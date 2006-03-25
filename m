Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbWCYStu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbWCYStu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 13:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWCYStU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 13:49:20 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:36051 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932236AbWCYSs6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 13:48:58 -0500
Date: Sat, 25 Mar 2006 19:46:12 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>
Subject: [patch 05/10] PI-futex: rt-mutex core
Message-ID: <20060325184612.GF16724@elte.hu>
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

From: Ingo Molnar <mingo@elte.hu>

core functions for the rt-mutex subsystem.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

----

 include/linux/init_task.h        |    1 
 include/linux/rtmutex.h          |  106 ++++
 include/linux/rtmutex_internal.h |  157 ++++++
 include/linux/sched.h            |   11 
 init/Kconfig                     |    5 
 kernel/Makefile                  |    1 
 kernel/fork.c                    |    3 
 kernel/rtmutex.c                 |  941 +++++++++++++++++++++++++++++++++++++++
 kernel/rtmutex.h                 |   28 +
 9 files changed, 1253 insertions(+)

Index: linux-pi-futex.mm.q/include/linux/init_task.h
===================================================================
--- linux-pi-futex.mm.q.orig/include/linux/init_task.h
+++ linux-pi-futex.mm.q/include/linux/init_task.h
@@ -123,6 +123,7 @@ extern struct group_info init_groups;
 	.journal_info	= NULL,						\
 	.cpu_timers	= INIT_CPU_TIMERS(tsk.cpu_timers),		\
 	.fs_excl	= ATOMIC_INIT(0),				\
+	INIT_RT_MUTEXES(tsk)						\
 }
 
 
Index: linux-pi-futex.mm.q/include/linux/rtmutex.h
===================================================================
--- /dev/null
+++ linux-pi-futex.mm.q/include/linux/rtmutex.h
@@ -0,0 +1,106 @@
+/*
+ * RT Mutexes: blocking mutual exclusion locks with PI support
+ *
+ * started by Ingo Molnar and Thomas Gleixner:
+ *
+ *  Copyright (C) 2004-2006 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
+ *  Copyright (C) 2006, Timesys Corp., Thomas Gleixner <tglx@timesys.com>
+ *
+ * This file contains the public data structure and API definitions.
+ */
+
+#ifndef __LINUX_RT_MUTEX_H
+#define __LINUX_RT_MUTEX_H
+
+#include <linux/linkage.h>
+#include <linux/plist.h>
+#include <linux/spinlock_types.h>
+
+/*
+ * The rt_mutex structure
+ *
+ * @wait_lock:	spinlock to protect the structure
+ * @wait_list:	pilist head to enqueue waiters in priority order
+ * @owner:	the mutex owner
+ */
+struct rt_mutex {
+	spinlock_t		wait_lock;
+	struct plist_head	wait_list;
+	struct task_struct	*owner;
+# ifdef CONFIG_DEBUG_RT_MUTEXES
+	int			save_state;
+	struct list_head	held_list;
+	unsigned long		acquire_ip;
+	const char 		*name, *file;
+	int			line;
+	void			*magic;
+# endif
+};
+
+struct rt_mutex_waiter;
+struct hrtimer_sleeper;
+
+#ifdef CONFIG_DEBUG_RT_MUTEXES
+# define __DEBUG_RT_MUTEX_INITIALIZER(mutexname) \
+	, .name = #mutexname, .file = __FILE__, .line = __LINE__
+# define rt_mutex_init(mutex)			__rt_mutex_init(mutex, __FUNCTION__)
+ extern void rt_mutex_debug_task_free(struct task_struct *tsk);
+#else
+# define __DEBUG_RT_MUTEX_INITIALIZER(mutexname)
+# define rt_mutex_init(mutex)			__rt_mutex_init(mutex, NULL)
+# define rt_mutex_debug_task_free(t)		do { } while (0)
+#endif
+
+#define __RT_MUTEX_INITIALIZER(mutexname) \
+	{ .wait_lock = SPIN_LOCK_UNLOCKED \
+	, .wait_list = PLIST_HEAD_INIT(mutexname.wait_list) \
+	, .owner = NULL \
+	__DEBUG_RT_MUTEX_INITIALIZER(mutexname)}
+
+#define DEFINE_RT_MUTEX(mutexname) \
+	struct rt_mutex mutexname = __RT_MUTEX_INITIALIZER(mutexname)
+
+/***
+ * rt_mutex_is_locked - is the mutex locked
+ * @lock: the mutex to be queried
+ *
+ * Returns 1 if the mutex is locked, 0 if unlocked.
+ */
+static inline int fastcall rt_mutex_is_locked(struct rt_mutex *lock)
+{
+	return lock->owner != NULL;
+}
+
+extern void fastcall __rt_mutex_init(struct rt_mutex *lock, const char *name);
+extern void fastcall rt_mutex_destroy(struct rt_mutex *lock);
+
+extern void fastcall rt_mutex_lock(struct rt_mutex *lock);
+extern int fastcall rt_mutex_lock_interruptible(struct rt_mutex *lock,
+						int detect_deadlock);
+extern int fastcall rt_mutex_timed_lock(struct rt_mutex *lock,
+					struct hrtimer_sleeper *timeout,
+					int detect_deadlock);
+
+extern int fastcall rt_mutex_trylock(struct rt_mutex *lock);
+
+extern void fastcall rt_mutex_unlock(struct rt_mutex *lock);
+
+#ifdef CONFIG_RT_MUTEXES
+# define rt_mutex_init_task(p)						\
+ do {									\
+	spin_lock_init(&p->pi_lock);					\
+	plist_head_init(&p->pi_waiters);				\
+	p->pi_blocked_on = NULL;					\
+	p->pi_locked_by = NULL;						\
+	INIT_LIST_HEAD(&p->pi_lock_chain);				\
+ } while (0)
+# define INIT_RT_MUTEXES(tsk)						\
+	.pi_waiters	= PLIST_HEAD_INIT(tsk.pi_waiters),		\
+	.pi_lock	= SPIN_LOCK_UNLOCKED,				\
+	.pi_lock_chain	= LIST_HEAD_INIT(tsk.pi_lock_chain),
+#else
+# define rt_mutex_init_task(p)		do { } while (0)
+# define INIT_RT_MUTEXES(tsk)
+#endif
+
+#endif
Index: linux-pi-futex.mm.q/include/linux/rtmutex_internal.h
===================================================================
--- /dev/null
+++ linux-pi-futex.mm.q/include/linux/rtmutex_internal.h
@@ -0,0 +1,157 @@
+/*
+ * RT Mutexes: blocking mutual exclusion locks with PI support
+ *
+ * started by Ingo Molnar and Thomas Gleixner:
+ *
+ *  Copyright (C) 2004-2006 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
+ *  Copyright (C) 2006, Timesys Corp., Thomas Gleixner <tglx@timesys.com>
+ *
+ * This file contains the private data structure and API definitions.
+ */
+
+#ifndef __LINUX_RT_MUTEX_INTERNAL_H
+#define __LINUX_RT_MUTEX_INTERNAL_H
+
+#include <linux/rtmutex.h>
+
+/*
+ * This is the control structure for tasks blocked on a rt_mutex,
+ * which is allocated on the kernel stack on of the blocked task.
+ *
+ * @list_entry:		pi node to enqueue into the mutex waiters list
+ * @pi_list_entry:	pi node to enqueue into the mutex owner waiters list
+ * @task:		task reference to the blocked task
+ */
+struct rt_mutex_waiter {
+	struct plist_node	list_entry;
+	struct plist_node	pi_list_entry;
+	struct task_struct	*task;
+	struct rt_mutex		*lock;
+#ifdef CONFIG_DEBUG_RT_MUTEXES
+	unsigned long		ip;
+	pid_t			deadlock_task_pid;
+	struct rt_mutex		*deadlock_lock;
+#endif
+};
+
+/*
+ * Plist wrapper macros
+ */
+#define rt_mutex_has_waiters(lock)	(!plist_head_empty(&lock->wait_list))
+
+#define rt_mutex_top_waiter(lock) 	\
+({ struct rt_mutex_waiter *__w = plist_first_entry(&lock->wait_list, \
+					struct rt_mutex_waiter, list_entry); \
+	BUG_ON(__w->lock != lock);	\
+	__w;				\
+})
+
+#define task_has_pi_waiters(task)	(!plist_head_empty(&task->pi_waiters))
+
+#define task_top_pi_waiter(task) 	\
+	plist_first_entry(&task->pi_waiters, struct rt_mutex_waiter, pi_list_entry)
+
+/*
+ * lock->owner state tracking:
+ *
+ * lock->owner holds the task_struct pointer of the owner. Bit 0 and 1
+ * are used to keep track of the "owner is pending" and "lock has
+ * waiters" state.
+ *
+ * owner	bit1	bit0
+ * NULL		0	0	lock is free (fast acquire possible)
+ * NULL		0	1	invalid state
+ * NULL		1	0	invalid state
+ * NULL		1	1	invalid state
+ * taskpointer	0	0	lock is held (fast release possible)
+ * taskpointer	0	1	task is pending owner
+ * taskpointer	1	0	lock is held and has waiters
+ * taskpointer	1	1	task is pending owner and lock has more waiters
+ *
+ * Pending ownership is assigned to the top (highest priority)
+ * waiter of the lock, when the lock is released. The thread is woken
+ * up and can now take the lock. Until the lock is taken (bit 0
+ * cleared) a competing higher priority thread can steal the lock
+ * which puts the woken up thread back on the waiters list.
+ *
+ * The fast atomic compare exchange based acquire and release is only
+ * possible when bit 0 and 1 of lock->owner are 0.
+ */
+#define RT_MUTEX_OWNER_PENDING	1UL
+#define RT_MUTEX_HAS_WAITERS	2UL
+#define RT_MUTEX_OWNER_MASKALL	3UL
+
+#define rt_mutex_owner(lock)						\
+({									\
+	typecheck(struct rt_mutex *,(lock));				\
+ 	((struct task_struct *)((unsigned long)((lock)->owner) & ~RT_MUTEX_OWNER_MASKALL)); \
+})
+
+#define rt_mutex_real_owner(lock)					\
+({									\
+	typecheck(struct rt_mutex *,(lock));				\
+ 	((struct task_struct *)((unsigned long)((lock)->owner) & ~RT_MUTEX_HAS_WAITERS)); \
+})
+
+#define rt_mutex_owner_pending(lock)					\
+({									\
+	typecheck(struct rt_mutex *,(lock));				\
+	((unsigned long)((lock)->owner) & RT_MUTEX_OWNER_PENDING);	\
+})
+
+static inline void rt_mutex_set_owner(struct rt_mutex *lock, struct task_struct *owner,
+				      unsigned long msk)
+{
+	unsigned long val = ((unsigned long) owner) | msk;
+
+	if (rt_mutex_has_waiters(lock))
+		val |= RT_MUTEX_HAS_WAITERS;
+
+	lock->owner = (struct task_struct *)(val);
+}
+
+static inline void clear_rt_mutex_waiters(struct rt_mutex *lock)
+{
+	unsigned long owner;
+
+	owner = ((unsigned long) lock->owner) & ~RT_MUTEX_HAS_WAITERS;
+	lock->owner = (struct task_struct *)(owner);
+}
+
+static inline void fixup_rt_mutex_waiters(struct rt_mutex *lock)
+{
+	if (!rt_mutex_has_waiters(lock))
+		clear_rt_mutex_waiters(lock);
+}
+
+/*
+ * We can speed up the acquire/release, if the architecture
+ * supports cmpxchg and if there's no debugging state to be set up
+ */
+#if defined(__HAVE_ARCH_CMPXCHG) && !defined(CONFIG_DEBUG_RT_MUTEXES)
+
+# define rt_mutex_cmpxchg(l,c,n)	(cmpxchg(&l->owner, c, n) == c)
+
+static inline void mark_rt_mutex_waiters(struct rt_mutex *lock)
+{
+	unsigned long owner, *p = (unsigned long *) &lock->owner;
+
+	do {
+		owner = *p;
+	} while (cmpxchg(p, owner, owner | RT_MUTEX_HAS_WAITERS) != owner);
+}
+
+#else
+
+# define rt_mutex_cmpxchg(l,c,n)	(0)
+
+static inline void mark_rt_mutex_waiters(struct rt_mutex *lock)
+{
+	unsigned long owner = ((unsigned long) lock->owner)| RT_MUTEX_HAS_WAITERS;
+
+	lock->owner = (struct task_struct *) owner;
+}
+
+#endif
+
+#endif
Index: linux-pi-futex.mm.q/include/linux/sched.h
===================================================================
--- linux-pi-futex.mm.q.orig/include/linux/sched.h
+++ linux-pi-futex.mm.q/include/linux/sched.h
@@ -36,6 +36,7 @@
 #include <linux/seccomp.h>
 #include <linux/rcupdate.h>
 #include <linux/futex.h>
+#include <linux/rtmutex.h>
 
 #include <linux/auxvec.h>	/* For AT_VECTOR_SIZE */
 
@@ -858,6 +859,16 @@ struct task_struct {
 	/* Protection of the PI data structures: */
 	spinlock_t pi_lock;
 
+#ifdef CONFIG_RT_MUTEXES
+	/* PI waiters blocked on a rt_mutex held by this task */
+	struct plist_head pi_waiters;
+	/* Deadlock detection and priority inheritance handling */
+	struct rt_mutex_waiter *pi_blocked_on;
+	/* PI locking helpers */
+	struct task_struct *pi_locked_by;
+	struct list_head pi_lock_chain;
+#endif
+
 #ifdef CONFIG_DEBUG_MUTEXES
 	/* mutex deadlock detection */
 	struct mutex_waiter *blocked_on;
Index: linux-pi-futex.mm.q/init/Kconfig
===================================================================
--- linux-pi-futex.mm.q.orig/init/Kconfig
+++ linux-pi-futex.mm.q/init/Kconfig
@@ -361,9 +361,14 @@ config BASE_FULL
 	  kernel data structures. This saves memory on small machines,
 	  but may reduce performance.
 
+config RT_MUTEXES
+	boolean
+	select PLIST
+
 config FUTEX
 	bool "Enable futex support" if EMBEDDED
 	default y
+	select RT_MUTEXES
 	help
 	  Disabling this option will cause the kernel to be built without
 	  support for "fast userspace mutexes".  The resulting kernel may not
Index: linux-pi-futex.mm.q/kernel/Makefile
===================================================================
--- linux-pi-futex.mm.q.orig/kernel/Makefile
+++ linux-pi-futex.mm.q/kernel/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_FUTEX) += futex.o
 ifeq ($(CONFIG_COMPAT),y)
 obj-$(CONFIG_FUTEX) += futex_compat.o
 endif
+obj-$(CONFIG_RT_MUTEXES) += rtmutex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += cpu.o spinlock.o
 obj-$(CONFIG_DEBUG_SPINLOCK) += spinlock.o
Index: linux-pi-futex.mm.q/kernel/fork.c
===================================================================
--- linux-pi-futex.mm.q.orig/kernel/fork.c
+++ linux-pi-futex.mm.q/kernel/fork.c
@@ -104,6 +104,7 @@ static kmem_cache_t *mm_cachep;
 void free_task(struct task_struct *tsk)
 {
 	free_thread_info(tsk->thread_info);
+	rt_mutex_debug_task_free(tsk);
 	free_task_struct(tsk);
 }
 EXPORT_SYMBOL(free_task);
@@ -1042,6 +1043,8 @@ static task_t *copy_process(unsigned lon
 	mpol_fix_fork_child_flag(p);
 #endif
 
+	rt_mutex_init_task(p);
+
 #ifdef CONFIG_DEBUG_MUTEXES
 	p->blocked_on = NULL; /* not blocked yet */
 #endif
Index: linux-pi-futex.mm.q/kernel/rtmutex.c
===================================================================
--- /dev/null
+++ linux-pi-futex.mm.q/kernel/rtmutex.c
@@ -0,0 +1,941 @@
+/*
+ * RT-Mutexes: simple blocking mutual exclusion locks with PI support
+ *
+ * started by Ingo Molnar and Thomas Gleixner:
+ *
+ *  Copyright (C) 2004-2006 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
+ *  Copyright (C) 2006 Timesys Corp., Thomas Gleixner <tglx@timesys.com>
+ *  Copyright (C) 2005 Kihon Technologies Inc., Steven Rostedt
+ */
+#include <linux/spinlock.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/timer.h>
+
+#include <linux/rtmutex_internal.h>
+
+#ifdef CONFIG_DEBUG_RT_MUTEXES
+# include "rtmutex-debug.h"
+#else
+# include "rtmutex.h"
+#endif
+
+/*
+ * Calculate task priority from the waiter list priority
+ *
+ * Return task->normal_prio when the waiter list is empty or when
+ * the waiter is not allowed to do priority boosting
+ */
+int rt_mutex_getprio(struct task_struct *task)
+{
+	if (likely(!task_has_pi_waiters(task)))
+		return task->normal_prio;
+
+	return min(task_top_pi_waiter(task)->pi_list_entry.prio,
+		   task->normal_prio);
+}
+
+/*
+ * Adjust the priority of a task, after its pi_waiters got modified.
+ *
+ * This can be both boosting and unboosting. task->pi_lock must be held.
+ */
+static void __rt_mutex_adjust_prio(struct task_struct *task)
+{
+	int prio = rt_mutex_getprio(task);
+
+	if (task->prio != prio)
+		rt_mutex_setprio(task, prio);
+}
+
+/*
+ * Adjust task priority (undo boosting). Called from the exit path of
+ * rt_mutex_slowunlock() and rt_mutex_slowlock().
+ *
+ * (Note: We do this outside of the protection of lock->wait_lock to
+ * allow the lock to be taken while or before we readjust the priority
+ * of task. We do not use the spin_xx_mutex() variants here as we are
+ * outside of the debug path.)
+ */
+static void rt_mutex_adjust_prio(struct task_struct *task)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&task->pi_lock, flags);
+	__rt_mutex_adjust_prio(task);
+	spin_unlock_irqrestore(&task->pi_lock, flags);
+}
+
+/*
+ * PI-locking: we lock PI-dependencies opportunistically via trylock.
+ *
+ * In the overwhelming majority of cases the 'PI chain' is empty or at
+ * most 1-2 entries long, for which the trylock is sufficient,
+ * scalability-wise. The locking might look a bit scary, for which we
+ * apologize in advance :-)
+ *
+ * If any of the trylocks fails then we back out, task the global
+ * pi_conflicts_lock and take the locks again. This ensures deadlock-free
+ * but still scalable locking in the dependency graph, combined with
+ * the ability to reliably (and cheaply) detect user-space deadlocks.
+ */
+static DEFINE_SPINLOCK(pi_conflicts_lock);
+
+/*
+ * Lock the full boosting chain.
+ *
+ * If 'try' is set, we have to backout if we hit a owner who is
+ * running its own pi chain operation. We go back and take the slow
+ * path via the pi_conflicts_lock.
+ */
+static int lock_pi_chain(struct rt_mutex *act_lock,
+			 struct rt_mutex_waiter *waiter,
+			 struct list_head *lock_chain,
+			 int try, int detect_deadlock)
+{
+	struct task_struct *owner;
+	struct rt_mutex *nextlock, *lock = act_lock;
+	struct rt_mutex_waiter *nextwaiter;
+
+	/*
+	 * Debugging might turn deadlock detection on, unconditionally:
+	 */
+	detect_deadlock = debug_rt_mutex_detect_deadlock(detect_deadlock);
+
+	for (;;) {
+		owner = rt_mutex_owner(lock);
+
+		/* Check for circular dependencies */
+		if (unlikely(owner->pi_locked_by == current)) {
+			debug_rt_mutex_deadlock(detect_deadlock, waiter, lock);
+			return detect_deadlock ? -EDEADLK : 0;
+		}
+
+		while (!spin_trylock(&owner->pi_lock)) {
+			/*
+			 * Owner runs its own chain. Go back and take
+			 * the slow path
+			 */
+			if (try && owner->pi_locked_by == owner)
+				return -EBUSY;
+			cpu_relax();
+		}
+
+		BUG_ON(owner->pi_locked_by);
+		owner->pi_locked_by = current;
+		BUG_ON(!list_empty(&owner->pi_lock_chain));
+		list_add(&owner->pi_lock_chain, lock_chain);
+
+		/*
+		 * When the owner is blocked on a lock, try to take
+		 * the lock:
+		 */
+		nextwaiter = owner->pi_blocked_on;
+
+		/* End of chain? */
+		if (!nextwaiter)
+			return 0;
+
+		nextlock = nextwaiter->lock;
+
+		/* Check for circular dependencies: */
+		if (unlikely(nextlock == act_lock ||
+			     rt_mutex_owner(nextlock) == current)) {
+			debug_rt_mutex_deadlock(detect_deadlock, waiter,
+						nextlock);
+			list_del_init(&owner->pi_lock_chain);
+			owner->pi_locked_by = NULL;
+			spin_unlock(&owner->pi_lock);
+			return detect_deadlock ? -EDEADLK : 0;
+		}
+
+		/* Try to get nextlock->wait_lock: */
+		if (unlikely(!spin_trylock(&nextlock->wait_lock))) {
+			list_del_init(&owner->pi_lock_chain);
+			owner->pi_locked_by = NULL;
+			spin_unlock(&owner->pi_lock);
+			cpu_relax();
+			continue;
+		}
+
+		lock = nextlock;
+
+		/*
+		 * If deadlock detection is done (or has to be done, as
+		 * for userspace locks), we have to walk the full chain
+		 * unconditionally.
+		 */
+		if (detect_deadlock)
+			continue;
+
+		/*
+		 * Optimization: we only have to continue up to the point
+		 * where boosting/unboosting still has to be done:
+		 */
+
+		/* Boost or unboost? */
+		if (waiter) {
+			/* If the top waiter has higher priority, stop: */
+			if (rt_mutex_top_waiter(lock)->list_entry.prio <=
+			    waiter->list_entry.prio)
+				return 0;
+		} else {
+			/* If nextwaiter is not the top waiter, stop: */
+			if (rt_mutex_top_waiter(lock) != nextwaiter)
+				return 0;
+		}
+	}
+}
+
+/*
+ * Unlock the pi_chain:
+ */
+static void unlock_pi_chain(struct list_head *lock_chain)
+{
+	struct task_struct *owner, *tmp;
+
+	list_for_each_entry_safe(owner, tmp, lock_chain, pi_lock_chain) {
+		struct rt_mutex_waiter *waiter = owner->pi_blocked_on;
+
+		list_del_init(&owner->pi_lock_chain);
+		BUG_ON(!owner->pi_locked_by);
+		owner->pi_locked_by = NULL;
+		if (waiter)
+			spin_unlock(&waiter->lock->wait_lock);
+		spin_unlock(&owner->pi_lock);
+	}
+}
+
+/*
+ * Do the priority (un)boosting along the chain:
+ */
+static void adjust_pi_chain(struct rt_mutex *lock,
+			    struct rt_mutex_waiter *waiter,
+			    struct rt_mutex_waiter *top_waiter,
+			    struct list_head *lock_chain)
+{
+	struct task_struct *owner = rt_mutex_owner(lock);
+	struct list_head *curr = lock_chain->prev;
+
+	for (;;) {
+		if (top_waiter)
+			plist_del(&top_waiter->pi_list_entry,
+				  &owner->pi_waiters);
+
+		if (waiter && waiter == rt_mutex_top_waiter(lock)) {
+			waiter->pi_list_entry.prio = waiter->task->prio;
+			plist_add(&waiter->pi_list_entry, &owner->pi_waiters);
+		}
+		__rt_mutex_adjust_prio(owner);
+
+		waiter = owner->pi_blocked_on;
+		if (!waiter || curr->prev == lock_chain)
+			return;
+
+		curr = curr->prev;
+		lock = waiter->lock;
+		owner = rt_mutex_owner(lock);
+		top_waiter = rt_mutex_top_waiter(lock);
+
+		plist_del(&waiter->list_entry, &lock->wait_list);
+		waiter->list_entry.prio = waiter->task->prio;
+		plist_add(&waiter->list_entry, &lock->wait_list);
+
+		/*
+		 * We can stop here, if the waiter is/was not the top
+		 * priority waiter:
+		 */
+		if (top_waiter != waiter &&
+				waiter != rt_mutex_top_waiter(lock))
+			return;
+
+		/*
+		 * Note: waiter is not necessarily the new top
+		 * waiter!
+		 */
+		waiter = rt_mutex_top_waiter(lock);
+	}
+}
+
+/*
+ * Task blocks on lock.
+ *
+ * Prepare waiter and potentially propagate our priority into the pi chain.
+ *
+ * This must be called with lock->wait_lock held.
+ */
+static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
+				   struct rt_mutex_waiter *waiter,
+				   int detect_deadlock __IP_DECL__)
+{
+	int res = 0;
+	struct rt_mutex_waiter *top_waiter = waiter;
+	LIST_HEAD(lock_chain);
+
+	waiter->task = current;
+	waiter->lock = lock;
+	debug_rt_mutex_reset_waiter(waiter);
+
+	spin_lock(&current->pi_lock);
+	current->pi_locked_by = current;
+	plist_node_init(&waiter->list_entry, current->prio);
+	plist_node_init(&waiter->pi_list_entry, current->prio);
+
+	/* Get the top priority waiter of the lock: */
+	if (rt_mutex_has_waiters(lock))
+		top_waiter = rt_mutex_top_waiter(lock);
+	plist_add(&waiter->list_entry, &lock->wait_list);
+
+	current->pi_blocked_on = waiter;
+
+	/*
+	 * Call adjust_prio_chain, when waiter is the new top waiter
+	 * or when deadlock detection is requested:
+	 */
+	if (waiter != rt_mutex_top_waiter(lock) &&
+	    !debug_rt_mutex_detect_deadlock(detect_deadlock))
+		goto out;
+
+	/* Try to lock the full chain: */
+	res = lock_pi_chain(lock, waiter, &lock_chain, 1, detect_deadlock);
+
+	if (likely(!res))
+		adjust_pi_chain(lock, waiter, top_waiter, &lock_chain);
+
+	/* Common case: we managed to lock it: */
+	if (res != -EBUSY)
+		goto out_unlock;
+
+	/* Rare case: we hit some other task running a pi chain operation: */
+	unlock_pi_chain(&lock_chain);
+
+	plist_del(&waiter->list_entry, &lock->wait_list);
+	current->pi_blocked_on = NULL;
+	current->pi_locked_by = NULL;
+	spin_unlock(&current->pi_lock);
+	fixup_rt_mutex_waiters(lock);
+
+	spin_unlock(&lock->wait_lock);
+
+	spin_lock(&pi_conflicts_lock);
+
+	spin_lock(&current->pi_lock);
+	current->pi_locked_by = current;
+	spin_lock(&lock->wait_lock);
+	if (!rt_mutex_owner(lock)) {
+		waiter->task = NULL;
+		spin_unlock(&pi_conflicts_lock);
+		goto out;
+	}
+	plist_node_init(&waiter->list_entry, current->prio);
+	plist_node_init(&waiter->pi_list_entry, current->prio);
+
+	/* Get the top priority waiter of the lock: */
+	if (rt_mutex_has_waiters(lock))
+		top_waiter = rt_mutex_top_waiter(lock);
+	plist_add(&waiter->list_entry, &lock->wait_list);
+
+	current->pi_blocked_on = waiter;
+
+	/* Lock the full chain: */
+	res = lock_pi_chain(lock, waiter, &lock_chain, 0, detect_deadlock);
+
+	/* Drop the conflicts lock before adjusting: */
+	spin_unlock(&pi_conflicts_lock);
+
+	if (likely(!res))
+		adjust_pi_chain(lock, waiter, top_waiter, &lock_chain);
+
+ out_unlock:
+	unlock_pi_chain(&lock_chain);
+ out:
+	current->pi_locked_by = NULL;
+	spin_unlock(&current->pi_lock);
+	return res;
+}
+
+/*
+ * Optimization: check if we can steal the lock from the
+ * assigned pending owner [which might not have taken the
+ * lock yet]:
+ */
+static inline int try_to_steal_lock(struct rt_mutex *lock)
+{
+	struct task_struct *pendowner = rt_mutex_owner(lock);
+	struct rt_mutex_waiter *next;
+
+	if (!rt_mutex_owner_pending(lock))
+		return 0;
+
+	if (pendowner == current)
+		return 1;
+
+	spin_lock(&pendowner->pi_lock);
+	if (current->prio >= pendowner->prio) {
+		spin_unlock(&pendowner->pi_lock);
+		return 0;
+	}
+
+	/*
+	 * Check if a waiter is enqueued on the pending owners
+	 * pi_waiters list. Remove it and readjust pending owners
+	 * priority.
+	 */
+	if (likely(!rt_mutex_has_waiters(lock))) {
+		spin_unlock(&pendowner->pi_lock);
+		return 1;
+	}
+
+	/* No chain handling, pending owner is not blocked on anything: */
+	next = rt_mutex_top_waiter(lock);
+	plist_del(&next->pi_list_entry, &pendowner->pi_waiters);
+	__rt_mutex_adjust_prio(pendowner);
+	spin_unlock(&pendowner->pi_lock);
+
+	/*
+	 * We are going to steal the lock and a waiter was
+	 * enqueued on the pending owners pi_waiters queue. So
+	 * we have to enqueue this waiter into
+	 * current->pi_waiters list. This covers the case,
+	 * where current is boosted because it holds another
+	 * lock and gets unboosted because the booster is
+	 * interrupted, so we would delay a waiter with higher
+	 * priority as current->normal_prio.
+	 *
+	 * Note: in the rare case of a SCHED_OTHER task changing
+	 * its priority and thus stealing the lock, next->task
+	 * might be current:
+	 */
+	if (likely(next->task != current)) {
+		spin_lock(&current->pi_lock);
+		plist_add(&next->pi_list_entry, &current->pi_waiters);
+		__rt_mutex_adjust_prio(current);
+		spin_unlock(&current->pi_lock);
+	}
+	return 1;
+}
+
+/*
+ * Try to take an rt-mutex
+ *
+ * This fails
+ * - when the lock has a real owner
+ * - when a different pending owner exists and has higher priority than current
+ *
+ * Must be called with lock->wait_lock held.
+ */
+static int try_to_take_rt_mutex(struct rt_mutex *lock __IP_DECL__)
+{
+	/*
+	 * We have to be careful here if the atomic speedups are
+	 * enabled, such that, when
+	 *  - no other waiter is on the lock
+	 *  - the lock has been released since we did the cmpxchg
+	 * the lock can be released or taken while we are doing the
+	 * checks and marking the lock with RT_MUTEX_HAS_WAITERS.
+	 *
+	 * The atomic acquire/release aware variant of
+	 * mark_rt_mutex_waiters uses a cmpxchg loop. After setting
+	 * the WAITERS bit, the atomic release / acquire can not
+	 * happen anymore and lock->wait_lock protects us from the
+	 * non-atomic case.
+	 *
+	 * Note, that this might set lock->owner =
+	 * RT_MUTEX_HAS_WAITERS in the case the lock is not contended
+	 * any more. This is fixed up when we take the ownership.
+	 */
+	mark_rt_mutex_waiters(lock);
+
+	if (rt_mutex_owner(lock) && !try_to_steal_lock(lock))
+		return 0;
+
+	/* We got the lock. */
+	debug_rt_mutex_lock(lock __IP__);
+
+	rt_mutex_set_owner(lock, current, 0);
+
+	rt_mutex_deadlock_account_lock(lock, current);
+
+	return 1;
+}
+
+/*
+ * Wake up the next waiter on the lock.
+ *
+ * Remove the top waiter from the current tasks waiter list and from
+ * the lock waiter list. Set it as pending owner. Then wake it up.
+ *
+ * Called with lock->wait_lock held.
+ */
+static void wakeup_next_waiter(struct rt_mutex *lock)
+{
+	struct rt_mutex_waiter *waiter;
+	struct task_struct *pendowner;
+
+	waiter = rt_mutex_top_waiter(lock);
+	plist_del(&waiter->list_entry, &lock->wait_list);
+
+	/*
+	 * Remove it from current->pi_waiters. We do not adjust a
+	 * possible priority boost right now. We execute wakeup in the
+	 * boosted mode and go back to normal after releasing
+	 * lock->wait_lock.
+	 */
+	spin_lock(&current->pi_lock);
+	plist_del(&waiter->pi_list_entry, &current->pi_waiters);
+	spin_unlock(&current->pi_lock);
+
+	pendowner = waiter->task;
+	waiter->task = NULL;
+
+	rt_mutex_set_owner(lock, pendowner, RT_MUTEX_OWNER_PENDING);
+
+	/*
+	 * Clear the pi_blocked_on variable and enqueue a possible
+	 * waiter into the pi_waiters list of the pending owner. This
+	 * prevents that in case the pending owner gets unboosted a
+	 * waiter with higher priority than pending-owner->normal_prio
+	 * is blocked on the unboosted (pending) owner.
+	 */
+	spin_lock(&pendowner->pi_lock);
+
+	WARN_ON(!pendowner->pi_blocked_on);
+	WARN_ON(pendowner->pi_blocked_on != waiter);
+	WARN_ON(pendowner->pi_blocked_on->lock != lock);
+
+	pendowner->pi_blocked_on = NULL;
+
+	if (rt_mutex_has_waiters(lock)) {
+		struct rt_mutex_waiter *next;
+
+		next = rt_mutex_top_waiter(lock);
+		plist_add(&next->pi_list_entry, &pendowner->pi_waiters);
+	}
+	spin_unlock(&pendowner->pi_lock);
+
+	wake_up_process(pendowner);
+}
+
+/*
+ * Remove a waiter from a lock
+ *
+ * Must be called with lock->wait_lock held.
+ */
+static int remove_waiter(struct rt_mutex *lock,
+			 struct rt_mutex_waiter *waiter __IP_DECL__)
+{
+	struct rt_mutex_waiter *next_waiter = NULL,
+				*top_waiter = rt_mutex_top_waiter(lock);
+	LIST_HEAD(lock_chain);
+	int res;
+
+	plist_del(&waiter->list_entry, &lock->wait_list);
+
+	spin_lock(&current->pi_lock);
+
+	if (waiter != top_waiter || rt_mutex_owner(lock) == current)
+		goto out;
+
+	current->pi_locked_by = current;
+
+	if (rt_mutex_has_waiters(lock))
+		next_waiter = rt_mutex_top_waiter(lock);
+
+	/* Try to lock the full chain: */
+	res = lock_pi_chain(lock, next_waiter, &lock_chain, 1, 0);
+
+	if (likely(res != -EBUSY)) {
+		adjust_pi_chain(lock, next_waiter, waiter, &lock_chain);
+		goto out_unlock;
+	}
+
+	/* We hit some other task running a pi chain operation: */
+	unlock_pi_chain(&lock_chain);
+	plist_add(&waiter->list_entry, &lock->wait_list);
+	current->pi_blocked_on = waiter;
+	current->pi_locked_by = NULL;
+	spin_unlock(&current->pi_lock);
+	spin_unlock(&lock->wait_lock);
+
+	spin_lock(&pi_conflicts_lock);
+
+	spin_lock(&current->pi_lock);
+	current->pi_locked_by = current;
+
+	spin_lock(&lock->wait_lock);
+
+	/* We might have been woken up: */
+	if (!waiter->task) {
+		spin_unlock(&pi_conflicts_lock);
+		goto out;
+	}
+
+	top_waiter = rt_mutex_top_waiter(lock);
+
+	plist_del(&waiter->list_entry, &lock->wait_list);
+
+	if (waiter != top_waiter || rt_mutex_owner(lock) == current)
+		goto out;
+
+	/* Get the top priority waiter of the lock: */
+	if (rt_mutex_has_waiters(lock))
+		next_waiter = rt_mutex_top_waiter(lock);
+
+	/* Lock the full chain: */
+	lock_pi_chain(lock, next_waiter, &lock_chain, 0, 0);
+
+	/* Drop the conflicts lock: */
+	spin_unlock(&pi_conflicts_lock);
+
+	adjust_pi_chain(lock, next_waiter, waiter, &lock_chain);
+
+ out_unlock:
+	unlock_pi_chain(&lock_chain);
+ out:
+	current->pi_blocked_on = NULL;
+	waiter->task = NULL;
+	current->pi_locked_by = NULL;
+	spin_unlock(&current->pi_lock);
+
+	WARN_ON(!plist_node_empty(&waiter->pi_list_entry));
+
+	return 0;
+}
+
+/*
+ * Slow path lock function:
+ */
+static int fastcall noinline __sched
+rt_mutex_slowlock(struct rt_mutex *lock, int state,
+		  struct hrtimer_sleeper *timeout,
+		  int detect_deadlock __IP_DECL__)
+{
+	struct rt_mutex_waiter waiter;
+	int ret = 0;
+	unsigned long flags;
+
+	debug_rt_mutex_init_waiter(&waiter);
+	waiter.task = NULL;
+
+	spin_lock_irqsave(&lock->wait_lock, flags);
+
+	/* Try to acquire the lock again: */
+	if (try_to_take_rt_mutex(lock __IP__)) {
+		spin_unlock_irqrestore(&lock->wait_lock, flags);
+		return 0;
+	}
+
+	BUG_ON(rt_mutex_owner(lock) == current);
+
+	set_task_state(current, state);
+
+	/* Setup the timer, when timeout != NULL */
+	if (unlikely(timeout))
+		hrtimer_start(&timeout->timer, timeout->timer.expires,
+			      HRTIMER_ABS);
+
+	for (;;) {
+		/* Try to acquire the lock: */
+		if (try_to_take_rt_mutex(lock __IP__))
+			break;
+
+		/*
+		 * TASK_INTERRUPTIBLE checks for signals and
+		 * timeout. Ignored otherwise.
+		 */
+		if (unlikely(state == TASK_INTERRUPTIBLE)) {
+			/* Signal pending? */
+			if (signal_pending(current))
+				ret = -EINTR;
+			if (timeout && !timeout->task)
+				ret = -ETIMEDOUT;
+			if (ret)
+				break;
+		}
+
+		/*
+		 * waiter.task is NULL the first time we come here and
+		 * when we have been woken up by the previous owner
+		 * but the lock got stolen by an higher prio task.
+		 */
+		if (!waiter.task) {
+			ret = task_blocks_on_rt_mutex(lock, &waiter,
+						      detect_deadlock __IP__);
+			if (ret == -EDEADLK)
+				break;
+			if (ret == -EBUSY)
+				continue;
+		}
+
+		spin_unlock_irqrestore(&lock->wait_lock, flags);
+
+		debug_rt_mutex_print_deadlock(&waiter);
+
+		schedule();
+
+		spin_lock_irqsave(&lock->wait_lock, flags);
+		set_task_state(current, state);
+	}
+
+	set_task_state(current, TASK_RUNNING);
+
+	if (unlikely(waiter.task))
+		remove_waiter(lock, &waiter __IP__);
+
+	/*
+	 * try_to_take_rt_mutex() sets the waiter bit
+	 * unconditionally. We might have to fix that up.
+	 */
+	fixup_rt_mutex_waiters(lock);
+
+	spin_unlock_irqrestore(&lock->wait_lock, flags);
+
+	/* Remove pending timer: */
+	if (unlikely(timeout && timeout->task))
+		hrtimer_cancel(&timeout->timer);
+
+	/*
+	 * Readjust priority, when we did not get the lock. We might
+	 * have been the pending owner and boosted. Since we did not
+	 * take the lock, the PI boost has to go.
+	 */
+	if (unlikely(ret))
+		rt_mutex_adjust_prio(current);
+
+	debug_rt_mutex_free_waiter(&waiter);
+
+	return ret;
+}
+
+/*
+ * Slow path try-lock function:
+ */
+static inline int fastcall
+rt_mutex_slowtrylock(struct rt_mutex *lock __IP_DECL__)
+{
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&lock->wait_lock, flags);
+
+	if (likely(rt_mutex_owner(lock) != current)) {
+
+		ret = try_to_take_rt_mutex(lock __IP__);
+		/*
+		 * try_to_take_rt_mutex() sets the lock waiters
+		 * bit. We might be the only waiter. Check if this
+		 * needs to be cleaned up.
+		 */
+		if (!ret)
+			fixup_rt_mutex_waiters(lock);
+	}
+
+	spin_unlock_irqrestore(&lock->wait_lock, flags);
+
+	return ret;
+}
+
+/*
+ * Slow path to release a rt-mutex:
+ */
+static void fastcall noinline __sched
+rt_mutex_slowunlock(struct rt_mutex *lock)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&lock->wait_lock, flags);
+
+	debug_rt_mutex_unlock(lock);
+
+	rt_mutex_deadlock_account_unlock(current);
+
+	if (!rt_mutex_has_waiters(lock)) {
+		lock->owner = NULL;
+		spin_unlock_irqrestore(&lock->wait_lock, flags);
+		return;
+	}
+
+	wakeup_next_waiter(lock);
+
+	spin_unlock_irqrestore(&lock->wait_lock, flags);
+
+	/* Undo pi boosting if necessary: */
+	rt_mutex_adjust_prio(current);
+}
+
+/*
+ * debug aware fast / slowpath lock,trylock,unlock
+ *
+ * The atomic acquire/release ops are compiled away, when either the
+ * architecture does not support cmpxchg or when debugging is enabled.
+ */
+static inline int
+rt_mutex_fastlock(struct rt_mutex *lock, int state,
+		  int detect_deadlock,
+		  int fastcall (*slowfn)(struct rt_mutex *lock, int state,
+					 struct hrtimer_sleeper *timeout,
+					 int detect_deadlock __IP_DECL__))
+{
+	if (!detect_deadlock && likely(rt_mutex_cmpxchg(lock, NULL, current))) {
+		rt_mutex_deadlock_account_lock(lock, current);
+		return 0;
+	} else
+		return slowfn(lock, state, NULL, detect_deadlock __RET_IP__);
+}
+
+static inline int
+rt_mutex_timed_fastlock(struct rt_mutex *lock, int state,
+			struct hrtimer_sleeper *timeout, int detect_deadlock,
+			int fastcall (*slowfn)(struct rt_mutex *lock, int state,
+					       struct hrtimer_sleeper *timeout,
+					       int detect_deadlock __IP_DECL__))
+{
+	if (!detect_deadlock && likely(rt_mutex_cmpxchg(lock, NULL, current))) {
+		rt_mutex_deadlock_account_lock(lock, current);
+		return 0;
+	} else
+		return slowfn(lock, state, timeout, detect_deadlock __RET_IP__);
+}
+
+static inline int
+rt_mutex_fasttrylock(struct rt_mutex *lock,
+		     int fastcall (*slowfn)(struct rt_mutex *lock __IP_DECL__))
+{
+	if (likely(rt_mutex_cmpxchg(lock, NULL, current))) {
+		rt_mutex_deadlock_account_lock(lock, current);
+		return 1;
+	}
+	return slowfn(lock __RET_IP__);
+}
+
+static inline void
+rt_mutex_fastunlock(struct rt_mutex *lock,
+		    void fastcall (*slowfn)(struct rt_mutex *lock))
+{
+	if (likely(rt_mutex_cmpxchg(lock, current, NULL)))
+		rt_mutex_deadlock_account_unlock(current);
+	else
+		slowfn(lock);
+}
+
+/**
+ * rt_mutex_lock - lock a rt_mutex
+ *
+ * @lock: the rt_mutex to be locked
+ */
+void fastcall __sched rt_mutex_lock(struct rt_mutex *lock)
+{
+	might_sleep();
+
+	rt_mutex_fastlock(lock, TASK_UNINTERRUPTIBLE, 0, rt_mutex_slowlock);
+}
+EXPORT_SYMBOL_GPL(rt_mutex_lock);
+
+/**
+ * rt_mutex_lock_interruptible - lock a rt_mutex interruptible
+ *
+ * @lock: 		the rt_mutex to be locked
+ * @detect_deadlock:	deadlock detection on/off
+ *
+ * Returns:
+ *  0 		on success
+ * -EINTR 	when interrupted by a signal
+ * -EDEADLK	when the lock would deadlock (when deadlock detection is on)
+ */
+int fastcall __sched rt_mutex_lock_interruptible(struct rt_mutex *lock,
+						 int detect_deadlock)
+{
+	might_sleep();
+
+	return rt_mutex_fastlock(lock, TASK_INTERRUPTIBLE,
+				 detect_deadlock, rt_mutex_slowlock);
+}
+EXPORT_SYMBOL_GPL(rt_mutex_lock_interruptible);
+
+/**
+ * rt_mutex_lock_interruptible_ktime - lock a rt_mutex interruptible
+ *				       the timeout structure is provided
+ *				       by the caller
+ *
+ * @lock: 		the rt_mutex to be locked
+ * @timeout:		timeout structure or NULL (no timeout)
+ * @detect_deadlock:	deadlock detection on/off
+ *
+ * Returns:
+ *  0 		on success
+ * -EINTR 	when interrupted by a signal
+ * -ETIMEOUT	when the timeout expired
+ * -EDEADLK	when the lock would deadlock (when deadlock detection is on)
+ */
+int fastcall
+rt_mutex_timed_lock(struct rt_mutex *lock, struct hrtimer_sleeper *timeout,
+		    int detect_deadlock)
+{
+	might_sleep();
+
+	return rt_mutex_timed_fastlock(lock, TASK_INTERRUPTIBLE, timeout,
+				       detect_deadlock, rt_mutex_slowlock);
+}
+EXPORT_SYMBOL_GPL(rt_mutex_timed_lock);
+
+
+/**
+ * rt_mutex_trylock - try to lock a rt_mutex
+ *
+ * @lock:	the rt_mutex to be locked
+ *
+ * Returns 1 on success and 0 on contention
+ */
+int fastcall __sched rt_mutex_trylock(struct rt_mutex *lock)
+{
+	return rt_mutex_fasttrylock(lock, rt_mutex_slowtrylock);
+}
+EXPORT_SYMBOL_GPL(rt_mutex_trylock);
+
+/**
+ * rt_mutex_unlock - unlock a rt_mutex
+ *
+ * @lock: the rt_mutex to be unlocked
+ */
+void fastcall __sched rt_mutex_unlock(struct rt_mutex *lock)
+{
+	rt_mutex_fastunlock(lock, rt_mutex_slowunlock);
+}
+EXPORT_SYMBOL_GPL(rt_mutex_unlock);
+
+/***
+ * rt_mutex_destroy - mark a mutex unusable
+ * @lock: the mutex to be destroyed
+ *
+ * This function marks the mutex uninitialized, and any subsequent
+ * use of the mutex is forbidden. The mutex must not be locked when
+ * this function is called.
+ */
+void fastcall rt_mutex_destroy(struct rt_mutex *lock)
+{
+	WARN_ON(rt_mutex_is_locked(lock));
+#ifdef CONFIG_DEBUG_RT_MUTEXES
+	lock->magic = NULL;
+#endif
+}
+
+EXPORT_SYMBOL_GPL(rt_mutex_destroy);
+
+/**
+ * __rt_mutex_init - initialize the rt lock
+ *
+ * @lock: the rt lock to be initialized
+ *
+ * Initialize the rt lock to unlocked state.
+ *
+ * Initializing of a locked rt lock is not allowed
+ */
+void fastcall __rt_mutex_init(struct rt_mutex *lock, const char *name)
+{
+	lock->owner = NULL;
+	spin_lock_init(&lock->wait_lock);
+	plist_head_init(&lock->wait_list);
+
+	debug_rt_mutex_init(lock, name);
+}
+EXPORT_SYMBOL_GPL(__rt_mutex_init);
Index: linux-pi-futex.mm.q/kernel/rtmutex.h
===================================================================
--- /dev/null
+++ linux-pi-futex.mm.q/kernel/rtmutex.h
@@ -0,0 +1,28 @@
+/*
+ * RT-Mutexes: blocking mutual exclusion locks with PI support
+ *
+ * started by Ingo Molnar and Thomas Gleixner:
+ *
+ *  Copyright (C) 2004-2006 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
+ *  Copyright (C) 2006, Timesys Corp., Thomas Gleixner <tglx@timesys.com>
+ *
+ * This file contains macros used solely by rtmutex.c.
+ * Non-debug version.
+ */
+
+#define __IP_DECL__
+#define __IP__
+#define __RET_IP__
+#define rt_mutex_deadlock_check(l)			(0)
+#define rt_mutex_deadlock_account_lock(m, t)		do { } while (0)
+#define rt_mutex_deadlock_account_unlock(l)		do { } while (0)
+#define debug_rt_mutex_init_waiter(w)			do { } while (0)
+#define debug_rt_mutex_free_waiter(w)			do { } while (0)
+#define debug_rt_mutex_lock(l)				do { } while (0)
+#define debug_rt_mutex_proxy_unlock(l)			do { } while (0)
+#define debug_rt_mutex_unlock(l)			do { } while (0)
+#define debug_rt_mutex_init(m, n)			do { } while (0)
+#define debug_rt_mutex_deadlock(d, a ,l)		do { } while (0)
+#define debug_rt_mutex_print_deadlock(w)		do { } while (0)
+#define debug_rt_mutex_detect_deadlock(d)		(d)
+#define debug_rt_mutex_reset_waiter(w)			do { } while (0)
