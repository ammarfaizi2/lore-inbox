Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265474AbSJXOyT>; Thu, 24 Oct 2002 10:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265477AbSJXOyT>; Thu, 24 Oct 2002 10:54:19 -0400
Received: from kim.it.uu.se ([130.238.12.178]:6082 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S265474AbSJXOyF>;
	Thu, 24 Oct 2002 10:54:05 -0400
Date: Thu, 24 Oct 2002 17:00:16 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200210241500.RAA03579@kim.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] x86 performance counters driver 3.0-pre2 for 2.5.44: [1/4] core files
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is perfctr-3.0-pre2 for 2.5.44. This is the 2.5-ready version
of the Linux/x86 performance-monitoring counters kernel extension.
Please consider it for inclusion in 2.5/2.6.

This is part 1 of 4: adding core files. The kernel will still compile
with this patch set applied.

/Mikael

 drivers/perfctr/Config.help |   30 +++++++++
 drivers/perfctr/Config.in   |   13 ++++
 drivers/perfctr/Makefile    |   29 ++++++++
 drivers/perfctr/compat.h    |   35 ++++++++++
 drivers/perfctr/init.c      |   68 +++++++++++++++++++++
 include/linux/perfctr.h     |  142 ++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 317 insertions(+)

diff -ruN linux-2.5.44/drivers/perfctr/Config.help linux-2.5.44.perfctr-3.0-pre2/drivers/perfctr/Config.help
--- linux-2.5.44/drivers/perfctr/Config.help	Thu Jan  1 01:00:00 1970
+++ linux-2.5.44.perfctr-3.0-pre2/drivers/perfctr/Config.help	Fri Oct 11 10:47:05 2002
@@ -0,0 +1,30 @@
+CONFIG_PERFCTR
+  This driver provides access to the performance-monitoring counter
+  registers available in some (but not all) modern processors.
+  These special-purpose registers can be programmed to count low-level
+  performance-related events which occur during program execution,
+  such as cache misses, pipeline stalls, etc.
+
+  The driver supports most x86-class processors known to have
+  performance-monitoring counters: Intel Pentium to Pentium 4,
+  AMD K7, Cyrix 6x86MX/MII/III, VIA C3, and WinChip C6/2/3.
+
+  On processors which have a time-stamp counter but no performance-
+  monitoring counters, such as the AMD K6 family, the driver supports
+  plain cycle-count performance measurements only.
+
+  On WinChip C6/2/3 processors the performance-monitoring counters
+  cannot be used unless the time-stamp counter has been disabled.
+  Please read <file:drivers/perfctr/x86.c> for further information.
+
+  You can safely say Y here, even if you intend to run the kernel
+  on a processor without performance-monitoring counters.
+
+CONFIG_PERFCTR_VIRTUAL
+  The processor's performance-monitoring counters are special-purpose
+  global registers. This option adds support for virtual per-process
+  performance-monitoring counters which only run when the process
+  to which they belong is executing. This improves the accuracy of
+  performance measurements by reducing "noise" from other processes.
+
+  Say Y.
diff -ruN linux-2.5.44/drivers/perfctr/Config.in linux-2.5.44.perfctr-3.0-pre2/drivers/perfctr/Config.in
--- linux-2.5.44/drivers/perfctr/Config.in	Thu Jan  1 01:00:00 1970
+++ linux-2.5.44.perfctr-3.0-pre2/drivers/perfctr/Config.in	Thu Oct 24 12:00:34 2002
@@ -0,0 +1,13 @@
+# $Id: Config.in,v 1.11 2002/10/11 08:47:05 mikpe Exp $
+# Performance-monitoring counters driver configuration
+#
+
+if [ "$CONFIG_PREEMPT" != "y" ]; then
+   mainmenu_option next_comment
+   comment 'Performance-monitoring counters support'
+   bool 'Performance-monitoring counters support' CONFIG_PERFCTR
+   if [ "$CONFIG_PERFCTR" != "n" ]; then
+      bool '  Virtual performance counters support' CONFIG_PERFCTR_VIRTUAL $CONFIG_PERFCTR
+   fi
+   endmenu
+fi
diff -ruN linux-2.5.44/drivers/perfctr/Makefile linux-2.5.44.perfctr-3.0-pre2/drivers/perfctr/Makefile
--- linux-2.5.44/drivers/perfctr/Makefile	Thu Jan  1 01:00:00 1970
+++ linux-2.5.44.perfctr-3.0-pre2/drivers/perfctr/Makefile	Fri Oct 11 10:47:05 2002
@@ -0,0 +1,29 @@
+# $Id: Makefile,v 1.9 2002/10/11 08:47:05 mikpe Exp $
+# Makefile for the Performance-monitoring counters driver.
+
+ifeq ($(VERSION).$(PATCHLEVEL),2.4)
+compat := y
+else
+compat := n
+endif
+
+compat-objs-y :=
+perfctr-objs-y := init.o
+
+compat-objs-$(CONFIG_X86) += x86_compat.o
+perfctr-objs-$(CONFIG_X86) += x86.o
+
+compat-objs-$(CONFIG_PERFCTR_VIRTUAL) += virtual_compat.o
+perfctr-objs-$(CONFIG_PERFCTR_VIRTUAL) += virtual.o
+
+perfctr-objs-$(compat) += $(compat-objs-y)
+
+perfctr-objs		:= $(perfctr-objs-y)
+obj-$(CONFIG_PERFCTR)	:= perfctr.o
+
+ifeq ($(VERSION).$(PATCHLEVEL),2.4)
+O_TARGET		:= perfctr.o
+obj-y			:= $(perfctr-objs)
+endif
+
+include $(TOPDIR)/Rules.make
diff -ruN linux-2.5.44/drivers/perfctr/compat.h linux-2.5.44.perfctr-3.0-pre2/drivers/perfctr/compat.h
--- linux-2.5.44/drivers/perfctr/compat.h	Thu Jan  1 01:00:00 1970
+++ linux-2.5.44.perfctr-3.0-pre2/drivers/perfctr/compat.h	Wed Oct 23 21:38:10 2002
@@ -0,0 +1,35 @@
+/* $Id: compat.h,v 1.27 2002/10/11 08:47:05 mikpe Exp $
+ * Performance-monitoring counters driver.
+ * Compatibility definitions for 2.4/2.5 kernels.
+ *
+ * Copyright (C) 1999-2002  Mikael Pettersson
+ */
+#include <linux/fs.h>
+#include <linux/version.h>
+
+#if defined(CONFIG_X86) && LINUX_VERSION_CODE < KERNEL_VERSION(2,4,11) && !defined(cpu_relax)
+#define cpu_relax()		rep_nop()
+#endif
+
+/* PROC_I() was introduced in 2.5.4 */
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,4)
+#include <linux/proc_fs.h>
+#else /* for 2.4 only, not 2.2 */
+#define PROC_I(inode) (&(inode)->u.proc_i)
+#endif
+
+/* remap_page_range() changed in 2.5.3-pre1 */
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,3)
+#include <linux/mm.h>
+static inline int perfctr_remap_page_range(struct vm_area_struct *vma, unsigned long from, unsigned long to, unsigned long size, pgprot_t prot)
+{
+	return remap_page_range(from, to, size, prot);
+}
+#undef remap_page_range
+#define remap_page_range(vma,from,to,size,prot) perfctr_remap_page_range((vma),(from),(to),(size),(prot))
+#endif
+
+/* put_task_struct() was introduced in 2.5.4 */
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,4)
+#define put_task_struct(tsk)	free_task_struct((tsk))
+#endif
diff -ruN linux-2.5.44/drivers/perfctr/init.c linux-2.5.44.perfctr-3.0-pre2/drivers/perfctr/init.c
--- linux-2.5.44/drivers/perfctr/init.c	Thu Jan  1 01:00:00 1970
+++ linux-2.5.44.perfctr-3.0-pre2/drivers/perfctr/init.c	Thu Oct 24 11:56:07 2002
@@ -0,0 +1,68 @@
+/* $Id: init.c,v 1.42 2002/10/20 21:53:01 mikpe Exp $
+ * Performance-monitoring counters driver.
+ * Top-level initialisation code.
+ *
+ * Copyright (C) 1999-2002  Mikael Pettersson
+ */
+#include <linux/config.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/perfctr.h>
+
+#include <asm/uaccess.h>
+
+#include "compat.h"
+#include "virtual.h"
+
+#define VERSION "3.0-pre2"
+
+struct perfctr_info perfctr_info = {
+	.version = VERSION
+};
+
+static inline int sys_perfctr_info(struct perfctr_info *argp)
+{
+	if( copy_to_user(argp, &perfctr_info, sizeof perfctr_info) )
+		return -EFAULT;
+	return 0;
+}
+
+static int init_done;
+
+asmlinkage int sys_perfctr(unsigned int cmd, int whom, void *arg)
+{
+	if( !init_done )
+		return -ENODEV;
+	if( cmd == PERFCTR_INFO )
+		return sys_perfctr_info((struct perfctr_info*)arg);
+	if( cmd <= VPERFCTR_CREAT )
+		return sys_vperfctr(cmd, whom, arg);
+	return -EINVAL;
+}
+
+int __init perfctr_init(void)
+{
+	int err;
+	if( (err = perfctr_cpu_init()) != 0 ) {
+		printk(KERN_INFO "perfctr: not supported by this processor\n");
+		return err;
+	}
+	if( (err = vperfctr_init()) != 0 )
+		return err;
+	printk(KERN_INFO "perfctr: driver %s, cpu type %s at %lu kHz\n",
+	       perfctr_info.version,
+	       perfctr_cpu_name[perfctr_info.cpu_type],
+	       perfctr_info.cpu_khz);
+	init_done = 1;
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
diff -ruN linux-2.5.44/include/linux/perfctr.h linux-2.5.44.perfctr-3.0-pre2/include/linux/perfctr.h
--- linux-2.5.44/include/linux/perfctr.h	Thu Jan  1 01:00:00 1970
+++ linux-2.5.44.perfctr-3.0-pre2/include/linux/perfctr.h	Wed Oct 23 21:34:59 2002
@@ -0,0 +1,142 @@
+/* $Id: perfctr.h,v 1.36 2002/10/20 21:51:06 mikpe Exp $
+ * Performance-Monitoring Counters driver
+ *
+ * Copyright (C) 1999-2002  Mikael Pettersson
+ */
+#ifndef _LINUX_PERFCTR_H
+#define _LINUX_PERFCTR_H
+
+#include <asm/perfctr.h>
+
+struct perfctr_info {
+	char version[32];
+	unsigned char nrcpus;
+	unsigned char cpu_type;
+	unsigned char cpu_features;
+	unsigned long cpu_khz;
+};
+
+/* cpu_type values */
+#define PERFCTR_X86_GENERIC	0	/* any x86 with rdtsc */
+#define PERFCTR_X86_INTEL_P5	1	/* no rdpmc */
+#define PERFCTR_X86_INTEL_P5MMX	2
+#define PERFCTR_X86_INTEL_P6	3
+#define PERFCTR_X86_INTEL_PII	4
+#define PERFCTR_X86_INTEL_PIII	5
+#define PERFCTR_X86_CYRIX_MII	6
+#define PERFCTR_X86_WINCHIP_C6	7	/* no rdtsc */
+#define PERFCTR_X86_WINCHIP_2	8	/* no rdtsc */
+#define PERFCTR_X86_AMD_K7	9
+#define PERFCTR_X86_VIA_C3	10	/* no pmc0 */
+#define PERFCTR_X86_INTEL_P4	11	/* model 0 and 1 */
+#define PERFCTR_X86_INTEL_P4M2	12	/* model 2 and above */
+
+/* cpu_features flag bits */
+#define PERFCTR_FEATURE_RDPMC	0x01
+#define PERFCTR_FEATURE_RDTSC	0x02
+#define PERFCTR_FEATURE_PCINT	0x04
+
+/* user's view of mmap:ed virtual perfctr */
+struct vperfctr_state {
+	unsigned int magic;
+	int si_signo;
+	struct perfctr_cpu_state cpu_state;
+};
+
+/* `struct vperfctr_state' binary layout version number */
+#define VPERFCTR_STATE_MAGIC	0x0201	/* 2.1 */
+#define VPERFCTR_MAGIC	((VPERFCTR_STATE_MAGIC<<16)|PERFCTR_CPU_STATE_MAGIC)
+
+/* parameter in VPERFCTR_CONTROL command */
+struct vperfctr_control {
+	int si_signo;
+	struct perfctr_cpu_control cpu_control;
+	unsigned long preserve;
+};
+
+/*
+ * sys_perfctr(unsigned int cmd, int whom, void *arg)
+ *
+ *	cmd			   whom, arg
+ */
+#define PERFCTR_INFO	 0	/* 0, struct perfctr_info* */
+#define VPERFCTR_SAMPLE	 1	/* fd, NULL */
+#define VPERFCTR_UNLINK	 2	/* fd, NULL */
+#define VPERFCTR_CONTROL 3	/* fd, struct vperfctr_control* */
+#define VPERFCTR_IRESUME 4	/* fd, NULL */
+#define VPERFCTR_OPEN	 5	/* pid, NULL */
+#define VPERFCTR_CREAT	 6	/* pid, NULL */
+
+#ifdef __KERNEL__
+
+extern struct perfctr_info perfctr_info;
+
+/*
+ * Virtual per-process performance-monitoring counters.
+ */
+struct vperfctr;	/* opaque */
+
+#ifdef CONFIG_PERFCTR_VIRTUAL
+
+/* process management operations */
+extern struct vperfctr *__vperfctr_copy(struct vperfctr*);
+extern void __vperfctr_exit(struct vperfctr*);
+extern void __vperfctr_suspend(struct vperfctr*);
+extern void __vperfctr_resume(struct vperfctr*);
+extern void __vperfctr_sample(struct vperfctr*);
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
+	if( perfctr ) {
+		thread->perfctr = NULL;
+		__vperfctr_exit(perfctr);
+	}
+}
+
+static inline void perfctr_suspend_thread(struct thread_struct *prev)
+{
+	struct vperfctr *perfctr;
+	perfctr = prev->perfctr;
+	if( perfctr )
+		__vperfctr_suspend(perfctr);
+}
+
+/* PRE: next is current */
+static inline void perfctr_resume_thread(struct thread_struct *next)
+{
+	struct vperfctr *perfctr;
+	perfctr = next->perfctr;
+	if( perfctr )
+		__vperfctr_resume(perfctr);
+}
+
+static inline void perfctr_sample_thread(struct thread_struct *thread)
+{
+#ifdef CONFIG_SMP
+	struct vperfctr *perfctr;
+	perfctr = thread->perfctr;
+	if( perfctr )
+		__vperfctr_sample(perfctr);
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
+
+#endif	/* CONFIG_PERFCTR_VIRTUAL */
+
+#endif	/* __KERNEL__ */
+
+#endif	/* _LINUX_PERFCTR_H */
