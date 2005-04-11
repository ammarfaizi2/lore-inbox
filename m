Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261957AbVDKWQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbVDKWQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 18:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbVDKWQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 18:16:29 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:31250 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261959AbVDKWPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 18:15:10 -0400
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix SIGBUS handling
X-Patch-Ref: 01-fixes/01-sigbus
Message-Id: <E1DL7BP-0003C3-8Z@raistlin.arm.linux.org.uk>
Date: Mon, 11 Apr 2005 23:15:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ARM wasn't raising a SIGBUS with a siginfo structure.  Fix
__do_user_fault() to allow us to use it for SIGBUS conditions,
and arrange for the sigbus path to use this.

We need to prevent the siginfo code being called if we do
not have a user space context to call it, so consolidate the
"user_mode()" tests.

Thanks to Ian Campbell who spotted this oversight.

Signed-off-by: Russell King <rmk@arm.linux.org.uk>

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej orig/arch/arm/mm/fault.c linux/arch/arm/mm/fault.c
--- orig/arch/arm/mm/fault.c	Fri Nov  5 19:28:15 2004
+++ linux/arch/arm/mm/fault.c	Fri Apr  8 14:24:50 2005
@@ -108,14 +108,15 @@ __do_kernel_fault(struct mm_struct *mm, 
  */
 static void
 __do_user_fault(struct task_struct *tsk, unsigned long addr,
-		unsigned int fsr, int code, struct pt_regs *regs)
+		unsigned int fsr, unsigned int sig, int code,
+		struct pt_regs *regs)
 {
 	struct siginfo si;
 
 #ifdef CONFIG_DEBUG_USER
 	if (user_debug & UDBG_SEGV) {
-		printk(KERN_DEBUG "%s: unhandled page fault at 0x%08lx, code 0x%03x\n",
-		       tsk->comm, addr, fsr);
+		printk(KERN_DEBUG "%s: unhandled page fault (%d) at 0x%08lx, code 0x%03x\n",
+		       tsk->comm, sig, addr, fsr);
 		show_pte(tsk->mm, addr);
 		show_regs(regs);
 	}
@@ -124,11 +125,11 @@ __do_user_fault(struct task_struct *tsk,
 	tsk->thread.address = addr;
 	tsk->thread.error_code = fsr;
 	tsk->thread.trap_no = 14;
-	si.si_signo = SIGSEGV;
+	si.si_signo = sig;
 	si.si_errno = 0;
 	si.si_code = code;
 	si.si_addr = (void __user *)addr;
-	force_sig_info(SIGSEGV, &si, tsk);
+	force_sig_info(sig, &si, tsk);
 }
 
 void
@@ -140,7 +141,7 @@ do_bad_area(struct task_struct *tsk, str
 	 * have no context to handle this fault with.
 	 */
 	if (user_mode(regs))
-		__do_user_fault(tsk, addr, fsr, SEGV_MAPERR, regs);
+		__do_user_fault(tsk, addr, fsr, SIGSEGV, SEGV_MAPERR, regs);
 	else
 		__do_kernel_fault(mm, addr, fsr, regs);
 }
@@ -201,10 +202,11 @@ survive:
 		goto out;
 
 	/*
-	 * If we are out of memory for pid1,
-	 * sleep for a while and retry
+	 * If we are out of memory for pid1, sleep for a while and retry
 	 */
+	up_read(&mm->mmap_sem);
 	yield();
+	down_read(&mm->mmap_sem);
 	goto survive;
 
 check_stack:
@@ -219,7 +221,7 @@ do_page_fault(unsigned long addr, unsign
 {
 	struct task_struct *tsk;
 	struct mm_struct *mm;
-	int fault;
+	int fault, sig, code;
 
 	tsk = current;
 	mm  = tsk->mm;
@@ -242,55 +244,45 @@ do_page_fault(unsigned long addr, unsign
 		return 0;
 
 	/*
-	 * We had some memory, but were unable to
-	 * successfully fix up this page fault.
-	 */
-	if (fault == 0)
-		goto do_sigbus;
-
-	/*
 	 * If we are in kernel mode at this point, we
 	 * have no context to handle this fault with.
 	 */
 	if (!user_mode(regs))
 		goto no_context;
 
-	if (fault == VM_FAULT_OOM) {
+	switch (fault) {
+	case VM_FAULT_OOM:
 		/*
-		 * We ran out of memory, or some other thing happened to
-		 * us that made us unable to handle the page fault gracefully.
+		 * We ran out of memory, or some other thing
+		 * happened to us that made us unable to handle
+		 * the page fault gracefully.
 		 */
 		printk("VM: killing process %s\n", tsk->comm);
 		do_exit(SIGKILL);
-	} else
-		__do_user_fault(tsk, addr, fsr, fault == VM_FAULT_BADACCESS ?
-				SEGV_ACCERR : SEGV_MAPERR, regs);
-	return 0;
+		return 0;
 
+	case 0:
+		/*
+		 * We had some memory, but were unable to
+		 * successfully fix up this page fault.
+		 */
+		sig = SIGBUS;
+		code = BUS_ADRERR;
+		break;
 
-/*
- * We ran out of memory, or some other thing happened to us that made
- * us unable to handle the page fault gracefully.
- */
-do_sigbus:
-	/*
-	 * Send a sigbus, regardless of whether we were in kernel
-	 * or user mode.
-	 */
-	tsk->thread.address = addr;
-	tsk->thread.error_code = fsr;
-	tsk->thread.trap_no = 14;
-	force_sig(SIGBUS, tsk);
-#ifdef CONFIG_DEBUG_USER
-	if (user_debug & UDBG_BUS) {
-		printk(KERN_DEBUG "%s: sigbus at 0x%08lx, pc=0x%08lx\n",
-			current->comm, addr, instruction_pointer(regs));
+	default:
+		/*
+		 * Something tried to access memory that
+		 * isn't in our memory map..
+		 */
+		sig = SIGSEGV;
+		code = fault == VM_FAULT_BADACCESS ?
+			SEGV_ACCERR : SEGV_MAPERR;
+		break;
 	}
-#endif
 
-	/* Kernel mode? Handle exceptions or die */
-	if (user_mode(regs))
-		return 0;
+	__do_user_fault(tsk, addr, fsr, sig, code, regs);
+	return 0;
 
 no_context:
 	__do_kernel_fault(mm, addr, fsr, regs);
