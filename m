Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbWGKS3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbWGKS3y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 14:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWGKS3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 14:29:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11693 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751189AbWGKS3w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 14:29:52 -0400
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Rik van Riel <riel@redhat.com>
Date: Tue, 11 Jul 2006 20:29:43 +0200
Message-Id: <20060711182943.31293.3449.sendpatchset@lappy>
In-Reply-To: <20060711182936.31293.58306.sendpatchset@lappy>
References: <20060711182936.31293.58306.sendpatchset@lappy>
Subject: [PATCH 1/2] mm: nonresident page tracking
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Rik van Riel <riel@redhat.com>

Track non-resident pages through a simple hashing scheme.  This way
the space overhead is limited to 1 u32 per page, or 0.1% space overhead
and lookups are one cache miss.

Aside from seeing whether or not a page was recently evicted, we can
also take a reasonable guess at how many other pages were evicted since
this page was evicted.

NOTE: bucket space also contributes to the total size of the hash.
This way even 64-bit machines with more than 2^32 pages get a fair
chance.

Signed-off-by: Rik van Riel <riel@redhat.com>
Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

 include/linux/nonresident.h |   35 +++++++++
 init/main.c                 |    2 
 mm/Kconfig                  |    4 +
 mm/Makefile                 |    1 
 mm/nonresident.c            |  167 ++++++++++++++++++++++++++++++++++++++++++++
 mm/swap.c                   |    3 
 mm/vmscan.c                 |    3 
 7 files changed, 215 insertions(+)

Index: linux-2.6/mm/nonresident.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/mm/nonresident.c	2006-07-10 19:51:24.000000000 +0200
@@ -0,0 +1,171 @@
+/*
+ * mm/nonresident.c
+ * (C) 2004,2005 Red Hat, Inc
+ * Written by Rik van Riel <riel@redhat.com>
+ * Released under the GPL, see the file COPYING for details.
+ *
+ * Keeps track of whether a non-resident page was recently evicted
+ * and should be immediately promoted to the active list. This also
+ * helps automatically tune the inactive target.
+ *
+ * The pageout code stores a recently evicted page in this cache
+ * by calling remember_page(mapping/mm, index/vaddr, generation)
+ * and can look it up in the cache by calling recently_evicted()
+ * with the same arguments.
+ *
+ * Note that there is no way to invalidate pages after eg. truncate
+ * or exit, we let the pages fall out of the non-resident set through
+ * normal replacement.
+ */
+#include <linux/mm.h>
+#include <linux/cache.h>
+#include <linux/spinlock.h>
+#include <linux/bootmem.h>
+#include <linux/hash.h>
+#include <linux/prefetch.h>
+#include <linux/kernel.h>
+
+/* Number of non-resident pages per hash bucket. Never smaller than 15. */
+#if (L1_CACHE_BYTES < 64)
+#define NR_BUCKET_BYTES 64
+#else
+#define NR_BUCKET_BYTES L1_CACHE_BYTES
+#endif
+#define NUM_NR ((NR_BUCKET_BYTES - sizeof(atomic_t))/sizeof(u32))
+
+struct nr_bucket
+{
+	atomic_t hand;
+	u32 page[NUM_NR];
+} ____cacheline_aligned;
+
+/* The non-resident page hash table. */
+static struct nr_bucket * nonres_table;
+static unsigned int nonres_shift;
+static unsigned int nonres_mask;
+
+static struct nr_bucket * nr_hash(void * mapping, unsigned long index)
+{
+	unsigned long bucket;
+	unsigned long hash;
+
+	hash = hash_ptr(mapping, BITS_PER_LONG);
+	hash = 37 * hash + hash_long(index, BITS_PER_LONG);
+	bucket = hash & nonres_mask;
+
+	return nonres_table + bucket;
+}
+
+static u32 nr_cookie(struct address_space * mapping, unsigned long index)
+{
+	/*
+	 * Different hash magic from bucket selection to insure
+	 * the combined bits extend hash-space.
+	 */
+	unsigned long cookie = hash_long(index, BITS_PER_LONG);
+	cookie = 51 * cookie + hash_ptr(mapping, BITS_PER_LONG);
+
+	if (mapping && mapping->host) {
+		cookie = 37 * cookie + hash_long(mapping->host->i_ino, BITS_PER_LONG);
+	}
+
+	return (u32)(cookie >> (BITS_PER_LONG - 32));
+}
+
+unsigned long nonresident_get(struct address_space * mapping, unsigned long index)
+{
+	struct nr_bucket * nr_bucket;
+	int distance;
+	u32 wanted;
+	int i;
+
+	prefetch(mapping->host);
+	nr_bucket = nr_hash(mapping, index);
+
+	prefetch(nr_bucket);
+	wanted = nr_cookie(mapping, index);
+
+	for (i = 0; i < NUM_NR; i++) {
+		if (nr_bucket->page[i] == wanted) {
+			nr_bucket->page[i] = 0;
+			/* Return the distance between entry and clock hand. */
+			distance = atomic_read(&nr_bucket->hand) + NUM_NR - i;
+			distance %= NUM_NR;
+			return (distance << nonres_shift) + (nr_bucket - nonres_table);
+		}
+	}
+
+	return ~0UL;
+}
+
+u32 nonresident_put(struct address_space * mapping, unsigned long index)
+{
+	struct nr_bucket * nr_bucket;
+	u32 nrpage;
+	int i;
+
+	prefetch(mapping->host);
+	nr_bucket = nr_hash(mapping, index);
+
+	prefetchw(nr_bucket);
+	nrpage = nr_cookie(mapping, index);
+
+	/* Atomically find the next array index. */
+	preempt_disable();
+retry:
+	i = atomic_inc_return(&nr_bucket->hand);
+	if (unlikely(i >= NUM_NR)) {
+		if (i == NUM_NR)
+			atomic_set(&nr_bucket->hand, -1);
+		goto retry;
+	}
+	preempt_enable();
+
+	/* Statistics may want to know whether the entry was in use. */
+	return xchg(&nr_bucket->page[i], nrpage);
+}
+
+unsigned long nonresident_total(void)
+{
+	return NUM_NR << nonres_shift;
+}
+
+/*
+ * For interactive workloads, we remember about as many non-resident pages
+ * as we have actual memory pages.  For server workloads with large inter-
+ * reference distances we could benefit from remembering more.
+ */
+static __initdata unsigned long nonresident_factor = 1;
+void __init nonresident_init(void)
+{
+	int target;
+	int i;
+
+	/*
+	 * Calculate the non-resident hash bucket target. Use a power of
+	 * two for the division because alloc_large_system_hash rounds up.
+	 */
+	target = nr_all_pages * nonresident_factor;
+	target /= (sizeof(struct nr_bucket) / sizeof(u32));
+
+	nonres_table = alloc_large_system_hash("Non-resident page tracking",
+					sizeof(struct nr_bucket),
+					target,
+					0,
+					HASH_EARLY | HASH_HIGHMEM,
+					&nonres_shift,
+					&nonres_mask,
+					0);
+
+	for (i = 0; i < (1 << nonres_shift); i++)
+		atomic_set(&nonres_table[i].hand, 0);
+}
+
+static int __init set_nonresident_factor(char * str)
+{
+	if (!str)
+		return 0;
+	nonresident_factor = simple_strtoul(str, &str, 0);
+	return 1;
+}
+__setup("nonresident_factor=", set_nonresident_factor);
Index: linux-2.6/include/linux/nonresident.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/include/linux/nonresident.h	2006-07-10 19:51:27.000000000 +0200
@@ -0,0 +1,35 @@
+#ifndef _LINUX_NONRESIDENT_H_
+#define _LINUX_NONRESIDENT_H_
+
+#ifdef __KERNEL__
+
+#ifdef CONFIG_MM_NONRESIDENT
+
+extern void nonresident_init(void);
+extern unsigned long nonresident_get(struct address_space *, unsigned long);
+extern u32 nonresident_put(struct address_space *, unsigned long);
+extern unsigned long nonresident_total(void);
+
+#else /* CONFIG_MM_NONRESIDENT */
+
+static inline void nonresident_init(void) { }
+static inline
+unsigned long nonresident_get(struct address_space *, unsigned long, int)
+{
+	return 0;
+}
+
+static inline u32 nonresident_put(struct address_space *, unsigned long)
+{
+	return 0;
+}
+
+static inline unsigned long nonresident_total(void)
+{
+	return 0;
+}
+
+#endif /* CONFIG_MM_NONRESIDENT */
+
+#endif /* __KERNEL */
+#endif /* _LINUX_NONRESIDENT_H_ */
Index: linux-2.6/init/main.c
===================================================================
--- linux-2.6.orig/init/main.c	2006-07-10 19:49:02.000000000 +0200
+++ linux-2.6/init/main.c	2006-07-10 19:49:52.000000000 +0200
@@ -49,6 +49,7 @@
 #include <linux/buffer_head.h>
 #include <linux/debug_locks.h>
 #include <linux/lockdep.h>
+#include <linux/nonresident.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -544,6 +545,7 @@ asmlinkage void __init start_kernel(void
 #endif
 	vfs_caches_init_early();
 	cpuset_init_early();
+	nonresident_init();
 	mem_init();
 	kmem_cache_init();
 	setup_per_cpu_pageset();
Index: linux-2.6/mm/Makefile
===================================================================
--- linux-2.6.orig/mm/Makefile	2006-07-10 19:49:02.000000000 +0200
+++ linux-2.6/mm/Makefile	2006-07-10 19:49:52.000000000 +0200
@@ -13,6 +13,7 @@ obj-y			:= bootmem.o filemap.o mempool.o
 			   prio_tree.o util.o mmzone.o vmstat.o $(mmu-y)
 
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o thrash.o
+obj-$(CONFIG_MM_NONRESIDENT) += nonresident.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
 obj-$(CONFIG_NUMA) 	+= mempolicy.o
 obj-$(CONFIG_SPARSEMEM)	+= sparse.o
Index: linux-2.6/mm/swap.c
===================================================================
--- linux-2.6.orig/mm/swap.c	2006-07-10 19:49:02.000000000 +0200
+++ linux-2.6/mm/swap.c	2006-07-10 19:49:52.000000000 +0200
@@ -30,6 +30,7 @@
 #include <linux/cpu.h>
 #include <linux/notifier.h>
 #include <linux/init.h>
+#include <linux/nonresident.h>
 
 /* How many pages do we try to swap or page in/out together? */
 int page_cluster;
@@ -346,6 +347,7 @@ void __pagevec_lru_add(struct pagevec *p
 		}
 		BUG_ON(PageLRU(page));
 		SetPageLRU(page);
+		nonresident_get(page_mapping(page), page_index(page));
 		add_page_to_inactive_list(zone, page);
 	}
 	if (zone)
@@ -373,6 +375,7 @@ void __pagevec_lru_add_active(struct pag
 		}
 		BUG_ON(PageLRU(page));
 		SetPageLRU(page);
+		nonresident_get(page_mapping(page), page_index(page));
 		BUG_ON(PageActive(page));
 		SetPageActive(page);
 		add_page_to_active_list(zone, page);
Index: linux-2.6/mm/vmscan.c
===================================================================
--- linux-2.6.orig/mm/vmscan.c	2006-07-10 19:49:02.000000000 +0200
+++ linux-2.6/mm/vmscan.c	2006-07-10 19:49:52.000000000 +0200
@@ -35,6 +35,7 @@
 #include <linux/rwsem.h>
 #include <linux/delay.h>
 #include <linux/kthread.h>
+#include <linux/nonresident.h>
 
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -395,6 +396,7 @@ int remove_mapping(struct address_space 
 
 	if (PageSwapCache(page)) {
 		swp_entry_t swap = { .val = page_private(page) };
+		nonresident_put(mapping, page_index(page));
 		__delete_from_swap_cache(page);
 		write_unlock_irq(&mapping->tree_lock);
 		swap_free(swap);
@@ -402,6 +404,7 @@ int remove_mapping(struct address_space 
 		return 1;
 	}
 
+	nonresident_put(mapping, page_index(page));
 	__remove_from_page_cache(page);
 	write_unlock_irq(&mapping->tree_lock);
 	__put_page(page);
Index: linux-2.6/mm/Kconfig
===================================================================
--- linux-2.6.orig/mm/Kconfig	2006-07-10 19:49:02.000000000 +0200
+++ linux-2.6/mm/Kconfig	2006-07-10 19:51:24.000000000 +0200
@@ -152,3 +152,7 @@ config RESOURCES_64BIT
 	default 64BIT
 	help
 	  This option allows memory and IO resources to be 64 bit.
+
+config MM_NONRESIDENT
+	bool "Track nonresident pages"
+	def_bool y

