Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318116AbSIOQxD>; Sun, 15 Sep 2002 12:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318121AbSIOQxD>; Sun, 15 Sep 2002 12:53:03 -0400
Received: from packet.digeo.com ([12.110.80.53]:17295 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S318116AbSIOQxC>;
	Sun, 15 Sep 2002 12:53:02 -0400
Message-ID: <3D84BFC8.2D8A7592@digeo.com>
Date: Sun, 15 Sep 2002 10:13:44 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Daniel Phillips <phillips@arcor.de>, lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.34-mm2
References: <3D841C8A.682E6A5C@digeo.com> <Pine.LNX.4.44L.0209151156080.1857-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Sep 2002 16:57:52.0017 (UTC) FILETIME=[07508010:01C25CD9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Sat, 14 Sep 2002, Andrew Morton wrote:
> > Daniel Phillips wrote:
> 
> > > but that sure looks like the low hanging fruit.
> >
> > It's low alright.  AFAIK Linux has always had this problem of
> > seizing up when there's a lot of dirty data around.
> 
> Somehow I doubt the "seizing up" problem is caused by too much
> scanning.  In fact, I'm pretty convinced it is caused by having
> too much IO submitted at once (and stalling in __get_request_wait).

Yes, the latency is due to request queue contention.

Dirty data reaches the tail of the LRU and "innocent" processes are
forced to write it.  But the queue is full.  They sleep until 32
requests are free.  They wake; but so does the heavy dirtier.  The
heavy dirtier immediately fills the queue again.  The innocent
page allocator finds some more dirty data.  Repeat.

It's DoS-via-request queue.  It's made worse by the fact that
kswapd is also DoS'ed, so pretty much all tasks need to perform
direct reclaim.

There are also latency problems, with similar causes, when page-allocating
processes encounter under-writeback pages at the tail of the LRU, but
this happens less often.

> The scanning is probably not relevant at all and it may be
> beneficial to just ignore the scanning for now and do our best
> to keep the pages in better LRU order.
> 

Yes, I'm not particularly fussed about (moderate) excess CPU use in these
situations, and nor about page replacement accuracy, really - pages
are being slushed through the system so fast that correct aging of the
ones on the inactive list probably just doesn't count.

The use of "how much did we scan" to determine when we're out
of memory is a bit of a problem; but the main problem (of which
I'm aware) is that the global throttling via blk_congestion_wait()
is not a sufficiently accurate indication that "pages came clean
in ZONE_NORMAL" on big highmem boxes.

Processes which are performing GFP_KERNEL allocations can keep
on getting woken up for ZONE_HIGHMEM completion, and they eventually
decide it's OOM.  This has only been observed when the dirty memory
limits are manually increased a lot, but it points to a design problem.

I don't know what's going on in `contest', nor in Alex's X build.  We'll
see...
