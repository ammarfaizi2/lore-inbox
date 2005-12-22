Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbVLVPjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbVLVPjR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 10:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbVLVPit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 10:38:49 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:48536 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751162AbVLVPio (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 10:38:44 -0500
Date: Thu, 22 Dec 2005 16:37:56 +0100
From: Ingo Molnar <mingo@elte.hu>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [patch 05/10] mutex subsystem, core
Message-ID: <20051222153756.GF6090@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mutex implementation, core files: just the basic subsystem, no users of it.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 include/linux/mutex.h |  101 +++++++++
 kernel/Makefile       |    2 
 kernel/mutex.c        |  527 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 629 insertions(+), 1 deletion(-)

Index: linux/include/linux/mutex.h
===================================================================
--- /dev/null
+++ linux/include/linux/mutex.h
@@ -0,0 +1,101 @@
+#ifndef __LINUX_MUTEX_H
+#define __LINUX_MUTEX_H
+
+/*
+ * Mutexes: blocking mutual exclusion locks
+ *
+ * started by Ingo Molnar:
+ *
+ *  Copyright (C) 2004, 2005 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
+ *
+ * This file contains the main data structure and API definitions.
+ */
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
+extern void FASTCALL(mutex_lock(struct mutex *lock));
+extern int FASTCALL(mutex_lock_interruptible(struct mutex *lock));
+extern int FASTCALL(mutex_trylock(struct mutex *lock));
+extern void FASTCALL(mutex_unlock(struct mutex *lock));
+extern int FASTCALL(mutex_is_locked(struct mutex *lock));
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
@@ -0,0 +1,527 @@
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
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/kallsyms.h>
+#include <linux/interrupt.h>
+
+/*
+ * Various debugging wrappers - they are mostly NOPs in the !DEBUG case:
+ */
+#ifndef CONFIG_DEBUG_MUTEXES
+# define spin_lock_mutex(lock)			spin_lock(lock)
+# define spin_unlock_mutex(lock)		spin_unlock(lock)
+# define remove_waiter(lock, waiter, ti) \
+		__list_del((waiter)->list.prev, (waiter)->list.next)
+
+# define DEBUG_WARN_ON(c)			do { } while (0)
+# define debug_set_owner(lock, new_owner)	do { } while (0)
+# define debug_clear_owner(lock)		do { } while (0)
+# define debug_init_waiter(waiter)		do { } while (0)
+# define debug_wake_waiter(lock, waiter)	do { } while (0)
+# define debug_free_waiter(waiter)		do { } while (0)
+# define debug_add_waiter(lock, waiter, ti, ip)	do { } while (0)
+# define debug_mutex_unlock(lock)		do { } while (0)
+# define debug_mutex_init(lock, name)		do { } while (0)
+/*
+ * Return-address parameters/declarations are nonexistent in the !DEBUG case:
+ */
+# define __IP_DECL__
+# define __IP__
+# define __CALLER_IP__
+#else /* !CONFIG_DEBUG_MUTEXES: */
+# include "mutex-debug.c"
+#endif
+
+/***
+ * mutex_is_locked - is the mutex locked
+ * @lock: the mutex to be queried
+ *
+ * Returns 1 if the mutex is locked, 0 if unlocked.
+ */
+int fastcall mutex_is_locked(struct mutex *lock)
+{
+	return atomic_read(&lock->count) != 1;
+}
+
+EXPORT_SYMBOL_GPL(mutex_is_locked);
+
+/*
+ * Block on a lock - add ourselves to the list of waiters.
+ * Called with lock->wait_lock held.
+ */
+static inline void
+add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
+	   struct thread_info *ti, int add_to_head __IP_DECL__)
+{
+	debug_add_waiter(lock, waiter, ti, ip);
+
+	waiter->ti = ti;
+
+	/*
+	 * Add waiting tasks to the end of the waitqueue (FIFO),
+	 * but add repeat waiters to the head (LIFO):
+	 */
+	if (add_to_head)
+		list_add(&waiter->list, &lock->wait_list);
+	else
+		list_add_tail(&waiter->list, &lock->wait_list);
+}
+
+/*
+ * Wake up a task and make it the new owner of the mutex:
+ */
+static inline void
+mutex_wakeup_waiter(struct mutex *lock __IP_DECL__)
+{
+	struct mutex_waiter *waiter;
+
+	/* get the first entry from the wait-list: */
+	waiter = list_entry(lock->wait_list.next, struct mutex_waiter, list);
+
+	debug_wake_waiter(lock, waiter);
+
+	wake_up_process(waiter->ti->task);
+}
+
+/*
+ * Lock a mutex, common slowpath. We just decremented the count,
+ * and it got negative as a result.
+ *
+ * We enter with the lock held, and return with it released.
+ */
+static inline int
+__mutex_lock_common(struct mutex *lock, struct mutex_waiter *waiter,
+		    struct thread_info *ti, unsigned long task_state,
+		    const int add_to_head __IP_DECL__)
+{
+	struct task_struct *task = ti->task;
+	unsigned int old_val;
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
+
+	if (unlikely(old_val == 1)) {
+		/*
+		 * Got the lock - rejoice! But there's one small
+		 * detail to fix up: above we have set the lock to -1,
+		 * unconditionally. But what if there are no waiters?
+		 * While it would work with -1 too, 0 is a better value
+		 * in that case, because we wont hit the slowpath when
+		 * we release the lock. We can simply use atomic_set()
+		 * for this, because we are the owners of the lock now,
+		 * and are still holding the wait_lock:
+		 */
+		if (likely(list_empty(&lock->wait_list)))
+			atomic_set(&lock->count, 0);
+		debug_set_owner(lock, ti __IP__);
+
+		spin_unlock_mutex(&lock->wait_lock);
+
+		debug_free_waiter(waiter);
+
+		DEBUG_WARN_ON(list_empty(&lock->held_list));
+		DEBUG_WARN_ON(lock->owner != ti);
+
+		return 1;
+	}
+
+	add_waiter(lock, waiter, ti, add_to_head __IP__);
+	__set_task_state(task, task_state);
+
+	/*
+	 * Ok, didnt get the lock - we'll go to sleep after return:
+	 */
+	spin_unlock_mutex(&lock->wait_lock);
+
+	return 0;
+}
+
+/*
+ * Lock the mutex, slowpath:
+ */
+static inline void __mutex_lock_nonatomic(struct mutex *lock __IP_DECL__)
+{
+	struct thread_info *ti = current_thread_info();
+	struct mutex_waiter waiter;
+	/* first time queue the waiter as FIFO: */
+	int add_to_head = 0;
+
+	debug_init_waiter(&waiter);
+
+	spin_lock_mutex(&lock->wait_lock);
+
+	/* releases the internal lock: */
+	while (!__mutex_lock_common(lock, &waiter, ti,
+			TASK_UNINTERRUPTIBLE, add_to_head __IP__)) {
+
+		/* start queueing the waiter as LIFO: */
+		add_to_head = 1;
+		/* wait to be woken up: */
+		schedule();
+
+		spin_lock_mutex(&lock->wait_lock);
+		remove_waiter(lock, &waiter, ti);
+	}
+}
+
+/*
+ * Lock a mutex interruptible, slowpath:
+ */
+static int __sched
+__mutex_lock_interruptible_nonatomic(struct mutex *lock __IP_DECL__)
+{
+	struct thread_info *ti = current_thread_info();
+	struct mutex_waiter waiter;
+	int add_to_head = 0;
+
+	debug_init_waiter(&waiter);
+
+	spin_lock_mutex(&lock->wait_lock);
+
+	for (;;) {
+		/* releases the internal lock: */
+		if (__mutex_lock_common(lock, &waiter, ti,
+				TASK_INTERRUPTIBLE, add_to_head __IP__))
+			return 0;
+
+		/* break out on a signal: */
+		if (unlikely(signal_pending(ti->task)))
+			break;
+
+		add_to_head = 1;
+		/* wait to be woken up: */
+		schedule();
+
+		spin_lock_mutex(&lock->wait_lock);
+		remove_waiter(lock, &waiter, ti);
+	}
+	/*
+	 * We got a signal. Remove ourselves from the wait list:
+	 */
+	spin_lock_mutex(&lock->wait_lock);
+	remove_waiter(lock, &waiter, ti);
+	/*
+	 * If there are other waiters then wake
+	 * one up:
+	 */
+	if (unlikely(!list_empty(&lock->wait_list)))
+		mutex_wakeup_waiter(lock __IP__);
+
+	spin_unlock_mutex(&lock->wait_lock);
+
+	__set_task_state(ti->task, TASK_RUNNING);
+
+	debug_free_waiter(&waiter);
+
+	return -EINTR;
+}
+
+/*
+ * We have three mutex_trylock() variants. The cmpxchg based one is
+ * the best one (because it has no side-effect on mutex_unlock()),
+ * but cmpxchg is not available on every architecture, so we also
+ * provide an atomic_dec_return based variant too. The debug variant
+ * takes the internal lock.
+ *
+ * [ The atomic_dec_return variant might end up making the counter
+ *   negative in the failure case, which may trigger the slowpath
+ *   for the owner's unlock path - but this is not a big problem
+ *   in practice. ]
+ */
+#ifndef CONFIG_DEBUG_MUTEXES
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
+#ifdef __HAVE_ARCH_CMPXCHG
+	if (atomic_cmpxchg(&lock->count, 1, 0) == 1)
+		return 1;
+#else
+	if (atomic_dec_return(&lock->count) == 0)
+		return 1;
+#endif
+	return 0;
+}
+
+#else /* CONFIG_DEBUG_MUTEXES: */
+
+/*
+ * In the debug case we take the spinlock and check whether we can
+ * get the lock:
+ */
+int fastcall mutex_trylock(struct mutex *lock)
+{
+	struct thread_info *ti = current_thread_info();
+	int ret = 0;
+
+	spin_lock_mutex(&lock->wait_lock);
+
+	if (atomic_read(&lock->count) == 1) {
+		atomic_set(&lock->count, 0);
+		debug_set_owner(lock, ti __CALLER_IP__);
+		ret = 1;
+	}
+
+	spin_unlock_mutex(&lock->wait_lock);
+
+	return ret;
+}
+
+#endif /* CONFIG_DEBUG_MUTEXES */
+
+/*
+ * Release the lock, slowpath:
+ */
+static inline void __mutex_unlock_nonatomic(struct mutex *lock __IP_DECL__)
+{
+	DEBUG_WARN_ON(lock->owner != current_thread_info());
+	/*
+	 * Set it back to 'unlocked' early. We can do this outside the
+	 * lock, because we are in the slowpath for sure, so we'll have a
+	 * waiter in flight (later on, if necessary), and if some other
+	 * task comes around, let it steal the lock - we'll cope with it.
+	 * Waiters take care of themselves and stay in flight until
+	 * necessary.
+	 *
+	 * (in the xchg based implementation the fastpath has set the
+	 *  count to 1 already, so we must not set it here, because we
+	 *  dont own the lock anymore. In the debug case we must set
+	 *  the lock inside the spinlock.)
+	 */
+#if !defined(CONFIG_MUTEX_XCHG_ALGORITHM) && !defined(CONFIG_DEBUG_MUTEXES)
+	atomic_set(&lock->count, 1);
+#endif
+	spin_lock_mutex(&lock->wait_lock);
+#ifdef CONFIG_DEBUG_MUTEXES
+	atomic_set(&lock->count, 1);
+#endif
+	debug_mutex_unlock(lock);
+
+	if (!list_empty(&lock->wait_list))
+		mutex_wakeup_waiter(lock __IP__);
+
+	debug_clear_owner(lock);
+
+	spin_unlock_mutex(&lock->wait_lock);
+}
+
+#ifndef CONFIG_DEBUG_MUTEXES
+/*
+ * We split it into a fastpath and a separate slowpath function,
+ * to reduce the register pressure on the fastpath:
+ *
+ * We want the atomic op come first, to make sure the
+ * branch is predicted as default-untaken:
+ */
+static __sched void FASTCALL(__mutex_lock_noinline(atomic_t *lock_count));
+
+/*
+ * Some architectures do not have fast dec_and_test atomic primitives,
+ * for them we are providing an atomic_xchg() based mutex implementation,
+ * if they enable CONFIG_MUTEX_XCHG_ALGORITHM.
+ *
+ * The locking fastpath is the 1->0 transition from 'unlocked' into
+ * 'locked' state:
+ */
+static inline void __mutex_lock_atomic(struct mutex *lock)
+{
+#ifdef CONFIG_MUTEX_XCHG_ALGORITHM
+	if (unlikely(atomic_xchg(&lock->count, 0) != 1))
+		__mutex_lock_noinline(&lock->count);
+#else
+	atomic_dec_call_if_negative(&lock->count, __mutex_lock_noinline);
+#endif
+}
+
+/*
+ * We put the slowpath into a separate function. This reduces
+ * register pressure in the fastpath, and also enables the
+ * atomic_[inc/dec]_call_if_[negative|nonpositive]() primitives.
+ */
+static void fastcall __sched __mutex_lock_noinline(atomic_t *lock_count)
+{
+	struct mutex *lock = container_of(lock_count, struct mutex, count);
+
+	__mutex_lock_nonatomic(lock);
+}
+
+static inline void __mutex_lock(struct mutex *lock)
+{
+	__mutex_lock_atomic(lock);
+}
+
+static inline int __mutex_lock_interruptible(struct mutex *lock)
+{
+#ifdef CONFIG_MUTEX_XCHG_ALGORITHM
+	if (unlikely(atomic_xchg(&lock->count, 0) != 1))
+		return __mutex_lock_interruptible_nonatomic(lock);
+#else
+	if (unlikely(atomic_dec_return(&lock->count) < 0))
+		return __mutex_lock_interruptible_nonatomic(lock);
+#endif
+	return 0;
+}
+
+static void __sched FASTCALL(__mutex_unlock_noinline(atomic_t *lock_count));
+
+/*
+ * The unlocking fastpath is the 0->1 transition from 'locked' into
+ * 'unlocked' state:
+ */
+static inline void __mutex_unlock_atomic(struct mutex *lock)
+{
+#ifdef CONFIG_MUTEX_XCHG_ALGORITHM
+	if (unlikely(atomic_xchg(&lock->count, 1) != 0))
+		__mutex_unlock_noinline(&lock->count);
+#else
+	atomic_inc_call_if_nonpositive(&lock->count, __mutex_unlock_noinline);
+#endif
+}
+
+static void fastcall __sched __mutex_unlock_noinline(atomic_t *lock_count)
+{
+	struct mutex *lock = container_of(lock_count, struct mutex, count);
+
+	__mutex_unlock_nonatomic(lock);
+}
+
+static inline void __mutex_unlock(struct mutex *lock)
+{
+	__mutex_unlock_atomic(lock);
+}
+
+#else /* CONFIG_DEBUG_MUTEXES: */
+
+/*
+ * In the debug case we just use the slowpath unconditionally:
+ */
+static inline void __mutex_lock(struct mutex *lock __IP_DECL__)
+{
+	__mutex_lock_nonatomic(lock __IP__);
+}
+
+static inline void __mutex_unlock(struct mutex *lock __IP_DECL__)
+{
+	__mutex_unlock_nonatomic(lock __IP__);
+}
+
+static inline int __mutex_lock_interruptible(struct mutex *lock __IP_DECL__)
+{
+	return __mutex_lock_interruptible_nonatomic(lock __IP__);
+}
+
+#endif
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
+	__mutex_lock(lock __CALLER_IP__);
+}
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
+	__mutex_unlock(lock __CALLER_IP__);
+}
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
+	return __mutex_lock_interruptible(lock __CALLER_IP__);
+}
+
+EXPORT_SYMBOL_GPL(mutex_lock);
+EXPORT_SYMBOL_GPL(mutex_unlock);
+EXPORT_SYMBOL_GPL(mutex_lock_interruptible);
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
+EXPORT_SYMBOL_GPL(__mutex_init);
+
