Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313323AbSC2Ayr>; Thu, 28 Mar 2002 19:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313324AbSC2Ayi>; Thu, 28 Mar 2002 19:54:38 -0500
Received: from air-2.osdl.org ([65.201.151.6]:19725 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S313323AbSC2Ayb>;
	Thu, 28 Mar 2002 19:54:31 -0500
Date: Thu, 28 Mar 2002 16:54:20 -0800
From: Bob Miller <rem@osdl.org>
To: davej@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.7-dj2 remove global semaphore_lock spin lock.
Message-ID: <20020328165420.A11479@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Difference from 2.5.7-dj1: folded in review comments to inline the functions
add_wait_queue_exclusive_locked() and remove_wait_queue_locked().

Below is a patch for i386 that replaces the global spin lock semaphore_lock,
with the rwlock_t embedded in the wait_queue_head_t in the struct semaphore.

None of the data protected by semaphore_lock lock is global and there is
no need to restrict the system to only allow one semaphore to be dealt with
at a time.

This removes 2 lock round trips from __down() and __down_interruptible().
It also reduces the number the cache lines touched by 1 (i.e.: cache line with
semaphore_lock).

This work has only been done for i386 because that is the only arch I have
access to for testing.  The same changes could be applied to arm, ia64, s390,
s390x and sparc if requested.

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17


diff -ru linux-2.5.7-dj2-orig/arch/i386/kernel/semaphore.c linux-2.5.7-dj2-sema/arch/i386/kernel/semaphore.c
--- linux-2.5.7-dj2-orig/arch/i386/kernel/semaphore.c	Mon Mar 18 12:37:13 2002
+++ linux-2.5.7-dj2-sema/arch/i386/kernel/semaphore.c	Thu Mar 28 14:04:34 2002
@@ -29,7 +29,8 @@
  * the increment operation.
  *
  * "sleeping" and the contention routine ordering is
- * protected by the semaphore spinlock.
+ * protected by the read/write lock in the semaphore's
+ * waitqueue head.
  *
  * Note that these functions are only called when there is
  * contention on the lock, and as such all this is the
@@ -53,39 +54,41 @@
 	wake_up(&sem->wait);
 }
 
-static spinlock_t semaphore_lock = SPIN_LOCK_UNLOCKED;
-
 void __down(struct semaphore * sem)
 {
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
+	unsigned long flags;
+
 	tsk->state = TASK_UNINTERRUPTIBLE;
-	add_wait_queue_exclusive(&sem->wait, &wait);
+	wq_write_lock_irqsave(&sem->wait.lock, flags);
+	add_wait_queue_exclusive_locked(&sem->wait, &wait);
 
-	spin_lock_irq(&semaphore_lock);
 	sem->sleepers++;
 	for (;;) {
 		int sleepers = sem->sleepers;
 
 		/*
 		 * Add "everybody else" into it. They aren't
-		 * playing, because we own the spinlock.
+		 * playing, because we own the wait lock
+		 * exclusivly.
 		 */
 		if (!atomic_add_negative(sleepers - 1, &sem->count)) {
 			sem->sleepers = 0;
 			break;
 		}
 		sem->sleepers = 1;	/* us - see -1 above */
-		spin_unlock_irq(&semaphore_lock);
+		wq_write_unlock_irqrestore(&sem->wait.lock, flags);
 
 		schedule();
+
+		wq_write_lock_irqsave(&sem->wait.lock, flags);
 		tsk->state = TASK_UNINTERRUPTIBLE;
-		spin_lock_irq(&semaphore_lock);
 	}
-	spin_unlock_irq(&semaphore_lock);
-	remove_wait_queue(&sem->wait, &wait);
+	remove_wait_queue_locked(&sem->wait, &wait);
+	wake_up_locked(&sem->wait);
+	wq_write_unlock_irqrestore(&sem->wait.lock, flags);
 	tsk->state = TASK_RUNNING;
-	wake_up(&sem->wait);
 }
 
 int __down_interruptible(struct semaphore * sem)
@@ -93,11 +96,13 @@
 	int retval = 0;
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
+	unsigned long flags;
+
 	tsk->state = TASK_INTERRUPTIBLE;
-	add_wait_queue_exclusive(&sem->wait, &wait);
+	wq_write_lock_irqsave(&sem->wait.lock, flags);
+	add_wait_queue_exclusive_locked(&sem->wait, &wait);
 
-	spin_lock_irq(&semaphore_lock);
-	sem->sleepers ++;
+	sem->sleepers++;
 	for (;;) {
 		int sleepers = sem->sleepers;
 
@@ -117,25 +122,27 @@
 
 		/*
 		 * Add "everybody else" into it. They aren't
-		 * playing, because we own the spinlock. The
-		 * "-1" is because we're still hoping to get
-		 * the lock.
+		 * playing, because we own the wait lock
+		 * exclusivly. The "-1" is because we're still
+		 * hoping to get the semaphore.
 		 */
 		if (!atomic_add_negative(sleepers - 1, &sem->count)) {
 			sem->sleepers = 0;
 			break;
 		}
 		sem->sleepers = 1;	/* us - see -1 above */
-		spin_unlock_irq(&semaphore_lock);
+		wq_write_unlock_irqrestore(&sem->wait.lock, flags);
 
 		schedule();
+
+		wq_write_lock_irqsave(&sem->wait.lock, flags);
 		tsk->state = TASK_INTERRUPTIBLE;
-		spin_lock_irq(&semaphore_lock);
 	}
-	spin_unlock_irq(&semaphore_lock);
+	remove_wait_queue_locked(&sem->wait, &wait);
+	wake_up_locked(&sem->wait);
+	wq_write_unlock_irqrestore(&sem->wait.lock, flags);
+
 	tsk->state = TASK_RUNNING;
-	remove_wait_queue(&sem->wait, &wait);
-	wake_up(&sem->wait);
 	return retval;
 }
 
@@ -152,18 +159,19 @@
 	int sleepers;
 	unsigned long flags;
 
-	spin_lock_irqsave(&semaphore_lock, flags);
+	wq_write_lock_irqsave(&sem->wait.lock, flags);
 	sleepers = sem->sleepers + 1;
 	sem->sleepers = 0;
 
 	/*
 	 * Add "everybody else" and us into it. They aren't
-	 * playing, because we own the spinlock.
+	 * playing, because we own the wait lock exclusivly.
 	 */
-	if (!atomic_add_negative(sleepers, &sem->count))
-		wake_up(&sem->wait);
+	if (!atomic_add_negative(sleepers, &sem->count)) {
+		wake_up_locked(&sem->wait);
+	}
 
-	spin_unlock_irqrestore(&semaphore_lock, flags);
+	wq_write_unlock_irqrestore(&sem->wait.lock, flags);
 	return 1;
 }
 
diff -ru linux-2.5.7-dj2-orig/include/linux/sched.h linux-2.5.7-dj2-sema/include/linux/sched.h
--- linux-2.5.7-dj2-orig/include/linux/sched.h	Thu Mar 28 09:20:59 2002
+++ linux-2.5.7-dj2-sema/include/linux/sched.h	Thu Mar 28 15:50:17 2002
@@ -469,6 +469,7 @@
 extern unsigned long prof_shift;
 
 extern void FASTCALL(__wake_up(wait_queue_head_t *q, unsigned int mode, int nr));
+extern void FASTCALL(__wake_up_locked(wait_queue_head_t *q, unsigned int mode));
 extern void FASTCALL(sleep_on(wait_queue_head_t *q));
 extern long FASTCALL(sleep_on_timeout(wait_queue_head_t *q,
 				      signed long timeout));
@@ -485,6 +486,7 @@
 #define wake_up_interruptible(x)	__wake_up((x),TASK_INTERRUPTIBLE, 1)
 #define wake_up_interruptible_nr(x, nr)	__wake_up((x),TASK_INTERRUPTIBLE, nr)
 #define wake_up_interruptible_all(x)	__wake_up((x),TASK_INTERRUPTIBLE, 0)
+#define wake_up_locked(x)		__wake_up_locked((x),TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE)
 asmlinkage long sys_wait4(pid_t pid,unsigned int * stat_addr, int options, struct rusage * ru);
 
 extern int in_group_p(gid_t);
@@ -711,6 +713,25 @@
 	remove_wait_queue(&wq, &__wait);				\
 } while (0)
 	
+/*
+ * Must be called with wait queue lock held in write mode.
+ */
+static inline void add_wait_queue_exclusive_locked(wait_queue_head_t *q,
+						   wait_queue_t * wait)
+{
+	wait->flags |= WQ_FLAG_EXCLUSIVE;
+	__add_wait_queue_tail(q,  wait);
+}
+
+/*
+ * Must be called with wait queue lock held in write mode.
+ */
+static inline void remove_wait_queue_locked(wait_queue_head_t *q,
+					    wait_queue_t * wait)
+{
+	__remove_wait_queue(q,  wait);
+}
+
 #define wait_event_interruptible(wq, condition)				\
 ({									\
 	int __ret = 0;							\
diff -ru linux-2.5.7-dj2-orig/kernel/sched.c linux-2.5.7-dj2-sema/kernel/sched.c
--- linux-2.5.7-dj2-orig/kernel/sched.c	Thu Mar 28 09:10:42 2002
+++ linux-2.5.7-dj2-sema/kernel/sched.c	Thu Mar 28 14:04:34 2002
@@ -857,7 +857,7 @@
  * started to run but is not in state TASK_RUNNING.  try_to_wake_up() returns
  * zero in this (rare) case, and we handle it by continuing to scan the queue.
  */
-static inline void __wake_up_common(wait_queue_head_t *q, unsigned int mode, int nr_exclusive)
+static void __wake_up_common(wait_queue_head_t *q, unsigned int mode, int nr_exclusive)
 {
 	struct list_head *tmp;
 	unsigned int state;
@@ -885,6 +885,15 @@
 	wq_read_unlock_irqrestore(&q->lock, flags);
 }
 
+/*
+ * Same as __wake_up but called with the wait_queue_head_t lock held
+ * in at least read mode.
+ */
+void __wake_up_locked(wait_queue_head_t *q, unsigned int mode)
+{
+	__wake_up_common(q, mode, 1);
+}
+
 void complete(struct completion *x)
 {
 	unsigned long flags;
