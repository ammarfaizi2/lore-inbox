Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756677AbWK1Ves@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756677AbWK1Ves (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 16:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756753AbWK1Ver
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 16:34:47 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:20104 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1756677AbWK1Ver
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 16:34:47 -0500
Date: Tue, 28 Nov 2006 21:34:43 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Rohit Seth <rohitseth@google.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       David Rientjes <rientjes@cs.washington.edu>,
       Paul Menage <menage@google.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [Patch1/4]: fake numa for x86_64 patch
In-Reply-To: <1164737207.14257.7.camel@galaxy.corp.google.com>
Message-ID: <Pine.LNX.4.64.0611282009320.14388@skynet.skynet.ie>
References: <1164245649.29844.148.camel@galaxy.corp.google.com> 
 <Pine.LNX.4.64.0611271310200.11949@skynet.skynet.ie> 
 <1164651761.6619.33.camel@galaxy.corp.google.com> 
 <Pine.LNX.4.64.0611281321020.7436@skynet.skynet.ie>
 <1164737207.14257.7.camel@galaxy.corp.google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2006, Rohit Seth wrote:

> On Tue, 2006-11-28 at 13:24 +0000, Mel Gorman wrote:
>> On Mon, 27 Nov 2006, Rohit Seth wrote:
>>
>>> Hi Mel,
>>>
>>> On Mon, 2006-11-27 at 13:18 +0000, Mel Gorman wrote:
>>>> On Wed, 22 Nov 2006, Rohit Seth wrote:
>>>>
>>>>> This patch provides a IO hole size in a given address range.
>>>>>
>>>>
>>>> Hi,
>>>>
>>>> This patch reintroduces a function that doubles up what
>>>> absent_pages_in_range(start_pfn, end_pfn). I recognise you do this because
>>>> you are interested in hole sizes before add_active_range() is called.
>>>
>>> Right.
>>>
>>>>
>>>> However, what is not clear is why these patches are so specific to x86_64.
>>>>
>>>
>>> Specifically in the fake numa case, we want to make sure that we don't
>>> carve fake nodes that only have IO holes in it.  Unlike the real NUMA
>>> case, here we don't have SRAT etc. to know the memory layout beforehand.
>>>
>>>
>>>> It looks possible to do the work of functions like split_nodes_equal() in
>>>> an architecture-independent manner using early_node_map rather than
>>>> dealing with the arch-specific nodes array. That would open the
>>>> possibility of providing fake nodes on more than one architecture in the
>>>> future.
>>>
>>> The functions like splti_nodes_equal etc. can be abstracted out to arch
>>> independent part.  I think the only API it needs from arch dependent
>>> part is to find out how much real RAM is present in range without have
>>> to first do add_active_range.
>>>
>>
>> That is a problem because the ranges must be registered with
>> add_active_range() to work out how much real RAM is present.
>>
>
> Right.  And that is why I need e820_hole_size functionality. BTW, what
> is the concern in having that function?
>

Because it provides almost identical functionality to another function. If 
that can be avoided, it's preferable.

>>> Though as a first step, let us fix the x86_64 (as it doesn't boot when
>>> you have sizeable chunk of IO hole and nodes > 4).
>>>
>>
>> Ok.
>>
>>> I'm also not sure if other archs actually want to have this
>>> functionality.
>>>
>>
>> It's possible that the containers people are interested in the possibility
>> of setting up fake nodes as part of a memory controller.
>>
> That is precisely why I'm doing it :-)
>
>>>> What I think can be done is that you register memory as normal and then
>>>> split up the nodes into fake nodes. This would remove the need for having
>>>> e820_hole_size() reintroduced.
>>>
>>> Are you saying first let the system find out real numa topology and then
>>> build fake numa on top of it?
>>>
>>
>> Yes, there is nothing stopping you altering the early_node_map[] before
>> free_area_init_node() initialises the node_mem_map. If you do hit a
>> problem, it'll be because x86_64 allocates it's own node_mem_map with
>> CONFIG_FLAT_NODE_MEM_MAP is set. Is that set when setting up fake nodes?
>>
>
> I thought they both (real numa + fake numa) operate on same data
> structures. I'll have to double check.
>
> -rohit
>

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
