Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbWGGXTD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbWGGXTD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 19:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbWGGXTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 19:19:01 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:57789 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932387AbWGGXS4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 19:18:56 -0400
Date: Fri, 7 Jul 2006 16:18:41 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Christoph Hellwig <hch@infradead.org>, Con Kolivas <kernel@kolivas.org>,
       Marcelo Tosatti <marcelo@kvack.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Andi Kleen <ak@suse.de>
Message-Id: <20060707231841.3790.88534.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060707231810.3790.19313.sendpatchset@schroedinger.engr.sgi.com>
References: <20060707231810.3790.19313.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 06/11] Page allocator ZONE_HIGHMEM cleanup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

page allocator ZONE_HIGHMEM fixups

1. We do not need to do an #ifdef in si_meminfo since both counters
   in use are zero if !CONFIG_HIGHMEM.

2. Add #ifdef in si_meminfo_node instead to avoid referencing zone
   information for ZONE_HIGHMEM if we do not have HIGHMEM
   (may not be there after the following patches).

3. Replace the use of ZONE_HIGHMEM with MAX_NR_ZONES in build_zonelists_node

4. build_zonelists_node: Remove BUG_ON for ZONE_HIGHMEM. Zone will
   be optional soon and thus BUG_ON cannot be triggered anymore.

5. init_free_area_core: Replace a use of ZONE_HIGHMEM with NR_MAX_ZONES.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-mm6/mm/page_alloc.c
===================================================================
--- linux-2.6.17-mm6.orig/mm/page_alloc.c	2006-07-05 20:49:58.340089640 -0700
+++ linux-2.6.17-mm6/mm/page_alloc.c	2006-07-07 15:07:41.676482357 -0700
@@ -1289,13 +1289,8 @@ void si_meminfo(struct sysinfo *val)
 	val->sharedram = 0;
 	val->freeram = nr_free_pages();
 	val->bufferram = nr_blockdev_pages();
-#ifdef CONFIG_HIGHMEM
 	val->totalhigh = totalhigh_pages;
 	val->freehigh = nr_free_highpages();
-#else
-	val->totalhigh = 0;
-	val->freehigh = 0;
-#endif
 	val->mem_unit = PAGE_SIZE;
 }
 
@@ -1308,8 +1303,13 @@ void si_meminfo_node(struct sysinfo *val
 
 	val->totalram = pgdat->node_present_pages;
 	val->freeram = nr_free_pages_pgdat(pgdat);
+#ifdef CONFIG_HIGHMEM
 	val->totalhigh = pgdat->node_zones[ZONE_HIGHMEM].present_pages;
 	val->freehigh = pgdat->node_zones[ZONE_HIGHMEM].free_pages;
+#else
+	val->totalhigh = 0;
+	val->freehigh = 0;
+#endif
 	val->mem_unit = PAGE_SIZE;
 }
 #endif
@@ -1442,14 +1442,11 @@ static int __meminit build_zonelists_nod
 {
 	struct zone *zone;
 
-	BUG_ON(zone_type > ZONE_HIGHMEM);
+	BUG_ON(zone_type >= MAX_NR_ZONES);
 
 	do {
 		zone = pgdat->node_zones + zone_type;
 		if (populated_zone(zone)) {
-#ifndef CONFIG_HIGHMEM
-			BUG_ON(zone_type > ZONE_NORMAL);
-#endif
 			zonelist->zones[nr_zones++] = zone;
 			check_highest_zone(zone_type);
 		}
@@ -2080,7 +2077,7 @@ static void __meminit free_area_init_cor
 		if (zholes_size)
 			realsize -= zholes_size[j];
 
-		if (j < ZONE_HIGHMEM)
+		if (!is_highmem_idx(j))
 			nr_kernel_pages += realsize;
 		nr_all_pages += realsize;
 
