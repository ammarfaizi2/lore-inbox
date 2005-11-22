Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965123AbVKVTS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965123AbVKVTS6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 14:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965133AbVKVTRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 14:17:52 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:42472 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S965131AbVKVTRe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 14:17:34 -0500
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>, nickpiggin@yahoo.com.au, ak@suse.de,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net,
       mingo@elte.hu
Message-Id: <20051122191730.21757.34503.sendpatchset@skynet.csn.ul.ie>
In-Reply-To: <20051122191710.21757.67440.sendpatchset@skynet.csn.ul.ie>
References: <20051122191710.21757.67440.sendpatchset@skynet.csn.ul.ie>
Subject: [PATCH 4/5] Light fragmentation avoidance without usemap: 004_configurable
Date: Tue, 22 Nov 2005 19:17:33 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The anti-defragmentation strategy has memory overhead. This patch allows
the strategy to be disabled for small memory systems or if it is known the
workload is suffering because of the strategy. It also acts to show where
the anti-defrag strategy interacts with the standard buddy allocator.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.15-rc1-mm2-003_percpu/include/linux/mmzone.h linux-2.6.15-rc1-mm2-004_configurable/include/linux/mmzone.h
--- linux-2.6.15-rc1-mm2-003_percpu/include/linux/mmzone.h	2005-11-22 16:52:10.000000000 +0000
+++ linux-2.6.15-rc1-mm2-004_configurable/include/linux/mmzone.h	2005-11-22 16:53:03.000000000 +0000
@@ -74,10 +74,17 @@ struct per_cpu_pageset {
 #endif
 } ____cacheline_aligned_in_smp;
 
+#ifdef CONFIG_PAGEALLOC_ANTIDEFRAG
 static inline int pcp_count(struct per_cpu_pages *pcp)
 {
 	return pcp->count[RCLM_NORCLM] + pcp->count[RCLM_EASY];
 }
+#else
+static inline int pcp_count(struct per_cpu_pages *pcp)
+{
+	return pcp->count[RCLM_NORCLM];
+}
+#endif /* CONFIG_PAGEALLOC_ANTIDEFRAG */
 
 #ifdef CONFIG_NUMA
 #define zone_pcp(__z, __cpu) ((__z)->pageset[(__cpu)])
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.15-rc1-mm2-003_percpu/init/Kconfig linux-2.6.15-rc1-mm2-004_configurable/init/Kconfig
--- linux-2.6.15-rc1-mm2-003_percpu/init/Kconfig	2005-11-21 19:44:33.000000000 +0000
+++ linux-2.6.15-rc1-mm2-004_configurable/init/Kconfig	2005-11-22 16:53:03.000000000 +0000
@@ -396,6 +396,18 @@ config CC_ALIGN_FUNCTIONS
 	  32-byte boundary only if this can be done by skipping 23 bytes or less.
 	  Zero means use compiler's default.
 
+config PAGEALLOC_ANTIDEFRAG
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
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.15-rc1-mm2-003_percpu/mm/page_alloc.c linux-2.6.15-rc1-mm2-004_configurable/mm/page_alloc.c
--- linux-2.6.15-rc1-mm2-003_percpu/mm/page_alloc.c	2005-11-22 16:52:10.000000000 +0000
+++ linux-2.6.15-rc1-mm2-004_configurable/mm/page_alloc.c	2005-11-22 16:53:03.000000000 +0000
@@ -68,6 +68,7 @@ int sysctl_lowmem_reserve_ratio[MAX_NR_Z
 
 EXPORT_SYMBOL(totalram_pages);
 
+#ifdef CONFIG_PAGEALLOC_ANTIDEFRAG
 static inline int get_pageblock_type(struct page *page)
 {
 	return (PageEasyRclm(page) != 0);
@@ -77,6 +78,17 @@ static inline int gfpflags_to_alloctype(
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
+#endif /* CONFIG_PAGEALLOC_ANTIDEFRAG */
 
 /*
  * Used by page_zone() to look up the address of the struct zone whose
@@ -531,6 +543,7 @@ static int prep_new_page(struct page *pa
 	return 0;
 }
 
+#ifdef CONFIG_PAGEALLOC_ANTIDEFRAG
 /* Remove an element from the buddy allocator from the fallback list */
 static struct page *__rmqueue_fallback(struct zone *zone, int order,
 							int alloctype)
@@ -568,6 +581,13 @@ static struct page *__rmqueue_fallback(s
 
 	return NULL;
 }
+#else
+static struct page *__rmqueue_fallback(struct zone *zone, unsigned int order,
+							int alloctype)
+{
+	return NULL;
+}
+#endif /* CONFIG_PAGEALLOC_ANTIDEFRAG */
 
 /* 
  * Do the hard work of removing an element from the buddy allocator.
