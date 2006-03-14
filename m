Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751746AbWCNApF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746AbWCNApF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 19:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751761AbWCNApF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 19:45:05 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:36758 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751746AbWCNApD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 19:45:03 -0500
Subject: Patch 2/9] Initialization
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <1142296834.5858.3.camel@elinux04.optonline.net>
References: <1142296834.5858.3.camel@elinux04.optonline.net>
Content-Type: text/plain
Organization: IBM
Message-Id: <1142297101.5858.10.camel@elinux04.optonline.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 13 Mar 2006 19:45:02 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

delayacct-setup.patch

Initialization code related to collection of per-task "delay" 
statistics which measure how long it had to wait for cpu, 
sync block io, swapping etc. The collection of statistics and 
the interface are in other patches. This patch sets up the data
structures and allows the statistics collection to be disabled 
through a  kernel boot paramater.

Signed-off-by: Shailabh Nagar <nagar@watson.ibm.com>

 Documentation/kernel-parameters.txt |    2 
 include/linux/delayacct.h           |   48 ++++++++++++++++++
 include/linux/sched.h               |   17 ++++++
 init/Kconfig                        |   13 +++++
 init/main.c                         |    2 
 kernel/Makefile                     |    1 
 kernel/delayacct.c                  |   92 ++++++++++++++++++++++++++++++++++++
 kernel/exit.c                       |    3 +
 kernel/fork.c                       |    2 
 9 files changed, 180 insertions(+)

Index: linux-2.6.16-rc5/Documentation/kernel-parameters.txt
===================================================================
--- linux-2.6.16-rc5.orig/Documentation/kernel-parameters.txt	2006-03-11 07:41:32.000000000 -0500
+++ linux-2.6.16-rc5/Documentation/kernel-parameters.txt	2006-03-11 07:41:37.000000000 -0500
@@ -410,6 +410,8 @@ running once the system is up.
 			Format: <area>[,<node>]
 			See also Documentation/networking/decnet.txt.
 
+	delayacct	[KNL] Enable per-task delay accounting
+
 	devfs=		[DEVFS]
 			See Documentation/filesystems/devfs/boot-options.
 
Index: linux-2.6.16-rc5/kernel/Makefile
===================================================================
--- linux-2.6.16-rc5.orig/kernel/Makefile	2006-03-11 07:41:32.000000000 -0500
+++ linux-2.6.16-rc5/kernel/Makefile	2006-03-11 07:41:37.000000000 -0500
@@ -34,6 +34,7 @@ obj-$(CONFIG_DETECT_SOFTLOCKUP) += softl
 obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
 obj-$(CONFIG_SECCOMP) += seccomp.o
 obj-$(CONFIG_RCU_TORTURE_TEST) += rcutorture.o
+obj-$(CONFIG_TASK_DELAY_ACCT) += delayacct.o
 
 ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
Index: linux-2.6.16-rc5/include/linux/delayacct.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.16-rc5/include/linux/delayacct.h	2006-03-11 07:41:37.000000000 -0500
@@ -0,0 +1,48 @@
+/* delayacct.h - per-task delay accounting
+ *
+ * Copyright (C) Shailabh Nagar, IBM Corp. 2006
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2.1 of the GNU Lesser General Public License
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ */
+
+#ifndef _LINUX_TASKDELAYS_H
+#define _LINUX_TASKDELAYS_H
+
+#include <linux/sched.h>
+
+#ifdef CONFIG_TASK_DELAY_ACCT
+extern int delayacct_on;	/* Delay accounting turned on/off */
+extern kmem_cache_t *delayacct_cache;
+extern int delayacct_init(void);
+extern void __delayacct_tsk_init(struct task_struct *);
+extern void __delayacct_tsk_exit(struct task_struct *);
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
+static inline int delayacct_init(void)
+{}
+static inline void delayacct_tsk_init(struct task_struct *tsk)
+{}
+static inline void delayacct_tsk_exit(struct task_struct *tsk)
+{}
+#endif /* CONFIG_TASK_DELAY_ACCT */
+#endif /* _LINUX_TASKDELAYS_H */
Index: linux-2.6.16-rc5/include/linux/sched.h
===================================================================
--- linux-2.6.16-rc5.orig/include/linux/sched.h	2006-03-11 07:41:32.000000000 -0500
+++ linux-2.6.16-rc5/include/linux/sched.h	2006-03-11 07:41:37.000000000 -0500
@@ -539,6 +539,20 @@ struct sched_info {
 extern struct file_operations proc_schedstat_operations;
 #endif
 
+#ifdef CONFIG_TASK_DELAY_ACCT
+struct task_delay_info {
+	spinlock_t	lock;
+
+	/* For each stat XXX, add following, aligned appropriately
+	 *
+	 * struct timespec XXX_start, XXX_end;
+	 * u64 XXX_delay;
+	 * u32 XXX_count;
+	 */
+};
+#endif
+
+
 enum idle_type
 {
 	SCHED_IDLE,
@@ -870,6 +884,9 @@ struct task_struct {
 #endif
 	atomic_t fs_excl;	/* holding fs exclusive resources */
 	struct rcu_head rcu;
+#ifdef	CONFIG_TASK_DELAY_ACCT
+	struct task_delay_info *delays;
+#endif
 };
 
 static inline pid_t process_group(struct task_struct *tsk)
Index: linux-2.6.16-rc5/init/Kconfig
===================================================================
--- linux-2.6.16-rc5.orig/init/Kconfig	2006-03-11 07:41:32.000000000 -0500
+++ linux-2.6.16-rc5/init/Kconfig	2006-03-11 07:41:37.000000000 -0500
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
Index: linux-2.6.16-rc5/init/main.c
===================================================================
--- linux-2.6.16-rc5.orig/init/main.c	2006-03-11 07:41:32.000000000 -0500
+++ linux-2.6.16-rc5/init/main.c	2006-03-11 07:41:37.000000000 -0500
@@ -47,6 +47,7 @@
 #include <linux/rmap.h>
 #include <linux/mempolicy.h>
 #include <linux/key.h>
+#include <linux/delayacct.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -537,6 +538,7 @@ asmlinkage void __init start_kernel(void
 	proc_root_init();
 #endif
 	cpuset_init();
+	delayacct_init();
 
 	check_bugs();
 
Index: linux-2.6.16-rc5/kernel/delayacct.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.16-rc5/kernel/delayacct.c	2006-03-11 07:41:37.000000000 -0500
@@ -0,0 +1,92 @@
+/* delayacct.c - per-task delay accounting
+ *
+ * Copyright (C) Shailabh Nagar, IBM Corp. 2006
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2.1 of the GNU Lesser General Public License
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ */
+
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/time.h>
+#include <linux/sysctl.h>
+#include <linux/delayacct.h>
+
+int delayacct_on = 0;		/* Delay accounting turned on/off */
+kmem_cache_t *delayacct_cache;
+
+static int __init delayacct_setup_enable(char *str)
+{
+	delayacct_on = 1;
+	return 1;
+}
+__setup("delayacct", delayacct_setup_enable);
+
+int delayacct_init(void)
+{
+	delayacct_cache = kmem_cache_create("delayacct_cache",
+					    sizeof(struct task_delay_info),
+					    0,
+					    SLAB_PANIC,
+					    NULL, NULL);
+	if (!delayacct_cache)
+		return -ENOMEM;
+	delayacct_tsk_init(&init_task);
+	return 0;
+}
+
+void __delayacct_tsk_init(struct task_struct *tsk)
+{
+	tsk->delays = kmem_cache_alloc(delayacct_cache, SLAB_KERNEL);
+	if (tsk->delays) {
+		memset(tsk->delays, 0, sizeof(*tsk->delays));
+		spin_lock_init(&tsk->delays->lock);
+	}
+}
+
+void __delayacct_tsk_exit(struct task_struct *tsk)
+{
+	if (tsk->delays) {
+		kmem_cache_free(delayacct_cache, tsk->delays);
+		tsk->delays = NULL;
+	}
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
+	nsec_t ns;
+
+	do_posix_clock_monotonic_gettime(end);
+	timespec_diff(start, end, &ts);
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
Index: linux-2.6.16-rc5/kernel/fork.c
===================================================================
--- linux-2.6.16-rc5.orig/kernel/fork.c	2006-03-11 07:41:32.000000000 -0500
+++ linux-2.6.16-rc5/kernel/fork.c	2006-03-11 07:41:37.000000000 -0500
@@ -44,6 +44,7 @@
 #include <linux/rmap.h>
 #include <linux/acct.h>
 #include <linux/cn_proc.h>
+#include <linux/delayacct.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -970,6 +971,7 @@ static task_t *copy_process(unsigned lon
 		goto bad_fork_cleanup_put_domain;
 
 	p->did_exec = 0;
+	delayacct_tsk_init(p);	/* Must remain after dup_task_struct() */
 	copy_flags(clone_flags, p);
 	p->pid = pid;
 	retval = -EFAULT;
Index: linux-2.6.16-rc5/kernel/exit.c
===================================================================
--- linux-2.6.16-rc5.orig/kernel/exit.c	2006-03-11 07:41:32.000000000 -0500
+++ linux-2.6.16-rc5/kernel/exit.c	2006-03-11 07:41:37.000000000 -0500
@@ -31,6 +31,7 @@
 #include <linux/signal.h>
 #include <linux/cn_proc.h>
 #include <linux/mutex.h>
+#include <linux/delayacct.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -842,6 +843,8 @@ fastcall NORET_TYPE void do_exit(long co
 				preempt_count());
 
 	acct_update_integrals(tsk);
+	delayacct_tsk_exit(tsk);
+
 	if (tsk->mm) {
 		update_hiwater_rss(tsk->mm);
 		update_hiwater_vm(tsk->mm);


