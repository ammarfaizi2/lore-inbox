Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261945AbVDKWEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261945AbVDKWEH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 18:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261944AbVDKWEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 18:04:07 -0400
Received: from de01egw01.freescale.net ([192.88.165.102]:50584 "EHLO
	de01egw01.freescale.net") by vger.kernel.org with ESMTP
	id S261945AbVDKWDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 18:03:16 -0400
Date: Mon, 11 Apr 2005 17:02:37 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@blarg.somerset.sps.mot.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
       linuxppc-dev@ozlabs.org, Jason McMullan <jason.mcmullan@timesys.com>
Subject: [PATCH] ppc32: refactor FPU exception handling
Message-ID: <Pine.LNX.4.61.0504111639330.10171@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Moved common FPU exception handling code out of head.S so it can be used 
by several of the sub-architectures that might of a full PowerPC FPU.  

Also, uses new CONFIG_PPC_FPU define to fix alignment exception 
handling for floating point load/store instructions to only occur if we 
have a hardware FPU.

Signed-off-by: Jason McMullan <jason.mcmullan@timesys.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---

diff -Nru a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig	2005-04-11 17:00:36 -05:00
+++ b/arch/ppc/Kconfig	2005-04-11 17:00:36 -05:00
@@ -53,6 +53,7 @@
 
 config 6xx
 	bool "6xx/7xx/74xx/52xx/82xx/83xx"
+	select PPC_FPU
 	help
 	  There are four types of PowerPC chips supported.  The more common
 	  types (601, 603, 604, 740, 750, 7400), the Motorola embedded
@@ -85,6 +86,9 @@
 	bool "e500"
 
 endchoice
+
+config PPC_FPU
+	bool
 
 config BOOKE
 	bool
diff -Nru a/arch/ppc/Makefile b/arch/ppc/Makefile
--- a/arch/ppc/Makefile	2005-04-11 17:00:36 -05:00
+++ b/arch/ppc/Makefile	2005-04-11 17:00:36 -05:00
@@ -53,6 +53,7 @@
 
 head-$(CONFIG_6xx)		+= arch/ppc/kernel/idle_6xx.o
 head-$(CONFIG_POWER4)		+= arch/ppc/kernel/idle_power4.o
+head-$(CONFIG_PPC_FPU)		+= arch/ppc/kernel/fpu.o
 
 core-y				+= arch/ppc/kernel/ arch/ppc/platforms/ \
 				   arch/ppc/mm/ arch/ppc/lib/ arch/ppc/syslib/
diff -Nru a/arch/ppc/kernel/Makefile b/arch/ppc/kernel/Makefile
--- a/arch/ppc/kernel/Makefile	2005-04-11 17:00:36 -05:00
+++ b/arch/ppc/kernel/Makefile	2005-04-11 17:00:36 -05:00
@@ -9,6 +9,7 @@
 extra-$(CONFIG_8xx)		:= head_8xx.o
 extra-$(CONFIG_6xx)		+= idle_6xx.o
 extra-$(CONFIG_POWER4)		+= idle_power4.o
+extra-$(CONFIG_PPC_FPU)		+= fpu.o
 extra-y				+= vmlinux.lds
 
 obj-y				:= entry.o traps.o irq.o idle.o time.o misc.o \
diff -Nru a/arch/ppc/kernel/align.c b/arch/ppc/kernel/align.c
--- a/arch/ppc/kernel/align.c	2005-04-11 17:00:36 -05:00
+++ b/arch/ppc/kernel/align.c	2005-04-11 17:00:36 -05:00
@@ -368,16 +368,24 @@
 
 	/* Single-precision FP load and store require conversions... */
 	case LD+F+S:
+#ifdef CONFIG_PPC_FPU
 		preempt_disable();
 		enable_kernel_fp();
 		cvt_fd(&data.f, &data.d, &current->thread.fpscr);
 		preempt_enable();
+#else
+		return 0;
+#endif
 		break;
 	case ST+F+S:
+#ifdef CONFIG_PPC_FPU
 		preempt_disable();
 		enable_kernel_fp();
 		cvt_df(&data.d, &data.f, &current->thread.fpscr);
 		preempt_enable();
+#else
+		return 0;
+#endif
 		break;
 	}
 
diff -Nru a/arch/ppc/kernel/fpu.S b/arch/ppc/kernel/fpu.S
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/kernel/fpu.S	2005-04-11 17:00:36 -05:00
@@ -0,0 +1,190 @@
+/*
+ *  FPU support code, moved here from head.S so that it can be used
+ *  by chips which use other head-whatever.S files.
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ *
+ */
+
+#include <linux/config.h>
+#include <asm/processor.h>
+#include <asm/page.h>
+#include <asm/mmu.h>
+#include <asm/pgtable.h>
+#include <asm/cputable.h>
+#include <asm/cache.h>
+#include <asm/thread_info.h>
+#include <asm/ppc_asm.h>
+#include <asm/offsets.h>
+
+/*
+ * This task wants to use the FPU now.
+ * On UP, disable FP for the task which had the FPU previously,
+ * and save its floating-point registers in its thread_struct.
+ * Load up this task's FP registers from its thread_struct,
+ * enable the FPU for the current task and return to the task.
+ */
+	.globl	load_up_fpu
+load_up_fpu:
+	mfmsr	r5
+	ori	r5,r5,MSR_FP
+#ifdef CONFIG_PPC64BRIDGE
+	clrldi	r5,r5,1			/* turn off 64-bit mode */
+#endif /* CONFIG_PPC64BRIDGE */
+	SYNC
+	MTMSRD(r5)			/* enable use of fpu now */
+	isync
+/*
+ * For SMP, we don't do lazy FPU switching because it just gets too
+ * horrendously complex, especially when a task switches from one CPU
+ * to another.  Instead we call giveup_fpu in switch_to.
+ */
+#ifndef CONFIG_SMP
+	tophys(r6,0)			/* get __pa constant */
+	addis	r3,r6,last_task_used_math@ha
+	lwz	r4,last_task_used_math@l(r3)
+	cmpwi	0,r4,0
+	beq	1f
+	add	r4,r4,r6
+	addi	r4,r4,THREAD		/* want last_task_used_math->thread */
+	SAVE_32FPRS(0, r4)
+	mffs	fr0
+	stfd	fr0,THREAD_FPSCR-4(r4)
+	lwz	r5,PT_REGS(r4)
+	add	r5,r5,r6
+	lwz	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
+	li	r10,MSR_FP|MSR_FE0|MSR_FE1
+	andc	r4,r4,r10		/* disable FP for previous task */
+	stw	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
+1:
+#endif /* CONFIG_SMP */
+	/* enable use of FP after return */
+	mfspr	r5,SPRN_SPRG3		/* current task's THREAD (phys) */
+	lwz	r4,THREAD_FPEXC_MODE(r5)
+	ori	r9,r9,MSR_FP		/* enable FP for current */
+	or	r9,r9,r4
+	lfd	fr0,THREAD_FPSCR-4(r5)
+	mtfsf	0xff,fr0
+	REST_32FPRS(0, r5)
+#ifndef CONFIG_SMP
+	subi	r4,r5,THREAD
+	sub	r4,r4,r6
+	stw	r4,last_task_used_math@l(r3)
+#endif /* CONFIG_SMP */
+	/* restore registers and return */
+	/* we haven't used ctr or xer or lr */
+	/* fall through to fast_exception_return */
+
+	.globl	fast_exception_return
+fast_exception_return:
+#if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
+	andi.	r10,r9,MSR_RI		/* check for recoverable interrupt */
+	beq	1f			/* if not, we've got problems */
+#endif
+
+2:	REST_4GPRS(3, r11)
+	lwz	r10,_CCR(r11)
+	REST_GPR(1, r11)
+	mtcr	r10
+	lwz	r10,_LINK(r11)
+	mtlr	r10
+	REST_GPR(10, r11)
+	mtspr	SPRN_SRR1,r9
+	mtspr	SPRN_SRR0,r12
+	REST_GPR(9, r11)
+	REST_GPR(12, r11)
+	lwz	r11,GPR11(r11)
+	SYNC
+	RFI
+
+/* check if the exception happened in a restartable section */
+1:	lis	r3,exc_exit_restart_end@ha
+	addi	r3,r3,exc_exit_restart_end@l
+	cmplw	r12,r3
+	bge	3f
+	lis	r4,exc_exit_restart@ha
+	addi	r4,r4,exc_exit_restart@l
+	cmplw	r12,r4
+	blt	3f
+	lis	r3,fee_restarts@ha
+	tophys(r3,r3)
+	lwz	r5,fee_restarts@l(r3)
+	addi	r5,r5,1
+	stw	r5,fee_restarts@l(r3)
+	mr	r12,r4		/* restart at exc_exit_restart */
+	b	2b
+
+	.comm	fee_restarts,4
+
+/* aargh, a nonrecoverable interrupt, panic */
+/* aargh, we don't know which trap this is */
+/* but the 601 doesn't implement the RI bit, so assume it's OK */
+3:
+BEGIN_FTR_SECTION
+	b	2b
+END_FTR_SECTION_IFSET(CPU_FTR_601)
+	li	r10,-1
+	stw	r10,TRAP(r11)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	lis	r10,MSR_KERNEL@h
+	ori	r10,r10,MSR_KERNEL@l
+	bl	transfer_to_handler_full
+	.long	nonrecoverable_exception
+	.long	ret_from_except
+
+/*
+ * FP unavailable trap from kernel - print a message, but let
+ * the task use FP in the kernel until it returns to user mode.
+ */
+ 	.globl	KernelFP
+KernelFP:
+	lwz	r3,_MSR(r1)
+	ori	r3,r3,MSR_FP
+	stw	r3,_MSR(r1)		/* enable use of FP after return */
+	lis	r3,86f@h
+	ori	r3,r3,86f@l
+	mr	r4,r2			/* current */
+	lwz	r5,_NIP(r1)
+	bl	printk
+	b	ret_from_except
+86:	.string	"floating point used in kernel (task=%p, pc=%x)\n"
+	.align	4,0
+
+/*
+ * giveup_fpu(tsk)
+ * Disable FP for the task given as the argument,
+ * and save the floating-point registers in its thread_struct.
+ * Enables the FPU for use in the kernel on return.
+ */
+	.globl	giveup_fpu
+giveup_fpu:
+	mfmsr	r5
+	ori	r5,r5,MSR_FP
+	SYNC_601
+	ISYNC_601
+	MTMSRD(r5)			/* enable use of fpu now */
+	SYNC_601
+	isync
+	cmpwi	0,r3,0
+	beqlr-				/* if no previous owner, done */
+	addi	r3,r3,THREAD	        /* want THREAD of task */
+	lwz	r5,PT_REGS(r3)
+	cmpwi	0,r5,0
+	SAVE_32FPRS(0, r3)
+	mffs	fr0
+	stfd	fr0,THREAD_FPSCR-4(r3)
+	beq	1f
+	lwz	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
+	li	r3,MSR_FP|MSR_FE0|MSR_FE1
+	andc	r4,r4,r3		/* disable FP for previous task */
+	stw	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
+1:
+#ifndef CONFIG_SMP
+	li	r5,0
+	lis	r4,last_task_used_math@ha
+	stw	r5,last_task_used_math@l(r4)
+#endif /* CONFIG_SMP */
+	blr
diff -Nru a/arch/ppc/kernel/head.S b/arch/ppc/kernel/head.S
--- a/arch/ppc/kernel/head.S	2005-04-11 17:00:36 -05:00
+++ b/arch/ppc/kernel/head.S	2005-04-11 17:00:36 -05:00
@@ -775,133 +775,6 @@
 	EXC_XFER_STD(0x480, UnknownException)
 #endif /* CONFIG_PPC64BRIDGE */
 
-/*
- * This task wants to use the FPU now.
- * On UP, disable FP for the task which had the FPU previously,
- * and save its floating-point registers in its thread_struct.
- * Load up this task's FP registers from its thread_struct,
- * enable the FPU for the current task and return to the task.
- */
-load_up_fpu:
-	mfmsr	r5
-	ori	r5,r5,MSR_FP
-#ifdef CONFIG_PPC64BRIDGE
-	clrldi	r5,r5,1			/* turn off 64-bit mode */
-#endif /* CONFIG_PPC64BRIDGE */
-	SYNC
-	MTMSRD(r5)			/* enable use of fpu now */
-	isync
-/*
- * For SMP, we don't do lazy FPU switching because it just gets too
- * horrendously complex, especially when a task switches from one CPU
- * to another.  Instead we call giveup_fpu in switch_to.
- */
-#ifndef CONFIG_SMP
-	tophys(r6,0)			/* get __pa constant */
-	addis	r3,r6,last_task_used_math@ha
-	lwz	r4,last_task_used_math@l(r3)
-	cmpwi	0,r4,0
-	beq	1f
-	add	r4,r4,r6
-	addi	r4,r4,THREAD		/* want last_task_used_math->thread */
-	SAVE_32FPRS(0, r4)
-	mffs	fr0
-	stfd	fr0,THREAD_FPSCR-4(r4)
-	lwz	r5,PT_REGS(r4)
-	add	r5,r5,r6
-	lwz	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
-	li	r10,MSR_FP|MSR_FE0|MSR_FE1
-	andc	r4,r4,r10		/* disable FP for previous task */
-	stw	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
-1:
-#endif /* CONFIG_SMP */
-	/* enable use of FP after return */
-	mfspr	r5,SPRN_SPRG3		/* current task's THREAD (phys) */
-	lwz	r4,THREAD_FPEXC_MODE(r5)
-	ori	r9,r9,MSR_FP		/* enable FP for current */
-	or	r9,r9,r4
-	lfd	fr0,THREAD_FPSCR-4(r5)
-	mtfsf	0xff,fr0
-	REST_32FPRS(0, r5)
-#ifndef CONFIG_SMP
-	subi	r4,r5,THREAD
-	sub	r4,r4,r6
-	stw	r4,last_task_used_math@l(r3)
-#endif /* CONFIG_SMP */
-	/* restore registers and return */
-	/* we haven't used ctr or xer or lr */
-	/* fall through to fast_exception_return */
-
-	.globl	fast_exception_return
-fast_exception_return:
-	andi.	r10,r9,MSR_RI		/* check for recoverable interrupt */
-	beq	1f			/* if not, we've got problems */
-2:	REST_4GPRS(3, r11)
-	lwz	r10,_CCR(r11)
-	REST_GPR(1, r11)
-	mtcr	r10
-	lwz	r10,_LINK(r11)
-	mtlr	r10
-	REST_GPR(10, r11)
-	mtspr	SPRN_SRR1,r9
-	mtspr	SPRN_SRR0,r12
-	REST_GPR(9, r11)
-	REST_GPR(12, r11)
-	lwz	r11,GPR11(r11)
-	SYNC
-	RFI
-
-/* check if the exception happened in a restartable section */
-1:	lis	r3,exc_exit_restart_end@ha
-	addi	r3,r3,exc_exit_restart_end@l
-	cmplw	r12,r3
-	bge	3f
-	lis	r4,exc_exit_restart@ha
-	addi	r4,r4,exc_exit_restart@l
-	cmplw	r12,r4
-	blt	3f
-	lis	r3,fee_restarts@ha
-	tophys(r3,r3)
-	lwz	r5,fee_restarts@l(r3)
-	addi	r5,r5,1
-	stw	r5,fee_restarts@l(r3)
-	mr	r12,r4		/* restart at exc_exit_restart */
-	b	2b
-
-	.comm	fee_restarts,4
-
-/* aargh, a nonrecoverable interrupt, panic */
-/* aargh, we don't know which trap this is */
-/* but the 601 doesn't implement the RI bit, so assume it's OK */
-3:
-BEGIN_FTR_SECTION
-	b	2b
-END_FTR_SECTION_IFSET(CPU_FTR_601)
-	li	r10,-1
-	stw	r10,TRAP(r11)
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	li	r10,MSR_KERNEL
-	bl	transfer_to_handler_full
-	.long	nonrecoverable_exception
-	.long	ret_from_except
-
-/*
- * FP unavailable trap from kernel - print a message, but let
- * the task use FP in the kernel until it returns to user mode.
- */
-KernelFP:
-	lwz	r3,_MSR(r1)
-	ori	r3,r3,MSR_FP
-	stw	r3,_MSR(r1)		/* enable use of FP after return */
-	lis	r3,86f@h
-	ori	r3,r3,86f@l
-	mr	r4,r2			/* current */
-	lwz	r5,_NIP(r1)
-	bl	printk
-	b	ret_from_except
-86:	.string	"floating point used in kernel (task=%p, pc=%x)\n"
-	.align	4,0
-
 #ifdef CONFIG_ALTIVEC
 /* Note that the AltiVec support is closely modeled after the FP
  * support.  Changes to one are likely to be applicable to the
@@ -1014,42 +887,6 @@
 #endif /* CONFIG_SMP */
 	blr
 #endif /* CONFIG_ALTIVEC */
-
-/*
- * giveup_fpu(tsk)
- * Disable FP for the task given as the argument,
- * and save the floating-point registers in its thread_struct.
- * Enables the FPU for use in the kernel on return.
- */
-	.globl	giveup_fpu
-giveup_fpu:
-	mfmsr	r5
-	ori	r5,r5,MSR_FP
-	SYNC_601
-	ISYNC_601
-	MTMSRD(r5)			/* enable use of fpu now */
-	SYNC_601
-	isync
-	cmpwi	0,r3,0
-	beqlr-				/* if no previous owner, done */
-	addi	r3,r3,THREAD	        /* want THREAD of task */
-	lwz	r5,PT_REGS(r3)
-	cmpwi	0,r5,0
-	SAVE_32FPRS(0, r3)
-	mffs	fr0
-	stfd	fr0,THREAD_FPSCR-4(r3)
-	beq	1f
-	lwz	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
-	li	r3,MSR_FP|MSR_FE0|MSR_FE1
-	andc	r4,r4,r3		/* disable FP for previous task */
-	stw	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
-1:
-#ifndef CONFIG_SMP
-	li	r5,0
-	lis	r4,last_task_used_math@ha
-	stw	r5,last_task_used_math@l(r4)
-#endif /* CONFIG_SMP */
-	blr
 
 /*
  * This code is jumped to from the startup code to copy
diff -Nru a/arch/ppc/kernel/head_44x.S b/arch/ppc/kernel/head_44x.S
--- a/arch/ppc/kernel/head_44x.S	2005-04-11 17:00:36 -05:00
+++ b/arch/ppc/kernel/head_44x.S	2005-04-11 17:00:36 -05:00
@@ -426,7 +426,11 @@
 	PROGRAM_EXCEPTION
 
 	/* Floating Point Unavailable Interrupt */
+#ifdef CONFIG_PPC_FPU
+	FP_UNAVAILABLE_EXCEPTION
+#else
 	EXCEPTION(0x2010, FloatingPointUnavailable, UnknownException, EXC_XFER_EE)
+#endif
 
 	/* System Call Interrupt */
 	START_EXCEPTION(SystemCall)
@@ -686,9 +690,11 @@
  *
  * The 44x core does not have an FPU.
  */
+#ifndef CONFIG_PPC_FPU
 _GLOBAL(giveup_fpu)
 	blr
-
+#endif
+
 /*
  * extern void abort(void)
  *
diff -Nru a/arch/ppc/kernel/head_booke.h b/arch/ppc/kernel/head_booke.h
--- a/arch/ppc/kernel/head_booke.h	2005-04-11 17:00:36 -05:00
+++ b/arch/ppc/kernel/head_booke.h	2005-04-11 17:00:36 -05:00
@@ -337,4 +337,11 @@
 	addi    r3,r1,STACK_FRAME_OVERHEAD;				      \
 	EXC_XFER_LITE(0x0900, timer_interrupt)
 
+#define FP_UNAVAILABLE_EXCEPTION					      \
+	START_EXCEPTION(FloatingPointUnavailable)			      \
+	NORMAL_EXCEPTION_PROLOG;					      \
+	bne	load_up_fpu;		/* if from user, just load it up */   \
+	addi	r3,r1,STACK_FRAME_OVERHEAD;				      \
+	EXC_XFER_EE_LITE(0x800, KernelFP)
+
 #endif /* __HEAD_BOOKE_H__ */
diff -Nru a/arch/ppc/kernel/head_fsl_booke.S b/arch/ppc/kernel/head_fsl_booke.S
--- a/arch/ppc/kernel/head_fsl_booke.S	2005-04-11 17:00:36 -05:00
+++ b/arch/ppc/kernel/head_fsl_booke.S	2005-04-11 17:00:36 -05:00
@@ -477,7 +477,11 @@
 	PROGRAM_EXCEPTION
 
 	/* Floating Point Unavailable Interrupt */
+#ifdef CONFIG_PPC_FPU
+	FP_UNAVAILABLE_EXCEPTION
+#else
 	EXCEPTION(0x0800, FloatingPointUnavailable, UnknownException, EXC_XFER_EE)
+#endif
 
 	/* System Call Interrupt */
 	START_EXCEPTION(SystemCall)
@@ -883,10 +887,12 @@
 /*
  * extern void giveup_fpu(struct task_struct *prev)
  *
- * The e500 core does not have an FPU.
+ * Not all FSL Book-E cores have an FPU
  */
+#ifndef CONFIG_PPC_FPU
 _GLOBAL(giveup_fpu)
 	blr
+#endif
 
 /*
  * extern void abort(void)
diff -Nru a/arch/ppc/kernel/misc.S b/arch/ppc/kernel/misc.S
--- a/arch/ppc/kernel/misc.S	2005-04-11 17:00:36 -05:00
+++ b/arch/ppc/kernel/misc.S	2005-04-11 17:00:36 -05:00
@@ -1096,17 +1096,7 @@
  * and exceptions as if the cpu had performed the load or store.
  */
 
-#if defined(CONFIG_4xx) || defined(CONFIG_E500)
-_GLOBAL(cvt_fd)
-	lfs	0,0(r3)
-	stfd	0,0(r4)
-	blr
-
-_GLOBAL(cvt_df)
-	lfd	0,0(r3)
-	stfs	0,0(r4)
-	blr
-#else
+#ifdef CONFIG_PPC_FPU
 _GLOBAL(cvt_fd)
 	lfd	0,-4(r5)	/* load up fpscr value */
 	mtfsf	0xff,0
diff -Nru a/arch/ppc/kernel/traps.c b/arch/ppc/kernel/traps.c
--- a/arch/ppc/kernel/traps.c	2005-04-11 17:00:36 -05:00
+++ b/arch/ppc/kernel/traps.c	2005-04-11 17:00:36 -05:00
@@ -176,7 +176,7 @@
 #else
 #define get_mc_reason(regs)	(mfspr(SPRN_MCSR))
 #endif
-#define REASON_FP		0
+#define REASON_FP		ESR_FP
 #define REASON_ILLEGAL		ESR_PIL
 #define REASON_PRIVILEGED	ESR_PPR
 #define REASON_TRAP		ESR_PTR
diff -Nru a/include/asm-ppc/reg_booke.h b/include/asm-ppc/reg_booke.h
--- a/include/asm-ppc/reg_booke.h	2005-04-11 17:00:36 -05:00
+++ b/include/asm-ppc/reg_booke.h	2005-04-11 17:00:36 -05:00
@@ -304,6 +304,7 @@
 #define ESR_PIL		0x08000000	/* Program Exception - Illegal */
 #define ESR_PPR		0x04000000	/* Program Exception - Priveleged */
 #define ESR_PTR		0x02000000	/* Program Exception - Trap */
+#define ESR_FP		0x01000000	/* Floating Point Operation */
 #define ESR_DST		0x00800000	/* Storage Exception - Data miss */
 #define ESR_DIZ		0x00400000	/* Storage Exception - Zone fault */
 #define ESR_ST		0x00800000	/* Store Operation */
