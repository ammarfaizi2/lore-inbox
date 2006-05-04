Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030303AbWEDTnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030303AbWEDTnh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 15:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbWEDTnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 15:43:37 -0400
Received: from mailhub.hp.com ([192.151.27.10]:52196 "EHLO mailhub.hp.com")
	by vger.kernel.org with ESMTP id S1030303AbWEDTng (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 15:43:36 -0400
From: "Bob Picco" <bob.picco@hp.com>
Date: Thu, 4 May 2006 15:43:34 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Bob Picco <bob.picco@hp.com>, Dave Hansen <haveblue@us.ibm.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Andy Whitcroft <apw@shadowen.org>
Subject: Re: assert/crash in __rmqueue() when enabling CONFIG_NUMA
Message-ID: <20060504194334.GH19859@localhost>
References: <20060419112130.GA22648@elte.hu> <p73aca07whs.fsf@bragg.suse.de> <20060502070618.GA10749@elte.hu> <200605020905.29400.ak@suse.de> <44576688.6050607@mbligh.org> <44576BF5.8070903@yahoo.com.au> <20060504013239.GG19859@localhost> <1146756066.22503.17.camel@localhost.localdomain> <20060504154652.GA4530@localhost> <20060504192528.GA26759@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060504192528.GA26759@elte.hu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:	[Thu May 04 2006, 03:25:28PM EDT]
> 
> * Bob Picco <bob.picco@hp.com> wrote:
> 
> > Dave Hansen wrote:	[Thu May 04 2006, 11:21:06AM EDT]
> > > I haven't thought through it completely, but these two lines worry me:
> > > 
> > > > + start = pgdat->node_start_pfn & ~((1 << (MAX_ORDER - 1)) - 1);
> > > > + end = start + pgdat->node_spanned_pages;
> > > 
> > > Should the "end" be based off of the original "start", or the aligned
> > > "start"?
> >
> > Yes. I failed to quilt refresh before sending. You mean end should be 
> > end = pgdat->node_start_pfn + pgdat->node_spanned_pages before 
> > rounding up.
> 
> do you have an updated patch i should try?
> 
> 	Ingo
You can try this but don't believe it will change your outcome. I've
booted this on ia64 with slight modification to eliminate
VIRTUAL_MEM_MAP and have only DISCONTIGMEM. Your case is failing at the
front edge of of the zone and not the ending edge which had a flaw in my
first post of the patch. I would have expected the first patch to handle
the front edge correctly.

I don't remember seeing your .config in the thread (or blind and unable
to see it). Would you please send it my way.

I'm also hoping Andy has time to look into this.

bob


Index: linux-2.6.17-rc3/mm/page_alloc.c
===================================================================
--- linux-2.6.17-rc3.orig/mm/page_alloc.c	2006-04-27 09:44:02.000000000 -0400
+++ linux-2.6.17-rc3/mm/page_alloc.c	2006-05-04 13:01:25.000000000 -0400
@@ -2123,14 +2123,22 @@ static void __init alloc_node_mem_map(st
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
+		start = pgdat->node_start_pfn & ~(MAX_ORDER_NR_PAGES - 1);
+		end = pgdat->node_start_pfn + pgdat->node_spanned_pages;
+		end = ALIGN(end, MAX_ORDER_NR_PAGES);
+		size =  (end - start) * sizeof(struct page);
 		map = alloc_remap(pgdat->node_id, size);
 		if (!map)
 			map = alloc_bootmem_node(pgdat, size);
-		pgdat->node_mem_map = map;
+		pgdat->node_mem_map = map + (pgdat->node_start_pfn - start);
 	}
 #ifdef CONFIG_FLATMEM
 	/*
Index: linux-2.6.17-rc3/include/linux/mmzone.h
===================================================================
--- linux-2.6.17-rc3.orig/include/linux/mmzone.h	2006-04-27 09:44:02.000000000 -0400
+++ linux-2.6.17-rc3/include/linux/mmzone.h	2006-05-04 13:01:39.000000000 -0400
@@ -22,6 +22,7 @@
 #else
 #define MAX_ORDER CONFIG_FORCE_MAX_ZONEORDER
 #endif
+#define MAX_ORDER_NR_PAGES (1 << (MAX_ORDER - 1))
 
 struct free_area {
 	struct list_head	free_list;
