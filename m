Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbUCUWSN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 17:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbUCUWR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 17:17:56 -0500
Received: from struggle.mr.itd.umich.edu ([141.211.14.79]:35240 "EHLO
	struggle.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id S261392AbUCUWNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 17:13:18 -0500
Date: Sun, 21 Mar 2004 17:13:09 -0500 (EST)
From: Rajesh Venkatasubramanian <vrajesh@umich.edu>
X-X-Sender: vrajesh@rust.engin.umich.edu
To: akpm@osdl.org
cc: torvalds@osdl.org, hugh@veritas.com, mbligh@aracnet.com, andrea@suse.de,
       riel@redhat.com, mingo@elte.hu, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [RFC][PATCH 3/3] Covert objrmap to use prio_tree... 
In-Reply-To: <Pine.GSO.4.58.0403211634350.10248@azure.engin.umich.edu>
Message-ID: <Pine.LNX.4.58.0403211712300.29552@rust.engin.umich.edu>
References: <Pine.LNX.4.44.0403150527400.28579-100000@localhost.localdomain>
 <Pine.GSO.4.58.0403211634350.10248@azure.engin.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Convert mm/rmap.c to prio_tree...



 mm/rmap.c |   50 +++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 43 insertions(+), 7 deletions(-)

diff -puN mm/rmap.c~objrmap_prio_tree mm/rmap.c
--- mmlinux-2.6/mm/rmap.c~objrmap_prio_tree	2004-03-21 16:25:12.000000000 -0500
+++ mmlinux-2.6-jaya/mm/rmap.c	2004-03-21 16:25:12.000000000 -0500
@@ -129,7 +129,7 @@ find_pte(struct vm_area_struct *vma, str
 	loffset = (page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT));
 	address = vma->vm_start + ((loffset - vma->vm_pgoff) << PAGE_SHIFT);
 	if (address < vma->vm_start || address >= vma->vm_end)
-		goto out;
+		BUG();

 	pgd = pgd_offset(mm, address);
 	if (!pgd_present(*pgd))
@@ -207,6 +207,8 @@ page_referenced_obj(struct page *page)
 {
 	struct address_space *mapping = page->mapping;
 	struct vm_area_struct *vma;
+	struct prio_tree_iter iter;
+	unsigned long loffset;
 	int referenced = 0;

 	if (!page->pte.mapcount)
@@ -221,11 +223,22 @@ page_referenced_obj(struct page *page)
 	if (down_trylock(&mapping->i_shared_sem))
 		return 1;

-	list_for_each_entry(vma, &mapping->i_mmap, shared)
+	loffset = (page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT));
+
+	vma = __vma_prio_tree_first(&mapping->i_mmap, &iter, loffset, loffset);
+	while (vma) {
 		referenced += page_referenced_obj_one(vma, page);
+		vma = __vma_prio_tree_next(vma, &mapping->i_mmap, &iter,
+				loffset, loffset);
+	}

-	list_for_each_entry(vma, &mapping->i_mmap_shared, shared)
+	vma = __vma_prio_tree_first(&mapping->i_mmap_shared, &iter, loffset,
+			loffset);
+	while (vma) {
 		referenced += page_referenced_obj_one(vma, page);
+		vma = __vma_prio_tree_next(vma, &mapping->i_mmap_shared, &iter,
+				loffset, loffset);
+	}

 	up(&mapping->i_shared_sem);

@@ -511,6 +524,8 @@ try_to_unmap_obj(struct page *page)
 {
 	struct address_space *mapping = page->mapping;
 	struct vm_area_struct *vma;
+	struct prio_tree_iter iter;
+	unsigned long loffset;
 	int ret = SWAP_AGAIN;

 	if (!mapping)
@@ -522,16 +537,25 @@ try_to_unmap_obj(struct page *page)
 	if (down_trylock(&mapping->i_shared_sem))
 		return ret;

-	list_for_each_entry(vma, &mapping->i_mmap, shared) {
+	loffset = (page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT));
+
+	vma = __vma_prio_tree_first(&mapping->i_mmap, &iter, loffset, loffset);
+	while (vma) {
 		ret = try_to_unmap_obj_one(vma, page);
 		if (ret == SWAP_FAIL || !page->pte.mapcount)
 			goto out;
+		vma = __vma_prio_tree_next(vma, &mapping->i_mmap, &iter,
+				loffset, loffset);
 	}

-	list_for_each_entry(vma, &mapping->i_mmap_shared, shared) {
+	vma = __vma_prio_tree_first(&mapping->i_mmap_shared, &iter, loffset,
+			loffset);
+	while (vma) {
 		ret = try_to_unmap_obj_one(vma, page);
 		if (ret == SWAP_FAIL || !page->pte.mapcount)
 			goto out;
+		vma = __vma_prio_tree_next(vma, &mapping->i_mmap_shared, &iter,
+				loffset, loffset);
 	}

 out:
@@ -749,6 +773,8 @@ int page_convert_anon(struct page *page)
 	struct address_space *mapping;
 	struct vm_area_struct *vma;
 	struct pte_chain *pte_chain = NULL;
+	struct prio_tree_iter iter;
+	unsigned long loffset;
 	pte_t *pte;
 	int err = 0;

@@ -783,7 +809,10 @@ int page_convert_anon(struct page *page)
 	 */
 	pte_chain_unlock(page);

-	list_for_each_entry(vma, &mapping->i_mmap, shared) {
+	loffset = (page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT));
+
+	vma = __vma_prio_tree_first(&mapping->i_mmap, &iter, loffset, loffset);
+	while (vma) {
 		if (!pte_chain) {
 			pte_chain = pte_chain_alloc(GFP_KERNEL);
 			if (!pte_chain) {
@@ -800,8 +829,13 @@ int page_convert_anon(struct page *page)
 			pte_unmap(pte);
 		}
 		spin_unlock(&vma->vm_mm->page_table_lock);
+		vma = __vma_prio_tree_next(vma, &mapping->i_mmap, &iter,
+				loffset, loffset);
 	}
-	list_for_each_entry(vma, &mapping->i_mmap_shared, shared) {
+
+	vma = __vma_prio_tree_first(&mapping->i_mmap_shared, &iter, loffset,
+			loffset);
+	while (vma) {
 		if (!pte_chain) {
 			pte_chain = pte_chain_alloc(GFP_KERNEL);
 			if (!pte_chain) {
@@ -818,6 +852,8 @@ int page_convert_anon(struct page *page)
 			pte_unmap(pte);
 		}
 		spin_unlock(&vma->vm_mm->page_table_lock);
+		vma = __vma_prio_tree_next(vma, &mapping->i_mmap_shared, &iter,
+				loffset, loffset);
 	}

 out_unlock:

_

