Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277913AbRJITHk>; Tue, 9 Oct 2001 15:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277914AbRJITHX>; Tue, 9 Oct 2001 15:07:23 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:14178 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S277913AbRJITHD>; Tue, 9 Oct 2001 15:07:03 -0400
Date: Tue, 9 Oct 2001 21:07:09 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: memory balancing highmem/dma fixes against pre6
Message-ID: <20011009210709.G724@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here it is how I fixed the highmem faliures in 2.4.11pre6aa1. I think
you won't like some of the things I did sorry. Also temporarly removed
the oom killer again, until I hook it into a better place (not kswpad)
and I don't kill in function of the size of the task that I'd hate on my
machines where big but innocent things runs all the time.

This seems to work just fine here with highmem emulation, and the
refill_inactive and friends are now highmem aware and this fixes the
problem completly in the testing I did (and it's certainly much more
efficient than looping over and over again always doing the wrong thing
for a long time). Now I think real hardware will like it as well, but
that still has to be demonstrated.

But now the memory balancing seems completly relaible and swap behaviour
seems really nice. cache behaviour should be the same as 2.4.11pre6
except I don't penalize readahead compared to "used once" data and I
avoid rolling over the inactive list in case there's no readahead for
example. 

I also avoided the decreasing priority per Linus's suggestion to avoid
banging too much on the inactive list while we swapout.

diff -urN 2.4.11pre6/include/linux/mmzone.h vm/include/linux/mmzone.h
--- 2.4.11pre6/include/linux/mmzone.h	Mon Oct  8 04:28:58 2001
+++ vm/include/linux/mmzone.h	Tue Oct  9 06:49:39 2001
@@ -41,6 +41,7 @@
 	unsigned long		free_pages;
 	unsigned long		pages_min, pages_low, pages_high;
 	int			need_balance;
+	int			nr_active_pages, nr_inactive_pages;
 
 	/*
 	 * free areas of different sizes
diff -urN 2.4.11pre6/include/linux/swap.h vm/include/linux/swap.h
--- 2.4.11pre6/include/linux/swap.h	Tue Oct  9 00:11:22 2001
+++ vm/include/linux/swap.h	Tue Oct  9 06:49:39 2001
@@ -131,7 +131,6 @@
 extern struct page * read_swap_cache_async(swp_entry_t);
 
 /* linux/mm/oom_kill.c */
-extern int out_of_memory(void);
 extern void oom_kill(void);
 
 /* linux/mm/swapfile.c */
@@ -173,27 +172,91 @@
 		BUG();				\
 } while (0)
 
+#define inc_nr_active_pages(page)				\
+do {								\
+	pg_data_t * __pgdat;					\
+	zone_t * __classzone, * __overflow;			\
+								\
+	__classzone = (page)->zone;				\
+	__pgdat = __classzone->zone_pgdat;			\
+	__overflow = __pgdat->node_zones + __pgdat->nr_zones;	\
+								\
+	while (__classzone < __overflow) {			\
+		__classzone->nr_active_pages++;			\
+		__classzone++;					\
+	}							\
+	nr_active_pages++;					\
+} while (0)
+
+#define dec_nr_active_pages(page)				\
+do {								\
+	pg_data_t * __pgdat;					\
+	zone_t * __classzone, * __overflow;			\
+								\
+	__classzone = (page)->zone;				\
+	__pgdat = __classzone->zone_pgdat;			\
+	__overflow = __pgdat->node_zones + __pgdat->nr_zones;	\
+								\
+	while (__classzone < __overflow) {			\
+		__classzone->nr_active_pages--;			\
+		__classzone++;					\
+	}							\
+	nr_active_pages--;					\
+} while (0)
+
+#define inc_nr_inactive_pages(page)				\
+do {								\
+	pg_data_t * __pgdat;					\
+	zone_t * __classzone, * __overflow;			\
+								\
+	__classzone = (page)->zone;				\
+	__pgdat = __classzone->zone_pgdat;			\
+	__overflow = __pgdat->node_zones + __pgdat->nr_zones;	\
+								\
+	while (__classzone < __overflow) {			\
+		__classzone->nr_inactive_pages++;		\
+		__classzone++;					\
+	}							\
+	nr_inactive_pages++;					\
+} while (0)
+
+#define dec_nr_inactive_pages(page)				\
+do {								\
+	pg_data_t * __pgdat;					\
+	zone_t * __classzone, * __overflow;			\
+								\
+	__classzone = (page)->zone;				\
+	__pgdat = __classzone->zone_pgdat;			\
+	__overflow = __pgdat->node_zones + __pgdat->nr_zones;	\
+								\
+	while (__classzone < __overflow) {			\
+		__classzone->nr_inactive_pages--;		\
+		__classzone++;					\
+	}							\
+	nr_inactive_pages--;					\
+} while (0)
+
 #define add_page_to_active_list(page)		\
 do {						\
 	DEBUG_LRU_PAGE(page);			\
 	SetPageActive(page);			\
 	list_add(&(page)->lru, &active_list);	\
-	nr_active_pages++;			\
+	inc_nr_active_pages(page);		\
 } while (0)
 
 #define add_page_to_inactive_list(page)		\
 do {						\
 	DEBUG_LRU_PAGE(page);			\
-	SetPageInactive(page);		\
+	SetPageInactive(page);			\
 	list_add(&(page)->lru, &inactive_list);	\
-	nr_inactive_pages++;			\
+	inc_nr_inactive_pages(page);		\
 } while (0)
 
 #define del_page_from_active_list(page)		\
 do {						\
 	list_del(&(page)->lru);			\
 	ClearPageActive(page);			\
-	nr_active_pages--;			\
+	dec_nr_active_pages(page);		\
 	DEBUG_LRU_PAGE(page);			\
 } while (0)
 
@@ -201,7 +264,7 @@
 do {						\
 	list_del(&(page)->lru);			\
 	ClearPageInactive(page);		\
-	nr_inactive_pages--;			\
+	dec_nr_inactive_pages(page);		\
 	DEBUG_LRU_PAGE(page);			\
 } while (0)
 
diff -urN 2.4.11pre6/mm/filemap.c vm/mm/filemap.c
--- 2.4.11pre6/mm/filemap.c	Tue Oct  9 00:11:25 2001
+++ vm/mm/filemap.c	Tue Oct  9 06:49:41 2001
@@ -1633,7 +1633,7 @@
 	 * and possibly copy it over to another page..
 	 */
 	old_page = page;
-	mark_page_accessed(page);
+	activate_page(page);
 	if (no_share) {
 		struct page *new_page = alloc_page(GFP_HIGHUSER);
 
@@ -2746,8 +2746,15 @@
 		}
 unlock:
 		kunmap(page);
+
+		/*
+		 * Mark the page accessed if we wrote the
+		 * beginning or we just did an lseek.
+		 */
+		if (!offset || !file->f_reada)
+			mark_page_accessed(page);
+
 		/* Mark it unlocked again and drop the page.. */
-		SetPageReferenced(page);
 		UnlockPage(page);
 		page_cache_release(page);
 
diff -urN 2.4.11pre6/mm/oom_kill.c vm/mm/oom_kill.c
--- 2.4.11pre6/mm/oom_kill.c	Tue Oct  9 00:11:25 2001
+++ vm/mm/oom_kill.c	Tue Oct  9 06:49:39 2001
@@ -192,67 +192,3 @@
 	schedule();
 	return;
 }
-
-static inline int node_zones_low(pg_data_t *pgdat)
-{
-	zone_t * zone;
-	int i;
-
-	for (i = pgdat->nr_zones-1; i >= 0; i--) {
-		zone = pgdat->node_zones + i;
-
-		if (zone->free_pages > (zone->pages_low))
-			return 0;
-
-	}
-	return 1;
-}
-
-static int all_zones_low(void)
-{
-	pg_data_t * pgdat = pgdat_list;
-
-	pgdat = pgdat_list;
-	do {
-		if (node_zones_low(pgdat))
-			continue;
-		return 0;
-	} while ((pgdat = pgdat->node_next));
-
-	return 1;
-}
-
-/**
- * out_of_memory - is the system out of memory?
- *
- * Returns 0 if there is still enough memory left,
- * 1 when we are out of memory (otherwise).
- */
-int out_of_memory(void)
-{
-	long cache_mem, limit;
-
-	/* Enough free memory?  Not OOM. */
-	if (!all_zones_low())
-		return 0;
-
-	/* Enough swap space left?  Not OOM. */
-	if (nr_swap_pages > 0)
-		return 0;
-
-	/*
-	 * If the buffer and page cache (including swap cache) are over
-	 * their (/proc tunable) minimum, we're still not OOM.  We test
-	 * this to make sure we don't return OOM when the system simply
-	 * has a hard time with the cache.
-	 */
-	cache_mem = atomic_read(&page_cache_size);
-	limit = 2;
-	limit *= num_physpages / 100;
-
-	if (cache_mem > limit)
-		return 0;
-
-	/* Else... */
-	return 1;
-}
diff -urN 2.4.11pre6/mm/page_alloc.c vm/mm/page_alloc.c
--- 2.4.11pre6/mm/page_alloc.c	Tue Oct  9 00:11:25 2001
+++ vm/mm/page_alloc.c	Tue Oct  9 06:49:39 2001
@@ -232,10 +232,8 @@
 static struct page * balance_classzone(zone_t * classzone, unsigned int gfp_mask, unsigned int order, int * freed)
 {
 	struct page * page = NULL;
-	int __freed = 0;
+	int __freed;
 
-	if (!(gfp_mask & __GFP_WAIT))
-		goto out;
 	if (in_interrupt())
 		BUG();
 
@@ -299,7 +297,6 @@
 		}
 		current->nr_local_pages = 0;
 	}
- out:
 	*freed = __freed;
 	return page;
 }
@@ -357,7 +354,6 @@
 
 	/* here we're in the low on memory slow path */
 
-rebalance:
 	if (current->flags & PF_MEMALLOC) {
 		zone = zonelist->zones;
 		for (;;) {
@@ -376,32 +372,47 @@
 	if (!(gfp_mask & __GFP_WAIT))
 		return NULL;
 
+ rebalance:
 	page = balance_classzone(classzone, gfp_mask, order, &freed);
 	if (page)
 		return page;
 
 	zone = zonelist->zones;
-	for (;;) {
-		zone_t *z = *(zone++);
-		if (!z)
-			break;
+	if (likely(freed)) {
+		for (;;) {
+			zone_t *z = *(zone++);
+			if (!z)
+				break;
 
-		if (zone_free_pages(z, order) > z->pages_min) {
-			page = rmqueue(z, order);
-			if (page)
-				return page;
+			if (zone_free_pages(z, order) > z->pages_min) {
+				page = rmqueue(z, order);
+				if (page)
+					return page;
+			}
 		}
-	}
+		if (!order)
+			goto rebalance;
+	} else {
+		/* 
+		 * Check that no other task is been killed meanwhile,
+		 * in such a case we can succeed the allocation.
+		 */
+		for (;;) {
+			zone_t *z = *(zone++);
+			if (!z)
+				break;
 
-	/* Don't let big-order allocations loop */
-	if (order)
-		return NULL;
+			if (zone_free_pages(z, order) > z->pages_high) {
+				page = rmqueue(z, order);
+				if (page)
+					return page;
+			}
+		}
+	}
 
-	/* Yield for kswapd, and try again */
-	current->policy |= SCHED_YIELD;
-	__set_current_state(TASK_RUNNING);
-	schedule();
-	goto rebalance;
+	printk(KERN_NOTICE "__alloc_pages: %u-order allocation failed (gfp=0x%x/%i) from %p\n",
+	       order, gfp_mask, !!(current->flags & PF_MEMALLOC), __builtin_return_address(0));
+	return NULL;
 }
 
 /*
@@ -516,25 +527,24 @@
 		zone_t *zone;
 		for (zone = tmpdat->node_zones;
 			       	zone < tmpdat->node_zones + MAX_NR_ZONES; zone++)
-			printk("Zone:%s freepages:%6lukB min:%6luKB low:%6lukB " 
-				       "high:%6lukB\n", 
-					zone->name,
-					(zone->free_pages)
-					<< ((PAGE_SHIFT-10)),
-					zone->pages_min
-					<< ((PAGE_SHIFT-10)),
-					zone->pages_low
-					<< ((PAGE_SHIFT-10)),
-					zone->pages_high
-					<< ((PAGE_SHIFT-10)));
-			
+			printk("Zone:%s freepages:%6lukB|%lu min:%6luKB|%lu low:%6lukB|%lu high:%6lukB:%lu active:%6dkB|%d inactive:%6dkB|%d\n",
+			       zone->name,
+			       zone->free_pages << (PAGE_SHIFT-10),
+			       zone->free_pages,
+			       zone->pages_min << (PAGE_SHIFT-10),
+			       zone->pages_min,
+			       zone->pages_low << (PAGE_SHIFT-10),
+			       zone->pages_low,
+			       zone->pages_high << (PAGE_SHIFT-10),
+			       zone->pages_high,
+			       zone->nr_active_pages << (PAGE_SHIFT-10),
+			       zone->nr_active_pages,
+			       zone->nr_inactive_pages << (PAGE_SHIFT-10),
+			       zone->nr_inactive_pages);
+
 		tmpdat = tmpdat->node_next;
 	}
 
-	printk("Free pages:      %6dkB (%6dkB HighMem)\n",
-		nr_free_pages() << (PAGE_SHIFT-10),
-		nr_free_highpages() << (PAGE_SHIFT-10));
-
 	printk("( Active: %d, inactive: %d, free: %d )\n",
 	       nr_active_pages,
 	       nr_inactive_pages,
@@ -709,6 +719,7 @@
 		zone->zone_pgdat = pgdat;
 		zone->free_pages = 0;
 		zone->need_balance = 0;
+		zone->nr_active_pages = zone->nr_inactive_pages = 0;
 		if (!size)
 			continue;
 
diff -urN 2.4.11pre6/mm/swap.c vm/mm/swap.c
--- 2.4.11pre6/mm/swap.c	Sun Sep 23 21:11:43 2001
+++ vm/mm/swap.c	Tue Oct  9 06:49:39 2001
@@ -54,6 +54,7 @@
 		del_page_from_active_list(page);
 		add_page_to_inactive_list(page);
 	}
+	ClearPageReferenced(page);
 }	
 
 void deactivate_page(struct page * page)
@@ -79,6 +80,7 @@
 	spin_lock(&pagemap_lru_lock);
 	activate_page_nolock(page);
 	spin_unlock(&pagemap_lru_lock);
+	SetPageReferenced(page);
 }
 
 /**
diff -urN 2.4.11pre6/mm/vmscan.c vm/mm/vmscan.c
--- 2.4.11pre6/mm/vmscan.c	Tue Oct  9 00:11:25 2001
+++ vm/mm/vmscan.c	Tue Oct  9 06:49:41 2001
@@ -47,20 +47,22 @@
 {
 	pte_t pte;
 	swp_entry_t entry;
-	int right_classzone;
 
 	/* Don't look at this pte if it's been accessed recently. */
 	if (ptep_test_and_clear_young(page_table)) {
 		flush_tlb_page(vma, address);
+		mark_page_accessed(page);
 		return 0;
 	}
 
-	if (TryLockPage(page))
+	if (PageActive(page))
 		return 0;
 
-	right_classzone = 1;
 	if (!memclass(page->zone, classzone))
-		right_classzone = 0;
+		return 0;
+
+	if (TryLockPage(page))
+		return 0;
 
 	/* From this point on, the odds are that we're going to
 	 * nuke this pte, so read and clear the pte.  This hook
@@ -89,7 +91,7 @@
 		{
 			int freeable = page_count(page) - !!page->buffers <= 2;
 			page_cache_release(page);
-			return freeable & right_classzone;
+			return freeable;
 		}
 	}
 
@@ -283,14 +285,14 @@
 	return count;
 }
 
-static int FASTCALL(swap_out(unsigned int priority, zone_t * classzone, unsigned int gfp_mask, int nr_pages));
-static int swap_out(unsigned int priority, zone_t * classzone, unsigned int gfp_mask, int nr_pages)
+static int FASTCALL(swap_out(zone_t * classzone, unsigned int gfp_mask, int nr_pages));
+static int swap_out(zone_t * classzone, unsigned int gfp_mask, int nr_pages)
 {
 	int counter;
 	struct mm_struct *mm;
 
 	/* Then, look at the other mm's */
-	counter = mmlist_nr / priority;
+	counter = mmlist_nr;
 	do {
 		if (unlikely(current->need_resched)) {
 			__set_current_state(TASK_RUNNING);
@@ -331,8 +333,7 @@
 {
 	struct list_head * entry;
 
-	spin_lock(&pagemap_lru_lock);
-	while (max_scan && (entry = inactive_list.prev) != &inactive_list) {
+	while (max_scan && classzone->nr_inactive_pages && (entry = inactive_list.prev) != &inactive_list) {
 		struct page * page;
 
 		if (unlikely(current->need_resched)) {
@@ -345,22 +346,23 @@
 
 		page = list_entry(entry, struct page, lru);
 
-		if (unlikely(!PageInactive(page) && !PageActive(page)))
+		if (unlikely(!PageInactive(page)))
 			BUG();
 
 		list_del(entry);
 		list_add(entry, &inactive_list);
-		if (PageTestandClearReferenced(page))
+		ClearPageReferenced(page);
+
+		if (!memclass(page->zone, classzone))
 			continue;
 
 		max_scan--;
 
-		if (unlikely(!memclass(page->zone, classzone)))
-			continue;
-
 		/* Racy check to avoid trylocking when not worthwhile */
-		if (!page->buffers && page_count(page) != 1)
+		if (!page->buffers && page_count(page) != 1) {
+			activate_page_nolock(page);
 			continue;
+		}
 
 		/*
 		 * The page is locked. IO in progress?
@@ -499,13 +501,13 @@
  * We move them the other way when we see the
  * reference bit on the page.
  */
-static void refill_inactive(int nr_pages)
+static void FASTCALL(refill_inactive(int nr_pages, zone_t * classzone));
+static void refill_inactive(int nr_pages, zone_t * classzone)
 {
 	struct list_head * entry;
 
-	spin_lock(&pagemap_lru_lock);
 	entry = active_list.prev;
-	while (nr_pages-- && entry != &active_list) {
+	while (nr_pages && entry != &active_list) {
 		struct page * page;
 
 		page = list_entry(entry, struct page, lru);
@@ -515,15 +517,24 @@
 			list_add(&page->lru, &active_list);
 			continue;
 		}
+		if (!memclass(page->zone, classzone))
+			continue;
+		if (!page->buffers && page_count(page) != 1)
+			continue;
+		nr_pages--;
 
 		del_page_from_active_list(page);
 		add_page_to_inactive_list(page);
+		SetPageReferenced(page);
+	}
+	if (entry != &active_list) {
+		list_del(&active_list);
+		list_add(&active_list, entry);
 	}
-	spin_unlock(&pagemap_lru_lock);
 }
 
-static int FASTCALL(shrink_caches(int priority, zone_t * classzone, unsigned int gfp_mask, int nr_pages));
-static int shrink_caches(int priority, zone_t * classzone, unsigned int gfp_mask, int nr_pages)
+static int FASTCALL(shrink_caches(zone_t * classzone, unsigned int gfp_mask, int nr_pages));
+static int shrink_caches(zone_t * classzone, unsigned int gfp_mask, int nr_pages)
 {
 	int max_scan;
 	int chunk_size = nr_pages;
@@ -533,38 +544,52 @@
 	if (nr_pages <= 0)
 		return 0;
 
+	spin_lock(&pagemap_lru_lock);
 	nr_pages = chunk_size;
 	/* try to keep the active list 2/3 of the size of the cache */
-	ratio = (unsigned long) nr_pages * nr_active_pages / ((nr_inactive_pages + 1) * 2);
-	refill_inactive(ratio);
-  
-	max_scan = nr_inactive_pages / priority;
+	ratio = (unsigned long) nr_pages * classzone->nr_active_pages / ((classzone->nr_inactive_pages * 2) + 1);
+	/* allow the active cache to grow */
+	if (ratio > nr_pages)
+		ratio = nr_pages;
+	refill_inactive(ratio, classzone);
+
+	max_scan = classzone->nr_inactive_pages / DEF_PRIORITY;
 	nr_pages = shrink_cache(nr_pages, max_scan, classzone, gfp_mask);
 	if (nr_pages <= 0)
 		return 0;
 
-	shrink_dcache_memory(priority, gfp_mask);
-	shrink_icache_memory(priority, gfp_mask);
-#ifdef CONFIG_QUOTA
-	shrink_dqcache_memory(DEF_PRIORITY, gfp_mask);
-#endif
+	shrink_dcache_memory(DEF_PRIORITY, gfp_mask);
+	shrink_icache_memory(DEF_PRIORITY, gfp_mask);
 
 	return nr_pages;
 }
 
+static int FASTCALL(check_classzone_need_balance(zone_t * classzone));
+
 int try_to_free_pages(zone_t * classzone, unsigned int gfp_mask, unsigned int order)
 {
 	int ret = 0;
-	int priority = DEF_PRIORITY;
-	int nr_pages = SWAP_CLUSTER_MAX;
 
-	do {
-		nr_pages = shrink_caches(priority, classzone, gfp_mask, nr_pages);
-		if (nr_pages <= 0)
-			return 1;
+	for (;;) {
+		int tries = DEF_PRIORITY << 1;
+		int nr_pages = SWAP_CLUSTER_MAX;
+
+		do {
+			nr_pages = shrink_caches(classzone, gfp_mask, nr_pages);
+			if (nr_pages <= 0)
+				return 1;
 
-		ret |= swap_out(priority, classzone, gfp_mask, SWAP_CLUSTER_MAX << 2);
-	} while (--priority);
+			ret |= swap_out(classzone, gfp_mask, SWAP_CLUSTER_MAX << 2);
+		} while (--tries);
+
+		if (likely(ret))
+			break;
+		if (likely(current->pid != 1) || !check_classzone_need_balance(classzone))
+			break;
+		current->policy |= SCHED_YIELD;
+		__set_current_state(TASK_RUNNING);
+		schedule();
+	}
 
 	return ret;
 }
@@ -598,7 +623,7 @@
 		if (!try_to_free_pages(zone, GFP_KSWAPD, 0)) {
 			zone->need_balance = 0;
 			__set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(HZ);
+			schedule_timeout(HZ*5);
 			continue;
 		}
 		if (check_classzone_need_balance(zone))
@@ -621,9 +646,6 @@
 		do
 			need_more_balance |= kswapd_balance_pgdat(pgdat);
 		while ((pgdat = pgdat->node_next));
-		if (need_more_balance && out_of_memory()) {
-			oom_kill();	
-		}
 	} while (need_more_balance);
 }
 

Andrea
