Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965010AbWALD0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965010AbWALD0I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 22:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965011AbWALD0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 22:26:08 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:4572 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965010AbWALD0H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 22:26:07 -0500
Date: Wed, 11 Jan 2006 19:25:53 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: cpw@sgi.com, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net, taka@valinux.co.jp,
       kamezawa.hiroyu@jp.fujitsu.com
Subject: Re: [PATCH 2/5] Direct Migration V9: migrate_pages() extension
In-Reply-To: <20060110214648.4d54da7c.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0601111919020.26549@schroedinger.engr.sgi.com>
References: <20060110224114.19138.10463.sendpatchset@schroedinger.engr.sgi.com>
 <20060110224124.19138.36811.sendpatchset@schroedinger.engr.sgi.com>
 <20060110214648.4d54da7c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jan 2006, Andrew Morton wrote:

> So I'd suggest that this part needs a bit of a rethink.  If we really need
> to run other processes then try a schedule_timeout_uninterruptible(1).  If
> not, just remove the loop.
> 
> Please stick a printk in there, work out how often and under which
> workloads that loop is actually doing something useful.

The loop is there to call try_to_unmap until it replaces all ptes
with swap ptes. The problem is that try_to_unmap may return SWAP_FAIL
if a pte was recently referenced and do nothing.

Lets go back to the way the old hotplug code did it. Modify 
try_to_unmap() to take an additional parameter so that the reference
bit in the ptes does not cause a SWAP_FAIL. Another option would be to 
modify try_to_unmap to return an additional status SWAP_REFERENCE and
call try_to_unmap until another status is returned.




Add a parameter to try_to_unmap and friends to not return
SWAP_FAIL if a newly referenced pte is encountered.

Then replace the loop in migrate_page_remove_references()
with an invokation of try_to_unmap with that parameter.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15/mm/vmscan.c
===================================================================
--- linux-2.6.15.orig/mm/vmscan.c	2006-01-11 19:22:01.000000000 -0800
+++ linux-2.6.15/mm/vmscan.c	2006-01-11 19:22:07.000000000 -0800
@@ -472,7 +472,7 @@ static int shrink_list(struct list_head 
 		 * processes. Try to unmap it here.
 		 */
 		if (page_mapped(page) && mapping) {
-			switch (try_to_unmap(page)) {
+			switch (try_to_unmap(page, 0)) {
 			case SWAP_FAIL:
 				goto activate_locked;
 			case SWAP_AGAIN:
@@ -621,7 +621,7 @@ static int swap_page(struct page *page)
 	struct address_space *mapping = page_mapping(page);
 
 	if (page_mapped(page) && mapping)
-		if (try_to_unmap(page) != SWAP_SUCCESS)
+		if (try_to_unmap(page, 0) != SWAP_SUCCESS)
 			goto unlock_retry;
 
 	if (PageDirty(page)) {
@@ -677,7 +677,6 @@ int migrate_page_remove_references(struc
 {
 	struct address_space *mapping = page_mapping(page);
 	struct page **radix_pointer;
-	int i;
 
 	/*
 	 * Avoid doing any of the following work if the page count
@@ -706,17 +705,7 @@ int migrate_page_remove_references(struc
 	 * If the page was not migrated then the PageSwapCache bit
 	 * is still set and the operation may continue.
 	 */
-	for(i = 0; i < 10 && page_mapped(page); i++) {
-		int rc = try_to_unmap(page);
-
-		if (rc == SWAP_SUCCESS)
-			break;
-		/*
-		 * If there are other runnable processes then running
-		 * them may make it possible to unmap the page
-		 */
-		schedule();
-	}
+	try_to_unmap(page, 1);
 
 	/*
 	 * Give up if we were unable to remove all mappings.
Index: linux-2.6.15/mm/rmap.c
===================================================================
--- linux-2.6.15.orig/mm/rmap.c	2006-01-11 19:22:00.000000000 -0800
+++ linux-2.6.15/mm/rmap.c	2006-01-11 19:22:07.000000000 -0800
@@ -571,7 +571,8 @@ void page_remove_rmap(struct page *page)
  * Subfunctions of try_to_unmap: try_to_unmap_one called
  * repeatedly from either try_to_unmap_anon or try_to_unmap_file.
  */
-static int try_to_unmap_one(struct page *page, struct vm_area_struct *vma)
+static int try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
+				int ignore_refs)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long address;
@@ -594,7 +595,8 @@ static int try_to_unmap_one(struct page 
 	 * skipped over this mm) then we should reactivate it.
 	 */
 	if ((vma->vm_flags & VM_LOCKED) ||
-			ptep_clear_flush_young(vma, address, pte)) {
+			(ptep_clear_flush_young(vma, address, pte)
+				&& !ignore_refs)) {
 		ret = SWAP_FAIL;
 		goto out_unmap;
 	}
@@ -728,7 +730,7 @@ static void try_to_unmap_cluster(unsigne
 	pte_unmap_unlock(pte - 1, ptl);
 }
 
-static int try_to_unmap_anon(struct page *page)
+static int try_to_unmap_anon(struct page *page, int ignore_refs)
 {
 	struct anon_vma *anon_vma;
 	struct vm_area_struct *vma;
@@ -739,7 +741,7 @@ static int try_to_unmap_anon(struct page
 		return ret;
 
 	list_for_each_entry(vma, &anon_vma->head, anon_vma_node) {
-		ret = try_to_unmap_one(page, vma);
+		ret = try_to_unmap_one(page, vma, ignore_refs);
 		if (ret == SWAP_FAIL || !page_mapped(page))
 			break;
 	}
@@ -756,7 +758,7 @@ static int try_to_unmap_anon(struct page
  *
  * This function is only called from try_to_unmap for object-based pages.
  */
-static int try_to_unmap_file(struct page *page)
+static int try_to_unmap_file(struct page *page, int ignore_refs)
 {
 	struct address_space *mapping = page->mapping;
 	pgoff_t pgoff = page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
@@ -770,7 +772,7 @@ static int try_to_unmap_file(struct page
 
 	spin_lock(&mapping->i_mmap_lock);
 	vma_prio_tree_foreach(vma, &iter, &mapping->i_mmap, pgoff, pgoff) {
-		ret = try_to_unmap_one(page, vma);
+		ret = try_to_unmap_one(page, vma, ignore_refs);
 		if (ret == SWAP_FAIL || !page_mapped(page))
 			goto out;
 	}
@@ -855,16 +857,16 @@ out:
  * SWAP_AGAIN	- we missed a mapping, try again later
  * SWAP_FAIL	- the page is unswappable
  */
-int try_to_unmap(struct page *page)
+int try_to_unmap(struct page *page, int ignore_refs)
 {
 	int ret;
 
 	BUG_ON(!PageLocked(page));
 
 	if (PageAnon(page))
-		ret = try_to_unmap_anon(page);
+		ret = try_to_unmap_anon(page, ignore_refs);
 	else
-		ret = try_to_unmap_file(page);
+		ret = try_to_unmap_file(page, ignore_refs);
 
 	if (!page_mapped(page))
 		ret = SWAP_SUCCESS;
Index: linux-2.6.15/include/linux/rmap.h
===================================================================
--- linux-2.6.15.orig/include/linux/rmap.h	2006-01-11 19:22:19.000000000 -0800
+++ linux-2.6.15/include/linux/rmap.h	2006-01-11 19:22:22.000000000 -0800
@@ -91,7 +91,7 @@ static inline void page_dup_rmap(struct 
  * Called from mm/vmscan.c to handle paging out
  */
 int page_referenced(struct page *, int is_locked);
-int try_to_unmap(struct page *);
+int try_to_unmap(struct page *, int ignore_refs);
 #ifdef CONFIG_MIGRATION
 void remove_from_swap(struct page *page);
 #endif
@@ -114,7 +114,7 @@ unsigned long page_address_in_vma(struct
 #define anon_vma_link(vma)	do {} while (0)
 
 #define page_referenced(page,l) TestClearPageReferenced(page)
-#define try_to_unmap(page)	SWAP_FAIL
+#define try_to_unmap(page, refs) SWAP_FAIL
 
 #endif	/* CONFIG_MMU */
 
