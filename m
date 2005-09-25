Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbVIYQMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbVIYQMZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 12:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbVIYQMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 12:12:25 -0400
Received: from silver.veritas.com ([143.127.12.111]:28599 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932245AbVIYQMY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 12:12:24 -0400
Date: Sun, 25 Sep 2005 17:11:58 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Paul Mundt <lethal@linux-sh.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 20/21] mm: sh64 hugetlbpage.c
In-Reply-To: <Pine.LNX.4.61.0509251644100.3490@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0509251710200.3490@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0509251644100.3490@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 25 Sep 2005 16:12:23.0993 (UTC) FILETIME=[EA289290:01C5C1EB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The sh64 hugetlbpage.c seems to be erroneous, left over from a bygone
age, clashing with the common hugetlb.c.  Replace it by a copy of the
sh hugetlbpage.c.  Except, delete that mk_pte_huge macro neither uses.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 arch/sh/mm/hugetlbpage.c   |    2 
 arch/sh64/mm/hugetlbpage.c |  188 ++-------------------------------------------
 2 files changed, 12 insertions(+), 178 deletions(-)

--- mm19/arch/sh/mm/hugetlbpage.c	2005-08-29 00:41:01.000000000 +0100
+++ mm20/arch/sh/mm/hugetlbpage.c	2005-09-24 19:30:49.000000000 +0100
@@ -54,8 +54,6 @@ pte_t *huge_pte_offset(struct mm_struct 
 	return pte;
 }
 
-#define mk_pte_huge(entry) do { pte_val(entry) |= _PAGE_SZHUGE; } while (0)
-
 void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 		     pte_t *ptep, pte_t entry)
 {
--- mm19/arch/sh64/mm/hugetlbpage.c	2005-08-29 00:41:01.000000000 +0100
+++ mm20/arch/sh64/mm/hugetlbpage.c	2005-09-24 19:30:49.000000000 +0100
@@ -54,41 +54,31 @@ pte_t *huge_pte_offset(struct mm_struct 
 	return pte;
 }
 
-#define mk_pte_huge(entry) do { pte_val(entry) |= _PAGE_SZHUGE; } while (0)
-
-static void set_huge_pte(struct mm_struct *mm, struct vm_area_struct *vma,
-			 struct page *page, pte_t * page_table, int write_access)
+void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
+		     pte_t *ptep, pte_t entry)
 {
-	unsigned long i;
-	pte_t entry;
-
-	add_mm_counter(mm, rss, HPAGE_SIZE / PAGE_SIZE);
-
-	if (write_access)
-		entry = pte_mkwrite(pte_mkdirty(mk_pte(page,
-						       vma->vm_page_prot)));
-	else
-		entry = pte_wrprotect(mk_pte(page, vma->vm_page_prot));
-	entry = pte_mkyoung(entry);
-	mk_pte_huge(entry);
+	int i;
 
 	for (i = 0; i < (1 << HUGETLB_PAGE_ORDER); i++) {
-		set_pte(page_table, entry);
-		page_table++;
-
+		set_pte_at(mm, addr, ptep, entry);
+		ptep++;
+		addr += PAGE_SIZE;
 		pte_val(entry) += PAGE_SIZE;
 	}
 }
 
-pte_t huge_ptep_get_and_clear(pte_t *ptep)
+pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
+			      pte_t *ptep)
 {
 	pte_t entry;
+	int i;
 
 	entry = *ptep;
 
 	for (i = 0; i < (1 << HUGETLB_PAGE_ORDER); i++) {
-		pte_clear(pte);
-		pte++;
+		pte_clear(mm, addr, ptep);
+		addr += PAGE_SIZE;
+		ptep++;
 	}
 
 	return entry;
@@ -106,79 +96,6 @@ int is_aligned_hugepage_range(unsigned l
 	return 0;
 }
 
-int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
-			    struct vm_area_struct *vma)
-{
-	pte_t *src_pte, *dst_pte, entry;
-	struct page *ptepage;
-	unsigned long addr = vma->vm_start;
-	unsigned long end = vma->vm_end;
-	int i;
-
-	while (addr < end) {
-		dst_pte = huge_pte_alloc(dst, addr);
-		if (!dst_pte)
-			goto nomem;
-		src_pte = huge_pte_offset(src, addr);
-		BUG_ON(!src_pte || pte_none(*src_pte));
-		entry = *src_pte;
-		ptepage = pte_page(entry);
-		get_page(ptepage);
-		for (i = 0; i < (1 << HUGETLB_PAGE_ORDER); i++) {
-			set_pte(dst_pte, entry);
-			pte_val(entry) += PAGE_SIZE;
-			dst_pte++;
-		}
-		add_mm_counter(dst, rss, HPAGE_SIZE / PAGE_SIZE);
-		addr += HPAGE_SIZE;
-	}
-	return 0;
-
-nomem:
-	return -ENOMEM;
-}
-
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
 			      unsigned long address, int write)
 {
@@ -195,84 +112,3 @@ struct page *follow_huge_pmd(struct mm_s
 {
 	return NULL;
 }
-
-void unmap_hugepage_range(struct vm_area_struct *vma,
-			  unsigned long start, unsigned long end)
-{
-	struct mm_struct *mm = vma->vm_mm;
-	unsigned long address;
-	pte_t *pte;
-	struct page *page;
-	int i;
-
-	BUG_ON(start & (HPAGE_SIZE - 1));
-	BUG_ON(end & (HPAGE_SIZE - 1));
-
-	for (address = start; address < end; address += HPAGE_SIZE) {
-		pte = huge_pte_offset(mm, address);
-		BUG_ON(!pte);
-		if (pte_none(*pte))
-			continue;
-		page = pte_page(*pte);
-		put_page(page);
-		for (i = 0; i < (1 << HUGETLB_PAGE_ORDER); i++) {
-			pte_clear(mm, address+(i*PAGE_SIZE), pte);
-			pte++;
-		}
-	}
-	add_mm_counter(mm, rss, -((end - start) >> PAGE_SHIFT));
-	flush_tlb_range(vma, start, end);
-}
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
-			/* charge the fs quota first */
-			if (hugetlb_get_quota(mapping)) {
-				ret = -ENOMEM;
-				goto out;
-			}
-			page = alloc_huge_page();
-			if (!page) {
-				hugetlb_put_quota(mapping);
-				ret = -ENOMEM;
-				goto out;
-			}
-			ret = add_to_page_cache(page, mapping, idx, GFP_ATOMIC);
-			if (! ret) {
-				unlock_page(page);
-			} else {
-				hugetlb_put_quota(mapping);
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
