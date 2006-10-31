Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161605AbWJaDuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161605AbWJaDuO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 22:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161606AbWJaDuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 22:50:14 -0500
Received: from server99.tchmachines.com ([72.9.230.178]:42684 "EHLO
	server99.tchmachines.com") by vger.kernel.org with ESMTP
	id S1161605AbWJaDuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 22:50:12 -0500
Date: Mon, 30 Oct 2006 19:51:40 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Christoph Lameter <clameter@engr.sgi.com>,
       Pekka J Enberg <penberg@cs.Helsinki.FI>, ego@in.ibm.com,
       "Benzi Galili (Benzi@ScaleMP.com)" <benzi@scalemp.com>,
       Alok Kataria <alok.kataria@calsoftinc.com>, shai@scalex86.org
Subject: Re: [rfc] [patch] mm: Slab - Eliminate lock_cpu_hotplug from slab
Message-ID: <20061031035140.GA3834@localhost.localdomain>
References: <20061028011919.GA4653@localhost.localdomain> <20061030102206.GA26669@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061030102206.GA26669@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server99.tchmachines.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2006 at 03:52:06PM +0530, Srivatsa Vaddagiri wrote:
> On Fri, Oct 27, 2006 at 06:19:19PM -0700, Ravikiran G Thirumalai wrote:
> > This patch also takes the cache_chain_sem at kmem_cache_shrink to
> > protect sanity of cpu_online_map at __cache_shrink, as viewed by slab.
> > (kmem_cache_shrink->__cache_shrink->drain_cpu_caches).  But, really,
> 
> drain_cpu_caches uses on_each_cpu() ..which does a preempt_disable()
> before using the cpu_online_map. That should be a safe enough access to the
> bitmap?

drain_cpu_caches has two call sites --  kmem_cache_destroy and
kmem_cache_shrink.  

kmem_cache_shrink:
>From what I can gather by looking at the cpu hotplug code, disabling 
preemption before iterating over cpu_online_map ensures that a
cpu won't disappear from the bitmask (system).  But it does not ensure that a
cpu won't come up right? (I see stop_machine usage in the cpu_down path, but
not in the cpu_up path). But then on closer look I see that on_each_cpu
uses call_lock to protect the cpu_online_map against cpu_online events.
So, yes we don't need to take the cache_chain_sem here.

kmem_cache_destroy:
We still need to stay serialized against cpu online here.  I guess
you already know why :)
http://lkml.org/lkml/2004/3/23/80

> > Another note.  Looks like a cpu hotplug event can send  CPU_UP_CANCELED to
> > a registered subsystem even if the subsystem did not receive CPU_UP_PREPARE.
> > This could be due to a subsystem registered for notification earlier than
> > the current subsystem crapping out with NOTIFY_BAD. Badness can occur with
> > in the CPU_UP_CANCELED code path at slab if this happens (The same would
> > apply for workqueue.c as well).  To overcome this, we might have to use either
> > a) a per subsystem flag and avoid handling of CPU_UP_CANCELED, or
> > b) Use a special notifier events like LOCK_ACQUIRE/RELEASE as Gautham was
> >    using in his experiments, or
> > c) Do not send CPU_UP_CANCELED to a subsystem which did not receive
> >    CPU_UP_PREPARE.
> > 
> > I would prefer c).
> 
> I think we need both b) and c).
> 
> Let me explain.
> 
> The need for c) is straightforward.
> 
> The need for b) comes from the fact that _cpu_down messes with the
> tsk->cpus_allowed mask (to possibly jump off the dying CPU). This would cause 
> sched_getaffinity() to potentially return a false value back to the user and 
> hence it was modified to take lock_cpu_hotplug() before reading 
> tsk->cpus_allowed.


Maybe I am missing something, but what prevents someone from reading the 
wrong tsk->cpus_allowed at (A) below?

static int _cpu_down(unsigned int cpu)
{
	...
	...
        set_cpus_allowed(current, tmp);
					----- (A)
        mutex_lock(&cpu_bitmask_lock);
        p = __stop_machine_run(take_cpu_down, NULL, cpu);
	...
}


> 
> If we are discarding this whole lock_cpu_hotplug(), then IMO, we should
> use LOCK_ACQUIRE/RELEASE, where ACQUIRE notification is sent *before*
> messing with tsk->cpus_allowed and RELEASE notification sent *after*
> restoring tsk->cpus_allowed (something like below):
> 
> @@ -186,13 +186,14 @@ int cpu_down(unsigned int cpu)
>  {
>         int err = 0;
> 
> -       mutex_lock(&cpu_add_remove_lock);
> +       blocking_notifier_call_chain(&cpu_chain, CPU_LOCK_ACQUIRE,
> +                                               (void *)(long)cpu);
>         if (cpu_hotplug_disabled)
>                 err = -EBUSY;
>         else
>                 err = _cpu_down(cpu);
> -
> -       mutex_unlock(&cpu_add_remove_lock);
> +       blocking_notifier_call_chain(&cpu_chain, CPU_LOCK_RELEASE,
> +                                               (void *)(long)cpu);
>         return err;
>  }
> 

But, since we send CPU_DOWN_PREPARE at _cpu_down before set_cpus_allowed(),
is it not possible to take the per scheduler subsystem lock at DOWN_PREPARE
and serialize sched_getaffinity with the same per scheduler subsys lock?

Thanks,
Kiran
