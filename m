Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751455AbWBQOhq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbWBQOhq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 09:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbWBQOhq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 09:37:46 -0500
Received: from mail12.syd.optusnet.com.au ([211.29.132.193]:28800 "EHLO
	mail12.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751455AbWBQOhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 09:37:45 -0500
From: Con Kolivas <kernel@kolivas.org>
To: ck@vds.kolivas.org
Subject: [Resend] [PATCH] mm: implement swap prefetching (v26)
Date: Sat, 18 Feb 2006 01:37:25 +1100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200602172235.40019.kernel@kolivas.org> <200602180130.44873.kernel@kolivas.org>
In-Reply-To: <200602180130.44873.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602180137.25801.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 February 2006 01:30, Con Kolivas wrote:
> On Friday 17 February 2006 22:35, Con Kolivas wrote:
> > Added disabling of swap prefetching when laptop_mode is enabled.
> >
> > Comment and function name cleanups etc.
> >
> > Please consider for -mm.
>
> Heh I borked something rotten in this one. There I go again. Please ignore
> this request.

Sorry about that. Sent out the wrong patch. Try again. 

Cheers,
Con
---
This patch implements swap prefetching when the vm is relatively idle and
there is free ram available. The code is based on some preliminary code by
Thomas Schlichter.

This stores a list of swapped entries in a list ordered most recently used
and a radix tree. It generates a low priority kernel thread running at nice 19
to do the prefetching at a later stage.

Once pages have been added to the swapped list, a timer is started, testing
for conditions suitable to prefetch swap pages every 5 seconds. Suitable
conditions are defined as lack of swapping out or in any pages, and no
watermark tests failing. Significant amounts of dirtied ram and changes in
free ram representing disk writes or reads also prevent prefetching.

It then checks that we have spare ram looking for at least 3* pages_high free
per zone and if it succeeds that will prefetch pages from swap into the swap
cache. The pages are added to the tail of the inactive list to preserve LRU
ordering.

Pages are prefetched until the list is empty or the vm is seen as busy
according to the previously described criteria. Node data on numa is stored
with the entries and an appropriate zonelist based on this is used when
allocating ram.

The pages are copied to swap cache and kept on backing store. This allows
pressure on either physical ram or swap to readily find free pages without
further I/O.

Prefetching can be enabled/disabled via the tunable in 
/proc/sys/vm/swap_prefetch initially set to 1 (enabled).

Laptop mode disables swap prefetching.

In testing on modern pc hardware this results in wall-clock time activation of
the firefox browser to speed up 5 fold after a worst case complete swap-out
of the browser on a static web page.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

 Documentation/sysctl/vm.txt |   11 
 include/linux/mm_inline.h   |    7 
 include/linux/swap.h        |   55 ++++
 include/linux/sysctl.h      |    1 
 init/Kconfig                |   22 +
 kernel/sysctl.c             |   10 
 mm/Makefile                 |    1 
 mm/swap.c                   |   42 +++
 mm/swap_prefetch.c          |  488 ++++++++++++++++++++++++++++++++++++++++++++
 mm/swap_state.c             |   10 
 mm/vmscan.c                 |    5 
 11 files changed, 651 insertions(+), 1 deletion(-)

Index: linux-2.6.16-rc3-sp/Documentation/sysctl/vm.txt
===================================================================
--- linux-2.6.16-rc3-sp.orig/Documentation/sysctl/vm.txt	2006-02-18 01:33:36.000000000 +1100
+++ linux-2.6.16-rc3-sp/Documentation/sysctl/vm.txt	2006-02-18 01:33:50.000000000 +1100
@@ -29,6 +29,7 @@ Currently, these files are in /proc/sys/
 - drop-caches
 - zone_reclaim_mode
 - zone_reclaim_interval
+- swap_prefetch
 
 ==============================================================
 
@@ -178,3 +179,13 @@ Time is set in seconds and set by defaul
 Reduce the interval if undesired off node allocations occur. However, too
 frequent scans will have a negative impact onoff node allocation performance.
 
+==============================================================
+
+swap_prefetch
+
+This enables or disables the swap prefetching feature. When the virtual
+memory subsystem has been extremely idle for at least 5 seconds it will start
+copying back pages from swap into the swapcache and keep a copy in swap. In
+practice it can take many minutes before the vm is idle enough.
+
+The default value is 1.
Index: linux-2.6.16-rc3-sp/include/linux/swap.h
===================================================================
--- linux-2.6.16-rc3-sp.orig/include/linux/swap.h	2006-02-18 01:33:36.000000000 +1100
+++ linux-2.6.16-rc3-sp/include/linux/swap.h	2006-02-18 01:33:50.000000000 +1100
@@ -7,6 +7,7 @@
 #include <linux/mmzone.h>
 #include <linux/list.h>
 #include <linux/sched.h>
+#include <linux/mm.h>
 
 #include <asm/atomic.h>
 #include <asm/page.h>
@@ -164,6 +165,7 @@ extern unsigned int nr_free_pagecache_pa
 /* linux/mm/swap.c */
 extern void FASTCALL(lru_cache_add(struct page *));
 extern void FASTCALL(lru_cache_add_active(struct page *));
+extern void FASTCALL(lru_cache_add_tail(struct page *));
 extern void FASTCALL(activate_page(struct page *));
 extern void FASTCALL(mark_page_accessed(struct page *));
 extern void lru_add_drain(void);
@@ -214,6 +216,58 @@ extern int shmem_unuse(swp_entry_t entry
 
 extern void swap_unplug_io_fn(struct backing_dev_info *, struct page *);
 
+#ifdef CONFIG_SWAP_PREFETCH
+/* mm/swap_prefetch.c */
+extern int swap_prefetch;
+struct swapped_entry {
+	swp_entry_t		swp_entry;	/* The actual swap entry */
+	struct list_head	swapped_list;	/* Linked list of entries */
+#if MAX_NUMNODES > 1
+	int			node;		/* Node id */
+#endif
+} __attribute__((packed));
+
+static inline void store_swap_entry_node(struct swapped_entry *entry,
+	struct page *page)
+{
+#if MAX_NUMNODES > 1
+	entry->node = page_to_nid(page);
+#endif
+}
+
+static inline int get_swap_entry_node(struct swapped_entry *entry)
+{
+#if MAX_NUMNODES > 1
+	return entry->node;
+#else
+	return 0;
+#endif
+}
+
+extern void add_to_swapped_list(struct page *page);
+extern void remove_from_swapped_list(const unsigned long index);
+extern void delay_swap_prefetch(void);
+extern void prepare_swap_prefetch(void);
+
+#else	/* CONFIG_SWAP_PREFETCH */
+static inline void add_to_swapped_list(struct page *__unused)
+{
+}
+
+static inline void prepare_swap_prefetch(void)
+{
+}
+
+static inline void remove_from_swapped_list(const unsigned long __unused)
+{
+}
+
+static inline void delay_swap_prefetch(void)
+{
+}
+
+#endif	/* CONFIG_SWAP_PREFETCH */
+
 #ifdef CONFIG_SWAP
 /* linux/mm/page_io.c */
 extern int swap_readpage(struct file *, struct page *);
@@ -235,6 +289,7 @@ extern void free_pages_and_swap_cache(st
 extern struct page * lookup_swap_cache(swp_entry_t);
 extern struct page * read_swap_cache_async(swp_entry_t, struct vm_area_struct *vma,
 					   unsigned long addr);
+extern int add_to_swap_cache(struct page *page, swp_entry_t entry);
 /* linux/mm/swapfile.c */
 extern long total_swap_pages;
 extern unsigned int nr_swapfiles;
Index: linux-2.6.16-rc3-sp/include/linux/sysctl.h
===================================================================
--- linux-2.6.16-rc3-sp.orig/include/linux/sysctl.h	2006-02-18 01:33:36.000000000 +1100
+++ linux-2.6.16-rc3-sp/include/linux/sysctl.h	2006-02-18 01:33:50.000000000 +1100
@@ -184,6 +184,7 @@ enum
 	VM_PERCPU_PAGELIST_FRACTION=30,/* int: fraction of pages in each percpu_pagelist */
 	VM_ZONE_RECLAIM_MODE=31, /* reclaim local zone memory before going off node */
 	VM_ZONE_RECLAIM_INTERVAL=32, /* time period to wait after reclaim failure */
+	VM_SWAP_PREFETCH=33,	/* swap prefetch */
 };
 
 
Index: linux-2.6.16-rc3-sp/init/Kconfig
===================================================================
--- linux-2.6.16-rc3-sp.orig/init/Kconfig	2006-02-18 01:33:36.000000000 +1100
+++ linux-2.6.16-rc3-sp/init/Kconfig	2006-02-18 01:33:50.000000000 +1100
@@ -92,6 +92,28 @@ config SWAP
 	  used to provide more virtual memory than the actual RAM present
 	  in your computer.  If unsure say Y.
 
+config SWAP_PREFETCH
+	bool "Support for prefetching swapped memory"
+	depends on SWAP
+	default y
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
+	  should stabilise around 50% swap usage maximum.
+
+	  Workstations and multiuser workstation servers will most likely want
+	  to say Y.
+
 config SYSVIPC
 	bool "System V IPC"
 	---help---
Index: linux-2.6.16-rc3-sp/kernel/sysctl.c
===================================================================
--- linux-2.6.16-rc3-sp.orig/kernel/sysctl.c	2006-02-18 01:33:36.000000000 +1100
+++ linux-2.6.16-rc3-sp/kernel/sysctl.c	2006-02-18 01:33:51.000000000 +1100
@@ -891,6 +891,16 @@ static ctl_table vm_table[] = {
 		.strategy	= &sysctl_jiffies,
 	},
 #endif
+#ifdef CONFIG_SWAP_PREFETCH
+	{
+		.ctl_name	= VM_SWAP_PREFETCH,
+		.procname	= "swap_prefetch",
+		.data		= &swap_prefetch,
+		.maxlen		= sizeof(swap_prefetch),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+#endif
 	{ .ctl_name = 0 }
 };
 
Index: linux-2.6.16-rc3-sp/mm/Makefile
===================================================================
--- linux-2.6.16-rc3-sp.orig/mm/Makefile	2006-02-18 01:33:36.000000000 +1100
+++ linux-2.6.16-rc3-sp/mm/Makefile	2006-02-18 01:33:51.000000000 +1100
@@ -13,6 +13,7 @@ obj-y			:= bootmem.o filemap.o mempool.o
 			   prio_tree.o util.o $(mmu-y)
 
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o thrash.o
+obj-$(CONFIG_SWAP_PREFETCH) += swap_prefetch.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
 obj-$(CONFIG_NUMA) 	+= mempolicy.o
 obj-$(CONFIG_SPARSEMEM)	+= sparse.o
Index: linux-2.6.16-rc3-sp/mm/swap.c
===================================================================
--- linux-2.6.16-rc3-sp.orig/mm/swap.c	2006-02-18 01:33:36.000000000 +1100
+++ linux-2.6.16-rc3-sp/mm/swap.c	2006-02-18 01:33:51.000000000 +1100
@@ -382,6 +382,45 @@ void __pagevec_lru_add_active(struct pag
 	pagevec_reinit(pvec);
 }
 
+static inline void __pagevec_lru_add_tail(struct pagevec *pvec)
+{
+	int i;
+	struct zone *zone = NULL;
+
+	for (i = 0; i < pagevec_count(pvec); i++) {
+		struct page *page = pvec->pages[i];
+		struct zone *pagezone = page_zone(page);
+
+		if (pagezone != zone) {
+			if (zone)
+				spin_unlock_irq(&zone->lru_lock);
+			zone = pagezone;
+			spin_lock_irq(&zone->lru_lock);
+		}
+		if (TestSetPageLRU(page))
+			BUG();
+		add_page_to_inactive_list_tail(zone, page);
+	}
+	if (zone)
+		spin_unlock_irq(&zone->lru_lock);
+	release_pages(pvec->pages, pvec->nr, pvec->cold);
+	pagevec_reinit(pvec);
+}
+
+/*
+ * Function used uniquely to put pages back to the lru at the end of the
+ * inactive list currently only used by swap prefetch.
+ */
+void fastcall lru_cache_add_tail(struct page *page)
+{
+	struct pagevec *pvec = &get_cpu_var(lru_add_pvecs);
+
+	page_cache_get(page);
+	if (!pagevec_add(pvec, page))
+		__pagevec_lru_add_tail(pvec);
+	put_cpu_var(lru_add_pvecs);
+}
+
 /*
  * Try to drop buffers from the pages in a pagevec
  */
@@ -514,5 +553,8 @@ void __init swap_setup(void)
 	 * Right now other parts of the system means that we
 	 * _really_ don't want to cluster much more
 	 */
+
+	prepare_swap_prefetch();
+
 	hotcpu_notifier(cpu_swap_callback, 0);
 }
Index: linux-2.6.16-rc3-sp/mm/swap_prefetch.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.16-rc3-sp/mm/swap_prefetch.c	2006-02-18 01:33:51.000000000 +1100
@@ -0,0 +1,488 @@
+/*
+ * linux/mm/swap_prefetch.c
+ *
+ * Copyright (C) 2005-2006 Con Kolivas
+ *
+ * Written by Con Kolivas <kernel@kolivas.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/fs.h>
+#include <linux/swap.h>
+#include <linux/ioprio.h>
+#include <linux/kthread.h>
+#include <linux/pagemap.h>
+#include <linux/syscalls.h>
+#include <linux/writeback.h>
+
+/*
+ * Time to delay prefetching if vm is busy or prefetching unsuccessful. There
+ * needs to be at least this duration of idle time meaning in practice it can
+ * be much longer
+ */
+#define PREFETCH_DELAY	(HZ * 5)
+
+/* sysctl - enable/disable swap prefetching */
+int swap_prefetch __read_mostly = 1;
+
+struct swapped_root {
+	unsigned long		busy;		/* vm busy */
+	spinlock_t		lock;		/* protects all data */
+	struct list_head	list;		/* MRU list of swapped pages */
+	struct radix_tree_root	swap_tree;	/* Lookup tree of pages */
+	unsigned int		count;		/* Number of entries */
+	unsigned int		maxcount;	/* Maximum entries allowed */
+	kmem_cache_t		*cache;		/* Of struct swapped_entry */
+};
+
+static struct swapped_root swapped = {
+	.busy 		= 0,			/* Any vm activity */
+	.lock		= SPIN_LOCK_UNLOCKED,
+	.list  		= LIST_HEAD_INIT(swapped.list),
+	.swap_tree	= RADIX_TREE_INIT(GFP_ATOMIC),
+	.count 		= 0,			/* Number of swapped entries */
+};
+
+static task_t *kprefetchd_task;
+
+/*
+ * We check to see no part of the vm is busy. If it is this will interrupt
+ * trickle_swap and wait another PREFETCH_DELAY. Purposefully racy.
+ */
+inline void delay_swap_prefetch(void)
+{
+	if (!test_bit(0, &swapped.busy))
+		__set_bit(0, &swapped.busy);
+}
+
+/*
+ * Drop behind accounting which keeps a list of the most recently used swap
+ * entries.
+ */
+void add_to_swapped_list(struct page *page)
+{
+	struct swapped_entry *entry;
+	unsigned long index;
+	int wakeup;
+
+	if (!swap_prefetch)
+		return;
+
+	wakeup = 0;
+
+	spin_lock(&swapped.lock);
+	if (swapped.count >= swapped.maxcount) {
+		/*
+		 * We limit the number of entries to 2/3 of physical ram.
+		 * Once the number of entries exceeds this we start removing
+		 * the least recently used entries.
+		 */
+		entry = list_entry(swapped.list.next,
+			struct swapped_entry, swapped_list);
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
+	index = page_private(page);
+	entry->swp_entry.val = index;
+	/*
+	 * On numa we need to store the node id to ensure that we prefetch to
+	 * the same node it came from.
+	 */
+	store_swap_entry_node(entry, page);
+
+	if (likely(!radix_tree_insert(&swapped.swap_tree, index, entry))) {
+		/*
+		 * If this is the first entry, kprefetchd needs to be
+		 * (re)started.
+		 */
+		if (list_empty(&swapped.list))
+			wakeup = 1;
+		list_add(&entry->swapped_list, &swapped.list);
+		swapped.count++;
+	}
+
+out_locked:
+	spin_unlock(&swapped.lock);
+
+	/* Do the wakeup outside the lock to shorten lock hold time. */
+	if (wakeup)
+		wake_up_process(kprefetchd_task);
+
+	return;
+}
+
+/*
+ * Removes entries from the swapped_list. The radix tree allows us to quickly
+ * look up the entry from the index without having to iterate over the whole
+ * list.
+ */
+void remove_from_swapped_list(const unsigned long index)
+{
+	struct swapped_entry *entry;
+	unsigned long flags;
+
+	if (list_empty(&swapped.list))
+		return;
+
+	spin_lock_irqsave(&swapped.lock, flags);
+	entry = radix_tree_delete(&swapped.swap_tree, index);
+	if (likely(entry)) {
+		list_del_init(&entry->swapped_list);
+		swapped.count--;
+		kmem_cache_free(swapped.cache, entry);
+	}
+	spin_unlock_irqrestore(&swapped.lock, flags);
+}
+
+enum trickle_return {
+	TRICKLE_SUCCESS,
+	TRICKLE_FAILED,
+	TRICKLE_DELAY,
+};
+
+/*
+ * prefetch_stats stores the free ram data of each node and this is used to
+ * determine if a node is suitable for prefetching into.
+ */
+struct prefetch_stats{
+	unsigned long	last_free[MAX_NUMNODES];
+	/* Free ram after a cycle of prefetching */
+	unsigned long	current_free[MAX_NUMNODES];
+	/* Free ram on this cycle of checking prefetch_suitable */
+	unsigned long	prefetch_watermark[MAX_NUMNODES];
+	/* Maximum amount we will prefetch to */
+	nodemask_t	prefetch_nodes;
+	/* Which nodes are currently suited to prefetching */
+	unsigned long	prefetched_pages;
+	/* Total pages we've prefetched on this wakeup of kprefetchd */
+};
+
+static struct prefetch_stats sp_stat;
+
+/*
+ * This tries to read a swp_entry_t into swap cache for swap prefetching.
+ * If it returns TRICKLE_DELAY we should delay further prefetching.
+ */
+static enum trickle_return trickle_swap_cache_async(const swp_entry_t entry,
+	const int node)
+{
+	enum trickle_return ret = TRICKLE_FAILED;
+	struct page *page;
+
+	read_lock_irq(&swapper_space.tree_lock);
+	/* Entry may already exist */
+	page = radix_tree_lookup(&swapper_space.page_tree, entry.val);
+	read_unlock_irq(&swapper_space.tree_lock);
+	if (page) {
+		remove_from_swapped_list(entry.val);
+		goto out;
+	}
+
+	/*
+	 * Get a new page to read from swap. We have already checked the
+	 * watermarks so __alloc_pages will not call on reclaim.
+	 */
+	page = alloc_pages_node(node, GFP_HIGHUSER & ~__GFP_WAIT, 0);
+	if (unlikely(!page)) {
+		ret = TRICKLE_DELAY;
+		goto out;
+	}
+
+	if (add_to_swap_cache(page, entry)) {
+		/* Failed to add to swap cache */
+		goto out_release;
+	}
+
+	/* Add them to the tail of the inactive list to preserve LRU order */
+	lru_cache_add_tail(page);
+	if (unlikely(swap_readpage(NULL, page))) {
+		ret = TRICKLE_DELAY;
+		goto out_release;
+	}
+
+	sp_stat.prefetched_pages++;
+	sp_stat.last_free[node]--;
+
+	ret = TRICKLE_SUCCESS;
+out_release:
+	page_cache_release(page);
+out:
+	return ret;
+}
+
+static void clear_last_prefetch_free(void)
+{
+	int node;
+
+	/*
+	 * Reset the nodes suitable for prefetching to all nodes. We could
+	 * update the data to take into account memory hotplug if desired..
+	 */
+	sp_stat.prefetch_nodes = node_online_map;
+	for_each_node_mask(node, sp_stat.prefetch_nodes)
+		sp_stat.last_free[node] = 0;
+}
+
+static void clear_current_prefetch_free(void)
+{
+	int node;
+
+	sp_stat.prefetch_nodes = node_online_map;
+	for_each_node_mask(node, sp_stat.prefetch_nodes)
+		sp_stat.current_free[node] = 0;
+}
+
+/*
+ * We want to be absolutely certain it's ok to start prefetching.
+ */
+static int prefetch_suitable(void)
+{
+	struct page_state ps;
+	unsigned long limit;
+	struct zone *z;
+	int node, ret = 0;
+
+	/* Purposefully racy and might return false positive which is ok */
+	if (__test_and_clear_bit(0, &swapped.busy))
+		goto out;
+
+	clear_current_prefetch_free();
+
+	/*
+	 * Have some hysteresis between where page reclaiming and prefetching
+	 * will occur to prevent ping-ponging between them.
+	 */
+	for_each_zone(z) {
+		unsigned long free;
+
+		if (!populated_zone(z))
+			continue;
+		node = z->zone_pgdat->node_id;
+
+		free = z->free_pages;
+		if (z->pages_high * 3 + z->lowmem_reserve[zone_idx(z)] > free) {
+			node_clear(node, sp_stat.prefetch_nodes);
+			continue;
+		}
+		sp_stat.current_free[node] += free;
+	}
+
+	/*
+	 * We iterate over each node testing to see if it is suitable for
+	 * prefetching and clear the nodemask if it is not.
+	 */
+	for_each_node_mask(node, sp_stat.prefetch_nodes) {
+		/*
+		 * We check to see that pages are not being allocated
+		 * elsewhere at any significant rate implying any
+		 * degree of memory pressure (eg during file reads)
+		 */
+		if (sp_stat.last_free[node]) {
+			if (sp_stat.current_free[node] + SWAP_CLUSTER_MAX <
+				sp_stat.last_free[node]) {
+					sp_stat.last_free[node] =
+						sp_stat.current_free[node];
+					node_clear(node,
+						sp_stat.prefetch_nodes);
+					continue;
+			}
+		} else
+			sp_stat.last_free[node] = sp_stat.current_free[node];
+
+		/*
+		 * get_page_state is super expensive so we only perform it
+		 * every SWAP_CLUSTER_MAX prefetched_pages
+		 */
+		if (sp_stat.prefetched_pages % SWAP_CLUSTER_MAX)
+			continue;
+
+		get_page_state_node(&ps, node);
+
+		/* We shouldn't prefetch when we are doing writeback */
+		if (ps.nr_writeback) {
+			node_clear(node, sp_stat.prefetch_nodes);
+			continue;
+		}
+
+		/*
+		 * >2/3 of the ram on this node is mapped, slab, swapcache or
+		 * dirty, we need to leave some free for pagecache.
+		 * Note that currently nr_slab is innacurate on numa because
+		 * nr_slab is incremented on the node doing the accounting
+		 * even if the slab is being allocated on a remote node. This
+		 * would be expensive to fix and not of great significance.
+		 */
+		limit = ps.nr_mapped + ps.nr_slab + ps.nr_dirty +
+			ps.nr_unstable + total_swapcache_pages;
+		if (limit > sp_stat.prefetch_watermark[node]) {
+			node_clear(node, sp_stat.prefetch_nodes);
+			continue;
+		}
+	}
+
+	if (nodes_empty(sp_stat.prefetch_nodes))
+		goto out;
+
+	/* Survived all that? Hooray we can prefetch! */
+	ret = 1;
+out:
+	return ret;
+}
+
+/*
+ * Get next swapped entry when iterating over all entries. swapped.lock
+ * should be held and we should already ensure that entry exists.
+ */
+static inline struct swapped_entry *next_swapped_entry
+	(struct swapped_entry *entry)
+{
+	return list_entry(entry->swapped_list.next->next,
+		struct swapped_entry, swapped_list);
+}
+
+/*
+ * trickle_swap is the main function that initiates the swap prefetching. It
+ * first checks to see if the busy flag is set, and does not prefetch if it
+ * is, as the flag implied we are low on memory or swapping in currently.
+ * Otherwise it runs until prefetch_suitable fails which occurs when the
+ * vm is busy, we prefetch to the watermark, or the list is empty.
+ */
+static enum trickle_return trickle_swap(void)
+{
+	enum trickle_return ret = TRICKLE_DELAY;
+	struct swapped_entry *entry;
+
+	if (!swap_prefetch || laptop_mode)
+		return ret;
+
+	entry = NULL;
+
+	for ( ; ; ) {
+		swp_entry_t swp_entry;
+		int node;
+
+		if (!prefetch_suitable())
+			break;
+
+		spin_lock(&swapped.lock);
+		if (list_empty(&swapped.list)) {
+			ret = TRICKLE_FAILED;
+			spin_unlock(&swapped.lock);
+			break;
+		}
+
+		if (!entry) {
+			/*
+			 * This sets the entry for the first iteration. It
+			 * also is a safeguard against the entry disappearing
+			 * while the lock is not held.
+			 */
+			entry = list_entry(swapped.list.next,
+				struct swapped_entry, swapped_list);
+		} else if (entry->swapped_list.next == swapped.list.next) {
+			/* Have we iterated over all entries? */
+			spin_unlock(&swapped.lock);
+			break;
+		}
+
+		node = get_swap_entry_node(entry);
+		if (!node_isset(node, sp_stat.prefetch_nodes)) {
+			/*
+			 * We found an entry that belongs to a node that is
+			 * not suitable for prefetching so skip it.
+			 */
+			entry = next_swapped_entry(entry);
+			spin_unlock(&swapped.lock);
+			continue;
+		}
+		swp_entry = entry->swp_entry;
+		entry = next_swapped_entry(entry);
+		spin_unlock(&swapped.lock);
+
+		if (trickle_swap_cache_async(swp_entry, node) == TRICKLE_DELAY)
+			break;
+	}
+
+	if (sp_stat.prefetched_pages) {
+		lru_add_drain();
+		sp_stat.prefetched_pages = 0;
+	}
+	return ret;
+}
+
+static int kprefetchd(void *__unused)
+{
+	set_user_nice(current, 19);
+	/* Set ioprio to lowest if supported by i/o scheduler */
+	sys_ioprio_set(IOPRIO_WHO_PROCESS, 0, IOPRIO_CLASS_IDLE);
+
+	do {
+		try_to_freeze();
+
+		/*
+		 * TRICKLE_FAILED implies no entries left - we do not schedule
+		 * a wakeup, and further delay the next one.
+		 */
+		if (trickle_swap() == TRICKLE_FAILED) {
+			set_current_state(TASK_INTERRUPTIBLE);
+			schedule();
+		}
+		clear_last_prefetch_free();
+		schedule_timeout_interruptible(PREFETCH_DELAY);
+	} while (!kthread_should_stop());
+
+	return 0;
+}
+
+/*
+ * Create kmem cache for swapped entries
+ */
+void __init prepare_swap_prefetch(void)
+{
+	pg_data_t *pgdat;
+	int node;
+
+	swapped.cache = kmem_cache_create("swapped_entry",
+		sizeof(struct swapped_entry), 0, SLAB_PANIC, NULL, NULL);
+
+	/*
+	 * Set max number of entries to 2/3 the size of physical ram  as we
+	 * only ever prefetch to consume 2/3 of the ram.
+	 */
+	swapped.maxcount = nr_free_pagecache_pages() / 3 * 2;
+
+	for_each_pgdat(pgdat) {
+		unsigned long present;
+
+		present = pgdat->node_present_pages;
+		if (!present)
+			continue;
+		node = pgdat->node_id;
+		sp_stat.prefetch_watermark[node] += present / 3 * 2;
+	}
+}
+
+static int __init kprefetchd_init(void)
+{
+	kprefetchd_task = kthread_run(kprefetchd, NULL, "kprefetchd");
+
+	return 0;
+}
+
+static void __exit kprefetchd_exit(void)
+{
+	kthread_stop(kprefetchd_task);
+}
+
+module_init(kprefetchd_init);
+module_exit(kprefetchd_exit);
Index: linux-2.6.16-rc3-sp/mm/swap_state.c
===================================================================
--- linux-2.6.16-rc3-sp.orig/mm/swap_state.c	2006-02-18 01:33:36.000000000 +1100
+++ linux-2.6.16-rc3-sp/mm/swap_state.c	2006-02-18 01:33:51.000000000 +1100
@@ -81,6 +81,7 @@ static int __add_to_swap_cache(struct pa
 		error = radix_tree_insert(&swapper_space.page_tree,
 						entry.val, page);
 		if (!error) {
+			remove_from_swapped_list(entry.val);
 			page_cache_get(page);
 			SetPageLocked(page);
 			SetPageSwapCache(page);
@@ -94,11 +95,12 @@ static int __add_to_swap_cache(struct pa
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
@@ -147,6 +149,9 @@ int add_to_swap(struct page * page, gfp_
 	swp_entry_t entry;
 	int err;
 
+	/* Swap prefetching is delayed if we're swapping pages */
+	delay_swap_prefetch();
+
 	if (!PageLocked(page))
 		BUG();
 
@@ -320,6 +325,9 @@ struct page *read_swap_cache_async(swp_e
 	struct page *found_page, *new_page = NULL;
 	int err;
 
+	/* Swap prefetching is delayed if we're already reading from swap */
+	delay_swap_prefetch();
+
 	do {
 		/*
 		 * First check the swap cache.  Since this is normally
Index: linux-2.6.16-rc3-sp/mm/vmscan.c
===================================================================
--- linux-2.6.16-rc3-sp.orig/mm/vmscan.c	2006-02-18 01:33:36.000000000 +1100
+++ linux-2.6.16-rc3-sp/mm/vmscan.c	2006-02-18 01:33:51.000000000 +1100
@@ -396,6 +396,7 @@ static int remove_mapping(struct address
 
 	if (PageSwapCache(page)) {
 		swp_entry_t swap = { .val = page_private(page) };
+		add_to_swapped_list(page);
 		__delete_from_swap_cache(page);
 		write_unlock_irq(&mapping->tree_lock);
 		swap_free(swap);
@@ -1432,6 +1433,8 @@ int try_to_free_pages(struct zone **zone
 	unsigned long lru_pages = 0;
 	int i;
 
+	delay_swap_prefetch();
+
 	sc.gfp_mask = gfp_mask;
 	sc.may_writepage = !laptop_mode;
 	sc.may_swap = 1;
@@ -1782,6 +1785,8 @@ int shrink_all_memory(int nr_pages)
 		.reclaimed_slab = 0,
 	};
 
+	delay_swap_prefetch();
+
 	current->reclaim_state = &reclaim_state;
 	for_each_pgdat(pgdat) {
 		int freed;
Index: linux-2.6.16-rc3-sp/include/linux/mm_inline.h
===================================================================
--- linux-2.6.16-rc3-sp.orig/include/linux/mm_inline.h	2006-02-18 01:33:36.000000000 +1100
+++ linux-2.6.16-rc3-sp/include/linux/mm_inline.h	2006-02-18 01:33:51.000000000 +1100
@@ -14,6 +14,13 @@ add_page_to_inactive_list(struct zone *z
 }
 
 static inline void
+add_page_to_inactive_list_tail(struct zone *zone, struct page *page)
+{
+	list_add_tail(&page->lru, &zone->inactive_list);
+	zone->nr_inactive++;
+}
+
+static inline void
 del_page_from_active_list(struct zone *zone, struct page *page)
 {
 	list_del(&page->lru);
