Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbVE2HlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVE2HlO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 03:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261268AbVE2HlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 03:41:13 -0400
Received: from pat.uio.no ([129.240.130.16]:4817 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261266AbVE2Hku (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 03:40:50 -0400
Subject: Re: RT and Cascade interrupts
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: john cooper <john.cooper@timesys.com>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Olaf Kirch <okir@suse.de>
In-Reply-To: <4299332F.6090900@timesys.com>
References: <42974F08.1C89CF2A@tv-sign.ru> <4297AF39.4070304@timesys.com>
	 <42983135.C521F1C8@tv-sign.ru>  <4298AED8.8000408@timesys.com>
	 <1117312557.10746.6.camel@lade.trondhjem.org>
	 <4299332F.6090900@timesys.com>
Content-Type: multipart/mixed; boundary="=-GFu0lPI68Bdh/YoYB6Ct"
Date: Sun, 29 May 2005 00:40:10 -0700
Message-Id: <1117352410.10788.29.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.868, required 12,
	autolearn=disabled, AWL 2.13, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GFu0lPI68Bdh/YoYB6Ct
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

lau den 28.05.2005 Klokka 23:12 (-0400) skreiv john cooper:

> 1.  Can you correlate anything of rpc_run_timer() running in
>      preemptive context which could explain the above behavior?
>
> 2.  Do you agree that (!RPC_TASK_HAS_TIMER && timer->base)
>      is an inconsistent state at the time of
>      rpc_release_task():rpc_delete_timer() ?

I have yet to see an example of that happening.

The current code should be working according to the following rules:

        timers are only set if the rpc_task is being put on a wait queue
        and tk_timeout is non-zero.

        RPC_TASK_HAS_TIMER is always set immediately before the timer is
        activated.

        It is cleared either by the handler _after_ it has run (and
        after timer->base has been cleared by __rpc_run_timer()), or by
        __rpc_execute()/rpc_release_task() immediately prior to the call
        to del_singleshot_timer_sync().

        task->tk_callback should never be putting a task to sleep, so
        there is no timer being set after the call to rpc_delete_timer()
        and prior to the call to task->tk_action.
        
The above rules should suffice to guarantee strict ordering w.r.t.
starting a timer, clearing the same timer, and restarting a new timer,
so the code should not need to be reentrant. I've appended a patch that
should check for strict compliance of the above rules. Could you try it
out and see if it triggers any Oopses?

Cheers,
  Trond


--=-GFu0lPI68Bdh/YoYB6Ct
Content-Disposition: inline; filename=linux-2.6.12-test_timer.dif
Content-Type: text/plain; name=linux-2.6.12-test_timer.dif; charset=UTF-8
Content-Transfer-Encoding: 7bit

 sched.c |    8 ++++++++
 1 files changed, 8 insertions(+)

Index: linux-2.6.12-rc4/net/sunrpc/sched.c
===================================================================
--- linux-2.6.12-rc4.orig/net/sunrpc/sched.c
+++ linux-2.6.12-rc4/net/sunrpc/sched.c
@@ -135,6 +135,8 @@ __rpc_add_timer(struct rpc_task *task, r
 static void
 rpc_delete_timer(struct rpc_task *task)
 {
+	BUG_ON(test_bit(RPC_TASK_HAS_TIMER, &task->tk_runstate) == 0 &&
+			timer_pending(&task->tk_timer));
 	if (RPC_IS_QUEUED(task))
 		return;
 	if (test_and_clear_bit(RPC_TASK_HAS_TIMER, &task->tk_runstate)) {
@@ -337,6 +339,8 @@ static void __rpc_sleep_on(struct rpc_wa
 void rpc_sleep_on(struct rpc_wait_queue *q, struct rpc_task *task,
 				rpc_action action, rpc_action timer)
 {
+	BUG_ON(test_bit(RPC_TASK_HAS_TIMER, &task->tk_runstate) != 0 ||
+			timer_pending(&task->tk_timer));
 	/*
 	 * Protect the queue operations.
 	 */
@@ -594,6 +598,8 @@ static int __rpc_execute(struct rpc_task
 			unlock_kernel();
 		}
 
+		BUG_ON(test_bit(RPC_TASK_HAS_TIMER, &task->tk_runstate) != 0 ||
+			timer_pending(&task->tk_timer));
 		/*
 		 * Perform the next FSM step.
 		 * tk_action may be NULL when the task has been killed
@@ -925,6 +931,8 @@ fail:
 
 void rpc_run_child(struct rpc_task *task, struct rpc_task *child, rpc_action func)
 {
+	BUG_ON(test_bit(RPC_TASK_HAS_TIMER, &task->tk_runstate) != 0 ||
+			timer_pending(&task->tk_timer));
 	spin_lock_bh(&childq.lock);
 	/* N.B. Is it possible for the child to have already finished? */
 	__rpc_sleep_on(&childq, task, func, NULL);

--=-GFu0lPI68Bdh/YoYB6Ct--

