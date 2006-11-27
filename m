Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758222AbWK0OIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758222AbWK0OIJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 09:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758224AbWK0OIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 09:08:09 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:41448 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1758222AbWK0OIH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 09:08:07 -0500
Date: Mon, 27 Nov 2006 14:08:05 +0000
To: akpm@osdl.org
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH] Add debugging aid for memory initialisation problems
Message-ID: <20061127140804.GA15405@skynet.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: mel@skynet.ie (Mel Gorman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A number of bug reports have been submitted related to memory initialisation
that would have been easier to debug if the PFN of page addresses were
available. The dmesg output is often insufficient to find that information
so debugging patches need to be sent to the reporting user.

This patch prints out information on the memmap when it is being allocated
and the sizeof(struct page) when loglevel is set high enough. In most
architectures, this output is produced in generic code. x86_64 and ia64 both
setup node_mem_map in an architecture-specific manner requiring arch-specfic
changes. Th memmap information can be used to translate any valid page
address into a PFN. page_to_pfn() cannot be used directly in bad_page()
because there is no guarantee that the address pointer is valid in any way
and the translation can produce garbage.

Information on memmap is not printed out for the SPARSEMEM memory model. This
only applies to FLATMEM and DISCONTIG configurations.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>

diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc6-mm1-clean/arch/ia64/mm/contig.c linux-2.6.19-rc6-mm1-debug_bootmem_init_issues/arch/ia64/mm/contig.c
--- linux-2.6.19-rc6-mm1-clean/arch/ia64/mm/contig.c	2006-11-27 10:49:10.000000000 +0000
+++ linux-2.6.19-rc6-mm1-debug_bootmem_init_issues/arch/ia64/mm/contig.c	2006-11-27 10:55:12.000000000 +0000
@@ -262,6 +262,9 @@ paging_init (void)
 		 */
 		NODE_DATA(0)->node_mem_map = vmem_map +
 			find_min_pfn_with_active_regions();
+		printk(KERN_DEBUG
+			"Node %d memmap at 0x%p size %lu first pfn 0x%p\n",
+			0, vmem_map, map_size, NODE_DATA(0)->node_mem_map);
 		free_area_init_nodes(max_zone_pfns);
 
 		printk("Virtual mem_map starts at 0x%p\n", mem_map);
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc6-mm1-clean/arch/ia64/mm/discontig.c linux-2.6.19-rc6-mm1-debug_bootmem_init_issues/arch/ia64/mm/discontig.c
--- linux-2.6.19-rc6-mm1-clean/arch/ia64/mm/discontig.c	2006-11-27 10:49:10.000000000 +0000
+++ linux-2.6.19-rc6-mm1-debug_bootmem_init_issues/arch/ia64/mm/discontig.c	2006-11-27 10:55:09.000000000 +0000
@@ -708,6 +708,9 @@ void __init paging_init(void)
 
 #ifdef CONFIG_VIRTUAL_MEM_MAP
 		NODE_DATA(node)->node_mem_map = vmem_map + pfn_offset;
+		printk(KERN_DEBUG
+			"Node %d memmap at 0x%p size %lu first pfn 0x%p\n",
+			node, vmem_map, 0, NODE_DATA(node)->node_mem_map);
 #endif
 		if (mem_data[node].max_pfn > max_pfn)
 			max_pfn = mem_data[node].max_pfn;
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc6-mm1-clean/arch/x86_64/mm/numa.c linux-2.6.19-rc6-mm1-debug_bootmem_init_issues/arch/x86_64/mm/numa.c
--- linux-2.6.19-rc6-mm1-clean/arch/x86_64/mm/numa.c	2006-11-27 10:49:10.000000000 +0000
+++ linux-2.6.19-rc6-mm1-debug_bootmem_init_issues/arch/x86_64/mm/numa.c	2006-11-27 10:51:36.000000000 +0000
@@ -158,6 +158,9 @@ void __init setup_node_zones(int nodeid)
 				memmapsize, SMP_CACHE_BYTES, 
 				round_down(limit - memmapsize, PAGE_SIZE), 
 				limit);
+	printk(KERN_DEBUG "Node %d memmap at 0x%p size %lu first pfn 0x%p\n",
+			nodeid, NODE_DATA(nodeid)->node_mem_map,
+			memmapsize, NODE_DATA(nodeid)->node_mem_map);
 #endif
 } 
 
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc6-mm1-clean/mm/page_alloc.c linux-2.6.19-rc6-mm1-debug_bootmem_init_issues/mm/page_alloc.c
--- linux-2.6.19-rc6-mm1-clean/mm/page_alloc.c	2006-11-27 10:49:13.000000000 +0000
+++ linux-2.6.19-rc6-mm1-debug_bootmem_init_issues/mm/page_alloc.c	2006-11-27 10:51:36.000000000 +0000
@@ -2808,6 +2808,9 @@ static void __init alloc_node_mem_map(st
 		if (!map)
 			map = alloc_bootmem_node(pgdat, size);
 		pgdat->node_mem_map = map + (pgdat->node_start_pfn - start);
+		printk(KERN_DEBUG
+			"Node %d memmap at 0x%p size %lu first pfn 0x%p\n",
+			pgdat->node_id, map, size, pgdat->node_mem_map);
 	}
 #ifdef CONFIG_FLATMEM
 	/*
@@ -3038,6 +3041,9 @@ void __init free_area_init_nodes(unsigne
 	/* Regions in the early_node_map can be in any order */
 	sort_node_map();
 
+	/* Print out the page size for debugging meminit problems */
+	printk(KERN_DEBUG "sizeof(struct page) = %d\n", sizeof(struct page));
+
 	/* Print out the zone ranges */
 	printk("Zone PFN ranges:\n");
 	for (i = 0; i < MAX_NR_ZONES; i++)
