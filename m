Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965105AbVIANql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965105AbVIANql (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 09:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965106AbVIANql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 09:46:41 -0400
Received: from mail09.syd.optusnet.com.au ([211.29.132.190]:4304 "EHLO
	mail09.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S965105AbVIANqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 09:46:40 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH][RFC] vm: swap prefetch
Date: Thu, 1 Sep 2005 23:46:32 +1000
User-Agent: KMail/1.8.2
Cc: Thomas Schlichter <thomas.schlichter@web.de>, ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_5YwFD1Ovl5nZlfP"
Message-Id: <200509012346.33020.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_5YwFD1Ovl5nZlfP
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Here is a working swap prefetching patch for 2.6.13. I have resuscitated and 
rewritten some early prefetch code Thomas Schlichter did in late 2.5 to 
create a configurable kernel thread that reads in swap from ram in reverse 
order it was written out. It does this once kswapd has been idle for a minute 
(implying no current vm stress). This patch attached below is a rollup of two 
patches the current versions of which are here:

http://ck.kolivas.org/patches/swap-prefetch/

These add an exclusive_timer function, and the patch that does the swap 
prefetching. I'm posting this rollup to lkml to see what the interest is in 
this feature, and for people to test it if they desire. I'm planning on 
including it in the next -ck but wanted to gauge general user opinion for 
mainline. Note that swapped in pages are kept on backing store (swap), 
meaning no further I/O is required if the page needs to swap back out.

Cheers,
Con Kolivas


--Boundary-00=_5YwFD1Ovl5nZlfP
Content-Type: text/x-diff;
  charset="us-ascii";
  name="swap_prefetch.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="swap_prefetch.patch"

Index: linux-2.6.13/include/linux/fs.h
===================================================================
--- linux-2.6.13.orig/include/linux/fs.h	2005-09-01 23:24:27.000000000 +1000
+++ linux-2.6.13/include/linux/fs.h	2005-09-01 23:25:07.000000000 +1000
@@ -340,6 +340,8 @@ struct address_space {
 	struct inode		*host;		/* owner: inode, block_device */
 	struct radix_tree_root	page_tree;	/* radix tree of all pages */
 	rwlock_t		tree_lock;	/* and rwlock protecting it */
+	struct radix_tree_root	swap_tree;	/* radix tree of swapped pages */
+	struct list_head	swapped_pages;	/* list of swapped pages */
 	unsigned int		i_mmap_writable;/* count VM_SHARED mappings */
 	struct prio_tree_root	i_mmap;		/* tree of private and shared mappings */
 	struct list_head	i_mmap_nonlinear;/*list VM_NONLINEAR mappings */
Index: linux-2.6.13/include/linux/swap.h
===================================================================
--- linux-2.6.13.orig/include/linux/swap.h	2005-09-01 23:24:27.000000000 +1000
+++ linux-2.6.13/include/linux/swap.h	2005-09-01 23:25:07.000000000 +1000
@@ -206,6 +206,7 @@ extern void free_pages_and_swap_cache(st
 extern struct page * lookup_swap_cache(swp_entry_t);
 extern struct page * read_swap_cache_async(swp_entry_t, struct vm_area_struct *vma,
 					   unsigned long addr);
+extern int add_to_swap_cache(struct page *page, swp_entry_t entry);
 /* linux/mm/swapfile.c */
 extern long total_swap_pages;
 extern unsigned int nr_swapfiles;
@@ -247,6 +248,33 @@ static inline void put_swap_token(struct
 		__put_swap_token(mm);
 }
 
+#ifdef CONFIG_SWAP_PREFETCH
+/*	mm/swap_prefetch.c */
+extern void prepare_prefetch(void);
+extern void add_to_swapped_list(unsigned long index);
+extern void remove_from_swapped_list(unsigned long index);
+extern int trickle_swap(void);
+extern void delay_prefetch_timer(void);
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
+static inline void delay_prefetch_timer(void)
+{
+}
+
+#endif	/* CONFIG_SWAP_PREFETCH */
+
 #else /* CONFIG_SWAP */
 
 #define total_swap_pages			0
Index: linux-2.6.13/include/linux/timer.h
===================================================================
--- linux-2.6.13.orig/include/linux/timer.h	2005-09-01 23:24:27.000000000 +1000
+++ linux-2.6.13/include/linux/timer.h	2005-09-01 23:25:07.000000000 +1000
@@ -53,6 +53,7 @@ extern void add_timer_on(struct timer_li
 extern int del_timer(struct timer_list * timer);
 extern int __mod_timer(struct timer_list *timer, unsigned long expires);
 extern int mod_timer(struct timer_list *timer, unsigned long expires);
+extern int exclusive_timer(struct timer_list *timer, unsigned long expires);
 
 extern unsigned long next_timer_interrupt(void);
 
Index: linux-2.6.13/init/Kconfig
===================================================================
--- linux-2.6.13.orig/init/Kconfig	2005-08-29 13:31:26.000000000 +1000
+++ linux-2.6.13/init/Kconfig	2005-09-01 23:25:07.000000000 +1000
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
Index: linux-2.6.13/kernel/timer.c
===================================================================
--- linux-2.6.13.orig/kernel/timer.c	2005-09-01 23:24:27.000000000 +1000
+++ linux-2.6.13/kernel/timer.c	2005-09-01 23:25:07.000000000 +1000
@@ -329,6 +329,30 @@ int mod_timer(struct timer_list *timer, 
 	return __mod_timer(timer, expires);
 }
 
+/***
+ * exclusive_timer - add a timer only if one doesn't already exist
+ * @timer: the timer to be modified
+ *
+ * This is a safe way to add a timer when multiple concurrent users are
+ * potentially setting a timer, and only one timer is desired.
+ *
+ * The function returns 1 if a timer was added.
+ */
+int exclusive_timer(struct timer_list *timer, unsigned long expires)
+{
+	BUG_ON(!timer->function);
+
+	check_timer(timer);
+	if (timer_pending(timer))
+		return 0;
+
+	/*
+	 * __mod_timer returns the opposite value, and this should always
+	 * return 1
+	 */
+	return (!__mod_timer(timer, expires));
+}
+
 EXPORT_SYMBOL(mod_timer);
 
 /***
Index: linux-2.6.13/mm/Makefile
===================================================================
--- linux-2.6.13.orig/mm/Makefile	2005-08-29 13:31:26.000000000 +1000
+++ linux-2.6.13/mm/Makefile	2005-09-01 23:25:07.000000000 +1000
@@ -13,6 +13,7 @@ obj-y			:= bootmem.o filemap.o mempool.o
 			   prio_tree.o $(mmu-y)
 
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o thrash.o
+obj-$(CONFIG_SWAP_PREFETCH) += swap_prefetch.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
 obj-$(CONFIG_NUMA) 	+= mempolicy.o
 obj-$(CONFIG_SPARSEMEM)	+= sparse.o
Index: linux-2.6.13/mm/swap.c
===================================================================
--- linux-2.6.13.orig/mm/swap.c	2005-09-01 23:24:27.000000000 +1000
+++ linux-2.6.13/mm/swap.c	2005-09-01 23:25:07.000000000 +1000
@@ -481,5 +481,8 @@ void __init swap_setup(void)
 	 * Right now other parts of the system means that we
 	 * _really_ don't want to cluster much more
 	 */
+
+	prepare_prefetch();
+
 	hotcpu_notifier(cpu_swap_callback, 0);
 }
Index: linux-2.6.13/mm/swap_prefetch.c
===================================================================
--- linux-2.6.13.orig/mm/swap_prefetch.c	2005-01-12 16:19:45.000000000 +1100
+++ linux-2.6.13/mm/swap_prefetch.c	2005-09-01 23:25:07.000000000 +1000
@@ -0,0 +1,198 @@
+#include <linux/swap.h>
+#include <linux/fs.h>
+#include <linux/pagemap.h>
+
+#define PREFETCH_DELAY	(HZ * 60)	/* Time kswapd is idle before prefetch */
+#define PREFETCH_INTERVAL (HZ)		/* Time between prefetching */
+
+struct swapped_root_t {
+	spinlock_t		lock;
+	unsigned int		count;
+	unsigned int		maxcount;
+	kmem_cache_t		*cache;
+	struct list_head	list;
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
+		panic("swap_setup(): cannot create swapped_entry SLAB cache");
+
+	/*
+	 * Set max count of swapped entries
+	 */
+	swapped_root.maxcount = nr_free_pagecache_pages();
+	spin_lock_init(&swapped_root.lock);
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
+	if(swapped_root.count >= swapped_root.maxcount) {
+		entry = list_entry(swapped_root.list.next,
+				struct swapped_entry_t, swapped_list);
+		radix_tree_delete(&mapping->swap_tree, entry->swp_entry.val);
+		list_del_init(&entry->swapped_list);
+		swapped_root.count--;
+	} else {
+		entry = kmem_cache_alloc(swapped_root.cache, GFP_ATOMIC);
+		if(!entry)
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
+	int ret = 0;
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
+	ret = 1;
+out:
+	return ret;
+}
+
+int trickle_swap(void)
+{
+	int pages = 0;
+	struct swapped_entry_t *entry;
+
+	while (pages < SWAP_CLUSTER_MAX * 2) {
+		spin_lock(&swapped_root.lock);
+		if (list_empty(&swapped_root.list)) {
+			spin_unlock(&swapped_root.lock);
+			return 0;
+		}
+		entry = list_entry(swapped_root.list.next,
+			struct swapped_entry_t, swapped_list);
+		spin_unlock(&swapped_root.lock);
+
+		if (trickle_swap_cache_async(entry->swp_entry))
+			pages++;
+	}
+	return 1;
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
+		prepare_to_wait(&kprefetchd_wait, &wait, TASK_INTERRUPTIBLE);
+		schedule();
+		finish_wait(&kprefetchd_wait, &wait);
+
+		if (trickle_swap())
+			exclusive_timer(&prefetch_timer, jiffies +
+				PREFETCH_INTERVAL);
+		else
+			exclusive_timer(&prefetch_timer, jiffies +
+				PREFETCH_DELAY);
+	}
+	return 0;
+}
+
+static void prefetch_wakeup(unsigned long data)
+{
+	if (waitqueue_active(&kprefetchd_wait))
+		wake_up_interruptible(&kprefetchd_wait);
+}
+
+static int __init kprefetchd_init(void)
+{
+	init_timer(&prefetch_timer);
+	prefetch_timer.data = 0;
+	prefetch_timer.function = prefetch_wakeup;
+	kernel_thread(kprefetchd, NULL, CLONE_KERNEL);
+	return 0;
+}
+
+module_init(kprefetchd_init)
+
+void delay_prefetch_timer(void)
+{
+	mod_timer(&prefetch_timer, jiffies + PREFETCH_DELAY);
+}
Index: linux-2.6.13/mm/swap_state.c
===================================================================
--- linux-2.6.13.orig/mm/swap_state.c	2005-09-01 23:24:27.000000000 +1000
+++ linux-2.6.13/mm/swap_state.c	2005-09-01 23:25:07.000000000 +1000
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
Index: linux-2.6.13/mm/vmscan.c
===================================================================
--- linux-2.6.13.orig/mm/vmscan.c	2005-09-01 23:24:27.000000000 +1000
+++ linux-2.6.13/mm/vmscan.c	2005-09-01 23:25:07.000000000 +1000
@@ -519,6 +519,7 @@ static int shrink_list(struct list_head 
 #ifdef CONFIG_SWAP
 		if (PageSwapCache(page)) {
 			swp_entry_t swap = { .val = page->private };
+			add_to_swapped_list(swap.val);
 			__delete_from_swap_cache(page);
 			write_unlock_irq(&mapping->tree_lock);
 			swap_free(swap);
@@ -1256,9 +1257,13 @@ void wakeup_kswapd(struct zone *zone, in
 		pgdat->kswapd_max_order = order;
 	if (!cpuset_zone_allowed(zone))
 		return;
-	if (!waitqueue_active(&zone->zone_pgdat->kswapd_wait))
+	if (!waitqueue_active(&pgdat->kswapd_wait))
 		return;
-	wake_up_interruptible(&zone->zone_pgdat->kswapd_wait);
+	
+	/* The prefetch timer is delayed while any kswapd is busy */
+	delay_prefetch_timer();
+
+	wake_up_interruptible(&pgdat->kswapd_wait);
 }
 
 #ifdef CONFIG_PM

--Boundary-00=_5YwFD1Ovl5nZlfP--
