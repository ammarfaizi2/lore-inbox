Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbULWExV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbULWExV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 23:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbULWExV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 23:53:21 -0500
Received: from ozlabs.org ([203.10.76.45]:57039 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261160AbULWEwG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 23:52:06 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16842.20203.993894.537919@cargo.ozlabs.ibm.com>
Date: Thu, 23 Dec 2004 15:51:55 +1100
From: Paul Mackerras <paulus@samba.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 signal code cleanup
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up the signal handling for PPC64 in 2.4.  There was
some old code in there that was never used, and also the signal
delivery code was saving some state in the thread_struct (in the
saved_msr and saved_softe fields).  That is of course bogus because
the kernel doesn't actually know when the process exits the signal
handler, and because signal handlers can be nested.  This patch
dispenses with the use of those thread_struct fields.  It also fixes a
possible race by using set_current_state (which has a barrier) rather
than setting current->state directly, removes some unused code,
removes some debug cruft, and fixes some compile warnings.

Please apply.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.4/arch/ppc64/kernel/signal.c ppc64-2.4-pseries/arch/ppc64/kernel/signal.c
--- linux-2.4/arch/ppc64/kernel/signal.c	2003-12-16 08:22:34.000000000 +1100
+++ ppc64-2.4-pseries/arch/ppc64/kernel/signal.c	2004-12-23 12:06:00.000000000 +1100
@@ -31,8 +31,8 @@
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
-#include <asm/ppcdebug.h>
 #include <asm/unistd.h>
+#include <asm/processor.h>
 
 #define DEBUG_SIG 0
 
@@ -138,7 +138,7 @@
 	regs->gpr[3] = EINTR;
 	regs->ccr |= 0x10000000;
 	while (1) {
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule();
 		if (do_signal(&saveset, regs))
 			/*
@@ -236,22 +236,16 @@
 
 	if (regs->msr & MSR_FP)
 		giveup_fpu(current);
-
-	current->thread.saved_msr = regs->msr & ~(MSR_FP | MSR_FE0 | MSR_FE1);
-	regs->msr = current->thread.saved_msr | current->thread.fpexc_mode;
-	current->thread.saved_softe = regs->softe;
-
 	err |= __put_user(&sc->gp_regs, &sc->regs);
 	err |= __copy_to_user(&sc->gp_regs, regs, GP_REGS_SIZE);
 	err |= __copy_to_user(&sc->fp_regs, &current->thread.fpr, FP_REGS_SIZE);
+	current->thread.fpscr = 0;
+
 	err |= __put_user(signr, &sc->signal);
 	err |= __put_user(handler, &sc->handler);
 	if (set != NULL)
 		err |=  __put_user(set->sig[0], &sc->oldmask);
 
-	regs->msr &= ~(MSR_FP | MSR_FE0 | MSR_FE1);
-	current->thread.fpscr = 0;
-
 	return err;
 }
 
@@ -263,20 +257,33 @@
 restore_sigcontext(struct pt_regs *regs, sigset_t *set, struct sigcontext *sc)
 {
 	unsigned int err = 0;
-
-	if (regs->msr & MSR_FP)
-		giveup_fpu(current);
-
-	err |= __copy_from_user(regs, &sc->gp_regs, GP_REGS_SIZE);
+	int i;
+	elf_greg_t *gregs = (elf_greg_t *)regs;
+	unsigned long msr;
+
+	/* copy up to but not including MSR */
+	err |= __copy_from_user(regs, &sc->gp_regs,
+				PT_MSR * sizeof(elf_greg_t));
+	/* get the MSR value from the stack but don't put it in regs->msr */
+	err |= __get_user(msr, &sc->gp_regs[PT_MSR]);
+	/* copy from orig_r3 (the word after the MSR) to the end,
+	 * but don't copy softe */
+	for (i = PT_ORIG_R3; err == 0 && i <= PT_RESULT; ++i)
+		if (i != PT_SOFTE)
+			err |= __get_user(gregs[i], &sc->gp_regs[i]);
+
+	/* make the process reload FP regs if it executes an FP instr */
+	regs->msr &= ~(MSR_FP | MSR_FE0 | MSR_FE1);
+#ifndef CONFIG_SMP
+	if (last_task_used_math == current)
+		last_task_used_math = NULL;
+#endif
 	err |= __copy_from_user(&current->thread.fpr, &sc->fp_regs, FP_REGS_SIZE);
-	current->thread.fpexc_mode = regs->msr & (MSR_FE0 | MSR_FE1);
+
+	/* restore the signal mask */
 	if (set != NULL)
 		err |=  __get_user(set->sig[0], &sc->oldmask);
 
-	/* Don't allow the signal handler to change these modulo FE{0,1} */
-	regs->msr = current->thread.saved_msr & ~(MSR_FP | MSR_FE0 | MSR_FE1);
-	regs->softe = current->thread.saved_softe;
-
 	return err;
 }
 
diff -urN linux-2.4/arch/ppc64/kernel/signal32.c ppc64-2.4-pseries/arch/ppc64/kernel/signal32.c
--- linux-2.4/arch/ppc64/kernel/signal32.c	2003-12-16 08:22:34.000000000 +1100
+++ ppc64-2.4-pseries/arch/ppc64/kernel/signal32.c	2004-12-23 13:20:38.000000000 +1100
@@ -48,7 +48,6 @@
 #include <asm/uaccess.h>
 #include <linux/elf.h>
 #include <asm/ppc32.h>
-#include <asm/ppcdebug.h>
 #include <asm/unistd.h>
 #include <asm/ucontext.h>
 
@@ -141,23 +140,22 @@
 {
 	struct k_sigaction new_ka, old_ka;
 	int ret;
+	u32 handler, restorer;
 	
-	PPCDBG(PPCDBG_SYS32, "sys32_sigaction - entered - pid=%ld current=%lx comm=%s\n", current->pid, current, current->comm);
-
 	if (sig < 0)
 		sig = -sig;
 
 	if (act) {
 		old_sigset_t32 mask;
 
-		ret = get_user((long)new_ka.sa.sa_handler, &act->sa_handler);
-		ret |= __get_user((long)new_ka.sa.sa_restorer, &act->sa_restorer);
+		ret = get_user(handler, &act->sa_handler);
+		ret |= __get_user(restorer, &act->sa_restorer);
 		ret |= __get_user(new_ka.sa.sa_flags, &act->sa_flags);
 		ret |= __get_user(mask, &act->sa_mask);
 		if (ret)
 			return ret;
-		PPCDBG(PPCDBG_SIGNAL, "sys32_sigaction flags =%lx  \n", new_ka.sa.sa_flags);
-
+		new_ka.sa.sa_handler = (__sighandler_t)(long) handler;
+		new_ka.sa.sa_restorer = (void (*)(void))(long) restorer;
 		siginitset(&new_ka.sa.sa_mask, mask);
 	}
 
@@ -171,9 +169,6 @@
 		ret |= __put_user(old_ka.sa.sa_mask.sig[0], &oact->sa_mask);
 	}
 
-	
-	PPCDBG(PPCDBG_SYS32, "sys32_sigaction - exited - pid=%ld current=%lx comm=%s\n", current->pid, current, current->comm);
-
 	return ret;
 }
 
@@ -188,15 +183,11 @@
 	int ret;
 	mm_segment_t old_fs = get_fs();
 	
-	PPCDBG(PPCDBG_SYS32, "sys32_sigpending - entered - pid=%ld current=%lx comm=%s\n", current->pid, current, current->comm);
-		
 	set_fs (KERNEL_DS);
 	ret = sys_sigpending(&s);
 	set_fs (old_fs);
 	if (put_user (s, set)) return -EFAULT;
 	
-	PPCDBG(PPCDBG_SYS32, "sys32_sigpending - exited - pid=%ld current=%lx comm=%s\n", current->pid, current, current->comm);
-
 	return ret;
 }
 
@@ -216,16 +207,12 @@
 	int ret;
 	mm_segment_t old_fs = get_fs();
 	
-	PPCDBG(PPCDBG_SYS32, "sys32_sigprocmask - entered - pid=%ld current=%lx comm=%s\n", current->pid, current, current->comm);
-	
 	if (set && get_user(s, set))
 		return -EFAULT;
 	set_fs (KERNEL_DS);
 	ret = sys_sigprocmask((int)how, set ? &s : NULL, oset ? &s : NULL);
 	set_fs (old_fs);
 	
-	PPCDBG(PPCDBG_SYS32, "sys32_sigprocmask - exited - pid=%ld current=%lx comm=%s\n", current->pid, current, current->comm);
-
 	if (ret)
 		return ret;
 	if (oset && put_user (s, oset))
@@ -256,14 +243,10 @@
 {
 	struct sigcontext32 *sc, sigctx;
 	struct sigregs32 *sr;
-	int ret;
 	elf_gregset_t32 saved_regs;  /* an array of ELF_NGREG unsigned ints (32 bits) */
 	sigset_t set;
-	unsigned int prevsp;
 	int i;
 
-	PPCDBG(PPCDBG_SIGNAL, "sys32_sigreturn - entered - pid=%ld current=%lx comm=%s \n", current->pid, current, current->comm);
-
 	sc = (struct sigcontext32 *)(regs->gpr[1] + __SIGNAL_FRAMESIZE32);
 	if (copy_from_user(&sigctx, sc, sizeof(sigctx)))
 		goto badframe;
@@ -279,107 +262,67 @@
 	recalc_sigpending(current);
 	spin_unlock_irq(&current->sigmask_lock);
 
-	sc++;			/* Look at next sigcontext */
-	/* If the next sigcontext is actually the sigregs (frame)  */
-	/*   - then no more sigcontexts on the user stack          */  
-	if (sc == (struct sigcontext32*)(u64)sigctx.regs)
-	{
-		/* Last stacked signal - restore registers */
-		sr = (struct sigregs32*)(u64)sigctx.regs;
-		if (regs->msr & MSR_FP )
-			giveup_fpu(current);
-		/* 
-		 * Copy the 32 bit register values off the user stack
-		 * into the 32 bit register area
-		 */
-		if (copy_from_user(saved_regs, &sr->gp_regs,sizeof(sr->gp_regs)))
-			goto badframe;
-		/*
-		 * The saved reg structure in the frame is an elf_grepset_t32,
-		 * it is a 32 bit register save of the registers in the
-		 * pt_regs structure that was stored on the kernel stack
-		 * during the system call when the system call was interrupted
-		 * for the signal. Only 32 bits are saved because the
-		 * sigcontext contains a pointer to the regs and the sig
-		 * context address is passed as a pointer to the signal
-		 * handler.  
-		 *
-		 * The entries in the elf_grepset have the same index as the
-		 * elements in the pt_regs structure.
-		 */
-		saved_regs[PT_MSR] = (regs->msr & ~MSR_USERCHANGE)
-			| (saved_regs[PT_MSR] & MSR_USERCHANGE);
-		/*
-		 * Register 2 is the kernel toc - should be reset on
-		 * any calls into the kernel 
-		 */
-		for (i = 0; i < 32; i++)
-			regs->gpr[i] = (u64)(saved_regs[i]) & 0xFFFFFFFF;
-
-		/*
-		 *  restore the non gpr registers 
-		 */
-		regs->msr = (u64)(saved_regs[PT_MSR]) & 0xFFFFFFFF;
-		/*
-		 * Insure that the interrupt mode is 64 bit, during 32 bit
-		 * execution. (This is necessary because we only saved
-		 * lower 32 bits of msr.)
-		 */
-		regs->msr = regs->msr | MSR_ISF;
-
-		regs->nip = (u64)(saved_regs[PT_NIP]) & 0xFFFFFFFF;
-		regs->orig_gpr3 = (u64)(saved_regs[PT_ORIG_R3]) & 0xFFFFFFFF; 
-		regs->ctr = (u64)(saved_regs[PT_CTR]) & 0xFFFFFFFF; 
-		regs->link = (u64)(saved_regs[PT_LNK]) & 0xFFFFFFFF; 
-		regs->xer = (u64)(saved_regs[PT_XER]) & 0xFFFFFFFF; 
-		regs->ccr = (u64)(saved_regs[PT_CCR]) & 0xFFFFFFFF;
-		/* regs->softe is left unchanged (like the MSR.EE bit) */
-		/******************************************************/
-		/* the DAR and the DSISR are only relevant during a   */
-		/*   data or instruction storage interrupt. The value */
-		/*   will be set to zero.                             */
-		/******************************************************/
-		regs->dar = 0; 
-		regs->dsisr = 0;
-		regs->result = (u64)(saved_regs[PT_RESULT]) & 0xFFFFFFFF;
+	sr = (struct sigregs32*)(u64)sigctx.regs;
+	/*
+	 * Copy the 32 bit register values off the user stack
+	 * into the 32 bit register area
+	 */
+	if (copy_from_user(saved_regs, &sr->gp_regs,sizeof(sr->gp_regs)))
+		goto badframe;
 
-		if (copy_from_user(current->thread.fpr, &sr->fp_regs, sizeof(sr->fp_regs)))
-			goto badframe;
+	/*
+	 * The saved reg structure in the frame is an elf_grepset_t32,
+	 * it is a 32 bit register save of the registers in the
+	 * pt_regs structure that was stored on the kernel stack
+	 * during the system call when the system call was interrupted
+	 * for the signal. Only 32 bits are saved because the
+	 * sigcontext contains a pointer to the regs and the sig
+	 * context address is passed as a pointer to the signal
+	 * handler.  
+	 *
+	 * The entries in the elf_grepset have the same index as the
+	 * elements in the pt_regs structure.
+	 */
+	for (i = 0; i < 32; i++)
+		regs->gpr[i] = (u64)(saved_regs[i]) & 0xFFFFFFFF;
 
-		ret = regs->result;
-	} else {
-		/* More signals to go */
-		regs->gpr[1] = (unsigned long)sc - __SIGNAL_FRAMESIZE32;
-		if (copy_from_user(&sigctx, sc, sizeof(sigctx)))
-			goto badframe;
-		sr = (struct sigregs32*)(u64)sigctx.regs;
-		regs->gpr[3] = ret = sigctx.signal;
-		regs->gpr[4] = (unsigned long) sc;
-		regs->link = (unsigned long) &sr->tramp;
-		regs->nip = sigctx.handler;
+	/*
+	 *  restore the non gpr registers 
+	 */
+	regs->nip = (u64)(saved_regs[PT_NIP]) & 0xFFFFFFFF;
+	regs->orig_gpr3 = (u64)(saved_regs[PT_ORIG_R3]) & 0xFFFFFFFF; 
+	regs->ctr = (u64)(saved_regs[PT_CTR]) & 0xFFFFFFFF; 
+	regs->link = (u64)(saved_regs[PT_LNK]) & 0xFFFFFFFF; 
+	regs->xer = (u64)(saved_regs[PT_XER]) & 0xFFFFFFFF; 
+	regs->ccr = (u64)(saved_regs[PT_CCR]) & 0xFFFFFFFF;
+	/* regs->softe is left unchanged (like the MSR.EE bit) */
+	regs->result = (u64)(saved_regs[PT_RESULT]) & 0xFFFFFFFF;
+
+	/* force the process to reload the FP registers from
+	   current->thread when it next does FP instructions */
+	regs->msr &= ~(MSR_FP | MSR_FE0 | MSR_FE1);
+#ifndef CONFIG_SMP
+	if (last_task_used_math == current)
+		last_task_used_math = NULL;
+#endif
+	if (copy_from_user(current->thread.fpr, &sr->fp_regs,
+			   sizeof(sr->fp_regs)))
+		goto badframe;
 
-		if (get_user(prevsp, &sr->gp_regs[PT_R1])
-		    || put_user(prevsp, (unsigned int*) regs->gpr[1]))
-			goto badframe;
-		current->thread.fpscr = 0;
-	}
-  
-	PPCDBG(PPCDBG_SIGNAL, "sys32_sigreturn - normal exit returning %ld - pid=%ld current=%lx comm=%s \n", ret, current->pid, current, current->comm);
-	return ret;
+	return regs->result;
 
 badframe:
-	PPCDBG(PPCDBG_SYS32NI, "sys32_sigreturn - badframe - pid=%ld current=%lx comm=%s \n", current->pid, current, current->comm);
-	do_exit(SIGSEGV);
+	force_sig(SIGSEGV, current);
+	return 0;
 }	
 
 /*
  * Set up a signal frame.
  */
 static void
-setup_frame32(struct pt_regs *regs, struct sigregs32 *frame,
-            unsigned int newsp)
+setup_frame32(struct pt_regs *regs, int sig, struct k_sigaction *ka,
+	      struct sigregs32 *frame, unsigned int newsp)
 {
-	struct sigcontext32 *sc = (struct sigcontext32 *)(u64)newsp;
 	int i;
 
 	if (verify_area(VERIFY_WRITE, frame, sizeof(*frame)))
@@ -425,30 +368,32 @@
 			   (unsigned long) &frame->tramp[2]);
 	current->thread.fpscr = 0;      /* turn off all fp exceptions */
 
-	newsp -= __SIGNAL_FRAMESIZE32;
-	if (put_user(regs->gpr[1], (u32*)(u64)newsp)
-	    || get_user(regs->nip, &sc->handler)
-	    || get_user(regs->gpr[3], &sc->signal))
-		goto badframe;
-
-	regs->gpr[1] = newsp & 0xFFFFFFFF;
 	/*
 	 * first parameter to the signal handler is the signal number
 	 *  - the value is in gpr3
 	 * second parameter to the signal handler is the sigcontext
 	 *   - set the value into gpr4
 	 */
-	regs->gpr[4] = (unsigned long) sc;
+	regs->gpr[3] = sig;
+	regs->gpr[4] = newsp;
+	regs->nip = (u64)ka->sa.sa_handler & 0xFFFFFFFF;
 	regs->link = (unsigned long) frame->tramp;
+
+	newsp -= __SIGNAL_FRAMESIZE32;
+	if (put_user(regs->gpr[1], (u32*)(u64)newsp))
+		goto badframe;
+	regs->gpr[1] = newsp;
+
 	return;
 
  badframe:
-	udbg_printf("setup_frame32 - badframe in setup_frame, regs=%p frame=%p newsp=%lx\n", regs, frame, newsp);  PPCDBG_ENTER_DEBUGGER();
 #if DEBUG_SIG
 	printk("badframe in setup_frame32, regs=%p frame=%p newsp=%lx\n",
 	       regs, frame, newsp);
 #endif
-	do_exit(SIGSEGV);
+	if (sig == SIGSEGV)
+		ka->sa.sa_handler = SIG_DFL;
+	force_sig(SIGSEGV, current);
 }
 
 
@@ -485,14 +430,12 @@
 	struct sigcontext32 sigctx;
 	struct sigregs32 *signalregs;
  
-	int i, ret;
+	int i;
 	elf_gregset_t32 saved_regs;   /* an array of 32 bit register values */
 	sigset_t signal_set; 
 	stack_t stack;
-	unsigned int previous_stack;
 
-	ret = 0;
-	/* Adjust the inputted reg1 to point to the first rt signal frame */
+	/* Adjust the inputted reg1 to point to the rt signal frame */
 	rt_stack_frame = (struct rt_sigframe_32 *)(regs->gpr[1] + __SIGNAL_FRAMESIZE32);
 	/* Copy the information from the user stack  */
 	if (copy_from_user(&sigctx, &rt_stack_frame->uc.uc_mcontext,sizeof(sigctx))
@@ -514,100 +457,54 @@
 	recalc_sigpending(current);
 	spin_unlock_irq(&current->sigmask_lock);
 
-	/* Set to point to the next rt_sigframe - this is used to determine whether this 
-	 *   is the last signal to process
-	 */
-	rt_stack_frame ++;
-
-	if (rt_stack_frame == (struct rt_sigframe_32 *)(u64)(sigctx.regs)) {
-		signalregs = (struct sigregs32 *) (u64)sigctx.regs;
-		/* If currently owning the floating point - give them up */
-		if (regs->msr & MSR_FP)
-			giveup_fpu(current);
+	signalregs = (struct sigregs32 *) (u64)sigctx.regs;
 
-		if (copy_from_user(saved_regs,&signalregs->gp_regs,sizeof(signalregs->gp_regs))) 
-			goto badframe;
-
-		/*
-		 * The saved reg structure in the frame is an elf_grepset_t32,
-		 * it is a 32 bit register save of the registers in the
-		 * pt_regs structure that was stored on the kernel stack
-		 * during the system call when the system call was interrupted
-		 * for the signal. Only 32 bits are saved because the
-		 * sigcontext contains a pointer to the regs and the sig
-		 * context address is passed as a pointer to the signal handler
-		 *
-		 * The entries in the elf_grepset have the same index as
-		 * the elements in the pt_regs structure.
-		 */
-		saved_regs[PT_MSR] = (regs->msr & ~MSR_USERCHANGE)
-			| (saved_regs[PT_MSR] & MSR_USERCHANGE);
-		/*
-		 * Register 2 is the kernel toc - should be reset on any
-		 * calls into the kernel
-		 */
-		for (i = 0; i < 32; i++)
-			regs->gpr[i] = (u64)(saved_regs[i]) & 0xFFFFFFFF;
-		/*
-		 * restore the non gpr registers
-		 */
-		regs->msr = (u64)(saved_regs[PT_MSR]) & 0xFFFFFFFF;
-		regs->nip = (u64)(saved_regs[PT_NIP]) & 0xFFFFFFFF;
-		regs->orig_gpr3 = (u64)(saved_regs[PT_ORIG_R3]) & 0xFFFFFFFF; 
-		regs->ctr = (u64)(saved_regs[PT_CTR]) & 0xFFFFFFFF; 
-		regs->link = (u64)(saved_regs[PT_LNK]) & 0xFFFFFFFF; 
-		regs->xer = (u64)(saved_regs[PT_XER]) & 0xFFFFFFFF; 
-		regs->ccr = (u64)(saved_regs[PT_CCR]) & 0xFFFFFFFF;
-		/* regs->softe is left unchanged (like MSR.EE) */
-		/*
-		 * the DAR and the DSISR are only relevant during a
-		 *   data or instruction storage interrupt. The value
-		 *   will be set to zero.
-		 */
-		regs->dar = 0; 
-		regs->dsisr = 0;
-		regs->result = (u64)(saved_regs[PT_RESULT]) & 0xFFFFFFFF;
-
-		if (copy_from_user(current->thread.fpr, &signalregs->fp_regs, sizeof(signalregs->fp_regs))) 
-			goto badframe;
-
-		ret = regs->result;
-	}
-	else  /* more signals to go  */
-	{
-		regs->gpr[1] = (u64)rt_stack_frame - __SIGNAL_FRAMESIZE32;
-		if (copy_from_user(&sigctx, &rt_stack_frame->uc.uc_mcontext,sizeof(sigctx)))
-		{
-			goto badframe;
-		}
-		signalregs = (struct sigregs32 *) (u64)sigctx.regs;
-		/* first parm to signal handler is the signal number */
-		regs->gpr[3] = ret = sigctx.signal;
-		/* second parm is a pointer to sig info */
-		get_user(regs->gpr[4], &rt_stack_frame->pinfo);
-		/* third parm is a pointer to the ucontext */
-		get_user(regs->gpr[5], &rt_stack_frame->puc);
-		/* fourth parm is the stack frame */
-		regs->gpr[6] = (u64)rt_stack_frame;
-		/* Set up link register to return to sigreturn when the */
-		/*  signal handler completes */
-		regs->link = (u64)&signalregs->tramp;
-		/* Set next instruction to the start fo the signal handler */
-		regs->nip = sigctx.handler;
-		/* Set the reg1 to look like a call to the signal handler */
-		if (get_user(previous_stack,&signalregs->gp_regs[PT_R1])
-		    || put_user(previous_stack, (unsigned long *)regs->gpr[1]))
-		{
-			goto badframe;
-		}
-		current->thread.fpscr = 0;
+	if (copy_from_user(saved_regs, &signalregs->gp_regs,
+			   sizeof(signalregs->gp_regs))) 
+		goto badframe;
 
-	}
+	/*
+	 * The saved reg structure in the frame is an elf_grepset_t32,
+	 * it is a 32 bit register save of the registers in the
+	 * pt_regs structure that was stored on the kernel stack
+	 * during the system call when the system call was interrupted
+	 * for the signal. Only 32 bits are saved because the
+	 * sigcontext contains a pointer to the regs and the sig
+	 * context address is passed as a pointer to the signal handler
+	 *
+	 * The entries in the elf_grepset have the same index as
+	 * the elements in the pt_regs structure.
+	 */
+	for (i = 0; i < 32; i++)
+		regs->gpr[i] = (u64)(saved_regs[i]) & 0xFFFFFFFF;
+	/*
+	 * restore the non gpr registers
+	 */
+	regs->nip = (u64)(saved_regs[PT_NIP]) & 0xFFFFFFFF;
+	regs->orig_gpr3 = (u64)(saved_regs[PT_ORIG_R3]) & 0xFFFFFFFF; 
+	regs->ctr = (u64)(saved_regs[PT_CTR]) & 0xFFFFFFFF; 
+	regs->link = (u64)(saved_regs[PT_LNK]) & 0xFFFFFFFF; 
+	regs->xer = (u64)(saved_regs[PT_XER]) & 0xFFFFFFFF; 
+	regs->ccr = (u64)(saved_regs[PT_CCR]) & 0xFFFFFFFF;
+	/* regs->softe is left unchanged (like MSR.EE) */
+	regs->result = (u64)(saved_regs[PT_RESULT]) & 0xFFFFFFFF;
+
+	/* force the process to reload the FP registers from
+	   current->thread when it next does FP instructions */
+	regs->msr &= ~(MSR_FP | MSR_FE0 | MSR_FE1);
+#ifndef CONFIG_SMP
+	if (last_task_used_math == current)
+		last_task_used_math = NULL;
+#endif
+	if (copy_from_user(current->thread.fpr, &signalregs->fp_regs,
+			   sizeof(signalregs->fp_regs))) 
+		goto badframe;
 
-	return ret;
+	return regs->result;
 
  badframe:
-	do_exit(SIGSEGV);     
+	force_sig(SIGSEGV, current);
+	return 0;
 }
 
 
@@ -617,15 +514,14 @@
 	struct k_sigaction new_ka, old_ka;
 	int ret;
 	sigset32_t set32;
-
-	PPCDBG(PPCDBG_SIGNAL, "sys32_rt_sigaction - entered - sig=%x \n", sig);
+	u32 handler;
 
 	/* XXX: Don't preclude handling different sized sigset_t's.  */
 	if (sigsetsize != sizeof(sigset32_t))
 		return -EINVAL;
 
 	if (act) {
-		ret = get_user((long)new_ka.sa.sa_handler, &act->sa_handler);
+		ret = get_user(handler, &act->sa_handler);
 		ret |= __copy_from_user(&set32, &act->sa_mask,
 					sizeof(sigset32_t));
 		switch (_NSIG_WORDS) {
@@ -643,6 +539,7 @@
 		
 		if (ret)
 			return -EFAULT;
+		new_ka.sa.sa_handler = (__sighandler_t)(long) handler;
 	}
 
 	ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
@@ -668,9 +565,7 @@
 		ret |= __put_user(old_ka.sa.sa_flags, &oact->sa_flags);
 	}
 
-  
-	PPCDBG(PPCDBG_SIGNAL, "sys32_rt_sigaction - exiting - sig=%x \n", sig);
-	return ret;
+  	return ret;
 }
 
 
@@ -691,8 +586,6 @@
 	int ret;
 	mm_segment_t old_fs = get_fs();
 
-	PPCDBG(PPCDBG_SIGNAL, "sys32_rt_sigprocmask - entered how=%x \n", (int)how);
-	
 	if (set) {
 		if (copy_from_user (&s32, set, sizeof(sigset32_t)))
 			return -EFAULT;
@@ -779,7 +672,7 @@
 	case SIGBUS:
 	case SIGFPE:
 	case SIGILL:
-		d->si_addr = (unsigned int)(s->si_addr);
+		d->si_addr = (unsigned int)(u64)(s->si_addr);
         break;
 	case SIGPOLL:
 		d->si_band = s->si_band;
@@ -943,7 +836,7 @@
 	regs->gpr[3] = EINTR;
 	regs->ccr |= 0x10000000;
 	while (1) {
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule();
 		if (do_signal(&saveset, regs))
 			/*
@@ -963,10 +856,9 @@
  * Set up a rt signal frame.
  */
 static void
-setup_rt_frame32(struct pt_regs *regs, struct sigregs32 *frame,
-            unsigned int newsp)
+setup_rt_frame32(struct pt_regs *regs, int sig, struct k_sigaction *ka,
+		 struct sigregs32 *frame, unsigned int newsp)
 {
-	unsigned int copyreg4,copyreg5;
 	struct rt_sigframe_32 * rt_sf = (struct rt_sigframe_32 *) (u64)newsp;
 	int i;
   
@@ -1013,34 +905,31 @@
 	current->thread.fpscr = 0;	/* turn off all fp exceptions */
   
 	/*
-	 * Retrieve rt_sigframe from stack and
-	 * set up registers for signal handler
-	*/
+	 * Set up registers for signal handler
+	 */
 	newsp -= __SIGNAL_FRAMESIZE32;
-      
-
-	if (put_user((u32)(regs->gpr[1]), (unsigned int *)(u64)newsp)
-	    || get_user(regs->nip, &rt_sf->uc.uc_mcontext.handler)
-	    || get_user(regs->gpr[3], &rt_sf->uc.uc_mcontext.signal)
-	    || get_user(copyreg4, &rt_sf->pinfo)
-	    || get_user(copyreg5, &rt_sf->puc))
-		goto badframe;
 
-	regs->gpr[4] = copyreg4;
-	regs->gpr[5] = copyreg5;
 	regs->gpr[1] = newsp;
+	regs->gpr[3] = sig;
+	regs->gpr[4] = (unsigned long) &rt_sf->info;
+	regs->gpr[5] = (unsigned long) &rt_sf->uc;
 	regs->gpr[6] = (unsigned long) rt_sf;
-	regs->link = (unsigned long) frame->tramp;
+	regs->nip    = (unsigned long) ka->sa.sa_handler;
+	regs->link   = (unsigned long) frame->tramp;
+
+	if (put_user((u32)(regs->gpr[1]), (unsigned int *)(u64)newsp))
+		goto badframe;
 
 	return;
 
  badframe:
-	udbg_printf("setup_frame32 - badframe in setup_frame, regs=%p frame=%p newsp=%lx\n", regs, frame, newsp);  PPCDBG_ENTER_DEBUGGER();
 #if DEBUG_SIG
-	printk("badframe in setup_frame32, regs=%p frame=%p newsp=%lx\n",
+	printk("badframe in setup_rt_frame32, regs=%p frame=%p newsp=%lx\n",
 	       regs, frame, newsp);
 #endif
-	do_exit(SIGSEGV);
+	if (sig == SIGSEGV)
+		ka->sa.sa_handler = SIG_DFL;
+	force_sig(SIGSEGV, current);
 }
 
 
@@ -1131,7 +1020,9 @@
 	       regs, frame, *newspp);
 	printk("sc=%p sig=%d ka=%p info=%p oldset=%p\n", sc, sig, ka, info, oldset);
 #endif
-	do_exit(SIGSEGV);
+	if (sig == SIGSEGV)
+		ka->sa.sa_handler = SIG_DFL;
+	force_sig(SIGSEGV, current);
 }
 
 
@@ -1150,6 +1041,8 @@
 	int ret;
 	mm_segment_t old_fs;
 	unsigned long sp;
+	u32 sssp;
+	stack_32_t *ustack;
 
 	/*
 	 * set sp to the user stack on entry to the system call
@@ -1157,21 +1050,26 @@
 	 */
 	sp = regs->gpr[1];
 
-	/*  Put new stack info in local 64 bit stack struct                      */ 
-	if (newstack && (get_user((long)uss.ss_sp, &((stack_32_t *)(long)newstack)->ss_sp) ||
-			 __get_user(uss.ss_flags, &((stack_32_t *)(long)newstack)->ss_flags) ||
-			 __get_user(uss.ss_size, &((stack_32_t *)(long)newstack)->ss_size)))
+	/*  Put new stack info in local 64 bit stack struct */ 
+	ustack = (stack_32_t *)(long) newstack;
+	if (newstack && (get_user(sssp, &ustack->ss_sp) ||
+			 __get_user(uss.ss_flags, &ustack->ss_flags) ||
+			 __get_user(uss.ss_size, &ustack->ss_size)))
 		return -EFAULT; 
-
+	uss.ss_sp = (void *)(long) sssp;
    
 	old_fs = get_fs();
 	set_fs(KERNEL_DS);
 	ret = do_sigaltstack(newstack ? &uss : NULL, oldstack ? &uoss : NULL, sp);
 	set_fs(old_fs);
-	/* Copy the stack information to the user output buffer                  */
-	if (!ret && oldstack  && (put_user((long)uoss.ss_sp, &((stack_32_t *)(long)oldstack)->ss_sp) ||
-				  __put_user(uoss.ss_flags, &((stack_32_t *)(long)oldstack)->ss_flags) ||
-				  __put_user(uoss.ss_size, &((stack_32_t *)(long)oldstack)->ss_size)))
+	if (ret)
+		return ret;
+
+	/* Copy the stack information to the user output buffer */
+	ustack = (stack_32_t *)(long) oldstack;
+	if (oldstack && (put_user((long)uoss.ss_sp, &ustack->ss_sp) ||
+			 __put_user(uoss.ss_flags, &ustack->ss_flags) ||
+			 __put_user(uoss.ss_size, &ustack->ss_size)))
 		return -EFAULT;
 	return ret;
 }
@@ -1198,6 +1096,7 @@
 	siginfo_t info;
 	struct k_sigaction *ka;
 	unsigned int frame, newsp;
+	unsigned long signr = 0;
 
 	if (!oldset)
 		oldset = &current->blocked;
@@ -1205,15 +1104,9 @@
 	newsp = frame = 0;
 
 	for (;;) {
-		unsigned long signr;
-		
 		spin_lock_irq(&current->sigmask_lock);
 		signr = dequeue_signal(&current->blocked, &info);
 		spin_unlock_irq(&current->sigmask_lock);
-		ifppcdebug(PPCDBG_SYS32) {
-			if (signr)
-				udbg_printf("do_signal32 - processing signal=%2lx - pid=%ld, comm=%s \n", signr, current->pid, current->comm);
-		}
 
 		if (!signr)
 			break;
@@ -1298,14 +1191,6 @@
 			}
 		}
 
-		PPCDBG(PPCDBG_SIGNAL, " do signal :sigaction flags = %lx \n" ,ka->sa.sa_flags);
-		PPCDBG(PPCDBG_SIGNAL, " do signal :on sig stack  = %lx \n" ,on_sig_stack(regs->gpr[1]));
-		PPCDBG(PPCDBG_SIGNAL, " do signal :reg1  = %lx \n" ,regs->gpr[1]);
-		PPCDBG(PPCDBG_SIGNAL, " do signal :alt stack  = %lx \n" ,current->sas_ss_sp);
-		PPCDBG(PPCDBG_SIGNAL, " do signal :alt stack size  = %lx \n" ,current->sas_ss_size);
-
-
-
 		if ( (ka->sa.sa_flags & SA_ONSTACK)
 		     && (! on_sig_stack(regs->gpr[1])))
 			newsp = (current->sas_ss_sp + current->sas_ss_size);
@@ -1333,8 +1218,10 @@
 
 	/* Invoke correct stack setup routine */
 	if (ka->sa.sa_flags & SA_SIGINFO) 
-		setup_rt_frame32(regs, (struct sigregs32*)(u64)frame, newsp);
+		setup_rt_frame32(regs, signr, ka,
+				 (struct sigregs32*)(u64)frame, newsp);
 	else
-		setup_frame32(regs, (struct sigregs32*)(u64)frame, newsp);
+		setup_frame32(regs, signr, ka,
+			      (struct sigregs32*)(u64)frame, newsp);
 	return 1;
 }
