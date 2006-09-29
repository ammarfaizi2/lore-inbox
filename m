Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751313AbWI2CNG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbWI2CNG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 22:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWI2CNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 22:13:05 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:21739 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751313AbWI2CNC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 22:13:02 -0400
Message-Id: <20060929021300.034805000@us.ibm.com>
References: <20060929020232.756637000@us.ibm.com>
User-Agent: quilt/0.45-1
Date: Thu, 28 Sep 2006 19:02:34 -0700
From: Matt Helsley <matthltc@us.ibm.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Jes Sorensen <jes@sgi.com>, LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       John T Kohl <jtk@us.ibm.com>, Christoph Hellwig <hch@lst.de>,
       Al Viro <viro@zeniv.linux.org.uk>, Steve Grubb <sgrubb@redhat.com>,
       linux-audit@redhat.com, Paul Jackson <pj@sgi.com>
Subject: [RFC][PATCH 02/10] Task watchers v2 Benchmark
Content-Disposition: inline; filename=task-watchers-benchmark
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This optional patch adds a fork/exit rate measurement facility using task
watchers. It is intended to be a tool for measuring the impact of task watchers
on fork and exit-heavy workloads.

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
---
 kernel/Makefile   |    1 
 kernel/twbench.c  |  103 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug |   12 ++++++
 3 files changed, 116 insertions(+)

Index: linux-2.6.18-mm1/kernel/twbench.c
===================================================================
--- /dev/null
+++ linux-2.6.18-mm1/kernel/twbench.c
@@ -0,0 +1,103 @@
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/task_watchers.h>
+
+#include <linux/debugfs.h>
+#include <linux/time.h>
+#include <linux/preempt.h>
+
+#include <asm/atomic.h>
+#include <asm/div64.h>
+
+struct twb_counter {
+	atomic_t count;
+	u64 reset_time_ns;
+};
+
+static u64 read_reset_rate(void *p)
+{
+	u64 rate, ts_ns;
+	struct timespec ts;
+	struct twb_counter *ctr = p;
+
+	/* begin pseudo-atomic region */
+	preempt_disable();
+	rate = atomic_xchg(((atomic_t*)&ctr->count), 0);
+	ktime_get_ts(&ts);
+	preempt_enable();
+	/* end pseudo-atomic region */
+
+	ts_ns = timespec_to_ns(&ts);
+	rate *= NSEC_PER_SEC;
+	do_div(rate, (u32)(ts_ns - ctr->reset_time_ns));
+	ctr->reset_time_ns = ts_ns;
+	return rate;
+}
+
+/* Counter bits */
+static struct twb_counter num_clones;
+static struct twb_counter num_exits;
+
+#ifndef MODULE
+static int inc_clone(unsigned long val, struct task_struct *task)
+{
+	atomic_inc(&num_clones.count);
+	return 0;
+}
+task_watcher_func(clone, inc_clone);
+
+static int inc_exit(unsigned long val, struct task_struct *task)
+{
+	atomic_inc(&num_exits.count);
+	return 0;
+}
+task_watcher_func(exit, inc_exit);
+#endif
+
+/* Debugfs bits */
+static struct dentry *twb_root, *twb_clone_file, *twb_exit_file;
+
+/*
+ * NOTE: Because open doesn't reset the count nor the reset time,
+ *       userspace must discard the first values read before starting
+ *       to monitor the rates.
+ */
+DEFINE_SIMPLE_ATTRIBUTE(rrr, read_reset_rate, NULL, "%llu\n");
+
+static int __init twb_debugfs_init(void)
+{
+	twb_root = debugfs_create_dir("twbench", NULL);
+	if (!twb_root)
+		return -ENOMEM;
+	twb_clone_file = debugfs_create_file("clones", 0744, twb_root,
+					     &num_clones, &rrr);
+	twb_exit_file = debugfs_create_file("exits", 0744, twb_root,
+					    &num_exits, &rrr);
+	return 0;
+}
+#ifndef MODULE
+__initcall(twb_debugfs_init);
+#endif
+
+static void __exit twb_debugfs_exit(void)
+{
+	debugfs_remove(twb_clone_file);
+	debugfs_remove(twb_exit_file);
+	debugfs_remove(twb_root);
+}
+
+static int __init twb_mod_init(void)
+{
+	int ret;
+
+	ret = twb_debugfs_init();
+	return ret;
+}
+
+static void __exit twb_mod_exit(void)
+{
+	twb_debugfs_exit();
+}
+
+module_init(twb_mod_init);
+module_exit(twb_mod_exit);
Index: linux-2.6.18-mm1/lib/Kconfig.debug
===================================================================
--- linux-2.6.18-mm1.orig/lib/Kconfig.debug
+++ linux-2.6.18-mm1/lib/Kconfig.debug
@@ -443,10 +443,22 @@ config RCU_TORTURE_TEST
 	  Say Y here if you want RCU torture tests to start automatically
 	  at boot time (you probably don't).
 	  Say M if you want the RCU torture tests to build as a module.
 	  Say N if you are unsure.
 
+config TWBENCH
+	bool "Output fork/clone and exit rates"
+	depends on DEBUG_KERNEL && DEBUG_FS
+	default n
+	help
+	   Print out the rate at which the system is fork/cloning new
+	   processes to <debugfs>/twbench/clone
+	   Print out the rate at which the system is exitting existing
+	   processes to <debugfs>/twbench/exit
+
+	   If unsure, say N.
+
 config LKDTM
 	tristate "Linux Kernel Dump Test Tool Module"
 	depends on KPROBES
 	default n
 	help
Index: linux-2.6.18-mm1/kernel/Makefile
===================================================================
--- linux-2.6.18-mm1.orig/kernel/Makefile
+++ linux-2.6.18-mm1/kernel/Makefile
@@ -45,10 +45,11 @@ obj-$(CONFIG_KPROBES) += kprobes.o
 obj-$(CONFIG_SYSFS) += ksysfs.o
 obj-$(CONFIG_DETECT_SOFTLOCKUP) += softlockup.o
 obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
 obj-$(CONFIG_SECCOMP) += seccomp.o
 obj-$(CONFIG_RCU_TORTURE_TEST) += rcutorture.o
+obj-$(CONFIG_TWBENCH) += twbench.o
 obj-$(CONFIG_DEBUG_SYNCHRO_TEST) += synchro-test.o
 obj-$(CONFIG_RELAY) += relay.o
 obj-$(CONFIG_UTS_NS) += utsname.o
 obj-$(CONFIG_TASK_DELAY_ACCT) += delayacct.o
 obj-$(CONFIG_TASKSTATS) += taskstats.o tsacct.o

--
