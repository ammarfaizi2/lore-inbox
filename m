Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030348AbVKHVEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030348AbVKHVEV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 16:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030355AbVKHVES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 16:04:18 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:37856 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030350AbVKHVEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 16:04:08 -0500
Date: Tue, 8 Nov 2005 13:03:41 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Mike Kravetz <kravetz@us.ibm.com>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       torvalds@osdl.org, Christoph Lameter <clameter@sgi.com>,
       Hirokazu Takahashi <taka@valinux.co.jp>, Andi Kleen <ak@suse.de>,
       Magnus Damm <magnus.damm@gmail.com>, Paul Jackson <pj@sgi.com>,
       Dave Hansen <haveblue@us.ibm.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Message-Id: <20051108210331.31330.62370.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051108210246.31330.61756.sendpatchset@schroedinger.engr.sgi.com>
References: <20051108210246.31330.61756.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 3/8] Direct Migration V2: migrate_pages() extension
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

V1->V2:
- Change migrate_pages() so that it can return pagelist for failed and
  moved pages. No longer free the old pages but allow caller to dispose
  of them.
- Unmap pages before changing reverse map under tree lock. Take
  a write_lock instead of a read_lock.
- Add documentation

Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>
Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.14-mm1/mm/vmscan.c
===================================================================
--- linux-2.6.14-mm1.orig/mm/vmscan.c	2005-11-08 11:17:13.000000000 -0800
+++ linux-2.6.14-mm1/mm/vmscan.c	2005-11-08 11:44:13.000000000 -0800
@@ -575,10 +575,6 @@ keep:
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
@@ -594,69 +590,244 @@ static int swap_page(struct page *page)
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
+	int i;
+
+	/*
+	 * Avoid doing any of the following work if the page count
+	 * indicates that the page is in use or truncate has removed
+	 * the page.
+	 */
+	if (!mapping || page_mapcount(page) + nr_refs != page_count(page))
+		return 1;
+
+	/*
+	 * Establish swap ptes for anonymous pages or destroy pte
+	 * maps for files.
+	 *
+	 * In order to reestablish file backed mappings the fault handlers
+	 * will take the radix tree_lock which is then used to synchronize.
+	 *
+	 * A process accessing via a swap pte (an anonymous page) will take a
+	 * page_lock on the old page which will block the process until the
+	 * migration attempt is complete. At that time the PageSwapCache bit
+	 * will be examined. If the page was migrated then the PageSwapCache
+	 * bit will be clear and the operation to retrieve the page will be
+	 * retried which will find the new page in the radix tree. Then a new
+	 * direct mapping may be generated.
+	 *
+	 * If the page was not migrated then the PageSwapCache bit
+	 * is still set and the operation may continue.
+	 */
+	for(i = 0; i < 10 && page_mapped(page); i++) {
+		int rc = try_to_unmap(page);
+
+		if (rc == SWAP_SUCCESS)
+			break;
+		/*
+		 * If there are other runnable processes then running
+		 * them may make it possible to unmap the page
+		 */
+		schedule();
+	}
+
+	/*
+	 * Avoid taking the tree lock if there is no hope of success.
+	 */
+	if (page_mapcount(page))
+		return 1;
+
+	write_lock_irq(&mapping->tree_lock);
+
+	radix_pointer = (struct page **)radix_tree_lookup_slot(
+						&mapping->page_tree,
+						page_index(page));
+
+	if (!page->mapping ||
+	    page_count(page) != nr_refs ||
+	    *radix_pointer != page) {
+		write_unlock_irq(&mapping->tree_lock);
+		return 1;
+	}
 
-free_it:
 	/*
-	 * We may free pages that were taken off the active list
-	 * by isolate_lru_page. However, free_hot_cold_page will check
-	 * if the active bit is set. So clear it.
+	 * The page count for the old page may be raised by other kernel
+	 * components at this point since there no lock exists to prevent
+	 * increasing the page_count. If that happens then the page will
+	 * continue to exist as long as the kernel component keeps the
+	 * page count high. The page has no other references left and it
+	 * is not being written to, otherwise the page lock would have been
+	 * taken.
+	 *
+	 * Filesystems increase the page count while holding the tree_lock
+	 * which provides synchronization with this code.
 	 */
+
+	/*
+	 * Certain minimal information about a page must be available
+	 * in order for other subsystems to properly handle the page if they
+	 * find it through the radix tree update before we are finished
+	 * copying the page.
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
+	__put_page(page);
+	write_unlock_irq(&mapping->tree_lock);
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
+	/* Debug potential trouble with concurrent increases of page_count */
+	if (page_count(page) != 1)
+		printk(KERN_ERR "precheck: copying %p->%p page count=%d\n",
+				page, newpage, page_count(page));
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
+
+	ClearPageSwapCache(page);
 	ClearPageActive(page);
+	ClearPagePrivate(page);
+	set_page_private(page, 0);
+	page->mapping = NULL;
+
+	if (page_count(page) != 1)
+		printk(KERN_ERR "postcheck: copying %p->%p page count=%d\n",
+				page, newpage, page_count(page));
 
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
- * Two lists are passed to this function. The first list
- * contains the pages isolated from the LRU to be migrated.
- * The second list contains new pages that the pages isolated
- * can be moved to. If the second list is NULL then all
- * pages are swapped out.
- *
  * The function returns after 10 attempts or if no pages
- * are movable anymore because t has become empty
+ * are movable anymore because to has become empty
  * or no retryable pages exist anymore.
  *
- * SIMPLIFIED VERSION: This implementation of migrate_pages
- * is only swapping out pages and never touches the second
- * list. The direct migration patchset
- * extends this function to avoid the use of swap.
+ * Return: Number of pages not migrated when to ran empty.
  */
-int migrate_pages(struct list_head *l, struct list_head *t)
+int migrate_pages(struct list_head *from, struct list_head *to,
+		  struct list_head *moved, struct list_head *failed)
 {
 	int retry;
-	LIST_HEAD(failed);
 	int nr_failed = 0;
 	int pass = 0;
 	struct page *page;
 	struct page *page2;
 	int swapwrite = current->flags & PF_SWAPWRITE;
+	int rc = 0;
 
 	if (!swapwrite)
 		current->flags |= PF_SWAPWRITE;
@@ -664,50 +835,137 @@ int migrate_pages(struct list_head *l, s
 redo:
 	retry = 0;
 
-	list_for_each_entry_safe(page, page2, l, lru) {
+	list_for_each_entry_safe(page, page2, from, lru) {
+		struct page *newpage = NULL;
+		struct address_space *mapping;
+
 		cond_resched();
 
+		if (to && list_empty(to))
+			break;
+
+		if (page_count(page) == 1) {
+			/* page was freed from under us. So we are done. */
+			list_move(&page->lru, moved);
+			continue;
+		}
+
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
-				list_move(&page->lru, &failed);
+				list_move(&page->lru, failed);
 				nr_failed++;
 				continue;
 			}
 		}
 #endif /* CONFIG_SWAP */
 
+		if (!to) {
+			rc = swap_page(page);
+			goto next;
+		}
+
+		newpage = lru_to_page(to);
+		lock_page(newpage);
+
 		/*
 		 * Page is properly locked and writeback is complete.
 		 * Try to migrate the page.
 		 */
-		if (swap_page(page)) {
-retry_later:
+		mapping = page_mapping(page);
+		if (!mapping)
+			goto unlock_both;
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
+		if (pass > 4) {
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
+			list_move(&page->lru, failed);
+			nr_failed++;
+		}
+		else if (newpage) {
+			/* Successful migration. Return new page to LRU */
+			move_to_lru(newpage);
+			list_move(&page->lru, moved);
 		}
 	}
 	if (retry && pass++ < 10)
@@ -716,9 +974,6 @@ retry_later:
 	if (!swapwrite)
 		current->flags &= ~PF_SWAPWRITE;
 
-	if (!list_empty(&failed))
-		list_splice(&failed, l);
-
 	return nr_failed + retry;
 }
 #endif
@@ -868,21 +1123,6 @@ done:
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
Index: linux-2.6.14-mm1/include/linux/swap.h
===================================================================
--- linux-2.6.14-mm1.orig/include/linux/swap.h	2005-11-07 11:48:20.000000000 -0800
+++ linux-2.6.14-mm1/include/linux/swap.h	2005-11-08 11:18:34.000000000 -0800
@@ -180,7 +180,12 @@ extern int isolate_lru_page(struct page 
 extern int putback_lru_pages(struct list_head *l);
 
 #ifdef CONFIG_MIGRATION
-extern int migrate_pages(struct list_head *l, struct list_head *t);
+extern int migrate_pages(struct list_head *l, struct list_head *t,
+			 struct list_head *moved, struct list_head *failed);
+
+extern int migrate_page(struct page *, struct page *);
+extern int migrate_page_remove_references(struct page *, struct page *, int);
+extern void migrate_page_copy(struct page *, struct page *);
 #endif
 
 #ifdef CONFIG_MMU
Index: linux-2.6.14-mm1/Documentation/vm/page_migration
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.14-mm1/Documentation/vm/page_migration	2005-11-08 11:18:34.000000000 -0800
@@ -0,0 +1,106 @@
+Page migration
+--------------
+
+Page migration occurs in several steps. First a high level
+description for those trying to use migrate_pages() and then
+a low level description of how the low level details work.
+
+
+A. Use of migrate_pages()
+-------------------------
+
+1. Remove pages from the LRU.
+
+   Lists of pages to be migrated are generated by scanning over
+   pages and moving them into lists. This is done by
+   calling isolate_lru_page() or __isolate_lru_page().
+   Calling isolate_lru_page increases the references to the page
+   so that it cannot vanish under us.
+
+2. Generate a list of newly allocates page to move the contents
+   of the first list to.
+
+3. The migrate_pages() function is called which attempts
+   to do the migration. It returns the moved pages in the
+   list specified as the third parameter and the failed
+   migrations in the fourth parameter. The first parameter
+   will contain the pages that could still be retried.
+
+4. The leftover pages of various types are returned
+   to the LRU using putback_to_lru_pages() or otherwise
+   disposed of. The pages will still have the refcount as
+   increased by isolate_lru_pages()!
+
+B. Operation of migrate_pages()
+--------------------------------
+
+migrate_pages does several passes over its list of pages. A page is moved
+if all references to a page are removable at the time.
+
+Steps:
+
+1. Lock the page to be migrated
+
+2. Insure that writeback is complete.
+
+3. Make sure that the page has assigned swap cache entry if
+   it is an anonyous page. The swap cache reference is necessary
+   to preserve the information contain in the page table maps.
+
+4. Prep the new page that we want to move to. It is locked
+   and set to not being uptodate so that all accesses to the new
+   page immediately lock while we are moving references.
+
+5. All the page table references to the page are either dropped (file backed)
+   or converted to swap references (anonymous pages). This should decrease the
+   reference count.
+
+6. The radix tree lock is taken
+
+7. The refcount of the page is examined and we back out if references remain
+
+8. The radix tree is checked and if it does not contain the pointer to this
+   page then we back out.
+
+9. The mapping is checked. If the mapping is gone then a truncate action may
+   be in progress and we back out.
+
+10. The new page is prepped with some settings from the old page so that accesses
+   to the new page will be discovererd to have the correct settings.
+
+11. The radix tree is changed to point to the new page.
+
+12. The reference count of the old page is dropped because the reference has now
+    been removed.
+
+13. The radix tree lock is dropped.
+
+14. The page contents are copied to the new page.
+
+15. The remaining page flags are copied to the new page.
+
+16. The old page flags are cleared to indicate that the page does
+    not use any information anymore.
+
+17. Queued up writeback on the new page is triggered.
+
+18. The locks are dropped from the old and new page.
+
+19. The swapcache reference is removed from the new page.
+
+20. The new page is moved to the LRU.
+
+This system is not without its problems. The check for the number of
+references while holding the radix tree lock may race with another function
+on another processor incrementing the reference counter for a page. In that
+case we will be in a situation where the page will linger until the reference
+count is dropped by that processor. There are no other references to the page
+though. The kernel functions would have taken a lock on the page if the page
+would have to be written to.
+
+The page is therefore likely just lingering for read purposes for a short while.
+The copy page code contains a couple of printks to detect the situation and help
+if there are any issues with the lingering pages.
+
+Christoph Lameter, November 7, 2005.
+
