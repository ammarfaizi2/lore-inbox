Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271143AbUJVBaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271143AbUJVBaV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 21:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271183AbUJVBYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 21:24:31 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11211 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S271119AbUJVBRM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 21:17:12 -0400
Message-ID: <41785F88.6090007@pobox.com>
Date: Thu, 21 Oct 2004 21:16:56 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>
Subject: [RFC,PATCH] 2.4, maintenance mode, and workqueues
Content-Type: multipart/mixed;
 boundary="------------040205060809010803010606"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040205060809010803010606
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


One thing that would make my life a lot easier, before 2.4 goes into 
"deep maintenance" mode, would be the addition of workqueues (kthread.c 
and workqueue.c).

Doing so would go a long way towards making drivers more portable, since 
the kthread/wq stuff eliminates a lot of the task/signal mess that a 
driver really shouldn't have to care about.

The interfaces are pretty self-contained, as is shown by the attached 
patch (_not_ for application).

	Jeff




--------------040205060809010803010606
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/10/21 21:15:43-04:00 jgarzik@pobox.com 
#   Add kthread/workqueue APIs.
# 
# kernel/workqueue.c
#   2004/10/21 21:15:41-04:00 jgarzik@pobox.com +528 -0
# 
# kernel/kthread.c
#   2004/10/21 21:15:41-04:00 jgarzik@pobox.com +184 -0
# 
# include/linux/workqueue.h
#   2004/10/21 21:15:41-04:00 jgarzik@pobox.com +89 -0
# 
# include/linux/kthread.h
#   2004/10/21 21:15:41-04:00 jgarzik@pobox.com +81 -0
# 
# kernel/workqueue.c
#   2004/10/21 21:15:41-04:00 jgarzik@pobox.com +0 -0
#   BitKeeper file /garz/repo/kthread-2.4/kernel/workqueue.c
# 
# kernel/sched.c
#   2004/10/21 21:15:41-04:00 jgarzik@pobox.com +11 -0
#   Add kthread/workqueue APIs.
# 
# kernel/kthread.c
#   2004/10/21 21:15:41-04:00 jgarzik@pobox.com +0 -0
#   BitKeeper file /garz/repo/kthread-2.4/kernel/kthread.c
# 
# kernel/ksyms.c
#   2004/10/21 21:15:41-04:00 jgarzik@pobox.com +1 -0
#   Add kthread/workqueue APIs.
# 
# kernel/Makefile
#   2004/10/21 21:15:41-04:00 jgarzik@pobox.com +3 -2
#   Add kthread/workqueue APIs.
# 
# include/linux/workqueue.h
#   2004/10/21 21:15:41-04:00 jgarzik@pobox.com +0 -0
#   BitKeeper file /garz/repo/kthread-2.4/include/linux/workqueue.h
# 
# include/linux/timer.h
#   2004/10/21 21:15:41-04:00 jgarzik@pobox.com +12 -0
#   Add kthread/workqueue APIs.
# 
# include/linux/smp.h
#   2004/10/21 21:15:41-04:00 jgarzik@pobox.com +11 -3
#   Add kthread/workqueue APIs.
# 
# include/linux/sched.h
#   2004/10/21 21:15:41-04:00 jgarzik@pobox.com +3 -1
#   Add kthread/workqueue APIs.
# 
# include/linux/kthread.h
#   2004/10/21 21:15:41-04:00 jgarzik@pobox.com +0 -0
#   BitKeeper file /garz/repo/kthread-2.4/include/linux/kthread.h
# 
diff -Nru a/include/linux/kthread.h b/include/linux/kthread.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/linux/kthread.h	2004-10-21 21:15:58 -04:00
@@ -0,0 +1,81 @@
+#ifndef _LINUX_KTHREAD_H
+#define _LINUX_KTHREAD_H
+/* Simple interface for creating and stopping kernel threads without mess. */
+#include <linux/fs.h>
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
+ * return when 'kthread_should_stop()' is true (which means
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
+ * Sets kthread_should_stop() for @k to return true, wakes it, and
+ * waits for it to exit.  Your threadfn() must not call do_exit()
+ * itself if you use this function!  This can also be called after
+ * kthread_create() instead of calling wake_up_process(): the thread
+ * will exit without calling threadfn().
+ *
+ * Returns the result of threadfn(), or -EINTR if wake_up_process()
+ * was never called. */
+int kthread_stop(struct task_struct *k);
+
+/**
+ * kthread_should_stop: should this kthread return now?
+ *
+ * When someone calls kthread_stop on your kthread, it will be woken
+ * and this will return true.  You should then return, and your return
+ * value will be passed through to kthread_stop().
+ */
+int kthread_should_stop(void);
+
+#endif /* _LINUX_KTHREAD_H */
diff -Nru a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	2004-10-21 21:15:58 -04:00
+++ b/include/linux/sched.h	2004-10-21 21:15:58 -04:00
@@ -135,6 +135,8 @@
 extern spinlock_t runqueue_lock;
 extern spinlock_t mmlist_lock;
 
+typedef struct task_struct task_t;
+
 extern void sched_init(void);
 extern void init_idle(void);
 extern void show_state(void);
@@ -143,7 +145,7 @@
 extern void update_process_times(int user);
 extern void update_one_process(struct task_struct *p, unsigned long user,
 			       unsigned long system, int cpu);
-
+extern void set_user_nice(struct task_struct *p, long nice);
 #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
 asmlinkage void schedule(void);
diff -Nru a/include/linux/smp.h b/include/linux/smp.h
--- a/include/linux/smp.h	2004-10-21 21:15:58 -04:00
+++ b/include/linux/smp.h	2004-10-21 21:15:58 -04:00
@@ -71,7 +71,7 @@
 #define MSG_RESCHEDULE		0x0003	/* Reschedule request from master CPU*/
 #define MSG_CALL_FUNCTION       0x0004  /* Call function on all other CPUs */
 
-#else
+#else /* !SMP */
 
 /*
  *	These macros fold the SMP functionality into a single CPU system
@@ -87,5 +87,13 @@
 #define smp_call_function(func,info,retry,wait)	({ 0; })
 #define cpu_online_map				1
 
-#endif
-#endif
+#endif /* !SMP */
+
+#define get_cpu()	({ smp_processor_id(); })
+#define put_cpu()	do {} while (0)
+#define lock_cpu_hotplug()	do {} while (0)
+#define unlock_cpu_hotplug()	do {} while (0)
+#define for_each_online_cpu(cpu)	\
+	for ((cpu) = 0; (cpu) < smp_num_cpus; (cpu)++)
+
+#endif /* __LINUX_SMP_H */
diff -Nru a/include/linux/timer.h b/include/linux/timer.h
--- a/include/linux/timer.h	2004-10-21 21:15:58 -04:00
+++ b/include/linux/timer.h	2004-10-21 21:15:58 -04:00
@@ -20,8 +20,20 @@
 	void (*function)(unsigned long);
 };
 
+#define TIMER_INITIALIZER(_function, _expires, _data) {         \
+		.function = (_function),                        \
+		.expires = (_expires),                          \
+		.data = (_data),                                \
+		.list = { NULL, NULL },				\
+	}
+
 extern void add_timer(struct timer_list * timer);
 extern int del_timer(struct timer_list * timer);
+
+static inline void add_timer_on(struct timer_list *timer, int cpu)
+{
+	add_timer(timer);
+}
 
 #ifdef CONFIG_SMP
 extern int del_timer_sync(struct timer_list * timer);
diff -Nru a/include/linux/workqueue.h b/include/linux/workqueue.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/linux/workqueue.h	2004-10-21 21:15:58 -04:00
@@ -0,0 +1,89 @@
+/*
+ * workqueue.h --- work queue handling for Linux.
+ */
+
+#ifndef _LINUX_WORKQUEUE_H
+#define _LINUX_WORKQUEUE_H
+
+#include <linux/timer.h>
+#include <linux/linkage.h>
+#include <linux/bitops.h>
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
+extern struct workqueue_struct *__create_workqueue(const char *name,
+						    int singlethread);
+#define create_workqueue(name) __create_workqueue((name), 0)
+#define create_singlethread_workqueue(name) __create_workqueue((name), 1)
+
+extern void destroy_workqueue(struct workqueue_struct *wq);
+
+extern int FASTCALL(queue_work(struct workqueue_struct *wq, struct work_struct *work));
+extern int FASTCALL(queue_delayed_work(struct workqueue_struct *wq, struct work_struct *work, unsigned long delay));
+extern void FASTCALL(flush_workqueue(struct workqueue_struct *wq));
+
+extern int FASTCALL(schedule_work(struct work_struct *work));
+extern int FASTCALL(schedule_delayed_work(struct work_struct *work, unsigned long delay));
+
+extern int schedule_delayed_work_on(int cpu, struct work_struct *work, unsigned long delay);
+extern void flush_scheduled_work(void);
+extern int current_is_keventd(void);
+extern int keventd_up(void);
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
+	int ret;
+
+	ret = del_timer_sync(&work->timer);
+	if (ret)
+		clear_bit(0, &work->pending);
+	return ret;
+}
+
+#endif
diff -Nru a/kernel/Makefile b/kernel/Makefile
--- a/kernel/Makefile	2004-10-21 21:15:58 -04:00
+++ b/kernel/Makefile	2004-10-21 21:15:58 -04:00
@@ -9,12 +9,13 @@
 
 O_TARGET := kernel.o
 
-export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o printk.o
+export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o \
+	      printk.o kthread.o workqueue.o
 
 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o info.o time.o softirq.o resource.o \
 	    sysctl.o acct.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o context.o
+	    signal.o sys.o kmod.o context.o kthread.o workqueue.o
 
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
diff -Nru a/kernel/ksyms.c b/kernel/ksyms.c
--- a/kernel/ksyms.c	2004-10-21 21:15:58 -04:00
+++ b/kernel/ksyms.c	2004-10-21 21:15:58 -04:00
@@ -478,6 +478,7 @@
 EXPORT_SYMBOL(xtime);
 EXPORT_SYMBOL(do_gettimeofday);
 EXPORT_SYMBOL(do_settimeofday);
+EXPORT_SYMBOL(set_user_nice);
 
 #if !defined(__ia64__)
 EXPORT_SYMBOL(loops_per_jiffy);
diff -Nru a/kernel/kthread.c b/kernel/kthread.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/kernel/kthread.c	2004-10-21 21:15:58 -04:00
@@ -0,0 +1,184 @@
+/* Kernel thread helper functions.
+ *   Copyright (C) 2004 IBM Corporation, Rusty Russell.
+ *
+ * Creation is done via keventd, so that we get a clean environment
+ * even if we're invoked from userspace (think modprobe, hotplug cpu,
+ * etc.).
+ */
+#include <linux/sched.h>
+#include <linux/kthread.h>
+#include <linux/completion.h>
+#include <linux/unistd.h>
+#include <linux/file.h>
+#include <linux/module.h>
+#include <linux/workqueue.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
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
+struct kthread_stop_info
+{
+	struct task_struct *k;
+	int err;
+	struct completion done;
+};
+
+/* Thread stopping is done by setthing this var: lock serializes
+ * multiple kthread_stop calls. */
+static DECLARE_MUTEX(kthread_stop_lock);
+static struct kthread_stop_info kthread_stop_info;
+
+int kthread_should_stop(void)
+{
+	return (kthread_stop_info.k == current);
+}
+EXPORT_SYMBOL(kthread_should_stop);
+
+static void kthread_exit_files(void)
+{
+	struct fs_struct *fs;
+	struct task_struct *tsk = current;
+
+	exit_fs(tsk);		/* current->fs->count--; */
+	fs = init_task.fs;
+	tsk->fs = fs;
+	atomic_inc(&fs->count);
+ 	exit_files(tsk);
+	current->files = init_task.files;
+	atomic_inc(&tsk->files->count);
+}
+
+static int kthread(void *_create)
+{
+	struct kthread_create_info *create = _create;
+	int (*threadfn)(void *data);
+	void *data;
+	int ret = -EINTR;
+
+	kthread_exit_files();
+
+	/* Copy data: it's on keventd's stack */
+	threadfn = create->threadfn;
+	data = create->data;
+
+	/* Block and flush all signals (in case we're not from keventd). */
+	spin_lock_irq(&current->sigmask_lock);
+	sigemptyset(&current->blocked);
+	recalc_sigpending(current);
+	flush_signals(current);
+	spin_unlock_irq(&current->sigmask_lock);
+
+	/* By default we can run anywhere, unlike keventd. */
+	set_cpus_allowed(current, CPU_MASK_ALL);
+
+	/* OK, tell user we're spawned, wait for stop or wakeup */
+	__set_current_state(TASK_INTERRUPTIBLE);
+	complete(&create->started);
+	schedule();
+
+	if (!kthread_should_stop())
+		ret = threadfn(data);
+
+	/* It might have exited on its own, w/o kthread_stop.  Check. */
+	if (kthread_should_stop()) {
+		kthread_stop_info.err = ret;
+		complete(&kthread_stop_info.done);
+	}
+	return 0;
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
+	}
+	complete(&create->done);
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
+EXPORT_SYMBOL(kthread_create);
+
+void kthread_bind(struct task_struct *k, unsigned int cpu)
+{
+	set_cpus_allowed(k, 1 << cpu);
+}
+EXPORT_SYMBOL(kthread_bind);
+
+int kthread_stop(struct task_struct *k)
+{
+	int ret;
+
+	down(&kthread_stop_lock);
+
+	/* It could exit after stop_info.k set, but before wake_up_process. */
+	get_task_struct(k);
+
+	/* Must init completion *before* thread sees kthread_stop_info.k */
+	init_completion(&kthread_stop_info.done);
+	wmb();
+
+	/* Now set kthread_should_stop() to true, and wake it up. */
+	kthread_stop_info.k = k;
+	wake_up_process(k);
+	put_task_struct(k);
+
+	/* Once it dies, reset stop ptr, gather result and we're done. */
+	wait_for_completion(&kthread_stop_info.done);
+	kthread_stop_info.k = NULL;
+	ret = kthread_stop_info.err;
+	up(&kthread_stop_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL(kthread_stop);
diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	2004-10-21 21:15:58 -04:00
+++ b/kernel/sched.c	2004-10-21 21:15:58 -04:00
@@ -1350,6 +1350,17 @@
 	atomic_inc(&current->files->count);
 }
 
+void set_user_nice(struct task_struct *p, long nice)
+{
+	if (nice < -20)
+		nice = -20;
+	if (nice > 19)
+		nice = 19;
+	write_lock(&tasklist_lock);
+	p->nice = nice;
+	write_unlock(&tasklist_lock);
+}
+
 extern unsigned long wait_init_idle;
 
 void __init init_idle(void)
diff -Nru a/kernel/workqueue.c b/kernel/workqueue.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/kernel/workqueue.c	2004-10-21 21:15:58 -04:00
@@ -0,0 +1,528 @@
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
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/init.h>
+#include <linux/signal.h>
+#include <linux/completion.h>
+#include <linux/workqueue.h>
+#include <linux/slab.h>
+#include <linux/notifier.h>
+#include <linux/kthread.h>
+#include <linux/smp.h>
+
+/*
+ * The per-CPU workqueue (if single thread, we always use cpu 0's).
+ *
+ * The sequence counters are for flush_scheduled_work().  It wants to wait
+ * until until all currently-scheduled works are completed, but it doesn't
+ * want to be livelocked by new, incoming ones.  So it waits until
+ * remove_sequence is >= the insert_sequence which pertained when
+ * flush_scheduled_work() was called.
+ */
+struct cpu_workqueue_struct {
+
+	spinlock_t lock;
+
+	long remove_sequence;	/* Least-recently added (next to run) */
+	long insert_sequence;	/* Next to add */
+
+	struct list_head worklist;
+	wait_queue_head_t more_work;
+	wait_queue_head_t work_done;
+
+	struct workqueue_struct *wq;
+	task_t *thread;
+
+	int run_depth;		/* Detect run_workqueue() recursion depth */
+} ____cacheline_aligned;
+
+/*
+ * The externally visible workqueue abstraction is an array of
+ * per-CPU workqueues:
+ */
+struct workqueue_struct {
+	struct cpu_workqueue_struct cpu_wq[NR_CPUS];
+	const char *name;
+	struct list_head list; 	/* Empty if single thread */
+};
+
+/* All the per-cpu workqueues on the system, for hotplug cpu to add/remove
+   threads to each one as cpus come/go. */
+static spinlock_t workqueue_lock = SPIN_LOCK_UNLOCKED;
+static LIST_HEAD(workqueues);
+
+/* If it's single threaded, it isn't in the list of workqueues. */
+static inline int is_single_threaded(struct workqueue_struct *wq)
+{
+	return list_empty(&wq->list);
+}
+
+/* Preempt must be disabled. */
+static void __queue_work(struct cpu_workqueue_struct *cwq,
+			 struct work_struct *work)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&cwq->lock, flags);
+	work->wq_data = cwq;
+	list_add_tail(&work->entry, &cwq->worklist);
+	cwq->insert_sequence++;
+	wake_up(&cwq->more_work);
+	spin_unlock_irqrestore(&cwq->lock, flags);
+}
+
+/*
+ * Queue work on a workqueue. Return non-zero if it was successfully
+ * added.
+ *
+ * We queue the work to the CPU it was submitted, but there is no
+ * guarantee that it will be processed by that CPU.
+ */
+int fastcall queue_work(struct workqueue_struct *wq, struct work_struct *work)
+{
+	int ret = 0, cpu = get_cpu();
+
+	if (!test_and_set_bit(0, &work->pending)) {
+		if (unlikely(is_single_threaded(wq)))
+			cpu = 0;
+		BUG_ON(!list_empty(&work->entry));
+		__queue_work(wq->cpu_wq + cpu, work);
+		ret = 1;
+	}
+	put_cpu();
+	return ret;
+}
+
+static void delayed_work_timer_fn(unsigned long __data)
+{
+	struct work_struct *work = (struct work_struct *)__data;
+	struct workqueue_struct *wq = work->wq_data;
+	int cpu = smp_processor_id();
+
+	if (unlikely(is_single_threaded(wq)))
+		cpu = 0;
+
+	__queue_work(wq->cpu_wq + cpu, work);
+}
+
+int fastcall queue_delayed_work(struct workqueue_struct *wq,
+			struct work_struct *work, unsigned long delay)
+{
+	int ret = 0;
+	struct timer_list *timer = &work->timer;
+
+	if (!test_and_set_bit(0, &work->pending)) {
+		BUG_ON(timer_pending(timer));
+		BUG_ON(!list_empty(&work->entry));
+
+		/* This stores wq for the moment, for the timer_fn */
+		work->wq_data = wq;
+		timer->expires = jiffies + delay;
+		timer->data = (unsigned long)work;
+		timer->function = delayed_work_timer_fn;
+		add_timer(timer);
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
+	cwq->run_depth++;
+	if (cwq->run_depth > 3) {
+		/* morton gets to eat his hat */
+		printk("%s: recursion depth exceeded: %d\n",
+			__FUNCTION__, cwq->run_depth);
+		dump_stack();
+	}
+	while (!list_empty(&cwq->worklist)) {
+		struct work_struct *work = list_entry(cwq->worklist.next,
+						struct work_struct, entry);
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
+		spin_lock_irqsave(&cwq->lock, flags);
+		cwq->remove_sequence++;
+		wake_up(&cwq->work_done);
+	}
+	cwq->run_depth--;
+	spin_unlock_irqrestore(&cwq->lock, flags);
+}
+
+static int worker_thread(void *__cwq)
+{
+	struct cpu_workqueue_struct *cwq = __cwq;
+	DECLARE_WAITQUEUE(wait, current);
+	struct k_sigaction sa;
+
+	set_user_nice(current, -10);
+
+	/* Block and flush all signals */
+	spin_lock_irq(&current->sigmask_lock);
+	sigemptyset(&current->blocked);
+	recalc_sigpending(current);
+	flush_signals(current);
+	spin_unlock_irq(&current->sigmask_lock);
+
+	/* SIG_IGN makes children autoreap: see do_notify_parent(). */
+	sa.sa.sa_handler = SIG_IGN;
+	sa.sa.sa_flags = 0;
+	siginitset(&sa.sa.sa_mask, sigmask(SIGCHLD));
+	do_sigaction(SIGCHLD, &sa, (struct k_sigaction *)0);
+
+	set_current_state(TASK_INTERRUPTIBLE);
+	while (!kthread_should_stop()) {
+		add_wait_queue(&cwq->more_work, &wait);
+		if (list_empty(&cwq->worklist))
+			schedule();
+		else
+			__set_current_state(TASK_RUNNING);
+		remove_wait_queue(&cwq->more_work, &wait);
+
+		if (!list_empty(&cwq->worklist))
+			run_workqueue(cwq);
+		set_current_state(TASK_INTERRUPTIBLE);
+	}
+	__set_current_state(TASK_RUNNING);
+	return 0;
+}
+
+static void flush_cpu_workqueue(struct cpu_workqueue_struct *cwq)
+{
+	if (cwq->thread == current) {
+		/*
+		 * Probably keventd trying to flush its own queue. So simply run
+		 * it by hand rather than deadlocking.
+		 */
+		run_workqueue(cwq);
+	} else {
+		DEFINE_WAIT(wait);
+		long sequence_needed;
+
+		spin_lock_irq(&cwq->lock);
+		sequence_needed = cwq->insert_sequence;
+
+		while (sequence_needed - cwq->remove_sequence > 0) {
+			prepare_to_wait(&cwq->work_done, &wait,
+					TASK_UNINTERRUPTIBLE);
+			spin_unlock_irq(&cwq->lock);
+			schedule();
+			spin_lock_irq(&cwq->lock);
+		}
+		finish_wait(&cwq->work_done, &wait);
+		spin_unlock_irq(&cwq->lock);
+	}
+}
+
+/*
+ * flush_workqueue - ensure that any scheduled work has run to completion.
+ *
+ * Forces execution of the workqueue and blocks until its completion.
+ * This is typically used in driver shutdown handlers.
+ *
+ * This function will sample each workqueue's current insert_sequence number and
+ * will sleep until the head sequence is greater than or equal to that.  This
+ * means that we sleep until all works which were queued on entry have been
+ * handled, but we are not livelocked by new incoming ones.
+ *
+ * This function used to run the workqueues itself.  Now we just wait for the
+ * helper threads to do it.
+ */
+void fastcall flush_workqueue(struct workqueue_struct *wq)
+{
+	if (is_single_threaded(wq)) {
+		/* Always use cpu 0's area. */
+		flush_cpu_workqueue(wq->cpu_wq + 0);
+	} else {
+		int cpu;
+
+		lock_cpu_hotplug();
+		for_each_online_cpu(cpu)
+			flush_cpu_workqueue(wq->cpu_wq + cpu);
+		unlock_cpu_hotplug();
+	}
+}
+
+static struct task_struct *create_workqueue_thread(struct workqueue_struct *wq,
+						   int cpu)
+{
+	struct cpu_workqueue_struct *cwq = wq->cpu_wq + cpu;
+	struct task_struct *p;
+
+	spin_lock_init(&cwq->lock);
+	cwq->wq = wq;
+	cwq->thread = NULL;
+	cwq->insert_sequence = 0;
+	cwq->remove_sequence = 0;
+	INIT_LIST_HEAD(&cwq->worklist);
+	init_waitqueue_head(&cwq->more_work);
+	init_waitqueue_head(&cwq->work_done);
+
+	if (is_single_threaded(wq))
+		p = kthread_create(worker_thread, cwq, "%s", wq->name);
+	else
+		p = kthread_create(worker_thread, cwq, "%s/%d", wq->name, cpu);
+	if (IS_ERR(p))
+		return NULL;
+	cwq->thread = p;
+	return p;
+}
+
+struct workqueue_struct *__create_workqueue(const char *name,
+					    int singlethread)
+{
+	int cpu, destroy = 0;
+	struct workqueue_struct *wq;
+	struct task_struct *p;
+
+	BUG_ON(strlen(name) > 10);
+
+	wq = kmalloc(sizeof(*wq), GFP_KERNEL);
+	if (!wq)
+		return NULL;
+	memset(wq, 0, sizeof(*wq));
+
+	wq->name = name;
+	/* We don't need the distraction of CPUs appearing and vanishing. */
+	lock_cpu_hotplug();
+	if (singlethread) {
+		INIT_LIST_HEAD(&wq->list);
+		p = create_workqueue_thread(wq, 0);
+		if (!p)
+			destroy = 1;
+		else
+			wake_up_process(p);
+	} else {
+		spin_lock(&workqueue_lock);
+		list_add(&wq->list, &workqueues);
+		spin_unlock(&workqueue_lock);
+		for_each_online_cpu(cpu) {
+			p = create_workqueue_thread(wq, cpu);
+			if (p) {
+				kthread_bind(p, cpu);
+				wake_up_process(p);
+			} else
+				destroy = 1;
+		}
+	}
+	unlock_cpu_hotplug();
+
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
+static void cleanup_workqueue_thread(struct workqueue_struct *wq, int cpu)
+{
+	struct cpu_workqueue_struct *cwq;
+	unsigned long flags;
+	struct task_struct *p;
+
+	cwq = wq->cpu_wq + cpu;
+	spin_lock_irqsave(&cwq->lock, flags);
+	p = cwq->thread;
+	cwq->thread = NULL;
+	spin_unlock_irqrestore(&cwq->lock, flags);
+	if (p)
+		kthread_stop(p);
+}
+
+void destroy_workqueue(struct workqueue_struct *wq)
+{
+	int cpu;
+
+	flush_workqueue(wq);
+
+	/* We don't need the distraction of CPUs appearing and vanishing. */
+	lock_cpu_hotplug();
+	if (is_single_threaded(wq))
+		cleanup_workqueue_thread(wq, 0);
+	else {
+		for_each_online_cpu(cpu)
+			cleanup_workqueue_thread(wq, cpu);
+		spin_lock(&workqueue_lock);
+		list_del(&wq->list);
+		spin_unlock(&workqueue_lock);
+	}
+	unlock_cpu_hotplug();
+	kfree(wq);
+}
+
+static struct workqueue_struct *keventd_wq;
+
+int fastcall schedule_work(struct work_struct *work)
+{
+	return queue_work(keventd_wq, work);
+}
+
+int fastcall schedule_delayed_work(struct work_struct *work, unsigned long delay)
+{
+	return queue_delayed_work(keventd_wq, work, delay);
+}
+
+int schedule_delayed_work_on(int cpu,
+			struct work_struct *work, unsigned long delay)
+{
+	int ret = 0;
+	struct timer_list *timer = &work->timer;
+
+	if (!test_and_set_bit(0, &work->pending)) {
+		BUG_ON(timer_pending(timer));
+		BUG_ON(!list_empty(&work->entry));
+		/* This stores keventd_wq for the moment, for the timer_fn */
+		work->wq_data = keventd_wq;
+		timer->expires = jiffies + delay;
+		timer->data = (unsigned long)work;
+		timer->function = delayed_work_timer_fn;
+		add_timer_on(timer, cpu);
+		ret = 1;
+	}
+	return ret;
+}
+
+void flush_scheduled_work(void)
+{
+	flush_workqueue(keventd_wq);
+}
+
+int keventd_up(void)
+{
+	return keventd_wq != NULL;
+}
+
+int current_is_keventd(void)
+{
+	struct cpu_workqueue_struct *cwq;
+	int cpu = smp_processor_id();	/* preempt-safe: keventd is per-cpu */
+	int ret = 0;
+
+	BUG_ON(!keventd_wq);
+
+	cwq = keventd_wq->cpu_wq + cpu;
+	if (current == cwq->thread)
+		ret = 1;
+
+	return ret;
+
+}
+
+#ifdef CONFIG_HOTPLUG_CPU
+/* Take the work from this (downed) CPU. */
+static void take_over_work(struct workqueue_struct *wq, unsigned int cpu)
+{
+	struct cpu_workqueue_struct *cwq = wq->cpu_wq + cpu;
+	LIST_HEAD(list);
+	struct work_struct *work;
+
+	spin_lock_irq(&cwq->lock);
+	list_splice_init(&cwq->worklist, &list);
+
+	while (!list_empty(&list)) {
+		printk("Taking work for %s\n", wq->name);
+		work = list_entry(list.next,struct work_struct,entry);
+		list_del(&work->entry);
+		__queue_work(wq->cpu_wq + smp_processor_id(), work);
+	}
+	spin_unlock_irq(&cwq->lock);
+}
+
+/* We're holding the cpucontrol mutex here */
+static int __devinit workqueue_cpu_callback(struct notifier_block *nfb,
+				  unsigned long action,
+				  void *hcpu)
+{
+	unsigned int hotcpu = (unsigned long)hcpu;
+	struct workqueue_struct *wq;
+
+	switch (action) {
+	case CPU_UP_PREPARE:
+		/* Create a new workqueue thread for it. */
+		list_for_each_entry(wq, &workqueues, list) {
+			if (create_workqueue_thread(wq, hotcpu) < 0) {
+				printk("workqueue for %i failed\n", hotcpu);
+				return NOTIFY_BAD;
+			}
+		}
+		break;
+
+	case CPU_ONLINE:
+		/* Kick off worker threads. */
+		list_for_each_entry(wq, &workqueues, list)
+			wake_up_process(wq->cpu_wq[hotcpu].thread);
+		break;
+
+	case CPU_UP_CANCELED:
+		list_for_each_entry(wq, &workqueues, list) {
+			/* Unbind so it can run. */
+			kthread_bind(wq->cpu_wq[hotcpu].thread,
+				     smp_processor_id());
+			cleanup_workqueue_thread(wq, hotcpu);
+		}
+		break;
+
+	case CPU_DEAD:
+		list_for_each_entry(wq, &workqueues, list)
+			cleanup_workqueue_thread(wq, hotcpu);
+		list_for_each_entry(wq, &workqueues, list)
+			take_over_work(wq, hotcpu);
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+#endif
+
+void init_workqueues(void)
+{
+#ifdef CONFIG_HOTPLUG_CPU
+	hotcpu_notifier(workqueue_cpu_callback, 0);
+#endif
+	keventd_wq = create_workqueue("events");
+	BUG_ON(!keventd_wq);
+}
+
+EXPORT_SYMBOL_GPL(__create_workqueue);
+EXPORT_SYMBOL_GPL(queue_work);
+EXPORT_SYMBOL_GPL(queue_delayed_work);
+EXPORT_SYMBOL_GPL(flush_workqueue);
+EXPORT_SYMBOL_GPL(destroy_workqueue);
+
+EXPORT_SYMBOL(schedule_work);
+EXPORT_SYMBOL(schedule_delayed_work);
+EXPORT_SYMBOL(schedule_delayed_work_on);
+EXPORT_SYMBOL(flush_scheduled_work);

--------------040205060809010803010606--
