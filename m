Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267810AbUJNV5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267810AbUJNV5o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 17:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267783AbUJNV5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 17:57:12 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:16620 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S267818AbUJNVpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 17:45:22 -0400
Date: Thu, 14 Oct 2004 23:45:20 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] move semaphore definitions to waitlock_types.h
Message-ID: <Pine.LNX.4.61.0410142345020.29976@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This moves the definition and initializer of semaphore, rw_semaphore and
wait queue structures to waitlock_types.h.


 asm-alpha/rwsem.h              |   28 ----------------
 asm-alpha/semaphore.h          |   22 ------------
 asm-alpha/waitlock_types.h     |   60 ++++++++++++++++++++++++++++++++++
 asm-arm/semaphore.h            |   23 -------------
 asm-arm/waitlock_types.h       |   29 ++++++++++++++++
 asm-arm26/semaphore.h          |   24 -------------
 asm-arm26/waitlock_types.h     |   30 +++++++++++++++++
 asm-cris/semaphore.h           |   23 -------------
 asm-cris/waitlock_types.h      |   29 ++++++++++++++++
 asm-h8300/semaphore.h          |   26 ---------------
 asm-h8300/waitlock_types.h     |   32 ++++++++++++++++++
 asm-i386/rwsem.h               |   31 -----------------
 asm-i386/semaphore.h           |   35 +++-----------------
 asm-i386/waitlock_types.h      |   64 ++++++++++++++++++++++++++++++++++++
 asm-ia64/rwsem.h               |   33 -------------------
 asm-ia64/semaphore.h           |   23 -------------
 asm-ia64/waitlock_types.h      |   66 ++++++++++++++++++++++++++++++++++++++
 asm-m68k/semaphore.h           |   23 -------------
 asm-m68k/waitlock_types.h      |   29 ++++++++++++++++
 asm-m68knommu/semaphore.h      |   23 -------------
 asm-m68knommu/waitlock_types.h |   29 ++++++++++++++++
 asm-mips/semaphore.h           |   28 ----------------
 asm-mips/waitlock_types.h      |   34 +++++++++++++++++++
 asm-parisc/semaphore.h         |   29 ----------------
 asm-parisc/waitlock_types.h    |   35 ++++++++++++++++++++
 asm-ppc/rwsem.h                |   33 -------------------
 asm-ppc/semaphore.h            |   28 ----------------
 asm-ppc/waitlock_types.h       |   71 +++++++++++++++++++++++++++++++++++++++++
 asm-ppc64/rwsem.h              |   33 -------------------
 asm-ppc64/semaphore.h          |   28 ----------------
 asm-ppc64/waitlock_types.h     |   71 +++++++++++++++++++++++++++++++++++++++++
 asm-s390/rwsem.h               |   29 ----------------
 asm-s390/semaphore.h           |   16 ---------
 asm-s390/waitlock_types.h      |   55 +++++++++++++++++++++++++++++++
 asm-sh/rwsem.h                 |   32 ------------------
 asm-sh/semaphore.h             |   23 -------------
 asm-sh/waitlock_types.h        |   65 +++++++++++++++++++++++++++++++++++++
 asm-sh64/semaphore.h           |   23 -------------
 asm-sh64/waitlock_types.h      |   29 ++++++++++++++++
 asm-sparc/semaphore.h          |   23 -------------
 asm-sparc/waitlock_types.h     |   29 ++++++++++++++++
 asm-sparc64/rwsem.h            |   15 --------
 asm-sparc64/semaphore.h        |   12 ------
 asm-sparc64/waitlock_types.h   |   37 +++++++++++++++++++++
 asm-um/waitlock_types.h        |    6 +++
 asm-v850/semaphore.h           |   13 -------
 asm-v850/waitlock_types.h      |   19 ++++++++++
 asm-x86_64/rwsem.h             |   31 -----------------
 asm-x86_64/semaphore.h         |   23 -------------
 asm-x86_64/waitlock_types.h    |   64 ++++++++++++++++++++++++++++++++++++
 linux/rwsem-spinlock.h         |   28 ----------------
 linux/rwsem.h                  |    1 
 linux/wait.h                   |   31 -----------------
 linux/waitlock_types.h         |   69 +++++++++++++++++++++++++++++++++++++++
 54 files changed, 960 insertions(+), 785 deletions(-)

Index: linux-2.6-inc/include/asm-i386/waitlock_types.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-inc/include/asm-i386/waitlock_types.h	2004-10-14 03:48:50.174401911 +0200
@@ -0,0 +1,64 @@
+#ifndef __ASM_I386_WAITLOCK_TYPES_H
+#define __ASM_I386_WAITLOCK_TYPES_H
+
+#include <linux/types.h>
+
+struct semaphore {
+	atomic_t count;
+	int sleepers;
+	wait_queue_head_t wait;
+#ifdef WAITQUEUE_DEBUG
+	long __magic;
+#endif
+};
+
+#ifdef WAITQUEUE_DEBUG
+# define __SEM_DEBUG_INIT(name)	, (long)&(name).__magic
+#else
+# define __SEM_DEBUG_INIT(name)
+#endif
+
+#define __SEMAPHORE_INITIALIZER(name,count)		\
+{	ATOMIC_INIT(count), 0,				\
+	__WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
+	__SEM_DEBUG_INIT(name) }
+
+#define __MUTEX_INITIALIZER(name) \
+	__SEMAPHORE_INITIALIZER(name,1)
+
+#ifndef CONFIG_RWSEM_GENERIC_SPINLOCK
+
+/*
+ * the rw semaphore definition
+ */
+struct rw_semaphore {
+	signed long		count;
+#define RWSEM_UNLOCKED_VALUE		0x00000000
+#define RWSEM_ACTIVE_BIAS		0x00000001
+#define RWSEM_ACTIVE_MASK		0x0000ffff
+#define RWSEM_WAITING_BIAS		(-0x00010000)
+#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
+#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
+	spinlock_t		wait_lock;
+	struct list_head	wait_list;
+#if RWSEM_DEBUG
+	int			debug;
+#endif
+};
+
+/*
+ * initialisation
+ */
+#if RWSEM_DEBUG
+#define __RWSEM_DEBUG_INIT      , 0
+#else
+#define __RWSEM_DEBUG_INIT	/* */
+#endif
+
+#define __RWSEM_INITIALIZER(name) \
+{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, LIST_HEAD_INIT((name).wait_list) \
+	__RWSEM_DEBUG_INIT }
+
+#endif /* CONFIG_RWSEM_GENERIC_SPINLOCK */
+
+#endif /* __ASM_I386_WAITLOCK_TYPES_H */
Index: linux-2.6-inc/include/asm-i386/semaphore.h
===================================================================
--- linux-2.6-inc.orig/include/asm-i386/semaphore.h	2003-07-18 23:22:38.000000000 +0200
+++ linux-2.6-inc/include/asm-i386/semaphore.h	2004-10-14 03:48:50.174401911 +0200
@@ -36,34 +36,12 @@
  *
  */
 
+#include <linux/waitlock_types.h>
 #include <asm/system.h>
 #include <asm/atomic.h>
 #include <linux/wait.h>
 #include <linux/rwsem.h>
 
-struct semaphore {
-	atomic_t count;
-	int sleepers;
-	wait_queue_head_t wait;
-#ifdef WAITQUEUE_DEBUG
-	long __magic;
-#endif
-};
-
-#ifdef WAITQUEUE_DEBUG
-# define __SEM_DEBUG_INIT(name) \
-		, (int)&(name).__magic
-#else
-# define __SEM_DEBUG_INIT(name)
-#endif
-
-#define __SEMAPHORE_INITIALIZER(name,count) \
-{ ATOMIC_INIT(count), 0, __WAIT_QUEUE_HEAD_INITIALIZER((name).wait) \
-	__SEM_DEBUG_INIT(name) }
-
-#define __MUTEX_INITIALIZER(name) \
-	__SEMAPHORE_INITIALIZER(name,1)
-
 #define __DECLARE_SEMAPHORE_GENERIC(name,count) \
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
@@ -72,12 +50,11 @@ struct semaphore {
 
 static inline void sema_init (struct semaphore *sem, int val)
 {
-/*
- *	*sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
- *
- * i'd rather use the more flexible initialization above, but sadly
- * GCC 2.7.2.3 emits a bogus warning. EGCS doesn't. Oh well.
- */
+	/*
+	 * Logically, 
+	 *   *sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
+	 * except that gcc produces better initializing by parts yet.
+	 */
 	atomic_set(&sem->count, val);
 	sem->sleepers = 0;
 	init_waitqueue_head(&sem->wait);
Index: linux-2.6-inc/include/linux/rwsem-spinlock.h
===================================================================
--- linux-2.6-inc.orig/include/linux/rwsem-spinlock.h	2003-07-18 23:22:47.000000000 +0200
+++ linux-2.6-inc/include/linux/rwsem-spinlock.h	2004-10-14 03:48:50.174401911 +0200
@@ -21,34 +21,6 @@
 
 struct rwsem_waiter;
 
-/*
- * the rw-semaphore definition
- * - if activity is 0 then there are no active readers or writers
- * - if activity is +ve then that is the number of active readers
- * - if activity is -1 then there is one active writer
- * - if wait_list is not empty, then there are processes waiting for the semaphore
- */
-struct rw_semaphore {
-	__s32			activity;
-	spinlock_t		wait_lock;
-	struct list_head	wait_list;
-#if RWSEM_DEBUG
-	int			debug;
-#endif
-};
-
-/*
- * initialisation
- */
-#if RWSEM_DEBUG
-#define __RWSEM_DEBUG_INIT      , 0
-#else
-#define __RWSEM_DEBUG_INIT	/* */
-#endif
-
-#define __RWSEM_INITIALIZER(name) \
-{ 0, SPIN_LOCK_UNLOCKED, LIST_HEAD_INIT((name).wait_list) __RWSEM_DEBUG_INIT }
-
 #define DECLARE_RWSEM(name) \
 	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
 
Index: linux-2.6-inc/include/asm-i386/rwsem.h
===================================================================
--- linux-2.6-inc.orig/include/asm-i386/rwsem.h	2003-07-18 23:22:38.000000000 +0200
+++ linux-2.6-inc/include/asm-i386/rwsem.h	2004-10-14 03:48:50.174401911 +0200
@@ -48,37 +48,6 @@ extern struct rw_semaphore *FASTCALL(rws
 extern struct rw_semaphore *FASTCALL(rwsem_wake(struct rw_semaphore *));
 extern struct rw_semaphore *FASTCALL(rwsem_downgrade_wake(struct rw_semaphore *sem));
 
-/*
- * the semaphore definition
- */
-struct rw_semaphore {
-	signed long		count;
-#define RWSEM_UNLOCKED_VALUE		0x00000000
-#define RWSEM_ACTIVE_BIAS		0x00000001
-#define RWSEM_ACTIVE_MASK		0x0000ffff
-#define RWSEM_WAITING_BIAS		(-0x00010000)
-#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
-#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
-	spinlock_t		wait_lock;
-	struct list_head	wait_list;
-#if RWSEM_DEBUG
-	int			debug;
-#endif
-};
-
-/*
- * initialisation
- */
-#if RWSEM_DEBUG
-#define __RWSEM_DEBUG_INIT      , 0
-#else
-#define __RWSEM_DEBUG_INIT	/* */
-#endif
-
-#define __RWSEM_INITIALIZER(name) \
-{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, LIST_HEAD_INIT((name).wait_list) \
-	__RWSEM_DEBUG_INIT }
-
 #define DECLARE_RWSEM(name) \
 	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
 
Index: linux-2.6-inc/include/linux/waitlock_types.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-inc/include/linux/waitlock_types.h	2004-10-14 03:48:50.175401739 +0200
@@ -0,0 +1,69 @@
+#ifndef __LINUX_WAITLOCK_TYPES_H
+#define __LINUX_WAITLOCK_TYPES_H
+
+#include <linux/types.h>
+#include <linux/spinlock_types.h>
+
+typedef struct __wait_queue wait_queue_t;
+typedef int (*wait_queue_func_t)(wait_queue_t *wait, unsigned mode, int sync, void *key);
+
+struct __wait_queue {
+	unsigned int flags;
+#define WQ_FLAG_EXCLUSIVE	0x01
+	struct task_struct * task;
+	wait_queue_func_t func;
+	struct list_head task_list;
+};
+
+typedef struct __wait_queue_head wait_queue_head_t;
+
+struct __wait_queue_head {
+	spinlock_t lock;
+	struct list_head task_list;
+};
+
+extern int default_wake_function(wait_queue_t *wait, unsigned mode, int sync, void *key);
+
+#define __WAITQUEUE_INITIALIZER(name, tsk) {				\
+	.task		= tsk,						\
+	.func		= default_wake_function,			\
+	.task_list	= { NULL, NULL } }
+
+#define __WAIT_QUEUE_HEAD_INITIALIZER(name) {				\
+	.lock		= SPIN_LOCK_UNLOCKED,				\
+	.task_list	= { &(name).task_list, &(name).task_list } }
+
+#include <asm/waitlock_types.h>
+
+#ifdef CONFIG_RWSEM_GENERIC_SPINLOCK
+/*
+ * the rw-semaphore definition
+ * - if activity is 0 then there are no active readers or writers
+ * - if activity is +ve then that is the number of active readers
+ * - if activity is -1 then there is one active writer
+ * - if wait_list is not empty, then there are processes waiting for the semaphore
+ */
+struct rw_semaphore {
+	__s32			activity;
+	spinlock_t		wait_lock;
+	struct list_head	wait_list;
+#if RWSEM_DEBUG
+	int			debug;
+#endif
+};
+
+/*
+ * initialisation
+ */
+#if RWSEM_DEBUG
+#define __RWSEM_DEBUG_INIT      , 0
+#else
+#define __RWSEM_DEBUG_INIT	/* */
+#endif
+
+#define __RWSEM_INITIALIZER(name) \
+{ 0, SPIN_LOCK_UNLOCKED, LIST_HEAD_INIT((name).wait_list) __RWSEM_DEBUG_INIT }
+
+#endif /* CONFIG_RWSEM_GENERIC_SPINLOCK */
+
+#endif /* __LINUX_WAITLOCK_TYPES_H */
Index: linux-2.6-inc/include/linux/rwsem.h
===================================================================
--- linux-2.6-inc.orig/include/linux/rwsem.h	2003-07-18 23:22:47.000000000 +0200
+++ linux-2.6-inc/include/linux/rwsem.h	2004-10-14 03:48:50.175401739 +0200
@@ -15,6 +15,7 @@
 
 #include <linux/config.h>
 #include <linux/types.h>
+#include <linux/waitlock_types.h>
 #include <linux/kernel.h>
 #include <asm/system.h>
 #include <asm/atomic.h>
Index: linux-2.6-inc/include/asm-sparc/waitlock_types.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-inc/include/asm-sparc/waitlock_types.h	2004-10-14 03:48:50.175401739 +0200
@@ -0,0 +1,29 @@
+#ifndef __ASM_SPARC_WAITLOCK_TYPES_H
+#define __ASM_SPARC_WAITLOCK_TYPES_H
+
+#include <linux/types.h>
+
+struct semaphore {
+	atomic24_t count;
+	int sleepers;
+	wait_queue_head_t wait;
+#ifdef WAITQUEUE_DEBUG
+	long __magic;
+#endif
+};
+
+#ifdef WAITQUEUE_DEBUG
+# define __SEM_DEBUG_INIT(name) \
+		, (long)&(name).__magic
+#else
+# define __SEM_DEBUG_INIT(name)
+#endif
+
+#define __SEMAPHORE_INITIALIZER(name,count) \
+{ ATOMIC24_INIT(count), 0, __WAIT_QUEUE_HEAD_INITIALIZER((name).wait) \
+	__SEM_DEBUG_INIT(name) }
+
+#define __MUTEX_INITIALIZER(name) \
+	__SEMAPHORE_INITIALIZER(name,1)
+
+#endif /* __ASM_SPARC_WAITLOCK_TYPES_H */
Index: linux-2.6-inc/include/asm-ia64/waitlock_types.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-inc/include/asm-ia64/waitlock_types.h	2004-10-14 03:48:50.175401739 +0200
@@ -0,0 +1,66 @@
+#ifndef __ASM_IA64_WAITLOCK_TYPES_H
+#define __ASM_IA64_WAITLOCK_TYPES_H
+
+#include <linux/types.h>
+
+struct semaphore {
+	atomic_t count;
+	int sleepers;
+	wait_queue_head_t wait;
+#if WAITQUEUE_DEBUG
+	long __magic;		/* initialized by __SEM_DEBUG_INIT() */
+#endif
+};
+
+#if WAITQUEUE_DEBUG
+# define __SEM_DEBUG_INIT(name)		, (long) &(name).__magic
+#else
+# define __SEM_DEBUG_INIT(name)
+#endif
+
+#define __SEMAPHORE_INITIALIZER(name,count)					\
+{										\
+	ATOMIC_INIT(count), 0, __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
+	__SEM_DEBUG_INIT(name)							\
+}
+
+#define __MUTEX_INITIALIZER(name)	__SEMAPHORE_INITIALIZER(name,1)
+
+#ifndef CONFIG_RWSEM_GENERIC_SPINLOCK
+
+/*
+ * the rw semaphore definition
+ */
+struct rw_semaphore {
+	signed int		count;
+	spinlock_t		wait_lock;
+	struct list_head	wait_list;
+#if RWSEM_DEBUG
+	int			debug;
+#endif
+};
+
+#define RWSEM_UNLOCKED_VALUE		0x00000000
+#define RWSEM_ACTIVE_BIAS		0x00000001
+#define RWSEM_ACTIVE_MASK		0x0000ffff
+#define RWSEM_WAITING_BIAS		(-0x00010000)
+#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
+#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
+
+/*
+ * initialization
+ */
+#if RWSEM_DEBUG
+#define __RWSEM_DEBUG_INIT      , 0
+#else
+#define __RWSEM_DEBUG_INIT	/* */
+#endif
+
+#define __RWSEM_INITIALIZER(name) \
+	{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, \
+	  LIST_HEAD_INIT((name).wait_list) \
+	  __RWSEM_DEBUG_INIT }
+
+#endif /* CONFIG_RWSEM_GENERIC_SPINLOCK */
+
+#endif /* __ASM_IA64_WAITLOCK_TYPES_H */
Index: linux-2.6-inc/include/asm-m68k/waitlock_types.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-inc/include/asm-m68k/waitlock_types.h	2004-10-14 03:48:50.175401739 +0200
@@ -0,0 +1,29 @@
+#ifndef __ASM_M68K_WAITLOCK_TYPES_H
+#define __ASM_M68K_WAITLOCK_TYPES_H
+
+#include <linux/types.h>
+
+struct semaphore {
+	atomic_t count;
+	atomic_t waking;
+	wait_queue_head_t wait;
+#ifdef WAITQUEUE_DEBUG
+	long __magic;
+#endif
+};
+
+#ifdef WAITQUEUE_DEBUG
+# define __SEM_DEBUG_INIT(name) \
+		, (long)&(name).__magic
+#else
+# define __SEM_DEBUG_INIT(name)
+#endif
+
+#define __SEMAPHORE_INITIALIZER(name,count) \
+{ ATOMIC_INIT(count), ATOMIC_INIT(0), __WAIT_QUEUE_HEAD_INITIALIZER((name).wait) \
+	__SEM_DEBUG_INIT(name) }
+
+#define __MUTEX_INITIALIZER(name) \
+	__SEMAPHORE_INITIALIZER(name,1)
+
+#endif /* __ASM_M68K_WAITLOCK_TYPES_H */
Index: linux-2.6-inc/include/asm-h8300/waitlock_types.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-inc/include/asm-h8300/waitlock_types.h	2004-10-14 03:48:50.176401566 +0200
@@ -0,0 +1,32 @@
+#ifndef __ASM_H8300_WAITLOCK_TYPES_H
+#define __ASM_H8300_WAITLOCK_TYPES_H
+
+#include <linux/types.h>
+
+struct semaphore {
+	atomic_t count;
+	int sleepers;
+	wait_queue_head_t wait;
+#if WAITQUEUE_DEBUG
+	long __magic;
+#endif
+};
+
+#if WAITQUEUE_DEBUG
+# define __SEM_DEBUG_INIT(name) \
+		, (long)&(name).__magic
+#else
+# define __SEM_DEBUG_INIT(name)
+#endif
+
+#define __SEMAPHORE_INITIALIZER(name,count) \
+{ ATOMIC_INIT(count), 0, __WAIT_QUEUE_HEAD_INITIALIZER((name).wait) \
+	__SEM_DEBUG_INIT(name) }
+
+#define __MUTEX_INITIALIZER(name) \
+	__SEMAPHORE_INITIALIZER(name,1)
+
+#define __DECLARE_SEMAPHORE_GENERIC(name,count) \
+	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
+
+#endif /* __ASM_H8300_WAITLOCK_TYPES_H */
Index: linux-2.6-inc/include/asm-arm26/waitlock_types.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-inc/include/asm-arm26/waitlock_types.h	2004-10-14 03:48:50.176401566 +0200
@@ -0,0 +1,30 @@
+#ifndef __ASM_ARM26_WAITLOCK_TYPES_H
+#define __ASM_ARM26_WAITLOCK_TYPES_H
+
+#include <linux/types.h>
+
+struct semaphore {
+	atomic_t count;
+	int sleepers;
+	wait_queue_head_t wait;
+#if WAITQUEUE_DEBUG
+	long __magic;
+#endif
+};
+
+#if WAITQUEUE_DEBUG
+# define __SEM_DEBUG_INIT(name) \
+		, (long)&(name).__magic
+#else
+# define __SEM_DEBUG_INIT(name)
+#endif
+
+#define __SEMAPHORE_INIT(name,count)			\
+	{ ATOMIC_INIT(count), 0,			\
+	  __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
+	  __SEM_DEBUG_INIT(name) }
+
+#define __MUTEX_INITIALIZER(name) \
+	__SEMAPHORE_INIT(name,1)
+
+#endif /* __ASM_ARM26_WAITLOCK_TYPES_H */
Index: linux-2.6-inc/include/asm-v850/waitlock_types.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-inc/include/asm-v850/waitlock_types.h	2004-10-14 03:48:50.176401566 +0200
@@ -0,0 +1,19 @@
+#ifndef __ASM_V850_WAITLOCK_TYPES_H
+#define __ASM_V850_WAITLOCK_TYPES_H
+
+#include <linux/types.h>
+
+struct semaphore {
+	atomic_t count;
+	int sleepers;
+	wait_queue_head_t wait;
+};
+
+#define __SEMAPHORE_INITIALIZER(name,count)				      \
+	{ ATOMIC_INIT (count), 0,					      \
+	  __WAIT_QUEUE_HEAD_INITIALIZER ((name).wait) }
+
+#define __MUTEX_INITIALIZER(name)					      \
+	__SEMAPHORE_INITIALIZER (name,1)
+
+#endif /* __ASM_V850_WAITLOCK_TYPES_H */
Index: linux-2.6-inc/include/asm-sh/waitlock_types.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-inc/include/asm-sh/waitlock_types.h	2004-10-14 03:48:50.176401566 +0200
@@ -0,0 +1,65 @@
+#ifndef __ASM_SH_WAITLOCK_TYPES_H
+#define __ASM_SH_WAITLOCK_TYPES_H
+
+#include <linux/types.h>
+
+struct semaphore {
+	atomic_t count;
+	int sleepers;
+	wait_queue_head_t wait;
+#ifdef WAITQUEUE_DEBUG
+	long __magic;
+#endif
+};
+
+#ifdef WAITQUEUE_DEBUG
+# define __SEM_DEBUG_INIT(name) \
+		, (int)&(name).__magic
+#else
+# define __SEM_DEBUG_INIT(name)
+#endif
+
+#define __SEMAPHORE_INITIALIZER(name,count) \
+{ ATOMIC_INIT(count), 0, __WAIT_QUEUE_HEAD_INITIALIZER((name).wait) \
+	__SEM_DEBUG_INIT(name) }
+
+#define __MUTEX_INITIALIZER(name) \
+	__SEMAPHORE_INITIALIZER(name,1)
+
+#ifndef CONFIG_RWSEM_GENERIC_SPINLOCK
+
+/*
+ * the rw semaphore definition
+ */
+struct rw_semaphore {
+	long		count;
+#define RWSEM_UNLOCKED_VALUE		0x00000000
+#define RWSEM_ACTIVE_BIAS		0x00000001
+#define RWSEM_ACTIVE_MASK		0x0000ffff
+#define RWSEM_WAITING_BIAS		(-0x00010000)
+#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
+#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
+	spinlock_t		wait_lock;
+	struct list_head	wait_list;
+#if RWSEM_DEBUG
+	int			debug;
+#endif
+};
+
+/*
+ * initialisation
+ */
+#if RWSEM_DEBUG
+#define __RWSEM_DEBUG_INIT      , 0
+#else
+#define __RWSEM_DEBUG_INIT	/* */
+#endif
+
+#define __RWSEM_INITIALIZER(name) \
+	{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, \
+	  LIST_HEAD_INIT((name).wait_list) \
+	  __RWSEM_DEBUG_INIT }
+
+#endif /* CONFIG_RWSEM_GENERIC_SPINLOCK */
+
+#endif /* __ASM_SH_WAITLOCK_TYPES_H */
Index: linux-2.6-inc/include/asm-m68knommu/waitlock_types.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-inc/include/asm-m68knommu/waitlock_types.h	2004-10-14 03:48:50.177401394 +0200
@@ -0,0 +1,29 @@
+#ifndef __ASM_M68KNOMMU_WAITLOCK_TYPES_H
+#define __ASM_M68KNOMMU_WAITLOCK_TYPES_H
+
+#include <linux/types.h>
+
+struct semaphore {
+	atomic_t count;
+	atomic_t waking;
+	wait_queue_head_t wait;
+#if WAITQUEUE_DEBUG
+	long __magic;
+#endif
+};
+
+#if WAITQUEUE_DEBUG
+# define __SEM_DEBUG_INIT(name) \
+		, (long)&(name).__magic
+#else
+# define __SEM_DEBUG_INIT(name)
+#endif
+
+#define __SEMAPHORE_INITIALIZER(name,count) \
+{ ATOMIC_INIT(count), ATOMIC_INIT(0), __WAIT_QUEUE_HEAD_INITIALIZER((name).wait) \
+	__SEM_DEBUG_INIT(name) }
+
+#define __MUTEX_INITIALIZER(name) \
+	__SEMAPHORE_INITIALIZER(name,1)
+
+#endif /* __ASM_M68KNOMMU_WAITLOCK_TYPES_H */
Index: linux-2.6-inc/include/asm-x86_64/waitlock_types.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-inc/include/asm-x86_64/waitlock_types.h	2004-10-14 03:48:50.177401394 +0200
@@ -0,0 +1,64 @@
+#ifndef __ASM_X86_64_WAITLOCK_TYPES_H
+#define __ASM_X86_64_WAITLOCK_TYPES_H
+
+#include <linux/types.h>
+
+struct semaphore {
+	atomic_t count;
+	int sleepers;
+	wait_queue_head_t wait;
+#ifdef WAITQUEUE_DEBUG
+	long __magic;
+#endif
+};
+
+#ifdef WAITQUEUE_DEBUG
+# define __SEM_DEBUG_INIT(name) \
+		, (int)&(name).__magic
+#else
+# define __SEM_DEBUG_INIT(name)
+#endif
+
+#define __SEMAPHORE_INITIALIZER(name,count) \
+{ ATOMIC_INIT(count), 0, __WAIT_QUEUE_HEAD_INITIALIZER((name).wait) \
+	__SEM_DEBUG_INIT(name) }
+
+#define __MUTEX_INITIALIZER(name) \
+	__SEMAPHORE_INITIALIZER(name,1)
+
+#ifndef CONFIG_RWSEM_GENERIC_SPINLOCK
+
+/*
+ * the semaphore definition
+ */
+struct rw_semaphore {
+	signed int		count;
+#define RWSEM_UNLOCKED_VALUE		0x00000000
+#define RWSEM_ACTIVE_BIAS		0x00000001
+#define RWSEM_ACTIVE_MASK		0x0000ffff
+#define RWSEM_WAITING_BIAS		(-0x00010000)
+#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
+#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
+	spinlock_t		wait_lock;
+	struct list_head	wait_list;
+#if RWSEM_DEBUG
+	int			debug;
+#endif
+};
+
+/*
+ * initialisation
+ */
+#if RWSEM_DEBUG
+#define __RWSEM_DEBUG_INIT      , 0
+#else
+#define __RWSEM_DEBUG_INIT	/* */
+#endif
+
+#define __RWSEM_INITIALIZER(name) \
+{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, LIST_HEAD_INIT((name).wait_list) \
+	__RWSEM_DEBUG_INIT }
+
+#endif /* CONFIG_RWSEM_GENERIC_SPINLOCK */
+
+#endif /* __ASM_X86_64_WAITLOCK_TYPES_H */
Index: linux-2.6-inc/include/asm-parisc/waitlock_types.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-inc/include/asm-parisc/waitlock_types.h	2004-10-14 03:48:50.177401394 +0200
@@ -0,0 +1,35 @@
+#ifndef __ASM_PARISC_WAITLOCK_TYPES_H
+#define __ASM_PARISC_WAITLOCK_TYPES_H
+
+#include <linux/types.h>
+
+/*
+ * The `count' is initialised to the number of people who are allowed to
+ * take the lock.  (Normally we want a mutex, so this is `1').  if
+ * `count' is positive, the lock can be taken.  if it's 0, no-one is
+ * waiting on it.  if it's -1, at least one task is waiting.
+ */
+struct semaphore {
+	spinlock_t	sentry;
+	int		count;
+	wait_queue_head_t wait;
+#if WAITQUEUE_DEBUG
+	long __magic;
+#endif
+};
+
+#if WAITQUEUE_DEBUG
+# define __SEM_DEBUG_INIT(name) \
+		, (long)&(name).__magic
+#else
+# define __SEM_DEBUG_INIT(name)
+#endif
+
+#define __SEMAPHORE_INITIALIZER(name,count) \
+{ SPIN_LOCK_UNLOCKED, count, __WAIT_QUEUE_HEAD_INITIALIZER((name).wait) \
+	__SEM_DEBUG_INIT(name) }
+
+#define __MUTEX_INITIALIZER(name) \
+	__SEMAPHORE_INITIALIZER(name,1)
+
+#endif /* __ASM_PARISC_WAITLOCK_TYPES_H */
Index: linux-2.6-inc/include/asm-s390/waitlock_types.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-inc/include/asm-s390/waitlock_types.h	2004-10-14 03:48:50.177401394 +0200
@@ -0,0 +1,55 @@
+#ifndef __ASM_S390_WAITLOCK_TYPES_H
+#define __ASM_S390_WAITLOCK_TYPES_H
+
+#include <linux/types.h>
+
+struct semaphore {
+	/*
+	 * Note that any negative value of count is equivalent to 0,
+	 * but additionally indicates that some process(es) might be
+	 * sleeping on `wait'.
+	 */
+	atomic_t count;
+	wait_queue_head_t wait;
+};
+
+#define __SEMAPHORE_INITIALIZER(name,count) \
+	{ ATOMIC_INIT(count), __WAIT_QUEUE_HEAD_INITIALIZER((name).wait) }
+
+#define __MUTEX_INITIALIZER(name) \
+	__SEMAPHORE_INITIALIZER(name,1)
+
+#ifndef CONFIG_RWSEM_GENERIC_SPINLOCK
+
+/*
+ * the rw semaphore definition
+ */
+struct rw_semaphore {
+	signed long		count;
+	spinlock_t		wait_lock;
+	struct list_head	wait_list;
+};
+
+#ifndef __s390x__
+#define RWSEM_UNLOCKED_VALUE	0x00000000
+#define RWSEM_ACTIVE_BIAS	0x00000001
+#define RWSEM_ACTIVE_MASK	0x0000ffff
+#define RWSEM_WAITING_BIAS	(-0x00010000)
+#else /* __s390x__ */
+#define RWSEM_UNLOCKED_VALUE	0x0000000000000000L
+#define RWSEM_ACTIVE_BIAS	0x0000000000000001L
+#define RWSEM_ACTIVE_MASK	0x00000000ffffffffL
+#define RWSEM_WAITING_BIAS	(-0x0000000100000000L)
+#endif /* __s390x__ */
+#define RWSEM_ACTIVE_READ_BIAS	RWSEM_ACTIVE_BIAS
+#define RWSEM_ACTIVE_WRITE_BIAS	(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
+
+/*
+ * initialisation
+ */
+#define __RWSEM_INITIALIZER(name) \
+{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, LIST_HEAD_INIT((name).wait_list) }
+
+#endif /* CONFIG_RWSEM_GENERIC_SPINLOCK */
+
+#endif /* __ASM_S390_WAITLOCK_TYPES_H */
Index: linux-2.6-inc/include/asm-ppc64/waitlock_types.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-inc/include/asm-ppc64/waitlock_types.h	2004-10-14 03:48:50.177401394 +0200
@@ -0,0 +1,71 @@
+#ifndef __ASM_PPC64_WAITLOCK_TYPES_H
+#define __ASM_PPC64_WAITLOCK_TYPES_H
+
+#include <linux/types.h>
+
+struct semaphore {
+	/*
+	 * Note that any negative value of count is equivalent to 0,
+	 * but additionally indicates that some process(es) might be
+	 * sleeping on `wait'.
+	 */
+	atomic_t count;
+	wait_queue_head_t wait;
+#ifdef WAITQUEUE_DEBUG
+	long __magic;
+#endif
+};
+
+#ifdef WAITQUEUE_DEBUG
+# define __SEM_DEBUG_INIT(name) \
+		, (long)&(name).__magic
+#else
+# define __SEM_DEBUG_INIT(name)
+#endif
+
+#define __SEMAPHORE_INITIALIZER(name, count) \
+	{ ATOMIC_INIT(count), \
+	  __WAIT_QUEUE_HEAD_INITIALIZER((name).wait) \
+	  __SEM_DEBUG_INIT(name) }
+
+#define __MUTEX_INITIALIZER(name) \
+	__SEMAPHORE_INITIALIZER(name, 1)
+
+#ifndef CONFIG_RWSEM_GENERIC_SPINLOCK
+
+/*
+ * the semaphore definition
+ */
+struct rw_semaphore {
+	/* XXX this should be able to be an atomic_t  -- paulus */
+	signed int		count;
+#define RWSEM_UNLOCKED_VALUE		0x00000000
+#define RWSEM_ACTIVE_BIAS		0x00000001
+#define RWSEM_ACTIVE_MASK		0x0000ffff
+#define RWSEM_WAITING_BIAS		(-0x00010000)
+#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
+#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
+	spinlock_t		wait_lock;
+	struct list_head	wait_list;
+#if RWSEM_DEBUG
+	int			debug;
+#endif
+};
+
+/*
+ * initialisation
+ */
+#if RWSEM_DEBUG
+#define __RWSEM_DEBUG_INIT      , 0
+#else
+#define __RWSEM_DEBUG_INIT	/* */
+#endif
+
+#define __RWSEM_INITIALIZER(name) \
+	{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, \
+	  LIST_HEAD_INIT((name).wait_list) \
+	  __RWSEM_DEBUG_INIT }
+
+#endif /* CONFIG_RWSEM_GENERIC_SPINLOCK */
+
+#endif /* __ASM_PPC64_WAITLOCK_TYPES_H */
Index: linux-2.6-inc/include/asm-mips/waitlock_types.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-inc/include/asm-mips/waitlock_types.h	2004-10-14 03:53:59.171088165 +0200
@@ -0,0 +1,34 @@
+#ifndef __ASM_MIPS_WAITLOCK_TYPES_H
+#define __ASM_MIPS_WAITLOCK_TYPES_H
+
+#include <linux/types.h>
+
+struct semaphore {
+	/*
+	 * Note that any negative value of count is equivalent to 0,
+	 * but additionally indicates that some process(es) might be
+	 * sleeping on `wait'.
+	 */
+	atomic_t count;
+	wait_queue_head_t wait;
+#ifdef WAITQUEUE_DEBUG
+	long __magic;
+#endif
+};
+
+#ifdef WAITQUEUE_DEBUG
+# define __SEM_DEBUG_INIT(name) \
+		, (long)&(name).__magic
+#else
+# define __SEM_DEBUG_INIT(name)
+#endif
+
+#define __SEMAPHORE_INITIALIZER(name, count) \
+	{ ATOMIC_INIT(count), \
+	  __WAIT_QUEUE_HEAD_INITIALIZER((name).wait) \
+	  __SEM_DEBUG_INIT(name) }
+
+#define __MUTEX_INITIALIZER(name) \
+	__SEMAPHORE_INITIALIZER(name, 1)
+
+#endif /* __ASM_MIPS_WAITLOCK_TYPES_H */
Index: linux-2.6-inc/include/asm-ppc/waitlock_types.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-inc/include/asm-ppc/waitlock_types.h	2004-10-14 03:48:50.178401221 +0200
@@ -0,0 +1,71 @@
+#ifndef __ASM_PPC_WAITLOCK_TYPES_H
+#define __ASM_PPC_WAITLOCK_TYPES_H
+
+#include <linux/types.h>
+
+struct semaphore {
+	/*
+	 * Note that any negative value of count is equivalent to 0,
+	 * but additionally indicates that some process(es) might be
+	 * sleeping on `wait'.
+	 */
+	atomic_t count;
+	wait_queue_head_t wait;
+#ifdef WAITQUEUE_DEBUG
+	long __magic;
+#endif
+};
+
+#ifdef WAITQUEUE_DEBUG
+# define __SEM_DEBUG_INIT(name) \
+		, (long)&(name).__magic
+#else
+# define __SEM_DEBUG_INIT(name)
+#endif
+
+#define __SEMAPHORE_INITIALIZER(name, count) \
+	{ ATOMIC_INIT(count), \
+	  __WAIT_QUEUE_HEAD_INITIALIZER((name).wait) \
+	  __SEM_DEBUG_INIT(name) }
+
+#define __MUTEX_INITIALIZER(name) \
+	__SEMAPHORE_INITIALIZER(name, 1)
+
+#ifndef CONFIG_RWSEM_GENERIC_SPINLOCK
+
+/*
+ * the semaphore definition
+ */
+struct rw_semaphore {
+	/* XXX this should be able to be an atomic_t  -- paulus */
+	signed long		count;
+#define RWSEM_UNLOCKED_VALUE		0x00000000
+#define RWSEM_ACTIVE_BIAS		0x00000001
+#define RWSEM_ACTIVE_MASK		0x0000ffff
+#define RWSEM_WAITING_BIAS		(-0x00010000)
+#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
+#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
+	spinlock_t		wait_lock;
+	struct list_head	wait_list;
+#ifdef RWSEM_DEBUG
+	int			debug;
+#endif
+};
+
+/*
+ * initialisation
+ */
+#ifdef RWSEM_DEBUG
+#define __RWSEM_DEBUG_INIT      , 0
+#else
+#define __RWSEM_DEBUG_INIT	/* */
+#endif
+
+#define __RWSEM_INITIALIZER(name) \
+	{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, \
+	  LIST_HEAD_INIT((name).wait_list) \
+	  __RWSEM_DEBUG_INIT }
+
+#endif /* CONFIG_RWSEM_GENERIC_SPINLOCK */
+
+#endif /* __ASM_PPC_WAITLOCK_TYPES_H */
Index: linux-2.6-inc/include/asm-alpha/waitlock_types.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-inc/include/asm-alpha/waitlock_types.h	2004-10-14 03:48:50.178401221 +0200
@@ -0,0 +1,60 @@
+#ifndef __ASM_ALPHA_WAITLOCK_TYPES_H
+#define __ASM_ALPHA_WAITLOCK_TYPES_H
+
+#include <linux/types.h>
+
+struct semaphore {
+	atomic_t count;
+	wait_queue_head_t wait;
+#ifdef WAITQUEUE_DEBUG
+	long __magic;
+#endif
+};
+
+#ifdef WAITQUEUE_DEBUG
+# define __SEM_DEBUG_INIT(name)		, (long)&(name).__magic
+#else
+# define __SEM_DEBUG_INIT(name)
+#endif
+
+#define __SEMAPHORE_INITIALIZER(name,count)		\
+	{ ATOMIC_INIT(count),				\
+	  __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
+	  __SEM_DEBUG_INIT(name) }
+
+#define __MUTEX_INITIALIZER(name)			\
+	__SEMAPHORE_INITIALIZER(name,1)
+
+#ifndef CONFIG_RWSEM_GENERIC_SPINLOCK
+
+/*
+ * the rw semaphore definition
+ */
+struct rw_semaphore {
+	long			count;
+#define RWSEM_UNLOCKED_VALUE		0x0000000000000000L
+#define RWSEM_ACTIVE_BIAS		0x0000000000000001L
+#define RWSEM_ACTIVE_MASK		0x00000000ffffffffL
+#define RWSEM_WAITING_BIAS		(-0x0000000100000000L)
+#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
+#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
+	spinlock_t		wait_lock;
+	struct list_head	wait_list;
+#if RWSEM_DEBUG
+	int			debug;
+#endif
+};
+
+#if RWSEM_DEBUG
+#define __RWSEM_DEBUG_INIT      , 0
+#else
+#define __RWSEM_DEBUG_INIT	/* */
+#endif
+
+#define __RWSEM_INITIALIZER(name) \
+	{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, \
+	LIST_HEAD_INIT((name).wait_list) __RWSEM_DEBUG_INIT }
+
+#endif /* CONFIG_RWSEM_GENERIC_SPINLOCK */
+
+#endif /* __ASM_ALPHA_WAITLOCK_TYPES_H */
Index: linux-2.6-inc/include/asm-um/waitlock_types.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-inc/include/asm-um/waitlock_types.h	2004-10-14 03:48:50.000000000 +0200
@@ -0,0 +1,6 @@
+#ifndef __ASM_UM_WAITLOCK_TYPES_H
+#define __ASM_UM_WAITLOCK_TYPES_H
+
+#include "asm/arch/waitlock_types.h"
+
+#endif /* __ASM_UM_WAITLOCK_TYPES_H */
Index: linux-2.6-inc/include/asm-sparc64/waitlock_types.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-inc/include/asm-sparc64/waitlock_types.h	2004-10-14 03:48:50.179401049 +0200
@@ -0,0 +1,37 @@
+#ifndef __ASM_SPARC64_WAITLOCK_TYPES_H
+#define __ASM_SPARC64_WAITLOCK_TYPES_H
+
+#include <linux/types.h>
+
+struct semaphore {
+	atomic_t count;
+	wait_queue_head_t wait;
+};
+
+#define __SEMAPHORE_INITIALIZER(name, count) \
+	{ ATOMIC_INIT(count), \
+	  __WAIT_QUEUE_HEAD_INITIALIZER((name).wait) }
+
+#define __MUTEX_INITIALIZER(name) \
+	__SEMAPHORE_INITIALIZER(name, 1)
+
+#ifndef CONFIG_RWSEM_GENERIC_SPINLOCK
+
+struct rw_semaphore {
+	signed int count;
+#define RWSEM_UNLOCKED_VALUE		0x00000000
+#define RWSEM_ACTIVE_BIAS		0x00000001
+#define RWSEM_ACTIVE_MASK		0x0000ffff
+#define RWSEM_WAITING_BIAS		0xffff0000
+#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
+#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
+	spinlock_t		wait_lock;
+	struct list_head	wait_list;
+};
+
+#define __RWSEM_INITIALIZER(name) \
+{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, LIST_HEAD_INIT((name).wait_list) }
+
+#endif /* CONFIG_RWSEM_GENERIC_SPINLOCK */
+
+#endif /* __ASM_SPARC64_WAITLOCK_TYPES_H */
Index: linux-2.6-inc/include/asm-arm/waitlock_types.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-inc/include/asm-arm/waitlock_types.h	2004-10-14 03:48:50.179401049 +0200
@@ -0,0 +1,29 @@
+#ifndef __ASM_ARM_WAITLOCK_TYPES_H
+#define __ASM_ARM_WAITLOCK_TYPES_H
+
+#include <linux/types.h>
+
+struct semaphore {
+	atomic_t count;
+	int sleepers;
+	wait_queue_head_t wait;
+#ifdef WAITQUEUE_DEBUG
+	long __magic;
+#endif
+};
+
+#ifdef WAITQUEUE_DEBUG
+# define __SEM_DEBUG_INIT(name)	.__magic = (long)&(name).__magic
+#else
+# define __SEM_DEBUG_INIT(name)
+#endif
+
+#define __SEMAPHORE_INIT(name,cnt) {				\
+	.count	= ATOMIC_INIT(cnt),				\
+	.wait	= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait),	\
+	__SEM_DEBUG_INIT(name)					\
+}
+
+#define __MUTEX_INITIALIZER(name) __SEMAPHORE_INIT(name,1)
+
+#endif /* __ASM_ARM_WAITLOCK_TYPES_H */
Index: linux-2.6-inc/include/asm-sh64/waitlock_types.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-inc/include/asm-sh64/waitlock_types.h	2004-10-14 03:48:50.179401049 +0200
@@ -0,0 +1,29 @@
+#ifndef __ASM_SH64_WAITLOCK_TYPES_H
+#define __ASM_SH64_WAITLOCK_TYPES_H
+
+#include <linux/types.h>
+
+struct semaphore {
+	atomic_t count;
+	int sleepers;
+	wait_queue_head_t wait;
+#ifdef WAITQUEUE_DEBUG
+	long __magic;
+#endif
+};
+
+#ifdef WAITQUEUE_DEBUG
+# define __SEM_DEBUG_INIT(name) \
+		, (int)&(name).__magic
+#else
+# define __SEM_DEBUG_INIT(name)
+#endif
+
+#define __SEMAPHORE_INITIALIZER(name,count) \
+{ ATOMIC_INIT(count), 0, __WAIT_QUEUE_HEAD_INITIALIZER((name).wait) \
+	__SEM_DEBUG_INIT(name) }
+
+#define __MUTEX_INITIALIZER(name) \
+	__SEMAPHORE_INITIALIZER(name,1)
+
+#endif /* __ASM_SH64_WAITLOCK_TYPES_H */
Index: linux-2.6-inc/include/asm-cris/waitlock_types.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-inc/include/asm-cris/waitlock_types.h	2004-10-14 03:48:50.179401049 +0200
@@ -0,0 +1,29 @@
+#ifndef __ASM_CRIS_WAITLOCK_TYPES_H
+#define __ASM_CRIS_WAITLOCK_TYPES_H
+
+#include <linux/types.h>
+
+struct semaphore {
+	atomic_t count;
+	atomic_t waking;
+	wait_queue_head_t wait;
+#if WAITQUEUE_DEBUG
+	long __magic;
+#endif
+};
+
+#if WAITQUEUE_DEBUG
+# define __SEM_DEBUG_INIT(name)         , (long)&(name).__magic
+#else
+# define __SEM_DEBUG_INIT(name)
+#endif
+
+#define __SEMAPHORE_INITIALIZER(name,count)             \
+        { ATOMIC_INIT(count), ATOMIC_INIT(0),           \
+          __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)    \
+          __SEM_DEBUG_INIT(name) }
+
+#define __MUTEX_INITIALIZER(name) \
+        __SEMAPHORE_INITIALIZER(name,1)
+
+#endif /* __ASM_CRIS_WAITLOCK_TYPES_H */
Index: linux-2.6-inc/include/asm-arm26/semaphore.h
===================================================================
--- linux-2.6-inc.orig/include/asm-arm26/semaphore.h	2004-10-11 23:57:31.000000000 +0200
+++ linux-2.6-inc/include/asm-arm26/semaphore.h	2004-10-14 03:48:50.179401049 +0200
@@ -12,30 +12,6 @@
 #include <asm/atomic.h>
 #include <asm/locks.h>
 
-struct semaphore {
-	atomic_t count;
-	int sleepers;
-	wait_queue_head_t wait;
-#if WAITQUEUE_DEBUG
-	long __magic;
-#endif
-};
-
-#if WAITQUEUE_DEBUG
-# define __SEM_DEBUG_INIT(name) \
-		, (long)&(name).__magic
-#else
-# define __SEM_DEBUG_INIT(name)
-#endif
-
-#define __SEMAPHORE_INIT(name,count)			\
-	{ ATOMIC_INIT(count), 0,			\
-	  __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
-	  __SEM_DEBUG_INIT(name) }
-
-#define __MUTEX_INITIALIZER(name) \
-	__SEMAPHORE_INIT(name,1)
-
 #define __DECLARE_SEMAPHORE_GENERIC(name,count)	\
 	struct semaphore name = __SEMAPHORE_INIT(name,count)
 
Index: linux-2.6-inc/include/asm-sh64/semaphore.h
===================================================================
--- linux-2.6-inc.orig/include/asm-sh64/semaphore.h	2004-10-11 23:57:31.000000000 +0200
+++ linux-2.6-inc/include/asm-sh64/semaphore.h	2004-10-14 03:48:50.180400876 +0200
@@ -27,29 +27,6 @@
 #include <asm/system.h>
 #include <asm/atomic.h>
 
-struct semaphore {
-	atomic_t count;
-	int sleepers;
-	wait_queue_head_t wait;
-#ifdef WAITQUEUE_DEBUG
-	long __magic;
-#endif
-};
-
-#ifdef WAITQUEUE_DEBUG
-# define __SEM_DEBUG_INIT(name) \
-		, (int)&(name).__magic
-#else
-# define __SEM_DEBUG_INIT(name)
-#endif
-
-#define __SEMAPHORE_INITIALIZER(name,count) \
-{ ATOMIC_INIT(count), 0, __WAIT_QUEUE_HEAD_INITIALIZER((name).wait) \
-	__SEM_DEBUG_INIT(name) }
-
-#define __MUTEX_INITIALIZER(name) \
-	__SEMAPHORE_INITIALIZER(name,1)
-
 #define __DECLARE_SEMAPHORE_GENERIC(name,count) \
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
Index: linux-2.6-inc/include/asm-cris/semaphore.h
===================================================================
--- linux-2.6-inc.orig/include/asm-cris/semaphore.h	2004-10-11 23:57:31.000000000 +0200
+++ linux-2.6-inc/include/asm-cris/semaphore.h	2004-10-14 03:48:50.180400876 +0200
@@ -20,29 +20,6 @@
 
 int printk(const char *fmt, ...);
 
-struct semaphore {
-	atomic_t count;
-	atomic_t waking;
-	wait_queue_head_t wait;
-#if WAITQUEUE_DEBUG
-	long __magic;
-#endif
-};
-
-#if WAITQUEUE_DEBUG
-# define __SEM_DEBUG_INIT(name)         , (long)&(name).__magic
-#else
-# define __SEM_DEBUG_INIT(name)
-#endif
-
-#define __SEMAPHORE_INITIALIZER(name,count)             \
-        { ATOMIC_INIT(count), ATOMIC_INIT(0),           \
-          __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)    \
-          __SEM_DEBUG_INIT(name) }
-
-#define __MUTEX_INITIALIZER(name) \
-        __SEMAPHORE_INITIALIZER(name,1)
-
 #define __DECLARE_SEMAPHORE_GENERIC(name,count) \
         struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
Index: linux-2.6-inc/include/asm-sparc64/semaphore.h
===================================================================
--- linux-2.6-inc.orig/include/asm-sparc64/semaphore.h	2004-10-11 23:57:31.000000000 +0200
+++ linux-2.6-inc/include/asm-sparc64/semaphore.h	2004-10-14 03:48:50.180400876 +0200
@@ -13,18 +13,6 @@
 #include <linux/wait.h>
 #include <linux/rwsem.h>
 
-struct semaphore {
-	atomic_t count;
-	wait_queue_head_t wait;
-};
-
-#define __SEMAPHORE_INITIALIZER(name, count) \
-	{ ATOMIC_INIT(count), \
-	  __WAIT_QUEUE_HEAD_INITIALIZER((name).wait) }
-
-#define __MUTEX_INITIALIZER(name) \
-	__SEMAPHORE_INITIALIZER(name, 1)
-
 #define __DECLARE_SEMAPHORE_GENERIC(name, count) \
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
Index: linux-2.6-inc/include/asm-v850/semaphore.h
===================================================================
--- linux-2.6-inc.orig/include/asm-v850/semaphore.h	2004-10-11 23:57:31.000000000 +0200
+++ linux-2.6-inc/include/asm-v850/semaphore.h	2004-10-14 03:48:50.180400876 +0200
@@ -8,19 +8,6 @@
 
 #include <asm/atomic.h>
 
-struct semaphore {
-	atomic_t count;
-	int sleepers;
-	wait_queue_head_t wait;
-};
-
-#define __SEMAPHORE_INITIALIZER(name,count)				      \
-	{ ATOMIC_INIT (count), 0,					      \
-	  __WAIT_QUEUE_HEAD_INITIALIZER ((name).wait) }
-
-#define __MUTEX_INITIALIZER(name)					      \
-	__SEMAPHORE_INITIALIZER (name,1)
-
 #define __DECLARE_SEMAPHORE_GENERIC(name,count)	\
 	struct semaphore name = __SEMAPHORE_INITIALIZER (name,count)
 
Index: linux-2.6-inc/include/asm-sh/semaphore.h
===================================================================
--- linux-2.6-inc.orig/include/asm-sh/semaphore.h	2004-10-11 23:57:31.000000000 +0200
+++ linux-2.6-inc/include/asm-sh/semaphore.h	2004-10-14 03:48:50.180400876 +0200
@@ -20,29 +20,6 @@
 #include <asm/system.h>
 #include <asm/atomic.h>
 
-struct semaphore {
-	atomic_t count;
-	int sleepers;
-	wait_queue_head_t wait;
-#ifdef WAITQUEUE_DEBUG
-	long __magic;
-#endif
-};
-
-#ifdef WAITQUEUE_DEBUG
-# define __SEM_DEBUG_INIT(name) \
-		, (int)&(name).__magic
-#else
-# define __SEM_DEBUG_INIT(name)
-#endif
-
-#define __SEMAPHORE_INITIALIZER(name,count) \
-{ ATOMIC_INIT(count), 0, __WAIT_QUEUE_HEAD_INITIALIZER((name).wait) \
-	__SEM_DEBUG_INIT(name) }
-
-#define __MUTEX_INITIALIZER(name) \
-	__SEMAPHORE_INITIALIZER(name,1)
-
 #define __DECLARE_SEMAPHORE_GENERIC(name,count) \
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
Index: linux-2.6-inc/include/asm-s390/semaphore.h
===================================================================
--- linux-2.6-inc.orig/include/asm-s390/semaphore.h	2004-10-11 23:57:31.000000000 +0200
+++ linux-2.6-inc/include/asm-s390/semaphore.h	2004-10-14 03:48:50.181400704 +0200
@@ -16,22 +16,6 @@
 #include <linux/wait.h>
 #include <linux/rwsem.h>
 
-struct semaphore {
-	/*
-	 * Note that any negative value of count is equivalent to 0,
-	 * but additionally indicates that some process(es) might be
-	 * sleeping on `wait'.
-	 */
-	atomic_t count;
-	wait_queue_head_t wait;
-};
-
-#define __SEMAPHORE_INITIALIZER(name,count) \
-	{ ATOMIC_INIT(count), __WAIT_QUEUE_HEAD_INITIALIZER((name).wait) }
-
-#define __MUTEX_INITIALIZER(name) \
-	__SEMAPHORE_INITIALIZER(name,1)
-
 #define __DECLARE_SEMAPHORE_GENERIC(name,count) \
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
Index: linux-2.6-inc/include/asm-sparc/semaphore.h
===================================================================
--- linux-2.6-inc.orig/include/asm-sparc/semaphore.h	2004-10-11 23:57:31.000000000 +0200
+++ linux-2.6-inc/include/asm-sparc/semaphore.h	2004-10-14 03:48:50.181400704 +0200
@@ -9,29 +9,6 @@
 #include <linux/wait.h>
 #include <linux/rwsem.h>
 
-struct semaphore {
-	atomic24_t count;
-	int sleepers;
-	wait_queue_head_t wait;
-#ifdef WAITQUEUE_DEBUG
-	long __magic;
-#endif
-};
-
-#ifdef WAITQUEUE_DEBUG
-# define __SEM_DEBUG_INIT(name) \
-		, (long)&(name).__magic
-#else
-# define __SEM_DEBUG_INIT(name)
-#endif
-
-#define __SEMAPHORE_INITIALIZER(name,count) \
-{ ATOMIC24_INIT(count), 0, __WAIT_QUEUE_HEAD_INITIALIZER((name).wait) \
-	__SEM_DEBUG_INIT(name) }
-
-#define __MUTEX_INITIALIZER(name) \
-	__SEMAPHORE_INITIALIZER(name,1)
-
 #define __DECLARE_SEMAPHORE_GENERIC(name,count) \
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
Index: linux-2.6-inc/include/asm-ppc/semaphore.h
===================================================================
--- linux-2.6-inc.orig/include/asm-ppc/semaphore.h	2004-10-11 23:57:31.000000000 +0200
+++ linux-2.6-inc/include/asm-ppc/semaphore.h	2004-10-14 03:48:50.181400704 +0200
@@ -21,34 +21,6 @@
 #include <linux/wait.h>
 #include <linux/rwsem.h>
 
-struct semaphore {
-	/*
-	 * Note that any negative value of count is equivalent to 0,
-	 * but additionally indicates that some process(es) might be
-	 * sleeping on `wait'.
-	 */
-	atomic_t count;
-	wait_queue_head_t wait;
-#ifdef WAITQUEUE_DEBUG
-	long __magic;
-#endif
-};
-
-#ifdef WAITQUEUE_DEBUG
-# define __SEM_DEBUG_INIT(name) \
-		, (long)&(name).__magic
-#else
-# define __SEM_DEBUG_INIT(name)
-#endif
-
-#define __SEMAPHORE_INITIALIZER(name, count) \
-	{ ATOMIC_INIT(count), \
-	  __WAIT_QUEUE_HEAD_INITIALIZER((name).wait) \
-	  __SEM_DEBUG_INIT(name) }
-
-#define __MUTEX_INITIALIZER(name) \
-	__SEMAPHORE_INITIALIZER(name, 1)
-
 #define __DECLARE_SEMAPHORE_GENERIC(name, count) \
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
Index: linux-2.6-inc/include/asm-ia64/semaphore.h
===================================================================
--- linux-2.6-inc.orig/include/asm-ia64/semaphore.h	2004-10-11 23:57:31.000000000 +0200
+++ linux-2.6-inc/include/asm-ia64/semaphore.h	2004-10-14 03:48:50.181400704 +0200
@@ -11,29 +11,6 @@
 
 #include <asm/atomic.h>
 
-struct semaphore {
-	atomic_t count;
-	int sleepers;
-	wait_queue_head_t wait;
-#if WAITQUEUE_DEBUG
-	long __magic;		/* initialized by __SEM_DEBUG_INIT() */
-#endif
-};
-
-#if WAITQUEUE_DEBUG
-# define __SEM_DEBUG_INIT(name)		, (long) &(name).__magic
-#else
-# define __SEM_DEBUG_INIT(name)
-#endif
-
-#define __SEMAPHORE_INITIALIZER(name,count)					\
-{										\
-	ATOMIC_INIT(count), 0, __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
-	__SEM_DEBUG_INIT(name)							\
-}
-
-#define __MUTEX_INITIALIZER(name)	__SEMAPHORE_INITIALIZER(name,1)
-
 #define __DECLARE_SEMAPHORE_GENERIC(name,count)					\
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name, count)
 
Index: linux-2.6-inc/include/asm-x86_64/semaphore.h
===================================================================
--- linux-2.6-inc.orig/include/asm-x86_64/semaphore.h	2004-10-11 23:57:31.000000000 +0200
+++ linux-2.6-inc/include/asm-x86_64/semaphore.h	2004-10-14 03:48:50.182400531 +0200
@@ -43,29 +43,6 @@
 #include <linux/rwsem.h>
 #include <linux/stringify.h>
 
-struct semaphore {
-	atomic_t count;
-	int sleepers;
-	wait_queue_head_t wait;
-#ifdef WAITQUEUE_DEBUG
-	long __magic;
-#endif
-};
-
-#ifdef WAITQUEUE_DEBUG
-# define __SEM_DEBUG_INIT(name) \
-		, (int)&(name).__magic
-#else
-# define __SEM_DEBUG_INIT(name)
-#endif
-
-#define __SEMAPHORE_INITIALIZER(name,count) \
-{ ATOMIC_INIT(count), 0, __WAIT_QUEUE_HEAD_INITIALIZER((name).wait) \
-	__SEM_DEBUG_INIT(name) }
-
-#define __MUTEX_INITIALIZER(name) \
-	__SEMAPHORE_INITIALIZER(name,1)
-
 #define __DECLARE_SEMAPHORE_GENERIC(name,count) \
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
Index: linux-2.6-inc/include/asm-parisc/semaphore.h
===================================================================
--- linux-2.6-inc.orig/include/asm-parisc/semaphore.h	2004-10-11 23:57:31.000000000 +0200
+++ linux-2.6-inc/include/asm-parisc/semaphore.h	2004-10-14 03:48:50.182400531 +0200
@@ -30,35 +30,6 @@
 
 #include <asm/system.h>
 
-/*
- * The `count' is initialised to the number of people who are allowed to
- * take the lock.  (Normally we want a mutex, so this is `1').  if
- * `count' is positive, the lock can be taken.  if it's 0, no-one is
- * waiting on it.  if it's -1, at least one task is waiting.
- */
-struct semaphore {
-	spinlock_t	sentry;
-	int		count;
-	wait_queue_head_t wait;
-#if WAITQUEUE_DEBUG
-	long __magic;
-#endif
-};
-
-#if WAITQUEUE_DEBUG
-# define __SEM_DEBUG_INIT(name) \
-		, (long)&(name).__magic
-#else
-# define __SEM_DEBUG_INIT(name)
-#endif
-
-#define __SEMAPHORE_INITIALIZER(name,count) \
-{ SPIN_LOCK_UNLOCKED, count, __WAIT_QUEUE_HEAD_INITIALIZER((name).wait) \
-	__SEM_DEBUG_INIT(name) }
-
-#define __MUTEX_INITIALIZER(name) \
-	__SEMAPHORE_INITIALIZER(name,1)
-
 #define __DECLARE_SEMAPHORE_GENERIC(name,count) \
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
Index: linux-2.6-inc/include/asm-mips/semaphore.h
===================================================================
--- linux-2.6-inc.orig/include/asm-mips/semaphore.h	2004-10-11 23:57:31.000000000 +0200
+++ linux-2.6-inc/include/asm-mips/semaphore.h	2004-10-14 03:53:54.651867952 +0200
@@ -29,34 +29,6 @@
 #include <linux/wait.h>
 #include <linux/rwsem.h>
 
-struct semaphore {
-	/*
-	 * Note that any negative value of count is equivalent to 0,
-	 * but additionally indicates that some process(es) might be
-	 * sleeping on `wait'.
-	 */
-	atomic_t count;
-	wait_queue_head_t wait;
-#ifdef WAITQUEUE_DEBUG
-	long __magic;
-#endif
-};
-
-#ifdef WAITQUEUE_DEBUG
-# define __SEM_DEBUG_INIT(name) \
-		, (long)&(name).__magic
-#else
-# define __SEM_DEBUG_INIT(name)
-#endif
-
-#define __SEMAPHORE_INITIALIZER(name, count) \
-	{ ATOMIC_INIT(count), \
-	  __WAIT_QUEUE_HEAD_INITIALIZER((name).wait) \
-	  __SEM_DEBUG_INIT(name) }
-
-#define __MUTEX_INITIALIZER(name) \
-	__SEMAPHORE_INITIALIZER(name, 1)
-
 #define __DECLARE_SEMAPHORE_GENERIC(name, count) \
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
Index: linux-2.6-inc/include/asm-m68knommu/semaphore.h
===================================================================
--- linux-2.6-inc.orig/include/asm-m68knommu/semaphore.h	2004-10-11 23:57:31.000000000 +0200
+++ linux-2.6-inc/include/asm-m68knommu/semaphore.h	2004-10-14 03:48:50.182400531 +0200
@@ -22,29 +22,6 @@
  */
 
 
-struct semaphore {
-	atomic_t count;
-	atomic_t waking;
-	wait_queue_head_t wait;
-#if WAITQUEUE_DEBUG
-	long __magic;
-#endif
-};
-
-#if WAITQUEUE_DEBUG
-# define __SEM_DEBUG_INIT(name) \
-		, (long)&(name).__magic
-#else
-# define __SEM_DEBUG_INIT(name)
-#endif
-
-#define __SEMAPHORE_INITIALIZER(name,count) \
-{ ATOMIC_INIT(count), ATOMIC_INIT(0), __WAIT_QUEUE_HEAD_INITIALIZER((name).wait) \
-	__SEM_DEBUG_INIT(name) }
-
-#define __MUTEX_INITIALIZER(name) \
-	__SEMAPHORE_INITIALIZER(name,1)
-
 #define __DECLARE_SEMAPHORE_GENERIC(name,count) \
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
Index: linux-2.6-inc/include/asm-h8300/semaphore.h
===================================================================
--- linux-2.6-inc.orig/include/asm-h8300/semaphore.h	2004-10-11 23:57:31.000000000 +0200
+++ linux-2.6-inc/include/asm-h8300/semaphore.h	2004-10-14 03:48:50.182400531 +0200
@@ -22,32 +22,6 @@
  */
 
 
-struct semaphore {
-	atomic_t count;
-	int sleepers;
-	wait_queue_head_t wait;
-#if WAITQUEUE_DEBUG
-	long __magic;
-#endif
-};
-
-#if WAITQUEUE_DEBUG
-# define __SEM_DEBUG_INIT(name) \
-		, (long)&(name).__magic
-#else
-# define __SEM_DEBUG_INIT(name)
-#endif
-
-#define __SEMAPHORE_INITIALIZER(name,count) \
-{ ATOMIC_INIT(count), 0, __WAIT_QUEUE_HEAD_INITIALIZER((name).wait) \
-	__SEM_DEBUG_INIT(name) }
-
-#define __MUTEX_INITIALIZER(name) \
-	__SEMAPHORE_INITIALIZER(name,1)
-
-#define __DECLARE_SEMAPHORE_GENERIC(name,count) \
-	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
-
 #define DECLARE_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
 #define DECLARE_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
 
Index: linux-2.6-inc/include/asm-m68k/semaphore.h
===================================================================
--- linux-2.6-inc.orig/include/asm-m68k/semaphore.h	2004-10-11 23:57:31.000000000 +0200
+++ linux-2.6-inc/include/asm-m68k/semaphore.h	2004-10-14 03:48:50.183400359 +0200
@@ -23,29 +23,6 @@
  */
 
 
-struct semaphore {
-	atomic_t count;
-	atomic_t waking;
-	wait_queue_head_t wait;
-#ifdef WAITQUEUE_DEBUG
-	long __magic;
-#endif
-};
-
-#ifdef WAITQUEUE_DEBUG
-# define __SEM_DEBUG_INIT(name) \
-		, (long)&(name).__magic
-#else
-# define __SEM_DEBUG_INIT(name)
-#endif
-
-#define __SEMAPHORE_INITIALIZER(name,count) \
-{ ATOMIC_INIT(count), ATOMIC_INIT(0), __WAIT_QUEUE_HEAD_INITIALIZER((name).wait) \
-	__SEM_DEBUG_INIT(name) }
-
-#define __MUTEX_INITIALIZER(name) \
-	__SEMAPHORE_INITIALIZER(name,1)
-
 #define __DECLARE_SEMAPHORE_GENERIC(name,count) \
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
Index: linux-2.6-inc/include/asm-alpha/semaphore.h
===================================================================
--- linux-2.6-inc.orig/include/asm-alpha/semaphore.h	2004-10-11 23:57:31.000000000 +0200
+++ linux-2.6-inc/include/asm-alpha/semaphore.h	2004-10-14 03:48:50.183400359 +0200
@@ -15,28 +15,6 @@
 #include <linux/wait.h>
 #include <linux/rwsem.h>
 
-struct semaphore {
-	atomic_t count;
-	wait_queue_head_t wait;
-#ifdef WAITQUEUE_DEBUG
-	long __magic;
-#endif
-};
-
-#ifdef WAITQUEUE_DEBUG
-# define __SEM_DEBUG_INIT(name)		, (long)&(name).__magic
-#else
-# define __SEM_DEBUG_INIT(name)
-#endif
-
-#define __SEMAPHORE_INITIALIZER(name,count)		\
-	{ ATOMIC_INIT(count),				\
-	  __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
-	  __SEM_DEBUG_INIT(name) }
-
-#define __MUTEX_INITIALIZER(name)			\
-	__SEMAPHORE_INITIALIZER(name,1)
-
 #define __DECLARE_SEMAPHORE_GENERIC(name,count)		\
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
Index: linux-2.6-inc/include/asm-ppc64/semaphore.h
===================================================================
--- linux-2.6-inc.orig/include/asm-ppc64/semaphore.h	2004-10-11 23:57:31.000000000 +0200
+++ linux-2.6-inc/include/asm-ppc64/semaphore.h	2004-10-14 03:48:50.183400359 +0200
@@ -15,34 +15,6 @@
 #include <linux/wait.h>
 #include <linux/rwsem.h>
 
-struct semaphore {
-	/*
-	 * Note that any negative value of count is equivalent to 0,
-	 * but additionally indicates that some process(es) might be
-	 * sleeping on `wait'.
-	 */
-	atomic_t count;
-	wait_queue_head_t wait;
-#ifdef WAITQUEUE_DEBUG
-	long __magic;
-#endif
-};
-
-#ifdef WAITQUEUE_DEBUG
-# define __SEM_DEBUG_INIT(name) \
-		, (long)&(name).__magic
-#else
-# define __SEM_DEBUG_INIT(name)
-#endif
-
-#define __SEMAPHORE_INITIALIZER(name, count) \
-	{ ATOMIC_INIT(count), \
-	  __WAIT_QUEUE_HEAD_INITIALIZER((name).wait) \
-	  __SEM_DEBUG_INIT(name) }
-
-#define __MUTEX_INITIALIZER(name) \
-	__SEMAPHORE_INITIALIZER(name, 1)
-
 #define __DECLARE_SEMAPHORE_GENERIC(name, count) \
 	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
 
Index: linux-2.6-inc/include/asm-arm/semaphore.h
===================================================================
--- linux-2.6-inc.orig/include/asm-arm/semaphore.h	2004-10-11 23:57:31.000000000 +0200
+++ linux-2.6-inc/include/asm-arm/semaphore.h	2004-10-14 03:48:50.183400359 +0200
@@ -12,29 +12,6 @@
 #include <asm/atomic.h>
 #include <asm/locks.h>
 
-struct semaphore {
-	atomic_t count;
-	int sleepers;
-	wait_queue_head_t wait;
-#ifdef WAITQUEUE_DEBUG
-	long __magic;
-#endif
-};
-
-#ifdef WAITQUEUE_DEBUG
-# define __SEM_DEBUG_INIT(name)	.__magic = (long)&(name).__magic
-#else
-# define __SEM_DEBUG_INIT(name)
-#endif
-
-#define __SEMAPHORE_INIT(name,cnt) {				\
-	.count	= ATOMIC_INIT(cnt),				\
-	.wait	= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait),	\
-	__SEM_DEBUG_INIT(name)					\
-}
-
-#define __MUTEX_INITIALIZER(name) __SEMAPHORE_INIT(name,1)
-
 #define __DECLARE_SEMAPHORE_GENERIC(name,count)	\
 	struct semaphore name = __SEMAPHORE_INIT(name,count)
 
Index: linux-2.6-inc/include/asm-sparc64/rwsem.h
===================================================================
--- linux-2.6-inc.orig/include/asm-sparc64/rwsem.h	2003-07-18 23:22:46.000000000 +0200
+++ linux-2.6-inc/include/asm-sparc64/rwsem.h	2004-10-14 03:48:50.184400186 +0200
@@ -18,21 +18,6 @@
 
 struct rwsem_waiter;
 
-struct rw_semaphore {
-	signed int count;
-#define RWSEM_UNLOCKED_VALUE		0x00000000
-#define RWSEM_ACTIVE_BIAS		0x00000001
-#define RWSEM_ACTIVE_MASK		0x0000ffff
-#define RWSEM_WAITING_BIAS		0xffff0000
-#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
-#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
-	spinlock_t		wait_lock;
-	struct list_head	wait_list;
-};
-
-#define __RWSEM_INITIALIZER(name) \
-{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, LIST_HEAD_INIT((name).wait_list) }
-
 #define DECLARE_RWSEM(name) \
 	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
 
Index: linux-2.6-inc/include/asm-s390/rwsem.h
===================================================================
--- linux-2.6-inc.orig/include/asm-s390/rwsem.h	2004-02-04 20:40:45.000000000 +0100
+++ linux-2.6-inc/include/asm-s390/rwsem.h	2004-10-14 03:48:50.184400186 +0200
@@ -54,35 +54,6 @@ extern struct rw_semaphore *rwsem_wake(s
 extern struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *);
 extern struct rw_semaphore *rwsem_downgrade_write(struct rw_semaphore *);
 
-/*
- * the semaphore definition
- */
-struct rw_semaphore {
-	signed long		count;
-	spinlock_t		wait_lock;
-	struct list_head	wait_list;
-};
-
-#ifndef __s390x__
-#define RWSEM_UNLOCKED_VALUE	0x00000000
-#define RWSEM_ACTIVE_BIAS	0x00000001
-#define RWSEM_ACTIVE_MASK	0x0000ffff
-#define RWSEM_WAITING_BIAS	(-0x00010000)
-#else /* __s390x__ */
-#define RWSEM_UNLOCKED_VALUE	0x0000000000000000L
-#define RWSEM_ACTIVE_BIAS	0x0000000000000001L
-#define RWSEM_ACTIVE_MASK	0x00000000ffffffffL
-#define RWSEM_WAITING_BIAS	(-0x0000000100000000L)
-#endif /* __s390x__ */
-#define RWSEM_ACTIVE_READ_BIAS	RWSEM_ACTIVE_BIAS
-#define RWSEM_ACTIVE_WRITE_BIAS	(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
-
-/*
- * initialisation
- */
-#define __RWSEM_INITIALIZER(name) \
-{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, LIST_HEAD_INIT((name).wait_list) }
-
 #define DECLARE_RWSEM(name) \
 	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
 
Index: linux-2.6-inc/include/asm-sh/rwsem.h
===================================================================
--- linux-2.6-inc.orig/include/asm-sh/rwsem.h	2003-07-18 23:22:44.000000000 +0200
+++ linux-2.6-inc/include/asm-sh/rwsem.h	2004-10-14 03:48:50.184400186 +0200
@@ -12,38 +12,6 @@
 #include <asm/atomic.h>
 #include <asm/system.h>
 
-/*
- * the semaphore definition
- */
-struct rw_semaphore {
-	long		count;
-#define RWSEM_UNLOCKED_VALUE		0x00000000
-#define RWSEM_ACTIVE_BIAS		0x00000001
-#define RWSEM_ACTIVE_MASK		0x0000ffff
-#define RWSEM_WAITING_BIAS		(-0x00010000)
-#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
-#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
-	spinlock_t		wait_lock;
-	struct list_head	wait_list;
-#if RWSEM_DEBUG
-	int			debug;
-#endif
-};
-
-/*
- * initialisation
- */
-#if RWSEM_DEBUG
-#define __RWSEM_DEBUG_INIT      , 0
-#else
-#define __RWSEM_DEBUG_INIT	/* */
-#endif
-
-#define __RWSEM_INITIALIZER(name) \
-	{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, \
-	  LIST_HEAD_INIT((name).wait_list) \
-	  __RWSEM_DEBUG_INIT }
-
 #define DECLARE_RWSEM(name)		\
 	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
 
Index: linux-2.6-inc/include/asm-x86_64/rwsem.h
===================================================================
--- linux-2.6-inc.orig/include/asm-x86_64/rwsem.h	2003-07-18 23:22:47.000000000 +0200
+++ linux-2.6-inc/include/asm-x86_64/rwsem.h	2004-10-14 03:48:50.184400186 +0200
@@ -49,37 +49,6 @@ extern struct rw_semaphore *rwsem_down_w
 extern struct rw_semaphore *rwsem_wake(struct rw_semaphore *);
 extern struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem);
 
-/*
- * the semaphore definition
- */
-struct rw_semaphore {
-	signed int		count;
-#define RWSEM_UNLOCKED_VALUE		0x00000000
-#define RWSEM_ACTIVE_BIAS		0x00000001
-#define RWSEM_ACTIVE_MASK		0x0000ffff
-#define RWSEM_WAITING_BIAS		(-0x00010000)
-#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
-#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
-	spinlock_t		wait_lock;
-	struct list_head	wait_list;
-#if RWSEM_DEBUG
-	int			debug;
-#endif
-};
-
-/*
- * initialisation
- */
-#if RWSEM_DEBUG
-#define __RWSEM_DEBUG_INIT      , 0
-#else
-#define __RWSEM_DEBUG_INIT	/* */
-#endif
-
-#define __RWSEM_INITIALIZER(name) \
-{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, LIST_HEAD_INIT((name).wait_list) \
-	__RWSEM_DEBUG_INIT }
-
 #define DECLARE_RWSEM(name) \
 	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
 
Index: linux-2.6-inc/include/asm-alpha/rwsem.h
===================================================================
--- linux-2.6-inc.orig/include/asm-alpha/rwsem.h	2003-07-18 23:22:36.000000000 +0200
+++ linux-2.6-inc/include/asm-alpha/rwsem.h	2004-10-14 03:48:50.185400014 +0200
@@ -23,34 +23,6 @@ extern struct rw_semaphore *rwsem_down_w
 extern struct rw_semaphore *rwsem_wake(struct rw_semaphore *);
 extern struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem);
 
-/*
- * the semaphore definition
- */
-struct rw_semaphore {
-	long			count;
-#define RWSEM_UNLOCKED_VALUE		0x0000000000000000L
-#define RWSEM_ACTIVE_BIAS		0x0000000000000001L
-#define RWSEM_ACTIVE_MASK		0x00000000ffffffffL
-#define RWSEM_WAITING_BIAS		(-0x0000000100000000L)
-#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
-#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
-	spinlock_t		wait_lock;
-	struct list_head	wait_list;
-#if RWSEM_DEBUG
-	int			debug;
-#endif
-};
-
-#if RWSEM_DEBUG
-#define __RWSEM_DEBUG_INIT      , 0
-#else
-#define __RWSEM_DEBUG_INIT	/* */
-#endif
-
-#define __RWSEM_INITIALIZER(name) \
-	{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, \
-	LIST_HEAD_INIT((name).wait_list) __RWSEM_DEBUG_INIT }
-
 #define DECLARE_RWSEM(name) \
 	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
 
Index: linux-2.6-inc/include/asm-ppc/rwsem.h
===================================================================
--- linux-2.6-inc.orig/include/asm-ppc/rwsem.h	2004-05-10 19:17:13.000000000 +0200
+++ linux-2.6-inc/include/asm-ppc/rwsem.h	2004-10-14 03:48:50.185400014 +0200
@@ -13,39 +13,6 @@
 #include <asm/atomic.h>
 #include <asm/system.h>
 
-/*
- * the semaphore definition
- */
-struct rw_semaphore {
-	/* XXX this should be able to be an atomic_t  -- paulus */
-	signed long		count;
-#define RWSEM_UNLOCKED_VALUE		0x00000000
-#define RWSEM_ACTIVE_BIAS		0x00000001
-#define RWSEM_ACTIVE_MASK		0x0000ffff
-#define RWSEM_WAITING_BIAS		(-0x00010000)
-#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
-#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
-	spinlock_t		wait_lock;
-	struct list_head	wait_list;
-#ifdef RWSEM_DEBUG
-	int			debug;
-#endif
-};
-
-/*
- * initialisation
- */
-#ifdef RWSEM_DEBUG
-#define __RWSEM_DEBUG_INIT      , 0
-#else
-#define __RWSEM_DEBUG_INIT	/* */
-#endif
-
-#define __RWSEM_INITIALIZER(name) \
-	{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, \
-	  LIST_HEAD_INIT((name).wait_list) \
-	  __RWSEM_DEBUG_INIT }
-
 #define DECLARE_RWSEM(name)		\
 	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
 
Index: linux-2.6-inc/include/asm-ppc64/rwsem.h
===================================================================
--- linux-2.6-inc.orig/include/asm-ppc64/rwsem.h	2003-09-27 21:46:39.000000000 +0200
+++ linux-2.6-inc/include/asm-ppc64/rwsem.h	2004-10-14 03:48:50.185400014 +0200
@@ -18,39 +18,6 @@
 #include <asm/atomic.h>
 #include <asm/system.h>
 
-/*
- * the semaphore definition
- */
-struct rw_semaphore {
-	/* XXX this should be able to be an atomic_t  -- paulus */
-	signed int		count;
-#define RWSEM_UNLOCKED_VALUE		0x00000000
-#define RWSEM_ACTIVE_BIAS		0x00000001
-#define RWSEM_ACTIVE_MASK		0x0000ffff
-#define RWSEM_WAITING_BIAS		(-0x00010000)
-#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
-#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
-	spinlock_t		wait_lock;
-	struct list_head	wait_list;
-#if RWSEM_DEBUG
-	int			debug;
-#endif
-};
-
-/*
- * initialisation
- */
-#if RWSEM_DEBUG
-#define __RWSEM_DEBUG_INIT      , 0
-#else
-#define __RWSEM_DEBUG_INIT	/* */
-#endif
-
-#define __RWSEM_INITIALIZER(name) \
-	{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, \
-	  LIST_HEAD_INIT((name).wait_list) \
-	  __RWSEM_DEBUG_INIT }
-
 #define DECLARE_RWSEM(name)		\
 	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
 
Index: linux-2.6-inc/include/asm-ia64/rwsem.h
===================================================================
--- linux-2.6-inc.orig/include/asm-ia64/rwsem.h	2003-08-23 21:06:02.000000000 +0200
+++ linux-2.6-inc/include/asm-ia64/rwsem.h	2004-10-14 03:48:50.185400014 +0200
@@ -25,39 +25,6 @@
 
 #include <asm/intrinsics.h>
 
-/*
- * the semaphore definition
- */
-struct rw_semaphore {
-	signed int		count;
-	spinlock_t		wait_lock;
-	struct list_head	wait_list;
-#if RWSEM_DEBUG
-	int			debug;
-#endif
-};
-
-#define RWSEM_UNLOCKED_VALUE		0x00000000
-#define RWSEM_ACTIVE_BIAS		0x00000001
-#define RWSEM_ACTIVE_MASK		0x0000ffff
-#define RWSEM_WAITING_BIAS		(-0x00010000)
-#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
-#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
-
-/*
- * initialization
- */
-#if RWSEM_DEBUG
-#define __RWSEM_DEBUG_INIT      , 0
-#else
-#define __RWSEM_DEBUG_INIT	/* */
-#endif
-
-#define __RWSEM_INITIALIZER(name) \
-	{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, \
-	  LIST_HEAD_INIT((name).wait_list) \
-	  __RWSEM_DEBUG_INIT }
-
 #define DECLARE_RWSEM(name) \
 	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
 
Index: linux-2.6-inc/include/linux/wait.h
===================================================================
--- linux-2.6-inc.orig/include/linux/wait.h	2004-08-14 13:01:17.000000000 +0200
+++ linux-2.6-inc/include/linux/wait.h	2004-10-14 03:48:50.186399841 +0200
@@ -12,45 +12,16 @@
 
 #include <linux/config.h>
 #include <linux/list.h>
-#include <linux/stddef.h>
-#include <linux/spinlock.h>
+#include <linux/waitlock_types.h>
 #include <asm/system.h>
 
-typedef struct __wait_queue wait_queue_t;
-typedef int (*wait_queue_func_t)(wait_queue_t *wait, unsigned mode, int sync, void *key);
-int default_wake_function(wait_queue_t *wait, unsigned mode, int sync, void *key);
-
-struct __wait_queue {
-	unsigned int flags;
-#define WQ_FLAG_EXCLUSIVE	0x01
-	struct task_struct * task;
-	wait_queue_func_t func;
-	struct list_head task_list;
-};
-
-struct __wait_queue_head {
-	spinlock_t lock;
-	struct list_head task_list;
-};
-typedef struct __wait_queue_head wait_queue_head_t;
-
-
 /*
  * Macros for declaration and initialisaton of the datatypes
  */
 
-#define __WAITQUEUE_INITIALIZER(name, tsk) {				\
-	.task		= tsk,						\
-	.func		= default_wake_function,			\
-	.task_list	= { NULL, NULL } }
-
 #define DECLARE_WAITQUEUE(name, tsk)					\
 	wait_queue_t name = __WAITQUEUE_INITIALIZER(name, tsk)
 
-#define __WAIT_QUEUE_HEAD_INITIALIZER(name) {				\
-	.lock		= SPIN_LOCK_UNLOCKED,				\
-	.task_list	= { &(name).task_list, &(name).task_list } }
-
 #define DECLARE_WAIT_QUEUE_HEAD(name) \
 	wait_queue_head_t name = __WAIT_QUEUE_HEAD_INITIALIZER(name)
 
