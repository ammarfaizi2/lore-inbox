Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946712AbWKJQsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946712AbWKJQsl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 11:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946782AbWKJQsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 11:48:41 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:44727 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1946712AbWKJQsj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 11:48:39 -0500
Message-ID: <4554AD66.6080705@us.ibm.com>
Date: Fri, 10 Nov 2006 10:48:38 -0600
From: Maynard Johnson <maynardj@us.ibm.com>
Reply-To: maynardj@us.ibm.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFC, PATCH 2/2] OProfile for Cell: Initial profiling support
Content-Type: multipart/mixed;
 boundary="------------000108080508050307010101"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000108080508050307010101
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------000108080508050307010101
Content-Type: text/plain;
 name="oprof-ppu.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oprof-ppu.diff"

Add PPU event-based and cycle-based profiling support to Oprofile for Cell.

Signed-Off-By: Carl Love <carll@us.ibm.com>
Signed-Off-By: Maynard Johnson <mpjohn@us.ibm.com>

Index: linux-2.6.18/arch/powerpc/kernel/cputable.c
===================================================================
--- linux-2.6.18.orig/arch/powerpc/kernel/cputable.c	2006-11-06 14:54:53.493095704 -0600
+++ linux-2.6.18/arch/powerpc/kernel/cputable.c	2006-11-09 08:49:41.097159368 -0600
@@ -287,6 +287,9 @@
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
--- linux-2.6.18.orig/arch/powerpc/oprofile/common.c	2006-09-19 22:42:06.000000000 -0500
+++ linux-2.6.18/arch/powerpc/oprofile/common.c	2006-11-09 18:50:18.673115320 -0600
@@ -136,6 +136,11 @@
 
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
@@ -147,6 +152,7 @@
 			model = &op_model_7450;
 			break;
 #endif
+
 #ifdef CONFIG_FSL_BOOKE
 		case PPC_OPROFILE_BOOKE:
 			model = &op_model_fsl_booke;
Index: linux-2.6.18/arch/powerpc/oprofile/Makefile
===================================================================
--- linux-2.6.18.orig/arch/powerpc/oprofile/Makefile	2006-09-19 22:42:06.000000000 -0500
+++ linux-2.6.18/arch/powerpc/oprofile/Makefile	2006-11-09 08:49:41.100158912 -0600
@@ -11,6 +11,7 @@
 		timer_int.o )
 
 oprofile-y := $(DRIVER_OBJS) common.o backtrace.o
+oprofile-$(CONFIG_PPC_CELL) += op_model_cell.o
 oprofile-$(CONFIG_PPC64) += op_model_rs64.o op_model_power4.o
 oprofile-$(CONFIG_FSL_BOOKE) += op_model_fsl_booke.o
 oprofile-$(CONFIG_PPC32) += op_model_7450.o
Index: linux-2.6.18/arch/powerpc/oprofile/op_model_cell.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18/arch/powerpc/oprofile/op_model_cell.c	2006-11-09 18:46:47.347158248 -0600
@@ -0,0 +1,628 @@
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
+#include <linux/oprofile.h>
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <asm/firmware.h>
+#include <asm/ptrace.h>
+#include <asm/system.h>
+#include <asm/processor.h>
+#include <asm/io.h>
+#include <asm/cputable.h>
+#include <asm/rtas.h>
+#include <asm/oprofile_impl.h>
+#include <asm/reg.h>
+#include <asm/prom.h>
+#include <linux/kthread.h>
+#include <linux/delay.h>
+#include <linux/spinlock.h>
+#include <linux/cpufreq.h>
+#include <linux/hrtimer.h>
+#include <asm/system.h>
+
+#include "../platforms/cell/cbe_regs.h"
+#include "../platforms/cell/pmu.h"
+#include "../platforms/cell/interrupt.h"
+#include "cell/perf_utils.h"
+
+unsigned long pmc_values[NR_CPUS][NUM_CNTRS];
+struct pmc_cntrl_data pmc_cntrl[NUM_THREADS][NUM_CNTRS];
+
+/* Interpetation of hdw_thread:
+ * 0 - even virtual cpus 0, 2, 4,...
+ * 1 - odd virtual cpus 1, 3, 5, ...
+ */
+static u32  hdw_thread;
+
+static u32 vrit_cntr_inter_mask;
+static struct hrtimer timer_virt_cntr;
+
+
+/* pm_signal, need per node copy for smt safeness since multiple cpus
+ * are using this structure in the RTAS calls */
+static struct pm_signal pm_signal[NR_NODES][OP_MAX_COUNTER];
+static int pm_rtas_token;
+
+static u32 reset_value[OP_MAX_COUNTER];
+static int num_counters;
+static int oprofile_running;
+static int stop_virt_cntrs;
+
+static u32 ctr_enabled;
+
+static short int passthru[NR_NODES];
+static signed char trace_bus[4];
+static signed char input_bus[2];
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
+
+	pm_signal[node][0].cpu = node;	// fw expects physical cpu #
+	passthru[node] = PASSTHRU_DISABLE;
+
+	ret = rtas_ibm_cbe_perftools(SUBFUNC_RESET, passthru[node],
+				     pm_signal[node],
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
+
+	if (passthru[node] == PASSTHRU_DISABLE) {
+		passthru[node] = PASSTHRU_ENABLE;
+	}
+
+	pm_signal[node][0].cpu = node;	// fw expects physical cpu #
+
+	ret = rtas_ibm_cbe_perftools(SUBFUNC_ACTIVATE, passthru[node],
+				     pm_signal[node],
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
+
+static void set_pm_event(u32 ctr, int event, u32 unit_mask)
+{
+	struct pm_signal *p;
+	u32 bus_word;
+	int node;
+	u32 bus_type;
+	u32 signal_bit;
+	struct oprofile_umask umask;
+	int j, i;
+
+
+	if (event == PPU_CYCLES_EVENT_NUM) {
+		/* Special Event: Count all cpu cycles */
+		pm_regs.pm07_cntrl[ctr] = CBE_COUNT_ALL_CYCLES;
+
+		for_each_cbe_node(node) {
+			p = &(pm_signal[node][ctr]);
+			p->signal_group = 21;
+			p->bus_word = 0;
+			p->sub_unit = 0;
+			p->bit = 0;
+		}
+
+		return;
+	} else {
+		pm_regs.pm07_cntrl[ctr] = 0;
+	}
+
+
+	umask.val = unit_mask;
+	bus_word = umask.bus_word;
+	bus_type = umask.bus_type;
+
+	signal_bit = (event % 100);
+
+	p = &(pm_signal[0][ctr]);
+
+	p->signal_group = event / 100;
+	p->bus_word = bus_word;
+	p->sub_unit = umask.sub_unit;
+
+	for_each_cbe_node(node) {
+		pm_signal[node][ctr].signal_group
+			= pm_signal[0][ctr].signal_group;
+		pm_signal[node][ctr].bus_word = pm_signal[0][ctr].bus_word;
+		pm_signal[node][ctr].sub_unit = pm_signal[0][ctr].sub_unit;
+	}
+
+	pm_regs.pm07_cntrl[ctr] = 0;
+	pm_regs.pm07_cntrl[ctr] |=
+	    PM07_CTR_COUNT_CYCLES(umask.count_cycles);
+	pm_regs.pm07_cntrl[ctr] |= PM07_CTR_POLARITY(umask.polarity);
+	pm_regs.pm07_cntrl[ctr] |=
+	    PM07_CTR_INPUT_CONTROL(umask.input_control);
+
+	if (umask.input_control == 0) {
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
+				if (input_bus[j] == UNUSED_WORD) {
+					input_bus[j] = i;
+					pm_regs.group_control |=
+					    (i << (31 - i));
+					break;
+				}
+			}
+		}
+	}
+}
+
+static void clear_pm_cntrl(struct pm_cntrl *pm_cntrl)
+{
+	/* clear the structure of values for setting the
+	   pm_control register */
+	pm_cntrl->enable = 0;
+	pm_cntrl->stop_at_max = 0;
+	pm_cntrl->trace_mode = 0;
+	pm_cntrl->freeze = 0;
+	pm_cntrl->count_mode = 0;
+}
+
+static void write_pm_cntrl(int cpu, struct pm_cntrl pm_cntrl)
+{
+	/* Oprofile will user 32 bit counters, set bits 7:10 to 0 */
+	u32 val = 0;
+
+	if (pm_cntrl.enable == 1)
+		val |= CBE_PM_ENABLE_PERF_MON;
+
+	if (pm_cntrl.stop_at_max == 1)
+		val |= CBE_PM_STOP_AT_MAX;
+
+	if (pm_cntrl.trace_mode == 1)
+		val |= CBE_PM_TRACE_MODE_SET(pm_cntrl.trace_mode);
+
+	if (pm_cntrl.freeze == 1)
+		val |= CBE_PM_FREEZE_ALL_CTRS;
+
+	/* routine set_ount_mode must be called previously to set
+	 *  the count mode based on the user selection of user and kernel */
+	val |= CBE_PM_COUNT_MODE_SET(pm_cntrl.count_mode);
+	cbe_write_pm(cpu, pm_control, val);
+
+}
+
+static inline void
+set_count_mode(u32 kernel, u32 user, struct pm_cntrl *pm_cntrl)
+{
+	/* The user must specify user and kernel if they want them. If
+	 *  neither is specified, OProfile will count in hypervisor mode */
+	if (kernel) {
+		if(user)
+			pm_cntrl->count_mode = CBE_COUNT_ALL_MODES;
+		else
+			pm_cntrl->count_mode = CBE_COUNT_SUPERVISOR_MODE;
+	} else {
+		if(user)
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
+static inline void disable_ctr(u32 cpu, u32 ctr)
+{
+	int val = 0;
+	cbe_write_pm07_control(cpu, ctr, val);
+}
+
+
+/*
+ * Oprofile setup functions
+ */
+
+static int cell_virtual_cntr(struct hrtimer *timer)
+{
+	/* This routine will alternate loading the virtual counters for
+	 * virtual CPUs */
+
+	int i, cntr_offset_prev, cntr_offset_next;
+	u32 cpu;
+	u32 interrupt_mask;
+	ktime_t kt;
+	int nEnabled = 0;
+
+
+	if (stop_virt_cntrs == 1)
+		return HRTIMER_NORESTART;
+
+        /* cntr offset for the cntrs that were running */
+	cntr_offset_prev = num_counters *  hdw_thread;	
+
+        /* switch the cpu handling the interrupts */
+	hdw_thread = 1 ^  hdw_thread;
+
+	/* cntr offset for the cntrs to start */
+	cntr_offset_next = num_counters *  hdw_thread;
+
+        /* The following is done only once per each node, but
+	 * we need cpu #, not node #, to pass to the cbe_xxx functions.
+	 */
+	for_each_online_cpu(cpu) {
+		if (cpu & 1)
+			continue;
+
+		/* stop counters, save counter values, restore counts
+		 * for previous thread */
+		cbe_disable_pm(cpu);
+		cbe_disable_pm_interrupts(cpu);
+		interrupt_mask = cbe_clear_pm_interrupts(cpu);
+
+		for (i = 0; i < num_counters; i++) {
+			pmc_values[cpu][i + cntr_offset_prev]
+				= cbe_read_ctr(cpu, i);
+			cbe_write_ctr(cpu, i,
+				      pmc_values[cpu][i+cntr_offset_next]);
+		}
+
+		/* switch to the other thread, change the interrupt
+		 *  and control regs to be scheduled on the CPU
+		 * corresponding to the thread to execute
+		 */
+		nEnabled = 0;
+
+		for (i = 0; i < num_counters; i++) {
+			if (pmc_cntrl[ hdw_thread][i+cntr_offset_next].enabled) {
+				set_pm_event(nEnabled,
+					     pmc_cntrl[hdw_thread][i].enabled,
+					     pmc_cntrl[hdw_thread][i].masks);
+
+				nEnabled++;
+				ctr_enabled |= (1 << i);
+			}
+		}
+
+		/* enable interrupts on the CPU thread that
+		 * is starting */
+		cbe_enable_pm_interrupts(cpu, hdw_thread,
+					 vrit_cntr_inter_mask);
+		cbe_enable_pm(cpu);
+		
+	}
+
+	if (stop_virt_cntrs == 1) {
+		return HRTIMER_NORESTART;
+
+	} else {
+		kt = ktime_set(0, VIRT_CNTR_SW_TIME_NS);
+		hrtimer_forward(timer, timer->base->get_time(), kt);
+		return HRTIMER_RESTART;
+	}
+}
+
+
+void start_virt_cntrs(void)
+{
+	ktime_t kt;
+
+	kt = ktime_set(0, VIRT_CNTR_SW_TIME_NS);
+
+	hrtimer_init(&timer_virt_cntr, CLOCK_MONOTONIC, HRTIMER_REL);
+	timer_virt_cntr.expires = kt;
+	timer_virt_cntr.function = cell_virtual_cntr;
+	hrtimer_start(&timer_virt_cntr, kt, HRTIMER_REL);
+}
+
+
+/* This function is called once for all cpus combined */
+static void
+cell_reg_setup(struct op_counter_config *ctr,
+	       struct op_system_config *sys, int num_ctrs)
+{
+	int node, i, j;
+	int nEnabled = 0;
+
+	stop_virt_cntrs = 0;
+	smp_mb();
+	pm_rtas_token = rtas_token("ibm,cbe-perftools");
+	if (pm_rtas_token == RTAS_UNKNOWN_SERVICE) {
+		printk("ERROR, ibm,cbe-perftools RTAS_UNKNOWN_SERVICE\n");
+		return;
+	}
+
+
+	for_each_cbe_node(node) {
+		passthru[node] = PASSTHRU_DISABLE;
+	}
+
+	num_counters = num_ctrs;
+
+	pm_regs.group_control = 0;
+	pm_regs.debug_bus_control = 0;
+
+	/* setup the pm_control register */
+	clear_pm_cntrl(&pm_regs.pm_cntrl);
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
+		for (j = 0; j < NR_CPUS; j++) {
+			pmc_values[j][i] = 0;
+		}
+	}
+
+	/* Setup the thread 1 events, map the thread 0 event to the
+	 *  equivalent thread 1 event
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
+		trace_bus[i] = UNUSED_WORD;
+
+	for (i = 0; i < 2; i++)
+		input_bus[i] = UNUSED_WORD;
+
+	/* Our counters count up, and "count" refers to
+	 * how much before the next interrupt, and we interrupt
+	 * on overflow.  So we calculate the starting value
+	 * which will give us "count" until overflow.
+	 * Then we set the events on the enabled counters.
+	 */
+
+	for (i = 0; i < num_counters; ++i) {
+		/* start with virtual counter set 0 */
+
+		if (pmc_cntrl[0][i].enabled) {
+			// using 32bit counters, reset max - count
+			reset_value[i] = 0xFFFFFFFF - ctr[i].count;
+			set_pm_event(nEnabled,
+				     pmc_cntrl[0][i].evnts,
+				     pmc_cntrl[0][i].masks);
+			nEnabled++;
+			ctr_enabled |= (1 << i);
+		}
+	}
+
+	start_virt_cntrs();
+
+}
+
+/* This function is called once for each cpu */
+static void cell_cpu_setup(void *unused)
+{
+	u32 cpu = smp_processor_id();
+	u32 nEnabled = 0;
+	u32 interrupt_mask;
+	int i;
+
+	/* There is one performance monitor for cpu 0/1 and one for cpu 2/3,
+	 * so we only need to perform this function once per node.
+	 */
+	if (is_smt() && (cpu & 1))
+		return;
+
+	if (pm_rtas_token == RTAS_UNKNOWN_SERVICE) {
+		printk("ERROR, RTAS_UNKNOWN_SERVICE\n");
+		return;
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
+	write_pm_cntrl(cpu, pm_regs.pm_cntrl);
+
+	interrupt_mask = 0;
+
+	for (i = 0; i < num_counters; ++i) {
+		if (ctr_enabled & (1 << i)) {
+			pm_signal[cpu / 2][nEnabled].cpu = cpu / 2;
+			nEnabled++;
+			interrupt_mask |= CBE_PM_CTR_OVERFLOW_INTR(i);
+		}
+	}
+
+	pm_rtas_activate_signals(cbe_cpu_to_node(cpu), nEnabled);
+}
+
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
+	if (is_smt() && (cpu & 1))
+		return;
+
+	interrupt_mask = 0;
+
+	for (i = 0; i < num_counters; ++i) {
+		if (ctr_enabled & (1 << i)) {
+			cbe_write_ctr(cpu, i, reset_value[i]);
+			enable_ctr(cpu, i, pm_regs.pm07_cntrl);
+			interrupt_mask |= CBE_PM_CTR_OVERFLOW_INTR(i);
+		} else {
+			disable_ctr(cpu, i);
+		}
+	}
+
+	cbe_clear_pm_interrupts(cpu);
+	vrit_cntr_inter_mask = interrupt_mask;
+
+	cbe_enable_pm_interrupts(cpu, hdw_thread, interrupt_mask);
+
+
+	cbe_enable_pm(cpu);
+
+	oprofile_running = 1;
+	smp_mb();
+}
+
+/*
+ *  PM virtual counter functions
+ */
+
+static void cell_stop(void)
+{
+	u32 cpu = smp_processor_id();
+
+	/* There is one performance monitor per node, so we 
+	 * only need to perform this function once per node.
+	 */
+	if (is_smt() && (cpu & 1)) {
+		return;
+	}
+	hrtimer_cancel(&timer_virt_cntr);
+	stop_virt_cntrs = 1;
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
+}
+
+static void
+cell_handle_interrupt(struct pt_regs *regs, struct op_counter_config *ctr)
+{
+	u32 cpu;
+	u64 pc;
+	int is_kernel;
+	u32 interrupt_mask;
+	int i;
+
+	cpu = smp_processor_id();
+	cbe_disable_pm(cpu);
+
+	interrupt_mask = cbe_clear_pm_interrupts(cpu);
+
+	if (oprofile_running == 1) {
+		pc = regs->nip;
+		is_kernel = is_kernel_addr(pc);
+
+		for (i = 0; i < num_counters; ++i) {
+			if (interrupt_mask & CBE_PM_CTR_OVERFLOW_INTR(i)) {
+				if (ctr[i].enabled) {
+					oprofile_add_pc(pc, is_kernel, i);
+					cbe_write_ctr(cpu, i, reset_value[i]);
+				}
+			}
+		}
+	}
+
+	/* The counters were frozen by the interrupt.
+	 * Reenable the interrupt and restart the counters.
+	 */
+	cbe_enable_pm_interrupts(cpu, hdw_thread, interrupt_mask);
+	cbe_enable_pm(cpu);
+}
+
+struct op_powerpc_model op_model_cell = {
+	.reg_setup = cell_reg_setup,
+	.cpu_setup = cell_cpu_setup,
+	.start = cell_start,
+	.stop = cell_stop,
+	.handle_interrupt = cell_handle_interrupt,
+};
Index: linux-2.6.18/include/asm-powerpc/cputable.h
===================================================================
--- linux-2.6.18.orig/include/asm-powerpc/cputable.h	2006-11-06 14:54:53.671068648 -0600
+++ linux-2.6.18/include/asm-powerpc/cputable.h	2006-11-09 08:49:41.109157544 -0600
@@ -45,6 +45,7 @@
 	PPC_OPROFILE_POWER4 = 2,
 	PPC_OPROFILE_G4 = 3,
 	PPC_OPROFILE_BOOKE = 4,
+	PPC_OPROFILE_CELL = 5,
 };
 
 struct cpu_spec {
Index: linux-2.6.18/include/asm-powerpc/oprofile_impl.h
===================================================================
--- linux-2.6.18.orig/include/asm-powerpc/oprofile_impl.h	2006-09-19 22:42:06.000000000 -0500
+++ linux-2.6.18/include/asm-powerpc/oprofile_impl.h	2006-11-09 18:48:46.531144568 -0600
@@ -54,6 +54,7 @@
 extern struct op_powerpc_model op_model_rs64;
 extern struct op_powerpc_model op_model_power4;
 extern struct op_powerpc_model op_model_7450;
+extern struct op_powerpc_model op_model_cell;
 
 #ifndef CONFIG_FSL_BOOKE
 
Index: linux-2.6.18/arch/powerpc/configs/cell_defconfig
===================================================================
--- linux-2.6.18.orig/arch/powerpc/configs/cell_defconfig	2006-11-06 14:54:56.464044264 -0600
+++ linux-2.6.18/arch/powerpc/configs/cell_defconfig	2006-11-09 12:39:30.844173528 -0600
@@ -1102,7 +1102,8 @@
 #
 # Instrumentation Support
 #
-# CONFIG_PROFILING is not set
+CONFIG_PROFILING=y
+CONFIG_OPROFILE=y
 # CONFIG_KPROBES is not set
 
 #

--------------000108080508050307010101--

