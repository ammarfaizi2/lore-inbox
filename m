Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263776AbUCZD0w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 22:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263909AbUCZD0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 22:26:51 -0500
Received: from gate.crashing.org ([63.228.1.57]:58760 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263776AbUCZD0d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 22:26:33 -0500
Subject: [PATCH] ppc32: arch code preempt fixes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Content-Type: text/plain
Message-Id: <1080271455.1196.13.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 26 Mar 2004 14:24:15 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I figured the best way to stop beeing bothered by users trying to
run preempt was to fix it ;) Here's a first batch that close some
races we had when testing regs->msr for altivec or FPU enable, then
doing the giveup_* function. A preempt in between those would have
caused us to save a stale altivec or FPU context.

Please, apply.

Ben.

diff -urN linux-2.5/arch/ppc/kernel/process.c linuxppc-2.5-benh/arch/ppc/kernel/process.c
--- linux-2.5/arch/ppc/kernel/process.c	2004-03-01 18:11:11.000000000 +1100
+++ linuxppc-2.5-benh/arch/ppc/kernel/process.c	2004-03-25 14:35:07.000000000 +1100
@@ -164,6 +164,7 @@
 void
 enable_kernel_altivec(void)
 {
+	preempt_disable();
 #ifdef CONFIG_SMP
 	if (current->thread.regs && (current->thread.regs->msr & MSR_VEC))
 		giveup_altivec(current);
@@ -172,12 +173,14 @@
 #else
 	giveup_altivec(last_task_used_altivec);
 #endif /* __SMP __ */
+	preempt_enable();
 }
 #endif /* CONFIG_ALTIVEC */
 
 void
 enable_kernel_fp(void)
 {
+	preempt_disable();
 #ifdef CONFIG_SMP
 	if (current->thread.regs && (current->thread.regs->msr & MSR_FP))
 		giveup_fpu(current);
@@ -186,13 +189,16 @@
 #else
 	giveup_fpu(last_task_used_math);
 #endif /* CONFIG_SMP */
+	preempt_enable();
 }
 
 int
 dump_fpu(struct pt_regs *regs, elf_fpregset_t *fpregs)
 {
+	preempt_disable();
 	if (regs->msr & MSR_FP)
 		giveup_fpu(current);
+	preempt_enable();
 	memcpy(fpregs, &current->thread.fpr[0], sizeof(*fpregs));
 	return 1;
 }
@@ -330,12 +336,14 @@
 
 	if (regs == NULL)
 		return;
+	preempt_disable();
 	if (regs->msr & MSR_FP)
 		giveup_fpu(current);
 #ifdef CONFIG_ALTIVEC
 	if (regs->msr & MSR_VEC)
 		giveup_altivec(current);
 #endif /* CONFIG_ALTIVEC */
+	preempt_enable();
 }
 
 /*
@@ -480,12 +488,14 @@
 	error = PTR_ERR(filename);
 	if (IS_ERR(filename))
 		goto out;
+	preempt_disable();
 	if (regs->msr & MSR_FP)
 		giveup_fpu(current);
 #ifdef CONFIG_ALTIVEC
 	if (regs->msr & MSR_VEC)
 		giveup_altivec(current);
 #endif /* CONFIG_ALTIVEC */
+	preempt_enable();
 	error = do_execve(filename, (char __user *__user *) a1,
 			  (char __user *__user *) a2, regs);
 	if (error == 0)
diff -urN linux-2.5/arch/ppc/kernel/traps.c linuxppc-2.5-benh/arch/ppc/kernel/traps.c
--- linux-2.5/arch/ppc/kernel/traps.c	2004-03-16 10:21:29.000000000 +1100
+++ linuxppc-2.5-benh/arch/ppc/kernel/traps.c	2004-03-25 13:21:47.000000000 +1100
@@ -391,14 +391,25 @@
 		return 0;
 	if (bug->line & BUG_WARNING_TRAP) {
 		/* this is a WARN_ON rather than BUG/BUG_ON */
+#ifdef CONFIG_XMON
+		xmon_printf(KERN_ERR "Badness in %s at %s:%d\n",
+		       bug->function, bug->file,
+		       bug->line & ~BUG_WARNING_TRAP);
+#endif /* CONFIG_XMON */		
 		printk(KERN_ERR "Badness in %s at %s:%d\n",
 		       bug->function, bug->file,
 		       bug->line & ~BUG_WARNING_TRAP);
 		dump_stack();
 		return 1;
 	}
+#ifdef CONFIG_XMON
+	xmon_printf(KERN_CRIT "kernel BUG in %s at %s:%d!\n",
+	       bug->function, bug->file, bug->line);
+	xmon(regs);
+#endif /* CONFIG_XMON */
 	printk(KERN_CRIT "kernel BUG in %s at %s:%d!\n",
 	       bug->function, bug->file, bug->line);
+
 	return 0;
 }
 
@@ -427,8 +438,14 @@
 		int code = 0;
 		u32 fpscr;
 
+		/* We must make sure the FP state is consistent with
+		 * our MSR_FP in regs
+		 */
+		preempt_disable();
 		if (regs->msr & MSR_FP)
 			giveup_fpu(current);
+		preempt_enable();
+
 		fpscr = current->thread.fpscr;
 		fpscr &= fpscr << 22;	/* mask summary bits with enables */
 		if (fpscr & FPSCR_VX)
@@ -592,13 +609,17 @@
 void
 AltivecAssistException(struct pt_regs *regs)
 {
+	preempt_disable();
 	if (regs->msr & MSR_VEC)
 		giveup_altivec(current);
+	preempt_enable();
+
 	/* XXX quick hack for now: set the non-Java bit in the VSCR */
 	current->thread.vscr.u[3] |= 0x10000;
 }
 #endif /* CONFIG_ALTIVEC */
 
+
 void __init trap_init(void)
 {
 }


