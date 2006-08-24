Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422657AbWHXUuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422657AbWHXUuV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 16:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422658AbWHXUuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 16:50:21 -0400
Received: from rune.pobox.com ([208.210.124.79]:41916 "EHLO rune.pobox.com")
	by vger.kernel.org with ESMTP id S1422657AbWHXUuT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 16:50:19 -0400
Date: Thu, 24 Aug 2006 15:50:12 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Paul Jackson <pj@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] cpuset: top_cpuset tracks hotplug changes to cpu_online_map
Message-ID: <20060824205012.GM11309@localdomain>
References: <20060824110049.5019.87063.sendpatchset@jackhammer.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824110049.5019.87063.sendpatchset@jackhammer.engr.sgi.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> From: Paul Jackson <pj@sgi.com>
> 
> Change the list of cpus allowed to tasks in the top (root)
> cpuset to dynamically track what cpus are online, using a CPU
> hotplug notifier.  Make this top cpus file read-only.
> 
> On systems that have cpusets configured in their kernel, but that
> aren't actively using cpusets (for some distros, this covers
> the majority of systems) all tasks end up in the top cpuset.
> 
> If that system does support CPU hotplug, then these tasks cannot
> make use of CPUs that are added after system boot, because the
> CPUs are not allowed in the top cpuset.  This is a surprising
> regression over earlier kernels that didn't have cpusets enabled.
> 
> In order to keep the behaviour of cpusets consistent between
> systems actively making use of them and systems not using them,
> this patch changes the behaviour of the 'cpus' file in the top
> (root) cpuset, making it read only, and making it automatically
> track the value of cpu_online_map.  Thus tasks in the top
> cpuset will have automatic use of hot plugged CPUs allowed by
> their cpuset.
> 
> Thanks to Anton Blanchard and Nathan Lynch for reporting this
> problem, driving the fix, and earlier versions of this patch.
> 
> Signed-off-by: Paul Jackson <pj@sgi.com>
> 
> ---
> 
> Anton or Nathan - can you test that this actually fixes
> the problem?  It should, but I don't have a hotplug
> enabled test rig available at the moment.  I've tested
> that it builds i386 and ia64, both with and without cpusets
> enabled, and boots and behaves ok on ia64 otherwise.  - pj


Thanks a lot Paul, this works fine with my testcase.



>  Documentation/cpusets.txt |    6 ++++++
>  kernel/cpuset.c           |   33 +++++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
> 
> --- 2.6.18-rc4-mm2.orig/kernel/cpuset.c	2006-08-23 23:03:23.082328581 -0700
> +++ 2.6.18-rc4-mm2/kernel/cpuset.c	2006-08-23 23:25:29.745783140 -0700
> @@ -815,6 +815,10 @@ static int update_cpumask(struct cpuset 
>  	struct cpuset trialcs;
>  	int retval, cpus_unchanged;
>  
> +	/* top_cpuset.cpus_allowed tracks cpu_online_map; it's read-only */
> +	if (cs == &top_cpuset)
> +		return -EACCES;
> +
>  	trialcs = *cs;
>  	retval = cpulist_parse(buf, trialcs.cpus_allowed);
>  	if (retval < 0)
> @@ -2032,6 +2036,33 @@ out:
>  	return err;
>  }
>  
> +/*
> + * The top_cpuset tracks what CPUs and Memory Nodes are online,
> + * period.  This is necessary in order to make cpusets transparent
> + * (of no affect) on systems that are actively using CPU hotplug
> + * but making no active use of cpusets.
> + *
> + * This handles CPU hotplug (cpuhp) events.  If someday Memory
> + * Nodes can be hotplugged (dynamically changing node_online_map)
> + * then we should handle that too, perhaps in a similar way.
> + */
> +
> +#ifdef CONFIG_HOTPLUG_CPU
> +static int cpuset_handle_cpuhp(struct notifier_block *nb,
> +				unsigned long phase, void *cpu)
> +{
> +	mutex_lock(&manage_mutex);
> +	mutex_lock(&callback_mutex);
> +
> +	top_cpuset.cpus_allowed = cpu_online_map;
> +
> +	mutex_unlock(&callback_mutex);
> +	mutex_unlock(&manage_mutex);
> +
> +	return 0;
> +}
> +#endif
> +
>  /**
>   * cpuset_init_smp - initialize cpus_allowed
>   *
> @@ -2042,6 +2073,8 @@ void __init cpuset_init_smp(void)
>  {
>  	top_cpuset.cpus_allowed = cpu_online_map;
>  	top_cpuset.mems_allowed = node_online_map;
> +
> +	hotcpu_notifier(cpuset_handle_cpuhp, 0);
>  }
>  
>  /**
> --- 2.6.18-rc4-mm2.orig/Documentation/cpusets.txt	2006-08-23 23:45:28.543688884 -0700
> +++ 2.6.18-rc4-mm2/Documentation/cpusets.txt	2006-08-23 23:45:46.515909967 -0700
> @@ -217,6 +217,12 @@ exclusive cpuset.  Also, the use of a Li
>  to represent the cpuset hierarchy provides for a familiar permission
>  and name space for cpusets, with a minimum of additional kernel code.
>  
> +The cpus file in the root (top_cpuset) cpuset is read-only.
> +It automatically tracks the value of cpu_online_map, using a CPU
> +hotplug notifier.  If and when memory nodes can be hotplugged,
> +we expect to make the mems file in the root cpuset read-only
> +as well, and have it track the value of node_online_map.
> +
>  
>  1.4 What are exclusive cpusets ?
>  --------------------------------
> 
> -- 
>                           I won't rest till it's the best ...
>                           Programmer, Linux Scalability
>                           Paul Jackson <pj@sgi.com> 1.650.933.1373
