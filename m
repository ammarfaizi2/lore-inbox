Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbWF3GPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbWF3GPA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 02:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbWF3GPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 02:15:00 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:39112 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751116AbWF3GO7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 02:14:59 -0400
Date: Thu, 29 Jun 2006 23:14:56 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: ZVC: Increase threshold for larger processor configurationss
In-Reply-To: <Pine.LNX.4.64.0606291116500.27926@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0606292314110.31091@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0606281038530.22262@schroedinger.engr.sgi.com>
 <20060628154911.6e035153.akpm@osdl.org> <Pine.LNX.4.64.0606291116500.27926@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2006, Christoph Lameter wrote:

> Thats one more memory reference. Hmmm... We could place the threshold in 
> the same cacheline. That would also open up the possbiliity of dynamically 
> calculating the threshold.
> 

like this?

ZVC: Dynamic counter threshold configuration

We add a threshold before the first counter and calculate the
threshold based on the size of the zone assuming that larger machines have larger
zone sizes and therefore larger thresholds.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-mm4/mm/vmstat.c
===================================================================
--- linux-2.6.17-mm4.orig/mm/vmstat.c	2006-06-29 13:07:13.342483251 -0700
+++ linux-2.6.17-mm4/mm/vmstat.c	2006-06-29 13:17:52.978741713 -0700
@@ -112,37 +112,22 @@ atomic_long_t vm_stat[NR_VM_ZONE_STAT_IT
 EXPORT_SYMBOL(vm_stat);
 
 #ifdef CONFIG_SMP
-
-#define STAT_THRESHOLD 32
-
-/*
- * Determine pointer to currently valid differential byte given a zone and
- * the item number.
- *
- * Preemption must be off
- */
-static inline s8 *diff_pointer(struct zone *zone, enum zone_stat_item item)
-{
-	return &zone_pcp(zone, smp_processor_id())->vm_stat_diff[item];
-}
-
 /*
  * For use when we know that interrupts are disabled.
  */
 void __mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
 				int delta)
 {
-	s8 *p;
+	struct per_cpu_pageset *pcp = zone_pcp(zone, smp_processor_id());
+	s8 *p = pcp->vm_stat_diff + item;
 	long x;
 
-	p = diff_pointer(zone, item);
 	x = delta + *p;
 
-	if (unlikely(x > STAT_THRESHOLD || x < -STAT_THRESHOLD)) {
+	if (unlikely(x > pcp->stat_threshold || x < -pcp->stat_threshold)) {
 		zone_page_state_add(x, zone, item);
 		x = 0;
 	}
-
 	*p = x;
 }
 EXPORT_SYMBOL(__mod_zone_page_state);
@@ -184,11 +169,12 @@ EXPORT_SYMBOL(mod_zone_page_state);
  */
 static void __inc_zone_state(struct zone *zone, enum zone_stat_item item)
 {
-	s8 *p = diff_pointer(zone, item);
+	struct per_cpu_pageset *pcp = zone_pcp(zone, smp_processor_id());
+	s8 *p = pcp->vm_stat_diff + item;
 
 	(*p)++;
 
-	if (unlikely(*p > STAT_THRESHOLD)) {
+	if (unlikely(*p > pcp->stat_threshold)) {
 		zone_page_state_add(*p, zone, item);
 		*p = 0;
 	}
@@ -203,11 +189,12 @@ EXPORT_SYMBOL(__inc_zone_page_state);
 void __dec_zone_page_state(struct page *page, enum zone_stat_item item)
 {
 	struct zone *zone = page_zone(page);
-	s8 *p = diff_pointer(zone, item);
+	struct per_cpu_pageset *pcp = zone_pcp(zone, smp_processor_id());
+	s8 *p = pcp->vm_stat_diff + item;
 
 	(*p)--;
 
-	if (unlikely(*p < -STAT_THRESHOLD)) {
+	if (unlikely(*p < -pcp->stat_threshold)) {
 		zone_page_state_add(*p, zone, item);
 		*p = 0;
 	}
@@ -238,16 +225,12 @@ EXPORT_SYMBOL(inc_zone_page_state);
 void dec_zone_page_state(struct page *page, enum zone_stat_item item)
 {
 	unsigned long flags;
-	struct zone *zone;
-	s8 *p;
+	struct zone *zone = page_zone(page);
+	struct per_cpu_pageset *pcp = zone_pcp(zone, smp_processor_id());
+	s8 *p = pcp->vm_stat_diff + item;
 
-	zone = page_zone(page);
 	local_irq_save(flags);
-	p = diff_pointer(zone, item);
-
-	(*p)--;
-
-	if (unlikely(*p < -STAT_THRESHOLD)) {
+	if (unlikely(*p < -pcp->stat_threshold)) {
 		zone_page_state_add(*p, zone, item);
 		*p = 0;
 	}
@@ -502,6 +485,7 @@ static int zoneinfo_show(struct seq_file
 		seq_printf(m,
 			   ")"
 			   "\n  pagesets");
+		seq_printf(m, "\n    stat_threshold: %i", zone_pcp(zone, 0)->stat_threshold);
 		for_each_online_cpu(i) {
 			struct per_cpu_pageset *pageset;
 			int j;
Index: linux-2.6.17-mm4/include/linux/mmzone.h
===================================================================
--- linux-2.6.17-mm4.orig/include/linux/mmzone.h	2006-06-29 13:07:12.486090884 -0700
+++ linux-2.6.17-mm4/include/linux/mmzone.h	2006-06-29 13:07:26.486201908 -0700
@@ -77,6 +77,7 @@ struct per_cpu_pages {
 struct per_cpu_pageset {
 	struct per_cpu_pages pcp[2];	/* 0: hot.  1: cold */
 #ifdef CONFIG_SMP
+	s8 stat_threshold;	/* maximum diff before update */
 	s8 vm_stat_diff[NR_VM_ZONE_STAT_ITEMS];
 #endif
 } ____cacheline_aligned_in_smp;
Index: linux-2.6.17-mm4/mm/page_alloc.c
===================================================================
--- linux-2.6.17-mm4.orig/mm/page_alloc.c	2006-06-29 13:07:13.313188187 -0700
+++ linux-2.6.17-mm4/mm/page_alloc.c	2006-06-29 13:14:57.831351395 -0700
@@ -1918,6 +1918,8 @@ static int __cpuinit process_zones(int c
 		if (percpu_pagelist_fraction)
 			setup_pagelist_highmark(zone_pcp(zone, cpu),
 			 	(zone->present_pages / percpu_pagelist_fraction));
+
+		vm_stat_setup(zone, cpu);
 	}
 
 	return 0;
@@ -2039,6 +2041,7 @@ static __meminit void zone_pcp_init(stru
 #else
 		setup_pageset(zone_pcp(zone,cpu), batch);
 #endif
+		vm_stat_setup(zone, cpu);
 	}
 	if (zone->present_pages)
 		printk(KERN_DEBUG "  %s zone: %lu pages, LIFO batch:%lu\n",
Index: linux-2.6.17-mm4/include/linux/vmstat.h
===================================================================
--- linux-2.6.17-mm4.orig/include/linux/vmstat.h	2006-06-29 13:07:12.916728323 -0700
+++ linux-2.6.17-mm4/include/linux/vmstat.h	2006-06-29 13:18:20.594224260 -0700
@@ -174,6 +175,27 @@ extern void inc_zone_state(struct zone *
 void refresh_cpu_vm_stats(int);
 void refresh_vm_stats(void);
 
+static inline void vm_stat_setup(struct zone *zone, int cpu)
+{
+	int threshold;
+
+	/*
+	 * Increase the threshold for every 64 Megabyte of memory by one.
+	 * The bigger the zone the more flexibility we can give us.
+	 *
+	 * The minimum threshold of 4 is equal to 256 MB of memory.
+	 * The maximum of 125 reflects 8 Gigabytes.
+	 */
+	threshold = zone->present_pages / (1024*1024*64 / PAGE_SIZE);
+
+	/*
+	 * Threshold must be between 4 and 125
+	 */
+	threshold = max(4, min(125, threshold));
+
+	zone_pcp(zone, cpu)->stat_threshold = threshold;
+}
+
 #else /* CONFIG_SMP */
 
 /*
@@ -210,6 +232,7 @@ static inline void __dec_zone_page_state
 
 static inline void refresh_cpu_vm_stats(int cpu) { }
 static inline void refresh_vm_stats(void) { }
+static inline void vm_stat_setup(struct zone *z, int cpu) { }
 #endif
 
 #endif /* _LINUX_VMSTAT_H */
