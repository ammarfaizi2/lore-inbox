Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129313AbQJaPhN>; Tue, 31 Oct 2000 10:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129166AbQJaPgy>; Tue, 31 Oct 2000 10:36:54 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:52989 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129032AbQJaPgk>; Tue, 31 Oct 2000 10:36:40 -0500
Message-ID: <39FEE701.CAC21AE5@uow.edu.au>
Date: Wed, 01 Nov 2000 02:36:33 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: kumon@flab.fujitsu.co.jp
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Negative scalability by removal of lock_kernel()?(Was: 
 Strange performance behavior of 2.4.0-test9)
In-Reply-To: <39F957BC.4289FF10@uow.edu.au>,
		<39F92187.A7621A09@timpanogas.org>
		<Pine.GSO.4.21.0010270257550.18660-100000@weyl.math.psu.edu>
		<20001027094613.A18382@gruyere.muc.suse.de>
		<39F957BC.4289FF10@uow.edu.au> <200010271257.VAA24374@asami.proc.flab.fujitsu.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kouichi,

how many Apache processes are you running? MaxSpareServers?

This patch is a moderate rewrite of __wake_up_common.  I'd be
interested in seeing how much difference it makes to the
performance of Apache when the file-locking serialisation is
disabled.

- It implements last-in/first-out semantics for waking
  TASK_EXCLUSIVE tasks.

- It fixes what was surely a bug wherein __wake_up_common
  scans the entire wait queue even when it has found the
  task which it wants to run.

On a dual-CPU box it dramatically increases the max connection
rate when there are a large number of waiters:

#waiters        conn/sec (t10-p5+patch)     conn/sec (t10-p5)
    30              5525                      4990
   100              5700                      4100
  1000              5600                      1500

This will be due entirely to the queue scanning fix - my
test app has a negligible cache footprint.

It's stable, but it's a work-in-progress.

- __wake_up_common does a fair amount of SMP-specific
  stuff when compiled for UP which needs sorting out

- it seems there's somebody in the networking code who
  changes a task state incorrectly when it's on a wait
  queue. This used to be OK, but it's not OK now that
  I'm relying upon the wait queue being in the state
  which it should be.

Thanks.



--- linux-2.4.0-test10-pre5/kernel/sched.c	Sun Oct 15 01:27:46 2000
+++ linux-akpm/kernel/sched.c	Wed Nov  1 01:54:44 2000
@@ -697,6 +697,53 @@
 	return;
 }
 
+#if WAITQUEUE_DEBUG
+/*
+ * Check that the wait queue is in the correct order:
+ *  !TASK_EXCLUSIVE at the head
+ *  TASK_EXCLUSIVE at the tail
+ *  The list is locked.
+ */
+
+static void check_wq_sanity(wait_queue_head_t *q)
+{
+	struct list_head *probe, *head;
+
+	head = &q->task_list;
+	probe = head->next;
+	while (probe != head) {
+		wait_queue_t *curr = list_entry(probe, wait_queue_t, task_list);
+		if (curr->task->state & TASK_EXCLUSIVE)
+			break;
+		probe = probe->next;
+	}
+	while (probe != head) {
+		wait_queue_t *curr = list_entry(probe, wait_queue_t, task_list);
+		if (!(curr->task->state & TASK_EXCLUSIVE)) {
+			printk("check_wq_sanity: mangled wait queue\n");
+#ifdef CONFIG_X86
+			show_stack(0);
+#endif
+			break;
+		}
+		probe = probe->next;
+	}
+}
+#endif	/* WAITQUEUE_DEBUG */
+	
+/*
+ * Wake up some tasks which are on *q.
+ *
+ * All tasks which are !TASK_EXCLUSIVE are woken.
+ * Only one TASK_EXCLUSIVE task is woken.
+ * The !TASK_EXCLUSIVE tasks start at q->task_list.next
+ * The TASK_EXCLUSIVE tasks start at q->task_list.prev
+ *
+ * When waking a TASK_EXCLUSIVE task we search backward,
+ * so we find the most-recently-added task (it will have the
+ * hottest cache)
+ */
+
 static inline void __wake_up_common (wait_queue_head_t *q, unsigned int mode,
 						const int sync)
 {
@@ -714,6 +761,7 @@
 	wq_write_lock_irqsave(&q->lock, flags);
 
 #if WAITQUEUE_DEBUG
+	check_wq_sanity(q);
 	CHECK_MAGIC_WQHEAD(q);
 #endif
 
@@ -722,6 +770,11 @@
         if (!head->next || !head->prev)
                 WQ_BUG();
 #endif
+
+	/*
+	 * if (mode & TASK_EXCLUSIVE) Wake all the !TASK_EXCLUSIVE tasks 
+	 * if !(mode & TASK_EXCLUSIVE) Wake all the tasks
+	 */
 	tmp = head->next;
 	while (tmp != head) {
 		unsigned int state;
@@ -734,40 +787,69 @@
 #endif
 		p = curr->task;
 		state = p->state;
+		if (state & mode & TASK_EXCLUSIVE)
+			break;			/* Finished all !TASK_EXCLUSIVEs */
 		if (state & (mode & ~TASK_EXCLUSIVE)) {
 #if WAITQUEUE_DEBUG
 			curr->__waker = (long)__builtin_return_address(0);
 #endif
-			/*
-			 * If waking up from an interrupt context then
-			 * prefer processes which are affine to this
-			 * CPU.
-			 */
-			if (irq && (state & mode & TASK_EXCLUSIVE)) {
+			if (sync)
+				wake_up_process_synchronous(p);
+			else
+				wake_up_process(p);
+		}
+	}
+
+	/*
+	 * Now wake one TASK_EXCLUSIVE task.
+	 */
+	if (mode & TASK_EXCLUSIVE) {
+		tmp = head->prev;
+		while (tmp != head) {
+			unsigned int state;
+	                wait_queue_t *curr = list_entry(tmp, wait_queue_t, task_list);
+			
+			tmp = tmp->prev;
+#if WAITQUEUE_DEBUG
+			CHECK_MAGIC(curr->__magic);
+#endif
+			p = curr->task;
+			state = p->state;
+			if (!(state & TASK_EXCLUSIVE))
+				break;		/* Exhausted all TASK_EXCLUSIVEs */
+
+			if (state & mode) {
+				/*
+				 * If waking up from an interrupt context then
+				 * prefer processes which are affine to this
+				 * CPU.
+				 */
 				if (!best_exclusive)
 					best_exclusive = p;
-				else if ((p->processor == best_cpu) &&
-					(best_exclusive->processor != best_cpu))
+				if (irq) {
+					if (p->processor == best_cpu) {
 						best_exclusive = p;
-			} else {
-				if (sync)
-					wake_up_process_synchronous(p);
-				else
-					wake_up_process(p);
-				if (state & mode & TASK_EXCLUSIVE)
+						break;
+					}
+				} else {
 					break;
+				}
 			}
 		}
-	}
-	if (best_exclusive)
-		best_exclusive->state = TASK_RUNNING;
-	wq_write_unlock_irqrestore(&q->lock, flags);
-
-	if (best_exclusive) {
-		if (sync)
-			wake_up_process_synchronous(best_exclusive);
-		else
-			wake_up_process(best_exclusive);
+
+		if (best_exclusive)
+			best_exclusive->state = TASK_RUNNING;
+
+		wq_write_unlock_irqrestore(&q->lock, flags);
+
+		if (best_exclusive) {
+			if (sync)
+				wake_up_process_synchronous(best_exclusive);
+			else
+				wake_up_process(best_exclusive);
+		}
+	} else {
+		wq_write_unlock_irqrestore(&q->lock, flags);
 	}
 out:
 	return;
--- linux-2.4.0-test10-pre5/kernel/fork.c	Sat Sep  9 16:19:30 2000
+++ linux-akpm/kernel/fork.c	Wed Nov  1 02:08:00 2000
@@ -39,6 +39,14 @@
 	unsigned long flags;
 
 	wq_write_lock_irqsave(&q->lock, flags);
+#if WAITQUEUE_DEBUG
+	if (wait->task.state & TASK_EXCLUSIVE) {
+		printk("add_wait_queue: exclusive task added at head!\n");
+#ifdef CONFIG_X86
+		show_stack(0);
+#endif
+	}
+#endif
 	__add_wait_queue(q, wait);
 	wq_write_unlock_irqrestore(&q->lock, flags);
 }
@@ -48,6 +56,14 @@
 	unsigned long flags;
 
 	wq_write_lock_irqsave(&q->lock, flags);
+#if WAITQUEUE_DEBUG
+	if (!(wait->task.state & TASK_EXCLUSIVE)) {
+		printk("add_wait_queue: non-exclusive task added at tail!\n");
+#ifdef CONFIG_X86
+		show_stack(0);
+#endif
+	}
+#endif
 	__add_wait_queue_tail(q, wait);
 	wq_write_unlock_irqrestore(&q->lock, flags);
 }
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
