Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265364AbUABHMa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 02:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265367AbUABHM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 02:12:29 -0500
Received: from dp.samba.org ([66.70.73.150]:6873 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265364AbUABHMR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 02:12:17 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       mingo@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] kthread_create 
In-reply-to: Your message of "Wed, 31 Dec 2003 19:45:02 -0800."
             <Pine.LNX.4.44.0312311935080.5831-100000@bigblue.dev.mdolabs.com> 
Date: Fri, 02 Jan 2004 18:09:56 +1100
Message-Id: <20040102071215.6D43C2C059@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0312311935080.5831-100000@bigblue.dev.mdolabs.com> yo
u write:
> On Wed, 31 Dec 2003, Rusty Russell wrote:
> 
> > But an alternate implementation would be to have a "kthread" kernel
> > thread, which would actually be parent to the kthread threads.  This
> > means it can allocate and clean up, since it catches *all* thread
> > deaths, including "exit()".
> > 
> > What do you think?
> 
> Did you take a look at the stuff I sent you? I'll append here with a 
> simple comment (this goes over you bits).

Yes, but I think it's a really bad idea, as I said before.

Anyway, Here's a version which fixes the issues raised by Andrew by
doing *everything* in keventd, uses waitpid(), and uses signals for
communication (except for the case of init failing).

Passes initial testing here.

TODO: better documentation.

Comments, welcome.
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Use Signals For Kthread
Author: Rusty Russell
Status: Tested on 2.6.0-bk3

D: The hotplug CPU code introduces two major problems:
D: 
D: 1) Threads which previously never stopped (migration thread,
D:    ksoftirqd, keventd) have to be stopped cleanly as CPUs go offline.
D: 2) Threads which previously never had to be created now have
D:    to be created when a CPU goes online.
D: 
D: Unfortunately, stopping a thread is fairly baroque, involving memory
D: barriers, a completion and spinning until the task is actually dead.
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
D: kthread_create(), kthread_start() and kthread_destroy().  These
D: primitives require no extra data-structures in the caller: they operate
D: on normal "struct task_struct"s.
D: 
D: Other changes:
D:   - Expose keventd_up(), as keventd and migration threads will use
D:     kthread to launch, and kthread normally uses workqueues and must
D:     recognize this case.
D: 
D: Changes since first version:
D: 1) Sleep UNINTERRUPTIBLE when waiting for reply (thanks Andrew Morton).
D: 2) Reparent threads and waitpid for them.
D: 3) Do ALL ops via keventd, so we don't disturb current process.
D: 
D: This version uses signals rather than its own communication
D: mechanism makes kthread code a little simpler, and means users can
D: loop inside corefn if they want, and return when signal_pending().

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29518-linux-2.6.0-bk3/include/linux/kthread.h .29518-linux-2.6.0-bk3.updated/include/linux/kthread.h
--- .29518-linux-2.6.0-bk3/include/linux/kthread.h	1970-01-01 10:00:00.000000000 +1000
+++ .29518-linux-2.6.0-bk3.updated/include/linux/kthread.h	2004-01-02 18:03:20.000000000 +1100
@@ -0,0 +1,38 @@
+#ifndef _LINUX_KTHREAD_H
+#define _LINUX_KTHREAD_H
+/* Simple abstraction for kernel thread usage: the initfn is called at
+ * the start, if that's successful (ie. returns 0), then the thread
+ * sleeps.
+ *
+ * Every time the thread is woken, it will run corefn, until that
+ * returns an error.  The thread must be ended by calling
+ * kthread_destroy().
+ */
+#include <linux/err.h>
+struct task_struct;
+
+/* Part I: create a kthread: if fork fails return ERR_PTR(-errno). */
+struct task_struct *kthread_create(int (*initfn)(void *data),
+				   int (*corefn)(void *data),
+				   void *data,
+				   const char namefmt[], ...);
+
+/* Part II: have thread call initfn(); return thread if successful,
+   otherwise ERR_PTR(-errno). */
+struct task_struct *kthread_start(struct task_struct *k);
+
+/* Convenient wrapper for both of the above. */
+#define kthread_run(initfn, corefn, data, namefmt, ...)			      \
+({									      \
+	struct task_struct *__k						      \
+		= kthread_create(initfn,corefn,data,namefmt, ## __VA_ARGS__); \
+	if (!IS_ERR(__k))						      \
+		__k = kthread_start(__k);				      \
+	__k;								      \
+})
+
+/* Stop the thread.  Return value is last return of corefn() (ie. zero
+ * if exited as normal).  Can be called before kthread_start(). */
+int kthread_destroy(struct task_struct *k);
+
+#endif /* _LINUX_KTHREAD_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29518-linux-2.6.0-bk3/include/linux/workqueue.h .29518-linux-2.6.0-bk3.updated/include/linux/workqueue.h
--- .29518-linux-2.6.0-bk3/include/linux/workqueue.h	2003-09-22 10:07:08.000000000 +1000
+++ .29518-linux-2.6.0-bk3.updated/include/linux/workqueue.h	2004-01-02 18:03:20.000000000 +1100
@@ -60,6 +60,7 @@ extern int FASTCALL(schedule_work(struct
 extern int FASTCALL(schedule_delayed_work(struct work_struct *work, unsigned long delay));
 extern void flush_scheduled_work(void);
 extern int current_is_keventd(void);
+extern int keventd_up(void);
 
 extern void init_workqueues(void);
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29518-linux-2.6.0-bk3/kernel/Makefile .29518-linux-2.6.0-bk3.updated/kernel/Makefile
--- .29518-linux-2.6.0-bk3/kernel/Makefile	2003-10-09 18:03:02.000000000 +1000
+++ .29518-linux-2.6.0-bk3.updated/kernel/Makefile	2004-01-02 18:03:20.000000000 +1100
@@ -6,7 +6,8 @@ obj-y     = sched.o fork.o exec_domain.o
 	    exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
-	    rcupdate.o intermodule.o extable.o params.o posix-timers.o
+	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
+	    kthread.o
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29518-linux-2.6.0-bk3/kernel/kthread.c .29518-linux-2.6.0-bk3.updated/kernel/kthread.c
--- .29518-linux-2.6.0-bk3/kernel/kthread.c	1970-01-01 10:00:00.000000000 +1000
+++ .29518-linux-2.6.0-bk3.updated/kernel/kthread.c	2004-01-02 18:03:20.000000000 +1100
@@ -0,0 +1,227 @@
+/* Kernel thread helper functions.
+ *   Copyright (C) 2003 IBM Corporation, Rusty Russell.
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
+/* This makes sure only one kthread is being talked to at once:
+ * protects global vars below. */
+static DECLARE_MUTEX(kthread_control);
+
+static int kthread_init_failed;
+static DECLARE_COMPLETION(kthread_ack);
+
+struct kthread_create_info
+{
+	int (*initfn)(void *data);
+	int (*corefn)(void *data);
+	void *data;
+	char *name;
+};
+
+/* Returns a POSITIVE error number. */
+static int kthread(void *data)
+{
+	/* Copy data: it's on keventd_init's stack */
+	struct kthread_create_info k = *(struct kthread_create_info *)data;
+	int ret = 0;
+	sigset_t blocked;
+
+	strcpy(current->comm, k.name);
+
+	/* Block and flush all signals. */
+	sigfillset(&blocked);
+	sigprocmask(SIG_BLOCK, &blocked, NULL);
+	flush_signals(current);
+
+	/* OK, tell user we're spawned, wait for kthread_start/destroy */
+	current->state = TASK_INTERRUPTIBLE;
+	complete(&kthread_ack);
+	schedule();
+
+	if (signal_pending(current))
+		return EINTR;
+
+	/* Run initfn, tell the caller the result. */
+	if (k.initfn)
+		ret = k.initfn(k.data);
+	kthread_init_failed = (ret < 0);
+	complete(&kthread_ack);
+	if (ret < 0)
+		return -ret;
+
+	while (!signal_pending(current)) {
+		/* If it fails, just wait until kthread_destroy. */
+		if (k.corefn && (ret = k.corefn(k.data)) < 0) {
+			k.corefn = NULL;
+			current->state = TASK_INTERRUPTIBLE;
+		}
+		schedule();
+	}
+
+	current->state = TASK_RUNNING;
+	return -ret;
+}
+
+enum kthread_op_type
+{
+	KTHREAD_CREATE,
+	KTHREAD_START,
+	KTHREAD_STOP,
+};
+
+struct kthread_op
+{
+	enum kthread_op_type type;
+
+	union {
+		/* KTHREAD_CREATE in */
+		struct kthread_start_info *start;
+		/* KTHREAD_START, KTHREAD_STOP in */
+		struct task_struct *target;
+		/* out */
+		struct task_struct *result;
+	} u;
+	struct completion done;
+};
+
+/* We are keventd: create a thread. */
+static void *create_kthread(struct kthread_op *op)
+{
+	int pid;
+
+	init_completion(&kthread_ack);
+	/* We want our own signal handler (we take no signals by default). */
+	pid = kernel_thread(kthread, op->u.start,CLONE_FS|CLONE_FILES|SIGCHLD);
+	if (pid < 0)
+		return ERR_PTR(pid);
+
+	wait_for_completion(&kthread_ack);
+	return find_task_by_pid(pid);
+}
+
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
+/* We are keventd: start the thread. */
+static void *start_kthread(struct kthread_op *op)
+{
+	int status = 0;
+
+	init_completion(&kthread_ack);
+
+	/* Adopt it in case it's going to die, then tell it to start... */
+	adopt_kthread(op->u.target);
+	get_task_struct(op->u.target);
+	wake_up_process(op->u.target);
+	wait_for_completion(&kthread_ack);
+
+	if (kthread_init_failed)
+		waitpid(op->u.target->tgid, &status, __WALL);
+	put_task_struct(op->u.target);
+
+	return ERR_PTR((status >> 8) & 0xFF);
+}
+
+/* We are keventd: stop the thread. */
+static void *stop_kthread(struct kthread_op *op)
+{
+	int status;
+
+	adopt_kthread(op->u.target);
+
+	get_task_struct(op->u.target);
+	force_sig(SIGTERM, op->u.target);
+	waitpid(op->u.target->tgid, &status, __WALL);
+	put_task_struct(op->u.target);
+
+	return ERR_PTR((status >> 8) & 0xFF);
+}
+
+/* We are keventd: do what they told us */
+static void keventd_do_kthread_op(void *_op)
+{
+	struct kthread_op *op = _op;
+
+	down(&kthread_control);
+
+	switch (op->type) {
+	case KTHREAD_CREATE: op->u.result = create_kthread(op); break;
+	case KTHREAD_START: op->u.result = start_kthread(op); break;
+	case KTHREAD_STOP: op->u.result = stop_kthread(op); break;
+	default:
+		BUG();
+	}
+
+	up(&kthread_control);
+	complete(&op->done);
+}
+
+static struct task_struct *do_kthread_op(enum kthread_op_type type, void *info)
+{
+	struct kthread_op op;
+	DECLARE_WORK(work, keventd_do_kthread_op, &op);
+
+	op.type = type;
+	op.u.target = info;
+	init_completion(&op.done);
+	
+	/* If we're being called to start the first workqueue, we
+	 * can't use keventd. */
+	if (!keventd_up())
+		work.func(work.data);
+	else {
+		schedule_work(&work);
+		wait_for_completion(&op.done);
+	}
+	return op.u.result;
+}
+
+struct task_struct *kthread_create(int (*initfn)(void *data),
+				   int (*corefn)(void *data),
+				   void *data,
+				   const char namefmt[],
+				   ...)
+{
+	va_list args;
+	struct kthread_create_info start;
+	/* Or, as we like to say, 16. */
+	char name[sizeof(((struct task_struct *)0)->comm)];
+
+	va_start(args, namefmt);
+	vsnprintf(name, sizeof(name), namefmt, args);
+	va_end(args);
+
+	start.initfn = initfn;
+	start.corefn = corefn;
+	start.data = data;
+	start.name = name;
+	return do_kthread_op(KTHREAD_CREATE, &start);
+}
+
+struct task_struct *kthread_start(struct task_struct *k)
+{
+	return do_kthread_op(KTHREAD_START, k);
+}
+
+int kthread_destroy(struct task_struct *k)
+{
+	return PTR_ERR(do_kthread_op(KTHREAD_STOP, k));
+}
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29518-linux-2.6.0-bk3/kernel/workqueue.c .29518-linux-2.6.0-bk3.updated/kernel/workqueue.c
--- .29518-linux-2.6.0-bk3/kernel/workqueue.c	2003-09-22 10:27:38.000000000 +1000
+++ .29518-linux-2.6.0-bk3.updated/kernel/workqueue.c	2004-01-02 18:03:20.000000000 +1100
@@ -359,6 +359,11 @@ void flush_scheduled_work(void)
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
