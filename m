Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964908AbVLPXOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964908AbVLPXOb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 18:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbVLPXOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 18:14:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34268 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964821AbVLPXN0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 18:13:26 -0500
Date: Fri, 16 Dec 2005 23:13:07 GMT
Message-Id: <200512162313.jBGND7g4019623@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 1/12]: MUTEX: Implement mutexes
In-Reply-To: <dhowells1134774786@warthog.cambridge.redhat.com>
References: <dhowells1134774786@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch introduces a simple mutex implementation as an alternative
to the usual semaphore implementation where simple mutex functionality is all
that is required.

This is useful in two ways:

 (1) A number of archs only provide very simple atomic instructions (such as
     XCHG on i386, TAS on M68K, SWAP on FRV) which aren't sufficient to
     implement full semaphore support directly. Instead spinlocks must be
     employed to implement fuller functionality.

 (2) This makes it more obvious that a mutex is a mutex and restricts the
     capabilites to make it more easier to debug.

This patch set does the following:

 (1) Renames DECLARE_MUTEX and DECLARE_MUTEX_LOCKED to be DECLARE_SEM_MUTEX and
     DECLARE_SEM_MUTEX_LOCKED for counting semaphores.

 (2) Provides a wrapper around the counting semaphore to provide a default
     mutex implementation with certain added debugging capabilities that aren't
     appropriate for a counting semaphore due to the nature of such. The
     type is:

	struct mutex

     Available mutex operations are:

	mutex_init()
	mutex_init_locked()
	mutex_trylock()
	mutex_lock()
	mutex_lock_interruptible()
	mutex_unlock()
	mutex_is_locked()

     Note that the trylock op has the opposite result logic to down_trylock,
     but in keeping with rwsems and spinlocks it returns true on success. In
     addition the following static initialisers are available:

	DECLARE_MUTEX();
	struct mutex name = MUTEX_UNLOCKED(name);

 (3) Provides an xchg() based mutex template selectable by setting
     CONFIG_ARCH_XCHG_MUTEX that, by default, uses xchg() to manipulate the
     state. This mutex only requires two states.

     If something more appropriate is available, the use of xchg() may be
     overridden by the arch by #defining the following macros in asm/system.h:

	__mutex_trylock(mutex)
	__mutex_release(mutex)
	mutex_is_locked(mutex)

     Furthermore the two state values involved may also be overridden by
     #defining:

	__MUTEX_STATE_UNLOCKED
	__MUTEX_STATE_LOCKED


     Overriding is possible by setting CONFIG_ARCH_IMPLEMENTS_MUTEX and
     supplying asm/mutex.h

     Partial overriding is possible by #defining mutex_grab(), mutex_release()
     and is_mutex_locked() to perform the appropriate optimised functions.

 (4) Provides a cmpxchg() based semaphore template selectable by setting
     CONFIG_ARCH_CMPXCHG_MUTEX that, by default, uses cmpxchg() to manipulate
     the state. This mutex requires three states.

     The use of cmpxchg() may be overridden by #defining the following macro in
     asm/system.h:

	__mutex_cmpxchg().

     The macro should be able to deal with unsigned long values as it's used to
     store the address of the thread info struct when mutex owner debugging is
     enabled.

 (5) If the arch wishes to provide the entire mutex implementation itself, it
     should set CONFIG_ARCH_IMPLEMENTS_MUTEX and provide asm/mutex.h.

 (6) Provides linux/mutex.h as a common include for gaining access to mutex
     semaphores.

 (7) Provides a debugging config option CONFIG_DEBUG_MUTEX_OWNER by which the
     mutex owner can be tracked and by which over-upping can be detected.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 mutex-core-2615rc5-2.diff
 include/linux/mutex-cmpxchg.h |  109 ++++++++++++++++++++++++++
 include/linux/mutex-default.h |  127 +++++++++++++++++++++++++++++++
 include/linux/mutex-xchg.h    |  171 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/mutex.h         |   46 +++++++++++
 lib/Kconfig.debug             |    8 +
 5 files changed, 461 insertions(+)

diff -uNrp linux-2.6.15-rc5/include/linux/mutex-cmpxchg.h linux-2.6.15-rc5-mutex/include/linux/mutex-cmpxchg.h
--- linux-2.6.15-rc5/include/linux/mutex-cmpxchg.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15-rc5-mutex/include/linux/mutex-cmpxchg.h	2005-12-15 19:40:48.000000000 +0000
@@ -0,0 +1,109 @@
+/* mutex-cmpxchg.h: compare-and-exchange-based mutexes
+ *
+ * Copyright (C) 2005 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ *
+ * This requires the arch to define CONFIG_ARCH_CMPXCHG_MUTEX
+ *
+ * The arch must also provide a cmpxchg() capable of dealing with a long
+ *
+ * See kernel/mutex-cmpxchg.c for the slow-path implementation.
+ */
+#ifndef _LINUX_MUTEX_CMPXCHG_H
+#define _LINUX_MUTEX_CMPXCHG_H
+
+#ifndef _LINUX_MUTEX_H
+#error linux/mutex-cmpxchg.h should not be included directly; use linux/mutex.h instead
+#endif
+
+#ifndef __ASSEMBLY__
+
+#include <linux/linkage.h>
+#include <linux/wait.h>
+#include <linux/spinlock.h>
+#include <asm/system.h>
+
+/*
+ * the mutex semaphore definition
+ * - if state is 0, then the mutex is available
+ * - if state is non-zero, then the mutex is busy and the state points to the
+ *   owner if debugging
+ *   - if the bottom bit is clear, then there are no waiters
+ *   - if the bottom bit is set, then there are processes waiting for the mutex
+ * - if wait_list is not empty, then there are processes waiting for the mutex
+ */
+struct mutex {
+	volatile unsigned long	state;
+	spinlock_t		wait_lock;
+	struct list_head	wait_list;
+};
+
+/*
+ * attempt to exchange the state of the mutex for a different one
+ */
+#ifndef __mutex_cmpxchg
+#define __mutex_cmpxchg(m, old, new) cmpxchg(&(m)->state, (old), (new))
+#endif
+
+/*
+ * mutex_is_locked() returns non-zero if the mutex is locked
+ */
+#define mutex_is_locked(mutex)	((mutex)->state)
+
+#ifdef CONFIG_DEBUG_MUTEX_OWNER
+#define __mutex_owner() ((unsigned long) current_thread_info())
+#else
+#define __mutex_owner() 2UL
+#endif
+
+#define MUTEX_UNLOCKED(name)					\
+{								\
+	.state		= 0,					\
+	.wait_lock	= SPIN_LOCK_UNLOCKED,			\
+	.wait_list	= LIST_HEAD_INIT((name).wait_list)	\
+}
+
+#define DECLARE_MUTEX(name) \
+	struct mutex name = MUTEX_UNLOCKED(name)
+
+static inline void __mutex_init(struct mutex *mutex, unsigned state)
+{
+	mutex->state = state;
+	spin_lock_init(&mutex->wait_lock);
+	INIT_LIST_HEAD(&mutex->wait_list);
+}
+
+static inline void mutex_init(struct mutex *mutex)
+{
+	__mutex_init(mutex, 0);
+}
+
+static inline void mutex_init_locked(struct mutex *mutex)
+{
+	__mutex_init(mutex, __mutex_owner());
+}
+
+/*
+ * attempt to grab the mutex without waiting for it to become available
+ * - returns true if we acquired it
+ */
+static inline int mutex_trylock(struct mutex *mutex)
+{
+	unsigned long state = __mutex_owner();
+
+	return likely(__mutex_cmpxchg(mutex, 0, state) == 0);
+}
+
+extern void fastcall mutex_lock(struct mutex *mutex);
+extern int fastcall  mutex_lock_interruptible(struct mutex *mutex);
+extern void fastcall mutex_unlock(struct mutex *mutex);
+
+
+#endif /* __ASSEMBLY__ */
+#endif /* _LINUX_MUTEX_CMPXCHG_H */
diff -uNrp linux-2.6.15-rc5/include/linux/mutex-default.h linux-2.6.15-rc5-mutex/include/linux/mutex-default.h
--- linux-2.6.15-rc5/include/linux/mutex-default.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15-rc5-mutex/include/linux/mutex-default.h	2005-12-16 17:41:27.000000000 +0000
@@ -0,0 +1,127 @@
+/* mutex-default.h: default mutex implementation: wrap semaphores
+ *
+ * Copyright (C) 2005 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _LINUX_MUTEX_DEFAULT_H
+#define _LINUX_MUTEX_DEFAULT_H
+
+#ifndef _LINUX_MUTEX_H
+#error linux/mutex-cmpxchg.h should not be included directly; use linux/mutex.h instead
+#endif
+
+#ifndef __ASSEMBLY__
+
+#include <asm/semaphore.h>
+
+/*
+ * the mutex definition
+ */
+struct mutex {
+	struct semaphore	sem;
+#ifdef CONFIG_DEBUG_MUTEX_OWNER
+	struct thread_info	*__owner;
+#endif
+};
+
+#ifdef CONFIG_DEBUG_MUTEX_OWNER
+# define __MUTEX_OWNER_INIT(owner) , .__owner = NULL
+#else
+# define __MUTEX_OWNER_INIT(owner)
+#endif
+
+#define MUTEX_UNLOCKED(name)				\
+{							\
+	.sem = __SEMAPHORE_INITIALIZER(name.sem, 1)	\
+	__MUTEX_OWNER_INIT(owner)			\
+}
+
+#define DECLARE_MUTEX(name) \
+	struct mutex name = MUTEX_UNLOCKED(name)
+
+static inline void mutex_init(struct mutex *mutex)
+{
+	sema_init(&mutex->sem, 1);
+}
+
+static inline void mutex_init_locked(struct mutex *mutex)
+{
+	sema_init(&mutex->sem, 0);
+#ifdef CONFIG_DEBUG_MUTEX_OWNER
+	mutex->__owner = current_thread_info();
+#endif
+}
+
+/*
+ * attempt to grab the mutex without waiting for it to become available
+ * - returns true if we acquired it
+ */
+static inline
+int mutex_trylock(struct mutex *mutex)
+{
+	int successful = (down_trylock(&mutex->sem) == 0);
+
+#ifdef CONFIG_DEBUG_MUTEX_OWNER
+	if (likely(successful))
+		mutex->__owner = current_thread_info();
+#endif
+
+	return successful;
+}
+
+/*
+ * fast path for attempting to grab the mutex
+ */
+static inline fastcall __sched
+void mutex_lock(struct mutex *mutex)
+{
+	down(&mutex->sem);
+#ifdef CONFIG_DEBUG_MUTEX_OWNER
+	mutex->__owner = current_thread_info();
+#endif
+}
+
+/*
+ * attempt to grab the mutex interruptibly
+ */
+static inline fastcall __sched
+int mutex_lock_interruptible(struct mutex *mutex)
+{
+	int ret = down_interruptible(&mutex->sem);
+
+#ifdef CONFIG_DEBUG_MUTEX_OWNER
+	if (unlikely(ret < 0))
+		mutex->__owner = current_thread_info();
+#endif
+
+	return ret;
+}
+
+/*
+ * unlock the mutex
+ */
+static inline fastcall __sched
+void fastcall mutex_unlock(struct mutex *mutex)
+{
+#ifdef CONFIG_DEBUG_MUTEX_OWNER
+	if (mutex->__owner != current_thread_info())
+		BUG();
+	mutex->__owner = NULL;
+#endif
+
+	up(&mutex->sem);
+}
+
+/*
+ * see if the mutex is locked
+ */
+#define mutex_is_locked(mutex)	(sem_is_locked(&(mutex)->sem))
+
+#endif /* __ASSEMBLY__ */
+#endif /* _LINUX_MUTEX_DEFAULT_H */
diff -uNrp linux-2.6.15-rc5/include/linux/mutex-xchg.h linux-2.6.15-rc5-mutex/include/linux/mutex-xchg.h
--- linux-2.6.15-rc5/include/linux/mutex-xchg.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15-rc5-mutex/include/linux/mutex-xchg.h	2005-12-16 17:20:27.000000000 +0000
@@ -0,0 +1,171 @@
+/* mutex-xchg.h: simple exchange-based mutexes
+ *
+ * Copyright (C) 2005 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ *
+ * This doesn't require the arch to do anything for straightforward xchg()
+ * based mutexes
+ *
+ * If the sets CONFIG_ARCH_IMPLEMENTS_MUTEX then this implementation will not
+ * be used, and the arch should supply asm/mutex.h.
+ *
+ * If the arch defines __mutex_trylock(), __mutex_release() and
+ * mutex_is_locked() for itself, then those will be used to provide the
+ * appropriate functionality.
+ *
+ * The arch may also override the mutex state values if it wishes.
+ *
+ * See kernel/mutex-xchg.c for the slow-path implementation.
+ */
+#ifndef _LINUX_MUTEX_XCHG_H
+#define _LINUX_MUTEX_XCHG_H
+
+#ifndef _LINUX_MUTEX_H
+#error linux/mutex-xchg.h should not be included directly; use linux/mutex.h instead
+#endif
+
+#ifndef __ASSEMBLY__
+
+#include <linux/linkage.h>
+#include <linux/wait.h>
+#include <linux/spinlock.h>
+#include <asm/system.h>
+
+/*
+ * the values corresponding to the possible states of the mutex
+ */
+#ifndef __MUTEX_STATE_UNLOCKED
+#define __MUTEX_STATE_UNLOCKED	0
+#define __MUTEX_STATE_LOCKED	1
+#endif
+
+/*
+ * the mutex semaphore definition
+ * - if state is 0, then the mutex is available
+ * - if state is non-zero, then the mutex is locked
+ * - if wait_list is not empty, then there are processes waiting for the mutex
+ */
+struct mutex {
+	volatile int		state;
+	spinlock_t		wait_lock;
+	struct list_head	wait_list;
+#ifdef CONFIG_DEBUG_MUTEX_OWNER
+	struct thread_info	*__owner;
+#endif
+};
+
+#ifndef __mutex_trylock
+/*
+ * __mutex_trylock() attempts to grab the mutex and returns true if successful
+ */
+#define __mutex_trylock(mutex) \
+	(xchg(&(mutex)->state, __MUTEX_STATE_LOCKED) == __MUTEX_STATE_UNLOCKED)
+
+/*
+ * __mutex_release() releases the mutex
+ */
+#define __mutex_release(mutex) \
+	do { (mutex)->state = __MUTEX_STATE_UNLOCKED; } while(0)
+
+/*
+ * mutex_is_locked() returns true if the mutex is locked
+ */
+#define mutex_is_locked(mutex)	((mutex)->state == __MUTEX_STATE_LOCKED)
+#endif
+
+#ifdef CONFIG_DEBUG_MUTEX_OWNER
+# define __MUTEX_OWNER_INIT(owner) , .__owner = NULL
+#else
+# define __MUTEX_OWNER_INIT(owner)
+#endif
+
+#define MUTEX_UNLOCKED(name)					\
+{								\
+	.state		= __MUTEX_STATE_UNLOCKED,		\
+	.wait_lock	= SPIN_LOCK_UNLOCKED,			\
+	.wait_list	= LIST_HEAD_INIT((name).wait_list)	\
+	__MUTEX_OWNER_INIT(owner)				\
+}
+
+#define DECLARE_MUTEX(name) \
+	struct mutex name = MUTEX_UNLOCKED(name)
+
+static inline void __mutex_init(struct mutex *mutex, unsigned state)
+{
+	mutex->state = state;
+	spin_lock_init(&mutex->wait_lock);
+	INIT_LIST_HEAD(&mutex->wait_list);
+#ifdef CONFIG_DEBUG_MUTEX_OWNER
+	if (state == __MUTEX_STATE_LOCKED)
+		mutex->__owner = current_thread_info();
+	else
+		mutex->__owner = NULL;
+#endif
+}
+
+static inline void mutex_init(struct mutex *mutex)
+{
+	__mutex_init(mutex, __MUTEX_STATE_UNLOCKED);
+}
+
+static inline void mutex_init_locked(struct mutex *mutex)
+{
+	__mutex_init(mutex, __MUTEX_STATE_LOCKED);
+}
+
+/*
+ * attempt to grab the mutex without waiting for it to become available
+ * - returns true if we acquired it
+ */
+static inline
+int mutex_trylock(struct mutex *mutex)
+{
+	if (likely(__mutex_trylock(mutex))) {
+		/* success */
+#ifdef CONFIG_DEBUG_MUTEX_OWNER
+		mutex->__owner = current_thread_info();
+#endif
+		return 1;
+	}
+
+	/* failure */
+	return 0;
+}
+
+/*
+ * slow paths
+ */
+extern void fastcall __mutex_lock(struct mutex *mutex);
+extern int fastcall __mutex_lock_interruptible(struct mutex *mutex);
+extern void fastcall mutex_unlock(struct mutex *mutex);
+
+/*
+ * fast path for attempting to grab the mutex
+ */
+static inline fastcall __sched
+void mutex_lock(struct mutex *mutex)
+{
+	if (!mutex_trylock(mutex))
+		__mutex_lock(mutex);
+}
+
+/*
+ * fast path for attempting to grab the mutex interruptibly
+ */
+static inline fastcall __sched
+int mutex_lock_interruptible(struct mutex *mutex)
+{
+	if (mutex_trylock(mutex))
+		return 0;
+
+	return __mutex_lock_interruptible(mutex);
+}
+
+#endif /* __ASSEMBLY__ */
+#endif /* _LINUX_MUTEX_XCHG_H */
diff -uNrp linux-2.6.15-rc5/include/linux/mutex.h linux-2.6.15-rc5-mutex/include/linux/mutex.h
--- linux-2.6.15-rc5/include/linux/mutex.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15-rc5-mutex/include/linux/mutex.h	2005-12-16 17:40:46.000000000 +0000
@@ -0,0 +1,46 @@
+/* mutex.h: mutex implementation base
+ *
+ * Copyright (C) 2005 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#ifndef _LINUX_MUTEX_H
+#define _LINUX_MUTEX_H
+
+#include <linux/config.h>
+
+#if defined(CONFIG_ARCH_IMPLEMENTS_MUTEX)
+/*
+ * the arch wants to implement the whole mutex itself
+ */
+#include <asm/mutex.h>
+
+#elif defined(CONFIG_ARCH_CMPXCHG_MUTEX)
+/*
+ * use the compare-and-exchange based mutex template
+ * - the arch may override __mutex_cmpxchg() to provide a long-sized cmpxchg()
+ */
+#include <linux/mutex-cmpxchg.h>
+
+#elif defined(CONFIG_ARCH_XCHG_MUTEX)
+/*
+ * use the simple two-state exchange based mutex template
+ * - the arch may override __mutex_trylock(), __mutex_release() and mutex_is_locked()
+ *   to use something other than xchg() by #defining __mutex_trylock
+ * - __MUTEX_STATE_UNLOCKED and __MUTEX_STATE_LOCKED may also be overridden
+ */
+#include <linux/mutex-xchg.h>
+
+#else
+/*
+ * default counting semaphore wrapping mutex
+ */
+#include <linux/mutex-default.h>
+
+#endif
+
+#endif /* _LINUX_MUTEX_H */
diff -uNrp linux-2.6.15-rc5/lib/Kconfig.debug linux-2.6.15-rc5-mutex/lib/Kconfig.debug
--- linux-2.6.15-rc5/lib/Kconfig.debug	2005-12-08 16:23:56.000000000 +0000
+++ linux-2.6.15-rc5-mutex/lib/Kconfig.debug	2005-12-15 17:44:11.000000000 +0000
@@ -111,6 +111,14 @@ config DEBUG_SPINLOCK_SLEEP
 	  If you say Y here, various routines which may sleep will become very
 	  noisy if they are called with a spinlock held.
 
+config DEBUG_MUTEX_OWNER
+	bool "Mutex owner tracking and checking"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here, the process currently owning a mutex will be
+	  remembered, and a warning will be issued if anyone other than that
+	  process releases it.
+
 config DEBUG_KOBJECT
 	bool "kobject debugging"
 	depends on DEBUG_KERNEL
