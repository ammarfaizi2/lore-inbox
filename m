Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbWAIFK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbWAIFK0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 00:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWAIFK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 00:10:26 -0500
Received: from thorn.pobox.com ([208.210.124.75]:57286 "EHLO thorn.pobox.com")
	by vger.kernel.org with ESMTP id S1751257AbWAIFKZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 00:10:25 -0500
Date: Sun, 8 Jan 2006 23:10:07 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Yanmin Zhang <ymzhang@unix-os.sc.intel.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, discuss@x86-64.org,
       linux-ia64@vger.kernel.org,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Shah, Rajesh" <rajesh.shah@intel.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: [PATCH v3]Export cpu topology by sysfs
Message-ID: <20060109051006.GC2683@localhost.localdomain>
References: <8126E4F969BA254AB43EA03C59F44E84045838F8@pdsmsx404> <20060104010658.A16342@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060104010658.A16342@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(sorry for the delay in response)

Yanmin Zhang wrote:
> Here is version 3. Based on Nathan's comments, the main changes are:
> 1) Drop thread id, so the first 2 patches of version 2 are dropped;

Thanks.

> 2) Set consistent default values for the 4 attributes.
> 

<snip>

> If one architecture wants to support this feature, it just needs to
> implement 4 defines, typically in file include/asm-XXX/topology.h.
> The 4 defines are:
> #define topology_physical_package_id(cpu)
> #define topology_core_id(cpu)
> #define topology_thread_siblings(cpu)
> #define topology_core_siblings(cpu)
> 
> The type of **_id is int.
> The type of siblings is cpumask_t.
> 
> To be consistent on all architectures, the 4 attributes should have
> deafult values if their values are unavailable. Below is the rule.
> 1) physical_package_id: If cpu has no physical package id, -1 is the
> default value.
> 2) core_id: If cpu doesn't support multi-core, its core id is 0.

Why not -1 as with the physical package id?  0 could be a valid core
id.

> 3) thread_siblings: Just include itself, if the cpu doesn't support
> HT/multi-thread.
> 4) core_siblings: Just include itself, if the cpu doesn't support
> multi-core and HT/Multi-thread.

Really, I think the least confusing interface would not export those
attributes which are not relevant for the system.  E.g. if the system
isn't multi-core, you don't see core_id and core_siblings attributes.

Failing that, let's at least have consistent, unambiguous values for
the ids which are not applicable.

<snip>
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

I still oppose this bit.  I want the attributes there for powerpc even
for offline cpus -- the topology information (if obtainable, which it
is on powerpc) is useful regardless of the cpu's online state.  The
attributes should appear when a cpu is made present, and go away when
a cpu is removed.

This week I'll try to do an implementation for powerpc.
