Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265910AbUIMEYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265910AbUIMEYh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 00:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265930AbUIMEYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 00:24:37 -0400
Received: from ozlabs.org ([203.10.76.45]:16797 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265910AbUIMEXy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 00:23:54 -0400
Date: Mon, 13 Sep 2004 14:11:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PPC64] Improved VSID allocation algorithm
Message-ID: <20040913041119.GA5351@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
	Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply.  This patch has been tested both on SLB and
segment table machines.  This new approach is far from the final word
in VSID/context allocation, but it's a noticeable improvement on the
old method.

Replace the VSID allocation algorithm.  The new algorithm first
generates a 36-bit "proto-VSID" (with 0xfffffffff reserved).  For
kernel addresses this is equal to the ESID (address >> 28), for user
addresses it is:
	(context << 15) | (esid & 0x7fff)

These are distinguishable from kernel proto-VSIDs because the top bit
is clear.  Proto-VSIDs with the top two bits equal to 0b10 are
reserved for now.

The proto-VSIDs are then scrambled into real VSIDs with the
multiplicative hash:
	VSID = (proto-VSID * VSID_MULTIPLIER) % VSID_MODULUS
	where	VSID_MULTIPLIER = 268435399 = 0xFFFFFC7
		VSID_MODULUS = 2^36-1 = 0xFFFFFFFFF

This scramble is 1:1, because VSID_MULTIPLIER and VSID_MODULUS are
co-prime since VSID_MULTIPLIER is prime (the largest 28-bit prime, in
fact).

This scheme has a number of advantages over the old one:
	- We now have VSIDs for every kernel address (i.e. everything
above 0xC000000000000000), except the very top segment.  That
simplifies a number of things.
	- We allow for 15 significant bits of ESID for user addresses
with 20 bits of context.  i.e. 8T (43 bits) of address space for up to
1M contexts, significantly more than the old method (although we will
need changes in the hash path and context allocation to take advantage
of this).
	- Because we use a real multiplicative hash function, we have
better and more robust hash scattering with this VSID algorithm (at
least based on some initial results).

Because the MODULUS is 2^n-1 we can use a trick to compute it
efficiently without a divide or extra multiply.  This makes the new
algorithm barely slower than the old one.

Index: working-2.6/include/asm-ppc64/mmu_context.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/mmu_context.h	2004-08-25 10:37:27.000000000 +1000
+++ working-2.6/include/asm-ppc64/mmu_context.h	2004-09-09 16:18:05.847490304 +1000
@@ -34,7 +34,7 @@
 }
 
 #define NO_CONTEXT		0
-#define FIRST_USER_CONTEXT	0x10    /* First 16 reserved for kernel */
+#define FIRST_USER_CONTEXT	1
 #define LAST_USER_CONTEXT	0x8000  /* Same as PID_MAX for now... */
 #define NUM_USER_CONTEXT	(LAST_USER_CONTEXT-FIRST_USER_CONTEXT)
 
@@ -181,46 +181,87 @@
 	local_irq_restore(flags);
 }
 
-/* This is only valid for kernel (including vmalloc, imalloc and bolted) EA's
+/* VSID allocation
+ * ===============
+ *
+ * We first generate a 36-bit "proto-VSID".  For kernel addresses this
+ * is equal to the ESID, for user addresses it is:
+ *	(context << 15) | (esid & 0x7fff)
+ *
+ * The two forms are distinguishable because the top bit is 0 for user
+ * addresses, whereas the top two bits are 1 for kernel addresses.
+ * Proto-VSIDs with the top two bits equal to 0b10 are reserved for
+ * now.
+ *
+ * The proto-VSIDs are then scrambled into real VSIDs with the
+ * multiplicative hash:
+ *
+ *	VSID = (proto-VSID * VSID_MULTIPLIER) % VSID_MODULUS
+ *	where	VSID_MULTIPLIER = 268435399 = 0xFFFFFC7
+ *		VSID_MODULUS = 2^36-1 = 0xFFFFFFFFF
+ *
+ * This scramble is only well defined for proto-VSIDs below
+ * 0xFFFFFFFFF, so both proto-VSID and actual VSID 0xFFFFFFFFF are
+ * reserved.  VSID_MULTIPLIER is prime (the largest 28-bit prime, in
+ * fact), so in particular it is co-prime to VSID_MODULUS, making this
+ * a 1:1 scrambling function.  Because the modulus is 2^n-1 we can
+ * compute it efficiently without a divide or extra multiply (see
+ * below).
+ *
+ * This scheme has several advantages over older methods:
+ *
+ * 	- We have VSIDs allocated for every kernel address
+ * (i.e. everything above 0xC000000000000000), except the very top
+ * segment, which simplifies several things.
+ *
+ * 	- We allow for 15 significant bits of ESID and 20 bits of
+ * context for user addresses.  i.e. 8T (43 bits) of address space for
+ * up to 1M contexts (although the page table structure and context
+ * allocation will need changes to take advantage of this).
+ *
+ * 	- The scramble function gives robust scattering in the hash
+ * table (at least based on some initial results).  The previous
+ * method was more susceptible to pathological cases giving excessive
+ * hash collisions.
  */
-static inline unsigned long
-get_kernel_vsid( unsigned long ea )
-{
-	unsigned long ordinal, vsid;
-	
-	ordinal = (((ea >> 28) & 0x1fff) * LAST_USER_CONTEXT) | (ea >> 60);
-	vsid = (ordinal * VSID_RANDOMIZER) & VSID_MASK;
-
-#ifdef HTABSTRESS
-	/* For debug, this path creates a very poor vsid distribuition.
-	 * A user program can access virtual addresses in the form
-	 * 0x0yyyyxxxx000 where yyyy = xxxx to cause multiple mappings
-	 * to hash to the same page table group.
-	 */
-	ordinal = ((ea >> 28) & 0x1fff) | (ea >> 44);
-	vsid = ordinal & VSID_MASK;
-#endif /* HTABSTRESS */
 
-	return vsid;
-} 
+/*
+ * WARNING - If you change these you must make sure the asm
+ * implementations in slb_allocate(), do_stab_bolted and mmu.h
+ * (ASM_VSID_SCRAMBLE macro) are changed accordingly.
+ *
+ * You'll also need to change the precomputed VSID values in head.S
+ * which are used by the iSeries firmware.
+ */
+
+static inline unsigned long vsid_scramble(unsigned long protovsid)
+{
+#if 0
+	/* The code below is equivalent to this function for arguments
+	 * < 2^VSID_BITS, which is all this should ever be called
+	 * with.  However gcc is not clever enough to compute the
+	 * modulus (2^n-1) without a second multiply. */
+	return ((protovsid * VSID_MULTIPLIER) % VSID_MODULUS);
+#else /* 1 */
+	unsigned long x;
+
+	x = protovsid * VSID_MULTIPLIER;
+	x = (x >> VSID_BITS) + (x & VSID_MODULUS);
+	return (x + ((x+1) >> VSID_BITS)) & VSID_MODULUS;
+#endif /* 1 */
+}
 
-/* This is only valid for user EA's (user EA's do not exceed 2^41 (EADDR_SIZE))
- */
-static inline unsigned long
-get_vsid( unsigned long context, unsigned long ea )
+/* This is only valid for addresses >= KERNELBASE */
+static inline unsigned long get_kernel_vsid(unsigned long ea)
 {
-	unsigned long ordinal, vsid;
-
-	ordinal = (((ea >> 28) & 0x1fff) * LAST_USER_CONTEXT) | context;
-	vsid = (ordinal * VSID_RANDOMIZER) & VSID_MASK;
-
-#ifdef HTABSTRESS
-	/* See comment above. */
-	ordinal = ((ea >> 28) & 0x1fff) | (context << 16);
-	vsid = ordinal & VSID_MASK;
-#endif /* HTABSTRESS */
+	return vsid_scramble(ea >> SID_SHIFT);
+} 
 
-	return vsid;
+/* This is only valid for user addresses (which are below 2^41) */
+static inline unsigned long get_vsid(unsigned long context, unsigned long ea)
+{
+	return vsid_scramble((context << USER_ESID_BITS)
+			     | (ea >> SID_SHIFT));
 }
 
 #endif /* __PPC64_MMU_CONTEXT_H */
Index: working-2.6/include/asm-ppc64/mmu.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/mmu.h	2004-09-07 10:38:00.000000000 +1000
+++ working-2.6/include/asm-ppc64/mmu.h	2004-09-09 15:04:16.814447984 +1000
@@ -15,6 +15,7 @@
 
 #include <linux/config.h>
 #include <asm/page.h>
+#include <linux/stringify.h>
 
 #ifndef __ASSEMBLY__
 
@@ -215,12 +216,44 @@
 #define SLB_VSID_KERNEL		(SLB_VSID_KP|SLB_VSID_C)
 #define SLB_VSID_USER		(SLB_VSID_KP|SLB_VSID_KS)
 
-#define VSID_RANDOMIZER ASM_CONST(42470972311)
-#define VSID_MASK	0xfffffffffUL
-/* Because we never access addresses below KERNELBASE as kernel
- * addresses, this VSID is never used for anything real, and will
- * never have pages hashed into it */
-#define BAD_VSID	ASM_CONST(0)
+#define VSID_MULTIPLIER	ASM_CONST(268435399)	/* largest 28-bit prime */
+#define VSID_BITS	36
+#define VSID_MODULUS	((1UL<<VSID_BITS)-1)
+
+#define CONTEXT_BITS	20
+#define USER_ESID_BITS	15
+
+/*
+ * This macro generates asm code to compute the VSID scramble
+ * function.  Used in slb_allocate() and do_stab_bolted.  The function
+ * computed is: (protovsid*VSID_MULTIPLIER) % VSID_MODULUS
+ *
+ *	rt = register continaing the proto-VSID and into which the
+ *		VSID will be stored
+ *	rx = scratch register (clobbered)
+ *
+ * 	- rt and rx must be different registers
+ * 	- The answer will end up in the low 36 bits of rt.  The higher
+ * 	  bits may contain other garbage, so you may need to mask the
+ * 	  result. 
+ */
+#define ASM_VSID_SCRAMBLE(rt, rx)	\
+	lis	rx,VSID_MULTIPLIER@h;					\
+	ori	rx,rx,VSID_MULTIPLIER@l;				\
+	mulld	rt,rt,rx;		/* rt = rt * MULTIPLIER */	\
+									\
+	srdi	rx,rt,VSID_BITS;					\
+	clrldi	rt,rt,(64-VSID_BITS);					\
+	add	rt,rt,rx;		/* add high and low bits */	\
+	/* Now, r3 == VSID (mod 2^36-1), and lies between 0 and		\
+	 * 2^36-1+2^28-1.  That in particular means that if r3 >=	\
+	 * 2^36-1, then r3+1 has the 2^36 bit set.  So, if r3+1 has	\
+	 * the bit clear, r3 already has the answer we want, if it	\
+	 * doesn't, the answer is the low 36 bits of r3+1.  So in all	\
+	 * cases the answer is the low 36 bits of (r3 + ((r3+1) >> 36))*/\
+	addi	rx,rt,1;						\
+	srdi	rx,rx,VSID_BITS;	/* extract 2^36 bit */		\
+	add	rt,rt,rx
 
 /* Block size masks */
 #define BL_128K	0x000
Index: working-2.6/arch/ppc64/mm/slb_low.S
===================================================================
--- working-2.6.orig/arch/ppc64/mm/slb_low.S	2004-09-07 10:38:00.000000000 +1000
+++ working-2.6/arch/ppc64/mm/slb_low.S	2004-09-09 15:04:16.815447832 +1000
@@ -68,19 +68,19 @@
 	srdi	r3,r3,28		/* get esid */
 	cmpldi	cr7,r9,0xc		/* cmp KERNELBASE for later use */
 
-	/* r9 = region, r3 = esid, cr7 = <>KERNELBASE */
-
-	rldicr.	r11,r3,32,16
-	bne-	8f			/* invalid ea bits set */
-	addi	r11,r9,-1
-	cmpldi	r11,0xb
-	blt-	8f			/* invalid region */
+	rldimi	r10,r3,28,0		/* r10= ESID<<28 | entry */
+	oris	r10,r10,SLB_ESID_V@h	/* r10 |= SLB_ESID_V */
 
-	/* r9 = region, r3 = esid, r10 = entry, cr7 = <>KERNELBASE */
+	/* r3 = esid, r10 = esid_data, cr7 = <>KERNELBASE */
 
 	blt	cr7,0f			/* user or kernel? */
 
-	/* kernel address */
+	/* kernel address: proto-VSID = ESID */
+	/* WARNING - MAGIC: we don't use the VSID 0xfffffffff, but
+	 * this code will generate the protoVSID 0xfffffffff for the
+	 * top segment.  That's ok, the scramble below will translate
+	 * it to VSID 0, which is reserved as a bad VSID - one which
+	 * will never have any pages in it.  */
 	li	r11,SLB_VSID_KERNEL
 BEGIN_FTR_SECTION
 	bne	cr7,9f
@@ -88,8 +88,12 @@
 END_FTR_SECTION_IFSET(CPU_FTR_16M_PAGE)
 	b	9f
 
-0:	/* user address */
+0:	/* user address: proto-VSID = context<<15 | ESID */
 	li	r11,SLB_VSID_USER
+
+	srdi.	r9,r3,13
+	bne-	8f			/* invalid ea bits set */
+
 #ifdef CONFIG_HUGETLB_PAGE
 BEGIN_FTR_SECTION
 	/* check against the hugepage ranges */
@@ -111,33 +115,18 @@
 #endif /* CONFIG_HUGETLB_PAGE */
 
 6:	ld	r9,PACACONTEXTID(r13)
+	rldimi	r3,r9,USER_ESID_BITS,0
 
-9:	/* r9 = "context", r3 = esid, r11 = flags, r10 = entry */
-
-	rldimi	r9,r3,15,0		/* r9= VSID ordinal */
-
-7:	rldimi	r10,r3,28,0		/* r10= ESID<<28 | entry */
-	oris	r10,r10,SLB_ESID_V@h	/* r10 |= SLB_ESID_V */
-
-	/* r9 = ordinal, r3 = esid, r11 = flags, r10 = esid_data */
-
-	li	r3,VSID_RANDOMIZER@higher
-	sldi	r3,r3,32
-	oris	r3,r3,VSID_RANDOMIZER@h
-	ori	r3,r3,VSID_RANDOMIZER@l
-
-	mulld	r9,r3,r9		/* r9 = ordinal * VSID_RANDOMIZER */
-	clrldi	r9,r9,28		/* r9 &= VSID_MASK */
-	sldi	r9,r9,SLB_VSID_SHIFT	/* r9 <<= SLB_VSID_SHIFT */
-	or	r9,r9,r11		/* r9 |= flags */
+9:	/* r3 = protovsid, r11 = flags, r10 = esid_data, cr7 = <>KERNELBASE */
+	ASM_VSID_SCRAMBLE(r3,r9)
 
-	/* r9 = vsid_data, r10 = esid_data, cr7 = <>KERNELBASE */
+	rldimi	r11,r3,SLB_VSID_SHIFT,16	/* combine VSID and flags */
 
 	/*
 	 * No need for an isync before or after this slbmte. The exception
 	 * we enter with and the rfid we exit with are context synchronizing.
 	 */
-	slbmte	r9,r10
+	slbmte	r11,r10
 
 	bgelr	cr7			/* we're done for kernel addresses */
 
@@ -160,6 +149,6 @@
 	blr
 
 8:	/* invalid EA */
-	li	r9,0			/* 0 VSID ordinal -> BAD_VSID */
+	li	r3,0			/* BAD_VSID */
 	li	r11,SLB_VSID_USER	/* flags don't much matter */
-	b	7b
+	b	9b
Index: working-2.6/arch/ppc64/kernel/head.S
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/head.S	2004-09-09 15:04:16.770454672 +1000
+++ working-2.6/arch/ppc64/kernel/head.S	2004-09-09 15:04:16.817447528 +1000
@@ -548,15 +548,15 @@
 	.llong	0		/* Reserved */
 	.llong	0		/* Reserved */
 	.llong	0		/* Reserved */
-	.llong	0xc00000000	/* KERNELBASE ESID */
-	.llong	0x6a99b4b14	/* KERNELBASE VSID */
+	.llong	(KERNELBASE>>SID_SHIFT)
+	.llong	0x40bffffd5	/* KERNELBASE VSID */
 	/* We have to list the bolted VMALLOC segment here, too, so that it
 	 * will be restored on shared processor switch */
-	.llong	0xd00000000	/* VMALLOCBASE ESID */
-	.llong	0x08d12e6ab	/* VMALLOCBASE VSID */
+	.llong	(VMALLOCBASE>>SID_SHIFT)
+	.llong	0xb0cffffd1	/* VMALLOCBASE VSID */
 	.llong	8192		/* # pages to map (32 MB) */
 	.llong	0		/* Offset from start of loadarea to start of map */
-	.llong	0x0006a99b4b140000	/* VPN of first page to map */
+	.llong	0x40bffffd50000	/* VPN of first page to map */
 
 	. = 0x6100
 
@@ -1064,18 +1064,9 @@
 	rldimi	r10,r11,7,52	/* r10 = first ste of the group */
 
 	/* Calculate VSID */
-	/* (((ea >> 28) & 0x1fff) << 15) | (ea >> 60) */
-	rldic	r11,r11,15,36
-	ori	r11,r11,0xc
-
-	/* VSID_RANDOMIZER */
-	li	r9,9
-	sldi	r9,r9,32
-	oris	r9,r9,58231
-	ori	r9,r9,39831
-
-	mulld	r9,r11,r9
-	rldic	r9,r9,12,16	/* r9 = vsid << 12 */
+	/* This is a kernel address, so protovsid = ESID */
+	ASM_VSID_SCRAMBLE(r11, r9)
+	rldic	r9,r11,12,16	/* r9 = vsid << 12 */
 
 	/* Search the primary group for a free entry */
 1:	ld	r11,0(r10)	/* Test valid bit of the current ste	*/
Index: working-2.6/arch/ppc64/mm/stab.c
===================================================================
--- working-2.6.orig/arch/ppc64/mm/stab.c	2004-08-25 10:37:26.000000000 +1000
+++ working-2.6/arch/ppc64/mm/stab.c	2004-09-09 15:04:16.818447376 +1000
@@ -115,15 +115,11 @@
 	unsigned char stab_entry;
 	unsigned long offset;
 
-	/* Check for invalid effective addresses. */
-	if (!IS_VALID_EA(ea))
-		return 1;
-
 	/* Kernel or user address? */
 	if (ea >= KERNELBASE) {
 		vsid = get_kernel_vsid(ea);
 	} else {
-		if (! mm)
+		if ((ea >= TASK_SIZE_USER64) || (! mm))
 			return 1;
 
 		vsid = get_vsid(mm->context.id, ea);
Index: working-2.6/include/asm-ppc64/pgtable.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/pgtable.h	2004-09-07 10:38:00.000000000 +1000
+++ working-2.6/include/asm-ppc64/pgtable.h	2004-09-09 15:29:13.949495840 +1000
@@ -45,10 +45,16 @@
                     PGD_INDEX_SIZE + PAGE_SHIFT) 
 
 /*
+ * Size of EA range mapped by our pagetables.
+ */
+#define PGTABLE_EA_BITS	41
+#define PGTABLE_EA_MASK	((1UL<<PGTABLE_EA_BITS)-1)
+
+/*
  * Define the address range of the vmalloc VM area.
  */
 #define VMALLOC_START (0xD000000000000000ul)
-#define VMALLOC_END   (VMALLOC_START + VALID_EA_BITS)
+#define VMALLOC_END   (VMALLOC_START + PGTABLE_EA_MASK)
 
 /*
  * Define the address range of the imalloc VM area.
@@ -58,19 +64,19 @@
 #define IMALLOC_VMADDR(x) ((unsigned long)(x))
 #define PHBS_IO_BASE  	  (0xE000000000000000ul)	/* Reserve 2 gigs for PHBs */
 #define IMALLOC_BASE      (0xE000000080000000ul)  
-#define IMALLOC_END       (IMALLOC_BASE + VALID_EA_BITS)
+#define IMALLOC_END       (IMALLOC_BASE + PGTABLE_EA_MASK)
 
 /*
  * Define the address range mapped virt <-> physical
  */
 #define KRANGE_START KERNELBASE
-#define KRANGE_END   (KRANGE_START + VALID_EA_BITS)
+#define KRANGE_END   (KRANGE_START + PGTABLE_EA_MASK)
 
 /*
  * Define the user address range
  */
 #define USER_START (0UL)
-#define USER_END   (USER_START + VALID_EA_BITS)
+#define USER_END   (USER_START + PGTABLE_EA_MASK)
 
 
 /*
Index: working-2.6/arch/ppc64/mm/hash_utils.c
===================================================================
--- working-2.6.orig/arch/ppc64/mm/hash_utils.c	2004-08-26 10:20:55.000000000 +1000
+++ working-2.6/arch/ppc64/mm/hash_utils.c	2004-09-09 15:04:16.820447072 +1000
@@ -253,24 +253,24 @@
 	int local = 0;
 	cpumask_t tmp;
 
-	/* Check for invalid addresses. */
-	if (!IS_VALID_EA(ea))
-		return 1;
-
  	switch (REGION_ID(ea)) {
 	case USER_REGION_ID:
 		user_region = 1;
 		mm = current->mm;
-		if (mm == NULL)
+		if ((ea > USER_END) || (! mm))
 			return 1;
 
 		vsid = get_vsid(mm->context.id, ea);
 		break;
 	case IO_REGION_ID:
+		if (ea > IMALLOC_END)
+			return 1;
 		mm = &ioremap_mm;
 		vsid = get_kernel_vsid(ea);
 		break;
 	case VMALLOC_REGION_ID:
+		if (ea > VMALLOC_END)
+			return 1;
 		mm = &init_mm;
 		vsid = get_kernel_vsid(ea);
 		break;
Index: working-2.6/include/asm-ppc64/page.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/page.h	2004-09-07 10:38:00.000000000 +1000
+++ working-2.6/include/asm-ppc64/page.h	2004-09-09 15:04:16.820447072 +1000
@@ -212,17 +212,6 @@
 #define USER_REGION_ID     (0UL)
 #define REGION_ID(X)	   (((unsigned long)(X))>>REGION_SHIFT)
 
-/*
- * Define valid/invalid EA bits (for all ranges)
- */
-#define VALID_EA_BITS   (0x000001ffffffffffUL)
-#define INVALID_EA_BITS (~(REGION_MASK|VALID_EA_BITS))
-
-#define IS_VALID_REGION_ID(x) \
-        (((x) == USER_REGION_ID) || ((x) >= KERNEL_REGION_ID))
-#define IS_VALID_EA(x) \
-        ((!((x) & INVALID_EA_BITS)) && IS_VALID_REGION_ID(REGION_ID(x)))
-
 #define __bpn_to_ba(x) ((((unsigned long)(x))<<PAGE_SHIFT) + KERNELBASE)
 #define __ba_to_bpn(x) ((((unsigned long)(x)) & ~REGION_MASK) >> PAGE_SHIFT)
 


-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
