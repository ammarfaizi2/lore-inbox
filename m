Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946789AbWKALRn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946789AbWKALRn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 06:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946785AbWKALRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 06:17:42 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:19595 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1946790AbWKALRl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 06:17:41 -0500
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org
Message-Id: <20061101111740.18798.85942.sendpatchset@skynet.skynet.ie>
In-Reply-To: <20061101111620.18798.34778.sendpatchset@skynet.skynet.ie>
References: <20061101111620.18798.34778.sendpatchset@skynet.skynet.ie>
Subject: [PATCH 4/11] Add a configure option for anti-fragmentation
Date: Wed,  1 Nov 2006 11:17:40 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The anti-fragmentation strategy has memory overhead. This patch allows
the strategy to be disabled for small memory systems or if it is known the
workload is suffering because of the strategy. It also acts to show where
the anti-frag strategy interacts with the standard buddy allocator.


Signed-off-by: Mel Gorman <mel@csn.ul.ie>
Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>
---

 init/Kconfig    |   14 ++++++++++++++
 mm/page_alloc.c |   20 ++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc4-mm1-003_percpu/init/Kconfig linux-2.6.19-rc4-mm1-004_configurable/init/Kconfig
--- linux-2.6.19-rc4-mm1-003_percpu/init/Kconfig	2006-10-31 13:27:13.000000000 +0000
+++ linux-2.6.19-rc4-mm1-004_configurable/init/Kconfig	2006-10-31 13:42:06.000000000 +0000
@@ -481,6 +481,20 @@ config SLOB
 	default !SLAB
 	bool
 
+config PAGEALLOC_ANTIFRAG
+ 	bool "Avoid fragmentation in the page allocator"
+ 	def_bool n
+ 	help
+ 	  The standard allocator will fragment memory over time which means
+ 	  that high order allocations will fail even if kswapd is running. If
+ 	  this option is set, the allocator will try and group page types into
+ 	  two groups, kernel and easy reclaimable. The gain is a best effort
+ 	  attempt at lowering fragmentation which a few workloads care about.
+ 	  The loss is a more complex allocactor that may perform slower. If
+	  you are interested in working with large pages, say Y and set
+	  /proc/sys/vm/min_free_bytes to be 10% of physical memory. Otherwise
+ 	  say N
+
 menu "Loadable module support"
 
 config MODULES
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc4-mm1-003_percpu/mm/page_alloc.c linux-2.6.19-rc4-mm1-004_configurable/mm/page_alloc.c
--- linux-2.6.19-rc4-mm1-003_percpu/mm/page_alloc.c	2006-10-31 13:40:01.000000000 +0000
+++ linux-2.6.19-rc4-mm1-004_configurable/mm/page_alloc.c	2006-10-31 13:42:06.000000000 +0000
@@ -135,6 +135,7 @@ static unsigned long __initdata dma_rese
 #endif /* CONFIG_MEMORY_HOTPLUG_RESERVE */
 #endif /* CONFIG_ARCH_POPULATES_NODE_MAP */
 
+#ifdef CONFIG_PAGEALLOC_ANTIFRAG
 static inline int get_page_rclmtype(struct page *page)
 {
 	return (PageEasyRclm(page) != 0);
@@ -144,6 +145,17 @@ static inline int gfpflags_to_rclmtype(g
 {
 	return ((gfp_flags & __GFP_EASYRCLM) != 0);
 }
+#else
+static inline int get_page_rclmtype(struct page *page)
+{
+	return RCLM_NORCLM;
+}
+
+static inline int gfpflags_to_rclmtype(gfp_t gfp_flags)
+{
+	return RCLM_NORCLM;
+}
+#endif /* CONFIG_PAGEALLOC_ANTIFRAG */
 
 #ifdef CONFIG_DEBUG_VM
 static int page_outside_zone_boundaries(struct zone *zone, struct page *page)
@@ -641,6 +653,7 @@ static int prep_new_page(struct page *pa
 	return 0;
 }
 
+#ifdef CONFIG_PAGEALLOC_ANTIFRAG
 /* Remove an element from the buddy allocator from the fallback list */
 static struct page *__rmqueue_fallback(struct zone *zone, int order,
 							gfp_t gfp_flags)
@@ -679,6 +692,13 @@ static struct page *__rmqueue_fallback(s
 
 	return NULL;
 }
+#else
+static struct page *__rmqueue_fallback(struct zone *zone, unsigned int order,
+							int rclmtype)
+{
+	return NULL;
+}
+#endif /* CONFIG_PAGEALLOC_ANTIFRAG */
 
 /* 
  * Do the hard work of removing an element from the buddy allocator.
