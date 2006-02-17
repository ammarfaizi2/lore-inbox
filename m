Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751424AbWBQOSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbWBQOSY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 09:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbWBQOSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 09:18:23 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:22238 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751424AbWBQOSW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 09:18:22 -0500
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Message-Id: <20060217141712.7621.49906.sendpatchset@skynet.csn.ul.ie>
In-Reply-To: <20060217141552.7621.74444.sendpatchset@skynet.csn.ul.ie>
References: <20060217141552.7621.74444.sendpatchset@skynet.csn.ul.ie>
Subject: [PATCH 4/7] ppc64 - Specify amount of kernel memory at boot time
Date: Fri, 17 Feb 2006 14:17:12 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds the kernelcore= parameter for ppc64.

The amount of memory will requested will not be reserved in all nodes. The
first node that is found that can accomodate the requested amount of memory
and have remaining more for ZONE_EASYRCLM is used. If a node has memory holes,
it also will not be used.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.16-rc3-mm1-103_x86coremem/arch/powerpc/mm/numa.c linux-2.6.16-rc3-mm1-104_ppc64coremem/arch/powerpc/mm/numa.c
--- linux-2.6.16-rc3-mm1-103_x86coremem/arch/powerpc/mm/numa.c	2006-02-16 09:50:42.000000000 +0000
+++ linux-2.6.16-rc3-mm1-104_ppc64coremem/arch/powerpc/mm/numa.c	2006-02-17 09:43:30.000000000 +0000
@@ -21,6 +21,7 @@
 #include <asm/lmb.h>
 #include <asm/system.h>
 #include <asm/smp.h>
+#include <asm/machdep.h>
 
 static int numa_enabled = 1;
 
@@ -722,20 +723,54 @@ void __init paging_init(void)
 	unsigned long zones_size[MAX_NR_ZONES];
 	unsigned long zholes_size[MAX_NR_ZONES];
 	int nid;
+	unsigned long core_mem_size = 0;
+	unsigned long core_mem_pfn = 0;
+	char *opt;
 
 	memset(zones_size, 0, sizeof(zones_size));
 	memset(zholes_size, 0, sizeof(zholes_size));
 
+	/* Check if ZONE_EASYRCLM should be populated */
+	opt = strstr(cmd_line, "kernelcore=");
+	if (opt) {
+		opt += 11;
+		core_mem_size = memparse(opt, &opt);
+		core_mem_pfn = core_mem_size >> PAGE_SHIFT;
+	}
+
 	for_each_online_node(nid) {
 		unsigned long start_pfn, end_pfn, pages_present;
 
 		get_region(nid, &start_pfn, &end_pfn, &pages_present);
 
-		zones_size[ZONE_DMA] = end_pfn - start_pfn;
-		zholes_size[ZONE_DMA] = zones_size[ZONE_DMA] - pages_present;
+		/*
+		 * Set up a zone for EASYRCLM as long as this node is large
+		 * enough to accomodate the requested size and that there
+		 * are no memory holes
+		 */
+		if (core_mem_pfn == 0 ||
+				end_pfn - start_pfn < core_mem_pfn ||
+				end_pfn - start_pfn != pages_present) {
+			zones_size[ZONE_DMA] = end_pfn - start_pfn;
+			zones_size[ZONE_EASYRCLM] = 0;
+			zholes_size[ZONE_DMA] =
+				zones_size[ZONE_DMA] - pages_present;
+			zholes_size[ZONE_EASYRCLM] = 0;
+			if (core_mem_pfn >= pages_present)
+				core_mem_pfn -= pages_present;
+		} else {
+			zones_size[ZONE_DMA] = core_mem_pfn;
+			zones_size[ZONE_EASYRCLM] = end_pfn - core_mem_pfn;
+			zholes_size[ZONE_DMA] = 0;
+			zholes_size[ZONE_EASYRCLM] = 0;
+			core_mem_pfn = 0;
+		}
 
-		dbg("free_area_init node %d %lx %lx (hole: %lx)\n", nid,
+		dbg("free_area_init DMA node %d %lx %lx (hole: %lx)\n", nid,
 		    zones_size[ZONE_DMA], start_pfn, zholes_size[ZONE_DMA]);
+		dbg("free_area_init EASYRCLM node %d %lx %lx (hole: %lx)\n",
+		    nid, zones_size[ZONE_EASYRCLM], zones_size[ZONE_DMA],
+		    zholes_size[ZONE_EASYRCLM]);
 
 		free_area_init_node(nid, NODE_DATA(nid), zones_size, start_pfn,
 				    zholes_size);
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.16-rc3-mm1-103_x86coremem/mm/page_alloc.c linux-2.6.16-rc3-mm1-104_ppc64coremem/mm/page_alloc.c
--- linux-2.6.16-rc3-mm1-103_x86coremem/mm/page_alloc.c	2006-02-17 09:42:01.000000000 +0000
+++ linux-2.6.16-rc3-mm1-104_ppc64coremem/mm/page_alloc.c	2006-02-17 09:43:30.000000000 +0000
@@ -1592,7 +1592,11 @@ static int __init build_zonelists_node(p
 		zone = pgdat->node_zones + zone_type;
 		if (populated_zone(zone)) {
 #ifndef CONFIG_HIGHMEM
-			BUG_ON(zone_type > ZONE_NORMAL);
+			/*
+			 * On architectures with only ZONE_DMA, it is still
+			 * valid to have a ZONE_EASYRCLM
+			 */
+			BUG_ON(zone_type == ZONE_HIGHMEM);
 #endif
 			zonelist->zones[nr_zones++] = zone;
 			check_highest_zone(zone_type);
