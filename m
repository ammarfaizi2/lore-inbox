Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbWESNnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbWESNnY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 09:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbWESNnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 09:43:24 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:4584 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932312AbWESNnX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 09:43:23 -0400
From: Mel Gorman <mel@csn.ul.ie>
To: akpm@osdl.org
Cc: Mel Gorman <mel@csn.ul.ie>, nickpiggin@yahoo.com.au, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, bob.picco@hp.com, ak@suse.de,
       linux-mm@kvack.org, apw@shadowen.org, mingo@elte.hu, mbligh@mbligh.org
Message-Id: <20060519134321.29021.99360.sendpatchset@skynet>
In-Reply-To: <20060519134241.29021.84756.sendpatchset@skynet>
References: <20060519134241.29021.84756.sendpatchset@skynet>
Subject: [PATCH 2/2] FLATMEM relax requirement for memory to start at pfn 0
Date: Fri, 19 May 2006 14:43:21 +0100 (IST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Andy Whitcroft <apw@shadowen.org>

The FLATMEM memory model assumes that memory is in one contigious area
based at pfn 0.  If we initialise node 0 to start at any other offset we
will incorrectly map pfn's to the wrong struct page *.  The key to the
memory model is the contigious nature of the memory not the location of it.
Relax the requirement for the area to start at 0.


 page_alloc.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
Acked-by: Mel Gorman <mel@csn.ul.ie>

diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc4-mm1-101-bob-node-alignment/mm/page_alloc.c linux-2.6.17-rc4-mm1-102-FLATMEM-relax-requirement-for-memory-to-start-at-pfn-0/mm/page_alloc.c
--- linux-2.6.17-rc4-mm1-101-bob-node-alignment/mm/page_alloc.c	2006-05-18 17:58:10.000000000 +0100
+++ linux-2.6.17-rc4-mm1-102-FLATMEM-relax-requirement-for-memory-to-start-at-pfn-0/mm/page_alloc.c	2006-05-18 19:14:44.000000000 +0100
@@ -2477,15 +2477,16 @@ static void __meminit free_area_init_cor
 
 static void __init alloc_node_mem_map(struct pglist_data *pgdat)
 {
+#ifdef CONFIG_FLAT_NODE_MEM_MAP
+	struct page *map = pgdat->node_mem_map;
+
 	/* Skip empty nodes */
 	if (!pgdat->node_spanned_pages)
 		return;
 
-#ifdef CONFIG_FLAT_NODE_MEM_MAP
 	/* ia64 gets its own node_mem_map, before this, without bootmem */
-	if (!pgdat->node_mem_map) {
+	if (!map) {
 		unsigned long size, start, end;
-		struct page *map;
 
 		/*
 		 * The zone's endpoints aren't required to be MAX_ORDER
@@ -2500,13 +2501,21 @@ static void __init alloc_node_mem_map(st
 		if (!map)
 			map = alloc_bootmem_node(pgdat, size);
 		pgdat->node_mem_map = map + (pgdat->node_start_pfn - start);
+
+		/*
+		 * With FLATMEM the global mem_map is used.  This is assumed
+		 * to be based at pfn 0 such that 'pfn = page* - mem_map'
+		 * is true. Adjust map relative to node_mem_map to
+		 * maintain this relationship.
+		 */
+		map -= pgdat->node_start_pfn;
 	}
 #ifdef CONFIG_FLATMEM
 	/*
 	 * With no DISCONTIG, the global mem_map is just set as node 0's
 	 */
 	if (pgdat == NODE_DATA(0))
-		mem_map = NODE_DATA(0)->node_mem_map;
+		mem_map = map;
 #endif
 #endif /* CONFIG_FLAT_NODE_MEM_MAP */
 }
