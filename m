Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964779AbVIKOy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbVIKOy0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 10:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbVIKOy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 10:54:26 -0400
Received: from mail28.syd.optusnet.com.au ([211.29.133.169]:60369 "EHLO
	mail28.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932395AbVIKOyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 10:54:25 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] vm: swap prefetch-5
Date: Mon, 12 Sep 2005 00:54:18 +1000
User-Agent: KMail/1.8.2
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_aUEJDlpiMFio12h"
Message-Id: <200509120054.18519.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_aUEJDlpiMFio12h
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Here is an updated patch to perform swap prefetching. This version is even 
more conservative at deciding when to start prefetching, not doing it if 
there is any significant amount of dirty ram. Other changes are minor 
cleanups and comments.

Latest patch is available here:

http://ck.kolivas.org/patches/swap-prefetch/

and attached below for 2.6.13.

This version is effectively what is included in 2.6.13-ck3

Cheers,
Con

--Boundary-00=_aUEJDlpiMFio12h
Content-Type: text/x-diff;
  charset="us-ascii";
  name="vm-swap_prefetch-5.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="vm-swap_prefetch-5.patch"

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
least 4* pages_high free and if it succeeds that will start prefetching
pages from swap. The pages are prefetched in 128kb groups every 1 second until
the vm is busy for the tests above, the watermarks fail to detect adequate
free ram or the list is emptied. The pages are copied to swap cache and kept
on backing store. This allows pressure on either physical ram or swap to
readily find free pages without further I/O.

In testing on modern pc hardware this results in wall-clock time activation of
the firefox browser to speed up 5 fold after a worst case complete swap-out
of the browser on an static web page.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

 include/linux/fs.h   |    2
 include/linux/swap.h |   27 ++++
 init/Kconfig         |   19 +++
 mm/Makefile          |    1
 mm/page_alloc.c      |   10 +
 mm/swap.c            |    3
 mm/swap_prefetch.c   |  317 +++++++++++++++++++++++++++++++++++++++++++++++++++
 mm/swap_state.c      |   12 +
 mm/vmscan.c          |    5
 9 files changed, 393 insertions(+), 3 deletions(-)

Index: linux-2.6.13-sp/include/linux/fs.h
===================================================================
--- linux-2.6.13-sp.orig/include/linux/fs.h	2005-09-12 00:19:33.000000000 +1000
+++ linux-2.6.13-sp/include/linux/fs.h	2005-09-12 00:19:52.000000000 +1000
@@ -340,6 +340,8 @@ struct address_space {
 	struct inode		*host;		/* owner: inode, block_device */
 	struct radix_tree_root	page_tree;	/* radix tree of all pages */
 	rwlock_t		tree_lock;	/* and rwlock protecting it */
+	struct radix_tree_root	swap_tree;	/* radix tree of swapped pages */
+	struct list_head	swapped_pages;	/* list of swapped pages */
 	unsigned int		i_mmap_writable;/* count VM_SHARED mappings */
 	struct prio_tree_root	i_mmap;		/* tree of private and shared mappings */
 	struct list_head	i_mmap_nonlinear;/*list VM_NONLINEAR mappings */
Index: linux-2.6.13-sp/include/linux/swap.h
===================================================================
--- linux-2.6.13-sp.orig/include/linux/swap.h	2005-09-12 00:19:33.000000000 +1000
+++ linux-2.6.13-sp/include/linux/swap.h	2005-09-12 00:19:54.000000000 +1000
@@ -185,6 +185,32 @@ extern int shmem_unuse(swp_entry_t entry
 
 extern void swap_unplug_io_fn(struct backing_dev_info *, struct page *);
 
+#ifdef CONFIG_SWAP_PREFETCH
+/*	mm/swap_prefetch.c */
+extern void prepare_prefetch(void);
+extern void add_to_swapped_list(unsigned long index);
+extern void remove_from_swapped_list(unsigned long index);
+extern void delay_prefetch(void);
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
@@ -206,6 +232,7 @@ extern void free_pages_and_swap_cache(st
 extern struct page * lookup_swap_cache(swp_entry_t);
 extern struct page * read_swap_cache_async(swp_entry_t, struct vm_area_struct *vma,
 					   unsigned long addr);
+extern int add_to_swap_cache(struct page *page, swp_entry_t entry);
 /* linux/mm/swapfile.c */
 extern long total_swap_pages;
 extern unsigned int nr_swapfiles;
Index: linux-2.6.13-sp/init/Kconfig
===================================================================
--- linux-2.6.13-sp.orig/init/Kconfig	2005-09-12 00:19:33.000000000 +1000
+++ linux-2.6.13-sp/init/Kconfig	2005-09-12 00:19:54.000000000 +1000
@@ -87,6 +87,25 @@ config SWAP
 	  used to provide more virtual memory than the actual RAM present
 	  in your computer.  If unsure say Y.
 
+config SWAP_PREFETCH
+	bool "Support for prefetching swapped memory"
+	depends on SWAP
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
+	  to life faster.
+	  
+	  Desktop users will most likely want to say Y.
+
 config SYSVIPC
 	bool "System V IPC"
 	depends on MMU
Index: linux-2.6.13-sp/mm/Makefile
===================================================================
--- linux-2.6.13-sp.orig/mm/Makefile	2005-09-12 00:19:33.000000000 +1000
+++ linux-2.6.13-sp/mm/Makefile	2005-09-12 00:19:52.000000000 +1000
@@ -13,6 +13,7 @@ obj-y			:= bootmem.o filemap.o mempool.o
 			   prio_tree.o $(mmu-y)
 
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o thrash.o
+obj-$(CONFIG_SWAP_PREFETCH) += swap_prefetch.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
 obj-$(CONFIG_NUMA) 	+= mempolicy.o
 obj-$(CONFIG_SPARSEMEM)	+= sparse.o
Index: linux-2.6.13-sp/mm/page_alloc.c
===================================================================
--- linux-2.6.13-sp.orig/mm/page_alloc.c	2005-09-12 00:19:33.000000000 +1000
+++ linux-2.6.13-sp/mm/page_alloc.c	2005-09-12 00:19:52.000000000 +1000
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
--- linux-2.6.13-sp.orig/mm/swap.c	2005-09-12 00:19:33.000000000 +1000
+++ linux-2.6.13-sp/mm/swap.c	2005-09-12 00:19:52.000000000 +1000
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
--- linux-2.6.13-sp.orig/mm/swap_prefetch.c	2005-01-12 16:19:45.000000000 +1100
+++ linux-2.6.13-sp/mm/swap_prefetch.c	2005-09-12 00:19:54.000000000 +1000
@@ -0,0 +1,317 @@
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
+	spinlock_t		lock;
+	unsigned int		count;
+	unsigned int		maxcount;
+	kmem_cache_t		*cache;
+	struct list_head	list;
+	int 			busy;
+	spinlock_t		busylock;
+};
+
+struct swapped_entry_t {
+	swp_entry_t		swp_entry;
+	struct list_head	swapped_list;
+};
+
+static struct swapped_root_t swapped_root = {
+	.count = 0,
+	.list  = LIST_HEAD_INIT(swapped_root.list),
+};
+
+static struct timer_list prefetch_timer;
+
+static DECLARE_WAIT_QUEUE_HEAD(kprefetchd_wait);
+
+static unsigned long total_high = 0;
+
+/*
+ * Create kmem cache for swapped entries
+ */
+void prepare_prefetch(void)
+{
+	struct zone *z;
+
+	swapped_root.cache = kmem_cache_create("swapped_entry",
+		sizeof(struct swapped_entry_t), 0, 0, NULL, NULL);
+	if (unlikely(!swapped_root.cache))
+		panic("prepare_prefetch(): cannot create swapped_entry SLAB cache");
+
+	/*
+	 * Set max count of swapped entries
+	 */
+	swapped_root.maxcount = nr_free_pagecache_pages();
+	spin_lock_init(&swapped_root.lock);
+	spin_lock_init(&swapped_root.busylock);
+
+	for_each_zone(z)
+		total_high += z->pages_high;
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
+ * trickle_swap and wait another PREFETCH_DELAY
+ */
+void delay_prefetch(void)
+{
+	spin_lock(&swapped_root.busylock);
+	swapped_root.busy = 1;
+	spin_unlock(&swapped_root.busylock);
+}
+
+void add_to_swapped_list(unsigned long index)
+{
+	struct swapped_entry_t *entry;
+	struct address_space *mapping = &swapper_space;
+	int error;
+
+	spin_lock(&swapped_root.lock);
+
+	if (swapped_root.count >= swapped_root.maxcount) {
+		entry = list_entry(swapped_root.list.next,
+				struct swapped_entry_t, swapped_list);
+		radix_tree_delete(&mapping->swap_tree, entry->swp_entry.val);
+		list_del_init(&entry->swapped_list);
+		swapped_root.count--;
+	} else {
+		entry = kmem_cache_alloc(swapped_root.cache, GFP_ATOMIC);
+		if (unlikely(!entry)) {
+			/* bad, can't allocate more mem */
+			delay_prefetch();
+			goto out_locked;
+		}
+	}
+
+	entry->swp_entry.val = index;
+
+	error = radix_tree_preload(GFP_ATOMIC);
+	if (likely(!error)) {
+		error = radix_tree_insert(&mapping->swap_tree, index, entry);
+		if (likely(!error)) {
+			/*
+			 * If this is the first entry the timer needs to be
+			 * (re)started
+			 */
+			if (list_empty(&swapped_root.list))
+				delay_prefetch_timer();
+			list_add(&entry->swapped_list, &swapped_root.list);
+			swapped_root.count++;
+		}
+		radix_tree_preload_end();
+	} else
+		kmem_cache_free(swapped_root.cache, entry);
+
+out_locked:
+	spin_unlock(&swapped_root.lock);
+}
+
+void remove_from_swapped_list(unsigned long index)
+{
+	struct address_space *mapping = &swapper_space;
+	struct swapped_entry_t *entry;
+
+	spin_lock(&swapped_root.lock);
+	entry = radix_tree_delete(&mapping->swap_tree, index);
+	if (entry) {
+		list_del_init(&entry->swapped_list);
+		swapped_root.count--;
+		kmem_cache_free(swapped_root.cache, entry);
+	}
+	spin_unlock(&swapped_root.lock);
+}
+
+/*
+ * This tries to read a swp_entry_t into swap cache for swap prefetching.
+ */
+static int trickle_swap_cache_async(swp_entry_t entry)
+{
+	struct page *found_page, *new_page = NULL;
+	struct address_space *mapping = &swapper_space;
+
+	/* May already exist, check it as cheaply as possible */
+	read_lock_irq(&mapping->tree_lock);
+	found_page = radix_tree_lookup(&mapping->page_tree, entry.val);
+	read_unlock_irq(&mapping->tree_lock);
+	if (found_page) {
+		remove_from_swapped_list(entry.val);
+		goto out;
+	}
+
+	/* Get a new page to read from swap */
+	new_page = alloc_page_vma(GFP_HIGHUSER, NULL, 0);
+	if (unlikely(!new_page)) {
+		/* Bad - out of memory */
+		delay_prefetch();
+		goto out;
+	}
+
+	if (add_to_swap_cache(new_page, entry)) {
+		/* Failed to add to swap cache */
+		page_cache_release(new_page);
+		goto out;
+	}
+
+	lru_cache_add_active(new_page);
+	swap_readpage(NULL, new_page);
+	return 1;
+out:
+	return 0;
+}
+
+static int test_clear_busy(void)
+{
+	int ret;
+
+	spin_lock(&swapped_root.busylock);
+	ret = swapped_root.busy;
+	swapped_root.busy = 0;
+	spin_unlock(&swapped_root.busylock);
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
+		if (test_clear_busy())
+			goto out;
+		spin_lock(&swapped_root.lock);
+		if (list_empty(&swapped_root.list)) {
+			ret = -1;
+			goto out_unlock;
+		}
+		entry = list_entry(swapped_root.list.next,
+			struct swapped_entry_t, swapped_list);
+		spin_unlock(&swapped_root.lock);
+
+		if (trickle_swap_cache_async(entry->swp_entry))
+			pages++;
+	}
+	ret = 1;
+	goto out;
+
+out_unlock:
+	spin_unlock(&swapped_root.lock);
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
+static void prefetch_wakeup(unsigned long data)
+{
+	unsigned long pending_writes, total_free = nr_free_pages();
+
+	/*
+	 * Have some hysteresis between where page reclaiming and prefetching
+	 * will occur to prevent ping-ponging between them.
+	 */
+	if (total_free < total_high * 4)
+		goto out_delay;
+
+	/* We shouldn't prefetch when we are doing writeback */
+	if (read_page_state(nr_writeback))
+		goto out_delay;
+
+	/* If we have dirty data, delay according to how much */
+	pending_writes = read_page_state(nr_dirty) +
+		read_page_state(nr_unstable);
+	if (pending_writes > SWAP_CLUSTER_MAX) {
+		if (pending_writes + total_high > total_free)
+			goto out_delay;
+		reset_prefetch_timer();
+		goto out;
+	}
+
+	/*
+	 * Ok, we passed all the checks, wake up kprefetchd. It will reset the
+	 * timer itself appropriately so no need to do it here
+	 */
+	if (waitqueue_active(&kprefetchd_wait))
+		wake_up_interruptible(&kprefetchd_wait);
+	goto out;
+
+out_delay:
+	delay_prefetch_timer();
+out:
+	return;
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
--- linux-2.6.13-sp.orig/mm/swap_state.c	2005-09-12 00:19:33.000000000 +1000
+++ linux-2.6.13-sp/mm/swap_state.c	2005-09-12 00:19:54.000000000 +1000
@@ -36,6 +36,8 @@ static struct backing_dev_info swap_back
 struct address_space swapper_space = {
 	.page_tree	= RADIX_TREE_INIT(GFP_ATOMIC|__GFP_NOWARN),
 	.tree_lock	= RW_LOCK_UNLOCKED,
+	.swap_tree	= RADIX_TREE_INIT(GFP_ATOMIC),
+	.swapped_pages	= LIST_HEAD_INIT(swapper_space.swapped_pages),
 	.a_ops		= &swap_aops,
 	.i_mmap_nonlinear = LIST_HEAD_INIT(swapper_space.i_mmap_nonlinear),
 	.backing_dev_info = &swap_backing_dev_info,
@@ -80,6 +82,7 @@ static int __add_to_swap_cache(struct pa
 		error = radix_tree_insert(&swapper_space.page_tree,
 						entry.val, page);
 		if (!error) {
+			remove_from_swapped_list(entry.val);
 			page_cache_get(page);
 			SetPageLocked(page);
 			SetPageSwapCache(page);
@@ -93,11 +96,12 @@ static int __add_to_swap_cache(struct pa
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
@@ -145,6 +149,9 @@ int add_to_swap(struct page * page)
 	swp_entry_t entry;
 	int err;
 
+	/* Swap prefetching is delayed if we're swapping pages */
+	delay_prefetch();
+
 	if (!PageLocked(page))
 		BUG();
 
@@ -325,6 +332,9 @@ struct page *read_swap_cache_async(swp_e
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
--- linux-2.6.13-sp.orig/mm/vmscan.c	2005-09-12 00:19:33.000000000 +1000
+++ linux-2.6.13-sp/mm/vmscan.c	2005-09-12 00:19:54.000000000 +1000
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

--Boundary-00=_aUEJDlpiMFio12h--
