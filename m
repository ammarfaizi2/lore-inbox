Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964836AbWBQNaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbWBQNaL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 08:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbWBQNaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 08:30:10 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:22745 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S964836AbWBQN3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 08:29:25 -0500
Date: Fri, 17 Feb 2006 22:28:43 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH: 003/012] Memory hotplug for new nodes v.2. (Wait table and zonelists initalization)
Cc: "Luck, Tony" <tony.luck@intel.com>, Andi Kleen <ak@suse.de>,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       Joel Schopp <jschopp@austin.ibm.com>, Dave Hansen <haveblue@us.ibm.com>,
       linux-ia64@vger.kernel.org,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       x86-64 Discuss <discuss@x86-64.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060217211336.406E.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch is to initialize wait table and zonelists for new pgdat.
When new node is added, free_area_init_node() is called to initialize
pgdat. But, wait table must be allocated by kmalloc (not bootmem) for it.
And, zonelists is accessed from any other process every time,
So, stop_machine_run() is used for safety update.


 Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
 Signed-off-by: Hiroyuki Kamezawa <kamezawa.hiroyu@jp.fujitsu.com>
 Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>


Index: pgdat3/mm/page_alloc.c
===================================================================
--- pgdat3.orig/mm/page_alloc.c	2006-02-17 16:52:50.000000000 +0900
+++ pgdat3/mm/page_alloc.c	2006-02-17 18:41:52.000000000 +0900
@@ -37,6 +37,7 @@
 #include <linux/nodemask.h>
 #include <linux/vmalloc.h>
 #include <linux/mempolicy.h>
+#include <linux/stop_machine.h>
 
 #include <asm/tlbflush.h>
 #include "internal.h"
@@ -2077,18 +2078,35 @@ void __init setup_per_cpu_pageset(void)
 static __meminit
 void zone_wait_table_init(struct zone *zone, unsigned long zone_size_pages)
 {
-	int i;
+	int i, hotadd = (system_state == SYSTEM_RUNNING);
 	struct pglist_data *pgdat = zone->zone_pgdat;
 
 	/*
 	 * The per-page waitqueue mechanism uses hashed waitqueues
 	 * per zone.
 	 */
-	zone->wait_table_size = wait_table_size(zone_size_pages);
-	zone->wait_table_bits =	wait_table_bits(zone->wait_table_size);
-	zone->wait_table = (wait_queue_head_t *)
-		alloc_bootmem_node(pgdat, zone->wait_table_size
-					* sizeof(wait_queue_head_t));
+	if (hotadd){
+		unsigned long size = 4096UL; /* Max size */
+		wait_queue_head_t *p;
+
+		while (size){
+			p = kmalloc(size * sizeof(wait_queue_head_t),
+				    GFP_ATOMIC);
+			if (p)
+				break;
+			size >>= 1;
+		}
+		zone->wait_table_size = size;
+		zone->wait_table_bits = wait_table_bits(size);
+		zone->wait_table = p;
+
+	} else {
+		zone->wait_table_size = wait_table_size(zone_size_pages);
+		zone->wait_table_bits =	wait_table_bits(zone->wait_table_size);
+		zone->wait_table = (wait_queue_head_t *)
+			alloc_bootmem_node(pgdat, zone->wait_table_size
+					        * sizeof(wait_queue_head_t));
+	}
 
 	for(i = 0; i < zone->wait_table_size; ++i)
 		init_waitqueue_head(zone->wait_table + i);
@@ -2126,6 +2144,7 @@ static __meminit void init_currently_emp
 	memmap_init(size, pgdat->node_id, zone_idx(zone), zone_start_pfn);
 
 	zone_init_free_lists(pgdat, zone, zone->spanned_pages);
+	zone->spanned_pages = size;
 }
 
 /*
@@ -2824,3 +2843,53 @@ void *__init alloc_large_system_hash(con
 
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
+		spin_unlock_irqrestore(&zone_init_lock, flags);
+		return -EEXIST;
+	}
+
+	printk(KERN_DEBUG "hot add zone init %lx %lx.....\n",
+	       phys_start_pfn, size_pages);
+	init_currently_empty_zone(zone, phys_start_pfn, size_pages);
+	zone_pcp_init(zone);
+
+	spin_unlock_irqrestore(&zone_init_lock, flags);
+	/*
+	 * This is an awfully blunt way to do this.  But, the
+	 * zonelists are accessed many times over large areas
+	 * of performance-critical code in the allocator.
+	 * That makes it very hard to get a conventional lock
+	 * to work.  This of this as a rw lock with a huge
+	 * write cost.
+	 */
+	stop_machine_run(__build_all_zonelists, zone->zone_pgdat, NR_CPUS);
+
+	return ret;
+}
+#endif
Index: pgdat3/include/linux/mmzone.h
===================================================================
--- pgdat3.orig/include/linux/mmzone.h	2006-02-17 16:52:43.000000000 +0900
+++ pgdat3/include/linux/mmzone.h	2006-02-17 18:41:52.000000000 +0900
@@ -403,7 +403,9 @@ static inline struct zone *next_zone(str
 
 static inline int populated_zone(struct zone *zone)
 {
-	return (!!zone->present_pages);
+	/* When hot-add, present page is 0 at this point.
+	   So check spanned_pages instead of present_pages */
+	return (!!zone->spanned_pages);
 }
 
 static inline int is_highmem_idx(int idx)
Index: pgdat3/mm/memory_hotplug.c
===================================================================
--- pgdat3.orig/mm/memory_hotplug.c	2006-02-17 16:52:49.000000000 +0900
+++ pgdat3/mm/memory_hotplug.c	2006-02-17 18:41:52.000000000 +0900
@@ -48,6 +48,8 @@ static int __add_section(struct zone *zo
 
 	ret = sparse_add_one_section(zone, phys_start_pfn, nr_pages);
 
+	hot_add_zone_init(zone, phys_start_pfn, PAGES_PER_SECTION);
+
 	if (ret < 0)
 		return ret;
 
Index: pgdat3/include/linux/memory_hotplug.h
===================================================================
--- pgdat3.orig/include/linux/memory_hotplug.h	2006-02-17 16:52:49.000000000 +0900
+++ pgdat3/include/linux/memory_hotplug.h	2006-02-17 18:52:37.000000000 +0900
@@ -89,6 +89,7 @@ static inline void clear_node_data_array
 
 extern int new_pgdat_init(int, unsigned long, unsigned long);
 extern void release_pgdat(pg_data_t *);
+extern int hot_add_zone_init(struct zone *, unsigned long, unsigned long);
 
 #else /* ! CONFIG_MEMORY_HOTPLUG */
 /*

-- 
Yasunori Goto 


