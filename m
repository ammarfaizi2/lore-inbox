Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317493AbSGTUlO>; Sat, 20 Jul 2002 16:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317500AbSGTUlN>; Sat, 20 Jul 2002 16:41:13 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:49150 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317493AbSGTUlK>; Sat, 20 Jul 2002 16:41:10 -0400
Date: Sat, 20 Jul 2002 13:43:00 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Robert Love <rml@tech9.net>, akpm@zip.com.au, torvalds@transmeta.com
cc: riel@conectiva.com.br, linux-kernel@vger.kernel.org, wli@holomorphy.com,
       linux-mm@kvack.org
Subject: Re: [PATCH] for_each_pgdat
Message-ID: <236911771.1027172579@[10.10.2.3]>
In-Reply-To: <1027196535.1116.773.camel@sinai>
References: <1027196535.1116.773.camel@sinai>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch implements for_each_pgdat(pg_data_t *) which is a helper
> macro to cleanup code that does a loop of the form:
> 
> 	pgdat = pgdat_list;
> 	while(pgdat) {
> 		/* ... */
> 		pgdat = pgdat->node_next;
> 	}
> 
> and replace it with:
> 
> 	for_each_pgdat(pgdat) {
> 		/* ... */
> 	}

If you're going to do that (which I think is a good idea) can you
rename node_next to pgdat_next, as it often has nothing to do with
nodes whatsoever (discontigmem on a non-NUMA machine, or even more
confusingly a NUMA machine which is discontig within a node)? I'll
attatch a patch below, but it conflicts what what you're doing
horribly, and it's even easier to do after your abtraction ...


diff -urN virgin-2.5.25/arch/ia64/mm/init.c 2.5.25-A02-pgdat_next/arch/ia64/mm/init.c
--- virgin-2.5.25/arch/ia64/mm/init.c	Fri Jul  5 16:42:22 2002
+++ 2.5.25-A02-pgdat_next/arch/ia64/mm/init.c	Fri Jul 19 10:33:48 2002
@@ -184,7 +184,7 @@
 			printk("\t%d reserved pages\n", reserved);
 			printk("\t%d pages shared\n", shared);
 			printk("\t%d pages swap cached\n", cached);
-			pgdat = pgdat->node_next;
+			pgdat = pgdat->pgdat_next;
 		} while (pgdat);
 		printk("Total of %ld pages in page table cache\n", pgtable_cache_size);
 		printk("%d free buffer pages\n", nr_free_buffer_pages());
diff -urN virgin-2.5.25/include/linux/mmzone.h 2.5.25-A02-pgdat_next/include/linux/mmzone.h
--- virgin-2.5.25/include/linux/mmzone.h	Fri Jul  5 16:42:02 2002
+++ 2.5.25-A02-pgdat_next/include/linux/mmzone.h	Fri Jul 19 10:34:12 2002
@@ -136,11 +136,11 @@
 	unsigned long node_start_mapnr;
 	unsigned long node_size;
 	int node_id;
-	struct pglist_data *node_next;
+	struct pglist_data *pgdat_next;          /* global chain of pg_data_t's */
 } pg_data_t;
 
 extern int numnodes;
-extern pg_data_t *pgdat_list;
+extern pg_data_t *pgdat_list;        /* head of global chain of pg_data_t's */
 
 static inline int memclass(zone_t *pgzone, zone_t *classzone)
 {
diff -urN virgin-2.5.25/mm/bootmem.c 2.5.25-A02-pgdat_next/mm/bootmem.c
--- virgin-2.5.25/mm/bootmem.c	Fri Jul  5 16:42:20 2002
+++ 2.5.25-A02-pgdat_next/mm/bootmem.c	Thu Jul 18 16:04:54 2002
@@ -49,7 +49,7 @@
 	bootmem_data_t *bdata = pgdat->bdata;
 	unsigned long mapsize = ((end - start)+7)/8;
 
-	pgdat->node_next = pgdat_list;
+	pgdat->pgdat_next = pgdat_list;
 	pgdat_list = pgdat;
 
 	mapsize = (mapsize + (sizeof(long) - 1UL)) & ~(sizeof(long) - 1UL);
@@ -343,7 +343,7 @@
 		if ((ptr = __alloc_bootmem_core(pgdat->bdata, size,
 						align, goal)))
 			return(ptr);
-		pgdat = pgdat->node_next;
+		pgdat = pgdat->pgdat_next;
 	}
 	/*
 	 * Whoops, we cannot satisfy the allocation request.
diff -urN virgin-2.5.25/mm/numa.c 2.5.25-A02-pgdat_next/mm/numa.c
--- virgin-2.5.25/mm/numa.c	Fri Jul  5 16:42:20 2002
+++ 2.5.25-A02-pgdat_next/mm/numa.c	Thu Jul 18 15:21:16 2002
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
diff -urN virgin-2.5.25/mm/page_alloc.c 2.5.25-A02-pgdat_next/mm/page_alloc.c
--- virgin-2.5.25/mm/page_alloc.c	Fri Jul  5 16:42:03 2002
+++ 2.5.25-A02-pgdat_next/mm/page_alloc.c	Thu Jul 18 15:25:35 2002
@@ -477,7 +477,7 @@
 	unsigned int i, sum = 0;
 	pg_data_t *pgdat;
 
-	for (pgdat = pgdat_list; pgdat; pgdat = pgdat->node_next)
+	for (pgdat = pgdat_list; pgdat; pgdat = pgdat->pgdat_next)
 		for (i = 0; i < MAX_NR_ZONES; ++i)
 			sum += pgdat->node_zones[i].free_pages;
 
@@ -501,7 +501,7 @@
 				sum += size - high;
 		}
 
-		pgdat = pgdat->node_next;
+		pgdat = pgdat->pgdat_next;
 	} while (pgdat);
 
 	return sum;
@@ -531,7 +531,7 @@
 
 	while (pgdat) {
 		pages += pgdat->node_zones[ZONE_HIGHMEM].free_pages;
-		pgdat = pgdat->node_next;
+		pgdat = pgdat->pgdat_next;
 	}
 	return pages;
 }
@@ -621,7 +621,7 @@
 					K(zone->pages_low),
 					K(zone->pages_high));
 			
-		tmpdat = tmpdat->node_next;
+		tmpdat = tmpdat->pgdat_next;
 	}
 
 	printk("( Active:%lu inactive:%lu dirty:%lu writeback:%lu free:%u )\n",
diff -urN virgin-2.5.25/mm/vmscan.c 2.5.25-A02-pgdat_next/mm/vmscan.c
--- virgin-2.5.25/mm/vmscan.c	Fri Jul  5 16:42:05 2002
+++ 2.5.25-A02-pgdat_next/mm/vmscan.c	Thu Jul 18 15:28:03 2002
@@ -747,7 +747,7 @@
 		pgdat = pgdat_list;
 		do
 			need_more_balance |= kswapd_balance_pgdat(pgdat);
-		while ((pgdat = pgdat->node_next));
+		while ((pgdat = pgdat->pgdat_next));
 	} while (need_more_balance);
 }
 
@@ -775,7 +775,7 @@
 		if (kswapd_can_sleep_pgdat(pgdat))
 			continue;
 		return 0;
-	} while ((pgdat = pgdat->node_next));
+	} while ((pgdat = pgdat->pgdat_next));
 
 	return 1;
 }

