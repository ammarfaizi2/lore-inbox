Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262704AbUC2G1f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 01:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbUC2G1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 01:27:35 -0500
Received: from gate.crashing.org ([63.228.1.57]:32658 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262704AbUC2G1a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 01:27:30 -0500
Subject: [PATCH] ppc32: More preempt fixes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1080541634.1212.2.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 29 Mar 2004 16:27:14 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch fixes more cases of possible preempt issue when testing
MSR for FP or VEC bits and then doing giveup_fpu or giveup_altivec
that I missed in my previous round of fixes (bk get helps before
grepping ;)

I also change the single step and program check exceptions to not
re-enable interrupts right away on C code entry, it was useless and
would cause interesting issues with preempt & xmon

diff -urN linux-2.5/arch/ppc/kernel/align.c linuxppc-2.5-benh/arch/ppc/kernel/align.c
--- linux-2.5/arch/ppc/kernel/align.c	2004-03-01 18:11:10.000000000 +1100
+++ linuxppc-2.5-benh/arch/ppc/kernel/align.c	2004-03-29 14:45:57.000000000 +1000
@@ -262,8 +262,12 @@
 			return -EFAULT;	/* bad address */
 	}
 
-	if ((flags & F) && (regs->msr & MSR_FP))
-		giveup_fpu(current);
+	if (flags & F) {
+		preempt_disable();
+		if (regs->msr & MSR_FP)
+			giveup_fpu(current);
+		preempt_enable();
+	}
 	if (flags & M)
 		return 0;		/* too hard for now */
 
diff -urN linux-2.5/arch/ppc/kernel/head.S linuxppc-2.5-benh/arch/ppc/kernel/head.S
--- linux-2.5/arch/ppc/kernel/head.S	2004-03-12 15:53:22.000000000 +1100
+++ linuxppc-2.5-benh/arch/ppc/kernel/head.S	2004-03-29 14:52:30.000000000 +1000
@@ -462,7 +462,7 @@
 	EXC_XFER_EE(0x600, AlignmentException)
 
 /* Program check exception */
-	EXCEPTION(0x700, ProgramCheck, ProgramCheckException, EXC_XFER_EE)
+	EXCEPTION(0x700, ProgramCheck, ProgramCheckException, EXC_XFER_STD)
 
 /* Floating-point unavailable */
 	. = 0x800
@@ -485,7 +485,7 @@
 	EXC_XFER_EE_LITE(0xc00, DoSyscall)
 
 /* Single step - not used on 601 */
-	EXCEPTION(0xd00, SingleStep, SingleStepException, EXC_XFER_EE)
+	EXCEPTION(0xd00, SingleStep, SingleStepException, EXC_XFER_STD)
 	EXCEPTION(0xe00, Trap_0e, UnknownException, EXC_XFER_EE)
 
 /*
diff -urN linux-2.5/arch/ppc/kernel/ptrace.c linuxppc-2.5-benh/arch/ppc/kernel/ptrace.c
--- linux-2.5/arch/ppc/kernel/ptrace.c	2004-03-01 18:11:11.000000000 +1100
+++ linuxppc-2.5-benh/arch/ppc/kernel/ptrace.c	2004-03-29 14:48:22.000000000 +1000
@@ -242,8 +242,10 @@
 		if (index < PT_FPR0) {
 			tmp = get_reg(child, (int) index);
 		} else {
+			preempt_disable();
 			if (child->thread.regs->msr & MSR_FP)
 				giveup_fpu(child);
+			preempt_enable();
 			tmp = ((unsigned long *)child->thread.fpr)[index - PT_FPR0];
 		}
 		ret = put_user(tmp,(unsigned long *) data);
@@ -276,8 +278,10 @@
 		if (index < PT_FPR0) {
 			ret = put_reg(child, index, data);
 		} else {
+			preempt_disable();
 			if (child->thread.regs->msr & MSR_FP)
 				giveup_fpu(child);
+			preempt_enable();
 			((unsigned long *)child->thread.fpr)[index - PT_FPR0] = data;
 			ret = 0;
 		}
@@ -338,8 +342,10 @@
 #ifdef CONFIG_ALTIVEC
 	case PTRACE_GETVRREGS:
 		/* Get the child altivec register state. */
+		preempt_disable();
 		if (child->thread.regs->msr & MSR_VEC)
 			giveup_altivec(child);
+		preempt_enable();
 		ret = get_vrregs((unsigned long *)data, child);
 		break;
 
@@ -347,8 +353,10 @@
 		/* Set the child altivec register state. */
 		/* this is to clear the MSR_VEC bit to force a reload
 		 * of register state from memory */
+		preempt_disable();
 		if (child->thread.regs->msr & MSR_VEC)
 			giveup_altivec(child);
+		preempt_enable();
 		ret = set_vrregs(child, (unsigned long *)data);
 		break;
 #endif
diff -urN linux-2.5/arch/ppc/kernel/signal.c linuxppc-2.5-benh/arch/ppc/kernel/signal.c
--- linux-2.5/arch/ppc/kernel/signal.c	2004-03-01 18:11:11.000000000 +1100
+++ linuxppc-2.5-benh/arch/ppc/kernel/signal.c	2004-03-29 14:51:39.000000000 +1000
@@ -191,8 +191,15 @@
 {
 	/* save general and floating-point registers */
 	CHECK_FULL_REGS(regs);
+	preempt_disable();
 	if (regs->msr & MSR_FP)
 		giveup_fpu(current);
+#ifdef CONFIG_ALTIVEC
+	if (current->thread.used_vr && (regs->msr & MSR_VEC))
+		giveup_altivec(current);
+#endif /* CONFIG_ALTIVEC */
+	preempt_enable();
+
 	if (__copy_to_user(&frame->mc_gregs, regs, GP_REGS_SIZE)
 	    || __copy_to_user(&frame->mc_fregs, current->thread.fpr,
 			      ELF_NFPREG * sizeof(double)))
@@ -203,8 +210,6 @@
 #ifdef CONFIG_ALTIVEC
 	/* save altivec registers */
 	if (current->thread.used_vr) {
-		if (regs->msr & MSR_VEC)
-			giveup_altivec(current);
 		if (__copy_to_user(&frame->mc_vregs, current->thread.vr,
 				   ELF_NVRREG * sizeof(vector128)))
 			return 1;


