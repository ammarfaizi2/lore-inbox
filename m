Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751337AbWCSCew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbWCSCew (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 21:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbWCSCew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 21:34:52 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:10435 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751337AbWCSCet (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 21:34:49 -0500
Message-Id: <20060319023454.869633000@localhost.localdomain>
References: <20060319023413.305977000@localhost.localdomain>
Date: Sun, 19 Mar 2006 10:34:26 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 13/23] readahead: page cache aging accounting
Content-Disposition: inline; filename=readahead-aging-accounting.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Collect info about the global available memory and its consumption speed.
The data are used by the stateful method to estimate the thrashing threshold.

They are the decisive factor of the correctness/accuracy of the resulting
read-ahead size.

- The accountings are done on a per-node basis, for the current vm subsystem
  allocates memory in a node affined manner.

- The readahead_aging is mainly increased on first access of the read-ahead
  pages, which makes it goes up constantly and smoothly, which helps improve
  the accuracy on small/fast read-aheads.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 include/linux/mm.h |    9 +++++++++
 mm/memory.c        |    1 +
 mm/readahead.c     |   51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 mm/swap.c          |    2 ++
 mm/vmscan.c        |    3 +++
 5 files changed, 66 insertions(+)

--- linux-2.6.16-rc6-mm2.orig/include/linux/mm.h
+++ linux-2.6.16-rc6-mm2/include/linux/mm.h
@@ -1031,6 +1031,15 @@ static inline int prefer_adaptive_readah
 	return readahead_ratio >= 10;
 }
 
+DECLARE_PER_CPU(unsigned long, readahead_aging);
+static inline void inc_readahead_aging(void)
+{
+	if (prefer_adaptive_readahead()) {
+		per_cpu(readahead_aging, get_cpu())++;
+		put_cpu();
+	}
+}
+
 /* Do stack extension */
 extern int expand_stack(struct vm_area_struct *vma, unsigned long address);
 #ifdef CONFIG_IA64
--- linux-2.6.16-rc6-mm2.orig/mm/memory.c
+++ linux-2.6.16-rc6-mm2/mm/memory.c
@@ -1984,6 +1984,7 @@ static int do_anonymous_page(struct mm_s
 		page_table = pte_offset_map_lock(mm, pmd, address, &ptl);
 		if (!pte_none(*page_table))
 			goto release;
+		inc_readahead_aging();
 		inc_mm_counter(mm, anon_rss);
 		lru_cache_add_active(page);
 		page_add_new_anon_rmap(page, vma, address);
--- linux-2.6.16-rc6-mm2.orig/mm/vmscan.c
+++ linux-2.6.16-rc6-mm2/mm/vmscan.c
@@ -440,6 +440,9 @@ static unsigned long shrink_page_list(st
 		if (PageWriteback(page))
 			goto keep_locked;
 
+		if (!PageReferenced(page))
+			inc_readahead_aging();
+
 		referenced = page_referenced(page, 1);
 		/* In active use or really unfreeable?  Activate it. */
 		if (referenced && page_mapping_inuse(page))
--- linux-2.6.16-rc6-mm2.orig/mm/swap.c
+++ linux-2.6.16-rc6-mm2/mm/swap.c
@@ -128,6 +128,8 @@ void fastcall mark_page_accessed(struct 
 		ClearPageReferenced(page);
 	} else if (!PageReferenced(page)) {
 		SetPageReferenced(page);
+		if (PageLRU(page))
+			inc_readahead_aging();
 	}
 }
 
--- linux-2.6.16-rc6-mm2.orig/mm/readahead.c
+++ linux-2.6.16-rc6-mm2/mm/readahead.c
@@ -46,6 +46,13 @@ int readahead_hit_rate = 2;
 EXPORT_SYMBOL(readahead_hit_rate);
 
 /*
+ * Measures the aging process of cold pages.
+ * Mainly increased on fresh page references to make it smooth.
+ */
+DEFINE_PER_CPU(unsigned long, readahead_aging);
+EXPORT_PER_CPU_SYMBOL(readahead_aging);
+
+/*
  * Detailed classification of read-ahead behaviors.
  */
 #define RA_CLASS_SHIFT 4
@@ -1009,6 +1016,50 @@ out:
 }
 
 /*
+ * State based calculation of read-ahead request.
+ *
+ * This figure shows the meaning of file_ra_state members:
+ *
+ *             chunk A                            chunk B
+ *  +---------------------------+-------------------------------------------+
+ *  |             #             |                   #                       |
+ *  +---------------------------+-------------------------------------------+
+ *                ^             ^                   ^                       ^
+ *              la_index      ra_index     lookahead_index         readahead_index
+ */
+
+/*
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
+	unsigned long cpu;
+	unsigned long sum = 0;
+	cpumask_t mask = node_to_cpumask(numa_node_id());
+
+	for_each_cpu_mask(cpu, mask)
+		sum += per_cpu(readahead_aging, cpu);
+
+	return sum;
+}
+
+/*
  * ra_min is mainly determined by the size of cache memory.
  * Table of concrete numbers for 4KB page size:
  *   inactive + free (MB):    4   8   16   32   64  128  256  512 1024

--
