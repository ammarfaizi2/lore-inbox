Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932534AbVHOXDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932534AbVHOXDT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 19:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932552AbVHOXDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 19:03:19 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:54029 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932534AbVHOXDS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 19:03:18 -0400
Date: Mon, 15 Aug 2005 16:01:09 -0700
From: zach@vmware.com
Message-Id: <200508152301.j7FN19cj005354@zach-dev.vmware.com>
To: ak@suse.de, akpm@osdl.org, chrisl@vmware.com, chrisw@osdl.org,
       hpa@zytor.com, linux-kernel@vger.kernel.org, mbligh@mbligh.org,
       pratap@vmware.com, virtualization@lists.osdl.org, zach@vmware.com,
       zwane@arm.linux.org.uk
Subject: [PATCH 6/6] i386 virtualization - Attempt to clean up pgtable code motion
X-OriginalArrivalTime: 15 Aug 2005 23:00:49.0851 (UTC) FILETIME=[2DDA00B0:01C5A1ED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Virtualization aware Linux kernels may need to redefine functions which write
to hardware page tables at the sub-architecture layer.  Previously, this was
done by encapsulation in a split mach-xxx/pgtable-{2|3}level-ops.h file, but
having 8 pgtable header files is simply unacceptable.  This goes some ways
towards cleaning that up by deprecating the 2/3 level subarch functions.
This is accomplished by using __HAVE_ARCH_FUNC macros, and allowing
one sub-arch file, pgtable-ops.h, which gets included before any functions
which write to hardware page tables, allowing the sub-architecture to override
any or all definitions it needs.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.13/include/asm-i386/pgtable-2level.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/pgtable-2level.h	2005-08-15 14:23:06.000000000 -0700
+++ linux-2.6.13/include/asm-i386/pgtable-2level.h	2005-08-15 14:24:11.000000000 -0700
@@ -55,4 +55,25 @@
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { (pte).pte_low })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val })
 
+/*
+ * Certain architectures need to do special things when PTEs
+ * within a page table are directly modified.  Thus, the following
+ * hook is made available.
+ */
+#ifndef __HAVE_ARCH_SET_PTE
+#define __HAVE_ARCH_SET_PTE
+#define set_pte(pteptr, pteval) (*(pteptr) = pteval)
+#endif
+#define set_pte_atomic(pteptr, pteval) set_pte(pteptr, pteval)
+
+#ifndef __HAVE_ARCH_SET_PMD
+#define __HAVE_ARCH_SET_PMD
+#define set_pmd(pmdptr, pmdval) (*(pmdptr) = (pmdval))
+#endif
+
+#ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
+#define __HAVE_ARCH_PTEP_GET_AND_CLEAR
+#define ptep_get_and_clear(mm,addr,xp)	__pte(xchg(&(xp)->pte_low, 0))
+#endif
+
 #endif /* _I386_PGTABLE_2LEVEL_H */
Index: linux-2.6.13/include/asm-i386/pgtable-3level.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/pgtable-3level.h	2005-08-15 14:23:06.000000000 -0700
+++ linux-2.6.13/include/asm-i386/pgtable-3level.h	2005-08-15 14:24:11.000000000 -0700
@@ -123,4 +123,58 @@
 
 #define __pmd_free_tlb(tlb, x)		do { } while (0)
 
+/*
+ * Sub-arch is allowed to override these, so check for definition first.
+ * New functions which write to hardware page table entries should go here.
+ */
+
+/* Rules for using set_pte: the pte being assigned *must* be
+ * either not present or in a state where the hardware will
+ * not attempt to update the pte.  In places where this is
+ * not possible, use pte_get_and_clear to obtain the old pte
+ * value and then use set_pte to update it.  -ben
+ */
+#ifndef __HAVE_ARCH_SET_PTE
+#define __HAVE_ARCH_SET_PTE
+static inline void set_pte(pte_t *ptep, pte_t pte)
+{
+	ptep->pte_high = pte.pte_high;
+	smp_wmb();
+	ptep->pte_low = pte.pte_low;
+}
+#endif
+
+#ifndef __HAVE_ARCH_SET_PTE_ATOMIC
+#define __HAVE_ARCH_SET_PTE_ATOMIC
+#define set_pte_atomic(pteptr,pteval) \
+		set_64bit((unsigned long long *)(pteptr),pte_val(pteval))
+#endif
+
+#ifndef __HAVE_ARCH_SET_PMD
+#define __HAVE_ARCH_SET_PMD
+#define set_pmd(pmdptr,pmdval) \
+		set_64bit((unsigned long long *)(pmdptr),pmd_val(pmdval))
+#endif
+
+#ifndef __HAVE_ARCH_SET_PUD
+#define __HAVE_ARCH_SET_PUD
+#define set_pud(pudptr,pudval) \
+		(*(pudptr) = (pudval))
+#endif
+
+#ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
+#define __HAVE_ARCH_PTEP_GET_AND_CLEAR
+static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
+{
+	pte_t res;
+
+	/* xchg acts as a barrier before the setting of the high bits */
+	res.pte_low = xchg(&ptep->pte_low, 0);
+	res.pte_high = ptep->pte_high;
+	ptep->pte_high = 0;
+
+	return res;
+}
+#endif
+
 #endif /* _I386_PGTABLE_3LEVEL_H */
Index: linux-2.6.13/include/asm-i386/pgtable.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/pgtable.h	2005-08-15 14:23:06.000000000 -0700
+++ linux-2.6.13/include/asm-i386/pgtable.h	2005-08-15 14:24:11.000000000 -0700
@@ -236,12 +236,55 @@
 static inline pte_t pte_mkwrite(pte_t pte)	{ (pte).pte_low |= _PAGE_RW; return pte; }
 static inline pte_t pte_mkhuge(pte_t pte)	{ (pte).pte_low |= _PAGE_PRESENT | _PAGE_PSE; return pte; }
 
+#include <pgtable-ops.h>
 #ifdef CONFIG_X86_PAE
 # include <asm/pgtable-3level.h>
 #else
 # include <asm/pgtable-2level.h>
 #endif
-#include <pgtable-ops.h>
+
+/*
+ * We give sub-architectures a chance to override functions which write to page
+ * tables, thus we check for existing definitions first.
+ */
+#ifndef __HAVE_ARCH_PTEP_TEST_AND_CLEAR_DIRTY
+#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_DIRTY
+static inline int ptep_test_and_clear_dirty(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
+{
+	if (!pte_dirty(*ptep))
+		return 0;
+	return test_and_clear_bit(_PAGE_BIT_DIRTY, &ptep->pte_low);
+}
+#endif
+
+#ifndef __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
+#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
+static inline int ptep_test_and_clear_young(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
+{
+	if (!pte_young(*ptep))
+		return 0;
+	return test_and_clear_bit(_PAGE_BIT_ACCESSED, &ptep->pte_low);
+}
+#endif
+
+#ifndef __HAVE_ARCH_PTEP_SET_WRPROTECT
+#define __HAVE_ARCH_PTEP_SET_WRPROTECT
+static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
+{
+	clear_bit(_PAGE_BIT_RW, &ptep->pte_low);
+}
+#endif
+
+#ifndef  __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
+#define  __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
+#define ptep_set_access_flags(__vma, __address, __ptep, __entry, __dirty) \
+	do {								  \
+		if (__dirty) {						  \
+			(__ptep)->pte_low = (__entry).pte_low;	  	  \
+			flush_tlb_page(__vma, __address);		  \
+		}							  \
+	} while (0)
+#endif
 
 #define set_pte_at(mm,addr,pteptr,pteval) set_pte(pteptr,pteval)
 
@@ -401,11 +444,7 @@
 #define GET_IOSPACE(pfn)		0
 #define GET_PFN(pfn)			(pfn)
 
-#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
-#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_DIRTY
-#define __HAVE_ARCH_PTEP_GET_AND_CLEAR
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR_FULL
-#define __HAVE_ARCH_PTEP_SET_WRPROTECT
 #define __HAVE_ARCH_PTE_SAME
 #include <asm-generic/pgtable.h>
 
Index: linux-2.6.13/include/asm-i386/mach-default/pgtable-2level-ops.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/mach-default/pgtable-2level-ops.h	2005-08-15 14:23:06.000000000 -0700
+++ linux-2.6.13/include/asm-i386/mach-default/pgtable-2level-ops.h	2003-01-30 02:24:37.000000000 -0800
@@ -1,15 +0,0 @@
-#ifndef _MACH_PGTABLE_LEVEL_OPS_H
-#define _MACH_PGTABLE_LEVEL_OPS_H
-
-/*
- * Certain architectures need to do special things when PTEs
- * within a page table are directly modified.  Thus, the following
- * hook is made available.
- */
-#define set_pte(pteptr, pteval) (*(pteptr) = pteval)
-#define set_pte_atomic(pteptr, pteval) set_pte(pteptr,pteval)
-#define set_pmd(pmdptr, pmdval) (*(pmdptr) = (pmdval))
-
-#define ptep_get_and_clear(mm,addr,xp)	__pte(xchg(&(xp)->pte_low, 0))
-
-#endif /* _PGTABLE_OPS_H */
Index: linux-2.6.13/include/asm-i386/mach-default/pgtable-3level-ops.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/mach-default/pgtable-3level-ops.h	2005-08-15 14:23:06.000000000 -0700
+++ linux-2.6.13/include/asm-i386/mach-default/pgtable-3level-ops.h	2003-01-30 02:24:37.000000000 -0800
@@ -1,37 +0,0 @@
-#ifndef _MACH_PGTABLE_LEVEL_OPS_H
-#define _MACH_PGTABLE_LEVEL_OPS_H
-
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
-
-#define __HAVE_ARCH_SET_PTE_ATOMIC
-#define set_pte_atomic(pteptr,pteval) \
-		set_64bit((unsigned long long *)(pteptr),pte_val(pteval))
-#define set_pmd(pmdptr,pmdval) \
-		set_64bit((unsigned long long *)(pmdptr),pmd_val(pmdval))
-#define set_pud(pudptr,pudval) \
-		(*(pudptr) = (pudval))
-
-static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
-{
-	pte_t res;
-
-	/* xchg acts as a barrier before the setting of the high bits */
-	res.pte_low = xchg(&ptep->pte_low, 0);
-	res.pte_high = ptep->pte_high;
-	ptep->pte_high = 0;
-
-	return res;
-}
-
-#endif
Index: linux-2.6.13/include/asm-i386/mach-default/pgtable-ops.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/mach-default/pgtable-ops.h	2005-08-15 14:23:06.000000000 -0700
+++ linux-2.6.13/include/asm-i386/mach-default/pgtable-ops.h	2005-08-15 14:24:11.000000000 -0700
@@ -25,31 +25,6 @@
 #ifndef _PGTABLE_OPS_H
 #define _PGTABLE_OPS_H
 
-#ifdef CONFIG_X86_PAE
-# include <pgtable-3level-ops.h>
-#else
-# include <pgtable-2level-ops.h>
-#endif
-
-static inline int ptep_test_and_clear_dirty(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
-{
-	if (!pte_dirty(*ptep))
-		return 0;
-	return test_and_clear_bit(_PAGE_BIT_DIRTY, &ptep->pte_low);
-}
-
-static inline int ptep_test_and_clear_young(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
-{
-	if (!pte_young(*ptep))
-		return 0;
-	return test_and_clear_bit(_PAGE_BIT_ACCESSED, &ptep->pte_low);
-}
-
-static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
-{
-	clear_bit(_PAGE_BIT_RW, &ptep->pte_low);
-}
-
 /*
  * clone_pgd_range(pgd_t *dst, pgd_t *src, int count);
  *
@@ -65,13 +40,4 @@
        memcpy(dst, src, count * sizeof(pgd_t));
 }
 
-#define  __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
-#define ptep_set_access_flags(__vma, __address, __ptep, __entry, __dirty) \
-	do {								  \
-		if (__dirty) {						  \
-			(__ptep)->pte_low = (__entry).pte_low;	  	  \
-			flush_tlb_page(__vma, __address);		  \
-		}							  \
-	} while (0)
-
 #endif /* _PGTABLE_OPS_H */
