Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbWBVQoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbWBVQoR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 11:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWBVQoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 11:44:16 -0500
Received: from [193.1.99.76] ([193.1.99.76]:27307 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932257AbWBVQoQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 11:44:16 -0500
Date: Wed, 22 Feb 2006 16:43:57 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH 4/7] ppc64 - Specify amount of kernel memory at boot time
In-Reply-To: <1140543359.8693.32.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0602221625100.2801@skynet.skynet.ie>
References: <20060217141552.7621.74444.sendpatchset@skynet.csn.ul.ie> 
 <20060217141712.7621.49906.sendpatchset@skynet.csn.ul.ie> 
 <1140196618.21383.112.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0602211445160.4335@skynet.skynet.ie>
 <1140543359.8693.32.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Feb 2006, Dave Hansen wrote:

> On Tue, 2006-02-21 at 14:51 +0000, Mel Gorman wrote:
>> A new release of patches is a long time away but here is an early draft of
>> what the above currently looks like. Is this more or less what you were
>> thinking?
>
> I think it may be a bit harder to understand than even the other
> one.  :(
>

:/

> In a nutshell, get_zones_info() tries to do too much.  Six function
> arguments should be a big, red, warning light that something is really
> wrong.  Calling a function _info() is another bad sign.  It means that
> you can't discretely describe what it does.
>
> Remember, there are 3 distinct tasks here:
>
> 1. size the node information from init_node_data[]
> 2. size the easy reclaim zone based on the boot parameters
> 3. take holes into account when doing the reclaim zone sizing
>

right

*some pounding on the keyboard*

Is this a bit clearer? It's built and boot tested on one ppc64 machine. I 
am having trouble finding a ppc64 machine that *has* memory holes to be 
100% sure it's ok.

diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.16-rc3-mm1-103_x86coremem/arch/powerpc/mm/numa.c linux-2.6.16-rc3-mm1-104_ppc64coremem/arch/powerpc/mm/numa.c
--- linux-2.6.16-rc3-mm1-103_x86coremem/arch/powerpc/mm/numa.c	2006-02-16 09:50:42.000000000 +0000
+++ linux-2.6.16-rc3-mm1-104_ppc64coremem/arch/powerpc/mm/numa.c	2006-02-22 16:07:35.000000000 +0000
@@ -17,10 +17,12 @@
  #include <linux/nodemask.h>
  #include <linux/cpu.h>
  #include <linux/notifier.h>
+#include <linux/sort.h>
  #include <asm/sparsemem.h>
  #include <asm/lmb.h>
  #include <asm/system.h>
  #include <asm/smp.h>
+#include <asm/machdep.h>

  static int numa_enabled = 1;

@@ -101,22 +103,41 @@ void __init add_region(unsigned int nid,
  	init_node_data[i].nid = nid;
  }

+/* Compare two elements in init_node_data. Assume start_pfn is at start */
+static int cmp_init_node_data(const void *a, const void *b)
+{
+	return *(unsigned long *)a - *(unsigned long *)b;
+}
+
+/*
+ * init_node_data is not necessarilly in pfn order making it difficult to
+ * determine where the EasyRclm should begin if it is requested. This sorts
+ * init_node_data by start_pfn
+ */
+void __init sort_regions(void)
+{
+	size_t num = 0;
+	size_t size_element = sizeof(init_node_data) / MAX_REGIONS;
+
+	while (init_node_data[num].end_pfn)
+		num++;
+
+	sort(init_node_data, num, size_element, cmp_init_node_data, NULL);
+}
+
  /* We assume init_node_data has no overlapping regions */
  void __init get_region(unsigned int nid, unsigned long *start_pfn,
-		       unsigned long *end_pfn, unsigned long *pages_present)
+		       unsigned long *end_pfn)
  {
  	unsigned int i;

  	*start_pfn = -1UL;
-	*end_pfn = *pages_present = 0;
+	*end_pfn = 0;

  	for (i = 0; init_node_data[i].end_pfn; i++) {
  		if (init_node_data[i].nid != nid)
  			continue;

-		*pages_present += init_node_data[i].end_pfn -
-			init_node_data[i].start_pfn;
-
  		if (init_node_data[i].start_pfn < *start_pfn)
  			*start_pfn = init_node_data[i].start_pfn;

@@ -129,6 +150,88 @@ void __init get_region(unsigned int nid,
  		*start_pfn = 0;
  }

+/* Initialise the size of each zone in a node */
+void __init zone_sizes_init(unsigned int nid,
+		unsigned long kernelcore_pages,
+		unsigned long *zones_size)
+{
+	unsigned int i;
+	unsigned long pages_present = 0;
+
+	/* Get the number of present pages in the node */
+	for (i = 0; init_node_data[i].end_pfn; i++) {
+		if (init_node_data[i].nid != nid)
+			continue;
+
+		pages_present += init_node_data[i].end_pfn -
+			init_node_data[i].start_pfn;
+	}
+
+	if (kernelcore_pages && kernelcore_pages < pages_present) {
+		zones_size[ZONE_DMA] = kernelcore_pages;
+		zones_size[ZONE_EASYRCLM] = pages_present - kernelcore_pages;
+	} else {
+		zones_size[ZONE_DMA] = pages_present;
+		zones_size[ZONE_EASYRCLM] = 0;
+	}
+}
+
+void __init get_zholes_size(unsigned int nid, unsigned long *zones_size,
+		unsigned long *zholes_size) {
+	unsigned int i = 0;
+	unsigned int start_easyrclm_pfn;
+	unsigned long last_end_pfn, first;
+
+	/* Find where the PFN of the end of DMA is */
+	unsigned long pages_count = zones_size[ZONE_DMA];
+	for (i = 0; init_node_data[i].end_pfn; i++) {
+		unsigned long segment_size;
+		if (init_node_data[i].nid != nid)
+			continue;
+
+		/*
+		 * Check if the end of ZONE_DMA is in this segment of the
+		 * init_node_data
+		 */
+		segment_size = init_node_data[i].end_pfn -
+			init_node_data[i].start_pfn;
+		if (pages_count > segment_size) {
+			/* End of ZONE_DMA is not here, move on */
+			pages_count -= segment_size;
+			continue;
+		}
+
+		/* End of ZONE_DMA is here */
+		start_easyrclm_pfn = init_node_data[i].start_pfn + pages_count;
+		break;
+	}
+
+	/* Walk the map again and get the size of the holes */
+	first = 1;
+	zholes_size[ZONE_DMA] = 0;
+	zholes_size[ZONE_EASYRCLM] = 0;
+	for (i = 1; init_node_data[i].end_pfn; i++) {
+		unsigned long hole_size;
+		if (init_node_data[i].nid != nid)
+			continue;
+
+		if (first) {
+			last_end_pfn = init_node_data[i].end_pfn;
+			first = 0;
+			continue;
+		}
+
+		/* Hole found */
+		hole_size = init_node_data[i].start_pfn - last_end_pfn;
+		if (init_node_data[i].start_pfn < start_easyrclm_pfn) {
+			zholes_size[ZONE_DMA] += hole_size;
+		} else {
+			zholes_size[ZONE_EASYRCLM] += hole_size;
+		}
+		last_end_pfn = init_node_data[i].end_pfn;
+	}
+}
+
  static inline void map_cpu_to_node(int cpu, int node)
  {
  	numa_cpu_lookup_table[cpu] = node;
@@ -622,11 +725,11 @@ void __init do_init_bootmem(void)
  	register_cpu_notifier(&ppc64_numa_nb);

  	for_each_online_node(nid) {
-		unsigned long start_pfn, end_pfn, pages_present;
+		unsigned long start_pfn, end_pfn;
  		unsigned long bootmem_paddr;
  		unsigned long bootmap_pages;

-		get_region(nid, &start_pfn, &end_pfn, &pages_present);
+		get_region(nid, &start_pfn, &end_pfn);

  		/* Allocate the node structure node local if possible */
  		NODE_DATA(nid) = careful_allocation(nid,
@@ -721,21 +824,36 @@ void __init paging_init(void)
  {
  	unsigned long zones_size[MAX_NR_ZONES];
  	unsigned long zholes_size[MAX_NR_ZONES];
+	unsigned long kernelcore_pages = 0;
  	int nid;
+	char *opt;

  	memset(zones_size, 0, sizeof(zones_size));
  	memset(zholes_size, 0, sizeof(zholes_size));

-	for_each_online_node(nid) {
-		unsigned long start_pfn, end_pfn, pages_present;
-
-		get_region(nid, &start_pfn, &end_pfn, &pages_present);
+	/* Check if ZONE_EASYRCLM should be populated */
+	opt = strstr(cmd_line, "kernelcore=");
+	if (opt) {
+		opt += 11;
+		unsigned long size_bytes = memparse(opt, &opt);
+		kernelcore_pages = size_bytes >> PAGE_SHIFT;
+	}

-		zones_size[ZONE_DMA] = end_pfn - start_pfn;
-		zholes_size[ZONE_DMA] = zones_size[ZONE_DMA] - pages_present;
+	sort_regions();
+	for_each_online_node(nid) {
+		unsigned long start_pfn, end_region_pfn;

-		dbg("free_area_init node %d %lx %lx (hole: %lx)\n", nid,
-		    zones_size[ZONE_DMA], start_pfn, zholes_size[ZONE_DMA]);
+		get_region(nid, &start_pfn, &end_region_pfn);
+		zone_sizes_init(nid, kernelcore_pages, &zones_size[0]);
+		get_zholes_size(nid, &zones_size[0], &zholes_size[0]);
+
+		dbg("free_area_init DMA      node %d %lx %lx (hole: %lx)\n",
+		    nid, zones_size[ZONE_DMA],
+		    start_pfn, zholes_size[ZONE_DMA]);
+
+		dbg("free_area_init EasyRclm node %d %lx %lx (hole: %lx)\n",
+		    nid, zones_size[ZONE_EASYRCLM],
+		    start_pfn, zholes_size[ZONE_EASYRCLM]);

  		free_area_init_node(nid, NODE_DATA(nid), zones_size, start_pfn,
  				    zholes_size);
