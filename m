Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313238AbSE1JZ3>; Tue, 28 May 2002 05:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313293AbSE1JZ2>; Tue, 28 May 2002 05:25:28 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:31941 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S313238AbSE1JZ2>;
	Tue, 28 May 2002 05:25:28 -0400
Date: Tue, 28 May 2002 11:25:03 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: William Lee Irwin III <wli@holomorphy.com>,
        Giuliano Pochini <pochini@shiny.it>, linux-kernel@vger.kernel.org,
        "chen, xiangping" <chen_xiangping@emc.com>
Subject: Re: Poor read performance when sequential write presents
Message-ID: <20020528092503.GJ17674@suse.de>
In-Reply-To: <3CED4843.2783B568@zip.com.au> <XFMail.20020524105942.pochini@shiny.it> <3CEE0758.27110CAD@zip.com.au> <20020524094606.GH14918@holomorphy.com> <3CEE1035.1E67E1B8@zip.com.au> <20020527080632.GC17674@suse.de> <3CF1ECD1.A1BB2CF1@zip.com.au> <20020527085414.GD17674@suse.de> <3CF1FDF8.B775DF44@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27 2002, Andrew Morton wrote:
> > On Mon, May 27 2002, Andrew Morton wrote:
> > > Jens Axboe wrote:
> > > >
> > > > ...
> > > > > But in 2.5, head-activeness went away and as far as I know, IDE and SCSI are
> > > > > treated the same.  Odd.
> > > >
> > > > It didn't really go away, it just gets handled automatically now.
> > > > elv_next_request() marks the request as started, in which case the i/o
> > > > scheduler won't consider it for merging etc. SCSI removes the request
> > > > directly after it has been marked started, while IDE leaves it on the
> > > > queue until it completes. For IDE TCQ, the behaviour is the same as with
> > > > SCSI.
> > >
> > > It won't consider the active request at the head of the queue for
> > > merging (making the request larger).  But it _could_ consider the
> > > request when making decisions about insertion (adding a new request
> > > at the head of the queue because it's close-on-disk to the active
> > > one).   Does it do that?
> > 
> > Only when the front request isn't active is it safe to consider
> > insertion in front of it. 2.5 does that exactly because it knows if the
> > request has been started, while 2.4 has to guess by looking at the
> > head-active flag and the plug status.
> > 
> > If the request is started, we will only consider placing in front of the
> > 2nd request not after the 1st. We could consider in between 1st and 2nd,
> > that should be safe. In fact that should be perfectly safe, just move
> > the barrier and started test down after the insert test. *req is the
> > insert-after point.
> 
> Makes sense.  I suspect it may even worsen the problem I observed
> with the mpage code.  Set the readahead to 256k with `blockdev --setra 512'
> and then run tiobench.  The read latencies are massive - one thread
> gets hold of the disk head and hogs it for 30-60 seconds.
> 
> The readahead code has a sort of double-window design.  The idea is that
> if the disk does 50 megs/sec and your application processes data at
> 49 megs/sec, the application will never block on I/O.  At 256k readahead,
> the readahead code will be laying out four BIOs at a time.  It's probable
> that the application is actually submitting BIOs for a new readahead
> window before all of the BIOs for the old one are complete.  So it's
> performing merging against its own reads.
> 
> Given all this, what I would expect to see is for thread "A" to capture
> the disk head for some period of time, until eventually one of thread "B"'s
> requests expires its latency.  Then thread "B" gets to hog the disk head.
> That's reasonable behaviour,  but the latencies are *enormous*.  Almost
> like the latency stuff isn't working.  But it sure looks OK.

I'm still waiting for some time to implement some nicer i/o scheduling
algorithms, I'd be sad to see elevator_linus be the default for 2.6. For
now it's just receiving the odd fixes here and there which do make small
improvements.

> Not super-high priority at this time.  I'll play with it some more.
> (Some userspace tunables for the elevator would be nice.  Hint. ;))

Agreed :-)

> hmm.  Actually the code looks a bit odd:
> 
>                 if (elv_linus_sequence(__rq)-- <= 0)
>                         break;
>                 if (!(__rq->flags & REQ_CMD))
>                         continue;
>                 if (elv_linus_sequence(__rq) < bio_sectors(bio))
>                         break;
> 
> The first decrement is saying that elv_linus_sequence is in units of
> requests, but the comparison (and the later `-= bio_sectors()') seems
> to be saying it's in units of sectors.

Well, it really is in units of sectors in 2.5, the first decrement is a
scan aging measure.

> I think calculating the latency in terms of requests makes more sense - just
> ignore the actual size of those requests (or weight it down in some manner).
> But I don't immediately see what the above code is up to?

That might make more sense, but again it's not likely to make
elevator_linus too tolerable anyways. You can easily changes the
read/write initial sequences to be >> 2 what they are now, and just
account seeks. The end result would be very similar, though :-)

-- 
Jens Axboe

