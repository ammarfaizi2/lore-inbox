Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129742AbRB0Knz>; Tue, 27 Feb 2001 05:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129749AbRB0Knp>; Tue, 27 Feb 2001 05:43:45 -0500
Received: from www.wen-online.de ([212.223.88.39]:20490 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S129742AbRB0Knj>;
	Tue, 27 Feb 2001 05:43:39 -0500
Date: Tue, 27 Feb 2001 11:43:21 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: Rik van Riel <riel@conectiva.com.br>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [patch][rfc][rft] vm throughput 2.4.2-ac4
Message-ID: <Pine.LNX.4.33.0102271109300.927-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Attempting to avoid doing I/O has been harmful to throughput here
ever since the queueing/elevator woes were fixed. Ever since then,
tossing attempts at avoidance has improved throughput markedly.

IMHO, any patch which claims to improve throughput via code deletion
should be worth a little eyeball time.. and maybe even a test run ;-)

Comments welcome.

	-Mike

--- linux-2.4.2-ac4/mm/page_alloc.c.org	Mon Feb 26 11:19:27 2001
+++ linux-2.4.2-ac4/mm/page_alloc.c	Tue Feb 27 10:31:10 2001
@@ -274,7 +274,7 @@
 struct page * __alloc_pages(zonelist_t *zonelist, unsigned long order)
 {
 	zone_t **zone;
-	int direct_reclaim = 0;
+	int direct_reclaim = 0, loop = 0;
 	unsigned int gfp_mask = zonelist->gfp_mask;
 	struct page * page;

@@ -366,7 +366,7 @@
 	 *   able to free some memory we can't free ourselves
 	 */
 	wakeup_kswapd();
-	if (gfp_mask & __GFP_WAIT) {
+	if (gfp_mask & __GFP_WAIT && loop) {
 		__set_current_state(TASK_RUNNING);
 		current->policy |= SCHED_YIELD;
 		schedule();
@@ -440,7 +440,7 @@
 			memory_pressure++;
 			try_to_free_pages(gfp_mask);
 			wakeup_bdflush(0);
-			if (!order)
+			if (!order || loop++ < (1 << order))
 				goto try_again;
 		}
 	}
--- linux-2.4.2-ac4/mm/vmscan.c.org	Mon Feb 26 09:31:46 2001
+++ linux-2.4.2-ac4/mm/vmscan.c	Tue Feb 27 09:04:50 2001
@@ -278,6 +278,8 @@
 	/* Always start by trying to penalize the process that is allocating memory */
 	if (mm)
 		retval = swap_out_mm(mm, swap_amount(mm));
+	if (retval)
+		return retval;

 	/* Then, look at the other mm's */
 	counter = (mmlist_nr << SWAP_SHIFT) >> priority;
@@ -418,8 +420,8 @@
 #define MAX_LAUNDER 		(1 << page_cluster)
 int page_launder(int gfp_mask, int user)
 {
-	int launder_loop, maxscan, flushed_pages, freed_pages, maxlaunder;
-	int can_get_io_locks, sync, target, shortage;
+	int maxscan, flushed_pages, freed_pages, maxlaunder;
+	int can_get_io_locks;
 	struct list_head * page_lru;
 	struct page * page;
 	struct zone_struct * zone;
@@ -430,15 +432,10 @@
 	 */
 	can_get_io_locks = gfp_mask & __GFP_IO;

-	target = free_shortage();
-
-	sync = 0;
-	launder_loop = 0;
 	maxlaunder = 0;
 	flushed_pages = 0;
 	freed_pages = 0;

-dirty_page_rescan:
 	spin_lock(&pagemap_lru_lock);
 	maxscan = nr_inactive_dirty_pages;
 	while ((page_lru = inactive_dirty_list.prev) != &inactive_dirty_list &&
@@ -446,6 +443,9 @@
 		page = list_entry(page_lru, struct page, lru);
 		zone = page->zone;

+		if ((user && freed_pages + flushed_pages > MAX_LAUNDER)
+				|| !free_shortage())
+			break;
 		/* Wrong page on list?! (list corruption, should not happen) */
 		if (!PageInactiveDirty(page)) {
 			printk("VM: page_launder, wrong page on list.\n");
@@ -464,18 +464,7 @@
 			continue;
 		}

-		/*
-		 * Disk IO is really expensive, so we make sure we
-		 * don't do more work than needed.
-		 * Note that clean pages from zones with enough free
-		 * pages still get recycled and dirty pages from these
-		 * zones can get flushed due to IO clustering.
-		 */
-		if (freed_pages + flushed_pages > target && !free_shortage())
-			break;
-		if (launder_loop && !maxlaunder)
-			break;
-		if (launder_loop && zone->inactive_clean_pages +
+		if (zone->inactive_clean_pages +
 				zone->free_pages > zone->pages_high)
 			goto skip_page;

@@ -500,14 +489,6 @@
 			if (!writepage)
 				goto page_active;

-			/* First time through? Move it to the back of the list */
-			if (!launder_loop) {
-				list_del(page_lru);
-				list_add(page_lru, &inactive_dirty_list);
-				UnlockPage(page);
-				continue;
-			}
-
 			/* OK, do a physical asynchronous write to swap.  */
 			ClearPageDirty(page);
 			page_cache_get(page);
@@ -517,7 +498,6 @@
 			/* XXX: all ->writepage()s should use nr_async_pages */
 			if (!PageSwapCache(page))
 				flushed_pages++;
-			maxlaunder--;
 			page_cache_release(page);

 			/* And re-start the thing.. */
@@ -535,7 +515,7 @@
 		 * buffer pages
 		 */
 		if (page->buffers) {
-			int wait, clearedbuf;
+			int clearedbuf;
 			/*
 			 * Since we might be doing disk IO, we have to
 			 * drop the spinlock and take an extra reference
@@ -545,16 +525,8 @@
 			page_cache_get(page);
 			spin_unlock(&pagemap_lru_lock);

-			/* Will we do (asynchronous) IO? */
-			if (launder_loop && maxlaunder == 0 && sync)
-				wait = 2;	/* Synchrounous IO */
-			else if (launder_loop && maxlaunder-- > 0)
-				wait = 1;	/* Async IO */
-			else
-				wait = 0;	/* No IO */
-
 			/* Try to free the page buffers. */
-			clearedbuf = try_to_free_buffers(page, wait);
+			clearedbuf = try_to_free_buffers(page, can_get_io_locks);

 			/*
 			 * Re-take the spinlock. Note that we cannot
@@ -566,7 +538,7 @@
 			/* The buffers were not freed. */
 			if (!clearedbuf) {
 				add_page_to_inactive_dirty_list(page);
-				if (wait)
+				if (can_get_io_locks)
 					flushed_pages++;

 			/* The page was only in the buffer cache. */
@@ -619,61 +591,8 @@
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
-	 */
-	shortage = free_shortage();
-	if (can_get_io_locks && !launder_loop && shortage) {
-		launder_loop = 1;
-
-		/*
-		 * User programs can run page_launder() in parallel so
-		 * we only flush a few pages at a time to avoid big IO
-		 * storms.   Kswapd, OTOH, is expected usually keep up
-		 * with the paging load in the system and doesn't have
-		 * the IO storm problem, so it just flushes all pages
-		 * needed to fix the free shortage.
-		 */
-		maxlaunder = shortage;
-		maxlaunder -= flushed_pages;
-		maxlaunder -= atomic_read(&nr_async_pages);
-
-		if (maxlaunder <= 0)
-			goto out;
-
-		if (user && maxlaunder > MAX_LAUNDER)
-			maxlaunder = MAX_LAUNDER;
-
-		/*
-		 * If we are called by a user program, we need to free
-		 * some pages. If we couldn't, we'll do the last page IO
-		 * synchronously to be sure
-		 */
-		if (user && !freed_pages)
-			sync = 1;
-
-		goto dirty_page_rescan;
-	}
-
-	/*
-	 * We have to make sure the data is actually written to
-	 * the disk now, otherwise we'll never get enough clean
-	 * pages and the system will keep queueing dirty pages
-	 * for flushing.
-	 */
-	run_task_queue(&tq_disk);
-
-	/*
 	 * Return the amount of pages we freed or made freeable.
 	 */
-out:
 	return freed_pages + flushed_pages;
 }

@@ -846,7 +765,7 @@
  * continue with its real work sooner. It also helps balancing when we
  * have multiple processes in try_to_free_pages simultaneously.
  */
-#define DEF_PRIORITY (6)
+#define DEF_PRIORITY (2)
 static int refill_inactive(unsigned int gfp_mask, int user)
 {
 	int count, start_count, maxtry;
@@ -981,14 +900,6 @@
 		/* If needed, try to free some memory. */
 		if (inactive_shortage() || free_shortage())
 			do_try_to_free_pages(GFP_KSWAPD, 0);
-
-		/*
-		 * Do some (very minimal) background scanning. This
-		 * will scan all pages on the active list once
-		 * every minute. This clears old referenced bits
-		 * and moves unused pages to the inactive list.
-		 */
-		refill_inactive_scan(DEF_PRIORITY, 0);

 		/* Once a second, recalculate some VM stats. */
 		if (time_after(jiffies, recalc + HZ)) {

