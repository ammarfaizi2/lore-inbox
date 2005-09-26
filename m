Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932492AbVIZUGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbVIZUGX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 16:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbVIZUGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 16:06:23 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:41121 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932492AbVIZUGW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 16:06:22 -0400
Message-ID: <433854B7.3080705@austin.ibm.com>
Date: Mon, 26 Sep 2005 15:06:15 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050909 Fedora/1.7.10-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Joel Schopp <jschopp@austin.ibm.com>,
       lhms <lhms-devel@lists.sourceforge.net>,
       Linux Memory Management List <linux-mm@kvack.org>,
       linux-kernel@vger.kernel.org, Mel Gorman <mel@csn.ul.ie>,
       Mike Kravetz <kravetz@us.ibm.com>
Subject: [PATCH 3/9] initialize defrag
References: <4338537E.8070603@austin.ibm.com>
In-Reply-To: <4338537E.8070603@austin.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------090503000807000709000402"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090503000807000709000402
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch allocates and initializes the newly added structures. Nothing
exciting.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>


--------------090503000807000709000402
Content-Type: text/plain;
 name="3_initialize_defrag"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="3_initialize_defrag"

Index: 2.6.13-joel2/mm/sparse.c
===================================================================
--- 2.6.13-joel2.orig/mm/sparse.c	2005-09-19 16:28:09.%N -0500
+++ 2.6.13-joel2/mm/sparse.c	2005-09-19 16:47:01.%N -0500
@@ -100,6 +100,22 @@ static struct page *sparse_early_mem_map
 	return NULL;
 }
 
+static int sparse_early_alloc_init_section(unsigned long pnum)
+{
+	struct page *map;
+	struct mem_section *ms = __nr_to_section(pnum);
+
+	map = sparse_early_mem_map_alloc(pnum);
+	if (!map)
+		return 1;
+
+	sparse_init_one_section(ms, pnum, map);
+
+	set_bit(RCLM_NORCLM, ms->free_area_usemap);
+
+	return 0;
+}
+
 /*
  * Allocate the accumulated non-linear sections, allocate a mem_map
  * for each and record the physical to section mapping.
@@ -107,16 +123,19 @@ static struct page *sparse_early_mem_map
 void sparse_init(void)
 {
 	unsigned long pnum;
-	struct page *map;
+	int rc;
 
 	for (pnum = 0; pnum < NR_MEM_SECTIONS; pnum++) {
 		if (!valid_section_nr(pnum))
-			continue;
+			continue;
+		rc = sparse_early_alloc_init_section(pnum);
+		if(rc) goto out_error;
 
-		map = sparse_early_mem_map_alloc(pnum);
-		if (map)
-			sparse_init_one_section(&mem_section[pnum], pnum, map);
 	}
+	return;
+
+ out_error:
+	printk("initialization error in sparse_early_alloc_init_section()\n");
 }
 
 /*
Index: 2.6.13-joel2/mm/page_alloc.c
===================================================================
--- 2.6.13-joel2.orig/mm/page_alloc.c	2005-09-19 16:28:40.%N -0500
+++ 2.6.13-joel2/mm/page_alloc.c	2005-09-19 17:13:53.%N -0500
@@ -1669,9 +1669,16 @@ void zone_init_free_lists(struct pglist_
 				unsigned long size)
 {
 	int order;
-	for (order = 0; order < MAX_ORDER ; order++) {
-		INIT_LIST_HEAD(&zone->free_area[order].free_list);
-		zone->free_area[order].nr_free = 0;
+	int type;
+	struct free_area *area;
+
+	/* Initialse the three size ordered lists of free_areas */
+	for (type=0; type < RCLM_TYPES; type++) {
+		for (order = 0; order < MAX_ORDER; order++) {
+			area = zone->free_area_lists[type];
+			INIT_LIST_HEAD(&area[order].free_list);
+			area[order].nr_free = 0;
+		}
 	}
 }
 
@@ -1849,6 +1856,40 @@ void __init setup_per_cpu_pageset()
 }
 
 #endif
+#ifndef CONFIG_SPARSEMEM
+#define roundup(x, y) ((((x)+((y)-1))/(y))*(y))
+/*
+ * Calculate the size of the zone->usemap in bytes rounded to an unsigned long
+ * Start by making sure zonesize is a multiple of MAX_ORDER-1 by rounding up
+ * Then figure 1 RCLM_TYPE worth of bits per MAX_ORDER-1, finally round up
+ * what is now in bits to nearest long in bits, then return it in bytes.
+ */
+static unsigned long __init usemap_size(unsigned long zonesize)
+{
+	unsigned long usemapsize;
+
+	usemapsize = roundup(zonesize, MAX_ORDER-1);
+	usemapsize = usemapsize >> (MAX_ORDER-1);
+	usemapsize *= BITS_PER_RCLM_TYPE;
+	usemapsize = roundup(usemapsize, 8 * sizeof(unsigned long));
+
+	return usemapsize >> 8;
+}
+
+static void free_area_usemap_init(unsigned long size, struct pglist_data *pgdat,
+				  struct zone *zone)
+{
+	unsigned long usemapsize;
+
+	usemapsize = usemap_size(size);
+	zone->free_area_usemap = alloc_bootmem_node(pgdat, usemapsize);
+	memset(zone->free_area_usemap, RCLM_NORCLM, usemapsize);
+}
+
+#else
+static void free_area_usemap_init(unsigned long size, struct pglist_data *pgdat,
+				  struct zone *zone){}
+#endif /* CONFIG_SPARSEMEM */
 
 /*
  * Set up the zone data structures:
@@ -1938,6 +1979,8 @@ static void __init free_area_init_core(s
 
 		zone_start_pfn += size;
 
+		free_area_usemap_init(size, pgdat, zone);
+
 		zone_init_free_lists(pgdat, zone, zone->spanned_pages);
 	}
 }

--------------090503000807000709000402--
