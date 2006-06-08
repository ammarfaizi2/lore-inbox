Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965057AbWFHXDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965057AbWFHXDp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 19:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965062AbWFHXDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 19:03:20 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:47329 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965057AbWFHXDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 19:03:14 -0400
Date: Thu, 8 Jun 2006 16:02:44 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20060608230244.25121.76440.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060608230239.25121.83503.sendpatchset@schroedinger.engr.sgi.com>
References: <20060608230239.25121.83503.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 01/14] Per zone counter functionality
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Per zone counter infrastructure

The counters that we currently have for the VM are split per processor. They
count the counter increments/decrements occurring per cpu. However, this has
no relation to the pages in use in a zone and we cannot tell f.e. how many
ZONE_DMA pages are dirty. So we are blind to potentially inbalances in the use
of various zones. In a NUMA system we cannot tell what pages are used for
what purpose. If we knew then we could put measures into the VM to balance
the use of memory between different zones and different nodes in a NUMA system.

For example it would be possible to limit the dirty pages per node so that
fast local memory is kept available even if a process is dirtying huge amounts
of pages.

Another example is zone reclaim. We do not know how many unmapped pages
exist per zone. So we just have to try to reclaim. If it is not working
then we pause and try again later. It would be better if we knew when
it makes sense to reclaim unmapped pages from a zone. This patchset allows
the determination of the number of unmapped pages per zone. We can remove
the zone reclaim interval with the counters introduced here.

Futhermore the ability to have various usage statistics available will
allow the development of new NUMA balancing algorithms that may be able
to improve the decisionmaking in the scheduler of when to move a process
to another node and hopefully will also enable automatic page migration
through a user space program that can analyse the memory load distribution
and then rebalance memory use in order to increase performance.

The counter framework here implements differential counters for each processor
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

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-rc6-mm1/include/linux/mmzone.h
===================================================================
--- linux-2.6.17-rc6-mm1.orig/include/linux/mmzone.h	2006-06-08 15:20:10.476033192 -0700
+++ linux-2.6.17-rc6-mm1/include/linux/mmzone.h	2006-06-08 15:42:25.204930191 -0700
@@ -46,6 +46,19 @@ struct zone_padding {
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
@@ -55,6 +68,10 @@ struct per_cpu_pages {
 
 struct per_cpu_pageset {
 	struct per_cpu_pages pcp[2];	/* 0: hot.  1: cold */
+#ifdef CONFIG_SMP
+	s8 vm_stat_diff[NR_STAT_ITEMS];
+#endif
+
 #ifdef CONFIG_NUMA
 	unsigned long numa_hit;		/* allocated in intended node */
 	unsigned long numa_miss;	/* allocated in non intended node */
@@ -170,6 +187,8 @@ struct zone {
 	/* A count of how many reclaimers are scanning this zone */
 	atomic_t		reclaim_in_progress;
 
+	/* Zone statistics */
+	vm_stat_t		vm_stat[NR_STAT_ITEMS];
 	/*
 	 * timestamp (in jiffies) of the last zone reclaim that did not
 	 * result in freeing of pages. This is used to avoid repeated scans
Index: linux-2.6.17-rc6-mm1/include/linux/page-flags.h
===================================================================
--- linux-2.6.17-rc6-mm1.orig/include/linux/page-flags.h	2006-06-08 15:20:10.627391012 -0700
+++ linux-2.6.17-rc6-mm1/include/linux/page-flags.h	2006-06-08 15:42:25.205906693 -0700
@@ -233,6 +233,52 @@ extern void __mod_page_state_offset(unsi
  } while (0)
 
 /*
+ * Zone based accounting with per cpu differentials.
+ */
+extern vm_stat_t vm_stat[NR_STAT_ITEMS];
+
+static inline unsigned long global_page_state(enum zone_stat_item item)
+{
+	long x = VM_STAT_GET(vm_stat[item]);
+#ifdef CONFIG_SMP
+	if (x < 0)
+		x = 0;
+#endif
+	return x;
+}
+
+static inline unsigned long zone_page_state(struct zone *zone,
+					enum zone_stat_item item)
+{
+	long x = VM_STAT_GET(zone->vm_stat[item]);
+#ifdef CONFIG_SMP
+	if (x < 0)
+		x = 0;
+#endif
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
+void __inc_zone_page_state(struct page *, enum zone_stat_item);
+void __dec_zone_page_state(struct page *, enum zone_stat_item);
+
+#define __add_zone_page_state(__z, __i, __d) __mod_zone_page_state(__z, __i, __d)
+#define __sub_zone_page_state(__z, __i, __d) __mod_zone_page_state(__z, __i,-(__d))
+
+void mod_zone_page_state(struct zone *, enum zone_stat_item, int);
+void inc_zone_page_state(struct page *, enum zone_stat_item);
+void dec_zone_page_state(struct page *, enum zone_stat_item);
+
+#define add_zone_page_state(__z, __i, __d) mod_zone_page_state(__z, __i, __d)
+#define sub_zone_page_state(__z, __i, __d) mod_zone_page_state(__z, __i, -(__d))
+
+/*
  * Manipulation of page state flags
  */
 #define PageLocked(page)		\
Index: linux-2.6.17-rc6-mm1/mm/page_alloc.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/page_alloc.c	2006-06-08 15:20:11.552138471 -0700
+++ linux-2.6.17-rc6-mm1/mm/page_alloc.c	2006-06-08 15:43:40.691466807 -0700
@@ -628,8 +628,279 @@ static int rmqueue_bulk(struct zone *zon
 	return i;
 }
 
+/*
+ * Manage combined zone based / global counters
+ *
+ * vm_stat contains the global counters
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
+	return &zone_pcp(zone, smp_processor_id())->vm_stat_diff[item];
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
+void __inc_zone_page_state(struct page *page, enum zone_stat_item item)
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
+void __dec_zone_page_state(struct page *page, enum zone_stat_item item)
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
+void inc_zone_page_state(struct page *page, enum zone_stat_item item)
+{
+	unsigned long flags;
+	struct zone *zone;
+	s8 *p;
+
+	zone = page_zone(page);
+	local_irq_save(flags);
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
+void dec_zone_page_state(struct page *page, enum zone_stat_item item)
+{
+	unsigned long flags;
+	struct zone *zone;
+	s8 *p;
+
+	zone = page_zone(page);
+	local_irq_save(flags);
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
+void refresh_cpu_vm_stats(int cpu)
+{
+	struct zone *zone;
+	int i;
+	unsigned long flags;
+
+	for_each_zone(zone) {
+		struct per_cpu_pageset *pcp;
+
+		pcp = zone_pcp(zone, cpu);
+
+		for (i = 0; i < NR_STAT_ITEMS; i++)
+			if (pcp->vm_stat_diff[i]) {
+				local_irq_save(flags);
+				zone_page_state_add(pcp->vm_stat_diff[i],
+					zone, i);
+				pcp->vm_stat_diff[i] = 0;
+				local_irq_restore(flags);
+			}
+	}
+}
+
+static void __refresh_cpu_vm_stats(void *dummy)
+{
+	refresh_cpu_vm_stats(smp_processor_id());
+}
+
+/*
+ * Consolidate all counters.
+ *
+ * Note that the result is less inaccurate but still inaccurate
+ * if concurrent processes are allowed to run. 
+ */
+void refresh_vm_stats(void)
+{
+	on_each_cpu(__refresh_cpu_vm_stats, NULL, 0, 1);
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
+void __inc_zone_page_state(struct page *page, enum zone_stat_item item)
+{
+	zone_page_state_add(1, page_zone(page), item);
+}
+EXPORT_SYMBOL(__inc_zone_page_state);
+
+void __dec_zone_page_state(struct page *page, enum zone_stat_item item)
+{
+	zone_page_state_add(-1, page_zone(page), item);
+}
+EXPORT_SYMBOL(__dec_zone_page_state);
+
+void inc_zone_page_state(struct page *page, enum zone_stat_item item)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	zone_page_state_add(1, page_zone(page), item);
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL(inc_zone_page_state);
+
+void dec_zone_page_state(struct page *page, enum zone_stat_item item)
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
 /*
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
+/*
  * Called from the slab reaper to drain pagesets on a particular node that
  * belong to the currently executing processor.
  * Note that this function must be called with the thread pinned to
@@ -2278,6 +2549,7 @@ static void __meminit free_area_init_cor
 		zone->nr_scan_inactive = 0;
 		zone->nr_active = 0;
 		zone->nr_inactive = 0;
+		memset(zone->vm_stat, 0, sizeof(zone->vm_stat));
 		atomic_set(&zone->reclaim_in_progress, 0);
 		if (!size)
 			continue;
@@ -2661,7 +2933,8 @@ static int page_alloc_cpu_notify(struct 
 		}
 
 		local_irq_enable();
-	}
+		refresh_cpu_vmstats(cpu);
+	} 
 	return NOTIFY_OK;
 }
 #endif /* CONFIG_HOTPLUG_CPU */
Index: linux-2.6.17-rc6-mm1/include/linux/gfp.h
===================================================================
--- linux-2.6.17-rc6-mm1.orig/include/linux/gfp.h	2006-06-08 15:20:10.249484712 -0700
+++ linux-2.6.17-rc6-mm1/include/linux/gfp.h	2006-06-08 15:43:40.689513803 -0700
@@ -163,4 +163,12 @@ void drain_node_pages(int node);
 static inline void drain_node_pages(int node) { };
 #endif
 
+#ifdef CONFIG_SMP
+void refresh_cpu_vm_stats(int);
+void refresh_vm_stats(void);
+#else
+static inline void refresh_cpu_vm_stats(int cpu) { };
+static inline void refresh_vm_stats(void) { };
+#endif
+
 #endif /* __LINUX_GFP_H */
Index: linux-2.6.17-rc6-mm1/mm/slab.c
===================================================================
--- linux-2.6.17-rc6-mm1.orig/mm/slab.c	2006-06-08 15:20:11.585339541 -0700
+++ linux-2.6.17-rc6-mm1/mm/slab.c	2006-06-08 15:42:25.210789203 -0700
@@ -3826,6 +3826,7 @@ next:
 	check_irq_on();
 	mutex_unlock(&cache_chain_mutex);
 	next_reap_node();
+	refresh_cpu_vm_stats(smp_processor_id());
 	/* Set up the next iteration */
 	schedule_delayed_work(&__get_cpu_var(reap_work), REAPTIMEOUT_CPUC);
 }
