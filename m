Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266875AbUFYWEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266875AbUFYWEO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 18:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266877AbUFYWEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 18:04:14 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:13726
	"EHLO voidhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S266875AbUFYWEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 18:04:05 -0400
Date: Fri, 25 Jun 2004 23:03:48 +0100
From: Andy Whitcroft <apw@shadowen.org>
Message-Id: <200406252203.i5PM3m6s031728@voidhawk.shadowen.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] convert uses of ZONE_HIGHMEM to is_highmem
Cc: akpm@osdl.org, apw@shadowen.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As the comments in mmzone.h indicate is_highmem() is designed to
reduce the proliferation of the constant ZONE_HIGHMEM.  This patch
updates three references to ZONE_HIGHMEM to use is_highmem().
None appear to be on critical paths.

Revision: $Rev: 305 $ 

Signed-off-by: Andy Whitcroft <apw@shadowen.org>

---
 arch/i386/mm/discontig.c |   17 +++++++++++------
 mm/page_alloc.c          |    9 +++++----
 2 files changed, 16 insertions(+), 10 deletions(-)

diff -upN reference/arch/i386/mm/discontig.c current/arch/i386/mm/discontig.c
--- reference/arch/i386/mm/discontig.c	2004-06-25 22:26:08.000000000 +0100
+++ current/arch/i386/mm/discontig.c	2004-06-25 22:26:50.000000000 +0100
@@ -411,17 +411,22 @@ void __init zone_sizes_init(void)
 void __init set_highmem_pages_init(int bad_ppro) 
 {
 #ifdef CONFIG_HIGHMEM
-	int nid;
+	struct zone *zone;
 
-	for (nid = 0; nid < numnodes; nid++) {
+	for_each_zone(zone) {
 		unsigned long node_pfn, node_high_size, zone_start_pfn;
 		struct page * zone_mem_map;
 		
-		node_high_size = NODE_DATA(nid)->node_zones[ZONE_HIGHMEM].spanned_pages;
-		zone_mem_map = NODE_DATA(nid)->node_zones[ZONE_HIGHMEM].zone_mem_map;
-		zone_start_pfn = NODE_DATA(nid)->node_zones[ZONE_HIGHMEM].zone_start_pfn;
+		if (!is_highmem(zone))
+			continue;
+
+		printk("Initializing %s for node %d\n", zone->name,
+			zone->zone_pgdat->node_id);
+
+		node_high_size = zone->spanned_pages;
+		zone_mem_map = zone->zone_mem_map;
+		zone_start_pfn = zone->zone_start_pfn;
 
-		printk("Initializing highpages for node %d\n", nid);
 		for (node_pfn = 0; node_pfn < node_high_size; node_pfn++) {
 			one_highpage_init((struct page *)(zone_mem_map + node_pfn),
 					  zone_start_pfn + node_pfn, bad_ppro);
diff -upN reference/mm/page_alloc.c current/mm/page_alloc.c
--- reference/mm/page_alloc.c	2004-06-25 22:26:08.000000000 +0100
+++ current/mm/page_alloc.c	2004-06-25 22:26:50.000000000 +0100
@@ -930,11 +930,12 @@ unsigned int nr_free_pagecache_pages(voi
 #ifdef CONFIG_HIGHMEM
 unsigned int nr_free_highpages (void)
 {
-	pg_data_t *pgdat;
+	struct zone *zone;
 	unsigned int pages = 0;
 
-	for_each_pgdat(pgdat)
-		pages += pgdat->node_zones[ZONE_HIGHMEM].free_pages;
+	for_each_zone(zone)
+		if (is_highmem(zone))
+			pages += zone->free_pages;
 
 	return pages;
 }
@@ -1422,7 +1423,7 @@ void __init memmap_init_zone(struct page
 		INIT_LIST_HEAD(&page->lru);
 #ifdef WANT_PAGE_VIRTUAL
 		/* The shift won't overflow because ZONE_NORMAL is below 4G. */
-		if (zone != ZONE_HIGHMEM)
+		if (!is_highmem(zone))
 			set_page_address(page, __va(start_pfn << PAGE_SHIFT));
 #endif
 		start_pfn++;
