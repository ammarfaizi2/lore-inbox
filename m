Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932708AbVLJA4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932708AbVLJA4G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 19:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932589AbVLJAzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 19:55:44 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:31965 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932669AbVLJAy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 19:54:59 -0500
Date: Fri, 9 Dec 2005 16:54:45 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-mm@kvack.org, Andi Kleen <ak@suse.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20051210005445.3887.94119.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051210005440.3887.34478.sendpatchset@schroedinger.engr.sgi.com>
References: <20051210005440.3887.34478.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC 1/6] Framework
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we have various vm counters that are split per cpu. This arrangement
does not allow access to per zone statistics that are important to optimize
VM behavior for NUMA architectures. All one can say from the per_cpu
differential variables is how much a certain variable was changed by this cpu
without being able to deduce how many pages in each zone are of a certain type.

This framework here implements differential counters for each processor
in struct zone. The differential counters are consolidated when a threshold is
exceeded (like the current implementation for nr_pageache), when slab reaping
occurs or when a consolidation function is called. The consolidation uses atomic
operations and accumulates counters per zone in the zone structure and globally
in the vm_stat array. VM function can access the counts by simply indexing
a global or zone specific array.

The arrangement of counters in an array simplifies processing when output
has to be generated for /proc/*.

Counter updates can be done by calling *_zone_page_state or
__*_zone_page_state. The second function can be called if it is
known that interrupts are disabled.

Contains a hack to get atomic_long_t without really having it.
That hack can be removed when atomic_long is available.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc5/mm/page_alloc.c
===================================================================
--- linux-2.6.15-rc5.orig/mm/page_alloc.c	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/mm/page_alloc.c	2005-12-09 16:34:52.000000000 -0800
@@ -556,7 +556,69 @@ static int rmqueue_bulk(struct zone *zon
 	return allocated;
 }
 
+/*
+ * Manage combined zone based / global counters
+ */
+atomic_long_t vm_stat[NR_STAT_ITEMS];
+
+/*
+ * Update the zone counters for one cpu.
+ * Called from the slab reaper once in awhile.
+ */
+void refresh_cpu_vm_stats(void)
+{
+	struct zone *zone;
+	int i;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	for_each_zone(zone) {
+		struct per_cpu_pageset *pcp = zone_pcp(zone, raw_smp_processor_id());
+
+		for(i = 0; i < NR_STAT_ITEMS; i++) {
+			int v;
+
+			v = pcp->vm_stat_diff[i];
+			if (v) {
+				pcp->vm_stat_diff[i] = 0;
+				atomic_long_add(v, &zone->vm_stat[i]);
+				atomic_long_add(v, &vm_stat[i]);
+			}
+		}
+	}
+	local_irq_restore(flags);
+}
+
+static void __refresh_cpu_vm_stats(void *dummy)
+{
+	refresh_cpu_vm_stats();
+}
+
+/*
+ * Consolidate all counters.
+ *
+ * Note that the result is less inaccurate but still inaccurate
+ * since concurrent processes can increment/decrement counters
+ * while this functions runs.
+ */
+void refresh_vm_stats(void)
+{
+	schedule_on_each_cpu(__refresh_cpu_vm_stats, NULL);
+}
+
+unsigned long node_page_state(int node, enum zone_stat_item item)
+{
+	struct zone *zones = NODE_DATA(node)->node_zones;
+	int i;
+	unsigned long v = 0;
+
+	for (i = 0; i < MAX_NR_ZONES; i++)
+		v += atomic_long_read(&zones[i].vm_stat[item]);
+	return v;
+}
+
 #ifdef CONFIG_NUMA
+
 /* Called from the slab reaper to drain remote pagesets */
 void drain_remote_pages(void)
 {
Index: linux-2.6.15-rc5/include/linux/page-flags.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/page-flags.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/linux/page-flags.h	2005-12-09 16:33:35.000000000 -0800
@@ -163,6 +163,59 @@ extern void __mod_page_state(unsigned lo
 	} while (0)
 
 /*
+ * Zone based accounting with per cpu differentials.
+ */
+#define STAT_THRESHOLD 32
+
+extern atomic_long_t vm_stat[NR_STAT_ITEMS];
+
+#define global_page_state(__x) atomic_long_read(&vm_stat[__x])
+#define zone_page_state(__z,__x) atomic_long_read(&(__z)->vm_stat[__x])
+extern unsigned long node_page_state(int node, enum zone_stat_item);
+
+/*
+ * For use when we know that interrupts are disabled.
+ */
+static inline void __mod_zone_page_state(struct zone *zone, enum zone_stat_item item, int delta)
+{
+	s8 *p;
+	long x;
+
+	p = &zone_pcp(zone, raw_smp_processor_id())->vm_stat_diff[item];
+	x = delta + *p;
+
+	if (unlikely(x > STAT_THRESHOLD || x < -STAT_THRESHOLD)) {
+		atomic_long_add(x, &zone->vm_stat[item]);
+        	atomic_long_add(x, &vm_stat[item]);
+		x = 0;
+	}
+
+	*p = x;
+}
+
+#define __inc_zone_page_state(zone, item) __mod_zone_page_state(zone, item, 1)
+#define __dec_zone_page_state(zone, item) __mod_zone_page_state(zone, item, -1)
+#define __add_zone_page_state(zone, item) __mod_zone_page_state(zone, item, delta)
+#define __sub_zone_page_state(zone, item) __mod_zone_page_state(zone, item, -(delta))
+
+/*
+ * For an unknown interrupt state
+ */
+static inline void mod_zone_page_state(struct zone *zone, enum zone_stat_item item, int delta)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	__mod_zone_page_state(zone, item, delta);
+	local_irq_restore(flags);
+}
+
+#define inc_zone_page_state(zone, item) mod_zone_page_state(zone, item, 1)
+#define dec_zone_page_state(zone, item) mod_zone_page_state(zone, item, -1)
+#define add_zone_page_state(zone, item, delta) mod_zone_page_state(zone, item, delta)
+#define sub_zone_page_state(zone, item, delta) mod_zone_page_state(zone, item, -(delta))
+
+/*
  * Manipulation of page state flags
  */
 #define PageLocked(page)		\
Index: linux-2.6.15-rc5/include/linux/gfp.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/gfp.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/linux/gfp.h	2005-12-09 16:27:13.000000000 -0800
@@ -153,8 +153,12 @@ extern void FASTCALL(free_cold_page(stru
 void page_alloc_init(void);
 #ifdef CONFIG_NUMA
 void drain_remote_pages(void);
+void refresh_cpu_vm_stats(void);
+void refresh_vm_stats(void);
 #else
 static inline void drain_remote_pages(void) { };
+static inline void refresh_cpu_vm_stats(void) { };
+static inline void refresh_vm_stats(void) { };
 #endif
 
 #endif /* __LINUX_GFP_H */
Index: linux-2.6.15-rc5/mm/slab.c
===================================================================
--- linux-2.6.15-rc5.orig/mm/slab.c	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/mm/slab.c	2005-12-09 16:27:13.000000000 -0800
@@ -3359,6 +3359,7 @@ next:
 	check_irq_on();
 	up(&cache_chain_sem);
 	drain_remote_pages();
+	refresh_cpu_vm_stats();
 	/* Setup the next iteration */
 	schedule_delayed_work(&__get_cpu_var(reap_work), REAPTIMEOUT_CPUC);
 }
Index: linux-2.6.15-rc5/include/linux/mmzone.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/mmzone.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/linux/mmzone.h	2005-12-09 16:27:13.000000000 -0800
@@ -44,6 +44,23 @@ struct zone_padding {
 #define ZONE_PADDING(name)
 #endif
 
+enum zone_stat_item { NR_MAPPED, NR_PAGECACHE };
+#define NR_STAT_ITEMS 2
+
+/*
+ * A hacky way of defining atomic long. Remove when
+ * atomic_long_t becomes available.
+ */
+#ifdef CONFIG_64BIT
+#define atomic_long_t atomic64_t
+#define atomic_long_add atomic64_add
+#define atomic_long_read atomic64_read
+#else
+#define atomic_long_t atomic_t
+#define atomic_long_add atomic_add
+#define atomic_long_read atomic_read
+#endif
+
 struct per_cpu_pages {
 	int count;		/* number of pages in the list */
 	int low;		/* low watermark, refill needed */
@@ -54,6 +71,8 @@ struct per_cpu_pages {
 
 struct per_cpu_pageset {
 	struct per_cpu_pages pcp[2];	/* 0: hot.  1: cold */
+	s8 vm_stat_diff[NR_STAT_ITEMS];
+
 #ifdef CONFIG_NUMA
 	unsigned long numa_hit;		/* allocated in intended node */
 	unsigned long numa_miss;	/* allocated in non intended node */
@@ -150,6 +169,8 @@ struct zone {
 	unsigned long		pages_scanned;	   /* since last reclaim */
 	int			all_unreclaimable; /* All pages pinned */
 
+	/* Zone statistics */
+	atomic_long_t		vm_stat[NR_STAT_ITEMS];
 	/*
 	 * Does the allocator try to reclaim pages from the zone as soon
 	 * as it fails a watermark_ok() in __alloc_pages?
@@ -236,7 +257,6 @@ struct zone {
 	char			*name;
 } ____cacheline_maxaligned_in_smp;
 
-
 /*
  * The "priority" of VM scanning is how much of the queues we will scan in one
  * go. A value of 12 for DEF_PRIORITY implies that we will scan 1/4096th of the
