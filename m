Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751269AbWBVLJB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbWBVLJB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 06:09:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbWBVLJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 06:09:01 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:13789 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751187AbWBVLJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 06:09:00 -0500
Date: Wed, 22 Feb 2006 20:08:44 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Yasunori Goto <y-goto@jp.fujitsu.com>
Subject: [PATCH] refine for_each_pgdat() [3/4] remove pgdat sorting
Message-Id: <20060222200844.7850451d.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Because pgdat_list was linked to pgdat_list in *reverse* order,
(by default) some of arch has to sort it by themselves.

Because for_each_pgdat uses node_online_map now, it traverses all pgdat
in order. The bootmem allocater is sorted. So, we can get rid of
arch-specific sorting codes.


Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>


Index: linux-2.6.16-rc4/arch/m32r/mm/discontig.c
===================================================================
--- linux-2.6.16-rc4.orig/arch/m32r/mm/discontig.c
+++ linux-2.6.16-rc4/arch/m32r/mm/discontig.c
@@ -137,12 +137,6 @@ unsigned long __init zone_sizes_init(voi
 	int nid, i;
 	mem_prof_t *mp;
 
-	pgdat_list = NULL;
-	for (nid = num_online_nodes() - 1 ; nid >= 0 ; nid--) {
-		NODE_DATA(nid)->pgdat_next = pgdat_list;
-		pgdat_list = NODE_DATA(nid);
-	}
-
 	for_each_online_node(nid) {
 		mp = &mem_prof[nid];
 		for (i = 0 ; i < MAX_NR_ZONES ; i++) {
Index: linux-2.6.16-rc4/arch/ia64/mm/discontig.c
===================================================================
--- linux-2.6.16-rc4.orig/arch/ia64/mm/discontig.c
+++ linux-2.6.16-rc4/arch/ia64/mm/discontig.c
@@ -379,31 +379,6 @@ static void __init *memory_less_node_all
 }
 
 /**
- * pgdat_insert - insert the pgdat into global pgdat_list
- * @pgdat: the pgdat for a node.
- */
-static void __init pgdat_insert(pg_data_t *pgdat)
-{
-	pg_data_t *prev = NULL, *next;
-
-	for_each_pgdat(next)
-		if (pgdat->node_id < next->node_id)
-			break;
-		else
-			prev = next;
-
-	if (prev) {
-		prev->pgdat_next = pgdat;
-		pgdat->pgdat_next = next;
-	} else {
-		pgdat->pgdat_next = pgdat_list;
-		pgdat_list = pgdat;
-	}
-
-	return;
-}
-
-/**
  * memory_less_nodes - allocate and initialize CPU only nodes pernode
  *	information.
  */
Index: linux-2.6.16-rc4/arch/i386/mm/discontig.c
===================================================================
--- linux-2.6.16-rc4.orig/arch/i386/mm/discontig.c
+++ linux-2.6.16-rc4/arch/i386/mm/discontig.c
@@ -352,17 +352,6 @@ void __init zone_sizes_init(void)
 {
 	int nid;
 
-	/*
-	 * Insert nodes into pgdat_list backward so they appear in order.
-	 * Clobber node 0's links and NULL out pgdat_list before starting.
-	 */
-	pgdat_list = NULL;
-	for (nid = MAX_NUMNODES - 1; nid >= 0; nid--) {
-		if (!node_online(nid))
-			continue;
-		NODE_DATA(nid)->pgdat_next = pgdat_list;
-		pgdat_list = NODE_DATA(nid);
-	}
 
 	for_each_online_node(nid) {
 		unsigned long zones_size[MAX_NR_ZONES] = {0, 0, 0};

