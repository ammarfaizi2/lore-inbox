Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264822AbUEaWTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264822AbUEaWTI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 18:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264821AbUEaWTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 18:19:06 -0400
Received: from aun.it.uu.se ([130.238.12.36]:56252 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S264820AbUEaWS0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 18:18:26 -0400
Date: Tue, 1 Jun 2004 00:18:18 +0200 (MEST)
Message-Id: <200405312218.i4VMIISg012277@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][1/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: core
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

perfctr-2.7.3 for 2.6.7-rc1-mm1, part 1/6:

- core driver files and kernel changes

 drivers/Makefile          |    1 
 drivers/perfctr/Kconfig   |   45 +++++++++++++
 drivers/perfctr/Makefile  |   16 ++++
 drivers/perfctr/cpumask.h |   24 +++++++
 drivers/perfctr/init.c    |   97 +++++++++++++++++++++++++++++
 drivers/perfctr/version.h |    1 
 include/linux/perfctr.h   |  153 ++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched.c            |    3 
 kernel/sys.c              |    6 +
 kernel/timer.c            |    2 
 10 files changed, 348 insertions(+)

diff -ruN linux-2.6.7-rc1-mm1/drivers/Makefile linux-2.6.7-rc1-mm1.perfctr-2.7.3.core/drivers/Makefile
--- linux-2.6.7-rc1-mm1/drivers/Makefile	2004-04-04 13:49:10.000000000 +0200
+++ linux-2.6.7-rc1-mm1.perfctr-2.7.3.core/drivers/Makefile	2004-05-31 23:43:34.232821000 +0200
@@ -49,4 +49,5 @@
 obj-$(CONFIG_MCA)		+= mca/
 obj-$(CONFIG_EISA)		+= eisa/
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
+obj-$(CONFIG_PERFCTR)		+= perfctr/
 obj-y				+= firmware/
diff -ruN linux-2.6.7-rc1-mm1/drivers/perfctr/Kconfig linux-2.6.7-rc1-mm1.perfctr-2.7.3.core/drivers/perfctr/Kconfig
--- linux-2.6.7-rc1-mm1/drivers/perfctr/Kconfig	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.7-rc1-mm1.perfctr-2.7.3.core/drivers/perfctr/Kconfig	2004-05-31 23:43:34.232821000 +0200
@@ -0,0 +1,45 @@
+# $Id: Kconfig,v 1.10 2004/05/24 11:00:55 mikpe Exp $
+# Performance-monitoring counters driver configuration
+#
+
+menu "Performance-monitoring counters support"
+
+config PERFCTR
+	bool "Performance monitoring counters support"
+	help
+	  This driver provides access to the performance-monitoring counter
+	  registers available in some (but not all) modern processors.
+	  These special-purpose registers can be programmed to count low-level
+	  performance-related events which occur during program execution,
+	  such as cache misses, pipeline stalls, etc.
+
+	  You can safely say Y here, even if you intend to run the kernel
+	  on a processor without performance-monitoring counters.
+
+config PERFCTR_INIT_TESTS
+	bool "Init-time hardware tests"
+	depends on PERFCTR
+	help
+	  This option makes the driver perform additional hardware tests
+	  during initialisation, and log their results in the kernel's
+	  message buffer. For most supported processors, these tests simply
+	  measure the runtime overheads of performance counter operations.
+
+	  If you have a less well-known processor (one not listed in the
+	  etc/costs/ directory in the user-space package), you should enable
+	  this option and email the results to the perfctr developers.
+
+	  If unsure, say N.
+
+config PERFCTR_VIRTUAL
+	bool "Virtual performance counters support"
+	depends on PERFCTR
+	help
+	  The processor's performance-monitoring counters are special-purpose
+	  global registers. This option adds support for virtual per-process
+	  performance-monitoring counters which only run when the process
+	  to which they belong is executing. This improves the accuracy of
+	  performance measurements by reducing "noise" from other processes.
+
+	  Say Y.
+endmenu
diff -ruN linux-2.6.7-rc1-mm1/drivers/perfctr/Makefile linux-2.6.7-rc1-mm1.perfctr-2.7.3.core/drivers/perfctr/Makefile
--- linux-2.6.7-rc1-mm1/drivers/perfctr/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.7-rc1-mm1.perfctr-2.7.3.core/drivers/perfctr/Makefile	2004-05-31 23:43:34.232821000 +0200
@@ -0,0 +1,16 @@
+# $Id: Makefile,v 1.26 2004/05/30 23:02:14 mikpe Exp $
+# Makefile for the Performance-monitoring counters driver.
+
+# This also covers x86_64.
+perfctr-objs-$(CONFIG_X86) := x86.o
+tests-objs-$(CONFIG_X86) := x86_tests.o
+
+perfctr-objs-$(CONFIG_PPC32) := ppc.o
+tests-objs-$(CONFIG_PPC32) := ppc_tests.o
+
+perfctr-objs-y += init.o
+perfctr-objs-$(CONFIG_PERFCTR_INIT_TESTS) += $(tests-objs-y)
+perfctr-objs-$(CONFIG_PERFCTR_VIRTUAL) += virtual.o
+
+perfctr-objs		:= $(perfctr-objs-y)
+obj-$(CONFIG_PERFCTR)	:= perfctr.o
diff -ruN linux-2.6.7-rc1-mm1/drivers/perfctr/cpumask.h linux-2.6.7-rc1-mm1.perfctr-2.7.3.core/drivers/perfctr/cpumask.h
--- linux-2.6.7-rc1-mm1/drivers/perfctr/cpumask.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.7-rc1-mm1.perfctr-2.7.3.core/drivers/perfctr/cpumask.h	2004-05-31 23:43:34.232821000 +0200
@@ -0,0 +1,24 @@
+/* $Id: cpumask.h,v 1.7 2004/05/12 19:59:01 mikpe Exp $
+ * Performance-monitoring counters driver.
+ * Partial simulation of cpumask_t on non-cpumask_t kernels.
+ * Extension to allow inspecting a cpumask_t as array of ulong.
+ * Appropriate definition of perfctr_cpus_forbidden_mask.
+ *
+ * Copyright (C) 2003-2004  Mikael Pettersson
+ */
+
+#ifdef CPU_ARRAY_SIZE
+#define PERFCTR_CPUMASK_NRLONGS	CPU_ARRAY_SIZE
+#else
+#define PERFCTR_CPUMASK_NRLONGS	1
+#endif
+
+/* `perfctr_cpus_forbidden_mask' used to be defined in <asm/perfctr.h>,
+   but cpumask_t compatibility issues forced it to be moved here. */
+#if PERFCTR_CPUS_FORBIDDEN_MASK_NEEDED
+extern cpumask_t perfctr_cpus_forbidden_mask;
+#define perfctr_cpu_is_forbidden(cpu)	cpu_isset((cpu), perfctr_cpus_forbidden_mask)
+#else
+#define perfctr_cpus_forbidden_mask	CPU_MASK_NONE
+#define perfctr_cpu_is_forbidden(cpu)	0 /* cpu_isset() needs an lvalue :-( */
+#endif
diff -ruN linux-2.6.7-rc1-mm1/drivers/perfctr/init.c linux-2.6.7-rc1-mm1.perfctr-2.7.3.core/drivers/perfctr/init.c
--- linux-2.6.7-rc1-mm1/drivers/perfctr/init.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.7-rc1-mm1.perfctr-2.7.3.core/drivers/perfctr/init.c	2004-05-31 23:43:34.232821000 +0200
@@ -0,0 +1,97 @@
+/* $Id: init.c,v 1.76 2004/05/31 18:18:55 mikpe Exp $
+ * Performance-monitoring counters driver.
+ * Top-level initialisation code.
+ *
+ * Copyright (C) 1999-2004  Mikael Pettersson
+ */
+#include <linux/config.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/perfctr.h>
+
+#include <asm/uaccess.h>
+
+#include "cpumask.h"
+#include "virtual.h"
+#include "version.h"
+
+struct perfctr_info perfctr_info = {
+	.abi_version = PERFCTR_ABI_VERSION,
+	.driver_version = VERSION,
+};
+
+char *perfctr_cpu_name __initdata;
+
+static int cpus_copy_to_user(const cpumask_t *cpus, struct perfctr_cpu_mask *argp)
+{
+	const unsigned int k_nrwords = PERFCTR_CPUMASK_NRLONGS*(sizeof(long)/sizeof(int));
+	unsigned int u_nrwords;
+	unsigned int ui, ki, j;
+
+	if (get_user(u_nrwords, &argp->nrwords))
+		return -EFAULT;
+	if (put_user(k_nrwords, &argp->nrwords))
+		return -EFAULT;
+	if (u_nrwords < k_nrwords)
+		return -EOVERFLOW;
+	for(ui = 0, ki = 0; ki < PERFCTR_CPUMASK_NRLONGS; ++ki) {
+		unsigned long mask = cpus_addr(*cpus)[ki];
+		for(j = 0; j < sizeof(long)/sizeof(int); ++j) {
+			if (put_user((unsigned int)mask, &argp->mask[ui]))
+				return -EFAULT;
+			++ui;
+			mask = (mask >> (8*sizeof(int)-1)) >> 1;
+		}
+	}
+	return 0;
+}
+
+asmlinkage long sys_perfctr_info(struct perfctr_info *infop,
+				 struct perfctr_cpu_mask *cpusp,
+				 struct perfctr_cpu_mask *forbiddenp)
+{
+	if (infop && copy_to_user(infop, &perfctr_info, sizeof perfctr_info))
+		return -EFAULT;
+	if (cpusp) {
+		cpumask_t cpus = cpu_online_map;
+		int err = cpus_copy_to_user(&cpus, cpusp);
+		if (err)
+			return err;
+	}
+	if (forbiddenp) {
+		cpumask_t cpus = perfctr_cpus_forbidden_mask;
+		int err = cpus_copy_to_user(&cpus, forbiddenp);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
+int __init perfctr_init(void)
+{
+	int err;
+
+	err = perfctr_cpu_init();
+	if (err) {
+		printk(KERN_INFO "perfctr: not supported by this processor\n");
+		return err;
+	}
+	err = vperfctr_init();
+	if (err)
+		return err;
+	printk(KERN_INFO "perfctr: driver %s, cpu type %s at %u kHz\n",
+	       perfctr_info.driver_version,
+	       perfctr_cpu_name,
+	       perfctr_info.cpu_khz);
+	return 0;
+}
+
+void __exit perfctr_exit(void)
+{
+	vperfctr_exit();
+	perfctr_cpu_exit();
+}
+
+module_init(perfctr_init)
+module_exit(perfctr_exit)
diff -ruN linux-2.6.7-rc1-mm1/drivers/perfctr/version.h linux-2.6.7-rc1-mm1.perfctr-2.7.3.core/drivers/perfctr/version.h
--- linux-2.6.7-rc1-mm1/drivers/perfctr/version.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.7-rc1-mm1.perfctr-2.7.3.core/drivers/perfctr/version.h	2004-05-31 23:43:34.232821000 +0200
@@ -0,0 +1 @@
+#define VERSION "2.7.3"
diff -ruN linux-2.6.7-rc1-mm1/include/linux/perfctr.h linux-2.6.7-rc1-mm1.perfctr-2.7.3.core/include/linux/perfctr.h
--- linux-2.6.7-rc1-mm1/include/linux/perfctr.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.7-rc1-mm1.perfctr-2.7.3.core/include/linux/perfctr.h	2004-05-31 23:43:34.232821000 +0200
@@ -0,0 +1,153 @@
+/* $Id: perfctr.h,v 1.78 2004/05/31 20:45:51 mikpe Exp $
+ * Performance-Monitoring Counters driver
+ *
+ * Copyright (C) 1999-2004  Mikael Pettersson
+ */
+#ifndef _LINUX_PERFCTR_H
+#define _LINUX_PERFCTR_H
+
+#ifdef CONFIG_PERFCTR	/* don't break archs without <asm/perfctr.h> */
+
+#include <asm/perfctr.h>
+
+struct perfctr_info {
+	unsigned int abi_version;
+	char driver_version[32];
+	unsigned int cpu_type;
+	unsigned int cpu_features;
+	unsigned int cpu_khz;
+	unsigned int tsc_to_cpu_mult;
+	unsigned int _reserved2;
+	unsigned int _reserved3;
+	unsigned int _reserved4;
+};
+
+struct perfctr_cpu_mask {
+	unsigned int nrwords;
+	unsigned int mask[1];	/* actually 'nrwords' */
+};
+
+/* abi_version values: Lower 16 bits contain the CPU data version, upper
+   16 bits contain the API version. Each half has a major version in its
+   upper 8 bits, and a minor version in its lower 8 bits. */
+#define PERFCTR_API_VERSION	0x0600	/* 6.0 */
+#define PERFCTR_ABI_VERSION	((PERFCTR_API_VERSION<<16)|PERFCTR_CPU_VERSION)
+
+/* cpu_features flag bits */
+#define PERFCTR_FEATURE_RDPMC	0x01
+#define PERFCTR_FEATURE_RDTSC	0x02
+#define PERFCTR_FEATURE_PCINT	0x04
+
+/* user's view of mmap:ed virtual perfctr */
+struct vperfctr_state {
+	struct perfctr_cpu_state cpu_state;
+};
+
+/* virtual perfctr control object */
+struct vperfctr_control {
+	int si_signo;
+	struct perfctr_cpu_control cpu_control;
+	unsigned int preserve;
+	unsigned int _reserved1;
+	unsigned int _reserved2;
+	unsigned int _reserved3;
+	unsigned int _reserved4;
+};
+
+#endif	/* CONFIG_PERFCTR */
+
+#ifdef __KERNEL__
+
+/*
+ * The perfctr system calls.
+ */
+asmlinkage long sys_perfctr_info(struct perfctr_info*, struct perfctr_cpu_mask*, struct perfctr_cpu_mask*);
+asmlinkage long sys_vperfctr_open(int tid, int creat);
+asmlinkage long sys_vperfctr_control(int fd, const struct vperfctr_control*);
+asmlinkage long sys_vperfctr_unlink(int fd);
+asmlinkage long sys_vperfctr_iresume(int fd);
+asmlinkage long sys_vperfctr_read(int fd,
+				  struct perfctr_sum_ctrs*,
+				  struct vperfctr_control*);
+
+extern struct perfctr_info perfctr_info;
+
+#ifdef CONFIG_PERFCTR_VIRTUAL
+
+/*
+ * Virtual per-process performance-monitoring counters.
+ */
+struct vperfctr;	/* opaque */
+
+/* process management operations */
+extern struct vperfctr *__vperfctr_copy(struct vperfctr*);
+extern void __vperfctr_exit(struct vperfctr*);
+extern void __vperfctr_suspend(struct vperfctr*);
+extern void __vperfctr_resume(struct vperfctr*);
+extern void __vperfctr_sample(struct vperfctr*);
+extern void __vperfctr_set_cpus_allowed(struct task_struct*, struct vperfctr*, cpumask_t);
+
+static inline void perfctr_copy_thread(struct thread_struct *thread)
+{
+	thread->perfctr = NULL;
+}
+
+static inline void perfctr_exit_thread(struct thread_struct *thread)
+{
+	struct vperfctr *perfctr;
+	perfctr = thread->perfctr;
+	if (perfctr)
+		__vperfctr_exit(perfctr);
+}
+
+static inline void perfctr_suspend_thread(struct thread_struct *prev)
+{
+	struct vperfctr *perfctr;
+	perfctr = prev->perfctr;
+	if (perfctr)
+		__vperfctr_suspend(perfctr);
+}
+
+static inline void perfctr_resume_thread(struct thread_struct *next)
+{
+	struct vperfctr *perfctr;
+	perfctr = next->perfctr;
+	if (perfctr)
+		__vperfctr_resume(perfctr);
+}
+
+static inline void perfctr_sample_thread(struct thread_struct *thread)
+{
+	struct vperfctr *perfctr;
+	perfctr = thread->perfctr;
+	if (perfctr)
+		__vperfctr_sample(perfctr);
+}
+
+static inline void perfctr_set_cpus_allowed(struct task_struct *p, cpumask_t new_mask)
+{
+#if PERFCTR_CPUS_FORBIDDEN_MASK_NEEDED
+	struct vperfctr *perfctr;
+
+	task_lock(p);
+	perfctr = p->thread.perfctr;
+	if (perfctr)
+		__vperfctr_set_cpus_allowed(p, perfctr, new_mask);
+	task_unlock(p);
+#endif
+}
+
+#else	/* !CONFIG_PERFCTR_VIRTUAL */
+
+static inline void perfctr_copy_thread(struct thread_struct *t) { }
+static inline void perfctr_exit_thread(struct thread_struct *t) { }
+static inline void perfctr_suspend_thread(struct thread_struct *t) { }
+static inline void perfctr_resume_thread(struct thread_struct *t) { }
+static inline void perfctr_sample_thread(struct thread_struct *t) { }
+static inline void perfctr_set_cpus_allowed(struct task_struct *p, cpumask_t m) { }
+
+#endif	/* CONFIG_PERFCTR_VIRTUAL */
+
+#endif	/* __KERNEL__ */
+
+#endif	/* _LINUX_PERFCTR_H */
diff -ruN linux-2.6.7-rc1-mm1/kernel/sched.c linux-2.6.7-rc1-mm1.perfctr-2.7.3.core/kernel/sched.c
--- linux-2.6.7-rc1-mm1/kernel/sched.c	2004-05-30 15:59:30.000000000 +0200
+++ linux-2.6.7-rc1-mm1.perfctr-2.7.3.core/kernel/sched.c	2004-05-31 23:43:34.232821000 +0200
@@ -40,6 +40,7 @@
 #include <linux/rcupdate.h>
 #include <linux/cpu.h>
 #include <linux/percpu.h>
+#include <linux/perfctr.h>
 #include <linux/kthread.h>
 #include <linux/seq_file.h>
 #include <linux/times.h>
@@ -3476,6 +3477,8 @@
 	migration_req_t req;
 	runqueue_t *rq;
 
+	perfctr_set_cpus_allowed(p, new_mask);
+
 	rq = task_rq_lock(p, &flags);
 	if (any_online_cpu(new_mask) == NR_CPUS) {
 		ret = -EINVAL;
diff -ruN linux-2.6.7-rc1-mm1/kernel/sys.c linux-2.6.7-rc1-mm1.perfctr-2.7.3.core/kernel/sys.c
--- linux-2.6.7-rc1-mm1/kernel/sys.c	2004-05-30 15:59:30.000000000 +0200
+++ linux-2.6.7-rc1-mm1.perfctr-2.7.3.core/kernel/sys.c	2004-05-31 23:43:34.232821000 +0200
@@ -279,6 +279,12 @@
 cond_syscall(sys_pciconfig_read)
 cond_syscall(sys_pciconfig_write)
 cond_syscall(sys_pciconfig_iobase)
+cond_syscall(sys_perfctr_info)
+cond_syscall(sys_vperfctr_open)
+cond_syscall(sys_vperfctr_control)
+cond_syscall(sys_vperfctr_unlink)
+cond_syscall(sys_vperfctr_iresume)
+cond_syscall(sys_vperfctr_read)
 
 static int set_one_prio(struct task_struct *p, int niceval, int error)
 {
diff -ruN linux-2.6.7-rc1-mm1/kernel/timer.c linux-2.6.7-rc1-mm1.perfctr-2.7.3.core/kernel/timer.c
--- linux-2.6.7-rc1-mm1/kernel/timer.c	2004-05-30 15:59:08.000000000 +0200
+++ linux-2.6.7-rc1-mm1.perfctr-2.7.3.core/kernel/timer.c	2004-05-31 23:43:34.232821000 +0200
@@ -31,6 +31,7 @@
 #include <linux/time.h>
 #include <linux/jiffies.h>
 #include <linux/cpu.h>
+#include <linux/perfctr.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -835,6 +836,7 @@
 	do_process_times(p, user, system);
 	do_it_virt(p, user);
 	do_it_prof(p);
+	perfctr_sample_thread(&p->thread);
 }	
 
 /*
