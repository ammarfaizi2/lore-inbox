Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129309AbQKREYT>; Fri, 17 Nov 2000 23:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130645AbQKREYJ>; Fri, 17 Nov 2000 23:24:09 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:18844 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129309AbQKREXd>; Fri, 17 Nov 2000 23:23:33 -0500
Message-ID: <3A15FD4E.B11875BE@uow.edu.au>
Date: Sat, 18 Nov 2000 14:53:50 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] semaphore optimisation
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch modestly improves the scalability and straight-line
performance of x86 semaphores by removing the semaphore_lock and using
the per-semaphore lock instead.  If removes several spinlock operations
and allows concurrent operations on separate semaphores.

No bugs were harmed in the preparation of this patch.  It's just me
fartarsing aound.




--- linux-2.4.0-test11-pre7/include/linux/sched.h	Sat Nov 18 13:55:32 2000
+++ linux-akpm/include/linux/sched.h	Sat Nov 18 14:42:26 2000
@@ -535,6 +535,7 @@
 #define CURRENT_TIME (xtime.tv_sec)
 
 extern void FASTCALL(__wake_up(wait_queue_head_t *q, unsigned int mode, unsigned int wq_mode));
+extern void FASTCALL(____wake_up(wait_queue_head_t *q, unsigned int mode, unsigned int wq_mode));
 extern void FASTCALL(__wake_up_sync(wait_queue_head_t *q, unsigned int mode, unsigned int wq_mode));
 extern void FASTCALL(sleep_on(wait_queue_head_t *q));
 extern long FASTCALL(sleep_on_timeout(wait_queue_head_t *q,
--- linux-2.4.0-test11-pre7/include/linux/wait.h	Sat Nov 18 13:55:32 2000
+++ linux-akpm/include/linux/wait.h	Sat Nov 18 14:42:26 2000
@@ -72,6 +72,7 @@
 # define wq_read_unlock_irqrestore read_unlock_irqrestore
 # define wq_read_unlock read_unlock
 # define wq_write_lock_irq write_lock_irq
+# define wq_write_unlock_irq write_unlock_irq
 # define wq_write_lock_irqsave write_lock_irqsave
 # define wq_write_unlock_irqrestore write_unlock_irqrestore
 # define wq_write_unlock write_unlock
@@ -84,6 +85,7 @@
 # define wq_read_unlock spin_unlock
 # define wq_read_unlock_irqrestore spin_unlock_irqrestore
 # define wq_write_lock_irq spin_lock_irq
+# define wq_write_unlock_irq spin_unlock_irq
 # define wq_write_lock_irqsave spin_lock_irqsave
 # define wq_write_unlock_irqrestore spin_unlock_irqrestore
 # define wq_write_unlock spin_unlock
--- linux-2.4.0-test11-pre7/arch/i386/kernel/semaphore.c	Sat Nov 18 13:55:28 2000
+++ linux-akpm/arch/i386/kernel/semaphore.c	Sat Nov 18 14:42:26 2000
@@ -53,16 +53,15 @@
 	wake_up(&sem->wait);
 }
 
-static spinlock_t semaphore_lock = SPIN_LOCK_UNLOCKED;
-
 void __down(struct semaphore * sem)
 {
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
-	tsk->state = TASK_UNINTERRUPTIBLE;
-	add_wait_queue_exclusive(&sem->wait, &wait);
 
-	spin_lock_irq(&semaphore_lock);
+	tsk->state = TASK_UNINTERRUPTIBLE;
+	wq_write_lock_irq(&sem->wait.lock);
+	wait.flags = WQ_FLAG_EXCLUSIVE;
+	__add_wait_queue_tail(&sem->wait, &wait);
 	sem->sleepers++;
 	for (;;) {
 		int sleepers = sem->sleepers;
@@ -76,14 +75,14 @@
 			break;
 		}
 		sem->sleepers = 1;	/* us - see -1 above */
-		spin_unlock_irq(&semaphore_lock);
+		wq_write_unlock_irq(&sem->wait.lock);
 
 		schedule();
 		tsk->state = TASK_UNINTERRUPTIBLE;
-		spin_lock_irq(&semaphore_lock);
+		wq_write_lock_irq(&sem->wait.lock);
 	}
-	spin_unlock_irq(&semaphore_lock);
-	remove_wait_queue(&sem->wait, &wait);
+	__remove_wait_queue(&sem->wait, &wait);
+	wq_write_unlock_irq(&sem->wait.lock);
 	tsk->state = TASK_RUNNING;
 	wake_up(&sem->wait);
 }
@@ -93,10 +92,11 @@
 	int retval = 0;
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
-	tsk->state = TASK_INTERRUPTIBLE;
-	add_wait_queue_exclusive(&sem->wait, &wait);
 
-	spin_lock_irq(&semaphore_lock);
+	tsk->state = TASK_INTERRUPTIBLE;
+	wq_write_lock_irq(&sem->wait.lock);
+	wait.flags = WQ_FLAG_EXCLUSIVE;
+	__add_wait_queue_tail(&sem->wait, &wait);
 	sem->sleepers ++;
 	for (;;) {
 		int sleepers = sem->sleepers;
@@ -126,15 +126,15 @@
 			break;
 		}
 		sem->sleepers = 1;	/* us - see -1 above */
-		spin_unlock_irq(&semaphore_lock);
+		wq_write_unlock_irq(&sem->wait.lock);
 
 		schedule();
 		tsk->state = TASK_INTERRUPTIBLE;
-		spin_lock_irq(&semaphore_lock);
+		wq_write_lock_irq(&sem->wait.lock);
 	}
-	spin_unlock_irq(&semaphore_lock);
+	__remove_wait_queue(&sem->wait, &wait);
+	wq_write_unlock_irq(&sem->wait.lock);
 	tsk->state = TASK_RUNNING;
-	remove_wait_queue(&sem->wait, &wait);
 	wake_up(&sem->wait);
 	return retval;
 }
@@ -152,7 +152,7 @@
 	int sleepers;
 	unsigned long flags;
 
-	spin_lock_irqsave(&semaphore_lock, flags);
+	wq_write_lock_irqsave(&sem->wait.lock, flags);
 	sleepers = sem->sleepers + 1;
 	sem->sleepers = 0;
 
@@ -161,9 +161,9 @@
 	 * playing, because we own the spinlock.
 	 */
 	if (!atomic_add_negative(sleepers, &sem->count))
-		wake_up(&sem->wait);
+		____wake_up(&sem->wait, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, WQ_FLAG_EXCLUSIVE);
 
-	spin_unlock_irqrestore(&semaphore_lock, flags);
+	wq_write_unlock_irqrestore(&sem->wait.lock, flags);
 	return 1;
 }
 
--- linux-2.4.0-test11-pre7/kernel/sched.c	Sat Nov 18 13:55:32 2000
+++ linux-akpm/kernel/sched.c	Sat Nov 18 14:42:26 2000
@@ -700,7 +700,7 @@
 }
 
 static inline void __wake_up_common (wait_queue_head_t *q, unsigned int mode,
-				     unsigned int wq_mode, const int sync)
+				     unsigned int wq_mode, const int sync, const int do_locking)
 {
 	struct list_head *tmp, *head;
 	struct task_struct *p, *best_exclusive;
@@ -713,7 +713,8 @@
 	best_cpu = smp_processor_id();
 	irq = in_interrupt();
 	best_exclusive = NULL;
-	wq_write_lock_irqsave(&q->lock, flags);
+	if (do_locking)
+		wq_write_lock_irqsave(&q->lock, flags);
 
 #if WAITQUEUE_DEBUG
 	CHECK_MAGIC_WQHEAD(q);
@@ -768,19 +769,25 @@
 		else
 			wake_up_process(best_exclusive);
 	}
-	wq_write_unlock_irqrestore(&q->lock, flags);
+	if (do_locking)
+		wq_write_unlock_irqrestore(&q->lock, flags);
 out:
 	return;
 }
 
 void __wake_up(wait_queue_head_t *q, unsigned int mode, unsigned int wq_mode)
 {
-	__wake_up_common(q, mode, wq_mode, 0);
+	__wake_up_common(q, mode, wq_mode, 0, 1);
+}
+
+void ____wake_up(wait_queue_head_t *q, unsigned int mode, unsigned int wq_mode)
+{
+	__wake_up_common(q, mode, wq_mode, 0, 0);
 }
 
 void __wake_up_sync(wait_queue_head_t *q, unsigned int mode, unsigned int wq_mode)
 {
-	__wake_up_common(q, mode, wq_mode, 1);
+	__wake_up_common(q, mode, wq_mode, 1, 1);
 }
 
 #define	SLEEP_ON_VAR				\
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
