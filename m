Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312491AbSDXSmL>; Wed, 24 Apr 2002 14:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312495AbSDXSmK>; Wed, 24 Apr 2002 14:42:10 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:34443 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S312491AbSDXSmI>;
	Wed, 24 Apr 2002 14:42:08 -0400
Date: Wed, 24 Apr 2002 12:39:40 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Christoph Hellwig <hch@infradead.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] patch to /proc/meminfo to display NUMA stats
Message-ID: <73870000.1019677180@flay>
In-Reply-To: <20020422173958.A3557@infradead.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, here version 2

> Sure.  First I wonder whether it would be possible to kill nr_free_pages()
> and nr_free_highpages() (or infact all of the nr_free*page() functions)
> in favour of the per-node ones, externalizing the for loop.  Or if there
> are to many users at least make them use the per-node version.
> Second I wonder whether nr_free_pages_node() and nr_free_highpages_node()
> should take a pgdat instead of a node id as the caller has it around anyway.

OK, I've taken most of this - I made the nr_free_pages extensions into _pgdat
calls that operate on a pgdat, as you suggested. I still think we need a 
nr_free_pages and friends to give global statistics, but I made those call
the pgdat functions (which I made inline to keep the speed up - they're small
with not many callers, so hopefully this isn't controversial).

> Also I think the per-node info should be in /proc/meminfo even for UMA
> machines, it doesn't hurt but makes it more consistant.

I'm slightly wary of doing this, as it'll break tools that parse /proc/meminfo
for everybody ... what I'm doing is fairly conservative, and having the global
section still there seems useful to me for the NUMA machines too. 

I also shifted the si_meminfo_node into mm/numa.c to make it generic for
all machines, and made it loop through the node_next loop of pgdats to
make it work on machines that have discontig within a node.

What do people think of the attatched version?

M.

diff -urN virgin-2.4.18/fs/proc/proc_misc.c linux-2.4.18-meminfo/fs/proc/proc_misc.c
--- virgin-2.4.18/fs/proc/proc_misc.c	Tue Nov 20 21:29:09 2001
+++ linux-2.4.18-meminfo/fs/proc/proc_misc.c	Mon Apr 15 09:31:32 2002
@@ -132,7 +132,7 @@
 				 int count, int *eof, void *data)
 {
 	struct sysinfo i;
-	int len;
+	int len, nid;
 	int pg_size ;
 
 /*
@@ -185,6 +185,27 @@
 		K(i.freeram-i.freehigh),
 		K(i.totalswap),
 		K(i.freeswap));
+
+#ifdef CONFIG_NUMA
+	for (nid = 0; nid < numnodes; ++nid) {
+		si_meminfo_node(&i, nid);
+		len += sprintf(page+len, "\n"
+			"Node %d MemTotal:     %8lu kB\n"
+			"Node %d MemFree:     %8lu kB\n"
+			"Node %d MemUsed:     %8lu kB\n"
+			"Node %d HighTotal:    %8lu kB\n"
+			"Node %d HighFree:     %8lu kB\n"
+			"Node %d LowTotal:     %8lu kB\n"
+			"Node %d LowFree:      %8lu kB\n",
+			nid, K(i.totalram),
+			nid, K(i.freeram),
+			nid, K(i.totalram-i.freeram),
+			nid, K(i.totalhigh),
+			nid, K(i.freehigh),
+			nid, K(i.totalram-i.totalhigh),
+			nid, K(i.freeram-i.freehigh));
+	}
+#endif
 
 	return proc_calc_metrics(page, start, off, count, eof, len);
 #undef B
diff -urN virgin-2.4.18/include/linux/highmem.h linux-2.4.18-meminfo/include/linux/highmem.h
--- virgin-2.4.18/include/linux/highmem.h	Mon Feb 25 11:38:13 2002
+++ linux-2.4.18-meminfo/include/linux/highmem.h	Mon Apr 22 15:52:36 2002
@@ -12,6 +12,7 @@
 
 /* declarations for linux/mm/highmem.c */
 unsigned int nr_free_highpages(void);
+inline unsigned int nr_free_highpages_pgdat(pg_data_t *pgdat);
 
 extern struct buffer_head * create_bounce(int rw, struct buffer_head * bh_orig);
 
diff -urN virgin-2.4.18/include/linux/mm.h linux-2.4.18-meminfo/include/linux/mm.h
--- virgin-2.4.18/include/linux/mm.h	Fri Dec 21 09:42:03 2001
+++ linux-2.4.18-meminfo/include/linux/mm.h	Sun Apr 14 13:52:34 2002
@@ -447,6 +447,9 @@
 extern void mem_init(void);
 extern void show_mem(void);
 extern void si_meminfo(struct sysinfo * val);
+#ifdef CONFIG_NUMA
+extern void si_meminfo_node(struct sysinfo *val, int nid);
+#endif
 extern void swapin_readahead(swp_entry_t);
 
 extern struct address_space swapper_space;
diff -urN virgin-2.4.18/include/linux/swap.h linux-2.4.18-meminfo/include/linux/swap.h
--- virgin-2.4.18/include/linux/swap.h	Thu Nov 22 11:46:19 2001
+++ linux-2.4.18-meminfo/include/linux/swap.h	Mon Apr 22 15:53:55 2002
@@ -84,6 +84,7 @@
 #define vm_swap_full() (nr_swap_pages*2 < total_swap_pages)
 
 extern unsigned int nr_free_pages(void);
+extern inline unsigned int nr_free_pages_pgdat (pg_data_t *pgdat);
 extern unsigned int nr_free_buffer_pages(void);
 extern int nr_active_pages;
 extern int nr_inactive_pages;
diff -urN virgin-2.4.18/mm/numa.c linux-2.4.18-meminfo/mm/numa.c
--- virgin-2.4.18/mm/numa.c	Mon Sep 17 16:15:02 2001
+++ linux-2.4.18-meminfo/mm/numa.c	Wed Apr 24 12:08:52 2002
@@ -128,3 +128,26 @@
 }
 
 #endif /* CONFIG_DISCONTIGMEM */
+
+void si_meminfo_node(struct sysinfo *val, int nid)
+{
+	pg_data_t *pgdat;
+
+	val->totalram = 0;
+	val->freeram = 0;
+	val->totalhigh = 0;
+	val->freehigh = 0;
+
+	pgdat = NODE_DATA(nid);
+	while (pgdat) {
+		val->totalram = pgdat->node_size;
+		val->freeram = nr_free_pages_pgdat(pgdat);
+		#ifdef CONFIG_HIGHMEM
+			val->totalhigh = pgdat->node_zones[ZONE_HIGHMEM].size;
+			val->freehigh = nr_free_highpages_pgdat(pgdat);
+		#endif
+		pgdat = pgdat->node_next;
+	}
+	val->mem_unit = PAGE_SIZE;
+	return;
+}
diff -urN virgin-2.4.18/mm/page_alloc.c linux-2.4.18-meminfo/mm/page_alloc.c
--- virgin-2.4.18/mm/page_alloc.c	Mon Feb 25 11:38:14 2002
+++ linux-2.4.18-meminfo/mm/page_alloc.c	Wed Apr 24 12:10:26 2002
@@ -450,19 +450,31 @@
 unsigned int nr_free_pages (void)
 {
 	unsigned int sum;
-	zone_t *zone;
 	pg_data_t *pgdat = pgdat_list;
 
 	sum = 0;
 	while (pgdat) {
-		for (zone = pgdat->node_zones; zone < pgdat->node_zones + MAX_NR_ZONES; zone++)
-			sum += zone->free_pages;
+		sum += nr_free_pages_pgdat(pgdat);
 		pgdat = pgdat->node_next;
 	}
 	return sum;
 }
 
 /*
+ * Total amount of free (allocatable) RAM for a given pg_data_t:
+ */
+inline unsigned int nr_free_pages_pgdat (pg_data_t *pgdat)
+{
+	unsigned int sum; 
+	zone_t *zone;
+
+	sum = 0;
+	for (zone = pgdat->node_zones; zone < pgdat->node_zones + MAX_NR_ZONES; zone++)
+		sum += zone->free_pages;
+	return sum;
+}
+
+/*
  * Amount of free RAM allocatable as buffer memory:
  */
 unsigned int nr_free_buffer_pages (void)
@@ -495,12 +507,17 @@
 	unsigned int pages = 0;
 
 	while (pgdat) {
-		pages += pgdat->node_zones[ZONE_HIGHMEM].free_pages;
+		pages += nr_free_highpages_pgdat(pgdat);
 		pgdat = pgdat->node_next;
 	}
 	return pages;
 }
-#endif
+
+inline unsigned int nr_free_highpages_pgdat (pg_data_t *pgdat)
+{
+	return pgdat->node_zones[ZONE_HIGHMEM].free_pages;
+}
+#endif /* CONFIG_HIGHMEM */
 
 #define K(x) ((x) << (PAGE_SHIFT-10))
 

