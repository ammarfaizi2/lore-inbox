Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266099AbUAFILc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 03:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266097AbUAFIKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 03:10:53 -0500
Received: from dp.samba.org ([66.70.73.150]:37037 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266096AbUAFIJm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 03:09:42 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: akpm@osdl.org, Davide Libenzi <davidel@xmailserver.org>
Cc: mingo@redhat.com, jgarzik@pobox.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] Second Coming of Kthread: Using kthread
Date: Tue, 06 Jan 2004 19:05:59 +1100
Message-Id: <20040106080939.8ACEE2C04F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And this patch is *much* simpler than the previous version, since the
kthread semantics are so close to kernel_thread.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Use Kthread For Core Kernel Threads
Author: Rusty Russell
Status: Tested on 2.6.1-rc1-bk6
Depends: Hotcpu-New-Kthread/kthread-simple.patch.gz

D: This simply changes over the migration threads, the workqueue
D: threads and the ksoftirqd threads to use kthread.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .764-linux-2.6.1-rc2/kernel/sched.c .764-linux-2.6.1-rc2.updated/kernel/sched.c
--- .764-linux-2.6.1-rc2/kernel/sched.c	2004-01-06 18:01:01.000000000 +1100
+++ .764-linux-2.6.1-rc2.updated/kernel/sched.c	2004-01-06 18:54:52.000000000 +1100
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
@@ -2708,36 +2694,28 @@ static int migration_call(struct notifie
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
+		p->thread_info->cpu = cpu;
+		p->cpus_allowed = cpumask_of_cpu(cpu);
+		cpu_rq(cpu)->migration_thread = p;
+		kthread_start(p);
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .764-linux-2.6.1-rc2/kernel/softirq.c .764-linux-2.6.1-rc2.updated/kernel/softirq.c
--- .764-linux-2.6.1-rc2/kernel/softirq.c	2003-10-09 18:03:02.000000000 +1000
+++ .764-linux-2.6.1-rc2.updated/kernel/softirq.c	2004-01-06 18:54:52.000000000 +1100
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
+		set_cpus_allowed(p, cpumask_of_cpu(hotcpu));
+		kthread_start(p);
+		per_cpu(ksoftirqd, hotcpu) = p;
  	}
 	return NOTIFY_OK;
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .764-linux-2.6.1-rc2/kernel/workqueue.c .764-linux-2.6.1-rc2.updated/kernel/workqueue.c
--- .764-linux-2.6.1-rc2/kernel/workqueue.c	2004-01-06 18:54:51.000000000 +1100
+++ .764-linux-2.6.1-rc2.updated/kernel/workqueue.c	2004-01-06 18:54:52.000000000 +1100
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
 
@@ -120,7 +120,6 @@ int queue_delayed_work(struct workqueue_
 		add_timer(timer);
 		ret = 1;
 	}
-	put_cpu();
 	return ret;
 }
 
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
 	set_cpus_allowed(current, cpumask_of_cpu(cpu));
 
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
 
@@ -247,13 +236,12 @@ void flush_workqueue(struct workqueue_st
 	}
 }
 
-static int create_workqueue_thread(struct workqueue_struct *wq,
-				   const char *name,
-				   int cpu)
+static struct task_struct *create_workqueue_thread(struct workqueue_struct *wq,
+						   const char *name,
+						   int cpu)
 {
-	startup_t startup;
 	struct cpu_workqueue_struct *cwq = wq->cpu_wq + cpu;
-	int ret;
+	struct task_struct *p;
 
 	spin_lock_init(&cwq->lock);
 	cwq->wq = wq;
@@ -263,23 +251,18 @@ static int create_workqueue_thread(struc
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
+	if (!IS_ERR(p))
+		cwq->thread = p;
+	return p;
 }
 
 struct workqueue_struct *create_workqueue(const char *name)
 {
 	int cpu, destroy = 0;
 	struct workqueue_struct *wq;
+	struct task_struct *p;
 
 	BUG_ON(strlen(name) > 10);
 
@@ -290,8 +273,11 @@ struct workqueue_struct *create_workqueu
 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
 		if (!cpu_online(cpu))
 			continue;
-		if (create_workqueue_thread(wq, name, cpu) < 0)
+		p = create_workqueue_thread(wq, name, cpu);
+		if (IS_ERR(p))
 			destroy = 1;
+		else
+			kthread_start(p);
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
