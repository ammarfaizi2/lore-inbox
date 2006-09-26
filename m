Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbWIZLvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWIZLvl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 07:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWIZLvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 07:51:41 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:49301 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751160AbWIZLvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 07:51:40 -0400
Message-Id: <20060926113748.089037000@chello.nl>
References: <20060926113150.294656000@chello.nl>
User-Agent: quilt/0.45-1
Date: Tue, 26 Sep 2006 13:31:51 +0200
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org
Cc: Jiri Kosina <jikos@jikos.cz>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 1/2] lockdep: lockdep_set_class_and_subclass
Content-Disposition: inline; filename=lockdep-init-subclass.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add lockdep_set_class_and_subclass() to the lockdep annotations.

This annotation makes it possible to assign a subclass on lock init. This
annotation is meant to reduce the _nested() annotations by assigning a
default subclass.

One could do without this annotation and rely on lockdep_set_class()
exclusively, but that would require a manual stack of struct lock_class_key
objects.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 include/linux/lockdep.h |   12 ++++++++----
 kernel/lockdep.c        |   10 ++++++----
 kernel/mutex-debug.c    |    2 +-
 lib/rwsem-spinlock.c    |    2 +-
 lib/rwsem.c             |    2 +-
 lib/spinlock_debug.c    |    4 ++--
 net/core/sock.c         |    2 +-
 7 files changed, 20 insertions(+), 14 deletions(-)

Index: linux-2.6-mm/include/linux/lockdep.h
===================================================================
--- linux-2.6-mm.orig/include/linux/lockdep.h	2006-09-26 11:05:29.000000000 +0200
+++ linux-2.6-mm/include/linux/lockdep.h	2006-09-26 13:10:40.000000000 +0200
@@ -202,7 +202,7 @@ extern int lockdep_internal(void);
  */
 
 extern void lockdep_init_map(struct lockdep_map *lock, const char *name,
-			     struct lock_class_key *key);
+			     struct lock_class_key *key, int subclass);
 
 /*
  * Reinitialize a lock key - for cases where there is special locking or
@@ -211,9 +211,11 @@ extern void lockdep_init_map(struct lock
  * or they are too narrow (they suffer from a false class-split):
  */
 #define lockdep_set_class(lock, key) \
-		lockdep_init_map(&(lock)->dep_map, #key, key)
+		lockdep_init_map(&(lock)->dep_map, #key, key, 0)
 #define lockdep_set_class_and_name(lock, key, name) \
-		lockdep_init_map(&(lock)->dep_map, name, key)
+		lockdep_init_map(&(lock)->dep_map, name, key, 0)
+#define lockdep_set_class_and_subclass(lock, key, sub) \
+		lockdep_init_map(&(lock)->dep_map, #key, key, sub)
 
 /*
  * Acquire a lock.
@@ -257,10 +259,12 @@ static inline int lockdep_internal(void)
 # define lock_release(l, n, i)			do { } while (0)
 # define lockdep_init()				do { } while (0)
 # define lockdep_info()				do { } while (0)
-# define lockdep_init_map(lock, name, key)	do { (void)(key); } while (0)
+# define lockdep_init_map(lock, name, key, sub)	do { (void)(key); } while (0)
 # define lockdep_set_class(lock, key)		do { (void)(key); } while (0)
 # define lockdep_set_class_and_name(lock, key, name) \
 		do { (void)(key); } while (0)
+#define lockdep_set_class_and_subclass(lock, key, sub) \
+		do { (void)(key); } while (0)
 # define INIT_LOCKDEP
 # define lockdep_reset()		do { debug_locks = 1; } while (0)
 # define lockdep_free_key_range(start, size)	do { } while (0)
Index: linux-2.6-mm/kernel/lockdep.c
===================================================================
--- linux-2.6-mm.orig/kernel/lockdep.c	2006-09-26 11:05:29.000000000 +0200
+++ linux-2.6-mm/kernel/lockdep.c	2006-09-26 13:13:09.000000000 +0200
@@ -1177,7 +1177,7 @@ look_up_lock_class(struct lockdep_map *l
  * itself, so actual lookup of the hash should be once per lock object.
  */
 static inline struct lock_class *
-register_lock_class(struct lockdep_map *lock, unsigned int subclass)
+register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 {
 	struct lockdep_subclass_key *key;
 	struct list_head *hash_head;
@@ -1249,7 +1249,7 @@ register_lock_class(struct lockdep_map *
 out_unlock_set:
 	__raw_spin_unlock(&hash_lock);
 
-	if (!subclass)
+	if (!subclass || force)
 		lock->class_cache = class;
 
 	DEBUG_LOCKS_WARN_ON(class->subclass != subclass);
@@ -1937,7 +1937,7 @@ void trace_softirqs_off(unsigned long ip
  * Initialize a lock instance's lock-class mapping info:
  */
 void lockdep_init_map(struct lockdep_map *lock, const char *name,
-		      struct lock_class_key *key)
+		      struct lock_class_key *key, int subclass)
 {
 	if (unlikely(!debug_locks))
 		return;
@@ -1957,6 +1957,8 @@ void lockdep_init_map(struct lockdep_map
 	lock->name = name;
 	lock->key = key;
 	lock->class_cache = NULL;
+	if (subclass)
+		register_lock_class(lock, subclass, 1);
 }
 
 EXPORT_SYMBOL_GPL(lockdep_init_map);
@@ -1995,7 +1997,7 @@ static int __lock_acquire(struct lockdep
 	 * Not cached yet or subclass?
 	 */
 	if (unlikely(!class)) {
-		class = register_lock_class(lock, subclass);
+		class = register_lock_class(lock, subclass, 0);
 		if (!class)
 			return 0;
 	}
Index: linux-2.6-mm/kernel/mutex-debug.c
===================================================================
--- linux-2.6-mm.orig/kernel/mutex-debug.c	2006-09-26 11:05:29.000000000 +0200
+++ linux-2.6-mm/kernel/mutex-debug.c	2006-09-26 13:10:40.000000000 +0200
@@ -91,7 +91,7 @@ void debug_mutex_init(struct mutex *lock
 	 * Make sure we are not reinitializing a held lock:
 	 */
 	debug_check_no_locks_freed((void *)lock, sizeof(*lock));
-	lockdep_init_map(&lock->dep_map, name, key);
+	lockdep_init_map(&lock->dep_map, name, key, 0);
 #endif
 	lock->owner = NULL;
 	lock->magic = lock;
Index: linux-2.6-mm/lib/rwsem-spinlock.c
===================================================================
--- linux-2.6-mm.orig/lib/rwsem-spinlock.c	2006-09-26 11:05:29.000000000 +0200
+++ linux-2.6-mm/lib/rwsem-spinlock.c	2006-09-26 13:10:40.000000000 +0200
@@ -28,7 +28,7 @@ void __init_rwsem(struct rw_semaphore *s
 	 * Make sure we are not reinitializing a held semaphore:
 	 */
 	debug_check_no_locks_freed((void *)sem, sizeof(*sem));
-	lockdep_init_map(&sem->dep_map, name, key);
+	lockdep_init_map(&sem->dep_map, name, key, 0);
 #endif
 	sem->activity = 0;
 	spin_lock_init(&sem->wait_lock);
Index: linux-2.6-mm/lib/rwsem.c
===================================================================
--- linux-2.6-mm.orig/lib/rwsem.c	2006-09-26 11:05:29.000000000 +0200
+++ linux-2.6-mm/lib/rwsem.c	2006-09-26 13:10:40.000000000 +0200
@@ -19,7 +19,7 @@ void __init_rwsem(struct rw_semaphore *s
 	 * Make sure we are not reinitializing a held semaphore:
 	 */
 	debug_check_no_locks_freed((void *)sem, sizeof(*sem));
-	lockdep_init_map(&sem->dep_map, name, key);
+	lockdep_init_map(&sem->dep_map, name, key, 0);
 #endif
 	sem->count = RWSEM_UNLOCKED_VALUE;
 	spin_lock_init(&sem->wait_lock);
Index: linux-2.6-mm/lib/spinlock_debug.c
===================================================================
--- linux-2.6-mm.orig/lib/spinlock_debug.c	2006-09-26 11:05:29.000000000 +0200
+++ linux-2.6-mm/lib/spinlock_debug.c	2006-09-26 13:10:40.000000000 +0200
@@ -20,7 +20,7 @@ void __spin_lock_init(spinlock_t *lock, 
 	 * Make sure we are not reinitializing a held lock:
 	 */
 	debug_check_no_locks_freed((void *)lock, sizeof(*lock));
-	lockdep_init_map(&lock->dep_map, name, key);
+	lockdep_init_map(&lock->dep_map, name, key, 0);
 #endif
 	lock->raw_lock = (raw_spinlock_t)__RAW_SPIN_LOCK_UNLOCKED;
 	lock->magic = SPINLOCK_MAGIC;
@@ -38,7 +38,7 @@ void __rwlock_init(rwlock_t *lock, const
 	 * Make sure we are not reinitializing a held lock:
 	 */
 	debug_check_no_locks_freed((void *)lock, sizeof(*lock));
-	lockdep_init_map(&lock->dep_map, name, key);
+	lockdep_init_map(&lock->dep_map, name, key, 0);
 #endif
 	lock->raw_lock = (raw_rwlock_t) __RAW_RW_LOCK_UNLOCKED;
 	lock->magic = RWLOCK_MAGIC;
Index: linux-2.6-mm/net/core/sock.c
===================================================================
--- linux-2.6-mm.orig/net/core/sock.c	2006-09-26 11:05:29.000000000 +0200
+++ linux-2.6-mm/net/core/sock.c	2006-09-26 13:10:40.000000000 +0200
@@ -823,7 +823,7 @@ static void inline sock_lock_init(struct
 				   af_family_slock_key_strings[sk->sk_family]);
 	lockdep_init_map(&sk->sk_lock.dep_map,
 			 af_family_key_strings[sk->sk_family],
-			 af_family_keys + sk->sk_family);
+			 af_family_keys + sk->sk_family, 0);
 }
 
 /**

--

