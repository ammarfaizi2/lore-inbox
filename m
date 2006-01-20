Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750868AbWATL5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbWATL5W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 06:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbWATL4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 06:56:55 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:41092 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1750868AbWATL4n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 06:56:43 -0500
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: jschopp@austin.ibm.com, Mel Gorman <mel@csn.ul.ie>,
       linux-kernel@vger.kernel.org, kamezawa.hiroyu@jp.fujitsu.com,
       lhms-devel@lists.sourceforge.net
Message-Id: <20060120115535.16475.28122.sendpatchset@skynet.csn.ul.ie>
In-Reply-To: <20060120115415.16475.8529.sendpatchset@skynet.csn.ul.ie>
References: <20060120115415.16475.8529.sendpatchset@skynet.csn.ul.ie>
Subject: [PATCH 4/4] Add a configure option for anti-fragmentation
Date: Fri, 20 Jan 2006 11:55:36 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The anti-fragmentation strategy has memory overhead. This patch allows
the strategy to be disabled for small memory systems or if it is known the
workload is suffering because of the strategy. It also acts to show where
the anti-frag strategy interacts with the standard buddy allocator.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.16-rc1-mm1-003_percpu/include/linux/mmzone.h linux-2.6.16-rc1-mm1-004_configurable/include/linux/mmzone.h
--- linux-2.6.16-rc1-mm1-003_percpu/include/linux/mmzone.h	2006-01-19 22:15:16.000000000 +0000
+++ linux-2.6.16-rc1-mm1-004_configurable/include/linux/mmzone.h	2006-01-19 22:27:50.000000000 +0000
@@ -73,10 +73,17 @@ struct per_cpu_pageset {
 #endif
 } ____cacheline_aligned_in_smp;
 
+#ifdef CONFIG_PAGEALLOC_ANTIFRAG
 static inline int pcp_count(struct per_cpu_pages *pcp)
 {
 	return pcp->count[RCLM_NORCLM] + pcp->count[RCLM_EASY];
 }
+#else
+static inline int pcp_count(struct per_cpu_pages *pcp)
+{
+	return pcp->count[RCLM_NORCLM];
+}
+#endif /* CONFIG_PAGEALLOC_ANTIFRAG */
 
 #ifdef CONFIG_NUMA
 #define zone_pcp(__z, __cpu) ((__z)->pageset[(__cpu)])
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.16-rc1-mm1-003_percpu/init/Kconfig linux-2.6.16-rc1-mm1-004_configurable/init/Kconfig
--- linux-2.6.16-rc1-mm1-003_percpu/init/Kconfig	2006-01-19 11:21:59.000000000 +0000
+++ linux-2.6.16-rc1-mm1-004_configurable/init/Kconfig	2006-01-19 22:27:50.000000000 +0000
@@ -376,6 +376,18 @@ config CC_ALIGN_FUNCTIONS
 	  32-byte boundary only if this can be done by skipping 23 bytes or less.
 	  Zero means use compiler's default.
 
+config PAGEALLOC_ANTIFRAG
+	bool "Avoid fragmentation in the page allocator"
+	def_bool n
+	help
+	  The standard allocator will fragment memory over time which means that
+	  high order allocations will fail even if kswapd is running. If this
+	  option is set, the allocator will try and group page types into
+	  two groups, kernel and easy reclaimable. The gain is a best effort
+	  attempt at lowering fragmentation which a few workloads care about.
+	  The loss is a more complex allocactor that performs slower.
+	  If unsure, say N
+
 config CC_ALIGN_LABELS
 	int "Label alignment" if EMBEDDED
 	default 0
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.16-rc1-mm1-003_percpu/mm/page_alloc.c linux-2.6.16-rc1-mm1-004_configurable/mm/page_alloc.c
--- linux-2.6.16-rc1-mm1-003_percpu/mm/page_alloc.c	2006-01-19 22:26:45.000000000 +0000
+++ linux-2.6.16-rc1-mm1-004_configurable/mm/page_alloc.c	2006-01-19 22:27:50.000000000 +0000
@@ -72,6 +72,7 @@ int sysctl_lowmem_reserve_ratio[MAX_NR_Z
 
 EXPORT_SYMBOL(totalram_pages);
 
+#ifdef CONFIG_PAGEALLOC_ANTIFRAG
 static inline int get_pageblock_type(struct page *page)
 {
 	return (PageEasyRclm(page) != 0);
@@ -81,6 +82,17 @@ static inline int gfpflags_to_alloctype(
 {
 	return ((gfp_flags & __GFP_EASYRCLM) != 0);
 }
+#else
+static inline int get_pageblock_type(struct page *page)
+{
+	return RCLM_NORCLM;
+}
+
+static inline int gfpflags_to_alloctype(unsigned long gfp_flags)
+{
+	return RCLM_NORCLM;
+}
+#endif /* CONFIG_PAGEALLOC_ANTIFRAG */
 
 /*
  * Used by page_zone() to look up the address of the struct zone whose
@@ -563,6 +575,7 @@ static int prep_new_page(struct page *pa
 	return 0;
 }
 
+#ifdef CONFIG_PAGEALLOC_ANTIFRAG
 /* Remove an element from the buddy allocator from the fallback list */
  static struct page *__rmqueue_fallback(struct zone *zone, int order,
 							int alloctype)
@@ -599,6 +612,13 @@ static int prep_new_page(struct page *pa
 
 	return NULL;
 }
+#else
+static struct page *__rmqueue_fallback(struct zone *zone, unsigned int order,
+							int alloctype)
+{
+	return NULL;
+}
+#endif /* CONFIG_PAGEALLOC_ANTIFRAG */
 
 /* 
  * Do the hard work of removing an element from the buddy allocator.
