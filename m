Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267957AbUIAELQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267957AbUIAELQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 00:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268083AbUIAELQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 00:11:16 -0400
Received: from ozlabs.org ([203.10.76.45]:34527 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267957AbUIAEKy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 00:10:54 -0400
Date: Wed, 1 Sep 2004 13:59:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: [PPC64] Pin the kernel stack's SLB entry
Message-ID: <20040901035913.GE5292@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
	Paul Mackerras <paulus@samba.org>, linuxppc64-dev@lists.linuxppc.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply.  This has been given basic testing on Power4
pSeries and iSeries machines.

At present, the SLB miss handler has to check the SLB slot it is about
to use to ensure that it does not contain the SLBE for the current
kernel stack - throwing out the SLBE for the kernel stack can trigger
the "megabug": we have no SLBE for the stack, but we don't fault
immediately because we have an ERAT entry for it.  The ERAT entry is
then lost due to a tlbie on another CPU during the unrecoverable
section of the exception return path.

This patch implements a different approach - with this patch SLB slot
2 always (well, nearly always) contains an SLBE for the stack.  This
slot is never cast out by the normal SLB miss path.  On context
switch, an SLBE for the new stack is pinned into this slot, unless the
new stack is the the bolted segment.

For iSeries we need a special workaround because there is no way of
ensuring the stack SLBE is preserved an a shared processor switch.
So, we still need to handle taking an SLB miss on the stack, in which
case we must make sure it is loaded into slot 2, rather than using the
normal round-robin.

This approach shaves a few ns off the slb miss time (on pSeries), but
more importantly makes it easier to experiment with different SLB
castout aporoaches without worrying about reinstating the megabug.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/arch/ppc64/kernel/asm-offsets.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/asm-offsets.c	2004-08-30 10:22:59.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/asm-offsets.c	2004-09-01 13:45:36.406026800 +1000
@@ -58,6 +58,7 @@
 	DEFINE(THREAD_FPR0, offsetof(struct thread_struct, fpr[0]));
 	DEFINE(THREAD_FPSCR, offsetof(struct thread_struct, fpscr));
 	DEFINE(KSP, offsetof(struct thread_struct, ksp));
+	DEFINE(KSP_VSID, offsetof(struct thread_struct, ksp_vsid));
 
 #ifdef CONFIG_ALTIVEC
 	DEFINE(THREAD_VR0, offsetof(struct thread_struct, vr[0]));
Index: working-2.6/arch/ppc64/kernel/entry.S
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/entry.S	2004-08-09 09:51:38.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/entry.S	2004-09-01 13:45:36.407026648 +1000
@@ -393,9 +393,17 @@
 	cmpd	cr1,r6,r9	/* or is new ESID the same as current ESID? */
 	cror	eq,4*cr1+eq,eq
 	beq	2f		/* if yes, don't slbie it */
-	oris	r6,r6,0x0800	/* set C (class) bit */
-	slbie	r6
-	slbie	r6		/* Workaround POWER5 < DD2.1 issue */
+	oris	r0,r6,0x0800	/* set C (class) bit */
+
+	/* Bolt in the new stack SLB entry */
+	ld	r7,KSP_VSID(r4)	/* Get new stack's VSID */
+	oris	r6,r6,(SLB_ESID_V)@h
+	ori	r6,r6,(SLB_NUM_BOLTED-1)@l
+	slbie	r0
+	slbie	r0		/* Workaround POWER5 < DD2.1 issue */
+	slbmte	r7,r6
+	isync
+
 2:
 END_FTR_SECTION_IFSET(CPU_FTR_SLB)
 	clrrdi	r7,r8,THREAD_SHIFT	/* base of new stack */
Index: working-2.6/arch/ppc64/kernel/process.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/process.c	2004-08-25 10:37:26.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/process.c	2004-09-01 13:45:36.408026496 +1000
@@ -356,6 +356,16 @@
 	kregs = (struct pt_regs *) sp;
 	sp -= STACK_FRAME_OVERHEAD;
 	p->thread.ksp = sp;
+	if (cur_cpu_spec->cpu_features & CPU_FTR_SLB) {
+		unsigned long sp_vsid = get_kernel_vsid(sp);
+
+		sp_vsid <<= SLB_VSID_SHIFT;
+		sp_vsid |= SLB_VSID_KERNEL;
+		if (cur_cpu_spec->cpu_features & CPU_FTR_16M_PAGE)
+			sp_vsid |= SLB_VSID_L;
+
+		p->thread.ksp_vsid = sp_vsid;
+	}
 
 	/*
 	 * The PPC64 ABI makes use of a TOC to contain function 
Index: working-2.6/arch/ppc64/mm/slb.c
===================================================================
--- working-2.6.orig/arch/ppc64/mm/slb.c	2004-08-24 10:47:11.000000000 +1000
+++ working-2.6/arch/ppc64/mm/slb.c	2004-09-01 13:45:36.409026344 +1000
@@ -24,30 +24,55 @@
 
 extern void slb_allocate(unsigned long ea);
 
+static inline unsigned long mk_esid_data(unsigned long ea, unsigned long slot)
+{
+	return (ea & ESID_MASK) | SLB_ESID_V | slot;
+}
+
+static inline unsigned long mk_vsid_data(unsigned long ea, unsigned long flags)
+{
+	return (get_kernel_vsid(ea) << SLB_VSID_SHIFT) | flags;
+}
+
 static inline void create_slbe(unsigned long ea, unsigned long vsid,
 			       unsigned long flags, unsigned long entry)
 {
-	ea = (ea & ESID_MASK) | SLB_ESID_V | entry;
-	vsid = (vsid << SLB_VSID_SHIFT) | flags;
 	asm volatile("slbmte  %0,%1" :
-		     : "r" (vsid), "r" (ea)
+		     : "r" (mk_vsid_data(ea, flags)),
+		       "r" (mk_esid_data(ea, entry))
 		     : "memory" );
 }
 
-static void slb_add_bolted(void)
+static void slb_flush_and_rebolt(void)
 {
-	WARN_ON(!irqs_disabled());
-
 	/* If you change this make sure you change SLB_NUM_BOLTED
-	 * appropriately too */
+	 * appropriately too. */
+	unsigned long ksp_flags = SLB_VSID_KERNEL;
+	unsigned long ksp_esid_data;
 
-	/* Slot 1 - first VMALLOC segment
-         * 	Since modules end up there it gets hit very heavily.
-         */
-	create_slbe(VMALLOCBASE, get_kernel_vsid(VMALLOCBASE),
-		    SLB_VSID_KERNEL, 1);
+	WARN_ON(!irqs_disabled());
 
-	asm volatile("isync":::"memory");
+	if (cur_cpu_spec->cpu_features & CPU_FTR_16M_PAGE)
+		ksp_flags |= SLB_VSID_L;
+
+	ksp_esid_data = mk_esid_data(get_paca()->kstack, 2);
+	if ((ksp_esid_data & ESID_MASK) == KERNELBASE)
+		ksp_esid_data &= ~SLB_ESID_V;
+
+	/* We need to do this all in asm, so we're sure we don't touch
+	 * the stack between the slbia and rebolting it. */
+	asm volatile("isync\n"
+		     "slbia\n"
+		     /* Slot 1 - first VMALLOC segment */
+		     "slbmte	%0,%1\n"
+		     /* Slot 2 - kernel stack */
+		     "slbmte	%2,%3\n"
+		     "isync"
+		     :: "r"(mk_vsid_data(VMALLOCBASE, SLB_VSID_KERNEL)),
+		        "r"(mk_esid_data(VMALLOCBASE, 1)),
+		        "r"(mk_vsid_data(ksp_esid_data, ksp_flags)), 
+		        "r"(ksp_esid_data)
+		     : "memory");
 }
 
 /* Flush all user entries from the segment table of the current processor. */
@@ -69,8 +94,7 @@
 		}
 		asm volatile("isync" : : : "memory");
 	} else {
-		asm volatile("isync; slbia; isync" : : : "memory");
-		slb_add_bolted();
+		slb_flush_and_rebolt();
 	}
 
 	/* Workaround POWER5 < DD2.1 issue */
@@ -113,22 +137,27 @@
 
 void slb_initialize(void)
 {
-#ifdef CONFIG_PPC_ISERIES
-	asm volatile("isync; slbia; isync":::"memory");
-#else
+	/* On iSeries the bolted entries have already been set up by
+	 * the hypervisor from the lparMap data in head.S */
+#ifndef CONFIG_PPC_ISERIES
 	unsigned long flags = SLB_VSID_KERNEL;
 
-	/* Invalidate the entire SLB (even slot 0) & all the ERATS */
-	if (cur_cpu_spec->cpu_features & CPU_FTR_16M_PAGE)
-		flags |= SLB_VSID_L;
-
-	asm volatile("isync":::"memory");
-	asm volatile("slbmte  %0,%0"::"r" (0) : "memory");
+ 	/* Invalidate the entire SLB (even slot 0) & all the ERATS */
+ 	if (cur_cpu_spec->cpu_features & CPU_FTR_16M_PAGE)
+ 		flags |= SLB_VSID_L;
+ 	
+ 	asm volatile("isync":::"memory");
+ 	asm volatile("slbmte  %0,%0"::"r" (0) : "memory");
 	asm volatile("isync; slbia; isync":::"memory");
-	create_slbe(KERNELBASE, get_kernel_vsid(KERNELBASE),
-		    flags, 0);
-
+	create_slbe(KERNELBASE, get_kernel_vsid(KERNELBASE), flags, 0);
+	create_slbe(VMALLOCBASE, get_kernel_vsid(KERNELBASE),
+		    SLB_VSID_KERNEL, 1);
+	/* We don't bolt the stack for the time being - we're in boot,
+	 * so the stack is in the bolted segment.  By the time it goes
+	 * elsewhere, we'll call _switch() which will bolt in the new
+	 * one. */
+	asm volatile("isync":::"memory");
 #endif
-	slb_add_bolted();
+
 	get_paca()->stab_rr = SLB_NUM_BOLTED;
 }
Index: working-2.6/arch/ppc64/mm/slb_low.S
===================================================================
--- working-2.6.orig/arch/ppc64/mm/slb_low.S	2004-08-10 11:14:24.000000000 +1000
+++ working-2.6/arch/ppc64/mm/slb_low.S	2004-09-01 13:45:36.409026344 +1000
@@ -37,8 +37,21 @@
 	 * a free slot first but that took too long. Unfortunately we
 	 * dont have any LRU information to help us choose a slot.
 	 */
+#ifdef CONFIG_PPC_ISERIES
+	/*
+	 * On iSeries, the "bolted" stack segment can be cast out on
+	 * shared processor switch so we need to check for a miss on
+	 * it and restore it to the right slot.
+	 */
+	ld	r9,PACAKSAVE(r13)
+	clrrdi	r9,r9,28
+	clrrdi	r11,r3,28
+	li	r10,SLB_NUM_BOLTED-1	/* Stack goes in last bolted slot */
+	cmpld	r9,r11
+	beq	3f
+#endif /* CONFIG_PPC_ISERIES */
+
 	ld	r10,PACASTABRR(r13)
-3:
 	addi	r10,r10,1
 	/* use a cpu feature mask if we ever change our slb size */
 	cmpldi	r10,SLB_NUM_ENTRIES
@@ -46,36 +59,9 @@
 	blt+	4f
 	li	r10,SLB_NUM_BOLTED
 
-	/*
-	 * Never cast out the segment for our kernel stack. Since we
-	 * dont invalidate the ERAT we could have a valid translation
-	 * for the kernel stack during the first part of exception exit
-	 * which gets invalidated due to a tlbie from another cpu at a
-	 * non recoverable point (after setting srr0/1) - Anton
-	 */
-4:	slbmfee	r11,r10
-	srdi	r11,r11,27
-	/*
-	 * Use paca->ksave as the value of the kernel stack pointer,
-	 * because this is valid at all times.
-	 * The >> 27 (rather than >> 28) is so that the LSB is the
-	 * valid bit - this way we check valid and ESID in one compare.
-	 * In order to completely close the tiny race in the context
-	 * switch (between updating r1 and updating paca->ksave),
-	 * we check against both r1 and paca->ksave.
-	 */
-	srdi	r9,r1,27
-	ori	r9,r9,1			/* mangle SP for later compare */
-	cmpd	r11,r9
-	beq-	3b
-	ld	r9,PACAKSAVE(r13)
-	srdi	r9,r9,27
-	ori	r9,r9,1
-	cmpd	r11,r9
-	beq-	3b
-
+4:
 	std	r10,PACASTABRR(r13)
-
+3:
 	/* r3 = faulting address, r10 = entry */
 
 	srdi	r9,r3,60		/* get region */
Index: working-2.6/include/asm-ppc64/mmu.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/mmu.h	2004-08-30 10:23:00.000000000 +1000
+++ working-2.6/include/asm-ppc64/mmu.h	2004-09-01 13:45:36.410026192 +1000
@@ -198,7 +198,7 @@
 #define STAB0_PHYS_ADDR	(STAB0_PAGE<<PAGE_SHIFT)
 #define STAB0_VIRT_ADDR	(KERNELBASE+STAB0_PHYS_ADDR)
 
-#define SLB_NUM_BOLTED		2
+#define SLB_NUM_BOLTED		3
 #define SLB_CACHE_ENTRIES	8
 
 /* Bits in the SLB ESID word */
Index: working-2.6/include/asm-ppc64/processor.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/processor.h	2004-08-25 10:37:27.000000000 +1000
+++ working-2.6/include/asm-ppc64/processor.h	2004-09-01 13:45:36.411026040 +1000
@@ -538,6 +538,7 @@
 
 struct thread_struct {
 	unsigned long	ksp;		/* Kernel stack pointer */
+	unsigned long	ksp_vsid;
 	struct pt_regs	*regs;		/* Pointer to saved register state */
 	mm_segment_t	fs;		/* for get_fs() validation */
 	double		fpr[32];	/* Complete floating point set */


-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
