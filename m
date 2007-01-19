Return-Path: <linux-kernel-owner+w=401wt.eu-S964794AbXASDNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbXASDNZ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 22:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbXASDNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 22:13:25 -0500
Received: from mail.screens.ru ([213.234.233.54]:48169 "EHLO mail.screens.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964794AbXASDNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 22:13:24 -0500
Date: Fri, 19 Jan 2007 06:11:42 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Cc: Srivatsa Vaddagiri <vatsa@in.ibm.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Gautham shenoy <ego@in.ibm.com>, David Howells <dhowells@redhat.com>,
       David Woodhouse <dwmw2@infradead.org>, "Theodore Ts'o" <tytso@mit.edu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: [RFC, PATCH] workqueue: rework threads/hotplug management
Message-ID: <20070119031142.GA925@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(to apply this patch,
 handle-cpu_lock_acquire-and-cpu_lock_release-in-workqueue_cpu_callback.patch
 should be dropped, it is not needed any longer).

With this patch workqueue_mutex is used only to protect workqueues list,
all workqueue operations can run in parallel with cpuhotplug callback path.
take_over_work(), migrate_sequence, CPU_LOCK_ACQUIRE/RELEASE go away.

CPU_DEAD just sets cwq->should_stop and returns. After that cwq->thread runs
unbound until it flushes cwq->worklist, then exits. So this patch slightly
increases the probability that work_struct will be processed by the "wrong"
CPU, but we can't avoid this with CONFIG_HOTPLUG_CPU anyway.

CPU_UP_PREPARE creates the new cwq->thread if it's not NULL, CPU_ONLINE binds
it to the new cpu.

This all greatly simplifies the workqueues/cpu-hotplug interaction and imho
makes the code better. Shrinks both the source and compiled code (430 bytes).
In particular, we can take workqueue_mutex in work->func() or create/destroy
workqueues from the cpuhotplug callback path.

The ugly part of this patch is that it adds "static int embryonic_cpu", it's
used by __create_workqueue() when it runs between CPU_UP_PREPARE/CPU_ONLINE.

cpu_populated_map was introduced to optimize for_each_possible_cpu(), it is
not strictly needed, and it is more a documentation in fact.

Further possible changes:

	- don't use kthread_create(), we don't use kthread_stop()

	- don't do kthread_bind() when create_workqueue_thread()
	  is called by CPU_UP_PREPARE, this is noop because of the
	  wake_up_process() below.

	- make cpu_populated_map per workqueue_struct, this allows
	  us to remove some "is_single_threaded(wq)" checks, and we
	  can clear the bit when cwq->thread exits.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- WQ/kernel/workqueue.c~1_rework	2007-01-19 05:01:53.000000000 +0300
+++ WQ/kernel/workqueue.c	2007-01-19 05:04:13.000000000 +0300
@@ -43,10 +43,11 @@ struct cpu_workqueue_struct {
 
 	struct list_head worklist;
 	wait_queue_head_t more_work;
+	struct work_struct *current_work;
 
 	struct workqueue_struct *wq;
 	struct task_struct *thread;
-	struct work_struct *current_work;
+	int should_stop;
 
 	int run_depth;		/* Detect run_workqueue() recursion depth */
 } ____cacheline_aligned;
@@ -64,11 +65,10 @@ struct workqueue_struct {
 
 /* All the per-cpu workqueues on the system, for hotplug cpu to add/remove
    threads to each one as cpus come/go. */
-static long migrate_sequence __read_mostly;
 static DEFINE_MUTEX(workqueue_mutex);
 static LIST_HEAD(workqueues);
 
-static int singlethread_cpu;
+static int singlethread_cpu __read_mostly;
 
 /* If it's single threaded, it isn't in the list of workqueues. */
 static inline int is_single_threaded(struct workqueue_struct *wq)
@@ -343,10 +343,28 @@ static void run_workqueue(struct cpu_wor
 	spin_unlock_irqrestore(&cwq->lock, flags);
 }
 
+/*
+ * NOTE: the caller must not touch *cwq if this func returns true
+ */
+static inline int cwq_should_stop(struct cpu_workqueue_struct *cwq)
+{
+	int should_stop = cwq->should_stop;
+
+	if (unlikely(should_stop)) {
+		spin_lock_irq(&cwq->lock);
+		should_stop = cwq->should_stop && list_empty(&cwq->worklist);
+		if (should_stop)
+			cwq->thread = NULL;
+		spin_unlock_irq(&cwq->lock);
+	}
+
+	return should_stop;
+}
+
 static int worker_thread(void *__cwq)
 {
 	struct cpu_workqueue_struct *cwq = __cwq;
-	DECLARE_WAITQUEUE(wait, current);
+	DEFINE_WAIT(wait);
 	struct k_sigaction sa;
 	sigset_t blocked;
 
@@ -372,23 +390,21 @@ static int worker_thread(void *__cwq)
 	siginitset(&sa.sa.sa_mask, sigmask(SIGCHLD));
 	do_sigaction(SIGCHLD, &sa, (struct k_sigaction *)0);
 
-	set_current_state(TASK_INTERRUPTIBLE);
-	while (!kthread_should_stop()) {
-		if (cwq->wq->freezeable)
-			try_to_freeze();
-
-		add_wait_queue(&cwq->more_work, &wait);
-		if (list_empty(&cwq->worklist))
-			schedule();
-		else
-			__set_current_state(TASK_RUNNING);
-		remove_wait_queue(&cwq->more_work, &wait);
-
-		if (!list_empty(&cwq->worklist))
-			run_workqueue(cwq);
-		set_current_state(TASK_INTERRUPTIBLE);
-	}
-	__set_current_state(TASK_RUNNING);
+	for (;;) {
+		if (cwq->wq->freezeable)
+			try_to_freeze();
+
+		prepare_to_wait(&cwq->more_work, &wait, TASK_INTERRUPTIBLE);
+		if (!cwq->should_stop && list_empty(&cwq->worklist))
+			schedule();
+		finish_wait(&cwq->more_work, &wait);
+
+		if (cwq_should_stop(cwq))
+			break;
+
+		run_workqueue(cwq);
+	}
+
 	return 0;
 }
 
@@ -414,6 +430,9 @@ static void insert_wq_barrier(struct cpu
 	insert_work(cwq, &barr->work, tail);
 }
 
+/* optimization, we could use cpu_possible_map */
+static cpumask_t cpu_populated_map __read_mostly;
+
 static void flush_cpu_workqueue(struct cpu_workqueue_struct *cwq)
 {
 	if (cwq->thread == current) {
@@ -453,20 +472,13 @@ static void flush_cpu_workqueue(struct c
  */
 void fastcall flush_workqueue(struct workqueue_struct *wq)
 {
-	if (is_single_threaded(wq)) {
-		/* Always use first cpu's area. */
+	if (is_single_threaded(wq))
 		flush_cpu_workqueue(per_cpu_ptr(wq->cpu_wq, singlethread_cpu));
-	} else {
-		long sequence;
+	else {
 		int cpu;
-again:
-		sequence = migrate_sequence;
 
-		for_each_possible_cpu(cpu)
+		for_each_cpu_mask(cpu, cpu_populated_map)
 			flush_cpu_workqueue(per_cpu_ptr(wq->cpu_wq, cpu));
-
-		if (unlikely(sequence != migrate_sequence))
-			goto again;
 	}
 }
 EXPORT_SYMBOL_GPL(flush_workqueue);
@@ -484,11 +496,8 @@ static void wait_on_work(struct cpu_work
 	}
 	spin_unlock_irq(&cwq->lock);
 
-	if (unlikely(running)) {
-		mutex_unlock(&workqueue_mutex);
+	if (unlikely(running))
 		wait_for_completion(&barr.done);
-		mutex_lock(&workqueue_mutex);
-	}
 }
 
 /**
@@ -509,155 +518,31 @@ void flush_work(struct workqueue_struct 
 {
 	struct cpu_workqueue_struct *cwq;
 
-	mutex_lock(&workqueue_mutex);
 	cwq = get_wq_data(work);
 	/* Was it ever queued ? */
 	if (!cwq)
-		goto out;
+		return;
 
 	/*
-	 * This work can't be re-queued, and the lock above protects us
-	 * from take_over_work(), no need to re-check that get_wq_data()
-	 * is still the same when we take cwq->lock.
+	 * This work can't be re-queued, no need to re-check that
+	 * get_wq_data() is still the same when we take cwq->lock.
 	 */
 	spin_lock_irq(&cwq->lock);
 	list_del_init(&work->entry);
 	work_release(work);
 	spin_unlock_irq(&cwq->lock);
 
-	if (is_single_threaded(wq)) {
-		/* Always use first cpu's area. */
+	if (is_single_threaded(wq))
 		wait_on_work(per_cpu_ptr(wq->cpu_wq, singlethread_cpu), work);
-	} else {
+	else {
 		int cpu;
 
-		for_each_online_cpu(cpu)
+		for_each_cpu_mask(cpu, cpu_populated_map)
 			wait_on_work(per_cpu_ptr(wq->cpu_wq, cpu), work);
 	}
-out:
-	mutex_unlock(&workqueue_mutex);
 }
 EXPORT_SYMBOL_GPL(flush_work);
 
-static void init_cpu_workqueue(struct workqueue_struct *wq, int cpu)
-{
-	struct cpu_workqueue_struct *cwq = per_cpu_ptr(wq->cpu_wq, cpu);
-
-	cwq->wq = wq;
-	spin_lock_init(&cwq->lock);
-	INIT_LIST_HEAD(&cwq->worklist);
-	init_waitqueue_head(&cwq->more_work);
-}
-
-static struct task_struct *create_workqueue_thread(struct workqueue_struct *wq,
-							int cpu)
-{
-	struct cpu_workqueue_struct *cwq = per_cpu_ptr(wq->cpu_wq, cpu);
-	struct task_struct *p;
-
-	if (is_single_threaded(wq))
-		p = kthread_create(worker_thread, cwq, "%s", wq->name);
-	else
-		p = kthread_create(worker_thread, cwq, "%s/%d", wq->name, cpu);
-	if (IS_ERR(p))
-		return NULL;
-	cwq->thread = p;
-	return p;
-}
-
-struct workqueue_struct *__create_workqueue(const char *name,
-					    int singlethread, int freezeable)
-{
-	int cpu, destroy = 0;
-	struct workqueue_struct *wq;
-	struct task_struct *p;
-
-	wq = kzalloc(sizeof(*wq), GFP_KERNEL);
-	if (!wq)
-		return NULL;
-
-	wq->cpu_wq = alloc_percpu(struct cpu_workqueue_struct);
-	if (!wq->cpu_wq) {
-		kfree(wq);
-		return NULL;
-	}
-
-	wq->name = name;
-	wq->freezeable = freezeable;
-
-	mutex_lock(&workqueue_mutex);
-	if (singlethread) {
-		INIT_LIST_HEAD(&wq->list);
-		init_cpu_workqueue(wq, singlethread_cpu);
-		p = create_workqueue_thread(wq, singlethread_cpu);
-		if (!p)
-			destroy = 1;
-		else
-			wake_up_process(p);
-	} else {
-		list_add(&wq->list, &workqueues);
-		for_each_possible_cpu(cpu) {
-			init_cpu_workqueue(wq, cpu);
-			if (!cpu_online(cpu))
-				continue;
-
-			p = create_workqueue_thread(wq, cpu);
-			if (p) {
-				kthread_bind(p, cpu);
-				wake_up_process(p);
-			} else
-				destroy = 1;
-		}
-	}
-	mutex_unlock(&workqueue_mutex);
-
-	/*
-	 * Was there any error during startup? If yes then clean up:
-	 */
-	if (destroy) {
-		destroy_workqueue(wq);
-		wq = NULL;
-	}
-	return wq;
-}
-EXPORT_SYMBOL_GPL(__create_workqueue);
-
-static void cleanup_workqueue_thread(struct workqueue_struct *wq, int cpu)
-{
-	struct cpu_workqueue_struct *cwq = per_cpu_ptr(wq->cpu_wq, cpu);
-
-	if (cwq->thread) {
-		kthread_stop(cwq->thread);
-		cwq->thread = NULL;
-	}
-}
-
-/**
- * destroy_workqueue - safely terminate a workqueue
- * @wq: target workqueue
- *
- * Safely destroy a workqueue. All work currently pending will be done first.
- */
-void destroy_workqueue(struct workqueue_struct *wq)
-{
-	int cpu;
-
-	flush_workqueue(wq);
-
-	/* We don't need the distraction of CPUs appearing and vanishing. */
-	mutex_lock(&workqueue_mutex);
-	if (is_single_threaded(wq))
-		cleanup_workqueue_thread(wq, singlethread_cpu);
-	else {
-		for_each_online_cpu(cpu)
-			cleanup_workqueue_thread(wq, cpu);
-		list_del(&wq->list);
-	}
-	mutex_unlock(&workqueue_mutex);
-	free_percpu(wq->cpu_wq);
-	kfree(wq);
-}
-EXPORT_SYMBOL_GPL(destroy_workqueue);
 
 static struct workqueue_struct *keventd_wq;
 
@@ -821,95 +706,209 @@ int current_is_keventd(void)
 
 }
 
-/* Take the work from this (downed) CPU. */
-static void take_over_work(struct workqueue_struct *wq, unsigned int cpu)
-{
-	struct cpu_workqueue_struct *cwq = per_cpu_ptr(wq->cpu_wq, cpu);
-	struct list_head list;
-	struct work_struct *work;
-
-	spin_lock_irq(&cwq->lock);
-	list_replace_init(&cwq->worklist, &list);
-	migrate_sequence++;
-
-	while (!list_empty(&list)) {
-		printk("Taking work for %s\n", wq->name);
-		work = list_entry(list.next,struct work_struct,entry);
-		list_del(&work->entry);
-		__queue_work(per_cpu_ptr(wq->cpu_wq, smp_processor_id()), work);
-	}
-	spin_unlock_irq(&cwq->lock);
-}
-
-/* We're holding the cpucontrol mutex here */
-static int __devinit workqueue_cpu_callback(struct notifier_block *nfb,
-				  unsigned long action,
-				  void *hcpu)
-{
-	unsigned int hotcpu = (unsigned long)hcpu;
-	struct workqueue_struct *wq;
-
-	switch (action) {
-	case CPU_UP_PREPARE:
-		mutex_lock(&workqueue_mutex);
-		/* Create a new workqueue thread for it. */
-		list_for_each_entry(wq, &workqueues, list) {
-			if (!create_workqueue_thread(wq, hotcpu)) {
-				printk("workqueue for %i failed\n", hotcpu);
-				return NOTIFY_BAD;
-			}
-		}
-		break;
-
-	case CPU_ONLINE:
-		/* Kick off worker threads. */
-		list_for_each_entry(wq, &workqueues, list) {
-			struct cpu_workqueue_struct *cwq;
-
-			cwq = per_cpu_ptr(wq->cpu_wq, hotcpu);
-			kthread_bind(cwq->thread, hotcpu);
-			wake_up_process(cwq->thread);
-		}
-		mutex_unlock(&workqueue_mutex);
-		break;
-
-	case CPU_UP_CANCELED:
-		list_for_each_entry(wq, &workqueues, list) {
-			if (!per_cpu_ptr(wq->cpu_wq, hotcpu)->thread)
-				continue;
-			/* Unbind so it can run. */
-			kthread_bind(per_cpu_ptr(wq->cpu_wq, hotcpu)->thread,
-				     any_online_cpu(cpu_online_map));
-			cleanup_workqueue_thread(wq, hotcpu);
-		}
-		mutex_unlock(&workqueue_mutex);
-		break;
-
-	case CPU_DOWN_PREPARE:
-		mutex_lock(&workqueue_mutex);
-		break;
-
-	case CPU_DOWN_FAILED:
-		mutex_unlock(&workqueue_mutex);
-		break;
-
-	case CPU_DEAD:
-		list_for_each_entry(wq, &workqueues, list)
-			cleanup_workqueue_thread(wq, hotcpu);
-		list_for_each_entry(wq, &workqueues, list)
-			take_over_work(wq, hotcpu);
-		mutex_unlock(&workqueue_mutex);
-		break;
-	}
-
-	return NOTIFY_OK;
-}
+static struct cpu_workqueue_struct *
+init_cpu_workqueue(struct workqueue_struct *wq, int cpu)
+{
+	struct cpu_workqueue_struct *cwq = per_cpu_ptr(wq->cpu_wq, cpu);
+
+	cwq->wq = wq;
+	spin_lock_init(&cwq->lock);
+	INIT_LIST_HEAD(&cwq->worklist);
+	init_waitqueue_head(&cwq->more_work);
+
+	return cwq;
+}
+
+static int create_workqueue_thread(struct cpu_workqueue_struct *cwq, int cpu)
+{
+	struct task_struct *p;
+
+	spin_lock_irq(&cwq->lock);
+	cwq->should_stop = 0;
+	p = cwq->thread;
+	spin_unlock_irq(&cwq->lock);
+
+	if (!p) {
+		struct workqueue_struct *wq = cwq->wq;
+		const char *fmt = is_single_threaded(wq) ? "%s" : "%s/%d";
+
+		p = kthread_create(worker_thread, cwq, fmt, wq->name, cpu);
+		/*
+		 * Nobody can add the work_struct to this cwq,
+		 *	if (caller is __create_workqueue)
+		 *		nobody should see this wq
+		 *	else // caller is CPU_UP_PREPARE
+		 *		cpu is not on cpu_online_map
+		 * so we can abort safely.
+		 */
+		if (IS_ERR(p))
+			return PTR_ERR(p);
+
+		cwq->thread = p;
+		if (!is_single_threaded(wq))
+			kthread_bind(p, cpu);
+		/*
+		 * Cancels affinity if the caller is CPU_UP_PREPARE.
+		 * Needs a cleanup, but OK.
+		 */
+		wake_up_process(p);
+	}
+
+	return 0;
+}
+
+static int embryonic_cpu __read_mostly = -1;
+
+struct workqueue_struct *__create_workqueue(const char *name,
+					    int singlethread, int freezeable)
+{
+	struct workqueue_struct *wq;
+	struct cpu_workqueue_struct *cwq;
+	int err = 0, cpu;
+
+	wq = kzalloc(sizeof(*wq), GFP_KERNEL);
+	if (!wq)
+		return NULL;
+
+	wq->cpu_wq = alloc_percpu(struct cpu_workqueue_struct);
+	if (!wq->cpu_wq) {
+		kfree(wq);
+		return NULL;
+	}
+
+	wq->name = name;
+	wq->freezeable = freezeable;
+
+	if (singlethread) {
+		INIT_LIST_HEAD(&wq->list);
+		cwq = init_cpu_workqueue(wq, singlethread_cpu);
+		err = create_workqueue_thread(cwq, singlethread_cpu);
+	} else {
+		mutex_lock(&workqueue_mutex);
+		list_add(&wq->list, &workqueues);
+
+		for_each_possible_cpu(cpu) {
+			cwq = init_cpu_workqueue(wq, cpu);
+			if (err || !(cpu_online(cpu) || cpu == embryonic_cpu))
+				continue;
+			err = create_workqueue_thread(cwq, cpu);
+		}
+		mutex_unlock(&workqueue_mutex);
+	}
+
+	if (err) {
+		destroy_workqueue(wq);
+		wq = NULL;
+	}
+	return wq;
+}
+EXPORT_SYMBOL_GPL(__create_workqueue);
+
+static void cleanup_workqueue_thread(struct workqueue_struct *wq, int cpu)
+{
+	struct cpu_workqueue_struct *cwq = per_cpu_ptr(wq->cpu_wq, cpu);
+	struct wq_barrier barr;
+	int alive = 0;
+
+	spin_lock_irq(&cwq->lock);
+	if (cwq->thread != NULL) {
+		insert_wq_barrier(cwq, &barr, 1);
+		cwq->should_stop = 1;
+		alive = 1;
+	}
+	spin_unlock_irq(&cwq->lock);
+
+	if (alive) {
+		wait_for_completion(&barr.done);
+
+		while (unlikely(cwq->thread != NULL))
+			cpu_relax();
+		/*
+		 * Wait until cwq->thread unlocks cwq->lock,
+		 * it won't touch *cwq after that.
+		 */
+		smp_rmb();
+		spin_unlock_wait(&cwq->lock);
+	}
+}
+
+/**
+ * destroy_workqueue - safely terminate a workqueue
+ * @wq: target workqueue
+ *
+ * Safely destroy a workqueue. All work currently pending will be done first.
+ */
+void destroy_workqueue(struct workqueue_struct *wq)
+{
+	if (is_single_threaded(wq))
+		cleanup_workqueue_thread(wq, singlethread_cpu);
+	else {
+		int cpu;
+
+		mutex_lock(&workqueue_mutex);
+		list_del(&wq->list);
+		mutex_unlock(&workqueue_mutex);
+
+		for_each_cpu_mask(cpu, cpu_populated_map)
+			cleanup_workqueue_thread(wq, cpu);
+	}
+
+	free_percpu(wq->cpu_wq);
+	kfree(wq);
+}
+EXPORT_SYMBOL_GPL(destroy_workqueue);
+
+static int __devinit workqueue_cpu_callback(struct notifier_block *nfb,
+						unsigned long action,
+						void *hcpu)
+{
+	struct workqueue_struct *wq;
+	struct cpu_workqueue_struct *cwq;
+	unsigned int cpu = (unsigned long)hcpu;
+	int ret = NOTIFY_OK;
+
+	mutex_lock(&workqueue_mutex);
+	embryonic_cpu = -1;
+	if (action == CPU_UP_PREPARE) {
+		cpu_set(cpu, cpu_populated_map);
+		embryonic_cpu = cpu;
+	}
+
+	list_for_each_entry(wq, &workqueues, list) {
+		cwq = per_cpu_ptr(wq->cpu_wq, cpu);
+
+		switch (action) {
+		case CPU_UP_PREPARE:
+			if (create_workqueue_thread(cwq, cpu))
+				ret = NOTIFY_BAD;
+			break;
+
+		case CPU_ONLINE:
+			set_cpus_allowed(cwq->thread, cpumask_of_cpu(cpu));
+			break;
+
+		case CPU_UP_CANCELED:
+		case CPU_DEAD:
+			cwq->should_stop = 1;
+			wake_up(&cwq->more_work);
+			break;
+		}
+
+		if (ret != NOTIFY_OK) {
+			printk(KERN_ERR "workqueue for %i failed\n", cpu);
+			break;
+		}
+	}
+	mutex_unlock(&workqueue_mutex);
+
+	return ret;
+}
 
 void init_workqueues(void)
 {
+	cpu_populated_map = cpu_online_map;
 	singlethread_cpu = first_cpu(cpu_possible_map);
 	hotcpu_notifier(workqueue_cpu_callback, 0);
 	keventd_wq = create_workqueue("events");
 	BUG_ON(!keventd_wq);
 }
-

