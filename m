Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261491AbSIZUoO>; Thu, 26 Sep 2002 16:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261492AbSIZUoO>; Thu, 26 Sep 2002 16:44:14 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:2198 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261491AbSIZUoM>;
	Thu, 26 Sep 2002 16:44:12 -0400
Message-ID: <3D9372D3.3000908@colorfullife.com>
Date: Thu, 26 Sep 2002 22:49:23 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: Ed Tomlinson <tomlins@cam.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch 3/4] slab reclaim balancing
References: <3D931608.3040702@colorfullife.com> <3D9345C4.74CD73B8@digeo.com> <3D935655.1030606@colorfullife.com> <3D9364BA.A2CA02C5@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Was the microbenchmark actually touching the memory which it was
> allocating from slab?  If so then yes, we'd expect to see cache
> misses against those cold pages coming out of the buddy.
>  

No, it was just measuring the cost of the kmem_cache_grow/shrink.

Btw, 140 cycles for kmem_cache_alloc+free is inflated - someone enabled 
kmem_cache_alloc_head() even in the no-debugging version.
As expected, done by Andrea, who neither bothered to cc me, nor actually 
understood the code.

> 
>>For SMP and slabs that are per-cpu cached, the change could be right,
>>because the arrays should absorb bursts. But I do not think that the
>>change is the right approach for UP.
> 
> 
> I'd suggest that we wait until we have slab freeing its pages into
> the hotlists, and allocating from them.  That should pull things back.
 >
You are asking a interesting question:

The slab is by design far from LIFO - it tries to find pages with no 
allocated objects, that are possible to return to the page allocator. It 
doesn't try to optimize for cache hit rates.

Is that actually the right approach? For large objects, it would be 
possible to cripple the freeable slabs list, and to perform the cache 
hit optimization (i.e. per-cpu LIFO) in page_alloc.c, but that doesn't 
work with small objects.

On SMP, the per-cpu arrays are the LIFO and should give good cache hit 
rates. On UP, I haven't enabled them, because they could increase the 
internal fragmentation of the slabs.

Perhaps we should enable the arrays on UP, too, and thus improve the 
cache hit rates? If there is no increase in fragmentation, we could 
ignore it. Otherwise we could replace the 3-list Bonwick slab with 
another backend, something that's stronger at reducing the internal 
fragmentation.

--
	Manfred


