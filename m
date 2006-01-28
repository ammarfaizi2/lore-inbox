Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422714AbWA0X60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422714AbWA0X60 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 18:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422712AbWA0X60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 18:58:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:11663 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422713AbWA0X6Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 18:58:25 -0500
Date: Fri, 27 Jan 2006 16:00:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: mingo@elte.hu, suresh.b.siddha@intel.com, nickpiggin@yahoo.com.au,
       ak@suse.de, linux-kernel@vger.kernel.org, rohit.seth@intel.com,
       asit.k.mallick@intel.com
Subject: Re: [Patch] sched: new sched domain for representing multi-core
Message-Id: <20060127160019.64caa6be.akpm@osdl.org>
In-Reply-To: <20060126195156.E19789@unix-os.sc.intel.com>
References: <20060126015132.A8521@unix-os.sc.intel.com>
	<20060127000854.GA16332@elte.hu>
	<20060126195156.E19789@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Siddha, Suresh B" <suresh.b.siddha@intel.com> wrote:
>
> Appended patch adds a new sched domain for representing multi-core with
> shared caches between cores. Consider a dual package system, each package
> containing two cores and with last level cache shared between cores with in a
> package. If there are two runnable processes, with this appended patch
> those two processes will be scheduled on different packages.
> 
> On such system, with this patch we have observed 8% perf improvement with 
> specJBB(2 warehouse) benchmark and 35% improvement with CFP2000 rate(with
> 2 users).
> 
> This new domain will come into play only on multi-core systems with shared
> caches. On other systems, this sched domain will be removed by
> domain degeneration code. This new domain can be also used for implementing
> power savings policy (see OLS 2005 CMP kernel scheduler paper for more
> details.. I will post another patch for power savings policy soon)
> 
> Most of the arch/* file changes are for cpu_coregroup_map() implementation.
> 
> Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
> Acked-by: Ingo Molnar <mingo@elte.hu>
> 

> +#ifdef CONFIG_SCHED_MC
> +#ifndef SD_MC_INIT
> +/* for now its same as SD_CPU_INIT.
> + * TBD: Tune Domain parameters!
> + */
> +#define SD_MC_INIT   SD_CPU_INIT
> +#endif
> +#endif
> +
>  #ifdef CONFIG_NUMA
>  #ifndef SD_NODE_INIT
>  #error Please define an appropriate SD_NODE_INIT in include/asm/topology.h!!!
> diff -pNru linux-2.6.16-rc1/kernel/sched.c linux-core/kernel/sched.c
> --- linux-2.6.16-rc1/kernel/sched.c	2006-01-16 23:44:47.000000000 -0800
> +++ linux-core/kernel/sched.c	2006-01-26 18:31:37.053182824 -0800
> @@ -5658,11 +5658,27 @@ static int cpu_to_cpu_group(int cpu)
>  }
>  #endif
>  
> +#ifdef CONFIG_SCHED_MC
> +static DEFINE_PER_CPU(struct sched_domain, core_domains);
> +static struct sched_group sched_group_core[NR_CPUS];
> +static int cpu_to_core_group(int cpu)
> +{
> +#ifdef	CONFIG_SCHED_SMT
> +	return first_cpu(cpu_sibling_map[cpu]);
> +#else
> +	return cpu;
> +#endif
> +}
> +#endif

ifdefs are getting a bit crazy here..  It'd be nice if we could revisit
this cometime with a view to cleaning them up a bit.

	#if defined(A) && defined(B)

beats

	#ifdef A
	#ifdef B
	...
	#endif
	#endif


>  static DEFINE_PER_CPU(struct sched_domain, phys_domains);
>  static struct sched_group sched_group_phys[NR_CPUS];
>  static int cpu_to_phys_group(int cpu)
>  {
> -#ifdef CONFIG_SCHED_SMT
> +#if defined(CONFIG_SCHED_MC)
> +	cpumask_t mask = cpu_coregroup_map(cpu);
> +	return first_cpu(mask);
> +#elif defined(CONFIG_SCHED_SMT)
>  	return first_cpu(cpu_sibling_map[cpu]);
>  #else

So here, CONFIG_SCHED_SMT only comes into effect if CONFIG_SCHED_MC=n.

>  	return cpu;
> @@ -5760,6 +5776,17 @@ void build_sched_domains(const cpumask_t
>  		sd->parent = p;
>  		sd->groups = &sched_group_phys[group];
>  
> +#ifdef CONFIG_SCHED_MC
> +		p = sd;
> +		sd = &per_cpu(core_domains, i);
> +		group = cpu_to_core_group(i);
> +		*sd = SD_MC_INIT;
> +		sd->span = cpu_coregroup_map(i);
> +		cpus_and(sd->span, sd->span, *cpu_map);
> +		sd->parent = p;
> +		sd->groups = &sched_group_core[group];
> +#endif
> +
>  #ifdef CONFIG_SCHED_SMT
>  		p = sd;
>  		sd = &per_cpu(cpu_domains, i);

But here, if CONFIG_CHED_MC=y and CONFIG_SCHED_SMT=y, SMT will win.

> @@ -5785,6 +5812,19 @@ void build_sched_domains(const cpumask_t
>  	}
>  #endif
>  
> +#ifdef CONFIG_SCHED_MC
> +	/* Set up CMP (core) groups */
> +	for_each_online_cpu(i) {
> +		cpumask_t this_core_map = cpu_coregroup_map(i);
> +		cpus_and(this_core_map, this_core_map, *cpu_map);
> +		if (i != first_cpu(this_core_map))
> +			continue;
> +		init_sched_build_groups(sched_group_core, this_core_map,
> +					&cpu_to_core_group);
> +	}
> +#endif

I think the for_each_online_cpu() is wrong.  The CPU hotplug CPU_UP
notifier is called _before_ the newly-upped CPU is marked in
cpu_online_map.  You'll see that the other code in build_sched_domains() is
using for_each_cpu_mask with the cpu mask which is soon to become
cpu_online_map.


> +
>  	/* Set up physical groups */
>  	for (i = 0; i < MAX_NUMNODES; i++) {
>  		cpumask_t nodemask = node_to_cpumask(i);
> @@ -5881,11 +5921,31 @@ void build_sched_domains(const cpumask_t
>  		power = SCHED_LOAD_SCALE;
>  		sd->groups->cpu_power = power;
>  #endif
> +#ifdef CONFIG_SCHED_MC
> +		sd = &per_cpu(core_domains, i);
> +		power = SCHED_LOAD_SCALE + (cpus_weight(sd->groups->cpumask)-1)
> +					    * SCHED_LOAD_SCALE / 10;
> +		sd->groups->cpu_power = power;
> + 
> +		sd = &per_cpu(phys_domains, i);
>  
> + 		/*
> + 		 * This has to be < 2 * SCHED_LOAD_SCALE
> + 		 * Lets keep it SCHED_LOAD_SCALE, so that
> + 		 * while calculating NUMA group's cpu_power
> + 		 * we can simply do
> + 		 *  numa_group->cpu_power += phys_group->cpu_power;
> + 		 *
> + 		 * See "only add power once for each physical pkg"
> + 		 * comment below
> + 		 */
> + 		sd->groups->cpu_power = SCHED_LOAD_SCALE;
> +#else

And in this case, if CONFIG_SCHED_MC=y and CONFIG_SCHED_SMT=y, SMT will
lose.


Perhaps we should just make SMT and MC disjoint in Kconfig.  Your call.

I'll duck the patch for now.
