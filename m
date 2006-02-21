Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932736AbWBUOwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932736AbWBUOwI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 09:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932737AbWBUOwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 09:52:08 -0500
Received: from [193.1.99.76] ([193.1.99.76]:52629 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932736AbWBUOwD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 09:52:03 -0500
Date: Tue, 21 Feb 2006 14:51:44 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH 4/7] ppc64 - Specify amount of kernel memory at boot time
In-Reply-To: <1140196618.21383.112.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0602211445160.4335@skynet.skynet.ie>
References: <20060217141552.7621.74444.sendpatchset@skynet.csn.ul.ie> 
 <20060217141712.7621.49906.sendpatchset@skynet.csn.ul.ie>
 <1140196618.21383.112.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Feb 2006, Dave Hansen wrote:

> On Fri, 2006-02-17 at 14:17 +0000, Mel Gorman wrote:
>> This patch adds the kernelcore= parameter for ppc64.
>>
>> The amount of memory will requested will not be reserved in all nodes. The
>> first node that is found that can accomodate the requested amount of memory
>> and have remaining more for ZONE_EASYRCLM is used. If a node has memory holes,
>> it also will not be used.
>
> One thing I think we really need to see before these go into mainline is
> the ability to shrink the ZONE_EASYRCLM at runtime, and give the memory
> back to NORMAL/DMA.
>
> Otherwise, any system starting off sufficiently small will end up having
> lowmem starvation issues.  Allowing resizing at least gives the admin a
> chance to avoid those issues.
>
>> +               if (core_mem_pfn == 0 ||
>> +                               end_pfn - start_pfn < core_mem_pfn ||
>> +                               end_pfn - start_pfn != pages_present) {
>> +                       zones_size[ZONE_DMA] = end_pfn - start_pfn;
>> +                       zones_size[ZONE_EASYRCLM] = 0;
>> +                       zholes_size[ZONE_DMA] =
>> +                               zones_size[ZONE_DMA] - pages_present;
>> +                       zholes_size[ZONE_EASYRCLM] = 0;
>> +                       if (core_mem_pfn >= pages_present)
>> +                               core_mem_pfn -= pages_present;
>> +               } else {
>> +                       zones_size[ZONE_DMA] = core_mem_pfn;
>> +                       zones_size[ZONE_EASYRCLM] = end_pfn - core_mem_pfn;
>> +                       zholes_size[ZONE_DMA] = 0;
>> +                       zholes_size[ZONE_EASYRCLM] = 0;
>> +                       core_mem_pfn = 0;
>> +               }
>
> I'm finding this bit of code really hard to parse.
>
> First of all, please give "core_mem_size" and "core_mem_pfn" some better
> names.  "core_mem_size" in _what_?  Bytes?  Pages?  g0ats? ;)
>
> The "pfn" in "core_mem_pfn" is usually used to denote a physical address
>>> PAGE_SHIFT.  However, yours is actually a _number_ of pages, not an
> address, right?  Actually, as I look at it closer, it appears to be a
> pfn in the else{} and a nr_page in the if{} block.
>
> core_mem_nr_pages or nr_core_mem_pages might be more appropriate.
>
> Users will _not_ care about memory holes.  They'll just want to specify
> a number of pages.  I think this:
>
>> +                       zones_size[ZONE_DMA] = core_mem_pfn;
>> +                       zones_size[ZONE_EASYRCLM] = end_pfn - core_mem_pfn;
>
> is probably bogus because it doesn't deal with holes at all.
>
> Walking those init_node_data() structures in get_region() is probably
> pretty darn fast, and we don't need to be careful about how many times
> we do it.  I think I'd probably separate out the problem a bit.
>
> 1. make get_region() not care about holes.  Have it just return the
>   range of the node's pages.
> 2. make a new function (get_region_holes()??) that, given a pfn range,
>   walks the init_node_data[] just like get_region() (have them share
>   code) and return the present_pages in that pfn range.
> 3. go back to paging init, and try to properly size ZONE_DMA.  Find
>   holes with your new function, and increase its size proportionately,
>   set zholes_size[ZONE_DMA] at this time.  Make sure the user size is
>   in nr_page, _NOT_ max_pfns.
> 4. give the rest of the space to ZONE_EASYRCLM.  Call your new function
>   to properly size its zone hole(s).
> 5. Profit!
>
> This may all belong broken out in a new function.
>

A new release of patches is a long time away but here is an early draft of 
what the above currently looks like. Is this more or less what you were 
thinking?

diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.16-rc3-mm1-103_x86coremem/arch/powerpc/mm/numa.c linux-2.6.16-rc3-mm1-104_ppc64coremem/arch/powerpc/mm/numa.c
--- linux-2.6.16-rc3-mm1-103_x86coremem/arch/powerpc/mm/numa.c	2006-02-16 09:50:42.000000000 +0000
+++ linux-2.6.16-rc3-mm1-104_ppc64coremem/arch/powerpc/mm/numa.c	2006-02-21 11:45:38.000000000 +0000
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

  		if (init_node_data[i].start_pfn < *start_pfn)
  			*start_pfn = init_node_data[i].start_pfn;

@@ -129,6 +150,108 @@ void __init get_region(unsigned int nid,
  		*start_pfn = 0;
  }

+/*
+ * Given a pfn range and the required number of pages for the kernel, return
+ * the zone of the DMA and EASYRCLM zones and any holes that are contained
+ */
+void __init get_zones_info(unsigned int nid,
+				unsigned long start_pfn,
+				unsigned long end_region_pfn,
+				unsigned long kernelcore_pages,
+				unsigned long *zones_size,
+				unsigned long *zholes_size)
+{
+	unsigned long end_kernelcore_pfn = 0;
+	unsigned long pages_present_kernel = 0;
+	unsigned long pages_present = 0;
+	unsigned int i;
+
+	dbg("get_zones_info: nid: %u kernelcore_pages: %lu range %lu -> %lu\n",
+			nid,
+			kernelcore_pages,
+			start_pfn,
+			end_region_pfn);
+
+	/* Handle the case where this region is totally empty */
+	if (end_region_pfn == start_pfn) {
+		dbg("get_zones_info: region is empty\n");
+		zones_size[ZONE_DMA] = 0;
+		zones_size[ZONE_EASYRCLM] = 0;
+		zholes_size[ZONE_DMA] = 0;
+		zholes_size[ZONE_EASYRCLM] = 0;
+		return;
+	}
+
+	/*
+	 * If kernelcore_pages were not required, make sure that this whole
+	 * region will be used for ZONE_DMA
+	 */
+	dbg("get_zones_info: kernelcore_pages = %lu\n", kernelcore_pages);
+	if (kernelcore_pages == 0) {
+		dbg("get_zones_info: kernel will use whole region\n");
+		kernelcore_pages = end_region_pfn - start_pfn;
+		end_kernelcore_pfn = end_region_pfn;
+	}
+
+	/*
+	 * Walk through node data to find a pfn where kernelcore_pages will
+	 * be in the range start_pfn -> kernelcore_pfn .
+	 */
+	for (i = 0; init_node_data[i].end_pfn; i++) {
+		unsigned long segment_start_pfn, segment_end_pfn;
+		unsigned long local_pages_present;
+
+		/*
+		 * If this segment does not contain pages in the required
+		 * pfn range, skip it
+		 */
+		if (init_node_data[i].nid != nid)
+			continue;
+		if (start_pfn >= init_node_data[i].end_pfn)
+			continue;
+		if (end_region_pfn <= init_node_data[i].start_pfn)
+			continue;
+
+		/* Find what portion of the segment is of interest */
+		segment_start_pfn = init_node_data[i].start_pfn;
+		segment_end_pfn = init_node_data[i].end_pfn;
+		if (segment_start_pfn < start_pfn)
+			segment_start_pfn = start_pfn;
+		if (segment_end_pfn > end_region_pfn)
+			segment_end_pfn = end_region_pfn;
+
+		/*
+		 * Update pages_present and see if we have reached the end
+		 * of the kernelcore portion of the region
+		 */
+		local_pages_present = segment_end_pfn - segment_start_pfn;
+		if (local_pages_present > kernelcore_pages) {
+			end_kernelcore_pfn =
+				segment_start_pfn + kernelcore_pages;
+			pages_present_kernel =
+				pages_present + kernelcore_pages;
+			kernelcore_pages = 0;
+		}
+
+		pages_present += local_pages_present;
+		if (kernelcore_pages) {
+			kernelcore_pages -= pages_present;
+			pages_present_kernel += pages_present;
+		}
+	}
+
+	/* Set the zones value */
+	dbg("get_zones_info: nid %d ZONE_DMA:      %lu -> %lu\n", nid,
+					start_pfn, end_kernelcore_pfn);
+	dbg("get_zones_info: nid %d ZONE_EASYRCLM: %lu -> %lu\n", nid,
+					end_kernelcore_pfn, end_region_pfn);
+	zones_size[ZONE_DMA] = end_kernelcore_pfn - start_pfn;
+	zholes_size[ZONE_DMA] = zones_size[ZONE_DMA] - pages_present_kernel;
+	zones_size[ZONE_EASYRCLM] = end_region_pfn - end_kernelcore_pfn;
+	zholes_size[ZONE_EASYRCLM] = zones_size[ZONE_EASYRCLM] -
+					(pages_present - pages_present_kernel);
+}
+
  static inline void map_cpu_to_node(int cpu, int node)
  {
  	numa_cpu_lookup_table[cpu] = node;
@@ -622,11 +745,11 @@ void __init do_init_bootmem(void)
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
@@ -721,21 +844,39 @@ void __init paging_init(void)
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
+	/* Check if ZONE_EASYRCLM should be populated */
+	opt = strstr(cmd_line, "kernelcore=");
+	if (opt) {
+		opt += 11;
+		unsigned long size_bytes = memparse(opt, &opt);
+		kernelcore_pages = size_bytes >> PAGE_SHIFT;
+	}

-		get_region(nid, &start_pfn, &end_pfn, &pages_present);
+	sort_regions();
+	for_each_online_node(nid) {
+		unsigned long start_pfn, end_region_pfn;

-		zones_size[ZONE_DMA] = end_pfn - start_pfn;
-		zholes_size[ZONE_DMA] = zones_size[ZONE_DMA] - pages_present;
+		get_region(nid, &start_pfn, &end_region_pfn);

-		dbg("free_area_init node %d %lx %lx (hole: %lx)\n", nid,
-		    zones_size[ZONE_DMA], start_pfn, zholes_size[ZONE_DMA]);
+		get_zones_info(nid, start_pfn, end_region_pfn,
+				kernelcore_pages,
+				&zones_size[0],
+				&zholes_size[0]);
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

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
