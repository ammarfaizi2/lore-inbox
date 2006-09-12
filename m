Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965187AbWILL0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965187AbWILL0V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 07:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965161AbWILL0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 07:26:21 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:5753 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S965187AbWILL0T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 07:26:19 -0400
Date: Tue, 12 Sep 2006 13:26:17 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, geraldsc@de.ibm.com
Subject: [S390] Cleanup in signal handling code.
Message-ID: <20060912112617.GC2826@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gerald Schaefer <geraldsc@de.ibm.com>

[S390] Cleanup in signal handling code.

Signed-off-by: Gerald Schaefer <geraldsc@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/signal.c |   39 +++++++++++++++++----------------------
 1 files changed, 17 insertions(+), 22 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/signal.c linux-2.6-patched/arch/s390/kernel/signal.c
--- linux-2.6/arch/s390/kernel/signal.c	2006-09-12 10:57:35.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/signal.c	2006-09-12 10:57:57.000000000 +0200
@@ -114,29 +114,26 @@ sys_sigaltstack(const stack_t __user *us
 static int save_sigregs(struct pt_regs *regs, _sigregs __user *sregs)
 {
 	unsigned long old_mask = regs->psw.mask;
-	int err;
-  
+	_sigregs user_sregs;
+
 	save_access_regs(current->thread.acrs);
 
 	/* Copy a 'clean' PSW mask to the user to avoid leaking
 	   information about whether PER is currently on.  */
 	regs->psw.mask = PSW_MASK_MERGE(PSW_USER_BITS, regs->psw.mask);
-	err = __copy_to_user(&sregs->regs.psw, &regs->psw,
-			     sizeof(sregs->regs.psw)+sizeof(sregs->regs.gprs));
+	memcpy(&user_sregs.regs.psw, &regs->psw, sizeof(sregs->regs.psw) +
+	       sizeof(sregs->regs.gprs));
 	regs->psw.mask = old_mask;
-	if (err != 0)
-		return err;
-	err = __copy_to_user(&sregs->regs.acrs, current->thread.acrs,
-			     sizeof(sregs->regs.acrs));
-	if (err != 0)
-		return err;
+	memcpy(&user_sregs.regs.acrs, current->thread.acrs,
+	       sizeof(sregs->regs.acrs));
 	/* 
 	 * We have to store the fp registers to current->thread.fp_regs
 	 * to merge them with the emulated registers.
 	 */
 	save_fp_regs(&current->thread.fp_regs);
-	return __copy_to_user(&sregs->fpregs, &current->thread.fp_regs,
-			      sizeof(s390_fp_regs));
+	memcpy(&user_sregs.fpregs, &current->thread.fp_regs,
+	       sizeof(s390_fp_regs));
+	return __copy_to_user(sregs, &user_sregs, sizeof(_sigregs));
 }
 
 /* Returns positive number on error */
@@ -144,27 +141,25 @@ static int restore_sigregs(struct pt_reg
 {
 	unsigned long old_mask = regs->psw.mask;
 	int err;
+	_sigregs user_sregs;
 
 	/* Alwys make any pending restarted system call return -EINTR */
 	current_thread_info()->restart_block.fn = do_no_restart_syscall;
 
-	err = __copy_from_user(&regs->psw, &sregs->regs.psw,
-			       sizeof(sregs->regs.psw)+sizeof(sregs->regs.gprs));
+	err = __copy_from_user(&user_sregs, sregs, sizeof(_sigregs));
 	regs->psw.mask = PSW_MASK_MERGE(old_mask, regs->psw.mask);
 	regs->psw.addr |= PSW_ADDR_AMODE;
 	if (err)
 		return err;
-	err = __copy_from_user(&current->thread.acrs, &sregs->regs.acrs,
-			       sizeof(sregs->regs.acrs));
-	if (err)
-		return err;
+	memcpy(&regs->psw, &user_sregs.regs.psw, sizeof(sregs->regs.psw) +
+	       sizeof(sregs->regs.gprs));
+	memcpy(&current->thread.acrs, &user_sregs.regs.acrs,
+	       sizeof(sregs->regs.acrs));
 	restore_access_regs(current->thread.acrs);
 
-	err = __copy_from_user(&current->thread.fp_regs, &sregs->fpregs,
-			       sizeof(s390_fp_regs));
+	memcpy(&current->thread.fp_regs, &user_sregs.fpregs,
+	       sizeof(s390_fp_regs));
 	current->thread.fp_regs.fpc &= FPC_VALID_MASK;
-	if (err)
-		return err;
 
 	restore_fp_regs(&current->thread.fp_regs);
 	regs->trap = -1;	/* disable syscall checks */
