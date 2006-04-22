Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbWDVVS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbWDVVS7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 17:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWDVVS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 17:18:59 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:37083 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751247AbWDVVS5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 17:18:57 -0400
Message-ID: <4449939D.7@watson.ibm.com>
Date: Fri, 21 Apr 2006 22:23:25 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: LSE <lse-tech@lists.sourceforge.net>, Jay Lan <jlan@engr.sgi.com>
Subject: [Patch 1/8] Setup
References: <444991EF.3080708@watson.ibm.com>
In-Reply-To: <444991EF.3080708@watson.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog

Fixes comments by akpm
- unnecessary initialization of delayacct_on
- use kmem_cache_zalloc
- redundant check in __delayacct_tsk_exit


delayacct-setup.patch

Initialization code related to collection of per-task "delay"
statistics which measure how long it had to wait for cpu,
sync block io, swapping etc. The collection of statistics and
the interface are in other patches. This patch sets up the data
structures and allows the statistics collection to be disabled
through a  kernel boot paramater.

Signed-off-by: Shailabh Nagar <nagar@watson.ibm.com>

 Documentation/kernel-parameters.txt |    2
 include/linux/delayacct.h           |   69 ++++++++++++++++++++++++++++
 include/linux/sched.h               |   21 ++++++++
 include/linux/time.h                |   10 ++++
 init/Kconfig                        |   13 +++++
 init/main.c                         |    2
 kernel/Makefile                     |    1
 kernel/delayacct.c                  |   87 ++++++++++++++++++++++++++++++++++++
 kernel/exit.c                       |    3 +
 kernel/fork.c                       |    2
 10 files changed, 210 insertions(+)

Index: linux-2.6.17-rc1/Documentation/kernel-parameters.txt
===================================================================
--- linux-2.6.17-rc1.orig/Documentation/kernel-parameters.txt	2006-04-13 10:55:54.000000000 -0400
+++ linux-2.6.17-rc1/Documentation/kernel-parameters.txt	2006-04-14 14:59:21.000000000 -0400
@@ -430,6 +430,8 @@ running once the system is up.
 			Format: <area>[,<node>]
 			See also Documentation/networking/decnet.txt.

+	delayacct	[KNL] Enable per-task delay accounting
+
 	devfs=		[DEVFS]
 			See Documentation/filesystems/devfs/boot-options.

Index: linux-2.6.17-rc1/kernel/Makefile
===================================================================
--- linux-2.6.17-rc1.orig/kernel/Makefile	2006-04-13 10:55:54.000000000 -0400
+++ linux-2.6.17-rc1/kernel/Makefile	2006-04-21 19:39:28.000000000 -0400
@@ -38,6 +38,7 @@ obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
 obj-$(CONFIG_SECCOMP) += seccomp.o
 obj-$(CONFIG_RCU_TORTURE_TEST) += rcutorture.o
 obj-$(CONFIG_RELAY) += relay.o
+obj-$(CONFIG_TASK_DELAY_ACCT) += delayacct.o

 ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
Index: linux-2.6.17-rc1/include/linux/delayacct.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.17-rc1/include/linux/delayacct.h	2006-04-21 19:39:29.000000000 -0400
@@ -0,0 +1,69 @@
+/* delayacct.h - per-task delay accounting
+ *
+ * Copyright (C) Shailabh Nagar, IBM Corp. 2006
+ *
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
+ *
+ */
+
+#ifndef _LINUX_TASKDELAYS_H
+#define _LINUX_TASKDELAYS_H
+
+#include <linux/sched.h>
+
+#ifdef CONFIG_TASK_DELAY_ACCT
+
+extern int delayacct_on;	/* Delay accounting turned on/off */
+extern kmem_cache_t *delayacct_cache;
+extern void delayacct_init(void);
+extern void __delayacct_tsk_init(struct task_struct *);
+extern void __delayacct_tsk_exit(struct task_struct *);
+
+static inline void delayacct_set_flag(int flag)
+{
+	if (current->delays)
+		current->delays->flags |= flag;
+}
+
+static inline void delayacct_clear_flag(int flag)
+{
+	if (current->delays)
+		current->delays->flags &= ~flag;
+}
+
+static inline void delayacct_tsk_init(struct task_struct *tsk)
+{
+	/* reinitialize in case parent's non-null pointer was dup'ed*/
+	tsk->delays = NULL;
+	if (unlikely(delayacct_on))
+		__delayacct_tsk_init(tsk);
+}
+
+static inline void delayacct_tsk_exit(struct task_struct *tsk)
+{
+	if (tsk->delays)
+		__delayacct_tsk_exit(tsk);
+}
+
+#else
+static inline void delayacct_set_flag(int flag)
+{}
+static inline void delayacct_clear_flag(int flag)
+{}
+static inline void delayacct_init(void)
+{}
+static inline void delayacct_tsk_init(struct task_struct *tsk)
+{}
+static inline void delayacct_tsk_exit(struct task_struct *tsk)
+{}
+#endif /* CONFIG_TASK_DELAY_ACCT */
+
+#endif
Index: linux-2.6.17-rc1/include/linux/sched.h
===================================================================
--- linux-2.6.17-rc1.orig/include/linux/sched.h	2006-04-13 10:55:54.000000000 -0400
+++ linux-2.6.17-rc1/include/linux/sched.h	2006-04-21 19:39:29.000000000 -0400
@@ -536,6 +536,24 @@ struct sched_info {
 extern struct file_operations proc_schedstat_operations;
 #endif

+#ifdef CONFIG_TASK_DELAY_ACCT
+struct task_delay_info {
+	spinlock_t	lock;
+	unsigned int	flags;	/* Private per-task flags */
+
+	/* For each stat XXX, add following, aligned appropriately
+	 *
+	 * struct timespec XXX_start, XXX_end;
+	 * u64 XXX_delay;
+	 * u32 XXX_count;
+	 *
+	 * Atomicity of updates to XXX_delay, XXX_count protected by
+	 * single lock above (split into XXX_lock if contention is an issue).
+	 */
+};
+#endif
+
+
 enum idle_type
 {
 	SCHED_IDLE,
@@ -882,6 +900,9 @@ struct task_struct {

 	atomic_t fs_excl;	/* holding fs exclusive resources */
 	struct rcu_head rcu;
+#ifdef	CONFIG_TASK_DELAY_ACCT
+	struct task_delay_info *delays;
+#endif
 };

 static inline pid_t process_group(struct task_struct *tsk)
Index: linux-2.6.17-rc1/init/Kconfig
===================================================================
--- linux-2.6.17-rc1.orig/init/Kconfig	2006-04-13 10:55:54.000000000 -0400
+++ linux-2.6.17-rc1/init/Kconfig	2006-04-21 19:39:28.000000000 -0400
@@ -150,6 +150,19 @@ config BSD_PROCESS_ACCT_V3
 	  for processing it. A preliminary version of these tools is available
 	  at <http://www.physik3.uni-rostock.de/tim/kernel/utils/acct/>.

+config TASK_DELAY_ACCT
+	bool "Enable per-task delay accounting (EXPERIMENTAL)"
+	help
+	  Collect information on time spent by a task waiting for system
+	  resources like cpu, synchronous block I/O completion and swapping
+	  in pages. Such statistics can help in setting a task's priorities
+	  relative to other tasks for cpu, io, rss limits etc.
+
+	  Unlike BSD process accounting, this information is available
+	  continuously during the lifetime of a task.
+
+	  Say N if unsure.
+
 config SYSCTL
 	bool "Sysctl support"
 	---help---
Index: linux-2.6.17-rc1/init/main.c
===================================================================
--- linux-2.6.17-rc1.orig/init/main.c	2006-04-13 10:55:54.000000000 -0400
+++ linux-2.6.17-rc1/init/main.c	2006-04-21 19:39:28.000000000 -0400
@@ -47,6 +47,7 @@
 #include <linux/rmap.h>
 #include <linux/mempolicy.h>
 #include <linux/key.h>
+#include <linux/delayacct.h>

 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -541,6 +542,7 @@ asmlinkage void __init start_kernel(void
 	proc_root_init();
 #endif
 	cpuset_init();
+	delayacct_init();

 	check_bugs();

Index: linux-2.6.17-rc1/kernel/delayacct.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.17-rc1/kernel/delayacct.c	2006-04-21 19:39:29.000000000 -0400
@@ -0,0 +1,87 @@
+/* delayacct.c - per-task delay accounting
+ *
+ * Copyright (C) Shailabh Nagar, IBM Corp. 2006
+ *
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
+ * the GNU General Public License for more details.
+ */
+
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/time.h>
+#include <linux/sysctl.h>
+#include <linux/delayacct.h>
+
+int delayacct_on __read_mostly;	/* Delay accounting turned on/off */
+kmem_cache_t *delayacct_cache;
+
+static int __init delayacct_setup_enable(char *str)
+{
+	delayacct_on = 1;
+	return 1;
+}
+__setup("delayacct", delayacct_setup_enable);
+
+void delayacct_init(void)
+{
+	delayacct_cache = kmem_cache_create("delayacct_cache",
+					    sizeof(struct task_delay_info),
+					    0,
+					    SLAB_PANIC,
+					    NULL, NULL);
+	delayacct_tsk_init(&init_task);
+}
+
+void __delayacct_tsk_init(struct task_struct *tsk)
+{
+	tsk->delays = kmem_cache_zalloc(delayacct_cache, SLAB_KERNEL);
+	if (tsk->delays)
+		spin_lock_init(&tsk->delays->lock);
+}
+
+void __delayacct_tsk_exit(struct task_struct *tsk)
+{
+	kmem_cache_free(delayacct_cache, tsk->delays);
+	tsk->delays = NULL;
+}
+
+/*
+ * Start accounting for a delay statistic using
+ * its starting timestamp (@start)
+ */
+
+static inline void delayacct_start(struct timespec *start)
+{
+	do_posix_clock_monotonic_gettime(start);
+}
+
+/*
+ * Finish delay accounting for a statistic using
+ * its timestamps (@start, @end), accumalator (@total) and @count
+ */
+
+static inline void delayacct_end(struct timespec *start, struct timespec *end,
+				u64 *total, u32 *count)
+{
+	struct timespec ts;
+	s64 ns;
+
+	do_posix_clock_monotonic_gettime(end);
+	timespec_sub(&ts, start, end);
+	ns = timespec_to_ns(&ts);
+	if (ns < 0)
+		return;
+
+	spin_lock(&current->delays->lock);
+	*total += ns;
+	(*count)++;
+	spin_unlock(&current->delays->lock);
+}
+
Index: linux-2.6.17-rc1/kernel/fork.c
===================================================================
--- linux-2.6.17-rc1.orig/kernel/fork.c	2006-04-13 10:55:54.000000000 -0400
+++ linux-2.6.17-rc1/kernel/fork.c	2006-04-14 14:59:21.000000000 -0400
@@ -44,6 +44,7 @@
 #include <linux/rmap.h>
 #include <linux/acct.h>
 #include <linux/cn_proc.h>
+#include <linux/delayacct.h>

 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -989,6 +990,7 @@ static task_t *copy_process(unsigned lon
 		goto bad_fork_cleanup_put_domain;

 	p->did_exec = 0;
+	delayacct_tsk_init(p);	/* Must remain after dup_task_struct() */
 	copy_flags(clone_flags, p);
 	p->pid = pid;
 	retval = -EFAULT;
Index: linux-2.6.17-rc1/kernel/exit.c
===================================================================
--- linux-2.6.17-rc1.orig/kernel/exit.c	2006-04-13 10:55:54.000000000 -0400
+++ linux-2.6.17-rc1/kernel/exit.c	2006-04-21 19:39:28.000000000 -0400
@@ -34,6 +34,7 @@
 #include <linux/mutex.h>
 #include <linux/futex.h>
 #include <linux/compat.h>
+#include <linux/delayacct.h>

 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -893,6 +894,7 @@ fastcall NORET_TYPE void do_exit(long co
 				preempt_count());

 	acct_update_integrals(tsk);
+
 	if (tsk->mm) {
 		update_hiwater_rss(tsk->mm);
 		update_hiwater_vm(tsk->mm);
@@ -909,6 +911,7 @@ fastcall NORET_TYPE void do_exit(long co
 	if (unlikely(tsk->compat_robust_list))
 		compat_exit_robust_list(tsk);
 #endif
+	delayacct_tsk_exit(tsk);
 	exit_mm(tsk);

 	exit_sem(tsk);
Index: linux-2.6.17-rc1/include/linux/time.h
===================================================================
--- linux-2.6.17-rc1.orig/include/linux/time.h	2006-04-13 10:55:54.000000000 -0400
+++ linux-2.6.17-rc1/include/linux/time.h	2006-04-14 14:59:21.000000000 -0400
@@ -68,6 +68,16 @@ extern unsigned long mktime(const unsign
 extern void set_normalized_timespec(struct timespec *ts, time_t sec, long nsec);

 /*
+ * sub = end - start, in normalized form
+ */
+static inline void timespec_sub(struct timespec *start, struct timespec *end,
+				struct timespec *sub)
+{
+	set_normalized_timespec(sub, end->tv_sec - start->tv_sec,
+				end->tv_nsec - start->tv_nsec);
+}
+
+/*
  * Returns true if the timespec is norm, false if denorm:
  */
 #define timespec_valid(ts) \
