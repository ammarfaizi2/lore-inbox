Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265081AbUAGHGi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 02:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265193AbUAGHGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 02:06:38 -0500
Received: from dp.samba.org ([66.70.73.150]:42202 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265081AbUAGHGT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 02:06:19 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: mingo@redhat.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] kthread_create 
In-reply-to: Your message of "Sun, 04 Jan 2004 22:52:24 -0800."
             <Pine.LNX.4.44.0401042243510.16042-100000@bigblue.dev.mdolabs.com> 
Date: Wed, 07 Jan 2004 18:00:52 +1100
Message-Id: <20040107070617.33CE92C107@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0401042243510.16042-100000@bigblue.dev.mdolabs.com> you write:
> On Mon, 5 Jan 2004, Rusty Russell wrote:
> > Nope.  That's EXACTLY the kind of burden on the caller I wanted to
> > avoid if at all possible.
> 
> Which burden? The kthread is a resource and a "struct kthread" is an 
> handle to the resource. You create the resource (kthread_create()), you 
> control the resource (kthread_start()) and you free the resource 
> (kthread_stop()). To me it's simple and clean and does not require hacks 
> like taking owerships of tasks and using SIGCLD/waitpid to communicate. 
> Anyway, that's your baby and you'll take your choice.

Thinking more about this issue lead me to rewrite the code to be
simpler to use.  Main benefit is that the transition from existing
code is minimal.

Latest version of patch, and code which uses it.  It's actually quite
neat now.  Changes since first version:

1) kthread_start() deleted in favor of wake_up_process() directly.
2) New kthread_bind() for just-created threads, to replace original
   migration thread open-coded version.
3) Slight simplification: thread named only if spawned OK.

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Simplified Kthread
Author: Rusty Russell
Status: Booted on 2.6.1-rc2-bk1
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
D: kthread_create() and kthread_stop().  These primitives require no
D: extra data-structures in the caller: they operate on normal "struct
D: task_struct"s.
D: 
D: Other changes:
D:   - Expose keventd_up(), as keventd and migration threads will use
D:     kthread to launch, and kthread normally uses workqueues and must
D:     recognize this case.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16124-linux-2.6.1-rc2-bk1/include/linux/kthread.h .16124-linux-2.6.1-rc2-bk1.updated/include/linux/kthread.h
--- .16124-linux-2.6.1-rc2-bk1/include/linux/kthread.h	1970-01-01 10:00:00.000000000 +1000
+++ .16124-linux-2.6.1-rc2-bk1.updated/include/linux/kthread.h	2004-01-07 17:56:59.000000000 +1100
@@ -0,0 +1,71 @@
+#ifndef _LINUX_KTHREAD_H
+#define _LINUX_KTHREAD_H
+/* Simple interface for creating and stopping kernel threads without mess. */
+#include <linux/err.h>
+#include <linux/sched.h>
+
+/**
+ * kthread_create: create a kthread.
+ * @threadfn: the function to run until signal_pending(current).
+ * @data: data ptr for @threadfn.
+ * @namefmt: printf-style name for the thread.
+ *
+ * Description: This helper function creates and names a kernel
+ * thread.  The thread will be stopped: use wake_up_process() to start
+ * it.  See also kthread_run(), kthread_create_on_cpu().
+ *
+ * When woken, the thread will run @threadfn() with @data as its
+ * argument. @threadfn can either call do_exit() directly if it is a
+ * standalone thread for which noone will call kthread_stop(), or
+ * return when 'signal_pending(current)' is true (which means
+ * kthread_stop() has been called).  The return value should be zero
+ * or a negative error number: it will be passed to kthread_stop().
+ * 
+ * Returns a task_struct or ERR_PTR(-ENOMEM).
+ */
+struct task_struct *kthread_create(int (*threadfn)(void *data),
+				   void *data,
+				   const char namefmt[], ...);
+
+/**
+ * kthread_run: create and wake a thread.
+ * @threadfn: the function to run until signal_pending(current).
+ * @data: data ptr for @threadfn.
+ * @namefmt: printf-style name for the thread.
+ *
+ * Description: Convenient wrapper for kthread_create() followed by
+ * wake_up_process().  Returns the kthread, or ERR_PTR(-ENOMEM). */
+#define kthread_run(threadfn, data, namefmt, ...)			   \
+({									   \
+	struct task_struct *__k						   \
+		= kthread_create(threadfn, data, namefmt, ## __VA_ARGS__); \
+	if (!IS_ERR(__k))						   \
+		wake_up_process(__k);					   \
+	__k;								   \
+})
+
+/**
+ * kthread_bind: bind a just-created kthread to a cpu.
+ * @k: thread created by kthread_create().
+ * @cpu: cpu (might not be online, must be possible) for @k to run on.
+ *
+ * Description: This function is equivalent to set_cpus_allowed(),
+ * except that @cpu doesn't need to be online, and the thread must be
+ * stopped (ie. just returned from kthread_create().
+ */
+void kthread_bind(struct task_struct *k, unsigned int cpu);
+
+/**
+ * kthread_stop: stop a thread created by kthread_create().
+ * @k: thread created by kthread_create().
+ *
+ * Sends a signal to @k, and waits for it to exit.  Your threadfn()
+ * must not call do_exit() itself if you use this function!  This can
+ * also be called after kthread_create() instead of calling
+ * wake_up_process(): the thread will exit without calling threadfn().
+ *
+ * Returns the result of threadfn(), or -EINTR if wake_up_process()
+ * was never called. */
+int kthread_stop(struct task_struct *k);
+
+#endif /* _LINUX_KTHREAD_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16124-linux-2.6.1-rc2-bk1/include/linux/workqueue.h .16124-linux-2.6.1-rc2-bk1.updated/include/linux/workqueue.h
--- .16124-linux-2.6.1-rc2-bk1/include/linux/workqueue.h	2003-09-22 10:07:08.000000000 +1000
+++ .16124-linux-2.6.1-rc2-bk1.updated/include/linux/workqueue.h	2004-01-07 17:56:59.000000000 +1100
@@ -60,6 +60,7 @@ extern int FASTCALL(schedule_work(struct
 extern int FASTCALL(schedule_delayed_work(struct work_struct *work, unsigned long delay));
 extern void flush_scheduled_work(void);
 extern int current_is_keventd(void);
+extern int keventd_up(void);
 
 extern void init_workqueues(void);
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16124-linux-2.6.1-rc2-bk1/kernel/Makefile .16124-linux-2.6.1-rc2-bk1.updated/kernel/Makefile
--- .16124-linux-2.6.1-rc2-bk1/kernel/Makefile	2003-10-09 18:03:02.000000000 +1000
+++ .16124-linux-2.6.1-rc2-bk1.updated/kernel/Makefile	2004-01-07 17:56:59.000000000 +1100
@@ -6,7 +6,8 @@ obj-y     = sched.o fork.o exec_domain.o
 	    exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
-	    rcupdate.o intermodule.o extable.o params.o posix-timers.o
+	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
+	    kthread.o
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16124-linux-2.6.1-rc2-bk1/kernel/kthread.c .16124-linux-2.6.1-rc2-bk1.updated/kernel/kthread.c
--- .16124-linux-2.6.1-rc2-bk1/kernel/kthread.c	1970-01-01 10:00:00.000000000 +1000
+++ .16124-linux-2.6.1-rc2-bk1.updated/kernel/kthread.c	2004-01-07 17:56:59.000000000 +1100
@@ -0,0 +1,170 @@
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
+	/* Copy data: it's on keventd's stack */
+	threadfn = create->threadfn;
+	data = create->data;
+
+	/* OK, tell user we're spawned, wait for stop or wakeup */
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
+		wait_task_inactive(create->result);
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
+	struct kthread_create_info create;
+	DECLARE_WORK(work, keventd_create_kthread, &create);
+
+	create.threadfn = threadfn;
+	create.data = data;
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
+	if (!IS_ERR(create.result)) {
+		va_list args;
+		va_start(args, namefmt);
+		vsnprintf(create.result->comm, sizeof(create.result->comm),
+			  namefmt, args);
+		va_end(args);
+	}
+
+	return create.result;
+}
+
+void kthread_bind(struct task_struct *k, unsigned int cpu)
+{
+	BUG_ON(k->state != TASK_INTERRUPTIBLE);
+	k->thread_info->cpu = cpu;
+	k->cpus_allowed = cpumask_of_cpu(cpu);
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .16124-linux-2.6.1-rc2-bk1/kernel/workqueue.c .16124-linux-2.6.1-rc2-bk1.updated/kernel/workqueue.c
--- .16124-linux-2.6.1-rc2-bk1/kernel/workqueue.c	2004-01-07 17:56:58.000000000 +1100
+++ .16124-linux-2.6.1-rc2-bk1.updated/kernel/workqueue.c	2004-01-07 17:56:59.000000000 +1100
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

Name: Use Kthread For Core Kernel Threads
Author: Rusty Russell
Status: Booted on 2.6.1-rc2-bk1
Depends: Hotcpu-New-Kthread/kthread-simple.patch.gz

D: This simply changes over the migration threads, the workqueue
D: threads and the ksoftirqd threads to use kthread.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .9505-linux-2.6.1-rc2-bk1/kernel/sched.c .9505-linux-2.6.1-rc2-bk1.updated/kernel/sched.c
--- .9505-linux-2.6.1-rc2-bk1/kernel/sched.c	2004-01-06 18:01:01.000000000 +1100
+++ .9505-linux-2.6.1-rc2-bk1.updated/kernel/sched.c	2004-01-07 16:34:26.000000000 +1100
@@ -37,6 +37,7 @@
 #include <linux/rcupdate.h>
 #include <linux/cpu.h>
 #include <linux/percpu.h>
+#include <linux/kthread.h>
 
 #ifdef CONFIG_NUMA
 #define cpu_to_node_mask(cpu) node_to_cpumask(cpu_to_node(cpu))
@@ -2640,12 +2641,6 @@ static void move_task_away(struct task_s
 	local_irq_restore(flags);
 }
 
-typedef struct {
-	int cpu;
-	struct completion startup_done;
-	task_t *task;
-} migration_startup_t;
-
 /*
  * migration_thread - this is a highprio system thread that performs
  * thread migration by bumping thread off CPU then 'pushing' onto
@@ -2655,27 +2650,17 @@ static int migration_thread(void * data)
 {
 	/* Marking "param" __user is ok, since we do a set_fs(KERNEL_DS); */
 	struct sched_param __user param = { .sched_priority = MAX_RT_PRIO-1 };
-	migration_startup_t *startup = data;
-	int cpu = startup->cpu;
 	runqueue_t *rq;
+	int cpu = (long)data;
 	int ret;
 
-	startup->task = current;
-	complete(&startup->startup_done);
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule();
-
 	BUG_ON(smp_processor_id() != cpu);
-
-	daemonize("migration/%d", cpu);
-	set_fs(KERNEL_DS);
-
 	ret = setscheduler(0, SCHED_FIFO, &param);
 
 	rq = this_rq();
-	rq->migration_thread = current;
+	BUG_ON(rq->migration_thread != current);
 
-	for (;;) {
+	while (!signal_pending(current)) {
 		struct list_head *head;
 		migration_req_t *req;
 
@@ -2698,6 +2683,7 @@ static int migration_thread(void * data)
 			       any_online_cpu(req->task->cpus_allowed));
 		complete(&req->done);
 	}
+	return 0;
 }
 
 /*
@@ -2708,36 +2694,27 @@ static int migration_call(struct notifie
 			  unsigned long action,
 			  void *hcpu)
 {
-	long cpu = (long) hcpu;
-	migration_startup_t startup;
+	int cpu = (long)hcpu;
+	struct task_struct *p;
 
 	switch (action) {
 	case CPU_ONLINE:
-
-		printk("Starting migration thread for cpu %li\n", cpu);
-
-		startup.cpu = cpu;
-		startup.task = NULL;
-		init_completion(&startup.startup_done);
-
-		kernel_thread(migration_thread, &startup, CLONE_KERNEL);
-		wait_for_completion(&startup.startup_done);
-		wait_task_inactive(startup.task);
-
-		startup.task->thread_info->cpu = cpu;
-		startup.task->cpus_allowed = cpumask_of_cpu(cpu);
-
-		wake_up_process(startup.task);
-
-		while (!cpu_rq(cpu)->migration_thread)
-			yield();
-
+		p = kthread_create(migration_thread, hcpu, "migration/%d",cpu);
+		if (IS_ERR(p))
+			return NOTIFY_BAD;
+		kthread_bind(p, cpu);
+		cpu_rq(cpu)->migration_thread = p;
+		wake_up_process(p);
 		break;
 	}
 	return NOTIFY_OK;
 }
 
-static struct notifier_block migration_notifier = { &migration_call, NULL, 0 };
+/* Want this before the other threads, so they can use set_cpus_allowed. */
+static struct notifier_block __devinitdata migration_notifier = { 
+	.notifier_call = migration_call,
+	.priority = 10,
+};
 
 __init int migration_init(void)
 {
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .9505-linux-2.6.1-rc2-bk1/kernel/softirq.c .9505-linux-2.6.1-rc2-bk1.updated/kernel/softirq.c
--- .9505-linux-2.6.1-rc2-bk1/kernel/softirq.c	2003-10-09 18:03:02.000000000 +1000
+++ .9505-linux-2.6.1-rc2-bk1.updated/kernel/softirq.c	2004-01-07 16:36:34.000000000 +1100
@@ -14,6 +14,7 @@
 #include <linux/notifier.h>
 #include <linux/percpu.h>
 #include <linux/cpu.h>
+#include <linux/kthread.h>
 
 /*
    - No shared variables, all the data are CPU local.
@@ -337,20 +338,14 @@ static int ksoftirqd(void * __bind_cpu)
 {
 	int cpu = (int) (long) __bind_cpu;
 
-	daemonize("ksoftirqd/%d", cpu);
 	set_user_nice(current, 19);
 	current->flags |= PF_IOTHREAD;
 
-	/* Migrate to the right CPU */
-	set_cpus_allowed(current, cpumask_of_cpu(cpu));
 	BUG_ON(smp_processor_id() != cpu);
 
-	__set_current_state(TASK_INTERRUPTIBLE);
-	mb();
-
-	__get_cpu_var(ksoftirqd) = current;
+	set_current_state(TASK_INTERRUPTIBLE);
 
-	for (;;) {
+	while (!signal_pending(current)) {
 		if (!local_softirq_pending())
 			schedule();
 
@@ -363,6 +358,7 @@ static int ksoftirqd(void * __bind_cpu)
 
 		__set_current_state(TASK_INTERRUPTIBLE);
 	}
+	return 0;
 }
 
 static int __devinit cpu_callback(struct notifier_block *nfb,
@@ -370,15 +366,17 @@ static int __devinit cpu_callback(struct
 				  void *hcpu)
 {
 	int hotcpu = (unsigned long)hcpu;
+	struct task_struct *p;
 
 	if (action == CPU_ONLINE) {
-		if (kernel_thread(ksoftirqd, hcpu, CLONE_KERNEL) < 0) {
+		p = kthread_create(ksoftirqd, hcpu, "ksoftirqd/%d", hotcpu);
+		if (IS_ERR(p)) {
 			printk("ksoftirqd for %i failed\n", hotcpu);
 			return NOTIFY_BAD;
 		}
-
-		while (!per_cpu(ksoftirqd, hotcpu))
-			yield();
+		per_cpu(ksoftirqd, hotcpu) = p;
+		kthread_bind(p, hotcpu);
+		wake_up_process(p);
  	}
 	return NOTIFY_OK;
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .9505-linux-2.6.1-rc2-bk1/kernel/workqueue.c .9505-linux-2.6.1-rc2-bk1.updated/kernel/workqueue.c
--- .9505-linux-2.6.1-rc2-bk1/kernel/workqueue.c	2004-01-07 16:33:53.000000000 +1100
+++ .9505-linux-2.6.1-rc2-bk1.updated/kernel/workqueue.c	2004-01-07 16:35:27.000000000 +1100
@@ -22,6 +22,7 @@
 #include <linux/completion.h>
 #include <linux/workqueue.h>
 #include <linux/slab.h>
+#include <linux/kthread.h>
 
 /*
  * The per-CPU workqueue.
@@ -45,7 +46,6 @@ struct cpu_workqueue_struct {
 
 	struct workqueue_struct *wq;
 	task_t *thread;
-	struct completion exit;
 
 } ____cacheline_aligned;
 
@@ -153,28 +152,23 @@ static inline void run_workqueue(struct 
 	spin_unlock_irqrestore(&cwq->lock, flags);
 }
 
-typedef struct startup_s {
-	struct cpu_workqueue_struct *cwq;
-	struct completion done;
-	const char *name;
-} startup_t;
-
-static int worker_thread(void *__startup)
+static int worker_thread(void *__cwq)
 {
-	startup_t *startup = __startup;
-	struct cpu_workqueue_struct *cwq = startup->cwq;
+	struct cpu_workqueue_struct *cwq = __cwq;
 	int cpu = cwq - cwq->wq->cpu_wq;
 	DECLARE_WAITQUEUE(wait, current);
 	struct k_sigaction sa;
+	sigset_t blocked;
 
-	daemonize("%s/%d", startup->name, cpu);
 	current->flags |= PF_IOTHREAD;
-	cwq->thread = current;
 
 	set_user_nice(current, -10);
-	set_cpus_allowed(current, cpumask_of_cpu(cpu));
+	BUG_ON(smp_processor_id() != cpu);
 
-	complete(&startup->done);
+	/* Block and flush all signals */
+	sigfillset(&blocked);
+	sigprocmask(SIG_BLOCK, &blocked, NULL);
+	flush_signals(current);
 
 	/* SIG_IGN makes children autoreap: see do_notify_parent(). */
 	sa.sa.sa_handler = SIG_IGN;
@@ -182,12 +176,10 @@ static int worker_thread(void *__startup
 	siginitset(&sa.sa.sa_mask, sigmask(SIGCHLD));
 	do_sigaction(SIGCHLD, &sa, (struct k_sigaction *)0);
 
-	for (;;) {
+	while (!signal_pending(current)) {
 		set_task_state(current, TASK_INTERRUPTIBLE);
 
 		add_wait_queue(&cwq->more_work, &wait);
-		if (!cwq->thread)
-			break;
 		if (list_empty(&cwq->worklist))
 			schedule();
 		else
@@ -197,9 +189,6 @@ static int worker_thread(void *__startup
 		if (!list_empty(&cwq->worklist))
 			run_workqueue(cwq);
 	}
-	remove_wait_queue(&cwq->more_work, &wait);
-	complete(&cwq->exit);
-
 	return 0;
 }
 
@@ -251,9 +240,8 @@ static int create_workqueue_thread(struc
 				   const char *name,
 				   int cpu)
 {
-	startup_t startup;
 	struct cpu_workqueue_struct *cwq = wq->cpu_wq + cpu;
-	int ret;
+	struct task_struct *p;
 
 	spin_lock_init(&cwq->lock);
 	cwq->wq = wq;
@@ -263,17 +251,13 @@ static int create_workqueue_thread(struc
 	INIT_LIST_HEAD(&cwq->worklist);
 	init_waitqueue_head(&cwq->more_work);
 	init_waitqueue_head(&cwq->work_done);
-	init_completion(&cwq->exit);
 
-	init_completion(&startup.done);
-	startup.cwq = cwq;
-	startup.name = name;
-	ret = kernel_thread(worker_thread, &startup, CLONE_FS | CLONE_FILES);
-	if (ret >= 0) {
-		wait_for_completion(&startup.done);
-		BUG_ON(!cwq->thread);
-	}
-	return ret;
+	p = kthread_create(worker_thread, cwq, "%s/%d", name, cpu);
+	if (IS_ERR(p))
+		return PTR_ERR(p);
+	cwq->thread = p;
+	kthread_bind(p, cpu);
+	return 0;
 }
 
 struct workqueue_struct *create_workqueue(const char *name)
@@ -292,6 +276,8 @@ struct workqueue_struct *create_workqueu
 			continue;
 		if (create_workqueue_thread(wq, name, cpu) < 0)
 			destroy = 1;
+		else
+			wake_up_process(wq->cpu_wq[cpu].thread);
 	}
 	/*
 	 * Was there any error during startup? If yes then clean up:
@@ -308,13 +294,8 @@ static void cleanup_workqueue_thread(str
 	struct cpu_workqueue_struct *cwq;
 
 	cwq = wq->cpu_wq + cpu;
-	if (cwq->thread) {
-		/* Tell thread to exit and wait for it. */
-		cwq->thread = NULL;
-		wake_up(&cwq->more_work);
-
-		wait_for_completion(&cwq->exit);
-	}
+	if (cwq->thread)
+		kthread_stop(cwq->thread);
 }
 
 void destroy_workqueue(struct workqueue_struct *wq)
