Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932420AbWEZMAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbWEZMAN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 08:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbWEZL74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 07:59:56 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:63193 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932410AbWEZLxE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 07:53:04 -0400
Message-ID: <348644381.06563@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060526115306.535453644@localhost.localdomain>
References: <20060526113906.084341801@localhost.localdomain>
Date: Fri, 26 May 2006 19:39:20 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 14/33] readahead: state based method - aging accounting
Content-Disposition: inline; filename=readahead-method-stateful-aging.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Collect info about the global available memory and its consumption speed.
The data are used by the stateful method to estimate the thrashing threshold.

They are the decisive factor of the correctness/accuracy of the resulting
read-ahead size.

- On NUMA systems, the accountings are done on a per-node basis. It works for
  the two common real-world schemes:
	  - the reader process allocates caches in a node affined manner;
	  - the reader process allocates caches _balancely_ from a set of nodes.

- On non-NUMA systems, the readahead_aging is mainly increased on first
  access of the read-ahead pages, in order to make it go up constantly and
  smoothly. It helps improve the accuracy on small/fast read-aheads, with
  the cost of a little more overhead.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 include/linux/mm.h     |    9 +++++++++
 include/linux/mmzone.h |    5 +++++
 mm/Kconfig             |    5 +++++
 mm/readahead.c         |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
 mm/swap.c              |    2 ++
 mm/vmscan.c            |    4 ++++
 6 files changed, 74 insertions(+)

--- linux-2.6.17-rc4-mm3.orig/mm/Kconfig
+++ linux-2.6.17-rc4-mm3/mm/Kconfig
@@ -203,3 +203,8 @@ config DEBUG_READAHEAD
 	  echo 1 > /debug/readahead/debug_level # stop filling my kern.log
 
 	  Say N for production servers.
+
+config READAHEAD_SMOOTH_AGING
+	def_bool n if NUMA
+	default y if !NUMA
+	depends on ADAPTIVE_READAHEAD
--- linux-2.6.17-rc4-mm3.orig/include/linux/mmzone.h
+++ linux-2.6.17-rc4-mm3/include/linux/mmzone.h
@@ -161,6 +161,11 @@ struct zone {
 	unsigned long		pages_scanned;	   /* since last reclaim */
 	int			all_unreclaimable; /* All pages pinned */
 
+	/* The accumulated number of activities that may cause page aging,
+	 * that is, make some pages closer to the tail of inactive_list.
+	 */
+	unsigned long 		aging_total;
+
 	/* A count of how many reclaimers are scanning this zone */
 	atomic_t		reclaim_in_progress;
 
--- linux-2.6.17-rc4-mm3.orig/include/linux/mm.h
+++ linux-2.6.17-rc4-mm3/include/linux/mm.h
@@ -1044,6 +1044,15 @@ static inline int prefer_adaptive_readah
 	return readahead_ratio >= 10;
 }
 
+DECLARE_PER_CPU(unsigned long, readahead_aging);
+static inline void inc_readahead_aging(void)
+{
+#ifdef CONFIG_READAHEAD_SMOOTH_AGING
+	if (prefer_adaptive_readahead())
+		per_cpu(readahead_aging, raw_smp_processor_id())++;
+#endif
+}
+
 /* Do stack extension */
 extern int expand_stack(struct vm_area_struct *vma, unsigned long address);
 #ifdef CONFIG_IA64
--- linux-2.6.17-rc4-mm3.orig/mm/vmscan.c
+++ linux-2.6.17-rc4-mm3/mm/vmscan.c
@@ -457,6 +457,9 @@ static unsigned long shrink_page_list(st
 		if (PageWriteback(page))
 			goto keep_locked;
 
+		if (!PageReferenced(page))
+			inc_readahead_aging();
+
 		referenced = page_referenced(page, 1);
 		/* In active use or really unfreeable?  Activate it. */
 		if (referenced && page_mapping_inuse(page))
@@ -655,6 +658,7 @@ static unsigned long shrink_inactive_lis
 					     &page_list, &nr_scan);
 		zone->nr_inactive -= nr_taken;
 		zone->pages_scanned += nr_scan;
+		zone->aging_total += nr_scan;
 		spin_unlock_irq(&zone->lru_lock);
 
 		nr_scanned += nr_scan;
--- linux-2.6.17-rc4-mm3.orig/mm/swap.c
+++ linux-2.6.17-rc4-mm3/mm/swap.c
@@ -127,6 +127,8 @@ void fastcall mark_page_accessed(struct 
 		ClearPageReferenced(page);
 	} else if (!PageReferenced(page)) {
 		SetPageReferenced(page);
+		if (PageLRU(page))
+			inc_readahead_aging();
 	}
 }
 
--- linux-2.6.17-rc4-mm3.orig/mm/readahead.c
+++ linux-2.6.17-rc4-mm3/mm/readahead.c
@@ -16,6 +16,7 @@
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
 #include <linux/pagevec.h>
+#include <asm/div64.h>
 
 /*
  * Adaptive read-ahead parameters.
@@ -35,6 +36,14 @@ EXPORT_SYMBOL_GPL(readahead_ratio);
 int readahead_hit_rate = 1;
 
 /*
+ * Measures the aging process of cold pages.
+ * Mainly increased on fresh page references to make it smooth.
+ */
+#ifdef CONFIG_READAHEAD_SMOOTH_AGING
+DEFINE_PER_CPU(unsigned long, readahead_aging);
+#endif
+
+/*
  * Detailed classification of read-ahead behaviors.
  */
 #define RA_CLASS_SHIFT 4
@@ -799,6 +808,46 @@ out:
 }
 
 /*
+ * The node's effective length of inactive_list(s).
+ */
+static unsigned long node_free_and_cold_pages(void)
+{
+	unsigned int i;
+	unsigned long sum = 0;
+	struct zone *zones = NODE_DATA(numa_node_id())->node_zones;
+
+	for (i = 0; i < MAX_NR_ZONES; i++)
+		sum += zones[i].nr_inactive +
+			zones[i].free_pages - zones[i].pages_low;
+
+	return sum;
+}
+
+/*
+ * The node's accumulated aging activities.
+ */
+static unsigned long node_readahead_aging(void)
+{
+       unsigned long sum = 0;
+
+#ifdef CONFIG_READAHEAD_SMOOTH_AGING
+       unsigned long cpu;
+       cpumask_t mask = node_to_cpumask(numa_node_id());
+
+       for_each_cpu_mask(cpu, mask)
+	       sum += per_cpu(readahead_aging, cpu);
+#else
+       unsigned int i;
+       struct zone *zones = NODE_DATA(numa_node_id())->node_zones;
+
+       for (i = 0; i < MAX_NR_ZONES; i++)
+	       sum += zones[i].aging_total;
+#endif
+
+       return sum;
+}
+
+/*
  * ra_min is mainly determined by the size of cache memory. Reasonable?
  *
  * Table of concrete numbers for 4KB page size:

--
