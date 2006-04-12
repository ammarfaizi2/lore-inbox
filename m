Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbWDLRvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWDLRvN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 13:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWDLRvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 13:51:13 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:20632 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932299AbWDLRvL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 13:51:11 -0400
Date: Wed, 12 Apr 2006 18:50:58 +0100 (IST)
From: Mel Gorman <mel@skynet.ie>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linuxppc-dev@ozlabs.org, davej@codemonkey.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ak@suse.de,
       bob.picco@hp.com
Subject: Re: [PATCH 0/6] [RFC] Sizing zones and holes in an architecture
 independent manner
In-Reply-To: <20060412163619.GA11085@agluck-lia64.sc.intel.com>
Message-ID: <Pine.LNX.4.64.0604121835430.7697@skynet.skynet.ie>
References: <20060411103946.18153.83059.sendpatchset@skynet>
 <20060411222029.GA7743@agluck-lia64.sc.intel.com>
 <Pine.LNX.4.64.0604112352230.6624@skynet.skynet.ie>
 <20060412000500.GA8532@agluck-lia64.sc.intel.com>
 <Pine.LNX.4.64.0604121001590.24819@skynet.skynet.ie>
 <20060412154633.GA10589@agluck-lia64.sc.intel.com>
 <Pine.LNX.4.64.0604121657380.24819@skynet.skynet.ie>
 <20060412163619.GA11085@agluck-lia64.sc.intel.com>
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
> Ok!  That boots on the tiger_defconfig.
>
> Some stuff is weird in the dmesg output though.

Ok, I see the problem. It happened because the zone boundary between DMA 
and NORMAL was in a hole.

When I am working out the size of a hole, I check the zone for the end_pfn 
of one active range is the same zone as the start_pfn in the next range. 
In this case, the end of area 1 is 131020 in DMA and the start of area 2 
is 393216 in NORMAL so the hole does not get accounted for.

> You report about
> twice as many pages in each zone, but then the total memory is
> about right.  Here's the diff of my regular kernel (got a bunch of
> patches post-2.6.17-rc1) against a 2.6.17-rc1 with your patches
> applied.  Note also that the Dentry and Inode caches allocated
> twice as much space (presumably based on the belief that there
> is more memory).  My guess is that you are counting the holes.
>
> -Tony
>
> 19,21c20,37
> < On node 0 totalpages: 260725
> <   DMA zone: 129700 pages, LIFO batch:7
> <   Normal zone: 131025 pages, LIFO batch:7
> ---
>> add_active_range(0, 1024, 130688): New
>> add_active_range(0, 130984, 131020): New
>> add_active_range(0, 393216, 524164): New
>> add_active_range(0, 524192, 524269): New
>> Dumping sorted node map
>> entry 0: 0  1024 -> 130688
>> entry 1: 0  130984 -> 131020
>> entry 2: 0  393216 -> 524164
>> entry 3: 0  524192 -> 524269
>> Hole found index 0: 1024 -> 1024
>> Hole found index 1: 130688 -> 130984
>> Hole found index 3: 524164 -> 524192
>> On node 0 totalpages: 522921
>> Hole found index 0: 1024 -> 1024
>> Hole found index 1: 130688 -> 130984
>>   DMA zone: 260824 pages, LIFO batch:7
>> Hole found index 3: 524164 -> 524192
>>   Normal zone: 262097 pages, LIFO batch:7
> 25c41
> < Kernel command line: BOOT_IMAGE=scsi0:EFI\redhat\l-tiger-smp.gz  root=LABEL=/ console=tty1 console=ttyS1,115200 ro
> ---
>> Kernel command line: BOOT_IMAGE=scsi0:EFI\redhat\l-tiger-smpxx.gz  root=LABEL=/ console=uart,io,0x2f8 ro
> 29,30c45,46
> < Dentry cache hash table entries: 524288 (order: 8, 4194304 bytes)
> < Inode-cache hash table entries: 262144 (order: 7, 2097152 bytes)
> ---
>> Dentry cache hash table entries: 1048576 (order: 9, 8388608 bytes)
>> Inode-cache hash table entries: 524288 (order: 8, 4194304 bytes)
> 32c48
> < Memory: 4070560k/4171600k available (6836k code, 99792k reserved, 2749k data, 256k init)
> ---
>> Memory: 4064416k/4171600k available (6832k code, 105936k reserved, 2753k data, 256k init)
>

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
