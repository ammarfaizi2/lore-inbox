Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbVK2Be0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbVK2Be0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 20:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbVK2BeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 20:34:25 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:16318 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932304AbVK2BeR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 20:34:17 -0500
Date: Tue, 29 Nov 2005 02:34:16 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] ptimer core
Message-ID: <Pine.LNX.4.61.0511290234100.2773@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This introduces the core of ptimer, this is just the basic
infrastructure and still uses jiffies, so it's not really precise just
yet. Basically it's just a reimplementation of normal kernel timer only
using rbtree instead.
The main differences to normal kernel timer:
- ptimer_stop() is synchronous and is so the counterpart to del_timer_sync().
- struct ptimer has no data field, as the this structure is usually embedded
  in other structures, it's simpler to just use container_of().
- the callback has a return value to signal a restart, this avoids an
  explicit ptimer_start and simplifies interval timer.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 fs/exec.c                    |    6 
 include/linux/posix-timers.h |    3 
 include/linux/ptimer.h       |   50 ++++++
 include/linux/sched.h        |    4 
 include/linux/timer.h        |    1 
 init/main.c                  |    1 
 kernel/Makefile              |    2 
 kernel/exit.c                |    2 
 kernel/fork.c                |    5 
 kernel/itimer.c              |   24 +-
 kernel/posix-timers.c        |   39 ++--
 kernel/ptimer.c              |  352 +++++++++++++++++++++++++++++++++++++++++++
 kernel/timer.c               |    1 
 13 files changed, 449 insertions(+), 41 deletions(-)

Index: linux-2.6-mm/fs/exec.c
===================================================================
--- linux-2.6-mm.orig/fs/exec.c	2005-11-28 22:32:47.000000000 +0100
+++ linux-2.6-mm/fs/exec.c	2005-11-28 22:44:51.000000000 +0100
@@ -642,10 +642,10 @@ static inline int de_thread(struct task_
 		 * synchronize with any firing (by calling del_timer_sync)
 		 * before we can safely let the old group leader die.
 		 */
-		sig->real_timer.data = (unsigned long)current;
+		sig->tsk = current;
 		spin_unlock_irq(lock);
-		if (del_timer_sync(&sig->real_timer))
-			add_timer(&sig->real_timer);
+		if (ptimer_stop(&sig->real_timer))
+			ptimer_start(&sig->real_timer);
 		spin_lock_irq(lock);
 	}
 	while (atomic_read(&sig->count) > count) {
Index: linux-2.6-mm/include/linux/posix-timers.h
===================================================================
--- linux-2.6-mm.orig/include/linux/posix-timers.h	2005-11-28 22:32:47.000000000 +0100
+++ linux-2.6-mm/include/linux/posix-timers.h	2005-11-28 22:44:51.000000000 +0100
@@ -4,6 +4,7 @@
 #include <linux/spinlock.h>
 #include <linux/list.h>
 #include <linux/sched.h>
+#include <linux/ptimer.h>
 
 union cpu_time_count {
 	cputime_t cpu;
@@ -51,7 +52,7 @@ struct k_itimer {
 	struct sigqueue *sigq;		/* signal queue entry. */
 	union {
 		struct {
-			struct timer_list timer;
+			struct ptimer timer;
 			struct list_head abs_timer_entry; /* clock abs_timer_list */
 			struct timespec wall_to_prev;   /* wall_to_monotonic used when set */
 			unsigned long incr; /* interval in jiffies */
Index: linux-2.6-mm/include/linux/ptimer.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-mm/include/linux/ptimer.h	2005-11-28 22:44:51.000000000 +0100
@@ -0,0 +1,50 @@
+/*
+ *  ptimer - high-precision kernel timers
+ *
+ *   Copyright(C) 2005, Thomas Gleixner <tglx@linutronix.de>
+ *   Copyright(C) 2005, Red Hat, Inc., Ingo Molnar
+ *   Copyright(C) 2005, Roman Zippel <zippel@linux-m68k.org>
+ *
+ *  data type definitions, declarations, prototypes
+ *
+ *  Started by: Thomas Gleixner and Ingo Molnar
+ *
+ *  For licencing details see kernel-base/COPYING
+ */
+
+#ifndef _LINUX_PTIMER_H
+#define _LINUX_PTIMER_H
+
+#include <linux/rbtree.h>
+#include <linux/wait.h>
+
+struct ptimer_base {
+	int index;
+	spinlock_t lock;
+	struct rb_root root;
+	struct rb_node *first_node;
+	struct ptimer *running_timer;
+	unsigned long last_expired;
+};
+
+struct ptimer {
+	struct ptimer_base *base;
+	struct rb_node node;
+	unsigned long expires;
+	int (*function)(struct ptimer *);
+};
+
+extern void ptimer_init(struct ptimer *timer, int base);
+extern void ptimer_start(struct ptimer *timer);
+extern void ptimer_modify(struct ptimer *timer, unsigned long);
+extern int ptimer_stop(struct ptimer *timer);
+extern int ptimer_try_to_stop(struct ptimer *timer);
+
+extern int ptimer_active(struct ptimer *timer);
+
+extern void ptimer_run_queues(void);
+extern void init_ptimers(void);
+
+extern int it_real_fn(struct ptimer *);
+
+#endif
Index: linux-2.6-mm/include/linux/sched.h
===================================================================
--- linux-2.6-mm.orig/include/linux/sched.h	2005-11-28 22:32:47.000000000 +0100
+++ linux-2.6-mm/include/linux/sched.h	2005-11-28 22:44:51.000000000 +0100
@@ -104,6 +104,7 @@ extern unsigned long nr_iowait(void);
 #include <linux/param.h>
 #include <linux/resource.h>
 #include <linux/timer.h>
+#include <linux/ptimer.h>
 
 #include <asm/processor.h>
 
@@ -402,7 +403,8 @@ struct signal_struct {
 	struct list_head posix_timers;
 
 	/* ITIMER_REAL timer for the process */
-	struct timer_list real_timer;
+	struct ptimer real_timer;
+	struct task_struct *tsk;
 	unsigned long it_real_value, it_real_incr;
 
 	/* ITIMER_PROF and ITIMER_VIRTUAL timers for the process */
Index: linux-2.6-mm/include/linux/timer.h
===================================================================
--- linux-2.6-mm.orig/include/linux/timer.h	2005-11-28 22:32:47.000000000 +0100
+++ linux-2.6-mm/include/linux/timer.h	2005-11-28 22:44:51.000000000 +0100
@@ -96,6 +96,5 @@ static inline void add_timer(struct time
 
 extern void init_timers(void);
 extern void run_local_timers(void);
-extern void it_real_fn(unsigned long);
 
 #endif
Index: linux-2.6-mm/init/main.c
===================================================================
--- linux-2.6-mm.orig/init/main.c	2005-11-28 22:32:47.000000000 +0100
+++ linux-2.6-mm/init/main.c	2005-11-28 22:44:51.000000000 +0100
@@ -487,6 +487,7 @@ asmlinkage void __init start_kernel(void
 	init_IRQ();
 	pidhash_init();
 	init_timers();
+	init_ptimers();
 	softirq_init();
 	time_init();
 
Index: linux-2.6-mm/kernel/Makefile
===================================================================
--- linux-2.6-mm.orig/kernel/Makefile	2005-11-28 22:32:47.000000000 +0100
+++ linux-2.6-mm/kernel/Makefile	2005-11-28 22:44:51.000000000 +0100
@@ -7,7 +7,7 @@ obj-y     = sched.o fork.o exec_domain.o
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
-	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o
+	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o ptimer.o
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
Index: linux-2.6-mm/kernel/exit.c
===================================================================
--- linux-2.6-mm.orig/kernel/exit.c	2005-11-28 22:32:47.000000000 +0100
+++ linux-2.6-mm/kernel/exit.c	2005-11-28 22:44:51.000000000 +0100
@@ -842,7 +842,7 @@ fastcall NORET_TYPE void do_exit(long co
 	}
 	group_dead = atomic_dec_and_test(&tsk->signal->live);
 	if (group_dead) {
- 		del_timer_sync(&tsk->signal->real_timer);
+ 		ptimer_stop(&tsk->signal->real_timer);
 		exit_itimers(tsk->signal);
 		acct_process(code);
 	}
Index: linux-2.6-mm/kernel/fork.c
===================================================================
--- linux-2.6-mm.orig/kernel/fork.c	2005-11-28 22:32:47.000000000 +0100
+++ linux-2.6-mm/kernel/fork.c	2005-11-28 22:44:51.000000000 +0100
@@ -42,6 +42,7 @@
 #include <linux/profile.h>
 #include <linux/rmap.h>
 #include <linux/acct.h>
+#include <linux/ptimer.h>
 #include <linux/cn_proc.h>
 
 #include <asm/pgtable.h>
@@ -794,9 +795,9 @@ static inline int copy_signal(unsigned l
 	INIT_LIST_HEAD(&sig->posix_timers);
 
 	sig->it_real_value = sig->it_real_incr = 0;
+	ptimer_init(&sig->real_timer, CLOCK_MONOTONIC);
 	sig->real_timer.function = it_real_fn;
-	sig->real_timer.data = (unsigned long) tsk;
-	init_timer(&sig->real_timer);
+	sig->tsk = tsk;
 
 	sig->it_virt_expires = cputime_zero;
 	sig->it_virt_incr = cputime_zero;
Index: linux-2.6-mm/kernel/itimer.c
===================================================================
--- linux-2.6-mm.orig/kernel/itimer.c	2005-11-28 22:32:47.000000000 +0100
+++ linux-2.6-mm/kernel/itimer.c	2005-11-28 22:44:51.000000000 +0100
@@ -18,7 +18,7 @@
 static unsigned long it_real_value(struct signal_struct *sig)
 {
 	unsigned long val = 0;
-	if (timer_pending(&sig->real_timer)) {
+	if (ptimer_active(&sig->real_timer)) {
 		val = sig->real_timer.expires - jiffies;
 
 		/* look out for negative/zero itimer.. */
@@ -113,12 +113,12 @@ asmlinkage long sys_getitimer(int which,
 }
 
 
-void it_real_fn(unsigned long __data)
+int it_real_fn(struct ptimer *timer)
 {
-	struct task_struct * p = (struct task_struct *) __data;
-	unsigned long inc = p->signal->it_real_incr;
+	struct signal_struct *sig = container_of(timer, struct signal_struct, real_timer);
+	unsigned long inc = sig->it_real_incr;
 
-	send_group_sig_info(SIGALRM, SEND_SIG_PRIV, p);
+	send_group_sig_info(SIGALRM, SEND_SIG_PRIV, sig->tsk);
 
 	/*
 	 * Now restart the timer if necessary.  We don't need any locking
@@ -131,10 +131,10 @@ void it_real_fn(unsigned long __data)
 	 * in add_timer.
 	 */
 	if (!inc)
-		return;
-	while (time_before_eq(p->signal->real_timer.expires, jiffies))
-		p->signal->real_timer.expires += inc;
-	add_timer(&p->signal->real_timer);
+		return 0;
+	while (time_before_eq(sig->real_timer.expires, jiffies))
+		sig->real_timer.expires += inc;
+	return 1;
 }
 
 int do_setitimer(int which, struct itimerval *value, struct itimerval *ovalue)
@@ -150,7 +150,7 @@ again:
 		interval = tsk->signal->it_real_incr;
 		val = it_real_value(tsk->signal);
 		/* We are sharing ->siglock with it_real_fn() */
-		if (try_to_del_timer_sync(&tsk->signal->real_timer) < 0) {
+		if (ptimer_try_to_stop(&tsk->signal->real_timer) < 0) {
 			spin_unlock_irq(&tsk->sighand->siglock);
 			goto again;
 		}
@@ -158,8 +158,8 @@ again:
 			timeval_to_jiffies(&value->it_interval);
 		expires = timeval_to_jiffies(&value->it_value);
 		if (expires)
-			mod_timer(&tsk->signal->real_timer,
-				  jiffies + 1 + expires);
+			ptimer_modify(&tsk->signal->real_timer,
+				      jiffies + 1 + expires);
 		spin_unlock_irq(&tsk->sighand->siglock);
 		if (ovalue) {
 			jiffies_to_timeval(val, &ovalue->it_value);
Index: linux-2.6-mm/kernel/posix-timers.c
===================================================================
--- linux-2.6-mm.orig/kernel/posix-timers.c	2005-11-28 22:32:47.000000000 +0100
+++ linux-2.6-mm/kernel/posix-timers.c	2005-11-28 22:44:51.000000000 +0100
@@ -155,7 +155,7 @@ static struct k_clock posix_clocks[MAX_C
 static struct k_clock_abs abs_list = {.list = LIST_HEAD_INIT(abs_list.list),
 				      .lock = SPIN_LOCK_UNLOCKED};
 
-static void posix_timer_fn(unsigned long);
+static int posix_timer_fn(struct ptimer *timer);
 static u64 do_posix_clock_monotonic_gettime_parts(
 	struct timespec *tp, struct timespec *mo);
 int do_posix_clock_monotonic_gettime(struct timespec *tp);
@@ -206,8 +206,7 @@ static inline int common_clock_set(clock
 static inline int common_timer_create(struct k_itimer *new_timer)
 {
 	INIT_LIST_HEAD(&new_timer->it.real.abs_timer_entry);
-	init_timer(&new_timer->it.real.timer);
-	new_timer->it.real.timer.data = (unsigned long) new_timer;
+	ptimer_init(&new_timer->it.real.timer, CLOCK_MONOTONIC);
 	new_timer->it.real.timer.function = posix_timer_fn;
 	return 0;
 }
@@ -334,7 +333,7 @@ static void remove_from_abslist(struct k
 	}
 }
 
-static void schedule_next_timer(struct k_itimer *timr)
+static int schedule_next_timer(struct k_itimer *timr)
 {
 	struct timespec new_wall_to;
 	struct now_struct now;
@@ -354,7 +353,7 @@ static void schedule_next_timer(struct k
 	 * also be added to the k_clock structure).
 	 */
 	if (!timr->it.real.incr)
-		return;
+		return 0;
 
 	do {
 		seq = read_seqbegin(&xtime_lock);
@@ -375,7 +374,7 @@ static void schedule_next_timer(struct k
 	timr->it_overrun_last = timr->it_overrun;
 	timr->it_overrun = -1;
 	++timr->it_requeue_pending;
-	add_timer(&timr->it.real.timer);
+	return 1;
 }
 
 /*
@@ -401,8 +400,8 @@ void do_schedule_next_timer(struct sigin
 
 	if (timr->it_clock < 0)	/* CPU clock */
 		posix_cpu_timer_schedule(timr);
-	else
-		schedule_next_timer(timr);
+	else if (schedule_next_timer(timr))
+		ptimer_start(&timr->it.real.timer);
 	info->si_overrun = timr->it_overrun_last;
 exit:
 	if (timr)
@@ -454,14 +453,14 @@ EXPORT_SYMBOL_GPL(posix_timer_event);
 
  * This code is for CLOCK_REALTIME* and CLOCK_MONOTONIC* timers.
  */
-static void posix_timer_fn(unsigned long __data)
+static int posix_timer_fn(struct ptimer *timer)
 {
-	struct k_itimer *timr = (struct k_itimer *) __data;
+	struct k_itimer *timr = container_of(timer, struct k_itimer, it.real.timer);
 	unsigned long flags;
 	unsigned long seq;
 	struct timespec delta, new_wall_to;
 	u64 exp = 0;
-	int do_notify = 1;
+	int do_notify = 1, do_restart = 0;
 
 	spin_lock_irqsave(&timr->it_lock, flags);
 	if (!list_empty(&timr->it.real.abs_timer_entry)) {
@@ -486,8 +485,8 @@ static void posix_timer_fn(unsigned long
 				   &exp);
 			timr->it.real.wall_to_prev = new_wall_to;
 			timr->it.real.timer.expires += exp;
-			add_timer(&timr->it.real.timer);
 			do_notify = 0;
+			do_restart = 1;
 		}
 		spin_unlock(&abs_list.lock);
 
@@ -507,9 +506,11 @@ static void posix_timer_fn(unsigned long
 			 * we will not get a call back to restart it AND
 			 * it should be restarted.
 			 */
-			schedule_next_timer(timr);
+			do_restart = schedule_next_timer(timr);
 	}
 	unlock_timer(timr, flags); /* hold thru abs lock to keep irq off */
+
+	return do_restart;
 }
 
 
@@ -797,7 +798,7 @@ common_timer_get(struct k_itimer *timr, 
 			expires = timr->it.real.timer.expires;
 		}
 		else
-			if (!timer_pending(&timr->it.real.timer))
+			if (!ptimer_active(&timr->it.real.timer))
 				expires = 0;
 		if (expires)
 			expires -= now.jiffies;
@@ -955,7 +956,7 @@ common_timer_set(struct k_itimer *timr, 
 	 * careful here.  If smp we could be in the "fire" routine which will
 	 * be spinning as we hold the lock.  But this is ONLY an SMP issue.
 	 */
-	if (try_to_del_timer_sync(&timr->it.real.timer) < 0) {
+	if (ptimer_try_to_stop(&timr->it.real.timer) < 0) {
 #ifdef CONFIG_SMP
 		/*
 		 * It can only be active if on an other cpu.  Since
@@ -997,7 +998,7 @@ common_timer_set(struct k_itimer *timr, 
 	 * in the abs list so we can do that right.
 	 */
 	if (((timr->it_sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_NONE))
-		add_timer(&timr->it.real.timer);
+		ptimer_start(&timr->it.real.timer);
 
 	if (flags & TIMER_ABSTIME && clock->abs_struct) {
 		spin_lock(&clock->abs_struct->lock);
@@ -1054,7 +1055,7 @@ static inline int common_timer_del(struc
 {
 	timer->it.real.incr = 0;
 
-	if (try_to_del_timer_sync(&timer->it.real.timer) < 0) {
+	if (ptimer_try_to_stop(&timer->it.real.timer) < 0) {
 #ifdef CONFIG_SMP
 		/*
 		 * It can only be active if on an other cpu.  Since
@@ -1383,8 +1384,8 @@ void clock_was_set(void)
 
 		list_del_init(&timr->it.real.abs_timer_entry);
 		if (add_clockset_delta(timr, &new_wall_to) &&
-		    del_timer(&timr->it.real.timer))  /* timer run yet? */
-			add_timer(&timr->it.real.timer);
+		    ptimer_stop(&timr->it.real.timer))  /* timer run yet? */
+			ptimer_start(&timr->it.real.timer);
 		list_add(&timr->it.real.abs_timer_entry, &abs_list.list);
 		spin_unlock_irq(&abs_list.lock);
 	} while (1);
Index: linux-2.6-mm/kernel/ptimer.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-mm/kernel/ptimer.c	2005-11-28 22:44:51.000000000 +0100
@@ -0,0 +1,352 @@
+/*
+ *  Copyright(C) 2005, Thomas Gleixner <tglx@linutronix.de>
+ *  Copyright(C) 2005, Red Hat, Inc., Ingo Molnar
+ *  Copyright(C) 2005, Roman Zippel <zippel@linux-m68k.org>
+ *
+ *  High-precision kernel timers
+ *
+ *  In contrast to the low-resolution timeout API implemented in
+ *  kernel/timer.c, ptimer can provide finer resolution and
+ *  accuracy depending on system configuration and capabilities.
+ *
+ *  These timers are currently used for:
+ *   - itimers
+ *   - POSIX timers
+ *   - nanosleep
+ *   - precise in-kernel timing
+ *
+ *  Started by: Thomas Gleixner and Ingo Molnar
+ *
+ *  Credits:
+ *	based on kernel/timer.c
+ *
+ *  For licencing details see kernel-base/COPYING
+ */
+
+#include <linux/cpu.h>
+#include <linux/jiffies.h>
+#include <linux/notifier.h>
+#include <linux/ptimer.h>
+#include <linux/percpu.h>
+#include <linux/spinlock.h>
+#include <linux/wait.h>
+
+#define PTIMER_INACTIVE	((void *)1)
+
+#define MAX_PTIMER_BASES       2
+static DEFINE_PER_CPU(struct ptimer_base, ptimer_bases[MAX_PTIMER_BASES]);
+
+/**
+ * ptimer_init - initialize a timer
+ *
+ * @timer:	the timer to be initialized
+ * @base:	clock source for timer
+ */
+void ptimer_init(struct ptimer *timer, int base)
+{
+	memset(timer, 0, sizeof(struct ptimer));
+	timer->base = &per_cpu(ptimer_bases[base], raw_smp_processor_id());
+	timer->node.rb_parent = PTIMER_INACTIVE;
+}
+
+int ptimer_active(struct ptimer *timer)
+{
+	return timer->node.rb_parent != PTIMER_INACTIVE;
+}
+
+static struct ptimer_base *ptimer_lock_base(struct ptimer *timer,
+					    unsigned long *flags)
+{
+	struct ptimer_base *base;
+
+	base = timer->base;
+	spin_lock_irqsave(&base->lock, *flags);
+	while (unlikely(base != timer->base)) {
+		/* The timer has migrated to another CPU */
+		spin_unlock(&base->lock);
+		cpu_relax();
+		base = timer->base;
+		spin_lock(&base->lock);
+	}
+	return base;
+}
+
+static void ptimer_enqueue(struct ptimer_base *base, struct ptimer *timer)
+{
+	struct ptimer *entry;
+	struct rb_node *parent, **link;
+
+	parent = base->first_node;
+	entry = rb_entry(parent, struct ptimer, node);
+	link = &base->root.rb_node;
+
+	if (!parent)
+		base->first_node = &timer->node;
+	else if (time_before(timer->expires, entry->expires)) {
+		link = &parent->rb_left;
+		base->first_node = &timer->node;
+	} else {
+		do {
+			parent = *link;
+			entry = rb_entry(parent, struct ptimer, node);
+			/*
+			 * We dont care about collisions. Nodes with
+			 * the same expiry time stay together.
+			 */
+			if (time_before(timer->expires, entry->expires))
+				link = &parent->rb_left;
+			else
+				link = &parent->rb_right;
+		} while (*link);
+	}
+
+	rb_link_node(&timer->node, parent, link);
+	rb_insert_color(&timer->node, &base->root);
+}
+
+static inline void ptimer_dequeue(struct ptimer *timer, int clear_active)
+{
+	struct ptimer_base *base = timer->base;
+
+	if (&timer->node == base->first_node)
+		base->first_node = rb_next(base->first_node);
+	rb_erase(&timer->node, &base->root);
+	if (clear_active)
+		timer->node.rb_parent = PTIMER_INACTIVE;
+}
+
+/*
+ * ptimer_start - start a timer
+ *
+ * @timer:	the timer to be started
+ *
+ * The timers function and expires fields must be set prior calling this
+ * function.
+ */
+void ptimer_start(struct ptimer *timer)
+{
+	struct ptimer_base *base;
+	unsigned long flags;
+
+	base = ptimer_lock_base(timer, &flags);
+	BUG_ON(ptimer_active(timer));
+
+	ptimer_enqueue(base, timer);
+
+	spin_unlock_irqrestore(&base->lock, flags);
+}
+
+/**
+ * ptimer_modify - modify a timer
+ *
+ * @timer:	the timer to be modified
+ */
+void ptimer_modify(struct ptimer *timer, unsigned long expires)
+{
+	struct ptimer_base *base, *new_base;
+	unsigned long flags;
+
+	base = ptimer_lock_base(timer, &flags);
+restart:
+	if (ptimer_active(timer))
+		ptimer_dequeue(timer, 0);
+
+	new_base = &per_cpu(ptimer_bases[base->index], raw_smp_processor_id());
+	if (base != new_base && likely(base->running_timer != timer)) {
+		timer->base = new_base;
+		spin_unlock(&base->lock);
+		spin_lock(&new_base->lock);
+		if (unlikely(timer->base != new_base))
+			goto restart;
+		base = new_base;
+	}
+
+	timer->expires = expires;
+	ptimer_enqueue(base, timer);
+
+	spin_unlock_irqrestore(&base->lock, flags);
+}
+
+/**
+ * ptimer_stop - stop a running timer synchronously
+ *
+ * @timer:	the timer to be stopped
+ *
+ * Stop a running timmer and make sure the timer is not running on
+ * another cpu. Return 1 if the timer was active and had been
+ * deactivated.
+ */
+int ptimer_stop(struct ptimer *timer)
+{
+	struct ptimer_base *base;
+	unsigned long flags;
+	int res;
+
+restart:
+	base = ptimer_lock_base(timer, &flags);
+	res = ptimer_active(timer);
+	if (res)
+		ptimer_dequeue(timer, 1);
+	if (unlikely(base->running_timer == timer)) {
+		spin_unlock_irqrestore(&base->lock, flags);
+		goto restart;
+	}
+
+	spin_unlock_irqrestore(&base->lock, flags);
+	return res;
+}
+
+/**
+ * ptimer_try_to_stop - try to stop a running timer
+ *
+ * @timer:	the timer to be stopped
+ *
+ * Try to stop a running timer, this function will fail to stop it
+ * and return -1, when the timer is running on another cpu.
+ * Otherwise it will behave like ptimer_stop and return 1 if the
+ * timer was active had been stopped.
+ */
+int ptimer_try_to_stop(struct ptimer *timer)
+{
+	struct ptimer_base *base;
+	unsigned long flags;
+	int res = -1;
+
+	base = ptimer_lock_base(timer, &flags);
+	if (unlikely(base->running_timer == timer))
+		goto out;
+	res = ptimer_active(timer);
+	if (res)
+		ptimer_dequeue(timer, 1);
+out:
+	spin_unlock_irqrestore(&base->lock, flags);
+	return res;
+}
+
+static inline void ptimer_run_queue(struct ptimer_base *base)
+{
+	struct ptimer *timer;
+	struct rb_node *node;
+	unsigned long now;
+	int res;
+
+	spin_lock(&base->lock);
+
+	now = base->last_expired;
+	while ((node = base->first_node) != NULL) {
+		timer = rb_entry(node, struct ptimer, node);
+		if (time_before(now, timer->expires))
+			break;
+		base->running_timer = timer;
+		ptimer_dequeue(timer, 1);
+		spin_unlock(&base->lock);
+		res = timer->function(timer);
+		spin_lock(&base->lock);
+		if (res)
+			ptimer_enqueue(base, timer);
+	}
+	base->running_timer = NULL;
+	spin_unlock(&base->lock);
+}
+
+void ptimer_run_queues(void)
+{
+	struct ptimer_base *base;
+
+	base = __get_cpu_var(ptimer_bases);
+	base->last_expired = jiffies;
+	ptimer_run_queue(&base[CLOCK_MONOTONIC]);
+}
+
+/*
+ * Functions related to initialization
+ */
+static void __devinit init_ptimers_cpu(int cpu)
+{
+	struct ptimer_base *base = per_cpu(ptimer_bases, cpu);
+	int i;
+
+	for (i = 0; i < MAX_PTIMER_BASES; i++) {
+		base[i].index = i;
+		base[i].last_expired = jiffies;
+		spin_lock_init(&base[i].lock);
+	}
+}
+
+#ifdef CONFIG_HOTPLUG_CPU
+static void migrate_ptimer_list(struct ptimer_base *old_base,
+				struct ptimer_base *new_base)
+{
+	struct ptimer *timer;
+	struct rb_node *node;
+
+	while ((node = rb_first(&old_base->root))) {
+		timer = rb_entry(node, struct ptimer, node);
+		ptimer_dequeue(timer, 0);
+		timer->base = new_base;
+		ptimer_enqueue(new_base, timer);
+	}
+}
+
+static void __devinit migrate_ptimers(int cpu)
+{
+	struct ptimer_base *old_base;
+	struct ptimer_base *new_base;
+	int i;
+
+	BUG_ON(cpu_online(cpu));
+	old_base = per_cpu(ptimer_bases, cpu);
+	new_base = get_cpu_var(ptimer_bases);
+
+	local_irq_disable();
+
+	for (i = 0; i < MAX_PTIMER_BASES; i++) {
+
+		spin_lock(&new_base->lock);
+		spin_lock(&old_base->lock);
+
+		if (old_base->running_timer)
+			BUG();
+
+		migrate_ptimer_list(old_base, new_base);
+
+		spin_unlock(&old_base->lock);
+		spin_unlock(&new_base->lock);
+		old_base++;
+		new_base++;
+	}
+
+	local_irq_enable();
+	put_cpu_var(ptimer_bases);
+}
+#endif /* CONFIG_HOTPLUG_CPU */
+
+static int __devinit ptimer_cpu_notify(struct notifier_block *self,
+				       unsigned long action, void *hcpu)
+{
+	long cpu = (long)hcpu;
+	switch(action) {
+	case CPU_UP_PREPARE:
+		init_ptimers_cpu(cpu);
+		break;
+#ifdef CONFIG_HOTPLUG_CPU
+	case CPU_DEAD:
+		migrate_ptimers(cpu);
+		break;
+#endif
+	default:
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block __devinitdata ptimers_nb = {
+	.notifier_call = ptimer_cpu_notify,
+};
+
+void __init init_ptimers(void)
+{
+	ptimer_cpu_notify(&ptimers_nb, (unsigned long)CPU_UP_PREPARE,
+			  (void *)(long)smp_processor_id());
+	register_cpu_notifier(&ptimers_nb);
+}
Index: linux-2.6-mm/kernel/timer.c
===================================================================
--- linux-2.6-mm.orig/kernel/timer.c	2005-11-28 22:44:06.000000000 +0100
+++ linux-2.6-mm/kernel/timer.c	2005-11-28 22:44:51.000000000 +0100
@@ -858,6 +858,7 @@ static void run_timer_softirq(struct sof
 {
 	tvec_base_t *base = &__get_cpu_var(tvec_bases);
 
+	ptimer_run_queues();
 	if (time_after_eq(jiffies, base->timer_jiffies))
 		__run_timers(base);
 }
