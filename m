Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965061AbWDMXy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965061AbWDMXy6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 19:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965054AbWDMXyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 19:54:38 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:33494 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965061AbWDMXye (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 19:54:34 -0400
Date: Thu, 13 Apr 2006 16:54:26 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       Lee Schermerhorn <lee.schermerhorn@hp.com>, linux-mm@kvack.org,
       Christoph Lameter <clameter@sgi.com>,
       Hirokazu Takahashi <taka@valinux.co.jp>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Message-Id: <20060413235426.15398.5327.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060413235406.15398.42233.sendpatchset@schroedinger.engr.sgi.com>
References: <20060413235406.15398.42233.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 4/5] Swapless V2: Rip out swap portion of old migration code
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rip the page migration logic out

Remove all code that has to do with swapping during page migration.

This also guts the ability to migrate pages to swap. No one used that
so lets let it go for good.

Page migration should be a bit broken after this patch.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-rc1-mm2/mm/migrate.c
===================================================================
--- linux-2.6.17-rc1-mm2.orig/mm/migrate.c	2006-04-11 12:14:34.000000000 -0700
+++ linux-2.6.17-rc1-mm2/mm/migrate.c	2006-04-11 22:56:27.000000000 -0700
@@ -70,10 +70,6 @@ int isolate_lru_page(struct page *page, 
  */
 int migrate_prep(void)
 {
-	/* Must have swap device for migration */
-	if (nr_swap_pages <= 0)
-		return -ENODEV;
-
 	/*
 	 * Clear the LRU lists so pages can be isolated.
 	 * Note that pages may be moved off the LRU after we have
@@ -129,52 +125,6 @@ int fail_migrate_page(struct page *newpa
 EXPORT_SYMBOL(fail_migrate_page);
 
 /*
- * swapout a single page
- * page is locked upon entry, unlocked on exit
- */
-static int swap_page(struct page *page)
-{
-	struct address_space *mapping = page_mapping(page);
-
-	if (page_mapped(page) && mapping)
-		if (try_to_unmap(page, 1) != SWAP_SUCCESS)
-			goto unlock_retry;
-
-	if (PageDirty(page)) {
-		/* Page is dirty, try to write it out here */
-		switch(pageout(page, mapping)) {
-		case PAGE_KEEP:
-		case PAGE_ACTIVATE:
-			goto unlock_retry;
-
-		case PAGE_SUCCESS:
-			goto retry;
-
-		case PAGE_CLEAN:
-			; /* try to free the page below */
-		}
-	}
-
-	if (PagePrivate(page)) {
-		if (!try_to_release_page(page, GFP_KERNEL) ||
-		    (!mapping && page_count(page) == 1))
-			goto unlock_retry;
-	}
-
-	if (remove_mapping(mapping, page)) {
-		/* Success */
-		unlock_page(page);
-		return 0;
-	}
-
-unlock_retry:
-	unlock_page(page);
-
-retry:
-	return -EAGAIN;
-}
-
-/*
  * Remove references for a page and establish the new page with the correct
  * basic settings to be able to stop accesses to the page.
  */
@@ -335,8 +285,7 @@ EXPORT_SYMBOL(migrate_page);
  * Two lists are passed to this function. The first list
  * contains the pages isolated from the LRU to be migrated.
  * The second list contains new pages that the pages isolated
- * can be moved to. If the second list is NULL then all
- * pages are swapped out.
+ * can be moved to.
  *
  * The function returns after 10 attempts or if no pages
  * are movable anymore because to has become empty
@@ -392,30 +341,13 @@ redo:
 		 * Only wait on writeback if we have already done a pass where
 		 * we we may have triggered writeouts for lots of pages.
 		 */
-		if (pass > 0) {
+		if (pass > 0)
 			wait_on_page_writeback(page);
-		} else {
+		else {
 			if (PageWriteback(page))
 				goto unlock_page;
 		}
 
-		/*
-		 * Anonymous pages must have swap cache references otherwise
-		 * the information contained in the page maps cannot be
-		 * preserved.
-		 */
-		if (PageAnon(page) && !PageSwapCache(page)) {
-			if (!add_to_swap(page, GFP_KERNEL)) {
-				rc = -ENOMEM;
-				goto unlock_page;
-			}
-		}
-
-		if (!to) {
-			rc = swap_page(page);
-			goto next;
-		}
-
 		newpage = lru_to_page(to);
 		lock_page(newpage);
 
@@ -469,24 +401,6 @@ redo:
 			goto unlock_both;
 		}
 
-		/*
-		 * On early passes with mapped pages simply
-		 * retry. There may be a lock held for some
-		 * buffers that may go away. Later
-		 * swap them out.
-		 */
-		if (pass > 4) {
-			/*
-			 * Persistently unable to drop buffers..... As a
-			 * measure of last resort we fall back to
-			 * swap_page().
-			 */
-			unlock_page(newpage);
-			newpage = NULL;
-			rc = swap_page(page);
-			goto next;
-		}
-
 unlock_both:
 		unlock_page(newpage);
 
Index: linux-2.6.17-rc1-mm2/mm/swapfile.c
===================================================================
--- linux-2.6.17-rc1-mm2.orig/mm/swapfile.c	2006-04-11 22:56:23.000000000 -0700
+++ linux-2.6.17-rc1-mm2/mm/swapfile.c	2006-04-11 22:56:27.000000000 -0700
@@ -618,15 +618,6 @@ static int unuse_mm(struct mm_struct *mm
 	return 0;
 }
 
-#ifdef CONFIG_MIGRATION
-int remove_vma_swap(struct vm_area_struct *vma, struct page *page)
-{
-	swp_entry_t entry = { .val = page_private(page) };
-
-	return unuse_vma(vma, entry, page);
-}
-#endif
-
 /*
  * Scan swap_map from current position to next entry still in use.
  * Recycle to start on reaching the end, returning 0 when empty.
Index: linux-2.6.17-rc1-mm2/mm/rmap.c
===================================================================
--- linux-2.6.17-rc1-mm2.orig/mm/rmap.c	2006-04-11 22:56:24.000000000 -0700
+++ linux-2.6.17-rc1-mm2/mm/rmap.c	2006-04-11 22:56:27.000000000 -0700
@@ -205,44 +205,6 @@ out:
 	return anon_vma;
 }
 
-#ifdef CONFIG_MIGRATION
-/*
- * Remove an anonymous page from swap replacing the swap pte's
- * through real pte's pointing to valid pages and then releasing
- * the page from the swap cache.
- *
- * Must hold page lock on page and mmap_sem of one vma that contains
- * the page.
- */
-void remove_from_swap(struct page *page)
-{
-	struct anon_vma *anon_vma;
-	struct vm_area_struct *vma;
-	unsigned long mapping;
-
-	if (!PageSwapCache(page))
-		return;
-
-	mapping = (unsigned long)page->mapping;
-
-	if (!mapping || (mapping & PAGE_MAPPING_ANON) == 0)
-		return;
-
-	/*
-	 * We hold the mmap_sem lock. So no need to call page_lock_anon_vma.
-	 */
-	anon_vma = (struct anon_vma *) (mapping - PAGE_MAPPING_ANON);
-	spin_lock(&anon_vma->lock);
-
-	list_for_each_entry(vma, &anon_vma->head, anon_vma_node)
-		remove_vma_swap(vma, page);
-
-	spin_unlock(&anon_vma->lock);
-	delete_from_swap_cache(page);
-}
-EXPORT_SYMBOL(remove_from_swap);
-#endif
-
 /*
  * At what user virtual address is page expected in vma?
  */
Index: linux-2.6.17-rc1-mm2/include/linux/rmap.h
===================================================================
--- linux-2.6.17-rc1-mm2.orig/include/linux/rmap.h	2006-04-11 22:56:24.000000000 -0700
+++ linux-2.6.17-rc1-mm2/include/linux/rmap.h	2006-04-11 22:56:27.000000000 -0700
@@ -92,7 +92,6 @@ static inline void page_dup_rmap(struct 
  */
 int page_referenced(struct page *, int is_locked);
 int try_to_unmap(struct page *, int ignore_refs);
-void remove_from_swap(struct page *page);
 
 /*
  * Called from mm/filemap_xip.c to unmap empty zero page
