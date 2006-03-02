Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbWCBRpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbWCBRpU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 12:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbWCBRpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 12:45:19 -0500
Received: from pat.uio.no ([129.240.130.16]:5335 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751267AbWCBRpT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 12:45:19 -0500
Subject: Re: Deadlock in net/sunrpc/sched.c
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Simon Derr <Simon.Derr@bull.net>
Cc: linux-kernel@vger.kernel.org, FACCINI BRUNO <Bruno.Faccini@bull.net>
In-Reply-To: <Pine.LNX.4.61.0603021116030.15393@openx3.frec.bull.fr>
References: <Pine.LNX.4.61.0603021116030.15393@openx3.frec.bull.fr>
Content-Type: text/plain
Date: Thu, 02 Mar 2006 09:45:12 -0800
Message-Id: <1141321512.10398.13.camel@netapplinux-10.connectathon.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.807, required 12,
	autolearn=disabled, AWL 2.14, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-02 at 11:38 +0100, Simon Derr wrote:
> Hi,
> 
> My colleague Bruno Faccini has found a deadlock in the rpc wake up code.
> This happened with 2.6.12 but it seems that the code has not changed and 
> the issue is very probably still present in the current kernels.
> 
> I think what happens is this:
> 
> One process (A) enters rpc_wake_up_task().
>    It enters rpc_start_wakeup() and sets the RPC_TASK_WAKEUP bit.
> 
> #define rpc_start_wakeup(t) \
>         (test_and_set_bit(RPC_TASK_WAKEUP, &(t)->tk_runstate) == 0)
> 
> void rpc_wake_up_task(struct rpc_task *task)
> {
>         if (rpc_start_wakeup(task)) {
>                 if (RPC_IS_QUEUED(task)) {
>                         struct rpc_wait_queue *queue = task->u.tk_wait.rpc_waitq;
> 
>                         spin_lock_bh(&queue->lock);
>                         __rpc_do_wake_up_task(task);
>                         spin_unlock_bh(&queue->lock);
>                 }
>                 rpc_finish_wakeup(task);
>         }
> }
> 
> 
> Now an interrupt has occured on another CPU and process (B) enters 
> rpc_wake_up(). It takes the queue spinlock, and enters this `while' loop:
> 
> void rpc_wake_up(struct rpc_wait_queue *queue)
> {
>         struct rpc_task *task;
> 
>         struct list_head *head;
>         spin_lock_bh(&queue->lock);
>         head = &queue->tasks[queue->maxpriority];
>         for (;;) {
>                 while (!list_empty(head)) {
>                         task = list_entry(head->next, struct rpc_task, u.tk_wait.list);
>                         __rpc_wake_up_task(task);
>                 }
>                 if (head == &queue->tasks[0])
>                         break;
>                 head--;
>         }
>         spin_unlock_bh(&queue->lock);
> }
> 
> static void __rpc_wake_up_task(struct rpc_task *task)
> {
>         if (rpc_start_wakeup(task)) {
>                 if (RPC_IS_QUEUED(task))
>                         __rpc_do_wake_up_task(task);
>                 rpc_finish_wakeup(task);
>         }
> }
> 
> 
> Now to exit this loop, B needs to reach __rpc_do_wake_up_task() where a 
> list_del will occur. But for this the RPC_TASK_WAKEUP must be released by 
> process A, and this won't happen until process B releases the queue 
> spinlock. --> deadlock.

Could you see if this fixes it?

Cheers,
  Trond
-----------------------
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
SUNRPC: Fix potential deadlock in RPC code

In rpc_wake_up() and rpc_wake_up_status(), it is possible for the call to
__rpc_wake_up_task() to fail if another thread happens to be calling
rpc_wake_up_task() on the same rpc_task.

Problem noticed by Bruno Faccini.

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 net/sunrpc/sched.c |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index a04cf3b..cd51b54 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -517,16 +517,14 @@ struct rpc_task * rpc_wake_up_next(struc
  */
 void rpc_wake_up(struct rpc_wait_queue *queue)
 {
-	struct rpc_task *task;
-
+	struct rpc_task *task, *next;
 	struct list_head *head;
+
 	spin_lock_bh(&queue->lock);
 	head = &queue->tasks[queue->maxpriority];
 	for (;;) {
-		while (!list_empty(head)) {
-			task = list_entry(head->next, struct rpc_task, u.tk_wait.list);
+		list_for_each_entry_safe(task, next, head, u.tk_wait.list)
 			__rpc_wake_up_task(task);
-		}
 		if (head == &queue->tasks[0])
 			break;
 		head--;
@@ -543,14 +541,13 @@ void rpc_wake_up(struct rpc_wait_queue *
  */
 void rpc_wake_up_status(struct rpc_wait_queue *queue, int status)
 {
+	struct rpc_task *task, *next;
 	struct list_head *head;
-	struct rpc_task *task;
 
 	spin_lock_bh(&queue->lock);
 	head = &queue->tasks[queue->maxpriority];
 	for (;;) {
-		while (!list_empty(head)) {
-			task = list_entry(head->next, struct rpc_task, u.tk_wait.list);
+		list_for_each_entry_safe(task, next, head, u.tk_wait.list) {
 			task->tk_status = status;
 			__rpc_wake_up_task(task);
 		}


