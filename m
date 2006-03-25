Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbWCYSu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbWCYSu1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 13:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWCYSt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 13:49:58 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:45523 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932236AbWCYStW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 13:49:22 -0500
Date: Sat, 25 Mar 2006 19:46:34 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>
Subject: [patch 08/10] PI-futex: rt-mutex tester
Message-ID: <20060325184634.GI16724@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

From: Thomas Gleixner <tglx@linutronix.de>

RT-mutex tester: scriptable tester for rt mutexes, which allows userspace
scripting of mutex unit-tests (and dynamic tests as well), using the
actual rt-mutex implementation of the kernel.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

----

 include/linux/rtmutex_internal.h             |   22 +
 include/linux/sched.h                        |    1 
 kernel/Makefile                              |    1 
 kernel/rtmutex-tester.c                      |  436 +++++++++++++++++++++++++++
 kernel/rtmutex.c                             |    3 
 lib/Kconfig.debug                            |    7 
 scripts/rt-tester/check-all.sh               |   21 +
 scripts/rt-tester/rt-tester.py               |  222 +++++++++++++
 scripts/rt-tester/t2-l1-2rt-sameprio.tst     |  101 ++++++
 scripts/rt-tester/t2-l1-pi.tst               |   84 +++++
 scripts/rt-tester/t2-l1-signal.tst           |   79 ++++
 scripts/rt-tester/t2-l2-2rt-deadlock.tst     |   91 +++++
 scripts/rt-tester/t3-l1-pi-1rt.tst           |   95 +++++
 scripts/rt-tester/t3-l1-pi-2rt.tst           |   96 +++++
 scripts/rt-tester/t3-l1-pi-3rt.tst           |   95 +++++
 scripts/rt-tester/t3-l1-pi-signal.tst        |   98 ++++++
 scripts/rt-tester/t3-l1-pi-steal.tst         |   99 ++++++
 scripts/rt-tester/t3-l2-pi.tst               |   95 +++++
 scripts/rt-tester/t4-l2-pi-deboost.tst       |  127 +++++++
 scripts/rt-tester/t5-l4-pi-boost-deboost.tst |  148 +++++++++
 20 files changed, 1920 insertions(+), 1 deletion(-)

Index: linux-pi-futex.mm.q/include/linux/rtmutex_internal.h
===================================================================
--- linux-pi-futex.mm.q.orig/include/linux/rtmutex_internal.h
+++ linux-pi-futex.mm.q/include/linux/rtmutex_internal.h
@@ -15,6 +15,28 @@
 #include <linux/rtmutex.h>
 
 /*
+ * The rtmutex in kernel tester is independent of rtmutex debugging. We
+ * call schedule_rt_mutex_test() instead of schedule() for the tasks which
+ * belong to the tester. That way we can delay the wakeup path of those
+ * threads to provoke lock stealing and testing of  complex boosting scenarios.
+ */
+#ifdef CONFIG_RT_MUTEX_TESTER
+
+extern void schedule_rt_mutex_test(struct rt_mutex *lock);
+
+#define schedule_rt_mutex(_lock)				\
+  do {								\
+	if (!(current->flags & PF_MUTEX_TESTER))		\
+		schedule();					\
+	else							\
+		schedule_rt_mutex_test(_lock);			\
+  } while (0)
+
+#else
+# define schedule_rt_mutex(_lock)			schedule()
+#endif
+
+/*
  * This is the control structure for tasks blocked on a rt_mutex,
  * which is allocated on the kernel stack on of the blocked task.
  *
Index: linux-pi-futex.mm.q/include/linux/sched.h
===================================================================
--- linux-pi-futex.mm.q.orig/include/linux/sched.h
+++ linux-pi-futex.mm.q/include/linux/sched.h
@@ -981,6 +981,7 @@ static inline void put_task_struct(struc
 #define PF_SPREAD_PAGE	0x04000000	/* Spread page cache over cpuset */
 #define PF_SPREAD_SLAB	0x08000000	/* Spread some slab caches over cpuset */
 #define PF_MEMPOLICY	0x10000000	/* Non-default NUMA mempolicy */
+#define PF_MUTEX_TESTER	0x20000000	/* Thread belongs to the rt mutex tester */
 
 /*
  * Only the _current_ task can read/write to tsk->flags, but other
Index: linux-pi-futex.mm.q/kernel/Makefile
===================================================================
--- linux-pi-futex.mm.q.orig/kernel/Makefile
+++ linux-pi-futex.mm.q/kernel/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_FUTEX) += futex_compat.o
 endif
 obj-$(CONFIG_RT_MUTEXES) += rtmutex.o
 obj-$(CONFIG_DEBUG_RT_MUTEXES) += rtmutex-debug.o
+obj-$(CONFIG_RT_MUTEX_TESTER) += rtmutex-tester.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += cpu.o spinlock.o
 obj-$(CONFIG_DEBUG_SPINLOCK) += spinlock.o
Index: linux-pi-futex.mm.q/kernel/rtmutex-tester.c
===================================================================
--- /dev/null
+++ linux-pi-futex.mm.q/kernel/rtmutex-tester.c
@@ -0,0 +1,436 @@
+/*
+ * RT-Mutex-tester: scriptable tester for rt mutexes
+ *
+ * started by Thomas Gleixner:
+ *
+ *  Copyright (C) 2006, Timesys Corp., Thomas Gleixner <tglx@timesys.com>
+ *
+ */
+#include <linux/config.h>
+#include <linux/kthread.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/smp_lock.h>
+#include <linux/spinlock.h>
+#include <linux/sysdev.h>
+#include <linux/timer.h>
+
+#include "rtmutex.h"
+
+#define MAX_RT_TEST_THREADS	8
+#define MAX_RT_TEST_MUTEXES	8
+
+static spinlock_t rttest_lock;
+static atomic_t rttest_event;
+
+struct test_thread_data {
+	int			opcode;
+	int			opdata;
+	int			mutexes[MAX_RT_TEST_MUTEXES];
+	int			bkl;
+	int			event;
+	struct sys_device	sysdev;
+};
+
+static struct test_thread_data thread_data[MAX_RT_TEST_THREADS];
+static task_t *threads[MAX_RT_TEST_THREADS];
+static struct rt_mutex mutexes[MAX_RT_TEST_MUTEXES];
+
+enum test_opcodes {
+	RTTEST_NOP = 0,
+	RTTEST_SCHEDOT,		/* 1 Sched other, data = nice */
+	RTTEST_SCHEDRT,		/* 2 Sched fifo, data = prio */
+	RTTEST_LOCK,		/* 3 Lock uninterruptible, data = lockindex */
+	RTTEST_LOCKNOWAIT,	/* 4 Lock uninterruptible no wait in wakeup, data = lockindex */
+	RTTEST_LOCKINT,		/* 5 Lock interruptible, data = lockindex */
+	RTTEST_LOCKINTNOWAIT,	/* 6 Lock interruptible no wait in wakeup, data = lockindex */
+	RTTEST_LOCKCONT,	/* 7 Continue locking after the wakeup delay */
+	RTTEST_UNLOCK,		/* 8 Unlock, data = lockindex */
+	RTTEST_LOCKBKL, 	/* 9 Lock BKL */
+	RTTEST_UNLOCKBKL,	/* 10 Unlock BKL */
+	RTTEST_SIGNAL,		/* 11 Signal other test thread, data = thread id */
+	RTTEST_RESETEVENT = 98,	/* 98 Reset event counter */
+	RTTEST_RESET = 99,	/* 99 Reset all pending operations */
+};
+
+static int handle_op(struct test_thread_data *td, int lockwakeup)
+{
+	struct sched_param schedpar;
+	int i, id, ret = -EINVAL;
+
+	switch(td->opcode) {
+
+	case RTTEST_NOP:
+		return 0;
+
+	case RTTEST_SCHEDOT:
+		schedpar.sched_priority = 0;
+		ret = sched_setscheduler(current, SCHED_NORMAL, &schedpar);
+		if (!ret)
+			set_user_nice(current, 0);
+		return ret;
+
+	case RTTEST_SCHEDRT:
+		schedpar.sched_priority = td->opdata;
+		return sched_setscheduler(current, SCHED_FIFO, &schedpar);
+
+	case RTTEST_LOCKCONT:
+		td->mutexes[td->opdata] = 1;
+		td->event = atomic_add_return(1, &rttest_event);
+		return 0;
+
+	case RTTEST_RESET:
+		for (i = 0; i < MAX_RT_TEST_MUTEXES; i++) {
+			if (td->mutexes[i] == 4) {
+				rt_mutex_unlock(&mutexes[i]);
+				td->mutexes[i] = 0;
+			}
+		}
+
+		if (!lockwakeup && td->bkl == 4) {
+			unlock_kernel();
+			td->bkl = 0;
+		}
+		return 0;
+
+	case RTTEST_RESETEVENT:
+		atomic_set(&rttest_event, 0);
+		return 0;
+
+	default:
+		if (lockwakeup)
+			return ret;
+	}
+
+	switch(td->opcode) {
+
+	case RTTEST_LOCK:
+	case RTTEST_LOCKNOWAIT:
+		id = td->opdata;
+		if (id < 0 || id >= MAX_RT_TEST_MUTEXES)
+			return ret;
+
+		td->mutexes[id] = 1;
+		td->event = atomic_add_return(1, &rttest_event);
+		rt_mutex_lock(&mutexes[id]);
+		td->event = atomic_add_return(1, &rttest_event);
+		td->mutexes[id] = 4;
+		return 0;
+
+	case RTTEST_LOCKINT:
+	case RTTEST_LOCKINTNOWAIT:
+		id = td->opdata;
+		if (id < 0 || id >= MAX_RT_TEST_MUTEXES)
+			return ret;
+
+		td->mutexes[id] = 1;
+		td->event = atomic_add_return(1, &rttest_event);
+		ret = rt_mutex_lock_interruptible(&mutexes[id], 0);
+		td->event = atomic_add_return(1, &rttest_event);
+		td->mutexes[id] = ret ? 0 : 4;
+		return ret ? -EINTR : 0;
+
+	case RTTEST_UNLOCK:
+		id = td->opdata;
+		if (id < 0 || id >= MAX_RT_TEST_MUTEXES || td->mutexes[id] != 4)
+			return ret;
+
+		td->event = atomic_add_return(1, &rttest_event);
+		rt_mutex_unlock(&mutexes[id]);
+		td->event = atomic_add_return(1, &rttest_event);
+		td->mutexes[id] = 0;
+		return 0;
+
+	case RTTEST_LOCKBKL:
+		if (td->bkl)
+			return 0;
+		td->bkl = 1;
+		lock_kernel();
+		td->bkl = 4;
+		return 0;
+
+	case RTTEST_UNLOCKBKL:
+		if (td->bkl != 4)
+			break;
+		unlock_kernel();
+		td->bkl = 0;
+		return 0;
+
+	default:
+		break;
+	}
+	return ret;
+}
+
+/*
+ * Schedule replacement for rtsem_down(). Only called for threads with
+ * PF_MUTEX_TESTER set.
+ *
+ * This allows us to have finegrained control over the event flow.
+ *
+ */
+void schedule_rt_mutex_test(struct rt_mutex *mutex)
+{
+	int tid, op, dat;
+	struct test_thread_data *td;
+
+	/* We have to lookup the task */
+	for (tid = 0; tid < MAX_RT_TEST_THREADS; tid++) {
+		if (threads[tid] == current)
+			break;
+	}
+
+	BUG_ON(tid == MAX_RT_TEST_THREADS);
+
+	td = &thread_data[tid];
+
+	op = td->opcode;
+	dat = td->opdata;
+
+	switch (op) {
+	case RTTEST_LOCK:
+	case RTTEST_LOCKINT:
+	case RTTEST_LOCKNOWAIT:
+	case RTTEST_LOCKINTNOWAIT:
+		if (mutex != &mutexes[dat])
+			break;
+
+		if (td->mutexes[dat] != 1)
+			break;
+
+		td->mutexes[dat] = 2;
+		td->event = atomic_add_return(1, &rttest_event);
+		break;
+
+	case RTTEST_LOCKBKL:
+	default:
+		break;
+	}
+
+	schedule();
+
+
+	switch (op) {
+	case RTTEST_LOCK:
+	case RTTEST_LOCKINT:
+		if (mutex != &mutexes[dat])
+			return;
+
+		if (td->mutexes[dat] != 2)
+			return;
+
+		td->mutexes[dat] = 3;
+		td->event = atomic_add_return(1, &rttest_event);
+		break;
+
+	case RTTEST_LOCKNOWAIT:
+	case RTTEST_LOCKINTNOWAIT:
+		if (mutex != &mutexes[dat])
+			return;
+
+		if (td->mutexes[dat] != 2)
+			return;
+
+		td->mutexes[dat] = 1;
+		td->event = atomic_add_return(1, &rttest_event);
+		return;
+
+	case RTTEST_LOCKBKL:
+		return;
+	default:
+		return;
+	}
+
+	td->opcode = 0;
+
+	for (;;) {
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		if (td->opcode > 0) {
+			int ret;
+
+			set_current_state(TASK_RUNNING);
+			ret = handle_op(td, 1);
+			set_current_state(TASK_INTERRUPTIBLE);
+			if (td->opcode == RTTEST_LOCKCONT)
+				break;
+			td->opcode = ret;
+		}
+
+		/* Wait for the next command to be executed */
+		schedule();
+	}
+
+	/* Restore previous command and data */
+	td->opcode = op;
+	td->opdata = dat;
+}
+
+static int test_func(void *data)
+{
+	struct test_thread_data *td = data;
+	int ret;
+
+	current->flags |= PF_MUTEX_TESTER;
+	allow_signal(SIGHUP);
+
+	for(;;) {
+
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		if (td->opcode > 0) {
+			set_current_state(TASK_RUNNING);
+			ret = handle_op(td, 0);
+			set_current_state(TASK_INTERRUPTIBLE);
+			td->opcode = ret;
+		}
+
+		/* Wait for the next command to be executed */
+		schedule();
+
+		if (signal_pending(current))
+			flush_signals(current);
+
+		if(kthread_should_stop())
+			break;
+	}
+	return 0;
+}
+
+/**
+ * sysfs_test_command - interface for test commands
+ * @dev:	thread reference
+ * @buf:	command for actual step
+ * @count:	length of buffer
+ *
+ * command syntax:
+ *
+ * opcode:data
+ */
+static ssize_t sysfs_test_command(struct sys_device *dev, const char *buf,
+				  size_t count)
+{
+	struct test_thread_data *td;
+	char cmdbuf[32];
+	int op, dat, tid;
+
+	td = container_of(dev, struct test_thread_data, sysdev);
+	tid = td->sysdev.id;
+
+	/* strings from sysfs write are not 0 terminated! */
+	if (count >= sizeof(cmdbuf))
+		return -EINVAL;
+
+	/* strip of \n: */
+	if (buf[count-1] == '\n')
+		count--;
+	if (count < 1)
+		return -EINVAL;
+
+	memcpy(cmdbuf, buf, count);
+	cmdbuf[count] = 0;
+
+	if (sscanf(cmdbuf, "%d:%d", &op, &dat) != 2)
+		return -EINVAL;
+
+	switch (op) {
+	case RTTEST_SIGNAL:
+		send_sig(SIGHUP, threads[tid], 0);
+		break;
+
+	default:
+		if (td->opcode > 0)
+			return -EBUSY;
+		td->opdata = dat;
+		td->opcode = op;
+		wake_up_process(threads[tid]);
+	}
+
+	return count;
+}
+
+/**
+ * sysfs_test_status - sysfs interface for rt tester
+ * @dev:	thread to query
+ * @buf:	char buffer to be filled with thread status info
+ */
+static ssize_t sysfs_test_status(struct sys_device *dev, char *buf)
+{
+	struct test_thread_data *td;
+	char *curr = buf;
+	task_t *tsk;
+	int i;
+
+	td = container_of(dev, struct test_thread_data, sysdev);
+	tsk = threads[td->sysdev.id];
+
+	spin_lock(&rttest_lock);
+
+	curr += sprintf(curr,
+		"O: %4d, E:%8d, S: 0x%08lx, P: %4d, N: %4d, B: %p, K: %d, M:",
+		td->opcode, td->event, tsk->state,
+			(MAX_RT_PRIO - 1) - tsk->prio,
+			(MAX_RT_PRIO - 1) - tsk->normal_prio,
+		tsk->pi_blocked_on, td->bkl);
+
+	for (i = MAX_RT_TEST_MUTEXES - 1; i >=0 ; i--)
+		curr += sprintf(curr, "%d", td->mutexes[i]);
+
+	spin_unlock(&rttest_lock);
+
+	curr += sprintf(curr, ", T: %p, R: %p\n", tsk,
+			mutexes[td->sysdev.id].owner);
+
+	return curr - buf;
+}
+
+static SYSDEV_ATTR(status, 0600, sysfs_test_status, NULL);
+static SYSDEV_ATTR(command, 0600, NULL, sysfs_test_command);
+
+static struct sysdev_class rttest_sysclass = {
+	set_kset_name("rttest"),
+};
+
+static int init_test_thread(int id)
+{
+	thread_data[id].sysdev.cls = &rttest_sysclass;
+	thread_data[id].sysdev.id = id;
+
+	threads[id] = kthread_run(test_func, &thread_data[id], "rt-test-%d", id);
+	if (IS_ERR(threads[id]))
+		return PTR_ERR(threads[id]);
+
+	return sysdev_register(&thread_data[id].sysdev);
+}
+
+static int init_rttest(void)
+{
+	int ret, i;
+
+	spin_lock_init(&rttest_lock);
+
+	for (i = 0; i < MAX_RT_TEST_MUTEXES; i++)
+		rt_mutex_init(&mutexes[i]);
+
+	ret = sysdev_class_register(&rttest_sysclass);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < MAX_RT_TEST_THREADS; i++) {
+		ret = init_test_thread(i);
+		if (ret)
+			break;
+		ret = sysdev_create_file(&thread_data[i].sysdev, &attr_status);
+		if (ret)
+			break;
+		ret = sysdev_create_file(&thread_data[i].sysdev, &attr_command);
+		if (ret)
+			break;
+	}
+
+	printk("Initializing RT-Tester: %s\n", ret ? "Failed" : "OK" );
+
+	return ret;
+}
+
+device_initcall(init_rttest);
Index: linux-pi-futex.mm.q/kernel/rtmutex.c
===================================================================
--- linux-pi-futex.mm.q.orig/kernel/rtmutex.c
+++ linux-pi-futex.mm.q/kernel/rtmutex.c
@@ -671,7 +671,8 @@ rt_mutex_slowlock(struct rt_mutex *lock,
 
 		debug_rt_mutex_print_deadlock(&waiter);
 
-		schedule();
+		if (waiter.task)
+			schedule_rt_mutex(lock);
 
 		spin_lock_irqsave(&lock->wait_lock, flags);
 		set_task_state(current, state);
Index: linux-pi-futex.mm.q/lib/Kconfig.debug
===================================================================
--- linux-pi-futex.mm.q.orig/lib/Kconfig.debug
+++ linux-pi-futex.mm.q/lib/Kconfig.debug
@@ -134,6 +134,13 @@ config DEBUG_PI_LIST
 	default y
 	depends on DEBUG_RT_MUTEXES
 
+config RT_MUTEX_TESTER
+	bool "Built-in scriptable tester for rt-mutexes"
+	depends on RT_MUTEXES
+	default n
+	help
+	  This option enables a rt-mutex tester.
+
 config DEBUG_SPINLOCK
 	bool "Spinlock debugging"
 	depends on DEBUG_KERNEL
Index: linux-pi-futex.mm.q/scripts/rt-tester/check-all.sh
===================================================================
--- /dev/null
+++ linux-pi-futex.mm.q/scripts/rt-tester/check-all.sh
@@ -0,0 +1,21 @@
+
+
+function testit ()
+{
+ printf "%-30s: " $1
+ ./rt-tester.py $1 | grep Pass
+}
+
+testit t2-l1-2rt-sameprio.tst
+testit t2-l1-pi.tst
+testit t2-l1-signal.tst
+#testit t2-l2-2rt-deadlock.tst
+testit t3-l1-pi-1rt.tst
+testit t3-l1-pi-2rt.tst
+testit t3-l1-pi-3rt.tst
+testit t3-l1-pi-signal.tst
+testit t3-l1-pi-steal.tst
+testit t3-l2-pi.tst
+testit t4-l2-pi-deboost.tst
+testit t5-l4-pi-boost-deboost.tst
+
Index: linux-pi-futex.mm.q/scripts/rt-tester/rt-tester.py
===================================================================
--- /dev/null
+++ linux-pi-futex.mm.q/scripts/rt-tester/rt-tester.py
@@ -0,0 +1,222 @@
+#!/usr/bin/env python
+#
+# rt-mutex tester
+#
+# (C) 2006 Thomas Gleixner <tglx@linutronix.de>
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+import os
+import sys
+import getopt
+import shutil
+import string
+
+# Globals
+quiet = 0
+test = 0
+comments = 0
+
+sysfsprefix = "/sys/devices/system/rttest/rttest"
+statusfile = "/status"
+commandfile = "/command"
+
+# Command opcodes
+cmd_opcodes = {
+    "schedother"    : "1",
+    "schedfifo"     : "2",
+    "lock"          : "3",
+    "locknowait"    : "4",
+    "lockint"       : "5",
+    "lockintnowait" : "6",
+    "lockcont"      : "7",
+    "unlock"        : "8",
+    "lockbkl"       : "9",
+    "unlockbkl"     : "10",
+    "signal"        : "11",
+    "resetevent"    : "98",
+    "reset"         : "99",
+    }
+
+test_opcodes = {
+    "prioeq"        : ["P" , "eq" , None],
+    "priolt"        : ["P" , "lt" , None],
+    "priogt"        : ["P" , "gt" , None],
+    "nprioeq"       : ["N" , "eq" , None],
+    "npriolt"       : ["N" , "lt" , None],
+    "npriogt"       : ["N" , "gt" , None],
+    "unlocked"      : ["M" , "eq" , 0],
+    "trylock"       : ["M" , "eq" , 1],
+    "blocked"       : ["M" , "eq" , 2],
+    "blockedwake"   : ["M" , "eq" , 3],
+    "locked"        : ["M" , "eq" , 4],
+    "opcodeeq"      : ["O" , "eq" , None],
+    "opcodelt"      : ["O" , "lt" , None],
+    "opcodegt"      : ["O" , "gt" , None],
+    "eventeq"       : ["E" , "eq" , None],
+    "eventlt"       : ["E" , "lt" , None],
+    "eventgt"       : ["E" , "gt" , None],
+    }
+
+# Print usage information
+def usage():
+    print "rt-tester.py <-c -h -q -t> <testfile>"
+    print " -c    display comments after first command"
+    print " -h    help"
+    print " -q    quiet mode"
+    print " -t    test mode (syntax check)"
+    print " testfile: read test specification from testfile"
+    print " otherwise from stdin"
+    return
+
+# Print progress when not in quiet mode
+def progress(str):
+    if not quiet:
+        print str
+
+# Analyse a status value
+def analyse(val, top, arg):
+
+    intval = int(val)
+
+    if top[0] == "M":
+        intval = intval / (10 ** int(arg))
+	intval = intval % 10
+        argval = top[2]
+    elif top[0] == "O":
+        argval = int(cmd_opcodes.get(arg, arg))
+    else:
+        argval = int(arg)
+
+    # progress("%d %s %d" %(intval, top[1], argval))
+
+    if top[1] == "eq" and intval == argval:
+	return 1
+    if top[1] == "lt" and intval < argval:
+        return 1
+    if top[1] == "gt" and intval > argval:
+	return 1
+    return 0
+
+# Parse the commandline
+try:
+    (options, arguments) = getopt.getopt(sys.argv[1:],'chqt')
+except getopt.GetoptError, ex:
+    usage()
+    sys.exit(1)
+
+# Parse commandline options
+for option, value in options:
+    if option == "-c":
+        comments = 1
+    elif option == "-q":
+        quiet = 1
+    elif option == "-t":
+        test = 1
+    elif option == '-h':
+        usage()
+        sys.exit(0)
+
+# Select the input source
+if arguments:
+    try:
+        fd = open(arguments[0])
+    except Exception,ex:
+        sys.stderr.write("File not found %s\n" %(arguments[0]))
+        sys.exit(1)
+else:
+    fd = sys.stdin
+
+linenr = 0
+
+# Read the test patterns
+while 1:
+
+    linenr = linenr + 1
+    line = fd.readline()
+    if not len(line):
+        break
+
+    line = line.strip()
+    parts = line.split(":")
+
+    if not parts or len(parts) < 1:
+        continue
+
+    if len(parts[0]) == 0:
+        continue
+
+    if parts[0].startswith("#"):
+	if comments > 1:
+	    progress(line)
+	continue
+
+    if comments == 1:
+	comments = 2
+
+    progress(line)
+
+    cmd = parts[0].strip().lower()
+    opc = parts[1].strip().lower()
+    tid = parts[2].strip()
+    dat = parts[3].strip()
+
+    try:
+        # Test or wait for a status value
+        if cmd == "t" or cmd == "w":
+            testop = test_opcodes[opc]
+
+            fname = "%s%s%s" %(sysfsprefix, tid, statusfile)
+            if test:
+		print fname
+                continue
+
+            while 1:
+                query = 1
+                fsta = open(fname, 'r')
+                status = fsta.readline().strip()
+                fsta.close()
+                stat = status.split(",")
+                for s in stat:
+		    s = s.strip()
+                    if s.startswith(testop[0]):
+                        # Seperate status value
+                        val = s[2:].strip()
+                        query = analyse(val, testop, dat)
+                        break
+                if query or cmd == "t":
+                    break
+
+            progress("   " + status)
+
+            if not query:
+                sys.stderr.write("Test failed in line %d\n" %(linenr))
+		sys.exit(1)
+
+        # Issue a command to the tester
+        elif cmd == "c":
+            cmdnr = cmd_opcodes[opc]
+            # Build command string and sys filename
+            cmdstr = "%s:%s" %(cmdnr, dat)
+            fname = "%s%s%s" %(sysfsprefix, tid, commandfile)
+            if test:
+		print fname
+                continue
+            fcmd = open(fname, 'w')
+            fcmd.write(cmdstr)
+            fcmd.close()
+
+    except Exception,ex:
+    	sys.stderr.write(str(ex))
+        sys.stderr.write("\nSyntax error in line %d\n" %(linenr))
+        if not test:
+            fd.close()
+            sys.exit(1)
+
+# Normal exit pass
+print "Pass"
+sys.exit(0)
+
+
Index: linux-pi-futex.mm.q/scripts/rt-tester/t2-l1-2rt-sameprio.tst
===================================================================
--- /dev/null
+++ linux-pi-futex.mm.q/scripts/rt-tester/t2-l1-2rt-sameprio.tst
@@ -0,0 +1,101 @@
+#
+# RT-Mutex test
+#
+# Op: C(ommand)/T(est)/W(ait)
+# |  opcode
+# |  |     threadid: 0-7
+# |  |     |  opcode argument
+# |  |     |  |
+# C: lock: 0: 0
+#
+# Commands
+#
+# opcode	opcode argument
+# schedother	nice value
+# schedfifo	priority
+# lock		lock nr (0-7)
+# locknowait	lock nr (0-7)
+# lockint	lock nr (0-7)
+# lockintnowait	lock nr (0-7)
+# lockcont	lock nr (0-7)
+# unlock	lock nr (0-7)
+# lockbkl	lock nr (0-7)
+# unlockbkl	lock nr (0-7)
+# signal	0
+# reset		0
+# resetevent	0
+#
+# Tests / Wait
+#
+# opcode	opcode argument
+#
+# prioeq	priority
+# priolt	priority
+# priogt	priority
+# nprioeq	normal priority
+# npriolt	normal priority
+# npriogt	normal priority
+# locked	lock nr (0-7)
+# blocked	lock nr (0-7)
+# blockedwake	lock nr (0-7)
+# unlocked	lock nr (0-7)
+# lockedbkl	dont care
+# blockedbkl	dont care
+# unlockedbkl	dont care
+# opcodeeq	command opcode or number
+# opcodelt	number
+# opcodegt	number
+# eventeq	number
+# eventgt	number
+# eventlt	number
+
+#
+# 2 threads 1 lock
+#
+C: resetevent:		0: 	0
+W: opcodeeq:		0: 	0
+
+# Set schedulers
+C: schedfifo:		0: 	80
+W: opcodeeq:		0: 	0
+C: schedfifo:		1: 	80
+W: opcodeeq:		1: 	0
+
+# T0 lock L0
+C: locknowait:		0: 	0
+C: locknowait:		1:	0
+W: locked:		0: 	0
+W: blocked:		1: 	0
+T: prioeq:		0: 	80
+
+# T0 unlock L0
+C: unlock:		0: 	0
+W: locked:		1: 	0
+
+# Verify T0
+W: unlocked:		0: 	0
+T: prioeq:		0: 	80
+
+# Unlock
+C: unlock:		1: 	0
+W: unlocked:		1: 	0
+
+# T1,T0 lock L0
+C: locknowait:		1: 	0
+C: locknowait:		0:	0
+W: locked:		1: 	0
+W: blocked:		0: 	0
+T: prioeq:		1: 	80
+
+# T1 unlock L0
+C: unlock:		1: 	0
+W: locked:		0: 	0
+
+# Verify T1
+W: unlocked:		1: 	0
+T: prioeq:		1: 	80
+
+# Unlock and exit
+C: unlock:		0: 	0
+W: unlocked:		0: 	0
+
Index: linux-pi-futex.mm.q/scripts/rt-tester/t2-l1-pi.tst
===================================================================
--- /dev/null
+++ linux-pi-futex.mm.q/scripts/rt-tester/t2-l1-pi.tst
@@ -0,0 +1,84 @@
+#
+# RT-Mutex test
+#
+# Op: C(ommand)/T(est)/W(ait)
+# |  opcode
+# |  |     threadid: 0-7
+# |  |     |  opcode argument
+# |  |     |  |
+# C: lock: 0: 0
+#
+# Commands
+#
+# opcode	opcode argument
+# schedother	nice value
+# schedfifo	priority
+# lock		lock nr (0-7)
+# locknowait	lock nr (0-7)
+# lockint	lock nr (0-7)
+# lockintnowait	lock nr (0-7)
+# lockcont	lock nr (0-7)
+# unlock	lock nr (0-7)
+# lockbkl	lock nr (0-7)
+# unlockbkl	lock nr (0-7)
+# signal	0
+# reset		0
+# resetevent	0
+#
+# Tests / Wait
+#
+# opcode	opcode argument
+#
+# prioeq	priority
+# priolt	priority
+# priogt	priority
+# nprioeq	normal priority
+# npriolt	normal priority
+# npriogt	normal priority
+# locked	lock nr (0-7)
+# blocked	lock nr (0-7)
+# blockedwake	lock nr (0-7)
+# unlocked	lock nr (0-7)
+# lockedbkl	dont care
+# blockedbkl	dont care
+# unlockedbkl	dont care
+# opcodeeq	command opcode or number
+# opcodelt	number
+# opcodegt	number
+# eventeq	number
+# eventgt	number
+# eventlt	number
+
+#
+# 2 threads 1 lock with priority inversion
+#
+C: resetevent:		0: 	0
+W: opcodeeq:		0: 	0
+
+# Set schedulers
+C: schedother:		0: 	0
+W: opcodeeq:		0: 	0
+C: schedfifo:		1: 	80
+W: opcodeeq:		1: 	0
+
+# T0 lock L0
+C: locknowait:		0: 	0
+W: locked:		0: 	0
+
+# T1 lock L0
+C: locknowait:		1: 	0
+W: blocked:		1: 	0
+T: prioeq:		0: 	80
+
+# T0 unlock L0
+C: unlock:		0: 	0
+W: locked:		1: 	0
+
+# Verify T1
+W: unlocked:		0: 	0
+T: priolt:		0: 	1
+
+# Unlock and exit
+C: unlock:		1: 	0
+W: unlocked:		1: 	0
+
Index: linux-pi-futex.mm.q/scripts/rt-tester/t2-l1-signal.tst
===================================================================
--- /dev/null
+++ linux-pi-futex.mm.q/scripts/rt-tester/t2-l1-signal.tst
@@ -0,0 +1,79 @@
+#
+# RT-Mutex test
+#
+# Op: C(ommand)/T(est)/W(ait)
+# |  opcode
+# |  |     threadid: 0-7
+# |  |     |  opcode argument
+# |  |     |  |
+# C: lock: 0: 0
+#
+# Commands
+#
+# opcode	opcode argument
+# schedother	nice value
+# schedfifo	priority
+# lock		lock nr (0-7)
+# locknowait	lock nr (0-7)
+# lockint	lock nr (0-7)
+# lockintnowait	lock nr (0-7)
+# lockcont	lock nr (0-7)
+# unlock	lock nr (0-7)
+# lockbkl	lock nr (0-7)
+# unlockbkl	lock nr (0-7)
+# signal	0
+# reset		0
+# resetevent	0
+#
+# Tests / Wait
+#
+# opcode	opcode argument
+#
+# prioeq	priority
+# priolt	priority
+# priogt	priority
+# nprioeq	normal priority
+# npriolt	normal priority
+# npriogt	normal priority
+# locked	lock nr (0-7)
+# blocked	lock nr (0-7)
+# blockedwake	lock nr (0-7)
+# unlocked	lock nr (0-7)
+# lockedbkl	dont care
+# blockedbkl	dont care
+# unlockedbkl	dont care
+# opcodeeq	command opcode or number
+# opcodelt	number
+# opcodegt	number
+# eventeq	number
+# eventgt	number
+# eventlt	number
+
+#
+# 2 threads 1 lock with priority inversion
+#
+C: resetevent:		0: 	0
+W: opcodeeq:		0: 	0
+
+# Set schedulers
+C: schedother:		0: 	0
+W: opcodeeq:		0: 	0
+C: schedother:		1: 	0
+W: opcodeeq:		1: 	0
+
+# T0 lock L0
+C: locknowait:		0: 	0
+W: locked:		0: 	0
+
+# T1 lock L0
+C: lockintnowait:	1: 	0
+W: blocked:		1: 	0
+
+# Interrupt T1
+C: signal:		1:	0
+W: unlocked:		1: 	0
+T: opcodeeq:		1:	-4
+
+# Unlock and exit
+C: unlock:		0: 	0
+W: unlocked:		0: 	0
Index: linux-pi-futex.mm.q/scripts/rt-tester/t2-l2-2rt-deadlock.tst
===================================================================
--- /dev/null
+++ linux-pi-futex.mm.q/scripts/rt-tester/t2-l2-2rt-deadlock.tst
@@ -0,0 +1,91 @@
+#
+# RT-Mutex test
+#
+# Op: C(ommand)/T(est)/W(ait)
+# |  opcode
+# |  |     threadid: 0-7
+# |  |     |  opcode argument
+# |  |     |  |
+# C: lock: 0: 0
+#
+# Commands
+#
+# opcode	opcode argument
+# schedother	nice value
+# schedfifo	priority
+# lock		lock nr (0-7)
+# locknowait	lock nr (0-7)
+# lockint	lock nr (0-7)
+# lockintnowait	lock nr (0-7)
+# lockcont	lock nr (0-7)
+# unlock	lock nr (0-7)
+# lockbkl	lock nr (0-7)
+# unlockbkl	lock nr (0-7)
+# signal	0
+# reset		0
+# resetevent	0
+#
+# Tests / Wait
+#
+# opcode	opcode argument
+#
+# prioeq	priority
+# priolt	priority
+# priogt	priority
+# nprioeq	normal priority
+# npriolt	normal priority
+# npriogt	normal priority
+# locked	lock nr (0-7)
+# blocked	lock nr (0-7)
+# blockedwake	lock nr (0-7)
+# unlocked	lock nr (0-7)
+# lockedbkl	dont care
+# blockedbkl	dont care
+# unlockedbkl	dont care
+# opcodeeq	command opcode or number
+# opcodelt	number
+# opcodegt	number
+# eventeq	number
+# eventgt	number
+# eventlt	number
+
+#
+# 2 threads 2 lock
+#
+C: resetevent:		0: 	0
+W: opcodeeq:		0: 	0
+
+# Set schedulers
+C: schedfifo:		0: 	80
+W: opcodeeq:		0: 	0
+C: schedfifo:		1: 	80
+W: opcodeeq:		1: 	0
+
+# T0 lock L0
+C: locknowait:		0: 	0
+W: locked:		0: 	0
+
+# T1 lock L1
+C: locknowait:		1:	1
+W: locked:		1: 	1
+
+# T0 lock L1
+C: lockintnowait:	0: 	1
+W: blocked:		0: 	1
+
+# T1 lock L0
+C: lockintnowait:	1: 	0
+W: blocked:		1: 	0
+
+# Make deadlock go away
+C: signal:		1:	0
+W: unlocked:		1:	0
+C: signal:		0:	0
+W: unlocked:		0:	1
+
+# Unlock and exit
+C: unlock:		0: 	0
+W: unlocked:		0: 	0
+C: unlock:		1: 	1
+W: unlocked:		1: 	1
+
Index: linux-pi-futex.mm.q/scripts/rt-tester/t3-l1-pi-1rt.tst
===================================================================
--- /dev/null
+++ linux-pi-futex.mm.q/scripts/rt-tester/t3-l1-pi-1rt.tst
@@ -0,0 +1,95 @@
+#
+# rt-mutex test
+#
+# Op: C(ommand)/T(est)/W(ait)
+# |  opcode
+# |  |     threadid: 0-7
+# |  |     |  opcode argument
+# |  |     |  |
+# C: lock: 0: 0
+#
+# Commands
+#
+# opcode	opcode argument
+# schedother	nice value
+# schedfifo	priority
+# lock		lock nr (0-7)
+# locknowait	lock nr (0-7)
+# lockint	lock nr (0-7)
+# lockintnowait	lock nr (0-7)
+# lockcont	lock nr (0-7)
+# unlock	lock nr (0-7)
+# lockbkl	lock nr (0-7)
+# unlockbkl	lock nr (0-7)
+# signal	thread to signal (0-7)
+# reset		0
+# resetevent	0
+#
+# Tests / Wait
+#
+# opcode	opcode argument
+#
+# prioeq	priority
+# priolt	priority
+# priogt	priority
+# nprioeq	normal priority
+# npriolt	normal priority
+# npriogt	normal priority
+# locked	lock nr (0-7)
+# blocked	lock nr (0-7)
+# blockedwake	lock nr (0-7)
+# unlocked	lock nr (0-7)
+# lockedbkl	dont care
+# blockedbkl	dont care
+# unlockedbkl	dont care
+# opcodeeq	command opcode or number
+# opcodelt	number
+# opcodegt	number
+# eventeq	number
+# eventgt	number
+# eventlt	number
+
+#
+# 3 threads 1 lock PI
+#
+C: resetevent:		0: 	0
+W: opcodeeq:		0: 	0
+
+# Set schedulers
+C: schedother:		0: 	0
+W: opcodeeq:		0: 	0
+C: schedother:		1: 	0
+W: opcodeeq:		1: 	0
+C: schedfifo:		2: 	82
+W: opcodeeq:		2: 	0
+
+# T0 lock L0
+C: locknowait:		0: 	0
+W: locked:		0: 	0
+
+# T1 lock L0
+C: locknowait:		1: 	0
+W: blocked:		1: 	0
+T: priolt:		0: 	1
+
+# T2 lock L0
+C: locknowait:		2: 	0
+W: blocked:		2: 	0
+T: prioeq:		0: 	82
+
+# T0 unlock L0
+C: unlock:		0: 	0
+
+# Wait until T2 got the lock
+W: locked:		2: 	0
+W: unlocked:		0:	0
+T: priolt:		0:	1
+
+# T2 unlock L0
+C: unlock:		2: 	0
+
+W: unlocked:		2: 	0
+W: locked:		1: 	0
+
+C: unlock:		1: 	0
+W: unlocked:		1: 	0
Index: linux-pi-futex.mm.q/scripts/rt-tester/t3-l1-pi-2rt.tst
===================================================================
--- /dev/null
+++ linux-pi-futex.mm.q/scripts/rt-tester/t3-l1-pi-2rt.tst
@@ -0,0 +1,96 @@
+#
+# rt-mutex test
+#
+# Op: C(ommand)/T(est)/W(ait)
+# |  opcode
+# |  |     threadid: 0-7
+# |  |     |  opcode argument
+# |  |     |  |
+# C: lock: 0: 0
+#
+# Commands
+#
+# opcode	opcode argument
+# schedother	nice value
+# schedfifo	priority
+# lock		lock nr (0-7)
+# locknowait	lock nr (0-7)
+# lockint	lock nr (0-7)
+# lockintnowait	lock nr (0-7)
+# lockcont	lock nr (0-7)
+# unlock	lock nr (0-7)
+# lockbkl	lock nr (0-7)
+# unlockbkl	lock nr (0-7)
+# signal	thread to signal (0-7)
+# reset		0
+# resetevent	0
+#
+# Tests / Wait
+#
+# opcode	opcode argument
+#
+# prioeq	priority
+# priolt	priority
+# priogt	priority
+# nprioeq	normal priority
+# npriolt	normal priority
+# npriogt	normal priority
+# locked	lock nr (0-7)
+# blocked	lock nr (0-7)
+# blockedwake	lock nr (0-7)
+# unlocked	lock nr (0-7)
+# lockedbkl	dont care
+# blockedbkl	dont care
+# unlockedbkl	dont care
+# opcodeeq	command opcode or number
+# opcodelt	number
+# opcodegt	number
+# eventeq	number
+# eventgt	number
+# eventlt	number
+
+#
+# 3 threads 1 lock PI
+#
+C: resetevent:		0: 	0
+W: opcodeeq:		0: 	0
+
+# Set schedulers
+C: schedother:		0: 	0
+W: opcodeeq:		0: 	0
+C: schedfifo:		1: 	81
+W: opcodeeq:		1: 	0
+C: schedfifo:		2: 	82
+W: opcodeeq:		2: 	0
+
+# T0 lock L0
+C: locknowait:		0: 	0
+W: locked:		0: 	0
+
+# T1 lock L0
+C: locknowait:		1: 	0
+W: blocked:		1: 	0
+T: prioeq:		0: 	81
+
+# T2 lock L0
+C: locknowait:		2: 	0
+W: blocked:		2: 	0
+T: prioeq:		0: 	82
+T: prioeq:		1:	81
+
+# T0 unlock L0
+C: unlock:		0: 	0
+
+# Wait until T2 got the lock
+W: locked:		2: 	0
+W: unlocked:		0:	0
+T: priolt:		0:	1
+
+# T2 unlock L0
+C: unlock:		2: 	0
+
+W: unlocked:		2: 	0
+W: locked:		1: 	0
+
+C: unlock:		1: 	0
+W: unlocked:		1: 	0
Index: linux-pi-futex.mm.q/scripts/rt-tester/t3-l1-pi-3rt.tst
===================================================================
--- /dev/null
+++ linux-pi-futex.mm.q/scripts/rt-tester/t3-l1-pi-3rt.tst
@@ -0,0 +1,95 @@
+#
+# rt-mutex test
+#
+# Op: C(ommand)/T(est)/W(ait)
+# |  opcode
+# |  |     threadid: 0-7
+# |  |     |  opcode argument
+# |  |     |  |
+# C: lock: 0: 0
+#
+# Commands
+#
+# opcode	opcode argument
+# schedother	nice value
+# schedfifo	priority
+# lock		lock nr (0-7)
+# locknowait	lock nr (0-7)
+# lockint	lock nr (0-7)
+# lockintnowait	lock nr (0-7)
+# lockcont	lock nr (0-7)
+# unlock	lock nr (0-7)
+# lockbkl	lock nr (0-7)
+# unlockbkl	lock nr (0-7)
+# signal	thread to signal (0-7)
+# reset		0
+# resetevent	0
+#
+# Tests / Wait
+#
+# opcode	opcode argument
+#
+# prioeq	priority
+# priolt	priority
+# priogt	priority
+# nprioeq	normal priority
+# npriolt	normal priority
+# npriogt	normal priority
+# locked	lock nr (0-7)
+# blocked	lock nr (0-7)
+# blockedwake	lock nr (0-7)
+# unlocked	lock nr (0-7)
+# lockedbkl	dont care
+# blockedbkl	dont care
+# unlockedbkl	dont care
+# opcodeeq	command opcode or number
+# opcodelt	number
+# opcodegt	number
+# eventeq	number
+# eventgt	number
+# eventlt	number
+
+#
+# 3 threads 1 lock PI
+#
+C: resetevent:		0: 	0
+W: opcodeeq:		0: 	0
+
+# Set schedulers
+C: schedfifo:		0: 	80
+W: opcodeeq:		0: 	0
+C: schedfifo:		1: 	81
+W: opcodeeq:		1: 	0
+C: schedfifo:		2: 	82
+W: opcodeeq:		2: 	0
+
+# T0 lock L0
+C: locknowait:		0: 	0
+W: locked:		0: 	0
+
+# T1 lock L0
+C: locknowait:		1: 	0
+W: blocked:		1: 	0
+T: prioeq:		0: 	81
+
+# T2 lock L0
+C: locknowait:		2: 	0
+W: blocked:		2: 	0
+T: prioeq:		0: 	82
+
+# T0 unlock L0
+C: unlock:		0: 	0
+
+# Wait until T2 got the lock
+W: locked:		2: 	0
+W: unlocked:		0:	0
+T: prioeq:		0:	80
+
+# T2 unlock L0
+C: unlock:		2: 	0
+
+W: locked:		1: 	0
+W: unlocked:		2: 	0
+
+C: unlock:		1: 	0
+W: unlocked:		1: 	0
Index: linux-pi-futex.mm.q/scripts/rt-tester/t3-l1-pi-signal.tst
===================================================================
--- /dev/null
+++ linux-pi-futex.mm.q/scripts/rt-tester/t3-l1-pi-signal.tst
@@ -0,0 +1,98 @@
+#
+# rt-mutex test
+#
+# Op: C(ommand)/T(est)/W(ait)
+# |  opcode
+# |  |     threadid: 0-7
+# |  |     |  opcode argument
+# |  |     |  |
+# C: lock: 0: 0
+#
+# Commands
+#
+# opcode	opcode argument
+# schedother	nice value
+# schedfifo	priority
+# lock		lock nr (0-7)
+# locknowait	lock nr (0-7)
+# lockint	lock nr (0-7)
+# lockintnowait	lock nr (0-7)
+# lockcont	lock nr (0-7)
+# unlock	lock nr (0-7)
+# lockbkl	lock nr (0-7)
+# unlockbkl	lock nr (0-7)
+# signal	thread to signal (0-7)
+# reset		0
+# resetevent	0
+#
+# Tests / Wait
+#
+# opcode	opcode argument
+#
+# prioeq	priority
+# priolt	priority
+# priogt	priority
+# nprioeq	normal priority
+# npriolt	normal priority
+# npriogt	normal priority
+# locked	lock nr (0-7)
+# blocked	lock nr (0-7)
+# blockedwake	lock nr (0-7)
+# unlocked	lock nr (0-7)
+# lockedbkl	dont care
+# blockedbkl	dont care
+# unlockedbkl	dont care
+# opcodeeq	command opcode or number
+# opcodelt	number
+# opcodegt	number
+# eventeq	number
+# eventgt	number
+# eventlt	number
+
+# Reset event counter
+C: resetevent:		0: 	0
+W: opcodeeq:		0: 	0
+
+# Set priorities
+C: schedother:		0: 	0
+W: opcodeeq:		0: 	0
+C: schedfifo:		1: 	80
+W: opcodeeq:		1: 	0
+C: schedfifo:		2: 	81
+W: opcodeeq:		2: 	0
+
+# T0 lock L0
+C: lock:		0:	0
+W: locked:		0: 	0
+
+# T1 lock L0, no wait in the wakeup path
+C: locknowait:		1: 	0
+W: blocked:		1: 	0
+T: prioeq:		0:	80
+
+# T2 lock L0 interruptible, no wait in the wakeup path
+C: lockintnowait:	2:	0
+W: blocked:		2: 	0
+T: prioeq:		0:	81
+
+# Interrupt T2
+C: signal:		2:	2
+W: unlocked:		2:	0
+T: prioeq:		0:	80
+
+T: locked:		0:	0
+T: blocked:		1:	0
+
+# T0 unlock L0
+C: unlock:		0: 	0
+
+# Wait until T1 has locked L0 and exit
+W: locked:		1:	0
+W: unlocked:		0: 	0
+T: priolt:		0:	1
+
+C: unlock:		1: 	0
+W: unlocked:		1: 	0
+
+
+
Index: linux-pi-futex.mm.q/scripts/rt-tester/t3-l1-pi-steal.tst
===================================================================
--- /dev/null
+++ linux-pi-futex.mm.q/scripts/rt-tester/t3-l1-pi-steal.tst
@@ -0,0 +1,99 @@
+#
+# rt-mutex test
+#
+# Op: C(ommand)/T(est)/W(ait)
+# |  opcode
+# |  |     threadid: 0-7
+# |  |     |  opcode argument
+# |  |     |  |
+# C: lock: 0: 0
+#
+# Commands
+#
+# opcode	opcode argument
+# schedother	nice value
+# schedfifo	priority
+# lock		lock nr (0-7)
+# locknowait	lock nr (0-7)
+# lockint	lock nr (0-7)
+# lockintnowait	lock nr (0-7)
+# lockcont	lock nr (0-7)
+# unlock	lock nr (0-7)
+# lockbkl	lock nr (0-7)
+# unlockbkl	lock nr (0-7)
+# signal	thread to signal (0-7)
+# reset		0
+# resetevent	0
+#
+# Tests / Wait
+#
+# opcode	opcode argument
+#
+# prioeq	priority
+# priolt	priority
+# priogt	priority
+# nprioeq	normal priority
+# npriolt	normal priority
+# npriogt	normal priority
+# locked	lock nr (0-7)
+# blocked	lock nr (0-7)
+# blockedwake	lock nr (0-7)
+# unlocked	lock nr (0-7)
+# lockedbkl	dont care
+# blockedbkl	dont care
+# unlockedbkl	dont care
+# opcodeeq	command opcode or number
+# opcodelt	number
+# opcodegt	number
+# eventeq	number
+# eventgt	number
+# eventlt	number
+
+#
+# 3 threads 1 lock PI steal pending ownership
+#
+C: resetevent:		0: 	0
+W: opcodeeq:		0: 	0
+
+# Set schedulers
+C: schedother:		0: 	0
+W: opcodeeq:		0: 	0
+C: schedfifo:		1: 	80
+W: opcodeeq:		1: 	0
+C: schedfifo:		2: 	81
+W: opcodeeq:		2: 	0
+
+# T0 lock L0
+C: lock:		0: 	0
+W: locked:		0: 	0
+
+# T1 lock L0
+C: lock:		1: 	0
+W: blocked:		1: 	0
+T: prioeq:		0: 	80
+
+# T0 unlock L0
+C: unlock:		0: 	0
+
+# Wait until T1 is in the wakeup loop
+W: blockedwake:		1: 	0
+T: priolt:		0: 	1
+
+# T2 lock L0
+C: lock:		2: 	0
+# T1 leave wakeup loop
+C: lockcont:		1: 	0
+
+# T2 must have the lock and T1 must be blocked
+W: locked:		2: 	0
+W: blocked:		1: 	0
+
+# T2 unlock L0
+C: unlock:		2: 	0
+
+# Wait until T1 is in the wakeup loop and let it run
+W: blockedwake:		1: 	0
+C: lockcont:		1: 	0
+W: locked:		1: 	0
+C: unlock:		1: 	0
+W: unlocked:		1: 	0
Index: linux-pi-futex.mm.q/scripts/rt-tester/t3-l2-pi.tst
===================================================================
--- /dev/null
+++ linux-pi-futex.mm.q/scripts/rt-tester/t3-l2-pi.tst
@@ -0,0 +1,95 @@
+#
+# rt-mutex test
+#
+# Op: C(ommand)/T(est)/W(ait)
+# |  opcode
+# |  |     threadid: 0-7
+# |  |     |  opcode argument
+# |  |     |  |
+# C: lock: 0: 0
+#
+# Commands
+#
+# opcode	opcode argument
+# schedother	nice value
+# schedfifo	priority
+# lock		lock nr (0-7)
+# locknowait	lock nr (0-7)
+# lockint	lock nr (0-7)
+# lockintnowait	lock nr (0-7)
+# lockcont	lock nr (0-7)
+# unlock	lock nr (0-7)
+# lockbkl	lock nr (0-7)
+# unlockbkl	lock nr (0-7)
+# signal	thread to signal (0-7)
+# reset		0
+# resetevent	0
+#
+# Tests / Wait
+#
+# opcode	opcode argument
+#
+# prioeq	priority
+# priolt	priority
+# priogt	priority
+# nprioeq	normal priority
+# npriolt	normal priority
+# npriogt	normal priority
+# locked	lock nr (0-7)
+# blocked	lock nr (0-7)
+# blockedwake	lock nr (0-7)
+# unlocked	lock nr (0-7)
+# lockedbkl	dont care
+# blockedbkl	dont care
+# unlockedbkl	dont care
+# opcodeeq	command opcode or number
+# opcodelt	number
+# opcodegt	number
+# eventeq	number
+# eventgt	number
+# eventlt	number
+
+#
+# 3 threads 2 lock PI
+#
+C: resetevent:		0: 	0
+W: opcodeeq:		0: 	0
+
+# Set schedulers
+C: schedother:		0: 	0
+W: opcodeeq:		0: 	0
+C: schedother:		1: 	0
+W: opcodeeq:		1: 	0
+C: schedfifo:		2: 	82
+W: opcodeeq:		2: 	0
+
+# T0 lock L0
+C: locknowait:		0: 	0
+W: locked:		0: 	0
+
+# T1 lock L0
+C: locknowait:		1: 	0
+W: blocked:		1: 	0
+T: priolt:		0: 	1
+
+# T2 lock L0
+C: locknowait:		2: 	0
+W: blocked:		2: 	0
+T: prioeq:		0: 	82
+
+# T0 unlock L0
+C: unlock:		0: 	0
+
+# Wait until T2 got the lock
+W: locked:		2: 	0
+W: unlocked:		0:	0
+T: priolt:		0:	1
+
+# T2 unlock L0
+C: unlock:		2: 	0
+
+W: unlocked:		2: 	0
+W: locked:		1: 	0
+
+C: unlock:		1: 	0
+W: unlocked:		1: 	0
Index: linux-pi-futex.mm.q/scripts/rt-tester/t4-l2-pi-deboost.tst
===================================================================
--- /dev/null
+++ linux-pi-futex.mm.q/scripts/rt-tester/t4-l2-pi-deboost.tst
@@ -0,0 +1,127 @@
+#
+# rt-mutex test
+#
+# Op: C(ommand)/T(est)/W(ait)
+# |  opcode
+# |  |     threadid: 0-7
+# |  |     |  opcode argument
+# |  |     |  |
+# C: lock: 0: 0
+#
+# Commands
+#
+# opcode	opcode argument
+# schedother	nice value
+# schedfifo	priority
+# lock		lock nr (0-7)
+# locknowait	lock nr (0-7)
+# lockint	lock nr (0-7)
+# lockintnowait	lock nr (0-7)
+# lockcont	lock nr (0-7)
+# unlock	lock nr (0-7)
+# lockbkl	lock nr (0-7)
+# unlockbkl	lock nr (0-7)
+# signal	thread to signal (0-7)
+# reset		0
+# resetevent	0
+#
+# Tests / Wait
+#
+# opcode	opcode argument
+#
+# prioeq	priority
+# priolt	priority
+# priogt	priority
+# nprioeq	normal priority
+# npriolt	normal priority
+# npriogt	normal priority
+# locked	lock nr (0-7)
+# blocked	lock nr (0-7)
+# blockedwake	lock nr (0-7)
+# unlocked	lock nr (0-7)
+# lockedbkl	dont care
+# blockedbkl	dont care
+# unlockedbkl	dont care
+# opcodeeq	command opcode or number
+# opcodelt	number
+# opcodegt	number
+# eventeq	number
+# eventgt	number
+# eventlt	number
+
+#
+# 4 threads 2 lock PI
+#
+C: resetevent:		0: 	0
+W: opcodeeq:		0: 	0
+
+# Set schedulers
+C: schedother:		0: 	0
+W: opcodeeq:		0: 	0
+C: schedother:		1: 	0
+W: opcodeeq:		1: 	0
+C: schedfifo:		2: 	82
+W: opcodeeq:		2: 	0
+C: schedfifo:		3: 	83
+W: opcodeeq:		3: 	0
+
+# T0 lock L0
+C: locknowait:		0: 	0
+W: locked:		0: 	0
+
+# T1 lock L1
+C: locknowait:		1: 	1
+W: locked:		1: 	1
+
+# T3 lock L0
+C: lockintnowait:	3: 	0
+W: blocked:		3: 	0
+T: prioeq:		0: 	83
+
+# T0 lock L1
+C: lock:		0: 	1
+W: blocked:		0: 	1
+T: prioeq:		1: 	83
+
+# T1 unlock L1
+C: unlock:		1:	1
+
+# Wait until T0 is in the wakeup code
+W: blockedwake:		0:	1
+
+# Verify that T1 is unboosted
+W: unlocked:		1: 	1
+T: priolt:		1: 	1
+
+# T2 lock L1 (T0 is boosted and pending owner !)
+C: locknowait:		2:	1
+W: blocked:		2: 	1
+T: prioeq:		0: 	83
+
+# Interrupt T3 and wait until T3 returned
+C: signal:		3:	0
+W: unlocked:		3:	0
+
+# Verify prio of T0 (still pending owner,
+# but T2 is enqueued due to the previous boost by T3
+T: prioeq:		0:	82
+
+# Let T0 continue
+C: lockcont:		0:	1
+W: locked:		0:	1
+
+# Unlock L1 and let T2 get L1
+C: unlock:		0:	1
+W: locked:		2:	1
+
+# Verify that T0 is unboosted
+W: unlocked:		0:	1
+T: priolt:		0:	1
+
+# Unlock everything and exit
+C: unlock:		2:	1
+W: unlocked:		2:	1
+
+C: unlock:		0:	0
+W: unlocked:		0:	0
+
Index: linux-pi-futex.mm.q/scripts/rt-tester/t5-l4-pi-boost-deboost.tst
===================================================================
--- /dev/null
+++ linux-pi-futex.mm.q/scripts/rt-tester/t5-l4-pi-boost-deboost.tst
@@ -0,0 +1,148 @@
+#
+# rt-mutex test
+#
+# Op: C(ommand)/T(est)/W(ait)
+# |  opcode
+# |  |     threadid: 0-7
+# |  |     |  opcode argument
+# |  |     |  |
+# C: lock: 0: 0
+#
+# Commands
+#
+# opcode	opcode argument
+# schedother	nice value
+# schedfifo	priority
+# lock		lock nr (0-7)
+# locknowait	lock nr (0-7)
+# lockint	lock nr (0-7)
+# lockintnowait	lock nr (0-7)
+# lockcont	lock nr (0-7)
+# unlock	lock nr (0-7)
+# lockbkl	lock nr (0-7)
+# unlockbkl	lock nr (0-7)
+# signal	thread to signal (0-7)
+# reset		0
+# resetevent	0
+#
+# Tests / Wait
+#
+# opcode	opcode argument
+#
+# prioeq	priority
+# priolt	priority
+# priogt	priority
+# nprioeq	normal priority
+# npriolt	normal priority
+# npriogt	normal priority
+# locked	lock nr (0-7)
+# blocked	lock nr (0-7)
+# blockedwake	lock nr (0-7)
+# unlocked	lock nr (0-7)
+# lockedbkl	dont care
+# blockedbkl	dont care
+# unlockedbkl	dont care
+# opcodeeq	command opcode or number
+# opcodelt	number
+# opcodegt	number
+# eventeq	number
+# eventgt	number
+# eventlt	number
+
+#
+# 5 threads 4 lock PI
+#
+C: resetevent:		0: 	0
+W: opcodeeq:		0: 	0
+
+# Set schedulers
+C: schedother:		0: 	0
+W: opcodeeq:		0: 	0
+C: schedfifo:		1: 	81
+W: opcodeeq:		1: 	0
+C: schedfifo:		2: 	82
+W: opcodeeq:		2: 	0
+C: schedfifo:		3: 	83
+W: opcodeeq:		3: 	0
+C: schedfifo:		4: 	84
+W: opcodeeq:		4: 	0
+
+# T0 lock L0
+C: locknowait:		0: 	0
+W: locked:		0: 	0
+
+# T1 lock L1
+C: locknowait:		1: 	1
+W: locked:		1: 	1
+
+# T1 lock L0
+C: lockintnowait:	1: 	0
+W: blocked:		1: 	0
+T: prioeq:		0: 	81
+
+# T2 lock L2
+C: locknowait:		2: 	2
+W: locked:		2: 	2
+
+# T2 lock L1
+C: lockintnowait:	2: 	1
+W: blocked:		2: 	1
+T: prioeq:		0: 	82
+T: prioeq:		1:	82
+
+# T3 lock L3
+C: locknowait:		3: 	3
+W: locked:		3: 	3
+
+# T3 lock L2
+C: lockintnowait:	3: 	2
+W: blocked:		3: 	2
+T: prioeq:		0: 	83
+T: prioeq:		1:	83
+T: prioeq:		2:	83
+
+# T4 lock L3
+C: lockintnowait:	4:	3
+W: blocked:		4: 	3
+T: prioeq:		0: 	84
+T: prioeq:		1:	84
+T: prioeq:		2:	84
+T: prioeq:		3:	84
+
+# Signal T4
+C: signal:		4: 	0
+W: unlocked:		4: 	3
+T: prioeq:		0: 	83
+T: prioeq:		1:	83
+T: prioeq:		2:	83
+T: prioeq:		3:	83
+
+# Signal T3
+C: signal:		3: 	0
+W: unlocked:		3: 	2
+T: prioeq:		0: 	82
+T: prioeq:		1:	82
+T: prioeq:		2:	82
+
+# Signal T2
+C: signal:		2: 	0
+W: unlocked:		2: 	1
+T: prioeq:		0: 	81
+T: prioeq:		1:	81
+
+# Signal T1
+C: signal:		1: 	0
+W: unlocked:		1: 	0
+T: priolt:		0: 	1
+
+# Unlock and exit
+C: unlock:		3:	3
+C: unlock:		2:	2
+C: unlock:		1:	1
+C: unlock:		0:	0
+
+W: unlocked:		3:	3
+W: unlocked:		2:	2
+W: unlocked:		1:	1
+W: unlocked:		0:	0
+
