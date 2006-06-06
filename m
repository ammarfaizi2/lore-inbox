Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbWFFPqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWFFPqN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 11:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWFFPqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 11:46:13 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:3993 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750755AbWFFPqM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 11:46:12 -0400
Date: Tue, 6 Jun 2006 17:45:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
Subject: [patch, -rc5-mm3] lock validator: -V3
Message-ID: <20060606154530.GA11063@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: lock validator: -V3
From: Ingo Molnar <mingo@elte.hu>

this patch contains items that had to be done in one go, so i guess i'll 
call this lock validator -V3, for lack of better name. (This goes to the 
tail of the current lock validator queue in -mm)

Changes:

added 'detect if freed' (or if reinitialized/destroyed when held) 
feature for all the lock types covered by the validator: spinlocks, 
rwlocks, mutexes and rwsems - using the same central lock debugging 
code. This feature was available for mutexes before, now it's in the 
generic 'lock debugging' code and hence extended to all lock types.

Accordingly, new lock debugging options are now available:

 CONFIG_DEBUG_SPINLOCK_ALLOC=y
 CONFIG_DEBUG_RWLOCK_ALLOC=y
 CONFIG_DEBUG_MUTEX_ALLOC=y
 CONFIG_DEBUG_RWSEM_ALLOC=y

Added 12 new testcases to the locking selftest, to make sure the new 
features are working.

I unified all the lock debugging options, they are now all structured 
as: 'basic', 'free/exit checking' and 'full validation', and are 
dependent on each other. The lock types can be debugged independenty of 
each other.

I also resurrected SysRq-D (print all locks) support.

All in one, the structure of the lock debugging code is alot more 
consistent now, and all the lock debugging features are available across 
the spectrum.

I have tested this on x86 and x86_64, using various combinations of the 
new (and old) lock debugging options. Works fine here.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 drivers/char/sysrq.c              |    1 
 include/asm-i386/rwsem.h          |    4 
 include/linux/debug_locks.h       |   19 ++-
 include/linux/lockdep.h           |   73 +++++++++----
 include/linux/mutex.h             |    6 -
 include/linux/rwsem-spinlock.h    |    4 
 include/linux/rwsem.h             |    4 
 include/linux/sched.h             |    1 
 include/linux/spinlock.h          |   16 --
 include/linux/spinlock_types.h    |    8 -
 include/linux/spinlock_types_up.h |    8 -
 include/linux/spinlock_up.h       |    5 
 kernel/lockdep.c                  |  211 ++++++++++++++++++++++++++++++++------
 kernel/mutex-debug.c              |    6 -
 kernel/mutex-debug.h              |    3 
 kernel/mutex-lockdep.h            |   40 -------
 kernel/mutex.c                    |   17 ---
 kernel/mutex.h                    |    2 
 kernel/spinlock.c                 |   38 ------
 lib/Kconfig.debug                 |   98 ++++++++++++-----
 lib/locking-selftest-mutex.h      |    6 +
 lib/locking-selftest-rlock.h      |    9 +
 lib/locking-selftest-rsem.h       |    9 +
 lib/locking-selftest-spin.h       |    6 +
 lib/locking-selftest-wlock.h      |    9 +
 lib/locking-selftest-wsem.h       |    9 +
 lib/locking-selftest.c            |  107 +++++++++++++++++--
 lib/rwsem-spinlock.c              |   10 +
 lib/rwsem.c                       |   10 +
 lib/spinlock_debug.c              |   36 ++++++
 30 files changed, 545 insertions(+), 230 deletions(-)

Index: linux/drivers/char/sysrq.c
===================================================================
--- linux.orig/drivers/char/sysrq.c
+++ linux/drivers/char/sysrq.c
@@ -153,7 +153,6 @@ static void sysrq_handle_showlocks(int k
 				struct tty_struct *tty)
 {
 	debug_show_all_locks();
-	print_lock_types();
 }
 
 static struct sysrq_key_op sysrq_showlocks_op = {
Index: linux/include/asm-i386/rwsem.h
===================================================================
--- linux.orig/include/asm-i386/rwsem.h
+++ linux/include/asm-i386/rwsem.h
@@ -65,7 +65,7 @@ struct rw_semaphore {
 #if RWSEM_DEBUG
 	int			debug;
 #endif
-#ifdef CONFIG_PROVE_RWSEM_LOCKING
+#ifdef CONFIG_DEBUG_RWSEM_ALLOC
 	struct lockdep_map dep_map;
 #endif
 };
@@ -79,7 +79,7 @@ struct rw_semaphore {
 #define __RWSEM_DEBUG_INIT	/* */
 #endif
 
-#ifdef CONFIG_PROVE_RWSEM_LOCKING
+#ifdef CONFIG_DEBUG_RWSEM_ALLOC
 # define __RWSEM_DEP_MAP_INIT(lockname) , .dep_map = { .name = #lockname }
 #else
 # define __RWSEM_DEP_MAP_INIT(lockname)
Index: linux/include/linux/debug_locks.h
===================================================================
--- linux.orig/include/linux/debug_locks.h
+++ linux/include/linux/debug_locks.h
@@ -41,22 +41,29 @@ extern int debug_locks_off(void);
 # define locking_selftest()	do { } while (0)
 #endif
 
-static inline void
-debug_check_no_locks_freed(const void *from, unsigned long len)
+#ifdef CONFIG_LOCKDEP
+extern void debug_show_all_locks(void);
+extern void debug_show_held_locks(struct task_struct *task);
+extern void debug_check_no_locks_freed(const void *from, unsigned long len);
+extern void debug_check_no_locks_held(struct task_struct *task);
+#else
+static inline void debug_show_all_locks(void)
 {
 }
 
-static inline void
-debug_check_no_locks_held(struct task_struct *task)
+static inline void debug_show_held_locks(struct task_struct *task)
 {
 }
 
-static inline void debug_show_all_locks(void)
+static inline void
+debug_check_no_locks_freed(const void *from, unsigned long len)
 {
 }
 
-static inline void debug_show_held_locks(struct task_struct *task)
+static inline void
+debug_check_no_locks_held(struct task_struct *task)
 {
 }
+#endif
 
 #endif
Index: linux/include/linux/lockdep.h
===================================================================
--- linux.orig/include/linux/lockdep.h
+++ linux/include/linux/lockdep.h
@@ -178,6 +178,7 @@ struct held_lock {
 	int				irq_context;
 	int				trylock;
 	int				read;
+	int				check;
 	int				hardirqs_off;
 };
 
@@ -202,15 +203,32 @@ extern void lockdep_print_held_locks(str
 extern void lockdep_init_map(struct lockdep_map *lock, const char *name,
 			     struct lockdep_type_key *key);
 
-extern void lockdep_acquire(struct lockdep_map *lock, unsigned int subtype,
-			    int trylock, int read, unsigned long ip);
+/*
+ * Acquire a lock.
+ *
+ * Values for "read":
+ *
+ *   0: exclusive (write) acquire
+ *   1: read-acquire (no recursion allowed)
+ *   2: read-acquire with same-instance recursion allowed
+ *
+ * Values for check:
+ *
+ *   0: disabled
+ *   1: simple checks (freeing, held-at-exit-time, etc.)
+ *   2: full validation
+ */
+extern void lock_acquire(struct lockdep_map *lock, unsigned int subtype,
+			 int trylock, int read, int check, unsigned long ip);
 
-extern void lockdep_release(struct lockdep_map *lock, int nested,
-			    unsigned long ip);
+extern void lock_release(struct lockdep_map *lock, int nested,
+			 unsigned long ip);
 
 # define INIT_LOCKDEP				.lockdep_recursion = 0,
 
 #else /* LOCKDEP */
+# define lock_acquire(l, s, t, r, c, i)		do { } while (0)
+# define lock_release(l, n, i)			do { } while (0)
 # define lockdep_init()				do { } while (0)
 # define lockdep_info()				do { } while (0)
 # define print_lock_types()			do { } while (0)
@@ -246,36 +264,55 @@ extern void early_boot_irqs_on(void);
  * Map the dependency ops to NOP or to real lockdep ops, depending
  * on the per lock-type debug mode:
  */
-#ifdef CONFIG_PROVE_SPIN_LOCKING
-# define spin_acquire(l, s, t, i)		lockdep_acquire(l, s, t, 0, i)
-# define spin_release(l, n, i)			lockdep_release(l, n, i)
+
+#ifdef CONFIG_DEBUG_SPINLOCK_ALLOC
+# ifdef CONFIG_PROVE_SPIN_LOCKING
+#  define spin_acquire(l, s, t, i)		lock_acquire(l, s, t, 0, 2, i)
+# else
+#  define spin_acquire(l, s, t, i)		lock_acquire(l, s, t, 0, 1, i)
+# endif
+# define spin_release(l, n, i)			lock_release(l, n, i)
 #else
 # define spin_acquire(l, s, t, i)		do { } while (0)
 # define spin_release(l, n, i)			do { } while (0)
 #endif
 
-#ifdef CONFIG_PROVE_RW_LOCKING
-# define rwlock_acquire(l, s, t, i)		lockdep_acquire(l, s, t, 0, i)
-# define rwlock_acquire_read(l, s, t, i)	lockdep_acquire(l, s, t, 1, i)
-# define rwlock_release(l, n, i)		lockdep_release(l, n, i)
+#ifdef CONFIG_DEBUG_RWLOCK_ALLOC
+# ifdef CONFIG_PROVE_RW_LOCKING
+#  define rwlock_acquire(l, s, t, i)		lock_acquire(l, s, t, 0, 2, i)
+#  define rwlock_acquire_read(l, s, t, i)	lock_acquire(l, s, t, 2, 2, i)
+# else
+#  define rwlock_acquire(l, s, t, i)		lock_acquire(l, s, t, 0, 1, i)
+#  define rwlock_acquire_read(l, s, t, i)	lock_acquire(l, s, t, 2, 1, i)
+# endif
+# define rwlock_release(l, n, i)		lock_release(l, n, i)
 #else
 # define rwlock_acquire(l, s, t, i)		do { } while (0)
 # define rwlock_acquire_read(l, s, t, i)	do { } while (0)
 # define rwlock_release(l, n, i)		do { } while (0)
 #endif
 
-#ifdef CONFIG_PROVE_MUTEX_LOCKING
-# define mutex_acquire(l, s, t, i)		lockdep_acquire(l, s, t, 0, i)
-# define mutex_release(l, n, i)			lockdep_release(l, n, i)
+#ifdef CONFIG_DEBUG_MUTEX_ALLOC
+# ifdef CONFIG_PROVE_MUTEX_LOCKING
+#  define mutex_acquire(l, s, t, i)		lock_acquire(l, s, t, 0, 2, i)
+# else
+#  define mutex_acquire(l, s, t, i)		lock_acquire(l, s, t, 0, 1, i)
+# endif
+# define mutex_release(l, n, i)			lock_release(l, n, i)
 #else
 # define mutex_acquire(l, s, t, i)		do { } while (0)
 # define mutex_release(l, n, i)			do { } while (0)
 #endif
 
-#ifdef CONFIG_PROVE_RWSEM_LOCKING
-# define rwsem_acquire(l, s, t, i)		lockdep_acquire(l, s, t, 0, i)
-# define rwsem_acquire_read(l, s, t, i)		lockdep_acquire(l, s, t, -1, i)
-# define rwsem_release(l, n, i)			lockdep_release(l, n, i)
+#ifdef CONFIG_DEBUG_RWSEM_ALLOC
+# ifdef CONFIG_PROVE_RWSEM_LOCKING
+#  define rwsem_acquire(l, s, t, i)		lock_acquire(l, s, t, 0, 2, i)
+#  define rwsem_acquire_read(l, s, t, i)	lock_acquire(l, s, t, 1, 2, i)
+# else
+#  define rwsem_acquire(l, s, t, i)		lock_acquire(l, s, t, 0, 1, i)
+#  define rwsem_acquire_read(l, s, t, i)	lock_acquire(l, s, t, 1, 1, i)
+# endif
+# define rwsem_release(l, n, i)			lock_release(l, n, i)
 #else
 # define rwsem_acquire(l, s, t, i)		do { } while (0)
 # define rwsem_acquire_read(l, s, t, i)		do { } while (0)
Index: linux/include/linux/mutex.h
===================================================================
--- linux.orig/include/linux/mutex.h
+++ linux/include/linux/mutex.h
@@ -54,7 +54,7 @@ struct mutex {
 	const char 		*name;
 	void			*magic;
 #endif
-#ifdef CONFIG_PROVE_MUTEX_LOCKING
+#ifdef CONFIG_DEBUG_MUTEX_ALLOC
 	struct lockdep_map	dep_map;
 #endif
 };
@@ -85,7 +85,7 @@ do {							\
 # define mutex_destroy(mutex)				do { } while (0)
 #endif
 
-#ifdef CONFIG_PROVE_MUTEX_LOCKING
+#ifdef CONFIG_DEBUG_MUTEX_ALLOC
 # define __DEP_MAP_MUTEX_INITIALIZER(lockname) \
 		, .dep_map = { .name = #lockname }
 #else
@@ -125,7 +125,7 @@ static inline int fastcall mutex_is_lock
 extern void fastcall mutex_lock(struct mutex *lock);
 extern int fastcall mutex_lock_interruptible(struct mutex *lock);
 
-#ifdef CONFIG_PROVE_MUTEX_LOCKING
+#ifdef CONFIG_DEBUG_MUTEX_ALLOC
 extern void mutex_lock_nested(struct mutex *lock, unsigned int subtype);
 #else
 # define mutex_lock_nested(lock, subtype) mutex_lock(lock)
Index: linux/include/linux/rwsem-spinlock.h
===================================================================
--- linux.orig/include/linux/rwsem-spinlock.h
+++ linux/include/linux/rwsem-spinlock.h
@@ -35,7 +35,7 @@ struct rw_semaphore {
 #if RWSEM_DEBUG
 	int			debug;
 #endif
-#ifdef CONFIG_PROVE_RWSEM_LOCKING
+#ifdef CONFIG_DEBUG_RWSEM_ALLOC
 	struct lockdep_map dep_map;
 #endif
 };
@@ -49,7 +49,7 @@ struct rw_semaphore {
 #define __RWSEM_DEBUG_INIT	/* */
 #endif
 
-#ifdef CONFIG_PROVE_RWSEM_LOCKING
+#ifdef CONFIG_DEBUG_RWSEM_ALLOC
 # define __RWSEM_DEP_MAP_INIT(lockname) , .dep_map = { .name = #lockname }
 #else
 # define __RWSEM_DEP_MAP_INIT(lockname)
Index: linux/include/linux/rwsem.h
===================================================================
--- linux.orig/include/linux/rwsem.h
+++ linux/include/linux/rwsem.h
@@ -30,7 +30,7 @@ struct rw_semaphore;
  * Lockdep: type splitting can also be done for dynamic locks, if for
  * example there are per-CPU dynamically allocated locks:
  */
-#ifdef CONFIG_PROVE_RWSEM_LOCKING
+#ifdef CONFIG_DEBUG_RWSEM_ALLOC
 #define init_rwsem_key(sem, key)				\
 	__init_rwsem((sem), #sem, key)
 #else
@@ -100,7 +100,7 @@ static inline void down_write(struct rw_
 /*
  * lock for writing
  */
-#ifdef CONFIG_PROVE_RWSEM_LOCKING
+#ifdef CONFIG_DEBUG_RWSEM_ALLOC
 static inline void down_write_nested(struct rw_semaphore *sem, int subtype)
 {
 	might_sleep();
Index: linux/include/linux/sched.h
===================================================================
--- linux.orig/include/linux/sched.h
+++ linux/include/linux/sched.h
@@ -940,6 +940,7 @@ struct task_struct {
 	struct held_lock held_locks[MAX_LOCK_DEPTH];
 #endif
 	unsigned int lockdep_recursion;
+	int lockdep_verbose;
 
 /* journalling filesystem info */
 	void *journal_info;
Index: linux/include/linux/spinlock.h
===================================================================
--- linux.orig/include/linux/spinlock.h
+++ linux/include/linux/spinlock.h
@@ -88,7 +88,7 @@ extern int __lockfunc generic__raw_read_
 # include <linux/spinlock_up.h>
 #endif
 
-#if defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PROVE_SPIN_LOCKING)
+#ifdef CONFIG_DEBUG_SPINLOCK
   extern void __spin_lock_init(spinlock_t *lock, const char *name,
 			       struct lockdep_type_key *key);
 # define spin_lock_init(lock)					\
@@ -123,7 +123,7 @@ do {								\
 	do { spin_lock_init(lock); (void)(key); } while (0)
 #endif
 
-#if defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PROVE_RW_LOCKING)
+#ifdef CONFIG_DEBUG_SPINLOCK
   extern void __rwlock_init(rwlock_t *lock, const char *name,
 			    struct lockdep_type_key *key);
 # define rwlock_init(lock)					\
@@ -152,9 +152,7 @@ do {								\
 /*
  * Pull the _spin_*()/_read_*()/_write_*() functions/declarations:
  */
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK) || \
-	defined(CONFIG_PROVE_SPIN_LOCKING) || \
-	defined(CONFIG_PROVE_RW_LOCKING)
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
 # include <linux/spinlock_api_smp.h>
 #else
 # include <linux/spinlock_api_up.h>
@@ -203,9 +201,7 @@ do {								\
 #define write_lock(lock)		_write_lock(lock)
 #define read_lock(lock)			_read_lock(lock)
 
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK) || \
-	defined(CONFIG_PROVE_SPIN_LOCKING) || \
-	defined(CONFIG_PROVE_RW_LOCKING)
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
 #define spin_lock_irqsave(lock, flags)	flags = _spin_lock_irqsave(lock)
 #define read_lock_irqsave(lock, flags)	flags = _read_lock_irqsave(lock)
 #define write_lock_irqsave(lock, flags)	flags = _write_lock_irqsave(lock)
@@ -228,9 +224,7 @@ do {								\
  * We inline the unlock functions in the nondebug case:
  */
 #if defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PREEMPT) || \
-	!defined(CONFIG_SMP) || \
-	defined(CONFIG_PROVE_SPIN_LOCKING) || \
-	defined(CONFIG_PROVE_RW_LOCKING)
+	!defined(CONFIG_SMP)
 # define spin_unlock(lock)		_spin_unlock(lock)
 # define spin_unlock_non_nested(lock)	_spin_unlock_non_nested(lock)
 # define read_unlock(lock)		_read_unlock(lock)
Index: linux/include/linux/spinlock_types.h
===================================================================
--- linux.orig/include/linux/spinlock_types.h
+++ linux/include/linux/spinlock_types.h
@@ -26,7 +26,7 @@ typedef struct {
 	unsigned int magic, owner_cpu;
 	void *owner;
 #endif
-#ifdef CONFIG_PROVE_SPIN_LOCKING
+#ifdef CONFIG_DEBUG_SPINLOCK_ALLOC
 	struct lockdep_map dep_map;
 #endif
 } spinlock_t;
@@ -42,7 +42,7 @@ typedef struct {
 	unsigned int magic, owner_cpu;
 	void *owner;
 #endif
-#ifdef CONFIG_PROVE_RW_LOCKING
+#ifdef CONFIG_DEBUG_RWLOCK_ALLOC
 	struct lockdep_map dep_map;
 #endif
 } rwlock_t;
@@ -51,13 +51,13 @@ typedef struct {
 
 #define SPINLOCK_OWNER_INIT	((void *)-1L)
 
-#ifdef CONFIG_PROVE_SPIN_LOCKING
+#ifdef CONFIG_DEBUG_SPINLOCK_ALLOC
 # define SPIN_DEP_MAP_INIT(lockname)	.dep_map = { .name = #lockname }
 #else
 # define SPIN_DEP_MAP_INIT(lockname)
 #endif
 
-#ifdef CONFIG_PROVE_RW_LOCKING
+#ifdef CONFIG_DEBUG_RWLOCK_ALLOC
 # define RW_DEP_MAP_INIT(lockname)	.dep_map = { .name = #lockname }
 #else
 # define RW_DEP_MAP_INIT(lockname)
Index: linux/include/linux/spinlock_types_up.h
===================================================================
--- linux.orig/include/linux/spinlock_types_up.h
+++ linux/include/linux/spinlock_types_up.h
@@ -13,12 +13,12 @@
  */
 
 #if defined(CONFIG_DEBUG_SPINLOCK) || \
-	defined(CONFIG_PROVE_SPIN_LOCKING) || \
-	defined(CONFIG_PROVE_RW_LOCKING)
+	defined(CONFIG_DEBUG_SPINLOCK_ALLOC) || \
+	defined(CONFIG_DEBUG_RWLOCK_ALLOC)
 
 typedef struct {
 	volatile unsigned int slock;
-#ifdef CONFIG_PROVE_SPIN_LOCKING
+#ifdef CONFIG_DEBUG_SPINLOCK_ALLOC
 	struct lockdep_map dep_map;
 #endif
 } raw_spinlock_t;
@@ -35,7 +35,7 @@ typedef struct { } raw_spinlock_t;
 
 typedef struct {
 	/* no debug version on UP */
-#ifdef CONFIG_PROVE_RW_LOCKING
+#ifdef CONFIG_DEBUG_RWLOCK_ALLOC
 	struct lockdep_map dep_map;
 #endif
 } raw_rwlock_t;
Index: linux/include/linux/spinlock_up.h
===================================================================
--- linux.orig/include/linux/spinlock_up.h
+++ linux/include/linux/spinlock_up.h
@@ -17,10 +17,7 @@
  * No atomicity anywhere, we are on UP.
  */
 
-#if defined(CONFIG_DEBUG_SPINLOCK) || \
-	defined(CONFIG_PROVE_SPIN_LOCKING) || \
-	defined(CONFIG_PROVE_RW_LOCKING)
-
+#ifdef CONFIG_DEBUG_SPINLOCK
 #define __raw_spin_is_locked(x)		((x)->slock == 0)
 
 static inline void __raw_spin_lock(raw_spinlock_t *lock)
Index: linux/kernel/lockdep.c
===================================================================
--- linux.orig/kernel/lockdep.c
+++ linux/kernel/lockdep.c
@@ -164,6 +164,8 @@ static int verbose(struct lock_type *typ
 	return 0;
 }
 
+#ifdef CONFIG_TRACE_IRQFLAGS
+
 static int hardirq_verbose(struct lock_type *type)
 {
 #if HARDIRQ_VERBOSE
@@ -180,6 +182,8 @@ static int softirq_verbose(struct lock_t
 	return 0;
 }
 
+#endif
+
 /*
  * Stack-trace: tightly packed array of stack backtrace
  * addresses. Protected by the hash_lock.
@@ -390,16 +394,16 @@ static void print_lock(struct held_lock 
 
 void lockdep_print_held_locks(struct task_struct *curr)
 {
-	int i;
+	int i, depth = curr->lockdep_depth;
 
-	if (!curr->lockdep_depth) {
+	if (!depth) {
 		printk("no locks held by %s/%d.\n", curr->comm, curr->pid);
 		return;
 	}
-	printk("%d locks held by %s/%d:\n",
-		curr->lockdep_depth, curr->comm, curr->pid);
+	printk("%d lock%s held by %s/%d:\n",
+		depth, depth > 1 ? "s" : "", curr->comm, curr->pid);
 
-	for (i = 0; i < curr->lockdep_depth; i++) {
+	for (i = 0; i < depth; i++) {
 		printk(" #%d: ", i);
 		print_lock(curr->held_locks + i);
 	}
@@ -889,7 +893,7 @@ check_deadlock(struct task_struct *curr,
 		 * Allow read-after-read recursion of the same
 		 * lock instance (i.e. read_lock(lock)+read_lock(lock)):
 		 */
-		if ((read > 0) && prev->read &&
+		if ((read == 2) && prev->read &&
 				(prev->instance == next_instance))
 			return 2;
 		return print_deadlock_bug(curr, prev, next);
@@ -988,7 +992,7 @@ check_prev_add(struct task_struct *curr,
 	 * write-lock never takes any other locks, then the reads are
 	 * equivalent to a NOP.
 	 */
-	if (next->read == 1 || prev->read == 1)
+	if (next->read == 2 || prev->read == 2)
 		return 1;
 	/*
 	 * Is the <prev> -> <next> dependency already present?
@@ -1997,9 +2001,9 @@ EXPORT_SYMBOL_GPL(lockdep_init_map);
  * This gets called for every mutex_lock*()/spin_lock*() operation.
  * We maintain the dependency maps and validate the locking attempt:
  */
-static int __lockdep_acquire(struct lockdep_map *lock, unsigned int subtype,
-			     int trylock, int read, int hardirqs_off,
-			     unsigned long ip)
+static int __lock_acquire(struct lockdep_map *lock, unsigned int subtype,
+			  int trylock, int read, int check, int hardirqs_off,
+			  unsigned long ip)
 {
 	struct task_struct *curr = current;
 	struct held_lock *hlock;
@@ -2046,8 +2050,11 @@ static int __lockdep_acquire(struct lock
 	hlock->instance = lock;
 	hlock->trylock = trylock;
 	hlock->read = read;
+	hlock->check = check;
 	hlock->hardirqs_off = hardirqs_off;
 
+	if (check != 2)
+		goto out_calc_hash;
 #ifdef CONFIG_TRACE_IRQFLAGS
 	/*
 	 * If non-trylock use in a hardirq or softirq context, then
@@ -2095,6 +2102,7 @@ static int __lockdep_acquire(struct lock
 	/* mark it as used: */
 	if (!mark_lock(curr, hlock, LOCK_USED, ip))
 		return 0;
+out_calc_hash:
 	/*
 	 * Calculate the chain hash: it's the combined has of all the
 	 * lock keys along the dependency chain. We save the hash value
@@ -2152,7 +2160,7 @@ static int __lockdep_acquire(struct lock
 	 * (If lookup_chain_cache() returns with 1 it acquires
 	 * hash_lock for us)
 	 */
-	if (!trylock && lookup_chain_cache(chain_key)) {
+	if (!trylock && (check == 2) && lookup_chain_cache(chain_key)) {
 		/*
 		 * Check whether last held lock:
 		 *
@@ -2205,7 +2213,8 @@ static int
 print_unlock_order_bug(struct task_struct *curr, struct lockdep_map *lock,
 		       struct held_lock *hlock, unsigned long ip)
 {
-	debug_locks_off();
+	if (!debug_locks_off())
+		return 0;
 	if (debug_locks_silent)
 		return 0;
 
@@ -2235,7 +2244,8 @@ static int
 print_unlock_inbalance_bug(struct task_struct *curr, struct lockdep_map *lock,
 			   unsigned long ip)
 {
-	debug_locks_off();
+	if (!debug_locks_off())
+		return 0;
 	if (debug_locks_silent)
 		return 0;
 
@@ -2278,11 +2288,11 @@ static int check_unlock(struct task_stru
  * Remove the lock to the list of currently held locks in a
  * potentially non-nested (out of order) manner. This is a
  * relatively rare operation, as all the unlock APIs default
- * to nested mode (which uses lockdep_release()):
+ * to nested mode (which uses lock_release()):
  */
 static int
-lockdep_release_non_nested(struct task_struct *curr,
-			   struct lockdep_map *lock, unsigned long ip)
+lock_release_non_nested(struct task_struct *curr,
+			struct lockdep_map *lock, unsigned long ip)
 {
 	struct held_lock *hlock, *prev_hlock;
 	unsigned int depth;
@@ -2321,9 +2331,9 @@ found_it:
 
 	for (i++; i < depth; i++) {
 		hlock = curr->held_locks + i;
-		if (!__lockdep_acquire(hlock->instance,
+		if (!__lock_acquire(hlock->instance,
 			hlock->type->subtype, hlock->trylock,
-				hlock->read, hlock->hardirqs_off,
+				hlock->read, hlock->check, hlock->hardirqs_off,
 				hlock->acquire_ip))
 			return 0;
 	}
@@ -2339,8 +2349,8 @@ found_it:
  * mutex_lock_interruptible()). This is done for unlocks that nest
  * perfectly. (i.e. the current top of the lock-stack is unlocked)
  */
-static int lockdep_release_nested(struct task_struct *curr,
-				  struct lockdep_map *lock, unsigned long ip)
+static int lock_release_nested(struct task_struct *curr,
+			       struct lockdep_map *lock, unsigned long ip)
 {
 	struct held_lock *hlock;
 	unsigned int depth;
@@ -2358,7 +2368,7 @@ static int lockdep_release_nested(struct
 #ifdef CONFIG_DEBUG_NON_NESTED_UNLOCKS
 		return print_unlock_order_bug(curr, lock, hlock, ip);
 #else
-		return lockdep_release_non_nested(curr, lock, ip);
+		return lock_release_non_nested(curr, lock, ip);
 #endif
 	}
 	curr->lockdep_depth--;
@@ -2383,8 +2393,8 @@ static int lockdep_release_nested(struct
  * mutex_lock_interruptible()). This is done for unlocks that nest
  * perfectly. (i.e. the current top of the lock-stack is unlocked)
  */
-static void __lockdep_release(struct lockdep_map *lock, int nested,
-			      unsigned long ip)
+static void
+__lock_release(struct lockdep_map *lock, int nested, unsigned long ip)
 {
 	struct task_struct *curr = current;
 
@@ -2392,10 +2402,10 @@ static void __lockdep_release(struct loc
 		return;
 
 	if (nested) {
-		if (!lockdep_release_nested(curr, lock, ip))
+		if (!lock_release_nested(curr, lock, ip))
 			return;
 	} else {
-		if (!lockdep_release_non_nested(curr, lock, ip))
+		if (!lock_release_non_nested(curr, lock, ip))
 			return;
 	}
 
@@ -2437,8 +2447,8 @@ static void check_flags(unsigned long fl
  * We are not always called with irqs disabled - do that here,
  * and also avoid lockdep recursion:
  */
-void lockdep_acquire(struct lockdep_map *lock, unsigned int subtype,
-		     int trylock, int read, unsigned long ip)
+void lock_acquire(struct lockdep_map *lock, unsigned int subtype,
+		  int trylock, int read, int check, unsigned long ip)
 {
 	unsigned long flags;
 
@@ -2451,15 +2461,16 @@ void lockdep_acquire(struct lockdep_map 
 	if (unlikely(current->lockdep_recursion))
 		goto out;
 	current->lockdep_recursion = 1;
-	__lockdep_acquire(lock, subtype, trylock, read, irqs_disabled_flags(flags), ip);
+	__lock_acquire(lock, subtype, trylock, read, check,
+		       irqs_disabled_flags(flags), ip);
 	current->lockdep_recursion = 0;
 out:
 	raw_local_irq_restore(flags);
 }
 
-EXPORT_SYMBOL_GPL(lockdep_acquire);
+EXPORT_SYMBOL_GPL(lock_acquire);
 
-void lockdep_release(struct lockdep_map *lock, int nested, unsigned long ip)
+void lock_release(struct lockdep_map *lock, int nested, unsigned long ip)
 {
 	unsigned long flags;
 
@@ -2471,13 +2482,13 @@ void lockdep_release(struct lockdep_map 
 	if (unlikely(current->lockdep_recursion))
 		goto out;
 	current->lockdep_recursion = 1;
-	__lockdep_release(lock, nested, ip);
+	__lock_release(lock, nested, ip);
 	current->lockdep_recursion = 0;
 out:
 	raw_local_irq_restore(flags);
 }
 
-EXPORT_SYMBOL_GPL(lockdep_release);
+EXPORT_SYMBOL_GPL(lock_release);
 
 /*
  * Used by the testsuite, sanitize the validator state
@@ -2648,3 +2659,139 @@ void __init lockdep_info(void)
 #endif
 }
 
+static inline int in_range(const void *start, const void *addr, const void *end)
+{
+	return addr >= start && addr <= end;
+}
+
+static void
+print_freed_lock_bug(struct task_struct *curr, const void *mem_from,
+		     const void *mem_to)
+{
+	if (!debug_locks_off())
+		return;
+	if (debug_locks_silent)
+		return;
+
+	printk("\n=========================\n");
+	printk(  "[ BUG: held lock freed! ]\n");
+	printk(  "-------------------------\n");
+	printk("%s/%d is freeing memory %p-%p, with a lock still held there!\n",
+		curr->comm, curr->pid, mem_from, mem_to-1);
+	lockdep_print_held_locks(curr);
+
+	printk("\nstack backtrace:\n");
+	dump_stack();
+}
+
+/*
+ * Called when kernel memory is freed (or unmapped), or if a lock
+ * is destroyed or reinitialized - this code checks whether there is
+ * any held lock in the memory range of <from> to <to>:
+ */
+void debug_check_no_locks_freed(const void *mem_from, unsigned long mem_len)
+{
+	const void *mem_to = mem_from + mem_len, *lock_from, *lock_to;
+	struct task_struct *curr = current;
+	struct held_lock *hlock;
+	unsigned long flags;
+	int i;
+
+	if (unlikely(!debug_locks))
+		return;
+
+	local_irq_save(flags);
+	for (i = 0; i < curr->lockdep_depth; i++) {
+		hlock = curr->held_locks + i;
+
+		lock_from = (void *)hlock->instance;
+		lock_to = (void *)(hlock->instance + 1);
+
+		if (!in_range(mem_from, lock_from, mem_to) &&
+					!in_range(mem_from, lock_to, mem_to))
+			continue;
+
+		print_freed_lock_bug(curr, mem_from, mem_to);
+		break;
+	}
+	local_irq_restore(flags);
+}
+
+static void print_held_locks_bug(struct task_struct *curr)
+{
+	if (!debug_locks_off())
+		return;
+	if (debug_locks_silent)
+		return;
+
+	printk("\n=====================================\n");
+	printk(  "[ BUG: lock held at task exit time! ]\n");
+	printk(  "-------------------------------------\n");
+	printk("%s/%d is exiting with locks still held!\n",
+		curr->comm, curr->pid);
+	lockdep_print_held_locks(curr);
+
+	printk("\nstack backtrace:\n");
+	dump_stack();
+}
+
+void debug_check_no_locks_held(struct task_struct *task)
+{
+	if (unlikely(task->lockdep_depth > 0))
+		print_held_locks_bug(task);
+}
+
+void debug_show_all_locks(void)
+{
+	struct task_struct *g, *p;
+	int count = 10;
+	int unlock = 1;
+
+	printk("\nShowing all locks held in the system:\n");
+
+	/*
+	 * Here we try to get the tasklist_lock as hard as possible,
+	 * if not successful after 2 seconds we ignore it (but keep
+	 * trying). This is to enable a debug printout even if a
+	 * tasklist_lock-holding task deadlocks or crashes.
+	 */
+retry:
+	if (!read_trylock(&tasklist_lock)) {
+		if (count == 10)
+			printk("hm, tasklist_lock locked, retrying... ");
+		if (count) {
+			count--;
+			printk(" #%d", 10-count);
+			mdelay(200);
+			goto retry;
+		}
+		printk(" ignoring it.\n");
+		unlock = 0;
+	}
+	if (count != 10)
+		printk(" locked it.\n");
+
+	do_each_thread(g, p) {
+		if (p->lockdep_depth)
+			lockdep_print_held_locks(p);
+		if (!unlock)
+			if (read_trylock(&tasklist_lock))
+				unlock = 1;
+	} while_each_thread(g, p);
+
+	printk("\n");
+	printk("=============================================\n\n");
+
+	if (unlock)
+		read_unlock(&tasklist_lock);
+}
+
+EXPORT_SYMBOL_GPL(debug_show_all_locks);
+
+void debug_show_held_locks(struct task_struct *task)
+{
+	lockdep_print_held_locks(task);
+}
+
+EXPORT_SYMBOL_GPL(debug_show_held_locks);
+
Index: linux/kernel/mutex-debug.c
===================================================================
--- linux.orig/kernel/mutex-debug.c
+++ linux/kernel/mutex-debug.c
@@ -82,12 +82,16 @@ void debug_mutex_unlock(struct mutex *lo
 	DEBUG_WARN_ON(lock->owner != current_thread_info());
 }
 
-void debug_mutex_init(struct mutex *lock, const char *name)
+void debug_mutex_init(struct mutex *lock, const char *name,
+		      struct lockdep_type_key *key)
 {
+#ifdef CONFIG_DEBUG_MUTEX_ALLOC
 	/*
 	 * Make sure we are not reinitializing a held lock:
 	 */
 	debug_check_no_locks_freed((void *)lock, sizeof(*lock));
+	lockdep_init_map(&lock->dep_map, name, key);
+#endif
 	lock->owner = NULL;
 	lock->magic = lock;
 }
Index: linux/kernel/mutex-debug.h
===================================================================
--- linux.orig/kernel/mutex-debug.h
+++ linux/kernel/mutex-debug.h
@@ -32,7 +32,8 @@ extern void debug_mutex_add_waiter(struc
 extern void mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 				struct thread_info *ti);
 extern void debug_mutex_unlock(struct mutex *lock);
-extern void debug_mutex_init(struct mutex *lock, const char *name);
+extern void debug_mutex_init(struct mutex *lock, const char *name,
+			     struct lockdep_type_key *key);
 
 #define spin_lock_mutex(lock, flags)			\
 	do {						\
Index: linux/kernel/mutex-lockdep.h
===================================================================
--- linux.orig/kernel/mutex-lockdep.h
+++ /dev/null
@@ -1,40 +0,0 @@
-/*
- * Mutexes: blocking mutual exclusion locks
- *
- * started by Ingo Molnar:
- *
- *  Copyright (C) 2004-2006 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
- *
- * This file contains mutex debugging related internal prototypes, for the
- * !CONFIG_DEBUG_MUTEXES && CONFIG_PROVE_MUTEX_LOCKING case. Most of
- * them are NOPs:
- */
-
-#define spin_lock_mutex(lock, flags)			\
-	do {						\
-		local_irq_save(flags);			\
-		__raw_spin_lock(&(lock)->raw_lock);	\
-	} while (0)
-
-#define spin_unlock_mutex(lock, flags)			\
-	do {						\
-		__raw_spin_unlock(&(lock)->raw_lock);	\
-		local_irq_restore(flags);		\
-	} while (0)
-
-#define mutex_remove_waiter(lock, waiter, ti) \
-		__list_del((waiter)->list.prev, (waiter)->list.next)
-
-#define debug_mutex_set_owner(lock, new_owner)		do { } while (0)
-#define debug_mutex_clear_owner(lock)			do { } while (0)
-#define debug_mutex_wake_waiter(lock, waiter)		do { } while (0)
-#define debug_mutex_free_waiter(waiter)			do { } while (0)
-#define debug_mutex_add_waiter(lock, waiter, ti)	do { } while (0)
-#define debug_mutex_unlock(lock)			do { } while (0)
-#define debug_mutex_init(lock, name)			do { } while (0)
-
-static inline void
-debug_mutex_lock_common(struct mutex *lock,
-			struct mutex_waiter *waiter)
-{
-}
Index: linux/kernel/mutex.c
===================================================================
--- linux.orig/kernel/mutex.c
+++ linux/kernel/mutex.c
@@ -27,13 +27,8 @@
 # include "mutex-debug.h"
 # include <asm-generic/mutex-null.h>
 #else
-# ifdef CONFIG_PROVE_MUTEX_LOCKING
-#  include "mutex-lockdep.h"
-#  include <asm-generic/mutex-null.h>
-# else
-#  include "mutex.h"
-#  include <asm/mutex.h>
-# endif
+# include "mutex.h"
+# include <asm/mutex.h>
 #endif
 
 /***
@@ -51,11 +46,7 @@ __mutex_init(struct mutex *lock, const c
 	spin_lock_init(&lock->wait_lock);
 	INIT_LIST_HEAD(&lock->wait_list);
 
-	debug_mutex_init(lock, name);
-
-#ifdef CONFIG_PROVE_MUTEX_LOCKING
-	lockdep_init_map(&lock->dep_map, name, key);
-#endif
+	debug_mutex_init(lock, name, key);
 }
 
 EXPORT_SYMBOL(__mutex_init);
@@ -225,7 +216,7 @@ __mutex_lock_slowpath(atomic_t *lock_cou
 	__mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, 0);
 }
 
-#ifdef CONFIG_PROVE_MUTEX_LOCKING
+#ifdef CONFIG_DEBUG_MUTEX_ALLOC
 void __sched
 mutex_lock_nested(struct mutex *lock, unsigned int subtype)
 {
Index: linux/kernel/mutex.h
===================================================================
--- linux.orig/kernel/mutex.h
+++ linux/kernel/mutex.h
@@ -24,7 +24,7 @@
 #define debug_mutex_free_waiter(waiter)			do { } while (0)
 #define debug_mutex_add_waiter(lock, waiter, ti)	do { } while (0)
 #define debug_mutex_unlock(lock)			do { } while (0)
-#define debug_mutex_init(lock, name)			do { } while (0)
+#define debug_mutex_init(lock, name, key)		do { } while (0)
 
 static inline void
 debug_mutex_lock_common(struct mutex *lock, struct mutex_waiter *waiter)
Index: linux/kernel/spinlock.c
===================================================================
--- linux.orig/kernel/spinlock.c
+++ linux/kernel/spinlock.c
@@ -17,44 +17,6 @@
 #include <linux/debug_locks.h>
 #include <linux/module.h>
 
-#if defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PROVE_SPIN_LOCKING)
-void __spin_lock_init(spinlock_t *lock, const char *name,
-		      struct lockdep_type_key *key)
-{
-	lock->raw_lock = (raw_spinlock_t)__RAW_SPIN_LOCK_UNLOCKED;
-#ifdef CONFIG_DEBUG_SPINLOCK
-	lock->magic = SPINLOCK_MAGIC;
-	lock->owner = SPINLOCK_OWNER_INIT;
-	lock->owner_cpu = -1;
-#endif
-#ifdef CONFIG_PROVE_SPIN_LOCKING
-	lockdep_init_map(&lock->dep_map, name, key);
-#endif
-}
-
-EXPORT_SYMBOL(__spin_lock_init);
-
-#endif
-
-#if defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PROVE_RW_LOCKING)
-
-void __rwlock_init(rwlock_t *lock, const char *name,
-		   struct lockdep_type_key *key)
-{
-	lock->raw_lock = (raw_rwlock_t) __RAW_RW_LOCK_UNLOCKED;
-#ifdef CONFIG_DEBUG_SPINLOCK
-	lock->magic = RWLOCK_MAGIC;
-	lock->owner = SPINLOCK_OWNER_INIT;
-	lock->owner_cpu = -1;
-#endif
-#ifdef CONFIG_PROVE_RW_LOCKING
-	lockdep_init_map(&lock->dep_map, name, key);
-#endif
-}
-
-EXPORT_SYMBOL(__rwlock_init);
-
-#endif
 /*
  * Generic declaration of the raw read_trylock() function,
  * architectures are supposed to optimize this:
Index: linux/lib/Kconfig.debug
===================================================================
--- linux.orig/lib/Kconfig.debug
+++ linux/lib/Kconfig.debug
@@ -146,24 +146,6 @@ config DEBUG_PREEMPT
 	  if kernel code uses it in a preemption-unsafe way. Also, the kernel
 	  will detect preemption count underflows.
 
-config DEBUG_MUTEXES
-	bool "Mutex debugging, basic checks"
-	default y
-	depends on DEBUG_KERNEL
-	help
-	 This feature allows mutex semantics violations to be detected and
-	 reported.
-
-config DEBUG_MUTEX_ALLOC
-	bool "Detect incorrect freeing of live mutexes"
-	default y
-	depends on DEBUG_MUTEXES
-	help
-	 This feature will check whether any held mutex is incorrectly
-	 freed by the kernel, via any of the memory-freeing routines
-	 (kfree(), kmem_cache_free(), free_pages(), vfree(), etc.),
-	 or whether there is any lock held during task exit.
-
 config DEBUG_RT_MUTEXES
 	bool "RT Mutex debugging, deadlock detection"
 	default y
@@ -185,7 +167,7 @@ config RT_MUTEX_TESTER
 	  This option enables a rt-mutex tester.
 
 config DEBUG_SPINLOCK
-	bool "Spinlock debugging"
+	bool "Spinlock and rw-lock debugging: basic checks"
 	depends on DEBUG_KERNEL
 	help
 	  Say Y here and build SMP to catch missing spinlock initialization
@@ -193,9 +175,20 @@ config DEBUG_SPINLOCK
 	  best used in conjunction with the NMI watchdog so that spinlock
 	  deadlocks are also debuggable.
 
+config DEBUG_SPINLOCK_ALLOC
+	bool "Spinlock debugging: detect incorrect freeing of live spinlocks"
+	depends on DEBUG_SPINLOCK
+	select LOCKDEP
+	help
+	 This feature will check whether any held spinlock is incorrectly
+	 freed by the kernel, via any of the memory-freeing routines
+	 (kfree(), kmem_cache_free(), free_pages(), vfree(), etc.),
+	 whether a live spinlock is being reinitialized via spin_lock_init(),
+	 or whether there is any spinlock held during task exit.
+
 config PROVE_SPIN_LOCKING
-	bool "Prove spin-locking correctness"
-	depends on TRACE_IRQFLAGS_SUPPORT
+	bool "Spinlock debugging: prove spin-locking correctness"
+	depends on TRACE_IRQFLAGS_SUPPORT && DEBUG_SPINLOCK_ALLOC
 	default n
 	help
 	 This feature enables the kernel to prove that all spinlock
@@ -231,9 +224,20 @@ config PROVE_SPIN_LOCKING
 
 	 For more details, see Documentation/locking-correctness.txt.
 
+config DEBUG_RWLOCK_ALLOC
+	bool "rw-lock debugging: detect incorrect freeing of live rwlocks"
+	depends on DEBUG_SPINLOCK
+	select LOCKDEP
+	help
+	 This feature will check whether any held rwlock is incorrectly
+	 freed by the kernel, via any of the memory-freeing routines
+	 (kfree(), kmem_cache_free(), free_pages(), vfree(), etc.),
+	 whether a live rwlock is being reinitialized via rwlock_init(),
+	 or whether there is any rwlock held during task exit.
+
 config PROVE_RW_LOCKING
-	bool "Prove rw-locking correctness"
-	depends on TRACE_IRQFLAGS_SUPPORT
+	bool "rw-lock debugging: prove rw-locking correctness"
+	depends on TRACE_IRQFLAGS_SUPPORT && DEBUG_RWLOCK_ALLOC
 	default n
 	help
 	 This feature enables the kernel to prove that all rwlock
@@ -269,9 +273,28 @@ config PROVE_RW_LOCKING
 
 	 For more details, see Documentation/locking-correctness.txt.
 
+config DEBUG_MUTEXES
+	bool "Mutex debugging: basic checks"
+	default y
+	depends on DEBUG_KERNEL
+	help
+	 This feature allows mutex semantics violations to be detected and
+	 reported.
+
+config DEBUG_MUTEX_ALLOC
+	bool "Mutex debugging: detect incorrect freeing of live mutexes"
+	depends on DEBUG_MUTEXES
+	select LOCKDEP
+	help
+	 This feature will check whether any held mutex is incorrectly
+	 freed by the kernel, via any of the memory-freeing routines
+	 (kfree(), kmem_cache_free(), free_pages(), vfree(), etc.),
+	 whether a live mutex is being reinitialized via mutex_init(),
+	 or whether there is any mutex held during task exit.
+
 config PROVE_MUTEX_LOCKING
-	bool "Prove mutex-locking correctness"
-	depends on TRACE_IRQFLAGS_SUPPORT
+	bool "Mutex debugging: prove mutex-locking correctness"
+	depends on DEBUG_MUTEX_ALLOC
 	default n
 	help
 	 This feature enables the kernel to prove that all mutexlock
@@ -307,9 +330,27 @@ config PROVE_MUTEX_LOCKING
 
 	 For more details, see Documentation/locking-correctness.txt.
 
+config DEBUG_RWSEMS
+	bool "rwsem debugging: basic checks"
+	depends on DEBUG_KERNEL
+	help
+	 This feature allows read-write semaphore semantics violations to
+	 be detected and reported.
+
+config DEBUG_RWSEM_ALLOC
+	bool "rwsem debugging: detect incorrect freeing of live rwsems"
+	depends on DEBUG_RWSEMS
+	select LOCKDEP
+	help
+	 This feature will check whether any held rwsem is incorrectly
+	 freed by the kernel, via any of the memory-freeing routines
+	 (kfree(), kmem_cache_free(), free_pages(), vfree(), etc.),
+	 whether a live rwsem is being reinitialized via init_rwsem(),
+	 or whether there is any rwsem held during task exit.
+
 config PROVE_RWSEM_LOCKING
 	bool "Prove rwsem-locking correctness"
-	depends on TRACE_IRQFLAGS_SUPPORT
+	depends on DEBUG_RWSEM_ALLOC
 	default n
 	help
 	 This feature enables the kernel to prove that all rwsemlock
@@ -347,11 +388,9 @@ config PROVE_RWSEM_LOCKING
 
 config LOCKDEP
 	bool
-	default y
 	select FRAME_POINTER
 	select KALLSYMS
 	select KALLSYMS_ALL
-	depends on PROVE_SPIN_LOCKING || PROVE_RW_LOCKING || PROVE_MUTEX_LOCKING || PROVE_RWSEM_LOCKING
 
 config DEBUG_NON_NESTED_UNLOCKS
 	bool "Detect non-nested unlocks"
@@ -370,7 +409,6 @@ config DEBUG_LOCKDEP
 	bool "Lock dependency engine debugging"
 	depends on LOCKDEP
 	default y
-	depends on TRACE_IRQFLAGS_SUPPORT
 	help
 	  If you say Y here, the lock dependency engine will do
 	  additional runtime checks to debug itself, at the price
@@ -383,7 +421,7 @@ config TRACE_IRQFLAGS
 	depends on PROVE_SPIN_LOCKING || PROVE_RW_LOCKING
 
 config DEBUG_SPINLOCK_SLEEP
-	bool "Sleep-inside-spinlock checking"
+	bool "Spinlock debugging: sleep-inside-spinlock checking"
 	depends on DEBUG_KERNEL
 	help
 	  If you say Y here, various routines which may sleep will become very
Index: linux/lib/locking-selftest-mutex.h
===================================================================
--- linux.orig/lib/locking-selftest-mutex.h
+++ linux/lib/locking-selftest-mutex.h
@@ -3,3 +3,9 @@
 
 #undef UNLOCK
 #define UNLOCK		MU
+
+#undef RLOCK
+#undef WLOCK
+
+#undef INIT
+#define INIT		MI
Index: linux/lib/locking-selftest-rlock.h
===================================================================
--- linux.orig/lib/locking-selftest-rlock.h
+++ linux/lib/locking-selftest-rlock.h
@@ -3,3 +3,12 @@
 
 #undef UNLOCK
 #define UNLOCK		RU
+
+#undef RLOCK
+#define RLOCK		RL
+
+#undef WLOCK
+#define WLOCK		WL
+
+#undef INIT
+#define INIT		RWI
Index: linux/lib/locking-selftest-rsem.h
===================================================================
--- linux.orig/lib/locking-selftest-rsem.h
+++ linux/lib/locking-selftest-rsem.h
@@ -3,3 +3,12 @@
 
 #undef UNLOCK
 #define UNLOCK		RSU
+
+#undef RLOCK
+#define RLOCK		RSL
+
+#undef WLOCK
+#define WLOCK		WSL
+
+#undef INIT
+#define INIT		RWSI
Index: linux/lib/locking-selftest-spin.h
===================================================================
--- linux.orig/lib/locking-selftest-spin.h
+++ linux/lib/locking-selftest-spin.h
@@ -3,3 +3,9 @@
 
 #undef UNLOCK
 #define UNLOCK		U
+
+#undef RLOCK
+#undef WLOCK
+
+#undef INIT
+#define INIT		SI
Index: linux/lib/locking-selftest-wlock.h
===================================================================
--- linux.orig/lib/locking-selftest-wlock.h
+++ linux/lib/locking-selftest-wlock.h
@@ -3,3 +3,12 @@
 
 #undef UNLOCK
 #define UNLOCK		WU
+
+#undef RLOCK
+#define RLOCK		RL
+
+#undef WLOCK
+#define WLOCK		WL
+
+#undef INIT
+#define INIT		RWI
Index: linux/lib/locking-selftest-wsem.h
===================================================================
--- linux.orig/lib/locking-selftest-wsem.h
+++ linux/lib/locking-selftest-wsem.h
@@ -3,3 +3,12 @@
 
 #undef UNLOCK
 #define UNLOCK		WSU
+
+#undef RLOCK
+#define RLOCK		RSL
+
+#undef WLOCK
+#define WLOCK		WSL
+
+#undef INIT
+#define INIT		RWSI
Index: linux/lib/locking-selftest.c
===================================================================
--- linux.orig/lib/locking-selftest.c
+++ linux/lib/locking-selftest.c
@@ -173,6 +173,7 @@ static void init_shared_types(void)
 #define U(x)			spin_unlock(&lock_##x)
 #define UNN(x)			spin_unlock_non_nested(&lock_##x)
 #define LU(x)			L(x); U(x)
+#define SI(x)			spin_lock_init(&lock_##x)
 
 #define WL(x)			write_lock(&rwlock_##x)
 #define WU(x)			write_unlock(&rwlock_##x)
@@ -182,10 +183,12 @@ static void init_shared_types(void)
 #define RU(x)			read_unlock(&rwlock_##x)
 #define RUNN(x)			read_unlock_non_nested(&rwlock_##x)
 #define RLU(x)			RL(x); RU(x)
+#define RWI(x)			rwlock_init(&rwlock_##x)
 
 #define ML(x)			mutex_lock(&mutex_##x)
 #define MU(x)			mutex_unlock(&mutex_##x)
 #define MUNN(x)			mutex_unlock_non_nested(&mutex_##x)
+#define MI(x)			mutex_init(&mutex_##x)
 
 #define WSL(x)			down_write(&rwsem_##x)
 #define WSU(x)			up_write(&rwsem_##x)
@@ -193,6 +196,7 @@ static void init_shared_types(void)
 #define RSL(x)			down_read(&rwsem_##x)
 #define RSU(x)			up_read(&rwsem_##x)
 #define RSUNN(x)		up_read_non_nested(&rwsem_##x)
+#define RWSI(x)			init_rwsem(&rwsem_##x)
 
 #define LOCK_UNLOCK_2(x,y)	LOCK(x); LOCK(y); UNLOCK(y); UNLOCK(x)
 
@@ -226,9 +230,7 @@ static void name##_321(void) { E3(); E2(
 #define E()					\
 						\
 	LOCK(X1);				\
-	LOCK(X2); /* this one should fail */	\
-	UNLOCK(X2);				\
-	UNLOCK(X1);
+	LOCK(X2); /* this one should fail */
 
 /*
  * 6 testcases:
@@ -256,16 +258,50 @@ static void rlock_AA1(void)
 {
 	RL(X1);
 	RL(X1); // this one should NOT fail
-	RU(X1);
-	RU(X1);
+}
+
+static void rlock_AA1B(void)
+{
+	RL(X1);
+	RL(X2); // this one should fail
 }
 
 static void rsem_AA1(void)
 {
 	RSL(X1);
 	RSL(X1); // this one should fail
-	RSU(X1);
-	RSU(X1);
+}
+
+static void rsem_AA1B(void)
+{
+	RSL(X1);
+	RSL(X2); // this one should fail
+}
+/*
+ * The mixing of read and write locks is not allowed:
+ */
+static void rlock_AA2(void)
+{
+	RL(X1);
+	WL(X2); // this one should fail
+}
+
+static void rsem_AA2(void)
+{
+	RSL(X1);
+	WSL(X2); // this one should fail
+}
+
+static void rlock_AA3(void)
+{
+	WL(X1);
+	RL(X2); // this one should fail
+}
+
+static void rsem_AA3(void)
+{
+	WSL(X1);
+	RSL(X2); // this one should fail
 }
 
 /*
@@ -491,6 +527,32 @@ GENERATE_TESTCASE(bad_unlock_order_rsem)
 
 #undef E
 
+/*
+ * initializing a held lock:
+ */
+#define E()					\
+						\
+	LOCK(A);				\
+	INIT(A); /* fail */
+
+/*
+ * 6 testcases:
+ */
+#include "locking-selftest-spin.h"
+GENERATE_TESTCASE(init_held_spin)
+#include "locking-selftest-wlock.h"
+GENERATE_TESTCASE(init_held_wlock)
+#include "locking-selftest-rlock.h"
+GENERATE_TESTCASE(init_held_rlock)
+#include "locking-selftest-mutex.h"
+GENERATE_TESTCASE(init_held_mutex)
+#include "locking-selftest-wsem.h"
+GENERATE_TESTCASE(init_held_wsem)
+#include "locking-selftest-rsem.h"
+GENERATE_TESTCASE(init_held_rsem)
+
+#undef E
+
 #ifdef CONFIG_LOCKDEP
 /*
  * bad unlock ordering - but using the _non_nested API,
@@ -871,25 +933,25 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_read_
 #include "locking-selftest-softirq.h"
 // GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion2_soft)
 
-#ifdef CONFIG_PROVE_SPIN_LOCKING
+#ifdef CONFIG_DEBUG_SPINLOCK_ALLOC
 # define I_SPINLOCK(x)	lockdep_reset_lock(&lock_##x.dep_map)
 #else
 # define I_SPINLOCK(x)
 #endif
 
-#ifdef CONFIG_PROVE_RW_LOCKING
+#ifdef CONFIG_DEBUG_RWLOCK_ALLOC
 # define I_RWLOCK(x)	lockdep_reset_lock(&rwlock_##x.dep_map)
 #else
 # define I_RWLOCK(x)
 #endif
 
-#ifdef CONFIG_PROVE_MUTEX_LOCKING
+#ifdef CONFIG_DEBUG_MUTEX_ALLOC
 # define I_MUTEX(x)	lockdep_reset_lock(&mutex_##x.dep_map)
 #else
 # define I_MUTEX(x)
 #endif
 
-#ifdef CONFIG_PROVE_RWSEM_LOCKING
+#ifdef CONFIG_DEBUG_RWSEM_ALLOC
 # define I_RWSEM(x)	lockdep_reset_lock(&rwsem_##x.dep_map)
 #else
 # define I_RWSEM(x)
@@ -1139,6 +1201,7 @@ void locking_selftest(void)
 	DO_TESTCASE_6R("A-B-C-D-B-D-D-A deadlock", ABCDBDDA);
 	DO_TESTCASE_6R("A-B-C-D-B-C-D-A deadlock", ABCDBCDA);
 	DO_TESTCASE_6("double unlock", double_unlock);
+	DO_TESTCASE_6("initialize held", init_held);
 #ifdef CONFIG_DEBUG_NON_NESTED_UNLOCKS
 	DO_TESTCASE_6("bad unlock order", bad_unlock_order);
 #else
@@ -1153,8 +1216,30 @@ void locking_selftest(void)
 	dotest(rsem_AA1, FAILURE, LOCKTYPE_RWSEM);
 	printk("\n");
 
+	print_testname("recursive read-lock #2");
+	printk("             |");
+	dotest(rlock_AA1B, FAILURE, LOCKTYPE_RWLOCK);
+	printk("             |");
+	dotest(rsem_AA1B, FAILURE, LOCKTYPE_RWSEM);
+	printk("\n");
+
+	print_testname("mixed read-write-lock");
+	printk("             |");
+	dotest(rlock_AA2, FAILURE, LOCKTYPE_RWLOCK);
+	printk("             |");
+	dotest(rsem_AA2, FAILURE, LOCKTYPE_RWSEM);
+	printk("\n");
+
+	print_testname("mixed write-read-lock");
+	printk("             |");
+	dotest(rlock_AA3, FAILURE, LOCKTYPE_RWLOCK);
+	printk("             |");
+	dotest(rsem_AA3, FAILURE, LOCKTYPE_RWSEM);
+	printk("\n");
+
 	printk("  --------------------------------------------------------------------------\n");
 
+
 #ifdef CONFIG_LOCKDEP
 	print_testname("non-nested unlock");
 	dotest(spin_order_nn, SUCCESS, LOCKTYPE_SPIN);
Index: linux/lib/rwsem-spinlock.c
===================================================================
--- linux.orig/lib/rwsem-spinlock.c
+++ linux/lib/rwsem-spinlock.c
@@ -33,15 +33,19 @@ void rwsemtrace(struct rw_semaphore *sem
 void __init_rwsem(struct rw_semaphore *sem, const char *name,
 		  struct lockdep_type_key *key)
 {
+#ifdef CONFIG_DEBUG_RWSEM_ALLOC
+	/*
+	 * Make sure we are not reinitializing a held semaphore:
+	 */
+	debug_check_no_locks_freed((void *)sem, sizeof(*sem));
+	lockdep_init_map(&sem->dep_map, name, key);
+#endif
 	sem->activity = 0;
 	spin_lock_init(&sem->wait_lock);
 	INIT_LIST_HEAD(&sem->wait_list);
 #if RWSEM_DEBUG
 	sem->debug = 0;
 #endif
-#ifdef CONFIG_PROVE_RWSEM_LOCKING
-	lockdep_init_map(&sem->dep_map, name, key);
-#endif
 }
 
 /*
Index: linux/lib/rwsem.c
===================================================================
--- linux.orig/lib/rwsem.c
+++ linux/lib/rwsem.c
@@ -14,15 +14,19 @@
 void __init_rwsem(struct rw_semaphore *sem, const char *name,
 		  struct lockdep_type_key *key)
 {
+#ifdef CONFIG_DEBUG_RWSEM_ALLOC
+	/*
+	 * Make sure we are not reinitializing a held semaphore:
+	 */
+	debug_check_no_locks_freed((void *)sem, sizeof(*sem));
+	lockdep_init_map(&sem->dep_map, name, key);
+#endif
 	sem->count = RWSEM_UNLOCKED_VALUE;
 	spin_lock_init(&sem->wait_lock);
 	INIT_LIST_HEAD(&sem->wait_list);
 #if RWSEM_DEBUG
 	sem->debug = 0;
 #endif
-#ifdef CONFIG_PROVE_RWSEM_LOCKING
-	lockdep_init_map(&sem->dep_map, name, key);
-#endif
 }
 
 EXPORT_SYMBOL(__init_rwsem);
Index: linux/lib/spinlock_debug.c
===================================================================
--- linux.orig/lib/spinlock_debug.c
+++ linux/lib/spinlock_debug.c
@@ -13,6 +13,42 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 
+void __spin_lock_init(spinlock_t *lock, const char *name,
+		      struct lockdep_type_key *key)
+{
+#ifdef CONFIG_DEBUG_SPINLOCK_ALLOC
+	/*
+	 * Make sure we are not reinitializing a held lock:
+	 */
+	debug_check_no_locks_freed((void *)lock, sizeof(*lock));
+	lockdep_init_map(&lock->dep_map, name, key);
+#endif
+	lock->raw_lock = (raw_spinlock_t)__RAW_SPIN_LOCK_UNLOCKED;
+	lock->magic = SPINLOCK_MAGIC;
+	lock->owner = SPINLOCK_OWNER_INIT;
+	lock->owner_cpu = -1;
+}
+
+EXPORT_SYMBOL(__spin_lock_init);
+
+void __rwlock_init(rwlock_t *lock, const char *name,
+		   struct lockdep_type_key *key)
+{
+#ifdef CONFIG_DEBUG_RWLOCK_ALLOC
+	/*
+	 * Make sure we are not reinitializing a held lock:
+	 */
+	debug_check_no_locks_freed((void *)lock, sizeof(*lock));
+	lockdep_init_map(&lock->dep_map, name, key);
+#endif
+	lock->raw_lock = (raw_rwlock_t) __RAW_RW_LOCK_UNLOCKED;
+	lock->magic = RWLOCK_MAGIC;
+	lock->owner = SPINLOCK_OWNER_INIT;
+	lock->owner_cpu = -1;
+}
+
+EXPORT_SYMBOL(__rwlock_init);
+
 static void spin_bug(spinlock_t *lock, const char *msg)
 {
 	struct task_struct *owner = NULL;
