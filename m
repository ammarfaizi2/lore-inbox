Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268367AbUJOTPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268367AbUJOTPO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 15:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268346AbUJOTJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 15:09:32 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:14053 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268357AbUJOTIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 15:08:47 -0400
Date: Fri, 15 Oct 2004 12:08:22 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: page fault scalability patch V10: [7/7] s/390 atomic pte operations
In-Reply-To: <Pine.LNX.4.58.0410151201020.26697@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0410151207360.26697@schroedinger.engr.sgi.com>
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
	* Provide atomic pte operations for s390

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.9-rc4/include/asm-s390/pgtable.h
===================================================================
--- linux-2.6.9-rc4.orig/include/asm-s390/pgtable.h	2004-10-10 19:58:24.000000000 -0700
+++ linux-2.6.9-rc4/include/asm-s390/pgtable.h	2004-10-14 12:22:14.000000000 -0700
@@ -567,6 +567,17 @@
 	return pte;
 }

+#define ptep_xchg_flush(__vma, __address, __ptep, __pteval)            \
+({                                                                     \
+	struct mm_struct *__mm = __vma->vm_mm;                          \
+	pte_t __pte;                                                    \
+	spin_lock(&__mm->page_table_lock);                              \
+	__pte = ptep_clear_flush(__vma, __address, __ptep);             \
+	set_pte(__ptep, __pteval);                                      \
+	spin_unlock(&__mm->page_table_lock);                            \
+	__pte;                                                          \
+})
+
 static inline void ptep_set_wrprotect(pte_t *ptep)
 {
 	pte_t old_pte = *ptep;
@@ -778,6 +789,19 @@

 #define kern_addr_valid(addr)   (1)

+/* Atomic PTE operations */
+#define __HAVE_ARCH_ATOMIC_TABLE_OPS
+
+static inline pte_t ptep_xchg(struct mm_struct *mm, unsigned long address, pte_t *ptep, pte_t pteval)
+{
+	return __pte(xchg(ptep, pte_val(pteval)));
+}
+
+static inline int ptep_cmpxchg (struct mm_struct *mm, unsigned long address, pte_t *ptep, pte_t oldval, pte_t newval)
+{
+	return cmpxchg(ptep, pte_val(oldval), pte_val(newval)) == pte_val(oldval);
+}
+
 /*
  * No page table caches to initialise
  */
@@ -791,6 +815,7 @@
 #define __HAVE_ARCH_PTEP_CLEAR_DIRTY_FLUSH
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
 #define __HAVE_ARCH_PTEP_CLEAR_FLUSH
+#define __HAVE_ARCH_PTEP_XCHG_FLUSH
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
 #define __HAVE_ARCH_PTEP_MKDIRTY
 #define __HAVE_ARCH_PTE_SAME
Index: linux-2.6.9-rc4/include/asm-s390/pgalloc.h
===================================================================
--- linux-2.6.9-rc4.orig/include/asm-s390/pgalloc.h	2004-10-10 19:58:06.000000000 -0700
+++ linux-2.6.9-rc4/include/asm-s390/pgalloc.h	2004-10-14 12:22:14.000000000 -0700
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
