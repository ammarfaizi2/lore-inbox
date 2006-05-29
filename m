Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751350AbWE2VmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbWE2VmM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbWE2VmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:42:00 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:43960 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751347AbWE2VZH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:25:07 -0400
Date: Mon, 29 May 2006 23:25:23 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 27/61] lock validator: prove spinlock/rwlock locking correctness
Message-ID: <20060529212523.GA3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
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

add CONFIG_PROVE_SPIN_LOCKING and CONFIG_PROVE_RW_LOCKING, which uses
the lock validator framework to prove spinlock and rwlock locking
correctness.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 include/asm-i386/spinlock.h       |    2 
 include/linux/spinlock.h          |   96 ++++++++++++++++++++++-----
 include/linux/spinlock_api_smp.h  |    4 +
 include/linux/spinlock_api_up.h   |    3 
 include/linux/spinlock_types.h    |   32 ++++++++-
 include/linux/spinlock_types_up.h |   10 ++
 include/linux/spinlock_up.h       |    4 -
 kernel/Makefile                   |    2 
 kernel/sched.c                    |   10 ++
 kernel/spinlock.c                 |  131 +++++++++++++++++++++++++++++++++++---
 lib/kernel_lock.c                 |    7 +-
 net/ipv4/route.c                  |    4 -
 12 files changed, 269 insertions(+), 36 deletions(-)

Index: linux/include/asm-i386/spinlock.h
===================================================================
--- linux.orig/include/asm-i386/spinlock.h
+++ linux/include/asm-i386/spinlock.h
@@ -68,6 +68,7 @@ static inline void __raw_spin_lock(raw_s
 		"=m" (lock->slock) : : "memory");
 }
 
+#ifndef CONFIG_PROVE_SPIN_LOCKING
 static inline void __raw_spin_lock_flags(raw_spinlock_t *lock, unsigned long flags)
 {
 	alternative_smp(
@@ -75,6 +76,7 @@ static inline void __raw_spin_lock_flags
 		__raw_spin_lock_string_up,
 		"=m" (lock->slock) : "r" (flags) : "memory");
 }
+#endif
 
 static inline int __raw_spin_trylock(raw_spinlock_t *lock)
 {
Index: linux/include/linux/spinlock.h
===================================================================
--- linux.orig/include/linux/spinlock.h
+++ linux/include/linux/spinlock.h
@@ -82,14 +82,64 @@ extern int __lockfunc generic__raw_read_
 /*
  * Pull the __raw*() functions/declarations (UP-nondebug doesnt need them):
  */
-#if defined(CONFIG_SMP)
+#ifdef CONFIG_SMP
 # include <asm/spinlock.h>
 #else
 # include <linux/spinlock_up.h>
 #endif
 
-#define spin_lock_init(lock)	do { *(lock) = SPIN_LOCK_UNLOCKED; } while (0)
-#define rwlock_init(lock)	do { *(lock) = RW_LOCK_UNLOCKED; } while (0)
+#if defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PROVE_SPIN_LOCKING)
+  extern void __spin_lock_init(spinlock_t *lock, const char *name,
+			       struct lockdep_type_key *key);
+# define spin_lock_init(lock)					\
+do {								\
+	static struct lockdep_type_key __key;			\
+								\
+	__spin_lock_init((lock), #lock, &__key);		\
+} while (0)
+
+/*
+ * If for example an array of static locks are initialized
+ * via spin_lock_init(), this API variant can be used to
+ * split the lock-types of them:
+ */
+# define spin_lock_init_static(lock)				\
+	__spin_lock_init((lock), #lock,				\
+			 (struct lockdep_type_key *)(lock))	\
+
+/*
+ * Type splitting can also be done for dynamic locks, if for
+ * example there are per-CPU dynamically allocated locks:
+ */
+# define spin_lock_init_key(lock, key)				\
+	__spin_lock_init((lock), #lock, key)
+
+#else
+# define spin_lock_init(lock)					\
+	do { *(lock) = SPIN_LOCK_UNLOCKED; } while (0)
+# define spin_lock_init_static(lock) 				\
+	spin_lock_init(lock)
+# define spin_lock_init_key(lock, key)				\
+	do { spin_lock_init(lock); (void)(key); } while (0)
+#endif
+
+#if defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PROVE_RW_LOCKING)
+  extern void __rwlock_init(rwlock_t *lock, const char *name,
+			    struct lockdep_type_key *key);
+# define rwlock_init(lock)					\
+do {								\
+	static struct lockdep_type_key __key;			\
+								\
+	__rwlock_init((lock), #lock, &__key);			\
+} while (0)
+# define rwlock_init_key(lock, key)				\
+	__rwlock_init((lock), #lock, key)
+#else
+# define rwlock_init(lock)					\
+	do { *(lock) = RW_LOCK_UNLOCKED; } while (0)
+# define rwlock_init_key(lock, key)				\
+	do { rwlock_init(lock); (void)(key); } while (0)
+#endif
 
 #define spin_is_locked(lock)	__raw_spin_is_locked(&(lock)->raw_lock)
 
@@ -102,7 +152,9 @@ extern int __lockfunc generic__raw_read_
 /*
  * Pull the _spin_*()/_read_*()/_write_*() functions/declarations:
  */
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK) || \
+	defined(CONFIG_PROVE_SPIN_LOCKING) || \
+	defined(CONFIG_PROVE_RW_LOCKING)
 # include <linux/spinlock_api_smp.h>
 #else
 # include <linux/spinlock_api_up.h>
@@ -113,7 +165,6 @@ extern int __lockfunc generic__raw_read_
 #define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
  extern int _raw_spin_trylock(spinlock_t *lock);
  extern void _raw_spin_unlock(spinlock_t *lock);
-
  extern void _raw_read_lock(rwlock_t *lock);
  extern int _raw_read_trylock(rwlock_t *lock);
  extern void _raw_read_unlock(rwlock_t *lock);
@@ -121,17 +172,17 @@ extern int __lockfunc generic__raw_read_
  extern int _raw_write_trylock(rwlock_t *lock);
  extern void _raw_write_unlock(rwlock_t *lock);
 #else
-# define _raw_spin_unlock(lock)		__raw_spin_unlock(&(lock)->raw_lock)
-# define _raw_spin_trylock(lock)	__raw_spin_trylock(&(lock)->raw_lock)
 # define _raw_spin_lock(lock)		__raw_spin_lock(&(lock)->raw_lock)
 # define _raw_spin_lock_flags(lock, flags) \
 		__raw_spin_lock_flags(&(lock)->raw_lock, *(flags))
+# define _raw_spin_trylock(lock)	__raw_spin_trylock(&(lock)->raw_lock)
+# define _raw_spin_unlock(lock)		__raw_spin_unlock(&(lock)->raw_lock)
 # define _raw_read_lock(rwlock)		__raw_read_lock(&(rwlock)->raw_lock)
-# define _raw_write_lock(rwlock)	__raw_write_lock(&(rwlock)->raw_lock)
-# define _raw_read_unlock(rwlock)	__raw_read_unlock(&(rwlock)->raw_lock)
-# define _raw_write_unlock(rwlock)	__raw_write_unlock(&(rwlock)->raw_lock)
 # define _raw_read_trylock(rwlock)	__raw_read_trylock(&(rwlock)->raw_lock)
+# define _raw_read_unlock(rwlock)	__raw_read_unlock(&(rwlock)->raw_lock)
+# define _raw_write_lock(rwlock)	__raw_write_lock(&(rwlock)->raw_lock)
 # define _raw_write_trylock(rwlock)	__raw_write_trylock(&(rwlock)->raw_lock)
+# define _raw_write_unlock(rwlock)	__raw_write_unlock(&(rwlock)->raw_lock)
 #endif
 
 #define read_can_lock(rwlock)		__raw_read_can_lock(&(rwlock)->raw_lock)
@@ -147,10 +198,14 @@ extern int __lockfunc generic__raw_read_
 #define write_trylock(lock)		__cond_lock(_write_trylock(lock))
 
 #define spin_lock(lock)			_spin_lock(lock)
+#define spin_lock_nested(lock, subtype) \
+					_spin_lock_nested(lock, subtype)
 #define write_lock(lock)		_write_lock(lock)
 #define read_lock(lock)			_read_lock(lock)
 
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK) || \
+	defined(CONFIG_PROVE_SPIN_LOCKING) || \
+	defined(CONFIG_PROVE_RW_LOCKING)
 #define spin_lock_irqsave(lock, flags)	flags = _spin_lock_irqsave(lock)
 #define read_lock_irqsave(lock, flags)	flags = _read_lock_irqsave(lock)
 #define write_lock_irqsave(lock, flags)	flags = _write_lock_irqsave(lock)
@@ -172,21 +227,24 @@ extern int __lockfunc generic__raw_read_
 /*
  * We inline the unlock functions in the nondebug case:
  */
-#if defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PREEMPT) || !defined(CONFIG_SMP)
+#if defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PREEMPT) || \
+	!defined(CONFIG_SMP) || \
+	defined(CONFIG_PROVE_SPIN_LOCKING) || \
+	defined(CONFIG_PROVE_RW_LOCKING)
 # define spin_unlock(lock)		_spin_unlock(lock)
+# define spin_unlock_non_nested(lock)	_spin_unlock_non_nested(lock)
 # define read_unlock(lock)		_read_unlock(lock)
+# define read_unlock_non_nested(lock)	_read_unlock_non_nested(lock)
 # define write_unlock(lock)		_write_unlock(lock)
-#else
-# define spin_unlock(lock)		__raw_spin_unlock(&(lock)->raw_lock)
-# define read_unlock(lock)		__raw_read_unlock(&(lock)->raw_lock)
-# define write_unlock(lock)		__raw_write_unlock(&(lock)->raw_lock)
-#endif
-
-#if defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PREEMPT) || !defined(CONFIG_SMP)
 # define spin_unlock_irq(lock)		_spin_unlock_irq(lock)
 # define read_unlock_irq(lock)		_read_unlock_irq(lock)
 # define write_unlock_irq(lock)		_write_unlock_irq(lock)
 #else
+# define spin_unlock(lock)		__raw_spin_unlock(&(lock)->raw_lock)
+# define spin_unlock_non_nested(lock)	__raw_spin_unlock(&(lock)->raw_lock)
+# define read_unlock(lock)		__raw_read_unlock(&(lock)->raw_lock)
+# define read_unlock_non_nested(lock)	__raw_read_unlock(&(lock)->raw_lock)
+# define write_unlock(lock)		__raw_write_unlock(&(lock)->raw_lock)
 # define spin_unlock_irq(lock) \
     do { __raw_spin_unlock(&(lock)->raw_lock); local_irq_enable(); } while (0)
 # define read_unlock_irq(lock) \
Index: linux/include/linux/spinlock_api_smp.h
===================================================================
--- linux.orig/include/linux/spinlock_api_smp.h
+++ linux/include/linux/spinlock_api_smp.h
@@ -20,6 +20,8 @@ int in_lock_functions(unsigned long addr
 #define assert_spin_locked(x)	BUG_ON(!spin_is_locked(x))
 
 void __lockfunc _spin_lock(spinlock_t *lock)		__acquires(spinlock_t);
+void __lockfunc _spin_lock_nested(spinlock_t *lock, int subtype)
+							__acquires(spinlock_t);
 void __lockfunc _read_lock(rwlock_t *lock)		__acquires(rwlock_t);
 void __lockfunc _write_lock(rwlock_t *lock)		__acquires(rwlock_t);
 void __lockfunc _spin_lock_bh(spinlock_t *lock)		__acquires(spinlock_t);
@@ -39,7 +41,9 @@ int __lockfunc _read_trylock(rwlock_t *l
 int __lockfunc _write_trylock(rwlock_t *lock);
 int __lockfunc _spin_trylock_bh(spinlock_t *lock);
 void __lockfunc _spin_unlock(spinlock_t *lock)		__releases(spinlock_t);
+void __lockfunc _spin_unlock_non_nested(spinlock_t *lock) __releases(spinlock_t);
 void __lockfunc _read_unlock(rwlock_t *lock)		__releases(rwlock_t);
+void __lockfunc _read_unlock_non_nested(rwlock_t *lock)	__releases(rwlock_t);
 void __lockfunc _write_unlock(rwlock_t *lock)		__releases(rwlock_t);
 void __lockfunc _spin_unlock_bh(spinlock_t *lock)	__releases(spinlock_t);
 void __lockfunc _read_unlock_bh(rwlock_t *lock)		__releases(rwlock_t);
Index: linux/include/linux/spinlock_api_up.h
===================================================================
--- linux.orig/include/linux/spinlock_api_up.h
+++ linux/include/linux/spinlock_api_up.h
@@ -49,6 +49,7 @@
   do { local_irq_restore(flags); __UNLOCK(lock); } while (0)
 
 #define _spin_lock(lock)			__LOCK(lock)
+#define _spin_lock_nested(lock, subtype)	__LOCK(lock)
 #define _read_lock(lock)			__LOCK(lock)
 #define _write_lock(lock)			__LOCK(lock)
 #define _spin_lock_bh(lock)			__LOCK_BH(lock)
@@ -65,7 +66,9 @@
 #define _write_trylock(lock)			({ __LOCK(lock); 1; })
 #define _spin_trylock_bh(lock)			({ __LOCK_BH(lock); 1; })
 #define _spin_unlock(lock)			__UNLOCK(lock)
+#define _spin_unlock_non_nested(lock)		__UNLOCK(lock)
 #define _read_unlock(lock)			__UNLOCK(lock)
+#define _read_unlock_non_nested(lock)		__UNLOCK(lock)
 #define _write_unlock(lock)			__UNLOCK(lock)
 #define _spin_unlock_bh(lock)			__UNLOCK_BH(lock)
 #define _write_unlock_bh(lock)			__UNLOCK_BH(lock)
Index: linux/include/linux/spinlock_types.h
===================================================================
--- linux.orig/include/linux/spinlock_types.h
+++ linux/include/linux/spinlock_types.h
@@ -9,6 +9,8 @@
  * Released under the General Public License (GPL).
  */
 
+#include <linux/lockdep.h>
+
 #if defined(CONFIG_SMP)
 # include <asm/spinlock_types.h>
 #else
@@ -24,6 +26,9 @@ typedef struct {
 	unsigned int magic, owner_cpu;
 	void *owner;
 #endif
+#ifdef CONFIG_PROVE_SPIN_LOCKING
+	struct lockdep_map dep_map;
+#endif
 } spinlock_t;
 
 #define SPINLOCK_MAGIC		0xdead4ead
@@ -37,28 +42,47 @@ typedef struct {
 	unsigned int magic, owner_cpu;
 	void *owner;
 #endif
+#ifdef CONFIG_PROVE_RW_LOCKING
+	struct lockdep_map dep_map;
+#endif
 } rwlock_t;
 
 #define RWLOCK_MAGIC		0xdeaf1eed
 
 #define SPINLOCK_OWNER_INIT	((void *)-1L)
 
+#ifdef CONFIG_PROVE_SPIN_LOCKING
+# define SPIN_DEP_MAP_INIT(lockname)	.dep_map = { .name = #lockname }
+#else
+# define SPIN_DEP_MAP_INIT(lockname)
+#endif
+
+#ifdef CONFIG_PROVE_RW_LOCKING
+# define RW_DEP_MAP_INIT(lockname)	.dep_map = { .name = #lockname }
+#else
+# define RW_DEP_MAP_INIT(lockname)
+#endif
+
 #ifdef CONFIG_DEBUG_SPINLOCK
 # define __SPIN_LOCK_UNLOCKED(lockname)					\
 	(spinlock_t)	{	.raw_lock = __RAW_SPIN_LOCK_UNLOCKED,	\
 				.magic = SPINLOCK_MAGIC,		\
 				.owner = SPINLOCK_OWNER_INIT,		\
-				.owner_cpu = -1 }
+				.owner_cpu = -1,			\
+				SPIN_DEP_MAP_INIT(lockname) }
 #define __RW_LOCK_UNLOCKED(lockname)					\
 	(rwlock_t)	{	.raw_lock = __RAW_RW_LOCK_UNLOCKED,	\
 				.magic = RWLOCK_MAGIC,			\
 				.owner = SPINLOCK_OWNER_INIT,		\
-				.owner_cpu = -1 }
+				.owner_cpu = -1,			\
+				RW_DEP_MAP_INIT(lockname) }
 #else
 # define __SPIN_LOCK_UNLOCKED(lockname) \
-	(spinlock_t)	{	.raw_lock = __RAW_SPIN_LOCK_UNLOCKED }
+	(spinlock_t)	{	.raw_lock = __RAW_SPIN_LOCK_UNLOCKED,	\
+				SPIN_DEP_MAP_INIT(lockname) }
 #define __RW_LOCK_UNLOCKED(lockname) \
-	(rwlock_t)	{	.raw_lock = __RAW_RW_LOCK_UNLOCKED }
+	(rwlock_t)	{	.raw_lock = __RAW_RW_LOCK_UNLOCKED,	\
+				RW_DEP_MAP_INIT(lockname) }
 #endif
 
 #define SPIN_LOCK_UNLOCKED	__SPIN_LOCK_UNLOCKED(old_style_spin_init)
Index: linux/include/linux/spinlock_types_up.h
===================================================================
--- linux.orig/include/linux/spinlock_types_up.h
+++ linux/include/linux/spinlock_types_up.h
@@ -12,10 +12,15 @@
  * Released under the General Public License (GPL).
  */
 
-#ifdef CONFIG_DEBUG_SPINLOCK
+#if defined(CONFIG_DEBUG_SPINLOCK) || \
+	defined(CONFIG_PROVE_SPIN_LOCKING) || \
+	defined(CONFIG_PROVE_RW_LOCKING)
 
 typedef struct {
 	volatile unsigned int slock;
+#ifdef CONFIG_PROVE_SPIN_LOCKING
+	struct lockdep_map dep_map;
+#endif
 } raw_spinlock_t;
 
 #define __RAW_SPIN_LOCK_UNLOCKED { 1 }
@@ -30,6 +35,9 @@ typedef struct { } raw_spinlock_t;
 
 typedef struct {
 	/* no debug version on UP */
+#ifdef CONFIG_PROVE_RW_LOCKING
+	struct lockdep_map dep_map;
+#endif
 } raw_rwlock_t;
 
 #define __RAW_RW_LOCK_UNLOCKED { }
Index: linux/include/linux/spinlock_up.h
===================================================================
--- linux.orig/include/linux/spinlock_up.h
+++ linux/include/linux/spinlock_up.h
@@ -17,7 +17,9 @@
  * No atomicity anywhere, we are on UP.
  */
 
-#ifdef CONFIG_DEBUG_SPINLOCK
+#if defined(CONFIG_DEBUG_SPINLOCK) || \
+	defined(CONFIG_PROVE_SPIN_LOCKING) || \
+	defined(CONFIG_PROVE_RW_LOCKING)
 
 #define __raw_spin_is_locked(x)		((x)->slock == 0)
 
Index: linux/kernel/Makefile
===================================================================
--- linux.orig/kernel/Makefile
+++ linux/kernel/Makefile
@@ -26,6 +26,8 @@ obj-$(CONFIG_RT_MUTEX_TESTER) += rtmutex
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += cpu.o spinlock.o
 obj-$(CONFIG_DEBUG_SPINLOCK) += spinlock.o
+obj-$(CONFIG_PROVE_SPIN_LOCKING) += spinlock.o
+obj-$(CONFIG_PROVE_RW_LOCKING) += spinlock.o
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += module.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o
Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c
+++ linux/kernel/sched.c
@@ -312,6 +312,13 @@ static inline void finish_lock_switch(ru
 	/* this is a valid case when another task releases the spinlock */
 	rq->lock.owner = current;
 #endif
+	/*
+	 * If we are tracking spinlock dependencies then we have to
+	 * fix up the runqueue lock - which gets 'carried over' from
+	 * prev into current:
+	 */
+	spin_acquire(&rq->lock.dep_map, 0, 0, _THIS_IP_);
+
 	spin_unlock_irq(&rq->lock);
 }
 
@@ -1839,6 +1846,7 @@ task_t * context_switch(runqueue_t *rq, 
 		WARN_ON(rq->prev_mm);
 		rq->prev_mm = oldmm;
 	}
+	spin_release(&rq->lock.dep_map, 1, _THIS_IP_);
 
 	/* Here we just switch the register state and the stack. */
 	switch_to(prev, next, prev);
@@ -4406,6 +4414,7 @@ asmlinkage long sys_sched_yield(void)
 	 * no need to preempt or enable interrupts:
 	 */
 	__release(rq->lock);
+	spin_release(&rq->lock.dep_map, 1, _THIS_IP_);
 	_raw_spin_unlock(&rq->lock);
 	preempt_enable_no_resched();
 
@@ -4465,6 +4474,7 @@ int cond_resched_lock(spinlock_t *lock)
 		spin_lock(lock);
 	}
 	if (need_resched()) {
+		spin_release(&lock->dep_map, 1, _THIS_IP_);
 		_raw_spin_unlock(lock);
 		preempt_enable_no_resched();
 		__cond_resched();
Index: linux/kernel/spinlock.c
===================================================================
--- linux.orig/kernel/spinlock.c
+++ linux/kernel/spinlock.c
@@ -14,8 +14,47 @@
 #include <linux/preempt.h>
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
+#include <linux/debug_locks.h>
 #include <linux/module.h>
 
+#if defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PROVE_SPIN_LOCKING)
+void __spin_lock_init(spinlock_t *lock, const char *name,
+		      struct lockdep_type_key *key)
+{
+	lock->raw_lock = (raw_spinlock_t)__RAW_SPIN_LOCK_UNLOCKED;
+#ifdef CONFIG_DEBUG_SPINLOCK
+	lock->magic = SPINLOCK_MAGIC;
+	lock->owner = SPINLOCK_OWNER_INIT;
+	lock->owner_cpu = -1;
+#endif
+#ifdef CONFIG_PROVE_SPIN_LOCKING
+	lockdep_init_map(&lock->dep_map, name, key);
+#endif
+}
+
+EXPORT_SYMBOL(__spin_lock_init);
+
+#endif
+
+#if defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PROVE_RW_LOCKING)
+
+void __rwlock_init(rwlock_t *lock, const char *name,
+		   struct lockdep_type_key *key)
+{
+	lock->raw_lock = (raw_rwlock_t) __RAW_RW_LOCK_UNLOCKED;
+#ifdef CONFIG_DEBUG_SPINLOCK
+	lock->magic = RWLOCK_MAGIC;
+	lock->owner = SPINLOCK_OWNER_INIT;
+	lock->owner_cpu = -1;
+#endif
+#ifdef CONFIG_PROVE_RW_LOCKING
+	lockdep_init_map(&lock->dep_map, name, key);
+#endif
+}
+
+EXPORT_SYMBOL(__rwlock_init);
+
+#endif
 /*
  * Generic declaration of the raw read_trylock() function,
  * architectures are supposed to optimize this:
@@ -30,8 +69,10 @@ EXPORT_SYMBOL(generic__raw_read_trylock)
 int __lockfunc _spin_trylock(spinlock_t *lock)
 {
 	preempt_disable();
-	if (_raw_spin_trylock(lock))
+	if (_raw_spin_trylock(lock)) {
+		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
 		return 1;
+	}
 	
 	preempt_enable();
 	return 0;
@@ -41,8 +82,10 @@ EXPORT_SYMBOL(_spin_trylock);
 int __lockfunc _read_trylock(rwlock_t *lock)
 {
 	preempt_disable();
-	if (_raw_read_trylock(lock))
+	if (_raw_read_trylock(lock)) {
+		rwlock_acquire_read(&lock->dep_map, 0, 1, _RET_IP_);
 		return 1;
+	}
 
 	preempt_enable();
 	return 0;
@@ -52,19 +95,29 @@ EXPORT_SYMBOL(_read_trylock);
 int __lockfunc _write_trylock(rwlock_t *lock)
 {
 	preempt_disable();
-	if (_raw_write_trylock(lock))
+	if (_raw_write_trylock(lock)) {
+		rwlock_acquire(&lock->dep_map, 0, 1, _RET_IP_);
 		return 1;
+	}
 
 	preempt_enable();
 	return 0;
 }
 EXPORT_SYMBOL(_write_trylock);
 
-#if !defined(CONFIG_PREEMPT) || !defined(CONFIG_SMP)
+/*
+ * If lockdep is enabled then we use the non-preemption spin-ops
+ * even on CONFIG_PREEMPT, because lockdep assumes that interrupts are
+ * not re-enabled during lock-acquire (which the preempt-spin-ops do):
+ */
+#if !defined(CONFIG_PREEMPT) || !defined(CONFIG_SMP) || \
+	defined(CONFIG_PROVE_SPIN_LOCKING) || \
+	defined(CONFIG_PROVE_RW_LOCKING)
 
 void __lockfunc _read_lock(rwlock_t *lock)
 {
 	preempt_disable();
+	rwlock_acquire_read(&lock->dep_map, 0, 0, _RET_IP_);
 	_raw_read_lock(lock);
 }
 EXPORT_SYMBOL(_read_lock);
@@ -75,7 +128,17 @@ unsigned long __lockfunc _spin_lock_irqs
 
 	local_irq_save(flags);
 	preempt_disable();
+	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
+	/*
+	 * On lockdep we dont want the hand-coded irq-enable of
+	 * _raw_spin_lock_flags() code, because lockdep assumes
+	 * that interrupts are not re-enabled during lock-acquire:
+	 */
+#ifdef CONFIG_PROVE_SPIN_LOCKING
+	_raw_spin_lock(lock);
+#else
 	_raw_spin_lock_flags(lock, &flags);
+#endif
 	return flags;
 }
 EXPORT_SYMBOL(_spin_lock_irqsave);
@@ -84,6 +147,7 @@ void __lockfunc _spin_lock_irq(spinlock_
 {
 	local_irq_disable();
 	preempt_disable();
+	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
 	_raw_spin_lock(lock);
 }
 EXPORT_SYMBOL(_spin_lock_irq);
@@ -92,6 +156,7 @@ void __lockfunc _spin_lock_bh(spinlock_t
 {
 	local_bh_disable();
 	preempt_disable();
+	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
 	_raw_spin_lock(lock);
 }
 EXPORT_SYMBOL(_spin_lock_bh);
@@ -102,6 +167,7 @@ unsigned long __lockfunc _read_lock_irqs
 
 	local_irq_save(flags);
 	preempt_disable();
+	rwlock_acquire_read(&lock->dep_map, 0, 0, _RET_IP_);
 	_raw_read_lock(lock);
 	return flags;
 }
@@ -111,6 +177,7 @@ void __lockfunc _read_lock_irq(rwlock_t 
 {
 	local_irq_disable();
 	preempt_disable();
+	rwlock_acquire_read(&lock->dep_map, 0, 0, _RET_IP_);
 	_raw_read_lock(lock);
 }
 EXPORT_SYMBOL(_read_lock_irq);
@@ -119,6 +186,7 @@ void __lockfunc _read_lock_bh(rwlock_t *
 {
 	local_bh_disable();
 	preempt_disable();
+	rwlock_acquire_read(&lock->dep_map, 0, 0, _RET_IP_);
 	_raw_read_lock(lock);
 }
 EXPORT_SYMBOL(_read_lock_bh);
@@ -129,6 +197,7 @@ unsigned long __lockfunc _write_lock_irq
 
 	local_irq_save(flags);
 	preempt_disable();
+	rwlock_acquire(&lock->dep_map, 0, 0, _RET_IP_);
 	_raw_write_lock(lock);
 	return flags;
 }
@@ -138,6 +207,7 @@ void __lockfunc _write_lock_irq(rwlock_t
 {
 	local_irq_disable();
 	preempt_disable();
+	rwlock_acquire(&lock->dep_map, 0, 0, _RET_IP_);
 	_raw_write_lock(lock);
 }
 EXPORT_SYMBOL(_write_lock_irq);
@@ -146,6 +216,7 @@ void __lockfunc _write_lock_bh(rwlock_t 
 {
 	local_bh_disable();
 	preempt_disable();
+	rwlock_acquire(&lock->dep_map, 0, 0, _RET_IP_);
 	_raw_write_lock(lock);
 }
 EXPORT_SYMBOL(_write_lock_bh);
@@ -153,6 +224,7 @@ EXPORT_SYMBOL(_write_lock_bh);
 void __lockfunc _spin_lock(spinlock_t *lock)
 {
 	preempt_disable();
+	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
 	_raw_spin_lock(lock);
 }
 
@@ -161,6 +233,7 @@ EXPORT_SYMBOL(_spin_lock);
 void __lockfunc _write_lock(rwlock_t *lock)
 {
 	preempt_disable();
+	rwlock_acquire(&lock->dep_map, 0, 0, _RET_IP_);
 	_raw_write_lock(lock);
 }
 
@@ -256,15 +329,35 @@ BUILD_LOCK_OPS(write, rwlock);
 
 #endif /* CONFIG_PREEMPT */
 
+void __lockfunc _spin_lock_nested(spinlock_t *lock, int subtype)
+{
+	preempt_disable();
+	spin_acquire(&lock->dep_map, subtype, 0, _RET_IP_);
+	_raw_spin_lock(lock);
+}
+
+EXPORT_SYMBOL(_spin_lock_nested);
+
 void __lockfunc _spin_unlock(spinlock_t *lock)
 {
+	spin_release(&lock->dep_map, 1, _RET_IP_);
 	_raw_spin_unlock(lock);
 	preempt_enable();
 }
 EXPORT_SYMBOL(_spin_unlock);
 
+void __lockfunc _spin_unlock_non_nested(spinlock_t *lock)
+{
+	spin_release(&lock->dep_map, 0, _RET_IP_);
+	_raw_spin_unlock(lock);
+	preempt_enable();
+}
+EXPORT_SYMBOL(_spin_unlock_non_nested);
+
+
 void __lockfunc _write_unlock(rwlock_t *lock)
 {
+	rwlock_release(&lock->dep_map, 1, _RET_IP_);
 	_raw_write_unlock(lock);
 	preempt_enable();
 }
@@ -272,13 +365,23 @@ EXPORT_SYMBOL(_write_unlock);
 
 void __lockfunc _read_unlock(rwlock_t *lock)
 {
+	rwlock_release(&lock->dep_map, 1, _RET_IP_);
 	_raw_read_unlock(lock);
 	preempt_enable();
 }
 EXPORT_SYMBOL(_read_unlock);
 
+void __lockfunc _read_unlock_non_nested(rwlock_t *lock)
+{
+	rwlock_release(&lock->dep_map, 0, _RET_IP_);
+	_raw_read_unlock(lock);
+	preempt_enable();
+}
+EXPORT_SYMBOL(_read_unlock_non_nested);
+
 void __lockfunc _spin_unlock_irqrestore(spinlock_t *lock, unsigned long flags)
 {
+	spin_release(&lock->dep_map, 1, _RET_IP_);
 	_raw_spin_unlock(lock);
 	local_irq_restore(flags);
 	preempt_enable();
@@ -287,6 +390,7 @@ EXPORT_SYMBOL(_spin_unlock_irqrestore);
 
 void __lockfunc _spin_unlock_irq(spinlock_t *lock)
 {
+	spin_release(&lock->dep_map, 1, _RET_IP_);
 	_raw_spin_unlock(lock);
 	local_irq_enable();
 	preempt_enable();
@@ -295,14 +399,16 @@ EXPORT_SYMBOL(_spin_unlock_irq);
 
 void __lockfunc _spin_unlock_bh(spinlock_t *lock)
 {
+	spin_release(&lock->dep_map, 1, _RET_IP_);
 	_raw_spin_unlock(lock);
 	preempt_enable_no_resched();
-	local_bh_enable();
+	local_bh_enable_ip((unsigned long)__builtin_return_address(0));
 }
 EXPORT_SYMBOL(_spin_unlock_bh);
 
 void __lockfunc _read_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
 {
+	rwlock_release(&lock->dep_map, 1, _RET_IP_);
 	_raw_read_unlock(lock);
 	local_irq_restore(flags);
 	preempt_enable();
@@ -311,6 +417,7 @@ EXPORT_SYMBOL(_read_unlock_irqrestore);
 
 void __lockfunc _read_unlock_irq(rwlock_t *lock)
 {
+	rwlock_release(&lock->dep_map, 1, _RET_IP_);
 	_raw_read_unlock(lock);
 	local_irq_enable();
 	preempt_enable();
@@ -319,14 +426,16 @@ EXPORT_SYMBOL(_read_unlock_irq);
 
 void __lockfunc _read_unlock_bh(rwlock_t *lock)
 {
+	rwlock_release(&lock->dep_map, 1, _RET_IP_);
 	_raw_read_unlock(lock);
 	preempt_enable_no_resched();
-	local_bh_enable();
+	local_bh_enable_ip((unsigned long)__builtin_return_address(0));
 }
 EXPORT_SYMBOL(_read_unlock_bh);
 
 void __lockfunc _write_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
 {
+	rwlock_release(&lock->dep_map, 1, _RET_IP_);
 	_raw_write_unlock(lock);
 	local_irq_restore(flags);
 	preempt_enable();
@@ -335,6 +444,7 @@ EXPORT_SYMBOL(_write_unlock_irqrestore);
 
 void __lockfunc _write_unlock_irq(rwlock_t *lock)
 {
+	rwlock_release(&lock->dep_map, 1, _RET_IP_);
 	_raw_write_unlock(lock);
 	local_irq_enable();
 	preempt_enable();
@@ -343,9 +453,10 @@ EXPORT_SYMBOL(_write_unlock_irq);
 
 void __lockfunc _write_unlock_bh(rwlock_t *lock)
 {
+	rwlock_release(&lock->dep_map, 1, _RET_IP_);
 	_raw_write_unlock(lock);
 	preempt_enable_no_resched();
-	local_bh_enable();
+	local_bh_enable_ip((unsigned long)__builtin_return_address(0));
 }
 EXPORT_SYMBOL(_write_unlock_bh);
 
@@ -353,11 +464,13 @@ int __lockfunc _spin_trylock_bh(spinlock
 {
 	local_bh_disable();
 	preempt_disable();
-	if (_raw_spin_trylock(lock))
+	if (_raw_spin_trylock(lock)) {
+		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
 		return 1;
+	}
 
 	preempt_enable_no_resched();
-	local_bh_enable();
+	local_bh_enable_ip((unsigned long)__builtin_return_address(0));
 	return 0;
 }
 EXPORT_SYMBOL(_spin_trylock_bh);
Index: linux/lib/kernel_lock.c
===================================================================
--- linux.orig/lib/kernel_lock.c
+++ linux/lib/kernel_lock.c
@@ -177,7 +177,12 @@ static inline void __lock_kernel(void)
 
 static inline void __unlock_kernel(void)
 {
-	spin_unlock(&kernel_flag);
+	/*
+	 * the BKL is not covered by lockdep, so we open-code the
+	 * unlocking sequence (and thus avoid the dep-chain ops):
+	 */
+	_raw_spin_unlock(&kernel_flag);
+	preempt_enable();
 }
 
 /*
Index: linux/net/ipv4/route.c
===================================================================
--- linux.orig/net/ipv4/route.c
+++ linux/net/ipv4/route.c
@@ -206,7 +206,9 @@ __u8 ip_tos2prio[16] = {
 struct rt_hash_bucket {
 	struct rtable	*chain;
 };
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK) || \
+	defined(CONFIG_PROVE_SPIN_LOCKING) || \
+	defined(CONFIG_PROVE_RW_LOCKING)
 /*
  * Instead of using one spinlock for each rt_hash_bucket, we use a table of spinlocks
  * The size of this table is a power of two and depends on the number of CPUS.
