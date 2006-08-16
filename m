Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWHPR60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWHPR60 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 13:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWHPR60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 13:58:26 -0400
Received: from mga06.intel.com ([134.134.136.21]:23183 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S932168AbWHPR6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 13:58:25 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,133,1154934000"; 
   d="scan'208"; a="109554338:sNHT68018790"
Date: Wed, 16 Aug 2006 10:45:51 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Paul Jackson <pj@sgi.com>, akpm@osdl.org
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au, mingo@redhat.com,
       apw@shadowen.org
Subject: Re: [patch] sched: group CPU power setup cleanup
Message-ID: <20060816104551.A7305@unix-os.sc.intel.com>
References: <20060815175525.A2333@unix-os.sc.intel.com> <20060815212455.c9fe1e34.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060815212455.c9fe1e34.pj@sgi.com>; from pj@sgi.com on Tue, Aug 15, 2006 at 09:24:55PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2006 at 09:24:55PM -0700, Paul Jackson wrote:
> That is, you had:
> 
> 
>   transient text
> 
>   --
> 
>   permanent changelog text (just the above 2 lines)
> 
>   Signed-off-by: ...
> 
>   diff ...
> 
> 
> Andrew's recommendations would instead have:
> 
> 
>   permanent changelog text (more than 2 lines, I hope,
>   in this case)
> 
>   Signed-off-by: ...
> 
>   ---
> 
>   transient text
> 
>   diff ...

Andrew, is it possible for changing your tpp format such that transient
text comes on the top followed by the change log and signed-off-by...
Transient text will have more info about the patch in the context of
an ongoing lkml thread conversation. Hence it makes sense to be on top rather
than somewhere in between the changelog and the patch.

I will def add more appropriate changelog text..

> > ... Typically cpu_power for all the groups in a
> > + * sched domain will be same unless there are asymmetries in the topology.
> 
> Does the above mean that all groups in a domain have the same
> number of CPUs?

typically yes. cpuhotplug or exclusive cpusets can change it..

> 
> 
> +static void init_sched_groups_power(int cpu, struct sched_domain *sd)
> +{
> +	...
> +
> +	if (cpu != first_cpu(sd->groups->cpumask))
> +		return;
> 
> I am a tad surprised that the above always works.  Is it ever possible
> that init_sched_groups_power() is never called for the first cpu in a
> group, and that hence the cpu_power of that group is not uninitialized?

No. This is not possible. 

> If there is some explanation as to how this is not possible, and it is
> guaranteed that init_sched_groups_power() is always called for the
> first cpu in a group, then that might be worthy of a comment.

init_sched_groups_power is called for each cpu in the cpu_map and hence for
all the cpus in a group.

> 
> Is it possible to get the partition1 or partition2 in the calls:
> 
>     int partition_sched_domains(cpumask_t *partition1, cpumask_t *partition2)
>     {
> 	    ...
> 	    if (!cpus_empty(*partition1))
> 		    err = build_sched_domains(partition1);
> 	    if (!err && !cpus_empty(*partition2))
> 		    err = build_sched_domains(partition2);
> 
> so some group had some CPUs, but not the first CPU of groups->cpumask
> in one of these partitions?

Question doesn't make sense... each domain has it own specific groups..

> +	/*
> +	 * For perf policy, if the groups in child domain share resources
> +	 * (for example cores sharing some portions of the cache hierarchy
> +	 * or SMT), then set this domain groups cpu_power such that each group
> +	 * can handle only one task, when there are other idle groups in the
> +	 * same sched domain.
> +	 */
> 
> I am clearly still missing proper understanding here.  How is it that
> the cpu_power of a group can be set so that it "can handle only one task?"

Please see the find_busiest_group() code and how its uses cpu_power.
For example if a group has two tasks and if its cpu_power is
1 * SCHED_LOAD_SCALE, then any other idle group in the domain will pickup
the extra task. I have explained the significance of the 'multiple' in the
comments.

> 
> 
> > +	if (!child || (!(sd->flags & SD_POWERSAVINGS_BALANCE) &&
> > +		       (child->flags & SD_SHARE_CPUPOWER ||
> > +			child->flags & SD_SHARE_PKG_RESOURCES))) {
> 
> Would this be equivalent to the following, which saves a few
> machine instructions and a conditional jump as well:
> 
> 	if (!child || (!(sd->flags & SD_POWERSAVINGS_BALANCE) &&
> 		       (child->flags &
> 				(SD_SHARE_CPUPOWER | SD_SHARE_PKG_RESOURCES)
> 			)) {

compiler will be doing it. Anyhow I will include this change, as it is cleaner.

thanks,
suresh
