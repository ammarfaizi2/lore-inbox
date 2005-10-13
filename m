Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964852AbVJMBVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbVJMBVx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 21:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbVJMBVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 21:21:52 -0400
Received: from silver.veritas.com ([143.127.12.111]:6040 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S964852AbVJMBVv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 21:21:51 -0400
Date: Thu, 13 Oct 2005 02:21:07 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 19/21] mm: rmap with inner ptlock
In-Reply-To: <Pine.LNX.4.61.0510130143240.4060@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0510130220260.4343@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0510130143240.4060@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 13 Oct 2005 01:21:51.0508 (UTC) FILETIME=[7D59E540:01C5CF94]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rmap's page_check_address descend without page_table_lock.  First just
pte_offset_map in case there's no pte present worth locking for, then
take page_table_lock for the full check, and pass ptl back to caller in
the same style as pte_offset_map_lock.  __xip_unmap, page_referenced_one
and try_to_unmap_one use pte_unmap_unlock.  try_to_unmap_cluster also.

page_check_address reformatted to avoid progressive indentation.
No use is made of its one error code, return NULL when it fails.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 include/linux/rmap.h |    4 -
 mm/filemap_xip.c     |   12 +----
 mm/rmap.c            |  109 +++++++++++++++++++++++++--------------------------
 3 files changed, 60 insertions(+), 65 deletions(-)

--- mm18/include/linux/rmap.h	2005-08-29 00:41:01.000000000 +0100
+++ mm19/include/linux/rmap.h	2005-10-11 23:58:30.000000000 +0100
@@ -95,8 +95,8 @@ int try_to_unmap(struct page *);
 /*
  * Called from mm/filemap_xip.c to unmap empty zero page
  */
-pte_t *page_check_address(struct page *, struct mm_struct *, unsigned long);
-
+pte_t *page_check_address(struct page *, struct mm_struct *,
+				unsigned long, spinlock_t **);
 
 /*
  * Used by swapoff to help locate where page is expected in vma.
--- mm18/mm/filemap_xip.c	2005-10-11 23:58:14.000000000 +0100
+++ mm19/mm/filemap_xip.c	2005-10-11 23:58:30.000000000 +0100
@@ -174,6 +174,7 @@ __xip_unmap (struct address_space * mapp
 	unsigned long address;
 	pte_t *pte;
 	pte_t pteval;
+	spinlock_t *ptl;
 	struct page *page;
 
 	spin_lock(&mapping->i_mmap_lock);
@@ -183,20 +184,15 @@ __xip_unmap (struct address_space * mapp
 			((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
 		BUG_ON(address < vma->vm_start || address >= vma->vm_end);
 		page = ZERO_PAGE(address);
-		/*
-		 * We need the page_table_lock to protect us from page faults,
-		 * munmap, fork, etc...
-		 */
-		pte = page_check_address(page, mm, address);
-		if (!IS_ERR(pte)) {
+		pte = page_check_address(page, mm, address, &ptl);
+		if (pte) {
 			/* Nuke the page table entry. */
 			flush_cache_page(vma, address, pte_pfn(*pte));
 			pteval = ptep_clear_flush(vma, address, pte);
 			page_remove_rmap(page);
 			dec_mm_counter(mm, file_rss);
 			BUG_ON(pte_dirty(pteval));
-			pte_unmap(pte);
-			spin_unlock(&mm->page_table_lock);
+			pte_unmap_unlock(pte, ptl);
 			page_cache_release(page);
 		}
 	}
--- mm18/mm/rmap.c	2005-10-11 23:54:33.000000000 +0100
+++ mm19/mm/rmap.c	2005-10-11 23:58:30.000000000 +0100
@@ -247,34 +247,41 @@ unsigned long page_address_in_vma(struct
  * On success returns with mapped pte and locked mm->page_table_lock.
  */
 pte_t *page_check_address(struct page *page, struct mm_struct *mm,
-			  unsigned long address)
+			  unsigned long address, spinlock_t **ptlp)
 {
 	pgd_t *pgd;
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
+	spinlock_t *ptl;
 
-	/*
-	 * We need the page_table_lock to protect us from page faults,
-	 * munmap, fork, etc...
-	 */
-	spin_lock(&mm->page_table_lock);
 	pgd = pgd_offset(mm, address);
-	if (likely(pgd_present(*pgd))) {
-		pud = pud_offset(pgd, address);
-		if (likely(pud_present(*pud))) {
-			pmd = pmd_offset(pud, address);
-			if (likely(pmd_present(*pmd))) {
-				pte = pte_offset_map(pmd, address);
-				if (likely(pte_present(*pte) &&
-					   page_to_pfn(page) == pte_pfn(*pte)))
-					return pte;
-				pte_unmap(pte);
-			}
-		}
+	if (!pgd_present(*pgd))
+		return NULL;
+
+	pud = pud_offset(pgd, address);
+	if (!pud_present(*pud))
+		return NULL;
+
+	pmd = pmd_offset(pud, address);
+	if (!pmd_present(*pmd))
+		return NULL;
+
+	pte = pte_offset_map(pmd, address);
+	/* Make a quick check before getting the lock */
+	if (!pte_present(*pte)) {
+		pte_unmap(pte);
+		return NULL;
+	}
+
+	ptl = &mm->page_table_lock;
+	spin_lock(ptl);
+	if (pte_present(*pte) && page_to_pfn(page) == pte_pfn(*pte)) {
+		*ptlp = ptl;
+		return pte;
 	}
-	spin_unlock(&mm->page_table_lock);
-	return ERR_PTR(-ENOENT);
+	pte_unmap_unlock(pte, ptl);
+	return NULL;
 }
 
 /*
@@ -287,28 +294,28 @@ static int page_referenced_one(struct pa
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long address;
 	pte_t *pte;
+	spinlock_t *ptl;
 	int referenced = 0;
 
 	address = vma_address(page, vma);
 	if (address == -EFAULT)
 		goto out;
 
-	pte = page_check_address(page, mm, address);
-	if (!IS_ERR(pte)) {
-		if (ptep_clear_flush_young(vma, address, pte))
-			referenced++;
+	pte = page_check_address(page, mm, address, &ptl);
+	if (!pte)
+		goto out;
 
-		/* Pretend the page is referenced if the task has the
-		   swap token and is in the middle of a page fault. */
-		if (mm != current->mm && !ignore_token &&
-				has_swap_token(mm) &&
-				rwsem_is_locked(&mm->mmap_sem))
-			referenced++;
+	if (ptep_clear_flush_young(vma, address, pte))
+		referenced++;
 
-		(*mapcount)--;
-		pte_unmap(pte);
-		spin_unlock(&mm->page_table_lock);
-	}
+	/* Pretend the page is referenced if the task has the
+	   swap token and is in the middle of a page fault. */
+	if (mm != current->mm && !ignore_token && has_swap_token(mm) &&
+			rwsem_is_locked(&mm->mmap_sem))
+		referenced++;
+
+	(*mapcount)--;
+	pte_unmap_unlock(pte, ptl);
 out:
 	return referenced;
 }
@@ -507,14 +514,15 @@ static int try_to_unmap_one(struct page 
 	unsigned long address;
 	pte_t *pte;
 	pte_t pteval;
+	spinlock_t *ptl;
 	int ret = SWAP_AGAIN;
 
 	address = vma_address(page, vma);
 	if (address == -EFAULT)
 		goto out;
 
-	pte = page_check_address(page, mm, address);
-	if (IS_ERR(pte))
+	pte = page_check_address(page, mm, address, &ptl);
+	if (!pte)
 		goto out;
 
 	/*
@@ -564,8 +572,7 @@ static int try_to_unmap_one(struct page 
 	page_cache_release(page);
 
 out_unmap:
-	pte_unmap(pte);
-	spin_unlock(&mm->page_table_lock);
+	pte_unmap_unlock(pte, ptl);
 out:
 	return ret;
 }
@@ -599,19 +606,14 @@ static void try_to_unmap_cluster(unsigne
 	pgd_t *pgd;
 	pud_t *pud;
 	pmd_t *pmd;
-	pte_t *pte, *original_pte;
+	pte_t *pte;
 	pte_t pteval;
+	spinlock_t *ptl;
 	struct page *page;
 	unsigned long address;
 	unsigned long end;
 	unsigned long pfn;
 
-	/*
-	 * We need the page_table_lock to protect us from page faults,
-	 * munmap, fork, etc...
-	 */
-	spin_lock(&mm->page_table_lock);
-
 	address = (vma->vm_start + cursor) & CLUSTER_MASK;
 	end = address + CLUSTER_SIZE;
 	if (address < vma->vm_start)
@@ -621,22 +623,22 @@ static void try_to_unmap_cluster(unsigne
 
 	pgd = pgd_offset(mm, address);
 	if (!pgd_present(*pgd))
-		goto out_unlock;
+		return;
 
 	pud = pud_offset(pgd, address);
 	if (!pud_present(*pud))
-		goto out_unlock;
+		return;
 
 	pmd = pmd_offset(pud, address);
 	if (!pmd_present(*pmd))
-		goto out_unlock;
+		return;
+
+	pte = pte_offset_map_lock(mm, pmd, address, &ptl);
 
 	/* Update high watermark before we lower rss */
 	update_hiwater_rss(mm);
 
-	for (original_pte = pte = pte_offset_map(pmd, address);
-			address < end; pte++, address += PAGE_SIZE) {
-
+	for (; address < end; pte++, address += PAGE_SIZE) {
 		if (!pte_present(*pte))
 			continue;
 
@@ -669,10 +671,7 @@ static void try_to_unmap_cluster(unsigne
 		dec_mm_counter(mm, file_rss);
 		(*mapcount)--;
 	}
-
-	pte_unmap(original_pte);
-out_unlock:
-	spin_unlock(&mm->page_table_lock);
+	pte_unmap_unlock(pte - 1, ptl);
 }
 
 static int try_to_unmap_anon(struct page *page)
