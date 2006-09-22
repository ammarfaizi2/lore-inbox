Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964793AbWIVRfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbWIVRfi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 13:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbWIVRfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 13:35:38 -0400
Received: from dvhart.com ([64.146.134.43]:11753 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S964793AbWIVRfh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 13:35:37 -0400
Message-ID: <45141EE8.4030607@mbligh.org>
Date: Fri, 22 Sep 2006 10:35:36 -0700
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Rohit Seth <rohitseth@google.com>, jesse.barnes@intel.com,
       anton@samba.org
Subject: Re: ZONE_DMA
References: <20060920135438.d7dd362b.akpm@osdl.org> <4511D855.7050100@mbligh.org> <20060920172253.f6d11445.akpm@osdl.org> <4511E1CA.6090403@mbligh.org> <Pine.LNX.4.64.0609201804320.2844@schroedinger.engr.sgi.com> <4511E9AC.2050507@mbligh.org> <Pine.LNX.4.64.0609210854210.5626@schroedinger.engr.sgi.com> <4512C469.5060107@mbligh.org> <Pine.LNX.4.64.0609211045400.5959@schroedinger.engr.sgi.com> <45131D2D.8020403@mbligh.org> <Pine.LNX.4.64.0609211937460.4433@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0609211937460.4433@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Thu, 21 Sep 2006, Martin Bligh wrote:
> 
> 
>>Just ignoring GFP_DMA in the allocator seems like a horrible violation
>>to me. GFP_DMA means "give me memory from ZONE_DMA". We're both well
>>aware that the whole concept of ZONE_DMA doesn't make much sense, but
>>still, that's what it does.
> 
> 
> We agreed that the definition of ZONE_DMA is not consistent across 
> architectures.
> 
> The concept of ZONE_DMA makes only sense in terms of an architectures 
> definition if a memory boundary (MAX_DMA_ADDRESS) exists for special DMA 
> devices not able to reach all of memory. If we do not have ZONE_DMA then the 
> architecture has to remove the definition of CONFIG_ZONE_DMA 
> and with that action told us that it is allowable to ignore GFP_DMA since 
> all devices can do DMA to all of memory (and all of memory is memory 
> without a border which is of course in ZONE_NORMAL).
> 
> GFP_DMA like GFP_HIGHMEM and GFP_DMA32 means give me memory from the zone 
> if its there. If not (the arch has no such memory) we fall back to ZONE_NORMAL.
> 
> This is fully consistent with established uses.

Given that the definition of ZONE_DMA is, I think we agree, nonsensical
in generic code anyway, whatever we do is going to be a pain.

I disagree that what you're doing is consistent with established
usage, see PPC64 for example, which I assumed you'd changed to be
consistent with what you're doing ... but it seems you haven't.

Your definition is one way of interpreting the current setup. It even
makes some sort of sense, I'll admit. However, there are other
definitions that make perfect sense too, which just goes to show that
the concept of ZONE_DMA is just a frigging inconsistent mess to start
with.

>>So if you just put all of memory in ZONE_DMA for your particular
>>machine, and bumped the DMA limit up to infinity, we wouldn't need
>>any of these patches, right? Which would also match what the other
>>arches do for this (eg PPC64).
> 
> That would mean abusing ZONE_DMA for a purpose it was not intended for. 
> ZOME_DMA is used to partition memory for a DMA not for covering all of 
> memory. That works yes but it shows a misunderstanding of the purpose for 
> which ZONE_DMA was created.

That is one possible way of defining it, but seeing as there is no
agreed to, documented definition, it's hard to tell whether this trumps
such other defined constants such as "GFP_DMA means gives me memory from
ZONE_DMA", which you're now violating.

> Also if you would do that then ZONE_NORMAL would be empty and you would 
> not be able to reach the goal of a system with a single zone. The slab 
> allocator gets thoroughly confused and waste pages allocating 
> memory in different slabs for ZONE_NORMAL and ZONE_DMA but they end up in 
> the same ZONE_DMA. Various other bits and pieces of the VM behave in 
> strange way but it works mostly. Seems that you got lucky but this should 
> be fixed.

It seems odd that PPC64 has worked fine this way for a long time then?

> ZONE_NORMAL is DMAable. GFP_DMA has never meant this is for DMA but it has 
> always meant this is for a special restricted DMA zone. That is also why 
> you have GFP_DMA32. Both GFP_DMA and GFP_DMA32 select special restricted 
> memory areas for handicapped DMA devices that are not able to reach all of 
> memory. Neither should cover all of memory.

The last sentence in this is your opinion, not an agreed-to definition.

Look, whatever we do is not going to be wholly clean, as the definitons
and requirements we start from are loose, inconsistent and somewhat
contradictary on occasion. So what we are left with is picking something
that is:

1. As consistent as possible across architectures.
2. As simple as possible.

If you can agree with the other arch maintainers (eg PPC64) that
stuffing it all in ZONE_NORMAL is somehow better than ZONE_DMA, then
maybe we can meet (1).

However, whatever you do, meeting (2) is rather hard - it's a damned
sight simpler to stuff it all in ZONE_DMA because that's the end of
the fallback list.

M.

