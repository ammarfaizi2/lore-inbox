Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbWCIKgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWCIKgc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 05:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751806AbWCIKgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 05:36:32 -0500
Received: from cirse.extra.cea.fr ([132.166.172.102]:27292 "EHLO
	cirse.extra.cea.fr") by vger.kernel.org with ESMTP id S1751797AbWCIKgb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 05:36:31 -0500
Message-Id: <200603091035.LAA04829@styx.bruyeres.cea.fr>
Date: Thu, 09 Mar 2006 11:35:21 +0100
From: Aurelien Degremont <aurelien.degremont@cea.fr>
User-Agent: Mozilla Thunderbird 1.0.6-1.4.1 (X11/20050719)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Jacques-Charles Lafoucriere <jc.lafoucriere@cea.fr>,
       Bruno Faccini <bruno.faccini@bull.net>, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix deadlock in RPC scheduling code.
Content-Type: multipart/mixed;
 boundary="------------010601080205090701070907"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010601080205090701070907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Here is a small patch which fixes a deadlock issue in RPC scheduling
code (rpc_wake_up_task() is mainly concerned). This problem happens if a
RPC task, waiting for the response of a sync request, is woken up by a
signal, and, in the same time, the kernel tries to wake up some RPC
tasks. If this is done, a deadlock could occurs due to an error in RPC
workqueue lock management.

This error was added by linux-2.6.8.1-49-rpc_workqueue.patch (included
in 2.6.11). This code was not changed since. The issue was detected on
linux-2.6.12.


**DESCRIPTION**

This deadlock is due to the wrong management of two locks: queue->lock
and the bit RPC_TASK_WAKEUP in task->tk_runstate.
When dealing with RPC workqueues, the code must take care of locking the
associated queue lock before doing any modifications on it or its tasks.
And it does it... except for one function. Nested locks should always be
taken in the same order.

As a consequence, in some circumstances (in fact, I noticed it several
times), this code deadlocks. Moreover, when this code is called, by
example by nfs_file_flush(), the lock_kernel() is held and so all the
system hangs.


**PATCH**

To fix the problem, we only need to invert the lock hierarchy in
rpc_wake_up_task() and taking care of checking the task is really queued
before trying to grab the lock.

This code becomes :

void rpc_wake_up_task(struct rpc_task *task)
{
           struct rpc_wait_queue *queue = NULL;


           /*
            * The task must always be queued because __rpc_do_wake_up_task()
            * modify it.
            */
           if (RPC_IS_QUEUED(task)) {


                   /*
                    * The queue lock must be taken BEFORE rpc_start_wakeup()
                    * is called.
                    */
                   queue = task->u.tk_wait.rpc_waitq;
                   spin_lock_bh(&queue->lock);


                   /* Really wake up the specified RPC task */
                   if (rpc_start_wakeup(task)) {
                           __rpc_do_wake_up_task(task);
                           rpc_finish_wakeup(task);
                   }


                   spin_unlock_bh(&queue->lock);
           }
}

This patch was done with version 2.6.15.4. It works correctly with
2.6.15.6.


**NOTES**

"The smaller the patch is, the better it is". So I kept it short. But,
in fact, I think the groups of functions rpc_wake_up_task(),
__rpc_wake_up_task() and __rpc_do_wake_up_task() could be simplified.


**AUTHORS**

The bug was worked out by Bruno Faccini bruno(dot)faccini(at)bull(dot)net
I did the corresponding patch.

-- 
Aurelien Degremont



--------------010601080205090701070907
Content-Type: text/x-patch;
 name="rpc_deadlock-2.6.15.6.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rpc_deadlock-2.6.15.6.patch"

--- linux-2.6.15.4/net/sunrpc/sched.c.orig	2006-03-08 16:54:36.515804799 +0100
+++ linux-2.6.15.4/net/sunrpc/sched.c		2006-03-08 17:00:37.724637607 +0100
@@ -353,7 +353,7 @@
  */
 static void __rpc_do_wake_up_task(struct rpc_task *task)
 {
-	dprintk("RPC: %4d __rpc_wake_up_task (now %ld)\n", task->tk_pid, jiffies);
+	dprintk("RPC: %4d __rpc_do_wake_up_task (now %ld)\n", task->tk_pid, jiffies);
 
 #ifdef RPC_DEBUG
 	BUG_ON(task->tk_magic != RPC_TASK_MAGIC_ID);
@@ -369,7 +369,7 @@
 
 	rpc_make_runnable(task);
 
-	dprintk("RPC:      __rpc_wake_up_task done\n");
+	dprintk("RPC:      __rpc_do_wake_up_task done\n");
 }
 
 /*
@@ -400,15 +400,28 @@
  */
 void rpc_wake_up_task(struct rpc_task *task)
 {
-	if (rpc_start_wakeup(task)) {
-		if (RPC_IS_QUEUED(task)) {
-			struct rpc_wait_queue *queue = task->u.tk_wait.rpc_waitq;
+	struct rpc_wait_queue *queue = NULL;
+
+	/* 
+	 * The task must always be queued because __rpc_do_wake_up_task() 
+	 * modify it.
+	 */
+	if (RPC_IS_QUEUED(task)) {
 
-			spin_lock_bh(&queue->lock);
+		/* 
+		 * The queue lock must be taken BEFORE rpc_start_wakeup() 
+		 * is called.
+		 */
+		queue = task->u.tk_wait.rpc_waitq;
+		spin_lock_bh(&queue->lock);
+	
+		/* Really wake up the specified RPC task */
+		if (rpc_start_wakeup(task)) {
 			__rpc_do_wake_up_task(task);
-			spin_unlock_bh(&queue->lock);
+			rpc_finish_wakeup(task);
 		}
-		rpc_finish_wakeup(task);
+		
+		spin_unlock_bh(&queue->lock);
 	}
 }
 



--------------010601080205090701070907--
