Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbWH1Ci3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbWH1Ci3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 22:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbWH1Ci3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 22:38:29 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:40656 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932317AbWH1Ci2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 22:38:28 -0400
Date: Mon, 28 Aug 2006 08:07:53 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ego@in.ibm.com, rusty@rustcorp.com.au, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, arjan@intel.linux.com, davej@redhat.com,
       mingo@elte.hu, dipankar@in.ibm.com, ashok.raj@intel.com
Subject: Re: [RFC][PATCH 0/4] Redesign cpu_hotplug locking.
Message-ID: <20060828023753.GA24777@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060824102618.GA2395@in.ibm.com> <20060824091704.cae2933c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824091704.cae2933c.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 09:17:04AM -0700, Andrew Morton wrote:
> > (ii) Though has been introduced recently in workqueue.c , it will only lead to
> > more deadlock scenarios since more locks would have to be acquired. 
> > 
> > Eg: workqueue + cpufreq(ondemand) ABBA deadlock scenario. Consider
> > - task1: echo ondemand > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
> > - task2: echo 0 > /sys/devices/system/cpu/cpu1/online
> > entering the system at the same time.
> > 
> > task1: calls store_scaling_governor which takes lock_cpu_hotplug.
> > 
> > task2: thru a blocking_notifier_call_chain(CPU_DOWN_PREPARE) 
> > to workqueue subsystem holds workqueue_mutex.
> > 
> > task1: calls create_workqueue from cpufreq_governor_dbs[ondemand] 
> > which tries taking workqueue_mutex but can't.
> > 
> > task2: thru blocking_notifier_call_chain(CPU_DOWN_PREPARE) calls
> > cpufreq_driver_target(cpufreq subsystem),which tries to take lock_cpu_hotplug
> > but cant since it is already taken by task1.
> > 
> > A typical ABBA deadlock!!!
> 
> That's a bug in cpufreq.  It should stop using lock_cpu_hotplug() and get
> its locking sorted out.

I don't think the deadlock scenario changes if cpufreq stops using
lock_cpu_hotplug() and starts using its own internal lock like
workqueue_mutex. This is unless the lock-heirarchy can be worked out in 
advance (i.e at compile time itself), which leads to the next question:

> > Replicating this persubsystem-cpu-hotplug lock model across all other
> > cpu_hotplug-sensitive subsystems would only create more such problems as 
> > notifier_callback does not follow any specific ordering while notifying 
> > the subsystems. 
> 
> The ordering is sufficiently well-defined: it's the order of the chain.  I
> don't expect there to be any problems here.

How is the "order" of the chain exposed? Moreover this needs to be
exposed at compile time itself so that people can code it correctly in
the first place! This cannot be done so easily unless we use priority
for notifiers (different priorities for different callbacks) or some
linking magic, which makes it somewhat ugly to maintain.

IMHO ensuring this heriarchy of locking order is maintained to avoid
deadlocks will be nightmarish. 

I would also feel more comfortable at another aspect of this single lock
- it will make both callback processing and cpu_online_map changes to be
atomic, though I can't think of specific example where having non-atomic 
callback processing hurts (*shrug*, just a safety feeling derived from 
experience of fixing many cpu hotplug bugs in the past).


-- 
Regards,
vatsa
