Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264221AbUCPRWF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 12:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263250AbUCPRUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 12:20:05 -0500
Received: from zcamail05.zca.compaq.com ([161.114.32.105]:61968 "EHLO
	zcamail05.zca.compaq.com") by vger.kernel.org with ESMTP
	id S263639AbUCPRO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 12:14:27 -0500
Message-ID: <40573460.9090605@hp.com>
Date: Tue, 16 Mar 2004 12:07:44 -0500
From: Robert Picco <Robert.Picco@hp.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Robert.Picco@hp.com, colpatch@us.ibm.com, mbligh@aracnet.com
Subject: boot time node and memory limit options
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch supports three boot line options.  mem_limit limits the amount of physical memory.
node_mem_limit limits the amount of physical memory per node on a NUMA machine.  nodes_limit
reduces the number of NUMA nodes to the value specified.  On a NUMA machine an eliminated node's 
CPU(s) are removed from the cpu_possible_map.  

The patch has been tested on an IA64 NUMA machine and uniprocessor X86 machine.

thanks,

Bob


--- linux-2.6.4-orig/mm/page_alloc.c	2004-03-10 21:55:22.000000000 -0500
+++ linux-2.6.4/mm/page_alloc.c	2004-03-15 12:11:35.000000000 -0500
@@ -55,6 +55,43 @@
 static char *zone_names[MAX_NR_ZONES] = { "DMA", "Normal", "HighMem" };
 int min_free_kbytes = 1024;
 
+static unsigned long mem_limit  __initdata = ~0UL;
+static unsigned long total_mem __initdata;
+
+static int __init mem_setup(char *str)
+{
+	char *end;
+
+	mem_limit = memparse(str + 1, &end) - 1;
+	return 1;
+}
+
+__setup("mem_limit", mem_setup);
+
+#ifdef	CONFIG_NUMA
+static unsigned long node_mem_limit __initdata = ~0UL;
+static long node_limit __initdata = MAX_NUMNODES;
+
+static int __init node_mem_setup(char *str)
+{
+	char *end;
+
+	node_mem_limit = memparse(str + 1, &end) - 1;
+	return 1;
+}
+
+static int __init nodes_setup(char *str)
+{
+	node_limit  =  simple_strtol(str+1, NULL, 10);
+	if (!node_limit)
+		node_limit = 1;
+	return 1;
+}
+
+__setup("node_mem_limit", node_mem_setup);
+__setup("nodes_limit", nodes_setup);
+#endif
+
 /*
  * Temporary debugging check for pages not lying within a given zone.
  */
@@ -1371,6 +1408,106 @@
 	}
 }
 
+#ifdef	CONFIG_NUMA
+static void __init do_trim_cpu(int node)
+{
+	int i;
+
+	for (i = 0; i < NR_CPUS; i++)
+		if (cpu_to_node(i) == node)
+			cpu_clear(i, cpu_possible_map);
+	return;
+}
+#endif
+
+static unsigned long __init dma_zone_top(struct pglist_data *pgdat, int *dmazones)
+{
+	unsigned long top;
+#define	DMA_SPAN_MIN	((64*1024*1024) >> PAGE_SHIFT)
+	top = 0UL;
+
+	if (pgdat->node_zones[ZONE_DMA].spanned_pages) {
+		if (*dmazones > 1) 
+			--*dmazones;			
+		else {
+			if (pgdat->node_zones[ZONE_DMA].spanned_pages > DMA_SPAN_MIN)
+				top = DMA_SPAN_MIN + pgdat->node_zones[ZONE_DMA].zone_start_pfn;
+			else
+				top = pgdat->node_zones[ZONE_DMA].zone_start_pfn + 
+					pgdat->node_zones[ZONE_DMA].spanned_pages;
+		}
+	}
+
+	return top;
+}
+
+void __init do_mem_limits(void)
+{
+	unsigned long total, alloc, free, top;
+	struct pglist_data *pgdat;
+	int dmazones;
+
+#ifdef	CONFIG_NUMA
+	if (node_limit == MAX_NUMNODES && node_mem_limit == ~0UL && mem_limit == ~0UL)
+#else
+	if (mem_limit == ~0UL)
+#endif
+		return;
+
+	dmazones = 0;
+	for_each_pgdat(pgdat) 
+		if (pgdat->node_zones[ZONE_DMA].spanned_pages) 
+			dmazones++;
+
+	for_each_pgdat(pgdat) {
+#ifdef	CONFIG_NUMA
+		if (node_limit != MAX_NUMNODES && pgdat->node_id >= node_limit) {
+			top = dma_zone_top(pgdat, &dmazones);
+			bootmem_memory_size(pgdat, &alloc, &total);
+			bootmem_memory_trim(pgdat, total - alloc, top);
+			do_trim_cpu(pgdat->node_id);
+			continue;
+		}
+#endif
+		if (mem_limit != ~0UL) {
+			unsigned long mem;
+
+			bootmem_memory_size(pgdat, &alloc, &total);
+			mem = total << PAGE_SHIFT;
+			if ((mem + total_mem) <= mem_limit) 
+				total_mem += mem;
+			else {
+				free = (mem + total_mem) - mem_limit;
+				total_mem = mem_limit;
+				top = dma_zone_top(pgdat, &dmazones);
+#ifdef	CONFIG_NUMA
+				if (free == mem) 
+					do_trim_cpu(pgdat->node_id);
+#endif
+				free >>= PAGE_SHIFT;
+				bootmem_memory_trim(pgdat, free, top);
+			}
+		}
+#ifdef	CONFIG_NUMA
+		else if (node_mem_limit != ~0UL) {
+			unsigned long mem;
+
+			bootmem_memory_size(pgdat, &alloc, &total);
+			mem = total << PAGE_SHIFT;
+
+			if (mem <= node_mem_limit)
+				continue;
+
+			top = dma_zone_top(pgdat, &dmazones);
+			free = (mem - node_mem_limit) >> PAGE_SHIFT;
+			bootmem_memory_trim(pgdat, free, top);
+		}
+#endif
+	}
+
+	return;
+}
+
 void __init free_area_init_node(int nid, struct pglist_data *pgdat,
 		struct page *node_mem_map, unsigned long *zones_size,
 		unsigned long node_start_pfn, unsigned long *zholes_size)
@@ -1397,6 +1534,7 @@
 
 void __init free_area_init(unsigned long *zones_size)
 {
+	pgdat_list = &contig_page_data;
 	free_area_init_node(0, &contig_page_data, NULL, zones_size,
 			__pa(PAGE_OFFSET) >> PAGE_SHIFT, NULL);
 	mem_map = contig_page_data.node_mem_map;
--- linux-2.6.4-orig/mm/bootmem.c	2004-03-10 21:55:24.000000000 -0500
+++ linux-2.6.4/mm/bootmem.c	2004-03-15 13:07:50.000000000 -0500
@@ -384,3 +384,51 @@
 	return NULL;
 }
 
+void __init bootmem_memory_size(pg_data_t *pgdat, unsigned long *alloc, unsigned long *total)
+{
+	unsigned long ralloc, i, idx, v, m, *map;
+	bootmem_data_t *bdata;
+
+	bdata = pgdat->bdata;
+	idx =  bdata->node_low_pfn - (bdata->node_boot_start >> PAGE_SHIFT);
+	*total = idx;
+	map = bdata->node_bootmem_map;
+	for (ralloc = 0, i = 0; i < idx; ) {
+		v = map[i / BITS_PER_LONG];
+		if (v) {
+			for (m = 1; m && i < idx; m <<=  1, i++) 
+				if (v & m)
+					ralloc++;
+		} else 
+			i += BITS_PER_LONG;
+	}
+
+	*alloc = ralloc;
+	return;
+}
+
+void __init bootmem_memory_trim(pg_data_t *pgdat, unsigned long trim, unsigned long top)
+{
+	unsigned long i, t, idx, v, m, *map;
+	bootmem_data_t *bdata;
+
+	bdata = pgdat->bdata;
+	idx =  bdata->node_low_pfn - (bdata->node_boot_start >> PAGE_SHIFT);
+	if (top != 0UL)
+		top -= (bdata->node_boot_start >> PAGE_SHIFT);
+	map = bdata->node_bootmem_map;
+	for (i = idx - 1, t = 0; t < trim && i != 0 && i >= top; ) {
+		v = ~map[i / BITS_PER_LONG];
+		if (v) {
+			for (m = 1UL << (i & (BITS_PER_LONG - 1)); 
+				m && i >= top && i != 0 && t < trim; m >>=  1, i--)
+				if (v & m) {
+					t++;
+					map[i / BITS_PER_LONG] |= m;
+				}
+		} else 
+			i -= min((unsigned long) BITS_PER_LONG, i);
+	}
+
+	return;
+} 
--- linux-2.6.4-orig/init/main.c	2004-03-10 21:55:23.000000000 -0500
+++ linux-2.6.4/init/main.c	2004-03-12 14:45:37.000000000 -0500
@@ -450,6 +450,7 @@
 	}
 #endif
 	page_address_init();
+	do_mem_limits();
 	mem_init();
 	kmem_cache_init();
 	if (late_time_init)
--- linux-2.6.4-orig/include/linux/mm.h	2004-03-10 21:55:21.000000000 -0500
+++ linux-2.6.4/include/linux/mm.h	2004-03-12 14:45:38.000000000 -0500
@@ -517,6 +517,7 @@
 	return pmd_offset(pgd, address);
 }
 
+extern void do_mem_limits(void);
 extern void free_area_init(unsigned long * zones_size);
 extern void free_area_init_node(int nid, pg_data_t *pgdat, struct page *pmap,
 	unsigned long * zones_size, unsigned long zone_start_pfn, 
--- linux-2.6.4-orig/include/linux/bootmem.h	2004-03-10 21:55:44.000000000 -0500
+++ linux-2.6.4/include/linux/bootmem.h	2004-03-12 14:45:38.000000000 -0500
@@ -58,6 +58,9 @@
 extern void __init free_bootmem_node (pg_data_t *pgdat, unsigned long addr, unsigned long size);
 extern unsigned long __init free_all_bootmem_node (pg_data_t *pgdat);
 extern void * __init __alloc_bootmem_node (pg_data_t *pgdat, unsigned long size, unsigned long align, unsigned long goal);
+extern void __init bootmem_memory_size(pg_data_t *pgdat, unsigned long *alloc, unsigned long *total);
+extern void __init bootmem_memory_trim(pg_data_t *pgdat, unsigned long trim, unsigned long top);
+
 #ifndef CONFIG_HAVE_ARCH_BOOTMEM_NODE
 #define alloc_bootmem_node(pgdat, x) \
 	__alloc_bootmem_node((pgdat), (x), SMP_CACHE_BYTES, __pa(MAX_DMA_ADDRESS))

