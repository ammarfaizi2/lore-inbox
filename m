Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267211AbUGVTq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267211AbUGVTq5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 15:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267206AbUGVTqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 15:46:34 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:19 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S267184AbUGVTpk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 15:45:40 -0400
Date: Thu, 22 Jul 2004 12:45:13 -0700
To: Scott Wood <scott@timesys.com>
Cc: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       linux-audio-dev@music.columbia.edu, arjanv@redhat.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040722194513.GA32377@nietzsche.lynx.com>
References: <20040721082218.GA19013@elte.hu> <20040721085246.GA19393@elte.hu> <40FE545E.3050300@yahoo.com.au> <20040721183415.GC2206@yoda.timesys> <20040721184650.GA27375@elte.hu> <20040721195650.GA2186@yoda.timesys> <20040721214534.GA31892@elte.hu> <20040722022810.GA3298@yoda.timesys> <20040722074034.GC7553@elte.hu> <20040722185308.GC4774@yoda.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040722185308.GC4774@yoda.timesys>
User-Agent: Mutt/1.5.6+20040523i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2004 at 02:53:08PM -0400, Scott Wood wrote:
> On Thu, Jul 22, 2004 at 09:40:34AM +0200, Ingo Molnar wrote:
> > * Scott Wood <scott@timesys.com> wrote:
> > > This sort of substitution is what we did in 2.4, though we made this
> > > type the default and gave the real spinlocks a new name to be used in
> > > those few places where it was really needed.  Of course, this resulted
> > > in a lot of places using a mutex where a spinlock would have been
> > > fine.
> > 
> > what are those few places where a spinlock was really needed?
> 
> Places that inherently cannot sleep, such as inside the scheduler,
> the unthreadable part of the hard IRQ code, inside the mutex
> implementation, etc.

Scott and Ingo,

Drivers that you might have to poll (technically a kind of hardware level
spinlock multi-device concurrency problem... Those special spins need to be
bounded by a preempt_{dis,en}able to prevent deadlocking) for completion since
it can't do an async notify of some sort, the low level timer handling
infrastructure, all places in the scheduler, all child functions/places that
can sleep/block within a non-preemptable critical section must be demoted back
to spinlocks and more stuff. The problem isn't trivial at all. The latter one
on the list is something that requires progressive audit as minor kernel
releases come out.

This is major project. kgdb needs to be ported to it, etc... and other
things that slip my mind right now.

There are also other problem with moving to a largely sleeping mutex
style kernel, dead lock detection becomes sorely needed. Current spinlock
detection methods are probably going to be useless in a system like this.
BSD/OS-FreeBSD have some of these facilites. The TimeSys mutexes have a
read/write lock, akind to BSD/OS shared/exclusive locks, that has a depth
first search cycle detector in them. My background is BSD/OS-FreeBSD.

The problem with FreeBSD is that their project is pretty much crap
in that they have these ego-manics focused on cute little SMP mechanisms
instead of actually doing the hard work of pushing locks down into lower
level subsystems. That's why DragonFly-BSD split from them in addition
to other multipule reasons. They also have tons more class and are nicer,
smarter folks in general. :)

The good thing about this, Linux, is that many of the RTOS issues we're
talking about now have a direct 1:1 relationship to SMP locking issues.
The concurrency issues, in a mathematical manner, are the same. It's not
just the trivial stuff with holding a non-preemptive lock such as BLK, but
in the context of priority inheritance and contention where, I believe,
the simple case use of priority inheritance should be considered a kind
contention overload condition of the overall system.

The general purpose OS folks like FreeBSD and old versions Solaris have a
sort of confused and backward notion of this problem by using priority
inheritance as a substitute for fixing the contention problems in the
first place. They abuse the scheduler to try and a get system that can
respond regularly to priority centric schedulers, but what happens instead
is they spread scheduling irregularities that effect the entire kernel
in unknown, unpredictable and odd ways. RTOS folks are much more sensitive
to the over and inappropriate use of things like this.

Linux is prime for some kind of RTOS conversion in that locks have been
pushed down sufficiently that late/runtime detection logic with simple
priority inheritance would rarely be triggered. That's basically a kind
of lock contention maladaptation. There's a possibility of making Linux
a top-notch RTOS if the right folks where working on that stuff.

Rant over... :)

BTW, this basically turning Linux into a kind of SGI IRIX style system.

> > I'm a bit uneasy about making mutexes the default not due to performance
> > but due to e.g. some hardware being very timing-sensitive. 
> 
> In practice, this didn't turn out to be an issue; most modern
> hardware seems to be pretty tolerant of that (and you already have to
> deal with things like interrupts getting in the way), and drivers
> which do local_irq_disable() or to ensure timing will still work.
 
> Has this sort of problem been seen with RT-Linux and such, which
> would cause similar delays?

bill

