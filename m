Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264956AbSLBTat>; Mon, 2 Dec 2002 14:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264963AbSLBTat>; Mon, 2 Dec 2002 14:30:49 -0500
Received: from tolkor.SGI.COM ([198.149.18.6]:20623 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S264956AbSLBTaB>;
	Mon, 2 Dec 2002 14:30:01 -0500
Date: Mon, 2 Dec 2002 21:51:25 -0500
From: Christoph Hellwig <hch@sgi.com>
To: marcelo@connectiva.com.br.munich.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] backport workqueue abstraction from 2.5
Message-ID: <20021202215125.A30454@sgi.com>
Mail-Followup-To: Christoph Hellwig <hch@sgi.com>,
	marcelo@connectiva.com.br, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch backports workqueues from 2.5.  I really want it for XFS
and jgarzik wants to use it in many of his network drivers.  I guess
there are other people interested in it aswell.  The patch only
adds workqueue.[ch] and doesn't change any existing code.

This needs the set_cpus_allowed patch I sent out today.


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.803, 2002-12-02 20:17:09+01:00, hch@lab343.munich.sgi.com
  Backport Ingo Molnar's workqueue abstraction from 2.5


 include/linux/workqueue.h |   66 ++++++++
 kernel/Makefile           |    5 
 kernel/workqueue.c        |  363 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 432 insertions(+), 2 deletions(-)


diff -Nru a/include/linux/workqueue.h b/include/linux/workqueue.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/workqueue.h	Mon Dec  2 20:21:22 2002
@@ -0,0 +1,66 @@
+/*
+ * workqueue.h --- work queue handling for Linux.
+ */
+
+#ifndef _LINUX_WORKQUEUE_H
+#define _LINUX_WORKQUEUE_H
+
+#include <linux/timer.h>
+#include <linux/linkage.h>
+
+struct workqueue_struct;
+
+struct work_struct {
+	unsigned long pending;
+	struct list_head entry;
+	void (*func)(void *);
+	void *data;
+	void *wq_data;
+	struct timer_list timer;
+};
+
+#define __WORK_INITIALIZER(n, f, d) {				\
+        .entry	= { &(n).entry, &(n).entry },			\
+	.func = (f),						\
+	.data = (d),						\
+	.timer = TIMER_INITIALIZER(NULL, 0, 0),			\
+	}
+
+#define DECLARE_WORK(n, f, d)					\
+	struct work_struct n = __WORK_INITIALIZER(n, f, d)
+
+/*
+ * initialize a work-struct's func and data pointers:
+ */
+#define PREPARE_WORK(_work, _func, _data)			\
+	do {							\
+		(_work)->func = _func;				\
+		(_work)->data = _data;				\
+	} while (0)
+
+/*
+ * initialize all of a work-struct:
+ */
+#define INIT_WORK(_work, _func, _data)				\
+	do {							\
+		INIT_LIST_HEAD(&(_work)->entry);		\
+		(_work)->pending = 0;				\
+		PREPARE_WORK((_work), (_func), (_data));	\
+		init_timer(&(_work)->timer);			\
+	} while (0)
+
+extern struct workqueue_struct *create_workqueue(const char *name);
+extern void destroy_workqueue(struct workqueue_struct *wq);
+
+extern int FASTCALL(queue_work(struct workqueue_struct *wq, struct work_struct *work));
+extern int FASTCALL(queue_delayed_work(struct workqueue_struct *wq, struct work_struct *work, unsigned long delay));
+extern void FASTCALL(flush_workqueue(struct workqueue_struct *wq));
+
+extern int FASTCALL(schedule_work(struct work_struct *work));
+extern int FASTCALL(schedule_delayed_work(struct work_struct *work, unsigned long delay));
+extern void flush_scheduled_work(void);
+
+extern void init_workqueues(void);
+
+#endif
+
diff -Nru a/kernel/Makefile b/kernel/Makefile
--- a/kernel/Makefile	Mon Dec  2 20:21:22 2002
+++ b/kernel/Makefile	Mon Dec  2 20:21:22 2002
@@ -9,12 +9,13 @@
 
 O_TARGET := kernel.o
 
-export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o printk.o
+export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o \
+	      printk.o workqueue.o
 
 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o info.o time.o softirq.o resource.o \
 	    sysctl.o acct.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o context.o
+	    signal.o sys.o kmod.o context.o workqueue.o
 
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
diff -Nru a/kernel/workqueue.c b/kernel/workqueue.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/kernel/workqueue.c	Mon Dec  2 20:21:22 2002
@@ -0,0 +1,363 @@
+/*
+ * linux/kernel/workqueue.c
+ *
+ * Generic mechanism for defining kernel helper threads for running
+ * arbitrary tasks in process context.
+ *
+ * Started by Ingo Molnar, Copyright (C) 2002
+ *
+ * Derived from the taskqueue/keventd code by:
+ *
+ *   David Woodhouse <dwmw2@redhat.com>
+ *   Andrew Morton <andrewm@uow.edu.au>
+ *   Kai Petzke <wpp@marie.physik.tu-berlin.de>
+ *   Theodore Ts'o <tytso@mit.edu>
+ */
+
+#define __KERNEL_SYSCALLS__
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/init.h>
+#include <linux/unistd.h>
+#include <linux/signal.h>
+#include <linux/completion.h>
+#include <linux/workqueue.h>
+#include <linux/slab.h>
+
+/*
+ * The per-CPU workqueue:
+ */
+struct cpu_workqueue_struct {
+
+	spinlock_t lock;
+
+	atomic_t nr_queued;
+	struct list_head worklist;
+	wait_queue_head_t more_work;
+	wait_queue_head_t work_done;
+
+	struct workqueue_struct *wq;
+	struct task_struct *thread;
+	struct completion exit;
+
+} ____cacheline_aligned;
+
+/*
+ * The externally visible workqueue abstraction is an array of
+ * per-CPU workqueues:
+ */
+struct workqueue_struct {
+	struct cpu_workqueue_struct cpu_wq[NR_CPUS];
+};
+
+/*
+ * Queue work on a workqueue. Return non-zero if it was successfully
+ * added.
+ *
+ * We queue the work to the CPU it was submitted, but there is no
+ * guarantee that it will be processed by that CPU.
+ */
+int queue_work(struct workqueue_struct *wq, struct work_struct *work)
+{
+	unsigned long flags;
+	int ret = 0, cpu = smp_processor_id();
+	struct cpu_workqueue_struct *cwq = wq->cpu_wq + cpu;
+
+	if (!test_and_set_bit(0, &work->pending)) {
+		BUG_ON(!list_empty(&work->entry));
+		work->wq_data = cwq;
+
+		spin_lock_irqsave(&cwq->lock, flags);
+		list_add_tail(&work->entry, &cwq->worklist);
+		atomic_inc(&cwq->nr_queued);
+		spin_unlock_irqrestore(&cwq->lock, flags);
+
+		wake_up(&cwq->more_work);
+		ret = 1;
+	}
+	return ret;
+}
+
+static void delayed_work_timer_fn(unsigned long __data)
+{
+	struct work_struct *work = (struct work_struct *)__data;
+	struct cpu_workqueue_struct *cwq = work->wq_data;
+	unsigned long flags;
+
+	/*
+	 * Do the wakeup within the spinlock, so that flushing
+	 * can be done in a guaranteed way.
+	 */
+	spin_lock_irqsave(&cwq->lock, flags);
+	list_add_tail(&work->entry, &cwq->worklist);
+	wake_up(&cwq->more_work);
+	spin_unlock_irqrestore(&cwq->lock, flags);
+}
+
+int queue_delayed_work(struct workqueue_struct *wq, struct work_struct *work, unsigned long delay)
+{
+	int ret = 0, cpu = smp_processor_id();
+	struct timer_list *timer = &work->timer;
+	struct cpu_workqueue_struct *cwq = wq->cpu_wq + cpu;
+
+	if (!test_and_set_bit(0, &work->pending)) {
+		BUG_ON(timer_pending(timer));
+		BUG_ON(!list_empty(&work->entry));
+
+		/*
+		 * Increase nr_queued so that the flush function
+		 * knows that there's something pending.
+		 */
+		atomic_inc(&cwq->nr_queued);
+		work->wq_data = cwq;
+
+		timer->expires = jiffies + delay;
+		timer->data = (unsigned long)work;
+		timer->function = delayed_work_timer_fn;
+		add_timer(timer);
+
+		ret = 1;
+	}
+	return ret;
+}
+
+static inline void run_workqueue(struct cpu_workqueue_struct *cwq)
+{
+	unsigned long flags;
+
+	/*
+	 * Keep taking off work from the queue until
+	 * done.
+	 */
+	spin_lock_irqsave(&cwq->lock, flags);
+	while (!list_empty(&cwq->worklist)) {
+		struct work_struct *work = list_entry(cwq->worklist.next, struct work_struct, entry);
+		void (*f) (void *) = work->func;
+		void *data = work->data;
+
+		list_del_init(cwq->worklist.next);
+		spin_unlock_irqrestore(&cwq->lock, flags);
+
+		BUG_ON(work->wq_data != cwq);
+		clear_bit(0, &work->pending);
+		f(data);
+
+		/*
+		 * We only wake up 'work done' waiters (flush) when
+		 * the last function has been fully processed.
+		 */
+		if (atomic_dec_and_test(&cwq->nr_queued))
+			wake_up(&cwq->work_done);
+
+		spin_lock_irqsave(&cwq->lock, flags);
+	}
+	spin_unlock_irqrestore(&cwq->lock, flags);
+}
+
+typedef struct startup_s {
+	struct cpu_workqueue_struct *cwq;
+	struct completion done;
+	const char *name;
+} startup_t;
+
+static int worker_thread(void *__startup)
+{
+	startup_t *startup = __startup;
+	struct cpu_workqueue_struct *cwq = startup->cwq;
+	int cpu = cwq - cwq->wq->cpu_wq;
+	DECLARE_WAITQUEUE(wait, current);
+	struct k_sigaction sa;
+
+	daemonize();
+	sprintf(current->comm, "%s/%d", startup->name, cpu);
+	cwq->thread = current;
+
+	set_cpus_allowed(current, 1UL << cpu);
+
+	spin_lock_irq(&current->sig->siglock);
+	siginitsetinv(&current->blocked, sigmask(SIGCHLD));
+	recalc_sigpending(current);
+	spin_unlock_irq(&current->sig->siglock);
+
+	complete(&startup->done);
+
+	/* Install a handler so SIGCLD is delivered */
+	sa.sa.sa_handler = SIG_IGN;
+	sa.sa.sa_flags = 0;
+	siginitset(&sa.sa.sa_mask, sigmask(SIGCHLD));
+	do_sigaction(SIGCHLD, &sa, (struct k_sigaction *)0);
+
+	for (;;) {
+		set_task_state(current, TASK_INTERRUPTIBLE);
+
+		add_wait_queue(&cwq->more_work, &wait);
+		if (!cwq->thread)
+			break;
+		if (list_empty(&cwq->worklist))
+			schedule();
+		else
+			set_task_state(current, TASK_RUNNING);
+		remove_wait_queue(&cwq->more_work, &wait);
+
+		if (!list_empty(&cwq->worklist))
+			run_workqueue(cwq);
+
+		if (signal_pending(current)) {
+			while (waitpid(-1, NULL, __WALL|WNOHANG) > 0)
+				/* SIGCHLD - auto-reaping */ ;
+
+			/* zap all other signals */
+			spin_lock_irq(&current->sig->siglock);
+			flush_signals(current);
+			recalc_sigpending(current);
+			spin_unlock_irq(&current->sig->siglock);
+		}
+	}
+	remove_wait_queue(&cwq->more_work, &wait);
+	complete(&cwq->exit);
+
+	return 0;
+}
+
+/*
+ * flush_workqueue - ensure that any scheduled work has run to completion.
+ *
+ * Forces execution of the workqueue and blocks until its completion.
+ * This is typically used in driver shutdown handlers.
+ *
+ * NOTE: if work is being added to the queue constantly by some other
+ * context then this function might block indefinitely.
+ */
+void flush_workqueue(struct workqueue_struct *wq)
+{
+	struct cpu_workqueue_struct *cwq;
+	int cpu;
+
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		cwq = wq->cpu_wq + cpu_logical_map(cpu);
+
+		if (atomic_read(&cwq->nr_queued)) {
+			DECLARE_WAITQUEUE(wait, current);
+
+			if (!list_empty(&cwq->worklist))
+				run_workqueue(cwq);
+
+			/*
+			 * Wait for helper thread(s) to finish up
+			 * the queue:
+			 */
+			set_task_state(current, TASK_INTERRUPTIBLE);
+			add_wait_queue(&cwq->work_done, &wait);
+			if (atomic_read(&cwq->nr_queued))
+				schedule();
+			else
+				set_task_state(current, TASK_RUNNING);
+			remove_wait_queue(&cwq->work_done, &wait);
+		}
+	}
+}
+
+struct workqueue_struct *create_workqueue(const char *name)
+{
+	int ret, cpu, destroy = 0;
+	struct cpu_workqueue_struct *cwq;
+	startup_t startup;
+	struct workqueue_struct *wq;
+
+	BUG_ON(strlen(name) > 10);
+	startup.name = name;
+
+	wq = kmalloc(sizeof(*wq), GFP_KERNEL);
+	if (!wq)
+		return NULL;
+
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		cwq = wq->cpu_wq + cpu_logical_map(cpu);
+
+		spin_lock_init(&cwq->lock);
+		cwq->wq = wq;
+		cwq->thread = NULL;
+		atomic_set(&cwq->nr_queued, 0);
+		INIT_LIST_HEAD(&cwq->worklist);
+		init_waitqueue_head(&cwq->more_work);
+		init_waitqueue_head(&cwq->work_done);
+
+		init_completion(&startup.done);
+		startup.cwq = cwq;
+		ret = kernel_thread(worker_thread, &startup,
+						CLONE_FS | CLONE_FILES);
+		if (ret < 0)
+			destroy = 1;
+		else {
+			wait_for_completion(&startup.done);
+			BUG_ON(!cwq->thread);
+		}
+	}
+	/*
+	 * Was there any error during startup? If yes then clean up:
+	 */
+	if (destroy) {
+		destroy_workqueue(wq);
+		wq = NULL;
+	}
+	return wq;
+}
+
+void destroy_workqueue(struct workqueue_struct *wq)
+{
+	struct cpu_workqueue_struct *cwq;
+	int cpu;
+
+	flush_workqueue(wq);
+
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		cwq = wq->cpu_wq + cpu_logical_map(cpu);
+		if (!cwq->thread)
+			continue;
+		/*
+		 * Initiate an exit and wait for it:
+		 */
+		init_completion(&cwq->exit);
+		cwq->thread = NULL;
+		wake_up(&cwq->more_work);
+
+		wait_for_completion(&cwq->exit);
+	}
+	kfree(wq);
+}
+
+static struct workqueue_struct *keventd_wq;
+
+int schedule_work(struct work_struct *work)
+{
+	return queue_work(keventd_wq, work);
+}
+
+int schedule_delayed_work(struct work_struct *work, unsigned long delay)
+{
+	return queue_delayed_work(keventd_wq, work, delay);
+}
+
+void flush_scheduled_work(void)
+{
+	flush_workqueue(keventd_wq);
+}
+
+void init_workqueues(void)
+{
+	keventd_wq = create_workqueue("events");
+	BUG_ON(!keventd_wq);
+}
+
+EXPORT_SYMBOL_GPL(create_workqueue);
+EXPORT_SYMBOL_GPL(queue_work);
+EXPORT_SYMBOL_GPL(queue_delayed_work);
+EXPORT_SYMBOL_GPL(flush_workqueue);
+EXPORT_SYMBOL_GPL(destroy_workqueue);
+
+EXPORT_SYMBOL(schedule_work);
+EXPORT_SYMBOL(schedule_delayed_work);
+EXPORT_SYMBOL(flush_scheduled_work);
+

===================================================================


This BitKeeper patch contains the following changesets:
1.803
## Wrapped with gzip_uu ##


begin 664 bkpatch14038
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
/NN%L-ASMOQR[?KH,-0``
`
end
