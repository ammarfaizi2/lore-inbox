Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262135AbVEXQkd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262135AbVEXQkd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 12:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbVEXQhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 12:37:14 -0400
Received: from mail.timesys.com ([65.117.135.102]:1162 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S262157AbVEXQeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 12:34:03 -0400
Message-ID: <42935715.2000505@timesys.com>
Date: Tue, 24 May 2005 12:32:21 -0400
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: john cooper <john.cooper@timesys.com>, Daniel Walker <dwalker@mvista.com>,
       linux-kernel@vger.kernel.org
Subject: Re: RT and Cascade interrupts
References: <Pine.LNX.4.44.0505120740270.31369-100000@dhcp153.mvista.com> <20050513074439.GB25458@elte.hu> <4284A7B6.4090408@timesys.com>
In-Reply-To: <4284A7B6.4090408@timesys.com>
Content-Type: multipart/mixed;
 boundary="------------040704090006050607070900"
X-OriginalArrivalTime: 24 May 2005 16:27:40.0328 (UTC) FILETIME=[811D3280:01C5607D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040704090006050607070900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

john cooper wrote:
> I'm seeing the BUG assert in kernel/timers.c:cascade()
> kick in (tmp->base is somehow 0) during a test which
> creates a few tasks of priority higher than ksoftirqd.
> This race doesn't happen if ksoftirqd's priority is
> elevated (eg: chrt -f -p 75 2) so the -RT patch might
> be opening up a window here.

There is a window in rpc_run_timer() which allows
it to lose track of timer ownership when ksoftirqd
(and thus itself) are preempted.  This doesn't
immediately cause a problem but does corrupt
the timer cascade list when the timer struct is
recycled/requeued.  This shows up some time later
as the list is processed.  The failure mode is cascade()
attempting to percolate a timer with poisoned
next/prev *s and a NULL base causing the assertion
BUG(tmp->base != base) to kick in.

The RPC code is attempting to replicate state of
timer ownership for a given rpc_task via RPC_TASK_HAS_TIMER
in rpc_task.tk_runstate.  Besides not working
correctly in the case of preemptable context it is
a replication of state of a timer pending in the
cascade structure (ie: timer->base).  The fix
changes the RPC code to use timer->base when
deciding whether an outstanding timer registration
exists during rpc_task tear down.

Note: this failure occurred in the 40-04 version of
the patch though it applies to more current versions.
It was seen when executing stress tests on a number
of PPC targets running on an NFS mounted root though
was not observed on a x86 target under similar
conditions.

-john


-- 
john.cooper@timesys.com

--------------040704090006050607070900
Content-Type: text/plain;
 name="RPC.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="RPC.patch"

./include/linux/sunrpc/sched.h
./net/sunrpc/sched.c
=================================================================
--- ./include/linux/sunrpc/sched.h.ORG	2005-05-24 10:29:24.000000000 -0400
+++ ./include/linux/sunrpc/sched.h	2005-05-24 10:47:56.000000000 -0400
@@ -142,7 +142,6 @@ typedef void			(*rpc_action)(struct rpc_
 #define RPC_TASK_RUNNING	0
 #define RPC_TASK_QUEUED		1
 #define RPC_TASK_WAKEUP		2
-#define RPC_TASK_HAS_TIMER	3
 
 #define RPC_IS_RUNNING(t)	(test_bit(RPC_TASK_RUNNING, &(t)->tk_runstate))
 #define rpc_set_running(t)	(set_bit(RPC_TASK_RUNNING, &(t)->tk_runstate))
=================================================================
--- ./net/sunrpc/sched.c.ORG	2005-05-24 10:29:52.000000000 -0400
+++ ./net/sunrpc/sched.c	2005-05-24 11:02:44.000000000 -0400
@@ -103,9 +103,6 @@ static void rpc_run_timer(struct rpc_tas
 		dprintk("RPC: %4d running timer\n", task->tk_pid);
 		callback(task);
 	}
-	smp_mb__before_clear_bit();
-	clear_bit(RPC_TASK_HAS_TIMER, &task->tk_runstate);
-	smp_mb__after_clear_bit();
 }
 
 /*
@@ -124,7 +121,6 @@ __rpc_add_timer(struct rpc_task *task, r
 		task->tk_timeout_fn = timer;
 	else
 		task->tk_timeout_fn = __rpc_default_timer;
-	set_bit(RPC_TASK_HAS_TIMER, &task->tk_runstate);
 	mod_timer(&task->tk_timer, jiffies + task->tk_timeout);
 }
 
@@ -135,7 +131,7 @@ __rpc_add_timer(struct rpc_task *task, r
 static inline void
 rpc_delete_timer(struct rpc_task *task)
 {
-	if (test_and_clear_bit(RPC_TASK_HAS_TIMER, &task->tk_runstate)) {
+	if (task->tk_timer.base) {
 		del_singleshot_timer_sync(&task->tk_timer);
 		dprintk("RPC: %4d deleting timer\n", task->tk_pid);
 	}

--------------040704090006050607070900--
