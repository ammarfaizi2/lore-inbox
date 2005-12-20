Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbVLTWCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbVLTWCe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 17:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbVLTWCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 17:02:11 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:10728 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932164AbVLTWCJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 17:02:09 -0500
Date: Tue, 20 Dec 2005 14:02:01 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Christoph Lameter <clameter@sgi.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20051220220201.30326.94308.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051220220151.30326.98563.sendpatchset@schroedinger.engr.sgi.com>
References: <20051220220151.30326.98563.sendpatchset@schroedinger.engr.sgi.com>
Subject: Zoned counters V1 [ 2/14]: Basic counter functionality
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we have various vm counters for the pages in a zone that are split
per cpu. This arrangement does not allow access to per zone statistics that
are important to optimize VM behavior for NUMA architectures. All one can say
from the per cpu differential variables is how much a certain variable was
changed by this cpu without being able to deduce how many pages in each zone
are of a certain type.

This framework here implements differential counters for each processor
in struct zone. The differential counters are consolidated when a threshold
is exceeded (like done in the current implementation for nr_pageache), when
slab reaping occurs or when a consolidation function is called.

Consolidation uses atomic operations and accumulates counters per zone in
the zone structure and also globally in the vm_stat array. VM functions can
access the counts by simply indexing a global or zone specific array.

The arrangement of counters in an array also simplifies processing when output
has to be generated for /proc/*.

Counter updates can be triggered by calling *_zone_page_state or
__*_zone_page_state. The second function can be called if it is known that
interrupts are disabled.

Specially optimized increment and decrement functions are provided. These
can avoid certain checks and use increment or decrement instructions that
an architecture may provide.

Two other patchsets depend on zoned VM stats:
1. Zone reclaim patchset (needs zoned VM stats to determine when to run a
   reclaim scan)
2. event counter patchset. This introduces lightweight counters and
   converts the rest of the page_state.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc5-mm3/include/linux/mmzone.h
===================================================================
--- linux-2.6.15-rc5-mm3.orig/include/linux/mmzone.h	2005-12-16 11:44:09.000000000 -0800
+++ linux-2.6.15-rc5-mm3/include/linux/mmzone.h	2005-12-20 11:58:27.000000000 -0800
@@ -44,6 +44,19 @@ struct zone_padding {
 #define ZONE_PADDING(name)
 #endif
 
+enum zone_stat_item {
+	NR_STAT_ITEMS };
+
+#ifdef CONFIG_SMP
+typedef atomic_long_t vm_stat_t;
+#define VM_STAT_GET(x) atomic_long_read(&(x))
+#define VM_STAT_ADD(x,v) atomic_long_add(v, &(x))
+#else
+typedef unsigned long vm_stat_t;
+#define VM_STAT_GET(x) (x)
+#define VM_STAT_ADD(x,v) (x) += (v)
+#endif
+
 struct per_cpu_pages {
 	int count;		/* number of pages in the list */
 	int high;		/* high watermark, emptying needed */
@@ -53,6 +66,10 @@ struct per_cpu_pages {
 
 struct per_cpu_pageset {
 	struct per_cpu_pages pcp[2];	/* 0: hot.  1: cold */
+#ifdef CONFIG_SMP
+	s8 vm_stat_diff[NR_STAT_ITEMS];
+#endif
+
 #ifdef CONFIG_NUMA
 	unsigned long numa_hit;		/* allocated in intended node */
 	unsigned long numa_miss;	/* allocated in non intended node */
@@ -149,6 +166,8 @@ struct zone {
 	unsigned long		pages_scanned;	   /* since last reclaim */
 	int			all_unreclaimable; /* All pages pinned */
 
+	/* Zone statistics */
+	vm_stat_t		vm_stat[NR_STAT_ITEMS];
 	/*
 	 * Does the allocator try to reclaim pages from the zone as soon
 	 * as it fails a watermark_ok() in __alloc_pages?Index: linux-2.6.15-rc5-mm3/include/linux/page-flags.h
===================================================================
--- linux-2.6.15-rc5-mm3.orig/include/linux/page-flags.h	2005-12-16 11:44:09.000000000 -0800
+++ linux-2.6.15-rc5-mm3/include/linux/page-flags.h	2005-12-20 12:10:14.000000000 -0800
@@ -205,6 +205,50 @@ extern void __mod_page_state_offset(unsi
  } while (0)
 
 /*
+ * Zone based accounting with per cpu differentials.
+ */
+extern vm_stat_t vm_stat[NR_STAT_ITEMS];
+
+static inline unsigned long global_page_state(enum zone_stat_item item)
+{
+	long x = VM_STAT_GET(vm_stat[item]);
+
+	if (x < 0)
+		x = 0;
+	return x;
+}
+
+static inline unsigned long zone_page_state(struct zone *zone,
+					enum zone_stat_item item)
+{
+	long x = VM_STAT_GET(zone->vm_stat[item]);
+
+	if (x < 0)
+		x = 0;
+	return x;
+}
+
+#ifdef CONFIG_NUMA
+unsigned long node_page_state(int node, enum zone_stat_item);
+#else
+#define node_page_state(node, item) global_page_state(item)
+#endif
+
+void __mod_zone_page_state(struct zone *, enum zone_stat_item item, int);
+void __inc_zone_page_state(const struct page *, enum zone_stat_item);
+void __dec_zone_page_state(const struct page *, enum zone_stat_item);
+
+#define __add_zone_page_state(__z, __i, __d) __mod_zone_page_state(__z, __i, __d)
+#define __sub_zone_page_state(__z, __i, __d) __mod_zone_page_state(__z, __i,-(__d))
+
+void mod_zone_page_state(struct zone *, enum zone_stat_item, int);
+void inc_zone_page_state(const struct page *, enum zone_stat_item);
+void dec_zone_page_state(const struct page *, enum zone_stat_item);
+
+#define add_zone_page_state(__z, __i, __d) mod_zone_page_state(__z, __i, __d)
+#define sub_zone_page_state(__z, __i, __d) mod_zone_page_state(__z, __i, -(__d))
+
+/*
  * Manipulation of page state flags
  */
 #define PageLocked(page)		\
Index: linux-2.6.15-rc5-mm3/mm/page_alloc.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/mm/page_alloc.c	2005-12-16 11:44:09.000000000 -0800
+++ linux-2.6.15-rc5-mm3/mm/page_alloc.c	2005-12-20 12:05:56.000000000 -0800
@@ -597,7 +597,279 @@ static int rmqueue_bulk(struct zone *zon
 	return i;
 }
 
+/*
+ * Manage combined zone based / global counters
+ */
+vm_stat_t vm_stat[NR_STAT_ITEMS];
+
+static inline void zone_page_state_add(long x, struct zone *zone,
+				 enum zone_stat_item item)
+{
+	VM_STAT_ADD(zone->vm_stat[item], x);
+	VM_STAT_ADD(vm_stat[item], x);
+}
+
+#ifdef CONFIG_SMP
+
+#define STAT_THRESHOLD 32
+
+/*
+ * Determine pointer to currently valid differential byte given a zone and
+ * the item number.
+ *
+ * Preemption must be off
+ */
+static inline s8 *diff_pointer(struct zone *zone, enum zone_stat_item item)
+{
+	return &zone_pcp(zone, raw_smp_processor_id())->vm_stat_diff[item];
+}
+
+/*
+ * For use when we know that interrupts are disabled.
+ */
+void __mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
+				int delta)
+{
+	s8 *p;
+	long x;
+
+	p = diff_pointer(zone, item);
+	x = delta + *p;
+
+	if (unlikely(x > STAT_THRESHOLD || x < -STAT_THRESHOLD)) {
+		zone_page_state_add(x, zone, item);
+		x = 0;
+	}
+
+	*p = x;
+}
+EXPORT_SYMBOL(__mod_zone_page_state);
+
+/*
+ * For an unknown interrupt state
+ */
+void mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
+				int delta)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	__mod_zone_page_state(zone, item, delta);
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL(mod_zone_page_state);
+
+/*
+ * Optimized increment and decrement functions.
+ *
+ * These are only for a single page and therefore can take a struct page *
+ * argument instead of struct zone *. This allows the inclusion of the code
+ * generated for page_zone(page) into the optimized functions.
+ *
+ * No overflow check is necessary and therefore the differential can be
+ * incremented or decremented in place which may allow the compilers to
+ * generate better code.
+ *
+ * The increment or decrement is known and therefore one boundary check can
+ * be omitted.
+ *
+ * Some processors have inc/dec instructions that are atomic vs an interrupt.
+ * However, the code must first determine the differential location in a zone
+ * based on the processor number and then inc/dec the counter. There is no
+ * guarantee without disabling preemption that the processor will not change
+ * in between and therefore the atomicity vs. interrupt cannot be exploited
+ * in a useful way here.
+ */
+void __inc_zone_page_state(const struct page *page, enum zone_stat_item item)
+{
+	struct zone *zone = page_zone(page);
+	s8 *p = diff_pointer(zone, item);
+
+	(*p)++;
+
+	if (unlikely(*p > STAT_THRESHOLD)) {
+		zone_page_state_add(*p, zone, item);
+		*p = 0;
+	}
+}
+EXPORT_SYMBOL(__inc_zone_page_state);
+
+void __dec_zone_page_state(const struct page *page, enum zone_stat_item item)
+{
+	struct zone *zone = page_zone(page);
+	s8 *p = diff_pointer(zone, item);
+
+	(*p)--;
+
+	if (unlikely(*p < -STAT_THRESHOLD)) {
+		zone_page_state_add(*p, zone, item);
+		*p = 0;
+	}
+}
+EXPORT_SYMBOL(__dec_zone_page_state);
+
+void inc_zone_page_state(const struct page *page, enum zone_stat_item item)
+{
+	unsigned long flags;
+	struct zone *zone;
+	s8 *p;
+
+	local_irq_save(flags);
+	zone = page_zone(page);
+	p = diff_pointer(zone, item);
+
+	(*p)++;
+
+	if (unlikely(*p > STAT_THRESHOLD)) {
+		zone_page_state_add(*p, zone, item);
+		*p = 0;
+	}
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL(inc_zone_page_state);
+
+void dec_zone_page_state(const struct page *page, enum zone_stat_item item)
+{
+	unsigned long flags;
+	struct zone *zone;
+	s8 *p;
+
+	local_irq_save(flags);
+	zone = page_zone(page);
+	p = diff_pointer(zone, item);
+
+	(*p)--;
+
+	if (unlikely(*p < -STAT_THRESHOLD)) {
+		zone_page_state_add(*p, zone, item);
+		*p = 0;
+	}
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL(dec_zone_page_state);
+
+/*
+ * Update the zone counters for one cpu.
+ */
+void refresh_cpu_vm_stats(void)
+{
+	struct zone *zone;
+	int i;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	for_each_zone(zone) {
+		struct per_cpu_pageset *pcp =
+				zone_pcp(zone, raw_smp_processor_id());
+
+		for(i = 0; i < NR_STAT_ITEMS; i++) {
+			int v;
+
+			v = pcp->vm_stat_diff[i];
+			if (v) {
+				pcp->vm_stat_diff[i] = 0;
+				zone_page_state_add(v, zone, i);
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
+EXPORT_SYMBOL(refresh_vm_stats);
+
+#else /* CONFIG_SMP */
+
+/*
+ * We do not maintain differentials in a single processor configuration.
+ * The functions directly modify the zone and global counters.
+ */
+
+void __mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
+				int delta)
+{
+	zone_page_state_add(delta, zone, item);
+}
+EXPORT_SYMBOL(__mod_zone_page_state);
+
+void mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
+				int delta)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	zone_page_state_add(delta, zone, item);
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL(mod_zone_page_state);
+
+void __inc_zone_page_state(const struct page *page, enum zone_stat_item item)
+{
+	zone_page_state_add(1, page_zone(page), item);
+}
+EXPORT_SYMBOL(__inc_zone_page_state);
+
+void __dec_zone_page_state(const struct page *page, enum zone_stat_item item)
+{
+	zone_page_state_add(-1, page_zone(page), item);
+}
+EXPORT_SYMBOL(__dec_zone_page_state);
+
+void inc_zone_page_state(const struct page *page, enum zone_stat_item item)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	zone_page_state_add(1, page_zone(page), item);
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL(inc_zone_page_state);
+
+void dec_zone_page_state(const struct page *page, enum zone_stat_item item)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	zone_page_state_add( -1, page_zone(page), item);
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL(dec_zone_page_state);
+#endif
+
 #ifdef CONFIG_NUMA
+/*
+ * Determine the per node value of a stat item. This is done by cycling
+ * through all the zones of a node.
+ */
+unsigned long node_page_state(int node, enum zone_stat_item item)
+{
+	struct zone *zones = NODE_DATA(node)->node_zones;
+	int i;
+	long v = 0;
+
+	for (i = 0; i < MAX_NR_ZONES; i++)
+		v += VM_STAT_GET(zones[i].vm_stat[item]);
+	if (v < 0)
+		v = 0;
+	return v;
+}
+EXPORT_SYMBOL(node_page_state);
+
 /* Called from the slab reaper to drain remote pagesets */
 void drain_remote_pages(void)
 {
@@ -2169,6 +2441,7 @@ static void __init free_area_init_core(s
 		zone->nr_scan_inactive = 0;
 		zone->nr_active = 0;
 		zone->nr_inactive = 0;
+		memset(zone->vm_stat, 0, sizeof(zone->vm_stat));
 		atomic_set(&zone->reclaim_in_progress, 0);
 		if (!size)
 			continue;
Index: linux-2.6.15-rc5-mm3/include/linux/gfp.h
===================================================================
--- linux-2.6.15-rc5-mm3.orig/include/linux/gfp.h	2005-12-16 11:44:09.000000000 -0800
+++ linux-2.6.15-rc5-mm3/include/linux/gfp.h	2005-12-20 11:58:27.000000000 -0800
@@ -164,4 +164,12 @@ void drain_remote_pages(void);
 static inline void drain_remote_pages(void) { };
 #endif
 
+#ifdef CONFIG_SMP
+void refresh_cpu_vm_stats(void);
+void refresh_vm_stats(void);
+#else
+static inline void refresh_cpu_vm_stats(void) { };
+static inline void refresh_vm_stats(void) { };
+#endif
+
 #endif /* __LINUX_GFP_H */
Index: linux-2.6.15-rc5-mm3/mm/slab.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/mm/slab.c	2005-12-16 11:44:09.000000000 -0800
+++ linux-2.6.15-rc5-mm3/mm/slab.c	2005-12-20 11:58:27.000000000 -0800
@@ -3423,6 +3423,7 @@ static void cache_reap(void *unused)
 	check_irq_on();
 	up(&cache_chain_sem);
 	drain_remote_pages();
+	refresh_cpu_vm_stats();
 	/* Setup the next iteration */
 	schedule_delayed_work(&__get_cpu_var(reap_work), REAPTIMEOUT_CPUC);
 }

