Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263566AbUJ3A6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263566AbUJ3A6H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 20:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbUJ3A4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 20:56:38 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:41462 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S263566AbUJ3AwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 20:52:20 -0400
Date: Fri, 29 Oct 2004 17:51:58 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org,
       trini@kernel.crashing.org, takeharu1219@ybb.ne.jp
Subject: [PATCH][PPC32][1/2] 40x and Book E debug: core support
Message-ID: <20041029175158.D13435@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the 40x and Book E Debug exception handling paths
to handle kernel space debug events. It also fixes up the in-kernel
ppc32 kgdb stub to work properly.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

diff -Nru a/arch/ppc/kernel/head_44x.S b/arch/ppc/kernel/head_44x.S
--- a/arch/ppc/kernel/head_44x.S	2004-10-29 17:13:29 -07:00
+++ b/arch/ppc/kernel/head_44x.S	2004-10-29 17:13:29 -07:00
@@ -599,64 +599,8 @@
 	mfspr	r10, SPRG0
 	b	InstructionStorage
 
-/* Check for a single step debug exception while in an exception
- * handler before state has been saved.  This is to catch the case
- * where an instruction that we are trying to single step causes
- * an exception (eg ITLB/DTLB miss) and thus the first instruction of
- * the exception handler generates a single step debug exception.
- *
- * If we get a debug trap on the first instruction of an exception handler,
- * we reset the MSR_DE in the _exception handler's_ MSR (the debug trap is
- * a critical exception, so we are using SPRN_CSRR1 to manipulate the MSR).
- * The exception handler was handling a non-critical interrupt, so it will
- * save (and later restore) the MSR via SPRN_SRR1, which will still have
- * the MSR_DE bit set.
- */
 	/* Debug Interrupt */
-	START_EXCEPTION(Debug)
-	CRITICAL_EXCEPTION_PROLOG
-
-	/*
-	 * If this is a single step or branch-taken exception in an
-	 * exception entry sequence, it was probably meant to apply to
-	 * the code where the exception occurred (since exception entry
-	 * doesn't turn off DE automatically).  We simulate the effect
-	 * of turning off DE on entry to an exception handler by turning
-	 * off DE in the CSRR1 value and clearing the debug status.
-	 */
-	mfspr	r10,SPRN_DBSR		/* check single-step/branch taken */
-	andis.	r10,r10,(DBSR_IC|DBSR_BT)@h
-	beq+	1f
-	andi.	r0,r9,MSR_PR		/* check supervisor */
-	beq	2f			/* branch if we need to fix it up... */
-
-	/* continue normal handling for a critical exception... */
-1:	mfspr	r4,SPRN_DBSR
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	EXC_XFER_TEMPLATE(DebugException, 0x2002, \
-		(MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), \
-		NOCOPY, crit_transfer_to_handler, ret_from_crit_exc)
-
-	/* here it looks like we got an inappropriate debug exception. */
-2:	rlwinm	r9,r9,0,~MSR_DE		/* clear DE in the CSRR1 value */
-	mtspr	SPRN_DBSR,r10		/* clear the IC/BT debug intr status */
-	/* restore state and get out */
-	lwz	r10,_CCR(r11)
-	lwz	r0,GPR0(r11)
-	lwz	r1,GPR1(r11)
-	mtcrf	0x80,r10
-	mtspr	CSRR0,r12
-	mtspr	CSRR1,r9
-	lwz	r9,GPR9(r11)
-
-	mtspr	SPRG2,r8;		/* SPRG2 only used in criticals */
-	lis	r8,crit_save@ha;
-	lwz	r10,crit_r10@l(r8)
-	lwz	r11,crit_r11@l(r8)
-	mfspr	r8,SPRG2
-
-	rfci
-	b	.
+	DEBUG_EXCEPTION
 
 /*
  * Local functions
diff -Nru a/arch/ppc/kernel/head_4xx.S b/arch/ppc/kernel/head_4xx.S
--- a/arch/ppc/kernel/head_4xx.S	2004-10-29 17:13:29 -07:00
+++ b/arch/ppc/kernel/head_4xx.S	2004-10-29 17:13:29 -07:00
@@ -709,8 +709,20 @@
 	EXCEPTION(0x1E00, Trap_1E, UnknownException, EXC_XFER_EE)
 	EXCEPTION(0x1F00, Trap_1F, UnknownException, EXC_XFER_EE)
 
-/* 0x2000 - Debug Exception
-*/
+/* Check for a single step debug exception while in an exception
+ * handler before state has been saved.  This is to catch the case
+ * where an instruction that we are trying to single step causes
+ * an exception (eg ITLB/DTLB miss) and thus the first instruction of
+ * the exception handler generates a single step debug exception.
+ *
+ * If we get a debug trap on the first instruction of an exception handler,
+ * we reset the MSR_DE in the _exception handler's_ MSR (the debug trap is
+ * a critical exception, so we are using SPRN_CSRR1 to manipulate the MSR).
+ * The exception handler was handling a non-critical interrupt, so it will
+ * save (and later restore) the MSR via SPRN_SRR1, which will still have
+ * the MSR_DE bit set.
+ */
+	/* 0x2000 - Debug Exception */
 	START_EXCEPTION(0x2000, DebugTrap)
 	CRITICAL_EXCEPTION_PROLOG
 
@@ -723,21 +735,20 @@
 	 * off DE in the SRR3 value and clearing the debug status.
 	 */
 	mfspr	r10,SPRN_DBSR		/* check single-step/branch taken */
-	andis.	r10,r10,(DBSR_IC|DBSR_BT)@h
-	beq+	1f
-	andi.	r0,r9,MSR_IR|MSR_PR	/* check supervisor + MMU off */
-	beq	2f			/* branch if we need to fix it up... */
+	andis.	r10,r10,DBSR_IC@h
+	beq+	2f
 
-	/* continue normal handling for a critical exception... */
-1:	mfspr	r4,SPRN_DBSR
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	EXC_XFER_TEMPLATE(DebugException, 0x2002, \
-		(MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), \
-		NOCOPY, crit_transfer_to_handler, ret_from_crit_exc)
+	andi.	r10,r9,MSR_IR|MSR_PR	/* check supervisor + MMU off */
+	beq	1f			/* branch and fix it up */
+
+	mfspr   r10,SPRN_SRR2		/* Faulting instruction address */
+	cmplwi  r10,0x2100
+	bgt+    2f			/* address above exception vectors */
 
 	/* here it looks like we got an inappropriate debug exception. */
-2:	rlwinm	r9,r9,0,~MSR_DE		/* clear DE in the SRR3 value */
-	mtspr	SPRN_DBSR,r10		/* clear the IC/BT debug intr status */
+1:	rlwinm	r9,r9,0,~MSR_DE		/* clear DE in the SRR3 value */
+	lis	r10,DBSR_IC@h		/* clear the IC event */
+	mtspr	SPRN_DBSR,r10
 	/* restore state and get out */
 	lwz	r10,_CCR(r11)
 	lwz	r0,GPR0(r11)
@@ -752,6 +763,13 @@
 	PPC405_ERR77_SYNC
 	rfci
 	b	.
+
+	/* continue normal handling for a critical exception... */
+2:	mfspr	r4,SPRN_DBSR
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	EXC_XFER_TEMPLATE(DebugException, 0x2002, \
+		(MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), \
+		NOCOPY, crit_transfer_to_handler, ret_from_crit_exc)
 
 /*
  * The other Data TLB exceptions bail out to this point
diff -Nru a/arch/ppc/kernel/head_booke.h b/arch/ppc/kernel/head_booke.h
--- a/arch/ppc/kernel/head_booke.h	2004-10-29 17:13:29 -07:00
+++ b/arch/ppc/kernel/head_booke.h	2004-10-29 17:13:29 -07:00
@@ -237,4 +237,70 @@
 			  ret_from_except)
 
 
+/* Check for a single step debug exception while in an exception
+ * handler before state has been saved.  This is to catch the case
+ * where an instruction that we are trying to single step causes
+ * an exception (eg ITLB/DTLB miss) and thus the first instruction of
+ * the exception handler generates a single step debug exception.
+ *
+ * If we get a debug trap on the first instruction of an exception handler,
+ * we reset the MSR_DE in the _exception handler's_ MSR (the debug trap is
+ * a critical exception, so we are using SPRN_CSRR1 to manipulate the MSR).
+ * The exception handler was handling a non-critical interrupt, so it will
+ * save (and later restore) the MSR via SPRN_CSRR1, which will still have
+ * the MSR_DE bit set.
+ */
+#define DEBUG_EXCEPTION							      \
+	START_EXCEPTION(Debug);						      \
+	CRITICAL_EXCEPTION_PROLOG;					      \
+									      \
+	/*								      \
+	 * If there is a single step or branch-taken exception in an	      \
+	 * exception entry sequence, it was probably meant to apply to	      \
+	 * the code where the exception occurred (since exception entry	      \
+	 * doesn't turn off DE automatically).  We simulate the effect	      \
+	 * of turning off DE on entry to an exception handler by turning      \
+	 * off DE in the CSRR1 value and clearing the debug status.	      \
+	 */								      \
+	mfspr	r10,SPRN_DBSR;		/* check single-step/branch taken */  \
+	andis.	r10,r10,DBSR_IC@h;					      \
+	beq+	2f;							      \
+									      \
+	lis	r10,KERNELBASE@h;	/* check if exception in vectors */   \
+	ori	r10,r10,KERNELBASE@l;					      \
+	cmplw	r12,r10;						      \
+	blt+	2f;			/* addr below exception vectors */    \
+									      \
+	lis	r10,Debug@h;						      \
+	ori	r10,r10,Debug@l;					      \
+	cmplw	r12,r10;						      \
+	bgt+	2f;			/* addr above exception vectors */    \
+									      \
+	/* here it looks like we got an inappropriate debug exception. */     \
+1:	rlwinm	r9,r9,0,~MSR_DE;	/* clear DE in the CSRR1 value */     \
+	lis	r10,DBSR_IC@h;		/* clear the IC event */	      \
+	mtspr	SPRN_DBSR,r10;						      \
+	/* restore state and get out */					      \
+	lwz	r10,_CCR(r11);						      \
+	lwz	r0,GPR0(r11);						      \
+	lwz	r1,GPR1(r11);						      \
+	mtcrf	0x80,r10;						      \
+	mtspr	CSRR0,r12;						      \
+	mtspr	CSRR1,r9;						      \
+	lwz	r9,GPR9(r11);						      \
+	lwz	r12,GPR12(r11);						      \
+	mtspr	SPRG2,r8;		/* SPRG2 only used in criticals */    \
+	lis	r8,crit_save@ha;					      \
+	lwz	r10,crit_r10@l(r8);					      \
+	lwz	r11,crit_r11@l(r8);					      \
+	mfspr	r8,SPRG2;						      \
+									      \
+	rfci;								      \
+	b	.;							      \
+									      \
+	/* continue normal handling for a critical exception... */	      \
+2:	mfspr	r4,SPRN_DBSR;						      \
+	addi	r3,r1,STACK_FRAME_OVERHEAD;				      \
+	EXC_XFER_TEMPLATE(DebugException, 0x2002, (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), NOCOPY, crit_transfer_to_handler, ret_from_crit_exc)
+
 #endif /* __HEAD_BOOKE_H__ */
diff -Nru a/arch/ppc/kernel/head_e500.S b/arch/ppc/kernel/head_e500.S
--- a/arch/ppc/kernel/head_e500.S	2004-10-29 17:13:29 -07:00
+++ b/arch/ppc/kernel/head_e500.S	2004-10-29 17:13:29 -07:00
@@ -668,64 +668,8 @@
 	/* Performance Monitor */
 	EXCEPTION(0x2060, PerformanceMonitor, UnknownException, EXC_XFER_EE)
 
-/* Check for a single step debug exception while in an exception
- * handler before state has been saved.  This is to catch the case
- * where an instruction that we are trying to single step causes
- * an exception (eg ITLB/DTLB miss) and thus the first instruction of
- * the exception handler generates a single step debug exception.
- *
- * If we get a debug trap on the first instruction of an exception handler,
- * we reset the MSR_DE in the _exception handler's_ MSR (the debug trap is
- * a critical exception, so we are using SPRN_CSRR1 to manipulate the MSR).
- * The exception handler was handling a non-critical interrupt, so it will
- * save (and later restore) the MSR via SPRN_SRR1, which will still have
- * the MSR_DE bit set.
- */
 	/* Debug Interrupt */
-	START_EXCEPTION(Debug)
-	CRITICAL_EXCEPTION_PROLOG
-
-	/*
-	 * If this is a single step or branch-taken exception in an
-	 * exception entry sequence, it was probably meant to apply to
-	 * the code where the exception occurred (since exception entry
-	 * doesn't turn off DE automatically).  We simulate the effect
-	 * of turning off DE on entry to an exception handler by turning
-	 * off DE in the CSRR1 value and clearing the debug status.
-	 */
-	mfspr	r10,SPRN_DBSR		/* check single-step/branch taken */
-	andis.	r10,r10,(DBSR_IC|DBSR_BT)@h
-	beq+	1f
-	andi.	r0,r9,MSR_PR		/* check supervisor */
-	beq	2f			/* branch if we need to fix it up... */
-
-	/* continue normal handling for a critical exception... */
-1:	mfspr	r4,SPRN_DBSR
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	EXC_XFER_TEMPLATE(DebugException, 0x2002, \
-		(MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), \
-		NOCOPY, crit_transfer_to_handler, ret_from_crit_exc)
-
-	/* here it looks like we got an inappropriate debug exception. */
-2:	rlwinm	r9,r9,0,~MSR_DE		/* clear DE in the CSRR1 value */
-	mtspr	SPRN_DBSR,r10		/* clear the IC/BT debug intr status */
-	/* restore state and get out */
-	lwz	r10,_CCR(r11)
-	lwz	r0,GPR0(r11)
-	lwz	r1,GPR1(r11)
-	mtcrf	0x80,r10
-	mtspr	CSRR0,r12
-	mtspr	CSRR1,r9
-	lwz	r9,GPR9(r11)
-
-	mtspr	SPRG2,r8;		/* SPRG2 only used in criticals */
-	lis	r8,crit_save@ha;
-	lwz	r10,crit_r10@l(r8)
-	lwz	r11,crit_r11@l(r8)
-	mfspr	r8,SPRG2
-
-	rfci
-	b	.
+	DEBUG_EXCEPTION
 
 /*
  * Local functions
diff -Nru a/arch/ppc/kernel/ppc-stub.c b/arch/ppc/kernel/ppc-stub.c
--- a/arch/ppc/kernel/ppc-stub.c	2004-10-29 17:13:29 -07:00
+++ b/arch/ppc/kernel/ppc-stub.c	2004-10-29 17:13:29 -07:00
@@ -498,7 +498,7 @@
 	unsigned int tt;		/* Trap type code for powerpc */
 	unsigned char signo;		/* Signal that we map this trap into */
 } hard_trap_info[] = {
-#if defined(CONFIG_40x)
+#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
 	{ 0x100, SIGINT  },		/* critical input interrupt */
 	{ 0x200, SIGSEGV },		/* machine check */
 	{ 0x300, SIGSEGV },		/* data storage */
@@ -521,7 +521,7 @@
 	** 0x1100  data TLB miss
 	** 0x1200  instruction TLB miss
 	*/
-	{ 0x2000, SIGTRAP},		/* debug */
+	{ 0x2002, SIGTRAP},		/* debug */
 #else
 	{ 0x200, SIGSEGV },		/* machine check */
 	{ 0x300, SIGSEGV },		/* address error (store) */
@@ -602,11 +602,6 @@
 	sigval = computeSignal(regs->trap);
 	ptr = remcomOutBuffer;
 
-#if defined(CONFIG_40x)
-	*ptr++ = 'S';
-	*ptr++ = hexchars[sigval >> 4];
-	*ptr++ = hexchars[sigval & 0xf];
-#else
 	*ptr++ = 'T';
 	*ptr++ = hexchars[sigval >> 4];
 	*ptr++ = hexchars[sigval & 0xf];
@@ -620,8 +615,6 @@
 	*ptr++ = ':';
 	ptr = mem2hex(((char *)regs) + SP_REGNUM*4, ptr, 4);
 	*ptr++ = ';';
-#endif
-
 	*ptr++ = 0;
 
 	putpacket(remcomOutBuffer);
@@ -774,10 +767,6 @@
  * some location may have changed something that is in the instruction cache.
  */
 			kgdb_flush_cache_all();
-#if defined(CONFIG_40x)
-			strcpy(remcomOutBuffer, "OK");
-			putpacket(remcomOutBuffer);
-#endif
 			mtmsr(msr);
 
 			kgdb_interruptible(1);
@@ -791,10 +780,9 @@
 
 		case 's':
 			kgdb_flush_cache_all();
-#if defined(CONFIG_40x)
+#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
+			mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) | DBCR0_IC);
 			regs->msr |= MSR_DE;
-			regs->dbcr0 |= (DBCR0_IDM | DBCR0_IC);
-			mtmsr(msr);
 #else
 			regs->msr |= MSR_SE;
 #endif
diff -Nru a/arch/ppc/kernel/ptrace.c b/arch/ppc/kernel/ptrace.c
--- a/arch/ppc/kernel/ptrace.c	2004-10-29 17:13:29 -07:00
+++ b/arch/ppc/kernel/ptrace.c	2004-10-29 17:13:29 -07:00
@@ -35,7 +35,7 @@
 /*
  * Set of msr bits that gdb can change on behalf of a process.
  */
-#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
+#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
 #define MSR_DEBUGCHANGE	0
 #else
 #define MSR_DEBUGCHANGE	(MSR_SE | MSR_BE)
@@ -201,9 +201,9 @@
 	struct pt_regs *regs = task->thread.regs;
 
 	if (regs != NULL) {
-#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
+#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
 		task->thread.dbcr0 = DBCR0_IDM | DBCR0_IC;
-		/* MSR.DE should already be set */
+		regs->msr |= MSR_DE;
 #else
 		regs->msr |= MSR_SE;
 #endif
@@ -216,8 +216,9 @@
 	struct pt_regs *regs = task->thread.regs;
 
 	if (regs != NULL) {
-#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
+#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
 		task->thread.dbcr0 = 0;
+		regs->msr &= ~MSR_DE;
 #else
 		regs->msr &= ~MSR_SE;
 #endif
diff -Nru a/arch/ppc/kernel/traps.c b/arch/ppc/kernel/traps.c
--- a/arch/ppc/kernel/traps.c	2004-10-29 17:13:29 -07:00
+++ b/arch/ppc/kernel/traps.c	2004-10-29 17:13:29 -07:00
@@ -647,22 +647,22 @@
 }
 #endif /* CONFIG_8xx */
 
-#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
+#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
 
 void DebugException(struct pt_regs *regs, unsigned long debug_status)
 {
-#if 0
-	if (debug_status & DBSR_TIE) {		/* trap instruction*/
-		if (!user_mode(regs) && debugger_bpt(regs))
-			return;
-		_exception(SIGTRAP, regs, 0, 0);
-
-	}
-#endif
 	if (debug_status & DBSR_IC) {	/* instruction completion */
-		if (!user_mode(regs) && debugger_sstep(regs))
-			return;
-		current->thread.dbcr0 &= ~DBCR0_IC;
+		regs->msr &= ~MSR_DE;
+		if (user_mode(regs)) {
+			current->thread.dbcr0 &= ~DBCR0_IC;
+		} else {
+			/* Disable instruction completion */
+			mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) & ~DBCR0_IC);
+			/* Clear the instruction completion event */
+			mtspr(SPRN_DBSR, DBSR_IC);
+			if (debugger_sstep(regs))
+				return;
+		}
 		_exception(SIGTRAP, regs, TRAP_TRACE, 0);
 	}
 }
diff -Nru a/include/asm-ppc/reg_booke.h b/include/asm-ppc/reg_booke.h
--- a/include/asm-ppc/reg_booke.h	2004-10-29 17:13:29 -07:00
+++ b/include/asm-ppc/reg_booke.h	2004-10-29 17:13:29 -07:00
@@ -63,9 +63,9 @@
 
 /* Default MSR for kernel mode. */
 #if defined (CONFIG_40x)
-#define MSR_KERNEL	(MSR_ME|MSR_RI|MSR_IR|MSR_DR|MSR_CE|MSR_DE)
+#define MSR_KERNEL	(MSR_ME|MSR_RI|MSR_IR|MSR_DR|MSR_CE)
 #elif defined(CONFIG_BOOKE)
-#define MSR_KERNEL	(MSR_ME|MSR_RI|MSR_CE|MSR_DE)
+#define MSR_KERNEL	(MSR_ME|MSR_RI|MSR_CE)
 #endif
 
 /* Special Purpose Registers (SPRNs)*/
