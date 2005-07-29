Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262720AbVG2ScB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262720AbVG2ScB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 14:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262701AbVG2Sb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 14:31:59 -0400
Received: from dvhart.com ([64.146.134.43]:26042 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S262711AbVG2Sb5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 14:31:57 -0400
Date: Fri, 29 Jul 2005 11:31:50 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, colpatch@us.ibm.com
Subject: [PATCH] Fix NUMA node sizing in nr_free_zone_pages
Message-ID: <240970000.1122661910@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are iterating over all nodes in nr_free_zone_pages(). Because the 
fallback zonelists contain all nodes in the system, and we walk all
the zonelists, we're counting memory multiple times (once for each
node). This caused us to make a size estimate of 32GB for an 8GB
AMD64 box, which makes all the dirty ratio calculations, etc incorrect.

There's still a further bug to fix from e820 holes causing overestimation
as well, but this fix is separate, and good as is, and fixes one class
of problems. Problem found by Badari, and tested by Ram Pai - thanks!

Signed-off-by:  Martin J. Bligh <mbligh@mbligh.org> 
Signed-off-by:  Matt Dobson <colpatch@us.ibm.com>

diff -purN -X /home/mbligh/.diff.exclude linux-2.6.12/mm/page_alloc.c 2.6.12-nr_free_zone_pages/mm/page_alloc.c
--- linux-2.6.12/mm/page_alloc.c	2005-06-17 17:21:43.000000000 -0700
+++ 2.6.12-nr_free_zone_pages/mm/page_alloc.c	2005-07-28 16:54:03.000000000 -0700
@@ -1006,20 +1006,19 @@ unsigned int nr_free_pages_pgdat(pg_data
 
 static unsigned int nr_free_zone_pages(int offset)
 {
-	pg_data_t *pgdat;
+	/* Just pick one node, since fallback list is circular */
+	pg_data_t *pgdat = NODE_DATA(numa_node_id());
 	unsigned int sum = 0;
 
-	for_each_pgdat(pgdat) {
-		struct zonelist *zonelist = pgdat->node_zonelists + offset;
-		struct zone **zonep = zonelist->zones;
-		struct zone *zone;
+	struct zonelist *zonelist = pgdat->node_zonelists + offset;
+	struct zone **zonep = zonelist->zones;
+	struct zone *zone;
 
-		for (zone = *zonep++; zone; zone = *zonep++) {
-			unsigned long size = zone->present_pages;
-			unsigned long high = zone->pages_high;
-			if (size > high)
-				sum += size - high;
-		}
+	for (zone = *zonep++; zone; zone = *zonep++) {
+		unsigned long size = zone->present_pages;
+		unsigned long high = zone->pages_high;
+		if (size > high)
+			sum += size - high;
 	}
 
 	return sum;


