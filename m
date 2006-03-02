Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751981AbWCBKiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981AbWCBKiO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 05:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751982AbWCBKiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 05:38:14 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:60901 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1751981AbWCBKiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 05:38:13 -0500
Date: Thu, 2 Mar 2006 11:38:10 +0100 (CET)
From: Simon Derr <Simon.Derr@bull.net>
X-X-Sender: derrs@openx3.frec.bull.fr
To: linux-kernel@vger.kernel.org
Cc: FACCINI BRUNO <Bruno.Faccini@bull.net>
Subject: Deadlock in net/sunrpc/sched.c
Message-ID: <Pine.LNX.4.61.0603021116030.15393@openx3.frec.bull.fr>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 02/03/2006 11:39:40,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 02/03/2006 11:39:42,
	Serialize complete at 02/03/2006 11:39:42
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

My colleague Bruno Faccini has found a deadlock in the rpc wake up code.
This happened with 2.6.12 but it seems that the code has not changed and 
the issue is very probably still present in the current kernels.

I think what happens is this:

One process (A) enters rpc_wake_up_task().
   It enters rpc_start_wakeup() and sets the RPC_TASK_WAKEUP bit.

#define rpc_start_wakeup(t) \
        (test_and_set_bit(RPC_TASK_WAKEUP, &(t)->tk_runstate) == 0)

void rpc_wake_up_task(struct rpc_task *task)
{
        if (rpc_start_wakeup(task)) {
                if (RPC_IS_QUEUED(task)) {
                        struct rpc_wait_queue *queue = task->u.tk_wait.rpc_waitq;

                        spin_lock_bh(&queue->lock);
                        __rpc_do_wake_up_task(task);
                        spin_unlock_bh(&queue->lock);
                }
                rpc_finish_wakeup(task);
        }
}


Now an interrupt has occured on another CPU and process (B) enters 
rpc_wake_up(). It takes the queue spinlock, and enters this `while' loop:

void rpc_wake_up(struct rpc_wait_queue *queue)
{
        struct rpc_task *task;

        struct list_head *head;
        spin_lock_bh(&queue->lock);
        head = &queue->tasks[queue->maxpriority];
        for (;;) {
                while (!list_empty(head)) {
                        task = list_entry(head->next, struct rpc_task, u.tk_wait.list);
                        __rpc_wake_up_task(task);
                }
                if (head == &queue->tasks[0])
                        break;
                head--;
        }
        spin_unlock_bh(&queue->lock);
}

static void __rpc_wake_up_task(struct rpc_task *task)
{
        if (rpc_start_wakeup(task)) {
                if (RPC_IS_QUEUED(task))
                        __rpc_do_wake_up_task(task);
                rpc_finish_wakeup(task);
        }
}


Now to exit this loop, B needs to reach __rpc_do_wake_up_task() where a 
list_del will occur. But for this the RPC_TASK_WAKEUP must be released by 
process A, and this won't happen until process B releases the queue 
spinlock. --> deadlock.


A possible fix would be to take the spinlock earlier in rpc_wake_up_task():



Signed-off-by: Simon.Derr@bull.net
Signed-off-by: Bruno.Faccini@bull.net

Index: linux-2.6.12.6/net/sunrpc/sched.c
===================================================================
--- linux-2.6.12.6.orig/net/sunrpc/sched.c	2005-08-29 18:55:27.000000000 +0200
+++ linux-2.6.12.6/net/sunrpc/sched.c	2006-03-02 11:10:38.000000000 +0100
@@ -400,16 +400,16 @@ __rpc_default_timer(struct rpc_task *tas
  */
 void rpc_wake_up_task(struct rpc_task *task)
 {
+	spin_lock_bh(&queue->lock);
 	if (rpc_start_wakeup(task)) {
 		if (RPC_IS_QUEUED(task)) {
 			struct rpc_wait_queue *queue = task->u.tk_wait.rpc_waitq;
 
-			spin_lock_bh(&queue->lock);
 			__rpc_do_wake_up_task(task);
-			spin_unlock_bh(&queue->lock);
 		}
 		rpc_finish_wakeup(task);
 	}
+	spin_unlock_bh(&queue->lock);
 }
 
 /*
