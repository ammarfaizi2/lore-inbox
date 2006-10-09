Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751884AbWJIONb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884AbWJIONb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 10:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932882AbWJIOLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 10:11:45 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:55807 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S932866AbWJIOLD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 10:11:03 -0400
Date: Mon, 9 Oct 2006 07:10:26 -0700
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200610091410.k99EAQHh026233@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 18/21] 2.6.18 perfmon2 : new powerpc files
Cc: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@frankl.hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the new files for powerpc.

The files are as follows:


arch/powerpc/perfmon/Kconfig:
	- add menuconfig options

arch/powerpc/perfmon/Makefile:
	- makefile for arch specific files

arch/powerpc/perfmon/perfmon.c:
	- architecture specific perfmon support. Implements architecrure specific
	  operations such as save/restore/start/stop/detect overflow counters, ...

arch/powerpc/perfmon/perfmon_power5.c:
	- PMU description table for Power 5

include/asm-powerpc/perfmon.h:
	- architecture specific header definitions



--- linux-2.6.18.base/arch/powerpc/perfmon/Kconfig	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.18/arch/powerpc/perfmon/Kconfig	2006-09-22 01:59:06.000000000 -0700
@@ -0,0 +1,17 @@
+menu "Hardware Performance Monitoring support"
+config PERFMON
+	bool "Perfmon2 performance monitoring interface"
+	default n
+	help
+  	Enables the perfmon2 interface to access the hardware
+	performance counters. See <http://perfmon2.sf.net/> for
+ 	more details.
+
+config PERFMON_POWER5
+	tristate "Support for Power5 hardware performance counters"
+	depends on PERFMON
+	default n
+	help
+	Enables support for the Power 5 hardware performance counters
+	If unsure, say M.
+endmenu
--- linux-2.6.18.base/arch/powerpc/perfmon/Makefile	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.18/arch/powerpc/perfmon/Makefile	2006-09-22 01:59:06.000000000 -0700
@@ -0,0 +1,2 @@
+obj-$(CONFIG_PERFMON)		+= perfmon.o
+obj-$(CONFIG_PERFMON_POWER5)	+= perfmon_power5.o
--- linux-2.6.18.base/arch/powerpc/perfmon/perfmon.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.18/arch/powerpc/perfmon/perfmon.c	2006-09-25 12:14:50.000000000 -0700
@@ -0,0 +1,298 @@
+/*
+ * This file implements the ppc64 specific
+ * support for the perfmon2 interface
+ *
+ * Copyright (c) 2005 David Gibson, IBM Corporation.
+ *
+ * based on versions for other architectures:
+ * Copyright (c) 2005-2006 Hewlett-Packard Development Company, L.P.
+ * Contributed by Stephane Eranian <eranian@hpl.hp.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+ * 02111-1307 USA
+  */
+#include <linux/interrupt.h>
+#include <linux/perfmon.h>
+
+/*
+ * collect pending overflowed PMDs. Called from pfm_ctxsw()
+ * and from PMU interrupt handler. Must fill in set->povfl_pmds[]
+ * and set->npend_ovfls. Interrupts are masked
+ */
+static void __pfm_get_ovfl_pmds(struct pfm_context *ctx,
+				struct pfm_event_set *set)
+{
+	u64 new_val, wmask;
+	unsigned long *used_mask;
+	unsigned int i, max;
+
+	max = pfm_pmu_conf->max_cnt_pmd;
+	used_mask = set->used_pmds;
+	wmask = PFM_ONE_64 << pfm_pmu_conf->counter_width;
+
+	for (i = 0; i < max; i++) {
+		/* assume all PMD are counters */
+		if (pfm_bv_isset(used_mask, i)) {
+			new_val = pfm_arch_read_pmd(ctx, i);
+
+			PFM_DBG_ovfl("pmd%u new_val=0x%lx bit=%d",
+				     i, new_val, (new_val&wmask) ? 1 : 0);
+
+			if ((new_val & wmask) == 0) {
+				pfm_bv_set(set->povfl_pmds, i);
+				set->npend_ovfls++;
+			}
+		}
+	}
+}
+
+/*
+ * Called from pfm_ctxsw(). Task is guaranteed to be current.
+ * Context is locked. Interrupts are masked. Monitoring is active.
+ * PMU access is guaranteed. PMC and PMD registers are live in PMU.
+ *
+ * for per-thread:
+ * 	must stop monitoring for the task
+ * Return:
+ * 	non-zero : did not save PMDs (as part of stopping the PMU)
+ * 	       0 : saved PMDs (no need to save them in caller)
+ */
+int pfm_arch_ctxswout_thread(struct task_struct *task, struct pfm_context *ctx,
+		       	      struct pfm_event_set *set)
+{
+	mtspr(SPRN_MMCR0, MMCR0_FC);
+
+	/*
+	 * disable lazy restore of PMC registers.
+	 */
+	if (set)
+		set->priv_flags |= PFM_SETFL_PRIV_MOD_PMCS;
+
+	__pfm_get_ovfl_pmds(ctx, set);
+
+	return 1;
+}
+
+/*
+ * Called from pfm_stop() and pfm_ctxsw() when idle
+ * task and EXCL_IDLE is on.
+ *
+ * Interrupts are masked. Context is locked. Set is the active set.
+ *
+ * For per-thread:
+ *   task is not necessarily current. If not current task, then
+ *   task is guaranteed stopped and off any cpu. Access to PMU
+ *   is not guaranteed. Interrupts are masked. Context is locked.
+ *   Set is the active set.
+ *
+ * For system-wide:
+ * 	task is current
+ *
+ * must disable active monitoring.
+ */
+void pfm_arch_stop(struct task_struct *task, struct pfm_context *ctx,
+		struct pfm_event_set *aset)
+{
+	if (task != current)
+		return;
+
+	mtspr(SPRN_MMCR0, MMCR0_FC);
+}
+
+/*
+ * function called from pfm_unload_context_*(). Context is locked.
+ * interrupts are masked. task is not guaranteed to be current task.
+ * Access to PMU is not guaranteed.
+ *
+ * function must do whatever arch-specific action is required on unload
+ * of a context.
+ *
+ * called for both system-wide and per-thread. task is NULL for ssytem-wide
+ */
+void pfm_arch_unload_context(struct pfm_context *ctx, struct task_struct *task)
+{
+}
+
+/*
+ * called from pfm_start() or pfm_ctxsw() when idle task and
+ * EXCL_IDLE is on.
+ *
+ * Interrupts are masked. Context is locked. Set is the active set.
+ *
+ * For per-trhead:
+ * 	Task is not necessarily current. If not current task, then task
+ * 	is guaranteed stopped and off any cpu. Access to PMU is not guaranteed.
+ *
+ * For system-wide:
+ * 	task is always current
+ *
+ * must enable active monitoring.
+ */
+static void __pfm_arch_start(struct task_struct *task, struct pfm_context *ctx,
+			     struct pfm_event_set *set)
+{
+	if (task != current)
+		return;
+
+	mtspr(SPRN_MMCR0, set->pmcs[0]);
+	mtspr(SPRN_MMCR1, set->pmcs[1]);
+	mtspr(SPRN_MMCRA, set->pmcs[2]);
+}
+
+void pfm_arch_start(struct task_struct *task, struct pfm_context *ctx,
+		    struct pfm_event_set *set)
+{
+	/*
+	 * mask/unmask uses start/stop mechanism, so we cannot allow
+	 * while masked.
+	 */
+	if (ctx->state == PFM_CTX_MASKED)
+		return;
+
+	__pfm_arch_start(task, ctx, set);
+}
+
+/*
+ * function called from pfm_switch_sets(), pfm_context_load_thread(),
+ * pfm_context_load_sys(), pfm_ctxsw(), pfm_switch_sets()
+ * context is locked. Interrupts are masked. set cannot be NULL.
+ * Access to the PMU is guaranteed.
+ *
+ * function must restore all PMD registers from set.
+ */
+void pfm_arch_restore_pmds(struct pfm_context *ctx, struct pfm_event_set *set)
+{
+	u64 ovfl_mask, val, *pmds;
+	unsigned long *impl_rw_mask, *cnt_mask;
+	u16 i, max_rw_pmd;
+
+	max_rw_pmd = pfm_pmu_conf->max_rw_pmd;
+	cnt_mask = pfm_pmu_conf->cnt_pmds;
+	ovfl_mask = pfm_pmu_conf->ovfl_mask;
+	impl_rw_mask = pfm_pmu_conf->impl_rw_pmds;
+	pmds = set->view->set_pmds;
+
+	/* start at 1 to skip TB */
+	for (i = 1; i < max_rw_pmd; i++) {
+		if (likely(pfm_bv_isset(impl_rw_mask, i))) {
+			val = pmds[i];
+			if (likely(pfm_bv_isset(cnt_mask, i)))
+				val &= ovfl_mask;
+			pfm_arch_write_pmd(ctx, i, val);
+		}
+	}
+}
+
+/*
+ * function called from pfm_switch_sets(), pfm_context_load_thread(),
+ * pfm_context_load_sys(), pfm_ctxsw(), pfm_switch_sets()
+ * context is locked. Interrupts are masked. set cannot be NULL.
+ * Access to the PMU is guaranteed.
+ *
+ * function must restore all PMC registers from set, if needed.
+ */
+void pfm_arch_restore_pmcs(struct pfm_context *ctx, struct pfm_event_set *set)
+{
+	u16 i, num_cnt;
+
+	num_cnt = pfm_pmu_conf->num_pmcs;
+
+	/*
+	 * - by default, no PMC measures anything
+	 * - on ctxswout, all used PMCs are disabled (cccr cleared)
+	 *
+	 * we need to restore the PMC (incl enable bits) only if
+	 * not masked and user issued pfm_start()
+	 */
+	if (ctx->state == PFM_CTX_MASKED || ctx->flags.started == 0)
+		return;
+
+	/*
+	 * restore all pmcs
+	 */
+	for (i = 0; i < num_cnt; i++)
+		pfm_arch_write_pmc(ctx, i, set->pmcs[i]);
+}
+
+asmlinkage void pfm_intr_handler(struct pt_regs *regs)
+{
+	pfm_interrupt_handler(instruction_pointer(regs), regs);
+}
+	
+extern void ppc64_enable_pmcs(void);
+
+void pfm_arch_init_percpu(void)
+{
+	ppc64_enable_pmcs();
+}
+/*
+ * called from __pfm_interrupt_handler(). ctx is not NULL.
+ * ctx is locked. PMU interrupt is masked.
+ *
+ * must stop all monitoring to ensure handler has consistent view.
+ * must collect overflowed PMDs bitmask  into povfls_pmds and
+ * npend_ovfls. If no interrupt detected then npend_ovfls
+ * must be set to zero.
+ */
+void pfm_arch_intr_freeze_pmu(struct pfm_context *ctx)
+{
+	mtspr(SPRN_MMCR0, MMCR0_FC);
+	__pfm_get_ovfl_pmds(ctx, ctx->active_set);
+}
+
+/*
+ * unfreeze PMU from pfm_do_interrupt_handler()
+ * ctx may be NULL for spurious
+ */
+void pfm_arch_intr_unfreeze_pmu(struct pfm_context *ctx)
+{
+	if (! ctx)
+		return;
+	pfm_arch_restore_pmcs(ctx, ctx->active_set);
+}
+
+void pfm_arch_mask_monitoring(struct pfm_context *ctx)
+{
+	mtspr(SPRN_MMCR0, MMCR0_FC);
+}
+
+void pfm_arch_unmask_monitoring(struct pfm_context *ctx)
+{
+	/*
+	 * on ppc64 masking/unmasking uses start/stop
+	 * mechanism
+	 */
+	__pfm_arch_start(current, ctx, ctx->active_set);
+}
+
+/*
+ * invoked from arch/ppc64/kernel.entry.S
+ */
+void ppc64_pfm_handle_work(void)
+{
+	pfm_handle_work();
+}
+
+char *pfm_arch_get_pmu_module_name(void)
+{
+	unsigned long pvr = mfspr(SPRN_PVR);
+
+	/*
+	 * XXX: ought to be something cleaner from cpu_data
+	 */
+	if (PVR_VER(pvr) == PV_POWER5)
+		return "perfmon_power5";
+
+	return NULL;
+}
--- linux-2.6.18.base/arch/powerpc/perfmon/perfmon_power5.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.18/arch/powerpc/perfmon/perfmon_power5.c	2006-09-25 12:15:22.000000000 -0700
@@ -0,0 +1,86 @@
+/*
+ * This file contains the POWER4 PMU register description tables
+ * and pmc checker used by perfmon.c.
+ *
+ * Copyright (c) 2005 David Gibson, IBM Corporation.
+ *
+ * Based on perfmon_p6.c:
+ * Copyright (c) 2005-2006 Hewlett-Packard Development Company, L.P.
+ * Contributed by Stephane Eranian <eranian@hpl.hp.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+ * 02111-1307 USA
+  */
+#include <linux/module.h>
+#include <linux/perfmon.h>
+
+MODULE_AUTHOR("David Gibson <dwg@au1.ibm.com>");
+MODULE_DESCRIPTION("POWER4 PMU description table");
+MODULE_LICENSE("GPL");
+
+static struct pfm_reg_desc pfm_power5_pmc_desc[]={
+/* mmcr0 */ PMC_D(PFM_REG_I, "MMCR0", MMCR0_FC, 0, 0, 0),
+/* mmcr1 */ PMC_D(PFM_REG_I, "MMCR1", 0x0, 0, 0, 0),
+/* mmcra */ PMC_D(PFM_REG_I, "MMCRA", 0x0, 0, 0, 0)
+};
+#define PFM_PM_NUM_PMCS	(sizeof(pfm_power5_pmc_desc)/sizeof(struct pfm_reg_desc))
+
+static struct pfm_reg_desc pfm_power5_pmd_desc[]={
+/* tb    */ PMD_D(PFM_REG_C, "TB"  , 0), /* rsvd_msk = -1 */
+/* pmd1  */ PMD_D(PFM_REG_C, "PMC1", 0),
+/* pmd2  */ PMD_D(PFM_REG_C, "PMC2", 0),
+/* pmd3  */ PMD_D(PFM_REG_C, "PMC3", 0),
+/* pmd4  */ PMD_D(PFM_REG_C, "PMC4", 0),
+/* pmd5  */ PMD_D(PFM_REG_C, "PMC5", 0),
+/* pmd6  */ PMD_D(PFM_REG_C, "PMC6", 0)
+};
+#define PFM_PM_NUM_PMDS	(sizeof(pfm_power5_pmd_desc)/sizeof(struct pfm_reg_desc))
+
+static int pfm_power5_probe_pmu(void)
+{
+	unsigned long pvr = mfspr(SPRN_PVR);
+
+	if (PVR_VER(pvr) != PV_POWER5)
+		return -1;
+
+	return 0;
+}
+
+/*
+ * impl_pmcs, impl_pmds are computed at runtime to minimize errors!
+ */
+static struct pfm_pmu_config pfm_power5_pmu_conf = {
+	.pmu_name = "POWER5",
+	.counter_width = 31,
+	.pmd_desc = pfm_power5_pmd_desc,
+	.pmc_desc = pfm_power5_pmc_desc,
+	.num_pmc_entries = PFM_PM_NUM_PMCS,
+	.num_pmd_entries = PFM_PM_NUM_PMDS,
+	.probe_pmu  = pfm_power5_probe_pmu,
+	.flags = PFM_PMU_BUILTIN_FLAG,
+	.owner = THIS_MODULE
+};
+	
+static int __init pfm_power5_pmu_init_module(void)
+{
+	return pfm_pmu_register(&pfm_power5_pmu_conf);
+}
+
+static void __exit pfm_power5_pmu_cleanup_module(void)
+{
+	pfm_pmu_unregister(&pfm_power5_pmu_conf);
+}
+
+module_init(pfm_power5_pmu_init_module);
+module_exit(pfm_power5_pmu_cleanup_module);
--- linux-2.6.18.base/include/asm-powerpc/perfmon.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.18/include/asm-powerpc/perfmon.h	2006-09-25 12:17:41.000000000 -0700
@@ -0,0 +1,278 @@
+/*
+ * Copyright (c) 2005 David Gibson, IBM Corporation.
+ *
+ * Based on other versions:
+ * Copyright (c) 2005 Hewlett-Packard Development Company, L.P.
+ * Contributed by Stephane Eranian <eranian@hpl.hp.com>
+ *
+ * This file contains ppc64 specific definitions for the perfmon
+ * interface.
+ *
+ * This file MUST never be included directly. Use linux/perfmon.h.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+ * 02111-1307 USA
+  */
+#ifndef _ASM_PPC64_PERFMON_H_
+#define _ASM_PPC64_PERFMON_H_
+
+#ifdef __KERNEL__
+
+#define PFM_ARCH_PMD_STK_ARG	1 /* conservative value */
+#define PFM_ARCH_PMC_STK_ARG	1 /* conservative value */
+
+/*
+ * on som PMU models, the upper bits of a counter must be set in order
+ * for the overflow interrupt to happen. On overflow, the counter
+ * has wrapped around, and the upper bits are now cleared. This
+ * function set them back.
+ *
+ * The current version loses whatever is remaining in the counter,
+ * which is usually not zero but has a small count. In order not
+ * to loose this count, we do a read-modify-write to set the upper
+ * bits while preserving the low-order bits. This is slow but
+ * works.
+ */
+static inline void pfm_arch_ovfl_reset_pmd(struct pfm_context *ctx,
+					   unsigned int cnum)
+{}
+
+static inline void pfm_arch_resend_irq(void)
+{}
+
+static inline void pfm_arch_serialize(void)
+{}
+
+
+static inline void pfm_arch_unfreeze_pmu(void)
+{}
+
+static inline void pfm_arch_write_pmc(struct pfm_context *ctx,
+				      unsigned int cnum,
+				      u64 value)
+{
+	switch (cnum) {
+	case 0:
+		mtspr(SPRN_MMCR0, value);
+		break;
+	case 1:
+		mtspr(SPRN_MMCR1, value);
+		break;
+	case 2:
+		mtspr(SPRN_MMCRA, value);
+		break;
+	default:
+		BUG();
+	}
+}
+
+static inline void pfm_arch_write_pmd(struct pfm_context *ctx,
+				      unsigned int cnum, u64 value)
+{
+	switch (cnum) {
+	case 1:
+		mtspr(SPRN_PMC1, value);
+		break;
+	case 2:
+		mtspr(SPRN_PMC2, value);
+		break;
+	case 3:
+		mtspr(SPRN_PMC3, value);
+		break;
+	case 4:
+		mtspr(SPRN_PMC4, value);
+		break;
+	case 5:
+		mtspr(SPRN_PMC5, value);
+		break;
+	case 6:
+		mtspr(SPRN_PMC6, value);
+		break;
+	case 7:
+		mtspr(SPRN_PMC7, value);
+		break;
+	case 8:
+		mtspr(SPRN_PMC8, value);
+		break;
+	default:
+		BUG();
+	}
+}
+
+static inline u64 pfm_arch_read_pmd(struct pfm_context *ctx, unsigned int cnum)
+{
+	switch (cnum) {
+	case 0:
+		return mftb();
+		break;
+	case 1:
+		return mfspr(SPRN_PMC1);
+		break;
+	case 2:
+		return mfspr(SPRN_PMC2);
+		break;
+	case 3:
+		return mfspr(SPRN_PMC3);
+		break;
+	case 4:
+		return mfspr(SPRN_PMC4);
+		break;
+	case 5:
+		return mfspr(SPRN_PMC5);
+		break;
+	case 6:
+		return mfspr(SPRN_PMC6);
+		break;
+	case 7:
+		return mfspr(SPRN_PMC7);
+		break;
+	case 8:
+		return mfspr(SPRN_PMC8);
+		break;
+	default:
+		BUG();
+		return 0;
+	}
+}
+
+static inline u64 pfm_arch_read_pmc(struct pfm_context *ctx, unsigned int cnum)
+{
+	switch (cnum) {
+	case 0:
+		return mfspr(SPRN_MMCR0);
+		break;
+	case 1:
+		return mfspr(SPRN_MMCR1);
+		break;
+	case 2:
+		return mfspr(SPRN_MMCRA);
+		break;
+	default:
+		BUG();
+		return 0;
+	}
+}
+
+/*
+ * At certain points, perfmon needs to know if monitoring has been
+ * explicitely started/stopped by user via pfm_start/pfm_stop. The
+ * information is tracked in flags.started. However on certain
+ * architectures, it may be possible to start/stop directly from
+ * user level with a single assembly instruction bypassing
+ * the kernel. This function must be used to determine by
+ * an arch-specific mean if monitoring is actually started/stopped.
+ * If there is no other way but to go through pfm_start/pfm_stop
+ * then this function can simply return 0
+ */
+static inline int pfm_arch_is_active(struct pfm_context *ctx)
+{
+	return 0;
+}
+
+static inline void pfm_arch_ctxswout_sys(struct task_struct *task,
+		           		 struct pfm_context *ctx,
+					 struct pfm_event_set *set)
+{
+	mtspr(SPRN_MMCR0, MMCR0_FC);
+}
+
+static inline void pfm_arch_ctxswin_sys(struct task_struct *task,
+                       struct pfm_context *ctx, struct pfm_event_set *set)
+{}
+
+static inline void pfm_arch_ctxswin_thread(struct task_struct *task,
+                       struct pfm_context *ctx, struct pfm_event_set *set)
+{}
+
+void pfm_arch_init_percpu(void);
+int  pfm_arch_is_monitoring_active(struct pfm_context *ctx);
+int  pfm_arch_ctxswout_thread(struct task_struct *task, struct pfm_context *ctx,
+			      struct pfm_event_set *set);
+void pfm_arch_stop(struct task_struct *task, struct pfm_context *ctx,
+			  struct pfm_event_set *set);
+void pfm_arch_start(struct task_struct *task, struct pfm_context *ctx,
+			   struct pfm_event_set *set);
+void pfm_arch_restore_pmds(struct pfm_context *ctx, struct pfm_event_set *set);
+void pfm_arch_restore_pmcs(struct pfm_context *ctx, struct pfm_event_set *set);
+int  pfm_arch_get_ovfl_pmds(struct pfm_context *ctx,
+				   struct pfm_event_set *set);
+void pfm_arch_intr_freeze_pmu(struct pfm_context *ctx);
+void pfm_arch_intr_unfreeze_pmu(struct pfm_context *ctx);
+char *pfm_arch_get_pmu_module_name(void);
+void pfm_arch_mask_monitoring(struct pfm_context *ctx);
+void pfm_arch_unmask_monitoring(struct pfm_context *ctx);
+
+static inline int pfm_arch_pmu_config_init(struct pfm_pmu_config *cfg)
+{
+	return 0;
+}
+
+static inline int pfm_arch_context_initialize(struct pfm_context *ctx,
+					       u32 ctx_flags)
+{
+	return 0;
+}
+
+void pfm_arch_unload_context(struct pfm_context *ctx, struct task_struct *task);
+
+static inline int pfm_arch_reserve_session(struct pfm_sessions *session,
+					   struct pfm_context *ctx,
+					   unsigned int cpu)
+{
+	return 0;
+}
+
+static inline void pfm_arch_release_session(struct pfm_sessions *session,
+					    struct pfm_context *ctx,
+					    u32 cpu)
+{}
+
+/*
+ * function called from pfm_setfl_sane(). Context is locked
+ * and interrupts are masked.
+ * The value of flags is the value of ctx_flags as passed by
+ * user.
+ *
+ * function must check arch-specific set flags.
+ * Return:
+ * 	1 when flags are valid
+ *      0 on error
+ */
+static inline int pfm_arch_setfl_sane(struct pfm_context *ctx, u32 flags)
+{
+	return 0;
+}
+
+static inline void pfm_arch_show_session(struct seq_file *m)
+{}
+
+static inline int pfm_arch_init(void)
+{
+	return 0;
+}
+
+static inline int pfm_arch_load_context(struct pfm_context *ctx,
+					struct task_struct *task)
+{
+	return 0;
+}
+
+struct pfm_arch_context {
+	/* empty */
+};
+
+#define PFM_ARCH_CTX_SIZE	sizeof(struct pfm_arch_context)
+
+#endif /* __KERNEL__ */
+#endif /* _ASM_PPC64_PERFMON_H_ */
