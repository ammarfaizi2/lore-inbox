Return-Path: <linux-kernel-owner+w=401wt.eu-S932756AbWLTAth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932756AbWLTAth (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 19:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932757AbWLTAtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 19:49:36 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:58361 "EHLO
	ms-smtp-04.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932756AbWLTAtf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 19:49:35 -0500
Subject: Re: [RFC] Patch: dynticks: idle load balancing
From: Steven Rostedt <rostedt@goodmis.org>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: mingo@elte.hu, nickpiggin@yahoo.com.au, vatsa@in.ibm.com, clameter@sgi.com,
       tglx@linutronix.de, arjan@linux.intel.com, linux-kernel@vger.kernel.org
In-Reply-To: <20061211155304.A31760@unix-os.sc.intel.com>
References: <20061211155304.A31760@unix-os.sc.intel.com>
Content-Type: text/plain
Date: Tue, 19 Dec 2006 19:49:03 -0500
Message-Id: <1166575743.17734.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-11 at 15:53 -0800, Siddha, Suresh B wrote:

> 
> Comments and review feedback welcome. Minimal testing done on couple of
> i386 platforms. Perf testing yet to be done.

Nice work!

> 
> thanks,
> suresh
> ---


> diff -pNru linux-2.6.19-mm1/include/linux/sched.h linux/include/linux/sched.h
> --- linux-2.6.19-mm1/include/linux/sched.h	2006-12-12 06:39:22.000000000 -0800
> +++ linux/include/linux/sched.h	2006-12-12 06:51:03.000000000 -0800
> @@ -195,6 +195,14 @@ extern void sched_init_smp(void);
>  extern void init_idle(struct task_struct *idle, int cpu);
>  
>  extern cpumask_t nohz_cpu_mask;
> +#ifdef CONFIG_SMP
> +extern int select_notick_load_balancer(int cpu);
> +#else
> +static inline int select_notick_load_balancer(int cpu)

Later on in the actual code, the parameter is named stop_tick, which
makes sense. You should change the name here too so it's not confusing
when looking later on at the code.

> +{
> +	return 0;
> +}
> +#endif

[...]

> +
> +/*
> + * This routine will try to nominate the ilb (idle load balancing)
> + * owner among the cpus whose ticks are stopped. ilb owner will do the idle
> + * load balancing on behalf of all those cpus. If all the cpus in the system
> + * go into this tickless mode, then there will be no ilb owner (as there is
> + * no need for one) and all the cpus will sleep till the next wakeup event
> + * arrives...
> + *
> + * For the ilb owner, tick is not stopped. And this tick will be used
> + * for idle load balancing. ilb owner will still be part of
> + * notick.cpu_mask..
> + *
> + * While stopping the tick, this cpu will become the ilb owner if there
> + * is no other owner. And will be the owner till that cpu becomes busy
> + * or if all cpus in the system stop their ticks at which point
> + * there is no need for ilb owner.
> + *
> + * When the ilb owner becomes busy, it nominates another owner, during the
> + * schedule()
> + */
> +int select_notick_load_balancer(int stop_tick)
> +{
> +	int cpu = smp_processor_id();
> +

[...]

> +#ifdef CONFIG_NO_HZ
> +	if (idle_cpu(local_cpu) && notick.load_balancer == local_cpu &&
> +	    !cpus_empty(cpus))
> +		goto restart;
> +#endif
>  }
>  #else
>  /*
> @@ -3562,6 +3669,21 @@ switch_tasks:
>  		++*switch_count;
>  
>  		prepare_task_switch(rq, next);
> +#if defined(CONFIG_HZ) && defined(CONFIG_SMP)

Ah! so this is where the CONFIG_NO_HZ mistake came in ;)


> +		if (prev == rq->idle && notick.load_balancer == -1) {
> +			/*
> +			 * simple selection for now: Nominate the first cpu in
> +			 * the notick list to be the next ilb owner.
> +			 *
> +			 * TBD: Traverse the sched domains and nominate
> +			 * the nearest cpu in the notick.cpu_mask.
> +			 */
> +			int ilb = first_cpu(notick.cpu_mask);
> +
> +			if (ilb != NR_CPUS)
> +				resched_cpu(ilb);
> +		}
> +#endif
>  		prev = context_switch(rq, prev, next);


-- Steve

