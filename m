Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263816AbUDMX2U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 19:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263814AbUDMX2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 19:28:20 -0400
Received: from fmr04.intel.com ([143.183.121.6]:9131 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S263809AbUDMX1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 19:27:32 -0400
Message-Id: <200404132325.i3DNPXF21289@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
       <lse-tech@lists.sourceforge.net>
Cc: <raybry@sgi.com>, "'Andy Whitcroft'" <apw@shadowen.org>,
       "'Andrew Morton'" <akpm@osdl.org>
Subject: hugetlb demand paging patch part [3/3]
Date: Tue, 13 Apr 2004 16:25:34 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcQhrp5avE/BuEjESPyzpR5PxTezbw==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Part 3 of 3

3. hugetlb_demand_arch.patch - this adds additional arch specific fixes
   for x86 and ia64 when generic demand paging is turned on.  Also bulk
   of the patch is to clean up with functions that no longer needed.


 i386/mm/hugetlbpage.c    |  148 +----------------------------------------------
 ia64/mm/hugetlbpage.c    |   93 -----------------------------
 sh/mm/hugetlbpage.c      |   94 -----------------------------
 sparc64/mm/hugetlbpage.c |   94 -----------------------------
 4 files changed, 10 insertions(+), 419 deletions(-)

diff -Nurp linux-2.6.5/arch/i386/mm/hugetlbpage.c linux-2.6.5.htlb/arch/i386/mm/hugetlbpage.c
--- linux-2.6.5/arch/i386/mm/hugetlbpage.c	2004-04-13 11:26:21.000000000 -0700
+++ linux-2.6.5.htlb/arch/i386/mm/hugetlbpage.c	2004-04-13 11:39:44.000000000 -0700
@@ -9,18 +9,14 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/hugetlb.h>
-#include <linux/pagemap.h>
-#include <linux/smp_lock.h>
-#include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/err.h>
-#include <linux/sysctl.h>
 #include <asm/mman.h>
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>

-static pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr)
+pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
 	pmd_t *pmd = NULL;
@@ -41,7 +37,8 @@ static pte_t *huge_pte_offset(struct mm_
 	return (pte_t *) pmd;
 }

-static void set_huge_pte(struct mm_struct *mm, struct vm_area_struct *vma, struct page *page, pte_t * page_table, int write_access)
+void set_huge_pte(struct mm_struct *mm, struct vm_area_struct *vma, struct page *page,
+		  pte_t * page_table, int write_access)
 {
 	pte_t entry;

@@ -96,95 +93,6 @@ nomem:
 	return -ENOMEM;
 }

-int
-follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
-		    struct page **pages, struct vm_area_struct **vmas,
-		    unsigned long *position, int *length, int i)
-{
-	unsigned long vpfn, vaddr = *position;
-	int remainder = *length;
-
-	WARN_ON(!is_vm_hugetlb_page(vma));
-
-	vpfn = vaddr/PAGE_SIZE;
-	while (vaddr < vma->vm_end && remainder) {
-
-		if (pages) {
-			pte_t *pte;
-			struct page *page;
-
-			pte = huge_pte_offset(mm, vaddr);
-
-			/* hugetlb should be locked, and hence, prefaulted */
-			WARN_ON(!pte || pte_none(*pte));
-
-			page = &pte_page(*pte)[vpfn % (HPAGE_SIZE/PAGE_SIZE)];
-
-			WARN_ON(!PageCompound(page));
-
-			get_page(page);
-			pages[i] = page;
-		}
-
-		if (vmas)
-			vmas[i] = vma;
-
-		vaddr += PAGE_SIZE;
-		++vpfn;
-		--remainder;
-		++i;
-	}
-
-	*length = remainder;
-	*position = vaddr;
-
-	return i;
-}
-
-#if 0	/* This is just for testing */
-struct page *
-follow_huge_addr(struct mm_struct *mm,
-	struct vm_area_struct *vma, unsigned long address, int write)
-{
-	unsigned long start = address;
-	int length = 1;
-	int nr;
-	struct page *page;
-
-	nr = follow_hugetlb_page(mm, vma, &page, NULL, &start, &length, 0);
-	if (nr == 1)
-		return page;
-	return NULL;
-}
-
-/*
- * If virtual address `addr' lies within a huge page, return its controlling
- * VMA, else NULL.
- */
-struct vm_area_struct *hugepage_vma(struct mm_struct *mm, unsigned long addr)
-{
-	if (mm->used_hugetlb) {
-		struct vm_area_struct *vma = find_vma(mm, addr);
-		if (vma && is_vm_hugetlb_page(vma))
-			return vma;
-	}
-	return NULL;
-}
-
-int pmd_huge(pmd_t pmd)
-{
-	return 0;
-}
-
-struct page *
-follow_huge_pmd(struct mm_struct *mm, unsigned long address,
-		pmd_t *pmd, int write)
-{
-	return NULL;
-}
-
-#else
-
 struct page *
 follow_huge_addr(struct mm_struct *mm,
 	struct vm_area_struct *vma, unsigned long address, int write)
@@ -209,13 +117,10 @@ follow_huge_pmd(struct mm_struct *mm, un
 	struct page *page;

 	page = pte_page(*(pte_t *)pmd);
-	if (page) {
+	if (page)
 		page += ((address & ~HPAGE_MASK) >> PAGE_SHIFT);
-		get_page(page);
-	}
 	return page;
 }
-#endif

 void unmap_hugepage_range(struct vm_area_struct *vma,
 		unsigned long start, unsigned long end)
@@ -239,48 +144,3 @@ void unmap_hugepage_range(struct vm_area
 	mm->rss -= (end - start) >> PAGE_SHIFT;
 	flush_tlb_range(vma, start, end);
 }
-
-int hugetlb_prefault(struct address_space *mapping, struct vm_area_struct *vma)
-{
-	struct mm_struct *mm = current->mm;
-	unsigned long addr;
-	int ret = 0;
-
-	BUG_ON(vma->vm_start & ~HPAGE_MASK);
-	BUG_ON(vma->vm_end & ~HPAGE_MASK);
-
-	spin_lock(&mm->page_table_lock);
-	for (addr = vma->vm_start; addr < vma->vm_end; addr += HPAGE_SIZE) {
-		unsigned long idx;
-		pte_t *pte = huge_pte_alloc(mm, addr);
-		struct page *page;
-
-		if (!pte) {
-			ret = -ENOMEM;
-			goto out;
-		}
-		if (!pte_none(*pte))
-			continue;
-
-		idx = ((addr - vma->vm_start) >> HPAGE_SHIFT)
-			+ (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));
-		page = find_get_page(mapping, idx);
-		if (!page) {
-			page = alloc_huge_page();
-			if (!page) {
-				ret = -ENOMEM;
-				goto out;
-			}
-			ret = add_to_page_cache(page, mapping, idx, GFP_ATOMIC);
-			unlock_page(page);
-			if (ret) {
-				free_huge_page(page);
-				goto out;
-			}
-		}
-		set_huge_pte(mm, vma, page, pte, vma->vm_flags & VM_WRITE);
-	}
-out:
-	spin_unlock(&mm->page_table_lock);
-	return ret;
-}
diff -Nurp linux-2.6.5/arch/ia64/mm/hugetlbpage.c linux-2.6.5.htlb/arch/ia64/mm/hugetlbpage.c
--- linux-2.6.5/arch/ia64/mm/hugetlbpage.c	2004-04-13 11:26:21.000000000 -0700
+++ linux-2.6.5.htlb/arch/ia64/mm/hugetlbpage.c	2004-04-13 11:42:09.000000000 -0700
@@ -13,10 +13,6 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/hugetlb.h>
-#include <linux/pagemap.h>
-#include <linux/smp_lock.h>
-#include <linux/slab.h>
-#include <linux/sysctl.h>
 #include <asm/mman.h>
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
@@ -24,8 +20,7 @@

 unsigned int hpage_shift=HPAGE_SHIFT_DEFAULT;

-static pte_t *
-huge_pte_alloc (struct mm_struct *mm, unsigned long addr)
+pte_t * huge_pte_alloc (struct mm_struct *mm, unsigned long addr)
 {
 	unsigned long taddr = htlbpage_to_page(addr);
 	pgd_t *pgd;
@@ -58,8 +53,7 @@ huge_pte_offset (struct mm_struct *mm, u

 #define mk_pte_huge(entry) { pte_val(entry) |= _PAGE_P; }

-static void
-set_huge_pte (struct mm_struct *mm, struct vm_area_struct *vma,
+void set_huge_pte (struct mm_struct *mm, struct vm_area_struct *vma,
 	      struct page *page, pte_t * page_table, int write_access)
 {
 	pte_t entry;
@@ -116,43 +110,6 @@ nomem:
 	return -ENOMEM;
 }

-int
-follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
-		    struct page **pages, struct vm_area_struct **vmas,
-		    unsigned long *st, int *length, int i)
-{
-	pte_t *ptep, pte;
-	unsigned long start = *st;
-	unsigned long pstart;
-	int len = *length;
-	struct page *page;
-
-	do {
-		pstart = start & HPAGE_MASK;
-		ptep = huge_pte_offset(mm, start);
-		pte = *ptep;
-
-back1:
-		page = pte_page(pte);
-		if (pages) {
-			page += ((start & ~HPAGE_MASK) >> PAGE_SHIFT);
-			get_page(page);
-			pages[i] = page;
-		}
-		if (vmas)
-			vmas[i] = vma;
-		i++;
-		len--;
-		start += PAGE_SIZE;
-		if (((start & HPAGE_MASK) == pstart) && len &&
-				(start < vma->vm_end))
-			goto back1;
-	} while (len && start < vma->vm_end);
-	*length = len;
-	*st = start;
-	return i;
-}
-
 struct vm_area_struct *hugepage_vma(struct mm_struct *mm, unsigned long addr)
 {
 	if (mm->used_hugetlb) {
@@ -175,7 +132,6 @@ struct page *follow_huge_addr(struct mm_
 		return NULL;
 	page = pte_page(*ptep);
 	page += ((addr & ~HPAGE_MASK) >> PAGE_SHIFT);
-	get_page(page);
 	return page;
 }
 int pmd_huge(pmd_t pmd)
@@ -263,51 +219,6 @@ void unmap_hugepage_range(struct vm_area
 	flush_tlb_range(vma, start, end);
 }

-int hugetlb_prefault(struct address_space *mapping, struct vm_area_struct *vma)
-{
-	struct mm_struct *mm = current->mm;
-	unsigned long addr;
-	int ret = 0;
-
-	BUG_ON(vma->vm_start & ~HPAGE_MASK);
-	BUG_ON(vma->vm_end & ~HPAGE_MASK);
-
-	spin_lock(&mm->page_table_lock);
-	for (addr = vma->vm_start; addr < vma->vm_end; addr += HPAGE_SIZE) {
-		unsigned long idx;
-		pte_t *pte = huge_pte_alloc(mm, addr);
-		struct page *page;
-
-		if (!pte) {
-			ret = -ENOMEM;
-			goto out;
-		}
-		if (!pte_none(*pte))
-			continue;
-
-		idx = ((addr - vma->vm_start) >> HPAGE_SHIFT)
-			+ (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));
-		page = find_get_page(mapping, idx);
-		if (!page) {
-			page = alloc_huge_page();
-			if (!page) {
-				ret = -ENOMEM;
-				goto out;
-			}
-			ret = add_to_page_cache(page, mapping, idx, GFP_ATOMIC);
-			unlock_page(page);
-			if (ret) {
-				free_huge_page(page);
-				goto out;
-			}
-		}
-		set_huge_pte(mm, vma, page, pte, vma->vm_flags & VM_WRITE);
-	}
-out:
-	spin_unlock(&mm->page_table_lock);
-	return ret;
-}
-
 unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 		unsigned long pgoff, unsigned long flags)
 {
diff -Nurp linux-2.6.5/arch/sh/mm/hugetlbpage.c linux-2.6.5.htlb/arch/sh/mm/hugetlbpage.c
--- linux-2.6.5/arch/sh/mm/hugetlbpage.c	2004-04-13 11:26:21.000000000 -0700
+++ linux-2.6.5.htlb/arch/sh/mm/hugetlbpage.c	2004-04-13 11:42:53.000000000 -0700
@@ -13,10 +13,6 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/hugetlb.h>
-#include <linux/pagemap.h>
-#include <linux/smp_lock.h>
-#include <linux/slab.h>
-#include <linux/sysctl.h>

 #include <asm/mman.h>
 #include <asm/pgalloc.h>
@@ -24,7 +20,7 @@
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>

-static pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr)
+pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
 	pmd_t *pmd;
@@ -56,7 +52,7 @@ static pte_t *huge_pte_offset(struct mm_

 #define mk_pte_huge(entry) do { pte_val(entry) |= _PAGE_SZHUGE; } while (0)

-static void set_huge_pte(struct mm_struct *mm, struct vm_area_struct *vma,
+void set_huge_pte(struct mm_struct *mm, struct vm_area_struct *vma,
 			 struct page *page, pte_t * page_table, int write_access)
 {
 	unsigned long i;
@@ -124,47 +120,6 @@ nomem:
 	return -ENOMEM;
 }

-int follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
-			struct page **pages, struct vm_area_struct **vmas,
-			unsigned long *position, int *length, int i)
-{
-	unsigned long vaddr = *position;
-	int remainder = *length;
-
-	WARN_ON(!is_vm_hugetlb_page(vma));
-
-	while (vaddr < vma->vm_end && remainder) {
-		if (pages) {
-			pte_t *pte;
-			struct page *page;
-
-			pte = huge_pte_offset(mm, vaddr);
-
-			/* hugetlb should be locked, and hence, prefaulted */
-			BUG_ON(!pte || pte_none(*pte));
-
-			page = pte_page(*pte);
-
-			WARN_ON(!PageCompound(page));
-
-			get_page(page);
-			pages[i] = page;
-		}
-
-		if (vmas)
-			vmas[i] = vma;
-
-		vaddr += PAGE_SIZE;
-		--remainder;
-		++i;
-	}
-
-	*length = remainder;
-	*position = vaddr;
-
-	return i;
-}
-
 struct page *follow_huge_addr(struct mm_struct *mm,
 			      struct vm_area_struct *vma,
 			      unsigned long address, int write)
@@ -214,48 +169,3 @@ void unmap_hugepage_range(struct vm_area
 	mm->rss -= (end - start) >> PAGE_SHIFT;
 	flush_tlb_range(vma, start, end);
 }
-
-int hugetlb_prefault(struct address_space *mapping, struct vm_area_struct *vma)
-{
-	struct mm_struct *mm = current->mm;
-	unsigned long addr;
-	int ret = 0;
-
-	BUG_ON(vma->vm_start & ~HPAGE_MASK);
-	BUG_ON(vma->vm_end & ~HPAGE_MASK);
-
-	spin_lock(&mm->page_table_lock);
-	for (addr = vma->vm_start; addr < vma->vm_end; addr += HPAGE_SIZE) {
-		unsigned long idx;
-		pte_t *pte = huge_pte_alloc(mm, addr);
-		struct page *page;
-
-		if (!pte) {
-			ret = -ENOMEM;
-			goto out;
-		}
-		if (!pte_none(*pte))
-			continue;
-
-		idx = ((addr - vma->vm_start) >> HPAGE_SHIFT)
-			+ (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));
-		page = find_get_page(mapping, idx);
-		if (!page) {
-			page = alloc_huge_page();
-			if (!page) {
-				ret = -ENOMEM;
-				goto out;
-			}
-			ret = add_to_page_cache(page, mapping, idx, GFP_ATOMIC);
-			unlock_page(page);
-			if (ret) {
-				free_huge_page(page);
-				goto out;
-			}
-		}
-		set_huge_pte(mm, vma, page, pte, vma->vm_flags & VM_WRITE);
-	}
-out:
-	spin_unlock(&mm->page_table_lock);
-	return ret;
-}
diff -Nurp linux-2.6.5/arch/sparc64/mm/hugetlbpage.c linux-2.6.5.htlb/arch/sparc64/mm/hugetlbpage.c
--- linux-2.6.5/arch/sparc64/mm/hugetlbpage.c	2004-04-13 11:26:21.000000000 -0700
+++ linux-2.6.5.htlb/arch/sparc64/mm/hugetlbpage.c	2004-04-13 11:44:06.000000000 -0700
@@ -9,10 +9,6 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/hugetlb.h>
-#include <linux/pagemap.h>
-#include <linux/smp_lock.h>
-#include <linux/slab.h>
-#include <linux/sysctl.h>
 #include <linux/module.h>

 #include <asm/mman.h>
@@ -21,7 +17,7 @@
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>

-static pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr)
+pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
 	pmd_t *pmd;
@@ -53,7 +49,7 @@ static pte_t *huge_pte_offset(struct mm_

 #define mk_pte_huge(entry) do { pte_val(entry) |= _PAGE_SZHUGE; } while (0)

-static void set_huge_pte(struct mm_struct *mm, struct vm_area_struct *vma,
+void set_huge_pte(struct mm_struct *mm, struct vm_area_struct *vma,
 			 struct page *page, pte_t * page_table, int write_access)
 {
 	unsigned long i;
@@ -121,47 +117,6 @@ nomem:
 	return -ENOMEM;
 }

-int follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
-			struct page **pages, struct vm_area_struct **vmas,
-			unsigned long *position, int *length, int i)
-{
-	unsigned long vaddr = *position;
-	int remainder = *length;
-
-	WARN_ON(!is_vm_hugetlb_page(vma));
-
-	while (vaddr < vma->vm_end && remainder) {
-		if (pages) {
-			pte_t *pte;
-			struct page *page;
-
-			pte = huge_pte_offset(mm, vaddr);
-
-			/* hugetlb should be locked, and hence, prefaulted */
-			BUG_ON(!pte || pte_none(*pte));
-
-			page = pte_page(*pte);
-
-			WARN_ON(!PageCompound(page));
-
-			get_page(page);
-			pages[i] = page;
-		}
-
-		if (vmas)
-			vmas[i] = vma;
-
-		vaddr += PAGE_SIZE;
-		--remainder;
-		++i;
-	}
-
-	*length = remainder;
-	*position = vaddr;
-
-	return i;
-}
-
 struct page *follow_huge_addr(struct mm_struct *mm,
 			      struct vm_area_struct *vma,
 			      unsigned long address, int write)
@@ -211,48 +166,3 @@ void unmap_hugepage_range(struct vm_area
 	mm->rss -= (end - start) >> PAGE_SHIFT;
 	flush_tlb_range(vma, start, end);
 }
-
-int hugetlb_prefault(struct address_space *mapping, struct vm_area_struct *vma)
-{
-	struct mm_struct *mm = current->mm;
-	unsigned long addr;
-	int ret = 0;
-
-	BUG_ON(vma->vm_start & ~HPAGE_MASK);
-	BUG_ON(vma->vm_end & ~HPAGE_MASK);
-
-	spin_lock(&mm->page_table_lock);
-	for (addr = vma->vm_start; addr < vma->vm_end; addr += HPAGE_SIZE) {
-		unsigned long idx;
-		pte_t *pte = huge_pte_alloc(mm, addr);
-		struct page *page;
-
-		if (!pte) {
-			ret = -ENOMEM;
-			goto out;
-		}
-		if (!pte_none(*pte))
-			continue;
-
-		idx = ((addr - vma->vm_start) >> HPAGE_SHIFT)
-			+ (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));
-		page = find_get_page(mapping, idx);
-		if (!page) {
-			page = alloc_huge_page();
-			if (!page) {
-				ret = -ENOMEM;
-				goto out;
-			}
-			ret = add_to_page_cache(page, mapping, idx, GFP_ATOMIC);
-			unlock_page(page);
-			if (ret) {
-				free_huge_page(page);
-				goto out;
-			}
-		}
-		set_huge_pte(mm, vma, page, pte, vma->vm_flags & VM_WRITE);
-	}
-out:
-	spin_unlock(&mm->page_table_lock);
-	return ret;
-}


