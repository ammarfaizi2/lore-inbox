Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262617AbSI0Tra>; Fri, 27 Sep 2002 15:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262616AbSI0Tr3>; Fri, 27 Sep 2002 15:47:29 -0400
Received: from packet.digeo.com ([12.110.80.53]:54662 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262612AbSI0Tqz>;
	Fri, 27 Sep 2002 15:46:55 -0400
Message-ID: <3D94B6EF.58434CC1@digeo.com>
Date: Fri, 27 Sep 2002 12:52:15 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: Ed Tomlinson <tomlins@cam.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch 3/4] slab reclaim balancing
References: <3D931608.3040702@colorfullife.com> <3D9372D3.3000908@colorfullife.com> <3D937E87.D387F358@digeo.com> <200209262041.11227.tomlins@cam.org> <3D949468.4010202@colorfullife.com> <3D94A2D4.55721A8A@digeo.com> <3D94B3B4.6090409@colorfullife.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Sep 2002 19:52:08.0193 (UTC) FILETIME=[5CA35710:01C2665F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> 
> Andrew Morton wrote:
> >
> >>* After flushing a batch back into the lists, the number of free objects
> >>in the lists is calculated. If freeable pages exist and the number
> >>exceeds a target, then the freeable pages above the target are returned
> >>to the page buddy.
> >
> >
> > Probably OK for now.  But slab should _not_ hold onto an unused,
> > cache-warm page.  Because do_anonymous_page() may want one.
> >
> If the per-cpu caches are enabled on UP, too, then this is a moot point:
> by the time a batch is freed from the per-cpu array, it will be cache cold.

Well yes, it's all smoke, mirrors and wishful thinking.  All we can
do is to apply local knowledge of typical behaviour in deciding whether
a page is likely to be usefully reused.

> And btw, why do you think a page is cache-warm when the last object on a
>   page is freed? If the last 32-byte kmalloc is released on a page, 40xx
> bytes are probably cache-cold.

L2 caches are hundreds of K, and a single P4 cacheline is 1/32nd of
a page.  Things are tending in that direction.
 
> Back to your first problem: You've mentioned excess hits on the
> cache_chain_semaphore. Which app did you use for stress testing?

I think it was dd-to-six-disks.

> Could you run a stress test with the applied patch?

Shall try to.

> I've tried dbench 50, with 128 MB RAM, on uniprocessor, with 2.4:
> 
> There were 9100 calls to kmem_cache_reap, and in 90% of the calls, no
> freeable memory was found. Alltogether, only 1300 pages were freed from
> the slabs.
> 
> Are there just too many calls to kmem_cache_reap()? Perhaps we should
> try to optimize the "nothing freeable exists" logic?

It certainly sounds like it.  Some sort of counter which is accessed
outside locks would be appropriate.  Test that before deciding to
take the lock.
