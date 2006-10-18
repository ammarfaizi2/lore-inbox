Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161008AbWJRNfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161008AbWJRNfa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 09:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWJRNfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 09:35:30 -0400
Received: from unthought.net ([212.97.129.88]:49928 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S1751484AbWJRNf3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 09:35:29 -0400
Date: Wed, 18 Oct 2006 15:35:30 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       "Phetteplace, Thad (GE Healthcare, consultant)" 
	<Thad.Phetteplace@ge.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Bandwidth Allocations under CFQ I/O Scheduler
Message-ID: <20061018133530.GY23492@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Jens Axboe <jens.axboe@oracle.com>,
	Arjan van de Ven <arjan@infradead.org>,
	"Phetteplace, Thad (GE Healthcare, consultant)" <Thad.Phetteplace@ge.com>,
	linux-kernel@vger.kernel.org
References: <CAEAF2308EEED149B26C2C164DFB20F4E7EAFE@ALPMLVEM06.e2k.ad.ge.com> <1161048269.3245.26.camel@laptopd505.fenrus.org> <20061017132312.GD7854@kernel.dk> <20061018080030.GU23492@unthought.net> <1161164456.3128.81.camel@laptopd505.fenrus.org> <20061018113001.GV23492@unthought.net> <20061018114913.GG24452@kernel.dk> <20061018122323.GW23492@unthought.net> <20061018124253.GH24452@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061018124253.GH24452@kernel.dk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 02:42:53PM +0200, Jens Axboe wrote:
...
> > impossible.
> 
> But you can say you want to give the db 90% of the disk bandwidth, and
> at least 50%. The iops/sec metric doesn't help you.

I think we're misunderstanding each other...

I am trying to say, that me being able to specify "90% of the disk
bandwidth" does not help me.

Because the DB would probably be happy with just 1% of the 100MiB/sec
theoretical bandwidth I could get from sequentially reading the disk -
but if it needs to do, say, 160 seeks per second to get those 1% of
100MiB/sec, then that is still more than 96% of the disk time available
with a 6ms seek time.

So, I believe we need something that takes into account the general
performance of the disk - not just the single-user-sequential-read/write
bandwidth.  And, as I shall soon argue, this is where I do think the
iops/sec metric does help - I probably just explained it very poorly to
begin with.

> > 
> > Would you want to limit bandwidth on a per-file or per-process basis?
> > You're talking files, above, I was thinking about processes (consumers
> > if you like) the whole time.
> 
> You need to define your workload for the kernel to know what to do. So
> for the bandwidth case, you need to tell the kernel against what file
> you want to allocate that bandwidth. If you go the percentage route, you
> don't need that. The percentage route doesn't care about sequential or
> random io, it just gets you foo % of the disk time. If the slice given
> is large enough, with 10% of the disk time you may have 90% of the total
> bandwidth if the remaining 90% of the time is spent doing random io. But
> you still have 10% of the time allocated.

I like the time allocation for several reasons:
1) It's presumably simple to implement
2) It will suit both your mp3 player and my database reasonably well
3) It's intuitive to the user - you can understand wall-clock time a lot
   easier than all the little things than influence whether or not you
   get a number of bytes written in a number of places on the disk in
   more or less than the time you had available...

I think "reasonably well" is good enough for a kernel that isn't
hard-real-time anyway  :)


...
[snip - good arguments, response will follow]
...

> > > with a magic iops/sec metric that is both
> > > hard to understand and impossible to quantify.
> > 
> > iops/sec is what you get from your disks. In real world scenarios. It's
> > no more magic than the real world, and no harder to understand than real
> > world disks. Although I admit real-world disks can be a bitch at times ;)
> 
> Again, iops/sec doesn't make sense unless you say how big the iops is

1 OSIOP (oestergaard standard input/output operation) is hereby defined
to be:
  1 optional seek
plus
  1 (read or write) of no more than 256 KiB  (*)

(*): The size limit should be adjusted every 10 years as disk technology
     evolves.

There you have it  :)

So, a single 1MiB read on a disk is 4 OSIOPs, for example.

> and what your stream of iops look like. That's why I say it's a
> benchmark metric.

I state that the total OSIOPs/second you can get out of a given disk
will not change by much, no matter which disk operations you perform and
how you mix them.

That was the whole point of using OSIOPs/sec rather than bandwidth to
begin with.

I know I did not properly define the iop to begin with - my bad, sorry.

> 
> > My argument is that it is simpler to understand than bandwidth.
> 
> And mine is that that is nonsense :-)

Still?  :)

I hope the above clears up some of the misunderstandings.

...
...
> > The total iops/sec "available" from a given disk will not vary a lot,
> > compared to how the total bandwidth available from a given disk will
> > vary.
> 
> That's only true if you scale your iops. And how are you going to give
> that number? You need to define what an iop is for it to be meaningfull.

Done :)

A basic OSIOP is useful for the application, because it maps very
closely to the read/write/seek API that applications are built over.
Thus, the application will know very well how many OSIOPs it needs in
order to complete a given job.

The total number of OSIOPs/sec available in the system, however, will
vary depending on the characteristics of the disk subsystem.  Just like
available cycles/sec vary with the speed of your processor.

You are correct in that the total number of OSIOPs/sec will not be
strictly constant over time - it will depend *somewhat* on the nature of
the operations performed. But it will not change completely - or at
least this is what I claim  :)

...
> > With more than 1 client, you get seeks, and then bandwidth is no longer
> > a sensible measure.
> 
> And neither is iops/sec.

We agree that neither is "correct".

I still claim that one is "not strictly correct but probably close
enough to be useful".

> But things don't deteriorate that quickly, if
> you can tolerate higher latency, it's quite possible to have most of the
> potential bandwidth available for > 1 client workloads.

True.

I do wonder, though, how often that would be practically useful. Seek
times are *huge* (milliseconds) compared to almost anything else we work
with.


-- 

 / jakob

