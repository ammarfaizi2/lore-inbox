Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbWFRHfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbWFRHfF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 03:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbWFRHeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 03:34:50 -0400
Received: from mail30.syd.optusnet.com.au ([211.29.133.193]:52868 "EHLO
	mail30.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932141AbWFRHeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 03:34:20 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux list <linux-kernel@vger.kernel.org>
Subject: [ckpatch][20/29] mm-lots_watermark.diff
Date: Sun, 18 Jun 2006 17:34:11 +1000
User-Agent: KMail/1.9.3
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 5298
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200606181734.11453.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The vm currently performs scanning when allocating ram once the watermarks
are below the pages_low value and tries to restore them to the pages_high
watermark. The disadvantage of this is that we are scanning most aggresssively
at the same time we are allocating ram regardless of the stress the vm is
under. Add a pages_lots watermark and allow the watermark to be relaxed
according to the stress the vm is at the time (according to the priority
value). Thus we have more in reserve next time we are allocating ram and end
up scanning less aggresssively. Note the actual pages_lots isn't used directly
in this code.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

 include/linux/mmzone.h |    2 +-
 mm/page_alloc.c        |    5 +++++
 mm/vmscan.c            |   18 +++++++++++++++---
 3 files changed, 21 insertions(+), 4 deletions(-)

Index: linux-ck-dev/include/linux/mmzone.h
===================================================================
--- linux-ck-dev.orig/include/linux/mmzone.h	2006-06-18 15:20:12.000000000 +1000
+++ linux-ck-dev/include/linux/mmzone.h	2006-06-18 15:25:00.000000000 +1000
@@ -123,7 +123,7 @@ struct per_cpu_pageset {
 struct zone {
 	/* Fields commonly accessed by the page allocator */
 	unsigned long		free_pages;
-	unsigned long		pages_min, pages_low, pages_high;
+	unsigned long		pages_min, pages_low, pages_high, pages_lots;
 	/*
 	 * We don't know if the memory that we're going to allocate will be freeable
 	 * or/and it will be released eventually, so to avoid totally wasting several
Index: linux-ck-dev/mm/page_alloc.c
===================================================================
--- linux-ck-dev.orig/mm/page_alloc.c	2006-06-18 15:20:12.000000000 +1000
+++ linux-ck-dev/mm/page_alloc.c	2006-06-18 15:25:00.000000000 +1000
@@ -1461,6 +1461,7 @@ void show_free_areas(void)
 			" min:%lukB"
 			" low:%lukB"
 			" high:%lukB"
+			" lots:%lukB"
 			" active:%lukB"
 			" inactive:%lukB"
 			" present:%lukB"
@@ -1472,6 +1473,7 @@ void show_free_areas(void)
 			K(zone->pages_min),
 			K(zone->pages_low),
 			K(zone->pages_high),
+			K(zone->pages_lots),
 			K(zone->nr_active),
 			K(zone->nr_inactive),
 			K(zone->present_pages),
@@ -2261,6 +2263,7 @@ static int zoneinfo_show(struct seq_file
 			   "\n        min      %lu"
 			   "\n        low      %lu"
 			   "\n        high     %lu"
+			   "\n        lots     %lu"
 			   "\n        active   %lu"
 			   "\n        inactive %lu"
 			   "\n        scanned  %lu (a: %lu i: %lu)"
@@ -2270,6 +2273,7 @@ static int zoneinfo_show(struct seq_file
 			   zone->pages_min,
 			   zone->pages_low,
 			   zone->pages_high,
+			   zone->pages_lots,
 			   zone->nr_active,
 			   zone->nr_inactive,
 			   zone->pages_scanned,
@@ -2609,6 +2613,7 @@ void setup_per_zone_pages_min(void)
 
 		zone->pages_low   = zone->pages_min + (tmp >> 2);
 		zone->pages_high  = zone->pages_min + (tmp >> 1);
+		zone->pages_lots  = zone->pages_min + tmp;
 		spin_unlock_irqrestore(&zone->lru_lock, flags);
 	}
 
Index: linux-ck-dev/mm/vmscan.c
===================================================================
--- linux-ck-dev.orig/mm/vmscan.c	2006-06-18 15:24:58.000000000 +1000
+++ linux-ck-dev/mm/vmscan.c	2006-06-18 15:25:00.000000000 +1000
@@ -1095,6 +1095,7 @@ loop_again:
 		 */
 		for (i = pgdat->nr_zones - 1; i >= 0; i--) {
 			struct zone *zone = pgdat->node_zones + i;
+			unsigned long watermark;
 
 			if (!populated_zone(zone))
 				continue;
@@ -1102,11 +1103,18 @@ loop_again:
 			if (zone->all_unreclaimable && priority != DEF_PRIORITY)
 				continue;
 
-			if (!zone_watermark_ok(zone, order, zone->pages_high,
-					       0, 0)) {
+			/*
+			 * The watermark is relaxed depending on the
+			 * level of "priority" till it drops to
+			 * pages_high.
+			 */
+			watermark = zone->pages_high + (zone->pages_high *
+				    priority / DEF_PRIORITY);
+			if (!zone_watermark_ok(zone, order, watermark, 0, 0)) {
 				end_zone = i;
 				goto scan;
 			}
+
 		}
 		goto out;
 scan:
@@ -1128,6 +1136,7 @@ scan:
 		for (i = 0; i <= end_zone; i++) {
 			struct zone *zone = pgdat->node_zones + i;
 			int nr_slab;
+			unsigned long watermark;
 
 			if (!populated_zone(zone))
 				continue;
@@ -1135,7 +1144,10 @@ scan:
 			if (zone->all_unreclaimable && priority != DEF_PRIORITY)
 				continue;
 
-			if (!zone_watermark_ok(zone, order, zone->pages_high,
+			watermark = zone->pages_high + (zone->pages_high *
+				    priority / DEF_PRIORITY);
+
+			if (!zone_watermark_ok(zone, order, watermark,
 					       end_zone, 0))
 				all_zones_ok = 0;
 			zone->temp_priority = priority;

-- 
-ck
