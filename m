Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934448AbWK3KYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934448AbWK3KYY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 05:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934524AbWK3KYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 05:24:24 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:4847 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP id S934448AbWK3KYX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 05:24:23 -0500
Date: Thu, 30 Nov 2006 15:54:10 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Gautham R Shenoy <ego@in.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, davej@redhat.com,
       dipankar@in.ibm.com, vatsa@in.ibm.com
Subject: Re: CPUFREQ-CPUHOTPLUG: Possible circular locking dependency
Message-ID: <20061130102410.GB23354@in.ibm.com>
Reply-To: ego@in.ibm.com
References: <20061129152404.GA7082@in.ibm.com> <20061130083144.GC29609@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061130083144.GC29609@elte.hu>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2006 at 09:31:44AM +0100, Ingo Molnar wrote:
> 
> * Gautham R Shenoy <ego@in.ibm.com> wrote:
> 
> > So do we
> > - Rethink the strategy of per-subsystem hotcpu-locks ?
> >
> >   OR
> >
> > - Think of a way to straighten out the super-convoluted cpufreq code ?
> 
> i'm still wondering what the conceptual source of this fundamental
> locking complexity in cpufreq (and hotplug) is - it is not intuitive to
> me at all. Could you try to explain that?

I can try :-)

IIRC, cpufreq was written before cpu-hotplug and thus, was never 
hotplug aware when it was first written.

Let me try and simplify this as far as I can.

a) cpufreq maintain's it's own cpumask in the variable 
policy->affected_cpus and says : If a frequency change is issued to
any one of the cpu's in the affected_cpus mask, you change frequency on 
all cpus in the mask.
So this needs to be consistent with cpu_online map and hence
cpu hotplug aware. Furthermore, we don't want cpus in this mask to go
down when we are trying to change frequencies on them. The function
which drives the frequency change in cpufreq-core is
cpufreq_driver_target and it needs cpu-hotplug protection.

b) This mask is changed when the cpu_hotplug core sends a
CPU_DEAD/CPU_ONLINE notification through the function
cpufreq_cpu_callback.

So it's a Read-Write situation, where cpufreq_driver_target()
is the read side and cpufreq_cpu_callback() is
the write side. 
So we would want a) and b) to be mutually exclusive.

c) Problem is when a just before a cpu is offlined, 
we want to put it at the lowest possible frequency.
So we send out a CPU_DOWN_PREPARE event handled by cpufreq_cpu_callback
which calls cpufreq_driver_target.

Classic case of calling down_read from a down_write context!

To solve this so many changes have taken place since 2.6.18-rcsomething.

i) Linus split cpu_control mutex in cpu.c to cpu_add_remove_lock and
cpu_bitmask_lock. While the former serializes cpu_hotplug attempts, the
latter actually provides cpu-hotplug protection.

ii) Arjan cleaned up cpufreq to eliminate all intra-cpufreq recursive
lock_cpu_hotplug calls.

iii) Andrew replaced lock_cpu_hotplug in workqueue code with
workqueue_mutex that solved the recursive hotplug problem between
ondemand governor and workqueue.

This is how it exists in 2.6.19.
Is it safe? Not really. 
The split locking still can hit a BUG_ON as described in the post
http://lkml.org/lkml/2006/8/24/89 because the split locking opens up a
window which allows cpufreq to try changing frequency on stale cpus.

Besides having so many subsystems depend on a global lock may not be 
such a good idea from the scalability perspective.

I did post a rcu-based scalable version of lock_cpu_hotplug but didn't
get much response.

Which is why we tried having per-subsystem hotplug locks where
each subsystem can define it's own mutex.

The readside will be something like
mutex_lock(&my_hotcpu_lock);

/* No hotplug can happen here */

mutex_unlock(&my_hotcpu_lock);

Define a callback function my_cpu_callback and handle events
CPU_LOCK_ACQUIRE and CPU_LOCK_RELEASE which would be sent out before
beginning a cpu hotplug and after the completion of a cpu hotplug
respectively.

my_cpu_callback( int event)
{
	switch(event) {
		case CPU_LOCK_ACQUIRE:
			mutex_lock(&my_hotcpu_mutex);
			break;

		/*
		 *	Cpu hotplug happens here.
		 *  	Handle any other pre/post hotplug events 
		 */

		case CPU_LOCK_RELEASE:
			mutex_unlock(&my_hotcpu_mutex);
	}		break;
}

This would work fine, if the interactions between the cpu-hotplug aware
code across subsystem is well ordered.

But the ondemand governor-workqueue interactions are causing the
circular dependency problem and in another case a recursive locking
problem. Sigh!

Hope this explaination helped :-)

> 	Ingo

regards
gautham.
-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"
