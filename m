Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261664AbVCWQnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbVCWQnj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 11:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262734AbVCWQnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 11:43:39 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:30851 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261664AbVCWQiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 11:38:46 -0500
Date: Wed, 23 Mar 2005 10:38:33 -0600
From: Michael Raymond <mraymond@sgi.com>
To: tony.luck@intel.com
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] User Level Interrupts
Message-ID: <20050323103832.A108873@goliath.americas.sgi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

    Allow fast (1+us) user notification of device interrupts.  This allows
more powerful user I/O applications to be written.  The process of porting
to other architectures is straight forward and fully documented.  More
information can be found at http://oss.sgi.com/projects/uli/.

Signed-off-by: Michael A Raymond <mraymond@sgi.com>

-- 
Michael A. Raymond              Office: (651) 683-3434
Core OS Group                   Real-Time System Software

--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="uli-2.6.11.diff"

diff -urN linux-2.6.11/arch/ia64/kernel/asm-offsets.c linux-2.6.11-uli/arch/ia64/kernel/asm-offsets.c
--- linux-2.6.11/arch/ia64/kernel/asm-offsets.c	2005-03-10 06:44:14.693503599 -0600
+++ linux-2.6.11-uli/arch/ia64/kernel/asm-offsets.c	2005-03-10 06:45:49.777264508 -0600
@@ -7,6 +7,7 @@
 #include <linux/config.h>
 
 #include <linux/sched.h>
+#include <linux/uli.h>
 
 #include <asm-ia64/processor.h>
 #include <asm-ia64/ptrace.h>
@@ -236,4 +237,19 @@
 	DEFINE(IA64_TIME_SOURCE_MMIO64, TIME_SOURCE_MMIO64);
 	DEFINE(IA64_TIME_SOURCE_MMIO32, TIME_SOURCE_MMIO32);
 	DEFINE(IA64_TIMESPEC_TV_NSEC_OFFSET, offsetof (struct timespec, tv_nsec));
+
+#ifdef CONFIG_ULI
+	BLANK();
+	DEFINE(ULI_GP_OFFSET, offsetof(struct uli, uli_gp));
+	DEFINE(ULI_SP_OFFSET, offsetof(struct uli, uli_sp));
+	DEFINE(ULI_BSPSTORE_OFFSET, offsetof(struct uli, uli_arch0));
+	DEFINE(ULI_TP_OFFSET, offsetof(struct uli, uli_arch1));
+	DEFINE(ULI_PC_OFFSET, offsetof(struct uli, uli_pc));
+	DEFINE(ULI_ARG_OFFSET, offsetof(struct uli, uli_funcarg));
+	DEFINE(ULI_TSTAMP_OFFSET, offsetof(struct uli, uli_tstamp));
+	DEFINE(ULI_DOUBLE_OFFSET, offsetof(struct uli, uli_double));
+	DEFINE(ULI_INTR_SP_OFFSET, offsetof(struct uli, uli_intr_sp));
+	DEFINE(ULI_INTR_BSPSTORE_OFFSET, offsetof(struct uli, uli_intr_arch0));
+	DEFINE(ULI_SAVED_EPC_OFFSET, offsetof(struct uli, uli_saved_epc));
+#endif /* CONFIG_ULI */
 }
diff -urN linux-2.6.11/arch/ia64/kernel/entry.S linux-2.6.11-uli/arch/ia64/kernel/entry.S
--- linux-2.6.11/arch/ia64/kernel/entry.S	2005-03-02 01:37:50.000000000 -0600
+++ linux-2.6.11-uli/arch/ia64/kernel/entry.S	2005-03-22 08:41:17.597377762 -0600
@@ -698,6 +698,16 @@
 (pUStk)	cmp.eq.unc p6,p0=r0,r0		// p6 <- pUStk
 #endif
 .work_processed_syscall:
+#ifdef CONFIG_ULI
+	addl r22 = THIS_CPU(uli_cur),r0 // uli_cur
+	;;
+	ld8 r22 = [r22] // load current ULI
+	;;
+(p6)	cmp.eq p6,p0=r0,r22 // If would do work && no ULI, then can still check
+(pUStk) cmp.eq.unc p7,p0=r0,r22 // Don't store to on_ustack if there's a ULI
+#else /* CONFIG_ULI */
+(pUStk) cmp.eq.unc p7,p0=r0,r0
+#endif /* CONFIG_ULI */
 	adds r2=PT(LOADRS)+16,r12
 	adds r3=PT(AR_BSPSTORE)+16,r12
 	adds r18=TI_FLAGS+IA64_TASK_SIZE,r13
@@ -760,7 +770,7 @@
 	addl r3=THIS_CPU(ia64_phys_stacked_size_p8),r0
 	;;
 (pUStk)	ld4 r3=[r3]		// r3 = cpu_data->phys_stacked_size_p8
-(pUStk) st1 [r14]=r17
+(p7)	st1 [r14]=r17
 	mov b6=r18		// I0  restore b6
 	;;
 	mov r14=r0		// clear r14
@@ -814,6 +824,14 @@
 (pUStk)	cmp.eq.unc p6,p0=r0,r0		// p6 <- pUStk
 #endif
 .work_processed_kernel:
+#ifdef CONFIG_ULI
+	addl r22 = THIS_CPU(uli_cur),r0 // uli_cur
+	;;
+	ld8 r22 = [r22] // load current ULI
+	;;
+(p6)	cmp.eq p6,p0=r0,r22 // If would do work && no ULI, then can still check
+	cmp.eq p9,p7=r0,r22 // Set p7 if there's a current ULI
+#endif /* CONFIG_ULI */
 	adds r17=TI_FLAGS+IA64_TASK_SIZE,r13
 	;;
 (p6)	ld4 r31=[r17]				// load current_thread_info()->flags
@@ -842,13 +860,44 @@
 	;;
 	ld8 r31=[r2],16		// load ar.ssd
 	ld8.fill r8=[r3],16
+#ifdef CONFIG_ULI
+(p7)	add r19 = ULI_DOUBLE_OFFSET,r22 /* &cur_uli->uli_double */
+#endif /* CONFIG_ULI */
 	;;
 	ld8.fill r9=[r2],16
 	ld8.fill r10=[r3],PT(R17)-PT(R10)
+#ifdef CONFIG_ULI
+(p7)    add r18 = ULI_TSTAMP_OFFSET,r22
+#endif /* CONFIG_ULI */
 	;;
 	ld8.fill r11=[r2],PT(R18)-PT(R11)
 	ld8.fill r17=[r3],16
+(pUStk) cmp.eq.unc p6,p0=r0,r0 /* p6 was false, set to pUStk */
+	;;
+#ifdef CONFIG_ULI
+/* We need to check if the current ULI has been running too long */
+(p9)	br.cond.sptk.many 1f /* No current ULI, skip the check */
+	;;
+	ld4 r22=[r19] /* *cur_uli->uli_double, # of double intrs  */
+	ld8 r18=[r18] /* *tstamp */
+	cmp.eq p0,p6=r0,r0 /* If there's a current ULI, p6 becomes false */
+	;;
+	mov r23 = ar.itc /* Get the current time */
+	sub r22=r22,r0,1 /* One less nested level above ULI handler */
+	;;
+	cmp.eq p8,p9=r22,r0 /* Returning into a handler? */
+	st4 [r19] = r22 /* store lower # of doubles */
+	;;
+(p8)	cmp.ge p0,p9=r23,r18 /* Returning into a handler && overrun? */
+	;;
+(p9)	br.cond.sptk.many 1f /* No overrun, continue exiting */
+	alloc r0=ar.pfs,0,0,2,0 /* There's been an overrun, abort the ULI */
 	;;
+	mov out0 = 24 /* SIGXCPU */
+	mov out1 = r0 /* &pt_regs */
+	br.call.spnt.few b6=uli_return /* Go to the start pt, this won't ret */
+1:
+#endif /* CONFIG_ULI */
 	ld8.fill r18=[r2],16
 	ld8.fill r19=[r3],16
 	;;
@@ -930,7 +979,7 @@
 (pUStk)	mov r17=1
 	;;
 	ld8.fill r3=[r16]
-(pUStk)	st1 [r18]=r17		// restore current->thread.on_ustack
+(p6)	st1 [r18]=r17		// restore current->thread.on_ustack
 	shr.u r18=r19,16	// get byte size of existing "dirty" partition
 	;;
 	mov r16=ar.bsp		// get existing backing store pointer
diff -urN linux-2.6.11/arch/ia64/kernel/fsys.S linux-2.6.11-uli/arch/ia64/kernel/fsys.S
--- linux-2.6.11/arch/ia64/kernel/fsys.S	2005-03-02 01:38:34.000000000 -0600
+++ linux-2.6.11-uli/arch/ia64/kernel/fsys.S	2005-03-22 08:45:29.832958277 -0600
@@ -579,6 +579,9 @@
 	mov psr.l=r9			// slam the door (17 cyc to srlz.i)
 	or r29=r8,r29			// construct cr.ipsr value to save
 	addl r22=IA64_RBS_OFFSET,r2	// compute base of RBS
+#ifdef CONFIG_ULI
+	addl r17 = THIS_CPU(uli_cur),r0 // &uli_cur[this cpu]
+#endif /* CONFIG_ULI */
 	;;
 	// GAS reports a spurious RAW hazard on the read of ar.rnat because it thinks
 	// we may be reading ar.itc after writing to psr.l.  Avoid that message with
@@ -587,6 +590,9 @@
 	mov.m r24=ar.rnat		// read ar.rnat (5 cyc lat)
 	lfetch.fault.excl.nt1 [r22]
 	adds r16=IA64_TASK_THREAD_ON_USTACK_OFFSET,r2
+#ifdef CONFIG_ULI
+	ld8 r3 = [r17] // Get the address of the current ULI
+#endif /* CONFIG_ULI */
 
 	// ensure previous insn group is issued before we stall for srlz.i:
 	;;
@@ -595,6 +601,14 @@
 	////////// from this point on, execution is not interruptible anymore
 	/////////////////////////////////////////////////////////////////////////////
 	addl r1=IA64_STK_OFFSET-IA64_PT_REGS_SIZE,r2	// compute base of memory stack
+#ifdef CONFIG_ULI
+	cmp.eq p7,p20=r0,r3      // ULI?
+	add r17 = ULI_INTR_SP_OFFSET, r3 // Former stack pointer
+	add r30 = ULI_INTR_BSPSTORE_OFFSET, r3   // Former BSP
+	;;
+(p20)	ld8 r1 = [r17] // sp
+(p20)	ld8 r22 = [r30] // bspstore
+#endif /* CONFIG_ULI */
 	cmp.ne pKStk,pUStk=r0,r0	// set pKStk <- 0, pUStk <- 1
 	;;
 	st1 [r16]=r0			// clear current->thread.on_ustack flag
@@ -613,6 +627,9 @@
 	mov rp=r2				// set the real return addr
 	tbit.z p8,p0=r3,TIF_SYSCALL_TRACE
 	;;
+#ifdef CONFIG_ULI
+(p20)	br.call.spnt.few b6=uli_syscall
+#endif /* CONFIG_ULI */
 (p10)	br.cond.spnt.many ia64_ret_from_syscall	// p10==true means out registers are more than 8
 (p8)	br.call.sptk.many b6=b6		// ignore this return addr
 	br.cond.sptk ia64_trace_syscall
diff -urN linux-2.6.11/arch/ia64/kernel/ivt.S linux-2.6.11-uli/arch/ia64/kernel/ivt.S
--- linux-2.6.11/arch/ia64/kernel/ivt.S	2005-03-02 01:37:49.000000000 -0600
+++ linux-2.6.11-uli/arch/ia64/kernel/ivt.S	2005-03-21 08:53:52.611672980 -0600
@@ -704,7 +704,21 @@
 	cmp.eq p0,p7=r18,r17			// is this a system call? (p7 <- false, if so)
 (p7)	br.cond.spnt non_syscall
 	;;
+#ifdef CONFIG_ULI
+       /*
+        * If we're in a ULI doing a system call, we need to start on the stack
+        * where we switched out to handle the ULI.
+        */
+	addl r17 = THIS_CPU(uli_cur),r0  // &uli_cur[this cpu]
+	;;
+	ld8 r22 = [r17]                  // r22 = current ULI, MINSTATE expects r22
+	;;
+	cmp.eq pUStk,pLvSys=r0,r22          // ULI?  MINSTATE expects a valid pLvSys
+	;;
+(pUStk) ld1 r17=[r16]           // load current->thread.on_ustack flag
+#else /* CONFIG_ULI */
 	ld1 r17=[r16]				// load current->thread.on_ustack flag
+#endif /* CONFIG_ULI */
 	st1 [r16]=r0				// clear current->thread.on_ustack flag
 	add r1=-IA64_TASK_THREAD_ON_USTACK_OFFSET,r16	// set r1 for MINSTATE_START_SAVE_MIN_VIRT
 	;;
@@ -721,6 +735,7 @@
 (p6)	adds r28=16,r28				// switch cr.iip to next bundle cr.ipsr.ei wrapped
 (p7)	adds r8=1,r8				// increment ei to next slot
 	;;
+	/* If we're in a ULI then r17 will be non-zero and we'll get pUStk */
 	cmp.eq pKStk,pUStk=r0,r17		// are we in kernel mode already?
 	dep r29=r8,r29,41,2			// insert new ei into cr.ipsr
 	;;
@@ -760,6 +775,9 @@
 	cmp.eq p8,p0=r2,r0
 	mov b6=r20
 	;;
+#ifdef CONFIG_ULI
+(pLvSys) br.call.spnt.few b6=uli_syscall
+#endif /* CONFIG_ULI */
 (p8)	br.call.sptk.many b6=b6			// ignore this return addr
 	br.cond.sptk ia64_trace_syscall
 	// NOT REACHED
diff -urN linux-2.6.11/arch/ia64/kernel/Makefile linux-2.6.11-uli/arch/ia64/kernel/Makefile
--- linux-2.6.11/arch/ia64/kernel/Makefile	2005-03-10 06:44:22.122120706 -0600
+++ linux-2.6.11-uli/arch/ia64/kernel/Makefile	2005-03-10 06:47:33.250570322 -0600
@@ -21,6 +21,7 @@
 obj-$(CONFIG_IA64_CYCLONE)	+= cyclone.o
 obj-$(CONFIG_IA64_MCA_RECOVERY)	+= mca_recovery.o
 mca_recovery-y			+= mca_drv.o mca_drv_asm.o
+obj-$(CONFIG_ULI)		+= uli_asm.o
 
 # The gate DSO image is built using a special linker script.
 targets += gate.so gate-syms.o
diff -urN linux-2.6.11/arch/ia64/kernel/minstate.h linux-2.6.11-uli/arch/ia64/kernel/minstate.h
--- linux-2.6.11/arch/ia64/kernel/minstate.h	2005-03-02 01:38:25.000000000 -0600
+++ linux-2.6.11-uli/arch/ia64/kernel/minstate.h	2005-03-18 15:31:09.001118433 -0600
@@ -4,15 +4,41 @@
 
 #include "entry.h"
 
+#ifdef CONFIG_ULI
+#include <asm/percpu.h>
+
+#define MINSTATE_LOAD_OFFSETS \
+(pLvSys)	add r17 = ULI_INTR_SP_OFFSET, r22;	/* prev sp - size(pt_regs) */ \
+(pLvSys)	add r18 = ULI_INTR_BSPSTORE_OFFSET, r22;	/* previous bspstore */
+
+#define MINSTATE_LOAD_STACK \
+(pLvSys)	ld8 r1 = [r17];	/* sp is prev mod'd sp */ \
+(pLvSys)	ld8 r22 = [r18];	/* bspstore is prev bspstore */
+
+# else /* CONFIG_ULI */
+
+#define MINSTATE_LOAD_OFFSETS
+#define MINSTATE_LOAD_STACK
+
+#endif /* CONFIG_ULI */
+
 /*
  * For ivt.s we want to access the stack virtually so we don't have to disable translation
  * on interrupts.
  *
  *  On entry:
  *	r1:	pointer to current task (ar.k6)
+ *
+ * For ULI code:
+ * If we came from user space, pUStk is true.
+ * If there is no current ULI and we took this trap while in the kernel,
+ *   OR if we're well above a ULI, pKStk is true.
+ * If we're right on top of a ULI, pLvSys is true and we use it to override
+ *   some of pUStk's values to get the appropriate kernel stacks.
  */
 #define MINSTATE_START_SAVE_MIN_VIRT								\
 (pUStk)	mov ar.rsc=0;		/* set enforced lazy mode, pl 0, little-endian, loadrs=0 */	\
+MINSTATE_LOAD_OFFSETS \
 	;;											\
 (pUStk)	mov.m r24=ar.rnat;									\
 (pUStk)	addl r22=IA64_RBS_OFFSET,r1;			/* compute base of RBS */		\
@@ -25,6 +51,8 @@
 (pUStk)	mov ar.bspstore=r22;				/* switch to kernel RBS */		\
 (pKStk) addl r1=-IA64_PT_REGS_SIZE,r1;			/* if in kernel mode, use sp (r12) */	\
 	;;											\
+MINSTATE_LOAD_STACK \
+	;;	\
 (pUStk)	mov r18=ar.bsp;										\
 (pUStk)	mov ar.rsc=0x3;		/* set eager mode, pl 0, little-endian, loadrs=0 */		\
 
@@ -61,7 +89,34 @@
 	;;
 
 #ifdef MINSTATE_VIRT
+#ifdef CONFIG_ULI
+
+/*
+ * We leave with pUStk true if we're not on a ULI OR we're well above one.
+ * We leave with pKStk true if there's a current ULI
+ * We leave with PLvSys true if we're the first above a ULI.
+ */
+#define MINSTATE_GET_CURRENT(reg) \
+	addl r20 = THIS_CPU(uli_cur),r0;	\
+	;;	\
+	ld8 r22 = [r20]; /* r22 = cur_uli, needed by START_SAVE_MIN_VIRT */	\
+	;;	\
+	cmp.eq pUStk,pKStk=r0,r22;	/* cur == NULL? */	\
+	add r20 = ULI_DOUBLE_OFFSET,r22;	/* r20 = &cur_uli.uli_double */	\
+	;;	\
+(pKStk)	ld4 r21 = [r20]; /* load # of doubles */	\
+(pUStk)	cmp.eq pUStk,pLvSys=r0,r0; /* init pLvSys to false */	\
+	;;	\
+(pKStk)	cmp.eq pLvSys,pUStk=r0,r21; /* First nested intr? */	\
+	;; \
+	mov reg=IA64_KR(CURRENT); /* If normal, use actual current */	\
+(pKStk)	add r21 = 1,r21; /* Increment the nested count */	\
+	;; \
+(pKStk)	st4 [r20] = r21; /* Mark that we're above a ULI */
+
+#else /* CONFIG_ULI */
 # define MINSTATE_GET_CURRENT(reg)	mov reg=IA64_KR(CURRENT)
+#endif /* CONFIG_ULI */
 # define MINSTATE_START_SAVE_MIN	MINSTATE_START_SAVE_MIN_VIRT
 # define MINSTATE_END_SAVE_MIN		MINSTATE_END_SAVE_MIN_VIRT
 #endif
@@ -72,6 +127,21 @@
 # define MINSTATE_END_SAVE_MIN		MINSTATE_END_SAVE_MIN_PHYS
 #endif
 
+#if defined(CONFIG_ULI) && !defined(MINSTATE_PHYS)
+/*
+ * pLvSys is true if we're right on top of a ULI
+ * pUStk is true if (we're not in a ULI) OR (well above a ULI)
+ * pLvSys and pUStk are opposites
+ */
+#define CHECK_USR \
+(pLvSys) mov r17 = 0x1; /* Pretend we're on the user stack */ \
+(pUStk) ld1 r17=[r16];				/* load current->thread.on_ustack flag */
+
+#else /* CONFIG_ULI */
+#define CHECK_USR \
+	ld1 r17=[r16];				/* load current->thread.on_ustack flag */
+#endif /* CONFIG_ULI */
+
 /*
  * DO_SAVE_MIN switches to the kernel stacks (if necessary) and saves
  * the minimum state necessary that allows us to turn psr.ic back
@@ -110,7 +180,7 @@
 	;;											\
 	adds r16=IA64_TASK_THREAD_ON_USTACK_OFFSET,r16;						\
 	;;											\
-	ld1 r17=[r16];				/* load current->thread.on_ustack flag */	\
+	CHECK_USR;	\
 	st1 [r16]=r0;				/* clear current->thread.on_ustack flag */	\
 	adds r1=-IA64_TASK_THREAD_ON_USTACK_OFFSET,r16						\
 	/* switch from user to kernel RBS: */							\
diff -urN linux-2.6.11/arch/ia64/kernel/traps.c linux-2.6.11-uli/arch/ia64/kernel/traps.c
--- linux-2.6.11/arch/ia64/kernel/traps.c	2005-03-02 01:38:26.000000000 -0600
+++ linux-2.6.11-uli/arch/ia64/kernel/traps.c	2005-03-10 06:45:50.655183125 -0600
@@ -15,6 +15,7 @@
 #include <linux/vt_kern.h>		/* For unblank_screen() */
 #include <linux/module.h>       /* for EXPORT_SYMBOL */
 #include <linux/hardirq.h>
+#include <linux/uli.h>
 
 #include <asm/fpswa.h>
 #include <asm/ia32.h>
@@ -181,6 +182,10 @@
 			sig = SIGTRAP; code = TRAP_BRKPT;
 		}
 	}
+
+	/* If a ULI caused this, abort it */
+	uli_trap(sig, regs);
+
 	siginfo.si_signo = sig;
 	siginfo.si_errno = 0;
 	siginfo.si_code = code;
@@ -375,6 +380,8 @@
 			return rv;
 	}
 #endif
+	/* If a ULI caused this abort it */
+	uli_trap(SIGILL, &regs);
 
 	sprintf(buf, "IA-64 Illegal operation fault");
 	die_if_kernel(buf, &regs, 0);
@@ -408,6 +415,9 @@
 		"Unknown fault 13", "Unknown fault 14", "Unknown fault 15"
 	};
 
+	/* If a ULI caused this abort it */
+	uli_trap(SIGILL, &regs);
+
 	if ((isr & IA64_ISR_NA) && ((isr & IA64_ISR_CODE_MASK) == IA64_ISR_CODE_LFETCH)) {
 		/*
 		 * This fault was due to lfetch.fault, set "ed" bit in the psr to cancel
diff -urN linux-2.6.11/arch/ia64/kernel/uli_asm.S linux-2.6.11-uli/arch/ia64/kernel/uli_asm.S
--- linux-2.6.11/arch/ia64/kernel/uli_asm.S	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.11-uli/arch/ia64/kernel/uli_asm.S	2005-03-21 08:51:01.522668631 -0600
@@ -0,0 +1,244 @@
+/*
+ * Copyright (c) 2005 Silicon Graphics, Inc.
+ * All rights reserved.
+ *
+ *   Michael A. Raymond <mraymond@sgi.com>
+ */
+
+/*
+ *  This file is part of the User Level Interrupt (ULI) feature.
+ *
+ *  ULI is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  ULI is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with ULI; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+#include <asm/asmmacro.h>
+#include <asm/offsets.h>
+
+/*
+ * We save the current state of the CPU and jump into
+ * uli_setup_eret.
+ */
+GLOBAL_ENTRY(uli_goto_user)
+	alloc r14=ar.pfs,1,0,1,0
+	flushrs
+	;;
+	mov r2=in0 // Index into ULI context save area
+	add r3=8,in0 // Ditto
+	mov r24=pr // Save the predicate register
+	mov r8=ar.unat
+	mov r15=ar.fpsr // Save the FP status reg since the user might modify it
+	mov r9=in0 // Use ULI storage spot for UNAT calc
+	mov r23=ar.bsp // Get the BSP return it
+	mov r16=rp      // b0
+	mov r17=b1
+	;;
+.mem.offset 0,0;	st8.spill.nta [r2]=gp,16	// r1 (gp)
+.mem.offset 8,0;	st8.spill.nta [r3]=r4,16	// r4
+	mov r18=b2
+	;;
+.mem.offset 0,0;	st8.spill.nta [r2]=r5,16	// r5
+.mem.offset 8,0;	st8.spill.nta [r3]=r6,16	// r6
+	extr.u r9=r9,3,6 // Start calculating post spill ar.unat
+	;;
+.mem.offset 0,0;	st8.spill.nta [r2]=r7,16	// r7
+.mem.offset 8,0;	st8.spill.nta [r3]=sp,16	// r12 (sp)
+	sub r10=64,r9
+	;;
+	mov ar.rsc = 0 // Put in lazy mode so we can read the folowing ar's
+	mov r25=ar.unat // Get UNAT after spill
+	mov out0=in0 // Pass on the ULI to use
+	;;
+	mov r22=ar.rnat
+	mov ar.rsc = 3 // Return to regular kernel mode
+	shr.u r11=r25,r9
+	;;
+	mov ar.unat=r8  // Restore the original UNAT after gr spill
+	;;
+	st8.nta [r2]=r8,16		// save caller's unat
+	st8.nta [r3]=r15,16		// save fpsr
+	mov r19=b3
+	;; 
+	st8.nta [r2]=r16,16		// b0
+	st8.nta [r3]=r17,16		// b1
+	mov r20=b4
+	;;
+	st8.nta [r2]=r18,16		// b2
+	st8.nta [r3]=r19,16		// b3
+	mov r21=b5
+	;; 
+	st8.nta [r2]=r20,16		// b4
+	st8.nta [r3]=r21,16		// b5
+	shl r25=r25,r10
+	;; 
+	st8.nta [r2]=r14,16		// ar.pfs
+	st8.nta [r3]=r22,16		// ar.rnat
+	or r25=r25,r11 // Arive at post spill ar.unat
+	;;
+	st8.nta [r2]=r24,16		// pr
+	st8.nta [r3]=r23,16		// ar.bsp
+ 	mov r26=ar.lc
+	;;
+	st8.nta [r2]=r25		// ar.unat - post save
+ 	st8.nta [r3]=r26 	 	// ar.lc
+	;;
+	br.call.sptk.many b6=uli_setup_eret
+       /*NOTREACHED*/
+END(uli_goto_user)
+
+/*
+ * Longjmp back to the state saved in uli_goto_user.  From there
+ * return to uli_goto_user's calling function.
+ */
+GLOBAL_ENTRY(uli_return_from_user)
+	alloc r8=ar.pfs,1,0,0,0
+	invala			// virt. -> phys. regnum mapping may change
+	add r4=0x90,in0 // &post unat
+	;;
+	ld8 r11=[r4]    // load post unat
+	mov r27=ar.rsc   // Save this for restoring later
+	extr.u r9=in0, 3, 6      // Start converting the ar.unat to use
+	;;
+	sub r8 = 64, r9
+	shl r10 = r11, r9
+	mov r2=in0
+	;;
+	shr.u r11=r11, r8
+	add r3=8,in0		// r3 <- &jmpbuf.r4
+	;;
+	or r11 = r11, r10        // Complete converting the ar.unat
+	;;
+	mov ar.unat = r11
+	add r8 = ULI_SAVED_EPC_OFFSET, in0
+	;;
+	ld8.fill.nta gp=[r2],16	// r1 (gp)
+	ld8.fill.nta r4=[r3],16		// r4
+	;;
+	ld8.fill.nta r5=[r2],16	// r5
+	ld8.fill.nta r6=[r3],16		// r6
+	;;
+	ld8.fill.nta r7=[r2],16	// r7
+	ld8.fill.nta sp=[r3],16		// r12 (sp)
+	;;
+	ld8.nta r28=[r2],16		// caller's unat
+       ld8.nta r29=[r3],16		// fpsr
+	;;
+	ld8.nta r16=[r2],16		// b0
+	ld8.nta r17=[r3],16		// b1
+	;;
+	ld8.nta r18=[r2],16		// b2
+	ld8.nta r19=[r3],16		// b3
+	mov b0=r16
+	;;
+	ld8.nta r20=[r2],16		// b4
+	ld8.nta r21=[r3],16		// b5
+	mov b1=r17
+	;;
+	ld8.nta r10=[r2],16		// ar.pfs
+	ld8.nta r22=[r3],16		// ar.rnat
+	mov b2=r18
+	;;
+	ld8.nta r24=[r2],16		// pr
+	ld8.nta r23=[r3],16		// ar.bsp
+	mov b3=r19
+	;;
+ 	ld8.nta r26=[r3] 	 	// ar.lc
+       ld8 r8=[r8]                 // cr.iip
+	mov b4=r20
+	;;
+	rsm psr.ic | psr.i      // Allow cr.iip to be set later
+	mov ar.pfs=r10
+	mov b5=r21
+	;;
+	srlz.d   // Make sure the disabling of interrupts is seen
+	mov ar.fpsr=r29			// restore fpsr
+	;;
+	mov ar.rsc=0		// Put RSE into lazy mode
+       loadrs
+	;;
+	mov cr.iip = r8         // restored originally preempted PC
+ 	mov ar.lc = r26
+	;;
+	mov.m ar.bspstore=r23	// restore ar.bspstore
+	mov.m ar.unat=r28			// restore caller's unat
+	;;
+	mov.m ar.rnat=r22		// restore ar.rnat
+	mov.m ar.rsc=r27		// restore ar.rsc
+	;;
+	ssm psr.ic | psr.i       // Reenable interrupts
+	;;
+	srlz.d   // Make sure that the above enabling of interrupts is seen
+	mov pr=r24,-1
+	br.ret.sptk.many rp
+END(uli_return_from_user)
+
+/*
+ * This is called from uli_setup_eret to do an rfi into the owning process's
+ * ULI handler.  We have to:
+ * - Save the actual current's PC when this interrupt occured
+ * - Save the actual current's sp & bspstore when this interrupt occured
+ * - Set the pc, sp, bspstore, gp, etc
+ * - Reenable interrupts on our way out
+ */
+GLOBAL_ENTRY(uli_eret)
+	mov r20 = ar.bsp // Save for bspstore loading on doubly nested intrs
+	alloc r21=ar.pfs,2,0,0,0 // We have two inputs
+	mov r22 = IA64_PT_REGS_SIZE // later subtraction wants general regs
+	;;
+	flushrs // Done after the alloc, allow switching of the bspstore
+	movl r21 = 0x8000000000000000 // valid & empty frame marker
+	;;
+	sub r22 = sp, r22 // sp - PT_REGS Make's handling nested intrs easier
+	rsm psr.ic // Turn off so that we can change cr.ifs
+	add r17 = ULI_INTR_SP_OFFSET, in0 // &uli_intr_sp
+	;;
+	srlz.d // make sure everyone has seen the status change
+	st8 [r17] = r22 // save mod'd sp for use in doubly nested interrupts
+	add r18 = ULI_INTR_BSPSTORE_OFFSET, in0 // &uli_intr_bspstore
+	;;
+	mov cr.ifs = r21 // Initialize their current frame marker
+	st8 [r18] = r20 // save parent's bspstore
+	add r17 = ULI_PC_OFFSET, in0 // &uli_pc
+	;;
+	mov r22 = cr.iip // Get PC of when we took this interrupt
+	ld8 r21 = [r17] // Load ULI handler's PC
+	add r18 = ULI_SAVED_EPC_OFFSET, in0 // &uli_epc
+	;;
+	mov cr.iip = r21 // rfi will load this as handler's PC
+	mov cr.ipsr = in1 // User space status register values to use
+	add r19 = ULI_SP_OFFSET, in0 // &uli_sp
+	;;
+	st8 [r18] = r22 // Save PC of when we took this interrupt
+	ld8 r12 = [r19] // Set the user's sp
+	add r20 = ULI_GP_OFFSET, in0 // &uli_gp
+	;;
+	ld8 r1 = [r20] // Set the user's gp
+	add r17 = ULI_ARG_OFFSET, in0 // &uli_funcarg
+	add r18 = ULI_BSPSTORE_OFFSET,in0 // &uli_bspstore
+	;; 
+	ld8 r20 = [r17] // Load the argument for the ULI handler
+	ld8 r21 = [r18] // Load user's bspstore to use
+	add r19 = ULI_TP_OFFSET,in0 // &uli_threadp
+	;;
+	mov ar.rsc = 0 // lazy mode for bspstore switch
+	invala // virtual->physical mapping changed, invalidate the ALAT
+	;;
+	mov ar.bspstore = r21 // Set the user's bspstore
+	mov ar.rsc = 0xf // standard user mode
+	mov r32 = r20 // handler's argument
+	;;
+	ssm psr.i | psr.ic // reenable interrupts
+	ld8 r13 = [r19] // Set the user's thread pointer
+	;;
+	rfi
+END(uli_eret)
diff -urN linux-2.6.11/arch/ia64/mm/fault.c linux-2.6.11-uli/arch/ia64/mm/fault.c
--- linux-2.6.11/arch/ia64/mm/fault.c	2005-03-02 01:38:32.000000000 -0600
+++ linux-2.6.11-uli/arch/ia64/mm/fault.c	2005-03-10 06:45:51.190332627 -0600
@@ -9,6 +9,7 @@
 #include <linux/mm.h>
 #include <linux/smp_lock.h>
 #include <linux/interrupt.h>
+#include <linux/uli.h>
 
 #include <asm/pgtable.h>
 #include <asm/processor.h>
@@ -84,6 +85,9 @@
 	struct siginfo si;
 	unsigned long mask;
 
+	/* If a ULI caused this abort it */
+	uli_trap(SIGSEGV, regs);
+
 	/*
 	 * If we're in an interrupt or have no user context, we must not take the fault..
 	 */
diff -urN linux-2.6.11/drivers/base/Kconfig linux-2.6.11-uli/drivers/base/Kconfig
--- linux-2.6.11/drivers/base/Kconfig	2005-03-02 01:37:49.000000000 -0600
+++ linux-2.6.11-uli/drivers/base/Kconfig	2005-03-10 06:45:51.386619214 -0600
@@ -37,4 +37,14 @@
 
 	  If you are unsure about this, say N here.
 
+config ULI
+	bool "User Level Interrupt Support"
+	depends on IA64 && EXPERIMENTAL
+	default n
+	help
+	  This enables hardware interrupts to be handled by software in
+	  user space.  This gives user processes more control over hardware
+	  and can enable driver development with reduced risk to system
+	  stability.
+
 endmenu
diff -urN linux-2.6.11/drivers/base/Makefile linux-2.6.11-uli/drivers/base/Makefile
--- linux-2.6.11/drivers/base/Makefile	2005-03-02 01:38:20.000000000 -0600
+++ linux-2.6.11-uli/drivers/base/Makefile	2005-03-10 06:45:51.631733311 -0600
@@ -7,6 +7,7 @@
 obj-y			+= power/
 obj-$(CONFIG_FW_LOADER)	+= firmware_class.o
 obj-$(CONFIG_NUMA)	+= node.o
+obj-$(CONFIG_ULI)	+= uli.o
 
 ifeq ($(CONFIG_DEBUG_DRIVER),y)
 EXTRA_CFLAGS += -DDEBUG
diff -urN linux-2.6.11/drivers/base/uli.c linux-2.6.11-uli/drivers/base/uli.c
--- linux-2.6.11/drivers/base/uli.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.11-uli/drivers/base/uli.c	2005-03-23 09:13:31.137340683 -0600
@@ -0,0 +1,687 @@
+/*
+ * Copyright (c) 2005 Silicon Graphics, Inc.
+ * All rights reserved.
+ *
+ *   Michael A. Raymond <mraymond@sgi.com>
+ */
+
+/*
+ *  This file is part of the User Level Interrupt (ULI) feature.
+ *
+ *  ULI is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  ULI is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with ULI; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+/*
+ *   User Level Interrupts (ULIs) are a method of handling interrupts in
+ * user space that would normally be entirely handled within the kernel.
+ * They are useful for fault tolerant interrupt handling code and for
+ * programs that do a lot of memory mapped I/O.
+ *
+ *   ULIs work by doing a return-from-interrupt (RFI) from the kernel
+ * interrupt handler to a user space function specified by the user.  The
+ * code is run entirely in user space and so faults can be contained and
+ * it can access all of the user's address space.  The only limitation is
+ * that system calls cannot be made from the handler function.  The
+ * supporting library, libuli, does use system calls to return to the
+ * kernel, but this is the only allowed or possible usage.
+ *
+ *                                                  -------
+ *      --------         ------------------------  | User  |
+ *     |Shared  |       | User        -------- <-|-|Process|
+ *     |Memory /|       |Process <-->|  ULI   |  |  -------
+ *     |Mapped  |<------|----------->|Function|  |      -------
+ *     |Memory  |       |             -------- <-|-----| User  |
+ *      --------        |Memory Access   A       |     |Process|
+ *                       ------------------------       -------
+ * User Level                            |
+ * --------------------------------------------------------------------
+ * Interrupt Level                       |
+ *                                     ------
+ *                                    |Kernel|
+ *                                    |ISR   | <--- Interrupt
+ *                                     ------
+ *
+ *   The specific details of the ULI implementation are as follows.  When
+ * a kernel interrupt handler that has been registered with by the user
+ * to use a ULI is run, it calls into uli_handler.  This function switches
+ * the virtual memory settings around so that the address space of the
+ * registering program is used.  A function called by uli_handler does an rfi
+ * into the user's address space after first saving the system state.  When
+ * the user's handler is completed, libuli does a write() call on the file
+ * descriptor representing its /dev/uli instance, which results in uli_write
+ * executing.  uli_write restores the state saved previously along with the
+ * proper address space.  uli_handler can then return to the previously
+ * executing kernel code.
+ *
+ *   Special care must be taken when an interrupt occurs while a ULI handler
+ * is already running.  Even though the system was running in user space,
+ * it must not start from the top of the kernel stack; it needs to start
+ * from where the kernel stack was before it did the rfi.  This is kept track
+ * of through uli_cur[] and each ULI's uli_double field.  If a ULI is
+ * currently running on a CPU then uli_cur[cpu] will point to the top level
+ * one.  When an interrupt occurs during a ULI, the ULI's uli_double field is
+ * incremented.  If the field is already >= 1, then no special steps need to
+ * be taken.  If a ULI happens to run nested above another ULI, then for each
+ * new nested interrupt checks and updates will only be made against the top
+ * most ULI.
+ *
+ *   libuli is a very simple wrapper library to make ULI usage easier.  It
+ * is by no means required though.
+ *
+ *                         -------
+ *                     -> |handler|->write()---->----------
+ *                    |    -------                         | User Space
+ *--------------------------------------------------------------------
+ *                    |       ------                       | Kernel Space
+ *                    |    <-|      | uli_return_from_user |
+ *                   rfi  |  |      |                      |
+ *                    |   l   ------                       |
+ *                    |   o  |      | uli_return           |
+ *                ------  n  |      |                      |
+ *      uli_eret |      | g   ------                       |
+ *               |      | j  |      | uli_write            |
+ *                ------  u  |      |                      |
+ * uli_setup_eret|      | m   ------                       V
+ *               |      | p  |      | uli_syscall          |
+ *                ------  |  |      |                      |
+ * uli_goto_user |      |<    ------                       |
+ *               |      |    |ptregs|                      |
+ *                  A            A                         |
+ *                  \-> ------    -----------<-------------
+ *         uli_handler |      |
+ *                     |      |
+ *                      ------
+ *      Kernel Handler |      |
+ *                     |      |
+ *
+ * Locks
+ *   There is one lock in the ULI which is called through ULILOCK and
+ * ULIUNLOCK.  This lock protects ULI creation / destruction.  Each handler
+ * can only run on one CPU.  To destroy a ULI, the function should run on
+ * its CPU, raise the interrupt level to keep the ULI from running, and then
+ * remove the ULI from the list of ULIs that can be run from that CPU.
+ *
+ *   Because ULIs are referenced through the file system we rely on the file
+ * system's standard methods for reference counting and the like.  Only
+ * processes which have a copy of a ULI's file open can block on it.  The ULI
+ * keeps a reference to its registering process's address space.
+ *
+ * Porting
+ *   To port ULI to a new architecture the following steps should be taken:
+ * - Add any architecture specific changes for the handler to libuli
+ * - Create a new <asm/uli_plat.h>.  This file must define:
+ *   - uli_context     - System state
+ *   - uli_sr          - CPU status register
+ *   - ULI_IRQS        - # of lines to support
+ *   - uli_delay       - Calculate cut off time for handler
+ *   - uli_setup_args  - One time arch specific set up routine
+ *   - uli_enable_fpu  - Reenable the kernel's FPU usage (optional)
+ *   - uli_disable_fpu - Disable the handler's FPU usage (optional)
+ * - Add uli_goto_user, uli_return_from_user, and uli_eret functions.
+ *   uli_goto_user saves system state and uli_return_from user restores it.
+ *   uli_eret prepares the CPU and does the rfi into the user's handler.
+ * - Modify the syscall entry and interrupt state saving / restoring code
+ * - Modify the architecture's IRQ processing code to check if it should
+ *   call into the ULI code.
+ */
+
+#include <linux/elfcore.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/interrupt.h>
+#include <linux/miscdevice.h>
+#include <linux/ptrace.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/smp.h>
+#include <linux/uli.h>
+
+#include <asm/mmu_context.h>
+#include <asm/semaphore.h>
+#include <asm/spinlock.h>
+#include <asm/uaccess.h>
+#include <asm/uli_plat.h>
+
+#define ULI_NAME "uli"
+
+static struct uli * uli_table[MAX_ULIS]; /* Points to all allocated ULIs */
+
+static spinlock_t uli_lock; /* Protects uli_table[] */
+
+#define ULILOCK(_flags) spin_lock_irqsave(&uli_lock, _flags)
+#define ULIUNLOCK(_flags) spin_unlock_irqrestore(&uli_lock, _flags)
+
+/* The ULI currently executing on each CPU */
+DEFINE_PER_CPU(struct uli *, uli_cur);
+
+static void uli_free(struct uli *);
+static int uli_ioctl(struct inode *, struct file *, unsigned int,
+			unsigned long);
+static int uli_release(struct inode *, struct file *);
+static ssize_t uli_write(struct file *, const char *, size_t, loff_t *);
+
+/* The file operations for /dev/uli */
+static struct file_operations uli_fops = {
+	ioctl: uli_ioctl,
+	release: uli_release,
+	write: uli_write,
+};
+
+/* The registration structure for /dev/uli */
+static struct miscdevice uli_miscdev = {
+	MISC_DYNAMIC_MINOR,
+	ULI_NAME,
+	&uli_fops,
+};
+
+/*
+ * Stop the passed ULI from running any more.
+ */
+static void
+uli_irq_teardown(struct uli * uli)
+{
+	/* Give up the IRQ */
+	free_irq((int)uli->teardownarg0, uli);
+}
+
+/*
+ * Help get the CPU ready to RFI into the ULI handler.  uli_eret
+ * will do the remainder of the work.
+ */
+void
+uli_setup_eret(struct uli * uli)
+{
+	struct uli ** cur_uli = &per_cpu(uli_cur, smp_processor_id());
+	union uli_sr sr;
+
+	/* Turn off all interrupts and get the CPU status */
+	local_irq_save(sr.psr_long);
+	uli->uli_saved_sr.psr_long = sr.psr_long;
+
+	/* Save previous ULI */
+	uli->uli_prev = *cur_uli;
+
+	/* Tell interrupt handling code that we're in a ULI */
+	uli->uli_double = 0;
+
+	/*
+	 * Set the current ULI.  We do this after setting uli_prev and
+	 * uli_double so that if another ULI comes in it will see a
+	 * consistent view.
+	 */
+	*cur_uli = uli;
+
+	/* Set up ULI thread's address space */
+	if (likely(current->active_mm != uli->uli_mm)) {
+		activate_mm(current->active_mm, uli->uli_mm);
+	}
+
+	/*
+	 * Set a time stamp so that we can tell if the ULI has
+	 * been running for too long and abort it.
+	 */
+	uli->uli_tstamp = uli_delay();
+
+	/* Reeanble interrupts and RFI into the ULI handler */
+	uli_eret(uli, uli->uli_sr.psr_long);
+
+	/*NOTREACHED*/
+	return;
+}
+
+/*
+ * This is called by a low level interrupt handler to call into
+ * the user's ULI handler.  During de-registration the
+ * specific device type code guarantees proper locking and that
+ * this uli won't be free'd out from under us.
+ */
+void
+uli_handler(struct uli * uli)
+{
+	struct uli ** cur_uli = &per_cpu(uli_cur, smp_processor_id());
+
+	/* Make sure this ULI is running where it's supposed to */
+	if (unlikely(uli->uli_cpu != smp_processor_id())) {
+		panic("ULI %p running on %d instead of %d\n",
+		      uli,
+		      smp_processor_id(),
+		      uli->uli_cpu);
+		return;
+	}
+
+	/* Save the current context and call uli_setup_eret to do the rfi */
+	uli_goto_user(uli);
+
+	/* The ULI is finished, restore VM info */
+	if (unlikely(!current->mm)) {
+		enter_lazy_tlb(current->active_mm, current);
+	} else if (likely(current->active_mm != uli->uli_mm)) {
+		activate_mm(uli->uli_mm, current->active_mm);
+	}
+
+	/* Reenable the FPU and interrupts */
+	uli_enable_fpu();
+	local_irq_restore(uli->uli_saved_sr.psr_long);
+
+	/* Restore any preempted ULI */
+	*cur_uli = uli->uli_prev;
+
+	/*
+	 * Check if we're expected to signal the ULI's creating process.
+	 * If we can't find it anymore then we destroy the ULI in order to
+	 * free up the affected address space and avoid weird situations.
+	 */
+	if (uli->uli_sig &&
+	    kill_proc_info(uli->uli_sig, SEND_SIG_FORCED,
+			     uli->uli_pid)) {
+		uli_free(uli);
+	}
+
+	return;
+}
+
+/*
+ * Run all the ULIs registered with the specified device.  This is
+ * assumed to be run at interrupt level so no locking of the ULI
+ * chain is needed.
+ */
+/*ARGSUSED*/
+static irqreturn_t
+uli_IRQ_handler(int dev, void * dev_id, struct pt_regs * regs)
+{
+	struct uli * uli = (struct uli *) dev_id;
+
+	/* Call the handler */
+	if (uli->uli_cpu == smp_processor_id()) {
+		uli_handler(uli);
+	}
+
+	return 0;
+}
+
+/*
+ * This is called at ULI completion time to return to the initiating
+ * code.  A ULI is considered to have completed when it successfully
+ * returns to the kernel or is aborted due to some fault.
+ */
+void
+uli_return(int sig, struct pt_regs * regs)
+{
+	struct uli * uli = per_cpu(uli_cur, local_cpu_data->cpu);
+
+	/* Save sig to be sent to ULI thread, if any */
+	uli->uli_sig = sig;
+
+	/*
+	 * If we were passed a particular context to store, copy them
+	 * into the ULI structure.  This currently only happens during
+	 * ULI abort because it's "too hard" to store the context data
+	 * into uli_eframe during the initial context save.
+	 */
+	if (regs) {
+		memcpy(&uli->uli_eframe, regs, sizeof(struct pt_regs));
+	}
+	
+	/* Return to where we fired off the ULI in uli_callup. */
+	uli_return_from_user(uli);
+
+	/*NOTREACHED*/
+}
+
+/*
+ * Generic set up code.
+ */
+int
+uli_new(struct uli ** uli_spot, struct uliargs * uargs)
+{
+	struct uli * uli;
+	int i;
+	unsigned long flags;
+
+	/* Validate the number of semaphores requested */
+	if (uargs->nsemas > ULI_MAX_SEMAS) {
+		return -EINVAL;
+	}
+
+	/* Allocate per-ULI data */
+	uli = kmalloc(ULI_SIZE(uargs->nsemas), GFP_KERNEL);
+	memset(uli, 0, ULI_SIZE(uargs->nsemas));
+	*uli_spot = uli;
+
+	/* Get a reference to the current address space */
+	if (!get_task_mm(current)) {
+		kfree(uli);
+		return -EBUSY;
+	}
+
+	/* Protect the global ULI table */
+	ULILOCK(flags);
+
+	/* Find a free spot from which to look up the ULI */
+	for (i = 0; i < MAX_ULIS; i++) {
+		if (uli_table[i] == NULL)
+			break;
+	}
+
+	/* No space left */
+	if (i == MAX_ULIS) {
+		ULIUNLOCK(flags);
+		kfree(uli);
+		return -EBUSY;
+	}
+
+	/* Record in the master table */
+	uli_table[i] = uli;
+	uli->uli_index = i;
+
+	/* Get the current context to use. */
+	uli->uli_pid = current->group_leader->pid;
+	uli->uli_mm = current->mm;
+
+	/* Set up the handler code */
+	uli->uli_sp = uargs->sp;
+	uli->uli_pc = uargs->pc;
+	uli->uli_gp = uargs->gp;
+	uli->uli_funcarg = uargs->funcarg;
+
+	/* Set up platform specific handler values */
+	uli_setup_args(uli, uargs);
+
+	/*
+	 * Disable the handler from using the FPU.  We don't save FPU
+	 * state for speed reasons, so this is necessary.  Anyone
+	 * nested above a ULI handler will either be another ULI or
+	 * other kernel code.
+	 */
+	uli_disable_fpu(uli->uli_sr);
+
+	/* Set up the semaphores */
+	uli->uli_nsemas = uargs->nsemas;
+	for (i = 0; i < uli->uli_nsemas; i++) {
+		sema_init(&uli->uli_sema[i], 0);
+	}
+
+	ULIUNLOCK(flags);
+
+	return 0;
+}
+
+/*
+ * Sleep on the passed semaphore of the passed ULI.
+ */
+static int
+uli_down(struct uli * uli, int sema)
+{
+	/* Check for a valid semaphore */
+	if (sema < 0 || sema >= uli->uli_nsemas) {
+		return -EINVAL;
+	}
+
+	/* Block allowing signals to wake us */
+	return down_interruptible(&uli->uli_sema[sema]);
+}
+
+/*
+ * Wake up the next thread on the passed semaphore of the passed ULI.
+ */
+static int
+uli_up(struct uli * uli, int sema)
+{
+	/* Check for a valid semaphore */
+	if (sema < 0 || sema >= uli->uli_nsemas) {
+		return -EINVAL;
+	}
+
+	/* Wake the next thread */
+	up(&uli->uli_sema[sema]);
+
+	return 0;
+}
+
+/*
+ * Destroy the passed ULI structure.  It first disconnects the ULI
+ * from its interrupt source then frees it.
+ */
+void
+uli_free(struct uli * uli)
+{
+	unsigned long flags;
+	cpumask_t oldmask;
+
+	/* Reschedule onto the ULI's CPU */
+	oldmask = current->cpus_allowed;
+	set_cpus_allowed(current, cpumask_of_cpu(uli->uli_cpu));
+
+	/* Block all interrupts so we know that the ULI isn't running */
+	ULILOCK(flags);
+
+	/* Disable the ULI */
+	uli_table[uli->uli_index] = NULL;
+	if (uli->uli_teardown) {
+		uli->uli_teardown(uli);
+	}
+
+	/* Reenable interrupts */
+	ULIUNLOCK(flags);
+
+	/* Reschedule */
+	set_cpus_allowed(current, oldmask);
+
+	/* Release the reference to its address space */
+	mmput(uli->uli_mm);
+
+	/* No longer need the per-ULI data */
+	kfree(uli);
+}
+
+/*
+ * When the per-interrupt opened file of /dev/uli is closed,
+ * this gets called so that we can free up any associated state.
+ */
+/*ARGSUSED*/
+static int
+uli_release(struct inode * inode, struct file * filp)
+{
+	struct uli * uli = filp->private_data;
+
+	/* If /dev/uli was opened but a ULI was never registered */
+	if (!uli) {
+		return 0;
+	}
+
+	/* For debugging purposes, clear the pointer to the ULI */
+	filp->private_data = NULL;
+
+	/* Call the generic free'ing function */
+	uli_free(uli);
+
+	return 0;
+}
+
+/*
+ * Handle ULI control operations
+ */
+static int
+uli_ioctl(struct inode * inode, struct file * filp,
+	   unsigned int cmd, unsigned long arg)
+{
+	struct uliargs uargs;
+	struct uli * uli;
+	int err;
+	unsigned long flags;
+
+	switch (cmd) {
+	case IOC_ULI_REG_IRQ:
+		/* We need to use the private_data field ourselves */
+		if (filp->private_data) {
+			return -EINVAL;
+		}
+
+		if (copy_from_user(&uargs, (void*)arg, sizeof(uargs))) {
+			return -EFAULT;
+		}
+
+		/* Validate the line requested */
+		if (uargs.id < 0 || uargs.id > ULI_IRQS) {
+			return -EINVAL;
+		}
+
+		/* Validate the CPU */
+		if (uargs.intarg > num_online_cpus()) {
+			return -EINVAL;
+		}
+
+		/* Create the ULI */
+		if ((err = uli_new(&uli, &uargs))) {
+			return err;
+		}
+
+		/* Store which line we registered with */
+		uli->teardownarg0 = uargs.id;
+
+		/* Mark which CPU the ULI can occur on */
+		uli->uli_cpu = uargs.intarg;
+
+		/* Request the IRQ */
+		err = request_irq(uargs.id, uli_IRQ_handler, SA_SHIRQ,
+				    "ULI", uli);
+		if (err) {
+			uli_free(uli);
+			return err;
+		}
+
+		/* Store the ULI for later teardown */
+		filp->private_data = uli;
+
+		/* Link the ULI into the interrupt line structure */
+		ULILOCK(flags);
+		uli->uli_teardown = uli_irq_teardown;
+		ULIUNLOCK(flags);
+
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ * Handle fast ULI operations.  We don't use ioctl because of
+ * the BKL.
+ */
+/*ARGSUSED*/
+static ssize_t
+uli_write(struct file * file, const char * buf, size_t count,
+	   loff_t * f_pos)
+{
+	struct uli * uli = (struct uli *)file->private_data;
+
+	/* The particular command was passed as the buffer address */
+	switch ((long)buf) {
+	case ULI_SLEEP_ADDR:
+		if (uli) {
+			return uli_down(uli, count);
+		}
+		return -EINVAL;
+		break;
+	case ULI_WAKEUP_ADDR:
+		if (uli) {
+			return uli_up(uli, count);
+		}
+		return -EINVAL;
+		break;
+	case ULI_RESOLV_ADDR: /* No action needed */
+		break;
+	}
+
+	return 0;
+}
+
+/*
+ * Handle fast ULI operations.  We make this look like sys_write()
+ * because libuli uses write() to return to the kernel from the handler.
+ * We can't always use uli_write() because the "current" running when
+ * the ULI handler does may not have the same file descriptor table.
+ */
+/*ARGSUSED*/
+asmlinkage ssize_t
+uli_syscall(int fd, const char * buf, size_t count,
+	     loff_t * f_pos)
+{
+	struct uli * uli = per_cpu(uli_cur, local_cpu_data->cpu);
+
+	/* The particular command was passed as the buffer address */
+	switch ((long)buf) {
+	case ULI_RETURN_ADDR: /* First for speed */
+		uli_return(0, NULL);
+		/*NOTREACHED*/
+		break;
+	case ULI_WAKEUP_ADDR:
+		return uli_up(uli, count);
+	default:
+		/*
+		 * No actual syscalls or any other ULI commands should be
+		 * called from a ULI handler.
+		 */
+		uli_return(SIGILL, (struct pt_regs *)uli->uli_intr_sp);
+		/*NOTREACHED*/
+	}
+
+	return -EINVAL;
+}
+
+/*
+ * This is called at startup time.  It creates the /dev
+ * ULI entry and handles setting up any other initial state.
+ */
+static int __init
+uli_init(void)
+{
+	int res, i;
+
+	/* They should already be NULL, but it can't hurt to be thorough */
+	for (i = 0; i < NR_CPUS; i++) {
+		per_cpu(uli_cur, i) = NULL;
+	}
+
+	/* Initialize the storage table */
+	for (i = 0; i < MAX_ULIS; i++) {
+		uli_table[i] = NULL;
+	}
+
+	/* Initialize the create / destroy lock */
+	spin_lock_init(&uli_lock);
+
+	/* Create the /dev ULI entry */
+	if ((res = misc_register(&uli_miscdev)) < 0) {
+		printk(KERN_ERR "%s: failed to register device, %d\n",
+			ULI_NAME, res);
+		return res;
+	}
+
+	return 0;
+}
+
+__initcall(uli_init);
+
+/*
+ * Should another kernel module wish to use ULIs, these are the minimum
+ * needed routines.
+ */
+EXPORT_SYMBOL(uli_free);
+EXPORT_SYMBOL(uli_handler);
+EXPORT_SYMBOL(uli_new);
+EXPORT_SYMBOL(uli_return);
diff -urN linux-2.6.11/include/asm-ia64/uli_plat.h linux-2.6.11-uli/include/asm-ia64/uli_plat.h
--- linux-2.6.11/include/asm-ia64/uli_plat.h	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.11-uli/include/asm-ia64/uli_plat.h	2005-03-10 06:45:52.621955200 -0600
@@ -0,0 +1,92 @@
+/*
+ * Copyright (c) 2005 Silicon Graphics, Inc.
+ * All rights reserved.
+ *
+ *   Michael A. Raymond <mraymond@sgi.com>
+ */
+
+/*
+ *  This file is part of the User Level Interrupt (ULI) feature.
+ *
+ *  ULI is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  ULI is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with ULI; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#ifndef __ARCH_ULI_H
+#define __ARCH_ULI_H
+
+#include <linux/ptrace.h>
+#include <asm/delay.h>
+#include <asm/irq.h>
+#include <asm/processor.h>
+
+/* Buffer to save minimum CPU context in */
+#define ULI_CTXTLEN 20
+typedef struct {
+	long _data[ULI_CTXTLEN];
+} uli_context __attribute__((__aligned__(16)));
+
+/* Simple union to make dealing with the processor state easier */
+union uli_sr {
+	struct ia64_psr psr_struct;
+	unsigned long psr_long;
+};
+
+#define ULI_IRQS NR_IRQS
+
+/* Some arbitrary point in the future */
+#define uli_delay() (ia64_get_itc() + 10000)
+
+/*
+ * Set up IA64 specific ULI handler values.  We must align the
+ * stack, get r13, and set the IP to the first instruction in the
+ * passed bundle.
+ */
+#define uli_setup_args(uli, uargs) \
+{	\
+	struct pt_regs * regs = ia64_task_regs(current);	\
+	unsigned long addr = (unsigned long)uli->uli_sp -	\
+		uargs->stacksize;	\
+\
+	/* The BSP must be 8-byte aligned */	\
+	addr = (addr + 0x7) & ~0x7;	\
+	uli->uli_arch0 = (caddr_t)addr;	\
+\
+	/* The sp must be 16-byte aligned */	\
+	addr = (unsigned long)uli->uli_sp & ~0xF;	\
+	uli->uli_sp = (caddr_t)addr;	\
+\
+	/* Set its user thread pointer */	\
+	uli->uli_arch1 = (void*)regs->r13;	\
+\
+	/* Get the status register value to use */	\
+	uli->uli_sr.psr_long = regs->cr_ipsr;	\
+\
+	/* Start with the first instruction in the bundle */	\
+	uli->uli_sr.psr_struct.ri = 0;	\
+}
+
+/*
+ * Reenable the FPU when the ULI handler is completed
+ */
+#define uli_enable_fpu()
+
+/*
+ * Platform specific disabling of FPU
+ */
+#define uli_disable_fpu(sr) \
+	sr.psr_struct.dfl = 1; \
+	sr.psr_struct.dfh = 1;
+
+#endif /* __ARCH_ULI_H */
diff -urN linux-2.6.11/include/linux/uli.h linux-2.6.11-uli/include/linux/uli.h
--- linux-2.6.11/include/linux/uli.h	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.11-uli/include/linux/uli.h	2005-03-23 09:15:07.875463206 -0600
@@ -0,0 +1,167 @@
+/*
+ * Copyright (c) 2005 Silicon Graphics, Inc.
+ * All rights reserved.
+ *
+ *   Michael A. Raymond <mraymond@sgi.com>
+ */
+
+/*
+ *  This file is part of the User Level Interrupt (ULI) feature.
+ *
+ *  ULI is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  ULI is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with ULI; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#ifndef __SYS_ULI_H
+#define __SYS_ULI_H
+
+#if defined(__cplusplus)
+extern "C" {
+#endif
+
+/* This is the ULI /dev entry */
+#define ULI_DEV "/dev/uli"
+
+/*
+ * This structure contains the arguments that must be passed to
+ * register ULIs.
+ */
+struct uliargs {
+	/* device independent fields */
+	caddr_t pc;		/* PC of handler function */
+	caddr_t gp;		/* GP for handler function */
+	caddr_t sp;		/* Base SP of stack to use */
+	size_t stacksize;	/* Size of stack (needed for IA64) */
+	void * funcarg;		/* argument to handler function */
+	unsigned int nsemas;		/* ULI's semaphores to sleep on */
+
+	int id;			/* Interrupt device specifier */
+	unsigned long intarg;	/* Special device parameter */
+};
+
+/* /dev/uli ioctl arguments */
+#define IOC_ULI_REG_IRQ 0x0010 /* Register a ULI for an IRQ line */
+
+/* /dev/uli I/O addresses */
+#define ULI_SLEEP_ADDR	0x100	/* ULI_sleep */
+#define ULI_WAKEUP_ADDR	0x200	/* ULI_wakeup */
+#define ULI_RETURN_ADDR	0x300	/* return from intr */
+#define ULI_RESOLV_ADDR	0x500	/* For pre-resolving symbols */
+
+#define ULI_MAX_SEMAS	32	/* Maximum number supported */
+
+/********************************************************************/
+#if defined(__KERNEL__)
+#if defined(CONFIG_ULI)
+
+#include <linux/config.h>
+#include <linux/elf.h>
+#include <linux/ptrace.h>
+#include <linux/types.h>
+#include <asm/mmu.h>
+#include <asm/percpu.h>
+#include <asm/semaphore.h>
+#include <asm/uli_plat.h>
+
+#define MAX_ULIS 64 /* Max number of ULIs supported */
+
+/*
+ * This kernel per-ULI structure keeps track off all its state.
+ */
+struct uli {
+	/* This must be first */
+	uli_context uli_context;		/* State before user handler */
+
+	caddr_t uli_gp;			/* Handler's GP */
+	caddr_t uli_sp;			/* Handler's SP */
+	union uli_sr uli_sr;		/* Handler's SR */
+	caddr_t uli_pc;			/* Handler's PC */
+	void * uli_funcarg;		/* Argument to handler */
+	caddr_t uli_arch0;		/* Arch specific user register */
+	caddr_t uli_arch1;		/* Arch specific user register */
+
+	pid_t uli_pid;		/* The registering process */
+	struct mm_struct * uli_mm;	/* MM of owning process */
+	unsigned long uli_tstamp;		/* Time ULI started */
+
+	unsigned int uli_double;	/* In doubly nested interrupt? */
+	unsigned long uli_intr_sp;	/* SP at time of goto user */
+	union uli_sr uli_saved_sr;	/* SR at time of goto user */
+	caddr_t uli_saved_epc;		/* PC interrupted by ULI handled intr */
+	unsigned long uli_intr_arch0;	/* Arch reg at goto user */
+
+	short uli_cpu;			/* Only this calls the handler */
+	struct uli * uli_next;		/* per-dev list of registered ULIs */
+	struct uli * uli_prev;		/* ULI preempted by this one */
+	int uli_sig;			/* Error status of ULI handler */
+	int uli_index;			/* ULI's spot in uli_table[] */
+
+	struct pt_regs uli_eframe;	/* Context of failed ULI */
+
+	/* Device dependent teardown func to disconnect interrupt */
+	void (*uli_teardown)(struct uli*);	/* Teardown from reg'd dev */
+	unsigned long teardownarg0;		/* Per-device teardown data */
+	unsigned long teardownarg1;		/* to be referenced from the */
+	unsigned long teardownarg2;		/* teardown handler */
+
+	int uli_nsemas;			/* # of semaphores in uli_sema[] */
+
+	/* Must be last element */
+	struct semaphore uli_sema[1];	/* So threads can queue off this ULI */
+};
+
+/* Size of the total ULI struct given number of semaphores */
+#define ULI_SIZE(nsemas) ((size_t)&(((struct uli*)0)->uli_sema[nsemas]))
+
+extern void uli_callup(unsigned int);
+extern void uli_eret(struct uli *, unsigned long);
+extern void uli_goto_user(struct uli *);
+extern void uli_handler(struct uli *);
+extern void uli_return(int, struct pt_regs *);
+extern void uli_return_from_user(struct uli *);
+extern void uli_setup_eret(struct uli *);
+
+/*
+ * If we're in a ULI and we commit any kind of illegal
+ * instruction,  we abort the ULI and send a signal to the
+ * owning process.
+ */
+static inline void
+uli_trap(int sig, struct pt_regs * regs)
+{
+	extern struct uli * per_cpu__uli_cur;
+	struct uli * uli = per_cpu(uli_cur, local_cpu_data->cpu);
+
+	/*
+	 * If uli_double > 1 then the fault wasn't the fault of the
+	 * ULI handler.
+	 */
+	if (uli &&
+	    uli->uli_double == 1) {
+		uli_return(sig, regs);
+	}
+}
+
+#else /* CONFIG_ULI */
+
+#define uli_trap(sig, regs) do {} while (0)
+
+#endif /* CONFIG_ULI */
+#endif /* __KERNEL__ */
+
+#if defined(__cplusplus)
+}
+#endif
+
+#endif /* __SYS_ULI_H */

--NzB8fVQJ5HfG6fxh--
