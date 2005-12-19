Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030220AbVLSBiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030220AbVLSBiG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 20:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030223AbVLSBiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 20:38:05 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:18405 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030220AbVLSBiD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 20:38:03 -0500
Date: Mon, 19 Dec 2005 02:37:18 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       Paul Jackson <pj@sgi.com>
Subject: [patch 05/15] Generic Mutex Subsystem, mutex-core.patch
Message-ID: <20051219013718.GA28038@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.7
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.7 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


mutex implementation, core files: just the basic subsystem, no users of it.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 include/linux/mutex.h   |  102 ++++++++
 include/linux/preempt.h |    1 
 include/linux/sched.h   |    5 
 kernel/Makefile         |    2 
 kernel/fork.c           |    4 
 kernel/mutex.c          |  564 ++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 677 insertions(+), 1 deletion(-)

Index: linux/include/linux/mutex.h
===================================================================
--- /dev/null
+++ linux/include/linux/mutex.h
@@ -0,0 +1,102 @@
+#ifndef __LINUX_MUTEX_H
+#define __LINUX_MUTEX_H
+
+/*
+ * Mutexes
+ *
+ * started by Ingo Molnar:
+ *
+ *  Copyright (C) 2004, 2005 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
+ *
+ * This file contains the main data structure and API definitions.
+ */
+#include <linux/config.h>
+#include <asm/atomic.h>
+#include <linux/list.h>
+#include <linux/spinlock_types.h>
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
+ *
+ * These semantics are fully enforced when DEBUG_MUTEXESS is
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
+	// 1: unlocked, 0: locked, negative: locked, possibly waiters
+	atomic_t		count;
+	spinlock_t		wait_lock;
+	struct list_head	wait_list;
+#ifdef CONFIG_DEBUG_MUTEXESS
+	struct thread_info	*owner;
+	struct list_head	held_list;
+	unsigned long		acquire_ip;
+	char 			*name, *file;
+	int			line;
+	void			*magic;
+#endif
+};
+
+/*
+ * This is the control structure for tasks blocked on mutex,
+ * which resides on the blocked task's kernel stack:
+ */
+struct mutex_waiter {
+	struct mutex		*lock;
+	struct list_head	list;
+	struct thread_info	*ti;
+	int			woken;
+#ifdef CONFIG_DEBUG_MUTEXESS
+	unsigned long		ip;
+	void			*magic;
+#endif
+};
+
+#ifdef CONFIG_DEBUG_MUTEXESS
+# define __MUTEX_DEADLOCK_DETECT_INITIALIZER(lockname) \
+	, .held_list = LIST_HEAD_INIT(lockname.held_list), \
+	.name = #lockname, .file = __FILE__, .line = __LINE__ , \
+	.magic = &lockname
+extern void FASTCALL(__mutex_init(struct mutex *lock, char *name,
+				  char *file, int line));
+# define mutex_init(sem)	__mutex_init(sem, NULL, __FILE__, __LINE__)
+#else
+# define __MUTEX_DEADLOCK_DETECT_INITIALIZER(lockname)
+extern void FASTCALL(__mutex_init(struct mutex *lock));
+# define mutex_init(sem)	__mutex_init(sem)
+#endif
+
+#define __MUTEX_INITIALIZER(lockname) \
+	{ .count = ATOMIC_INIT(1) \
+	, .wait_lock = SPIN_LOCK_UNLOCKED \
+	, .wait_list = LIST_HEAD_INIT(lockname.wait_list) \
+	__MUTEX_DEADLOCK_DETECT_INITIALIZER(lockname) }
+
+#define DEFINE_MUTEX(mutexname) \
+	struct mutex mutexname = __MUTEX_INITIALIZER(mutexname)
+
+extern void FASTCALL(mutex_lock(struct mutex *lock));
+extern int FASTCALL(mutex_lock_interruptible(struct mutex *lock));
+extern int FASTCALL(mutex_trylock(struct mutex *lock));
+extern void FASTCALL(mutex_unlock(struct mutex *lock));
+extern int FASTCALL(mutex_is_locked(struct mutex *lock));
+
+#endif
Index: linux/include/linux/preempt.h
===================================================================
--- linux.orig/include/linux/preempt.h
+++ linux/include/linux/preempt.h
@@ -22,6 +22,7 @@
 #define dec_preempt_count() sub_preempt_count(1)
 
 #define preempt_count()	(current_thread_info()->preempt_count)
+#define preempt_count_ti(ti)	((ti)->preempt_count)
 
 #ifdef CONFIG_PREEMPT
 
Index: linux/include/linux/sched.h
===================================================================
--- linux.orig/include/linux/sched.h
+++ linux/include/linux/sched.h
@@ -820,6 +820,11 @@ struct task_struct {
 /* Protection of proc_dentry: nesting proc_lock, dcache_lock, write_lock_irq(&tasklist_lock); */
 	spinlock_t proc_lock;
 
+#ifdef CONFIG_DEBUG_MUTEXESS
+	/* mutex deadlock detection */
+	struct mutex_waiter *blocked_on;
+#endif
+
 /* journalling filesystem info */
 	void *journal_info;
 
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
Index: linux/kernel/fork.c
===================================================================
--- linux.orig/kernel/fork.c
+++ linux/kernel/fork.c
@@ -973,6 +973,10 @@ static task_t *copy_process(unsigned lon
  	}
 #endif
 
+#ifdef CONFIG_DEBUG_MUTEXESS
+	p->blocked_on = NULL; /* not blocked yet */
+#endif
+
 	p->tgid = p->pid;
 	if (clone_flags & CLONE_THREAD)
 		p->tgid = current->tgid;
Index: linux/kernel/mutex.c
===================================================================
--- /dev/null
+++ linux/kernel/mutex.c
@@ -0,0 +1,564 @@
+/*
+ * kernel/mutex.c
+ *
+ * Mutexes
+ *
+ * Started by Ingo Molnar:
+ *
+ *  Copyright (C) 2004, 2005 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
+ *
+ * Many thanks to Arjan van de Ven, Thomas Gleixner, Steven Rostedt and
+ * David Howells for suggestions and improvements.
+ */
+#include <linux/config.h>
+#include <linux/mutex.h>
+#include <linux/sched.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/kallsyms.h>
+#include <linux/syscalls.h>
+#include <linux/interrupt.h>
+
+/*
+ * We can speed up the lock-acquire, if the architecture
+ * supports cmpxchg and if there's no debugging state
+ * to be set up (!DEBUG_MUTEXESS).
+ *
+ * trick: we can use cmpxchg on the release side too, if bit
+ * 0 of lock->owner is set if there is at least a single pending
+ * task in the wait_list. This way the release atomic-fastpath
+ * can be a mirror image of the acquire path:
+ */
+#if defined(__HAVE_ARCH_CMPXCHG) && !defined(CONFIG_DEBUG_MUTEXESS)
+# define MUTEX_LOCKLESS_FASTPATH
+#endif
+
+/*
+ * In the debug case we carry the caller's instruction pointer into
+ * other functions, but we dont want the function argument overhead
+ * in the nondebug case - hence these macros:
+ */
+#ifdef CONFIG_DEBUG_MUTEXESS
+# define __IP_DECL__		, unsigned long ip
+# define __IP__			, ip
+# define __W_CALLER__(waiter)	, (waiter)->ip
+# define __CALLER_IP__		, (unsigned long)__builtin_return_address(0)
+#else
+# define __IP_DECL__
+# define __IP__
+# define __W_CALLER__(waiter)
+# define __CALLER_IP__
+#endif
+
+#ifdef CONFIG_DEBUG_MUTEXESS
+# include "mutex-debug.c"
+#else /* !CONFIG_DEBUG_MUTEXESS */
+
+// #define MUTEX_IRQ_SAFE
+
+#ifdef MUTEX_IRQ_SAFE
+# define mutex_irq_disable()			local_irq_disable()
+# define mutex_irq_enable()			local_irq_enable()
+# define mutex_irq_save(flags)			local_irq_save(flags)
+# define mutex_irq_restore(flags)		local_irq_restore(flags)
+#else
+# define mutex_irq_disable()			preempt_disable()
+# define mutex_irq_enable()			preempt_enable()
+# define mutex_irq_save(flags) \
+			do { (void)(flags); preempt_disable(); } while (0)
+# define mutex_irq_restore(flags) \
+			do { (void)(flags); preempt_enable(); } while (0)
+#endif
+
+# define debug_lock_irq(lock, ti) \
+		do { mutex_irq_disable(); (void)(ti); } while (0)
+# define debug_lock_irqsave(lock, flags, ti) \
+		do { mutex_irq_save(flags); (void)(ti); } while (0)
+# define debug_unlock_irq(lock, ti)		mutex_irq_enable()
+# define debug_unlock_irqrestore(lock, flags, ti)	\
+	do {						\
+		(void)(ti);				\
+		mutex_irq_restore(flags);		\
+		preempt_check_resched();		\
+	} while (0)
+# define debug_mutex_irq_disable(ti)		mutex_irq_disable()
+# define debug_mutex_irq_enable(ti)		mutex_irq_enable()
+# define debug_mutex_irq_restore(flags, ti)	mutex_irq_restore(flags)
+
+# define debug_unlock(lock, ti)			do { } while (0)
+
+# define DEBUG_BUG()				do { } while (0)
+# define DEBUG_WARN_ON(c)			do { } while (0)
+# define DEBUG_OFF()				do { } while (0)
+# define DEBUG_BUG_ON(c)			do { } while (0)
+
+static inline void
+debug_set_owner(struct mutex *lock, struct thread_info *new_owner)
+{
+}
+
+static inline void debug_init_waiter(struct mutex_waiter *waiter)
+{
+}
+
+static inline void debug_free_waiter(struct mutex_waiter *waiter)
+{
+}
+
+#endif /* !CONFIG_DEBUG_MUTEXESS */
+
+#ifdef CONFIG_SMP
+# define SMP_DEBUG_WARN_ON(c)			DEBUG_WARN_ON(c)
+# define SMP_DEBUG_BUG_ON(c)			DEBUG_BUG_ON(c)
+#else
+# define SMP_DEBUG_WARN_ON(c)			do { } while (0)
+# define SMP_DEBUG_BUG_ON(c)			do { } while (0)
+#endif
+
+/*
+ * Block on a lock - add ourselves to the list of waiters.
+ * Called with lock->wait_lock held.
+ */
+static inline void
+__add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
+	     struct thread_info *ti, struct task_struct *task __IP_DECL__)
+{
+#ifdef CONFIG_DEBUG_MUTEXESS
+	debug_init_waiter(waiter);
+	SMP_DEBUG_WARN_ON(!spin_is_locked(&lock->wait_lock));
+	check_deadlock(lock, 0, ti, ip);
+	waiter->ip = ip;
+	/* Mark the current thread as blocked on the lock: */
+	task->blocked_on = waiter;
+#endif
+	waiter->woken = 0;
+	waiter->lock = lock;
+	waiter->ti = ti;
+
+	/* Add waiting tasks to the end of the waitqueue (FIFO): */
+	list_add_tail(&waiter->list, &lock->wait_list);
+}
+
+
+static inline void
+__remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
+	        struct thread_info *ti, struct task_struct *task)
+{
+#ifdef CONFIG_DEBUG_MUTEXESS
+	DEBUG_WARN_ON(list_empty(&waiter->list));
+	DEBUG_WARN_ON(waiter->ti != ti);
+	DEBUG_WARN_ON(task->blocked_on != waiter);
+	task->blocked_on = NULL;
+#endif
+	list_del_init(&waiter->list);
+	waiter->ti = NULL;
+}
+
+static inline void
+remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
+	      struct thread_info *ti, struct task_struct *task)
+{
+	unsigned long flags;
+
+	debug_lock_irqsave(&debug_lock, flags, ti);
+
+	spin_lock(&lock->wait_lock);
+	__remove_waiter(lock, waiter, ti, task);
+	spin_unlock(&lock->wait_lock);
+
+	debug_unlock_irqrestore(&debug_lock, flags, ti);
+	debug_free_waiter(waiter);
+}
+
+/*
+ * Lock a mutex, common slowpath. We just decremented the count,
+ * and it got negative as a result.
+ */
+static inline int
+__mutex_lock_common(struct mutex *lock, struct mutex_waiter *waiter,
+		    struct thread_info *ti, struct task_struct *task,
+		    unsigned long *flags, unsigned long task_state __IP_DECL__)
+{
+	unsigned int old_val;
+
+	debug_lock_irqsave(&debug_lock, *flags, ti);
+	DEBUG_WARN_ON(lock->magic != lock);
+
+	spin_lock(&lock->wait_lock);
+	__add_waiter(lock, waiter, ti, task __IP__);
+	set_task_state(task, task_state);
+
+	/*
+	 * Lets try to take the lock again - this is needed even if
+	 * we get here for the first time (shortly after failing to
+	 * acquire the lock), to make sure that we get a wakeup once
+	 * it's unlocked. Later on this is the operation that gives
+	 * us the lock. We need to xchg it to -1, so that when we
+	 * release the lock, we properly wake up other waiters!
+	 */
+	old_val = atomic_xchg(&lock->count, -1);
+
+	if (old_val == 1) {
+		/*
+		 * Got the lock! Rejoice:
+		 */
+		debug_set_owner(lock, ti __IP__);
+		__remove_waiter(lock, waiter, ti, task);
+
+		spin_unlock(&lock->wait_lock);
+		__set_task_state(task, TASK_RUNNING);
+
+		debug_unlock_irqrestore(&debug_lock, *flags, ti);
+		debug_free_waiter(waiter);
+		DEBUG_WARN_ON(list_empty(&lock->held_list));
+		DEBUG_WARN_ON(lock->owner != ti);
+
+		return 1;
+	}
+
+	/*
+	 * Ok, didnt get the lock - we'll go to sleep after return:
+	 */
+	spin_unlock(&lock->wait_lock);
+
+	debug_unlock_irqrestore(&debug_lock, *flags, ti);
+
+	return 0;
+}
+
+/*
+ * Lock the mutex:
+ */
+static inline void __mutex_lock_nonatomic(struct mutex *lock __IP_DECL__)
+{
+	struct thread_info *ti = current_thread_info();
+	struct task_struct *task = ti->task;
+	struct mutex_waiter waiter;
+	unsigned long flags;
+
+repeat:
+	if (__mutex_lock_common(lock, &waiter, ti, task, &flags,
+						TASK_UNINTERRUPTIBLE __IP__))
+		return;
+
+	/* wait to be woken up */
+	schedule();
+
+	remove_waiter(lock, &waiter, ti, task);
+
+	goto repeat;
+}
+
+/*
+ * Wake up a task and make it the new owner of the mutex:
+ */
+static inline void
+__mutex_wakeup_waiter(struct mutex *lock __IP_DECL__)
+{
+	struct mutex_waiter *waiter;
+
+	SMP_DEBUG_WARN_ON(!spin_is_locked(&lock->wait_lock));
+	DEBUG_WARN_ON(list_empty(&lock->wait_list));
+
+	/*
+	 * Get the first entry from the wait-list:
+	 */
+	waiter = list_entry(lock->wait_list.next, struct mutex_waiter, list);
+
+	DEBUG_WARN_ON(waiter->magic != waiter);
+	DEBUG_WARN_ON(list_empty(&waiter->list));
+
+	if (!waiter->woken) {
+		waiter->woken = 1;
+		wake_up_process(waiter->ti->task);
+	}
+}
+
+/*
+ * Helper functions for mutex_lock_interruptible() timeouts:
+ */
+
+static void process_timeout(unsigned long __data)
+{
+	wake_up_process((task_t *)__data);
+}
+
+static inline void
+start_mutex_timer(struct timer_list *timer, unsigned long time,
+		  unsigned long *expire)
+{
+	*expire = time + jiffies;
+	init_timer(timer);
+	timer->expires = *expire;
+	timer->data = (unsigned long)current;
+	timer->function = process_timeout;
+	add_timer(timer);
+}
+
+static inline int
+stop_mutex_timer(struct timer_list *timer, unsigned long time,
+		 unsigned long expire)
+{
+	int ret;
+
+	ret = (int)(expire - jiffies);
+	if (!timer_pending(timer)) {
+		del_singleshot_timer_sync(timer);
+		ret = -ETIMEDOUT;
+	}
+	return ret;
+}
+
+/*
+ * Lock a mutex interruptible, with timeouts:
+ */
+static int __sched
+__mutex_lock_interruptible(struct mutex *lock, unsigned long time __IP_DECL__)
+{
+	struct thread_info *ti = current_thread_info();
+	struct task_struct *task = ti->task;
+	unsigned long expire = 0, flags;
+	struct mutex_waiter waiter;
+	struct timer_list timer;
+	int ret;
+
+repeat:
+	if (__mutex_lock_common(lock, &waiter, ti, task, &flags,
+						TASK_INTERRUPTIBLE __IP__))
+		return 0;
+
+	if (time)
+		start_mutex_timer(&timer, time, &expire);
+
+	/* wait to be given the lock */
+	if (!signal_pending(task) && (!time || timer_pending(&timer))) {
+		schedule();
+
+		remove_waiter(lock, &waiter, ti, task);
+		goto repeat;
+	}
+	/*
+	 * We got a signal or timed out. Remove ourselves from
+	 * the wait list:
+	 */
+	ret = -EINTR;
+	if (time)
+		ret = stop_mutex_timer(&timer, time, expire);
+
+	debug_lock_irq(&debug_lock, ti);
+	DEBUG_WARN_ON(lock->magic != lock);
+
+	spin_lock(&lock->wait_lock);
+	__remove_waiter(lock, &waiter, ti, task);
+	/*
+	 * If there are other waiters then wake
+	 * one up:
+	 */
+	if (unlikely(!list_empty(&lock->wait_list)))
+		__mutex_wakeup_waiter(lock __IP__);
+
+	spin_unlock(&lock->wait_lock);
+	__set_task_state(task, TASK_RUNNING);
+
+	debug_unlock_irq(&debug_lock, ti);
+	debug_free_waiter(&waiter);
+
+	return ret;
+}
+
+/*
+ * Mutex trylock, returns 1 if successful, 0 if contention
+ */
+static int __mutex_trylock(struct mutex *lock __IP_DECL__)
+{
+#ifdef MUTEX_LOCKLESS_FASTPATH
+	if (atomic_cmpxchg(&lock->count, 1, 0) == 1)
+		return 1;
+	return 0;
+#else
+	struct thread_info *ti = current_thread_info();
+	unsigned long flags;
+	int ret = 0;
+
+	debug_lock_irqsave(&debug_lock, flags, ti);
+	spin_lock(&lock->wait_lock);
+	DEBUG_WARN_ON(lock->magic != lock);
+
+	if (atomic_read(&lock->count) == 1) {
+		atomic_set(&lock->count, 0);
+		debug_set_owner(lock, ti __IP__);
+		ret = 1;
+	}
+	spin_unlock(&lock->wait_lock);
+	debug_unlock_irqrestore(&debug_lock, flags, ti);
+
+	return ret;
+#endif
+}
+
+int fastcall mutex_is_locked(struct mutex *lock)
+{
+	mb();
+	return atomic_read(&lock->count) != 1;
+}
+
+EXPORT_SYMBOL_GPL(mutex_is_locked);
+
+int __sched fastcall mutex_trylock(struct mutex *lock)
+{
+	return __mutex_trylock(lock __CALLER_IP__);
+}
+
+/*
+ * Release the lock:
+ */
+static inline void __mutex_unlock_nonatomic(struct mutex *lock __IP_DECL__)
+{
+	struct thread_info *ti = current_thread_info();
+	unsigned long flags;
+
+	debug_lock_irqsave(&debug_lock, flags, ti);
+	spin_lock(&lock->wait_lock);
+
+#ifdef CONFIG_DEBUG_MUTEXESS
+	DEBUG_WARN_ON(lock->magic != lock);
+	DEBUG_WARN_ON(!lock->wait_list.prev && !lock->wait_list.next);
+	DEBUG_WARN_ON(lock->owner != ti);
+	if (debug_on) {
+		DEBUG_WARN_ON(list_empty(&lock->held_list));
+		list_del_init(&lock->held_list);
+	}
+#endif
+
+	if (unlikely(!list_empty(&lock->wait_list)))
+		__mutex_wakeup_waiter(lock __IP__);
+#ifdef CONFIG_DEBUG_MUTEXESS
+	lock->owner = NULL;
+#endif
+	/*
+	 * Set it back to 'unlocked'. We'll have a waiter in flight
+	 * (if any), and if some other task comes around, let it
+	 * steal the lock. Waiters take care of themselves and stay
+	 * in flight until necessary.
+	 */
+	atomic_set(&lock->count, 1);
+
+	spin_unlock(&lock->wait_lock);
+	debug_unlock_irqrestore(&debug_lock, flags, ti);
+}
+
+#ifdef MUTEX_LOCKLESS_FASTPATH
+
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
+ * The locking fastpath is the 1->0 transition from
+ * 'unlocked' into 'locked' state:
+ */
+static inline void __mutex_lock_atomic(struct mutex *lock)
+{
+	atomic_dec_call_if_negative(&lock->count, __mutex_lock_noinline);
+}
+
+static fastcall __sched void __mutex_lock_noinline(atomic_t *lock_count)
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
+static void __sched FASTCALL(__mutex_unlock_noinline(atomic_t *lock_count));
+
+/*
+ * The unlocking fastpath is the 0->1 transition from
+ * 'locked' into 'unlocked' state:
+ */
+static inline void __mutex_unlock_atomic(struct mutex *lock)
+{
+	atomic_inc_call_if_nonpositive(&lock->count, __mutex_unlock_noinline);
+}
+
+static fastcall void __sched __mutex_unlock_noinline(atomic_t *lock_count)
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
+#else
+
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
+#endif
+
+void __sched fastcall mutex_lock(struct mutex *lock)
+{
+	__mutex_lock(lock __CALLER_IP__);
+}
+
+EXPORT_SYMBOL_GPL(mutex_lock);
+
+void __sched fastcall mutex_unlock(struct mutex *lock)
+{
+	DEBUG_WARN_ON(lock->owner != current_thread_info());
+	__mutex_unlock(lock __CALLER_IP__);
+}
+
+EXPORT_SYMBOL_GPL(mutex_unlock);
+
+int __sched fastcall mutex_lock_interruptible(struct mutex *lock)
+{
+	return __mutex_lock_interruptible(lock, 0 __CALLER_IP__);
+}
+
+EXPORT_SYMBOL_GPL(mutex_lock_interruptible);
+
+/*
+ * Initialise the lock:
+ */
+void fastcall __mutex_init(struct mutex *lock
+#ifdef CONFIG_DEBUG_MUTEXESS
+	, char *name, char *file, int line
+#endif
+						)
+{
+	atomic_set(&lock->count, 1);
+	spin_lock_init(&lock->wait_lock);
+	INIT_LIST_HEAD(&lock->wait_list);
+#ifdef CONFIG_DEBUG_MUTEXESS
+	lock->owner = NULL;
+	INIT_LIST_HEAD(&lock->held_list);
+	lock->name = name;
+	lock->file = file;
+	lock->line = line;
+	lock->magic = lock;
+#endif
+
+}
+EXPORT_SYMBOL_GPL(__mutex_init);
