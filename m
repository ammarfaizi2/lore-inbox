Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271836AbRH1TKm>; Tue, 28 Aug 2001 15:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271883AbRH1TKd>; Tue, 28 Aug 2001 15:10:33 -0400
Received: from yktgi01e0-s1.watson.ibm.com ([198.81.209.16]:31119 "HELO
	ssm22.watson.ibm.com") by vger.kernel.org with SMTP
	id <S271836AbRH1TKT>; Tue, 28 Aug 2001 15:10:19 -0400
Date: Tue, 28 Aug 2001 06:30:10 -0400
From: Hubertus Franke <frankeh@watson.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [frankeh@watson.ibm.com: Re: Is it bad to have lots of sleeping tasks?]
Message-ID: <20010828063010.A733@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alan Cox <alan@lxorguk.ukuu.org.uk> on 08/27/2001 03:18:39 PM
> 
> 
> > Alan is right, I would not be too concerned about the recalculate
> > loop. There are patches out that would basically eliminate the
> > update of all tasks during recalculate, but they come at an additional
> > cost during add_from_runqueue and del_from_runqueue. I don't know
> > exactly where the break-even point is where either solution is
> > worse of better.
> 
> The overhead will be pretty close to zero since the update will be for a
> task that is in local cache, so its a tiny bit of math from L1 cache with
> writes that don't cause stalls.

Agreed, nothing to be to worried about
> 
> > We presented this stuff at OLS and since then have improved the
> > low running-thread count scenario.
> 
> > The MQ is functionally equivalent to the current scheduler
> 
> This is one of the things I think we have wrong although I understand
> keeping the behaviour was part of the goal of your code. The scheduler
> should be cache optimising for cpu soakers at least. That also seems
> to simplify the scheduler not make it more complex.

As it stands right now, I would consider it <cache optimising> as the
p->processor is still taken into account. There is no temporal decay though.

> 
> For example we tend to schedule events badly - consider processes A and B
> and are CPU suckers and an editor. Each time you hit a key and wake the
> editor you tend to flip between running A and B.
> 
> I'd like to see us end up with an O(1) [for hardware ffz at least]
> scheduler
> that did the right things for cache locality. I've got some ideas but I
> don't know how to make them work SMP.
> 

For that you need to adequately estimate the cache state of a process.
There is some stuff out there as long as you can track the cache misses for
a given application. In our MQ project we also implemented an priority level
scheduler that utilizes ffz(), however the overhead for the lowend was 
considerable and ended up worse then the current scheduler. One of the
problems there is that if the running tasks are still touched then they
are likely on the top of the priority lists (or the upper ranges).
Taking them out every time we run a task, seems also undesirable, particularly
there are some race conditions.

In our presentation at OLS (on the lse website) we showed some of the problems
(a) sticking with a single runqueue lock is a true scalability problem
    This is due to the fact that the interarrival rate of scheduling calls
    is getting tighter and tighter with an increase in #cpus.
    We measured for a simple TPC-H like load interarrival rates of 
    ~500 microseconds for a 2-way and ~4 tasks on the runqueue on average.
    For an 8-way that went down to 50-90 microseconds interarrival rate at 
    ~8 tasks on the runqueue. The lock hold times did not substantially change.
    However the lockcontention in the 2-way went from something like 5% to
    almost 50%.
    This tells us we need to break up the lock in order to scale, even if
    we can provide a O(1) scheduler.
(b) The question then arises, we can make the MQ behave such that it 
    schedules locally only and doesn't scan across other cpus.
    Currently the MQ has an order O(T[i] + N) where T[i] is average runqueue
    length of cpu-i and N is number of CPUs. 
    Scanning only locally getting O(T[i]) which in low task count situations
    would be O(1) is not sufficient, as we can get load inbalances as
    also shown in our paper at OLS.
    We have a solution for this for an upcoming ALS paper and also already
    described on lse which is pooling and load balancing.
    We see some performance increases for NUMA machines and less for large
    SMP machines as compared to the MQ itself.
    
> > Alan, could you suggest some benchmarks to run for 2-way systems,
> > that have low thread counts, are easily reproducable (no big setup and
> > large system configuration required) that would help us make the point
> > for a larger set of application then we have targetted.
> 
> Lmbench can be useful for small scale numbers, although it isnt intended
> currently to measure SMP. Perhaps Larry can comment on that.

We used lat_ctx, but it doesn't give a lot of control. We use another 
similar benchmark (called reflex) that creates a bit more randomness.
On lat_ctx we do see the same performance as the vanilla scheduler.

> 
> We certainly both agree the scheduler needs work
> 
> Alan
> 

I like to iterate more on the design that you have in mind.
Could you give some description.
It must be somewhat similar in spirit as we do with pooling in that
you schedule locally for a while (thus providing the O(1) characteristics)
and then consolidate the differences in loadinbalances/fairness 
that have accumulated over time at a much larger time quantum.

However you still have to make sure you don't leave idle_cpus idle if the
load > #cpus, which basically can create a hot cache line. We solved that
in the pooling extension to MQ by a idle_mask.  

-- Hubertus Franke  (frankeh@watson.ibm.com)


