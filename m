Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964848AbWACX1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbWACX1H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965048AbWACX1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:27:06 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:5549 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S965021AbWACX04 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:26:56 -0500
Message-ID: <43BB082E.3010005@watson.ibm.com>
Date: Tue, 03 Jan 2006 23:26:38 +0000
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       LSE <lse-tech@lists.sourceforge.net>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: [Patch 2/6] Delay accounting: Initialization, kernel boot option
References: <43BB05D8.6070101@watson.ibm.com>
In-Reply-To: <43BB05D8.6070101@watson.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since 11/14/05

- use nanosecond resolution, adjusted wall clock time for timestamps
  instead of sched_clock (akpm, andi, marcelo)
- kernel boot param to control delay stats collection (parag)
- better CONFIG parameter name (parag)

11/14/05: First post

delayacct-init.patch

Initialization code related to collection of per-task "delay"
statistics which measure how long it had to wait for cpu,
sync block io, swapping etc.. The collection of statistics and
the interface are in other patches. This patch sets up the data
structures and allows the statistics collection to be disabled
through a  kernel boot paramater.


Signed-off-by: Shailabh Nagar <nagar@watson.ibm.com>

 Documentation/kernel-parameters.txt |    2 ++
 include/linux/delayacct.h           |   26 ++++++++++++++++++++++++++
 include/linux/sched.h               |   11 +++++++++++
 init/Kconfig                        |   13 +++++++++++++
 kernel/Makefile                     |    1 +
 kernel/delayacct.c                  |   36 ++++++++++++++++++++++++++++++++++++
 kernel/fork.c                       |    2 ++
 7 files changed, 91 insertions(+)

Index: linux-2.6.15-rc7/init/Kconfig
===================================================================
--- linux-2.6.15-rc7.orig/init/Kconfig
+++ linux-2.6.15-rc7/init/Kconfig
@@ -162,6 +162,19 @@ config BSD_PROCESS_ACCT_V3
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
Index: linux-2.6.15-rc7/include/linux/sched.h
===================================================================
--- linux-2.6.15-rc7.orig/include/linux/sched.h
+++ linux-2.6.15-rc7/include/linux/sched.h
@@ -541,6 +541,14 @@ struct sched_info {
 extern struct file_operations proc_schedstat_operations;
 #endif

+#ifdef CONFIG_TASK_DELAY_ACCT
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
@@ -857,6 +865,9 @@ struct task_struct {
 	int cpuset_mems_generation;
 #endif
 	atomic_t fs_excl;	/* holding fs exclusive resources */
+#ifdef	CONFIG_TASK_DELAY_ACCT
+	struct task_delay_info delays;
+#endif
 };

 static inline pid_t process_group(struct task_struct *tsk)
Index: linux-2.6.15-rc7/kernel/fork.c
===================================================================
--- linux-2.6.15-rc7.orig/kernel/fork.c
+++ linux-2.6.15-rc7/kernel/fork.c
@@ -43,6 +43,7 @@
 #include <linux/rmap.h>
 #include <linux/acct.h>
 #include <linux/cn_proc.h>
+#include <linux/delayacct.h>

 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -923,6 +924,7 @@ static task_t *copy_process(unsigned lon
 	if (p->binfmt && !try_module_get(p->binfmt->module))
 		goto bad_fork_cleanup_put_domain;

+	delayacct_tsk_init(p);
 	p->did_exec = 0;
 	copy_flags(clone_flags, p);
 	p->pid = pid;
Index: linux-2.6.15-rc7/include/linux/delayacct.h
===================================================================
--- /dev/null
+++ linux-2.6.15-rc7/include/linux/delayacct.h
@@ -0,0 +1,26 @@
+/* delayacct.h - per-task delay accounting
+ *
+ * Copyright (C) Shailabh Nagar, IBM Corp. 2005
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
+extern void delayacct_tsk_init(struct task_struct *tsk);
+#else
+static inline void delayacct_tsk_init(struct task_struct *tsk)
+{}
+#endif /* CONFIG_TASK_DELAY_ACCT */
+#endif /* _LINUX_TASKDELAYS_H */
Index: linux-2.6.15-rc7/Documentation/kernel-parameters.txt
===================================================================
--- linux-2.6.15-rc7.orig/Documentation/kernel-parameters.txt
+++ linux-2.6.15-rc7/Documentation/kernel-parameters.txt
@@ -921,6 +921,8 @@ running once the system is up.

 	nocache		[ARM]

+	nodelayacct	[KNL] Disable per-task delay accounting
+
 	nodisconnect	[HW,SCSI,M68K] Disables SCSI disconnects.

 	noexec		[IA-64]
Index: linux-2.6.15-rc7/kernel/Makefile
===================================================================
--- linux-2.6.15-rc7.orig/kernel/Makefile
+++ linux-2.6.15-rc7/kernel/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
 obj-$(CONFIG_CRASH_DUMP) += crash_dump.o
 obj-$(CONFIG_SECCOMP) += seccomp.o
 obj-$(CONFIG_RCU_TORTURE_TEST) += rcutorture.o
+obj-$(CONFIG_TASK_DELAY_ACCT) += delayacct.o

 ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
Index: linux-2.6.15-rc7/kernel/delayacct.c
===================================================================
--- /dev/null
+++ linux-2.6.15-rc7/kernel/delayacct.c
@@ -0,0 +1,36 @@
+/* delayacct.c - per-task delay accounting
+ *
+ * Copyright (C) Shailabh Nagar, IBM Corp. 2005
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
+
+int delayacct_on=1;	/* Delay accounting turned on/off */
+
+static int __init delayacct_setup_disable(char *str)
+{
+	delayacct_on = 0;
+	return 1;
+}
+__setup("nodelayacct", delayacct_setup_disable);
+
+inline void delayacct_tsk_init(struct task_struct *tsk)
+{
+	memset(&tsk->delays, 0, sizeof(tsk->delays));
+	spin_lock_init(&tsk->delays.lock);
+}
+
+static int __init delayacct_init(void)
+{
+	delayacct_tsk_init(&init_task);
+	return 0;
+}
+core_initcall(delayacct_init);
