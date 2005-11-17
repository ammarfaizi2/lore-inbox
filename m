Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbVKQOB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbVKQOB4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 09:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbVKQOB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 09:01:56 -0500
Received: from mail04.syd.optusnet.com.au ([211.29.132.185]:65478 "EHLO
	mail04.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750830AbVKQOBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 09:01:55 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux-mm@kvack.org
Subject: [PATCH] mm: populated_zone
Date: Fri, 18 Nov 2005 01:01:42 +1100
User-Agent: KMail/1.8.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 5973
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200511180101.43084.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are numerous places we check whether a zone is populated or not.

Provide a helper function to check for populated zones and convert
all checks for zone->present_pages.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

 include/linux/mmzone.h |    5 +++++
 mm/mempolicy.c         |    2 +-
 mm/page_alloc.c        |   16 ++++++++--------
 mm/swap_prefetch.c     |    4 ++--
 mm/vmscan.c            |    8 ++++----
 5 files changed, 20 insertions(+), 15 deletions(-)

---

Index: linux-2.6.14-mm2/include/linux/mmzone.h
===================================================================
--- linux-2.6.14-mm2.orig/include/linux/mmzone.h
+++ linux-2.6.14-mm2/include/linux/mmzone.h
@@ -400,6 +400,11 @@ static inline struct zone *next_zone(str
 #define for_each_zone(zone) \
 	for (zone = pgdat_list->node_zones; zone; zone = next_zone(zone))
 
+static inline int populated_zone(struct zone *zone)
+{
+	return (!!zone->present_pages);
+}
+
 static inline int is_highmem_idx(int idx)
 {
 	return (idx == ZONE_HIGHMEM);
Index: linux-2.6.14-mm2/mm/mempolicy.c
===================================================================
--- linux-2.6.14-mm2.orig/mm/mempolicy.c
+++ linux-2.6.14-mm2/mm/mempolicy.c
@@ -139,7 +139,7 @@ static struct zonelist *bind_zonelist(no
 		int k;
 		for (k = MAX_NR_ZONES-1; k >= 0; k--) {
 			struct zone *z = &NODE_DATA(nd)->node_zones[k];
-			if (!z->present_pages)
+			if (!populated_zone(z))
 				continue;
 			zl->zones[num++] = z;
 			if (k > policy_zone)
Index: linux-2.6.14-mm2/mm/page_alloc.c
===================================================================
--- linux-2.6.14-mm2.orig/mm/page_alloc.c
+++ linux-2.6.14-mm2/mm/page_alloc.c
@@ -1372,7 +1372,7 @@ void show_free_areas(void)
 		show_node(zone);
 		printk("%s per-cpu:", zone->name);
 
-		if (!zone->present_pages) {
+		if (!populated_zone(zone)) {
 			printk(" empty\n");
 			continue;
 		} else
@@ -1450,7 +1450,7 @@ void show_free_areas(void)
 
 		show_node(zone);
 		printk("%s: ", zone->name);
-		if (!zone->present_pages) {
+		if (!populated_zone(zone)) {
 			printk("empty\n");
 			continue;
 		}
@@ -1479,7 +1479,7 @@ static int __init build_zonelists_node(p
 		BUG();
 	case ZONE_HIGHMEM:
 		zone = pgdat->node_zones + ZONE_HIGHMEM;
-		if (zone->present_pages) {
+		if (populated_zone(zone)) {
 #ifndef CONFIG_HIGHMEM
 			BUG();
 #endif
@@ -1487,15 +1487,15 @@ static int __init build_zonelists_node(p
 		}
 	case ZONE_NORMAL:
 		zone = pgdat->node_zones + ZONE_NORMAL;
-		if (zone->present_pages)
+		if (populated_zone(zone))
 			zonelist->zones[j++] = zone;
 	case ZONE_DMA32:
 		zone = pgdat->node_zones + ZONE_DMA32;
-		if (zone->present_pages)
+		if (populated_zone(zone))
 			zonelist->zones[j++] = zone;
 	case ZONE_DMA:
 		zone = pgdat->node_zones + ZONE_DMA;
-		if (zone->present_pages)
+		if (populated_zone(zone))
 			zonelist->zones[j++] = zone;
 	}
 
@@ -2156,7 +2156,7 @@ static int frag_show(struct seq_file *m,
 	int order;
 
 	for (zone = node_zones; zone - node_zones < MAX_NR_ZONES; ++zone) {
-		if (!zone->present_pages)
+		if (!populated_zone(zone))
 			continue;
 
 		spin_lock_irqsave(&zone->lock, flags);
@@ -2189,7 +2189,7 @@ static int zoneinfo_show(struct seq_file
 	for (zone = node_zones; zone - node_zones < MAX_NR_ZONES; zone++) {
 		int i;
 
-		if (!zone->present_pages)
+		if (!populated_zone(zone))
 			continue;
 
 		spin_lock_irqsave(&zone->lock, flags);
Index: linux-2.6.14-mm2/mm/swap_prefetch.c
===================================================================
--- linux-2.6.14-mm2.orig/mm/swap_prefetch.c
+++ linux-2.6.14-mm2/mm/swap_prefetch.c
@@ -176,7 +176,7 @@ static struct page *prefetch_get_page(vo
 	for_each_zone(z) {
 		long free;
 
-		if (z->present_pages == 0)
+		if (!populated_zone(z))
 			continue;
 
 		/* We don't prefetch into DMA */
@@ -291,7 +291,7 @@ static int prefetch_suitable(void)
 	for_each_zone(z) {
 		unsigned long free;
 
-		if (z->present_pages == 0)
+		if (!populated_zone(z))
 			continue;
 		free = z->free_pages;
 		if (z->pages_high * 3 > free)
Index: linux-2.6.14-mm2/mm/vmscan.c
===================================================================
--- linux-2.6.14-mm2.orig/mm/vmscan.c
+++ linux-2.6.14-mm2/mm/vmscan.c
@@ -1122,7 +1122,7 @@ shrink_caches(struct zone **zones, struc
 	for (i = 0; zones[i] != NULL; i++) {
 		struct zone *zone = zones[i];
 
-		if (zone->present_pages == 0)
+		if (!populated_zone(zone))
 			continue;
 
 		if (!cpuset_zone_allowed(zone, __GFP_HARDWALL))
@@ -1292,7 +1292,7 @@ loop_again:
 			for (i = pgdat->nr_zones - 1; i >= 0; i--) {
 				struct zone *zone = pgdat->node_zones + i;
 
-				if (zone->present_pages == 0)
+				if (!populated_zone(zone))
 					continue;
 
 				if (zone->all_unreclaimable &&
@@ -1329,7 +1329,7 @@ scan:
 			struct zone *zone = pgdat->node_zones + i;
 			int nr_slab;
 
-			if (zone->present_pages == 0)
+			if (!populated_zone(zone))
 				continue;
 
 			if (zone->all_unreclaimable && priority != DEF_PRIORITY)
@@ -1481,7 +1481,7 @@ void wakeup_kswapd(struct zone *zone, in
 {
 	pg_data_t *pgdat;
 
-	if (zone->present_pages == 0)
+	if (!populated_zone(zone))
 		return;
 
 	pgdat = zone->zone_pgdat;
