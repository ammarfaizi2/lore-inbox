Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751542AbVKBKSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbVKBKSa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 05:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751543AbVKBKSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 05:18:30 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:47809 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751541AbVKBKS3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 05:18:29 -0500
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Ingo Molnar <mingo@elte.hu>,
       Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Dave Hansen <haveblue@us.ibm.com>, Mel Gorman <mel@csn.ul.ie>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19 
In-reply-to: Your message of Wed, 02 Nov 2005 20:37:43 +1100.
             <436888E7.1060609@yahoo.com.au> 
Date: Wed, 02 Nov 2005 02:17:58 -0800
Message-Id: <E1EXFgs-0005tq-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 02 Nov 2005 20:37:43 +1100, Nick Piggin wrote:
> Gerrit Huizenga wrote:
> > On Wed, 02 Nov 2005 19:50:15 +1100, Nick Piggin wrote:
> 
> >>Isn't the solution for your hypervisor problem to dish out pages of
> >>the same size that are used by the virtual machines. Doesn't this
> >>provide you with a nice, 100% solution that doesn't add complexity
> >>where it isn't needed?
> > 
> > 
> > So do you see the problem with fragementation if the hypervisor is
> > handing out, say, 1 MB pages?  Or, more likely, something like 64 MB
> > pages?  What are the chances that an entire 64 MB page can be freed
> > on a large system that has been up a while?
>
> I see the problem, but if you want to be able to shrink memory to a
> given size, then you must either introduce a hard limit somewhere, or
> have the hypervisor hand out guest sized pages. Use zones, or Xen?
 
 So why do you believe there must be a hard limit?
 
 Any reduction in memory usage is going to be workload related.
 If the workload is consuming less memory than is available, memory
 reclaim is easy (e.g. handle fragmentation, find nice sized chunks).
 The workload determines how much the administrator can free.  If
 the workload is using all of the resources available (e.g. lots of
 associated kernel memory locked down, locked user pages, etc.)
 then the administrator will logically be able to reduce less memory
 from the machine.

 The amount of memory to be freed up is not determined by some pre-defined
 machine constraints but based on the actual workload's use of the machine.

 In other words, who really cares if there is some hard limit?  The
 only limit should be the number of pages not currently needed by
 a given workload, not some arbitrary zone size.

> > And, if you create zones, you run into all of the zone rebalancing
> > problems of ZONE_DMA, ZONE_NORMAL, ZONE_HIGHMEM.  In that case, on
> > any long running system, ZONE_HOTPLUGGABLE has been overwhelmed with
> > random allocations, making almost none of it available.
> 
> If there are zone rebalancing problems[*], then it would be great to
> have more users of zones because then they will be more likely to get
> fixed.
> 
> [*] and there are, sadly enough - see the recent patches I posted to
>      lkml for example. But I'm fairly confident that once the particularly
>      silly ones have been fixed, zone balancing will no longer be a
>      derogatory term as has been thrown around (maybe rightly) in this
>      thread!

 You are more optimistic here than I.  You might have improved the
 problem but I think that any zone rebalancing problem is intrinsicly
 hard given the way those zones are used and the fact that we sort
 of want them to be dynamic and yet physically contiguous.  Those two
 core constraints seem to be relatively at odds with each other.

 I'm not a huge fan of dividing memory up into different types which
 are all special purposed.  Everything that becomes special purposed
 over time limits its use and brings up questions on what special purpose
 bucket each allocation should use (e.g. ZONE_NORMAL or ZONE_HIGHMEM
 or ZONE_DMA or ZONE_HOTPLUGGABLE).  And then, when you run out of
 ZONE_HIGHMEM and have to reach into ZONE_HOTPLUGGABLE for some pinned
 memory allocation, it seems the whole concept leads to a messy
 train wreck.

gerrit
