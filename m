Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbUEDWU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbUEDWU1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 18:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbUEDWU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 18:20:26 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:19395 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261378AbUEDWUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 18:20:04 -0400
Date: Tue, 4 May 2004 23:19:56 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] rmap 21 try_to_unmap_one mapcount
In-Reply-To: <Pine.LNX.4.44.0405042315160.2156-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0405042318490.2156-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why should try_to_unmap_anon and try_to_unmap_file take a copy of
page->mapcount and pass it down for try_to_unmap_one to decrement?
why not just check page->mapcount itself? asks akpm.  Perhaps there
used to be a good reason, but not any more: remove the mapcount arg.

 mm/rmap.c |   26 ++++++++++----------------
 1 files changed, 10 insertions(+), 16 deletions(-)

--- rmap20/mm/rmap.c	2004-05-04 21:21:28.897449704 +0100
+++ rmap21/mm/rmap.c	2004-05-04 21:21:39.928772688 +0100
@@ -466,9 +466,8 @@ int fastcall mremap_move_anon_rmap(struc
  ** repeatedly from either try_to_unmap_anon or try_to_unmap_file.
  **/
 
-static int try_to_unmap_one(struct page *page,
-	struct mm_struct *mm, unsigned long address,
-	unsigned int *mapcount, struct vm_area_struct *vma)
+static int try_to_unmap_one(struct page *page, struct mm_struct *mm,
+		unsigned long address, struct vm_area_struct *vma)
 {
 	pgd_t *pgd;
 	pmd_t *pmd;
@@ -498,8 +497,6 @@ static int try_to_unmap_one(struct page 
 	if (page_to_pfn(page) != pte_pfn(*pte))
 		goto out_unmap;
 
-	(*mapcount)--;
-
 	if (!vma) {
 		vma = find_vma(mm, address);
 		/* unmap_vmas drops page_table_lock with vma unlinked */
@@ -643,7 +640,6 @@ out_unlock:
 
 static inline int try_to_unmap_anon(struct page *page)
 {
-	unsigned int mapcount = page->mapcount;
 	struct anonmm *anonmm = (struct anonmm *) page->mapping;
 	struct anonmm *anonhd = anonmm->head;
 	struct list_head *seek_head;
@@ -654,9 +650,8 @@ static inline int try_to_unmap_anon(stru
 	 * First try the indicated mm, it's the most likely.
 	 */
 	if (anonmm->mm && anonmm->mm->rss) {
-		ret = try_to_unmap_one(page,
-			anonmm->mm, page->index, &mapcount, NULL);
-		if (ret == SWAP_FAIL || !mapcount)
+		ret = try_to_unmap_one(page, anonmm->mm, page->index, NULL);
+		if (ret == SWAP_FAIL || !page->mapcount)
 			goto out;
 	}
 
@@ -670,9 +665,8 @@ static inline int try_to_unmap_anon(stru
 	list_for_each_entry(anonmm, seek_head, list) {
 		if (!anonmm->mm || !anonmm->mm->rss)
 			continue;
-		ret = try_to_unmap_one(page,
-			anonmm->mm, page->index, &mapcount, NULL);
-		if (ret == SWAP_FAIL || !mapcount)
+		ret = try_to_unmap_one(page, anonmm->mm, page->index, NULL);
+		if (ret == SWAP_FAIL || !page->mapcount)
 			goto out;
 	}
 out:
@@ -694,7 +688,6 @@ out:
  */
 static inline int try_to_unmap_file(struct page *page)
 {
-	unsigned int mapcount = page->mapcount;
 	struct address_space *mapping = page->mapping;
 	pgoff_t pgoff = page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
 	struct vm_area_struct *vma = NULL;
@@ -704,6 +697,7 @@ static inline int try_to_unmap_file(stru
 	unsigned long cursor;
 	unsigned long max_nl_cursor = 0;
 	unsigned long max_nl_size = 0;
+	unsigned int mapcount;
 
 	if (!spin_trylock(&mapping->i_shared_lock))
 		return ret;
@@ -712,9 +706,8 @@ static inline int try_to_unmap_file(stru
 					&iter, pgoff, pgoff)) != NULL) {
 		if (vma->vm_mm->rss) {
 			address = vma_address(vma, pgoff);
-			ret = try_to_unmap_one(page,
-				vma->vm_mm, address, &mapcount, vma);
-			if (ret == SWAP_FAIL || !mapcount)
+			ret = try_to_unmap_one(page, vma->vm_mm, address, vma);
+			if (ret == SWAP_FAIL || !page->mapcount)
 				goto out;
 		}
 	}
@@ -744,6 +737,7 @@ static inline int try_to_unmap_file(stru
 	 * The mapcount of the page we came in with is irrelevant,
 	 * but even so use it as a guide to how hard we should try?
 	 */
+	mapcount = page->mapcount;
 	rmap_unlock(page);
 	cond_resched_lock(&mapping->i_shared_lock);
 

