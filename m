Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265457AbSKKEP7>; Sun, 10 Nov 2002 23:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265459AbSKKEP7>; Sun, 10 Nov 2002 23:15:59 -0500
Received: from packet.digeo.com ([12.110.80.53]:47818 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265457AbSKKEP6>;
	Sun, 10 Nov 2002 23:15:58 -0500
Message-ID: <3DCF308E.166FAADF@digeo.com>
Date: Sun, 10 Nov 2002 20:22:38 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Rik van Riel <riel@conectiva.com.br>, Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       marcelo@conectiva.com.br
Subject: Re: [BENCHMARK] 2.4.{18,19{-ck9},20rc1{-aa1}} with contest
References: <3DCEC6F7.E5EC1147@digeo.com> <Pine.LNX.4.44L.0211101902390.8133-100000@imladris.surriel.com> <20021111015445.GB5343@x30.random> <3DCF2BF5.5DD165DD@digeo.com> <20021111040642.GA30193@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Nov 2002 04:22:38.0524 (UTC) FILETIME=[F7E9EFC0:01C28939]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> On Sun, Nov 10, 2002 at 08:03:01PM -0800, Andrew Morton wrote:
> > Andrea Arcangeli wrote:
> > >
> > > the slowdown happens in this case:
> > >
> > >         queue 5 6 7 8 9
> > >
> > > insert read 3
> > >
> > >         queue 3 5 6 7 8 9
> >
> > read-latency will not do that.
> 
> So what will it do? Must do something very much like what I described or
> it is a noop period. Please elaborate.

If a read was not merged with another read on the tail->head walk
the read will be inserted near the head.  The head->tail walk bypasses
all reads, six (default) writes and then inserts the new read.

It has the shortcoming that earlier reads may be walked past in the
tail->head phase.  It's a three-liner to prevent that but I was never
able to demonstrate any difference.

> >
> > > However I think even read-latency is more a workarond to a problem in
> > > the I/O queue dimensions.
> >
> > The problem is the 2.4 algorithm.  If a read is not mergeable or
> > insertable it is placed at the tail of the queue.  Which is the
> > worst possible place it can be put because applications wait on
> > reads, not on writes.
> 
> O_SYNC/-osync waits on writes too, so are you saying writes must go to
> the head because of that?

It has been discussed: boost a request to head-of-queue when a thread
starts to wait on a buffer/page which is inside that request.

But we don't care about synchronous writes.  As long as we don't
starve them out completely, optimise the (vastly more) common case.

> reads should be not too bad at the end too if
> only the queue wasn't that oversized when the merging is at its maximum.
> Fix the oversizing of the queue, then read-latency will matter much
> less.

Think about two threads.  One is generating a stream of writes and
the other is trying to read a file.  The reader needs to read the 
directory, the inode, the first data blocks, the first indirect and
then some more data blocks.  That's at least three synchronous reads.
Even if those reads are placed just three requests from head-of-queue,
the reader will make one tenth of the progress of the writer.

And the current code places those reads 64 requests from head-of-queue.

When the various things which were congesting write queueing were fixed
in the 2.5 VM a streaming write was slowing such read operations down by
a factor of 4000.
