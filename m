Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261912AbVFGPzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261912AbVFGPzQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 11:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbVFGPzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 11:55:16 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:44517 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261912AbVFGPyo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 11:54:44 -0400
Date: Tue, 7 Jun 2005 17:54:39 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.47-20
In-Reply-To: <20050607110409.GA14613@elte.hu>
Message-Id: <Pine.OSF.4.05.10506071638130.28240-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,
 This is an old problem of cpu_freq.c not compiling. I (re)send a fix for
it. This time as a real patch...

Esben

--- drivers/cpufreq/cpufreq.c.orig      2005-06-07 15:47:25.000000000 +0200
+++ drivers/cpufreq/cpufreq.c   2005-06-07 16:31:01.000000000 +0200
@@ -605,7 +605,8 @@
        policy->cpu = cpu;
        policy->cpus = cpumask_of_cpu(cpu);
 
-       init_MUTEX_LOCKED(&policy->lock);
+       init_MUTEX(&policy->lock);
+       down(&policy->lock);
        init_completion(&policy->kobj_unregister);
        INIT_WORK(&policy->update, handle_update, (void *)(long)cpu);


On Tue, 7 Jun 2005, Ingo Molnar wrote:

> 
> i have released the -V0.7.47-20 Real-Time Preemption patch, which can be 
> downloaded from the usual place:
> 
>     http://redhat.com/~mingo/realtime-preempt/
> 
> i've implemented two new features:
> 
>  - new debugging feature: CONFIG_DEBUG_RT_LOCKING_MODE, which
>    adds the /proc/sys/kernel/preempt_locks flag (default: 0). This way
>    the 'locking model' can be switched runtime - very useful for
>    debugging and profiling. Value 0 means that all spinlocks and rwlocks
>    are implemented via raw spinlocks/rwlocks. (which disable preemption,
>    increase latency, but improve throughput) Value 1 means the kernel 
>    will fully preempt all locks again. (NOTE: the only safe runtime 
>    switching of the locking model can be done while the system is idle, 
>    so i've implemented the flag via two flags where the idle thread 
>    propagates the new value from the user-flag to the kernel-flag. You 
>    should put a "sleep 1" into scripts that switch the locking mode, to 
>    guarantee that the new flag value is picked up.)
> 
>  - performance feature: i've implemented a new scheduler feature called 
>    'delayed preemption', which turns sync wakeups into guaranteed 
>    wakeups, while preserving their workload-batching properties. A 
>    delayed preemption request is implemented via the 
>    TIF_NEED_RESCHED_DELAYED flag, which runs in parallel to the 
>    "immediate preemption" TIF_NEED_RESCHED flag. If this works out fine 
>    then it will be a suitable replacement for the upstream sync-wakeups 
>    facility as well.
> 
> delayed preemption already improved the performance of 'hackbench' under 
> PREEMPT_RT quite signifiantly.
> 
> to build a -V0.7.47-20 tree, the following patches have to be applied:
> 
>    http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.11.tar.bz2
>    http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.12-rc6.bz2
>    http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.12-rc6-V0.7.47-20
> 
> 	Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

