Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161003AbWI3AEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161003AbWI3AEj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 20:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbWI3AEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 20:04:34 -0400
Received: from www.osadl.org ([213.239.205.134]:35732 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1422854AbWI3AES (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 20:04:18 -0400
Message-Id: <20060929234441.210732000@cruncher.tec.linutronix.de>
References: <20060929234435.330586000@cruncher.tec.linutronix.de>
Date: Fri, 29 Sep 2006 23:58:41 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: [patch 21/23] debugging feature: timer stats
Content-Disposition: inline; filename=timer_stats.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

add /proc/tstats support: debugging feature to profile timer expiration.
Both the starting site, process/PID and the expiration function is
captured. This allows the quick identification of timer event sources
in a system.

sample output:

 # echo 1 > /proc/tstats
 # cat /proc/tstats
 Timerstats sample period: 3.888770 s
   12,     0 swapper          hrtimer_stop_sched_tick (hrtimer_sched_tick)
   15,     1 swapper          hcd_submit_urb (rh_timer_func)
    4,   959 kedac            schedule_timeout (process_timeout)
    1,     0 swapper          page_writeback_init (wb_timer_fn)
   28,     0 swapper          hrtimer_stop_sched_tick (hrtimer_sched_tick)
   22,  2948 IRQ 4            tty_flip_buffer_push (delayed_work_timer_fn)
    3,  3100 bash             schedule_timeout (process_timeout)
    1,     1 swapper          queue_delayed_work_on (delayed_work_timer_fn)
    1,     1 swapper          queue_delayed_work_on (delayed_work_timer_fn)
    1,     1 swapper          neigh_table_init_no_netlink (neigh_periodic_timer)
    1,  2292 ip               __netdev_watchdog_up (dev_watchdog)
    1,    23 events/1         do_cache_clean (delayed_work_timer_fn)
 90 total events, 30.0 events/sec

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
--
 include/linux/hrtimer.h   |   44 ++++++++
 include/linux/timer.h     |   48 +++++++++
 kernel/hrtimer.c          |   26 +++++
 kernel/time/Makefile      |    3 
 kernel/time/timer_stats.c |  227 ++++++++++++++++++++++++++++++++++++++++++++++
 kernel/timer.c            |   29 +++++
 kernel/workqueue.c        |    8 +
 lib/Kconfig.debug         |   11 ++
 8 files changed, 391 insertions(+), 5 deletions(-)

Index: linux-2.6.18-mm2/include/linux/hrtimer.h
===================================================================
--- linux-2.6.18-mm2.orig/include/linux/hrtimer.h	2006-09-30 01:41:18.000000000 +0200
+++ linux-2.6.18-mm2/include/linux/hrtimer.h	2006-09-30 01:41:20.000000000 +0200
@@ -74,6 +74,11 @@ struct hrtimer {
 	int				cb_mode;
 	struct list_head		cb_entry;
 #endif
+#ifdef CONFIG_TIMER_STATS
+	void				*start_site;
+	char				start_comm[16];
+	int				start_pid;
+#endif
 };
 
 /**
@@ -258,4 +263,43 @@ static inline int hrtimer_stop_sched_tic
 /* Bootup initialization: */
 extern void __init hrtimers_init(void);
 
+/*
+ * Timer-statistics info:
+ */
+#ifdef CONFIG_TIMER_STATS
+
+extern void tstats_update_stats(void *timer, pid_t pid, void *startf,
+				void *timerf, char * comm);
+
+static inline void tstats_account_hrtimer(struct hrtimer *timer)
+{
+	tstats_update_stats(timer, timer->start_pid, timer->start_site,
+			    timer->function, timer->start_comm);
+}
+
+extern void __tstats_hrtimer_set_start_info(struct hrtimer *timer, void *addr);
+
+static inline void tstats_hrtimer_set_start_info(struct hrtimer *timer)
+{
+	__tstats_hrtimer_set_start_info(timer, __builtin_return_address(0));
+}
+
+static inline void tstats_hrtimer_clear_start_info(struct hrtimer *timer)
+{
+	timer->start_site = NULL;
+}
+#else
+static inline void tstats_account_hrtimer(struct hrtimer *timer)
+{
+}
+
+static inline void tstats_hrtimer_set_start_info(struct hrtimer *timer)
+{
+}
+
+static inline void tstats_hrtimer_clear_start_info(struct hrtimer *timer)
+{
+}
+#endif
+
 #endif
Index: linux-2.6.18-mm2/include/linux/timer.h
===================================================================
--- linux-2.6.18-mm2.orig/include/linux/timer.h	2006-09-30 01:41:19.000000000 +0200
+++ linux-2.6.18-mm2/include/linux/timer.h	2006-09-30 01:41:20.000000000 +0200
@@ -2,6 +2,7 @@
 #define _LINUX_TIMER_H
 
 #include <linux/list.h>
+#include <linux/ktime.h>
 #include <linux/spinlock.h>
 #include <linux/stddef.h>
 
@@ -15,6 +16,11 @@ struct timer_list {
 	unsigned long data;
 
 	struct tvec_t_base_s *base;
+#ifdef CONFIG_TIMER_STATS
+	void *start_site;
+	char start_comm[16];
+	int start_pid;
+#endif
 };
 
 extern struct tvec_t_base_s boot_tvec_bases;
@@ -74,6 +80,48 @@ extern unsigned long next_timer_interrup
  */
 extern unsigned long get_next_timer_interrupt(unsigned long now);
 
+/*
+ * Timer-statistics info:
+ */
+#ifdef CONFIG_TIMER_STATS
+
+extern void tstats_update_stats(void *timer, pid_t pid, void *startf,
+				void *timerf, char * comm);
+
+static inline void tstats_account_timer(struct timer_list *timer)
+{
+	tstats_update_stats(timer, timer->start_pid, timer->start_site,
+			    timer->function, timer->start_comm);
+}
+
+extern void __tstats_timer_set_start_info(struct timer_list *timer, void *addr);
+
+static inline void tstats_timer_set_start_info(struct timer_list *timer)
+{
+	__tstats_timer_set_start_info(timer, __builtin_return_address(0));
+}
+
+static inline void tstats_timer_clear_start_info(struct timer_list *timer)
+{
+	timer->start_site = NULL;
+}
+#else
+static inline void tstats_account_timer(struct timer_list *timer)
+{
+}
+
+static inline void tstats_timer_set_start_info(struct timer_list *timer)
+{
+}
+
+static inline void tstats_timer_clear_start_info(struct timer_list *timer)
+{
+}
+#endif
+
+extern void delayed_work_timer_fn(unsigned long __data);
+
+
 /***
  * add_timer - start a timer
  * @timer: the timer to be added
Index: linux-2.6.18-mm2/kernel/hrtimer.c
===================================================================
--- linux-2.6.18-mm2.orig/kernel/hrtimer.c	2006-09-30 01:41:18.000000000 +0200
+++ linux-2.6.18-mm2/kernel/hrtimer.c	2006-09-30 01:41:20.000000000 +0200
@@ -814,6 +814,18 @@ static inline void hrtimer_resume_jiffie
 
 #endif /* CONFIG_HIGH_RES_TIMERS */
 
+#ifdef CONFIG_TIMER_STATS
+void __tstats_hrtimer_set_start_info(struct hrtimer *timer, void *addr)
+{
+	if (timer->start_site)
+		return;
+
+	timer->start_site = addr;
+	memcpy(timer->start_comm, current->comm, TASK_COMM_LEN);
+	timer->start_pid = current->pid;
+}
+#endif
+
 /*
  * Timekeeping resumed notification
  */
@@ -959,6 +971,7 @@ remove_hrtimer(struct hrtimer *timer, st
 		 * Remove the timer and force reprogramming when high
 		 * resolution mode is active
 		 */
+		tstats_hrtimer_clear_start_info(timer);
 		__remove_hrtimer(timer, base, HRTIMER_INACTIVE, 1);
 		return 1;
 	}
@@ -1005,6 +1018,8 @@ hrtimer_start(struct hrtimer *timer, kti
 	}
 	timer->expires = tim;
 
+	tstats_hrtimer_set_start_info(timer);
+
 	enqueue_hrtimer(timer, new_base);
 
 	unlock_hrtimer_base(timer, &flags);
@@ -1146,6 +1161,12 @@ void hrtimer_init(struct hrtimer *timer,
 
 	timer->base = &cpu_base->clock_base[clock_id];
 	hrtimer_init_timer_hres(timer);
+
+#ifdef CONFIG_TIMER_STATS
+	timer->start_site = NULL;
+	timer->start_pid = -1;
+	memset(timer->start_comm, 0, TASK_COMM_LEN);
+#endif
 }
 EXPORT_SYMBOL_GPL(hrtimer_init);
 
@@ -1229,6 +1250,7 @@ void hrtimer_interrupt(struct pt_regs *r
 			}
 
 			__remove_hrtimer(timer, base, HRTIMER_CALLBACK, 0);
+			tstats_account_hrtimer(timer);
 
 			if (timer->function(timer) != HRTIMER_NORESTART) {
 				BUG_ON(timer->state != HRTIMER_CALLBACK);
@@ -1277,6 +1299,8 @@ static void run_hrtimer_softirq(struct s
 		timer = list_entry(cpu_base->cb_pending.next,
 				   struct hrtimer, cb_entry);
 
+		tstats_account_hrtimer(timer);
+
 		fn = timer->function;
 		__remove_hrtimer(timer, timer->base, HRTIMER_CALLBACK, 0);
 		spin_unlock_irq(&cpu_base->lock);
@@ -1326,6 +1350,8 @@ static inline void run_hrtimer_queue(str
 		if (base->softirq_time.tv64 <= timer->expires.tv64)
 			break;
 
+		tstats_account_hrtimer(timer);
+
 		fn = timer->function;
 		__remove_hrtimer(timer, base, HRTIMER_CALLBACK, 0);
 		spin_unlock_irq(&cpu_base->lock);
Index: linux-2.6.18-mm2/kernel/time/Makefile
===================================================================
--- linux-2.6.18-mm2.orig/kernel/time/Makefile	2006-09-30 01:41:17.000000000 +0200
+++ linux-2.6.18-mm2/kernel/time/Makefile	2006-09-30 01:41:20.000000000 +0200
@@ -1,3 +1,4 @@
 obj-y += ntp.o clocksource.o jiffies.o
 
-obj-$(CONFIG_GENERIC_TIME) += clockevents.o
+obj-$(CONFIG_GENERIC_TIME)	+= clockevents.o
+obj-$(CONFIG_TIMER_STATS)	+= timer_stats.o
Index: linux-2.6.18-mm2/kernel/time/timer_stats.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-mm2/kernel/time/timer_stats.c	2006-09-30 01:41:20.000000000 +0200
@@ -0,0 +1,227 @@
+/*
+ * kernel/time/timer_stats.c
+ *
+ * Copyright(C) 2006, Red Hat, Inc., Ingo Molnar
+ * Copyright(C) 2006, Thomas Gleixner <tglx@timesys.com>
+ *
+ * Based on: timer_top.c
+ *	Copyright (C) 2005 Instituto Nokia de Tecnologia - INdT - Manaus
+ *	Written by Daniel Petrini <d.pensator@gmail.com>
+ *
+ * Collect timer usage statistics.
+ *
+ * We export the addresses and counting of timer functions being called,
+ * the pid and cmdline from the owner process if applicable.
+ *
+ * Start/stop data collection:
+ * # echo 1[0] >/proc/tstats
+ *
+ * Display the collected information:
+ * # cat /proc/tstats
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/list.h>
+#include <linux/proc_fs.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/sched.h>
+#include <linux/seq_file.h>
+#include <linux/kallsyms.h>
+
+#include <asm/uaccess.h>
+
+static DEFINE_SPINLOCK(tstats_lock);
+static int tstats_status;
+static ktime_t tstats_time;
+
+enum tstats_stat {
+	TSTATS_INACTIVE,
+	TSTATS_ACTIVE,
+	TSTATS_READOUT,
+	TSTATS_RESET,
+};
+
+struct tstats_entry {
+	void			*timer;
+	void			*start_func;
+	void			*expire_func;
+	unsigned long		counter;
+	pid_t			pid;
+	char			comm[TASK_COMM_LEN + 1];
+};
+
+#define TSTATS_MAX_ENTRIES	1024
+
+static struct tstats_entry tstats[TSTATS_MAX_ENTRIES];
+
+void tstats_update_stats(void *timer, pid_t pid, void *startf,
+			 void *timerf, char * comm)
+{
+	struct tstats_entry *entry = tstats;
+	unsigned long flags;
+	int i;
+
+	spin_lock_irqsave(&tstats_lock, flags);
+	if (tstats_status != TSTATS_ACTIVE)
+		goto out_unlock;
+
+	for (i = 0; i < TSTATS_MAX_ENTRIES; i++, entry++) {
+		if (entry->timer == timer &&
+		    entry->start_func == startf &&
+		    entry->expire_func == timerf &&
+		    entry->pid == pid) {
+
+			entry->counter++;
+			break;
+		}
+		if (!entry->timer) {
+			entry->timer = timer;
+			entry->start_func = startf;
+			entry->expire_func = timerf;
+			entry->counter = 1;
+			entry->pid = pid;
+			memcpy(entry->comm, comm, TASK_COMM_LEN);
+			entry->comm[TASK_COMM_LEN] = 0;
+			break;
+		}
+	}
+
+ out_unlock:
+	spin_unlock_irqrestore(&tstats_lock, flags);
+}
+
+static void tstats_reset(void)
+{
+	memset(tstats, 0, sizeof(tstats));
+}
+
+static void print_name_offset(struct seq_file *m, unsigned long addr)
+{
+	char namebuf[KSYM_NAME_LEN+1];
+	unsigned long size, offset;
+	const char *sym_name;
+	char *modname;
+
+	sym_name = kallsyms_lookup(addr, &size, &offset, &modname, namebuf);
+	if (sym_name)
+		seq_printf(m, "%s", sym_name);
+	else
+		seq_printf(m, "<%p>", (void *)addr);
+}
+
+static int tstats_show(struct seq_file *m, void *v)
+{
+	struct tstats_entry *entry = tstats;
+	struct timespec period;
+	unsigned long ms;
+	long events = 0;
+	int i;
+
+	spin_lock_irq(&tstats_lock);
+	switch(tstats_status) {
+	case TSTATS_ACTIVE:
+		tstats_time = ktime_sub(ktime_get(), tstats_time);
+	case TSTATS_INACTIVE:
+		tstats_status = TSTATS_READOUT;
+		break;
+	default:
+		spin_unlock_irq(&tstats_lock);
+		return -EBUSY;
+	}
+	spin_unlock_irq(&tstats_lock);
+
+	period = ktime_to_timespec(tstats_time);
+	ms = period.tv_nsec % 1000000;
+
+	seq_printf(m, "Timerstats sample period: %ld.%3ld s\n",
+		   period.tv_sec, ms);
+
+	for (i = 0; i < TSTATS_MAX_ENTRIES && entry->timer; i++, entry++) {
+		seq_printf(m, "%4lu, %5d %-16s ", entry->counter, entry->pid,
+			   entry->comm);
+
+		print_name_offset(m, (unsigned long)entry->start_func);
+		seq_puts(m, " (");
+		print_name_offset(m, (unsigned long)entry->expire_func);
+		seq_puts(m, ")\n");
+		events += entry->counter;
+	}
+
+	ms += period.tv_sec * 1000;
+	if (events && period.tv_sec)
+		seq_printf(m, "%ld total events, %ld.%ld events/sec\n", events,
+			   events / period.tv_sec, events * 1000 / ms);
+	else
+		seq_printf(m, "%ld total events\n", events);
+
+	tstats_status = TSTATS_INACTIVE;
+	return 0;
+}
+
+static ssize_t tstats_write(struct file *file, const char __user *buf,
+			    size_t count, loff_t *offs)
+{
+	char ctl[2];
+
+	if (count != 2 || *offs)
+		return -EINVAL;
+
+	if (copy_from_user(ctl, buf, count))
+		return -EFAULT;
+
+	switch (ctl[0]) {
+	case '0':
+		spin_lock_irq(&tstats_lock);
+		if (tstats_status == TSTATS_ACTIVE) {
+			tstats_status = TSTATS_INACTIVE;
+			tstats_time = ktime_sub(ktime_get(), tstats_time);
+		}
+		spin_unlock_irq(&tstats_lock);
+		break;
+	case '1':
+		spin_lock_irq(&tstats_lock);
+		if (tstats_status == TSTATS_INACTIVE) {
+			tstats_status = TSTATS_RESET;
+			spin_unlock_irq(&tstats_lock);
+			tstats_reset();
+			tstats_time = ktime_get();
+			tstats_status = TSTATS_ACTIVE;
+		} else
+			spin_unlock_irq(&tstats_lock);
+		break;
+	default:
+		count = -EINVAL;
+	}
+
+	return count;
+}
+
+static int tstats_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, tstats_show, NULL);
+}
+
+static struct file_operations tstats_fops = {
+	.open		= tstats_open,
+	.read		= seq_read,
+	.write		= tstats_write,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
+static int __init init_tstats(void)
+{
+	struct proc_dir_entry *pe = create_proc_entry("tstats", 0666, NULL);
+
+	if (!pe)
+		return -ENOMEM;
+
+	pe->proc_fops = &tstats_fops;
+
+	return 0;
+}
+module_init(init_tstats);
Index: linux-2.6.18-mm2/kernel/timer.c
===================================================================
--- linux-2.6.18-mm2.orig/kernel/timer.c	2006-09-30 01:41:19.000000000 +0200
+++ linux-2.6.18-mm2/kernel/timer.c	2006-09-30 01:41:20.000000000 +0200
@@ -34,6 +34,7 @@
 #include <linux/cpu.h>
 #include <linux/syscalls.h>
 #include <linux/delay.h>
+#include <linux/kallsyms.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -135,6 +136,18 @@ static void internal_add_timer(tvec_base
 	list_add_tail(&timer->entry, vec);
 }
 
+#ifdef CONFIG_TIMER_STATS
+void __tstats_timer_set_start_info(struct timer_list *timer, void *addr)
+{
+	if (timer->start_site)
+		return;
+
+	timer->start_site = addr;
+	memcpy(timer->start_comm, current->comm, TASK_COMM_LEN);
+	timer->start_pid = current->pid;
+}
+#endif
+
 /**
  * init_timer - initialize a timer.
  * @timer: the timer to be initialized
@@ -146,11 +159,16 @@ void fastcall init_timer(struct timer_li
 {
 	timer->entry.next = NULL;
 	timer->base = __raw_get_cpu_var(tvec_bases);
+#ifdef CONFIG_TIMER_STATS
+	timer->start_site = NULL;
+	timer->start_pid = -1;
+	memset(timer->start_comm, 0, TASK_COMM_LEN);
+#endif
 }
 EXPORT_SYMBOL(init_timer);
 
 static inline void detach_timer(struct timer_list *timer,
-					int clear_pending)
+				int clear_pending)
 {
 	struct list_head *entry = &timer->entry;
 
@@ -197,6 +215,7 @@ int __mod_timer(struct timer_list *timer
 	unsigned long flags;
 	int ret = 0;
 
+	tstats_timer_set_start_info(timer);
 	BUG_ON(!timer->function);
 
 	base = lock_timer_base(timer, &flags);
@@ -247,6 +266,7 @@ void add_timer_on(struct timer_list *tim
 	tvec_base_t *base = per_cpu(tvec_bases, cpu);
   	unsigned long flags;
 
+	tstats_timer_set_start_info(timer);
   	BUG_ON(timer_pending(timer) || !timer->function);
 	spin_lock_irqsave(&base->lock, flags);
 	timer->base = base;
@@ -279,6 +299,7 @@ int mod_timer(struct timer_list *timer, 
 {
 	BUG_ON(!timer->function);
 
+	tstats_timer_set_start_info(timer);
 	/*
 	 * This is a common optimization triggered by the
 	 * networking code - if the timer is re-modified
@@ -309,6 +330,7 @@ int del_timer(struct timer_list *timer)
 	unsigned long flags;
 	int ret = 0;
 
+	tstats_timer_clear_start_info(timer);
 	if (timer_pending(timer)) {
 		base = lock_timer_base(timer, &flags);
 		if (timer_pending(timer)) {
@@ -444,6 +466,8 @@ static inline void __run_timers(tvec_bas
  			fn = timer->function;
  			data = timer->data;
 
+			tstats_account_timer(timer);
+
 			set_running_timer(base, timer);
 			detach_timer(timer, 1);
 			spin_unlock_irq(&base->lock);
@@ -1114,7 +1138,8 @@ static void run_timer_softirq(struct sof
 {
 	tvec_base_t *base = __get_cpu_var(tvec_bases);
 
- 	hrtimer_run_queues();
+	hrtimer_run_queues();
+
 	if (time_after_eq(jiffies, base->timer_jiffies))
 		__run_timers(base);
 }
Index: linux-2.6.18-mm2/kernel/workqueue.c
===================================================================
--- linux-2.6.18-mm2.orig/kernel/workqueue.c	2006-09-30 01:41:09.000000000 +0200
+++ linux-2.6.18-mm2/kernel/workqueue.c	2006-09-30 01:41:20.000000000 +0200
@@ -119,12 +119,14 @@ int fastcall queue_work(struct workqueue
 }
 EXPORT_SYMBOL_GPL(queue_work);
 
-static void delayed_work_timer_fn(unsigned long __data)
+void delayed_work_timer_fn(unsigned long __data)
 {
 	struct work_struct *work = (struct work_struct *)__data;
 	struct workqueue_struct *wq = work->wq_data;
 	int cpu = smp_processor_id();
+	struct list_head *head;
 
+	head = &per_cpu_ptr(wq->cpu_wq, cpu)->more_work.task_list;
 	if (unlikely(is_single_threaded(wq)))
 		cpu = singlethread_cpu;
 
@@ -140,11 +142,12 @@ static void delayed_work_timer_fn(unsign
  * Returns non-zero if it was successfully added.
  */
 int fastcall queue_delayed_work(struct workqueue_struct *wq,
-			struct work_struct *work, unsigned long delay)
+				struct work_struct *work, unsigned long delay)
 {
 	int ret = 0;
 	struct timer_list *timer = &work->timer;
 
+	tstats_timer_set_start_info(&work->timer);
 	if (!test_and_set_bit(0, &work->pending)) {
 		BUG_ON(timer_pending(timer));
 		BUG_ON(!list_empty(&work->entry));
@@ -469,6 +472,7 @@ EXPORT_SYMBOL(schedule_work);
  */
 int fastcall schedule_delayed_work(struct work_struct *work, unsigned long delay)
 {
+	tstats_timer_set_start_info(&work->timer);
 	return queue_delayed_work(keventd_wq, work, delay);
 }
 EXPORT_SYMBOL(schedule_delayed_work);
Index: linux-2.6.18-mm2/lib/Kconfig.debug
===================================================================
--- linux-2.6.18-mm2.orig/lib/Kconfig.debug	2006-09-30 01:41:09.000000000 +0200
+++ linux-2.6.18-mm2/lib/Kconfig.debug	2006-09-30 01:41:20.000000000 +0200
@@ -109,6 +109,17 @@ config SCHEDSTATS
 	  application, you can say N to avoid the very slight overhead
 	  this adds.
 
+config TIMER_STATS
+	bool "Collect kernel timers statistics"
+	depends on DEBUG_KERNEL && PROC_FS
+	help
+	  If you say Y here, additional code will be inserted into the
+	  timer routines to collect statistics about kernel timers being
+	  reprogrammed. The statistics can be read from /proc/tstats.
+	  The statistics collection is started by writing 1 to /proc/tstats,
+	  writing 0 stops it. This feature is useful to collect information
+	  about timer usage patterns in kernel and userspace.
+
 config DEBUG_SLAB
 	bool "Debug slab memory allocations"
 	depends on DEBUG_KERNEL && SLAB

--

