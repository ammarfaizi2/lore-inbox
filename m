Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284902AbSALFJ7>; Sat, 12 Jan 2002 00:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284966AbSALFJu>; Sat, 12 Jan 2002 00:09:50 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:40977 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S284902AbSALFJc>; Sat, 12 Jan 2002 00:09:32 -0500
Message-ID: <3C3FC3B2.352EDF36@zip.com.au>
Date: Fri, 11 Jan 2002 21:03:46 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rob Landley <landley@trommello.org>
CC: yodaiken@fsmlabs.com, Robert Love <rml@tech9.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, nigel@nrg.org,
        linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu> <1010781207.819.27.camel@phantasy> <20020111195018.A2008@hq.fsmlabs.com>,
		<20020111195018.A2008@hq.fsmlabs.com> <20020112042404.WCSI23959.femail47.sdc1.sfba.home.com@there>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:
> 
> On Friday 11 January 2002 09:50 pm, yodaiken@fsmlabs.com wrote:
> > On Fri, Jan 11, 2002 at 03:33:22PM -0500, Robert Love wrote:
> > > On Fri, 2002-01-11 at 07:37, Alan Cox wrote:
> > > The preemptible kernel plus the spinlock cleanup could really take us
> > > far.  Having locked at a lot of the long-held locks in the kernel, I am
> > > confident at least reasonable progress could be made.
> > >
> > > Beyond that, yah, we need a better locking construct.  Priority
> > > inversion could be solved with a priority-inheriting mutex, which we can
> > > tackle if and when we want to go that route.  Not now.
> >
> > Backing the car up to the edge of the cliff really gives us
> > good results. Beyond that, we could jump off the cliff
> > if we want to go that route.
> > Preempt leads to inheritance and inheritance leads to disaster.
> 
> I preempt leads to disaster than Linux can't do SMP.  Are you saying that's
> the case?

Victor is referring to priority inheritance, to solve priority inversion.

Priority inheritance seems undesirable for Linux - these applications are
already in the minority.   A realtime application on Linux should simply
avoid complex system calls which can lead to blockage on a SCHED_OTHER
thread.

If the app is well-designed, the only place in which it is likely to
be unexpectedly blocked inside the kernel is in the page allocator.
My approach to this problem is to cause non-SCHED_OTHER processes
to perform atomic (non-blocking) memory allocations, with a fallback
to non-atomic.

> The preempt patch is really "SMP on UP".  If pre-empt shows up a problem,
> then it's a problem SMP users will see too.  If we can't take advantage of
> the existing SMP locking infrastructure to improve latency and interactive
> feel on UP machines, than SMP for linux DOES NOT WORK.
> 
> > All the numbers I've seen show Morton's low latency just works better. Are
> > there other numbers I should look at.
> 
> This approach is basically a collection of heuristics.  The kernel has been
> profiled and everywhere a latency spike was found, a band-aid was put on it
> (an explicit scheduling point).  This doesn't say there aren't other latency
> spikes, just that with the collection of hardware and software being
> benchmarked, the latency spikes that were found have each had a band-aid
> individually applied to them.

The preempt patch needs all this as well.
 
> This isn't a BAD thing.  If the benchmarks used to find latency spikes are at
> all like real-world use, then it helps real-world applications.  But of
> COURSE the benchmarks are going to look good, since tuning the kernel to
> those benchmarks is the way the patch was developed!
> 
> The majority of the original low latency scheduling point work is handled
> automatically by the SMP on UP kernel.

No it is not.

The preempt code only obsoletes a handful of the low-latency patch's
resceduling.  The most trivial ones.  generic_file_read, generic_file_write
and a couple of /proc functions.

Of the sixty or so rescheduling points in the low-latency patch, about
fifty are inside locks.  Many of these are just lock_kernel().  About
half are not.

>  You don't NEED to insert scheduling
> points anywhere you aren't inside a spinlock.

I know of only four or five places in the kernel where large amount of
time are spent in unlocked code.  All the other problem areas are inside locks.

>  So the SMP on UP patch makes
> most of the explicit scheduling point patch go away,

s/most/a trivial minority/

> accomplishing the same
> thing in a less intrusive manner.

s/less/more/

> (Yes, it makes all kernels act like SMP
> kernels for debugging purposes.  But you can turn it off for debugging if you
> want to, that's just another toggle in the magic sysreq menu.  And this isn't
> entirely a bad thing: applying the enormous UP userbase to the remaining SMP
> bugs is bound to squeeze out one or two more obscure ones, but those bugs DO
> exist already on SMP.)

Saying "it's a config option" is a cop-out.  The kernel developers should
be aiming at producing a piece of software which can be shrink-wrap
deployed to millions of people.

Arguably, enabling it on UP and disabling it on SMP may be a sensible
approach, meraly because SMP tends to map onto applications which
do not require lower latencies.
  
> However, what's left of the explicit scheduling work is still very useful.
> When you ARE inside a spinlock, you can't just schedule, you have to save
> state, drop the lock(s), schedule, re-acquire the locks, and reload your
> state in case somebody else diddled with the structures you were using.  This
> is a lot harder than just scheduling, but breaking up long-held locks like
> this helps SMP scalability, AND helps latency in the SMP-on-UP case.

Yes, it _may_ help SMP scalability.  But a better approach is to replace
spinlocks with rwlocks when a lock is fond to have this access pattern.
 
> So the best approach is a combination of the two patches.  SMP-on-UP for
> everything outside of spinlocks, and then manually yielding locks that cause
> problems.

Well the ideal approach is to simply make the long-running locked code
faster, by better choice of algorithm and data structure.  Unfortunately,
in the majority of cases, this isn't possible.

-
