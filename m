Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276947AbRJHTTU>; Mon, 8 Oct 2001 15:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276952AbRJHTS7>; Mon, 8 Oct 2001 15:18:59 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:5947 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S276947AbRJHTSy>; Mon, 8 Oct 2001 15:18:54 -0400
To: "Victor Yodaiken" <yodaiken@fsmlabs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] I still see people using cli()
In-Reply-To: <20011008111246.A17790@hq2>
From: ebiederman@uswest.net (Eric W. Biederman)
Date: 08 Oct 2001 13:09:33 -0600
In-Reply-To: <20011008111246.A17790@hq2>
Message-ID: <m11ykevthu.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Victor Yodaiken" <yodaiken@fsmlabs.com> writes:

> Really? I see totally otherwise. The rule: "kernel code runs until it does a
> blocking
> 
> call" makes sense. 

Oh, you mean the kernel can go away anytime it feels like it.  Because this
happens pontentially at every function call.  When we can I'm very
much in favor of not using locks at all. 

The problem with the run until block approach is that people forget that
some rare cases they will block, or those cases are modified so that
they will block after your code is written.  And since it never shows
up in testing everything looks good until you hit the real world.

If you start with the SMP premise that you have multiple cpus
executing in the kernel at the same time you start with a healthier
assumption.

Now I do agree that the whole nested lock issue is not a very healthy
solution to the problem case of multiple threads executing within the
kernel.  I don't think we even have any of those execept in the kernel
core.  But for RTLinux this is mostly likely what you are working on,
the worst of it.

>  What's really hard is figuring out which 12 spinlocks you
> need
> 
> in what order.

I agree that anytime you get deeper than 1 spinlock there are issues.
I don't think the current kernel gets deeper than 3 locks.  And yes
this is a nasty case no questions asked.  This actually sounds like
the lazy page table mechanism...

> > > > Right now there is a preemptible kernel patch being maintained
> > > > somewhere.  I haven't had a chance to look recently.  But the recent
> > > > threads on low latency mentioned it.
> > > 
> > > Try it out. Try running a kernel compile while a POSIX SCHED_FIFO process
> > > is running.
> > 
> > My expectation would be that the SCHED_FIFO process would totally stop
> > the kernel compile.  At least until it saw fit to sleep.
> 
> Right - even for a periodic SCHED_FIFO process that gives up the processor a
> lot.
> 
> So how do you ensure that the router daemon runs, that network packets get
> processed ...
> 
> that all the other things that normally happen because kernel tasks run to
> completion
> 
> and because user programs all progress still happen?

Progress is a hard requirement especially when you give up fairness,
and especially when you are wanting a specific amount of progress.  

> > > > As for rules.  They are the usual SMP rules.  In earlier version there
> > > > was a requirement or that you used balanced constructs.
> > > 
> > 
> > There are 3 different goals we are mentioning here.
> > 1) SMP
> > 2) Soft Realtime.  (low-latency) 
> >     This is things like playing audio or video where it is o.k. to skip
> >     but want it to happen as rarely as possible.
> > 3) Hard Realtime.  (guaranteed-latency)
> > 
> > All 3 are different.
> 
> 
> Agree.  People forget though. And "as rarely as possible" is pretty
> damn vague.

Agrred it isn't the most clear.  The core with soft realtime is that
it is o.k. to fail, nothing nasty will happen.  The you work on
reducing the latencies without penalizing other things.  In that
cases keeping the latencies down is not the most important thing.

> > > I'm sorry, but this is not correct.   SMP is different from low-latency and
> > > has different goals. 
> > 
> > SMP has the basic goal of having locks held for as short a time as possible,
> 
> It does?  I thought SMP had the basic goal of optimizing average case use of
> multiple
> 
> processors and getting a decent ratio between throughput and responsiveness.
> That's very different.

Yes overall.  But in the point case of lock hold times it is true.

> > and a preemptible kernel has the goal of having the kernel being unpreemptible
> 
> > for as short a time as possible.  Both of these are compatible.
> 
> Nope. You are taking an implementation rule of thumb "lock should not be held
> long"
> 
> which is often true for SMP and noting that it is compatible with the core
> design goal
> 
> of low-latency. The problem is that for low latency, "we often find it useful to
> keep
> 
> lock hold times short" does not get you very far.

It solves a lot of the corner cases like long compute loops in the
kernel like the swap off path.  For many of the other cases keeping
both latency low, and throughput  high is a general design goal.  I
agree that preemption is not a silver bullet.

The obvious case this solves is copy_from_user.  Which often is a real
bottleneck, but if you add code to see if it should preempt itself it
will run slower, and get less throughput.  At the same time
copy_from_user does not have any locks held.  In that case preemption
is the optimal approach.

Another case is the swapoff path.  Which can run a very long time in
kernel mode, and when it doesn't find a page to do I/O on it doesn't
make a single blocking call.  But it also has periods of time when
it doesn't hold locks.

So there are cases preemption is a good solution.  Reviewing the current
algorithms and find a good way to handle things is also good.

> > Nope you can't.  However in your example I would only prefer your design if
> > I was designing for guaranteed latency.  Not just trying to keep the
> > latencies low.
> > 
> > I don't have a problem with my audio player skipping once ever 2 or 3
> > years.  A classic low-latency problem.
> 
> 
> Actually, soft RT usually means "good performance until really I need it".

I admit a lot of times that does seem to be the implementation.

Because the people offering it don't have it as a goal.  With a touch
of care the people doing the current low-latency work on linux should
be able to keep the kernel hackers honest on that score.  Without
users who complain a lot of things look good until you use them.

Again I aim soft real time type things at audio, and video players,
not robot control.  Where skips are obviously o.k. just not pleasant
to the ear.


> > Personally I have a hard time buying hard real time code.  Because
> > there are always things cases where you cannot make guarantees.  To
> > even have a clue what the speed of your code will really run at you
> > need to take into account the exact platform your code will run at,
> > and you need to know the operating environment for that platform.  And
> > even with the best analysis and planning something still goes wrong.
> 
> 
> Odd, I could have sworn it worked.

Hmm.  The mars probe problem not withstanding?  As I recall in that
case it was only because they had a backup strategy, of rebooting the
machine, for when the hard realtime requirements failed to be met that
the system managed to land on mars.

Personally I think doing everything in your power to bound latencies
and do everything possible to ensure that something will happen in a
timely manner is the correct thing to do.  However you still have to
keep the engineering assumption that something can still go wrong.  A
gamma ray could hit your clock generater causing the cpu to run 5%
slower, you could be running on a subtlely defective cpu, or a whole
host of things.  

My problem with hard real time, is that just with a skim of it I get
the feeling people are certain they can achieve their goals and not
just come within 99.9999999999% of them.

And as systems get more complex the probability of the inevitiable
failure is due human error goes up.  As I recall the mars lander it
was a bug in the implementation of priority inheritance.

Eric



