Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbWAPQz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbWAPQz1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 11:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWAPQz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 11:55:27 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:1976 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751113AbWAPQz0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 11:55:26 -0500
Date: Mon, 16 Jan 2006 08:54:41 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       dada1@cosmobay1.com
Subject: Re: [RFC][PATCH] RCU tuning for latency/OOM
Message-ID: <20060116165441.GA5683@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060106181148.GB6897@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060106181148.GB6897@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 11:41:49PM +0530, Dipankar Sarma wrote:
> As a follow-up of the previous discussion on latency issues and
> large RCU batches, I have made some experimental changes in
> the RCU batch tuning. I set the batch limit back to 10 (should really
> be larger, but perhaps audio folks can tell me what works well).
> for better latency, but if the queue length increases to
> a high watermark, the batch limit is increased so that
> pending RCUs are processed quickly. Also, we start sending
> resched interrupts to all cpus participating in RCU grace
> period once the queue length increases to a high watermark.
> I suspect that the default values of the tunables I used
> are not that good. But someone with a setup to test extreme
> cases can perhaps tell me what works best. I hope we can
> work something out that works well for most common workloads
> and doesn't fall over in extreme situations.
> 
> The patch below has been sanity tested (kernbench) on ppc64
> and x86_64. Not meant for inclusion yet, but feedback on
> latency and OOM testing would be greatly appreciated.

Looks good!  Some comments interspersed.  Also would be very good
to get some realtime workloads on it -- CCing Eric Dumazet, though
most of my mail to him gets intercepted by SpamCop.  :-/

						Thanx, Paul

> Thanks
> Dipankar
> 
> 
> This patch adds new tunables for RCU queue and finished batches.
> There are two types of controls - number of completed RCU updates
> invoked in a batch (blimit) and monitoring for high rate of
> incoming RCUs on a cpu (qhimark, qlowmark). By default,
> the per-cpu batch limit is set to a small value. If
> the input RCU rate exceeds the high watermark, we do two things -
> force quiescent state on all cpus and set the batch limit
> of the CPU to -1. Setting batch limit to -1 forces all
> finished RCUs to be processed in one shot. Once the incoming
> queued RCUs fall below the low watermark, the batch limit
> is set to the default.
> 
> Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>
> 
> 
>  include/linux/rcupdate.h |    4 ++-
>  kernel/rcupdate.c        |   49 +++++++++++++++++++++++++++++++++++------------
>  2 files changed, 40 insertions(+), 13 deletions(-)
> 
> diff -puN kernel/rcupdate.c~rcu-batch-tuning kernel/rcupdate.c
> --- linux-2.6.15-rc5-rcu/kernel/rcupdate.c~rcu-batch-tuning	2006-01-04 12:31:03.000000000 +0530
> +++ linux-2.6.15-rc5-rcu-dipankar/kernel/rcupdate.c	2006-01-06 22:41:46.000000000 +0530
> @@ -71,7 +71,10 @@ DEFINE_PER_CPU(struct rcu_data, rcu_bh_d
>  
>  /* Fake initialization required by compiler */
>  static DEFINE_PER_CPU(struct tasklet_struct, rcu_tasklet) = {NULL};
> -static int maxbatch = 10000;
> +static int blimit = 10;
> +static int qhimark = 10000;
> +static int qlowmark = 100;
> +static int rsinterval = 1000;

My kneejerk reaction is that rsinterval would normally need to be
about the same size as qhimark, but must defer to real-world experience.

>  #ifndef __HAVE_ARCH_CMPXCHG
>  /*
> @@ -86,6 +89,18 @@ spinlock_t __rcuref_hash[RCUREF_HASH_SIZ
>  };
>  #endif
>  
> +static inline void force_quiescent_state(struct rcu_data *rdp,
> +			struct rcu_state *rsp)
> +{
> +	int cpu;
> +	set_need_resched();
> +	if (unlikely(rdp->qlen - rdp->last_rs_qlen > rsinterval)) {
> +		rdp->last_rs_qlen = rdp->qlen;
> +		for_each_cpu_mask(cpu, rsp->cpumask)
> +			smp_send_reschedule(cpu);

This sends an unneeded IPI to the sending CPU as well -- perhaps check
for cpu==smp_processor_id()?

> +	}
> +}
> +
>  /**
>   * call_rcu - Queue an RCU callback for invocation after a grace period.
>   * @head: structure to be used for queueing the RCU updates.
> @@ -110,8 +125,10 @@ void fastcall call_rcu(struct rcu_head *
>  	*rdp->nxttail = head;
>  	rdp->nxttail = &head->next;
>  
> -	if (unlikely(++rdp->count > 10000))
> -		set_need_resched();
> +	if (unlikely(++rdp->qlen > qhimark)) {
> +		rdp->blimit = INT_MAX;

I believe I understand what you are doing here, entering a sort of 
"desperation mode" to avoid an OOM event.  But this means that the
softirq function can spend an arbitrary amount of time processing
callbacks.

So, I agree that you need to do this when in "desperation mode".
But shouldn't this be in response to OOM or something, rather than
the first response to hitting the high-water mark?

> +		force_quiescent_state(rdp, &rcu_state);
> +	}
>  
>  	local_irq_restore(flags);
>  }
> @@ -144,12 +161,12 @@ void fastcall call_rcu_bh(struct rcu_hea
>  	rdp = &__get_cpu_var(rcu_bh_data);
>  	*rdp->nxttail = head;
>  	rdp->nxttail = &head->next;
> -	rdp->count++;
> -/*
> - *  Should we directly call rcu_do_batch() here ?
> - *  if (unlikely(rdp->count > 10000))
> - *      rcu_do_batch(rdp);
> - */

I completely agree with the above deletion.  ;-)

> +
> +	if (unlikely(++rdp->qlen > qhimark)) {
> +		rdp->blimit = INT_MAX;
> +		force_quiescent_state(rdp, &rcu_bh_state);
> +	}
> +
>  	local_irq_restore(flags);
>  }
>  
> @@ -176,10 +193,12 @@ static void rcu_do_batch(struct rcu_data
>  		next = rdp->donelist = list->next;
>  		list->func(list);
>  		list = next;
> -		rdp->count--;
> -		if (++count >= maxbatch)
> +		rdp->qlen--;
> +		if (++count >= rdp->blimit)

Cute -- but doesn't this want to be something like:

		if (++count > rdp->blimit)

so that you go forever in the "rdp->blimit == INTMAX" case?  Or do you
really want to stop after 2^31 repetitions?  Hmmm...  I guess that it
is -really- hard to argue that this matters either way.  If you really
go through 2^31 repetitions, the system is really cranking memory through
RCU, so there is some question in my mind as to whether it is getting
any real work done anyway...

>  			break;
>  	}
> +	if (rdp->blimit == INT_MAX && rdp->qlen <= qlowmark)
> +		rdp->blimit = blimit;

Would it make sense to cap rdp->blimit to max(blimit,rdp->qlen)?

If it makes sense to increase blimit slowly, seems like it also
makes sense to decrease it slowly.  Not sure what the correct
algorithm is, though.

>  	if (!rdp->donelist)
>  		rdp->donetail = &rdp->donelist;
>  	else
> @@ -416,6 +435,9 @@ static void rcu_init_percpu_data(int cpu
>  	rdp->quiescbatch = rcp->completed;
>  	rdp->qs_pending = 0;
>  	rdp->cpu = cpu;
> +	rdp->qlen = 0;
> +	rdp->last_rs_qlen = 0;
> +	rdp->blimit = blimit;
>  }
>  
>  static void __devinit rcu_online_cpu(int cpu)
> @@ -509,7 +531,10 @@ void synchronize_kernel(void)
>  	synchronize_rcu();
>  }
>  
> -module_param(maxbatch, int, 0);
> +module_param(blimit, int, 0);
> +module_param(qhimark, int, 0);
> +module_param(qlowmark, int, 0);
> +module_param(rsinterval, int, 0);
>  EXPORT_SYMBOL_GPL(rcu_batches_completed);
>  EXPORT_SYMBOL(call_rcu);  /* WARNING: GPL-only in April 2006. */
>  EXPORT_SYMBOL(call_rcu_bh);  /* WARNING: GPL-only in April 2006. */
> diff -puN include/linux/rcupdate.h~rcu-batch-tuning include/linux/rcupdate.h
> --- linux-2.6.15-rc5-rcu/include/linux/rcupdate.h~rcu-batch-tuning	2006-01-05 17:07:51.000000000 +0530
> +++ linux-2.6.15-rc5-rcu-dipankar/include/linux/rcupdate.h	2006-01-05 17:51:00.000000000 +0530
> @@ -94,11 +94,13 @@ struct rcu_data {
>  	long  	       	batch;           /* Batch # for current RCU batch */
>  	struct rcu_head *nxtlist;
>  	struct rcu_head **nxttail;
> -	long            count; /* # of queued items */
> +	long            qlen; 	 	 /* # of queued callbacks */
> +	long		last_rs_qlen;	 /* qlen during the last resched */
>  	struct rcu_head *curlist;
>  	struct rcu_head **curtail;
>  	struct rcu_head *donelist;
>  	struct rcu_head **donetail;
> +	long		blimit;		 /* Upper limit on a processed batch */
>  	int cpu;
>  };
>  
> 
> _
> 
