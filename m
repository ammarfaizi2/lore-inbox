Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262095AbVADTsB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbVADTsB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 14:48:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbVADTrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 14:47:06 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:3786 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261842AbVADTiB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 14:38:01 -0500
Date: Tue, 4 Jan 2005 11:37:39 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Hugh Dickins <hugh@veritas.com>, akpm@osdl.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: page fault scalability patch V14 [4/7]: i386 atomic pte operations
In-Reply-To: <Pine.LNX.4.58.0501041129030.805@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0501041137200.805@schroedinger.engr.sgi.com>
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
	* Atomic pte operations for i386 in regular and PAE modes

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.10/include/asm-i386/pgtable.h
===================================================================
--- linux-2.6.10.orig/include/asm-i386/pgtable.h	2005-01-03 10:31:31.000000000 -0800
+++ linux-2.6.10/include/asm-i386/pgtable.h	2005-01-03 12:08:35.000000000 -0800
@@ -407,6 +407,7 @@
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
 #define __HAVE_ARCH_PTEP_MKDIRTY
 #define __HAVE_ARCH_PTE_SAME
+#define __HAVE_ARCH_ATOMIC_TABLE_OPS
 #include <asm-generic/pgtable.h>

 #endif /* _I386_PGTABLE_H */
Index: linux-2.6.10/include/asm-i386/pgtable-3level.h
===================================================================
--- linux-2.6.10.orig/include/asm-i386/pgtable-3level.h	2005-01-03 10:31:31.000000000 -0800
+++ linux-2.6.10/include/asm-i386/pgtable-3level.h	2005-01-03 12:11:59.000000000 -0800
@@ -8,7 +8,8 @@
  * tables on PPro+ CPUs.
  *
  * Copyright (C) 1999 Ingo Molnar <mingo@redhat.com>
- */
+ * August 26, 2004 added ptep_cmpxchg <christoph@lameter.com>
+*/

 #define pte_ERROR(e) \
 	printk("%s:%d: bad pte %p(%08lx%08lx).\n", __FILE__, __LINE__, &(e), (e).pte_high, (e).pte_low)
@@ -44,21 +45,11 @@
 	return pte_x(pte);
 }

-/* Rules for using set_pte: the pte being assigned *must* be
- * either not present or in a state where the hardware will
- * not attempt to update the pte.  In places where this is
- * not possible, use pte_get_and_clear to obtain the old pte
- * value and then use set_pte to update it.  -ben
- */
-static inline void set_pte(pte_t *ptep, pte_t pte)
-{
-	ptep->pte_high = pte.pte_high;
-	smp_wmb();
-	ptep->pte_low = pte.pte_low;
-}
 #define __HAVE_ARCH_SET_PTE_ATOMIC
 #define set_pte_atomic(pteptr,pteval) \
 		set_64bit((unsigned long long *)(pteptr),pte_val(pteval))
+#define set_pte(pteptr,pteval) \
+		*(unsigned long long *)(pteptr) = pte_val(pteval)
 #define set_pmd(pmdptr,pmdval) \
 		set_64bit((unsigned long long *)(pmdptr),pmd_val(pmdval))
 #define set_pud(pudptr,pudval) \
@@ -155,4 +146,25 @@

 #define __pmd_free_tlb(tlb, x)		do { } while (0)

+/* Atomic PTE operations */
+#define ptep_xchg_flush(__vma, __addr, __ptep, __newval) \
+({	pte_t __r;							\
+	/* xchg acts as a barrier before the setting of the high bits. */\
+	__r.pte_low = xchg(&(__ptep)->pte_low, (__newval).pte_low);	\
+	__r.pte_high = (__ptep)->pte_high;				\
+	(__ptep)->pte_high = (__newval).pte_high;			\
+	flush_tlb_page(__vma, __addr);					\
+	(__r);								\
+})
+
+#define __HAVE_ARCH_PTEP_XCHG_FLUSH
+
+static inline int ptep_cmpxchg(struct vm_area_struct *vma, unsigned long address, pte_t *ptep, pte_t oldval, pte_t newval)
+{
+	return cmpxchg8b((unsigned long long *)ptep, pte_val(oldval), pte_val(newval)) == pte_val(oldval);
+}
+
+#define __HAVE_ARCH_GET_PTE_ATOMIC
+#define get_pte_atomic(__ptep) __pte(get_64bit((unsigned long long *)(__ptep)))
+
 #endif /* _I386_PGTABLE_3LEVEL_H */
Index: linux-2.6.10/include/asm-i386/pgtable-2level.h
===================================================================
--- linux-2.6.10.orig/include/asm-i386/pgtable-2level.h	2005-01-03 10:31:31.000000000 -0800
+++ linux-2.6.10/include/asm-i386/pgtable-2level.h	2005-01-03 12:08:35.000000000 -0800
@@ -65,4 +65,7 @@
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { (pte).pte_low })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val })

+/* Atomic PTE operations */
+#define ptep_cmpxchg(__vma,__a,__xp,__oldpte,__newpte) (cmpxchg(&(__xp)->pte_low, (__oldpte).pte_low, (__newpte).pte_low)==(__oldpte).pte_low)
+
 #endif /* _I386_PGTABLE_2LEVEL_H */
Index: linux-2.6.10/include/asm-i386/pgalloc.h
===================================================================
--- linux-2.6.10.orig/include/asm-i386/pgalloc.h	2005-01-03 10:31:31.000000000 -0800
+++ linux-2.6.10/include/asm-i386/pgalloc.h	2005-01-03 12:11:23.000000000 -0800
@@ -4,9 +4,12 @@
 #include <linux/config.h>
 #include <asm/processor.h>
 #include <asm/fixmap.h>
+#include <asm/system.h>
 #include <linux/threads.h>
 #include <linux/mm.h>		/* for struct page */

+#define PMD_NONE 0L
+
 #define pmd_populate_kernel(mm, pmd, pte) \
 		set_pmd(pmd, __pmd(_PAGE_TABLE + __pa(pte)))

@@ -14,6 +17,18 @@
 	set_pmd(pmd, __pmd(_PAGE_TABLE +			\
 		((unsigned long long)page_to_pfn(pte) <<	\
 			(unsigned long long) PAGE_SHIFT)))
+/* Atomic version */
+static inline int pmd_test_and_populate(struct mm_struct *mm, pmd_t *pmd, struct page *pte)
+{
+#ifdef CONFIG_X86_PAE
+	return cmpxchg8b( ((unsigned long long *)pmd), PMD_NONE, _PAGE_TABLE +
+		((unsigned long long)page_to_pfn(pte) <<
+			(unsigned long long) PAGE_SHIFT) ) == PMD_NONE;
+#else
+	return cmpxchg( (unsigned long *)pmd, PMD_NONE, _PAGE_TABLE + (page_to_pfn(pte) << PAGE_SHIFT)) == PMD_NONE;
+#endif
+}
+
 /*
  * Allocate and free page tables.
  */
@@ -44,6 +59,7 @@
 #define pmd_free(x)			do { } while (0)
 #define __pmd_free_tlb(tlb,x)		do { } while (0)
 #define pud_populate(mm, pmd, pte)	BUG()
+#define pud_test_and_populate(mm, pmd, pte) 	({ BUG(); 1; })
 #endif

 #define check_pgt_cache()	do { } while (0)

