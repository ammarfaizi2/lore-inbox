Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030219AbWHXCy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030219AbWHXCy2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 22:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030221AbWHXCy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 22:54:28 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:61108 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030219AbWHXCy1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 22:54:27 -0400
Date: Wed, 23 Aug 2006 19:54:15 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ntl@pobox.com, anton@samba.org, simon.derr@bull.net,
       nathanl@austin.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: cpusets not cpu hotplug aware
Message-Id: <20060823195415.1762371a.pj@sgi.com>
In-Reply-To: <20060823171239.b1e85cec.akpm@osdl.org>
References: <20060821132709.GB8499@krispykreme>
	<20060821104334.2faad899.pj@sgi.com>
	<20060821192133.GC8499@krispykreme>
	<20060821140148.435d15f3.pj@sgi.com>
	<20060821215120.244f1f6f.akpm@osdl.org>
	<20060822050401.GB11309@localdomain>
	<20060821221437.255808fa.pj@sgi.com>
	<20060823221114.GF11309@localdomain>
	<20060823234953.GH11309@localdomain>
	<20060823171239.b1e85cec.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon,

  Take note below of my proposal to make the 'cpus' and 'mems'
  of the top cpuset read-only.  Holler if that hurts.

Nathan wrote:
> +static int cpuset_handle_cpuhp(struct notifier_block *nb,
> +				unsigned long phase, void *_cpu)
> +{
> +	unsigned long cpu = (unsigned long)_cpu;
> +
> +	mutex_lock(&manage_mutex);
> +	mutex_lock(&callback_mutex);
> +
> +	switch (phase) {
> +	case CPU_ONLINE:
> +		cpu_set(cpu, top_cpuset.cpus_allowed);
> +		break;
> +	case CPU_DEAD:
> +		cpu_clear(cpu, top_cpuset.cpus_allowed);
> +		break;
> +	}
> +
> +	mutex_unlock(&callback_mutex);
> +	mutex_unlock(&manage_mutex);
> +
> +	return 0;
> +}
> +

Andrew commented:
> I must say, that's a pretty simple patch. 

Not simple enough ;).

How about (uncompiled, untested, unanything):

=================================================================
/*
 * The top_cpuset tracks what CPUs and Memory Nodes are online,
 * period.  This is necessary in order to make cpusets transparent
 * (of no affect) on systems that are actively using CPU hotplug
 * but making no active use of cpusets.
 *
 * This handles CPU hotplug (cpuhp) events.  If someday Memory
 * Nodes can be hotplugged (dynamically changing node_online_map)
 * then we should handle that too, perhaps in a similar way.
 */

#ifdef CONFIG_HOTPLUG_CPU
static int cpuset_handle_cpuhp(struct notifier_block *nb,
				unsigned long phase, void *cpu)
{
	mutex_lock(&manage_mutex);
	mutex_lock(&callback_mutex);

	top_cpuset.cpus_allowed = cpu_online_map;

	mutex_unlock(&callback_mutex);
	mutex_unlock(&manage_mutex);

	return 0;
}
#endif

... plus the hotcpu_notifier() initializer.
=================================================================

However I get to spend the few lines of code I saved here elsewhere,
adding special case code so that the top_cpuset's 'cpus' and 'mems'
files are read-only.

The new rule is simple:

  The top cpuset's cpus and mems track what is online.

The user is no longer in direct control of these two cpuset settings.

And I should add a few lines to Documentation/cpusets.txt, describing
this.

When I return from my son's 18-th birthday party this evening, I will
see what I can whip up.

Thanks, Nathan.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
