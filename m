Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261388AbVFAOSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbVFAOSr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 10:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbVFAORa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 10:17:30 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:22203 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261394AbVFAOOW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 10:14:22 -0400
Message-ID: <429DC4A8.BFF69FB3@tv-sign.ru>
Date: Wed, 01 Jun 2005 18:22:32 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: john cooper <john.cooper@timesys.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Olaf Kirch <okir@suse.de>
Subject: Re: RT and Cascade interrupts
References: <42974F08.1C89CF2A@tv-sign.ru> <4297AF39.4070304@timesys.com>
	 <42983135.C521F1C8@tv-sign.ru> <4298AED8.8000408@timesys.com>
	 <1117312557.10746.6.camel@lade.trondhjem.org> <4299332F.6090900@timesys.com>
	 <1117352410.10788.29.camel@lade.trondhjem.org> <429B8678.1000706@timesys.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

del_timer_sync() is known to be racy. Now I think it has
(theoretically) problems with singleshot timers too.

Suppose whe have rpc timer which is running on CPU_0, it is
preempted *after* it has cleared RPC_TASK_HAS_TIMER bit.

Then __rpc_execute's main loop on CPU_1 calls rpc_delete_timer(),
it returns without doing del_timer_sync().

Now it calls ->tk_action()->rpc_sleep_on()->__rpc_add_timer(),
timer pending on CPU_1.

preemption comes, reschedule at another (not CPU_1) processor,
(this step is not strictly necessary).

Next loop iteration, __rpc_execute calls rpc_delete_timer() again,
now it calls del_timer_sync().

del_timer_sync:

	// __run_timers starts on CPU_1, picks rpc timer, sets
	// timer->base = 0

	ret += del_timer(timer); // return 0, timer is not pending.

	for_each_online_cpu() {
		if (timer running on that cpu) {
			// finds the timer still running on CPU_0,
			// waits for __run_timers on CPU_0 change
			//	->running_timer,
			// the timer on CPU_0 completes.
			break;
		}
	}

	if (timer_pending())	// NO
		goto del_again;

	// The timer still running on CPU_1
	return;

This all is very unlikely of course, but it would be nice to verify
that kernel/timer.c is not the source of the problem.

John, if it is easy to reproduce the problem, could you please retest
with this patch?

Oleg.

--- 2.6.12-rc5/net/sunrpc/sched.c~	Wed Jun  1 17:49:57 2005
+++ 2.6.12-rc5/net/sunrpc/sched.c	Wed Jun  1 18:00:31 2005
@@ -137,8 +137,12 @@ rpc_delete_timer(struct rpc_task *task)
 {
 	if (RPC_IS_QUEUED(task))
 		return;
-	if (test_and_clear_bit(RPC_TASK_HAS_TIMER, &task->tk_runstate)) {
-		del_singleshot_timer_sync(&task->tk_timer);
+	if (test_bit(RPC_TASK_HAS_TIMER, &task->tk_runstate)) {
+		if (del_singleshot_timer_sync(&task->tk_timer)) {
+			BUG_ON(!test_bit(RPC_TASK_HAS_TIMER, &task->tk_runstate));
+			clear_bit(RPC_TASK_HAS_TIMER, &task->tk_runstate);
+		} else
+			BUG_ON(test_bit(RPC_TASK_HAS_TIMER, &task->tk_runstate));
 		dprintk("RPC: %4d deleting timer\n", task->tk_pid);
 	}
 }
