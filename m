Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752105AbWCHNmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105AbWCHNmj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 08:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752106AbWCHNmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 08:42:38 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:8635 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1752105AbWCHNmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 08:42:22 -0500
Date: Wed, 08 Mar 2006 22:42:19 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: "Luck, Tony" <tony.luck@intel.com>, Andi Kleen <ak@suse.de>,
       Joel Schopp <jschopp@austin.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: [PATCH: 009/017](RFC) Memory hotplug for new nodes v.3. (add return code init_currently_empty_zone)
Cc: linux-ia64@vger.kernel.org, Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@osdl.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060308213104.0034.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When add_zone() is called against empty zone (not populated zone),
we have to initialize the zone which didn't initialize at boot time.
But, init_currently_empty_zone() may fail due to allocation of 
wait table. So, this patch is to catch its error code.

Changes against wait_table is in the next patch.


Signed-off-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

Index: pgdat6/mm/page_alloc.c
===================================================================
--- pgdat6.orig/mm/page_alloc.c	2006-03-06 18:25:37.000000000 +0900
+++ pgdat6/mm/page_alloc.c	2006-03-06 18:26:22.000000000 +0900
@@ -2107,8 +2107,9 @@ static __meminit void zone_pcp_init(stru
 		zone->name, zone->present_pages, batch);
 }
 
-static __meminit void init_currently_empty_zone(struct zone *zone,
-		unsigned long zone_start_pfn, unsigned long size)
+__meminit int init_currently_empty_zone(struct zone *zone,
+					unsigned long zone_start_pfn,
+					unsigned long size)
 {
 	struct pglist_data *pgdat = zone->zone_pgdat;
 
@@ -2120,6 +2121,8 @@ static __meminit void init_currently_emp
 	memmap_init(size, pgdat->node_id, zone_idx(zone), zone_start_pfn);
 
 	zone_init_free_lists(pgdat, zone, zone->spanned_pages);
+
+	return 0;
 }
 
 /*
@@ -2134,6 +2137,7 @@ static void __init free_area_init_core(s
 	unsigned long j;
 	int nid = pgdat->node_id;
 	unsigned long zone_start_pfn = pgdat->node_start_pfn;
+	int ret;
 
 	pgdat_resize_init(pgdat);
 	pgdat->nr_zones = 0;
@@ -2175,7 +2179,8 @@ static void __init free_area_init_core(s
 			continue;
 
 		zonetable_add(zone, nid, j, zone_start_pfn, size);
-		init_currently_empty_zone(zone, zone_start_pfn, size);
+		ret = init_currently_empty_zone(zone, zone_start_pfn, size);
+		BUG_ON(ret);
 		zone_start_pfn += size;
 	}
 }
Index: pgdat6/mm/memory_hotplug.c
===================================================================
--- pgdat6.orig/mm/memory_hotplug.c	2006-03-06 18:26:17.000000000 +0900
+++ pgdat6/mm/memory_hotplug.c	2006-03-06 18:26:22.000000000 +0900
@@ -26,16 +26,23 @@
 
 extern void zonetable_add(struct zone *zone, int nid, int zid, unsigned long pfn,
 			  unsigned long size);
-static void __add_zone(struct zone *zone, unsigned long phys_start_pfn)
+static int __add_zone(struct zone *zone, unsigned long phys_start_pfn)
 {
 	struct pglist_data *pgdat = zone->zone_pgdat;
 	int nr_pages = PAGES_PER_SECTION;
 	int nid = pgdat->node_id;
 	int zone_type;
+	int ret = 0;
 
 	zone_type = zone - pgdat->node_zones;
+	if (!populated_zone(zone)) {
+		ret =init_currently_empty_zone(zone, phys_start_pfn , nr_pages);
+		if (ret < 0)
+			return ret;
+	}
 	memmap_init_zone(nr_pages, nid, zone_type, phys_start_pfn);
 	zonetable_add(zone, nid, zone_type, phys_start_pfn, nr_pages);
+	return 0;
 }
 
 extern int sparse_add_one_section(struct zone *zone, unsigned long start_pfn,
@@ -50,7 +57,11 @@ static int __add_section(struct zone *zo
 	if (ret < 0)
 		return ret;
 
-	__add_zone(zone, phys_start_pfn);
+	ret = __add_zone(zone, phys_start_pfn);
+
+	if (ret < 0)
+		return ret;
+
 	return register_new_memory(__pfn_to_section(phys_start_pfn));
 }
 
Index: pgdat6/include/linux/mmzone.h
===================================================================
--- pgdat6.orig/include/linux/mmzone.h	2006-03-06 18:25:37.000000000 +0900
+++ pgdat6/include/linux/mmzone.h	2006-03-06 18:26:22.000000000 +0900
@@ -332,6 +332,9 @@ void wakeup_kswapd(struct zone *zone, in
 int zone_watermark_ok(struct zone *z, int order, unsigned long mark,
 		int classzone_idx, int alloc_flags);
 
+extern int init_currently_empty_zone(struct zone *zone, unsigned long start_pfn,
+				     unsigned long size);
+
 #ifdef CONFIG_HAVE_MEMORY_PRESENT
 void memory_present(int nid, unsigned long start, unsigned long end);
 #else

-- 
Yasunori Goto 


