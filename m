Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261334AbRENExx>; Mon, 14 May 2001 00:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261509AbRENExn>; Mon, 14 May 2001 00:53:43 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:12809 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S261334AbRENEx1>;
	Mon, 14 May 2001 00:53:27 -0400
Date: Mon, 14 May 2001 01:53:03 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] page_alloc.c fixes
Message-ID: <Pine.LNX.4.21.0105140144510.4671-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The attached patch against 2.4.5-pre1 page_alloc.c fixes
the following things:

1) uses >= in __alloc_pages_limit(), so we can get 1 page
   below the limit and tests like free_shortage() and
   out_of_memory() can test for shortage with a simple '<'
   ... this should prevent subtle errors in the future

2) moved the 'z->pages_min + 8' test from __alloc_pages_limit()
   to the first test in __alloc_pages, this should make the code
   a bit more obvious (IMHO)

3) remove the wakeup tests for kswapd and bdflush from the start
   of __alloc_pages(), these hardly do any more than eating CPU;
   especially bdflush was in danger of being woken up with no work
   to do; kswapd will be woken up as soon as the zones start hitting
   z->pages_low, so that should be ok too

4) break the possible infinite loop and device driver hangs by not
   looping in __alloc_pages() for higher-order allocations; that is,
   we stop looping as soon as free_shortage() is reduced to 0, because
   at that point we know the allocation fails due to memory fragmentation
   and not due to free memory shortage

5) fix nr_free_buffer_pages() to not count highmem pages; this is needed
   because highmem pages cannot be allocated as buffer memory and filling
   up all of low memory with dirty buffers is "bad" for performance

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)



--- linux-2.4.5-pre1/mm/page_alloc.c.orig	Mon May 14 01:11:14 2001
+++ linux-2.4.5-pre1/mm/page_alloc.c	Mon May 14 01:42:49 2001
@@ -250,10 +250,10 @@
 				water_mark = z->pages_high;
 		}
 
-		if (z->free_pages + z->inactive_clean_pages > water_mark) {
+		if (z->free_pages + z->inactive_clean_pages >= water_mark) {
 			struct page *page = NULL;
 			/* If possible, reclaim a page directly. */
-			if (direct_reclaim && z->free_pages < z->pages_min + 8)
+			if (direct_reclaim)
 				page = reclaim_page(z);
 			/* If that fails, fall back to rmqueue. */
 			if (!page)
@@ -298,21 +298,6 @@
 	if (order == 0 && (gfp_mask & __GFP_WAIT))
 		direct_reclaim = 1;
 
-	/*
-	 * If we are about to get low on free pages and we also have
-	 * an inactive page shortage, wake up kswapd.
-	 */
-	if (inactive_shortage() > inactive_target / 2 && free_shortage())
-		wakeup_kswapd();
-	/*
-	 * If we are about to get low on free pages and cleaning
-	 * the inactive_dirty pages would fix the situation,
-	 * wake up bdflush.
-	 */
-	else if (free_shortage() && nr_inactive_dirty_pages > free_shortage()
-			&& nr_inactive_dirty_pages >= freepages.high)
-		wakeup_bdflush(0);
-
 try_again:
 	/*
 	 * First, see if we have any zones with lots of free memory.
@@ -328,7 +313,7 @@
 		if (!z->size)
 			BUG();
 
-		if (z->free_pages >= z->pages_low) {
+		if (z->free_pages >= z->pages_min + 8) {
 			page = rmqueue(z, order);
 			if (page)
 				return page;
@@ -396,7 +381,7 @@
 	page = __alloc_pages_limit(zonelist, order, PAGES_MIN, direct_reclaim);
 	if (page)
 		return page;
-
+		
 	/*
 	 * Damn, we didn't succeed.
 	 *
@@ -442,18 +427,20 @@
 		}
 		/*
 		 * When we arrive here, we are really tight on memory.
+		 * Since kswapd didn't succeed in freeing pages for us,
+		 * we try to help it.
 		 *
-		 * We try to free pages ourselves by:
-		 * 	- shrinking the i/d caches.
-		 * 	- reclaiming unused memory from the slab caches.
-		 * 	- swapping/syncing pages to disk (done by page_launder)
-		 * 	- moving clean pages from the inactive dirty list to
-		 * 	  the inactive clean list. (done by page_launder)
+		 * Single page allocs loop until the allocation succeeds.
+		 * Multi-page allocs can fail due to memory fragmentation;
+		 * in that case we bail out to prevent infinite loops and
+		 * hanging device drivers ...
 		 */
 		if (gfp_mask & __GFP_WAIT) {
 			memory_pressure++;
-			try_to_free_pages(gfp_mask);
-			goto try_again;
+			if (!order || free_shortage()) {
+				try_to_free_pages(gfp_mask);
+				goto try_again;
+			}
 		}
 	}
 
@@ -559,6 +546,23 @@
 }
 
 /*
+ * Total amount of free (allocatable) RAM in a given zone.
+ */
+unsigned int nr_free_pages_zone (int zone_type)
+{
+	pg_data_t	*pgdat;
+	unsigned int	 sum;
+
+	sum = 0;
+	pgdat = pgdat_list;
+	while (pgdat) {
+		sum += (pgdat->node_zones+zone_type)->free_pages;
+		pgdat = pgdat->node_next;
+	}
+	return sum;
+}
+
+/*
  * Total amount of inactive_clean (allocatable) RAM:
  */
 unsigned int nr_inactive_clean_pages (void)
@@ -577,14 +581,43 @@
 }
 
 /*
+ * Total amount of inactive_clean (allocatable) RAM in a given zone.
+ */
+unsigned int nr_inactive_clean_pages_zone (int zone_type)
+{
+	pg_data_t	*pgdat;
+	unsigned int	 sum;
+
+	sum = 0;
+	pgdat = pgdat_list;
+	while (pgdat) {
+		sum += (pgdat->node_zones+zone_type)->inactive_clean_pages;
+		pgdat = pgdat->node_next;
+	}
+	return sum;
+}
+
+
+/*
  * Amount of free RAM allocatable as buffer memory:
+ *
+ * For HIGHMEM systems don't count HIGHMEM pages.
+ * This is function is still far from perfect for HIGHMEM systems, but
+ * it is close enough for the time being.
  */
 unsigned int nr_free_buffer_pages (void)
 {
 	unsigned int sum;
 
-	sum = nr_free_pages();
-	sum += nr_inactive_clean_pages();
+#if	CONFIG_HIGHMEM
+	sum = nr_free_pages_zone(ZONE_NORMAL) +
+	      nr_free_pages_zone(ZONE_DMA) +
+	      nr_inactive_clean_pages_zone(ZONE_NORMAL) +
+	      nr_inactive_clean_pages_zone(ZONE_DMA);
+#else
+	sum = nr_free_pages() +
+	      nr_inactive_clean_pages();
+#endif
 	sum += nr_inactive_dirty_pages;
 
 	/*

