Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbULAX6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbULAX6E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 18:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbULAXzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 18:55:32 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:5025 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261514AbULAXpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 18:45:09 -0500
Date: Wed, 1 Dec 2004 15:45:04 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Hugh Dickins <hugh@veritas.com>, akpm@osdl.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: page fault scalability patch V12 [6/7]: atomic pte operations for
 s390
In-Reply-To: <Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0412011544290.5721@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>
 <Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org>
 <Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org>
 <Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog
        * Provide atomic pte operations for s390

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.9/include/asm-s390/pgtable.h
===================================================================
--- linux-2.6.9.orig/include/asm-s390/pgtable.h	2004-10-18 14:54:55.000000000 -0700
+++ linux-2.6.9/include/asm-s390/pgtable.h	2004-11-19 11:35:08.000000000 -0800
@@ -567,6 +567,15 @@
 	return pte;
 }

+#define ptep_xchg_flush(__vma, __address, __ptep, __pteval)            \
+({                                                                     \
+	struct mm_struct *__mm = __vma->vm_mm;                          \
+	pte_t __pte;                                                    \
+	__pte = ptep_clear_flush(__vma, __address, __ptep);             \
+	set_pte(__ptep, __pteval);                                      \
+	__pte;                                                          \
+})
+
 static inline void ptep_set_wrprotect(pte_t *ptep)
 {
 	pte_t old_pte = *ptep;
@@ -778,6 +787,14 @@

 #define kern_addr_valid(addr)   (1)

+/* Atomic PTE operations */
+#define __HAVE_ARCH_ATOMIC_TABLE_OPS
+
+static inline int ptep_cmpxchg (struct vm_area_struct *vma, unsigned long address, pte_t *ptep, pte_t oldval, pte_t newval)
+{
+	return cmpxchg(ptep, pte_val(oldval), pte_val(newval)) == pte_val(oldval);
+}
+
 /*
  * No page table caches to initialise
  */
@@ -791,6 +808,7 @@
 #define __HAVE_ARCH_PTEP_CLEAR_DIRTY_FLUSH
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
 #define __HAVE_ARCH_PTEP_CLEAR_FLUSH
+#define __HAVE_ARCH_PTEP_XCHG_FLUSH
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
 #define __HAVE_ARCH_PTEP_MKDIRTY
 #define __HAVE_ARCH_PTE_SAME
Index: linux-2.6.9/include/asm-s390/pgalloc.h
===================================================================
--- linux-2.6.9.orig/include/asm-s390/pgalloc.h	2004-10-18 14:54:37.000000000 -0700
+++ linux-2.6.9/include/asm-s390/pgalloc.h	2004-11-19 11:33:25.000000000 -0800
@@ -97,6 +97,10 @@
 	pgd_val(*pgd) = _PGD_ENTRY | __pa(pmd);
 }

+static inline int pgd_test_and_populate(struct mm_struct *mm, pdg_t *pgd, pmd_t *pmd)
+{
+	return cmpxchg(pgd, _PAGE_TABLE_INV, _PGD_ENTRY | __pa(pmd)) == _PAGE_TABLE_INV;
+}
 #endif /* __s390x__ */

 static inline void
@@ -119,6 +123,18 @@
 	pmd_populate_kernel(mm, pmd, (pte_t *)((page-mem_map) << PAGE_SHIFT));
 }

+static inline int
+pmd_test_and_populate(struct mm_struct *mm, pmd_t *pmd, struct page *page)
+{
+	int rc;
+	spin_lock(&mm->page_table_lock);
+
+	rc=pte_same(*pmd, _PAGE_INVALID_EMPTY);
+	if (rc) pmd_populate(mm, pmd, page);
+	spin_unlock(&mm->page_table_lock);
+	return rc;
+}
+
 /*
  * page table entry allocation/free routines.
  */

