Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbUCRLA6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 06:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262502AbUCRLA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 06:00:58 -0500
Received: from ozlabs.org ([203.10.76.45]:24808 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261760AbUCRK7L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 05:59:11 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16473.33090.673344.320630@cargo.ozlabs.ibm.com>
Date: Thu, 18 Mar 2004 22:00:18 +1100
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix SLB reload bug
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, Linus,

Recently we found a particularly nasty bug in the segment handling in
the ppc64 kernel.  It would only happen rarely under heavy load, but
when it did the machine would lock up with the whole of memory filled
with exception stack frames.

The primary cause was that we were losing the translation for the
kernel stack from the SLB, but we still had it in the ERAT for a while
longer.  Now, there is a critical region in various exception exit
paths where we have loaded the SRR0 and SRR1 registers from GPRs and
we are loading those GPRs and the stack pointer from the exception
frame on the kernel stack.  If we lose the ERAT entry for the kernel
stack in that region, we take an SLB miss on the next access to the
kernel stack.  Taking the exception overwrites the values we have put
into SRR0 and SRR1, which means we lose state.  In fact we ended up
repeating that last section of the exception exit path, but using the
user stack pointer this time.  That caused another exception (or if it
didn't, we loaded a new value from the user stack and then went around
and tried to use that).  And it spiralled downwards from there.

The patch below fixes the primary problem by making sure that we
really never cast out the SLB entry for the kernel stack.  It also
improves debuggability in case anything like this happens again by:

- In our exception exit paths, we now check whether the RI bit in the
  SRR1 value is 0.  We already set the RI bit to 0 before starting the
  critical region, but we never checked it.  Now, if we do ever get an
  exception in one of the critical regions, we will detect it before
  returning to the critical region, and instead we will print a nasty
  message and oops.

- In the exception entry code, we now check that the kernel stack
  pointer value we're about to use isn't a userspace address.  If it
  is, we print a nasty message and oops.

Please apply.  This has been tested on G5 and pSeries (both with and
without hypervisor) and compile-tested on iSeries.

Thanks,
Paul.

diff -urN linux-2.5/arch/ppc64/kernel/entry.S slb-fix-2.5/arch/ppc64/kernel/entry.S
--- linux-2.5/arch/ppc64/kernel/entry.S	2004-03-11 11:33:37.000000000 +1100
+++ slb-fix-2.5/arch/ppc64/kernel/entry.S	2004-03-18 12:30:01.000000000 +1100
@@ -292,7 +292,24 @@
 	addi	r6,r4,-THREAD	/* Convert THREAD to 'current' */
 	std	r6,PACACURRENT(r13)	/* Set new 'current' */
 
-	ld	r1,KSP(r4)	/* Load new stack pointer */
+	ld	r8,KSP(r4)	/* new stack pointer */
+BEGIN_FTR_SECTION
+	clrrdi	r6,r8,28	/* get its ESID */
+	clrrdi	r9,r1,28	/* get current sp ESID */
+	clrldi.	r0,r6,2		/* is new ESID c00000000? */
+	cmpd	cr1,r6,r9	/* or is new ESID the same as current ESID? */
+	cror	eq,4*cr1+eq,eq
+	beq	2f		/* if yes, don't slbie it */
+	oris	r6,r6,0x0800	/* set C (class) bit */
+	slbie	r6
+2:
+END_FTR_SECTION_IFSET(CPU_FTR_SLB)
+	clrrdi	r7,r8,THREAD_SHIFT	/* base of new stack */
+	addi	r7,r7,THREAD_SIZE-INT_FRAME_SIZE
+
+	mr	r1,r8		/* start using new stack pointer */
+	std	r7,PACAKSAVE(r13)
+
 	ld	r6,_CCR(r1)
 	mtcrf	0xFF,r6
 
@@ -357,7 +374,6 @@
 	addi	r0,r1,INT_FRAME_SIZE	/* size of frame */
 	ld	r4,PACACURRENT(r13)
 	std	r0,THREAD+KSP(r4)	/* save kernel stack pointer */
-	std	r1,PACAKSAVE(r13)	/* save exception stack pointer */
 
 	/*
 	 * r13 is our per cpu area, only restore it if we are returning to
@@ -388,6 +404,10 @@
 4:	stb	r5,PACAPROCENABLED(r4)
 #endif
 
+	ld	r3,_MSR(r1)
+	andi.	r3,r3,MSR_RI
+	beq-	unrecov_restore
+
 	ld	r3,_CTR(r1)
 	ld	r0,_LINK(r1)
 	mtctr	r3
@@ -439,6 +459,11 @@
 	bl	.do_signal
 	b	.ret_from_except
 
+unrecov_restore:
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	.unrecoverable_exception
+	b	unrecov_restore
+
 #ifdef CONFIG_PPC_PSERIES
 /*
  * On CHRP, the Run-Time Abstraction Services (RTAS) have to be
diff -urN linux-2.5/arch/ppc64/kernel/head.S slb-fix-2.5/arch/ppc64/kernel/head.S
--- linux-2.5/arch/ppc64/kernel/head.S	2004-03-11 11:33:37.000000000 +1100
+++ slb-fix-2.5/arch/ppc64/kernel/head.S	2004-03-18 14:41:58.000000000 +1100
@@ -275,14 +275,15 @@
 	mfspr	r22,SPRG1;		/* Save r21 in exc. frame      */ \
 	std	r22,EX_R21(r21);	                                  \
 	std     r21,PACAEXCSP(r20);     /* update exception stack ptr  */ \
-		                        /*   iff no protection flt     */ \
 	ld	r22,EX_SRR1(r21);	/* Get SRR1 from exc. frame    */ \
 	andi.   r22,r22,MSR_PR;         /* Set CR for later branch     */ \
 	mr      r22,r1;                 /* Save r1                     */ \
 	subi    r1,r1,INT_FRAME_SIZE;   /* alloc frame on kernel stack */ \
 	beq-    1f;                                                       \
 	ld      r1,PACAKSAVE(r20);      /* kernel stack to use         */ \
-1:      std     r22,GPR1(r1);           /* save r1 in stackframe       */ \
+1:      cmpdi	cr1,r1,0;		/* check if r1 is in userspace */ \
+	bge	cr1,bad_stack;		/* abort if it is	       */ \
+	std     r22,GPR1(r1);           /* save r1 in stackframe       */ \
 	std     r22,0(r1);              /* make stack chain pointer    */ \
 	std     r23,_CCR(r1);           /* save CR in stackframe       */ \
 	ld	r22,EX_R20(r21);	/* move r20 to stackframe      */ \
@@ -610,12 +611,68 @@
 #else
 	STD_EXCEPTION_COMMON(0x1700, AltivecAssist, .UnknownException )
 #endif
+
+/*
+ * Here the exception frame is filled out and we have detected that
+ * the kernel stack pointer is bad.  R23 contains the saved CR, r20
+ * points to the paca, r21 points to the exception frame, and r22
+ * contains the (bad) kernel stack pointer.
+ * We switch to using the paca guard page as an emergency stack,
+ * save the registers on there, and call kernel_bad_stack(),
+ * which panics.
+ */
+bad_stack:
+	addi	r1,r20,8192-64-INT_FRAME_SIZE
+	std	r22,GPR1(r1)
+	std	r23,_CCR(r1)
+	ld	r22,EX_R20(r21)
+	std	r22,GPR20(r1)
+	ld	r23,EX_R21(r21)
+	std	r23,GPR21(r1)
+	ld	r22,EX_R22(r21)
+	std	r22,GPR22(r1)
+	ld	r23,EX_R23(r21)
+	std	r23,GPR23(r1)
+	ld	r23,EX_DAR(r21)
+	std	r23,_DAR(r1)
+	lwz     r22,EX_DSISR(r21)
+	std	r22,_DSISR(r1)
+	lwz	r23,EX_TRAP(r21)
+	std	r23,TRAP(r1)
+	ld	r22,EX_SRR0(r21)
+	ld	r23,EX_SRR1(r21)
+	std	r22,_NIP(r1)
+	std	r23,_MSR(r1)
+	addi	r21,r21,-EXC_FRAME_SIZE
+	std	r21,PACAEXCSP(r20)
+	mflr	r22
+	std	r22,_LINK(r1)
+	mfctr	r23
+	std	r23,_CTR(r1)
+	mfspr	r22,XER
+	std	r22,_XER(r1)
+	SAVE_GPR(0, r1)
+	SAVE_10GPRS(2, r1)
+	SAVE_8GPRS(12, r1)
+	SAVE_8GPRS(24, r1)
+	addi	r21,r1,INT_FRAME_SIZE
+	std	r21,0(r1)
+	li	r22,0
+	std	r22,0(r21)
+	ld	r2,PACATOC(r20)
+	mr	r13,r20
+1:	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	.kernel_bad_stack
+	b	1b
+
 /*
  * Return from an exception which is handled without calling
  * save_remaining_regs.  The caller is assumed to have done
  * EXCEPTION_PROLOG_COMMON.
  */
 fast_exception_return:
+	andi.	r3,r23,MSR_RI		/* check if RI is set */
+	beq-	unrecov_fer
 	ld      r3,_CCR(r1)
 	ld      r4,_LINK(r1)
 	ld      r5,_CTR(r1)
@@ -639,6 +696,14 @@
 	ld      r1,GPR1(r1)
 	rfid
 
+unrecov_fer:
+	li	r6,0x4000
+	li	r20,0
+	bl	.save_remaining_regs
+1:	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	.unrecoverable_exception
+	b	1b
+
 /*
  * Here r20 points to the PACA, r21 to the exception frame,
  * r23 contains the saved CR.
@@ -996,6 +1061,11 @@
 	ld      r21,PACAEXCSP(r20)      /* Get the exception frame pointer */
 	addi    r21,r21,EXC_FRAME_SIZE
 	lwz	r23,EX_CCR(r21)		/* get saved CR */
+
+	ld	r22,EX_SRR1(r21)
+	andi.	r22,r22,MSR_RI
+	beq-	unrecov_stab
+
 	/* note that this is almost identical to maskable_exception_exit */
 	mtcr    r23                     /* restore CR */
 
@@ -1014,6 +1084,15 @@
 	mfspr	r21,SPRG1
 	rfid
 
+unrecov_stab:
+	EXCEPTION_PROLOG_COMMON
+	li	r6,0x4100
+	li	r20,0
+	bl	.save_remaining_regs
+1:	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	.unrecoverable_exception
+	b	1b
+
 /*
  * r20 points to the PACA, r21 to the exception frame,
  * r23 contains the saved CR.
@@ -1052,15 +1131,23 @@
 	slbmfee	r21,r22
 	srdi	r21,r21,27
 	/*
-	 * This is incorrect (r1 is not the kernel stack) if we entered
-	 * from userspace but there is no critical window from userspace
-	 * so this should be OK. Also if we cast out the userspace stack
-	 * segment while in userspace we will fault it straight back in.
+	 * Use paca->ksave as the value of the kernel stack pointer,
+	 * because this is valid at all times.
+	 * The >> 27 (rather than >> 28) is so that the LSB is the
+	 * valid bit - this way we check valid and ESID in one compare.
+	 * In order to completely close the tiny race in the context
+	 * switch (between updating r1 and updating paca->ksave),
+	 * we check against both r1 and paca->ksave.
 	 */
 	srdi	r23,r1,27
 	ori	r23,r23,1
 	cmpd	r23,r21
 	beq-	1b
+	ld	r23,PACAKSAVE(r20)
+	srdi	r23,r23,27
+ 	ori	r23,r23,1
+ 	cmpd	r23,r21
+ 	beq-	1b
 
 	/* r20 = paca, r22 = entry */
 
@@ -1117,6 +1204,10 @@
 	lwz	r23,EX_CCR(r21)		/* get saved CR */
 	/* note that this is almost identical to maskable_exception_exit */
 
+	ld	r22,EX_SRR1(r21)
+	andi.	r22,r22,MSR_RI
+	beq-	unrecov_stab
+
 	/*
 	 * Until everyone updates binutils hardwire the POWER4 optimised
 	 * single field mtcrf
@@ -1190,9 +1281,8 @@
 
 	/*
 	 * Indicate that r1 contains the kernel stack and
-	 * get the Kernel TOC and CURRENT pointers from the paca
+	 * get the Kernel TOC pointer from the paca
 	 */
-	std	r22,PACAKSAVE(r13)	/* r1 is now kernel sp */
 	ld	r2,PACATOC(r13)		/* Get Kernel TOC pointer */
 
 	/*
@@ -1764,7 +1854,6 @@
 
 	std	r2,PACATOC(r13)
 	li	r6,0
-	std	r6,PACAKSAVE(r13)
 	stb	r6,PACAPROCENABLED(r13)
 
 #ifndef CONFIG_PPC_ISERIES
@@ -1783,6 +1872,7 @@
 	ldx	r1,r3,r28
 	addi	r1,r1,THREAD_SIZE
 	subi	r1,r1,STACK_FRAME_OVERHEAD
+	std	r1,PACAKSAVE(r13)
 
 	ld	r3,PACASTABREAL(r13)    /* get raddr of segment table       */
 	ori	r4,r3,1			/* turn on valid bit                */
@@ -2055,7 +2145,7 @@
 
 	std	r2,PACATOC(r13)
 	li	r5,0
-	std	r0,PACAKSAVE(r13)
+	std	r1,PACAKSAVE(r13)
 
 	/* Restore the parms passed in from the bootloader. */
 	mr	r3,r31
diff -urN linux-2.5/arch/ppc64/kernel/process.c slb-fix-2.5/arch/ppc64/kernel/process.c
--- linux-2.5/arch/ppc64/kernel/process.c	2004-03-17 22:09:23.000000000 +1100
+++ slb-fix-2.5/arch/ppc64/kernel/process.c	2004-03-18 12:49:57.000000000 +1100
@@ -161,28 +161,6 @@
 	local_irq_save(flags);
 	last = _switch(old_thread, new_thread);
 
-	/*
-	 * force our kernel stack out of the ERAT and SLB, this is to
-	 * avoid the race where we it hangs around in the ERAT but not the
-	 * SLB and the ERAT gets invalidated at just the wrong moment by
-	 * another CPU doing a tlbie.
-	 *
-	 * We definitely dont want to flush our bolted segment, so check
-	 * for that first.
-	 */
-	if ((cur_cpu_spec->cpu_features & CPU_FTR_SLB) &&
-	    GET_ESID(__get_SP()) != GET_ESID(PAGE_OFFSET)) {
-		union {
-			unsigned long word0;
-			slb_dword0 data;
-		} esid_data;
-
-		esid_data.word0 = 0;
-		/* class bit is in valid field for slbie instruction */
-		esid_data.data.v = 1;
-		esid_data.data.esid = GET_ESID(__get_SP());
-		asm volatile("isync; slbie %0; isync" : : "r" (esid_data));
-	}
 	local_irq_restore(flags);
 
 	return last;
diff -urN linux-2.5/arch/ppc64/kernel/traps.c slb-fix-2.5/arch/ppc64/kernel/traps.c
--- linux-2.5/arch/ppc64/kernel/traps.c	2004-02-25 18:39:38.000000000 +1100
+++ slb-fix-2.5/arch/ppc64/kernel/traps.c	2004-03-18 14:28:35.000000000 +1100
@@ -511,6 +511,32 @@
 }
 #endif /* CONFIG_ALTIVEC */
 
+/*
+ * We enter here if we get an unrecoverable exception, that is, one
+ * that happened at a point where the RI (recoverable interrupt) bit
+ * in the MSR is 0.  This indicates that SRR0/1 are live, and that
+ * we therefore lost state by taking this exception.
+ */
+void unrecoverable_exception(struct pt_regs *regs)
+{
+	printk(KERN_EMERG "Unrecoverable exception %lx at %lx\n",
+	       regs->trap, regs->nip);
+	debugger(regs);
+	die("Unrecoverable exception", regs, SIGABRT);
+}
+
+/*
+ * We enter here if we discover during exception entry that we are
+ * running in supervisor mode with a userspace value in the stack pointer.
+ */
+void kernel_bad_stack(struct pt_regs *regs)
+{
+	printk(KERN_EMERG "Bad kernel stack pointer %lx at %lx\n",
+	       regs->gpr[1], regs->nip);
+	debugger(regs);
+	die("Bad kernel stack pointer", regs, SIGABRT);
+}
+
 void __init trap_init(void)
 {
 }
