Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbWEDBcp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbWEDBcp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 21:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWEDBcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 21:32:45 -0400
Received: from mailhub.hp.com ([192.151.27.10]:32716 "EHLO mailhub.hp.com")
	by vger.kernel.org with ESMTP id S1750836AbWEDBcp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 21:32:45 -0400
From: "Bob Picco" <bob.picco@hp.com>
Date: Wed, 3 May 2006 21:32:39 -0400
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, Andi Kleen <ak@suse.de>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Andy Whitcroft <apw@shadowen.org>
Subject: Re: assert/crash in __rmqueue() when enabling CONFIG_NUMA
Message-ID: <20060504013239.GG19859@localhost>
References: <20060419112130.GA22648@elte.hu> <p73aca07whs.fsf@bragg.suse.de> <20060502070618.GA10749@elte.hu> <200605020905.29400.ak@suse.de> <44576688.6050607@mbligh.org> <44576BF5.8070903@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44576BF5.8070903@yahoo.com.au>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:	[Tue May 02 2006, 10:25:57AM EDT]
> Martin J. Bligh wrote:
> >>Oh that's a 32bit kernel. I don't think the 32bit NUMA has ever worked
> >>anywhere but some Summit systems (at least every time I tried it it 
> >>blew up on me and nobody seems to use it regularly). Maybe it would be 
> >>finally time to mark it CONFIG_BROKEN though or just remove it (even 
> >>by design it doesn't work very well) 
> >
> >
> >Bollocks. It works fine, and is tested every single day, on every git
> >release, and every -mm tree.
> 
> Whatever the case, there definitely does not appear to be sufficient
> zone alignment enforced for the buddy allocator. I cannot see how it
> could work if zones are not aligned on 4MB boundaries.
> 
> Maybe some architectures / subarch code naturally does this for us,
> but Ingo is definitely hitting this bug because his config does not
> (align, that is).
> 
> I've randomly added a couple more cc's.
> 
The patch below isn't compile tested or correct for those cases where
alloc_remap is called or where arch code has allocated node_mem_map for
CONFIG_FLAT_NODE_MEM_MAP. It's just conveying what I believe the issue is.

Andy added code to buddy allocator which doesn't require the zone's endpoints
to be aligned to MAX_ORDER. I think the issue is that the buddy
allocator requires the node_mem_map's endpoints to be MAX_ORDER aligned. 
Otherwise __page_find_buddy could compute a buddy not in node_mem_map
for partial MAX_ORDER regions at zone's endpoints. page_is_buddy will
detect that these pages at endpoints aren't PG_buddy (they were zeroed
out by bootmem allocator and not part of zone).  Of course the negative
here is we could waste a little memory but the positive is eliminating
all the old checks for zone boundary conditions.

SPARSEMEM won't encounter this issue because of MAX_ORDER size
constraint when SPARSEMEM is configured. ia64 VIRTUAL_MEM_MAP doesn't
need the logic either because the holes and endpoints are handled
differently.  This leaves checking alloc_remap and other arches which
privately allocate for node_mem_map.

Any how I could be totally wrong but like I said this requires more
thought.

bob


Index: linux-2.6.17-rc3/mm/page_alloc.c
===================================================================
--- linux-2.6.17-rc3.orig/mm/page_alloc.c	2006-04-27 09:44:02.000000000 -0400
+++ linux-2.6.17-rc3/mm/page_alloc.c	2006-05-03 14:50:13.000000000 -0400
@@ -2123,14 +2123,23 @@ static void __init alloc_node_mem_map(st
 #ifdef CONFIG_FLAT_NODE_MEM_MAP
 	/* ia64 gets its own node_mem_map, before this, without bootmem */
 	if (!pgdat->node_mem_map) {
-		unsigned long size;
+		unsigned long size, start, end;
 		struct page *map;
 
-		size = (pgdat->node_spanned_pages + 1) * sizeof(struct page);
+		/*
+		 * The zone's endpoints aren't required to be MAX_ORDER
+		 * aligned but the node_mem_map endpoints must be in order
+		 * for the buddy allocator to function correctly.
+		 */
+		start = pgdat->node_start_pfn & ~((1 << (MAX_ORDER - 1)) - 1);
+		end = start + pgdat->node_spanned_pages;
+		end = (end + ((1 << (MAX_ORDER - 1)) - 1) &
+			~((1 << (MAX_ORDER - 1)) - 1);
+		size =  (end - start) * sizeof(struct page);
 		map = alloc_remap(pgdat->node_id, size);
 		if (!map)
 			map = alloc_bootmem_node(pgdat, size);
-		pgdat->node_mem_map = map;
+		pgdat->node_mem_map = map + ( pgdat->node_start_pfn - start);
 	}
 #ifdef CONFIG_FLATMEM
 	/*
