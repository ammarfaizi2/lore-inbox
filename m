Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316446AbSGGS6v>; Sun, 7 Jul 2002 14:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316465AbSGGS6u>; Sun, 7 Jul 2002 14:58:50 -0400
Received: from mons.uio.no ([129.240.130.14]:49877 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S316446AbSGGS6s>;
	Sun, 7 Jul 2002 14:58:48 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15656.36854.346705.165994@charged.uio.no>
Date: Sun, 7 Jul 2002 21:01:10 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.25 Clean up RPC receive code [part 2]
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  After getting rid of rpc_lock_task() from net/sunrpc/xprt.c (see the
previous patch), we can now remove it from the generic RPC queue
handling code.

Cheers,
  Trond

diff -u --recursive --new-file linux-2.5.25-rpc_rep/include/linux/sunrpc/sched.h linux-2.5.25-rpc_cleanup/include/linux/sunrpc/sched.h
--- linux-2.5.25-rpc_rep/include/linux/sunrpc/sched.h	Tue Feb 26 22:56:28 2002
+++ linux-2.5.25-rpc_cleanup/include/linux/sunrpc/sched.h	Sun Jul  7 17:48:20 2002
@@ -75,9 +75,7 @@
 	wait_queue_head_t	tk_wait;	/* sync: sleep on this q */
 	unsigned long		tk_timeout;	/* timeout for rpc_sleep() */
 	unsigned short		tk_flags;	/* misc flags */
-	unsigned short		tk_lock;	/* Task lock counter */
-	unsigned char		tk_active   : 1,/* Task has been activated */
-				tk_wakeup   : 1;/* Task waiting to wake up */
+	unsigned char		tk_active   : 1;/* Task has been activated */
 	unsigned long		tk_runstate;	/* Task run status */
 #ifdef RPC_DEBUG
 	unsigned short		tk_pid;		/* debugging aid */
@@ -181,15 +179,11 @@
 void		rpc_remove_wait_queue(struct rpc_task *);
 void		rpc_sleep_on(struct rpc_wait_queue *, struct rpc_task *,
 					rpc_action action, rpc_action timer);
-void		rpc_sleep_locked(struct rpc_wait_queue *, struct rpc_task *,
-				 rpc_action action, rpc_action timer);
 void		rpc_add_timer(struct rpc_task *, rpc_action);
 void		rpc_wake_up_task(struct rpc_task *);
 void		rpc_wake_up(struct rpc_wait_queue *);
 struct rpc_task *rpc_wake_up_next(struct rpc_wait_queue *);
 void		rpc_wake_up_status(struct rpc_wait_queue *, int);
-int		__rpc_lock_task(struct rpc_task *);
-void		rpc_unlock_task(struct rpc_task *);
 void		rpc_delay(struct rpc_task *, unsigned long);
 void *		rpc_allocate(unsigned int flags, unsigned int);
 void		rpc_free(void *);
diff -u --recursive --new-file linux-2.5.25-rpc_rep/net/sunrpc/sched.c linux-2.5.25-rpc_cleanup/net/sunrpc/sched.c
--- linux-2.5.25-rpc_rep/net/sunrpc/sched.c	Sat May  4 03:52:12 2002
+++ linux-2.5.25-rpc_cleanup/net/sunrpc/sched.c	Sun Jul  7 17:50:03 2002
@@ -73,7 +73,7 @@
  * Spinlock for wait queues. Access to the latter also has to be
  * interrupt-safe in order to allow timers to wake up sleeping tasks.
  */
-spinlock_t rpc_queue_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t rpc_queue_lock = SPIN_LOCK_UNLOCKED;
 /*
  * Spinlock for other critical sections of code.
  */
@@ -157,7 +157,7 @@
 void rpc_add_timer(struct rpc_task *task, rpc_action timer)
 {
 	spin_lock_bh(&rpc_queue_lock);
-	if (!(RPC_IS_RUNNING(task) || task->tk_wakeup))
+	if (!RPC_IS_RUNNING(task))
 		__rpc_add_timer(task, timer);
 	spin_unlock_bh(&rpc_queue_lock);
 }
@@ -358,27 +358,10 @@
 	spin_unlock_bh(&rpc_queue_lock);
 }
 
-void
-rpc_sleep_locked(struct rpc_wait_queue *q, struct rpc_task *task,
-		 rpc_action action, rpc_action timer)
-{
-	/*
-	 * Protect the queue operations.
-	 */
-	spin_lock_bh(&rpc_queue_lock);
-	__rpc_sleep_on(q, task, action, timer);
-	__rpc_lock_task(task);
-	spin_unlock_bh(&rpc_queue_lock);
-}
-
 /**
  * __rpc_wake_up_task - wake up a single rpc_task
  * @task: task to be woken up
  *
- * If the task is locked, it is merely removed from the queue, and
- * 'task->tk_wakeup' is set. rpc_unlock_task() will then ensure
- * that it is woken up as soon as the lock count goes to zero.
- *
  * Caller must hold rpc_queue_lock
  */
 static void
@@ -407,14 +390,6 @@
 	if (task->tk_rpcwait != &schedq)
 		__rpc_remove_wait_queue(task);
 
-	/* If the task has been locked, then set tk_wakeup so that
-	 * rpc_unlock_task() wakes us up... */
-	if (task->tk_lock) {
-		task->tk_wakeup = 1;
-		return;
-	} else
-		task->tk_wakeup = 0;
-
 	rpc_make_runnable(task);
 
 	dprintk("RPC:      __rpc_wake_up_task done\n");
@@ -502,30 +477,6 @@
 }
 
 /*
- * Lock down a sleeping task to prevent it from waking up
- * and disappearing from beneath us.
- *
- * This function should always be called with the
- * rpc_queue_lock held.
- */
-int
-__rpc_lock_task(struct rpc_task *task)
-{
-	if (!RPC_IS_RUNNING(task))
-		return ++task->tk_lock;
-	return 0;
-}
-
-void
-rpc_unlock_task(struct rpc_task *task)
-{
-	spin_lock_bh(&rpc_queue_lock);
-	if (task->tk_lock && !--task->tk_lock && task->tk_wakeup)
-		__rpc_wake_up_task(task);
-	spin_unlock_bh(&rpc_queue_lock);
-}
-
-/*
  * Run a task at a later time
  */
 static void	__rpc_atrun(struct rpc_task *);
@@ -707,15 +658,6 @@
 		spin_lock_bh(&rpc_queue_lock);
 
 		task_for_first(task, &schedq.tasks) {
-			if (task->tk_lock) {
-				spin_unlock_bh(&rpc_queue_lock);
-				printk(KERN_ERR "RPC: Locked task was scheduled !!!!\n");
-#ifdef RPC_DEBUG			
-				rpc_debug = ~0;
-				rpc_show_tasks();
-#endif			
-				break;
-			}
 			__rpc_remove_wait_queue(task);
 			spin_unlock_bh(&rpc_queue_lock);
 
