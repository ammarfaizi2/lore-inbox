Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289213AbSANMJX>; Mon, 14 Jan 2002 07:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289218AbSANMJM>; Mon, 14 Jan 2002 07:09:12 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:40966 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S289213AbSANMJI>; Mon, 14 Jan 2002 07:09:08 -0500
Message-ID: <3C42CA59.F070C2B8@aitel.hist.no>
Date: Mon, 14 Jan 2002 13:08:57 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.2-pre11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu> <1010781207.819.27.camel@phantasy> <20020111195018.A2008@hq.fsmlabs.com> <20020112042404.WCSI23959.femail47.sdc1.sfba.home.com@there>
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

There is a difference.  Preempt have the same locking requirements as
SMP, but there's also _timing_ requirements.

> The preempt patch is really "SMP on UP".  If pre-empt shows up a problem,
> then it's a problem SMP users will see too.  If we can't take advantage of
> the existing SMP locking infrastructure to improve latency and interactive
> feel on UP machines, than SMP for linux DOES NOT WORK.

One example where preempt may break and SMP does not:

Consider driver code.  Critical data structures is protected by
spinlocks,
but some of the access to the hardware device itself is outside those
locks (I can prove that the other processors can't get there with
the driver in that state anyway)

Now, hardware access has timing requirements.  That works on SMP because
you don't loose the CPU to anything but interrupts, and they are fast. 
You get it back almost immediately.  The device in question times out
after a much longer interval.

But preempt may decide to run a time-consuming higher priority task in
the 
middle of device access, cuasing the hardware to time out and fail.
Hardware access isn't necessarily in a interrupt handler.  It may be
done directly in a read/write/ioctl call if the device happens
to be available at the moment.

This is a case where SMP works even though preempt may fail.  I don't
know if this is an issue for existing drivers, but it is possible.

Helge Hafting



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
> 
> This isn't a BAD thing.  If the benchmarks used to find latency spikes are at
> all like real-world use, then it helps real-world applications.  But of
> COURSE the benchmarks are going to look good, since tuning the kernel to
> those benchmarks is the way the patch was developed!
> 
> The majority of the original low latency scheduling point work is handled
> automatically by the SMP on UP kernel.  You don't NEED to insert scheduling
> points anywhere you aren't inside a spinlock.  So the SMP on UP patch makes
> most of the explicit scheduling point patch go away, accomplishing the same
> thing in a less intrusive manner.  (Yes, it makes all kernels act like SMP
> kernels for debugging purposes.  But you can turn it off for debugging if you
> want to, that's just another toggle in the magic sysreq menu.  And this isn't
> entirely a bad thing: applying the enormous UP userbase to the remaining SMP
> bugs is bound to squeeze out one or two more obscure ones, but those bugs DO
> exist already on SMP.)
> 
> However, what's left of the explicit scheduling work is still very useful.
> When you ARE inside a spinlock, you can't just schedule, you have to save
> state, drop the lock(s), schedule, re-acquire the locks, and reload your
> state in case somebody else diddled with the structures you were using.  This
> is a lot harder than just scheduling, but breaking up long-held locks like
> this helps SMP scalability, AND helps latency in the SMP-on-UP case.
> 
> So the best approach is a combination of the two patches.  SMP-on-UP for
> everything outside of spinlocks, and then manually yielding locks that cause
> problems.  Both Robert Love and Andrew Morton have come out in favor of each
> other's patches on lkml just in the past few days.  The patches work together
> quite well, and each wants to see the other's patch applied.
> 
> Rob
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
