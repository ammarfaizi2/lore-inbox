Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbVLTIzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbVLTIzM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 03:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbVLTIzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 03:55:11 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:17874 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750884AbVLTIzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 03:55:06 -0500
Date: Tue, 20 Dec 2005 17:53:06 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>
Subject: [Patch] New zone ZONE_EASY_RECLAIM take 4. (is_easy_reclaim func)[4/8]
Cc: Joel Schopp <jschopp@austin.ibm.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.057
Message-Id: <20051220172927.1B0E.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.21.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is for calculation of the watermark zone->pages_min/low/high.

There is no change at take 4.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

Index: zone_reclaim/include/linux/mmzone.h
===================================================================
--- zone_reclaim.orig/include/linux/mmzone.h	2005-12-19 20:24:04.000000000 +0900
+++ zone_reclaim/include/linux/mmzone.h	2005-12-19 20:24:07.000000000 +0900
@@ -394,6 +394,11 @@ static inline int populated_zone(struct 
 	return (!!zone->present_pages);
 }
 
+static inline int is_easy_reclaim_idx(int idx)
+{
+	return (idx == ZONE_EASY_RECLAIM);
+}
+
 static inline int is_highmem_idx(int idx)
 {
 	return (idx == ZONE_HIGHMEM);
@@ -410,11 +415,21 @@ static inline int is_normal_idx(int idx)
  *              to ZONE_{DMA/NORMAL/HIGHMEM/etc} in general code to a minimum.
  * @zone - pointer to struct zone variable
  */
+static inline int is_easy_reclaim(struct zone *zone)
+{
+	return zone == zone->zone_pgdat->node_zones + ZONE_EASY_RECLAIM;
+}
+
 static inline int is_highmem(struct zone *zone)
 {
 	return zone == zone->zone_pgdat->node_zones + ZONE_HIGHMEM;
 }
 
+static inline int is_higher_zone(struct zone *zone)
+{
+	return (is_highmem(zone) || is_easy_reclaim(zone));
+}
+
 static inline int is_normal(struct zone *zone)
 {
 	return zone == zone->zone_pgdat->node_zones + ZONE_NORMAL;
Index: zone_reclaim/mm/page_alloc.c
===================================================================
--- zone_reclaim.orig/mm/page_alloc.c	2005-12-19 20:24:04.000000000 +0900
+++ zone_reclaim/mm/page_alloc.c	2005-12-19 20:24:07.000000000 +0900
@@ -2592,7 +2592,7 @@ void setup_per_zone_pages_min(void)
 
 	/* Calculate total number of !ZONE_HIGHMEM pages */
 	for_each_zone(zone) {
-		if (!is_highmem(zone))
+		if (!is_higher_zone(zone))
 			lowmem_pages += zone->present_pages;
 	}
 
@@ -2600,7 +2600,7 @@ void setup_per_zone_pages_min(void)
 		unsigned long tmp;
 		spin_lock_irqsave(&zone->lru_lock, flags);
 		tmp = (pages_min * zone->present_pages) / lowmem_pages;
-		if (is_highmem(zone)) {
+		if (is_higher_zone(zone)) {
 			/*
 			 * __GFP_HIGH and PF_MEMALLOC allocations usually don't
 			 * need highmem pages, so cap pages_min to a small

-- 
Yasunori Goto 


