Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265135AbSKJUEL>; Sun, 10 Nov 2002 15:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265138AbSKJUEL>; Sun, 10 Nov 2002 15:04:11 -0500
Received: from [195.223.140.107] ([195.223.140.107]:32645 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S265135AbSKJUEJ>;
	Sun, 10 Nov 2002 15:04:09 -0500
Date: Sun, 10 Nov 2002 21:10:45 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       marcelo@conectiva.com.br
Subject: Re: [BENCHMARK] 2.4.{18,19{-ck9},20rc1{-aa1}} with contest
Message-ID: <20021110201045.GA4056@x30.random>
References: <20021110024451.GE2544@x30.random> <Pine.LNX.4.44L.0211101727230.8133-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0211101727230.8133-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2002 at 05:32:44PM -0200, Rik van Riel wrote:
> On Sun, 10 Nov 2002, Andrea Arcangeli wrote:
> > On Sat, Nov 09, 2002 at 01:00:19PM +1100, Con Kolivas wrote:
> 
> > > 2.4.19-ck9 [2]          78.3    88      31      8       1.10
> > > 2.4.20-rc1 [3]          105.9   69      32      2       1.48
> > > 2.4.20-rc1aa1 [1]       106.3   69      33      3       1.49
> >
> > again ck9 is faster because of elevator hacks ala read-latency.
> >
> > in short your whole benchmark seems all about interacitivy of reads
> > during write flood.
> 
> Which is a very important thing.  You have to keep in mind that

sure, this is why I fixed the potential ~infinite starvation in the 2.3
elevator.

> reads and writes are fundamentally different operations since
> the majority of the writes happen asynchronously while the program
> continues running, while the majority of reads are synchronous and
> your program will block while the read is going on.
> 
> Because of this it is also much easier to do writes in large chunks
> than it is to do reads in large chunks, because with writes you
> know exactly what data you're going to write while you can't know
> which data you'll need to read next.
> 
> > All the difference is there and it will hurt you badly if you do
> > async-io benchmarks,
> 
> Why would read-latency hurt the async-io benchmark ?

because only with async-io it is possible to keep the I/O pipeline
filled by reads. readahead only allows to do read-I/O in large chunks,
it has no way to fill the pipeline.

Infact the size of the request queue is the foundamental factor that
controls read latency during heavy writes without special heuristics ala
read-latency. 

In short without async-io there is no way at all that a read application
can read at a decent speed during a write flood, unless you have special
hacks in the elevator ala read-latency that allows reads to enter in the
front of the queue, which reduces the chance to reorder reads and
potentially decreases performance on a async-io benchmark even in
presence of seeks.

> Whether the IO is synchronous or asynchronous shouldn't matter much,

the fact the I/O is sync or async makes the whole difference. with sync
reads the vmstat line in the read column will be always very small
compared to the write column under a write flood. This can be fixed either:

1) with hacks in the elevator ala read-latency that are not generic and
   could decrease performance of other workloads
2) reducing the size of the I/O queue, that may decrease performance
   also with seeks since it decreases the probaility of reordering in
   the elevator
3) by having the app using async-io for reads allowing it to keep the
   I/O pipeline full with reads

readahead, at least in its current form, only make sure that a 512k
command will be submitted instead of a 4k command, that's not remotely
comparable to writeback that floods the I/O queue constnatly with
several dozen or hundred mbytes of data. Increasing readhaead is also
risky, 512k is kind of obviously safe in all circumstances since it's a
single dma command anyways (and 128k for ide).

I'm starting benchmarking 2.4.20rc1aa against 2.4.19-ck9 under dbench
right now (then I'll run the contest), I can't imagine how can it be
that much faster under dbench, -aa is almost as fast as 2.5 in dbench
and much faster than 2.4 mainline, so if 19-ck9 is really that much
faster than -aa then it is likely much faster than 2.5 too. I definitely
need to examine in full detail what's going on with 2.4.19-ck9. Once I
will understand it I will let you know. For istance I know Randy's
numbers are fully reliable and I trust them:

	http://home.earthlink.net/~rwhron/kernel/bigbox.html

I find Randy's number extremely useful. Of course it's great to see also
the responsiveness side of a kernel, but dbench isn't normally a
benchmark that needs responsiveness, quite the opposite, the most unfair
is the behaviour of vm and elevator, the faster usually dbench runs,
because with unfariness dbench tends to run kind of single threaded that
maximizes at most the writeback effect etc... So if 2.4.19-ck9 is so
much faster under dbench and so much more responsive with the contest
that seems to benchmark basically only the read latency under writeback
flushing flood, then it is definitely worthwhile to produce a patch
against mainline that generates this boost. If it has the preemption
patch that could hardly explain it too, the improvement from 45 MB/sec
to 65 MB/sec there's quite an huge difference and we have all the
schedule points in the submit_bh too, so it's quite unlikely that
preempt could explain that difference, it might against a mainline, but
not against my tree.

Anyways this is all guessing, once I'll check the code after I
reproduced the numbers things should be much more clear.

Andrea
