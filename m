Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbUAVCwO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 21:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264321AbUAVCwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 21:52:14 -0500
Received: from gate.crashing.org ([63.228.1.57]:63447 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261270AbUAVCwH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 21:52:07 -0500
Subject: [PATCH] ppc32: Fixes to the signal context code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1074739872.949.85.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 22 Jan 2004 13:51:13 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew !

This patch (which has been in my tree for some time now) does 2
things to the ppc32 signal code:

 - The new sys_swapcontext() syscall that we added recently (and which
is _not_ yet used by glibc, so it's ok to change it slightly at this
point, glibc kernel version check will limit us to 2.6.2 or 2.6.3)
gets a new context size argument, so we can deal with future context
size changes.

 - When ucontext is get/set/swapped using the above syscall, the TLS
(r2) is preserved (it's still saved/restored on signal entry & return
though).

The equivalent of this patch is already in the ppc64 signal32.c emulation,
and it has no effect until glibc is updated to use the new syscall, which
should happen soon now, so please apply.

Regards,
Ben.


diff -urN linuxppc-2.5-benh/arch/ppc/kernel/signal.c linux-2.5-merge/arch/ppc/kernel/signal.c
--- linuxppc-2.5-benh/arch/ppc/kernel/signal.c	2004-01-22 11:12:43.769970904 +1100
+++ linux-2.5-merge/arch/ppc/kernel/signal.c	2004-01-22 13:20:57.393362368 +1100
@@ -241,16 +241,12 @@
  * (except for MSR).
  */
 static int
-restore_user_regs(struct pt_regs *regs, struct mcontext __user *sr, int sig)
+restore_user_regs(struct pt_regs *regs, struct mcontext __user *sr)
 {
-	unsigned long save_r2;
 #ifdef CONFIG_ALTIVEC
 	unsigned long msr;
 #endif
 
-	/* backup/restore the TLS as we don't want it to be modified */
-	if (!sig)
-		save_r2 = regs->gpr[2];
 	/* copy up to but not including MSR */
 	if (__copy_from_user(regs, &sr->mc_gregs, PT_MSR * sizeof(elf_greg_t)))
 		return 1;
@@ -258,8 +254,6 @@
 	if (__copy_from_user(&regs->orig_gpr3, &sr->mc_gregs[PT_ORIG_R3],
 			     GP_REGS_SIZE - PT_ORIG_R3 * sizeof(elf_greg_t)))
 		return 1;
-	if (!sig)
-		regs->gpr[2] = save_r2;
 
 	/* force the process to reload the FP registers from
 	   current->thread when it next does FP instructions */
@@ -365,7 +359,7 @@
 	force_sig(SIGSEGV, current);
 }
 
-static int do_setcontext(struct ucontext __user *ucp, struct pt_regs *regs, int sig)
+static int do_setcontext(struct ucontext __user *ucp, struct pt_regs *regs)
 {
 	sigset_t set;
 	struct mcontext *mcp;
@@ -374,7 +368,7 @@
 	    || __get_user(mcp, &ucp->uc_regs))
 		return -EFAULT;
 	restore_sigmask(&set);
-	if (restore_user_regs(regs, mcp, sig))
+	if (restore_user_regs(regs, mcp))
 		return -EFAULT;
 
 	return 0;
@@ -382,16 +376,10 @@
 
 int sys_swapcontext(struct ucontext __user *old_ctx,
 		    struct ucontext __user *new_ctx,
-		    int ctx_size, int r6, int r7, int r8, struct pt_regs *regs)
+		    int r5, int r6, int r7, int r8, struct pt_regs *regs)
 {
 	unsigned char tmp;
 
-	/* Context size is for future use. Right now, we only make sure
-	 * we are passed something we understand
-	 */
-	if (ctx_size < sizeof(struct ucontext))
-		return -EINVAL;
-
 	if (old_ctx != NULL) {
 		if (verify_area(VERIFY_WRITE, old_ctx, sizeof(*old_ctx))
 		    || save_user_regs(regs, &old_ctx->uc_mcontext, 0)
@@ -418,7 +406,7 @@
 	 * or if another thread unmaps the region containing the context.
 	 * We kill the task with a SIGSEGV in this situation.
 	 */
-	if (do_setcontext(new_ctx, regs, 0))
+	if (do_setcontext(new_ctx, regs))
 		do_exit(SIGSEGV);
 	sigreturn_exit(regs);
 	/* doesn't actually return back to here */
@@ -437,7 +425,7 @@
 		(regs->gpr[1] + __SIGNAL_FRAMESIZE + 16);
 	if (verify_area(VERIFY_READ, rt_sf, sizeof(struct rt_sigframe)))
 		goto bad;
-	if (do_setcontext(&rt_sf->uc, regs, 1))
+	if (do_setcontext(&rt_sf->uc, regs))
 		goto bad;
 
 	/*
@@ -496,7 +484,7 @@
 	if (save_user_regs(regs, &frame->mctx, __NR_sigreturn))
 		goto badframe;
 
-	if (put_user(regs->gpr[1], (unsigned long __user *)newsp))
+	if (put_user(regs->gpr[1], (unsigned long *)newsp))
 		goto badframe;
 	regs->gpr[1] = newsp;
 	regs->gpr[3] = sig;
@@ -541,7 +529,7 @@
 
 	sr = (struct mcontext *) sigctx.regs;
 	if (verify_area(VERIFY_READ, sr, sizeof(*sr))
-	    || restore_user_regs(regs, sr, 1))
+	    || restore_user_regs(regs, sr))
 		goto badframe;
 
 	sigreturn_exit(regs);		/* doesn't return */


