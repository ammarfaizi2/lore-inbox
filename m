Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935086AbWK3E2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935086AbWK3E2i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 23:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934251AbWK3E2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 23:28:38 -0500
Received: from ausmtp05.au.ibm.com ([202.81.18.154]:24983 "EHLO
	ausmtp05.au.ibm.com") by vger.kernel.org with ESMTP id S935086AbWK3E2G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 23:28:06 -0500
Date: Thu, 30 Nov 2006 09:58:07 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ego@in.ibm.com, mingo@elte.hu, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, davej@redhat.com, dipankar@in.ibm.com,
       vatsa@in.ibm.com
Subject: Re: CPUFREQ-CPUHOTPLUG: Possible circular locking dependency
Message-ID: <20061130042807.GA4855@in.ibm.com>
Reply-To: ego@in.ibm.com
References: <20061129152404.GA7082@in.ibm.com> <20061129130556.d20c726e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061129130556.d20c726e.akpm@osdl.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2006 at 01:05:56PM -0800, Andrew Morton wrote:
> On Wed, 29 Nov 2006 20:54:04 +0530
> Gautham R Shenoy <ego@in.ibm.com> wrote:
> 
> > Ok, so to cut the long story short,
> > - While changing governor from anything to
> > ondemand, locks are taken in the following order
> >
> > policy->lock ===> dbs_mutex ===> workqueue_mutex.

> >
> > - While offlining a cpu, locks are taken in the following order
> >
> > cpu_add_remove_lock ==> sched_hotcpu_mutex ==> workqueue_mutex ==
> > ==> cache_chain_mutex ==> policy->lock.
> 
> What functions are taking all these locks?  (ie: the callpath?)

While changing cpufreq governor to ondemand, the locks taken are:
--------------------------------------------------------------------------
lock		function		file
--------------------------------------------------------------------------
policy->lock	store_scaling_governor	drivers/cpufreq/cpufreq.c

dbs_mutex	cpufreq_governor_dbs	drivers/cpufreq/cpufreq_ondemand.c

workqueue_mutex	__create_workqueue	kernel/workqueue.c
--------------------------------------------------------------------------

The complete callpath would be

store_scaling_governor [*]
	|
__cpufreq_set_policy
	|
__cpufreq_governor(data, CPUFREQ_GOV_START)
	|
policy->governor->governor => cpufreq_governor_dbs(data, CPUFREQ_GOV_START) [*]
	|
create_workqueue #defined as __create_workqueue [*]
	
where [*] = locks taken.

While offlining a cpu, locks are taken in the following order:

--------------------------------------------------------------------------
lock			function		file
--------------------------------------------------------------------------
cpu_add_remove_lock	cpu_down		kernel/cpu.c

sched_hotcpu_mutex	migration_call		kernel/sched.c

workqueue_mutex		workqueue_cpu_callback	kernel/workqueue.c

cache_chain_mutex	cpuup_callback		mm/slab.c

policy->lock		cpufreq_driver_target	drivers/cpufreq/cpufreq.c
---------------------------------------------------------------------------

Please note that in the above,
- sched_hotcpu_mutex, workqueue_mutex, cache_chain_mutex are taken 
  while handling CPU_LOCK_ACQUIRE events in the respective subsystems'
  cpu_callback functions.

- policy->lock is taken while handling CPU_DOWN_PREPARE in 
  cpufreq_cpu_callback which calls cpufreq_driver_target.

It's perfectly clear that in the cpu offline callpath, cpufreq
does not have to do anything with the workqueue. 

So can we ignore this circular-dep warning as a false positive?
Or is there a way to exploit this circular dependency ?

At the moment, I cannot think of way to exploit this circular dependency
unless we do something like try destroying the created workqueue when the
cpu is dead, i.e make the cpufreq governors cpu-hotplug-aware.
(eeks! that doesn't look good)

I'm working on fixing this. Let me see if I can come up with something.

Thanks and Regards
gautham.
-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"
