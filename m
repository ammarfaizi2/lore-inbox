Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265164AbSIRCOr>; Tue, 17 Sep 2002 22:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265163AbSIRCNy>; Tue, 17 Sep 2002 22:13:54 -0400
Received: from dp.samba.org ([66.70.73.150]:61357 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265161AbSIRCMO>;
	Tue, 17 Sep 2002 22:12:14 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
Cc: mingo@elte.hu
Subject: [PATCH] In-kernel module loader 1/7
Date: Wed, 18 Sep 2002 12:05:18 +1000
Message-Id: <20020918021714.E43A92C132@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Sorry Ingo, an hour late.  Look hard at 1/7, sched.c BTW ]

Hi all,

	I've rewritten my in-kernel module loader: this version breaks
much less existing code.  Basically, we go to a model of
externally-controlled module refcounts with possibility of failure
(ie. try_inc_mod_count, now called try_module_get()).

There are some rough edges, but it Works for Me(TM).  Read the
descriptions for caveats.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Later primitive
Author: Rusty Russell
Section: Misc
Status: Tested on 2.5.35

D: This patch implements the wait_for_later() call needed for safe
D: module unload and hotplug CPU.  It is a minimal subset of RCU which
D: works with a preemptible kernel.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22006-linux-2.5.35/include/linux/later.h .22006-linux-2.5.35.updated/include/linux/later.h
--- .22006-linux-2.5.35/include/linux/later.h	1970-01-01 10:00:00.000000000 +1000
+++ .22006-linux-2.5.35.updated/include/linux/later.h	2002-09-17 14:00:58.000000000 +1000
@@ -0,0 +1,60 @@
+#ifndef __LINUX_LATER_H
+#define __LINUX_LATER_H
+/* Do something after system has calmed down.
+   (c) 2002 Rusty Russell, IBM Corporation.
+*/
+#include <linux/config.h>
+#include <linux/sched.h>
+#include <linux/compiler.h>
+#include <asm/atomic.h>
+
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
+struct later
+{
+	struct later *next;
+	void (*func)(void *data);
+	void *data;
+};
+
+extern void noone_running(void);
+extern atomic_t runcounts[2];
+extern int which_runcount;
+
+/* We flip between two run counters. */
+static inline atomic_t *runcount(struct task_struct *task)
+{
+	return &runcounts[!(task->flags & PF_RUNCOUNT)];
+}
+
+/* Decrement counter on entering voluntary schedule. */
+static inline void put_runcount(void)
+{
+	/* If we hit zero and it's the not the active list... */
+	if (atomic_dec_and_test(runcount(current))
+	    && (current->flags & PF_RUNCOUNT) != which_runcount)
+			noone_running();
+}
+
+/* Increment counter in leaving voluntary schedule. */
+static inline void get_runcount(struct task_struct *task)
+{
+	/* Sets PF_RUNCOUNT, or not */
+	task->flags = ((task->flags & ~PF_RUNCOUNT) | which_runcount);
+	atomic_inc(runcount(task));
+}
+
+/* Queues future request: may sleep on UP if func sleeps... */
+void do_later(struct later *head, void (*func)(void *data), void *data);
+
+/* Wait until it's later. */
+void wait_for_later(void);
+
+#else /* !SMP, !PREEMPT */
+struct later { };
+#define do_later(head, func, data) (func(data))
+static inline void put_runcount(void) { }
+static inline void get_runcount(void) { }
+
+extern inline void wait_for_later(void) { }
+#endif
+#endif /* __LINUX_LATER_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22006-linux-2.5.35/include/linux/sched.h .22006-linux-2.5.35.updated/include/linux/sched.h
--- .22006-linux-2.5.35/include/linux/sched.h	2002-09-16 12:43:48.000000000 +1000
+++ .22006-linux-2.5.35.updated/include/linux/sched.h	2002-09-17 14:02:56.000000000 +1000
@@ -424,6 +424,7 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define PF_IOTHREAD	0x00020000	/* this thread is needed for doing I/O to swap */
 #define PF_FROZEN	0x00040000	/* frozen for system suspend */
 #define PF_SYNC		0x00080000	/* performing fsync(), etc */
+#define PF_RUNCOUNT	0x00100000	/* which run counter to use */
 
 /*
  * Ptrace flags
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22006-linux-2.5.35/kernel/Makefile .22006-linux-2.5.35.updated/kernel/Makefile
--- .22006-linux-2.5.35/kernel/Makefile	2002-08-11 15:31:43.000000000 +1000
+++ .22006-linux-2.5.35.updated/kernel/Makefile	2002-09-17 14:00:58.000000000 +1000
@@ -24,6 +24,11 @@ obj-$(CONFIG_MODULES) += ksyms.o
 obj-$(CONFIG_PM) += pm.o
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_SOFTWARE_SUSPEND) += suspend.o
+ifeq ($(CONFIG_PREEMPT),y)
+obj-y += later.o
+else
+obj-$(CONFIG_SMP) += later.o
+endif
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22006-linux-2.5.35/kernel/fork.c .22006-linux-2.5.35.updated/kernel/fork.c
--- .22006-linux-2.5.35/kernel/fork.c	2002-09-16 12:43:49.000000000 +1000
+++ .22006-linux-2.5.35.updated/kernel/fork.c	2002-09-17 14:03:06.000000000 +1000
@@ -28,6 +28,7 @@
 #include <linux/security.h>
 #include <linux/futex.h>
 #include <linux/ptrace.h>
+#include <linux/later.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -816,6 +817,7 @@ static struct task_struct *copy_process(
 	else
 		p->exit_signal = clone_flags & CSIGNAL;
 	p->pdeath_signal = 0;
+	get_runcount(p);
 
 	/*
 	 * Share the timeslice between parent and child, thus the
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22006-linux-2.5.35/kernel/later.c .22006-linux-2.5.35.updated/kernel/later.c
--- .22006-linux-2.5.35/kernel/later.c	1970-01-01 10:00:00.000000000 +1000
+++ .22006-linux-2.5.35.updated/kernel/later.c	2002-09-17 14:00:58.000000000 +1000
@@ -0,0 +1,148 @@
+/* Do something after system has calmed down.
+
+   Copyright (C) 2002 Rusty Russell, IBM Corporation
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+*/
+#include <linux/later.h>
+#include <linux/spinlock.h>
+#include <linux/completion.h>
+
+static spinlock_t later_lock = SPIN_LOCK_UNLOCKED;
+
+/* We track how many tasks are running or preempted.  At opportune
+   times, we switch all new counting over to the alternate counter,
+   and when the old counter hits zero, we know that everyone has
+   voluntarily preempted. */
+
+/* One for the boot cpu idle thread. */
+atomic_t runcounts[2] = { ATOMIC_INIT(0), ATOMIC_INIT(1) };
+int which_runcount; /* = 0, means runcount[1] active. */
+
+/* The two lists of tasks. */
+static struct later *later_list[2]; /* = { NULL, NULL } */
+
+static inline int active_count(void)
+{
+	if (which_runcount == PF_RUNCOUNT)
+		return 0;
+	else
+		return 1;
+};
+
+/* We're done: process batch. */
+void noone_running(void)
+{
+	struct later *list;
+
+	/* Remove inactive list for processing. */
+	spin_lock_irq(&later_lock);
+	list = later_list[!active_count()];
+	later_list[!active_count()] = NULL;
+	spin_unlock_irq(&later_lock);
+
+	/* Callback usually frees the entry, so be careful */
+	while (list) {
+		struct later *next = list->next;
+		list->func(list->data);
+		list = next;
+	}
+}
+
+/* Queues future request: if nothing happening, switch queues. */
+void do_later(struct later *head, void (*func)(void *data), void *data)
+{
+	unsigned long flags;
+
+	head->func = func;
+	head->data = data;
+
+	spin_lock_irqsave(&later_lock, flags);
+	/* Add to list */
+	head->next = later_list[active_count()];
+	later_list[active_count()] = head;
+
+	/* If other list is empty, switch them. */
+	if (later_list[!active_count()] == NULL) {
+		/* Beware: which_runcount being read without lock by sched.c */
+		wmb();
+		which_runcount ^= PF_RUNCOUNT;
+	}
+	spin_unlock_irqrestore(&later_lock, flags);
+}
+
+/* Because of FASTCALL declaration of complete, we use this wrapper */
+static void wakeme(void *completion)
+{
+	complete(completion);
+}
+
+/* Wait until it's later. */
+void wait_for_later(void)
+{
+	DECLARE_COMPLETION(completion);
+	struct later later;
+
+	/* Queue it and wait... */
+	do_later(&later, wakeme, &completion);
+	wait_for_completion(&completion);
+}
+
+#if 0
+#include <linux/proc_fs.h>
+
+static int write_wait(struct file *file, const char *buffer,
+		 unsigned long count, void *data)
+{
+	wait_for_later();
+	return count;
+}
+
+static int read_wait(char *page, char **start, off_t off,
+		     int count, int *eof, void *data)
+{
+	char *p = page;
+	int len;
+
+	spin_lock_irq(&later_lock);
+	p += sprintf(p, "ACTIVE: %u (%p)\nOTHER: %u (%p)\n",
+		     atomic_read(&runcounts[active_count()]),
+		     later_list[active_count()],
+		     atomic_read(&runcounts[!active_count()]),
+		     later_list[!active_count()]);
+	spin_unlock_irq(&later_lock);
+
+	len = (p - page) - off;
+	if (len < 0)
+		len = 0;
+
+	*eof = (len <= count) ? 1 : 0;
+	*start = page + off;
+
+	return len;
+}
+
+static int __init create_wait_proc(void)
+{
+	struct proc_dir_entry *e;
+
+	e = create_proc_entry("wait_for_later", 0644, NULL);
+	e->write_proc = &write_wait;
+	e->read_proc = &read_wait;
+	return 0;
+}
+
+__initcall(create_wait_proc);
+#endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22006-linux-2.5.35/kernel/sched.c .22006-linux-2.5.35.updated/kernel/sched.c
--- .22006-linux-2.5.35/kernel/sched.c	2002-09-16 12:43:49.000000000 +1000
+++ .22006-linux-2.5.35.updated/kernel/sched.c	2002-09-17 14:02:16.000000000 +1000
@@ -29,6 +29,7 @@
 #include <linux/security.h>
 #include <linux/notifier.h>
 #include <linux/delay.h>
+#include <linux/later.h>
 
 /*
  * Convert user-nice values [ -20 ... 0 ... 19 ]
@@ -938,7 +939,7 @@ asmlinkage void schedule(void)
 	runqueue_t *rq;
 	prio_array_t *array;
 	struct list_head *queue;
-	int idx;
+	int idx, preempt;
 
 	if (unlikely(in_atomic()))
 		BUG();
@@ -946,6 +947,9 @@ asmlinkage void schedule(void)
 #if CONFIG_DEBUG_HIGHMEM
 	check_highmem_ptes();
 #endif
+	preempt = (preempt_count() & PREEMPT_ACTIVE);
+	if (!preempt)
+		put_runcount();
 need_resched:
 	preempt_disable();
 	prev = current;
@@ -959,7 +963,7 @@ need_resched:
 	 * if entering off of a kernel preemption go straight
 	 * to picking the next task.
 	 */
-	if (unlikely(preempt_count() & PREEMPT_ACTIVE))
+	if (unlikely(preempt))
 		goto pick_next_task;
 
 	switch (prev->state) {
@@ -1020,6 +1024,9 @@ switch_tasks:
 	preempt_enable_no_resched();
 	if (test_thread_flag(TIF_NEED_RESCHED))
 		goto need_resched;
+
+	if (!preempt)
+		get_runcount(current);
 }
 
 #ifdef CONFIG_PREEMPT
