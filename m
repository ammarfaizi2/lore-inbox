Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268372AbUJOTVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268372AbUJOTVF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 15:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268342AbUJOTHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 15:07:43 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:64202 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S268334AbUJOTF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 15:05:59 -0400
Date: Fri, 15 Oct 2004 12:05:34 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: page fault scalability patch V10: [3/7] IA64 atomic pte operations
In-Reply-To: <Pine.LNX.4.58.0410151201020.26697@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0410151204570.26697@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0408150630560.324@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0409201348070.4628@schroedinger.engr.sgi.com>
 <20040920205752.GH4242@wotan.suse.de> <200409211841.25507.vda@port.imtp.ilyichevsk.odessa.ua>
 <20040921154542.GB12132@wotan.suse.de> <41527885.8020402@myrealbox.com>
 <20040923090345.GA6146@wotan.suse.de> <Pine.LNX.4.58.0409271204180.31769@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0410151201020.26697@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog
	* Provide atomic pte operations for ia64
	* pte lock operations
	* Enhanced parallelism in page fault handler if applied together
	  with the generic patch

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.9-rc4/include/asm-ia64/pgalloc.h
===================================================================
--- linux-2.6.9-rc4.orig/include/asm-ia64/pgalloc.h	2004-10-10 19:56:40.000000000 -0700
+++ linux-2.6.9-rc4/include/asm-ia64/pgalloc.h	2004-10-14 11:32:38.000000000 -0700
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
Index: linux-2.6.9-rc4/include/asm-ia64/pgtable.h
===================================================================
--- linux-2.6.9-rc4.orig/include/asm-ia64/pgtable.h	2004-10-10 19:57:17.000000000 -0700
+++ linux-2.6.9-rc4/include/asm-ia64/pgtable.h	2004-10-14 12:21:06.000000000 -0700
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
@@ -270,6 +273,8 @@
 #define pte_dirty(pte)		((pte_val(pte) & _PAGE_D) != 0)
 #define pte_young(pte)		((pte_val(pte) & _PAGE_A) != 0)
 #define pte_file(pte)		((pte_val(pte) & _PAGE_FILE) != 0)
+#define pte_locked(pte)		((pte_val(pte) & _PAGE_LOCK)!=0)
+
 /*
  * Note: we convert AR_RWX to AR_RX and AR_RW to AR_R by clearing the 2nd bit in the
  * access rights:
@@ -281,8 +286,15 @@
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
@@ -342,7 +354,6 @@
 #define pte_unmap_nested(pte)		do { } while (0)

 /* atomic versions of the some PTE manipulations: */
-
 static inline int
 ptep_test_and_clear_young (pte_t *ptep)
 {
@@ -414,6 +425,18 @@
 #endif
 }

+static inline pte_t
+ptep_xchg (struct mm_struct *mm, pte_t *ptep, pte_t pteval)
+{
+	return __pte(xchg((long *) ptep, pteval.pte));
+}
+
+static inline int
+ptep_cmpxchg (struct vm_area_struct *vma, unsigned long addr, pte_t *ptep, pte_t oldval, pte_t newval)
+{
+	return ia64_cmpxchg8_acq(&ptep->pte, newval.pte, oldval.pte) == oldval.pte;
+}
+
 static inline int
 pte_same (pte_t a, pte_t b)
 {
@@ -558,6 +581,8 @@
 #define __HAVE_ARCH_PTEP_MKDIRTY
 #define __HAVE_ARCH_PTE_SAME
 #define __HAVE_ARCH_PGD_OFFSET_GATE
+#define __HAVE_ARCH_ATOMIC_TABLE_OPS
+#define __HAVE_ARCH_LOCK_TABLE_OPS
 #include <asm-generic/pgtable.h>

 #endif /* _ASM_IA64_PGTABLE_H */
