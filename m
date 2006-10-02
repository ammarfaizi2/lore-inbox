Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbWJBKj0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWJBKj0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 06:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWJBKjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 06:39:21 -0400
Received: from smtp-out.google.com ([216.239.45.12]:35280 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750761AbWJBKjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 06:39:14 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:references:user-agent:date:from:to:cc:
	subject:content-disposition:sender;
	b=sf9eoh9MzP86RHMZVwG4AdkPCuyVGQsglXq5PgAYvtPW/l32UfOiw9MceUowktLeJ
	a2NNjUY3jCLgnyPfidm1Q==
Message-Id: <20061002103826.117030000@menage.corp.google.com>
References: <20061002095319.865614000@menage.corp.google.com>
User-Agent: quilt/0.45-1
Date: Mon, 02 Oct 2006 02:53:23 -0700
From: Paul Menage <menage@google.com>
To: pj@sgi.com, akpm@osdl.org, ckrm-tech@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, winget@google.com, mbligh@google.com,
       rohitseth@google.com, sekharan@us.ibm.com, jlan@sgi.com
Subject: [RFC][PATCH 4/4] Simple CPU accounting container subsystem
Content-Disposition: inline; filename=cpu_acct
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This demonstrates how to use the generic container subsystem for a
simple resource tracker that counts the total CPU time used by all
processes in a container, during the time that they're members of the
container.

Signed-off-by: Paul Menage <menage@google.com>

---
 include/linux/cpu_acct.h |   14 ++++++
 init/Kconfig             |    7 +++
 kernel/Makefile          |    1 
 kernel/cpu_acct.c        |  108 +++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched.c           |    6 ++
 5 files changed, 136 insertions(+)

Index: linux-2.6.18/include/linux/cpu_acct.h
===================================================================
--- /dev/null
+++ linux-2.6.18/include/linux/cpu_acct.h
@@ -0,0 +1,14 @@
+
+#ifndef _LINUX_CPU_ACCT_H
+#define _LINUX_CPU_ACCT_H
+
+#include <linux/container.h>
+#include <asm/cputime.h>
+
+#ifdef CONFIG_CONTAINER_CPUACCT
+extern void cpuacct_charge(struct task_struct *, cputime_t cputime);
+#else
+static void inline cpuacct_charge(struct task_struct *p, cputime_t cputime) {}
+#endif
+
+#endif
Index: linux-2.6.18/init/Kconfig
===================================================================
--- linux-2.6.18.orig/init/Kconfig
+++ linux-2.6.18/init/Kconfig
@@ -244,6 +244,13 @@ config CPUSETS_DEFAULT_ENABLED
 	  default at boot, for compatibility with legacy cpuset
 	  semantics
 
+config CONTAINER_CPUACCT
+	bool "Simple CPU accounting container subsystem"
+	select CONTAINERS
+	help
+	  Provides a simple Resource Controller for monitoring the
+	  total CPU consumed by the tasks in a container
+
 config RELAY
 	bool "Kernel->user space relay support (formerly relayfs)"
 	help
Index: linux-2.6.18/kernel/cpu_acct.c
===================================================================
--- /dev/null
+++ linux-2.6.18/kernel/cpu_acct.c
@@ -0,0 +1,108 @@
+/*
+ * kernel/cpu_acct.c - CPU accounting container subsystem
+ *
+ * Copyright (C) Google Inc, 2006
+ *
+ */
+
+/*
+ * Container subsystem for reporting total CPU usage of tasks in a
+ * container.
+ */
+
+#include <linux/module.h>
+#include <linux/container.h>
+#include <linux/fs.h>
+#include <asm/div64.h>
+
+struct cpuacct {
+	spinlock_t lock;
+	cputime64_t time; // total time used by this class
+};
+
+static struct container_subsys cpuacct_subsys;
+static inline struct cpuacct *container_ca(struct container *cont)
+{
+	return (struct cpuacct *)cont->subsys[cpuacct_subsys.subsys_id];
+}
+
+static int cpuacct_create(struct container *cont)
+{
+	struct cpuacct *ca = kzalloc(sizeof(*ca), GFP_KERNEL);
+	if (!ca) return -ENOMEM;
+	spin_lock_init(&ca->lock);
+	cont->subsys[cpuacct_subsys.subsys_id] = ca;
+	return 0;
+}
+
+static void cpuacct_destroy(struct container *cont)
+{
+	kfree(container_ca(cont));
+}
+
+static ssize_t cpuusage_read(struct container *cont,
+			     struct cftype *cft,
+			     struct file *file,
+			     char __user *buf,
+			     size_t nbytes, loff_t *ppos)
+{
+	struct cpuacct *ca = container_ca(cont);
+	cputime64_t time;
+	char usagebuf[64];
+	char *s = usagebuf;
+
+	spin_lock_irq(&ca->lock);
+	time = ca->time;
+	spin_unlock_irq(&ca->lock);
+
+	time *= 1000;
+	do_div(time, HZ);
+	s += sprintf(s, "%llu", (unsigned long long) time);
+
+	return simple_read_from_buffer(buf, nbytes, ppos, usagebuf, s - usagebuf);
+}
+
+static struct cftype cft_usage = {
+	.name = "cpu_usage",
+	.read = cpuusage_read,
+};
+
+static int cpuacct_populate(struct container *cont)
+{
+	return container_add_file(cont, &cft_usage);
+}
+
+
+void cpuacct_charge(struct task_struct *task, cputime_t cputime) {
+
+	struct cpuacct *ca;
+	struct container *cont;
+	unsigned long flags;
+
+	if (cpuacct_subsys.subsys_id < 0) return;
+	rcu_read_lock();
+	cont = rcu_dereference(task->container);
+	ca = container_ca(cont);
+	if (ca) {
+		spin_lock_irqsave(&ca->lock, flags);
+		ca->time = cputime64_add(ca->time, cputime);
+		spin_unlock_irqrestore(&ca->lock, flags);
+	}
+	rcu_read_unlock();
+}
+
+static struct container_subsys cpuacct_subsys = {
+	.name = "cpuacct",
+	.create = cpuacct_create,
+	.destroy = cpuacct_destroy,
+	.populate = cpuacct_populate,
+	.subsys_id = -1,
+};
+
+int __init init_cpuacct(void)
+{
+	int id = container_register_subsys(&cpuacct_subsys);
+	return id < 0 ? id : 0;
+}
+
+module_init(init_cpuacct)
Index: linux-2.6.18/kernel/Makefile
===================================================================
--- linux-2.6.18.orig/kernel/Makefile
+++ linux-2.6.18/kernel/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_KEXEC) += kexec.o
 obj-$(CONFIG_COMPAT) += compat.o
 obj-$(CONFIG_CONTAINERS) += container.o
 obj-$(CONFIG_CPUSETS) += cpuset.o
+obj-$(CONFIG_CONTAINER_CPUACCT) += cpu_acct.o
 obj-$(CONFIG_IKCONFIG) += configs.o
 obj-$(CONFIG_STOP_MACHINE) += stop_machine.o
 obj-$(CONFIG_AUDIT) += audit.o auditfilter.o
Index: linux-2.6.18/kernel/sched.c
===================================================================
--- linux-2.6.18.orig/kernel/sched.c
+++ linux-2.6.18/kernel/sched.c
@@ -52,6 +52,7 @@
 #include <linux/acct.h>
 #include <linux/kprobes.h>
 #include <linux/delayacct.h>
+#include <linux/cpu_acct.h>
 #include <asm/tlb.h>
 
 #include <asm/unistd.h>
@@ -2918,6 +2919,8 @@ void account_user_time(struct task_struc
 
 	p->utime = cputime_add(p->utime, cputime);
 
+	cpuacct_charge(p, cputime);
+
 	/* Add user time to cpustat. */
 	tmp = cputime_to_cputime64(cputime);
 	if (TASK_NICE(p) > 0)
@@ -2941,6 +2944,9 @@ void account_system_time(struct task_str
 
 	p->stime = cputime_add(p->stime, cputime);
 
+	if (p != rq->idle)
+		cpuacct_charge(p, cputime);
+
 	/* Add system time to cpustat. */
 	tmp = cputime_to_cputime64(cputime);
 	if (hardirq_count() - hardirq_offset)

--
