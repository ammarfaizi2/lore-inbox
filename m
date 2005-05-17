Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbVEQMZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbVEQMZl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 08:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVEQMZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 08:25:41 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:58586
	"EHLO pinky.shadowen.org") by vger.kernel.org with ESMTP
	id S261430AbVEQMZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 08:25:21 -0400
To: christoph@scalex86.org
Subject: Re: [PATCH] Factor in buddy allocator alignment requirements in node memory alignment
Cc: akpm@osdl.org, haveblue@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, shai@scalex86.org
In-Reply-To: <Pine.LNX.4.62.0505161240240.13692@ScMPusgw>
Message-Id: <E1DY18K-0002dJ-KM@pinky.shadowen.org>
From: Andy Whitcroft <apw@shadowen.org>
Date: Tue, 17 May 2005 13:25:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     if ((zone_start_pfn) & (zone_required_alignment-1))
>            printk(KERN_CRIT "BUG: wrong zone alignment, it will crash\n");

I am confused.  Your patch attempts to change the alignment of the
mem_map for the node.  However, the warning which is triggering is
talking about the relative alignment of the physical pages which
make up the zone, ie those which will be represented by the mem_map.
The alignment of the mem_map is being forced because we are going
to use large pages to map them for performance and tlb coverage
not to match the alignment constraint above.

That said, I believe that this warning is no longer accurate.
The order in which buddies are combined and the alignment thereof
is handled by __free_pages_bulk.  This now uses the low order
bits of the physical page frame number to calculate the free'd
objects relative position within the MAX_ORDER aligned buddies,
not the relative position of the page structure within the mem_map.
This allows _either_ edge of the zone to contain partial MAX_ORDER
sized buddies.  These simply never will have matching buddies and
thus will never make it to the 'top' of the pyramid.

Indeed looking back at the original patch I commented on how this
change fixed the problem highlighted by the warning, it seems I
failed to follow up and remove it.

In short I think that this warning is now bogus and can be removed.

Andrew, please consider this patch for -mm.

-apw

===
Originally __free_pages_bulk used the relative page number within
a zone to define its buddies.  This meant that to maintain the
"maximally aligned" requirements (that an allocation of size N will
be aligned at least to N physically) zones had to also be aligned to
1<<MAX_ORDER pages.  When __free_pages_bulk was updated to use the
relative page frame numbers of the free'd pages to pair buddies this
released the alignment constraint on the 'left' edge of the zone.
This allows _either_ edge of the zone to contain partial MAX_ORDER
sized buddies.  These simply never will have matching buddies and
thus will never make it to the 'top' of the pyramid.

The patch below removes a now redundant check ensuring that the
mem_map was aligned to MAX_ORDER.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>

diffstat free_area_init_core-remove-bogus-warning
---
 page_alloc.c |    4 ----
 1 files changed, 4 deletions(-)

diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/mm/page_alloc.c current/mm/page_alloc.c
--- reference/mm/page_alloc.c
+++ current/mm/page_alloc.c
@@ -1942,7 +1942,6 @@ static void __init free_area_init_core(s
 		unsigned long *zones_size, unsigned long *zholes_size)
 {
 	unsigned long i, j;
-	const unsigned long zone_required_alignment = 1UL << (MAX_ORDER-1);
 	int cpu, nid = pgdat->node_id;
 	unsigned long zone_start_pfn = pgdat->node_start_pfn;
 
@@ -2033,9 +2032,6 @@ static void __init free_area_init_core(s
 		zone->zone_mem_map = pfn_to_page(zone_start_pfn);
 		zone->zone_start_pfn = zone_start_pfn;
 
-		if ((zone_start_pfn) & (zone_required_alignment-1))
-			printk(KERN_CRIT "BUG: wrong zone alignment, it will crash\n");
-
 		memmap_init(size, nid, j, zone_start_pfn);
 
 		zonetable_add(zone, nid, j, zone_start_pfn, size);
