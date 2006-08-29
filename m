Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964837AbWH2KMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbWH2KMu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 06:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964875AbWH2KMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 06:12:50 -0400
Received: from smtp.cce.hp.com ([161.114.21.25]:49449 "EHLO
	ccerelrim04.cce.hp.com") by vger.kernel.org with ESMTP
	id S964837AbWH2KMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 06:12:49 -0400
From: "Bob Picco" <bob.picco@hp.com>
Date: Tue, 29 Aug 2006 06:12:47 -0400
To: akpm@osdl.org
Cc: mel@csn.ul.ie, tony.luck@intel.com, bob.picco@hp.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH] ia64 specific for Sizing zones and holes in an architecture independent
Message-ID: <20060829101247.GF10680@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-PMX-Version: 5.1.2.240295, Antispam-Engine: 2.3.0.1, Antispam-Data: 2006.8.29.25943
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew,

Mel's latest V9 regressed slightly for ia64 FLATMEM+VIRTUAL_MEM_MAP. When 
the largest hole is greater than LARGE_GAP, vmem_map is allocated before 
free_area_init_nodes; resultant crash follows. Rather than complicate
alloc_node_mem_map just for this ia64 case, add an adjustment to node_mem_map
which is later negated by alloc_node_mem_map.

Previous to V9, the mem_map adjustment was done in the scope where allocation
is achieved in alloc_node_mem_map. The current code is more appropriate but
unfortunately caused an issue for ia64.

Please add this to the next -mm.

thanks,

bob

Acked-by: Mel Gorman <mel@csn.ul.ie>
Signed-off-by: Bob Picco <bob.picco@hp.com>

 arch/ia64/mm/contig.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

Index: linux-2.6.18-rc4-mm3/arch/ia64/mm/contig.c
===================================================================
--- linux-2.6.18-rc4-mm3.orig/arch/ia64/mm/contig.c	2006-08-28 13:10:00.000000000 -0400
+++ linux-2.6.18-rc4-mm3/arch/ia64/mm/contig.c	2006-08-28 18:18:54.000000000 -0400
@@ -252,7 +252,12 @@ paging_init (void)
 		vmem_map = (struct page *) vmalloc_end;
 		efi_memmap_walk(create_mem_map_page_table, NULL);
 
-		NODE_DATA(0)->node_mem_map = vmem_map;
+		/*
+		 * alloc_node_mem_map makes an adjustment for mem_map
+		 * which isn't compatible with vmem_map.
+		 */
+		NODE_DATA(0)->node_mem_map = vmem_map +
+			find_min_pfn_with_active_regions();
 		free_area_init_nodes(max_zone_pfns);
 
 		printk("Virtual mem_map starts at 0x%p\n", mem_map);
