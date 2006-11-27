Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933156AbWK0TEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933156AbWK0TEW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 14:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758537AbWK0TEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 14:04:22 -0500
Received: from nacho.alt.net ([207.14.113.18]:17292 "HELO nacho.alt.net")
	by vger.kernel.org with SMTP id S1758413AbWK0TEV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 14:04:21 -0500
Date: Mon, 27 Nov 2006 19:04:19 +0000 (GMT)
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: [PATCH 2.6.19-rc6] sunrpc: fix race condition
Message-ID: <Pine.LNX.4.64.0611271900120.10489@nacho.alt.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Delivery-Agent: TMDA/1.0.3 (Seattle Slew)
From: Chris Caputo <ccaputo@alt.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Caputo <ccaputo@alt.net>
[PATCH 2.6.19-rc6] sunrpc: fix race condition

Patch linux-2.6.10-01-rpc_workqueue.dif introduced a race condition into 
net/sunrpc/sched.c in kernels 2.6.11-rc1 through 2.6.19-rc6.  The race 
scenario is as follows...

Given: RPC_TASK_QUEUED, RPC_TASK_RUNNING and RPC_TASK_ASYNC are set.

__rpc_execute() (no spinlock)    rpc_make_runnable() (queue spinlock held)
-----------------------------    -----------------------------------------
                                 do_ret = rpc_test_and_set_running(task);
rpc_clear_running(task);
if (RPC_IS_ASYNC(task)) {
        if (RPC_IS_QUEUED(task))
                return 0;
                                 rpc_clear_queued(task);
                                 if (do_ret)
                                         return;

Thus both threads return and the task is abandoned forever.

In my test NFS client usage (~200 Mb/s at ~3,000 RPC calls/s) this race 
condition has resulted in processes getting permanently stuck in 'D' state 
often in less than 15 minutes of uptime.

The following patch fixes the problem by returning to use of a spinlock in 
__rpc_execute().

Signed-off-by: Chris Caputo <ccaputo@alt.net>
---

diff -up a/net/sunrpc/sched.c b/net/sunrpc/sched.c
--- a/net/sunrpc/sched.c	2006-11-27 08:41:07.000000000 +0000
+++ b/net/sunrpc/sched.c	2006-11-27 11:14:21.000000000 +0000
@@ -587,6 +587,7 @@ EXPORT_SYMBOL(rpc_exit_task);
 static int __rpc_execute(struct rpc_task *task)
 {
 	int		status = 0;
+	struct rpc_wait_queue *queue;
 
 	dprintk("RPC: %4d rpc_execute flgs %x\n",
 				task->tk_pid, task->tk_flags);
@@ -631,22 +632,27 @@ static int __rpc_execute(struct rpc_task
 			lock_kernel();
 			task->tk_action(task);
 			unlock_kernel();
+			/* micro-optimization to avoid spinlock */
+			if (!RPC_IS_QUEUED(task))
+				continue;
 		}
 
 		/*
-		 * Lockless check for whether task is sleeping or not.
+		 * Check whether task is sleeping.
 		 */
-		if (!RPC_IS_QUEUED(task))
-			continue;
-		rpc_clear_running(task);
+		queue = task->u.tk_wait.rpc_waitq;
+		spin_lock_bh(&queue->lock);
 		if (RPC_IS_ASYNC(task)) {
-			/* Careful! we may have raced... */
-			if (RPC_IS_QUEUED(task))
-				return 0;
-			if (rpc_test_and_set_running(task))
+			if (RPC_IS_QUEUED(task)) {
+				rpc_clear_running(task);
+				spin_unlock_bh(&queue->lock);
 				return 0;
+			}
+			spin_unlock_bh(&queue->lock);
 			continue;
 		}
+		rpc_clear_running(task);
+		spin_unlock_bh(&queue->lock);
 
 		/* sync task: sleep here */
 		dprintk("RPC: %4d sync task going to sleep\n", task->tk_pid);
