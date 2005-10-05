Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965187AbVJEOqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965187AbVJEOqc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 10:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932646AbVJEOqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 10:46:30 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:2959 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932640AbVJEOqZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 10:46:25 -0400
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: akpm@osdl.org, Mel Gorman <mel@csn.ul.ie>, kravetz@us.ibm.com,
       linux-kernel@vger.kernel.org, jschopp@austin.ibm.com,
       lhms-devel@lists.sourceforge.net
Message-Id: <20051005144623.11796.99869.sendpatchset@skynet.csn.ul.ie>
In-Reply-To: <20051005144546.11796.1154.sendpatchset@skynet.csn.ul.ie>
References: <20051005144546.11796.1154.sendpatchset@skynet.csn.ul.ie>
Subject: [PATCH 7/7] Fragmentation Avoidance V16: 007_stats
Date: Wed,  5 Oct 2005 15:46:23 +0100 (IST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is not necessary to apply this patch to get all the anti-fragmentation
code. This patch adds a new config option called CONFIG_ALLOCSTATS. If
set, a number of new bean counters are added that are related to the
anti-fragmentation code. The information is exported via /proc/buddyinfo. This
is very useful when debugging why high-order pages are not available for
allocation.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc3-006_percpu/include/linux/mmzone.h linux-2.6.14-rc3-007_stats/include/linux/mmzone.h
--- linux-2.6.14-rc3-006_percpu/include/linux/mmzone.h	2005-10-05 12:26:56.000000000 +0100
+++ linux-2.6.14-rc3-007_stats/include/linux/mmzone.h	2005-10-05 12:29:57.000000000 +0100
@@ -176,6 +176,19 @@ struct zone {
 	unsigned long		fallback_reserve;
 	long			fallback_balance;
 
+#ifdef CONFIG_ALLOCSTATS
+	/*
+	 * These are beancounters that track how the placement policy
+	 * of the buddy allocator is performing
+	 */
+	unsigned long fallback_count[RCLM_TYPES];
+	unsigned long alloc_count[RCLM_TYPES];
+	unsigned long reserve_count[RCLM_TYPES];
+	unsigned long kernnorclm_full_steal;
+	unsigned long kernnorclm_partial_steal;
+#endif
+
+
 	ZONE_PADDING(_pad1_)
 
 	/* Fields commonly accessed by the page reclaim scanner */
@@ -265,6 +278,17 @@ struct zone {
 	char			*name;
 } ____cacheline_maxaligned_in_smp;
 
+#ifdef CONFIG_ALLOCSTATS
+#define inc_fallback_count(zone, type) zone->fallback_count[type]++
+#define inc_alloc_count(zone, type) zone->alloc_count[type]++
+#define inc_kernnorclm_partial_steal(zone) zone->kernnorclm_partial_steal++
+#define inc_kernnorclm_full_steal(zone) zone->kernnorclm_full_steal++
+#else
+#define inc_fallback_count(zone, type) do {} while (0)
+#define inc_alloc_count(zone, type) do {} while (0)
+#define inc_kernnorclm_partial_steal(zone) do {} while (0)
+#define inc_kernnorclm_full_steal(zone) do {} while (0)
+#endif
 
 /*
  * The "priority" of VM scanning is how much of the queues we will scan in one
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc3-006_percpu/lib/Kconfig.debug linux-2.6.14-rc3-007_stats/lib/Kconfig.debug
--- linux-2.6.14-rc3-006_percpu/lib/Kconfig.debug	2005-10-04 22:58:34.000000000 +0100
+++ linux-2.6.14-rc3-007_stats/lib/Kconfig.debug	2005-10-05 12:29:57.000000000 +0100
@@ -77,6 +77,17 @@ config SCHEDSTATS
 	  application, you can say N to avoid the very slight overhead
 	  this adds.
 
+config ALLOCSTATS
+	bool "Collection buddy allocator statistics"
+	depends on DEBUG_KERNEL && PROC_FS
+	help
+	  If you say Y here, additional code will be inserted into the
+	  page allocator routines to collect statistics on the allocator
+	  behavior and provide them in /proc/buddyinfo. These stats are
+	  useful for measuring fragmentation in the buddy allocator. If
+	  you are not debugging or measuring the allocator, you can say N
+	  to avoid the slight overhead this adds.
+
 config DEBUG_SLAB
 	bool "Debug memory allocations"
 	depends on DEBUG_KERNEL
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc3-006_percpu/mm/page_alloc.c linux-2.6.14-rc3-007_stats/mm/page_alloc.c
--- linux-2.6.14-rc3-006_percpu/mm/page_alloc.c	2005-10-05 12:27:48.000000000 +0100
+++ linux-2.6.14-rc3-007_stats/mm/page_alloc.c	2005-10-05 12:29:57.000000000 +0100
@@ -191,6 +191,11 @@ EXPORT_SYMBOL(zone_table);
 static char *zone_names[MAX_NR_ZONES] = { "DMA", "Normal", "HighMem" };
 int min_free_kbytes = 1024;
 
+#ifdef CONFIG_ALLOCSTATS
+static char *type_names[RCLM_TYPES] = { "KernNoRclm", "UserRclm",
+					"KernRclm", "Fallback"};
+#endif /* CONFIG_ALLOCSTATS */
+
 unsigned long __initdata nr_kernel_pages;
 unsigned long __initdata nr_all_pages;
 
@@ -675,6 +680,9 @@ fallback_buddy_reserve(int start_allocty
 
 		set_pageblock_type(zone, page, reserve_type);
 		inc_reserve_count(zone, reserve_type);
+		inc_kernnorclm_full_steal(zone);
+	} else {
+		inc_kernnorclm_partial_steal(zone);
 	}
 	return area;
 }
@@ -714,6 +722,15 @@ fallback_alloc(int alloctype, struct zon
 					current_order, area);
 
 		}
+
+		/*
+		 * If the current alloctype is RCLM_FALLBACK, it means
+		 * that the requested pool and fallback pool are both
+		 * depleted and we are falling back to other pools.
+		 * At this point, pools are starting to get fragmented
+		 */
+		if (alloctype == RCLM_FALLBACK)
+			inc_fallback_count(zone, start_alloctype);
 	}
 
 	return NULL;
@@ -730,6 +747,8 @@ static struct page *__rmqueue(struct zon
 	unsigned int current_order;
 	struct page *page;
 
+	inc_alloc_count(zone, alloctype);
+
 	for (current_order = order; current_order < MAX_ORDER; ++current_order) {
 		area = &(zone->free_area_lists[alloctype][current_order]);
 		if (list_empty(&area->free_list))
@@ -2319,6 +2338,20 @@ static void __init free_area_init_core(s
 		zone_start_pfn += size;
 
 		zone_init_free_lists(pgdat, zone, zone->spanned_pages);
+
+#ifdef CONFIG_ALLOCSTAT
+		memset((unsigned long *)zone->fallback_count, 0,
+				sizeof(zone->fallback_count));
+		memset((unsigned long *)zone->alloc_count, 0,
+				sizeof(zone->alloc_count));
+		memset((unsigned long *)zone->alloc_count, 0,
+				sizeof(zone->alloc_count));
+		zone->kernnorclm_partial_steal=0;
+		zone->kernnorclm_full_steal=0;
+		zone->reserve_count[RCLM_NORCLM] =
+				realsize >> (MAX_ORDER-1);
+#endif
+
 	}
 }
 
@@ -2415,6 +2448,18 @@ static int frag_show(struct seq_file *m,
 	int order, type;
 	struct free_area *area;
 	unsigned long nr_bufs = 0;
+#ifdef CONFIG_ALLOCSTATS
+	int i;
+	unsigned long kernnorclm_full_steal=0;
+	unsigned long kernnorclm_partial_steal=0;
+	unsigned long reserve_count[RCLM_TYPES];
+	unsigned long fallback_count[RCLM_TYPES];
+	unsigned long alloc_count[RCLM_TYPES];
+
+	memset(reserve_count, 0, sizeof(reserve_count));
+	memset(fallback_count, 0, sizeof(fallback_count));
+	memset(alloc_count, 0, sizeof(alloc_count));
+#endif
 
 	for (zone = node_zones; zone - node_zones < MAX_NR_ZONES; ++zone) {
 		if (!zone->present_pages)
@@ -2435,6 +2480,79 @@ static int frag_show(struct seq_file *m,
 		spin_unlock_irqrestore(&zone->lock, flags);
 		seq_putc(m, '\n');
 	}
+
+#ifdef CONFIG_ALLOCSTATS
+ 	/* Show statistics for each allocation type */
+ 	seq_printf(m, "\nPer-allocation-type statistics");
+ 	for (zone = node_zones; zone - node_zones < MAX_NR_ZONES; ++zone) {
+ 		if (!zone->present_pages)
+ 			continue;
+ 
+ 		spin_lock_irqsave(&zone->lock, flags);
+ 		for (type=0; type < RCLM_TYPES; type++) {
+			struct list_head *elem;
+ 			seq_printf(m, "\nNode %d, zone %8s, type %10s ", 
+ 					pgdat->node_id, zone->name,
+ 					type_names[type]);
+ 			for (order = 0; order < MAX_ORDER; ++order) {
+ 				nr_bufs = 0;
+
+ 				list_for_each(elem, &(zone->free_area_lists[type][order].free_list))
+ 					++nr_bufs;
+ 				seq_printf(m, "%6lu ", nr_bufs);
+ 			}
+		}
+ 
+ 		/* Scan global list */
+ 		seq_printf(m, "\n");
+ 		seq_printf(m, "Node %d, zone %8s, type %10s", 
+ 					pgdat->node_id, zone->name,
+ 					"MAX_ORDER");
+		nr_bufs = 0;
+		for (type=0; type < RCLM_TYPES; type++) {
+			nr_bufs += zone->free_area_lists[type][MAX_ORDER-1].nr_free;
+		}
+ 		seq_printf(m, "%6lu ", nr_bufs);
+		seq_printf(m, "\n");
+
+ 		seq_printf(m, "%s Zone beancounters\n", zone->name);
+		seq_printf(m, "Fallback balance: %d\n", (int)zone->fallback_balance);
+		seq_printf(m, "Fallback reserve: %d\n", (int)zone->fallback_reserve);
+		seq_printf(m, "Partial steal:    %lu\n", zone->kernnorclm_partial_steal);
+		seq_printf(m, "Full steal:       %lu\n", zone->kernnorclm_full_steal);
+
+		kernnorclm_partial_steal += zone->kernnorclm_partial_steal;
+		kernnorclm_full_steal += zone->kernnorclm_full_steal;
+		seq_putc(m, '\n');
+
+		for (i=0; i< RCLM_TYPES; i++) {
+			seq_printf(m, "%-10s Allocs: %-10lu Reserve: %-10lu Fallbacks: %-10lu\n",
+					type_names[i],
+					zone->alloc_count[i],
+					zone->reserve_count[i],
+					zone->fallback_count[i]);
+			alloc_count[i] += zone->alloc_count[i];
+			reserve_count[i] += zone->reserve_count[i];
+			fallback_count[i] += zone->fallback_count[i];
+		}
+
+		spin_unlock_irqrestore(&zone->lock, flags);
+	}
+
+
+ 	/* Show bean counters */
+ 	seq_printf(m, "\nGlobal beancounters\n");
+	seq_printf(m, "Partial steal:    %lu\n", kernnorclm_partial_steal);
+	seq_printf(m, "Full steal:       %lu\n", kernnorclm_full_steal);
+
+	for (i=0; i< RCLM_TYPES; i++) {
+ 		seq_printf(m, "%-10s Allocs: %-10lu Reserve: %-10lu Fallbacks: %-10lu\n", 
+				type_names[i], 
+				alloc_count[i],
+				reserve_count[i],
+				fallback_count[i]);
+	}
+#endif /* CONFIG_ALLOCSTATS */
 	return 0;
 }
 
