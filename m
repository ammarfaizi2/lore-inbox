Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314230AbSDVQHr>; Mon, 22 Apr 2002 12:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314242AbSDVQHo>; Mon, 22 Apr 2002 12:07:44 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:52655 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S314230AbSDVQHj>;
	Mon, 22 Apr 2002 12:07:39 -0400
Date: Mon, 22 Apr 2002 10:05:19 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [RFC] patch to /proc/meminfo to display NUMA stats
Message-ID: <25270000.1019495119@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below is a patch to /proc/meminfo to display free, used and total
memory per node on a NUMA machine. It works fine on an ia32
machine, but is not yet ready for submission until I make it generic.
Before I go to the effort of doing that, I thought I'd seek some feedback.

Comments?

Thanks,

Martin.

diff -urN virgin-2.4.18/arch/i386/mm/init.c linux-2.4.18-meminfo/arch/i386/mm/init.c
--- virgin-2.4.18/arch/i386/mm/init.c	Fri Dec 21 09:41:53 2001
+++ linux-2.4.18-meminfo/arch/i386/mm/init.c	Sun Apr 14 13:43:56 2002
@@ -598,6 +598,18 @@
 	return;
 }
 
+#ifdef CONFIG_NUMA
+void si_meminfo_node(struct sysinfo *val, int nid)
+{
+	val->totalram = NODE_DATA(nid)->node_size;
+	val->freeram = nr_free_pages_node(nid);
+	val->totalhigh = NODE_DATA(nid)->node_zones[ZONE_HIGHMEM].size;
+	val->freehigh = nr_free_highpages_node(nid);
+	val->mem_unit = PAGE_SIZE;
+	return;
+}
+#endif
+
 #if defined(CONFIG_X86_PAE)
 struct kmem_cache_s *pae_pgd_cachep;
 void __init pgtable_cache_init(void)
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
+++ linux-2.4.18-meminfo/include/linux/highmem.h	Sun Apr 14 13:48:11 2002
@@ -12,6 +12,9 @@
 
 /* declarations for linux/mm/highmem.c */
 unsigned int nr_free_highpages(void);
+#ifdef CONFIG_NUMA
+unsigned int nr_free_highpages_node (int);
+#endif
 
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
+++ linux-2.4.18-meminfo/include/linux/swap.h	Sun Apr 14 13:48:46 2002
@@ -84,6 +84,9 @@
 #define vm_swap_full() (nr_swap_pages*2 < total_swap_pages)
 
 extern unsigned int nr_free_pages(void);
+#ifdef CONFIG_NUMA
+extern unsigned int nr_free_pages_node (int);
+#endif
 extern unsigned int nr_free_buffer_pages(void);
 extern int nr_active_pages;
 extern int nr_inactive_pages;
diff -urN virgin-2.4.18/mm/page_alloc.c linux-2.4.18-meminfo/mm/page_alloc.c
--- virgin-2.4.18/mm/page_alloc.c	Mon Feb 25 11:38:14 2002
+++ linux-2.4.18-meminfo/mm/page_alloc.c	Sun Apr 14 13:43:56 2002
@@ -462,6 +462,23 @@
 	return sum;
 }
 
+#ifdef CONFIG_NUMA
+/*
+ * Total amount of free (allocatable) RAM for a given node:
+ */
+unsigned int nr_free_pages_node (int nid)
+{
+	unsigned int sum;
+	zone_t *zone;
+	pg_data_t *pgdat = NODE_DATA(nid);
+
+	sum = 0;
+	for (zone = pgdat->node_zones; zone < pgdat->node_zones + MAX_NR_ZONES; zone++)
+		sum += zone->free_pages;
+	return sum;
+}
+#endif
+
 /*
  * Amount of free RAM allocatable as buffer memory:
  */
@@ -500,7 +517,14 @@
 	}
 	return pages;
 }
-#endif
+
+#ifdef CONFIG_NUMA
+unsigned int nr_free_highpages_node (int nid)
+{
+	return NODE_DATA(nid)->node_zones[ZONE_HIGHMEM].free_pages;
+}
+#endif /* CONFIG_NUMA */
+#endif /* CONFIG_HIGHMEM */
 
 #define K(x) ((x) << (PAGE_SHIFT-10))
 

