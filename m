Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264018AbUDGFc5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 01:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264093AbUDGFc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 01:32:57 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:9137 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S264018AbUDGFcy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 01:32:54 -0400
Subject: Re: [Experimental CPU Hotplug PATCH] - Move migrate_all_tasks to
	CPU_DEAD handling
From: Rusty Russell <rusty@rustcorp.com.au>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       LHCS list <lhcs-devel@lists.sourceforge.net>
In-Reply-To: <20040407050111.GA10256@in.ibm.com>
References: <20040405121824.GA8497@in.ibm.com>
	 <4071F9C5.2030002@yahoo.com.au> <20040406083713.GB7362@in.ibm.com>
	 <407277AE.2050403@yahoo.com.au> <1081310073.5922.86.camel@bach>
	 <20040407050111.GA10256@in.ibm.com>
Content-Type: text/plain
Message-Id: <1081315931.5922.151.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 07 Apr 2004 15:32:12 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-04-07 at 15:01, Srivatsa Vaddagiri wrote:
> I restore the mask though (under covers of lock_cpu_hotplug) before
> returning from cpu_down. Task should never see this violated affinity.

But other tasks can do a getaffinity() on it and see the wrong affinity.
Probably not a big issue.

> Rusty,
> 	What do you think abt the whole patch? It has withstood 
> my stress-test harness :-)

I agree with Ingo: it's clever, well done.  Minor nitpicks:

+void migrate_all_tasks(int cpu)
 {
        struct task_struct *tsk, *t;
        int dest_cpu, src_cpu;
        unsigned int node;
 
-       /* We're nailed to this CPU. */
-       src_cpu = smp_processor_id();
+       src_cpu = cpu;

Just make the parameter name "src_cpu"?


+               /* Take idle task off runqueue and restore it's
+                * policy/priority
+                */
+               rq = task_rq_lock(rq->idle, &flags);
+
+               /* Call init_idle instead ?? init_idle doesn't restore
the
+                * policy though for us ..
+                */
+               deactivate_task(rq->idle, rq);
+               __setscheduler(rq->idle, SCHED_NORMAL, MAX_PRIO);
+
+               task_rq_unlock(rq, &flags);

One-line comments and compact code good:

		/* Idle task back to normal (off runqueue, low prio) */
		rq = task_rq_lock(rq->idle, &flags);
		deactivate_task(rq->idle, rq);
		__setscheduler(rq->idle, SCHED_NORMAL, MAX_PRIO);
		task_rq_unlock(rq, &flags);



+               /* Force scheduler to switch to idle task when we yield.
+                * We expect idle task to _immediately_ notice that it's
cpu
+                * is offline and die quickly.
+                *
+                * This allows us to defer calling mirate_all_tasks
until
+                * CPU_DEAD notification time.
+                */
+               sched_idle_next();

This comment's very big.  They don't need to know all the things we
don't do.  I'd prefer:

		/* Force idle task to run as soon as we yield: it should
		   immediately notice cpu is offline and die quickly. */

I'm happy for this to go in..
Rusty
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

