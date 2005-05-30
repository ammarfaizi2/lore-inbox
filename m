Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbVE3OzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbVE3OzA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 10:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbVE3OyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 10:54:07 -0400
Received: from mx2.elte.hu ([157.181.151.9]:52411 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261620AbVE3Ovh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 10:51:37 -0400
Date: Mon, 30 May 2005 16:50:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, john cooper <john.cooper@timesys.com>,
       linux-kernel@vger.kernel.org, Olaf Kirch <okir@suse.de>
Subject: Re: RT and Cascade interrupts
Message-ID: <20050530145050.GB16609@elte.hu>
References: <42974F08.1C89CF2A@tv-sign.ru> <4297AF39.4070304@timesys.com> <42983135.C521F1C8@tv-sign.ru> <4298AED8.8000408@timesys.com> <1117312557.10746.6.camel@lade.trondhjem.org> <4299A7F6.3A31BB7D@tv-sign.ru> <1117375108.11049.27.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117375108.11049.27.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> > Is this patch makes any sense?
> 
> Yes. I agree the scenario is theoretically possible (so I can queue 
> that patch up for you). I am not convinced it is a plausible 
> explanation for what John claims to be seeing, though.

i've added this patch (and your debug asserts, except for the 
rpc_delete_timer() one) to the -RT tree and i've removed the earlier 
hack - perhaps John can re-run the test and see whether it still occurs 
under -rc5-RT-V0.7.47-13 or later?

most races are much more likely to occur under PREEMPT_RT than under 
other preemption models, but maybe there's something else going on as 
well.

	Ingo

--- linux/net/sunrpc/sched.c.orig
+++ linux/net/sunrpc/sched.c
@@ -135,8 +135,6 @@ __rpc_add_timer(struct rpc_task *task, r
 static void
 rpc_delete_timer(struct rpc_task *task)
 {
-	if (RPC_IS_QUEUED(task))
-		return;
 	if (test_and_clear_bit(RPC_TASK_HAS_TIMER, &task->tk_runstate)) {
 		del_singleshot_timer_sync(&task->tk_timer);
 		dprintk("RPC: %4d deleting timer\n", task->tk_pid);
@@ -337,6 +335,8 @@ static void __rpc_sleep_on(struct rpc_wa
 void rpc_sleep_on(struct rpc_wait_queue *q, struct rpc_task *task,
 				rpc_action action, rpc_action timer)
 {
+	BUG_ON(test_bit(RPC_TASK_HAS_TIMER, &task->tk_runstate) != 0 ||
+			timer_pending(&task->tk_timer));
 	/*
 	 * Protect the queue operations.
 	 */
@@ -566,7 +566,6 @@ static int __rpc_execute(struct rpc_task
 
 	BUG_ON(RPC_IS_QUEUED(task));
 
- restarted:
 	while (1) {
 		/*
 		 * Garbage collection of pending timers...
@@ -594,6 +593,8 @@ static int __rpc_execute(struct rpc_task
 			unlock_kernel();
 		}
 
+		BUG_ON(test_bit(RPC_TASK_HAS_TIMER, &task->tk_runstate) != 0 ||
+			timer_pending(&task->tk_timer));
 		/*
 		 * Perform the next FSM step.
 		 * tk_action may be NULL when the task has been killed
@@ -607,6 +608,7 @@ static int __rpc_execute(struct rpc_task
 			unlock_kernel();
 		}
 
+ restarted:
 		/*
 		 * Lockless check for whether task is sleeping or not.
 		 */
@@ -925,6 +927,8 @@ fail:
 
 void rpc_run_child(struct rpc_task *task, struct rpc_task *child, rpc_action func)
 {
+	BUG_ON(test_bit(RPC_TASK_HAS_TIMER, &task->tk_runstate) != 0 ||
+			timer_pending(&task->tk_timer));
 	spin_lock_bh(&childq.lock);
 	/* N.B. Is it possible for the child to have already finished? */
 	__rpc_sleep_on(&childq, task, func, NULL);
