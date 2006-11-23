Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757187AbWKWMBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757187AbWKWMBp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 07:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757208AbWKWMBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 07:01:45 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:9906 "EHLO calculon.skynet.ie")
	by vger.kernel.org with ESMTP id S1757187AbWKWMBo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 07:01:44 -0500
Date: Thu, 23 Nov 2006 12:01:41 +0000
To: Andre Noll <maan@systemlinux.org>
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org, Adrian Bunk <bunk@stusta.de>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Rientjes <rientjes@cs.washington.edu>
Subject: Re: [discuss] 2.6.19-rc6: known regressions (v4)
Message-ID: <20061123120141.GA20920@skynet.ie>
References: <Pine.LNX.4.64.0611152008450.3349@woody.osdl.org> <20061121212424.GQ5200@stusta.de> <200611221142.21212.ak@suse.de> <20061122155233.GA30607@skynet.ie> <20061122174223.GE27761@skl-net.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20061122174223.GE27761@skl-net.de>
User-Agent: Mutt/1.5.9i
From: mel@skynet.ie (Mel Gorman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/06 18:42), Andre Noll didst pronounce:
> On 15:52, Mel Gorman wrote:
> 
> > Right, so I took a closer look to see what the story was.
> 
> Thanks a lot, Mel.
> 

Thank you for getting back promptly.

> > Bootmem setup node 0 0000000000000000-00000000fc000000
> > Bootmem setup node 1 0000000100000000-0000000200000000
> > 
> > That's node 0 PFN 0->1032192 and node 1 PFN 1048576->2097152.
> > 
> > That is showing an additional 16 page frames that are not in the E820 map
> > (although I have seen this before and it didn't show up as a bad page). I
> > would be very interested in finding out what the bad_page PFNs are if this
> > bug still exists to see if it is those 16 frames. I've included a patch
> > below that might help.
> > 
> > Andre, if the bug still exists for you, can you apply Andi's patch to
> > reduce the log size and the following patch please and post us the
> > output with loglevel=8 please? Thanks
> 
> Done. Here's the output of dmesg with your and Andi's patch applied.
>

ahhh, I believe I see the problem now. Please try out the following patch.

====

find_min_pfn_for_node() and find_min_pfn_with_active_regions() both depend
on a sorted early_node_map[]. However, sort_node_map() is being called after
fin_min_pfn_with_active_regions() in free_area_init_nodes(). In most cases,
this is ok, but on at least one x86_64, the SRAT table caused the E820 ranges
to be registered out of order. This gave the wrong values for the min PFN
range resulting in some pages not being initialised.

This patch sorts the early_node_map in find_min_pfn_for_node(). It has
been boot tested on x86, x86_64, ppc64 and ia64.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>

diff -rup linux-2.6.19-rc6-clean/mm/page_alloc.c linux-2.6.19-rc6-sort_in_find_min/mm/page_alloc.c
--- linux-2.6.19-rc6-clean/mm/page_alloc.c	2006-11-15 20:03:40.000000000 -0800
+++ linux-2.6.19-rc6-sort_in_find_min/mm/page_alloc.c	2006-11-23 02:23:57.000000000 -0800
@@ -2612,6 +2612,9 @@ unsigned long __init find_min_pfn_for_no
 {
 	int i;
 
+	/* Regions in the early_node_map can be in any order */
+	sort_node_map();
+
 	/* Assuming a sorted map, the first range found has the starting pfn */
 	for_each_active_range_index_in_nid(i, nid)
 		return early_node_map[i].start_pfn;
@@ -2680,9 +2683,6 @@ void __init free_area_init_nodes(unsigne
 			max(max_zone_pfn[i], arch_zone_lowest_possible_pfn[i]);
 	}
 
-	/* Regions in the early_node_map can be in any order */
-	sort_node_map();
-
 	/* Print out the zone ranges */
 	printk("Zone PFN ranges:\n");
 	for (i = 0; i < MAX_NR_ZONES; i++)
