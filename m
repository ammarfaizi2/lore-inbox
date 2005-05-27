Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262660AbVE0XjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262660AbVE0XjK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 19:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262661AbVE0XjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 19:39:09 -0400
Received: from mail.timesys.com ([65.117.135.102]:30148 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S262660AbVE0Xi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 19:38:56 -0400
Message-ID: <4297AF39.4070304@timesys.com>
Date: Fri, 27 May 2005 19:37:29 -0400
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oleg Nesterov <oleg@tv-sign.ru>
CC: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       john cooper <john.cooper@timesys.com>
Subject: Re: RT and Cascade interrupts
References: <42974F08.1C89CF2A@tv-sign.ru>
In-Reply-To: <42974F08.1C89CF2A@tv-sign.ru>
Content-Type: multipart/mixed;
 boundary="------------070402070205080406080403"
X-OriginalArrivalTime: 27 May 2005 23:32:23.0500 (UTC) FILETIME=[5581E8C0:01C56314]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070402070205080406080403
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Oleg Nesterov wrote:
> john cooper wrote:
> 
>> rpc_delete_timer(struct rpc_task *task)
>> {
>>-	if (test_and_clear_bit(RPC_TASK_HAS_TIMER, &task->tk_runstate)) {
>>+	if (task->tk_timer.base) {
>> 		del_singleshot_timer_sync(&task->tk_timer);
>> 		dprintk("RPC: %4d deleting timer\n", task->tk_pid);
>> 	}
> 
> 
> I know nothing about rpc, but this looks completely wrong to me.
> 
> Please don't use the ->base directly, use timer_pending().

A nit here but fair enough.

> This field is never NULL in -mm tree.

Which is ok if timer_pending() still provides the needed
information.  Otherwise another means will be needed to
determine whether the struct timer is logically "off" the
base to which it was previous queued.  I added such state
information to the timer structure and associated code in
the process of hunting this problem, but removed it in the
patch as for the tree to which this applies the state of
base already provided the information.

> Next, timer_pending() == 0 does not mean that del_timer_sync() is
> not needed, it may be running on the other CPU.

Whether timer_pending() is SMP safe depends on the caller's
context relative to the overall usage of the timer structure.

For example we aren't holding base->lock in rpc_delete_timer()
as would normally be expected.  The reason this is safe is
the transition to "timer off base" and "timer.base <- NULL"
follows this sequence in __run_timers().  So the worst we
can do is to be racing with another cpu trying to expire this
timer and we will delete an already inactive timer which is
innocuous here.

The state transition of "timer on base" and
"timer.base <- base" can only happen after we free
the struct rpc_task in which the struct timer is embedded.
We haven't done so yet so no race here exists.

> Looking at the code for the first time, I can guess that RPC_TASK_HAS_TIMER
> was invented to indicate when it is safe not to wait for timer
> completition. This bit is cleared after ->tk_timeout_fn call in
> the timer's handler. After that rpc_run_timer will not touch *task.

The problem being it is possible in the now preemptible
context in which rpc_run_timer() executes for the call
of callback(task) to be preempted allowing another task
restart the timer (via a call to __rpc_add_timer()).
So the previous implied assumption in a nonpreemptive
rpc_run_timer() of the timer known to be inactive (as
that's how we arrived here) is no longer reliable.

The failure is for the timer to have been requeued during
the preemption but RPC_TASK_HAS_TIMER to afterwards
be cleared in rpc_run_timer().  This results in the call to
rpc_delete_timer() from rpc_release_task() never occurring
and the rpc_task struct then released for reuse with the
embedded timer struct still linked in the timer cascade list.
The next reuse of this rpc_task struct requeues the
embedded timer struct again in the cascade list causing
the corruption.

The fix removes the attempt to replicate timer queue
status from the RPC code by removing the usage of the
pre-calculated RPC_TASK_HAS_TIMER.  This information is
only for the benefit of rpc_delete_timer() which is
called in the case of rpc_task tear down.  So the test
is deferred until just before freeing the rpc_task for
reuse.

The potential race within rpc_release_task() of the timer
being requeued between the call to rpc_delete_timer()
and the call to rpc_free() is closed by setting
tk_timeout = 0 in the rpc_task before the rpc_delete_timer()
call.  It may be unnecessary but I couldn't conclude a
race did not exist so it errs on the side of caution.
Updated patch attached relative to 40-04.

This is a rather complex failure scenario which unwinds
over time and requires considerable instrumentation to
isolate.  I think the addition of configurable debug
state information to the timer structure along with
assertion checking in the primitives which manipulate
them would be quite useful for catching similar problems.

-john


-- 
john.cooper@timesys.com

--------------070402070205080406080403
Content-Type: text/plain;
 name="RPC.patch2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="RPC.patch2"

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
+++ ./net/sunrpc/sched.c	2005-05-27 18:27:41.000000000 -0400
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
+	if (timer_pending(&task->tk_timer)) {
 		del_singleshot_timer_sync(&task->tk_timer);
 		dprintk("RPC: %4d deleting timer\n", task->tk_pid);
 	}
@@ -849,6 +845,7 @@ void rpc_release_task(struct rpc_task *t
 	task->tk_active = 0;
 
 	/* Synchronously delete any running timer */
+	task->tk_timeout = 0;
 	rpc_delete_timer(task);
 
 	/* Release resources */

--------------070402070205080406080403--
