Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267356AbTAQLAu>; Fri, 17 Jan 2003 06:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267487AbTAQLAu>; Fri, 17 Jan 2003 06:00:50 -0500
Received: from ophelia.ess.nec.de ([193.141.139.8]:58285 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S267356AbTAQLAr> convert rfc822-to-8bit; Fri, 17 Jan 2003 06:00:47 -0500
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 2.5.58] new NUMA scheduler: fix
Date: Fri, 17 Jan 2003 12:10:03 +0100
User-Agent: KMail/1.4.3
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Andrew Theurer <habanero@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Linus Torvalds <torvalds@transmeta.com>
References: <Pine.LNX.4.44.0301162110480.10526-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0301162110480.10526-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301171210.03567.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On Thursday 16 January 2003 21:19, Ingo Molnar wrote:
> On Thu, 16 Jan 2003, Martin J. Bligh wrote:
> > > complex. It's the one that is aware of the global scheduling picture.
> > > For NUMA i'd suggest two asynchronous frequencies: one intra-node
> > > frequency, and an inter-node frequency - configured by the architecture
> > > and roughly in the same proportion to each other as cachemiss
> > > latencies.
> >
> > That's exactly what's in the latest set of patches - admittedly it's a
> > multiplier of when we run load_balance, not the tick multiplier, but
> > that's very easy to fix. Can you check out the stuff I posted last
> > night? I think it's somewhat cleaner ...
>
> yes, i saw it, it has the same tying between idle-CPU-rebalance and
> inter-node rebalance, as Erich's patch. You've put it into
> cpus_to_balance(), but that still makes rq->nr_balanced a 'synchronously'
> coupled balancing act. There are two synchronous balancing acts currently:
> the 'CPU just got idle' event, and the exec()-balancing (*) event. Neither
> must involve any 'heavy' balancing, only local balancing.


I prefer a single point of entry called load_balance() to multiple
functionally different balancers. The reason is that the later choice
might lead to balancers competing or working against each other. Not
now but the design could mislead to such developments. 

But the main other reasons for calling the cross-node balancer after
NODE_BALANCE_RATE calls to the intra-node balancer (you call it
synchronous balancing) is performance:

Davide Libenzi showed quite a while ago that one benefits a lot if the
idle CPUs stay idle for rather short time. IIRC, his conclusion for
the multi-queue scheduler was that an order of magnitude of 10ms is
long enough, below you start feeling the balancing overhead, above you
waste useful cycles.

On a NUMA system this is even more important: the longer you leave
fresh tasks on an overloaded node, the more probable it is that they
allocate their memory there. And then they will run with poor
performance on the node which stayed idle for 200-400ms before
stealing them. So one wastes 200-400ms on each CPU of the idle node
and at the end gets tasks which perform poorly, anyway. If the tasks
are "old", at least we didn't waste too much time beeing idle. The
long-term target should be that the tasks should remember where their
memory is and return to that node.

> The inter-node
> balancing (which is heavier than even the global SMP balancer), should
> never be triggered from the high-frequency path.

Hmmm, we made it really slim. Actually the cross-node balancing might
even be cheaper than the global SMP balancer:
- it first loops over the nodes (loop length 4 on a 16 CPU NUMA-Q & Azusa)
- then it loops over the cpumask of the most loaded node + the current
CPU (loop length 5 on a NUMA-Q & Azusa).
This has to be compared with the loop length of 16 when doing the
global SMP rebalance. The additional work done for averaging is
minimal. The more nodes, the cheaper the NUMA cross-node balancing
compared to the global SMP balancing.

Besides: the CPU is idle anyway! So who cares whether it just
unsuccessfully scans its own empty node or looks at the other nodes
from time to time? It does this lockless and doesn't modify any
variables in other runqueues, so doesn't create cache misses for other
CPUs.

> [whether it's high
> frequency or not depends on the actual workload, but it can be potentially
> _very_ high frequency, easily on the order of 1 million times a second -
> then you'll call the inter-node balancer 100K times a second.]

You mean because cpu_idle() loops over schedule()? The code is:
        while (1) {
                void (*idle)(void) = pm_idle;
                if (!idle)
                        idle = default_idle;
                irq_stat[smp_processor_id()].idle_timestamp = jiffies;
                while (!need_resched())
                        idle();
                schedule();
        }
So if the CPU is idle, it won't go through schedule(), except we get
an interrupt from time to time... And then, it doesn't really
matter. Or do you want to keep idle CPUs free for serving interrupts?
That could be legitimate, but is not the typical load I had in
mind and is an issue not related to the NUMA scheduler. But maybe you
have something else in mind, that I didn't consider, yet.

Under normal conditions the rebalancing I though about would work the
following way:

Busy CPU:
 - intra-node rebalance every 200ms (interval timer controlled)
 - cross-node rebalance every NODE_BALANCE_RATE*200ms (2s)
 - when about to go idle, rebalance internally or across nodes, 10
 times more often within the node

Idle CPU:
 - intra-node rebalance every 1ms
 - cross-node rebalance every NODE_REBALANCE_RATE * 1ms (10ms)
   This doesn't appear to be too frequent for me... after all the cpu
   is idle and couldn't steal anything from it's own node.

I don't insist too much on this design, but I can't see any serious
reasons against it. Of course, the performance should decide.

I'm about to test the two versions in discussion on an NEC Asama
(small configuration with 4 nodes, good memory latency ratio between
nodes (1.6), no node-level cache). 

Best regards,
Erich


On Thursday 16 January 2003 21:19, Ingo Molnar wrote:
> On Thu, 16 Jan 2003, Martin J. Bligh wrote:
> > > complex. It's the one that is aware of the global scheduling picture.
> > > For NUMA i'd suggest two asynchronous frequencies: one intra-node
> > > frequency, and an inter-node frequency - configured by the architecture
> > > and roughly in the same proportion to each other as cachemiss
> > > latencies.
> >
> > That's exactly what's in the latest set of patches - admittedly it's a
> > multiplier of when we run load_balance, not the tick multiplier, but
> > that's very easy to fix. Can you check out the stuff I posted last
> > night? I think it's somewhat cleaner ...
>
> yes, i saw it, it has the same tying between idle-CPU-rebalance and
> inter-node rebalance, as Erich's patch. You've put it into
> cpus_to_balance(), but that still makes rq->nr_balanced a 'synchronously'
> coupled balancing act. There are two synchronous balancing acts currently:
> the 'CPU just got idle' event, and the exec()-balancing (*) event. Neither
> must involve any 'heavy' balancing, only local balancing. The inter-node
> balancing (which is heavier than even the global SMP balancer), should
> never be triggered from the high-frequency path. [whether it's high
> frequency or not depends on the actual workload, but it can be potentially
> _very_ high frequency, easily on the order of 1 million times a second -
> then you'll call the inter-node balancer 100K times a second.]
>
> I'd strongly suggest to decouple the heavy NUMA load-balancing code from
> the fastpath and re-check the benchmark numbers.
>
> 	Ingo
>
> (*) whether sched_balance_exec() is a high-frequency path or not is up to
> debate. Right now it's not possible to get much more than a couple of
> thousand exec()'s per second on fast CPUs. Hopefully that will change in
> the future though, so exec() events could become really fast. So i'd
> suggest to only do local (ie. SMP-alike) balancing in the exec() path, and
> only do NUMA cross-node balancing with a fixed frequency, from the timer
> tick. But exec()-time is really special, since the user task usually has
> zero cached state at this point, so we _can_ do cheap cross-node balancing
> as well. So it's a boundary thing - probably doing the full-blown
> balancing is the right thing.

