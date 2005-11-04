Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbVKDXhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbVKDXhs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 18:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbVKDXhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 18:37:47 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:29079 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751096AbVKDXhq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 18:37:46 -0500
Date: Fri, 4 Nov 2005 15:37:27 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Hugh Dickins <hugh@veritas.com>, Mike Kravetz <kravetz@us.ibm.com>,
       linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>, linux-mm@kvack.org,
       torvalds@osdl.org, Christoph Lameter <clameter@sgi.com>,
       Hirokazu Takahashi <taka@valinux.co.jp>,
       Magnus Damm <magnus.damm@gmail.com>, Paul Jackson <pj@sgi.com>,
       Dave Hansen <haveblue@us.ibm.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Message-Id: <20051104233727.5459.51093.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051104233712.5459.94627.sendpatchset@schroedinger.engr.sgi.com>
References: <20051104233712.5459.94627.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 3/7] Direct Migration V1: migrate_pages() extension for direct migration
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add direct migration support with fall back to swap.

Direct migration support on top of the swap based page migration facility.

This allows the direct migration of anonymous pages and the migration of
file backed pages by dropping the associated buffers (requires writeout).

Fall back to swap out if necessary.

The patch is based on lots of patches from the hotplug project but the code
was restructured, documented and simplified as much as possible.

Note that an additional patch that defines the migrate_page() method
for filesystems is necessary in order to avoid writeback for anonymous
and file backed pages.

Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>
Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.14-rc5-mm1/mm/vmscan.c
===================================================================
--- linux-2.6.14-rc5-mm1.orig/mm/vmscan.c	2005-11-04 09:53:30.000000000 -0800
+++ linux-2.6.14-rc5-mm1/mm/vmscan.c	2005-11-04 10:23:58.000000000 -0800
@@ -576,10 +576,6 @@ keep:
 /*
  * swapout a single page
  * page is locked upon entry, unlocked on exit
- *
- * return codes:
- *	0 = complete
- *	1 = retry
  */
 static int swap_page(struct page *page)
 {
@@ -595,42 +591,201 @@ static int swap_page(struct page *page)
 		case PAGE_KEEP:
 		case PAGE_ACTIVATE:
 			goto unlock_retry;
+
 		case PAGE_SUCCESS:
-			goto retry;
+			return -EAGAIN;
+
 		case PAGE_CLEAN:
 			; /* try to free the page below */
 		}
 	}
 
 	if (PagePrivate(page)) {
-		if (!try_to_release_page(page, GFP_KERNEL))
+		if (!try_to_release_page(page, GFP_KERNEL) ||
+		    (!mapping && page_count(page) == 1))
 			goto unlock_retry;
-		if (!mapping && page_count(page) == 1)
-			goto free_it;
 	}
 
-	if (!remove_mapping(mapping, page))
-		goto unlock_retry;		/* truncate got there first */
+	if (remove_mapping(mapping, page)) {
+		unlock_page(page);
+		return 0;
+	}
+
+unlock_retry:
+	unlock_page(page);
+
+	return -EAGAIN;
+}
+
+static inline void move_to_lru(struct page *page)
+{
+	list_del(&page->lru);
+	if (PageActive(page)) {
+		/*
+		 * lru_cache_add_active checks that
+		 * the PG_active bit is off.
+		 */
+		ClearPageActive(page);
+		lru_cache_add_active(page);
+	} else
+		lru_cache_add(page);
+	put_page(page);
+}
+
+/*
+ * Page migration was developed in the context of the memory hotplug project.
+ * The main authors of the migration code are:
+ *
+ * IWAMOTO Toshihiro <iwamoto@valinux.co.jp>
+ * Hirokazu Takahashi <taka@valinux.co.jp>
+ * Dave Hansen <haveblue@us.ibm.com>
+ * Christoph Lameter <clameter@sgi.com>
+ */
+
+/*
+ * Remove references for a page and establish the new page with the correct
+ * basic settings to be able to stop accesses to the page.
+ */
+int migrate_page_remove_references(struct page *newpage, struct page *page, int nr_refs)
+{
+	struct address_space *mapping = page_mapping(page);
+	struct page **radix_pointer;
+
+	/* Must have added this page to swap so mapping must exist */
+	BUG_ON(!mapping);
+
+	/* Bail out if there are other users of the page */
+	if (page_mapcount(page) + nr_refs != page_count(page))
+		return 1;
+
+	read_lock_irq(&mapping->tree_lock);
+
+	radix_pointer = (struct page **)radix_tree_lookup_slot(
+						&mapping->page_tree,
+						page_index(page));
+	if (*radix_pointer != page) {
+		/*
+		 * Someone else modified the radix tree
+		 */
+		read_unlock_irq(&mapping->tree_lock);
+		return 1;
+	}
+
+	/*
+	 * Certain minimal information about a page must be available
+	 * in order for other subsystems to properly handle the page if they
+	 * find it through some of the links that we soon may establish.
+	 */
+	get_page(newpage);
+	newpage->index = page_index(page);
+	if (PageSwapCache(page)) {
+		SetPageSwapCache(newpage);
+		set_page_private(newpage, page_private(page));
+	} else
+		newpage->mapping = page->mapping;
+
+	*radix_pointer = newpage;
+	read_unlock_irq(&mapping->tree_lock);
+
+	/*
+	 * We are now in the critical section where there is no easy way
+	 * out since other processes accessing newpage may have followed
+	 * the mapping that we have exstablished above. We need to succeed!
+	 */
+	while (page_mapped(page)) {
+		int rc = try_to_unmap(page);
+
+		if (rc == SWAP_SUCCESS)
+			break;
+		/*
+		 * If there are other runnable processes then running
+		 * them may make it possible to unmap the page
+		 */
+		schedule();
+
+		/*
+		 * A really unswappable page should not occur here
+		 * since we should have checked for the page
+		 * not being in a vma that is unswappable
+		 * before entering this function.
+		 *
+		 * Currently we will simply hang if such a page
+		 * is encountered here.
+		 */
+	}
+
+	__put_page(page);		/* mapping removed from page */
+
+	return 0;
+}
+
+/*
+ * Copy the page to its new location
+ */
+void migrate_page_copy(struct page *newpage, struct page *page)
+{
+
+	copy_highpage(newpage, page);
+
+	if (PageError(page))
+		SetPageError(newpage);
+	if (PageReferenced(page))
+		SetPageReferenced(newpage);
+	if (PageUptodate(page))
+		SetPageUptodate(newpage);
+	if (PageActive(page))
+		SetPageActive(newpage);
+	if (PageChecked(page))
+		SetPageChecked(newpage);
+	if (PageMappedToDisk(page))
+		SetPageMappedToDisk(newpage);
+
+	if (PageDirty(page)) {
+		clear_page_dirty_for_io(page);
+		set_page_dirty(newpage);
+	}
 
-free_it:
 	/*
-	 * We may free pages that were taken off the active list
-	 * by isolate_lru_page. However, free_hot_cold_page will check
-	 * if the active bit is set. So clear it.
+	 * Make the old page a zombie page
 	 */
+	ClearPageSwapCache(page);
 	ClearPageActive(page);
+	ClearPagePrivate(page);
+	set_page_private(page, 0);
+	page->mapping = NULL;
 
-	list_del(&page->lru);
-	unlock_page(page);
-	put_page(page);
- 	return 0;
+	/*
+	 * If any waiters have accumulated on the new page then
+	 * wake them up.
+	 */
+	if (PageWriteback(newpage))
+		end_page_writeback(newpage);
+}
 
-unlock_retry:
-	unlock_page(page);
+/*
+ * Common logic to directly migrate a single page suitable for
+ * pages that do not use PagePrivate.
+ *
+ * Pages are locked upon entry and exit.
+ *
+ * It has been verified that the page is not
+ *  1. Undergoing writeback.
+ *  2. Having any additional references besides the radix tree,
+ *     page tables and the reference from isolate_lru_page().
+ *  3. Part of a vma that is not swappable
+ */
+int migrate_page(struct page *newpage, struct page *page)
+{
+	BUG_ON(PageWriteback(page));	/* Writeback must be complete */
+
+	if (migrate_page_remove_references(newpage, page, 2))
+		return -EAGAIN;
 
-retry:
-       return 1;
+	migrate_page_copy(newpage, page);
+
+	return 0;
 }
+
 /*
  * migrate_pages
  *
@@ -644,10 +799,7 @@ retry:
  * are movable anymore because t has become empty
  * or no retryable pages exist anymore.
  *
- * SIMPLIFIED VERSION: This implementation of migrate_pages
- * is only swapping out pages and never touches the second
- * list. The direct migration patchset
- * extends this function to avoid the use of swap.
+ * Return: Number of pages not migrated when t ran empty.
  */
 int migrate_pages(struct list_head *l, struct list_head *t)
 {
@@ -658,6 +810,7 @@ int migrate_pages(struct list_head *l, s
 	struct page *page;
 	struct page *page2;
 	int swapwrite = current->flags & PF_SWAPWRITE;
+	int rc = 0;
 
 	if (!swapwrite)
 		current->flags |= PF_SWAPWRITE;
@@ -666,32 +819,48 @@ redo:
 	retry = 0;
 
 	list_for_each_entry_safe(page, page2, l, lru) {
+		struct page *newpage = NULL;
+		struct address_space *mapping;
+
 		cond_resched();
 
+		if (t && list_empty(t))
+			break;
+
+		if (page_count(page) == 1) {
+			/* page was freed from under us */
+			move_to_lru(page);
+			continue;
+		}
 		/*
 		 * Skip locked pages during the first two passes to give the
-		 * functions holding the lock time to release the page. Later we use
-		 * lock_page to have a higher chance of acquiring the lock.
+		 * functions holding the lock time to release the page.
+		 * Later we use lock_page() to have a higher chance of
+		 * acquiring the lock.
 		 */
+		rc = -EAGAIN;
 		if (pass > 2)
 			lock_page(page);
 		else
 			if (TestSetPageLocked(page))
-				goto retry_later;
+				goto next;
 
 		/*
-		 * Only wait on writeback if we have already done a pass where
-		 * we we may have triggered writeouts for lots of pages.
+		 * Only wait on writeback if we have already done a pass
+		 * where we we may have triggered writeouts.
 		 */
 		if (pass > 0)
 			wait_on_page_writeback(page);
 		else
-			if (PageWriteback(page)) {
-				unlock_page(page);
-				goto retry_later;
-			}
+			if (PageWriteback(page))
+				goto unlock_page;
 
 #ifdef CONFIG_SWAP
+		/*
+		 * Anonymous pages must have swap cache references otherwise
+		 * the information contained in the page maps cannot be
+		 * preserved.
+		 */
 		if (PageAnon(page) && !PageSwapCache(page)) {
 			if (!add_to_swap(page)) {
 				unlock_page(page);
@@ -702,13 +871,80 @@ redo:
 		}
 #endif /* CONFIG_SWAP */
 
+		if (!t) {
+			rc = swap_page(page);
+			goto next;
+		}
+
+		newpage = lru_to_page(t);
+		lock_page(newpage);
+
 		/*
 		 * Page is properly locked and writeback is complete.
 		 * Try to migrate the page.
 		 */
-		if (swap_page(page)) {
-retry_later:
+		mapping = page_mapping(page);
+
+		/*
+		 * Trigger writeout if page is dirty
+		 */
+		if (PageDirty(page)) {
+			switch (pageout(page, mapping)) {
+			case PAGE_KEEP:
+			case PAGE_ACTIVATE:
+				goto unlock_both;
+
+			case PAGE_SUCCESS:
+				unlock_page(newpage);
+				goto next;
+
+			case PAGE_CLEAN:
+				; /* try to migrate the page below */
+			}
+		}
+
+		/*
+		 * If we have no buffer or can release the buffers
+		 * then do a simple migration.
+		 */
+		if (!page_has_buffers(page) ||
+		    try_to_release_page(page, GFP_KERNEL)) {
+			rc = migrate_page(newpage, page);
+			goto unlock_both;
+		}
+
+		/*
+		 * On early passes with mapped pages simply
+		 * retry. There may be a lock held for some
+		 * buffers that may go away later. Later
+		 * swap them out.
+		 */
+		if (pass > 2) {
+			unlock_page(newpage);
+			newpage = NULL;
+			rc = swap_page(page);
+			goto next;
+		}
+
+unlock_both:
+		unlock_page(newpage);
+
+unlock_page:
+		unlock_page(page);
+
+next:
+		if (rc == -EAGAIN)
+			/* Page should be retried later */
 			retry++;
+
+		else if (rc) {
+			/* Permanent failure to migrate the page */
+			list_move(&page->lru, &failed);
+			nr_failed++;
+		}
+		else if (newpage) {
+			/* Successful migration. Return page to LRU */
+			move_to_lru(newpage);
 		}
 	}
 	if (retry && pass++ < 10)
@@ -869,21 +1105,6 @@ done:
 	pagevec_release(&pvec);
 }
 
-static inline void move_to_lru(struct page *page)
-{
-	list_del(&page->lru);
-	if (PageActive(page)) {
-		/*
-		 * lru_cache_add_active checks that
-		 * the PG_active bit is off.
-		 */
-		ClearPageActive(page);
-		lru_cache_add_active(page);
-	} else 
-		lru_cache_add(page);
-	put_page(page);
-}
-
 /*
  * Add isolated pages on the list back to the LRU
  *
Index: linux-2.6.14-rc5-mm1/include/linux/swap.h
===================================================================
--- linux-2.6.14-rc5-mm1.orig/include/linux/swap.h	2005-11-04 09:53:30.000000000 -0800
+++ linux-2.6.14-rc5-mm1/include/linux/swap.h	2005-11-04 10:04:46.000000000 -0800
@@ -181,6 +181,10 @@ extern int putback_lru_pages(struct list
 
 #ifdef CONFIG_MIGRATION
 extern int migrate_pages(struct list_head *l, struct list_head *t);
+
+extern int migrate_page(struct page *, struct page *);
+extern int migrate_page_remove_references(struct page *, struct page *, int);
+extern void migrate_page_copy(struct page *, struct page *);
 #endif
 
 #ifdef CONFIG_MMU
