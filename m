Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267864AbUHNBVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267864AbUHNBVs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 21:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267867AbUHNBVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 21:21:48 -0400
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:46433 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267864AbUHNBVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 21:21:45 -0400
Message-ID: <411D6920.9050007@yahoo.com.au>
Date: Sat, 14 Aug 2004 11:21:36 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Jesse Barnes <jbarnes@engr.sgi.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, steiner@sgi.com
Subject: Re: [PATCH] allocate page caches pages in round robin fasion
References: <200408121646.50740.jbarnes@engr.sgi.com> <200408130859.24637.jbarnes@engr.sgi.com> <89760000.1092414010@[10.10.2.4]> <200408130934.20913.jbarnes@engr.sgi.com> <92140000.1092415652@[10.10.2.4]> <411CFB04.603@yahoo.com.au> <75260000.1092431774@flay>
In-Reply-To: <75260000.1092431774@flay>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
>>>Well, either we're:
>>>
>>>1. Falling back and putting all our most recent accesses off-node.
>>>
>>>or.
>>>
>>>2. Not falling back and only able to use one node's memory for any one 
>>>(single threaded) app.
>>>
>>>Either situation is crap, though I'm not sure which turd we picked right
>>>now ... I'd have to look at the code again ;-) I thought it was 2, but
>>>I might be wrong.
>>> 
>>
>>I'm looking at this now. We are doing 1 currently.
> 
> 
> In theory, yes. In practice, I have a feeling kswapd will keep us above
> the level of free memory where we'd fall back to another zone to allocate,
> won't it?
>  

Nope. Take a look at the first loop-through-the-zones in alloc_pages
(preferably in akpm's tree that is cleaned up a bit).

We go through *all* zones first and allocate them down to pages_low
before kicking kswapd.

I have tried kicking kswapd before going off node, but it frees memory
really aggressively - so you're nearly left with a local alloc policy.

> 
>>There are a couple of issues. The first is that you need to minimise
>>regressions for when working set size is bigger than the local node.
> 
> 
> Good point ... that is, indeed, a total bitch to fix.
> 

At the end of the day we'll possibly just have to have a sysctl. I
don't think all regressions could be eliminated completely. We'll
see.

> 
>>I have a patch going now that just reclaims use-once file cache before
>>going off node. Seems to help a bit for basic things that just push
>>pagecache through the system. It definitely reduces remote allocations
>>by several orders of magnitude for those cases.
> 
> 
> Makes sense, but doesn't the same thing make sense on a global basis?
> I don't feel NUMA is anything magical here ...
> 

Didn't parse that. If you mean the transition from highmem->normal->dma
zones, I don't think that should be treated in this way. Imagine small
highmem zones for example. We have the lower zone protection in place
for that case - and that is something that in turn isn't good for NUMA,
because the SGI guys (I think) already ran into that and fixed it to be
per-node only.
