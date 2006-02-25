Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932637AbWBYGGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932637AbWBYGGF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 01:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932692AbWBYGGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 01:06:05 -0500
Received: from fgwmail.fujitsu.co.jp ([164.71.1.133]:60855 "EHLO
	fgwmail.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932637AbWBYGGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 01:06:04 -0500
Date: Sat, 25 Feb 2006 15:05:28 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] for_each_online_pgdat (take2)  [1/5]  define
 for_each_online_pgdat
Message-Id: <20060225150528.98386921.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces for_each_pgdat with for_each_online_pgdat()
and makes use of node_online_map instead of pgdat_link.

Changelog v1 -> v2
 - fixes bug in code for ia64 initialization.
 - restructured patch dependency.
 - introduce for_each_online_pgdat().

This patch is against 2.6.16-rc4-mm2. 
tested on i386/ia64(smp)/ia64(NUMA config..but not on NUMA hardware.)

-- Kame

This patch defines for_each_online_pgdat() as a replacement of for_each_pgdat()

Now, online nodes are managed by node_online_map. But for_each_pgdat() uses
pgdat_link to iterate over all nodes(pgdat). This means management structure
for online pgdat is duplicated.

I think using node_online_map for for_each_pgdat() is simple and sane rather
ather than pgdat_link. New macro is named as for_each_online_pgdat().
Following patch will fix callers of for_each_pgdat().

The bootmem allocater uses for_each_pgdat() before pgdat initialization.
I don't think it's sane.Following patch will fix it.

Signed-Off-By: Yasunori Goto     <y-goto@jp.fujitsu.com>
Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>


Index: linux-2.6.16-rc4-mm2/include/linux/mmzone.h
===================================================================
--- linux-2.6.16-rc4-mm2.orig/include/linux/mmzone.h
+++ linux-2.6.16-rc4-mm2/include/linux/mmzone.h
@@ -13,6 +13,7 @@
 #include <linux/numa.h>
 #include <linux/init.h>
 #include <linux/seqlock.h>
+#include <linux/nodemask.h>
 #include <asm/atomic.h>
 
 /* Free memory management - zoned buddy allocator.  */
@@ -349,57 +350,6 @@ unsigned long __init node_memmap_size_by
  */
 #define zone_idx(zone)		((zone) - (zone)->zone_pgdat->node_zones)
 
-/**
- * for_each_pgdat - helper macro to iterate over all nodes
- * @pgdat - pointer to a pg_data_t variable
- *
- * Meant to help with common loops of the form
- * pgdat = pgdat_list;
- * while(pgdat) {
- * 	...
- * 	pgdat = pgdat->pgdat_next;
- * }
- */
-#define for_each_pgdat(pgdat) \
-	for (pgdat = pgdat_list; pgdat; pgdat = pgdat->pgdat_next)
-
-/*
- * next_zone - helper magic for for_each_zone()
- * Thanks to William Lee Irwin III for this piece of ingenuity.
- */
-static inline struct zone *next_zone(struct zone *zone)
-{
-	pg_data_t *pgdat = zone->zone_pgdat;
-
-	if (zone < pgdat->node_zones + MAX_NR_ZONES - 1)
-		zone++;
-	else if (pgdat->pgdat_next) {
-		pgdat = pgdat->pgdat_next;
-		zone = pgdat->node_zones;
-	} else
-		zone = NULL;
-
-	return zone;
-}
-
-/**
- * for_each_zone - helper macro to iterate over all memory zones
- * @zone - pointer to struct zone variable
- *
- * The user only needs to declare the zone variable, for_each_zone
- * fills it in. This basically means for_each_zone() is an
- * easier to read version of this piece of code:
- *
- * for (pgdat = pgdat_list; pgdat; pgdat = pgdat->node_next)
- * 	for (i = 0; i < MAX_NR_ZONES; ++i) {
- * 		struct zone * z = pgdat->node_zones + i;
- * 		...
- * 	}
- * }
- */
-#define for_each_zone(zone) \
-	for (zone = pgdat_list->node_zones; zone; zone = next_zone(zone))
-
 static inline int populated_zone(struct zone *zone)
 {
 	return (!!zone->present_pages);
@@ -471,6 +421,62 @@ extern struct pglist_data contig_page_da
 
 #endif /* !CONFIG_NEED_MULTIPLE_NODES */
 
+static inline struct pglist_data *first_online_pgdat(void)
+{
+	return NODE_DATA(first_online_node);
+}
+
+static inline struct pglist_data *next_online_pgdat(struct pglist_data *pgdat)
+{
+	int nid = next_online_node(pgdat->node_id);
+
+	if (nid == MAX_NUMNODES)
+		return NULL;
+	return NODE_DATA(nid);
+}
+
+
+/**
+ * for_each_pgdat - helper macro to iterate over all nodes
+ * @pgdat - pointer to a pg_data_t variable
+ */
+#define for_each_online_pgdat(pgdat)			\
+	for (pgdat = first_online_pgdat();		\
+	     pgdat;					\
+	     pgdat = next_online_pgdat(pgdat))
+
+/*
+ * next_zone - helper magic for for_each_zone()
+ * Thanks to William Lee Irwin III for this piece of ingenuity.
+ */
+static inline struct zone *next_zone(struct zone *zone)
+{
+	pg_data_t *pgdat = zone->zone_pgdat;
+
+	if (zone < pgdat->node_zones + MAX_NR_ZONES - 1)
+		zone++;
+	else {
+		pgdat = next_online_pgdat(pgdat);
+		if (pgdat)
+			zone = pgdat->node_zones;
+		else
+			zone = NULL;
+	}
+	return zone;
+}
+
+/**
+ * for_each_zone - helper macro to iterate over all memory zones
+ * @zone - pointer to struct zone variable
+ *
+ * The user only needs to declare the zone variable, for_each_zone
+ * fills it in.
+ */
+#define for_each_zone(zone)			        \
+	for (zone = (first_online_pgdat())->node_zones; \
+	     zone;					\
+	     zone = next_zone(zone))
+
 #ifdef CONFIG_SPARSEMEM
 #include <asm/sparsemem.h>
 #endif
Index: linux-2.6.16-rc4-mm2/include/linux/nodemask.h
===================================================================
--- linux-2.6.16-rc4-mm2.orig/include/linux/nodemask.h
+++ linux-2.6.16-rc4-mm2/include/linux/nodemask.h
@@ -350,11 +350,15 @@ extern nodemask_t node_possible_map;
 #define num_possible_nodes()	nodes_weight(node_possible_map)
 #define node_online(node)	node_isset((node), node_online_map)
 #define node_possible(node)	node_isset((node), node_possible_map)
+#define first_online_node	first_node(node_online_map)
+#define next_online_node(nid)	next_node((nid), node_online_map)
 #else
 #define num_online_nodes()	1
 #define num_possible_nodes()	1
 #define node_online(node)	((node) == 0)
 #define node_possible(node)	((node) == 0)
+#define first_online_node	0
+#define next_online_node(nid)	(MAX_NUMNODES)
 #endif
 
 #define any_online_node(mask)			\
