Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWDKLcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWDKLcD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 07:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWDKLb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 07:31:57 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:10934 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750772AbWDKLbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 07:31:38 -0400
Date: Tue, 11 Apr 2006 20:30:39 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [Patch:004/005] wait_table and zonelist initializing for memory hotadd (wait_table initialization)
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
In-Reply-To: <20060411202031.5643.Y-GOTO@jp.fujitsu.com>
References: <20060411202031.5643.Y-GOTO@jp.fujitsu.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060411202802.564B.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Wait_table is initialized according to zone size at boot time.
But, we cannot know the maixmum zone size when memory hotplug is enabled.
It can be changed.... And resizing of wait_table is hard.

So kernel allocate and initialzie wait_table as its maximum size.

Signed-off-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

 mm/page_alloc.c |   47 +++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 41 insertions(+), 6 deletions(-)

Index: pgdat10/mm/page_alloc.c
===================================================================
--- pgdat10.orig/mm/page_alloc.c	2006-04-11 15:15:36.000000000 +0900
+++ pgdat10/mm/page_alloc.c	2006-04-11 19:03:23.000000000 +0900
@@ -1786,6 +1786,7 @@ void __init build_all_zonelists(void)
  */
 #define PAGES_PER_WAITQUEUE	256
 
+#ifndef CONFIG_MEMORY_HOTPLUG
 static inline unsigned long wait_table_hash_nr_entries(unsigned long pages)
 {
 	unsigned long size = 1;
@@ -1804,6 +1805,33 @@ static inline unsigned long wait_table_h
 
 	return max(size, 4UL);
 }
+#else
+/*
+ * XXX: Because zone size might be changed by hot-add,
+ *	It is hard to determin suitable value for wait_table as traditional.
+ *	So, we use maximum entries now.
+ *
+ *	  The max wait table size = 4096 x sizeof(wait_queue_head_t) byte.
+ *	    ex:
+ *	      i386 (preemption config)    : 4096 x 16 = 64Kbyte.
+ *	      ia64, x86-64 (no preemption): 4096 x 20 = 80Kbyte.
+ *	      ia64, x86-64 (preemption)   : 4096 x 24 = 96Kbyte.
+ *
+ *	  The maximum entries are prepared when a zone's memory is
+ *	  (512K + 256) pages or more by traditional way. (See above)
+ *	  It equals ....
+ *	    i386, x86-64, powerpc(4K page size) : =  ( 2G + 1M)byte.
+ *	    ia64(16K page size)                 : =  ( 8G + 4M)byte.
+ *	    powerpc (64K page size)             : =  (32G +16M)byte.
+ *
+ *	  If system doesn't have this size or more memory in the future,
+ *	  wait_table might be too bigger than suitable.
+ */
+static inline unsigned long wait_table_hash_nr_entries(unsigned long pages)
+{
+	return 4096UL;
+}
+#endif
 
 /*
  * This is an integer logarithm so that shifts can be used later
@@ -2072,10 +2100,11 @@ void __init setup_per_cpu_pageset(void)
 #endif
 
 static __meminit
-void zone_wait_table_init(struct zone *zone, unsigned long zone_size_pages)
+int zone_wait_table_init(struct zone *zone, unsigned long zone_size_pages)
 {
 	int i;
 	struct pglist_data *pgdat = zone->zone_pgdat;
+	size_t alloc_size;
 
 	/*
 	 * The per-page waitqueue mechanism uses hashed waitqueues
@@ -2085,12 +2114,32 @@ void zone_wait_table_init(struct zone *z
 		 wait_table_hash_nr_entries(zone_size_pages);
 	zone->wait_table_bits =
 		wait_table_bits(zone->wait_table_hash_nr_entries);
-	zone->wait_table = (wait_queue_head_t *)
-		alloc_bootmem_node(pgdat, zone->wait_table_hash_nr_entries
-					* sizeof(wait_queue_head_t));
+	alloc_size = zone->wait_table_hash_nr_entries
+					* sizeof(wait_queue_head_t);
+
+ 	if (system_state == SYSTEM_BOOTING) {
+		zone->wait_table = (wait_queue_head_t *)
+			alloc_bootmem_node(pgdat, alloc_size);
+	} else {
+		/*
+		 * XXX: This case means that a zone whose size was 0 gets new
+		 *      memory by memory hot-add.
+		 *      But, this may be the case that "new node" is hotadded.
+		 * 	If its case, vmalloc() will not get this new node's
+		 *      memory. Because this wait_table must be initialized
+		 *      to use this new node itself too.
+		 *      To use this new node's memory, further consideration
+		 *      will be necessary.
+		 */
+		zone->wait_table = (wait_queue_head_t *)vmalloc(alloc_size);
+	}
+	if (!zone->wait_table)
+		return -ENOMEM;
 
 	for(i = 0; i < zone->wait_table_hash_nr_entries; ++i)
 		init_waitqueue_head(zone->wait_table + i);
+
+	return 0;
 }
 
 static __meminit void zone_pcp_init(struct zone *zone)
@@ -2117,8 +2166,10 @@ __meminit int init_currently_empty_zone(
 					unsigned long size)
 {
 	struct pglist_data *pgdat = zone->zone_pgdat;
-
-	zone_wait_table_init(zone, size);
+	int ret;
+	ret = zone_wait_table_init(zone, size);
+	if (ret)
+		return ret;
 	pgdat->nr_zones = zone_idx(zone) + 1;
 
 	zone->zone_start_pfn = zone_start_pfn;

-- 
Yasunori Goto 


