Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265516AbSKKEdR>; Sun, 10 Nov 2002 23:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265521AbSKKEdR>; Sun, 10 Nov 2002 23:33:17 -0500
Received: from [195.223.140.107] ([195.223.140.107]:38021 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S265516AbSKKEdP>;
	Sun, 10 Nov 2002 23:33:15 -0500
Date: Mon, 11 Nov 2002 05:39:41 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Rik van Riel <riel@conectiva.com.br>, Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       marcelo@conectiva.com.br
Subject: Re: [BENCHMARK] 2.4.{18,19{-ck9},20rc1{-aa1}} with contest
Message-ID: <20021111043941.GB30193@dualathlon.random>
References: <3DCEC6F7.E5EC1147@digeo.com> <Pine.LNX.4.44L.0211101902390.8133-100000@imladris.surriel.com> <20021111015445.GB5343@x30.random> <3DCF2BF5.5DD165DD@digeo.com> <20021111040642.GA30193@dualathlon.random> <3DCF308E.166FAADF@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DCF308E.166FAADF@digeo.com>
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2002 at 08:22:38PM -0800, Andrew Morton wrote:
> Andrea Arcangeli wrote:
> > 
> > On Sun, Nov 10, 2002 at 08:03:01PM -0800, Andrew Morton wrote:
> > > Andrea Arcangeli wrote:
> > > >
> > > > the slowdown happens in this case:
> > > >
> > > >         queue 5 6 7 8 9
> > > >
> > > > insert read 3
> > > >
> > > >         queue 3 5 6 7 8 9
> > >
> > > read-latency will not do that.
> > 
> > So what will it do? Must do something very much like what I described or
> > it is a noop period. Please elaborate.
> 
> If a read was not merged with another read on the tail->head walk
> the read will be inserted near the head.  The head->tail walk bypasses
> all reads, six (default) writes and then inserts the new read.
> 
> It has the shortcoming that earlier reads may be walked past in the
> tail->head phase.  It's a three-liner to prevent that but I was never
> able to demonstrate any difference.

from your description it seems what will happen is:

	queue 3 5 6 7 8 9

I don't see why you say it won't do that. the whole point of the patch
to put reads at or near the head, and you say 3 won't be put at the
head if only 5 writes are pending. Or maybe your bypasses "6 writes"
means the other way around, that you put the read as the seventh entry
in the queue if there are 6 writes pending, is it the case?

> > > > However I think even read-latency is more a workarond to a
> > > > problem in
> > > > the I/O queue dimensions.
> > >
> > > The problem is the 2.4 algorithm.  If a read is not mergeable or
> > > insertable it is placed at the tail of the queue.  Which is the
> > > worst possible place it can be put because applications wait on
> > > reads, not on writes.
> > 
> > O_SYNC/-osync waits on writes too, so are you saying writes must go to
> > the head because of that?
> 
> It has been discussed: boost a request to head-of-queue when a thread
> starts to wait on a buffer/page which is inside that request.
> 
> But we don't care about synchronous writes.  As long as we don't
> starve them out completely, optimise the (vastly more) common case.

yes, it should be worthwhile to potentially decrease a little the global
throughput to increase significantly the read latency, I'm not against
that, but before I would care about that I prefer to get a limit on the
size of the queue in bytes, not in requests, that is a generic issue for
writes and read-async-io too, it's a task against task fairness/latency
matter, not specific to reads, but it should help read latency
visibly too. In any case the two things are orthogonal, if the queue is
smaller read-latency will do even better.

> > reads should be not too bad at the end too if
> > only the queue wasn't that oversized when the merging is at its maximum.
> > Fix the oversizing of the queue, then read-latency will matter much
> > less.
> 
> Think about two threads.  One is generating a stream of writes and
> the other is trying to read a file.  The reader needs to read the 
> directory, the inode, the first data blocks, the first indirect and
> then some more data blocks.  That's at least three synchronous reads.

sure I know the problem with sync reads.

> Even if those reads are placed just three requests from head-of-queue,
> the reader will make one tenth of the progress of the writer.

actually it's probably much worse tha a 10 times ratio since the writer
is going to use big requests, while the reader is probably seeking with
<=4k requests.

> And the current code places those reads 64 requests from head-of-queue.
> 
> When the various things which were congesting write queueing were fixed
> in the 2.5 VM a streaming write was slowing such read operations down by
> a factor of 4000.


Andrea
