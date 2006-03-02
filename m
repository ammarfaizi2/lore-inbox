Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbWCBEwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWCBEwl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 23:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWCBEwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 23:52:41 -0500
Received: from ozlabs.org ([203.10.76.45]:26080 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750805AbWCBEwk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 23:52:40 -0500
Date: Thu, 2 Mar 2006 15:52:01 +1100
From: "'David Gibson'" <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Hugh Dickins <hugh@veritas.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       wlilinux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: hugepage: Fix hugepage logic in free_pgtables()
Message-ID: <20060302045201.GA6627@localhost.localdomain>
Mail-Followup-To: 'David Gibson' <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Hugh Dickins <hugh@veritas.com>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	wlilinux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

free_pgtables() has special logic to call hugetlb_free_pgd_range()
instead of the normal free_pgd_range() on hugepage VMAs.  However, the
test it uses to do so is incorrect: it calls is_hugepage_only_range on
a hugepage sized range at the start of the vma.
is_hugepage_only_range() will return true if the given range has any
intersection with a hugepage address region, and in this case the
given region need not be hugepage aligned.  So, for example, this test
can return true if called on, say, a 4k VMA immediately preceding a
(nicely aligned) hugepage VMA.

At present we get away with this because the powerpc version of
hugetlb_free_pgd_range() is just a call to free_pgd_range().  On ia64
(the only other arch with a non-trivial is_hugepage_only_range()) we
get away with it for a different reason; the hugepage area is not
contiguous with the rest of the user address space, and VMAs are not
permitted in between, so the test can't return a false positive there.

Nonetheless this should be fixed.  We do that in the patch below by
replacing the is_hugepage_only_range() test with an explicit test of
the VMA using is_vm_hugetlb_page().

This in turn changes behaviour for platforms where
is_hugepage_only_range() returns false always (everything except
powerpc and ia64).  We address this by ensuring that
hugetlb_free_pgd_range() is defined to be identical to
free_pgd_range() (instead of a no-op) on everything except ia64.  Even
so, it will prevent some otherwise possible coalescing of calls down
to free_pgd_range().  Since this only happens for hugepage VMAs,
removing this small optimization seems unlikely to cause any trouble.

This patch causes no regressions on the libhugetlbfs testsuite - ppc64
POWER5 (8-way), ppc64 G5 (2-way) and i386 Pentium M (UP).

Signed-off-by: David Gibson <dwg@au1.ibm.com>

Index: working-2.6/mm/memory.c
===================================================================
--- working-2.6.orig/mm/memory.c	2006-02-24 11:44:36.000000000 +1100
+++ working-2.6/mm/memory.c	2006-03-02 11:14:03.000000000 +1100
@@ -277,7 +277,7 @@ void free_pgtables(struct mmu_gather **t
 		anon_vma_unlink(vma);
 		unlink_file_vma(vma);
 
-		if (is_hugepage_only_range(vma->vm_mm, addr, HPAGE_SIZE)) {
+		if (is_vm_hugetlb_page(vma)) {
 			hugetlb_free_pgd_range(tlb, addr, vma->vm_end,
 				floor, next? next->vm_start: ceiling);
 		} else {
@@ -285,8 +285,7 @@ void free_pgtables(struct mmu_gather **t
 			 * Optimization: gather nearby vmas into one call down
 			 */
 			while (next && next->vm_start <= vma->vm_end + PMD_SIZE
-			  && !is_hugepage_only_range(vma->vm_mm, next->vm_start,
-							HPAGE_SIZE)) {
+			       && !is_vm_hugetlb_page(vma)) {
 				vma = next;
 				next = vma->vm_next;
 				anon_vma_unlink(vma);
Index: working-2.6/include/asm-ia64/page.h
===================================================================
--- working-2.6.orig/include/asm-ia64/page.h	2006-03-02 11:12:40.000000000 +1100
+++ working-2.6/include/asm-ia64/page.h	2006-03-02 11:30:26.000000000 +1100
@@ -57,6 +57,7 @@
 
 # define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
 # define ARCH_HAS_HUGEPAGE_ONLY_RANGE
+# define ARCH_HAS_HUGETLB_FREE_PGD_RANGE
 #endif /* CONFIG_HUGETLB_PAGE */
 
 #ifdef __ASSEMBLY__
Index: working-2.6/include/asm-powerpc/pgtable.h
===================================================================
--- working-2.6.orig/include/asm-powerpc/pgtable.h	2006-02-24 11:44:35.000000000 +1100
+++ working-2.6/include/asm-powerpc/pgtable.h	2006-03-02 11:29:26.000000000 +1100
@@ -468,11 +468,6 @@ extern pgd_t swapper_pg_dir[];
 
 extern void paging_init(void);
 
-#ifdef CONFIG_HUGETLB_PAGE
-#define hugetlb_free_pgd_range(tlb, addr, end, floor, ceiling) \
-	free_pgd_range(tlb, addr, end, floor, ceiling)
-#endif
-
 /*
  * This gets called at the end of handling a page fault, when
  * the kernel has put a new PTE into the page table for the process.
Index: working-2.6/include/linux/hugetlb.h
===================================================================
--- working-2.6.orig/include/linux/hugetlb.h	2006-03-02 11:12:40.000000000 +1100
+++ working-2.6/include/linux/hugetlb.h	2006-03-02 11:47:30.000000000 +1100
@@ -43,8 +43,10 @@ void hugetlb_change_protection(struct vm
 
 #ifndef ARCH_HAS_HUGEPAGE_ONLY_RANGE
 #define is_hugepage_only_range(mm, addr, len)	0
-#define hugetlb_free_pgd_range(tlb, addr, end, floor, ceiling) \
-						do { } while (0)
+#endif
+
+#ifndef ARCH_HAS_HUGETLB_FREE_PGD_RANGE
+#define hugetlb_free_pgd_range	free_pgd_range
 #endif
 
 #ifndef ARCH_HAS_PREPARE_HUGEPAGE_RANGE
@@ -93,8 +95,7 @@ static inline unsigned long hugetlb_tota
 #define prepare_hugepage_range(addr, len)	(-EINVAL)
 #define pmd_huge(x)	0
 #define is_hugepage_only_range(mm, addr, len)	0
-#define hugetlb_free_pgd_range(tlb, addr, end, floor, ceiling) \
-						do { } while (0)
+#define hugetlb_free_pgd_range(tlb, addr, end, floor, ceiling) ({BUG(); 0; })
 #define hugetlb_fault(mm, vma, addr, write)	({ BUG(); 0; })
 
 #define hugetlb_change_protection(vma, address, end, newprot)

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
