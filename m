Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284717AbSALEYX>; Fri, 11 Jan 2002 23:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284728AbSALEYN>; Fri, 11 Jan 2002 23:24:13 -0500
Received: from femail47.sdc1.sfba.home.com ([24.254.60.41]:12170 "EHLO
	femail47.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S284717AbSALEYF>; Fri, 11 Jan 2002 23:24:05 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: yodaiken@fsmlabs.com, Robert Love <rml@tech9.net>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Fri, 11 Jan 2002 15:22:08 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, nigel@nrg.org,
        Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu> <1010781207.819.27.camel@phantasy> <20020111195018.A2008@hq.fsmlabs.com>
In-Reply-To: <20020111195018.A2008@hq.fsmlabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020112042404.WCSI23959.femail47.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 January 2002 09:50 pm, yodaiken@fsmlabs.com wrote:
> On Fri, Jan 11, 2002 at 03:33:22PM -0500, Robert Love wrote:
> > On Fri, 2002-01-11 at 07:37, Alan Cox wrote:
> > The preemptible kernel plus the spinlock cleanup could really take us
> > far.  Having locked at a lot of the long-held locks in the kernel, I am
> > confident at least reasonable progress could be made.
> >
> > Beyond that, yah, we need a better locking construct.  Priority
> > inversion could be solved with a priority-inheriting mutex, which we can
> > tackle if and when we want to go that route.  Not now.
>
> Backing the car up to the edge of the cliff really gives us
> good results. Beyond that, we could jump off the cliff
> if we want to go that route.
> Preempt leads to inheritance and inheritance leads to disaster.

I preempt leads to disaster than Linux can't do SMP.  Are you saying that's 
the case?

The preempt patch is really "SMP on UP".  If pre-empt shows up a problem, 
then it's a problem SMP users will see too.  If we can't take advantage of 
the existing SMP locking infrastructure to improve latency and interactive 
feel on UP machines, than SMP for linux DOES NOT WORK.

> All the numbers I've seen show Morton's low latency just works better. Are
> there other numbers I should look at.

This approach is basically a collection of heuristics.  The kernel has been 
profiled and everywhere a latency spike was found, a band-aid was put on it 
(an explicit scheduling point).  This doesn't say there aren't other latency 
spikes, just that with the collection of hardware and software being 
benchmarked, the latency spikes that were found have each had a band-aid 
individually applied to them.

This isn't a BAD thing.  If the benchmarks used to find latency spikes are at 
all like real-world use, then it helps real-world applications.  But of 
COURSE the benchmarks are going to look good, since tuning the kernel to 
those benchmarks is the way the patch was developed!

The majority of the original low latency scheduling point work is handled 
automatically by the SMP on UP kernel.  You don't NEED to insert scheduling 
points anywhere you aren't inside a spinlock.  So the SMP on UP patch makes 
most of the explicit scheduling point patch go away, accomplishing the same 
thing in a less intrusive manner.  (Yes, it makes all kernels act like SMP 
kernels for debugging purposes.  But you can turn it off for debugging if you 
want to, that's just another toggle in the magic sysreq menu.  And this isn't 
entirely a bad thing: applying the enormous UP userbase to the remaining SMP 
bugs is bound to squeeze out one or two more obscure ones, but those bugs DO 
exist already on SMP.)

However, what's left of the explicit scheduling work is still very useful.  
When you ARE inside a spinlock, you can't just schedule, you have to save 
state, drop the lock(s), schedule, re-acquire the locks, and reload your 
state in case somebody else diddled with the structures you were using.  This 
is a lot harder than just scheduling, but breaking up long-held locks like 
this helps SMP scalability, AND helps latency in the SMP-on-UP case.

So the best approach is a combination of the two patches.  SMP-on-UP for 
everything outside of spinlocks, and then manually yielding locks that cause 
problems.  Both Robert Love and Andrew Morton have come out in favor of each 
other's patches on lkml just in the past few days.  The patches work together 
quite well, and each wants to see the other's patch applied.

Rob
