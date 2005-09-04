Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750852AbVIDOKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbVIDOKi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 10:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbVIDOKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 10:10:38 -0400
Received: from mail13.syd.optusnet.com.au ([211.29.132.194]:12749 "EHLO
	mail13.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750812AbVIDOKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 10:10:37 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] vm: swap prefetch-1
Date: Mon, 5 Sep 2005 00:13:54 +1000
User-Agent: KMail/1.8.2
Cc: ck@vds.kolivas.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_iEwGDUjc7Gf08lw"
Message-Id: <200509050013.54892.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_iEwGDUjc7Gf08lw
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks to those who tested the swap prefetch code in its first public 
iteration. Here is a respin of the code which improves its behaviour to be 
virtually unnoticable, and fix a couple of bugs that showed up.

Changes:
This version is suspend aware
Swap prefetches are limited to SWAP_CLUSTER_MAX (=128kb) per second
Prefetching is delayed whenever memory watermark limits are missed, or swap is 
going in or out. The delay has been reduced to 5 seconds though.
Memory pressure while in the actual prefetch code will break out of it
The dependence on an new timer interface was abolished
Other cleanups and tweaks

Please test and report back. Assuming no bugs show up in this version, it will 
be included in the next -ck.

The latest patch is available for download from here:

http://ck.kolivas.org/patches/swap-prefetch/

and is attached to this email

Cheers,
Con


--Boundary-00=_iEwGDUjc7Gf08lw
Content-Type: text/x-diff;
  charset="us-ascii";
  name="vm-swap_prefetch-1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="vm-swap_prefetch-1.patch"

This patch implements swap prefetching when the vm is in an idle state.

Add a list of pages that are added to swap. Then use that list when the vm is
idle, as determined by not failing any watermark tests or swapping in/out
pages, to prefetch pages in the most recently used order back into swap cache
with a low priority kernel thread.

Leaving the pages on swap and in swap cache means that if any vm stress is
encountered without using those prefetched pages, the swap cache entries can
be dropped and they are already in swap without needing to be rewritten out.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

 include/linux/fs.h   |    2
 include/linux/swap.h |   27 +++++
 init/Kconfig         |   11 ++
 mm/Makefile          |    1
 mm/page_alloc.c      |   10 +
 mm/swap.c            |    3
 mm/swap_prefetch.c   |  260 +++++++++++++++++++++++++++++++++++++++++++++++++++
 mm/swap_state.c      |   12 ++
 mm/vmscan.c          |    1
 9 files changed, 324 insertions(+), 3 deletions(-)

Index: linux-2.6.13-sp/include/linux/fs.h
===================================================================
--- linux-2.6.13-sp.orig/include/linux/fs.h	2005-09-04 23:53:39.000000000 +1000
+++ linux-2.6.13-sp/include/linux/fs.h	2005-09-04 23:54:04.000000000 +1000
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
--- linux-2.6.13-sp.orig/include/linux/swap.h	2005-09-04 23:53:39.000000000 +1000
+++ linux-2.6.13-sp/include/linux/swap.h	2005-09-04 23:54:04.000000000 +1000
@@ -206,6 +206,7 @@ extern void free_pages_and_swap_cache(st
 extern struct page * lookup_swap_cache(swp_entry_t);
 extern struct page * read_swap_cache_async(swp_entry_t, struct vm_area_struct *vma,
 					   unsigned long addr);
+extern int add_to_swap_cache(struct page *page, swp_entry_t entry);
 /* linux/mm/swapfile.c */
 extern long total_swap_pages;
 extern unsigned int nr_swapfiles;
@@ -247,6 +248,32 @@ static inline void put_swap_token(struct
 		__put_swap_token(mm);
 }
 
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
 #else /* CONFIG_SWAP */
 
 #define total_swap_pages			0
Index: linux-2.6.13-sp/init/Kconfig
===================================================================
--- linux-2.6.13-sp.orig/init/Kconfig	2005-09-04 23:53:39.000000000 +1000
+++ linux-2.6.13-sp/init/Kconfig	2005-09-04 23:54:04.000000000 +1000
@@ -87,6 +87,17 @@ config SWAP
 	  used to provide more virtual memory than the actual RAM present
 	  in your computer.  If unsure say Y.
 
+config SWAP_PREFETCH
+	bool "Support for prefetching swapped memory (EXPERIMENTAL)"
+	depends on SWAP && EXPERIMENTAL
+	default n
+	---help---
+	  This option will allow the kernel to prefetch swapped memory pages
+	  when idle. The pages will be kept on both swap and in swap_cache
+	  thus avoiding the need for further I/O if either ram or swap space
+	  is required. This is desirable on workstations.
+	  Desktop users will most likely want to say Y.
+
 config SYSVIPC
 	bool "System V IPC"
 	depends on MMU
Index: linux-2.6.13-sp/mm/Makefile
===================================================================
--- linux-2.6.13-sp.orig/mm/Makefile	2005-09-04 23:53:39.000000000 +1000
+++ linux-2.6.13-sp/mm/Makefile	2005-09-04 23:54:04.000000000 +1000
@@ -13,6 +13,7 @@ obj-y			:= bootmem.o filemap.o mempool.o
 			   prio_tree.o $(mmu-y)
 
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o thrash.o
+obj-$(CONFIG_SWAP_PREFETCH) += swap_prefetch.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
 obj-$(CONFIG_NUMA) 	+= mempolicy.o
 obj-$(CONFIG_SPARSEMEM)	+= sparse.o
Index: linux-2.6.13-sp/mm/page_alloc.c
===================================================================
--- linux-2.6.13-sp.orig/mm/page_alloc.c	2005-08-30 14:07:46.000000000 +1000
+++ linux-2.6.13-sp/mm/page_alloc.c	2005-09-04 23:54:04.000000000 +1000
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
--- linux-2.6.13-sp.orig/mm/swap.c	2005-09-04 23:53:39.000000000 +1000
+++ linux-2.6.13-sp/mm/swap.c	2005-09-04 23:54:04.000000000 +1000
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
--- linux-2.6.13-sp.orig/mm/swap_prefetch.c	2005-09-04 23:25:26.000000000 +1000
+++ linux-2.6.13-sp/mm/swap_prefetch.c	2005-09-04 23:54:04.000000000 +1000
@@ -0,0 +1,260 @@
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
+/*
+ * Create kmem cache for swapped entries
+ */
+void prepare_prefetch(void)
+{
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
+		if (!entry)
+			goto out_locked;
+	}
+
+	entry->swp_entry.val = index;
+
+	error = radix_tree_preload(GFP_ATOMIC);
+	if (likely(!error)) {
+		error = radix_tree_insert(&mapping->swap_tree, index, entry);
+		if (likely(!error)) {
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
+	if (!new_page)
+		goto out;		/* Out of memory */
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
+ * Otherwise it runs till SWAP_CLUSTER_MAX is prefetched.
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
+		if (list_empty(&swapped_root.list))
+			goto out_unlock;
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
+static inline void reset_prefetch_timer(void)
+{
+	mod_timer(&prefetch_timer, jiffies + PREFETCH_INTERVAL);
+}
+
+static inline void delay_prefetch_timer(void)
+{
+	mod_timer(&prefetch_timer, jiffies + PREFETCH_DELAY);
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
+		try_to_freeze();
+		prepare_to_wait(&kprefetchd_wait, &wait, TASK_INTERRUPTIBLE);
+		schedule();
+		finish_wait(&kprefetchd_wait, &wait);
+
+		if (trickle_swap())
+			reset_prefetch_timer();
+		else
+			delay_prefetch_timer();
+	}
+	return 0;
+}
+
+static void prefetch_wakeup(unsigned long data)
+{
+	pg_data_t *pgdat;
+	int i;
+
+	/* Make sure we really have spare ram before doing any prefetching */
+	for_each_pgdat(pgdat) {
+		for (i = pgdat->nr_zones - 1; i >= 0; i--) {
+			struct zone *z = pgdat->node_zones + i;
+			if (!zone_watermark_ok(z, 0, z->pages_high * 2,
+				0, 0, 0)) {
+					delay_prefetch_timer();
+					return;
+			}
+		}
+	}
+
+	if (waitqueue_active(&kprefetchd_wait))
+		wake_up_interruptible(&kprefetchd_wait);
+}
+
+static int __init kprefetchd_init(void)
+{
+	init_timer(&prefetch_timer);
+	prefetch_timer.data = 0;
+	prefetch_timer.function = prefetch_wakeup;
+	prefetch_timer.expires = jiffies + PREFETCH_DELAY;
+
+	kernel_thread(kprefetchd, NULL, CLONE_KERNEL);
+
+	add_timer(&prefetch_timer);
+
+	return 0;
+}
+
+module_init(kprefetchd_init)
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
Index: linux-2.6.13-sp/mm/swap_state.c
===================================================================
--- linux-2.6.13-sp.orig/mm/swap_state.c	2005-09-04 23:53:39.000000000 +1000
+++ linux-2.6.13-sp/mm/swap_state.c	2005-09-04 23:54:04.000000000 +1000
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
@@ -148,6 +152,9 @@ int add_to_swap(struct page * page)
 	if (!PageLocked(page))
 		BUG();
 
+	/* Swap prefetching is delayed if we're swapping pages */
+	delay_prefetch();
+
 	for (;;) {
 		entry = get_swap_page();
 		if (!entry.val)
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
--- linux-2.6.13-sp.orig/mm/vmscan.c	2005-09-04 23:53:39.000000000 +1000
+++ linux-2.6.13-sp/mm/vmscan.c	2005-09-04 23:54:04.000000000 +1000
@@ -519,6 +519,7 @@ static int shrink_list(struct list_head 
 #ifdef CONFIG_SWAP
 		if (PageSwapCache(page)) {
 			swp_entry_t swap = { .val = page->private };
+			add_to_swapped_list(swap.val);
 			__delete_from_swap_cache(page);
 			write_unlock_irq(&mapping->tree_lock);
 			swap_free(swap);

--Boundary-00=_iEwGDUjc7Gf08lw--
