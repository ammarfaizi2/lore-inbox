Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030510AbWBHD3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030510AbWBHD3k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 22:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030484AbWBHD3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 22:29:40 -0500
Received: from mail16.syd.optusnet.com.au ([211.29.132.197]:61650 "EHLO
	mail16.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1030500AbWBHD3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 22:29:38 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] mm: implement swap prefetching v21
Date: Wed, 8 Feb 2006 14:29:09 +1100
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, ck@vds.kolivas.org,
       Nick Piggin <nickpiggin@yahoo.com.au>
References: <200602071028.30721.kernel@kolivas.org> <20060206163842.7ff70c49.akpm@osdl.org>
In-Reply-To: <20060206163842.7ff70c49.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1969586.sdO4zkXB8A";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602081429.11823.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1969586.sdO4zkXB8A
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Ok here is a rewrite incorporating many of the suggested changes by Andrew =
and
Nick (thanks both for comments). The numa and cpuset issues Nick brought up
I have not tackled (yet?)

Cheers,
Con
=2D--
This patch implements swap prefetching when the vm is relatively idle and
there is free ram available. The code is based on some early work by Thomas
Schlichter.

This stores a list of swapped entries in a list ordered most recently used
and a radix tree. It generates a low priority kernel thread running at nice=
 19
to do the prefetching at a later stage.

Once pages have been added to the swapped list, a timer is started, testing
for conditions suitable to prefetch swap pages every 5 seconds. Suitable
conditions are defined as lack of swapping out or in any pages, and no
watermark tests failing. Significant amounts of dirtied ram and changes in
free ram representing disk writes or reads also prevent prefetching.

It then checks that we have spare ram looking for at least 3* pages_high fr=
ee
per zone and if it succeeds that will prefetch pages from swap into the swap
cache. Pages are prefetched until the list is empty or the vm is seen as bu=
sy
according to the previously described criteria.

The pages are copied to swap cache and kept on backing store. This allows
pressure on either physical ram or swap to readily find free pages without
further I/O.

Prefetching can be enabled/disabled via the tunable in=20
/proc/sys/vm/swap_prefetch initially set to 1 (enabled).

In testing on modern pc hardware this results in wall-clock time activation=
 of
the firefox browser to speed up 5 fold after a worst case complete swap-out
of the browser on an static web page.

Signed-off-by: Con Kolivas <kernel@kolivas.org>
=20
 Documentation/sysctl/vm.txt |    8
 include/linux/swap.h        |   29 +++
 include/linux/sysctl.h      |    1
 init/Kconfig                |   22 ++
 kernel/sysctl.c             |   10 +
 mm/Makefile                 |    1
 mm/page_alloc.c             |   10 -
 mm/swap.c                   |    3
 mm/swap_prefetch.c          |  378 +++++++++++++++++++++++++++++++++++++++=
+++++
 mm/swap_state.c             |   10 +
 mm/vmscan.c                 |    5
 11 files changed, 474 insertions(+), 3 deletions(-)

Index: linux-2.6.16-rc2/Documentation/sysctl/vm.txt
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.16-rc2.orig/Documentation/sysctl/vm.txt	2006-02-07 11:02:18=
=2E000000000 +1100
+++ linux-2.6.16-rc2/Documentation/sysctl/vm.txt	2006-02-08 11:23:03.000000=
000 +1100
@@ -29,6 +29,7 @@ Currently, these files are in /proc/sys/
 - drop-caches
 - zone_reclaim_mode
 - zone_reclaim_interval
+- swap_prefetch
=20
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
@@ -178,3 +179,10 @@ Time is set in seconds and set by defaul
 Reduce the interval if undesired off node allocations occur. However, too
 frequent scans will have a negative impact onoff node allocation performan=
ce.
=20
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+swap_prefetch
+
+This enables or disables the swap prefetching feature.
+
+The default value is 1.
Index: linux-2.6.16-rc2/include/linux/swap.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.16-rc2.orig/include/linux/swap.h	2006-02-07 11:02:38.000000=
000 +1100
+++ linux-2.6.16-rc2/include/linux/swap.h	2006-02-08 11:30:06.000000000 +11=
00
@@ -214,6 +214,34 @@ extern int shmem_unuse(swp_entry_t entry
=20
 extern void swap_unplug_io_fn(struct backing_dev_info *, struct page *);
=20
+#ifdef CONFIG_SWAP_PREFETCH
+/* only used by swap prefetch externally */
+/*	mm/swap_prefetch.c */
+extern void prepare_swap_prefetch(void);
+extern void add_to_swapped_list(unsigned long index);
+extern void remove_from_swapped_list(unsigned long index);
+extern void delay_swap_prefetch(void);
+extern int swap_prefetch;
+
+#else	/* CONFIG_SWAP_PREFETCH */
+static inline void add_to_swapped_list(unsigned long index)
+{
+}
+
+static inline void prepare_swap_prefetch(void)
+{
+}
+
+static inline void remove_from_swapped_list(unsigned long index)
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
@@ -235,6 +263,7 @@ extern void free_pages_and_swap_cache(st
 extern struct page * lookup_swap_cache(swp_entry_t);
 extern struct page * read_swap_cache_async(swp_entry_t, struct vm_area_str=
uct *vma,
 					   unsigned long addr);
+extern int add_to_swap_cache(struct page *page, swp_entry_t entry);
 /* linux/mm/swapfile.c */
 extern long total_swap_pages;
 extern unsigned int nr_swapfiles;
Index: linux-2.6.16-rc2/include/linux/sysctl.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.16-rc2.orig/include/linux/sysctl.h	2006-02-07 11:02:38.0000=
00000 +1100
+++ linux-2.6.16-rc2/include/linux/sysctl.h	2006-02-08 11:24:43.000000000 +=
1100
@@ -184,6 +184,7 @@ enum
 	VM_PERCPU_PAGELIST_FRACTION=3D30,/* int: fraction of pages in each percpu=
_pagelist */
 	VM_ZONE_RECLAIM_MODE=3D31, /* reclaim local zone memory before going off =
node */
 	VM_ZONE_RECLAIM_INTERVAL=3D32, /* time period to wait after reclaim failu=
re */
+	VM_SWAP_PREFETCH=3D33,	/* swap prefetch */
 };
=20
=20
Index: linux-2.6.16-rc2/init/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.16-rc2.orig/init/Kconfig	2006-02-07 11:02:39.000000000 +1100
+++ linux-2.6.16-rc2/init/Kconfig	2006-02-08 11:26:24.000000000 +1100
@@ -103,6 +103,28 @@ config SWAP
 	  used to provide more virtual memory than the actual RAM present
 	  in your computer.  If unsure say Y.
=20
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
Index: linux-2.6.16-rc2/kernel/sysctl.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.16-rc2.orig/kernel/sysctl.c	2006-02-07 11:02:39.000000000 +=
1100
+++ linux-2.6.16-rc2/kernel/sysctl.c	2006-02-08 13:51:10.000000000 +1100
@@ -891,6 +891,16 @@ static ctl_table vm_table[] =3D {
 		.strategy	=3D &sysctl_jiffies,
 	},
 #endif
+#ifdef CONFIG_SWAP_PREFETCH
+	{
+		.ctl_name	=3D VM_SWAP_PREFETCH,
+		.procname	=3D "swap_prefetch",
+		.data		=3D &swap_prefetch,
+		.maxlen		=3D sizeof(swap_prefetch),
+		.mode		=3D 0644,
+		.proc_handler	=3D &proc_dointvec,
+	},
+#endif
 	{ .ctl_name =3D 0 }
 };
=20
Index: linux-2.6.16-rc2/mm/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.16-rc2.orig/mm/Makefile	2006-02-07 11:02:39.000000000 +1100
+++ linux-2.6.16-rc2/mm/Makefile	2006-02-08 11:21:09.000000000 +1100
@@ -13,6 +13,7 @@ obj-y			:=3D bootmem.o filemap.o mempool.o
 			   prio_tree.o util.o $(mmu-y)
=20
 obj-$(CONFIG_SWAP)	+=3D page_io.o swap_state.o swapfile.o thrash.o
+obj-$(CONFIG_SWAP_PREFETCH) +=3D swap_prefetch.o
 obj-$(CONFIG_HUGETLBFS)	+=3D hugetlb.o
 obj-$(CONFIG_NUMA) 	+=3D mempolicy.o
 obj-$(CONFIG_SPARSEMEM)	+=3D sparse.o
Index: linux-2.6.16-rc2/mm/page_alloc.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.16-rc2.orig/mm/page_alloc.c	2006-02-07 11:02:39.000000000 +=
1100
+++ linux-2.6.16-rc2/mm/page_alloc.c	2006-02-08 11:29:47.000000000 +1100
@@ -833,7 +833,7 @@ int zone_watermark_ok(struct zone *z, in
 		min -=3D min / 4;
=20
 	if (free_pages <=3D min + z->lowmem_reserve[classzone_idx])
=2D		return 0;
+		goto out_failed;
 	for (o =3D 0; o < order; o++) {
 		/* At the next order, this order's pages become unavailable */
 		free_pages -=3D z->free_area[o].nr_free << o;
@@ -842,9 +842,15 @@ int zone_watermark_ok(struct zone *z, in
 		min >>=3D 1;
=20
 		if (free_pages <=3D min)
=2D			return 0;
+			goto out_failed;
 	}
+
 	return 1;
+out_failed:
+	/* Swap prefetching is delayed if any watermark is low */
+	delay_swap_prefetch();
+
+	return 0;
 }
=20
 /*
Index: linux-2.6.16-rc2/mm/swap.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.16-rc2.orig/mm/swap.c	2006-02-07 11:02:39.000000000 +1100
+++ linux-2.6.16-rc2/mm/swap.c	2006-02-08 11:30:28.000000000 +1100
@@ -502,5 +502,8 @@ void __init swap_setup(void)
 	 * Right now other parts of the system means that we
 	 * _really_ don't want to cluster much more
 	 */
+
+	prepare_swap_prefetch();
+
 	hotcpu_notifier(cpu_swap_callback, 0);
 }
Index: linux-2.6.16-rc2/mm/swap_prefetch.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.16-rc2/mm/swap_prefetch.c	2006-02-08 13:22:44.000000000 +1100
@@ -0,0 +1,378 @@
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
+#include <linux/fs.h>
+#include <linux/swap.h>
+#include <linux/ioprio.h>
+#include <linux/kthread.h>
+#include <linux/pagemap.h>
+#include <linux/syscalls.h>
+#include <linux/writeback.h>
+
+/* Time to delay prefetching if vm is busy or prefetching unsuccessful */
+#define PREFETCH_DELAY	(HZ * 5)
+
+/* sysctl - enable/disable swap prefetching */
+int swap_prefetch __read_mostly =3D 1;
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
+struct swapped_entry {
+	swp_entry_t		swp_entry;
+	struct list_head	swapped_list;
+};
+
+static struct swapped_root swapped =3D {
+	.busy 		=3D 0,			/* Any vm activity */
+	.lock		=3D SPIN_LOCK_UNLOCKED,
+	.list  		=3D LIST_HEAD_INIT(swapped.list),
+	.swap_tree	=3D RADIX_TREE_INIT(GFP_ATOMIC),
+	.count 		=3D 0,			/* Number of swapped entries */
+};
+
+static task_t *kprefetchd_task;
+
+/* Max mapped we will prefetch to */
+static unsigned long mapped_limit __read_mostly;
+
+/*
+ * Create kmem cache for swapped entries
+ */
+void __init prepare_swap_prefetch(void)
+{
+	long mem =3D nr_free_pagecache_pages();
+
+	swapped.cache =3D kmem_cache_create("swapped_entry",
+		sizeof(struct swapped_entry), 0, SLAB_PANIC, NULL, NULL);
+
+	/* Set max number of entries to size of physical ram */
+	swapped.maxcount =3D mem;
+	/* Set maximum amount of mapped pages to prefetch to 2/3 ram */
+	mapped_limit =3D mem / 3 * 2;
+}
+
+/*
+ * We check to see no part of the vm is busy. If it is this will interrupt
+ * trickle_swap and wait another PREFETCH_DELAY. Purposefully racy.
+ */
+inline void delay_swap_prefetch(void)
+{
+	__set_bit(0, &swapped.busy);
+}
+
+/*
+ * Drop behind accounting which keeps a list of the most recently used swap
+ * entries.
+ */
+void add_to_swapped_list(unsigned long index)
+{
+	struct swapped_entry *entry;
+
+	spin_lock(&swapped.lock);
+	if (swapped.count >=3D swapped.maxcount) {
+		/*
+		 * We limit the number of entries to the size of physical ram.
+		 * Once the number of entries exceeds this we start removing
+		 * the least recently used entries.
+		 */
+		entry =3D list_entry(swapped.list.next,
+			struct swapped_entry, swapped_list);
+		radix_tree_delete(&swapped.swap_tree, entry->swp_entry.val);
+		list_del(&entry->swapped_list);
+		swapped.count--;
+	} else {
+		entry =3D kmem_cache_alloc(swapped.cache, GFP_ATOMIC);
+		if (unlikely(!entry))
+			/* bad, can't allocate more mem */
+			goto out_locked;
+	}
+
+	entry->swp_entry.val =3D index;
+
+	if (likely(!radix_tree_insert(&swapped.swap_tree, index, entry))) {
+		/*
+		 * If this is the first entry, kprefetchd needs to be
+		 * (re)started
+		 */
+		if (list_empty(&swapped.list))
+			wake_up_process(kprefetchd_task);
+		list_add(&entry->swapped_list, &swapped.list);
+		swapped.count++;
+	}
+
+out_locked:
+	spin_unlock(&swapped.lock);
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
+	entry =3D radix_tree_delete(&swapped.swap_tree, index);
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
+ * This tries to read a swp_entry_t into swap cache for swap prefetching.
+ * If it returns TRICKLE_DELAY we should delay further prefetching.
+ */
+static enum trickle_return trickle_swap_cache_async(swp_entry_t entry)
+{
+	enum trickle_return ret =3D TRICKLE_FAILED;
+	struct zonelist *zonelist;
+	struct page *page =3D NULL;
+
+	read_lock(&swapper_space.tree_lock);
+	/* Entry may already exist */
+	page =3D radix_tree_lookup(&swapper_space.page_tree, entry.val);
+	read_unlock(&swapper_space.tree_lock);
+	if (page) {
+		remove_from_swapped_list(entry.val);
+		goto out;
+	}
+
+	/*
+	 * Use a default numa policy; anywhere in ram is better than on swap.
+	 * Keeping track of the original process's policy would be
+	 * prohibitively expensive.
+	 */
+	zonelist =3D NODE_DATA(numa_node_id())->node_zonelists +
+		(GFP_HIGHUSER & GFP_ZONEMASK);
+
+	/*
+	 * Get a new page to read from swap. We have already checked the
+	 * watermarks so __alloc_pages will not call on reclaim.
+	 */
+	page =3D __alloc_pages(GFP_HIGHUSER & ~__GFP_WAIT, 0, zonelist);
+	if (unlikely(!page)) {
+		ret =3D TRICKLE_DELAY;
+		goto out;
+	}
+
+	if (add_to_swap_cache(page, entry))
+		/* Failed to add to swap cache */
+		goto out_release;
+
+	lru_cache_add(page);
+	if (unlikely(swap_readpage(NULL, page))) {
+		ret =3D TRICKLE_DELAY;
+		goto out_release;
+	}
+
+	ret =3D TRICKLE_SUCCESS;
+out_release:
+	page_cache_release(page);
+out:
+	return ret;
+}
+
+/*
+ * last_prefetch_free is the amount of free ram after a cycle of prefetchi=
ng
+ * current_free is the amount of free ram on this cycle of checking
+ * prefetch_suitable.
+ */
+static unsigned long last_prefetch_free, current_free, prefetched_pages;
+
+/*
+ * We want to be absolutely certain it's ok to start prefetching.
+ */
+static int prefetch_suitable(void)
+{
+	struct page_state ps;
+	unsigned long limit;
+	struct zone *z;
+	int ret =3D 0;
+
+	/* Purposefully racy and might return false positive which is ok */
+	if (__test_and_clear_bit(0, &swapped.busy))
+		goto out;
+
+	current_free =3D 0;
+	/*
+	 * Have some hysteresis between where page reclaiming and prefetching
+	 * will occur to prevent ping-ponging between them.
+	 */
+	for_each_zone(z) {
+		unsigned long free;
+
+		if (!populated_zone(z))
+			continue;
+		free =3D z->free_pages;
+		if (z->pages_high * 3 > free)
+			goto out;
+		current_free +=3D free;
+	}
+
+	/*
+	 * We check to see that pages are not being allocated elsewhere
+	 * at any significant rate implying any degree of memory pressure
+	 * (eg during file reads)
+	 */
+	if (last_prefetch_free) {
+		if (current_free + SWAP_CLUSTER_MAX < last_prefetch_free) {
+			last_prefetch_free =3D current_free;
+			goto out;
+		}
+	} else
+		last_prefetch_free =3D current_free;
+
+	/*
+	 * get_page_state is super expensive so we only perform it every
+	 * SWAP_CLUSTER_MAX prefetched_pages
+	 */
+	if (prefetched_pages % SWAP_CLUSTER_MAX)
+		goto out_prefetch;
+
+	get_page_state(&ps);
+
+	/* We shouldn't prefetch when we are doing writeback */
+	if (ps.nr_writeback)
+		goto out;
+
+	/*
+	 * >2/3 of the ram is mapped, swapcache or dirty, we need some free
+	 * for pagecache
+	 */
+	limit =3D ps.nr_mapped + ps.nr_slab + ps.nr_dirty + ps.nr_unstable +
+		total_swapcache_pages;
+	if (limit > mapped_limit)
+		goto out;
+
+out_prefetch:
+	/* Survived all that? Hooray we can prefetch! */
+	ret =3D 1;
+out:
+	return ret;
+}
+
+/*
+ * trickle_swap is the main function that initiates the swap prefetching. =
It
+ * first checks to see if the busy flag is set, and does not prefetch if it
+ * is, as the flag implied we are low on memory or swapping in currently.
+ * Otherwise it runs until prefetch_suitable fails which occurs when the
+ * vm is busy, we prefetch to the watermark, or the list is empty.
+ */
+static enum trickle_return trickle_swap(void)
+{
+	enum trickle_return ret =3D TRICKLE_DELAY;
+	struct swapped_entry *entry;
+
+	for ( ; ; ) {
+		enum trickle_return got_page;
+
+		if (!prefetch_suitable())
+			goto out;
+		spin_lock(&swapped.lock);
+		if (list_empty(&swapped.list)) {
+			spin_unlock(&swapped.lock);
+			ret =3D TRICKLE_FAILED;
+			goto out;
+		}
+		entry =3D list_entry(swapped.list.next,
+			struct swapped_entry, swapped_list);
+		spin_unlock(&swapped.lock);
+
+		got_page =3D trickle_swap_cache_async(entry->swp_entry);
+		switch (got_page) {
+		case TRICKLE_FAILED:
+			break;
+		case TRICKLE_SUCCESS:
+			last_prefetch_free--;
+			prefetched_pages++;
+			break;
+		case TRICKLE_DELAY:
+			goto out;
+		}
+	}
+
+out:
+	if (prefetched_pages) {
+		lru_add_drain();
+		prefetched_pages =3D 0;
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
+		enum trickle_return prefetched;
+
+		try_to_freeze();
+
+		/*
+		 * TRICKLE_FAILED implies no entries left - we do not schedule
+		 * a wakeup, and further delay the next one.
+		 */
+		prefetched =3D trickle_swap();
+		switch (prefetched) {
+		case TRICKLE_SUCCESS:
+		case TRICKLE_DELAY:
+			last_prefetch_free =3D 0;
+			schedule_timeout_interruptible(PREFETCH_DELAY);
+			break;
+		case TRICKLE_FAILED:
+			last_prefetch_free =3D 0;
+			schedule_timeout_interruptible(MAX_SCHEDULE_TIMEOUT);
+			schedule_timeout_interruptible(PREFETCH_DELAY);
+			break;
+		}
+	} while (!kthread_should_stop());
+
+	return 0;
+}
+
+static int __init kprefetchd_init(void)
+{
+	kprefetchd_task =3D kthread_run(kprefetchd, NULL, "kprefetchd");
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
Index: linux-2.6.16-rc2/mm/swap_state.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.16-rc2.orig/mm/swap_state.c	2006-02-07 11:02:39.000000000 +=
1100
+++ linux-2.6.16-rc2/mm/swap_state.c	2006-02-08 11:33:05.000000000 +1100
@@ -81,6 +81,7 @@ static int __add_to_swap_cache(struct pa
 		error =3D radix_tree_insert(&swapper_space.page_tree,
 						entry.val, page);
 		if (!error) {
+			remove_from_swapped_list(entry.val);
 			page_cache_get(page);
 			SetPageLocked(page);
 			SetPageSwapCache(page);
@@ -94,11 +95,12 @@ static int __add_to_swap_cache(struct pa
 	return error;
 }
=20
=2Dstatic int add_to_swap_cache(struct page *page, swp_entry_t entry)
+int add_to_swap_cache(struct page *page, swp_entry_t entry)
 {
 	int error;
=20
 	if (!swap_duplicate(entry)) {
+		remove_from_swapped_list(entry.val);
 		INC_CACHE_INFO(noent_race);
 		return -ENOENT;
 	}
@@ -147,6 +149,9 @@ int add_to_swap(struct page * page, gfp_
 	swp_entry_t entry;
 	int err;
=20
+	/* Swap prefetching is delayed if we're swapping pages */
+	delay_swap_prefetch();
+
 	if (!PageLocked(page))
 		BUG();
=20
@@ -320,6 +325,9 @@ struct page *read_swap_cache_async(swp_e
 	struct page *found_page, *new_page =3D NULL;
 	int err;
=20
+	/* Swap prefetching is delayed if we're already reading from swap */
+	delay_swap_prefetch();
+
 	do {
 		/*
 		 * First check the swap cache.  Since this is normally
Index: linux-2.6.16-rc2/mm/vmscan.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.16-rc2.orig/mm/vmscan.c	2006-02-07 11:02:39.000000000 +1100
+++ linux-2.6.16-rc2/mm/vmscan.c	2006-02-08 11:23:32.000000000 +1100
@@ -396,6 +396,7 @@ static int remove_mapping(struct address
=20
 	if (PageSwapCache(page)) {
 		swp_entry_t swap =3D { .val =3D page_private(page) };
+		add_to_swapped_list(swap.val);
 		__delete_from_swap_cache(page);
 		write_unlock_irq(&mapping->tree_lock);
 		swap_free(swap);
@@ -1406,6 +1407,8 @@ int try_to_free_pages(struct zone **zone
 	unsigned long lru_pages =3D 0;
 	int i;
=20
+	delay_swap_prefetch();
+
 	sc.gfp_mask =3D gfp_mask;
 	sc.may_writepage =3D !laptop_mode;
 	sc.may_swap =3D 1;
@@ -1758,6 +1761,8 @@ int shrink_all_memory(int nr_pages)
 		.reclaimed_slab =3D 0,
 	};
=20
+	delay_swap_prefetch();
+
 	current->reclaim_state =3D &reclaim_state;
 	for_each_pgdat(pgdat) {
 		int freed;

--nextPart1969586.sdO4zkXB8A
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBD6WWHZUg7+tp6mRURAh2qAJ4m7KZvnCKdp85jR+OfZnWZI4mWIACfRBuw
srChwKYD292MqXmeMyWQdD4=
=0+Vc
-----END PGP SIGNATURE-----

--nextPart1969586.sdO4zkXB8A--
