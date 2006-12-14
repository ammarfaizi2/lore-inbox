Return-Path: <linux-kernel-owner+w=401wt.eu-S1750790AbWLNODG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWLNODG (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 09:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWLNODF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 09:03:05 -0500
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:58508
	"EHLO gnuppy.monkey.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790AbWLNODC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 09:03:02 -0500
Date: Thu, 14 Dec 2006 05:39:03 -0800
To: Ingo Molnar <mingo@elte.hu>
Cc: Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel@vger.kernel.org,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: [PATCH 2/5] lock stat kills lock meter for -rt
Message-ID: <20061214133903.GB22194@gnuppy.monkey.org>
References: <20061214133504.GA22081@gnuppy.monkey.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline
In-Reply-To: <20061214133504.GA22081@gnuppy.monkey.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


.c files that have been changed, rtmutex.c, rt.c


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cfiles.diff"

============================================================
--- kernel/rt.c	5fc97ed10d5053f52488dddfefdb92e6aee2b148
+++ kernel/rt.c	3b86109e8e4163223f17c7d13a5bf53df0e04d70
@@ -66,6 +66,7 @@
 #include <linux/plist.h>
 #include <linux/fs.h>
 #include <linux/futex.h>
+#include <linux/lock_stat.h>
 
 #include "rtmutex_common.h"
 
@@ -75,6 +76,42 @@
 # include "rtmutex.h"
 #endif
 
+#ifdef CONFIG_LOCK_STAT
+#define __LOCK_STAT_RT_MUTEX_LOCK(a)				\
+	rt_mutex_lock_with_ip(a,				\
+		(unsigned long) __builtin_return_address(0))
+#else
+#define __LOCK_STAT_RT_MUTEX_LOCK(a)				\
+	rt_mutex_lock(a);
+#endif
+
+#ifdef CONFIG_LOCK_STAT
+#define __LOCK_STAT_RT_MUTEX_LOCK_INTERRUPTIBLE(a, b)		\
+	rt_mutex_lock_interruptible_with_ip(a, b,		\
+		(unsigned long) __builtin_return_address(0))
+#else
+#define __LOCK_STAT_RT_MUTEX_LOCK_INTERRUPTIBLE(a)		\
+	rt_mutex_lock_interruptible(a, b);
+#endif
+
+#ifdef CONFIG_LOCK_STAT
+#define __LOCK_STAT_RT_MUTEX_TRYLOCK(a)				\
+	rt_mutex_trylock_with_ip(a,				\
+		(unsigned long) __builtin_return_address(0))
+#else
+#define __LOCK_STAT_RT_MUTEX_TRYLOCK(a)				\
+	rt_mutex_trylock(a);
+#endif
+
+#ifdef CONFIG_LOCK_STAT
+#define __LOCK_STAT_RT_SPIN_LOCK(a)				\
+	__rt_spin_lock_with_ip(a,				\
+		(unsigned long) __builtin_return_address(0))
+#else
+#define __LOCK_STAT_RT_SPIN_LOCK(a)				\
+	__rt_spin_lock(a);
+#endif
+
 #ifdef CONFIG_PREEMPT_RT
 /*
  * Unlock these on crash:
@@ -88,7 +125,8 @@ void zap_rt_locks(void)
 /*
  * struct mutex functions
  */
-void _mutex_init(struct mutex *lock, char *name, struct lock_class_key *key)
+void _mutex_init(struct mutex *lock, char *name, struct lock_class_key *key
+			__COMMA_LOCK_STAT_NOTE_PARAM_DECL)
 {
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	/*
@@ -97,14 +135,15 @@ void _mutex_init(struct mutex *lock, cha
 	debug_check_no_locks_freed((void *)lock, sizeof(*lock));
 	lockdep_init_map(&lock->dep_map, name, key, 0);
 #endif
-	__rt_mutex_init(&lock->lock, name);
+	__rt_mutex_init(&lock->lock, name __COMMA_LOCK_STAT_NOTE_VARS);
 }
 EXPORT_SYMBOL(_mutex_init);
 
 void __lockfunc _mutex_lock(struct mutex *lock)
 {
 	mutex_acquire(&lock->dep_map, 0, 0, _RET_IP_);
-	rt_mutex_lock(&lock->lock);
+
+	__LOCK_STAT_RT_MUTEX_LOCK(&lock->lock);
 }
 EXPORT_SYMBOL(_mutex_lock);
 
@@ -124,14 +163,14 @@ void __lockfunc _mutex_lock_nested(struc
 void __lockfunc _mutex_lock_nested(struct mutex *lock, int subclass)
 {
 	mutex_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
-	rt_mutex_lock(&lock->lock);
+	__LOCK_STAT_RT_MUTEX_LOCK(&lock->lock);
 }
 EXPORT_SYMBOL(_mutex_lock_nested);
 #endif
 
 int __lockfunc _mutex_trylock(struct mutex *lock)
 {
-	int ret = rt_mutex_trylock(&lock->lock);
+	int ret = __LOCK_STAT_RT_MUTEX_TRYLOCK(&lock->lock);
 
 	if (ret)
 		mutex_acquire(&lock->dep_map, 0, 1, _RET_IP_);
@@ -152,7 +191,7 @@ int __lockfunc rt_write_trylock(rwlock_t
  */
 int __lockfunc rt_write_trylock(rwlock_t *rwlock)
 {
-	int ret = rt_mutex_trylock(&rwlock->lock);
+	int ret = __LOCK_STAT_RT_MUTEX_TRYLOCK(&rwlock->lock);
 
 	if (ret)
 		rwlock_acquire(&rwlock->dep_map, 0, 1, _RET_IP_);
@@ -179,7 +218,7 @@ int __lockfunc rt_read_trylock(rwlock_t 
 	}
 	spin_unlock_irqrestore(&lock->wait_lock, flags);
 
-	ret = rt_mutex_trylock(lock);
+	ret = __LOCK_STAT_RT_MUTEX_TRYLOCK(lock);
 	if (ret)
 		rwlock_acquire_read(&rwlock->dep_map, 0, 1, _RET_IP_);
 
@@ -190,7 +229,7 @@ void __lockfunc rt_write_lock(rwlock_t *
 void __lockfunc rt_write_lock(rwlock_t *rwlock)
 {
 	rwlock_acquire(&rwlock->dep_map, 0, 0, _RET_IP_);
-	__rt_spin_lock(&rwlock->lock);
+	__LOCK_STAT_RT_SPIN_LOCK(&rwlock->lock);
 }
 EXPORT_SYMBOL(rt_write_lock);
 
@@ -210,11 +249,44 @@ void __lockfunc rt_read_lock(rwlock_t *r
 		return;
 	}
 	spin_unlock_irqrestore(&lock->wait_lock, flags);
-	__rt_spin_lock(lock);
+	__LOCK_STAT_RT_SPIN_LOCK(lock);
 }
 
 EXPORT_SYMBOL(rt_read_lock);
 
+#ifdef CONFIG_LOCK_STAT
+void __lockfunc rt_write_lock_with_ip(rwlock_t *rwlock, unsigned long ip)
+{
+	rwlock_acquire(&rwlock->dep_map, 0, 0, ip);
+	__rt_spin_lock_with_ip(&rwlock->lock, ip);
+}
+EXPORT_SYMBOL(rt_write_lock_with_ip);
+
+void __lockfunc rt_read_lock_with_ip(rwlock_t *rwlock, unsigned long ip)
+{
+	unsigned long flags;
+	struct rt_mutex *lock = &rwlock->lock;
+
+	/*
+	 * NOTE: we handle it as a write-lock:
+	 */
+	rwlock_acquire(&rwlock->dep_map, 0, 0, ip);
+	/*
+	 * Read locks within the write lock succeed.
+	 */
+	spin_lock_irqsave(&lock->wait_lock, flags);
+	if (rt_mutex_real_owner(lock) == current) {
+		spin_unlock_irqrestore(&lock->wait_lock, flags);
+		rwlock->read_depth++;
+		return;
+	}
+	spin_unlock_irqrestore(&lock->wait_lock, flags);
+	__rt_spin_lock_with_ip(lock, ip);
+}
+
+EXPORT_SYMBOL(rt_read_lock_with_ip);
+#endif
+
 void __lockfunc rt_write_unlock(rwlock_t *rwlock)
 {
 	/* NOTE: we always pass in '1' for nested, for simplicity */
@@ -246,7 +318,12 @@ unsigned long __lockfunc rt_write_lock_i
 
 unsigned long __lockfunc rt_write_lock_irqsave(rwlock_t *rwlock)
 {
+#ifdef CONFIG_LOCK_STAT
+	rt_write_lock_with_ip(rwlock,
+				(unsigned long) __builtin_return_address(0));
+#else
 	rt_write_lock(rwlock);
+#endif
 
 	return 0;
 }
@@ -254,13 +331,19 @@ unsigned long __lockfunc rt_read_lock_ir
 
 unsigned long __lockfunc rt_read_lock_irqsave(rwlock_t *rwlock)
 {
+#ifdef CONFIG_LOCK_STAT
+	rt_read_lock_with_ip(rwlock,
+				(unsigned long) __builtin_return_address(0));
+#else
 	rt_read_lock(rwlock);
+#endif
 
 	return 0;
 }
 EXPORT_SYMBOL(rt_read_lock_irqsave);
 
-void __rt_rwlock_init(rwlock_t *rwlock, char *name, struct lock_class_key *key)
+void __rt_rwlock_init(rwlock_t *rwlock, char *name, struct lock_class_key *key
+			__COMMA_LOCK_STAT_NOTE_PARAM_DECL)
 {
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	/*
@@ -269,11 +352,30 @@ void __rt_rwlock_init(rwlock_t *rwlock, 
 	debug_check_no_locks_freed((void *)rwlock, sizeof(*rwlock));
 	lockdep_init_map(&rwlock->dep_map, name, key, 0);
 #endif
-	__rt_mutex_init(&rwlock->lock, name);
+	__rt_mutex_init(&rwlock->lock, name __COMMA_LOCK_STAT_NOTE_VARS);
 	rwlock->read_depth = 0;
 }
 EXPORT_SYMBOL(__rt_rwlock_init);
 
+#ifdef CONFIG_LOCK_STAT
+void __rt_rwlock_init_annotated(rwlock_t *rwlock, char *name,
+				struct lock_class_key *key,
+				LOCK_STAT_NOTE_PARAM_DECL,
+				struct lock_stat *lsobject)
+{
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	/*
+	 * Make sure we are not reinitializing a held lock:
+	 */
+	debug_check_no_locks_freed((void *)rwlock, sizeof(*rwlock));
+	lockdep_init_map(&rwlock->dep_map, name, key, 0);
+#endif
+	__rt_mutex_init_annotated(&rwlock->lock, name, LOCK_STAT_NOTE_VARS, lsobject);
+	rwlock->read_depth = 0;
+}
+EXPORT_SYMBOL(__rt_rwlock_init_annotated);
+#endif
+
 /*
  * rw_semaphores
  */
@@ -335,7 +437,7 @@ int fastcall rt_down_write_trylock(struc
 
 int fastcall rt_down_write_trylock(struct rw_semaphore *rwsem)
 {
-	int ret = rt_mutex_trylock(&rwsem->lock);
+	int ret = __LOCK_STAT_RT_MUTEX_TRYLOCK(&rwsem->lock);
 
 	if (ret)
 		rwsem_acquire(&rwsem->dep_map, 0, 1, _RET_IP_);
@@ -346,14 +448,14 @@ void fastcall rt_down_write(struct rw_se
 void fastcall rt_down_write(struct rw_semaphore *rwsem)
 {
 	rwsem_acquire(&rwsem->dep_map, 0, 0, _RET_IP_);
-	rt_mutex_lock(&rwsem->lock);
+	__LOCK_STAT_RT_MUTEX_LOCK(&rwsem->lock);
 }
 EXPORT_SYMBOL(rt_down_write);
 
 void fastcall rt_down_write_nested(struct rw_semaphore *rwsem, int subclass)
 {
 	rwsem_acquire(&rwsem->dep_map, subclass, 0, _RET_IP_);
-	rt_mutex_lock(&rwsem->lock);
+	__LOCK_STAT_RT_MUTEX_LOCK(&rwsem->lock);
 }
 EXPORT_SYMBOL(rt_down_write_nested);
 
@@ -374,7 +476,7 @@ int fastcall rt_down_read_trylock(struct
 	}
 	spin_unlock_irqrestore(&rwsem->lock.wait_lock, flags);
 
-	ret = rt_mutex_trylock(&rwsem->lock);
+	ret = __LOCK_STAT_RT_MUTEX_TRYLOCK(&rwsem->lock);
 	if (ret)
 		rwsem_acquire(&rwsem->dep_map, 0, 1, _RET_IP_);
 	return ret;
@@ -398,7 +500,7 @@ static void __rt_down_read(struct rw_sem
 		return;
 	}
 	spin_unlock_irqrestore(&rwsem->lock.wait_lock, flags);
-	rt_mutex_lock(&rwsem->lock);
+	__LOCK_STAT_RT_MUTEX_LOCK(&rwsem->lock);
 }
 
 void fastcall rt_down_read(struct rw_semaphore *rwsem)
@@ -433,14 +535,15 @@ void fastcall rt_down_read_non_owner(str
 		return;
 	}
 	spin_unlock_irqrestore(&rwsem->lock.wait_lock, flags);
-	rt_mutex_lock(&rwsem->lock);
+	__LOCK_STAT_RT_MUTEX_LOCK(&rwsem->lock);
 }
 EXPORT_SYMBOL(rt_down_read_non_owner);
 
 #endif
 
 void fastcall __rt_rwsem_init(struct rw_semaphore *rwsem, char *name,
-			      struct lock_class_key *key)
+			      struct lock_class_key *key
+				__COMMA_LOCK_STAT_NOTE_PARAM_DECL)
 {
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	/*
@@ -449,7 +552,7 @@ void fastcall __rt_rwsem_init(struct rw_
 	debug_check_no_locks_freed((void *)rwsem, sizeof(*rwsem));
 	lockdep_init_map(&rwsem->dep_map, name, key, 0);
 #endif
-	__rt_mutex_init(&rwsem->lock, name);
+	__rt_mutex_init(&rwsem->lock, name __COMMA_LOCK_STAT_NOTE_VARS);
 	rwsem->read_depth = 0;
 }
 EXPORT_SYMBOL(__rt_rwsem_init);
@@ -478,7 +581,7 @@ void fastcall rt_down(struct semaphore *
 
 void fastcall rt_down(struct semaphore *sem)
 {
-	rt_mutex_lock(&sem->lock);
+	__LOCK_STAT_RT_MUTEX_LOCK(&sem->lock);
 	__down_complete(sem);
 }
 EXPORT_SYMBOL(rt_down);
@@ -487,7 +590,7 @@ int fastcall rt_down_interruptible(struc
 {
 	int ret;
 
-	ret = rt_mutex_lock_interruptible(&sem->lock, 0);
+	ret = __LOCK_STAT_RT_MUTEX_LOCK_INTERRUPTIBLE(&sem->lock, 0);
 	if (ret)
 		return ret;
 	__down_complete(sem);
@@ -507,7 +610,7 @@ int fastcall rt_down_trylock(struct sema
 	 * embedded mutex internally. It would be quite complex to remove
 	 * these transient failures so lets try it the simple way first:
 	 */
-	if (rt_mutex_trylock(&sem->lock)) {
+	if (__LOCK_STAT_RT_MUTEX_TRYLOCK(&sem->lock)) {
 		__down_complete(sem);
 		return 0;
 	}
@@ -534,26 +637,26 @@ EXPORT_SYMBOL(rt_up);
 }
 EXPORT_SYMBOL(rt_up);
 
-void fastcall __sema_init(struct semaphore *sem, int val,
-			  char *name, char *file, int line)
+void fastcall __sema_init(struct semaphore *sem, int val, char *name
+			__COMMA_LOCK_STAT_FN_DECL, char *_file, int _line)
 {
 	atomic_set(&sem->count, val);
 	switch (val) {
 	case 0:
-		__rt_mutex_init(&sem->lock, name);
-		rt_mutex_lock(&sem->lock);
+		__rt_mutex_init(&sem->lock, name __COMMA_LOCK_STAT_NOTE_VARS);
+		rt_mutex_lock_with_ip(&sem->lock, (unsigned long) __builtin_return_address(0));
 		break;
 	default:
-		__rt_mutex_init(&sem->lock, name);
+		__rt_mutex_init(&sem->lock, name __COMMA_LOCK_STAT_NOTE_VARS);
 		break;
 	}
 }
 EXPORT_SYMBOL(__sema_init);
 
-void fastcall __init_MUTEX(struct semaphore *sem, char *name, char *file,
-			   int line)
+void fastcall __init_MUTEX(struct semaphore *sem, char *name
+			__COMMA_LOCK_STAT_FN_DECL, char *_file, int _line)
 {
-	__sema_init(sem, 1, name, file, line);
+	__sema_init(sem, 1, name __COMMA_LOCK_STAT_FN_VAR, _file, _line);
 }
 EXPORT_SYMBOL(__init_MUTEX);
 
============================================================
--- kernel/rtmutex.c	5fbb6943266e0a2de638851c887e331999eaa16d
+++ kernel/rtmutex.c	d9330ea301d8a5df835beefd0f3257d84e70523c
@@ -15,6 +15,10 @@
 #include <linux/sched.h>
 #include <linux/timer.h>
 
+#include <linux/hardirq.h>
+#include <linux/interrupt.h>
+#include <linux/lock_stat.h>
+
 #include "rtmutex_common.h"
 
 #ifdef CONFIG_DEBUG_RT_MUTEXES
@@ -68,6 +72,11 @@ rt_mutex_set_owner(struct rt_mutex *lock
 	lock->owner = (struct task_struct *)val;
 }
 
+static inline void rt_mutex_clear_owner(struct rt_mutex *lock)
+{
+	lock->owner = (struct task_struct *) NULL;
+}
+
 static inline void clear_rt_mutex_waiters(struct rt_mutex *lock)
 {
 	lock->owner = (struct task_struct *)
@@ -146,6 +155,7 @@ static void __rt_mutex_adjust_prio(struc
 
 	if (task->prio != prio)
 		rt_mutex_setprio(task, prio);
+	/* reschedules task if the priority is lower, holds the run queue lock */
 }
 
 /*
@@ -623,12 +633,14 @@ rt_spin_lock_fastlock(struct rt_mutex *l
 
 static inline void
 rt_spin_lock_fastlock(struct rt_mutex *lock,
-		void fastcall (*slowfn)(struct rt_mutex *lock))
+		void fastcall (*slowfn)(struct rt_mutex *lock
+						__COMMA_LOCK_STAT_IP_DECL)
+				__COMMA_LOCK_STAT_IP_DECL)
 {
 	if (likely(rt_mutex_cmpxchg(lock, NULL, current)))
 		rt_mutex_deadlock_account_lock(lock, current);
 	else
-		slowfn(lock);
+		slowfn(lock __COMMA_LOCK_STAT_IP);
 }
 
 static inline void
@@ -652,10 +664,13 @@ static void fastcall noinline __sched
  * sleep/wakeup event loops.
  */
 static void fastcall noinline __sched
-rt_spin_lock_slowlock(struct rt_mutex *lock)
+rt_spin_lock_slowlock(struct rt_mutex *lock __COMMA_LOCK_STAT_IP_DECL)
 {
 	struct rt_mutex_waiter waiter;
 	unsigned long saved_state, state, flags;
+#ifdef CONFIG_LOCK_STAT
+	struct task_struct *owner;
+#endif
 
 	debug_rt_mutex_init_waiter(&waiter);
 	waiter.task = NULL;
@@ -663,6 +678,13 @@ rt_spin_lock_slowlock(struct rt_mutex *l
 	spin_lock_irqsave(&lock->wait_lock, flags);
 	init_lists(lock);
 
+#ifdef CONFIG_LOCK_STAT
+		owner = rt_mutex_owner(lock);
+
+//		get_task_struct(owner);
+		lock_stat_note_contention(&lock->lock_stat, owner, _ip);
+//		put_task_struct(owner);
+#endif
 	/* Try to acquire the lock again: */
 	if (try_to_take_rt_mutex(lock)) {
 		spin_unlock_irqrestore(&lock->wait_lock, flags);
@@ -775,22 +797,40 @@ void __lockfunc rt_spin_lock(spinlock_t 
 
 void __lockfunc rt_spin_lock(spinlock_t *lock)
 {
-	rt_spin_lock_fastlock(&lock->lock, rt_spin_lock_slowlock);
+	rt_spin_lock_fastlock(&lock->lock, rt_spin_lock_slowlock
+						__COMMA_LOCK_STAT_RET_IP);
 	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
 }
 EXPORT_SYMBOL(rt_spin_lock);
 
 void __lockfunc __rt_spin_lock(struct rt_mutex *lock)
 {
-	rt_spin_lock_fastlock(lock, rt_spin_lock_slowlock);
+	rt_spin_lock_fastlock(lock, rt_spin_lock_slowlock
+						__COMMA_LOCK_STAT_RET_IP);
 }
 EXPORT_SYMBOL(__rt_spin_lock);
 
+#ifdef CONFIG_LOCK_STAT
+void __lockfunc rt_spin_lock_with_ip(spinlock_t *lock, unsigned long _ip)
+{
+	rt_spin_lock_fastlock(&lock->lock, rt_spin_lock_slowlock, _ip);
+	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
+}
+EXPORT_SYMBOL(rt_spin_lock_with_ip);
+
+void __lockfunc __rt_spin_lock_with_ip(struct rt_mutex *lock, unsigned long _ip)
+{
+	rt_spin_lock_fastlock(lock, rt_spin_lock_slowlock, _ip);
+}
+EXPORT_SYMBOL(__rt_spin_lock_with_ip);
+#endif
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 
 void __lockfunc rt_spin_lock_nested(spinlock_t *lock, int subclass)
 {
-	rt_spin_lock_fastlock(&lock->lock, rt_spin_lock_slowlock);
+	rt_spin_lock_fastlock(&lock->lock, rt_spin_lock_slowlock
+						__COMMA_LOCK_STAT_RET_IP);
 	spin_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
 }
 EXPORT_SYMBOL(rt_spin_lock_nested);
@@ -823,10 +863,20 @@ EXPORT_SYMBOL(rt_spin_unlock_wait);
 }
 EXPORT_SYMBOL(rt_spin_unlock_wait);
 
+#if 0
+//#ifdef CONFIG_LOCK_STAT
+#define __RT_MUTEX_TRYLOCK_WITH_IP(a)	\
+	rt_mutex_trylock_with_ip(a, (unsigned long) __builtin_return_address(0));
+#else
+#define __RT_MUTEX_TRYLOCK_WITH_IP(a)	\
+	rt_mutex_trylock(a);
+#endif
+
 int __lockfunc rt_spin_trylock(spinlock_t *lock)
 {
-	int ret = rt_mutex_trylock(&lock->lock);
+	int ret;
 
+	ret = __RT_MUTEX_TRYLOCK_WITH_IP(&lock->lock)
 	if (ret)
 		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
 
@@ -839,7 +889,8 @@ int __lockfunc rt_spin_trylock_irqsave(s
 	int ret;
 
 	*flags = 0;
-	ret = rt_mutex_trylock(&lock->lock);
+
+	ret = __RT_MUTEX_TRYLOCK_WITH_IP(&lock->lock)
 	if (ret)
 		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
 
@@ -852,7 +903,11 @@ int _atomic_dec_and_spin_lock(atomic_t *
 	/* Subtract 1 from counter unless that drops it to 0 (ie. it was 1) */
 	if (atomic_add_unless(atomic, -1, 1))
 		return 0;
+#ifdef CONFIG_LOCK_STAT
+	rt_spin_lock_with_ip(lock, (unsigned long) __builtin_return_address(0));
+#else
 	rt_spin_lock(lock);
+#endif
 	if (atomic_dec_and_test(atomic))
 		return 1;
 	rt_spin_unlock(lock);
@@ -861,7 +916,8 @@ void
 EXPORT_SYMBOL(_atomic_dec_and_spin_lock);
 
 void
-__rt_spin_lock_init(spinlock_t *lock, char *name, struct lock_class_key *key)
+__rt_spin_lock_init(spinlock_t *lock, char *name, struct lock_class_key *key
+			__COMMA_LOCK_STAT_NOTE_PARAM_DECL)
 {
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	/*
@@ -870,12 +926,31 @@ __rt_spin_lock_init(spinlock_t *lock, ch
 	debug_check_no_locks_freed((void *)lock, sizeof(*lock));
 	lockdep_init_map(&lock->dep_map, name, key, 0);
 #endif
-	__rt_mutex_init(&lock->lock, name);
+	__rt_mutex_init(&lock->lock, name __COMMA_LOCK_STAT_NOTE_VARS);
 }
 EXPORT_SYMBOL(__rt_spin_lock_init);
 
+#ifdef CONFIG_LOCK_STAT
+void
+__rt_spin_lock_init_annotated(spinlock_t *lock, char *name,
+				struct lock_class_key *key,
+				LOCK_STAT_NOTE_PARAM_DECL,
+				struct lock_stat *lsobject)
+{
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	/*
+	 * Make sure we are not reinitializing a held lock:
+	 */
+	debug_check_no_locks_freed((void *)lock, sizeof(*lock));
+	lockdep_init_map(&lock->dep_map, name, key, 0);
 #endif
+	__rt_mutex_init_annotated(&lock->lock, name, LOCK_STAT_NOTE_VARS, lsobject);
+}
+EXPORT_SYMBOL(__rt_spin_lock_init_annotated);
+#endif
 
+#endif
+
 #ifdef CONFIG_PREEMPT_BKL
 
 static inline int rt_release_bkl(struct rt_mutex *lock, unsigned long flags)
@@ -914,11 +989,15 @@ rt_mutex_slowlock(struct rt_mutex *lock,
 static int __sched
 rt_mutex_slowlock(struct rt_mutex *lock, int state,
 		  struct hrtimer_sleeper *timeout,
-		  int detect_deadlock)
+		  int detect_deadlock
+			__COMMA_LOCK_STAT_IP_DECL)
 {
 	int ret = 0, saved_lock_depth = -1;
 	struct rt_mutex_waiter waiter;
 	unsigned long flags;
+#ifdef CONFIG_LOCK_STAT
+	struct task_struct *owner;
+#endif
 
 	debug_rt_mutex_init_waiter(&waiter);
 	waiter.task = NULL;
@@ -926,6 +1005,13 @@ rt_mutex_slowlock(struct rt_mutex *lock,
 	spin_lock_irqsave(&lock->wait_lock, flags);
 	init_lists(lock);
 
+#ifdef CONFIG_LOCK_STAT
+		owner = rt_mutex_owner(lock);
+
+//		get_task_struct(owner);
+		lock_stat_note_contention(&lock->lock_stat, owner, _ip);
+//		put_task_struct(owner);
+#endif
 	/* Try to acquire the lock again: */
 	if (try_to_take_rt_mutex(lock)) {
 		spin_unlock_irqrestore(&lock->wait_lock, flags);
@@ -937,7 +1023,11 @@ rt_mutex_slowlock(struct rt_mutex *lock,
 	 * possible deadlock in the scheduler.
 	 */
 	if (unlikely(current->lock_depth >= 0))
+#ifdef CONFIG_PREEMPT_BKL
 		saved_lock_depth = rt_release_bkl(lock, flags);
+#else
+		saved_lock_depth = rt_release_bkl(lock);
+#endif
 
 	set_current_state(state);
 
@@ -1040,11 +1130,23 @@ static inline int
  * Slow path try-lock function:
  */
 static inline int
-rt_mutex_slowtrylock(struct rt_mutex *lock)
+rt_mutex_slowtrylock(struct rt_mutex *lock __COMMA_LOCK_STAT_IP_DECL)
 {
 	unsigned long flags;
 	int ret = 0;
+#ifdef CONFIG_LOCK_STAT
+	struct task_struct *owner;
+#endif
 
+	debug_rt_mutex_init_waiter(&waiter);
+
+#ifdef CONFIG_LOCK_STAT
+	owner = rt_mutex_owner(lock);
+
+//	get_task_struct(owner);
+	lock_stat_note_contention(&lock->lock_stat, owner, _ip);
+//	put_task_struct(owner);
+#endif
 	spin_lock_irqsave(&lock->wait_lock, flags);
 
 	if (likely(rt_mutex_owner(lock) != current)) {
@@ -1057,6 +1159,7 @@ rt_mutex_slowtrylock(struct rt_mutex *lo
 		 * bit unconditionally. Clean this up.
 		 */
 		fixup_rt_mutex_waiters(lock);
+
 	}
 
 	spin_unlock_irqrestore(&lock->wait_lock, flags);
@@ -1103,38 +1206,62 @@ rt_mutex_fastlock(struct rt_mutex *lock,
 		  int detect_deadlock,
 		  int (*slowfn)(struct rt_mutex *lock, int state,
 				struct hrtimer_sleeper *timeout,
-				int detect_deadlock))
+				int detect_deadlock __COMMA_LOCK_STAT_IP_DECL)
+				__COMMA_LOCK_STAT_IP_DECL)
 {
 	if (!detect_deadlock && likely(rt_mutex_cmpxchg(lock, NULL, current))) {
 		rt_mutex_deadlock_account_lock(lock, current);
 		return 0;
 	} else
-		return slowfn(lock, state, NULL, detect_deadlock);
+		return slowfn(lock, state, NULL, detect_deadlock
+							__COMMA_LOCK_STAT_RET_IP);
 }
 
+#ifdef CONFIG_LOCK_STAT
 static inline int
+rt_mutex_fastlock_with_ip(struct rt_mutex *lock, int state,
+		  int detect_deadlock,
+		  int (*slowfn)(struct rt_mutex *lock, int state,
+				struct hrtimer_sleeper *timeout,
+				int detect_deadlock, unsigned long _ip),
+		  unsigned long _ip)
+{
+	if (!detect_deadlock && likely(rt_mutex_cmpxchg(lock, NULL, current))) {
+		rt_mutex_deadlock_account_lock(lock, current);
+		return 0;
+	} else
+		return slowfn(lock, state, NULL, detect_deadlock, _ip);
+}
+#endif
+
+static inline int
 rt_mutex_timed_fastlock(struct rt_mutex *lock, int state,
 			struct hrtimer_sleeper *timeout, int detect_deadlock,
 			int (*slowfn)(struct rt_mutex *lock, int state,
 				      struct hrtimer_sleeper *timeout,
-				      int detect_deadlock))
+				      int detect_deadlock
+					__COMMA_LOCK_STAT_IP_DECL)
+			__COMMA_LOCK_STAT_IP_DECL)
 {
 	if (!detect_deadlock && likely(rt_mutex_cmpxchg(lock, NULL, current))) {
 		rt_mutex_deadlock_account_lock(lock, current);
 		return 0;
 	} else
-		return slowfn(lock, state, timeout, detect_deadlock);
+		return slowfn(lock, state, timeout, detect_deadlock
+							__COMMA_LOCK_STAT_IP);
 }
 
 static inline int
 rt_mutex_fasttrylock(struct rt_mutex *lock,
-		     int (*slowfn)(struct rt_mutex *lock))
+		     int (*slowfn)(struct rt_mutex *lock
+					__COMMA_LOCK_STAT_IP_DECL)
+			__COMMA_LOCK_STAT_IP_DECL)
 {
 	if (likely(rt_mutex_cmpxchg(lock, NULL, current))) {
 		rt_mutex_deadlock_account_lock(lock, current);
 		return 1;
 	}
-	return slowfn(lock);
+	return slowfn(lock __COMMA_LOCK_STAT_IP);
 }
 
 static inline void
@@ -1147,6 +1274,17 @@ rt_mutex_fastunlock(struct rt_mutex *loc
 		slowfn(lock);
 }
 
+#define PANIC_IF_IN_ATOMIC()					\
+	if (							\
+	    (system_state == SYSTEM_RUNNING) &&			\
+	     in_atomic() &&					\
+	     !oops_in_progress &&				\
+	     !current->exit_state				\
+	     ) {						\
+		panic("%s: in atomic: " "%s/0x%08x/%d\n",	\
+			__func__, current->comm, preempt_count(), current->pid);	\
+	}
+
 /**
  * rt_mutex_lock - lock a rt_mutex
  *
@@ -1155,11 +1293,26 @@ void __sched rt_mutex_lock(struct rt_mut
 void __sched rt_mutex_lock(struct rt_mutex *lock)
 {
 	might_sleep();
+	PANIC_IF_IN_ATOMIC();
 
-	rt_mutex_fastlock(lock, TASK_UNINTERRUPTIBLE, 0, rt_mutex_slowlock);
+	rt_mutex_fastlock(lock, TASK_UNINTERRUPTIBLE, 0, rt_mutex_slowlock
+							__COMMA_LOCK_STAT_RET_IP);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_lock);
 
+#ifdef CONFIG_LOCK_STAT
+void __sched rt_mutex_lock_with_ip(struct rt_mutex *lock, unsigned long ip)
+{
+	might_sleep();
+	PANIC_IF_IN_ATOMIC();
+
+	rt_mutex_fastlock_with_ip(lock, TASK_UNINTERRUPTIBLE, 0, rt_mutex_slowlock,
+										ip);
+}
+EXPORT_SYMBOL_GPL(rt_mutex_lock_with_ip);
+#endif
+
+
 /**
  * rt_mutex_lock_interruptible - lock a rt_mutex interruptible
  *
@@ -1175,11 +1328,23 @@ int __sched rt_mutex_lock_interruptible(
 						 int detect_deadlock)
 {
 	might_sleep();
+	return rt_mutex_fastlock(lock, TASK_INTERRUPTIBLE,
+				 detect_deadlock, rt_mutex_slowlock
+							__COMMA_LOCK_STAT_RET_IP);
+}
+EXPORT_SYMBOL_GPL(rt_mutex_lock_interruptible);
 
+#ifdef CONFIG_LOCK_STAT
+int __sched rt_mutex_lock_interruptible_with_ip(struct rt_mutex *lock,
+						int detect_deadlock,
+						unsigned long ip)
+{
+	might_sleep();
 	return rt_mutex_fastlock(lock, TASK_INTERRUPTIBLE,
-				 detect_deadlock, rt_mutex_slowlock);
+				 detect_deadlock, rt_mutex_slowlock, ip);
 }
-EXPORT_SYMBOL_GPL(rt_mutex_lock_interruptible);
+EXPORT_SYMBOL_GPL(rt_mutex_lock_interruptible_with_ip);
+#endif
 
 /**
  * rt_mutex_lock_interruptible_ktime - lock a rt_mutex interruptible
@@ -1203,7 +1368,8 @@ rt_mutex_timed_lock(struct rt_mutex *loc
 	might_sleep();
 
 	return rt_mutex_timed_fastlock(lock, TASK_INTERRUPTIBLE, timeout,
-				       detect_deadlock, rt_mutex_slowlock);
+				       detect_deadlock, rt_mutex_slowlock
+					__COMMA_LOCK_STAT_RET_IP);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_timed_lock);
 
@@ -1216,7 +1382,8 @@ int __sched rt_mutex_trylock(struct rt_m
  */
 int __sched rt_mutex_trylock(struct rt_mutex *lock)
 {
-	return rt_mutex_fasttrylock(lock, rt_mutex_slowtrylock);
+	return rt_mutex_fasttrylock(lock, rt_mutex_slowtrylock
+							__COMMA_LOCK_STAT_RET_IP);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_trylock);
 
@@ -1231,6 +1398,14 @@ EXPORT_SYMBOL_GPL(rt_mutex_unlock);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_unlock);
 
+#ifdef CONFIG_LOCK_STAT
+int __sched rt_mutex_trylock_with_ip(struct rt_mutex *lock, unsigned long _ip)
+{
+	return rt_mutex_fasttrylock(lock, rt_mutex_slowtrylock, _ip);
+}
+EXPORT_SYMBOL_GPL(rt_mutex_trylock_with_ip);
+#endif
+
 /***
  * rt_mutex_destroy - mark a mutex unusable
  * @lock: the mutex to be destroyed
@@ -1258,16 +1433,50 @@ EXPORT_SYMBOL_GPL(rt_mutex_destroy);
  *
  * Initializing of a locked rt lock is not allowed
  */
-void __rt_mutex_init(struct rt_mutex *lock, const char *name)
+void __rt_mutex_init(struct rt_mutex *lock, const char *name
+			__COMMA_LOCK_STAT_NOTE_PARAM_DECL)
 {
-	lock->owner = NULL;
-	spin_lock_init(&lock->wait_lock);
+	rt_mutex_clear_owner(lock);
+	spin_lock_init(&lock->wait_lock); /* raw spinlock here */
 	plist_head_init(&lock->wait_list, &lock->wait_lock);
 
 	debug_rt_mutex_init(lock, name);
+#ifdef CONFIG_LOCK_STAT
+	lock->lock_stat = NULL;
+	lock_stat_scoped_attach(&lock->lock_stat, LOCK_STAT_NOTE_VARS);
+#endif
 }
 EXPORT_SYMBOL_GPL(__rt_mutex_init);
 
+/*
+ * Annotated version of lock_stat
+ */
+#ifdef CONFIG_LOCK_STAT
+void __rt_mutex_init_annotated(struct rt_mutex *lock, const char *name,
+				LOCK_STAT_NOTE_PARAM_DECL,
+				struct lock_stat *lsobject)
+{
+	rt_mutex_clear_owner(lock);
+	spin_lock_init(&lock->wait_lock); /* raw spinlock here */
+	plist_head_init(&lock->wait_list, &lock->wait_lock);
+
+	debug_rt_mutex_init(lock, name);
+
+	BUG_ON(!lsobject);
+	lock->lock_stat = lsobject;
+
+	if(!lock_stat_is_initialized(&lock->lock_stat))
+	{
+		ksym_strcpy(lock->lock_stat->function, _function);
+		lock->lock_stat->file	= (char *) _file;
+		lock->lock_stat->line	= _line;
+	}
+
+	atomic_inc(&lock->lock_stat->ninlined);
+}
+#endif
+EXPORT_SYMBOL_GPL(__rt_mutex_init_annotated);
+
 /**
  * rt_mutex_init_proxy_locked - initialize and lock a rt_mutex on behalf of a
  *				proxy owner
@@ -1281,7 +1490,7 @@ void rt_mutex_init_proxy_locked(struct r
 void rt_mutex_init_proxy_locked(struct rt_mutex *lock,
 				struct task_struct *proxy_owner)
 {
-	__rt_mutex_init(lock, NULL);
+	__rt_mutex_init(lock, NULL __COMMA_LOCK_STAT_NOTE);
 	debug_rt_mutex_proxy_lock(lock, proxy_owner);
 	rt_mutex_set_owner(lock, proxy_owner, 0);
 	rt_mutex_deadlock_account_lock(lock, proxy_owner);

--A6N2fC+uXW/VQSAv--
