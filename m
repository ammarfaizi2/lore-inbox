Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261701AbUL3T1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbUL3T1O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 14:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbUL3T1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 14:27:13 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:8277 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261701AbUL3T1B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 14:27:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ZpOcKPmZ4ewkobVK1QE+lK7WGfBt5YRmEGiuHlbjRJN7PnR2690WTlqkrHByzfQffy2IoNlt3su49jv+hTKR7v/n8KGntT0abT7rq2SdIs4BfV2OX+3ZyBw8QAPADk+KmjbJSpTZ+HfGJCJudheOMKZWn/xxNn9j8913QGtBuPk=
Message-ID: <53046857041230112742acccbe@mail.gmail.com>
Date: Thu, 30 Dec 2004 12:27:00 -0700
From: Jesse Allen <the3dfxdude@gmail.com>
Reply-To: Jesse Allen <the3dfxdude@gmail.com>
To: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: ptrace single-stepping change breaks Wine
Cc: Linus Torvalds <torvalds@osdl.org>, Mike Hearn <mh@codeweavers.com>,
       Thomas Sailer <sailer@scs.ch>, Eric Pouech <pouech-eric@wanadoo.fr>,
       Daniel Jacobowitz <dan@debian.org>, Roland McGrath <roland@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
In-Reply-To: <Pine.LNX.4.58.0412300953470.2193@bigblue.dev.mdolabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com>
	 <530468570412291343d1478cf@mail.gmail.com>
	 <Pine.LNX.4.58.0412291622560.2353@ppc970.osdl.org>
	 <Pine.LNX.4.58.0412291703400.30636@bigblue.dev.mdolabs.com>
	 <Pine.LNX.4.58.0412291745470.2353@ppc970.osdl.org>
	 <Pine.LNX.4.58.0412292050550.22893@ppc970.osdl.org>
	 <Pine.LNX.4.58.0412292055540.22893@ppc970.osdl.org>
	 <Pine.LNX.4.58.0412292106400.454@bigblue.dev.mdolabs.com>
	 <Pine.LNX.4.58.0412292256350.22893@ppc970.osdl.org>
	 <Pine.LNX.4.58.0412300953470.2193@bigblue.dev.mdolabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Dec 2004 09:59:27 -0800 (PST), Davide Libenzi
<davidel@xmailserver.org> wrote:
> On Wed, 29 Dec 2004, Linus Torvalds wrote:
> 
> > On Wed, 29 Dec 2004, Davide Libenzi wrote:
> > >
> > > I think same. My test simply let the function processing to let thru and
> > > reach the fake signal sending point.
> >
> > No, your test-case doesn't even send a signal at all, because your
> > test-program just uses a PTRACE_SINGLESTEP without any "send signal" - so
> > "exit_code" will be zero after the debuggee gets released from the
> > "ptrace_notify()", and the suspect code will never be executed..
> 
> No no, my test case has nothing to do with the extra signal sent in
> do_syscall_trace(). But the test I put at the time:
> 
> -       if (!test_thread_flag(TIF_SYSCALL_TRACE))
> +       if (!test_thread_flag(TIF_SYSCALL_TRACE) &&
> +           !test_thread_flag(TIF_SINGLESTEP))
>                 return;
> 
> will make the code to not execute the "return" (in the single step case)
> and to fall through the point where the signal is sent.


Using the latest version of the patch on do_syscall_trace(), it still
doesn't work unless I remove this test.  If indeed it's supposed to
fall through to receive the proper signal, (ie to single step properly
after an int op), then removing it is wrong, and I won't consider it
anymore.  I also have to use the patch shown below, with a typo-fixed,
to fix the other problem.  I broke it apart from the other because we
might want to consider it seperately right now.

I spent some time speaking to my brother about this.  He has done his
own kernel before for an embedded system.  He was rather frustrated
with me trying to find a reason for why a rather simple change broke
my program.  He told me I couldn't have it both ways.  However I
believe that I don't understand the linux code well enough to make
that conclusion.


> 
> 
> > The problem I think I see (and which the comment alludes to) is that if
> > the controlling process continues the debuggee with a signal, we'll be
> > doing the wrong thing: the code in do_syscall_trace() will take that
> > signal (in "current->exit_code") and send it as a real signal to the
> > debuggee, but since it is debugged, it will be caught (again) by the
> > controlling process, which apparently in the case of Wine gets very
> > confused.
> >
> > So I _think_ the problem happens for the following schenario:
> >  - wine for some reason does a PTRACE_SINGLESTEP over a system call
> >  - after the single-step, wine ends up trying to get the sub-process to
> >    enter a signal handler with ptrace( PTRACE_CONT, ... sig)
> >  - the normal ptrace path (where we trap a signal - see kernel/signal.c
> >    and the "ptrace_stop()" logic) handles this correctly, but
> >    do_syscall_trace() will do a "send_sig()"
> >  - we'll try to handle the signal when returning to the traced process
> >  - now "get_signal_to_deliver()" will invoce the ptrace logic AGAIN, and
> >    call ptrace_stop() for this fake signal, and we'll report a new event
> >    to the controlling process.
> >
> > Does this make sense?
> 
> This might explain what they were seeing, but OTOH it seems that the real
> cause of their problems is related to something else (according to other
> emails on this thread).
> 
> 

Actually, I don't think the vanilla kernel has the code that breaks
those other wine programs.  I just learned of this yesterday and it's
not related.  I believe it's only in fedora core 3 or -ac kernels and 
I use vanilla kernels.


Jesse

--- linux/arch/i386/kernel/ptrace.c	2004-12-29 14:10:34.000000000 -0700
+++ linux-mod/arch/i386/kernel/ptrace.c	2004-12-29 20:50:00.000000000 -0700
@@ -142,18 +142,31 @@
 {
 	long eflags;
 
+	/*
+	 * Always set TIF_SINGLESTEP - this guarantees that 
+	 * we single-step system calls etc.. 
+	 */
 	set_tsk_thread_flag(child, TIF_SINGLESTEP);
+
+	/*
+	 * If TF was already set, don't do anything else
+	 */
 	eflags = get_stack_long(child, EFL_OFFSET);
+	if (eflags & TRAP_FLAG)
+		return;
 	put_stack_long(child, EFL_OFFSET, eflags | TRAP_FLAG);
 	child->ptrace |= PT_DTRACE;
 }
 
 static void clear_singlestep(struct task_struct *child)
 {
+	/* Always clear TIF_SINGLESTEP... */
+	clear_tsk_thread_flag(child, TIF_SINGLESTEP);
+
+	/* But touch TF only if it was set by us.. */
 	if (child->ptrace & PT_DTRACE) {
 		long eflags;
 
-		clear_tsk_thread_flag(child, TIF_SINGLESTEP);
 		eflags = get_stack_long(child, EFL_OFFSET);
 		put_stack_long(child, EFL_OFFSET, eflags & ~TRAP_FLAG);
 		child->ptrace &= ~PT_DTRACE;
