Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262253AbVCIW3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbVCIW3T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 17:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262084AbVCIW2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 17:28:19 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:57671 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262373AbVCIWNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 17:13:22 -0500
Date: Wed, 9 Mar 2005 22:12:40 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 10/15] ptwalk: copy_page_range
In-Reply-To: <Pine.LNX.4.61.0503092201070.6070@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0503092212110.6070@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503092201070.6070@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert copy_page_range pagetable walkers to loops using p?d_addr_end.
Merge copy_swap_pte into copy_one_pte, make a few minor tidyups.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/memory.c |  141 ++++++++++++++++++++++++------------------------------------
 1 files changed, 57 insertions(+), 84 deletions(-)

--- ptwalk9/mm/memory.c	2005-03-09 01:38:00.000000000 +0000
+++ ptwalk10/mm/memory.c	2005-03-09 01:38:12.000000000 +0000
@@ -260,20 +260,7 @@ out:
  */
 
 static inline void
-copy_swap_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm, pte_t pte)
-{
-	if (pte_file(pte))
-		return;
-	swap_duplicate(pte_to_swp_entry(pte));
-	if (list_empty(&dst_mm->mmlist)) {
-		spin_lock(&mmlist_lock);
-		list_add(&dst_mm->mmlist, &src_mm->mmlist);
-		spin_unlock(&mmlist_lock);
-	}
-}
-
-static inline void
-copy_one_pte(struct mm_struct *dst_mm,  struct mm_struct *src_mm,
+copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		pte_t *dst_pte, pte_t *src_pte, unsigned long vm_flags,
 		unsigned long addr)
 {
@@ -281,12 +268,21 @@ copy_one_pte(struct mm_struct *dst_mm,  
 	struct page *page;
 	unsigned long pfn;
 
-	/* pte contains position in swap, so copy. */
-	if (!pte_present(pte)) {
-		copy_swap_pte(dst_mm, src_mm, pte);
+	/* pte contains position in swap or file, so copy. */
+	if (unlikely(!pte_present(pte))) {
+		if (!pte_file(pte)) {
+			swap_duplicate(pte_to_swp_entry(pte));
+			/* make sure dst_mm is on swapoff's mmlist. */
+			if (unlikely(list_empty(&dst_mm->mmlist))) {
+				spin_lock(&mmlist_lock);
+				list_add(&dst_mm->mmlist, &src_mm->mmlist);
+				spin_unlock(&mmlist_lock);
+			}
+		}
 		set_pte_at(dst_mm, addr, dst_pte, pte);
 		return;
 	}
+
 	pfn = pte_pfn(pte);
 	/* the pte points outside of valid memory, the
 	 * mapping is assumed to be good, meaningful
@@ -326,25 +322,21 @@ copy_one_pte(struct mm_struct *dst_mm,  
 	page_dup_rmap(page);
 }
 
-static int copy_pte_range(struct mm_struct *dst_mm,  struct mm_struct *src_mm,
+static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		pmd_t *dst_pmd, pmd_t *src_pmd, struct vm_area_struct *vma,
 		unsigned long addr, unsigned long end)
 {
 	pte_t *src_pte, *dst_pte;
-	pte_t *s, *d;
 	unsigned long vm_flags = vma->vm_flags;
 
 again:
-	d = dst_pte = pte_alloc_map(dst_mm, dst_pmd, addr);
+	dst_pte = pte_alloc_map(dst_mm, dst_pmd, addr);
 	if (!dst_pte)
 		return -ENOMEM;
+	src_pte = pte_offset_map_nested(src_pmd, addr);
 
 	spin_lock(&src_mm->page_table_lock);
-	s = src_pte = pte_offset_map_nested(src_pmd, addr);
-	for (; addr < end; s++, d++) {
-		if (!pte_none(*s))
-			copy_one_pte(dst_mm, src_mm, d, s, vm_flags, addr);
-		addr += PAGE_SIZE;
+	do {
 		/*
 		 * We are holding two locks at this point - either of them
 		 * could generate latencies in another task on another CPU.
@@ -353,105 +345,86 @@ again:
 		    need_lockbreak(&src_mm->page_table_lock) ||
 		    need_lockbreak(&dst_mm->page_table_lock))
 			break;
-	}
-	pte_unmap_nested(src_pte);
-	pte_unmap(dst_pte);
+		if (pte_none(*src_pte))
+			continue;
+		copy_one_pte(dst_mm, src_mm, dst_pte, src_pte, vm_flags, addr);
+	} while (dst_pte++, src_pte++, addr += PAGE_SIZE, addr != end);
 	spin_unlock(&src_mm->page_table_lock);
 
+	pte_unmap_nested(src_pte - 1);
+	pte_unmap(dst_pte - 1);
 	cond_resched_lock(&dst_mm->page_table_lock);
-	if (addr < end)
+	if (addr != end)
 		goto again;
 	return 0;
 }
 
-static int copy_pmd_range(struct mm_struct *dst_mm,  struct mm_struct *src_mm,
+static int copy_pmd_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		pud_t *dst_pud, pud_t *src_pud, struct vm_area_struct *vma,
 		unsigned long addr, unsigned long end)
 {
 	pmd_t *src_pmd, *dst_pmd;
-	int err = 0;
 	unsigned long next;
 
-	src_pmd = pmd_offset(src_pud, addr);
 	dst_pmd = pmd_alloc(dst_mm, dst_pud, addr);
 	if (!dst_pmd)
 		return -ENOMEM;
-
-	for (; addr < end; addr = next, src_pmd++, dst_pmd++) {
-		next = (addr + PMD_SIZE) & PMD_MASK;
-		if (next > end || next <= addr)
-			next = end;
+	src_pmd = pmd_offset(src_pud, addr);
+	do {
+		next = pmd_addr_end(addr, end);
 		if (pmd_none_or_clear_bad(src_pmd))
 			continue;
-		err = copy_pte_range(dst_mm, src_mm, dst_pmd, src_pmd,
-							vma, addr, next);
-		if (err)
-			break;
-	}
-	return err;
+		if (copy_pte_range(dst_mm, src_mm, dst_pmd, src_pmd,
+						vma, addr, next))
+			return -ENOMEM;
+	} while (dst_pmd++, src_pmd++, addr = next, addr != end);
+	return 0;
 }
 
-static int copy_pud_range(struct mm_struct *dst_mm,  struct mm_struct *src_mm,
+static int copy_pud_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		pgd_t *dst_pgd, pgd_t *src_pgd, struct vm_area_struct *vma,
 		unsigned long addr, unsigned long end)
 {
 	pud_t *src_pud, *dst_pud;
-	int err = 0;
 	unsigned long next;
 
-	src_pud = pud_offset(src_pgd, addr);
 	dst_pud = pud_alloc(dst_mm, dst_pgd, addr);
 	if (!dst_pud)
 		return -ENOMEM;
-
-	for (; addr < end; addr = next, src_pud++, dst_pud++) {
-		next = (addr + PUD_SIZE) & PUD_MASK;
-		if (next > end || next <= addr)
-			next = end;
+	src_pud = pud_offset(src_pgd, addr);
+	do {
+		next = pud_addr_end(addr, end);
 		if (pud_none_or_clear_bad(src_pud))
 			continue;
-		err = copy_pmd_range(dst_mm, src_mm, dst_pud, src_pud,
-							vma, addr, next);
-		if (err)
-			break;
-	}
-	return err;
+		if (copy_pmd_range(dst_mm, src_mm, dst_pud, src_pud,
+						vma, addr, next))
+			return -ENOMEM;
+	} while (dst_pud++, src_pud++, addr = next, addr != end);
+	return 0;
 }
 
-int copy_page_range(struct mm_struct *dst, struct mm_struct *src,
+int copy_page_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		struct vm_area_struct *vma)
 {
 	pgd_t *src_pgd, *dst_pgd;
-	unsigned long addr, start, end, next;
-	int err = 0;
+	unsigned long next;
+	unsigned long addr = vma->vm_start;
+	unsigned long end = vma->vm_end;
 
 	if (is_vm_hugetlb_page(vma))
-		return copy_hugetlb_page_range(dst, src, vma);
+		return copy_hugetlb_page_range(dst_mm, src_mm, vma);
 
-	start = vma->vm_start;
-	src_pgd = pgd_offset(src, start);
-	dst_pgd = pgd_offset(dst, start);
-
-	end = vma->vm_end;
-	addr = start;
-	while (addr && (addr < end-1)) {
-		next = (addr + PGDIR_SIZE) & PGDIR_MASK;
-		if (next > end || next <= addr)
-			next = end;
+	dst_pgd = pgd_offset(dst_mm, addr);
+	src_pgd = pgd_offset(src_mm, addr);
+	do {
+		next = pgd_addr_end(addr, end);
 		if (pgd_none_or_clear_bad(src_pgd))
-			goto next_pgd;
-		err = copy_pud_range(dst, src, dst_pgd, src_pgd,
-							vma, addr, next);
-		if (err)
-			break;
-
-next_pgd:
-		src_pgd++;
-		dst_pgd++;
-		addr = next;
-	}
-
-	return err;
+			continue;
+		if (copy_pud_range(dst_mm, src_mm, dst_pgd, src_pgd,
+						vma, addr, next))
+			return -ENOMEM;
+	} while (dst_pgd++, src_pgd++, addr = next, addr != end);
+	return 0;
 }
 
 static void zap_pte_range(struct mmu_gather *tlb, pmd_t *pmd,
