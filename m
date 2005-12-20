Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750872AbVLTIxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbVLTIxt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 03:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbVLTIxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 03:53:48 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:4282 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750868AbVLTIxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 03:53:47 -0500
Date: Tue, 20 Dec 2005 17:52:27 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>
Subject: [Patch] New zone ZONE_EASY_RECLAIM take 4. (change build_zonelists)[3/8]
Cc: Joel Schopp <jschopp@austin.ibm.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.057
Message-Id: <20051220172910.1B0C.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.21.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is changing build_zonelists for new zone.

__GFP_xxxs are flag for requires of page allocation which zone
is prefered. But, it is used as an index number for zonelists[] too.
But after my patch, __GFP_xxx might be set at same time. So,
last set bit number of __GFP is recognized for zonelists' index
by this patch.

take3->take4:
  take 3's modification was still wrong.
  __GFP_EASY_RECLAIM is 0x04 on i386, so fls(__GFP_EASY_RECLAIM)
  is 3. zone 3 is ZONE_HIGHMEM, not ZONE_EASY_RECLAIM.
  So, I rearranged __GFP_XXX flags (see: define gfp_easy_relcaim patch)
  and fls() is used at highest_zone() again.

take2 -> take 3:
 This patch is modified take 3 to avoid panic on i386.
 __GFP_DMA32 is 0 for i386. So, ZONE_DMA32 is selected 
 if zone_bits is 0 which means Zone_normal. 
 Zone_DMA32 is not allocated on i386, so kernel paniced 
 by no normal memory.
 In this patch, even if zone_bits is 0 adn __GFP_DMA32 is 0,
 Zone_Normal is selected.


Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

Index: zone_reclaim/mm/page_alloc.c
===================================================================
--- zone_reclaim.orig/mm/page_alloc.c	2005-12-19 20:18:29.000000000 +0900
+++ zone_reclaim/mm/page_alloc.c	2005-12-19 20:19:56.000000000 +0900
@@ -1585,14 +1585,11 @@ static int __init build_zonelists_node(p
 {
 	struct zone *zone;
 
-	BUG_ON(zone_type > ZONE_HIGHMEM);
+	BUG_ON(zone_type > ZONE_EASY_RECLAIM);
 
 	do {
 		zone = pgdat->node_zones + zone_type;
 		if (populated_zone(zone)) {
-#ifndef CONFIG_HIGHMEM
-			BUG_ON(zone_type > ZONE_NORMAL);
-#endif
 			zonelist->zones[nr_zones++] = zone;
 			check_highest_zone(zone_type);
 		}
@@ -1605,12 +1602,17 @@ static int __init build_zonelists_node(p
 static inline int highest_zone(int zone_bits)
 {
 	int res = ZONE_NORMAL;
-	if (zone_bits & (__force int)__GFP_HIGHMEM)
-		res = ZONE_HIGHMEM;
-	if (zone_bits & (__force int)__GFP_DMA32)
-		res = ZONE_DMA32;
-	if (zone_bits & (__force int)__GFP_DMA)
+
+	if (zone_bits == fls((__force int)__GFP_DMA))
 		res = ZONE_DMA;
+	if (zone_bits == fls((__force int)__GFP_DMA32) &&
+	    (__force int)__GFP_DMA32 == 0x02)
+		res = ZONE_DMA32;
+	if (zone_bits == fls((__force int)__GFP_HIGHMEM))
+		res = ZONE_HIGHMEM;
+	if (zone_bits == fls((__force int)__GFP_EASY_RECLAIM))
+		res = ZONE_EASY_RECLAIM;
+
 	return res;
 }
 
Index: zone_reclaim/include/linux/gfp.h
===================================================================
--- zone_reclaim.orig/include/linux/gfp.h	2005-12-19 20:19:37.000000000 +0900
+++ zone_reclaim/include/linux/gfp.h	2005-12-19 20:19:56.000000000 +0900
@@ -81,7 +81,7 @@ struct vm_area_struct;
 
 static inline int gfp_zone(gfp_t gfp)
 {
-	int zone = GFP_ZONEMASK & (__force int) gfp;
+	int zone = fls(GFP_ZONEMASK & (__force int) gfp);
 	BUG_ON(zone >= GFP_ZONETYPES);
 	return zone;
 }

-- 
Yasunori Goto 


