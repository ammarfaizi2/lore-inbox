Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261406AbVHGBUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbVHGBUN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 21:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbVHGBSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 21:18:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61397 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261406AbVHGBRC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 21:17:02 -0400
Date: Sat, 6 Aug 2005 18:16:53 -0700
From: Chris Wright <chrisw@osdl.org>
To: Zachary Amsden <zach@vmware.com>
Cc: akpm@osdl.org, chrisw@osdl.org, linux-kernel@vger.kernel.org,
       davej@codemonkey.org.uk, hpa@zytor.com, Riley@Williams.Name,
       pratap@vmware.com, chrisl@vmware.com
Subject: Re: [PATCH] 8/8 Create MMU 2/3 level accessors in the sub-arch layer (i386)
Message-ID: <20050807011653.GM7762@shell0.pdx.osdl.net>
References: <42F46558.9010202@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42F46558.9010202@vmware.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zachary Amsden (zach@vmware.com) wrote:
> All operations which update live page table entries have been moved to the
> sub-architecture layer.  Unfortunately, this required yet another parallel set
> of pgtable-Nlevel-ops.h files, but this avoids the ugliness of having to use
> #ifdef's all of the code.

I hit similar issue...

--- linux-2.6.12-xen0-arch.orig/include/asm-i386/pgtable.h
+++ linux-2.6.12-xen0-arch/include/asm-i386/pgtable.h
@@ -200,15 +200,6 @@ extern unsigned long long __PAGE_KERNEL,
 /* The boot page tables (all created as a single array) */
 extern unsigned long pg0[];
 
-#define pte_present(x)	((x).pte_low & (_PAGE_PRESENT | _PAGE_PROTNONE))
-#define pte_clear(mm,addr,xp)	do { set_pte_at(mm, addr, xp, __pte(0)); } while (0)
-
-#define pmd_none(x)	(!pmd_val(x))
-#define pmd_present(x)	(pmd_val(x) & _PAGE_PRESENT)
-#define pmd_clear(xp)	do { set_pmd(xp, __pmd(0)); } while (0)
-#define	pmd_bad(x)	((pmd_val(x) & (~PAGE_MASK & ~_PAGE_USER)) != _KERNPG_TABLE)
-
-
 #define pages_to_mb(x) ((x) >> (20-PAGE_SHIFT))
 
 /*
@@ -237,6 +228,17 @@ static inline pte_t pte_mkdirty(pte_t pt
 static inline pte_t pte_mkyoung(pte_t pte)	{ (pte).pte_low |= _PAGE_ACCESSED; return pte; }
 static inline pte_t pte_mkwrite(pte_t pte)	{ (pte).pte_low |= _PAGE_RW; return pte; }
 
+#include <mach_pgtable.h>
+
+#define pte_present(x)	((x).pte_low & (_PAGE_PRESENT | _PAGE_PROTNONE))
+#define pte_clear(mm,addr,xp)	do { set_pte_at(mm, addr, xp, __pte(0)); } while (0)
+
+#define pmd_none(x)	(!pmd_val(x))
+#define pmd_present(x)	(pmd_val(x) & _PAGE_PRESENT)
+#define pmd_clear(xp)	do { set_pmd(xp, __pmd(0)); } while (0)
+#define pmd_bad(x)	mach_pmd_bad(x)
+
+
 #ifdef CONFIG_X86_PAE
 # include <asm/pgtable-3level.h>
 #else
@@ -257,10 +259,7 @@ static inline int ptep_test_and_clear_yo
 	return test_and_clear_bit(_PAGE_BIT_ACCESSED, &ptep->pte_low);
 }
 
-static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
-{
-	clear_bit(_PAGE_BIT_RW, &ptep->pte_low);
-}
+#define ptep_set_wrprotect(mm,addr,ptep) mach_ptep_set_wrprotect(mm,addr,ptep)
 
 /*
  * Macro to mark a page protection value as "uncacheable".  On processors which do not support
@@ -363,9 +362,9 @@ extern void noexec_setup(const char *str
 
 #if defined(CONFIG_HIGHPTE)
 #define pte_offset_map(dir, address) \
-	((pte_t *)kmap_atomic(pmd_page(*(dir)),KM_PTE0) + pte_index(address))
+	((pte_t *)kmap_atomic_pte(pmd_page(*(dir)),KM_PTE0) + pte_index(address))
 #define pte_offset_map_nested(dir, address) \
-	((pte_t *)kmap_atomic(pmd_page(*(dir)),KM_PTE1) + pte_index(address))
+	((pte_t *)kmap_atomic_pte(pmd_page(*(dir)),KM_PTE1) + pte_index(address))
 #define pte_unmap(pte) kunmap_atomic(pte, KM_PTE0)
 #define pte_unmap_nested(pte) kunmap_atomic(pte, KM_PTE1)
 #else
@@ -403,10 +402,10 @@ extern void noexec_setup(const char *str
 #endif /* !CONFIG_DISCONTIGMEM */
 
 #define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
-		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
+		mach_io_remap_page_range(vma, vaddr, paddr, size, prot)
 
 #define io_remap_pfn_range(vma, vaddr, pfn, size, prot)		\
-		remap_pfn_range(vma, vaddr, pfn, size, prot)
+		mach_io_remap_pfn_range(vma, vaddr, pfn, size, prot)
 
 #define MK_IOSPACE_PFN(space, pfn)	(pfn)
 #define GET_IOSPACE(pfn)		0
--- linux-2.6.12-xen0-arch.orig/include/asm-i386/pgtable-2level.h
+++ linux-2.6.12-xen0-arch/include/asm-i386/pgtable-2level.h
@@ -2,6 +2,7 @@
 #define _I386_PGTABLE_2LEVEL_H
 
 #include <asm-generic/pgtable-nopmd.h>
+#include <mach_pgtable-2level.h>
 
 #define pte_ERROR(e) \
 	printk("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, (e).pte_low)
@@ -16,13 +17,13 @@
 #define set_pte(pteptr, pteval) (*(pteptr) = pteval)
 #define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
 #define set_pte_atomic(pteptr, pteval) set_pte(pteptr,pteval)
-#define set_pmd(pmdptr, pmdval) (*(pmdptr) = (pmdval))
+#define set_pmd(pmdptr, pmdval) mach_set_pmd(pmdptr, pmdval)
 
-#define ptep_get_and_clear(mm,addr,xp)	__pte(xchg(&(xp)->pte_low, 0))
+#define ptep_get_and_clear(mm,addr,xp)	mach_ptep_get_and_clear(mm,addr,xp)
 #define pte_same(a, b)		((a).pte_low == (b).pte_low)
-#define pte_page(x)		pfn_to_page(pte_pfn(x))
+#define pte_page(x)		mach_pte_page(x)
 #define pte_none(x)		(!(x).pte_low)
-#define pte_pfn(x)		((unsigned long)(((x).pte_low >> PAGE_SHIFT)))
+#define pte_pfn(x)		mach_pte_pfn(x)
 #define pfn_pte(pfn, prot)	__pte(((pfn) << PAGE_SHIFT) | pgprot_val(prot))
 #define pfn_pmd(pfn, prot)	__pmd(((pfn) << PAGE_SHIFT) | pgprot_val(prot))
 
--- linux-2.6.12-xen0-arch.orig/include/asm-i386/pgtable-3level-defs.h
+++ linux-2.6.12-xen0-arch/include/asm-i386/pgtable-3level-defs.h
@@ -1,7 +1,7 @@
 #ifndef _I386_PGTABLE_3LEVEL_DEFS_H
 #define _I386_PGTABLE_3LEVEL_DEFS_H
 
-#define HAVE_SHARED_KERNEL_PMD 1
+#include <mach_pgtable-3level-defs.h>
 
 /*
  * PGDIR_SHIFT determines what a top-level page table entry can map
--- /dev/null
+++ linux-2.6.12-xen0-arch/include/asm-i386/mach-default/mach_pgtable.h
@@ -0,0 +1,18 @@
+#ifndef __ASM_MACH_PGTABLE_H
+#define __ASM_MACH_PGTABLE_H
+
+#define mach_pmd_present(x)	(pmd_val(x) & _PAGE_PRESENT)
+#define mach_pmd_bad(x)		((pmd_val(x) & (~PAGE_MASK & ~_PAGE_USER)) != _KERNPG_TABLE)
+
+static inline void mach_ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
+{
+	clear_bit(_PAGE_BIT_RW, &ptep->pte_low);
+}
+
+#define mach_io_remap_page_range(vma, vaddr, paddr, size, prot)		\
+		remap_pfn_range(vma, vaddr, (paddr) >> PAGE_SHIFT, size, prot)
+
+#define mach_io_remap_pfn_range(vma, vaddr, pfn, size, prot)		\
+		remap_pfn_range(vma, vaddr, pfn, size, prot)
+
+#endif
--- /dev/null
+++ linux-2.6.12-xen0-arch/include/asm-i386/mach-default/mach_pgtable-2level.h
@@ -0,0 +1,10 @@
+#ifndef _ASM_MACH_PGTABLE_2LEVEL_H
+#define _ASM_MACH_PGTABLE_2LEVEL_H
+
+#define mach_set_pmd(pmdptr, pmdval) (*(pmdptr) = (pmdval))
+
+#define mach_ptep_get_and_clear(mm,addr,xp)	__pte(xchg(&(xp)->pte_low, 0))
+#define mach_pte_page(x)		pfn_to_page(pte_pfn(x))
+#define mach_pte_pfn(x)		((unsigned long)(((x).pte_low >> PAGE_SHIFT)))
+
+#endif
--- /dev/null
+++ linux-2.6.12-xen0-arch/include/asm-i386/mach-default/mach_pgtable-3level-defs.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_MACH_PGTABLE_3LEVEL_DEFS_H
+#define _ASM_MACH_PGTABLE_3LEVEL_DEFS_H
+
+#define HAVE_SHARED_KERNEL_PMD 1
+
+#endif
