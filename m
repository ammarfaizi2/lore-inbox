Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262802AbUEKA6B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262802AbUEKA6B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 20:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbUEKA6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 20:58:00 -0400
Received: from host213-123-250-229.in-addr.btopenworld.com ([213.123.250.229]:6439
	"EHLO 2003SERVER.sbs2003.local") by vger.kernel.org with ESMTP
	id S262802AbUEKA5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 20:57:32 -0400
thread-index: AcQ282L6GCls77mvSDiIB1KOn0fM0A==
X-Sieve: Server Sieve 2.2
Date: Tue, 11 May 2004 02:00:43 +0100
From: "Matt Porter" <mporter@kernel.crashing.org>
To: <Administrator@vger.kernel.org>
Message-ID: <000101c436f3$62fa7330$d100000a@sbs2003.local>
Cc: <paulus@samba.org>, <linux-kernel@vger.kernel.org>,
       <linuxppc-dev@lists.linuxppc.org>
Content-Transfer-Encoding: 7bit
Subject: [PATCH][1/2] PPC32: Add Book E / PPC44x specific exception support
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
X-Mailer: Microsoft CDO for Exchange 2000
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Mailing-List: <linuxppc-dev@lists.linuxppc.org>
X-Loop: linuxppc-dev@lists.linuxppc.org
Envelope-to: paul@sumlocktest.fsnet.co.uk
X-me-spamlevel: not-spam
Content-Class: urn:content-classes:message
Importance: normal
X-me-spamrating: 54.122519
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.132
X-OriginalArrivalTime: 11 May 2004 01:00:43.0890 (UTC) FILETIME=[62FCBD20:01C436F3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Adds general Book E debug exception support and PPC44x-specific debug
exception implementation. Please apply.

-Matt

diff -Nru a/arch/ppc/kernel/entry.S b/arch/ppc/kernel/entry.S
--- a/arch/ppc/kernel/entry.S	Wed May  5 17:21:54 2004
+++ b/arch/ppc/kernel/entry.S	Wed May  5 17:21:54 2004
@@ -44,13 +44,28 @@
 #define LOAD_MSR_KERNEL(r, x)	li r,(x)
 #endif

-#ifdef CONFIG_4xx
+#ifdef CONFIG_BOOKE
+#define	COR	r8
+#define BOOKE_LOAD_COR	lis COR,crit_save@ha
+#define BOOKE_REST_COR	mfspr COR,SPRG2
+#define BOOKE_SAVE_COR	mtspr SPRG2,COR
+#else
+#define COR	0
+#define BOOKE_LOAD_COR
+#define BOOKE_REST_COR
+#define BOOKE_SAVE_COR
+#endif
+
+#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
 	.globl	crit_transfer_to_handler
 crit_transfer_to_handler:
-	lwz	r0,crit_r10@l(0)
+	BOOKE_SAVE_COR
+	BOOKE_LOAD_COR
+	lwz	r0,crit_r10@l(COR)
 	stw	r0,GPR10(r11)
-	lwz	r0,crit_r11@l(0)
+	lwz	r0,crit_r11@l(COR)
 	stw	r0,GPR11(r11)
+	BOOKE_REST_COR
 	/* fall through */
 #endif

@@ -695,12 +710,14 @@
 	mtlr	r11
 	lwz	r10,_CCR(r1)
 	mtcrf	0xff,r10
+#ifdef CONFIG_40x
 	/* avoid any possible TLB misses here by turning off MSR.DR, we
 	 * assume the instructions here are mapped by a pinned TLB entry */
 	li	r10,MSR_IR
 	mtmsr	r10
 	isync
 	tophys(r1, r1)
+#endif
 	lwz	r9,_DEAR(r1)
 	lwz	r10,_ESR(r1)
 	mtspr	SPRN_DEAR,r9
@@ -711,27 +728,30 @@
 	mtspr	CSRR1,r12
 	lwz	r9,GPR9(r1)
 	lwz	r12,GPR12(r1)
-	lwz	r10,crit_sprg0@l(0)
+	BOOKE_SAVE_COR
+	BOOKE_LOAD_COR
+	lwz	r10,crit_sprg0@l(COR)
 	mtspr	SPRN_SPRG0,r10
-	lwz	r10,crit_sprg1@l(0)
+	lwz	r10,crit_sprg1@l(COR)
 	mtspr	SPRN_SPRG1,r10
-	lwz	r10,crit_sprg4@l(0)
+	lwz	r10,crit_sprg4@l(COR)
 	mtspr	SPRN_SPRG4,r10
-	lwz	r10,crit_sprg5@l(0)
+	lwz	r10,crit_sprg5@l(COR)
 	mtspr	SPRN_SPRG5,r10
-	lwz	r10,crit_sprg6@l(0)
+	lwz	r10,crit_sprg6@l(COR)
 	mtspr	SPRN_SPRG6,r10
-	lwz	r10,crit_sprg7@l(0)
+	lwz	r10,crit_sprg7@l(COR)
 	mtspr	SPRN_SPRG7,r10
-	lwz	r10,crit_srr0@l(0)
+	lwz	r10,crit_srr0@l(COR)
 	mtspr	SRR0,r10
-	lwz	r10,crit_srr1@l(0)
+	lwz	r10,crit_srr1@l(COR)
 	mtspr	SRR1,r10
-	lwz	r10,crit_pid@l(0)
+	lwz	r10,crit_pid@l(COR)
 	mtspr	SPRN_PID,r10
 	lwz	r10,GPR10(r1)
 	lwz	r11,GPR11(r1)
 	lwz	r1,GPR1(r1)
+	BOOKE_REST_COR
 	PPC405_ERR77_SYNC
 	rfci
 	b	.		/* prevent prefetch past rfci */
diff -Nru a/arch/ppc/kernel/head_44x.S b/arch/ppc/kernel/head_44x.S
--- a/arch/ppc/kernel/head_44x.S	Wed May  5 17:21:54 2004
+++ b/arch/ppc/kernel/head_44x.S	Wed May  5 17:21:54 2004
@@ -296,7 +296,7 @@
 #define NORMAL_EXCEPTION_PROLOG						     \
 	mtspr	SPRN_SPRG0,r10;		/* save two registers to work with */\
 	mtspr	SPRN_SPRG1,r11;						     \
-	mtspr	SPRN_SPRG2,r1;						     \
+	mtspr	SPRN_SPRG4W,r1;						     \
 	mfcr	r10;			/* save CR in r10 for now	   */\
 	mfspr	r11,SPRN_SRR1;		/* check whether user or kernel    */\
 	andi.	r11,r11,MSR_PR;						     \
@@ -315,7 +315,7 @@
 	stw	r12,GPR11(r11);						     \
 	mflr	r10;							     \
 	stw	r10,_LINK(r11);						     \
-	mfspr	r10,SPRG2;						     \
+	mfspr	r10,SPRG4R;						     \
 	mfspr	r12,SRR0;						     \
 	stw	r10,GPR1(r11);						     \
 	mfspr	r9,SRR1;						     \
@@ -331,30 +331,36 @@
  * can potentially occur at any point during normal exception processing.
  * Thus we cannot use the same SPRG registers as the normal prolog above.
  * Instead we use a couple of words of memory at low physical addresses.
- * This is OK since we don't support SMP on these processors.
+ * This is OK since we don't support SMP on these processors. For Book E
+ * processors, we also have a reserved register (SPRG2) that is only used
+ * in critical exceptions so we can free up a GPR to use as the base for
+ * indirect access to the critical exception save area.  This is necessary
+ * since the MMU is always on and the save area is offset from KERNELBASE.
  */
-/* XXX but we don't have RAM mapped at 0 in space 0  -- paulus. */
 #define CRITICAL_EXCEPTION_PROLOG					     \
-	stw	r10,crit_r10@l(0);	/* save two registers to work with */\
-	stw	r11,crit_r11@l(0);					     \
+	mtspr	SPRG2,r8;		/* SPRG2 only used in criticals */   \
+	lis	r8,crit_save@ha;					     \
+	stw	r10,crit_r10@l(r8);					     \
+	stw	r11,crit_r11@l(r8);					     \
 	mfspr	r10,SPRG0;						     \
-	stw	r10,crit_sprg0@l(0);					     \
+	stw	r10,crit_sprg0@l(r8);					     \
 	mfspr	r10,SPRG1;						     \
-	stw	r10,crit_sprg1@l(0);					     \
+	stw	r10,crit_sprg1@l(r8);					     \
 	mfspr	r10,SPRG4R;						     \
-	stw	r10,crit_sprg4@l(0);					     \
+	stw	r10,crit_sprg4@l(r8);					     \
 	mfspr	r10,SPRG5R;						     \
-	stw	r10,crit_sprg5@l(0);					     \
+	stw	r10,crit_sprg5@l(r8);					     \
 	mfspr	r10,SPRG6R;						     \
-	stw	r10,crit_sprg6@l(0);					     \
+	stw	r10,crit_sprg6@l(r8);					     \
 	mfspr	r10,SPRG7R;						     \
-	stw	r10,crit_sprg7@l(0);					     \
+	stw	r10,crit_sprg7@l(r8);					     \
 	mfspr	r10,SPRN_PID;						     \
-	stw	r10,crit_pid@l(0);					     \
+	stw	r10,crit_pid@l(r8);					     \
 	mfspr	r10,SRR0;						     \
-	stw	r10,crit_srr0@l(0);					     \
+	stw	r10,crit_srr0@l(r8);					     \
 	mfspr	r10,SRR1;						     \
-	stw	r10,crit_srr1@l(0);					     \
+	stw	r10,crit_srr1@l(r8);					     \
+	mfspr	r8,SPRG2;		/* SPRG2 only used in criticals */   \
 	mfcr	r10;			/* save CR in r10 for now	   */\
 	mfspr	r11,SPRN_CSRR1;		/* check whether user or kernel    */\
 	andi.	r11,r11,MSR_PR;						     \
@@ -366,7 +372,6 @@
 	lwz	r11,THREAD_INFO-THREAD(r11); /* this thread's kernel stack */\
 	addi	r11,r11,THREAD_SIZE;					     \
 1:	subi	r11,r11,INT_FRAME_SIZE;	/* Allocate an exception frame     */\
-	tophys(r11,r11);						     \
 	stw	r10,_CCR(r11);          /* save various registers	   */\
 	stw	r12,GPR12(r11);						     \
 	stw	r9,GPR9(r11);						     \
@@ -763,61 +768,50 @@
  * the MSR_DE bit set.
  */
 	/* Debug Interrupt */
-	CRITICAL_EXCEPTION(0x2000, Debug, DebugException)
-#if 0
 	START_EXCEPTION(Debug)
-	/* This first instruction was already executed by the exception
-	 * handler and must be the first instruction of every exception
-	 * handler.
-	 */
-	mtspr	SPRN_SPRG0,r10		/* Save some working registers... */
-	mtspr	SPRN_SPRG1,r11
-	mtspr	SPRN_SPRG4W,r12
-	mfcr	r10			/* ..and the cr because we change it */
-
-	mfspr   r11,SPRN_CSRR1		/* MSR at the time of fault */
-	andi.   r11,r11,MSR_PR
-	bne+    2f			/* trapped from problem state */
-
-	mfspr   r11,SPRN_CSRR0		/* Faulting instruction address */
-	lis	r12, KERNELBASE@h
-	ori	r12, r12, KERNELBASE@l
-	cmplw   r11,r12
-	blt+    2f			/* addr below exception vectors */
-
-	lis	r12, Debug@h
-	ori	r12, r12, Debug@l
-	cmplw   r11,r12
-	bgt+    2f			/* addr above TLB exception vectors */
-
-	lis     r11,DBSR_IC@h           /* Remove the trap status */
-	mtspr   SPRN_DBSR,r11
-
-	mfspr	r11,SPRN_CSRR1
-	rlwinm	r11,r11,0,23,21		/* clear MSR_DE */
-	mtspr	SPRN_CSRR1, r11		/* restore MSR at rcfi without DE */
-
-	mtcrf   0xff,r10                /* restore registers */
-	mfspr	r12,SPRN_SPRG4R
-	mfspr   r11,SPRN_SPRG1
-	mfspr   r10,SPRN_SPRG0
-
-	sync
-	rfci                            /* return to the exception handler  */
-	b	.			/* prevent prefetch past rfci */
+	CRITICAL_EXCEPTION_PROLOG

-2:
-	mtcrf   0xff,r10                /* restore registers */
-	mfspr   r12,SPRN_SPRG4R
-	mfspr   r11,SPRN_SPRG1
-	mfspr   r10,SPRN_SPRG0
+	/*
+	 * If this is a single step or branch-taken exception in an
+	 * exception entry sequence, it was probably meant to apply to
+	 * the code where the exception occurred (since exception entry
+	 * doesn't turn off DE automatically).  We simulate the effect
+	 * of turning off DE on entry to an exception handler by turning
+	 * off DE in the CSRR1 value and clearing the debug status.
+	 */
+	mfspr	r10,SPRN_DBSR		/* check single-step/branch taken */
+	andis.	r10,r10,(DBSR_IC|DBSR_BT)@h
+	beq+	1f
+	andi.	r0,r9,MSR_PR		/* check supervisor */
+	beq	2f			/* branch if we need to fix it up... */

-	CRIT_EXCEPTION_PROLOG
+	/* continue normal handling for a critical exception... */
+1:	mfspr	r4,SPRN_DBSR
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	li	r7,CRIT_EXC;
-        li      r9,MSR_KERNEL
-	FINISH_EXCEPTION(DebugException)
-#endif
+	EXC_XFER_TEMPLATE(DebugException, 0x2002, \
+		(MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), \
+		NOCOPY, crit_transfer_to_handler, ret_from_crit_exc)
+
+	/* here it looks like we got an inappropriate debug exception. */
+2:	rlwinm	r9,r9,0,~MSR_DE		/* clear DE in the CSRR1 value */
+	mtspr	SPRN_DBSR,r10		/* clear the IC/BT debug intr status */
+	/* restore state and get out */
+	lwz	r10,_CCR(r11)
+	lwz	r0,GPR0(r11)
+	lwz	r1,GPR1(r11)
+	mtcrf	0x80,r10
+	mtspr	CSRR0,r12
+	mtspr	CSRR1,r9
+	lwz	r9,GPR9(r11)
+
+	mtspr	SPRG2,r8;		/* SPRG2 only used in criticals */
+	lis	r8,crit_save@ha;
+	lwz	r10,crit_r10@l(r8)
+	lwz	r11,crit_r11@l(r8)
+	mfspr	r8,SPRG2
+
+	rfci
+	b	.

 /*
  * Local functions
@@ -976,24 +970,13 @@
 	.previous

 /*
- * This space gets a copy of optional info passed to us by the bootstrap
- * which is used to pass parameters into the kernel like root=/dev/sda1, etc.
- */
-_GLOBAL(cmd_line)
-	.space	512
-
-/*
- * Room for two PTE pointers, usually the kernel and current user pointers
- * to their respective root page table.
- */
-abatron_pteptrs:
-	.space	8
-
-/*
  * This area is used for temporarily saving registers during the
- * critical exception prolog.
+ * critical exception prolog. It must always follow the page
+ * aligned allocations, so it starts on a page boundary, ensuring
+ * that all crit_save areas are in a single page.
  */
-crit_save:
+_GLOBAL(crit_save)
+	.space  4
 _GLOBAL(crit_r10)
 	.space	4
 _GLOBAL(crit_r11)
@@ -1016,3 +999,19 @@
 	.space	4
 _GLOBAL(crit_srr1)
 	.space	4
+
+/*
+ * This space gets a copy of optional info passed to us by the bootstrap
+ * which is used to pass parameters into the kernel like root=/dev/sda1, etc.
+ */
+_GLOBAL(cmd_line)
+	.space	512
+
+/*
+ * Room for two PTE pointers, usually the kernel and current user pointers
+ * to their respective root page table.
+ */
+abatron_pteptrs:
+	.space	8
+
+
diff -Nru a/include/asm-ppc/reg_booke.h b/include/asm-ppc/reg_booke.h
--- a/include/asm-ppc/reg_booke.h	Wed May  5 17:21:54 2004
+++ b/include/asm-ppc/reg_booke.h	Wed May  5 17:21:54 2004
@@ -144,6 +144,7 @@
  */
 #ifdef CONFIG_BOOKE
 #define DBSR_IC		0x08000000	/* Instruction Completion */
+#define DBSR_BT		0x04000000	/* Branch Taken */
 #define DBSR_TIE	0x01000000	/* Trap Instruction Event */
 #endif
 #ifdef CONFIG_40x

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/


