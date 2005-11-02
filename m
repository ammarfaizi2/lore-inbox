Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965078AbVKBPLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965078AbVKBPLb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 10:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965076AbVKBPLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 10:11:31 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:41138 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S965074AbVKBPLa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 10:11:30 -0500
Date: Wed, 2 Nov 2005 15:11:19 +0000
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Joel Schopp <jschopp@austin.ibm.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net, Ingo Molnar <mingo@elte.hu>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Message-ID: <20051102151119.GA16174@skynet.ie>
References: <20051030235440.6938a0e9.akpm@osdl.org> <27700000.1130769270@[10.10.2.4]> <4366A8D1.7020507@yahoo.com.au> <Pine.LNX.4.58.0510312333240.29390@skynet> <4366C559.5090504@yahoo.com.au> <Pine.LNX.4.58.0511010137020.29390@skynet> <4366D469.2010202@yahoo.com.au> <4367D71A.1030208@austin.ibm.com> <43681100.1000603@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <43681100.1000603@yahoo.com.au>
User-Agent: Mutt/1.5.6+20040907i
From: mel@csn.ul.ie (Mel Gorman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/11/05 12:06), Nick Piggin didst pronounce:
> Joel Schopp wrote:
> 
> >The patches do ad a reasonable amount of complexity to the page 
> >allocator.  In my opinion that is the only downside of these patches, 
> >even though it is a big one.  What we need to decide as a community is 
> >if there is a less complex way to do this, and if there isn't a less 
> >complex way then is the benefit worth the increased complexity.
> >
> >As to the non-zero performance cost, I think hard numbers should carry 
> >more weight than they have been given in this area.  Mel has posted hard 
> >numbers that say the patches are a wash with respect to performance.  I 
> >don't see any evidence to contradict those results.
> >
> 
> The numbers I have seen show that performance is decreased. People
> like Ken Chen spend months trying to find a 0.05% improvement in
> performance. Not long ago I just spent days getting our cached
> kbuild performance back to where 2.4 is on my build system.
> 

One contention point is the overhead this introduces. Lets say that
we do discover that kbuild is slower with this patch (still unknown),
then we have to get rid of mbuddy, disable it or replace it with an
as-yet-to-be-written-zone-based-approach.

I wrote a quick patch that disables anti-defrag via a config option and ran
aim9 on the test machine I have been using all along. I deliberatly changed
the minimum amount of anti-defrag as possible but maybe we could make this
patch even smaller or go the other way and conditionally take out as much
anti-defrag as possible.

Here are the Aim9 comparisons between -clean and
-mbuddy-v19-antidefrag-disabled-with-config-option (just the one run)

These are both based on 2.6.14-rc5-mm1

                vanilla-mm  mbuddy-disabled-via-config
1 creat-clo      16006.00   15844.72    -161.28 -1.01% File Creations and Closes/second
2 page_test     117515.83  119696.77    2180.94  1.86% System Allocations & Pages/second
3 brk_test      440289.81  439870.04    -419.77 -0.10% System Memory Allocations/second
4 jmp_test     4179466.67 4179150.00    -316.67 -0.01% Non-local gotos/second
5 signal_test    80803.20   82055.98    1252.78  1.55% Signal Traps/second
6 exec_test         61.75      61.53      -0.22 -0.36% Program Loads/second
7 fork_test       1327.01    1344.55      17.54  1.32% Task Creations/second
8 link_test       5531.53    5548.33      16.80  0.30% Link/Unlink Pairs/second

On this kernel, I forgot to disable the collection of buddy allocator
statistics. Collection introduces more overhead in both CPU and memory.
Here are the figures when statistic collection is also disabled via the
config option.

		vanilla-mm mbuddy-disabled-via-config-nostats
 1 creat-clo      16006.00   15906.06     -99.94 -0.62% File Creations and Closes/second
 2 page_test     117515.83  120736.54    3220.71  2.74% System Allocations & Pages/second
 3 brk_test      440289.81  430311.61   -9978.20 -2.27% System Memory Allocations/second
 4 jmp_test     4179466.67 4181683.33    2216.66  0.05% Non-local gotos/second
 5 signal_test    80803.20   87387.54    6584.34  8.15% Signal Traps/second
 6 exec_test         61.75      62.14       0.39  0.63% Program Loads/second
 7 fork_test       1327.01    1345.77      18.76  1.41% Task Creations/second
 8 link_test       5531.53    5556.72      25.19  0.46% Link/Unlink Pairs/second

So, now we have performance gains in a number of areas. Nice big jump in
page_test and that fork_test improvement probably won't hurt kbuild either with
exec_test giving a bit of a nudge. signal_test has a big hike for some reason,
not sure who will benefit there, but hey, it can't be bad. I am annoyed with
brk_test especially as it is very similar to page_test in the aim9 source
code but there is no point hiding the result either. These figures does not
tell us how kbuild really performs of course. For that, kbuild needs to be run
on both kernels and compared. This applies to any workload.

This anti-defrag makes the code more complex and harder to read, no
arguement there. However, on at least one test machine, there is a very small
difference when anti-defrag is enabled in comparison to a vanilla kernel.
When the patches applied and the anti-defrag disabled via a kernel option,
we see a number of performance gains, on one machine at least which is a
good thing. Wider testing would show if these good figures are specific to
my testbed or not.

If other testbeds show up nothing bad, anti-defrag with this additional
patch could give us the best of both worlds. If you have a hotplug machine
or you care about high orders, enable this option. Otherwise, choose N and
avoid the anti-defrag overhead.

diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc5-mm1-mbuddy-v19-noconfig/include/linux/gfp.h linux-2.6.14-rc5-mm1-mbuddy-v19-withconfig/include/linux/gfp.h
--- linux-2.6.14-rc5-mm1-mbuddy-v19-noconfig/include/linux/gfp.h	2005-11-02 12:44:06.000000000 +0000
+++ linux-2.6.14-rc5-mm1-mbuddy-v19-withconfig/include/linux/gfp.h	2005-11-02 12:49:24.000000000 +0000
@@ -50,6 +50,7 @@ struct vm_area_struct;
 #define __GFP_HARDWALL   0x40000u /* Enforce hardwall cpuset memory allocs */
 #define __GFP_VALID	0x80000000u /* valid GFP flags */
 
+#ifdef CONFIG_PAGEALLOC_ANTIDEFRAG
 /*
  * Allocation type modifiers, these are required to be adjacent
  * __GFP_EASYRCLM: Easily reclaimed pages like userspace or buffer pages
@@ -61,6 +62,11 @@ struct vm_area_struct;
 #define __GFP_EASYRCLM   0x80000u  /* User and other easily reclaimed pages */
 #define __GFP_KERNRCLM   0x100000u /* Kernel page that is reclaimable */
 #define __GFP_RCLM_BITS  (__GFP_EASYRCLM|__GFP_KERNRCLM)
+#else
+#define __GFP_EASYRCLM   0
+#define __GFP_KERNRCLM   0
+#define __GFP_RCLM_BITS  0
+#endif /* CONFIG_PAGEALLOC_ANTIDEFRAG */
 
 #define __GFP_BITS_SHIFT 21	/* Room for 21 __GFP_FOO bits */
 #define __GFP_BITS_MASK ((1 << __GFP_BITS_SHIFT) - 1)
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc5-mm1-mbuddy-v19-noconfig/include/linux/mmzone.h linux-2.6.14-rc5-mm1-mbuddy-v19-withconfig/include/linux/mmzone.h
--- linux-2.6.14-rc5-mm1-mbuddy-v19-noconfig/include/linux/mmzone.h	2005-11-02 12:44:07.000000000 +0000
+++ linux-2.6.14-rc5-mm1-mbuddy-v19-withconfig/include/linux/mmzone.h	2005-11-02 13:00:56.000000000 +0000
@@ -23,6 +23,7 @@
 #endif
 #define PAGES_PER_MAXORDER (1 << (MAX_ORDER-1))
 
+#ifdef CONFIG_PAGEALLOC_ANTIDEFRAG
 /*
  * The two bit field __GFP_RECLAIMBITS enumerates the following types of
  * page reclaimability.
@@ -33,6 +34,14 @@
 #define RCLM_FALLBACK 3
 #define RCLM_TYPES    4
 #define BITS_PER_RCLM_TYPE 2
+#else
+#define RCLM_NORCLM   0
+#define RCLM_EASY     0
+#define RCLM_KERN     0
+#define RCLM_FALLBACK 0
+#define RCLM_TYPES    1
+#define BITS_PER_RCLM_TYPE 0
+#endif
 
 #define for_each_rclmtype_order(type, order) \
 	for (order = 0; order < MAX_ORDER; order++) \
@@ -60,6 +69,7 @@ struct zone_padding {
 #define ZONE_PADDING(name)
 #endif
 
+#ifdef CONFIG_PAGEALLOC_ANTIDEFRAG
 /*
  * Indices into pcpu_list
  * PCPU_KERNEL: For RCLM_NORCLM and RCLM_KERN allocations
@@ -68,6 +78,11 @@ struct zone_padding {
 #define PCPU_KERNEL 0
 #define PCPU_EASY   1
 #define PCPU_TYPES  2
+#else
+#define PCPU_KERNEL 0
+#define PCPU_EASY   0
+#define PCPU_TYPES  1
+#endif
 
 struct per_cpu_pages {
 	int count[PCPU_TYPES];  /* Number of pages on each list */
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc5-mm1-mbuddy-v19-noconfig/init/Kconfig linux-2.6.14-rc5-mm1-mbuddy-v19-withconfig/init/Kconfig
--- linux-2.6.14-rc5-mm1-mbuddy-v19-noconfig/init/Kconfig	2005-11-02 12:42:20.000000000 +0000
+++ linux-2.6.14-rc5-mm1-mbuddy-v19-withconfig/init/Kconfig	2005-11-02 12:59:49.000000000 +0000
@@ -419,6 +419,17 @@ config CC_ALIGN_JUMPS
 	  no dummy operations need be executed.
 	  Zero means use compiler's default.
 
+config PAGEALLOC_ANTIDEFRAG
+	bool "Try and avoid fragmentation in the page allocator"
+	def_bool y
+	help
+	  The standard allocator will fragment memory over time which means that
+	  high order allocations will fail even if kswapd is running. If this
+	  option is set, the allocator will try and group page types into
+	  three groups KernNoRclm, KernRclm and EasyRclm. The gain is a best
+	  effort attempt at lowering fragmentation. The loss is more complexity
+
+
 endmenu		# General setup
 
 config TINY_SHMEM
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc5-mm1-mbuddy-v19-noconfig/mm/page_alloc.c linux-2.6.14-rc5-mm1-mbuddy-v19-withconfig/mm/page_alloc.c
--- linux-2.6.14-rc5-mm1-mbuddy-v19-noconfig/mm/page_alloc.c	2005-11-02 13:05:07.000000000 +0000
+++ linux-2.6.14-rc5-mm1-mbuddy-v19-withconfig/mm/page_alloc.c	2005-11-02 14:09:37.000000000 +0000
@@ -57,11 +57,17 @@ long nr_swap_pages;
  * fallback_allocs contains the fallback types for low memory conditions
  * where the preferred alloction type if not available.
  */
+#ifdef CONFIG_PAGEALLOC_ANTIDEFRAG
 int fallback_allocs[RCLM_TYPES-1][RCLM_TYPES+1] = {
 	{RCLM_NORCLM,	RCLM_FALLBACK, RCLM_KERN,   RCLM_EASY, RCLM_TYPES},
 	{RCLM_EASY,     RCLM_FALLBACK, RCLM_NORCLM, RCLM_KERN, RCLM_TYPES},
 	{RCLM_KERN,     RCLM_FALLBACK, RCLM_NORCLM, RCLM_EASY, RCLM_TYPES}
 };
+#else
+int fallback_allocs[RCLM_TYPES][RCLM_TYPES+1] = {
+	{RCLM_NORCLM, RCLM_TYPES}
+};
+#endif /* CONFIG_PAGEALLOC_ANTIDEFRAG */
 
 /* Returns 1 if the needed percentage of the zone is reserved for fallbacks */
 static inline int min_fallback_reserved(struct zone *zone)
@@ -98,6 +104,7 @@ EXPORT_SYMBOL(totalram_pages);
 #error __GFP_KERNRCLM not mapping to RCLM_KERN
 #endif
 
+#ifdef CONFIG_PAGEALLOC_ANTIDEFRAG
 /*
  * This function maps gfpflags to their RCLM_TYPE. It makes assumptions
  * on the location of the GFP flags.
@@ -115,6 +122,12 @@ static inline int gfpflags_to_rclmtype(g
 
 	return rclmbits >> RCLM_SHIFT;
 }
+#else
+static inline int gfpflags_to_rclmtype(gfp_t gfp_flags)
+{
+	return RCLM_NORCLM;
+}
+#endif /* CONFIG_PAGEALLOC_ANTIDEFRAG */
 
 /*
  * copy_bits - Copy bits between bitmaps
@@ -134,6 +147,9 @@ static inline void copy_bits(unsigned lo
 		int sindex_src,
 		int nr)
 {
+	if (nr == 0)
+		return;
+
 	/*
 	 * Written like this to take advantage of arch-specific
 	 * set_bit() and clear_bit() functions
@@ -188,8 +204,12 @@ static char *zone_names[MAX_NR_ZONES] = 
 int min_free_kbytes = 1024;
 
 #ifdef CONFIG_ALLOCSTATS
+#ifdef CONFIG_PAGEALLOC_ANTIDEFRAG
 static char *type_names[RCLM_TYPES] = { "KernNoRclm", "EasyRclm",
 					"KernRclm", "Fallback"};
+#else
+static char *type_names[RCLM_TYPES] = { "KernNoRclm" };
+#endif /* CONFIG_PAGEALLOC_ANTIDEFRAG */
 #endif /* CONFIG_ALLOCSTATS */
 
 unsigned long __initdata nr_kernel_pages;
@@ -2228,8 +2248,10 @@ static void __init setup_usemap(struct p
 				struct zone *zone, unsigned long zonesize)
 {
 	unsigned long usemapsize = usemap_size(zonesize);
-	zone->free_area_usemap = alloc_bootmem_node(pgdat, usemapsize);
-	memset(zone->free_area_usemap, RCLM_NORCLM, usemapsize);
+	if (usemapsize != 0) {
+		zone->free_area_usemap = alloc_bootmem_node(pgdat, usemapsize);
+		memset(zone->free_area_usemap, RCLM_NORCLM, usemapsize);
+	}
 }
 #else
 static void inline setup_usemap(struct pglist_data *pgdat,


