Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263787AbTEODbd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 23:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263810AbTEODWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 23:22:48 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:29164 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263773AbTEODSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 23:18:31 -0400
Date: Thu, 15 May 2003 04:31:16 +0100
Message-Id: <200305150331.h4F3VGPN000754@deviant.impure.org.uk>
To: torvalds@transmeta.com, akpm@digeo.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: shrink zonelists.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Originally from Matt Dobson. I've been running with this for a while
in -dj, with no noticable side-effects.

Matt:

node_zonelists looks like it should really be declared of size 
MAX_NR_ZONES, not GFP_ZONEMASK.  GFP_ZONEMASK is currently 15, making 
node_zonelists an array of 16 elements.  The extra zonelists are all 
just duplicates of the *real* zonelists, namely the first 3 entries. 
Again, if anyone can explain to me why I'm wrong in my thinking, I'd 
love to know.  There's certainly no way you could bitwise-and something 
with any combination of the GFP_DMA and GFP_HIGHMEM flags to refer to 
the 12th zonelist or some such!  Or am I crazy?

Cheers!

-Matt

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/include/linux/mmzone.h linux-2.5/include/linux/mmzone.h
--- bk-linus/include/linux/mmzone.h	2003-04-10 06:01:37.000000000 +0100
+++ linux-2.5/include/linux/mmzone.h	2003-04-22 17:33:54.000000000 +0100
@@ -146,6 +146,7 @@ struct zone {
 #define ZONE_NORMAL		1
 #define ZONE_HIGHMEM		2
 #define MAX_NR_ZONES		3
+#define GFP_ZONEMASK	0x03
 
 /*
  * One allocation request operates on a zonelist. A zonelist
@@ -162,7 +163,6 @@ struct zonelist {
 	struct zone *zones[MAX_NUMNODES * MAX_NR_ZONES + 1]; // NULL delimited
 };
 
-#define GFP_ZONEMASK	0x0f
 
 /*
  * The pg_data_t structure is used in machines with CONFIG_DISCONTIGMEM
@@ -178,7 +178,7 @@ struct zonelist {
 struct bootmem_data;
 typedef struct pglist_data {
 	struct zone node_zones[MAX_NR_ZONES];
-	struct zonelist node_zonelists[GFP_ZONEMASK+1];
+	struct zonelist node_zonelists[MAX_NR_ZONES];
 	int nr_zones;
 	struct page *node_mem_map;
 	unsigned long *valid_addr_bitmap;
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/mm/page_alloc.c linux-2.5/mm/page_alloc.c
--- bk-linus/mm/page_alloc.c	2003-05-13 11:51:13.000000000 +0100
+++ linux-2.5/mm/page_alloc.c	2003-05-13 11:59:33.000000000 +0100
@@ -1041,7 +1041,7 @@ static void __init build_zonelists(pg_da
 
 	local_node = pgdat->node_id;
 	printk("Building zonelist for node : %d\n", local_node);
-	for (i = 0; i <= GFP_ZONEMASK; i++) {
+	for (i = 0; i < MAX_NR_ZONES; i++) {
 		struct zonelist *zonelist;
 
 		zonelist = pgdat->node_zonelists + i;
