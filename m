Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261801AbREXM6L>; Thu, 24 May 2001 08:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261805AbREXM5w>; Thu, 24 May 2001 08:57:52 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:20229 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S261801AbREXM5t>; Thu, 24 May 2001 08:57:49 -0400
Date: Thu, 24 May 2001 09:57:20 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>, <arjanv@redhat.com>,
        <linux-mm@kvack.org>, Ben LaHaise <bcrl@redhat.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: [PATCH] 2.4.5-pre5 VM patch
Message-ID: <Pine.LNX.4.33.0105240955240.10469-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here are yesterday's 2 VM patches, cleaned up as per the
suggestion of Jeff Garzik and improved a little bit more
in the nr_free_buffer_pages_area().

Please apply for the next pre-kernel.

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/




--- linux-2.4.5-pre5/mm/page_alloc.c.orig	Thu May 24 02:57:48 2001
+++ linux-2.4.5-pre5/mm/page_alloc.c	Thu May 24 06:31:18 2001
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

@@ -488,6 +481,10 @@
 				return page;
 		}

+		/* Don't let GFP_BUFFER allocations eat all the memory. */
+		if (gfp_mask==GFP_BUFFER && z->free_pages < z->pages_min * 3/4)
+			continue;
+
 		/* XXX: is pages_min/4 a good amount to reserve for this? */
 		if (z->free_pages < z->pages_min / 4 &&
 				!(current->flags & PF_MEMALLOC))
@@ -498,7 +495,7 @@
 	}

 	/* No luck.. */
-	printk(KERN_ERR "__alloc_pages: %lu-order allocation failed.\n", order);
+//	printk(KERN_ERR "__alloc_pages: %lu-order allocation failed.\n", order);
 	return NULL;
 }

@@ -577,34 +574,66 @@
 }

 /*
+ * Total amount of inactive_clean (allocatable) RAM in a given zone.
+ */
+#ifdef CONFIG_HIGHMEM
+unsigned int nr_free_buffer_pages_zone (int zone_type)
+{
+	pg_data_t	*pgdat;
+	unsigned int	 sum;
+
+	sum = 0;
+	pgdat = pgdat_list;
+	while (pgdat) {
+		sum += (pgdat->node_zones+zone_type)->free_pages;
+		sum += (pgdat->node_zones+zone_type)->inactive_clean_pages;
+		sum += (pgdat->node_zones+zone_type)->inactive_dirty_pages;
+		pgdat = pgdat->node_next;
+	}
+	return sum;
+}
+#endif
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
+#ifdef CONFIG_HIGHMEM
+	sum = nr_free_buffer_pages_zone(ZONE_NORMAL) +
+	      nr_free_buffer_pages_zone(ZONE_DMA);
+#else
+	sum = nr_free_pages() +
+	      nr_inactive_clean_pages();
 	sum += nr_inactive_dirty_pages;
+#endif

 	/*
 	 * Keep our write behind queue filled, even if
-	 * kswapd lags a bit right now.
+	 * kswapd lags a bit right now. Make sure not
+	 * to clog up the whole inactive_dirty list with
+	 * dirty pages, though.
 	 */
-	if (sum < freepages.high + inactive_target)
-		sum = freepages.high + inactive_target;
+	if (sum < freepages.high + inactive_target / 2)
+		sum = freepages.high + inactive_target / 2;
 	/*
 	 * We don't want dirty page writebehind to put too
 	 * much pressure on the working set, but we want it
 	 * to be possible to have some dirty pages in the
 	 * working set without upsetting the writebehind logic.
 	 */
-	sum += nr_active_pages >> 4;
+	sum += nr_active_pages >> 5;

 	return sum;
 }

-#if CONFIG_HIGHMEM
+#ifdef CONFIG_HIGHMEM
 unsigned int nr_free_highpages (void)
 {
 	pg_data_t *pgdat = pgdat_list;
--- linux-2.4.5-pre5/mm/vmscan.c.orig	Thu May 24 02:57:48 2001
+++ linux-2.4.5-pre5/mm/vmscan.c	Thu May 24 05:42:00 2001
@@ -865,14 +865,18 @@

 	/*
 	 * If we're low on free pages, move pages from the
-	 * inactive_dirty list to the inactive_clean list.
+	 * inactive_dirty list to the inactive_clean list
+	 * and shrink the inode and dentry caches.
 	 *
 	 * Usually bdflush will have pre-cleaned the pages
 	 * before we get around to moving them to the other
 	 * list, so this is a relatively cheap operation.
 	 */
-	if (free_shortage())
+	if (free_shortage()) {
 		ret += page_launder(gfp_mask, user);
+		shrink_dcache_memory(DEF_PRIORITY, gfp_mask);
+		shrink_icache_memory(DEF_PRIORITY, gfp_mask);
+	}

 	/*
 	 * If needed, we move pages from the active list
@@ -882,21 +886,10 @@
 		ret += refill_inactive(gfp_mask, user);

 	/*
-	 * Delete pages from the inode and dentry caches and
-	 * reclaim unused slab cache if memory is low.
+	 * If we're still short on free pages, reclaim unused
+	 * slab cache memory.
 	 */
 	if (free_shortage()) {
-		shrink_dcache_memory(DEF_PRIORITY, gfp_mask);
-		shrink_icache_memory(DEF_PRIORITY, gfp_mask);
-	} else {
-		/*
-		 * Illogical, but true. At least for now.
-		 *
-		 * If we're _not_ under shortage any more, we
-		 * reap the caches. Why? Because a noticeable
-		 * part of the caches are the buffer-heads,
-		 * which we'll want to keep if under shortage.
-		 */
 		kmem_cache_reap(gfp_mask);
 	}


