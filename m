Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317560AbSGJROK>; Wed, 10 Jul 2002 13:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317561AbSGJROJ>; Wed, 10 Jul 2002 13:14:09 -0400
Received: from air-2.osdl.org ([65.172.181.6]:2432 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S317560AbSGJROF>;
	Wed, 10 Jul 2002 13:14:05 -0400
Date: Wed, 10 Jul 2002 10:16:39 -0700
From: Bob Miller <rem@osdl.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.25 remove global semaphore_lock spin lock.
Message-ID: <20020710101639.A18859@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.628   -> 1.629  
#	include/linux/sched.h	1.70    -> 1.71   
#	      kernel/sched.c	1.103   -> 1.104  
#	arch/i386/kernel/semaphore.c	1.6     -> 1.7    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/10	rem@doc.pdx.osdl.net	1.629
# Replace the global semaphore_lock with the spinlock embedded in
# the wait_queue_head_t.  None of the data protected by semaphore_lock
# is global and there is no need to restrict the system to only allow
# one semaphore to be dealt with at a time.
# 
# This removes 2 lock round trips from __down() and __down_interruptible().
# It also reduces the number of cache lines touched by 1 (the cache line
# with seamphore_lock).
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/semaphore.c b/arch/i386/kernel/semaphore.c
--- a/arch/i386/kernel/semaphore.c	Wed Jul 10 10:06:50 2002
+++ b/arch/i386/kernel/semaphore.c	Wed Jul 10 10:06:50 2002
@@ -28,8 +28,8 @@
  * needs to do something only if count was negative before
  * the increment operation.
  *
- * "sleeping" and the contention routine ordering is
- * protected by the semaphore spinlock.
+ * "sleeping" and the contention routine ordering is protected
+ * by the spinlock in the semaphore's waitqueue head.
  *
  * Note that these functions are only called when there is
  * contention on the lock, and as such all this is the
@@ -53,39 +53,41 @@
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
+	spin_lock_irqsave(&sem->wait.lock, flags);
+	add_wait_queue_exclusive_locked(&sem->wait, &wait);
 
-	spin_lock_irq(&semaphore_lock);
 	sem->sleepers++;
 	for (;;) {
 		int sleepers = sem->sleepers;
 
 		/*
 		 * Add "everybody else" into it. They aren't
-		 * playing, because we own the spinlock.
+		 * playing, because we own the spinlock in
+		 * the wait_queue_head.
 		 */
 		if (!atomic_add_negative(sleepers - 1, &sem->count)) {
 			sem->sleepers = 0;
 			break;
 		}
 		sem->sleepers = 1;	/* us - see -1 above */
-		spin_unlock_irq(&semaphore_lock);
+		spin_unlock_irqrestore(&sem->wait.lock, flags);
 
 		schedule();
+
+		spin_lock_irqsave(&sem->wait.lock, flags);
 		tsk->state = TASK_UNINTERRUPTIBLE;
-		spin_lock_irq(&semaphore_lock);
 	}
-	spin_unlock_irq(&semaphore_lock);
-	remove_wait_queue(&sem->wait, &wait);
+	remove_wait_queue_locked(&sem->wait, &wait);
+	wake_up_locked(&sem->wait);
+	spin_unlock_irqrestore(&sem->wait.lock, flags);
 	tsk->state = TASK_RUNNING;
-	wake_up(&sem->wait);
 }
 
 int __down_interruptible(struct semaphore * sem)
@@ -93,11 +95,13 @@
 	int retval = 0;
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
+	unsigned long flags;
+
 	tsk->state = TASK_INTERRUPTIBLE;
-	add_wait_queue_exclusive(&sem->wait, &wait);
+	spin_lock_irqsave(&sem->wait.lock, flags);
+	add_wait_queue_exclusive_locked(&sem->wait, &wait);
 
-	spin_lock_irq(&semaphore_lock);
-	sem->sleepers ++;
+	sem->sleepers++;
 	for (;;) {
 		int sleepers = sem->sleepers;
 
@@ -117,25 +121,27 @@
 
 		/*
 		 * Add "everybody else" into it. They aren't
-		 * playing, because we own the spinlock. The
-		 * "-1" is because we're still hoping to get
-		 * the lock.
+		 * playing, because we own the spinlock in
+		 * wait_queue_head. The "-1" is because we're
+		 * still hoping to get the semaphore.
 		 */
 		if (!atomic_add_negative(sleepers - 1, &sem->count)) {
 			sem->sleepers = 0;
 			break;
 		}
 		sem->sleepers = 1;	/* us - see -1 above */
-		spin_unlock_irq(&semaphore_lock);
+		spin_unlock_irqrestore(&sem->wait.lock, flags);
 
 		schedule();
+
+		spin_lock_irqsave(&sem->wait.lock, flags);
 		tsk->state = TASK_INTERRUPTIBLE;
-		spin_lock_irq(&semaphore_lock);
 	}
-	spin_unlock_irq(&semaphore_lock);
+	remove_wait_queue_locked(&sem->wait, &wait);
+	wake_up_locked(&sem->wait);
+	spin_unlock_irqrestore(&sem->wait.lock, flags);
+
 	tsk->state = TASK_RUNNING;
-	remove_wait_queue(&sem->wait, &wait);
-	wake_up(&sem->wait);
 	return retval;
 }
 
@@ -152,18 +158,20 @@
 	int sleepers;
 	unsigned long flags;
 
-	spin_lock_irqsave(&semaphore_lock, flags);
+	spin_lock_irqsave(&sem->wait.lock, flags);
 	sleepers = sem->sleepers + 1;
 	sem->sleepers = 0;
 
 	/*
 	 * Add "everybody else" and us into it. They aren't
-	 * playing, because we own the spinlock.
+	 * playing, because we own the spinlock in the
+	 * wait_queue_head.
 	 */
-	if (!atomic_add_negative(sleepers, &sem->count))
-		wake_up(&sem->wait);
+	if (!atomic_add_negative(sleepers, &sem->count)) {
+		wake_up_locked(&sem->wait);
+	}
 
-	spin_unlock_irqrestore(&semaphore_lock, flags);
+	spin_unlock_irqrestore(&sem->wait.lock, flags);
 	return 1;
 }
 
diff -Nru a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Wed Jul 10 10:06:50 2002
+++ b/include/linux/sched.h	Wed Jul 10 10:06:50 2002
@@ -487,6 +487,7 @@
 extern unsigned long prof_shift;
 
 extern void FASTCALL(__wake_up(wait_queue_head_t *q, unsigned int mode, int nr));
+extern void FASTCALL(__wake_up_locked(wait_queue_head_t *q, unsigned int mode));
 extern void FASTCALL(__wake_up_sync(wait_queue_head_t *q, unsigned int mode, int nr));
 extern void FASTCALL(sleep_on(wait_queue_head_t *q));
 extern long FASTCALL(sleep_on_timeout(wait_queue_head_t *q,
@@ -504,6 +505,7 @@
 #define wake_up_interruptible(x)	__wake_up((x),TASK_INTERRUPTIBLE, 1)
 #define wake_up_interruptible_nr(x, nr)	__wake_up((x),TASK_INTERRUPTIBLE, nr)
 #define wake_up_interruptible_all(x)	__wake_up((x),TASK_INTERRUPTIBLE, 0)
+#define	wake_up_locked(x)		__wake_up_locked((x), TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE)
 #ifdef CONFIG_SMP
 #define wake_up_interruptible_sync(x)   __wake_up_sync((x),TASK_INTERRUPTIBLE, 1)
 #else
@@ -696,6 +698,25 @@
 	remove_wait_queue(&wq, &__wait);				\
 } while (0)
 	
+/*
+ * Must be called with the spinlock in the wait_queue_head_t held.
+ */
+static inline void add_wait_queue_exclusive_locked(wait_queue_head_t *q,
+						   wait_queue_t * wait)
+{
+	wait->flags |= WQ_FLAG_EXCLUSIVE;
+	__add_wait_queue_tail(q,  wait);
+}
+
+/*
+ * Must be called with the spinlock in the wait_queue_head_t held.
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
diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Wed Jul 10 10:06:50 2002
+++ b/kernel/sched.c	Wed Jul 10 10:06:50 2002
@@ -928,7 +928,7 @@
  * started to run but is not in state TASK_RUNNING.  try_to_wake_up() returns
  * zero in this (rare) case, and we handle it by continuing to scan the queue.
  */
-static inline void __wake_up_common(wait_queue_head_t *q, unsigned int mode, int nr_exclusive, int sync)
+static void __wake_up_common(wait_queue_head_t *q, unsigned int mode, int nr_exclusive, int sync)
 {
 	struct list_head *tmp, *next;
 
@@ -954,6 +954,14 @@
 	spin_lock_irqsave(&q->lock, flags);
 	__wake_up_common(q, mode, nr_exclusive, 0);
 	spin_unlock_irqrestore(&q->lock, flags);
+}
+
+/*
+ * Same as __wake_up but called with the spinlock in wait_queue_head_t held.
+ */
+void __wake_up_locked(wait_queue_head_t *q, unsigned int mode)
+{
+	__wake_up_common(q, mode, 1, 0);
 }
 
 #if CONFIG_SMP
