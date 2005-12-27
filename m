Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbVL0VTs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbVL0VTs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 16:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbVL0VTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 16:19:48 -0500
Received: from thorn.pobox.com ([208.210.124.75]:50651 "EHLO thorn.pobox.com")
	by vger.kernel.org with ESMTP id S1751146AbVL0VTr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 16:19:47 -0500
Date: Tue, 27 Dec 2005 15:19:36 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Yanmin Zhang <ymzhang@unix-os.sc.intel.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, discuss@x86-64.org,
       linux-ia64@vger.kernel.org,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Shah, Rajesh" <rajesh.shah@intel.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       yanmin.zhang@intel.com
Subject: Re: [PATCH v2:3/3]Export cpu topology by sysfs
Message-ID: <20051227211934.GA12674@localhost.localdomain>
References: <8126E4F969BA254AB43EA03C59F44E84044DEE70@pdsmsx404> <20051227024140.A9081@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051227024140.A9081@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yanmin Zhang wrote:
> 
> Items (attributes) are similar to /proc/cpuinfo.
> 
> 1) /sys/devices/system/cpu/cpuX/topology/physical_package_id:
> represent the physical package id of  cpu X;
> 2) /sys/devices/system/cpu/cpuX/topology/core_id:
> represent the cpu core id to cpu X;
> 3) /sys/devices/system/cpu/cpuX/topology/thread_id:
> represent the cpu thread id  to cpu X;

So what is the format of the *_id attributes?  Looks like this is
determined by the architecture, which is okay, but it doesn't seem
explicit.

What about sane default values for the *_id attributes?  For example,
say I have a uniprocessor PC without HT or multicore -- should all of
these attributes have zero values, or some kind of "special" value to
mean "not applicable"?

Hmm, why should thread_id be exported at all?  Is it useful to
userspace in a way that the logical cpu id is not?

> 4) /sys/devices/system/cpu/cpuX/topology/thread_siblings:
> represent the thread siblings to cpu X in the same core;
> 5) /sys/devices/system/cpu/cpuX/topology/core_siblings:
> represent the thread siblings to cpu X in the same physical package;
> 
> If one architecture wants to support this feature, it just needs to
> implement 5 defines, typically in file include/asm-XXX/topology.h.
> The 5 defines are:
> #define topology_physical_package_id(cpu)
> #define topology_core_id(cpu)
> #define topology_thread_id(cpu)
> #define topology_thread_siblings(cpu)
> #define topology_core_siblings(cpu)
> 
> The type of siblings is cpumask_t.
> 
> If an attribute isn't defined on an architecture, it won't be
> exported.

Okay, but which combinations of attributes are valid?  E.g. I would
think that it's fine for an architecture to define topology_thread_id
and topology_thread_siblings without any of the others, correct?

Also I'd rather the architectures have the ability to define these as
functions instead of macros.

<snip>

> +/* Add/Remove cpu_topology interface for CPU device */
> +static int __cpuinit topology_add_dev(struct sys_device * sys_dev)
> +{
> +	sysfs_create_group(&sys_dev->kobj, &topology_attr_group);
> +	return 0;
> +}

Can't sysfs_create_group fail?

> +
> +static int __cpuinit topology_remove_dev(struct sys_device * sys_dev)
> +{
> +	sysfs_remove_group(&sys_dev->kobj, &topology_attr_group);
> +	return 0;
> +}
> +
> +static int __cpuinit topology_cpu_callback(struct notifier_block *nfb,
> +		unsigned long action, void *hcpu)
> +{
> +	unsigned int cpu = (unsigned long)hcpu;
> +	struct sys_device *sys_dev;
> +
> +	sys_dev = get_cpu_sysdev(cpu);
> +	switch (action) {
> +		case CPU_ONLINE:
> +			topology_add_dev(sys_dev);
> +			break;
> +		case CPU_DEAD:
> +			topology_remove_dev(sys_dev);
> +			break;
> +	}
> +	return NOTIFY_OK;
> +}

I don't think it makes much sense to add and remove the attribute
group for cpu online/offline events.  The topology information for an
offline cpu is potentially valuable -- it could help the admin decide
which processor to online at runtime, for example.

I believe the correct time to update the topology information is when
the topology actually changes (e.g. physical addition or removal of a
processor) -- this is independent of online/offline operations.

In general, I'm still a little uneasy with exporting the cpu topology
in this way.  I can see how the information would be useful, and right
now, Linux does not do a great job of exposing to userspace these
relationships between cpus.  So I see the need.  But the things about
this approach which I don't like are:

- Attributes which are not applicable to the running system will be
  exported anyway.  Discovery at runtime would be less confusing, I
  think.

- This locks us into exporting a three-level topology (thread, core,
  package), with hard-coded names, when it seems probable that there
  will be systems with more levels than that in the future.

Have you considered basing the exported topology on sched domains?


Nathan
