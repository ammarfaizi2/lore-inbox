Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262103AbVC1XDD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262103AbVC1XDD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 18:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbVC1XDC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 18:03:02 -0500
Received: from de01egw01.freescale.net ([192.88.165.102]:14060 "EHLO
	de01egw01.freescale.net") by vger.kernel.org with ESMTP
	id S262103AbVC1XBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 18:01:07 -0500
Date: Mon, 28 Mar 2005 17:00:36 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@blarg.somerset.sps.mot.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32: cleanup of Book-E exception handling
Message-ID: <Pine.LNX.4.61.0503281653380.9929@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Cleaned up the Book-E exception handling code to remove saving/restoring 
registers that were not needed. Moved the register save/restore area onto 
the exception stacks instead of dedicated offsets. Additionally, this 
allows for proper SMP handling of the additional exception levels.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---

diff -Nru a/arch/ppc/kernel/entry.S b/arch/ppc/kernel/entry.S
--- a/arch/ppc/kernel/entry.S	2005-03-28 14:24:24 -06:00
+++ b/arch/ppc/kernel/entry.S	2005-03-28 14:24:24 -06:00
@@ -45,40 +45,37 @@
 #endif
 
 #ifdef CONFIG_BOOKE
-#define	COR	r8	/* Critical Offset Register (COR) */
-#define BOOKE_LOAD_COR	lis COR,crit_save@ha
-#define BOOKE_REST_COR	mfspr COR,SPRN_SPRG2
-#define BOOKE_SAVE_COR	mtspr SPRN_SPRG2,COR
-#else
-#define COR	0
-#define BOOKE_LOAD_COR
-#define BOOKE_REST_COR
-#define BOOKE_SAVE_COR
-#endif
-
-#ifdef CONFIG_BOOKE
+#include "head_booke.h"
 	.globl	mcheck_transfer_to_handler
 mcheck_transfer_to_handler:
-	mtspr	SPRN_SPRG6W,r8
-	lis	r8,mcheck_save@ha
-	lwz	r0,mcheck_r10@l(r8)
+	mtspr	MCHECK_SPRG,r8
+	BOOKE_LOAD_MCHECK_STACK
+	lwz	r0,GPR10-INT_FRAME_SIZE(r8)
 	stw	r0,GPR10(r11)
-	lwz	r0,mcheck_r11@l(r8)
+	lwz	r0,GPR11-INT_FRAME_SIZE(r8)
 	stw	r0,GPR11(r11)
-	mfspr	r8,SPRN_SPRG6R
+	mfspr	r8,MCHECK_SPRG
 	b	transfer_to_handler_full
+
+	.globl	crit_transfer_to_handler
+crit_transfer_to_handler:
+	mtspr	CRIT_SPRG,r8
+	BOOKE_LOAD_CRIT_STACK
+	lwz	r0,GPR10-INT_FRAME_SIZE(r8)
+	stw	r0,GPR10(r11)
+	lwz	r0,GPR11-INT_FRAME_SIZE(r8)
+	stw	r0,GPR11(r11)
+	mfspr	r8,CRIT_SPRG
+	/* fall through */
 #endif
 
-#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
+#ifdef CONFIG_40x
 	.globl	crit_transfer_to_handler
 crit_transfer_to_handler:
-	BOOKE_SAVE_COR
-	BOOKE_LOAD_COR
-	lwz	r0,crit_r10@l(COR)
+	lwz	r0,crit_r10@l(0)
 	stw	r0,GPR10(r11)
-	lwz	r0,crit_r11@l(COR)
+	lwz	r0,crit_r11@l(0)
 	stw	r0,GPR11(r11)
-	BOOKE_REST_COR
 	/* fall through */
 #endif
 
@@ -724,8 +721,6 @@
  * We have to restore various SPRs that may have been in use at the
  * time of the critical interrupt.
  *
- * Note that SPRG6 is used for machine check on CONFIG_BOOKE parts and
- * thus not saved in the critical handler
  */
 	.globl	ret_from_crit_exc
 ret_from_crit_exc:
@@ -770,32 +765,9 @@
 	mtspr	SPRN_CSRR1,r12
 	lwz	r9,GPR9(r1)
 	lwz	r12,GPR12(r1)
-	BOOKE_SAVE_COR
-	BOOKE_LOAD_COR
-	lwz	r10,crit_sprg0@l(COR)
-	mtspr	SPRN_SPRG0,r10
-	lwz	r10,crit_sprg1@l(COR)
-	mtspr	SPRN_SPRG1,r10
-	lwz	r10,crit_sprg4@l(COR)
-	mtspr	SPRN_SPRG4,r10
-	lwz	r10,crit_sprg5@l(COR)
-	mtspr	SPRN_SPRG5,r10
-#ifdef CONFIG_40x
-	lwz	r10,crit_sprg6@l(COR)
-	mtspr	SPRN_SPRG6,r10
-#endif
-	lwz	r10,crit_sprg7@l(COR)
-	mtspr	SPRN_SPRG7,r10
-	lwz	r10,crit_srr0@l(COR)
-	mtspr	SPRN_SRR0,r10
-	lwz	r10,crit_srr1@l(COR)
-	mtspr	SPRN_SRR1,r10
-	lwz	r10,crit_pid@l(COR)
-	mtspr	SPRN_PID,r10
 	lwz	r10,GPR10(r1)
 	lwz	r11,GPR11(r1)
 	lwz	r1,GPR1(r1)
-	BOOKE_REST_COR
 	PPC405_ERR77_SYNC
 	rfci
 	b	.		/* prevent prefetch past rfci */
@@ -839,32 +811,9 @@
 	mtspr	SPRN_MCSRR1,r12
 	lwz	r9,GPR9(r1)
 	lwz	r12,GPR12(r1)
-	mtspr	SPRN_SPRG6W,r8
-	lis	r8,mcheck_save@ha
-	lwz	r10,mcheck_sprg0@l(r8)
-	mtspr	SPRN_SPRG0,r10
-	lwz	r10,mcheck_sprg1@l(r8)
-	mtspr	SPRN_SPRG1,r10
-	lwz	r10,mcheck_sprg4@l(r8)
-	mtspr	SPRN_SPRG4,r10
-	lwz	r10,mcheck_sprg5@l(r8)
-	mtspr	SPRN_SPRG5,r10
-	lwz	r10,mcheck_sprg7@l(r8)
-	mtspr	SPRN_SPRG7,r10
-	lwz	r10,mcheck_srr0@l(r8)
-	mtspr	SPRN_SRR0,r10
-	lwz	r10,mcheck_srr1@l(r8)
-	mtspr	SPRN_SRR1,r10
-	lwz	r10,mcheck_csrr0@l(r8)
-	mtspr	SPRN_CSRR0,r10
-	lwz	r10,mcheck_csrr1@l(r8)
-	mtspr	SPRN_CSRR1,r10
-	lwz	r10,mcheck_pid@l(r8)
-	mtspr	SPRN_PID,r10
 	lwz	r10,GPR10(r1)
 	lwz	r11,GPR11(r1)
 	lwz	r1,GPR1(r1)
-	mfspr	r8,SPRN_SPRG6R
 	RFMCI
 #endif /* CONFIG_BOOKE */
 
diff -Nru a/arch/ppc/kernel/head_44x.S b/arch/ppc/kernel/head_44x.S
--- a/arch/ppc/kernel/head_44x.S	2005-03-28 14:24:24 -06:00
+++ b/arch/ppc/kernel/head_44x.S	2005-03-28 14:24:24 -06:00
@@ -728,78 +728,13 @@
 _GLOBAL(swapper_pg_dir)
 	.space	8192
 
+/* Reserved 4k for the critical exception stack & 4k for the machine
+ * check stack per CPU for kernel mode exceptions */
 	.section .bss
-/* Stack for handling critical exceptions from kernel mode */
-critical_stack_bottom:
-	.space 4096
-critical_stack_top:
-	.previous
-
-/* Stack for handling machine check exceptions from kernel mode */
-mcheck_stack_bottom:
-	.space 4096
-mcheck_stack_top:
-	.previous
-
-/*
- * This area is used for temporarily saving registers during the
- * critical and machine check exception prologs. It must always
- * follow the page aligned allocations, so it starts on a page
- * boundary, ensuring that all crit_save areas are in a single
- * page.
- */
-
-/* crit_save */
-_GLOBAL(crit_save)
-	.space  4
-_GLOBAL(crit_r10)
-	.space	4
-_GLOBAL(crit_r11)
-	.space	4
-_GLOBAL(crit_sprg0)
-	.space	4
-_GLOBAL(crit_sprg1)
-	.space	4
-_GLOBAL(crit_sprg4)
-	.space	4
-_GLOBAL(crit_sprg5)
-	.space	4
-_GLOBAL(crit_sprg7)
-	.space	4
-_GLOBAL(crit_pid)
-	.space	4
-_GLOBAL(crit_srr0)
-	.space	4
-_GLOBAL(crit_srr1)
-	.space	4
-
-/* mcheck_save */
-_GLOBAL(mcheck_save)
-	.space  4
-_GLOBAL(mcheck_r10)
-	.space	4
-_GLOBAL(mcheck_r11)
-	.space	4
-_GLOBAL(mcheck_sprg0)
-	.space	4
-_GLOBAL(mcheck_sprg1)
-	.space	4
-_GLOBAL(mcheck_sprg4)
-	.space	4
-_GLOBAL(mcheck_sprg5)
-	.space	4
-_GLOBAL(mcheck_sprg7)
-	.space	4
-_GLOBAL(mcheck_pid)
-	.space	4
-_GLOBAL(mcheck_srr0)
-	.space	4
-_GLOBAL(mcheck_srr1)
-	.space	4
-_GLOBAL(mcheck_csrr0)
-	.space	4
-_GLOBAL(mcheck_csrr1)
-	.space	4
+        .align 12
+exception_stack_bottom:
+	.space	BOOKE_EXCEPTION_STACK_SIZE
+_GLOBAL(exception_stack_top)
 
 /*
  * This space gets a copy of optional info passed to us by the bootstrap
diff -Nru a/arch/ppc/kernel/head_4xx.S b/arch/ppc/kernel/head_4xx.S
--- a/arch/ppc/kernel/head_4xx.S	2005-03-28 14:24:24 -06:00
+++ b/arch/ppc/kernel/head_4xx.S	2005-03-28 14:24:24 -06:00
@@ -95,24 +95,6 @@
 	.space	4
 _GLOBAL(crit_r11)
 	.space	4
-_GLOBAL(crit_sprg0)
-	.space	4
-_GLOBAL(crit_sprg1)
-	.space	4
-_GLOBAL(crit_sprg4)
-	.space	4
-_GLOBAL(crit_sprg5)
-	.space	4
-_GLOBAL(crit_sprg6)
-	.space	4
-_GLOBAL(crit_sprg7)
-	.space	4
-_GLOBAL(crit_pid)
-	.space	4
-_GLOBAL(crit_srr0)
-	.space	4
-_GLOBAL(crit_srr1)
-	.space	4
 
 /*
  * Exception vector entry code. This code runs with address translation
@@ -165,24 +147,6 @@
 #define CRITICAL_EXCEPTION_PROLOG					     \
 	stw	r10,crit_r10@l(0);	/* save two registers to work with */\
 	stw	r11,crit_r11@l(0);					     \
-	mfspr	r10,SPRN_SPRG0;						     \
-	stw	r10,crit_sprg0@l(0);					     \
-	mfspr	r10,SPRN_SPRG1;						     \
-	stw	r10,crit_sprg1@l(0);					     \
-	mfspr	r10,SPRN_SPRG4;						     \
-	stw	r10,crit_sprg4@l(0);					     \
-	mfspr	r10,SPRN_SPRG5;						     \
-	stw	r10,crit_sprg5@l(0);					     \
-	mfspr	r10,SPRN_SPRG6;						     \
-	stw	r10,crit_sprg6@l(0);					     \
-	mfspr	r10,SPRN_SPRG7;						     \
-	stw	r10,crit_sprg7@l(0);					     \
-	mfspr	r10,SPRN_PID;						     \
-	stw	r10,crit_pid@l(0);					     \
-	mfspr	r10,SPRN_SRR0;						     \
-	stw	r10,crit_srr0@l(0);					     \
-	mfspr	r10,SPRN_SRR1;						     \
-	stw	r10,crit_srr1@l(0);					     \
 	mfcr	r10;			/* save CR in r10 for now	   */\
 	mfspr	r11,SPRN_SRR3;		/* check whether user or kernel    */\
 	andi.	r11,r11,MSR_PR;						     \
@@ -221,9 +185,6 @@
 	 * r11 saved in crit_r11 and in stack frame,
 	 *	now phys stack/exception frame pointer
 	 * r12 saved in stack frame, now saved SRR2
-	 * SPRG0,1,4,5,6,7 saved in crit_sprg0,1,4,5,6,7
-	 * PID saved in crit_pid
-	 * SRR0,1 saved in crit_srr0,1
 	 * CR saved in stack frame, CR0.EQ = !SRR3.PR
 	 * LR, DEAR, ESR in stack frame
 	 * r1 saved in stack frame, now virt stack/excframe pointer
@@ -1030,10 +991,11 @@
 
 /* Stack for handling critical exceptions from kernel mode */
 	.section .bss
-critical_stack_bottom:
+        .align 12
+exception_stack_bottom:
 	.space	4096
 critical_stack_top:
-	.previous
+_GLOBAL(exception_stack_top)
 
 /* This space gets a copy of optional info passed to us by the bootstrap
  * which is used to pass parameters into the kernel like root=/dev/sda1, etc.
diff -Nru a/arch/ppc/kernel/head_booke.h b/arch/ppc/kernel/head_booke.h
--- a/arch/ppc/kernel/head_booke.h	2005-03-28 14:24:24 -06:00
+++ b/arch/ppc/kernel/head_booke.h	2005-03-28 14:24:24 -06:00
@@ -22,7 +22,7 @@
 	lwz	r1,THREAD_INFO-THREAD(r1); /* this thread's kernel stack   */\
 	addi	r1,r1,THREAD_SIZE;					     \
 1:	subi	r1,r1,INT_FRAME_SIZE;	/* Allocate an exception frame     */\
-	tophys(r11,r1);							     \
+	mr	r11,r1;							     \
 	stw	r10,_CCR(r11);          /* save various registers	   */\
 	stw	r12,GPR12(r11);						     \
 	stw	r9,GPR9(r11);						     \
@@ -42,45 +42,71 @@
 	SAVE_4GPRS(3, r11);						     \
 	SAVE_2GPRS(7, r11)
 
+/* To handle the additional exception priority levels on 40x and Book-E
+ * processors we allocate a 4k stack per additional priority level. The various
+ * head_xxx.S files allocate space (exception_stack_top) for each priority's
+ * stack times the number of CPUs
+ *
+ * On 40x critical is the only additional level
+ * On 44x/e500 we have critical and machine check
+ *
+ * Additionally we reserve a SPRG for each priority level so we can free up a
+ * GPR to use as the base for indirect access to the exception stacks.  This
+ * is necessary since the MMU is always on, for Book-E parts, and the stacks
+ * are offset from KERNELBASE.
+ *
+ */
+#define BOOKE_EXCEPTION_STACK_SIZE	(8192)
+
+/* CRIT_SPRG only used in critical exception handling */
+#define CRIT_SPRG	SPRN_SPRG2
+/* MCHECK_SPRG only used in critical exception handling */
+#define MCHECK_SPRG	SPRN_SPRG6W
+
+#define MCHECK_STACK_TOP	(exception_stack_top - 4096)
+#define CRIT_STACK_TOP		(exception_stack_top)
+
+#ifdef CONFIG_SMP
+#define BOOKE_LOAD_CRIT_STACK				\
+	mfspr	r8,SPRN_PIR;				\
+	mulli	r8,r8,BOOKE_EXCEPTION_STACK_SIZE;	\
+	neg	r8,r8;					\
+	addis	r8,r8,CRIT_STACK_TOP@ha;		\
+	addi	r8,r8,CRIT_STACK_TOP@l
+#define BOOKE_LOAD_MCHECK_STACK				\
+	mfspr	r8,SPRN_PIR;				\
+	mulli	r8,r8,BOOKE_EXCEPTION_STACK_SIZE;	\
+	neg	r8,r8;					\
+	addis	r8,r8,MCHECK_STACK_TOP@ha;		\
+	addi	r8,r8,MCHECK_STACK_TOP@l
+#else
+#define BOOKE_LOAD_CRIT_STACK				\
+	lis	r8,CRIT_STACK_TOP@h;			\
+	ori	r8,r8,CRIT_STACK_TOP@l
+#define BOOKE_LOAD_MCHECK_STACK				\
+	lis	r8,MCHECK_STACK_TOP@h;			\
+	ori	r8,r8,MCHECK_STACK_TOP@l
+#endif
+
 /*
  * Exception prolog for critical exceptions.  This is a little different
  * from the normal exception prolog above since a critical exception
  * can potentially occur at any point during normal exception processing.
  * Thus we cannot use the same SPRG registers as the normal prolog above.
- * Instead we use a couple of words of memory at low physical addresses.
- * This is OK since we don't support SMP on these processors. For Book E
- * processors, we also have a reserved register (SPRG2) that is only used
- * in critical exceptions so we can free up a GPR to use as the base for
- * indirect access to the critical exception save area.  This is necessary
- * since the MMU is always on and the save area is offset from KERNELBASE.
+ * Instead we use a portion of the critical exception stack at low physical
+ * addresses.
  */
+
 #define CRITICAL_EXCEPTION_PROLOG					     \
-	mtspr	SPRN_SPRG2,r8;		/* SPRG2 only used in criticals */   \
-	lis	r8,crit_save@ha;					     \
-	stw	r10,crit_r10@l(r8);					     \
-	stw	r11,crit_r11@l(r8);					     \
-	mfspr	r10,SPRN_SPRG0;						     \
-	stw	r10,crit_sprg0@l(r8);					     \
-	mfspr	r10,SPRN_SPRG1;						     \
-	stw	r10,crit_sprg1@l(r8);					     \
-	mfspr	r10,SPRN_SPRG4R;					     \
-	stw	r10,crit_sprg4@l(r8);					     \
-	mfspr	r10,SPRN_SPRG5R;					     \
-	stw	r10,crit_sprg5@l(r8);					     \
-	mfspr	r10,SPRN_SPRG7R;					     \
-	stw	r10,crit_sprg7@l(r8);					     \
-	mfspr	r10,SPRN_PID;						     \
-	stw	r10,crit_pid@l(r8);					     \
-	mfspr	r10,SPRN_SRR0;						     \
-	stw	r10,crit_srr0@l(r8);					     \
-	mfspr	r10,SPRN_SRR1;						     \
-	stw	r10,crit_srr1@l(r8);					     \
-	mfspr	r8,SPRN_SPRG2;		/* SPRG2 only used in criticals */   \
+	mtspr	CRIT_SPRG,r8;						     \
+	BOOKE_LOAD_CRIT_STACK;		/* r8 points to the crit stack */    \
+	stw	r10,GPR10-INT_FRAME_SIZE(r8);				     \
+	stw	r11,GPR11-INT_FRAME_SIZE(r8);				     \
 	mfcr	r10;			/* save CR in r10 for now	   */\
 	mfspr	r11,SPRN_CSRR1;		/* check whether user or kernel    */\
 	andi.	r11,r11,MSR_PR;						     \
-	lis	r11,critical_stack_top@h;				     \
-	ori	r11,r11,critical_stack_top@l;				     \
+	mr	r11,r8;							     \
+	mfspr	r8,CRIT_SPRG;						     \
 	beq	1f;							     \
 	/* COMING FROM USER MODE */					     \
 	mfspr	r11,SPRN_SPRG3;		/* if from user, start at top of   */\
@@ -100,7 +126,7 @@
 	stw	r1,GPR1(r11);						     \
 	mfspr	r9,SPRN_CSRR1;						     \
 	stw	r1,0(r11);						     \
-	tovirt(r1,r11);							     \
+	mr	r1,r11;							     \
 	rlwinm	r9,r9,0,14,12;		/* clear MSR_WE (necessary?)	   */\
 	stw	r0,GPR0(r11);						     \
 	SAVE_4GPRS(3, r11);						     \
@@ -109,43 +135,18 @@
 /*
  * Exception prolog for machine check exceptions.  This is similar to
  * the critical exception prolog, except that machine check exceptions
- * have their own save area.  For Book E processors, we also have a
- * reserved register (SPRG6) that is only used in machine check exceptions
- * so we can free up a GPR to use as the base for indirect access to the
- * machine check exception save area.  This is necessary since the MMU
- * is always on and the save area is offset from KERNELBASE.
+ * have their stack.
  */
 #define MCHECK_EXCEPTION_PROLOG					     \
-	mtspr	SPRN_SPRG6W,r8;		/* SPRG6 used in machine checks */   \
-	lis	r8,mcheck_save@ha;					     \
-	stw	r10,mcheck_r10@l(r8);					     \
-	stw	r11,mcheck_r11@l(r8);					     \
-	mfspr	r10,SPRN_SPRG0;						     \
-	stw	r10,mcheck_sprg0@l(r8);					     \
-	mfspr	r10,SPRN_SPRG1;						     \
-	stw	r10,mcheck_sprg1@l(r8);					     \
-	mfspr	r10,SPRN_SPRG4R;					     \
-	stw	r10,mcheck_sprg4@l(r8);					     \
-	mfspr	r10,SPRN_SPRG5R;					     \
-	stw	r10,mcheck_sprg5@l(r8);					     \
-	mfspr	r10,SPRN_SPRG7R;					     \
-	stw	r10,mcheck_sprg7@l(r8);					     \
-	mfspr	r10,SPRN_PID;						     \
-	stw	r10,mcheck_pid@l(r8);					     \
-	mfspr	r10,SPRN_SRR0;						     \
-	stw	r10,mcheck_srr0@l(r8);					     \
-	mfspr	r10,SPRN_SRR1;						     \
-	stw	r10,mcheck_srr1@l(r8);					     \
-	mfspr	r10,SPRN_CSRR0;						     \
-	stw	r10,mcheck_csrr0@l(r8);					     \
-	mfspr	r10,SPRN_CSRR1;						     \
-	stw	r10,mcheck_csrr1@l(r8);					     \
-	mfspr	r8,SPRN_SPRG6R;		/* SPRG6 used in machine checks */   \
+	mtspr	MCHECK_SPRG,r8;						     \
+	BOOKE_LOAD_MCHECK_STACK;	/* r8 points to the mcheck stack   */\
+	stw	r10,GPR10-INT_FRAME_SIZE(r8);				     \
+	stw	r11,GPR11-INT_FRAME_SIZE(r8);				     \
 	mfcr	r10;			/* save CR in r10 for now	   */\
 	mfspr	r11,SPRN_MCSRR1;	/* check whether user or kernel    */\
 	andi.	r11,r11,MSR_PR;						     \
-	lis	r11,mcheck_stack_top@h;					     \
-	ori	r11,r11,mcheck_stack_top@l;				     \
+	mr	r11,r8;							     \
+	mfspr	r8,MCHECK_SPRG;						     \
 	beq	1f;							     \
 	/* COMING FROM USER MODE */					     \
 	mfspr	r11,SPRN_SPRG3;		/* if from user, start at top of   */\
@@ -165,7 +166,7 @@
 	stw	r1,GPR1(r11);						     \
 	mfspr	r9,SPRN_MCSRR1;						     \
 	stw	r1,0(r11);						     \
-	tovirt(r1,r11);							     \
+	mr	r1,r11;							     \
 	rlwinm	r9,r9,0,14,12;		/* clear MSR_WE (necessary?)	   */\
 	stw	r0,GPR0(r11);						     \
 	SAVE_4GPRS(3, r11);						     \
@@ -289,11 +290,11 @@
 	mtspr	SPRN_CSRR1,r9;						      \
 	lwz	r9,GPR9(r11);						      \
 	lwz	r12,GPR12(r11);						      \
-	mtspr	SPRN_SPRG2,r8;		/* SPRG2 only used in criticals */    \
-	lis	r8,crit_save@ha;					      \
-	lwz	r10,crit_r10@l(r8);					      \
-	lwz	r11,crit_r11@l(r8);					      \
-	mfspr	r8,SPRN_SPRG2;						      \
+	mtspr	CRIT_SPRG,r8;						      \
+	BOOKE_LOAD_CRIT_STACK;		/* r8 points to the crit stack */     \
+	lwz	r10,GPR10-INT_FRAME_SIZE(r8);				      \
+	lwz	r11,GPR11-INT_FRAME_SIZE(r8);				      \
+	mfspr	r8,CRIT_SPRG;						      \
 									      \
 	rfci;								      \
 	b	.;							      \
diff -Nru a/arch/ppc/kernel/head_e500.S b/arch/ppc/kernel/head_e500.S
--- a/arch/ppc/kernel/head_e500.S	2005-03-28 14:24:24 -06:00
+++ b/arch/ppc/kernel/head_e500.S	2005-03-28 14:24:24 -06:00
@@ -33,6 +33,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/threads.h>
 #include <asm/processor.h>
 #include <asm/page.h>
 #include <asm/mmu.h>
@@ -789,8 +790,6 @@
 	SYNC
 	rfi
 
-
-
 /*
  * SPE unavailable trap from kernel - print a message, but let
  * the task use SPE in the kernel until it returns to user mode.
@@ -929,78 +928,13 @@
 _GLOBAL(swapper_pg_dir)
 	.space	4096
 
+/* Reserved 4k for the critical exception stack & 4k for the machine
+ * check stack per CPU for kernel mode exceptions */
 	.section .bss
-/* Stack for handling critical exceptions from kernel mode */
-critical_stack_bottom:
-	.space 4096
-critical_stack_top:
-	.previous
-
-/* Stack for handling machine check exceptions from kernel mode */
-mcheck_stack_bottom:
-	.space 4096
-mcheck_stack_top:
-	.previous
-
-/*
- * This area is used for temporarily saving registers during the
- * critical and machine check exception prologs. It must always
- * follow the page aligned allocations, so it starts on a page
- * boundary, ensuring that all crit_save areas are in a single
- * page.
- */
-
-/* crit_save */
-_GLOBAL(crit_save)
-	.space  4
-_GLOBAL(crit_r10)
-	.space	4
-_GLOBAL(crit_r11)
-	.space	4
-_GLOBAL(crit_sprg0)
-	.space	4
-_GLOBAL(crit_sprg1)
-	.space	4
-_GLOBAL(crit_sprg4)
-	.space	4
-_GLOBAL(crit_sprg5)
-	.space	4
-_GLOBAL(crit_sprg7)
-	.space	4
-_GLOBAL(crit_pid)
-	.space	4
-_GLOBAL(crit_srr0)
-	.space	4
-_GLOBAL(crit_srr1)
-	.space	4
-
-/* mcheck_save */
-_GLOBAL(mcheck_save)
-	.space  4
-_GLOBAL(mcheck_r10)
-	.space	4
-_GLOBAL(mcheck_r11)
-	.space	4
-_GLOBAL(mcheck_sprg0)
-	.space	4
-_GLOBAL(mcheck_sprg1)
-	.space	4
-_GLOBAL(mcheck_sprg4)
-	.space	4
-_GLOBAL(mcheck_sprg5)
-	.space	4
-_GLOBAL(mcheck_sprg7)
-	.space	4
-_GLOBAL(mcheck_pid)
-	.space	4
-_GLOBAL(mcheck_srr0)
-	.space	4
-_GLOBAL(mcheck_srr1)
-	.space	4
-_GLOBAL(mcheck_csrr0)
-	.space	4
-_GLOBAL(mcheck_csrr1)
-	.space	4
+        .align 12
+exception_stack_bottom:
+	.space	BOOKE_EXCEPTION_STACK_SIZE * NR_CPUS
+_GLOBAL(exception_stack_top)
 
 /*
  * This space gets a copy of optional info passed to us by the bootstrap
@@ -1015,5 +949,4 @@
  */
 abatron_pteptrs:
 	.space	8
-
 
