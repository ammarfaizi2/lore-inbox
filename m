Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261441AbSIZSmj>; Thu, 26 Sep 2002 14:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261442AbSIZSmj>; Thu, 26 Sep 2002 14:42:39 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:42645 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261441AbSIZSmi>;
	Thu, 26 Sep 2002 14:42:38 -0400
Message-ID: <3D935655.1030606@colorfullife.com>
Date: Thu, 26 Sep 2002 20:47:49 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: Ed Tomlinson <tomlins@cam.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch 3/4] slab reclaim balancing
References: <3D931608.3040702@colorfullife.com> <3D9345C4.74CD73B8@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> (What Ed said - we do hang onto one page.  And I _have_ measured
> cost in kmem_cache_shrink...)
> 
I totally agree about kmem_cache_shrink - it's total abuse that 
fs/dcache.c calls it regularly. It was intended to be called before 
module unload, or during ifdown, etc.
On NUMA, it's probably worse, because it does an IPI to all cpus. 
dcache.c should not call kmem_cache_shrink, and kmem_cache_reap should 
be improved.

> Before:
> Elapsed: 20.18s User: 192.914s System: 48.292s CPU: 1195.6%
> 
> After:
> Elapsed: 19.798s User: 191.61s System: 43.322s CPU: 1186.4%
> 
> That's for a kernel compile.
> 
UP or SMP?
And was that the complete patch, or just the modification to slab.c?

I've made a microbenchmark of kmem_cache_alloc/free of 4 kb objects, on 
UP, AMD Duron:
		1 object	4 objects
cur		145 cycles	 662 cycles
patched		133 cycles	2733 cycles

Summary:
* for one object, the patch is a slight performance improvement. The 
reason is that the fallback from partial to free list in 
kmem_cache_alloc_one is avoided.
* the overhead of kmem_cache_grow/shrink is around 500 cycles, nearly a 
slowdown of factor 4. The cache had no constructor/destructor.
* everything cache hot state. [100 runs in a loop, loop overhead 
substracted. 98 or 99 runs completed in the given time, except for 
patched-4obj, where 24 runs completed in 2735 cycles, 72 in 2733 cycles]


For SMP and slabs that are per-cpu cached, the change could be right, 
because the arrays should absorb bursts. But I do not think that the 
change is the right approach for UP.

--
	Manfred

