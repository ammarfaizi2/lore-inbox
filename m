Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932402AbWBYGMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbWBYGMv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 01:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbWBYGMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 01:12:51 -0500
Received: from fgwmail2.fujitsu.co.jp ([164.71.1.135]:52170 "EHLO
	fgwmail2.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932402AbWBYGMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 01:12:50 -0500
Date: Sat, 25 Feb 2006 15:12:29 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] for_each_online_pgdat (take2)  [4/5]  remove sorting pgdat
Message-Id: <20060225151229.797ac2ca.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Because pgdat_list was linked to pgdat_list in *reverse* order,
(By default) some of arch has to sort it by themselves.

for_each_pgdat has gone..for_each_online_pgdat() uses node_online_map,
which doesn't need to be sorted.

This patch removes codes for sorting pgdat.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>


Index: linux-2.6.16-rc4-mm2/arch/m32r/mm/discontig.c
===================================================================
--- linux-2.6.16-rc4-mm2.orig/arch/m32r/mm/discontig.c	2006-02-25 13:02:37.000000000 +0900
+++ linux-2.6.16-rc4-mm2/arch/m32r/mm/discontig.c	2006-02-25 13:10:53.000000000 +0900
@@ -137,12 +137,6 @@
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
Index: linux-2.6.16-rc4-mm2/arch/ia64/mm/discontig.c
===================================================================
--- linux-2.6.16-rc4-mm2.orig/arch/ia64/mm/discontig.c	2006-02-25 13:10:52.000000000 +0900
+++ linux-2.6.16-rc4-mm2/arch/ia64/mm/discontig.c	2006-02-25 13:10:53.000000000 +0900
@@ -379,31 +379,6 @@
 }
 
 /**
- * pgdat_insert - insert the pgdat into global pgdat_list
- * @pgdat: the pgdat for a node.
- */
-static void __init pgdat_insert(pg_data_t *pgdat)
-{
-	pg_data_t *prev = NULL, *next;
-
-	for_each_online_pgdat(next)
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
@@ -745,11 +720,5 @@
 				    pfn_offset, zholes_size);
 	}
 
-	/*
-	 * Make memory less nodes become a member of the known nodes.
-	 */
-	for_each_node_mask(node, memory_less_mask)
-		pgdat_insert(mem_data[node].pgdat);
-
 	zero_page_memmap_ptr = virt_to_page(ia64_imva(empty_zero_page));
 }
Index: linux-2.6.16-rc4-mm2/arch/i386/mm/discontig.c
===================================================================
--- linux-2.6.16-rc4-mm2.orig/arch/i386/mm/discontig.c	2006-02-25 13:02:37.000000000 +0900
+++ linux-2.6.16-rc4-mm2/arch/i386/mm/discontig.c	2006-02-25 13:10:53.000000000 +0900
@@ -352,17 +352,6 @@
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
