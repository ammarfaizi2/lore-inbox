Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbWAJA15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbWAJA15 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 19:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751795AbWAJA15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 19:27:57 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:48025 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751310AbWAJA14
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 19:27:56 -0500
Date: Mon, 9 Jan 2006 16:28:18 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 4/5] rcu: join rcu_ctrlblk and rcu_state
Message-ID: <20060110002818.GD15083@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <43C165CE.AF913697@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C165CE.AF913697@tv-sign.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2006 at 10:19:42PM +0300, Oleg Nesterov wrote:
> This patch moves rcu_state into the rcu_ctrlblk. I think there
> are no reasons why we should have 2 different variables to control
> rcu state. Every user of rcu_state has also "rcu_ctrlblk *rcp" in
> the parameter list.

This patch looks sane to me.  It passes a short one-hour rcutorture
on ppc64 and x86, firing up some overnight runs as well.

Dipankar, Manfred, any other concerns?  Cacheline alignment?  (Seems
to me this code is far enough from the fastpath that this should not
be a problem, but thought I should ask.)

							Thanx, Paul

Acked-by: Paul E. McKenney <paulmck@us.ibm.com>
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
> 
> --- 2.6.15/include/linux/rcupdate.h~4_JOIN	2006-01-08 21:36:07.000000000 +0300
> +++ 2.6.15/include/linux/rcupdate.h	2006-01-08 23:16:36.000000000 +0300
> @@ -65,6 +65,10 @@ struct rcu_ctrlblk {
>  	long	cur;		/* Current batch number.                      */
>  	long	completed;	/* Number of the last completed batch         */
>  	int	next_pending;	/* Is the next batch already waiting?         */
> +
> +	spinlock_t	lock	____cacheline_maxaligned_in_smp;
> +	cpumask_t	cpumask; /* CPUs that need to switch in order    */
> +	                         /* for current batch to proceed.        */
>  } ____cacheline_maxaligned_in_smp;
>  
>  /* Is batch a before batch b ? */
> --- 2.6.15/kernel/rcupdate.c~4_JOIN	2006-01-08 22:46:13.000000000 +0300
> +++ 2.6.15/kernel/rcupdate.c	2006-01-08 23:49:31.000000000 +0300
> @@ -49,22 +49,18 @@
>  #include <linux/cpu.h>
>  
>  /* Definition for rcupdate control block. */
> -struct rcu_ctrlblk rcu_ctrlblk = 
> -	{ .cur = -300, .completed = -300 };
> -struct rcu_ctrlblk rcu_bh_ctrlblk =
> -	{ .cur = -300, .completed = -300 };
> -
> -/* Bookkeeping of the progress of the grace period */
> -struct rcu_state {
> -	spinlock_t	lock; /* Guard this struct and writes to rcu_ctrlblk */
> -	cpumask_t	cpumask; /* CPUs that need to switch in order    */
> -	                              /* for current batch to proceed.        */
> +struct rcu_ctrlblk rcu_ctrlblk = {
> +	.cur = -300,
> +	.completed = -300,
> +	.lock = SPIN_LOCK_UNLOCKED,
> +	.cpumask = CPU_MASK_NONE,
> +};
> +struct rcu_ctrlblk rcu_bh_ctrlblk = {
> +	.cur = -300,
> +	.completed = -300,
> +	.lock = SPIN_LOCK_UNLOCKED,
> +	.cpumask = CPU_MASK_NONE,
>  };
> -
> -static struct rcu_state rcu_state ____cacheline_maxaligned_in_smp =
> -	  {.lock = SPIN_LOCK_UNLOCKED, .cpumask = CPU_MASK_NONE };
> -static struct rcu_state rcu_bh_state ____cacheline_maxaligned_in_smp =
> -	  {.lock = SPIN_LOCK_UNLOCKED, .cpumask = CPU_MASK_NONE };
>  
>  DEFINE_PER_CPU(struct rcu_data, rcu_data) = { 0L };
>  DEFINE_PER_CPU(struct rcu_data, rcu_bh_data) = { 0L };
> @@ -233,13 +229,13 @@ static void rcu_do_batch(struct rcu_data
>   *   This is done by rcu_start_batch. The start is not broadcasted to
>   *   all cpus, they must pick this up by comparing rcp->cur with
>   *   rdp->quiescbatch. All cpus are recorded  in the
> - *   rcu_state.cpumask bitmap.
> + *   rcu_ctrlblk.cpumask bitmap.
>   * - All cpus must go through a quiescent state.
>   *   Since the start of the grace period is not broadcasted, at least two
>   *   calls to rcu_check_quiescent_state are required:
>   *   The first call just notices that a new grace period is running. The
>   *   following calls check if there was a quiescent state since the beginning
> - *   of the grace period. If so, it updates rcu_state.cpumask. If
> + *   of the grace period. If so, it updates rcu_ctrlblk.cpumask. If
>   *   the bitmap is empty, then the grace period is completed.
>   *   rcu_check_quiescent_state calls rcu_start_batch(0) to start the next grace
>   *   period (if necessary).
> @@ -247,9 +243,9 @@ static void rcu_do_batch(struct rcu_data
>  /*
>   * Register a new batch of callbacks, and start it up if there is currently no
>   * active batch and the batch to be registered has not already occurred.
> - * Caller must hold rcu_state.lock.
> + * Caller must hold rcu_ctrlblk.lock.
>   */
> -static void rcu_start_batch(struct rcu_ctrlblk *rcp, struct rcu_state *rsp)
> +static void rcu_start_batch(struct rcu_ctrlblk *rcp)
>  {
>  	if (rcp->next_pending &&
>  			rcp->completed == rcp->cur) {
> @@ -264,11 +260,11 @@ static void rcu_start_batch(struct rcu_c
>  		/*
>  		 * Accessing nohz_cpu_mask before incrementing rcp->cur needs a
>  		 * Barrier  Otherwise it can cause tickless idle CPUs to be
> -		 * included in rsp->cpumask, which will extend graceperiods
> +		 * included in rcp->cpumask, which will extend graceperiods
>  		 * unnecessarily.
>  		 */
>  		smp_mb();
> -		cpus_andnot(rsp->cpumask, cpu_online_map, nohz_cpu_mask);
> +		cpus_andnot(rcp->cpumask, cpu_online_map, nohz_cpu_mask);
>  
>  	}
>  }
> @@ -278,13 +274,13 @@ static void rcu_start_batch(struct rcu_c
>   * Clear it from the cpu mask and complete the grace period if it was the last
>   * cpu. Start another grace period if someone has further entries pending
>   */
> -static void cpu_quiet(int cpu, struct rcu_ctrlblk *rcp, struct rcu_state *rsp)
> +static void cpu_quiet(int cpu, struct rcu_ctrlblk *rcp)
>  {
> -	cpu_clear(cpu, rsp->cpumask);
> -	if (cpus_empty(rsp->cpumask)) {
> +	cpu_clear(cpu, rcp->cpumask);
> +	if (cpus_empty(rcp->cpumask)) {
>  		/* batch completed ! */
>  		rcp->completed = rcp->cur;
> -		rcu_start_batch(rcp, rsp);
> +		rcu_start_batch(rcp);
>  	}
>  }
>  
> @@ -294,7 +290,7 @@ static void cpu_quiet(int cpu, struct rc
>   * quiescent cycle, then indicate that it has done so.
>   */
>  static void rcu_check_quiescent_state(struct rcu_ctrlblk *rcp,
> -			struct rcu_state *rsp, struct rcu_data *rdp)
> +					struct rcu_data *rdp)
>  {
>  	if (rdp->quiescbatch != rcp->cur) {
>  		/* start new grace period: */
> @@ -319,15 +315,15 @@ static void rcu_check_quiescent_state(st
>  		return;
>  	rdp->qs_pending = 0;
>  
> -	spin_lock(&rsp->lock);
> +	spin_lock(&rcp->lock);
>  	/*
>  	 * rdp->quiescbatch/rcp->cur and the cpu bitmap can come out of sync
>  	 * during cpu startup. Ignore the quiescent state.
>  	 */
>  	if (likely(rdp->quiescbatch == rcp->cur))
> -		cpu_quiet(rdp->cpu, rcp, rsp);
> +		cpu_quiet(rdp->cpu, rcp);
>  
> -	spin_unlock(&rsp->lock);
> +	spin_unlock(&rcp->lock);
>  }
>  
>  
> @@ -348,16 +344,16 @@ static void rcu_move_batch(struct rcu_da
>  }
>  
>  static void __rcu_offline_cpu(struct rcu_data *this_rdp,
> -	struct rcu_ctrlblk *rcp, struct rcu_state *rsp, struct rcu_data *rdp)
> +				struct rcu_ctrlblk *rcp, struct rcu_data *rdp)
>  {
>  	/* if the cpu going offline owns the grace period
>  	 * we can block indefinitely waiting for it, so flush
>  	 * it here
>  	 */
> -	spin_lock_bh(&rsp->lock);
> +	spin_lock_bh(&rcp->lock);
>  	if (rcp->cur != rcp->completed)
> -		cpu_quiet(rdp->cpu, rcp, rsp);
> -	spin_unlock_bh(&rsp->lock);
> +		cpu_quiet(rdp->cpu, rcp);
> +	spin_unlock_bh(&rcp->lock);
>  	rcu_move_batch(this_rdp, rdp->curlist, rdp->curtail);
>  	rcu_move_batch(this_rdp, rdp->nxtlist, rdp->nxttail);
>  
> @@ -367,9 +363,9 @@ static void rcu_offline_cpu(int cpu)
>  	struct rcu_data *this_rdp = &get_cpu_var(rcu_data);
>  	struct rcu_data *this_bh_rdp = &get_cpu_var(rcu_bh_data);
>  
> -	__rcu_offline_cpu(this_rdp, &rcu_ctrlblk, &rcu_state,
> +	__rcu_offline_cpu(this_rdp, &rcu_ctrlblk,
>  					&per_cpu(rcu_data, cpu));
> -	__rcu_offline_cpu(this_bh_rdp, &rcu_bh_ctrlblk, &rcu_bh_state,
> +	__rcu_offline_cpu(this_bh_rdp, &rcu_bh_ctrlblk,
>  					&per_cpu(rcu_bh_data, cpu));
>  	put_cpu_var(rcu_data);
>  	put_cpu_var(rcu_bh_data);
> @@ -388,7 +384,7 @@ static void rcu_offline_cpu(int cpu)
>   * This does the RCU processing work from tasklet context. 
>   */
>  static void __rcu_process_callbacks(struct rcu_ctrlblk *rcp,
> -			struct rcu_state *rsp, struct rcu_data *rdp)
> +					struct rcu_data *rdp)
>  {
>  	if (rdp->curlist && !rcu_batch_before(rcp->completed, rdp->batch)) {
>  		*rdp->donetail = rdp->curlist;
> @@ -418,25 +414,23 @@ static void __rcu_process_callbacks(stru
>  
>  		if (!rcp->next_pending) {
>  			/* and start it/schedule start if it's a new batch */
> -			spin_lock(&rsp->lock);
> +			spin_lock(&rcp->lock);
>  			rcp->next_pending = 1;
> -			rcu_start_batch(rcp, rsp);
> -			spin_unlock(&rsp->lock);
> +			rcu_start_batch(rcp);
> +			spin_unlock(&rcp->lock);
>  		}
>  	} else {
>  		local_irq_enable();
>  	}
> -	rcu_check_quiescent_state(rcp, rsp, rdp);
> +	rcu_check_quiescent_state(rcp, rdp);
>  	if (rdp->donelist)
>  		rcu_do_batch(rdp);
>  }
>  
>  static void rcu_process_callbacks(unsigned long unused)
>  {
> -	__rcu_process_callbacks(&rcu_ctrlblk, &rcu_state,
> -				&__get_cpu_var(rcu_data));
> -	__rcu_process_callbacks(&rcu_bh_ctrlblk, &rcu_bh_state,
> -				&__get_cpu_var(rcu_bh_data));
> +	__rcu_process_callbacks(&rcu_ctrlblk, &__get_cpu_var(rcu_data));
> +	__rcu_process_callbacks(&rcu_bh_ctrlblk, &__get_cpu_var(rcu_bh_data));
>  }
>  
>  static int __rcu_pending(struct rcu_ctrlblk *rcp, struct rcu_data *rdp)
> 
