Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161065AbWI1LPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161065AbWI1LPI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 07:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161068AbWI1LPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 07:15:06 -0400
Received: from smtp-out.google.com ([216.239.45.12]:13530 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1161065AbWI1LO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 07:14:58 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:references:user-agent:date:from:to:cc:
	subject:content-disposition:sender;
	b=eOjD2yfVvnKihWLcbDxssZp8EJbj6xzza8M2xCYQ4GU7eo4iFRctv3lEQB3y+dka6
	Tj+8gNc7RbqqFn6Sb3eRA==
Message-Id: <20060928111408.679660000@menage.corp.google.com>
References: <20060928104035.840699000@menage.corp.google.com>
User-Agent: quilt/0.45-1
Date: Thu, 28 Sep 2006 03:40:39 -0700
From: menage@google.com
To: pj@sgi.com, akpm@osdl.org, ckrm-tech@lists.sourceforge.net,
       mbligh@google.com, rohitseth@google.com, winget@google.com, dev@sw.ru,
       sekharan@us.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 4/4] Simple CPU accounting container subsystem
Content-Disposition: inline; filename=cpu_acct
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This demonstrates how to use the generic container subsystem for a
simple resource tracker that counts the total CPU time used by all
processes in a container, during the time that they're members of the
container.


---
 include/linux/cpu_acct.h |   10 ++++
 init/Kconfig             |    8 +++
 kernel/Makefile          |    1 
 kernel/cpu_acct.c        |  104 +++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched.c           |    6 ++
 5 files changed, 129 insertions(+)

Index: linux-2.6.18/include/linux/cpu_acct.h
===================================================================
--- /dev/null
+++ linux-2.6.18/include/linux/cpu_acct.h
@@ -0,0 +1,10 @@
+
+#ifndef _LINUX_CPU_ACCT_H
+#define _LINUX_CPU_ACCT_H
+
+#include <linux/container.h>
+#include <asm/cputime.h>
+
+extern void cpuacct_charge(struct task_struct *, cputime_t cputime);
+
+#endif
Index: linux-2.6.18/init/Kconfig
===================================================================
--- linux-2.6.18.orig/init/Kconfig
+++ linux-2.6.18/init/Kconfig
@@ -240,6 +240,14 @@ config CPUSETS
 
 	  Say N if unsure.
 
+config CONTAINER_CPUACCT
+	bool "Simple CPU accounting container subsystem"
+	depends on CONTAINERS
+	help
+	  Provides a simple Resource Controller for monitoring the
+	  total CPU consumed by the tasks in a container
+
+
 config RELAY
 	bool "Kernel->user space relay support (formerly relayfs)"
 	help
Index: linux-2.6.18/kernel/cpu_acct.c
===================================================================
--- /dev/null
+++ linux-2.6.18/kernel/cpu_acct.c
@@ -0,0 +1,104 @@
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
+extern struct container_subsys cpuacct_subsys;
+#define container_ca(_cont) (_cont)->subsys[cpuacct_subsys.subsys_id]
+
+static int cpuacct_create(struct container *cont)
+{
+	struct cpuacct *ca = kzalloc(sizeof(*ca), GFP_KERNEL);
+	if (!ca) return -ENOMEM;
+	spin_lock_init(&ca->lock);
+	container_ca(cont) = ca;
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
+	s += sprintf(s, "%llu", time);
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
+struct container_subsys cpuacct_subsys = {
+	.create = cpuacct_create,
+	.destroy = cpuacct_destroy,
+	.populate = cpuacct_populate,
+        .subsys_id = -1,
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
