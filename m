Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964952AbVKADNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964952AbVKADNt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 22:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964956AbVKADNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 22:13:33 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:38844 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964952AbVKADNY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 22:13:24 -0500
Date: Mon, 31 Oct 2005 19:12:54 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: torvalds@osdl.org
Cc: akpm@osdl.org, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Mike Kravetz <kravetz@us.ibm.com>,
       Ray Bryant <raybry@mpdtxmail.amd.com>,
       Lee Schermerhorn <lee.schermerhorn@hp.com>,
       linux-kernel@vger.kernel.org, Christoph Lameter <clameter@sgi.com>,
       Magnus Damm <magnus.damm@gmail.com>, Paul Jackson <pj@sgi.com>,
       Dave Hansen <haveblue@us.ibm.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Message-Id: <20051101031254.12488.18612.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051101031239.12488.76816.sendpatchset@schroedinger.engr.sgi.com>
References: <20051101031239.12488.76816.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 3/5] Swap Migration V5: migrate_pages() function
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Page migration support in vmscan.c

This patch adds the basic page migration function with a minimal implementation
that only allows the eviction of pages to swap space.

Page eviction and migration may be useful to migrate pages, to suspend programs
or for remapping single pages (useful for faulty pages or pages with soft ECC
failures)

The process is as follows:

The function wanting to migrate pages must first build a list of pages to be
migrated or evicted and take them off the lru lists via isolate_lru_page().
isolate_lru_page determines that a page is freeable based on the LRU bit set.

Then the actual migration or swapout can happen by calling migrate_pages().

migrate_pages does its best to migrate or swapout the pages and does multiple passes
over the list. Some pages may only be swappable if they are not dirty. migrate_pages
may start writing out dirty pages in the initial passes over the pages.
However, migrate_pages may not be able to migrate or evict all pages for a variety
of reasons.

The remaining pages may be returned to the LRU lists using putback_lru_pages().

Changelog V4->V5:
- Use the lru caches to return pages to the LRU

Changelog V3->V4:
- Restructure code so that applying patches to support full migration does
  require minimal changes. Rename swapout_pages() to migrate_pages().

Changelog V2->V3:
- Extract common code from shrink_list() and swapout_pages()

Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>
Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.14-rc5-mm1/include/linux/swap.h
===================================================================
--- linux-2.6.14-rc5-mm1.orig/include/linux/swap.h	2005-10-31 14:11:20.000000000 -0800
+++ linux-2.6.14-rc5-mm1/include/linux/swap.h	2005-10-31 18:38:14.000000000 -0800
@@ -179,6 +179,8 @@ extern int vm_swappiness;
 extern int isolate_lru_page(struct page *p);
 extern int putback_lru_pages(struct list_head *l);
 
+extern int migrate_pages(struct list_head *l, struct list_head *t);
+
 #ifdef CONFIG_MMU
 /* linux/mm/shmem.c */
 extern int shmem_unuse(swp_entry_t entry, struct page *page);
Index: linux-2.6.14-rc5-mm1/mm/vmscan.c
===================================================================
--- linux-2.6.14-rc5-mm1.orig/mm/vmscan.c	2005-10-31 14:11:20.000000000 -0800
+++ linux-2.6.14-rc5-mm1/mm/vmscan.c	2005-10-31 18:41:13.000000000 -0800
@@ -368,6 +368,45 @@ static pageout_t pageout(struct page *pa
 	return PAGE_CLEAN;
 }
 
+static inline int remove_mapping(struct address_space *mapping,
+				struct page *page)
+{
+	if (!mapping)
+		return 0;		/* truncate got there first */
+
+	write_lock_irq(&mapping->tree_lock);
+
+	/*
+	 * The non-racy check for busy page.  It is critical to check
+	 * PageDirty _after_ making sure that the page is freeable and
+	 * not in use by anybody. 	(pagecache + us == 2)
+	 */
+	if (unlikely(page_count(page) != 2))
+		goto cannot_free;
+	smp_rmb();
+	if (unlikely(PageDirty(page)))
+		goto cannot_free;
+
+	if (PageSwapCache(page)) {
+		swp_entry_t swap = { .val = page_private(page) };
+		add_to_swapped_list(swap.val);
+		__delete_from_swap_cache(page);
+		write_unlock_irq(&mapping->tree_lock);
+		swap_free(swap);
+		__put_page(page);	/* The pagecache ref */
+		return 1;
+	}
+
+	__remove_from_page_cache(page);
+	write_unlock_irq(&mapping->tree_lock);
+	__put_page(page);
+	return 1;
+
+cannot_free:
+	write_unlock_irq(&mapping->tree_lock);
+	return 0;
+}
+
 /*
  * shrink_list adds the number of reclaimed pages to sc->nr_reclaimed
  */
@@ -506,37 +545,8 @@ static int shrink_list(struct list_head 
 				goto free_it;
 		}
 
-		if (!mapping)
-			goto keep_locked;	/* truncate got there first */
-
-		write_lock_irq(&mapping->tree_lock);
-
-		/*
-		 * The non-racy check for busy page.  It is critical to check
-		 * PageDirty _after_ making sure that the page is freeable and
-		 * not in use by anybody. 	(pagecache + us == 2)
-		 */
-		if (unlikely(page_count(page) != 2))
-			goto cannot_free;
-		smp_rmb();
-		if (unlikely(PageDirty(page)))
-			goto cannot_free;
-
-#ifdef CONFIG_SWAP
-		if (PageSwapCache(page)) {
-			swp_entry_t swap = { .val = page_private(page) };
-			add_to_swapped_list(swap.val);
-			__delete_from_swap_cache(page);
-			write_unlock_irq(&mapping->tree_lock);
-			swap_free(swap);
-			__put_page(page);	/* The pagecache ref */
-			goto free_it;
-		}
-#endif /* CONFIG_SWAP */
-
-		__remove_from_page_cache(page);
-		write_unlock_irq(&mapping->tree_lock);
-		__put_page(page);
+		if (!remove_mapping(mapping, page))
+			goto keep_locked;
 
 free_it:
 		unlock_page(page);
@@ -545,10 +555,6 @@ free_it:
 			__pagevec_release_nonlru(&freed_pvec);
 		continue;
 
-cannot_free:
-		write_unlock_irq(&mapping->tree_lock);
-		goto keep_locked;
-
 activate_locked:
 		SetPageActive(page);
 		pgactivate++;
@@ -567,6 +573,156 @@ keep:
 }
 
 /*
+ * swapout a single page
+ * page is locked upon entry, unlocked on exit
+ *
+ * return codes:
+ *	0 = complete
+ *	1 = retry
+ */
+static int swap_page(struct page *page)
+{
+	struct address_space *mapping = page_mapping(page);
+
+	if (page_mapped(page) && mapping)
+		if (try_to_unmap(page) != SWAP_SUCCESS)
+			goto unlock_retry;
+
+	if (PageDirty(page)) {
+		/* Page is dirty, try to write it out here */
+		switch(pageout(page, mapping)) {
+		case PAGE_KEEP:
+		case PAGE_ACTIVATE:
+			goto unlock_retry;
+		case PAGE_SUCCESS:
+			goto retry;
+		case PAGE_CLEAN:
+			; /* try to free the page below */
+		}
+	}
+
+	if (PagePrivate(page)) {
+		if (!try_to_release_page(page, GFP_KERNEL))
+			goto unlock_retry;
+		if (!mapping && page_count(page) == 1)
+			goto free_it;
+	}
+
+	if (!remove_mapping(mapping, page))
+		goto unlock_retry;		/* truncate got there first */
+
+free_it:
+	/*
+	 * We may free pages that were taken off the active list
+	 * by isolate_lru_page. However, free_hot_cold_page will check
+	 * if the active bit is set. So clear it.
+	 */
+	ClearPageActive(page);
+
+	list_del(&page->lru);
+	unlock_page(page);
+	put_page(page);
+ 	return 0;
+
+unlock_retry:
+	unlock_page(page);
+
+retry:
+       return 1;
+}
+/*
+ * migrate_pages
+ *
+ * Two lists are passed to this function. The first list
+ * contains the pages isolated from the LRU to be migrated.
+ * The second list contains new pages that the pages isolated
+ * can be moved to. If the second list is NULL then all
+ * pages are swapped out.
+ *
+ * The function returns after 10 attempts or if no pages
+ * are movable anymore because t has become empty
+ * or no retryable pages exist anymore.
+ *
+ * SIMPLIFIED VERSION: This implementation of migrate_pages
+ * is only swapping out pages and never touches the second
+ * list. The direct migration patchset
+ * extends this function to avoid the use of swap.
+ */
+int migrate_pages(struct list_head *l, struct list_head *t)
+{
+	int retry;
+	LIST_HEAD(failed);
+	int nr_failed = 0;
+	int pass = 0;
+	struct page *page;
+	struct page *page2;
+	int swapwrite = current->flags & PF_SWAPWRITE;
+
+	if (!swapwrite)
+		current->flags |= PF_SWAPWRITE;
+
+redo:
+	retry = 0;
+
+	list_for_each_entry_safe(page, page2, l, lru) {
+		cond_resched();
+
+		/*
+		 * Skip locked pages during the first two passes to give the
+		 * functions holding the lock time to release the page. Later we use
+		 * lock_page to have a higher chance of acquiring the lock.
+		 */
+		if (pass > 2)
+			lock_page(page);
+		else
+			if (TestSetPageLocked(page))
+				goto retry_later;
+
+		/*
+		 * Only wait on writeback if we have already done a pass where
+		 * we we may have triggered writeouts for lots of pages.
+		 */
+		if (pass > 0)
+			wait_on_page_writeback(page);
+		else
+			if (PageWriteback(page)) {
+				unlock_page(page);
+				goto retry_later;
+			}
+
+#ifdef CONFIG_SWAP
+		if (PageAnon(page) && !PageSwapCache(page)) {
+			if (!add_to_swap(page)) {
+				unlock_page(page);
+				list_move(&page->lru, &failed);
+				nr_failed++;
+				continue;
+			}
+		}
+#endif /* CONFIG_SWAP */
+
+		/*
+		 * Page is properly locked and writeback is complete.
+		 * Try to migrate the page.
+		 */
+		if (swap_page(page)) {
+retry_later:
+			retry++;
+		}
+	}
+	if (retry && pass++ < 10)
+		goto redo;
+
+	if (!swapwrite)
+		current->flags &= ~PF_SWAPWRITE;
+
+	if (!list_empty(&failed))
+		list_splice(&failed, l);
+
+	return nr_failed + retry;
+}
+
+/*
  * zone->lru_lock is heavily contended.  Some of the functions that
  * shrink the lists perform better by taking out a batch of pages
  * and working on them outside the LRU lock.
@@ -709,7 +865,7 @@ done:
 	pagevec_release(&pvec);
 }
 
-static inline void move_to_lru(struct *page)
+static inline void move_to_lru(struct page *page)
 {
 	list_del(&page->lru);
 	if (PageActive(page)) {
@@ -718,8 +874,8 @@ static inline void move_to_lru(struct *p
 		 * the PG_active bit is off.
 		 */
 		ClearPageActive(page);
-		lru_cache_add_activE(page);
-	} else {
+		lru_cache_add_active(page);
+	} else 
 		lru_cache_add(page);
 	put_page(page);
 }
