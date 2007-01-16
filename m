Return-Path: <linux-kernel-owner+w=401wt.eu-S1750783AbXAPK2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbXAPK2Y (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 05:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbXAPK2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 05:28:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43213 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750783AbXAPK2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 05:28:23 -0500
Message-Id: <20070116101815.617343000@taijtu.programming.kicks-ass.net>
References: <20070116094557.494892000@taijtu.programming.kicks-ass.net>
User-Agent: quilt/0.46-1
Date: Tue, 16 Jan 2007 10:46:02 +0100
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-mm@kvack.org
Cc: David Miller <davem@davemloft.net>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 5/9] mm: emergency pool
Content-Disposition: inline; filename=page_alloc-emerg.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Provide means to reserve a specific amount pages.

The emergency pool is separated from the min watermark because ALLOC_HARDER
and ALLOC_HIGH modify the watermark in a relative way and thus do not ensure
a strict minimum.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 include/linux/mmzone.h |    3 +-
 mm/page_alloc.c        |   52 ++++++++++++++++++++++++++++++++++++++++---------
 mm/vmstat.c            |    6 ++---
 3 files changed, 48 insertions(+), 13 deletions(-)

Index: linux-2.6-git/include/linux/mmzone.h
===================================================================
--- linux-2.6-git.orig/include/linux/mmzone.h	2007-01-15 09:58:44.000000000 +0100
+++ linux-2.6-git/include/linux/mmzone.h	2007-01-15 09:58:54.000000000 +0100
@@ -156,7 +156,7 @@ enum zone_type {
 struct zone {
 	/* Fields commonly accessed by the page allocator */
 	unsigned long		free_pages;
-	unsigned long		pages_min, pages_low, pages_high;
+	unsigned long		pages_emerg, pages_min, pages_low, pages_high;
 	/*
 	 * We don't know if the memory that we're going to allocate will be freeable
 	 * or/and it will be released eventually, so to avoid totally wasting several
@@ -540,6 +540,7 @@ int sysctl_min_unmapped_ratio_sysctl_han
 			struct file *, void __user *, size_t *, loff_t *);
 int sysctl_min_slab_ratio_sysctl_handler(struct ctl_table *, int,
 			struct file *, void __user *, size_t *, loff_t *);
+void adjust_memalloc_reserve(int pages);
 
 #include <linux/topology.h>
 /* Returns the number of the current Node. */
Index: linux-2.6-git/mm/page_alloc.c
===================================================================
--- linux-2.6-git.orig/mm/page_alloc.c	2007-01-15 09:58:51.000000000 +0100
+++ linux-2.6-git/mm/page_alloc.c	2007-01-15 09:58:54.000000000 +0100
@@ -97,6 +97,7 @@ static char * const zone_names[MAX_NR_ZO
 
 static DEFINE_SPINLOCK(min_free_lock);
 int min_free_kbytes = 1024;
+int var_free_kbytes;
 
 unsigned long __meminitdata nr_kernel_pages;
 unsigned long __meminitdata nr_all_pages;
@@ -991,7 +992,8 @@ int zone_watermark_ok(struct zone *z, in
 	if (alloc_flags & ALLOC_HARDER)
 		min -= min / 4;
 
-	if (free_pages <= min + z->lowmem_reserve[classzone_idx])
+	if (free_pages <= min + z->lowmem_reserve[classzone_idx] +
+			z->pages_emerg)
 		return 0;
 	for (o = 0; o < order; o++) {
 		/* At the next order, this order's pages become unavailable */
@@ -1344,8 +1346,8 @@ nofail_alloc:
 nopage:
 	if (!(gfp_mask & __GFP_NOWARN) && printk_ratelimit()) {
 		printk(KERN_WARNING "%s: page allocation failure."
-			" order:%d, mode:0x%x\n",
-			p->comm, order, gfp_mask);
+			" order:%d, mode:0x%x, alloc_flags:0x%x, pflags:0x%lx\n",
+			p->comm, order, gfp_mask, alloc_flags, p->flags);
 		dump_stack();
 		show_mem();
 	}
@@ -1590,9 +1592,9 @@ void show_free_areas(void)
 			"\n",
 			zone->name,
 			K(zone->free_pages),
-			K(zone->pages_min),
-			K(zone->pages_low),
-			K(zone->pages_high),
+			K(zone->pages_emerg + zone->pages_min),
+			K(zone->pages_emerg + zone->pages_low),
+			K(zone->pages_emerg + zone->pages_high),
 			K(zone->nr_active),
 			K(zone->nr_inactive),
 			K(zone->present_pages),
@@ -3025,7 +3027,7 @@ static void calculate_totalreserve_pages
 			}
 
 			/* we treat pages_high as reserved pages. */
-			max += zone->pages_high;
+			max += zone->pages_high + zone->pages_emerg;
 
 			if (max > zone->present_pages)
 				max = zone->present_pages;
@@ -3082,7 +3084,8 @@ static void setup_per_zone_lowmem_reserv
  */
 static void __setup_per_zone_pages_min(void)
 {
-	unsigned long pages_min = min_free_kbytes >> (PAGE_SHIFT - 10);
+	unsigned pages_min = min_free_kbytes >> (PAGE_SHIFT - 10);
+	unsigned pages_emerg = var_free_kbytes >> (PAGE_SHIFT - 10);
 	unsigned long lowmem_pages = 0;
 	struct zone *zone;
 	unsigned long flags;
@@ -3094,11 +3097,13 @@ static void __setup_per_zone_pages_min(v
 	}
 
 	for_each_zone(zone) {
-		u64 tmp;
+		u64 tmp, tmp_emerg;
 
 		spin_lock_irqsave(&zone->lru_lock, flags);
 		tmp = (u64)pages_min * zone->present_pages;
 		do_div(tmp, lowmem_pages);
+		tmp_emerg = (u64)pages_emerg * zone->present_pages;
+		do_div(tmp_emerg, lowmem_pages);
 		if (is_highmem(zone)) {
 			/*
 			 * __GFP_HIGH and PF_MEMALLOC allocations usually don't
@@ -3117,12 +3122,14 @@ static void __setup_per_zone_pages_min(v
 			if (min_pages > 128)
 				min_pages = 128;
 			zone->pages_min = min_pages;
+			zone->pages_emerg = min_pages;
 		} else {
 			/*
 			 * If it's a lowmem zone, reserve a number of pages
 			 * proportionate to the zone's size.
 			 */
 			zone->pages_min = tmp;
+			zone->pages_emerg = tmp_emerg;
 		}
 
 		zone->pages_low   = zone->pages_min + (tmp >> 2);
@@ -3143,6 +3150,33 @@ void setup_per_zone_pages_min(void)
 	spin_unlock_irqrestore(&min_free_lock, flags);
 }
 
+/**
+ *	adjust_memalloc_reserve - adjust the memalloc reserve
+ *	@pages: number of pages to add
+ *
+ *	It adds a number of pages to the memalloc reserve; if
+ *	the number was positive it kicks kswapd into action to
+ *	satisfy the higher watermarks.
+ *
+ *	NOTE: there is only a single caller, hence no locking.
+ */
+void adjust_memalloc_reserve(int pages)
+{
+	var_free_kbytes += pages << (PAGE_SHIFT - 10);
+	BUG_ON(var_free_kbytes < 0);
+	setup_per_zone_pages_min();
+	if (pages > 0) {
+		struct zone *zone;
+		for_each_zone(zone)
+			wakeup_kswapd(zone, 0);
+	}
+	if (pages)
+		printk(KERN_DEBUG "Emergency reserve: %d\n",
+				var_free_kbytes);
+}
+
+EXPORT_SYMBOL_GPL(adjust_memalloc_reserve);
+
 /*
  * Initialise min_free_kbytes.
  *
Index: linux-2.6-git/mm/vmstat.c
===================================================================
--- linux-2.6-git.orig/mm/vmstat.c	2007-01-15 09:58:44.000000000 +0100
+++ linux-2.6-git/mm/vmstat.c	2007-01-15 09:58:54.000000000 +0100
@@ -535,9 +535,9 @@ static int zoneinfo_show(struct seq_file
 			   "\n        spanned  %lu"
 			   "\n        present  %lu",
 			   zone->free_pages,
-			   zone->pages_min,
-			   zone->pages_low,
-			   zone->pages_high,
+			   zone->pages_emerg + zone->pages_min,
+			   zone->pages_emerg + zone->pages_low,
+			   zone->pages_emerg + zone->pages_high,
 			   zone->nr_active,
 			   zone->nr_inactive,
 			   zone->pages_scanned,

-- 

