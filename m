Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268513AbTBWQUW>; Sun, 23 Feb 2003 11:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268514AbTBWQUW>; Sun, 23 Feb 2003 11:20:22 -0500
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:32247 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP
	id <S268513AbTBWQUV>; Sun, 23 Feb 2003 11:20:21 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: Tom Sanders <developer_linux@yahoo.com>, redhat-list@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: Question about Linux signal handling
Date: Sun, 23 Feb 2003 10:30:07 -0600
X-Mailer: KMail [version 1.2]
References: <20030223044520.87268.qmail@web9804.mail.yahoo.com>
In-Reply-To: <20030223044520.87268.qmail@web9804.mail.yahoo.com>
MIME-Version: 1.0
Message-Id: <03022310300700.31584@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 22 February 2003 22:45, Tom Sanders wrote:
> If I catch a signal (SIGUSR2) using "sigaction" call
> then is the signal handler replaced with default
> handling, if I don't install the signal handler again?
>
> I remember that in UNIX "signal" system call default
> signal bahavior was to replace the signal handler with
> default after everytime signal was received?
>
> My observation is that even if I get same signal
> twice, I get the same print (which I have in my signal
> handler) again, illustrating that signal handler was
> not replaced with default !!! Is that the correct
> behavior of "sigaction"?

Depends on the value of sa_flags parameter:

>From the manpage SIGACTION(2):

       sa_flags  specifies  a  set  of  flags  which  modify  the
       behaviour  of the signal handling process. It is formed by
       the bitwise OR of zero or more of the following:
 
              SA_NOCLDSTOP
                     If signum is SIGCHLD, do not receive notifi-
                     cation when child processes stop (i.e., when
                     child  processes  receive  one  of  SIGSTOP,
                     SIGTSTP, SIGTTIN or SIGTTOU).
 
              SA_ONESHOT or SA_RESETHAND
                     Restore  the  signal  action  to the default
                     state  once  the  signal  handler  has  been
                     called.   (This  is  the default behavior of
                     the signal(2) system call.)
 
              SA_RESTART
                     Provide behaviour compatible with BSD signal
                     semantics  by  making  certain  system calls
                     restartable across signals.
 
              SA_NOMASK or SA_NODEFER
                     Do  not  prevent  the  signal   from   being
                     received from within its own signal handler.
 
              SA_SIGINFO
                     The signal handler takes  3  arguments,  not
                     one.   In  this case, sa_sigaction should be
                     set instead of sa_handler.   (The  sa_sigac-
                     tion field was added in Linux 2.1.86.)

You are describing SA_ONESHOT as what you think you should
get..

I believe you are getting the correct result. With the ONESHOT option
you can/will loose signals, since the handler would be set back to the
default, and any subsequent signal lost. This loss of signals is one of the
original complaints about UNIX signal handling.

Now my manpage continues with the warning:

       The  POSIX  spec  only defines SA_NOCLDSTOP.  Use of other
       sa_flags is non-portable.

and:

CONFORMING TO
       POSIX,  SVr4.  SVr4 does not document the EINTR condition.
