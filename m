Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263228AbUDSG1N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 02:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262719AbUDSG1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 02:27:13 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:13952 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S263228AbUDSG0p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 02:26:45 -0400
Subject: Re: [PATCH] create_singlethread_workqueue()
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <200404190713.09058.ioe-lkml@rameria.de>
References: <1082344185.29285.4.camel@bach>
	 <200404190713.09058.ioe-lkml@rameria.de>
Content-Type: text/plain
Message-Id: <1082355964.30154.149.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 19 Apr 2004 16:26:08 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-04-19 at 15:12, Ingo Oeser wrote:
> > +		if (is_single_threaded(wq))
> > +			cpu = 0;
> >  		cwq = wq->cpu_wq + cpu;
> >  
> >  		if (cwq->thread == current) {
> > @@ -266,7 +271,8 @@ void fastcall flush_workqueue(struct wor
> 
> I can't see, how this works.

I can't either.  If I had more than one CPU...

OK.  This has been tested on my dual SMP.  Only other change is
cosmetic: single-threaded wq thread does not have "/0" appended.

Thanks!
Rusty.

Name: Workqueues With Only A Single Thread, Not One Per CPU
Status: Tested on 2.6.6-rc1-bk3

Workqueues are a great primitive for running things from user context
from a completely clean environment.  Unfortunately, they currently
insist on creating one thread per CPU, which is overkill for many
situations, so the more generic keventd workqueue is used for these.
Recently deadlocks using keventd were demonstrated, showing that it is
not suitable for all uses.

1) Clean up CPU iterators.  Always a nice touch.

2) Add __create_workqueue() and create_singlethread_workqueue(),
   keeping source compatibility.

3) Put workqueues in workqueue list even if !CONFIG_HOTPLUG_CPU (means
   we need a lock to protect that list).  Now we can tell if a wq is
   single-threaded using list_empty(&wq->list).

4) For single-threaded workqueues, override CPU in queue_work,
   delayed_work_timer_fn and flush_workqueue to be 0.  flush_workqueue
   now does redundant passes for single-threaded workqueues, but the
   code remains simple.

5) Make create_workqueue_thread return the thread, so we can easily
   kthread_bind for multi-threaded workqueues.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21345-linux-2.6.6-rc1-bk3/include/linux/workqueue.h .21345-linux-2.6.6-rc1-bk3.updated/include/linux/workqueue.h
--- .21345-linux-2.6.6-rc1-bk3/include/linux/workqueue.h	2004-03-12 07:57:28.000000000 +1100
+++ .21345-linux-2.6.6-rc1-bk3.updated/include/linux/workqueue.h	2004-04-19 16:08:51.000000000 +1000
@@ -49,7 +49,11 @@ struct work_struct {
 		init_timer(&(_work)->timer);			\
 	} while (0)
 
-extern struct workqueue_struct *create_workqueue(const char *name);
+extern struct workqueue_struct *__create_workqueue(const char *name,
+						    int singlethread);
+#define create_workqueue(name) __create_workqueue((name), 0)
+#define create_singlethread_workqueue(name) __create_workqueue((name), 1)
+
 extern void destroy_workqueue(struct workqueue_struct *wq);
 
 extern int FASTCALL(queue_work(struct workqueue_struct *wq, struct work_struct *work));
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21345-linux-2.6.6-rc1-bk3/kernel/workqueue.c .21345-linux-2.6.6-rc1-bk3.updated/kernel/workqueue.c
--- .21345-linux-2.6.6-rc1-bk3/kernel/workqueue.c	2004-04-05 09:04:48.000000000 +1000
+++ .21345-linux-2.6.6-rc1-bk3.updated/kernel/workqueue.c	2004-04-19 16:08:51.000000000 +1000
@@ -27,7 +27,7 @@
 #include <linux/kthread.h>
 
 /*
- * The per-CPU workqueue.
+ * The per-CPU workqueue (if single thread, we always use cpu 0's).
  *
  * The sequence counters are for flush_scheduled_work().  It wants to wait
  * until until all currently-scheduled works are completed, but it doesn't
@@ -59,20 +59,19 @@ struct cpu_workqueue_struct {
 struct workqueue_struct {
 	struct cpu_workqueue_struct cpu_wq[NR_CPUS];
 	const char *name;
-	struct list_head list;
+	struct list_head list; 	/* Empty if single thread */
 };
 
-#ifdef CONFIG_HOTPLUG_CPU
-/* All the workqueues on the system, for hotplug cpu to add/remove
-   threads to each one as cpus come/go.  Protected by cpucontrol
-   sem. */
+/* All the per-cpu workqueues on the system, for hotplug cpu to add/remove
+   threads to each one as cpus come/go. */
+static spinlock_t workqueue_lock = SPIN_LOCK_UNLOCKED;
 static LIST_HEAD(workqueues);
-#define add_workqueue(wq) list_add(&(wq)->list, &workqueues)
-#define del_workqueue(wq) list_del(&(wq)->list)
-#else
-#define add_workqueue(wq)
-#define del_workqueue(wq)
-#endif /* CONFIG_HOTPLUG_CPU */
+
+/* If it's single threaded, it isn't in the list of workqueues. */
+static inline int is_single_threaded(struct workqueue_struct *wq)
+{
+	return list_empty(&wq->list);
+}
 
 /* Preempt must be disabled. */
 static void __queue_work(struct cpu_workqueue_struct *cwq,
@@ -100,6 +99,8 @@ int fastcall queue_work(struct workqueue
 	int ret = 0, cpu = get_cpu();
 
 	if (!test_and_set_bit(0, &work->pending)) {
+		if (unlikely(is_single_threaded(wq)))
+			cpu = 0;
 		BUG_ON(!list_empty(&work->entry));
 		__queue_work(wq->cpu_wq + cpu, work);
 		ret = 1;
@@ -112,8 +113,12 @@ static void delayed_work_timer_fn(unsign
 {
 	struct work_struct *work = (struct work_struct *)__data;
 	struct workqueue_struct *wq = work->wq_data;
+	int cpu = smp_processor_id();
 
-	__queue_work(wq->cpu_wq + smp_processor_id(), work);
+	if (unlikely(is_single_threaded(wq)))
+		cpu = 0;
+
+	__queue_work(wq->cpu_wq + cpu, work);
 }
 
 int fastcall queue_delayed_work(struct workqueue_struct *wq,
@@ -234,13 +239,14 @@ void fastcall flush_workqueue(struct wor
 	might_sleep();
 
 	lock_cpu_hotplug();
-	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+	for_each_online_cpu(cpu) {
 		DEFINE_WAIT(wait);
 		long sequence_needed;
 
-		if (!cpu_online(cpu))
-			continue;
-		cwq = wq->cpu_wq + cpu;
+		if (is_single_threaded(wq))
+			cwq = wq->cpu_wq + 0; /* Always use cpu 0's area. */
+		else
+			cwq = wq->cpu_wq + cpu;
 
 		if (cwq->thread == current) {
 			/*
@@ -266,7 +272,8 @@ void fastcall flush_workqueue(struct wor
 	unlock_cpu_hotplug();
 }
 
-static int create_workqueue_thread(struct workqueue_struct *wq, int cpu)
+static struct task_struct *create_workqueue_thread(struct workqueue_struct *wq,
+						   int cpu)
 {
 	struct cpu_workqueue_struct *cwq = wq->cpu_wq + cpu;
 	struct task_struct *p;
@@ -280,18 +287,22 @@ static int create_workqueue_thread(struc
 	init_waitqueue_head(&cwq->more_work);
 	init_waitqueue_head(&cwq->work_done);
 
-	p = kthread_create(worker_thread, cwq, "%s/%d", wq->name, cpu);
+	if (is_single_threaded(wq))
+		p = kthread_create(worker_thread, cwq, "%s", wq->name);
+	else
+		p = kthread_create(worker_thread, cwq, "%s/%d", wq->name, cpu);
 	if (IS_ERR(p))
-		return PTR_ERR(p);
+		return NULL;
 	cwq->thread = p;
-	kthread_bind(p, cpu);
-	return 0;
+	return p;
 }
 
-struct workqueue_struct *create_workqueue(const char *name)
+struct workqueue_struct *__create_workqueue(const char *name,
+					    int singlethread)
 {
 	int cpu, destroy = 0;
 	struct workqueue_struct *wq;
+	struct task_struct *p;
 
 	BUG_ON(strlen(name) > 10);
 
@@ -303,15 +314,26 @@ struct workqueue_struct *create_workqueu
 	wq->name = name;
 	/* We don't need the distraction of CPUs appearing and vanishing. */
 	lock_cpu_hotplug();
-	for (cpu = 0; cpu < NR_CPUS; cpu++) {
-		if (!cpu_online(cpu))
-			continue;
-		if (create_workqueue_thread(wq, cpu) < 0)
+	if (singlethread) {
+		INIT_LIST_HEAD(&wq->list);
+		p = create_workqueue_thread(wq, 0);
+		if (!p)
 			destroy = 1;
 		else
-			wake_up_process(wq->cpu_wq[cpu].thread);
+			wake_up_process(p);
+	} else {
+		spin_lock(&workqueue_lock);
+		list_add(&wq->list, &workqueues);
+		spin_unlock_irq(&workqueue_lock);
+		for_each_online_cpu(cpu) {
+			p = create_workqueue_thread(wq, cpu);
+			if (p) {
+				kthread_bind(p, cpu);
+				wake_up_process(p);
+			} else
+				destroy = 1;
+		}
 	}
-	add_workqueue(wq);
 
 	/*
 	 * Was there any error during startup? If yes then clean up:
@@ -347,11 +369,15 @@ void destroy_workqueue(struct workqueue_
 
 	/* We don't need the distraction of CPUs appearing and vanishing. */
 	lock_cpu_hotplug();
-	for (cpu = 0; cpu < NR_CPUS; cpu++) {
-		if (cpu_online(cpu))
+	if (is_single_threaded(wq))
+		cleanup_workqueue_thread(wq, 0);
+	else {
+		for_each_online_cpu(cpu)
 			cleanup_workqueue_thread(wq, cpu);
+		spin_lock(&workqueue_lock);
+		list_del(&wq->list);
+		spin_unlock_irq(&workqueue_lock);
 	}
-	del_workqueue(wq);
 	unlock_cpu_hotplug();
 	kfree(wq);
 }
@@ -467,7 +493,7 @@ void init_workqueues(void)
 	BUG_ON(!keventd_wq);
 }
 
-EXPORT_SYMBOL_GPL(create_workqueue);
+EXPORT_SYMBOL_GPL(__create_workqueue);
 EXPORT_SYMBOL_GPL(queue_work);
 EXPORT_SYMBOL_GPL(queue_delayed_work);
 EXPORT_SYMBOL_GPL(flush_workqueue);

-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

