Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262104AbVADTw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbVADTw4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 14:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbVADTwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 14:52:15 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:7115 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262020AbVADTjG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 14:39:06 -0500
Date: Tue, 4 Jan 2005 11:38:46 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Hugh Dickins <hugh@veritas.com>, akpm@osdl.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: page fault scalability patch V14 [6/7]: s390 atomic pte operationsw
In-Reply-To: <Pine.LNX.4.58.0501041129030.805@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0501041138200.805@schroedinger.engr.sgi.com>
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
        * Provide atomic pte operations for s390

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.10/include/asm-s390/pgtable.h
===================================================================
--- linux-2.6.10.orig/include/asm-s390/pgtable.h	2005-01-03 10:31:31.000000000 -0800
+++ linux-2.6.10/include/asm-s390/pgtable.h	2005-01-03 12:12:03.000000000 -0800
@@ -569,6 +569,15 @@
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
@@ -780,6 +789,14 @@

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
@@ -793,6 +810,7 @@
 #define __HAVE_ARCH_PTEP_CLEAR_DIRTY_FLUSH
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
 #define __HAVE_ARCH_PTEP_CLEAR_FLUSH
+#define __HAVE_ARCH_PTEP_XCHG_FLUSH
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
 #define __HAVE_ARCH_PTEP_MKDIRTY
 #define __HAVE_ARCH_PTE_SAME
Index: linux-2.6.10/include/asm-s390/pgalloc.h
===================================================================
--- linux-2.6.10.orig/include/asm-s390/pgalloc.h	2004-12-24 13:35:00.000000000 -0800
+++ linux-2.6.10/include/asm-s390/pgalloc.h	2005-01-03 12:12:03.000000000 -0800
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

