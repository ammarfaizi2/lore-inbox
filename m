Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751412AbWE2Vkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbWE2Vkn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbWE2Vjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:39:47 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:57554 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751343AbWE2VZJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:25:09 -0400
Date: Mon, 29 May 2006 23:25:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 28/61] lock validator: prove mutex locking correctness
Message-ID: <20060529212528.GB3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

add CONFIG_PROVE_MUTEX_LOCKING, which uses the lock validator framework
to prove mutex locking correctness.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 include/linux/mutex-debug.h |    8 +++++++-
 include/linux/mutex.h       |   34 +++++++++++++++++++++++++++++++---
 kernel/mutex-debug.c        |    8 ++++++++
 kernel/mutex-lockdep.h      |   40 ++++++++++++++++++++++++++++++++++++++++
 kernel/mutex.c              |   28 ++++++++++++++++++++++------
 kernel/mutex.h              |    3 +--
 6 files changed, 109 insertions(+), 12 deletions(-)

Index: linux/include/linux/mutex-debug.h
===================================================================
--- linux.orig/include/linux/mutex-debug.h
+++ linux/include/linux/mutex-debug.h
@@ -2,6 +2,7 @@
 #define __LINUX_MUTEX_DEBUG_H
 
 #include <linux/linkage.h>
+#include <linux/lockdep.h>
 
 /*
  * Mutexes - debugging helpers:
@@ -10,7 +11,12 @@
 #define __DEBUG_MUTEX_INITIALIZER(lockname)				\
 	, .magic = &lockname
 
-#define mutex_init(sem)		__mutex_init(sem, __FILE__":"#sem)
+#define mutex_init(mutex)						\
+do {									\
+	static struct lockdep_type_key __key;				\
+									\
+	__mutex_init((mutex), #mutex, &__key);				\
+} while (0)
 
 extern void FASTCALL(mutex_destroy(struct mutex *lock));
 
Index: linux/include/linux/mutex.h
===================================================================
--- linux.orig/include/linux/mutex.h
+++ linux/include/linux/mutex.h
@@ -13,6 +13,7 @@
 #include <linux/list.h>
 #include <linux/spinlock_types.h>
 #include <linux/linkage.h>
+#include <linux/lockdep.h>
 
 #include <asm/atomic.h>
 
@@ -53,6 +54,9 @@ struct mutex {
 	const char 		*name;
 	void			*magic;
 #endif
+#ifdef CONFIG_PROVE_MUTEX_LOCKING
+	struct lockdep_map	dep_map;
+#endif
 };
 
 /*
@@ -72,20 +76,36 @@ struct mutex_waiter {
 # include <linux/mutex-debug.h>
 #else
 # define __DEBUG_MUTEX_INITIALIZER(lockname)
-# define mutex_init(mutex)			__mutex_init(mutex, NULL)
+# define mutex_init(mutex) \
+do {							\
+	static struct lockdep_type_key __key;		\
+							\
+	__mutex_init((mutex), NULL, &__key);		\
+} while (0)
 # define mutex_destroy(mutex)				do { } while (0)
 #endif
 
+#ifdef CONFIG_PROVE_MUTEX_LOCKING
+# define __DEP_MAP_MUTEX_INITIALIZER(lockname) \
+		, .dep_map = { .name = #lockname }
+#else
+# define __DEP_MAP_MUTEX_INITIALIZER(lockname)
+#endif
+
 #define __MUTEX_INITIALIZER(lockname) \
 		{ .count = ATOMIC_INIT(1) \
 		, .wait_lock = SPIN_LOCK_UNLOCKED \
 		, .wait_list = LIST_HEAD_INIT(lockname.wait_list) \
-		__DEBUG_MUTEX_INITIALIZER(lockname) }
+		__DEBUG_MUTEX_INITIALIZER(lockname) \
+		__DEP_MAP_MUTEX_INITIALIZER(lockname) }
 
 #define DEFINE_MUTEX(mutexname) \
 	struct mutex mutexname = __MUTEX_INITIALIZER(mutexname)
 
-extern void fastcall __mutex_init(struct mutex *lock, const char *name);
+extern void __mutex_init(struct mutex *lock, const char *name,
+			 struct lockdep_type_key *key);
+
+#define mutex_init_key(mutex, name, key) __mutex_init((mutex), name, key)
 
 /***
  * mutex_is_locked - is the mutex locked
@@ -104,11 +124,19 @@ static inline int fastcall mutex_is_lock
  */
 extern void fastcall mutex_lock(struct mutex *lock);
 extern int fastcall mutex_lock_interruptible(struct mutex *lock);
+
+#ifdef CONFIG_PROVE_MUTEX_LOCKING
+extern void mutex_lock_nested(struct mutex *lock, unsigned int subtype);
+#else
+# define mutex_lock_nested(lock, subtype) mutex_lock(lock)
+#endif
+
 /*
  * NOTE: mutex_trylock() follows the spin_trylock() convention,
  *       not the down_trylock() convention!
  */
 extern int fastcall mutex_trylock(struct mutex *lock);
 extern void fastcall mutex_unlock(struct mutex *lock);
+extern void fastcall mutex_unlock_non_nested(struct mutex *lock);
 
 #endif
Index: linux/kernel/mutex-debug.c
===================================================================
--- linux.orig/kernel/mutex-debug.c
+++ linux/kernel/mutex-debug.c
@@ -100,6 +100,14 @@ static int check_deadlock(struct mutex *
 		return 0;
 
 	task = ti->task;
+	/*
+	 * In the PROVE_MUTEX_LOCKING we are tracking all held
+	 * locks already, which allows us to optimize this:
+	 */
+#ifdef CONFIG_PROVE_MUTEX_LOCKING
+	if (!task->lockdep_depth)
+		return 0;
+#endif
 	lockblk = NULL;
 	if (task->blocked_on)
 		lockblk = task->blocked_on->lock;
Index: linux/kernel/mutex-lockdep.h
===================================================================
--- /dev/null
+++ linux/kernel/mutex-lockdep.h
@@ -0,0 +1,40 @@
+/*
+ * Mutexes: blocking mutual exclusion locks
+ *
+ * started by Ingo Molnar:
+ *
+ *  Copyright (C) 2004-2006 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
+ *
+ * This file contains mutex debugging related internal prototypes, for the
+ * !CONFIG_DEBUG_MUTEXES && CONFIG_PROVE_MUTEX_LOCKING case. Most of
+ * them are NOPs:
+ */
+
+#define spin_lock_mutex(lock, flags)			\
+	do {						\
+		local_irq_save(flags);			\
+		__raw_spin_lock(&(lock)->raw_lock);	\
+	} while (0)
+
+#define spin_unlock_mutex(lock, flags)			\
+	do {						\
+		__raw_spin_unlock(&(lock)->raw_lock);	\
+		local_irq_restore(flags);		\
+	} while (0)
+
+#define mutex_remove_waiter(lock, waiter, ti) \
+		__list_del((waiter)->list.prev, (waiter)->list.next)
+
+#define debug_mutex_set_owner(lock, new_owner)		do { } while (0)
+#define debug_mutex_clear_owner(lock)			do { } while (0)
+#define debug_mutex_wake_waiter(lock, waiter)		do { } while (0)
+#define debug_mutex_free_waiter(waiter)			do { } while (0)
+#define debug_mutex_add_waiter(lock, waiter, ti)	do { } while (0)
+#define debug_mutex_unlock(lock)			do { } while (0)
+#define debug_mutex_init(lock, name)			do { } while (0)
+
+static inline void
+debug_mutex_lock_common(struct mutex *lock,
+			struct mutex_waiter *waiter)
+{
+}
Index: linux/kernel/mutex.c
===================================================================
--- linux.orig/kernel/mutex.c
+++ linux/kernel/mutex.c
@@ -27,8 +27,13 @@
 # include "mutex-debug.h"
 # include <asm-generic/mutex-null.h>
 #else
-# include "mutex.h"
-# include <asm/mutex.h>
+# ifdef CONFIG_PROVE_MUTEX_LOCKING
+#  include "mutex-lockdep.h"
+#  include <asm-generic/mutex-null.h>
+# else
+#  include "mutex.h"
+#  include <asm/mutex.h>
+# endif
 #endif
 
 /***
@@ -39,13 +44,18 @@
  *
  * It is not allowed to initialize an already locked mutex.
  */
-__always_inline void fastcall __mutex_init(struct mutex *lock, const char *name)
+void
+__mutex_init(struct mutex *lock, const char *name, struct lockdep_type_key *key)
 {
 	atomic_set(&lock->count, 1);
 	spin_lock_init(&lock->wait_lock);
 	INIT_LIST_HEAD(&lock->wait_list);
 
 	debug_mutex_init(lock, name);
+
+#ifdef CONFIG_PROVE_MUTEX_LOCKING
+	lockdep_init_map(&lock->dep_map, name, key);
+#endif
 }
 
 EXPORT_SYMBOL(__mutex_init);
@@ -146,6 +156,7 @@ __mutex_lock_common(struct mutex *lock, 
 	spin_lock_mutex(&lock->wait_lock, flags);
 
 	debug_mutex_lock_common(lock, &waiter);
+	mutex_acquire(&lock->dep_map, subtype, 0, _RET_IP_);
 	debug_mutex_add_waiter(lock, &waiter, task->thread_info);
 
 	/* add waiting tasks to the end of the waitqueue (FIFO): */
@@ -173,6 +184,7 @@ __mutex_lock_common(struct mutex *lock, 
 		if (unlikely(state == TASK_INTERRUPTIBLE &&
 						signal_pending(task))) {
 			mutex_remove_waiter(lock, &waiter, task->thread_info);
+			mutex_release(&lock->dep_map, 1, _RET_IP_);
 			spin_unlock_mutex(&lock->wait_lock, flags);
 
 			debug_mutex_free_waiter(&waiter);
@@ -198,7 +210,9 @@ __mutex_lock_common(struct mutex *lock, 
 
 	debug_mutex_free_waiter(&waiter);
 
+#ifdef CONFIG_DEBUG_MUTEXES
 	DEBUG_WARN_ON(lock->owner != task->thread_info);
+#endif
 
 	return 0;
 }
@@ -211,7 +225,7 @@ __mutex_lock_slowpath(atomic_t *lock_cou
 	__mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, 0);
 }
 
-#ifdef CONFIG_DEBUG_MUTEXES
+#ifdef CONFIG_PROVE_MUTEX_LOCKING
 void __sched
 mutex_lock_nested(struct mutex *lock, unsigned int subtype)
 {
@@ -232,6 +246,7 @@ __mutex_unlock_common_slowpath(atomic_t 
 	unsigned long flags;
 
 	spin_lock_mutex(&lock->wait_lock, flags);
+	mutex_release(&lock->dep_map, nested, _RET_IP_);
 	debug_mutex_unlock(lock);
 
 	/*
@@ -322,9 +337,10 @@ static inline int __mutex_trylock_slowpa
 	spin_lock_mutex(&lock->wait_lock, flags);
 
 	prev = atomic_xchg(&lock->count, -1);
-	if (likely(prev == 1))
+	if (likely(prev == 1)) {
 		debug_mutex_set_owner(lock, current_thread_info());
-
+		mutex_acquire(&lock->dep_map, 0, 1, _RET_IP_);
+	}
 	/* Set it back to 0 if there are no waiters: */
 	if (likely(list_empty(&lock->wait_list)))
 		atomic_set(&lock->count, 0);
Index: linux/kernel/mutex.h
===================================================================
--- linux.orig/kernel/mutex.h
+++ linux/kernel/mutex.h
@@ -16,14 +16,13 @@
 #define mutex_remove_waiter(lock, waiter, ti) \
 		__list_del((waiter)->list.prev, (waiter)->list.next)
 
+#undef DEBUG_WARN_ON
 #define DEBUG_WARN_ON(c)				do { } while (0)
 #define debug_mutex_set_owner(lock, new_owner)		do { } while (0)
 #define debug_mutex_clear_owner(lock)			do { } while (0)
 #define debug_mutex_wake_waiter(lock, waiter)		do { } while (0)
 #define debug_mutex_free_waiter(waiter)			do { } while (0)
 #define debug_mutex_add_waiter(lock, waiter, ti)	do { } while (0)
-#define mutex_acquire(lock, subtype, trylock)	do { } while (0)
-#define mutex_release(lock, nested)		do { } while (0)
 #define debug_mutex_unlock(lock)			do { } while (0)
 #define debug_mutex_init(lock, name)			do { } while (0)
 
