Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266106AbTLaEUb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 23:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266109AbTLaEUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 23:20:30 -0500
Received: from dp.samba.org ([66.70.73.150]:12442 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266106AbTLaEUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 23:20:19 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@osdl.org, akpm@osdl.org
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] kthread_create
Date: Wed, 31 Dec 2003 14:31:08 +1100
Message-Id: <20031231042016.958DC2C04B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

	Ingo read through this before and liked it: this is the basis
of the Hotplug CPU patch, and as such has been stressed fairly well.
Tested stand-alone, and included here for wider review.

Feedback welcome!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Kernel Thread Control Primitives
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

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .32392-linux-2.6.0-test11-bk6/include/linux/kthread.h .32392-linux-2.6.0-test11-bk6.updated/include/linux/kthread.h
--- .32392-linux-2.6.0-test11-bk6/include/linux/kthread.h	1970-01-01 10:00:00.000000000 +1000
+++ .32392-linux-2.6.0-test11-bk6.updated/include/linux/kthread.h	2003-12-09 17:42:29.000000000 +1100
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .32392-linux-2.6.0-test11-bk6/include/linux/workqueue.h .32392-linux-2.6.0-test11-bk6.updated/include/linux/workqueue.h
--- .32392-linux-2.6.0-test11-bk6/include/linux/workqueue.h	2003-09-22 10:07:08.000000000 +1000
+++ .32392-linux-2.6.0-test11-bk6.updated/include/linux/workqueue.h	2003-12-09 17:42:29.000000000 +1100
@@ -60,6 +60,7 @@ extern int FASTCALL(schedule_work(struct
 extern int FASTCALL(schedule_delayed_work(struct work_struct *work, unsigned long delay));
 extern void flush_scheduled_work(void);
 extern int current_is_keventd(void);
+extern int keventd_up(void);
 
 extern void init_workqueues(void);
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .32392-linux-2.6.0-test11-bk6/kernel/Makefile .32392-linux-2.6.0-test11-bk6.updated/kernel/Makefile
--- .32392-linux-2.6.0-test11-bk6/kernel/Makefile	2003-10-09 18:03:02.000000000 +1000
+++ .32392-linux-2.6.0-test11-bk6.updated/kernel/Makefile	2003-12-09 17:42:29.000000000 +1100
@@ -6,7 +6,8 @@ obj-y     = sched.o fork.o exec_domain.o
 	    exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
-	    rcupdate.o intermodule.o extable.o params.o posix-timers.o
+	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
+	    kthread.o
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .32392-linux-2.6.0-test11-bk6/kernel/kthread.c .32392-linux-2.6.0-test11-bk6.updated/kernel/kthread.c
--- .32392-linux-2.6.0-test11-bk6/kernel/kthread.c	1970-01-01 10:00:00.000000000 +1000
+++ .32392-linux-2.6.0-test11-bk6.updated/kernel/kthread.c	2003-12-09 17:42:29.000000000 +1100
@@ -0,0 +1,228 @@
+/* Kernel thread helper functions.
+ *   Copyright (C) 2003 IBM Corporation, Rusty Russell.
+ *
+ * Everything uses keventd, so that we get a clean environment even if
+ * we're invoked from userspace (think modprobe, hotplug cpu).
+ */
+#include <linux/sched.h>
+#include <linux/kthread.h>
+#include <linux/completion.h>
+#include <linux/err.h>
+#include <asm/semaphore.h>
+
+/* This makes sure only one kthread is being talked to at once. */
+static DECLARE_MUTEX(kthread_control);
+
+/* This coordinates communication between the kthread and routine
+ * controlling it.  Strictly unneccessary, but without it it's barrier
+ * hell. */
+static spinlock_t ktm_lock = SPIN_LOCK_UNLOCKED;
+
+/* All thread comms is command -> ack, so we keep it simple. */
+struct kt_message
+{
+	struct task_struct *from, *to;
+	void *info;
+};
+
+static struct kt_message ktm;
+
+static void ktm_send(struct task_struct *to, void *info)
+{
+	spin_lock(&ktm_lock);
+	ktm.to = to;
+	ktm.from = current;
+	ktm.info = info;
+	if (ktm.to)
+		wake_up_process(ktm.to);
+	spin_unlock(&ktm_lock);
+}
+
+static struct kt_message ktm_receive(void)
+{
+	struct kt_message m;
+
+	for (;;) {
+		spin_lock(&ktm_lock);
+		if (ktm.to == current)
+			break;
+		current->state = TASK_INTERRUPTIBLE;
+		spin_unlock(&ktm_lock);
+		schedule();
+	}
+	m = ktm;
+	spin_unlock(&ktm_lock);
+	return m;
+}
+
+struct kthread
+{
+	int (*initfn)(void *data);
+	int (*corefn)(void *data);
+	void *data;
+	char *name;
+};
+
+/* Check if we're being told to stop. */
+static int time_to_die(struct kt_message *m)
+{
+        int ret = 0;
+
+        spin_lock(&ktm_lock);
+        if (ktm.to == current && ktm.info == NULL) {
+                *m = ktm;
+                ret = 1;
+        }
+        spin_unlock(&ktm_lock);
+        return ret;
+}
+
+static int kthread(void *data)
+{
+	/* Copy data: it's on keventd_init's stack */
+	struct kthread k = *(struct kthread *)data;
+	struct kt_message m;
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
+	/* Send to spawn_kthread, so it knows who we are. */
+	ktm_send(ktm.info, current);
+
+	/* Receive from kthread_start or kthread_destroy */
+	m = ktm_receive();
+	if (!m.info)
+		goto stop;
+	if (k.initfn && (ret = k.initfn(k.data)) < 0)
+		goto stop;
+	ktm_send(m.from, current);
+
+	for (;;) {
+		if (time_to_die(&m))
+			break;
+
+		/* If it fails, just wait until kthread_destroy. */
+		if (k.corefn && (ret = k.corefn(k.data)) < 0)
+			k.corefn = NULL;
+
+		if (time_to_die(&m))
+			break;
+
+		schedule();
+	}
+
+	current->state = TASK_RUNNING;
+stop:
+	ktm_send(m.from, ERR_PTR(ret));
+	return ret;
+}
+
+struct kthread_create
+{
+	struct task_struct *result;
+	struct kthread k;
+	struct completion done;
+};
+
+/* We are keventd().  We create a thread. */
+static void spawn_kthread(void *data)
+{
+	struct kthread_create *kc = data;
+	int ret;
+
+	/* Set up message so they know who their parent is. */
+	ktm_send(NULL, current);
+
+	/* We want our own signal handler (we take no signals by default). */
+	ret = kernel_thread(kthread, &kc->k, CLONE_FS | CLONE_FILES | SIGCHLD);
+	if (ret < 0)
+		kc->result = ERR_PTR(ret);
+	else {
+		/* They tell us who they are. */
+		struct kt_message m = ktm_receive();
+		kc->result = m.info;
+	}
+	complete(&kc->done);
+}
+
+struct task_struct *kthread_create(int (*initfn)(void *data),
+				   int (*corefn)(void *data),
+				   void *data,
+				   const char namefmt[],
+				   ...)
+{
+	va_list args;
+	struct kthread_create kc;
+	DECLARE_WORK(work, spawn_kthread, &kc);
+	/* Or, as we like to say, 16. */
+	char name[sizeof(((struct task_struct *)0)->comm)];
+
+	va_start(args, namefmt);
+	vsnprintf(name, sizeof(name), namefmt, args);
+	va_end(args);
+
+	init_completion(&kc.done);
+	kc.k.initfn = initfn;
+	kc.k.corefn = corefn;
+	kc.k.data = data;
+	kc.k.name = name;
+
+	down(&kthread_control);
+	/* If we're being called to start the first workqueue, we
+	 * can't use keventd. */
+	if (!keventd_up())
+		work.func(work.data);
+	else {
+		schedule_work(&work);
+		wait_for_completion(&kc.done);
+	}
+	up(&kthread_control);
+	return kc.result;
+}
+
+static void wait_for_death(struct task_struct *k)
+{
+	while (!(k->state & TASK_ZOMBIE) && !(k->state & TASK_DEAD))
+		yield();
+}
+
+struct task_struct *kthread_start(struct task_struct *k)
+{
+	struct kt_message m;
+
+	get_task_struct(k);
+
+	down(&kthread_control);
+	ktm_send(k, k);
+	m = ktm_receive();
+	up(&kthread_control);
+
+	if (IS_ERR(m.info))
+		wait_for_death(k);
+	put_task_struct(k);
+
+	return m.info;
+}
+
+int kthread_destroy(struct task_struct *k)
+{
+	struct kt_message m;
+
+	get_task_struct(k);
+
+	down(&kthread_control);
+	ktm_send(k, NULL);
+	m = ktm_receive();
+	up(&kthread_control);
+
+	wait_for_death(k);
+	put_task_struct(k);
+
+	return PTR_ERR(m.info);
+}
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .32392-linux-2.6.0-test11-bk6/kernel/workqueue.c .32392-linux-2.6.0-test11-bk6.updated/kernel/workqueue.c
--- .32392-linux-2.6.0-test11-bk6/kernel/workqueue.c	2003-09-22 10:27:38.000000000 +1000
+++ .32392-linux-2.6.0-test11-bk6.updated/kernel/workqueue.c	2003-12-09 17:42:29.000000000 +1100
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
