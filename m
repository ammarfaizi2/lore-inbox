Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265732AbUAEEbz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 23:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265882AbUAEEbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 23:31:55 -0500
Received: from dp.samba.org ([66.70.73.150]:64165 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265732AbUAEEbm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 23:31:42 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: mingo@redhat.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] kthread_create 
In-reply-to: Your message of "Sun, 04 Jan 2004 15:03:01 -0800."
             <Pine.LNX.4.44.0401041501510.12666-100000@bigblue.dev.mdolabs.com> 
Date: Mon, 05 Jan 2004 15:09:10 +1100
Message-Id: <20040105043139.B8D642C10E@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0401041501510.12666-100000@bigblue.dev.mdolabs.com> you write:
> I can see two options:
> 
> 1) We do not allow do_exit() from kthreads
> 
> 2) We give kthread_exit()
> 
> What do you think?

Well, I've now got a patch which works without any global
datastructures, but still allows the same semantics.  Includes some
fixes in the previous code, and test code.

Also includes a longstanding fix in workqueue.c: we never get SIGCHLD
if signal handler is SIG_IGN.

I'm not sure it's neater, though.  We don't have WIFEXITED() in the
kernel, so lots of manual shifting, probably should add that
somewhere.

Thoughts?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.1-rc1-bk5/include/linux/kthread.h working-2.6.1-rc1-bk5-kthread-noglobal/include/linux/kthread.h
--- linux-2.6.1-rc1-bk5/include/linux/kthread.h	1970-01-01 10:00:00.000000000 +1000
+++ working-2.6.1-rc1-bk5-kthread-noglobal/include/linux/kthread.h	2004-01-05 14:42:02.000000000 +1100
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.1-rc1-bk5/include/linux/workqueue.h working-2.6.1-rc1-bk5-kthread-noglobal/include/linux/workqueue.h
--- linux-2.6.1-rc1-bk5/include/linux/workqueue.h	2003-09-22 10:07:08.000000000 +1000
+++ working-2.6.1-rc1-bk5-kthread-noglobal/include/linux/workqueue.h	2004-01-05 14:42:02.000000000 +1100
@@ -60,6 +60,7 @@ extern int FASTCALL(schedule_work(struct
 extern int FASTCALL(schedule_delayed_work(struct work_struct *work, unsigned long delay));
 extern void flush_scheduled_work(void);
 extern int current_is_keventd(void);
+extern int keventd_up(void);
 
 extern void init_workqueues(void);
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.1-rc1-bk5/kernel/Makefile working-2.6.1-rc1-bk5-kthread-noglobal/kernel/Makefile
--- linux-2.6.1-rc1-bk5/kernel/Makefile	2003-10-09 18:03:02.000000000 +1000
+++ working-2.6.1-rc1-bk5-kthread-noglobal/kernel/Makefile	2004-01-05 14:42:02.000000000 +1100
@@ -6,7 +6,8 @@ obj-y     = sched.o fork.o exec_domain.o
 	    exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
-	    rcupdate.o intermodule.o extable.o params.o posix-timers.o
+	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
+	    kthread.o
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.1-rc1-bk5/kernel/kthread.c working-2.6.1-rc1-bk5-kthread-noglobal/kernel/kthread.c
--- linux-2.6.1-rc1-bk5/kernel/kthread.c	1970-01-01 10:00:00.000000000 +1000
+++ working-2.6.1-rc1-bk5-kthread-noglobal/kernel/kthread.c	2004-01-05 14:42:02.000000000 +1100
@@ -0,0 +1,289 @@
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
+struct kthread_create_info
+{
+	int (*initfn)(void *data);
+	int (*corefn)(void *data);
+	void *data;
+	char *name;
+	struct completion started;
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
+	complete(&((struct kthread_create_info *)data)->started);
+	schedule();
+
+	if (signal_pending(current))
+		return EINTR;
+
+	/* Run initfn: start_kthread is in wait(). */
+	if (k.initfn)
+		ret = k.initfn(k.data);
+	if (ret < 0)
+		return -ret << 8;
+
+	/* We succeeded.  Stop ourselves to break them out of wait(). */
+	current->exit_code = 1;
+	current->state = TASK_STOPPED;
+	notify_parent(current, SIGCHLD);
+	schedule();
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
+	return -ret << 8;
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
+		struct kthread_create_info *create;
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
+	/* We want our own signal handler (we take no signals by default). */
+	pid = kernel_thread(kthread,op->u.create,CLONE_FS|CLONE_FILES|SIGCHLD);
+	if (pid < 0)
+		return ERR_PTR(pid);
+
+	wait_for_completion(&op->u.create->started);
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
+	int ret, status;
+
+	/* Adopt it so we can wait() for result. */
+	adopt_kthread(op->u.target);
+	wake_up_process(op->u.target);
+
+	ret = waitpid(op->u.target->tgid, &status, __WALL|WUNTRACED);
+	BUG_ON(ret < 0);
+	if ((status & 0xff) == 0x7f) {
+		/* STOPPED means initfn succeeded, tell it to continue. */
+		wake_up_process(op->u.target);
+		return NULL;
+	}
+
+	return ERR_PTR(-((status >> 8) & 0xFF));
+}
+
+/* We are keventd: stop the thread. */
+static void *stop_kthread(struct kthread_op *op)
+{
+	int status;
+	pid_t pid = op->u.target->tgid;
+
+	adopt_kthread(op->u.target);
+
+	force_sig(SIGTERM, op->u.target);
+	waitpid(pid, &status, __WALL);
+
+	return ERR_PTR(-((status >> 8) & 0xFF));
+}
+
+/* We are keventd: do what they told us */
+static void keventd_do_kthread_op(void *_op)
+{
+	struct kthread_op *op = _op;
+
+	switch (op->type) {
+	case KTHREAD_CREATE: op->u.result = create_kthread(op); break;
+	case KTHREAD_START: op->u.result = start_kthread(op); break;
+	case KTHREAD_STOP: op->u.result = stop_kthread(op); break;
+	default:
+		BUG();
+	}
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
+	init_completion(&start.started);
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
+
+/* Test code */
+#include <linux/init.h>
+static int init(void *data)
+{
+	if (data == init) {
+		printk("init returning %i\n", -EINVAL);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int core(void *data)
+{
+	if (data == core)
+		return -ENOENT;
+	if (data == do_exit)
+		do_exit(0);
+	current->state = TASK_INTERRUPTIBLE;
+	return 0;
+}
+
+static int test_kthreads(void)
+{
+	struct task_struct *k;
+	int ret;
+
+	printk("kthread: Initialization which fails.\n");
+	k = kthread_create(init, core, init, "kthreadtest");
+	BUG_ON(IS_ERR(k));
+	ret = kthread_start(k);
+	BUG_ON(ret != -EINVAL);
+
+	printk("kthread: stopped before initialization\n");
+	k = kthread_create(init, core, NULL, "kthreadtest");
+	BUG_ON(IS_ERR(k));
+	ret = kthread_stop(k);
+	BUG_ON(ret != 0);
+
+	printk("kthread: Corefn which fails.\n");
+	k = kthread_create(init, core, core, "kthreadtest");
+	BUG_ON(IS_ERR(k));
+	ret = kthread_start(k);
+	BUG_ON(ret != 0);
+	ret = kthread_stop(k);
+	BUG_ON(ret != -ENOENT);
+
+	printk("kthread: Corefn which succeeds.\n");
+	k = kthread_create(init, core, NULL, "kthreadtest");
+	BUG_ON(IS_ERR(k));
+	ret = kthread_start(k);
+	BUG_ON(ret != 0);
+	ret = kthread_stop(k);
+	BUG_ON(ret != 0);
+
+	printk("kthread: Corefn which exits.\n");
+	k = kthread_create(init, core, do_exit, "kthreadtest");
+	BUG_ON(IS_ERR(k));
+	get_task_struct(k);
+	ret = kthread_start(k);
+	BUG_ON(ret != 0);
+	BUG_ON(!(k->state & (TASK_ZOMBIE|TASK_DEAD)));
+	put_task_struct(k);
+
+	printk("All kthread tests passed...\n");
+	return 0;
+}
+
+module_init(test_kthreads);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.1-rc1-bk5/kernel/workqueue.c working-2.6.1-rc1-bk5-kthread-noglobal/kernel/workqueue.c
--- linux-2.6.1-rc1-bk5/kernel/workqueue.c	2003-09-22 10:27:38.000000000 +1000
+++ working-2.6.1-rc1-bk5-kthread-noglobal/kernel/workqueue.c	2004-01-05 14:42:02.000000000 +1100
@@ -181,7 +181,7 @@ static int worker_thread(void *__startup
 	complete(&startup->done);
 
 	/* Install a handler so SIGCLD is delivered */
-	sa.sa.sa_handler = SIG_IGN;
+	sa.sa.sa_handler = SIG_DFL;
 	sa.sa.sa_flags = 0;
 	siginitset(&sa.sa.sa_mask, sigmask(SIGCHLD));
 	do_sigaction(SIGCHLD, &sa, (struct k_sigaction *)0);
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
