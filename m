Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964885AbVL1TOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbVL1TOP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 14:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbVL1TOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 14:14:15 -0500
Received: from thorn.pobox.com ([208.210.124.75]:41600 "EHLO thorn.pobox.com")
	by vger.kernel.org with ESMTP id S964881AbVL1TOO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 14:14:14 -0500
Date: Wed, 28 Dec 2005 13:14:02 -0600
From: Nathan Lynch <ntl@pobox.com>
To: "Zhang, Yanmin" <yanmin.zhang@intel.com>
Cc: Yanmin Zhang <ymzhang@unix-os.sc.intel.com>, greg@kroah.com,
       linux-kernel@vger.kernel.org, discuss@x86-64.org,
       linux-ia64@vger.kernel.org,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Shah, Rajesh" <rajesh.shah@intel.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: [PATCH v2:3/3]Export cpu topology by sysfs
Message-ID: <20051228191402.GE12674@localhost.localdomain>
References: <8126E4F969BA254AB43EA03C59F44E84045301CF@pdsmsx404>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8126E4F969BA254AB43EA03C59F44E84045301CF@pdsmsx404>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >>What about sane default values for the *_id attributes?

> It depends on the specific architectures. On i386/x86_64, the
> default vaules of *_id are 0xffu. On ia64, the default value of
> physical_package_id is -1.

> >>For example,
> >>say I have a uniprocessor PC without HT or multicore -- should all of
> >>these attributes have zero values, or some kind of "special" value to
> >>mean "not applicable"?
>
> This feature is disabled when CONFIG_SMP=n.

Irrelevant.  Running SMP kernels on UP boxes is not uncommon.

The point I was trying to make is that these new attributes will show
up on systems where they don't provide useful information -- the UP
case aside, there are plenty of SMP systems which aren't multicore or
multithreaded.  We need to take care that the attributes don't provide
misleading information on such systems.

> I can't make decision that all arch should use the same default
> values, so let architectures to decide. Is it ok? 

Not really -- inevitably we'll wind up with an interface that has
slightly different semantics on each architecture.

> >>Hmm, why should thread_id be exported at all?  Is it useful to
> >>userspace in a way that the logical cpu id is not?
>
> Just to make it clearer. Of course, physical_package_id /core_id/
> logical cpu id could tell enough info like thread id. 

Then let's drop thread_id until there's a need for it.


> >>> +static int __cpuinit topology_remove_dev(struct sys_device * sys_dev)
> >>> +{
> >>> +	sysfs_remove_group(&sys_dev->kobj, &topology_attr_group);
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static int __cpuinit topology_cpu_callback(struct notifier_block *nfb,
> >>> +		unsigned long action, void *hcpu)
> >>> +{
> >>> +	unsigned int cpu = (unsigned long)hcpu;
> >>> +	struct sys_device *sys_dev;
> >>> +
> >>> +	sys_dev = get_cpu_sysdev(cpu);
> >>> +	switch (action) {
> >>> +		case CPU_ONLINE:
> >>> +			topology_add_dev(sys_dev);
> >>> +			break;
> >>> +		case CPU_DEAD:
> >>> +			topology_remove_dev(sys_dev);
> >>> +			break;
> >>> +	}
> >>> +	return NOTIFY_OK;
> >>> +}
> >>
> >>I don't think it makes much sense to add and remove the attribute
> >>group for cpu online/offline events.  The topology information for an
> >>offline cpu is potentially valuable -- it could help the admin decide
> >>which processor to online at runtime, for example.
> >>
> >>I believe the correct time to update the topology information is when
> >>the topology actually changes (e.g. physical addition or removal of a
> >>processor) -- this is independent of online/offline operations.
>
> Currently, on i386/x86_64/ia64, a cpu gets its own topology by
> itself and fills into a global array. If the cpu is offline since
> the machine is booted, we can't get its topology info.

Hmm, is this a limitation of those architectures?  On ppc64 (where
this feature would be applicable) Open Firmware provides such topology
information regardless of the cpus' states; does the firmware or ACPI
on these platforms not do the same?

> And when a cpu is offline, current kernel deletes it from the
> thread_siblings and core_siblings of other cpu. 

That's fine -- I'm just arguing against the addition/removal of the
attributes when cpus go online and offline.


> >>- This locks us into exporting a three-level topology (thread, core,
> >>  package), with hard-coded names, when it seems probable that there
> >>  will be systems with more levels than that in the future.
>

> It's easy to add more levels based on my implementations.
> Hard-coded names might be a problem. Is there any special
> requirement to change the names arch-specifically? If some
> architectures really need their specific names, I will change the
> names from hard-coded to arch-defined.

No, don't worry about it.  I withdraw that objection.

