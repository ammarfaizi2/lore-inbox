Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315225AbSEIXTW>; Thu, 9 May 2002 19:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315230AbSEIXTV>; Thu, 9 May 2002 19:19:21 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:44228 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315225AbSEIXTT>;
	Thu, 9 May 2002 19:19:19 -0400
Date: Thu, 9 May 2002 16:18:21 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: rwhron@earthlink.net, mingo@elte.hu, gh@us.ibm.com,
        linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: O(1) scheduler gives big boost to tbench 192
Message-ID: <20020509161821.K1516@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <20020503093856.A27263@rushmore> <20020507151356.A18701@w-mikek.des.beaverton.ibm.com> <20020508105049.A31998@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2002 at 10:50:49AM +0200, Andrea Arcangeli wrote:
> 
> I would like if you could pass over your changes to the O(1) scheduler
> to resurrect the sync-wakeup.
> 

Here is a patch to reintroduce __wake_up_sync() in 2.5.14.
It would be interesting to see if this helps in some of the
areas where people have seen a drop in performance.  Since,
'full pipes' are the only users of this code, I would only
expect to see benefit in workloads expecting high pipe
bandwidth.

Let me know what you think.

-- 
Mike

diff -Naur linux-2.5.14/fs/pipe.c linux-2.5.14-pipe/fs/pipe.c
--- linux-2.5.14/fs/pipe.c	Mon May  6 03:37:52 2002
+++ linux-2.5.14-pipe/fs/pipe.c	Wed May  8 22:48:39 2002
@@ -116,7 +116,7 @@
 		 * writers synchronously that there is more
 		 * room.
 		 */
-		wake_up_interruptible(PIPE_WAIT(*inode));
+		wake_up_interruptible_sync(PIPE_WAIT(*inode));
 		if (!PIPE_EMPTY(*inode))
 			BUG();
 		goto do_more_read;
diff -Naur linux-2.5.14/include/linux/sched.h linux-2.5.14-pipe/include/linux/sched.h
--- linux-2.5.14/include/linux/sched.h	Mon May  6 03:37:54 2002
+++ linux-2.5.14-pipe/include/linux/sched.h	Thu May  9 20:47:19 2002
@@ -485,6 +485,11 @@
 #define wake_up_interruptible(x)	__wake_up((x),TASK_INTERRUPTIBLE, 1)
 #define wake_up_interruptible_nr(x, nr)	__wake_up((x),TASK_INTERRUPTIBLE, nr)
 #define wake_up_interruptible_all(x)	__wake_up((x),TASK_INTERRUPTIBLE, 0)
+#ifdef CONFIG_SMP
+#define wake_up_interruptible_sync(x)   __wake_up_sync((x),TASK_INTERRUPTIBLE, 1)
+#else
+#define wake_up_interruptible_sync(x)   __wake_up((x),TASK_INTERRUPTIBLE, 1)
+#endif
 asmlinkage long sys_wait4(pid_t pid,unsigned int * stat_addr, int options, struct rusage * ru);
 
 extern int in_group_p(gid_t);
diff -Naur linux-2.5.14/kernel/sched.c linux-2.5.14-pipe/kernel/sched.c
--- linux-2.5.14/kernel/sched.c	Mon May  6 03:37:57 2002
+++ linux-2.5.14-pipe/kernel/sched.c	Thu May  9 21:04:13 2002
@@ -329,27 +329,38 @@
  * "current->state = TASK_RUNNING" to mark yourself runnable
  * without the overhead of this.
  */
-static int try_to_wake_up(task_t * p)
+static int try_to_wake_up(task_t * p, int sync)
 {
 	unsigned long flags;
 	int success = 0;
 	runqueue_t *rq;
 
+repeat_lock_task:
 	rq = task_rq_lock(p, &flags);
-	p->state = TASK_RUNNING;
 	if (!p->array) {
+		if (unlikely(sync)) {
+			if (p->thread_info->cpu != smp_processor_id()) {
+				p->thread_info->cpu = smp_processor_id();
+				task_rq_unlock(rq, &flags);
+				goto repeat_lock_task;
+			}
+		}
 		activate_task(p, rq);
+		/*
+		 * If sync is set, a resched_task() is a NOOP
+		 */
 		if (p->prio < rq->curr->prio)
 			resched_task(rq->curr);
 		success = 1;
 	}
+	p->state = TASK_RUNNING;
 	task_rq_unlock(rq, &flags);
 	return success;
 }
 
 int wake_up_process(task_t * p)
 {
-	return try_to_wake_up(p);
+	return try_to_wake_up(p, 0);
 }
 
 void wake_up_forked_process(task_t * p)
@@ -872,7 +883,7 @@
  * started to run but is not in state TASK_RUNNING.  try_to_wake_up() returns
  * zero in this (rare) case, and we handle it by continuing to scan the queue.
  */
-static inline void __wake_up_common(wait_queue_head_t *q, unsigned int mode, int nr_exclusive)
+static inline void __wake_up_common(wait_queue_head_t *q, unsigned int mode, int nr_exclusive, int sync)
 {
 	struct list_head *tmp;
 	unsigned int state;
@@ -883,7 +894,7 @@
 		curr = list_entry(tmp, wait_queue_t, task_list);
 		p = curr->task;
 		state = p->state;
-		if ((state & mode) && try_to_wake_up(p) &&
+		if ((state & mode) && try_to_wake_up(p, sync) &&
 			((curr->flags & WQ_FLAG_EXCLUSIVE) && !--nr_exclusive))
 				break;
 	}
@@ -897,7 +908,22 @@
 		return;
 
 	wq_read_lock_irqsave(&q->lock, flags);
-	__wake_up_common(q, mode, nr_exclusive);
+	__wake_up_common(q, mode, nr_exclusive, 0);
+	wq_read_unlock_irqrestore(&q->lock, flags);
+}
+
+void __wake_up_sync(wait_queue_head_t *q, unsigned int mode, int nr_exclusive)
+{
+	unsigned long flags;
+
+	if (unlikely(!q))
+		return;
+
+	wq_read_lock_irqsave(&q->lock, flags);
+	if (likely(nr_exclusive))
+		__wake_up_common(q, mode, nr_exclusive, 1);
+	else
+		__wake_up_common(q, mode, nr_exclusive, 0);
 	wq_read_unlock_irqrestore(&q->lock, flags);
 }
 
@@ -907,7 +933,7 @@
 
 	spin_lock_irqsave(&x->wait.lock, flags);
 	x->done++;
-	__wake_up_common(&x->wait, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 1);
+	__wake_up_common(&x->wait, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 1, 0);
 	spin_unlock_irqrestore(&x->wait.lock, flags);
 }
 
