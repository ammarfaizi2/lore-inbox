Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289209AbSANL6K>; Mon, 14 Jan 2002 06:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289212AbSANL57>; Mon, 14 Jan 2002 06:57:59 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:7706 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S289209AbSANL5t>; Mon, 14 Jan 2002 06:57:49 -0500
Date: Mon, 14 Jan 2002 12:56:19 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Robert Love <rml@tech9.net>
Cc: Andrew Morton <akpm@zip.com.au>, jogi@planetzork.ping.de,
        Ed Sweetman <ed.sweetman@wmich.edu>, yodaiken@fsmlabs.com,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, nigel@nrg.org,
        Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020114125619.E10227@athlon.random>
In-Reply-To: <20020112121315.B1482@inspiron.school.suse.de> <20020112160714.A10847@planetzork.spacenet> <20020112095209.A5735@hq.fsmlabs.com> <20020112180016.T1482@inspiron.school.suse.de> <005301c19b9b$6acc61e0$0501a8c0@psuedogod> <3C409B2D.DB95D659@zip.com.au> <20020113184249.A15955@planetzork.spacenet> <1010946178.11848.14.camel@phantasy> <3C41E415.9D3DA253@zip.com.au> <1010952276.12125.59.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <1010952276.12125.59.camel@phantasy>; from rml@tech9.net on Sun, Jan 13, 2002 at 03:04:35PM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 13, 2002 at 03:04:35PM -0500, Robert Love wrote:
> user system.  But things like (ack!) dbench 16 show a marked
> improvement.

please try again on top of -aa, and I've to specify this : benchmarked
in a way that can be trusted and compared, so we can make some use of
this information.  This mean with -18pre2aa2 alone and only -preempt on
top of -18pre2aa2.

NOTE: I'd be glad to say "preempt rules", "go preempt", "preempt is
cool" like you as soon as I have some proof it makes _THE_ difference
and that it is worth the mess on SMP (per-cpu, RCU locking, etc...), not
to tell about the other architectures, but at the moment there's only a
number of people running xmms on mainline with the broken scheduling
points and those numbers that cannot be compared in any sane way. I
repeat, I'm not against preempt, I just want to get some real world
proof and measurement and at the moment I think preempt doesn't worth,
but if you give us _any_ real world proof that a that low mean latency
of the order of 10/100 usec matters to get most of the cpu cycles out of
the cpu during trashing (as it could be possible to speculate from the
broken benchmark posted in this thread), and that there's no real
regression with the additional branches in the spin_unlock in 100%
system load, I may change my mind (an of course, only for anything above
2.5, and still I think there are more interesting optimizations to do
rahter than requiring everybody spending lots of time fixing drivers,
auditing, fixing smp, rcu locking etc... but ok if it is obviously good
thing [aka no real regression and only benefits long term] it would be
ok to do it early as well). I'm not particularly worried about the
preempt lock around the per-cpu stuff, that's a cacheline local, and it
could go into the schedule_data like I did for the rcu per-cpu
variables, so they're at zero cacheline cost (RCU_poll patch costs now
only 1 instruction per schedule and zero memory overhead [an incl
instruction precisely]).

> > Benchmarks are well and good, but until we have a solid explanation for
> > the throughput changes which people are seeing, it's risky to claim
> > that there is a general benefit.
> 
> I have an explanation.  We can schedule quicker off a woken task.  When
> an event occurs that allows an I/O-blocked task to run, its time-to-run
> is shorter.  Same event/response improvement that helps interactivity.

That's a nice speculation out of a broken comparison, it may be really
the case, there's no way to be sure, before that sum of usec you should
also sum the seconds spent walking the tasklist in the non O(1)
scheduler.

Andrea
