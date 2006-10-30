Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161206AbWJ3KRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161206AbWJ3KRI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 05:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161207AbWJ3KRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 05:17:08 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:23695 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161206AbWJ3KRF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 05:17:05 -0500
Date: Mon, 30 Oct 2006 15:52:06 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Christoph Lameter <clameter@engr.sgi.com>,
       Pekka J Enberg <penberg@cs.Helsinki.FI>, ego@in.ibm.com,
       "Benzi Galili (Benzi@ScaleMP.com)" <benzi@scalemp.com>,
       Alok Kataria <alok.kataria@calsoftinc.com>, shai@scalex86.org
Subject: Re: [rfc] [patch] mm: Slab - Eliminate lock_cpu_hotplug from slab
Message-ID: <20061030102206.GA26669@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20061028011919.GA4653@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061028011919.GA4653@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2006 at 06:19:19PM -0700, Ravikiran G Thirumalai wrote:
> This patch also takes the cache_chain_sem at kmem_cache_shrink to
> protect sanity of cpu_online_map at __cache_shrink, as viewed by slab.
> (kmem_cache_shrink->__cache_shrink->drain_cpu_caches).  But, really,

drain_cpu_caches uses on_each_cpu() ..which does a preempt_disable()
before using the cpu_online_map. That should be a safe enough access to the
bitmap?

> kmem_cache_shrink is used at just one place in the acpi subsystem!
> Do we really need to keep kmem_cache_shrink at all?
> 
> Another note.  Looks like a cpu hotplug event can send  CPU_UP_CANCELED to
> a registered subsystem even if the subsystem did not receive CPU_UP_PREPARE.
> This could be due to a subsystem registered for notification earlier than
> the current subsystem crapping out with NOTIFY_BAD. Badness can occur with
> in the CPU_UP_CANCELED code path at slab if this happens (The same would
> apply for workqueue.c as well).  To overcome this, we might have to use either
> a) a per subsystem flag and avoid handling of CPU_UP_CANCELED, or
> b) Use a special notifier events like LOCK_ACQUIRE/RELEASE as Gautham was
>    using in his experiments, or
> c) Do not send CPU_UP_CANCELED to a subsystem which did not receive
>    CPU_UP_PREPARE.
> 
> I would prefer c).

I think we need both b) and c).

Let me explain.

The need for c) is straightforward.

The need for b) comes from the fact that _cpu_down messes with the
tsk->cpus_allowed mask (to possibly jump off the dying CPU). This would cause 
sched_getaffinity() to potentially return a false value back to the user and 
hence it was modified to take lock_cpu_hotplug() before reading 
tsk->cpus_allowed.

If we are discarding this whole lock_cpu_hotplug(), then IMO, we should
use LOCK_ACQUIRE/RELEASE, where ACQUIRE notification is sent *before*
messing with tsk->cpus_allowed and RELEASE notification sent *after*
restoring tsk->cpus_allowed (something like below):

@@ -186,13 +186,14 @@ int cpu_down(unsigned int cpu)
 {
        int err = 0;

-       mutex_lock(&cpu_add_remove_lock);
+       blocking_notifier_call_chain(&cpu_chain, CPU_LOCK_ACQUIRE,
+                                               (void *)(long)cpu);
        if (cpu_hotplug_disabled)
                err = -EBUSY;
        else
                err = _cpu_down(cpu);
-
-       mutex_unlock(&cpu_add_remove_lock);
+       blocking_notifier_call_chain(&cpu_chain, CPU_LOCK_RELEASE,
+                                               (void *)(long)cpu);
        return err;
 }


-- 
Regards,
vatsa
