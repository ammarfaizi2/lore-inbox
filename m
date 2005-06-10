Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262410AbVFJClg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbVFJClg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 22:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbVFJClg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 22:41:36 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:39337 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S262410AbVFJCkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 22:40:51 -0400
Date: Thu, 9 Jun 2005 21:40:39 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>
cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] ppc32: Factor out common exception code into macro's for
 4xx/Book-E
Message-ID: <Pine.LNX.4.61.0506092140070.24892@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

4xx and Book-E PPC's have several exception levels.  The code to handle
each level is fairly regular.  Turning the code into macro's will ease
the handling of future exception levels (debug) in forth coming chips.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 03d7635f7da398ffc32f53520090d34a1476755d
tree 9186ada6aa7177a41e2368e60dfc3596e3e30017
parent 24e4731a8b0b74af65f39fa11cc3a520e52f0a63
author Kumar K. Gala <kumar.gala@freescale.com> Thu, 09 Jun 2005 21:39:12 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Thu, 09 Jun 2005 21:39:12 -0500

 arch/ppc/kernel/entry.S      |  164 ++++++++++++++++--------------------------
 arch/ppc/kernel/head_booke.h |   94 ++++++------------------
 2 files changed, 87 insertions(+), 171 deletions(-)

diff --git a/arch/ppc/kernel/entry.S b/arch/ppc/kernel/entry.S
--- a/arch/ppc/kernel/entry.S
+++ b/arch/ppc/kernel/entry.S
@@ -46,26 +46,23 @@
 
 #ifdef CONFIG_BOOKE
 #include "head_booke.h"
+#define TRANSFER_TO_HANDLER_EXC_LEVEL(exc_level)	\
+	mtspr	exc_level##_SPRG,r8;			\
+	BOOKE_LOAD_EXC_LEVEL_STACK(exc_level);		\
+	lwz	r0,GPR10-INT_FRAME_SIZE(r8);		\
+	stw	r0,GPR10(r11);				\
+	lwz	r0,GPR11-INT_FRAME_SIZE(r8);		\
+	stw	r0,GPR11(r11);				\
+	mfspr	r8,exc_level##_SPRG
+
 	.globl	mcheck_transfer_to_handler
 mcheck_transfer_to_handler:
-	mtspr	MCHECK_SPRG,r8
-	BOOKE_LOAD_MCHECK_STACK
-	lwz	r0,GPR10-INT_FRAME_SIZE(r8)
-	stw	r0,GPR10(r11)
-	lwz	r0,GPR11-INT_FRAME_SIZE(r8)
-	stw	r0,GPR11(r11)
-	mfspr	r8,MCHECK_SPRG
+	TRANSFER_TO_HANDLER_EXC_LEVEL(MCHECK)
 	b	transfer_to_handler_full
 
 	.globl	crit_transfer_to_handler
 crit_transfer_to_handler:
-	mtspr	CRIT_SPRG,r8
-	BOOKE_LOAD_CRIT_STACK
-	lwz	r0,GPR10-INT_FRAME_SIZE(r8)
-	stw	r0,GPR10(r11)
-	lwz	r0,GPR11-INT_FRAME_SIZE(r8)
-	stw	r0,GPR11(r11)
-	mfspr	r8,CRIT_SPRG
+	TRANSFER_TO_HANDLER_EXC_LEVEL(CRIT)
 	/* fall through */
 #endif
 
@@ -781,99 +778,64 @@ exc_exit_restart_end:
  * time of the critical interrupt.
  *
  */
-	.globl	ret_from_crit_exc
-ret_from_crit_exc:
-	REST_NVGPRS(r1)
-	lwz	r3,_MSR(r1)
-	andi.	r3,r3,MSR_PR
-	LOAD_MSR_KERNEL(r10,MSR_KERNEL)
-	bne	user_exc_return
-
-	lwz	r0,GPR0(r1)
-	lwz	r2,GPR2(r1)
-	REST_4GPRS(3, r1)
-	REST_2GPRS(7, r1)
-
-	lwz	r10,_XER(r1)
-	lwz	r11,_CTR(r1)
-	mtspr	SPRN_XER,r10
-	mtctr	r11
-
-	PPC405_ERR77(0,r1)
-	stwcx.	r0,0,r1			/* to clear the reservation */
-
-	lwz	r11,_LINK(r1)
-	mtlr	r11
-	lwz	r10,_CCR(r1)
-	mtcrf	0xff,r10
 #ifdef CONFIG_40x
-	/* avoid any possible TLB misses here by turning off MSR.DR, we
-	 * assume the instructions here are mapped by a pinned TLB entry */
-	li	r10,MSR_IR
-	mtmsr	r10
-	isync
-	tophys(r1, r1)
+#define PPC_40x_TURN_OFF_MSR_DR						    \
+	/* avoid any possible TLB misses here by turning off MSR.DR, we	    \
+	 * assume the instructions here are mapped by a pinned TLB entry */ \
+	li	r10,MSR_IR;						    \
+	mtmsr	r10;							    \
+	isync;								    \
+	tophys(r1, r1);
+#else
+#define PPC_40x_TURN_OFF_MSR_DR
 #endif
-	lwz	r9,_DEAR(r1)
-	lwz	r10,_ESR(r1)
-	mtspr	SPRN_DEAR,r9
-	mtspr	SPRN_ESR,r10
-	lwz	r11,_NIP(r1)
-	lwz	r12,_MSR(r1)
-	mtspr	SPRN_CSRR0,r11
-	mtspr	SPRN_CSRR1,r12
-	lwz	r9,GPR9(r1)
-	lwz	r12,GPR12(r1)
-	lwz	r10,GPR10(r1)
-	lwz	r11,GPR11(r1)
-	lwz	r1,GPR1(r1)
-	PPC405_ERR77_SYNC
-	rfci
-	b	.		/* prevent prefetch past rfci */
+
+#define RET_FROM_EXC_LEVEL(exc_lvl_srr0, exc_lvl_srr1, exc_lvl_rfi)	\
+	REST_NVGPRS(r1);						\
+	lwz	r3,_MSR(r1);						\
+	andi.	r3,r3,MSR_PR;						\
+	LOAD_MSR_KERNEL(r10,MSR_KERNEL);				\
+	bne	user_exc_return;					\
+	lwz	r0,GPR0(r1);						\
+	lwz	r2,GPR2(r1);						\
+	REST_4GPRS(3, r1);						\
+	REST_2GPRS(7, r1);						\
+	lwz	r10,_XER(r1);						\
+	lwz	r11,_CTR(r1);						\
+	mtspr	SPRN_XER,r10;						\
+	mtctr	r11;							\
+	PPC405_ERR77(0,r1);						\
+	stwcx.	r0,0,r1;		/* to clear the reservation */	\
+	lwz	r11,_LINK(r1);						\
+	mtlr	r11;							\
+	lwz	r10,_CCR(r1);						\
+	mtcrf	0xff,r10;						\
+	PPC_40x_TURN_OFF_MSR_DR;					\
+	lwz	r9,_DEAR(r1);						\
+	lwz	r10,_ESR(r1);						\
+	mtspr	SPRN_DEAR,r9;						\
+	mtspr	SPRN_ESR,r10;						\
+	lwz	r11,_NIP(r1);						\
+	lwz	r12,_MSR(r1);						\
+	mtspr	exc_lvl_srr0,r11;					\
+	mtspr	exc_lvl_srr1,r12;					\
+	lwz	r9,GPR9(r1);						\
+	lwz	r12,GPR12(r1);						\
+	lwz	r10,GPR10(r1);						\
+	lwz	r11,GPR11(r1);						\
+	lwz	r1,GPR1(r1);						\
+	PPC405_ERR77_SYNC;						\
+	exc_lvl_rfi;							\
+	b	.;		/* prevent prefetch past exc_lvl_rfi */
+
+	.globl	ret_from_crit_exc
+ret_from_crit_exc:
+	RET_FROM_EXC_LEVEL(SPRN_CSRR0, SPRN_CSRR1, RFCI)
 
 #ifdef CONFIG_BOOKE
-/*
- * Return from a machine check interrupt, similar to a critical
- * interrupt.
- */
 	.globl	ret_from_mcheck_exc
 ret_from_mcheck_exc:
-	REST_NVGPRS(r1)
-	lwz	r3,_MSR(r1)
-	andi.	r3,r3,MSR_PR
-	LOAD_MSR_KERNEL(r10,MSR_KERNEL)
-	bne	user_exc_return
-
-	lwz	r0,GPR0(r1)
-	lwz	r2,GPR2(r1)
-	REST_4GPRS(3, r1)
-	REST_2GPRS(7, r1)
-
-	lwz	r10,_XER(r1)
-	lwz	r11,_CTR(r1)
-	mtspr	SPRN_XER,r10
-	mtctr	r11
-
-	stwcx.	r0,0,r1			/* to clear the reservation */
-
-	lwz	r11,_LINK(r1)
-	mtlr	r11
-	lwz	r10,_CCR(r1)
-	mtcrf	0xff,r10
-	lwz	r9,_DEAR(r1)
-	lwz	r10,_ESR(r1)
-	mtspr	SPRN_DEAR,r9
-	mtspr	SPRN_ESR,r10
-	lwz	r11,_NIP(r1)
-	lwz	r12,_MSR(r1)
-	mtspr	SPRN_MCSRR0,r11
-	mtspr	SPRN_MCSRR1,r12
-	lwz	r9,GPR9(r1)
-	lwz	r12,GPR12(r1)
-	lwz	r10,GPR10(r1)
-	lwz	r11,GPR11(r1)
-	lwz	r1,GPR1(r1)
-	RFMCI
+	RET_FROM_EXC_LEVEL(SPRN_MCSRR0, SPRN_MCSRR1, RFMCI)
 #endif /* CONFIG_BOOKE */
 
 /*
diff --git a/arch/ppc/kernel/head_booke.h b/arch/ppc/kernel/head_booke.h
--- a/arch/ppc/kernel/head_booke.h
+++ b/arch/ppc/kernel/head_booke.h
@@ -67,46 +67,36 @@
 #define CRIT_STACK_TOP		(exception_stack_top)
 
 #ifdef CONFIG_SMP
-#define BOOKE_LOAD_CRIT_STACK				\
+#define BOOKE_LOAD_EXC_LEVEL_STACK(level)		\
 	mfspr	r8,SPRN_PIR;				\
 	mulli	r8,r8,BOOKE_EXCEPTION_STACK_SIZE;	\
 	neg	r8,r8;					\
-	addis	r8,r8,CRIT_STACK_TOP@ha;		\
-	addi	r8,r8,CRIT_STACK_TOP@l
-#define BOOKE_LOAD_MCHECK_STACK				\
-	mfspr	r8,SPRN_PIR;				\
-	mulli	r8,r8,BOOKE_EXCEPTION_STACK_SIZE;	\
-	neg	r8,r8;					\
-	addis	r8,r8,MCHECK_STACK_TOP@ha;		\
-	addi	r8,r8,MCHECK_STACK_TOP@l
+	addis	r8,r8,level##_STACK_TOP@ha;		\
+	addi	r8,r8,level##_STACK_TOP@l
 #else
-#define BOOKE_LOAD_CRIT_STACK				\
-	lis	r8,CRIT_STACK_TOP@h;			\
-	ori	r8,r8,CRIT_STACK_TOP@l
-#define BOOKE_LOAD_MCHECK_STACK				\
-	lis	r8,MCHECK_STACK_TOP@h;			\
-	ori	r8,r8,MCHECK_STACK_TOP@l
+#define BOOKE_LOAD_EXC_LEVEL_STACK(level)		\
+	lis	r8,level##_STACK_TOP@h;			\
+	ori	r8,r8,level##_STACK_TOP@l
 #endif
 
 /*
- * Exception prolog for critical exceptions.  This is a little different
- * from the normal exception prolog above since a critical exception
- * can potentially occur at any point during normal exception processing.
- * Thus we cannot use the same SPRG registers as the normal prolog above.
- * Instead we use a portion of the critical exception stack at low physical
- * addresses.
+ * Exception prolog for critical/machine check exceptions.  This is a
+ * little different from the normal exception prolog above since a
+ * critical/machine check exception can potentially occur at any point
+ * during normal exception processing. Thus we cannot use the same SPRG
+ * registers as the normal prolog above. Instead we use a portion of the
+ * critical/machine check exception stack at low physical addresses.
  */
-
-#define CRITICAL_EXCEPTION_PROLOG					     \
-	mtspr	CRIT_SPRG,r8;						     \
-	BOOKE_LOAD_CRIT_STACK;		/* r8 points to the crit stack */    \
+#define EXC_LEVEL_EXCEPTION_PROLOG(exc_level, exc_level_srr0, exc_level_srr1) \
+	mtspr	exc_level##_SPRG,r8;					     \
+	BOOKE_LOAD_EXC_LEVEL_STACK(exc_level);/* r8 points to the exc_level stack*/ \
 	stw	r10,GPR10-INT_FRAME_SIZE(r8);				     \
 	stw	r11,GPR11-INT_FRAME_SIZE(r8);				     \
 	mfcr	r10;			/* save CR in r10 for now	   */\
-	mfspr	r11,SPRN_CSRR1;		/* check whether user or kernel    */\
+	mfspr	r11,exc_level_srr1;	/* check whether user or kernel    */\
 	andi.	r11,r11,MSR_PR;						     \
 	mr	r11,r8;							     \
-	mfspr	r8,CRIT_SPRG;						     \
+	mfspr	r8,exc_level##_SPRG;					     \
 	beq	1f;							     \
 	/* COMING FROM USER MODE */					     \
 	mfspr	r11,SPRN_SPRG3;		/* if from user, start at top of   */\
@@ -122,9 +112,9 @@
 	stw	r12,_DEAR(r11);		/* since they may have had stuff   */\
 	mfspr	r9,SPRN_ESR;		/* in them at the point where the  */\
 	stw	r9,_ESR(r11);		/* exception was taken		   */\
-	mfspr	r12,SPRN_CSRR0;						     \
+	mfspr	r12,exc_level_srr0;					     \
 	stw	r1,GPR1(r11);						     \
-	mfspr	r9,SPRN_CSRR1;						     \
+	mfspr	r9,exc_level_srr1;					     \
 	stw	r1,0(r11);						     \
 	mr	r1,r11;							     \
 	rlwinm	r9,r9,0,14,12;		/* clear MSR_WE (necessary?)	   */\
@@ -132,45 +122,10 @@
 	SAVE_4GPRS(3, r11);						     \
 	SAVE_2GPRS(7, r11)
 
-/*
- * Exception prolog for machine check exceptions.  This is similar to
- * the critical exception prolog, except that machine check exceptions
- * have their stack.
- */
-#define MCHECK_EXCEPTION_PROLOG					     \
-	mtspr	MCHECK_SPRG,r8;						     \
-	BOOKE_LOAD_MCHECK_STACK;	/* r8 points to the mcheck stack   */\
-	stw	r10,GPR10-INT_FRAME_SIZE(r8);				     \
-	stw	r11,GPR11-INT_FRAME_SIZE(r8);				     \
-	mfcr	r10;			/* save CR in r10 for now	   */\
-	mfspr	r11,SPRN_MCSRR1;	/* check whether user or kernel    */\
-	andi.	r11,r11,MSR_PR;						     \
-	mr	r11,r8;							     \
-	mfspr	r8,MCHECK_SPRG;						     \
-	beq	1f;							     \
-	/* COMING FROM USER MODE */					     \
-	mfspr	r11,SPRN_SPRG3;		/* if from user, start at top of   */\
-	lwz	r11,THREAD_INFO-THREAD(r11); /* this thread's kernel stack */\
-	addi	r11,r11,THREAD_SIZE;					     \
-1:	subi	r11,r11,INT_FRAME_SIZE;	/* Allocate an exception frame     */\
-	stw	r10,_CCR(r11);          /* save various registers	   */\
-	stw	r12,GPR12(r11);						     \
-	stw	r9,GPR9(r11);						     \
-	mflr	r10;							     \
-	stw	r10,_LINK(r11);						     \
-	mfspr	r12,SPRN_DEAR;		/* save DEAR and ESR in the frame  */\
-	stw	r12,_DEAR(r11);		/* since they may have had stuff   */\
-	mfspr	r9,SPRN_ESR;		/* in them at the point where the  */\
-	stw	r9,_ESR(r11);		/* exception was taken		   */\
-	mfspr	r12,SPRN_MCSRR0;					     \
-	stw	r1,GPR1(r11);						     \
-	mfspr	r9,SPRN_MCSRR1;						     \
-	stw	r1,0(r11);						     \
-	mr	r1,r11;							     \
-	rlwinm	r9,r9,0,14,12;		/* clear MSR_WE (necessary?)	   */\
-	stw	r0,GPR0(r11);						     \
-	SAVE_4GPRS(3, r11);						     \
-	SAVE_2GPRS(7, r11)
+#define CRITICAL_EXCEPTION_PROLOG \
+		EXC_LEVEL_EXCEPTION_PROLOG(CRIT, SPRN_CSRR0, SPRN_CSRR1)
+#define MCHECK_EXCEPTION_PROLOG \
+		EXC_LEVEL_EXCEPTION_PROLOG(MCHECK, SPRN_MCSRR0, SPRN_MCSRR1)
 
 /*
  * Exception vectors.
@@ -237,7 +192,6 @@ label:
 	EXC_XFER_TEMPLATE(hdlr, n+1, MSR_KERNEL, COPY_EE, transfer_to_handler, \
 			  ret_from_except)
 
-
 /* Check for a single step debug exception while in an exception
  * handler before state has been saved.  This is to catch the case
  * where an instruction that we are trying to single step causes
@@ -291,7 +245,7 @@ label:
 	lwz	r9,GPR9(r11);						      \
 	lwz	r12,GPR12(r11);						      \
 	mtspr	CRIT_SPRG,r8;						      \
-	BOOKE_LOAD_CRIT_STACK;		/* r8 points to the crit stack */     \
+	BOOKE_LOAD_EXC_LEVEL_STACK(CRIT); /* r8 points to the debug stack */  \
 	lwz	r10,GPR10-INT_FRAME_SIZE(r8);				      \
 	lwz	r11,GPR11-INT_FRAME_SIZE(r8);				      \
 	mfspr	r8,CRIT_SPRG;						      \
