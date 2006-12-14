Return-Path: <linux-kernel-owner+w=401wt.eu-S932722AbWLNNke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932722AbWLNNke (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 08:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932721AbWLNNke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 08:40:34 -0500
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:59375
	"EHLO gnuppy.monkey.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932720AbWLNNkd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 08:40:33 -0500
X-Greylist: delayed 317 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 08:40:32 EST
Date: Thu, 14 Dec 2006 05:40:27 -0800
To: Ingo Molnar <mingo@elte.hu>
Cc: Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel@vger.kernel.org,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: [PATCH 3/5] lock stat kills lock meter for -rt (.h files)
Message-ID: <20061214134026.GC22194@gnuppy.monkey.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="4ZLFUWh1odzi/v6L"
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Containes .h file changes.

bill


--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="hfiles.diff"

============================================================
--- include/linux/mutex.h	d231debc2848a8344e1b04055ef22e489702e648
+++ include/linux/mutex.h	734c89362a3d77d460eb20eec3107e7b76fed938
@@ -15,6 +15,7 @@
 #include <linux/rt_lock.h>
 #include <linux/linkage.h>
 #include <linux/lockdep.h>
+#include <linux/lock_stat.h>
 
 #include <asm/atomic.h>
 
@@ -35,7 +36,8 @@ extern void
 	}
 
 extern void
-_mutex_init(struct mutex *lock, char *name, struct lock_class_key *key);
+_mutex_init(struct mutex *lock, char *name, struct lock_class_key *key
+					__COMMA_LOCK_STAT_NOTE_PARAM_DECL);
 
 extern void __lockfunc _mutex_lock(struct mutex *lock);
 extern int __lockfunc _mutex_lock_interruptible(struct mutex *lock);
@@ -56,11 +58,15 @@ extern void __lockfunc _mutex_unlock(str
 # define mutex_lock_nested(l, s)	_mutex_lock(l)
 #endif
 
+#define __mutex_init(l,n)		__rt_mutex_init(&(l)->mutex,	\
+					n				\
+					__COMMA_LOCK_STAT_NOTE)
+
 # define mutex_init(mutex)				\
 do {							\
 	static struct lock_class_key __key;		\
 							\
-	_mutex_init((mutex), #mutex, &__key);		\
+	_mutex_init((mutex), #mutex, &__key __COMMA_LOCK_STAT_NOTE);	\
 } while (0)
 
 #else
============================================================
--- include/linux/rt_lock.h	d7515027865666075d3e285bcec8c36e9b6cfc47
+++ include/linux/rt_lock.h	297792307de5b4aef2c7e472e2a32c727e5de3f1
@@ -13,6 +13,7 @@
 #include <linux/rtmutex.h>
 #include <asm/atomic.h>
 #include <linux/spinlock_types.h>
+#include <linux/lock_stat.h>
 
 #ifdef CONFIG_PREEMPT_RT
 /*
@@ -28,8 +29,8 @@ typedef struct {
 
 #ifdef CONFIG_DEBUG_RT_MUTEXES
 # define __SPIN_LOCK_UNLOCKED(name) \
-	(spinlock_t) { { .wait_lock = _RAW_SPIN_LOCK_UNLOCKED(name) \
-	, .save_state = 1, .file = __FILE__, .line = __LINE__ } }
+	(spinlock_t) { .lock = { .wait_lock = _RAW_SPIN_LOCK_UNLOCKED(name) \
+	, .save_state = 1, .file = __FILE__, .line = __LINE__ __COMMA_LOCK_STAT_INITIALIZER} }
 #else
 # define __SPIN_LOCK_UNLOCKED(name) \
 	(spinlock_t) { { .wait_lock = _RAW_SPIN_LOCK_UNLOCKED(name) } }
@@ -92,7 +93,7 @@ typedef struct {
 # ifdef CONFIG_DEBUG_RT_MUTEXES
 #  define __RW_LOCK_UNLOCKED(name) (rwlock_t) \
 	{ .lock = { .wait_lock = _RAW_SPIN_LOCK_UNLOCKED(name), \
-	 .save_state = 1, .file = __FILE__, .line = __LINE__ } }
+	 .save_state = 1, .file = __FILE__, .line = __LINE__ __COMMA_LOCK_STAT_INITIALIZER } }
 # else
 #  define __RW_LOCK_UNLOCKED(name) (rwlock_t) \
 	{ .lock = { .wait_lock = _RAW_SPIN_LOCK_UNLOCKED(name) } }
@@ -139,14 +140,16 @@ struct semaphore name = \
  */
 #define DECLARE_MUTEX_LOCKED COMPAT_DECLARE_MUTEX_LOCKED
 
-extern void fastcall __sema_init(struct semaphore *sem, int val, char *name, char *file, int line);
+extern void fastcall __sema_init(struct semaphore *sem, int val, char *name
+				__COMMA_LOCK_STAT_FN_DECL, char *_file, int _line);
 
 #define rt_sema_init(sem, val) \
-		__sema_init(sem, val, #sem, __FILE__, __LINE__)
+		__sema_init(sem, val, #sem __COMMA_LOCK_STAT_NOTE_FN, __FILE__, __LINE__)
 
-extern void fastcall __init_MUTEX(struct semaphore *sem, char *name, char *file, int line);
+extern void fastcall __init_MUTEX(struct semaphore *sem, char *name
+				__COMMA_LOCK_STAT_FN_DECL, char *_file, int _line);
 #define rt_init_MUTEX(sem) \
-		__init_MUTEX(sem, #sem, __FILE__, __LINE__)
+		__init_MUTEX(sem, #sem __COMMA_LOCK_STAT_NOTE_FN, __FILE__, __LINE__)
 
 extern void there_is_no_init_MUTEX_LOCKED_for_RT_semaphores(void);
 
@@ -247,13 +250,14 @@ extern void fastcall __rt_rwsem_init(str
 	struct rw_semaphore lockname = __RWSEM_INITIALIZER(lockname)
 
 extern void fastcall __rt_rwsem_init(struct rw_semaphore *rwsem, char *name,
-				     struct lock_class_key *key);
+				     struct lock_class_key *key
+					__COMMA_LOCK_STAT_NOTE_PARAM_DECL);
 
 # define rt_init_rwsem(sem)				\
 do {							\
 	static struct lock_class_key __key;		\
 							\
-	__rt_rwsem_init((sem), #sem, &__key);		\
+	__rt_rwsem_init((sem), #sem, &__key __COMMA_LOCK_STAT_NOTE);		\
 } while (0)
 
 extern void fastcall rt_down_write(struct rw_semaphore *rwsem);
============================================================
--- include/linux/rtmutex.h	e6fa10297e6c20d27edba172aeb078a60c64488e
+++ include/linux/rtmutex.h	55cd2de44a52e049fa8a0da63bde6449cefeb8fe
@@ -15,6 +15,7 @@
 #include <linux/linkage.h>
 #include <linux/plist.h>
 #include <linux/spinlock_types.h>
+#include <linux/lock_stat.h>
 
 /*
  * The rt_mutex structure
@@ -33,6 +34,9 @@ struct rt_mutex {
 	int			line;
 	void			*magic;
 #endif
+#ifdef CONFIG_LOCK_STAT
+	struct lock_stat	*lock_stat;
+#endif
 };
 
 struct rt_mutex_waiter;
@@ -54,11 +58,13 @@ struct hrtimer_sleeper;
 #ifdef CONFIG_DEBUG_RT_MUTEXES
 # define __DEBUG_RT_MUTEX_INITIALIZER(mutexname) \
 	, .name = #mutexname, .file = __FILE__, .line = __LINE__
-# define rt_mutex_init(mutex)			__rt_mutex_init(mutex, __FUNCTION__)
+# define rt_mutex_init(mutex)		__rt_mutex_init(mutex, __FUNCTION__ \
+						__COMMA_LOCK_STAT_NOTE_DECL_FLLN)
  extern void rt_mutex_debug_task_free(struct task_struct *tsk);
 #else
 # define __DEBUG_RT_MUTEX_INITIALIZER(mutexname)
-# define rt_mutex_init(mutex)			__rt_mutex_init(mutex, NULL)
+# define rt_mutex_init(mutex)		__rt_mutex_init(mutex, NULL		\
+						__COMMA_LOCK_STAT_NOTE_DECL_FLLN)
 # define rt_mutex_debug_task_free(t)			do { } while (0)
 #endif
 
@@ -66,6 +72,7 @@ struct hrtimer_sleeper;
 	{ .wait_lock = RAW_SPIN_LOCK_UNLOCKED(mutexname) \
 	, .wait_list = PLIST_HEAD_INIT(mutexname.wait_list, mutexname.wait_lock) \
 	, .owner = NULL \
+	__COMMA_LOCK_STAT_INITIALIZER	\
 	__DEBUG_RT_MUTEX_INITIALIZER(mutexname)}
 
 #define DEFINE_RT_MUTEX(mutexname) \
@@ -82,10 +89,19 @@ static inline int rt_mutex_is_locked(str
 	return lock->owner != NULL;
 }
 
-extern void __rt_mutex_init(struct rt_mutex *lock, const char *name);
+extern void __rt_mutex_init(struct rt_mutex *lock,
+				const char *name
+				__COMMA_LOCK_STAT_NOTE_PARAM_DECL);
+#ifdef CONFIG_LOCK_STAT
+extern void __rt_mutex_init_annotated(struct rt_mutex *lock, const char *name,
+					LOCK_STAT_NOTE_PARAM_DECL,
+					struct lock_stat *lsobject);
+#endif
+
 extern void rt_mutex_destroy(struct rt_mutex *lock);
 
 extern void rt_mutex_lock(struct rt_mutex *lock);
+
 extern int rt_mutex_lock_interruptible(struct rt_mutex *lock,
 						int detect_deadlock);
 extern int rt_mutex_timed_lock(struct rt_mutex *lock,
@@ -96,6 +112,20 @@ extern void rt_mutex_unlock(struct rt_mu
 
 extern void rt_mutex_unlock(struct rt_mutex *lock);
 
+#ifdef CONFIG_LOCK_STAT
+extern void rt_mutex_lock_with_ip(struct rt_mutex *lock,
+					unsigned long ip);
+extern int rt_mutex_lock_interruptible_with_ip(struct rt_mutex *lock,
+						int detect_deadlock,
+						unsigned long ip);
+extern int rt_mutex_timed_lock_with_ip(struct rt_mutex *lock,
+					struct hrtimer_sleeper *timeout,
+					int detect_deadlock,
+					unsigned long ip);
+extern int rt_mutex_trylock_with_ip(struct rt_mutex *lock,
+					unsigned long ip);
+#endif
+
 #ifdef CONFIG_RT_MUTEXES
 # define INIT_RT_MUTEXES(tsk)						\
 	.pi_waiters	= PLIST_HEAD_INIT(tsk.pi_waiters, tsk.pi_lock),	\
============================================================
--- include/linux/spinlock.h	b4a4e821bac27625019dd765523d82f6e131f4b0
+++ include/linux/spinlock.h	23a6f3a945925fc935a3e21da2b244be61826feb
@@ -91,6 +91,7 @@
 #include <linux/stringify.h>
 #include <linux/bottom_half.h>
 #include <linux/irqflags.h>
+#include <linux/lock_stat.h>
 
 #include <asm/system.h>
 
@@ -153,8 +154,17 @@ extern void
 extern int __bad_rwlock_type(void);
 
 extern void
-__rt_spin_lock_init(spinlock_t *lock, char *name, struct lock_class_key *key);
+__rt_spin_lock_init(spinlock_t *lock, char *name, struct lock_class_key *key
+			__COMMA_LOCK_STAT_NOTE_PARAM_DECL);
 
+#ifdef CONFIG_LOCK_STAT
+extern void
+__rt_spin_lock_init_annotated(spinlock_t *lock, char *name,
+				struct lock_class_key *key,
+				LOCK_STAT_NOTE_PARAM_DECL,
+				struct lock_stat *lsobject);
+#endif
+
 extern void __lockfunc rt_spin_lock(spinlock_t *lock);
 extern void __lockfunc rt_spin_lock_nested(spinlock_t *lock, int subclass);
 extern void __lockfunc rt_spin_unlock(spinlock_t *lock);
@@ -171,6 +181,10 @@ extern void __lockfunc __rt_spin_unlock(
 extern void __lockfunc __rt_spin_lock(struct rt_mutex *lock);
 extern void __lockfunc __rt_spin_unlock(struct rt_mutex *lock);
 
+#ifdef CONFIG_LOCK_STAT
+extern void __lockfunc __rt_spin_lock_with_ip(struct rt_mutex *lock, unsigned long _ip);
+#endif
+
 #ifdef CONFIG_PREEMPT_RT
 # define _spin_lock(l)			rt_spin_lock(l)
 # define _spin_lock_nested(l, s)	rt_spin_lock_nested(l, s)
@@ -219,9 +233,18 @@ do {							\
 do {							\
 	static struct lock_class_key __key;		\
 							\
-	__rt_spin_lock_init(sl, n, &__key);		\
+	__rt_spin_lock_init(sl, n, &__key __COMMA_LOCK_STAT_NOTE);		\
 } while (0)
 
+#ifdef CONFIG_LOCK_STAT
+#define _spin_lock_init_annotated(sl, n, f, l, lsobj)	\
+do {							\
+	static struct lock_class_key __key;		\
+							\
+	__rt_spin_lock_init_annotated(sl, n, &__key, f, __func__, l, lsobj);		\
+} while (0)
+#endif
+
 # ifdef CONFIG_PREEMPT_RT
 #  define _spin_can_lock(l)		(!rt_mutex_is_locked(&(l)->lock))
 #  define _spin_is_locked(l)		rt_mutex_is_locked(&(l)->lock)
@@ -302,15 +325,31 @@ extern void
 extern unsigned long __lockfunc rt_write_lock_irqsave(rwlock_t *rwlock);
 extern unsigned long __lockfunc rt_read_lock_irqsave(rwlock_t *rwlock);
 extern void
-__rt_rwlock_init(rwlock_t *rwlock, char *name, struct lock_class_key *key);
+__rt_rwlock_init(rwlock_t *rwlock, char *name, struct lock_class_key *key
+					__COMMA_LOCK_STAT_NOTE_PARAM_DECL);
 
 #define _rwlock_init(rwl, n, f, l)			\
 do {							\
 	static struct lock_class_key __key;		\
 							\
-	__rt_rwlock_init(rwl, n, &__key);		\
+	__rt_rwlock_init(rwl, n, &__key __COMMA_LOCK_STAT_NOTE);		\
 } while (0)
 
+#ifdef CONFIG_LOCK_STAT
+extern void
+__rt_rwlock_init_annotated(rwlock_t *rwlock, char *name,
+				struct lock_class_key *key,
+				LOCK_STAT_NOTE_PARAM_DECL,
+				struct lock_stat *lsobject);
+
+#define _rwlock_init_annotated(rwl, n, f, l, lsobject)	\
+do {							\
+	static struct lock_class_key __key;		\
+							\
+	__rt_rwlock_init(rwl, n, &__key, LOCK_STAT_NOTE, lsobject);		\
+} while (0)
+#endif
+
 #ifdef CONFIG_PREEMPT_RT
 # define rt_read_can_lock(rwl)	(!rt_mutex_is_locked(&(rwl)->lock))
 # define rt_write_can_lock(rwl)	(!rt_mutex_is_locked(&(rwl)->lock))
@@ -428,6 +467,19 @@ do {									\
 
 #define spin_lock_init(lock)		PICK_OP_INIT(_lock_init, lock)
 
+#ifdef CONFIG_LOCK_STAT
+#define PICK_OP_INIT_ANNOTATED(op, lock, lsobj)				\
+do {									\
+	if (TYPE_EQUAL((lock), raw_spinlock_t))				\
+		_raw_spin##op((raw_spinlock_t *)(lock));		\
+	else if (TYPE_EQUAL(lock, spinlock_t))				\
+		_spin##op##_annotated((spinlock_t *)(lock), #lock, __FILE__, __LINE__, lsobj); \
+	else __bad_spinlock_type();					\
+} while (0)
+
+#define spin_lock_init_annotated(lock, lsobj)	PICK_OP_INIT_ANNOTATED(_lock_init, lock, lsobj)
+#endif
+
 #ifdef CONFIG_DEBUG_SPINLOCK
   extern void __raw_rwlock_init(raw_rwlock_t *lock, const char *name,
 				struct lock_class_key *key);

--4ZLFUWh1odzi/v6L--
