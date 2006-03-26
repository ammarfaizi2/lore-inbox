Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbWCZQHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWCZQHV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 11:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWCZQHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 11:07:21 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:28603 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751345AbWCZQHU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 11:07:20 -0500
Date: Sun, 26 Mar 2006 18:03:53 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, torvalds@osdl.org,
       arjan@infradead.org, Esben Nielsen <simlo@phys.au.dk>
Subject: [patch] PI-futex: -V2
Message-ID: <20060326160353.GA13282@elte.hu>
References: <20060325184612.GF16724@elte.hu> <20060325220728.3d5c8d36.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060325220728.3d5c8d36.akpm@osdl.org>
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


* Andrew Morton <akpm@osdl.org> wrote:

> > +struct rt_mutex {
> > +	spinlock_t		wait_lock;
> > +	struct plist_head	wait_list;
> > +	struct task_struct	*owner;
> > +# ifdef CONFIG_DEBUG_RT_MUTEXES

> The indented #-statments make some sense when we're using nested #ifs 
> (although I tend to accidentally-on-purpose delete them).  But the 
> above ones aren't even nested..

fixed.

> > +extern void fastcall __rt_mutex_init(struct rt_mutex *lock, const char *name);
> > +extern void fastcall rt_mutex_destroy(struct rt_mutex *lock);

> Does fastcall actually do any good?  Isn't CONFIG_REGPARM equivalent 
> to that anyway?  It's a bit of an eyesore.

it's not needed - i removed all of them. (This code was started before 
REGPARM was reliable enough for distros to enable.)

> > +#ifdef CONFIG_RT_MUTEXES
> > +# define rt_mutex_init_task(p)						\
> > + do {									\
> > +	spin_lock_init(&p->pi_lock);					\
> > +	plist_head_init(&p->pi_waiters);				\
> > +	p->pi_blocked_on = NULL;					\
> > +	p->pi_locked_by = NULL;						\
> > +	INIT_LIST_HEAD(&p->pi_lock_chain);				\
> > + } while (0)
> 
> Somewhere in there is a C function struggling to escape.

ok, i've moved this to fork.c, into an inline function.

> > Index: linux-pi-futex.mm.q/include/linux/rtmutex_internal.h
> 
> Perhaps this could go in kernel/.  If you think that's valuable.

agreed, i moved it. (i also renamed it to rtmutex_common.h, and cleaned 
it up some more.)

> > +#define task_top_pi_waiter(task) 	\
> > +	plist_first_entry(&task->pi_waiters, struct rt_mutex_waiter, pi_list_entry)
> 
> All of these can become C functions, yes?

agreed, done.

> > +#define rt_mutex_owner_pending(lock)					\
> > +({									\
> > +	typecheck(struct rt_mutex *,(lock));				\
> > +	((unsigned long)((lock)->owner) & RT_MUTEX_OWNER_PENDING);	\
> > +})
> 
> Bizarre.  The `typecheck' thingies were added, I assume, because these 
> macros really wanted to be C functions?

correct - i converted them to C inline functions. (These macros are the 
side-effect of them being in the generic rtmutex.h file for a long time 
- and that file gets included early on in the -rt tree, when various 
structures used by these macros are not defined yet.)

> > +static inline void rt_mutex_set_owner(struct rt_mutex *lock, struct task_struct *owner,
> > +				      unsigned long msk)
> > +{
> > +	unsigned long val = ((unsigned long) owner) | msk;
> > +
> > +	if (rt_mutex_has_waiters(lock))
> > +		val |= RT_MUTEX_HAS_WAITERS;
> > +
> > +	lock->owner = (struct task_struct *)(val);
> > +}
> 
> Might be getting a bit large for inlining.

agreed. I moved these functions to rtmutex.c and uninlined the bigger 
ones.

> > +		/* End of chain? */
> > +		if (!nextwaiter)
> > +			return 0;
> 
> We return zero with the spinlock held?  I guess that's the point of the
> whole function.

correct. It's a "lock this chain" function call.

> > +		nextlock = nextwaiter->lock;
> > +
> > +		/* Check for circular dependencies: */
> > +		if (unlikely(nextlock == act_lock ||
> > +			     rt_mutex_owner(nextlock) == current)) {
> > +			debug_rt_mutex_deadlock(detect_deadlock, waiter,
> > +						nextlock);
> > +			list_del_init(&owner->pi_lock_chain);
> > +			owner->pi_locked_by = NULL;
> > +			spin_unlock(&owner->pi_lock);
> > +			return detect_deadlock ? -EDEADLK : 0;
> > +		}
> 
> But here we can return zero without having locked anything.  How does 
> the caller know what locks are held?

this is a loop, and we might have taken other locks up to this point.  
The locks taken are the ones put into the p->pi_lock_chain list ... 
which list is walked at lock-release time.

> This function needs a better covering description, IMO.

ok, added some more comments explaining it better.

> > +		/* Try to get nextlock->wait_lock: */
> > +		if (unlikely(!spin_trylock(&nextlock->wait_lock))) {
> > +			list_del_init(&owner->pi_lock_chain);
> > +			owner->pi_locked_by = NULL;
> > +			spin_unlock(&owner->pi_lock);
> > +			cpu_relax();
> > +			continue;
> > +		}
> 
> All these trylocks and cpu_relaxes are a worry.

this is a typical lock-order solution we use in other places in the 
kernel: the common locking order is ->wait_lock + ->pi_lock - but in 
this case we have to take ->pi_lock first - hence the ->trylock, 
pi_lock-release, cpu_relax() and redoing of the pi_lock.

> > +/*
> > + * Do the priority (un)boosting along the chain:
> > + */
> > +static void adjust_pi_chain(struct rt_mutex *lock,
> > +			    struct rt_mutex_waiter *waiter,
> > +			    struct rt_mutex_waiter *top_waiter,
> > +			    struct list_head *lock_chain)
> > +{
> > +	struct task_struct *owner = rt_mutex_owner(lock);
> > +	struct list_head *curr = lock_chain->prev;
> > +
> > +	for (;;) {
> > +		if (top_waiter)
> > +			plist_del(&top_waiter->pi_list_entry,
> > +				  &owner->pi_waiters);
> > +
> > +		if (waiter && waiter == rt_mutex_top_waiter(lock)) {
> 
> rt_mutex_top_waiter() can never return NULL, so the test for NULL 
> could be removed.

it might be NULL if adjust_pi_chain() is called from remove_waiter(), 
and next_waiter there is NULL (because !rt_mutex_has_waiters() after the 
removal of the current waiter).

> > +/*
> > + * Slow path lock function:
> > + */
> > +static int fastcall noinline __sched
> > +rt_mutex_slowlock(struct rt_mutex *lock, int state,
> > +		  struct hrtimer_sleeper *timeout,
> > +		  int detect_deadlock __IP_DECL__)
> > +{
> 
> heh, fastcall slowpath.  Why's it noinline?

leftovers of cycle-level optimizations from the -rt tree. I've removed 
it, it's not needed anymore.

> > +	set_task_state(current, state);
> 
> set_current_state()  (Several more below)

fixed.

> > +EXPORT_SYMBOL_GPL(__rt_mutex_init);
> 
> What's the export for?

for the -rt tree. (latest -rt trees are based on this patch-queue and
rt-mutex subsystem as-is) Right now the rt-tester code uses it - which
isnt modular (but it could be made modular). Should i remove the export?

find below a delta patch to the current patch-queue you have in -mm.
Most of the patches in the -V2 queue were changed, so there are only two
options: a full updated queue or to add this all-included update patch.

this update includes the fixes for the things you noticed, plus a couple 
of more cleanups, and a fix from Esben Nielsen for the PI logic. I have 
merged the -V2 queue to the -rt tree [and have released 2.6.16-rt8] and 
have re-checked the PI code under load - it's all looking good.

	Ingo

------
From: Ingo Molnar <mingo@elte.hu>

clean up the code as per Andrew's suggestions:

 - '# ifdef' => '#ifdef'
 - fastcall removal
 - lots of macro -> C function conversions
 - move rtmutex_internals.h to kernel/rtmutex_common.h
 - uninline two larger functions
 - remove noinline
 - explain locking better
 - set_task_state(current, state) => set_current_state(state)

 - fix the PI code (Esben Nielsen)

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/linux/rtmutex_internal.h |  187 ---------------------------------------
 linux/include/linux/rtmutex.h    |   29 ++----
 linux/kernel/fork.c              |   11 ++
 linux/kernel/futex.c             |    3 
 linux/kernel/rtmutex-debug.c     |    2 
 linux/kernel/rtmutex-debug.h     |    2 
 linux/kernel/rtmutex.c           |  116 ++++++++++++++++++++----
 linux/kernel/rtmutex_common.h    |  123 +++++++++++++++++++++++++
 linux/kernel/sched.c             |    2 
 9 files changed, 247 insertions(+), 228 deletions(-)

Index: linux/include/linux/rtmutex.h
===================================================================
--- linux.orig/include/linux/rtmutex.h
+++ linux/include/linux/rtmutex.h
@@ -27,14 +27,14 @@ struct rt_mutex {
 	spinlock_t		wait_lock;
 	struct plist_head	wait_list;
 	struct task_struct	*owner;
-# ifdef CONFIG_DEBUG_RT_MUTEXES
+#ifdef CONFIG_DEBUG_RT_MUTEXES
 	int			save_state;
 	struct list_head	held_list;
 	unsigned long		acquire_ip;
 	const char 		*name, *file;
 	int			line;
 	void			*magic;
-# endif
+#endif
 };
 
 struct rt_mutex_waiter;
@@ -79,40 +79,31 @@ struct hrtimer_sleeper;
  *
  * Returns 1 if the mutex is locked, 0 if unlocked.
  */
-static inline int fastcall rt_mutex_is_locked(struct rt_mutex *lock)
+static inline int rt_mutex_is_locked(struct rt_mutex *lock)
 {
 	return lock->owner != NULL;
 }
 
-extern void fastcall __rt_mutex_init(struct rt_mutex *lock, const char *name);
-extern void fastcall rt_mutex_destroy(struct rt_mutex *lock);
+extern void __rt_mutex_init(struct rt_mutex *lock, const char *name);
+extern void rt_mutex_destroy(struct rt_mutex *lock);
 
-extern void fastcall rt_mutex_lock(struct rt_mutex *lock);
-extern int fastcall rt_mutex_lock_interruptible(struct rt_mutex *lock,
+extern void rt_mutex_lock(struct rt_mutex *lock);
+extern int rt_mutex_lock_interruptible(struct rt_mutex *lock,
 						int detect_deadlock);
-extern int fastcall rt_mutex_timed_lock(struct rt_mutex *lock,
+extern int rt_mutex_timed_lock(struct rt_mutex *lock,
 					struct hrtimer_sleeper *timeout,
 					int detect_deadlock);
 
-extern int fastcall rt_mutex_trylock(struct rt_mutex *lock);
+extern int rt_mutex_trylock(struct rt_mutex *lock);
 
-extern void fastcall rt_mutex_unlock(struct rt_mutex *lock);
+extern void rt_mutex_unlock(struct rt_mutex *lock);
 
 #ifdef CONFIG_RT_MUTEXES
-# define rt_mutex_init_task(p)						\
- do {									\
-	spin_lock_init(&p->pi_lock);					\
-	plist_head_init(&p->pi_waiters);				\
-	p->pi_blocked_on = NULL;					\
-	p->pi_locked_by = NULL;						\
-	INIT_LIST_HEAD(&p->pi_lock_chain);				\
- } while (0)
 # define INIT_RT_MUTEXES(tsk)						\
 	.pi_waiters	= PLIST_HEAD_INIT(tsk.pi_waiters),		\
 	.pi_lock	= SPIN_LOCK_UNLOCKED,				\
 	.pi_lock_chain	= LIST_HEAD_INIT(tsk.pi_lock_chain),
 #else
-# define rt_mutex_init_task(p)		do { } while (0)
 # define INIT_RT_MUTEXES(tsk)
 #endif
 
Index: linux/include/linux/rtmutex_internal.h
===================================================================
--- linux.orig/include/linux/rtmutex_internal.h
+++ /dev/null
@@ -1,187 +0,0 @@
-/*
- * RT Mutexes: blocking mutual exclusion locks with PI support
- *
- * started by Ingo Molnar and Thomas Gleixner:
- *
- *  Copyright (C) 2004-2006 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
- *  Copyright (C) 2006, Timesys Corp., Thomas Gleixner <tglx@timesys.com>
- *
- * This file contains the private data structure and API definitions.
- */
-
-#ifndef __LINUX_RT_MUTEX_INTERNAL_H
-#define __LINUX_RT_MUTEX_INTERNAL_H
-
-#include <linux/rtmutex.h>
-
-/*
- * The rtmutex in kernel tester is independent of rtmutex debugging. We
- * call schedule_rt_mutex_test() instead of schedule() for the tasks which
- * belong to the tester. That way we can delay the wakeup path of those
- * threads to provoke lock stealing and testing of  complex boosting scenarios.
- */
-#ifdef CONFIG_RT_MUTEX_TESTER
-
-extern void schedule_rt_mutex_test(struct rt_mutex *lock);
-
-#define schedule_rt_mutex(_lock)				\
-  do {								\
-	if (!(current->flags & PF_MUTEX_TESTER))		\
-		schedule();					\
-	else							\
-		schedule_rt_mutex_test(_lock);			\
-  } while (0)
-
-#else
-# define schedule_rt_mutex(_lock)			schedule()
-#endif
-
-/*
- * This is the control structure for tasks blocked on a rt_mutex,
- * which is allocated on the kernel stack on of the blocked task.
- *
- * @list_entry:		pi node to enqueue into the mutex waiters list
- * @pi_list_entry:	pi node to enqueue into the mutex owner waiters list
- * @task:		task reference to the blocked task
- */
-struct rt_mutex_waiter {
-	struct plist_node	list_entry;
-	struct plist_node	pi_list_entry;
-	struct task_struct	*task;
-	struct rt_mutex		*lock;
-#ifdef CONFIG_DEBUG_RT_MUTEXES
-	unsigned long		ip;
-	pid_t			deadlock_task_pid;
-	struct rt_mutex		*deadlock_lock;
-#endif
-};
-
-/*
- * Plist wrapper macros
- */
-#define rt_mutex_has_waiters(lock)	(!plist_head_empty(&lock->wait_list))
-
-#define rt_mutex_top_waiter(lock) 	\
-({ struct rt_mutex_waiter *__w = plist_first_entry(&lock->wait_list, \
-					struct rt_mutex_waiter, list_entry); \
-	BUG_ON(__w->lock != lock);	\
-	__w;				\
-})
-
-#define task_has_pi_waiters(task)	(!plist_head_empty(&task->pi_waiters))
-
-#define task_top_pi_waiter(task) 	\
-	plist_first_entry(&task->pi_waiters, struct rt_mutex_waiter, pi_list_entry)
-
-/*
- * lock->owner state tracking:
- *
- * lock->owner holds the task_struct pointer of the owner. Bit 0 and 1
- * are used to keep track of the "owner is pending" and "lock has
- * waiters" state.
- *
- * owner	bit1	bit0
- * NULL		0	0	lock is free (fast acquire possible)
- * NULL		0	1	invalid state
- * NULL		1	0	invalid state
- * NULL		1	1	invalid state
- * taskpointer	0	0	lock is held (fast release possible)
- * taskpointer	0	1	task is pending owner
- * taskpointer	1	0	lock is held and has waiters
- * taskpointer	1	1	task is pending owner and lock has more waiters
- *
- * Pending ownership is assigned to the top (highest priority)
- * waiter of the lock, when the lock is released. The thread is woken
- * up and can now take the lock. Until the lock is taken (bit 0
- * cleared) a competing higher priority thread can steal the lock
- * which puts the woken up thread back on the waiters list.
- *
- * The fast atomic compare exchange based acquire and release is only
- * possible when bit 0 and 1 of lock->owner are 0.
- */
-#define RT_MUTEX_OWNER_PENDING	1UL
-#define RT_MUTEX_HAS_WAITERS	2UL
-#define RT_MUTEX_OWNER_MASKALL	3UL
-
-#define rt_mutex_owner(lock)						\
-({									\
-	typecheck(struct rt_mutex *,(lock));				\
- 	((struct task_struct *)((unsigned long)((lock)->owner) & ~RT_MUTEX_OWNER_MASKALL)); \
-})
-
-#define rt_mutex_real_owner(lock)					\
-({									\
-	typecheck(struct rt_mutex *,(lock));				\
- 	((struct task_struct *)((unsigned long)((lock)->owner) & ~RT_MUTEX_HAS_WAITERS)); \
-})
-
-#define rt_mutex_owner_pending(lock)					\
-({									\
-	typecheck(struct rt_mutex *,(lock));				\
-	((unsigned long)((lock)->owner) & RT_MUTEX_OWNER_PENDING);	\
-})
-
-static inline void rt_mutex_set_owner(struct rt_mutex *lock, struct task_struct *owner,
-				      unsigned long msk)
-{
-	unsigned long val = ((unsigned long) owner) | msk;
-
-	if (rt_mutex_has_waiters(lock))
-		val |= RT_MUTEX_HAS_WAITERS;
-
-	lock->owner = (struct task_struct *)(val);
-}
-
-static inline void clear_rt_mutex_waiters(struct rt_mutex *lock)
-{
-	unsigned long owner;
-
-	owner = ((unsigned long) lock->owner) & ~RT_MUTEX_HAS_WAITERS;
-	lock->owner = (struct task_struct *)(owner);
-}
-
-static inline void fixup_rt_mutex_waiters(struct rt_mutex *lock)
-{
-	if (!rt_mutex_has_waiters(lock))
-		clear_rt_mutex_waiters(lock);
-}
-
-/*
- * We can speed up the acquire/release, if the architecture
- * supports cmpxchg and if there's no debugging state to be set up
- */
-#if defined(__HAVE_ARCH_CMPXCHG) && !defined(CONFIG_DEBUG_RT_MUTEXES)
-
-# define rt_mutex_cmpxchg(l,c,n)	(cmpxchg(&l->owner, c, n) == c)
-
-static inline void mark_rt_mutex_waiters(struct rt_mutex *lock)
-{
-	unsigned long owner, *p = (unsigned long *) &lock->owner;
-
-	do {
-		owner = *p;
-	} while (cmpxchg(p, owner, owner | RT_MUTEX_HAS_WAITERS) != owner);
-}
-
-#else
-
-# define rt_mutex_cmpxchg(l,c,n)	(0)
-
-static inline void mark_rt_mutex_waiters(struct rt_mutex *lock)
-{
-	unsigned long owner = ((unsigned long) lock->owner)| RT_MUTEX_HAS_WAITERS;
-
-	lock->owner = (struct task_struct *) owner;
-}
-
-#endif
-
-/*
- * PI-futex support (proxy locking functions, etc.):
- */
-extern struct task_struct *rt_mutex_next_owner(struct rt_mutex *lock);
-extern void rt_mutex_init_proxy_locked(struct rt_mutex *lock,
-				       struct task_struct *proxy_owner);
-extern void rt_mutex_proxy_unlock(struct rt_mutex *lock,
-				  struct task_struct *proxy_owner);
-#endif
Index: linux/kernel/fork.c
===================================================================
--- linux.orig/kernel/fork.c
+++ linux/kernel/fork.c
@@ -922,6 +922,17 @@ asmlinkage long sys_set_tid_address(int 
 	return current->pid;
 }
 
+static inline void rt_mutex_init_task(struct task_struct *p)
+{
+#ifdef CONFIG_RT_MUTEXES
+	spin_lock_init(&p->pi_lock);
+	plist_head_init(&p->pi_waiters);
+	p->pi_blocked_on = NULL;
+	p->pi_locked_by = NULL;
+	INIT_LIST_HEAD(&p->pi_lock_chain);
+#endif
+}
+
 /*
  * This creates a new process as a copy of the old one,
  * but does not actually start it yet.
Index: linux/kernel/futex.c
===================================================================
--- linux.orig/kernel/futex.c
+++ linux/kernel/futex.c
@@ -48,9 +48,10 @@
 #include <linux/pagemap.h>
 #include <linux/syscalls.h>
 #include <linux/signal.h>
-#include <linux/rtmutex_internal.h>
 #include <asm/futex.h>
 
+#include "rtmutex_common.h"
+
 #define FUTEX_HASHBITS (CONFIG_BASE_SMALL ? 4 : 8)
 
 /*
Index: linux/kernel/rtmutex-debug.c
===================================================================
--- linux.orig/kernel/rtmutex-debug.c
+++ linux/kernel/rtmutex-debug.c
@@ -27,7 +27,7 @@
 #include <linux/plist.h>
 #include <linux/fs.h>
 
-#include <linux/rtmutex_internal.h>
+#include "rtmutex_common.h"
 
 #ifdef CONFIG_DEBUG_RT_MUTEXES
 # include "rtmutex-debug.h"
Index: linux/kernel/rtmutex-debug.h
===================================================================
--- linux.orig/kernel/rtmutex-debug.h
+++ linux/kernel/rtmutex-debug.h
@@ -9,8 +9,6 @@
  * This file contains macros used solely by rtmutex.c. Debug version.
  */
 
-#include <linux/rtmutex_internal.h>
-
 #define __IP_DECL__		, unsigned long ip
 #define __IP__			, ip
 #define __RET_IP__		, (unsigned long)__builtin_return_address(0)
Index: linux/kernel/rtmutex.c
===================================================================
--- linux.orig/kernel/rtmutex.c
+++ linux/kernel/rtmutex.c
@@ -12,7 +12,7 @@
 #include <linux/sched.h>
 #include <linux/timer.h>
 
-#include <linux/rtmutex_internal.h>
+#include "rtmutex_common.h"
 
 #ifdef CONFIG_DEBUG_RT_MUTEXES
 # include "rtmutex-debug.h"
@@ -21,6 +21,80 @@
 #endif
 
 /*
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
+
+static void
+rt_mutex_set_owner(struct rt_mutex *lock, struct task_struct *owner,
+		   unsigned long mask)
+{
+	unsigned long val = (unsigned long)owner | mask;
+
+	if (rt_mutex_has_waiters(lock))
+		val |= RT_MUTEX_HAS_WAITERS;
+
+	lock->owner = (struct task_struct *)val;
+}
+
+static inline void clear_rt_mutex_waiters(struct rt_mutex *lock)
+{
+	lock->owner = (struct task_struct *)
+			((unsigned long)lock->owner & ~RT_MUTEX_HAS_WAITERS);
+}
+
+static void fixup_rt_mutex_waiters(struct rt_mutex *lock)
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
+# define rt_mutex_cmpxchg(l,c,n)	(cmpxchg(&l->owner, c, n) == c)
+static inline void mark_rt_mutex_waiters(struct rt_mutex *lock)
+{
+	unsigned long owner, *p = (unsigned long *) &lock->owner;
+
+	do {
+		owner = *p;
+	} while (cmpxchg(p, owner, owner | RT_MUTEX_HAS_WAITERS) != owner);
+}
+#else
+# define rt_mutex_cmpxchg(l,c,n)	(0)
+static inline void mark_rt_mutex_waiters(struct rt_mutex *lock)
+{
+	lock->owner = (struct task_struct *)
+			((unsigned long)lock->owner | RT_MUTEX_HAS_WAITERS);
+}
+#endif
+
+/*
  * Calculate task priority from the waiter list priority
  *
  * Return task->normal_prio when the waiter list is empty or when
@@ -87,6 +161,9 @@ static DEFINE_SPINLOCK(pi_conflicts_lock
  * If 'try' is set, we have to backout if we hit a owner who is
  * running its own pi chain operation. We go back and take the slow
  * path via the pi_conflicts_lock.
+ *
+ * We put all held locks into a list, via ->pi_lock_chain, and walk
+ * this list at unlock_pi_chain() time.
  */
 static int lock_pi_chain(struct rt_mutex *act_lock,
 			 struct rt_mutex_waiter *waiter,
@@ -222,10 +299,15 @@ static void adjust_pi_chain(struct rt_mu
 			plist_del(&top_waiter->pi_list_entry,
 				  &owner->pi_waiters);
 
-		if (waiter && waiter == rt_mutex_top_waiter(lock)) {
+		if (waiter)
 			waiter->pi_list_entry.prio = waiter->task->prio;
-			plist_add(&waiter->pi_list_entry, &owner->pi_waiters);
+
+		if (rt_mutex_has_waiters(lock)) {
+			top_waiter = rt_mutex_top_waiter(lock);
+			plist_add(&top_waiter->pi_list_entry,
+				  &owner->pi_waiters);
 		}
+
 		__rt_mutex_adjust_prio(owner);
 
 		waiter = owner->pi_blocked_on;
@@ -605,7 +687,7 @@ static int remove_waiter(struct rt_mutex
 /*
  * Slow path lock function:
  */
-static int fastcall noinline __sched
+static int __sched
 rt_mutex_slowlock(struct rt_mutex *lock, int state,
 		  struct hrtimer_sleeper *timeout,
 		  int detect_deadlock __IP_DECL__)
@@ -711,7 +793,7 @@ rt_mutex_slowlock(struct rt_mutex *lock,
 /*
  * Slow path try-lock function:
  */
-static inline int fastcall
+static inline int
 rt_mutex_slowtrylock(struct rt_mutex *lock __IP_DECL__)
 {
 	unsigned long flags;
@@ -739,7 +821,7 @@ rt_mutex_slowtrylock(struct rt_mutex *lo
 /*
  * Slow path to release a rt-mutex:
  */
-static void fastcall noinline __sched
+static void __sched
 rt_mutex_slowunlock(struct rt_mutex *lock)
 {
 	unsigned long flags;
@@ -773,7 +855,7 @@ rt_mutex_slowunlock(struct rt_mutex *loc
 static inline int
 rt_mutex_fastlock(struct rt_mutex *lock, int state,
 		  int detect_deadlock,
-		  int fastcall (*slowfn)(struct rt_mutex *lock, int state,
+		  int (*slowfn)(struct rt_mutex *lock, int state,
 					 struct hrtimer_sleeper *timeout,
 					 int detect_deadlock __IP_DECL__))
 {
@@ -787,7 +869,7 @@ rt_mutex_fastlock(struct rt_mutex *lock,
 static inline int
 rt_mutex_timed_fastlock(struct rt_mutex *lock, int state,
 			struct hrtimer_sleeper *timeout, int detect_deadlock,
-			int fastcall (*slowfn)(struct rt_mutex *lock, int state,
+			int (*slowfn)(struct rt_mutex *lock, int state,
 					       struct hrtimer_sleeper *timeout,
 					       int detect_deadlock __IP_DECL__))
 {
@@ -800,7 +882,7 @@ rt_mutex_timed_fastlock(struct rt_mutex 
 
 static inline int
 rt_mutex_fasttrylock(struct rt_mutex *lock,
-		     int fastcall (*slowfn)(struct rt_mutex *lock __IP_DECL__))
+		     int (*slowfn)(struct rt_mutex *lock __IP_DECL__))
 {
 	if (likely(rt_mutex_cmpxchg(lock, NULL, current))) {
 		rt_mutex_deadlock_account_lock(lock, current);
@@ -811,7 +893,7 @@ rt_mutex_fasttrylock(struct rt_mutex *lo
 
 static inline void
 rt_mutex_fastunlock(struct rt_mutex *lock,
-		    void fastcall (*slowfn)(struct rt_mutex *lock))
+		    void (*slowfn)(struct rt_mutex *lock))
 {
 	if (likely(rt_mutex_cmpxchg(lock, current, NULL)))
 		rt_mutex_deadlock_account_unlock(current);
@@ -824,7 +906,7 @@ rt_mutex_fastunlock(struct rt_mutex *loc
  *
  * @lock: the rt_mutex to be locked
  */
-void fastcall __sched rt_mutex_lock(struct rt_mutex *lock)
+void __sched rt_mutex_lock(struct rt_mutex *lock)
 {
 	might_sleep();
 
@@ -843,7 +925,7 @@ EXPORT_SYMBOL_GPL(rt_mutex_lock);
  * -EINTR 	when interrupted by a signal
  * -EDEADLK	when the lock would deadlock (when deadlock detection is on)
  */
-int fastcall __sched rt_mutex_lock_interruptible(struct rt_mutex *lock,
+int __sched rt_mutex_lock_interruptible(struct rt_mutex *lock,
 						 int detect_deadlock)
 {
 	might_sleep();
@@ -868,7 +950,7 @@ EXPORT_SYMBOL_GPL(rt_mutex_lock_interrup
  * -ETIMEOUT	when the timeout expired
  * -EDEADLK	when the lock would deadlock (when deadlock detection is on)
  */
-int fastcall
+int
 rt_mutex_timed_lock(struct rt_mutex *lock, struct hrtimer_sleeper *timeout,
 		    int detect_deadlock)
 {
@@ -887,7 +969,7 @@ EXPORT_SYMBOL_GPL(rt_mutex_timed_lock);
  *
  * Returns 1 on success and 0 on contention
  */
-int fastcall __sched rt_mutex_trylock(struct rt_mutex *lock)
+int __sched rt_mutex_trylock(struct rt_mutex *lock)
 {
 	return rt_mutex_fasttrylock(lock, rt_mutex_slowtrylock);
 }
@@ -898,7 +980,7 @@ EXPORT_SYMBOL_GPL(rt_mutex_trylock);
  *
  * @lock: the rt_mutex to be unlocked
  */
-void fastcall __sched rt_mutex_unlock(struct rt_mutex *lock)
+void __sched rt_mutex_unlock(struct rt_mutex *lock)
 {
 	rt_mutex_fastunlock(lock, rt_mutex_slowunlock);
 }
@@ -912,7 +994,7 @@ EXPORT_SYMBOL_GPL(rt_mutex_unlock);
  * use of the mutex is forbidden. The mutex must not be locked when
  * this function is called.
  */
-void fastcall rt_mutex_destroy(struct rt_mutex *lock)
+void rt_mutex_destroy(struct rt_mutex *lock)
 {
 	WARN_ON(rt_mutex_is_locked(lock));
 #ifdef CONFIG_DEBUG_RT_MUTEXES
@@ -931,7 +1013,7 @@ EXPORT_SYMBOL_GPL(rt_mutex_destroy);
  *
  * Initializing of a locked rt lock is not allowed
  */
-void fastcall __rt_mutex_init(struct rt_mutex *lock, const char *name)
+void __rt_mutex_init(struct rt_mutex *lock, const char *name)
 {
 	lock->owner = NULL;
 	spin_lock_init(&lock->wait_lock);
Index: linux/kernel/rtmutex_common.h
===================================================================
--- /dev/null
+++ linux/kernel/rtmutex_common.h
@@ -0,0 +1,123 @@
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
+#ifndef __KERNEL_RTMUTEX_COMMON_H
+#define __KERNEL_RTMUTEX_COMMON_H
+
+#include <linux/rtmutex.h>
+
+/*
+ * The rtmutex in kernel tester is independent of rtmutex debugging. We
+ * call schedule_rt_mutex_test() instead of schedule() for the tasks which
+ * belong to the tester. That way we can delay the wakeup path of those
+ * threads to provoke lock stealing and testing of  complex boosting scenarios.
+ */
+#ifdef CONFIG_RT_MUTEX_TESTER
+
+extern void schedule_rt_mutex_test(struct rt_mutex *lock);
+
+#define schedule_rt_mutex(_lock)				\
+  do {								\
+	if (!(current->flags & PF_MUTEX_TESTER))		\
+		schedule();					\
+	else							\
+		schedule_rt_mutex_test(_lock);			\
+  } while (0)
+
+#else
+# define schedule_rt_mutex(_lock)			schedule()
+#endif
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
+ * Various helpers to access the waiters-plist:
+ */
+static inline int rt_mutex_has_waiters(struct rt_mutex *lock)
+{
+	return !plist_head_empty(&lock->wait_list);
+}
+
+static inline struct rt_mutex_waiter *
+rt_mutex_top_waiter(struct rt_mutex *lock)
+{
+	struct rt_mutex_waiter *w;
+
+	w = plist_first_entry(&lock->wait_list, struct rt_mutex_waiter,
+			       list_entry);
+	BUG_ON(w->lock != lock);
+
+	return w;
+}
+
+static inline int task_has_pi_waiters(struct task_struct *p)
+{
+	return !plist_head_empty(&p->pi_waiters);
+}
+
+static inline struct rt_mutex_waiter *
+task_top_pi_waiter(struct task_struct *p)
+{
+	return plist_first_entry(&p->pi_waiters, struct rt_mutex_waiter,
+				  pi_list_entry);
+}
+
+/*
+ * lock->owner state tracking:
+ */
+#define RT_MUTEX_OWNER_PENDING	1UL
+#define RT_MUTEX_HAS_WAITERS	2UL
+#define RT_MUTEX_OWNER_MASKALL	3UL
+
+static inline struct task_struct *rt_mutex_owner(struct rt_mutex *lock)
+{
+	return (struct task_struct *)
+		((unsigned long)((lock)->owner) & ~RT_MUTEX_OWNER_MASKALL);
+}
+
+static inline struct task_struct *rt_mutex_real_owner(struct rt_mutex *lock)
+{
+ 	return (struct task_struct *)
+		((unsigned long)((lock)->owner) & ~RT_MUTEX_HAS_WAITERS);
+}
+
+static inline unsigned long rt_mutex_owner_pending(struct rt_mutex *lock)
+{
+	return ((unsigned long)((lock)->owner) & RT_MUTEX_OWNER_PENDING);
+}
+
+/*
+ * PI-futex support (proxy locking functions, etc.):
+ */
+extern struct task_struct *rt_mutex_next_owner(struct rt_mutex *lock);
+extern void rt_mutex_init_proxy_locked(struct rt_mutex *lock,
+				       struct task_struct *proxy_owner);
+extern void rt_mutex_proxy_unlock(struct rt_mutex *lock,
+				  struct task_struct *proxy_owner);
+#endif
Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c
+++ linux/kernel/sched.c
@@ -3895,7 +3895,7 @@ static void __setscheduler(struct task_s
 	p->rt_priority = prio;
 
 	p->normal_prio = normal_prio(p);
-	/* we are holding p->pi_list already */
+	/* we are holding p->pi_lock already */
 	p->prio = rt_mutex_getprio(p);
 	/*
 	 * SCHED_BATCH tasks are treated as perpetual CPU hogs:
