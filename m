Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030369AbWHXQSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030369AbWHXQSM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 12:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030373AbWHXQSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 12:18:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28871 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030369AbWHXQSK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 12:18:10 -0400
Date: Thu, 24 Aug 2006 09:17:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: ego@in.ibm.com
Cc: rusty@rustcorp.com.au, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       arjan@intel.linux.com, davej@redhat.com, mingo@elte.hu,
       vatsa@in.ibm.com, dipankar@in.ibm.com, ashok.raj@intel.com
Subject: Re: [RFC][PATCH 0/4] Redesign cpu_hotplug locking.
Message-Id: <20060824091704.cae2933c.akpm@osdl.org>
In-Reply-To: <20060824102618.GA2395@in.ibm.com>
References: <20060824102618.GA2395@in.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Aug 2006 15:56:18 +0530
Gautham R Shenoy <ego@in.ibm.com> wrote:

> While running some tests involving simultaneous cpu_hotplugging
> and changing of cpu_freq governors with 2.6.18-rc4-git1 kernel, 
> I hit the BUG_ON() in the cpufreq_p4_target(p4-clockmod.c).

cpufreq remains borked.

> The problem occured due to a race window opened up by the 2-lock scheme
> in cpu_down().

It was opened up by incorrect code in cpufreq.

> In future, we may face simillar scenarios where the subsystems are 
> maintaining the snapshot of the online cpus and the snapshot is updated only on a
> CPU_UP_PREPARE or a CPU_DEAD event, allowing other tasks to perform some *nasty* 
> operation between __stop_machine()_run and CPU_DEAD notification.

If those subsystems are buggy, sure.

> To solve this, I eliminated mutex_lock(&cpu_add_remove_lock) from both 
> cpu_down and cpu_up and moved mutex_lock(&cpu_bitmask_lock) in its place.
> The locks surrounding __stop_machin_run() and __cpu_up() were removed.
> This, however gave rise to new set of LUKEWARM IQ's emanating from 
> cpufreq_cpu_callback and cpufreq_stat_cpu_callback.

Better to eliminate lock_cpu_hotplug().

> The offending functions were (cpufreq_set_policy &cpufreq_driver_target) and 
> cpufreq_update_policy which were being called from cpufreq_cpu_callback and
> cpufreq_stat_cpu_callback respectively on CPU_ONLINE and CPU_DOWN_PREPARE
> events. These offenders call lock_cpu_hotplug ( YUCK!)
> 
> The possible solutions to cpu_hotplug "locking" summarized from the
> previous discussion threads are:
> 
> i) Clean up the whole code and ensure there are *NO* recursive lock takers.
> 
> ii) Have a per-subsystem cpu_hotplug_lock and let cpu_down(/up) acquire
> all these locks before performing a hotplug.
> 
> iii) Implement cpu_hotplug_lock as Refcount + Waitqueue.
> 
> (i) is ugly. We've seen Arjan give a try at cleaning up workqueue + ondemand
> mess.

Well yeah.

> (ii) Though has been introduced recently in workqueue.c , it will only lead to
> more deadlock scenarios since more locks would have to be acquired. 
> 
> Eg: workqueue + cpufreq(ondemand) ABBA deadlock scenario. Consider
> - task1: echo ondemand > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
> - task2: echo 0 > /sys/devices/system/cpu/cpu1/online
> entering the system at the same time.
> 
> task1: calls store_scaling_governor which takes lock_cpu_hotplug.
> 
> task2: thru a blocking_notifier_call_chain(CPU_DOWN_PREPARE) 
> to workqueue subsystem holds workqueue_mutex.
> 
> task1: calls create_workqueue from cpufreq_governor_dbs[ondemand] 
> which tries taking workqueue_mutex but can't.
> 
> task2: thru blocking_notifier_call_chain(CPU_DOWN_PREPARE) calls
> cpufreq_driver_target(cpufreq subsystem),which tries to take lock_cpu_hotplug
> but cant since it is already taken by task1.
> 
> A typical ABBA deadlock!!!

That's a bug in cpufreq.  It should stop using lock_cpu_hotplug() and get
its locking sorted out.

> Replicating this persubsystem-cpu-hotplug lock model across all other
> cpu_hotplug-sensitive subsystems would only create more such problems as 
> notifier_callback does not follow any specific ordering while notifying 
> the subsystems. 

The ordering is sufficiently well-defined: it's the order of the chain.  I
don't expect there to be any problems here.

Yes, the chain can change while a hotadd or hotremove is happening.  But
that's already a bug.  We need to take cpu_add_remove_lock in
[un]register_cpu_notifier().

> (iii) makes sense as it is closest to RWSEMs. 

argh.

box:/usr/src/linux-2.6.18-rc4> grep -r online . | grep cpu | wc -l
793

We're going to get into a mess if we try to fit all that stuff into using
some global unified locking scheme.

There might be scalability problems too.

There is a large amount of code in there which is presently racy against
cpu hotplug.  Once we have a scheme in place, those code sites need to be
reviewed and, if necessary, fixed.

> So here's an implementation on the lines of (c).
> 
> There are two types of tasks interested in cpu_hotplug
> - ones who want to *prevent* a hotplug event.
> - ones who want to *perform* a cpu hotplug.

Well.  There are tasks which wish to protect a per-cpu resource.  They
should do that by taking a per-resource lock.  As an optional,
cpu-hotplug-specific super-fast optimisation they can also do this by
running atomically.

Look, cpufreq locking is a mess.  I don't think we'll improve that by
adding new types of locks which hopefully work OK in the presence of
cpufreq's abuse.  Better to do the hard work, pick apart cpufreq, work out
specifically which per-cpu resources are being used, design a locking
scheme for each one, document it and then implement it.

For instance: why does the drivers/cpufreq/cpufreq.c:store_one() macro take
lock_cpu_hotplug()?  There are no per-cpu resources in sight!  It's quite
inappropriate.  The developers were (mis)led into doing this by the
seductive lock_kernel()iness of lock_cpu_hotplug().  Over the years we've
learnt to not do this sort of thing.  lock_cpu_hotplug() was a bad idea.

We already have sufficient locking primitives to get this right.  Let's fix
cpufreq locking rather than introduce complex new primitives which we hope
will work in the presence of the existing mess.

Step 1: remove all mention of lock_cpu_hotplug() from cpufreq.

Step 2: work out what data needs to be locked, and how.

Step 3: implement.

Let me re-re-re-re-emphasise: this is a cpufreq bug.  All of it.
