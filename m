Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262167AbSIZEEW>; Thu, 26 Sep 2002 00:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262163AbSIZEEU>; Thu, 26 Sep 2002 00:04:20 -0400
Received: from packet.digeo.com ([12.110.80.53]:38616 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262156AbSIZEDn>;
	Thu, 26 Sep 2002 00:03:43 -0400
Message-ID: <3D928854.F76986EF@digeo.com>
Date: Wed, 25 Sep 2002 21:08:52 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>, Ed Tomlinson <tomlins@cam.org>
Subject: [patch 3/4] slab reclaim balancing
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Sep 2002 04:08:52.0887 (UTC) FILETIME=[6CCB3A70:01C26512]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



A patch from Ed Tomlinson which improves the way in which the kernel
reclaims slab objects.

The theory is: a cached object's usefulness is measured in terms of the
number of disk seeks which it saves.  Furthermore, we assume that one
dentry or inode saves as many seeks as one pagecache page.

So we reap slab objects at the same rate as we reclaim pages.  For each
1% of reclaimed pagecache we reclaim 1% of slab.  (Actually, we _scan_
1% of slab for each 1% of scanned pages).

Furthermore we assume that one swapout costs twice as many seeks as one
pagecache page, and twice as many seeks as one slab object.  So we
double the pressure on slab when anonymous pages are being considered
for eviction.

The code works nicely, and smoothly.  Possibly it does not shrink slab
hard enough, but that is now very easy to tune up and down.  It is just:

	ratio *= 3;

in shrink_caches().

Slab caches no longer hold onto completely empty pages.  Instead, pages
are freed as soon as they have zero objects.  This is possibly a
performance hit for slabs which have constructors, but it's doubtful. 
Most allocations after a batch of frees are satisfied from inside
internally-fragmented pages and by the time slab gets back onto using
the wholly-empty pages they'll be cache-cold.  slab would be better off
going and requesting a new, cache-warm page and reconstructing the
objects therein.  (Once we have the per-cpu hot-page allocator in
place.  It's happening).

As a consequence of the above, kmem_cache_srhink() is now unused.  No
great loss there - the serialising effect of kmem_cache_shrink and its
semaphore in front of page reclaim was measurably bad.


Still todo:

- batch up the shrinking so we don't call into prune_dcache and
  friends at high frequency asking for a tiny number of objects.

- Maybe expose the shrink ratio via a tunable.

- clean up slab.c

- highmem page reclaim in prune_icache: highmem pages can pin
  inodes.


 fs/dcache.c            |   30 ++++++----------------------
 fs/dquot.c             |   19 ++++--------------
 fs/inode.c             |   29 ++++++++-------------------
 include/linux/dcache.h |    2 -
 include/linux/mm.h     |    1 
 mm/page_alloc.c        |   11 ++++++++++
 mm/slab.c              |    8 +++++--
 mm/vmscan.c            |   51 ++++++++++++++++++++++++++++++++++---------------
 8 files changed, 76 insertions(+), 75 deletions(-)

--- 2.5.38/fs/dcache.c~slabasap	Wed Sep 25 20:15:25 2002
+++ 2.5.38-akpm/fs/dcache.c	Wed Sep 25 20:15:25 2002
@@ -329,12 +329,11 @@ static inline void prune_one_dentry(stru
 void prune_dcache(int count)
 {
 	spin_lock(&dcache_lock);
-	for (;;) {
+	for (; count ; count--) {
 		struct dentry *dentry;
 		struct list_head *tmp;
 
 		tmp = dentry_unused.prev;
-
 		if (tmp == &dentry_unused)
 			break;
 		list_del_init(tmp);
@@ -349,12 +348,8 @@ void prune_dcache(int count)
 		dentry_stat.nr_unused--;
 
 		/* Unused dentry with a count? */
-		if (atomic_read(&dentry->d_count))
-			BUG();
-
+		BUG_ON(atomic_read(&dentry->d_count));
 		prune_one_dentry(dentry);
-		if (!--count)
-			break;
 	}
 	spin_unlock(&dcache_lock);
 }
@@ -573,19 +568,11 @@ void shrink_dcache_anon(struct list_head
 
 /*
  * This is called from kswapd when we think we need some
- * more memory, but aren't really sure how much. So we
- * carefully try to free a _bit_ of our dcache, but not
- * too much.
- *
- * Priority:
- *   1 - very urgent: shrink everything
- *  ...
- *   6 - base-level: try to shrink a bit.
+ * more memory. 
  */
-int shrink_dcache_memory(int priority, unsigned int gfp_mask)
+int shrink_dcache_memory(int ratio, unsigned int gfp_mask)
 {
-	int count = 0;
-
+	int entries = dentry_stat.nr_dentry / ratio + 1;
 	/*
 	 * Nasty deadlock avoidance.
 	 *
@@ -600,11 +587,8 @@ int shrink_dcache_memory(int priority, u
 	if (!(gfp_mask & __GFP_FS))
 		return 0;
 
-	count = dentry_stat.nr_unused / priority;
-
-	prune_dcache(count);
-	kmem_cache_shrink(dentry_cache);
-	return 0;
+	prune_dcache(entries);
+	return entries;
 }
 
 #define NAME_ALLOC_LEN(len)	((len+16) & ~15)
--- 2.5.38/fs/dquot.c~slabasap	Wed Sep 25 20:15:25 2002
+++ 2.5.38-akpm/fs/dquot.c	Wed Sep 25 20:15:25 2002
@@ -480,26 +480,17 @@ static void prune_dqcache(int count)
 
 /*
  * This is called from kswapd when we think we need some
- * more memory, but aren't really sure how much. So we
- * carefully try to free a _bit_ of our dqcache, but not
- * too much.
- *
- * Priority:
- *   1 - very urgent: shrink everything
- *   ...
- *   6 - base-level: try to shrink a bit.
+ * more memory
  */
 
-int shrink_dqcache_memory(int priority, unsigned int gfp_mask)
+int shrink_dqcache_memory(int ratio, unsigned int gfp_mask)
 {
-	int count = 0;
+	int entries = dqstats.allocated_dquots / ratio + 1;
 
 	lock_kernel();
-	count = dqstats.free_dquots / priority;
-	prune_dqcache(count);
+	prune_dqcache(entries);
 	unlock_kernel();
-	kmem_cache_shrink(dquot_cachep);
-	return 0;
+	return entries;
 }
 
 /*
--- 2.5.38/fs/inode.c~slabasap	Wed Sep 25 20:15:25 2002
+++ 2.5.38-akpm/fs/inode.c	Wed Sep 25 20:15:25 2002
@@ -386,10 +386,11 @@ void prune_icache(int goal)
 
 	count = 0;
 	entry = inode_unused.prev;
-	while (entry != &inode_unused)
-	{
+	for(; goal; goal--) {
 		struct list_head *tmp = entry;
 
+		if (entry == &inode_unused)
+			break;
 		entry = entry->prev;
 		inode = INODE(tmp);
 		if (inode->i_state & (I_FREEING|I_CLEAR|I_LOCK))
@@ -403,8 +404,6 @@ void prune_icache(int goal)
 		list_add(tmp, freeable);
 		inode->i_state |= I_FREEING;
 		count++;
-		if (!--goal)
-			break;
 	}
 	inodes_stat.nr_unused -= count;
 	spin_unlock(&inode_lock);
@@ -414,19 +413,11 @@ void prune_icache(int goal)
 
 /*
  * This is called from kswapd when we think we need some
- * more memory, but aren't really sure how much. So we
- * carefully try to free a _bit_ of our icache, but not
- * too much.
- *
- * Priority:
- *   1 - very urgent: shrink everything
- *  ...
- *   6 - base-level: try to shrink a bit.
+ * more memory. 
  */
-int shrink_icache_memory(int priority, int gfp_mask)
+int shrink_icache_memory(int ratio, unsigned int gfp_mask)
 {
-	int count = 0;
-
+	int entries = inodes_stat.nr_inodes / ratio + 1;
 	/*
 	 * Nasty deadlock avoidance..
 	 *
@@ -437,12 +428,10 @@ int shrink_icache_memory(int priority, i
 	if (!(gfp_mask & __GFP_FS))
 		return 0;
 
-	count = inodes_stat.nr_unused / priority;
-
-	prune_icache(count);
-	kmem_cache_shrink(inode_cachep);
-	return 0;
+	prune_icache(entries);
+	return entries;
 }
+EXPORT_SYMBOL(shrink_icache_memory);
 
 /*
  * Called with the inode lock held.
--- 2.5.38/include/linux/dcache.h~slabasap	Wed Sep 25 20:15:25 2002
+++ 2.5.38-akpm/include/linux/dcache.h	Wed Sep 25 20:15:25 2002
@@ -186,7 +186,7 @@ extern int shrink_dcache_memory(int, uns
 extern void prune_dcache(int);
 
 /* icache memory management (defined in linux/fs/inode.c) */
-extern int shrink_icache_memory(int, int);
+extern int shrink_icache_memory(int, unsigned int);
 extern void prune_icache(int);
 
 /* quota cache memory management (defined in linux/fs/dquot.c) */
--- 2.5.38/include/linux/mm.h~slabasap	Wed Sep 25 20:15:25 2002
+++ 2.5.38-akpm/include/linux/mm.h	Wed Sep 25 20:15:25 2002
@@ -524,6 +524,7 @@ extern struct vm_area_struct *find_exten
 
 extern struct page * vmalloc_to_page(void *addr);
 extern unsigned long get_page_cache_size(void);
+extern unsigned int nr_used_zone_pages(void);
 
 #endif /* __KERNEL__ */
 
--- 2.5.38/mm/page_alloc.c~slabasap	Wed Sep 25 20:15:25 2002
+++ 2.5.38-akpm/mm/page_alloc.c	Wed Sep 25 20:15:25 2002
@@ -479,6 +479,17 @@ unsigned int nr_free_pages(void)
 	return sum;
 }
 
+unsigned int nr_used_zone_pages(void)
+{
+	unsigned int pages = 0;
+	struct zone *zone;
+
+	for_each_zone(zone)
+		pages += zone->nr_active + zone->nr_inactive;
+
+	return pages;
+}
+
 static unsigned int nr_free_zone_pages(int offset)
 {
 	pg_data_t *pgdat;
--- 2.5.38/mm/slab.c~slabasap	Wed Sep 25 20:15:25 2002
+++ 2.5.38-akpm/mm/slab.c	Wed Sep 25 20:15:25 2002
@@ -1496,7 +1496,11 @@ static inline void kmem_cache_free_one(k
 		if (unlikely(!--slabp->inuse)) {
 			/* Was partial or full, now empty. */
 			list_del(&slabp->list);
-			list_add(&slabp->list, &cachep->slabs_free);
+/*			list_add(&slabp->list, &cachep->slabs_free); 		*/
+			if (unlikely(list_empty(&cachep->slabs_partial)))
+				list_add(&slabp->list, &cachep->slabs_partial);
+			else
+				kmem_slab_destroy(cachep, slabp);
 		} else if (unlikely(inuse == cachep->num)) {
 			/* Was full. */
 			list_del(&slabp->list);
@@ -1970,7 +1974,7 @@ static int s_show(struct seq_file *m, vo
 	}
 	list_for_each(q,&cachep->slabs_partial) {
 		slabp = list_entry(q, slab_t, list);
-		if (slabp->inuse == cachep->num || !slabp->inuse)
+		if (slabp->inuse == cachep->num)
 			BUG();
 		active_objs += slabp->inuse;
 		active_slabs++;
--- 2.5.38/mm/vmscan.c~slabasap	Wed Sep 25 20:15:25 2002
+++ 2.5.38-akpm/mm/vmscan.c	Wed Sep 25 20:15:25 2002
@@ -70,6 +70,10 @@
 #define prefetchw_prev_lru_page(_page, _base, _field) do { } while (0)
 #endif
 
+#ifndef CONFIG_QUOTA
+#define shrink_dqcache_memory(ratio, gfp_mask) do { } while (0)
+#endif
+
 /* Must be called with page's pte_chain_lock held. */
 static inline int page_mapping_inuse(struct page * page)
 {
@@ -97,7 +101,7 @@ static inline int is_page_cache_freeable
 
 static /* inline */ int
 shrink_list(struct list_head *page_list, int nr_pages,
-		unsigned int gfp_mask, int *max_scan)
+		unsigned int gfp_mask, int *max_scan, int *nr_mapped)
 {
 	struct address_space *mapping;
 	LIST_HEAD(ret_pages);
@@ -116,6 +120,10 @@ shrink_list(struct list_head *page_list,
 		if (TestSetPageLocked(page))
 			goto keep;
 
+		/* Double the slab pressure for mapped and swapcache pages */
+		if (page_mapped(page) || PageSwapCache(page))
+			(*nr_mapped)++;
+
 		BUG_ON(PageActive(page));
 		may_enter_fs = (gfp_mask & __GFP_FS) ||
 				(PageSwapCache(page) && (gfp_mask & __GFP_IO));
@@ -320,7 +328,7 @@ keep:
  */
 static /* inline */ int
 shrink_cache(int nr_pages, struct zone *zone,
-		unsigned int gfp_mask, int max_scan)
+		unsigned int gfp_mask, int max_scan, int *nr_mapped)
 {
 	LIST_HEAD(page_list);
 	struct pagevec pvec;
@@ -371,7 +379,8 @@ shrink_cache(int nr_pages, struct zone *
 
 		max_scan -= nr_scan;
 		KERNEL_STAT_ADD(pgscan, nr_scan);
-		nr_pages = shrink_list(&page_list,nr_pages,gfp_mask,&max_scan);
+		nr_pages = shrink_list(&page_list, nr_pages,
+				gfp_mask, &max_scan, nr_mapped);
 
 		if (nr_pages <= 0 && list_empty(&page_list))
 			goto done;
@@ -522,14 +531,10 @@ refill_inactive_zone(struct zone *zone, 
 
 static /* inline */ int
 shrink_zone(struct zone *zone, int max_scan,
-		unsigned int gfp_mask, int nr_pages)
+		unsigned int gfp_mask, int nr_pages, int *nr_mapped)
 {
 	unsigned long ratio;
 
-	/* This is bogus for ZONE_HIGHMEM? */
-	if (kmem_cache_reap(gfp_mask) >= nr_pages)
-  		return 0;
-
 	/*
 	 * Try to keep the active list 2/3 of the size of the cache.  And
 	 * make sure that refill_inactive is given a decent number of pages.
@@ -547,7 +552,8 @@ shrink_zone(struct zone *zone, int max_s
 		atomic_sub(SWAP_CLUSTER_MAX, &zone->refill_counter);
 		refill_inactive_zone(zone, SWAP_CLUSTER_MAX);
 	}
-	nr_pages = shrink_cache(nr_pages, zone, gfp_mask, max_scan);
+	nr_pages = shrink_cache(nr_pages, zone, gfp_mask,
+				max_scan, nr_mapped);
 	return nr_pages;
 }
 
@@ -557,6 +563,9 @@ shrink_caches(struct zone *classzone, in
 {
 	struct zone *first_classzone;
 	struct zone *zone;
+	int ratio;
+	int nr_mapped = 0;
+	int pages = nr_used_zone_pages();
 
 	first_classzone = classzone->zone_pgdat->node_zones;
 	for (zone = classzone; zone >= first_classzone; zone--) {
@@ -581,16 +590,28 @@ shrink_caches(struct zone *classzone, in
 		max_scan = zone->nr_inactive >> priority;
 		if (max_scan < to_reclaim * 2)
 			max_scan = to_reclaim * 2;
-		unreclaimed = shrink_zone(zone, max_scan, gfp_mask, to_reclaim);
+		unreclaimed = shrink_zone(zone, max_scan,
+				gfp_mask, to_reclaim, &nr_mapped);
 		nr_pages -= to_reclaim - unreclaimed;
 		*total_scanned += max_scan;
 	}
 
-	shrink_dcache_memory(priority, gfp_mask);
-	shrink_icache_memory(1, gfp_mask);
-#ifdef CONFIG_QUOTA
-	shrink_dqcache_memory(DEF_PRIORITY, gfp_mask);
-#endif
+	/*
+	 * Here we assume it costs one seek to replace a lru page and that
+	 * it also takes a seek to recreate a cache object.  With this in
+	 * mind we age equal percentages of the lru and ageable caches.
+	 * This should balance the seeks generated by these structures.
+	 *
+	 * NOTE: for now I do this for all zones.  If we find this is too
+	 * aggressive on large boxes we may want to exclude ZONE_HIGHMEM
+	 *
+	 * If we're encountering mapped pages on the LRU then increase the
+	 * pressure on slab to avoid swapping.
+	 */
+	ratio = (pages / (*total_scanned + nr_mapped + 1)) + 1;
+	shrink_dcache_memory(ratio, gfp_mask);
+	shrink_icache_memory(ratio, gfp_mask);
+	shrink_dqcache_memory(ratio, gfp_mask);
 	return nr_pages;
 }
 

.
