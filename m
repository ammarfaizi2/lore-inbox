Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267909AbUHES71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267909AbUHES71 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 14:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267895AbUHES70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 14:59:26 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:53635 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S267918AbUHES5Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 14:57:24 -0400
Subject: Re: [PATCH] don't pass mem_map into init functions
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jesse Barnes <jbarnes@engr.sgi.com>
In-Reply-To: <20040804214250.2de3dd81.akpm@osdl.org>
References: <1091581282.27397.6676.camel@nighthawk>
	 <20040804214250.2de3dd81.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-aaMo2SLKu56+eXl1r3FD"
Message-Id: <1091732146.31490.161.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 05 Aug 2004 11:55:46 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-aaMo2SLKu56+eXl1r3FD
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2004-08-04 at 21:42, Andrew Morton wrote: 
> You wanna take a shot at fixing this up please?
> 
> arch/sparc64/mm/init.c: In function `paging_init':
> arch/sparc64/mm/init.c:1589: warning: passing arg 4 of `free_area_init_node' makes integer from pointer without a cast
> arch/sparc64/mm/init.c:1589: warning: passing arg 5 of `free_area_init_node' makes pointer from integer without a cast
> arch/sparc64/mm/init.c:1589: error: too many arguments to function `free_area_init_node'

Looks like I missed a couple of architectures.  This patch, on top of my
previous one and Jesse's should clean up the rest.

-- Dave

--=-aaMo2SLKu56+eXl1r3FD
Content-Disposition: attachment; filename=B2-init-no-mem_map-morearches.patch
Content-Type: text/x-patch; name=B2-init-no-mem_map-morearches.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit




---

 memhotplug-dave/arch/arm/mm/init.c               |    2 +-
 memhotplug-dave/arch/ia64/mm/contig.c            |    2 +-
 memhotplug-dave/arch/mips/sgi-ip27/ip27-memory.c |    2 +-
 memhotplug-dave/arch/parisc/mm/init.c            |    2 +-
 memhotplug-dave/arch/sparc/mm/srmmu.c            |    2 +-
 memhotplug-dave/arch/sparc/mm/sun4c.c            |    2 +-
 memhotplug-dave/arch/sparc64/mm/init.c           |    2 +-
 memhotplug-dave/arch/x86_64/mm/numa.c            |    2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff -puN arch/arm/mm/init.c~B2-init-no-mem_map-morearches arch/arm/mm/init.c
--- memhotplug/arch/arm/mm/init.c~B2-init-no-mem_map-morearches	Thu Aug  5 09:41:06 2004
+++ memhotplug-dave/arch/arm/mm/init.c	Thu Aug  5 09:41:06 2004
@@ -502,7 +502,7 @@ void __init paging_init(struct meminfo *
 		 */
 		arch_adjust_zones(node, zone_size, zhole_size);
 
-		free_area_init_node(node, pgdat, NULL, zone_size,
+		free_area_init_node(node, pgdat, zone_size,
 				bdata->node_boot_start >> PAGE_SHIFT, zhole_size);
 	}
 
diff -puN arch/ia64/mm/contig.c~B2-init-no-mem_map-morearches arch/ia64/mm/contig.c
--- memhotplug/arch/ia64/mm/contig.c~B2-init-no-mem_map-morearches	Thu Aug  5 09:41:06 2004
+++ memhotplug-dave/arch/ia64/mm/contig.c	Thu Aug  5 09:41:06 2004
@@ -267,7 +267,7 @@ paging_init (void)
 	efi_memmap_walk(find_largest_hole, (u64 *)&max_gap);
 	if (max_gap < LARGE_GAP) {
 		vmem_map = (struct page *) 0;
-		free_area_init_node(0, &contig_page_data, NULL, zones_size, 0,
+		free_area_init_node(0, &contig_page_data, zones_size, 0,
 				    zholes_size);
 		mem_map = contig_page_data.node_mem_map;
 	} else {
diff -puN arch/mips/sgi-ip27/ip27-memory.c~B2-init-no-mem_map-morearches arch/mips/sgi-ip27/ip27-memory.c
--- memhotplug/arch/mips/sgi-ip27/ip27-memory.c~B2-init-no-mem_map-morearches	Thu Aug  5 09:41:06 2004
+++ memhotplug-dave/arch/mips/sgi-ip27/ip27-memory.c	Thu Aug  5 09:41:06 2004
@@ -225,7 +225,7 @@ void __init paging_init(void)
 		pfn_t end_pfn = node_getmaxclick(node) + 1;
 
 		zones_size[ZONE_DMA] = end_pfn - start_pfn;
-		free_area_init_node(node, NODE_DATA(node), NULL,
+		free_area_init_node(node, NODE_DATA(node),
 				zones_size, start_pfn, NULL);
 
 		if (end_pfn > max_low_pfn)
diff -puN arch/parisc/mm/init.c~B2-init-no-mem_map-morearches arch/parisc/mm/init.c
--- memhotplug/arch/parisc/mm/init.c~B2-init-no-mem_map-morearches	Thu Aug  5 09:41:06 2004
+++ memhotplug-dave/arch/parisc/mm/init.c	Thu Aug  5 09:41:06 2004
@@ -761,7 +761,7 @@ void __init paging_init(void)
 		unsigned long zones_size[MAX_NR_ZONES] = { 0, 0, 0, };
 
 		zones_size[ZONE_DMA] = pmem_ranges[i].pages;
-		free_area_init_node(i,NODE_DATA(i),NULL,zones_size,
+		free_area_init_node(i,NODE_DATA(i),zones_size,
 				(pmem_ranges[i].start_pfn << PAGE_SHIFT),0);
 	}
 
diff -puN arch/sparc/mm/srmmu.c~B2-init-no-mem_map-morearches arch/sparc/mm/srmmu.c
--- memhotplug/arch/sparc/mm/srmmu.c~B2-init-no-mem_map-morearches	Thu Aug  5 09:41:06 2004
+++ memhotplug-dave/arch/sparc/mm/srmmu.c	Thu Aug  5 09:41:06 2004
@@ -1341,7 +1341,7 @@ void __init srmmu_paging_init(void)
 		zones_size[ZONE_HIGHMEM] = npages;
 		zholes_size[ZONE_HIGHMEM] = npages - calc_highpages();
 
-		free_area_init_node(0, &contig_page_data, NULL, zones_size,
+		free_area_init_node(0, &contig_page_data, zones_size,
 				    pfn_base, zholes_size);
 		mem_map = contig_page_data.node_mem_map;
 	}
diff -puN arch/sparc/mm/sun4c.c~B2-init-no-mem_map-morearches arch/sparc/mm/sun4c.c
--- memhotplug/arch/sparc/mm/sun4c.c~B2-init-no-mem_map-morearches	Thu Aug  5 09:41:06 2004
+++ memhotplug-dave/arch/sparc/mm/sun4c.c	Thu Aug  5 09:41:06 2004
@@ -2114,7 +2114,7 @@ void __init sun4c_paging_init(void)
 		zones_size[ZONE_HIGHMEM] = npages;
 		zholes_size[ZONE_HIGHMEM] = npages - calc_highpages();
 
-		free_area_init_node(0, &contig_page_data, NULL, zones_size,
+		free_area_init_node(0, &contig_page_data, zones_size,
 				    pfn_base, zholes_size);
 		mem_map = contig_page_data.node_mem_map;
 	}
diff -puN arch/sparc64/mm/init.c~B2-init-no-mem_map-morearches arch/sparc64/mm/init.c
--- memhotplug/arch/sparc64/mm/init.c~B2-init-no-mem_map-morearches	Thu Aug  5 09:41:06 2004
+++ memhotplug-dave/arch/sparc64/mm/init.c	Thu Aug  5 09:41:06 2004
@@ -1585,7 +1585,7 @@ void __init paging_init(void)
 		zones_size[ZONE_DMA] = npages;
 		zholes_size[ZONE_DMA] = npages - pages_avail;
 
-		free_area_init_node(0, &contig_page_data, NULL, zones_size,
+		free_area_init_node(0, &contig_page_data, zones_size,
 				    phys_base >> PAGE_SHIFT, zholes_size);
 		mem_map = contig_page_data.node_mem_map;
 	}
diff -puN arch/x86_64/mm/numa.c~B2-init-no-mem_map-morearches arch/x86_64/mm/numa.c
--- memhotplug/arch/x86_64/mm/numa.c~B2-init-no-mem_map-morearches	Thu Aug  5 09:41:06 2004
+++ memhotplug-dave/arch/x86_64/mm/numa.c	Thu Aug  5 09:41:06 2004
@@ -136,7 +136,7 @@ void __init setup_node_zones(int nodeid)
 		zones[ZONE_NORMAL] = end_pfn - start_pfn; 
 	} 
     
-	free_area_init_node(nodeid, NODE_DATA(nodeid), NULL, zones, 
+	free_area_init_node(nodeid, NODE_DATA(nodeid), zones,
 			    start_pfn, NULL); 
 } 
 

_

--=-aaMo2SLKu56+eXl1r3FD--

