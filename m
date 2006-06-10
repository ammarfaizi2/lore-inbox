Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030367AbWFJIMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030367AbWFJIMK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 04:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030370AbWFJIMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 04:12:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44997 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030367AbWFJIMG (ORCPT
	<rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sat, 10 Jun 2006 04:12:06 -0400
Date: Sat, 10 Jun 2006 01:11:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: kernel@kolivas.org, linux-mm@kvack.org, Linux-Kernel@vger.kernel.org
Subject: Re: merging swap prefetching
Message-Id: <20060610011156.7c72332f.akpm@osdl.org>
In-Reply-To: <448A79C9.5000500@yahoo.com.au>
References: <448A79C9.5000500@yahoo.com.au>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jun 2006 17:50:33 +1000
Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> I had a quick look at the code, and I think it still needs
> more cleanup and review... it is vaguely difficult to participate
> in discussions about these patches because they are often split
> over several iterations of versions/fixes, and because it isn't
> always clear what they depend on (although in the case of swap
> prefetching, that isn't so much of a problem).

I rolled all the patches together:


From: Con Kolivas <kernel@kolivas.org>

Implement swap prefetching when the vm is relatively idle and there is free
ram available.  The code is based on some preliminary code by Thomas
Schlichter.

This stores a list of swapped entries in a list ordered most recently used
and a radix tree.  It generates a low priority kernel thread running at
nice 19 to do the prefetching at a later stage.

Once pages have been added to the swapped list, a timer is started, testing
for conditions suitable to prefetch swap pages every 5 seconds.  Suitable
conditions are defined as lack of swapping out or in any pages, and no
watermark tests failing.  Significant amounts of dirtied ram and changes in
free ram representing disk writes or reads also prevent prefetching.

It then checks that we have spare ram looking for at least 3* pages_high
free per zone and if it succeeds that will prefetch pages from swap into
the swap cache.  The pages are added to the tail of the inactive list to
preserve LRU ordering.

Pages are prefetched until the list is empty or the vm is seen as busy
according to the previously described criteria.  Node data on numa is
stored with the entries and an appropriate zonelist based on this is used
when allocating ram.

The pages are copied to swap cache and kept on backing store.  This allows
pressure on either physical ram or swap to readily find free pages without
further I/O.

Prefetching can be enabled/disabled via the tunable in
/proc/sys/vm/swap_prefetch initially set to 1 (enabled).

Enabling laptop_mode disables swap prefetching to prevent unnecessary spin
ups.

In testing on modern pc hardware this results in wall-clock time activation
of the firefox browser to speed up 5 fold after a worst case complete
swap-out of the browser on a static web page.

From: Ingo Molnar <mingo@elte.hu>

  Fix potential swap-prefetch deadlock, found by the locking correctness
  validator.

Signed-off-by: Con Kolivas <kernel@kolivas.org>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 Documentation/sysctl/vm.txt   |   11 
 include/linux/mm_inline.h     |    7 
 include/linux/swap-prefetch.h |   55 +++
 include/linux/swap.h          |    2 
 include/linux/sysctl.h        |    2 
 init/Kconfig                  |   22 +
 kernel/sysctl.c               |   11 
 mm/Makefile                   |    1 
 mm/swap.c                     |   48 ++
 mm/swap_prefetch.c            |  579 ++++++++++++++++++++++++++++++++
 mm/swap_state.c               |   11 
 mm/vmscan.c                   |    5 
 12 files changed, 752 insertions(+), 2 deletions(-)

diff -puN Documentation/sysctl/vm.txt~mm-implement-swap-prefetching Documentation/sysctl/vm.txt
--- devel/Documentation/sysctl/vm.txt~mm-implement-swap-prefetching	2006-06-09 20:58:36.000000000 -0700
+++ devel-akpm/Documentation/sysctl/vm.txt	2006-06-10 01:06:31.000000000 -0700
@@ -30,6 +30,7 @@ Currently, these files are in /proc/sys/
 - zone_reclaim_mode
 - zone_reclaim_interval
 - panic_on_oom
+- swap_prefetch
 
 ==============================================================
 
@@ -191,3 +192,13 @@ rather than killing rogue processes, set
 
 The default value is 0.
 
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
diff -puN include/linux/mm_inline.h~mm-implement-swap-prefetching include/linux/mm_inline.h
--- devel/include/linux/mm_inline.h~mm-implement-swap-prefetching	2006-06-09 20:58:36.000000000 -0700
+++ devel-akpm/include/linux/mm_inline.h	2006-06-09 20:58:36.000000000 -0700
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
diff -puN include/linux/swap.h~mm-implement-swap-prefetching include/linux/swap.h
--- devel/include/linux/swap.h~mm-implement-swap-prefetching	2006-06-09 20:58:36.000000000 -0700
+++ devel-akpm/include/linux/swap.h	2006-06-09 20:58:36.000000000 -0700
@@ -173,6 +173,7 @@ extern unsigned int nr_free_pagecache_pa
 /* linux/mm/swap.c */
 extern void FASTCALL(lru_cache_add(struct page *));
 extern void FASTCALL(lru_cache_add_active(struct page *));
+extern void FASTCALL(lru_cache_add_tail(struct page *));
 extern void FASTCALL(activate_page(struct page *));
 extern void FASTCALL(mark_page_accessed(struct page *));
 extern void lru_add_drain(void);
@@ -228,6 +229,7 @@ extern void free_pages_and_swap_cache(st
 extern struct page * lookup_swap_cache(swp_entry_t);
 extern struct page * read_swap_cache_async(swp_entry_t, struct vm_area_struct *vma,
 					   unsigned long addr);
+extern int add_to_swap_cache(struct page *page, swp_entry_t entry);
 /* linux/mm/swapfile.c */
 extern long total_swap_pages;
 extern unsigned int nr_swapfiles;
diff -puN include/linux/sysctl.h~mm-implement-swap-prefetching include/linux/sysctl.h
--- devel/include/linux/sysctl.h~mm-implement-swap-prefetching	2006-06-09 20:58:36.000000000 -0700
+++ devel-akpm/include/linux/sysctl.h	2006-06-10 01:06:34.000000000 -0700
@@ -191,9 +191,9 @@ enum
 	VM_ZONE_RECLAIM_MODE=31, /* reclaim local zone memory before going off node */
 	VM_PANIC_ON_OOM=33,	/* panic at out-of-memory */
 	VM_VDSO_ENABLED=34,	/* map VDSO into new processes? */
+	VM_SWAP_PREFETCH=35,	/* swap prefetch */
 };
 
-
 /* CTL_NET names: */
 enum
 {
diff -puN init/Kconfig~mm-implement-swap-prefetching init/Kconfig
--- devel/init/Kconfig~mm-implement-swap-prefetching	2006-06-09 20:58:36.000000000 -0700
+++ devel-akpm/init/Kconfig	2006-06-10 01:06:34.000000000 -0700
@@ -100,6 +100,28 @@ config SWAP
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
diff -puN kernel/sysctl.c~mm-implement-swap-prefetching kernel/sysctl.c
--- devel/kernel/sysctl.c~mm-implement-swap-prefetching	2006-06-09 20:58:36.000000000 -0700
+++ devel-akpm/kernel/sysctl.c	2006-06-10 01:06:34.000000000 -0700
@@ -23,6 +23,7 @@
 #include <linux/mm.h>
 #include <linux/swap.h>
 #include <linux/slab.h>
+#include <linux/swap-prefetch.h>
 #include <linux/sysctl.h>
 #include <linux/proc_fs.h>
 #include <linux/capability.h>
@@ -948,6 +949,16 @@ static ctl_table vm_table[] = {
 		.extra1		= &zero,
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
 
diff -puN mm/Makefile~mm-implement-swap-prefetching mm/Makefile
--- devel/mm/Makefile~mm-implement-swap-prefetching	2006-06-09 20:58:36.000000000 -0700
+++ devel-akpm/mm/Makefile	2006-06-09 20:58:36.000000000 -0700
@@ -13,6 +13,7 @@ obj-y			:= bootmem.o filemap.o mempool.o
 			   prio_tree.o util.o mmzone.o $(mmu-y)
 
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o thrash.o
+obj-$(CONFIG_SWAP_PREFETCH) += swap_prefetch.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
 obj-$(CONFIG_NUMA) 	+= mempolicy.o
 obj-$(CONFIG_SPARSEMEM)	+= sparse.o
diff -puN mm/swap.c~mm-implement-swap-prefetching mm/swap.c
--- devel/mm/swap.c~mm-implement-swap-prefetching	2006-06-09 20:58:36.000000000 -0700
+++ devel-akpm/mm/swap.c	2006-06-10 01:07:12.000000000 -0700
@@ -17,6 +17,7 @@
 #include <linux/sched.h>
 #include <linux/kernel_stat.h>
 #include <linux/swap.h>
+#include <linux/swap-prefetch.h>
 #include <linux/mman.h>
 #include <linux/pagemap.h>
 #include <linux/pagevec.h>
@@ -137,6 +138,7 @@ EXPORT_SYMBOL(mark_page_accessed);
  */
 static DEFINE_PER_CPU(struct pagevec, lru_add_pvecs) = { 0, };
 static DEFINE_PER_CPU(struct pagevec, lru_add_active_pvecs) = { 0, };
+static DEFINE_PER_CPU(struct pagevec, lru_add_tail_pvecs) = { 0, };
 
 void fastcall lru_cache_add(struct page *page)
 {
@@ -158,6 +160,31 @@ void fastcall lru_cache_add_active(struc
 	put_cpu_var(lru_add_active_pvecs);
 }
 
+static void __pagevec_lru_add_tail(struct pagevec *pvec)
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
+		BUG_ON(PageLRU(page));
+		SetPageLRU(page);
+		add_page_to_inactive_list_tail(zone, page);
+	}
+	if (zone)
+		spin_unlock_irq(&zone->lru_lock);
+	release_pages(pvec->pages, pvec->nr, pvec->cold);
+	pagevec_reinit(pvec);
+}
+
 static void __lru_add_drain(int cpu)
 {
 	struct pagevec *pvec = &per_cpu(lru_add_pvecs, cpu);
@@ -168,6 +195,9 @@ static void __lru_add_drain(int cpu)
 	pvec = &per_cpu(lru_add_active_pvecs, cpu);
 	if (pagevec_count(pvec))
 		__pagevec_lru_add_active(pvec);
+	pvec = &per_cpu(lru_add_tail_pvecs, cpu);
+	if (pagevec_count(pvec))
+		__pagevec_lru_add_tail(pvec);
 }
 
 void lru_add_drain(void)
@@ -384,6 +414,21 @@ void __pagevec_lru_add_active(struct pag
 }
 
 /*
+ * Function used uniquely to put pages back to the lru at the end of the
+ * inactive list to preserve the lru order. Currently only used by swap
+ * prefetch.
+ */
+void fastcall lru_cache_add_tail(struct page *page)
+{
+	struct pagevec *pvec = &get_cpu_var(lru_add_tail_pvecs);
+
+	page_cache_get(page);
+	if (!pagevec_add(pvec, page))
+		__pagevec_lru_add_tail(pvec);
+	put_cpu_var(lru_add_pvecs);
+}
+
+/*
  * Try to drop buffers from the pages in a pagevec
  */
 void pagevec_strip(struct pagevec *pvec)
@@ -495,5 +540,8 @@ void __init swap_setup(void)
 	 * Right now other parts of the system means that we
 	 * _really_ don't want to cluster much more
 	 */
+
+	prepare_swap_prefetch();
+
 	hotcpu_notifier(cpu_swap_callback, 0);
 }
diff -puN /dev/null mm/swap_prefetch.c
--- /dev/null	2006-06-03 22:34:36.282200750 -0700
+++ devel-akpm/mm/swap_prefetch.c	2006-06-10 01:07:16.000000000 -0700
@@ -0,0 +1,579 @@
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
+#include <linux/mm.h>
+#include <linux/swap.h>
+#include <linux/swap-prefetch.h>
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
+	.lock		= SPIN_LOCK_UNLOCKED,
+	.list  		= LIST_HEAD_INIT(swapped.list),
+	.swap_tree	= RADIX_TREE_INIT(GFP_ATOMIC),
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
+	unsigned long index, flags;
+	int wakeup;
+
+	if (!swap_prefetch)
+		return;
+
+	wakeup = 0;
+
+	spin_lock_irqsave(&swapped.lock, flags);
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
+		if (!swapped.count)
+			wakeup = 1;
+		list_add(&entry->swapped_list, &swapped.list);
+		swapped.count++;
+	}
+
+out_locked:
+	spin_unlock_irqrestore(&swapped.lock, flags);
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
+struct node_stats {
+	unsigned long	last_free;
+	/* Free ram after a cycle of prefetching */
+	unsigned long	current_free;
+	/* Free ram on this cycle of checking prefetch_suitable */
+	unsigned long	prefetch_watermark;
+	/* Maximum amount we will prefetch to */
+	unsigned long	highfree[MAX_NR_ZONES];
+	/* The amount of free ram before we start prefetching */
+	unsigned long	lowfree[MAX_NR_ZONES];
+	/* The amount of free ram where we will stop prefetching */
+	unsigned long	*pointfree[MAX_NR_ZONES];
+	/* highfree or lowfree depending on whether we've hit a watermark */
+};
+
+/*
+ * prefetch_stats stores the free ram data of each node and this is used to
+ * determine if a node is suitable for prefetching into.
+ */
+struct prefetch_stats {
+	nodemask_t	prefetch_nodes;
+	/* Which nodes are currently suited to prefetching */
+	unsigned long	prefetched_pages;
+	/* Total pages we've prefetched on this wakeup of kprefetchd */
+	struct node_stats node[MAX_NUMNODES];
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
+	sp_stat.node[node].last_free--;
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
+	for_each_node_mask(node, sp_stat.prefetch_nodes) {
+		struct node_stats *ns = &sp_stat.node[node];
+
+		ns->last_free = 0;
+	}
+}
+
+static void clear_current_prefetch_free(void)
+{
+	int node;
+
+	sp_stat.prefetch_nodes = node_online_map;
+	for_each_node_mask(node, sp_stat.prefetch_nodes) {
+		struct node_stats *ns = &sp_stat.node[node];
+
+		ns->current_free = 0;
+	}
+}
+
+/*
+ * This updates the high and low watermarks of amount of free ram in each
+ * node used to start and stop prefetching. We prefetch from pages_high * 4
+ * down to pages_high * 3.
+ */
+static void examine_free_limits(void)
+{
+	struct zone *z;
+
+	for_each_zone(z) {
+		struct node_stats *ns;
+		int idx;
+
+		if (!populated_zone(z))
+			continue;
+
+		ns = &sp_stat.node[z->zone_pgdat->node_id];
+		idx = zone_idx(z);
+		ns->lowfree[idx] = z->pages_high * 3 +
+			z->lowmem_reserve[ZONE_HIGHMEM];
+		ns->highfree[idx] = ns->lowfree[idx] + z->pages_high;
+
+		if (z->free_pages > ns->highfree[idx]) {
+			/*
+			 * We've gotten above the high watermark of free pages
+			 * so we can start prefetching till we get to the low
+			 * watermark.
+			 */
+			ns->pointfree[idx] = &ns->lowfree[idx];
+		}
+	}
+}
+
+/*
+ * We want to be absolutely certain it's ok to start prefetching.
+ */
+static int prefetch_suitable(void)
+{
+	unsigned long limit;
+	struct zone *z;
+	int node, ret = 0, test_pagestate = 0;
+
+	/* Purposefully racy */
+	if (test_bit(0, &swapped.busy)) {
+		__clear_bit(0, &swapped.busy);
+		goto out;
+	}
+
+	/*
+	 * get_page_state and above_background_load are expensive so we only
+	 * perform them every SWAP_CLUSTER_MAX prefetched_pages.
+	 * We test to see if we're above_background_load as disk activity
+	 * even at low priority can cause interrupt induced scheduling
+	 * latencies.
+	 */
+	if (!(sp_stat.prefetched_pages % SWAP_CLUSTER_MAX)) {
+		if (above_background_load())
+			goto out;
+		test_pagestate = 1;
+	}
+
+	clear_current_prefetch_free();
+
+	/*
+	 * Have some hysteresis between where page reclaiming and prefetching
+	 * will occur to prevent ping-ponging between them.
+	 */
+	for_each_zone(z) {
+		struct node_stats *ns;
+		unsigned long free;
+		int idx;
+
+		if (!populated_zone(z))
+			continue;
+
+		node = z->zone_pgdat->node_id;
+		ns = &sp_stat.node[node];
+		idx = zone_idx(z);
+
+		free = z->free_pages;
+		if (free < *ns->pointfree[idx]) {
+			/*
+			 * Free pages have dropped below the low watermark so
+			 * we won't start prefetching again till we hit the
+			 * high watermark of free pages.
+			 */
+			ns->pointfree[idx] = &ns->highfree[idx];
+			node_clear(node, sp_stat.prefetch_nodes);
+			continue;
+		}
+		ns->current_free += free;
+	}
+
+	/*
+	 * We iterate over each node testing to see if it is suitable for
+	 * prefetching and clear the nodemask if it is not.
+	 */
+	for_each_node_mask(node, sp_stat.prefetch_nodes) {
+		struct node_stats *ns = &sp_stat.node[node];
+		struct page_state ps;
+
+		/*
+		 * We check to see that pages are not being allocated
+		 * elsewhere at any significant rate implying any
+		 * degree of memory pressure (eg during file reads)
+		 */
+		if (ns->last_free) {
+			if (ns->current_free + SWAP_CLUSTER_MAX <
+			    ns->last_free) {
+				ns->last_free = ns->current_free;
+				node_clear(node,
+					sp_stat.prefetch_nodes);
+				continue;
+			}
+		} else
+			ns->last_free = ns->current_free;
+
+		if (!test_pagestate)
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
+		if (limit > ns->prefetch_watermark) {
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
+ * Get previous swapped entry when iterating over all entries. swapped.lock
+ * should be held and we should already ensure that entry exists.
+ */
+static inline struct swapped_entry *prev_swapped_entry
+	(struct swapped_entry *entry)
+{
+	return list_entry(entry->swapped_list.prev->prev,
+		struct swapped_entry, swapped_list);
+}
+
+/*
+ * trickle_swap is the main function that initiates the swap prefetching. It
+ * first checks to see if the busy flag is set, and does not prefetch if it
+ * is, as the flag implied we are low on memory or swapping in currently.
+ * Otherwise it runs until prefetch_suitable fails which occurs when the
+ * vm is busy, we prefetch to the watermark, or the list is empty or we have
+ * iterated over all entries
+ */
+static enum trickle_return trickle_swap(void)
+{
+	enum trickle_return ret = TRICKLE_DELAY;
+	struct swapped_entry *entry;
+	unsigned long flags;
+
+	/*
+	 * If laptop_mode is enabled don't prefetch to avoid hard drives
+	 * doing unnecessary spin-ups
+	 */
+	if (!swap_prefetch || laptop_mode)
+		return ret;
+
+	examine_free_limits();
+	entry = NULL;
+
+	for ( ; ; ) {
+		swp_entry_t swp_entry;
+		int node;
+
+		if (!prefetch_suitable())
+			break;
+
+		spin_lock_irqsave(&swapped.lock, flags);
+		if (list_empty(&swapped.list)) {
+			ret = TRICKLE_FAILED;
+			spin_unlock_irqrestore(&swapped.lock, flags);
+			break;
+		}
+
+		if (!entry) {
+			/*
+			 * This sets the entry for the first iteration. It
+			 * also is a safeguard against the entry disappearing
+			 * while the lock is not held.
+			 */
+			entry = list_entry(swapped.list.prev,
+				struct swapped_entry, swapped_list);
+		} else if (entry->swapped_list.prev == swapped.list.next) {
+			/*
+			 * If we have iterated over all entries and there are
+			 * still entries that weren't swapped out there may
+			 * be a reason we could not swap them back in so
+			 * delay attempting further prefetching.
+			 */
+			spin_unlock_irqrestore(&swapped.lock, flags);
+			break;
+		}
+
+		node = get_swap_entry_node(entry);
+		if (!node_isset(node, sp_stat.prefetch_nodes)) {
+			/*
+			 * We found an entry that belongs to a node that is
+			 * not suitable for prefetching so skip it.
+			 */
+			entry = prev_swapped_entry(entry);
+			spin_unlock_irqrestore(&swapped.lock, flags);
+			continue;
+		}
+		swp_entry = entry->swp_entry;
+		entry = prev_swapped_entry(entry);
+		spin_unlock_irqrestore(&swapped.lock, flags);
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
+	struct sched_param param = { .sched_priority = 0 };
+
+	sched_setscheduler(current, SCHED_BATCH, &param);
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
+	struct zone *zone;
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
+	for_each_zone(zone) {
+		unsigned long present;
+		struct node_stats *ns;
+		int idx;
+
+		present = zone->present_pages;
+		if (!present)
+			continue;
+
+		ns = &sp_stat.node[zone->zone_pgdat->node_id];
+		ns->prefetch_watermark += present / 3 * 2;
+		idx = zone_idx(zone);
+		ns->pointfree[idx] = &ns->highfree[idx];
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
diff -puN mm/swap_state.c~mm-implement-swap-prefetching mm/swap_state.c
--- devel/mm/swap_state.c~mm-implement-swap-prefetching	2006-06-09 20:58:36.000000000 -0700
+++ devel-akpm/mm/swap_state.c	2006-06-10 01:06:25.000000000 -0700
@@ -10,6 +10,7 @@
 #include <linux/mm.h>
 #include <linux/kernel_stat.h>
 #include <linux/swap.h>
+#include <linux/swap-prefetch.h>
 #include <linux/init.h>
 #include <linux/pagemap.h>
 #include <linux/buffer_head.h>
@@ -82,6 +83,7 @@ static int __add_to_swap_cache(struct pa
 		error = radix_tree_insert(&swapper_space.page_tree,
 						entry.val, page);
 		if (!error) {
+			remove_from_swapped_list(entry.val);
 			page_cache_get(page);
 			SetPageLocked(page);
 			SetPageSwapCache(page);
@@ -95,11 +97,12 @@ static int __add_to_swap_cache(struct pa
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
@@ -148,6 +151,9 @@ int add_to_swap(struct page * page, gfp_
 	swp_entry_t entry;
 	int err;
 
+	/* Swap prefetching is delayed if we're swapping pages */
+	delay_swap_prefetch();
+
 	BUG_ON(!PageLocked(page));
 
 	for (;;) {
@@ -320,6 +326,9 @@ struct page *read_swap_cache_async(swp_e
 	struct page *found_page, *new_page = NULL;
 	int err;
 
+	/* Swap prefetching is delayed if we're already reading from swap */
+	delay_swap_prefetch();
+
 	do {
 		/*
 		 * First check the swap cache.  Since this is normally
diff -puN mm/vmscan.c~mm-implement-swap-prefetching mm/vmscan.c
--- devel/mm/vmscan.c~mm-implement-swap-prefetching	2006-06-09 20:58:36.000000000 -0700
+++ devel-akpm/mm/vmscan.c	2006-06-10 01:06:31.000000000 -0700
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/kernel_stat.h>
 #include <linux/swap.h>
+#include <linux/swap-prefetch.h>
 #include <linux/pagemap.h>
 #include <linux/init.h>
 #include <linux/highmem.h>
@@ -395,6 +396,7 @@ int remove_mapping(struct address_space 
 
 	if (PageSwapCache(page)) {
 		swp_entry_t swap = { .val = page_private(page) };
+		add_to_swapped_list(page);
 		__delete_from_swap_cache(page);
 		write_unlock_irq(&mapping->tree_lock);
 		swap_free(swap);
@@ -975,6 +977,7 @@ unsigned long try_to_free_pages(struct z
 		.swappiness = vm_swappiness,
 	};
 
+	delay_swap_prefetch();
 	count_vm_event(ALLOCSTALL);
 
 	for (i = 0; zones[i] != NULL; i++) {
@@ -1356,6 +1359,8 @@ unsigned long shrink_all_memory(unsigned
 		.swappiness = vm_swappiness,
 	};
 
+	delay_swap_prefetch();
+
 	current->reclaim_state = &reclaim_state;
 
 	lru_pages = 0;
diff -puN /dev/null include/linux/swap-prefetch.h
--- /dev/null	2006-06-03 22:34:36.282200750 -0700
+++ devel-akpm/include/linux/swap-prefetch.h	2006-06-09 20:58:36.000000000 -0700
@@ -0,0 +1,55 @@
+#ifndef SWAP_PREFETCH_H_INCLUDED
+#define SWAP_PREFETCH_H_INCLUDED
+
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
+#endif	/* CONFIG_SWAP_PREFETCH */
+
+#endif		/* SWAP_PREFETCH_H_INCLUDED */
_

