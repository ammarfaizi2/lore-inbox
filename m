Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263204AbUEBS3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263204AbUEBS3a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 14:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbUEBS3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 14:29:30 -0400
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:24605 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S263204AbUEBS3K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 14:29:10 -0400
Date: Sun, 2 May 2004 11:28:12 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Jack Steiner <steiner@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RCU scaling on large systems
Message-ID: <20040502182811.GA1244@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20040501120805.GA7767@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040501120805.GA7767@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Jack!

On Sat, May 01, 2004 at 07:08:05AM -0500, Jack Steiner wrote:
> 
> Has anyone investigated scaling of the RCU algorithms on large
> cpu-count systems?
> 
> We are running 2.6.5 on a 512p system. The RCU update code is causing 
> a near-livelock when booting. Several times, I dropped into kdb &
> found many of the cpus in the RCU code. The cpus are in
> rcu_check_quiescent_state() spinning on the rcu_ctrlblk.mutex.

The current RCU grace-period-detection infrastructure was designed
for a few tens of CPUs, so it is absolutely no surprise that it 
does not serve you well on a 512-CPU system.

The current RCU infrastructure algorithm can be thought of as a 
lazy barrier controlled by a bitmask.  For 512 CPUs, I believe that
more of a combining-tree algorithm will be needed.  If you have
a NUMA-like architecture, then the structure of the combining tree
will of course want to reflect the underlying hardware architecture.
Then any time period during which each of the individual NUMA nodes
passed through a local grace period is a global grace period.
This approach allows you to have per-NUMA-node RCU locks and a global
RCU lock, reducing the number of acquisitions of the global lock
by the ratio of the number of CPUs to the number of nodes.

>From your numbers below, I would guess that if you have at least
8 CPUs per NUMA node, a two-level tree would suffice.  If you have
only 4 CPUs per NUMA node, you might well need a per-node level,
a per-4-nodes level, and a global level to get the global lock
contention reduced sufficiently.

> I also found an interesting anomaly that was traced to RCU. I have
> a program that measures "cpu efficiency". Basically, the program 
> creates a cpu bound thread for each cpu & measures the percentage 
> of time that each cpu ACTUALLY spends executing user code.
> On an idle each system, each cpu *should* spend >99% in user mode.
> 
> On a 512p idle 2.6.5 system, each cpu spends ~6% of the time in the kernel
> RCU code. The time is spent contending for shared cache lines.

Again, no surprise, Linux's RCU was not designed for a 512-CPU
system.  ;-)

The hierarchical grace-period-detection scheme described above
also increases cache locality, greatly reducing the cache-thrashing
you are seeing.

> Even more bizarre: if I repeatedly type "ls" in a *single* window 
> (probably 5 times/sec), then EVERY CPU IN THE SYSTEM spends ~50%
> of the time in the RCU code.

Hmmm...  How large was the directory you were running "ls" on?
At first blush, it sounds like the "ls" was somehow provoking
a dcache update, which would then exercise RCU.

> The RCU algorithms don't scale - at least on our systems!!!!!

As noted earlier, the current implementation is not designed for
512 CPUs.  And, as noted earlier, there are ways to make it
scale.  But for some reason, we felt it advisable to start with
a smaller, simpler, and hence less scalable implementation.  ;-)

> Attached is an experimental hack that fixes the problem. I
> don't believe that this is the correct fix but it does prove
> that slowing down the frequency of updates fixes the problem.
> 
> 
> With this hack, "ls" no longer measurable disturbs other cpus. Each
> cpu spends ~99.8% of its time in user code regardless of the frequency
> of typing "ls".
> 
> 
> 
> By default, the RCU code attempts to process callbacks on each cpu
> every tick. The hack adds a mask so that only a few cpus process
> callbacks each tick. 

Cute!  However, it is not clear to me that this approach is
compatible with real-time use of RCU, since it results in CPUs
processing their callbacks less frequently, and thus getting
more of them to process at a time.

But it is not clear to me that anyone is looking for realtime
response from a 512-CPU machine (yow!!!), so perhaps this
is not a problem...

> I ran a simple experiment to vary the mask. Col 1 shows the mask
> value, col 2 show system time when system is idle, col 3 shows
> system time when typing "ls" on a single cpu. The percentages are
> "eyeballed averages" for all cpus.
> 
> 	VAL	idle%	"ls" %
> 	0	6.00	55.00
> 	1	2.00	50.00
> 	3	 .20	20.00
> 	7	 .20	  .22
> 	15	 .20	  .24
> 	31	 .19	  .25
> 	63	 .19	  .26
> 	127	 .19	  .25
> 	511	 .19	  .19
> 
> Looks like any value >7 or 15 should be ok on our hardware. I picked 
> a larger value because I don't understand how heavy loads affect the 
> optimal value.  I suspect that the optimal value is architecture
> dependent & probably platform dependent.
> 
> 
> Is anyone already working on this issue?
> 
> Comments and additional insight appreciated..........

This patch certainly seems simple enough, and I would guess that
"jiffies" is referenced often enough that it is warm in the cache
despite being frequently updated.

Other thoughts?

						Thanx, Paul

> Index: linux/include/linux/rcupdate.h
> ===================================================================
> --- linux.orig/include/linux/rcupdate.h	2004-04-30 09:59:00.000000000 -0500
> +++ linux/include/linux/rcupdate.h	2004-04-30 10:01:37.000000000 -0500
> @@ -41,6 +41,7 @@
>  #include <linux/threads.h>
>  #include <linux/percpu.h>
>  #include <linux/cpumask.h>
> +#include <linux/jiffies.h>
>  
>  /**
>   * struct rcu_head - callback structure for use with RCU
> @@ -84,6 +85,14 @@
>          return (a - b) > 0;
>  }
>  
> +#define RCU_JIFFIES_MASK 15
> +
> +/* Is it time to process a batch on this cpu */
> +static inline int rcu_time(int cpu)
> +{
> +	return (((jiffies - cpu) & RCU_JIFFIES_MASK) == 0);
> +}
> +
>  /*
>   * Per-CPU data for Read-Copy Update.
>   * nxtlist - new callbacks are added here
> @@ -111,11 +120,11 @@
>  
>  static inline int rcu_pending(int cpu) 
>  {
> -	if ((!list_empty(&RCU_curlist(cpu)) &&
> +	if (rcu_time(cpu) && ((!list_empty(&RCU_curlist(cpu)) &&
>  	     rcu_batch_before(RCU_batch(cpu), rcu_ctrlblk.curbatch)) ||
>  	    (list_empty(&RCU_curlist(cpu)) &&
>  			 !list_empty(&RCU_nxtlist(cpu))) ||
> -	    cpu_isset(cpu, rcu_ctrlblk.rcu_cpu_mask))
> +	    cpu_isset(cpu, rcu_ctrlblk.rcu_cpu_mask)))
>  		return 1;
>  	else
>  		return 0;
> -- 
> Thanks
> 
> Jack Steiner (steiner@sgi.com)          651-683-5302
> Principal Engineer                      SGI - Silicon Graphics, Inc.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
