Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbWCZCJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbWCZCJz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 21:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWCZCJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 21:09:55 -0500
Received: from smtp.osdl.org ([65.172.181.4]:61583 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751141AbWCZCJy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 21:09:54 -0500
Date: Sat, 25 Mar 2006 18:06:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: vatsa@in.ibm.com
Cc: nickpiggin@yahoo.com.au, mingo@elte.hu, suresh.b.siddha@intel.com,
       pj@sgi.com, hawkes@sgi.com, linux-kernel@vger.kernel.org,
       dino@in.ibm.com
Subject: Re: [PATCH 2.6.16-mm1 1/2] sched_domain: handle kmalloc failure
Message-Id: <20060325180605.6e5bb4b9.akpm@osdl.org>
In-Reply-To: <20060325082730.GA17011@in.ibm.com>
References: <20060325082730.GA17011@in.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:
>
> I think there is a bug in build_sched_domains() when kmalloc fails to
> allocate memory for 'sched_group_allnodes'. 
> 
> Consider the case where build_sched_domains() is being invoked because a
> CPUset is being made exclusive. Further lets say user changed cpu_exclusive 
> property of some CPUset as follow:
> 
> 	echo 1 > cpu_exclusive	# (Step a)
> 	echo 0 > cpu_exclusive	# (Step b)
> 	echo 1 > cpu_exclusive	# (Step c)
> 
> 
> Lets say that all memory allocations succeeded during the 1st attempt to
> make CPUset exclusive (Step a). Step a would result in the sched domain
> heirarchy being initialized for all CPUs in the CPUSet under
> consideration. Step b would cause those memory allocations to be freed
> up.
> 
> Now during Step c, lets say that kmalloc failed to allocate for
> 'sched_group_allnodes'. When that happens, the code just breaks out of
> the 'for' loop. I think that is wrong, as it would cause the previous
> assignments (made during Step a) to be retained. This could cause, among
> other things, sd->groups to be invalid (for allnodes_domains)?
> 
> Patch below (against 2.6.16-mm1) fixes it. I have done some minimal test
> of it.
> 

This is rather ugly, sorry.

> 
> 
>  kernel/sched.c |   10 +++++++---
>  1 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff -puN kernel/sched.c~sd_handle_error kernel/sched.c
> --- linux-2.6.16-mm1/kernel/sched.c~sd_handle_error	2006-03-25 11:39:07.000000000 +0530
> +++ linux-2.6.16-mm1-root/kernel/sched.c	2006-03-25 11:39:59.000000000 +0530
> @@ -5965,6 +5965,7 @@ void build_sched_domains(const cpumask_t
>  {
>  	int i;
>  #ifdef CONFIG_NUMA
> +	int alloc_failed = 0;
>  	struct sched_group **sched_group_nodes = NULL;
>  	struct sched_group *sched_group_allnodes = NULL;
>  
> @@ -5993,7 +5994,7 @@ void build_sched_domains(const cpumask_t
>  #ifdef CONFIG_NUMA
>  		if (cpus_weight(*cpu_map)
>  				> SD_NODES_PER_DOMAIN*cpus_weight(nodemask)) {
> -			if (!sched_group_allnodes) {
> +			if (!sched_group_allnodes && !alloc_failed) {
>  				sched_group_allnodes
>  					= kmalloc(sizeof(struct sched_group)
>  							* MAX_NUMNODES,
> @@ -6001,7 +6002,7 @@ void build_sched_domains(const cpumask_t
>  				if (!sched_group_allnodes) {
>  					printk(KERN_WARNING
>  					"Can not alloc allnodes sched group\n");
> -					break;
> +					alloc_failed = 1;
>  				}
>  				sched_group_allnodes_bycpu[i]
>  						= sched_group_allnodes;
> @@ -6010,7 +6011,10 @@ void build_sched_domains(const cpumask_t
>  			*sd = SD_ALLNODES_INIT;
>  			sd->span = *cpu_map;
>  			group = cpu_to_allnodes_group(i);
> -			sd->groups = &sched_group_allnodes[group];
> +			sd->groups = sched_group_allnodes ?
> +				 &sched_group_allnodes[group] : NULL;
> +			if (!sd->groups)
> +				sd->flags = 0;		/* No load balancing */
>  			p = sd;
>  		} else
>  			p = NULL;

So if the kmalloc failed we'll try to limp along without load balancing?

I think it would be better to free any thus-far allocated memory and to
fail the whole thing.

Returning void from build_sched_domains was wrong.

build_sched_domains() should be static and __cpuinit, btw.

