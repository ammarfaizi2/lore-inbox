Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964780AbWESXZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbWESXZs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 19:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964784AbWESXZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 19:25:48 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:22453 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S964780AbWESXZr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 19:25:47 -0400
Date: Sat, 20 May 2006 00:25:43 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Andrew Morton <akpm@osdl.org>
Cc: nickpiggin@yahoo.com.au, haveblue@us.ibm.com, ak@suse.de, bob.picco@hp.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, apw@shadowen.org,
       mingo@elte.hu, mbligh@mbligh.org
Subject: Re: [PATCH 1/2] Align the node_mem_map endpoints to a MAX_ORDER
 boundary
In-Reply-To: <20060519134948.10992ba1.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0605192358060.12335@skynet.skynet.ie>
References: <20060519134241.29021.84756.sendpatchset@skynet>
 <20060519134301.29021.71137.sendpatchset@skynet> <20060519134948.10992ba1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 May 2006, Andrew Morton wrote:

> Mel Gorman <mel@csn.ul.ie> wrote:
>>
>> Andy added code to buddy allocator which does not require the zone's
>> endpoints to be aligned to MAX_ORDER. An issue is that the buddy
>> allocator requires the node_mem_map's endpoints to be MAX_ORDER aligned.
>> Otherwise __page_find_buddy could compute a buddy not in node_mem_map for
>> partial MAX_ORDER regions at zone's endpoints. page_is_buddy will detect
>> that these pages at endpoints are not PG_buddy (they were zeroed out by
>> bootmem allocator and not part of zone). Of course the negative here is
>> we could waste a little memory but the positive is eliminating all the
>> old checks for zone boundary conditions.
>>
>> SPARSEMEM won't encounter this issue because of MAX_ORDER size constraint
>> when SPARSEMEM is configured. ia64 VIRTUAL_MEM_MAP doesn't need the
>> logic either because the holes and endpoints are handled differently.
>> This leaves checking alloc_remap and other arches which privately allocate
>> for node_mem_map.
>
> Do we think we need this in 2.6.17?
>

I think so. Not all architectures are making sure their node_start_pfn is 
aligned to a boundary. For example, x86_64 does, ia64 may align depending 
on the value of MAX_ORDER and i386 does not appear to make any effort. No 
one seems to be making any special effort to align the end of the zone at 
all. This potentially means that the buddy allocator is checking portions 
of memory as if they were struct page * when they are something totally 
different. I suspect it's just luck that the memory outside of the mem_map 
never looked like buddies.

Anyone else care to comment?

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
