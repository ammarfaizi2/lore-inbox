Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265532AbSKKFEE>; Mon, 11 Nov 2002 00:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265533AbSKKFEE>; Mon, 11 Nov 2002 00:04:04 -0500
Received: from packet.digeo.com ([12.110.80.53]:19915 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265532AbSKKFEB>;
	Mon, 11 Nov 2002 00:04:01 -0500
Message-ID: <3DCF3BD1.4A95617D@digeo.com>
Date: Sun, 10 Nov 2002 21:10:41 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Rik van Riel <riel@conectiva.com.br>, Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       marcelo@conectiva.com.br
Subject: Re: [BENCHMARK] 2.4.{18,19{-ck9},20rc1{-aa1}} with contest
References: <3DCEC6F7.E5EC1147@digeo.com> <Pine.LNX.4.44L.0211101902390.8133-100000@imladris.surriel.com> <20021111015445.GB5343@x30.random> <3DCF2BF5.5DD165DD@digeo.com> <20021111040642.GA30193@dualathlon.random> <3DCF308E.166FAADF@digeo.com> <20021111043941.GB30193@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Nov 2002 05:10:41.0737 (UTC) FILETIME=[AE715390:01C28940]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> from your description it seems what will happen is:
> 
>         queue 3 5 6 7 8 9
> 
> I don't see why you say it won't do that. the whole point of the patch
> to put reads at or near the head, and you say 3 won't be put at the
> head if only 5 writes are pending. Or maybe your bypasses "6 writes"
> means the other way around, that you put the read as the seventh entry
> in the queue if there are 6 writes pending, is it the case?

Actually I thought your "queue" was "head of queue" and that 5,6,7,8 and 9
were reads....

If the queue contains, say:

(head)	R1 R2 R3 W1 W2 W3 W4 W5 W6 W7

Then a new R4 will be inserted between W6 and W7.  So if R5 is mergeable
with R4 there is still plenty of time for that.


> > > > > However I think even read-latency is more a workarond to a
> > > > > problem in
> > > > > the I/O queue dimensions.
> > > >
> > > > The problem is the 2.4 algorithm.  If a read is not mergeable or
> > > > insertable it is placed at the tail of the queue.  Which is the
> > > > worst possible place it can be put because applications wait on
> > > > reads, not on writes.
> > >
> > > O_SYNC/-osync waits on writes too, so are you saying writes must go to
> > > the head because of that?
> >
> > It has been discussed: boost a request to head-of-queue when a thread
> > starts to wait on a buffer/page which is inside that request.
> >
> > But we don't care about synchronous writes.  As long as we don't
> > starve them out completely, optimise the (vastly more) common case.
> 
> yes, it should be worthwhile to potentially decrease a little the global
> throughput to increase significantly the read latency, I'm not against
> that, but before I would care about that I prefer to get a limit on the
> size of the queue in bytes, not in requests,

Really, it should be in terms of "time".  If you assume 6 msec seek and
30 mbyte/sec bandwidth, the crossover is a 120 kbyte I/O.  Not that I'm
sure this means anything interesting ;)  But the lesson is that the
size of a request isn't very important.

> actually it's probably much worse tha a 10 times ratio since the writer
> is going to use big requests, while the reader is probably seeking with
> <=4k requests.
> 

Yup.  This is one case where improving latency improves throughput,
if there's computational work to be done.

2.5 (and read-latency) sort-of solve these problems by creating a
massive seekstorm when there are competing reads and writes.  It's
a pretty sad solution really.

Better would be to perform those reads and writes in nice big batches.
That's easy for the writes, but for reads we need to wait for the
application to submit another one.  That means actually deliberately
leaving the disk head idle for a few milliseconds in the anticipation
that the application will submit another nearby read.  This is called
"anticipatory scheduling" and has been shown to provide 20%-70%
performance boost in web serving workloads.   It just makes heaps of
sense to me and I'd love to see it in Linux...

See http://www.cs.ucsd.edu/sosp01/papers/iyer.pdf
