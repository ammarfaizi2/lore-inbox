Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267971AbUHUWXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267971AbUHUWXr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 18:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267975AbUHUWXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 18:23:47 -0400
Received: from darwin.snarc.org ([81.56.210.228]:51928 "EHLO darwin.snarc.org")
	by vger.kernel.org with ESMTP id S267971AbUHUWX1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 18:23:27 -0400
Date: Sun, 22 Aug 2004 00:23:18 +0200
To: lkml <linux-kernel@vger.kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] ppc32 use simplified mmenonics
Message-ID: <20040821222318.GA32229@snarc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Email may contain unsmilyfied humor and/or satire.
User-Agent: Mutt/1.5.6+20040803i
From: Vincent Hanquez <tab@snarc.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi LKML and Benjamin,

This patch substitutes complex rlwinm instruction to the simplied
instruction clrrwi when possible.

This has the same meaning as the ppc knows only about rlwinm; clrrwi
is just a language simplification.

basicly it's a : s/rlwinm R1,R2,0,0,31-N/clrrwi R1,R2,N/

Please apply or comments,
Thanks

Signed-off-by: Vincent Hanquez <tab@snarc.org>

diff -u -Naur linux-2.6.8.1.orig/arch/ppc/kernel/entry.S linux-2.6.8.1/arch/ppc/kernel/entry.S
--- linux-2.6.8.1.orig/arch/ppc/kernel/entry.S	2004-08-21 21:56:22.000000000 +0200
+++ linux-2.6.8.1/arch/ppc/kernel/entry.S	2004-08-21 21:57:47.000000000 +0200
@@ -198,7 +198,7 @@
 #ifdef SHOW_SYSCALLS
 	bl	do_show_syscall
 #endif /* SHOW_SYSCALLS */
-	rlwinm	r10,r1,0,0,18	/* current_thread_info() */
+	clrrwi	r10,r1,13	/* current_thread_info() */
 	lwz	r11,TI_LOCAL_FLAGS(r10)
 	rlwinm	r11,r11,0,~_TIFL_FORCE_NOERROR
 	stw	r11,TI_LOCAL_FLAGS(r10)
@@ -223,7 +223,7 @@
 	mr	r6,r3
 	li	r11,-_LAST_ERRNO
 	cmpl	0,r3,r11
-	rlwinm	r12,r1,0,0,18	/* current_thread_info() */
+	clrrwi	r12,r1,13	/* current_thread_info() */
 	blt+	30f
 	lwz	r11,TI_LOCAL_FLAGS(r12)
 	andi.	r11,r11,_TIFL_FORCE_NOERROR
@@ -310,7 +310,7 @@
 	LOAD_MSR_KERNEL(r10,MSR_KERNEL)	/* doesn't include MSR_EE */
 	SYNC
 	MTMSRD(r10)		/* disable interrupts again */
-	rlwinm	r12,r1,0,0,18	/* current_thread_info() */
+	clrrwi	r12,r1,13	/* current_thread_info() */
 	lwz	r9,TI_FLAGS(r12)
 5:
 	andi.	r0,r9,_TIF_NEED_RESCHED
@@ -407,7 +407,7 @@
 ppc_sigsuspend:
 	SAVE_NVGPRS(r1)
 	lwz	r0,TRAP(r1)
-	rlwinm	r0,r0,0,0,30		/* clear LSB to indicate full */
+	clrrwi	r0,r0,1			/* clear LSB to indicate full */
 	stw	r0,TRAP(r1)		/* register set saved */
 	b	sys_sigsuspend
 
@@ -415,15 +415,15 @@
 ppc_rt_sigsuspend:
 	SAVE_NVGPRS(r1)
 	lwz	r0,TRAP(r1)
-	rlwinm	r0,r0,0,0,30
-	stw	r0,TRAP(r1)
+	clrrwi	r0,r0,1			/* clear LSB to indicate full */
+	stw	r0,TRAP(r1)		/* register set saved */
 	b	sys_rt_sigsuspend
 
 	.globl	ppc_fork
 ppc_fork:
 	SAVE_NVGPRS(r1)
 	lwz	r0,TRAP(r1)
-	rlwinm	r0,r0,0,0,30		/* clear LSB to indicate full */
+	clrrwi	r0,r0,1			/* clear LSB to indicate full */
 	stw	r0,TRAP(r1)		/* register set saved */
 	b	sys_fork
 
@@ -431,7 +431,7 @@
 ppc_vfork:
 	SAVE_NVGPRS(r1)
 	lwz	r0,TRAP(r1)
-	rlwinm	r0,r0,0,0,30		/* clear LSB to indicate full */
+	clrrwi	r0,r0,1			/* clear LSB to indicate full */
 	stw	r0,TRAP(r1)		/* register set saved */
 	b	sys_vfork
 
@@ -439,7 +439,7 @@
 ppc_clone:
 	SAVE_NVGPRS(r1)
 	lwz	r0,TRAP(r1)
-	rlwinm	r0,r0,0,0,30		/* clear LSB to indicate full */
+	clrrwi	r0,r0,1			/* clear LSB to indicate full */
 	stw	r0,TRAP(r1)		/* register set saved */
 	b	sys_clone
 
@@ -447,7 +447,7 @@
 ppc_swapcontext:
 	SAVE_NVGPRS(r1)
 	lwz	r0,TRAP(r1)
-	rlwinm	r0,r0,0,0,30		/* clear LSB to indicate full */
+	clrrwi	r0,r0,1			/* clear LSB to indicate full */
 	stw	r0,TRAP(r1)		/* register set saved */
 	b	sys_swapcontext
 
@@ -566,7 +566,7 @@
 	.globl	sigreturn_exit
 sigreturn_exit:
 	subi	r1,r3,STACK_FRAME_OVERHEAD
-	rlwinm	r12,r1,0,0,18	/* current_thread_info() */
+	clrrwi	r12,r1,13	/* current_thread_info() */
 	lwz	r9,TI_FLAGS(r12)
 	andi.	r0,r9,_TIF_SYSCALL_TRACE
 	bnel-	do_syscall_trace
@@ -592,7 +592,7 @@
 
 user_exc_return:		/* r10 contains MSR_KERNEL here */
 	/* Check current_thread_info()->flags */
-	rlwinm	r9,r1,0,0,18
+	clrrwi	r9,r1,13
 	lwz	r9,TI_FLAGS(r9)
 	andi.	r0,r9,(_TIF_SIGPENDING|_TIF_NEED_RESCHED)
 	bne	do_work
@@ -611,7 +611,7 @@
 /* N.B. the only way to get here is from the beq following ret_from_except. */
 resume_kernel:
 	/* check current_thread_info->preempt_count */
-	rlwinm	r9,r1,0,0,18
+	clrrwi	r9,r1,13
 	lwz	r0,TI_PREEMPT(r9)
 	cmpwi	0,r0,0		/* if non-zero, just restore regs and return */
 	bne	restore
@@ -629,7 +629,7 @@
 	LOAD_MSR_KERNEL(r10,MSR_KERNEL)
 	SYNC
 	MTMSRD(r10)		/* disable interrupts */
-	rlwinm	r9,r1,0,0,18
+	clrrwi	r9,r1,13
 	li	r0,0
 	stw	r0,TI_PREEMPT(r9)
 	lwz	r3,TI_FLAGS(r9)
@@ -912,7 +912,7 @@
 	LOAD_MSR_KERNEL(r10,MSR_KERNEL)
 	SYNC
 	MTMSRD(r10)		/* disable interrupts */
-	rlwinm	r9,r1,0,0,18
+	clrrwi	r9,r1,13
 	lwz	r9,TI_FLAGS(r9)
 	andi.	r0,r9,_TIF_NEED_RESCHED
 	bne-	do_resched
@@ -927,7 +927,7 @@
 	andi.	r0,r3,1
 	beq	2f
 	SAVE_NVGPRS(r1)
-	rlwinm	r3,r3,0,0,30
+	clrrwi	r3,r3,1
 	stw	r3,TRAP(r1)
 2:	li	r3,0
 	addi	r4,r1,STACK_FRAME_OVERHEAD
@@ -964,7 +964,7 @@
 	andi.	r0,r3,1
 	beq	4f
 	SAVE_NVGPRS(r1)
-	rlwinm	r3,r3,0,0,30
+	clrrwi	r3,r3,1
 	stw	r3,TRAP(r1)
 4:	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	nonrecoverable_exception
diff -u -Naur linux-2.6.8.1.orig/arch/ppc/kernel/head_44x.S linux-2.6.8.1/arch/ppc/kernel/head_44x.S
--- linux-2.6.8.1.orig/arch/ppc/kernel/head_44x.S	2004-08-21 21:56:22.000000000 +0200
+++ linux-2.6.8.1/arch/ppc/kernel/head_44x.S	2004-08-21 21:57:47.000000000 +0200
@@ -571,7 +571,7 @@
 	ori	r11, r11, swapper_pg_dir@l
 
 	mfspr   r12,SPRN_MMUCR
-	rlwinm	r12,r12,0,0,23		/* Clear TID */
+	clrrwi	r12,r12,8		/* Clear TID */
 
 	b	4f
 
@@ -590,7 +590,7 @@
 
 	rlwinm  r12, r10, 13, 19, 29    /* Compute pgdir/pmd offset */
 	lwzx    r11, r12, r11           /* Get pgd/pmd entry */
-	rlwinm. r12, r11, 0, 0, 20      /* Extract pt base address */
+	clrrwi. r12, r11, 11		/* Extract pt base address */
 	beq     2f                      /* Bail if no table */
 
 	rlwimi  r12, r10, 23, 20, 28    /* Compute pte address */
@@ -720,7 +720,7 @@
 	ori	r11, r11, swapper_pg_dir@l
 
 	mfspr	r12,SPRN_MMUCR
-	rlwinm	r12,r12,0,0,23		/* Clear TID */
+	clrrwi	r12,r12,8		/* Clear TID */
 
 	b	4f
 
@@ -739,7 +739,7 @@
 
 	rlwinm 	r12, r10, 13, 19, 29	/* Compute pgdir/pmd offset */
 	lwzx	r11, r12, r11		/* Get pgd/pmd entry */
-	rlwinm.	r12, r11, 0, 0, 20	/* Extract pt base address */
+	clrrwi. r12, r11, 11		/* Extract pt base address */
 	beq	2f			/* Bail if no table */
 
 	rlwimi	r12, r10, 23, 20, 28	/* Compute pte address */
@@ -789,7 +789,7 @@
 	ori	r11, r11, swapper_pg_dir@l
 
 	mfspr	r12,SPRN_MMUCR
-	rlwinm	r12,r12,0,0,23		/* Clear TID */
+	clrrwi	r12,r12,8		/* Clear TID */
 
 	b	4f
 
@@ -808,7 +808,7 @@
 
 	rlwinm	r12, r10, 13, 19, 29	/* Compute pgdir/pmd offset */
 	lwzx	r11, r12, r11		/* Get pgd/pmd entry */
-	rlwinm.	r12, r11, 0, 0, 20	/* Extract pt base address */
+	clrrwi. r12, r11, 11		/* Extract pt base address */
 	beq	2f			/* Bail if no table */
 
 	rlwimi	r12, r10, 23, 20, 28	/* Compute pte address */
diff -u -Naur linux-2.6.8.1.orig/arch/ppc/kernel/head_4xx.S linux-2.6.8.1/arch/ppc/kernel/head_4xx.S
--- linux-2.6.8.1.orig/arch/ppc/kernel/head_4xx.S	2004-08-21 21:56:22.000000000 +0200
+++ linux-2.6.8.1/arch/ppc/kernel/head_4xx.S	2004-08-21 21:57:47.000000000 +0200
@@ -347,7 +347,7 @@
 	tophys(r11, r11)
 	rlwimi	r11, r10, 12, 20, 29	/* Create L1 (pgdir/pmd) address */
 	lwz	r11, 0(r11)		/* Get L1 entry */
-	rlwinm.	r12, r11, 0, 0, 19	/* Extract L2 (pte) base address */
+	clrrwi.	r12, r11, 12		/* Extract L2 (pte) base address */
 	beq	2f			/* Bail if no table */
 
 	rlwimi	r12, r10, 22, 20, 29	/* Compute PTE address */
diff -u -Naur linux-2.6.8.1.orig/arch/ppc/kernel/head_8xx.S linux-2.6.8.1/arch/ppc/kernel/head_8xx.S
--- linux-2.6.8.1.orig/arch/ppc/kernel/head_8xx.S	2004-08-21 21:56:22.000000000 +0200
+++ linux-2.6.8.1/arch/ppc/kernel/head_8xx.S	2004-08-21 22:36:37.000000000 +0200
@@ -329,7 +329,7 @@
 	rlwimi	r20, r21, 0, 2, 19
 3:
 	lwz	r21, 0(r20)	/* Get the level 1 entry */
-	rlwinm.	r20, r21,0,0,19	/* Extract page descriptor page address */
+	clrrwi.	r20, r21,12	/* Extract page descriptor page address */
 	beq	2f		/* If zero, don't try to find a pte */
 
 	/* We have a pte table, so load the MI_TWC with the attributes
@@ -413,7 +413,7 @@
 	rlwimi r20, r21, 0, 2, 19
 3:
 	lwz	r21, 0(r20)	/* Get the level 1 entry */
-	rlwinm.	r20, r21,0,0,19	/* Extract page descriptor page address */
+	clrrwi.	r20, r21,12	/* Extract page descriptor page address */
 	beq	2f		/* If zero, don't try to find a pte */
 
 	/* We have a pte table, so load fetch the pte from the table.
@@ -533,7 +533,7 @@
 	 * assuming we only use the dcbi instruction on kernel addresses.
 	 */
 	mfspr	r20, DAR
-	rlwinm	r21, r20, 0, 0, 19
+	clrrwi	r21, r20, 12
 	ori	r21, r21, MD_EVALID
 	mfspr	r20, M_CASID
 	rlwimi	r21, r20, 0, 28, 31
@@ -556,7 +556,7 @@
 	rlwimi	r20, r21, 0, 2, 19
 3:
 	lwz	r21, 0(r20)	/* Get the level 1 entry */
-	rlwinm.	r20, r21,0,0,19	/* Extract page descriptor page address */
+	clrrwi.	r20, r21,12	/* Extract page descriptor page address */
 	beq	2f		/* If zero, bail */
 
 	/* We have a pte table, so fetch the pte from the table.
diff -u -Naur linux-2.6.8.1.orig/arch/ppc/kernel/head_e500.S linux-2.6.8.1/arch/ppc/kernel/head_e500.S
--- linux-2.6.8.1.orig/arch/ppc/kernel/head_e500.S	2004-08-21 21:56:22.000000000 +0200
+++ linux-2.6.8.1/arch/ppc/kernel/head_e500.S	2004-08-21 22:37:50.000000000 +0200
@@ -640,7 +640,7 @@
 4:
 	rlwimi	r11, r10, 12, 20, 29	/* Create L1 (pgdir/pmd) address */
 	lwz	r11, 0(r11)		/* Get L1 entry */
-	rlwinm.	r12, r11, 0, 0, 19	/* Extract L2 (pte) base address */
+	clrrwi.	r12, r11, 12		/* Extract L2 (pte) base address */
 	beq	2f			/* Bail if no table */
 
 	rlwimi	r12, r10, 22, 20, 29	/* Compute PTE address */
@@ -787,7 +787,7 @@
 4:
 	rlwimi	r11, r10, 12, 20, 29	/* Create L1 (pgdir/pmd) address */
 	lwz	r11, 0(r11)		/* Get L1 entry */
-	rlwinm.	r12, r11, 0, 0, 19	/* Extract L2 (pte) base address */
+	clrrwi.	r12, r11, 12		/* Extract L2 (pte) base address */
 	beq	2f			/* Bail if no table */
 
 	rlwimi	r12, r10, 22, 20, 29	/* Compute PTE address */
@@ -852,7 +852,7 @@
 4:
 	rlwimi	r11, r10, 12, 20, 29	/* Create L1 (pgdir/pmd) address */
 	lwz	r11, 0(r11)		/* Get L1 entry */
-	rlwinm.	r12, r11, 0, 0, 19	/* Extract L2 (pte) base address */
+	clrrwi.	r12, r11, 12		/* Extract L2 (pte) base address */
 	beq	2f			/* Bail if no table */
 
 	rlwimi	r12, r10, 22, 20, 29	/* Compute PTE address */
diff -u -Naur linux-2.6.8.1.orig/arch/ppc/kernel/head.S linux-2.6.8.1/arch/ppc/kernel/head.S
--- linux-2.6.8.1.orig/arch/ppc/kernel/head.S	2004-08-21 21:56:22.000000000 +0200
+++ linux-2.6.8.1/arch/ppc/kernel/head.S	2004-08-21 22:38:56.000000000 +0200
@@ -532,7 +532,7 @@
 112:	tophys(r2,r2)
 	rlwimi	r2,r3,12,20,29		/* insert top 10 bits of address */
 	lwz	r2,0(r2)		/* get pmd entry */
-	rlwinm.	r2,r2,0,0,19		/* extract address of pte page */
+	clrrwi.	r2,r2,12		/* extract address of pte page */
 	beq-	InstructionAddressInvalid	/* return if no mapping */
 	rlwimi	r2,r3,22,20,29		/* insert next 10 bits of address */
 	lwz	r3,0(r2)		/* get linux-style pte */
@@ -606,7 +606,7 @@
 112:	tophys(r2,r2)
 	rlwimi	r2,r3,12,20,29		/* insert top 10 bits of address */
 	lwz	r2,0(r2)		/* get pmd entry */
-	rlwinm.	r2,r2,0,0,19		/* extract address of pte page */
+	clrrwi.	r2,r2,12		/* extract address of pte page */
 	beq-	DataAddressInvalid	/* return if no mapping */
 	rlwimi	r2,r3,22,20,29		/* insert next 10 bits of address */
 	lwz	r3,0(r2)		/* get linux-style pte */
@@ -678,7 +678,7 @@
 112:	tophys(r2,r2)
 	rlwimi	r2,r3,12,20,29		/* insert top 10 bits of address */
 	lwz	r2,0(r2)		/* get pmd entry */
-	rlwinm.	r2,r2,0,0,19		/* extract address of pte page */
+	clrrwi.	r2,r2,12		/* extract address of pte page */
 	beq-	DataAddressInvalid	/* return if no mapping */
 	rlwimi	r2,r3,22,20,29		/* insert next 10 bits of address */
 	lwz	r3,0(r2)		/* get linux-style pte */
diff -u -Naur linux-2.6.8.1.orig/arch/ppc/kernel/idle_6xx.S linux-2.6.8.1/arch/ppc/kernel/idle_6xx.S
--- linux-2.6.8.1.orig/arch/ppc/kernel/idle_6xx.S	2004-08-21 21:56:22.000000000 +0200
+++ linux-2.6.8.1/arch/ppc/kernel/idle_6xx.S	2004-08-21 22:39:45.000000000 +0200
@@ -93,7 +93,7 @@
 	mtmsr	r0
 
 	/* Check current_thread_info()->flags */
-	rlwinm	r4,r1,0,0,18
+	clrrwi	r4,r1,13
 	lwz	r4,TI_FLAGS(r4)
 	andi.	r0,r4,_TIF_NEED_RESCHED
 	beq	1f
@@ -111,7 +111,7 @@
 	 * doesn't even bother doing the dcbf's here...
 	 */
 	mfspr	r4,SPRN_MSSCR0
-	rlwinm	r4,r4,0,0,29
+	clrrwi	r4,r4,2
 	sync
 	mtspr	SPRN_MSSCR0,r4
 	sync
@@ -189,7 +189,7 @@
 1:
 #endif
 	
-	rlwinm	r9,r1,0,0,18
+	clrrwi	r9,r1,13
 	tophys(r9,r9)
 	lwz	r11,TI_CPU(r9)
 	slwi	r11,r11,2
diff -u -Naur linux-2.6.8.1.orig/arch/ppc/kernel/idle_power4.S linux-2.6.8.1/arch/ppc/kernel/idle_power4.S
--- linux-2.6.8.1.orig/arch/ppc/kernel/idle_power4.S	2004-08-21 21:56:22.000000000 +0200
+++ linux-2.6.8.1/arch/ppc/kernel/idle_power4.S	2004-08-21 22:40:06.000000000 +0200
@@ -65,7 +65,7 @@
 	mtmsr	r0
 
 	/* Check current_thread_info()->flags */
-	rlwinm	r4,r1,0,0,18
+	clrrwi	r4,r1,13
 	lwz	r4,TI_FLAGS(r4)
 	andi.	r0,r4,_TIF_NEED_RESCHED
 	beq	1f
diff -u -Naur linux-2.6.8.1.orig/arch/ppc/kernel/misc.S linux-2.6.8.1/arch/ppc/kernel/misc.S
--- linux-2.6.8.1.orig/arch/ppc/kernel/misc.S	2004-08-21 21:56:22.000000000 +0200
+++ linux-2.6.8.1/arch/ppc/kernel/misc.S	2004-08-21 22:33:33.000000000 +0200
@@ -232,7 +232,7 @@
 	mtspr	SPRN_HID1,r4
 
 	/* Store new HID1 image */
-	rlwinm	r6,r1,0,0,18
+	clrrwi	r6,r1,13
 	lwz	r6,TI_CPU(r6)
 	slwi	r6,r6,2
 	addis	r6,r6,nap_save_hid1@ha
@@ -456,7 +456,7 @@
 #endif /* CONFIG_SMP */
 #else /* !(CONFIG_40x || CONFIG_44x || CONFIG_FSL_BOOKE) */
 #if defined(CONFIG_SMP)
-	rlwinm	r8,r1,0,0,18
+	clrrwi	r8,r1,13
 	lwz	r8,TI_CPU(r8)
 	oris	r8,r8,10
 	mfmsr	r10
@@ -523,7 +523,7 @@
 	isync
 10:
 #elif defined(CONFIG_FSL_BOOKE)
-	rlwinm	r4, r3, 0, 0, 19
+	clrrwi	r4, r3, 12
 	ori	r5, r4, 0x08	/* TLBSEL = 1 */
 	ori	r6, r4, 0x10	/* TLBSEL = 2 */
 	ori	r7, r4, 0x18	/* TLBSEL = 3 */
@@ -537,7 +537,7 @@
 #endif /* CONFIG_SMP */
 #else /* !(CONFIG_40x || CONFIG_44x || CONFIG_FSL_BOOKE) */
 #if defined(CONFIG_SMP)
-	rlwinm	r8,r1,0,0,18
+	clrrwi	r8,r1,13
 	lwz	r8,TI_CPU(r8)
 	oris	r8,r8,11
 	mfmsr	r10
@@ -739,7 +739,7 @@
 	rlwinm	r5,r5,16,16,31
 	cmpi	0,r5,1
 	beqlr					/* for 601, do nothing */
-	rlwinm	r3,r3,0,0,19			/* Get page base address */
+	clrrwi	r3,r3,12			/* Get page base address */
 	li	r4,4096/L1_CACHE_LINE_SIZE	/* Number of lines in a page */
 	mtctr	r4
 	mr	r6,r3
@@ -772,7 +772,7 @@
 	rlwinm	r0,r10,0,28,26			/* clear DR */
 	mtmsr	r0
 	isync
-	rlwinm	r3,r3,0,0,19			/* Get page base address */
+	clrrwi	r3,r3,12			/* Get page base address */
 	li	r4,4096/L1_CACHE_LINE_SIZE	/* Number of lines in a page */
 	mtctr	r4
 	mr	r6,r3
diff -u -Naur linux-2.6.8.1.orig/arch/ppc/kernel/ppc_htab.c linux-2.6.8.1/arch/ppc/kernel/ppc_htab.c
--- linux-2.6.8.1.orig/arch/ppc/kernel/ppc_htab.c	2004-08-21 21:56:22.000000000 +0200
+++ linux-2.6.8.1/arch/ppc/kernel/ppc_htab.c	2004-08-21 21:59:05.000000000 +0200
@@ -275,7 +275,7 @@
 		/* setup mmcr0 and clear the correct pmc */
 	       asm volatile(
 		       "mfspr %0,%1\n\t"     /* get current mccr0 */
-		       "rlwinm %0,%0,0,0,31-6\n\t"  /* clear bits [26-31] */
+		       "clrrwi %0,%0,6\n\t"  /* clear bits [26-31] */
 		       "ori   %0,%0,%2 \n\t" /* or in mmcr0 settings */
 		       "mtspr %1,%0 \n\t"    /* set new mccr0 */
 		       "mtspr %3,%4 \n\t"    /* reset the pmc */
@@ -290,7 +290,7 @@
 		/* setup mmcr0 and clear the correct pmc */
 	       asm volatile(
 		       "mfspr %0,%1\n\t"     /* get current mccr0 */
-		       "rlwinm %0,%0,0,0,31-6\n\t"  /* clear bits [26-31] */
+		       "clrrwi %0,%0,6\n\t"  /* clear bits [26-31] */
 		       "ori   %0,%0,%2 \n\t" /* or in mmcr0 settings */
 		       "mtspr %1,%0 \n\t"    /* set new mccr0 */
 		       "mtspr %3,%4 \n\t"    /* reset the pmc */
@@ -304,7 +304,7 @@
 		/* setup mmcr0 and clear the correct pmc */
 	       asm volatile(
 		       "mfspr %0,%1\n\t"     /* get current mccr0 */
-		       "rlwinm %0,%0,0,0,31-6\n\t"  /* clear bits [26-31] */
+		       "clrrwi %0,%0,6\n\t"  /* clear bits [26-31] */
 		       "ori   %0,%0,%2 \n\t" /* or in mmcr0 settings */
 		       "mtspr %1,%0 \n\t"    /* set new mccr0 */
 		       "mtspr %3,%4 \n\t"    /* reset the pmc */
