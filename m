Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316416AbSEZUuI>; Sun, 26 May 2002 16:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316404AbSEZUpC>; Sun, 26 May 2002 16:45:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56848 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316408AbSEZUo2>;
	Sun, 26 May 2002 16:44:28 -0400
Message-ID: <3CF149E9.A4796BAE@zip.com.au>
Date: Sun, 26 May 2002 13:47:37 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 16/18] factor common code in page_alloc.c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Factor out some similar code in page_alloc.c

=====================================

--- 2.5.18/mm/page_alloc.c~zone-pages-cleanup	Sun May 26 12:38:09 2002
+++ 2.5.18-akpm/mm/page_alloc.c	Sun May 26 12:38:09 2002
@@ -543,16 +543,13 @@ unsigned int nr_free_pages (void)
 	return sum;
 }
 
-/*
- * Amount of free RAM allocatable as buffer memory:
- */
-unsigned int nr_free_buffer_pages (void)
+static unsigned int nr_free_zone_pages(int offset)
 {
 	pg_data_t *pgdat = pgdat_list;
 	unsigned int sum = 0;
 
 	do {
-		zonelist_t *zonelist = pgdat->node_zonelists + (GFP_USER & GFP_ZONEMASK);
+		zonelist_t *zonelist = pgdat->node_zonelists + offset;
 		zone_t **zonep = zonelist->zones;
 		zone_t *zone;
 
@@ -570,30 +567,19 @@ unsigned int nr_free_buffer_pages (void)
 }
 
 /*
- * Amount of free RAM allocatable as pagecache memory:
+ * Amount of free RAM allocatable within ZONE_DMA and ZONE_NORMAL
  */
-unsigned int nr_free_pagecache_pages(void)
+unsigned int nr_free_buffer_pages(void)
 {
-	pg_data_t *pgdat = pgdat_list;
-	unsigned int sum = 0;
-
-	do {
-		zonelist_t *zonelist = pgdat->node_zonelists +
-				(GFP_HIGHUSER & GFP_ZONEMASK);
-		zone_t **zonep = zonelist->zones;
-		zone_t *zone;
-
-		for (zone = *zonep++; zone; zone = *zonep++) {
-			unsigned long size = zone->size;
-			unsigned long high = zone->pages_high;
-			if (size > high)
-				sum += size - high;
-		}
-
-		pgdat = pgdat->node_next;
-	} while (pgdat);
+	return nr_free_zone_pages(GFP_USER & GFP_ZONEMASK);
+}
 
-	return sum;
+/*
+ * Amount of free RAM allocatable within all zones
+ */
+unsigned int nr_free_pagecache_pages(void)
+{
+	return nr_free_zone_pages(GFP_HIGHUSER & GFP_ZONEMASK);
 }
 
 #if CONFIG_HIGHMEM


-
