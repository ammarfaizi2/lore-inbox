Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266108AbTLaEVK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 23:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266111AbTLaEVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 23:21:10 -0500
Received: from dp.samba.org ([66.70.73.150]:13210 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266108AbTLaEUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 23:20:19 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@osdl.org, akpm@osdl.org
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Use kthread primitives
Date: Wed, 31 Dec 2003 15:17:58 +1100
Message-Id: <20031231042016.A68802C079@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And this is the patch actually uses the kthread primitives,
simplifying and shrinking the code a little bit.

Name: Use Kthread For Core Kernel Threads
Author: Rusty Russell
Status: Tested on 2.6.0-bk3
Depends: Hotcpu/kthread.patch.gz

D: This simply changes over the migration threads, the workqueue
D: threads and the ksoftirqd threads to use kthread.
D: 
D: Changes:
D:  - kernel/sched.c: Split migration_thread() into
D:    migration_kthread_init() and migration_kthread() for use with
D:    kthread.  Simplifies startup greatly.
D:    - No need for migration_startup_t.
D: 
D:  - kernel/softirq.c: Split ksoftirqd() into ksoftirqd_init() and
D:    ksoftirqd(). 
D: 
D:  - kernel/workqueue.c: Split worker_thread() into worker_thread_init()
D:    and worker_thread(). 
D:    - Change waitqueue to task pointer (we need it anyway, and there's
D:      always only one).
D:    - Remove exit completion (kthread_destroy handles that for us).
D:    - Make create_workqueue_thread() return a task struct directly,
D:      since kthread_create gives us that without needing to use
D:      a structure for the thread to put it in.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27587-2.6.0-bk3-use-kthread.pre/kernel/sched.c .27587-2.6.0-bk3-use-kthread/kernel/sched.c
--- .27587-2.6.0-bk3-use-kthread.pre/kernel/sched.c	2003-12-31 10:04:41.000000000 +1100
+++ .27587-2.6.0-bk3-use-kthread/kernel/sched.c	2003-12-31 14:17:42.000000000 +1100
@@ -37,6 +37,7 @@
 #include <linux/rcupdate.h>
 #include <linux/cpu.h>
 #include <linux/percpu.h>
+#include <linux/kthread.h>
 
 #ifdef CONFIG_NUMA
 #define cpu_to_node_mask(cpu) node_to_cpumask(cpu_to_node(cpu))
@@ -2640,64 +2641,54 @@ static void move_task_away(struct task_s
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
  * another runqueue.
  */
-static int migration_thread(void * data)
+static int migration_kthread_init(void *data)
 {
 	/* Marking "param" __user is ok, since we do a set_fs(KERNEL_DS); */
 	struct sched_param __user param = { .sched_priority = MAX_RT_PRIO-1 };
-	migration_startup_t *startup = data;
-	int cpu = startup->cpu;
-	runqueue_t *rq;
-	int ret;
-
-	startup->task = current;
-	complete(&startup->startup_done);
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule();
+	unsigned int cpu = (long)data;
 
 	BUG_ON(smp_processor_id() != cpu);
 
-	daemonize("migration/%d", cpu);
 	set_fs(KERNEL_DS);
 
-	ret = setscheduler(0, SCHED_FIFO, &param);
-
-	rq = this_rq();
-	rq->migration_thread = current;
+	setscheduler(0, SCHED_FIFO, &param);
+	return 0;
+}
 
-	for (;;) {
-		struct list_head *head;
-		migration_req_t *req;
+static int migration_kthread(void *data)
+{
+	runqueue_t *rq;
+	struct list_head *head;
+	migration_req_t *req;
 
-		if (current->flags & PF_FREEZE)
-			refrigerator(PF_IOTHREAD);
+	rq = this_rq();
 
-		spin_lock_irq(&rq->lock);
-		head = &rq->migration_queue;
-		current->state = TASK_INTERRUPTIBLE;
-		if (list_empty(head)) {
-			spin_unlock_irq(&rq->lock);
-			schedule();
-			continue;
-		}
+	spin_lock_irq(&rq->lock);
+	head = &rq->migration_queue;
+	while (!list_empty(head)) {
 		req = list_entry(head->next, migration_req_t, list);
 		list_del_init(head->next);
-		spin_unlock_irq(&rq->lock);
 
+		spin_unlock_irq(&rq->lock);
 		move_task_away(req->task,
 			       any_online_cpu(req->task->cpus_allowed));
 		complete(&req->done);
+		spin_lock_irq(&rq->lock);
+		current->state = TASK_INTERRUPTIBLE;
 	}
+	current->state = TASK_INTERRUPTIBLE;
+	spin_unlock_irq(&rq->lock);
+
+	/* FIXME: Should this be in kthread.c? --RR */
+	if (current->flags & PF_FREEZE)
+		refrigerator(PF_IOTHREAD);
+
+	return 0;
 }
 
 /*
@@ -2709,35 +2700,31 @@ static int migration_call(struct notifie
 			  void *hcpu)
 {
 	long cpu = (long) hcpu;
-	migration_startup_t startup;
+	struct task_struct *p;
 
 	switch (action) {
 	case CPU_ONLINE:
-
 		printk("Starting migration thread for cpu %li\n", cpu);
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
+		p = kthread_create(migration_kthread_init, migration_kthread,
+				   hcpu, "migration/%ld", cpu);
+		if (IS_ERR(p))
+			return NOTIFY_BAD;
+		/* Manually bind to CPU: thread stopped, so this is OK. */
+		p->thread_info->cpu = cpu;
+		p->cpus_allowed = cpumask_of_cpu(cpu);
+		if (IS_ERR(kthread_start(p)))
+			return NOTIFY_BAD;
+		cpu_rq(cpu)->migration_thread = p;
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27587-2.6.0-bk3-use-kthread.pre/kernel/softirq.c .27587-2.6.0-bk3-use-kthread/kernel/softirq.c
--- .27587-2.6.0-bk3-use-kthread.pre/kernel/softirq.c	2003-10-09 18:03:02.000000000 +1000
+++ .27587-2.6.0-bk3-use-kthread/kernel/softirq.c	2003-12-31 14:17:42.000000000 +1100
@@ -14,6 +14,7 @@
 #include <linux/notifier.h>
 #include <linux/percpu.h>
 #include <linux/cpu.h>
+#include <linux/kthread.h>
 
 /*
    - No shared variables, all the data are CPU local.
@@ -333,36 +334,30 @@ void __init softirq_init(void)
 	register_cpu_notifier(&tasklet_nb);
 }
 
-static int ksoftirqd(void * __bind_cpu)
+static int ksoftirqd_init(void *__bind_cpu)
 {
-	int cpu = (int) (long) __bind_cpu;
-
-	daemonize("ksoftirqd/%d", cpu);
-	set_user_nice(current, 19);
-	current->flags |= PF_IOTHREAD;
+	unsigned int cpu = (long) __bind_cpu;
 
 	/* Migrate to the right CPU */
 	set_cpus_allowed(current, cpumask_of_cpu(cpu));
 	BUG_ON(smp_processor_id() != cpu);
 
-	__set_current_state(TASK_INTERRUPTIBLE);
-	mb();
-
-	__get_cpu_var(ksoftirqd) = current;
-
-	for (;;) {
-		if (!local_softirq_pending())
-			schedule();
-
-		__set_current_state(TASK_RUNNING);
-
-		while (local_softirq_pending()) {
-			do_softirq();
-			cond_resched();
-		}
+	set_user_nice(current, 19);
+	current->flags |= PF_IOTHREAD;
+	return 0;
+}
 
-		__set_current_state(TASK_INTERRUPTIBLE);
+static int ksoftirqd(void *__bind_cpu)
+{
+again:
+	set_current_state(TASK_INTERRUPTIBLE);
+	if (local_softirq_pending()) {
+		current->state = TASK_RUNNING;
+		do_softirq();
+		cond_resched();
+		goto again;
 	}
+	return 0;
 }
 
 static int __devinit cpu_callback(struct notifier_block *nfb,
@@ -370,15 +365,16 @@ static int __devinit cpu_callback(struct
 				  void *hcpu)
 {
 	int hotcpu = (unsigned long)hcpu;
+	struct task_struct *p;
 
 	if (action == CPU_ONLINE) {
-		if (kernel_thread(ksoftirqd, hcpu, CLONE_KERNEL) < 0) {
+		p = kthread_run(ksoftirqd_init, ksoftirqd, hcpu,
+				"ksoftirqd/%d", hotcpu);
+		if (IS_ERR(p)) {
 			printk("ksoftirqd for %i failed\n", hotcpu);
 			return NOTIFY_BAD;
 		}
-
-		while (!per_cpu(ksoftirqd, hotcpu))
-			yield();
+		per_cpu(ksoftirqd, hotcpu) = p;
  	}
 	return NOTIFY_OK;
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27587-2.6.0-bk3-use-kthread.pre/kernel/workqueue.c .27587-2.6.0-bk3-use-kthread/kernel/workqueue.c
--- .27587-2.6.0-bk3-use-kthread.pre/kernel/workqueue.c	2003-12-31 14:17:42.000000000 +1100
+++ .27587-2.6.0-bk3-use-kthread/kernel/workqueue.c	2003-12-31 14:17:42.000000000 +1100
@@ -25,6 +25,7 @@
 #include <linux/completion.h>
 #include <linux/workqueue.h>
 #include <linux/slab.h>
+#include <linux/kthread.h>
 
 /*
  * The per-CPU workqueue.
@@ -43,13 +44,10 @@ struct cpu_workqueue_struct {
 	long insert_sequence;	/* Next to add */
 
 	struct list_head worklist;
-	wait_queue_head_t more_work;
+	struct task_struct *worker;
 	wait_queue_head_t work_done;
 
 	struct workqueue_struct *wq;
-	task_t *thread;
-	struct completion exit;
-
 } ____cacheline_aligned;
 
 /*
@@ -80,7 +78,7 @@ int queue_work(struct workqueue_struct *
 		spin_lock_irqsave(&cwq->lock, flags);
 		list_add_tail(&work->entry, &cwq->worklist);
 		cwq->insert_sequence++;
-		wake_up(&cwq->more_work);
+		wake_up_process(cwq->worker);
 		spin_unlock_irqrestore(&cwq->lock, flags);
 		ret = 1;
 	}
@@ -101,7 +99,7 @@ static void delayed_work_timer_fn(unsign
 	spin_lock_irqsave(&cwq->lock, flags);
 	list_add_tail(&work->entry, &cwq->worklist);
 	cwq->insert_sequence++;
-	wake_up(&cwq->more_work);
+	wake_up_process(cwq->worker);
 	spin_unlock_irqrestore(&cwq->lock, flags);
 }
 
@@ -127,6 +125,27 @@ int queue_delayed_work(struct workqueue_
 	return ret;
 }
 
+static int worker_thread_init(void *__cwq)
+{
+	struct k_sigaction sa;
+	struct cpu_workqueue_struct *cwq = __cwq;
+	int cpu = cwq - cwq->wq->cpu_wq;
+
+	set_cpus_allowed(current, cpumask_of_cpu(cpu));
+	BUG_ON(smp_processor_id() != cpu);
+
+	allow_signal(SIGCHLD);
+	current->flags |= PF_IOTHREAD;
+	set_user_nice(current, -10);
+
+	/* Install a handler so SIGCLD is delivered */
+	sa.sa.sa_handler = SIG_IGN;
+	sa.sa.sa_flags = 0;
+	siginitset(&sa.sa.sa_mask, sigmask(SIGCHLD));
+	do_sigaction(SIGCHLD, &sa, (struct k_sigaction *)0);
+	return 0;
+}
+
 static inline void run_workqueue(struct cpu_workqueue_struct *cwq)
 {
 	unsigned long flags;
@@ -153,65 +172,22 @@ static inline void run_workqueue(struct 
 		cwq->remove_sequence++;
 		wake_up(&cwq->work_done);
 	}
+	current->state = TASK_INTERRUPTIBLE;
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
-	int cpu = cwq - cwq->wq->cpu_wq;
-	DECLARE_WAITQUEUE(wait, current);
-	struct k_sigaction sa;
-
-	daemonize("%s/%d", startup->name, cpu);
-	allow_signal(SIGCHLD);
-	current->flags |= PF_IOTHREAD;
-	cwq->thread = current;
-
-	set_user_nice(current, -10);
-	set_cpus_allowed(current, cpumask_of_cpu(cpu));
-
-	complete(&startup->done);
-
-	/* Install a handler so SIGCLD is delivered */
-	sa.sa.sa_handler = SIG_IGN;
-	sa.sa.sa_flags = 0;
-	siginitset(&sa.sa.sa_mask, sigmask(SIGCHLD));
-	do_sigaction(SIGCHLD, &sa, (struct k_sigaction *)0);
-
-	for (;;) {
-		set_task_state(current, TASK_INTERRUPTIBLE);
-
-		add_wait_queue(&cwq->more_work, &wait);
-		if (!cwq->thread)
-			break;
-		if (list_empty(&cwq->worklist))
-			schedule();
-		else
-			set_task_state(current, TASK_RUNNING);
-		remove_wait_queue(&cwq->more_work, &wait);
-
-		if (!list_empty(&cwq->worklist))
-			run_workqueue(cwq);
+	struct cpu_workqueue_struct *cwq = __cwq;
 
-		if (signal_pending(current)) {
-			while (waitpid(-1, NULL, __WALL|WNOHANG) > 0)
-				/* SIGCHLD - auto-reaping */ ;
+	if (signal_pending(current)) {
+		while (waitpid(-1, NULL, __WALL|WNOHANG) > 0)
+			/* SIGCHLD - auto-reaping */ ;
 
-			/* zap all other signals */
-			flush_signals(current);
-		}
+		/* zap all other signals */
+		flush_signals(current);
 	}
-	remove_wait_queue(&cwq->more_work, &wait);
-	complete(&cwq->exit);
-
+	run_workqueue(cwq);
 	return 0;
 }
 
@@ -259,39 +235,33 @@ void flush_workqueue(struct workqueue_st
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
-	cwq->thread = NULL;
+	cwq->worker = NULL;
 	cwq->insert_sequence = 0;
 	cwq->remove_sequence = 0;
 	INIT_LIST_HEAD(&cwq->worklist);
-	init_waitqueue_head(&cwq->more_work);
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
+	p = kthread_create(worker_thread_init, worker_thread, cwq, 
+			   "%s/%d", name, cpu);
+	if (!IS_ERR(p))
+		cwq->worker = p;
+	return p;
 }
 
 struct workqueue_struct *create_workqueue(const char *name)
 {
 	int cpu, destroy = 0;
 	struct workqueue_struct *wq;
+	struct task_struct *p;
 
 	BUG_ON(strlen(name) > 10);
 
@@ -302,8 +272,12 @@ struct workqueue_struct *create_workqueu
 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
 		if (!cpu_online(cpu))
 			continue;
-		if (create_workqueue_thread(wq, name, cpu) < 0)
+		p = create_workqueue_thread(wq, name, cpu);
+		if (IS_ERR(p))
 			destroy = 1;
+		else
+			kthread_start(p);
+
 	}
 	/*
 	 * Was there any error during startup? If yes then clean up:
@@ -320,13 +294,8 @@ static void cleanup_workqueue_thread(str
 	struct cpu_workqueue_struct *cwq;
 
 	cwq = wq->cpu_wq + cpu;
-	if (cwq->thread) {
-		/* Tell thread to exit and wait for it. */
-		cwq->thread = NULL;
-		wake_up(&cwq->more_work);
-
-		wait_for_completion(&cwq->exit);
-	}
+	if (cwq->worker)
+		kthread_destroy(cwq->worker);
 }
 
 void destroy_workqueue(struct workqueue_struct *wq)
@@ -375,7 +344,7 @@ int current_is_keventd(void)
 		if (!cpu_online(cpu))
 			continue;
 		cwq = keventd_wq->cpu_wq + cpu;
-		if (current == cwq->thread)
+		if (current == cwq->worker)
 			return 1;
 	}
 	return 0;

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
