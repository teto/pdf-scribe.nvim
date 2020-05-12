if exists('g:pdfdscribe_loaded')
  finish
endif

if !exists('g:pdfscribe_pdf_dir')
  let g:pdfscribe_pdf_dir = '~/Downloads'
endif

if !exists('g:pdfscribe_notes_dir')
  let g:pdfscribe_notes_dir = '~/notes'
endif

if !exists('g:pdfscribe_notes_extension')
  let g:pdfscribe_notes_extension = 'md'
endif

if !exists('g:pdfscribe_notes_marker')
  let g:pdfscribe_notes_marker = '## Notes'
endif

if !exists('g:pdfscribe_date_format')
  let g:pdfscribe_date_format = '%y/%d/%m'
endif

if !exists('g:pdfscribe_note_template') && !exists('*' . g:pdfscribe_note_formatter)
  let g:pdfscribe_note_template =<< trim END
    - (*${modified}*, page ${page}):${-selected_text: ${contents}-}
    ${+selected_text:  > ${selected_text}+}
    ${+selected_text:  ${contents}+}
    END
endif

if !exists('g:pdfscribe_file_template') && !exists('*' . g:pdfscribe_file_formatter)
  let g:pdfscribe_file_template =<< trim END
  # ${title}${+author: (${author})+}
  ${date}
  ${+keywords:${keywords}+}
  ${file}

  ## Main Idea

  ${notes_marker}
  ${notes}
  ${notes_end_marker}
  ${+links:${links}+}
  END
endif

command! -nargs=? -complete=customlist,pdfscribe#complete_pdf_files PdfScribeInit call pdscribe#init_notes(<q-args>)
command! -nargs=? -complete=customlist,pdfscribe#complete_notes_files PdfScribeUpdateNotes call pdfscribe#update_notes(<q-args>)

let g:pdfscribe_loaded = v:true