Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265691AbUFXVnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265691AbUFXVnq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 17:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265740AbUFXVmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 17:42:19 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:8350
	"EHLO voidhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S265676AbUFXVk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 17:40:57 -0400
Date: Thu, 24 Jun 2004 22:40:35 +0100
From: Andy Whitcroft <apw@shadowen.org>
Message-Id: <200406242140.i5OLeZV4028038@voidhawk.shadowen.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix GFP zone modifier interators
Cc: akpm@osdl.org, apw@shadowen.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It appears that when we initialise the per node zonelists we are
using the wrong upper bound for the modifier scan.  This patch
introduces GFP_ZONEMODS to correct this.

-apw

=== 8< ===
For each node there are a defined list of MAX_NR_ZONES zones.
These are selected as a result of the __GFP_DMA and __GFP_HIGHMEM
zone modifier flags being passed to the memory allocator as part of
the GFP mask.  Each node has a set of zone lists, node_zonelists,
which defines the list and order of zones to scan for each flag
combination.  When initialising these lists we iterate over
modifier combinations 0 .. MAX_NR_ZONES.  However, this is only
correct when there are at most ZONES_SHIFT flags.  If another flag
is introduced zonelists for it would not be initialised.

This patch introduces GFP_ZONEMODS (based on GFP_ZONEMASK) as a
bound for the number of modifier combinations.

Revision: $Rev: 296 $

Signed-off-by: Andy Whitcroft <apw@shadowen.org>

---

diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/include/linux/mmzone.h current/include/linux/mmzone.h
--- reference/include/linux/mmzone.h	2004-06-22 22:57:27.000000000 +0100
+++ current/include/linux/mmzone.h	2004-06-24 19:05:25.000000000 +0100
@@ -70,6 +70,7 @@ struct per_cpu_pageset {
 #define ZONES_SHIFT		2	/* ceil(log2(MAX_NR_ZONES)) */
 
 #define GFP_ZONEMASK	0x03
+#define GFP_ZONEMODS	(GFP_ZONEMASK + 1)
 
 /*
  * On machines where it is needed (eg PCs) we divide physical memory
@@ -226,7 +227,7 @@ struct zonelist {
 struct bootmem_data;
 typedef struct pglist_data {
 	struct zone node_zones[MAX_NR_ZONES];
-	struct zonelist node_zonelists[MAX_NR_ZONES];
+	struct zonelist node_zonelists[GFP_ZONEMODS];
 	int nr_zones;
 	struct page *node_mem_map;
 	struct bootmem_data *bdata;
diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/mm/page_alloc.c current/mm/page_alloc.c
--- reference/mm/page_alloc.c	2004-06-22 22:57:27.000000000 +0100
+++ current/mm/page_alloc.c	2004-06-24 21:07:11.000000000 +0100
@@ -1266,7 +1266,7 @@ static void __init build_zonelists(pg_da
 	DECLARE_BITMAP(used_mask, MAX_NUMNODES);
 
 	/* initialize zonelists */
-	for (i = 0; i < MAX_NR_ZONES; i++) {
+	for (i = 0; i < GFP_ZONEMODS; i++) {
 		zonelist = pgdat->node_zonelists + i;
 		memset(zonelist, 0, sizeof(*zonelist));
 		zonelist->zones[0] = NULL;
@@ -1288,7 +1288,7 @@ static void __init build_zonelists(pg_da
 			node_load[node] += load;
 		prev_node = node;
 		load--;
-		for (i = 0; i < MAX_NR_ZONES; i++) {
+		for (i = 0; i < GFP_ZONEMODS; i++) {
 			zonelist = pgdat->node_zonelists + i;
 			for (j = 0; zonelist->zones[j] != NULL; j++);
 
@@ -1311,7 +1311,7 @@ static void __init build_zonelists(pg_da
 	int i, j, k, node, local_node;
 
 	local_node = pgdat->node_id;
-	for (i = 0; i < MAX_NR_ZONES; i++) {
+	for (i = 0; i < GFP_ZONEMODS; i++) {
 		struct zonelist *zonelist;
 
 		zonelist = pgdat->node_zonelists + i;
@@ -1887,7 +1887,7 @@ static void setup_per_zone_protection(vo
 		 * For each of the different allocation types:
 		 * GFP_DMA -> GFP_KERNEL -> GFP_HIGHMEM
 		 */
-		for (i = 0; i < MAX_NR_ZONES; i++) {
+		for (i = 0; i < GFP_ZONEMODS; i++) {
 			/*
 			 * For each of the zones:
 			 * ZONE_HIGHMEM -> ZONE_NORMAL -> ZONE_DMA
