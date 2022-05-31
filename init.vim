"coc.nvim stored in this directory
"/home/subodh/.local/share/nvim/plugged/coc.nvim

syntax on
set relativenumber
set autoindent
set tabstop=4
set shiftwidth=4
set smarttab
set softtabstop=4
set mouse=a
set scrolloff=10
set nowrap
set incsearch
set ignorecase
set smartcase
set showcmd
set showmode
set showmatch
set history=1000

:highlight Cursorline cterm=bold ctermbg=black

"remove trailing whitespace from python file"
autocmd BufWritePre *.py :%s/\s+$//e

"inoremap ( ()<Left>
"inoremap { {}<Left>
"inoremap [ []<Left>
"inoremap " ""<Left>
"inoremap ' ''<Left>



call plug#begin()
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'http://github.com/tpope/vim-surround' 
Plug 'OmniSharp/omnisharp-vim'
Plug 'flazz/vim-colorschemes'
"Plug 'ervandew/supertab'
Plug 'prettier/vim-prettier', { 'do': 'npm install' , 'branch' : 'release/1.x' }
Plug 'dense-analysis/ale'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'valloric/MatchTagAlways'
Plug 'jiangmiao/auto-pairs'
Plug 'https://github.com/preservim/nerdtree' 
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/ap/vim-css-color' " CSS Color Preview
Plug 'https://github.com/rafi/awesome-vim-colorschemes' " Retro Scheme
Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
Plug 'https://github.com/tc50cal/vim-terminal' " Vim Terminal
Plug 'https://github.com/preservim/tagbar' " Tagbar for code navigation
Plug 'https://github.com/terryma/vim-multiple-cursors' " CTRL + N for multiple cursors
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'vimwiki/vimwiki'
call plug#end()

"colorscheme jellybeans
colorscheme minimalist
let g:airline_theme='minimalist'

set encoding=utf-8
scriptencoding utf-8
let g:airline#extensions#tmuxline#enabled = 0

" How tab behaves while picking auto complete.
let g:SuperTabMappingForward = '<S-Tab>'
let g:SuperTabMappingBackward = '<Tab>'
let g:fzf_preview_window = 'right:60%'

if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
"   let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
" ctrl+p when you move to a file this highlights it.
let g:nerdtree_sync_cursorline = 1

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


" Read gitignore and dont show relevant files in ctrlp.
" let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:prettier#config#parser = 'babylon'
" hi Normal ctermbg=none
"
" For Coc Action Menu to work.
" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

let g:ale_linters_ignore = {
      \   'typescript': ['tslint'],
      \}

let g:ale_linters = {
\ 'cs': ['OmniSharp']
\}

nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
"nnoremap <C-l> :call CocActionAsync('jumpDefinition')<CR>

nmap <F8> :TagbarToggle<CR>

:set completeopt-=preview " For No Previews
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"
let g:airline_powerline_fonts = 1
let g:tmuxline_powerline_separators = 0

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

"inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"

:map <C-n> :NERDTreeToggle<CR>
:map <C-p> :GFiles<CR>
:map <C-f> :Files<CR>
"collapse json files by themselves.
:map <C-j> :set filetype=json \| :syntax on \| :set foldmethod=syntax
"zo for open
"zc for close
" Auto indent your file.
map <F7> gg=G<C-o><C-o>
" Navigate Tabs
map <C-t><up> :tabr<cr>
map <C-t><down> :tabl<cr>
map <C-t><left> :tabp<cr>
map <C-t><right> :tabn<cr>

" Supprot for different goto definitions for different file types.
autocmd FileType cs nmap <silent> gd :OmniSharpGotoDefinition<CR>
autocmd FileType cs nnoremap <buffer> <Leader>fu :OmniSharpFindUsages<CR>
autocmd FileType cs nnoremap <buffer> <Leader>fi :OmniSharpFindImplementations<CR>
autocmd FileType cs nnoremap <Leader><Space> :OmniSharpGetCodeActions<CR>

autocmd FileType ts nmap <silent> gd :call CocActionAsync('jumpDefinition')<CR>
autocmd FileType html nmap <silent> gd :call CocActionAsync('jumpDefinition')<CR>

