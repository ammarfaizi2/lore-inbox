Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266242AbUHBDj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266242AbUHBDj3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 23:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266240AbUHBDj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 23:39:28 -0400
Received: from ozlabs.org ([203.10.76.45]:40164 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266245AbUHBDi3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 23:38:29 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16653.46794.875909.367696@cargo.ozlabs.ibm.com>
Date: Mon, 2 Aug 2004 13:36:42 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: anton@samba.org, david@gibson.dropbear.id.au, linux-kernel@vger.kernel.org,
       Mike Wolf <mjw@us.ibm.com>
Subject: [PATCH] PPC64 Improve SLB reload
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rewrite/cleanup of the SLB management code.  This removes nearly all
the SLB related code from arch/ppc64/kernel/stab.c and puts a
rewritten version in arch/ppc64/mm, where it better belongs.  The main
SLB miss path is in assembler and the other routines have been cleaned
up and streamlined.

Notable changes:
	- Ugly bitfields no longer used for generating SLB entries.

	- slb_allocate() (the main SLB miss routine) is now in
assembler, and all the data it uses is stored in the PACA.

	- The mm context is now copied into the PACA at context switch
time, to avoid looking up the thread struct on SLB miss.

	- An SLB miss will now never (directly) result in a call to
do_page_fault.  If we get a miss on a totally bogus address the
handler will now put in an SLB referencing VSID 0.  This will never
have any pages, so we'll get the (fatal) page fault shortly
afterwards.  This simplifies the SLB entry and exit paths.

	- The round-robin pointer in the PACA now references the
last-used instead of next-to-use SLB slot, which simplifies the asm
for updating it slightly.

	- Unify do_slb_bolted with the general SLB miss path.  There
is now one SLB miss handler, in assembler, and called with only the
low-level exception prolog (EXCEPTION_PROLOG_[PI]SERIES rather than
EXCEPTION_PROLOG_COMMON) and minimal extra save/restore logic.

	- Streamlines the exception entry/exit path of the SLB miss
handler to shave a few cycles off.  The most significant change is
that the RI bit is left off throughout the whole handler, which avoids
an extra mtmsrd to turn it back off on the exit path.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc64/kernel/asm-offsets.c g5-ppc64/arch/ppc64/kernel/asm-offsets.c
--- linux-2.5/arch/ppc64/kernel/asm-offsets.c	2004-07-05 11:49:19.000000000 +1000
+++ g5-ppc64/arch/ppc64/kernel/asm-offsets.c	2004-08-02 13:02:49.000000000 +1000
@@ -86,10 +86,17 @@
         DEFINE(PACASAVEDMSR, offsetof(struct paca_struct, saved_msr));
         DEFINE(PACASTABREAL, offsetof(struct paca_struct, stab_real));
         DEFINE(PACASTABVIRT, offsetof(struct paca_struct, stab_addr));
-	DEFINE(PACASTABRR, offsetof(struct paca_struct, stab_next_rr));
+	DEFINE(PACASTABRR, offsetof(struct paca_struct, stab_rr));
         DEFINE(PACAR1, offsetof(struct paca_struct, saved_r1));
 	DEFINE(PACATOC, offsetof(struct paca_struct, kernel_toc));
 	DEFINE(PACAPROCENABLED, offsetof(struct paca_struct, proc_enabled));
+	DEFINE(PACASLBCACHE, offsetof(struct paca_struct, slb_cache));
+	DEFINE(PACASLBCACHEPTR, offsetof(struct paca_struct, slb_cache_ptr));
+	DEFINE(PACACONTEXTID, offsetof(struct paca_struct, context.id));
+	DEFINE(PACASLBR3, offsetof(struct paca_struct, slb_r3));
+#ifdef CONFIG_HUGETLB_PAGE
+	DEFINE(PACAHTLBSEGS, offsetof(struct paca_struct, context.htlb_segs));
+#endif /* CONFIG_HUGETLB_PAGE */
 	DEFINE(PACADEFAULTDECR, offsetof(struct paca_struct, default_decr));
 	DEFINE(PACAPROFENABLED, offsetof(struct paca_struct, prof_enabled));
 	DEFINE(PACAPROFLEN, offsetof(struct paca_struct, prof_len));
diff -urN linux-2.5/arch/ppc64/kernel/head.S g5-ppc64/arch/ppc64/kernel/head.S
--- linux-2.5/arch/ppc64/kernel/head.S	2004-07-28 01:06:01.000000000 +1000
+++ g5-ppc64/arch/ppc64/kernel/head.S	2004-08-02 13:02:52.000000000 +1000
@@ -200,6 +200,7 @@
 #define EX_R13		32
 #define EX_SRR0		40
 #define EX_DAR		48
+#define EX_LR		48	/* SLB miss saves LR, but not DAR */
 #define EX_DSISR	56
 #define EX_CCR		60
 
@@ -433,18 +434,52 @@
 	.globl DataAccessSLB_Pseries
 DataAccessSLB_Pseries:
 	mtspr	SPRG1,r13
-	mtspr	SPRG2,r12
-	mfspr	r13,DAR
-	mfcr	r12
-	srdi	r13,r13,60
-	cmpdi	r13,0xc
-	beq	.do_slb_bolted_Pseries
-	mtcrf	0x80,r12
-	mfspr	r12,SPRG2
-	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, DataAccessSLB_common)
+	mfspr	r13,SPRG3		/* get paca address into r13 */
+	std	r9,PACA_EXSLB+EX_R9(r13)	/* save r9 - r12 */
+	std	r10,PACA_EXSLB+EX_R10(r13)
+	std	r11,PACA_EXSLB+EX_R11(r13)
+	std	r12,PACA_EXSLB+EX_R12(r13)
+	std	r3,PACASLBR3(r13)
+	mfspr	r9,SPRG1
+	std	r9,PACA_EXSLB+EX_R13(r13)
+	mfcr	r9
+	clrrdi	r12,r13,32		/* get high part of &label */
+	mfmsr	r10
+	mfspr	r11,SRR0		/* save SRR0 */
+	ori	r12,r12,(.do_slb_miss)@l
+	ori	r10,r10,MSR_IR|MSR_DR	/* DON'T set RI for SLB miss */
+	mtspr	SRR0,r12
+	mfspr	r12,SRR1		/* and SRR1 */
+	mtspr	SRR1,r10
+	mfspr	r3,DAR
+	rfid
 
 	STD_EXCEPTION_PSERIES(0x400, InstructionAccess)
-	STD_EXCEPTION_PSERIES(0x480, InstructionAccessSLB)
+
+	. = 0x480
+	.globl InstructionAccessSLB_Pseries
+InstructionAccessSLB_Pseries:
+	mtspr	SPRG1,r13
+	mfspr	r13,SPRG3		/* get paca address into r13 */
+	std	r9,PACA_EXSLB+EX_R9(r13)	/* save r9 - r12 */
+	std	r10,PACA_EXSLB+EX_R10(r13)
+	std	r11,PACA_EXSLB+EX_R11(r13)
+	std	r12,PACA_EXSLB+EX_R12(r13)
+	std	r3,PACASLBR3(r13)
+	mfspr	r9,SPRG1
+	std	r9,PACA_EXSLB+EX_R13(r13)
+	mfcr	r9
+	clrrdi	r12,r13,32		/* get high part of &label */
+	mfmsr	r10
+	mfspr	r11,SRR0		/* save SRR0 */
+	ori	r12,r12,(.do_slb_miss)@l
+	ori	r10,r10,MSR_IR|MSR_DR	/* DON'T set RI for SLB miss */
+	mtspr	SRR0,r12
+	mfspr	r12,SRR1		/* and SRR1 */
+	mtspr	SRR1,r10
+	mr	r3,r11			/* SRR0 is faulting address */
+	rfid
+	
 	STD_EXCEPTION_PSERIES(0x500, HardwareInterrupt)
 	STD_EXCEPTION_PSERIES(0x600, Alignment)
 	STD_EXCEPTION_PSERIES(0x700, ProgramCheck)
@@ -494,11 +529,6 @@
 	mfspr	r12,SPRG2
 	EXCEPTION_PROLOG_PSERIES(PACA_EXSLB, .do_stab_bolted)
 
-_GLOBAL(do_slb_bolted_Pseries)
-	mtcrf	0x80,r12
-	mfspr	r12,SPRG2
-	EXCEPTION_PROLOG_PSERIES(PACA_EXSLB, .do_slb_bolted)
-
 	
 	/* Space for the naca.  Architected to be located at real address
 	 * NACA_PHYS_ADDR.  Various tools rely on this location being fixed.
@@ -587,27 +617,25 @@
 	.globl	DataAccessSLB_Iseries
 DataAccessSLB_Iseries:
 	mtspr	SPRG1,r13		/* save r13 */
-	mtspr	SPRG2,r12
-	mfspr	r13,DAR
-	mfcr	r12
-	srdi	r13,r13,60
-	cmpdi	r13,0xc
-	beq	.do_slb_bolted_Iseries
-	mtcrf	0x80,r12
-	mfspr	r12,SPRG2
-	EXCEPTION_PROLOG_ISERIES_1(PACA_EXGEN)
-	EXCEPTION_PROLOG_ISERIES_2
-	b	DataAccessSLB_common
-
-.do_slb_bolted_Iseries:
-	mtcrf	0x80,r12
-	mfspr	r12,SPRG2
 	EXCEPTION_PROLOG_ISERIES_1(PACA_EXSLB)
-	EXCEPTION_PROLOG_ISERIES_2
-	b	.do_slb_bolted
+	std	r3,PACASLBR3(r13)
+	ld	r11,PACALPPACA+LPPACASRR0(r13)
+	ld	r12,PACALPPACA+LPPACASRR1(r13)
+	mfspr	r3,DAR
+	b	.do_slb_miss
 
 	STD_EXCEPTION_ISERIES(0x400, InstructionAccess, PACA_EXGEN)
-	STD_EXCEPTION_ISERIES(0x480, InstructionAccessSLB, PACA_EXGEN)
+
+	.globl	InstructionAccessSLB_Iseries
+InstructionAccessSLB_Iseries:
+	mtspr	SPRG1,r13		/* save r13 */
+	EXCEPTION_PROLOG_ISERIES_1(PACA_EXSLB)
+	std	r3,PACASLBR3(r13)
+	ld	r11,PACALPPACA+LPPACASRR0(r13)
+	ld	r12,PACALPPACA+LPPACASRR1(r13)
+	mr	r3,r11
+	b	.do_slb_miss
+
 	MASKABLE_EXCEPTION_ISERIES(0x500, HardwareInterrupt)
 	STD_EXCEPTION_ISERIES(0x600, Alignment, PACA_EXGEN)
 	STD_EXCEPTION_ISERIES(0x700, ProgramCheck, PACA_EXGEN)
@@ -865,21 +893,6 @@
 	b	.do_hash_page	 	/* Try to handle as hpte fault */
 
 	.align	7
-	.globl DataAccessSLB_common
-DataAccessSLB_common:
-	mfspr	r10,DAR
-	std	r10,PACA_EXGEN+EX_DAR(r13)
-	EXCEPTION_PROLOG_COMMON(0x380, PACA_EXGEN)
-	ld	r3,PACA_EXGEN+EX_DAR(r13)
-	std	r3,_DAR(r1)
-	bl	.slb_allocate
-	cmpdi	r3,0			/* Check return code */
-	beq	fast_exception_return	/* Return if we succeeded */
-	li	r5,0
-	std	r5,_DSISR(r1)
-	b	.handle_page_fault
-
-	.align	7
 	.globl InstructionAccess_common
 InstructionAccess_common:
 	EXCEPTION_PROLOG_COMMON(0x400, PACA_EXGEN)
@@ -889,21 +902,6 @@
 	b	.do_hash_page		/* Try to handle as hpte fault */
 
 	.align	7
-	.globl InstructionAccessSLB_common
-InstructionAccessSLB_common:
-	EXCEPTION_PROLOG_COMMON(0x480, PACA_EXGEN)
-	ld	r3,_NIP(r1)		/* SRR0 = NIA	*/
-	bl	.slb_allocate
-	or.	r3,r3,r3		/* Check return code */
-	beq+	fast_exception_return	/* Return if we succeeded */
-
-	ld	r4,_NIP(r1)
-	li	r5,0
-	std	r4,_DAR(r1)
-	std	r5,_DSISR(r1)
-	b      .handle_page_fault
-
-	.align	7
 	.globl HardwareInterrupt_common
 	.globl HardwareInterrupt_entry
 HardwareInterrupt_common:
@@ -1152,130 +1150,37 @@
 /*
  * r13 points to the PACA, r9 contains the saved CR,
  * r11 and r12 contain the saved SRR0 and SRR1.
+ * r3 has the faulting address
  * r9 - r13 are saved in paca->exslb.
+ * r3 is saved in paca->slb_r3
  * We assume we aren't going to take any exceptions during this procedure.
  */
-/* XXX note fix masking in get_kernel_vsid to match */
-_GLOBAL(do_slb_bolted)
+_GLOBAL(do_slb_miss)
+	mflr	r10
+
 	stw	r9,PACA_EXSLB+EX_CCR(r13)	/* save CR in exc. frame */
 	std	r11,PACA_EXSLB+EX_SRR0(r13)	/* save SRR0 in exc. frame */
+	std	r10,PACA_EXSLB+EX_LR(r13)	/* save LR */
 
-	/*
-	 * We take the next entry, round robin. Previously we tried
-	 * to find a free slot first but that took too long. Unfortunately
-	 * we dont have any LRU information to help us choose a slot.
-	 */
-
-	/* r13 = paca */
-1:	ld	r10,PACASTABRR(r13)
-	addi	r9,r10,1
-	cmpdi	r9,SLB_NUM_ENTRIES
-	blt+	2f
-	li	r9,2			/* dont touch slot 0 or 1 */
-2:	std	r9,PACASTABRR(r13)
-
-	/* r13 = paca, r10 = entry */
-
-	/* 
-	 * Never cast out the segment for our kernel stack. Since we
-	 * dont invalidate the ERAT we could have a valid translation
-	 * for the kernel stack during the first part of exception exit 
-	 * which gets invalidated due to a tlbie from another cpu at a
-	 * non recoverable point (after setting srr0/1) - Anton
-	 */
-	slbmfee	r9,r10
-	srdi	r9,r9,27
-	/*
-	 * Use paca->ksave as the value of the kernel stack pointer,
-	 * because this is valid at all times.
-	 * The >> 27 (rather than >> 28) is so that the LSB is the
-	 * valid bit - this way we check valid and ESID in one compare.
-	 * In order to completely close the tiny race in the context
-	 * switch (between updating r1 and updating paca->ksave),
-	 * we check against both r1 and paca->ksave.
-	 */
-	srdi	r11,r1,27
-	ori	r11,r11,1
-	cmpd	r11,r9
-	beq-	1b
-	ld	r11,PACAKSAVE(r13)
-	srdi	r11,r11,27
- 	ori	r11,r11,1
- 	cmpd	r11,r9
- 	beq-	1b
-
-	/* r13 = paca, r10 = entry */
-
-	/* (((ea >> 28) & 0x1fff) << 15) | (ea >> 60) */
-	mfspr	r9,DAR
-	rldicl	r11,r9,36,51
-	sldi	r11,r11,15
-	srdi	r9,r9,60
-	or	r11,r11,r9
-
-	/* VSID_RANDOMIZER */
-	li	r9,9
-	sldi	r9,r9,32
-	oris	r9,r9,58231
-	ori	r9,r9,39831
-
-	/* vsid = (ordinal * VSID_RANDOMIZER) & VSID_MASK */
-	mulld	r11,r11,r9
-	clrldi	r11,r11,28
-
-	/* r13 = paca, r10 = entry, r11 = vsid */
-
-	/* Put together slb word1 */
-	sldi	r11,r11,12
-
-BEGIN_FTR_SECTION
-	/* set kp and c bits */
-	ori	r11,r11,0x480
-END_FTR_SECTION_IFCLR(CPU_FTR_16M_PAGE)
-BEGIN_FTR_SECTION
-	/* set kp, l and c bits */
-	ori	r11,r11,0x580
-END_FTR_SECTION_IFSET(CPU_FTR_16M_PAGE)
-
-	/* r13 = paca, r10 = entry, r11 = slb word1 */
-
-	/* Put together slb word0 */
-	mfspr	r9,DAR
-	clrrdi	r9,r9,28	/* get the new esid */
-	oris	r9,r9,0x800	/* set valid bit */
-	rldimi	r9,r10,0,52	/* insert entry */
-
-	/* r13 = paca, r9 = slb word0, r11 = slb word1 */
-
-	/* 
-	 * No need for an isync before or after this slbmte. The exception
-	 * we enter with and the rfid we exit with are context synchronizing .
-	 */
-	slbmte	r11,r9
+	bl	.slb_allocate			/* handle it */
 
 	/* All done -- return from exception. */
+	
+	ld	r10,PACA_EXSLB+EX_LR(r13)
+	ld	r3,PACASLBR3(r13)
 	lwz	r9,PACA_EXSLB+EX_CCR(r13)	/* get saved CR */
 	ld	r11,PACA_EXSLB+EX_SRR0(r13)	/* get saved SRR0 */
 
+	mtlr	r10
+
 	andi.	r10,r12,MSR_RI	/* check for unrecoverable exception */
 	beq-	unrecov_slb
 
-	/*
-	 * Until everyone updates binutils hardwire the POWER4 optimised
-	 * single field mtcrf
-	 */
-#if 0
-	.machine	push
-	.machine	"power4"
+.machine	push
+.machine	"power4"
 	mtcrf	0x80,r9
-	.machine	pop
-#else
-	.long 0x7d380120
-#endif
-
-	mfmsr	r10
-	clrrdi	r10,r10,2
-	mtmsrd	r10,1
+	mtcrf	0x01,r9		/* slb_allocate uses cr0 and cr7 */
+.machine	pop
 
 	mtspr	SRR0,r11
 	mtspr	SRR1,r12
diff -urN linux-2.5/arch/ppc64/kernel/pacaData.c g5-ppc64/arch/ppc64/kernel/pacaData.c
--- linux-2.5/arch/ppc64/kernel/pacaData.c	2004-07-30 00:25:12.000000000 +1000
+++ g5-ppc64/arch/ppc64/kernel/pacaData.c	2004-08-02 13:02:44.000000000 +1000
@@ -57,7 +57,6 @@
 	.stab_addr = (asrv),		/* Virt pointer to segment table */ \
 	.emergency_sp = &emergency_stack[((number)+1) * PAGE_SIZE],	    \
 	.cpu_start = (start),		/* Processor start */		    \
-	.stab_next_rr = 1,						    \
 	.lppaca = {							    \
 		.xDesc = 0xd397d781,	/* "LpPa" */			    \
 		.xSize = sizeof(struct ItLpPaca),			    \
diff -urN linux-2.5/arch/ppc64/kernel/smp.c g5-ppc64/arch/ppc64/kernel/smp.c
--- linux-2.5/arch/ppc64/kernel/smp.c	2004-07-30 00:25:13.000000000 +1000
+++ g5-ppc64/arch/ppc64/kernel/smp.c	2004-08-02 13:02:44.000000000 +1000
@@ -389,8 +389,6 @@
 
 	/* Fixup atomic count: it exited inside IRQ handler. */
 	paca[lcpu].__current->thread_info->preempt_count	= 0;
-	/* Fixup SLB round-robin so next segment (kernel) goes in segment 0 */
-	paca[lcpu].stab_next_rr = 0;
 
 	/* At boot this is done in prom.c. */
 	paca[lcpu].hw_cpu_id = pcpu;
diff -urN linux-2.5/arch/ppc64/kernel/stab.c g5-ppc64/arch/ppc64/kernel/stab.c
--- linux-2.5/arch/ppc64/kernel/stab.c	2004-07-05 11:49:19.000000000 +1000
+++ g5-ppc64/arch/ppc64/kernel/stab.c	2004-08-02 13:02:44.000000000 +1000
@@ -20,26 +20,10 @@
 #include <asm/naca.h>
 #include <asm/cputable.h>
 
-static int make_ste(unsigned long stab, unsigned long esid, unsigned long vsid);
-static void make_slbe(unsigned long esid, unsigned long vsid, int large,
-		      int kernel_segment);
+static int make_ste(unsigned long stab, unsigned long esid,
+		    unsigned long vsid);
 
-static inline void slb_add_bolted(void)
-{
-#ifndef CONFIG_PPC_ISERIES
-	unsigned long esid = GET_ESID(VMALLOCBASE);
-	unsigned long vsid = get_kernel_vsid(VMALLOCBASE);
-
-	WARN_ON(!irqs_disabled());
-
-	/*
-	 * Bolt in the first vmalloc segment. Since modules end
-	 * up there it gets hit very heavily.
-	 */
-	get_paca()->stab_next_rr = 1;
-	make_slbe(esid, vsid, 0, 1);
-#endif
-}
+void slb_initialize(void);
 
 /*
  * Build an entry for the base kernel segment and put it into
@@ -48,32 +32,13 @@
  */
 void stab_initialize(unsigned long stab)
 {
-	unsigned long esid, vsid; 
-	int seg0_largepages = 0;
-
-	esid = GET_ESID(KERNELBASE);
-	vsid = get_kernel_vsid(esid << SID_SHIFT); 
-
-	if (cur_cpu_spec->cpu_features & CPU_FTR_16M_PAGE)
-		seg0_largepages = 1;
+	unsigned long vsid = get_kernel_vsid(KERNELBASE);
 
 	if (cur_cpu_spec->cpu_features & CPU_FTR_SLB) {
-		/* Invalidate the entire SLB & all the ERATS */
-#ifdef CONFIG_PPC_ISERIES
-		asm volatile("isync; slbia; isync":::"memory");
-#else
-		asm volatile("isync":::"memory");
-		asm volatile("slbmte  %0,%0"::"r" (0) : "memory");
-		asm volatile("isync; slbia; isync":::"memory");
-		get_paca()->stab_next_rr = 0;
-		make_slbe(esid, vsid, seg0_largepages, 1);
-		asm volatile("isync":::"memory");
-#endif
-
-		slb_add_bolted();
+		slb_initialize();
 	} else {
 		asm volatile("isync; slbia; isync":::"memory");
-		make_ste(stab, esid, vsid);
+		make_ste(stab, GET_ESID(KERNELBASE), vsid);
 
 		/* Order update */
 		asm volatile("sync":::"memory"); 
@@ -129,7 +94,7 @@
 	 * Could not find empty entry, pick one with a round robin selection.
 	 * Search all entries in the two groups.
 	 */
-	castout_entry = get_paca()->stab_next_rr;
+	castout_entry = get_paca()->stab_rr;
 	for (i = 0; i < 16; i++) {
 		if (castout_entry < 8) {
 			global_entry = (esid & 0x1f) << 3;
@@ -148,7 +113,7 @@
 		castout_entry = (castout_entry + 1) & 0xf;
 	}
 
-	get_paca()->stab_next_rr = (castout_entry + 1) & 0xf;
+	get_paca()->stab_rr = (castout_entry + 1) & 0xf;
 
 	/* Modify the old entry to the new value. */
 
@@ -314,229 +279,3 @@
 
 	preload_stab(tsk, mm);
 }
-
-/*
- * SLB stuff
- */
-
-/*
- * Create a segment buffer entry for the given esid/vsid pair.
- *
- * NOTE: A context syncronising instruction is required before and after
- * this, in the common case we use exception entry and rfid.
- */
-static void make_slbe(unsigned long esid, unsigned long vsid, int large,
-		      int kernel_segment)
-{
-	unsigned long entry, castout_entry;
-	union {
-		unsigned long word0;
-		slb_dword0    data;
-	} esid_data;
-	union {
-		unsigned long word0;
-		slb_dword1    data;
-	} vsid_data;
-	struct paca_struct *lpaca = get_paca();
-
-	/*
-	 * We take the next entry, round robin. Previously we tried
-	 * to find a free slot first but that took too long. Unfortunately
-	 * we dont have any LRU information to help us choose a slot.
-	 */
-
-	/* 
-	 * Never cast out the segment for our kernel stack. Since we
-	 * dont invalidate the ERAT we could have a valid translation
-	 * for the kernel stack during the first part of exception exit 
-	 * which gets invalidated due to a tlbie from another cpu at a
-	 * non recoverable point (after setting srr0/1) - Anton
-	 *
-	 * paca Ksave is always valid (even when on the interrupt stack)
-	 * so we use that.
-	 */
-	castout_entry = lpaca->stab_next_rr;
-	do {
-		entry = castout_entry;
-		castout_entry++; 
-		/*
-		 * We bolt in the first kernel segment and the first
-		 * vmalloc segment.
-		 */
-		if (castout_entry >= SLB_NUM_ENTRIES)
-			castout_entry = 2;
-		asm volatile("slbmfee  %0,%1" : "=r" (esid_data) : "r" (entry));
-	} while (esid_data.data.v &&
-		 esid_data.data.esid == GET_ESID(lpaca->kstack));
-
-	lpaca->stab_next_rr = castout_entry;
-
-	/* slbie not needed as the previous mapping is still valid. */
-
-	/* 
-	 * Write the new SLB entry.
-	 */
-	vsid_data.word0 = 0;
-	vsid_data.data.vsid = vsid;
-	vsid_data.data.kp = 1;
-	if (large)
-		vsid_data.data.l = 1;
-	if (kernel_segment)
-		vsid_data.data.c = 1;
-	else
-		vsid_data.data.ks = 1;
-
-	esid_data.word0 = 0;
-	esid_data.data.esid = esid;
-	esid_data.data.v = 1;
-	esid_data.data.index = entry;
-
-	/*
-	 * No need for an isync before or after this slbmte. The exception
-	 * we enter with and the rfid we exit with are context synchronizing.
-	 */
-	asm volatile("slbmte  %0,%1" : : "r" (vsid_data), "r" (esid_data)); 
-}
-
-static inline void __slb_allocate(unsigned long esid, unsigned long vsid,
-				  mm_context_t context)
-{
-	int large = 0;
-	int region_id = REGION_ID(esid << SID_SHIFT);
-	unsigned long offset;
-
-	if (cur_cpu_spec->cpu_features & CPU_FTR_16M_PAGE) {
-		if (region_id == KERNEL_REGION_ID)
-			large = 1;
-		else if (region_id == USER_REGION_ID)
-			large = in_hugepage_area(context, esid << SID_SHIFT);
-	}
-
-	make_slbe(esid, vsid, large, region_id != USER_REGION_ID);
-
-	if (region_id != USER_REGION_ID)
-		return;
-
-	offset = __get_cpu_var(stab_cache_ptr);
-	if (offset < NR_STAB_CACHE_ENTRIES)
-		__get_cpu_var(stab_cache[offset++]) = esid;
-	else
-		offset = NR_STAB_CACHE_ENTRIES+1;
-	__get_cpu_var(stab_cache_ptr) = offset;
-}
-
-/*
- * Allocate a segment table entry for the given ea.
- */
-int slb_allocate(unsigned long ea)
-{
-	unsigned long vsid, esid;
-	mm_context_t context;
-
-	/* Check for invalid effective addresses. */
-	if (unlikely(!IS_VALID_EA(ea)))
-		return 1;
-
-	/* Kernel or user address? */
-	if (REGION_ID(ea) >= KERNEL_REGION_ID) {
-		context = KERNEL_CONTEXT(ea);
-		vsid = get_kernel_vsid(ea);
-	} else {
-		if (unlikely(!current->mm))
-			return 1;
-
-		context = current->mm->context;
-		vsid = get_vsid(context.id, ea);
-	}
-
-	esid = GET_ESID(ea);
-#ifndef CONFIG_PPC_ISERIES
-	BUG_ON((esid << SID_SHIFT) == VMALLOCBASE);
-#endif
-	__slb_allocate(esid, vsid, context);
-
-	return 0;
-}
-
-/*
- * preload some userspace segments into the SLB.
- */
-static void preload_slb(struct task_struct *tsk, struct mm_struct *mm)
-{
-	unsigned long pc = KSTK_EIP(tsk);
-	unsigned long stack = KSTK_ESP(tsk);
-	unsigned long unmapped_base;
-	unsigned long pc_esid = GET_ESID(pc);
-	unsigned long stack_esid = GET_ESID(stack);
-	unsigned long unmapped_base_esid;
-	unsigned long vsid;
-
-	if (test_tsk_thread_flag(tsk, TIF_32BIT))
-		unmapped_base = TASK_UNMAPPED_BASE_USER32;
-	else
-		unmapped_base = TASK_UNMAPPED_BASE_USER64;
-
-	unmapped_base_esid = GET_ESID(unmapped_base);
-
-	if (!IS_VALID_EA(pc) || (REGION_ID(pc) >= KERNEL_REGION_ID))
-		return;
-	vsid = get_vsid(mm->context.id, pc);
-	__slb_allocate(pc_esid, vsid, mm->context);
-
-	if (pc_esid == stack_esid)
-		return;
-
-	if (!IS_VALID_EA(stack) || (REGION_ID(stack) >= KERNEL_REGION_ID))
-		return;
-	vsid = get_vsid(mm->context.id, stack);
-	__slb_allocate(stack_esid, vsid, mm->context);
-
-	if (pc_esid == unmapped_base_esid || stack_esid == unmapped_base_esid)
-		return;
-
-	if (!IS_VALID_EA(unmapped_base) ||
-	    (REGION_ID(unmapped_base) >= KERNEL_REGION_ID))
-		return;
-	vsid = get_vsid(mm->context.id, unmapped_base);
-	__slb_allocate(unmapped_base_esid, vsid, mm->context);
-}
-
-/* Flush all user entries from the segment table of the current processor. */
-void flush_slb(struct task_struct *tsk, struct mm_struct *mm)
-{
-	unsigned long offset = __get_cpu_var(stab_cache_ptr);
-	union {
-		unsigned long word0;
-		slb_dword0 data;
-	} esid_data;
-
-	if (offset <= NR_STAB_CACHE_ENTRIES) {
-		int i;
-		asm volatile("isync" : : : "memory");
-		for (i = 0; i < offset; i++) {
-			esid_data.word0 = 0;
-			esid_data.data.esid = __get_cpu_var(stab_cache[i]);
-			BUG_ON(esid_data.data.esid == GET_ESID(VMALLOCBASE));
-			asm volatile("slbie %0" : : "r" (esid_data));
-		}
-		asm volatile("isync" : : : "memory");
-	} else {
-		asm volatile("isync; slbia; isync" : : : "memory");
-		slb_add_bolted();
-	}
-
-	/* Workaround POWER5 < DD2.1 issue */
-	if (offset == 1 || offset > NR_STAB_CACHE_ENTRIES) {
-		/* 
-		 * flush segment in EEH region, we dont normally access
-		 * addresses in this region.
-		 */
-		esid_data.word0 = 0;
-		esid_data.data.esid = EEH_REGION_ID;
-		asm volatile("slbie %0" : : "r" (esid_data));
-	}
-
-	__get_cpu_var(stab_cache_ptr) = 0;
-
-	preload_slb(tsk, mm);
-}
diff -urN linux-2.5/arch/ppc64/mm/Makefile g5-ppc64/arch/ppc64/mm/Makefile
--- linux-2.5/arch/ppc64/mm/Makefile	2004-02-28 10:11:18.000000000 +1100
+++ g5-ppc64/arch/ppc64/mm/Makefile	2004-08-02 13:02:44.000000000 +1000
@@ -4,6 +4,6 @@
 
 EXTRA_CFLAGS += -mno-minimal-toc
 
-obj-y := fault.o init.o imalloc.o hash_utils.o hash_low.o tlb.o
+obj-y := fault.o init.o imalloc.o hash_utils.o hash_low.o tlb.o slb_low.o slb.o
 obj-$(CONFIG_DISCONTIGMEM) += numa.o
 obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
diff -urN linux-2.5/arch/ppc64/mm/fault.c g5-ppc64/arch/ppc64/mm/fault.c
--- linux-2.5/arch/ppc64/mm/fault.c	2004-07-17 08:44:01.000000000 +1000
+++ g5-ppc64/arch/ppc64/mm/fault.c	2004-08-02 13:02:44.000000000 +1000
@@ -93,13 +93,15 @@
 	unsigned long is_write = error_code & 0x02000000;
 	unsigned long trap = TRAP(regs);
 
-	if (trap == 0x300 || trap == 0x380) {
+	BUG_ON((trap == 0x380) || (trap == 0x480));
+
+	if (trap == 0x300) {
 		if (debugger_fault_handler(regs))
 			return 0;
 	}
 
 	/* On a kernel SLB miss we can only check for a valid exception entry */
-	if (!user_mode(regs) && (trap == 0x380 || address >= TASK_SIZE))
+	if (!user_mode(regs) && (address >= TASK_SIZE))
 		return SIGSEGV;
 
 	if (error_code & 0x00400000) {
diff -urN linux-2.5/arch/ppc64/mm/slb.c g5-ppc64/arch/ppc64/mm/slb.c
--- /dev/null	2004-04-13 15:11:35.000000000 +1000
+++ g5-ppc64/arch/ppc64/mm/slb.c	2004-08-02 13:02:44.000000000 +1000
@@ -0,0 +1,136 @@
+/*
+ * PowerPC64 SLB support.
+ *
+ * Copyright (C) 2004 David Gibson <dwg@au.ibm.com>, IBM
+ * Based on earlier code writteh by:
+ * Dave Engebretsen and Mike Corrigan {engebret|mikejc}@us.ibm.com
+ *    Copyright (c) 2001 Dave Engebretsen
+ * Copyright (C) 2002 Anton Blanchard <anton@au.ibm.com>, IBM
+ * 
+ *
+ *      This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/config.h>
+#include <asm/pgtable.h>
+#include <asm/mmu.h>
+#include <asm/mmu_context.h>
+#include <asm/paca.h>
+#include <asm/naca.h>
+#include <asm/cputable.h>
+
+extern void slb_allocate(unsigned long ea);
+
+static inline void create_slbe(unsigned long ea, unsigned long vsid,
+			       unsigned long flags, unsigned long entry)
+{
+	ea = (ea & ESID_MASK) | SLB_ESID_V | entry;
+	vsid = (vsid << SLB_VSID_SHIFT) | flags;
+	asm volatile("slbmte  %0,%1" :
+		     : "r" (vsid), "r" (ea)
+		     : "memory" );
+}
+
+static void slb_add_bolted(void)
+{
+#ifndef CONFIG_PPC_ISERIES
+	WARN_ON(!irqs_disabled());
+
+	/* If you change this make sure you change SLB_NUM_BOLTED
+	 * appropriately too */
+
+	/* Slot 1 - first VMALLOC segment
+         * 	Since modules end up there it gets hit very heavily.
+         */
+	create_slbe(VMALLOCBASE, get_kernel_vsid(VMALLOCBASE),
+		    SLB_VSID_KERNEL, 1);
+
+	asm volatile("isync":::"memory");
+#endif
+}
+
+/* Flush all user entries from the segment table of the current processor. */
+void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
+{
+	unsigned long offset = get_paca()->slb_cache_ptr;
+	unsigned long esid_data;
+	unsigned long pc = KSTK_EIP(tsk);
+	unsigned long stack = KSTK_ESP(tsk);
+	unsigned long unmapped_base;
+
+	if (offset <= SLB_CACHE_ENTRIES) {
+		int i;
+		asm volatile("isync" : : : "memory");
+		for (i = 0; i < offset; i++) {
+			esid_data = (unsigned long)get_paca()->slb_cache[i]
+				<< SID_SHIFT;
+			asm volatile("slbie %0" : : "r" (esid_data));
+		}
+		asm volatile("isync" : : : "memory");
+	} else {
+		asm volatile("isync; slbia; isync" : : : "memory");
+		slb_add_bolted();
+	}
+
+	/* Workaround POWER5 < DD2.1 issue */
+	if (offset == 1 || offset > SLB_CACHE_ENTRIES) {
+		/* flush segment in EEH region, we shouldn't ever
+		 * access addresses in this region. */
+		asm volatile("slbie %0" : : "r"(EEHREGIONBASE));
+	}
+
+	get_paca()->slb_cache_ptr = 0;
+	get_paca()->context = mm->context;
+
+	/*
+	 * preload some userspace segments into the SLB.
+	 */
+	if (test_tsk_thread_flag(tsk, TIF_32BIT))
+		unmapped_base = TASK_UNMAPPED_BASE_USER32;
+	else
+		unmapped_base = TASK_UNMAPPED_BASE_USER64;
+
+	if (pc >= KERNELBASE)
+		return;
+	slb_allocate(pc);
+
+	if (GET_ESID(pc) == GET_ESID(stack))
+		return;
+
+	if (stack >= KERNELBASE)
+		return;
+	slb_allocate(stack);
+	
+	if ((GET_ESID(pc) == GET_ESID(unmapped_base))
+	    || (GET_ESID(stack) == GET_ESID(unmapped_base)))
+		return;
+
+	if (unmapped_base >= KERNELBASE)
+		return;
+	slb_allocate(unmapped_base);
+}
+
+void slb_initialize(void)
+{
+#ifdef CONFIG_PPC_ISERIES
+	asm volatile("isync; slbia; isync":::"memory");
+#else
+	unsigned long flags = SLB_VSID_KERNEL;
+
+	/* Invalidate the entire SLB (even slot 0) & all the ERATS */
+	if (cur_cpu_spec->cpu_features & CPU_FTR_16M_PAGE)
+		flags |= SLB_VSID_L;
+	
+	asm volatile("isync":::"memory");
+	asm volatile("slbmte  %0,%0"::"r" (0) : "memory");
+	asm volatile("isync; slbia; isync":::"memory");
+	create_slbe(KERNELBASE, get_kernel_vsid(KERNELBASE),
+		    flags, 0);
+	
+#endif
+	slb_add_bolted();
+	get_paca()->stab_rr = SLB_NUM_BOLTED;
+}
diff -urN linux-2.5/arch/ppc64/mm/slb_low.S g5-ppc64/arch/ppc64/mm/slb_low.S
--- /dev/null	2004-04-13 15:11:35.000000000 +1000
+++ g5-ppc64/arch/ppc64/mm/slb_low.S	2004-08-02 13:02:44.000000000 +1000
@@ -0,0 +1,168 @@
+/*
+ * arch/ppc64/mm/slb_low.S
+ *
+ * Low-level SLB routines
+ *
+ * Copyright (C) 2004 David Gibson <dwg@au.ibm.com>, IBM
+ *
+ * Based on earlier C version:	
+ * Dave Engebretsen and Mike Corrigan {engebret|mikejc}@us.ibm.com
+ *    Copyright (c) 2001 Dave Engebretsen
+ * Copyright (C) 2002 Anton Blanchard <anton@au.ibm.com>, IBM
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/config.h>
+#include <asm/processor.h>
+#include <asm/page.h>
+#include <asm/mmu.h>
+#include <asm/ppc_asm.h>
+#include <asm/offsets.h>
+#include <asm/cputable.h>
+
+/* void slb_allocate(unsigned long ea);
+ *
+ * Create an SLB entry for the given EA (user or kernel).
+ * 	r3 = faulting address, r13 = PACA
+ *	r9, r10, r11 are clobbered by this function
+ * No other registers are examined or changed.
+ */
+_GLOBAL(slb_allocate)
+	/*
+	 * First find a slot, round robin. Previously we tried to find
+	 * a free slot first but that took too long. Unfortunately we
+	 * dont have any LRU information to help us choose a slot.
+	 */
+	srdi	r9,r1,27
+	ori	r9,r9,1			/* mangle SP for later compare */
+
+	ld	r10,PACASTABRR(r13)
+3:
+	addi	r10,r10,1
+	/* use a cpu feature mask if we ever change our slb size */
+	cmpldi	r10,SLB_NUM_ENTRIES
+
+	blt+	4f
+	li	r10,SLB_NUM_BOLTED
+4:
+	slbmfee	r11,r10
+	/* Don't throw out the segment for our kernel stack. Since we
+	 * dont invalidate the ERAT we could have a valid translation
+	 * for the kernel stack during the first part of exception
+	 * exit which gets invalidated due to a tlbie from another cpu
+	 * at a non recoverable point (after setting srr0/1) - Anton
+	 *
+	 * The >> 27 (rather than >> 28) is so that the LSB is the
+	 * valid bit - this way we check valid and ESID in one compare.
+	 */
+	srdi	r11,r11,27
+	cmpd	r11,r9
+	beq-	3b
+
+	std	r10,PACASTABRR(r13)
+
+	/* r3 = faulting address, r10 = entry */
+
+	srdi	r9,r3,60		/* get region */
+	srdi	r3,r3,28		/* get esid */
+	cmpldi	cr7,r9,0xc		/* cmp KERNELBASE for later use */
+
+	/* r9 = region, r3 = esid, cr7 = <>KERNELBASE */
+
+	rldicr.	r11,r3,32,16
+	bne-	8f			/* invalid ea bits set */
+	addi	r11,r9,-1
+	cmpldi	r11,0xb
+	blt-	8f			/* invalid region */
+
+	/* r9 = region, r3 = esid, r10 = entry, cr7 = <>KERNELBASE */
+
+	blt	cr7,0f			/* user or kernel? */
+
+	/* kernel address */
+	li	r11,SLB_VSID_KERNEL
+BEGIN_FTR_SECTION
+	bne	cr7,9f
+	li	r11,(SLB_VSID_KERNEL|SLB_VSID_L)
+END_FTR_SECTION_IFSET(CPU_FTR_16M_PAGE)
+	b	9f
+
+0:	/* user address */
+	li	r11,SLB_VSID_USER
+#ifdef CONFIG_HUGETLB_PAGE
+BEGIN_FTR_SECTION
+	/* check against the hugepage ranges */
+	cmpldi	r3,(TASK_HPAGE_END>>SID_SHIFT)
+	bge	6f			/* >= TASK_HPAGE_END */
+	cmpldi	r3,(TASK_HPAGE_BASE>>SID_SHIFT)
+	bge	5f			/* TASK_HPAGE_BASE..TASK_HPAGE_END */
+	cmpldi	r3,16
+	bge	6f			/* 4GB..TASK_HPAGE_BASE */
+
+	lhz	r9,PACAHTLBSEGS(r13)
+	srd	r9,r9,r3
+	andi.	r9,r9,1
+	beq	6f
+
+5:	/* this is a hugepage user address */
+	li	r11,(SLB_VSID_USER|SLB_VSID_L)
+END_FTR_SECTION_IFSET(CPU_FTR_16M_PAGE)
+#endif /* CONFIG_HUGETLB_PAGE */
+
+6:	ld	r9,PACACONTEXTID(r13)
+
+9:	/* r9 = "context", r3 = esid, r11 = flags, r10 = entry */
+
+	rldimi	r9,r3,15,0		/* r9= VSID ordinal */
+
+7:	rldimi	r10,r3,28,0		/* r10= ESID<<28 | entry */
+	oris	r10,r10,SLB_ESID_V@h	/* r10 |= SLB_ESID_V */
+
+	/* r9 = ordinal, r3 = esid, r11 = flags, r10 = esid_data */
+
+	li	r3,VSID_RANDOMIZER@higher
+	sldi	r3,r3,32
+	oris	r3,r3,VSID_RANDOMIZER@h
+	ori	r3,r3,VSID_RANDOMIZER@l
+
+	mulld	r9,r3,r9		/* r9 = ordinal * VSID_RANDOMIZER */
+	clrldi	r9,r9,28		/* r9 &= VSID_MASK */
+	sldi	r9,r9,SLB_VSID_SHIFT	/* r9 <<= SLB_VSID_SHIFT */
+	or	r9,r9,r11		/* r9 |= flags */
+
+	/* r9 = vsid_data, r10 = esid_data, cr7 = <>KERNELBASE */
+
+	/*
+	 * No need for an isync before or after this slbmte. The exception
+	 * we enter with and the rfid we exit with are context synchronizing.
+	 */
+	slbmte	r9,r10
+
+	bgelr	cr7			/* we're done for kernel addresses */
+
+	/* Update the slb cache */
+	lhz	r3,PACASLBCACHEPTR(r13)	/* offset = paca->slb_cache_ptr */
+	cmpldi	r3,SLB_CACHE_ENTRIES
+	bge	1f
+
+	/* still room in the slb cache */
+	sldi	r11,r3,1		/* r11 = offset * sizeof(u16) */
+	rldicl	r10,r10,36,28		/* get low 16 bits of the ESID */
+	add	r11,r11,r13		/* r11 = (u16 *)paca + offset */
+	sth	r10,PACASLBCACHE(r11)	/* paca->slb_cache[offset] = esid */
+	addi	r3,r3,1			/* offset++ */
+	b	2f
+1:					/* offset >= SLB_CACHE_ENTRIES */
+	li	r3,SLB_CACHE_ENTRIES+1
+2:
+	sth	r3,PACASLBCACHEPTR(r13)	/* paca->slb_cache_ptr = offset */
+	blr
+
+8:	/* invalid EA */
+	li	r9,0			/* 0 VSID ordinal -> BAD_VSID */
+	li	r11,SLB_VSID_USER	/* flags don't much matter */
+	b	7b
diff -urN linux-2.5/include/asm-ppc64/mmu.h g5-ppc64/include/asm-ppc64/mmu.h
--- linux-2.5/include/asm-ppc64/mmu.h	2004-07-05 11:49:20.000000000 +1000
+++ g5-ppc64/include/asm-ppc64/mmu.h	2004-08-02 13:02:44.000000000 +1000
@@ -37,12 +37,6 @@
 		mm_context_t ctx = { .id = REGION_ID(ea), KERNEL_LOW_HPAGES}; \
 		ctx; })
 
-/*
- * Hardware Segment Lookaside Buffer Entry
- * This structure has been padded out to two 64b doublewords (actual SLBE's are
- * 94 bits).  This padding facilites use by the segment management
- * instructions.
- */
 typedef struct {
 	unsigned long esid: 36; /* Effective segment ID */
 	unsigned long resv0:20; /* Reserved */
@@ -71,35 +65,6 @@
 	} dw1;
 } STE;
 
-typedef struct {
-	unsigned long esid: 36; /* Effective segment ID */
-	unsigned long v:     1; /* Entry valid (v=1) or invalid */
-	unsigned long null1:15; /* padding to a 64b boundary */
-	unsigned long index:12; /* Index to select SLB entry. Used by slbmte */
-} slb_dword0;
-
-typedef struct {
-	unsigned long vsid: 52; /* Virtual segment ID */
-	unsigned long ks:    1; /* Supervisor (privileged) state storage key */
-	unsigned long kp:    1; /* Problem state storage key */
-	unsigned long n:     1; /* No-execute if n=1 */
-	unsigned long l:     1; /* Virt pages are large (l=1) or 4KB (l=0) */
-	unsigned long c:     1; /* Class */
-	unsigned long resv0: 7; /* Padding to a 64b boundary */
-} slb_dword1;
-
-typedef struct {
-	union {
-		unsigned long dword0;
-		slb_dword0    dw0;
-	} dw0;
-
-	union {
-		unsigned long dword1;
-		slb_dword1    dw1;
-	} dw1;
-} SLBE;
-
 /* Hardware Page Table Entry */
 
 #define HPTES_PER_GROUP 8
@@ -259,6 +224,30 @@
 #define STAB0_PHYS_ADDR	(STAB0_PAGE<<PAGE_SHIFT)
 #define STAB0_VIRT_ADDR	(KERNELBASE+STAB0_PHYS_ADDR)
 
+#define SLB_NUM_BOLTED		2
+#define SLB_CACHE_ENTRIES	8
+
+/* Bits in the SLB ESID word */
+#define SLB_ESID_V		0x0000000008000000	/* entry is valid */
+
+/* Bits in the SLB VSID word */
+#define SLB_VSID_SHIFT		12
+#define SLB_VSID_KS		0x0000000000000800
+#define SLB_VSID_KP		0x0000000000000400
+#define SLB_VSID_N		0x0000000000000200	/* no-execute */
+#define SLB_VSID_L		0x0000000000000100	/* largepage (4M) */
+#define SLB_VSID_C		0x0000000000000080	/* class */
+
+#define SLB_VSID_KERNEL		(SLB_VSID_KP|SLB_VSID_C)
+#define SLB_VSID_USER		(SLB_VSID_KP|SLB_VSID_KS)
+
+#define VSID_RANDOMIZER ASM_CONST(42470972311)
+#define VSID_MASK	0xfffffffffUL
+/* Because we never access addresses below KERNELBASE as kernel
+ * addresses, this VSID is never used for anything real, and will
+ * never have pages hashed into it */
+#define BAD_VSID	ASM_CONST(0)
+
 /* Block size masks */
 #define BL_128K	0x000
 #define BL_256K 0x001
diff -urN linux-2.5/include/asm-ppc64/mmu_context.h g5-ppc64/include/asm-ppc64/mmu_context.h
--- linux-2.5/include/asm-ppc64/mmu_context.h	2004-06-04 07:19:01.000000000 +1000
+++ g5-ppc64/include/asm-ppc64/mmu_context.h	2004-08-02 13:02:44.000000000 +1000
@@ -136,7 +136,7 @@
 }
 
 extern void flush_stab(struct task_struct *tsk, struct mm_struct *mm);
-extern void flush_slb(struct task_struct *tsk, struct mm_struct *mm);
+extern void switch_slb(struct task_struct *tsk, struct mm_struct *mm);
 
 /*
  * switch_mm is the entry point called from the architecture independent
@@ -161,7 +161,7 @@
 		return;
 
 	if (cur_cpu_spec->cpu_features & CPU_FTR_SLB)
-		flush_slb(tsk, next);
+		switch_slb(tsk, next);
 	else
 		flush_stab(tsk, next);
 }
@@ -181,10 +181,6 @@
 	local_irq_restore(flags);
 }
 
-#define VSID_RANDOMIZER 42470972311UL
-#define VSID_MASK	0xfffffffffUL
-
-
 /* This is only valid for kernel (including vmalloc, imalloc and bolted) EA's
  */
 static inline unsigned long
diff -urN linux-2.5/include/asm-ppc64/paca.h g5-ppc64/include/asm-ppc64/paca.h
--- linux-2.5/include/asm-ppc64/paca.h	2004-07-05 11:49:20.000000000 +1000
+++ g5-ppc64/include/asm-ppc64/paca.h	2004-08-02 13:02:49.000000000 +1000
@@ -78,20 +78,26 @@
 	u64 exmc[8];		/* used for machine checks */
 	u64 exslb[8];		/* used for SLB/segment table misses
 				 * on the linear mapping */
-	u64 exdsi[8];		/* used for linear mapping hash table misses */
+	u64 slb_r3;		/* spot to save R3 on SLB miss */
+	mm_context_t context;
+	u16 slb_cache[SLB_CACHE_ENTRIES];
+	u16 slb_cache_ptr;
 
 	/*
 	 * then miscellaneous read-write fields
 	 */
 	struct task_struct *__current;	/* Pointer to current */
 	u64 kstack;			/* Saved Kernel stack addr */
-	u64 stab_next_rr;		/* stab/slb round-robin counter */
+	u64 stab_rr;			/* stab/slb round-robin counter */
 	u64 next_jiffy_update_tb;	/* TB value for next jiffy update */
 	u64 saved_r1;			/* r1 save for RTAS calls */
 	u64 saved_msr;			/* MSR saved here by enter_rtas */
 	u32 lpevent_count;		/* lpevents processed  */
 	u8 proc_enabled;		/* irq soft-enable flag */
 
+	/* not yet used */
+	u64 exdsi[8];		/* used for linear mapping hash table misses */
+
 	/*
 	 * iSeries structues which the hypervisor knows about - Not
 	 * sure if these particularly need to be cacheline aligned.
diff -urN linux-2.5/include/asm-ppc64/page.h g5-ppc64/include/asm-ppc64/page.h
--- linux-2.5/include/asm-ppc64/page.h	2004-05-31 19:02:01.000000000 +1000
+++ g5-ppc64/include/asm-ppc64/page.h	2004-08-02 13:02:44.000000000 +1000
@@ -27,6 +27,7 @@
 
 #define SID_SHIFT       28
 #define SID_MASK        0xfffffffffUL
+#define ESID_MASK	0xfffffffff0000000UL
 #define GET_ESID(x)     (((x) >> SID_SHIFT) & SID_MASK)
 
 #ifdef CONFIG_HUGETLB_PAGE
@@ -37,8 +38,8 @@
 #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
 
 /* For 64-bit processes the hugepage range is 1T-1.5T */
-#define TASK_HPAGE_BASE 	(0x0000010000000000UL)
-#define TASK_HPAGE_END 	(0x0000018000000000UL)
+#define TASK_HPAGE_BASE ASM_CONST(0x0000010000000000)
+#define TASK_HPAGE_END 	ASM_CONST(0x0000018000000000)
 
 #define LOW_ESID_MASK(addr, len)	(((1U << (GET_ESID(addr+len-1)+1)) \
 	   	                	- (1U << GET_ESID(addr))) & 0xffff)
