Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266095AbUAFIKH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 03:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266097AbUAFIKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 03:10:06 -0500
Received: from dp.samba.org ([66.70.73.150]:36269 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266095AbUAFIJl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 03:09:41 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: akpm@osdl.org, Davide Libenzi <davidel@xmailserver.org>
Cc: mingo@redhat.com, jgarzik@pobox.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] Second Coming of Kthread
Date: Tue, 06 Jan 2004 19:04:30 +1100
Message-Id: <20040106080939.828062C04B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My previous approach, with initfn and corefn, was too complex.  Having
reimplemented it using signals, and debated a length with Davide, I
present this completely rewritten, much simpler version.

The user now uses it exactly like kernel_thread(), and exits when
signalled.  This requires the previous workqueue SIGCHLD fix.

Feedback welcome!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Simplified Kthread
Author: Rusty Russell
Status: Tested on 2.6.1-rc1-bk6
Depends: Hotcpu-New-Kthread/workqueue_children.patch.gz

D: The hotplug CPU code introduces two major problems:
D: 
D: 1) Threads which previously never stopped (migration thread,
D:    ksoftirqd, keventd) have to be stopped cleanly as CPUs go offline.
D: 2) Threads which previously never had to be created now have
D:    to be created when a CPU goes online.
D: 
D: Unfortunately, stopping a thread is fairly baroque, involving memory
D: barriers, a completion and spinning until the task is actually dead
D: (for example, complete_and_exit() must be used if inside a module).
D: 
D: There are also three problems in starting a thread:
D: 1) Doing it from a random process context risks environment contamination:
D:    better to do it from keventd to guarantee a clean environment, a-la
D:    call_usermodehelper.
D: 2) Getting the task struct without races is a hard: see kernel/sched.c
D:    migration_call(), kernel/workqueue.c create_workqueue_thread().
D: 3) There are races in starting a thread for a CPU which is not yet
D:    online: migration thread does a complex dance at the moment for
D:    a similar reason (there may be no migration thread to migrate us).
D: 
D: Place all this logic in some primitives to make life easier:
D: kthread_create(), kthread_start() and kthread_stop().  These
D: primitives require no extra data-structures in the caller: they operate
D: on normal "struct task_struct"s.
D: 
D: Other changes:
D:   - Expose keventd_up(), as keventd and migration threads will use
D:     kthread to launch, and kthread normally uses workqueues and must
D:     recognize this case.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12121-linux-2.6.1-rc1-bk6/include/linux/kthread.h .12121-linux-2.6.1-rc1-bk6.updated/include/linux/kthread.h
--- .12121-linux-2.6.1-rc1-bk6/include/linux/kthread.h	1970-01-01 10:00:00.000000000 +1000
+++ .12121-linux-2.6.1-rc1-bk6.updated/include/linux/kthread.h	2004-01-06 16:05:54.000000000 +1100
@@ -0,0 +1,67 @@
+#ifndef _LINUX_KTHREAD_H
+#define _LINUX_KTHREAD_H
+/* Simple interface for creating and stopping kernel threads without mess. */
+#include <linux/err.h>
+struct task_struct;
+
+/**
+ * kthread_create: create a kthread.
+ * @threadfn: the function to run until signal_pending(current).
+ * @data: data ptr for @threadfn.
+ * @namefmt: printf-style name for the thread.
+ *
+ * Description: This helper function creates and names a kernel
+ * thread.  The thread will be stopped: use kthread_start() to start
+ * it.  See also kthread_run().
+ * 
+ * Returns a task_struct or ERR_PTR(-ENOMEM).
+ */
+struct task_struct *kthread_create(int (*threadfn)(void *data),
+				   void *data,
+				   const char namefmt[], ...);
+
+/**
+ * kthread_start: start a thread created by kthread_create().
+ * @k: the task returned by kthread_create().
+ *
+ * Description: This makes the thread @k run the threadfn() specified
+ * in kthread_create().  The threadfn() can either call do_exit()
+ * directly if it is a standalone thread for which noone will call
+ * kthread_stop(), or return when 'signal_pending(current)' is true
+ * (which means kthread_stop() has been called).  The return value
+ * should be zero or a negative error number: it will be passed to
+ * kthread_stop().
+ */
+void kthread_start(struct task_struct *k);
+
+/**
+ * kthread_run: create and start a thread.
+ * @threadfn: the function to run until signal_pending(current).
+ * @data: data ptr for @threadfn.
+ * @namefmt: printf-style name for the thread.
+ *
+ * Description: Convenient wrapper for kthread_create() followed by
+ * kthread_start().  Returns the kthread, or ERR_PTR(-ENOMEM). */
+#define kthread_run(threadfn, data, namefmt, ...)			   \
+({									   \
+	struct task_struct *__k						   \
+		= kthread_create(threadfn, data, namefmt, ## __VA_ARGS__); \
+	if (!IS_ERR(__k))						   \
+		kthread_start(__k);					   \
+	__k;								   \
+})
+
+/**
+ * kthread_stop: stop a thread created by kthread_create().
+ * @k: thread created by kthread_create.
+ *
+ * Sends a signal to @k, and waits for it to exit.  Your threadfn()
+ * must not call do_exit() itself if you use this function!  This can
+ * also be called after kthread_create() instead of calling
+ * kthread_start(): the thread will exit without calling threadfn.
+ *
+ * Returns the result of threadfn(), or -EINTR if kthread_start() was never
+ * called. */
+int kthread_stop(struct task_struct *k);
+
+#endif /* _LINUX_KTHREAD_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12121-linux-2.6.1-rc1-bk6/include/linux/workqueue.h .12121-linux-2.6.1-rc1-bk6.updated/include/linux/workqueue.h
--- .12121-linux-2.6.1-rc1-bk6/include/linux/workqueue.h	2003-09-22 10:07:08.000000000 +1000
+++ .12121-linux-2.6.1-rc1-bk6.updated/include/linux/workqueue.h	2004-01-06 16:05:54.000000000 +1100
@@ -60,6 +60,7 @@ extern int FASTCALL(schedule_work(struct
 extern int FASTCALL(schedule_delayed_work(struct work_struct *work, unsigned long delay));
 extern void flush_scheduled_work(void);
 extern int current_is_keventd(void);
+extern int keventd_up(void);
 
 extern void init_workqueues(void);
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12121-linux-2.6.1-rc1-bk6/kernel/Makefile .12121-linux-2.6.1-rc1-bk6.updated/kernel/Makefile
--- .12121-linux-2.6.1-rc1-bk6/kernel/Makefile	2003-10-09 18:03:02.000000000 +1000
+++ .12121-linux-2.6.1-rc1-bk6.updated/kernel/Makefile	2004-01-06 16:05:54.000000000 +1100
@@ -6,7 +6,8 @@ obj-y     = sched.o fork.o exec_domain.o
 	    exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
-	    rcupdate.o intermodule.o extable.o params.o posix-timers.o
+	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
+	    kthread.o
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12121-linux-2.6.1-rc1-bk6/kernel/kthread.c .12121-linux-2.6.1-rc1-bk6.updated/kernel/kthread.c
--- .12121-linux-2.6.1-rc1-bk6/kernel/kthread.c	1970-01-01 10:00:00.000000000 +1000
+++ .12121-linux-2.6.1-rc1-bk6.updated/kernel/kthread.c	2004-01-06 16:05:54.000000000 +1100
@@ -0,0 +1,171 @@
+/* Kernel thread helper functions.
+ *   Copyright (C) 2004 IBM Corporation, Rusty Russell.
+ *
+ * Everything is done via keventd, so that we get a clean environment
+ * even if we're invoked from userspace (think modprobe, hotplug cpu,
+ * etc.).  Also, it allows us to wait for dying kthreads without side
+ * effects involved in adopting kthreads to random processes.
+ */
+#define __KERNEL_SYSCALLS__
+#include <linux/sched.h>
+#include <linux/kthread.h>
+#include <linux/completion.h>
+#include <linux/err.h>
+#include <linux/unistd.h>
+#include <asm/semaphore.h>
+
+struct kthread_create_info
+{
+	/* Information passed to kthread() from keventd. */
+	int (*threadfn)(void *data);
+	void *data;
+	char *name;
+	struct completion started;
+
+	/* Result passed back to kthread_create() from keventd. */
+	struct task_struct *result;
+	struct completion done;
+};
+
+/* Returns so that WEXITSTATUS(ret) == errno. */
+static int kthread(void *_create)
+{
+	struct kthread_create_info *create = _create;
+	int (*threadfn)(void *data);
+	void *data;
+	int ret = -EINTR;
+
+	strcpy(current->comm, create->name);
+
+	/* Copy data: it's on keventd's stack */
+	threadfn = create->threadfn;
+	data = create->data;
+
+	/* OK, tell user we're spawned, wait for kthread_start/stop */
+	current->state = TASK_INTERRUPTIBLE;
+	complete(&create->started);
+	schedule();
+
+	while (!signal_pending(current))
+		ret = threadfn(data);
+
+	return (-ret) << 8;
+}
+
+/* We are keventd: create a thread. */
+static void keventd_create_kthread(void *_create)
+{
+	struct kthread_create_info *create = _create;
+	int pid;
+
+	/* We want our own signal handler (we take no signals by default). */
+	pid = kernel_thread(kthread, create, CLONE_FS | CLONE_FILES | SIGCHLD);
+	if (pid < 0) {
+		create->result = ERR_PTR(pid);
+	} else {
+		wait_for_completion(&create->started);
+		create->result = find_task_by_pid(pid);
+	}
+	complete(&create->done);
+}
+
+struct kthread_stop_info
+{
+	struct task_struct *k;
+	int result;
+	struct completion done;
+};
+
+/* "to look upon me as her own dad -- in a very real, and legally
+   binding sense." - Michael Palin */
+static void adopt_kthread(struct task_struct *k)
+{
+	write_lock_irq(&tasklist_lock);
+	REMOVE_LINKS(k);
+	k->parent = current;
+	k->real_parent = current;
+	SET_LINKS(k);
+	write_unlock_irq(&tasklist_lock);
+}
+
+/* We are keventd: stop the thread. */
+static void keventd_stop_kthread(void *_stop)
+{
+	struct kthread_stop_info *stop = _stop;
+	int status;
+	sigset_t blocked;
+	struct k_sigaction sa;
+
+	/* Install a handler so SIGCHLD is actually delivered */
+	sa.sa.sa_handler = SIG_DFL;
+	sa.sa.sa_flags = 0;
+	siginitset(&sa.sa.sa_mask, sigmask(SIGCHLD));
+	do_sigaction(SIGCHLD, &sa, (struct k_sigaction *)0);
+	allow_signal(SIGCHLD);
+
+	adopt_kthread(stop->k);
+	/* All signals are blocked, hence the force. */
+	force_sig(SIGTERM, stop->k);
+	waitpid(stop->k->tgid, &status, __WALL);
+	stop->result = -((status >> 8) & 0xFF);
+	complete(&stop->done);
+
+	/* Back to normal: block and flush all signals */
+	sigfillset(&blocked);
+	sigprocmask(SIG_BLOCK, &blocked, NULL);
+	flush_signals(current);
+	sa.sa.sa_handler = SIG_IGN;
+	do_sigaction(SIGCHLD, &sa, (struct k_sigaction *)0);
+	while (waitpid(-1, &status, __WALL|WNOHANG) > 0);
+}
+
+struct task_struct *kthread_create(int (*threadfn)(void *data),
+				   void *data,
+				   const char namefmt[],
+				   ...)
+{
+	va_list args;
+	struct kthread_create_info create;
+	DECLARE_WORK(work, keventd_create_kthread, &create);
+	/* Or, as we like to say, 16. */
+	char name[sizeof(((struct task_struct *)0)->comm)];
+
+	va_start(args, namefmt);
+	vsnprintf(name, sizeof(name), namefmt, args);
+	va_end(args);
+
+	create.threadfn = threadfn;
+	create.data = data;
+	create.name = name;
+	init_completion(&create.started);
+	init_completion(&create.done);
+
+	/* If we're being called to start the first workqueue, we
+	 * can't use keventd. */
+	if (!keventd_up())
+		work.func(work.data);
+	else {
+		schedule_work(&work);
+		wait_for_completion(&create.done);
+	}
+
+	return create.result;
+}
+
+void kthread_start(struct task_struct *k)
+{
+	wake_up_process(k);
+}
+
+int kthread_stop(struct task_struct *k)
+{
+	struct kthread_stop_info stop;
+	DECLARE_WORK(work, keventd_stop_kthread, &stop);
+
+	stop.k = k;
+	init_completion(&stop.done);
+
+	schedule_work(&work);
+	wait_for_completion(&stop.done);
+	return stop.result;
+}
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12121-linux-2.6.1-rc1-bk6/kernel/workqueue.c .12121-linux-2.6.1-rc1-bk6.updated/kernel/workqueue.c
--- .12121-linux-2.6.1-rc1-bk6/kernel/workqueue.c	2004-01-06 16:05:51.000000000 +1100
+++ .12121-linux-2.6.1-rc1-bk6.updated/kernel/workqueue.c	2004-01-06 16:05:54.000000000 +1100
@@ -347,6 +347,11 @@ void flush_scheduled_work(void)
 	flush_workqueue(keventd_wq);
 }
 
+int keventd_up(void)
+{
+	return keventd_wq != NULL;
+}
+
 int current_is_keventd(void)
 {
 	struct cpu_workqueue_struct *cwq;
