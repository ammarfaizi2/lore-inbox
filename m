Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbVJJOXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbVJJOXR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 10:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbVJJOXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 10:23:17 -0400
Received: from mail10.syd.optusnet.com.au ([211.29.132.191]:54758 "EHLO
	mail10.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750754AbVJJOXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 10:23:17 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm - implement swap prefetching
Date: Tue, 11 Oct 2005 00:23:01 +1000
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_GlnSDeHktBvFNhd"
Message-Id: <200510110023.02426.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_GlnSDeHktBvFNhd
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Andrew could you please consider this for -mm

Small changes to the style after suggestions from Pekka Enberg (thanks), and 
changed the default size of prefetch to gently increase with size of ram. 
Functionally this is the same code as vm-swap_prefetch-15 and I believe ready 
for a wider audience.

Cheers,
Con
---




--Boundary-00=_GlnSDeHktBvFNhd
Content-Type: text/x-diff;
  charset="us-ascii";
  name="vm-swap_prefetch-16.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="vm-swap_prefetch-16.patch"

This patch implements swap prefetching when the vm is relatively idle and
there is free ram available. The code is based on some early work by Thomas
Schlichter.

This stores a list of swapped entries in a list ordered most recently used
and a radix tree. It generates a low priority kernel thread running at nice 19
to do the prefetching at a later stage.

Once pages have been added to the swapped list, a timer is started, testing
for conditions suitable to prefetch swap pages every 5 seconds. Suitable
conditions are defined as lack of swapping out or in any pages, and no
watermark tests failing. Significant amounts of dirtied ram and changes in
free ram representing disk writes or reads also prevent prefetching.

It then checks that we have spare ram looking for at least 3* pages_high free
per zone and if it succeeds that will prefetch pages from swap. The pages are
prefetched in 128kb groups every 1 second until the vm is busy for the tests
above, the watermarks fail to detect adequate free ram or the list is emptied.
The pages are copied to swap cache and kept on backing store. This allows
pressure on either physical ram or swap to readily find free pages without
further I/O.

The amount prefetched in each group is configurable via the tunable in
/proc/sys/vm/swap_prefetch. This is set to a value based on memory size. When
laptop_mode is enabled it prefetches in ten times larger blocks to minimise
the time spent reading.

In testing on modern pc hardware this results in wall-clock time activation of
the firefox browser to speed up 5 fold after a worst case complete swap-out
of the browser on an static web page.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

 Documentation/sysctl/vm.txt |   12 +
 include/linux/swap.h        |   33 +++
 include/linux/sysctl.h      |    1
 init/Kconfig                |   21 +
 kernel/sysctl.c             |   12 +
 mm/Makefile                 |    1
 mm/page_alloc.c             |   14 -
 mm/swap.c                   |    3
 mm/swap_prefetch.c          |  467 ++++++++++++++++++++++++++++++++++++++++++++
 mm/swap_state.c             |   10
 mm/vmscan.c                 |    5
 11 files changed, 574 insertions(+), 5 deletions(-)

Index: linux-2.6.14-rc3/Documentation/sysctl/vm.txt
===================================================================
--- linux-2.6.14-rc3.orig/Documentation/sysctl/vm.txt	2004-12-25 10:14:46.000000000 +1100
+++ linux-2.6.14-rc3/Documentation/sysctl/vm.txt	2005-10-10 21:57:53.000000000 +1000
@@ -26,6 +26,7 @@ Currently, these files are in /proc/sys/
 - min_free_kbytes
 - laptop_mode
 - block_dump
+- swap_prefetch
 
 ==============================================================
 
@@ -102,3 +103,14 @@ This is used to force the Linux VM to ke
 of kilobytes free.  The VM uses this number to compute a pages_min
 value for each lowmem zone in the system.  Each lowmem zone gets 
 a number of reserved free pages based proportionally on its size.
+
+==============================================================
+
+swap_prefetch
+
+This is the amount of data prefetched per prefetching interval when
+swap prefetching is compiled in. The value means multiples of 128K,
+except when laptop_mode is enabled and then it is ten times larger.
+Setting it to 0 disables prefetching entirely.
+
+The default value is dependant on ramsize.
Index: linux-2.6.14-rc3/include/linux/swap.h
===================================================================
--- linux-2.6.14-rc3.orig/include/linux/swap.h	2005-10-08 20:16:37.000000000 +1000
+++ linux-2.6.14-rc3/include/linux/swap.h	2005-10-08 21:23:35.000000000 +1000
@@ -183,6 +183,38 @@ extern int shmem_unuse(swp_entry_t entry
 
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
+extern int swap_prefetch;
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
@@ -204,6 +236,7 @@ extern void free_pages_and_swap_cache(st
 extern struct page * lookup_swap_cache(swp_entry_t);
 extern struct page * read_swap_cache_async(swp_entry_t, struct vm_area_struct *vma,
 					   unsigned long addr);
+extern int add_to_swap_cache(struct page *page, swp_entry_t entry);
 /* linux/mm/swapfile.c */
 extern long total_swap_pages;
 extern unsigned int nr_swapfiles;
Index: linux-2.6.14-rc3/include/linux/sysctl.h
===================================================================
--- linux-2.6.14-rc3.orig/include/linux/sysctl.h	2005-10-08 20:16:37.000000000 +1000
+++ linux-2.6.14-rc3/include/linux/sysctl.h	2005-10-08 21:23:35.000000000 +1000
@@ -180,6 +180,7 @@ enum
 	VM_VFS_CACHE_PRESSURE=26, /* dcache/icache reclaim pressure */
 	VM_LEGACY_VA_LAYOUT=27, /* legacy/compatibility virtual address space layout */
 	VM_SWAP_TOKEN_TIMEOUT=28, /* default time for token time out */
+	VM_SWAP_PREFETCH=29,	/* int: amount to swap prefetch */
 };
 
 
Index: linux-2.6.14-rc3/init/Kconfig
===================================================================
--- linux-2.6.14-rc3.orig/init/Kconfig	2005-10-08 20:16:37.000000000 +1000
+++ linux-2.6.14-rc3/init/Kconfig	2005-10-08 21:23:35.000000000 +1000
@@ -103,6 +103,27 @@ config SWAP
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
+	  to life faster. Note that your swap usage will appear to increase
+	  but these are cached pages, can be dropped freely by the vm, and it
+	  should stabilise around 50% swap usage.
+	  
+	  Desktop users will most likely want to say Y.
+
 config SYSVIPC
 	bool "System V IPC"
 	depends on MMU
Index: linux-2.6.14-rc3/kernel/sysctl.c
===================================================================
--- linux-2.6.14-rc3.orig/kernel/sysctl.c	2005-10-08 20:16:37.000000000 +1000
+++ linux-2.6.14-rc3/kernel/sysctl.c	2005-10-08 21:23:35.000000000 +1000
@@ -848,6 +848,18 @@ static ctl_table vm_table[] = {
 		.proc_handler	= &proc_dointvec_jiffies,
 		.strategy	= &sysctl_jiffies,
 	},
+#ifdef CONFIG_SWAP_PREFETCH
+	{
+		.ctl_name	= VM_SWAP_PREFETCH,
+		.procname	= "swap_prefetch",
+		.data		= &swap_prefetch,
+		.maxlen		= sizeof(swap_prefetch),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &zero,
+	},
+#endif
 #endif
 	{ .ctl_name = 0 }
 };
Index: linux-2.6.14-rc3/mm/Makefile
===================================================================
--- linux-2.6.14-rc3.orig/mm/Makefile	2005-08-29 13:31:26.000000000 +1000
+++ linux-2.6.14-rc3/mm/Makefile	2005-10-08 21:23:35.000000000 +1000
@@ -13,6 +13,7 @@ obj-y			:= bootmem.o filemap.o mempool.o
 			   prio_tree.o $(mmu-y)
 
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o thrash.o
+obj-$(CONFIG_SWAP_PREFETCH) += swap_prefetch.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
 obj-$(CONFIG_NUMA) 	+= mempolicy.o
 obj-$(CONFIG_SPARSEMEM)	+= sparse.o
Index: linux-2.6.14-rc3/mm/page_alloc.c
===================================================================
--- linux-2.6.14-rc3.orig/mm/page_alloc.c	2005-10-08 20:16:38.000000000 +1000
+++ linux-2.6.14-rc3/mm/page_alloc.c	2005-10-08 21:23:35.000000000 +1000
@@ -608,7 +608,7 @@ void drain_local_pages(void)
 }
 #endif /* CONFIG_PM */
 
-static void zone_statistics(struct zonelist *zonelist, struct zone *z)
+void zone_statistics(struct zonelist *zonelist, struct zone *z)
 {
 #ifdef CONFIG_NUMA
 	unsigned long flags;
@@ -685,7 +685,7 @@ static inline void prep_zero_page(struct
  * we cheat by calling it from here, in the order > 0 path.  Saves a branch
  * or two.
  */
-static struct page *
+struct page *
 buffered_rmqueue(struct zone *zone, int order, unsigned int __nocast gfp_flags)
 {
 	unsigned long flags;
@@ -746,7 +746,7 @@ int zone_watermark_ok(struct zone *z, in
 		min -= min / 4;
 
 	if (free_pages <= min + z->lowmem_reserve[classzone_idx])
-		return 0;
+		goto out_failed;
 	for (o = 0; o < order; o++) {
 		/* At the next order, this order's pages become unavailable */
 		free_pages -= z->free_area[o].nr_free << o;
@@ -755,9 +755,15 @@ int zone_watermark_ok(struct zone *z, in
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
Index: linux-2.6.14-rc3/mm/swap.c
===================================================================
--- linux-2.6.14-rc3.orig/mm/swap.c	2004-08-15 14:08:19.000000000 +1000
+++ linux-2.6.14-rc3/mm/swap.c	2005-10-08 21:23:35.000000000 +1000
@@ -481,5 +481,8 @@ void __init swap_setup(void)
 	 * Right now other parts of the system means that we
 	 * _really_ don't want to cluster much more
 	 */
+
+	prepare_prefetch();
+
 	hotcpu_notifier(cpu_swap_callback, 0);
 }
Index: linux-2.6.14-rc3/mm/swap_prefetch.c
===================================================================
--- linux-2.6.14-rc3.orig/mm/swap_prefetch.c	2005-10-09 20:59:45.507423480 +1000
+++ linux-2.6.14-rc3/mm/swap_prefetch.c	2005-10-10 21:57:53.000000000 +1000
@@ -0,0 +1,467 @@
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
+#include <linux/syscalls.h>
+#include <linux/ioprio.h>
+#include <linux/writeback.h>
+
+/* Time to delay prefetching if vm is busy or prefetching unsuccessful */
+#define PREFETCH_DELAY	(HZ * 5)
+/* Time between attempting prefetching when vm is idle */
+#define PREFETCH_INTERVAL (HZ)
+
+/* sysctl - how many SWAP_CLUSTER_MAX pages to prefetch at a time */
+int swap_prefetch = 1;
+
+struct swapped_root {
+	unsigned long		busy;		/* vm busy */
+	spinlock_t		lock;		/* protects all data */
+	struct list_head	list;		/* MRU list of swapped pages */
+	struct radix_tree_root	swap_tree;	/* Lookup tree of pages */
+	unsigned int		count;		/* Number of entries */
+	unsigned int		maxcount;	/* Maximum entries allowed */
+	kmem_cache_t		*cache;
+};
+
+struct swapped_entry {
+	swp_entry_t		swp_entry;
+	struct list_head	swapped_list;
+};
+
+static struct swapped_root swapped = {
+	.busy 		= 0,
+	.list  		= LIST_HEAD_INIT(swapped.list),
+	.swap_tree	= RADIX_TREE_INIT(GFP_ATOMIC),
+	.count 		= 0,
+};
+
+static struct timer_list prefetch_timer;
+
+static DECLARE_WAIT_QUEUE_HEAD(kprefetchd_wait);
+
+static unsigned long mapped_limit;	/* Max mapped we will prefetch to */
+static unsigned long last_free = 0;	/* Last total free pages */
+static unsigned long temp_free = 0;
+
+/*
+ * Create kmem cache for swapped entries
+ */
+void __init prepare_prefetch(void)
+{
+	long mem = nr_free_pagecache_pages();
+
+	swapped.cache = kmem_cache_create("swapped_entry",
+		sizeof(struct swapped_entry), 0, 0, NULL, NULL);
+	if (unlikely(!swapped.cache))
+		panic("prepare_prefetch(): cannot create swapped_entry SLAB cache");
+
+	/* Set max number of entries to size of physical ram */
+	swapped.maxcount = mem;
+	/* Set maximum amount of mapped pages to prefetch to 2/3 ram */
+	mapped_limit = mem / 3 * 2;
+
+	/* Set initial swap_prefetch value according to memory size */
+	mem /= SWAP_CLUSTER_MAX * 1000;
+	while ((mem >>= 1))
+		swap_prefetch++;
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
+	struct swapped_entry *entry;
+	int error;
+
+	if (unlikely(!spin_trylock(&swapped.lock)))
+		goto out;
+
+	if (swapped.count >= swapped.maxcount) {
+		entry = list_entry(swapped.list.next,
+				struct swapped_entry, swapped_list);
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
+	struct swapped_entry *entry;
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
+enum trickle_return {
+	SUCCESS,
+	FAILED,
+	DELAY,
+};
+
+/*
+ * This tries to read a swp_entry_t into swap cache for swap prefetching.
+ * If it returns DELAY we should delay further prefetching.
+ */
+static enum trickle_return trickle_swap_cache_async(swp_entry_t entry)
+{
+	enum trickle_return ret = FAILED;
+	struct page *page = NULL;
+
+	if (unlikely(!read_trylock(&swapper_space.tree_lock))) {
+		ret = DELAY;
+		goto out;
+	}
+	/* Entry may already exist */
+	page = radix_tree_lookup(&swapper_space.page_tree, entry.val);
+	read_unlock(&swapper_space.tree_lock);
+	if (page) {
+		remove_from_swapped_list(entry.val);
+		goto out;
+	}
+
+	/* Get a new page to read from swap */
+	page = prefetch_get_page();
+	if (unlikely(!page)) {
+		ret = DELAY;
+		goto out;
+	}
+
+	if (add_to_swap_cache(page, entry))
+		/* Failed to add to swap cache */
+		goto out_release;
+
+	lru_cache_add(page);
+	if (unlikely(swap_readpage(NULL, page))) {
+		ret = DELAY;
+		goto out_release;
+	}
+
+	ret = SUCCESS;
+out_release:
+	page_cache_release(page);
+out:
+	return ret;
+}
+
+/*
+ * How many pages to prefetch at a time. We prefetch SWAP_CLUSTER_MAX *
+ * swap_prefetch per PREFETCH_INTERVAL, but prefetch ten times as much at a
+ * time in laptop_mode to minimise the time we keep the disk spinning.
+ */
+static inline unsigned long prefetch_pages(void)
+{
+	return (SWAP_CLUSTER_MAX * swap_prefetch * (1 + 9 * laptop_mode));
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
+	temp_free = 0;
+	/*
+	 * Have some hysteresis between where page reclaiming and prefetching
+	 * will occur to prevent ping-ponging between them.
+	 */
+	for_each_zone(z) {
+		unsigned long free;
+
+		if (z->present_pages == 0)
+			continue;
+		free = z->free_pages;
+		if (z->pages_high * 3 > free)
+			goto out;
+		temp_free += free;
+	}
+
+	/*
+	 * We check to see that pages are not being allocated elsewhere
+	 * at any significant rate implying any degree of memory pressure
+	 * (eg during file reads)
+	 */
+	if (last_free) {
+		if (temp_free + SWAP_CLUSTER_MAX + prefetch_pages() <
+			last_free) {
+				last_free = temp_free;
+				goto out;
+		}
+	} else
+		last_free = temp_free;
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
+ * Otherwise it runs till prefetch_pages() are prefetched.
+ */
+static enum trickle_return trickle_swap(void)
+{
+	enum trickle_return ret = DELAY;
+	struct swapped_entry *entry;
+	int pages = 0;
+
+	while (pages < prefetch_pages()) {
+		enum trickle_return got_page;
+
+		if (!prefetch_suitable())
+			goto out;
+		/* Lock is held? We must be busy elsewhere */
+		if (unlikely(!spin_trylock(&swapped.lock)))
+			goto out;
+		if (list_empty(&swapped.list)) {
+			spin_unlock(&swapped.lock);
+			ret = FAILED;
+			goto out;
+		}
+		entry = list_entry(swapped.list.next,
+			struct swapped_entry, swapped_list);
+		spin_unlock(&swapped.lock);
+
+		got_page = trickle_swap_cache_async(entry->swp_entry);
+		switch (got_page) {
+		case FAILED:
+			break;
+		case SUCCESS:
+			pages++;
+			break;
+		case DELAY:
+			goto out;
+		}
+	}
+	ret = SUCCESS;
+
+out:
+	if (pages)
+		lru_add_drain();
+	return ret;
+}
+
+static int kprefetchd(void *data)
+{
+	DEFINE_WAIT(wait);
+
+	daemonize("kprefetchd");
+	set_user_nice(current, 19);
+	/* Set ioprio to lowest if supported by i/o scheduler */
+	sys_ioprio_set(IOPRIO_WHO_PROCESS, 0, IOPRIO_CLASS_IDLE);
+
+	for ( ; ; ) {
+		enum trickle_return prefetched;
+
+		try_to_freeze();
+		prepare_to_wait(&kprefetchd_wait, &wait, TASK_INTERRUPTIBLE);
+		schedule();
+		finish_wait(&kprefetchd_wait, &wait);
+
+		/* FAILED implies no entries left - the timer is not reset */
+		prefetched = trickle_swap();
+		switch (prefetched) {
+		case SUCCESS:
+			last_free = temp_free;
+			reset_prefetch_timer();
+			break;
+		case DELAY:
+			last_free = 0;
+			delay_prefetch_timer();
+			break;
+		case FAILED:
+			last_free = 0;
+			break;
+		}
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
Index: linux-2.6.14-rc3/mm/swap_state.c
===================================================================
--- linux-2.6.14-rc3.orig/mm/swap_state.c	2005-10-08 20:16:38.000000000 +1000
+++ linux-2.6.14-rc3/mm/swap_state.c	2005-10-08 21:23:35.000000000 +1000
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
@@ -146,6 +148,9 @@ int add_to_swap(struct page * page)
 	swp_entry_t entry;
 	int err;
 
+	/* Swap prefetching is delayed if we're swapping pages */
+	delay_prefetch();
+
 	if (!PageLocked(page))
 		BUG();
 
@@ -321,6 +326,9 @@ struct page *read_swap_cache_async(swp_e
 	struct page *found_page, *new_page = NULL;
 	int err;
 
+	/* Swap prefetching is delayed if we're already reading from swap */
+	delay_prefetch();
+
 	do {
 		/*
 		 * First check the swap cache.  Since this is normally
Index: linux-2.6.14-rc3/mm/vmscan.c
===================================================================
--- linux-2.6.14-rc3.orig/mm/vmscan.c	2005-10-08 20:16:38.000000000 +1000
+++ linux-2.6.14-rc3/mm/vmscan.c	2005-10-08 21:23:35.000000000 +1000
@@ -519,6 +519,7 @@ static int shrink_list(struct list_head 
 #ifdef CONFIG_SWAP
 		if (PageSwapCache(page)) {
 			swp_entry_t swap = { .val = page->private };
+			add_to_swapped_list(swap.val);
 			__delete_from_swap_cache(page);
 			write_unlock_irq(&mapping->tree_lock);
 			swap_free(swap);
@@ -931,6 +932,8 @@ int try_to_free_pages(struct zone **zone
 	unsigned long lru_pages = 0;
 	int i;
 
+	delay_prefetch();
+
 	sc.gfp_mask = gfp_mask;
 	sc.may_writepage = 0;
 	sc.may_swap = 1;
@@ -1277,6 +1280,8 @@ int shrink_all_memory(int nr_pages)
 		.reclaimed_slab = 0,
 	};
 
+	delay_prefetch();
+
 	current->reclaim_state = &reclaim_state;
 	for_each_pgdat(pgdat) {
 		int freed;

--Boundary-00=_GlnSDeHktBvFNhd--
