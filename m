Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318922AbSG1HaC>; Sun, 28 Jul 2002 03:30:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318921AbSG1HWs>; Sun, 28 Jul 2002 03:22:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56837 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318922AbSG1HVQ>;
	Sun, 28 Jul 2002 03:21:16 -0400
Message-ID: <3D439E2D.5BA9899F@zip.com.au>
Date: Sun, 28 Jul 2002 00:33:01 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 7/13] for_each_pgdat macro
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Patch from Robert Love.

This patch implements for_each_pgdat(pg_data_t *) which is a helper
macro to cleanup code that does a loop of the form:

        pgdat = pgdat_list;
        while(pgdat) {
	        /* ... */
	        pgdat = pgdat->node_next;
	}
	
and replace it with:
	
	for_each_pgdat(pgdat) {
		/* ... */
	}

This code is from Rik's 2.4-rmap patch and is by William Irwin.


 arch/ia64/mm/init.c    |    7 +++----
 include/linux/mmzone.h |   16 +++++++++++++++-
 mm/bootmem.c           |    7 +++----
 mm/numa.c              |    6 +++---
 mm/page_alloc.c        |   21 +++++++++------------
 mm/vmscan.c            |    4 ++--
 6 files changed, 35 insertions(+), 26 deletions(-)

--- 2.5.29/arch/ia64/mm/init.c~for_each_pgdat	Sat Jul 27 23:39:06 2002
+++ 2.5.29-akpm/arch/ia64/mm/init.c	Sat Jul 27 23:39:06 2002
@@ -167,10 +167,10 @@ show_mem(void)
 
 #ifdef CONFIG_DISCONTIGMEM
 	{
-		pg_data_t *pgdat = pgdat_list;
+		pg_data_t *pgdat;
 
 		printk("Free swap:       %6dkB\n", nr_swap_pages<<(PAGE_SHIFT-10));
-		do {
+		for_each_pgdat(pgdat) {
 			printk("Node ID: %d\n", pgdat->node_id);
 			for(i = 0; i < pgdat->node_size; i++) {
 				if (PageReserved(pgdat->node_mem_map+i))
@@ -184,8 +184,7 @@ show_mem(void)
 			printk("\t%d reserved pages\n", reserved);
 			printk("\t%d pages shared\n", shared);
 			printk("\t%d pages swap cached\n", cached);
-			pgdat = pgdat->node_next;
-		} while (pgdat);
+		}
 		printk("Total of %ld pages in page table cache\n", pgtable_cache_size);
 		printk("%d free buffer pages\n", nr_free_buffer_pages());
 	}
--- 2.5.29/include/linux/mmzone.h~for_each_pgdat	Sat Jul 27 23:39:06 2002
+++ 2.5.29-akpm/include/linux/mmzone.h	Sat Jul 27 23:49:01 2002
@@ -136,7 +136,7 @@ typedef struct pglist_data {
 	unsigned long node_start_mapnr;
 	unsigned long node_size;
 	int node_id;
-	struct pglist_data *node_next;
+	struct pglist_data *pgdat_next;
 } pg_data_t;
 
 extern int numnodes;
@@ -163,6 +163,20 @@ extern void free_area_init_core(int nid,
 
 extern pg_data_t contig_page_data;
 
+/**
+ * for_each_pgdat - helper macro to iterate over all nodes
+ * @pgdat - pointer to a pg_data_t variable
+ *
+ * Meant to help with common loops of the form
+ * pgdat = pgdat_list;
+ * while(pgdat) {
+ * 	...
+ * 	pgdat = pgdat->pgdat_next;
+ * }
+ */
+#define for_each_pgdat(pgdat) \
+	for (pgdat = pgdat_list; pgdat; pgdat = pgdat->pgdat_next)
+
 #ifndef CONFIG_DISCONTIGMEM
 
 #define NODE_DATA(nid)		(&contig_page_data)
--- 2.5.29/mm/bootmem.c~for_each_pgdat	Sat Jul 27 23:39:06 2002
+++ 2.5.29-akpm/mm/bootmem.c	Sat Jul 27 23:39:06 2002
@@ -49,7 +49,7 @@ static unsigned long __init init_bootmem
 	bootmem_data_t *bdata = pgdat->bdata;
 	unsigned long mapsize = ((end - start)+7)/8;
 
-	pgdat->node_next = pgdat_list;
+	pgdat->pgdat_next = pgdat_list;
 	pgdat_list = pgdat;
 
 	mapsize = (mapsize + (sizeof(long) - 1UL)) & ~(sizeof(long) - 1UL);
@@ -339,12 +339,11 @@ void * __init __alloc_bootmem (unsigned 
 	pg_data_t *pgdat = pgdat_list;
 	void *ptr;
 
-	while (pgdat) {
+	for_each_pgdat(pgdat)
 		if ((ptr = __alloc_bootmem_core(pgdat->bdata, size,
 						align, goal)))
 			return(ptr);
-		pgdat = pgdat->node_next;
-	}
+
 	/*
 	 * Whoops, we cannot satisfy the allocation request.
 	 */
--- 2.5.29/mm/numa.c~for_each_pgdat	Sat Jul 27 23:39:06 2002
+++ 2.5.29-akpm/mm/numa.c	Sat Jul 27 23:39:06 2002
@@ -98,19 +98,19 @@ struct page * _alloc_pages(unsigned int 
 	if (!next)
 		next = pgdat_list;
 	temp = next;
-	next = next->node_next;
+	next = next->pgdat_next;
 #endif
 	start = temp;
 	while (temp) {
 		if ((ret = alloc_pages_pgdat(temp, gfp_mask, order)))
 			return(ret);
-		temp = temp->node_next;
+		temp = temp->pgdat_next;
 	}
 	temp = pgdat_list;
 	while (temp != start) {
 		if ((ret = alloc_pages_pgdat(temp, gfp_mask, order)))
 			return(ret);
-		temp = temp->node_next;
+		temp = temp->pgdat_next;
 	}
 	return(0);
 }
--- 2.5.29/mm/page_alloc.c~for_each_pgdat	Sat Jul 27 23:39:06 2002
+++ 2.5.29-akpm/mm/page_alloc.c	Sat Jul 27 23:49:01 2002
@@ -481,7 +481,7 @@ unsigned int nr_free_pages(void)
 	unsigned int i, sum = 0;
 	pg_data_t *pgdat;
 
-	for (pgdat = pgdat_list; pgdat; pgdat = pgdat->node_next)
+	for (pgdat = pgdat_list; pgdat; pgdat = pgdat->pgdat_next)
 		for (i = 0; i < MAX_NR_ZONES; ++i)
 			sum += pgdat->node_zones[i].free_pages;
 
@@ -490,10 +490,10 @@ unsigned int nr_free_pages(void)
 
 static unsigned int nr_free_zone_pages(int offset)
 {
-	pg_data_t *pgdat = pgdat_list;
+	pg_data_t *pgdat;
 	unsigned int sum = 0;
 
-	do {
+	for_each_pgdat(pgdat) {
 		zonelist_t *zonelist = pgdat->node_zonelists + offset;
 		zone_t **zonep = zonelist->zones;
 		zone_t *zone;
@@ -504,9 +504,7 @@ static unsigned int nr_free_zone_pages(i
 			if (size > high)
 				sum += size - high;
 		}
-
-		pgdat = pgdat->node_next;
-	} while (pgdat);
+	}
 
 	return sum;
 }
@@ -530,13 +528,12 @@ unsigned int nr_free_pagecache_pages(voi
 #if CONFIG_HIGHMEM
 unsigned int nr_free_highpages (void)
 {
-	pg_data_t *pgdat = pgdat_list;
+	pg_data_t *pgdat;
 	unsigned int pages = 0;
 
-	while (pgdat) {
+	for_each_pgdat(pgdat)
 		pages += pgdat->node_zones[ZONE_HIGHMEM].free_pages;
-		pgdat = pgdat->node_next;
-	}
+
 	return pages;
 }
 #endif
@@ -614,7 +611,7 @@ void show_free_areas(void)
 		K(nr_free_pages()),
 		K(nr_free_highpages()));
 
-	for (pgdat = pgdat_list; pgdat; pgdat = pgdat->node_next)
+	for (pgdat = pgdat_list; pgdat; pgdat = pgdat->pgdat_next)
 		for (type = 0; type < MAX_NR_ZONES; ++type) {
 			zone_t *zone = &pgdat->node_zones[type];
 			printk("Zone:%s "
@@ -636,7 +633,7 @@ void show_free_areas(void)
 		ps.nr_writeback,
 		nr_free_pages());
 
-	for (pgdat = pgdat_list; pgdat; pgdat = pgdat->node_next)
+	for (pgdat = pgdat_list; pgdat; pgdat = pgdat->pgdat_next)
 		for (type = 0; type < MAX_NR_ZONES; type++) {
 			list_t *elem;
 			zone_t *zone = &pgdat->node_zones[type];
--- 2.5.29/mm/vmscan.c~for_each_pgdat	Sat Jul 27 23:39:06 2002
+++ 2.5.29-akpm/mm/vmscan.c	Sat Jul 27 23:39:06 2002
@@ -471,7 +471,7 @@ static void kswapd_balance(void)
 		pgdat = pgdat_list;
 		do
 			need_more_balance |= kswapd_balance_pgdat(pgdat);
-		while ((pgdat = pgdat->node_next));
+		while ((pgdat = pgdat->pgdat_next));
 	} while (need_more_balance);
 }
 
@@ -499,7 +499,7 @@ static int kswapd_can_sleep(void)
 		if (kswapd_can_sleep_pgdat(pgdat))
 			continue;
 		return 0;
-	} while ((pgdat = pgdat->node_next));
+	} while ((pgdat = pgdat->pgdat_next));
 
 	return 1;
 }

.
