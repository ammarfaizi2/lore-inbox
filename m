Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967584AbWLEKDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967584AbWLEKDa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 05:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967485AbWLEKD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 05:03:29 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:42220 "EHLO
	calculon.skynet.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967584AbWLEKD2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 05:03:28 -0500
Date: Tue, 5 Dec 2006 10:03:26 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: akpm@osdl.org, clameter@sgi.com, apw@shadowen.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add __GFP_MOVABLE for callers to flag allocations that
 may be migrated
In-Reply-To: <20061205101629.5cb78828.kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.64.0612050952500.11807@skynet.skynet.ie>
References: <20061130170746.GA11363@skynet.ie> <20061130173129.4ebccaa2.akpm@osdl.org>
 <Pine.LNX.4.64.0612010948320.32594@skynet.skynet.ie> <20061201110103.08d0cf3d.akpm@osdl.org>
 <20061204140747.GA21662@skynet.ie> <20061204113051.4e90b249.akpm@osdl.org>
 <Pine.LNX.4.64.0612041946460.26428@skynet.skynet.ie> <20061204143435.6ab587db.akpm@osdl.org>
 <Pine.LNX.4.64.0612042338390.2108@skynet.skynet.ie>
 <20061205101629.5cb78828.kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2006, KAMEZAWA Hiroyuki wrote:

> Hi, your plan looks good to me.

Thanks.

> some comments.
>
> On Mon, 4 Dec 2006 23:45:32 +0000 (GMT)
> Mel Gorman <mel@csn.ul.ie> wrote:
>> 1. Use lumpy-reclaim to intelligently reclaim contigous pages. The same
>>     logic can be used to reclaim within a PFN range
>> 2. Merge anti-frag to help high-order allocations, hugetlbpage
>>     allocations and freeing up SPARSEMEM sections of memory
>
> For freeing up SPARSEMEM sections of memory ?

Yes.

> It looks that you assumes MAX_ORDER_NR_PAGES equals to PAGES_PER_SECTION.
> plz don't assume that when you talk about generic arch code.
>

Yes, I was making the assumption that MAX_ORDER would be increased when 
memory hot-remove was possible so that MAX_ORDER_NR_PAGES == 
PAGES_PER_SECTION. I think it would be a reasonable restriction unless 
section sizes can get really large.

>> 3. Anti-frag includes support for page flags that affected a MAX_ORDER block
>>     of pages. These flags can be used to mark a section of memory that should
>>     not be allocated from. This is of interest to both hugetlb page allocatoin
>>     and memory hot-remove. Use the flags to mark a MAX_ORDER_NR_PAGES that
>>     is currently being freed up and shouldn't be allocated.
>
>> 4. Use anti-frag fallback logic to bias unmovable allocations to the lower
>>     PFNs.
>
> I think this can be one of the most diffcult things ;)
>

It depends on how aggressive the bias is. If it's just "try and keep them 
low but don't work too hard", then it's a simple case of searching the 
free list at the order we are falling back to. If the lowest 
MAX_ORDER_NR_PAGES must be reclaimed for use by unmovable allocations, it 
gets harder but it's not impossible.

>> 5. Add arch support where possible for offlining sections of memory that
>>     can be powered down.
>
> I had a patch for ACPI-memory-hot-unplug, which ties memory sections to memory
> chunk on ACPI.
>

Great, I had a strong feeling something like that existed.

>> 6. Add arch support where possible to power down a DIMM when the memory
>>     sections that make it up have been offlined. This is an extenstion of
>>     step 5 only.
>> 7. Add a zone that only allows __GFP_MOVABLE allocations so that
>>     sections can 100% be reclaimed and powered-down
>> 8. Allow nodes to only have a zone for __GFP_MOVABLE allocations so that
>>     whole nodes can be offlined.
>>
> I (numa-node-hotplug) needs 7 and 8 basically. And Other people may not.

Power would be more interested in 2 for SPARSEMEM sections. Also, while 
getting 7 and 8 right will be important, it won't help stuff like the 
e1000 problem which is why I put it towards the end. I'm going to relook 
at the adding-zone patches today and see if they can be brought forward so 
we can take a proper look.

> IMHO:
> For DIMM unplug, I suspect that we'll finally divide memory to core-memory and
> hot-pluggable by pgdat even on SMP. If we use pgdat for that purpose, almost all
> necessary infrastructure(statistics ,etc..) is ready.
> But if we find better way, it's good.
>

That is one possibility. There are people working on fake nodes for 
containers at the moment. If that pans out, the infrastructure would be 
available to create one node per DIMM.

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
