Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161052AbWBNNZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161052AbWBNNZc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 08:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161051AbWBNNZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 08:25:32 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:63116 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1161049AbWBNNZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 08:25:31 -0500
Date: Tue, 14 Feb 2006 22:24:34 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [Lhms-devel] [RFC/PATCH: 002/010] Memory hotplug for new nodes with pgdat allocation. (Wait table and zonelists initalization)
Cc: "Luck, Tony" <tony.luck@intel.com>, Andi Kleen <ak@suse.de>,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       linux-ia64@vger.kernel.org,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       x86-64 Discuss <discuss@x86-64.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>,
       Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <43EDC35B.5060106@jp.fujitsu.com>
References: <20060211125941.D35C.Y-GOTO@jp.fujitsu.com> <43EDC35B.5060106@jp.fujitsu.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060214221413.ECF3.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yasunori Goto wrote:
> > 
> >> On Fri, 2006-02-10 at 23:20 +0900, Yasunori Goto wrote:
> >>>  static __meminit
> >>>  void zone_wait_table_init(struct zone *zone, unsigned long
> >>> zone_size_pages)
> >>>  {
> >>> -       int i;
> >>> +       int i, hotadd = (system_state == SYSTEM_RUNNING);
> >>>         struct pglist_data *pgdat = zone->zone_pgdat;
> >>> +       unsigned long allocsize;
> >>>  
> >>>         /*
> >>>          * The per-page waitqueue mechanism uses hashed waitqueues
> >>>          * per zone.
> >>>          */
> >>> +       if (hotadd && (zone_size_pages == PAGES_PER_SECTION))
> >>> +               zone_size_pages = PAGES_PER_SECTION << 2; 
> >> I don't think I understand this calculation.  You online only 4 sections
> >> worth of pages?
> > 
> > Ummmmm.
> > I realized that I've forgotten many things about this patch
> > due to long time keeping in storage. 
> > At least here looks strange indeed.
> > I need shake my brain to recall it. :-(
> 
> Ah, I'm not sure but it was because I didn't have a patch for zone's waittable resizing,
> and resizing it looked impossible. Above code was just a quick hack for the case a zone
> is initialized with only 1 section.
> How large it should be ? or Resizing it, is necessary to be discussed.

Ok. How is like this patch? I changed wait_table_size() for it.
If there is no objection, I'll continue....

Thanks.

-----------------------------

This patch is to initialize wait table and zonelists for new pgdat.
When new node is added, free_area_init_node() is called to initialize
pgdat. But, wait table must be allocated by kmalloc (not bootmem) for it.
And, zonelists is accessed from any other process every time,
So, stop_machine_run() is used for safety update.


 Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
 Signed-off-by: Hiroyuki Kamezawa <kamezawa.hiroyu@jp.fujitsu.com>
 Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

Index: pgdat2/mm/page_alloc.c
===================================================================
--- pgdat2.orig/mm/page_alloc.c	2006-02-14 18:50:37.000000000 +0900
+++ pgdat2/mm/page_alloc.c	2006-02-14 22:11:53.000000000 +0900
@@ -37,6 +37,7 @@
 #include <linux/nodemask.h>
 #include <linux/vmalloc.h>
 #include <linux/mempolicy.h>
+#include <linux/stop_machine.h>
 
 #include <asm/tlbflush.h>
 #include "internal.h"
@@ -1789,6 +1790,24 @@ static inline unsigned long wait_table_s
 
 	pages /= PAGES_PER_WAITQUEUE;
 
+	/*
+	 * In memory hotplug case, the number of pages is just
+	 * for the first section. But, there is no information how
+	 * much memory will be added in the future,
+	 * and this hash table cann't be reallocated.
+	 * When memory hotplug is required, much memory will be
+	 * necessary. Probably, bigger size is better.
+	 * But kmalloc might fail if size is over order 3.
+	 * This is to take wait_table size as much as possible.
+	 */
+	if (system_state == SYSTEM_RUNNING){
+		unsigned long queue_head_size = 1;
+		while (queue_head_size < sizeof(wait_queue_head_t))
+		       queue_head_size <<= 1;
+
+		pages = (1 << (PAGE_SHIFT + 3)) / queue_head_size;
+	}
+
 	while (size < pages)
 		size <<= 1;
 
@@ -2071,8 +2090,9 @@ void __init setup_per_cpu_pageset(void)
 static __meminit
 void zone_wait_table_init(struct zone *zone, unsigned long zone_size_pages)
 {
-	int i;
+	int i, hotadd = (system_state == SYSTEM_RUNNING);
 	struct pglist_data *pgdat = zone->zone_pgdat;
+	unsigned long allocsize;
 
 	/*
 	 * The per-page waitqueue mechanism uses hashed waitqueues
@@ -2080,9 +2100,12 @@ void zone_wait_table_init(struct zone *z
 	 */
 	zone->wait_table_size = wait_table_size(zone_size_pages);
 	zone->wait_table_bits =	wait_table_bits(zone->wait_table_size);
-	zone->wait_table = (wait_queue_head_t *)
-		alloc_bootmem_node(pgdat, zone->wait_table_size
-					* sizeof(wait_queue_head_t));
+	allocsize = zone->wait_table_size * sizeof(wait_queue_head_t);
+	if (hotadd)
+		zone->wait_table = kmalloc(allocsize, GFP_KERNEL);
+	else
+		zone->wait_table = (wait_queue_head_t *)
+			alloc_bootmem_node(pgdat, allocsize);
 
 	for(i = 0; i < zone->wait_table_size; ++i)
 		init_waitqueue_head(zone->wait_table + i);
@@ -2120,6 +2143,7 @@ static __meminit void init_currently_emp
 	memmap_init(size, pgdat->node_id, zone_idx(zone), zone_start_pfn);
 
 	zone_init_free_lists(pgdat, zone, zone->spanned_pages);
+	zone->spanned_pages = size;
 }
 
 /*
@@ -2818,3 +2842,53 @@ void *__init alloc_large_system_hash(con
 
 	return table;
 }
+
+static inline int zone_previously_initialized(struct zone *zone)
+{
+	if (zone->wait_table_size)
+		return 1;
+
+	return 0;
+}
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+static int __build_all_zonelists(void *dummy)
+{
+	int i;
+	for_each_online_node(i)
+		build_zonelists(NODE_DATA(i));
+	/* XXX: Cpuset must be updated when node is hotplugged. */
+	return 0;
+}
+
+DEFINE_SPINLOCK(zone_init_lock);
+int hot_add_zone_init(struct zone *zone, unsigned long phys_start_pfn,
+		      unsigned long size_pages)
+{
+	int ret = 0;
+	unsigned long flags;
+	spin_lock_irqsave(&zone_init_lock,flags);
+	if (zone_previously_initialized(zone)) {
+		ret = -EEXIST;
+		goto out;
+	}
+
+	printk(KERN_DEBUG "hot add zone init %lx %lx.....\n",
+	       phys_start_pfn, size_pages);
+	init_currently_empty_zone(zone, phys_start_pfn, size_pages);
+	zone_pcp_init(zone);
+
+	/*
+	 * This is an awfully blunt way to do this.  But, the
+	 * zonelists are accessed many times over large areas
+	 * of performance-critical code in the allocator.
+	 * That makes it very hard to get a conventional lock
+	 * to work.  This of this as a rw lock with a huge
+	 * write cost.
+	 */
+	stop_machine_run(__build_all_zonelists, zone->zone_pgdat, NR_CPUS);
+out:
+	spin_unlock_irqrestore(&zone_init_lock, flags);
+	return ret;
+}
+#endif
Index: pgdat2/include/linux/mmzone.h
===================================================================
--- pgdat2.orig/include/linux/mmzone.h	2006-02-14 18:14:59.000000000 +0900
+++ pgdat2/include/linux/mmzone.h	2006-02-14 18:50:44.000000000 +0900
@@ -403,7 +403,9 @@ static inline struct zone *next_zone(str
 
 static inline int populated_zone(struct zone *zone)
 {
-	return (!!zone->present_pages);
+	/* When hot-add, present page is 0 at this point.
+	   So check spanned_pages instead of present_pages */
+	return (!!zone->spanned_pages);
 }
 
 static inline int is_highmem_idx(int idx)
Index: pgdat2/mm/memory_hotplug.c
===================================================================
--- pgdat2.orig/mm/memory_hotplug.c	2006-02-14 18:50:12.000000000 +0900
+++ pgdat2/mm/memory_hotplug.c	2006-02-14 22:10:12.000000000 +0900
@@ -48,6 +48,8 @@ static int __add_section(struct zone *zo
 
 	ret = sparse_add_one_section(zone, phys_start_pfn, nr_pages);
 
+	hot_add_zone_init(zone, phys_start_pfn, PAGES_PER_SECTION);
+
 	if (ret < 0)
 		return ret;
 

-- 
Yasunori Goto 



