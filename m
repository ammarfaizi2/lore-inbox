Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbTEQTX4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 15:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbTEQTX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 15:23:56 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:32690 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261786AbTEQTXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 15:23:51 -0400
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Scheduling problem with 2.4?
References: <x54r3tddhs.fsf@lola.goethe.zz>
	<20030517174100.GT1429@dualathlon.random>
Reply-To: dak@gnu.org
From: David.Kastrup@t-online.de (David Kastrup)
Date: 17 May 2003 21:36:29 +0200
In-Reply-To: <20030517174100.GT1429@dualathlon.random>
Message-ID: <x5r86x74ci.fsf@lola.goethe.zz>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Andrea Arcangeli <andrea@suse.de> writes:

> On Sat, May 17, 2003 at 01:22:23PM +0200, David Kastrup wrote:
> > 
> > I have a problem with Emacs which crawls when used as a shell.  If I
> > call M-x shell RET and then do something like
> > hexdump -v /dev/null|dd count=100k bs=1
> 
> this certainly can't be it
> 
> andrea@dualathlon:~> hexdump -v /dev/null|dd count=100k bs=1
> 0+0 records in
> 0+0 records out

Argl.  Substitute /dev/zero in the obvious place.  My stupidity.

Here is a test file for generating further stats from within Emacs.
You can call it interactively from within Emacs with
M-x load-library RET testio.el RET
M-x make-test RET

and you can use it from the command line (if you really must) with
emacs -batch -q -no-site-file -l testio.el -eval "(progn(make-test t
  'kill-emacs)(sit-for 100000))"


--=-=-=
Content-Type: application/emacs-lisp
Content-Disposition: attachment; filename=testio.el

(defvar test-pattern nil)
(defvar test-start nil)

(defun test-filter (process string printer)
  (push (cons (floor (- (float-time) test-start))
	      (length string)) test-pattern)
  (princ string printer))

(defun test-predicate (a b)
  (if (equal (car a) (car b))
      (< (cdr a) (cdr b))
    (< (car a) (car b))))

(defun make-test (printer &optional finish)
  (interactive (let ((buffer (get-buffer-create "*test*")))
		  (switch-to-buffer buffer)
		  (erase-buffer)
		  (list buffer)))
  (setq test-pattern nil test-start (float-time))
  (let ((process (start-process
		  "test" (and (bufferp printer) printer) "sh"
		  "-c" "od -v /dev/zero|dd bs=1 count=100k")))
    (set-process-filter process `(lambda (process string)
				   (test-filter process string
						',printer)))
    (set-process-sentinel process `(lambda (process string)
				     (test-sentinel process string
						    ',printer ',finish)))
    process))

(defun test-sentinel (process string printer finish)
  (princ string printer)
  (delete-process process)
  (setq test-pattern (sort test-pattern #'test-predicate))
  (let (elt lastelt lastcount)
    (while
	(prog1
	    (setq elt (pop test-pattern))
	  (if (equal lastelt elt)
	      (when lastelt (setq lastcount (1+ lastcount)))
	    (when lastelt
	      (princ (format "%4d blocks with size %4d\n"
			     lastcount (cdr lastelt)) printer))
	    (setq lastcount 1)))
      (when (not (eq (car lastelt) (car elt)))
	(princ (format "Time:%3d\n" (car elt)) printer))
      (setq lastelt elt)))
  (if finish (funcall finish)))


--=-=-=



It will then output the read stuff from the process followed by
statistics of block sizes over each second it ran.

The interactive session tends to be somewhat worse, but the command
line version is bad enough for a demonstration.

It is obvious that during most of the time, the pipe only receives
single characters.

Again, I am pretty sure that Emacs is at fault too, but I don't
understand the implications of what scheduling behavior causes the
pipes to remain mostly empty, with an occasional full filling.  It
would be better if Emacs would not be context-switched into the
moment something appears in the pipe, but if the writer to the pipe
would keep the opportunity to fill'er'up until it is either preempted
or needs to wait.  If there was some possibility to force this
behavior from within Emacs, this would be good to know.

Thanks,

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum

--=-=-=--
