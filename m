Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261570AbUKSTuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbUKSTuG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 14:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbUKSTsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 14:48:43 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:13960 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261560AbUKSTow (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 14:44:52 -0500
Date: Fri, 19 Nov 2004 11:44:47 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: torvalds@osdl.org, akpm@osdl.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Hugh Dickins <hugh@veritas.com>,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: page fault scalability patch V11 [3/7]: ia64 atomic pte operations
In-Reply-To: <Pine.LNX.4.58.0411190704330.5145@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0411191144180.24095@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0411061527440.3567-100000@localhost.localdomain>
  <Pine.LNX.4.58.0411181126440.30385@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.58.0411181715280.834@schroedinger.engr.sgi.com> 
 <419D581F.2080302@yahoo.com.au>  <Pine.LNX.4.58.0411181835540.1421@schroedinger.engr.sgi.com>
  <419D5E09.20805@yahoo.com.au>  <Pine.LNX.4.58.0411181921001.1674@schroedinger.engr.sgi.com>
 <1100848068.25520.49.camel@gaston> <Pine.LNX.4.58.0411190704330.5145@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog
        * Provide atomic pte operations for ia64
        * Enhanced parallelism in page fault handler if applied together
          with the generic patch

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.9/include/asm-ia64/pgalloc.h
===================================================================
--- linux-2.6.9.orig/include/asm-ia64/pgalloc.h	2004-10-18 14:53:06.000000000 -0700
+++ linux-2.6.9/include/asm-ia64/pgalloc.h	2004-11-19 07:54:19.000000000 -0800
@@ -34,6 +34,10 @@
 #define pmd_quicklist		(local_cpu_data->pmd_quick)
 #define pgtable_cache_size	(local_cpu_data->pgtable_cache_sz)

+/* Empty entries of PMD and PGD */
+#define PMD_NONE       0
+#define PGD_NONE       0
+
 static inline pgd_t*
 pgd_alloc_one_fast (struct mm_struct *mm)
 {
@@ -78,12 +82,19 @@
 	preempt_enable();
 }

+
 static inline void
 pgd_populate (struct mm_struct *mm, pgd_t *pgd_entry, pmd_t *pmd)
 {
 	pgd_val(*pgd_entry) = __pa(pmd);
 }

+/* Atomic populate */
+static inline int
+pgd_test_and_populate (struct mm_struct *mm, pgd_t *pgd_entry, pmd_t *pmd)
+{
+	return ia64_cmpxchg8_acq(pgd_entry,__pa(pmd), PGD_NONE) == PGD_NONE;
+}

 static inline pmd_t*
 pmd_alloc_one_fast (struct mm_struct *mm, unsigned long addr)
@@ -132,6 +143,13 @@
 	pmd_val(*pmd_entry) = page_to_phys(pte);
 }

+/* Atomic populate */
+static inline int
+pmd_test_and_populate (struct mm_struct *mm, pmd_t *pmd_entry, struct page *pte)
+{
+	return ia64_cmpxchg8_acq(pmd_entry, page_to_phys(pte), PMD_NONE) == PMD_NONE;
+}
+
 static inline void
 pmd_populate_kernel (struct mm_struct *mm, pmd_t *pmd_entry, pte_t *pte)
 {
Index: linux-2.6.9/include/asm-ia64/pgtable.h
===================================================================
--- linux-2.6.9.orig/include/asm-ia64/pgtable.h	2004-11-15 11:13:38.000000000 -0800
+++ linux-2.6.9/include/asm-ia64/pgtable.h	2004-11-19 07:55:35.000000000 -0800
@@ -414,6 +425,26 @@
 #endif
 }

+/*
+ * IA-64 doesn't have any external MMU info: the page tables contain all the necessary
+ * information.  However, we use this routine to take care of any (delayed) i-cache
+ * flushing that may be necessary.
+ */
+extern void update_mmu_cache (struct vm_area_struct *vma, unsigned long vaddr, pte_t pte);
+
+static inline int
+ptep_cmpxchg (struct vm_area_struct *vma, unsigned long addr, pte_t *ptep, pte_t oldval, pte_t newval)
+{
+	/*
+	 * IA64 defers icache flushes. If the new pte is executable we may
+	 * have to flush the icache to insure cache coherency immediately
+	 * after the cmpxchg.
+	 */
+	if (pte_exec(newval))
+		update_mmu_cache(vma, addr, newval);
+	return ia64_cmpxchg8_acq(&ptep->pte, newval.pte, oldval.pte) == oldval.pte;
+}
+
 static inline int
 pte_same (pte_t a, pte_t b)
 {
@@ -476,13 +507,6 @@
 	struct vm_area_struct * prev, unsigned long start, unsigned long end);
 #endif

-/*
- * IA-64 doesn't have any external MMU info: the page tables contain all the necessary
- * information.  However, we use this routine to take care of any (delayed) i-cache
- * flushing that may be necessary.
- */
-extern void update_mmu_cache (struct vm_area_struct *vma, unsigned long vaddr, pte_t pte);
-
 #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
 /*
  * Update PTEP with ENTRY, which is guaranteed to be a less
@@ -560,6 +584,8 @@
 #define __HAVE_ARCH_PTEP_MKDIRTY
 #define __HAVE_ARCH_PTE_SAME
 #define __HAVE_ARCH_PGD_OFFSET_GATE
+#define __HAVE_ARCH_ATOMIC_TABLE_OPS
+#define __HAVE_ARCH_LOCK_TABLE_OPS
 #include <asm-generic/pgtable.h>

 #endif /* _ASM_IA64_PGTABLE_H */

