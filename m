Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262046AbVCaWyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262046AbVCaWyU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 17:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262044AbVCaWyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 17:54:20 -0500
Received: from dh138.citi.umich.edu ([141.211.133.138]:46766 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S262043AbVCaWxJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 17:53:09 -0500
Subject: Re: [RFC] Add support for semaphore-like structure with support
	for asynchronous I/O
From: Trond Myklebust <trondmy@trondhjem.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>
In-Reply-To: <1112224663.18019.39.camel@lade.trondhjem.org>
References: <1112219491.10771.18.camel@lade.trondhjem.org>
	 <20050330143409.04f48431.akpm@osdl.org>
	 <1112224663.18019.39.camel@lade.trondhjem.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 31 Mar 2005 17:53:06 -0500
Message-Id: <1112309586.27458.19.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on den 30.03.2005 Klokka 18:17 (-0500) skreiv Trond Myklebust:
> > Or have I misunderstood the intent?  Some /* comments */ would be appropriate..
> 
> Will do.

OK. Plenty of comments added that will hopefully clarify what is going
on and how to use the API. Also some cleanups of the code.

I haven't changed the name "iosem" as Nikita suggested. That's not
because I'm opposed to doing so, but I haven't yet heard something that
I like. Suggestions welcome...

Cheers,
 Trond

--------------
NFS: Add support for iosems.

 These act rather like semaphores, but also have support for asynchronous
 I/O, using the wait_queue_t callback features.

 Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---
 include/linux/iosem.h |  110 +++++++++++++++++++++++++++++++
 lib/Makefile          |    2 
 lib/iosem.c           |  177 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 288 insertions(+), 1 deletion(-)

Index: linux-2.6.12-rc1/include/linux/iosem.h
===================================================================
--- /dev/null
+++ linux-2.6.12-rc1/include/linux/iosem.h
@@ -0,0 +1,110 @@
+/*
+ * include/linux/iosem.h
+ *
+ * Copyright (C) 2005 Trond Myklebust <Trond.Myklebust@netapp.com>
+ *
+ * Definitions for iosems. These can act as mutexes, but unlike
+ * semaphores, their code is 100% arch-independent, and can therefore
+ * easily be expanded in order to provide for things like
+ * asynchronous I/O.
+ */
+
+#ifndef __LINUX_SEM_LOCK_H
+#define __LINUX_SEM_LOCK_H
+
+#ifdef __KERNEL__
+#include <linux/wait.h>
+#include <linux/workqueue.h>
+
+/*
+ * struct iosem: iosem mutex
+ *      state: bitmask - currently only signals whether or not an exclusive
+ *      		 lock has been taken
+ *      wait: FIFO wait queue
+ */
+struct iosem {
+#define IOSEM_LOCK_EXCLUSIVE (31)
+/* #define IOSEM_LOCK_SHARED (30) */
+	unsigned long state;
+	wait_queue_head_t wait;
+};
+
+
+
+/*
+ * struct iosem_wait: acts as a request for a lock on the iosem
+ *      lock: backpointer to the iosem
+ *      wait: wait queue entry. note that the callback function
+ *            defines what to do when the lock has been granted
+ */
+struct iosem_wait {
+	struct iosem *lock;
+	wait_queue_t wait;
+};
+
+/*
+ * struct iosem_work: used by asynchronous waiters.
+ *
+ * 	work: work to schedule once the iosem has been granted. The
+ * 	      function containing the critical code that needs to
+ * 	      run under the protection of the lock should be placed here.
+ * 	      The same function is responsible for calling iosem_unlock()
+ * 	      when done.
+ * 	waiter: iosem waitqueue entry
+ */
+struct iosem_work {
+	struct work_struct work;
+	struct iosem_wait waiter;
+};
+
+/*
+ * Functions for synchronous i/o
+ */
+
+/* Synchronously grab an iosem.
+ * These functions act in pretty much the same way down()/up()
+ * do for semaphores.
+ */
+extern void FASTCALL(iosem_lock(struct iosem *lk));
+extern void FASTCALL(iosem_unlock(struct iosem *lk));
+
+/*
+ * Callback function to wake up the sleeping task once
+ * it has been granted an exclusive lock
+ */
+extern int iosem_lock_wake_function(wait_queue_t *wait, unsigned mode, int sync, void *key);
+
+/* Initialize a struct iosem in the "unlocked" state */
+static inline void iosem_init(struct iosem *lk)
+{
+	lk->state = 0;
+	init_waitqueue_head(&lk->wait);
+}
+
+/* Initializes a lock request */
+static inline void iosem_waiter_init(struct iosem_wait *waiter)
+{
+	waiter->lock = NULL;
+	init_waitqueue_entry(&waiter->wait, current);
+	INIT_LIST_HEAD(&waiter->wait.task_list);
+}
+
+/* 
+ * Functions for asynchronous I/O.
+ */
+
+/* Requests an exclusive lock on the iosem on behalf of a workqueue entry "wk".
+ * Schedule wk->work for execution as soon as the lock is granted. */
+extern int FASTCALL(iosem_lock_and_schedule_work(struct iosem *lk, struct iosem_work *wk));
+
+/* Waitqueue notifier that schedules work once the exclusive lock has
+ * been granted */
+extern int iosem_lock_and_schedule_function(wait_queue_t *wait, unsigned mode, int sync, void *key);
+
+static inline void iosem_work_init(struct iosem_work *wk, void (*func)(void *), void *data)
+{
+	INIT_WORK(&wk->work, func, data);
+}
+
+#endif /* __KERNEL__ */
+#endif /* __LINUX_SEM_LOCK_H */
Index: linux-2.6.12-rc1/lib/iosem.c
===================================================================
--- /dev/null
+++ linux-2.6.12-rc1/lib/iosem.c
@@ -0,0 +1,177 @@
+/*
+ * linux/lib/iosem.c
+ *
+ * Copyright (C) 2005 Trond Myklebust <Trond.Myklebust@netapp.com>
+ *
+ * A set of primitives for semaphore-like locks that also support notification
+ * callbacks for waiters.
+ */
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/wait.h>
+#include <linux/iosem.h>
+
+/*
+ * Common function for requesting an exclusive lock on an iosem
+ *
+ * Note: should be called while holding the non-irqsafe spinlock
+ * lk->wait.lock. The spinlock is non-irqsafe as we have no reason (yet) to
+ * expect anyone to take/release iosems from within an interrupt
+ * context (and 'cos it is a _bug_ to attempt to wake up the waitqueue
+ * lk->wait using anything other than iosem_unlock()).
+ */
+static inline int __iosem_lock(struct iosem *lk, struct iosem_wait *waiter)
+{
+	int ret;
+
+	if (lk->state != 0) {
+		/* The lock cannot be immediately granted: queue waiter */
+		waiter->lock = lk;
+		add_wait_queue_exclusive_locked(&lk->wait, &waiter->wait);
+		ret = -EINPROGRESS;
+	} else {
+		lk->state |= 1 << IOSEM_LOCK_EXCLUSIVE;
+		ret = 0;
+	}
+	return ret;
+}
+
+/**
+ * iosem_unlock - release an exclusive lock
+ * @iosem - the iosem on which we hold an exclusive lock
+ */
+void fastcall iosem_unlock(struct iosem *lk)
+{
+	spin_lock(&lk->wait.lock);
+	lk->state &= ~(1 << IOSEM_LOCK_EXCLUSIVE);
+	wake_up_locked(&lk->wait);
+	spin_unlock(&lk->wait.lock);
+}
+EXPORT_SYMBOL(iosem_unlock);
+
+/**
+ * iosem_lock_wake_function - take an exclusive lock and wake up sleeping task
+ * @wait: waitqueue entry. Must be part of an initialized struct iosem_wait
+ * @mode:
+ * @sync:
+ * @key:
+ *
+ * Standard wait_queue_func_t callback function used by iosem_lock(). When
+ * called, it will attempt to wake up the sleeping task, and set an
+ * exclusive lock on the iosem.
+ * On success, @wait is automatically removed from the iosem's waitqueue,
+ * and a non-zero value is returned.
+ *
+ * This function will in practice *always* be called from within iosem_unlock()
+ */
+int iosem_lock_wake_function(wait_queue_t *wait, unsigned mode, int sync, void *key)
+{
+	struct iosem_wait *waiter = container_of(wait, struct iosem_wait, wait);
+	unsigned long *lk_state = &waiter->lock->state;
+	int ret = 0;
+
+	if (*lk_state == 0) {
+		ret = default_wake_function(wait, mode, sync, key);
+		if (ret) {
+			*lk_state |= 1 << IOSEM_LOCK_EXCLUSIVE;
+			list_del_init(&wait->task_list);
+		}
+	}
+	return ret;
+}
+
+/**
+ * iosem_lock - synchronously take an exclusive lock
+ * @iosem - the iosem to take an exclusive lock
+ *
+ * If the exclusive lock cannot be immediately granted, put the current task
+ * to uninterruptible sleep until it can.
+ */
+void fastcall iosem_lock(struct iosem *lk)
+{
+	struct iosem_wait waiter;
+
+	might_sleep();
+
+	iosem_waiter_init(&waiter);
+	waiter.wait.func = iosem_lock_wake_function;
+
+	spin_lock(&lk->wait.lock);
+	if (__iosem_lock(lk, &waiter) != 0) {
+		/* Must wait for lock... */
+		for (;;) {
+			set_current_state(TASK_UNINTERRUPTIBLE);
+			if (list_empty(&waiter.wait.task_list))
+				break;
+			spin_unlock(&lk->wait.lock);
+			schedule();
+			spin_lock(&lk->wait.lock);
+		}
+		__set_current_state(TASK_RUNNING);
+	}
+	spin_unlock(&lk->wait.lock);
+}
+EXPORT_SYMBOL(iosem_lock);
+
+/**
+ * iosem_lock_and_schedule_function - take an exclusive lock and schedule work
+ * @wait: waitqueue entry. Must be part of an initialized struct iosem_work
+ * @mode: unused
+ * @sync: unused
+ * @key: unused
+ *
+ * Standard wait_queue_func_t callback function used by
+ * iosem_lock_and_schedule_work. When called, it will attempt to queue the
+ * work function and set the exclusive lock on the iosem.
+ * On success, @wait is removed from the iosem's waitqueue, and a non-zero
+ * value is returned.
+ *
+ * This function will in practice *always* be called from within iosem_unlock()
+ */
+int iosem_lock_and_schedule_function(wait_queue_t *wait, unsigned mode, int sync, void *key)
+{
+	struct iosem_wait *waiter = container_of(wait, struct iosem_wait, wait);
+	struct iosem_work *wk = container_of(waiter, struct iosem_work, waiter);
+	unsigned long *lk_state = &waiter->lock->state;
+	int ret = 0;
+
+	if (*lk_state == 0) {
+		ret = schedule_work(&wk->work);
+		if (ret) {
+			*lk_state |= 1 << IOSEM_LOCK_EXCLUSIVE;
+			list_del_init(&wait->task_list);
+		}
+	}
+	return ret;
+}
+
+/**
+ * iosem_lock_and_schedule_work - request an exclusive lock and schedule work
+ * @lk: pointer to iosem
+ * @wk: pointer to iosem_work
+ *
+ * Request an exclusive lock on the iosem. If the lock cannot be immediately
+ * granted, place wk->waiter on the iosem's waitqueue, and return, else
+ * immediately queue the work function wk->work.
+ *
+ * Once the exclusive lock has been granted, the work function described by
+ * wk->work is queued in keventd. It is then the responsibility of that work
+ * function to release the exclusive lock once it has been granted.
+ *
+ * returns -EINPROGRESS if the lock could not be immediately granted.
+ */
+int fastcall iosem_lock_and_schedule_work(struct iosem *lk, struct iosem_work *wk)
+{
+	int ret;
+
+	iosem_waiter_init(&wk->waiter);
+	wk->waiter.wait.func = iosem_lock_and_schedule_function;
+	spin_lock(&lk->wait.lock);
+	ret = __iosem_lock(lk, &wk->waiter);
+	spin_unlock(&lk->wait.lock);
+	if (ret == 0)
+		ret = schedule_work(&wk->work);
+	return ret;
+}
+EXPORT_SYMBOL(iosem_lock_and_schedule_work);
Index: linux-2.6.12-rc1/lib/Makefile
===================================================================
--- linux-2.6.12-rc1.orig/lib/Makefile
+++ linux-2.6.12-rc1/lib/Makefile
@@ -8,7 +8,7 @@ lib-y := errno.o ctype.o string.o vsprin
 	 bitmap.o extable.o kobject_uevent.o prio_tree.o sha1.o \
 	 halfmd4.o
 
-obj-y += sort.o parser.o
+obj-y += sort.o parser.o iosem.o
 
 ifeq ($(CONFIG_DEBUG_KOBJECT),y)
 CFLAGS_kobject.o += -DDEBUG

-- 
Trond Myklebust <trondmy@trondhjem.org>
