Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263776AbUEGUxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263776AbUEGUxO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 16:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263772AbUEGUxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 16:53:14 -0400
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:22923 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S263776AbUEGUvx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 16:51:53 -0400
Date: Fri, 7 May 2004 13:50:48 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Jack Steiner <steiner@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RCU scaling on large systems
Message-ID: <20040507205048.GB1246@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20040501120805.GA7767@sgi.com> <20040502182811.GA1244@us.ibm.com> <20040503184006.GA10721@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040503184006.GA10721@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2004 at 01:40:06PM -0500, Jack Steiner wrote:
> Paul - 
> 
> Thanks for the reply.
> 
> 
> Additional data from experiments today.
> 
> As expected, there are multiple hot spots related to the rcu_ctrlblk.
> 
> 	- scheduler_tick() in the rcu_pending macro. Specifically, on the
> 	  load of the rcu_cpu_mask.

Going to a hierarchical approach would break this up, especially if
the hierarchy reflected the NUMA structure of the machine.

> 	- rcu_check_quiescent_state() on spin_lock(&rcu_ctrlblk.mutex);

Again, in a hierarchical approach, this would be the lock at the
lowest level of the hierarchy.

> These two spots are are ~equally hot. 
> 
> Some of the cache line contention could be alleviated by separating 
> these fields into multiple cache lines.  Wli posted a patch over the 
> weekend that does that. I have not had a chance to review the patch in 
> detail but it looks a reasonable idea.

Could help or hurt -- multiple cachelines can be accessed in parallel,
which should speed things up, but the need to load multiple cachelines
could slow other things down.

> -----------------
> Response to your mail:
> 
> 
> 
> > >From your numbers below, I would guess that if you have at least
> > 8 CPUs per NUMA node, a two-level tree would suffice.  If you have
> > only 4 CPUs per NUMA node, you might well need a per-node level,
> > a per-4-nodes level, and a global level to get the global lock
> > contention reduced sufficiently.
> 
> The system consists of 256 nodes. Each node has 2 cpus located on
> a shared FSB. The nodes are packaged as 128 modules - 2 nodes per
> module. The 2 nodes in a module are slightly "closer" latency-wise 
> than nodes in different modules. 

If the latency difference is sufficiently slight, a two-level scheme
that split the system up into 16 blocks of 8 nodes (16 CPUs) each
would seem most likely to help.

> > > I also found an interesting anomaly that was traced to RCU. I have
> > > a program that measures "cpu efficiency". Basically, the program 
> > > creates a cpu bound thread for each cpu & measures the percentage 
> > > of time that each cpu ACTUALLY spends executing user code.
> > > On an idle each system, each cpu *should* spend >99% in user mode.
> > > 
> > > On a 512p idle 2.6.5 system, each cpu spends ~6% of the time in the kernel
> > > RCU code. The time is spent contending for shared cache lines.
> > 
> > Again, no surprise, Linux's RCU was not designed for a 512-CPU
> > system.  ;-)
> > 
> > The hierarchical grace-period-detection scheme described above
> > also increases cache locality, greatly reducing the cache-thrashing
> > you are seeing.
> > 
> > > Even more bizarre: if I repeatedly type "ls" in a *single* window 
> > > (probably 5 times/sec), then EVERY CPU IN THE SYSTEM spends ~50%
> > > of the time in the RCU code.
> > 
> > Hmmm...  How large was the directory you were running "ls" on?
> > At first blush, it sounds like the "ls" was somehow provoking
> > a dcache update, which would then exercise RCU.
> 
> The directory size does not seem to be too significant. I tried one test 
> on a NFS directory with 250 files. Another test on /tmp with 25 files.
> In both cases, the results were similar. 

Hmmm...  I took a quick glance, but don't see why an "ls" would
cause RCU to be invoked.  This should only happen if a dentry is
ejected from dcache.

Any enlightenment appreciated!

> > > The RCU algorithms don't scale - at least on our systems!!!!!
> > 
> > As noted earlier, the current implementation is not designed for
> > 512 CPUs.  And, as noted earlier, there are ways to make it
> > scale.  But for some reason, we felt it advisable to start with
> > a smaller, simpler, and hence less scalable implementation.  ;-)
> 
> Makes sense. I would not have expected otherwise. Overall, linux scales
> to 512p much better than I would have predicted. 

Indeed!  I am impressed!

> Is anyone working on improving RCU scaling to higher cpu counts. I
> dont want to duplicate any work that is already in progress.
> Otherwise, I'll start investigating what can be done to improve
> scaling. 

We are focusing first on some of the update-side code, which on
our systems is a much tighter bottleneck than is the RCU infrastructure.
I expect that we will need to increase RCU scaling eventually, but
if you have a short-term need, you should go ahead.  I will of course
be more than happy to review and comment.  One challenge will be
coming up with something that works efficiently both for small
and large machines.  Maybe some arch-specific code is required, but
it would be good to avoid this, if possible.

> > > Attached is an experimental hack that fixes the problem. I
> > > don't believe that this is the correct fix but it does prove
> > > that slowing down the frequency of updates fixes the problem.
> > > 
> > > 
> > > With this hack, "ls" no longer measurable disturbs other cpus. Each
> > > cpu spends ~99.8% of its time in user code regardless of the frequency
> > > of typing "ls".
> > > 
> > > 
> > > 
> > > By default, the RCU code attempts to process callbacks on each cpu
> > > every tick. The hack adds a mask so that only a few cpus process
> > > callbacks each tick. 
> > 
> > Cute!  However, it is not clear to me that this approach is
> > compatible with real-time use of RCU, since it results in CPUs
> > processing their callbacks less frequently, and thus getting
> > more of them to process at a time.
> > 
> > But it is not clear to me that anyone is looking for realtime
> > response from a 512-CPU machine (yow!!!), so perhaps this
> > is not a problem...
> 
> Agree on both counts.

I will let you and Jesse hash out the need for realtime response
on a 512-way machine.  ;-)

						Thanx, Paul

> -- 
> Thanks
> 
> Jack Steiner (steiner@sgi.com)          651-683-5302
> Principal Engineer                      SGI - Silicon Graphics, Inc.
> 
