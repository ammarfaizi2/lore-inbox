Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276523AbRJHRR5>; Mon, 8 Oct 2001 13:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276534AbRJHRRs>; Mon, 8 Oct 2001 13:17:48 -0400
Received: from hq2.fsmlabs.com ([209.155.42.199]:1808 "HELO hq2.fsmlabs.com")
	by vger.kernel.org with SMTP id <S276523AbRJHRRc>;
	Mon, 8 Oct 2001 13:17:32 -0400
Date: Mon, 8 Oct 2001 11:12:46 -0600
From: Victor Yodaiken <yodaiken@fsmlabs.com>
To: "Eric W. Biederman" <ebiederman@uswest.net>
Cc: Victor Yodaiken <yodaiken@fsmlabs.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] I still see people using cli()
Message-ID: <20011008111246.A17790@hq2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1669qw068.fsf@frodo.biederman.org>
User-Agent: Mutt/1.3.18i
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2001 at 10:45:19AM -0600, Eric W. Biederman wrote:
> "Victor Yodaiken" <yodaiken@fsmlabs.com> writes:
> 
> > On Mon, Oct 08, 2001 at 09:11:57AM -0600, Eric W. Biederman wrote:
> > > > IF the kernel becomes preemptible it will be so slow, so buggy, and so
> > painful
> > 
> > > > to maintain, that those issues won't matter.
> > > 
> > > The preemptible kernel work just takes the current SMP code, and
> > > allows it to work on a single processor.  You are not interruptted if
> > > you have a lock held.  This makes the number of cases in the kernel
> > > simpler, and should improve maintenance as more people will be
> > > affected by the SMP issues.
> > 
> > i.e. "since we are already committed to making the kernel more complex, slower,
> > and
> > 
> >       harder to maintain, there is no problem ... "
> 
> Already committed?  Already completed.  Personally I think a model where
> you have the cpu until you or one of the functions you call is hard to
> maintain because you can easily loose control by accident.  


Really? I see totally otherwise. The rule: "kernel code runs until it does a blocking 
call" makes sense.   What's really hard is figuring out which 12 spinlocks you need
in what order.


> > > Right now there is a preemptible kernel patch being maintained
> > > somewhere.  I haven't had a chance to look recently.  But the recent
> > > threads on low latency mentioned it.
> > 
> > Try it out. Try running a kernel compile while a POSIX SCHED_FIFO process
> > is running.
> 
> My expectation would be that the SCHED_FIFO process would totally stop
> the kernel compile.  At least until it saw fit to sleep.

Right - even for a periodic SCHED_FIFO process that gives up the processor a lot.
So how do you ensure that the router daemon runs, that network packets get processed ... 
that all the other things that normally happen because kernel tasks run to completion
and because user programs all progress still happen?
> 
> > > As for rules.  They are the usual SMP rules.  In earlier version there
> > > was a requirement or that you used balanced constructs.
> > 
> 
> There are 3 different goals we are mentioning here.
> 1) SMP
> 2) Soft Realtime.  (low-latency) 
>     This is things like playing audio or video where it is o.k. to skip
>     but want it to happen as rarely as possible.
> 3) Hard Realtime.  (guaranteed-latency)
> 
> All 3 are different.


Agree.  People forget though. And "as rarely as possible" is pretty damn vague.


> 
> > I'm sorry, but this is not correct.   SMP is different from low-latency and
> > has different goals. 
> 
> SMP has the basic goal of having locks held for as short a time as possible,

It does?  I thought SMP had the basic goal of optimizing average case use of multiple
processors and getting a decent ratio between throughput and responsiveness.
That's very different.

> and a preemptible kernel has the goal of having the kernel being unpreemptible
> for as short a time as possible.  Both of these are compatible.

Nope. You are taking an implementation rule of thumb "lock should not be held long"
which is often true for SMP and noting that it is compatible with the core design goal
of low-latency. The problem is that for low latency, "we often find it useful to keep
lock hold times short" does not get you very far.
	

> > You certainly can piggyback low-latency of a sort on 
> > on the finer-grained locking you get from SMP support, but if you optimize
> > a kernel for SMP support you don't necessarily look at the same lock issues 
> > as you would if your goal was to reduce latency. E.g. for SMP a design like
> > 
> > 	each processor maintains a local cache of resource X. Getting X from
> > 	the local cache takes 100ns and only local locking.
> > 
> > 	there is a slow and expensive spin locked central resource for X
> > 	used to replenish local caches. Getting X from the central resource
> > 	takes 1 second.
> > 
> > 	Cache success rate is over 99.99%.
> > 
> > With 10000 accesses to X, total time is 1.01 seconds for an average of 100
> > microseconds and this
> > 
> > is overstating the case, for most processes never see the 1second delay and
> > average
> > 
> > 100ns per access. 
> > 
> > But worst case is 1 second!
> > 
> > If you were to design for low latency, you'd prefer the design
> > 
> > 	an elaborate resource control mechanism allows all processors to 
> > 	share X and get X resources within 1 millisecond.
> > 
> > 1000 times better latency, 10000 times worse average case. 
> > 
> > You cannot escape a tradeoff by pretending it's not there.
> 
> Nope you can't.  However in your example I would only prefer your design if
> I was designing for guaranteed latency.  Not just trying to keep the
> latencies low.
> 
> I don't have a problem with my audio player skipping once ever 2 or 3
> years.  A classic low-latency problem.


Actually, soft RT usually means "good performance until really I need it".

> > Look we handle this all the time in RTLinux: we have to throw away
> > heartbreakingly
> > 
> > beautiful solutions because worst case numbers are bad. 
> 
> That is because you care about guaranteed latency, which is a truly
> different case from the normal linux kernel deals with.

Yes indeed.

> Personally I have a hard time buying hard real time code.  Because
> there are always things cases where you cannot make guarantees.  To
> even have a clue what the speed of your code will really run at you
> need to take into account the exact platform your code will run at,
> and you need to know the operating environment for that platform.  And
> even with the best analysis and planning something still goes wrong.


Odd, I could have sworn it worked.


