Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261687AbUL3R7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbUL3R7m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 12:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbUL3R7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 12:59:42 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:48098 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261687AbUL3R7e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 12:59:34 -0500
X-AuthUser: davidel@xmailserver.org
Date: Thu, 30 Dec 2004 09:59:27 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Jesse Allen <the3dfxdude@gmail.com>, Mike Hearn <mh@codeweavers.com>,
       Thomas Sailer <sailer@scs.ch>, Eric Pouech <pouech-eric@wanadoo.fr>,
       Daniel Jacobowitz <dan@debian.org>, Roland McGrath <roland@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
In-Reply-To: <Pine.LNX.4.58.0412292256350.22893@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0412300953470.2193@bigblue.dev.mdolabs.com>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com> 
 <20041120214915.GA6100@tesore.ph.cox.net>  <41A251A6.2030205@wanadoo.fr> 
 <Pine.LNX.4.58.0411221300460.20993@ppc970.osdl.org>  <1101161953.13273.7.camel@littlegreen>
  <1104286459.7640.54.camel@gamecube.scs.ch>  <1104332559.3393.16.camel@littlegreen>
  <Pine.LNX.4.58.0412291047120.2353@ppc970.osdl.org> 
 <53046857041229114077eb4d1d@mail.gmail.com>  <Pine.LNX.4.58.0412291151080.2353@ppc970.osdl.org>
 <530468570412291343d1478cf@mail.gmail.com> <Pine.LNX.4.58.0412291622560.2353@ppc970.osdl.org>
 <Pine.LNX.4.58.0412291703400.30636@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0412291745470.2353@ppc970.osdl.org>
 <Pine.LNX.4.58.0412292050550.22893@ppc970.osdl.org>
 <Pine.LNX.4.58.0412292055540.22893@ppc970.osdl.org>
 <Pine.LNX.4.58.0412292106400.454@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0412292256350.22893@ppc970.osdl.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Dec 2004, Linus Torvalds wrote:

> On Wed, 29 Dec 2004, Davide Libenzi wrote:
> > 
> > I think same. My test simply let the function processing to let thru and 
> > reach the fake signal sending point.
> 
> No, your test-case doesn't even send a signal at all, because your
> test-program just uses a PTRACE_SINGLESTEP without any "send signal" - so
> "exit_code" will be zero after the debuggee gets released from the
> "ptrace_notify()", and the suspect code will never be executed..

No no, my test case has nothing to do with the extra signal sent in 
do_syscall_trace(). But the test I put at the time:

-       if (!test_thread_flag(TIF_SYSCALL_TRACE))
+       if (!test_thread_flag(TIF_SYSCALL_TRACE) &&
+           !test_thread_flag(TIF_SINGLESTEP))
                return;

will make the code to not execute the "return" (in the single step case) 
and to fall through the point where the signal is sent.



> The problem I think I see (and which the comment alludes to) is that if
> the controlling process continues the debuggee with a signal, we'll be
> doing the wrong thing: the code in do_syscall_trace() will take that
> signal (in "current->exit_code") and send it as a real signal to the
> debuggee, but since it is debugged, it will be caught (again) by the
> controlling process, which apparently in the case of Wine gets very
> confused.
> 
> So I _think_ the problem happens for the following schenario:
>  - wine for some reason does a PTRACE_SINGLESTEP over a system call
>  - after the single-step, wine ends up trying to get the sub-process to 
>    enter a signal handler with ptrace( PTRACE_CONT, ... sig)
>  - the normal ptrace path (where we trap a signal - see kernel/signal.c 
>    and the "ptrace_stop()" logic) handles this correctly, but 
>    do_syscall_trace() will do a "send_sig()"
>  - we'll try to handle the signal when returning to the traced process
>  - now "get_signal_to_deliver()" will invoce the ptrace logic AGAIN, and 
>    call ptrace_stop() for this fake signal, and we'll report a new event 
>    to the controlling process.
> 
> Does this make sense?

This might explain what they were seeing, but OTOH it seems that the real 
cause of their problems is related to something else (according to other 
emails on this thread).



- Davide

