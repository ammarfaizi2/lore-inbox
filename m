Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274254AbRIXXyB>; Mon, 24 Sep 2001 19:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274257AbRIXXxn>; Mon, 24 Sep 2001 19:53:43 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:15111 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S274254AbRIXXxd>; Mon, 24 Sep 2001 19:53:33 -0400
Date: Mon, 24 Sep 2001 20:53:09 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: <linux-mm@kvack.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] page aging + launder 2.4.9-ac15
Message-ID: <Pine.LNX.4.33L.0109242044450.1864-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ TESTERS WANTED ]

Hi,

the following patch implements some minor page aging changes
and a rather large page_launder() change for 2.4.9-ac15:

page aging:
 - use min()/max()
 - only enforce inactive target when we have a
   free shortage()
 - set the page age to a minimum of PAGE_AGE_START
   when a page is added back to the active list
 - still age pages even when we don't have an
   inactive shortage in the zone, this way we keep
   the ages up-to-date in workloads where we're
   'grazing' a zone lightly

page launder:
 - stick to the idea of not writing out pages when
   the amount of dirty pages is relatively small ...
 - ... but drop the launder_loop logic, making kswapd
   much more CPU friendly in extreme cases
 - writeout is controlled by a static variable, which
   is set if the percentage of not-freed pages goes above
   a high water mark and is cleared once it goes below
   the low water mark
 - (these watermarks are still untuned ... need to fix that)
 - some other random cruft was removed from page_launder()


Testers for this patch are requested.  Please try this thing
under various workloads, in particular the workload you're
using your computer under most of the time ... ;)

regards,

Rik
--
IA64: a worthy successor to the i860.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/



--- linux-2.4.9-ac15/mm/vmscan.c.orig	Mon Sep 24 17:30:48 2001
+++ linux-2.4.9-ac15/mm/vmscan.c	Mon Sep 24 20:39:41 2001
@@ -28,19 +28,12 @@

 static inline void age_page_up(struct page *page)
 {
-	unsigned long age = page->age;
-	age += PAGE_AGE_ADV;
-	if (age > PAGE_AGE_MAX)
-		age = PAGE_AGE_MAX;
-	page->age = age;
+	page->age = min((int) (page->age + PAGE_AGE_ADV), PAGE_AGE_MAX);
 }

 static inline void age_page_down(struct page *page)
 {
-	unsigned long age = page->age;
-	if (age > 0)
-		age -= PAGE_AGE_DECL;
-	page->age = age;
+	page->age -= min(PAGE_AGE_DECL, (int)page->age);
 }

 /*
@@ -108,6 +101,23 @@
 	pte_t pte;
 	swp_entry_t entry;

+	/* Don't look at this pte if it's been accessed recently. */
+	if (ptep_test_and_clear_young(page_table)) {
+		age_page_up(page);
+		return;
+	}
+
+	/*
+	 * If the page is on the active list, page aging is done in
+	 * refill_inactive_scan(), anonymous pages are aged here.
+	 * This is done so heavily shared pages (think libc.so)
+	 * don't get punished heavily while they are still in use.
+	 * The alternative would be to put anonymous pages on the
+	 * active list too, but that increases complexity (for now).
+	 */
+	if (!PageActive(page))
+		age_page_down(page);
+
 	/*
 	 * If we have plenty inactive pages on this
 	 * zone, skip it.
@@ -133,23 +143,6 @@
 	pte = ptep_get_and_clear(page_table);
 	flush_tlb_page(vma, address);

-	/* Don't look at this pte if it's been accessed recently. */
-	if (ptep_test_and_clear_young(page_table)) {
-		age_page_up(page);
-		return;
-	}
-
-	/*
-	 * If the page is on the active list, page aging is done in
-	 * refill_inactive_scan(), anonymous pages are aged here.
-	 * This is done so heavily shared pages (think libc.so)
-	 * don't get punished heavily while they are still in use.
-	 * The alternative would be to put anonymous pages on the
-	 * active list too, but that increases complexity (for now).
-	 */
-	if (!PageActive(page))
-		age_page_down(page);
-
 	/*
 	 * Is the page already in the swap cache? If so, then
 	 * we can just drop our reference to it without doing
@@ -447,6 +440,7 @@
 				page_count(page) > (1 + !!page->buffers)) {
 			del_page_from_inactive_clean_list(page);
 			add_page_to_active_list(page);
+			page->age = max((int)page->age, PAGE_AGE_START);
 			continue;
 		}

@@ -536,34 +530,56 @@
  * @gfp_mask: what operations we are allowed to do
  * @sync: are we allowed to do synchronous IO in emergencies ?
  *
- * When this function is called, we are most likely low on free +
- * inactive_clean pages. Since we want to refill those pages as
- * soon as possible, we'll make two loops over the inactive list,
- * one to move the already cleaned pages to the inactive_clean lists
- * and one to (often asynchronously) clean the dirty inactive pages.
+ * This function is called when we are low on free / inactive_clean
+ * pages, its purpose is to refill the free/clean list as efficiently
+ * as possible.
  *
- * In situations where kswapd cannot keep up, user processes will
- * end up calling this function. Since the user process needs to
- * have a page before it can continue with its allocation, we'll
- * do synchronous page flushing in that case.
+ * This means we do writes asynchronously as long as possible and will
+ * only sleep on IO when we don't have another option. Since writeouts
+ * cause disk seeks and make read IO slower, we skip writes alltogether
+ * when the amount of dirty pages is small.
  *
  * This code is heavily inspired by the FreeBSD source code. Thanks
  * go out to Matthew Dillon.
  */
-#define MAX_LAUNDER 		(4 * (1 << page_cluster))
-#define CAN_DO_FS		(gfp_mask & __GFP_FS)
-#define CAN_DO_IO		(gfp_mask & __GFP_IO)
+#define	CAN_DO_FS	((gfp_mask & __GFP_FS) && should_write)
+#define	WRITE_LOW_WATER		10
+#define	WRITE_HIGH_WATER	25
 int page_launder(int gfp_mask, int sync)
 {
-	int launder_loop, maxscan, cleaned_pages, maxlaunder;
+	int maxscan, cleaned_pages, failed_pages, total;
 	struct list_head * page_lru;
 	struct page * page;

-	launder_loop = 0;
-	maxlaunder = 0;
+	/*
+	 * This flag determines if we should do writeouts of dirty data
+	 * or not.  When more than WRITE_HIGH_WATER percentage of the
+	 * pages we process would need to be written out we set this flag
+	 * and will do writeout, the flag is cleared once we go below
+	 * WRITE_LOW_WATER.  Note that only pages we actually process
+	 * get counted, ie. pages where we make it beyond the TryLock.
+	 *
+	 * XXX: These flags still need tuning.
+	 */
+	static int should_write = 0;
+
 	cleaned_pages = 0;
+	failed_pages = 0;
+
+	/*
+	 * The gfp_mask tells try_to_free_buffers() below if it should
+	 * wait do IO or may be allowed to wait on IO synchronously.
+	 *
+	 * Note that syncronous IO only happens when a page has not been
+	 * written out yet when we see it for a second time, this is done
+	 * through magic in try_to_free_buffers().
+	 */
+	if (!should_write)
+		gfp_mask &= ~(__GFP_WAIT | __GFP_IO);
+	else if (!sync)
+		gfp_mask &= ~__GFP_WAIT;

-dirty_page_rescan:
+	/* The main launder loop. */
 	spin_lock(&pagemap_lru_lock);
 	maxscan = nr_inactive_dirty_pages;
 	while ((page_lru = inactive_dirty_list.prev) != &inactive_dirty_list &&
@@ -579,34 +595,24 @@
 			continue;
 		}

-		/*
-		 * If the page is or was in use, we move it to the active
-		 * list. Note that pages in use by processes can easily
-		 * end up here to be unmapped later, but we just don't
-		 * want them clogging up the inactive list.
-		 */
+		/* Page is or was in use?  Move it to the active list. */
 		if ((PageReferenced(page) || page->age > 0 ||
 				page_count(page) > (1 + !!page->buffers) ||
 				page_ramdisk(page)) && !PageLocked(page)) {
 			del_page_from_inactive_dirty_list(page);
 			add_page_to_active_list(page);
+			page->age = max((int)page->age, PAGE_AGE_START);
 			continue;
 		}

 		/*
-		 * If we have plenty free pages on a zone:
-		 *
-		 * 1) we avoid a writeout for that page if its dirty.
-		 * 2) if its a buffercache page, and not a pagecache
-		 * one, we skip it since we cannot move it to the
-		 * inactive clean list --- we have to free it.
+		 * If this zone has plenty of pages free,
+		 * don't spend time on cleaning it.
 		 */
 		if (zone_free_plenty(page->zone)) {
-			if (!page->mapping || page_dirty(page)) {
-				list_del(page_lru);
-				list_add(page_lru, &inactive_dirty_list);
-				continue;
-			}
+			list_del(page_lru);
+			list_add(page_lru, &inactive_dirty_list);
+			continue;
 		}

 		/*
@@ -633,11 +639,12 @@
 			if (!writepage)
 				goto page_active;

-			/* First time through? Move it to the back of the list */
-			if (!launder_loop || !CAN_DO_FS) {
+			/* Can't do it? Move it to the back of the list. */
+			if (!CAN_DO_FS) {
 				list_del(page_lru);
 				list_add(page_lru, &inactive_dirty_list);
 				UnlockPage(page);
+				failed_pages++;
 				continue;
 			}

@@ -664,9 +671,7 @@
 		 * buffer pages
 		 */
 		if (page->buffers) {
-			unsigned int buffer_mask;
 			int clearedbuf;
-			int freed_page = 0;
 			/*
 			 * Since we might be doing disk IO, we have to
 			 * drop the spinlock and take an extra reference
@@ -676,16 +681,8 @@
 			page_cache_get(page);
 			spin_unlock(&pagemap_lru_lock);

-			/* Will we do (asynchronous) IO? */
-			if (launder_loop && maxlaunder == 0 && sync)
-				buffer_mask = gfp_mask;				/* Do as much as we can */
-			else if (launder_loop && maxlaunder-- > 0)
-				buffer_mask = gfp_mask & ~__GFP_WAIT;			/* Don't wait, async write-out */
-			else
-				buffer_mask = gfp_mask & ~(__GFP_WAIT | __GFP_IO);	/* Don't even start IO */
-
-			/* Try to free metadata underlying the page. */
-			clearedbuf = try_to_release_page(page, buffer_mask);
+			/* Try to free the page buffers. */
+			clearedbuf = try_to_release_page(page, gfp_mask);

 			/*
 			 * Re-take the spinlock. Note that we cannot
@@ -697,11 +694,11 @@
 			/* The buffers were not freed. */
 			if (!clearedbuf) {
 				add_page_to_inactive_dirty_list(page);
+				failed_pages++;

 			/* The page was only in the buffer cache. */
 			} else if (!page->mapping) {
 				atomic_dec(&buffermem_pages);
-				freed_page = 1;
 				cleaned_pages++;

 			/* The page has more users besides the cache and us. */
@@ -722,13 +719,6 @@
 			UnlockPage(page);
 			page_cache_release(page);

-			/*
-			 * If we're freeing buffer cache pages, stop when
-			 * we've got enough free memory.
-			 */
-			if (freed_page && !free_shortage())
-				break;
-
 			continue;
 		} else if (page->mapping && !PageDirty(page)) {
 			/*
@@ -750,33 +740,22 @@
 			 */
 			del_page_from_inactive_dirty_list(page);
 			add_page_to_active_list(page);
+			page->age = max((int)page->age, PAGE_AGE_START);
 			UnlockPage(page);
 		}
 	}
 	spin_unlock(&pagemap_lru_lock);

 	/*
-	 * If we don't have enough free pages, we loop back once
-	 * to queue the dirty pages for writeout. When we were called
-	 * by a user process (that /needs/ a free page) and we didn't
-	 * free anything yet, we wait synchronously on the writeout of
-	 * MAX_SYNC_LAUNDER pages.
-	 *
-	 * We also wake up bdflush, since bdflush should, under most
-	 * loads, flush out the dirty pages before we have to wait on
-	 * IO.
+	 * Set the should_write flag, for the next callers of page_launder.
+	 * If we go below the low watermark we stop the writeout of dirty
+	 * pages, writeout is started when we get above the high watermark.
 	 */
-	if (CAN_DO_IO && !launder_loop && free_shortage()) {
-		launder_loop = 1;
-		/* If we cleaned pages, never do synchronous IO. */
-		if (cleaned_pages)
-			sync = 0;
-		/* We only do a few "out of order" flushes. */
-		maxlaunder = MAX_LAUNDER;
-		/* Kflushd takes care of the rest. */
-		wakeup_bdflush(0);
-		goto dirty_page_rescan;
-	}
+	total = failed_pages + cleaned_pages;
+	if (should_write && failed_pages * 100 < WRITE_LOW_WATER * total)
+		should_write = 0;
+	else if (!should_write && failed_pages * 100 > WRITE_HIGH_WATER * total)
+		should_write = 1;

 	/* Return the number of pages moved to the inactive_clean list. */
 	return cleaned_pages;
@@ -998,27 +977,26 @@
 	return progress;
 }

-
-
+/*
+ * Worker function for kswapd and try_to_free_pages, we get
+ * called whenever there is a shortage of free/inactive_clean
+ * pages.
+ *
+ * This function will also move pages to the inactive list,
+ * if needed.
+ */
 static int do_try_to_free_pages(unsigned int gfp_mask, int user)
 {
 	int ret = 0;

 	/*
-	 * If we're low on free pages, move pages from the
-	 * inactive_dirty list to the inactive_clean list.
-	 *
-	 * Usually bdflush will have pre-cleaned the pages
-	 * before we get around to moving them to the other
-	 * list, so this is a relatively cheap operation.
+	 * Eat memory from filesystem page cache, buffer cache,
+	 * dentry, inode and filesystem quota caches.
 	 */
-
-	if (free_shortage()) {
-		ret += page_launder(gfp_mask, user);
-		shrink_dcache_memory(0, gfp_mask);
-		shrink_icache_memory(0, gfp_mask);
-		shrink_dqcache_memory(DEF_PRIORITY, gfp_mask);
-	}
+	ret += page_launder(gfp_mask, user);
+	shrink_dcache_memory(0, gfp_mask);
+	shrink_icache_memory(0, gfp_mask);
+	shrink_dqcache_memory(DEF_PRIORITY, gfp_mask);

 	/*
 	 * If needed, we move pages from the active list
@@ -1028,7 +1006,7 @@
 		ret += refill_inactive(gfp_mask);

 	/*
-	 * Reclaim unused slab cache if memory is low.
+	 * Reclaim unused slab cache memory.
 	 */
 	kmem_cache_reap(gfp_mask);

@@ -1080,7 +1058,7 @@
 		static long recalc = 0;

 		/* If needed, try to free some memory. */
-		if (inactive_shortage() || free_shortage())
+		if (free_shortage())
 			do_try_to_free_pages(GFP_KSWAPD, 0);

 		/* Once a second ... */
@@ -1090,8 +1068,6 @@
 			/* Do background page aging. */
 			refill_inactive_scan(DEF_PRIORITY);
 		}
-
-		run_task_queue(&tq_disk);

 		/*
 		 * We go to sleep if either the free page shortage

