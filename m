Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964835AbWFNBC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbWFNBC4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 21:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964836AbWFNBC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 21:02:56 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:62180 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964835AbWFNBCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 21:02:54 -0400
Date: Tue, 13 Jun 2006 18:02:43 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Con Kolivas <kernel@kolivas.org>,
       Christoph Lameter <clameter@sgi.com>, Dave Chinner <dgc@sgi.com>
Message-Id: <20060614010243.859.45903.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060614010238.859.4228.sendpatchset@schroedinger.engr.sgi.com>
References: <20060614010238.859.4228.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 01/21] Create vmstat.c/.h from page_alloc.c/.h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move counter code from page_alloc.c/page-flags.h to vmstat.c/h.

Create vmstat.c/vmstat.h by separating the counter code and the proc functions.

Move the vm_stat_text array before zoneinfo_show.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-rc6-cl/include/linux/page-flags.h
===================================================================
--- linux-2.6.17-rc6-cl.orig/include/linux/page-flags.h	2006-06-12 12:42:50.853428498 -0700
+++ linux-2.6.17-rc6-cl/include/linux/page-flags.h	2006-06-12 12:43:12.081607020 -0700
@@ -5,11 +5,7 @@
 #ifndef PAGE_FLAGS_H
 #define PAGE_FLAGS_H
 
-#include <linux/percpu.h>
-#include <linux/cache.h>
-#include <linux/types.h>
-
-#include <asm/pgtable.h>
+#include <linux/vmstat.h>
 
 /*
  * Various page->flags bits:
@@ -105,134 +101,6 @@
 #endif
 
 /*
- * Global page accounting.  One instance per CPU.  Only unsigned longs are
- * allowed.
- *
- * - Fields can be modified with xxx_page_state and xxx_page_state_zone at
- * any time safely (which protects the instance from modification by
- * interrupt.
- * - The __xxx_page_state variants can be used safely when interrupts are
- * disabled.
- * - The __xxx_page_state variants can be used if the field is only
- * modified from process context and protected from preemption, or only
- * modified from interrupt context.  In this case, the field should be
- * commented here.
- */
-struct page_state {
-	unsigned long nr_dirty;		/* Dirty writeable pages */
-	unsigned long nr_writeback;	/* Pages under writeback */
-	unsigned long nr_unstable;	/* NFS unstable pages */
-	unsigned long nr_page_table_pages;/* Pages used for pagetables */
-	unsigned long nr_mapped;	/* mapped into pagetables.
-					 * only modified from process context */
-	unsigned long nr_slab;		/* In slab */
-#define GET_PAGE_STATE_LAST nr_slab
-
-	/*
-	 * The below are zeroed by get_page_state().  Use get_full_page_state()
-	 * to add up all these.
-	 */
-	unsigned long pgpgin;		/* Disk reads */
-	unsigned long pgpgout;		/* Disk writes */
-	unsigned long pswpin;		/* swap reads */
-	unsigned long pswpout;		/* swap writes */
-
-	unsigned long pgalloc_high;	/* page allocations */
-	unsigned long pgalloc_normal;
-	unsigned long pgalloc_dma32;
-	unsigned long pgalloc_dma;
-
-	unsigned long pgfree;		/* page freeings */
-	unsigned long pgactivate;	/* pages moved inactive->active */
-	unsigned long pgdeactivate;	/* pages moved active->inactive */
-
-	unsigned long pgfault;		/* faults (major+minor) */
-	unsigned long pgmajfault;	/* faults (major only) */
-
-	unsigned long pgrefill_high;	/* inspected in refill_inactive_zone */
-	unsigned long pgrefill_normal;
-	unsigned long pgrefill_dma32;
-	unsigned long pgrefill_dma;
-
-	unsigned long pgsteal_high;	/* total highmem pages reclaimed */
-	unsigned long pgsteal_normal;
-	unsigned long pgsteal_dma32;
-	unsigned long pgsteal_dma;
-
-	unsigned long pgscan_kswapd_high;/* total highmem pages scanned */
-	unsigned long pgscan_kswapd_normal;
-	unsigned long pgscan_kswapd_dma32;
-	unsigned long pgscan_kswapd_dma;
-
-	unsigned long pgscan_direct_high;/* total highmem pages scanned */
-	unsigned long pgscan_direct_normal;
-	unsigned long pgscan_direct_dma32;
-	unsigned long pgscan_direct_dma;
-
-	unsigned long pginodesteal;	/* pages reclaimed via inode freeing */
-	unsigned long slabs_scanned;	/* slab objects scanned */
-	unsigned long kswapd_steal;	/* pages reclaimed by kswapd */
-	unsigned long kswapd_inodesteal;/* reclaimed via kswapd inode freeing */
-	unsigned long pageoutrun;	/* kswapd's calls to page reclaim */
-	unsigned long allocstall;	/* direct reclaim calls */
-
-	unsigned long pgrotated;	/* pages rotated to tail of the LRU */
-	unsigned long nr_bounce;	/* pages for bounce buffers */
-};
-
-extern void get_page_state(struct page_state *ret);
-extern void get_page_state_node(struct page_state *ret, int node);
-extern void get_full_page_state(struct page_state *ret);
-extern unsigned long read_page_state_offset(unsigned long offset);
-extern void mod_page_state_offset(unsigned long offset, unsigned long delta);
-extern void __mod_page_state_offset(unsigned long offset, unsigned long delta);
-
-#define read_page_state(member) \
-	read_page_state_offset(offsetof(struct page_state, member))
-
-#define mod_page_state(member, delta)	\
-	mod_page_state_offset(offsetof(struct page_state, member), (delta))
-
-#define __mod_page_state(member, delta)	\
-	__mod_page_state_offset(offsetof(struct page_state, member), (delta))
-
-#define inc_page_state(member)		mod_page_state(member, 1UL)
-#define dec_page_state(member)		mod_page_state(member, 0UL - 1)
-#define add_page_state(member,delta)	mod_page_state(member, (delta))
-#define sub_page_state(member,delta)	mod_page_state(member, 0UL - (delta))
-
-#define __inc_page_state(member)	__mod_page_state(member, 1UL)
-#define __dec_page_state(member)	__mod_page_state(member, 0UL - 1)
-#define __add_page_state(member,delta)	__mod_page_state(member, (delta))
-#define __sub_page_state(member,delta)	__mod_page_state(member, 0UL - (delta))
-
-#define page_state(member) (*__page_state(offsetof(struct page_state, member)))
-
-#define state_zone_offset(zone, member)					\
-({									\
-	unsigned offset;						\
-	if (is_highmem(zone))						\
-		offset = offsetof(struct page_state, member##_high);	\
-	else if (is_normal(zone))					\
-		offset = offsetof(struct page_state, member##_normal);	\
-	else if (is_dma32(zone))					\
-		offset = offsetof(struct page_state, member##_dma32);	\
-	else								\
-		offset = offsetof(struct page_state, member##_dma);	\
-	offset;								\
-})
-
-#define __mod_page_state_zone(zone, member, delta)			\
- do {									\
-	__mod_page_state_offset(state_zone_offset(zone, member), (delta)); \
- } while (0)
-
-#define mod_page_state_zone(zone, member, delta)			\
- do {									\
-	mod_page_state_offset(state_zone_offset(zone, member), (delta)); \
- } while (0)
-
-/*
  * Manipulation of page state flags
  */
 #define PageLocked(page)		\
Index: linux-2.6.17-rc6-cl/mm/Makefile
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/Makefile	2006-06-12 12:42:52.028160490 -0700
+++ linux-2.6.17-rc6-cl/mm/Makefile	2006-06-12 12:43:12.082583522 -0700
@@ -10,7 +10,7 @@ mmu-$(CONFIG_MMU)	:= fremap.o highmem.o 
 obj-y			:= bootmem.o filemap.o mempool.o oom_kill.o fadvise.o \
 			   page_alloc.o page-writeback.o pdflush.o \
 			   readahead.o swap.o truncate.o vmscan.o \
-			   prio_tree.o util.o mmzone.o $(mmu-y)
+			   prio_tree.o util.o mmzone.o vmstat.o $(mmu-y)
 
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o thrash.o
 obj-$(CONFIG_SWAP_PREFETCH) += swap_prefetch.o
Index: linux-2.6.17-rc6-cl/include/linux/mm.h
===================================================================
--- linux-2.6.17-rc6-cl.orig/include/linux/mm.h	2006-06-12 12:42:50.747966275 -0700
+++ linux-2.6.17-rc6-cl/include/linux/mm.h	2006-06-12 12:43:12.083560024 -0700
@@ -4,6 +4,7 @@
 #include <linux/sched.h>
 #include <linux/errno.h>
 #include <linux/capability.h>
+#include <linux/vmstat.h>
 
 #ifdef __KERNEL__
 
@@ -37,7 +38,6 @@ extern int sysctl_legacy_va_layout;
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/processor.h>
-#include <asm/atomic.h>
 
 #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
 
Index: linux-2.6.17-rc6-cl/include/linux/vmstat.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.17-rc6-cl/include/linux/vmstat.h	2006-06-12 12:43:12.084536526 -0700
@@ -0,0 +1,135 @@
+#ifndef _LINUX_VMSTAT_H
+#define _LINUX_VMSTAT_H
+
+#include <linux/types.h>
+
+/*
+ * Global page accounting.  One instance per CPU.  Only unsigned longs are
+ * allowed.
+ *
+ * - Fields can be modified with xxx_page_state and xxx_page_state_zone at
+ * any time safely (which protects the instance from modification by
+ * interrupt.
+ * - The __xxx_page_state variants can be used safely when interrupts are
+ * disabled.
+ * - The __xxx_page_state variants can be used if the field is only
+ * modified from process context and protected from preemption, or only
+ * modified from interrupt context.  In this case, the field should be
+ * commented here.
+ */
+struct page_state {
+	unsigned long nr_dirty;		/* Dirty writeable pages */
+	unsigned long nr_writeback;	/* Pages under writeback */
+	unsigned long nr_unstable;	/* NFS unstable pages */
+	unsigned long nr_page_table_pages;/* Pages used for pagetables */
+	unsigned long nr_mapped;	/* mapped into pagetables.
+					 * only modified from process context */
+	unsigned long nr_slab;		/* In slab */
+#define GET_PAGE_STATE_LAST nr_slab
+
+	/*
+	 * The below are zeroed by get_page_state().  Use get_full_page_state()
+	 * to add up all these.
+	 */
+	unsigned long pgpgin;		/* Disk reads */
+	unsigned long pgpgout;		/* Disk writes */
+	unsigned long pswpin;		/* swap reads */
+	unsigned long pswpout;		/* swap writes */
+
+	unsigned long pgalloc_high;	/* page allocations */
+	unsigned long pgalloc_normal;
+	unsigned long pgalloc_dma32;
+	unsigned long pgalloc_dma;
+
+	unsigned long pgfree;		/* page freeings */
+	unsigned long pgactivate;	/* pages moved inactive->active */
+	unsigned long pgdeactivate;	/* pages moved active->inactive */
+
+	unsigned long pgfault;		/* faults (major+minor) */
+	unsigned long pgmajfault;	/* faults (major only) */
+
+	unsigned long pgrefill_high;	/* inspected in refill_inactive_zone */
+	unsigned long pgrefill_normal;
+	unsigned long pgrefill_dma32;
+	unsigned long pgrefill_dma;
+
+	unsigned long pgsteal_high;	/* total highmem pages reclaimed */
+	unsigned long pgsteal_normal;
+	unsigned long pgsteal_dma32;
+	unsigned long pgsteal_dma;
+
+	unsigned long pgscan_kswapd_high;/* total highmem pages scanned */
+	unsigned long pgscan_kswapd_normal;
+	unsigned long pgscan_kswapd_dma32;
+	unsigned long pgscan_kswapd_dma;
+
+	unsigned long pgscan_direct_high;/* total highmem pages scanned */
+	unsigned long pgscan_direct_normal;
+	unsigned long pgscan_direct_dma32;
+	unsigned long pgscan_direct_dma;
+
+	unsigned long pginodesteal;	/* pages reclaimed via inode freeing */
+	unsigned long slabs_scanned;	/* slab objects scanned */
+	unsigned long kswapd_steal;	/* pages reclaimed by kswapd */
+	unsigned long kswapd_inodesteal;/* reclaimed via kswapd inode freeing */
+	unsigned long pageoutrun;	/* kswapd's calls to page reclaim */
+	unsigned long allocstall;	/* direct reclaim calls */
+
+	unsigned long pgrotated;	/* pages rotated to tail of the LRU */
+	unsigned long nr_bounce;	/* pages for bounce buffers */
+};
+
+extern void get_page_state(struct page_state *ret);
+extern void get_page_state_node(struct page_state *ret, int node);
+extern void get_full_page_state(struct page_state *ret);
+extern unsigned long read_page_state_offset(unsigned long offset);
+extern void mod_page_state_offset(unsigned long offset, unsigned long delta);
+extern void __mod_page_state_offset(unsigned long offset, unsigned long delta);
+
+#define read_page_state(member) \
+	read_page_state_offset(offsetof(struct page_state, member))
+
+#define mod_page_state(member, delta)	\
+	mod_page_state_offset(offsetof(struct page_state, member), (delta))
+
+#define __mod_page_state(member, delta)	\
+	__mod_page_state_offset(offsetof(struct page_state, member), (delta))
+
+#define inc_page_state(member)		mod_page_state(member, 1UL)
+#define dec_page_state(member)		mod_page_state(member, 0UL - 1)
+#define add_page_state(member,delta)	mod_page_state(member, (delta))
+#define sub_page_state(member,delta)	mod_page_state(member, 0UL - (delta))
+
+#define __inc_page_state(member)	__mod_page_state(member, 1UL)
+#define __dec_page_state(member)	__mod_page_state(member, 0UL - 1)
+#define __add_page_state(member,delta)	__mod_page_state(member, (delta))
+#define __sub_page_state(member,delta)	__mod_page_state(member, 0UL - (delta))
+
+#define page_state(member) (*__page_state(offsetof(struct page_state, member)))
+
+#define state_zone_offset(zone, member)					\
+({									\
+	unsigned offset;						\
+	if (is_highmem(zone))						\
+		offset = offsetof(struct page_state, member##_high);	\
+	else if (is_normal(zone))					\
+		offset = offsetof(struct page_state, member##_normal);	\
+	else if (is_dma32(zone))					\
+		offset = offsetof(struct page_state, member##_dma32);	\
+	else								\
+		offset = offsetof(struct page_state, member##_dma);	\
+	offset;								\
+})
+
+#define __mod_page_state_zone(zone, member, delta)			\
+ do {									\
+	__mod_page_state_offset(state_zone_offset(zone, member), (delta)); \
+ } while (0)
+
+#define mod_page_state_zone(zone, member, delta)			\
+ do {									\
+	mod_page_state_offset(state_zone_offset(zone, member), (delta)); \
+ } while (0)
+
+#endif /* _LINUX_VMSTAT_H */
+
Index: linux-2.6.17-rc6-cl/mm/vmstat.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.17-rc6-cl/mm/vmstat.c	2006-06-12 12:51:44.438570245 -0700
@@ -0,0 +1,417 @@
+/*
+ *  linux/mm/vmstat.c
+ *
+ *  Manages VM statistics
+ *  Copyright (C) 1991, 1992, 1993, 1994  Linus Torvalds
+ */
+
+#include <linux/config.h>
+#include <linux/mm.h>
+
+/*
+ * Accumulate the page_state information across all CPUs.
+ * The result is unavoidably approximate - it can change
+ * during and after execution of this function.
+ */
+static DEFINE_PER_CPU(struct page_state, page_states) = {0};
+
+atomic_t nr_pagecache = ATOMIC_INIT(0);
+EXPORT_SYMBOL(nr_pagecache);
+#ifdef CONFIG_SMP
+DEFINE_PER_CPU(long, nr_pagecache_local) = 0;
+#endif
+
+static void __get_page_state(struct page_state *ret, int nr, cpumask_t *cpumask)
+{
+	unsigned cpu;
+
+	memset(ret, 0, nr * sizeof(unsigned long));
+	cpus_and(*cpumask, *cpumask, cpu_online_map);
+
+	for_each_cpu_mask(cpu, *cpumask) {
+		unsigned long *in;
+		unsigned long *out;
+		unsigned off;
+		unsigned next_cpu;
+
+		in = (unsigned long *)&per_cpu(page_states, cpu);
+
+		next_cpu = next_cpu(cpu, *cpumask);
+		if (likely(next_cpu < NR_CPUS))
+			prefetch(&per_cpu(page_states, next_cpu));
+
+		out = (unsigned long *)ret;
+		for (off = 0; off < nr; off++)
+			*out++ += *in++;
+	}
+}
+
+void get_page_state_node(struct page_state *ret, int node)
+{
+	int nr;
+	cpumask_t mask = node_to_cpumask(node);
+
+	nr = offsetof(struct page_state, GET_PAGE_STATE_LAST);
+	nr /= sizeof(unsigned long);
+
+	__get_page_state(ret, nr+1, &mask);
+}
+
+void get_page_state(struct page_state *ret)
+{
+	int nr;
+	cpumask_t mask = CPU_MASK_ALL;
+
+	nr = offsetof(struct page_state, GET_PAGE_STATE_LAST);
+	nr /= sizeof(unsigned long);
+
+	__get_page_state(ret, nr + 1, &mask);
+}
+
+void get_full_page_state(struct page_state *ret)
+{
+	cpumask_t mask = CPU_MASK_ALL;
+
+	__get_page_state(ret, sizeof(*ret) / sizeof(unsigned long), &mask);
+}
+
+unsigned long read_page_state_offset(unsigned long offset)
+{
+	unsigned long ret = 0;
+	int cpu;
+
+	for_each_online_cpu(cpu) {
+		unsigned long in;
+
+		in = (unsigned long)&per_cpu(page_states, cpu) + offset;
+		ret += *((unsigned long *)in);
+	}
+	return ret;
+}
+
+void __mod_page_state_offset(unsigned long offset, unsigned long delta)
+{
+	void *ptr;
+
+	ptr = &__get_cpu_var(page_states);
+	*(unsigned long *)(ptr + offset) += delta;
+}
+EXPORT_SYMBOL(__mod_page_state_offset);
+
+void mod_page_state_offset(unsigned long offset, unsigned long delta)
+{
+	unsigned long flags;
+	void *ptr;
+
+	local_irq_save(flags);
+	ptr = &__get_cpu_var(page_states);
+	*(unsigned long *)(ptr + offset) += delta;
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL(mod_page_state_offset);
+
+void __get_zone_counts(unsigned long *active, unsigned long *inactive,
+			unsigned long *free, struct pglist_data *pgdat)
+{
+	struct zone *zones = pgdat->node_zones;
+	int i;
+
+	*active = 0;
+	*inactive = 0;
+	*free = 0;
+	for (i = 0; i < MAX_NR_ZONES; i++) {
+		*active += zones[i].nr_active;
+		*inactive += zones[i].nr_inactive;
+		*free += zones[i].free_pages;
+	}
+}
+
+void get_zone_counts(unsigned long *active,
+		unsigned long *inactive, unsigned long *free)
+{
+	struct pglist_data *pgdat;
+
+	*active = 0;
+	*inactive = 0;
+	*free = 0;
+	for_each_online_pgdat(pgdat) {
+		unsigned long l, m, n;
+		__get_zone_counts(&l, &m, &n, pgdat);
+		*active += l;
+		*inactive += m;
+		*free += n;
+	}
+}
+
+#ifdef CONFIG_PROC_FS
+
+#include <linux/seq_file.h>
+
+static void *frag_start(struct seq_file *m, loff_t *pos)
+{
+	pg_data_t *pgdat;
+	loff_t node = *pos;
+	for (pgdat = first_online_pgdat();
+	     pgdat && node;
+	     pgdat = next_online_pgdat(pgdat))
+		--node;
+
+	return pgdat;
+}
+
+static void *frag_next(struct seq_file *m, void *arg, loff_t *pos)
+{
+	pg_data_t *pgdat = (pg_data_t *)arg;
+
+	(*pos)++;
+	return next_online_pgdat(pgdat);
+}
+
+static void frag_stop(struct seq_file *m, void *arg)
+{
+}
+
+/*
+ * This walks the free areas for each zone.
+ */
+static int frag_show(struct seq_file *m, void *arg)
+{
+	pg_data_t *pgdat = (pg_data_t *)arg;
+	struct zone *zone;
+	struct zone *node_zones = pgdat->node_zones;
+	unsigned long flags;
+	int order;
+
+	for (zone = node_zones; zone - node_zones < MAX_NR_ZONES; ++zone) {
+		if (!populated_zone(zone))
+			continue;
+
+		spin_lock_irqsave(&zone->lock, flags);
+		seq_printf(m, "Node %d, zone %8s ", pgdat->node_id, zone->name);
+		for (order = 0; order < MAX_ORDER; ++order)
+			seq_printf(m, "%6lu ", zone->free_area[order].nr_free);
+		spin_unlock_irqrestore(&zone->lock, flags);
+		seq_putc(m, '\n');
+	}
+	return 0;
+}
+
+struct seq_operations fragmentation_op = {
+	.start	= frag_start,
+	.next	= frag_next,
+	.stop	= frag_stop,
+	.show	= frag_show,
+};
+
+static char *vmstat_text[] = {
+	"nr_dirty",
+	"nr_writeback",
+	"nr_unstable",
+	"nr_page_table_pages",
+	"nr_mapped",
+	"nr_slab",
+
+	"pgpgin",
+	"pgpgout",
+	"pswpin",
+	"pswpout",
+
+	"pgalloc_high",
+	"pgalloc_normal",
+	"pgalloc_dma32",
+	"pgalloc_dma",
+
+	"pgfree",
+	"pgactivate",
+	"pgdeactivate",
+
+	"pgfault",
+	"pgmajfault",
+
+	"pgrefill_high",
+	"pgrefill_normal",
+	"pgrefill_dma32",
+	"pgrefill_dma",
+
+	"pgsteal_high",
+	"pgsteal_normal",
+	"pgsteal_dma32",
+	"pgsteal_dma",
+
+	"pgscan_kswapd_high",
+	"pgscan_kswapd_normal",
+	"pgscan_kswapd_dma32",
+	"pgscan_kswapd_dma",
+
+	"pgscan_direct_high",
+	"pgscan_direct_normal",
+	"pgscan_direct_dma32",
+	"pgscan_direct_dma",
+
+	"pginodesteal",
+	"slabs_scanned",
+	"kswapd_steal",
+	"kswapd_inodesteal",
+	"pageoutrun",
+	"allocstall",
+
+	"pgrotated",
+	"nr_bounce",
+};
+
+/*
+ * Output information about zones in @pgdat.
+ */
+static int zoneinfo_show(struct seq_file *m, void *arg)
+{
+	pg_data_t *pgdat = arg;
+	struct zone *zone;
+	struct zone *node_zones = pgdat->node_zones;
+	unsigned long flags;
+
+	for (zone = node_zones; zone - node_zones < MAX_NR_ZONES; zone++) {
+		int i;
+
+		if (!populated_zone(zone))
+			continue;
+
+		spin_lock_irqsave(&zone->lock, flags);
+		seq_printf(m, "Node %d, zone %8s", pgdat->node_id, zone->name);
+		seq_printf(m,
+			   "\n  pages free     %lu"
+			   "\n        min      %lu"
+			   "\n        low      %lu"
+			   "\n        high     %lu"
+			   "\n        active   %lu"
+			   "\n        inactive %lu"
+			   "\n        scanned  %lu (a: %lu i: %lu)"
+			   "\n        spanned  %lu"
+			   "\n        present  %lu",
+			   zone->free_pages,
+			   zone->pages_min,
+			   zone->pages_low,
+			   zone->pages_high,
+			   zone->nr_active,
+			   zone->nr_inactive,
+			   zone->pages_scanned,
+			   zone->nr_scan_active, zone->nr_scan_inactive,
+			   zone->spanned_pages,
+			   zone->present_pages);
+		seq_printf(m,
+			   "\n        protection: (%lu",
+			   zone->lowmem_reserve[0]);
+		for (i = 1; i < ARRAY_SIZE(zone->lowmem_reserve); i++)
+			seq_printf(m, ", %lu", zone->lowmem_reserve[i]);
+		seq_printf(m,
+			   ")"
+			   "\n  pagesets");
+		for_each_online_cpu(i) {
+			struct per_cpu_pageset *pageset;
+			int j;
+
+			pageset = zone_pcp(zone, i);
+			for (j = 0; j < ARRAY_SIZE(pageset->pcp); j++) {
+				if (pageset->pcp[j].count)
+					break;
+			}
+			if (j == ARRAY_SIZE(pageset->pcp))
+				continue;
+			for (j = 0; j < ARRAY_SIZE(pageset->pcp); j++) {
+				seq_printf(m,
+					   "\n    cpu: %i pcp: %i"
+					   "\n              count: %i"
+					   "\n              high:  %i"
+					   "\n              batch: %i",
+					   i, j,
+					   pageset->pcp[j].count,
+					   pageset->pcp[j].high,
+					   pageset->pcp[j].batch);
+			}
+#ifdef CONFIG_NUMA
+			seq_printf(m,
+				   "\n            numa_hit:       %lu"
+				   "\n            numa_miss:      %lu"
+				   "\n            numa_foreign:   %lu"
+				   "\n            interleave_hit: %lu"
+				   "\n            local_node:     %lu"
+				   "\n            other_node:     %lu",
+				   pageset->numa_hit,
+				   pageset->numa_miss,
+				   pageset->numa_foreign,
+				   pageset->interleave_hit,
+				   pageset->local_node,
+				   pageset->other_node);
+#endif
+		}
+		seq_printf(m,
+			   "\n  all_unreclaimable: %u"
+			   "\n  prev_priority:     %i"
+			   "\n  temp_priority:     %i"
+			   "\n  start_pfn:         %lu",
+			   zone->all_unreclaimable,
+			   zone->prev_priority,
+			   zone->temp_priority,
+			   zone->zone_start_pfn);
+		spin_unlock_irqrestore(&zone->lock, flags);
+		seq_putc(m, '\n');
+	}
+	return 0;
+}
+
+struct seq_operations zoneinfo_op = {
+	.start	= frag_start, /* iterate over all zones. The same as in
+			       * fragmentation. */
+	.next	= frag_next,
+	.stop	= frag_stop,
+	.show	= zoneinfo_show,
+};
+
+static void *vmstat_start(struct seq_file *m, loff_t *pos)
+{
+	struct page_state *ps;
+
+	if (*pos >= ARRAY_SIZE(vmstat_text))
+		return NULL;
+
+	ps = kmalloc(sizeof(*ps), GFP_KERNEL);
+	m->private = ps;
+	if (!ps)
+		return ERR_PTR(-ENOMEM);
+	get_full_page_state(ps);
+	ps->pgpgin /= 2;		/* sectors -> kbytes */
+	ps->pgpgout /= 2;
+	return (unsigned long *)ps + *pos;
+}
+
+static void *vmstat_next(struct seq_file *m, void *arg, loff_t *pos)
+{
+	(*pos)++;
+	if (*pos >= ARRAY_SIZE(vmstat_text))
+		return NULL;
+	return (unsigned long *)m->private + *pos;
+}
+
+static int vmstat_show(struct seq_file *m, void *arg)
+{
+	unsigned long *l = arg;
+	unsigned long off = l - (unsigned long *)m->private;
+
+	seq_printf(m, "%s %lu\n", vmstat_text[off], *l);
+	return 0;
+}
+
+static void vmstat_stop(struct seq_file *m, void *arg)
+{
+	kfree(m->private);
+	m->private = NULL;
+}
+
+struct seq_operations vmstat_op = {
+	.start	= vmstat_start,
+	.next	= vmstat_next,
+	.stop	= vmstat_stop,
+	.show	= vmstat_show,
+};
+
+#endif /* CONFIG_PROC_FS */
+
Index: linux-2.6.17-rc6-cl/mm/page_alloc.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/page_alloc.c	2006-06-12 12:42:52.042808021 -0700
+++ linux-2.6.17-rc6-cl/mm/page_alloc.c	2006-06-12 12:43:12.087466032 -0700
@@ -1306,141 +1306,6 @@ static void show_node(struct zone *zone)
 #endif
 
 /*
- * Accumulate the page_state information across all CPUs.
- * The result is unavoidably approximate - it can change
- * during and after execution of this function.
- */
-static DEFINE_PER_CPU(struct page_state, page_states) = {0};
-
-atomic_t nr_pagecache = ATOMIC_INIT(0);
-EXPORT_SYMBOL(nr_pagecache);
-#ifdef CONFIG_SMP
-DEFINE_PER_CPU(long, nr_pagecache_local) = 0;
-#endif
-
-static void __get_page_state(struct page_state *ret, int nr, cpumask_t *cpumask)
-{
-	unsigned cpu;
-
-	memset(ret, 0, nr * sizeof(unsigned long));
-	cpus_and(*cpumask, *cpumask, cpu_online_map);
-
-	for_each_cpu_mask(cpu, *cpumask) {
-		unsigned long *in;
-		unsigned long *out;
-		unsigned off;
-		unsigned next_cpu;
-
-		in = (unsigned long *)&per_cpu(page_states, cpu);
-
-		next_cpu = next_cpu(cpu, *cpumask);
-		if (likely(next_cpu < NR_CPUS))
-			prefetch(&per_cpu(page_states, next_cpu));
-
-		out = (unsigned long *)ret;
-		for (off = 0; off < nr; off++)
-			*out++ += *in++;
-	}
-}
-
-void get_page_state_node(struct page_state *ret, int node)
-{
-	int nr;
-	cpumask_t mask = node_to_cpumask(node);
-
-	nr = offsetof(struct page_state, GET_PAGE_STATE_LAST);
-	nr /= sizeof(unsigned long);
-
-	__get_page_state(ret, nr+1, &mask);
-}
-
-void get_page_state(struct page_state *ret)
-{
-	int nr;
-	cpumask_t mask = CPU_MASK_ALL;
-
-	nr = offsetof(struct page_state, GET_PAGE_STATE_LAST);
-	nr /= sizeof(unsigned long);
-
-	__get_page_state(ret, nr + 1, &mask);
-}
-
-void get_full_page_state(struct page_state *ret)
-{
-	cpumask_t mask = CPU_MASK_ALL;
-
-	__get_page_state(ret, sizeof(*ret) / sizeof(unsigned long), &mask);
-}
-
-unsigned long read_page_state_offset(unsigned long offset)
-{
-	unsigned long ret = 0;
-	int cpu;
-
-	for_each_online_cpu(cpu) {
-		unsigned long in;
-
-		in = (unsigned long)&per_cpu(page_states, cpu) + offset;
-		ret += *((unsigned long *)in);
-	}
-	return ret;
-}
-
-void __mod_page_state_offset(unsigned long offset, unsigned long delta)
-{
-	void *ptr;
-
-	ptr = &__get_cpu_var(page_states);
-	*(unsigned long *)(ptr + offset) += delta;
-}
-EXPORT_SYMBOL(__mod_page_state_offset);
-
-void mod_page_state_offset(unsigned long offset, unsigned long delta)
-{
-	unsigned long flags;
-	void *ptr;
-
-	local_irq_save(flags);
-	ptr = &__get_cpu_var(page_states);
-	*(unsigned long *)(ptr + offset) += delta;
-	local_irq_restore(flags);
-}
-EXPORT_SYMBOL(mod_page_state_offset);
-
-void __get_zone_counts(unsigned long *active, unsigned long *inactive,
-			unsigned long *free, struct pglist_data *pgdat)
-{
-	struct zone *zones = pgdat->node_zones;
-	int i;
-
-	*active = 0;
-	*inactive = 0;
-	*free = 0;
-	for (i = 0; i < MAX_NR_ZONES; i++) {
-		*active += zones[i].nr_active;
-		*inactive += zones[i].nr_inactive;
-		*free += zones[i].free_pages;
-	}
-}
-
-void get_zone_counts(unsigned long *active,
-		unsigned long *inactive, unsigned long *free)
-{
-	struct pglist_data *pgdat;
-
-	*active = 0;
-	*inactive = 0;
-	*free = 0;
-	for_each_online_pgdat(pgdat) {
-		unsigned long l, m, n;
-		__get_zone_counts(&l, &m, &n, pgdat);
-		*active += l;
-		*inactive += m;
-		*free += n;
-	}
-}
-
-/*
  * The node's effective length of inactive_list(s).
  */
 unsigned long nr_free_inactive_pages_node(int nid)
@@ -2360,278 +2225,6 @@ void __init free_area_init(unsigned long
 			__pa(PAGE_OFFSET) >> PAGE_SHIFT, NULL);
 }
 
-#ifdef CONFIG_PROC_FS
-
-#include <linux/seq_file.h>
-
-static void *frag_start(struct seq_file *m, loff_t *pos)
-{
-	pg_data_t *pgdat;
-	loff_t node = *pos;
-	for (pgdat = first_online_pgdat();
-	     pgdat && node;
-	     pgdat = next_online_pgdat(pgdat))
-		--node;
-
-	return pgdat;
-}
-
-static void *frag_next(struct seq_file *m, void *arg, loff_t *pos)
-{
-	pg_data_t *pgdat = (pg_data_t *)arg;
-
-	(*pos)++;
-	return next_online_pgdat(pgdat);
-}
-
-static void frag_stop(struct seq_file *m, void *arg)
-{
-}
-
-/* 
- * This walks the free areas for each zone.
- */
-static int frag_show(struct seq_file *m, void *arg)
-{
-	pg_data_t *pgdat = (pg_data_t *)arg;
-	struct zone *zone;
-	struct zone *node_zones = pgdat->node_zones;
-	unsigned long flags;
-	int order;
-
-	for (zone = node_zones; zone - node_zones < MAX_NR_ZONES; ++zone) {
-		if (!populated_zone(zone))
-			continue;
-
-		spin_lock_irqsave(&zone->lock, flags);
-		seq_printf(m, "Node %d, zone %8s ", pgdat->node_id, zone->name);
-		for (order = 0; order < MAX_ORDER; ++order)
-			seq_printf(m, "%6lu ", zone->free_area[order].nr_free);
-		spin_unlock_irqrestore(&zone->lock, flags);
-		seq_putc(m, '\n');
-	}
-	return 0;
-}
-
-struct seq_operations fragmentation_op = {
-	.start	= frag_start,
-	.next	= frag_next,
-	.stop	= frag_stop,
-	.show	= frag_show,
-};
-
-/*
- * Output information about zones in @pgdat.
- */
-static int zoneinfo_show(struct seq_file *m, void *arg)
-{
-	pg_data_t *pgdat = arg;
-	struct zone *zone;
-	struct zone *node_zones = pgdat->node_zones;
-	unsigned long flags;
-
-	for (zone = node_zones; zone - node_zones < MAX_NR_ZONES; zone++) {
-		int i;
-
-		if (!populated_zone(zone))
-			continue;
-
-		spin_lock_irqsave(&zone->lock, flags);
-		seq_printf(m, "Node %d, zone %8s", pgdat->node_id, zone->name);
-		seq_printf(m,
-			   "\n  pages free     %lu"
-			   "\n        min      %lu"
-			   "\n        low      %lu"
-			   "\n        high     %lu"
-			   "\n        active   %lu"
-			   "\n        inactive %lu"
-			   "\n        scanned  %lu (a: %lu i: %lu)"
-			   "\n        spanned  %lu"
-			   "\n        present  %lu",
-			   zone->free_pages,
-			   zone->pages_min,
-			   zone->pages_low,
-			   zone->pages_high,
-			   zone->nr_active,
-			   zone->nr_inactive,
-			   zone->pages_scanned,
-			   zone->nr_scan_active, zone->nr_scan_inactive,
-			   zone->spanned_pages,
-			   zone->present_pages);
-		seq_printf(m,
-			   "\n        protection: (%lu",
-			   zone->lowmem_reserve[0]);
-		for (i = 1; i < ARRAY_SIZE(zone->lowmem_reserve); i++)
-			seq_printf(m, ", %lu", zone->lowmem_reserve[i]);
-		seq_printf(m,
-			   ")"
-			   "\n  pagesets");
-		for_each_online_cpu(i) {
-			struct per_cpu_pageset *pageset;
-			int j;
-
-			pageset = zone_pcp(zone, i);
-			for (j = 0; j < ARRAY_SIZE(pageset->pcp); j++) {
-				if (pageset->pcp[j].count)
-					break;
-			}
-			if (j == ARRAY_SIZE(pageset->pcp))
-				continue;
-			for (j = 0; j < ARRAY_SIZE(pageset->pcp); j++) {
-				seq_printf(m,
-					   "\n    cpu: %i pcp: %i"
-					   "\n              count: %i"
-					   "\n              high:  %i"
-					   "\n              batch: %i",
-					   i, j,
-					   pageset->pcp[j].count,
-					   pageset->pcp[j].high,
-					   pageset->pcp[j].batch);
-			}
-#ifdef CONFIG_NUMA
-			seq_printf(m,
-				   "\n            numa_hit:       %lu"
-				   "\n            numa_miss:      %lu"
-				   "\n            numa_foreign:   %lu"
-				   "\n            interleave_hit: %lu"
-				   "\n            local_node:     %lu"
-				   "\n            other_node:     %lu",
-				   pageset->numa_hit,
-				   pageset->numa_miss,
-				   pageset->numa_foreign,
-				   pageset->interleave_hit,
-				   pageset->local_node,
-				   pageset->other_node);
-#endif
-		}
-		seq_printf(m,
-			   "\n  all_unreclaimable: %u"
-			   "\n  prev_priority:     %i"
-			   "\n  temp_priority:     %i"
-			   "\n  start_pfn:         %lu",
-			   zone->all_unreclaimable,
-			   zone->prev_priority,
-			   zone->temp_priority,
-			   zone->zone_start_pfn);
-		spin_unlock_irqrestore(&zone->lock, flags);
-		seq_putc(m, '\n');
-	}
-	return 0;
-}
-
-struct seq_operations zoneinfo_op = {
-	.start	= frag_start, /* iterate over all zones. The same as in
-			       * fragmentation. */
-	.next	= frag_next,
-	.stop	= frag_stop,
-	.show	= zoneinfo_show,
-};
-
-static char *vmstat_text[] = {
-	"nr_dirty",
-	"nr_writeback",
-	"nr_unstable",
-	"nr_page_table_pages",
-	"nr_mapped",
-	"nr_slab",
-
-	"pgpgin",
-	"pgpgout",
-	"pswpin",
-	"pswpout",
-
-	"pgalloc_high",
-	"pgalloc_normal",
-	"pgalloc_dma32",
-	"pgalloc_dma",
-
-	"pgfree",
-	"pgactivate",
-	"pgdeactivate",
-
-	"pgfault",
-	"pgmajfault",
-
-	"pgrefill_high",
-	"pgrefill_normal",
-	"pgrefill_dma32",
-	"pgrefill_dma",
-
-	"pgsteal_high",
-	"pgsteal_normal",
-	"pgsteal_dma32",
-	"pgsteal_dma",
-
-	"pgscan_kswapd_high",
-	"pgscan_kswapd_normal",
-	"pgscan_kswapd_dma32",
-	"pgscan_kswapd_dma",
-
-	"pgscan_direct_high",
-	"pgscan_direct_normal",
-	"pgscan_direct_dma32",
-	"pgscan_direct_dma",
-
-	"pginodesteal",
-	"slabs_scanned",
-	"kswapd_steal",
-	"kswapd_inodesteal",
-	"pageoutrun",
-	"allocstall",
-
-	"pgrotated",
-	"nr_bounce",
-};
-
-static void *vmstat_start(struct seq_file *m, loff_t *pos)
-{
-	struct page_state *ps;
-
-	if (*pos >= ARRAY_SIZE(vmstat_text))
-		return NULL;
-
-	ps = kmalloc(sizeof(*ps), GFP_KERNEL);
-	m->private = ps;
-	if (!ps)
-		return ERR_PTR(-ENOMEM);
-	get_full_page_state(ps);
-	ps->pgpgin /= 2;		/* sectors -> kbytes */
-	ps->pgpgout /= 2;
-	return (unsigned long *)ps + *pos;
-}
-
-static void *vmstat_next(struct seq_file *m, void *arg, loff_t *pos)
-{
-	(*pos)++;
-	if (*pos >= ARRAY_SIZE(vmstat_text))
-		return NULL;
-	return (unsigned long *)m->private + *pos;
-}
-
-static int vmstat_show(struct seq_file *m, void *arg)
-{
-	unsigned long *l = arg;
-	unsigned long off = l - (unsigned long *)m->private;
-
-	seq_printf(m, "%s %lu\n", vmstat_text[off], *l);
-	return 0;
-}
-
-static void vmstat_stop(struct seq_file *m, void *arg)
-{
-	kfree(m->private);
-	m->private = NULL;
-}
-
-struct seq_operations vmstat_op = {
-	.start	= vmstat_start,
-	.next	= vmstat_next,
-	.stop	= vmstat_stop,
-	.show	= vmstat_show,
-};
-
-#endif /* CONFIG_PROC_FS */
-
 #ifdef CONFIG_HOTPLUG_CPU
 static int page_alloc_cpu_notify(struct notifier_block *self,
 				 unsigned long action, void *hcpu)
