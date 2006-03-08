Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752099AbWCHNmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752099AbWCHNmm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 08:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752097AbWCHNmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 08:42:42 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:26555 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1752099AbWCHNmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 08:42:37 -0500
Date: Wed, 08 Mar 2006 22:42:33 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: "Luck, Tony" <tony.luck@intel.com>, Andi Kleen <ak@suse.de>,
       Joel Schopp <jschopp@austin.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: [PATCH: 010/017](RFC) Memory hotplug for new nodes v.3. (allocate wait table)
Cc: linux-ia64@vger.kernel.org, Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@osdl.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060308213301.0036.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Wait_table is initialized according to zone size at boot time.
But, we cannot know the maixmum zone size when memory hotplug is enabled.
It can be changed.... And resizing of wait_table is too hard.

So kernel allocate and initialzie wait_table as its maximum size.

Signed-off-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

Index: pgdat6/mm/page_alloc.c
===================================================================
--- pgdat6.orig/mm/page_alloc.c	2006-03-06 20:27:16.000000000 +0900
+++ pgdat6/mm/page_alloc.c	2006-03-06 20:27:36.000000000 +0900
@@ -1784,6 +1784,7 @@ void __init build_all_zonelists(void)
  */
 #define PAGES_PER_WAITQUEUE	256
 
+#ifdef CONFIG_MEMORY_HOTPLUG
 static inline unsigned long wait_table_size(unsigned long pages)
 {
 	unsigned long size = 1;
@@ -1802,6 +1803,17 @@ static inline unsigned long wait_table_s
 
 	return max(size, 4UL);
 }
+#else
+/*
+ * Because zone size might be changed by hot-add,
+ * We can't determin suitable size for wait_table as traditional.
+ * So, we use maximum size.
+ */
+static inline unsigned long wait_table_size(unsigned long pages)
+{
+	return 4096UL:
+}
+#endif
 
 /*
  * This is an integer logarithm so that shifts can be used later
@@ -2070,7 +2082,7 @@ void __init setup_per_cpu_pageset(void)
 #endif
 
 static __meminit
-void zone_wait_table_init(struct zone *zone, unsigned long zone_size_pages)
+int zone_wait_table_init(struct zone *zone, unsigned long zone_size_pages)
 {
 	int i;
 	struct pglist_data *pgdat = zone->zone_pgdat;
@@ -2081,12 +2093,31 @@ void zone_wait_table_init(struct zone *z
 	 */
 	zone->wait_table_size = wait_table_size(zone_size_pages);
 	zone->wait_table_bits =	wait_table_bits(zone->wait_table_size);
-	zone->wait_table = (wait_queue_head_t *)
-		alloc_bootmem_node(pgdat, zone->wait_table_size
-					* sizeof(wait_queue_head_t));
+	if (system_state == SYSTEM_BOOTING) {
+		zone->wait_table = (wait_queue_head_t *)
+			alloc_bootmem_node(pgdat, zone->wait_table_size
+						* sizeof(wait_queue_head_t));
+	} else {
+		int table_size;
+		/* we can use kmalloc() in run time */
+		do {
+			table_size = zone->wait_table_size
+					* sizeof(wait_queue_head_t);
+			zone->wait_table = kmalloc(table_size, GFP_ATOMIC);
+			if (!zone->wait_table) {
+				/* try half size */
+				zone->wait_table_size >>= 1;
+				zone->wait_table_bits =
+					wait_table_bits(zone->wait_table_size);
+			}
+		} while (zone->wait_table_size && !zone->wait_table);
+	}
+	if (!zone->wait_table)
+		return -ENOMEM;
 
 	for(i = 0; i < zone->wait_table_size; ++i)
 		init_waitqueue_head(zone->wait_table + i);
+	return 0;
 }
 
 static __meminit void zone_pcp_init(struct zone *zone)
@@ -2112,8 +2143,10 @@ __meminit int init_currently_empty_zone(
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


