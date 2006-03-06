Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWCFEGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWCFEGE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 23:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbWCFEGC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 23:06:02 -0500
Received: from ozlabs.org ([203.10.76.45]:52890 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750780AbWCFEGB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 23:06:01 -0500
Date: Mon, 6 Mar 2006 15:05:22 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: William Lee Irwin <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: hugepage: is_aligned_hugepage_range() cleanup
Message-ID: <20060306040522.GE21408@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>,
	William Lee Irwin <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch applies on top of all my other hugepage patches in the -mm
queue.

Quite a long time back, prepare_hugepage_range() replaced
is_aligned_hugepage_range() as the callback from mm/mmap.c to arch
code to verify if an address range is suitable for a hugepage mapping.
is_aligned_hugepage_range() stuck around, but only to implement
prepare_hugepage_range() on archs which didn't implement their own.

Most archs (everything except ia64 and powerpc) used the same
implementation of is_aligned_hugepage_range().  On powerpc, which
implements its own prepare_hugepage_range(), the custom version was
never used.

In addition, "is_aligned_hugepage_range()" was a bad name, because it
suggests it returns true iff the given range is a good hugepage range,
whereas in fact it returns 0-or-error (so the sense is reversed).

This patch cleans up by abolishing is_aligned_hugepage_range().
Instead prepare_hugepage_range() is defined directly.  Most archs use
the default version, which simply checks the given region is aligned
to the size of a hugepage.  ia64 and powerpc define custom versions.
The ia64 one simply checks that the range is in the correct address
space region in addition to being suitably aligned.  The powerpc
version (just as previously) checks for suitable addresses, and if
necessary performs low-level MMU frobbing to set up new areas for use
by hugepages.

No libhugetlbfs testsuite regressions on ppc64 (POWER5 LPAR).

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

 arch/i386/mm/hugetlbpage.c    |   12 ------------
 arch/ia64/mm/hugetlbpage.c    |    5 +++--
 arch/powerpc/mm/hugetlbpage.c |   15 ---------------
 arch/sh/mm/hugetlbpage.c      |   12 ------------
 arch/sh64/mm/hugetlbpage.c    |   12 ------------
 arch/sparc64/mm/hugetlbpage.c |   12 ------------
 include/asm-ia64/page.h       |    1 +
 include/linux/hugetlb.h       |   16 ++++++++++++----
 8 files changed, 16 insertions(+), 69 deletions(-)

Index: working-2.6/arch/i386/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/i386/mm/hugetlbpage.c	2006-02-24 11:44:19.000000000 +1100
+++ working-2.6/arch/i386/mm/hugetlbpage.c	2006-03-06 14:57:48.000000000 +1100
@@ -48,18 +48,6 @@ pte_t *huge_pte_offset(struct mm_struct 
 	return (pte_t *) pmd;
 }
 
-/*
- * This function checks for proper alignment of input addr and len parameters.
- */
-int is_aligned_hugepage_range(unsigned long addr, unsigned long len)
-{
-	if (len & ~HPAGE_MASK)
-		return -EINVAL;
-	if (addr & ~HPAGE_MASK)
-		return -EINVAL;
-	return 0;
-}
-
 #if 0	/* This is just for testing */
 struct page *
 follow_huge_addr(struct mm_struct *mm, unsigned long address, int write)
Index: working-2.6/arch/ia64/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/ia64/mm/hugetlbpage.c	2006-02-24 11:44:19.000000000 +1100
+++ working-2.6/arch/ia64/mm/hugetlbpage.c	2006-03-06 14:57:48.000000000 +1100
@@ -68,9 +68,10 @@ huge_pte_offset (struct mm_struct *mm, u
 #define mk_pte_huge(entry) { pte_val(entry) |= _PAGE_P; }
 
 /*
- * This function checks for proper alignment of input addr and len parameters.
+ * Don't actually need to do any preparation, but need to make sure
+ * the address is in the right region.
  */
-int is_aligned_hugepage_range(unsigned long addr, unsigned long len)
+int prepare_hugepage_range(unsigned long addr, unsigned long len)
 {
 	if (len & ~HPAGE_MASK)
 		return -EINVAL;
Index: working-2.6/arch/powerpc/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/hugetlbpage.c	2006-03-06 14:57:48.000000000 +1100
+++ working-2.6/arch/powerpc/mm/hugetlbpage.c	2006-03-06 14:57:48.000000000 +1100
@@ -332,21 +332,6 @@ pte_t huge_ptep_get_and_clear(struct mm_
 	return __pte(old);
 }
 
-/*
- * This function checks for proper alignment of input addr and len parameters.
- */
-int is_aligned_hugepage_range(unsigned long addr, unsigned long len)
-{
-	if (len & ~HPAGE_MASK)
-		return -EINVAL;
-	if (addr & ~HPAGE_MASK)
-		return -EINVAL;
-	if (! (within_hugepage_low_range(addr, len)
-	       || within_hugepage_high_range(addr, len)) )
-		return -EINVAL;
-	return 0;
-}
-
 struct slb_flush_info {
 	struct mm_struct *mm;
 	u16 newareas;
Index: working-2.6/arch/sh/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/sh/mm/hugetlbpage.c	2006-02-24 11:44:20.000000000 +1100
+++ working-2.6/arch/sh/mm/hugetlbpage.c	2006-03-06 14:57:48.000000000 +1100
@@ -84,18 +84,6 @@ pte_t huge_ptep_get_and_clear(struct mm_
 	return entry;
 }
 
-/*
- * This function checks for proper alignment of input addr and len parameters.
- */
-int is_aligned_hugepage_range(unsigned long addr, unsigned long len)
-{
-	if (len & ~HPAGE_MASK)
-		return -EINVAL;
-	if (addr & ~HPAGE_MASK)
-		return -EINVAL;
-	return 0;
-}
-
 struct page *follow_huge_addr(struct mm_struct *mm,
 			      unsigned long address, int write)
 {
Index: working-2.6/arch/sh64/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/sh64/mm/hugetlbpage.c	2006-02-24 11:44:20.000000000 +1100
+++ working-2.6/arch/sh64/mm/hugetlbpage.c	2006-03-06 14:57:48.000000000 +1100
@@ -84,18 +84,6 @@ pte_t huge_ptep_get_and_clear(struct mm_
 	return entry;
 }
 
-/*
- * This function checks for proper alignment of input addr and len parameters.
- */
-int is_aligned_hugepage_range(unsigned long addr, unsigned long len)
-{
-	if (len & ~HPAGE_MASK)
-		return -EINVAL;
-	if (addr & ~HPAGE_MASK)
-		return -EINVAL;
-	return 0;
-}
-
 struct page *follow_huge_addr(struct mm_struct *mm,
 			      unsigned long address, int write)
 {
Index: working-2.6/arch/sparc64/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/sparc64/mm/hugetlbpage.c	2006-02-24 11:44:21.000000000 +1100
+++ working-2.6/arch/sparc64/mm/hugetlbpage.c	2006-03-06 14:57:48.000000000 +1100
@@ -92,18 +92,6 @@ pte_t huge_ptep_get_and_clear(struct mm_
 	return entry;
 }
 
-/*
- * This function checks for proper alignment of input addr and len parameters.
- */
-int is_aligned_hugepage_range(unsigned long addr, unsigned long len)
-{
-	if (len & ~HPAGE_MASK)
-		return -EINVAL;
-	if (addr & ~HPAGE_MASK)
-		return -EINVAL;
-	return 0;
-}
-
 struct page *follow_huge_addr(struct mm_struct *mm,
 			      unsigned long address, int write)
 {
Index: working-2.6/include/asm-ia64/page.h
===================================================================
--- working-2.6.orig/include/asm-ia64/page.h	2006-03-06 14:57:47.000000000 +1100
+++ working-2.6/include/asm-ia64/page.h	2006-03-06 14:57:48.000000000 +1100
@@ -57,6 +57,7 @@
 
 # define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
 # define ARCH_HAS_HUGEPAGE_ONLY_RANGE
+# define ARCH_HAS_PREPARE_HUGEPAGE_RANGE
 # define ARCH_HAS_HUGETLB_FREE_PGD_RANGE
 #endif /* CONFIG_HUGETLB_PAGE */
 
Index: working-2.6/include/linux/hugetlb.h
===================================================================
--- working-2.6.orig/include/linux/hugetlb.h	2006-03-06 14:57:48.000000000 +1100
+++ working-2.6/include/linux/hugetlb.h	2006-03-06 14:57:48.000000000 +1100
@@ -36,7 +36,6 @@ struct page *follow_huge_addr(struct mm_
 			      int write);
 struct page *follow_huge_pmd(struct mm_struct *mm, unsigned long address,
 				pmd_t *pmd, int write);
-int is_aligned_hugepage_range(unsigned long addr, unsigned long len);
 int pmd_huge(pmd_t pmd);
 void hugetlb_change_protection(struct vm_area_struct *vma,
 		unsigned long address, unsigned long end, pgprot_t newprot);
@@ -54,8 +53,18 @@ void hugetlb_free_pgd_range(struct mmu_g
 #endif
 
 #ifndef ARCH_HAS_PREPARE_HUGEPAGE_RANGE
-#define prepare_hugepage_range(addr, len)	\
-	is_aligned_hugepage_range(addr, len)
+/*
+ * If the arch doesn't supply something else, assume that hugepage
+ * size aligned regions are ok without further preparation.
+ */
+static inline int prepare_hugepage_range(unsigned long addr, unsigned long len)
+{
+	if (len & ~HPAGE_MASK)
+		return -EINVAL;
+	if (addr & ~HPAGE_MASK)
+		return -EINVAL;
+	return 0;
+}
 #else
 int prepare_hugepage_range(unsigned long addr, unsigned long len);
 #endif
@@ -95,7 +104,6 @@ static inline unsigned long hugetlb_tota
 #define hugetlb_report_meminfo(buf)		0
 #define hugetlb_report_node_meminfo(n, buf)	0
 #define follow_huge_pmd(mm, addr, pmd, write)	NULL
-#define is_aligned_hugepage_range(addr, len)	0
 #define prepare_hugepage_range(addr, len)	(-EINVAL)
 #define pmd_huge(x)	0
 #define is_hugepage_only_range(mm, addr, len)	0

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
