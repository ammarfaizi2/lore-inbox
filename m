Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267673AbTBRGGz>; Tue, 18 Feb 2003 01:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267677AbTBRGFT>; Tue, 18 Feb 2003 01:05:19 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:64680 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S267673AbTBRGFN>; Tue, 18 Feb 2003 01:05:13 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH]  Set child process initial stack-pointers correctly on the v850
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030218061508.C0FEF37C6@mcspd15.ucom.lsi.nec.co.jp>
Date: Tue, 18 Feb 2003 15:15:08 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously the v850's copy_thread function didn't set the child's stack
pointer at all, with the result that it accidentally worked for vfork
(where the child has the same SP as the parent), but not for user
threads; kernel threads also accidentally worked, for a different
reason.

diff -ruN -X../cludes linux-2.5.62-uc0.orig/arch/v850/kernel/process.c linux-2.5.62-uc0/arch/v850/kernel/process.c
--- linux-2.5.62-uc0.orig/arch/v850/kernel/process.c	2002-11-28 10:24:54.000000000 +0900
+++ linux-2.5.62-uc0/arch/v850/kernel/process.c	2003-02-18 11:41:09.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * arch/v850/kernel/process.c -- Arch-dependent process handling
  *
- *  Copyright (C) 2001,02  NEC Corporation
- *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03  NEC Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -75,7 +75,9 @@
 
 	set_fs (KERNEL_DS);
 
-	/* Clone this thread.  */
+	/* Clone this thread.  Note that we don't pass the clone syscall's
+	   second argument -- it's ignored for calls from kernel mode (the
+	   child's SP is always set to the top of the kernel stack).  */
 	arg0 = flags | CLONE_VM;
 	syscall = __NR_clone;
 	asm volatile ("trap " SYSCALL_SHORT_TRAP
@@ -109,7 +111,8 @@
 		 struct task_struct *p, struct pt_regs *regs)
 {
 	/* Start pushing stuff from the top of the child's kernel stack.  */
-	unsigned long ksp = (unsigned long)p->thread_info + THREAD_SIZE;
+	unsigned long orig_ksp = (unsigned long)p->thread_info + THREAD_SIZE;
+	unsigned long ksp = orig_ksp;
 	/* We push two `state save' stack fames (see entry.S) on the new
 	   kernel stack:
 	     1) The innermost one is what switch_thread would have
@@ -138,6 +141,19 @@
 	   jump when the child thread begins running.  */
 	child_switch_regs->gpr[GPR_LP] = (v850_reg_t)ret_from_fork;
 
+	if (regs->kernel_mode)
+		/* Since we're returning to kernel-mode, make sure the child's
+		   stored kernel stack pointer agrees with what the actual
+		   stack pointer will be at that point (the trap return code
+		   always restores the SP, even when returning to
+		   kernel-mode).  */
+		child_trap_regs->gpr[GPR_SP] = orig_ksp;
+	else
+		/* Set the child's user-mode stack-pointer (the name
+		   `stack_start' is a misnomer, it's just the initial SP
+		   value).  */
+		child_trap_regs->gpr[GPR_SP] = stack_start;
+
 	/* Thread state for the child (everything else is on the stack).  */
 	p->thread.ksp = ksp;
 
