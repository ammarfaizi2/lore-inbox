Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265198AbUFHL4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265198AbUFHL4f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 07:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265170AbUFHL4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 07:56:18 -0400
Received: from ozlabs.org ([203.10.76.45]:61346 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265044AbUFHLsc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 07:48:32 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16581.36680.665915.435522@cargo.ozlabs.ibm.com>
Date: Tue, 8 Jun 2004 20:04:56 +1000
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linuxppc64-dev@lists.linuxppc.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, anton@samba.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: PREEMPT for ppc64
In-Reply-To: <Pine.LNX.4.58.0406070737240.1730@ppc970.osdl.org>
References: <16580.7953.94871.281986@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0406070737240.1730@ppc970.osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> The most _common_ bug (and the one I don't see any code for at all in your
> patch) is stuff that knows which CPU it is on, or that reads actual
> special CPU registers and acts on them. The other thing to look out for is
> anything that gets the CPU number: use "get_cpu() + put_cpu()" rather than
> "smp_processor_id()".

I went through and looked at all the uses of smp_processor_id(),
get_paca(), mfspr(), and mtspr().  There were a few places in
arch/ppc64/mm/*.c that were using smp_processor_id() to do the
optimization of using the local-processor-only form of the tlb
invalidate instruction.  I changed them to use get_cpu/put_cpu and
that has fixed the problem.  It's running well now, I have been using
it on a G5 and other boxes and it hasn't hung or crashed.

I also made flush_fp_to_thread() and flush_altivec_to_thread()
functions.  It is necessary to disable preemption before testing
regs->msr (as Ben noted) so I put in a comment about that.

Here's the current patch.  I think it should go in after 2.6.7 is out.

Regards,
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
+++ test25/arch/ppc64/kernel/align.c	2004-06-08 15:37:40.000000000 +1000
@@ -22,8 +22,6 @@
 #include <asm/cache.h>
 #include <asm/cputable.h>
 
-void disable_kernel_fp(void); /* asm function from head.S */
-
 struct aligninfo {
 	unsigned char len;
 	unsigned char flags;
@@ -280,8 +278,11 @@
 	}
 
 	/* Force the fprs into the save area so we can reference them */
-	if ((flags & F) && (regs->msr & MSR_FP))
-		giveup_fpu(current);
+	if (flags & F) {
+		if (!user_mode(regs))
+			return 0;
+		flush_fp_to_thread(current);
+	}
 	
 	/* If we are loading, get the data from user space */
 	if (flags & LD) {
@@ -310,9 +311,11 @@
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
@@ -344,9 +347,11 @@
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
+++ test25/arch/ppc64/kernel/entry.S	2004-06-06 18:31:22.000000000 +1000
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
+++ test25/arch/ppc64/kernel/process.c	2004-06-08 16:23:02.968947112 +1000
@@ -65,8 +65,43 @@
 	.page_table_lock = SPIN_LOCK_UNLOCKED,
 };
 
+/*
+ * Make sure the floating-point register state in the
+ * the thread_struct is up to date for task tsk.
+ */
+void flush_fp_to_thread(struct task_struct *tsk)
+{
+	if (tsk->thread.regs) {
+		/*
+		 * We need to disable preemption here because if we didn't,
+		 * another process could get scheduled after the regs->msr
+		 * test but before we have finished saving the FP registers
+		 * to the thread_struct.  That process could take over the
+		 * FPU, and then when we get scheduled again we would store
+		 * bogus values for the remaining FP registers.
+		 */
+		preempt_disable();
+		if (tsk->thread.regs->msr & MSR_FP) {
+#ifdef CONFIG_SMP
+			/*
+			 * This should only ever be called for current or
+			 * for a stopped child process.  Since we save away
+			 * the FP register state on context switch on SMP,
+			 * there is something wrong if a stopped child appears
+			 * to still have its FP state in the CPU registers.
+			 */
+			BUG_ON(tsk != current);
+#endif
+			giveup_fpu(current);
+		}
+		preempt_enable();
+	}
+}
+
 void enable_kernel_fp(void)
 {
+	WARN_ON(preemptible());
+
 #ifdef CONFIG_SMP
 	if (current->thread.regs && (current->thread.regs->msr & MSR_FP))
 		giveup_fpu(current);
@@ -80,12 +115,9 @@
 
 int dump_task_fpu(struct task_struct *tsk, elf_fpregset_t *fpregs)
 {
-	struct pt_regs *regs = tsk->thread.regs;
-
-	if (!regs)
+	if (!tsk->thread.regs)
 		return 0;
-	if (tsk == current && (regs->msr & MSR_FP))
-		giveup_fpu(current);
+	flush_fp_to_thread(current);
 
 	memcpy(fpregs, &tsk->thread.fpr[0], sizeof(*fpregs));
 
@@ -96,6 +128,8 @@
 
 void enable_kernel_altivec(void)
 {
+	WARN_ON(preemptible());
+
 #ifdef CONFIG_SMP
 	if (current->thread.regs && (current->thread.regs->msr & MSR_VEC))
 		giveup_altivec(current);
@@ -107,10 +141,29 @@
 }
 EXPORT_SYMBOL(enable_kernel_altivec);
 
+/*
+ * Make sure the VMX/Altivec register state in the
+ * the thread_struct is up to date for task tsk.
+ */
+void flush_altivec_to_thread(struct task_struct *tsk)
+{
+#ifdef CONFIG_ALTIVEC
+	if (tsk->thread.regs) {
+		preempt_disable();
+		if (tsk->thread.regs->msr & MSR_VEC) {
+#ifdef CONFIG_SMP
+			BUG_ON(tsk != current);
+#endif
+			giveup_altivec(current);
+		}
+		preempt_enable();
+	}
+#endif
+}
+
 int dump_task_altivec(struct pt_regs *regs, elf_vrregset_t *vrregs)
 {
-	if (regs->msr & MSR_VEC)
-		giveup_altivec(current);
+	flush_altivec_to_thread(current);
 	memcpy(vrregs, &current->thread.vr[0], sizeof(*vrregs));
 	return 1;
 }
@@ -245,16 +298,8 @@
  */
 void prepare_to_copy(struct task_struct *tsk)
 {
-	struct pt_regs *regs = tsk->thread.regs;
-
-	if (regs == NULL)
-		return;
-	if (regs->msr & MSR_FP)
-		giveup_fpu(current);
-#ifdef CONFIG_ALTIVEC
-	if (regs->msr & MSR_VEC)
-		giveup_altivec(current);
-#endif /* CONFIG_ALTIVEC */
+	flush_fp_to_thread(current);
+	flush_altivec_to_thread(current);
 }
 
 /*
@@ -439,12 +484,8 @@
 	error = PTR_ERR(filename);
 	if (IS_ERR(filename))
 		goto out;
-	if (regs->msr & MSR_FP)
-		giveup_fpu(current);
-#ifdef CONFIG_ALTIVEC
-	if (regs->msr & MSR_VEC)
-		giveup_altivec(current);
-#endif /* CONFIG_ALTIVEC */
+	flush_fp_to_thread(current);
+	flush_altivec_to_thread(current);
 	error = do_execve(filename, (char __user * __user *) a1,
 				    (char __user * __user *) a2, regs);
   
diff -urN linux-2.5/arch/ppc64/kernel/ptrace.c test25/arch/ppc64/kernel/ptrace.c
--- linux-2.5/arch/ppc64/kernel/ptrace.c	2004-06-01 08:11:19.000000000 +1000
+++ test25/arch/ppc64/kernel/ptrace.c	2004-06-08 14:20:46.000000000 +1000
@@ -119,8 +119,7 @@
 		if (index < PT_FPR0) {
 			tmp = get_reg(child, (int)index);
 		} else {
-			if (child->thread.regs->msr & MSR_FP)
-				giveup_fpu(child);
+			flush_fp_to_thread(child);
 			tmp = ((unsigned long *)child->thread.fpr)[index - PT_FPR0];
 		}
 		ret = put_user(tmp,(unsigned long __user *) data);
@@ -152,8 +151,7 @@
 		if (index < PT_FPR0) {
 			ret = put_reg(child, index, data);
 		} else {
-			if (child->thread.regs->msr & MSR_FP)
-				giveup_fpu(child);
+			flush_fp_to_thread(child);
 			((unsigned long *)child->thread.fpr)[index - PT_FPR0] = data;
 			ret = 0;
 		}
@@ -245,8 +243,7 @@
 		unsigned long *reg = &((unsigned long *)child->thread.fpr)[0];
 		unsigned long __user *tmp = (unsigned long __user *)addr;
 
-		if (child->thread.regs->msr & MSR_FP)
-			giveup_fpu(child);
+		flush_fp_to_thread(child);
 
 		for (i = 0; i < 32; i++) {
 			ret = put_user(*reg, tmp);
@@ -263,8 +260,7 @@
 		unsigned long *reg = &((unsigned long *)child->thread.fpr)[0];
 		unsigned long __user *tmp = (unsigned long __user *)addr;
 
-		if (child->thread.regs->msr & MSR_FP)
-			giveup_fpu(child);
+		flush_fp_to_thread(child);
 
 		for (i = 0; i < 32; i++) {
 			ret = get_user(*reg, tmp);
diff -urN linux-2.5/arch/ppc64/kernel/ptrace32.c test25/arch/ppc64/kernel/ptrace32.c
--- linux-2.5/arch/ppc64/kernel/ptrace32.c	2004-06-01 08:11:19.000000000 +1000
+++ test25/arch/ppc64/kernel/ptrace32.c	2004-06-08 14:35:01.000000000 +1000
@@ -136,8 +136,7 @@
 		if (index < PT_FPR0) {
 			tmp = get_reg(child, index);
 		} else {
-			if (child->thread.regs->msr & MSR_FP)
-				giveup_fpu(child);
+			flush_fp_to_thread(child);
 			/*
 			 * the user space code considers the floating point
 			 * to be an array of unsigned int (32 bits) - the
@@ -179,8 +178,7 @@
 			break;
 
 		if (numReg >= PT_FPR0) {
-			if (child->thread.regs->msr & MSR_FP)
-				giveup_fpu(child);
+			flush_fp_to_thread(child);
 			tmp = ((unsigned long int *)child->thread.fpr)[numReg - PT_FPR0];
 		} else { /* register within PT_REGS struct */
 			tmp = get_reg(child, numReg);
@@ -244,8 +242,7 @@
 		if (index < PT_FPR0) {
 			ret = put_reg(child, index, data);
 		} else {
-			if (child->thread.regs->msr & MSR_FP)
-				giveup_fpu(child);
+			flush_fp_to_thread(child);
 			/*
 			 * the user space code considers the floating point
 			 * to be an array of unsigned int (32 bits) - the
@@ -283,8 +280,7 @@
 				|| ((numReg > PT_CCR) && (numReg < PT_FPR0)))
 			break;
 		if (numReg >= PT_FPR0) {
-			if (child->thread.regs->msr & MSR_FP)
-				giveup_fpu(child);
+			flush_fp_to_thread(child);
 		}
 		if (numReg == PT_MSR)
 			data = (data & MSR_DEBUGCHANGE)
@@ -379,8 +375,7 @@
 		unsigned long *reg = &((unsigned long *)child->thread.fpr)[0];
 		unsigned int __user *tmp = (unsigned int __user *)addr;
 
-		if (child->thread.regs->msr & MSR_FP)
-			giveup_fpu(child);
+		flush_fp_to_thread(child);
 
 		for (i = 0; i < 32; i++) {
 			ret = put_user(*reg, tmp);
@@ -397,8 +392,7 @@
 		unsigned long *reg = &((unsigned long *)child->thread.fpr)[0];
 		unsigned int __user *tmp = (unsigned int __user *)addr;
 
-		if (child->thread.regs->msr & MSR_FP)
-			giveup_fpu(child);
+		flush_fp_to_thread(child);
 
 		for (i = 0; i < 32; i++) {
 			ret = get_user(*reg, tmp);
diff -urN linux-2.5/arch/ppc64/kernel/rtas.c test25/arch/ppc64/kernel/rtas.c
--- linux-2.5/arch/ppc64/kernel/rtas.c	2004-05-22 09:08:53.000000000 +1000
+++ test25/arch/ppc64/kernel/rtas.c	2004-06-08 16:24:40.010838888 +1000
@@ -68,10 +68,11 @@
 void
 call_rtas_display_status(char c)
 {
-	struct rtas_args *args = &(get_paca()->xRtas);
+	struct rtas_args *args;
 	unsigned long s;
 
 	spin_lock_irqsave(&rtas.lock, s);
+	args = &(get_paca()->xRtas);
 
 	args->token = 10;
 	args->nargs = 1;
@@ -145,7 +146,7 @@
 	va_list list;
 	int i, logit = 0;
 	unsigned long s;
-	struct rtas_args *rtas_args = &(get_paca()->xRtas);
+	struct rtas_args *rtas_args;
 	long ret;
 
 	PPCDBG(PPCDBG_RTAS, "Entering rtas_call\n");
@@ -158,6 +159,7 @@
 
 	/* Gotta do something different here, use global lock for now... */
 	spin_lock_irqsave(&rtas.lock, s);
+	rtas_args = &(get_paca()->xRtas);
 
 	rtas_args->token = token;
 	rtas_args->nargs = nargs;
diff -urN linux-2.5/arch/ppc64/kernel/signal.c test25/arch/ppc64/kernel/signal.c
--- linux-2.5/arch/ppc64/kernel/signal.c	2004-06-01 08:11:19.000000000 +1000
+++ test25/arch/ppc64/kernel/signal.c	2004-06-08 16:25:15.899840320 +1000
@@ -131,8 +131,7 @@
 #endif
 	long err = 0;
 
-	if (regs->msr & MSR_FP)
-		giveup_fpu(current);
+	flush_fp_to_thread(current);
 
 	/* Make sure signal doesn't get spurrious FP exceptions */
 	current->thread.fpscr = 0;
@@ -141,9 +140,8 @@
 	err |= __put_user(v_regs, &sc->v_regs);
 
 	/* save altivec registers */
-	if (current->thread.used_vr) {		
-		if (regs->msr & MSR_VEC)
-			giveup_altivec(current);
+	if (current->thread.used_vr) {
+		flush_altivec_to_thread(current);
 		/* Copy 33 vec registers (vr0..31 and vscr) to the stack */
 		err |= __copy_to_user(v_regs, current->thread.vr, 33 * sizeof(vector128));
 		/* set MSR_VEC in the MSR value in the frame to indicate that sc->v_reg)
diff -urN linux-2.5/arch/ppc64/kernel/signal32.c test25/arch/ppc64/kernel/signal32.c
--- linux-2.5/arch/ppc64/kernel/signal32.c	2004-06-01 08:11:19.000000000 +1000
+++ test25/arch/ppc64/kernel/signal32.c	2004-06-08 16:25:26.220868592 +1000
@@ -130,11 +130,10 @@
 {
 	elf_greg_t64 *gregs = (elf_greg_t64 *)regs;
 	int i, err = 0;
-	
-	/* Make sure floating point registers are stored in regs */ 
-	if (regs->msr & MSR_FP)
-		giveup_fpu(current);
-	
+
+	/* Make sure floating point registers are stored in regs */
+	flush_fp_to_thread(current);
+
 	/* save general and floating-point registers */
 	for (i = 0; i <= PT_RESULT; i ++)
 		err |= __put_user((unsigned int)gregs[i], &frame->mc_gregs[i]);
@@ -148,8 +147,7 @@
 #ifdef CONFIG_ALTIVEC
 	/* save altivec registers */
 	if (current->thread.used_vr) {
-		if (regs->msr & MSR_VEC)
-			giveup_altivec(current);
+		flush_altivec_to_thread(current);
 		if (__copy_to_user(&frame->mc_vregs, current->thread.vr,
 				   ELF_NVRREG32 * sizeof(vector128)))
 			return 1;
diff -urN linux-2.5/arch/ppc64/kernel/sys_ppc32.c test25/arch/ppc64/kernel/sys_ppc32.c
--- linux-2.5/arch/ppc64/kernel/sys_ppc32.c	2004-06-01 08:11:19.000000000 +1000
+++ test25/arch/ppc64/kernel/sys_ppc32.c	2004-06-08 15:19:01.000000000 +1000
@@ -617,12 +617,8 @@
 	error = PTR_ERR(filename);
 	if (IS_ERR(filename))
 		goto out;
-	if (regs->msr & MSR_FP)
-		giveup_fpu(current);
-#ifdef CONFIG_ALTIVEC
-	if (regs->msr & MSR_VEC)
-		giveup_altivec(current);
-#endif /* CONFIG_ALTIVEC */
+	flush_fp_to_thread(current);
+	flush_altivec_to_thread(current);
 
 	error = compat_do_execve(filename, compat_ptr(a1), compat_ptr(a2), regs);
 
diff -urN linux-2.5/arch/ppc64/kernel/traps.c test25/arch/ppc64/kernel/traps.c
--- linux-2.5/arch/ppc64/kernel/traps.c	2004-05-22 09:08:53.000000000 +1000
+++ test25/arch/ppc64/kernel/traps.c	2004-06-08 16:26:54.933962616 +1000
@@ -308,8 +308,7 @@
 	siginfo_t info;
 	unsigned long fpscr;
 
-	if (regs->msr & MSR_FP)
-		giveup_fpu(current);
+	flush_fp_to_thread(current);
 
 	fpscr = current->thread.fpscr;
 
@@ -521,8 +520,7 @@
 void
 AltivecAssistException(struct pt_regs *regs)
 {
-	if (regs->msr & MSR_VEC)
-		giveup_altivec(current);
+	flush_altivec_to_thread(current);
 	/* XXX quick hack for now: set the non-Java bit in the VSCR */
 	current->thread.vscr.u[3] |= 0x10000;
 }
diff -urN linux-2.5/arch/ppc64/mm/hash_utils.c test25/arch/ppc64/mm/hash_utils.c
--- linux-2.5/arch/ppc64/mm/hash_utils.c	2004-04-01 06:59:36.000000000 +1000
+++ test25/arch/ppc64/mm/hash_utils.c	2004-06-08 13:51:25.000000000 +1000
@@ -251,6 +251,7 @@
 	struct mm_struct *mm;
 	pte_t *ptep;
 	int ret;
+	int cpu;
 	int user_region = 0;
 	int local = 0;
 	cpumask_t tmp;
@@ -302,7 +303,8 @@
 	if (pgdir == NULL)
 		return 1;
 
-	tmp = cpumask_of_cpu(smp_processor_id());
+	cpu = get_cpu();
+	tmp = cpumask_of_cpu(cpu);
 	if (user_region && cpus_equal(mm->cpu_vm_mask, tmp))
 		local = 1;
 
@@ -311,11 +313,13 @@
 		ret = hash_huge_page(mm, access, ea, vsid, local);
 	else {
 		ptep = find_linux_pte(pgdir, ea);
-		if (ptep == NULL)
+		if (ptep == NULL) {
+			put_cpu();
 			return 1;
+		}
 		ret = __hash_page(ea, access, vsid, ptep, trap, local);
 	}
-
+	put_cpu();
 
 	return ret;
 }
diff -urN linux-2.5/arch/ppc64/mm/hugetlbpage.c test25/arch/ppc64/mm/hugetlbpage.c
--- linux-2.5/arch/ppc64/mm/hugetlbpage.c	2004-05-23 17:45:55.000000000 +1000
+++ test25/arch/ppc64/mm/hugetlbpage.c	2004-06-08 13:52:16.000000000 +1000
@@ -375,6 +375,7 @@
 	unsigned long addr;
 	hugepte_t *ptep;
 	struct page *page;
+	int cpu;
 	int local = 0;
 	cpumask_t tmp;
 
@@ -383,7 +384,8 @@
 	BUG_ON((end % HPAGE_SIZE) != 0);
 
 	/* XXX are there races with checking cpu_vm_mask? - Anton */
-	tmp = cpumask_of_cpu(smp_processor_id());
+	cpu = get_cpu();
+	tmp = cpumask_of_cpu(cpu);
 	if (cpus_equal(vma->vm_mm->cpu_vm_mask, tmp))
 		local = 1;
 
@@ -406,6 +408,7 @@
 
 		put_page(page);
 	}
+	put_cpu();
 
 	mm->rss -= (end - start) >> PAGE_SHIFT;
 }
diff -urN linux-2.5/arch/ppc64/mm/init.c test25/arch/ppc64/mm/init.c
--- linux-2.5/arch/ppc64/mm/init.c	2004-05-28 07:16:52.000000000 +1000
+++ test25/arch/ppc64/mm/init.c	2004-06-08 13:52:50.000000000 +1000
@@ -764,6 +764,7 @@
 	void *pgdir;
 	pte_t *ptep;
 	int local = 0;
+	int cpu;
 	cpumask_t tmp;
 
 	/* handle i-cache coherency */
@@ -794,12 +795,14 @@
 
 	vsid = get_vsid(vma->vm_mm->context.id, ea);
 
-	tmp = cpumask_of_cpu(smp_processor_id());
+	cpu = get_cpu();
+	tmp = cpumask_of_cpu(cpu);
 	if (cpus_equal(vma->vm_mm->cpu_vm_mask, tmp))
 		local = 1;
 
 	__hash_page(ea, pte_val(pte) & (_PAGE_USER|_PAGE_RW), vsid, ptep,
 		    0x300, local);
+	put_cpu();
 }
 
 void * reserve_phb_iospace(unsigned long size)
diff -urN linux-2.5/arch/ppc64/mm/tlb.c test25/arch/ppc64/mm/tlb.c
--- linux-2.5/arch/ppc64/mm/tlb.c	2004-05-23 17:45:55.000000000 +1000
+++ test25/arch/ppc64/mm/tlb.c	2004-06-08 13:54:44.000000000 +1000
@@ -91,12 +91,15 @@
 void __flush_tlb_pending(struct ppc64_tlb_batch *batch)
 {
 	int i;
-	cpumask_t tmp = cpumask_of_cpu(smp_processor_id());
+	int cpu;
+	cpumask_t tmp;
 	int local = 0;
 
 	BUG_ON(in_interrupt());
 
+	cpu = get_cpu();
 	i = batch->index;
+	tmp = cpumask_of_cpu(cpu);
 	if (cpus_equal(batch->mm->cpu_vm_mask, tmp))
 		local = 1;
 
@@ -106,6 +109,7 @@
 	else
 		flush_hash_range(batch->context, i, local);
 	batch->index = 0;
+	put_cpu();
 }
 
 #ifdef CONFIG_SMP
diff -urN linux-2.5/include/asm-ppc64/hardirq.h test25/include/asm-ppc64/hardirq.h
--- linux-2.5/include/asm-ppc64/hardirq.h	2003-10-17 06:01:35.000000000 +1000
+++ test25/include/asm-ppc64/hardirq.h	2004-06-06 20:37:24.000000000 +1000
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
diff -urN linux-2.5/include/asm-ppc64/system.h test25/include/asm-ppc64/system.h
--- linux-2.5/include/asm-ppc64/system.h	2004-05-22 09:08:54.000000000 +1000
+++ test25/include/asm-ppc64/system.h	2004-06-08 16:29:24.431868072 +1000
@@ -111,6 +111,8 @@
 extern int _get_PVR(void);
 extern void giveup_fpu(struct task_struct *);
 extern void disable_kernel_fp(void);
+extern void flush_fp_to_thread(struct task_struct *);
+extern void flush_altivec_to_thread(struct task_struct *);
 extern void enable_kernel_fp(void);
 extern void giveup_altivec(struct task_struct *);
 extern void disable_kernel_altivec(void);
diff -urN linux-2.5/include/asm-ppc64/thread_info.h test25/include/asm-ppc64/thread_info.h
--- linux-2.5/include/asm-ppc64/thread_info.h	2004-05-26 18:14:47.000000000 +1000
+++ test25/include/asm-ppc64/thread_info.h	2004-06-06 18:23:21.000000000 +1000
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
