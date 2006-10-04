Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161908AbWJDRjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161908AbWJDRjS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 13:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161913AbWJDRil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 13:38:41 -0400
Received: from www.osadl.org ([213.239.205.134]:50405 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1161927AbWJDRiL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 13:38:11 -0400
Message-Id: <20061004172224.378807000@cruncher.tec.linutronix.de>
References: <20061004172217.092570000@cruncher.tec.linutronix.de>
Date: Wed, 04 Oct 2006 17:31:53 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       John Stultz <johnstul@us.ibm.com>,
       Valdis Kletnieks <valdis.kletnieks@vt.edu>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>,
       David Woodhouse <dwmw2@infradead.org>, Jim Gettys <jg@laptop.org>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: [patch 22/22] debugging feature: timer stats
Content-Disposition: inline; filename=debugging-feature-timer-stats.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Add /proc/timer_stats support: debugging feature to profile timer expiration. 
Both the starting site, process/PID and the expiration function is captured. 
This allows the quick identification of timer event sources in a system.

Sample output:

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
 Documentation/hrtimer/timer_stats.txt |   68 +++++++++
 include/linux/hrtimer.h               |   53 +++++++
 include/linux/timer.h                 |   49 ++++++
 kernel/hrtimer.c                      |   26 +++
 kernel/time/Makefile                  |    3 
 kernel/time/timer_stats.c             |  244 ++++++++++++++++++++++++++++++++++
 kernel/timer.c                        |   29 +++-
 kernel/workqueue.c                    |    6 
 lib/Kconfig.debug                     |   11 +
 9 files changed, 483 insertions(+), 6 deletions(-)

Index: linux-2.6.18-mm3/Documentation/hrtimer/timer_stats.txt
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-mm3/Documentation/hrtimer/timer_stats.txt	2006-10-04 18:13:59.000000000 +0200
@@ -0,0 +1,68 @@
+timer_stats - timer usage statistics
+------------------------------------
+
+timer_stats is a debugging facility to make the timer (ab)usage in a Linux
+system visible to kernel and userspace developers. It is not intended for
+production usage as it adds significant overhead to the (hr)timer code and the
+(hr)timer data structures.
+
+timer_stats should be used by kernel and userspace developers to verify that
+their code does not make unduly use of timers. This helps to avoid unnecessary
+wakeups, which should be avoided to optimize power consumption.
+
+It can be enabled by CONFIG_TIMER_STATS in the "Kernel hacking" configuration
+section.
+
+timer_stats collects information about the timer events which are fired in a
+Linux system over a sample period:
+
+- the pid of the task(process) which initialized the timer
+- the name of the process which initialized the timer
+- the function where the timer was intialized
+- the callback function which is associated to the timer
+- the number of events (callbacks)
+
+timer_stats adds an entry to /proc: /proc/timer_stats
+
+This entry is used to control the statistics functionality and to read out the
+sampled information.
+
+The timer_stats functionality is inactive on bootup.
+
+To activate a sample period issue:
+# echo 1 >/proc/timer_stats
+
+To stop a sample period issue:
+# echo 0 >/proc/timer_stats
+
+The statistics can be retrieved by:
+# cat /proc/timer_stats
+
+The readout of /proc/timer_stats automatically disables sampling. The sampled
+information is kept until a new sample period is started. This allows multiple
+readouts.
+
+Sample output of /proc/timer_stats:
+
+Timerstats sample period: 3.888770 s
+  12,     0 swapper          hrtimer_stop_sched_tick (hrtimer_sched_tick)
+  15,     1 swapper          hcd_submit_urb (rh_timer_func)
+   4,   959 kedac            schedule_timeout (process_timeout)
+   1,     0 swapper          page_writeback_init (wb_timer_fn)
+  28,     0 swapper          hrtimer_stop_sched_tick (hrtimer_sched_tick)
+  22,  2948 IRQ 4            tty_flip_buffer_push (delayed_work_timer_fn)
+   3,  3100 bash             schedule_timeout (process_timeout)
+   1,     1 swapper          queue_delayed_work_on (delayed_work_timer_fn)
+   1,     1 swapper          queue_delayed_work_on (delayed_work_timer_fn)
+   1,     1 swapper          neigh_table_init_no_netlink (neigh_periodic_timer)
+   1,  2292 ip               __netdev_watchdog_up (dev_watchdog)
+   1,    23 events/1         do_cache_clean (delayed_work_timer_fn)
+90 total events, 30.0 events/sec
+
+The first column is the number of events, the second column the pid, the third
+column is the name of the process. The forth column shows the function which
+initialized the timer and in parantheses the callback function which was
+executed on expiry.
+
+    Thomas, Ingo
+
Index: linux-2.6.18-mm3/include/linux/hrtimer.h
===================================================================
--- linux-2.6.18-mm3.orig/include/linux/hrtimer.h	2006-10-04 18:13:58.000000000 +0200
+++ linux-2.6.18-mm3/include/linux/hrtimer.h	2006-10-04 18:13:59.000000000 +0200
@@ -101,8 +101,14 @@ enum hrtimer_cb_mode {
  * @cb_mode:	high resolution timer feature to select the callback execution
  *		 mode
  * @cb_entry:	list head to enqueue an expired timer into the callback list
+ * @start_site:	timer statistics field to store the site where the timer
+ *		was started
+ * @start_comm: timer statistics field to store the name of the process which
+ *		started the timer
+ * @start_pid: timer statistics field to store the pid of the task which
+ *		started the timer
  *
- * The hrtimer structure must be initialized by init_hrtimer_#CLOCKTYPE()
+ * The hrtimer structure must be initialized by hrtimer_init()
  */
 struct hrtimer {
 	struct rb_node			node;
@@ -114,6 +120,11 @@ struct hrtimer {
 	enum hrtimer_cb_mode		cb_mode;
 	struct list_head		cb_entry;
 #endif
+#ifdef CONFIG_TIMER_STATS
+	void				*start_site;
+	char				start_comm[16];
+	int				start_pid;
+#endif
 };
 
 /**
@@ -335,4 +346,44 @@ static inline void show_no_hz_stats(stru
 /* Bootup initialization: */
 extern void __init hrtimers_init(void);
 
+/*
+ * Timer-statistics info:
+ */
+#ifdef CONFIG_TIMER_STATS
+
+extern void timer_stats_update_stats(void *timer, pid_t pid, void *startf,
+				     void *timerf, char * comm);
+
+static inline void timer_stats_account_hrtimer(struct hrtimer *timer)
+{
+	timer_stats_update_stats(timer, timer->start_pid, timer->start_site,
+				 timer->function, timer->start_comm);
+}
+
+extern void __timer_stats_hrtimer_set_start_info(struct hrtimer *timer,
+						 void *addr);
+
+static inline void timer_stats_hrtimer_set_start_info(struct hrtimer *timer)
+{
+	__timer_stats_hrtimer_set_start_info(timer, __builtin_return_address(0));
+}
+
+static inline void timer_stats_hrtimer_clear_start_info(struct hrtimer *timer)
+{
+	timer->start_site = NULL;
+}
+#else
+static inline void timer_stats_account_hrtimer(struct hrtimer *timer)
+{
+}
+
+static inline void timer_stats_hrtimer_set_start_info(struct hrtimer *timer)
+{
+}
+
+static inline void timer_stats_hrtimer_clear_start_info(struct hrtimer *timer)
+{
+}
+#endif
+
 #endif
Index: linux-2.6.18-mm3/include/linux/timer.h
===================================================================
--- linux-2.6.18-mm3.orig/include/linux/timer.h	2006-10-04 18:13:55.000000000 +0200
+++ linux-2.6.18-mm3/include/linux/timer.h	2006-10-04 18:13:59.000000000 +0200
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
@@ -73,6 +79,49 @@ extern unsigned long next_timer_interrup
  */
 extern unsigned long get_next_timer_interrupt(unsigned long now);
 
+/*
+ * Timer-statistics info:
+ */
+#ifdef CONFIG_TIMER_STATS
+
+extern void timer_stats_update_stats(void *timer, pid_t pid, void *startf,
+				     void *timerf, char * comm);
+
+static inline void timer_stats_account_timer(struct timer_list *timer)
+{
+	timer_stats_update_stats(timer, timer->start_pid, timer->start_site,
+				 timer->function, timer->start_comm);
+}
+
+extern void __timer_stats_timer_set_start_info(struct timer_list *timer,
+					       void *addr);
+
+static inline void timer_stats_timer_set_start_info(struct timer_list *timer)
+{
+	__timer_stats_timer_set_start_info(timer, __builtin_return_address(0));
+}
+
+static inline void timer_stats_timer_clear_start_info(struct timer_list *timer)
+{
+	timer->start_site = NULL;
+}
+#else
+static inline void timer_stats_account_timer(struct timer_list *timer)
+{
+}
+
+static inline void timer_stats_timer_set_start_info(struct timer_list *timer)
+{
+}
+
+static inline void timer_stats_timer_clear_start_info(struct timer_list *timer)
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
Index: linux-2.6.18-mm3/kernel/hrtimer.c
===================================================================
--- linux-2.6.18-mm3.orig/kernel/hrtimer.c	2006-10-04 18:13:58.000000000 +0200
+++ linux-2.6.18-mm3/kernel/hrtimer.c	2006-10-04 18:13:59.000000000 +0200
@@ -965,6 +965,18 @@ static inline void hrtimer_resume_jiffy_
 
 #endif /* CONFIG_HIGH_RES_TIMERS */
 
+#ifdef CONFIG_TIMER_STATS
+void __timer_stats_hrtimer_set_start_info(struct hrtimer *timer, void *addr)
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
@@ -1133,6 +1145,7 @@ remove_hrtimer(struct hrtimer *timer, st
 		 * reprogramming happens in the interrupt handler. This is a
 		 * rare case and less expensive than a smp call.
 		 */
+		timer_stats_hrtimer_clear_start_info(timer);
 		reprogram = base->cpu_base == &__get_cpu_var(hrtimer_bases);
 		__remove_hrtimer(timer, base, HRTIMER_STATE_INACTIVE,
 				 reprogram);
@@ -1181,6 +1194,8 @@ hrtimer_start(struct hrtimer *timer, kti
 	}
 	timer->expires = tim;
 
+	timer_stats_hrtimer_set_start_info(timer);
+
 	enqueue_hrtimer(timer, new_base, base == new_base);
 
 	unlock_hrtimer_base(timer, &flags);
@@ -1313,6 +1328,12 @@ void hrtimer_init(struct hrtimer *timer,
 
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
 
@@ -1395,6 +1416,7 @@ void hrtimer_interrupt(struct pt_regs *r
 
 			__remove_hrtimer(timer, base,
 					 HRTIMER_STATE_CALLBACK, 0);
+			timer_stats_account_hrtimer(timer);
 
 			if (timer->function(timer) != HRTIMER_NORESTART) {
 				BUG_ON(timer->state != HRTIMER_STATE_CALLBACK);
@@ -1440,6 +1462,8 @@ static void run_hrtimer_softirq(struct s
 		timer = list_entry(cpu_base->cb_pending.next,
 				   struct hrtimer, cb_entry);
 
+		timer_stats_account_hrtimer(timer);
+
 		fn = timer->function;
 		__remove_hrtimer(timer, timer->base, HRTIMER_STATE_CALLBACK, 0);
 		spin_unlock_irq(&cpu_base->lock);
@@ -1496,6 +1520,8 @@ static inline void run_hrtimer_queue(str
 		if (base->softirq_time.tv64 <= timer->expires.tv64)
 			break;
 
+		timer_stats_account_hrtimer(timer);
+
 		fn = timer->function;
 		__remove_hrtimer(timer, base, HRTIMER_STATE_CALLBACK, 0);
 		spin_unlock_irq(&cpu_base->lock);
Index: linux-2.6.18-mm3/kernel/time/Makefile
===================================================================
--- linux-2.6.18-mm3.orig/kernel/time/Makefile	2006-10-04 18:13:57.000000000 +0200
+++ linux-2.6.18-mm3/kernel/time/Makefile	2006-10-04 18:13:59.000000000 +0200
@@ -1,3 +1,4 @@
 obj-y += ntp.o clocksource.o jiffies.o
 
-obj-$(CONFIG_GENERIC_CLOCKEVENTS) += clockevents.o
+obj-$(CONFIG_GENERIC_CLOCKEVENTS)	+= clockevents.o
+obj-$(CONFIG_TIMER_STATS)		+= timer_stats.o
Index: linux-2.6.18-mm3/kernel/time/timer_stats.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-mm3/kernel/time/timer_stats.c	2006-10-04 18:13:59.000000000 +0200
@@ -0,0 +1,244 @@
+/*
+ * kernel/time/timer_stats.c
+ *
+ * Collect timer usage statistics.
+ *
+ * Copyright(C) 2006, Red Hat, Inc., Ingo Molnar
+ * Copyright(C) 2006 Timesys Corp., Thomas Gleixner <tglx@timesys.com>
+ *
+ * timer_stats is based on timer_top, a similar functionality which was part of
+ * Con Kolivas dyntick patch set. It was developed by Daniel Petrini at the
+ * Instituto Nokia de Tecnologia - INdT - Manaus. timer_top's design was based
+ * on dynamic allocation of the statistics entries rather than the static array
+ * which is used by timer_stats. It was written for the pre hrtimer kernel code
+ * and therefor did not take hrtimers into account. Nevertheless it provided
+ * the base for the timer_stats implementation and was a helpful source of
+ * inspiration in the first place. Kudos to Daniel and the Nokia folks for this
+ * effort.
+ *
+ * timer_top.c is
+ *	Copyright (C) 2005 Instituto Nokia de Tecnologia - INdT - Manaus
+ *	Written by Daniel Petrini <d.pensator@gmail.com>
+ *	timer_top.c was released under the GNU General Public License version 2
+ *
+ * We export the addresses and counting of timer functions being called,
+ * the pid and cmdline from the owner process if applicable.
+ *
+ * Start/stop data collection:
+ * # echo 1[0] >/proc/timer_stats
+ *
+ * Display the collected information:
+ * # cat /proc/timer_stats
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
+static DEFINE_SPINLOCK(tstats_lock);
+static enum tstats_stat tstats_status;
+static ktime_t tstats_time;
+
+/**
+ * timer_stats_update_stats - Update the statistics for a timer.
+ * @timer:	pointer to either a timer_list or a hrtimer
+ * @pid:	the pid of the task which set up the timer
+ * @startf:	pointer to the function which did the timer setup
+ * @timerf:	pointer to the timer callback function of the timer
+ * @comm:	name of the process which set up the timer
+ *
+ * When the timer is already registered, then the event counter is
+ * incremented. Otherwise the timer is registered in a free slot.
+ */
+void timer_stats_update_stats(void *timer, pid_t pid, void *startf,
+			      void *timerf, char * comm)
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
+			memset(tstats, 0, sizeof(tstats));
+			tstats_time = ktime_get();
+			tstats_status = TSTATS_ACTIVE;
+		}
+		spin_unlock_irq(&tstats_lock);
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
+	struct proc_dir_entry *pe;
+
+	pe = create_proc_entry("timer_stats", 0666, NULL);
+
+	if (!pe)
+		return -ENOMEM;
+
+	pe->proc_fops = &tstats_fops;
+
+	return 0;
+}
+module_init(init_tstats);
Index: linux-2.6.18-mm3/kernel/timer.c
===================================================================
--- linux-2.6.18-mm3.orig/kernel/timer.c	2006-10-04 18:13:58.000000000 +0200
+++ linux-2.6.18-mm3/kernel/timer.c	2006-10-04 18:13:59.000000000 +0200
@@ -34,6 +34,7 @@
 #include <linux/cpu.h>
 #include <linux/syscalls.h>
 #include <linux/delay.h>
+#include <linux/kallsyms.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -133,6 +134,18 @@ static void internal_add_timer(tvec_base
 	list_add_tail(&timer->entry, vec);
 }
 
+#ifdef CONFIG_TIMER_STATS
+void __timer_stats_timer_set_start_info(struct timer_list *timer, void *addr)
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
@@ -144,11 +157,16 @@ void fastcall init_timer(struct timer_li
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
 
@@ -195,6 +213,7 @@ int __mod_timer(struct timer_list *timer
 	unsigned long flags;
 	int ret = 0;
 
+	timer_stats_timer_set_start_info(timer);
 	BUG_ON(!timer->function);
 
 	base = lock_timer_base(timer, &flags);
@@ -245,6 +264,7 @@ void add_timer_on(struct timer_list *tim
 	tvec_base_t *base = per_cpu(tvec_bases, cpu);
   	unsigned long flags;
 
+	timer_stats_timer_set_start_info(timer);
   	BUG_ON(timer_pending(timer) || !timer->function);
 	spin_lock_irqsave(&base->lock, flags);
 	timer->base = base;
@@ -277,6 +297,7 @@ int mod_timer(struct timer_list *timer, 
 {
 	BUG_ON(!timer->function);
 
+	timer_stats_timer_set_start_info(timer);
 	/*
 	 * This is a common optimization triggered by the
 	 * networking code - if the timer is re-modified
@@ -307,6 +328,7 @@ int del_timer(struct timer_list *timer)
 	unsigned long flags;
 	int ret = 0;
 
+	timer_stats_timer_clear_start_info(timer);
 	if (timer_pending(timer)) {
 		base = lock_timer_base(timer, &flags);
 		if (timer_pending(timer)) {
@@ -440,6 +462,8 @@ static inline void __run_timers(tvec_bas
  			fn = timer->function;
  			data = timer->data;
 
+			timer_stats_account_timer(timer);
+
 			set_running_timer(base, timer);
 			detach_timer(timer, 1);
 			spin_unlock_irq(&base->lock);
@@ -1129,7 +1153,8 @@ static void run_timer_softirq(struct sof
 {
 	tvec_base_t *base = __get_cpu_var(tvec_bases);
 
- 	hrtimer_run_queues();
+	hrtimer_run_queues();
+
 	if (time_after_eq(jiffies, base->timer_jiffies))
 		__run_timers(base);
 }
Index: linux-2.6.18-mm3/kernel/workqueue.c
===================================================================
--- linux-2.6.18-mm3.orig/kernel/workqueue.c	2006-10-04 18:13:48.000000000 +0200
+++ linux-2.6.18-mm3/kernel/workqueue.c	2006-10-04 18:13:59.000000000 +0200
@@ -119,7 +119,7 @@ int fastcall queue_work(struct workqueue
 }
 EXPORT_SYMBOL_GPL(queue_work);
 
-static void delayed_work_timer_fn(unsigned long __data)
+void delayed_work_timer_fn(unsigned long __data)
 {
 	struct work_struct *work = (struct work_struct *)__data;
 	struct workqueue_struct *wq = work->wq_data;
@@ -140,11 +140,12 @@ static void delayed_work_timer_fn(unsign
  * Returns non-zero if it was successfully added.
  */
 int fastcall queue_delayed_work(struct workqueue_struct *wq,
-			struct work_struct *work, unsigned long delay)
+				struct work_struct *work, unsigned long delay)
 {
 	int ret = 0;
 	struct timer_list *timer = &work->timer;
 
+	timer_stats_timer_set_start_info(&work->timer);
 	if (!test_and_set_bit(0, &work->pending)) {
 		BUG_ON(timer_pending(timer));
 		BUG_ON(!list_empty(&work->entry));
@@ -469,6 +470,7 @@ EXPORT_SYMBOL(schedule_work);
  */
 int fastcall schedule_delayed_work(struct work_struct *work, unsigned long delay)
 {
+	timer_stats_timer_set_start_info(&work->timer);
 	return queue_delayed_work(keventd_wq, work, delay);
 }
 EXPORT_SYMBOL(schedule_delayed_work);
Index: linux-2.6.18-mm3/lib/Kconfig.debug
===================================================================
--- linux-2.6.18-mm3.orig/lib/Kconfig.debug	2006-10-04 18:13:48.000000000 +0200
+++ linux-2.6.18-mm3/lib/Kconfig.debug	2006-10-04 18:13:59.000000000 +0200
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

