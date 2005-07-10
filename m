Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261903AbVGJLSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbVGJLSL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 07:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbVGJLSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 07:18:11 -0400
Received: from amsfep11-int.chello.nl ([213.46.243.19]:40509 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S261903AbVGJLSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 07:18:10 -0400
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.51-12
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: William Weston <weston@sysex.net>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <1120944243.12169.3.camel@twins>
References: <200506301952.22022.annabellesgarden@yahoo.de>
	 <20050630205029.GB1824@elte.hu>
	 <200507010027.33079.annabellesgarden@yahoo.de>
	 <20050701071850.GA18926@elte.hu>
	 <Pine.LNX.4.58.0507011739550.27619@echo.lysdexia.org>
	 <20050703140432.GA19074@elte.hu> <20050703181229.GA32741@elte.hu>
	 <Pine.LNX.4.58.0507061802570.20214@echo.lysdexia.org>
	 <20050707104859.GD22422@elte.hu>
	 <Pine.LNX.4.58.0507071257320.25321@echo.lysdexia.org>
	 <20050708080359.GA32001@elte.hu>
	 <Pine.LNX.4.58.0507081246340.30549@echo.lysdexia.org>
	 <1120944243.12169.3.camel@twins>
Content-Type: text/plain
Date: Sun, 10 Jul 2005 13:18:07 +0200
Message-Id: <1120994288.14680.0.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-07-09 at 23:24 +0200, Peter Zijlstra wrote:
> On Fri, 2005-07-08 at 13:12 -0700, William Weston wrote:
> > On Fri, 8 Jul 2005, Ingo Molnar wrote:
> > 
> > > could you check whether the priority leakage happens if you disable SMP?  
> > > (if you can reproduce it easily)
> > 
> > No priority leakages have been seen with UP configs on any of the 
> > machines I've been testing.
> > 
> > The leakage is not hard to reproduce under SMT:  start up jackd from a
> > text vc with an rt prio of 60 (or some unique prio above the IRQ threads),
> > then restart X and login.  After several minutes, X and all of its
> > children will be running at whatever prio jackd was started at (but still
> > SCHED_NORMAL).  Eventually, init, a handful of SCHED_NORMAL kernel
> > threads, and other random processes are all running at the same priority.  
> > When reset to default priority with chrt or schedtool, these processes
> > eventually revert back to the leaked priority level.  When jackd is
> > stopped, the priorities stay in their elevated state.  If jackd is not 
> > started before logging in to X, then the priority of one of the SCHED_FF 
> > kernel threads is leaked to other processes in the same manner.
> > 
> 
> I can reproduce priority leakage on my SMP system; any userspace process
> chrt'ed up and a lot will follow. This makes the system very
> unresponsive when doing a make -j5. Verified on 51-{6,18,23}.
> 

The following patch seems to fix it for me, YMMV.

--- kernel/sched.c~     2005-07-08 10:27:59.000000000 +0200
+++ kernel/sched.c      2005-07-10 13:00:42.000000000 +0200
@@ -780,7 +780,8 @@ static void recalc_task_prio(task_t *p,
                }
        }

-       p->prio = p->normal_prio = effective_prio(p);
+       p->prio = effective_prio(p);
+       p->normal_prio = unlikely(rt_prio(p->normal_prio)) ? p->prio : __effective_prio(p);
 }

 /*
@@ -1415,7 +1416,8 @@ void fastcall wake_up_new_task(task_t *
        p->sleep_avg = JIFFIES_TO_NS(CURRENT_BONUS(p) *
                CHILD_PENALTY / 100 * MAX_SLEEP_AVG / MAX_BONUS);

-       p->prio = p->normal_prio = effective_prio(p);
+       p->prio = effective_prio(p);
+       p->normal_prio = unlikely(rt_prio(p->normal_prio)) ? p->prio : __effective_prio(p);

        if (likely(cpu == this_cpu)) {
                if (!(clone_flags & CLONE_VM)) {
@@ -1427,7 +1429,8 @@ void fastcall wake_up_new_task(task_t *
                        if (unlikely(!current->array))
                                __activate_task(p, rq);
                        else {
-                               p->prio = p->normal_prio = current->prio;
+                               p->prio = current->prio;
+                               p->normal_prio = current->normal_prio;
                                __activate_task_after(p, current, rq);
                        }
                        set_need_resched();
@@ -2744,7 +2747,8 @@ void scheduler_tick(void)
        if (!--p->time_slice) {
                dequeue_task(p, rq->active);
                set_tsk_need_resched(p);
-               p->prio = p->normal_prio = effective_prio(p);
+               p->prio = effective_prio(p);
+               p->normal_prio = unlikely(rt_prio(p->normal_prio)) ? p->prio : __effective_prio(p);
                p->time_slice = task_timeslice(p);
                p->first_time_slice = 0;



-- 
Peter Zijlstra <a.p.zijlstra@chello.nl>

