Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751388AbWE2ViG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbWE2ViG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWE2VZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:25:23 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:41656 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751327AbWE2VZA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:25:00 -0400
Date: Mon, 29 May 2006 23:25:18 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 26/61] lock validator: prove rwsem locking correctness
Message-ID: <20060529212518.GZ3155@elte.hu>
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

add CONFIG_PROVE_RWSEM_LOCKING, which uses the lock validator framework
to prove rwsem locking correctness.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 include/asm-i386/rwsem.h       |   38 +++++++++++++++++++--------
 include/linux/rwsem-spinlock.h |   23 +++++++++++++++-
 include/linux/rwsem.h          |   56 +++++++++++++++++++++++++++++++++++++++++
 lib/rwsem-spinlock.c           |   15 ++++++++--
 lib/rwsem.c                    |   19 +++++++++++++
 5 files changed, 135 insertions(+), 16 deletions(-)

Index: linux/include/asm-i386/rwsem.h
===================================================================
--- linux.orig/include/asm-i386/rwsem.h
+++ linux/include/asm-i386/rwsem.h
@@ -40,6 +40,7 @@
 
 #include <linux/list.h>
 #include <linux/spinlock.h>
+#include <linux/lockdep.h>
 
 struct rwsem_waiter;
 
@@ -64,6 +65,9 @@ struct rw_semaphore {
 #if RWSEM_DEBUG
 	int			debug;
 #endif
+#ifdef CONFIG_PROVE_RWSEM_LOCKING
+	struct lockdep_map dep_map;
+#endif
 };
 
 /*
@@ -75,22 +79,29 @@ struct rw_semaphore {
 #define __RWSEM_DEBUG_INIT	/* */
 #endif
 
+#ifdef CONFIG_PROVE_RWSEM_LOCKING
+# define __RWSEM_DEP_MAP_INIT(lockname) , .dep_map = { .name = #lockname }
+#else
+# define __RWSEM_DEP_MAP_INIT(lockname)
+#endif
+
+
 #define __RWSEM_INITIALIZER(name) \
 { RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, LIST_HEAD_INIT((name).wait_list) \
-	__RWSEM_DEBUG_INIT }
+	__RWSEM_DEBUG_INIT __RWSEM_DEP_MAP_INIT(name) }
 
 #define DECLARE_RWSEM(name) \
 	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
 
-static inline void init_rwsem(struct rw_semaphore *sem)
-{
-	sem->count = RWSEM_UNLOCKED_VALUE;
-	spin_lock_init(&sem->wait_lock);
-	INIT_LIST_HEAD(&sem->wait_list);
-#if RWSEM_DEBUG
-	sem->debug = 0;
-#endif
-}
+extern void __init_rwsem(struct rw_semaphore *sem, const char *name,
+			 struct lockdep_type_key *key);
+
+#define init_rwsem(sem)						\
+do {								\
+	static struct lockdep_type_key __key;			\
+								\
+	__init_rwsem((sem), #sem, &__key);			\
+} while (0)
 
 /*
  * lock for reading
@@ -143,7 +154,7 @@ LOCK_PREFIX	"  cmpxchgl  %2,%0\n\t"
 /*
  * lock for writing
  */
-static inline void __down_write(struct rw_semaphore *sem)
+static inline void __down_write_nested(struct rw_semaphore *sem, int subtype)
 {
 	int tmp;
 
@@ -167,6 +178,11 @@ LOCK_PREFIX	"  xadd      %%edx,(%%eax)\n
 		: "memory", "cc");
 }
 
+static inline void __down_write(struct rw_semaphore *sem)
+{
+	__down_write_nested(sem, 0);
+}
+
 /*
  * trylock for writing -- returns 1 if successful, 0 if contention
  */
Index: linux/include/linux/rwsem-spinlock.h
===================================================================
--- linux.orig/include/linux/rwsem-spinlock.h
+++ linux/include/linux/rwsem-spinlock.h
@@ -35,6 +35,9 @@ struct rw_semaphore {
 #if RWSEM_DEBUG
 	int			debug;
 #endif
+#ifdef CONFIG_PROVE_RWSEM_LOCKING
+	struct lockdep_map dep_map;
+#endif
 };
 
 /*
@@ -46,16 +49,32 @@ struct rw_semaphore {
 #define __RWSEM_DEBUG_INIT	/* */
 #endif
 
+#ifdef CONFIG_PROVE_RWSEM_LOCKING
+# define __RWSEM_DEP_MAP_INIT(lockname) , .dep_map = { .name = #lockname }
+#else
+# define __RWSEM_DEP_MAP_INIT(lockname)
+#endif
+
 #define __RWSEM_INITIALIZER(name) \
-{ 0, SPIN_LOCK_UNLOCKED, LIST_HEAD_INIT((name).wait_list) __RWSEM_DEBUG_INIT }
+{ 0, SPIN_LOCK_UNLOCKED, LIST_HEAD_INIT((name).wait_list) __RWSEM_DEBUG_INIT __RWSEM_DEP_MAP_INIT(name) }
 
 #define DECLARE_RWSEM(name) \
 	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
 
-extern void FASTCALL(init_rwsem(struct rw_semaphore *sem));
+extern void __init_rwsem(struct rw_semaphore *sem, const char *name,
+			 struct lockdep_type_key *key);
+
+#define init_rwsem(sem)						\
+do {								\
+	static struct lockdep_type_key __key;			\
+								\
+	__init_rwsem((sem), #sem, &__key);			\
+} while (0)
+
 extern void FASTCALL(__down_read(struct rw_semaphore *sem));
 extern int FASTCALL(__down_read_trylock(struct rw_semaphore *sem));
 extern void FASTCALL(__down_write(struct rw_semaphore *sem));
+extern void FASTCALL(__down_write_nested(struct rw_semaphore *sem, int subtype));
 extern int FASTCALL(__down_write_trylock(struct rw_semaphore *sem));
 extern void FASTCALL(__up_read(struct rw_semaphore *sem));
 extern void FASTCALL(__up_write(struct rw_semaphore *sem));
Index: linux/include/linux/rwsem.h
===================================================================
--- linux.orig/include/linux/rwsem.h
+++ linux/include/linux/rwsem.h
@@ -40,6 +40,20 @@ extern void FASTCALL(rwsemtrace(struct r
 static inline void down_read(struct rw_semaphore *sem)
 {
 	might_sleep();
+	rwsem_acquire_read(&sem->dep_map, 0, 0, _THIS_IP_);
+
+	rwsemtrace(sem,"Entering down_read");
+	__down_read(sem);
+	rwsemtrace(sem,"Leaving down_read");
+}
+
+/*
+ * Take a lock when not the owner will release it:
+ */
+static inline void down_read_non_owner(struct rw_semaphore *sem)
+{
+	might_sleep();
+
 	rwsemtrace(sem,"Entering down_read");
 	__down_read(sem);
 	rwsemtrace(sem,"Leaving down_read");
@@ -53,6 +67,8 @@ static inline int down_read_trylock(stru
 	int ret;
 	rwsemtrace(sem,"Entering down_read_trylock");
 	ret = __down_read_trylock(sem);
+	if (ret == 1)
+		rwsem_acquire_read(&sem->dep_map, 0, 1, _THIS_IP_);
 	rwsemtrace(sem,"Leaving down_read_trylock");
 	return ret;
 }
@@ -63,12 +79,28 @@ static inline int down_read_trylock(stru
 static inline void down_write(struct rw_semaphore *sem)
 {
 	might_sleep();
+	rwsem_acquire(&sem->dep_map, 0, 0, _THIS_IP_);
+
 	rwsemtrace(sem,"Entering down_write");
 	__down_write(sem);
 	rwsemtrace(sem,"Leaving down_write");
 }
 
 /*
+ * lock for writing
+ */
+static inline void down_write_nested(struct rw_semaphore *sem, int subtype)
+{
+	might_sleep();
+	rwsem_acquire(&sem->dep_map, subtype, 0, _THIS_IP_);
+
+	rwsemtrace(sem,"Entering down_write_nested");
+	__down_write_nested(sem, subtype);
+	rwsemtrace(sem,"Leaving down_write_nested");
+}
+
+
+/*
  * trylock for writing -- returns 1 if successful, 0 if contention
  */
 static inline int down_write_trylock(struct rw_semaphore *sem)
@@ -76,6 +108,8 @@ static inline int down_write_trylock(str
 	int ret;
 	rwsemtrace(sem,"Entering down_write_trylock");
 	ret = __down_write_trylock(sem);
+	if (ret == 1)
+		rwsem_acquire(&sem->dep_map, 0, 0, _THIS_IP_);
 	rwsemtrace(sem,"Leaving down_write_trylock");
 	return ret;
 }
@@ -85,16 +119,34 @@ static inline int down_write_trylock(str
  */
 static inline void up_read(struct rw_semaphore *sem)
 {
+	rwsem_release(&sem->dep_map, 1, _THIS_IP_);
+
 	rwsemtrace(sem,"Entering up_read");
 	__up_read(sem);
 	rwsemtrace(sem,"Leaving up_read");
 }
 
+static inline void up_read_non_nested(struct rw_semaphore *sem)
+{
+	rwsem_release(&sem->dep_map, 0, _THIS_IP_);
+	__up_read(sem);
+}
+
+/*
+ * Not the owner will release it:
+ */
+static inline void up_read_non_owner(struct rw_semaphore *sem)
+{
+	__up_read(sem);
+}
+
 /*
  * release a write lock
  */
 static inline void up_write(struct rw_semaphore *sem)
 {
+	rwsem_release(&sem->dep_map, 1, _THIS_IP_);
+
 	rwsemtrace(sem,"Entering up_write");
 	__up_write(sem);
 	rwsemtrace(sem,"Leaving up_write");
@@ -105,6 +157,10 @@ static inline void up_write(struct rw_se
  */
 static inline void downgrade_write(struct rw_semaphore *sem)
 {
+	/*
+	 * lockdep: a downgraded write will live on as a write
+	 * dependency.
+	 */
 	rwsemtrace(sem,"Entering downgrade_write");
 	__downgrade_write(sem);
 	rwsemtrace(sem,"Leaving downgrade_write");
Index: linux/lib/rwsem-spinlock.c
===================================================================
--- linux.orig/lib/rwsem-spinlock.c
+++ linux/lib/rwsem-spinlock.c
@@ -30,7 +30,8 @@ void rwsemtrace(struct rw_semaphore *sem
 /*
  * initialise the semaphore
  */
-void fastcall init_rwsem(struct rw_semaphore *sem)
+void __init_rwsem(struct rw_semaphore *sem, const char *name,
+		  struct lockdep_type_key *key)
 {
 	sem->activity = 0;
 	spin_lock_init(&sem->wait_lock);
@@ -38,6 +39,9 @@ void fastcall init_rwsem(struct rw_semap
 #if RWSEM_DEBUG
 	sem->debug = 0;
 #endif
+#ifdef CONFIG_PROVE_RWSEM_LOCKING
+	lockdep_init_map(&sem->dep_map, name, key);
+#endif
 }
 
 /*
@@ -204,7 +208,7 @@ int fastcall __down_read_trylock(struct 
  * get a write lock on the semaphore
  * - we increment the waiting count anyway to indicate an exclusive lock
  */
-void fastcall __sched __down_write(struct rw_semaphore *sem)
+void fastcall __sched __down_write_nested(struct rw_semaphore *sem, int subtype)
 {
 	struct rwsem_waiter waiter;
 	struct task_struct *tsk;
@@ -247,6 +251,11 @@ void fastcall __sched __down_write(struc
 	rwsemtrace(sem, "Leaving __down_write");
 }
 
+void fastcall __sched __down_write(struct rw_semaphore *sem)
+{
+	__down_write_nested(sem, 0);
+}
+
 /*
  * trylock for writing -- returns 1 if successful, 0 if contention
  */
@@ -331,7 +340,7 @@ void fastcall __downgrade_write(struct r
 	rwsemtrace(sem, "Leaving __downgrade_write");
 }
 
-EXPORT_SYMBOL(init_rwsem);
+EXPORT_SYMBOL(__init_rwsem);
 EXPORT_SYMBOL(__down_read);
 EXPORT_SYMBOL(__down_read_trylock);
 EXPORT_SYMBOL(__down_write);
Index: linux/lib/rwsem.c
===================================================================
--- linux.orig/lib/rwsem.c
+++ linux/lib/rwsem.c
@@ -8,6 +8,25 @@
 #include <linux/init.h>
 #include <linux/module.h>
 
+/*
+ * Initialize an rwsem:
+ */
+void __init_rwsem(struct rw_semaphore *sem, const char *name,
+		  struct lockdep_type_key *key)
+{
+	sem->count = RWSEM_UNLOCKED_VALUE;
+	spin_lock_init(&sem->wait_lock);
+	INIT_LIST_HEAD(&sem->wait_list);
+#if RWSEM_DEBUG
+	sem->debug = 0;
+#endif
+#ifdef CONFIG_PROVE_RWSEM_LOCKING
+	lockdep_init_map(&sem->dep_map, name, key);
+#endif
+}
+
+EXPORT_SYMBOL(__init_rwsem);
+
 struct rwsem_waiter {
 	struct list_head list;
 	struct task_struct *task;
