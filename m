Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbUL3E2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbUL3E2z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 23:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261513AbUL3E2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 23:28:55 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:64316 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261442AbUL3E2u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 23:28:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=i/qwl7HHCQbi9xDHpQVuKHM+IJtg+b9MXkpoPBbkNa8zQhBbODtHcAyyc3x7f17Alj4xWliTo8XP6trM87lPdEmgHbfBMr0ARFMnbmiDf8+MBiqMcKD37GUA6hNAtojtWD5l3rkwiu2GMv6RqtILYSA/t3xiFZEr4Oe+oNYkJi4=
Message-ID: <5304685704122920285a9d9e99@mail.gmail.com>
Date: Wed, 29 Dec 2004 21:28:50 -0700
From: Jesse Allen <the3dfxdude@gmail.com>
Reply-To: Jesse Allen <the3dfxdude@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: ptrace single-stepping change breaks Wine
Cc: Mike Hearn <mh@codeweavers.com>, Thomas Sailer <sailer@scs.ch>,
       Eric Pouech <pouech-eric@wanadoo.fr>,
       Daniel Jacobowitz <dan@debian.org>, Roland McGrath <roland@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>,
       Davide Libenzi <davidel@xmailserver.org>
In-Reply-To: <Pine.LNX.4.58.0412291622560.2353@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com>
	 <Pine.LNX.4.58.0411221300460.20993@ppc970.osdl.org>
	 <1101161953.13273.7.camel@littlegreen>
	 <1104286459.7640.54.camel@gamecube.scs.ch>
	 <1104332559.3393.16.camel@littlegreen>
	 <Pine.LNX.4.58.0412291047120.2353@ppc970.osdl.org>
	 <53046857041229114077eb4d1d@mail.gmail.com>
	 <Pine.LNX.4.58.0412291151080.2353@ppc970.osdl.org>
	 <530468570412291343d1478cf@mail.gmail.com>
	 <Pine.LNX.4.58.0412291622560.2353@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Dec 2004 16:44:05 -0800 (PST), Linus Torvalds
<torvalds@osdl.org> wrote:
> 
> That still leaves the problem of the clearing of TF_MASK. I _appears_ that
> the problem is that TF was set both by Wine doing a PTRACE_SINGLESTEP
> (since PT_DTRACE is set) _and_ the application having TF enabled in eflags
> from before (since it seems to want to keep it enabled).
> 
> How about something like the attachment for the TF_MASK issue (replacing
> your "don't clear" code)? The comments should make the intention pretty
> obvious, but I have equally obviously not actually _tested_ any of this..
> 

The following patch works for me.  I still have to remove
TIF_SINGLESTEP test.  I also went ahead and tried adding the other fix
on the ptrace_notify call and _TIF_WORK_MASK, but for some reason,
changing _TIF_WORK_MASK seems to break the program now.  This patch
does fix the TF clearing problem.

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
@@ -568,15 +581,13 @@
 			audit_syscall_exit(current, regs->eax);
 	}
 
-	if (!test_thread_flag(TIF_SYSCALL_TRACE) &&
-	    !test_thread_flag(TIF_SINGLESTEP))
+	if (!test_thread_flag(TIF_SYSCALL_TRACE))
 		return;
 	if (!(current->ptrace & PT_PTRACED))
 		return;
 	/* the 0x80 provides a way for the tracing parent to distinguish
 	   between a syscall stop and SIGTRAP delivery */
-	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD) &&
-				 !test_thread_flag(TIF_SINGLESTEP) ? 0x80 : 0));
+	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD) ? 0x80 : 0));
 
 	/*
 	 * this isn't the same as continuing with a signal, but it will do
