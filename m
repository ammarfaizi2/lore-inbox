Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312973AbSFFXU6>; Thu, 6 Jun 2002 19:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312962AbSFFXU5>; Thu, 6 Jun 2002 19:20:57 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:6791 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S312973AbSFFXUz>;
	Thu, 6 Jun 2002 19:20:55 -0400
Date: Thu, 6 Jun 2002 16:20:28 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Robert Love <rml@tech9.net>, Ingo Molnar <mingo@elte.hu>,
        linux-kernel@vger.kernel.org
Subject: Scheduler Bug (set_cpus_allowed)
Message-ID: <20020606162028.E3193@w-mikek2.des.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At my suggestion the following optimization/fast path
was added to set_cpus_allowed:

        /*
         * If the task is not on a runqueue, then it is sufficient
         * to simply update the task's cpu field.
         */
        if (!p->array) {
                p->thread_info->cpu = __ffs(p->cpus_allowed);
                task_rq_unlock(rq, &flags);
                goto out;
        }

Unfortunately, the assumption made here is not true.

Consider the case where a task is to give up the CPU
and schedule() is called.  In such a case the current
task is removed from the runqueue (via deactivate_task).
Now, further assume that there are no runnable tasks
on the runqueue and we end up calling load_balance().
In load_balance, we potentially drop the runqueue lock
to obtain multiple runqueue locks in the proper order.
Now, when we drop the runqueue lock we will still
be running in the context of task p.  However, p does
not reside on a runqueue.  It is now possible for
set_cpus_allowed() to be called for p.  We can get the
runqueue lock and take the fast path to simply update
the task's cpu field.  If this happens, bad (very bad)
things will happen!

My first thought was to simply add a check to the
above code to ensure that p was not currently running
(p != rq->curr).  However, even with this change I
'think' the same problem exists later on in schedule()
where we drop the runqueue lock before doing a context
switch.  At this point, p is not on the runqueue and
p != rq->curr, yet we are still runnning in the context
of p until we actually do the context switch.  To tell
the truth, I'm not exactly sure what 'rq->frozen' lock
is for.  Also, the routine 'schedule_tail' does not
appear to be used anywhere.

Comments?/Thoughts?/Suggestions?
-- 
Mike
