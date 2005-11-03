Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750886AbVKCF0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbVKCF0s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 00:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbVKCF0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 00:26:48 -0500
Received: from ozlabs.org ([203.10.76.45]:26055 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750758AbVKCF0r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 00:26:47 -0500
Date: Thu, 3 Nov 2005 16:26:34 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: ppc64: Fix bug in SLB miss handler for hugepages
Message-ID: <20051103052634.GD24772@localhost.localdomain>
Mail-Followup-To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Andrew Morton <akpm@osdl.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <1130915220.20136.14.camel@gaston> <1130916198.20136.17.camel@gaston> <17257.33037.210237.986072@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17257.33037.210237.986072@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2005 at 02:16:29PM +1100, Paul Mackerras wrote:
> Benjamin Herrenschmidt writes:
> 
> > It took a while, but finally, here is the 64K pages support patch for
> > ppc64. This patch adds a new CONFIG_PPC_64K_PAGES which, when enabled,
> > changes the kernel base page size to 64K. The resulting kernel still
> > boots on any hardware. On current machines with 4K pages support only,
> > the kernel will maintain 16 "subpages" for each 64K page
> > transparently.
> > 
> > Note that while real 64K capable HW has been tested, the current patch
> > will not enable it yet as such hardware is not released yet, and I'm
> > still verifying with the firmware architects the proper to get the
> > information from the newer hypervisors.
> > 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Acked-by: Paul Mackerras <paulus@samba.org>

This patch, however, should be applied on top to fix some problems
with hugepage (some pre-existing, another introduced by this patch).

The patch fixes a bug in the SLB miss handler for hugepages on ppc64
introduced by the dynamic hugepage patch (commit id
c594adad5653491813959277fb87a2fef54c4e05) due to a misunderstanding of
the srd instruction's behaviour (mea culpa).  The problem arises when
a 64-bit process maps some hugepages in the low 4GB of the address
space (unusual).  In this case, as well as the 256M segment in
question being marked for hugepages, other segments at 32G intervals
will be incorrectly marked for hugepages.

In the process, this patch tweaks the semantics of the hugepage
bitmaps to be more sensible.  Previously, an address below 4G was
marked for hugepages if the appropriate segment bit in the "low areas"
bitmask was set *or* if the low bit in the "high areas" bitmap was set
(which would mark all addresses below 1TB for hugepage).  With this
patch, any given address is governed by a single bitmap.  Addresses
below 4GB are marked for hugepage if and only if their bit is set in
the "low areas" bitmap (256M granularity).  Addresses between 4GB and
1TB are marked for hugepage iff the low bit in the "high areas" bitmap
is set.  Higher addresses are marked for hugepage iff their bit in the
"high areas" bitmap is set (1TB granularity).

To avoid conflicts, this patch must be applied on top of BenH's
pending patch for 64k base page size [0].  As such, this patch also
addresses a hugepage problem introduced by that patch.  That patch
allows hugepages of 1MB in size on hardware which supports it,
however, that won't work when using 4k pages (4 level pagetable),
because in that case hugepage PTEs are stored at the PMD level, and
each PMD entry maps 2MB.  This patch simply disallows hugepages in
that case (we can do something cleverer to re-enable them some other
day).

Built, booted, and a handful of hugepage related tests passed on
POWER5 LPAR (both ARCH=powerpc and ARCH=ppc64).

[0] http://gate.crashing.org/~benh/ppc64-64k-pages.diff

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/arch/powerpc/mm/slb_low.S
===================================================================
--- working-2.6.orig/arch/powerpc/mm/slb_low.S	2005-11-03 14:52:16.000000000 +1100
+++ working-2.6/arch/powerpc/mm/slb_low.S	2005-11-03 14:55:56.000000000 +1100
@@ -80,12 +80,17 @@
 BEGIN_FTR_SECTION
 	b	1f
 END_FTR_SECTION_IFCLR(CPU_FTR_16M_PAGE)
+	cmpldi	r10,16
+
+	lhz	r9,PACALOWHTLBAREAS(r13)
+	mr	r11,r10
+	blt	5f
+
 	lhz	r9,PACAHIGHHTLBAREAS(r13)
 	srdi	r11,r10,(HTLB_AREA_SHIFT-SID_SHIFT)
-	srd	r9,r9,r11
-	lhz	r11,PACALOWHTLBAREAS(r13)
-	srd	r11,r11,r10
-	or.	r9,r9,r11
+
+5:	srd	r9,r9,r11
+	andi.	r9,r9,1
 	beq	1f
 _GLOBAL(slb_miss_user_load_huge)
 	li	r11,0
Index: working-2.6/arch/powerpc/mm/hash_utils_64.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/hash_utils_64.c	2005-11-03 14:52:16.000000000 +1100
+++ working-2.6/arch/powerpc/mm/hash_utils_64.c	2005-11-03 15:40:56.000000000 +1100
@@ -329,12 +329,14 @@
 	 */
 	if (mmu_psize_defs[MMU_PAGE_16M].shift)
 		mmu_huge_psize = MMU_PAGE_16M;
+	/* With 4k/4level pagetables, we can't (for now) cope with a
+	 * huge page size < PMD_SIZE */
 	else if (mmu_psize_defs[MMU_PAGE_1M].shift)
 		mmu_huge_psize = MMU_PAGE_1M;
 
 	/* Calculate HPAGE_SHIFT and sanity check it */
-	if (mmu_psize_defs[mmu_huge_psize].shift > 16 &&
-	    mmu_psize_defs[mmu_huge_psize].shift < 28)
+	if (mmu_psize_defs[mmu_huge_psize].shift > MIN_HUGEPTE_SHIFT &&
+	    mmu_psize_defs[mmu_huge_psize].shift < SID_SHIFT)
 		HPAGE_SHIFT = mmu_psize_defs[mmu_huge_psize].shift;
 	else
 		HPAGE_SHIFT = 0; /* No huge pages dude ! */
Index: working-2.6/include/asm-ppc64/pgtable-4k.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/pgtable-4k.h	2005-11-03 14:52:16.000000000 +1100
+++ working-2.6/include/asm-ppc64/pgtable-4k.h	2005-11-03 15:38:40.000000000 +1100
@@ -23,6 +23,9 @@
 #define PMD_SIZE	(1UL << PMD_SHIFT)
 #define PMD_MASK	(~(PMD_SIZE-1))
 
+/* With 4k base page size, hugepage PTEs go at the PMD level */
+#define MIN_HUGEPTE_SHIFT	PMD_SHIFT
+
 /* PUD_SHIFT determines what a third-level page table entry can map */
 #define PUD_SHIFT	(PMD_SHIFT + PMD_INDEX_SIZE)
 #define PUD_SIZE	(1UL << PUD_SHIFT)
Index: working-2.6/include/asm-ppc64/pgtable-64k.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/pgtable-64k.h	2005-11-03 14:52:16.000000000 +1100
+++ working-2.6/include/asm-ppc64/pgtable-64k.h	2005-11-03 15:39:07.000000000 +1100
@@ -14,6 +14,9 @@
 #define PTRS_PER_PMD	(1 << PMD_INDEX_SIZE)
 #define PTRS_PER_PGD	(1 << PGD_INDEX_SIZE)
 
+/* With 4k base page size, hugepage PTEs go at the PMD level */
+#define MIN_HUGEPTE_SHIFT	PAGE_SHIFT
+
 /* PMD_SHIFT determines what a second-level page table entry can map */
 #define PMD_SHIFT	(PAGE_SHIFT + PTE_INDEX_SIZE)
 #define PMD_SIZE	(1UL << PMD_SHIFT)
Index: working-2.6/arch/powerpc/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/hugetlbpage.c	2005-11-03 14:52:16.000000000 +1100
+++ working-2.6/arch/powerpc/mm/hugetlbpage.c	2005-11-03 15:56:34.000000000 +1100
@@ -212,6 +212,12 @@
 
 	BUG_ON(area >= NUM_HIGH_AREAS);
 
+	/* Hack, so that each addresses is controlled by exactly one
+	 * of the high or low area bitmaps, the first high area starts
+	 * at 4GB, not 0 */
+	if (start == 0)
+		start = 0x100000000UL;
+
 	/* Check no VMAs are in the region */
 	vma = find_vma(mm, start);
 	if (vma && (vma->vm_start < end))


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/people/dgibson
