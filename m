Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265210AbUE0XX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265210AbUE0XX4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 19:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265211AbUE0XXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 19:23:55 -0400
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:15611 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S265210AbUE0XXq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 19:23:46 -0400
Date: Thu, 27 May 2004 16:22:11 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Manfred Spraul <manfred@dbl.q-ag.de>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] [RFC, PATCH] 2/5 rcu lock update: Use a sequence lock for starting batches
Message-ID: <20040527232210.GA2558@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <200405250535.i4P5ZLiR017599@dbl.q-ag.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405250535.i4P5ZLiR017599@dbl.q-ag.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Manfred,

I am still digging through these, and things look quite good in general,
but I have a question on your second patch.

Given the following sequence of events:

1.	CPU 0 executes the

		rcu_ctrlblk.batch.next_pending = 1;

	at the beginning of rcu_start_batch().

2.	CPU 1 executes the read_seqcount code sequence in
	rcu_process_callbacks(), setting RCU_batch(cpu) to
	the next batch number, and setting next_pending to 1.

3.	CPU 0 executes the remainder of rcu_start_batch(),
	setting rcu_ctrlblk.batch.next_pending to 0 and
	incrementing rcu_ctrlblk.batch.cur.

4.	CPU 1's state is now as if the grace period had already
	completed for the callbacks that were just moved to
	RCU_curlist(), which would be very bad.

First, can this sequence of events really happen?  I cannot see
anything that prevents it, but on the other hand, am writing this
while under the influence of heavy-duty decongestants.

Second, is CPU 1's state really "grace period completed"?
See previous disclaimer.

If this really is a problem, it seems like the fix would be
to extend the range of the write_seqcount to cover the entire
body of rcu_start_batch().  Which would increase the number
of write_seqcount calls, degrading performance.  Might not be
enough to worry about, but 512 CPUs is 512 CPUs...

Another approach would be to do the write_seqcount_begin() in
both "if" statements, and to do the corresponding write_seqcount_end()
if the begin had happened.  If this is a concern, something like the
following might be appropriate:

static void rcu_start_batch(int next_pending)
{
	cpumask_t active;
	int writeseq = 0;

	if (next_pending) {
		write_seqcount_begin(&rcu_ctrlblk.batch.lock);
		writeseq = 1;
		rcu_ctrlblk.batch.next_pending = 1;
	}

	if (rcu_ctrlblk.batch.next_pending &&
			rcu_ctrlblk.batch.completed == rcu_ctrlblk.batch.cur) {
		/* Can't change, since spin lock held. */
		active = nohz_cpu_mask;
		cpus_complement(active);
		cpus_and(rcu_ctrlblk.state.rcu_cpu_mask, cpu_online_map, active);
		if (!writeseq) {
			write_seqcount_begin(&rcu_ctrlblk.batch.lock);
			writeseq = 1;
		}
		rcu_ctrlblk.batch.next_pending = 0;
		rcu_ctrlblk.batch.cur++;
	}
	if (writeseq)
		write_seqcount_end(&rcu_ctrlblk.batch.lock);
}

Thoughts?

Will continue looking through the patches, more later.

						Thanx, Paul

On Tue, May 25, 2004 at 07:35:21AM +0200, Manfred Spraul wrote:
> Hi,
> 
> Step two for reducing cacheline trashing within rcupdate.c:
> 
> rcu_process_callbacks always acquires rcu_ctrlblk.state.mutex and
> calls rcu_start_batch, even if the batch is already running or already
> scheduled to run.
> This can be avoided with a sequence lock: A sequence lock allows
> to read the current batch number and next_pending atomically. If
> next_pending is already set, then there is no need to acquire the
> global mutex.
> 
> This means that for each grace period, there will be
> 
> - one write access to the rcu_ctrlblk.batch cacheline
> - lots of read accesses to rcu_ctrlblk.batch (3-10*cpus_online(),
>   perhaps even more).
>   
>   Behavior similar to the jiffies cacheline, shouldn't be a problem.
>   
> - cpus_online()+1 write accesses to rcu_ctrlblk.state, all of them
>   starting with spin_lock(&rcu_ctrlblk.state.mutex).
> 
>   For large enough cpus_online() this will be a problem, but all
>   except two of the spin_lock calls only protect the rcu_cpu_mask
>   bitmap, thus a hierarchical bitmap would allow to split the write
>   accesses to multiple cachelines.
> 
> Tested on an 8-way with reaim. Unfortunately it probably won't help
> with Jack Steiner's 'ls' test since in this test only one cpu
> generates rcu entries.
> 
> What do you think?
> 
> --
> 	Manfred
> 
> // $Header$
> // Kernel Version:
> //  VERSION = 2
> //  PATCHLEVEL = 6
> //  SUBLEVEL = 6
> //  EXTRAVERSION = -mm4
> --- 2.6/kernel/rcupdate.c	2004-05-23 11:53:46.000000000 +0200
> +++ build-2.6/kernel/rcupdate.c	2004-05-23 11:53:52.000000000 +0200
> @@ -47,7 +47,7 @@
>  
>  /* Definition for rcupdate control block. */
>  struct rcu_ctrlblk rcu_ctrlblk = 
> -	{ .batch = { .cur = -300, .completed = -300 },
> +	{ .batch = { .cur = -300, .completed = -300 , .lock = SEQCNT_ZERO },
>  	  .state = {.mutex = SPIN_LOCK_UNLOCKED, .rcu_cpu_mask = CPU_MASK_NONE } };
>  DEFINE_PER_CPU(struct rcu_data, rcu_data) = { 0L };
>  
> @@ -124,16 +124,18 @@
>  	cpumask_t active;
>  
>  	if (next_pending)
> -		rcu_ctrlblk.state.next_pending = 1;
> +		rcu_ctrlblk.batch.next_pending = 1;
>  
> -	if (rcu_ctrlblk.state.next_pending &&
> +	if (rcu_ctrlblk.batch.next_pending &&
>  			rcu_ctrlblk.batch.completed == rcu_ctrlblk.batch.cur) {
> -		rcu_ctrlblk.state.next_pending = 0;
>  		/* Can't change, since spin lock held. */
>  		active = nohz_cpu_mask;
>  		cpus_complement(active);
>  		cpus_and(rcu_ctrlblk.state.rcu_cpu_mask, cpu_online_map, active);
> +		write_seqcount_begin(&rcu_ctrlblk.batch.lock);
> +		rcu_ctrlblk.batch.next_pending = 0;
>  		rcu_ctrlblk.batch.cur++;
> +		write_seqcount_end(&rcu_ctrlblk.batch.lock);
>  	}
>  }
>  
> @@ -261,6 +263,8 @@
>  
>  	local_irq_disable();
>  	if (!list_empty(&RCU_nxtlist(cpu)) && list_empty(&RCU_curlist(cpu))) {
> +		int next_pending, seq;
> +
>  		__list_splice(&RCU_nxtlist(cpu), &RCU_curlist(cpu));
>  		INIT_LIST_HEAD(&RCU_nxtlist(cpu));
>  		local_irq_enable();
> @@ -268,10 +272,19 @@
>  		/*
>  		 * start the next batch of callbacks
>  		 */
> -		spin_lock(&rcu_ctrlblk.state.mutex);
> -		RCU_batch(cpu) = rcu_ctrlblk.batch.cur + 1;
> -		rcu_start_batch(1);
> -		spin_unlock(&rcu_ctrlblk.state.mutex);
> +		do {
> +			seq = read_seqcount_begin(&rcu_ctrlblk.batch.lock);
> +			/* determine batch number */
> +			RCU_batch(cpu) = rcu_ctrlblk.batch.cur + 1;
> +			next_pending = rcu_ctrlblk.batch.next_pending;
> +		} while (read_seqcount_retry(&rcu_ctrlblk.batch.lock, seq));
> +
> +		if (!next_pending) {
> +			/* and start it/schedule start if it's a new batch */
> +			spin_lock(&rcu_ctrlblk.state.mutex);
> +			rcu_start_batch(1);
> +			spin_unlock(&rcu_ctrlblk.state.mutex);
> +		}
>  	} else {
>  		local_irq_enable();
>  	}
> --- 2.6/include/linux/rcupdate.h	2004-05-23 11:53:46.000000000 +0200
> +++ build-2.6/include/linux/rcupdate.h	2004-05-23 11:53:52.000000000 +0200
> @@ -41,6 +41,7 @@
>  #include <linux/threads.h>
>  #include <linux/percpu.h>
>  #include <linux/cpumask.h>
> +#include <linux/seqlock.h>
>  
>  /**
>   * struct rcu_head - callback structure for use with RCU
> @@ -69,11 +70,14 @@
>  	struct {
>  		long	cur;		/* Current batch number.	      */
>  		long	completed;	/* Number of the last completed batch */
> +		int	next_pending;	/* Is the next batch already waiting? */
> +		seqcount_t lock;	/* for atomically reading cur and     */
> +		                        /* next_pending. Spinlock not used,   */
> +		                        /* protected by state.mutex           */
>  	} batch ____cacheline_maxaligned_in_smp;
>  	/* remaining members: bookkeeping of the progress of the grace period */
>  	struct {
>  		spinlock_t	mutex;	/* Guard this struct                  */
> -		int	next_pending;	/* Is the next batch already waiting? */
>  		cpumask_t	rcu_cpu_mask; 	/* CPUs that need to switch   */
>  				/* in order for current batch to proceed.     */
>  	} state ____cacheline_maxaligned_in_smp;
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: Oracle 10g
> Get certified on the hottest thing ever to hit the market... Oracle 10g. 
> Take an Oracle 10g class now, and we'll give you the exam FREE.
> http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
> _______________________________________________
> Lse-tech mailing list
> Lse-tech@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/lse-tech
> 
