Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265336AbSKKBsN>; Sun, 10 Nov 2002 20:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265345AbSKKBsN>; Sun, 10 Nov 2002 20:48:13 -0500
Received: from [195.223.140.107] ([195.223.140.107]:35461 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S265336AbSKKBsK>;
	Sun, 10 Nov 2002 20:48:10 -0500
Date: Mon, 11 Nov 2002 02:54:45 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Andrew Morton <akpm@digeo.com>, Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       marcelo@conectiva.com.br
Subject: Re: [BENCHMARK] 2.4.{18,19{-ck9},20rc1{-aa1}} with contest
Message-ID: <20021111015445.GB5343@x30.random>
References: <3DCEC6F7.E5EC1147@digeo.com> <Pine.LNX.4.44L.0211101902390.8133-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0211101902390.8133-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2002 at 07:05:01PM -0200, Rik van Riel wrote:
> On Sun, 10 Nov 2002, Andrew Morton wrote:
> > Andrea Arcangeli wrote:
> > >
> > > > Whether the IO is synchronous or asynchronous shouldn't matter much,
> > >
> > > the fact the I/O is sync or async makes the whole difference. with sync
> > > reads the vmstat line in the read column will be always very small
> > > compared to the write column under a write flood. This can be fixed either:
> > >
> > > 1) with hacks in the elevator ala read-latency that are not generic and
> > >    could decrease performance of other workloads
> 
> It'd be nice if you specified which kind of workloads. Generic

the slowdown happens in this case:

	queue 5 6 7 8 9

insert read 3

	queue 3 5 6 7 8 9

request 3 is handled by the device

	queue 5 6 7 8 9

insert read 1

	queue 1 5 6 7 8 9

request 1 is handled by the device

	queue 5 6 7 8 9

insert read 2

	queue 2 5 6 7 8 9

request 2 is handled by the device

so what happened is:

	read 3
	read 1
	read 2

while w/o read-latency what would happen most probably would been the
below, because the read 5 6 7 8 9 would give the other reads the time to
be inserted and reordered and in turn optimized:

	read 1
	read 2
	read 3

let's ignore async-io to keep it simple, there definitely the
possibility of slowing down with lots of task reading at the same time
even with only sync reads (that could be during swapping lots of major
faults at the same time during some write load or whatever else that
generates lots of tasks reading at near time during some background
writing).

Anybody claiming there isn't the potential of a global I/O throughput
slowdown would be clueless.

I know in some case it the additional seeking may allow the cpu to do
more work and that may actually increase the throughput, but this isn't
always the case, it can definitely slowdown.

all you can argue is that the decrease of latency for lots of common
interactive workloads could worth the potential of a global throghput
slowdown. On that I may agree. I wasn't very excited in merging that
because I was scared of slowdowns of workloads with async-io and
lots of tasks reading at the same time small things during writes that
as I demonstrated above can definitely happen in practice and it's
realistic. I run myself a number of workloads like that.  The current
algorithm is optimal for throughput.

However I think even read-latency is more a workarond to a problem in
the I/O queue dimensions. I think the I/O queue should be dunamically
limited to amount of data queued (in bytes not in number of requests).

We need plenty of requests only because all the requests may have 4k
only when no merging can happen, and in such case we definitely need the
elevator to do an huge work to be efficient, seeking heavily on 4k
requests (or smaller) hurts a lot, seeking on 512k requests is much less
severe.

But when each request is large 512k it is pointless to allow the same
number of requests that we allow when the requests are 4k. I think
starting with such simple fix would provide smimilar benefit of
read-latency and no corner case at all. So I would much prefer to start
with a fix like that to account for the available request size to
drivers in bytes of data in the queue, instead of in number of requests
in the queue. read-latency kind of workarounds the way too huge I/O
queue when each request is 512k in size. And it workaround it only for
reads, O_SYNC/-osync would get stuck big time against writeback load
from other files just like like reads now. The fix I propose is generic,
basically it has no downside, it is more dynamic and so I prefer it even
if may not be as direct and hard like read-latency, but that is infact what
makes it better and potentially faster in throughput than read-latency.

Going one step further we could limit the amount of bytes that each
single task can submit, so for example kupdate/bdflush couldn't fill the
queue completely anymore, and still the elevator could do an huge work
when thousand of different tasks are submitting at the same time, which
is the interesting case for the elevator, or the amount of data to
submit in the queue for each task could depend on the number of tasks
actively doing I/O in the last few seconds.

These are the fixes (I consider the limiting of bytes in the I/O queue a
fix) that I would prefer.

Infact I today think the max_bomb_segment I researched some year back
was so beneficial in terms of read-latency just because it effectively
had the effect of reducing the max amount of pending "writeback" bytes
in the queue, not really because it splitted the request in multiple dma
(in turn decreasing a lot performance because the dma chunks were way
too small to have an hope to reach the peak performance of the hardware,
and the fact performance was so hurted forced us to back it out
completely, rightly).  So I'm optimistic that reducing the size of the
queue and making it tunable from elvtune would be the first thing to do
rather than playing with the read-latency hack that just workarounds the
way too huge queue size when the merging is at its maximum and that can
hurt performance in some case.

Andrea
