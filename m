Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262910AbUEBBjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262910AbUEBBjh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 21:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262914AbUEBBjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 21:39:37 -0400
Received: from cfcafw.sgi.com ([198.149.23.1]:18014 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262910AbUEBBj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 21:39:29 -0400
Date: Sat, 1 May 2004 20:38:46 -0500
From: Jack Steiner <steiner@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: RCU scaling on large systems
Message-ID: <20040502013846.GA31405@sgi.com>
References: <20040501120805.GA7767@sgi.com> <20040501211704.GY1445@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040501211704.GY1445@holomorphy.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 01, 2004 at 02:17:04PM -0700, William Lee Irwin III wrote:
> On Sat, May 01, 2004 at 07:08:05AM -0500, Jack Steiner wrote:
> > On a 512p idle 2.6.5 system, each cpu spends ~6% of the time in the kernel
> > RCU code. The time is spent contending for shared cache lines.
> 
> Would something like this help cacheline contention? This uses the
> per_cpu data areas to hold per-cpu booleans for needing switches.
> Untested/uncompiled.
> 
> The global lock is unfortunately still there.

It will be Monday before I can get time on the large system & do
additional experiments. I have 2 logs & both show the
contention is on the line "spin_lock(&rcu_ctrlblk.mutex);".  These traces
were from a heavy workload with processes on most cpus.

I want to repeat the "ls" experiment & see if it has the same hot spot.
The "ls" experiment has only 1 active cpu. The rest of the cpus are idle.

I'll post additional info on Monday (if possible).

I'll also try your patch. (Thanks for quick reply)



> 
> 
> -- wli
> 
> Index: wli-2.6.6-rc3-mm1/include/linux/rcupdate.h
> ===================================================================
> --- wli-2.6.6-rc3-mm1.orig/include/linux/rcupdate.h	2004-04-03 19:36:52.000000000 -0800
> +++ wli-2.6.6-rc3-mm1/include/linux/rcupdate.h	2004-05-01 14:15:09.000000000 -0700
> @@ -41,6 +41,9 @@
>  #include <linux/threads.h>
>  #include <linux/percpu.h>
>  #include <linux/cpumask.h>
> +#include <asm/atomic.h>
> +
> +#define RCU_CPU_SCATTER (NR_CPUS > 128)
>  
>  /**
>   * struct rcu_head - callback structure for use with RCU
> @@ -68,8 +71,10 @@
>  	spinlock_t	mutex;		/* Guard this struct                  */
>  	long		curbatch;	/* Current batch number.	      */
>  	long		maxbatch;	/* Max requested batch number.        */
> +#if !RCU_CPU_SCATTER
>  	cpumask_t	rcu_cpu_mask; 	/* CPUs that need to switch in order  */
>  					/* for current batch to proceed.      */
> +#endif
>  };
>  
>  /* Is batch a before batch b ? */
> @@ -96,6 +101,9 @@
>          long  	       	batch;           /* Batch # for current RCU batch */
>          struct list_head  nxtlist;
>          struct list_head  curlist;
> +#if RCU_CPU_SCATTER
> +	atomic_t	need_switch;
> +#endif
>  };
>  
>  DECLARE_PER_CPU(struct rcu_data, rcu_data);
> @@ -109,13 +117,39 @@
>  
>  #define RCU_QSCTR_INVALID	0
>  
> +#if RCU_CPU_SCATTER
> +#define rcu_need_switch(cpu)		(!!atomic_read(&per_cpu(rcu_data, cpu).need_switch))
> +#define rcu_clear_need_switch(cpu)	atomic_set(&per_cpu(rcu_data, cpu).need_switch, 0)
> +static inline int rcu_any_cpu_need_switch(void)
> +{
> +	int cpu;
> +	for_each_online_cpu(cpu) {
> +		if (rcu_need_switch(cpu))
> +			return 1;
> +	}
> +	return 0;
> +}
> +
> +static inline void rcu_set_need_switch_cpumask(cpumask_t cpumask)
> +{
> +	int cpu;
> +	for_each_cpu_mask(cpu, cpumask)
> +		atomic_set(&per_cpu(rcu_data, cpu).need_switch, 1);
> +}
> +#else
> +#define rcu_need_switch(cpu)		cpu_isset(cpu, rcu_ctrlblk.rcu_cpu_mask)
> +#define rcu_clear_need_switch(cpu)	cpu_clear(cpu, rcu_ctrlblk.rcu_cpu_mask)
> +#define rcu_any_cpu_need_switch()	(!cpus_empty(rcu_ctrlblk.rcu_cpu_mask))
> +#define rcu_set_need_switch_cpumask(x)	cpus_copy(rcu_ctrlblk.rcu_cpu_mask, x)
> +#endif
> +
>  static inline int rcu_pending(int cpu) 
>  {
>  	if ((!list_empty(&RCU_curlist(cpu)) &&
>  	     rcu_batch_before(RCU_batch(cpu), rcu_ctrlblk.curbatch)) ||
>  	    (list_empty(&RCU_curlist(cpu)) &&
>  			 !list_empty(&RCU_nxtlist(cpu))) ||
> -	    cpu_isset(cpu, rcu_ctrlblk.rcu_cpu_mask))
> +	    	rcu_need_switch(cpu))
>  		return 1;
>  	else
>  		return 0;
> Index: wli-2.6.6-rc3-mm1/kernel/rcupdate.c
> ===================================================================
> --- wli-2.6.6-rc3-mm1.orig/kernel/rcupdate.c	2004-04-30 15:05:53.000000000 -0700
> +++ wli-2.6.6-rc3-mm1/kernel/rcupdate.c	2004-05-01 13:47:05.000000000 -0700
> @@ -46,10 +46,19 @@
>  #include <linux/cpu.h>
>  
>  /* Definition for rcupdate control block. */
> -struct rcu_ctrlblk rcu_ctrlblk = 
> -	{ .mutex = SPIN_LOCK_UNLOCKED, .curbatch = 1, 
> -	  .maxbatch = 1, .rcu_cpu_mask = CPU_MASK_NONE };
> +struct rcu_ctrlblk rcu_ctrlblk = {
> +	.mutex = SPIN_LOCK_UNLOCKED,
> +	.curbatch = 1, 
> +	.maxbatch = 1,
> +#if !RCU_CPU_SCATTER
> +	.rcu_cpu_mask = CPU_MASK_NONE
> +#endif
> +};
> +#if RCU_CPU_SCATTER
> +DEFINE_PER_CPU(struct rcu_data, rcu_data) = { .need_switch = ATOMIC_INIT(0), };
> +#else
>  DEFINE_PER_CPU(struct rcu_data, rcu_data) = { 0L };
> +#endif
>  
>  /* Fake initialization required by compiler */
>  static DEFINE_PER_CPU(struct tasklet_struct, rcu_tasklet) = {NULL};
> @@ -109,13 +118,14 @@
>  		rcu_ctrlblk.maxbatch = newbatch;
>  	}
>  	if (rcu_batch_before(rcu_ctrlblk.maxbatch, rcu_ctrlblk.curbatch) ||
> -	    !cpus_empty(rcu_ctrlblk.rcu_cpu_mask)) {
> +	    !rcu_any_cpu_need_switch()) {
>  		return;
>  	}
>  	/* Can't change, since spin lock held. */
>  	active = idle_cpu_mask;
>  	cpus_complement(active);
> -	cpus_and(rcu_ctrlblk.rcu_cpu_mask, cpu_online_map, active);
> +	cpus_and(active, cpu_online_map, active);
> +	rcu_set_need_switch_cpumask(active);
>  }
>  
>  /*
> @@ -127,7 +137,7 @@
>  {
>  	int cpu = smp_processor_id();
>  
> -	if (!cpu_isset(cpu, rcu_ctrlblk.rcu_cpu_mask))
> +	if (!rcu_need_switch(cpu))
>  		return;
>  
>  	/* 
> @@ -143,12 +153,12 @@
>  		return;
>  
>  	spin_lock(&rcu_ctrlblk.mutex);
> -	if (!cpu_isset(cpu, rcu_ctrlblk.rcu_cpu_mask))
> +	if (!rcu_need_switch(cpu))
>  		goto out_unlock;
>  
> -	cpu_clear(cpu, rcu_ctrlblk.rcu_cpu_mask);
> +	rcu_clear_need_switch(cpu);
>  	RCU_last_qsctr(cpu) = RCU_QSCTR_INVALID;
> -	if (!cpus_empty(rcu_ctrlblk.rcu_cpu_mask))
> +	if (!rcu_any_cpu_need_switch())
>  		goto out_unlock;
>  
>  	rcu_ctrlblk.curbatch++;
> @@ -186,11 +196,11 @@
>  	 * it here
>  	 */
>  	spin_lock_irq(&rcu_ctrlblk.mutex);
> -	if (cpus_empty(rcu_ctrlblk.rcu_cpu_mask))
> +	if (!rcu_any_cpu_need_switch())
>  		goto unlock;
>  
> -	cpu_clear(cpu, rcu_ctrlblk.rcu_cpu_mask);
> -	if (cpus_empty(rcu_ctrlblk.rcu_cpu_mask)) {
> +	rcu_clear_need_switch(cpu);
> +	if (!rcu_any_cpu_need_switch()) {
>  		rcu_ctrlblk.curbatch++;
>  		/* We may avoid calling start batch if
>  		 * we are starting the batch only

-- 
Thanks

Jack Steiner (steiner@sgi.com)          651-683-5302
Principal Engineer                      SGI - Silicon Graphics, Inc.


