Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266120AbSKLCR1>; Mon, 11 Nov 2002 21:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266114AbSKLCQO>; Mon, 11 Nov 2002 21:16:14 -0500
Received: from holomorphy.com ([66.224.33.161]:45496 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266121AbSKLCQB>;
	Mon, 11 Nov 2002 21:16:01 -0500
To: linux-kernel@vger.kernel.org
Subject: [1/9] NUMA-Q: initialize pgdat_list later in boot
Message-Id: <E18BQf6-000418-00@holomorphy>
From: William Lee Irwin III <wli@holomorphy.com>
Date: Mon, 11 Nov 2002 18:20:20 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In order to remove the assumption pgdat's off of node 0 are mapped
early, this patch moves the linking of the pgdats off node 0 into
the pgdat_list into zone_sizes_init().

There is also the cosmetic side-effect of ordering the nodes in a
manner consistent with usual notions of their enumeration.

 discontig.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)


diff -urpN numaq-2.5.47/arch/i386/mm/discontig.c 00_late_list/arch/i386/mm/discontig.c
--- numaq-2.5.47/arch/i386/mm/discontig.c	2002-11-10 19:28:17.000000000 -0800
+++ 00_late_list/arch/i386/mm/discontig.c	2002-11-11 16:13:57.000000000 -0800
@@ -251,13 +251,6 @@ unsigned long __init setup_memory(void)
 	 */
 	find_smp_config();
 
-	/*insert other nodes into pgdat_list*/
-	for (nid = 1; nid < numnodes; nid++){       
-		NODE_DATA(nid)->pgdat_next = pgdat_list;
-		pgdat_list = NODE_DATA(nid);
-	}
-       
-
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (LOADER_TYPE && INITRD_START) {
 		if (INITRD_START + INITRD_SIZE <= (system_max_low_pfn << PAGE_SHIFT)) {
@@ -282,6 +275,16 @@ void __init zone_sizes_init(void)
 {
 	int nid;
 
+	/*
+	 * Insert nodes into pgdat_list backward so they appear in order.
+	 * Clobber node 0's links and NULL out pgdat_list before starting.
+	 */
+	pgdat_list = NULL;
+	for (nid = numnodes - 1; nid >= 0; nid--) {       
+		NODE_DATA(nid)->pgdat_next = pgdat_list;
+		pgdat_list = NODE_DATA(nid);
+	}
+
 	for (nid = 0; nid < numnodes; nid++) {
 		unsigned long zones_size[MAX_NR_ZONES] = {0, 0, 0};
 		unsigned int max_dma;
