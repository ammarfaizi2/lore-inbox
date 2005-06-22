Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262245AbVFVUvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262245AbVFVUvm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 16:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262146AbVFVUtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 16:49:35 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:36085 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S262161AbVFVUlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 16:41:15 -0400
Date: Wed, 22 Jun 2005 15:41:09 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
       kim.phillips@freescale.com
Subject: [PATCH] ppc32: Add support for Freescale e200 (Book-E) core
Message-ID: <Pine.LNX.4.61.0506221539470.3206@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The e200 core is a Book-E core (similar to e500) that has a unified L1
cache and is not cache coherent on the bus.  The e200 core also adds a
separate exception level for debug exceptions.  Part of this patch helps 
to cleanup a few cases that are true for all Freescale Book-E parts, not 
just e500.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 575a595c982d029b2921675c6344aa6b2295d058
tree cd6ba641e4d6b038bce0636c2d96f0117b522c8f
parent 2a5a68b840cbab31baab2d9b2e1e6de3b289ae1e
author Kumar K. Gala <kumar.gala@freescale.com> Wed, 22 Jun 2005 11:29:28 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Wed, 22 Jun 2005 11:29:28 -0500

 arch/ppc/Kconfig                 |   17 ++++++----
 arch/ppc/Makefile                |    3 +-
 arch/ppc/kernel/Makefile         |    2 +
 arch/ppc/kernel/cputable.c       |   25 ++++++++++++++-
 arch/ppc/kernel/entry.S          |    9 +++++
 arch/ppc/kernel/head_booke.h     |   64 +++++++++++++++++++++++++++++++++++++-
 arch/ppc/kernel/head_fsl_booke.S |   51 ++++++++++++++++++++++++++++++
 arch/ppc/kernel/misc.S           |    8 +++++
 arch/ppc/kernel/perfmon.c        |    2 +
 arch/ppc/kernel/traps.c          |   24 ++++++++++++--
 arch/ppc/mm/fsl_booke_mmu.c      |    2 +
 include/asm-ppc/mmu.h            |    2 +
 include/asm-ppc/mmu_context.h    |    2 +
 include/asm-ppc/ppc_asm.h        |    2 +
 include/asm-ppc/reg.h            |    1 +
 include/asm-ppc/reg_booke.h      |   18 ++++++++++-
 16 files changed, 214 insertions(+), 18 deletions(-)

diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -88,6 +88,9 @@ config 8xx
 	depends on BROKEN
 	bool "8xx"
 
+config E200
+	bool "e200"
+
 config E500
 	bool "e500"
 
@@ -98,12 +101,12 @@ config PPC_FPU
 
 config BOOKE
 	bool
-	depends on E500
+	depends on E200 || E500
 	default y
 
 config FSL_BOOKE
 	bool
-	depends on E500
+	depends on E200 || E500
 	default y
 
 config PTE_64BIT
@@ -141,16 +144,16 @@ config ALTIVEC
 
 config SPE
 	bool "SPE Support"
-	depends on E500
+	depends on E200 || E500
 	---help---
 	  This option enables kernel support for the Signal Processing
 	  Extensions (SPE) to the PowerPC processor. The kernel currently
 	  supports saving and restoring SPE registers, and turning on the
 	  'spe enable' bit so user processes can execute SPE instructions.
 
-	  This option is only usefully if you have a processor that supports
+	  This option is only useful if you have a processor that supports
 	  SPE (e500, otherwise known as 85xx series), but does not have any
-	  affect on a non-spe cpu (it does, however add code to the kernel).
+	  effect on a non-spe cpu (it does, however add code to the kernel).
 
 	  If in doubt, say Y here.
 
@@ -200,7 +203,7 @@ config TAU_AVERAGE
 
 config MATH_EMULATION
 	bool "Math emulation"
-	depends on 4xx || 8xx || E500
+	depends on 4xx || 8xx || E200 || E500
 	---help---
 	  Some PowerPC chips designed for embedded applications do not have
 	  a floating-point unit and therefore do not implement the
@@ -254,7 +257,7 @@ config PPC_STD_MMU
 
 config NOT_COHERENT_CACHE
 	bool
-	depends on 4xx || 8xx
+	depends on 4xx || 8xx || E200
 	default y
 
 endmenu
diff --git a/arch/ppc/Makefile b/arch/ppc/Makefile
--- a/arch/ppc/Makefile
+++ b/arch/ppc/Makefile
@@ -29,7 +29,7 @@ CPP		= $(CC) -E $(CFLAGS)
 
 CHECKFLAGS	+= -D__powerpc__
 
-ifndef CONFIG_E500
+ifndef CONFIG_FSL_BOOKE
 CFLAGS		+= -mstring
 endif
 
@@ -38,6 +38,7 @@ cpu-as-$(CONFIG_4xx)		+= -Wa,-m405
 cpu-as-$(CONFIG_6xx)		+= -Wa,-maltivec
 cpu-as-$(CONFIG_POWER4)		+= -Wa,-maltivec
 cpu-as-$(CONFIG_E500)		+= -Wa,-me500
+cpu-as-$(CONFIG_E200)		+= -Wa,-me200
 
 AFLAGS += $(cpu-as-y)
 CFLAGS += $(cpu-as-y)
diff --git a/arch/ppc/kernel/Makefile b/arch/ppc/kernel/Makefile
--- a/arch/ppc/kernel/Makefile
+++ b/arch/ppc/kernel/Makefile
@@ -26,7 +26,9 @@ obj-$(CONFIG_KGDB)		+= ppc-stub.o
 obj-$(CONFIG_SMP)		+= smp.o smp-tbsync.o
 obj-$(CONFIG_TAU)		+= temp.o
 obj-$(CONFIG_ALTIVEC)		+= vecemu.o vector.o
+ifndef CONFIG_E200
 obj-$(CONFIG_FSL_BOOKE)		+= perfmon_fsl_booke.o
+endif
 
 ifndef CONFIG_MATH_EMULATION
 obj-$(CONFIG_8xx)		+= softemu8xx.o
diff --git a/arch/ppc/kernel/cputable.c b/arch/ppc/kernel/cputable.c
--- a/arch/ppc/kernel/cputable.c
+++ b/arch/ppc/kernel/cputable.c
@@ -903,7 +903,30 @@ struct cpu_spec	cpu_specs[] = {
 		.dcache_bsize		= 32,
 	},
 #endif /* CONFIG_44x */
-#ifdef CONFIG_E500
+#ifdef CONFIG_FSL_BOOKE
+	{ 	/* e200z5 */
+		.pvr_mask		= 0xfff00000,
+		.pvr_value		= 0x81000000,
+		.cpu_name		= "e200z5",
+		/* xxx - galak: add CPU_FTR_MAYBE_CAN_DOZE */
+		.cpu_features		= CPU_FTR_USE_TB,
+		.cpu_user_features	= PPC_FEATURE_32 |
+			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_EFP_SINGLE |
+			PPC_FEATURE_UNIFIED_CACHE,
+		.dcache_bsize		= 32,
+	},
+	{ 	/* e200z6 */
+		.pvr_mask		= 0xfff00000,
+		.pvr_value		= 0x81100000,
+		.cpu_name		= "e200z6",
+		/* xxx - galak: add CPU_FTR_MAYBE_CAN_DOZE */
+		.cpu_features		= CPU_FTR_USE_TB,
+		.cpu_user_features	= PPC_FEATURE_32 |
+			PPC_FEATURE_HAS_MMU | PPC_FEATURE_SPE_COMP |
+			PPC_FEATURE_HAS_EFP_SINGLE |
+			PPC_FEATURE_UNIFIED_CACHE,
+		.dcache_bsize		= 32,
+	},
 	{ 	/* e500 */
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x80200000,
diff --git a/arch/ppc/kernel/entry.S b/arch/ppc/kernel/entry.S
--- a/arch/ppc/kernel/entry.S
+++ b/arch/ppc/kernel/entry.S
@@ -60,6 +60,11 @@ mcheck_transfer_to_handler:
 	TRANSFER_TO_HANDLER_EXC_LEVEL(MCHECK)
 	b	transfer_to_handler_full
 
+	.globl	debug_transfer_to_handler
+debug_transfer_to_handler:
+	TRANSFER_TO_HANDLER_EXC_LEVEL(DEBUG)
+	b	transfer_to_handler_full
+
 	.globl	crit_transfer_to_handler
 crit_transfer_to_handler:
 	TRANSFER_TO_HANDLER_EXC_LEVEL(CRIT)
@@ -835,6 +840,10 @@ ret_from_crit_exc:
 	RET_FROM_EXC_LEVEL(SPRN_CSRR0, SPRN_CSRR1, RFCI)
 
 #ifdef CONFIG_BOOKE
+	.globl	ret_from_debug_exc
+ret_from_debug_exc:
+	RET_FROM_EXC_LEVEL(SPRN_DSRR0, SPRN_DSRR1, RFDI)
+
 	.globl	ret_from_mcheck_exc
 ret_from_mcheck_exc:
 	RET_FROM_EXC_LEVEL(SPRN_MCSRR0, SPRN_MCSRR1, RFMCI)
diff --git a/arch/ppc/kernel/head_booke.h b/arch/ppc/kernel/head_booke.h
--- a/arch/ppc/kernel/head_booke.h
+++ b/arch/ppc/kernel/head_booke.h
@@ -49,6 +49,7 @@
  *
  * On 40x critical is the only additional level
  * On 44x/e500 we have critical and machine check
+ * On e200 we have critical and debug (machine check occurs via critical)
  *
  * Additionally we reserve a SPRG for each priority level so we can free up a
  * GPR to use as the base for indirect access to the exception stacks.  This
@@ -60,12 +61,16 @@
 
 /* CRIT_SPRG only used in critical exception handling */
 #define CRIT_SPRG	SPRN_SPRG2
-/* MCHECK_SPRG only used in critical exception handling */
+/* MCHECK_SPRG only used in machine check exception handling */
 #define MCHECK_SPRG	SPRN_SPRG6W
 
 #define MCHECK_STACK_TOP	(exception_stack_top - 4096)
 #define CRIT_STACK_TOP		(exception_stack_top)
 
+/* only on e200 for now */
+#define DEBUG_STACK_TOP		(exception_stack_top - 4096)
+#define DEBUG_SPRG		SPRN_SPRG6W
+
 #ifdef CONFIG_SMP
 #define BOOKE_LOAD_EXC_LEVEL_STACK(level)		\
 	mfspr	r8,SPRN_PIR;				\
@@ -124,6 +129,8 @@
 
 #define CRITICAL_EXCEPTION_PROLOG \
 		EXC_LEVEL_EXCEPTION_PROLOG(CRIT, SPRN_CSRR0, SPRN_CSRR1)
+#define DEBUG_EXCEPTION_PROLOG \
+		EXC_LEVEL_EXCEPTION_PROLOG(DEBUG, SPRN_DSRR0, SPRN_DSRR1)
 #define MCHECK_EXCEPTION_PROLOG \
 		EXC_LEVEL_EXCEPTION_PROLOG(MCHECK, SPRN_MCSRR0, SPRN_MCSRR1)
 
@@ -205,6 +212,60 @@ label:
  * save (and later restore) the MSR via SPRN_CSRR1, which will still have
  * the MSR_DE bit set.
  */
+#ifdef CONFIG_E200
+#define DEBUG_EXCEPTION							      \
+	START_EXCEPTION(Debug);						      \
+	DEBUG_EXCEPTION_PROLOG;						      \
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
+1:	rlwinm	r9,r9,0,~MSR_DE;	/* clear DE in the CDRR1 value */     \
+	lis	r10,DBSR_IC@h;		/* clear the IC event */	      \
+	mtspr	SPRN_DBSR,r10;						      \
+	/* restore state and get out */					      \
+	lwz	r10,_CCR(r11);						      \
+	lwz	r0,GPR0(r11);						      \
+	lwz	r1,GPR1(r11);						      \
+	mtcrf	0x80,r10;						      \
+	mtspr	SPRN_DSRR0,r12;						      \
+	mtspr	SPRN_DSRR1,r9;						      \
+	lwz	r9,GPR9(r11);						      \
+	lwz	r12,GPR12(r11);						      \
+	mtspr	DEBUG_SPRG,r8;						      \
+	BOOKE_LOAD_EXC_LEVEL_STACK(DEBUG); /* r8 points to the debug stack */ \
+	lwz	r10,GPR10-INT_FRAME_SIZE(r8);				      \
+	lwz	r11,GPR11-INT_FRAME_SIZE(r8);				      \
+	mfspr	r8,DEBUG_SPRG;						      \
+									      \
+	RFDI;								      \
+	b	.;							      \
+									      \
+	/* continue normal handling for a critical exception... */	      \
+2:	mfspr	r4,SPRN_DBSR;						      \
+	addi	r3,r1,STACK_FRAME_OVERHEAD;				      \
+	EXC_XFER_TEMPLATE(DebugException, 0x2002, (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), NOCOPY, debug_transfer_to_handler, ret_from_debug_exc)
+#else
 #define DEBUG_EXCEPTION							      \
 	START_EXCEPTION(Debug);						      \
 	CRITICAL_EXCEPTION_PROLOG;					      \
@@ -257,6 +318,7 @@ label:
 2:	mfspr	r4,SPRN_DBSR;						      \
 	addi	r3,r1,STACK_FRAME_OVERHEAD;				      \
 	EXC_XFER_TEMPLATE(DebugException, 0x2002, (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), NOCOPY, crit_transfer_to_handler, ret_from_crit_exc)
+#endif
 
 #define INSTRUCTION_STORAGE_EXCEPTION					      \
 	START_EXCEPTION(InstructionStorage)				      \
diff --git a/arch/ppc/kernel/head_fsl_booke.S b/arch/ppc/kernel/head_fsl_booke.S
--- a/arch/ppc/kernel/head_fsl_booke.S
+++ b/arch/ppc/kernel/head_fsl_booke.S
@@ -102,6 +102,7 @@ invstr:	mflr	r6				/* Make it accessible
 	or	r7,r7,r4
 	mtspr	SPRN_MAS6,r7
 	tlbsx	0,r6				/* search MSR[IS], SPID=PID0 */
+#ifndef CONFIG_E200
 	mfspr	r7,SPRN_MAS1
 	andis.	r7,r7,MAS1_VALID@h
 	bne	match_TLB
@@ -118,6 +119,7 @@ invstr:	mflr	r6				/* Make it accessible
 	or	r7,r7,r4
 	mtspr	SPRN_MAS6,r7
 	tlbsx	0,r6				/* Fall through, we had to match */
+#endif
 match_TLB:
 	mfspr	r7,SPRN_MAS0
 	rlwinm	r3,r7,16,20,31			/* Extract MAS0(Entry) */
@@ -196,8 +198,10 @@ skpinv:	addi	r6,r6,1				/* Increment */
 /* 4. Clear out PIDs & Search info */
 	li	r6,0
 	mtspr	SPRN_PID0,r6
+#ifndef CONFIG_E200
 	mtspr	SPRN_PID1,r6
 	mtspr	SPRN_PID2,r6
+#endif
 	mtspr	SPRN_MAS6,r6
 
 /* 5. Invalidate mapping we started in */
@@ -277,7 +281,9 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	SET_IVOR(32, SPEUnavailable);
 	SET_IVOR(33, SPEFloatingPointData);
 	SET_IVOR(34, SPEFloatingPointRound);
+#ifndef CONFIG_E200
 	SET_IVOR(35, PerformanceMonitor);
+#endif
 
 	/* Establish the interrupt vector base */
 	lis	r4,interrupt_base@h	/* IVPR only uses the high 16-bits */
@@ -285,6 +291,9 @@ skpinv:	addi	r6,r6,1				/* Increment */
 
 	/* Setup the defaults for TLB entries */
 	li	r2,(MAS4_TSIZED(BOOKE_PAGESZ_4K))@l
+#ifdef CONFIG_E200
+	oris	r2,r2,MAS4_TLBSELD(1)@h
+#endif
    	mtspr	SPRN_MAS4, r2
 
 #if 0
@@ -293,6 +302,12 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	oris	r2,r2,HID0_DOZE@h
 	mtspr	SPRN_HID0, r2
 #endif
+#ifdef CONFIG_E200
+	/* enable dedicated debug exception handling resources (Debug APU) */
+	mfspr	r2,SPRN_HID0
+	ori 	r2,r2,HID0_DAPUEN@l
+	mtspr	SPRN_HID0,r2
+#endif
 
 #if !defined(CONFIG_BDI_SWITCH)
 	/*
@@ -414,7 +429,12 @@ interrupt_base:
 	CRITICAL_EXCEPTION(0x0100, CriticalInput, UnknownException)
 
 	/* Machine Check Interrupt */
+#ifdef CONFIG_E200
+	/* no RFMCI, MCSRRs on E200 */
+	CRITICAL_EXCEPTION(0x0200, MachineCheck, MachineCheckException)
+#else
 	MCHECK_EXCEPTION(0x0200, MachineCheck, MachineCheckException)
+#endif
 
 	/* Data Storage Interrupt */
 	START_EXCEPTION(DataStorage)
@@ -520,8 +540,13 @@ interrupt_base:
 #ifdef CONFIG_PPC_FPU
 	FP_UNAVAILABLE_EXCEPTION
 #else
+#ifdef CONFIG_E200
+	/* E200 treats 'normal' floating point instructions as FP Unavail exception */
+	EXCEPTION(0x0800, FloatingPointUnavailable, ProgramCheckException, EXC_XFER_EE)
+#else
 	EXCEPTION(0x0800, FloatingPointUnavailable, UnknownException, EXC_XFER_EE)
 #endif
+#endif
 
 	/* System Call Interrupt */
 	START_EXCEPTION(SystemCall)
@@ -691,6 +716,7 @@ interrupt_base:
 /*
  * Local functions
  */
+
 	/*
 	 * Data TLB exceptions will bail out to this point
 	 * if they can't resolve the lightweight TLB fault.
@@ -761,6 +787,31 @@ END_FTR_SECTION_IFSET(CPU_FTR_BIG_PHYS)
 2:	rlwimi	r11, r12, 0, 20, 31	/* Extract RPN from PTE and merge with perms */
 	mtspr	SPRN_MAS3, r11
 #endif
+#ifdef CONFIG_E200
+	/* Round robin TLB1 entries assignment */
+	mfspr	r12, SPRN_MAS0
+
+	/* Extract TLB1CFG(NENTRY) */
+	mfspr	r11, SPRN_TLB1CFG
+	andi.	r11, r11, 0xfff
+
+	/* Extract MAS0(NV) */
+	andi.	r13, r12, 0xfff
+	addi	r13, r13, 1
+	cmpw	0, r13, r11
+	addi	r12, r12, 1
+
+	/* check if we need to wrap */
+	blt	7f
+
+	/* wrap back to first free tlbcam entry */
+	lis	r13, tlbcam_index@ha
+	lwz	r13, tlbcam_index@l(r13)
+	rlwimi	r12, r13, 0, 20, 31
+7:
+	mtspr   SPRN_MAS0,r12
+#endif /* CONFIG_E200 */
+
 	tlbwe
 
 	/* Done...restore registers and get out of here.  */
diff --git a/arch/ppc/kernel/misc.S b/arch/ppc/kernel/misc.S
--- a/arch/ppc/kernel/misc.S
+++ b/arch/ppc/kernel/misc.S
@@ -593,6 +593,14 @@ _GLOBAL(flush_instruction_cache)
 	iccci	0,r3
 #endif
 #elif CONFIG_FSL_BOOKE
+BEGIN_FTR_SECTION
+	mfspr   r3,SPRN_L1CSR0
+	ori     r3,r3,L1CSR0_CFI|L1CSR0_CLFC
+	/* msync; isync recommended here */
+	mtspr   SPRN_L1CSR0,r3
+	isync
+	blr
+END_FTR_SECTION_IFCLR(CPU_FTR_SPLIT_ID_CACHE)
 	mfspr	r3,SPRN_L1CSR1
 	ori	r3,r3,L1CSR1_ICFI|L1CSR1_ICLFR
 	mtspr	SPRN_L1CSR1,r3
diff --git a/arch/ppc/kernel/perfmon.c b/arch/ppc/kernel/perfmon.c
--- a/arch/ppc/kernel/perfmon.c
+++ b/arch/ppc/kernel/perfmon.c
@@ -36,7 +36,7 @@
 /* A lock to regulate grabbing the interrupt */
 DEFINE_SPINLOCK(perfmon_lock);
 
-#ifdef CONFIG_FSL_BOOKE
+#if defined (CONFIG_FSL_BOOKE) && !defined (CONFIG_E200)
 static void dummy_perf(struct pt_regs *regs)
 {
 	unsigned int pmgc0 = mfpmr(PMRN_PMGC0);
diff --git a/arch/ppc/kernel/traps.c b/arch/ppc/kernel/traps.c
--- a/arch/ppc/kernel/traps.c
+++ b/arch/ppc/kernel/traps.c
@@ -173,13 +173,13 @@ static inline int check_io_access(struct
 /* On 4xx, the reason for the machine check or program exception
    is in the ESR. */
 #define get_reason(regs)	((regs)->dsisr)
-#ifndef CONFIG_E500
+#ifndef CONFIG_FSL_BOOKE
 #define get_mc_reason(regs)	((regs)->dsisr)
 #else
 #define get_mc_reason(regs)	(mfspr(SPRN_MCSR))
 #endif
 #define REASON_FP		ESR_FP
-#define REASON_ILLEGAL		ESR_PIL
+#define REASON_ILLEGAL		(ESR_PIL | ESR_PUO)
 #define REASON_PRIVILEGED	ESR_PPR
 #define REASON_TRAP		ESR_PTR
 
@@ -302,7 +302,25 @@ void MachineCheckException(struct pt_reg
 		printk("Bus - Instruction Parity Error\n");
 	if (reason & MCSR_BUS_RPERR)
 		printk("Bus - Read Parity Error\n");
-#else /* !CONFIG_4xx && !CONFIG_E500 */
+#elif defined (CONFIG_E200)
+	printk("Machine check in kernel mode.\n");
+	printk("Caused by (from MCSR=%lx): ", reason);
+
+	if (reason & MCSR_MCP)
+		printk("Machine Check Signal\n");
+	if (reason & MCSR_CP_PERR)
+		printk("Cache Push Parity Error\n");
+	if (reason & MCSR_CPERR)
+		printk("Cache Parity Error\n");
+	if (reason & MCSR_EXCP_ERR)
+		printk("ISI, ITLB, or Bus Error on first instruction fetch for an exception handler\n");
+	if (reason & MCSR_BUS_IRERR)
+		printk("Bus - Read Bus Error on instruction fetch\n");
+	if (reason & MCSR_BUS_DRERR)
+		printk("Bus - Read Bus Error on data load\n");
+	if (reason & MCSR_BUS_WRERR)
+		printk("Bus - Write Bus Error on buffered store or cache line push\n");
+#else /* !CONFIG_4xx && !CONFIG_E500 && !CONFIG_E200 */
 	printk("Machine check in kernel mode.\n");
 	printk("Caused by (from SRR1=%lx): ", reason);
 	switch (reason & 0x601F0000) {
diff --git a/arch/ppc/mm/fsl_booke_mmu.c b/arch/ppc/mm/fsl_booke_mmu.c
--- a/arch/ppc/mm/fsl_booke_mmu.c
+++ b/arch/ppc/mm/fsl_booke_mmu.c
@@ -126,7 +126,7 @@ void settlbcam(int index, unsigned long 
 		flags |= _PAGE_COHERENT;
 #endif
 
-	TLBCAM[index].MAS0 = MAS0_TLBSEL(1) | MAS0_ESEL(index);
+	TLBCAM[index].MAS0 = MAS0_TLBSEL(1) | MAS0_ESEL(index) | MAS0_NV(index+1);
 	TLBCAM[index].MAS1 = MAS1_VALID | MAS1_IPROT | MAS1_TSIZE(tsize) | MAS1_TID(pid);
 	TLBCAM[index].MAS2 = virt & PAGE_MASK;
 
diff --git a/include/asm-ppc/mmu.h b/include/asm-ppc/mmu.h
--- a/include/asm-ppc/mmu.h
+++ b/include/asm-ppc/mmu.h
@@ -405,7 +405,7 @@ typedef struct _P601_BAT {
 
 #define MAS0_TLBSEL(x)	((x << 28) & 0x30000000)
 #define MAS0_ESEL(x)	((x << 16) & 0x0FFF0000)
-#define MAS0_NV		0x00000FFF
+#define MAS0_NV(x)	((x) & 0x00000FFF)
 
 #define MAS1_VALID 	0x80000000
 #define MAS1_IPROT	0x40000000
diff --git a/include/asm-ppc/mmu_context.h b/include/asm-ppc/mmu_context.h
--- a/include/asm-ppc/mmu_context.h
+++ b/include/asm-ppc/mmu_context.h
@@ -63,7 +63,7 @@ static inline void enter_lazy_tlb(struct
 #define LAST_CONTEXT    	255
 #define FIRST_CONTEXT    	1
 
-#elif defined(CONFIG_E500)
+#elif defined(CONFIG_E200) || defined(CONFIG_E500)
 #define NO_CONTEXT      	256
 #define LAST_CONTEXT    	255
 #define FIRST_CONTEXT    	1
diff --git a/include/asm-ppc/ppc_asm.h b/include/asm-ppc/ppc_asm.h
--- a/include/asm-ppc/ppc_asm.h
+++ b/include/asm-ppc/ppc_asm.h
@@ -174,6 +174,8 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
 #define CLR_TOP32(r)
 #endif /* CONFIG_PPC64BRIDGE */
 
+#define RFCI		.long 0x4c000066	/* rfci instruction */
+#define RFDI		.long 0x4c00004e	/* rfdi instruction */
 #define RFMCI		.long 0x4c00004c	/* rfmci instruction */
 
 #ifdef CONFIG_IBM405_ERR77
diff --git a/include/asm-ppc/reg.h b/include/asm-ppc/reg.h
--- a/include/asm-ppc/reg.h
+++ b/include/asm-ppc/reg.h
@@ -160,6 +160,7 @@
 #define HID0_ICFI	(1<<11)		/* Instr. Cache Flash Invalidate */
 #define HID0_DCI	(1<<10)		/* Data Cache Invalidate */
 #define HID0_SPD	(1<<9)		/* Speculative disable */
+#define HID0_DAPUEN	(1<<8)		/* Debug APU enable */
 #define HID0_SGE	(1<<7)		/* Store Gathering Enable */
 #define HID0_SIED	(1<<7)		/* Serial Instr. Execution [Disable] */
 #define HID0_DFCA	(1<<6)		/* Data Cache Flush Assist */
diff --git a/include/asm-ppc/reg_booke.h b/include/asm-ppc/reg_booke.h
--- a/include/asm-ppc/reg_booke.h
+++ b/include/asm-ppc/reg_booke.h
@@ -165,6 +165,8 @@ do {						\
 #define SPRN_MCSRR1	0x23B	/* Machine Check Save and Restore Register 1 */
 #define SPRN_MCSR	0x23C	/* Machine Check Status Register */
 #define SPRN_MCAR	0x23D	/* Machine Check Address Register */
+#define SPRN_DSRR0	0x23E	/* Debug Save and Restore Register 0 */
+#define SPRN_DSRR1	0x23F	/* Debug Save and Restore Register 1 */
 #define SPRN_MAS0	0x270	/* MMU Assist Register 0 */
 #define SPRN_MAS1	0x271	/* MMU Assist Register 1 */
 #define SPRN_MAS2	0x272	/* MMU Assist Register 2 */
@@ -264,6 +266,17 @@ do {						\
 #define MCSR_BUS_IPERR 	0x00000002UL /* Instruction parity Error */
 #define MCSR_BUS_RPERR 	0x00000001UL /* Read parity Error */
 #endif
+#ifdef CONFIG_E200
+#define MCSR_MCP 	0x80000000UL /* Machine Check Input Pin */
+#define MCSR_CP_PERR 	0x20000000UL /* Cache Push Parity Error */
+#define MCSR_CPERR 	0x10000000UL /* Cache Parity Error */
+#define MCSR_EXCP_ERR 	0x08000000UL /* ISI, ITLB, or Bus Error on 1st insn
+					fetch for an exception handler */
+#define MCSR_BUS_IRERR 	0x00000010UL /* Read Bus Error on instruction fetch*/
+#define MCSR_BUS_DRERR 	0x00000008UL /* Read Bus Error on data load */
+#define MCSR_BUS_WRERR 	0x00000004UL /* Write Bus Error on buffered
+					store or cache line push */
+#endif
 
 /* Bit definitions for the DBSR. */
 /*
@@ -311,6 +324,7 @@ do {						\
 #define ESR_ST		0x00800000	/* Store Operation */
 #define ESR_DLK		0x00200000	/* Data Cache Locking */
 #define ESR_ILK		0x00100000	/* Instr. Cache Locking */
+#define ESR_PUO		0x00040000	/* Unimplemented Operation exception */
 #define ESR_BO		0x00020000	/* Byte Ordering */
 
 /* Bit definitions related to the DBCR0. */
@@ -387,10 +401,12 @@ do {						\
 #define ICCR_CACHE	1		/* Cacheable */
 
 /* Bit definitions for L1CSR0. */
+#define L1CSR0_CLFC	0x00000100	/* Cache Lock Bits Flash Clear */
 #define L1CSR0_DCFI	0x00000002	/* Data Cache Flash Invalidate */
+#define L1CSR0_CFI	0x00000002	/* Cache Flash Invalidate */
 #define L1CSR0_DCE	0x00000001	/* Data Cache Enable */
 
-/* Bit definitions for L1CSR0. */
+/* Bit definitions for L1CSR1. */
 #define L1CSR1_ICLFR	0x00000100	/* Instr Cache Lock Bits Flash Reset */
 #define L1CSR1_ICFI	0x00000002	/* Instr Cache Flash Invalidate */
 #define L1CSR1_ICE	0x00000001	/* Instr Cache Enable */
