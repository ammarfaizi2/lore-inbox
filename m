Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751673AbWB0IMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbWB0IMI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 03:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751675AbWB0IMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 03:12:08 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:64699 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751673AbWB0IMH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 03:12:07 -0500
Subject: [Patch 2/7] Add sysctl for schedstats
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: lse-tech <lse-tech@lists.sourceforge.net>
In-Reply-To: <1141027367.5785.42.camel@elinux04.optonline.net>
References: <1141026996.5785.38.camel@elinux04.optonline.net>
	 <1141027367.5785.42.camel@elinux04.optonline.net>
Content-Type: text/plain
Organization: IBM
Message-Id: <1141027923.5785.50.camel@elinux04.optonline.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 27 Feb 2006 03:12:03 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

schedstats-sysctl.patch

Add sysctl option for controlling schedstats collection
dynamically. Delay accounting leverages schedstats for
cpu delay statistics.

Signed-off-by: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-off-by: Shailabh Nagar <nagar@watson.ibm.com>

 Documentation/kernel-parameters.txt |    2 
 include/linux/sched.h               |    4 +
 include/linux/sysctl.h              |    1 
 kernel/sched.c                      |   74 +++++++++++++++++++++++++++++++++---
 kernel/sysctl.c                     |   10 ++++
 lib/Kconfig.debug                   |    6 +-
 6 files changed, 90 insertions(+), 7 deletions(-)

Index: linux-2.6.16-rc4/include/linux/sched.h
===================================================================
--- linux-2.6.16-rc4.orig/include/linux/sched.h	2006-02-27 01:20:04.000000000 -0500
+++ linux-2.6.16-rc4/include/linux/sched.h	2006-02-27 01:52:52.000000000 -0500
@@ -15,6 +15,7 @@
 #include <linux/cpumask.h>
 #include <linux/errno.h>
 #include <linux/nodemask.h>
+#include <linux/sysctl.h>
 
 #include <asm/system.h>
 #include <asm/semaphore.h>
@@ -525,6 +526,9 @@ struct backing_dev_info;
 struct reclaim_state;
 
 #ifdef CONFIG_SCHEDSTATS
+extern int schedstats_sysctl;
+extern int schedstats_sysctl_handler(ctl_table *, int, struct file *,
+					void __user *, size_t *, loff_t *);
 struct sched_info {
 	/* cumulative counters */
 	unsigned long	cpu_time,	/* time spent on the cpu */
Index: linux-2.6.16-rc4/include/linux/sysctl.h
===================================================================
--- linux-2.6.16-rc4.orig/include/linux/sysctl.h	2006-02-27 01:20:04.000000000 -0500
+++ linux-2.6.16-rc4/include/linux/sysctl.h	2006-02-27 01:52:52.000000000 -0500
@@ -146,6 +146,7 @@ enum
 	KERN_RANDOMIZE=68, /* int: randomize virtual address space */
 	KERN_SETUID_DUMPABLE=69, /* int: behaviour of dumps for setuid core */
 	KERN_SPIN_RETRY=70,	/* int: number of spinlock retries */
+	KERN_SCHEDSTATS=71,	/* int: Schedstats on/off */
 };
 
 
Index: linux-2.6.16-rc4/kernel/sched.c
===================================================================
--- linux-2.6.16-rc4.orig/kernel/sched.c	2006-02-27 01:20:04.000000000 -0500
+++ linux-2.6.16-rc4/kernel/sched.c	2006-02-27 01:52:52.000000000 -0500
@@ -382,11 +382,56 @@ static inline void task_rq_unlock(runque
 }
 
 #ifdef CONFIG_SCHEDSTATS
+
+int schedstats_sysctl = 0;		/* schedstats turned off by default */
+static DEFINE_PER_CPU(int, schedstats) = 0;
+
+static void schedstats_set(int val)
+{
+	int i;
+	static spinlock_t schedstats_lock = SPIN_LOCK_UNLOCKED;
+
+	spin_lock(&schedstats_lock);
+	schedstats_sysctl = val;
+	for (i = 0; i < NR_CPUS; i++)
+		per_cpu(schedstats, i) = val;
+	spin_unlock(&schedstats_lock);
+}
+
+static int __init schedstats_setup_enable(char *str)
+{
+	schedstats_sysctl = 1;
+	schedstats_set(schedstats_sysctl);
+	return 1;
+}
+
+__setup("schedstats", schedstats_setup_enable);
+
+int schedstats_sysctl_handler(ctl_table *table, int write, struct file *filp,
+			void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	int ret, prev = schedstats_sysctl;
+	struct task_struct *g, *t;
+
+	ret = proc_dointvec(table, write, filp, buffer, lenp, ppos);
+	if ((ret != 0) || (prev == schedstats_sysctl))
+		return ret;
+	if (schedstats_sysctl) {
+		read_lock(&tasklist_lock);
+		do_each_thread(g, t) {
+			memset(&t->sched_info, 0, sizeof(t->sched_info));
+		} while_each_thread(g, t);
+		read_unlock(&tasklist_lock);
+	}
+	schedstats_set(schedstats_sysctl);
+	return ret;
+}
+
 /*
  * bump this up when changing the output format or the meaning of an existing
  * format, so that tools can adapt (or abort)
  */
-#define SCHEDSTAT_VERSION 12
+#define SCHEDSTAT_VERSION 13
 
 static int show_schedstat(struct seq_file *seq, void *v)
 {
@@ -394,6 +439,10 @@ static int show_schedstat(struct seq_fil
 
 	seq_printf(seq, "version %d\n", SCHEDSTAT_VERSION);
 	seq_printf(seq, "timestamp %lu\n", jiffies);
+	if (!schedstats_sysctl) {
+		seq_printf(seq, "State Off\n");
+		return 0;
+	}
 	for_each_online_cpu(cpu) {
 		runqueue_t *rq = cpu_rq(cpu);
 #ifdef CONFIG_SMP
@@ -472,8 +521,17 @@ struct file_operations proc_schedstat_op
 	.release = single_release,
 };
 
-# define schedstat_inc(rq, field)	do { (rq)->field++; } while (0)
-# define schedstat_add(rq, field, amt)	do { (rq)->field += (amt); } while (0)
+#define schedstats_on	(per_cpu(schedstats, smp_processor_id()) != 0)
+#define schedstat_inc(rq, field)	\
+do {					\
+	if (unlikely(schedstats_on))	\
+		(rq)->field++;		\
+} while (0)
+#define schedstat_add(rq, field, amt)	\
+do {					\
+	if (unlikely(schedstats_on))	\
+		(rq)->field += (amt);	\
+} while (0)
 #else /* !CONFIG_SCHEDSTATS */
 # define schedstat_inc(rq, field)	do { } while (0)
 # define schedstat_add(rq, field, amt)	do { } while (0)
@@ -556,7 +614,7 @@ static void sched_info_arrive(task_t *t)
  */
 static inline void sched_info_queued(task_t *t)
 {
-	if (!t->sched_info.last_queued)
+	if (unlikely(schedstats_on && !t->sched_info.last_queued))
 		t->sched_info.last_queued = jiffies;
 }
 
@@ -580,7 +638,7 @@ static inline void sched_info_depart(tas
  * their time slice.  (This may also be called when switching to or from
  * the idle task.)  We are only called when prev != next.
  */
-static inline void sched_info_switch(task_t *prev, task_t *next)
+static inline void __sched_info_switch(task_t *prev, task_t *next)
 {
 	struct runqueue *rq = task_rq(prev);
 
@@ -595,6 +653,12 @@ static inline void sched_info_switch(tas
 	if (next != rq->idle)
 		sched_info_arrive(next);
 }
+
+static inline void sched_info_switch(task_t *prev, task_t *next)
+{
+	if (unlikely(schedstats_on))
+		__sched_info_switch(prev, next);
+}
 #else
 #define sched_info_queued(t)		do { } while (0)
 #define sched_info_switch(t, next)	do { } while (0)
Index: linux-2.6.16-rc4/kernel/sysctl.c
===================================================================
--- linux-2.6.16-rc4.orig/kernel/sysctl.c	2006-02-27 01:20:04.000000000 -0500
+++ linux-2.6.16-rc4/kernel/sysctl.c	2006-02-27 01:52:52.000000000 -0500
@@ -656,6 +656,16 @@ static ctl_table kern_table[] = {
 		.proc_handler	= &proc_dointvec,
 	},
 #endif
+#if defined(CONFIG_SCHEDSTATS)
+	{
+		.ctl_name	= KERN_SCHEDSTATS,
+		.procname	= "schedstats",
+		.data		= &schedstats_sysctl,
+		.maxlen		= sizeof (int),
+		.mode		= 0644,
+		.proc_handler	= &schedstats_sysctl_handler,
+	},
+#endif
 	{ .ctl_name = 0 }
 };
 
Index: linux-2.6.16-rc4/lib/Kconfig.debug
===================================================================
--- linux-2.6.16-rc4.orig/lib/Kconfig.debug	2006-02-27 01:20:04.000000000 -0500
+++ linux-2.6.16-rc4/lib/Kconfig.debug	2006-02-27 01:52:52.000000000 -0500
@@ -67,15 +67,17 @@ config DETECT_SOFTLOCKUP
 
 config SCHEDSTATS
 	bool "Collect scheduler statistics"
-	depends on DEBUG_KERNEL && PROC_FS
+	depends on PROC_FS
 	help
 	  If you say Y here, additional code will be inserted into the
 	  scheduler and related routines to collect statistics about
 	  scheduler behavior and provide them in /proc/schedstat.  These
-	  stats may be useful for both tuning and debugging the scheduler
+	  stats may be useful for both tuning and debugging the scheduler.
 	  If you aren't debugging the scheduler or trying to tune a specific
 	  application, you can say N to avoid the very slight overhead
 	  this adds.
+	  Schedstats collection, and most of its overhead, can also be
+	  controlled dyanmically through the schedstats sysctl.
 
 config DEBUG_SLAB
 	bool "Debug memory allocations"
Index: linux-2.6.16-rc4/Documentation/kernel-parameters.txt
===================================================================
--- linux-2.6.16-rc4.orig/Documentation/kernel-parameters.txt	2006-02-27 01:19:52.000000000 -0500
+++ linux-2.6.16-rc4/Documentation/kernel-parameters.txt	2006-02-27 01:52:52.000000000 -0500
@@ -1333,6 +1333,8 @@ running once the system is up.
 	sc1200wdt=	[HW,WDT] SC1200 WDT (watchdog) driver
 			Format: <io>[,<timeout>[,<isapnp>]]
 
+	schedstats	[KNL] Collect CPU scheduler statistics
+
 	scsi_debug_*=	[SCSI]
 			See drivers/scsi/scsi_debug.c.
 


