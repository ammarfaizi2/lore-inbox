Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291386AbSAaXCR>; Thu, 31 Jan 2002 18:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291387AbSAaXCH>; Thu, 31 Jan 2002 18:02:07 -0500
Received: from air-1.osdl.org ([65.201.151.5]:8064 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S291386AbSAaXBl>;
	Thu, 31 Jan 2002 18:01:41 -0500
Date: Thu, 31 Jan 2002 15:01:39 -0800
From: Bob Miller <rem@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.3 remove global semaphore_lock spin lock.
Message-ID: <20020131150139.A1345@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
Open Software Development Lab			Phone: 503.626.2455 Ext. 17


diff -ru linux.2.5.3-orig/arch/i386/kernel/semaphore.c linux.2.5.3/arch/i386/kernel/semaphore.c
--- linux.2.5.3-orig/arch/i386/kernel/semaphore.c	Fri Nov 30 08:54:18 2001
+++ linux.2.5.3/arch/i386/kernel/semaphore.c	Thu Jan 31 14:18:43 2002
@@ -28,7 +28,8 @@
  * the increment operation.
  *
  * "sleeping" and the contention routine ordering is
- * protected by the semaphore spinlock.
+ * protected by the read/write lock in the semaphore's
+ * waitqueue head.
  *
  * Note that these functions are only called when there is
  * contention on the lock, and as such all this is the
@@ -52,39 +53,41 @@
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
@@ -92,11 +95,13 @@
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
 
@@ -116,25 +121,27 @@
 
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
 
@@ -151,18 +158,19 @@
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
 
diff -ru linux.2.5.3-orig/include/linux/sched.h linux.2.5.3/include/linux/sched.h
--- linux.2.5.3-orig/include/linux/sched.h	Tue Jan 29 21:41:12 2002
+++ linux.2.5.3/include/linux/sched.h	Thu Jan 31 10:35:37 2002
@@ -537,6 +537,7 @@
 
 extern void FASTCALL(__wake_up(wait_queue_head_t *q, unsigned int mode, int nr));
 extern void FASTCALL(__wake_up_sync(wait_queue_head_t *q, unsigned int mode, int nr));
+extern void FASTCALL(__wake_up_locked(wait_queue_head_t *q, unsigned int mode, int nr));
 extern void FASTCALL(sleep_on(wait_queue_head_t *q));
 extern long FASTCALL(sleep_on_timeout(wait_queue_head_t *q,
 				      signed long timeout));
@@ -556,6 +557,7 @@
 #define wake_up_interruptible_all(x)	__wake_up((x),TASK_INTERRUPTIBLE, 0)
 #define wake_up_interruptible_sync(x)	__wake_up_sync((x),TASK_INTERRUPTIBLE, 1)
 #define wake_up_interruptible_sync_nr(x) __wake_up_sync((x),TASK_INTERRUPTIBLE,  nr)
+#define wake_up_locked(x)		__wake_up_locked((x),TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 1)
 asmlinkage long sys_wait4(pid_t pid,unsigned int * stat_addr, int options, struct rusage * ru);
 
 extern int in_group_p(gid_t);
@@ -757,7 +759,9 @@
 
 extern void FASTCALL(add_wait_queue(wait_queue_head_t *q, wait_queue_t * wait));
 extern void FASTCALL(add_wait_queue_exclusive(wait_queue_head_t *q, wait_queue_t * wait));
+extern void FASTCALL(add_wait_queue_exclusive_locked(wait_queue_head_t *q, wait_queue_t * wait));
 extern void FASTCALL(remove_wait_queue(wait_queue_head_t *q, wait_queue_t * wait));
+extern void FASTCALL(remove_wait_queue_locked(wait_queue_head_t *q, wait_queue_t * wait));
 
 extern void wait_task_inactive(task_t * p);
 extern void kick_if_running(task_t * p);
diff -ru linux.2.5.3-orig/kernel/fork.c linux.2.5.3/kernel/fork.c
--- linux.2.5.3-orig/kernel/fork.c	Mon Jan 28 15:11:45 2002
+++ linux.2.5.3/kernel/fork.c	Thu Jan 31 09:55:20 2002
@@ -59,6 +59,15 @@
 	wq_write_unlock_irqrestore(&q->lock, flags);
 }
 
+/*
+ * Must be called with wait queue lock held in write mode.
+ */
+void add_wait_queue_exclusive_locked(wait_queue_head_t *q, wait_queue_t * wait)
+{
+	wait->flags |= WQ_FLAG_EXCLUSIVE;
+	__add_wait_queue_tail(q, wait);
+}
+
 void remove_wait_queue(wait_queue_head_t *q, wait_queue_t * wait)
 {
 	unsigned long flags;
@@ -68,6 +77,14 @@
 	wq_write_unlock_irqrestore(&q->lock, flags);
 }
 
+/*
+ * Must be called with wait queue lock held in write mode.
+ */
+void remove_wait_queue_locked(wait_queue_head_t *q, wait_queue_t * wait)
+{
+	__remove_wait_queue(q, wait);
+}
+
 void __init fork_init(unsigned long mempages)
 {
 	/*
diff -ru linux.2.5.3-orig/kernel/sched.c linux.2.5.3/kernel/sched.c
--- linux.2.5.3-orig/kernel/sched.c	Mon Jan 28 15:12:47 2002
+++ linux.2.5.3/kernel/sched.c	Thu Jan 31 09:55:20 2002
@@ -743,6 +743,17 @@
 	}
 }
 
+/*
+ * Same as __wake_up but called with the wait_queue_head_t lock held
+ * in at least read mode.
+ */
+void __wake_up_locked(wait_queue_head_t *q, unsigned int mode, int nr)
+{
+	if (q) {
+		__wake_up_common(q, mode, nr, 0);
+	}
+}
+
 void __wake_up_sync(wait_queue_head_t *q, unsigned int mode, int nr)
 {
 	if (q) {
