Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261880AbUFGHwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbUFGHwH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 03:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbUFGHwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 03:52:07 -0400
Received: from ozlabs.org ([203.10.76.45]:50388 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261880AbUFGHvn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 03:51:43 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16580.7953.94871.281986@cargo.ozlabs.ibm.com>
Date: Mon, 7 Jun 2004 17:53:53 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Cc: anton@samba.org, benh@kernel.crashing.org, akpm@osdl.org,
       torvalds@osdl.org
Subject: PREEMPT for ppc64
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch that implements CONFIG_PREEMPT for ppc64.  Aside from
the entry.S changes to check the _TIF_NEED_RESCHED bit when returning
from an exception, most of the changes are to add preempt/{dis,en}able
in various places.  Undoubtedly I have missed some though.

This runs just fine with CONFIG_PREEMPT=y on the two pSeries machines
I tried it on, but on my dual G5 it locks up randomly.  It boots OK,
but if I do kernel compile with -j3 it doesn't get the whole way
through.  It just freezes solid with no oops.  Time for firescope
maybe.

Paul.

diff -urN linux-2.5/arch/ppc64/Kconfig test25/arch/ppc64/Kconfig
--- linux-2.5/arch/ppc64/Kconfig	2004-05-26 07:58:59.000000000 +1000
+++ test25/arch/ppc64/Kconfig	2004-06-05 20:42:42.000000000 +1000
@@ -198,7 +198,6 @@
 
 config PREEMPT
 	bool "Preemptible Kernel"
-	depends on BROKEN
 	help
 	  This option reduces the latency of the kernel when reacting to
 	  real-time or interactive events by allowing a low priority process to
diff -urN linux-2.5/arch/ppc64/kernel/align.c test25/arch/ppc64/kernel/align.c
--- linux-2.5/arch/ppc64/kernel/align.c	2004-06-01 08:11:19.000000000 +1000
+++ test25/arch/ppc64/kernel/align.c	2004-06-06 20:36:17.843892064 +1000
@@ -280,8 +280,12 @@
 	}
 
 	/* Force the fprs into the save area so we can reference them */
-	if ((flags & F) && (regs->msr & MSR_FP))
-		giveup_fpu(current);
+	if (flags & F) {
+		preempt_disable();
+		if (regs->msr & MSR_FP)
+			giveup_fpu(current);
+		preempt_enable();
+	}
 	
 	/* If we are loading, get the data from user space */
 	if (flags & LD) {
@@ -310,9 +314,11 @@
 		if (flags & F) {
 			if (nb == 4) {
 				/* Doing stfs, have to convert to single */
+				preempt_disable();
 				enable_kernel_fp();
 				cvt_df(&current->thread.fpr[reg], (float *)&data.v[4], &current->thread.fpscr);
 				disable_kernel_fp();
+				preempt_enable();
 			}
 			else
 				data.dd = current->thread.fpr[reg];
@@ -344,9 +350,11 @@
 		if (flags & F) {
 			if (nb == 4) {
 				/* Doing lfs, have to convert to double */
+				preempt_disable();
 				enable_kernel_fp();
 				cvt_fd((float *)&data.v[4], &current->thread.fpr[reg], &current->thread.fpscr);
 				disable_kernel_fp();
+				preempt_enable();
 			}
 			else
 				current->thread.fpr[reg] = data.dd;
diff -urN linux-2.5/arch/ppc64/kernel/asm-offsets.c test25/arch/ppc64/kernel/asm-offsets.c
--- linux-2.5/arch/ppc64/kernel/asm-offsets.c	2004-06-04 07:19:00.000000000 +1000
+++ test25/arch/ppc64/kernel/asm-offsets.c	2004-06-05 20:43:03.000000000 +1000
@@ -48,6 +48,7 @@
 	DEFINE(THREAD_SHIFT, THREAD_SHIFT);
 	DEFINE(THREAD_SIZE, THREAD_SIZE);
 	DEFINE(TI_FLAGS, offsetof(struct thread_info, flags));
+	DEFINE(TI_PREEMPT, offsetof(struct thread_info, preempt_count));
 
 	/* task_struct->thread */
 	DEFINE(THREAD, offsetof(struct task_struct, thread));
diff -urN linux-2.5/arch/ppc64/kernel/entry.S test25/arch/ppc64/kernel/entry.S
--- linux-2.5/arch/ppc64/kernel/entry.S	2004-05-01 12:59:54.000000000 +1000
+++ test25/arch/ppc64/kernel/entry.S	2004-06-06 18:31:22.621943960 +1000
@@ -371,15 +371,27 @@
 	andc	r9,r10,r4	/* clear MSR_EE */
 	mtmsrd	r9,1		/* Update machine state */
 
+#ifdef CONFIG_PREEMPT
+	clrrdi	r9,r1,THREAD_SHIFT	/* current_thread_info() */
+	ld	r3,_MSR(r1)
+	ld	r4,TI_FLAGS(r9)
+	andi.	r0,r3,MSR_PR
+	mtcrf	1,r4		/* get bottom 4 thread flags into cr7 */
+	bt	31-TIF_NEED_RESCHED,do_resched
+	beq	restore		/* if returning to kernel */
+	bt	31-TIF_SIGPENDING,do_user_signal
+
+#else /* !CONFIG_PREEMPT */
 	ld	r3,_MSR(r1)	/* Returning to user mode? */
 	andi.	r3,r3,MSR_PR
 	beq	restore		/* if not, just restore regs and return */
 
 	/* Check current_thread_info()->flags */
-	clrrdi	r3,r1,THREAD_SHIFT
-	ld	r3,TI_FLAGS(r3)
-	andi.	r0,r3,_TIF_USER_WORK_MASK
+	clrrdi	r9,r1,THREAD_SHIFT
+	ld	r4,TI_FLAGS(r9)
+	andi.	r0,r4,_TIF_USER_WORK_MASK
 	bne	do_work
+#endif
 
 	addi	r0,r1,INT_FRAME_SIZE	/* size of frame */
 	ld	r4,PACACURRENT(r13)
@@ -452,18 +464,47 @@
 
 	rfid
 
+#ifndef CONFIG_PREEMPT
 /* Note: this must change if we start using the  TIF_NOTIFY_RESUME bit */
 do_work:
-	/* Enable interrupts */
-	mtmsrd	r10,1
+	andi.	r0,r4,_TIF_NEED_RESCHED
+	beq	do_user_signal
+
+#else /* CONFIG_PREEMPT */
+do_resched:
+	bne	do_user_resched		/* if returning to user mode */
+	/* Check that preempt_count() == 0 and interrupts are enabled */
+	lwz	r8,TI_PREEMPT(r9)
+	cmpwi	cr1,r8,0
+#ifdef CONFIG_PPC_ISERIES
+	ld	r0,SOFTE(r1)
+	cmpdi	r0,0
+#else
+	andi.	r0,r3,MSR_EE
+#endif
+	crandc	eq,cr1*4+eq,eq
+	bne	restore
+	/* here we are preempting the current task */
+1:	lis	r0,PREEMPT_ACTIVE@h
+	stw	r0,TI_PREEMPT(r9)
+#ifdef CONFIG_PPC_ISERIES
+	li	r0,1
+	stb	r0,PACAPROCENABLED(r13)
+#endif
+#endif /* CONFIG_PREEMPT */
 
-	andi.	r0,r3,_TIF_NEED_RESCHED
-	beq	1f
+do_user_resched:
+	mtmsrd	r10,1		/* reenable interrupts */
 	bl	.schedule
+#ifdef CONFIG_PREEMPT
+	clrrdi	r9,r1,THREAD_SHIFT
+	li	r0,0
+	stw	r0,TI_PREEMPT(r9)
+#endif
 	b	.ret_from_except
 
-1:	andi.	r0,r3,_TIF_SIGPENDING
-	beq	.ret_from_except
+do_user_signal:
+	mtmsrd	r10,1
 	li	r3,0
 	addi	r4,r1,STACK_FRAME_OVERHEAD
 	bl	.do_signal
diff -urN linux-2.5/arch/ppc64/kernel/process.c test25/arch/ppc64/kernel/process.c
--- linux-2.5/arch/ppc64/kernel/process.c	2004-06-01 08:11:19.000000000 +1000
+++ test25/arch/ppc64/kernel/process.c	2004-06-06 20:39:54.240879144 +1000
@@ -67,6 +67,8 @@
 
 void enable_kernel_fp(void)
 {
+	WARN_ON(preemptible());
+
 #ifdef CONFIG_SMP
 	if (current->thread.regs && (current->thread.regs->msr & MSR_FP))
 		giveup_fpu(current);
@@ -84,8 +86,10 @@
 
 	if (!regs)
 		return 0;
+	preempt_disable();
 	if (tsk == current && (regs->msr & MSR_FP))
 		giveup_fpu(current);
+	preempt_enable();
 
 	memcpy(fpregs, &tsk->thread.fpr[0], sizeof(*fpregs));
 
@@ -96,6 +100,8 @@
 
 void enable_kernel_altivec(void)
 {
+	WARN_ON(preemptible());
+
 #ifdef CONFIG_SMP
 	if (current->thread.regs && (current->thread.regs->msr & MSR_VEC))
 		giveup_altivec(current);
@@ -109,8 +115,10 @@
 
 int dump_task_altivec(struct pt_regs *regs, elf_vrregset_t *vrregs)
 {
+	preempt_disable();
 	if (regs->msr & MSR_VEC)
 		giveup_altivec(current);
+	preempt_enable();
 	memcpy(vrregs, &current->thread.vr[0], sizeof(*vrregs));
 	return 1;
 }
@@ -249,12 +257,14 @@
 
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
@@ -439,12 +449,14 @@
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
 	error = do_execve(filename, (char __user * __user *) a1,
 				    (char __user * __user *) a2, regs);
   
diff -urN linux-2.5/arch/ppc64/kernel/ptrace.c test25/arch/ppc64/kernel/ptrace.c
--- linux-2.5/arch/ppc64/kernel/ptrace.c	2004-06-01 08:11:19.000000000 +1000
+++ test25/arch/ppc64/kernel/ptrace.c	2004-06-05 20:55:21.000000000 +1000
@@ -50,6 +50,32 @@
 	clear_single_step(child);
 }
 
+/* Make sure child's FP registers aren't cached in CPU registers. */
+#ifdef CONFIG_SMP
+/*
+ * On SMP we save away the FP register state on context switch.
+ * Since the child is stopped, there is something seriously wrong
+ * if its FP state appears to still be in the CPU registers.
+ */
+void ptrace_flush_child_fp(struct task_struct *child)
+{
+	BUG_ON(child->thread.regs && (child->thread.regs->msr & MSR_FP));
+}
+#else
+/*
+ * On UP the child's register state may still be in the CPU registers.
+ * We need to disable preemption so that once we decide we need to save
+ * the registers away, we save all of them without getting switched.
+ */
+void ptrace_flush_child_fp(struct task_struct *child)
+{
+	preempt_disable();
+	if (child->thread.regs->msr & MSR_FP)
+		giveup_fpu(child);
+	preempt_enable();
+}
+#endif
+
 int sys_ptrace(long request, long pid, long addr, long data)
 {
 	struct task_struct *child;
@@ -119,8 +145,7 @@
 		if (index < PT_FPR0) {
 			tmp = get_reg(child, (int)index);
 		} else {
-			if (child->thread.regs->msr & MSR_FP)
-				giveup_fpu(child);
+			ptrace_flush_child_fp(child);
 			tmp = ((unsigned long *)child->thread.fpr)[index - PT_FPR0];
 		}
 		ret = put_user(tmp,(unsigned long __user *) data);
@@ -152,8 +177,7 @@
 		if (index < PT_FPR0) {
 			ret = put_reg(child, index, data);
 		} else {
-			if (child->thread.regs->msr & MSR_FP)
-				giveup_fpu(child);
+			ptrace_flush_child_fp(child);
 			((unsigned long *)child->thread.fpr)[index - PT_FPR0] = data;
 			ret = 0;
 		}
@@ -245,8 +269,7 @@
 		unsigned long *reg = &((unsigned long *)child->thread.fpr)[0];
 		unsigned long __user *tmp = (unsigned long __user *)addr;
 
-		if (child->thread.regs->msr & MSR_FP)
-			giveup_fpu(child);
+		ptrace_flush_child_fp(child);
 
 		for (i = 0; i < 32; i++) {
 			ret = put_user(*reg, tmp);
@@ -263,8 +286,7 @@
 		unsigned long *reg = &((unsigned long *)child->thread.fpr)[0];
 		unsigned long __user *tmp = (unsigned long __user *)addr;
 
-		if (child->thread.regs->msr & MSR_FP)
-			giveup_fpu(child);
+		ptrace_flush_child_fp(child);
 
 		for (i = 0; i < 32; i++) {
 			ret = get_user(*reg, tmp);
diff -urN linux-2.5/arch/ppc64/kernel/ptrace32.c test25/arch/ppc64/kernel/ptrace32.c
--- linux-2.5/arch/ppc64/kernel/ptrace32.c	2004-06-01 08:11:19.000000000 +1000
+++ test25/arch/ppc64/kernel/ptrace32.c	2004-06-05 20:54:30.000000000 +1000
@@ -136,8 +136,7 @@
 		if (index < PT_FPR0) {
 			tmp = get_reg(child, index);
 		} else {
-			if (child->thread.regs->msr & MSR_FP)
-				giveup_fpu(child);
+			ptrace_flush_child_fp(child);
 			/*
 			 * the user space code considers the floating point
 			 * to be an array of unsigned int (32 bits) - the
@@ -179,8 +178,7 @@
 			break;
 
 		if (numReg >= PT_FPR0) {
-			if (child->thread.regs->msr & MSR_FP)
-				giveup_fpu(child);
+			ptrace_flush_child_fp(child);
 			tmp = ((unsigned long int *)child->thread.fpr)[numReg - PT_FPR0];
 		} else { /* register within PT_REGS struct */
 			tmp = get_reg(child, numReg);
@@ -244,8 +242,7 @@
 		if (index < PT_FPR0) {
 			ret = put_reg(child, index, data);
 		} else {
-			if (child->thread.regs->msr & MSR_FP)
-				giveup_fpu(child);
+			ptrace_flush_child_fp(child);
 			/*
 			 * the user space code considers the floating point
 			 * to be an array of unsigned int (32 bits) - the
@@ -283,8 +280,7 @@
 				|| ((numReg > PT_CCR) && (numReg < PT_FPR0)))
 			break;
 		if (numReg >= PT_FPR0) {
-			if (child->thread.regs->msr & MSR_FP)
-				giveup_fpu(child);
+			ptrace_flush_child_fp(child);
 		}
 		if (numReg == PT_MSR)
 			data = (data & MSR_DEBUGCHANGE)
@@ -379,8 +375,7 @@
 		unsigned long *reg = &((unsigned long *)child->thread.fpr)[0];
 		unsigned int __user *tmp = (unsigned int __user *)addr;
 
-		if (child->thread.regs->msr & MSR_FP)
-			giveup_fpu(child);
+		ptrace_flush_child_fp(child);
 
 		for (i = 0; i < 32; i++) {
 			ret = put_user(*reg, tmp);
@@ -397,8 +392,7 @@
 		unsigned long *reg = &((unsigned long *)child->thread.fpr)[0];
 		unsigned int __user *tmp = (unsigned int __user *)addr;
 
-		if (child->thread.regs->msr & MSR_FP)
-			giveup_fpu(child);
+		ptrace_flush_child_fp(child);
 
 		for (i = 0; i < 32; i++) {
 			ret = get_user(*reg, tmp);
diff -urN linux-2.5/arch/ppc64/kernel/signal.c test25/arch/ppc64/kernel/signal.c
--- linux-2.5/arch/ppc64/kernel/signal.c	2004-06-01 08:11:19.000000000 +1000
+++ test25/arch/ppc64/kernel/signal.c	2004-06-05 21:20:35.000000000 +1000
@@ -131,8 +131,10 @@
 #endif
 	long err = 0;
 
+	preempt_disable();
 	if (regs->msr & MSR_FP)
 		giveup_fpu(current);
+	preempt_enable();
 
 	/* Make sure signal doesn't get spurrious FP exceptions */
 	current->thread.fpscr = 0;
@@ -142,8 +144,10 @@
 
 	/* save altivec registers */
 	if (current->thread.used_vr) {		
+		preempt_disable();
 		if (regs->msr & MSR_VEC)
 			giveup_altivec(current);
+		preempt_enable();
 		/* Copy 33 vec registers (vr0..31 and vscr) to the stack */
 		err |= __copy_to_user(v_regs, current->thread.vr, 33 * sizeof(vector128));
 		/* set MSR_VEC in the MSR value in the frame to indicate that sc->v_reg)
diff -urN linux-2.5/arch/ppc64/kernel/signal32.c test25/arch/ppc64/kernel/signal32.c
--- linux-2.5/arch/ppc64/kernel/signal32.c	2004-06-01 08:11:19.000000000 +1000
+++ test25/arch/ppc64/kernel/signal32.c	2004-06-05 21:20:52.000000000 +1000
@@ -132,9 +132,11 @@
 	int i, err = 0;
 	
 	/* Make sure floating point registers are stored in regs */ 
+	preempt_disable();
 	if (regs->msr & MSR_FP)
 		giveup_fpu(current);
-	
+	preempt_enable();
+
 	/* save general and floating-point registers */
 	for (i = 0; i <= PT_RESULT; i ++)
 		err |= __put_user((unsigned int)gregs[i], &frame->mc_gregs[i]);
@@ -148,8 +150,10 @@
 #ifdef CONFIG_ALTIVEC
 	/* save altivec registers */
 	if (current->thread.used_vr) {
+		preempt_disable();
 		if (regs->msr & MSR_VEC)
 			giveup_altivec(current);
+		preempt_enable();
 		if (__copy_to_user(&frame->mc_vregs, current->thread.vr,
 				   ELF_NVRREG32 * sizeof(vector128)))
 			return 1;
diff -urN linux-2.5/arch/ppc64/kernel/sys_ppc32.c test25/arch/ppc64/kernel/sys_ppc32.c
--- linux-2.5/arch/ppc64/kernel/sys_ppc32.c	2004-06-01 08:11:19.000000000 +1000
+++ test25/arch/ppc64/kernel/sys_ppc32.c	2004-06-04 22:48:11.000000000 +1000
@@ -617,12 +617,14 @@
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
 
 	error = compat_do_execve(filename, compat_ptr(a1), compat_ptr(a2), regs);
 
diff -urN linux-2.5/arch/ppc64/kernel/traps.c test25/arch/ppc64/kernel/traps.c
--- linux-2.5/arch/ppc64/kernel/traps.c	2004-05-22 09:08:53.000000000 +1000
+++ test25/arch/ppc64/kernel/traps.c	2004-06-05 21:21:48.000000000 +1000
@@ -308,8 +308,10 @@
 	siginfo_t info;
 	unsigned long fpscr;
 
+	preempt_disable();
 	if (regs->msr & MSR_FP)
 		giveup_fpu(current);
+	preempt_enable();
 
 	fpscr = current->thread.fpscr;
 
@@ -521,8 +523,10 @@
 void
 AltivecAssistException(struct pt_regs *regs)
 {
+	preempt_disable();
 	if (regs->msr & MSR_VEC)
 		giveup_altivec(current);
+	preempt_enable();
 	/* XXX quick hack for now: set the non-Java bit in the VSCR */
 	current->thread.vscr.u[3] |= 0x10000;
 }
diff -urN linux-2.5/include/asm-ppc64/hardirq.h test25/include/asm-ppc64/hardirq.h
--- linux-2.5/include/asm-ppc64/hardirq.h	2003-10-17 06:01:35.000000000 +1000
+++ test25/include/asm-ppc64/hardirq.h	2004-06-06 20:37:24.854954688 +1000
@@ -82,9 +82,11 @@
 
 #ifdef CONFIG_PREEMPT
 # define in_atomic()	((preempt_count() & ~PREEMPT_ACTIVE) != kernel_locked())
+# define preemptible()	(preempt_count() == 0 && !irqs_disabled())
 # define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
 #else
 # define in_atomic()	(preempt_count() != 0)
+# define preemptible()	0
 # define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
 #endif
 #define irq_exit()							\
diff -urN linux-2.5/include/asm-ppc64/ptrace.h test25/include/asm-ppc64/ptrace.h
--- linux-2.5/include/asm-ppc64/ptrace.h	2004-05-20 08:06:38.000000000 +1000
+++ test25/include/asm-ppc64/ptrace.h	2004-06-05 21:22:35.000000000 +1000
@@ -60,6 +60,9 @@
 	PPC_REG_32 result; 	/* Result of a system call */
 };
 
+struct task_struct;
+extern void ptrace_flush_child_fp(struct task_struct *);
+
 #endif
 
 #define STACK_FRAME_OVERHEAD	112	/* size of minimum stack frame */
diff -urN linux-2.5/include/asm-ppc64/thread_info.h test25/include/asm-ppc64/thread_info.h
--- linux-2.5/include/asm-ppc64/thread_info.h	2004-05-26 18:14:47.000000000 +1000
+++ test25/include/asm-ppc64/thread_info.h	2004-06-06 18:23:21.819942200 +1000
@@ -13,6 +13,7 @@
 #ifndef __ASSEMBLY__
 #include <linux/config.h>
 #include <asm/processor.h>
+#include <asm/page.h>
 #include <linux/stringify.h>
 
 /*
@@ -23,7 +24,7 @@
 	struct exec_domain *exec_domain;	/* execution domain */
 	unsigned long	flags;			/* low level flags */
 	int		cpu;			/* cpu we're on */
-	int		preempt_count;		/* not used at present */
+	int		preempt_count;
 	struct restart_block restart_block;
 };
 
@@ -73,7 +74,7 @@
 static inline struct thread_info *current_thread_info(void)
 {
 	struct thread_info *ti;
-	__asm__("clrrdi %0,1,14" : "=r"(ti));
+	__asm__("clrrdi %0,1,%1" : "=r"(ti) : "i" (THREAD_SHIFT));
 	return ti;
 }
 
@@ -83,6 +84,8 @@
 
 /*
  * thread information flag bit numbers
+ * N.B. If TIF_SIGPENDING or TIF_NEED_RESCHED are changed
+ * to be >= 4, code in entry.S will need to be changed.
  */
 #define TIF_SYSCALL_TRACE	0	/* syscall trace active */
 #define TIF_NOTIFY_RESUME	1	/* resumption notification requested */
