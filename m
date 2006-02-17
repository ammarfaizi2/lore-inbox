Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751428AbWBQOSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbWBQOSk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 09:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbWBQOSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 09:18:40 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:24798 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751428AbWBQOSi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 09:18:38 -0500
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Message-Id: <20060217141732.7621.56133.sendpatchset@skynet.csn.ul.ie>
In-Reply-To: <20060217141552.7621.74444.sendpatchset@skynet.csn.ul.ie>
References: <20060217141552.7621.74444.sendpatchset@skynet.csn.ul.ie>
Subject: [PATCH 5/7] At boot, determine what zone memory will hot-add to
Date: Fri, 17 Feb 2006 14:17:32 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Once ZONE_EASYRCLM is added, the x86 by default adds to ZONE_EASYRCLM and
ppc64 by default uses ZONE_DMA. This patch changes the behavior slightly on
x86 and ppc64.

o By default, ZONE_DMA is used on ppc64 and ZONE_HIGHMEM is used on x86
o If kernelcore is specified at boot time, x86 and ppc64 hotadd to ZONE_EASYRCLM
o If kernelcore and noeasyrclm is used, ppc64 will use ZONE_DMA and x86 will
  use ZONE_HIGHMEM

This is a list of scenarios and what happens with different options on an
x86 with 1.5GiB of physical RAM. ./activate is a script that tries to online
all inactive physical memory.

Boot with no special parameters
  - ./activate does nothing
  - All high memory in HIGHMEM

Boot with mem=512MB
  - Machine boots with 512MB active RAM
  - ./activate adds memory to ZONE_HIGHMEM
  - No memory in ZONE_EASYRCLM
 
Boot with kernelcore=512MB
  - Machine boots with 1.5GiB RAM
  - ./activate does nothing
  - No memory in HIGHMEM
  - Some of what would be NORMAL and all of HIGHMEM is in EASYRCLM

Boot with kernelcore=512MB mem=512MB
  - Machine boots with 512MB RAM
  - ./activate adds memory to ZONE_EASYRCLM
  - No memory in HIGHMEM
  
Boot with kernelcore=512MB mem=512MB noeasyrclm
  - Machine boots with 512MB RAM
  - ./activate adds memory to ZONE_EASYRCLM
  - No memory in HIGHMEM
  - With noeasyrclm, this is identical to booting with just mem=512MB

Boot with kernelcore=1024MB mem=1024MB
  - Machine boots with 1024MB RAM
  - Some memory already in ZONE_HIGHMEM
  - ./activate adds memory to ZONE_EASYRCLM

Boot with kernelcore=1024MB mem=1024MB noeasyrclm
  - Machine boots with 1024MB RAM
  - Some memory already in ZONE_EASYRCLM
  - ./activate adds memory to ZONE_HIGHMEM

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.16-rc3-mm1-104_ppc64coremem/arch/i386/kernel/setup.c linux-2.6.16-rc3-mm1-106_zonechoose/arch/i386/kernel/setup.c
--- linux-2.6.16-rc3-mm1-104_ppc64coremem/arch/i386/kernel/setup.c	2006-02-17 09:42:45.000000000 +0000
+++ linux-2.6.16-rc3-mm1-106_zonechoose/arch/i386/kernel/setup.c	2006-02-17 09:44:16.000000000 +0000
@@ -115,6 +115,8 @@ static unsigned int highmem_pages = -1;
 /* user-defined easy-reclaim-size */
 static unsigned int core_mem_pages = -1;
 static unsigned int easyrclm_pages = 0;
+static int hotadd_zone_offset = -1;
+
 /*
  * Setup options
  */
@@ -923,6 +925,18 @@ static void __init parse_cmdline_early (
 		  */
 		else if (!memcmp(from, "kernelcore=",11)) {
 			core_mem_pages = memparse(from+11, &from) >> PAGE_SHIFT;
+
+			if (hotadd_zone_offset == -1)
+				hotadd_zone_offset = ZONE_EASYRCLM;
+		}
+
+		/*
+		 * Once kernelcore= is specified, the default zone to add to
+		 * is ZONE_EASYRCLM. This parameter allows an administrator
+		 * to override that
+		 */
+		else if (!memcmp(from, "noeasyrclm", 10)) {
+			hotadd_zone_offset = ZONE_HIGHMEM;
 		}
 
 	next_char:
@@ -1550,6 +1564,13 @@ void __init setup_arch(char **cmdline_p)
 	tsc_init();
 }
 
+struct zone *get_zone_for_hotadd(struct pglist_data *pgdata) {
+	if (unlikely(hotadd_zone_offset == -1))
+		hotadd_zone_offset = ZONE_HIGHMEM;
+
+	return &pgdata->node_zones[hotadd_zone_offset];
+}
+
 #include "setup_arch_post.h"
 /*
  * Local Variables:
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.16-rc3-mm1-104_ppc64coremem/arch/i386/mm/init.c linux-2.6.16-rc3-mm1-106_zonechoose/arch/i386/mm/init.c
--- linux-2.6.16-rc3-mm1-104_ppc64coremem/arch/i386/mm/init.c	2006-02-16 09:50:41.000000000 +0000
+++ linux-2.6.16-rc3-mm1-106_zonechoose/arch/i386/mm/init.c	2006-02-17 09:44:16.000000000 +0000
@@ -655,7 +655,7 @@ void __init mem_init(void)
 int add_memory(u64 start, u64 size)
 {
 	struct pglist_data *pgdata = &contig_page_data;
-	struct zone *zone = pgdata->node_zones + MAX_NR_ZONES-1;
+	struct zone *zone = get_zone_for_hotadd(pgdata);
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
 
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.16-rc3-mm1-104_ppc64coremem/arch/powerpc/mm/mem.c linux-2.6.16-rc3-mm1-106_zonechoose/arch/powerpc/mm/mem.c
--- linux-2.6.16-rc3-mm1-104_ppc64coremem/arch/powerpc/mm/mem.c	2006-02-16 09:50:42.000000000 +0000
+++ linux-2.6.16-rc3-mm1-106_zonechoose/arch/powerpc/mm/mem.c	2006-02-17 09:44:16.000000000 +0000
@@ -129,7 +129,7 @@ int __devinit add_memory(u64 start, u64 
 	create_section_mapping(start, start + size);
 
 	/* this should work for most non-highmem platforms */
-	zone = pgdata->node_zones;
+	zone = get_zone_for_hotadd(pgdata);
 
 	return __add_pages(zone, start_pfn, nr_pages);
 
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.16-rc3-mm1-104_ppc64coremem/arch/powerpc/mm/numa.c linux-2.6.16-rc3-mm1-106_zonechoose/arch/powerpc/mm/numa.c
--- linux-2.6.16-rc3-mm1-104_ppc64coremem/arch/powerpc/mm/numa.c	2006-02-17 09:43:30.000000000 +0000
+++ linux-2.6.16-rc3-mm1-106_zonechoose/arch/powerpc/mm/numa.c	2006-02-17 09:44:16.000000000 +0000
@@ -39,6 +39,7 @@ EXPORT_SYMBOL(node_data);
 static bootmem_data_t __initdata plat_node_bdata[MAX_NUMNODES];
 static int min_common_depth;
 static int n_mem_addr_cells, n_mem_size_cells;
+static int hotadd_zone_offset = -1;
 
 /*
  * We need somewhere to store start/end/node for each region until we have
@@ -736,6 +737,13 @@ void __init paging_init(void)
 		opt += 11;
 		core_mem_size = memparse(opt, &opt);
 		core_mem_pfn = core_mem_size >> PAGE_SHIFT;
+		hotadd_zone_offset = ZONE_EASYRCLM;
+	}
+
+	/* Check if the administrator requests only ZONE_DMA be used */
+	opt = strstr(cmd_line, "noeasyrclm");
+	if (opt) {
+		hotadd_zone_offset = ZONE_DMA;
 	}
 
 	for_each_online_node(nid) {
@@ -847,4 +855,12 @@ got_numa_domain:
 	}
 	return numa_domain;
 }
+
+struct zone *get_zone_for_hotadd(struct pglist_data *pgdata)
+{
+	if (unlikely(hotadd_zone_offset == -1))
+		hotadd_zone_offset = ZONE_DMA;
+
+	return &pgdata->node_zones[hotadd_zone_offset];
+}
 #endif /* CONFIG_MEMORY_HOTPLUG */
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.16-rc3-mm1-104_ppc64coremem/include/linux/memory_hotplug.h linux-2.6.16-rc3-mm1-106_zonechoose/include/linux/memory_hotplug.h
--- linux-2.6.16-rc3-mm1-104_ppc64coremem/include/linux/memory_hotplug.h	2006-02-13 00:27:25.000000000 +0000
+++ linux-2.6.16-rc3-mm1-106_zonechoose/include/linux/memory_hotplug.h	2006-02-17 09:44:16.000000000 +0000
@@ -57,6 +57,7 @@ extern void online_page(struct page *pag
 extern int add_memory(u64 start, u64 size);
 extern int remove_memory(u64 start, u64 size);
 extern int online_pages(unsigned long, unsigned long);
+extern struct zone *get_zone_for_hotadd(struct pglist_data *);
 
 /* reasonably generic interface to expand the physical pages in a zone  */
 extern int __add_pages(struct zone *zone, unsigned long start_pfn,
