Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759261AbWLDTW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759261AbWLDTW6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 14:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759310AbWLDTW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 14:22:58 -0500
Received: from [198.99.130.12] ([198.99.130.12]:46938 "EHLO
	saraswathi.solana.com" rhost-flags-FAIL-??-OK-OK) by vger.kernel.org
	with ESMTP id S1759125AbWLDTW4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 14:22:56 -0500
Message-Id: <200612041918.kB4JIdRf023003@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: [PATCH] x86_64/i386 - Kernel-mode faults pollute current->thead
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 04 Dec 2006 14:18:39 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel-mode traps on x86_64 can pollute the trap information for a previous
userspace trap for which the signal has not yet been delivered to the process.

do_trap and do_general_protection set task->thread.error_code and .trapno
for kernel traps.  If a kernel-mode trap arrives between the arrival of a
userspace trap and the delivery of the associated SISGEGV to the process,
the process will get the kernel trap information in its sigcontext.

This causes UML process segfaults, as the trapno that the UML kernel sees is
13, rather than the 14 for normal page faults.  So, the UML kernel passes the
SIGSEGV along to its process.

I don't claim to fully understand the problem.  On the one hand, a check in
do_general_protection for a pending SIGSEGV turned up nothing.  On the other
hand, this patch fixed the UML process segfault problem.

The patch below moves the setting of error_code and trapno so that that only
happens in the case of userspace faults.  As a side-effect, this should speed
up kernel-mode fault handling a tiny bit.

I looked at i386, and there is a similar situation.  In this case, there is
duplicate code setting task->thread.error_code and trapno.  I deleted one,
leaving the copy that runs in the case of a userspace fault.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17.i686/arch/i386/kernel/traps.c
===================================================================
--- linux-2.6.17.i686.orig/arch/i386/kernel/traps.c	2006-11-08 15:03:17.000000000 -0500
+++ linux-2.6.17.i686/arch/i386/kernel/traps.c	2006-12-04 12:38:49.000000000 -0500
@@ -444,8 +444,6 @@ static void __kprobes do_trap(int trapnr
 			      siginfo_t *info)
 {
 	struct task_struct *tsk = current;
-	tsk->thread.error_code = error_code;
-	tsk->thread.trap_no = trapnr;
 
 	if (regs->eflags & VM_MASK) {
 		if (vm86)
@@ -457,6 +455,9 @@ static void __kprobes do_trap(int trapnr
 		goto kernel_trap;
 
 	trap_signal: {
+		tsk->thread.error_code = error_code;
+		tsk->thread.trap_no = trapnr;
+
 		if (info)
 			force_sig_info(signr, info, tsk);
 		else
@@ -646,9 +647,6 @@ fastcall void __kprobes do_general_prote
 		return;
 	}
 
-	current->thread.error_code = error_code;
-	current->thread.trap_no = 13;
-
 	if (regs->eflags & VM_MASK)
 		goto gp_in_vm86;
 
Index: linux-2.6.17.i686/arch/x86_64/kernel/traps.c
===================================================================
--- linux-2.6.17.i686.orig/arch/x86_64/kernel/traps.c	2006-11-08 15:03:17.000000000 -0500
+++ linux-2.6.17.i686/arch/x86_64/kernel/traps.c	2006-12-04 12:38:49.000000000 -0500
@@ -490,10 +490,10 @@ static void __kprobes do_trap(int trapnr
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
@@ -591,10 +591,10 @@ asmlinkage void __kprobes do_general_pro
 
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

