Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbWESNnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbWESNnG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 09:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbWESNnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 09:43:06 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:64999 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932317AbWESNnE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 09:43:04 -0400
From: Mel Gorman <mel@csn.ul.ie>
To: akpm@osdl.org
Cc: Mel Gorman <mel@csn.ul.ie>, nickpiggin@yahoo.com.au, haveblue@us.ibm.com,
       ak@suse.de, bob.picco@hp.com, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, apw@shadowen.org, mingo@elte.hu, mbligh@mbligh.org
Message-Id: <20060519134301.29021.71137.sendpatchset@skynet>
In-Reply-To: <20060519134241.29021.84756.sendpatchset@skynet>
References: <20060519134241.29021.84756.sendpatchset@skynet>
Subject: [PATCH 1/2] Align the node_mem_map endpoints to a MAX_ORDER boundary
Date: Fri, 19 May 2006 14:43:01 +0100 (IST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Bob Picco <bob.picco@hp.com>

Andy added code to buddy allocator which does not require the zone's
endpoints to be aligned to MAX_ORDER. An issue is that the buddy
allocator requires the node_mem_map's endpoints to be MAX_ORDER aligned.
Otherwise __page_find_buddy could compute a buddy not in node_mem_map for
partial MAX_ORDER regions at zone's endpoints. page_is_buddy will detect
that these pages at endpoints are not PG_buddy (they were zeroed out by
bootmem allocator and not part of zone). Of course the negative here is
we could waste a little memory but the positive is eliminating all the
old checks for zone boundary conditions.

SPARSEMEM won't encounter this issue because of MAX_ORDER size constraint
when SPARSEMEM is configured. ia64 VIRTUAL_MEM_MAP doesn't need the
logic either because the holes and endpoints are handled differently.
This leaves checking alloc_remap and other arches which privately allocate
for node_mem_map.


 include/linux/mmzone.h |    1 +
 mm/page_alloc.c        |   14 +++++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

Signed-off-by: Bob Picco <bob.picco@hp.com>
Acked-by: Mel Gorman <mel@csn.ul.ie>

diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc4-mm1-clean/include/linux/mmzone.h linux-2.6.17-rc4-mm1-101-bob-node-alignment/include/linux/mmzone.h
--- linux-2.6.17-rc4-mm1-clean/include/linux/mmzone.h	2006-05-18 17:23:55.000000000 +0100
+++ linux-2.6.17-rc4-mm1-101-bob-node-alignment/include/linux/mmzone.h	2006-05-18 17:52:13.000000000 +0100
@@ -21,6 +21,7 @@
 #else
 #define MAX_ORDER CONFIG_FORCE_MAX_ZONEORDER
 #endif
+#define MAX_ORDER_NR_PAGES (1 << (MAX_ORDER - 1))
 
 struct free_area {
 	struct list_head	free_list;
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc4-mm1-clean/mm/page_alloc.c linux-2.6.17-rc4-mm1-101-bob-node-alignment/mm/page_alloc.c
--- linux-2.6.17-rc4-mm1-clean/mm/page_alloc.c	2006-05-18 17:23:55.000000000 +0100
+++ linux-2.6.17-rc4-mm1-101-bob-node-alignment/mm/page_alloc.c	2006-05-18 17:58:10.000000000 +0100
@@ -2484,14 +2484,22 @@ static void __init alloc_node_mem_map(st
 #ifdef CONFIG_FLAT_NODE_MEM_MAP
 	/* ia64 gets its own node_mem_map, before this, without bootmem */
 	if (!pgdat->node_mem_map) {
-		unsigned long size;
+		unsigned long size, start, end;
 		struct page *map;
 
-		size = (pgdat->node_spanned_pages + 1) * sizeof(struct page);
+		/*
+		 * The zone's endpoints aren't required to be MAX_ORDER
+		 * aligned but the node_mem_map endpoints must be in order
+		 * for the buddy allocator to function correctly.
+		 */
+		start = pgdat->node_start_pfn & ~(MAX_ORDER_NR_PAGES - 1);
+		end = pgdat->node_start_pfn + pgdat->node_spanned_pages;
+		end = ALIGN(end, MAX_ORDER_NR_PAGES);
+		size =  (end - start) * sizeof(struct page);
 		map = alloc_remap(pgdat->node_id, size);
 		if (!map)
 			map = alloc_bootmem_node(pgdat, size);
-		pgdat->node_mem_map = map;
+		pgdat->node_mem_map = map + (pgdat->node_start_pfn - start);
 	}
 #ifdef CONFIG_FLATMEM
 	/*
