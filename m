Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965239AbWHWWLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965239AbWHWWLY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 18:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965243AbWHWWLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 18:11:24 -0400
Received: from rune.pobox.com ([208.210.124.79]:57065 "EHLO rune.pobox.com")
	by vger.kernel.org with ESMTP id S965239AbWHWWLY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 18:11:24 -0400
Date: Wed, 23 Aug 2006 17:11:14 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, anton@samba.org, simon.derr@bull.net,
       nathanl@austin.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: cpusets not cpu hotplug aware
Message-ID: <20060823221114.GF11309@localdomain>
References: <20060821132709.GB8499@krispykreme> <20060821104334.2faad899.pj@sgi.com> <20060821192133.GC8499@krispykreme> <20060821140148.435d15f3.pj@sgi.com> <20060821215120.244f1f6f.akpm@osdl.org> <20060822050401.GB11309@localdomain> <20060821221437.255808fa.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060821221437.255808fa.pj@sgi.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Nathan wrote:
> > I think it would be more sensible for the default (i.e. user hasn't
> > explicitly configured any cpusets) behavior on a CONFIG_CPUSETS=y
> > kernel to match the behavior with a CONFIG_CPUSETS=n kernel. 
> 
> Basically, in this situation, that would mean that the code that
> masks a requested sched_setaffinity cpumask with the tasks
> cpuset_cpus_allowed():
> 
> 	cpus_allowed = cpuset_cpus_allowed(p);
> 	cpus_and(new_mask, new_mask, cpus_allowed);
> 
> would not be executed in the case of a kernel configured for cpusets,
> when running on a system that wasn't using cpusets.
> 
> That's quite doable, and for systems not actually using cpusets, makes
> good sense.
> 
> But it makes a bit of discontinuity in the system behaviour when
> someone starts using cpusets.  If someone makes a cpuset, then suddenly
> tasks in the top cpuset start seeing failed sched_setaffinity calls
> for any CPU that was brought online after system boot.
> 
> If there is some decent way I can get the cpus_allowed of the top
> cpuset to track the cpu_online_map, then we avoid this discontinuity
> in system behaviour.


How about this?  I've verified it fixes the issue but I'm nervous
about the locking.


--- cpuhp-sched_setaffinity.orig/kernel/cpuset.c
+++ cpuhp-sched_setaffinity/kernel/cpuset.c
@@ -2033,6 +2033,31 @@ out:
 	return err;
 }
 
+static int cpuset_handle_cpuhp(struct notifier_block *nb,
+				unsigned long phase, void *_cpu)
+{
+	unsigned long cpu = (unsigned long)_cpu;
+
+	mutex_lock(&manage_mutex);
+	lock_cpu_hotplug();
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
+	unlock_cpu_hotplug();
+	mutex_unlock(&manage_mutex);
+
+	return 0;
+}
+
 /**
  * cpuset_init_smp - initialize cpus_allowed
  *
@@ -2043,6 +2068,8 @@ void __init cpuset_init_smp(void)
 {
 	top_cpuset.cpus_allowed = cpu_online_map;
 	top_cpuset.mems_allowed = node_online_map;
+
+	hotcpu_notifier(cpuset_handle_cpuhp, 0);
 }
 
 /**
