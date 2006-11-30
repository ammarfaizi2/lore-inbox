Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757894AbWK3GfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757894AbWK3GfR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 01:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757841AbWK3GfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 01:35:12 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:14328 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1757857AbWK3GfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 01:35:08 -0500
Date: Thu, 30 Nov 2006 12:05:12 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: Gautham R Shenoy <ego@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, mingo@elte.hu, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, davej@redhat.com, dipankar@in.ibm.com,
       vatsa@in.ibm.com
Subject: Re: CPUFREQ-CPUHOTPLUG: Possible circular locking dependency
Message-ID: <20061130063512.GA19492@in.ibm.com>
Reply-To: ego@in.ibm.com
References: <20061129152404.GA7082@in.ibm.com> <20061129130556.d20c726e.akpm@osdl.org> <20061130042807.GA4855@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061130042807.GA4855@in.ibm.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2006 at 09:58:07AM +0530, Gautham R Shenoy wrote:
> 
> So can we ignore this circular-dep warning as a false positive?
> Or is there a way to exploit this circular dependency ?
> 
> At the moment, I cannot think of way to exploit this circular dependency
> unless we do something like try destroying the created workqueue when the
> cpu is dead, i.e make the cpufreq governors cpu-hotplug-aware.
> (eeks! that doesn't look good)

Ok, I see that we are already doing it :(. So we can end up in a
deadlock.

Here's the culprit callpath:

_cpu_down()
!
!-> raw_notifier_call_chain(CPU_LOCK_ACQUIRE)
!	!
!	!-> workqueue_cpu_mutex(CPU_LOCK_ACQUIRE) [*]
!
!-> raw_notifier_call_chain(CPU_DEAD)
	!
	!-> cpufreq_cpu_callback (CPU_DEAD)
		!
		!-> cpufreq_remove_dev
			!
			!-> __cpufreq_governor(data, GOVERNOR_STOP)
				!
				!-> policy->governor->governor()
					!
					!-> cpufreq_governor_dbs(GOVERNOR_STOP)
						!
						!-> destroy_workqueue() [*]

[*] indicates function takes workqueue_mutex.

So a deadlock!

I wasn't able to observe this because I'm running Xeon SMP box on which
you cannot offline cpu0. And cpufreq data is created only for cpu0,
while all other cpus cpufreq_data just point to cpu0's cpufreq_data.

So the mentioned callpath within  cpufreq_remove_dev is never reached
during the normal cpu offline cycle.

However, if there are architectures which allow the first-booted-cpu
(or to be precise, the cpu for which cpufreq_data is *actually* created) 
to be offlined and we are running Ondemand governor during the offline,
we will see this deadlock.

regards
gautham.
-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"
