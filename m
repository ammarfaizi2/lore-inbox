Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263324AbREWX46>; Wed, 23 May 2001 19:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263325AbREWX4s>; Wed, 23 May 2001 19:56:48 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:44299 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S263324AbREWX4g>; Wed, 23 May 2001 19:56:36 -0400
Date: Wed, 23 May 2001 20:56:27 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Ben LaHaise <bcrl@redhat.com>, <arjanv@redhat.com>,
        <linux-mm@kvack.org>
Subject: [PATCH] remove deadlocks __alloc_pages()
Message-ID: <Pine.LNX.4.33.0105232046200.311-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the following patch to page_alloc.c:
- removes 2 possible deadlocks from __alloc_pages()
- cleans up the code in __alloc_pages(), moving some "eat free
  pages first" code from __alloc_pages_limit() directly into
  __alloc_pages()
- fixes a minor balancing issue with dirty pages


	Deadlocks:

- GFP_BUFFER allocations can loop forever in __alloc_pages(),
  without freeing up pages and getting a chance of ever
  succeeding
- multi-page allocations can loop forever in __alloc_pages(),
  when there is enough free memory in the system but that free
  memory is fragmented, the allocation will never succeed

Both these deadlocks have been fixed by simply breaking out
of the loop when these conditions are detected. Note that
GFP_BUFFER allocators all expect to deal with allocation
failures every once in a while and that failing the allocation
is the only way of making progress.

Of course, with GFP_BUFFER being able to eat into the reserved
pages a little bit, in most cases its allocation will simply
succeed and the system will run even better ;)


	Cleanup:

- remove the CPU-eating wakeups ... it was quite possible to
  wake up a bdflush which had nothing to do or a kswapd which
  would go to sleep again after only a few sets of context
  switches ... don't wake these up if needed
- move some code around in __alloc_pages() so the eating from
  free pages is done before we call __alloc_pages_limit()
  -- shouldn't have any impact


	Dirty memory balancing:

Since we cannot have highmem pages in the buffer cache, don't
try allow more dirty buffers than we have space for in low
memory. This thing seems to improve the situation quite a bit,
but should probably be improved further for future kernels
(however, that's no reason to not put this improvement in NOW,
there are people who need it).


regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/



--- linux-2.4.5-pre3/mm/page_alloc.c.orig	Wed May 23 14:09:22 2001
+++ linux-2.4.5-pre3/mm/page_alloc.c	Wed May 23 15:36:34 2001
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
@@ -442,18 +427,26 @@
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
+		 *
+		 * Another issue are GFP_BUFFER allocations; because they
+		 * do not have __GFP_IO set it's possible we cannot make
+		 * any progress freeing pages, in that case it's better
+		 * to give up than to deadlock the kernel looping here.
 		 */
 		if (gfp_mask & __GFP_WAIT) {
 			memory_pressure++;
-			try_to_free_pages(gfp_mask);
-			goto try_again;
+			if (!order || free_shortage()) {
+				int progress = try_to_free_pages(gfp_mask);
+				if (progress || gfp_mask & __GFP_IO)
+					goto try_again;
+			}
 		}
 	}

@@ -559,6 +552,23 @@
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
@@ -577,14 +587,43 @@
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

