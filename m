Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030736AbWJDR5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030736AbWJDR5z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 13:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030726AbWJDR5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 13:57:50 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:11234 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030731AbWJDR5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 13:57:44 -0400
Date: Wed, 4 Oct 2006 19:57:46 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [S390] user-copy optimization fallout.
Message-ID: <20061004175746.GB26756@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[S390] user-copy optimization fallout.

Fix new restore_sigregs function. It copies the user space copy of the
old psw without correcting the psw.mask and the psw.addr high order bit.
While we are at it, simplify save_sigregs a bit.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/signal.c |   17 +++++++----------
 1 files changed, 7 insertions(+), 10 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/signal.c linux-2.6-patched/arch/s390/kernel/signal.c
--- linux-2.6/arch/s390/kernel/signal.c	2006-10-04 19:53:26.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/signal.c	2006-10-04 19:53:45.000000000 +0200
@@ -113,17 +113,15 @@ sys_sigaltstack(const stack_t __user *us
 /* Returns non-zero on fault. */
 static int save_sigregs(struct pt_regs *regs, _sigregs __user *sregs)
 {
-	unsigned long old_mask = regs->psw.mask;
 	_sigregs user_sregs;
 
 	save_access_regs(current->thread.acrs);
 
 	/* Copy a 'clean' PSW mask to the user to avoid leaking
 	   information about whether PER is currently on.  */
-	regs->psw.mask = PSW_MASK_MERGE(PSW_USER_BITS, regs->psw.mask);
-	memcpy(&user_sregs.regs.psw, &regs->psw, sizeof(sregs->regs.psw) +
-	       sizeof(sregs->regs.gprs));
-	regs->psw.mask = old_mask;
+	user_sregs.regs.psw.mask = PSW_MASK_MERGE(PSW_USER_BITS, regs->psw.mask);
+	user_sregs.regs.psw.addr = regs->psw.addr;
+	memcpy(&user_sregs.regs.gprs, &regs->gprs, sizeof(sregs->regs.gprs));
 	memcpy(&user_sregs.regs.acrs, current->thread.acrs,
 	       sizeof(sregs->regs.acrs));
 	/* 
@@ -139,7 +137,6 @@ static int save_sigregs(struct pt_regs *
 /* Returns positive number on error */
 static int restore_sigregs(struct pt_regs *regs, _sigregs __user *sregs)
 {
-	unsigned long old_mask = regs->psw.mask;
 	int err;
 	_sigregs user_sregs;
 
@@ -147,12 +144,12 @@ static int restore_sigregs(struct pt_reg
 	current_thread_info()->restart_block.fn = do_no_restart_syscall;
 
 	err = __copy_from_user(&user_sregs, sregs, sizeof(_sigregs));
-	regs->psw.mask = PSW_MASK_MERGE(old_mask, regs->psw.mask);
-	regs->psw.addr |= PSW_ADDR_AMODE;
 	if (err)
 		return err;
-	memcpy(&regs->psw, &user_sregs.regs.psw, sizeof(sregs->regs.psw) +
-	       sizeof(sregs->regs.gprs));
+	regs->psw.mask = PSW_MASK_MERGE(regs->psw.mask,
+					user_sregs.regs.psw.mask);
+	regs->psw.addr = PSW_ADDR_AMODE | user_sregs.regs.psw.addr;
+	memcpy(&regs->gprs, &user_sregs.regs.gprs, sizeof(sregs->regs.gprs));
 	memcpy(&current->thread.acrs, &user_sregs.regs.acrs,
 	       sizeof(sregs->regs.acrs));
 	restore_access_regs(current->thread.acrs);
