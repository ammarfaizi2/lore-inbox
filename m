Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265054AbSJOWov>; Tue, 15 Oct 2002 18:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265117AbSJOWoO>; Tue, 15 Oct 2002 18:44:14 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:51979 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S265054AbSJOW1w>; Tue, 15 Oct 2002 18:27:52 -0400
Date: Tue, 15 Oct 2002 23:33:39 +0100
From: John Levon <levon@movementarian.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [7/7] oprofile - i386 driver
Message-ID: <20021015223339.GG41906@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *181aFv-000DFg-00*8j9VlogDkLE* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Finally, add the i386 timer-interrupt and perfctr drivers for i386


diff -X dontdiff -Naur linux-linus/arch/i386/Makefile linux-linus2/arch/i386/Makefile
--- linux-linus/arch/i386/Makefile	Sun Oct 13 19:51:03 2002
+++ linux-linus2/arch/i386/Makefile	Tue Oct 15 23:10:31 2002
@@ -57,6 +57,8 @@
 					   arch/i386/$(MACHINE)/
 drivers-$(CONFIG_MATH_EMULATION)	+= arch/i386/math-emu/
 drivers-$(CONFIG_PCI)			+= arch/i386/pci/
+# FIXME: is drivers- right ?
+drivers-$(CONFIG_OPROFILE)		+= arch/i386/oprofile/
 
 CFLAGS += -Iarch/i386/$(MACHINE)
 AFLAGS += -Iarch/i386/$(MACHINE)
diff -X dontdiff -Naur linux-linus/arch/i386/config.in linux-linus2/arch/i386/config.in
--- linux-linus/arch/i386/config.in	Tue Oct 15 22:23:10 2002
+++ linux-linus2/arch/i386/config.in	Tue Oct 15 23:10:51 2002
@@ -442,12 +442,7 @@
 
 source net/bluetooth/Config.in
 
-if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
-   mainmenu_option next_comment
-   comment 'Profiling support'
-   bool 'Profiling support (EXPERIMENTAL)' CONFIG_PROFILING
-   endmenu
-fi
+source arch/i386/oprofile/Config.in
  
 mainmenu_option next_comment
 comment 'Kernel hacking'
diff -X dontdiff -Naur linux-linus/arch/i386/oprofile/Config.help linux-linus2/arch/i386/oprofile/Config.help
--- linux-linus/arch/i386/oprofile/Config.help	Thu Jan  1 01:00:00 1970
+++ linux-linus2/arch/i386/oprofile/Config.help	Tue Oct 15 23:10:31 2002
@@ -0,0 +1,6 @@
+CONFIG_OPROFILE
+  OProfile is a profiling system capable of profiling the
+  whole system, include the kernel, kernel modules, libraries,
+  and applications.
+
+  If unsure, say N.
diff -X dontdiff -Naur linux-linus/arch/i386/oprofile/Config.in linux-linus2/arch/i386/oprofile/Config.in
--- linux-linus/arch/i386/oprofile/Config.in	Thu Jan  1 01:00:00 1970
+++ linux-linus2/arch/i386/oprofile/Config.in	Tue Oct 15 23:10:31 2002
@@ -0,0 +1,9 @@
+if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
+   mainmenu_option next_comment
+   comment 'Profiling support'
+   bool 'Profiling support (EXPERIMENTAL)' CONFIG_PROFILING
+   if [ "$CONFIG_PROFILING" = "y" ]; then
+      tristate '  OProfile system profiling (EXPERIMENTAL)' CONFIG_OPROFILE
+   fi
+   endmenu
+fi
diff -X dontdiff -Naur linux-linus/arch/i386/oprofile/Makefile linux-linus2/arch/i386/oprofile/Makefile
--- linux-linus/arch/i386/oprofile/Makefile	Thu Jan  1 01:00:00 1970
+++ linux-linus2/arch/i386/oprofile/Makefile	Tue Oct 15 23:10:31 2002
@@ -0,0 +1,16 @@
+vpath %.c = . $(TOPDIR)/drivers/oprofile
+
+obj-$(CONFIG_OPROFILE) += oprofile.o
+ 
+DRIVER_OBJS = $(addprefix ../../../drivers/oprofile/, \
+	oprof.o cpu_buffer.o buffer_sync.o \
+	event_buffer.o oprofile_files.o \
+	oprofilefs.o oprofile_stats.o )
+ 
+oprofile-objs := $(DRIVER_OBJS) init.o timer_int.o
+
+ifdef CONFIG_X86_LOCAL_APIC
+oprofile-objs += nmi_int.o op_model_athlon.o op_model_ppro.o
+endif
+ 
+include $(TOPDIR)/Rules.make
diff -X dontdiff -Naur linux-linus/arch/i386/oprofile/init.c linux-linus2/arch/i386/oprofile/init.c
--- linux-linus/arch/i386/oprofile/init.c	Thu Jan  1 01:00:00 1970
+++ linux-linus2/arch/i386/oprofile/init.c	Tue Oct 15 23:10:31 2002
@@ -0,0 +1,30 @@
+/**
+ * @file init.c
+ *
+ * @remark Copyright 2002 OProfile authors
+ * @remark Read the file COPYING
+ *
+ * @author John Levon <levon@movementarian.org>
+ */
+
+#include <linux/kernel.h>
+#include <linux/oprofile.h>
+#include <linux/init.h>
+ 
+/* We support CPUs that have performance counters like the Pentium Pro
+ * with NMI mode samples. Other x86 CPUs use a simple interrupt keyed
+ * off the timer interrupt, which cannot profile interrupts-disabled
+ * code unlike the NMI-based code.
+ */
+ 
+extern int nmi_init(struct oprofile_operations ** ops, enum oprofile_cpu * cpu);
+extern void timer_init(struct oprofile_operations ** ops, enum oprofile_cpu * cpu);
+
+int __init oprofile_arch_init(struct oprofile_operations ** ops, enum oprofile_cpu * cpu)
+{
+#ifdef CONFIG_X86_LOCAL_APIC
+	if (!nmi_init(ops, cpu))
+#endif
+		timer_init(ops, cpu);
+	return 0;
+}
diff -X dontdiff -Naur linux-linus/arch/i386/oprofile/nmi_int.c linux-linus2/arch/i386/oprofile/nmi_int.c
--- linux-linus/arch/i386/oprofile/nmi_int.c	Thu Jan  1 01:00:00 1970
+++ linux-linus2/arch/i386/oprofile/nmi_int.c	Tue Oct 15 23:10:31 2002
@@ -0,0 +1,258 @@
+/**
+ * @file nmi_int.c
+ *
+ * @remark Copyright 2002 OProfile authors
+ * @remark Read the file COPYING
+ *
+ * @author John Levon <levon@movementarian.org>
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/notifier.h>
+#include <linux/smp.h>
+#include <linux/oprofile.h>
+#include <linux/pm.h>
+#include <asm/thread_info.h>
+#include <asm/nmi.h>
+#include <asm/ptrace.h>
+#include <asm/msr.h>
+#include <asm/apic.h>
+#include <asm/bitops.h>
+#include <asm/processor.h>
+ 
+#include "op_counter.h"
+#include "op_x86_model.h"
+ 
+static struct op_x86_model_spec const * model;
+static struct op_msrs cpu_msrs[NR_CPUS];
+static unsigned long saved_lvtpc[NR_CPUS];
+static unsigned long kernel_only;
+ 
+static int nmi_start(void);
+static void nmi_stop(void);
+
+static struct pm_dev * oprofile_pmdev;
+ 
+/* We're at risk of causing big trouble unless we
+ * make sure to not cause any NMI interrupts when
+ * suspended.
+ */
+static int oprofile_pm_callback(struct pm_dev * dev,
+		pm_request_t rqst, void * data)
+{
+	switch (rqst) {
+		case PM_SUSPEND:
+			nmi_stop();
+			break;
+		case PM_RESUME:
+			nmi_start();
+			break;
+	}
+	return 0;
+}
+ 
+ 
+// FIXME: kernel_only
+static int nmi_callback(struct pt_regs * regs, int cpu)
+{
+	return (model->check_ctrs(cpu, &cpu_msrs[cpu], regs));
+}
+ 
+ 
+static void nmi_save_registers(struct op_msrs * msrs)
+{
+	unsigned int const nr_ctrs = model->num_counters;
+	unsigned int const nr_ctrls = model->num_controls; 
+	struct op_msr_group * counters = &msrs->counters;
+	struct op_msr_group * controls = &msrs->controls;
+	int i;
+
+	for (i = 0; i < nr_ctrs; ++i) {
+		rdmsr(counters->addrs[i],
+			counters->saved[i].low,
+			counters->saved[i].high);
+	}
+ 
+	for (i = 0; i < nr_ctrls; ++i) {
+		rdmsr(controls->addrs[i],
+			controls->saved[i].low,
+			controls->saved[i].high);
+	}
+}
+
+ 
+static void nmi_cpu_setup(void * dummy)
+{
+	int cpu = smp_processor_id();
+	struct op_msrs * msrs = &cpu_msrs[cpu];
+	model->fill_in_addresses(msrs);
+	nmi_save_registers(msrs);
+	spin_lock(&oprofilefs_lock);
+	model->setup_ctrs(msrs);
+	spin_unlock(&oprofilefs_lock);
+	saved_lvtpc[cpu] = apic_read(APIC_LVTPC);
+	apic_write(APIC_LVTPC, APIC_DM_NMI);
+}
+ 
+
+static int nmi_setup(void)
+{
+	/* We walk a thin line between law and rape here.
+	 * We need to be careful to install our NMI handler
+	 * without actually triggering any NMIs as this will
+	 * break the core code horrifically.
+	 */
+	smp_call_function(nmi_cpu_setup, NULL, 0, 1);
+	nmi_cpu_setup(0);
+	set_nmi_callback(nmi_callback);
+	oprofile_pmdev = set_nmi_pm_callback(oprofile_pm_callback);
+	return 0;
+}
+
+
+static void nmi_restore_registers(struct op_msrs * msrs)
+{
+	unsigned int const nr_ctrs = model->num_counters;
+	unsigned int const nr_ctrls = model->num_controls; 
+	struct op_msr_group * counters = &msrs->counters;
+	struct op_msr_group * controls = &msrs->controls;
+	int i;
+
+	for (i = 0; i < nr_ctrls; ++i) {
+		wrmsr(controls->addrs[i],
+			controls->saved[i].low,
+			controls->saved[i].high);
+	}
+ 
+	for (i = 0; i < nr_ctrs; ++i) {
+		wrmsr(counters->addrs[i],
+			counters->saved[i].low,
+			counters->saved[i].high);
+	}
+}
+ 
+
+static void nmi_cpu_shutdown(void * dummy)
+{
+	int cpu = smp_processor_id();
+	struct op_msrs * msrs = &cpu_msrs[cpu];
+	apic_write(APIC_LVTPC, saved_lvtpc[cpu]);
+	nmi_restore_registers(msrs);
+}
+
+ 
+static void nmi_shutdown(void)
+{
+	unset_nmi_pm_callback(oprofile_pmdev);
+	unset_nmi_callback();
+	smp_call_function(nmi_cpu_shutdown, NULL, 0, 1);
+	nmi_cpu_shutdown(0);
+}
+
+ 
+static void nmi_cpu_start(void * dummy)
+{
+	struct op_msrs const * msrs = &cpu_msrs[smp_processor_id()];
+	model->start(msrs);
+}
+ 
+
+static int nmi_start(void)
+{
+	smp_call_function(nmi_cpu_start, NULL, 0, 1);
+	nmi_cpu_start(0);
+	return 0;
+}
+ 
+ 
+static void nmi_cpu_stop(void * dummy)
+{
+	struct op_msrs const * msrs = &cpu_msrs[smp_processor_id()];
+	model->stop(msrs);
+}
+ 
+ 
+static void nmi_stop(void)
+{
+	smp_call_function(nmi_cpu_stop, NULL, 0, 1);
+	nmi_cpu_stop(0);
+}
+
+
+struct op_counter_config counter_config[OP_MAX_COUNTER];
+
+static int nmi_create_files(struct super_block * sb, struct dentry * root)
+{
+	int i;
+
+	for (i = 0; i < model->num_counters; ++i) {
+		struct dentry * dir;
+		char buf[2];
+ 
+		snprintf(buf, 2, "%d", i);
+		dir = oprofilefs_mkdir(sb, root, buf);
+		oprofilefs_create_ulong(sb, dir, "enabled", &counter_config[i].enabled); 
+		oprofilefs_create_ulong(sb, dir, "event", &counter_config[i].event); 
+		oprofilefs_create_ulong(sb, dir, "count", &counter_config[i].count); 
+		oprofilefs_create_ulong(sb, dir, "unit_mask", &counter_config[i].unit_mask); 
+		oprofilefs_create_ulong(sb, dir, "kernel", &counter_config[i].kernel); 
+		oprofilefs_create_ulong(sb, dir, "user", &counter_config[i].user); 
+	}
+
+	oprofilefs_create_ulong(sb, root, "kernel_only", &kernel_only);
+	return 0;
+}
+ 
+ 
+struct oprofile_operations nmi_ops = {
+	.create_files 	= nmi_create_files,
+	.setup 		= nmi_setup,
+	.shutdown	= nmi_shutdown,
+	.start		= nmi_start,
+	.stop		= nmi_stop
+};
+ 
+ 
+int __init nmi_init(struct oprofile_operations ** ops, enum oprofile_cpu * cpu)
+{
+	__u8 vendor = current_cpu_data.x86_vendor;
+	__u8 family = current_cpu_data.x86;
+	__u8 cpu_model = current_cpu_data.x86_model;
+ 
+	if (!cpu_has_apic)
+		return 0;
+ 
+	switch (vendor) {
+		case X86_VENDOR_AMD:
+			/* Needs to be at least an Athlon (or hammer in 32bit mode) */
+			if (family < 6)
+				return 0;
+			model = &op_athlon_spec;
+			*cpu = OPROFILE_CPU_ATHLON;
+			break;
+ 
+		case X86_VENDOR_INTEL:
+			/* Less than a P6-class processor */
+			if (family != 6)
+				return 0;
+	 
+			if (cpu_model > 5) {
+				*cpu = OPROFILE_CPU_PIII;
+			} else if (cpu_model > 2) {
+				*cpu = OPROFILE_CPU_PII;
+			} else {
+				*cpu = OPROFILE_CPU_PPRO;
+			}
+ 
+			model = &op_ppro_spec;
+			break;
+
+		default:
+			return 0;
+	}
+
+	*ops = &nmi_ops;
+	printk(KERN_INFO "oprofile: using NMI interrupt.\n");
+	return 1;
+}
diff -X dontdiff -Naur linux-linus/arch/i386/oprofile/op_counter.h linux-linus2/arch/i386/oprofile/op_counter.h
--- linux-linus/arch/i386/oprofile/op_counter.h	Thu Jan  1 01:00:00 1970
+++ linux-linus2/arch/i386/oprofile/op_counter.h	Tue Oct 15 23:10:31 2002
@@ -0,0 +1,29 @@
+/**
+ * @file op_counter.h
+ *
+ * @remark Copyright 2002 OProfile authors
+ * @remark Read the file COPYING
+ *
+ * @author John Levon
+ */
+ 
+#ifndef OP_COUNTER_H
+#define OP_COUNTER_H
+ 
+#define OP_MAX_COUNTER 4
+ 
+/* Per-perfctr configuration as set via
+ * oprofilefs.
+ */
+struct op_counter_config {
+        unsigned long count;
+        unsigned long enabled;
+        unsigned long event;
+        unsigned long kernel;
+        unsigned long user;
+        unsigned long unit_mask;
+};
+
+extern struct op_counter_config counter_config[];
+
+#endif /* OP_COUNTER_H */
diff -X dontdiff -Naur linux-linus/arch/i386/oprofile/op_model_athlon.c linux-linus2/arch/i386/oprofile/op_model_athlon.c
--- linux-linus/arch/i386/oprofile/op_model_athlon.c	Thu Jan  1 01:00:00 1970
+++ linux-linus2/arch/i386/oprofile/op_model_athlon.c	Tue Oct 15 23:10:31 2002
@@ -0,0 +1,149 @@
+/**
+ * @file op_model_athlon.h
+ * athlon / K7 model-specific MSR operations
+ *
+ * @remark Copyright 2002 OProfile authors
+ * @remark Read the file COPYING
+ *
+ * @author John Levon
+ * @author Philippe Elie
+ * @author Graydon Hoare
+ */
+
+#include <linux/oprofile.h>
+#include <asm/ptrace.h>
+#include <asm/msr.h>
+ 
+#include "op_x86_model.h"
+#include "op_counter.h"
+
+#define NUM_COUNTERS 4
+#define NUM_CONTROLS 4
+
+#define CTR_READ(l,h,msrs,c) do {rdmsr(msrs->counters.addrs[(c)], (l), (h));} while (0)
+#define CTR_WRITE(l,msrs,c) do {wrmsr(msrs->counters.addrs[(c)], -(unsigned int)(l), -1);} while (0)
+#define CTR_OVERFLOWED(n) (!((n) & (1U<<31)))
+
+#define CTRL_READ(l,h,msrs,c) do {rdmsr(msrs->controls.addrs[(c)], (l), (h));} while (0)
+#define CTRL_WRITE(l,h,msrs,c) do {wrmsr(msrs->controls.addrs[(c)], (l), (h));} while (0)
+#define CTRL_SET_ACTIVE(n) (n |= (1<<22))
+#define CTRL_SET_INACTIVE(n) (n &= ~(1<<22))
+#define CTRL_CLEAR(x) (x &= (1<<21))
+#define CTRL_SET_ENABLE(val) (val |= 1<<20)
+#define CTRL_SET_USR(val,u) (val |= ((u & 1) << 16))
+#define CTRL_SET_KERN(val,k) (val |= ((k & 1) << 17))
+#define CTRL_SET_UM(val, m) (val |= (m << 8))
+#define CTRL_SET_EVENT(val, e) (val |= e)
+
+static unsigned long reset_value[NUM_COUNTERS];
+ 
+static void athlon_fill_in_addresses(struct op_msrs * const msrs)
+{
+	msrs->counters.addrs[0] = MSR_K7_PERFCTR0;
+	msrs->counters.addrs[1] = MSR_K7_PERFCTR1;
+	msrs->counters.addrs[2] = MSR_K7_PERFCTR2;
+	msrs->counters.addrs[3] = MSR_K7_PERFCTR3;
+
+	msrs->controls.addrs[0] = MSR_K7_EVNTSEL0;
+	msrs->controls.addrs[1] = MSR_K7_EVNTSEL1;
+	msrs->controls.addrs[2] = MSR_K7_EVNTSEL2;
+	msrs->controls.addrs[3] = MSR_K7_EVNTSEL3;
+}
+
+ 
+static void athlon_setup_ctrs(struct op_msrs const * const msrs)
+{
+	unsigned int low, high;
+	int i;
+ 
+	/* clear all counters */
+	for (i = 0 ; i < NUM_CONTROLS; ++i) {
+		CTRL_READ(low, high, msrs, i);
+		CTRL_CLEAR(low);
+		CTRL_WRITE(low, high, msrs, i);
+	}
+	
+	/* avoid a false detection of ctr overflows in NMI handler */
+	for (i = 0; i < NUM_COUNTERS; ++i) {
+		CTR_WRITE(1, msrs, i);
+	}
+
+	/* enable active counters */
+	for (i = 0; i < NUM_COUNTERS; ++i) {
+		if (counter_config[i].event) {
+			reset_value[i] = counter_config[i].count;
+
+			CTR_WRITE(counter_config[i].count, msrs, i);
+
+			CTRL_READ(low, high, msrs, i);
+			CTRL_CLEAR(low);
+			CTRL_SET_ENABLE(low);
+			CTRL_SET_USR(low, counter_config[i].user);
+			CTRL_SET_KERN(low, counter_config[i].kernel);
+			CTRL_SET_UM(low, counter_config[i].unit_mask);
+			CTRL_SET_EVENT(low, counter_config[i].event);
+			CTRL_WRITE(low, high, msrs, i);
+		} else {
+			reset_value[i] = 0;
+		}
+	}
+}
+
+ 
+static int athlon_check_ctrs(unsigned int const cpu, 
+			      struct op_msrs const * const msrs, 
+			      struct pt_regs * const regs)
+{
+	unsigned int low, high;
+	int handled = 0;
+	int i;
+	for (i = 0 ; i < NUM_COUNTERS; ++i) {
+		CTR_READ(low, high, msrs, i);
+		if (CTR_OVERFLOWED(low)) {
+			oprofile_add_sample(regs->eip, i, cpu);
+			CTR_WRITE(reset_value[i], msrs, i);
+			handled = 1;
+		}
+	}
+	return handled;
+}
+
+ 
+static void athlon_start(struct op_msrs const * const msrs)
+{
+	unsigned int low, high;
+	int i;
+	for (i = 0 ; i < NUM_COUNTERS ; ++i) {
+		if (reset_value[i]) {
+			CTRL_READ(low, high, msrs, i);
+			CTRL_SET_ACTIVE(low);
+			CTRL_WRITE(low, high, msrs, i);
+		}
+	}
+}
+
+
+static void athlon_stop(struct op_msrs const * const msrs)
+{
+	unsigned int low,high;
+	int i;
+
+	/* Subtle: stop on all counters to avoid race with
+	 * setting our pm callback */
+	for (i = 0 ; i < NUM_COUNTERS ; ++i) {
+		CTRL_READ(low, high, msrs, i);
+		CTRL_SET_INACTIVE(low);
+		CTRL_WRITE(low, high, msrs, i);
+	}
+}
+
+
+struct op_x86_model_spec const op_athlon_spec = {
+	.num_counters = NUM_COUNTERS,
+	.num_controls = NUM_CONTROLS,
+	.fill_in_addresses = &athlon_fill_in_addresses,
+	.setup_ctrs = &athlon_setup_ctrs,
+	.check_ctrs = &athlon_check_ctrs,
+	.start = &athlon_start,
+	.stop = &athlon_stop
+};
diff -X dontdiff -Naur linux-linus/arch/i386/oprofile/op_model_ppro.c linux-linus2/arch/i386/oprofile/op_model_ppro.c
--- linux-linus/arch/i386/oprofile/op_model_ppro.c	Thu Jan  1 01:00:00 1970
+++ linux-linus2/arch/i386/oprofile/op_model_ppro.c	Tue Oct 15 23:10:31 2002
@@ -0,0 +1,133 @@
+/**
+ * @file op_model_ppro.h
+ * pentium pro / P6 model-specific MSR operations
+ *
+ * @remark Copyright 2002 OProfile authors
+ * @remark Read the file COPYING
+ *
+ * @author John Levon
+ * @author Philippe Elie
+ * @author Graydon Hoare
+ */
+
+#include <linux/oprofile.h>
+#include <asm/ptrace.h>
+#include <asm/msr.h>
+ 
+#include "op_x86_model.h"
+#include "op_counter.h"
+
+#define NUM_COUNTERS 2
+#define NUM_CONTROLS 2
+
+#define CTR_READ(l,h,msrs,c) do {rdmsr(msrs->counters.addrs[(c)], (l), (h));} while (0)
+#define CTR_WRITE(l,msrs,c) do {wrmsr(msrs->counters.addrs[(c)], -(u32)(l), -1);} while (0)
+#define CTR_OVERFLOWED(n) (!((n) & (1U<<31)))
+
+#define CTRL_READ(l,h,msrs,c) do {rdmsr((msrs->controls.addrs[(c)]), (l), (h));} while (0)
+#define CTRL_WRITE(l,h,msrs,c) do {wrmsr((msrs->controls.addrs[(c)]), (l), (h));} while (0)
+#define CTRL_SET_ACTIVE(n) (n |= (1<<22))
+#define CTRL_SET_INACTIVE(n) (n &= ~(1<<22))
+#define CTRL_CLEAR(x) (x &= (1<<21))
+#define CTRL_SET_ENABLE(val) (val |= 1<<20)
+#define CTRL_SET_USR(val,u) (val |= ((u & 1) << 16))
+#define CTRL_SET_KERN(val,k) (val |= ((k & 1) << 17))
+#define CTRL_SET_UM(val, m) (val |= (m << 8))
+#define CTRL_SET_EVENT(val, e) (val |= e)
+
+static unsigned long reset_value[NUM_COUNTERS];
+ 
+static void ppro_fill_in_addresses(struct op_msrs * const msrs)
+{
+	msrs->counters.addrs[0] = MSR_P6_PERFCTR0;
+	msrs->counters.addrs[1] = MSR_P6_PERFCTR1;
+	
+	msrs->controls.addrs[0] = MSR_P6_EVNTSEL0;
+	msrs->controls.addrs[1] = MSR_P6_EVNTSEL1;
+}
+
+
+static void ppro_setup_ctrs(struct op_msrs const * const msrs)
+{
+	unsigned int low, high;
+	int i;
+
+	/* clear all counters */
+	for (i = 0 ; i < NUM_CONTROLS; ++i) {
+		CTRL_READ(low, high, msrs, i);
+		CTRL_CLEAR(low);
+		CTRL_WRITE(low, high, msrs, i);
+	}
+	
+	/* avoid a false detection of ctr overflows in NMI handler */
+	for (i = 0; i < NUM_COUNTERS; ++i) {
+		CTR_WRITE(1, msrs, i);
+	}
+
+	/* enable active counters */
+	for (i = 0; i < NUM_COUNTERS; ++i) {
+		if (counter_config[i].event) {
+			reset_value[i] = counter_config[i].count;
+
+			CTR_WRITE(counter_config[i].count, msrs, i);
+
+			CTRL_READ(low, high, msrs, i);
+			CTRL_CLEAR(low);
+			CTRL_SET_ENABLE(low);
+			CTRL_SET_USR(low, counter_config[i].user);
+			CTRL_SET_KERN(low, counter_config[i].kernel);
+			CTRL_SET_UM(low, counter_config[i].unit_mask);
+			CTRL_SET_EVENT(low, counter_config[i].event);
+			CTRL_WRITE(low, high, msrs, i);
+		}
+	}
+}
+
+ 
+static int ppro_check_ctrs(unsigned int const cpu, 
+			    struct op_msrs const * const msrs,
+			    struct pt_regs * const regs)
+{
+	unsigned int low, high;
+	int i;
+	int handled = 0;
+ 
+	for (i = 0 ; i < NUM_COUNTERS; ++i) {
+		CTR_READ(low, high, msrs, i);
+		if (CTR_OVERFLOWED(low)) {
+			oprofile_add_sample(regs->eip, i, cpu);
+			CTR_WRITE(reset_value[i], msrs, i);
+			handled = 1;
+		}
+	}
+	return handled;
+}
+
+ 
+static void ppro_start(struct op_msrs const * const msrs)
+{
+	unsigned int low,high;
+	CTRL_READ(low, high, msrs, 0);
+	CTRL_SET_ACTIVE(low);
+	CTRL_WRITE(low, high, msrs, 0);
+}
+
+
+static void ppro_stop(struct op_msrs const * const msrs)
+{
+	unsigned int low,high;
+	CTRL_READ(low, high, msrs, 0);
+	CTRL_SET_INACTIVE(low);
+	CTRL_WRITE(low, high, msrs, 0);
+}
+
+
+struct op_x86_model_spec const op_ppro_spec = {
+	.num_counters = NUM_COUNTERS,
+	.num_controls = NUM_CONTROLS,
+	.fill_in_addresses = &ppro_fill_in_addresses,
+	.setup_ctrs = &ppro_setup_ctrs,
+	.check_ctrs = &ppro_check_ctrs,
+	.start = &ppro_start,
+	.stop = &ppro_stop
+};
diff -X dontdiff -Naur linux-linus/arch/i386/oprofile/op_x86_model.h linux-linus2/arch/i386/oprofile/op_x86_model.h
--- linux-linus/arch/i386/oprofile/op_x86_model.h	Thu Jan  1 01:00:00 1970
+++ linux-linus2/arch/i386/oprofile/op_x86_model.h	Tue Oct 15 23:10:31 2002
@@ -0,0 +1,52 @@
+/**
+ * @file op_x86_model.h
+ * interface to x86 model-specific MSR operations
+ *
+ * @remark Copyright 2002 OProfile authors
+ * @remark Read the file COPYING
+ *
+ * @author Graydon Hoare
+ */
+
+#ifndef OP_X86_MODEL_H
+#define OP_X86_MODEL_H
+
+/* will need re-working for Pentium IV */
+#define MAX_MSR 4
+ 
+struct op_saved_msr {
+	unsigned int high;
+	unsigned int low;
+};
+
+struct op_msr_group {
+	unsigned int addrs[MAX_MSR];
+	struct op_saved_msr saved[MAX_MSR];
+};
+
+struct op_msrs {
+	struct op_msr_group counters;
+	struct op_msr_group controls;
+};
+
+struct pt_regs;
+
+/* The model vtable abstracts the differences between
+ * various x86 CPU model's perfctr support.
+ */
+struct op_x86_model_spec {
+	unsigned int const num_counters;
+	unsigned int const num_controls;
+	void (*fill_in_addresses)(struct op_msrs * const msrs);
+	void (*setup_ctrs)(struct op_msrs const * const msrs);
+	int (*check_ctrs)(unsigned int const cpu, 
+		struct op_msrs const * const msrs,
+		struct pt_regs * const regs);
+	void (*start)(struct op_msrs const * const msrs);
+	void (*stop)(struct op_msrs const * const msrs);
+};
+
+extern struct op_x86_model_spec const op_ppro_spec;
+extern struct op_x86_model_spec const op_athlon_spec;
+
+#endif /* OP_X86_MODEL_H */
diff -X dontdiff -Naur linux-linus/arch/i386/oprofile/timer_int.c linux-linus2/arch/i386/oprofile/timer_int.c
--- linux-linus/arch/i386/oprofile/timer_int.c	Thu Jan  1 01:00:00 1970
+++ linux-linus2/arch/i386/oprofile/timer_int.c	Tue Oct 15 23:10:31 2002
@@ -0,0 +1,57 @@
+/**
+ * @file timer_int.c
+ *
+ * @remark Copyright 2002 OProfile authors
+ * @remark Read the file COPYING
+ *
+ * @author John Levon <levon@movementarian.org>
+ */
+
+#include <linux/kernel.h>
+#include <linux/notifier.h>
+#include <linux/smp.h>
+#include <linux/irq.h>
+#include <linux/oprofile.h>
+#include <asm/ptrace.h>
+ 
+#include "op_counter.h"
+ 
+static int timer_notify(struct notifier_block * self, unsigned long val, void * data)
+{
+	struct pt_regs * regs = (struct pt_regs *)data;
+	int cpu = smp_processor_id();
+ 
+	oprofile_add_sample(regs->eip, 0, cpu);
+	return 0;
+}
+ 
+ 
+static struct notifier_block timer_notifier = {
+	.notifier_call	= timer_notify,
+};
+ 
+
+static int timer_start(void)
+{
+	return register_profile_notifier(&timer_notifier);
+}
+
+
+static void timer_stop(void)
+{
+	unregister_profile_notifier(&timer_notifier);
+}
+
+
+static struct oprofile_operations timer_ops = {
+	.start	= timer_start,
+	.stop	= timer_stop
+};
+
+ 
+void __init timer_init(struct oprofile_operations ** ops, enum oprofile_cpu * cpu)
+{
+	*ops = &timer_ops;
+	*cpu = OPROFILE_CPU_TIMER;
+	printk(KERN_INFO "oprofile: using timer interrupt.\n");
+}
