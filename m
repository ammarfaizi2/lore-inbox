Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318285AbSHKHnD>; Sun, 11 Aug 2002 03:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317911AbSHKH1l>; Sun, 11 Aug 2002 03:27:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32262 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317946AbSHKHZL>;
	Sun, 11 Aug 2002 03:25:11 -0400
Message-ID: <3D561488.1ED33F8B@zip.com.au>
Date: Sun, 11 Aug 2002 00:38:48 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 6/21] multithread and batch page reclaim
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This patch multithreads the main page reclaim function, shrink_cache().

This function used to run under pagemap_lru_lock.  Instead, we grab
that lock, put 32 pages from the LRU into a private list, drop the
pagemap_lru_lock and then proceed to attempt to free those pages.

Any pages which were succesfully reclaimed are batch-freed.  Pages
which were not reclaimed are re-added to the LRU.

This patch reduces pagemap_lru_lock contention on the 4-way by a factor
of thirty.

The shrink_cache() code has been simplified somewhat.

refill_inactive() was being called too often - often just to process
two or three pages.  Fiddled with that so it processes pages at the
same rate, but works on 32 pages at a time.

Added a couple of mark_page_accessed() calls into mm/memory.c from 2.4.
They seem appropriate.

Change the shrink_caches() logic so that it will still trickle through
the active list (via refill_inactive) even if the inactive list is much
larger than the active list.



 include/linux/mm.h         |    1 
 include/linux/page-flags.h |    2 
 include/linux/swap.h       |    9 
 mm/filemap.c               |    3 
 mm/memory.c                |    2 
 mm/swap_state.c            |    1 
 mm/vmscan.c                |  519 ++++++++++++++++++++++++++-------------------
 7 files changed, 322 insertions(+), 215 deletions(-)

--- 2.5.31/mm/vmscan.c~shrink_cache-pagevec	Sun Aug 11 00:20:33 2002
+++ 2.5.31-akpm/mm/vmscan.c	Sun Aug 11 00:21:02 2002
@@ -23,6 +23,7 @@
 #include <linux/writeback.h>
 #include <linux/suspend.h>
 #include <linux/buffer_head.h>		/* for try_to_release_page() */
+#include <linux/pagevec.h>
 
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
@@ -36,10 +37,35 @@
  */
 #define DEF_PRIORITY (6)
 
-static inline int is_page_cache_freeable(struct page * page)
-{
-	return page_count(page) - !!PagePrivate(page) == 1;
-}
+#ifdef ARCH_HAS_PREFETCH
+#define prefetch_prev_lru_page(_page, _base, _field)			\
+	do {								\
+		if ((_page)->lru.prev != _base) {			\
+			struct page *prev;				\
+									\
+			prev = list_entry(_page->lru.prev,		\
+					struct page, lru);		\
+			prefetch(&prev->_field);			\
+		}							\
+	} while (0)
+#else
+#define prefetch_prev_lru_page(_page, _base, _field) do { } while (0)
+#endif
+
+#ifdef ARCH_HAS_PREFETCHW
+#define prefetchw_prev_lru_page(_page, _base, _field)			\
+	do {								\
+		if ((_page)->lru.prev != _base) {			\
+			struct page *prev;				\
+									\
+			prev = list_entry(_page->lru.prev,		\
+					struct page, lru);		\
+			prefetchw(&prev->_field);			\
+		}							\
+	} while (0)
+#else
+#define prefetchw_prev_lru_page(_page, _base, _field) do { } while (0)
+#endif
 
 /* Must be called with page's pte_chain_lock held. */
 static inline int page_mapping_inuse(struct page * page)
@@ -61,89 +87,49 @@ static inline int page_mapping_inuse(str
 	return 0;
 }
 
-static int
-shrink_cache(int nr_pages, zone_t *classzone,
-		unsigned int gfp_mask, int priority, int max_scan)
+static inline int is_page_cache_freeable(struct page *page)
+{
+	return page_count(page) - !!PagePrivate(page) == 2;
+}
+
+static /* inline */ int
+shrink_list(struct list_head *page_list, int nr_pages, zone_t *classzone,
+		unsigned int gfp_mask, int priority, int *max_scan)
 {
-	struct list_head * entry;
 	struct address_space *mapping;
+	LIST_HEAD(ret_pages);
+	struct pagevec freed_pvec;
+	const int nr_pages_in = nr_pages;
+	int pgactivate = 0;
 
-	spin_lock(&pagemap_lru_lock);
-	while (--max_scan >= 0 &&
-			(entry = inactive_list.prev) != &inactive_list) {
+	pagevec_init(&freed_pvec);
+	while (!list_empty(page_list)) {
 		struct page *page;
 		int may_enter_fs;
 
-		if (need_resched()) {
-			spin_unlock(&pagemap_lru_lock);
-			__set_current_state(TASK_RUNNING);
-			schedule();
-			spin_lock(&pagemap_lru_lock);
-			continue;
-		}
-
-		page = list_entry(entry, struct page, lru);
-
-		if (unlikely(!PageLRU(page)))
-			BUG();
-		if (unlikely(PageActive(page)))
-			BUG();
-
-		list_del(entry);
-		list_add(entry, &inactive_list);
-		KERNEL_STAT_INC(pgscan);
-
-		/*
-		 * Zero page counts can happen because we unlink the pages
-		 * _after_ decrementing the usage count..
-		 */
-		if (unlikely(!page_count(page)))
-			continue;
-
+		page = list_entry(page_list->prev, struct page, lru);
+		list_del(&page->lru);
 		if (!memclass(page_zone(page), classzone))
-			continue;
-
-		/*
-		 * swap activity never enters the filesystem and is safe
-		 * for GFP_NOFS allocations.
-		 */
-		may_enter_fs = (gfp_mask & __GFP_FS) ||
-				(PageSwapCache(page) && (gfp_mask & __GFP_IO));
-
-		/*
-		 * IO in progress? Leave it at the back of the list.
-		 */
-		if (unlikely(PageWriteback(page))) {
-			if (may_enter_fs) {
-				page_cache_get(page);
-				spin_unlock(&pagemap_lru_lock);
-				wait_on_page_writeback(page);
-				page_cache_release(page);
-				spin_lock(&pagemap_lru_lock);
-			}
-			continue;
-		}
+			goto keep;
 
 		if (TestSetPageLocked(page))
-			continue;
+			goto keep;
 
-		if (PageWriteback(page)) {	/* The non-racy check */
-			unlock_page(page);
-			continue;
+		BUG_ON(PageActive(page));
+		may_enter_fs = (gfp_mask & __GFP_FS) ||
+				(PageSwapCache(page) && (gfp_mask & __GFP_IO));
+		if (PageWriteback(page)) {
+			if (may_enter_fs)
+				wait_on_page_writeback(page);  /* throttling */
+			else
+				goto keep_locked;
 		}
 
-		/*
-		 * The page is in active use or really unfreeable. Move to
-		 * the active list.
-		 */
 		pte_chain_lock(page);
 		if (page_referenced(page) && page_mapping_inuse(page)) {
-			del_page_from_inactive_list(page);
-			add_page_to_active_list(page);
+			/* In active use or really unfreeable.  Activate it. */
 			pte_chain_unlock(page);
-			unlock_page(page);
-			KERNEL_STAT_INC(pgactivate);
-			continue;
+			goto activate_locked;
 		}
 
 		/*
@@ -153,18 +139,9 @@ shrink_cache(int nr_pages, zone_t *class
 		 * XXX: implement swap clustering ?
 		 */
 		if (page->pte.chain && !page->mapping && !PagePrivate(page)) {
-			page_cache_get(page);
 			pte_chain_unlock(page);
-			spin_unlock(&pagemap_lru_lock);
-			if (!add_to_swap(page)) {
-				activate_page(page);
-				unlock_page(page);
-				page_cache_release(page);
-				spin_lock(&pagemap_lru_lock);
-				continue;
-			}
-			page_cache_release(page);
-			spin_lock(&pagemap_lru_lock);
+			if (!add_to_swap(page))
+				goto activate_locked;
 			pte_chain_lock(page);
 		}
 
@@ -174,30 +151,22 @@ shrink_cache(int nr_pages, zone_t *class
 		 */
 		if (page->pte.chain) {
 			switch (try_to_unmap(page)) {
-				case SWAP_ERROR:
-				case SWAP_FAIL:
-					goto page_active;
-				case SWAP_AGAIN:
-					pte_chain_unlock(page);
-					unlock_page(page);
-					continue;
-				case SWAP_SUCCESS:
-					; /* try to free the page below */
+			case SWAP_ERROR:
+			case SWAP_FAIL:
+				pte_chain_unlock(page);
+				goto activate_locked;
+			case SWAP_AGAIN:
+				pte_chain_unlock(page);
+				goto keep_locked;
+			case SWAP_SUCCESS:
+				; /* try to free the page below */
 			}
 		}
 		pte_chain_unlock(page);
 		mapping = page->mapping;
 
 		if (PageDirty(page) && is_page_cache_freeable(page) &&
-				page->mapping && may_enter_fs) {
-			/*
-			 * It is not critical here to write it only if
-			 * the page is unmapped beause any direct writer
-			 * like O_DIRECT would set the page's dirty bitflag
-			 * on the physical page after having successfully
-			 * pinned it and after the I/O to the page is finished,
-			 * so the direct writes to the page cannot get lost.
-			 */
+					mapping && may_enter_fs) {
 			int (*writeback)(struct page *, int *);
 			const int cluster_size = SWAP_CLUSTER_MAX;
 			int nr_to_write = cluster_size;
@@ -205,13 +174,9 @@ shrink_cache(int nr_pages, zone_t *class
 			writeback = mapping->a_ops->vm_writeback;
 			if (writeback == NULL)
 				writeback = generic_vm_writeback;
-			page_cache_get(page);
-			spin_unlock(&pagemap_lru_lock);
 			(*writeback)(page, &nr_to_write);
-			max_scan -= (cluster_size - nr_to_write);
-			page_cache_release(page);
-			spin_lock(&pagemap_lru_lock);
-			continue;
+			*max_scan -= (cluster_size - nr_to_write);
+			goto keep;
 		}
 
 		/*
@@ -227,162 +192,292 @@ shrink_cache(int nr_pages, zone_t *class
 		 * will do this, as well as the blockdev mapping. 
 		 * try_to_release_page() will discover that cleanness and will
 		 * drop the buffers and mark the page clean - it can be freed.
+		 *
+		 * Rarely, pages can have buffers and no ->mapping.  These are
+		 * the pages which were not successfully invalidated in
+		 * truncate_complete_page().  We try to drop those buffers here
+		 * and if that worked, and the page is no longer mapped into
+		 * process address space (page_count == 0) it can be freed.
+		 * Otherwise, leave the page on the LRU so it is swappable.
 		 */
 		if (PagePrivate(page)) {
-			spin_unlock(&pagemap_lru_lock);
+			if (!try_to_release_page(page, 0))
+				goto keep_locked;
+			if (!mapping && page_count(page) == 1)
+				goto free_it;
+		}
 
-			/* avoid to free a locked page */
-			page_cache_get(page);
+		if (!mapping)
+			goto keep_locked;	/* truncate got there first */
 
-			if (try_to_release_page(page, gfp_mask)) {
-				if (!mapping) {
-					/* effectively free the page here */
-					unlock_page(page);
-					page_cache_release(page);
-
-					spin_lock(&pagemap_lru_lock);
-					if (--nr_pages)
-						continue;
-					break;
-				} else {
-					/*
-					 * The page is still in pagecache so undo the stuff
-					 * before the try_to_release_page since we've not
-					 * finished and we can now try the next step.
-					 */
-					page_cache_release(page);
-
-					spin_lock(&pagemap_lru_lock);
-				}
-			} else {
-				/* failed to drop the buffers so stop here */
-				unlock_page(page);
-				page_cache_release(page);
+		write_lock(&mapping->page_lock);
 
-				spin_lock(&pagemap_lru_lock);
-				continue;
-			}
-		}
-
-		/*
-		 * This is the non-racy check for busy page.
-		 */
-		if (mapping) {
-			write_lock(&mapping->page_lock);
-			if (is_page_cache_freeable(page))
-				goto page_freeable;
-			write_unlock(&mapping->page_lock);
-		}
-		unlock_page(page);
-		continue;
-page_freeable:
 		/*
-		 * It is critical to check PageDirty _after_ we made sure
-		 * the page is freeable* so not in use by anybody.
+		 * The non-racy check for busy page.  It is critical to check
+		 * PageDirty _after_ making sure that the page is freeable and
+		 * not in use by anybody. 	(pagecache + us == 2)
 		 */
-		if (PageDirty(page)) {
+		if (page_count(page) != 2 || PageDirty(page)) {
 			write_unlock(&mapping->page_lock);
-			unlock_page(page);
-			continue;
+			goto keep_locked;
 		}
 
-		/* point of no return */
-		if (likely(!PageSwapCache(page))) {
-			__remove_inode_page(page);
-			write_unlock(&mapping->page_lock);
-		} else {
-			swp_entry_t swap;
-			swap.val = page->index;
+		if (PageSwapCache(page)) {
+			swp_entry_t swap = { .val = page->index };
 			__delete_from_swap_cache(page);
 			write_unlock(&mapping->page_lock);
 			swap_free(swap);
+		} else {
+			__remove_from_page_cache(page);
+			write_unlock(&mapping->page_lock);
 		}
-
-		__lru_cache_del(page);
+		__put_page(page);	/* The pagecache ref */
+free_it:
 		unlock_page(page);
+		nr_pages--;
+		if (!pagevec_add(&freed_pvec, page))
+			__pagevec_release_nonlru(&freed_pvec);
+		continue;
 
-		/* effectively free the page here */
-		page_cache_release(page);
-		KERNEL_STAT_INC(pgsteal);
-		if (--nr_pages)
-			continue;
-		goto out;
-page_active:
-		/*
-		 * OK, we don't know what to do with the page.
-		 * It's no use keeping it here, so we move it to
-		 * the active list.
-		 */
-		del_page_from_inactive_list(page);
-		add_page_to_active_list(page);
-		pte_chain_unlock(page);
+activate_locked:
+		SetPageActive(page);
+		pgactivate++;
+keep_locked:
 		unlock_page(page);
-		KERNEL_STAT_INC(pgactivate);
+keep:
+		list_add(&page->lru, &ret_pages);
+		BUG_ON(PageLRU(page));
 	}
-out:	spin_unlock(&pagemap_lru_lock);
+	list_splice(&ret_pages, page_list);
+	if (pagevec_count(&freed_pvec))
+		__pagevec_release_nonlru(&freed_pvec);
+	KERNEL_STAT_ADD(pgsteal, nr_pages_in - nr_pages);
+	KERNEL_STAT_ADD(pgactivate, pgactivate);
 	return nr_pages;
 }
 
 /*
- * This moves pages from the active list to
- * the inactive list.
+ * pagemap_lru_lock is heavily contented.  We relieve it by quickly privatising
+ * a batch of pages and working on them outside the lock.  Any pages which were
+ * not freed will be added back to the LRU.
+ *
+ * shrink_cache() is passed the number of pages to try to free, and returns
+ * the number which are yet-to-free.
  *
- * We move them the other way if the page is 
- * referenced by one or more processes, from rmap
+ * For pagecache intensive workloads, the first loop here is the hottest spot
+ * in the kernel (apart from the copy_*_user functions).
  */
-static void refill_inactive(int nr_pages)
+static /* inline */ int
+shrink_cache(int nr_pages, zone_t *classzone,
+		unsigned int gfp_mask, int priority, int max_scan)
 {
-	struct list_head * entry;
+	LIST_HEAD(page_list);
+	struct pagevec pvec;
+	int nr_to_process;
+
+	/*
+	 * Try to ensure that we free `nr_pages' pages in one pass of the loop.
+	 */
+	nr_to_process = nr_pages;
+	if (nr_to_process < SWAP_CLUSTER_MAX)
+		nr_to_process = SWAP_CLUSTER_MAX;
+
+	pagevec_init(&pvec);
 
 	spin_lock(&pagemap_lru_lock);
-	entry = active_list.prev;
-	while (nr_pages-- && entry != &active_list) {
-		struct page * page;
+	while (max_scan > 0 && nr_pages > 0) {
+		struct page *page;
+		int n = 0;
 
-		page = list_entry(entry, struct page, lru);
-		entry = entry->prev;
+		while (n < nr_to_process && !list_empty(&inactive_list)) {
+			page = list_entry(inactive_list.prev, struct page, lru);
 
-		KERNEL_STAT_INC(pgscan);
+			prefetchw_prev_lru_page(page, &inactive_list, flags);
 
-		pte_chain_lock(page);
-		if (page->pte.chain && page_referenced(page)) {
+			if (!TestClearPageLRU(page))
+				BUG();
+			list_del(&page->lru);
+			if (page_count(page) == 0) {
+				/* It is currently in pagevec_release() */
+				SetPageLRU(page);
+				list_add(&page->lru, &inactive_list);
+				continue;
+			}
+			list_add(&page->lru, &page_list);
+			page_cache_get(page);
+			n++;
+		}
+		spin_unlock(&pagemap_lru_lock);
+
+		if (list_empty(&page_list))
+			goto done;
+
+		max_scan -= n;
+		mod_page_state(nr_inactive, -n);
+		KERNEL_STAT_ADD(pgscan, n);
+		nr_pages = shrink_list(&page_list, nr_pages, classzone,
+					gfp_mask, priority, &max_scan);
+
+		if (nr_pages <= 0 && list_empty(&page_list))
+			goto done;
+
+		spin_lock(&pagemap_lru_lock);
+		/*
+		 * Put back any unfreeable pages.
+		 */
+		while (!list_empty(&page_list)) {
+			page = list_entry(page_list.prev, struct page, lru);
+			if (TestSetPageLRU(page))
+				BUG();
 			list_del(&page->lru);
-			list_add(&page->lru, &active_list);
+			if (PageActive(page))
+				__add_page_to_active_list(page);
+			else
+				add_page_to_inactive_list(page);
+			if (!pagevec_add(&pvec, page)) {
+				spin_unlock(&pagemap_lru_lock);
+				__pagevec_release(&pvec);
+				spin_lock(&pagemap_lru_lock);
+			}
+		}
+  	}
+	spin_unlock(&pagemap_lru_lock);
+done:
+	pagevec_release(&pvec);
+	return nr_pages;	
+}
+
+/*
+ * This moves pages from the active list to the inactive list.
+ *
+ * We move them the other way if the page is referenced by one or more
+ * processes, from rmap.
+ *
+ * If the pages are mostly unmapped, the processing is fast and it is
+ * appropriate to hold pagemap_lru_lock across the whole operation.  But if
+ * the pages are mapped, the processing is slow (page_referenced()) so we
+ * should drop pagemap_lru_lock around each page.  It's impossible to balance
+ * this, so instead we remove the pages from the LRU while processing them.
+ * It is safe to rely on PG_active against the non-LRU pages in here because
+ * nobody will play with that bit on a non-LRU page.
+ *
+ * The downside is that we have to touch page->count against each page.
+ * But we had to alter page->flags anyway.
+ */
+static /* inline */ void refill_inactive(const int nr_pages_in)
+{
+	int pgdeactivate = 0;
+	int nr_pages = nr_pages_in;
+	LIST_HEAD(l_hold);	/* The pages which were snipped off */
+	LIST_HEAD(l_inactive);	/* Pages to go onto the inactive_list */
+	LIST_HEAD(l_active);	/* Pages to go onto the active_list */
+	struct page *page;
+	struct pagevec pvec;
+
+	spin_lock(&pagemap_lru_lock);
+	while (nr_pages && !list_empty(&active_list)) {
+		page = list_entry(active_list.prev, struct page, lru);
+		prefetchw_prev_lru_page(page, &active_list, flags);
+		if (!TestClearPageLRU(page))
+			BUG();
+		page_cache_get(page);
+		list_move(&page->lru, &l_hold);
+		nr_pages--;
+	}
+	spin_unlock(&pagemap_lru_lock);
+
+	while (!list_empty(&l_hold)) {
+		page = list_entry(l_hold.prev, struct page, lru);
+		list_del(&page->lru);
+		if (page->pte.chain) {
+			if (test_and_set_bit(PG_chainlock, &page->flags)) {
+				list_add(&page->lru, &l_active);
+				continue;
+			}
+			if (page->pte.chain && page_referenced(page)) {
+				pte_chain_unlock(page);
+				list_add(&page->lru, &l_active);
+				continue;
+			}
 			pte_chain_unlock(page);
-			continue;
 		}
-		del_page_from_active_list(page);
-		add_page_to_inactive_list(page);
-		pte_chain_unlock(page);
-		KERNEL_STAT_INC(pgdeactivate);
+		list_add(&page->lru, &l_inactive);
+		pgdeactivate++;
+	}
+
+	pagevec_init(&pvec);
+	spin_lock(&pagemap_lru_lock);
+	while (!list_empty(&l_inactive)) {
+		page = list_entry(l_inactive.prev, struct page, lru);
+		prefetchw_prev_lru_page(page, &l_inactive, flags);
+		if (TestSetPageLRU(page))
+			BUG();
+		if (!TestClearPageActive(page))
+			BUG();
+		list_move(&page->lru, &inactive_list);
+		if (!pagevec_add(&pvec, page)) {
+			spin_unlock(&pagemap_lru_lock);
+			__pagevec_release(&pvec);
+			spin_lock(&pagemap_lru_lock);
+		}
+	}
+	while (!list_empty(&l_active)) {
+		page = list_entry(l_active.prev, struct page, lru);
+		prefetchw_prev_lru_page(page, &l_active, flags);
+		if (TestSetPageLRU(page))
+			BUG();
+		BUG_ON(!PageActive(page));
+		list_move(&page->lru, &active_list);
+		if (!pagevec_add(&pvec, page)) {
+			spin_unlock(&pagemap_lru_lock);
+			__pagevec_release(&pvec);
+			spin_lock(&pagemap_lru_lock);
+		}
 	}
 	spin_unlock(&pagemap_lru_lock);
+	pagevec_release(&pvec);
+
+	mod_page_state(nr_active, -pgdeactivate);
+	mod_page_state(nr_inactive, pgdeactivate);
+	KERNEL_STAT_ADD(pgscan, nr_pages_in - nr_pages);
+	KERNEL_STAT_ADD(pgdeactivate, pgdeactivate);
 }
 
-static int FASTCALL(shrink_caches(zone_t * classzone, int priority, unsigned int gfp_mask, int nr_pages));
-static int shrink_caches(zone_t * classzone, int priority, unsigned int gfp_mask, int nr_pages)
+static /* inline */ int
+shrink_caches(zone_t *classzone, int priority,
+		unsigned int gfp_mask, int nr_pages)
 {
-	int chunk_size = nr_pages;
 	unsigned long ratio;
 	struct page_state ps;
 	int max_scan;
+	static atomic_t nr_to_refill = ATOMIC_INIT(0);
 
-	nr_pages -= kmem_cache_reap(gfp_mask);
-	if (nr_pages <= 0)
-		return 0;
-
-	nr_pages = chunk_size;
+	if (kmem_cache_reap(gfp_mask) >= nr_pages)
+  		return 0;
 
 	/*
-	 * Try to keep the active list 2/3 of the size of the cache
+	 * Try to keep the active list 2/3 of the size of the cache.  And
+	 * make sure that refill_inactive is given a decent number of pages.
+	 *
+	 * The "ratio+1" here is important.  With pagecache-intensive workloads
+	 * the inactive list is huge, and `ratio' evaluates to zero all the
+	 * time.  Which pins the active list memory.  So we add one to `ratio'
+	 * just to make sure that the kernel will slowly sift through the
+	 * active list.
 	 */
 	get_page_state(&ps);
 	ratio = (unsigned long)nr_pages * ps.nr_active /
 				((ps.nr_inactive | 1) * 2);
-	refill_inactive(ratio);
+	atomic_add(ratio+1, &nr_to_refill);
+	if (atomic_read(&nr_to_refill) > SWAP_CLUSTER_MAX) {
+		atomic_sub(SWAP_CLUSTER_MAX, &nr_to_refill);
+		refill_inactive(SWAP_CLUSTER_MAX);
+	}
+
 	max_scan = ps.nr_inactive / priority;
 	nr_pages = shrink_cache(nr_pages, classzone,
 				gfp_mask, priority, max_scan);
+
 	if (nr_pages <= 0)
 		return 0;
 
--- 2.5.31/include/linux/page-flags.h~shrink_cache-pagevec	Sun Aug 11 00:20:33 2002
+++ 2.5.31-akpm/include/linux/page-flags.h	Sun Aug 11 00:21:01 2002
@@ -154,6 +154,7 @@ extern void get_page_state(struct page_s
 		ret;							\
 	})
 
+#define SetPageLRU(page)	set_bit(PG_lru, &(page)->flags)
 #define PageLRU(page)		test_bit(PG_lru, &(page)->flags)
 #define TestSetPageLRU(page)	test_and_set_bit(PG_lru, &(page)->flags)
 #define TestClearPageLRU(page)	test_and_clear_bit(PG_lru, &(page)->flags)
@@ -161,6 +162,7 @@ extern void get_page_state(struct page_s
 #define PageActive(page)	test_bit(PG_active, &(page)->flags)
 #define SetPageActive(page)	set_bit(PG_active, &(page)->flags)
 #define ClearPageActive(page)	clear_bit(PG_active, &(page)->flags)
+#define TestClearPageActive(page) test_and_clear_bit(PG_active, &(page)->flags)
 
 #define PageSlab(page)		test_bit(PG_slab, &(page)->flags)
 #define SetPageSlab(page)	set_bit(PG_slab, &(page)->flags)
--- 2.5.31/mm/filemap.c~shrink_cache-pagevec	Sun Aug 11 00:20:33 2002
+++ 2.5.31-akpm/mm/filemap.c	Sun Aug 11 00:21:02 2002
@@ -545,7 +545,8 @@ int add_to_page_cache(struct page *page,
 		page_cache_get(page);
 	}
 	write_unlock(&mapping->page_lock);
-	if (!error)
+	/* Anon pages are already on the LRU */
+	if (!error && !PageSwapCache(page))
 		lru_cache_add(page);
 	return error;
 }
--- 2.5.31/mm/swap_state.c~shrink_cache-pagevec	Sun Aug 11 00:20:33 2002
+++ 2.5.31-akpm/mm/swap_state.c	Sun Aug 11 00:21:03 2002
@@ -381,6 +381,7 @@ struct page * read_swap_cache_async(swp_
 			/*
 			 * Initiate read into locked page and return.
 			 */
+			lru_cache_add(new_page);
 			swap_readpage(NULL, new_page);
 			return new_page;
 		}
--- 2.5.31/mm/memory.c~shrink_cache-pagevec	Sun Aug 11 00:20:33 2002
+++ 2.5.31-akpm/mm/memory.c	Sun Aug 11 00:21:03 2002
@@ -1180,6 +1180,7 @@ static int do_swap_page(struct mm_struct
 		KERNEL_STAT_INC(pgmajfault);
 	}
 
+	mark_page_accessed(page);
 	lock_page(page);
 
 	/*
@@ -1257,6 +1258,7 @@ static int do_anonymous_page(struct mm_s
 		flush_page_to_ram(page);
 		entry = pte_mkwrite(pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
 		lru_cache_add(page);
+		mark_page_accessed(page);
 	}
 
 	set_pte(page_table, entry);
--- 2.5.31/include/linux/swap.h~shrink_cache-pagevec	Sun Aug 11 00:20:33 2002
+++ 2.5.31-akpm/include/linux/swap.h	Sun Aug 11 00:21:03 2002
@@ -227,12 +227,17 @@ do {						\
 		BUG();				\
 } while (0)
 
+#define __add_page_to_active_list(page)		\
+do {						\
+	list_add(&(page)->lru, &active_list);	\
+	inc_page_state(nr_active);		\
+} while (0)
+
 #define add_page_to_active_list(page)		\
 do {						\
 	DEBUG_LRU_PAGE(page);			\
 	SetPageActive(page);			\
-	list_add(&(page)->lru, &active_list);	\
-	inc_page_state(nr_active);		\
+	__add_page_to_active_list(page);	\
 } while (0)
 
 #define add_page_to_inactive_list(page)		\
--- 2.5.31/include/linux/mm.h~shrink_cache-pagevec	Sun Aug 11 00:20:33 2002
+++ 2.5.31-akpm/include/linux/mm.h	Sun Aug 11 00:21:02 2002
@@ -195,6 +195,7 @@ struct page {
  */
 #define get_page(p)		atomic_inc(&(p)->count)
 #define put_page(p)		__free_page(p)
+#define __put_page(p)		atomic_dec(&(p)->count)
 #define put_page_testzero(p) 	atomic_dec_and_test(&(p)->count)
 #define page_count(p)		atomic_read(&(p)->count)
 #define set_page_count(p,v) 	atomic_set(&(p)->count, v)

.
