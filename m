Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968182AbWLELKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968182AbWLELKm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 06:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968118AbWLELKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 06:10:06 -0500
Received: from madara.hpl.hp.com ([192.6.19.124]:64915 "EHLO madara.hpl.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759956AbWLELJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 06:09:21 -0500
Date: Tue, 5 Dec 2006 03:07:19 -0800
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200612051107.kB5B7JH8017690@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 18/21] 2.6.19 perfmon2 : new powerpc files
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

arch/powerpc/perfmon/perfmon_ppc32.c:
	- PMU description table for32-bit PowerPC

include/asm-powerpc/perfmon.h:
	- architecture specific header definitions



--- linux-2.6.19.base/arch/powerpc/perfmon/Kconfig	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.19/arch/powerpc/perfmon/Kconfig	2006-12-03 14:15:48.000000000 -0800
@@ -0,0 +1,32 @@
+menu "Hardware Performance Monitoring support"
+config PERFMON
+	bool "Perfmon2 performance monitoring interface"
+	default n
+	help
+  	Enables the perfmon2 interface to access the hardware
+	performance counters. See <http://perfmon2.sf.net/> for
+ 	more details.
+
+config PERFMON_DEBUG
+ 	bool "Perfmon debugging"
+	default n
+	depends on PERFMON
+ 	help
+  	Enables perfmon debugging support
+
+config PERFMON_POWER5
+	tristate "Support for Power5 hardware performance counters"
+	depends on PERFMON
+	default n
+	help
+	Enables support for the Power 5 hardware performance counters
+	If unsure, say M.
+
+config PERFMON_PPC32
+	tristate "Support for PPC32 hardware performance counters"
+	depends on PERFMON
+	default n
+	help
+	Enables support for the PPC32 hardware performance counters
+	If unsure, say M.
+endmenu
--- linux-2.6.19.base/arch/powerpc/perfmon/Makefile	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.19/arch/powerpc/perfmon/Makefile	2006-12-03 14:15:48.000000000 -0800
@@ -0,0 +1,3 @@
+obj-$(CONFIG_PERFMON)		+= perfmon.o
+obj-$(CONFIG_PERFMON_POWER5)	+= perfmon_power5.o
+obj-$(CONFIG_PERFMON_PPC32)	+= perfmon_ppc32.o
--- linux-2.6.19.base/arch/powerpc/perfmon/perfmon.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.19/arch/powerpc/perfmon/perfmon.c	2006-12-03 14:15:48.000000000 -0800
@@ -0,0 +1,358 @@
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
+	wmask = 1ULL << pfm_pmu_conf->counter_width;
+
+	for (i = 0; i < max; i++) {
+		/* assume all PMD are counters */
+		if (pfm_bv_isset(used_mask, i)) {
+			new_val = pfm_arch_read_pmd(ctx, i);
+
+			PFM_DBG_ovfl("pmd%u new_val=0x%lx bit=%d",
+				     i, new_val, (new_val&wmask) ? 1 : 0);
+
+			if (!(new_val & wmask)) {
+				pfm_bv_set(set->povfl_pmds, i);
+				set->npend_ovfls++;
+			}
+		}
+	}
+}
+
+static void pfm_stop_active(struct task_struct *task, struct pfm_context *ctx,
+			    struct pfm_event_set *set)
+{
+	unsigned int i, max;
+
+	max = pfm_pmu_conf->max_pmc;
+	/*
+	 * clear enable bits
+	 */
+	for (i = 0; i < max; i++) {
+		if (pfm_bv_isset(set->used_pmcs, i))
+			pfm_arch_write_pmc(ctx, i,0);
+	}
+
+	if (set->npend_ovfls)
+		return;
+
+	__pfm_get_ovfl_pmds(ctx, set);
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
+	/*
+	 * disable lazy restore of PMC registers.
+	 */
+	set->priv_flags |= PFM_SETFL_PRIV_MOD_PMCS;
+
+	pfm_stop_active(task, ctx, set);
+
+	return 1;
+}
+
+/*
+ * Called from pfm_stop() and idle notifier
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
+		struct pfm_event_set *set)
+{
+	/*
+	 * stop live registers and collect pending overflow
+	 */
+	if (task == current)
+		pfm_stop_active(task, ctx, set);
+}
+
+static void __pfm_arch_start(struct task_struct *task, struct pfm_context *ctx,
+		    struct pfm_event_set *set)
+{
+	unsigned int i, max_pmc;
+
+	if (task != current)
+		return;
+
+	max_pmc = pfm_pmu_conf->max_pmc;
+
+	for (i = 0; i < max_pmc; i++) {
+		if (pfm_bv_isset(set->used_pmcs, i))
+		    pfm_arch_write_pmc(ctx, i, set->pmcs[i]);
+	}
+}
+
+/*
+ * called from pfm_start() and idle notifier
+ *
+ * Interrupts are masked. Context is locked. Set is the active set.
+ *
+ * For per-thread:
+ * 	Task is not necessarily current. If not current task, then task
+ * 	is guaranteed stopped and off any cpu. No access to PMU is task
+ *	is not current.
+ *
+ * For system-wide:
+ * 	task is always current
+ *
+ * must enable active monitoring.
+ */
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
+	u64 *impl_pmds;
+	unsigned int i;
+	unsigned int max_pmd;
+
+	max_pmd = pfm_pmu_conf->max_pmd;
+	ovfl_mask = pfm_pmu_conf->ovfl_mask;
+	impl_pmds = pfm_pmu_conf->impl_pmds;
+	pmds = set->view->set_pmds;
+
+	/*
+	 * must restore all pmds to avoid leaking
+	 * information to user.
+	 */
+	for (i = 0; i < max_pmd; i++) {
+
+		if (pfm_bv_isset(impl_pmds, i) == 0)
+			continue;
+
+		val = pmds[i];
+
+		/*
+		 * set upper bits for counter to ensure
+		 * overflow will trigger
+		 */
+		val &= ovfl_mask;
+
+		pfm_arch_write_pmd(ctx, i, val);
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
+	u64 *impl_pmcs;
+	unsigned int i, max_pmc;
+
+	max_pmc = pfm_pmu_conf->max_pmc;
+	impl_pmcs = pfm_pmu_conf->impl_pmcs;
+
+	/*
+	 * - by default no PMCS measures anything
+	 * - on ctxswout, all used PMCs are disabled (cccr enable bit cleared)
+	 * hence when masked we do not need to restore anything
+	 */
+	if (ctx->state == PFM_CTX_MASKED || ctx->flags.started == 0)
+		return;
+
+	/*
+	 * restore all pmcs
+	 */
+	for (i = 0; i < max_pmc; i++)
+		if (pfm_bv_isset(impl_pmcs, i))
+			pfm_arch_write_pmc(ctx, i, set->pmcs[i]);
+}
+
+#if 0
+asmlinkage void pfm_intr_handler(struct pt_regs *regs)
+{
+	pfm_interrupt_handler(instruction_pointer(regs), regs);
+}
+#endif
+	
+extern void ppc64_enable_pmcs(void);
+
+void pfm_arch_init_percpu(void)
+{
+#ifdef CONFIG_PPC64
+	ppc64_enable_pmcs();
+#endif
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
+	/*
+	 * if pfm_pmu_conf is NULL then ctx is NULL
+	 * so we are covered for both here.
+	 */
+	if (pfm_pmu_conf == NULL)
+		return;
+
+	pfm_stop_active(current, ctx, ctx->active_set);
+}
+
+/*
+ * unfreeze PMU from pfm_do_interrupt_handler()
+ * ctx may be NULL for spurious
+ */
+void pfm_arch_intr_unfreeze_pmu(struct pfm_context *ctx)
+{
+	if (!ctx)
+		return;
+	pfm_arch_restore_pmcs(ctx, ctx->active_set);
+}
+
+void pfm_arch_mask_monitoring(struct pfm_context *ctx)
+{
+	/*
+	 * on ppc64 masking/unmasking uses start/stop
+	 * mechanism
+	 */
+  	pfm_arch_stop(current, ctx, ctx->active_set);
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
+#if 0
+/*
+ * invoked from arch/ppc64/kernel.entry.S
+ */
+void ppc64_pfm_handle_work(void)
+{
+	pfm_handle_work();
+}
+#endif
+
+char *pfm_arch_get_pmu_module_name(void)
+{
+  unsigned int pvr = mfspr(SPRN_PVR);
+
+  switch (PVR_VER(pvr))
+    {
+    case 0x0004: /* 604 */
+    case 0x0009: /* 604e;  */
+    case 0x000A: /* 604ev */
+    case 0x0008: /* 750/740 */
+    case 0x7000: /* 750FX */
+    case 0x7001:
+    case 0x7002: /* 750GX */
+    case 0x000C: /* 7400 */
+    case 0x800C: /* 7410 */
+    case 0x8000: /* 7451/7441 */
+    case 0x8001: /* 7455/7445 */
+    case 0x8002: /* 7457/7447 */
+    case 0x8003: /* 7447A */
+    case 0x8004: /* 7448 */
+      return("perfmon_ppc32");
+    case PV_POWER4:
+    case PV_POWER4p:
+      return "perfmon_power4";
+    case PV_POWER5:
+    case PV_POWER5p:
+      return "perfmon_power5";
+    case PV_970:
+    case PV_970FX:
+    case PV_970MP:
+      return "perfmon_ppc970";
+    case PV_BE:
+      return "perfmon_cell";
+    }
+  return NULL;
+}
--- linux-2.6.19.base/arch/powerpc/perfmon/perfmon_power5.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.19/arch/powerpc/perfmon/perfmon_power5.c	2006-12-03 14:15:48.000000000 -0800
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
--- linux-2.6.19.base/arch/powerpc/perfmon/perfmon_ppc32.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.19/arch/powerpc/perfmon/perfmon_ppc32.c	2006-12-03 14:15:48.000000000 -0800
@@ -0,0 +1,206 @@
+/*
+ * This file contains the PPC32 PMU register description tables
+ * and pmc checker used by perfmon.c.
+ *
+ * Philip Mucci, mucci@cs.utk.edu
+ * 
+ * Based on code from:
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
+MODULE_AUTHOR("Philip Mucci <mucci@cs.utk.edu>");
+MODULE_DESCRIPTION("PPC32 PMU description table");
+MODULE_LICENSE("GPL");
+
+struct pfm_arch_pmu_info pfm_ppc32_pmu_info={
+  .pmu_style = PM_NONE,
+};
+
+static struct pfm_pmu_config pfm_ppc32_pmu_conf;
+
+static struct pfm_reg_desc pfm_ppc32_pmc_desc[]={
+/* mmcr0 */ PMC_D(PFM_REG_I, "MMCR0", 0x0, 0, 0, SPRN_MMCR0),
+/* mmcr1 */ PMC_D(PFM_REG_I, "MMCR1", 0x0, 0, 0, SPRN_MMCR1),
+/* mmcra */ PMC_D(PFM_REG_I, "MMCRA", 0x0, 0, 0, SPRN_MMCRA)
+};
+#define PFM_PM_NUM_PMCS	(sizeof(pfm_ppc32_pmc_desc)/sizeof(struct pfm_reg_desc))
+
+static struct pfm_reg_desc pfm_ppc32_pmd_desc[]={
+/* pmd0  */ PMD_D(PFM_REG_C, "PMC1", SPRN_PMC1),
+/* pmd1  */ PMD_D(PFM_REG_C, "PMC2", SPRN_PMC2),
+/* pmd2  */ PMD_D(PFM_REG_C, "PMC3", SPRN_PMC3),
+/* pmd3  */ PMD_D(PFM_REG_C, "PMC4", SPRN_PMC4),
+/* pmd4  */ PMD_D(PFM_REG_C, "PMC5", SPRN_PMC5),
+/* pmd5  */ PMD_D(PFM_REG_C, "PMC6", SPRN_PMC6)
+};
+#define PFM_PM_NUM_PMDS	(sizeof(pfm_ppc32_pmd_desc)/sizeof(struct pfm_reg_desc))
+
+static void perfmon_perf_irq(struct pt_regs *regs) 
+{
+  /* BLATANTLY STOLEN FROM OPROFILE, then modified */
+
+  /* set the PMM bit (see comment below) */
+  mtmsr(mfmsr() | MSR_PMM);
+  
+  pfm_interrupt_handler(instruction_pointer(regs),regs);
+
+  /* The freeze bit was set by the interrupt. */
+  /* Clear the freeze bit, and reenable the interrupt.
+   * The counters won't actually start until the rfi clears
+   * the PMM bit */
+  
+
+  /* Unfreezes the counters on this CPU, enables the interrupt,
+   * enables the counters to trigger the interrupt, and sets the
+   * counters to only count when the mark bit is not set.
+   */
+  {
+    u32 mmcr0 = mfspr(SPRN_MMCR0);
+    
+    mmcr0 &= ~(MMCR0_FC | MMCR0_FCM0);
+    mmcr0 |= (MMCR0_FCECE | MMCR0_PMC1CE | MMCR0_PMCjCE | MMCR0_PMXE);
+    
+    mtspr(SPRN_MMCR0, mmcr0);
+  }
+}
+
+static int pfm_ppc32_probe_pmu(void)
+{
+	enum ppc32_pmu_type pm_type;
+	int nmmcr = 0, npmds = 0, intsok = 0, i;
+	unsigned int pvr;
+	char *str;
+
+	pvr = mfspr(SPRN_PVR);
+
+	switch (PVR_VER(pvr)) {
+	case 0x0004: /* 604 */
+		str = "PPC604";
+		pm_type = PM_604;
+		nmmcr = 1;
+		npmds = 2;
+		break;
+	case 0x0009: /* 604e;  */
+	case 0x000A: /* 604ev */
+		str = "PPC604e";
+		pm_type = PM_604e;
+		nmmcr = 2;
+		npmds = 4;
+		break;
+	case 0x0008: /* 750/740 */
+		str = "PPC750";
+		pm_type = PM_750;
+		nmmcr = 2;
+		npmds = 4;
+		break;
+	case 0x7000: /* 750FX */
+	case 0x7001:
+		str = "PPC750";
+		pm_type = PM_750;
+		nmmcr = 2;
+		npmds = 4;
+		if ((pvr & 0xFF0F) >= 0x0203)
+			intsok = 1;
+		break;
+	case 0x7002: /* 750GX */
+		str = "PPC750";
+		pm_type = PM_750;
+		nmmcr = 2;
+		npmds = 4;
+		intsok = 1;
+	case 0x000C: /* 7400 */
+		str = "PPC7400";
+		pm_type = PM_7400;
+		nmmcr = 3;
+		npmds = 4;
+		break;
+	case 0x800C: /* 7410 */
+		str = "PPC7410";
+		pm_type = PM_7400;
+		nmmcr = 3;
+		npmds = 4;
+		if ((pvr & 0xFFFF) >= 0x01103)
+			intsok = 1;
+		break;
+	case 0x8000: /* 7451/7441 */
+	case 0x8001: /* 7455/7445 */
+	case 0x8002: /* 7457/7447 */
+	case 0x8003: /* 7447A */
+	case 0x8004: /* 7448 */
+		str = "PPC7450";
+		pm_type = PM_7450;
+		nmmcr = 3; npmds = 6;
+		intsok = 1;
+		break;
+	default:
+		PFM_INFO("Unknown PVR_VER(0x%x)\n",PVR_VER(pvr));
+		return -1;
+	}
+
+	/*
+	 * deconfigure unimplemented registers
+	 */
+	for(i=npmds; i < PFM_PM_NUM_PMDS; i++)
+		pfm_ppc32_pmd_desc[i].type = PFM_REG_NA;
+
+	for(i=nmmcr; i < PFM_PM_NUM_PMCS; i++)
+		pfm_ppc32_pmc_desc[i].type = PFM_REG_NA;
+
+	/*
+	 * update PMU description structure
+	 */
+	pfm_ppc32_pmu_conf.pmu_name = str;
+	pfm_ppc32_pmu_info.pmu_style = pm_type;
+	pfm_ppc32_pmu_conf.num_pmc_entries = nmmcr;
+	pfm_ppc32_pmu_conf.num_pmd_entries = npmds;
+
+	if (intsok == 0)
+		PFM_INFO("Interrupts unlikely to work\n");
+
+	return reserve_pmc_hardware(perfmon_perf_irq);
+}
+
+static struct pfm_pmu_config pfm_ppc32_pmu_conf = {
+	.counter_width = 31,
+	.pmd_desc = pfm_ppc32_pmd_desc,
+	.pmc_desc = pfm_ppc32_pmc_desc,
+	.probe_pmu  = pfm_ppc32_probe_pmu,
+	.flags = PFM_PMU_BUILTIN_FLAG,
+	.owner = THIS_MODULE,
+	.version = "0.1",
+	.arch_info = &pfm_ppc32_pmu_info
+};
+	
+static int __init pfm_ppc32_pmu_init_module(void)
+{
+	return pfm_pmu_register(&pfm_ppc32_pmu_conf);
+}
+
+static void __exit pfm_ppc32_pmu_cleanup_module(void)
+{
+  release_pmc_hardware();
+  pfm_pmu_unregister(&pfm_ppc32_pmu_conf);
+}
+
+module_init(pfm_ppc32_pmu_init_module);
+module_exit(pfm_ppc32_pmu_cleanup_module);
--- linux-2.6.19.base/include/asm-powerpc/perfmon.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.19/include/asm-powerpc/perfmon.h	2006-12-03 14:15:48.000000000 -0800
@@ -0,0 +1,296 @@
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
+#include <asm/pmc.h>
+
+enum ppc32_pmu_type {
+	PM_NONE,
+	PM_604,
+	PM_604e,
+	PM_750,	/* XXX: Minor event set diffs between IBM and Moto. */
+	PM_7400,
+	PM_7450,
+};
+
+struct pfm_arch_pmu_info {
+	enum ppc32_pmu_type pmu_style;
+};
+
+#ifdef CONFIG_PPC32
+#define PFM_ARCH_PMD_STK_ARG	6 /* conservative value */
+#define PFM_ARCH_PMC_STK_ARG	6 /* conservative value */
+#else
+#define PFM_ARCH_PMD_STK_ARG	8 /* conservative value */
+#define PFM_ARCH_PMC_STK_ARG	8 /* conservative value */
+#endif
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
+	/*
+	 * we only write to the actual register when monitoring is
+	 * active (pfm_start was issued)
+	 */
+	if (ctx && (ctx->flags.started == 0))
+		return;
+
+  	switch(pfm_pmu_conf->pmc_desc[cnum].hw_addr) {
+	case SPRN_MMCR0:
+		mtspr(SPRN_MMCR0, value);
+		break;
+	case SPRN_MMCR1:
+		mtspr(SPRN_MMCR1, value);
+		break;
+	case SPRN_MMCRA:
+		mtspr(SPRN_MMCRA, value);
+		break;
+	default:
+		BUG();
+	}
+}
+
+static inline u64 pfm_arch_read_pmc(struct pfm_context *ctx, unsigned int cnum)
+{
+	switch(pfm_pmu_conf->pmc_desc[cnum].hw_addr) {
+	case SPRN_MMCR0:
+		return mfspr(SPRN_MMCR0);
+	case SPRN_MMCR1:
+		return mfspr(SPRN_MMCR1);
+	case SPRN_MMCRA:
+		return mfspr(SPRN_MMCRA);
+	default:
+		BUG();
+	}
+}
+
+
+static inline void pfm_arch_write_pmd(struct pfm_context *ctx,
+				      unsigned int cnum, u64 value)
+{
+  	value &= pfm_pmu_conf->ovfl_mask;
+
+	switch(pfm_pmu_conf->pmd_desc[cnum].hw_addr) {
+	case SPRN_PMC1:
+		mtspr(SPRN_PMC1, value);
+		break;
+	case SPRN_PMC2:
+		mtspr(SPRN_PMC2, value);
+		break;
+	case SPRN_PMC3:
+		mtspr(SPRN_PMC3, value);
+		break;
+	case SPRN_PMC4:
+		mtspr(SPRN_PMC4, value);
+		break;
+	case SPRN_PMC5:
+		mtspr(SPRN_PMC5, value);
+		break;
+	case SPRN_PMC6:
+		mtspr(SPRN_PMC6, value);
+		break;
+	case SPRN_PMC7:
+		mtspr(SPRN_PMC7, value);
+		break;
+	case SPRN_PMC8:
+		mtspr(SPRN_PMC8, value);
+		break;
+	default:
+		BUG();
+	}
+}
+
+static inline u64 pfm_arch_read_pmd(struct pfm_context *ctx, unsigned int cnum)
+{
+	switch(pfm_pmu_conf->pmd_desc[cnum].hw_addr) {
+	case SPRN_PMC1:
+		return mfspr(SPRN_PMC1);
+	case SPRN_PMC2:
+		return mfspr(SPRN_PMC2);
+	case SPRN_PMC3:
+		return mfspr(SPRN_PMC3);
+	case SPRN_PMC4:
+		return mfspr(SPRN_PMC4);
+	case SPRN_PMC5:
+		return mfspr(SPRN_PMC5);
+	case SPRN_PMC6:
+		return mfspr(SPRN_PMC6);
+	case SPRN_PMC7:
+		return mfspr(SPRN_PMC7);
+	case SPRN_PMC8:
+		return mfspr(SPRN_PMC8);
+	default:
+		BUG();
+	}
+}
+
+/*
+ * For some CPUs, the upper bits of a counter must be set in order for the
+ * overflow interrupt to happen. On overflow, the counter has wrapped around,
+ * and the upper bits are cleared. This function may be used to set them back.
+ */
+static inline void pfm_arch_ovfl_reset_pmd(struct pfm_context *ctx,
+					   unsigned int cnum)
+{
+	u64 val;
+
+	val = pfm_arch_read_pmd(ctx, cnum);
+
+	/* This masks out overflow bit 31 */
+	pfm_arch_write_pmd(ctx, cnum, val);
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
+static inline int pfm_arch_pmu_config_init(struct _pfm_pmu_config *cfg)
+{
+	return 0;
+}
+
+static inline void pfm_arch_pmu_config_remove(void)
+{}
+
+static inline int pfm_arch_context_initialize(struct pfm_context *ctx,
+					       u32 ctx_flags)
+{
+	return 0;
+}
+
+static inline void pfm_arch_unload_context(struct pfm_context *ctx, struct task_struct *task)
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
+/*
+ * not applicable to powerpc
+ */
+static inline int pfm_smpl_buffer_alloc_compat(struct pfm_context *ctx,
+					       size_t rsize, struct file *filp)
+{
+	return -EINVAL;
+}
+
+static inline void pfm_arch_idle_notifier_register(void)
+{}
+
+static inline void pfm_arch_idle_notifier_unregister(void)
+{}
+
+struct pfm_arch_context {
+	/* empty */
+};
+
+#define PFM_ARCH_CTX_SIZE	sizeof(struct pfm_arch_context)
+
+#endif /* __KERNEL__ */
+#endif /* _ASM_PPC64_PERFMON_H_ */
