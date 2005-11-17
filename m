Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbVKQJQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbVKQJQP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 04:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbVKQJQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 04:16:15 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:8651 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750708AbVKQJQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 04:16:13 -0500
Message-ID: <437C4A61.908@jp.fujitsu.com>
Date: Thu, 17 Nov 2005 18:16:17 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
Subject: Re: [Lhms-devel] Re: 2.6.14-mm2
References: <20051110203544.027e992c.akpm@osdl.org>	 <437B2C82.6020803@jp.fujitsu.com> <1132147036.7915.19.camel@localhost>	 <437B5801.4010204@jp.fujitsu.com> <1132158704.19290.3.camel@localhost>
In-Reply-To: <1132158704.19290.3.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> Hmmm.  I _think_ you're just trying to do some things at runtime that I
> didn't intend.  In the patch I pointed to in the last mail, look at what
> I did in hot_add_zone_init().  It does some of what
> free_area_init_core() does, but only the most minimal bits.  Basically:
> 
>        zone_wait_table_init(zone, size_pages);
>        init_currently_empty_zone(zone, phys_start_pfn, size_pages);
>        zone_pcp_init(zone);
> 
> Your way may also be valid, but I broke out init_currently_empty_zone()
> for a reason, and I think this was it.  I don't think we want to be
> calling free_area_init_core() itself at runtime.
> 
Thank you, Dave.

My final patch is below. but I attach this just for sharing not for upstream.

Without some strange emulation of memory hot add, this patch is needless, now.

I use this with custom-dsdt (custom acpi information created by hand) and
other emulation code.

This is sesstion log :)
--
> [kamezawa@aworks ~]$ cat /proc/meminfo
> MemTotal:       501772 kB
> MemFree:        415576 kB
> HighTotal:           0 kB
> HighFree:            0 kB
There are no Highmem.
> [root@aworks kamezawa]# cat /sys/devices/system/memory/memory9/state
> offline
> [root@aworks kamezawa]# echo online > /sys/devices/system/memory/memory9/state
> [root@aworks kamezawa]# cat /sys/devices/system/memory/memory9/state
> online
> [root@aworks kamezawa]# cat /proc/meminfo
> MemTotal:       567308 kB
> MemFree:        479968 kB
> HighTotal:       65536 kB
> HighFree:        65408 kB
Highmem is available
> [root@aworks kamezawa]# cat /proc/meminfo
> MemTotal:       567308 kB
> MemFree:        475440 kB
> HighTotal:       65536 kB
> HighFree:        61128 kB
Highmem is used.

Thanks,
-- Kame
--
Linux-2.6.14-mm2's memory-hot-add cannot deal with
adding new zone case.

My personal x86 environment, which has only 700M bytes memory,
has no HIGHMEM at boot time. So I cannot play with memory-hot-add
with it.

This patch enables memory-hot-add test on tiny machine.
With this patch, I boot the kernel with mem= or memlimit= option
and can add extra 200M bytes pages.

Just for emulation people with poor machine ;)

Note:
This patch is cut out from Dave Hansen's -mhp tree.

-- kame <kamezawa.hiroyu@jp.fujitsu.com>

Index: linux-2.6.14-mm2/mm/page_alloc.c
===================================================================
--- linux-2.6.14-mm2.orig/mm/page_alloc.c
+++ linux-2.6.14-mm2/mm/page_alloc.c
@@ -36,6 +36,7 @@
  #include <linux/memory_hotplug.h>
  #include <linux/nodemask.h>
  #include <linux/vmalloc.h>
+#include <linux/stop_machine.h>

  #include <asm/tlbflush.h>
  #include "internal.h"
@@ -1479,7 +1480,9 @@ static int __init build_zonelists_node(p
  		BUG();
  	case ZONE_HIGHMEM:
  		zone = pgdat->node_zones + ZONE_HIGHMEM;
-		if (zone->present_pages) {
+		/* When hot-add, present page is 0 at this point.
+                   so check spanned_pages instead of present_pages */
+		if (zone->spanned_pages) {
  #ifndef CONFIG_HIGHMEM
  			BUG();
  #endif
@@ -1952,21 +1955,26 @@ void __init setup_per_cpu_pageset()
  #endif

  static __devinit
-void zone_wait_table_init(struct zone *zone, unsigned long zone_size_pages)
+void zone_wait_table_init(struct zone *zone,
+			  unsigned long zone_size_pages, int hotadd)
  {
  	int i;
  	struct pglist_data *pgdat = zone->zone_pgdat;
-
+	int allocsize;
  	/*
  	 * The per-page waitqueue mechanism uses hashed waitqueues
  	 * per zone.
  	 */
+	if (hotadd && (zone_size_pages == PAGES_PER_SECTION))
+		zone_size_pages = PAGES_PER_SECTION << 2;
  	zone->wait_table_size = wait_table_size(zone_size_pages);
  	zone->wait_table_bits =	wait_table_bits(zone->wait_table_size);
-	zone->wait_table = (wait_queue_head_t *)
-		alloc_bootmem_node(pgdat, zone->wait_table_size
-					* sizeof(wait_queue_head_t));
-
+	allocsize = zone->wait_table_size * sizeof(wait_queue_head_t);
+	if (hotadd)
+		zone->wait_table = kmalloc(allocsize, GFP_KERNEL);
+	else
+		zone->wait_table = (wait_queue_head_t *)
+			alloc_bootmem_node(pgdat, allocsize);
  	for(i = 0; i < zone->wait_table_size; ++i)
  		init_waitqueue_head(zone->wait_table + i);
  }
@@ -1994,7 +2002,6 @@ static __devinit void init_currently_emp
  {
  	struct pglist_data *pgdat = zone->zone_pgdat;

-	zone_wait_table_init(zone, size);
  	pgdat->nr_zones = zone_idx(zone) + 1;

  	zone->zone_mem_map = pfn_to_page(zone_start_pfn);
@@ -2003,6 +2010,7 @@ static __devinit void init_currently_emp
  	memmap_init(size, pgdat->node_id, zone_idx(zone), zone_start_pfn);

  	zone_init_free_lists(pgdat, zone, zone->spanned_pages);
+	zone->spanned_pages = size;
  }

  /*
@@ -2022,7 +2030,7 @@ static void __init free_area_init_core(s
  	pgdat->nr_zones = 0;
  	init_waitqueue_head(&pgdat->kswapd_wait);
  	pgdat->kswapd_max_order = 0;
-	
+
  	for (j = 0; j < MAX_NR_ZONES; j++) {
  		struct zone *zone = pgdat->node_zones + j;
  		unsigned long size, realsize;
@@ -2054,10 +2062,12 @@ static void __init free_area_init_core(s
  		zone->nr_active = 0;
  		zone->nr_inactive = 0;
  		atomic_set(&zone->reclaim_in_progress, 0);
+
  		if (!size)
  			continue;

  		zonetable_add(zone, nid, j, zone_start_pfn, size);
+		zone_wait_table_init(zone, size, 0);
  		init_currently_empty_zone(zone, zone_start_pfn, size);
  		zone_start_pfn += size;
  	}
@@ -2669,3 +2679,49 @@ void *__init alloc_large_system_hash(con

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
+static int __build_zonelists(void *__pgdat)
+{
+	pg_data_t *pgdat = __pgdat;
+	build_zonelists(pgdat);
+	return 0;
+}
+DEFINE_SPINLOCK(zone_init_lock);
+int hot_add_zone_init(struct zone *zone, unsigned long phys_start_pfn, unsigned long size_pages)
+{
+	int ret = 0;
+	unsigned long flags;
+	spin_lock_irqsave(&zone_init_lock,flags);
+	if (zone_previously_initialized(zone)) {
+		ret = -EEXIST;
+		goto out;
+	}
+
+	zone_wait_table_init(zone, size_pages, 1);
+	printk("hot add zone init %lx %lx.....\n",phys_start_pfn, size_pages);
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
+	stop_machine_run(__build_zonelists, zone->zone_pgdat, NR_CPUS);
+out:
+	spin_unlock_irqrestore(&zone_init_lock, flags);
+	return ret;
+}
+#endif
Index: linux-2.6.14-mm2/mm/memory_hotplug.c
===================================================================
--- linux-2.6.14-mm2.orig/mm/memory_hotplug.c
+++ linux-2.6.14-mm2/mm/memory_hotplug.c
@@ -48,6 +48,8 @@ static int __add_section(struct zone *zo

  	ret = sparse_add_one_section(zone, phys_start_pfn, nr_pages);

+	hot_add_zone_init(zone, phys_start_pfn, PAGES_PER_SECTION);
+
  	if (ret < 0)
  		return ret;



