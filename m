Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261910AbVASVkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbVASVkE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 16:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbVASVj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 16:39:59 -0500
Received: from natjimbo.rzone.de ([81.169.145.162]:18090 "EHLO
	natjimbo.rzone.de") by vger.kernel.org with ESMTP id S261910AbVASViF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 16:38:05 -0500
Date: Wed, 19 Jan 2005 22:38:34 +0100
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 2/4] interruptible rwsem operations (i386, core)
Message-ID: <20050119213834.GC8471@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.de>,
	dhowells@redhat.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Piggin <nickpiggin@yahoo.com.au>

Add functions down_read_interruptible, and down_write_interruptible to rw
semaphores. Implement these for i386.

Other architectures should be fairly straight forward - the functions are
basically identical to down_read  / down_write, but must just catch and
return the value from the out-of-line function in the case that the semaphore
is contended.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>
Signed-off-by: Dominik Brodowski <linux@brodo.de>

---

 linux-2.6-npiggin/include/asm-i386/rwsem.h       |   75 ++++++++++++-
 linux-2.6-npiggin/include/linux/rwsem-spinlock.h |    2 
 linux-2.6-npiggin/include/linux/rwsem.h          |   28 ++++
 linux-2.6-npiggin/lib/rwsem-spinlock.c           |  132 +++++++++++++++++++++++
 linux-2.6-npiggin/lib/rwsem.c                    |  114 ++++++++++++++++++-
 5 files changed, 337 insertions(+), 14 deletions(-)

diff -puN lib/rwsem.c~rwsem-interruptible lib/rwsem.c
--- linux-2.6/lib/rwsem.c~rwsem-interruptible	2005-01-19 13:39:39.000000000 +1100
+++ linux-2.6-npiggin/lib/rwsem.c	2005-01-19 13:39:39.000000000 +1100
@@ -142,8 +142,7 @@ __rwsem_do_wake(struct rw_semaphore *sem
 /*
  * wait for a lock to be granted
  */
-static inline struct rw_semaphore *
-rwsem_down_failed_common(struct rw_semaphore *sem,
+static inline void rwsem_down_failed_common(struct rw_semaphore *sem,
 			struct rwsem_waiter *waiter, signed long adjustment)
 {
 	struct task_struct *tsk = current;
@@ -180,15 +179,70 @@ rwsem_down_failed_common(struct rw_semap
 	}
 
 	tsk->state = TASK_RUNNING;
+}
 
-	return sem;
+/*
+ * interruptible wait for a lock to be granted
+ */
+static inline int
+rwsem_down_interruptible_failed_common(struct rw_semaphore *sem,
+			struct rwsem_waiter *waiter, signed long adjustment)
+{
+	struct task_struct *tsk = current;
+	signed long count;
+	int ret = 0;
+
+	if (signal_pending(current))
+		return -EINTR;
+
+	set_task_state(tsk, TASK_INTERRUPTIBLE);
+
+	/* set up my own style of waitqueue */
+	spin_lock(&sem->wait_lock);
+	waiter->task = tsk;
+	get_task_struct(tsk);
+
+	list_add_tail(&waiter->list, &sem->wait_list);
+
+	/* we're now waiting on the lock, but no longer actively read-locking */
+	count = rwsem_atomic_update(adjustment, sem);
+
+	/* if there are no active locks, wake the front queued process(es) up */
+	if (!(count & RWSEM_ACTIVE_MASK))
+		sem = __rwsem_do_wake(sem, 0);
+
+	spin_unlock(&sem->wait_lock);
+
+	/* wait to be given the lock */
+	for (;;) {
+		if (!waiter->task)
+			break;
+		if (signal_pending(current)) {
+			spin_lock(&sem->wait_lock);
+			if (!waiter->task) {
+				spin_unlock(&sem->wait_lock);
+				break;
+			}
+			list_del(&waiter->list);
+			rwsem_atomic_add(-adjustment, sem);
+			spin_unlock(&sem->wait_lock);
+			ret = -EINTR;
+			break;
+		}
+
+		schedule();
+		set_task_state(tsk, TASK_INTERRUPTIBLE);
+	}
+
+	tsk->state = TASK_RUNNING;
+
+	return ret;
 }
 
 /*
  * wait for the read lock to be granted
  */
-struct rw_semaphore fastcall __sched *
-rwsem_down_read_failed(struct rw_semaphore *sem)
+void fastcall __sched rwsem_down_read_failed(struct rw_semaphore *sem)
 {
 	struct rwsem_waiter waiter;
 
@@ -199,14 +253,33 @@ rwsem_down_read_failed(struct rw_semapho
 				RWSEM_WAITING_BIAS - RWSEM_ACTIVE_BIAS);
 
 	rwsemtrace(sem, "Leaving rwsem_down_read_failed");
-	return sem;
+}
+
+/*
+ * interruptible wait for the read lock to be granted
+ */
+int fastcall __sched
+rwsem_down_read_interruptible_failed(struct rw_semaphore *sem)
+{
+	struct rwsem_waiter waiter;
+	int ret;
+
+	rwsemtrace(sem, "Entering rwsem_down_read_interruptible_failed");
+
+	waiter.flags = RWSEM_WAITING_FOR_READ;
+	ret = rwsem_down_interruptible_failed_common(sem, &waiter,
+				RWSEM_WAITING_BIAS - RWSEM_ACTIVE_BIAS);
+	if (ret == -EINTR)
+		up_read(sem);
+
+	rwsemtrace(sem, "Leaving rwsem_down_read_interruptible_failed");
+	return ret;
 }
 
 /*
  * wait for the write lock to be granted
  */
-struct rw_semaphore fastcall __sched *
-rwsem_down_write_failed(struct rw_semaphore *sem)
+void fastcall __sched rwsem_down_write_failed(struct rw_semaphore *sem)
 {
 	struct rwsem_waiter waiter;
 
@@ -216,10 +289,31 @@ rwsem_down_write_failed(struct rw_semaph
 	rwsem_down_failed_common(sem, &waiter, -RWSEM_ACTIVE_BIAS);
 
 	rwsemtrace(sem, "Leaving rwsem_down_write_failed");
-	return sem;
 }
 
 /*
+ * interruptible wait for the write lock to be granted
+ */
+int fastcall __sched
+rwsem_down_write_interruptible_failed(struct rw_semaphore *sem)
+{
+	struct rwsem_waiter waiter;
+	int ret;
+
+	rwsemtrace(sem, "Entering rwsem_down_write_interruptible_failed");
+
+	waiter.flags = RWSEM_WAITING_FOR_WRITE;
+	ret = rwsem_down_interruptible_failed_common(sem, &waiter,
+						-RWSEM_ACTIVE_BIAS);
+	if (ret == -EINTR)
+		up_write(sem);
+
+	rwsemtrace(sem, "Leaving rwsem_down_write_interruptible_failed");
+	return ret;
+}
+
+
+/*
  * handle waking up a waiter on the semaphore
  * - up_read/up_write has decremented the active part of count if we come here
  */
@@ -262,7 +356,9 @@ struct rw_semaphore fastcall *rwsem_down
 }
 
 EXPORT_SYMBOL(rwsem_down_read_failed);
+EXPORT_SYMBOL(rwsem_down_read_interruptible_failed);
 EXPORT_SYMBOL(rwsem_down_write_failed);
+EXPORT_SYMBOL(rwsem_down_write_interruptible_failed);
 EXPORT_SYMBOL(rwsem_wake);
 EXPORT_SYMBOL(rwsem_downgrade_wake);
 #if RWSEM_DEBUG
diff -puN include/asm-i386/rwsem.h~rwsem-interruptible include/asm-i386/rwsem.h
--- linux-2.6/include/asm-i386/rwsem.h~rwsem-interruptible	2005-01-19 13:39:39.000000000 +1100
+++ linux-2.6-npiggin/include/asm-i386/rwsem.h	2005-01-19 13:39:39.000000000 +1100
@@ -43,8 +43,12 @@
 
 struct rwsem_waiter;
 
-extern struct rw_semaphore *FASTCALL(rwsem_down_read_failed(struct rw_semaphore *sem));
-extern struct rw_semaphore *FASTCALL(rwsem_down_write_failed(struct rw_semaphore *sem));
+extern void FASTCALL(rwsem_down_read_failed(struct rw_semaphore *sem));
+extern int FASTCALL(
+	rwsem_down_read_interruptible_failed(struct rw_semaphore *sem));
+extern void FASTCALL(rwsem_down_write_failed(struct rw_semaphore *sem));
+extern int FASTCALL(
+	rwsem_down_write_interruptible_failed(struct rw_semaphore *sem));
 extern struct rw_semaphore *FASTCALL(rwsem_wake(struct rw_semaphore *));
 extern struct rw_semaphore *FASTCALL(rwsem_downgrade_wake(struct rw_semaphore *sem));
 
@@ -99,11 +103,12 @@ static inline void __down_read(struct rw
 {
 	__asm__ __volatile__(
 		"# beginning down_read\n\t"
-LOCK_PREFIX	"  incl      (%%eax)\n\t" /* adds 0x00000001, returns the old value */
+LOCK_PREFIX	"  incl      %0\n\t" /* adds 0x00000001, returns the old value */
 		"  js        2f\n\t" /* jump if we weren't granted the lock */
 		"1:\n\t"
 		LOCK_SECTION_START("")
 		"2:\n\t"
+		"  movl      %2,%%eax\n\t"
 		"  pushl     %%ecx\n\t"
 		"  pushl     %%edx\n\t"
 		"  call      rwsem_down_read_failed\n\t"
@@ -113,11 +118,41 @@ LOCK_PREFIX	"  incl      (%%eax)\n\t" /*
 		LOCK_SECTION_END
 		"# ending down_read\n\t"
 		: "=m"(sem->count)
-		: "a"(sem), "m"(sem->count)
+		: "m"(sem->count), "m"(sem)
 		: "memory", "cc");
 }
 
 /*
+ * interruptible lock for reading
+ */
+static inline int __down_read_interruptible(struct rw_semaphore *sem)
+{
+	int ret = 0;
+
+	__asm__ __volatile__(
+		"# beginning down_read_interruptible\n\t"
+LOCK_PREFIX	"  incl      %0\n\t" /* adds 0x00000001, returns the old value */
+		"  js        2f\n\t" /* jump if we weren't granted the lock */
+		"1:\n\t"
+		LOCK_SECTION_START("")
+		"2:\n\t"
+		"  movl      %3,%%eax\n\t"
+		"  pushl     %%ecx\n\t"
+		"  pushl     %%edx\n\t"
+		"  call      rwsem_down_read_interruptible_failed\n\t"
+		"  popl      %%edx\n\t"
+		"  popl      %%ecx\n\t"
+		"  movl      %%eax,%1\n\t"
+		"  jmp       1b\n"
+		LOCK_SECTION_END
+		"# ending down_read_interruptible\n\t"
+		: "=m"(sem->count), "=m"(ret)
+		: "m"(sem->count), "m"(sem)
+		: "memory", "cc");
+	return ret;
+}
+
+/*
  * trylock for reading -- returns 1 if successful, 0 if contention
  */
 static inline int __down_read_trylock(struct rw_semaphore *sem)
@@ -150,7 +185,7 @@ static inline void __down_write(struct r
 	tmp = RWSEM_ACTIVE_WRITE_BIAS;
 	__asm__ __volatile__(
 		"# beginning down_write\n\t"
-LOCK_PREFIX	"  xadd      %%edx,(%%eax)\n\t" /* subtract 0x0000ffff, returns the old value */
+LOCK_PREFIX	"  xadd      %%edx,%0\n\t" /* subtract 0x0000ffff, returns the old value */
 		"  testl     %%edx,%%edx\n\t" /* was the count 0 before? */
 		"  jnz       2f\n\t" /* jump if we weren't granted the lock */
 		"1:\n\t"
@@ -168,6 +203,36 @@ LOCK_PREFIX	"  xadd      %%edx,(%%eax)\n
 }
 
 /*
+ * interruptible lock for writing
+ */
+static inline int __down_write_interruptible(struct rw_semaphore *sem)
+{
+	int ret = 0;
+
+	__asm__ __volatile__(
+		"# beginning down_write_interruptible\n\t"
+LOCK_PREFIX	"  xadd      %%edx,%0\n\t" /* subtract 0x0000ffff, returns the old value */
+		"  testl     %%edx,%%edx\n\t" /* was the count 0 before? */
+		"  jnz       2f\n\t" /* jump if we weren't granted the lock */
+		"1:\n\t"
+		LOCK_SECTION_START("")
+		"2:\n\t"
+		"  movl      %3,%%eax\n\t"
+		"  pushl     %%ecx\n\t"
+		"  call      rwsem_down_write_interruptible_failed\n\t"
+		"  popl      %%ecx\n\t"
+		"  movl      %%eax, %1\n\t"
+		"  jmp       1b\n"
+		LOCK_SECTION_END
+		"# ending down_write_interruptible"
+		: "=m"(sem->count), "=m"(ret)
+		: "m"(sem->count), "m"(sem), "d"(RWSEM_ACTIVE_WRITE_BIAS)
+		: "memory", "cc");
+	return ret;
+}
+
+
+/*
  * trylock for writing -- returns 1 if successful, 0 if contention
  */
 static inline int __down_write_trylock(struct rw_semaphore *sem)
diff -puN lib/rwsem-spinlock.c~rwsem-interruptible lib/rwsem-spinlock.c
--- linux-2.6/lib/rwsem-spinlock.c~rwsem-interruptible	2005-01-19 13:39:39.000000000 +1100
+++ linux-2.6-npiggin/lib/rwsem-spinlock.c	2005-01-19 13:39:39.000000000 +1100
@@ -179,6 +179,71 @@ void fastcall __sched __down_read(struct
 }
 
 /*
+ * get a read lock on the semaphore (interruptible)
+ */
+int fastcall __sched __down_read_interruptible(struct rw_semaphore *sem)
+{
+	struct rwsem_waiter waiter;
+	struct task_struct *tsk;
+	int ret = 0;
+
+	rwsemtrace(sem, "Entering __down_read_interruptible");
+
+	if (signal_pending(current)) {
+		ret = -EINTR;
+		goto out;
+	}
+
+	spin_lock(&sem->wait_lock);
+
+	if (sem->activity >= 0 && list_empty(&sem->wait_list)) {
+		/* granted */
+		sem->activity++;
+		spin_unlock(&sem->wait_lock);
+		goto out;
+	}
+
+	tsk = current;
+	set_task_state(tsk, TASK_INTERRUPTIBLE);
+
+	/* set up my own style of waitqueue */
+	waiter.task = tsk;
+	waiter.flags = RWSEM_WAITING_FOR_READ;
+	get_task_struct(tsk);
+
+	list_add_tail(&waiter.list, &sem->wait_list);
+
+	/* we don't need to touch the semaphore struct anymore */
+	spin_unlock(&sem->wait_lock);
+
+	/* wait to be given the lock */
+	for (;;) {
+		if (!waiter.task)
+			break;
+		if (signal_pending(current)) {
+			spin_lock(&sem->wait_lock);
+			if (!waiter.task) {
+				spin_unlock(&sem->wait_lock);
+				break;
+			}
+			list_del(&waiter.list);
+			spin_unlock(&sem->wait_lock);
+			ret = -EINTR;
+			break;
+		}
+		schedule();
+		set_task_state(tsk, TASK_INTERRUPTIBLE);
+	}
+
+	tsk->state = TASK_RUNNING;
+
+ out:
+	rwsemtrace(sem, "Leaving __down_read_interruptible");
+
+	return ret;
+}
+
+/*
  * trylock for reading -- returns 1 if successful, 0 if contention
  */
 int fastcall __down_read_trylock(struct rw_semaphore *sem)
@@ -248,6 +313,73 @@ void fastcall __sched __down_write(struc
 }
 
 /*
+ * get a write lock on the semaphore
+ * - we increment the waiting count anyway to indicate an exclusive lock
+ */
+int fastcall __sched __down_write_interruptible(struct rw_semaphore *sem)
+{
+	struct rwsem_waiter waiter;
+	struct task_struct *tsk;
+	int ret = 0;
+
+	rwsemtrace(sem, "Entering __down_write");
+
+	if (signal_pending(current)) {
+		ret = -EINTR;
+		goto out;
+	}
+
+	spin_lock(&sem->wait_lock);
+
+	if (sem->activity == 0 && list_empty(&sem->wait_list)) {
+		/* granted */
+		sem->activity = -1;
+		spin_unlock(&sem->wait_lock);
+		goto out;
+	}
+
+	tsk = current;
+	set_task_state(tsk, TASK_INTERRUPTIBLE);
+
+	/* set up my own style of waitqueue */
+	waiter.task = tsk;
+	waiter.flags = RWSEM_WAITING_FOR_WRITE;
+	get_task_struct(tsk);
+
+	list_add_tail(&waiter.list, &sem->wait_list);
+
+	/* we don't need to touch the semaphore struct anymore */
+	spin_unlock(&sem->wait_lock);
+
+	/* wait to be given the lock */
+	for (;;) {
+		if (!waiter.task)
+			break;
+		if (signal_pending(current)) {
+			spin_lock(&sem->wait_lock);
+			if (!waiter.task) {
+				spin_unlock(&sem->wait_lock);
+				break;
+			}
+			list_del(&waiter.list);
+			spin_unlock(&sem->wait_lock);
+			ret = -EINTR;
+			break;
+		}
+		schedule();
+		set_task_state(tsk, TASK_INTERRUPTIBLE);
+	}
+
+	tsk->state = TASK_RUNNING;
+
+ out:
+	rwsemtrace(sem, "Leaving __down_write");
+
+	return ret;
+}
+
+
+/*
  * trylock for writing -- returns 1 if successful, 0 if contention
  */
 int fastcall __down_write_trylock(struct rw_semaphore *sem)
diff -puN include/linux/rwsem.h~rwsem-interruptible include/linux/rwsem.h
--- linux-2.6/include/linux/rwsem.h~rwsem-interruptible	2005-01-19 13:39:39.000000000 +1100
+++ linux-2.6-npiggin/include/linux/rwsem.h	2005-01-19 13:39:39.000000000 +1100
@@ -47,6 +47,20 @@ static inline void down_read(struct rw_s
 }
 
 /*
+ * interrupbile lock for reading
+ * returns 0 on success, -EINTR if interrupted
+ */
+static inline int down_read_interruptible(struct rw_semaphore *sem)
+{
+	int ret;
+	might_sleep();
+	rwsemtrace(sem,"Entering down_read_interruptible");
+	ret = __down_read_interruptible(sem);
+	rwsemtrace(sem,"Leaving down_read_interruptible");
+	return ret;
+}
+
+/*
  * trylock for reading -- returns 1 if successful, 0 if contention
  */
 static inline int down_read_trylock(struct rw_semaphore *sem)
@@ -70,6 +84,20 @@ static inline void down_write(struct rw_
 }
 
 /*
+ * interrupbile lock for writing
+ * returns 0 on success, -EINTR if interrupted
+ */
+static inline int down_write_interruptible(struct rw_semaphore *sem)
+{
+	int ret;
+	might_sleep();
+	rwsemtrace(sem,"Entering down_write_interruptible");
+	ret = __down_write_interruptible(sem);
+	rwsemtrace(sem,"Leaving down_write_interruptible");
+	return ret;
+}
+
+/*
  * trylock for writing -- returns 1 if successful, 0 if contention
  */
 static inline int down_write_trylock(struct rw_semaphore *sem)
diff -puN include/linux/rwsem-spinlock.h~rwsem-interruptible include/linux/rwsem-spinlock.h
--- linux-2.6/include/linux/rwsem-spinlock.h~rwsem-interruptible	2005-01-19 13:39:39.000000000 +1100
+++ linux-2.6-npiggin/include/linux/rwsem-spinlock.h	2005-01-19 13:39:39.000000000 +1100
@@ -54,8 +54,10 @@ struct rw_semaphore {
 
 extern void FASTCALL(init_rwsem(struct rw_semaphore *sem));
 extern void FASTCALL(__down_read(struct rw_semaphore *sem));
+extern int FASTCALL(__down_read_interruptible(struct rw_semaphore *sem));
 extern int FASTCALL(__down_read_trylock(struct rw_semaphore *sem));
 extern void FASTCALL(__down_write(struct rw_semaphore *sem));
+extern int FASTCALL(__down_write_interruptible(struct rw_semaphore *sem));
 extern int FASTCALL(__down_write_trylock(struct rw_semaphore *sem));
 extern void FASTCALL(__up_read(struct rw_semaphore *sem));
 extern void FASTCALL(__up_write(struct rw_semaphore *sem));

_

