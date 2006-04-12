Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750896AbWDLBi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbWDLBi2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 21:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbWDLBi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 21:38:28 -0400
Received: from mailhub.hp.com ([192.151.27.10]:42716 "EHLO mailhub.hp.com")
	by vger.kernel.org with ESMTP id S1750896AbWDLBi1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 21:38:27 -0400
From: "Bob Picco" <bob.picco@hp.com>
Date: Tue, 11 Apr 2006 21:38:24 -0400
To: Mel Gorman <mel@skynet.ie>
Cc: Bob Picco <bob.picco@hp.com>, "Luck, Tony" <tony.luck@intel.com>,
       linuxppc-dev@ozlabs.org, davej@codemonkey.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ak@suse.de
Subject: Re: [PATCH 0/6] [RFC] Sizing zones and holes in an architecture independent manner
Message-ID: <20060412013824.GF23742@localhost>
References: <20060411103946.18153.83059.sendpatchset@skynet> <20060411222029.GA7743@agluck-lia64.sc.intel.com> <20060411232944.GE23742@localhost> <Pine.LNX.4.64.0604120053080.10268@skynet.skynet.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604120053080.10268@skynet.skynet.ie>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman wrote:	[Tue Apr 11 2006, 08:02:10PM EDT]
> On Tue, 11 Apr 2006, Bob Picco wrote:
> 
> >luck wrote:	[Tue Apr 11 2006, 06:20:29PM EDT]
> >>On Tue, Apr 11, 2006 at 11:39:46AM +0100, Mel Gorman wrote:
> >>
> >>>The patches have only been *compile tested* for ia64 with a flatmem
> >>>configuration. At attempt was made to boot test on an ancient RS/6000
> >>>but the vanilla kernel does not boot so I have to investigate there.
> >>
> >>The good news: Compilation is clean on the ia64 config variants that
> >>I usually build (all 10 of them).
> >>
> >>The bad (or at least consistent) news: It doesn't boot on an Intel
> >>Tiger either (oops at kmem_cache_alloc+0x41).
> >>
> >>-Tony
> >I had a reply queued to report the same failure with
> >DISCONTIG+NUMA+VIRTUAL_MEM_MAP.  This was 2 CPU HP rx2600. I'll take a 
> >closer
> >look at the code tomorrow.
> >
> 
> hmm, ok, so discontig.c is in use which narrows things down. When 
> build_node_maps() is called, I assumed that the start and end pfn passed 
> in was for a valid page range. Was this a valid assumption? When I re-read 
The addresses are a valid physical range. The caution should be that
filter_rsvd_memory converts the addresses from identity mapped to
physical. efi_memmap_walk calls back to function with identity mapped
addresses. What you've done seems okay.
BTW - I like want you are attempting to achieve.
> the comment, it implies that memory holes could be within this range which 
> would cause boot failures. If that is the case, the correct thing to do 
> was to call add_active_range() in count_node_pages() instead of 
> build_node_maps().
Yes that helps because of granules and it boots.  The patch below is applied 
on top of your original post. But..

Index: linux-2.6.17-rc1/arch/ia64/mm/discontig.c
===================================================================
--- linux-2.6.17-rc1.orig/arch/ia64/mm/discontig.c	2006-04-11 20:36:15.000000000 -0400
+++ linux-2.6.17-rc1/arch/ia64/mm/discontig.c	2006-04-11 20:52:59.000000000 -0400
@@ -88,9 +88,6 @@ static int __init build_node_maps(unsign
 	min_low_pfn = min(min_low_pfn, bdp->node_boot_start>>PAGE_SHIFT);
 	max_low_pfn = max(max_low_pfn, bdp->node_low_pfn);
 
-	/* Add a known active range */
-	add_active_range(node, start, end);
-
 	return 0;
 }
 
@@ -651,6 +648,8 @@ static __init int count_node_pages(unsig
 	mem_data[node].min_pfn = min(mem_data[node].min_pfn,
 				     start >> PAGE_SHIFT);
 
+	add_active_range(node, start, end);
+
 	return 0;
 }

Page free/avail accounting is off and I'm done for tonight. I believe it's how 
you treat holes but haven't looked closely yet.
 

Let me wrap my head around this code again. It's been some time.
> 
bob
