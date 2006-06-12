Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbWFLVNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbWFLVNb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 17:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbWFLVNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 17:13:12 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:25257 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751517AbWFLVNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 17:13:09 -0400
Date: Mon, 12 Jun 2006 14:12:55 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Con Kolivas <kernel@kolivas.org>, Marcelo Tosatti <marcelo@kvack.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Dave Chinner <dgc@sgi.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20060612211255.20862.39044.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060612211244.20862.41106.sendpatchset@schroedinger.engr.sgi.com>
References: <20060612211244.20862.41106.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 02/21] Basic ZVC (zoned vm counter) implementation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: zoned vm counters: per zone counter functionality
From: Christoph Lameter <clameter@sgi.com>

Per zone counter infrastructure

The counters that we currently have for the VM are split per processor.
The processor however has not much to do with the zone these pages belong
to. We cannot tell f.e. how many ZONE_DMA pages are dirty.

So we are blind to potentially inbalances in the usage of memory in various
zones.  F.e. in a NUMA system we cannot tell how many pages are dirty on
a particular node.  If we knew then we could put measures into the VM to balance
the use of memory between different zones and different nodes in a NUMA
system. For example it would be possible to limit the dirty pages per node
so that fast local memory is kept available even if a process is dirtying
huge amounts of pages.

Another example is zone reclaim.  We do not know how many unmapped pages exist
per zone.  So we just have to try to reclaim.  If it is not working then we
pause and try again later.  It would be better if we knew when it makes sense
to reclaim unmapped pages from a zone.  This patchset allows the determination
of the number of unmapped pages per zone.  We can remove the zone reclaim
interval with the counters introduced here.

Futhermore the ability to have various usage statistics available will allow
the development of new NUMA balancing algorithms that may be able to improve
the decision making in the scheduler of when to move a process to another node
and hopefully will also enable automatic page migration through a user space
program that can analyse the memory load distribution and then rebalance
memory use in order to increase performance.

The counter framework here implements differential counters for each processor
in struct zone.  The differential counters are consolidated when a threshold
is exceeded (like done in the current implementation for nr_pageache), when
slab reaping occurs or when a consolidation function is called.

Consolidation uses atomic operations and accumulates counters per zone in the
zone structure and also globally in the vm_stat array.  VM functions can
access the counts by simply indexing a global or zone specific array.

The arrangement of counters in an array also simplifies processing when output
has to be generated for /proc/*.

Counters can be updated by calling *_zone_page_state or  __*_zone_page_state
analogous to *_page_state. The second group of functions can be called if it
is known that interrupts are disabled.

Special optimized increment and decrement functions are provided.  These can
avoid certain checks and use increment or decrement instructions that an
architecture may provide.

We also add a new CONFIG_DMA_IS_NORMAL that signifies that an architecture
can do DMA to all memory and therefore ZONE_NORMAL will not be populated.
This is only currently set for ia64 and only affects node_page_state(). In
the best case node_page_state can be reduced to retrieving a single counter
for the one zone on the node.

Signed-off-by: Christoph Lameter <clameter@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>

Index: linux-2.6.17-rc6-cl/include/linux/mmzone.h
===================================================================
--- linux-2.6.17-rc6-cl.orig/include/linux/mmzone.h	2006-06-12 12:42:50.753825287 -0700
+++ linux-2.6.17-rc6-cl/include/linux/mmzone.h	2006-06-12 12:54:33.238664762 -0700
@@ -46,6 +46,9 @@ struct zone_padding {
 #define ZONE_PADDING(name)
 #endif
 
+enum zone_stat_item {
+	NR_STAT_ITEMS };
+
 struct per_cpu_pages {
 	int count;		/* number of pages in the list */
 	int high;		/* high watermark, emptying needed */
@@ -55,6 +58,10 @@ struct per_cpu_pages {
 
 struct per_cpu_pageset {
 	struct per_cpu_pages pcp[2];	/* 0: hot.  1: cold */
+#ifdef CONFIG_SMP
+	s8 vm_stat_diff[NR_STAT_ITEMS];
+#endif
+
 #ifdef CONFIG_NUMA
 	unsigned long numa_hit;		/* allocated in intended node */
 	unsigned long numa_miss;	/* allocated in non intended node */
@@ -170,6 +177,8 @@ struct zone {
 	/* A count of how many reclaimers are scanning this zone */
 	atomic_t		reclaim_in_progress;
 
+	/* Zone statistics */
+	atomic_long_t		vm_stat[NR_STAT_ITEMS];
 	/*
 	 * timestamp (in jiffies) of the last zone reclaim that did not
 	 * result in freeing of pages. This is used to avoid repeated scans
Index: linux-2.6.17-rc6-cl/mm/page_alloc.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/page_alloc.c	2006-06-12 12:43:12.087466032 -0700
+++ linux-2.6.17-rc6-cl/mm/page_alloc.c	2006-06-12 12:54:33.240617767 -0700
@@ -2143,6 +2143,7 @@ static void __meminit free_area_init_cor
 		zone->nr_scan_inactive = 0;
 		zone->nr_active = 0;
 		zone->nr_inactive = 0;
+		zap_zone_vm_stats(zone);
 		atomic_set(&zone->reclaim_in_progress, 0);
 		if (!size)
 			continue;
@@ -2254,6 +2255,7 @@ static int page_alloc_cpu_notify(struct 
 		}
 
 		local_irq_enable();
+		refresh_cpu_vm_stats(cpu);
 	}
 	return NOTIFY_OK;
 }
Index: linux-2.6.17-rc6-cl/mm/slab.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/slab.c	2006-06-12 12:42:52.056479050 -0700
+++ linux-2.6.17-rc6-cl/mm/slab.c	2006-06-12 12:54:33.242570771 -0700
@@ -3826,6 +3826,7 @@ next:
 	check_irq_on();
 	mutex_unlock(&cache_chain_mutex);
 	next_reap_node();
+	refresh_cpu_vm_stats(smp_processor_id());
 	/* Set up the next iteration */
 	schedule_delayed_work(&__get_cpu_var(reap_work), REAPTIMEOUT_CPUC);
 }
Index: linux-2.6.17-rc6-cl/include/linux/vmstat.h
===================================================================
--- linux-2.6.17-rc6-cl.orig/include/linux/vmstat.h	2006-06-12 12:43:12.084536526 -0700
+++ linux-2.6.17-rc6-cl/include/linux/vmstat.h	2006-06-12 12:54:33.243547273 -0700
@@ -2,6 +2,9 @@
 #define _LINUX_VMSTAT_H
 
 #include <linux/types.h>
+#include <linux/config.h>
+#include <linux/mmzone.h>
+#include <asm/atomic.h>
 
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
@@ -131,5 +134,84 @@ extern void __mod_page_state_offset(unsi
 	mod_page_state_offset(state_zone_offset(zone, member), (delta)); \
  } while (0)
 
+/*
+ * Zone based page accounting with per cpu differentials.
+ */
+extern atomic_long_t vm_stat[NR_STAT_ITEMS];
+
+static inline unsigned long global_page_state(enum zone_stat_item item)
+{
+	long x = atomic_long_read(&vm_stat[item]);
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
+	long x = atomic_long_read(&zone->vm_stat[item]);
+#ifdef CONFIG_SMP
+	if (x < 0)
+		x = 0;
+#endif
+	return x;
+}
+
+#ifdef CONFIG_NUMA
+/*
+ * Determine the per node value of a stat item. This function
+ * is called frequently in a NUMA machine, so try to be as
+ * frugal as possible.
+ */
+static inline unsigned long node_page_state(int node,
+				 enum zone_stat_item item)
+{
+	struct zone *zones = NODE_DATA(node)->node_zones;
+
+	return
+#ifndef CONFIG_DMA_IS_NORMAL
+#if !defined(CONFIG_DMA_IS_DMA32) && BITS_PER_LONG >= 64
+		zone_page_state(&zones[ZONE_DMA32], item) +
+#endif
+		zone_page_state(&zones[ZONE_NORMAL], item) +
+#endif
+#ifdef CONFIG_HIGHMEM
+		zone_page_state(&zones[ZONE_HIGHMEM], item) +
+#endif
+		zone_page_state(&zones[ZONE_DMA], item);
+}
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
+static inline void zap_zone_vm_stats(struct zone *zone) {
+	memset(zone->vm_stat, 0, sizeof(zone->vm_stat));
+}
+
+#ifdef CONFIG_SMP
+void refresh_cpu_vm_stats(int);
+void refresh_vm_stats(void);
+#else
+static inline void refresh_cpu_vm_stats(int cpu) { }
+static inline void refresh_vm_stats(void) { }
+#endif
+
 #endif /* _LINUX_VMSTAT_H */
 
Index: linux-2.6.17-rc6-cl/arch/ia64/Kconfig
===================================================================
--- linux-2.6.17-rc6-cl.orig/arch/ia64/Kconfig	2006-06-12 12:42:41.828596355 -0700
+++ linux-2.6.17-rc6-cl/arch/ia64/Kconfig	2006-06-12 13:31:07.490528917 -0700
@@ -70,6 +70,10 @@ config DMA_IS_DMA32
 	bool
 	default y
 
+config DMA_IS_NORMAL
+	bool
+	default y
+
 choice
 	prompt "System type"
 	default IA64_GENERIC
Index: linux-2.6.17-rc6-cl/mm/vmstat.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/vmstat.c	2006-06-12 12:51:44.438570245 -0700
+++ linux-2.6.17-rc6-cl/mm/vmstat.c	2006-06-12 13:07:49.853393476 -0700
@@ -3,10 +3,15 @@
  *
  *  Manages VM statistics
  *  Copyright (C) 1991, 1992, 1993, 1994  Linus Torvalds
+ *
+ *  zoned VM statistics
+ *  Copyright (C) 2006 Silicon Graphics, Inc.,
+ *		Christoph Lameter <christoph@lameter.com>
  */
 
 #include <linux/config.h>
 #include <linux/mm.h>
+#include <linux/module.h>
 
 /*
  * Accumulate the page_state information across all CPUs.
@@ -143,6 +148,259 @@ void get_zone_counts(unsigned long *acti
 	}
 }
 
+/*
+ * Manage combined zone based / global counters
+ *
+ * vm_stat contains the global counters
+ */
+atomic_long_t vm_stat[NR_STAT_ITEMS];
+
+static inline void zone_page_state_add(long x, struct zone *zone,
+				 enum zone_stat_item item)
+{
+	atomic_long_add(x, &zone->vm_stat[item]);
+	atomic_long_add(x, &vm_stat[item]);
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
+					int delta)
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
+ 				int delta)
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
 #ifdef CONFIG_PROC_FS
 
 #include <linux/seq_file.h>
@@ -204,6 +462,9 @@ struct seq_operations fragmentation_op =
 };
 
 static char *vmstat_text[] = {
+	/* Zoned VM counters */
+
+	/* Page state */
 	"nr_dirty",
 	"nr_writeback",
 	"nr_unstable",
@@ -297,6 +558,11 @@ static int zoneinfo_show(struct seq_file
 			   zone->nr_scan_active, zone->nr_scan_inactive,
 			   zone->spanned_pages,
 			   zone->present_pages);
+
+		for (i = 0; i < NR_STAT_ITEMS; i++)
+			seq_printf(m, "\n    %-12s %lu", vmstat_text[i],
+					zone_page_state(zone, i));
+
 		seq_printf(m,
 			   "\n        protection: (%lu",
 			   zone->lowmem_reserve[0]);
@@ -368,19 +634,25 @@ struct seq_operations zoneinfo_op = {
 
 static void *vmstat_start(struct seq_file *m, loff_t *pos)
 {
+	unsigned long *v;
 	struct page_state *ps;
+	int i;
 
 	if (*pos >= ARRAY_SIZE(vmstat_text))
 		return NULL;
 
-	ps = kmalloc(sizeof(*ps), GFP_KERNEL);
-	m->private = ps;
-	if (!ps)
+	v = kmalloc(NR_STAT_ITEMS *sizeof(unsigned long)
+			+ sizeof(*ps), GFP_KERNEL);
+	m->private = v;
+	if (!v)
 		return ERR_PTR(-ENOMEM);
+	for (i = 0; i < NR_STAT_ITEMS; i++)
+		v[i] = global_page_state(i);
+	ps = (struct page_state *)(v + NR_STAT_ITEMS);
 	get_full_page_state(ps);
 	ps->pgpgin /= 2;		/* sectors -> kbytes */
 	ps->pgpgout /= 2;
-	return (unsigned long *)ps + *pos;
+	return v + *pos;
 }
 
 static void *vmstat_next(struct seq_file *m, void *arg, loff_t *pos)
