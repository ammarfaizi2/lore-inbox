Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262600AbVF3NCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262600AbVF3NCv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 09:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262662AbVF3NCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 09:02:51 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:27355 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S262600AbVF3NCq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 09:02:46 -0400
Message-ID: <42C3EF9F.D5E7761E@tv-sign.ru>
Date: Thu, 30 Jun 2005 17:11:59 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] rpc_delete_timer() cleanup
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When rpc task receives a signal while sleeping on RPC_TASK_QUEUED bit,
__rpc_execute() calls rpc_wake_up_task(). If rpc timer starts on another
cpu at the same time it can set RPC_TASK_WAKEUP bit before rpc_wake_up_task()
called from __rpc_execute() does so. Now the main loop in __rpc_execute
restarted with RPC_TASK_QUEUED bit and with still executing tk_timer.

I don't see too bad in this (the task already has RPC_TASK_KILLED flag,
so ->tk_exit() should not call rpc_delay(), and it has TIF_SIGPENDING),
but still I think it was not intended to happen.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.13-rc1/net/sunrpc/sched.c~	Thu Jun 30 17:03:08 2005
+++ 2.6.13-rc1/net/sunrpc/sched.c	Thu Jun 30 17:03:25 2005
@@ -135,8 +135,6 @@ __rpc_add_timer(struct rpc_task *task, r
 static void
 rpc_delete_timer(struct rpc_task *task)
 {
-	if (RPC_IS_QUEUED(task))
-		return;
 	if (test_and_clear_bit(RPC_TASK_HAS_TIMER, &task->tk_runstate)) {
 		del_singleshot_timer_sync(&task->tk_timer);
 		dprintk("RPC: %4d deleting timer\n", task->tk_pid);
