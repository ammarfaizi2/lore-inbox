Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317542AbSGTVe0>; Sat, 20 Jul 2002 17:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317541AbSGTVe0>; Sat, 20 Jul 2002 17:34:26 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:57335 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317540AbSGTVeX>; Sat, 20 Jul 2002 17:34:23 -0400
Subject: Re: [PATCH] for_each_pgdat
From: Robert Love <rml@tech9.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, akpm@zip.com.au,
       riel@conectiva.com.br, linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <Pine.LNX.4.44.0207201359350.1576-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0207201359350.1576-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 20 Jul 2002 14:37:19 -0700
Message-Id: <1027201039.1085.812.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-07-20 at 14:00, Linus Torvalds wrote:

> Ok guys, you three (and whoever else wants to play? ;) fight it out amonst
> yourselves, I'll wait for the end result (iow: I'll just ignore both
> patches for now).

No no... the issues are fairly orthogonal.

Attached is a patch with the for_each_pgdat implementation and
s/node_next/pgdat_next/ per Martin.

If Bill wants to convert pgdats to lists that is fine but is another
step.  Let's get in this first batch and that can be done off this.

Patch is against 2.5.27, please apply.

	Robert Love

diff -urN linux-2.5.27/arch/ia64/mm/init.c linux/arch/ia64/mm/init.c
--- linux-2.5.27/arch/ia64/mm/init.c	Sat Jul 20 12:11:15 2002
+++ linux/arch/ia64/mm/init.c	Sat Jul 20 14:27:15 2002
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
+++ linux/include/linux/mmzone.h	Sat Jul 20 14:28:57 2002
@@ -136,7 +136,7 @@
 	unsigned long node_start_mapnr;
 	unsigned long node_size;
 	int node_id;
-	struct pglist_data *node_next;
+	struct pglist_data *pgdat_next;
 } pg_data_t;
 
 extern int numnodes;
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
+ * 	pgdat = pgdat->pgdat_next;
+ * }
+ */
+#define for_each_pgdat(pgdat) \
+	for (pgdat = pgdat_list; pgdat; pgdat = pgdat->pgdat_next)
+
 #ifndef CONFIG_DISCONTIGMEM
 
 #define NODE_DATA(nid)		(&contig_page_data)
diff -urN linux-2.5.27/mm/bootmem.c linux/mm/bootmem.c
--- linux-2.5.27/mm/bootmem.c	Sat Jul 20 12:11:12 2002
+++ linux/mm/bootmem.c	Sat Jul 20 14:28:52 2002
@@ -49,7 +49,7 @@
 	bootmem_data_t *bdata = pgdat->bdata;
 	unsigned long mapsize = ((end - start)+7)/8;
 
-	pgdat->node_next = pgdat_list;
+	pgdat->pgdat_next = pgdat_list;
 	pgdat_list = pgdat;
 
 	mapsize = (mapsize + (sizeof(long) - 1UL)) & ~(sizeof(long) - 1UL);
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
diff -urN linux-2.5.27/mm/numa.c linux/mm/numa.c
--- linux-2.5.27/mm/numa.c	Sat Jul 20 12:11:12 2002
+++ linux/mm/numa.c	Sat Jul 20 14:29:11 2002
@@ -109,20 +109,20 @@
 	spin_lock_irqsave(&node_lock, flags);
 	if (!next) next = pgdat_list;
 	temp = next;
-	next = next->node_next;
+	next = next->pgdat_next;
 	spin_unlock_irqrestore(&node_lock, flags);
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
diff -urN linux-2.5.27/mm/page_alloc.c linux/mm/page_alloc.c
--- linux-2.5.27/mm/page_alloc.c	Sat Jul 20 12:11:07 2002
+++ linux/mm/page_alloc.c	Sat Jul 20 14:29:25 2002
@@ -480,7 +480,7 @@
 	unsigned int i, sum = 0;
 	pg_data_t *pgdat;
 
-	for (pgdat = pgdat_list; pgdat; pgdat = pgdat->node_next)
+	for (pgdat = pgdat_list; pgdat; pgdat = pgdat->pgdat_next)
 		for (i = 0; i < MAX_NR_ZONES; ++i)
 			sum += pgdat->node_zones[i].free_pages;
 
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
@@ -627,7 +624,7 @@
 					K(zone->pages_low),
 					K(zone->pages_high));
 			
-		tmpdat = tmpdat->node_next;
+		tmpdat = tmpdat->pgdat_next;
 	}
 
 	printk("( Active:%lu inactive:%lu dirty:%lu writeback:%lu free:%u )\n",
diff -urN linux-2.5.27/mm/vmscan.c linux/mm/vmscan.c
--- linux-2.5.27/mm/vmscan.c	Sat Jul 20 12:11:08 2002
+++ linux/mm/vmscan.c	Sat Jul 20 14:29:35 2002
@@ -471,7 +471,7 @@
 		pgdat = pgdat_list;
 		do
 			need_more_balance |= kswapd_balance_pgdat(pgdat);
-		while ((pgdat = pgdat->node_next));
+		while ((pgdat = pgdat->pgdat_next));
 	} while (need_more_balance);
 }
 
@@ -499,7 +499,7 @@
 		if (kswapd_can_sleep_pgdat(pgdat))
 			continue;
 		return 0;
-	} while ((pgdat = pgdat->node_next));
+	} while ((pgdat = pgdat->pgdat_next));
 
 	return 1;
 }


