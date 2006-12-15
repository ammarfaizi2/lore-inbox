Return-Path: <linux-kernel-owner+w=401wt.eu-S1752938AbWLORMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752938AbWLORMN (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 12:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752947AbWLORMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 12:12:13 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:36703 "EHLO
	calculon.skynet.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752938AbWLORMM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 12:12:12 -0500
X-Greylist: delayed 1424 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Dec 2006 12:12:11 EST
Date: Fri, 15 Dec 2006 16:48:25 +0000
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Avoid excessive sorting of early_node_map[]
Message-ID: <20061215164824.GA13580@skynet.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: mel@skynet.ie (Mel Gorman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

find_min_pfn_for_node() and find_min_pfn_with_active_regions() sort
early_node_map[] on every call. This is an excessive amount of sorting and
that can be avoided. This patch always searches the whole early_node_map[]
in find_min_pfn_for_node() instead of returning the first value found. The
map is then only sorted once when required. Successfully boot tested on a
number of machines.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-mm1-clean/mm/page_alloc.c linux-2.6.19-mm1-excessivesort/mm/page_alloc.c
--- linux-2.6.19-mm1-clean/mm/page_alloc.c	2006-11-29 21:57:37.000000000 +0000
+++ linux-2.6.19-mm1-excessivesort/mm/page_alloc.c	2006-12-14 15:59:40.000000000 +0000
@@ -2607,20 +2607,23 @@ static void __init sort_node_map(void)
 			cmp_node_active_region, NULL);
 }
 
-/* Find the lowest pfn for a node. This depends on a sorted early_node_map */
+/* Find the lowest pfn for a node */
 unsigned long __init find_min_pfn_for_node(unsigned long nid)
 {
 	int i;
-
-	/* Regions in the early_node_map can be in any order */
-	sort_node_map();
+	unsigned long min_pfn = -1UL;
 
 	/* Assuming a sorted map, the first range found has the starting pfn */
 	for_each_active_range_index_in_nid(i, nid)
-		return early_node_map[i].start_pfn;
+		min_pfn = min(min_pfn, early_node_map[i].start_pfn);
 
-	printk(KERN_WARNING "Could not find start_pfn for node %lu\n", nid);
-	return 0;
+	if (min_pfn == -1UL) {
+		printk(KERN_WARNING
+			"Could not find start_pfn for node %lu\n", nid);
+		return 0;
+	}
+
+	return min_pfn;
 }
 
 /**
@@ -2669,6 +2672,9 @@ void __init free_area_init_nodes(unsigne
 	unsigned long nid;
 	enum zone_type i;
 
+	/* Sort early_node_map as initialisation assumes it is sorted */
+	sort_node_map();
+
 	/* Record where the zone boundaries are */
 	memset(arch_zone_lowest_possible_pfn, 0,
 				sizeof(arch_zone_lowest_possible_pfn));
