Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265118AbUADEbP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 23:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265112AbUADEbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 23:31:15 -0500
Received: from dp.samba.org ([66.70.73.150]:51844 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265118AbUADEak (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 23:30:40 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       mingo@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] kthread_create 
In-reply-to: Your message of "Sat, 03 Jan 2004 11:00:55 -0800."
             <Pine.LNX.4.44.0401031021280.1678-100000@bigblue.dev.mdolabs.com> 
Date: Sun, 04 Jan 2004 13:34:19 +1100
Message-Id: <20040104043037.007922C0F1@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0401031021280.1678-100000@bigblue.dev.mdolabs.com> you write:
> Rusty, I took a better look at the patch and I think we can have 
> per-kthread stuff w/out littering the task_struct and by making the thing 
> more robust.

Except sharing data with a lock is perfectly robust.

> We keep a global list_head protected by a global spinlock. We 
> define a structure that contain all the per-kthread stuff we need 
> (including a task_struct* to the kthread itself). When a kthread starts it 
> will add itself to the list, and when it will die it will remove itself 
> from the list.

Yeah, I deliberately didn't implement this, because (1) it seems like
a lot of complexity when using a lock and letting them share a single
structure works fine and is even simpler, and (2) the thread can't
just "do_exit()".

You can get around (2) by having a permenant parent "kthread" thread
which is a parent to all the kthreads (it'll get a SIGCHLD when
someone does "do_exit()").  But the implementation was pretty ugly,
since it involved having a communications mechanism with the kthread
parent, which means you have the global ktm_message-like-thing for
this...

> The start/stop functions will lookup the list (or hash, 
> depending on how much stuff you want to drop in) with the target 
> task_struct*, and if the lookup fails, it means the task already quit 
> (another task already did kthread_stop() ??, natural death ????). This is 
> too bad, but at least there won't be deadlock (or crash) beacause of this. 

> This because currently we keep the kthread task_struct* lingering around 
> w/out a method that willl inform us if the task goes away for some reason 
> (so that we can avoid signaling it and waiting for some interaction). The 
> list/hash will be able to tell us this. What do you think?

I put the "corefn fails" option in there in case someone wants it, but
I'm not sure how it would be used in practice.  If it becomes
commonplace to have them handing around for a long time, then storing
the result somewhere rather than keeping the whole thread around makes
sense, but at the moment it seems like premature optimization.

Unfortunately, my fd idea is broken, because the process which does
the start may not be the same as the one which does the create.  A
shared queue really is the simplest solution.

Latest version below,
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
D: 4) This version uses signals rather than its own communication
D:     mechanism makes kthread code a little simpler, and means users can
D:     loop inside corefn if they want, and return when signal_pending().
D: 5) kthread_destroy() renamed to kthread_stop().
D: 6) kthread_start() returns an int.
D: 7) Better documentation, in nanodoc form.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .8740-linux-2.6.1-rc1/include/linux/kthread.h .8740-linux-2.6.1-rc1.updated/include/linux/kthread.h
--- .8740-linux-2.6.1-rc1/include/linux/kthread.h	1970-01-01 10:00:00.000000000 +1000
+++ .8740-linux-2.6.1-rc1.updated/include/linux/kthread.h	2004-01-02 21:18:54.000000000 +1100
@@ -0,0 +1,81 @@
+#ifndef _LINUX_KTHREAD_H
+#define _LINUX_KTHREAD_H
+/* Simple interface for creating and stopping kernel threads without mess. */
+#include <linux/err.h>
+struct task_struct;
+
+/**
+ * kthread_create: create a kthread.
+ * @initfn: a function to run when kthread_start() is called.
+ * @corefn: a function to run after @initfn succeeds.
+ * @data: data ptr for @initfn and @corefn.
+ * @namefmt: printf-style name for the thread.
+ *
+ * Description: This helper function creates and names a kernel
+ * thread, and controls it for you.  See kthread_start() and
+ * kthread_run().
+ * 
+ * Returns a task_struct or ERR_PTR(-ENOMEM).
+ */
+struct task_struct *kthread_create(int (*initfn)(void *data),
+				   int (*corefn)(void *data),
+				   void *data,
+				   const char namefmt[], ...);
+
+/**
+ * kthread_start: start a thread created by kthread_create().
+ * @k: the task returned by kthread_create().
+ *
+ * Description: This makes the thread @k run the initfn() specified in
+ * kthread_create(), if non-NULL, and return the result.  If that
+ * result is less than zero, then the thread @k is terminated.
+ * Otherwise, the corefn() is run if it is not NULL.
+ *
+ * There are two ways to write corefn(): simple or complex.  For
+ * simple, you set current->state to TASK_INTERRUPTIBLE, check for
+ * work, then return 0 when it is done.  The kthread code will call
+ * schedule(), and call corefn() again when woken.  More complex
+ * corefn()s can loop themselves, but must return 0 when
+ * signal_pending(current) is true.
+ *
+ * corefn() can terminate itself in two ways: if someone will later
+ * call kthread_stop(), simply return a negative error number.
+ * Otherwise, if you call do_exit() directly, the thread will
+ * terminate immediately. */
+int kthread_start(struct task_struct *k);
+
+/**
+ * kthread_run: create and start a thread.
+ * @initfn: a function to run when kthread_start() is called.
+ * @corefn: a function to run after initfn succeeds.
+ * @data: data ptr for @initfn and @corefn.
+ * @namefmt: printf-style name for the thread.
+ *
+ * Description: Convenient wrapper for kthread_create() followed by
+ * kthread_start().  Returns the kthread, or ERR_PTR(). */
+#define kthread_run(initfn, corefn, data, namefmt, ...)			      \
+({									      \
+	struct task_struct *__k						      \
+		= kthread_create(initfn,corefn,data,namefmt, ## __VA_ARGS__); \
+	if (!IS_ERR(__k)) {						      \
+		int __err = kthread_start(__k);				      \
+		if (__err) __k = ERR_PTR(__err);			      \
+	}								      \
+	__k;								      \
+})
+
+/**
+ * kthread_stop: stop a thread created by kthread_create().
+ * @k: thread created by kthread_start.
+ *
+ * Sends a signal to @k, and waits for it to exit.  Your corefn() must
+ * not call do_exit() itself if you use this function!  This can also
+ * be called after kthread_create() instead of calling
+ * kthread_start(): the thread will exit without calling initfn() or
+ * corefn().
+ *
+ * Returns the last result of corefn(), or 0 if kthread_start() was
+ * never called. */
+int kthread_stop(struct task_struct *k);
+
+#endif /* _LINUX_KTHREAD_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .8740-linux-2.6.1-rc1/include/linux/workqueue.h .8740-linux-2.6.1-rc1.updated/include/linux/workqueue.h
--- .8740-linux-2.6.1-rc1/include/linux/workqueue.h	2003-09-22 10:07:08.000000000 +1000
+++ .8740-linux-2.6.1-rc1.updated/include/linux/workqueue.h	2004-01-02 20:45:13.000000000 +1100
@@ -60,6 +60,7 @@ extern int FASTCALL(schedule_work(struct
 extern int FASTCALL(schedule_delayed_work(struct work_struct *work, unsigned long delay));
 extern void flush_scheduled_work(void);
 extern int current_is_keventd(void);
+extern int keventd_up(void);
 
 extern void init_workqueues(void);
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .8740-linux-2.6.1-rc1/kernel/Makefile .8740-linux-2.6.1-rc1.updated/kernel/Makefile
--- .8740-linux-2.6.1-rc1/kernel/Makefile	2003-10-09 18:03:02.000000000 +1000
+++ .8740-linux-2.6.1-rc1.updated/kernel/Makefile	2004-01-02 20:45:13.000000000 +1100
@@ -6,7 +6,8 @@ obj-y     = sched.o fork.o exec_domain.o
 	    exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
-	    rcupdate.o intermodule.o extable.o params.o posix-timers.o
+	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
+	    kthread.o
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .8740-linux-2.6.1-rc1/kernel/kthread.c .8740-linux-2.6.1-rc1.updated/kernel/kthread.c
--- .8740-linux-2.6.1-rc1/kernel/kthread.c	1970-01-01 10:00:00.000000000 +1000
+++ .8740-linux-2.6.1-rc1.updated/kernel/kthread.c	2004-01-02 21:07:50.000000000 +1100
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
+	/* OK, tell user we're spawned, wait for kthread_start/stop */
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
+		/* If it fails, just wait until kthread_stop. */
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
+int kthread_start(struct task_struct *k)
+{
+	return PTR_ERR(do_kthread_op(KTHREAD_START, k));
+}
+
+int kthread_stop(struct task_struct *k)
+{
+	return PTR_ERR(do_kthread_op(KTHREAD_STOP, k));
+}
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .8740-linux-2.6.1-rc1/kernel/workqueue.c .8740-linux-2.6.1-rc1.updated/kernel/workqueue.c
--- .8740-linux-2.6.1-rc1/kernel/workqueue.c	2003-09-22 10:27:38.000000000 +1000
+++ .8740-linux-2.6.1-rc1.updated/kernel/workqueue.c	2004-01-02 20:45:13.000000000 +1100
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
