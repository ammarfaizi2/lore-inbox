Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262580AbSI0SVg>; Fri, 27 Sep 2002 14:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262578AbSI0SVg>; Fri, 27 Sep 2002 14:21:36 -0400
Received: from packet.digeo.com ([12.110.80.53]:45187 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262571AbSI0SV3>;
	Fri, 27 Sep 2002 14:21:29 -0400
Message-ID: <3D94A2D4.55721A8A@digeo.com>
Date: Fri, 27 Sep 2002 11:26:28 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: Ed Tomlinson <tomlins@cam.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch 3/4] slab reclaim balancing
References: <3D931608.3040702@colorfullife.com> <3D9372D3.3000908@colorfullife.com> <3D937E87.D387F358@digeo.com> <200209262041.11227.tomlins@cam.org> <3D949468.4010202@colorfullife.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Sep 2002 18:26:21.0415 (UTC) FILETIME=[60EB5770:01C26653]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> 
> Ed Tomlinson wrote:
> >
> > There is no dispute that in some cases it will be slower from a slab perspective.  As
> > Andrew and you have discussed there are things that can be done to speed things
> > up.  Is not the question really, "Are the vm and slab faster together when slab pages
> > are freed asap?"
> >
> 
> Some caches are quite bursty - what about the 2 kB generic cache that is
> used for the MTU sized socket buffers? With interrupt mitigation
> enabled, I'd expect that a GigE nic could allocate a few dozend 2kb
> objects in every interrupt, and I don't think it's the right approach to
>   effectively disable the cache in slab.c for such loads.

Well that's all rather broken at present.  Your gigE NIC has just
trashed 60k of cache-warm memory by putting it under busmastering
receive.

It would be better to use separate slabs for Rx and Tx. Rx ones
are backed by the cold page allocator and Tx ones by the hot page
allocator.  This is an improvement, but Rx is still doing suboptimal
things because it "warms up" memory and we're not taking advantage
of that.  That's starting to get tricky.

There are many things we can do.  We need to get the core in place
and start using, tuning and using it in a few places before deciding
whether to go nuts using the same technique everywhere.  I hope we do ;)

> I do not have many data points, but in a netbench run on 4-way Xeon,
> kmem_cache_free is called 5 million times/minute, and additional 4
> million calls to kfree - I agree that _reap right now is bad, but IMHO
> it's questionable if the fix should be inside the hot-path of the allocator.
> 
> What about this approach:
> 
> * enable batching even on UP, with a LIFO array in front of the lists.

That has to be right.
 
> * After flushing a batch back into the lists, the number of free objects
> in the lists is calculated. If freeable pages exist and the number
> exceeds a target, then the freeable pages above the target are returned
> to the page buddy.

Probably OK for now.  But slab should _not_ hold onto an unused,
cache-warm page.  Because do_anonymous_page() may want one.

> * The target of freeable pages is increased by kmem_cache_grow - if we
> had to get another page from gfp, then our own cache was too small.
> 
> Since the test for the number of freeable objects only happens after
> batching, i.e. in the worst case once for every 30 kmem_cache_free
> calls, it doesn't matter if it's a bit expensive.
> 
> Open problems:
> 
> * What about cache with large objects (>PAGE_SIZE, e.g. the bio
> MAX_PAGES object, or the 16 kb socket buffers used over loopback)? Right
> now, they are not cached in the per-cpu arrays, to reduce the memory
> pressure. If the list processing becomes slower, we would slow down
> these slab users. But OTHO if you memcpy 16 kB, then a few cycles in
> kmalloc probably won't matter much.
> 
> * Where to flush the per-cpu caches? On a 16-way system, they can
> contain up to 4000 objects, for each cache. Right now that happens in
> kmem_cache_reap(). One flush per second would be enough, just to avoid
> that on lightly loaded slabs, objects remain forever in the per-cpu
> arrays and prevent pages from becoming freeable.

kswapd could do that, or set up a timer and use pdflush_operation,
