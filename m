Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261924AbTCYWIU>; Tue, 25 Mar 2003 17:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261905AbTCYWIC>; Tue, 25 Mar 2003 17:08:02 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:38576 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S262302AbTCYWEm>; Tue, 25 Mar 2003 17:04:42 -0500
Date: Tue, 25 Mar 2003 22:17:46 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] swap 07/13 objrmap page_table_lock
In-Reply-To: <Pine.LNX.4.44.0303252209070.12636-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0303252216010.12636-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A recent update removed the page_table_lock from objrmap.  That was
simply wrong: it's necessary to guard mm->rss (in try_to_unmap), and
it's necessary to ensure the page tables don't get freed beneath us
(in which case any modification of the pte, by page_referenced or
by try_to_unmap, might be corrupting a freed and reused page).

Then restore the original SWAP_AGAIN semantics in try_to_unmap:
simplest for inner levels to return SWAP_AGAIN or SWAP_FAILED,
outer level to decide SWAP_SUCCESS if all pages were unmapped.
Stop searching when all have been unmapped.

page_convert_anon left for the moment with FIXMEs rather than
page_table_lock.  I believe it can be done without page_table_lock
(which would be problematic there), but have noticed several other
bugs there, more patches will follow at a later date (though I'd
much rather anobjrmap, which handles all this so much more cleanly).

--- swap06/mm/rmap.c	Tue Mar 25 20:43:51 2003
+++ swap07/mm/rmap.c	Tue Mar 25 20:44:02 2003
@@ -143,9 +143,13 @@
 static int
 page_referenced_obj_one(struct vm_area_struct *vma, struct page *page)
 {
+	struct mm_struct *mm = vma->vm_mm;
 	pte_t *pte;
 	int referenced = 0;
 
+	if (!spin_trylock(&mm->page_table_lock))
+		return 1;
+
 	pte = find_pte(vma, page, NULL);
 	if (pte) {
 		if (ptep_test_and_clear_young(pte))
@@ -153,6 +157,7 @@
 		pte_unmap(pte);
 	}
 
+	spin_unlock(&mm->page_table_lock);
 	return referenced;
 }
 
@@ -489,7 +494,10 @@
 	unsigned long address;
 	pte_t *pte;
 	pte_t pteval;
-	int ret = SWAP_SUCCESS;
+	int ret = SWAP_AGAIN;
+
+	if (!spin_trylock(&mm->page_table_lock))
+		return ret;
 
 	pte = find_pte(vma, page, &address);
 	if (!pte)
@@ -518,6 +526,7 @@
 	pte_unmap(pte);
 
 out:
+	spin_unlock(&mm->page_table_lock);
 	return ret;
 }
 
@@ -538,7 +547,7 @@
 {
 	struct address_space *mapping = page->mapping;
 	struct vm_area_struct *vma;
-	int ret = SWAP_SUCCESS;
+	int ret = SWAP_AGAIN;
 
 	if (!mapping)
 		BUG();
@@ -547,23 +556,20 @@
 		BUG();
 
 	if (down_trylock(&mapping->i_shared_sem))
-		return SWAP_AGAIN;
+		return ret;
 	
 	list_for_each_entry(vma, &mapping->i_mmap, shared) {
 		ret = try_to_unmap_obj_one(vma, page);
-		if (ret != SWAP_SUCCESS)
+		if (ret == SWAP_FAIL || !page->pte.mapcount)
 			goto out;
 	}
 
 	list_for_each_entry(vma, &mapping->i_mmap_shared, shared) {
 		ret = try_to_unmap_obj_one(vma, page);
-		if (ret != SWAP_SUCCESS)
+		if (ret == SWAP_FAIL || !page->pte.mapcount)
 			goto out;
 	}
 
-	if (page->pte.mapcount)
-		BUG();
-
 out:
 	up(&mapping->i_shared_sem);
 	return ret;
@@ -753,8 +759,10 @@
 		}
 	}
 out:
-	if (!page_mapped(page))
+	if (!page_mapped(page)) {
 		dec_page_state(nr_mapped);
+		ret = SWAP_SUCCESS;
+	}
 	return ret;
 }
 
@@ -839,6 +847,7 @@
 
 	index = NRPTE-1;
 	list_for_each_entry(vma, &mapping->i_mmap, shared) {
+		/* FIXME: unsafe without page_table_lock */
 		pte = find_pte(vma, page, NULL);
 		if (pte) {
 			pte_paddr = ptep_to_paddr(pte);
@@ -855,6 +864,7 @@
 		}
 	}
 	list_for_each_entry(vma, &mapping->i_mmap_shared, shared) {
+		/* FIXME: unsafe without page_table_lock */
 		pte = find_pte(vma, page, NULL);
 		if (pte) {
 			pte_paddr = ptep_to_paddr(pte);

