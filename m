Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161483AbWLAVHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161483AbWLAVHe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 16:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161441AbWLAVHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 16:07:34 -0500
Received: from [198.99.130.12] ([198.99.130.12]:5002 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1161415AbWLAVHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 16:07:33 -0500
Date: Fri, 1 Dec 2006 16:03:35 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: x86_64 Kernel faults pollute task structs
Message-ID: <20061201210335.GA6751@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In arch/x86_64/kernel/traps.c:do_general_protection(), we have

	tsk->thread.error_code = error_code;
	tsk->thread.trap_no = 13;

	if (user_mode(regs)) {
		...
		force_sig(SIGSEGV, tsk);
		return;
	} 

	/* kernel gp */
	{
		...
	}

When a kernel GP fault comes in, and the process has a pending SEGV,
thread.error_code and trap_no will get corrupted, and those values
will be passed to the process if it's handling SIGSEGV.

UML on x86_64 sees process segfaults when the host is loaded.  The
trap_no in the sigcontext is 13, not 14, but cr2 and the faulting
instruction are consistent with a normal, trap_no == 14, page fault.
However, trap_no == 13 makes the UML kernel think that it's not a
normal page fault, and passes the segfault along to the process.

This patch - the do_general_protection part of it, anyway - makes the
UML process segfaults disappear.

--- arch/x86_64/kernel/traps.c~	2006-12-01 15:02:55.000000000 -0500
+++ arch/x86_64/kernel/traps.c	2006-12-01 15:02:29.000000000 -0500
@@ -637,10 +637,10 @@
 {
 	struct task_struct *tsk = current;
 
-	tsk->thread.error_code = error_code;
-	tsk->thread.trap_no = trapnr;
-
 	if (user_mode(regs)) {
+		tsk->thread.error_code = error_code;
+		tsk->thread.trap_no = trapnr;
+
 		if (exception_trace && unhandled_signal(tsk, signr))
 			printk(KERN_INFO
 			       "%s[%d] trap %s rip:%lx rsp:%lx error:%lx\n",
@@ -738,10 +738,10 @@
 
 	conditional_sti(regs);
 
-	tsk->thread.error_code = error_code;
-	tsk->thread.trap_no = 13;
-
 	if (user_mode(regs)) {
+		tsk->thread.error_code = error_code;
+		tsk->thread.trap_no = 13;
+
 		if (exception_trace && unhandled_signal(tsk, SIGSEGV))
 			printk(KERN_INFO
 		       "%s[%d] general protection rip:%lx rsp:%lx error:%lx\n",

The simplistic model I had where a process takes a userspace segfault,
and while it's in the kernel dealing with it, it takes a kernel GP
fault, polluting trap_no and error_code, appears to be wrong.

I put a some code which counted the number of times that
	sigismember(&tsk->pending.signal, SIGSEGV)
is true when do_general_protection() is called, and that turned out to
be zero.

However, the fact that my processes stop segfaulting with the above
patch suggests that there is something to this.  At the very least,
this patch seems harmless and speeds up kernel fault handling a tiny
bit.

Looking at i386, there is something similar.  I'd suggest this for
do_traps():

--- linux-2.6.orig/arch/i386/kernel/traps.c
+++ linux-2.6/arch/i386/kernel/traps.c
@@ -543,8 +543,6 @@ static void __kprobes do_trap(int trapnr
 			      siginfo_t *info)
 {
 	struct task_struct *tsk = current;
-	tsk->thread.error_code = error_code;
-	tsk->thread.trap_no = trapnr;
 
 	if (regs->eflags & VM_MASK) {
 		if (vm86)
@@ -556,6 +554,9 @@ static void __kprobes do_trap(int trapnr
 		goto kernel_trap;
 
 	trap_signal: {
+		tsk->thread.error_code = error_code;
+		tsk->thread.trap_no = trapnr;
+
 		if (info)
 			force_sig_info(signr, info, tsk);
 		else

Interestingly, it looks like someone half-did this job in
do_general_protection(), where trap_no and error_code are assigned
twice:

--- linux-2.6.orig/arch/i386/kernel/traps.c
+++ linux-2.6/arch/i386/kernel/traps.c
@@ -670,9 +671,6 @@ fastcall void __kprobes do_general_prote
 	}
 	put_cpu();
 
-	current->thread.error_code = error_code;
-	current->thread.trap_no = 13;
-
 	if (regs->eflags & VM_MASK)
 		goto gp_in_vm86;
 
It looks like this behavior is not universal.  I took a quick look at
powerpc, and it appears not to be doing this.  However, this might be
something for arch maintainers to take a look at.

If there are no objections, I'll roll the changes above into a proper,
signed-off patch, and send it in.

				Jeff

-- 
Work email - jdike at linux dot intel dot com
