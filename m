Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932549AbVJTXAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932549AbVJTXAV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 19:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932550AbVJTXAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 19:00:20 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:14534 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932549AbVJTXAB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 19:00:01 -0400
Date: Thu, 20 Oct 2005 15:59:45 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Mike Kravetz <kravetz@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Christoph Lameter <clameter@sgi.com>,
       Magnus Damm <magnus.damm@gmail.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20051020225945.19761.15772.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051020225935.19761.57434.sendpatchset@schroedinger.engr.sgi.com>
References: <20051020225935.19761.57434.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 2/4] Swap migration V3: Page Eviction
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Page eviction support in vmscan.c

This patch adds functions that allow the eviction of pages to swap space.
Page eviction may be useful to migrate pages, to suspend programs or for
ummapping single pages (useful for faulty pages or pages with soft ECC
failures)

The process is as follows:

The function wanting to evict pages must first build a list of pages to be evicted
and take them off the lru lists. This is done using the isolate_lru_page function.
isolate_lru_page determines that a page is freeable based on the LRU bit set and
adds the page if it is indeed freeable to the list specified.
isolate_lru_page will return 0 for a page that is not freeable.

Then the actual swapout can happen by calling swapout_pages().

swapout_pages does its best to swapout the pages and does multiple passes over the list.
However, swapout_pages may not be able to evict all pages for a variety of reasons.

The remaining pages may be returned to the LRU lists using putback_lru_pages().

V3:
- Extract common code from shrink_list() and swapout_pages()

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.14-rc4-mm1/include/linux/swap.h
===================================================================
--- linux-2.6.14-rc4-mm1.orig/include/linux/swap.h	2005-10-20 13:13:24.000000000 -0700
+++ linux-2.6.14-rc4-mm1/include/linux/swap.h	2005-10-20 13:20:53.000000000 -0700
@@ -179,6 +179,8 @@ extern int vm_swappiness;
 extern int isolate_lru_page(struct page *p, struct list_head *l);
 extern int putback_lru_pages(struct list_head *l);
 
+extern int swapout_pages(struct list_head *l);
+
 #ifdef CONFIG_MMU
 /* linux/mm/shmem.c */
 extern int shmem_unuse(swp_entry_t entry, struct page *page);
Index: linux-2.6.14-rc4-mm1/mm/vmscan.c
===================================================================
--- linux-2.6.14-rc4-mm1.orig/mm/vmscan.c	2005-10-20 13:18:05.000000000 -0700
+++ linux-2.6.14-rc4-mm1/mm/vmscan.c	2005-10-20 13:22:33.000000000 -0700
@@ -370,6 +370,42 @@ static pageout_t pageout(struct page *pa
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
+	if (page_count(page) != 2 || PageDirty(page)) {
+		write_unlock_irq(&mapping->tree_lock);
+		return 0;
+	}
+
+#ifdef CONFIG_SWAP
+	if (PageSwapCache(page)) {
+		swp_entry_t swap = { .val = page->private };
+		add_to_swapped_list(swap.val);
+		__delete_from_swap_cache(page);
+		write_unlock_irq(&mapping->tree_lock);
+		swap_free(swap);
+		__put_page(page);	/* The pagecache ref */
+		return 1;
+	}
+#endif /* CONFIG_SWAP */
+
+	__remove_from_page_cache(page);
+	write_unlock_irq(&mapping->tree_lock);
+	__put_page(page);
+	return 1;
+}
+
 /*
  * shrink_list adds the number of reclaimed pages to sc->nr_reclaimed
  */
@@ -508,36 +544,8 @@ static int shrink_list(struct list_head 
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
-		if (page_count(page) != 2 || PageDirty(page)) {
-			write_unlock_irq(&mapping->tree_lock);
+		if (!remove_mapping(mapping, page))
 			goto keep_locked;
-		}
-
-#ifdef CONFIG_SWAP
-		if (PageSwapCache(page)) {
-			swp_entry_t swap = { .val = page->private };
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
 
 free_it:
 		unlock_page(page);
@@ -564,6 +572,122 @@ keep:
 }
 
 /*
+ * Swapout evicts the pages on the list to swap space.
+ * This is essentially a dumbed down version of shrink_list
+ *
+ * returns the number of pages that were not evictable
+ *
+ * Multiple passes are performed over the list. The first
+ * pass avoids waiting on locks and triggers writeout
+ * actions. Later passes begin to wait on locks in order
+ * to have a better chance of acquiring the lock.
+ */
+int swapout_pages(struct list_head *l)
+{
+	int retry;
+	int failed;
+	int pass = 0;
+	struct page *page;
+	struct page *page2;
+
+	current->flags |= PF_KSWAPD;
+
+redo:
+	retry = 0;
+	failed = 0;
+
+	list_for_each_entry_safe(page, page2, l, lru) {
+		struct address_space *mapping;
+
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
+			if (PageWriteback(page))
+				goto retry_later_locked;
+
+#ifdef CONFIG_SWAP
+		if (PageAnon(page) && !PageSwapCache(page)) {
+			if (!add_to_swap(page))
+				goto failed;
+		}
+#endif /* CONFIG_SWAP */
+
+		mapping = page_mapping(page);
+		if (page_mapped(page) && mapping)
+			if (try_to_unmap(page) != SWAP_SUCCESS)
+				goto retry_later_locked;
+
+		if (PageDirty(page)) {
+			/* Page is dirty, try to write it out here */
+			switch(pageout(page, mapping)) {
+			case PAGE_KEEP:
+			case PAGE_ACTIVATE:
+				goto retry_later_locked;
+			case PAGE_SUCCESS:
+				goto retry_later;
+			case PAGE_CLEAN:
+				; /* try to free the page below */
+			}
+		}
+
+		if (PagePrivate(page)) {
+			if (!try_to_release_page(page, GFP_KERNEL))
+				goto retry_later_locked;
+			if (!mapping && page_count(page) == 1)
+				goto free_it;
+		}
+
+		if (!remove_mapping(mapping, page))
+			goto retry_later_locked;       /* truncate got there first */
+
+free_it:
+		/*
+		 * We may free pages that were taken off the active list
+		 * by isolate_lru_page. However, free_hot_cold_page will check
+		 * if the active bit is set. So clear it.
+		 */
+		ClearPageActive(page);
+
+		list_del(&page->lru);
+		unlock_page(page);
+		put_page(page);
+		continue;
+
+failed:
+		failed++;
+		unlock_page(page);
+		continue;
+
+retry_later_locked:
+		unlock_page(page);
+retry_later:
+		retry++;
+	}
+	if (retry && pass++ < 10)
+		goto redo;
+
+	current->flags &= ~PF_KSWAPD;
+	return failed + retry;
+}
+
+/*
  * zone->lru_lock is heavily contended.  Some of the functions that
  * shrink the lists perform better by taking out a batch of pages
  * and working on them outside the LRU lock.
