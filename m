Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263239AbTGOGKK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 02:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263355AbTGOGKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 02:10:10 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:22326 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S263239AbTGOGJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 02:09:45 -0400
Date: Mon, 14 Jul 2003 23:24:34 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] [1/2] workqueue 2.5.74->2.4.21 backport
Message-ID: <20030714232434.A3449@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

The last time I asked about this, Marc-Christian Petersen pointed me
to <http://marc.theaimsgroup.com/?l=linux-kernel&m=103885818416173&w=2>
which was a backport of the 2.5.51 workqueue (to 2.4.20 I guess),
by Christoph Hellwig.

Turns out it was missing a few minor glue pieces, which I was able to
easily add.  It also didn't test for a cpu's online-ness before creating
a queue for it; this caused problems somewhere (I forget).

Here is that backport with the glue added.  Next I will send a relative
diff which incorporates updates as of 2.5.74.

I'm looking for any comments on the goodness of the patch.  I'm not
looking for it to be included in any 2.4 kernel, as there are no 2.4
users of it.   But I have a local fork which backports the 2.5
NFS ... which does use the workqueue.  So I'm looking for expert
opinion on whether it looks problematic.  The real meat is in the
next patch, this one doesn't touch existing code in a significant way.

Thanks,
/fc

diff -uNrp linux-2.4.21.0/include/asm-i386/smp.h linux-2.4.21-wq.51/include/asm-i386/smp.h
--- linux-2.4.21.0/include/asm-i386/smp.h	Thu Nov 28 15:53:15 2002
+++ linux-2.4.21-wq.51/include/asm-i386/smp.h	Tue Jul  8 01:50:31 2003
@@ -83,6 +83,8 @@ extern void smp_store_cpu_info(int id);	
 
 #define smp_processor_id() (current->processor)
 
+#define cpu_online(cpu) (cpu_online_map & (1<<(cpu)))
+
 static __inline int hard_smp_processor_id(void)
 {
 	/* we don't want to mark this access volatile - bad code generation */
diff -uNrp linux-2.4.21.0/include/linux/workqueue.h linux-2.4.21-wq.51/include/linux/workqueue.h
--- linux-2.4.21.0/include/linux/workqueue.h	Wed Dec 31 16:00:00 1969
+++ linux-2.4.21-wq.51/include/linux/workqueue.h	Tue Jul  8 01:50:23 2003
@@ -0,0 +1,75 @@
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
+/*
+ * Kill off a pending schedule_delayed_work().  Note that the work callback
+ * function may still be running on return from cancel_delayed_work().  Run
+ * flush_scheduled_work() to wait on it.
+ */
+static inline int cancel_delayed_work(struct work_struct *work)
+{
+	return del_timer_sync(&work->timer);
+}
+
+#endif
+
diff -uNrp linux-2.4.21.0/init/main.c linux-2.4.21-wq.51/init/main.c
--- linux-2.4.21.0/init/main.c	Fri Aug  2 17:39:46 2002
+++ linux-2.4.21-wq.51/init/main.c	Tue Jul  8 01:50:31 2003
@@ -27,6 +27,7 @@
 #include <linux/iobuf.h>
 #include <linux/bootmem.h>
 #include <linux/tty.h>
+#include <linux/workqueue.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -527,6 +528,7 @@ static void __init do_basic_setup(void)
 	sock_init();
 
 	start_context_thread();
+	init_workqueues();
 	do_initcalls();
 
 #ifdef CONFIG_IRDA
diff -uNrp linux-2.4.21.0/kernel/Makefile linux-2.4.21-wq.51/kernel/Makefile
--- linux-2.4.21.0/kernel/Makefile	Sun Sep 16 21:22:40 2001
+++ linux-2.4.21-wq.51/kernel/Makefile	Tue Jul  8 01:50:02 2003
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
diff -uNrp linux-2.4.21.0/kernel/workqueue.c linux-2.4.21-wq.51/kernel/workqueue.c
--- linux-2.4.21.0/kernel/workqueue.c	Wed Dec 31 16:00:00 1969
+++ linux-2.4.21-wq.51/kernel/workqueue.c	Tue Jul  8 01:50:31 2003
@@ -0,0 +1,369 @@
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
+		if (!cpu_online(cpu))
+			continue;
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
+		if (!cpu_online(cpu))
+			continue;
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
+		if (!cpu_online(cpu))
+			continue;
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
