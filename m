Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277108AbRJHTrO>; Mon, 8 Oct 2001 15:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277106AbRJHTrE>; Mon, 8 Oct 2001 15:47:04 -0400
Received: from hq2.fsmlabs.com ([209.155.42.199]:52496 "HELO hq2.fsmlabs.com")
	by vger.kernel.org with SMTP id <S277099AbRJHTq4>;
	Mon, 8 Oct 2001 15:46:56 -0400
Date: Mon, 8 Oct 2001 13:42:11 -0600
From: Victor Yodaiken <yodaiken@fsmlabs.com>
To: "Eric W. Biederman" <ebiederman@uswest.net>
Cc: Victor Yodaiken <yodaiken@fsmlabs.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] I still see people using cli()
Message-ID: <20011008134211.A20536@hq2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m11ykevthu.fsf@frodo.biederman.org>
User-Agent: Mutt/1.3.18i
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2001 at 01:09:33PM -0600, Eric W. Biederman wrote:
> "Victor Yodaiken" <yodaiken@fsmlabs.com> writes:
> 
> > Really? I see totally otherwise. The rule: "kernel code runs until it does a
> > blocking
> > 
> > call" makes sense. 
> 
> Oh, you mean the kernel can go away anytime it feels like it.  Because this
> happens pontentially at every function call.  When we can I'm very
> much in favor of not using locks at all. 
> 
> The problem with the run until block approach is that people forget that
> some rare cases they will block, or those cases are modified so that
> they will block after your code is written.  And since it never shows
> up in testing everything looks good until you hit the real world.

The same problem appears with spin_locks

	spin_lock A
	f();
	...

And next week a new version of f containing
	if(rarecondition)
	    {
	    spinlock A
	    do ...
	    unlock A
	    }

Why do you think Linux now needs recursive mutexes and locks?

> 
> If you start with the SMP premise that you have multiple cpus
> executing in the kernel at the same time you start with a healthier
> assumption.

And you loose a lot of potential optimizations and gain complexity.

> 
> Now I do agree that the whole nested lock issue is not a very healthy
> solution to the problem case of multiple threads executing within the
> kernel.  I don't think we even have any of those execept in the kernel

You bet.
[...]

> I agree that anytime you get deeper than 1 spinlock there are issues.
> I don't think the current kernel gets deeper than 3 locks.  And yes
> this is a nasty case no questions asked.  This actually sounds like
> the lazy page table mechanism...
> 
> > > > > Right now there is a preemptible kernel patch being maintained
> > > > > somewhere.  I haven't had a chance to look recently.  But the recent
> > > > > threads on low latency mentioned it.
> > > > 
> > > > Try it out. Try running a kernel compile while a POSIX SCHED_FIFO process
> > > > is running.
> > > 
> > > My expectation would be that the SCHED_FIFO process would totally stop
> > > the kernel compile.  At least until it saw fit to sleep.
> > 
> > Right - even for a periodic SCHED_FIFO process that gives up the processor a
> > lot.
> > 
> > So how do you ensure that the router daemon runs, that network packets get
> > processed ...
> > 
> > that all the other things that normally happen because kernel tasks run to
> > completion
> > 
> > and because user programs all progress still happen?
> 
> Progress is a hard requirement especially when you give up fairness,
> and especially when you are wanting a specific amount of progress.  

Its good to run a general purpose OS under the rule that all processes
eventually progress. But then you cannot add the rule that the highest
priority RT task runs within some small T time units.
These rules are not compatible.


[...]

> The obvious case this solves is copy_from_user.  Which often is a real
> bottleneck, but if you add code to see if it should preempt itself it
> will run slower, and get less throughput.  At the same time
> copy_from_user does not have any locks held.  In that case preemption
> is the optimal approach.

Why is it optimal compared to just doing the copy and getting it over with?

	copy data and blow cache
vs
	copy some data and blow cache
	get preempted
	repeat N times


> > > Personally I have a hard time buying hard real time code.  Because
> > > there are always things cases where you cannot make guarantees.  To
> > > even have a clue what the speed of your code will really run at you
> > > need to take into account the exact platform your code will run at,
> > > and you need to know the operating environment for that platform.  And
> > > even with the best analysis and planning something still goes wrong.
> > 
> > 
> > Odd, I could have sworn it worked.
> 
> Hmm.  The mars probe problem not withstanding?  As I recall in that

Bug free software is not possible. Bug free hardware is not possible. 


> case it was only because they had a backup strategy, of rebooting the
> machine, for when the hard realtime requirements failed to be met that
> the system managed to land on mars.
> 
> Personally I think doing everything in your power to bound latencies
> and do everything possible to ensure that something will happen in a
> timely manner is the correct thing to do.  However you still have to
> keep the engineering assumption that something can still go wrong.  A
> gamma ray could hit your clock generater causing the cpu to run 5%
> slower, you could be running on a subtlely defective cpu, or a whole
> host of things.  

Sure. But consider:
	Personally I have a hard time  buying  bridge designs to always
	support max load. You could have defective cables, or a comet could
	land on the bridge, or ...



	
> 
> My problem with hard real time, is that just with a skim of it I get
> the feeling people are certain they can achieve their goals and not
> just come within 99.9999999999% of them.
> 
> And as systems get more complex the probability of the inevitiable
> failure is due human error goes up.  As I recall the mars lander it
> was a bug in the implementation of priority inheritance.

Actually it was a design error in VxWorks. 

