Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261542AbSIZVeI>; Thu, 26 Sep 2002 17:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261545AbSIZVeI>; Thu, 26 Sep 2002 17:34:08 -0400
Received: from packet.digeo.com ([12.110.80.53]:49645 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261542AbSIZVeG>;
	Thu, 26 Sep 2002 17:34:06 -0400
Message-ID: <3D937E87.D387F358@digeo.com>
Date: Thu, 26 Sep 2002 14:39:19 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: Ed Tomlinson <tomlins@cam.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch 3/4] slab reclaim balancing
References: <3D931608.3040702@colorfullife.com> <3D9345C4.74CD73B8@digeo.com> <3D935655.1030606@colorfullife.com> <3D9364BA.A2CA02C5@digeo.com> <3D9372D3.3000908@colorfullife.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Sep 2002 21:39:16.0018 (UTC) FILETIME=[2981D920:01C265A5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> 
> Andrew Morton wrote:
> >
> > Was the microbenchmark actually touching the memory which it was
> > allocating from slab?  If so then yes, we'd expect to see cache
> > misses against those cold pages coming out of the buddy.
> >
> 
> No, it was just measuring the cost of the kmem_cache_grow/shrink.
> 
> Btw, 140 cycles for kmem_cache_alloc+free is inflated - someone enabled
> kmem_cache_alloc_head() even in the no-debugging version.
> As expected, done by Andrea, who neither bothered to cc me, nor actually
> understood the code.

hm, OK.  Sorry, I did not realise that you were this closely
interested/involved with slab, so things have been sort of
going on behind your back :(

> >
> >>For SMP and slabs that are per-cpu cached, the change could be right,
> >>because the arrays should absorb bursts. But I do not think that the
> >>change is the right approach for UP.
> >
> >
> > I'd suggest that we wait until we have slab freeing its pages into
> > the hotlists, and allocating from them.  That should pull things back.
>  >
> You are asking a interesting question:
> 
> The slab is by design far from LIFO - it tries to find pages with no
> allocated objects, that are possible to return to the page allocator. It
> doesn't try to optimize for cache hit rates.
> 
> Is that actually the right approach? For large objects, it would be
> possible to cripple the freeable slabs list, and to perform the cache
> hit optimization (i.e. per-cpu LIFO) in page_alloc.c, but that doesn't
> work with small objects.

Well with a, what? 100:1 speed ratio, we'll generally get best results
from optimising for locality/recency of reference.

> On SMP, the per-cpu arrays are the LIFO and should give good cache hit
> rates. On UP, I haven't enabled them, because they could increase the
> internal fragmentation of the slabs.
>
> Perhaps we should enable the arrays on UP, too, and thus improve the
> cache hit rates? If there is no increase in fragmentation, we could
> ignore it. Otherwise we could replace the 3-list Bonwick slab with
> another backend, something that's stronger at reducing the internal
> fragmentation.

Definitely worthy of investigation.  Memory sizes are increasing,
and the cached-versus-noncached latencies are increasing.  Both
these say "optimise for cache hits".

Plus we'd lose a ton of ifdefs if we enabled it on UP as well...

Bill wrote a couple of handy slab-monitoring tools, btw.
http://www.zip.com.au/~akpm/linux/patches/ - I use bloatmeter.
