Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269010AbTBWXVd>; Sun, 23 Feb 2003 18:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269012AbTBWXVd>; Sun, 23 Feb 2003 18:21:33 -0500
Received: from [195.223.140.107] ([195.223.140.107]:25734 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S269010AbTBWXVb>;
	Sun, 23 Feb 2003 18:21:31 -0500
Date: Mon, 24 Feb 2003 00:32:51 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: Andrew Morton <akpm@digeo.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [ak@suse.de: Re: iosched: impact of streaming read on read-many-files]
Message-ID: <20030223233251.GK29467@dualathlon.random>
References: <20030222054307.GA22074@wotan.suse.de> <20030221230716.630934cf.akpm@digeo.com> <20030222145728.L629@nightmaster.csn.tu-chemnitz.de> <20030223154002.GG29467@dualathlon.random> <20030223200508.N21727@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030223200508.N21727@nightmaster.csn.tu-chemnitz.de>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2003 at 08:05:08PM +0100, Ingo Oeser wrote:
> On Sun, Feb 23, 2003 at 04:40:02PM +0100, Andrea Arcangeli wrote:
> > On Sat, Feb 22, 2003 at 02:57:28PM +0100, Ingo Oeser wrote:
> > > What about implementing io-requests, which can time out? So if it will
> > > not be serviced in time or we know, that it will not be serviced
> > > in time, we can skip that.
> > 
> > that works only if the congestion cames from multimedia apps that are
> > willing to cancel the timed out (now worthless) I/O, that is never the
> > case normally due the low I/O load they generate (usually it's apps not
> > going to cancel the I/O that congest the blkdev layer).
>  
> I would put it to loads, where it doesn't matter that all streams
> will be serviced all the time and where it does matter more, that
> we stay responsive and show the latest frames available.
> 
> > still, it's a good idea, you're basically asking to implement the cancel
> > aio api and I doubt anybody could disagree with that ;).
> 
> I'm aware of these, but if we are so heavily busy, that the
> applications looses IO frames already, then calling into an

Note that we're dealing with a disk heavily busy since they're timing
out, but we're not necessairly cpu-busy at all. The cancellation is a
completely disk-less operation, it runs at cpu core speed. A simple
getevents with timeout + io_cancel will do the trick just fine. Sure,
this way the cancellation will have to run a bit of userspace code too,
but it shouldn't make that much difference in practice (at least unless
there's an heavy cpu or swap overload too that introduce an huge time
gap between the getevents timeout and the io_cancel to enter kernel).
Your API makes sense too, but it's just a different API and I'm not sure
if it worth to implement it at the light of the above considerations,
given we just have the io_cancel syscall. Also note that the
cancellation API makes sense even if we don't work in the disk-queue
layer, infact unless you've a 4G worthless I/O queue like in Andrew's
example, probably it won't make an huge difference to cancel the I/O in
the queue too, even if of course it would make perfect sense to do that
too.  it is especially difficult to cancel the I/O in the disk queue at
the moment because we can't make sure what is our request and what is
somebody else request. Same goes for your cancellation API, it would be
difficult to cancel it. Everything in the queue is asynchronous and not
everybody will wait on its stuff immediatly.

> application (which might be swapped out) to traverse its
> AIO overhead the cancel makes no sense any more.

again, we're not necessairly swapped out, the aio api should take care
of the I/O congestions, not necessairly of the VM and cpu congestions.
And for the I/O congestions it looks sane to me even if it will have to
pass through userspace, but passing through userspace may be an
advantage some time (so you can choose how much to cancel or whatever).

> I want a deadline attached to them and have them automatically
> cancelled after this deadline. (that's why I quoted the relevant
> part of my e-mail again).

Sure I understood your point.

> I can see many uses besides multi media applications. Also http
> or ftp server could do this, if they are busier as expected or if
> a connection dropped.

Not sure how much you can save, disconnects shouldn't be so frequent and
filling the cache anyways may make sense specially for http, and the
timeouts are quite long, by the time the network timeout trigger likely
the I/O just completed since a long time, and it wouldn't be easy to
synchronize the network timeout with the request submit-time-timeout. I
believe cancellation matters for interactive applications, and http and
ftp aren't interactive, I mean, there's not a throughput requirement for
http/ftp, nor a frame rate to keep up with, if flash or java takes
longer to load because your network is slower, you'll just wait longer etc..

Andrea
