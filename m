Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266648AbUGPXlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266648AbUGPXlZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 19:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266650AbUGPXlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 19:41:25 -0400
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:47429 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S266648AbUGPXkw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 19:40:52 -0400
Date: Fri, 16 Jul 2004 16:38:03 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Manfred Spraul <manfred@dbl.q-ag.de>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] [RFC, PATCH] 5/5 rcu lock update: Hierarchical rcu_cpu_mask bitmap
Message-ID: <20040716233803.GA1293@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <200405250535.i4P5ZO7I017623@dbl.q-ag.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405250535.i4P5ZO7I017623@dbl.q-ag.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2004 at 07:35:24AM +0200, Manfred Spraul wrote:
> Hi,
> 
> Step five for reducing cacheline trashing within rcupdate.c,
> third step for a hierarchical cpumask bitmap: 
> 
> Introduce a new cpu_quiet implementation based on a hierarchical
> bitmap, again based on generation numbers.
> 
> Each level contains a copy of the generation number. A mismatch means
> that the level is not yet initialized.
> 
> Most code changes depend on RCU_HUGE, the old (and more efficient)
> code remains unchanged and can be used for non-gargantuan systems.
> 
> Proof of concept, needs further cleanups and testing.
> Does pass reaim on an 8-way Pentium III Xeon.
> 
> What do you think?

Hello, Manfred,

Please accept my apologies for taking so long to go through this.
I could not find any functional problems, very impressive!

A few questions and comments, as always...

o	The two calls to rcu_batch_before are of the form:

		!rcu_batch_before(rcu_ctrlblk.completed,RCU_batch(cpu)))

	I recommend replacing these with:

		rcu_batch_done(RCU_batch(cpu))

	which is defined something like:

		static inline int rcu_batch_done(long b)
		{
			return (rcu_ctrlblk.completed - b) >= 0;
		}

	And then removing the unused rcu_batch_after().  [Yes, I know
	that you inherited much of this.  Guilty to charges as read!]

o	cpu_quiet()'s "force" argument seems to be used to indicate that
	the CPU is going offline.  Recommend either a name or comment
	making this explicit.

o	A few more things indicated below.

						Thanx, Paul

> // $Header$
> // Kernel Version:
> //  VERSION = 2
> //  PATCHLEVEL = 6
> //  SUBLEVEL = 6
> //  EXTRAVERSION = -mm4
> --- 2.6/kernel/rcupdate.c	2004-05-23 13:30:01.000000000 +0200
> +++ build-2.6/kernel/rcupdate.c	2004-05-23 13:31:23.000000000 +0200
> @@ -49,14 +49,48 @@
>  struct rcu_ctrlblk rcu_ctrlblk = 
>  	{ .cur = -300, .completed = -300 , .lock = SEQCNT_ZERO };
>  
> +/* XXX Dummy - should belong into arch XXX */
> +#define RCU_HUGE
> +#define RCU_GROUP_SIZE	2
> +/* XXX End of dummy XXX */
> +
> +#ifdef RCU_HUGE
> +
> +#define RCU_GROUPCOUNT		((NR_CPUS+RCU_GROUP_SIZE-1)/RCU_GROUP_SIZE)
> +#define RCU_GROUP_CPUMASKLEN	((RCU_GROUP_SIZE+BITS_PER_LONG-1)/BITS_PER_LONG)
> +#define RCU_GROUPMASKLEN	((NR_CPUS+RCU_GROUP_SIZE*BITS_PER_LONG-1)/(RCU_GROUP_SIZE*BITS_PER_LONG))
> +
> +struct rcu_group_state {
> +	spinlock_t	mutex; /* Guard this struct                           */
> +	long batchnum;
> +	unsigned long outstanding[RCU_GROUP_CPUMASKLEN];
> +} ____cacheline_maxaligned_in_smp;
> +
> +struct rcu_group_state rcu_groups[RCU_GROUPCOUNT] = 
> +	{ [0 ... RCU_GROUPCOUNT-1] =
> +		{ .mutex = SPIN_LOCK_UNLOCKED, .batchnum = -400 } };
> +
> +#endif
> +
>  /* Bookkeeping of the progress of the grace period */
>  struct {
>  	spinlock_t	mutex; /* Guard this struct and writes to rcu_ctrlblk */
> +#ifdef RCU_HUGE
> +	long batchnum;         /* batchnum we are working on. Mismatch with   */
> +	                       /* rcu_ctrlblk.cur means restart from scratch  */
> +	unsigned long outstanding[RCU_GROUPMASKLEN];
> +#else
>  	cpumask_t	rcu_cpu_mask; /* CPUs that need to switch in order    */
>  	                              /* for current batch to proceed.        */
> +#endif
>  } rcu_state ____cacheline_maxaligned_in_smp = 
> -	  {.mutex = SPIN_LOCK_UNLOCKED, .rcu_cpu_mask = CPU_MASK_NONE };
> -
> +	  {.mutex = SPIN_LOCK_UNLOCKED,
> +#ifdef RCU_HUGE
> +		.batchnum = -400,
> +#else
> +		.rcu_cpu_mask = CPU_MASK_NONE
> +#endif
> +	  };
>  
>  DEFINE_PER_CPU(struct rcu_data, rcu_data) = { 0L };
>  
> @@ -130,17 +164,23 @@
>   */
>  static void rcu_start_batch(int next_pending)
>  {
> -	cpumask_t active;
> -
>  	if (next_pending)
>  		rcu_ctrlblk.next_pending = 1;
>  
>  	if (rcu_ctrlblk.next_pending &&
>  			rcu_ctrlblk.completed == rcu_ctrlblk.cur) {
> +#ifdef RCU_HUGE
> +		/* Nothing to do: RCU_HUGE uses lazy initialization of the
> +		 * outstanding bitmap
> +		 */
> +#else
> +		cpumask_t active;
> +
>  		/* Can't change, since spin lock held. */
>  		active = nohz_cpu_mask;
>  		cpus_complement(active);
>  		cpus_and(rcu_state.rcu_cpu_mask, cpu_online_map, active);
> +#endif
>  		write_seqcount_begin(&rcu_ctrlblk.lock);
>  		rcu_ctrlblk.next_pending = 0;
>  		rcu_ctrlblk.cur++;
> @@ -153,6 +193,75 @@
>   * Clear it from the cpu mask and complete the grace period if it was the last
>   * cpu. Start another grace period if someone has further entries pending
>   */
> +#ifdef RCU_HUGE
> +static void cpu_quiet(int cpu, int force)
> +{
> +	struct rcu_group_state *rgs;
> +	long batch;
> +	int i;
> +
> +	batch = rcu_ctrlblk.cur;
> +
> +	rgs = &rcu_groups[cpu/RCU_GROUP_SIZE];
> +
> +	spin_lock(&rgs->mutex);
> +	if (rgs->batchnum != batch) {

Recommend pulling the following out as a separate (maybe inline) function.
Named something like init_batch_group().

> +		int offset;
> +		/* first call for this batch - initialize outstanding */
> +		rgs->batchnum = batch;
> +		memset(rgs->outstanding, 0, sizeof(rgs->outstanding));
> +		offset = (cpu/RCU_GROUP_SIZE)*RCU_GROUP_SIZE;
> +		for (i=0;i<RCU_GROUP_SIZE;i++) {
> +			if (cpu_online(i+offset) && !cpu_isset(i+offset, nohz_cpu_mask))
> +				__set_bit(i, rgs->outstanding);
> +		}

----------------------------------

> +	}
> +	if (unlikely(RCU_quiescbatch(cpu) != rgs->batchnum) && likely(!force))
> +       		goto out_unlock_group;
> +
> +	__clear_bit(cpu%RCU_GROUP_SIZE, rgs->outstanding);
> +	for (i=0;i<RCU_GROUP_CPUMASKLEN;i++) {
> +		if (rgs->outstanding[i])
> +			break;
> +	}
> +	if (i==RCU_GROUP_CPUMASKLEN) {
> +		/* group completed, escalate to global level */
> +		spin_lock(&rcu_state.mutex);
> +
> +		if (rcu_state.batchnum != rcu_ctrlblk.cur) {

Recommend pulling the following out as a separate (maybe inline) function.
Named something like init_batch_global().

> +			/* first call for this batch - initialize outstanding */
> +			rcu_state.batchnum = rcu_ctrlblk.cur;
> +			memset(rcu_state.outstanding, 0, sizeof(rcu_state.outstanding));
> +
> +			for (i=0;i<NR_CPUS;i+=RCU_GROUP_SIZE) {
> +				int j;
> +				for (j=0;j<RCU_GROUP_SIZE;j++) {
> +					if (cpu_online(i+j) && !cpu_isset(i+j, nohz_cpu_mask))
> +						break;
> +				}
> +				if (j != RCU_GROUP_SIZE)
> +					__set_bit(i/RCU_GROUP_SIZE, rcu_state.outstanding);
> +			}

-----------------------------

> +		}
> +		if (unlikely(rgs->batchnum != rcu_state.batchnum))
> +       			goto out_unlock_all;
> +		__clear_bit(cpu/RCU_GROUP_SIZE, rcu_state.outstanding);
> +		for (i=0;i<RCU_GROUPMASKLEN;i++) {
> +			if (rcu_state.outstanding[i])
> +				break;
> +		}
> +		if (i==RCU_GROUPMASKLEN) {
> +			/* all groups completed, batch completed */
> +			rcu_ctrlblk.completed = rcu_ctrlblk.cur;
> +			rcu_start_batch(0);
> +		}
> +out_unlock_all:
> +		spin_unlock(&rcu_state.mutex);
> +	}
> +out_unlock_group:
> +	spin_unlock(&rgs->mutex);
> +}
> +#else
>  static void cpu_quiet(int cpu, int force)
>  {
>  	spin_lock(&rcu_state.mutex);
> @@ -175,6 +284,7 @@
>  out_unlock:
>  	spin_unlock(&rcu_state.mutex);
>  }
> +#endif
>  
>  /*
>   * Check if the cpu has gone through a quiescent state (say context
> @@ -240,6 +350,7 @@
>  	 * we can block indefinitely waiting for it, so flush
>  	 * it here
>  	 */

I don't understand how the following helps, given that the CPU being
offlined is supposed to be completely dead by the time we get here.
Can't see anything that it really hurts other than a bit of delay in
an extremely infrequent operation, but...

> +	spin_unlock_wait(&rcu_state.mutex);
>  	cpu_quiet(cpu, 1);
>  
>  	rcu_move_batch(&RCU_curlist(cpu));
> @@ -250,11 +361,30 @@
>  
>  #endif
>  
> +#ifdef RCU_HUGE
> +static void rcu_update_group(int cpu)
> +{
> +	int i, offset;
> +	offset = (cpu/RCU_GROUP_SIZE)*RCU_GROUP_SIZE;
> +	for (i=0;i<RCU_GROUP_SIZE;i++) {
> +		if (cpu_online(i+offset) && !cpu_isset(i, nohz_cpu_mask))
> +			break;
> +	}
> +	if (i == RCU_GROUP_SIZE) {
> +		/* No cpu online from this group. Initialize batchnum. */

It took me a bit to figure out why this is safe without locking.
I believe it is safe because of the following:

1.	Only one CPU can come online at a time.

2.	The call from rcu_restart_cpu() is protected by rcu_state.mutex.

3.	Only the first CPU in a group coming online will get here,
	and in that case, there is no other CPU in the group to
	call rcu_restart_cpu(), e.g., via to-be-added nohz code.

Might be worth a comment.

> +		rcu_groups[cpu/RCU_GROUP_SIZE].batchnum = rcu_ctrlblk.completed;
> +	}
> +}
> +#endif
> +
>  void rcu_restart_cpu(int cpu)
>  {
>  	spin_lock_bh(&rcu_state.mutex);
>  	RCU_quiescbatch(cpu) = rcu_ctrlblk.completed;
>  	RCU_qs_pending(cpu) = 0;
> +#ifdef RCU_HUGE
> +	rcu_update_group(cpu);
> +#endif
>  	spin_unlock_bh(&rcu_state.mutex);
>  }
>  
> @@ -315,6 +445,9 @@
>  
>  static void __devinit rcu_online_cpu(int cpu)
>  {
> +#ifdef RCU_HUGE
> +	rcu_update_group(cpu);
> +#endif
>  	memset(&per_cpu(rcu_data, cpu), 0, sizeof(struct rcu_data));
>  	tasklet_init(&RCU_tasklet(cpu), rcu_process_callbacks, 0UL);
>  	INIT_LIST_HEAD(&RCU_nxtlist(cpu));
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
