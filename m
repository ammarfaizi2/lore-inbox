Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317504AbSGTUVM>; Sat, 20 Jul 2002 16:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317495AbSGTUUL>; Sat, 20 Jul 2002 16:20:11 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:41716 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317493AbSGTUTO>; Sat, 20 Jul 2002 16:19:14 -0400
Subject: [PATCH] for_each_pgdat
From: Robert Love <rml@tech9.net>
To: akpm@zip.com.au, torvalds@transmeta.com
Cc: riel@conectiva.com.br, linux-kernel@vger.kernel.org, wli@holomorphy.com,
       linux-mm@kvack.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 20 Jul 2002 13:22:15 -0700
Message-Id: <1027196535.1116.773.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

Patch is against 2.5.27, please apply.

	Robert Love

diff -urN linux-2.5.27/arch/ia64/mm/init.c linux/arch/ia64/mm/init.c
--- linux-2.5.27/arch/ia64/mm/init.c	Sat Jul 20 12:11:15 2002
+++ linux/arch/ia64/mm/init.c	Sat Jul 20 12:56:57 2002
@@ -167,10 +167,10 @@
 
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
@@ -184,8 +184,7 @@
 			printk("\t%d reserved pages\n", reserved);
 			printk("\t%d pages shared\n", shared);
 			printk("\t%d pages swap cached\n", cached);
-			pgdat = pgdat->node_next;
-		} while (pgdat);
+		}
 		printk("Total of %ld pages in page table cache\n", pgtable_cache_size);
 		printk("%d free buffer pages\n", nr_free_buffer_pages());
 	}
diff -urN linux-2.5.27/include/linux/mmzone.h linux/include/linux/mmzone.h
--- linux-2.5.27/include/linux/mmzone.h	Sat Jul 20 12:11:05 2002
+++ linux/include/linux/mmzone.h	Sat Jul 20 12:56:57 2002
@@ -163,6 +163,20 @@
 
 extern pg_data_t contig_page_data;
 
+/**
+ * for_each_pgdat - helper macro to iterate over all nodes
+ * @pgdat - pointer to a pg_data_t variable
+ *
+ * Meant to help with common loops of the form
+ * pgdat = pgdat_list;
+ * while(pgdat) {
+ * 	...
+ * 	pgdat = pgdat->node_next;
+ * }
+ */
+#define for_each_pgdat(pgdat) \
+	for (pgdat = pgdat_list; pgdat; pgdat = pgdat->node_next)
+
 #ifndef CONFIG_DISCONTIGMEM
 
 #define NODE_DATA(nid)		(&contig_page_data)
diff -urN linux-2.5.27/mm/bootmem.c linux/mm/bootmem.c
--- linux-2.5.27/mm/bootmem.c	Sat Jul 20 12:11:12 2002
+++ linux/mm/bootmem.c	Sat Jul 20 12:56:57 2002
@@ -339,12 +339,11 @@
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
diff -urN linux-2.5.27/mm/page_alloc.c linux/mm/page_alloc.c
--- linux-2.5.27/mm/page_alloc.c	Sat Jul 20 12:11:07 2002
+++ linux/mm/page_alloc.c	Sat Jul 20 12:56:57 2002
@@ -489,10 +489,10 @@
 
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
@@ -503,9 +503,7 @@
 			if (size > high)
 				sum += size - high;
 		}
-
-		pgdat = pgdat->node_next;
-	} while (pgdat);
+	}
 
 	return sum;
 }
@@ -529,13 +527,12 @@
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

