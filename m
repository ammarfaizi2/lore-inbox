Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262256AbRENGyw>; Mon, 14 May 2001 02:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262254AbRENGyn>; Mon, 14 May 2001 02:54:43 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:49932 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S262253AbRENGy3>;
	Mon, 14 May 2001 02:54:29 -0400
Date: Mon, 14 May 2001 03:54:21 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] vmscan.c fixes
Message-ID: <Pine.LNX.4.21.0105140335580.4671-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

the following patch does:

1) fix swap_amount() to never return a swap count larger than
   the process' RSS and swap_out() to return immediately when
   swapping out a process with 0 RSS

2) the counter in swap_out() is corrected with a factor of
   1<<SWAP_SHIFT, so swap_out() now scans an equal amount of
   pages to what is scanned by refill_inactive_scan()

3) leave the referenced bit set on pages rescued from one of
   the inactive page queues, this particularly helps page aging
   of buffer cache pages under memory pressure
   -- thanks to Marcelo Tosatti

4) refill_inactive_scan() now takes a target of the number of
   pages to deactivate, this balances the way refill_inactive_scan()
   and swap_out() do their scans and will make it possible to sanely
   balance refill_inactive()

5) refill_inactive_scan() puts a bound on background aging; since
   background aging is done to _increase_ the page aging info in
   the system, we do normal background scanning when we have up to
   10% inactive+free pages, very light background scanning up to
   25% inactive+free pages and no background scanning at all after
   that

6) with the >= change in __alloc_pages(), we can drop the silly
   +1 thing from free_shortage()

7) updated the comments to refill_inactive()

8) in refill_inactive(), make it possible for kswapd to fix even
   big inactive shortages with just one scan; this should avoid
   spurious kswapd wakeups, context switches and apps blocking
   while trying to free pages themselves  ...  note how not being
   able to deactivate enough pages interferes with the ability to
   free pages and the kswapd sleep condition

9) change the balancing loop in refill_inactive() so both
   refill_inactive_scan() and swap_out() are called in the same way
   and can be balanced

10) in do_try_to_free_pages() only call page_launder() for situations
   page_launder actually tries to solve ... calling it in a situation
   which page_launder doesn't solve will only waste CPU

11) move the background scanning into the once-a-second block, this
   probably doesn't have any performance influence at all but I like
   it better this way ;)

12) don't try to wake up kswapd if it's already hard at work, this
   saves a metric shitload of context switches in Mike Galbraith's
   tests so I included it

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)


--- linux-2.4.5-pre1/mm/vmscan.c.orig	Mon May 14 02:11:30 2001
+++ linux-2.4.5-pre1/mm/vmscan.c	Mon May 14 03:34:52 2001
@@ -24,6 +24,8 @@
 
 #include <asm/pgalloc.h>
 
+#define MAX(a,b) ((a) > (b) ? (a) : (b))
+
 /*
  * The swap-out function returns 1 if it successfully
  * scanned all the pages it was asked to (`count').
@@ -228,6 +230,8 @@
 	unsigned long address;
 	struct vm_area_struct* vma;
 
+	if (!count)
+		return 1;
 	/*
 	 * Go through process' page directory.
 	 */
@@ -271,7 +275,12 @@
 static inline int swap_amount(struct mm_struct *mm)
 {
 	int nr = mm->rss >> SWAP_SHIFT;
-	return nr < SWAP_MIN ? SWAP_MIN : nr;
+	if (nr < SWAP_MIN) {
+		nr = SWAP_MIN;
+		if (nr > mm->rss)
+			nr = mm->rss;
+	}
+	return nr;
 }
 
 static int swap_out(unsigned int priority, int gfp_mask)
@@ -285,7 +294,7 @@
 		retval = swap_out_mm(mm, swap_amount(mm));
 
 	/* Then, look at the other mm's */
-	counter = mmlist_nr >> priority;
+	counter = (mmlist_nr << SWAP_SHIFT) >> priority;
 	do {
 		struct list_head *p;
 
@@ -350,7 +359,7 @@
 		}
 
 		/* Page is or was in use?  Move it to the active list. */
-		if (PageTestandClearReferenced(page) || page->age > 0 ||
+		if (PageReferenced(page) || page->age > 0 ||
 				(!page->buffers && page_count(page) > 1)) {
 			del_page_from_inactive_clean_list(page);
 			add_page_to_active_list(page);
@@ -453,7 +462,7 @@
 		}
 
 		/* Page is or was in use?  Move it to the active list. */
-		if (PageTestandClearReferenced(page) || page->age > 0 ||
+		if (PageReferenced(page) || page->age > 0 ||
 				(!page->buffers && page_count(page) > 1) ||
 				page_ramdisk(page)) {
 			del_page_from_inactive_dirty_list(page);
@@ -631,21 +640,42 @@
 /**
  * refill_inactive_scan - scan the active list and find pages to deactivate
  * @priority: the priority at which to scan
- * @oneshot: exit after deactivating one page
+ * @target: number of pages to deactivate, zero for background aging
  *
  * This function will scan a portion of the active list to find
  * unused pages, those pages will then be moved to the inactive list.
  */
-int refill_inactive_scan(unsigned int priority, int oneshot)
+int refill_inactive_scan(unsigned int priority, int target)
 {
 	struct list_head * page_lru;
 	struct page * page;
-	int maxscan, page_active = 0;
-	int ret = 0;
+	int maxscan = nr_active_pages >> priority;
+	int page_active = 0;
+	int nr_deactivated = 0;
+
+	/*
+	 * When we are background aging, we try to increase the page aging
+	 * information in the system. When we have too many inactive pages
+	 * we don't do background aging since having all pages on the
+	 * inactive list decreases aging information.
+	 *
+	 * Since not all active pages have to be on the active list, we round
+	 * nr_active_pages up to num_physpages/2, if needed.
+	 */
+	if (!target) {
+		int inactive = nr_free_pages() + nr_inactive_clean_pages() +
+						nr_inactive_dirty_pages;
+		int active = MAX(nr_active_pages, num_physpages / 2);
+		if (active > 10 * inactive)
+			maxscan = nr_active_pages >> 4;
+		else if (active > 3 * inactive)
+			maxscan = nr_active_pages >> 8;
+		else
+			return 0;
+	}
 
 	/* Take the lock while messing with the list... */
 	spin_lock(&pagemap_lru_lock);
-	maxscan = nr_active_pages >> priority;
 	while (maxscan-- > 0 && (page_lru = active_list.prev) != &active_list) {
 		page = list_entry(page_lru, struct page, lru);
 
@@ -683,21 +713,21 @@
 		}
 		/*
 		 * If the page is still on the active list, move it
-		 * to the other end of the list. Otherwise it was
-		 * deactivated by age_page_down and we exit successfully.
+		 * to the other end of the list. Otherwise we exit if
+		 * we have done enough work.
 		 */
 		if (page_active || PageActive(page)) {
 			list_del(page_lru);
 			list_add(page_lru, &active_list);
 		} else {
-			ret = 1;
-			if (oneshot)
+			nr_deactivated++;
+			if (target && nr_deactivated >= target)
 				break;
 		}
 	}
 	spin_unlock(&pagemap_lru_lock);
 
-	return ret;
+	return nr_deactivated;
 }
 
 /*
@@ -709,6 +739,7 @@
 	pg_data_t *pgdat = pgdat_list;
 	int sum = 0;
 	int freeable = nr_free_pages() + nr_inactive_clean_pages();
+	/* XXX: dynamic free target is complicated and may be wrong... */
 	int freetarget = freepages.high + inactive_target / 3;
 
 	/* Are we low on free pages globally? */
@@ -721,9 +752,8 @@
 		for(i = 0; i < MAX_NR_ZONES; i++) {
 			zone_t *zone = pgdat->node_zones+ i;
 			if (zone->size && (zone->inactive_clean_pages +
-					zone->free_pages < zone->pages_min+1)) {
-				/* + 1 to have overlap with alloc_pages() !! */
-				sum += zone->pages_min + 1;
+					zone->free_pages < zone->pages_min)) {
+				sum += zone->pages_min;
 				sum -= zone->free_pages;
 				sum -= zone->inactive_clean_pages;
 			}
@@ -777,38 +807,46 @@
 }
 
 /*
- * We need to make the locks finer granularity, but right
- * now we need this so that we can do page allocations
- * without holding the kernel lock etc.
+ * Refill_inactive is the function used to scan and age the pages on
+ * the active list and in the working set of processes, moving the
+ * little-used pages to the inactive list.
  *
- * We want to try to free "count" pages, and we want to 
- * cluster them so that we get good swap-out behaviour.
+ * When called by kswapd, we try to deactivate as many pages as needed
+ * to recover from the inactive page shortage. This makes it possible
+ * for kswapd to keep up with memory demand so user processes can get
+ * low latency on memory allocations.
  *
- * OTOH, if we're a user process (and not kswapd), we
- * really care about latency. In that case we don't try
- * to free too many pages.
+ * However, when the system starts to get overloaded we can get called
+ * by user processes. For user processes we want to both reduce the
+ * latency and make sure that multiple user processes together don't
+ * deactivate too many pages. To achieve this we simply do less work
+ * when called from a user process.
  */
 #define DEF_PRIORITY (6)
 static int refill_inactive(unsigned int gfp_mask, int user)
 {
 	int count, start_count, maxtry;
 
-	count = inactive_shortage() + free_shortage();
-	if (user)
+	if (user) {
 		count = (1 << page_cluster);
-	start_count = count;
+		maxtry = 6;
+	} else {
+		count = inactive_shortage();
+		maxtry = 1 << DEF_PRIORITY;
+	}
 
-	maxtry = 6;
+	start_count = count;
 	do {
 		if (current->need_resched) {
 			__set_current_state(TASK_RUNNING);
 			schedule();
+			if (!inactive_shortage())
+				return 1;
 		}
 
-		while (refill_inactive_scan(DEF_PRIORITY, 1)) {
-			if (--count <= 0)
-				goto done;
-		}
+		count -= refill_inactive_scan(DEF_PRIORITY, count);
+		if (count <= 0)
+			goto done;
 
 		/* If refill_inactive_scan failed, try to page stuff out.. */
 		swap_out(DEF_PRIORITY, gfp_mask);
@@ -834,8 +872,7 @@
 	 * before we get around to moving them to the other
 	 * list, so this is a relatively cheap operation.
 	 */
-	if (free_shortage() || nr_inactive_dirty_pages > nr_free_pages() +
-			nr_inactive_clean_pages())
+	if (free_shortage())
 		ret += page_launder(gfp_mask, user);
 
 	/*
@@ -918,18 +955,15 @@
 		if (inactive_shortage() || free_shortage()) 
 			do_try_to_free_pages(GFP_KSWAPD, 0);
 
-		/*
-		 * Do some (very minimal) background scanning. This
-		 * will scan all pages on the active list once
-		 * every minute. This clears old referenced bits
-		 * and moves unused pages to the inactive list.
-		 */
-		refill_inactive_scan(DEF_PRIORITY, 0);
-
-		/* Once a second, recalculate some VM stats. */
+		/* Once a second ... */
 		if (time_after(jiffies, recalc + HZ)) {
 			recalc = jiffies;
+
+			/* Recalculate VM statistics. */
 			recalculate_vm_stats();
+
+			/* Do background page aging. */
+			refill_inactive_scan(DEF_PRIORITY, 0);
 		}
 
 		run_task_queue(&tq_disk);
@@ -964,7 +998,7 @@
 
 void wakeup_kswapd(void)
 {
-	if (current != kswapd_task)
+	if (waitqueue_active(&kswapd_wait))
 		wake_up_process(kswapd_task);
 }
 

