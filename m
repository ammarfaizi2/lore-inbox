Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262391AbUEKA2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbUEKA2q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 20:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbUEKA2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 20:28:46 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:40917 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S262476AbUEKAYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 20:24:38 -0400
Date: Mon, 10 May 2004 17:23:35 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Cc: paulus@samba.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@lists.linuxppc.org
Subject: [PATCH][2/2] PPC32: Add Book E / PPC44x specific exception support
Message-ID: <20040510172335.D26495@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds general Book E machine check exception support and PPC44x-specific
machine check exception implementation. Please apply.

-Matt

diff -Nru a/arch/ppc/kernel/entry.S b/arch/ppc/kernel/entry.S
--- a/arch/ppc/kernel/entry.S	Mon May 10 14:41:18 2004
+++ b/arch/ppc/kernel/entry.S	Mon May 10 14:41:18 2004
@@ -56,6 +56,19 @@
 #define BOOKE_SAVE_COR
 #endif
 
+#ifdef CONFIG_BOOKE
+	.globl	mcheck_transfer_to_handler
+mcheck_transfer_to_handler:
+	mtspr	SPRG6W,r8
+	lis	r8,mcheck_save@ha
+	lwz	r0,mcheck_r10@l(r8)
+	stw	r0,GPR10(r11)
+	lwz	r0,mcheck_r11@l(r8)
+	stw	r0,GPR11(r11)
+	mfspr	r8,SPRG6R
+	b	transfer_to_handler_full
+#endif
+
 #if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
 	.globl	crit_transfer_to_handler
 crit_transfer_to_handler:
@@ -97,7 +110,7 @@
 	beq	2f			/* if from user, fix up THREAD.regs */
 	addi	r11,r1,STACK_FRAME_OVERHEAD
 	stw	r11,PT_REGS(r12)
-#ifdef CONFIG_4xx
+#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
 	lwz	r12,PTRACE-THREAD(r12)
 	andi.	r12,r12,PT_PTRACED
 	beq+	3f
@@ -738,8 +751,10 @@
 	mtspr	SPRN_SPRG4,r10
 	lwz	r10,crit_sprg5@l(COR)
 	mtspr	SPRN_SPRG5,r10
+#ifdef CONFIG_40x
 	lwz	r10,crit_sprg6@l(COR)
 	mtspr	SPRN_SPRG6,r10
+#endif
 	lwz	r10,crit_sprg7@l(COR)
 	mtspr	SPRN_SPRG7,r10
 	lwz	r10,crit_srr0@l(COR)
@@ -755,6 +770,74 @@
 	PPC405_ERR77_SYNC
 	rfci
 	b	.		/* prevent prefetch past rfci */
+
+#ifdef CONFIG_BOOKE
+/*
+ * Return from a machine check interrupt, similar to a critical
+ * interrupt.
+ */
+	.globl	ret_from_mcheck_exc
+ret_from_mcheck_exc:
+	REST_NVGPRS(r1)
+	lwz	r3,_MSR(r1)
+	andi.	r3,r3,MSR_PR
+	LOAD_MSR_KERNEL(r10,MSR_KERNEL)
+	bne	user_exc_return
+
+	lwz	r0,GPR0(r1)
+	lwz	r2,GPR2(r1)
+	REST_4GPRS(3, r1)
+	REST_2GPRS(7, r1)
+
+	lwz	r10,_XER(r1)
+	lwz	r11,_CTR(r1)
+	mtspr	XER,r10
+	mtctr	r11
+
+	stwcx.	r0,0,r1			/* to clear the reservation */
+
+	lwz	r11,_LINK(r1)
+	mtlr	r11
+	lwz	r10,_CCR(r1)
+	mtcrf	0xff,r10
+	lwz	r9,_DEAR(r1)
+	lwz	r10,_ESR(r1)
+	mtspr	SPRN_DEAR,r9
+	mtspr	SPRN_ESR,r10
+	lwz	r11,_NIP(r1)
+	lwz	r12,_MSR(r1)
+	mtspr	MCSRR0,r11
+	mtspr	MCSRR1,r12
+	lwz	r9,GPR9(r1)
+	lwz	r12,GPR12(r1)
+	mtspr	SPRG6W,r8
+	lis	r8,mcheck_save@ha
+	lwz	r10,mcheck_sprg0@l(r8)
+	mtspr	SPRN_SPRG0,r10
+	lwz	r10,mcheck_sprg1@l(r8)
+	mtspr	SPRN_SPRG1,r10
+	lwz	r10,mcheck_sprg4@l(r8)
+	mtspr	SPRN_SPRG4,r10
+	lwz	r10,mcheck_sprg5@l(r8)
+	mtspr	SPRN_SPRG5,r10
+	lwz	r10,mcheck_sprg7@l(r8)
+	mtspr	SPRN_SPRG7,r10
+	lwz	r10,mcheck_srr0@l(r8)
+	mtspr	SRR0,r10
+	lwz	r10,mcheck_srr1@l(r8)
+	mtspr	SRR1,r10
+	lwz	r10,mcheck_csrr0@l(r8)
+	mtspr	CSRR0,r10
+	lwz	r10,mcheck_csrr1@l(r8)
+	mtspr	CSRR1,r10
+	lwz	r10,mcheck_pid@l(r8)
+	mtspr	SPRN_PID,r10
+	lwz	r10,GPR10(r1)
+	lwz	r11,GPR11(r1)
+	lwz	r1,GPR1(r1)
+	mfspr	r8,SPRG6R
+	RFMCI	
+#endif /* CONFIG_BOOKE */
 
 /*
  * Load the DBCR0 value for a task that is being ptraced,
diff -Nru a/arch/ppc/kernel/head_44x.S b/arch/ppc/kernel/head_44x.S
--- a/arch/ppc/kernel/head_44x.S	Mon May 10 14:41:18 2004
+++ b/arch/ppc/kernel/head_44x.S	Mon May 10 14:41:18 2004
@@ -350,8 +350,6 @@
 	stw	r10,crit_sprg4@l(r8);					     \
 	mfspr	r10,SPRG5R;						     \
 	stw	r10,crit_sprg5@l(r8);					     \
-	mfspr	r10,SPRG6R;						     \
-	stw	r10,crit_sprg6@l(r8);					     \
 	mfspr	r10,SPRG7R;						     \
 	stw	r10,crit_sprg7@l(r8);					     \
 	mfspr	r10,SPRN_PID;						     \
@@ -392,6 +390,71 @@
 	SAVE_2GPRS(7, r11)
 
 /*
+ * Exception prolog for machine check exceptions.  This is similar to
+ * the critical exception prolog, except that machine check exceptions
+ * have their own save area.  For Book E processors, we also have a
+ * reserved register (SPRG6) that is only used in machine check exceptions
+ * so we can free up a GPR to use as the base for indirect access to the
+ * machine check exception save area.  This is necessary since the MMU
+ * is always on and the save area is offset from KERNELBASE.
+ */
+#define MCHECK_EXCEPTION_PROLOG					     \
+	mtspr	SPRG6W,r8;		/* SPRG6 used in machine checks */   \
+	lis	r8,mcheck_save@ha;					     \
+	stw	r10,mcheck_r10@l(r8);					     \
+	stw	r11,mcheck_r11@l(r8);					     \
+	mfspr	r10,SPRG0;						     \
+	stw	r10,mcheck_sprg0@l(r8);					     \
+	mfspr	r10,SPRG1;						     \
+	stw	r10,mcheck_sprg1@l(r8);					     \
+	mfspr	r10,SPRG4R;						     \
+	stw	r10,mcheck_sprg4@l(r8);					     \
+	mfspr	r10,SPRG5R;						     \
+	stw	r10,mcheck_sprg5@l(r8);					     \
+	mfspr	r10,SPRG7R;						     \
+	stw	r10,mcheck_sprg7@l(r8);					     \
+	mfspr	r10,SPRN_PID;						     \
+	stw	r10,mcheck_pid@l(r8);					     \
+	mfspr	r10,SRR0;						     \
+	stw	r10,mcheck_srr0@l(r8);					     \
+	mfspr	r10,SRR1;						     \
+	stw	r10,mcheck_srr1@l(r8);					     \
+	mfspr	r10,CSRR0;						     \
+	stw	r10,mcheck_csrr0@l(r8);					     \
+	mfspr	r10,CSRR1;						     \
+	stw	r10,mcheck_csrr1@l(r8);					     \
+	mfspr	r8,SPRG6R;		/* SPRG6 used in machine checks */   \
+	mfcr	r10;			/* save CR in r10 for now	   */\
+	mfspr	r11,SPRN_MCSRR1;	/* check whether user or kernel    */\
+	andi.	r11,r11,MSR_PR;						     \
+	lis	r11,mcheck_stack_top@h;					     \
+	ori	r11,r11,mcheck_stack_top@l;				     \
+	beq	1f;							     \
+	/* COMING FROM USER MODE */					     \
+	mfspr	r11,SPRG3;		/* if from user, start at top of   */\
+	lwz	r11,THREAD_INFO-THREAD(r11); /* this thread's kernel stack */\
+	addi	r11,r11,THREAD_SIZE;					     \
+1:	subi	r11,r11,INT_FRAME_SIZE;	/* Allocate an exception frame     */\
+	stw	r10,_CCR(r11);          /* save various registers	   */\
+	stw	r12,GPR12(r11);						     \
+	stw	r9,GPR9(r11);						     \
+	mflr	r10;							     \
+	stw	r10,_LINK(r11);						     \
+	mfspr	r12,SPRN_DEAR;		/* save DEAR and ESR in the frame  */\
+	stw	r12,_DEAR(r11);		/* since they may have had stuff   */\
+	mfspr	r9,SPRN_ESR;		/* in them at the point where the  */\
+	stw	r9,_ESR(r11);		/* exception was taken		   */\
+	mfspr	r12,MCSRR0;						     \
+	stw	r1,GPR1(r11);						     \
+	mfspr	r9,MCSRR1;						     \
+	stw	r1,0(r11);						     \
+	tovirt(r1,r11);							     \
+	rlwinm	r9,r9,0,14,12;		/* clear MSR_WE (necessary?)	   */\
+	stw	r0,GPR0(r11);						     \
+	SAVE_4GPRS(3, r11);						     \
+	SAVE_2GPRS(7, r11)
+
+/*
  * Exception vectors.
  */
 #define	START_EXCEPTION(label)						     \
@@ -417,6 +480,18 @@
 			  NOCOPY, transfer_to_handler_full, \
 			  ret_from_except_full)
 
+#define MCHECK_EXCEPTION(n, label, hdlr)			\
+	START_EXCEPTION(label);					\
+	MCHECK_EXCEPTION_PROLOG;				\
+	lis	r4,MCSR_MCS@h;					\
+	mtspr	SPRN_MCSR,r4;					\
+	mfspr	r5,SPRN_ESR;					\
+	stw	r5,_ESR(r11);					\
+	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
+	EXC_XFER_TEMPLATE(hdlr, n+2, (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), \
+			  NOCOPY, mcheck_transfer_to_handler,   \
+			  ret_from_mcheck_exc)
+
 #define EXC_XFER_TEMPLATE(hdlr, trap, msr, copyee, tfer, ret)	\
 	li	r10,trap;					\
 	stw	r10,TRAP(r11);					\
@@ -451,7 +526,11 @@
 	CRITICAL_EXCEPTION(0x0100, CriticalInput, UnknownException)
 
 	/* Machine Check Interrupt */
+#ifdef CONFIG_440A
+	MCHECK_EXCEPTION(0x0200, MachineCheck, MachineCheckException)
+#else
 	CRITICAL_EXCEPTION(0x0200, MachineCheck, MachineCheckException)
+#endif
 
 	/* Data Storage Interrupt */
 	START_EXCEPTION(DataStorage)
@@ -459,7 +538,6 @@
 	mtspr	SPRG1, r11
 	mtspr	SPRG4W, r12
 	mtspr	SPRG5W, r13
-	mtspr	SPRG6W, r14
 	mfcr	r11
 	mtspr	SPRG7W, r11
 
@@ -532,15 +610,14 @@
 	rlwinm	r11,r11,0,20,15		/* Clear U0-U3 */
 
 	/* find the TLB index that caused the fault.  It has to be here. */
-	tlbsx	r14, 0, r10
+	tlbsx	r10, 0, r10
 
-	tlbwe	r11, r14, PPC44x_TLB_ATTRIB	/* Write ATTRIB */
+	tlbwe	r11, r10, PPC44x_TLB_ATTRIB	/* Write ATTRIB */
 
 	/* Done...restore registers and get out of here.
 	*/
 	mfspr	r11, SPRG7R
 	mtcr	r11
-	mfspr	r14, SPRG6R
 	mfspr	r13, SPRG5R
 	mfspr	r12, SPRG4R
 
@@ -555,7 +632,6 @@
 	 */
 	mfspr	r11, SPRG7R
 	mtcr	r11
-	mfspr	r14, SPRG6R
 	mfspr	r13, SPRG5R
 	mfspr	r12, SPRG4R
 
@@ -623,7 +699,6 @@
 	mtspr	SPRG1, r11
 	mtspr	SPRG4W, r12
 	mtspr	SPRG5W, r13
-	mtspr	SPRG6W, r14
 	mfcr	r11
 	mtspr	SPRG7W, r11
 	mfspr	r10, SPRN_DEAR		/* Get faulting address */
@@ -676,7 +751,6 @@
 	 */
 	mfspr	r11, SPRG7R
 	mtcr	r11
-	mfspr	r14, SPRG6R
 	mfspr	r13, SPRG5R
 	mfspr	r12, SPRG4R
 	mfspr	r11, SPRG1
@@ -694,7 +768,6 @@
 	mtspr	SPRG1, r11
 	mtspr	SPRG4W, r12
 	mtspr	SPRG5W, r13
-	mtspr	SPRG6W, r14
 	mfcr	r11
 	mtspr	SPRG7W, r11
 	mfspr	r10, SRR0		/* Get faulting address */
@@ -747,7 +820,6 @@
 	 */
 	mfspr	r11, SPRG7R
 	mtcr	r11
-	mfspr	r14, SPRG6R
 	mfspr	r13, SPRG5R
 	mfspr	r12, SPRG4R
 	mfspr	r11, SPRG1
@@ -837,7 +909,6 @@
  * 	r11 - available to use
  *	r12 - Pointer to the 64-bit PTE
  *	r13 - available to use
- *	r14 - available to use
  *	MMUCR - loaded with proper value when we get here
  *	Upon exit, we reload everything and RFI.
  */
@@ -852,51 +923,50 @@
 
 	/* Load the next available TLB index */
 	lis	r13, tlb_44x_index@ha
-	lwz	r14, tlb_44x_index@l(r13)
+	lwz	r13, tlb_44x_index@l(r13)
 	/* Load the TLB high watermark */
-	lis	r13, tlb_44x_hwater@ha
-	lwz	r11, tlb_44x_hwater@l(r13)
+	lis	r11, tlb_44x_hwater@ha
+	lwz	r11, tlb_44x_hwater@l(r11)
 
 	/* Increment, rollover, and store TLB index */
-	addi	r14, r14, 1
-	cmpw	0, r14, r11			/* reserve entries */
+	addi	r13, r13, 1
+	cmpw	0, r13, r11			/* reserve entries */
 	ble	7f
-	li	r14, 0
+	li	r13, 0
 7:
 	/* Store the next available TLB index */
-	lis	r13, tlb_44x_index@ha
-	stw	r14, tlb_44x_index@l(r13)
+	lis	r11, tlb_44x_index@ha
+	stw	r13, tlb_44x_index@l(r11)
 
-	lwz	r13, 0(r12)			/* Get MS word of PTE */
-	lwz	r11, 4(r12)			/* Get LS word of PTE */
-	rlwimi	r13, r11, 0, 0 , 19		/* Insert RPN */
-	tlbwe	r13, r14, PPC44x_TLB_XLAT	/* Write XLAT */
+	lwz	r11, 0(r12)			/* Get MS word of PTE */
+	lwz	r12, 4(r12)			/* Get LS word of PTE */
+	rlwimi	r11, r12, 0, 0 , 19		/* Insert RPN */
+	tlbwe	r11, r13, PPC44x_TLB_XLAT	/* Write XLAT */
 
 	/*
 	 * Create PAGEID. This is the faulting address,
 	 * page size, and valid flag.
 	 */
-	li	r12, PPC44x_TLB_VALID | PPC44x_TLB_4K
-	rlwimi	r10, r12, 0, 20, 31		/* Insert valid and page size */
-	tlbwe	r10, r14, PPC44x_TLB_PAGEID	/* Write PAGEID */
-
-	li	r13, PPC44x_TLB_SR@l		/* Set SR */
-	rlwimi	r13, r11, 0, 30, 30		/* Set SW = _PAGE_RW */
-	rlwimi	r13, r11, 29, 29, 29		/* SX = _PAGE_HWEXEC */
-	rlwimi	r13, r11, 29, 28, 28		/* UR = _PAGE_USER */
-	rlwimi	r12, r11, 31, 26, 26		/* (_PAGE_USER>>1)->r12 */
-	and	r12, r12, r11			/* HWEXEC & USER */
-	rlwimi	r13, r12, 0, 26, 26		/* UX = HWEXEC & USER */
-
-	rlwimi	r11, r13, 0, 26, 31		/* Insert static perms */
-	rlwinm	r11, r11, 0, 20, 15		/* Clear U0-U3 */
-	tlbwe	r11, r14, PPC44x_TLB_ATTRIB	/* Write ATTRIB */
+	li	r11, PPC44x_TLB_VALID | PPC44x_TLB_4K
+	rlwimi	r10, r11, 0, 20, 31		/* Insert valid and page size */
+	tlbwe	r10, r13, PPC44x_TLB_PAGEID	/* Write PAGEID */
+
+	li	r10, PPC44x_TLB_SR@l		/* Set SR */
+	rlwimi	r10, r12, 0, 30, 30		/* Set SW = _PAGE_RW */
+	rlwimi	r10, r12, 29, 29, 29		/* SX = _PAGE_HWEXEC */
+	rlwimi	r10, r12, 29, 28, 28		/* UR = _PAGE_USER */
+	rlwimi	r11, r12, 31, 26, 26		/* (_PAGE_USER>>1)->r12 */
+	and	r11, r12, r11			/* HWEXEC & USER */
+	rlwimi	r10, r11, 0, 26, 26		/* UX = HWEXEC & USER */
+
+	rlwimi	r12, r10, 0, 26, 31		/* Insert static perms */
+	rlwinm	r12, r12, 0, 20, 15		/* Clear U0-U3 */
+	tlbwe	r12, r13, PPC44x_TLB_ATTRIB	/* Write ATTRIB */
 
 	/* Done...restore registers and get out of here.
 	*/
 	mfspr	r11, SPRG7R
 	mtcr	r11
-	mfspr	r14, SPRG6R
 	mfspr	r13, SPRG5R
 	mfspr	r12, SPRG4R
 	mfspr	r11, SPRG1
@@ -962,19 +1032,28 @@
 _GLOBAL(swapper_pg_dir)
 	.space	8192
 
-/* Stack for handling critical exceptions from kernel mode */
 	.section .bss
+/* Stack for handling critical exceptions from kernel mode */
 critical_stack_bottom:
 	.space 4096
 critical_stack_top:
 	.previous
 
+/* Stack for handling machine check exceptions from kernel mode */
+mcheck_stack_bottom:
+	.space 4096
+mcheck_stack_top:
+	.previous
+
 /*
  * This area is used for temporarily saving registers during the
- * critical exception prolog. It must always follow the page
- * aligned allocations, so it starts on a page boundary, ensuring
- * that all crit_save areas are in a single page.
+ * critical and machine check exception prologs. It must always
+ * follow the page aligned allocations, so it starts on a page
+ * boundary, ensuring that all crit_save areas are in a single
+ * page.
  */
+
+/* crit_save */
 _GLOBAL(crit_save)
 	.space  4
 _GLOBAL(crit_r10)
@@ -989,8 +1068,6 @@
 	.space	4
 _GLOBAL(crit_sprg5)
 	.space	4
-_GLOBAL(crit_sprg6)
-	.space	4
 _GLOBAL(crit_sprg7)
 	.space	4
 _GLOBAL(crit_pid)
@@ -998,6 +1075,34 @@
 _GLOBAL(crit_srr0)
 	.space	4
 _GLOBAL(crit_srr1)
+	.space	4
+
+/* mcheck_save */
+_GLOBAL(mcheck_save)
+	.space  4
+_GLOBAL(mcheck_r10)
+	.space	4
+_GLOBAL(mcheck_r11)
+	.space	4
+_GLOBAL(mcheck_sprg0)
+	.space	4
+_GLOBAL(mcheck_sprg1)
+	.space	4
+_GLOBAL(mcheck_sprg4)
+	.space	4
+_GLOBAL(mcheck_sprg5)
+	.space	4
+_GLOBAL(mcheck_sprg7)
+	.space	4
+_GLOBAL(mcheck_pid)
+	.space	4
+_GLOBAL(mcheck_srr0)
+	.space	4
+_GLOBAL(mcheck_srr1)
+	.space	4
+_GLOBAL(mcheck_csrr0)
+	.space	4
+_GLOBAL(mcheck_csrr1)
 	.space	4
 
 /*
diff -Nru a/arch/ppc/kernel/traps.c b/arch/ppc/kernel/traps.c
--- a/arch/ppc/kernel/traps.c	Mon May 10 14:41:18 2004
+++ b/arch/ppc/kernel/traps.c	Mon May 10 14:41:18 2004
@@ -222,14 +222,43 @@
 	if (check_io_access(regs))
 		return;
 
-#ifdef CONFIG_4xx
+#if defined(CONFIG_4xx) && !defined(CONFIG_440A)
 	if (reason & ESR_IMCP) {
 		printk("Instruction");
 		mtspr(SPRN_ESR, reason & ~ESR_IMCP);
 	} else
 		printk("Data");
 	printk(" machine check in kernel mode.\n");
-
+#elif defined(CONFIG_440A)
+	printk("Machine check in kernel mode.\n");
+	if (reason & ESR_IMCP){
+		printk("Instruction Synchronous Machine Check exception\n");
+		mtspr(SPRN_ESR, reason & ~ESR_IMCP);
+	}
+	else {
+		u32 mcsr = mfspr(SPRN_MCSR);
+		if (mcsr & MCSR_IB)
+			printk("Instruction Read PLB Error\n");
+		if (mcsr & MCSR_DRB)
+			printk("Data Read PLB Error\n");
+		if (mcsr & MCSR_DWB)
+			printk("Data Write PLB Error\n");
+		if (mcsr & MCSR_TLBP)
+			printk("TLB Parity Error\n");
+		if (mcsr & MCSR_ICP){
+			flush_instruction_cache();
+			printk("I-Cache Parity Error\n");
+		}	
+		if (mcsr & MCSR_DCSP)
+			printk("D-Cache Search Parity Error\n");
+		if (mcsr & MCSR_DCFP)
+			printk("D-Cache Flush Parity Error\n");
+		if (mcsr & MCSR_IMPE)
+			printk("Machine Check exception is imprecise\n");
+		
+		/* Clear MCSR */
+		mtspr(SPRN_MCSR, mcsr);
+	}
 #else /* !CONFIG_4xx */
 	printk("Machine check in kernel mode.\n");
 	printk("Caused by (from SRR1=%lx): ", reason);
diff -Nru a/include/asm-ppc/ppc_asm.h b/include/asm-ppc/ppc_asm.h
--- a/include/asm-ppc/ppc_asm.h	Mon May 10 14:41:18 2004
+++ b/include/asm-ppc/ppc_asm.h	Mon May 10 14:41:18 2004
@@ -161,6 +161,8 @@
 #define CLR_TOP32(r)
 #endif /* CONFIG_PPC64BRIDGE */
 
+#define RFMCI		.long 0x4c00004c	/* rfmci instruction */
+
 #ifdef CONFIG_IBM405_ERR77
 #define PPC405_ERR77(ra,rb)	dcbt	ra, rb;
 #define	PPC405_ERR77_SYNC	sync;
diff -Nru a/include/asm-ppc/reg_booke.h b/include/asm-ppc/reg_booke.h
--- a/include/asm-ppc/reg_booke.h	Mon May 10 14:41:18 2004
+++ b/include/asm-ppc/reg_booke.h	Mon May 10 14:41:18 2004
@@ -86,6 +86,20 @@
 #define SPRN_IVOR13	0x19D	/* Interrupt Vector Offset Register 13 */
 #define SPRN_IVOR14	0x19E	/* Interrupt Vector Offset Register 14 */
 #define SPRN_IVOR15	0x19F	/* Interrupt Vector Offset Register 15 */
+#define SPRN_MCSRR0	0x23A	/* Machine Check Save and Restore Register 0 */
+#define SPRN_MCSRR1	0x23B	/* Machine Check Save and Restore Register 1 */
+#define SPRN_MCSR	0x23C	/* Machine Check Status Register */
+#ifdef CONFIG_440A
+#define  MCSR_MCS	0x80000000 /* Machine Check Summary */
+#define  MCSR_IB	0x40000000 /* Instruction PLB Error */
+#define  MCSR_DRB	0x20000000 /* Data Read PLB Error */
+#define  MCSR_DWB	0x10000000 /* Data Write PLB Error */
+#define  MCSR_TLBP	0x08000000 /* TLB Parity Error */
+#define  MCSR_ICP	0x04000000 /* I-Cache Parity Error */
+#define  MCSR_DCSP	0x02000000 /* D-Cache Search Parity Error */
+#define  MCSR_DCFP	0x01000000 /* D-Cache Flush Parity Error */
+#define  MCSR_IMPE	0x00800000 /* Imprecise Machine Check Exception */
+#endif
 #define SPRN_ZPR	0x3B0	/* Zone Protection Register (40x) */
 #define SPRN_MMUCR	0x3B2	/* MMU Control Register */
 #define SPRN_CCR0	0x3B3	/* Core Configuration Register */
@@ -251,6 +265,8 @@
 #define CSRR0	SPRN_SRR2	/* Logically and functionally equivalent. */
 #define CSRR1	SPRN_SRR3	/* Logically and functionally equivalent. */
 #endif
+#define MCSRR0	SPRN_MCSRR0	/* Machine Check Save and Restore Register 0 */
+#define MCSRR1	SPRN_MCSRR1	/* Machine Check Save and Restore Register 1 */
 #define DCMP	SPRN_DCMP	/* Data TLB Compare Register */
 #define SPRG4R	SPRN_SPRG4R	/* Supervisor Private Registers */
 #define SPRG5R	SPRN_SPRG5R
