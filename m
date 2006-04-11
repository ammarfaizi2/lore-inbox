Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWDKLbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWDKLbU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 07:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWDKLbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 07:31:19 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:29838 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750763AbWDKLay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 07:30:54 -0400
Date: Tue, 11 Apr 2006 20:30:33 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [Patch:003/005] wait_table and zonelist initializing for memory hotadd(add return code for init_current_empty_zone)
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
In-Reply-To: <20060411202031.5643.Y-GOTO@jp.fujitsu.com>
References: <20060411202031.5643.Y-GOTO@jp.fujitsu.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060411202714.5649.Y-GOTO@jp.fujitsu.com>
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

 include/linux/mmzone.h |    3 +++
 mm/memory_hotplug.c    |   15 +++++++++++++--
 mm/page_alloc.c        |   11 ++++++++---
 3 files changed, 24 insertions(+), 5 deletions(-)

Index: pgdat10/mm/page_alloc.c
===================================================================
--- pgdat10.orig/mm/page_alloc.c	2006-04-11 15:15:28.000000000 +0900
+++ pgdat10/mm/page_alloc.c	2006-04-11 15:15:36.000000000 +0900
@@ -2112,8 +2112,9 @@ static __meminit void zone_pcp_init(stru
 			zone->name, zone->present_pages, batch);
 }
 
-static __meminit void init_currently_empty_zone(struct zone *zone,
-		unsigned long zone_start_pfn, unsigned long size)
+__meminit int init_currently_empty_zone(struct zone *zone,
+					unsigned long zone_start_pfn,
+					unsigned long size)
 {
 	struct pglist_data *pgdat = zone->zone_pgdat;
 
@@ -2125,6 +2126,8 @@ static __meminit void init_currently_emp
 	memmap_init(size, pgdat->node_id, zone_idx(zone), zone_start_pfn);
 
 	zone_init_free_lists(pgdat, zone, zone->spanned_pages);
+
+	return 0;
 }
 
 /*
@@ -2139,6 +2142,7 @@ static void __meminit free_area_init_cor
 	unsigned long j;
 	int nid = pgdat->node_id;
 	unsigned long zone_start_pfn = pgdat->node_start_pfn;
+	int ret;
 
 	pgdat_resize_init(pgdat);
 	pgdat->nr_zones = 0;
@@ -2180,7 +2184,8 @@ static void __meminit free_area_init_cor
 			continue;
 
 		zonetable_add(zone, nid, j, zone_start_pfn, size);
-		init_currently_empty_zone(zone, zone_start_pfn, size);
+		ret = init_currently_empty_zone(zone, zone_start_pfn, size);
+		BUG_ON(ret);
 		zone_start_pfn += size;
 	}
 }
Index: pgdat10/mm/memory_hotplug.c
===================================================================
--- pgdat10.orig/mm/memory_hotplug.c	2006-04-11 15:15:28.000000000 +0900
+++ pgdat10/mm/memory_hotplug.c	2006-04-11 15:15:36.000000000 +0900
@@ -26,7 +26,7 @@
 
 extern void zonetable_add(struct zone *zone, int nid, int zid, unsigned long pfn,
 			  unsigned long size);
-static void __add_zone(struct zone *zone, unsigned long phys_start_pfn)
+static int __add_zone(struct zone *zone, unsigned long phys_start_pfn)
 {
 	struct pglist_data *pgdat = zone->zone_pgdat;
 	int nr_pages = PAGES_PER_SECTION;
@@ -34,8 +34,15 @@ static void __add_zone(struct zone *zone
 	int zone_type;
 
 	zone_type = zone - pgdat->node_zones;
+	if (!populated_zone(zone)) {
+		int ret = 0;
+		ret = init_currently_empty_zone(zone, phys_start_pfn, nr_pages);
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
 
Index: pgdat10/include/linux/mmzone.h
===================================================================
--- pgdat10.orig/include/linux/mmzone.h	2006-04-11 15:15:28.000000000 +0900
+++ pgdat10/include/linux/mmzone.h	2006-04-11 15:15:36.000000000 +0900
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


