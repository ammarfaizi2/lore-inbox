Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbUCQUHw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 15:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262046AbUCQUHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 15:07:52 -0500
Received: from mail.shareable.org ([81.29.64.88]:47757 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262043AbUCQUHq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 15:07:46 -0500
Date: Wed, 17 Mar 2004 20:07:02 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Mark Gross <mgross@linux.co.intel.com>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Call for HRT in 2.6 kernel was Re: finding out the value of HZ from userspace
Message-ID: <20040317200702.GA25293@mail.shareable.org>
References: <20040311141703.GE3053@luna.mooo.com> <200403161757.48786.mgross@linux.intel.com> <20040317023059.GD19564@mail.shareable.org> <200403170848.01156.mgross@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403170848.01156.mgross@linux.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Gross wrote:
> > If, however, you can't do that, consider: on i386 HZ is currently
> > 1000.  So your request for 2ms timer is perfectly satisfiable using
> > the standard timers.  Remember to turn on CONFIG_PREEMPT, and use a
> > SCHED_FIFO sceduling policy.
> 
> Check out the non-HRT timer code it rounds up to the next jiffies, always.  

You said you wanted a _2ms_ timer.  Rounded up to the next jiffie,
that's... 2ms!

> Running with the HRT patch, we get a lot closer to what is being asked for.  

Ok.

> > If you measure the jitter and find it is unacceptable, be aware that
> > none of the high-res timer patches for non-real-time linux will
> > improve that.
> 
> Not true.  The HRT patch does indeed improve things a lot.  In fact
> it more or less does the job and it enables the application.  Its
> not perfect, but its good.

Ok.  My point was theoretical and I got it wrong, you're right and you
tried it. :)

> The high res timer patch re-programs the PIT to produce an interrupt
> as close to the timeout as it can, where just the jiffies clock will
> wake up on the following jiffies tick.  On average 1 jiffies late!
> Thats a LOT of jitter.  If you look at the code and follow through
> the logic, if you ask for a 2ms sleep, you are basically going to
> get a 3ms sleep.  If you ask for a 1.1ms sleep you get a 2ms (with
> random larger jitters) sleep.

Yes.  The point is that the added delay with the standard timers is
predictable, so it is possible to structure your program around that,
synchronising to the jiffies clock: have your program tick every
1.99ms or whatever that _actual_ rate of HZ/2 is on 2.6 x86 kernels.
(I gather the jiffie is slightly shorter than 1ms due to timer chip
limitation).

I don't see that the unpredictable part of the jitter would be
improved with high res timers: the unpredictable part being due to
disabled preemption, other interrupts etc.

That's what I meant by jitter, sorry for the lack of precision (no pun
intended).

> To change this without doing some of the things in the HRT patch opens up the timer code to waking up 
> the process too early.  Also a bad thing.

That's what I did with my old "Snake" program: determine when select()
will round up, and then wake up early and busy-wait in a loop calling
gettimeofday() until the precise time arrives.

It's not good, although the busy wait is limited to the length of 1
jiffie, or less if you can structure your program to compute
synchronised with the jiffie clock.

> This just isn't good enough for an entire class of applications that
> could exist on linux if it weren't for this issue.

Hmm.

For VoIP, I'm wondering why you need a timebase other than the sound
card.  Won't it provide an interrupt for every new sound fragment?

> > > Linux needs a low jitter time base standard for desktop multi-media
> > > applications of many types.
> >
> > That's one of the reasons why HZ was changed to 1000 on x86 for 2.6
> > kernels, and the major motivation for adding CONFIG_PREEMPT.
> 
> I know, but the current solution still isn't good enough, on a
> number of levels.

To demonstrate that 1000Hz ticks aren't good enough, because you need
much smaller jitter than 1ms on "ordinary machines" i.e. standard
distros, you'll have to demonstrate that you really are seeing much
smaller jitter than 1ms in your HRT-patched kernels and that it makes
a useful difference.

The pre-emptive patches was initially rejected, but Linus changed his
mind after a lot of good experimental data showing significant and
consistent improvements in latency statistics, the fact that the
patches were remarkeably non-invasive (because most of the work had
been done to support fine-grained SMP by then), and perhaps most
importantly, and surprisingly, I/O performance improved.

So there is hope with HRT, but it needs more than an implementation to
get into the standard tree (IMHO): it has to be fairly small,
non-invasive, not harm existing performance, and backed by convincing
experimental data showing worthwhile improvements.

On the bright side, HRT makes it possible to eliminate the jiffie tick
entirely, which is quite likely to be good for performance and power
consumption.  The objection to that has been that changing code which
depends on the timer tick to not use it any more would complicate that
code without much gain, and it's just not worth complicating anything
for it.  But maybe, as for kernel pre-emption, it will turn out
simpler than expected.

-- Jamie
