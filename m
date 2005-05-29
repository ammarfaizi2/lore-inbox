Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbVE2LXC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbVE2LXC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 07:23:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbVE2LXC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 07:23:02 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:57516 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261183AbVE2LW6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 07:22:58 -0400
Message-ID: <4299A7F6.3A31BB7D@tv-sign.ru>
Date: Sun, 29 May 2005 15:31:02 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: john cooper <john.cooper@timesys.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Olaf Kirch <okir@suse.de>
Subject: Re: RT and Cascade interrupts
References: <42974F08.1C89CF2A@tv-sign.ru> <4297AF39.4070304@timesys.com>
		 <42983135.C521F1C8@tv-sign.ru>  <4298AED8.8000408@timesys.com> <1117312557.10746.6.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

__rpc_execute() calls ->tk_exit and goes to 'restarted' label.
What if ->tk_exit calls rpc_sleep_on() ? If it is possible, we
have a race.

CPU_0 (main loop in rpc_execute restarted)		CPU_1

rpc_delete_timer:
	if (RPC_IS_QUEUED())	// YES
		return;
							rpc_run_timer:
								rpc_wake_up_task:
									clear_bit(RPC_TASK_QUEUED)
								preemption, or long interrupt

if (!RPC_IS_QUEUED())		// YES
	task->tk_action()
		__rpc_add_timer:
			set_bit(RPC_TASK_HAS_TIMER)
			mod_timer();
								clear_bit(RPC_TASK_HAS_TIMER)

Now we have pending timer without RPC_TASK_HAS_TIMER bit set.

Is this patch makes any sense?

Oleg.

--- 2.6.12-rc5/net/sunrpc/sched.c~	Sun May 29 15:09:25 2005
+++ 2.6.12-rc5/net/sunrpc/sched.c	Sun May 29 15:11:24 2005
@@ -135,8 +135,6 @@ __rpc_add_timer(struct rpc_task *task, r
 static void
 rpc_delete_timer(struct rpc_task *task)
 {
-	if (RPC_IS_QUEUED(task))
-		return;
 	if (test_and_clear_bit(RPC_TASK_HAS_TIMER, &task->tk_runstate)) {
 		del_singleshot_timer_sync(&task->tk_timer);
 		dprintk("RPC: %4d deleting timer\n", task->tk_pid);
@@ -566,7 +564,6 @@ static int __rpc_execute(struct rpc_task
 
 	BUG_ON(RPC_IS_QUEUED(task));
 
- restarted:
 	while (1) {
 		/*
 		 * Garbage collection of pending timers...
@@ -607,6 +604,7 @@ static int __rpc_execute(struct rpc_task
 			unlock_kernel();
 		}
 
+ restarted:
 		/*
 		 * Lockless check for whether task is sleeping or not.
 		 */
