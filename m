Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbVLLXsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbVLLXsg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 18:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbVLLXrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 18:47:01 -0500
Received: from mx1.redhat.com ([66.187.233.31]:35491 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932245AbVLLXqT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 18:46:19 -0500
Date: Mon, 12 Dec 2005 23:45:45 GMT
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org,
       matthew@wil.cx
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-Id: <dhowells1134431145@warthog.cambridge.redhat.com>
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

 (2) This makes it obvious in what way the semaphore is being used: whether
     it's being used as a mutex or being used as a counter.

This patch set does the following:

 (1) Provides a simple xchg() based semaphore as a default for all
     architectures that don't wish to override it and provide their own.

     Overriding is possible by setting CONFIG_ARCH_IMPLEMENTS_MUTEX and
     supplying asm/mutex.h

     Partial overriding is possible by #defining mutex_grab(), mutex_release()
     and is_mutex_locked() to perform the appropriate optimised functions.

 (2) Provides linux/mutex.h as a common include for gaining access to mutex
     semaphores.

 (3) Provides linux/semaphore.h as a common include for gaining access to all
     the different types of semaphore that may be used from within the kernel.

 (4) Renames down*() to down_sem*() and up() to up_sem() for the traditional
     semaphores, and removes init_MUTEX*() and DECLARE_MUTEX*() from
     asm/semaphore.h

 (5) Redirects the following to apply to the new mutexes rather than the
     traditional semaphores:

	down()
	down_trylock()
	down_interruptible()
	up()
	init_MUTEX()
     	init_MUTEX_LOCKED()
	DECLARE_MUTEX()
	DECLARE_MUTEX_LOCKED()

     On the basis that most usages of semaphores are as mutexes, this makes
     sense for in most cases it's just then a matter of changing the type from
     struct semaphore to struct mutex. In some cases, sema_init() has to be
     changed to init_MUTEX*() also.

 (6) Generally include linux/semaphore.h in place of asm/semaphore.h.

 (7) Provides a debugging config option CONFIG_DEBUG_MUTEX_OWNER by which the
     mutex owner can be tracked and by which over-upping can be detected.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 mutex-simple-2615rc5.diff
 include/linux/mutex-simple.h |  194 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/mutex.h        |   32 +++++++
 include/linux/semaphore.h    |   30 ++++++
 lib/Kconfig.debug            |    8 +
 lib/Makefile                 |    4 
 lib/mutex-simple.c           |  178 +++++++++++++++++++++++++++++++++++++++
 lib/semaphore-sleepers.c     |    8 -
 7 files changed, 450 insertions(+), 4 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/semaphore.h linux-2.6.15-rc5-mutex/include/linux/semaphore.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/semaphore.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15-rc5-mutex/include/linux/semaphore.h	2005-12-12 22:03:53.000000000 +0000
@@ -0,0 +1,30 @@
+/* semaphore.h: include the various types of semaphore in one package
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
+#ifndef _LINUX_SEMAPHORE_H
+#define _LINUX_SEMAPHORE_H
+
+/*
+ * simple mutex semaphores
+ */
+#include <linux/mutex.h>
+
+/*
+ * multiple-count semaphores
+ */
+#include <asm/semaphore.h>
+
+/*
+ * read/write semaphores
+ */
+#include <linux/rwsem.h>
+
+#endif /* _LINUX_SEMAPHORE_H */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/mutex.h linux-2.6.15-rc5-mutex/include/linux/mutex.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/mutex.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15-rc5-mutex/include/linux/mutex.h	2005-12-12 22:13:30.000000000 +0000
@@ -0,0 +1,32 @@
+/* mutex.h: mutex semaphore implementation base
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
+#ifdef CONFIG_ARCH_IMPLEMENTS_MUTEX
+
+/*
+ * the arch wants to implement the whole mutex itself
+ */
+#include <asm/mutex.h>
+#else
+
+/*
+ * simple exchange-based mutex
+ * - the arch may override mutex_grab(), mutex_release() and is_mutex_locked()
+ *   to use something other than xchg() by #defining mutex_grab
+ */
+#include <linux/mutex-simple.h>
+#endif
+
+#endif /* _LINUX_MUTEX_H */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/include/linux/mutex-simple.h linux-2.6.15-rc5-mutex/include/linux/mutex-simple.h
--- /warthog/kernels/linux-2.6.15-rc5/include/linux/mutex-simple.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15-rc5-mutex/include/linux/mutex-simple.h	2005-12-12 22:26:11.000000000 +0000
@@ -0,0 +1,194 @@
+/* mutex-simple.h: simple exchange-based mutexes
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
+ * If the arch defines mutex_grab(), mutex_release() and is_mutex_locked() for
+ * itself, then those will be used to provide the appropriate functionality
+ *
+ * See lib/mutex-simple.c for the slow-path implementation.
+ */
+#ifndef _LINUX_MUTEX_SIMPLE_H
+#define _LINUX_MUTEX_SIMPLE_H
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
+ * the mutex semaphore definition
+ * - if state is 0, then the mutex is available
+ * - if state is non-zero, then the mutex is busy
+ * - if wait_list is not empty, then there are processes waiting for the mutex
+ */
+struct mutex {
+	int			state;
+	spinlock_t		wait_lock;
+	struct list_head	wait_list;
+#ifdef CONFIG_DEBUG_MUTEX_OWNER
+	struct task_struct	*__owner;
+#endif
+};
+
+#ifndef mutex_grab
+/*
+ * mutex_grab() attempts to grab the mutex and returns true if successful
+ */
+#define mutex_grab(mutex)	(xchg(&(mutex)->state, 1) == 0)
+
+/*
+ * mutex_release() releases the mutex
+ */
+#define mutex_release(mutex)	do { (mutex)->state = 0; } while(0)
+
+/*
+ * is_mutex_locked() returns non-zero if the mutex is locked
+ */
+#define is_mutex_locked(mutex)	((mutex)->state)
+#endif
+
+#ifdef CONFIG_DEBUG_MUTEX_OWNER
+# define __MUTEX_OWNER_INIT(owner) , .__owner = (owner)
+#else
+# define __MUTEX_OWNER_INIT(owner)
+#endif
+
+#define __MUTEX_INITIALISER(name,_state,owner)			\
+{								\
+	.state		= (_state),				\
+	.wait_lock	= SPIN_LOCK_UNLOCKED,			\
+	.wait_list	= LIST_HEAD_INIT((name).wait_list)	\
+	__MUTEX_OWNER_INIT(owner)				\
+}
+
+#define __DECLARE_MUTEX_GENERIC(name, owner, state)			\
+	struct mutex name = __MUTEX_INITIALISER(name, owner, state)
+
+#define DECLARE_MUTEX(name) \
+	__DECLARE_MUTEX_GENERIC(name, 0, NULL)
+
+#define DECLARE_MUTEX_LOCKED(name, owner) \
+	__DECLARE_MUTEX_GENERIC(name, 1, (owner))
+
+static inline void mutex_init(struct mutex *mutex,
+			      unsigned state,
+			      struct task_struct *owner)
+{
+	mutex->state = state;
+	spin_lock_init(&mutex->wait_lock);
+	INIT_LIST_HEAD(&mutex->wait_list);
+#ifdef CONFIG_DEBUG_MUTEX_OWNER
+	mutex->__owner = owner;
+#endif
+}
+
+static inline void init_MUTEX(struct mutex *mutex)
+{
+	mutex_init(mutex, 0, NULL);
+}
+
+static inline void init_MUTEX_LOCKED (struct mutex *mutex)
+{
+	mutex_init(mutex, 1, current);
+}
+
+extern void __down(struct mutex *mutex);
+extern int  __down_interruptible(struct mutex *mutex);
+extern void __up(struct mutex *mutex);
+
+#ifdef CONFIG_DEBUG_MUTEX_OWNER
+extern void __up_bad(struct mutex *mutex);
+#endif
+
+/*
+ * sleep until we get the mutex
+ */
+static inline void down(struct mutex *mutex)
+{
+	if (mutex_grab(mutex)) {
+#ifdef CONFIG_DEBUG_MUTEX_OWNER
+		mutex->__owner = current;
+#endif
+	}
+	else {
+		__down(mutex);
+	}
+}
+
+/*
+ * sleep interruptibly until we get the mutex
+ * - return 0 if successful, -EINTR if interrupted
+ */
+static inline int down_interruptible(struct mutex *mutex)
+{
+	if (mutex_grab(mutex)) {
+#ifdef CONFIG_DEBUG_MUTEX_OWNER
+		mutex->__owner = current;
+#endif
+		return 0;
+	}
+
+	return __down_interruptible(mutex);
+}
+
+/*
+ * attempt to grab the mutex without waiting for it to become available
+ * - returns zero if we acquired it
+ */
+static inline int down_trylock(struct mutex *mutex)
+{
+	if (mutex_grab(mutex)) {
+		/* success */
+#ifdef CONFIG_DEBUG_MUTEX_OWNER
+		mutex->__owner = current;
+#endif
+		return 0;
+	}
+
+	/* failure */
+	return 1;
+}
+
+/*
+ * release the mutex
+ */
+static inline void up(struct mutex *mutex)
+{
+	unsigned long flags;
+
+#ifdef CONFIG_DEBUG_MUTEX_OWNER
+	if (mutex->__owner != current)
+		__up_bad(mutex);
+	mutex->__owner = NULL;
+#endif
+
+	/* must prevent a race */
+	spin_lock_irqsave(&mutex->wait_lock, flags);
+	if (!list_empty(&mutex->wait_list))
+		__up(mutex);
+	else
+		mutex_release(mutex);
+	spin_unlock_irqrestore(&mutex->wait_lock, flags);
+}
+
+#endif /* __ASSEMBLY__ */
+#endif /* _LINUX_MUTEX_SIMPLE_H */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/lib/Kconfig.debug linux-2.6.15-rc5-mutex/lib/Kconfig.debug
--- /warthog/kernels/linux-2.6.15-rc5/lib/Kconfig.debug	2005-12-08 16:23:56.000000000 +0000
+++ linux-2.6.15-rc5-mutex/lib/Kconfig.debug	2005-12-12 16:59:35.000000000 +0000
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
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/lib/Makefile linux-2.6.15-rc5-mutex/lib/Makefile
--- /warthog/kernels/linux-2.6.15-rc5/lib/Makefile	2005-12-08 16:23:56.000000000 +0000
+++ linux-2.6.15-rc5-mutex/lib/Makefile	2005-12-12 18:59:21.000000000 +0000
@@ -28,6 +28,10 @@ ifneq ($(CONFIG_HAVE_DEC_LOCK),y)
   lib-y += dec_and_lock.o
 endif
 
+ifneq ($(CONFIG_ARCH_IMPLEMENTS_MUTEX),y)
+  lib-y += mutex-simple.o
+endif
+
 obj-$(CONFIG_CRC_CCITT)	+= crc-ccitt.o
 obj-$(CONFIG_CRC16)	+= crc16.o
 obj-$(CONFIG_CRC32)	+= crc32.o
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/lib/mutex-simple.c linux-2.6.15-rc5-mutex/lib/mutex-simple.c
--- /warthog/kernels/linux-2.6.15-rc5/lib/mutex-simple.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15-rc5-mutex/lib/mutex-simple.c	2005-12-12 22:27:00.000000000 +0000
@@ -0,0 +1,178 @@
+/* mutex-simple.c: simple mutex slow paths
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
+#include <linux/config.h>
+#include <linux/sched.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+
+struct mutex_waiter {
+	struct list_head	list;
+	struct task_struct	*task;
+};
+
+/*
+ * wait for a token to be granted from a mutex
+ */
+void __down(struct mutex *mutex)
+{
+	struct mutex_waiter waiter;
+	struct task_struct *tsk = current;
+	unsigned long flags;
+
+	/* set up my own style of waitqueue */
+	waiter.task = tsk;
+
+	spin_lock_irqsave(&mutex->wait_lock, flags);
+
+	if (mutex_grab(mutex)) {
+		/* we got the mutex anyway */
+		spin_unlock_irqrestore(&mutex->wait_lock, flags);
+		return;
+	}
+
+	/* need to sleep */
+	get_task_struct(tsk);
+	list_add_tail(&waiter.list, &mutex->wait_list);
+
+	/* we don't need to touch the mutex struct anymore */
+	spin_unlock_irqrestore(&mutex->wait_lock, flags);
+
+	/* wait to be given the mutex */
+	set_task_state(tsk, TASK_UNINTERRUPTIBLE);
+
+	for (;;) {
+		if (list_empty(&waiter.list))
+			break;
+		schedule();
+		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
+	}
+
+	tsk->state = TASK_RUNNING;
+}
+
+EXPORT_SYMBOL(__down);
+
+/*
+ * interruptibly wait for a token to be granted from a mutex
+ */
+int __down_interruptible(struct mutex *mutex)
+{
+	struct mutex_waiter waiter;
+	struct task_struct *tsk = current;
+	unsigned long flags;
+	int ret;
+
+	/* set up my own style of waitqueue */
+	waiter.task = tsk;
+
+	spin_lock_irqsave(&mutex->wait_lock, flags);
+
+	if (mutex_grab(mutex)) {
+		/* we got the mutex anyway */
+		spin_unlock_irqrestore(&mutex->wait_lock, flags);
+		return 0;
+	}
+
+	/* need to sleep */
+	get_task_struct(tsk);
+	list_add_tail(&waiter.list, &mutex->wait_list);
+
+	/* we don't need to touch the mutex struct anymore */
+	set_task_state(tsk, TASK_INTERRUPTIBLE);
+
+	spin_unlock_irqrestore(&mutex->wait_lock, flags);
+
+	/* wait to be given the mutex */
+	for (;;) {
+		if (list_empty(&waiter.list))
+			break;
+		if (unlikely(signal_pending(current)))
+			goto interrupted;
+		schedule();
+		set_task_state(tsk, TASK_INTERRUPTIBLE);
+	}
+
+	tsk->state = TASK_RUNNING;
+	return 0;
+
+interrupted:
+	spin_lock_irqsave(&mutex->wait_lock, flags);
+
+	/* we may still have been given the mutex */
+	ret = 0;
+	if (!list_empty(&waiter.list)) {
+		list_del(&waiter.list);
+		ret = -EINTR;
+	}
+
+	spin_unlock_irqrestore(&mutex->wait_lock, flags);
+	if (ret == -EINTR)
+		put_task_struct(current);
+	return ret;
+}
+
+EXPORT_SYMBOL(__down_interruptible);
+
+/*
+ * release a single token back to a mutex
+ * - entered with lock held and interrupts disabled
+ * - the queue will not be empty
+ */
+void __up(struct mutex *mutex)
+{
+	struct mutex_waiter *waiter;
+	struct task_struct *tsk;
+
+	/* grant the token to the process at the front of the queue */
+	waiter = list_entry(mutex->wait_list.next, struct mutex_waiter, list);
+
+	/* we must be careful not to touch 'waiter' after we set ->task = NULL.
+	 * - it is an allocated on the waiter's stack and may become invalid at
+	 *   any time after that point (due to a wakeup from another source).
+	 */
+	list_del_init(&waiter->list);
+	tsk = waiter->task;
+#ifdef CONFIG_DEBUG_MUTEX_OWNER
+	mutex->__owner = tsk;
+#endif
+	mb();
+	waiter->task = NULL;
+	wake_up_process(tsk);
+	put_task_struct(tsk);
+}
+
+EXPORT_SYMBOL(__up);
+
+/*
+ * report an up() that doesn't match a down()
+ */
+#ifdef CONFIG_DEBUG_MUTEX_OWNER
+void __up_bad(struct mutex *mutex)
+{
+	if (!mutex->__owner) {
+		printk(KERN_ERR
+		       "BUG: process %d [%s] releasing unowned mutex\n",
+		       current->pid,
+		       current->comm);
+	}
+	else {
+		printk(KERN_ERR
+		       "BUG: process %d [%s] releasing mutex owned by %d [%s]\n",
+		       current->pid,
+		       current->comm,
+		       mutex->__owner->pid,
+		       mutex->__owner->comm);
+	}
+}
+
+EXPORT_SYMBOL(__up_bad);
+#endif
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/lib/semaphore-sleepers.c linux-2.6.15-rc5-mutex/lib/semaphore-sleepers.c
--- /warthog/kernels/linux-2.6.15-rc5/lib/semaphore-sleepers.c	2005-11-01 13:19:22.000000000 +0000
+++ linux-2.6.15-rc5-mutex/lib/semaphore-sleepers.c	2005-12-12 17:58:35.000000000 +0000
@@ -49,12 +49,12 @@
  *    we cannot lose wakeup events.
  */
 
-fastcall void __up(struct semaphore *sem)
+fastcall void __up_sem(struct semaphore *sem)
 {
 	wake_up(&sem->wait);
 }
 
-fastcall void __sched __down(struct semaphore * sem)
+fastcall void __sched __down_sem(struct semaphore * sem)
 {
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
@@ -91,7 +91,7 @@ fastcall void __sched __down(struct sema
 	tsk->state = TASK_RUNNING;
 }
 
-fastcall int __sched __down_interruptible(struct semaphore * sem)
+fastcall int __sched __down_sem_interruptible(struct semaphore * sem)
 {
 	int retval = 0;
 	struct task_struct *tsk = current;
@@ -154,7 +154,7 @@ fastcall int __sched __down_interruptibl
  * single "cmpxchg" without failure cases,
  * but then it wouldn't work on a 386.
  */
-fastcall int __down_trylock(struct semaphore * sem)
+fastcall int __down_sem_trylock(struct semaphore * sem)
 {
 	int sleepers;
 	unsigned long flags;
