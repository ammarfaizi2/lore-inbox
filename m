Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263173AbVHFH1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263173AbVHFH1o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 03:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262342AbVHFHZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 03:25:14 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:5380 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S262088AbVHFHYA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 03:24:00 -0400
Message-ID: <42F46558.9010202@vmware.com>
Date: Sat, 06 Aug 2005 00:23:04 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org, chrisw@osdl.org, linux-kernel@vger.kernel.org,
       davej@codemonkey.org.uk, hpa@zytor.com, Riley@Williams.Name,
       pratap@vmware.com, zach@vmware.com, chrisl@vmware.com
Subject: [PATCH] 8/8 Create MMU 2/3 level accessors in the sub-arch layer
 (i386)
Content-Type: multipart/mixed;
 boundary="------------070803030304060704030600"
X-OriginalArrivalTime: 06 Aug 2005 07:23:21.0812 (UTC) FILETIME=[B9B0A140:01C59A57]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070803030304060704030600
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------070803030304060704030600
Content-Type: text/plain;
 name="subarch-mmu"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="subarch-mmu"

i386 Transparent paravirtualization sub-arch patch #8.

Transparent paravirtualization support for MMU operations.

All operations which update live page table entries have been moved to the
sub-architecture layer.  Unfortunately, this required yet another parallel set
of pgtable-Nlevel-ops.h files, but this avoids the ugliness of having to use
#ifdef's all of the code.

This is pure code motion.  Anything else would be a bug.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.13/include/asm-i386/pgtable-2level.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/pgtable-2level.h	2005-08-04 13:42:31.000000000 -0700
+++ linux-2.6.13/include/asm-i386/pgtable-2level.h	2005-08-04 14:02:16.000000000 -0700
@@ -8,17 +8,6 @@
 #define pgd_ERROR(e) \
 	printk("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
 
-/*
- * Certain architectures need to do special things when PTEs
- * within a page table are directly modified.  Thus, the following
- * hook is made available.
- */
-#define set_pte(pteptr, pteval) (*(pteptr) = pteval)
-#define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
-#define set_pte_atomic(pteptr, pteval) set_pte(pteptr,pteval)
-#define set_pmd(pmdptr, pmdval) (*(pmdptr) = (pmdval))
-
-#define ptep_get_and_clear(mm,addr,xp)	__pte(xchg(&(xp)->pte_low, 0))
 #define pte_same(a, b)		((a).pte_low == (b).pte_low)
 #define pte_page(x)		pfn_to_page(pte_pfn(x))
 #define pte_none(x)		(!(x).pte_low)
Index: linux-2.6.13/include/asm-i386/pgtable-3level.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/pgtable-3level.h	2005-08-04 13:42:31.000000000 -0700
+++ linux-2.6.13/include/asm-i386/pgtable-3level.h	2005-08-04 14:02:16.000000000 -0700
@@ -44,28 +44,6 @@
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
-#define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
-
-#define __HAVE_ARCH_SET_PTE_ATOMIC
-#define set_pte_atomic(pteptr,pteval) \
-		set_64bit((unsigned long long *)(pteptr),pte_val(pteval))
-#define set_pmd(pmdptr,pmdval) \
-		set_64bit((unsigned long long *)(pmdptr),pmd_val(pmdval))
-#define set_pud(pudptr,pudval) \
-		(*(pudptr) = (pudval))
-
 /*
  * Pentium-II erratum A13: in PAE mode we explicitly have to flush
  * the TLB via cr3 if the top-level pgd is changed...
@@ -90,18 +68,6 @@
 #define pmd_offset(pud, address) ((pmd_t *) pud_page(*(pud)) + \
 			pmd_index(address))
 
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
 static inline int pte_same(pte_t a, pte_t b)
 {
 	return a.pte_low == b.pte_low && a.pte_high == b.pte_high;
Index: linux-2.6.13/include/asm-i386/pgtable.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/pgtable.h	2005-08-04 13:47:07.000000000 -0700
+++ linux-2.6.13/include/asm-i386/pgtable.h	2005-08-04 14:02:29.000000000 -0700
@@ -201,11 +201,9 @@
 extern unsigned long pg0[];
 
 #define pte_present(x)	((x).pte_low & (_PAGE_PRESENT | _PAGE_PROTNONE))
-#define pte_clear(mm,addr,xp)	do { set_pte_at(mm, addr, xp, __pte(0)); } while (0)
 
 #define pmd_none(x)	(!pmd_val(x))
 #define pmd_present(x)	(pmd_val(x) & _PAGE_PRESENT)
-#define pmd_clear(xp)	do { set_pmd(xp, __pmd(0)); } while (0)
 #define	pmd_bad(x)	((pmd_val(x) & (~PAGE_MASK & ~_PAGE_USER)) != _KERNPG_TABLE)
 
 
@@ -243,20 +241,12 @@
 #else
 # include <asm/pgtable-2level.h>
 #endif
+#include <pgtable-ops.h>
+  
+#define set_pte_at(mm,addr,pteptr,pteval) set_pte(pteptr,pteval)
 
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
+#define pte_clear(mm,addr,xp)	do { set_pte_at(mm, addr, xp, __pte(0)); } while (0)
+#define pmd_clear(xp)	do { set_pmd(xp, __pmd(0)); } while (0)
 
 static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm, unsigned long addr, pte_t *ptep, int full)
 {
@@ -270,26 +260,6 @@
 	return pte;
 }
 
-static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
-{
-	clear_bit(_PAGE_BIT_RW, &ptep->pte_low);
-}
-
-/*
- * clone_pgd_range(pgd_t *dst, pgd_t *src, int count);
- *
- *  dst - pointer to pgd range anwhere on a pgd page
- *  src - ""
- *  count - the number of pgds to copy.
- *
- * dst and src can be on the same page, but the range must not overlap,
- * and must not cross a page boundary.
- */
-static inline void clone_pgd_range(pgd_t *dst, pgd_t *src, int count)
-{
-       memcpy(dst, src, count * sizeof(pgd_t));
-}
-
 /*
  * Macro to mark a page protection value as "uncacheable".  On processors which do not support
  * it, this is a no-op.
@@ -414,14 +384,6 @@
  * bit at the same time.
  */
 #define update_mmu_cache(vma,address,pte) do { } while (0)
-#define  __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
-#define ptep_set_access_flags(__vma, __address, __ptep, __entry, __dirty) \
-	do {								  \
-		if (__dirty) {						  \
-			(__ptep)->pte_low = (__entry).pte_low;	  	  \
-			flush_tlb_page(__vma, __address);		  \
-		}							  \
-	} while (0)
 
 #endif /* !__ASSEMBLY__ */
 
Index: linux-2.6.13/include/asm-i386/mach-default/pgtable-2level-ops.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/mach-default/pgtable-2level-ops.h	2005-08-04 14:02:04.000000000 -0700
+++ linux-2.6.13/include/asm-i386/mach-default/pgtable-2level-ops.h	2005-08-04 14:02:16.000000000 -0700
@@ -0,0 +1,15 @@
+#ifndef _MACH_PGTABLE_LEVEL_OPS_H
+#define _MACH_PGTABLE_LEVEL_OPS_H
+
+/*
+ * Certain architectures need to do special things when PTEs
+ * within a page table are directly modified.  Thus, the following
+ * hook is made available.
+ */
+#define set_pte(pteptr, pteval) (*(pteptr) = pteval)
+#define set_pte_atomic(pteptr, pteval) set_pte(pteptr,pteval)
+#define set_pmd(pmdptr, pmdval) (*(pmdptr) = (pmdval))
+
+#define ptep_get_and_clear(mm,addr,xp)	__pte(xchg(&(xp)->pte_low, 0))
+
+#endif /* _PGTABLE_OPS_H */
Index: linux-2.6.13/include/asm-i386/mach-default/pgtable-3level-ops.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/mach-default/pgtable-3level-ops.h	2005-08-04 14:02:04.000000000 -0700
+++ linux-2.6.13/include/asm-i386/mach-default/pgtable-3level-ops.h	2005-08-04 14:02:16.000000000 -0700
@@ -0,0 +1,37 @@
+#ifndef _MACH_PGTABLE_LEVEL_OPS_H
+#define _MACH_PGTABLE_LEVEL_OPS_H
+
+/* Rules for using set_pte: the pte being assigned *must* be
+ * either not present or in a state where the hardware will
+ * not attempt to update the pte.  In places where this is
+ * not possible, use pte_get_and_clear to obtain the old pte
+ * value and then use set_pte to update it.  -ben
+ */
+static inline void set_pte(pte_t *ptep, pte_t pte)
+{
+	ptep->pte_high = pte.pte_high;
+	smp_wmb();
+	ptep->pte_low = pte.pte_low;
+}
+
+#define __HAVE_ARCH_SET_PTE_ATOMIC
+#define set_pte_atomic(pteptr,pteval) \
+		set_64bit((unsigned long long *)(pteptr),pte_val(pteval))
+#define set_pmd(pmdptr,pmdval) \
+		set_64bit((unsigned long long *)(pmdptr),pmd_val(pmdval))
+#define set_pud(pudptr,pudval) \
+		(*(pudptr) = (pudval))
+
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
+
+#endif
Index: linux-2.6.13/include/asm-i386/mach-default/pgtable-ops.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/mach-default/pgtable-ops.h	2005-08-04 14:02:04.000000000 -0700
+++ linux-2.6.13/include/asm-i386/mach-default/pgtable-ops.h	2005-08-04 14:02:44.000000000 -0700
@@ -0,0 +1,77 @@
+/*
+ * Copyright (C) 2005, VMware, Inc.
+ *
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send feedback to zach@vmware.com
+ *
+ */
+
+#ifndef _PGTABLE_OPS_H
+#define _PGTABLE_OPS_H
+
+#ifdef CONFIG_X86_PAE
+# include <pgtable-3level-ops.h>
+#else
+# include <pgtable-2level-ops.h>
+#endif
+
+static inline int ptep_test_and_clear_dirty(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
+{
+	if (!pte_dirty(*ptep))
+		return 0;
+	return test_and_clear_bit(_PAGE_BIT_DIRTY, &ptep->pte_low);
+}
+
+static inline int ptep_test_and_clear_young(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
+{
+	if (!pte_young(*ptep))
+		return 0;
+	return test_and_clear_bit(_PAGE_BIT_ACCESSED, &ptep->pte_low);
+}
+
+static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
+{
+	clear_bit(_PAGE_BIT_RW, &ptep->pte_low);
+}
+
+/*
+ * clone_pgd_range(pgd_t *dst, pgd_t *src, int count);
+ *
+ *  dst - pointer to pgd range anwhere on a pgd page
+ *  src - ""
+ *  count - the number of pgds to copy.
+ *
+ * dst and src can be on the same page, but the range must not overlap,
+ * and must not cross a page boundary.
+ */
+static inline void clone_pgd_range(pgd_t *dst, pgd_t *src, int count)
+{
+       memcpy(dst, src, count * sizeof(pgd_t));
+}
+
+#define  __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
+#define ptep_set_access_flags(__vma, __address, __ptep, __entry, __dirty) \
+	do {								  \
+		if (__dirty) {						  \
+			(__ptep)->pte_low = (__entry).pte_low;	  	  \
+			flush_tlb_page(__vma, __address);		  \
+		}							  \
+	} while (0)
+
+#endif /* _PGTABLE_OPS_H */

--------------070803030304060704030600--
