Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266790AbUFYQdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266790AbUFYQdI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 12:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266791AbUFYQdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 12:33:07 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:11678
	"EHLO voidhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S266790AbUFYQc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 12:32:58 -0400
Date: Fri, 25 Jun 2004 17:32:28 +0100
From: Andy Whitcroft <apw@shadowen.org>
Message-Id: <200406251632.i5PGWSBI030792@voidhawk.shadowen.org>
To: akpm@osdl.org, apw@shadowen.org
Subject: Re: [PATCH] fix GFP zone modifier interators
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040624152333.79b36a90.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't get it.  If you were going to add a new zone, identified by
> __GFP_WHATEVER then you'd need to increase MAX_NR_ZONES
> anyway, wouldn't you?
> 
> I'm sure you're right, but I haven't worked on this stuff in months and
> it's obscure.  Care to explain a little more?
> 
> > This patch introduces GFP_ZONEMODS (based on GFP_ZONEMASK) as a
> > bound for the number of modifier combinations.
> 
> The "ZONEMODS" identifier doesn't really grab me.  ZONETYPES, or something?
> 
> Either way, please add a big fat comment over it, explaining to the poor
> reader what its semantic meaning is.

Ok, based on your comments I have changed the name of the define
to GFP_ZONETYPES.  I have also added extensive comments to the two
defines to explain their meaning.  I have also handled the case
where the bits are independant and exclusive which allows us to
minimise the number of zonelists.

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

This patch introduces GFP_ZONETYPES (based on GFP_ZONEMASK) as a
bound for the number of modifier combinations.

Revision: $Rev: 301 $

Signed-off-by: Andy Whitcroft <apw@shadowen.org>

---

diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/include/linux/mmzone.h current/include/linux/mmzone.h
--- reference/include/linux/mmzone.h	2004-06-22 22:57:27.000000000 +0100
+++ current/include/linux/mmzone.h	2004-06-25 17:06:17.000000000 +0100
@@ -69,7 +69,34 @@ struct per_cpu_pageset {
 #define MAX_NR_ZONES		3	/* Sync this with ZONES_SHIFT */
 #define ZONES_SHIFT		2	/* ceil(log2(MAX_NR_ZONES)) */
 
+
+/*
+ * When a memory allocation must confirm to specific limitations (such
+ * as being suitable for DMA) the caller will pass in hints to the
+ * allocator in the gfp_mask, in the zone modifier bits.  These bits
+ * are used to select an priority ordered list of memory zones which
+ * match the requested limits.  GFP_ZONEMASK defines which bits within
+ * the gfp_mask should be considered as zone modifiers.  Each valid
+ * combination of the zone modifier bits has a corresponding list
+ * of zones (in node_zonelists).  Thus for two zone modifiers there
+ * will be a maximum of 4 (2 ** 2) zonelists, for 3 modifiers there will
+ * be 8 (2 ** 3) zonelists.  GFP_ZONETYPES defines the number of possible
+ * combinations of zone modifiers in "zone modifier space".
+ */
 #define GFP_ZONEMASK	0x03
+/*
+ * As an optimisation any zone modifier bits which are only valid when
+ * no other zone modifier bits are set (loners) should be placed in
+ * the highest order bits of this field.  This allows us to reduce the
+ * extent of the zonelists thus saving space.  For example in the case
+ * of three zone modifier bits, we could require up to eight zonelists.
+ * If the left most zone modifier is a "loner" then the highest valid
+ * zonelist would be four allowing us to allocate only five zonelists.
+ * Use the first form when the left most bit is not a "loner", otherwise
+ * use the second.
+ */
+/* #define GFP_ZONETYPES	(GFP_ZONEMASK + 1) */		/* Non-loner */
+#define GFP_ZONETYPES	((GFP_ZONEMASK + 1) / 2 + 1)		/* Loner */
 
 /*
  * On machines where it is needed (eg PCs) we divide physical memory
@@ -226,7 +253,7 @@ struct zonelist {
 struct bootmem_data;
 typedef struct pglist_data {
 	struct zone node_zones[MAX_NR_ZONES];
-	struct zonelist node_zonelists[MAX_NR_ZONES];
+	struct zonelist node_zonelists[GFP_ZONETYPES];
 	int nr_zones;
 	struct page *node_mem_map;
 	struct bootmem_data *bdata;
diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/mm/page_alloc.c current/mm/page_alloc.c
--- reference/mm/page_alloc.c	2004-06-22 22:57:27.000000000 +0100
+++ current/mm/page_alloc.c	2004-06-25 16:02:06.000000000 +0100
@@ -1266,7 +1266,7 @@ static void __init build_zonelists(pg_da
 	DECLARE_BITMAP(used_mask, MAX_NUMNODES);
 
 	/* initialize zonelists */
-	for (i = 0; i < MAX_NR_ZONES; i++) {
+	for (i = 0; i < GFP_ZONETYPES; i++) {
 		zonelist = pgdat->node_zonelists + i;
 		memset(zonelist, 0, sizeof(*zonelist));
 		zonelist->zones[0] = NULL;
@@ -1288,7 +1288,7 @@ static void __init build_zonelists(pg_da
 			node_load[node] += load;
 		prev_node = node;
 		load--;
-		for (i = 0; i < MAX_NR_ZONES; i++) {
+		for (i = 0; i < GFP_ZONETYPES; i++) {
 			zonelist = pgdat->node_zonelists + i;
 			for (j = 0; zonelist->zones[j] != NULL; j++);
 
@@ -1311,7 +1311,7 @@ static void __init build_zonelists(pg_da
 	int i, j, k, node, local_node;
 
 	local_node = pgdat->node_id;
-	for (i = 0; i < MAX_NR_ZONES; i++) {
+	for (i = 0; i < GFP_ZONETYPES; i++) {
 		struct zonelist *zonelist;
 
 		zonelist = pgdat->node_zonelists + i;
@@ -1887,7 +1887,7 @@ static void setup_per_zone_protection(vo
 		 * For each of the different allocation types:
 		 * GFP_DMA -> GFP_KERNEL -> GFP_HIGHMEM
 		 */
-		for (i = 0; i < MAX_NR_ZONES; i++) {
+		for (i = 0; i < GFP_ZONETYPES; i++) {
 			/*
 			 * For each of the zones:
 			 * ZONE_HIGHMEM -> ZONE_NORMAL -> ZONE_DMA
