Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264337AbUACXyU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 18:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264340AbUACXyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 18:54:20 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:4232 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264337AbUACXx6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 18:53:58 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sat, 3 Jan 2004 15:53:59 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       <mingo@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] kthread_create 
In-Reply-To: <Pine.LNX.4.44.0401031021280.1678-100000@bigblue.dev.mdolabs.com>
Message-ID: <Pine.LNX.4.44.0401031549580.2022-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Jan 2004, Davide Libenzi wrote:

> On Fri, 2 Jan 2004, Davide Libenzi wrote:
> 
> > On Sat, 3 Jan 2004, Rusty Russell wrote:
> > 
> > > In message <Pine.LNX.4.44.0401020856150.2278-100000@bigblue.dev.mdolabs.com> you write:
> > > > Rusty, you still have to use global static data when there is no need.
> > > 
> > > And you're still putting obscure crap in the task struct when there's
> > > no need.  Honestly, I'd be ashamed to post such a patch.
> > 
> > Ashamed !? Take a look at your original patch and then define shame. You 
> > had a communication mechanism that whilst being a private 1<->1 
> > communication among two tasks, relied on a single global message 
> > strucure, lock and mutex. Honestly I do not like myself to add stuff 
> > inside a strcture for one-time use. Not because of adding 12 bytes to the 
> > struct, that are laughable. But because it is used by a small piece of 
> > code w/out a re-use ability for other things.
> 
> Rusty, I took a better look at the patch and I think we can have 
> per-kthread stuff w/out littering the task_struct and by making the thing 
> more robust. We keep a global list_head protected by a global spinlock. We 
> define a structure that contain all the per-kthread stuff we need 
> (including a task_struct* to the kthread itself). When a kthread starts it 
> will add itself to the list, and when it will die it will remove itself 
> from the list. The start/stop functions will lookup the list (or hash, 
> depending on how much stuff you want to drop in) with the target 
> task_struct*, and if the lookup fails, it means the task already quit 
> (another task already did kthread_stop() ??, natural death ????). This is 
> too bad, but at least there won't be deadlock (or crash) beacause of this. 
> This because currently we keep the kthread task_struct* lingering around 
> w/out a method that willl inform us if the task goes away for some reason 
> (so that we can avoid signaling it and waiting for some interaction). The 
> list/hash will be able to tell us this. What do you think?

Rusty, I gave the patch a quick shot. There's no more single and 
global data structures but the list that stores all kthreads. Like usual, 
if you don't like it you can trash it. But pls leave shame apart. It did 
nothing to you :-)




- Davide




--- linux-2.5/include/linux/kthread.h._orig	2004-01-03 14:15:33.033286880 -0800
+++ linux-2.5/include/linux/kthread.h	2004-01-03 14:15:33.033286880 -0800
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
--- linux-2.5/include/linux/workqueue.h._orig	2004-01-03 14:14:17.678742512 -0800
+++ linux-2.5/include/linux/workqueue.h	2004-01-03 14:15:33.042285512 -0800
@@ -60,6 +60,7 @@
 extern int FASTCALL(schedule_delayed_work(struct work_struct *work, unsigned long delay));
 extern void flush_scheduled_work(void);
 extern int current_is_keventd(void);
+extern int keventd_up(void);
 
 extern void init_workqueues(void);
 
--- linux-2.5/kernel/Makefile._orig	2004-01-03 14:14:18.205662408 -0800
+++ linux-2.5/kernel/Makefile	2004-01-03 14:15:33.092277912 -0800
@@ -6,7 +6,8 @@
 	    exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
-	    rcupdate.o intermodule.o extable.o params.o posix-timers.o
+	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
+	    kthread.o
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
--- linux-2.5/kernel/kthread.c._orig	2004-01-03 14:15:33.100276696 -0800
+++ linux-2.5/kernel/kthread.c	2004-01-03 15:48:39.783971680 -0800
@@ -0,0 +1,255 @@
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
+#include <linux/list.h>
+#include <linux/kthread.h>
+#include <linux/completion.h>
+#include <linux/err.h>
+#include <linux/unistd.h>
+#include <asm/semaphore.h>
+
+
+
+
+static LIST_HEAD(kt_list);
+static spinlock_t kt_lock = SPIN_LOCK_UNLOCKED;
+
+
+
+struct kthread_create_info
+{
+	int (*initfn)(void *data);
+	int (*corefn)(void *data);
+	void *data;
+	char *name;
+};
+
+struct kthread_create
+{
+	struct kthread_create_info info;
+	struct semaphore ack;
+	struct task_struct *tsk;
+};
+
+struct kthread_node
+{
+	struct list_head lnk;
+	struct task_struct *self;
+	struct semaphore sem;
+	struct semaphore ack;
+	int ret, done;
+};
+
+
+/*
+ * Try to lookup the kthread node associated with the task "k".
+ * If the task exist, acquire ktn->sem to avoid the task to exit.
+ */
+static struct kthread_node *kthread_lookup(struct task_struct *k) {
+	struct list_head *pos;
+	struct kthread_node *ktn = NULL;
+
+	spin_lock(&kt_lock);
+	list_for_each(pos, &kt_list) {
+		ktn = list_entry(pos, struct kthread_node, lnk);
+		if (ktn->self == k)
+			break;
+		ktn = NULL;
+	}
+	if (ktn && down_trylock(&ktn->sem))
+		ktn = NULL;
+	spin_unlock(&kt_lock);
+	return ktn;
+}
+
+
+/* Returns a POSITIVE error number. */
+static int kthread(void *data)
+{
+	/* Copy data: it's on keventd_init's stack */
+	struct kthread_create *ktc = data;
+	struct kthread_create_info k = ktc->info;
+	int ret = 0;
+	sigset_t blocked;
+	struct kthread_node ktn;
+
+	/* Initialize the kthread list node and drop itself inside the list */
+	ktn.done = 0;
+	ktn.ret = -1;
+	ktn.self = current;
+	init_MUTEX(&ktn.sem);
+	init_MUTEX_LOCKED(&ktn.ack);
+	spin_lock(&kt_lock);
+	list_add(&ktn.lnk, &kt_list);
+	spin_unlock(&kt_lock);
+
+	strcpy(current->comm, k.name);
+
+	/* Block and flush all signals. */
+	sigfillset(&blocked);
+	sigprocmask(SIG_BLOCK, &blocked, NULL);
+	flush_signals(current);
+
+	/*
+	 * OK, tell user we're spawned, wait for kthread_start/stop.
+	 * Note that after this call the "ktc" pointer will be no longer
+	 * valid.
+	 */
+	up(&ktc->ack);
+	current->state = TASK_INTERRUPTIBLE;
+	schedule();
+
+	ret = EINTR;
+	if (signal_pending(current))
+		goto out;
+
+	/* Run initfn, tell the caller the result. */
+	ret = 0;
+	if (k.initfn)
+		ret = k.initfn(k.data);
+	ktn.ret = ret;
+
+	/*
+	 * The caller is waiting for us to signal the completion
+	 * of the init function.
+	 */
+	up(&ktn.ack);
+
+	if (ret < 0)
+		goto out;
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
+
+	ret = 0;
+out:
+	spin_lock(&kt_lock);
+	list_del(&ktn.lnk);
+	spin_unlock(&kt_lock);
+
+	ktn.done = 1;
+	ktn.ret = ret;
+
+	/*
+	 * The control code will hold the semaphore down to avoid
+	 * the task (and the associated node data) to vanish during
+	 * the handshake
+	 */
+	down(&ktn.sem);
+
+	return ret;
+}
+
+static void create_kthread(void *data)
+{
+	int pid;
+	struct kthread_create *ktc = data;
+
+	/* We want our own signal handler (we take no signals by default). */
+	pid = kernel_thread(kthread, ktc, CLONE_FS|CLONE_FILES|SIGCHLD);
+	if (pid < 0)
+		ktc->tsk = ERR_PTR(pid);
+	else {
+		down(&ktc->ack);
+		ktc->tsk = find_task_by_pid(pid);
+	}
+}
+
+struct task_struct *kthread_create(int (*initfn)(void *data),
+				   int (*corefn)(void *data),
+				   void *data,
+				   const char namefmt[],
+				   ...)
+{
+	va_list args;
+	struct kthread_create ktc;
+	/* Or, as we like to say, 16. */
+	char name[sizeof(((struct task_struct *)0)->comm)];
+	DECLARE_WORK(work, create_kthread, &ktc);
+
+	va_start(args, namefmt);
+	vsnprintf(name, sizeof(name), namefmt, args);
+	va_end(args);
+
+	ktc.info.initfn = initfn;
+	ktc.info.corefn = corefn;
+	ktc.info.data = data;
+	ktc.info.name = name;
+	init_MUTEX_LOCKED(&ktc.ack);
+
+	/* If we're being called to start the first workqueue, we
+	 * can't use keventd. */
+	if (!keventd_up())
+		work.func(work.data);
+	else {
+		schedule_work(&work);
+		down(&ktc.ack);
+	}
+	return ktc.tsk;
+}
+
+int kthread_start(struct task_struct *k)
+{
+	int ret;
+	struct kthread_node *ktn = kthread_lookup(k);
+
+	/* No corresponding kthread is found. Too bad ... */
+	if (!ktn)
+		return -ENOENT;
+
+	/*
+	 * Wake up the kthread task waiting for us to unlock so that
+	 * it can go run the init function.
+	 */
+	wake_up_process(ktn->self);
+
+	/* Wait for kthread ack after init function complete. */
+	down(&ktn->ack);
+
+	/* Get the init result. */
+	ret = ktn->ret;
+
+	/* now we can release the kthread node. */
+	up(&ktn->sem);
+
+	return ret;
+}
+
+int kthread_stop(struct task_struct *k)
+{
+	int ret;
+	struct kthread_node *ktn = kthread_lookup(k);
+
+	/* No corresponding kthread is found. Too bad ... */
+	if (!ktn)
+		return -ENOENT;
+
+	force_sig(SIGTERM, ktn->self);
+
+	while (!ktn->done)
+		yield();
+
+	/* Get the complete result. */
+	ret = ktn->ret;
+
+	/* now we can release the kthread node. */
+	up(&ktn->sem);
+
+	return ret;
+}
+
--- linux-2.5/kernel/workqueue.c._orig	2004-01-03 14:14:18.259654200 -0800
+++ linux-2.5/kernel/workqueue.c	2004-01-03 14:15:33.109275328 -0800
@@ -359,6 +359,11 @@
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

