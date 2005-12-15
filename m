Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932623AbVLOAOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932623AbVLOAOh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 19:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932622AbVLOAOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 19:14:37 -0500
Received: from omx3-ext.sgi.com ([192.48.171.25]:14021 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932628AbVLOAOg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 19:14:36 -0500
Date: Wed, 14 Dec 2005 16:14:25 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20051215001425.31405.74009.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051215001415.31405.24898.sendpatchset@schroedinger.engr.sgi.com>
References: <20051215001415.31405.24898.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC3 02/14] Basic counter functionality
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
the zone structure and also globally in the vm_stat array. VM function can
access the counts by simply indexing a global or zone specific array.

The arrangement of counters in an array simplifies processing when output
has to be generated for /proc/*.

Counter updates can be triggered by calling *_zone_page_state or
__*_zone_page_state. The second function can be called if it is known that
interrupts are disabled.

Specially optimized increment and decrement functions are provided. These
can avoid certain checks and use increment or decrement instructions that
an architecture may provide.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc5-mm2/mm/page_alloc.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/mm/page_alloc.c	2005-12-12 15:07:45.000000000 -0800
+++ linux-2.6.15-rc5-mm2/mm/page_alloc.c	2005-12-14 14:57:22.000000000 -0800
@@ -596,7 +596,281 @@ static int rmqueue_bulk(struct zone *zon
 	return i;
 }
 
+/*
+ * Manage combined zone based / global counters
+ */
+#define STAT_THRESHOLD 32
+
+atomic_long_t vm_stat[NR_STAT_ITEMS];
+
+static inline void zone_page_state_consolidate(long x, struct zone *zone, enum zone_stat_item item)
+{
+	atomic_long_add(x, &zone->vm_stat[item]);
+	atomic_long_add(x, &vm_stat[item]);
+}
+
+#ifdef CONFIG_SMP
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
+void __mod_zone_page_state(struct zone *zone, enum zone_stat_item item, int delta)
+{
+	s8 *p;
+	long x;
+
+	p = diff_pointer(zone, item);
+	x = delta + *p;
+
+	if (unlikely(x > STAT_THRESHOLD || x < -STAT_THRESHOLD)) {
+		zone_page_state_consolidate(x, zone, item);
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
+void mod_zone_page_state(struct zone *zone, enum zone_stat_item item, int delta)
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
+	*p++;
+
+	if (unlikely(*p > STAT_THRESHOLD)) {
+		zone_page_state_consolidate(*p, zone, item);
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
+	*p--;
+
+	if (unlikely(*p < -STAT_THRESHOLD)) {
+		zone_page_state_consolidate(*p, zone, item);
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
+	*p++;
+
+	if (unlikely(*p > STAT_THRESHOLD)) {
+		zone_page_state_consolidate(*p, zone, item);
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
+	*p--;
+
+	if (unlikely(*p < -STAT_THRESHOLD)) {
+		zone_page_state_consolidate(*p, zone, item);
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
+		struct per_cpu_pageset *pcp = zone_pcp(zone, raw_smp_processor_id());
+
+		for(i = 0; i < NR_STAT_ITEMS; i++) {
+			int v;
+
+			v = pcp->vm_stat_diff[i];
+			if (v) {
+				pcp->vm_stat_diff[i] = 0;
+				zone_page_state_consolidate(v, zone, i);
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
+ * For use when we know that interrupts are disabled.
+ */
+void __mod_zone_page_state(struct zone *zone, enum zone_stat_item item, int delta)
+{
+	zone_page_state_consolidate(delta, zone, item);
+}
+EXPORT_SYMBOL(__mod_zone_page_state);
+
+/*
+ * For an unknown interrupt state
+ */
+void mod_zone_page_state(struct zone *zone, enum zone_stat_item item, int delta)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	zone_page_state_consolidate(delta, zone, item);
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL(mod_zone_page_state);
+
+void __inc_zone_page_state(const struct page *page, enum zone_stat_item item)
+{
+	struct zone *zone = page_zone(page);
+
+	zone_page_state_consolidate(1, zone, item);
+}
+EXPORT_SYMBOL(__inc_zone_page_state);
+
+void __dec_zone_page_state(const struct page *page, enum zone_stat_item item)
+{
+	struct zone *zone = page_zone(page);
+
+	zone_page_state_consolidate(-1, zone, item);
+}
+EXPORT_SYMBOL(__dec_zone_page_state);
+
+void inc_zone_page_state(const struct page *page, enum zone_stat_item item)
+{
+	unsigned long flags;
+	struct zone *zone;
+
+	local_irq_save(flags);
+	zone = page_zone(page);
+	zone_page_state_consolidate(1, zone, item);
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL(inc_zone_page_state);
+
+void dec_zone_page_state(const struct page *page, enum zone_stat_item item)
+{
+	unsigned long flags;
+	struct zone *zone;
+
+	local_irq_save(flags);
+	zone = page_zone(page);
+	zone_page_state_consolidate(-1, zone, item);
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
+		v += atomic_long_read(&zones[i].vm_stat[item]);
+	if (v < 0)
+		v = 0;
+	return v;
+}
+EXPORT_SYMBOL(node_page_state);
+
 /* Called from the slab reaper to drain remote pagesets */
 void drain_remote_pages(void)
 {
Index: linux-2.6.15-rc5-mm2/include/linux/page-flags.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/linux/page-flags.h	2005-12-12 09:10:34.000000000 -0800
+++ linux-2.6.15-rc5-mm2/include/linux/page-flags.h	2005-12-14 14:45:40.000000000 -0800
@@ -174,6 +174,49 @@ extern void __mod_page_state(unsigned lo
  } while (0)
 
 /*
+ * Zone based accounting with per cpu differentials.
+ */
+extern atomic_long_t vm_stat[NR_STAT_ITEMS];
+
+static inline unsigned long global_page_state(enum zone_stat_item item)
+{
+	long x = atomic_long_read(&vm_stat[item]);
+
+	if (x < 0)
+		x = 0;
+	return x;
+}
+
+static inline unsigned long zone_page_state(struct zone *zone, enum zone_stat_item item)
+{
+	long x = atomic_long_read(&zone->vm_stat[item]);
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
+void __mod_zone_page_state(struct zone *zone, enum zone_stat_item item, int delta);
+void __inc_zone_page_state(const struct page *page, enum zone_stat_item item);
+void __dec_zone_page_state(const struct page *page, enum zone_stat_item item);
+
+#define __add_zone_page_state(zone, item) __mod_zone_page_state(zone, item, delta)
+#define __sub_zone_page_state(zone, item) __mod_zone_page_state(zone, item, -(delta))
+
+void mod_zone_page_state(struct zone *zone, enum zone_stat_item item, int delta);
+void inc_zone_page_state(const struct page *page, enum zone_stat_item item);
+void dec_zone_page_state(const struct page *page, enum zone_stat_item item);
+
+#define add_zone_page_state(zone, item, delta) mod_zone_page_state(zone, item, delta)
+#define sub_zone_page_state(zone, item, delta) mod_zone_page_state(zone, item, -(delta))
+
+/*
  * Manipulation of page state flags
  */
 #define PageLocked(page)		\
Index: linux-2.6.15-rc5-mm2/include/linux/gfp.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/linux/gfp.h	2005-12-12 09:10:34.000000000 -0800
+++ linux-2.6.15-rc5-mm2/include/linux/gfp.h	2005-12-14 14:49:19.000000000 -0800
@@ -160,4 +160,12 @@ void drain_remote_pages(void);
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
Index: linux-2.6.15-rc5-mm2/mm/slab.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/mm/slab.c	2005-12-12 09:10:34.000000000 -0800
+++ linux-2.6.15-rc5-mm2/mm/slab.c	2005-12-14 14:45:40.000000000 -0800
@@ -3423,6 +3423,7 @@ static void cache_reap(void *unused)
 	check_irq_on();
 	up(&cache_chain_sem);
 	drain_remote_pages();
+	refresh_cpu_vm_stats();
 	/* Setup the next iteration */
 	schedule_delayed_work(&__get_cpu_var(reap_work), REAPTIMEOUT_CPUC);
 }
Index: linux-2.6.15-rc5-mm2/include/linux/mmzone.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/linux/mmzone.h	2005-12-12 09:10:34.000000000 -0800
+++ linux-2.6.15-rc5-mm2/include/linux/mmzone.h	2005-12-14 14:46:34.000000000 -0800
@@ -44,6 +44,9 @@ struct zone_padding {
 #define ZONE_PADDING(name)
 #endif
 
+enum zone_stat_item { };
+#define NR_STAT_ITEMS 0
+
 struct per_cpu_pages {
 	int count;		/* number of pages in the list */
 	int high;		/* high watermark, emptying needed */
@@ -53,6 +56,10 @@ struct per_cpu_pages {
 
 struct per_cpu_pageset {
 	struct per_cpu_pages pcp[2];	/* 0: hot.  1: cold */
+#ifdef CONFIG_SMP
+	s8 vm_stat_diff[NR_STAT_ITEMS];
+#endif
+
 #ifdef CONFIG_NUMA
 	unsigned long numa_hit;		/* allocated in intended node */
 	unsigned long numa_miss;	/* allocated in non intended node */
@@ -149,6 +156,8 @@ struct zone {
 	unsigned long		pages_scanned;	   /* since last reclaim */
 	int			all_unreclaimable; /* All pages pinned */
 
+	/* Zone statistics */
+	atomic_long_t		vm_stat[NR_STAT_ITEMS];
 	/*
 	 * Does the allocator try to reclaim pages from the zone as soon
 	 * as it fails a watermark_ok() in __alloc_pages?
