Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311025AbSGKVEN>; Thu, 11 Jul 2002 17:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311749AbSGKVEK>; Thu, 11 Jul 2002 17:04:10 -0400
Received: from dsl-213-023-020-056.arcor-ip.net ([213.23.20.56]:32689 "EHLO
	starship") by vger.kernel.org with ESMTP id <S311025AbSGKVEI>;
	Thu, 11 Jul 2002 17:04:08 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Mark Mielke <mark@mark.mielke.cc>, Linux <linux-kernel@vger.kernel.org>
Subject: Re: Whoa... (was: Re: HZ, preferably as small as possible)
Date: Thu, 11 Jul 2002 23:08:01 +0200
X-Mailer: KMail [version 1.3.2]
References: <3D2CA6E3.CB5BC420@zip.com.au> <20020710160921.H32168@host110.fsmlabs.com> <20020711093620.A19422@mark.mielke.cc>
In-Reply-To: <20020711093620.A19422@mark.mielke.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17SlAQ-0002W1-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 July 2002 15:36, Mark Mielke wrote:
> On Wed, Jul 10, 2002 at 04:09:21PM -0600, Cort Dougan wrote:
> > Yes, please do make it a config option.  10x interrupt overhead makes me
> > worry.  It lets users tailor the kernel to their expected load.
> 
> All this talk is getting to me.
> 
> I thought we recently (1 month ago? 2 months ago?) concluded that
> increases in interrupt frequency only affects performance by a very
> small amount, but generates an increase in responsiveness. The only
> real argument against that I have seen, is the 'power conservation'
> argument. The idea was, that the scheduler itself did not execute
> on most interrupts. The clock is updated, and that is about all.
> 
> I can invent a reason as to why throughput increases, from user space.
> The hard drive sends data to the kernel, the kernel handles the
> hardware interrupt, grabs the buffer, and returns control to the
> active process/thread. It may be some time until the process/thread
> that is *reading* the data gets scheduled. Any reduction in the
> average time a process/thread will be scheduled to execute, results in
> increased throughput.

Yes, it's the same reason that -preempt leads, counterintuitively,
to better throughput under parallel loads.  Contrary to popular
wisdom, lower latency and higher throughput are not always mutally
exclusive.

Anyway, 1 ms timer interrupt is still a snail's pace by the
standards of today's processors, it's silly to worry about it.  If
somebody wants a cruder scheduling interval than the raw timer
interrupt, that's child's play, just step the interval down.  The
only slightly challenging thing is do that without restricting
choice of rate for the raw timer and scheduler, respectively.  Here,
a novel application of Bresenham's algorithm (the line drawing
algorithm) works nicely: at each raw interrupt, subtract the period
of the raw interrupt from an accumulator; if the result is less
than zero, add the period of the scheduler to the accumlator and
drop into the scheduler's part of the timer interrupt.

This Bresenham trick works for arbitrary collections of interrupt
rates, all with different periods.  It has the property that,
over time, the total number of invocations at each rate remains
*exactly* correct, and so long as the raw interrupt runs at a
reasonably high rate, displacement isn't that bad either.

-- 
Daniel
