Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264936AbRFZM4Q>; Tue, 26 Jun 2001 08:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264934AbRFZMz6>; Tue, 26 Jun 2001 08:55:58 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:31764 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S264933AbRFZMzq>; Tue, 26 Jun 2001 08:55:46 -0400
Date: Tue, 26 Jun 2001 14:55:18 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Bulent Abali <abali@us.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Justin T. Gibbs" <gibbs@scsiguy.com>, mingo@elte.hu
Subject: Re: all processes waiting in TASK_UNINTERRUPTIBLE state
Message-ID: <20010626145518.A2195@athlon.random>
In-Reply-To: <OF7B251945.42FE908D-ON85256A76.004C34E9@pok.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF7B251945.42FE908D-ON85256A76.004C34E9@pok.ibm.com>; from abali@us.ibm.com on Mon, Jun 25, 2001 at 10:10:38AM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2001 at 10:10:38AM -0400, Bulent Abali wrote:
> 
> keywords:  tux, aic7xxx, 2.4.5-ac4, specweb99, __wait_on_page, __lock_page
> 
> Greetings,
> 
> I am running in to a problem, seemingly a deadlock situation, where almost
> all the processes end up in the TASK_UNINTERRUPTIBLE state.   All the

could you try to reproduce with this patch applied on top of
2.4.6pre5aa1 or 2.4.6pre5 vanilla?

diff -urN 2.4.6pre5aa1/include/linux/swap.h 2.4.6pre5aa1-backout-page_launder/include/linux/swap.h
--- 2.4.6pre5aa1/include/linux/swap.h	Sun Jun 24 02:06:13 2001
+++ 2.4.6pre5aa1-backout-page_launder/include/linux/swap.h	Sun Jun 24 21:37:12 2001
@@ -205,16 +205,6 @@
 	page->zone->inactive_dirty_pages++; \
 }
 
-/* Like the above, but add us after the bookmark. */
-#define add_page_to_inactive_dirty_list_marker(page) { \
-	DEBUG_ADD_PAGE \
-	ZERO_PAGE_BUG \
-	SetPageInactiveDirty(page); \
-	list_add(&(page)->lru, marker_lru); \
-	nr_inactive_dirty_pages++; \
-	page->zone->inactive_dirty_pages++; \
-}
-
 #define add_page_to_inactive_clean_list(page) { \
 	DEBUG_ADD_PAGE \
 	ZERO_PAGE_BUG \
diff -urN 2.4.6pre5aa1/mm/vmscan.c 2.4.6pre5aa1-backout-page_launder/mm/vmscan.c
--- 2.4.6pre5aa1/mm/vmscan.c	Sun Jun 24 01:41:09 2001
+++ 2.4.6pre5aa1-backout-page_launder/mm/vmscan.c	Sun Jun 24 21:37:11 2001
@@ -407,7 +407,7 @@
 /**
  * page_launder - clean dirty inactive pages, move to inactive_clean list
  * @gfp_mask: what operations we are allowed to do
- * @sync: are we allowed to do synchronous IO in emergencies ?
+ * @sync: should we wait synchronously for the cleaning of pages
  *
  * When this function is called, we are most likely low on free +
  * inactive_clean pages. Since we want to refill those pages as
@@ -426,61 +426,23 @@
 #define MAX_LAUNDER 		(4 * (1 << page_cluster))
 #define CAN_DO_IO		(gfp_mask & __GFP_IO)
 #define CAN_DO_BUFFERS		(gfp_mask & __GFP_BUFFER)
-#define marker_lru		(&marker_page_struct.lru)
 int page_launder(int gfp_mask, int sync)
 {
-	static int cannot_free_pages;
 	int launder_loop, maxscan, cleaned_pages, maxlaunder;
 	struct list_head * page_lru;
 	struct page * page;
 
-	/* Our bookmark of where we are in the inactive_dirty list. */
-	struct page marker_page_struct = { zone: NULL };
-
 	launder_loop = 0;
 	maxlaunder = 0;
 	cleaned_pages = 0;
 
 dirty_page_rescan:
 	spin_lock(&pagemap_lru_lock);
-	/*
-	 * By not scanning all inactive dirty pages we'll write out
-	 * really old dirty pages before evicting newer clean pages.
-	 * This should cause some LRU behaviour if we have a large
-	 * amount of inactive pages (due to eg. drop behind).
-	 *
-	 * It also makes us accumulate dirty pages until we have enough
-	 * to be worth writing to disk without causing excessive disk
-	 * seeks and eliminates the infinite penalty clean pages incurred
-	 * vs. dirty pages.
-	 */
-	maxscan = nr_inactive_dirty_pages / 4;
-	if (launder_loop)
-		maxscan *= 2;
-	list_add_tail(marker_lru, &inactive_dirty_list);
-	for (;;) {
-		page_lru = marker_lru->prev;
-		if (page_lru == &inactive_dirty_list)
-			break;
-		if (--maxscan < 0)
-			break;
-		if (!free_shortage())
-			break;
-
+	maxscan = nr_inactive_dirty_pages;
+	while ((page_lru = inactive_dirty_list.prev) != &inactive_dirty_list &&
+				maxscan-- > 0) {
 		page = list_entry(page_lru, struct page, lru);
 
-		/* Move the bookmark backwards.. */
-		list_del(marker_lru);
-		list_add_tail(marker_lru, page_lru);
-
-		/* Don't waste CPU if chances are we cannot free anything. */
-		if (launder_loop && maxlaunder < 0 && cannot_free_pages)
-			break;
-
-		/* Skip other people's marker pages. */
-		if (!page->zone)
-			continue;
-
 		/* Wrong page on list?! (list corruption, should not happen) */
 		if (!PageInactiveDirty(page)) {
 			printk("VM: page_launder, wrong page on list.\n");
@@ -492,6 +454,7 @@
 
 		/* Page is or was in use?  Move it to the active list. */
 		if (PageReferenced(page) || page->age > 0 ||
+				page->zone->free_pages > page->zone->pages_high ||
 				(!page->buffers && page_count(page) > 1) ||
 				page_ramdisk(page)) {
 			del_page_from_inactive_dirty_list(page);
@@ -501,9 +464,11 @@
 
 		/*
 		 * The page is locked. IO in progress?
-		 * Skip the page, we'll take a look when it unlocks.
+		 * Move it to the back of the list.
 		 */
 		if (TryLockPage(page)) {
+			list_del(page_lru);
+			list_add(page_lru, &inactive_dirty_list);
 			continue;
 		}
 
@@ -517,8 +482,10 @@
 			if (!writepage)
 				goto page_active;
 
-			/* First time through? Skip the page. */
+			/* First time through? Move it to the back of the list */
 			if (!launder_loop || !CAN_DO_IO) {
+				list_del(page_lru);
+				list_add(page_lru, &inactive_dirty_list);
 				UnlockPage(page);
 				continue;
 			}
@@ -531,8 +498,6 @@
 			writepage(page);
 			page_cache_release(page);
 
-			maxlaunder--;
-
 			/* And re-start the thing.. */
 			spin_lock(&pagemap_lru_lock);
 			continue;
@@ -560,9 +525,9 @@
 			spin_unlock(&pagemap_lru_lock);
 
 			/* Will we do (asynchronous) IO? */
-			if (launder_loop && maxlaunder-- == 0 && sync)
+			if (launder_loop && maxlaunder == 0 && sync)
 				wait = 2;	/* Synchrounous IO */
-			else if (launder_loop && maxlaunder > 0)
+			else if (launder_loop && maxlaunder-- > 0)
 				wait = 1;	/* Async IO */
 			else
 				wait = 0;	/* No IO */
@@ -579,7 +544,7 @@
 
 			/* The buffers were not freed. */
 			if (!clearedbuf) {
-				add_page_to_inactive_dirty_list_marker(page);
+				add_page_to_inactive_dirty_list(page);
 
 			/* The page was only in the buffer cache. */
 			} else if (!page->mapping) {
@@ -635,8 +600,6 @@
 			UnlockPage(page);
 		}
 	}
-	/* Remove our marker. */
-	list_del(marker_lru);
 	spin_unlock(&pagemap_lru_lock);
 
 	/*
@@ -652,29 +615,16 @@
 	 */
 	if ((CAN_DO_IO || CAN_DO_BUFFERS) && !launder_loop && free_shortage()) {
 		launder_loop = 1;
-		/*
-		 * If we, or the previous process running page_launder(),
-		 * managed to free any pages we never do synchronous IO.
-		 */
-		if (cleaned_pages || !cannot_free_pages)
+		/* If we cleaned pages, never do synchronous IO. */
+		if (cleaned_pages)
 			sync = 0;
-		/* Else, do synchronous IO (if we are allowed to). */
-		else if (sync)
-			sync = 1;
 		/* We only do a few "out of order" flushes. */
 		maxlaunder = MAX_LAUNDER;
-		/* Let bdflush take care of the rest. */
+		/* Kflushd takes care of the rest. */
 		wakeup_bdflush(0);
 		goto dirty_page_rescan;
 	}
 
-	/*
-	 * If we failed to free pages (because all pages are dirty)
-	 * we remember this for the next time. This will prevent us
-	 * from wasting too much CPU here.
-	 */
-	cannot_free_pages = !cleaned_pages;
-
 	/* Return the number of pages moved to the inactive_clean list. */
 	return cleaned_pages;
 }
@@ -899,7 +849,7 @@
 	 * list, so this is a relatively cheap operation.
 	 */
 	if (free_shortage()) {
-		ret += page_launder(gfp_mask, 1);
+		ret += page_launder(gfp_mask, user);
 		shrink_dcache_memory(DEF_PRIORITY, gfp_mask);
 		shrink_icache_memory(DEF_PRIORITY, gfp_mask);
 	}
Andrea
