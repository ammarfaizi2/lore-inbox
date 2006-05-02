Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964781AbWEBUst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbWEBUst (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 16:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964876AbWEBUst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 16:48:49 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:11415 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S964781AbWEBUst
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 16:48:49 -0400
Date: Tue, 2 May 2006 13:48:53 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Dimitri Sivanich <sivanich@sgi.com>
Cc: Dipankar Sarma <dipankar@in.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, mason@suse.de,
       Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH 1/2] enable remote rcu callback processing
Message-ID: <20060502204853.GF1294@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060403203804.GA8178@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060403203804.GA8178@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2006 at 03:38:04PM -0500, Dimitri Sivanich wrote:
> I've noticed recent kernels have had some latency issues with
> file_free_rcu running from  __rcu_process_callbacks().
> kmem_cache_free() can run without preemption for 100's of usec
> on 1GHz machines, regardless of the setting of CONFIG_PREEMPT.
> 
> This results in some unpredictable periods of fairly long processor
> unavailability, such as when a thread is waiting to be woken by an
> interrupt handler on a 'now quiet' processor.
> 
> In addition to current long delays associated with file_free_rcu(), and
> any other rcu callback delays that may be lurking, future uses of rcu
> could result in similiar issues, so it seems a comprehensive approach is
> what is needed to remedy this.
> 
> The change I'm proposing solves this by having a set of processors
> process the donelists (function callbacks) of a configured set of
> processors from tasklet context.  The remote processor donelist callbacks
>  are processed in a round-robin fashion, one list per processor.  Since
> only donelist callback processing is affected, other rcu list and
> quiescent state processing is unaffected.
> 
> This patch does add donelist locking for configured processors, but the
> locking is passive (the processors doing the donelist processing try
> the lock and move on if unavailable), so contention is minimal.
> 
> Note that these patches only affect NUMA systems.  Code for Non-NUMA
> systems remains unchanged.
> 
> For this patch (1), configuration of processors for remote rcu
> callback processing is done at boot-time via the 'remotercu'
> parameter.  Patch 2 adds dynamic configuration.

Interesting approach!!!  Please accept my apologies for being slow
about getting to this, there have been a few distractions.  You get
three guesses, and the first two do not count.  ;-)

Some comments below.  Some nits, but a few places with serious
race conditions (or serious misunderstandings on my part of exactly
how this code works...).

							Thanx, Paul

> Signed-off-by: Dimitri Sivanich <sivanich@sgi.com>
> Signed-off-by: Christoph Lameter <clameter@sgi.com>
> 
> Index: linux/kernel/rcupdate.c
> ===================================================================
> --- linux.orig/kernel/rcupdate.c	2006-04-03 15:26:15.914125174 -0500
> +++ linux/kernel/rcupdate.c	2006-04-03 15:26:38.743863052 -0500
> @@ -68,6 +68,8 @@ DEFINE_PER_CPU(struct rcu_data, rcu_bh_d
>  
>  /* Fake initialization required by compiler */
>  static DEFINE_PER_CPU(struct tasklet_struct, rcu_tasklet) = {NULL};
> +/* Tasklet for processing rcu callbacks remotely */
> +static DEFINE_PER_CPU(struct tasklet_struct, rcu_remote_tasklet) = {NULL};
>  static int blimit = 10;
>  static int qhimark = 10000;
>  static int qlowmark = 100;
> @@ -106,6 +108,140 @@ static inline void force_quiescent_state
>  }
>  #endif
>  
> +#ifdef CONFIG_NUMA

Could you please use a different CONFIG variable?  Perhaps something
associated with the isolscpu capability, which seems to be somewhat
related to this?

There are a number of NUMA platforms that might not want this to be
unconditional.  I believe that you can use CONFIG magic to make it
be unconditional for the specific platforms you are interested in,
while making it optional for others.  (That said, I cannot count myself
a CONFIG expert...)

> +/*
> + * Variables and routines for remote rcu callback processing
> + *
> + * Remote callback processing allows specified (configured) cpus to have
> + * their list of rcu callbacks processed by other (non-configured) cpus,
> + * thus reducing the amount of overhead and latency seen by configured
> + * cpus.
> + *
> + * This is accomplished by having non-configured cpus process the donelist
> + * of the configured cpus from tasklet context.  The remote cpu donelists
> + * are processed in a round-robin fashion, one list per cpu.  Since only
> + * donelist processing is affected, other rcu list and quiescent state
> + * processing is unaffected.
> + *
> + * Configuration of cpus for remote rcu callback processing is done
> + * at boot-time via the remotercu parameter.
> + */
> +
> +/* cpus configured for remote callback processing, this rarely changes */
> +static cpumask_t __read_mostly cpu_remotercu_map = CPU_MASK_NONE;

Judging from the code below, this variable has bits set for those
CPUs that don't do their own RCU callback invocation.  When I first
read this, I thought that the mask was instead for CPUs that do the
RCU callback invocations on behalf of other CPUs.  How about something
like "CPUs configured not to do their own RCU callback invocations"?

> +
> +/* next cpu for which we need to do remote callback processing */
> +static int cpu_remotercu_next = -1;
> +
> +/* lock cpu_remotercu_next and changes to cpu_remotercu_map */
> +static spinlock_t cpu_remotercu_lock = SPIN_LOCK_UNLOCKED;
> +
> +/*
> + * Return a mask of online cpus configured for remote rcu processing.

The above comment confused me -- this macro assigns this mask to
its argument rather than returning it.  Perhaps "Set _m_ to a mask
of online CPUs configured for remote RCU processing"?  Yes, I am
a bit jetlagged, thus easily confused right now, but so will the
poor guy trying to do debugging at 3AM local time...

> + */
> +#define rcu_remote_cpus(_m_) \
> +	cpus_and((_m_), cpu_remotercu_map, cpu_online_map)
> +
> +/*
> + * Is this cpu configured for remote rcu callback processing?
> + */
> +static int rcu_callbacks_processed_remotely(int cpu) {
> +	cpumask_t mask;
> +
> +	rcu_remote_cpus(mask);
> +	return(cpu_isset(cpu, mask));
> +}
> +
> +/*
> + * Should this cpu be processing rcu callbacks for cpus configured as such?
> + */
> +static int rcu_process_remote(int cpu)
> +{
> +	cpumask_t mask;
> +
> +	rcu_remote_cpus(mask);
> +	/*
> +	 * If the system has some cpus configured for remote callbacks and
> +	 * this cpu is not one of those, then this cpu processes remote rcu
> +	 * callbacks.
> +	 */
> +	return (!(cpus_empty(mask) || cpu_isset(cpu, mask)));
> +}
> +
> +/*
> + * Get the next cpu on which to do remote rcu callback processing
> + * We simply round-robin across all cpus configured for remote callbacks.
> + */
> +static int rcu_next_remotercu(void)
> +{
> +	cpumask_t mask;
> +	unsigned long flags;
> +	int cpu;
> +
> +	rcu_remote_cpus(mask);
> +	if (unlikely(cpus_empty(mask)))

This is one reason for wanting this to be under something other than
CONFIG_NUMA.  If this capability has been specifically configured,
then the unlikely() above makes sense.  On the other hand, if this
code appears on all NUMA platforms, then it absolutely does not make
sense to have "unlikely()".

> +		return -1;
> +	spin_lock_irqsave(&cpu_remotercu_lock, flags);
> +	cpu_remotercu_next=next_cpu(cpu_remotercu_next, mask);
> +	if (cpu_remotercu_next >= NR_CPUS) {
> +		cpu_remotercu_next = first_cpu(mask);
> +	}
> +	cpu = cpu_remotercu_next;
> +	spin_unlock_irqrestore(&cpu_remotercu_lock, flags);
> +
> +	return cpu;
> +}
> +
> +/*
> + * Configure a cpu for remote rcu callback processing.
> + */
> +static int rcu_set_remote_rcu(int cpu) {
> +	unsigned long flags;
> +
> +	if (cpu < NR_CPUS) {
> +		spin_lock_irqsave(&cpu_remotercu_lock, flags);
> +		cpu_set(cpu, cpu_remotercu_map);
> +		spin_unlock_irqrestore(&cpu_remotercu_lock, flags);
> +		return 0;
> +	} else
> +		return 1;
> +}
> +
> +/*
> + * Configure a cpu for standard rcu callback processing.
> + */
> +static void rcu_clear_remote_rcu(int cpu) {
> +	unsigned long flags;
> +
> +	if (cpu < NR_CPUS) {
> +		spin_lock_irqsave(&cpu_remotercu_lock, flags);
> +		cpu_clear(cpu, cpu_remotercu_map);
> +		spin_unlock_irqrestore(&cpu_remotercu_lock, flags);
> +	}
> +}

I have to ask...  Why not an error return on this one, similar
to rcu_set_remote_rcu()?

> +/*
> + * Configure a set of cpus at boot time for remote rcu callback
> + * processing via the 'remotercu' parameter.
> + */
> +static int __init rcu_remotercu_cpu_setup(char *str)
> +{
> +	int cpus[NR_CPUS], i;
> +
> +	str = get_options(str, ARRAY_SIZE(cpus), cpus);
> +	cpus_clear(cpu_remotercu_map);
> +	for (i = 1; i <= cpus[0]; i++)
> +		rcu_set_remote_rcu(cpus[i]);
> +	cpu_remotercu_next = first_cpu(cpu_remotercu_map);
> +	return 1;
> +}

Why no error check in the above?  As I understand it, upon return
from get_options(), if *str is not the nul character, there was
a parse error.

> +__setup ("remotercu=", rcu_remotercu_cpu_setup);
> +#else
> +static int rcu_callbacks_processed_remotely(int cpu) { return 0; }
> +static int rcu_process_remote(int cpu) { return 0; }
> +static void rcu_clear_remote_rcu(int cpu) {}
> +#endif
>  /**
>   * call_rcu - Queue an RCU callback for invocation after a grace period.
>   * @head: structure to be used for queueing the RCU updates.
> @@ -129,10 +265,32 @@ void fastcall call_rcu(struct rcu_head *
>  	rdp = &__get_cpu_var(rcu_data);
>  	*rdp->nxttail = head;
>  	rdp->nxttail = &head->next;
> +
> +#ifdef CONFIG_NUMA
> +	if (unlikely(rcu_callbacks_processed_remotely(smp_processor_id()))) {
> +		long old, new;
> +
> +		/* Update qlen safely if configured for remote callbacks */
> +		do {
> +			old = rdp->qlen;
> +			new = old + 1;
> +		} while (cmpxchg(&rdp->qlen, old, new)!=old);

The above is another reason for this not to be default for all NUMA
platforms...

A lighter-weight approach would be to have a pair of integers, one for
the number of callbacks registered and another for the number processed.
This would eliminate the need for atomics.  Should be OK without memory
barriers as well.

> +		if (unlikely(rdp->qlen > qhimark)) {
> +			rdp->blimit = INT_MAX;
> +			force_quiescent_state(rdp, &rcu_ctrlblk);
> +		}
> +	} else {
> +		if (unlikely(++rdp->qlen > qhimark)) {
> +			rdp->blimit = INT_MAX;
> +			force_quiescent_state(rdp, &rcu_ctrlblk);
> +		}
> +	}

These two pieces of code should be combined.  If the pair-of-integers
approach can be used, then this falls out.  Otherwise, the "else"
clause needs "++rdp->qlen" and the rest of the "if" statement is
common code.

> +#else
>  	if (unlikely(++rdp->qlen > qhimark)) {
>  		rdp->blimit = INT_MAX;
>  		force_quiescent_state(rdp, &rcu_ctrlblk);
>  	}
> +#endif
>  	local_irq_restore(flags);
>  }
>  
> @@ -165,10 +323,31 @@ void fastcall call_rcu_bh(struct rcu_hea
>  	*rdp->nxttail = head;
>  	rdp->nxttail = &head->next;
>  
> +#ifdef CONFIG_NUMA
> +	if (unlikely(rcu_callbacks_processed_remotely(smp_processor_id()))) {
> +		long old, new;
> +
> +		/* Update qlen safely if configured for remote callbacks */
> +		do {
> +			old = rdp->qlen;
> +			new = old + 1;
> +		} while (cmpxchg(&rdp->qlen, old, new)!=old);

Same comments as for call_rcu() above.

> +		if (unlikely(rdp->qlen > qhimark)) {
> +			rdp->blimit = INT_MAX;
> +			force_quiescent_state(rdp, &rcu_ctrlblk);
> +		}
> +	} else {
> +		if (unlikely(++rdp->qlen > qhimark)) {
> +			rdp->blimit = INT_MAX;
> +			force_quiescent_state(rdp, &rcu_bh_ctrlblk);
> +		}
> +	}
> +#else
>  	if (unlikely(++rdp->qlen > qhimark)) {
>  		rdp->blimit = INT_MAX;
>  		force_quiescent_state(rdp, &rcu_bh_ctrlblk);
>  	}
> +#endif
>  
>  	local_irq_restore(flags);
>  }
> @@ -386,6 +565,8 @@ static void rcu_offline_cpu(int cpu)
>  	struct rcu_data *this_rdp = &get_cpu_var(rcu_data);
>  	struct rcu_data *this_bh_rdp = &get_cpu_var(rcu_bh_data);
>  
> +	rcu_clear_remote_rcu(cpu);
> +
>  	__rcu_offline_cpu(this_rdp, &rcu_ctrlblk,
>  					&per_cpu(rcu_data, cpu));
>  	__rcu_offline_cpu(this_bh_rdp, &rcu_bh_ctrlblk,
> @@ -393,6 +574,7 @@ static void rcu_offline_cpu(int cpu)
>  	put_cpu_var(rcu_data);
>  	put_cpu_var(rcu_bh_data);
>  	tasklet_kill_immediate(&per_cpu(rcu_tasklet, cpu), cpu);
> +	tasklet_kill_immediate(&per_cpu(rcu_remote_tasklet, cpu), cpu);
>  }
>  
>  #else
> @@ -409,9 +591,32 @@ static void rcu_offline_cpu(int cpu)
>  static void __rcu_process_callbacks(struct rcu_ctrlblk *rcp,
>  					struct rcu_data *rdp)
>  {
> +#ifdef CONFIG_NUMA
> +	int cpu = smp_processor_id();
> +
> +	if (rdp->curlist && !rcu_batch_before(rcp->completed, rdp->batch)) {
> +		/*
> +		 * If this cpu is configured for remote rcu callback
> +		 * processing, grab the lock to protect donelist from
> +		 * changes done by remote callback processing.
> +		 *
> +		 * Remote callback processing should only try this lock,
> +		 * then move on, so contention should be minimal.
> +		 */
> +		if (unlikely(rcu_callbacks_processed_remotely(cpu))) {
> +			spin_lock_irq(&rdp->rmlock);
> +			*rdp->donetail = rdp->curlist;
> +			rdp->donetail = rdp->curtail;
> +			spin_unlock_irq(&rdp->rmlock);
> +		} else {

What happens if we get here just when our bit is set in cpu_remotercu_map?
Seems like we could see a destructive race between this CPU manipulating
donetail and some other CPU trying to process our callbacks.  One way
to prevent this race would be to require that CPUs only set their own bits
in cpu_remotercu_map.  If you do take this approach, considerable commenting
will be needed...

> +			*rdp->donetail = rdp->curlist;
> +			rdp->donetail = rdp->curtail;
> +		}
> +#else
>  	if (rdp->curlist && !rcu_batch_before(rcp->completed, rdp->batch)) {
>  		*rdp->donetail = rdp->curlist;
>  		rdp->donetail = rdp->curtail;
> +#endif
>  		rdp->curlist = NULL;
>  		rdp->curtail = &rdp->curlist;
>  	}
> @@ -445,7 +650,7 @@ static void __rcu_process_callbacks(stru
>  	}
>  
>  	rcu_check_quiescent_state(rcp, rdp);
> -	if (rdp->donelist)
> +	if (!rcu_callbacks_processed_remotely(cpu) && rdp->donelist)
>  		rcu_do_batch(rdp);
>  }
>  
> @@ -455,6 +660,80 @@ static void rcu_process_callbacks(unsign
>  	__rcu_process_callbacks(&rcu_bh_ctrlblk, &__get_cpu_var(rcu_bh_data));
>  }
>  
> +#ifdef CONFIG_NUMA
> +/*
> + * Do callback processing for cpus marked as such.
> + *
> + * This will only be run on systems with cpus configured for remote
> + * callback processing, but only on cpus not configured as such.
> + *
> + * We process both regular and bh donelists for only one cpu at a
> + * time.
> + */
> +static void rcu_process_remote_callbacks(unsigned long unused)
> +{
> +	struct rcu_data *rdp, *rdp_bh;
> +	struct rcu_head * list = NULL;
> +	struct rcu_head * list_bh = NULL;
> +	int cpu;
> +	long old, new, cnt;
> +

Don't we need to acquire cpu_remotercu_lock at this point?  I don't
see how the manipulation of cpu_remotercu_map is safe otherwise.

> +	/* Get the cpu for which we will process the donelists */
> +	cpu = rcu_next_remotercu();
> +	if (unlikely(cpu == -1)) {
> +		return;
> +	}

Seems like we could release cpu_remotercu_lock here...

> +	/*
> +	 * We process whatever remote callbacks we can at this moment for
> +	 * this cpu.  If the list protection locks are held, we move on,
> +	 * as we don't want contention.
> +	 */
> +	rdp = &per_cpu(rcu_data, cpu);
> +	if (spin_trylock_irq(&rdp->rmlock)) {
> +		if ((list=xchg(&rdp->donelist, NULL))!=NULL)
> +			rdp->donetail = &rdp->donelist;
> +		spin_unlock_irq(&rdp->rmlock);
> +	}
> +
> +	rdp_bh = &per_cpu(rcu_bh_data, cpu);
> +	if (spin_trylock_irq(&rdp_bh->rmlock)) {
> +		if ((list_bh=xchg(&rdp_bh->donelist, NULL))!=NULL)
> +			rdp_bh->donetail = &rdp_bh->donelist;
> +		spin_unlock_irq(&rdp_bh->rmlock);
> +	}
> +
> +	/* Process the donelists */
> +	cnt=0;
> +	while (list) {
> +		list->func(list);
> +		list = list->next;
> +		cnt++;
> +	}
> +
> +	/* Safely update qlen without lock contention */
> +	if (cnt) do {
> +		old = rdp->qlen;
> +		new = old - cnt;
> +	} while (cmpxchg(&rdp->qlen, old, new)!=old);

Again, could eliminate the cmpxchg() by maintaining separate counts
for callbacks queued and invoked.

> +	cnt=0;
> +	while (list_bh) {
> +		list_bh->func(list_bh);
> +		list_bh = list_bh->next;
> +		cnt++;
> +	}
> +
> +	if (cnt) do {
> +		old = rdp_bh->qlen;
> +		new = old - cnt;
> +	} while (cmpxchg(&rdp_bh->qlen, old, new)!=old);
> +}
> +#else
> +static void rcu_process_remote_callbacks(unsigned long unused) {}
> +#endif
> +
>  static int __rcu_pending(struct rcu_ctrlblk *rcp, struct rcu_data *rdp)
>  {
>  	/* This cpu has pending rcu entries and the grace period
> @@ -481,6 +760,13 @@ static int __rcu_pending(struct rcu_ctrl
>  
>  int rcu_pending(int cpu)
>  {
> +	/*
> +	 * Schedule remote callback processing on this cpu only if
> +	 * there are cpus setup for remote callback processing, and
> +	 * this one is not.
> +	 */
> +	if (unlikely(rcu_process_remote(cpu)))
> +		tasklet_schedule(&per_cpu(rcu_remote_tasklet, cpu));

I am a little concerned about the above -- we don't even know that
any of the remote CPUs have any callbacks to process, but we are going
to invoke a tasklet, acquire a bunch of locks, etc., etc.

>  	return __rcu_pending(&rcu_ctrlblk, &per_cpu(rcu_data, cpu)) ||
>  		__rcu_pending(&rcu_bh_ctrlblk, &per_cpu(rcu_bh_data, cpu));
>  }
> @@ -518,6 +804,8 @@ static void __devinit rcu_online_cpu(int
>  	rcu_init_percpu_data(cpu, &rcu_ctrlblk, rdp);
>  	rcu_init_percpu_data(cpu, &rcu_bh_ctrlblk, bh_rdp);
>  	tasklet_init(&per_cpu(rcu_tasklet, cpu), rcu_process_callbacks, 0UL);
> +	tasklet_init(&per_cpu(rcu_remote_tasklet, cpu),
> +		rcu_process_remote_callbacks, 0UL);
>  }
>  
>  static int __devinit rcu_cpu_notify(struct notifier_block *self, 
> Index: linux/include/linux/rcupdate.h
> ===================================================================
> --- linux.orig/include/linux/rcupdate.h	2006-04-03 15:26:15.918124778 -0500
> +++ linux/include/linux/rcupdate.h	2006-04-03 15:26:38.743863052 -0500
> @@ -108,6 +108,7 @@ struct rcu_data {
>  	struct rcu_head barrier;
>  #ifdef CONFIG_SMP
>  	long		last_rs_qlen;	 /* qlen during the last resched */
> +	spinlock_t	rmlock;		 /* for use with remote callback */
>  #endif
>  };
>  
