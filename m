Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277401AbRJJU0i>; Wed, 10 Oct 2001 16:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277409AbRJJU03>; Wed, 10 Oct 2001 16:26:29 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:24077 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S277408AbRJJU0R>; Wed, 10 Oct 2001 16:26:17 -0400
Date: Wed, 10 Oct 2001 17:25:30 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: <kernelnewbies@nl.linux.org>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [CFT][PATCH] smoother VM for -ac
Message-ID: <Pine.LNX.4.33L.0110101710150.26495-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

over the last week I've created a small patch which seems
to drastically improve VM performance and interactivity for
2.4.10-ac{9,10}. Initial test results mostly seem to suggest
that the system runs lots smoother for desktop use and doesn't
get into thrashing until the working set _really_ exceeds the
size of RAM.

People have already asked to have this patch integrated into
the -ac kernel, but it would be nice to have a few more test
results from this combined eatcache + stophog patch before
having it integrated ...

The patch implements the following things:
1) bypass page aging entirely for unused objects in
   the cache
2) increase the distance between inactive_shortage
   and inactive_plenty, so kswapd should spend less
   time shuffling random pages around  ...  shouldn't
   make a difference for most loads, but should add
   some robustness in worst cases
3) does page aging _before_ the zone_inactive_plenty()
   test, so old referenced bits get cleared
   [not a big cpu eater, since the code won't run unless
   we have a free or inactive shortage somewhere]
4) in page_alloc.c, the "slowdown" reschedule has been
   made stronger by turning it into a try_to_free_pages(),
   under memory load, this results in allocators calling
   try_to_free_pages() when the amount of work to be done
   isn't too bad yet and pretty much guarantees them they'll
   get to do their allocation immediately afterwards ...
   statistics make sure that the memory hogs are slowed down
   much more than well-behaved programs


Please test this patch and tell Alan and me how it works for
you and whether there are loads where the system performs
worse with this patch than without...

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)

http://www.surriel.com/		http://distro.conectiva.com/



--- linux-2.4.10-ac10/mm/page_alloc.c.orig	Mon Oct  8 18:22:51 2001
+++ linux-2.4.10-ac10/mm/page_alloc.c	Wed Oct 10 14:08:54 2001
@@ -346,22 +346,15 @@
 	 * We wake up kswapd, in the hope that kswapd will
 	 * resolve this situation before memory gets tight.
 	 *
-	 * We also yield the CPU, because that:
-	 * - gives kswapd a chance to do something
-	 * - slows down allocations, in particular the
-	 *   allocations from the fast allocator that's
-	 *   causing the problems ...
-	 * - ... which minimises the impact the "bad guys"
-	 *   have on the rest of the system
-	 * - if we don't have __GFP_IO set, kswapd may be
-	 *   able to free some memory we can't free ourselves
+	 * We'll also help a bit trying to free pages, this
+	 * way statistics will make sure really fast allocators
+	 * are slowed down more than slow allocators and other
+	 * programs in the system shouldn't be impacted as much
+	 * by the hogs.
 	 */
 	wakeup_kswapd();
-	if (gfp_mask & __GFP_WAIT) {
-		__set_current_state(TASK_RUNNING);
-		current->policy |= SCHED_YIELD;
-		schedule();
-	}
+	if (gfp_mask & __GFP_WAIT)
+		try_to_free_pages(gfp_mask);

 	/*
 	 * After waking up kswapd, we try to allocate a page
--- linux-2.4.10-ac10/mm/vmscan.c.orig	Mon Oct  8 18:22:51 2001
+++ linux-2.4.10-ac10/mm/vmscan.c	Mon Oct  8 19:18:12 2001
@@ -50,7 +50,7 @@
 	inactive += zone->inactive_clean_pages;
 	inactive += zone->free_pages;

-	return (inactive > (zone->size / 3));
+	return (inactive > (zone->size * 2 / 5));
 }

 #define FREE_PLENTY_FACTOR 2
@@ -97,6 +97,24 @@
 	return pagecache > limit;
 }

+static inline int page_mapping_notused(struct page * page)
+{
+	struct address_space * mapping = page->mapping;
+
+	if (!mapping)
+		return 0;
+
+	/* This mapping is really large and would monopolise the pagecache. */
+	if (mapping->nrpages > atomic_read(&page_cache_size) / 20);
+		return 0;
+
+	/* File is mmaped by somebody */
+	if (mapping->i_mmap || mapping->i_mmap_shared)
+		return 1;
+
+	return 0;
+}
+
 /*
  * The swap-out function returns 1 if it successfully
  * scanned all the pages it was asked to (`count').
@@ -826,14 +844,14 @@
 		}

 		/*
-		 * Don't deactivate pages from zones which have
-		 * plenty inactive pages.
+		 * Do aging on the pages.  Every time a page is referenced,
+		 * page->age gets incremented.  If it wasn't referenced, we
+		 * decrement page->age.  The page gets moved to the inactive
+		 * list when one of the following is true:
+		 * - the page age reaches 0
+		 * - the object the page belongs to isn't in active use
+		 * - the object the page belongs to is hogging the cache
 		 */
-		if (zone_inactive_plenty(page->zone)) {
-			goto skip_page;
-		}
-
-		/* Do aging on the pages. */
 		if (PageTestandClearReferenced(page)) {
 			age_page_up(page);
 		} else {
@@ -843,20 +861,26 @@
 		}

 		/*
-		 * If the amount of buffer cache pages is too
-		 * high we just move every buffer cache page we
-		 * find to the inactive list. Eventually they'll
-		 * be reclaimed there...
+		 * Don't deactivate pages from zones which have
+		 * plenty inactive pages.
+		 */
+		if (zone_inactive_plenty(page->zone)) {
+			goto skip_page;
+		}
+
+		/*
+		 * If the buffer cache is large, don't do page aging.
+		 * If this page really is used, it'll be referenced
+		 * again while on the inactive list.
 		 */
 		if (page->buffers && !page->mapping && too_many_buffers())
 			deactivate_page_nolock(page);

 		/*
-		 * If the page cache is too large, we deactivate all
-		 * page cache pages which are not in use by a process.
+		 * Deactivate pages from files which aren't in use, busy
+		 * pages will be referenced while on the inactive list.
 		 */
-		if (pagecache_too_large() && page->mapping &&
-				page_count(page) <= (page->buffers ? 2 : 1))
+		if (page_mapping_notused(page))
 			deactivate_page_nolock(page);

 		/*
--- linux-2.4.10-ac10/include/linux/swap.h.orig	Mon Oct  8 18:23:03 2001
+++ linux-2.4.10-ac10/include/linux/swap.h	Mon Oct  8 19:15:09 2001
@@ -261,7 +261,7 @@
 	if (vm_static_inactive_target)
 		return vm_static_inactive_target;

-	return num_physpages / 4;
+	return num_physpages / 5;
 }

 /*

