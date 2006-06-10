Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030398AbWFJACA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030398AbWFJACA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 20:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030399AbWFJACA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 20:02:00 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:53378 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030398AbWFJAB7 (ORCPT
	<rfc822;linux-kerneL@vger.kernel.org>);
	Fri, 9 Jun 2006 20:01:59 -0400
From: Darren Hart <dvhltc@us.ibm.com>
Organization: IBM Linux Technology Center
To: linux-kerneL@vger.kernel.org
Subject: [RFC PATCH -rt] Priority preemption latency
Date: Fri, 9 Jun 2006 17:01:54 -0700
User-Agent: KMail/1.9.1
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606091701.55185.dvhltc@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have run into a situation where a lower priority RT task will run after a 
higher priority RT task is awoken.  We are running the test case available 
here:

	http://linux.dvhart.com/tests/prio-preempt/

For all required files, including librt.h, download the tarball here:

	http://linux.dvhart.com/tests/tests.tar.bz2

The test case returns non zero on failure, so just run it in a loop, exitting 
on failure.  The following is a patch by Mike Kravetz that seems to resolve 
the problem.

Thoughts, comments?

Thanks,

-- 
Darren Hart
IBM Linux Technology Center



I've been looking into the priority preemption issues with [the prio-preempt 
test case]. My 'theory' is that when RT tasks are awakened they are not always
put on the 'best' runqueue.  As a result, the rt_overload functionality
has to be engaged to get the task to a CPU it can run on.  This 'delay'
in getting the task on a CPU is the 'bug' exposed by the testcase as
a lower priority task is allowed to run during this delay.

In the testcase, awakened worker tasks should all run on the same CPU
as the others are busy running other higher priority tasks.  But, from
the scheduler's point of view these other CPUs might be a better place
for the awakened task because they are 'less loaded'.

My quick and dirty patch (below) is to the try_to_wake_up path.  When
awakening an RT task don't send it to a remote CPU (determined to
be less loaded) unless it can prerempt the task running on the remote
CPU.  In such cases the task is added to the current CPU's runqueue.

I've been successfully running the C testcase for a while with this patch
applied.

I'm not sure of there is a 'complete' solution to this problem without
a redesign of 'global' RT scheduling on SMP.  The rt_overload mechanism
does not guarantee strict priority ordering (as evidenced by this bug).
Perhaps the best solution we can hope for with the current mechanism is
to make the scheduler be smarter with RT task placement on SMP.  This
would at least minimize the need for rt_overload.

-- 
Mike

diff -Naupr linux-rayrt12.1-r357/kernel/sched.c 
linux-rayrt12.1-r357.work/kernel/sched.c
--- linux-rayrt12.1-r357/kernel/sched.c	2006-05-27 00:43:35.000000000 +0000
+++ linux-rayrt12.1-r357.work/kernel/sched.c	2006-06-08 22:41:20.000000000 
+0000
@@ -1543,6 +1543,17 @@ static int try_to_wake_up(task_t *p, uns
 		}
 	}
 
+	/*
+	 * XXX  Don't send RT task elsewhere unless it can preempt current
+	 * XXX  on other CPU.  Better yet would be for awakened RT tasks to
+	 * XXX  examine this(and all other) CPU(s) to see what is the best
+	 * XXX  fit.  For example there is no check here to see if the
+	 * XXX  currently running task can be preempted (which would be the
+	 * XXX  ideal case).
+	 */
+	if (rt_task(p) && !TASK_PREEMPTS_CURR(p, rq))
+		goto out_set_cpu;
+
 	new_cpu = cpu; /* Could not wake to this_cpu. Wake to cpu instead */
 out_set_cpu:
 	new_cpu = wake_idle(new_cpu, p);

