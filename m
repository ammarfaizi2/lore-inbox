Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbVADTsC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbVADTsC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 14:48:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbVADTqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 14:46:34 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:38375 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261854AbVADTgh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 14:36:37 -0500
Date: Tue, 4 Jan 2005 11:36:33 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Hugh Dickins <hugh@veritas.com>, akpm@osdl.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: page fault scalability patch V14 [2/7]: ia64 atomic pte operations
In-Reply-To: <Pine.LNX.4.58.0501041129030.805@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0501041136000.805@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>
 <Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org>
 <Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org>
 <Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0412011545060.5721@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0501041129030.805@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog
        * Provide atomic pte operations for ia64
        * Enhanced parallelism in page fault handler if applied together
          with the generic patch

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.10/include/asm-ia64/pgalloc.h
===================================================================
--- linux-2.6.10.orig/include/asm-ia64/pgalloc.h	2005-01-03 10:31:31.000000000 -0800
+++ linux-2.6.10/include/asm-ia64/pgalloc.h	2005-01-03 12:37:44.000000000 -0800
@@ -34,6 +34,10 @@
 #define pmd_quicklist		(local_cpu_data->pmd_quick)
 #define pgtable_cache_size	(local_cpu_data->pgtable_cache_sz)

+/* Empty entries of PMD and PGD */
+#define PMD_NONE       0
+#define PUD_NONE       0
+
 static inline pgd_t*
 pgd_alloc_one_fast (struct mm_struct *mm)
 {
@@ -84,6 +88,13 @@
 	pud_val(*pud_entry) = __pa(pmd);
 }

+/* Atomic populate */
+static inline int
+pud_test_and_populate (struct mm_struct *mm, pud_t *pud_entry, pmd_t *pmd)
+{
+	return ia64_cmpxchg8_acq(pud_entry,__pa(pmd), PUD_NONE) == PUD_NONE;
+}
+
 static inline pmd_t*
 pmd_alloc_one_fast (struct mm_struct *mm, unsigned long addr)
 {
@@ -131,6 +142,13 @@
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
Index: linux-2.6.10/include/asm-ia64/pgtable.h
===================================================================
--- linux-2.6.10.orig/include/asm-ia64/pgtable.h	2005-01-03 10:31:31.000000000 -0800
+++ linux-2.6.10/include/asm-ia64/pgtable.h	2005-01-03 12:37:44.000000000 -0800
@@ -30,6 +30,8 @@
 #define _PAGE_P_BIT		0
 #define _PAGE_A_BIT		5
 #define _PAGE_D_BIT		6
+#define _PAGE_IG_BITS          53
+#define _PAGE_LOCK_BIT         (_PAGE_IG_BITS+3)       /* bit 56. Aligned to 8 bits */

 #define _PAGE_P			(1 << _PAGE_P_BIT)	/* page present bit */
 #define _PAGE_MA_WB		(0x0 <<  2)	/* write back memory attribute */
@@ -58,6 +60,7 @@
 #define _PAGE_PPN_MASK		(((__IA64_UL(1) << IA64_MAX_PHYS_BITS) - 1) & ~0xfffUL)
 #define _PAGE_ED		(__IA64_UL(1) << 52)	/* exception deferral */
 #define _PAGE_PROTNONE		(__IA64_UL(1) << 63)
+#define _PAGE_LOCK		(__IA64_UL(1) << _PAGE_LOCK_BIT)

 /* Valid only for a PTE with the present bit cleared: */
 #define _PAGE_FILE		(1 << 1)		/* see swap & file pte remarks below */
@@ -271,6 +274,8 @@
 #define pte_dirty(pte)		((pte_val(pte) & _PAGE_D) != 0)
 #define pte_young(pte)		((pte_val(pte) & _PAGE_A) != 0)
 #define pte_file(pte)		((pte_val(pte) & _PAGE_FILE) != 0)
+#define pte_locked(pte)		((pte_val(pte) & _PAGE_LOCK)!=0)
+
 /*
  * Note: we convert AR_RWX to AR_RX and AR_RW to AR_R by clearing the 2nd bit in the
  * access rights:
@@ -282,8 +287,15 @@
 #define pte_mkyoung(pte)	(__pte(pte_val(pte) | _PAGE_A))
 #define pte_mkclean(pte)	(__pte(pte_val(pte) & ~_PAGE_D))
 #define pte_mkdirty(pte)	(__pte(pte_val(pte) | _PAGE_D))
+#define pte_mkunlocked(pte)	(__pte(pte_val(pte) & ~_PAGE_LOCK))

 /*
+ * Lock functions for pte's
+ */
+#define ptep_lock(ptep)		test_and_set_bit(_PAGE_LOCK_BIT, ptep)
+#define ptep_unlock(ptep)	{ clear_bit(_PAGE_LOCK_BIT,ptep); smp_mb__after_clear_bit(); }
+#define ptep_unlock_set(ptep, val) set_pte(ptep, pte_mkunlocked(val))
+/*
  * Macro to a page protection value as "uncacheable".  Note that "protection" is really a
  * misnomer here as the protection value contains the memory attribute bits, dirty bits,
  * and various other bits as well.
@@ -343,7 +355,6 @@
 #define pte_unmap_nested(pte)		do { } while (0)

 /* atomic versions of the some PTE manipulations: */
-
 static inline int
 ptep_test_and_clear_young (pte_t *ptep)
 {
@@ -415,6 +426,26 @@
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
@@ -477,13 +508,6 @@
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
@@ -561,6 +585,8 @@
 #define __HAVE_ARCH_PTEP_MKDIRTY
 #define __HAVE_ARCH_PTE_SAME
 #define __HAVE_ARCH_PGD_OFFSET_GATE
+#define __HAVE_ARCH_ATOMIC_TABLE_OPS
+#define __HAVE_ARCH_LOCK_TABLE_OPS
 #include <asm-generic/pgtable.h>
 #include <asm-generic/pgtable-nopud.h>


