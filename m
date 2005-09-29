Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbVI2PPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbVI2PPk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 11:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbVI2PPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 11:15:40 -0400
Received: from mail09.syd.optusnet.com.au ([211.29.132.190]:31447 "EHLO
	mail09.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932181AbVI2PPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 11:15:39 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] vm - swap_prefetch v12
Date: Fri, 30 Sep 2005 01:15:32 +1000
User-Agent: KMail/1.8.2
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_VUAPDnEB73NGvuJ"
Message-Id: <200509300115.33060.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_VUAPDnEB73NGvuJ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Latest version of swap prefetching also available in incremental form and for 
download here:
http://ck.kolivas.org/patches/swap-prefetch/

-One unlocking bug was fixed
-Pages are prefetched inactive now so they're the first thing that is swapped 
back out again under pressure
-Numerous tweaks and cleanups including:
-Acted on suggestion by John Corbet (thanks!)

Cheers,
Con

--Boundary-00=_VUAPDnEB73NGvuJ
Content-Type: text/x-diff;
  charset="us-ascii";
  name="vm-swap_prefetch-12.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="vm-swap_prefetch-12.patch"

This patch implements swap prefetching when the vm is relatively idle and
there is free ram available. The code is based on some early work by Thomas
Schlichter.

This stores a list of swapped entries in a list ordered most recently used
and a radix tree. It generates a low priority kernel thread running at nice 19
to do the prefetching at a later stage.

Once pages have been added to the swapped list, a timer is started, testing
for conditions suitable to prefetch swap pages every 5 seconds. Suitable
conditions are defined as lack of swapping out or in any pages, and no
watermark tests failing. Significant amounts of dirtied ram also prevent
prefetching. It then checks that we have spare ram looking for at
least 3* pages_high free per zone and if it succeeds that will prefetch
pages from swap. The pages are prefetched in 128kb groups every 1 second until
the vm is busy for the tests above, the watermarks fail to detect adequate
free ram or the list is emptied. The pages are copied to swap cache and kept
on backing store. This allows pressure on either physical ram or swap to
readily find free pages without further I/O.

In testing on modern pc hardware this results in wall-clock time activation of
the firefox browser to speed up 5 fold after a worst case complete swap-out
of the browser on an static web page.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

 include/linux/swap.h |   32 ++++
 init/Kconfig         |   21 ++
 mm/Makefile          |    1
 mm/page_alloc.c      |   14 +
 mm/swap.c            |    3
 mm/swap_prefetch.c   |  408 +++++++++++++++++++++++++++++++++++++++++++++++++++
 mm/swap_state.c      |   10 +
 mm/vmscan.c          |    5
 8 files changed, 489 insertions(+), 5 deletions(-)

Index: linux-2.6.13-sp/include/linux/swap.h
===================================================================
--- linux-2.6.13-sp.orig/include/linux/swap.h	2005-09-26 15:52:30.000000000 +1000
+++ linux-2.6.13-sp/include/linux/swap.h	2005-09-26 15:52:52.000000000 +1000
@@ -185,6 +185,37 @@ extern int shmem_unuse(swp_entry_t entry
 
 extern void swap_unplug_io_fn(struct backing_dev_info *, struct page *);
 
+#ifdef CONFIG_SWAP_PREFETCH
+/* only used by prefetch externally */
+/*	mm/swap_prefetch.c */
+extern void prepare_prefetch(void);
+extern void add_to_swapped_list(unsigned long index);
+extern void remove_from_swapped_list(unsigned long index);
+extern void delay_prefetch(void);
+/* linux/mm/page_alloc.c */
+extern struct page *
+buffered_rmqueue(struct zone *zone, int order, unsigned int __nocast gfp_flags);
+extern void zone_statistics(struct zonelist *zonelist, struct zone *z);
+
+#else	/* CONFIG_SWAP_PREFETCH */
+static inline void add_to_swapped_list(unsigned long index)
+{
+}
+
+static inline void prepare_prefetch(void)
+{
+}
+
+static inline void remove_from_swapped_list(unsigned long index)
+{
+}
+
+static inline void delay_prefetch(void)
+{
+}
+
+#endif	/* CONFIG_SWAP_PREFETCH */
+
 #ifdef CONFIG_SWAP
 /* linux/mm/page_io.c */
 extern int swap_readpage(struct file *, struct page *);
@@ -206,6 +237,7 @@ extern void free_pages_and_swap_cache(st
 extern struct page * lookup_swap_cache(swp_entry_t);
 extern struct page * read_swap_cache_async(swp_entry_t, struct vm_area_struct *vma,
 					   unsigned long addr);
+extern int add_to_swap_cache(struct page *page, swp_entry_t entry);
 /* linux/mm/swapfile.c */
 extern long total_swap_pages;
 extern unsigned int nr_swapfiles;
Index: linux-2.6.13-sp/init/Kconfig
===================================================================
--- linux-2.6.13-sp.orig/init/Kconfig	2005-09-26 15:52:30.000000000 +1000
+++ linux-2.6.13-sp/init/Kconfig	2005-09-26 15:52:52.000000000 +1000
@@ -87,6 +87,27 @@ config SWAP
 	  used to provide more virtual memory than the actual RAM present
 	  in your computer.  If unsure say Y.
 
+config SWAP_PREFETCH
+	bool "Support for prefetching swapped memory"
+	depends on SWAP && EXPERIMENTAL
+	default n
+	---help---
+	  This option will allow the kernel to prefetch swapped memory pages
+	  when idle. The pages will be kept on both swap and in swap_cache
+	  thus avoiding the need for further I/O if either ram or swap space
+	  is required.
+	  
+	  What this will do on workstations is slowly bring back applications
+	  that have swapped out after memory intensive workloads back into
+	  physical ram if you have free ram at a later stage and the machine
+	  is relatively idle. This means that when you come back to your
+	  computer after leaving it idle for a while, applications will come
+	  to life faster. Note that your swap usage will appear to increase
+	  but these are cached pages, can be dropped freely by the vm, and it
+	  should stabilise around 50% swap usage.
+	  
+	  Desktop users will most likely want to say Y.
+
 config SYSVIPC
 	bool "System V IPC"
 	depends on MMU
Index: linux-2.6.13-sp/mm/Makefile
===================================================================
--- linux-2.6.13-sp.orig/mm/Makefile	2005-09-26 15:52:30.000000000 +1000
+++ linux-2.6.13-sp/mm/Makefile	2005-09-26 15:52:52.000000000 +1000
@@ -13,6 +13,7 @@ obj-y			:= bootmem.o filemap.o mempool.o
 			   prio_tree.o $(mmu-y)
 
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o thrash.o
+obj-$(CONFIG_SWAP_PREFETCH) += swap_prefetch.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
 obj-$(CONFIG_NUMA) 	+= mempolicy.o
 obj-$(CONFIG_SPARSEMEM)	+= sparse.o
Index: linux-2.6.13-sp/mm/page_alloc.c
===================================================================
--- linux-2.6.13-sp.orig/mm/page_alloc.c	2005-09-26 15:52:30.000000000 +1000
+++ linux-2.6.13-sp/mm/page_alloc.c	2005-09-26 15:52:52.000000000 +1000
@@ -607,7 +607,7 @@ void drain_local_pages(void)
 }
 #endif /* CONFIG_PM */
 
-static void zone_statistics(struct zonelist *zonelist, struct zone *z)
+void zone_statistics(struct zonelist *zonelist, struct zone *z)
 {
 #ifdef CONFIG_NUMA
 	unsigned long flags;
@@ -684,7 +684,7 @@ static inline void prep_zero_page(struct
  * we cheat by calling it from here, in the order > 0 path.  Saves a branch
  * or two.
  */
-static struct page *
+struct page *
 buffered_rmqueue(struct zone *zone, int order, unsigned int __nocast gfp_flags)
 {
 	unsigned long flags;
@@ -745,7 +745,7 @@ int zone_watermark_ok(struct zone *z, in
 		min -= min / 4;
 
 	if (free_pages <= min + z->lowmem_reserve[classzone_idx])
-		return 0;
+		goto out_failed;
 	for (o = 0; o < order; o++) {
 		/* At the next order, this order's pages become unavailable */
 		free_pages -= z->free_area[o].nr_free << o;
@@ -754,9 +754,15 @@ int zone_watermark_ok(struct zone *z, in
 		min >>= 1;
 
 		if (free_pages <= min)
-			return 0;
+			goto out_failed;
 	}
+
 	return 1;
+out_failed:
+	/* Swap prefetching is delayed if any watermark is low */
+	delay_prefetch();
+
+	return 0;	
 }
 
 static inline int
Index: linux-2.6.13-sp/mm/swap.c
===================================================================
--- linux-2.6.13-sp.orig/mm/swap.c	2005-09-26 15:52:30.000000000 +1000
+++ linux-2.6.13-sp/mm/swap.c	2005-09-26 15:52:52.000000000 +1000
@@ -481,5 +481,8 @@ void __init swap_setup(void)
 	 * Right now other parts of the system means that we
 	 * _really_ don't want to cluster much more
 	 */
+
+	prepare_prefetch();
+
 	hotcpu_notifier(cpu_swap_callback, 0);
 }
Index: linux-2.6.13-sp/mm/swap_prefetch.c
===================================================================
--- linux-2.6.13-sp.orig/mm/swap_prefetch.c	2005-09-30 00:30:04.016590920 +1000
+++ linux-2.6.13-sp/mm/swap_prefetch.c	2005-09-30 00:51:37.000000000 +1000
@@ -0,0 +1,408 @@
+/*
+ * linux/mm/swap_prefetch.c
+ *
+ * Copyright (C) 2005 Con Kolivas
+ *
+ * Written by Con Kolivas <kernel@kolivas.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/swap.h>
+#include <linux/fs.h>
+#include <linux/pagemap.h>
+
+/* Time to delay prefetching if vm is busy or prefetching unsuccessful */
+#define PREFETCH_DELAY	(HZ * 5)
+/* Time between attempting prefetching when vm is idle */
+#define PREFETCH_INTERVAL (HZ)
+
+struct swapped_root_t {
+	unsigned long		busy;
+	spinlock_t		lock;
+	struct list_head	list;
+	struct radix_tree_root	swap_tree;	
+	rwlock_t		*rwlock;
+	unsigned int		count;
+	unsigned int		maxcount;
+	kmem_cache_t		*cache;
+};
+
+struct swapped_entry_t {
+	swp_entry_t		swp_entry;
+	struct list_head	swapped_list;
+};
+
+static struct swapped_root_t swapped = {
+	.busy 		= 0,
+	.list  		= LIST_HEAD_INIT(swapped.list),
+	.swap_tree	= RADIX_TREE_INIT(GFP_ATOMIC),
+	.rwlock		= &swapper_space.tree_lock,
+	.count 		= 0,
+};
+
+static struct timer_list prefetch_timer;
+
+static DECLARE_WAIT_QUEUE_HEAD(kprefetchd_wait);
+
+static unsigned long mapped_limit;
+
+/*
+ * Create kmem cache for swapped entries
+ */
+void __init prepare_prefetch(void)
+{
+	long total_memory = nr_free_pagecache_pages();
+	long se_size = sizeof(struct swapped_entry_t);
+
+	swapped.cache = kmem_cache_create("swapped_entry", se_size,
+		0, 0, NULL, NULL);
+	if (unlikely(!swapped.cache))
+		panic("prepare_prefetch(): cannot create swapped_entry SLAB cache");
+
+	/* Set max count of swapped entries to 5% ram */
+	swapped.maxcount = (total_memory / 20) * (PAGE_SIZE / se_size);
+	/* Set maximum amount of mapped pages to prefetch to 2/3 ram */
+	mapped_limit = total_memory / 3 * 2;
+
+	spin_lock_init(&swapped.lock);
+}
+
+static inline void delay_prefetch_timer(void)
+{
+	mod_timer(&prefetch_timer, jiffies + PREFETCH_DELAY);
+}
+
+static inline void reset_prefetch_timer(void)
+{
+	mod_timer(&prefetch_timer, jiffies + PREFETCH_INTERVAL);
+}
+
+/*
+ * We check to see no part of the vm is busy. If it is this will interrupt
+ * trickle_swap and wait another PREFETCH_DELAY. Purposefully racy.
+ */
+void delay_prefetch(void)
+{
+	__set_bit(0, &swapped.busy);
+}
+
+/*
+ * Accounting is sloppy on purpose. As adding and removing entries from the
+ * list happens during swapping in and out we don't want to be spinning on
+ * locks. It is cheaper to just miss adding an entry since having a reference
+ * to every entry is not critical.
+ */
+void add_to_swapped_list(unsigned long index)
+{
+	struct swapped_entry_t *entry;
+	int error;
+
+	if (unlikely(!spin_trylock(&swapped.lock)))
+		goto out;
+
+	if (swapped.count >= swapped.maxcount) {
+		entry = list_entry(swapped.list.next,
+				struct swapped_entry_t, swapped_list);
+		radix_tree_delete(&swapped.swap_tree, entry->swp_entry.val);
+		list_del(&entry->swapped_list);
+		swapped.count--;
+	} else {
+		entry = kmem_cache_alloc(swapped.cache, GFP_ATOMIC);
+		if (unlikely(!entry))
+			/* bad, can't allocate more mem */
+			goto out_locked;
+	}
+
+	entry->swp_entry.val = index;
+
+	error = radix_tree_preload(GFP_ATOMIC);
+	if (likely(!error)) {
+		error = radix_tree_insert(&swapped.swap_tree, index, entry);
+		if (likely(!error)) {
+			/*
+			 * If this is the first entry the timer needs to be
+			 * (re)started
+			 */
+			if (list_empty(&swapped.list))
+				delay_prefetch_timer();
+			list_add(&entry->swapped_list, &swapped.list);
+			swapped.count++;
+		}
+		radix_tree_preload_end();
+	} else
+		kmem_cache_free(swapped.cache, entry);
+
+out_locked:
+	spin_unlock(&swapped.lock);
+out:
+	return;
+}
+
+/*
+ * Cheaper to not spin on the lock and remove the entry lazily via
+ * add_to_swap_cache when we hit it in trickle_swap_cache_async
+ */
+void remove_from_swapped_list(unsigned long index)
+{
+	struct swapped_entry_t *entry;
+	unsigned long flags;
+
+	if (unlikely(!spin_trylock_irqsave(&swapped.lock, flags)))
+		return;
+	entry = radix_tree_delete(&swapped.swap_tree, index);
+	if (likely(entry)) {
+		list_del_init(&entry->swapped_list);
+		swapped.count--;
+		kmem_cache_free(swapped.cache, entry);
+	}
+	spin_unlock_irqrestore(&swapped.lock, flags);
+}
+
+/*
+ * Find the zone with the most free pages, recheck the watermarks and
+ * then directly allocate the ram. We don't want prefetch to use
+ * __alloc_pages and go calling on reclaim.
+ */
+static struct page *prefetch_get_page(void)
+{
+	struct zone *zone = NULL, *z;
+	struct page *page = NULL;
+	long most_free = 0;
+
+	for_each_zone(z) {
+		long free;
+
+		if (z->present_pages == 0)
+			continue;
+
+		free = z->free_pages;
+
+		/* Check yet again we are above watermarks, by now likely */
+		if (unlikely(free < z->pages_high * 3))
+			goto out;
+
+		/* We don't prefetch into DMA */
+		if (zone_idx(z) == ZONE_DMA)
+			continue;
+
+		/* Select the zone with the most free ram */
+		if (free > most_free) {
+			most_free = free;
+			zone = z;
+		}
+	}
+
+	if (zone == NULL)
+		goto out;
+
+	page = buffered_rmqueue(zone, 0, GFP_HIGHUSER);
+	if (likely(page)) {
+		struct zonelist *zonelist;
+
+		zonelist = NODE_DATA(numa_node_id())->node_zonelists +
+		(GFP_HIGHUSER & GFP_ZONEMASK);
+
+		zone_statistics(zonelist, zone);
+	}
+out:
+	return page;
+}
+
+/*
+ * This tries to read a swp_entry_t into swap cache for swap prefetching.
+ * Returns 1 on success, 0 on failure, -1 on failure and we should delay
+ * further prefetching.
+ */
+static int trickle_swap_cache_async(swp_entry_t entry)
+{
+	struct page *page = NULL;
+	int ret = 0;
+
+	/* Entry may already exist */
+	if (unlikely(!read_trylock(swapped.rwlock))) {
+		ret = -1;
+		goto out;
+	}
+	page = radix_tree_lookup(&swapper_space.page_tree, entry.val);
+	read_unlock(swapped.rwlock);
+	if (page) {
+		remove_from_swapped_list(entry.val);
+		goto out;
+	}
+
+	/* Get a new page to read from swap */
+	page = prefetch_get_page();
+	if (unlikely(!page)) {
+		ret = -1;
+		goto out;
+	}
+
+	if (add_to_swap_cache(page, entry)) {
+		/* Failed to add to swap cache */
+		page_cache_release(page);
+		goto out;
+	}
+
+	lru_cache_add(page);
+	if (unlikely(swap_readpage(NULL, page))) {
+		ret = -1;
+		goto out;
+	}
+	ret = 1;
+out:
+	return ret;
+}
+
+/*
+ * We want to be absolutely certain it's ok to start prefetching.
+ */
+static int prefetch_suitable(void)
+{
+	struct page_state ps;
+	unsigned long pending_writes, limit;
+	struct zone *z;
+	int ret = 0;
+
+	/* Purposefully racy and might return false positive which is ok */
+	if (__test_and_clear_bit(0, &swapped.busy))
+		goto out;
+
+	/*
+	 * Have some hysteresis between where page reclaiming and prefetching
+	 * will occur to prevent ping-ponging between them.
+	 */
+	for_each_zone(z) {
+		if (z->present_pages == 0)
+			continue;
+		if (z->pages_high * 3 > z->free_pages)
+			goto out;
+	}
+
+	get_page_state(&ps);
+
+	/* We shouldn't prefetch when we are doing writeback */
+	if (ps.nr_writeback)
+		goto out;
+
+	/* Delay prefetching if we have significant amounts of dirty data */
+	pending_writes = ps.nr_dirty + ps.nr_unstable;
+	if (pending_writes > SWAP_CLUSTER_MAX)
+		goto out;
+
+	/* >2/3 of the ram is mapped, we need some free for pagecache */
+	limit = ps.nr_mapped + ps.nr_slab + pending_writes;
+	if (limit > mapped_limit)
+		goto out;
+
+	/*
+	 * Add swapcache to limit as well, but check this last since it needs
+	 * locking
+	 */
+	if (unlikely(!read_trylock(&swapper_space.tree_lock)))
+		goto out;
+	limit += total_swapcache_pages;
+	read_unlock(&swapper_space.tree_lock);
+	if (limit > mapped_limit)
+		goto out;
+
+	/* Survived all that? Hooray we can prefetch! */
+	ret = 1;
+out:
+	return ret;
+}
+
+/*
+ * trickle_swap is the main function that initiates the swap prefetching. It
+ * first checks to see if the busy flag is set, and does not prefetch if it
+ * is, as the flag implied we are low on memory or swapping in currently.
+ * Otherwise it runs till SWAP_CLUSTER_MAX is prefetched. This function
+ * returns 1 if it succeeds in a cycle of prefetching, 0 if it is interrupted
+ * or -1 if there is nothing left to prefetch.
+ */
+static int trickle_swap(void)
+{
+	int ret = 0, pages = 0;
+	struct swapped_entry_t *entry;
+
+	while (pages < SWAP_CLUSTER_MAX) {
+		int got_page;
+
+		if (!prefetch_suitable())
+			goto out;
+		/* Lock is held? We must be busy elsewhere */
+		if (unlikely(!spin_trylock(&swapped.lock)))
+			goto out;
+		if (list_empty(&swapped.list)) {
+			ret = -1;
+			goto out_unlock;
+		}
+		entry = list_entry(swapped.list.next,
+			struct swapped_entry_t, swapped_list);
+		spin_unlock(&swapped.lock);
+
+		got_page = trickle_swap_cache_async(entry->swp_entry);
+		if (unlikely(got_page == -1))
+			goto out;
+		pages += got_page;
+	}
+	return 1;
+
+out_unlock:
+	spin_unlock(&swapped.lock);
+out:
+	return ret;
+}
+
+static int kprefetchd(void *data)
+{
+	DEFINE_WAIT(wait);
+
+	daemonize("kprefetchd");
+	set_user_nice(current, 19);
+
+	for ( ; ; ) {
+		int prefetched;
+
+		try_to_freeze();
+		prepare_to_wait(&kprefetchd_wait, &wait, TASK_INTERRUPTIBLE);
+		schedule();
+		finish_wait(&kprefetchd_wait, &wait);
+
+		/* If trickle_swap() returns -1 the timer is not reset */
+		if (!(prefetched = trickle_swap()))
+			delay_prefetch_timer();
+		else if (prefetched == 1)
+			reset_prefetch_timer();
+	}
+	return 0;
+}
+
+/*
+ * Wake up kprefetchd. It will reset the timer itself appropriately so no
+ * need to do it here
+ */
+static void prefetch_wakeup(unsigned long data)
+{
+	if (waitqueue_active(&kprefetchd_wait))
+		wake_up_interruptible(&kprefetchd_wait);
+}
+
+static int __init kprefetchd_init(void)
+{
+	/*
+	 * Prepare the prefetch timer. It is inactive until entries are placed
+	 * on the swapped_list
+	 */
+	init_timer(&prefetch_timer);
+	prefetch_timer.data = 0;
+	prefetch_timer.function = prefetch_wakeup;
+
+	kernel_thread(kprefetchd, NULL, CLONE_KERNEL);
+
+	return 0;
+}
+
+module_init(kprefetchd_init)
Index: linux-2.6.13-sp/mm/swap_state.c
===================================================================
--- linux-2.6.13-sp.orig/mm/swap_state.c	2005-09-26 15:52:30.000000000 +1000
+++ linux-2.6.13-sp/mm/swap_state.c	2005-09-30 00:51:37.000000000 +1000
@@ -80,6 +80,7 @@ static int __add_to_swap_cache(struct pa
 		error = radix_tree_insert(&swapper_space.page_tree,
 						entry.val, page);
 		if (!error) {
+			remove_from_swapped_list(entry.val);
 			page_cache_get(page);
 			SetPageLocked(page);
 			SetPageSwapCache(page);
@@ -93,11 +94,12 @@ static int __add_to_swap_cache(struct pa
 	return error;
 }
 
-static int add_to_swap_cache(struct page *page, swp_entry_t entry)
+int add_to_swap_cache(struct page *page, swp_entry_t entry)
 {
 	int error;
 
 	if (!swap_duplicate(entry)) {
+		remove_from_swapped_list(entry.val);
 		INC_CACHE_INFO(noent_race);
 		return -ENOENT;
 	}
@@ -145,6 +147,9 @@ int add_to_swap(struct page * page)
 	swp_entry_t entry;
 	int err;
 
+	/* Swap prefetching is delayed if we're swapping pages */
+	delay_prefetch();
+
 	if (!PageLocked(page))
 		BUG();
 
@@ -325,6 +330,9 @@ struct page *read_swap_cache_async(swp_e
 	struct page *found_page, *new_page = NULL;
 	int err;
 
+	/* Swap prefetching is delayed if we're already reading from swap */
+	delay_prefetch();
+
 	do {
 		/*
 		 * First check the swap cache.  Since this is normally
Index: linux-2.6.13-sp/mm/vmscan.c
===================================================================
--- linux-2.6.13-sp.orig/mm/vmscan.c	2005-09-26 15:52:30.000000000 +1000
+++ linux-2.6.13-sp/mm/vmscan.c	2005-09-26 15:52:52.000000000 +1000
@@ -519,6 +519,7 @@ static int shrink_list(struct list_head 
 #ifdef CONFIG_SWAP
 		if (PageSwapCache(page)) {
 			swp_entry_t swap = { .val = page->private };
+			add_to_swapped_list(swap.val);
 			__delete_from_swap_cache(page);
 			write_unlock_irq(&mapping->tree_lock);
 			swap_free(swap);
@@ -929,6 +930,8 @@ int try_to_free_pages(struct zone **zone
 	unsigned long lru_pages = 0;
 	int i;
 
+	delay_prefetch();
+
 	sc.gfp_mask = gfp_mask;
 	sc.may_writepage = 0;
 	sc.may_swap = 1;
@@ -1275,6 +1278,8 @@ int shrink_all_memory(int nr_pages)
 		.reclaimed_slab = 0,
 	};
 
+	delay_prefetch();
+
 	current->reclaim_state = &reclaim_state;
 	for_each_pgdat(pgdat) {
 		int freed;

--Boundary-00=_VUAPDnEB73NGvuJ--
