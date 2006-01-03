Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbWACXLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbWACXLv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964873AbWACXID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:08:03 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:42911 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964838AbWACXH1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:07:27 -0500
Date: Wed, 4 Jan 2006 00:07:12 +0100
From: Ingo Molnar <mingo@elte.hu>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [patch 08/20] mutex subsystem, core
Message-ID: <20060103230712.GI13511@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.0 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.8 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


mutex implementation, core files: just the basic subsystem, no users of it.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@infradead.org>

----

 include/linux/mutex.h |  111 ++++++++++++++++
 kernel/Makefile       |    2 
 kernel/mutex.c        |  346 ++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/mutex.h        |   35 +++++
 4 files changed, 493 insertions(+), 1 deletion(-)

Index: linux/include/linux/mutex.h
===================================================================
--- /dev/null
+++ linux/include/linux/mutex.h
@@ -0,0 +1,111 @@
+/*
+ * Mutexes: blocking mutual exclusion locks
+ *
+ * started by Ingo Molnar:
+ *
+ *  Copyright (C) 2004, 2005 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
+ *
+ * This file contains the main data structure and API definitions.
+ */
+#ifndef __LINUX_MUTEX_H
+#define __LINUX_MUTEX_H
+
+#include <linux/list.h>
+#include <linux/spinlock_types.h>
+
+#include <asm/atomic.h>
+
+/*
+ * Simple, straightforward mutexes with strict semantics:
+ *
+ * - only one task can hold the mutex at a time
+ * - only the owner can unlock the mutex
+ * - multiple unlocks are not permitted
+ * - recursive locking is not permitted
+ * - a mutex object must be initialized via the API
+ * - a mutex object must not be initialized via memset or copying
+ * - task may not exit with mutex held
+ * - memory areas where held locks reside must not be freed
+ * - held mutexes must not be reinitialized
+ * - mutexes may not be used in irq contexts
+ *
+ * These semantics are fully enforced when DEBUG_MUTEXES is
+ * enabled. Furthermore, besides enforcing the above rules, the mutex
+ * debugging code also implements a number of additional features
+ * that make lock debugging easier and faster:
+ *
+ * - uses symbolic names of mutexes, whenever they are printed in debug output
+ * - point-of-acquire tracking, symbolic lookup of function names
+ * - list of all locks held in the system, printout of them
+ * - owner tracking
+ * - detects self-recursing locks and prints out all relevant info
+ * - detects multi-task circular deadlocks and prints out all affected
+ *   locks and tasks (and only those tasks)
+ */
+struct mutex {
+	/* 1: unlocked, 0: locked, negative: locked, possible waiters */
+	atomic_t		count;
+	spinlock_t		wait_lock;
+	struct list_head	wait_list;
+#ifdef CONFIG_DEBUG_MUTEXES
+	struct thread_info	*owner;
+	struct list_head	held_list;
+	unsigned long		acquire_ip;
+	const char 		*name;
+	void			*magic;
+#endif
+};
+
+/*
+ * This is the control structure for tasks blocked on mutex,
+ * which resides on the blocked task's kernel stack:
+ */
+struct mutex_waiter {
+	struct list_head	list;
+	struct thread_info	*ti;
+#ifdef CONFIG_DEBUG_MUTEXES
+	struct mutex		*lock;
+	void			*magic;
+#endif
+};
+
+#ifdef CONFIG_DEBUG_MUTEXES
+# include <linux/mutex-debug.h>
+#else
+# define __DEBUG_MUTEX_INITIALIZER(lockname)
+# define mutex_init(mutex)			__mutex_init(mutex, NULL)
+# define mutex_destroy(mutex)				do { } while (0)
+# define mutex_debug_show_all_locks()			do { } while (0)
+# define mutex_debug_show_held_locks(p)			do { } while (0)
+# define mutex_debug_check_no_locks_held(task)		do { } while (0)
+# define mutex_debug_check_no_locks_freed(from, to)	do { } while (0)
+#endif
+
+#define __MUTEX_INITIALIZER(lockname) \
+		{ .count = ATOMIC_INIT(1) \
+		, .wait_lock = SPIN_LOCK_UNLOCKED \
+		, .wait_list = LIST_HEAD_INIT(lockname.wait_list) \
+		__DEBUG_MUTEX_INITIALIZER(lockname) }
+
+#define DEFINE_MUTEX(mutexname) \
+	struct mutex mutexname = __MUTEX_INITIALIZER(mutexname)
+
+extern void FASTCALL(__mutex_init(struct mutex *lock, const char *name));
+
+/***
+ * mutex_is_locked - is the mutex locked
+ * @lock: the mutex to be queried
+ *
+ * Returns 1 if the mutex is locked, 0 if unlocked.
+ */
+static inline int fastcall mutex_is_locked(struct mutex *lock)
+{
+	return atomic_read(&lock->count) != 1;
+}
+
+extern void FASTCALL(mutex_lock(struct mutex *lock));
+extern int FASTCALL(mutex_lock_interruptible(struct mutex *lock));
+extern int FASTCALL(mutex_trylock(struct mutex *lock));
+extern void FASTCALL(mutex_unlock(struct mutex *lock));
+
+#endif
Index: linux/kernel/Makefile
===================================================================
--- linux.orig/kernel/Makefile
+++ linux/kernel/Makefile
@@ -7,7 +7,7 @@ obj-y     = sched.o fork.o exec_domain.o
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
-	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o
+	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o mutex.o
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
Index: linux/kernel/mutex.c
===================================================================
--- /dev/null
+++ linux/kernel/mutex.c
@@ -0,0 +1,346 @@
+/*
+ * kernel/mutex.c
+ *
+ * Mutexes: blocking mutual exclusion locks
+ *
+ * Started by Ingo Molnar:
+ *
+ *  Copyright (C) 2004, 2005 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
+ *
+ * Many thanks to Arjan van de Ven, Thomas Gleixner, Steven Rostedt and
+ * David Howells for suggestions and improvements.
+ */
+#include <linux/mutex.h>
+#include <linux/sched.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+
+/*
+ * In the DEBUG case we are using the "NULL fastpath" for mutexes,
+ * which forces all calls into the slowpath:
+ */
+#ifdef CONFIG_DEBUG_MUTEXES
+# include "mutex-debug.h"
+# include <asm-generic/mutex-null.h>
+#else
+# include "mutex.h"
+# include <asm/mutex.h>
+#endif
+
+/*
+ * Lock a mutex (possibly interruptible), slowpath:
+ */
+static int __sched
+__mutex_lock_common(struct mutex *lock, int state __IP_DECL__)
+{
+	struct thread_info *ti = current_thread_info();
+	struct mutex_waiter waiter;
+	unsigned int old_val;
+
+	debug_mutex_init_waiter(&waiter);
+
+	spin_lock_mutex(&lock->wait_lock);
+
+	/*
+	 * Lets try to take the lock again - this is needed even if
+	 * we get here for the first time (shortly after failing to
+	 * acquire the lock), to make sure that we get a wakeup once
+	 * it's unlocked. Later on this is the operation that gives
+	 * us the lock. So we xchg it to -1, so that when we release
+	 * the lock, we properly wake up the other waiters:
+	 */
+	old_val = atomic_xchg(&lock->count, -1);
+	if (unlikely(old_val == 1))
+		goto got_the_lock;
+
+	debug_mutex_add_waiter(lock, &waiter, ti, ip);
+
+	/* add waiting tasks to the end of the waitqueue (FIFO): */
+	list_add_tail(&waiter.list, &lock->wait_list);
+	waiter.ti = ti;
+
+	for (;;) {
+		__set_task_state(ti->task, state);
+
+		/* didnt get the lock, go to sleep: */
+		spin_unlock_mutex(&lock->wait_lock);
+		schedule();
+		spin_lock_mutex(&lock->wait_lock);
+
+		/* try to take the lock again: */
+		old_val = atomic_xchg(&lock->count, -1);
+
+		/* got the lock? */
+		if (likely(old_val == 1)) {
+			mutex_remove_waiter(lock, &waiter, ti);
+			break;
+		}
+
+		/* got a signal? */
+		if (unlikely(state == TASK_INTERRUPTIBLE &&
+						signal_pending(ti->task))) {
+			mutex_remove_waiter(lock, &waiter, ti);
+			spin_unlock_mutex(&lock->wait_lock);
+
+			debug_mutex_free_waiter(&waiter);
+			return -EINTR;
+		}
+	}
+
+got_the_lock:
+	/* got the lock - rejoice: */
+	debug_mutex_set_owner(lock, ti __IP__);
+
+	/* set it to 0 if there are no waiters left: */
+	if (likely(list_empty(&lock->wait_list)))
+		atomic_set(&lock->count, 0);
+
+	spin_unlock_mutex(&lock->wait_lock);
+
+	debug_mutex_free_waiter(&waiter);
+
+	DEBUG_WARN_ON(list_empty(&lock->held_list));
+	DEBUG_WARN_ON(lock->owner != ti);
+
+	return 0;
+}
+
+/*
+ * Spinlock based trylock, we take the spinlock and check whether we
+ * can get the lock:
+ */
+static inline int __mutex_trylock_nonatomic(atomic_t *lock_count)
+{
+	struct mutex *lock = container_of(lock_count, struct mutex, count);
+	int prev;
+
+	spin_lock_mutex(&lock->wait_lock);
+
+	prev = atomic_xchg(&lock->count, -1);
+	if (likely(prev == 1))
+		debug_mutex_set_owner(lock, current_thread_info() __RET_IP__);
+	/* Set it back to 0 if there are no waiters: */
+	if (likely(list_empty(&lock->wait_list)))
+		atomic_set(&lock->count, 0);
+
+	spin_unlock_mutex(&lock->wait_lock);
+
+	return prev == 1;
+}
+
+/*
+ * Release the lock, slowpath:
+ */
+static inline void __mutex_unlock_nonatomic(struct mutex *lock __IP_DECL__)
+{
+	DEBUG_WARN_ON(lock->owner != current_thread_info());
+
+	spin_lock_mutex(&lock->wait_lock);
+
+	/*
+	 * some architectures leave the lock unlocked in the fastpath failure
+	 * case, others need to leave it locked. In the later case we have to
+	 * unlock it here
+	 */
+	if (__mutex_slowpath_needs_to_unlock())
+		atomic_set(&lock->count, 1);
+
+	debug_mutex_unlock(lock);
+
+	if (!list_empty(&lock->wait_list)) {
+		/* get the first entry from the wait-list: */
+		struct mutex_waiter *waiter =
+				list_entry(lock->wait_list.next,
+					   struct mutex_waiter, list);
+
+		debug_mutex_wake_waiter(lock, waiter);
+
+		wake_up_process(waiter->ti->task);
+	}
+
+	debug_mutex_clear_owner(lock);
+
+	spin_unlock_mutex(&lock->wait_lock);
+}
+
+/*
+ * We split it into a fastpath and a separate slowpath function,
+ * to reduce the register pressure on the fastpath:
+ *
+ * We want the atomic ops to come first in the kernel image, to make
+ * sure the branch is predicted by the CPU as default-untaken:
+ */
+static __sched void FASTCALL(__mutex_lock_noinline(atomic_t *lock_count
+						   __IP_DECL__));
+
+/*
+ * The locking fastpath is the 1->0 transition from 'unlocked' into
+ * 'locked' state:
+ */
+static inline void __mutex_lock_atomic(struct mutex *lock __IP_DECL__)
+{
+	__mutex_fastpath_lock(&lock->count, __mutex_lock_noinline);
+}
+
+static void fastcall __sched
+__mutex_lock_noinline(atomic_t *lock_count __IP_DECL__)
+{
+	struct mutex *lock = container_of(lock_count, struct mutex, count);
+
+	__mutex_lock_common(lock, TASK_UNINTERRUPTIBLE __IP__);
+}
+
+static inline void __mutex_lock(struct mutex *lock __IP_DECL__)
+{
+	__mutex_lock_atomic(lock __IP__);
+}
+
+static int fastcall __sched
+__mutex_lock_interruptible_noinline(atomic_t *lock_count __IP_DECL__);
+
+static inline int __mutex_lock_interruptible(struct mutex *lock __IP_DECL__)
+{
+	return __mutex_fastpath_lock_retval
+			(&lock->count, __mutex_lock_interruptible_noinline);
+}
+
+static int fastcall __sched
+__mutex_lock_interruptible_noinline(atomic_t *lock_count __IP_DECL__)
+{
+	struct mutex *lock = container_of(lock_count, struct mutex, count);
+
+	return __mutex_lock_common(lock, TASK_INTERRUPTIBLE __IP__);
+}
+
+static void __sched FASTCALL(__mutex_unlock_noinline(atomic_t *lock_count
+						     __IP_DECL__));
+
+/*
+ * The unlocking fastpath is the 0->1 transition from 'locked' into
+ * 'unlocked' state:
+ */
+static inline void __mutex_unlock_atomic(struct mutex *lock __IP_DECL__)
+{
+	__mutex_fastpath_unlock(&lock->count, __mutex_unlock_noinline);
+}
+
+static void fastcall __sched __mutex_unlock_noinline(atomic_t *lock_count
+						     __IP_DECL__)
+{
+	struct mutex *lock = container_of(lock_count, struct mutex, count);
+
+	__mutex_unlock_nonatomic(lock __IP__);
+}
+
+static inline void __mutex_unlock(struct mutex *lock __IP_DECL__)
+{
+	__mutex_unlock_atomic(lock __IP__);
+}
+
+/***
+ * mutex_lock - acquire the mutex
+ * @lock: the mutex to be acquired
+ *
+ * Lock the mutex exclusively for this task. If the mutex is not
+ * available right now, it will sleep until it can get it.
+ *
+ * The mutex must later on be released by the same task that
+ * acquired it. Recursive locking is not allowed. The task
+ * may not exit without first unlocking the mutex. Also, kernel
+ * memory where the mutex resides mutex must not be freed with
+ * the mutex still locked. The mutex must first be initialized
+ * (or statically defined) before it can be locked. memset()-ing
+ * the mutex to 0 is not allowed.
+ *
+ * ( The CONFIG_DEBUG_MUTEXES .config option turns on debugging
+ *   checks that will enforce the restrictions and will also do
+ *   deadlock debugging. )
+ *
+ * This function is similar to (but not equivalent to) down().
+ */
+void fastcall __sched mutex_lock(struct mutex *lock)
+{
+	might_sleep();
+	__mutex_lock(lock __RET_IP__);
+}
+
+EXPORT_SYMBOL(mutex_lock);
+
+/***
+ * mutex_unlock - release the mutex
+ * @lock: the mutex to be released
+ *
+ * Unlock a mutex that has been locked by this task previously.
+ *
+ * This function must not be used in interrupt context. Unlocking
+ * of a not locked mutex is not allowed.
+ *
+ * This function is similar to (but not equivalent to) up().
+ */
+void fastcall __sched mutex_unlock(struct mutex *lock)
+{
+	__mutex_unlock(lock __RET_IP__);
+}
+
+EXPORT_SYMBOL(mutex_unlock);
+
+/***
+ * mutex_trylock - try acquire the mutex, without waiting
+ * @lock: the mutex to be acquired
+ *
+ * Try to acquire the mutex atomically. Returns 1 if the mutex
+ * has been acquired successfully, and 0 on contention.
+ *
+ * NOTE: this function follows the spin_trylock() convention, so
+ * it is negated to the down_trylock() return values! Be careful
+ * about this when converting semaphore users to mutexes.
+ *
+ * This function must not be used in interrupt context. The
+ * mutex must be released by the same task that acquired it.
+ */
+int fastcall mutex_trylock(struct mutex *lock)
+{
+	return __mutex_fastpath_trylock(&lock->count,
+					__mutex_trylock_nonatomic);
+}
+
+EXPORT_SYMBOL(mutex_trylock);
+
+/***
+ * mutex_lock_interruptible - acquire the mutex, interruptable
+ * @lock: the mutex to be acquired
+ *
+ * Lock the mutex like mutex_lock(), and return 0 if the mutex has
+ * been acquired or sleep until the mutex becomes available. If a
+ * signal arrives while waiting for the lock then this function
+ * returns -EINTR.
+ *
+ * This function is similar to (but not equivalent to) down_interruptible().
+ */
+int fastcall __sched mutex_lock_interruptible(struct mutex *lock)
+{
+	might_sleep();
+	return __mutex_lock_interruptible(lock __RET_IP__);
+}
+
+EXPORT_SYMBOL(mutex_lock_interruptible);
+
+/***
+ * mutex_init - initialize the mutex
+ * @lock: the mutex to be initialized
+ *
+ * Initialize the mutex to unlocked state.
+ *
+ * It is not allowed to initialize an already locked mutex.
+ */
+void fastcall __mutex_init(struct mutex *lock, const char *name)
+{
+	atomic_set(&lock->count, 1);
+	spin_lock_init(&lock->wait_lock);
+	INIT_LIST_HEAD(&lock->wait_list);
+
+	debug_mutex_init(lock, name);
+}
+EXPORT_SYMBOL(__mutex_init);
+
Index: linux/kernel/mutex.h
===================================================================
--- /dev/null
+++ linux/kernel/mutex.h
@@ -0,0 +1,35 @@
+/*
+ * Mutexes: blocking mutual exclusion locks
+ *
+ * started by Ingo Molnar:
+ *
+ *  Copyright (C) 2004, 2005 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
+ *
+ * This file contains mutex debugging related internal prototypes, for the
+ * !CONFIG_DEBUG_MUTEXES case. Most of them are NOPs:
+ */
+
+#define spin_lock_mutex(lock)			spin_lock(lock)
+#define spin_unlock_mutex(lock)			spin_unlock(lock)
+#define mutex_remove_waiter(lock, waiter, ti) \
+		__list_del((waiter)->list.prev, (waiter)->list.next)
+
+#define DEBUG_WARN_ON(c)				do { } while (0)
+#define debug_mutex_set_owner(lock, new_owner)		do { } while (0)
+#define debug_mutex_clear_owner(lock)			do { } while (0)
+#define debug_mutex_init_waiter(waiter)			do { } while (0)
+#define debug_mutex_wake_waiter(lock, waiter)		do { } while (0)
+#define debug_mutex_free_waiter(waiter)			do { } while (0)
+#define debug_mutex_add_waiter(lock, waiter, ti, ip)	do { } while (0)
+#define debug_mutex_unlock(lock)			do { } while (0)
+#define debug_mutex_init(lock, name)			do { } while (0)
+
+/*
+ * Return-address parameters/declarations. They are very useful for
+ * debugging, but add overhead in the !DEBUG case - so we go the
+ * trouble of using this not too elegant but zero-cost solution:
+ */
+#define __IP_DECL__
+#define __IP__
+#define __RET_IP__
+
