Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261473AbVFARyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbVFARyP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 13:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbVFARyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 13:54:14 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:666 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261473AbVFARs1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 13:48:27 -0400
Date: Wed, 1 Jun 2005 10:48:17 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: akpm@osdl.org
cc: linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Periodically drain non local pagesets
Message-ID: <Pine.LNX.4.62.0506011047060.9277@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The pageset array can potentially acquire a huge amount of memory on large
NUMA systems. F.e. on a system with 512 processors and 256 nodes there will
be 256*512 pagesets. If each pageset only holds 5 pages then we are talking about
655360 pages.With a 16K page size on IA64 this results in potentially 10 Gigabytes
of memory being trapped in pagesets. The typical cases are much less for smaller
systems but there is still the potential of memory being trapped in off node
pagesets. Off node memory may be rarely used if local memory is available and so
we may potentially have memory in seldom used pagesets without this patch.

The slab allocator flushes its per cpu caches every 2 seconds. The following patch
flushes the off node pageset caches in the same way by tying into the slab flush.

The patch also changes /proc/zoneinfo to include the number of
pages currently in each pageset.

Patch against 2.6.12-rc5-mm1

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.12-rc5/include/linux/gfp.h
===================================================================
--- linux-2.6.12-rc5.orig/include/linux/gfp.h	2005-05-27 16:39:48.000000000 -0700
+++ linux-2.6.12-rc5/include/linux/gfp.h	2005-06-01 10:40:04.000000000 -0700
@@ -135,5 +135,10 @@ extern void FASTCALL(free_cold_page(stru
 #define free_page(addr) free_pages((addr),0)
 
 void page_alloc_init(void);
+#ifdef CONFIG_NUMA
+void drain_remote_pages(void);
+#else
+static inline void drain_remote_pages(void) { };
+#endif
 
 #endif /* __LINUX_GFP_H */
Index: linux-2.6.12-rc5/mm/page_alloc.c
===================================================================
--- linux-2.6.12-rc5.orig/mm/page_alloc.c	2005-05-27 16:40:20.000000000 -0700
+++ linux-2.6.12-rc5/mm/page_alloc.c	2005-06-01 10:41:25.000000000 -0700
@@ -515,6 +515,36 @@ static int rmqueue_bulk(struct zone *zon
 	return allocated;
 }
 
+#ifdef CONFIG_NUMA
+/* Called from the slab reaper to drain remote pagesets */
+void drain_remote_pages(void)
+{
+	struct zone *zone;
+	int i;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	for_each_zone(zone) {
+		struct per_cpu_pageset *pset;
+
+		/* Do not drain local pagesets */
+		if (zone == zone_table[numa_node_id()])
+			continue;
+
+		pset = zone->pageset[smp_processor_id()];
+		for (i = 0; i < ARRAY_SIZE(pset->pcp); i++) {
+			struct per_cpu_pages *pcp;
+
+			pcp = &pset->pcp[i];
+			if (pcp->count)
+				pcp->count -= free_pages_bulk(zone, pcp->count,
+						&pcp->list, 0);
+		}
+	}
+	local_irq_restore(flags);
+}
+#endif
+
 #if defined(CONFIG_PM) || defined(CONFIG_HOTPLUG_CPU)
 static void __drain_pages(unsigned int cpu)
 {
@@ -1385,12 +1415,13 @@ void show_free_areas(void)
 			pageset = zone_pcp(zone, cpu);
 
 			for (temperature = 0; temperature < 2; temperature++)
-				printk("cpu %d %s: low %d, high %d, batch %d\n",
+				printk("cpu %d %s: low %d, high %d, batch %d used:%d\n",
 					cpu,
 					temperature ? "cold" : "hot",
 					pageset->pcp[temperature].low,
 					pageset->pcp[temperature].high,
-					pageset->pcp[temperature].batch);
+					pageset->pcp[temperature].batch,
+					pageset->pcp[temperature].count);
 		}
 	}
 
Index: linux-2.6.12-rc5/mm/slab.c
===================================================================
--- linux-2.6.12-rc5.orig/mm/slab.c	2005-05-27 16:41:36.000000000 -0700
+++ linux-2.6.12-rc5/mm/slab.c	2005-06-01 10:22:18.000000000 -0700
@@ -3471,6 +3471,7 @@ next:
 	}
 	check_irq_on();
 	up(&cache_chain_sem);
+	drain_remote_pages();
 	/* Setup the next iteration */
 	schedule_delayed_work(&__get_cpu_var(reap_work), REAPTIMEOUT_CPUC + smp_processor_id());
 }
