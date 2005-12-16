Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964870AbVLPXPN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbVLPXPN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 18:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964876AbVLPXOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 18:14:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39132 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964824AbVLPXN0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 18:13:26 -0500
Date: Fri, 16 Dec 2005 23:13:08 GMT
Message-Id: <200512162313.jBGND8Hu019637@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 8/12]: MUTEX: Rename DECLARE_MUTEX for kernel/ dir
In-Reply-To: <dhowells1134774786@warthog.cambridge.redhat.com>
References: <dhowells1134774786@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch renames DECLARE_MUTEX*() to DECLARE_SEM_MUTEX*() for the
kernel/ directory.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 mutex-kernel-2615rc5-2.diff
 kernel/Makefile        |    3 
 kernel/audit.c         |    2 
 kernel/cpu.c           |    2 
 kernel/cpuset.c        |    4 
 kernel/irq/autoprobe.c |    2 
 kernel/kthread.c       |    2 
 kernel/module.c        |    4 
 kernel/mutex-cmpxchg.c |  298 +++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/mutex-xchg.c    |  220 ++++++++++++++++++++++++++++++++++++
 kernel/posix-timers.c  |    2 
 kernel/power/main.c    |    2 
 kernel/power/pm.c      |    2 
 kernel/printk.c        |    2 
 kernel/profile.c       |    2 
 kernel/stop_machine.c  |    2 
 15 files changed, 535 insertions(+), 14 deletions(-)

diff -uNrp linux-2.6.15-rc5/kernel/Makefile linux-2.6.15-rc5-mutex/kernel/Makefile
--- linux-2.6.15-rc5/kernel/Makefile	2005-12-08 16:23:55.000000000 +0000
+++ linux-2.6.15-rc5-mutex/kernel/Makefile	2005-12-16 17:38:19.000000000 +0000
@@ -33,6 +33,9 @@ obj-$(CONFIG_CRASH_DUMP) += crash_dump.o
 obj-$(CONFIG_SECCOMP) += seccomp.o
 obj-$(CONFIG_RCU_TORTURE_TEST) += rcutorture.o
 
+obj-$(CONFIG_ARCH_CMPXCHG_MUTEX) += mutex-cmpxchg.o
+obj-$(CONFIG_ARCH_XCHG_MUTEX) += mutex-xchg.o
+
 ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
 # needed for x86 only.  Why this used to be enabled for all architectures is beyond
diff -uNrp linux-2.6.15-rc5/kernel/audit.c linux-2.6.15-rc5-mutex/kernel/audit.c
--- linux-2.6.15-rc5/kernel/audit.c	2005-12-08 16:23:55.000000000 +0000
+++ linux-2.6.15-rc5-mutex/kernel/audit.c	2005-12-15 17:14:57.000000000 +0000
@@ -113,7 +113,7 @@ static DECLARE_WAIT_QUEUE_HEAD(audit_bac
 /* The netlink socket is only to be read by 1 CPU, which lets us assume
  * that list additions and deletions never happen simultaneously in
  * auditsc.c */
-DECLARE_MUTEX(audit_netlink_sem);
+DECLARE_SEM_MUTEX(audit_netlink_sem);
 
 /* AUDIT_BUFSIZ is the size of the temporary buffer used for formatting
  * audit records.  Since printk uses a 1024 byte buffer, this buffer
diff -uNrp linux-2.6.15-rc5/kernel/cpu.c linux-2.6.15-rc5-mutex/kernel/cpu.c
--- linux-2.6.15-rc5/kernel/cpu.c	2005-12-08 16:23:55.000000000 +0000
+++ linux-2.6.15-rc5-mutex/kernel/cpu.c	2005-12-15 17:14:57.000000000 +0000
@@ -16,7 +16,7 @@
 #include <asm/semaphore.h>
 
 /* This protects CPUs going up and down... */
-static DECLARE_MUTEX(cpucontrol);
+static DECLARE_SEM_MUTEX(cpucontrol);
 
 static struct notifier_block *cpu_chain;
 
diff -uNrp linux-2.6.15-rc5/kernel/cpuset.c linux-2.6.15-rc5-mutex/kernel/cpuset.c
--- linux-2.6.15-rc5/kernel/cpuset.c	2005-12-08 16:23:55.000000000 +0000
+++ linux-2.6.15-rc5-mutex/kernel/cpuset.c	2005-12-15 17:14:57.000000000 +0000
@@ -229,8 +229,8 @@ static struct super_block *cpuset_sb = N
  * such matters.
  */
 
-static DECLARE_MUTEX(manage_sem);
-static DECLARE_MUTEX(callback_sem);
+static DECLARE_SEM_MUTEX(manage_sem);
+static DECLARE_SEM_MUTEX(callback_sem);
 
 /*
  * A couple of forward declarations required, due to cyclic reference loop:
diff -uNrp linux-2.6.15-rc5/kernel/irq/autoprobe.c linux-2.6.15-rc5-mutex/kernel/irq/autoprobe.c
--- linux-2.6.15-rc5/kernel/irq/autoprobe.c	2005-08-30 13:56:39.000000000 +0100
+++ linux-2.6.15-rc5-mutex/kernel/irq/autoprobe.c	2005-12-15 17:14:57.000000000 +0000
@@ -16,7 +16,7 @@
  * comes in on to an unassigned handler will get stuck with
  * "IRQ_WAITING" cleared and the interrupt disabled.
  */
-static DECLARE_MUTEX(probe_sem);
+static DECLARE_SEM_MUTEX(probe_sem);
 
 /**
  *	probe_irq_on	- begin an interrupt autodetect
diff -uNrp linux-2.6.15-rc5/kernel/kthread.c linux-2.6.15-rc5-mutex/kernel/kthread.c
--- linux-2.6.15-rc5/kernel/kthread.c	2005-12-08 16:23:55.000000000 +0000
+++ linux-2.6.15-rc5-mutex/kernel/kthread.c	2005-12-15 17:14:57.000000000 +0000
@@ -41,7 +41,7 @@ struct kthread_stop_info
 
 /* Thread stopping is done by setthing this var: lock serializes
  * multiple kthread_stop calls. */
-static DECLARE_MUTEX(kthread_stop_lock);
+static DECLARE_SEM_MUTEX(kthread_stop_lock);
 static struct kthread_stop_info kthread_stop_info;
 
 int kthread_should_stop(void)
diff -uNrp linux-2.6.15-rc5/kernel/module.c linux-2.6.15-rc5-mutex/kernel/module.c
--- linux-2.6.15-rc5/kernel/module.c	2005-12-08 16:23:55.000000000 +0000
+++ linux-2.6.15-rc5-mutex/kernel/module.c	2005-12-15 17:14:57.000000000 +0000
@@ -59,10 +59,10 @@
 static DEFINE_SPINLOCK(modlist_lock);
 
 /* List of modules, protected by module_mutex AND modlist_lock */
-static DECLARE_MUTEX(module_mutex);
+static DECLARE_SEM_MUTEX(module_mutex);
 static LIST_HEAD(modules);
 
-static DECLARE_MUTEX(notify_mutex);
+static DECLARE_SEM_MUTEX(notify_mutex);
 static struct notifier_block * module_notify_list;
 
 int register_module_notifier(struct notifier_block * nb)
diff -uNrp linux-2.6.15-rc5/kernel/mutex-cmpxchg.c linux-2.6.15-rc5-mutex/kernel/mutex-cmpxchg.c
--- linux-2.6.15-rc5/kernel/mutex-cmpxchg.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15-rc5-mutex/kernel/mutex-cmpxchg.c	2005-12-15 17:25:06.000000000 +0000
@@ -0,0 +1,298 @@
+/* mutex-cmpxchg.c: cmpxchg-based mutex slow paths
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
+#define CONTENTION_FLAG 1UL
+
+/*
+ * wait for a token to be granted from a mutex
+ * - noinlined to improve the fastpath case
+ */
+static noinline fastcall __sched
+void __mutex_lock(struct mutex *mutex, unsigned long me)
+{
+	struct mutex_waiter waiter;
+	struct task_struct *tsk;
+	unsigned long flags, state, old;
+
+	me = (unsigned long) current_thread_info();
+
+	/* slow path */
+	spin_lock_irqsave(&mutex->wait_lock, flags);
+
+	do {
+		/* see if we can grab the mutex immediately */
+		state = __mutex_cmpxchg(mutex, 0, me);
+		if (!state) {
+			/* we did */
+			spin_unlock_irqrestore(&mutex->wait_lock, flags);
+			return;
+		}
+
+		if (state & CONTENTION_FLAG)
+			goto sleep; /* already flagged for contention */
+
+		/* attempt to mark the mutex as being contended
+		 * - it may get released whilst we're doing this
+		 */
+		do {
+			old = state;
+			state = __mutex_cmpxchg(mutex, state,
+						old | CONTENTION_FLAG);
+
+		} while (state && state != old);
+	} while (!state);
+
+sleep:
+	/* need to sleep; set up my own style of waitqueue */
+	tsk = current;
+	waiter.task = tsk;
+
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
+		if (!waiter.task)
+			break;
+		schedule();
+		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
+	}
+
+	tsk->state = TASK_RUNNING;
+}
+
+/*
+ * fast path for attempting to grab the mutex
+ */
+fastcall __sched void mutex_lock(struct mutex *mutex)
+{
+	unsigned long me = __mutex_owner();
+
+	if (likely(__mutex_cmpxchg(mutex, 0, me) == 0))
+		return;
+
+	/* tail-call the slow path */
+	__mutex_lock(mutex, me);
+}
+
+EXPORT_SYMBOL(mutex_lock);
+
+/*
+ * slow path to interruptibly wait for a mutex to be granted to the caller
+ * - noinlined to improve the fastpath case
+ */
+static noinline fastcall __sched
+int __mutex_lock_interruptible(struct mutex *mutex, unsigned long me)
+{
+	struct mutex_waiter waiter;
+	struct task_struct *tsk;
+	unsigned long flags, state, old;
+	int ret;
+
+	spin_lock_irqsave(&mutex->wait_lock, flags);
+
+	do {
+		/* see if we can grab the mutex immediately */
+		state = __mutex_cmpxchg(mutex, 0, me);
+		if (!state) {
+			/* we did */
+			spin_unlock_irqrestore(&mutex->wait_lock, flags);
+			return 0;
+		}
+
+		if (unlikely(signal_pending(current)))
+			goto early_interrupt;
+
+		if (state & CONTENTION_FLAG)
+			goto sleep; /* already flagged for contention */
+
+		/* attempt to mark the mutex as being contended
+		 * - it may get released whilst we're doing this
+		 */
+		do {
+			old = state;
+			state = __mutex_cmpxchg(mutex, state,
+						old | CONTENTION_FLAG);
+
+		} while (state && state != old);
+	} while (!state);
+
+sleep:
+	/* need to sleep; set up my own style of waitqueue */
+	tsk = current;
+	waiter.task = tsk;
+
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
+		if (!waiter.task)
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
+	list_del(&waiter.list);
+	spin_unlock_irqrestore(&mutex->wait_lock, flags);
+
+	/* we may still have been given the mutex */
+	ret = 0;
+	if (waiter.task) {
+		put_task_struct(current);
+		ret = -EINTR;
+	}
+	return ret;
+
+early_interrupt:
+	spin_unlock_irqrestore(&mutex->wait_lock, flags);
+	return -EINTR;
+}
+
+/*
+ * fast path for attempting to grab the mutex interruptibly
+ */
+fastcall __sched
+int mutex_lock_interruptible(struct mutex *mutex)
+{
+	unsigned long me = __mutex_owner();
+
+	if (likely(__mutex_cmpxchg(mutex, 0, me) == 0))
+		return 0;
+
+	/* tail-call the slow path */
+	return __mutex_lock_interruptible(mutex, me);
+}
+
+EXPORT_SYMBOL(mutex_lock_interruptible);
+
+/*
+ * report an unlock that doesn't balance a lock in the right context
+ */
+#ifdef CONFIG_DEBUG_MUTEX_OWNER
+static void __bad_mutex_state(struct mutex *mutex)
+{
+	struct task_struct *owner =
+		((struct thread_info *)
+		 (mutex->state & ~CONTENTION_FLAG)
+		 )->task;
+
+	BUG_ON(mutex->state == CONTENTION_FLAG);
+
+	if (!mutex->state) {
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
+		       owner->pid,
+		       owner->comm);
+	}
+}
+#endif
+
+/*
+ * slow path to release a mutex that's under contention
+ * - the queue should not be empty
+ * - noinlined to improve the fastpath case
+ */
+static noinline fastcall __sched
+void __mutex_unlock(struct mutex *mutex, unsigned long me)
+{
+	struct mutex_waiter *waiter;
+	struct task_struct *tsk;
+	unsigned long flags, state;
+
+	/* slow path */
+#ifdef CONFIG_DEBUG_MUTEX_OWNER
+	if ((mutex->state & ~CONTENTION_FLAG) != me)
+		__bad_mutex_state(mutex);
+#endif
+
+	/* must prevent a race */
+	spin_lock_irqsave(&mutex->wait_lock, flags);
+
+	if (!list_empty(&mutex->wait_list)) {
+		/* grant the token to the process at the front of the queue */
+		waiter = list_entry(mutex->wait_list.next,
+				    struct mutex_waiter, list);
+
+		/* we must be careful not to touch 'waiter' after we set ->task
+		 * to NULL.
+		 * - it is an allocated on the waiter's stack and may become
+		 *   invalid at any time after that point (due to a wakeup from
+		 *   another source).
+		 */
+		list_del_init(&waiter->list);
+		tsk = waiter->task;
+		state = (unsigned long) tsk;
+		if (!list_empty(&waiter->list))
+			state |= CONTENTION_FLAG;
+		mutex->state = state;
+		smp_mb();
+		waiter->task = NULL;
+		wake_up_process(tsk);
+		put_task_struct(tsk);
+	}
+	else {
+		mutex->state = 0;
+	}
+
+	spin_unlock_irqrestore(&mutex->wait_lock, flags);
+}
+
+/*
+ * fast path to release a mutex
+ */
+fastcall __sched
+void mutex_unlock(struct mutex *mutex)
+{
+	unsigned long me = __mutex_owner();
+
+	if (__mutex_cmpxchg(mutex, me, 0) == me)
+		return;
+
+	__mutex_unlock(mutex, me);
+}
+
+EXPORT_SYMBOL(mutex_unlock);
diff -uNrp linux-2.6.15-rc5/kernel/mutex-xchg.c linux-2.6.15-rc5-mutex/kernel/mutex-xchg.c
--- linux-2.6.15-rc5/kernel/mutex-xchg.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15-rc5-mutex/kernel/mutex-xchg.c	2005-12-15 19:44:13.000000000 +0000
@@ -0,0 +1,220 @@
+/* mutex-xchg.c: simple exchange-based mutex slow paths
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
+noinline fastcall __sched
+void  __mutex_lock(struct mutex *mutex)
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
+	if (mutex_trylock(mutex)) {
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
+		if (!waiter.task)
+			break;
+		schedule();
+		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
+	}
+
+	tsk->state = TASK_RUNNING;
+}
+
+/*
+ * fast path for attempting to grab the mutex
+ */
+#if 0
+fastcall __sched
+void mutex_lock(struct mutex *mutex)
+{
+	if (!mutex_trylock(mutex))
+		__mutex_lock(mutex);
+}
+#endif
+
+EXPORT_SYMBOL(__mutex_lock);
+
+/*
+ * slow path to interruptibly wait for a mutex to be granted to the caller
+ */
+noinline fastcall __sched
+int __mutex_lock_interruptible(struct mutex *mutex)
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
+	if (mutex_trylock(mutex)) {
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
+		if (!waiter.task)
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
+	list_del(&waiter.list);
+	spin_unlock_irqrestore(&mutex->wait_lock, flags);
+
+	/* we may still have been given the mutex */
+	ret = 0;
+	if (waiter.task) {
+		put_task_struct(current);
+		ret = -EINTR;
+	}
+	return ret;
+}
+
+/*
+ * fast path for attempting to grab the mutex interruptibly
+ */
+#if 0
+fastcall __sched
+int mutex_lock_interruptible(struct mutex *mutex)
+{
+	if (mutex_trylock(mutex))
+		return 0;
+
+	return __mutex_lock_interruptible(mutex);
+}
+#endif
+
+EXPORT_SYMBOL(__mutex_lock_interruptible);
+
+/*
+ * report an up() that doesn't match a mutex_lock()
+ */
+#ifdef CONFIG_DEBUG_MUTEX_OWNER
+static void __bad_mutex_state(struct mutex *mutex)
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
+#endif
+
+/*
+ * release a mutex
+ */
+void fastcall __sched mutex_unlock(struct mutex *mutex)
+{
+	struct mutex_waiter *waiter;
+	struct task_struct *tsk;
+	unsigned long flags;
+
+#ifdef CONFIG_DEBUG_MUTEX_OWNER
+	if (mutex->__owner != current)
+		__bad_mutex_state(mutex);
+	mutex->__owner = NULL;
+#endif
+
+	/* must prevent a race */
+	spin_lock_irqsave(&mutex->wait_lock, flags);
+
+	if (!list_empty(&mutex->wait_list)) {
+		/* grant the token to the process at the front of the queue */
+		waiter = list_entry(mutex->wait_list.next,
+				    struct mutex_waiter, list);
+
+		/* we must be careful not to touch 'waiter' after we set ->task
+		 * to NULL.
+		 * - it is an allocated on the waiter's stack and may become
+		 *   invalid at any time after that point (due to a wakeup from
+		 *   another source).
+		 */
+		list_del_init(&waiter->list);
+		tsk = waiter->task;
+#ifdef CONFIG_DEBUG_MUTEX_OWNER
+		mutex->__owner = tsk;
+#endif
+		smp_mb();
+		waiter->task = NULL;
+		wake_up_process(tsk);
+		put_task_struct(tsk);
+	}
+	else {
+		__mutex_release(mutex);
+	}
+
+	spin_unlock_irqrestore(&mutex->wait_lock, flags);
+}
+
+EXPORT_SYMBOL(mutex_unlock);
diff -uNrp linux-2.6.15-rc5/kernel/posix-timers.c linux-2.6.15-rc5-mutex/kernel/posix-timers.c
--- linux-2.6.15-rc5/kernel/posix-timers.c	2005-12-08 16:23:55.000000000 +0000
+++ linux-2.6.15-rc5-mutex/kernel/posix-timers.c	2005-12-15 17:14:57.000000000 +0000
@@ -1312,7 +1312,7 @@ sys_clock_getres(clockid_t which_clock, 
 static DECLARE_WAIT_QUEUE_HEAD(nanosleep_abs_wqueue);
 static DECLARE_WORK(clock_was_set_work, (void(*)(void*))clock_was_set, NULL);
 
-static DECLARE_MUTEX(clock_was_set_lock);
+static DECLARE_SEM_MUTEX(clock_was_set_lock);
 
 void clock_was_set(void)
 {
diff -uNrp linux-2.6.15-rc5/kernel/power/main.c linux-2.6.15-rc5-mutex/kernel/power/main.c
--- linux-2.6.15-rc5/kernel/power/main.c	2005-12-08 16:23:55.000000000 +0000
+++ linux-2.6.15-rc5-mutex/kernel/power/main.c	2005-12-15 17:14:57.000000000 +0000
@@ -22,7 +22,7 @@
 /*This is just an arbitrary number */
 #define FREE_PAGE_NUMBER (100)
 
-DECLARE_MUTEX(pm_sem);
+DECLARE_SEM_MUTEX(pm_sem);
 
 struct pm_ops *pm_ops;
 suspend_disk_method_t pm_disk_mode = PM_DISK_SHUTDOWN;
diff -uNrp linux-2.6.15-rc5/kernel/power/pm.c linux-2.6.15-rc5-mutex/kernel/power/pm.c
--- linux-2.6.15-rc5/kernel/power/pm.c	2005-12-08 16:23:55.000000000 +0000
+++ linux-2.6.15-rc5-mutex/kernel/power/pm.c	2005-12-15 17:14:57.000000000 +0000
@@ -40,7 +40,7 @@ int pm_active;
  *	until a resume but that will be fine.
  */
  
-static DECLARE_MUTEX(pm_devs_lock);
+static DECLARE_SEM_MUTEX(pm_devs_lock);
 static LIST_HEAD(pm_devs);
 
 /**
diff -uNrp linux-2.6.15-rc5/kernel/printk.c linux-2.6.15-rc5-mutex/kernel/printk.c
--- linux-2.6.15-rc5/kernel/printk.c	2005-12-08 16:23:56.000000000 +0000
+++ linux-2.6.15-rc5-mutex/kernel/printk.c	2005-12-15 17:14:57.000000000 +0000
@@ -66,7 +66,7 @@ EXPORT_SYMBOL(oops_in_progress);
  * provides serialisation for access to the entire console
  * driver system.
  */
-static DECLARE_MUTEX(console_sem);
+static DECLARE_SEM_MUTEX(console_sem);
 struct console *console_drivers;
 /*
  * This is used for debugging the mess that is the VT code by
diff -uNrp linux-2.6.15-rc5/kernel/profile.c linux-2.6.15-rc5-mutex/kernel/profile.c
--- linux-2.6.15-rc5/kernel/profile.c	2005-08-30 13:56:40.000000000 +0100
+++ linux-2.6.15-rc5-mutex/kernel/profile.c	2005-12-15 17:14:57.000000000 +0000
@@ -44,7 +44,7 @@ static cpumask_t prof_cpu_mask = CPU_MAS
 #ifdef CONFIG_SMP
 static DEFINE_PER_CPU(struct profile_hit *[2], cpu_profile_hits);
 static DEFINE_PER_CPU(int, cpu_profile_flip);
-static DECLARE_MUTEX(profile_flip_mutex);
+static DECLARE_SEM_MUTEX(profile_flip_mutex);
 #endif /* CONFIG_SMP */
 
 static int __init profile_setup(char * str)
diff -uNrp linux-2.6.15-rc5/kernel/stop_machine.c linux-2.6.15-rc5-mutex/kernel/stop_machine.c
--- linux-2.6.15-rc5/kernel/stop_machine.c	2005-12-08 16:23:56.000000000 +0000
+++ linux-2.6.15-rc5-mutex/kernel/stop_machine.c	2005-12-15 17:14:57.000000000 +0000
@@ -23,7 +23,7 @@ enum stopmachine_state {
 static enum stopmachine_state stopmachine_state;
 static unsigned int stopmachine_num_threads;
 static atomic_t stopmachine_thread_ack;
-static DECLARE_MUTEX(stopmachine_mutex);
+static DECLARE_SEM_MUTEX(stopmachine_mutex);
 
 static int stopmachine(void *cpu)
 {
