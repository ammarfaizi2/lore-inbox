Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263419AbREXItn>; Thu, 24 May 2001 04:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263420AbREXItd>; Thu, 24 May 2001 04:49:33 -0400
Received: from www.wen-online.de ([212.223.88.39]:23557 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S263419AbREXItU>;
	Thu, 24 May 2001 04:49:20 -0400
Date: Thu, 24 May 2001 10:48:48 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Rik van Riel <riel@conectiva.com.br>
cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH] Re: Linux 2.4.4-ac10
In-Reply-To: <Pine.LNX.4.21.0105200546241.5531-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.33.0105241041100.369-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 May 2001, Rik van Riel wrote:

> Remember that inactive_clean pages are always immediately
> reclaimable by __alloc_pages(), if you measured a performance
> difference by freeing pages in a different way I'm pretty sure
> it's a side effect of something else.  What that something
> else is I'm curious to find out, but I'm pretty convinced that
> throwing away data early isn't the way to go.

OK.. let's forget about throughput for a moment and consider
those annoying reports of 0 order allocations failing :)

What do you think of the below (ignore the refill_inactive bit)
wrt allocator reliability under heavy stress?  The thing does
kick in and pump up zones even if I set the 'blood donor' level
to pages_min.

	-Mike

--- linux-2.4.5-pre3/mm/page_alloc.c.org	Mon May 21 10:35:06 2001
+++ linux-2.4.5-pre3/mm/page_alloc.c	Thu May 24 08:18:36 2001
@@ -224,10 +224,11 @@
 			unsigned long order, int limit, int direct_reclaim)
 {
 	zone_t **zone = zonelist->zones;
+	struct page *page = NULL;

 	for (;;) {
 		zone_t *z = *(zone++);
-		unsigned long water_mark;
+		unsigned long water_mark = 1 << order;

 		if (!z)
 			break;
@@ -249,18 +250,44 @@
 			case PAGES_HIGH:
 				water_mark = z->pages_high;
 		}
+		if (z->free_pages + z->inactive_clean_pages < water_mark)
+			continue;

-		if (z->free_pages + z->inactive_clean_pages > water_mark) {
-			struct page *page = NULL;
-			/* If possible, reclaim a page directly. */
-			if (direct_reclaim && z->free_pages < z->pages_min + 8)
+		if (direct_reclaim) {
+			int count;
+
+			/* If we're in bad shape.. */
+			if (z->free_pages < z->pages_low && z->inactive_clean_pages) {
+				count = 4 * (1 << page_cluster);
+				/* reclaim a page for ourselves if we can afford to.. */
+				if (z->inactive_clean_pages > count)
+					page = reclaim_page(z);
+				if (z->inactive_clean_pages < 2 * count)
+					count = z->inactive_clean_pages / 2;
+			} else count = 0;
+
+			/*
+			 * and make a small donation to the reclaim challenged.
+			 *
+			 * We don't ever want a zone to reach the state where we
+			 * have nothing except reclaimable pages left.. not if
+			 * we can possibly do something to help prevent it.
+			 */
+			while (count--) {
+				struct page *page;
 				page = reclaim_page(z);
-			/* If that fails, fall back to rmqueue. */
-			if (!page)
-				page = rmqueue(z, order);
-			if (page)
-				return page;
+				if (!page)
+					break;
+				__free_page(page);
+			}
 		}
+		if (!page)
+			page = rmqueue(z, order);
+		if (page)
+			return page;
+		if (z->inactive_clean_pages - z->free_pages > z->pages_low
+				&& waitqueue_active(&kreclaimd_wait))
+			wake_up_interruptible(&kreclaimd_wait);
 	}

 	/* Found nothing. */
@@ -314,29 +341,6 @@
 		wakeup_bdflush(0);

 try_again:
-	/*
-	 * First, see if we have any zones with lots of free memory.
-	 *
-	 * We allocate free memory first because it doesn't contain
-	 * any data ... DUH!
-	 */
-	zone = zonelist->zones;
-	for (;;) {
-		zone_t *z = *(zone++);
-		if (!z)
-			break;
-		if (!z->size)
-			BUG();
-
-		if (z->free_pages >= z->pages_low) {
-			page = rmqueue(z, order);
-			if (page)
-				return page;
-		} else if (z->free_pages < z->pages_min &&
-					waitqueue_active(&kreclaimd_wait)) {
-				wake_up_interruptible(&kreclaimd_wait);
-		}
-	}

 	/*
 	 * Try to allocate a page from a zone with a HIGH
--- linux-2.4.5-pre3/mm/vmscan.c.org	Thu May 17 16:44:23 2001
+++ linux-2.4.5-pre3/mm/vmscan.c	Thu May 24 08:05:21 2001
@@ -824,39 +824,17 @@
 #define DEF_PRIORITY (6)
 static int refill_inactive(unsigned int gfp_mask, int user)
 {
-	int count, start_count, maxtry;
-
-	if (user) {
-		count = (1 << page_cluster);
-		maxtry = 6;
-	} else {
-		count = inactive_shortage();
-		maxtry = 1 << DEF_PRIORITY;
-	}
-
-	start_count = count;
-	do {
-		if (current->need_resched) {
-			__set_current_state(TASK_RUNNING);
-			schedule();
-			if (!inactive_shortage())
-				return 1;
-		}
-
-		count -= refill_inactive_scan(DEF_PRIORITY, count);
-		if (count <= 0)
-			goto done;
-
-		/* If refill_inactive_scan failed, try to page stuff out.. */
-		swap_out(DEF_PRIORITY, gfp_mask);
-
-		if (--maxtry <= 0)
-				return 0;
-
-	} while (inactive_shortage());
-
-done:
-	return (count < start_count);
+	int shortage = inactive_shortage();
+	int large = freepages.high/2;
+	int scale;
+
+	scale = shortage/large;
+	scale += free_shortage()/large;
+	if (scale > DEF_PRIORITY-1)
+		scale = DEF_PRIORITY-1;
+	if (refill_inactive_scan(DEF_PRIORITY-scale, shortage) < shortage)
+		return swap_out(DEF_PRIORITY, gfp_mask);
+	return 1;
 }

 static int do_try_to_free_pages(unsigned int gfp_mask, int user)
@@ -976,8 +954,9 @@
 		 * We go to sleep for one second, but if it's needed
 		 * we'll be woken up earlier...
 		 */
-		if (!free_shortage() || !inactive_shortage()) {
-			interruptible_sleep_on_timeout(&kswapd_wait, HZ);
+		if (current->need_resched || !free_shortage() ||
+				!inactive_shortage()) {
+			interruptible_sleep_on_timeout(&kswapd_wait, HZ/10);
 		/*
 		 * If we couldn't free enough memory, we see if it was
 		 * due to the system just not having enough memory.
@@ -1051,10 +1030,13 @@
 			int i;
 			for(i = 0; i < MAX_NR_ZONES; i++) {
 				zone_t *zone = pgdat->node_zones + i;
+				int count;
 				if (!zone->size)
 					continue;

-				while (zone->free_pages < zone->pages_low) {
+				count = zone->pages_low;
+				while (zone->free_pages < zone->inactive_clean_pages &&
+						count--) {
 					struct page * page;
 					page = reclaim_page(zone);
 					if (!page)
@@ -1064,6 +1046,9 @@
 			}
 			pgdat = pgdat->node_next;
 		} while (pgdat);
+#if 1
+		run_task_queue(&tq_disk);
+#endif
 	}
 }


