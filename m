Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263843AbUECSlC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263843AbUECSlC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 14:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbUECSlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 14:41:01 -0400
Received: from cfcafw.SGI.COM ([198.149.23.1]:33508 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S263843AbUECSkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 14:40:19 -0400
Date: Mon, 3 May 2004 13:40:06 -0500
From: Jack Steiner <steiner@sgi.com>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RCU scaling on large systems
Message-ID: <20040503184006.GA10721@sgi.com>
References: <20040501120805.GA7767@sgi.com> <20040502182811.GA1244@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040502182811.GA1244@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul - 

Thanks for the reply.


Additional data from experiments today.

As expected, there are multiple hot spots related to the rcu_ctrlblk.

	- scheduler_tick() in the rcu_pending macro. Specifically, on the
	  load of the rcu_cpu_mask.

	- rcu_check_quiescent_state() on spin_lock(&rcu_ctrlblk.mutex);

These two spots are are ~equally hot. 

Some of the cache line contention could be alleviated by separating 
these fields into multiple cache lines.  Wli posted a patch over the 
weekend that does that. I have not had a chance to review the patch in 
detail but it looks a reasonable idea.



-----------------
Response to your mail:



> >From your numbers below, I would guess that if you have at least
> 8 CPUs per NUMA node, a two-level tree would suffice.  If you have
> only 4 CPUs per NUMA node, you might well need a per-node level,
> a per-4-nodes level, and a global level to get the global lock
> contention reduced sufficiently.

The system consists of 256 nodes. Each node has 2 cpus located on
a shared FSB. The nodes are packaged as 128 modules - 2 nodes per
module. The 2 nodes in a module are slightly "closer" latency-wise 
than nodes in different modules. 


> 
> > I also found an interesting anomaly that was traced to RCU. I have
> > a program that measures "cpu efficiency". Basically, the program 
> > creates a cpu bound thread for each cpu & measures the percentage 
> > of time that each cpu ACTUALLY spends executing user code.
> > On an idle each system, each cpu *should* spend >99% in user mode.
> > 
> > On a 512p idle 2.6.5 system, each cpu spends ~6% of the time in the kernel
> > RCU code. The time is spent contending for shared cache lines.
> 
> Again, no surprise, Linux's RCU was not designed for a 512-CPU
> system.  ;-)
> 
> The hierarchical grace-period-detection scheme described above
> also increases cache locality, greatly reducing the cache-thrashing
> you are seeing.
> 
> > Even more bizarre: if I repeatedly type "ls" in a *single* window 
> > (probably 5 times/sec), then EVERY CPU IN THE SYSTEM spends ~50%
> > of the time in the RCU code.
> 
> Hmmm...  How large was the directory you were running "ls" on?
> At first blush, it sounds like the "ls" was somehow provoking
> a dcache update, which would then exercise RCU.

The directory size does not seem to be too significant. I tried one test 
on a NFS directory with 250 files. Another test on /tmp with 25 files.
In both cases, the results were similar. 


> 
> > The RCU algorithms don't scale - at least on our systems!!!!!
> 
> As noted earlier, the current implementation is not designed for
> 512 CPUs.  And, as noted earlier, there are ways to make it
> scale.  But for some reason, we felt it advisable to start with
> a smaller, simpler, and hence less scalable implementation.  ;-)

Makes sense. I would not have expected otherwise. Overall, linux scales
to 512p much better than I would have predicted. 

Is anyone working on improving RCU scaling to higher cpu counts. I
dont want to duplicate any work that is already in progress.
Otherwise, I'll start investigating what can be done to improve
scaling. 




> 
> > Attached is an experimental hack that fixes the problem. I
> > don't believe that this is the correct fix but it does prove
> > that slowing down the frequency of updates fixes the problem.
> > 
> > 
> > With this hack, "ls" no longer measurable disturbs other cpus. Each
> > cpu spends ~99.8% of its time in user code regardless of the frequency
> > of typing "ls".
> > 
> > 
> > 
> > By default, the RCU code attempts to process callbacks on each cpu
> > every tick. The hack adds a mask so that only a few cpus process
> > callbacks each tick. 
> 
> Cute!  However, it is not clear to me that this approach is
> compatible with real-time use of RCU, since it results in CPUs
> processing their callbacks less frequently, and thus getting
> more of them to process at a time.
> 
> But it is not clear to me that anyone is looking for realtime
> response from a 512-CPU machine (yow!!!), so perhaps this
> is not a problem...

Agree on both counts.


-- 
Thanks

Jack Steiner (steiner@sgi.com)          651-683-5302
Principal Engineer                      SGI - Silicon Graphics, Inc.
