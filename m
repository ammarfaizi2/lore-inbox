Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266101AbSKLCR1>; Mon, 11 Nov 2002 21:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266115AbSKLCQS>; Mon, 11 Nov 2002 21:16:18 -0500
Received: from holomorphy.com ([66.224.33.161]:44984 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266101AbSKLCQB>;
	Mon, 11 Nov 2002 21:16:01 -0500
To: linux-kernel@vger.kernel.org
Subject: [2/9] NUMA-Q: memset pgdats later in boot
Message-Id: <E18BQf6-00041A-00@holomorphy>
From: William Lee Irwin III <wli@holomorphy.com>
Date: Mon, 11 Nov 2002 18:20:20 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In order to remove the assumption that pgdats for nodes > 0 are mapped
early, this patch moves the process of memset()'ing a node's pgdat into
zone_sizes_init(), just before they're to be linked.

 discontig.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)


diff -urpN 00_late_list/arch/i386/mm/discontig.c 01_late_memset/arch/i386/mm/discontig.c
--- 00_late_list/arch/i386/mm/discontig.c	2002-11-11 16:13:57.000000000 -0800
+++ 01_late_memset/arch/i386/mm/discontig.c	2002-11-11 16:21:37.000000000 -0800
@@ -70,7 +70,8 @@ static void __init allocate_pgdat(int ni
 	node_datasz = PFN_UP(sizeof(struct pglist_data));
 	NODE_DATA(nid) = (pg_data_t *)(__va(min_low_pfn << PAGE_SHIFT));
 	min_low_pfn += node_datasz;
-	memset(NODE_DATA(nid), 0, sizeof(struct pglist_data));
+	if (!nid)
+		memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
 }
 
 /*
@@ -281,6 +282,8 @@ void __init zone_sizes_init(void)
 	 */
 	pgdat_list = NULL;
 	for (nid = numnodes - 1; nid >= 0; nid--) {       
+		if (nid)
+			memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
 		NODE_DATA(nid)->pgdat_next = pgdat_list;
 		pgdat_list = NODE_DATA(nid);
 	}
