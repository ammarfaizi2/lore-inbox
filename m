Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267248AbUI0TR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267248AbUI0TR1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 15:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267254AbUI0TMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 15:12:10 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:39570 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S267234AbUI0TKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 15:10:38 -0400
Date: Mon, 27 Sep 2004 12:10:03 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: akpm@osdl.org
cc: Andy Lutomirski <luto@myrealbox.com>, ak@suse.de, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: page fault scalability patch V9: [3/7] atomic pte operatios for ia64
In-Reply-To: <B6E8046E1E28D34EB815A11AC8CA312902CD3282@mtv-atc-605e--n.corp.sgi.com>
Message-ID: <Pine.LNX.4.58.0409271208440.31769@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0408150630560.324@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0409201348070.4628@schroedinger.engr.sgi.com>
 <20040920205752.GH4242@wotan.suse.de> <200409211841.25507.vda@port.imtp.ilyichevsk.odessa.ua>
 <20040921154542.GB12132@wotan.suse.de> <41527885.8020402@myrealbox.com>
 <20040923090345.GA6146@wotan.suse.de> <B6E8046E1E28D34EB815A11AC8CA312902CD3282@mtv-atc-605e--n.corp.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog
	* Provide atomic pte operations for ia64
	* Enhanced parallelism in page fault handler if applied together
	  with the generic patch

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linus/include/asm-ia64/pgalloc.h
===================================================================
--- linus.orig/include/asm-ia64/pgalloc.h	2004-09-18 14:25:23.000000000 -0700
+++ linus/include/asm-ia64/pgalloc.h	2004-09-18 15:43:25.000000000 -0700
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
Index: linus/include/asm-ia64/pgtable.h
===================================================================
--- linus.orig/include/asm-ia64/pgtable.h	2004-09-18 14:25:23.000000000 -0700
+++ linus/include/asm-ia64/pgtable.h	2004-09-18 15:43:25.000000000 -0700
@@ -423,6 +423,19 @@
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 extern void paging_init (void);

+/* Atomic PTE operations */
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
 /*
  * Note: The macros below rely on the fact that MAX_SWAPFILES_SHIFT <= number of
  *	 bits in the swap-type field of the swap pte.  It would be nice to
@@ -558,6 +571,7 @@
 #define __HAVE_ARCH_PTEP_MKDIRTY
 #define __HAVE_ARCH_PTE_SAME
 #define __HAVE_ARCH_PGD_OFFSET_GATE
+#define __HAVE_ARCH_ATOMIC_TABLE_OPS
 #include <asm-generic/pgtable.h>

 #endif /* _ASM_IA64_PGTABLE_H */

