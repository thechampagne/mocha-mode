;;; mocha-mode.el --- A major mode for the Mocha configuration language -*- lexical-binding: t -*-

;; Version: 0.0.1
;; Author: XXIV
;; Keywords: files, mocha
;; Package-Requires: ((emacs "24.3"))
;; Homepage: https://github.com/thechampagne/mocha-mode

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; A major mode for the Mocha configuration language.

;;;; Installation

;; You can use built-in package manager (package.el) or do everything by your hands.

;;;;; Using package manager

;; Add the following to your Emacs config file

;; (require 'package)
;; (add-to-list 'package-archives
;;              '("melpa" . "https://melpa.org/packages/") t)
;; (package-initialize)

;; Then use `M-x package-install RET mocha-mode RET` to install the mode.
;; Use `M-x mocha-mode` to change your current mode.

;;;;; Manual

;; Download the mode to your local directory.  You can do it through `git clone` command:

;; git clone git://github.com/thechampagne/mocha-mode.git

;; Then add path to mocha-mode to load-path list — add the following to your Emacs config file

;; (add-to-list 'load-path
;; 	     "/path/to/mocha-mode/")
;; (require 'mocha-mode)

;; Use `M-x mocha-mode` to change your current mode.

;;; Code:

(defconst mocha-mode-syntax-table
  (let ((table (make-syntax-table)))
    (modify-syntax-entry ?\' "\"" table)
    table))


(defconst mocha-constants
  '("true" "false" "nil"))


(defconst mocha-font-lock-keywords
  (list
   `("\\(#.*\\)" . font-lock-comment-face)
   `(,(regexp-opt mocha-constants 'words) . font-lock-constant-face)
   `("@\\<\\([a-zA-Z0-9_:]*\\)\\>" . font-lock-preprocessor-face)
   `("\\<\\([a-zA-Z0-9_]*\\)\\>[[:space:]]*:[[:space:]]*{" . (1 font-lock-type-face))
   `("\\<\\([a-zA-Z0-9_]*\\)\\>[[:space:]]*:[[:space:]]*\\[" . (1 font-lock-type-face))
   `("\\<\\([a-zA-Z0-9_]*\\)\\>[[:space:]]*:" . (1 font-lock-variable-name-face))))

;;;###autoload
(define-derived-mode mocha-mode prog-mode "Mocha"
  "A major mode for the Mocha configuration language."
  :syntax-table mocha-mode-syntax-table
  (setq-local font-lock-defaults '(mocha-font-lock-keywords))
  (setq-local comment-start "# ")
  (setq-local comment-end ""))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.mocha\\'" . mocha-mode))

(provide 'mocha-mode)

;;; mocha-mode.el ends here
