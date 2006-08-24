Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965189AbWHXARE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965189AbWHXARE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 20:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965296AbWHXARD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 20:17:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3806 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965189AbWHXARB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 20:17:01 -0400
Date: Wed, 23 Aug 2006 17:12:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nathan Lynch <ntl@pobox.com>
Cc: Paul Jackson <pj@sgi.com>, anton@samba.org, simon.derr@bull.net,
       nathanl@austin.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: cpusets not cpu hotplug aware
Message-Id: <20060823171239.b1e85cec.akpm@osdl.org>
In-Reply-To: <20060823234953.GH11309@localdomain>
References: <20060821132709.GB8499@krispykreme>
	<20060821104334.2faad899.pj@sgi.com>
	<20060821192133.GC8499@krispykreme>
	<20060821140148.435d15f3.pj@sgi.com>
	<20060821215120.244f1f6f.akpm@osdl.org>
	<20060822050401.GB11309@localdomain>
	<20060821221437.255808fa.pj@sgi.com>
	<20060823221114.GF11309@localdomain>
	<20060823234953.GH11309@localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2006 18:49:53 -0500
Nathan Lynch <ntl@pobox.com> wrote:

> Update cpus_allowed in top_cpuset when cpus are hotplugged;
> otherwise binding a task to a newly hotplugged cpu fails since the
> toplevel cpuset has a static copy of whatever cpu_online_map was at
> boot time.
> 

I must say, that's a pretty simple patch.  It beats dealing with udev
developers ;)

> 
> --- cpuhp-sched_setaffinity.orig/kernel/cpuset.c
> +++ cpuhp-sched_setaffinity/kernel/cpuset.c
> @@ -2033,6 +2033,29 @@ out:
>  	return err;
>  }
>  
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

The above needs #ifdef CONFIG_HOTPLUG_CPU wrappers.

>  /**
>   * cpuset_init_smp - initialize cpus_allowed
>   *
> @@ -2043,6 +2066,8 @@ void __init cpuset_init_smp(void)
>  {
>  	top_cpuset.cpus_allowed = cpu_online_map;
>  	top_cpuset.mems_allowed = node_online_map;
> +
> +	hotcpu_notifier(cpuset_handle_cpuhp, 0);
>  }
>  
>  /**
