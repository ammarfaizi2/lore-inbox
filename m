Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277094AbRJQTfq>; Wed, 17 Oct 2001 15:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277083AbRJQTfk>; Wed, 17 Oct 2001 15:35:40 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:51718 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S277108AbRJQTfS>; Wed, 17 Oct 2001 15:35:18 -0400
Date: Wed, 17 Oct 2001 16:35:35 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: <linux-mm@kvack.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [CFT][PATCH] hogstop + eatcache fixes 2.4.12-ac3
Message-ID: <Pine.LNX.4.33L.0110171617180.1554-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ As usual ... testers wanted ]

Hi,

The following patch implements a few things for the VM in 2.4.12-ac3:

1) Throttle allocators more than we did before by making them
   call try_to_free_pages() when we get below ->pages_low in
   every zone, but OTOH they'll get to allocate down to ->pages_min
   immediately after having called try_to_free_pages()

   This has the effect of slowing down heavy allocators while still
   giving each allocation relatively low latency.

2) Remove the "swap out the current process" logic from swap_out(),
   this logic does nothing to protect the other programs in the
   system.  In fact, it causes the memory hog to have _more_ page
   faults, thus hurting the system more than when it had a better
   chance to keep its pages in memory.

3) Make the above logic PF_MEMALLOC aware  (oops).

4) Fix the logic errors in the -eatcache part, due to hysterical
   raisins part of the logic was inverted ... *sigh*

5) Remove the special casing for the buffer cache since many
   filesystems put their metadata in the page cache. Instead do
   aging on unmapped buffer/cache when the cache is getting very
   small (and thus the other memory users are huge).

6) Add some specialcasing so the swapcache is treated right.


It would be nice if people could test this patch and send some
feedback, as usual there's the problem that I'm only one person
with a limited set of computers while testing would go much
faster and more thorough if 20 people tested it on their box ;)

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)

http://www.surriel.com/		http://distro.conectiva.com/



--- linux-2.4.12-ac3/mm/page_alloc.c.orig	Tue Oct 16 15:56:38 2001
+++ linux-2.4.12-ac3/mm/page_alloc.c	Tue Oct 16 16:58:17 2001
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
+	if ((gfp_mask & __GFP_WAIT) && !(current->flags & PF_MEMALLOC))
+		try_to_free_pages(gfp_mask);

 	/*
 	 * After waking up kswapd, we try to allocate a page
@@ -431,8 +424,13 @@
 		 * do not have __GFP_FS set it's possible we cannot make
 		 * any progress freeing pages, in that case it's better
 		 * to give up than to deadlock the kernel looping here.
+		 *
+		 * NFS: we must yield the CPU (to rpciod) to avoid deadlock.
 		 */
 		if (gfp_mask & __GFP_WAIT) {
+			__set_current_state(TASK_RUNNING);
+			current->policy |= SCHED_YIELD;
+			schedule();
 			if (!order || free_shortage()) {
 				int progress = try_to_free_pages(gfp_mask);
 				if (progress || (gfp_mask & __GFP_FS))
--- linux-2.4.12-ac3/mm/vmscan.c.orig	Tue Oct 16 15:56:38 2001
+++ linux-2.4.12-ac3/mm/vmscan.c	Wed Oct 17 09:16:58 2001
@@ -74,44 +74,52 @@
 }

 /*
- * In general, page aging can balance the various uses of memory
- * nicely, but sometimes the caches have so much activity that
- * they push out other things and influence system behaviour in
- * a bad way.  If we have too much of a certain cache, we just
- * bypass page aging and drop cache pages a bit faster.
+ * We only do page aging if the object in question is in use or
+ * if the cache is getting small. The "small cache" thing happens
+ * when the working set of processes is getting very large and we
+ * need to be careful which pages we evict...
  */
-static inline int too_many_buffers(void)
+static inline int cache_is_small(void)
 {
 	int bufferpages = atomic_read(&buffermem_pages);
-	int limit = num_physpages * buffer_mem.borrow_percent / 100;
-
-	return bufferpages > limit;
-}
-
-static inline int pagecache_too_large(void)
-{
 	int pagecache = atomic_read(&page_cache_size) - swapper_space.nrpages;
+
 	int limit = num_physpages * page_cache.borrow_percent / 100;

-	return pagecache > limit;
+	return bufferpages + pagecache < limit;
 }

 static inline int page_mapping_notused(struct page * page)
 {
 	struct address_space * mapping = page->mapping;

-	if (!mapping)
+	/*
+	 * If a swap cache page is in the RSS of a process, we age it.
+	 * Otherwise, we don't.
+	 */
+	if (PageSwapCache(page)) {
+	       	if (page_count(page) > (1 + !!page->buffers))
+			return 0;
+
+		return 1;
+	}
+
+	/* If the cache is small, always use page aging. */
+	if (cache_is_small())
 		return 0;

+	if (!mapping)
+		return 1;
+
 	/* This mapping is really large and would monopolise the pagecache. */
 	if (mapping->nrpages > atomic_read(&page_cache_size) / 20);
-		return 0;
+		return 1;

-	/* File is mmaped by somebody */
+	/* File is mmaped by somebody. */
 	if (mapping->i_mmap || mapping->i_mmap_shared)
-		return 1;
+		return 0;

-	return 0;
+	return 1;
 }

 /*
@@ -399,11 +407,7 @@
 	int retval = 0;
 	struct mm_struct *mm = current->mm;

-	/* Always start by trying to penalize the process that is allocating memory */
-	if (mm)
-		retval = swap_out_mm(mm, swap_amount(mm));
-
-	/* Then, look at the other mm's */
+	/* Scan part of the process virtual memory. */
 	counter = (mmlist_nr << SWAP_SHIFT) >> priority;
 	do {
 		spin_lock(&mmlist_lock);
@@ -836,8 +840,6 @@
 			age_page_up(page);
 		} else {
 			age_page_down(page);
-			if (!page->age)
-				deactivate_page_nolock(page);
 		}

 		/*
@@ -848,12 +850,8 @@
 			goto skip_page;
 		}

-		/*
-		 * If the buffer cache is large, don't do page aging.
-		 * If this page really is used, it'll be referenced
-		 * again while on the inactive list.
-		 */
-		if (page->buffers && !page->mapping && too_many_buffers())
+		/* Deactivate a page once page->age reaches 0. */
+		if (!page->age)
 			deactivate_page_nolock(page);

 		/*

