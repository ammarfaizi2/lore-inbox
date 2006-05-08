Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbWEHOMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWEHOMj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 10:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbWEHOMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 10:12:38 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:53942 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932103AbWEHOMd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 10:12:33 -0400
From: Mel Gorman <mel@csn.ul.ie>
To: akpm@osdl.org
Cc: davej@codemonkey.org.uk, tony.luck@intel.com, Mel Gorman <mel@csn.ul.ie>,
       ak@suse.de, bob.picco@hp.com, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, linux-mm@kvack.org
Message-Id: <20060508141231.26912.52976.sendpatchset@skynet>
In-Reply-To: <20060508141030.26912.93090.sendpatchset@skynet>
References: <20060508141030.26912.93090.sendpatchset@skynet>
Subject: [PATCH 6/6] Break out memory initialisation code from page_alloc.c to mem_init.c
Date: Mon,  8 May 2006 15:12:31 +0100 (IST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


page_alloc.c contains a large amount of memory initialisation code. This patch
breaks out the initialisation code to a separate file to make page_alloc.c
a bit easier to read.


 Makefile     |    2 
 mem_init.c   | 1123 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 page_alloc.c | 1105 -----------------------------------------------------
 3 files changed, 1124 insertions(+), 1106 deletions(-)

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc3-mm1-105-ia64_use_init_nodes/mm/Makefile linux-2.6.17-rc3-mm1-106-breakout_mem_init/mm/Makefile
--- linux-2.6.17-rc3-mm1-105-ia64_use_init_nodes/mm/Makefile	2006-05-01 11:37:01.000000000 +0100
+++ linux-2.6.17-rc3-mm1-106-breakout_mem_init/mm/Makefile	2006-05-08 09:22:02.000000000 +0100
@@ -8,7 +8,7 @@ mmu-$(CONFIG_MMU)	:= fremap.o highmem.o 
 			   vmalloc.o
 
 obj-y			:= bootmem.o filemap.o mempool.o oom_kill.o fadvise.o \
-			   page_alloc.o page-writeback.o pdflush.o \
+			   page_alloc.o mem_init.o page-writeback.o pdflush.o \
 			   readahead.o swap.o truncate.o vmscan.o \
 			   prio_tree.o util.o mmzone.o $(mmu-y)
 
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc3-mm1-105-ia64_use_init_nodes/mm/mem_init.c linux-2.6.17-rc3-mm1-106-breakout_mem_init/mm/mem_init.c
--- linux-2.6.17-rc3-mm1-105-ia64_use_init_nodes/mm/mem_init.c	2006-05-01 11:51:50.000000000 +0100
+++ linux-2.6.17-rc3-mm1-106-breakout_mem_init/mm/mem_init.c	2006-05-08 11:00:23.000000000 +0100
@@ -0,0 +1,1123 @@
+/*
+ * mm/mem_init.c
+ * Initialises the architecture independant view of memory. pgdats, zones, etc
+ *
+ *  Copyright (C) 1991, 1992, 1993, 1994  Linus Torvalds
+ *  Copyright (C) 1995, Stephen Tweedie
+ *  Copyright (C) July 1999, Gerhard Wichert, Siemens AG
+ *  Copyright (C) 1999, Ingo Molnar, Red Hat
+ *  Copyright (C) 1999, 2000, Kanoj Sarcar, SGI
+ *  Copyright (C) Sept 2000, Martin J. Bligh
+ *	(lots of bits borrowed from Ingo Molnar & Andrew Morton)
+ *  Copyright (C) Apr 2006, Mel Gorman, IBM
+ *	(lots of bits taken from architecture-specific code)
+ */
+#include <linux/config.h>
+#include <linux/sort.h>
+#include <linux/pfn.h>
+#include <linux/mm.h>
+#include <linux/bootmem.h>
+#include <linux/cpuset.h>
+#include <linux/mempolicy.h>
+#include <linux/sysctl.h>
+#include <linux/swap.h>
+#include <linux/cpu.h>
+#include <linux/stop_machine.h>
+#include <linux/vmalloc.h>
+
+static char *zone_names[MAX_NR_ZONES] = { "DMA", "DMA32", "Normal", "HighMem" };
+int percpu_pagelist_fraction;
+
+#ifdef CONFIG_ARCH_POPULATES_NODE_MAP
+  #ifdef CONFIG_MAX_ACTIVE_REGIONS
+    #define MAX_ACTIVE_REGIONS CONFIG_MAX_ACTIVE_REGIONS
+  #else
+    #define MAX_ACTIVE_REGIONS (MAX_NR_ZONES * MAX_NUMNODES + 1)
+  #endif
+
+  struct node_active_region __initdata early_node_map[MAX_ACTIVE_REGIONS];
+  unsigned long __initdata arch_zone_lowest_possible_pfn[MAX_NR_ZONES];
+  unsigned long __initdata arch_zone_highest_possible_pfn[MAX_NR_ZONES];
+#endif /* CONFIG_ARCH_POPULATES_NODE_MAP */
+
+/*
+ * Builds allocation fallback zone lists.
+ *
+ * Add all populated zones of a node to the zonelist.
+ */
+static int __meminit build_zonelists_node(pg_data_t *pgdat,
+			struct zonelist *zonelist, int nr_zones, int zone_type)
+{
+	struct zone *zone;
+
+	BUG_ON(zone_type > ZONE_HIGHMEM);
+
+	do {
+		zone = pgdat->node_zones + zone_type;
+		if (populated_zone(zone)) {
+#ifndef CONFIG_HIGHMEM
+			BUG_ON(zone_type > ZONE_NORMAL);
+#endif
+			zonelist->zones[nr_zones++] = zone;
+			check_highest_zone(zone_type);
+		}
+		zone_type--;
+
+	} while (zone_type >= 0);
+	return nr_zones;
+}
+
+static inline int highest_zone(int zone_bits)
+{
+	int res = ZONE_NORMAL;
+	if (zone_bits & (__force int)__GFP_HIGHMEM)
+		res = ZONE_HIGHMEM;
+	if (zone_bits & (__force int)__GFP_DMA32)
+		res = ZONE_DMA32;
+	if (zone_bits & (__force int)__GFP_DMA)
+		res = ZONE_DMA;
+	return res;
+}
+
+#ifdef CONFIG_NUMA
+#define MAX_NODE_LOAD (num_online_nodes())
+static int __meminitdata node_load[MAX_NUMNODES];
+/**
+ * find_next_best_node - find the next node that should appear in a given node's fallback list
+ * @node: node whose fallback list we're appending
+ * @used_node_mask: nodemask_t of already used nodes
+ *
+ * We use a number of factors to determine which is the next node that should
+ * appear on a given node's fallback list.  The node should not have appeared
+ * already in @node's fallback list, and it should be the next closest node
+ * according to the distance array (which contains arbitrary distance values
+ * from each node to each node in the system), and should also prefer nodes
+ * with no CPUs, since presumably they'll have very little allocation pressure
+ * on them otherwise.
+ * It returns -1 if no node is found.
+ */
+static int __meminit find_next_best_node(int node, nodemask_t *used_node_mask)
+{
+	int n, val;
+	int min_val = INT_MAX;
+	int best_node = -1;
+
+	/* Use the local node if we haven't already */
+	if (!node_isset(node, *used_node_mask)) {
+		node_set(node, *used_node_mask);
+		return node;
+	}
+
+	for_each_online_node(n) {
+		cpumask_t tmp;
+
+		/* Don't want a node to appear more than once */
+		if (node_isset(n, *used_node_mask))
+			continue;
+
+		/* Use the distance array to find the distance */
+		val = node_distance(node, n);
+
+		/* Penalize nodes under us ("prefer the next node") */
+		val += (n < node);
+
+		/* Give preference to headless and unused nodes */
+		tmp = node_to_cpumask(n);
+		if (!cpus_empty(tmp))
+			val += PENALTY_FOR_NODE_WITH_CPUS;
+
+		/* Slight preference for less loaded node */
+		val *= (MAX_NODE_LOAD*MAX_NUMNODES);
+		val += node_load[n];
+
+		if (val < min_val) {
+			min_val = val;
+			best_node = n;
+		}
+	}
+
+	if (best_node >= 0)
+		node_set(best_node, *used_node_mask);
+
+	return best_node;
+}
+
+static void __meminit build_zonelists(pg_data_t *pgdat)
+{
+	int i, j, k, node, local_node;
+	int prev_node, load;
+	struct zonelist *zonelist;
+	nodemask_t used_mask;
+
+	/* initialize zonelists */
+	for (i = 0; i < GFP_ZONETYPES; i++) {
+		zonelist = pgdat->node_zonelists + i;
+		zonelist->zones[0] = NULL;
+	}
+
+	/* NUMA-aware ordering of nodes */
+	local_node = pgdat->node_id;
+	load = num_online_nodes();
+	prev_node = local_node;
+	nodes_clear(used_mask);
+	while ((node = find_next_best_node(local_node, &used_mask)) >= 0) {
+		int distance = node_distance(local_node, node);
+
+		/*
+		 * If another node is sufficiently far away then it is better
+		 * to reclaim pages in a zone before going off node.
+		 */
+		if (distance > RECLAIM_DISTANCE)
+			zone_reclaim_mode = 1;
+
+		/*
+		 * We don't want to pressure a particular node.
+		 * So adding penalty to the first node in same
+		 * distance group to make it round-robin.
+		 */
+
+		if (distance != node_distance(local_node, prev_node))
+			node_load[node] += load;
+		prev_node = node;
+		load--;
+		for (i = 0; i < GFP_ZONETYPES; i++) {
+			zonelist = pgdat->node_zonelists + i;
+			for (j = 0; zonelist->zones[j] != NULL; j++);
+
+			k = highest_zone(i);
+
+	 		j = build_zonelists_node(NODE_DATA(node), zonelist, j, k);
+			zonelist->zones[j] = NULL;
+		}
+	}
+}
+
+#else	/* CONFIG_NUMA */
+
+static void __meminit build_zonelists(pg_data_t *pgdat)
+{
+	int i, j, k, node, local_node;
+
+	local_node = pgdat->node_id;
+	for (i = 0; i < GFP_ZONETYPES; i++) {
+		struct zonelist *zonelist;
+
+		zonelist = pgdat->node_zonelists + i;
+
+		j = 0;
+		k = highest_zone(i);
+ 		j = build_zonelists_node(pgdat, zonelist, j, k);
+ 		/*
+ 		 * Now we build the zonelist so that it contains the zones
+ 		 * of all the other nodes.
+ 		 * We don't want to pressure a particular node, so when
+ 		 * building the zones for node N, we make sure that the
+ 		 * zones coming right after the local ones are those from
+ 		 * node N+1 (modulo N)
+ 		 */
+		for (node = local_node + 1; node < MAX_NUMNODES; node++) {
+			if (!node_online(node))
+				continue;
+			j = build_zonelists_node(NODE_DATA(node), zonelist, j, k);
+		}
+		for (node = 0; node < local_node; node++) {
+			if (!node_online(node))
+				continue;
+			j = build_zonelists_node(NODE_DATA(node), zonelist, j, k);
+		}
+
+		zonelist->zones[j] = NULL;
+	}
+}
+
+#endif	/* CONFIG_NUMA */
+
+/* return values int ....just for stop_machine_run() */
+static int __meminit __build_all_zonelists(void *dummy)
+{
+	int nid;
+	for_each_online_node(nid)
+		build_zonelists(NODE_DATA(nid));
+	return 0;
+}
+
+void __meminit build_all_zonelists(void)
+{
+	if (system_state == SYSTEM_BOOTING) {
+		__build_all_zonelists(0);
+		cpuset_init_current_mems_allowed();
+	} else {
+		/* we have to stop all cpus to guaranntee there is no user
+		   of zonelist */
+		stop_machine_run(__build_all_zonelists, NULL, NR_CPUS);
+		/* cpuset refresh routine should be here */
+	}
+
+	printk("Built %i zonelists\n", num_online_nodes());
+
+}
+
+/*
+ * Helper functions to size the waitqueue hash table.
+ * Essentially these want to choose hash table sizes sufficiently
+ * large so that collisions trying to wait on pages are rare.
+ * But in fact, the number of active page waitqueues on typical
+ * systems is ridiculously low, less than 200. So this is even
+ * conservative, even though it seems large.
+ *
+ * The constant PAGES_PER_WAITQUEUE specifies the ratio of pages to
+ * waitqueues, i.e. the size of the waitq table given the number of pages.
+ */
+#define PAGES_PER_WAITQUEUE	256
+
+#ifndef CONFIG_MEMORY_HOTPLUG
+static inline unsigned long wait_table_hash_nr_entries(unsigned long pages)
+{
+	unsigned long size = 1;
+
+	pages /= PAGES_PER_WAITQUEUE;
+
+	while (size < pages)
+		size <<= 1;
+
+	/*
+	 * Once we have dozens or even hundreds of threads sleeping
+	 * on IO we've got bigger problems than wait queue collision.
+	 * Limit the size of the wait table to a reasonable size.
+	 */
+	size = min(size, 4096UL);
+
+	return max(size, 4UL);
+}
+#else
+/*
+ * A zone's size might be changed by hot-add, so it is not possible to determine
+ * a suitable size for its wait_table.  So we use the maximum size now.
+ *
+ * The max wait table size = 4096 x sizeof(wait_queue_head_t).   ie:
+ *
+ *    i386 (preemption config)    : 4096 x 16 = 64Kbyte.
+ *    ia64, x86-64 (no preemption): 4096 x 20 = 80Kbyte.
+ *    ia64, x86-64 (preemption)   : 4096 x 24 = 96Kbyte.
+ *
+ * The maximum entries are prepared when a zone's memory is (512K + 256) pages
+ * or more by the traditional way. (See above).  It equals:
+ *
+ *    i386, x86-64, powerpc(4K page size) : =  ( 2G + 1M)byte.
+ *    ia64(16K page size)                 : =  ( 8G + 4M)byte.
+ *    powerpc (64K page size)             : =  (32G +16M)byte.
+ */
+static inline unsigned long wait_table_hash_nr_entries(unsigned long pages)
+{
+	return 4096UL;
+}
+#endif
+
+/*
+ * This is an integer logarithm so that shifts can be used later
+ * to extract the more random high bits from the multiplicative
+ * hash function before the remainder is taken.
+ */
+static inline unsigned long wait_table_bits(unsigned long size)
+{
+	return ffz(~size);
+}
+
+#define LONG_ALIGN(x) (((x)+(sizeof(long))-1)&~((sizeof(long))-1))
+
+#ifndef __HAVE_ARCH_MEMMAP_INIT
+#define memmap_init(size, nid, zone, start_pfn) \
+	memmap_init_zone((size), (nid), (zone), (start_pfn))
+#endif
+
+/*
+ * Initially all pages are reserved - free ones are freed
+ * up by free_all_bootmem() once the early boot process is
+ * done. Non-atomic initialization, single-pass.
+ */
+void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
+		unsigned long start_pfn)
+{
+	struct page *page;
+	unsigned long end_pfn = start_pfn + size;
+	unsigned long pfn;
+
+	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
+		if (!early_pfn_valid(pfn))
+			continue;
+		page = pfn_to_page(pfn);
+		set_page_links(page, zone, nid, pfn);
+		init_page_count(page);
+		reset_page_mapcount(page);
+		SetPageReserved(page);
+		INIT_LIST_HEAD(&page->lru);
+#ifdef WANT_PAGE_VIRTUAL
+		/* The shift won't overflow because ZONE_NORMAL is below 4G. */
+		if (!is_highmem_idx(zone))
+			set_page_address(page, __va(pfn << PAGE_SHIFT));
+#endif
+	}
+}
+
+void zone_init_free_lists(struct pglist_data *pgdat, struct zone *zone,
+				unsigned long size)
+{
+	int order;
+	for (order = 0; order < MAX_ORDER ; order++) {
+		INIT_LIST_HEAD(&zone->free_area[order].free_list);
+		zone->free_area[order].nr_free = 0;
+	}
+}
+
+#define ZONETABLE_INDEX(x, zone_nr)	((x << ZONES_SHIFT) | zone_nr)
+void zonetable_add(struct zone *zone, int nid, int zid, unsigned long pfn,
+		unsigned long size)
+{
+	unsigned long snum = pfn_to_section_nr(pfn);
+	unsigned long end = pfn_to_section_nr(pfn + size);
+
+	if (FLAGS_HAS_NODE)
+		zone_table[ZONETABLE_INDEX(nid, zid)] = zone;
+	else
+		for (; snum <= end; snum++)
+			zone_table[ZONETABLE_INDEX(snum, zid)] = zone;
+}
+
+static __meminit
+int zone_wait_table_init(struct zone *zone, unsigned long zone_size_pages)
+{
+	int i;
+	struct pglist_data *pgdat = zone->zone_pgdat;
+	size_t alloc_size;
+
+	/*
+	 * The per-page waitqueue mechanism uses hashed waitqueues
+	 * per zone.
+	 */
+	zone->wait_table_hash_nr_entries =
+		 wait_table_hash_nr_entries(zone_size_pages);
+	zone->wait_table_bits =
+		wait_table_bits(zone->wait_table_hash_nr_entries);
+	alloc_size = zone->wait_table_hash_nr_entries
+					* sizeof(wait_queue_head_t);
+
+ 	if (system_state == SYSTEM_BOOTING) {
+		zone->wait_table = (wait_queue_head_t *)
+			alloc_bootmem_node(pgdat, alloc_size);
+	} else {
+		/*
+		 * This case means that a zone whose size was 0 gets new memory
+		 * via memory hot-add.
+		 * But it may be the case that a new node was hot-added.  In
+		 * this case vmalloc() will not be able to use this new node's
+		 * memory - this wait_table must be initialized to use this new
+		 * node itself as well.
+		 * To use this new node's memory, further consideration will be
+		 * necessary.
+		 */
+		zone->wait_table = (wait_queue_head_t *)vmalloc(alloc_size);
+	}
+	if (!zone->wait_table)
+		return -ENOMEM;
+
+	for(i = 0; i < zone->wait_table_hash_nr_entries; ++i)
+		init_waitqueue_head(zone->wait_table + i);
+
+	return 0;
+}
+
+/*
+ * setup_pagelist_highmark() sets the high water mark for hot per_cpu_pagelist
+ * to the value high for the pageset p.
+ */
+static void setup_pagelist_highmark(struct per_cpu_pageset *p,
+				unsigned long high)
+{
+	struct per_cpu_pages *pcp;
+
+	pcp = &p->pcp[0]; /* hot list */
+	pcp->high = high;
+	pcp->batch = max(1UL, high/4);
+	if ((high/4) > (PAGE_SHIFT * 8))
+		pcp->batch = PAGE_SHIFT * 8;
+}
+
+/*
+ * percpu_pagelist_fraction - changes the pcp->high for each zone on each
+ * cpu.  It is the fraction of total pages in each zone that a hot per cpu pagelist
+ * can have before it gets flushed back to buddy allocator.
+ */
+int percpu_pagelist_fraction_sysctl_handler(ctl_table *table, int write,
+	struct file *file, void __user *buffer, size_t *length, loff_t *ppos)
+{
+	struct zone *zone;
+	unsigned int cpu;
+	int ret;
+
+	ret = proc_dointvec_minmax(table, write, file, buffer, length, ppos);
+	if (!write || (ret == -EINVAL))
+		return ret;
+	for_each_zone(zone) {
+		for_each_online_cpu(cpu) {
+			unsigned long  high;
+			high = zone->present_pages / percpu_pagelist_fraction;
+			setup_pagelist_highmark(zone_pcp(zone, cpu), high);
+		}
+	}
+	return 0;
+}
+
+static int __cpuinit zone_batchsize(struct zone *zone)
+{
+	int batch;
+
+	/*
+	 * The per-cpu-pages pools are set to around 1000th of the
+	 * size of the zone.  But no more than 1/2 of a meg.
+	 *
+	 * OK, so we don't know how big the cache is.  So guess.
+	 */
+	batch = zone->present_pages / 1024;
+	if (batch * PAGE_SIZE > 512 * 1024)
+		batch = (512 * 1024) / PAGE_SIZE;
+	batch /= 4;		/* We effectively *= 4 below */
+	if (batch < 1)
+		batch = 1;
+
+	/*
+	 * Clamp the batch to a 2^n - 1 value. Having a power
+	 * of 2 value was found to be more likely to have
+	 * suboptimal cache aliasing properties in some cases.
+	 *
+	 * For example if 2 tasks are alternately allocating
+	 * batches of pages, one task can end up with a lot
+	 * of pages of one half of the possible page colors
+	 * and the other with pages of the other colors.
+	 */
+	batch = (1 << (fls(batch + batch/2)-1)) - 1;
+
+	return batch;
+}
+
+inline void setup_pageset(struct per_cpu_pageset *p, unsigned long batch)
+{
+	struct per_cpu_pages *pcp;
+
+	memset(p, 0, sizeof(*p));
+
+	pcp = &p->pcp[0];		/* hot */
+	pcp->count = 0;
+	pcp->high = 6 * batch;
+	pcp->batch = max(1UL, 1 * batch);
+	INIT_LIST_HEAD(&pcp->list);
+
+	pcp = &p->pcp[1];		/* cold*/
+	pcp->count = 0;
+	pcp->high = 2 * batch;
+	pcp->batch = max(1UL, batch/2);
+	INIT_LIST_HEAD(&pcp->list);
+}
+
+#ifdef CONFIG_NUMA
+/*
+ * Boot pageset table. One per cpu which is going to be used for all
+ * zones and all nodes. The parameters will be set in such a way
+ * that an item put on a list will immediately be handed over to
+ * the buddy list. This is safe since pageset manipulation is done
+ * with interrupts disabled.
+ *
+ * Some NUMA counter updates may also be caught by the boot pagesets.
+ *
+ * The boot_pagesets must be kept even after bootup is complete for
+ * unused processors and/or zones. They do play a role for bootstrapping
+ * hotplugged processors.
+ *
+ * zoneinfo_show() and maybe other functions do
+ * not check if the processor is online before following the pageset pointer.
+ * Other parts of the kernel may not check if the zone is available.
+ */
+static struct per_cpu_pageset boot_pageset[NR_CPUS];
+
+/*
+ * Dynamically allocate memory for the
+ * per cpu pageset array in struct zone.
+ */
+static int __cpuinit process_zones(int cpu)
+{
+	struct zone *zone, *dzone;
+
+	for_each_zone(zone) {
+
+		zone_pcp(zone, cpu) = kmalloc_node(sizeof(struct per_cpu_pageset),
+					 GFP_KERNEL, cpu_to_node(cpu));
+		if (!zone_pcp(zone, cpu))
+			goto bad;
+
+		setup_pageset(zone_pcp(zone, cpu), zone_batchsize(zone));
+
+		if (percpu_pagelist_fraction)
+			setup_pagelist_highmark(zone_pcp(zone, cpu),
+			 	(zone->present_pages / percpu_pagelist_fraction));
+	}
+
+	return 0;
+bad:
+	for_each_zone(dzone) {
+		if (dzone == zone)
+			break;
+		kfree(zone_pcp(dzone, cpu));
+		zone_pcp(dzone, cpu) = NULL;
+	}
+	return -ENOMEM;
+}
+
+static inline void free_zone_pagesets(int cpu)
+{
+	struct zone *zone;
+
+	for_each_zone(zone) {
+		struct per_cpu_pageset *pset = zone_pcp(zone, cpu);
+
+		zone_pcp(zone, cpu) = NULL;
+		kfree(pset);
+	}
+}
+
+static int pageset_cpuup_callback(struct notifier_block *nfb,
+		unsigned long action,
+		void *hcpu)
+{
+	int cpu = (long)hcpu;
+	int ret = NOTIFY_OK;
+
+	switch (action) {
+		case CPU_UP_PREPARE:
+			if (process_zones(cpu))
+				ret = NOTIFY_BAD;
+			break;
+		case CPU_UP_CANCELED:
+		case CPU_DEAD:
+			free_zone_pagesets(cpu);
+			break;
+		default:
+			break;
+	}
+	return ret;
+}
+
+static struct notifier_block pageset_notifier =
+	{ &pageset_cpuup_callback, NULL, 0 };
+
+void __init setup_per_cpu_pageset(void)
+{
+	int err;
+
+	/* Initialize per_cpu_pageset for cpu 0.
+	 * A cpuup callback will do this for every cpu
+	 * as it comes online
+	 */
+	err = process_zones(smp_processor_id());
+	BUG_ON(err);
+	register_cpu_notifier(&pageset_notifier);
+}
+#endif
+
+static __meminit void zone_pcp_init(struct zone *zone)
+{
+	int cpu;
+	unsigned long batch = zone_batchsize(zone);
+
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+#ifdef CONFIG_NUMA
+		/* Early boot. Slab allocator not functional yet */
+		zone_pcp(zone, cpu) = &boot_pageset[cpu];
+		setup_pageset(&boot_pageset[cpu],0);
+#else
+		setup_pageset(zone_pcp(zone,cpu), batch);
+#endif
+	}
+	if (zone->present_pages)
+		printk(KERN_DEBUG "  %s zone: %lu pages, LIFO batch:%lu\n",
+			zone->name, zone->present_pages, batch);
+}
+
+__meminit int init_currently_empty_zone(struct zone *zone,
+					unsigned long zone_start_pfn,
+					unsigned long size)
+{
+	struct pglist_data *pgdat = zone->zone_pgdat;
+	int ret;
+	ret = zone_wait_table_init(zone, size);
+	if (ret)
+		return ret;
+	pgdat->nr_zones = zone_idx(zone) + 1;
+
+	zone->zone_start_pfn = zone_start_pfn;
+
+	memmap_init(size, pgdat->node_id, zone_idx(zone), zone_start_pfn);
+
+	zone_init_free_lists(pgdat, zone, zone->spanned_pages);
+
+	return 0;
+}
+
+#ifdef CONFIG_ARCH_POPULATES_NODE_MAP
+/* Note: nid == MAX_NUMNODES returns first region */
+static int __init first_active_region_index_in_nid(int nid)
+{
+	int i;
+	for (i = 0; early_node_map[i].end_pfn; i++) {
+		if (nid == MAX_NUMNODES || early_node_map[i].nid == nid)
+			return i;
+	}
+
+	return MAX_ACTIVE_REGIONS;
+}
+
+/* Note: nid == MAX_NUMNODES returns next region */
+static int __init next_active_region_index_in_nid(unsigned int index, int nid)
+{
+	for (index = index + 1; early_node_map[index].end_pfn; index++) {
+		if (nid == MAX_NUMNODES || early_node_map[index].nid == nid)
+			return index;
+	}
+
+	return MAX_ACTIVE_REGIONS;
+}
+
+#ifndef CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID
+int __init early_pfn_to_nid(unsigned long pfn)
+{
+	int i;
+
+	for (i = 0; early_node_map[i].end_pfn; i++) {
+		unsigned long start_pfn = early_node_map[i].start_pfn;
+		unsigned long end_pfn = early_node_map[i].end_pfn;
+
+		if ((start_pfn <= pfn) && (pfn < end_pfn))
+			return early_node_map[i].nid;
+	}
+
+	return -1;
+}
+#endif
+
+#define for_each_active_range_index_in_nid(i, nid) \
+	for (i = first_active_region_index_in_nid(nid); \
+				i != MAX_ACTIVE_REGIONS; \
+				i = next_active_region_index_in_nid(i, nid))
+
+void __init free_bootmem_with_active_regions(int nid,
+						unsigned long max_low_pfn)
+{
+	unsigned int i;
+	for_each_active_range_index_in_nid(i, nid) {
+		unsigned long size_pages = 0;
+		unsigned long end_pfn = early_node_map[i].end_pfn;
+		if (early_node_map[i].start_pfn >= max_low_pfn)
+			continue;
+
+		if (end_pfn > max_low_pfn)
+			end_pfn = max_low_pfn;
+
+		size_pages = end_pfn - early_node_map[i].start_pfn;
+		free_bootmem_node(NODE_DATA(early_node_map[i].nid),
+				PFN_PHYS(early_node_map[i].start_pfn),
+				size_pages << PAGE_SHIFT);
+	}
+}
+
+void __init sparse_memory_present_with_active_regions(int nid)
+{
+	unsigned int i;
+	for_each_active_range_index_in_nid(i, nid)
+		memory_present(early_node_map[i].nid,
+				early_node_map[i].start_pfn,
+				early_node_map[i].end_pfn);
+}
+
+void __init get_pfn_range_for_nid(unsigned int nid,
+			unsigned long *start_pfn, unsigned long *end_pfn)
+{
+	unsigned int i;
+	*start_pfn = -1UL;
+	*end_pfn = 0;
+
+	for_each_active_range_index_in_nid(i, nid) {
+		*start_pfn = min(*start_pfn, early_node_map[i].start_pfn);
+		*end_pfn = max(*end_pfn, early_node_map[i].end_pfn);
+	}
+
+	if (*start_pfn == -1UL) {
+		printk(KERN_WARNING "Node %u active with no memory\n", nid);
+		*start_pfn = 0;
+	}
+}
+
+unsigned long __init zone_present_pages_in_node(int nid,
+					unsigned long zone_type,
+					unsigned long *ignored)
+{
+	unsigned long node_start_pfn, node_end_pfn;
+	unsigned long zone_start_pfn, zone_end_pfn;
+
+	/* Get the start and end of the node and zone */
+	get_pfn_range_for_nid(nid, &node_start_pfn, &node_end_pfn);
+	zone_start_pfn = arch_zone_lowest_possible_pfn[zone_type];
+	zone_end_pfn = arch_zone_highest_possible_pfn[zone_type];
+
+	/* Check that this node has pages within the zone's required range */
+	if (zone_end_pfn < node_start_pfn || zone_start_pfn > node_end_pfn)
+		return 0;
+
+	/* Move the zone boundaries inside the node if necessary */
+	zone_end_pfn = min(zone_end_pfn, node_end_pfn);
+	zone_start_pfn = max(zone_start_pfn, node_start_pfn);
+
+	/* Return the spanned pages */
+	return zone_end_pfn - zone_start_pfn;
+}
+
+unsigned long __init __absent_pages_in_range(int nid,
+				unsigned long range_start_pfn,
+				unsigned long range_end_pfn)
+{
+	int i = 0;
+	unsigned long prev_end_pfn = 0, hole_pages = 0;
+	unsigned long start_pfn;
+
+	/* Find the end_pfn of the first active range of pfns in the node */
+	i = first_active_region_index_in_nid(nid);
+	if (i == MAX_ACTIVE_REGIONS)
+		return 0;
+	prev_end_pfn = early_node_map[i].start_pfn;
+
+	/* Find all holes for the zone within the node */
+	for (; i != MAX_ACTIVE_REGIONS;
+			i = next_active_region_index_in_nid(i, nid)) {
+
+		/* No need to continue if prev_end_pfn is outside the zone */
+		if (prev_end_pfn >= range_end_pfn)
+			break;
+
+		/* Make sure the end of the zone is not within the hole */
+		start_pfn = min(early_node_map[i].start_pfn, range_end_pfn);
+		prev_end_pfn = max(prev_end_pfn, range_start_pfn);
+
+		/* Update the hole size cound and move on */
+		if (start_pfn > range_start_pfn) {
+			BUG_ON(prev_end_pfn > start_pfn);
+			hole_pages += start_pfn - prev_end_pfn;
+		}
+		prev_end_pfn = early_node_map[i].end_pfn;
+	}
+
+	return hole_pages;
+}
+
+unsigned long __init absent_pages_in_range(unsigned long start_pfn,
+							unsigned long end_pfn)
+{
+	return __absent_pages_in_range(MAX_NUMNODES, start_pfn, end_pfn);
+}
+
+unsigned long __init zone_absent_pages_in_node(int nid,
+					unsigned long zone_type,
+					unsigned long *ignored)
+{
+	return __absent_pages_in_range(nid,
+				arch_zone_lowest_possible_pfn[zone_type],
+				arch_zone_highest_possible_pfn[zone_type]);
+}
+#else
+static inline unsigned long zone_present_pages_in_node(int nid,
+					unsigned long zone_type,
+					unsigned long *zones_size)
+{
+	return zones_size[zone_type];
+}
+
+static inline unsigned long zone_absent_pages_in_node(int nid,
+						unsigned long zone_type,
+						unsigned long *zholes_size)
+{
+	if (!zholes_size)
+		return 0;
+
+	return zholes_size[zone_type];
+}
+#endif
+
+static void __init calculate_node_totalpages(struct pglist_data *pgdat,
+		unsigned long *zones_size, unsigned long *zholes_size)
+{
+	unsigned long realtotalpages, totalpages = 0;
+	int i;
+
+	for (i = 0; i < MAX_NR_ZONES; i++) {
+		totalpages += zone_present_pages_in_node(pgdat->node_id, i,
+								zones_size);
+	}
+	pgdat->node_spanned_pages = totalpages;
+
+	realtotalpages = totalpages;
+	for (i = 0; i < MAX_NR_ZONES; i++) {
+		realtotalpages -=
+			zone_absent_pages_in_node(pgdat->node_id, i, zholes_size);
+	}
+	pgdat->node_present_pages = realtotalpages;
+	printk(KERN_DEBUG "On node %d totalpages: %lu\n", pgdat->node_id,
+							realtotalpages);
+}
+
+/*
+ * Set up the zone data structures:
+ *   - mark all pages reserved
+ *   - mark all memory queues empty
+ *   - clear the memory bitmaps
+ */
+static void __meminit free_area_init_core(struct pglist_data *pgdat,
+		unsigned long *zones_size, unsigned long *zholes_size)
+{
+	unsigned long j;
+	int nid = pgdat->node_id;
+	unsigned long zone_start_pfn = pgdat->node_start_pfn;
+	int ret;
+
+	pgdat_resize_init(pgdat);
+	pgdat->nr_zones = 0;
+	init_waitqueue_head(&pgdat->kswapd_wait);
+	pgdat->kswapd_max_order = 0;
+
+	for (j = 0; j < MAX_NR_ZONES; j++) {
+		struct zone *zone = pgdat->node_zones + j;
+		unsigned long size, realsize;
+
+		size = zone_present_pages_in_node(nid, j, zones_size);
+		realsize = size - zone_absent_pages_in_node(nid, j,
+								zholes_size);
+		if (j < ZONE_HIGHMEM)
+			nr_kernel_pages += realsize;
+		nr_all_pages += realsize;
+
+		zone->spanned_pages = size;
+		zone->present_pages = realsize;
+		zone->name = zone_names[j];
+		spin_lock_init(&zone->lock);
+		spin_lock_init(&zone->lru_lock);
+		zone_seqlock_init(zone);
+		zone->zone_pgdat = pgdat;
+		zone->free_pages = 0;
+
+		zone->temp_priority = zone->prev_priority = DEF_PRIORITY;
+
+		zone_pcp_init(zone);
+		INIT_LIST_HEAD(&zone->active_list);
+		INIT_LIST_HEAD(&zone->inactive_list);
+		zone->nr_scan_active = 0;
+		zone->nr_scan_inactive = 0;
+		zone->nr_active = 0;
+		zone->nr_inactive = 0;
+		atomic_set(&zone->reclaim_in_progress, 0);
+		if (!size)
+			continue;
+
+		zonetable_add(zone, nid, j, zone_start_pfn, size);
+		ret = init_currently_empty_zone(zone, zone_start_pfn, size);
+		BUG_ON(ret);
+		zone_start_pfn += size;
+	}
+}
+
+static void __init alloc_node_mem_map(struct pglist_data *pgdat)
+{
+	/* Skip empty nodes */
+	if (!pgdat->node_spanned_pages)
+		return;
+
+#ifdef CONFIG_FLAT_NODE_MEM_MAP
+	/* ia64 gets its own node_mem_map, before this, without bootmem */
+	if (!pgdat->node_mem_map) {
+		unsigned long size;
+		struct page *map;
+
+		size = (pgdat->node_spanned_pages + 1) * sizeof(struct page);
+		map = alloc_remap(pgdat->node_id, size);
+		if (!map)
+			map = alloc_bootmem_node(pgdat, size);
+		pgdat->node_mem_map = map;
+	}
+#ifdef CONFIG_FLATMEM
+	/*
+	 * With no DISCONTIG, the global mem_map is just set as node 0's
+	 */
+	if (pgdat == NODE_DATA(0))
+		mem_map = NODE_DATA(0)->node_mem_map;
+#endif
+#endif /* CONFIG_FLAT_NODE_MEM_MAP */
+}
+
+void __meminit free_area_init_node(int nid, struct pglist_data *pgdat,
+		unsigned long *zones_size, unsigned long node_start_pfn,
+		unsigned long *zholes_size)
+{
+	pgdat->node_id = nid;
+	pgdat->node_start_pfn = node_start_pfn;
+	calculate_node_totalpages(pgdat, zones_size, zholes_size);
+
+	alloc_node_mem_map(pgdat);
+
+	free_area_init_core(pgdat, zones_size, zholes_size);
+}
+
+#ifdef CONFIG_ARCH_POPULATES_NODE_MAP
+void __init add_active_range(unsigned int nid, unsigned long start_pfn,
+						unsigned long end_pfn)
+{
+	unsigned int i;
+	printk(KERN_DEBUG "Range (%d) %lu -> %lu\n", nid, start_pfn, end_pfn);
+
+	/* Merge with existing active regions if possible */
+	for (i = 0; early_node_map[i].end_pfn; i++) {
+		if (early_node_map[i].nid != nid)
+			continue;
+
+		/* Skip if an existing region covers this new one */
+		if (start_pfn >= early_node_map[i].start_pfn &&
+				end_pfn <= early_node_map[i].end_pfn)
+			return;
+
+		/* Merge forward if suitable */
+		if (start_pfn <= early_node_map[i].end_pfn &&
+				end_pfn > early_node_map[i].end_pfn) {
+			early_node_map[i].end_pfn = end_pfn;
+			return;
+		}
+
+		/* Merge backward if suitable */
+		if (start_pfn < early_node_map[i].end_pfn &&
+				end_pfn >= early_node_map[i].start_pfn) {
+			early_node_map[i].start_pfn = start_pfn;
+			return;
+		}
+	}
+
+	/* Leave last entry NULL, we use range.end_pfn to terminate the walk */
+	if (i >= MAX_ACTIVE_REGIONS - 1) {
+		printk(KERN_ERR "Too many memory regions, truncating\n");
+		return;
+	}
+
+	early_node_map[i].nid = nid;
+	early_node_map[i].start_pfn = start_pfn;
+	early_node_map[i].end_pfn = end_pfn;
+}
+
+void __init shrink_active_range(unsigned int nid, unsigned long old_end_pfn,
+						unsigned long new_end_pfn)
+{
+	unsigned int i;
+
+	/* Find the old active region end and shrink */
+	for_each_active_range_index_in_nid(i, nid) {
+		if (early_node_map[i].end_pfn == old_end_pfn) {
+			early_node_map[i].end_pfn = new_end_pfn;
+			break;
+		}
+	}
+}
+
+void __init remove_all_active_ranges()
+{
+	memset(early_node_map, 0, sizeof(early_node_map));
+}
+
+/* Compare two active node_active_regions */
+static int __init cmp_node_active_region(const void *a, const void *b)
+{
+	struct node_active_region *arange = (struct node_active_region *)a;
+	struct node_active_region *brange = (struct node_active_region *)b;
+
+	/* Done this way to avoid overflows */
+	if (arange->start_pfn > brange->start_pfn)
+		return 1;
+	if (arange->start_pfn < brange->start_pfn)
+		return -1;
+
+	return 0;
+}
+
+/* sort the node_map by start_pfn */
+static void __init sort_node_map(void)
+{
+	size_t num = 0;
+	while (early_node_map[num].end_pfn)
+		num++;
+
+	sort(early_node_map, num, sizeof(struct node_active_region),
+						cmp_node_active_region, NULL);
+}
+
+/* Find the lowest pfn for a node. This depends on a sorted early_node_map */
+unsigned long __init find_min_pfn_for_node(unsigned long nid)
+{
+	int i;
+
+	/* Assuming a sorted map, the first range found has the starting pfn */
+	for_each_active_range_index_in_nid(i, nid)
+		return early_node_map[i].start_pfn;
+
+	printk(KERN_WARNING "Could not find start_pfn for node %lu\n", nid);
+	return 0;
+}
+
+unsigned long __init find_min_pfn_with_active_regions(void)
+{
+	return find_min_pfn_for_node(MAX_NUMNODES);
+}
+
+unsigned long __init find_max_pfn_with_active_regions(void)
+{
+	int i;
+	unsigned long max_pfn = 0;
+
+	for (i = 0; early_node_map[i].end_pfn; i++)
+		max_pfn = max(max_pfn, early_node_map[i].end_pfn);
+
+	return max_pfn;
+}
+
+void __init free_area_init_nodes(unsigned long arch_max_dma_pfn,
+				unsigned long arch_max_dma32_pfn,
+				unsigned long arch_max_low_pfn,
+				unsigned long arch_max_high_pfn)
+{
+	unsigned long nid;
+	int zone_index;
+
+	/* Record where the zone boundaries are */
+	memset(arch_zone_lowest_possible_pfn, 0,
+				sizeof(arch_zone_lowest_possible_pfn));
+	memset(arch_zone_highest_possible_pfn, 0,
+				sizeof(arch_zone_highest_possible_pfn));
+	arch_zone_lowest_possible_pfn[ZONE_DMA] =
+					find_min_pfn_with_active_regions();
+	arch_zone_highest_possible_pfn[ZONE_DMA] = arch_max_dma_pfn;
+	arch_zone_highest_possible_pfn[ZONE_DMA32] = arch_max_dma32_pfn;
+	arch_zone_highest_possible_pfn[ZONE_NORMAL] = arch_max_low_pfn;
+	arch_zone_highest_possible_pfn[ZONE_HIGHMEM] = arch_max_high_pfn;
+	for (zone_index = 1; zone_index < MAX_NR_ZONES; zone_index++) {
+		arch_zone_lowest_possible_pfn[zone_index] =
+			arch_zone_highest_possible_pfn[zone_index-1];
+	}
+
+	/* Regions in the early_node_map can be in any order */
+	sort_node_map();
+
+	for_each_online_node(nid) {
+		pg_data_t *pgdat = NODE_DATA(nid);
+		free_area_init_node(nid, pgdat, NULL,
+				find_min_pfn_for_node(nid), NULL);
+	}
+}
+#endif /* CONFIG_ARCH_POPULATES_NODE_MAP */
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc3-mm1-105-ia64_use_init_nodes/mm/page_alloc.c linux-2.6.17-rc3-mm1-106-breakout_mem_init/mm/page_alloc.c
--- linux-2.6.17-rc3-mm1-105-ia64_use_init_nodes/mm/page_alloc.c	2006-05-08 10:56:43.000000000 +0100
+++ linux-2.6.17-rc3-mm1-106-breakout_mem_init/mm/page_alloc.c	2006-05-08 09:22:02.000000000 +0100
@@ -38,8 +38,6 @@
 #include <linux/vmalloc.h>
 #include <linux/mempolicy.h>
 #include <linux/stop_machine.h>
-#include <linux/sort.h>
-#include <linux/pfn.h>
 
 #include <asm/tlbflush.h>
 #include "internal.h"
@@ -56,7 +54,6 @@ unsigned long totalram_pages __read_most
 unsigned long totalhigh_pages __read_mostly;
 unsigned long totalreserve_pages __read_mostly;
 long nr_swap_pages;
-int percpu_pagelist_fraction;
 
 static void __free_pages_ok(struct page *page, unsigned int order);
 
@@ -82,24 +79,11 @@ EXPORT_SYMBOL(totalram_pages);
 struct zone *zone_table[1 << ZONETABLE_SHIFT] __read_mostly;
 EXPORT_SYMBOL(zone_table);
 
-static char *zone_names[MAX_NR_ZONES] = { "DMA", "DMA32", "Normal", "HighMem" };
 int min_free_kbytes = 1024;
 
 unsigned long __meminitdata nr_kernel_pages;
 unsigned long __meminitdata nr_all_pages;
 
-#ifdef CONFIG_ARCH_POPULATES_NODE_MAP
-  #ifdef CONFIG_MAX_ACTIVE_REGIONS
-    #define MAX_ACTIVE_REGIONS CONFIG_MAX_ACTIVE_REGIONS
-  #else
-    #define MAX_ACTIVE_REGIONS (MAX_NR_ZONES * MAX_NUMNODES + 1)
-  #endif
-
-  struct node_active_region __initdata early_node_map[MAX_ACTIVE_REGIONS];
-  unsigned long __initdata arch_zone_lowest_possible_pfn[MAX_NR_ZONES];
-  unsigned long __initdata arch_zone_highest_possible_pfn[MAX_NR_ZONES];
-#endif /* CONFIG_ARCH_POPULATES_NODE_MAP */
-
 #ifdef CONFIG_DEBUG_VM
 static int page_outside_zone_boundaries(struct zone *zone, struct page *page)
 {
@@ -1593,1069 +1577,6 @@ void show_free_areas(void)
 	show_swap_cache_info();
 }
 
-/*
- * Builds allocation fallback zone lists.
- *
- * Add all populated zones of a node to the zonelist.
- */
-static int __meminit build_zonelists_node(pg_data_t *pgdat,
-			struct zonelist *zonelist, int nr_zones, int zone_type)
-{
-	struct zone *zone;
-
-	BUG_ON(zone_type > ZONE_HIGHMEM);
-
-	do {
-		zone = pgdat->node_zones + zone_type;
-		if (populated_zone(zone)) {
-#ifndef CONFIG_HIGHMEM
-			BUG_ON(zone_type > ZONE_NORMAL);
-#endif
-			zonelist->zones[nr_zones++] = zone;
-			check_highest_zone(zone_type);
-		}
-		zone_type--;
-
-	} while (zone_type >= 0);
-	return nr_zones;
-}
-
-static inline int highest_zone(int zone_bits)
-{
-	int res = ZONE_NORMAL;
-	if (zone_bits & (__force int)__GFP_HIGHMEM)
-		res = ZONE_HIGHMEM;
-	if (zone_bits & (__force int)__GFP_DMA32)
-		res = ZONE_DMA32;
-	if (zone_bits & (__force int)__GFP_DMA)
-		res = ZONE_DMA;
-	return res;
-}
-
-#ifdef CONFIG_NUMA
-#define MAX_NODE_LOAD (num_online_nodes())
-static int __meminitdata node_load[MAX_NUMNODES];
-/**
- * find_next_best_node - find the next node that should appear in a given node's fallback list
- * @node: node whose fallback list we're appending
- * @used_node_mask: nodemask_t of already used nodes
- *
- * We use a number of factors to determine which is the next node that should
- * appear on a given node's fallback list.  The node should not have appeared
- * already in @node's fallback list, and it should be the next closest node
- * according to the distance array (which contains arbitrary distance values
- * from each node to each node in the system), and should also prefer nodes
- * with no CPUs, since presumably they'll have very little allocation pressure
- * on them otherwise.
- * It returns -1 if no node is found.
- */
-static int __meminit find_next_best_node(int node, nodemask_t *used_node_mask)
-{
-	int n, val;
-	int min_val = INT_MAX;
-	int best_node = -1;
-
-	/* Use the local node if we haven't already */
-	if (!node_isset(node, *used_node_mask)) {
-		node_set(node, *used_node_mask);
-		return node;
-	}
-
-	for_each_online_node(n) {
-		cpumask_t tmp;
-
-		/* Don't want a node to appear more than once */
-		if (node_isset(n, *used_node_mask))
-			continue;
-
-		/* Use the distance array to find the distance */
-		val = node_distance(node, n);
-
-		/* Penalize nodes under us ("prefer the next node") */
-		val += (n < node);
-
-		/* Give preference to headless and unused nodes */
-		tmp = node_to_cpumask(n);
-		if (!cpus_empty(tmp))
-			val += PENALTY_FOR_NODE_WITH_CPUS;
-
-		/* Slight preference for less loaded node */
-		val *= (MAX_NODE_LOAD*MAX_NUMNODES);
-		val += node_load[n];
-
-		if (val < min_val) {
-			min_val = val;
-			best_node = n;
-		}
-	}
-
-	if (best_node >= 0)
-		node_set(best_node, *used_node_mask);
-
-	return best_node;
-}
-
-static void __meminit build_zonelists(pg_data_t *pgdat)
-{
-	int i, j, k, node, local_node;
-	int prev_node, load;
-	struct zonelist *zonelist;
-	nodemask_t used_mask;
-
-	/* initialize zonelists */
-	for (i = 0; i < GFP_ZONETYPES; i++) {
-		zonelist = pgdat->node_zonelists + i;
-		zonelist->zones[0] = NULL;
-	}
-
-	/* NUMA-aware ordering of nodes */
-	local_node = pgdat->node_id;
-	load = num_online_nodes();
-	prev_node = local_node;
-	nodes_clear(used_mask);
-	while ((node = find_next_best_node(local_node, &used_mask)) >= 0) {
-		int distance = node_distance(local_node, node);
-
-		/*
-		 * If another node is sufficiently far away then it is better
-		 * to reclaim pages in a zone before going off node.
-		 */
-		if (distance > RECLAIM_DISTANCE)
-			zone_reclaim_mode = 1;
-
-		/*
-		 * We don't want to pressure a particular node.
-		 * So adding penalty to the first node in same
-		 * distance group to make it round-robin.
-		 */
-
-		if (distance != node_distance(local_node, prev_node))
-			node_load[node] += load;
-		prev_node = node;
-		load--;
-		for (i = 0; i < GFP_ZONETYPES; i++) {
-			zonelist = pgdat->node_zonelists + i;
-			for (j = 0; zonelist->zones[j] != NULL; j++);
-
-			k = highest_zone(i);
-
-	 		j = build_zonelists_node(NODE_DATA(node), zonelist, j, k);
-			zonelist->zones[j] = NULL;
-		}
-	}
-}
-
-#else	/* CONFIG_NUMA */
-
-static void __meminit build_zonelists(pg_data_t *pgdat)
-{
-	int i, j, k, node, local_node;
-
-	local_node = pgdat->node_id;
-	for (i = 0; i < GFP_ZONETYPES; i++) {
-		struct zonelist *zonelist;
-
-		zonelist = pgdat->node_zonelists + i;
-
-		j = 0;
-		k = highest_zone(i);
- 		j = build_zonelists_node(pgdat, zonelist, j, k);
- 		/*
- 		 * Now we build the zonelist so that it contains the zones
- 		 * of all the other nodes.
- 		 * We don't want to pressure a particular node, so when
- 		 * building the zones for node N, we make sure that the
- 		 * zones coming right after the local ones are those from
- 		 * node N+1 (modulo N)
- 		 */
-		for (node = local_node + 1; node < MAX_NUMNODES; node++) {
-			if (!node_online(node))
-				continue;
-			j = build_zonelists_node(NODE_DATA(node), zonelist, j, k);
-		}
-		for (node = 0; node < local_node; node++) {
-			if (!node_online(node))
-				continue;
-			j = build_zonelists_node(NODE_DATA(node), zonelist, j, k);
-		}
-
-		zonelist->zones[j] = NULL;
-	}
-}
-
-#endif	/* CONFIG_NUMA */
-
-/* return values int ....just for stop_machine_run() */
-static int __meminit __build_all_zonelists(void *dummy)
-{
-	int nid;
-	for_each_online_node(nid)
-		build_zonelists(NODE_DATA(nid));
-	return 0;
-}
-
-void __meminit build_all_zonelists(void)
-{
-	if (system_state == SYSTEM_BOOTING) {
-		__build_all_zonelists(0);
-		cpuset_init_current_mems_allowed();
-	} else {
-		/* we have to stop all cpus to guaranntee there is no user
-		   of zonelist */
-		stop_machine_run(__build_all_zonelists, NULL, NR_CPUS);
-		/* cpuset refresh routine should be here */
-	}
-
-	printk("Built %i zonelists\n", num_online_nodes());
-
-}
-
-/*
- * Helper functions to size the waitqueue hash table.
- * Essentially these want to choose hash table sizes sufficiently
- * large so that collisions trying to wait on pages are rare.
- * But in fact, the number of active page waitqueues on typical
- * systems is ridiculously low, less than 200. So this is even
- * conservative, even though it seems large.
- *
- * The constant PAGES_PER_WAITQUEUE specifies the ratio of pages to
- * waitqueues, i.e. the size of the waitq table given the number of pages.
- */
-#define PAGES_PER_WAITQUEUE	256
-
-#ifndef CONFIG_MEMORY_HOTPLUG
-static inline unsigned long wait_table_hash_nr_entries(unsigned long pages)
-{
-	unsigned long size = 1;
-
-	pages /= PAGES_PER_WAITQUEUE;
-
-	while (size < pages)
-		size <<= 1;
-
-	/*
-	 * Once we have dozens or even hundreds of threads sleeping
-	 * on IO we've got bigger problems than wait queue collision.
-	 * Limit the size of the wait table to a reasonable size.
-	 */
-	size = min(size, 4096UL);
-
-	return max(size, 4UL);
-}
-#else
-/*
- * A zone's size might be changed by hot-add, so it is not possible to determine
- * a suitable size for its wait_table.  So we use the maximum size now.
- *
- * The max wait table size = 4096 x sizeof(wait_queue_head_t).   ie:
- *
- *    i386 (preemption config)    : 4096 x 16 = 64Kbyte.
- *    ia64, x86-64 (no preemption): 4096 x 20 = 80Kbyte.
- *    ia64, x86-64 (preemption)   : 4096 x 24 = 96Kbyte.
- *
- * The maximum entries are prepared when a zone's memory is (512K + 256) pages
- * or more by the traditional way. (See above).  It equals:
- *
- *    i386, x86-64, powerpc(4K page size) : =  ( 2G + 1M)byte.
- *    ia64(16K page size)                 : =  ( 8G + 4M)byte.
- *    powerpc (64K page size)             : =  (32G +16M)byte.
- */
-static inline unsigned long wait_table_hash_nr_entries(unsigned long pages)
-{
-	return 4096UL;
-}
-#endif
-
-/*
- * This is an integer logarithm so that shifts can be used later
- * to extract the more random high bits from the multiplicative
- * hash function before the remainder is taken.
- */
-static inline unsigned long wait_table_bits(unsigned long size)
-{
-	return ffz(~size);
-}
-
-#define LONG_ALIGN(x) (((x)+(sizeof(long))-1)&~((sizeof(long))-1))
-
-/*
- * Initially all pages are reserved - free ones are freed
- * up by free_all_bootmem() once the early boot process is
- * done. Non-atomic initialization, single-pass.
- */
-void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
-		unsigned long start_pfn)
-{
-	struct page *page;
-	unsigned long end_pfn = start_pfn + size;
-	unsigned long pfn;
-
-	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
-		if (!early_pfn_valid(pfn))
-			continue;
-		page = pfn_to_page(pfn);
-		set_page_links(page, zone, nid, pfn);
-		init_page_count(page);
-		reset_page_mapcount(page);
-		SetPageReserved(page);
-		INIT_LIST_HEAD(&page->lru);
-#ifdef WANT_PAGE_VIRTUAL
-		/* The shift won't overflow because ZONE_NORMAL is below 4G. */
-		if (!is_highmem_idx(zone))
-			set_page_address(page, __va(pfn << PAGE_SHIFT));
-#endif
-#ifdef CONFIG_PAGE_OWNER
-		page->order = -1;
-#endif
-	}
-}
-
-void zone_init_free_lists(struct pglist_data *pgdat, struct zone *zone,
-				unsigned long size)
-{
-	int order;
-	for (order = 0; order < MAX_ORDER ; order++) {
-		INIT_LIST_HEAD(&zone->free_area[order].free_list);
-		zone->free_area[order].nr_free = 0;
-	}
-}
-
-#define ZONETABLE_INDEX(x, zone_nr)	((x << ZONES_SHIFT) | zone_nr)
-void zonetable_add(struct zone *zone, int nid, int zid, unsigned long pfn,
-		unsigned long size)
-{
-	unsigned long snum = pfn_to_section_nr(pfn);
-	unsigned long end = pfn_to_section_nr(pfn + size);
-
-	if (FLAGS_HAS_NODE)
-		zone_table[ZONETABLE_INDEX(nid, zid)] = zone;
-	else
-		for (; snum <= end; snum++)
-			zone_table[ZONETABLE_INDEX(snum, zid)] = zone;
-}
-
-#ifndef __HAVE_ARCH_MEMMAP_INIT
-#define memmap_init(size, nid, zone, start_pfn) \
-	memmap_init_zone((size), (nid), (zone), (start_pfn))
-#endif
-
-static int __cpuinit zone_batchsize(struct zone *zone)
-{
-	int batch;
-
-	/*
-	 * The per-cpu-pages pools are set to around 1000th of the
-	 * size of the zone.  But no more than 1/2 of a meg.
-	 *
-	 * OK, so we don't know how big the cache is.  So guess.
-	 */
-	batch = zone->present_pages / 1024;
-	if (batch * PAGE_SIZE > 512 * 1024)
-		batch = (512 * 1024) / PAGE_SIZE;
-	batch /= 4;		/* We effectively *= 4 below */
-	if (batch < 1)
-		batch = 1;
-
-	/*
-	 * Clamp the batch to a 2^n - 1 value. Having a power
-	 * of 2 value was found to be more likely to have
-	 * suboptimal cache aliasing properties in some cases.
-	 *
-	 * For example if 2 tasks are alternately allocating
-	 * batches of pages, one task can end up with a lot
-	 * of pages of one half of the possible page colors
-	 * and the other with pages of the other colors.
-	 */
-	batch = (1 << (fls(batch + batch/2)-1)) - 1;
-
-	return batch;
-}
-
-inline void setup_pageset(struct per_cpu_pageset *p, unsigned long batch)
-{
-	struct per_cpu_pages *pcp;
-
-	memset(p, 0, sizeof(*p));
-
-	pcp = &p->pcp[0];		/* hot */
-	pcp->count = 0;
-	pcp->high = 6 * batch;
-	pcp->batch = max(1UL, 1 * batch);
-	INIT_LIST_HEAD(&pcp->list);
-
-	pcp = &p->pcp[1];		/* cold*/
-	pcp->count = 0;
-	pcp->high = 2 * batch;
-	pcp->batch = max(1UL, batch/2);
-	INIT_LIST_HEAD(&pcp->list);
-}
-
-/*
- * setup_pagelist_highmark() sets the high water mark for hot per_cpu_pagelist
- * to the value high for the pageset p.
- */
-
-static void setup_pagelist_highmark(struct per_cpu_pageset *p,
-				unsigned long high)
-{
-	struct per_cpu_pages *pcp;
-
-	pcp = &p->pcp[0]; /* hot list */
-	pcp->high = high;
-	pcp->batch = max(1UL, high/4);
-	if ((high/4) > (PAGE_SHIFT * 8))
-		pcp->batch = PAGE_SHIFT * 8;
-}
-
-
-#ifdef CONFIG_NUMA
-/*
- * Boot pageset table. One per cpu which is going to be used for all
- * zones and all nodes. The parameters will be set in such a way
- * that an item put on a list will immediately be handed over to
- * the buddy list. This is safe since pageset manipulation is done
- * with interrupts disabled.
- *
- * Some NUMA counter updates may also be caught by the boot pagesets.
- *
- * The boot_pagesets must be kept even after bootup is complete for
- * unused processors and/or zones. They do play a role for bootstrapping
- * hotplugged processors.
- *
- * zoneinfo_show() and maybe other functions do
- * not check if the processor is online before following the pageset pointer.
- * Other parts of the kernel may not check if the zone is available.
- */
-static struct per_cpu_pageset boot_pageset[NR_CPUS];
-
-/*
- * Dynamically allocate memory for the
- * per cpu pageset array in struct zone.
- */
-static int __cpuinit process_zones(int cpu)
-{
-	struct zone *zone, *dzone;
-
-	for_each_zone(zone) {
-
-		zone_pcp(zone, cpu) = kmalloc_node(sizeof(struct per_cpu_pageset),
-					 GFP_KERNEL, cpu_to_node(cpu));
-		if (!zone_pcp(zone, cpu))
-			goto bad;
-
-		setup_pageset(zone_pcp(zone, cpu), zone_batchsize(zone));
-
-		if (percpu_pagelist_fraction)
-			setup_pagelist_highmark(zone_pcp(zone, cpu),
-			 	(zone->present_pages / percpu_pagelist_fraction));
-	}
-
-	return 0;
-bad:
-	for_each_zone(dzone) {
-		if (dzone == zone)
-			break;
-		kfree(zone_pcp(dzone, cpu));
-		zone_pcp(dzone, cpu) = NULL;
-	}
-	return -ENOMEM;
-}
-
-static inline void free_zone_pagesets(int cpu)
-{
-	struct zone *zone;
-
-	for_each_zone(zone) {
-		struct per_cpu_pageset *pset = zone_pcp(zone, cpu);
-
-		zone_pcp(zone, cpu) = NULL;
-		kfree(pset);
-	}
-}
-
-static int pageset_cpuup_callback(struct notifier_block *nfb,
-		unsigned long action,
-		void *hcpu)
-{
-	int cpu = (long)hcpu;
-	int ret = NOTIFY_OK;
-
-	switch (action) {
-		case CPU_UP_PREPARE:
-			if (process_zones(cpu))
-				ret = NOTIFY_BAD;
-			break;
-		case CPU_UP_CANCELED:
-		case CPU_DEAD:
-			free_zone_pagesets(cpu);
-			break;
-		default:
-			break;
-	}
-	return ret;
-}
-
-static struct notifier_block pageset_notifier =
-	{ &pageset_cpuup_callback, NULL, 0 };
-
-void __init setup_per_cpu_pageset(void)
-{
-	int err;
-
-	/* Initialize per_cpu_pageset for cpu 0.
-	 * A cpuup callback will do this for every cpu
-	 * as it comes online
-	 */
-	err = process_zones(smp_processor_id());
-	BUG_ON(err);
-	register_cpu_notifier(&pageset_notifier);
-}
-
-#endif
-
-static __meminit
-int zone_wait_table_init(struct zone *zone, unsigned long zone_size_pages)
-{
-	int i;
-	struct pglist_data *pgdat = zone->zone_pgdat;
-	size_t alloc_size;
-
-	/*
-	 * The per-page waitqueue mechanism uses hashed waitqueues
-	 * per zone.
-	 */
-	zone->wait_table_hash_nr_entries =
-		 wait_table_hash_nr_entries(zone_size_pages);
-	zone->wait_table_bits =
-		wait_table_bits(zone->wait_table_hash_nr_entries);
-	alloc_size = zone->wait_table_hash_nr_entries
-					* sizeof(wait_queue_head_t);
-
- 	if (system_state == SYSTEM_BOOTING) {
-		zone->wait_table = (wait_queue_head_t *)
-			alloc_bootmem_node(pgdat, alloc_size);
-	} else {
-		/*
-		 * This case means that a zone whose size was 0 gets new memory
-		 * via memory hot-add.
-		 * But it may be the case that a new node was hot-added.  In
-		 * this case vmalloc() will not be able to use this new node's
-		 * memory - this wait_table must be initialized to use this new
-		 * node itself as well.
-		 * To use this new node's memory, further consideration will be
-		 * necessary.
-		 */
-		zone->wait_table = (wait_queue_head_t *)vmalloc(alloc_size);
-	}
-	if (!zone->wait_table)
-		return -ENOMEM;
-
-	for(i = 0; i < zone->wait_table_hash_nr_entries; ++i)
-		init_waitqueue_head(zone->wait_table + i);
-
-	return 0;
-}
-
-static __meminit void zone_pcp_init(struct zone *zone)
-{
-	int cpu;
-	unsigned long batch = zone_batchsize(zone);
-
-	for (cpu = 0; cpu < NR_CPUS; cpu++) {
-#ifdef CONFIG_NUMA
-		/* Early boot. Slab allocator not functional yet */
-		zone_pcp(zone, cpu) = &boot_pageset[cpu];
-		setup_pageset(&boot_pageset[cpu],0);
-#else
-		setup_pageset(zone_pcp(zone,cpu), batch);
-#endif
-	}
-	if (zone->present_pages)
-		printk(KERN_DEBUG "  %s zone: %lu pages, LIFO batch:%lu\n",
-			zone->name, zone->present_pages, batch);
-}
-
-__meminit int init_currently_empty_zone(struct zone *zone,
-					unsigned long zone_start_pfn,
-					unsigned long size)
-{
-	struct pglist_data *pgdat = zone->zone_pgdat;
-	int ret;
-	ret = zone_wait_table_init(zone, size);
-	if (ret)
-		return ret;
-	pgdat->nr_zones = zone_idx(zone) + 1;
-
-	zone->zone_start_pfn = zone_start_pfn;
-
-	memmap_init(size, pgdat->node_id, zone_idx(zone), zone_start_pfn);
-
-	zone_init_free_lists(pgdat, zone, zone->spanned_pages);
-
-	return 0;
-}
-
-#ifdef CONFIG_ARCH_POPULATES_NODE_MAP
-/* Note: nid == MAX_NUMNODES returns first region */
-static int __init first_active_region_index_in_nid(int nid)
-{
-	int i;
-	for (i = 0; early_node_map[i].end_pfn; i++) {
-		if (nid == MAX_NUMNODES || early_node_map[i].nid == nid)
-			return i;
-	}
-
-	return MAX_ACTIVE_REGIONS;
-}
-
-/* Note: nid == MAX_NUMNODES returns next region */
-static int __init next_active_region_index_in_nid(unsigned int index, int nid)
-{
-	for (index = index + 1; early_node_map[index].end_pfn; index++) {
-		if (nid == MAX_NUMNODES || early_node_map[index].nid == nid)
-			return index;
-	}
-
-	return MAX_ACTIVE_REGIONS;
-}
-
-#ifndef CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID
-int __init early_pfn_to_nid(unsigned long pfn)
-{
-	int i;
-
-	for (i = 0; early_node_map[i].end_pfn; i++) {
-		unsigned long start_pfn = early_node_map[i].start_pfn;
-		unsigned long end_pfn = early_node_map[i].end_pfn;
-
-		if ((start_pfn <= pfn) && (pfn < end_pfn))
-			return early_node_map[i].nid;
-	}
-
-	return -1;
-}
-#endif /* CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID */
-
-#define for_each_active_range_index_in_nid(i, nid) \
-	for (i = first_active_region_index_in_nid(nid); \
-				i != MAX_ACTIVE_REGIONS; \
-				i = next_active_region_index_in_nid(i, nid))
-
-void __init free_bootmem_with_active_regions(int nid,
-						unsigned long max_low_pfn)
-{
-	unsigned int i;
-	for_each_active_range_index_in_nid(i, nid) {
-		unsigned long size_pages = 0;
-		unsigned long end_pfn = early_node_map[i].end_pfn;
-		if (early_node_map[i].start_pfn >= max_low_pfn)
-			continue;
-
-		if (end_pfn > max_low_pfn)
-			end_pfn = max_low_pfn;
-
-		size_pages = end_pfn - early_node_map[i].start_pfn;
-		free_bootmem_node(NODE_DATA(early_node_map[i].nid),
-				PFN_PHYS(early_node_map[i].start_pfn),
-				size_pages << PAGE_SHIFT);
-	}
-}
-
-void __init sparse_memory_present_with_active_regions(int nid)
-{
-	unsigned int i;
-	for_each_active_range_index_in_nid(i, nid)
-		memory_present(early_node_map[i].nid,
-				early_node_map[i].start_pfn,
-				early_node_map[i].end_pfn);
-}
-
-void __init get_pfn_range_for_nid(unsigned int nid,
-			unsigned long *start_pfn, unsigned long *end_pfn)
-{
-	unsigned int i;
-	*start_pfn = -1UL;
-	*end_pfn = 0;
-
-	for_each_active_range_index_in_nid(i, nid) {
-		*start_pfn = min(*start_pfn, early_node_map[i].start_pfn);
-		*end_pfn = max(*end_pfn, early_node_map[i].end_pfn);
-	}
-
-	if (*start_pfn == -1UL) {
-		printk(KERN_WARNING "Node %u active with no memory\n", nid);
-		*start_pfn = 0;
-	}
-}
-
-unsigned long __init zone_present_pages_in_node(int nid,
-					unsigned long zone_type,
-					unsigned long *ignored)
-{
-	unsigned long node_start_pfn, node_end_pfn;
-	unsigned long zone_start_pfn, zone_end_pfn;
-
-	/* Get the start and end of the node and zone */
-	get_pfn_range_for_nid(nid, &node_start_pfn, &node_end_pfn);
-	zone_start_pfn = arch_zone_lowest_possible_pfn[zone_type];
-	zone_end_pfn = arch_zone_highest_possible_pfn[zone_type];
-
-	/* Check that this node has pages within the zone's required range */
-	if (zone_end_pfn < node_start_pfn || zone_start_pfn > node_end_pfn)
-		return 0;
-
-	/* Move the zone boundaries inside the node if necessary */
-	zone_end_pfn = min(zone_end_pfn, node_end_pfn);
-	zone_start_pfn = max(zone_start_pfn, node_start_pfn);
-
-	/* Return the spanned pages */
-	return zone_end_pfn - zone_start_pfn;
-}
-
-unsigned long __init __absent_pages_in_range(int nid,
-				unsigned long range_start_pfn,
-				unsigned long range_end_pfn)
-{
-	int i = 0;
-	unsigned long prev_end_pfn = 0, hole_pages = 0;
-	unsigned long start_pfn;
-
-	/* Find the end_pfn of the first active range of pfns in the node */
-	i = first_active_region_index_in_nid(nid);
-	if (i == MAX_ACTIVE_REGIONS)
-		return 0;
-	prev_end_pfn = early_node_map[i].start_pfn;
-
-	/* Find all holes for the zone within the node */
-	for (; i != MAX_ACTIVE_REGIONS;
-			i = next_active_region_index_in_nid(i, nid)) {
-
-		/* No need to continue if prev_end_pfn is outside the zone */
-		if (prev_end_pfn >= range_end_pfn)
-			break;
-
-		/* Make sure the end of the zone is not within the hole */
-		start_pfn = min(early_node_map[i].start_pfn, range_end_pfn);
-		prev_end_pfn = max(prev_end_pfn, range_start_pfn);
-
-		/* Update the hole size cound and move on */
-		if (start_pfn > range_start_pfn) {
-			BUG_ON(prev_end_pfn > start_pfn);
-			hole_pages += start_pfn - prev_end_pfn;
-		}
-		prev_end_pfn = early_node_map[i].end_pfn;
-	}
-
-	return hole_pages;
-}
-
-unsigned long __init absent_pages_in_range(unsigned long start_pfn,
-							unsigned long end_pfn)
-{
-	return __absent_pages_in_range(MAX_NUMNODES, start_pfn, end_pfn);
-}
-
-unsigned long __init zone_absent_pages_in_node(int nid,
-					unsigned long zone_type,
-					unsigned long *ignored)
-{
-	return __absent_pages_in_range(nid,
-				arch_zone_lowest_possible_pfn[zone_type],
-				arch_zone_highest_possible_pfn[zone_type]);
-}
-#else
-static inline unsigned long zone_present_pages_in_node(int nid,
-					unsigned long zone_type,
-					unsigned long *zones_size)
-{
-	return zones_size[zone_type];
-}
-
-static inline unsigned long zone_absent_pages_in_node(int nid,
-						unsigned long zone_type,
-						unsigned long *zholes_size)
-{
-	if (!zholes_size)
-		return 0;
-
-	return zholes_size[zone_type];
-}
-#endif
-
-static void __init calculate_node_totalpages(struct pglist_data *pgdat,
-		unsigned long *zones_size, unsigned long *zholes_size)
-{
-	unsigned long realtotalpages, totalpages = 0;
-	int i;
-
-	for (i = 0; i < MAX_NR_ZONES; i++) {
-		totalpages += zone_present_pages_in_node(pgdat->node_id, i,
-								zones_size);
-	}
-	pgdat->node_spanned_pages = totalpages;
-
-	realtotalpages = totalpages;
-	for (i = 0; i < MAX_NR_ZONES; i++) {
-		realtotalpages -=
-			zone_absent_pages_in_node(pgdat->node_id, i, zholes_size);
-	}
-	pgdat->node_present_pages = realtotalpages;
-	printk(KERN_DEBUG "On node %d totalpages: %lu\n", pgdat->node_id,
-							realtotalpages);
-}
-
-/*
- * Set up the zone data structures:
- *   - mark all pages reserved
- *   - mark all memory queues empty
- *   - clear the memory bitmaps
- */
-static void __meminit free_area_init_core(struct pglist_data *pgdat,
-		unsigned long *zones_size, unsigned long *zholes_size)
-{
-	unsigned long j;
-	int nid = pgdat->node_id;
-	unsigned long zone_start_pfn = pgdat->node_start_pfn;
-	int ret;
-
-	pgdat_resize_init(pgdat);
-	pgdat->nr_zones = 0;
-	init_waitqueue_head(&pgdat->kswapd_wait);
-	pgdat->kswapd_max_order = 0;
-	
-	for (j = 0; j < MAX_NR_ZONES; j++) {
-		struct zone *zone = pgdat->node_zones + j;
-		unsigned long size, realsize;
-
-		size = zone_present_pages_in_node(nid, j, zones_size);
-		realsize = size - zone_absent_pages_in_node(nid, j,
-								zholes_size);
-		if (j < ZONE_HIGHMEM)
-			nr_kernel_pages += realsize;
-		nr_all_pages += realsize;
-
-		zone->spanned_pages = size;
-		zone->present_pages = realsize;
-		zone->name = zone_names[j];
-		spin_lock_init(&zone->lock);
-		spin_lock_init(&zone->lru_lock);
-		zone_seqlock_init(zone);
-		zone->zone_pgdat = pgdat;
-		zone->free_pages = 0;
-
-		zone->temp_priority = zone->prev_priority = DEF_PRIORITY;
-
-		zone_pcp_init(zone);
-		INIT_LIST_HEAD(&zone->active_list);
-		INIT_LIST_HEAD(&zone->inactive_list);
-		zone->nr_scan_active = 0;
-		zone->nr_scan_inactive = 0;
-		zone->nr_active = 0;
-		zone->nr_inactive = 0;
-		atomic_set(&zone->reclaim_in_progress, 0);
-		if (!size)
-			continue;
-
-		zonetable_add(zone, nid, j, zone_start_pfn, size);
-		ret = init_currently_empty_zone(zone, zone_start_pfn, size);
-		BUG_ON(ret);
-		zone_start_pfn += size;
-	}
-}
-
-static void __init alloc_node_mem_map(struct pglist_data *pgdat)
-{
-	/* Skip empty nodes */
-	if (!pgdat->node_spanned_pages)
-		return;
-
-#ifdef CONFIG_FLAT_NODE_MEM_MAP
-	/* ia64 gets its own node_mem_map, before this, without bootmem */
-	if (!pgdat->node_mem_map) {
-		unsigned long size;
-		struct page *map;
-
-		size = (pgdat->node_spanned_pages + 1) * sizeof(struct page);
-		map = alloc_remap(pgdat->node_id, size);
-		if (!map)
-			map = alloc_bootmem_node(pgdat, size);
-		pgdat->node_mem_map = map;
-	}
-#ifdef CONFIG_FLATMEM
-	/*
-	 * With no DISCONTIG, the global mem_map is just set as node 0's
-	 */
-	if (pgdat == NODE_DATA(0))
-		mem_map = NODE_DATA(0)->node_mem_map;
-#endif
-#endif /* CONFIG_FLAT_NODE_MEM_MAP */
-}
-
-void __meminit free_area_init_node(int nid, struct pglist_data *pgdat,
-		unsigned long *zones_size, unsigned long node_start_pfn,
-		unsigned long *zholes_size)
-{
-	pgdat->node_id = nid;
-	pgdat->node_start_pfn = node_start_pfn;
-	calculate_node_totalpages(pgdat, zones_size, zholes_size);
-
-	alloc_node_mem_map(pgdat);
-
-	free_area_init_core(pgdat, zones_size, zholes_size);
-}
-
-#ifdef CONFIG_ARCH_POPULATES_NODE_MAP
-void __init add_active_range(unsigned int nid, unsigned long start_pfn,
-						unsigned long end_pfn)
-{
-	unsigned int i;
-	printk(KERN_DEBUG "Range (%d) %lu -> %lu\n", nid, start_pfn, end_pfn);
-
-	/* Merge with existing active regions if possible */
-	for (i = 0; early_node_map[i].end_pfn; i++) {
-		if (early_node_map[i].nid != nid)
-			continue;
-
-		/* Skip if an existing region covers this new one */
-		if (start_pfn >= early_node_map[i].start_pfn &&
-				end_pfn <= early_node_map[i].end_pfn)
-			return;
-
-		/* Merge forward if suitable */
-		if (start_pfn <= early_node_map[i].end_pfn &&
-				end_pfn > early_node_map[i].end_pfn) {
-			early_node_map[i].end_pfn = end_pfn;
-			return;
-		}
-
-		/* Merge backward if suitable */
-		if (start_pfn < early_node_map[i].end_pfn &&
-				end_pfn >= early_node_map[i].start_pfn) {
-			early_node_map[i].start_pfn = start_pfn;
-			return;
-		}
-	}
-
-	/* Leave last entry NULL, we use range.end_pfn to terminate the walk */
-	if (i >= MAX_ACTIVE_REGIONS - 1) {
-		printk(KERN_ERR "Too many memory regions, truncating\n");
-		return;
-	}
-
-	early_node_map[i].nid = nid;
-	early_node_map[i].start_pfn = start_pfn;
-	early_node_map[i].end_pfn = end_pfn;
-}
-
-void __init shrink_active_range(unsigned int nid, unsigned long old_end_pfn,
-						unsigned long new_end_pfn)
-{
-	unsigned int i;
-
-	/* Find the old active region end and shrink */
-	for_each_active_range_index_in_nid(i, nid) {
-		if (early_node_map[i].end_pfn == old_end_pfn) {
-			early_node_map[i].end_pfn = new_end_pfn;
-			break;
-		}
-	}
-}
-
-void __init remove_all_active_ranges()
-{
-	memset(early_node_map, 0, sizeof(early_node_map));
-}
-
-/* Compare two active node_active_regions */
-static int __init cmp_node_active_region(const void *a, const void *b)
-{
-	struct node_active_region *arange = (struct node_active_region *)a;
-	struct node_active_region *brange = (struct node_active_region *)b;
-
-	/* Done this way to avoid overflows */
-	if (arange->start_pfn > brange->start_pfn)
-		return 1;
-	if (arange->start_pfn < brange->start_pfn)
-		return -1;
-
-	return 0;
-}
-
-/* sort the node_map by start_pfn */
-static void __init sort_node_map(void)
-{
-	size_t num = 0;
-	while (early_node_map[num].end_pfn)
-		num++;
-
-	sort(early_node_map, num, sizeof(struct node_active_region),
-						cmp_node_active_region, NULL);
-}
-
-/* Find the lowest pfn for a node. This depends on a sorted early_node_map */
-unsigned long __init find_min_pfn_for_node(unsigned long nid)
-{
-	int i;
-
-	/* Assuming a sorted map, the first range found has the starting pfn */
-	for_each_active_range_index_in_nid(i, nid)
-		return early_node_map[i].start_pfn;
-
-	printk(KERN_WARNING "Could not find start_pfn for node %lu\n", nid);
-	return 0;
-}
-
-unsigned long __init find_min_pfn_with_active_regions(void)
-{
-	return find_min_pfn_for_node(MAX_NUMNODES);
-}
-
-unsigned long __init find_max_pfn_with_active_regions(void)
-{
-	int i;
-	unsigned long max_pfn = 0;
-
-	for (i = 0; early_node_map[i].end_pfn; i++)
-		max_pfn = max(max_pfn, early_node_map[i].end_pfn);
-
-	return max_pfn;
-}
-
-void __init free_area_init_nodes(unsigned long arch_max_dma_pfn,
-				unsigned long arch_max_dma32_pfn,
-				unsigned long arch_max_low_pfn,
-				unsigned long arch_max_high_pfn)
-{
-	unsigned long nid;
-	int zone_index;
-
-	/* Record where the zone boundaries are */
-	memset(arch_zone_lowest_possible_pfn, 0,
-				sizeof(arch_zone_lowest_possible_pfn));
-	memset(arch_zone_highest_possible_pfn, 0,
-				sizeof(arch_zone_highest_possible_pfn));
-	arch_zone_lowest_possible_pfn[ZONE_DMA] =
-					find_min_pfn_with_active_regions();
-	arch_zone_highest_possible_pfn[ZONE_DMA] = arch_max_dma_pfn;
-	arch_zone_highest_possible_pfn[ZONE_DMA32] = arch_max_dma32_pfn;
-	arch_zone_highest_possible_pfn[ZONE_NORMAL] = arch_max_low_pfn;
-	arch_zone_highest_possible_pfn[ZONE_HIGHMEM] = arch_max_high_pfn;
-	for (zone_index = 1; zone_index < MAX_NR_ZONES; zone_index++) {
-		arch_zone_lowest_possible_pfn[zone_index] =
-			arch_zone_highest_possible_pfn[zone_index-1];
-	}
-
-	/* Regions in the early_node_map can be in any order */
-	sort_node_map();
-
-	for_each_online_node(nid) {
-		pg_data_t *pgdat = NODE_DATA(nid);
-		free_area_init_node(nid, pgdat, NULL,
-				find_min_pfn_for_node(nid), NULL);
-	}
-}
-#endif /* CONFIG_ARCH_POPULATES_NODE_MAP */
-
 #ifndef CONFIG_NEED_MULTIPLE_NODES
 static bootmem_data_t contig_bootmem_data;
 struct pglist_data contig_page_data = { .bdata = &contig_bootmem_data };
@@ -3176,32 +2097,6 @@ int lowmem_reserve_ratio_sysctl_handler(
 	return 0;
 }
 
-/*
- * percpu_pagelist_fraction - changes the pcp->high for each zone on each
- * cpu.  It is the fraction of total pages in each zone that a hot per cpu pagelist
- * can have before it gets flushed back to buddy allocator.
- */
-
-int percpu_pagelist_fraction_sysctl_handler(ctl_table *table, int write,
-	struct file *file, void __user *buffer, size_t *length, loff_t *ppos)
-{
-	struct zone *zone;
-	unsigned int cpu;
-	int ret;
-
-	ret = proc_dointvec_minmax(table, write, file, buffer, length, ppos);
-	if (!write || (ret == -EINVAL))
-		return ret;
-	for_each_zone(zone) {
-		for_each_online_cpu(cpu) {
-			unsigned long  high;
-			high = zone->present_pages / percpu_pagelist_fraction;
-			setup_pagelist_highmark(zone_pcp(zone, cpu), high);
-		}
-	}
-	return 0;
-}
-
 __initdata int hashdist = HASHDIST_DEFAULT;
 
 #ifdef CONFIG_NUMA
