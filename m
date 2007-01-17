Return-Path: <linux-kernel-owner+w=401wt.eu-S1751156AbXAQNTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbXAQNTS (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 08:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbXAQNTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 08:19:18 -0500
Received: from smtp.cce.hp.com ([161.114.21.24]:10266 "EHLO
	ccerelrim03.cce.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156AbXAQNTQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 08:19:16 -0500
From: "Bob Picco" <bob.picco@hp.com>
Date: Wed, 17 Jan 2007 08:19:04 -0500
To: akpm@osdl.org
Cc: mel@csn.ul.ie, apw@shadowen.org, tony.luck@intel.com, ak@muc.de,
       bob.picco@hp.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] clean up sparsemem memory_present calls for ia64 and x86_64
Message-ID: <20070117131904.GB27728@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-PMX-Version: 5.2.1.279297, Antispam-Engine: 2.4.0.264935, Antispam-Data: 2007.1.17.50432
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Eliminate arch specific memory_present calls for ia64 NUMA and x86_64 NUMA by
utilizing sparse_memory_present_with_active_regions. It was boot tested
for both arches.
 
Acked-by: Mel Gorman <mel@csn.ul.ie>
Signed-off-by: Bob Picco <bob.picco@hp.com>

 arch/ia64/mm/discontig.c |   36 +++---------------------------------
 arch/x86_64/mm/numa.c    |   17 ++---------------
 2 files changed, 5 insertions(+), 48 deletions(-)

Index: linux-2.6.20-rc4/arch/ia64/mm/discontig.c
===================================================================
--- linux-2.6.20-rc4.orig/arch/ia64/mm/discontig.c	2007-01-11 12:11:54.000000000 -0500
+++ linux-2.6.20-rc4/arch/ia64/mm/discontig.c	2007-01-11 12:12:38.000000000 -0500
@@ -412,37 +412,6 @@ static void __init memory_less_nodes(voi
 	return;
 }
 
-#ifdef CONFIG_SPARSEMEM
-/**
- * register_sparse_mem - notify SPARSEMEM that this memory range exists.
- * @start: physical start of range
- * @end: physical end of range
- * @arg: unused
- *
- * Simply calls SPARSEMEM to register memory section(s).
- */
-static int __init register_sparse_mem(unsigned long start, unsigned long end,
-	void *arg)
-{
-	int nid;
-
-	start = __pa(start) >> PAGE_SHIFT;
-	end = __pa(end) >> PAGE_SHIFT;
-	nid = early_pfn_to_nid(start);
-	memory_present(nid, start, end);
-
-	return 0;
-}
-
-static void __init arch_sparse_init(void)
-{
-	efi_memmap_walk(register_sparse_mem, NULL);
-	sparse_init();
-}
-#else
-#define arch_sparse_init() do {} while (0)
-#endif
-
 /**
  * find_memory - walk the EFI memory map and setup the bootmem allocator
  *
@@ -688,10 +657,11 @@ void __init paging_init(void)
 
 	max_dma = virt_to_phys((void *) MAX_DMA_ADDRESS) >> PAGE_SHIFT;
 
-	arch_sparse_init();
-
 	efi_memmap_walk(filter_rsvd_memory, count_node_pages);
 
+	sparse_memory_present_with_active_regions(MAX_NUMNODES);
+	sparse_init();
+
 #ifdef CONFIG_VIRTUAL_MEM_MAP
 	vmalloc_end -= PAGE_ALIGN(ALIGN(max_low_pfn, MAX_ORDER_NR_PAGES) *
 		sizeof(struct page));
Index: linux-2.6.20-rc4/arch/x86_64/mm/numa.c
===================================================================
--- linux-2.6.20-rc4.orig/arch/x86_64/mm/numa.c	2007-01-11 12:11:08.000000000 -0500
+++ linux-2.6.20-rc4/arch/x86_64/mm/numa.c	2007-01-11 12:11:57.000000000 -0500
@@ -321,20 +321,6 @@ unsigned long __init numa_free_all_bootm
 	return pages;
 } 
 
-#ifdef CONFIG_SPARSEMEM
-static void __init arch_sparse_init(void)
-{
-	int i;
-
-	for_each_online_node(i)
-		memory_present(i, node_start_pfn(i), node_end_pfn(i));
-
-	sparse_init();
-}
-#else
-#define arch_sparse_init() do {} while (0)
-#endif
-
 void __init paging_init(void)
 { 
 	int i;
@@ -344,7 +330,8 @@ void __init paging_init(void)
 	max_zone_pfns[ZONE_DMA32] = MAX_DMA32_PFN;
 	max_zone_pfns[ZONE_NORMAL] = end_pfn;
 
-	arch_sparse_init();
+	sparse_memory_present_with_active_regions(MAX_NUMNODES);
+	sparse_init();
 
 	for_each_online_node(i) {
 		setup_node_zones(i); 
