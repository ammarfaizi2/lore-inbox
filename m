Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbUDHCQo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 22:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbUDHCQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 22:16:44 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:13509 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S261422AbUDHCQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 22:16:01 -0400
Date: Wed, 7 Apr 2004 22:16:15 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Philippe Elie <phil.el@wanadoo.fr>,
       John Levon <levon@movementarian.org>,
       Russell King <rmk@arm.linux.org.uk>,
       Deepak Saxena <dsaxena@plexity.net>,
       "Jiang, Dave" <dave.jiang@intel.com>,
       "Khanna, Mohitx" <mohitx.khanna@intel.com>
Subject: [PATCH][2.6] Oprofile, ARM/XScale PMU driver
Message-ID: <Pine.LNX.4.58.0404072203350.16677@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch adds support for the XScale performance monitoring
unit to OProfile. It uses not only the performance monitoring counters,
but also the clock cycle counter (CCNT) allowing for upto 5 usable
counters.

The code has been developed and tested on an IOP331 (hardware courtesy of
Intel) therefore i haven't been able to test it on XScale PMU1 systems.
Testing on said systems would be appreciated, and if done, please uncomment the
#define DEBUG line at the top of op_model_xscale.c

OProfile userspace support has already been committed and should be
available via CVS.

Dave, Mohit, i'll send you a tarball of what i have against the -iop tree
in a seperate email.

Andrew, please consider for inclusion.

Index: linux-2.6.5/arch/arm/oprofile/Makefile
===================================================================
RCS file: /home/cvsroot/linux-2.6.5/arch/arm/oprofile/Makefile,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 Makefile
--- linux-2.6.5/arch/arm/oprofile/Makefile	4 Apr 2004 21:27:51 -0000	1.1.1.1
+++ linux-2.6.5/arch/arm/oprofile/Makefile	8 Apr 2004 01:46:24 -0000
@@ -7,3 +7,5 @@ DRIVER_OBJS = $(addprefix ../../../drive
 		timer_int.o )

 oprofile-y				:= $(DRIVER_OBJS) init.o
+oprofile-$(CONFIG_CPU_XSCALE)		+= common.o op_model_xscale.o
+
Index: linux-2.6.5/arch/arm/oprofile/common.c
===================================================================
RCS file: linux-2.6.5/arch/arm/oprofile/common.c
diff -N linux-2.6.5/arch/arm/oprofile/common.c
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ linux-2.6.5/arch/arm/oprofile/common.c	8 Apr 2004 01:46:19 -0000
@@ -0,0 +1,138 @@
+/**
+ * @file common.c
+ *
+ * @remark Copyright 2004 Oprofile Authors
+ * @remark Read the file COPYING
+ *
+ * @author Zwane Mwaikambo
+ */
+
+#include <linux/init.h>
+#include <linux/oprofile.h>
+#include <linux/errno.h>
+#include <asm/semaphore.h>
+
+#include "op_counter.h"
+#include "op_arm_model.h"
+
+static struct op_arm_model_spec *pmu_model;
+static int pmu_enabled;
+static struct semaphore pmu_sem;
+
+static int pmu_start(void);
+static int pmu_setup(void);
+static void pmu_stop(void);
+static int pmu_create_files(struct super_block *, struct dentry *);
+
+static struct oprofile_operations pmu_ops = {
+	.create_files	= pmu_create_files,
+	.setup		= pmu_setup,
+	.shutdown	= pmu_stop,
+	.start		= pmu_start,
+	.stop		= pmu_stop,
+};
+
+#ifdef CONFIG_PM
+static struct sys_device device_oprofile = {
+	.id		= 0,
+	.cls		= &oprofile_sysclass,
+};
+
+static int __init init_driverfs(void)
+{
+	int ret;
+
+	if (!(ret = sysdev_class_register(&oprofile_sysclass)))
+		ret = sys_device_register(&device_oprofile);
+
+	return ret;
+}
+
+static void __exit exit_driverfs(void)
+{
+	sys_device_unregister(&device_oprofile);
+	sysdev_class_unregister(&oprofile_sysclass);
+}
+#else
+#define init_driverfs()	do { } while (0)
+#define exit_driverfs() do { } while (0)
+#endif /* CONFIG_PM */
+
+struct op_counter_config counter_config[OP_MAX_COUNTER];
+
+static int pmu_create_files(struct super_block *sb, struct dentry *root)
+{
+	unsigned int i;
+
+	for (i = 0; i < pmu_model->num_counters; i++) {
+		struct dentry *dir;
+		char buf[2];
+
+		snprintf(buf, sizeof buf, "%d", i);
+		dir = oprofilefs_mkdir(sb, root, buf);
+		oprofilefs_create_ulong(sb, dir, "enabled", &counter_config[i].enabled);
+		oprofilefs_create_ulong(sb, dir, "event", &counter_config[i].event);
+		oprofilefs_create_ulong(sb, dir, "count", &counter_config[i].count);
+		oprofilefs_create_ulong(sb, dir, "unit_mask", &counter_config[i].unit_mask);
+		oprofilefs_create_ulong(sb, dir, "kernel", &counter_config[i].kernel);
+		oprofilefs_create_ulong(sb, dir, "user", &counter_config[i].user);
+	}
+
+	return 0;
+}
+
+static int pmu_setup(void)
+{
+	int ret;
+
+	spin_lock(&oprofilefs_lock);
+	ret = pmu_model->setup_ctrs();
+	spin_unlock(&oprofilefs_lock);
+	return ret;
+}
+
+static int pmu_start(void)
+{
+	int ret = -EBUSY;
+
+	down(&pmu_sem);
+	if (!pmu_enabled) {
+		ret = pmu_model->start();
+		pmu_enabled = !ret;
+	}
+	up(&pmu_sem);
+	return ret;
+}
+
+static void pmu_stop(void)
+{
+	down(&pmu_sem);
+	if (pmu_enabled)
+		pmu_model->stop();
+	pmu_enabled = 0;
+	up(&pmu_sem);
+}
+
+int __init pmu_init(struct oprofile_operations **ops, struct op_arm_model_spec *spec)
+{
+	init_MUTEX(&pmu_sem);
+
+	if (spec->init() < 0)
+		return -ENODEV;
+
+	pmu_model = spec;
+	init_driverfs();
+	*ops = &pmu_ops;
+	pmu_ops.cpu_type = pmu_model->name;
+	printk(KERN_INFO "oprofile: using %s PMU\n", spec->name);
+	return 0;
+}
+
+void pmu_exit(void)
+{
+	if (pmu_model) {
+		exit_driverfs();
+		pmu_model = NULL;
+	}
+}
+
Index: linux-2.6.5/arch/arm/oprofile/init.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.5/arch/arm/oprofile/init.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 init.c
--- linux-2.6.5/arch/arm/oprofile/init.c	4 Apr 2004 21:27:51 -0000	1.1.1.1
+++ linux-2.6.5/arch/arm/oprofile/init.c	8 Apr 2004 01:46:19 -0000
@@ -2,6 +2,7 @@
  * @file init.c
  *
  * @remark Copyright 2004 Oprofile Authors
+ * @remark Read the file COPYING
  *
  * @author Zwane Mwaikambo
  */
@@ -9,14 +10,21 @@
 #include <linux/oprofile.h>
 #include <linux/init.h>
 #include <linux/errno.h>
-
-int oprofile_arch_init(struct oprofile_operations **ops)
+#include "op_arm_model.h"
+
+int __init oprofile_arch_init(struct oprofile_operations **ops)
 {
 	int ret = -ENODEV;

+#ifdef CONFIG_CPU_XSCALE
+	ret = pmu_init(ops, &op_xscale_spec);
+#endif
 	return ret;
 }

 void oprofile_arch_exit(void)
 {
+#ifdef CONFIG_CPU_XSCALE
+	pmu_exit();
+#endif
 }
Index: linux-2.6.5/arch/arm/oprofile/op_arm_model.h
===================================================================
RCS file: linux-2.6.5/arch/arm/oprofile/op_arm_model.h
diff -N linux-2.6.5/arch/arm/oprofile/op_arm_model.h
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ linux-2.6.5/arch/arm/oprofile/op_arm_model.h	8 Apr 2004 01:46:21 -0000
@@ -0,0 +1,29 @@
+/**
+ * @file op_arm_model.h
+ * interface to ARM machine specific operations
+ *
+ * @remark Copyright 2004 Oprofile Authors
+ * @remark Read the file COPYING
+ *
+ * @author Zwane Mwaikambo
+ */
+
+#ifndef OP_ARM_MODEL_H
+#define OP_ARM_MODEL_H
+
+struct op_arm_model_spec {
+	int (*init)(void);
+	unsigned int num_counters;
+	int (*setup_ctrs)(void);
+	int (*start)(void);
+	void (*stop)(void);
+	char *name;
+};
+
+#ifdef CONFIG_CPU_XSCALE
+extern struct op_arm_model_spec op_xscale_spec;
+#endif
+
+extern int pmu_init(struct oprofile_operations **ops, struct op_arm_model_spec *spec);
+extern void pmu_exit(void);
+#endif /* OP_ARM_MODEL_H */
Index: linux-2.6.5/arch/arm/oprofile/op_counter.h
===================================================================
RCS file: linux-2.6.5/arch/arm/oprofile/op_counter.h
diff -N linux-2.6.5/arch/arm/oprofile/op_counter.h
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ linux-2.6.5/arch/arm/oprofile/op_counter.h	8 Apr 2004 01:46:21 -0000
@@ -0,0 +1,29 @@
+/**
+ * @file op_counter.h
+ *
+ * @remark Copyright 2004 Oprofile Authors
+ * @remark Read the file COPYING
+ *
+ * @author Zwane Mwaikambo
+ */
+
+#ifndef OP_COUNTER_H
+#define OP_COUNTER_H
+
+#define OP_MAX_COUNTER 5
+
+/* Per performance monitor configuration as set via
+ * oprofilefs.
+ */
+struct op_counter_config {
+	unsigned long count;
+	unsigned long enabled;
+	unsigned long event;
+	unsigned long unit_mask;
+	unsigned long kernel;
+	unsigned long user;
+};
+
+extern struct op_counter_config counter_config[];
+
+#endif /* OP_COUNTER_H */
Index: linux-2.6.5/arch/arm/oprofile/op_model_xscale.c
===================================================================
RCS file: linux-2.6.5/arch/arm/oprofile/op_model_xscale.c
diff -N linux-2.6.5/arch/arm/oprofile/op_model_xscale.c
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ linux-2.6.5/arch/arm/oprofile/op_model_xscale.c	8 Apr 2004 01:46:19 -0000
@@ -0,0 +1,432 @@
+/**
+ * @file op_model_xscale.c
+ * XScale Performance Monitor Driver
+ *
+ * @remark Copyright 2000-2004 Deepak Saxena <dsaxena@mvista.com>
+ * @remark Copyright 2000-2004 MontaVista Software Inc
+ * @remark Copyright 2004 Dave Jiang <dave.jiang@intel.com>
+ * @remark Copyright 2004 Intel Corporation
+ * @remark Copyright 2004 Zwane Mwaikambo <zwane@arm.linux.org.uk>
+ * @remark Copyright 2004 Oprofile Authors
+ *
+ * @remark Read the file COPYING
+ *
+ * @author Zwane Mwaikambo
+ */
+
+/* #define DEBUG */
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <linux/oprofile.h>
+#include <linux/interrupt.h>
+#include <asm/arch/irqs.h>
+
+#include "op_counter.h"
+#include "op_arm_model.h"
+
+#define	PMU_ENABLE	0x001	/* Enable counters */
+#define PMN_RESET	0x002	/* Reset event counters */
+#define	CCNT_RESET	0x004	/* Reset clock counter */
+#define	PMU_RESET	(CCNT_RESET | PMN_RESET)
+
+/* TODO do runtime detection */
+#ifdef CONFIG_ARCH_IOP310
+#define XSCALE_PMU_IRQ  IRQ_XS80200_PMU
+#endif
+#ifdef CONFIG_ARCH_IOP321
+#define XSCALE_PMU_IRQ  IRQ_IOP321_CORE_PMU
+#endif
+#ifdef CONFIG_ARCH_IOP331
+#define XSCALE_PMU_IRQ  IRQ_IOP331_CORE_PMU
+#endif
+
+/*
+ * Different types of events that can be counted by the XScale PMU
+ * as used by Oprofile userspace. Here primarily for documentation
+ * purposes.
+ */
+
+#define EVT_ICACHE_MISS			0x00
+#define	EVT_ICACHE_NO_DELIVER		0x01
+#define	EVT_DATA_STALL			0x02
+#define	EVT_ITLB_MISS			0x03
+#define	EVT_DTLB_MISS			0x04
+#define	EVT_BRANCH			0x05
+#define	EVT_BRANCH_MISS			0x06
+#define	EVT_INSTRUCTION			0x07
+#define	EVT_DCACHE_FULL_STALL		0x08
+#define	EVT_DCACHE_FULL_STALL_CONTIG	0x09
+#define	EVT_DCACHE_ACCESS		0x0A
+#define	EVT_DCACHE_MISS			0x0B
+#define	EVT_DCACE_WRITE_BACK		0x0C
+#define	EVT_PC_CHANGED			0x0D
+#define	EVT_BCU_REQUEST			0x10
+#define	EVT_BCU_FULL			0x11
+#define	EVT_BCU_DRAIN			0x12
+#define	EVT_BCU_ECC_NO_ELOG		0x14
+#define	EVT_BCU_1_BIT_ERR		0x15
+#define	EVT_RMW				0x16
+/* EVT_CCNT is not hardware defined */
+#define EVT_CCNT			0xFE
+#define EVT_UNUSED			0xFF
+
+struct pmu_counter {
+	volatile unsigned long ovf;
+	unsigned long reset_counter;
+};
+
+enum { CCNT, PMN0, PMN1, PMN2, PMN3, MAX_COUNTERS };
+
+static struct pmu_counter results[MAX_COUNTERS];
+
+/*
+ * There are two versions of the PMU in current XScale processors
+ * with differing register layouts and number of performance counters.
+ * e.g. IOP321 is xsc1 whilst IOP331 is xsc2.
+ * We detect which register layout to use in xscale_detect_pmu()
+ */
+enum { PMU_XSC1, PMU_XSC2 };
+
+struct pmu_type {
+	int id;
+	char *name;
+	int num_counters;
+	unsigned int int_enable;
+	unsigned int cnt_ovf[MAX_COUNTERS];
+	unsigned int int_mask[MAX_COUNTERS];
+};
+
+static struct pmu_type pmu_parms[] = {
+	{
+		.id		= PMU_XSC1,
+		.name		= "arm/xscale1",
+		.num_counters	= 3,
+		.int_mask	= { [PMN0] = 0x10, [PMN1] = 0x20,
+				    [CCNT] = 0x40 },
+		.cnt_ovf	= { [CCNT] = 0x400, [PMN0] = 0x100,
+				    [PMN1] = 0x200},
+	},
+	{
+		.id		= PMU_XSC2,
+		.name		= "arm/xscale2",
+		.num_counters	= 5,
+		.int_mask	= { [CCNT] = 0x01, [PMN0] = 0x02,
+				    [PMN1] = 0x04, [PMN2] = 0x08,
+				    [PMN3] = 0x10 },
+		.cnt_ovf	= { [CCNT] = 0x01, [PMN0] = 0x02,
+				    [PMN1] = 0x04, [PMN2] = 0x08,
+				    [PMN3] = 0x10 },
+	},
+};
+
+static struct pmu_type *pmu;
+
+static void write_pmnc(u32 val)
+{
+	/* upper 4bits and 7, 11 are write-as-0 */
+	val &= 0xffff77f;
+	if (pmu->id == PMU_XSC1)
+		__asm__ __volatile__ ("mcr p14, 0, %0, c0, c0, 0" : : "r" (val));
+	else
+		__asm__ __volatile__ ("mcr p14, 0, %0, c0, c1, 0" : : "r" (val));
+}
+
+static u32 read_pmnc(void)
+{
+	u32 val;
+
+	if (pmu->id == PMU_XSC1)
+		__asm__ __volatile__ ("mrc p14, 0, %0, c0, c0, 0" : "=r" (val));
+	else
+		__asm__ __volatile__ ("mrc p14, 0, %0, c0, c1, 0" : "=r" (val));
+
+	return val;
+}
+
+static u32 __xsc1_read_counter(int counter)
+{
+	u32 val = 0;
+
+	switch (counter) {
+	case CCNT:
+		__asm__ __volatile__ ("mrc p14, 0, %0, c1, c0, 0" : "=r" (val));
+		break;
+	case PMN0:
+		__asm__ __volatile__ ("mrc p14, 0, %0, c2, c0, 0" : "=r" (val));
+		break;
+	case PMN1:
+		__asm__ __volatile__ ("mrc p14, 0, %0, c3, c0, 0" : "=r" (val));
+		break;
+	}
+	return val;
+}
+
+static u32 __xsc2_read_counter(int counter)
+{
+	u32 val = 0;
+
+	switch (counter) {
+	case CCNT:
+		__asm__ __volatile__ ("mrc p14, 0, %0, c1, c1, 0" : "=r" (val));
+		break;
+	case PMN0:
+		__asm__ __volatile__ ("mrc p14, 0, %0, c0, c2, 0" : "=r" (val));
+		break;
+	case PMN1:
+		__asm__ __volatile__ ("mrc p14, 0, %0, c1, c2, 0" : "=r" (val));
+		break;
+	case PMN2:
+		__asm__ __volatile__ ("mrc p14, 0, %0, c2, c2, 0" : "=r" (val));
+		break;
+	case PMN3:
+		__asm__ __volatile__ ("mrc p14, 0, %0, c3, c2, 0" : "=r" (val));
+		break;
+	}
+	return val;
+}
+
+static u32 read_counter(int counter)
+{
+	u32 val;
+
+	if (pmu->id == PMU_XSC1)
+		val = __xsc1_read_counter(counter);
+	else
+		val = __xsc2_read_counter(counter);
+
+	return val;
+}
+
+static void __xsc1_write_counter(int counter, u32 val)
+{
+	switch (counter) {
+	case CCNT:
+		__asm__ __volatile__ ("mcr p14, 0, %0, c1, c0, 0" : : "r" (val));
+		break;
+	case PMN0:
+		__asm__ __volatile__ ("mcr p14, 0, %0, c2, c0, 0" : : "r" (val));
+		break;
+	case PMN1:
+		__asm__ __volatile__ ("mcr p14, 0, %0, c3, c0, 0" : : "r" (val));
+		break;
+	}
+}
+
+static void __xsc2_write_counter(int counter, u32 val)
+{
+	switch (counter) {
+	case CCNT:
+		__asm__ __volatile__ ("mcr p14, 0, %0, c1, c1, 0" : : "r" (val));
+		break;
+	case PMN0:
+		__asm__ __volatile__ ("mcr p14, 0, %0, c0, c2, 0" : : "r" (val));
+		break;
+	case PMN1:
+		__asm__ __volatile__ ("mcr p14, 0, %0, c1, c2, 0" : : "r" (val));
+		break;
+	case PMN2:
+		__asm__ __volatile__ ("mcr p14, 0, %0, c2, c2, 0" : : "r" (val));
+		break;
+	case PMN3:
+		__asm__ __volatile__ ("mcr p14, 0, %0, c3, c2, 0" : : "r" (val));
+		break;
+	}
+}
+
+static void write_counter(int counter, u32 val)
+{
+	if (pmu->id == PMU_XSC1)
+		__xsc1_write_counter(counter, val);
+	else
+		__xsc2_write_counter(counter, val);
+}
+
+static int xscale_setup_ctrs(void)
+{
+	u32 evtsel, pmnc;
+	int i;
+
+	for (i = CCNT; i < MAX_COUNTERS; i++) {
+		if (counter_config[i].event)
+			continue;
+
+		counter_config[i].event = EVT_UNUSED;
+	}
+
+	switch (pmu->id) {
+	case PMU_XSC1:
+		pmnc = (counter_config[PMN1].event << 20) | (counter_config[PMN0].event << 12);
+		pr_debug("xscale_setup_ctrs: pmnc: %#08x\n", pmnc);
+		write_pmnc(pmnc);
+		break;
+
+	case PMU_XSC2:
+		evtsel = counter_config[PMN0].event | (counter_config[PMN1].event << 8) |
+			(counter_config[PMN2].event << 16) | (counter_config[PMN3].event << 24);
+
+		pr_debug("xscale_setup_ctrs: evtsel %#08x\n", evtsel);
+		__asm__ __volatile__ ("mcr p14, 0, %0, c8, c1, 0" : : "r" (evtsel));
+		break;
+	}
+
+	for (i = CCNT; i < MAX_COUNTERS; i++) {
+		if (counter_config[i].event == EVT_UNUSED) {
+			counter_config[i].event = 0;
+			pmu->int_enable &= ~pmu->int_mask[i];
+			continue;
+		}
+
+		results[i].reset_counter = counter_config[i].count;
+		write_counter(i, -(u32)counter_config[i].count);
+		pmu->int_enable |= pmu->int_mask[i];
+		pr_debug("xscale_setup_ctrs: counter%d %#08x from %#08lx\n", i,
+			read_counter(i), counter_config[i].count);
+	}
+
+	return 0;
+}
+
+static void inline __xsc1_check_ctrs(void)
+{
+	int i;
+	u32 pmnc = read_pmnc();
+
+	/* NOTE: there's an A stepping errata that states if an overflow */
+	/*       bit already exists and another occurs, the previous     */
+	/*       Overflow bit gets cleared. There's no workaround.	 */
+	/*	 Fixed in B stepping or later			 	 */
+
+	pmnc &= ~(PMU_ENABLE | pmu->cnt_ovf[PMN0] | pmu->cnt_ovf[PMN1] |
+		pmu->cnt_ovf[CCNT]);
+	write_pmnc(pmnc);
+
+	for (i = CCNT; i <= PMN1; i++) {
+		if (!(pmu->int_mask[i] & pmu->int_enable))
+			continue;
+
+		if (pmnc & pmu->cnt_ovf[i])
+			results[i].ovf++;
+	}
+}
+
+static void inline __xsc2_check_ctrs(void)
+{
+	int i;
+	u32 flag = 0, pmnc = read_pmnc();
+
+	pmnc &= ~PMU_ENABLE;
+	write_pmnc(pmnc);
+
+	/* read overflow flag register */
+	__asm__ __volatile__ ("mrc p14, 0, %0, c5, c1, 0" : "=r" (flag));
+
+	for (i = CCNT; i <= PMN3; i++) {
+		if (!(pmu->int_mask[i] & pmu->int_enable))
+			continue;
+
+		if (flag & pmu->cnt_ovf[i])
+			results[i].ovf++;
+	}
+
+	/* writeback clears overflow bits */
+	__asm__ __volatile__ ("mcr p14, 0, %0, c5, c1, 0" : : "r" (flag));
+}
+
+static irqreturn_t xscale_pmu_interrupt(int irq, void *arg, struct pt_regs *regs)
+{
+	unsigned long eip = instruction_pointer(regs);
+	int i, is_kernel = !user_mode(regs);
+	u32 pmnc;
+
+	if (pmu->id == PMU_XSC1)
+		__xsc1_check_ctrs();
+	else
+		__xsc2_check_ctrs();
+
+	for (i = CCNT; i < MAX_COUNTERS; i++) {
+		if (!results[i].ovf)
+			continue;
+
+		write_counter(i, -(u32)results[i].reset_counter);
+		oprofile_add_sample(eip, is_kernel, i, smp_processor_id());
+		results[i].ovf--;
+	}
+
+	pmnc = read_pmnc() | PMU_ENABLE;
+	write_pmnc(pmnc);
+
+	return IRQ_HANDLED;
+}
+
+static void xscale_pmu_stop(void)
+{
+	u32 pmnc = read_pmnc();
+
+	pmnc &= ~PMU_ENABLE;
+	write_pmnc(pmnc);
+
+	free_irq(XSCALE_PMU_IRQ, results);
+}
+
+static int xscale_pmu_start(void)
+{
+	int ret;
+	u32 pmnc = read_pmnc();
+
+	ret = request_irq(XSCALE_PMU_IRQ, xscale_pmu_interrupt, SA_INTERRUPT,
+			"XScale PMU", (void *)results);
+
+	if (ret < 0) {
+		printk(KERN_ERR "oprofile: unable to request IRQ%d for XScale PMU\n",
+			XSCALE_PMU_IRQ);
+		return ret;
+	}
+
+	if (pmu->id == PMU_XSC1)
+		pmnc |= pmu->int_enable;
+	else
+		__asm__ __volatile__ ("mcr p14, 0, %0, c4, c1, 0" : : "r" (pmu->int_enable));
+
+	pmnc |= PMU_ENABLE;
+	write_pmnc(pmnc);
+	pr_debug("xscale_pmu_start: pmnc: %#08x mask: %08x\n", pmnc, pmu->int_enable);
+	return 0;
+}
+
+static int xscale_detect_pmu(void)
+{
+	int ret = 0;
+	u32 id;
+
+	__asm__ __volatile__ ("mrc p15, 0, %0, c0, c0, 0" : "=r" (id));
+	id = (id >> 13) & 0x7;
+
+	switch (id) {
+	case 1:
+		pmu = &pmu_parms[PMU_XSC1];
+		break;
+	case 2:
+		pmu = &pmu_parms[PMU_XSC2];
+		break;
+	default:
+		ret = -ENODEV;
+		break;
+	}
+
+	if (!ret) {
+		op_xscale_spec.name = pmu->name;
+		op_xscale_spec.num_counters = pmu->num_counters;
+		pr_debug("xscale_detect_pmu: detected %s PMU\n", pmu->name);
+	}
+
+	return ret;
+}
+
+struct op_arm_model_spec op_xscale_spec = {
+	.init		= xscale_detect_pmu,
+	.setup_ctrs	= xscale_setup_ctrs,
+	.start		= xscale_pmu_start,
+	.stop		= xscale_pmu_stop,
+};
+
