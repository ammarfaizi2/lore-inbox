Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266100AbSKLCW1>; Mon, 11 Nov 2002 21:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266112AbSKLCQM>; Mon, 11 Nov 2002 21:16:12 -0500
Received: from holomorphy.com ([66.224.33.161]:45752 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266122AbSKLCQB>;
	Mon, 11 Nov 2002 21:16:01 -0500
To: linux-kernel@vger.kernel.org
Subject: [7/9] NUMA-Q: allocate pgdats from node-local memory
Message-Id: <E18BQf6-00041K-00@holomorphy>
From: William Lee Irwin III <wli@holomorphy.com>
Date: Mon, 11 Nov 2002 18:20:20 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This changes allocate_pgdat() to hand back virtual addresses of pgdats
from the start of node_remap_start_vaddr[nid].

 discontig.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)


diff -urpN 05_memmap_after/arch/i386/mm/discontig.c 06_alloc_virtual/arch/i386/mm/discontig.c
--- 05_memmap_after/arch/i386/mm/discontig.c	2002-11-11 16:37:14.000000000 -0800
+++ 06_alloc_virtual/arch/i386/mm/discontig.c	2002-11-11 16:43:30.000000000 -0800
@@ -73,13 +73,13 @@ static void __init find_max_pfn_node(int
  */
 static void __init allocate_pgdat(int nid)
 {
-	unsigned long node_datasz;
-
-	node_datasz = PFN_UP(sizeof(struct pglist_data));
-	NODE_DATA(nid) = (pg_data_t *)(__va(min_low_pfn << PAGE_SHIFT));
-	min_low_pfn += node_datasz;
-	if (!nid)
+	if (nid)
+		NODE_DATA(nid) = (pg_data_t *)node_remap_start_vaddr[nid];
+	else {
+		NODE_DATA(nid) = (pg_data_t *)(__va(min_low_pfn << PAGE_SHIFT));
+		min_low_pfn += PFN_UP(sizeof(pg_data_t));
 		memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
+	}
 }
 
 /*
