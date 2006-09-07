Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751852AbWIGUgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751852AbWIGUgv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 16:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751858AbWIGUgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 16:36:51 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:54244 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751852AbWIGUgu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 16:36:50 -0400
Date: Thu, 7 Sep 2006 13:37:28 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Dipankar Sarma <dipankar@in.ibm.com>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>,
       Eric Dumazet <dada1@cosmosbay.com>,
       "David S. Miller" <davem@davemloft.net>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, josht@us.ibm.com
Subject: Re: [PATCH] simplify/improve rcu batch tuning
Message-ID: <20060907203727.GE1293@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060903163419.GA235@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060903163419.GA235@oleg>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 03, 2006 at 08:34:19PM +0400, Oleg Nesterov wrote:
> I have no idea how to test this patch. It passed rcutorture.ko,
> but the "improve" part of the subject is only my speculation, so
> please comment.

I definitely like the fact that it kills a config parameter!!!

Some thoughts for testing...

1.	Modify rcutorture.c to keep all the rcutorture kernel threads
	off of at least one CPU.  Run a CPU-bound user process on that
	CPU.  Compare the rate a which grace periods progress in
	the following three situations:

	a.	With your patch.

	b.	With stock kernel.

	c.	With the function disabled (e.g., use the
		not-CONFIG_SMP version of force_quiescent_state()).

	You would expect to see fast grace-period progress for (a) and
	(b), slow for (c).

2.	As above, but have another process generating lots of
	RCU callbacks, for example, by opening and closing lots
	of files, creating and deleting lots of files with long
	randomly selected names, thrashing the route cache, or
	whatever.

> This patch kills a hard-to-calculate 'rsinterval' boot parameter
> and per-cpu rcu_data.last_rs_qlen. Instead, it adds adds a flag
> rcu_ctrlblk.signaled, which records the fact that one of CPUs
> has sent a resched IPI since the last rcu_start_batch().
> 
> Roughly speaking, we need two rcu_start_batch()s in order to move
> callbacks from ->nxtlist to ->donelist. This means that when ->qlen
> exceeds qhimark and continues to grow, we should send a resched IPI,
> and then do it again after we gone through a quiescent state.
> 
> On the other hand, if it was already sent, we don't need to do
> it again when another CPU detects overflow of the queue.

And it does it exactly once for each set of quiescent states until
the qlen drops -- though it seems to on a call_rcu() being called
on at least one CPU for each stage of queuing.  This is a weakness,
but is no worse than the current behavior, so cannot complain too
much.

Some additional comments below, but this patch seems to me to be in all
ways a significant improvement over the current code, so acking as is.

Acked-by: Paul E. McKenney <paulmck@us.ibm.com>
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
> 
> --- 2.6.18-rc4/Documentation/kernel-parameters.txt~1_auto	2006-08-19 17:50:56.000000000 +0400
> +++ 2.6.18-rc4/Documentation/kernel-parameters.txt	2006-09-03 17:47:38.000000000 +0400
> @@ -1342,10 +1342,6 @@ running once the system is up.
>  	rcu.qlowmark=	[KNL,BOOT] Set threshold of queued
>  			RCU callbacks below which batch limiting is re-enabled.
>  
> -	rcu.rsinterval=	[KNL,BOOT,SMP] Set the number of additional
> -			RCU callbacks to queued before forcing reschedule
> -			on all cpus.
> -
>  	rdinit=		[KNL]
>  			Format: <full_path>
>  			Run specified binary instead of /init from the ramdisk,
> --- 2.6.18-rc4/include/linux/rcupdate.h~1_auto	2006-07-16 01:53:08.000000000 +0400
> +++ 2.6.18-rc4/include/linux/rcupdate.h	2006-09-03 18:00:59.000000000 +0400
> @@ -66,6 +66,8 @@ struct rcu_ctrlblk {
>  	long	completed;	/* Number of the last completed batch         */
>  	int	next_pending;	/* Is the next batch already waiting?         */
>  
> +	int	signaled;
> +
>  	spinlock_t	lock	____cacheline_internodealigned_in_smp;
>  	cpumask_t	cpumask; /* CPUs that need to switch in order    */
>  	                         /* for current batch to proceed.        */
> @@ -106,9 +108,6 @@ struct rcu_data {
>  	long		blimit;		 /* Upper limit on a processed batch */
>  	int cpu;
>  	struct rcu_head barrier;
> -#ifdef CONFIG_SMP
> -	long		last_rs_qlen;	 /* qlen during the last resched */
> -#endif
>  };
>  
>  DECLARE_PER_CPU(struct rcu_data, rcu_data);
> --- 2.6.18-rc4/kernel/rcupdate.c~1_auto	2006-08-19 17:50:56.000000000 +0400
> +++ 2.6.18-rc4/kernel/rcupdate.c	2006-09-03 18:01:23.000000000 +0400
> @@ -71,9 +71,6 @@ static DEFINE_PER_CPU(struct tasklet_str
>  static int blimit = 10;
>  static int qhimark = 10000;
>  static int qlowmark = 100;
> -#ifdef CONFIG_SMP
> -static int rsinterval = 1000;
> -#endif
>  
>  static atomic_t rcu_barrier_cpu_count;
>  static DEFINE_MUTEX(rcu_barrier_mutex);
> @@ -86,8 +83,8 @@ static void force_quiescent_state(struct
>  	int cpu;
>  	cpumask_t cpumask;
>  	set_need_resched();

Not that it makes a big difference, but why is the above
set_need_resched() not in the body of the following "if" statement?
It used to be important, because it could prevent additional IPIs in
the same grace period, but since the current code will only send one
IPI per grace period, it seems like it can safely be tucked under the
"if" statement.

> -	if (unlikely(rdp->qlen - rdp->last_rs_qlen > rsinterval)) {
> -		rdp->last_rs_qlen = rdp->qlen;
> +	if (unlikely(!rcp->signaled)) {
> +		rcp->signaled = 1;
>  		/*
>  		 * Don't send IPI to itself. With irqs disabled,
>  		 * rdp->cpu is the current cpu.
> @@ -297,6 +294,7 @@ static void rcu_start_batch(struct rcu_c
>  		smp_mb();
>  		cpus_andnot(rcp->cpumask, cpu_online_map, nohz_cpu_mask);
>  
> +		rcp->signaled = 0;

Would it make sense to invoke force_quiescent_state() here in the
case that rdp->qlen is still large?  The disadvantage is that qlen
still counts the number of callbacks that are already slated for
invocation.  Another approach would be to check rdp->qlen and
rcp->signaled in rcu_do_batch(), but only once rdp->donlist goes
NULL.

Thoughts?

>  	}
>  }
>  
> @@ -624,9 +622,6 @@ void synchronize_rcu(void)
>  module_param(blimit, int, 0);
>  module_param(qhimark, int, 0);
>  module_param(qlowmark, int, 0);
> -#ifdef CONFIG_SMP
> -module_param(rsinterval, int, 0);
> -#endif
>  EXPORT_SYMBOL_GPL(rcu_batches_completed);
>  EXPORT_SYMBOL_GPL(rcu_batches_completed_bh);
>  EXPORT_SYMBOL_GPL(call_rcu);
> 
