Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbVDZLJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbVDZLJN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 07:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVDZLJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 07:09:13 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:50576 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S261483AbVDZLIZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 07:08:25 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17006.8471.317402.662874@cargo.ozlabs.ibm.com>
Date: Tue, 26 Apr 2005 21:08:07 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: benh@kernel.crashing.org, trini@kernel.crashing.org,
       kumar.gala@freescale.com, linux-kernel@vger.kernel.org
Subject: [PATCH] ppc32: refactor FPU exception handling
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Moved common FPU exception handling code out of head.S so it can be used 
by several of the sub-architectures that might of a full PowerPC FPU.  

Also, uses new CONFIG_PPC_FPU define to fix alignment exception 
handling for floating point load/store instructions to only occur if we 
have a hardware FPU.

Signed-off-by: Jason McMullan <jason.mcmullan@timesys.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

---
diff -urN linux-2.6/arch/ppc/Kconfig test26/arch/ppc/Kconfig
--- linux-2.6/arch/ppc/Kconfig	2005-04-26 20:19:17.000000000 +1000
+++ test26/arch/ppc/Kconfig	2005-04-26 20:54:47.000000000 +1000
@@ -53,6 +53,7 @@
 
 config 6xx
 	bool "6xx/7xx/74xx/52xx/82xx/83xx"
+	select PPC_FPU
 	help
 	  There are four types of PowerPC chips supported.  The more common
 	  types (601, 603, 604, 740, 750, 7400), the Motorola embedded
@@ -86,6 +87,9 @@
 
 endchoice
 
+config PPC_FPU
+	bool
+
 config BOOKE
 	bool
 	depends on E500
diff -urN linux-2.6/arch/ppc/Makefile test26/arch/ppc/Makefile
--- linux-2.6/arch/ppc/Makefile	2005-04-26 20:19:17.000000000 +1000
+++ test26/arch/ppc/Makefile	2005-04-26 20:54:47.000000000 +1000
@@ -53,6 +53,7 @@
 
 head-$(CONFIG_6xx)		+= arch/ppc/kernel/idle_6xx.o
 head-$(CONFIG_POWER4)		+= arch/ppc/kernel/idle_power4.o
+head-$(CONFIG_PPC_FPU)		+= arch/ppc/kernel/fpu.o
 
 core-y				+= arch/ppc/kernel/ arch/ppc/platforms/ \
 				   arch/ppc/mm/ arch/ppc/lib/ arch/ppc/syslib/
diff -urN linux-2.6/arch/ppc/kernel/Makefile test26/arch/ppc/kernel/Makefile
--- linux-2.6/arch/ppc/kernel/Makefile	2005-04-26 20:19:19.000000000 +1000
+++ test26/arch/ppc/kernel/Makefile	2005-04-26 20:54:47.000000000 +1000
@@ -9,6 +9,7 @@
 extra-$(CONFIG_8xx)		:= head_8xx.o
 extra-$(CONFIG_6xx)		+= idle_6xx.o
 extra-$(CONFIG_POWER4)		+= idle_power4.o
+extra-$(CONFIG_PPC_FPU)		+= fpu.o
 extra-y				+= vmlinux.lds
 
 obj-y				:= entry.o traps.o irq.o idle.o time.o misc.o \
diff -urN linux-2.6/arch/ppc/kernel/align.c test26/arch/ppc/kernel/align.c
--- linux-2.6/arch/ppc/kernel/align.c	2005-04-26 20:19:19.000000000 +1000
+++ test26/arch/ppc/kernel/align.c	2005-04-26 20:54:47.000000000 +1000
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
 
diff -urN linux-2.6/arch/ppc/kernel/entry.S test26/arch/ppc/kernel/entry.S
--- linux-2.6/arch/ppc/kernel/entry.S	2005-04-26 20:19:19.000000000 +1000
+++ test26/arch/ppc/kernel/entry.S	2005-04-26 20:54:47.000000000 +1000
@@ -563,6 +563,65 @@
 	addi	r1,r1,INT_FRAME_SIZE
 	blr
 
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
+#if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
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
+#endif
+
 	.globl	sigreturn_exit
 sigreturn_exit:
 	subi	r1,r3,STACK_FRAME_OVERHEAD
diff -urN linux-2.6/arch/ppc/kernel/fpu.S test26/arch/ppc/kernel/fpu.S
--- /dev/null	2005-04-02 20:23:56.000000000 +1000
+++ test26/arch/ppc/kernel/fpu.S	2005-04-26 20:54:47.000000000 +1000
@@ -0,0 +1,133 @@
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
+	b	fast_exception_return
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
diff -urN linux-2.6/arch/ppc/kernel/head.S test26/arch/ppc/kernel/head.S
--- linux-2.6/arch/ppc/kernel/head.S	2005-04-26 20:19:19.000000000 +1000
+++ test26/arch/ppc/kernel/head.S	2005-04-26 20:54:47.000000000 +1000
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
@@ -1016,42 +889,6 @@
 #endif /* CONFIG_ALTIVEC */
 
 /*
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
-
-/*
  * This code is jumped to from the startup code to copy
  * the kernel image to physical address 0.
  */
diff -urN linux-2.6/arch/ppc/kernel/head_44x.S test26/arch/ppc/kernel/head_44x.S
--- linux-2.6/arch/ppc/kernel/head_44x.S	2005-04-26 20:19:19.000000000 +1000
+++ test26/arch/ppc/kernel/head_44x.S	2005-04-26 20:54:47.000000000 +1000
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
diff -urN linux-2.6/arch/ppc/kernel/head_booke.h test26/arch/ppc/kernel/head_booke.h
--- linux-2.6/arch/ppc/kernel/head_booke.h	2005-04-26 20:19:19.000000000 +1000
+++ test26/arch/ppc/kernel/head_booke.h	2005-04-26 20:54:47.000000000 +1000
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
diff -urN linux-2.6/arch/ppc/kernel/head_fsl_booke.S test26/arch/ppc/kernel/head_fsl_booke.S
--- linux-2.6/arch/ppc/kernel/head_fsl_booke.S	2005-04-26 20:19:19.000000000 +1000
+++ test26/arch/ppc/kernel/head_fsl_booke.S	2005-04-26 20:54:47.000000000 +1000
@@ -504,7 +504,11 @@
 	PROGRAM_EXCEPTION
 
 	/* Floating Point Unavailable Interrupt */
+#ifdef CONFIG_PPC_FPU
+	FP_UNAVAILABLE_EXCEPTION
+#else
 	EXCEPTION(0x0800, FloatingPointUnavailable, UnknownException, EXC_XFER_EE)
+#endif
 
 	/* System Call Interrupt */
 	START_EXCEPTION(SystemCall)
@@ -916,10 +920,12 @@
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
diff -urN linux-2.6/arch/ppc/kernel/misc.S test26/arch/ppc/kernel/misc.S
--- linux-2.6/arch/ppc/kernel/misc.S	2005-04-26 20:19:19.000000000 +1000
+++ test26/arch/ppc/kernel/misc.S	2005-04-26 20:54:47.000000000 +1000
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
diff -urN linux-2.6/arch/ppc/kernel/traps.c test26/arch/ppc/kernel/traps.c
--- linux-2.6/arch/ppc/kernel/traps.c	2005-04-26 20:19:20.000000000 +1000
+++ test26/arch/ppc/kernel/traps.c	2005-04-26 20:54:47.000000000 +1000
@@ -176,7 +176,7 @@
 #else
 #define get_mc_reason(regs)	(mfspr(SPRN_MCSR))
 #endif
-#define REASON_FP		0
+#define REASON_FP		ESR_FP
 #define REASON_ILLEGAL		ESR_PIL
 #define REASON_PRIVILEGED	ESR_PPR
 #define REASON_TRAP		ESR_PTR
diff -urN linux-2.6/include/asm-ppc/reg_booke.h test26/include/asm-ppc/reg_booke.h
--- linux-2.6/include/asm-ppc/reg_booke.h	2005-04-26 20:21:36.000000000 +1000
+++ test26/include/asm-ppc/reg_booke.h	2005-04-26 20:54:47.000000000 +1000
@@ -305,6 +305,7 @@
 #define ESR_PIL		0x08000000	/* Program Exception - Illegal */
 #define ESR_PPR		0x04000000	/* Program Exception - Priveleged */
 #define ESR_PTR		0x02000000	/* Program Exception - Trap */
+#define ESR_FP		0x01000000	/* Floating Point Operation */
 #define ESR_DST		0x00800000	/* Storage Exception - Data miss */
 #define ESR_DIZ		0x00400000	/* Storage Exception - Zone fault */
 #define ESR_ST		0x00800000	/* Store Operation */
