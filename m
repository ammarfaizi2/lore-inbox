Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbVKODar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbVKODar (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 22:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbVKODar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 22:30:47 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:11957 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932349AbVKODaq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 22:30:46 -0500
Message-ID: <43796596.2010908@watson.ibm.com>
Date: Mon, 14 Nov 2005 23:35:34 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Patch 1/4] Delay accounting: Initialization
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

delayacct-init.patch

Setup data structures for collecting per-task delay statistics which measure
how long it had to wait for cpu, block io and page fault completion. The
collection of statistics and the interface are in other patches for easier
review and selection.

Signed-off-by: Shailabh Nagar <nagar@watson.ibm.com>

 include/linux/delayacct.h |   57 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/sched.h     |   11 ++++++++
 init/Kconfig              |   13 ++++++++++
 init/main.c               |    2 +
 kernel/fork.c             |    2 +
 5 files changed, 85 insertions(+)

Index: linux-2.6.14/init/Kconfig
===================================================================
--- linux-2.6.14.orig/init/Kconfig
+++ linux-2.6.14/init/Kconfig
@@ -162,6 +162,19 @@ config BSD_PROCESS_ACCT_V3
 	  for processing it. A preliminary version of these tools is available
 	  at <http://www.physik3.uni-rostock.de/tim/kernel/utils/acct/>.

+config DELAY_ACCT
+	bool "Enable per-task delay accounting (EXPERIMENTAL)"
+	help
+	  Collect information on time spent by a task waiting for system
+	  resources like cpu, block I/O	completion and page fault servicing.
+	  Such statistics can help in setting a task's priorities relative to
+	  other tasks for cpu, io, rss limits etc.
+
+	  Unlike BSD process accounting, this information is available
+	  continuously during the lifetime of a task.
+
+	  Say N if unsure.
+
 config SYSCTL
 	bool "Sysctl support"
 	---help---
Index: linux-2.6.14/include/linux/sched.h
===================================================================
--- linux-2.6.14.orig/include/linux/sched.h
+++ linux-2.6.14/include/linux/sched.h
@@ -497,6 +497,14 @@ struct sched_info {
 extern struct file_operations proc_schedstat_operations;
 #endif

+#ifdef CONFIG_DELAY_ACCT
+struct task_delay_info {
+	spinlock_t	lock;
+
+	/* Add stats in pairs: uint64_t delay, uint32_t count */
+};
+#endif
+
 enum idle_type
 {
 	SCHED_IDLE,
@@ -813,6 +821,9 @@ struct task_struct {
 	int cpuset_mems_generation;
 #endif
 	atomic_t fs_excl;	/* holding fs exclusive resources */
+#ifdef	CONFIG_DELAY_ACCT
+	struct task_delay_info delays;
+#endif
 };

 static inline pid_t process_group(struct task_struct *tsk)
Index: linux-2.6.14/kernel/fork.c
===================================================================
--- linux-2.6.14.orig/kernel/fork.c
+++ linux-2.6.14/kernel/fork.c
@@ -42,6 +42,7 @@
 #include <linux/profile.h>
 #include <linux/rmap.h>
 #include <linux/acct.h>
+#include <linux/delayacct.h>

 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -934,6 +935,7 @@ static task_t *copy_process(unsigned lon
 	if (p->binfmt && !try_module_get(p->binfmt->module))
 		goto bad_fork_cleanup_put_domain;

+	delayacct_init(p);
 	p->did_exec = 0;
 	copy_flags(clone_flags, p);
 	p->pid = pid;
Index: linux-2.6.14/init/main.c
===================================================================
--- linux-2.6.14.orig/init/main.c
+++ linux-2.6.14/init/main.c
@@ -47,6 +47,7 @@
 #include <linux/rmap.h>
 #include <linux/mempolicy.h>
 #include <linux/key.h>
+#include <linux/delayacct.h>
 #include <net/sock.h>

 #include <asm/io.h>
@@ -537,6 +538,7 @@ asmlinkage void __init start_kernel(void
 	proc_root_init();
 #endif
 	cpuset_init();
+	delayacct_init(&init_task);

 	check_bugs();

Index: linux-2.6.14/include/linux/delayacct.h
===================================================================
--- /dev/null
+++ linux-2.6.14/include/linux/delayacct.h
@@ -0,0 +1,57 @@
+/* delayacctdelays.h - for delay accounting
+ *
+ * Copyright (C) Shailabh Nagar, IBM Corp. 2005
+ * Based on earlier work by Hubertus Franke, IBM Corp. 2003
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
+#include <linux/types.h>
+#include <linux/sched.h>
+
+#ifdef CONFIG_DELAY_ACCT
+
+static inline void delayacct_init(struct task_struct *tsk)
+{
+	memset(&tsk->delays, 0, sizeof(tsk->delays));
+	spin_lock_init(&tsk->delays.lock);
+}
+
+#define delayacct_def_var(ts)		unsigned long long ts
+static inline void delayacct_timestamp(unsigned long long *ts)
+{
+	*ts = sched_clock();
+}
+
+/* because of hardware timer drifts in SMPs and task continue on different cpu
+ * then where the start_ts was taken there is a possibility that
+ * end_ts < start_ts by some usecs. In this case we ignore the diff
+ * and add nothing to the total.
+ */
+#ifdef CONFIG_SMP
+#define test_ts_integrity(start_ts, end_ts)  (likely((end_ts) > (start_ts)))
+#else
+#define test_ts_integrity(start_ts, end_ts)  (1)
+#endif
+
+#else
+
+static inline void delayacct_init(struct task_struct *tsk)
+{}
+#define delayacct_def_var(ts)
+static inline void delayacct_timestamp(unsigned long long *ts)
+{}
+
+#endif /* CONFIG_DELAY_ACCT */
+
+
+#endif /* _LINUX_TASKDELAYS_H */
