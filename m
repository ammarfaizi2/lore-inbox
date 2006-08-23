Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965066AbWHWXuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965066AbWHWXuE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 19:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965189AbWHWXuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 19:50:04 -0400
Received: from rune.pobox.com ([208.210.124.79]:18304 "EHLO rune.pobox.com")
	by vger.kernel.org with ESMTP id S965066AbWHWXuD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 19:50:03 -0400
Date: Wed, 23 Aug 2006 18:49:53 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, anton@samba.org, simon.derr@bull.net,
       nathanl@austin.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: cpusets not cpu hotplug aware
Message-ID: <20060823234953.GH11309@localdomain>
References: <20060821132709.GB8499@krispykreme> <20060821104334.2faad899.pj@sgi.com> <20060821192133.GC8499@krispykreme> <20060821140148.435d15f3.pj@sgi.com> <20060821215120.244f1f6f.akpm@osdl.org> <20060822050401.GB11309@localdomain> <20060821221437.255808fa.pj@sgi.com> <20060823221114.GF11309@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060823221114.GF11309@localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Lynch wrote:
> Paul Jackson wrote:
> > 
> > If there is some decent way I can get the cpus_allowed of the top
> > cpuset to track the cpu_online_map, then we avoid this discontinuity
> > in system behaviour.
> 
> 
> How about this?  I've verified it fixes the issue but I'm nervous
> about the locking.
> 
> 
> --- cpuhp-sched_setaffinity.orig/kernel/cpuset.c
> +++ cpuhp-sched_setaffinity/kernel/cpuset.c
> @@ -2033,6 +2033,31 @@ out:
>  	return err;
>  }
>  
> +static int cpuset_handle_cpuhp(struct notifier_block *nb,
> +				unsigned long phase, void *_cpu)
> +{
> +	unsigned long cpu = (unsigned long)_cpu;
> +
> +	mutex_lock(&manage_mutex);
> +	lock_cpu_hotplug();
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
> +	unlock_cpu_hotplug();
> +	mutex_unlock(&manage_mutex);
> +
> +	return 0;
> +}

Actually the lock/unlock_cpu_hotplug aren't necessary,
cpu_add_remove_lock is already held in this context.


Update cpus_allowed in top_cpuset when cpus are hotplugged;
otherwise binding a task to a newly hotplugged cpu fails since the
toplevel cpuset has a static copy of whatever cpu_online_map was at
boot time.

Signed-off-by: Nathan Lynch <ntl@pobox.com>

--- cpuhp-sched_setaffinity.orig/kernel/cpuset.c
+++ cpuhp-sched_setaffinity/kernel/cpuset.c
@@ -2033,6 +2033,29 @@ out:
 	return err;
 }
 
+static int cpuset_handle_cpuhp(struct notifier_block *nb,
+				unsigned long phase, void *_cpu)
+{
+	unsigned long cpu = (unsigned long)_cpu;
+
+	mutex_lock(&manage_mutex);
+	mutex_lock(&callback_mutex);
+
+	switch (phase) {
+	case CPU_ONLINE:
+		cpu_set(cpu, top_cpuset.cpus_allowed);
+		break;
+	case CPU_DEAD:
+		cpu_clear(cpu, top_cpuset.cpus_allowed);
+		break;
+	}
+
+	mutex_unlock(&callback_mutex);
+	mutex_unlock(&manage_mutex);
+
+	return 0;
+}
+
 /**
  * cpuset_init_smp - initialize cpus_allowed
  *
@@ -2043,6 +2066,8 @@ void __init cpuset_init_smp(void)
 {
 	top_cpuset.cpus_allowed = cpu_online_map;
 	top_cpuset.mems_allowed = node_online_map;
+
+	hotcpu_notifier(cpuset_handle_cpuhp, 0);
 }
 
 /**
