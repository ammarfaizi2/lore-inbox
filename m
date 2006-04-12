Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbWDLRc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbWDLRc4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 13:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbWDLRc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 13:32:56 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:47766 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932273AbWDLRcz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 13:32:55 -0400
Date: Wed, 12 Apr 2006 18:32:42 +0100 (IST)
From: Mel Gorman <mel@skynet.ie>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linuxppc-dev@ozlabs.org, davej@codemonkey.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ak@suse.de,
       bob.picco@hp.com
Subject: Re: [PATCH 0/6] [RFC] Sizing zones and holes in an architecture
 independent manner
In-Reply-To: <20060412170726.GA11143@agluck-lia64.sc.intel.com>
Message-ID: <Pine.LNX.4.64.0604121818200.7697@skynet.skynet.ie>
References: <20060411103946.18153.83059.sendpatchset@skynet>
 <20060411222029.GA7743@agluck-lia64.sc.intel.com>
 <Pine.LNX.4.64.0604112352230.6624@skynet.skynet.ie>
 <20060412000500.GA8532@agluck-lia64.sc.intel.com>
 <Pine.LNX.4.64.0604121001590.24819@skynet.skynet.ie>
 <20060412154633.GA10589@agluck-lia64.sc.intel.com>
 <Pine.LNX.4.64.0604121657380.24819@skynet.skynet.ie>
 <20060412170726.GA11143@agluck-lia64.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Apr 2006, Luck, Tony wrote:

> On Wed, Apr 12, 2006 at 05:00:32PM +0100, Mel Gorman wrote:
>> Patch is attached as 105-ia64_use_init_nodes.patch until I beat sense into
>> my mail setup. I've added Bob Picco to the cc list as he will hit the same
>> issue with whitespace corruption.
>
> Next I tried building a "generic" kernel (using arch/ia64/defconfig). This
> has NUMA=y and DISCONTIG=y).  This crashes with the following console log.
>
>
> <snipped>
> add_active_range(0, 0, 4096): New
> add_active_range(0, 0, 131072): New
> add_active_range(0, 0, 131072): New
> add_active_range(0, 393216, 523264): New
> add_active_range(0, 393216, 523264): New
> add_active_range(0, 393216, 524288): New
> add_active_range(0, 393216, 524288): New

This is where it started going wrong. I did not expect add_active_range() 
to be called with overlapping PFNs so they were not getting merged. If 
they were getting merged correctly, I'd expect the output to be

add_active_range(0, 0, 4096): New
add_active_range(0, 0, 131072): Merging forward
add_active_range(0, 0, 131072): Merging forward
add_active_range(0, 393216, 523264): New
add_active_range(0, 393216, 523264): Merging forward
add_active_range(0, 393216, 524288): Merging forward
add_active_range(0, 393216, 524288): Merging forward

> Virtual mem_map starts at 0xa0007ffffe400000
> Dumping sorted node map
> entry 0: 0  0 -> 131072
> entry 1: 0  0 -> 4096
> entry 2: 0  0 -> 131072
> entry 3: 0  393216 -> 523264
> entry 4: 0  393216 -> 524288
> entry 5: 0  393216 -> 524288
> entry 6: 0  393216 -> 523264
> Hole found index 0: 0 -> 0
> prev_end > start_pfn : 131072 > 0

And here is where it goes BLAM. Without the debugging patch, the check is 
just;

BUG_ON(prev_end_pfn > start_pfn);

The error I was *expecting* to catch was an unsorted node map. It's just 
nice it caught this situation as well. It'll take a while to fix this up 
properly.

Thanks

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
