Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934112AbWKWVzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934112AbWKWVzv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 16:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934111AbWKWVzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 16:55:51 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:61409 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S934112AbWKWVzu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 16:55:50 -0500
Date: Thu, 23 Nov 2006 21:55:45 +0000
To: Andrew Morton <akpm@osdl.org>
Cc: Andre Noll <maan@systemlinux.org>, Andi Kleen <ak@suse.de>,
       discuss@x86-64.org, Adrian Bunk <bunk@stusta.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Rientjes <rientjes@cs.washington.edu>
Subject: Re: [discuss] 2.6.19-rc6: known regressions (v4)
Message-ID: <20061123215545.GA9551@skynet.ie>
References: <Pine.LNX.4.64.0611152008450.3349@woody.osdl.org> <20061121212424.GQ5200@stusta.de> <200611221142.21212.ak@suse.de> <20061122155233.GA30607@skynet.ie> <20061122174223.GE27761@skl-net.de> <20061123120141.GA20920@skynet.ie> <20061123110930.abc4fd9a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20061123110930.abc4fd9a.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
From: mel@skynet.ie (Mel Gorman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/11/06 11:09), Andrew Morton didst pronounce:
> On Thu, 23 Nov 2006 12:01:41 +0000
> mel@skynet.ie (Mel Gorman) wrote:
> 
> > find_min_pfn_for_node() and find_min_pfn_with_active_regions() both depend
> > on a sorted early_node_map[]. However, sort_node_map() is being called after
> > fin_min_pfn_with_active_regions() in free_area_init_nodes(). In most cases,
> > this is ok, but on at least one x86_64, the SRAT table caused the E820 ranges
> > to be registered out of order. This gave the wrong values for the min PFN
> > range resulting in some pages not being initialised.
> > 
> > This patch sorts the early_node_map in find_min_pfn_for_node(). It has
> > been boot tested on x86, x86_64, ppc64 and ia64.
> > 
> > Signed-off-by: Mel Gorman <mel@csn.ul.ie>
> > 
> > diff -rup linux-2.6.19-rc6-clean/mm/page_alloc.c linux-2.6.19-rc6-sort_in_find_min/mm/page_alloc.c
> > --- linux-2.6.19-rc6-clean/mm/page_alloc.c	2006-11-15 20:03:40.000000000 -0800
> > +++ linux-2.6.19-rc6-sort_in_find_min/mm/page_alloc.c	2006-11-23 02:23:57.000000000 -0800
> > @@ -2612,6 +2612,9 @@ unsigned long __init find_min_pfn_for_no
> >  {
> >  	int i;
> >  
> > +	/* Regions in the early_node_map can be in any order */
> > +	sort_node_map();
> > +
> >  	/* Assuming a sorted map, the first range found has the starting pfn */
> >  	for_each_active_range_index_in_nid(i, nid)
> >  		return early_node_map[i].start_pfn;
> > @@ -2680,9 +2683,6 @@ void __init free_area_init_nodes(unsigne
> >  			max(max_zone_pfn[i], arch_zone_lowest_possible_pfn[i]);
> >  	}
> >  
> > -	/* Regions in the early_node_map can be in any order */
> > -	sort_node_map();
> > -
> >  	/* Print out the zone ranges */
> >  	printk("Zone PFN ranges:\n");
> >  	for (i = 0; i < MAX_NR_ZONES; i++)
> 

yes, once per active node.
          
> Seems a bit ... ungainly?
>


It is, but this late in the cycle, I was going for the
obviously-correct-and-will-definitly-work solution.

It would be sufficient to call sort_node_map() in
find_min_pfn_with_active_regions() but I wasn't sure someone would call
find_min_pfn_for_node() at some future time causing another fun bug.

A slightly smarter, but not quite as obviously correct, patch is below if
you prefer it. It removes the assumption about early_node_map being sorted
for find_min_pfns and friends by always searching the whole map.  The map
is then only sorted once when it is required. Andre, I'd appreciate it if
you could give it a spin to be 100% sure it's ok. It passed a boot-test on
a few machines here.

===========

find_min_pfn_for_node() and find_min_pfn_with_active_regions() both
depend on a sorted  early_node_map[] to find the correct values. However,
sort_node_map() is being called after fin_min_pfn_with_active_regions()
in free_area_init_nodes(). In most cases, this is ok, but on an x86_64,
the SRAT table caused the E820 ranges to be registered out of order. This gave
the wrong values for the min PFN range resulting in some pages not being
initialised.

This patch works by always searching the whole early_node_map[] in
find_min_pfn_for_node().

Signed-off-by: Mel Gorman <mel@csn.ul.ie>

diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-clean/mm/page_alloc.c linux-2.6.19-rc5-mm2-sort_in_find_min/mm/page_alloc.c
--- linux-2.6.19-rc5-mm2-clean/mm/page_alloc.c	2006-11-14 14:01:37.000000000 +0000
+++ linux-2.6.19-rc5-mm2-sort_in_find_min/mm/page_alloc.c	2006-11-23 20:37:18.000000000 +0000
@@ -2945,17 +2945,22 @@ static void __init sort_node_map(void)
 			cmp_node_active_region, NULL);
 }
 
-/* Find the lowest pfn for a node. This depends on a sorted early_node_map */
+/* Find the lowest pfn for a node */
 unsigned long __init find_min_pfn_for_node(unsigned long nid)
 {
 	int i;
+	unsigned long min_pfn = -1UL;
 
 	/* Assuming a sorted map, the first range found has the starting pfn */
 	for_each_active_range_index_in_nid(i, nid)
-		return early_node_map[i].start_pfn;
+		min_pfn = min(min_pfn, early_node_map[i].start_pfn);
 
-	printk(KERN_WARNING "Could not find start_pfn for node %lu\n", nid);
-	return 0;
+	if (min_pfn == -1UL) {
+		printk(KERN_WARNING "Could not find start_pfn for node %lu\n", nid);
+		return 0;
+	}
+	
+	return min_pfn;
 }
 
 /**
