Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030873AbWKOSvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030873AbWKOSvs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 13:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030872AbWKOSvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 13:51:48 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:53151 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030874AbWKOSvq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 13:51:46 -0500
Message-ID: <455B619C.7040904@us.ibm.com>
Date: Wed, 15 Nov 2006 12:51:08 -0600
From: Maynard Johnson <maynardj@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [RFC, Patch 1/1] OProfile for Cell: Initial profiling support --
 new patch
Content-Type: multipart/mixed;
 boundary="------------030207080505090400090808"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030207080505090400090808
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------030207080505090400090808
Content-Type: text/plain;
 name="oprof-ppu.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oprof-ppu.diff"

Index: linux-2.6.18/arch/powerpc/configs/cell_defconfig
===================================================================
--- linux-2.6.18.orig/arch/powerpc/configs/cell_defconfig	2006-11-15 10:44:42.880315592 -0600
+++ linux-2.6.18/arch/powerpc/configs/cell_defconfig	2006-11-15 10:45:30.735227560 -0600
@@ -1099,7 +1099,8 @@
 #
 # Instrumentation Support
 #
-# CONFIG_PROFILING is not set
+CONFIG_PROFILING=y
+CONFIG_OPROFILE=y
 # CONFIG_KPROBES is not set
 
 #
Index: linux-2.6.18/arch/powerpc/kernel/cputable.c
===================================================================
--- linux-2.6.18.orig/arch/powerpc/kernel/cputable.c	2006-11-15 10:44:40.584264280 -0600
+++ linux-2.6.18/arch/powerpc/kernel/cputable.c	2006-11-15 10:45:30.738227104 -0600
@@ -304,6 +304,9 @@
 			PPC_FEATURE_SMT,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
+		.num_pmcs		= 4,
+		.oprofile_cpu_type	= "ppc64/cell-be",
+		.oprofile_type		= PPC_OPROFILE_CELL,
 		.platform		= "ppc-cell-be",
 	},
 	{	/* PA Semi PA6T */
Index: linux-2.6.18/arch/powerpc/oprofile/common.c
===================================================================
--- linux-2.6.18.orig/arch/powerpc/oprofile/common.c	2006-11-15 10:44:40.168195360 -0600
+++ linux-2.6.18/arch/powerpc/oprofile/common.c	2006-11-15 10:45:30.740226800 -0600
@@ -141,6 +141,11 @@
 
 	switch (cur_cpu_spec->oprofile_type) {
 #ifdef CONFIG_PPC64
+#ifdef CONFIG_PPC_CELL
+		case PPC_OPROFILE_CELL:
+			model = &op_model_cell;
+			break;
+#endif
 		case PPC_OPROFILE_RS64:
 			model = &op_model_rs64;
 			break;
Index: linux-2.6.18/arch/powerpc/oprofile/Makefile
===================================================================
--- linux-2.6.18.orig/arch/powerpc/oprofile/Makefile	2006-11-15 10:44:40.166195664 -0600
+++ linux-2.6.18/arch/powerpc/oprofile/Makefile	2006-11-15 10:45:30.741226648 -0600
@@ -11,6 +11,7 @@
 		timer_int.o )
 
 oprofile-y := $(DRIVER_OBJS) common.o backtrace.o
+oprofile-$(CONFIG_PPC_CELL) += op_model_cell.o
 oprofile-$(CONFIG_PPC64) += op_model_rs64.o op_model_power4.o
 oprofile-$(CONFIG_FSL_BOOKE) += op_model_fsl_booke.o
 oprofile-$(CONFIG_6xx) += op_model_7450.o
Index: linux-2.6.18/arch/powerpc/oprofile/op_model_cell.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18/arch/powerpc/oprofile/op_model_cell.c	2006-11-15 11:13:45.512316720 -0600
@@ -0,0 +1,717 @@
+/*
+ * Cell Broadband Engine OProfile Support
+ *
+ * (C) Copyright IBM Corporation 2006
+ *
+ * Author: David Erb (djerb@us.ibm.com)
+ * Modifications:
+ *         Carl Love <carll@us.ibm.com>
+ *         Maynard Johnson <maynardj@us.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/cpufreq.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/jiffies.h>
+#include <linux/kthread.h>
+#include <linux/oprofile.h>
+#include <linux/percpu.h>
+#include <linux/smp.h>
+#include <linux/spinlock.h>
+#include <linux/timer.h>
+#include <asm/cell-pmu.h>
+#include <asm/cputable.h>
+#include <asm/firmware.h>
+#include <asm/io.h>
+#include <asm/oprofile_impl.h>
+#include <asm/processor.h>
+#include <asm/prom.h>
+#include <asm/ptrace.h>
+#include <asm/reg.h>
+#include <asm/rtas.h>
+#include <asm/system.h>
+
+#include "../platforms/cell/interrupt.h"
+
+#define PPU_CYCLES_EVENT_NUM 1	/*  event number for CYCLES */
+#define CBE_COUNT_ALL_CYCLES 0x42800000	/* PPU cycle event specifier */
+
+#define NUM_THREADS 2
+#define VIRT_CNTR_SW_TIME_NS 100000000	// 0.5 seconds
+
+struct pmc_cntrl_data {
+	unsigned long vcntr;
+	unsigned long evnts;
+	unsigned long masks;
+	unsigned long enabled;
+};
+
+/*
+ * ibm,cbe-perftools rtas parameters
+ */
+
+struct pm_signal {
+	u16 cpu;		/* Processor to modify */
+	u16 sub_unit;		/* hw subunit this applies to (if applicable) */
+	u16 signal_group;	/* Signal Group to Enable/Disable */
+	u8 bus_word;		/* Enable/Disable on this Trace/Trigger/Event
+				 * Bus Word(s) (bitmask)
+				 */
+	u8 bit;			/* Trigger/Event bit (if applicable) */
+};
+
+/*
+ * rtas call arguments
+ */
+enum {
+	SUBFUNC_RESET = 1,
+	SUBFUNC_ACTIVATE = 2,
+	SUBFUNC_DEACTIVATE = 3,
+
+	PASSTHRU_IGNORE = 0,
+	PASSTHRU_ENABLE = 1,
+	PASSTHRU_DISABLE = 2,
+};
+
+struct pm_cntrl {
+	u16 enable;
+	u16 stop_at_max;
+	u16 trace_mode;
+	u16 freeze;
+	u16 count_mode;
+};
+
+static struct {
+	u32 group_control;
+	u32 debug_bus_control;
+	struct pm_cntrl pm_cntrl;
+	u32 pm07_cntrl[NR_PHYS_CTRS];
+} pm_regs;
+
+
+#define GET_SUB_UNIT(x) ((x & 0x0000f000) >> 12)
+#define GET_BUS_WORD(x) ((x & 0x000000f0) >> 4)
+#define GET_BUS_TYPE(x) ((x & 0x00000300) >> 8)
+#define GET_POLARITY(x) ((x & 0x00000002) >> 1)
+#define GET_COUNT_CYCLES(x) (x & 0x00000001)
+#define GET_INPUT_CONTROL(x) ((x & 0x00000004) >> 2)
+
+
+DEFINE_PER_CPU(unsigned long[NR_PHYS_CTRS], pmc_values);
+
+struct pmc_cntrl_data pmc_cntrl[NUM_THREADS][NR_PHYS_CTRS];
+
+/* Interpetation of hdw_thread:
+ * 0 - even virtual cpus 0, 2, 4,...
+ * 1 - odd virtual cpus 1, 3, 5, ...
+ */
+static u32  hdw_thread;
+
+static u32 virt_cntr_inter_mask;
+static struct timer_list timer_virt_cntr;
+
+/* pm_signal needs to be glogal since it is initialized in
+ * cell_reg_setup at the time when the necessary information
+ * is available. 
+ */
+static struct pm_signal pm_signal[NR_PHYS_CTRS];
+static int pm_rtas_token;
+
+static u32 reset_value[NR_PHYS_CTRS];
+static int num_counters;
+static int oprofile_running;
+static spinlock_t stop_virt_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t virt_cntr_lock = SPIN_LOCK_UNLOCKED;
+
+static u32 ctr_enabled;
+
+static unsigned char trace_bus[4];
+static unsigned char input_bus[2];
+
+/*
+ * Firmware interface functions
+ */
+static int
+rtas_ibm_cbe_perftools(int subfunc, int passthru,
+		       void *address, unsigned long length)
+{
+	u64 paddr = __pa(address);
+
+	return rtas_call(pm_rtas_token, 5, 1, NULL, subfunc, passthru,
+			 paddr >> 32, paddr & 0xffffffff, length);
+}
+
+static void pm_rtas_reset_signals(u32 node)
+{
+	int ret;
+	struct pm_signal pm_signal_local[NR_PHYS_CTRS];
+
+	/*  The debug bus is being set to the passthru disable state.
+	 *  However, the FW still expects atleast one legal signal routing
+	 *  entry or it will return an error on the arguments.  If we don't
+	 *  supply a valid entry, we must ignore all return values.  Ignoring
+	 *  all return values means we might miss an error we should be
+	 *  concerned about.
+	 */
+
+	/*  fw expects physical cpu #. */
+	pm_signal_local[0].cpu = node;
+	pm_signal_local[0].signal_group = 21;
+	pm_signal_local[0].bus_word = 1;
+	pm_signal_local[0].sub_unit = 0;
+	pm_signal_local[0].bit = 0;
+
+	ret = rtas_ibm_cbe_perftools(SUBFUNC_RESET, PASSTHRU_DISABLE,
+				     pm_signal_local,
+				     sizeof(struct pm_signal));
+
+	if (ret)
+		printk(KERN_WARNING "%s: rtas returned: %d\n",
+		       __FUNCTION__, ret);
+}
+
+static void pm_rtas_activate_signals(u32 node, u32 count)
+{
+	int ret;
+	int j;
+        struct pm_signal pm_signal_local[NR_PHYS_CTRS];
+
+	for (j = 0; j < count; j++) {
+		/* fw expects physical cpu # */
+		pm_signal_local[j].cpu = node;
+		pm_signal_local[j].signal_group = pm_signal[j].signal_group;
+		pm_signal_local[j].bus_word = pm_signal[j].bus_word;
+		pm_signal_local[j].sub_unit = pm_signal[j].sub_unit;
+		pm_signal_local[j].bit = pm_signal[j].bit;
+	}
+
+	ret = rtas_ibm_cbe_perftools(SUBFUNC_ACTIVATE, PASSTHRU_ENABLE,
+				     pm_signal_local,
+				     count * sizeof(struct pm_signal));
+
+	if (ret)
+		printk(KERN_WARNING "%s: rtas returned: %d\n",
+		       __FUNCTION__, ret);
+}
+
+/*
+ * PM Signal functions
+ */
+static void set_pm_event(u32 ctr, int event, u32 unit_mask)
+{
+	struct pm_signal *p;
+	u32 signal_bit;
+	u32 bus_word, bus_type, count_cycles, polarity, input_control;
+	int j, i;
+
+	if (event == PPU_CYCLES_EVENT_NUM) {
+		/* Special Event: Count all cpu cycles */
+		pm_regs.pm07_cntrl[ctr] = CBE_COUNT_ALL_CYCLES;
+		p = &(pm_signal[ctr]);
+		p->signal_group = 21;
+		p->bus_word = 1;
+		p->sub_unit = 0;
+		p->bit = 0;
+		goto out;
+	} else {
+		pm_regs.pm07_cntrl[ctr] = 0;
+	}
+
+	bus_word = GET_BUS_WORD(unit_mask);
+	bus_type = GET_BUS_TYPE(unit_mask);
+	count_cycles = GET_COUNT_CYCLES(unit_mask);
+	polarity = GET_POLARITY(unit_mask);
+	input_control = GET_INPUT_CONTROL(unit_mask);
+	signal_bit = (event % 100);
+
+	p = &(pm_signal[ctr]);
+
+	p->signal_group = event / 100;
+	p->bus_word = bus_word;
+	p->sub_unit = unit_mask & 0x0000f000;
+
+	pm_regs.pm07_cntrl[ctr] = 0;
+	pm_regs.pm07_cntrl[ctr] |= PM07_CTR_COUNT_CYCLES(count_cycles);
+	pm_regs.pm07_cntrl[ctr] |= PM07_CTR_POLARITY(polarity);
+	pm_regs.pm07_cntrl[ctr] |= PM07_CTR_INPUT_CONTROL(input_control);
+
+	if (input_control == 0) {
+		if (signal_bit > 31) {
+			signal_bit -= 32;
+			if (bus_word == 0x3)
+				bus_word = 0x2;
+			else if (bus_word == 0xc)
+				bus_word = 0x8;
+		}
+
+		if ((bus_type == 0) && p->signal_group >= 60)
+			bus_type = 2;
+		if ((bus_type == 1) && p->signal_group >= 50)
+			bus_type = 0;
+
+		pm_regs.pm07_cntrl[ctr] |= PM07_CTR_INPUT_MUX(signal_bit);
+	} else {
+		pm_regs.pm07_cntrl[ctr] = 0;
+		p->bit = signal_bit;
+	}
+
+	for (i = 0; i < 4; i++) {
+		if (bus_word & (1 << i)) {
+			pm_regs.debug_bus_control |=
+			    (bus_type << (31 - (2 * i) + 1));
+
+			for (j = 0; j < 2; j++) {
+				if (input_bus[j] == 0xff) {
+					input_bus[j] = i;
+					pm_regs.group_control |=
+					    (i << (31 - i));
+					break;
+				}
+			}
+		}
+	}
+out:
+	return;
+}
+
+static void write_pm_cntrl(int cpu, struct pm_cntrl * pm_cntrl)
+{
+	/* Oprofile will use 32 bit counters, set bits 7:10 to 0 */
+	u32 val = 0;
+	if (pm_cntrl->enable == 1)
+		val |= CBE_PM_ENABLE_PERF_MON;
+
+	if (pm_cntrl->stop_at_max == 1)
+		val |= CBE_PM_STOP_AT_MAX;
+
+	if (pm_cntrl->trace_mode == 1)
+		val |= CBE_PM_TRACE_MODE_SET(pm_cntrl->trace_mode);
+
+	if (pm_cntrl->freeze == 1)
+		val |= CBE_PM_FREEZE_ALL_CTRS;
+
+	/* Routine set_count_mode must be called previously to set
+	 * the count mode based on the user selection of user and kernel.
+	 */
+	val |= CBE_PM_COUNT_MODE_SET(pm_cntrl->count_mode);
+	cbe_write_pm(cpu, pm_control, val);
+}
+
+static inline void
+set_count_mode(u32 kernel, u32 user, struct pm_cntrl *pm_cntrl)
+{
+	/* The user must specify user and kernel if they want them. If
+	 *  neither is specified, OProfile will count in hypervisor mode
+	 */
+	if (kernel) {
+		if (user)
+			pm_cntrl->count_mode = CBE_COUNT_ALL_MODES;
+		else
+			pm_cntrl->count_mode = CBE_COUNT_SUPERVISOR_MODE;
+	} else {
+		if (user)
+			pm_cntrl->count_mode = CBE_COUNT_PROBLEM_MODE;
+		else
+			pm_cntrl->count_mode = CBE_COUNT_HYPERVISOR_MODE;
+	}
+}
+
+static inline void enable_ctr(u32 cpu, u32 ctr, u32 * pm07_cntrl)
+{
+
+	pm07_cntrl[ctr] |= PM07_CTR_ENABLE(1);
+	cbe_write_pm07_control(cpu, ctr, pm07_cntrl[ctr]);
+}
+
+/*
+ * Oprofile setup functions
+ */
+static void cell_virtual_cntr(unsigned long data)
+{
+	/* This routine will alternate loading the virtual counters for
+	 * virtual CPUs
+	 */
+	int i, cntr_offset_prev, cntr_offset_next;
+	u32 cpu;
+	unsigned long flags = 0;
+	int num_enabled = 0;
+
+	/* Make sure that the interrupt_hander and 
+	 * the virt counter are not both playing with
+	 * the counters on the same node.  */
+
+	spin_lock_irqsave(&virt_cntr_lock, flags);
+
+        /* cntr offset for the cntrs that were running */
+	cntr_offset_prev = num_counters *  hdw_thread;	
+
+        /* switch the cpu handling the interrupts */
+	hdw_thread = 1 ^  hdw_thread;
+
+	/* cntr offset for the cntrs to start */
+	cntr_offset_next = num_counters *  hdw_thread;
+	/* The following is done only once per each node, but       
+	 * we need cpu #, not node #, to pass to the cbe_xxx functions.
+	 */
+	for_each_online_cpu(cpu) {
+ 		if (cbe_get_hw_thread_id(cpu))
+			continue;
+
+		/* stop counters, save counter values, restore counts
+		 * for previous thread
+		 */
+
+		cbe_disable_pm(cpu);
+		if (cbe_query_pm_interrupts(cpu)) {
+			/* There is a pending interrupt.  We will clear it.
+			 * The cntr value will be 0xffffffff.  We will 
+			 * reset that to 0xfffffff0 when the current 
+			 * thread is restarted.  This will generate a new
+			 * interrupt and make sure that we never restore
+			 * the counters to the max value.  If the counters
+			 * were restored to the max value, they do not 
+			 * increment and no interrupts are generated.  Hence
+			 * no more samples will be collected on that cpu. 
+			 * Ignore return value from cbe_clear_pm_interrupts()
+			 */
+			cbe_clear_pm_interrupts(cpu);
+		}
+
+		cbe_disable_pm_interrupts(cpu);
+		for (i = 0; i < num_counters; i++) {
+			per_cpu(pmc_values, cpu)[i + cntr_offset_prev]
+				= cbe_read_ctr(cpu, i);
+
+			if (per_cpu(pmc_values, cpu)[i+cntr_offset_next] == \
+			    0xFFFFFFFF) 
+				/* Make sure the counter is not restored to
+				 * the max value.  If you do, the counters 
+				 * will not increment, and no interrupts will 
+				 * occur. 
+				 */
+				cbe_write_ctr(cpu, i, 0xFFFFFFF0);
+			else
+				cbe_write_ctr(cpu, i,
+					      per_cpu(pmc_values, 
+						      cpu)[i+cntr_offset_next]);
+		}
+
+		/* Switch to the other thread. Change the interrupt
+		 * and control regs to be scheduled on the CPU
+		 * corresponding to the thread to execute.
+		 */
+		num_enabled = 0;
+
+		for (i = 0; i < num_counters; i++) {
+			if (pmc_cntrl[hdw_thread][i+cntr_offset_next].enabled) {
+				set_pm_event(num_enabled,
+					     pmc_cntrl[hdw_thread][i].enabled,
+					     pmc_cntrl[hdw_thread][i].masks);
+
+				num_enabled++;
+				ctr_enabled |= (1 << i);
+			}
+		}
+
+		/* Enable interrupts on the CPU thread that is starting */
+		cbe_enable_pm_interrupts(cpu, hdw_thread,
+					 virt_cntr_inter_mask);
+		cbe_enable_pm(cpu);
+	}
+
+	spin_unlock_irqrestore(&virt_cntr_lock, flags);
+
+	timer_virt_cntr.expires = jiffies + HZ/10;
+	add_timer(&timer_virt_cntr);
+
+	return;
+}
+
+static void start_virt_cntrs(void)
+{
+	init_timer(&timer_virt_cntr);
+	timer_virt_cntr.function = cell_virtual_cntr;
+	timer_virt_cntr.data = 0UL;
+	timer_virt_cntr.expires = jiffies + HZ/10;
+	add_timer(&timer_virt_cntr);
+}
+
+/* This function is called once for all cpus combined */
+static void
+cell_reg_setup(struct op_counter_config *ctr,
+	       struct op_system_config *sys, int num_ctrs)
+{
+	int i, j;
+	int num_enabled = 0;
+
+	smp_mb();
+	pm_rtas_token = rtas_token("ibm,cbe-perftools");
+	if (pm_rtas_token == RTAS_UNKNOWN_SERVICE) {
+		printk(KERN_WARNING "%s: RTAS_UNKNOWN_SERVICE\n",
+		       __FUNCTION__);
+		goto out;
+	}
+
+	num_counters = num_ctrs;
+
+	pm_regs.group_control = 0;
+	pm_regs.debug_bus_control = 0;
+
+	/* setup the pm_control register */
+	memset(&pm_regs.pm_cntrl, 0, sizeof(struct pm_cntrl));
+	pm_regs.pm_cntrl.stop_at_max = 1;
+	pm_regs.pm_cntrl.trace_mode = 0;
+	pm_regs.pm_cntrl.freeze = 1;
+
+	set_count_mode(sys->enable_kernel, sys->enable_user,
+		       &pm_regs.pm_cntrl);
+
+	/* Setup the thread 0 events */
+	for (i = 0; i < num_ctrs; ++i) {
+
+		pmc_cntrl[0][i].evnts = ctr[i].event;
+		pmc_cntrl[0][i].masks = ctr[i].unit_mask;
+		pmc_cntrl[0][i].enabled = ctr[i].enabled;
+		pmc_cntrl[0][i].vcntr = i;
+
+		for_each_possible_cpu(j)
+			per_cpu(pmc_values, j)[i] = 0;
+	}
+
+	/* Setup the thread 1 events, map the thread 0 event to the
+	 * equivalent thread 1 event.
+	 */
+	for (i = 0; i < num_ctrs; ++i) {
+
+		if ((ctr[i].event >= 2100) && (ctr[i].event <= 2111))
+			pmc_cntrl[1][i].evnts = ctr[i].event + 19;
+		else if (ctr[i].event == 2203)
+			pmc_cntrl[1][i].evnts = ctr[i].event;
+		else if ((ctr[i].event >= 2200) && (ctr[i].event <= 2215))
+			pmc_cntrl[1][i].evnts = ctr[i].event + 16;
+		else
+			pmc_cntrl[1][i].evnts = ctr[i].event;
+
+		pmc_cntrl[1][i].masks = ctr[i].unit_mask;
+		pmc_cntrl[1][i].enabled = ctr[i].enabled;
+		pmc_cntrl[1][i].vcntr = i;
+	}
+
+	for (i = 0; i < 4; i++)
+		trace_bus[i] = 0xff;
+
+	for (i = 0; i < 2; i++)
+		input_bus[i] = 0xff;
+
+	/* Our counters count up, and "count" refers to
+	 * how much before the next interrupt, and we interrupt
+	 * on overflow.  So we calculate the starting value
+	 * which will give us "count" until overflow.
+	 * Then we set the events on the enabled counters.
+	 */
+	for (i = 0; i < num_counters; ++i) {
+		/* start with virtual counter set 0 */
+
+		if (pmc_cntrl[0][i].enabled) {
+			/* Using 32bit counters, reset max - count */
+			reset_value[i] = 0xFFFFFFFF - ctr[i].count;
+			set_pm_event(num_enabled,
+				     pmc_cntrl[0][i].evnts,
+				     pmc_cntrl[0][i].masks);
+			num_enabled++;
+			ctr_enabled |= (1 << i);
+		}
+	}
+
+	start_virt_cntrs();
+out:
+	return;
+}
+
+/* This function is called once for each cpu */
+static void cell_cpu_setup(void *unused)
+{
+	u32 cpu = smp_processor_id();
+	u32 num_enabled = 0;
+	int i;
+
+	/* There is one performance monitor per processor chip (i.e. node),
+	 * so we only need to perform this function once per node.
+	 */
+	if (cbe_get_hw_thread_id(cpu))
+		goto out;
+
+	if (pm_rtas_token == RTAS_UNKNOWN_SERVICE) {
+		printk(KERN_WARNING "%s: RTAS_UNKNOWN_SERVICE\n",
+		       __FUNCTION__);
+		goto out;
+	}
+
+	/* Stop all counters */
+	cbe_disable_pm(cpu);
+	cbe_disable_pm_interrupts(cpu);
+
+	cbe_write_pm(cpu, pm_interval, 0);
+	cbe_write_pm(cpu, pm_start_stop, 0);
+	cbe_write_pm(cpu, group_control, pm_regs.group_control);
+	cbe_write_pm(cpu, debug_bus_control, pm_regs.debug_bus_control);
+	write_pm_cntrl(cpu, &pm_regs.pm_cntrl);
+
+	for (i = 0; i < num_counters; ++i) {
+		if (ctr_enabled & (1 << i)) {
+			pm_signal[num_enabled].cpu = cbe_cpu_to_node(cpu);
+			num_enabled++;
+		}
+	}
+
+	pm_rtas_activate_signals(cbe_cpu_to_node(cpu), num_enabled);
+out:
+	return;
+}
+
+static void cell_start(struct op_counter_config *ctr)
+{
+	u32 cpu = smp_processor_id();
+	u32 interrupt_mask;
+	u32 i;
+
+	/* There is one performance monitor per node, so we 
+	 * only need to perform this function once per node.
+	 */
+	if (cbe_get_hw_thread_id(cpu))
+		goto out;
+
+	interrupt_mask = 0;
+
+	for (i = 0; i < num_counters; ++i) {
+		if (ctr_enabled & (1 << i)) {
+			cbe_write_ctr(cpu, i, reset_value[i]);
+			enable_ctr(cpu, i, pm_regs.pm07_cntrl);
+			interrupt_mask |= CBE_PM_CTR_OVERFLOW_INTR(i);
+		} else {
+			/* Disable counter */
+			cbe_write_pm07_control(cpu, i, 0);
+		}
+	}
+
+	cbe_clear_pm_interrupts(cpu);
+	virt_cntr_inter_mask = interrupt_mask;
+	cbe_enable_pm_interrupts(cpu, hdw_thread, interrupt_mask);
+	cbe_enable_pm(cpu);
+	oprofile_running = 1;
+	smp_mb();
+out:
+	return;
+}
+
+static void cell_stop(void)
+{
+	u32 cpu = smp_processor_id();
+	unsigned long flags = 0;
+
+	/* There is one performance monitor per node, so we 
+	 * only need to perform this function once per node.
+	 */
+	
+	if (cbe_get_hw_thread_id(cpu))
+		goto out;
+
+	/* Make sure only once CPU at a time trys to cancel 
+	 * the timer 
+	 */
+	spin_lock_irqsave(&stop_virt_lock, flags);
+	if (timer_pending(&timer_virt_cntr))
+		del_timer_sync(&timer_virt_cntr);
+	spin_unlock_irqrestore(&stop_virt_lock, flags);
+
+	smp_mb();
+
+	/* Stop the counters */
+	cbe_disable_pm(cpu);
+
+	/* Deactivate the signals */
+	pm_rtas_reset_signals(cbe_cpu_to_node(cpu));
+
+	/* Deactivate interrupts */
+	cbe_disable_pm_interrupts(cpu);
+
+	oprofile_running = 0;
+	smp_mb();
+out:
+	return;
+}
+
+static void
+cell_handle_interrupt(struct pt_regs *regs, struct op_counter_config *ctr)
+{
+	u32 cpu;
+	u64 pc;
+	int is_kernel;
+	unsigned long flags = 0;
+	u32 interrupt_mask;
+	int i;
+
+	cpu = smp_processor_id();
+
+	/* Need to make sure the interrupt handler and the virt counter
+	 * routine are not running at the same time. See the 
+	 * cell_virtual_cntr() routine for additional comments. */
+	spin_lock_irqsave(&virt_cntr_lock, flags);
+	
+	/* Need to disable and reenable the performance counters
+	 * to get the desired behavior from the hardware.  This
+	 * is hardware specific.  
+	 */
+
+	cbe_disable_pm(cpu);
+
+	interrupt_mask = cbe_clear_pm_interrupts(cpu);
+
+	/* If the interrupt mask has been cleared, then the virt cntr
+	 * has cleared the interrupt.  When the thread that generated
+	 * the interrupt is restored, the data count will be restored to
+	 * 0xffffff0 to cause the interrupt to be regenerated.
+	 */
+
+	if ((oprofile_running == 1) && (interrupt_mask != 0)) {
+		pc = regs->nip;
+		is_kernel = is_kernel_addr(pc);
+
+		for (i = 0; i < num_counters; ++i) {
+			if ((interrupt_mask & CBE_PM_CTR_OVERFLOW_INTR(i)) &&
+			    ctr[i].enabled) {
+				oprofile_add_pc(pc, is_kernel, i);
+				cbe_write_ctr(cpu, i, reset_value[i]);
+			}
+		}
+
+		/* The counters were frozen by the interrupt.
+		 * Reenable the interrupt and restart the counters.
+		 */
+		cbe_enable_pm_interrupts(cpu, hdw_thread, interrupt_mask);
+
+		/* The writes to the various performance counters only writes
+		 * to a latch.  The new values (interrupt setting bits, reset
+		 * counter value etc.) are not copied to the actual registers 
+		 * until the performance monitor is enabled.  In order to get
+		 * this to work as desired, the permormance monitor needs to 
+		 * be disabled while writting to the latches.  This is a 
+		 * HW design issue.
+		 */
+		cbe_enable_pm(cpu);
+	}
+	spin_unlock_irqrestore(&virt_cntr_lock, flags);
+}
+
+struct op_powerpc_model op_model_cell = {
+	.reg_setup = cell_reg_setup,
+	.cpu_setup = cell_cpu_setup,
+	.start = cell_start,
+	.stop = cell_stop,
+	.handle_interrupt = cell_handle_interrupt,
+};
Index: linux-2.6.18/arch/powerpc/platforms/cell/cbe_regs.c
===================================================================
--- linux-2.6.18.orig/arch/powerpc/platforms/cell/cbe_regs.c	2006-11-15 10:44:40.629257440 -0600
+++ linux-2.6.18/arch/powerpc/platforms/cell/cbe_regs.c	2006-11-15 10:45:30.750225280 -0600
@@ -132,6 +132,18 @@
 }
 EXPORT_SYMBOL_GPL(cbe_get_cpu_mic_tm_regs);
 
+/* FIXME
+ * This is little more than a stub at the moment.  It should be
+ * fleshed out so that it works for both SMT and non-SMT, no
+ * matter if the passed cpu is odd or even. 
+ * For SMT enabled, returns 0 for even-numbered cpu; otherwise 1.
+ * For SMT disabled, returns 0 for all cpus.
+ */
+u32 cbe_get_hw_thread_id(int cpu)
+{
+	return (cpu & 1);
+}
+EXPORT_SYMBOL_GPL(cbe_get_hw_thread_id);
 
 void __init cbe_regs_init(void)
 {
Index: linux-2.6.18/include/asm-powerpc/cell-pmu.h
===================================================================
--- linux-2.6.18.orig/include/asm-powerpc/cell-pmu.h	2006-11-15 10:45:06.386200720 -0600
+++ linux-2.6.18/include/asm-powerpc/cell-pmu.h	2006-11-15 11:14:53.737196336 -0600
@@ -92,4 +92,21 @@
 extern u32  cbe_query_pm_interrupts(u32 cpu);
 extern u32  cbe_clear_pm_interrupts(u32 cpu);
 
+/* Utility functions, macros */
+extern u32 cbe_get_hw_thread_id(int cpu);
+
+#define cbe_cpu_to_node(cpu) ((cpu) >> 1)
+
+#define CBE_COUNT_SUPERVISOR_MODE       0
+#define CBE_COUNT_HYPERVISOR_MODE       1
+#define CBE_COUNT_PROBLEM_MODE          2
+#define CBE_COUNT_ALL_MODES             3
+
+/* Macros for the pm07_control registers. */
+#define PM07_CTR_INPUT_MUX(x)                    ((((x) & 1) << 26) & 0x3f)
+#define PM07_CTR_INPUT_CONTROL(x)                (((x) & 1) << 25)
+#define PM07_CTR_POLARITY(x)                     (((x) & 1) << 24)
+#define PM07_CTR_COUNT_CYCLES(x)                 (((x) & 1) << 23)
+#define PM07_CTR_ENABLE(x)                       (((x) & 1) << 22)
+
 #endif /* __ASM_CELL_PMU_H__ */
Index: linux-2.6.18/include/asm-powerpc/cputable.h
===================================================================
--- linux-2.6.18.orig/include/asm-powerpc/cputable.h	2006-11-15 10:44:40.369296960 -0600
+++ linux-2.6.18/include/asm-powerpc/cputable.h	2006-11-15 10:45:30.754224672 -0600
@@ -45,6 +45,7 @@
 	PPC_OPROFILE_POWER4 = 2,
 	PPC_OPROFILE_G4 = 3,
 	PPC_OPROFILE_BOOKE = 4,
+	PPC_OPROFILE_CELL = 5,
 };
 
 struct cpu_spec {
Index: linux-2.6.18/include/asm-powerpc/oprofile_impl.h
===================================================================
--- linux-2.6.18.orig/include/asm-powerpc/oprofile_impl.h	2006-11-15 10:44:40.204189888 -0600
+++ linux-2.6.18/include/asm-powerpc/oprofile_impl.h	2006-11-15 10:45:30.755224520 -0600
@@ -54,6 +54,7 @@
 extern struct op_powerpc_model op_model_rs64;
 extern struct op_powerpc_model op_model_power4;
 extern struct op_powerpc_model op_model_7450;
+extern struct op_powerpc_model op_model_cell;
 
 #ifndef CONFIG_FSL_BOOKE
 

--------------030207080505090400090808--

