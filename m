Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbVKURte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbVKURte (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 12:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbVKURte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 12:49:34 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:31417 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S932431AbVKURtZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 12:49:25 -0500
Date: Mon, 21 Nov 2005 18:48:44 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, clg@fr.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 4/5] s390: rt_sigreturn fix.
Message-ID: <20051121174844.GD9638@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cedric Le Goater <clg@fr.ibm.com>

[patch 4/5] s390: rt_sigreturn fix.

Check return code of do_sigaltstack and force a SIGSEGV
if it is -EFAULT.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>

---

 arch/s390/kernel/compat_signal.c |    2 --
 arch/s390/kernel/signal.c        |    6 +++---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/compat_signal.c linux-2.6-patched/arch/s390/kernel/compat_signal.c
--- linux-2.6/arch/s390/kernel/compat_signal.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/compat_signal.c	2005-11-21 18:40:07.000000000 +0100
@@ -467,8 +467,6 @@ asmlinkage long sys32_rt_sigreturn(struc
 	if (err)
 		goto badframe; 
 
-	/* It is more difficult to avoid calling this function than to
-	   call it and ignore errors.  */
 	set_fs (KERNEL_DS);
 	do_sigaltstack((stack_t __user *)&st, NULL, regs->gprs[15]);
 	set_fs (old_fs);
diff -urpN linux-2.6/arch/s390/kernel/signal.c linux-2.6-patched/arch/s390/kernel/signal.c
--- linux-2.6/arch/s390/kernel/signal.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/signal.c	2005-11-21 18:40:07.000000000 +0100
@@ -254,9 +254,9 @@ asmlinkage long sys_rt_sigreturn(struct 
 	if (restore_sigregs(regs, &frame->uc.uc_mcontext))
 		goto badframe;
 
-	/* It is more difficult to avoid calling this function than to
-	   call it and ignore errors.  */
-	do_sigaltstack(&frame->uc.uc_stack, NULL, regs->gprs[15]);
+	if (do_sigaltstack(&frame->uc.uc_stack, NULL,
+			   regs->gprs[15]) == -EFAULT)
+		goto badframe;
 	return regs->gprs[2];
 
 badframe:
