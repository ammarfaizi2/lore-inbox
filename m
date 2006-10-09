Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932881AbWJIOOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932881AbWJIOOo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 10:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932869AbWJIOOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 10:14:16 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:61695 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S932908AbWJIOLe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 10:11:34 -0400
Date: Mon, 9 Oct 2006 07:10:23 -0700
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200610091410.k99EANOW026207@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 16/21] 2.6.18 perfmon2 : new i386 files
Cc: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@frankl.hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the new i386 files


The files are as follows:

arch/i386/perfmon/Kconfig:
	- add menuconfig options

arch/i386/perfmon/Makefile:
	- makefile for arch specific files

arch/i386/perfmon/perfmon.c:
	- architecture specific perfmon support. Implements architecrure specific
	  operations such as save/restore/start/stop/detect overflow counters, handle
	  NMI interrupt, ...

arch/i386/perfmon/perfmon_gen_ia32.c:
	- PMU description table for architectural perfmon, e.g., used by Core Duo/Core Solo

arch/i386/perfmon/perfmon_p4.c:
	- PMU description table for P4 (32 and 64 bit modes)

arch/i386/perfmon/perfmon_p4_pebs_smpl.c:
	- implement 32-bit and 64-bit PEBS sampling format

arch/i386/perfmon/perfmon_p6.c:
	- PMU description table for all P6-based processors, incl Pentium M

include/asm-i386/perfmon.h:
	- architecture specific header definitions

include/asm-i386/perfmon_p4_pebs_smpl.h:
	- public header file for 32-bit AND 64-bit PEBS sampling format




--- linux-2.6.18.base/arch/i386/perfmon/Kconfig	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.18/arch/i386/perfmon/Kconfig	2006-09-22 05:00:15.000000000 -0700
@@ -0,0 +1,49 @@
+menu "Hardware Performance Monitoring support"
+config PERFMON
+  	bool "Perfmon2 performance monitoring interface"
+	select X86_LOCAL_APIC
+	default n
+  	help
+  	Enables the perfmon2 interface to access the hardware
+	performance counters. See <http://perfmon2.sf.net/> for
+ 	more details.
+
+config PERFMON_P6
+	tristate "Support for Intel P6/Pentium M processor hardware performance counters"
+	depends on PERFMON
+	default n
+	help
+	Enables support for Intel P6-style hardware performance counters.
+	To be used for with Intel Pentium III, PentiumPro, Pentium M processors.
+
+config I386_PERFMON_P4
+	tristate "Support for 32-bit Intel Pentium 4/Xeon hardware performance counters"
+	depends on PERFMON
+	default n
+	help
+	Enables support for 32-bit Intel Pentium 4/Xeon hardware performance
+	counters.
+
+config	I386_PERFMON_P4_PEBS
+	tristate "Support for Intel Precise Event-Based Sampling (PEBS)"
+	depends on I386_PERFMON_P4
+	default n
+	help
+	Enables support for 32-bit Precise Event-Based Sampling (PEBS) on the Intel
+	Pentium 4 and Xeon processors which supports it.
+
+config  PERFMON_GEN_IA32
+	tristate "Support for Intel architectural performance counters"
+	depends on PERFMON
+	default n
+	help
+	Enables 32-bit support for Intel architectural performance counters.
+
+config	I386_PERFMON_K8
+	tristate "Support 32-bit mode AMD Athlon64/Opteron64 hardware performance counters"
+	depends on PERFMON
+	default n
+	help
+	Enables support for 32-bit mode AND Althon64/Opterton64 hardware performance counters.
+endmenu
+
--- linux-2.6.18.base/arch/i386/perfmon/Makefile	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.18/arch/i386/perfmon/Makefile	2006-09-22 01:58:48.000000000 -0700
@@ -0,0 +1,12 @@
+#
+# Copyright (c) 2005-2006 Hewlett-Packard Development Company, L.P.
+# Contributed by Stephane Eranian <eranian@hpl.hp.com>
+#
+obj-$(CONFIG_PERFMON)			+= perfmon.o
+obj-$(CONFIG_PERFMON_P6)		+= perfmon_p6.o
+obj-$(CONFIG_I386_PERFMON_P4)		+= perfmon_p4.o
+obj-$(CONFIG_PERFMON_GEN_IA32)		+= perfmon_gen_ia32.o
+obj-$(CONFIG_I386_PERFMON_P4_PEBS)	+= perfmon_p4_pebs_smpl.o
+obj-$(CONFIG_I386_PERFMON_K8)   	+= perfmon_k8.o
+
+perfmon_k8-$(subst m,y,$(CONFIG_I386_PERFMON_K8)) += ../../x86_64/perfmon/perfmon_k8.o
--- linux-2.6.18.base/arch/i386/perfmon/perfmon.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.18/arch/i386/perfmon/perfmon.c	2006-09-26 02:29:41.000000000 -0700
@@ -0,0 +1,837 @@
+/*
+ * This file implements the IA-32/X86-64/EM64T specific
+ * support for the perfmon2 interface
+ *
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
+#include <linux/kprobes.h>
+#include <asm/idle.h>
+#include <asm/nmi.h>
+
+DEFINE_PER_CPU(unsigned long, real_iip);
+
+#define MSR_IA32_PEBS_ENABLE	0x3f1 /* unique per-thread */
+#define MSR_IA32_DS_AREA	0x600 /* unique per-thread */
+
+struct pfm_ds_area {
+	unsigned long	bts_buf_base;
+	unsigned long	bts_index;
+	unsigned long	bts_abs_max;
+	unsigned long	bts_intr_thres;
+	unsigned long	pebs_buf_base;
+	unsigned long	pebs_index;
+	unsigned long	pebs_abs_max;
+	unsigned long	pebs_intr_thres;
+	u64		pebs_cnt_reset;
+};
+
+static int (*pfm_stop_active)(struct task_struct *task,
+			       struct pfm_context *ctx,
+			       struct pfm_event_set *set);
+
+static inline int get_smt_id(void)
+{
+#ifdef CONFIG_SMP
+	int cpu = smp_processor_id();
+	return (cpu != first_cpu(cpu_sibling_map[cpu]));
+#else
+	return 0;
+#endif
+}
+
+void __pfm_write_reg(const struct pfm_arch_ext_reg *xreg, u64 val)
+{
+	u64 pmi;
+	int smt_id;
+	
+	smt_id = get_smt_id();
+	/*
+	 * HT is only supported by P4-style PMU
+	 *
+	 * Adjust for T1 if necessary:
+	 *
+	 * - move the T0_OS/T0_USR bits into T1 slots
+	 * - move the OVF_PMI_T0 bits into T1 slot
+	 *
+	 * The P4/EM64T T1 is cleared by description table.
+	 * User only works with T0.
+	 */
+	if (smt_id) {
+		if (xreg->reg_type & PFM_REGT_ESCR) {
+
+			/* copy T0_USR & T0_OS to T1 */
+			val |= ((val & 0xc) >> 2);
+
+			/* clear bits T0_USR & T0_OS */
+			val &= ~0xc;
+
+		} else if (xreg->reg_type & PFM_REGT_CCCR) {
+			pmi = (val >> 26) & 0x1;
+			if (pmi) {
+				val &=~(1UL<<26);
+				val |= 1UL<<27;
+			}
+		}
+	}
+	
+	if (xreg->addrs[smt_id]) {
+		PFM_DBG(" wrmsrl(0x%lx, 0x%llx)", xreg->addrs[smt_id], (unsigned long long)val);
+		wrmsrl(xreg->addrs[smt_id], val);
+	}
+}
+
+void __pfm_read_reg(const struct pfm_arch_ext_reg *xreg, u64 *val)
+{
+	int smt_id;
+	
+	smt_id = get_smt_id();
+
+	if (likely(xreg->addrs[smt_id])) {
+		rdmsrl(xreg->addrs[smt_id], *val);
+		PFM_DBG(" rdmsrl(0x%lx, 0x%llx)", xreg->addrs[smt_id], (unsigned long long)*val);
+		/*
+		 * HT is only supported by P4-style PMU
+		 *
+		 * move the Tx_OS and Tx_USR bits into
+		 * T0 slots setting the T1 slots to zero
+		 */
+		if (xreg->reg_type & PFM_REGT_ESCR) {
+			if (smt_id)
+				*val |= (((*val) & 0x3) << 2);
+
+			/*
+			 * zero out bits that are reserved
+			 * (including T1_OS and T1_USR)
+			 */
+			*val &= PFM_ESCR_RSVD;
+		}
+	} else
+		 *val = 0;
+}
+
+static void __kprobes __pfm_arch_quiesce_pmu_percpu(void)
+{
+	struct pfm_arch_pmu_info *arch_info;
+	struct pfm_arch_ext_reg *xregs;
+	unsigned int i, num_pmcs;
+
+	BUG_ON(!pfm_pmu_conf);
+
+	num_pmcs = pfm_pmu_conf->num_pmcs;
+	arch_info = pfm_pmu_conf->arch_info;
+	xregs = arch_info->pmc_addrs;
+
+	/*
+	 * quiesce PMU by clearing register that have enable bits
+	 * or start/stop capabilities. Note that enable_mask takes
+	 * into account registers unavailable due to NMI
+	 */
+	for (i = 0; i < num_pmcs; i++)
+		if (pfm_bv_isset(arch_info->enable_mask, i))
+			__pfm_write_reg(xregs+i, 0);
+}
+
+void pfm_arch_init_percpu(void)
+{
+	unsigned long mask;
+
+	/*
+	 * We initialize APIC with LVTPC vector masked.
+	 *
+	 * This is motivated by the fact that the PMU may be
+	 * in a condition where it has already an interrupt pending.
+	 *
+	 * If there is no PMU description, it is not possible to clear
+	 * the overflow condition, therefore all we can do is mask
+	 * the interrupt. that is fine because until a PMU description
+	 * is provided, the PMU is unuseable.
+	 *
+	 * Once a description is loaded, then it is possible to access
+	 * the PMU registers to clear the condition.
+	 *
+	 * If NMI is using local APIC, then the problem does not exist
+	 * because LAPIC has already been properly initialized.
+	 */
+	if (nmi_watchdog != NMI_LOCAL_APIC) {
+
+		mask = LOCAL_PERFMON_VECTOR;
+		if (!pfm_pmu_conf)
+			mask |= APIC_LVT_MASKED;
+		else
+			__pfm_arch_quiesce_pmu_percpu();
+
+		apic_write(APIC_LVTPC, mask);
+		PFM_INFO("CPU%d APIC mask=0x%lx", smp_processor_id(), mask);
+	} else
+		PFM_INFO("CPU%d APIC read=0x%lx",
+			smp_processor_id(),
+			(unsigned long)apic_read(APIC_LVTPC));
+}
+
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
+	struct pfm_arch_pmu_info *arch_info;
+	struct pfm_arch_context *ctx_arch;
+	struct pfm_event_set *set;
+	struct pfm_ds_area *ds;
+
+	arch_info = pfm_pmu_conf->arch_info;
+	ctx_arch = pfm_ctx_arch(ctx);
+
+	set = ctx->active_set;
+PFM_DBG("called");
+	/*
+	 * stop active monitoring and collect overflow information
+	 */
+	pfm_stop_active(current, ctx, set);
+	
+	/*
+	 * PMU is stopped, thus PEBS is stopped already
+	 * on PEBS full interrupt, the IQ_CCCR4 counter does
+	 * not have the OVF bit set. Thus we use the pebs index
+	 * to detect overflow. This is required because we may
+	 * have more than one reason for overflow due to 64-bit
+	 * counter virtualization.
+	 *
+	 * We don't actually keep track of the overflow unless
+	 * IQ_CTR4 is actually used.
+	 *
+	 * With HT enabled, the mappings are such that IQ_CTR4 and IQ_CTR5
+	 * are mapped onto the same PMD registers.
+	 */
+	if (ctx_arch->ds_area) {
+		ds = (struct pfm_ds_area *)ctx_arch->ds_area;
+		if (ds->pebs_index >= ds->pebs_intr_thres
+		    && pfm_bv_isset(set->used_pmds, arch_info->pebs_ctr_idx)) {
+			pfm_bv_set(set->povfl_pmds, arch_info->pebs_ctr_idx);
+			set->npend_ovfls++;
+		}
+	}
+}
+
+/*
+ * unfreeze PMU from pfm_do_interrupt_handler()
+ * ctx may be NULL for spurious
+ */
+void pfm_arch_intr_unfreeze_pmu(struct pfm_context *ctx)
+{
+	struct pfm_arch_context *ctx_arch;
+
+	if (ctx == NULL)
+		return;
+
+	ctx_arch = pfm_ctx_arch(ctx);
+
+	pfm_arch_restore_pmcs(ctx, ctx->active_set);
+
+	/*
+	 * reload DS area pointer because it is cleared by
+	 * pfm_stop_active()
+	 */
+	if (ctx_arch->ds_area) {
+		wrmsrl(MSR_IA32_DS_AREA, ctx_arch->ds_area);
+		PFM_DBG("restoring DS");
+	}
+}
+
+/*
+ * Called from pfm_ctxsw(). Task is guaranteed to be current.
+ * set cannot be NULL. Context is locked. Interrupts are masked.
+ * Caller has already restored all PMD and PMC registers.
+ *
+ * must reactivate monitoring
+ */
+void pfm_arch_ctxswin_thread(struct task_struct *task, struct pfm_context *ctx,
+		      struct pfm_event_set *set)
+{
+	struct pfm_arch_context *ctx_arch;
+
+	ctx_arch = pfm_ctx_arch(ctx);
+PFM_DBG("called");
+	/*
+	 * reload DS management area pointer. Pointer
+	 * not managed as a PMC thus it is not restored
+	 * with the rest of the registers.
+	 */
+	if (ctx_arch->ds_area)
+		wrmsrl(MSR_IA32_DS_AREA, ctx_arch->ds_area);
+}
+
+static int __pfm_stop_active_p6(struct task_struct *task,
+				 struct pfm_context *ctx,
+				 struct pfm_event_set *set)
+{
+	struct pfm_arch_pmu_info *arch_info = pfm_pmu_conf->arch_info;
+	struct pfm_arch_ext_reg *xrc, *xrd;
+	u64 *cnt_mask;
+	u64 val, wmask, ovfl_mask;
+	u16 i, num;
+
+	num = set->nused_pmcs;
+	xrc = arch_info->pmc_addrs;
+	xrd = arch_info->pmd_addrs;
+	wmask = PFM_ONE_64 << pfm_pmu_conf->counter_width;
+
+	/*
+	 * clear enable bit (stop monitoring)
+	 * Unfortunately, this is very expensive!
+	 * wrmsrl() is serialized.
+	 */
+	for (i = 0; num; i++) {
+		if (pfm_bv_isset(set->used_pmcs, i)) {
+			wrmsrl(xrc[i].addrs[0], 0);
+			num--;
+		}
+	}
+
+	/*
+	 * if we already having a pending overflow condition, we do not
+	 * save them PMDs here, we let the generic code take care of it,
+	 * if needed.
+	 */
+	if (set->npend_ovfls)
+		return 1;
+
+	ovfl_mask = pfm_pmu_conf->ovfl_mask;
+	cnt_mask = pfm_pmu_conf->cnt_pmds;
+	/*
+	 * check for pending overflows and save PMDs (combo)
+	 * Must check for counting PMDs because of virtual PMDs
+	 */
+	num = set->nused_pmds;
+	for (i = 0; num; i++) {
+		if (pfm_bv_isset(set->used_pmds, i)) {
+			val = pfm_read_pmd(ctx, i);
+			if (likely(pfm_bv_isset(cnt_mask, i))) {
+				if (!(val & wmask)) {
+					pfm_bv_set(set->povfl_pmds, i);
+					set->npend_ovfls++;
+				}
+			}
+			num--;
+		}
+	}
+	/* no need to save PMDs after this */
+	return 0;
+}
+
+/*
+ * stop active set only
+ */
+static int __pfm_stop_active_p4(struct task_struct *task,
+				 struct pfm_context *ctx,
+				 struct pfm_event_set *set)
+{
+	struct pfm_arch_pmu_info *arch_info = pfm_pmu_conf->arch_info;
+	struct pfm_arch_context *ctx_arch;
+	struct pfm_arch_ext_reg *xrc, *xrd;
+	u64 used_enable_mask[PFM_PMC_BV];
+	u32 i, num, count;
+	u16 max_pmc;
+	u64 cccr, ctr1, ctr2;
+
+	ctx_arch = pfm_ctx_arch(ctx);
+	max_pmc = pfm_pmu_conf->max_pmc;
+	xrc = arch_info->pmc_addrs;
+	xrd = arch_info->pmd_addrs;
+
+	/*
+	 * build used enable PMC bitmask
+	 * if user did not set any CCCR, then mask is
+	 * empty and there is nothing to do because nothing
+	 * was started
+	 */
+	bitmap_and(ulp(used_enable_mask),
+		   ulp(set->used_pmcs),
+		   ulp(arch_info->enable_mask),
+		   max_pmc);
+
+	count = bitmap_weight(ulp(used_enable_mask), max_pmc);
+
+	/*
+	 * stop PEBS and clear DS area pointer
+	 */
+	if (ctx_arch->ds_area) {
+		wrmsrl(MSR_IA32_PEBS_ENABLE, 0);
+		wrmsrl(MSR_IA32_DS_AREA, 0);
+	}
+
+	/*
+	 * ensures we do not destroy pending overflow
+	 * information. If pended interrupts are already
+	 * known, then we just stop monitoring.
+	 */
+	if (set->npend_ovfls) {
+		/*
+		 * clear enable bit
+		 * unfortunately, this is very expensive!
+		 */
+		num = count;
+		for (i = 0; num; i++) {
+			BUG_ON(i >= PFM_MAX_PMCS);
+			if (pfm_bv_isset(used_enable_mask, i)) {
+				__pfm_write_reg(xrc+i, 0);
+				num--;
+			}
+		}
+		/* need save PMDs at upper level */
+		return 1;
+	}
+
+	/*
+	 * stop monitoring, collect pending overflow information and
+	 * save pmds.
+	 *
+	 * We need to read the CCR twice, once to get overflow info
+	 * and a second to stop monitoring (which destroys the OVF flag)
+	 */
+	num = count;
+	for (i = 0; num; i++) {
+		BUG_ON(i >= PFM_MAX_PMCS);
+		if (pfm_bv_isset(used_enable_mask, i)) {
+
+			/* read counter (PMD) controlled by PMC */
+			__pfm_read_reg(xrd+(xrc[i].ctr), &ctr1);
+
+			/* read CCCR (PMC) value */
+			__pfm_read_reg(xrc+i, &cccr);
+
+			/* clear CCCR value: stop counter but destroy OVF */
+			__pfm_write_reg(xrc+i, 0);
+
+			/* read counter controlled by CCCR again */
+			__pfm_read_reg(xrd+(xrc[i].ctr), &ctr2);
+
+			/*
+			 * there is an overflow if either:
+			 * 	- CCCR.ovf is set (and we just cleared it)
+			 * 	- ctr2 < ctr1
+			 * in that case we set the bit corresponding to the
+			 * overflowed PMD  in povfl_pmds.
+			 */
+			if ((cccr & (PFM_ONE_64<<31)) || (ctr2 < ctr1)) {
+				pfm_bv_set(set->povfl_pmds, xrc[i].ctr);
+				set->npend_ovfls++;
+			}
+			num--;
+		}
+	}
+	/* save the PMD at higher level */
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
+		   struct pfm_event_set *set)
+{
+	if (task != current)
+		return;
+
+PFM_DBG("called");
+	pfm_stop_active(task, ctx, set);
+}
+
+/*
+ * Called from pfm_ctxsw(). Task is guaranteed to be current.
+ * Context is locked. Interrupts are masked. Monitoring is active.
+ * PMU access is guaranteed. PMC and PMD registers are live in PMU.
+ *
+ * Must stop monitoring, save pending overflow information
+ * Return:
+ * 	non-zero : did not save PMDs (as part of stopping the PMU)
+ * 	       0 : saved PMDs (no need to save them in caller)
+ */
+int pfm_arch_ctxswout_thread(struct task_struct *task, struct pfm_context *ctx,
+		             struct pfm_event_set *set)
+{
+	struct pfm_arch_context *ctx_arch;
+
+	ctx_arch = pfm_ctx_arch(ctx);
+
+	/*
+	 * disable lazy restore of PMCS on ctxswin because
+	 * we modify some of them.
+	 */
+	set->priv_flags |= PFM_SETFL_PRIV_MOD_PMCS;
+
+PFM_DBG("called");
+	return pfm_stop_active(task, ctx, set);
+}
+
+/*
+ * called from pfm_start() and idle notifier
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
+void pfm_arch_start(struct task_struct *task, struct pfm_context *ctx,
+		    struct pfm_event_set *set)
+{
+	struct pfm_arch_pmu_info *arch_info = pfm_pmu_conf->arch_info;
+	struct pfm_arch_context *ctx_arch;
+	struct pfm_arch_ext_reg *xregs;
+	u64 *mask;
+	u16 i, num; 
+
+	if (ctx->state == PFM_CTX_MASKED || task != current)
+		return;
+
+	ctx_arch = pfm_ctx_arch(ctx);
+	num = set->nused_pmcs;
+	mask = set->used_pmcs;
+	xregs = arch_info->pmc_addrs;
+
+	/*
+	 * we must actually install all implemented pmcs registers because
+	 * until started, we do not write any PMC registers.  Note that
+	 * registers used  by other subsystems (e.g. NMI) are removed from
+	 * impl_pmcs.
+	 *
+	 * The available registers that are actually not used get their default
+	 * value such that the counter does not count anything. As such, we can
+	 * afford to write all of them but then stop only the one we use.
+	 */
+	for (i = 0; num; i++) {
+		if (pfm_bv_isset(mask, i)) {
+			__pfm_write_reg(xregs+i, set->pmcs[i]);
+			num--;
+		}
+	}
+
+	/*
+	 * reload DS area pointer. PEBS_ENABLE is restored with the PMCs
+	 * in pfm_restore_pmcs(). 
+	 */
+	if (ctx_arch->ds_area) {
+		wrmsrl(MSR_IA32_DS_AREA, ctx_arch->ds_area);
+		PFM_DBG("restoring DS");
+	}
+}
+
+/*
+ * function called from pfm_switch_sets(), pfm_context_load_thread(),
+ * pfm_context_load_sys(), pfm_ctxsw()
+ *
+ * context is locked. Interrupts are masked. Set cannot be NULL.
+ * Access to the PMU is guaranteed.
+ *
+ * function must restore PMD registers fom active set
+ */
+void pfm_arch_restore_pmds(struct pfm_context *ctx, struct pfm_event_set *set)
+{
+	struct pfm_arch_pmu_info *arch_info = pfm_pmu_conf->arch_info;
+	struct pfm_arch_ext_reg *xregs;
+	u64 ovfl_mask, val, *pmds;
+	u64 *used_pmds, *cnt_mask;
+	u16 i, num;
+
+	ovfl_mask = pfm_pmu_conf->ovfl_mask;
+	pmds = set->view->set_pmds;
+	used_pmds = set->used_pmds;
+	num = set->nused_pmds;
+	cnt_mask = pfm_pmu_conf->cnt_pmds;
+	xregs = arch_info->pmd_addrs;
+
+	/*
+	 * we can restore only the PMD we use because:
+	 * 	- you can only read with pfm_read_pmds() the registers
+	 * 	  declared used via pfm_write_pmds(), smpl_pmds, reset_pmds
+	 *
+	 * 	- if cr4.pce=1, only counters are exposed to user. No
+	 * 	  address is ever exposed by counters
+	 */
+	for (i = 0; num; i++) {
+		if (likely(pfm_bv_isset(used_pmds, i))) {
+			val = pmds[i];
+			if (likely(pfm_bv_isset(cnt_mask, i)))
+				val |= ~ovfl_mask;
+			__pfm_write_reg(xregs+i, val);
+			num--;
+		}
+	}
+}
+
+/*
+ * function called from pfm_switch_sets(), pfm_context_load_thread(),
+ * pfm_context_load_sys(), pfm_ctxsw().
+ * Context is locked. Interrupts are masked. set cannot be NULL.
+ * Access to the PMU is guaranteed.
+ *
+ * function must restore all PMC registers from set
+ */
+void pfm_arch_restore_pmcs(struct pfm_context *ctx, struct pfm_event_set *set)
+{
+	struct pfm_arch_pmu_info *arch_info = pfm_pmu_conf->arch_info;
+	struct pfm_arch_ext_reg *xregs;
+	u64 *mask;
+	u16 i, num;
+
+	xregs = arch_info->pmc_addrs;
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
+	 * In general, writing MSRs is very expensive, so try to be smart.
+	 *
+	 * P6-style:
+	 * 	- pmc are totally independent of each other, there is
+	 * 	  possible side-effect from stale pmcs. Therefore we only
+	 * 	  restore the registers we use
+	 * P4-style:
+	 * 	- must restore everything because there are some dependencies
+	 * 	(e.g., ESCR and CCCR)
+	 */
+	num = set->nused_pmcs;
+	mask = set->used_pmcs;
+	for (i = 0; num; i++) {
+		if (pfm_bv_isset(mask, i)) {
+			__pfm_write_reg(xregs+i, set->pmcs[i]);
+			num--;
+		}
+	}
+}
+
+/*
+ * The PMU interrupt is handled through an interrupt gate, therefore
+ * the CPU automatically clears the EFLAGS.IF, i.e., masking interrupts.
+ *
+ * The perfmon interrupt handler MUST run with interrupts disabled due
+ * to possible race with other, higher priority interrupts, such as timer
+ * or IPI function calls.
+ *
+ * See description in IA-32 architecture manual, Vol 3 section 5.8.1
+ */
+fastcall void smp_pmu_interrupt(struct pt_regs *regs)
+{
+	unsigned long iip;
+
+	ack_APIC_irq();
+	exit_idle();
+	irq_enter();
+
+	if (nmi_watchdog == NMI_LOCAL_APIC)
+		iip = __get_cpu_var(real_iip);
+	else
+		iip = instruction_pointer(regs);
+	
+	pfm_interrupt_handler(iip, regs);
+
+	/*
+	 * On Intel P6, Pentium M, P4:
+	 * 	- it is necessary to clear the MASK field for the LVTPC
+	 * 	  vector. Otherwise interrupts remain masked. See
+	 * 	  section 8.5.1
+	 * AMD X86-64:
+	 * 	- the documentation does not stipulate the behavior.
+	 * 	  To be safe, we also rewrite the vector to clear the
+	 * 	  mask field
+	 */
+	if (nmi_watchdog != NMI_LOCAL_APIC)
+		apic_write(APIC_LVTPC, LOCAL_PERFMON_VECTOR);
+	irq_exit();
+	enter_idle();
+}
+
+/*
+ * called from pfm_register_pmu_config() after the new
+ * config has been validated and installed. The pfm_session_lock
+ * is held.
+ *
+ * Must sanity check the arch-specific config information
+ *
+ * return:
+ * 	< 0 : if error
+ * 	  0 : if success
+ */
+int pfm_arch_pmu_config_init(struct pfm_pmu_config *cfg)
+{
+	struct pfm_arch_pmu_info *arch_info = cfg->arch_info;
+	u16 i, num=0;
+
+	/*
+	 * adust stop routine based on PMU model
+	 *
+	 * P6, Pentium M, AMD X86-64 = P6
+	 * P4, Xeon, EM64T = P4
+	 */
+	switch(arch_info->pmu_style) {
+		case PFM_X86_PMU_P4:
+			pfm_stop_active = __pfm_stop_active_p4;
+			break;
+		case PFM_X86_PMU_P6:
+			pfm_stop_active = __pfm_stop_active_p6;
+			break;
+		default:
+			PFM_INFO("unknown pmu_style=%d", arch_info->pmu_style);
+			return -EINVAL;
+	}
+	bitmap_zero(ulp(arch_info->enable_mask), PFM_MAX_HW_PMCS);
+	for(i=0; i < PFM_MAX_HW_PMCS; i++) {
+		if (arch_info->pmc_addrs[i].reg_type & PFM_REGT_EN) {
+			pfm_bv_set(arch_info->enable_mask, i);
+			num++;
+		}
+	}
+	PFM_INFO("PMU has %u enable PMCs", num);
+	return 0;
+}
+
+char *pfm_arch_get_pmu_module_name(void)
+{
+	switch(cpu_data->x86) {
+		case 6:
+			switch(cpu_data->x86_model) {
+				case 3: /* Pentium II */
+				case 7 ... 11:
+				case 13:
+					return "perfmon_p6";
+				default:
+					goto try_arch;
+			}
+		case 15:
+			/* All Opteron processors */
+			if (cpu_data->x86_vendor == X86_VENDOR_AMD)
+				return "perfmon_k8";
+
+			switch(cpu_data->x86_model) {
+				case 0 ... 6:
+					return "perfmon_p4";
+			}
+			/* FALL THROUGH */
+		default:
+try_arch:
+			if (boot_cpu_has(X86_FEATURE_ARCH_PERFMON))
+				return "perfmon_gen_ia32";
+			return NULL;
+	}
+	return NULL;
+}
+
+static int pfm_idle_notify_handler(struct notifier_block *nb,
+				   unsigned long state,
+				   void *data)
+{
+	struct pfm_context *ctx;
+	struct pfm_event_set *set;
+	unsigned long flags;
+	u64 now;
+
+	ctx = __get_cpu_var(pmu_ctx);
+	if (ctx == NULL)
+		return NOTIFY_OK;
+
+	BUG_ON(current->pid);
+
+	local_irq_save(flags);
+
+	if (ctx->flags.system && ctx->flags.started) {
+		now = sched_clock();
+		set = ctx->active_set;
+
+		if (state == IDLE_START) {
+			set->duration += now - set->duration_start;
+			pfm_arch_stop(current, ctx, set);
+		} else {
+			pfm_arch_start(current, ctx, set);
+			set->duration_start = now;
+		}
+	}
+
+	local_irq_restore(flags);
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block pfm_idle_notifier= {
+	.notifier_call = pfm_idle_notify_handler
+};
+
+/* global, one time, initialization */
+int __init pfm_arch_init(void)
+{
+	idle_notifier_register(&pfm_idle_notifier);
+	return 0;
+}
+
+/*
+ * called from nmi_watchdog_tick()
+ */
+void __kprobes pfm_handle_nmi(struct pt_regs *regs)
+{
+	struct pfm_context *ctx;
+
+	ctx = __get_cpu_var(pmu_ctx);
+	if (ctx == NULL)
+		return;
+	/*
+	 * we stop the PMU to avoid further overflow before this
+	 * one is treated by lower priority interrupt handler
+	 *
+	 * We cannot grab any locks (due to NMI)
+	 */
+	__pfm_arch_quiesce_pmu_percpu();
+	__get_cpu_var(real_iip) = instruction_pointer(regs);
+
+	/*
+	 * post lower priority interrupt (normal LOCAL_PERFMON_VECTOR)
+	 */
+	pfm_arch_resend_irq();
+	__get_cpu_var(pfm_stats).pfm_ovfl_intr_nmi_count++;
+}
--- linux-2.6.18.base/arch/i386/perfmon/perfmon_gen_ia32.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.18/arch/i386/perfmon/perfmon_gen_ia32.c	2006-09-25 12:11:55.000000000 -0700
@@ -0,0 +1,267 @@
+/*
+ * This file contains the IA-32 architectural perfmon register description tables.
+ *
+ * The IA-32 architectural perfmon (PMU) was introduced with Intel Core Solo
+ * and Core Duo processors.
+ *
+ * Copyright (c) 2006 Hewlett-Packard Development Company, L.P.
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
+ */
+#include <linux/module.h>
+#include <linux/perfmon.h>
+#include <asm/msr.h>
+#include <asm/apic.h>
+#include <asm/nmi.h>
+
+MODULE_AUTHOR("Stephane Eranian <eranian@hpl.hp.com>");
+MODULE_DESCRIPTION("Generic IA-32 PMU description table");
+MODULE_LICENSE("GPL");
+
+/*
+ * - upper 32 bits are reserved
+ * - INT: APIC enable bit is reserved (forced to 1)
+ * - bit 21 is reserved
+ */
+#define PFM_GEN_IA32_PMC_RSVD	~((0xffffffffULL<<32) \
+		  	| (PFM_ONE_64<<20)    \
+			| (PFM_ONE_64<<21))
+
+/*
+ * force Local APIC interrupt on overflow
+ * disable with NO_EMUL64
+ */
+#define PFM_GEN_IA32_PMC_VAL	(PFM_ONE_64<<20)
+#define PFM_GEN_IA32_NO64	(PFM_ONE_64<<20)
+
+/*
+ * architectuture specifies that:
+ * IA32_PMCx MSR starts at 0xc1 & occupy a contiguous block of MSR addr
+ * IA32_PERFEVTSELx MSR starts at 0x186 & occupy a contiguous block of MSR addr
+ */
+#define MSR_GEN_PERFEVTSEL_BASE	MSR_P6_EVNTSEL0
+#define MSR_GEN_PMC_BASE	MSR_P6_PERFCTR0
+
+#define PFM_GEN_IA32_SEL(n)	{ \
+	.addrs[0] = MSR_GEN_PERFEVTSEL_BASE+(n), \
+	.addrs[1] = 0, \
+	.ctr = n, \
+	.reg_type = PFM_REGT_EN}
+
+#define PFM_GEN_IA32_CTR(n) { \
+	.addrs[0] = MSR_GEN_PMC_BASE+(n), \
+	.addrs[1] = 0, \
+	.ctr = n, \
+	.reg_type = PFM_REGT_CTR}
+
+struct pmu_eax {
+        unsigned int version:8;
+        unsigned int num_cnt:8;
+        unsigned int cnt_width:8;
+        unsigned int ebx_length:8;
+};
+
+/*
+ * physical addresses of MSR controlling the perfevtsel and counter registers
+ */
+struct pfm_arch_pmu_info pfm_gen_ia32_pmu_info={
+	.pmc_addrs = {
+		PFM_GEN_IA32_SEL(0) ,  PFM_GEN_IA32_SEL(1),  PFM_GEN_IA32_SEL(2),  PFM_GEN_IA32_SEL(3),
+		PFM_GEN_IA32_SEL(4) ,  PFM_GEN_IA32_SEL(5),  PFM_GEN_IA32_SEL(6),  PFM_GEN_IA32_SEL(7),
+		PFM_GEN_IA32_SEL(8) ,  PFM_GEN_IA32_SEL(9), PFM_GEN_IA32_SEL(10), PFM_GEN_IA32_SEL(11),
+		PFM_GEN_IA32_SEL(12), PFM_GEN_IA32_SEL(13), PFM_GEN_IA32_SEL(14), PFM_GEN_IA32_SEL(15),
+		PFM_GEN_IA32_SEL(16), PFM_GEN_IA32_SEL(17), PFM_GEN_IA32_SEL(18), PFM_GEN_IA32_SEL(19),
+		PFM_GEN_IA32_SEL(20), PFM_GEN_IA32_SEL(21), PFM_GEN_IA32_SEL(22), PFM_GEN_IA32_SEL(23),
+		PFM_GEN_IA32_SEL(24), PFM_GEN_IA32_SEL(25), PFM_GEN_IA32_SEL(26), PFM_GEN_IA32_SEL(27),
+		PFM_GEN_IA32_SEL(28), PFM_GEN_IA32_SEL(29), PFM_GEN_IA32_SEL(30), PFM_GEN_IA32_SEL(31)
+	},
+	.pmd_addrs = {
+		PFM_GEN_IA32_CTR(0) ,  PFM_GEN_IA32_CTR(1),  PFM_GEN_IA32_CTR(2),  PFM_GEN_IA32_CTR(3),
+		PFM_GEN_IA32_CTR(4) ,  PFM_GEN_IA32_CTR(5),  PFM_GEN_IA32_CTR(6),  PFM_GEN_IA32_CTR(7),
+		PFM_GEN_IA32_CTR(8) ,  PFM_GEN_IA32_CTR(9), PFM_GEN_IA32_CTR(10), PFM_GEN_IA32_CTR(11),
+		PFM_GEN_IA32_CTR(12), PFM_GEN_IA32_CTR(13), PFM_GEN_IA32_CTR(14), PFM_GEN_IA32_CTR(15),
+		PFM_GEN_IA32_CTR(16), PFM_GEN_IA32_CTR(17), PFM_GEN_IA32_CTR(18), PFM_GEN_IA32_CTR(19),
+		PFM_GEN_IA32_CTR(20), PFM_GEN_IA32_CTR(21), PFM_GEN_IA32_CTR(22), PFM_GEN_IA32_CTR(23),
+		PFM_GEN_IA32_CTR(24), PFM_GEN_IA32_CTR(25), PFM_GEN_IA32_CTR(26), PFM_GEN_IA32_CTR(27),
+		PFM_GEN_IA32_CTR(28), PFM_GEN_IA32_CTR(29), PFM_GEN_IA32_CTR(30), PFM_GEN_IA32_CTR(31)
+	},
+	.pmu_style = PFM_X86_PMU_P6,
+};
+
+#define PFM_GEN_IA32_C(n) {                 \
+	.type = PFM_REG_I64,                \
+	.desc = "PERFEVTSEL"#n,             \
+	.dfl_val = PFM_GEN_IA32_PMC_VAL,    \
+	.rsvd_msk = PFM_GEN_IA32_PMC_RSVD,  \
+	.no_emul64_msk = PFM_GEN_IA32_NO64, \
+	.hw_addr = MSR_GEN_PERFEVTSEL_BASE+(n) \
+	}
+
+#define PFM_GEN_IA32_D(n) { \
+	.type = PFM_REG_C,  \
+	.desc = "PMC"#n,    \
+	.dfl_val = 0,       \
+	.rsvd_msk = -1,     \
+	.no_emul64_msk = 0, \
+	.hw_addr = MSR_GEN_PMC_BASE+(n) \
+	}
+
+static struct pfm_reg_desc pfm_gen_ia32_pmc_desc[]={
+/* pmc0  */  PFM_GEN_IA32_C(0),  PFM_GEN_IA32_C(1),  PFM_GEN_IA32_C(2),  PFM_GEN_IA32_C(3),
+/* pmc4  */  PFM_GEN_IA32_C(4),  PFM_GEN_IA32_C(5),  PFM_GEN_IA32_C(6),  PFM_GEN_IA32_C(7),
+/* pmc8  */  PFM_GEN_IA32_C(8),  PFM_GEN_IA32_C(9), PFM_GEN_IA32_C(10), PFM_GEN_IA32_C(11),
+/* pmc12 */ PFM_GEN_IA32_C(12), PFM_GEN_IA32_C(13), PFM_GEN_IA32_C(14), PFM_GEN_IA32_C(15),
+/* pmc16 */ PFM_GEN_IA32_C(16), PFM_GEN_IA32_C(17), PFM_GEN_IA32_C(18), PFM_GEN_IA32_C(19),
+/* pmc20 */ PFM_GEN_IA32_C(20), PFM_GEN_IA32_C(21), PFM_GEN_IA32_C(22), PFM_GEN_IA32_C(23),
+/* pmc24 */ PFM_GEN_IA32_C(24), PFM_GEN_IA32_C(25), PFM_GEN_IA32_C(26), PFM_GEN_IA32_C(27),
+/* pmc28 */ PFM_GEN_IA32_C(28), PFM_GEN_IA32_C(29), PFM_GEN_IA32_C(30), PFM_GEN_IA32_C(31)
+};
+
+static struct pfm_reg_desc pfm_gen_ia32_pmd_desc[]={
+/* pmd0  */  PFM_GEN_IA32_D(0),  PFM_GEN_IA32_D(1),  PFM_GEN_IA32_D(2),  PFM_GEN_IA32_D(3),
+/* pmd4  */  PFM_GEN_IA32_D(4),  PFM_GEN_IA32_D(5),  PFM_GEN_IA32_D(6),  PFM_GEN_IA32_D(7),
+/* pmd8  */  PFM_GEN_IA32_D(8),  PFM_GEN_IA32_D(9), PFM_GEN_IA32_D(10), PFM_GEN_IA32_D(11),
+/* pmd12 */ PFM_GEN_IA32_D(12), PFM_GEN_IA32_D(13), PFM_GEN_IA32_D(14), PFM_GEN_IA32_D(15),
+/* pmd16 */ PFM_GEN_IA32_D(16), PFM_GEN_IA32_D(17), PFM_GEN_IA32_D(18), PFM_GEN_IA32_D(19),
+/* pmd20 */ PFM_GEN_IA32_D(20), PFM_GEN_IA32_D(21), PFM_GEN_IA32_D(22), PFM_GEN_IA32_D(23),
+/* pmd24 */ PFM_GEN_IA32_D(24), PFM_GEN_IA32_D(25), PFM_GEN_IA32_D(26), PFM_GEN_IA32_D(27),
+/* pmd28 */ PFM_GEN_IA32_D(28), PFM_GEN_IA32_D(29), PFM_GEN_IA32_D(30), PFM_GEN_IA32_D(31)
+};
+#define PFM_GEN_IA32_MAX_PMCS	ARRAY_SIZE(pfm_gen_ia32_pmc_desc)
+
+#define MSR_IA32_MISC_ENABLE_PERF_AVAIL (1<<7) /* read-only status bit */
+
+static struct pfm_pmu_config pfm_gen_ia32_pmu_conf;
+
+static int pfm_gen_ia32_probe_pmu(void)
+{
+	union {
+		unsigned int val;
+		struct pmu_eax eax;
+	} eax;
+	unsigned int ebx, ecx, edx;
+	unsigned int num_cnt;
+
+	if (cpu_data->x86_vendor != X86_VENDOR_INTEL) {
+		PFM_INFO("not an Intel processor");
+		return -1;
+	}
+
+	/*
+	 * ensure CPUID instruction exists
+	 */
+	if (cpu_data->x86 < 5) {
+		PFM_INFO("processor family too old");
+		return -1;
+	}
+
+	/*
+	 * check if CPU supports 0xa function of CPUID
+	 * 0xa started with Core Duo/Solo. Needed to detect if
+	 * architected PMU is present
+	 */
+	cpuid(0x0, &eax.val, &ebx, &ecx, &edx);
+	if (eax.val < 0xa) {
+		PFM_INFO("CPUID 0xa function not supported\n");
+		return -1;
+	}
+
+	cpuid(0xa, &eax.val, &ebx, &ecx, &edx);
+	if (eax.eax.version < 1) {
+		PFM_INFO("architectural perfmon not supported\n");
+		return -1;
+	}
+	num_cnt = eax.eax.num_cnt;
+
+	/*
+	 * sanity check number of counters
+	 */
+	if (num_cnt == 0 || num_cnt >= PFM_MAX_HW_PMCS) {
+		PFM_INFO("invalid number of counters %u\n", eax.eax.num_cnt);
+		return -1;
+	}
+	/*
+	 * instead of dynamically generating the description table
+	 * and MSR addresses, we have a default description with a reasonably
+	 * large number of counters (32). We believe this is plenty for quite
+	 * some time. Thus allows us to have a much simpler probing and
+	 * initialization routine, especially because we have no dynamic
+	 * allocation, especially for the counter names.
+	 *
+	 * When HW supports more that what we haev prepared for, then we limit
+	 * the number of counters we support and print a message.
+	 */
+	if (num_cnt >= PFM_GEN_IA32_MAX_PMCS) {
+		printk(KERN_INFO "perfmon: Limiting number of counters to %zu,"
+				 "HW supports %u", PFM_GEN_IA32_MAX_PMCS, num_cnt);
+		num_cnt = PFM_GEN_IA32_MAX_PMCS;
+	}
+
+	if (eax.eax.cnt_width > 63) {
+		PFM_INFO("invalid counter width %u\n", eax.eax.cnt_width);
+		return -1;
+	}
+
+	if (!cpu_has_apic) {
+		PFM_INFO("no Local APIC, unsupported");
+		return -1;
+	}
+
+	if (nmi_watchdog == NMI_LOCAL_APIC) {
+		PFM_INFO("NMI watchdog using PERFEVTSEL0/PERTCTR0, disabling them for perfmon");
+		pfm_gen_ia32_pmc_desc[0].type = PFM_REG_NA;
+		pfm_gen_ia32_pmd_desc[0].type = PFM_REG_NA;
+		pfm_gen_ia32_pmu_info.pmc_addrs[0].reg_type = PFM_REGT_NA;
+		pfm_gen_ia32_pmu_info.pmd_addrs[0].reg_type = PFM_REGT_NA;
+	}
+	pfm_gen_ia32_pmu_conf.num_pmc_entries = num_cnt;
+	pfm_gen_ia32_pmu_conf.num_pmd_entries = num_cnt;
+
+	return 0;
+}
+
+/*
+ * Counters may have model-specific width. Yet the documentation says
+ * that only the lower 32 bits can be written to. bits [w-32]
+ * are sign extensions of bit 31. As such the effective width of
+ * a counter is 31 bits only.
+ * See IA-32 Intel Architecture Software developer manual Vol 3b:
+ * system programming and section 18.17.2 in particular.
+ */
+static struct pfm_pmu_config pfm_gen_ia32_pmu_conf={
+	.pmu_name = "Intel architectural",
+	.pmd_desc = pfm_gen_ia32_pmd_desc,
+	.counter_width   = 31,
+	.pmc_desc = pfm_gen_ia32_pmc_desc,
+	.probe_pmu = pfm_gen_ia32_probe_pmu,
+	.version = "1.0",
+	.flags = PFM_PMU_BUILTIN_FLAG,
+	.owner = THIS_MODULE,
+	.arch_info = &pfm_gen_ia32_pmu_info
+};
+	
+static int __init pfm_gen_ia32_pmu_init_module(void)
+{
+	return pfm_pmu_register(&pfm_gen_ia32_pmu_conf);
+}
+
+static void __exit pfm_gen_ia32_pmu_cleanup_module(void)
+{
+	pfm_pmu_unregister(&pfm_gen_ia32_pmu_conf);
+}
+
+module_init(pfm_gen_ia32_pmu_init_module);
+module_exit(pfm_gen_ia32_pmu_cleanup_module);
--- linux-2.6.18.base/arch/i386/perfmon/perfmon_p4.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.18/arch/i386/perfmon/perfmon_p4.c	2006-09-25 12:12:45.000000000 -0700
@@ -0,0 +1,430 @@
+/*	
+ * This file contains the P4/Xeon/EM64T PMU register description tables
+ * and pmc checker used by perfmon.c.
+ *
+ * Copyright (c) 2005 Intel Corporation
+ * Contributed by Bryan Wilkerson <bryan.p.wilkerson@intel.com>
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
+#include <asm/msr.h>
+#include <asm/apic.h>
+#include <asm/nmi.h>
+
+MODULE_AUTHOR("Bryan Wilkerson <bryan.p.wilkerson@intel.com>");
+MODULE_DESCRIPTION("P4/Xeon/EM64T PMU description table");
+MODULE_LICENSE("GPL");
+
+static int force;
+MODULE_PARM_DESC(force, "bool: force module to load succesfully");
+module_param(force, bool, 0600);
+
+/*
+ * CCCR default value:
+ * 	- OVF_PMI_T0=1 (bit 26)
+ * 	- OVF_PMI_T1=0 (bit 27) (set if necessary in pfm_write_reg())
+ * 	- all other bits are zero
+ *
+ * OVF_PMI is forced to zero if PFM_REGFL_NO_EMUL64 is set on CCCR
+ */
+#define PFM_CCCR_DFL	(PFM_ONE_64<<26) | (0x3ULL<<16)
+
+/*
+ * CCCR reserved fields:
+ * 	- bits 0-11, 25-29, 31-63
+ * 	- OVF_PMI (26-27), override with REGFL_NO_EMUL64
+ * reserved bits must be 0
+ */
+#define PFM_CCCR_RSVD     (0xfull<<12)  \
+			| (0x7full<<18) \
+			| (0x1ull<<30)
+
+#define PFM_P4_NO64	(3ULL<<26) /* use 3 even in non HT mode */
+
+/*
+ * With HyperThreading enabled:
+ *
+ *  The ESCRs and CCCRs are divided in half with the top half
+ *  belonging to logical processor 0 and the bottom half going to
+ *  logical processor 1. Thus only half of the PMU resources are
+ *  accessible to applications.
+ *
+ *  PEBS is not available due to the fact that:
+ *  	- MSR_PEBS_MATRIX_VERT is shared between the threads
+ *      - IA32_PEBS_ENABLE is shared between the threads
+ *
+ * With HyperThreading disabled:
+ *
+ * The full set of PMU resources is exposed to applications.
+ *
+ * The mapping is chosen such that PMCxx -> MSR is the same
+ * in HT and non HT mode, if register is present in HT mode.
+ *
+ */
+#define PFM_REGT_NHTESCR (PFM_REGT_ESCR|PFM_REGT_NOHT)
+#define PFM_REGT_NHTCCCR (PFM_REGT_CCCR|PFM_REGT_NOHT|PFM_REGT_EN)
+#define PFM_REGT_NHTPEBS (PFM_REGT_PEBS|PFM_REGT_NOHT)
+#define PFM_REGT_NHTCTR  (PFM_REGT_CTR|PFM_REGT_NOHT)
+#define PFM_REGT_ENAC    (PFM_REGT_CCCR|PFM_REGT_EN)
+
+static struct pfm_arch_pmu_info pfm_p4_pmu_info={
+ .pmc_addrs = {
+ 	/*pmc 0 */    {{MSR_P4_BPU_ESCR0, MSR_P4_BPU_ESCR1}, 0, PFM_REGT_ESCR}, /*   BPU_ESCR0,1 */
+ 	/*pmc 1 */    {{MSR_P4_IS_ESCR0, MSR_P4_IS_ESCR1}, 0, PFM_REGT_ESCR}, /*    IS_ESCR0,1 */
+ 	/*pmc 2 */    {{MSR_P4_MOB_ESCR0, MSR_P4_MOB_ESCR1}, 0, PFM_REGT_ESCR}, /*   MOB_ESCR0,1 */
+ 	/*pmc 3 */    {{MSR_P4_ITLB_ESCR0, MSR_P4_ITLB_ESCR1}, 0, PFM_REGT_ESCR}, /*  ITLB_ESCR0,1 */
+ 	/*pmc 4 */    {{MSR_P4_PMH_ESCR0, MSR_P4_PMH_ESCR1}, 0, PFM_REGT_ESCR}, /*   PMH_ESCR0,1 */
+ 	/*pmc 5 */    {{MSR_P4_IX_ESCR0, MSR_P4_IX_ESCR1}, 0, PFM_REGT_ESCR}, /*    IX_ESCR0,1 */
+ 	/*pmc 6 */    {{MSR_P4_FSB_ESCR0, MSR_P4_FSB_ESCR1}, 0, PFM_REGT_ESCR}, /*   FSB_ESCR0,1 */
+ 	/*pmc 7 */    {{MSR_P4_BSU_ESCR0, MSR_P4_BSU_ESCR1}, 0, PFM_REGT_ESCR}, /*   BSU_ESCR0,1 */
+ 	/*pmc 8 */    {{MSR_P4_MS_ESCR0, MSR_P4_MS_ESCR1}, 0, PFM_REGT_ESCR}, /*    MS_ESCR0,1 */
+ 	/*pmc 9 */    {{MSR_P4_TC_ESCR0, MSR_P4_TC_ESCR1}, 0, PFM_REGT_ESCR}, /*    TC_ESCR0,1 */
+ 	/*pmc 10*/    {{MSR_P4_TBPU_ESCR0, MSR_P4_TBPU_ESCR1}, 0, PFM_REGT_ESCR}, /*  TBPU_ESCR0,1 */
+ 	/*pmc 11*/    {{MSR_P4_FLAME_ESCR0, MSR_P4_FLAME_ESCR1}, 0, PFM_REGT_ESCR}, /* FLAME_ESCR0,1 */
+ 	/*pmc 12*/    {{MSR_P4_FIRM_ESCR0, MSR_P4_FIRM_ESCR1}, 0, PFM_REGT_ESCR}, /*  FIRM_ESCR0,1 */
+ 	/*pmc 13*/    {{MSR_P4_SAAT_ESCR0, MSR_P4_SAAT_ESCR1}, 0, PFM_REGT_ESCR}, /*  SAAT_ESCR0,1 */
+ 	/*pmc 14*/    {{MSR_P4_U2L_ESCR0, MSR_P4_U2L_ESCR1}, 0, PFM_REGT_ESCR}, /*   U2L_ESCR0,1 */
+ 	/*pmc 15*/    {{MSR_P4_DAC_ESCR0, MSR_P4_DAC_ESCR1}, 0, PFM_REGT_ESCR}, /*   DAC_ESCR0,1 */
+ 	/*pmc 16*/    {{MSR_P4_IQ_ESCR0, MSR_P4_IQ_ESCR1}, 0, PFM_REGT_ESCR}, /*    IQ_ESCR0,1 (only model 1 and 2) */
+ 	/*pmc 17*/    {{MSR_P4_ALF_ESCR0, MSR_P4_ALF_ESCR1}, 0, PFM_REGT_ESCR}, /*   ALF_ESCR0,1 */
+ 	/*pmc 18*/    {{MSR_P4_RAT_ESCR0, MSR_P4_RAT_ESCR1}, 0, PFM_REGT_ESCR}, /*   RAT_ESCR0,1 */
+ 	/*pmc 19*/    {{MSR_P4_SSU_ESCR0, 0}, 0, PFM_REGT_ESCR}, /*   SSU_ESCR0   */
+ 	/*pmc 20*/    {{MSR_P4_CRU_ESCR0, MSR_P4_CRU_ESCR1}, 0, PFM_REGT_ESCR}, /*   CRU_ESCR0,1 */
+ 	/*pmc 21*/    {{MSR_P4_CRU_ESCR2, MSR_P4_CRU_ESCR3}, 0, PFM_REGT_ESCR}, /*   CRU_ESCR2,3 */
+ 	/*pmc 22*/    {{MSR_P4_CRU_ESCR4, MSR_P4_CRU_ESCR5}, 0, PFM_REGT_ESCR}, /*   CRU_ESCR4,5 */
+
+ 	/*pmc 23*/    {{MSR_P4_BPU_CCCR0, MSR_P4_BPU_CCCR2}, 0, PFM_REGT_ENAC}, /*   BPU_CCCR0,2 */
+ 	/*pmc 24*/    {{MSR_P4_BPU_CCCR1, MSR_P4_BPU_CCCR3}, 1, PFM_REGT_ENAC}, /*   BPU_CCCR1,3 */
+ 	/*pmc 25*/    {{MSR_P4_MS_CCCR0, MSR_P4_MS_CCCR2}, 2, PFM_REGT_ENAC}, /*    MS_CCCR0,2 */
+ 	/*pmc 26*/    {{MSR_P4_MS_CCCR1, MSR_P4_MS_CCCR3}, 3, PFM_REGT_ENAC}, /*    MS_CCCR1,3 */
+ 	/*pmc 27*/    {{MSR_P4_FLAME_CCCR0, MSR_P4_FLAME_CCCR2}, 4, PFM_REGT_ENAC}, /* FLAME_CCCR0,2 */
+ 	/*pmc 28*/    {{MSR_P4_FLAME_CCCR1, MSR_P4_FLAME_CCCR3}, 5, PFM_REGT_ENAC}, /* FLAME_CCCR1,3 */
+ 	/*pmc 29*/    {{MSR_P4_IQ_CCCR0, MSR_P4_IQ_CCCR2}, 6, PFM_REGT_ENAC}, /*    IQ_CCCR0,2 */
+ 	/*pmc 30*/    {{MSR_P4_IQ_CCCR1, MSR_P4_IQ_CCCR3}, 7, PFM_REGT_ENAC}, /*    IQ_CCCR1,3 */
+ 	/*pmc 31*/    {{MSR_P4_IQ_CCCR4, MSR_P4_IQ_CCCR5}, 8, PFM_REGT_ENAC}, /*    IQ_CCCR4,5 */
+ 	/* non HT extensions */	
+ 	/*pmc 32*/    {{MSR_P4_BPU_ESCR1,     0}, 0, PFM_REGT_NHTESCR}, /*   BPU_ESCR1   */
+ 	/*pmc 33*/    {{MSR_P4_IS_ESCR1,     0}, 0, PFM_REGT_NHTESCR}, /*    IS_ESCR1   */
+ 	/*pmc 34*/    {{MSR_P4_MOB_ESCR1,     0}, 0, PFM_REGT_NHTESCR}, /*   MOB_ESCR1   */
+ 	/*pmc 35*/    {{MSR_P4_ITLB_ESCR1,     0}, 0, PFM_REGT_NHTESCR}, /*  ITLB_ESCR1   */
+ 	/*pmc 36*/    {{MSR_P4_PMH_ESCR1,     0}, 0, PFM_REGT_NHTESCR}, /*   PMH_ESCR1   */
+ 	/*pmc 37*/    {{MSR_P4_IX_ESCR1,     0}, 0, PFM_REGT_NHTESCR}, /*    IX_ESCR1   */
+ 	/*pmc 38*/    {{MSR_P4_FSB_ESCR1,     0}, 0, PFM_REGT_NHTESCR}, /*   FSB_ESCR1   */
+ 	/*pmc 39*/    {{MSR_P4_BSU_ESCR1,     0}, 0, PFM_REGT_NHTESCR}, /*   BSU_ESCR1   */
+ 	/*pmc 40*/    {{MSR_P4_MS_ESCR1,     0}, 0, PFM_REGT_NHTESCR}, /*    MS_ESCR1   */
+ 	/*pmc 41*/    {{MSR_P4_TC_ESCR1,     0}, 0, PFM_REGT_NHTESCR}, /*    TC_ESCR1   */
+ 	/*pmc 42*/    {{MSR_P4_TBPU_ESCR1,     0}, 0, PFM_REGT_NHTESCR}, /*  TBPU_ESCR1   */
+ 	/*pmc 43*/    {{MSR_P4_FLAME_ESCR1,     0}, 0, PFM_REGT_NHTESCR}, /* FLAME_ESCR1   */
+ 	/*pmc 44*/    {{MSR_P4_FIRM_ESCR1,     0}, 0, PFM_REGT_NHTESCR}, /*  FIRM_ESCR1   */
+ 	/*pmc 45*/    {{MSR_P4_SAAT_ESCR1,     0}, 0, PFM_REGT_NHTESCR}, /*  SAAT_ESCR1   */
+ 	/*pmc 46*/    {{MSR_P4_U2L_ESCR1,     0}, 0, PFM_REGT_NHTESCR}, /*   U2L_ESCR1   */
+ 	/*pmc 47*/    {{MSR_P4_DAC_ESCR1,     0}, 0, PFM_REGT_NHTESCR}, /*   DAC_ESCR1   */
+ 	/*pmc 48*/    {{MSR_P4_IQ_ESCR1,     0}, 0, PFM_REGT_NHTESCR}, /*    IQ_ESCR1   (only model 1 and 2) */
+ 	/*pmc 49*/    {{MSR_P4_ALF_ESCR1,     0}, 0, PFM_REGT_NHTESCR}, /*   ALF_ESCR1   */
+ 	/*pmc 50*/    {{MSR_P4_RAT_ESCR1,     0}, 0, PFM_REGT_NHTESCR}, /*   RAT_ESCR1   */
+ 	/*pmc 51*/    {{MSR_P4_CRU_ESCR1,     0}, 0, PFM_REGT_NHTESCR}, /*   CRU_ESCR1   */
+ 	/*pmc 52*/    {{MSR_P4_CRU_ESCR3,     0}, 0, PFM_REGT_NHTESCR}, /*   CRU_ESCR3   */
+ 	/*pmc 53*/    {{MSR_P4_CRU_ESCR5,     0}, 0, PFM_REGT_NHTESCR}, /*   CRU_ESCR5   */
+ 	/*pmc 54*/    {{MSR_P4_BPU_CCCR1,     0}, 9, PFM_REGT_NHTCCCR}, /*   BPU_CCCR1   */
+ 	/*pmc 55*/    {{MSR_P4_BPU_CCCR3,     0},10, PFM_REGT_NHTCCCR}, /*   BPU_CCCR3   */
+ 	/*pmc 56*/    {{MSR_P4_MS_CCCR1,     0},11, PFM_REGT_NHTCCCR}, /*    MS_CCCR1   */
+ 	/*pmc 57*/    {{MSR_P4_MS_CCCR3,     0},12, PFM_REGT_NHTCCCR}, /*    MS_CCCR3   */
+ 	/*pmc 58*/    {{MSR_P4_FLAME_CCCR1,     0},13, PFM_REGT_NHTCCCR}, /* FLAME_CCCR1   */
+ 	/*pmc 59*/    {{MSR_P4_FLAME_CCCR3,     0},14, PFM_REGT_NHTCCCR}, /* FLAME_CCCR3   */
+ 	/*pmc 60*/    {{MSR_P4_IQ_CCCR2,     0},15, PFM_REGT_NHTCCCR}, /*    IQ_CCCR2   */
+ 	/*pmc 61*/    {{MSR_P4_IQ_CCCR3,     0},16, PFM_REGT_NHTCCCR}, /*    IQ_CCCR3   */
+ 	/*pmc 62*/    {{MSR_P4_IQ_CCCR5,     0},17, PFM_REGT_NHTCCCR}, /*    IQ_CCCR5   */
+ 	/*pmc 63*/    {{0x3f2,     0}, 0, PFM_REGT_NHTPEBS},/* PEBS_MATRIX_VERT */
+ 	/*pmc 64*/    {{0x3f1,     0}, 0, PFM_REGT_NHTPEBS} /* PEBS_ENABLE   */
+ },
+
+ .pmd_addrs = {
+ 	/*pmd 0 */    {{MSR_P4_BPU_PERFCTR0, MSR_P4_BPU_PERFCTR2}, 0, PFM_REGT_CTR},  /*   BPU_CTR0,2  */
+ 	/*pmd 1 */    {{MSR_P4_BPU_PERFCTR1, MSR_P4_BPU_PERFCTR3}, 0, PFM_REGT_CTR},  /*   BPU_CTR1,3  */
+ 	/*pmd 2 */    {{MSR_P4_MS_PERFCTR0, MSR_P4_MS_PERFCTR2}, 0, PFM_REGT_CTR},  /*    MS_CTR0,2  */
+ 	/*pmd 3 */    {{MSR_P4_MS_PERFCTR1, MSR_P4_MS_PERFCTR3}, 0, PFM_REGT_CTR},  /*    MS_CTR1,3  */
+ 	/*pmd 4 */    {{MSR_P4_FLAME_PERFCTR0, MSR_P4_FLAME_PERFCTR2}, 0, PFM_REGT_CTR},  /* FLAME_CTR0,2  */
+ 	/*pmd 5 */    {{MSR_P4_FLAME_PERFCTR1, MSR_P4_FLAME_PERFCTR3}, 0, PFM_REGT_CTR},  /* FLAME_CTR1,3  */
+ 	/*pmd 6 */    {{MSR_P4_IQ_PERFCTR0, MSR_P4_IQ_PERFCTR2}, 0, PFM_REGT_CTR},  /*    IQ_CTR0,2  */
+ 	/*pmd 7 */    {{MSR_P4_IQ_PERFCTR1, MSR_P4_IQ_PERFCTR3}, 0, PFM_REGT_CTR},  /*    IQ_CTR1,3  */
+ 	/*pmd 8 */    {{MSR_P4_IQ_PERFCTR4, MSR_P4_IQ_PERFCTR5}, 0, PFM_REGT_CTR},  /*    IQ_CTR4,5  */
+ 	/*
+ 	 * non HT extensions
+ 	 */
+ 	/*pmd 9 */    {{MSR_P4_BPU_PERFCTR2,     0}, 0, PFM_REGT_NHTCTR},  /*   BPU_CTR2    */
+ 	/*pmd 10*/    {{MSR_P4_BPU_PERFCTR3,     0}, 0, PFM_REGT_NHTCTR},  /*   BPU_CTR3    */
+ 	/*pmd 11*/    {{MSR_P4_MS_PERFCTR2,     0}, 0, PFM_REGT_NHTCTR},  /*    MS_CTR2    */
+ 	/*pmd 12*/    {{MSR_P4_MS_PERFCTR3,     0}, 0, PFM_REGT_NHTCTR},  /*    MS_CTR3    */
+ 	/*pmd 13*/    {{MSR_P4_FLAME_PERFCTR2,     0}, 0, PFM_REGT_NHTCTR},  /* FLAME_CTR2    */
+ 	/*pmd 14*/    {{MSR_P4_FLAME_PERFCTR3,     0}, 0, PFM_REGT_NHTCTR},  /* FLAME_CTR3    */
+ 	/*pmd 15*/    {{MSR_P4_IQ_PERFCTR2,     0}, 0, PFM_REGT_NHTCTR},  /*    IQ_CTR2    */
+ 	/*pmd 16*/    {{MSR_P4_IQ_PERFCTR3,     0}, 0, PFM_REGT_NHTCTR},  /*    IQ_CTR3    */
+ 	/*pmd 17*/    {{MSR_P4_IQ_PERFCTR5,     0}, 0, PFM_REGT_NHTCTR},  /*    IQ_CTR5    */
+ },
+ .pebs_ctr_idx = 8, /* thread0: IQ_CTR4, thread1: IQ_CTR5 */
+ .pmu_style  = PFM_X86_PMU_P4,
+};
+
+static struct pfm_reg_desc pfm_p4_pmc_desc[]={
+/* pmc0  */ PMC_D(PFM_REG_I, "BPU_ESCR0"  , 0x0, PFM_ESCR_RSVD, 0, MSR_P4_BPU_ESCR0),
+/* pmc1  */ PMC_D(PFM_REG_I, "IS_ESCR0"   , 0x0, PFM_ESCR_RSVD, 0, MSR_P4_IQ_ESCR0),
+/* pmc2  */ PMC_D(PFM_REG_I, "MOB_ESCR0"  , 0x0, PFM_ESCR_RSVD, 0, MSR_P4_MOB_ESCR0),
+/* pmc3  */ PMC_D(PFM_REG_I, "ITLB_ESCR0" , 0x0, PFM_ESCR_RSVD, 0, MSR_P4_ITLB_ESCR0),
+/* pmc4  */ PMC_D(PFM_REG_I, "PMH_ESCR0"  , 0x0, PFM_ESCR_RSVD, 0, MSR_P4_PMH_ESCR0),
+/* pmc5  */ PMC_D(PFM_REG_I, "IX_ESCR0"   , 0x0, PFM_ESCR_RSVD, 0, MSR_P4_IX_ESCR0),
+/* pmc6  */ PMC_D(PFM_REG_I, "FSB_ESCR0"  , 0x0, PFM_ESCR_RSVD, 0, MSR_P4_FSB_ESCR0),
+/* pmc7  */ PMC_D(PFM_REG_I, "BSU_ESCR0"  , 0x0, PFM_ESCR_RSVD, 0, MSR_P4_BSU_ESCR0),
+/* pmc8  */ PMC_D(PFM_REG_I, "MS_ESCR0"   , 0x0, PFM_ESCR_RSVD, 0, MSR_P4_MS_ESCR0),
+/* pmc9  */ PMC_D(PFM_REG_I, "TC_ESCR0"   , 0x0, PFM_ESCR_RSVD, 0, MSR_P4_TC_ESCR0),
+/* pmc10 */ PMC_D(PFM_REG_I, "TBPU_ESCR0" , 0x0, PFM_ESCR_RSVD, 0, MSR_P4_TBPU_ESCR0),
+/* pmc11 */ PMC_D(PFM_REG_I, "FLAME_ESCR0", 0x0, PFM_ESCR_RSVD, 0, MSR_P4_FLAME_ESCR0),
+/* pmc12 */ PMC_D(PFM_REG_I, "FIRM_ESCR0" , 0x0, PFM_ESCR_RSVD, 0, MSR_P4_FIRM_ESCR0),
+/* pmc13 */ PMC_D(PFM_REG_I, "SAAT_ESCR0" , 0x0, PFM_ESCR_RSVD, 0, MSR_P4_SAAT_ESCR0),
+/* pmc14 */ PMC_D(PFM_REG_I, "U2L_ESCR0"  , 0x0, PFM_ESCR_RSVD, 0, MSR_P4_U2L_ESCR0),
+/* pmc15 */ PMC_D(PFM_REG_I, "DAC_ESCR0"  , 0x0, PFM_ESCR_RSVD, 0, MSR_P4_DAC_ESCR0),
+/* pmc16 */ PMC_D(PFM_REG_I, "IQ_ESCR0"   , 0x0, PFM_ESCR_RSVD, 0, MSR_P4_IQ_ESCR0), /* only model 1 and 2*/
+/* pmc17 */ PMC_D(PFM_REG_I, "ALF_ESCR0"  , 0x0, PFM_ESCR_RSVD, 0, MSR_P4_ALF_ESCR0),
+/* pmc18 */ PMC_D(PFM_REG_I, "RAT_ESCR0"  , 0x0, PFM_ESCR_RSVD, 0, MSR_P4_RAT_ESCR0),
+/* pmc19 */ PMC_D(PFM_REG_I, "SSU_ESCR0"  , 0x0, PFM_ESCR_RSVD, 0, MSR_P4_SSU_ESCR0),
+/* pmc20 */ PMC_D(PFM_REG_I, "CRU_ESCR0"  , 0x0, PFM_ESCR_RSVD, 0, MSR_P4_CRU_ESCR0),
+/* pmc21 */ PMC_D(PFM_REG_I, "CRU_ESCR2"  , 0x0, PFM_ESCR_RSVD, 0, MSR_P4_CRU_ESCR2),
+/* pmc22 */ PMC_D(PFM_REG_I, "CRU_ESCR4"  , 0x0, PFM_ESCR_RSVD, 0, MSR_P4_CRU_ESCR4),
+/* pmc23 */ PMC_D(PFM_REG_I64, "BPU_CCCR0"  , PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_P4_NO64, MSR_P4_BPU_CCCR0),
+/* pmc24 */ PMC_D(PFM_REG_I64, "BPU_CCCR1"  , PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_P4_NO64, MSR_P4_BPU_CCCR1),
+/* pmc25 */ PMC_D(PFM_REG_I64, "MS_CCCR0"   , PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_P4_NO64, MSR_P4_MS_CCCR0),
+/* pmc26 */ PMC_D(PFM_REG_I64, "MS_CCCR1"   , PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_P4_NO64, MSR_P4_MS_CCCR1),
+/* pmc27 */ PMC_D(PFM_REG_I64, "FLAME_CCCR0", PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_P4_NO64, MSR_P4_FLAME_CCCR0),
+/* pmc28 */ PMC_D(PFM_REG_I64, "FLAME_CCCR1", PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_P4_NO64, MSR_P4_FLAME_CCCR1),
+/* pmc29 */ PMC_D(PFM_REG_I64, "IQ_CCCR0"   , PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_P4_NO64, MSR_P4_IQ_CCCR0),
+/* pmc30 */ PMC_D(PFM_REG_I64, "IQ_CCCR1"   , PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_P4_NO64, MSR_P4_IQ_CCCR1),
+/* pmc31 */ PMC_D(PFM_REG_I64, "IQ_CCCR4"   , PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_P4_NO64, MSR_P4_IQ_CCCR4),
+		/* No HT extension */
+/* pmc32 */ PMC_D(PFM_REG_I, "BPU_ESCR1"  , 0x0, PFM_ESCR_RSVD, 0, MSR_P4_BPU_ESCR1),
+/* pmc33 */ PMC_D(PFM_REG_I, "IS_ESCR1"   , 0x0, PFM_ESCR_RSVD, 0, MSR_P4_IS_ESCR1),
+/* pmc34 */ PMC_D(PFM_REG_I, "MOB_ESCR1"  , 0x0, PFM_ESCR_RSVD, 0, MSR_P4_MOB_ESCR1),
+/* pmc35 */ PMC_D(PFM_REG_I, "ITLB_ESCR1" , 0x0, PFM_ESCR_RSVD, 0, MSR_P4_ITLB_ESCR1),
+/* pmc36 */ PMC_D(PFM_REG_I, "PMH_ESCR1"  , 0x0, PFM_ESCR_RSVD, 0, MSR_P4_PMH_ESCR1),
+/* pmc37 */ PMC_D(PFM_REG_I, "IX_ESCR1"   , 0x0, PFM_ESCR_RSVD, 0, MSR_P4_IX_ESCR1),
+/* pmc38 */ PMC_D(PFM_REG_I, "FSB_ESCR1"  , 0x0, PFM_ESCR_RSVD, 0, MSR_P4_FSB_ESCR1),
+/* pmc39 */ PMC_D(PFM_REG_I, "BSU_ESCR1"  , 0x0, PFM_ESCR_RSVD, 0, MSR_P4_BSU_ESCR1),
+/* pmc40 */ PMC_D(PFM_REG_I, "MS_ESCR1"   , 0x0, PFM_ESCR_RSVD, 0, MSR_P4_MS_ESCR1),
+/* pmc41 */ PMC_D(PFM_REG_I, "TC_ESCR1"   , 0x0, PFM_ESCR_RSVD, 0, MSR_P4_TC_ESCR1),
+/* pmc42 */ PMC_D(PFM_REG_I, "TBPU_ESCR1" , 0x0, PFM_ESCR_RSVD, 0, MSR_P4_TBPU_ESCR1),
+/* pmc43 */ PMC_D(PFM_REG_I, "FLAME_ESCR1", 0x0, PFM_ESCR_RSVD, 0, MSR_P4_FLAME_ESCR1),
+/* pmc44 */ PMC_D(PFM_REG_I, "FIRM_ESCR1" , 0x0, PFM_ESCR_RSVD, 0, MSR_P4_FIRM_ESCR1),
+/* pmc45 */ PMC_D(PFM_REG_I, "SAAT_ESCR1" , 0x0, PFM_ESCR_RSVD, 0, MSR_P4_SAAT_ESCR1),
+/* pmc46 */ PMC_D(PFM_REG_I, "U2L_ESCR1"  , 0x0, PFM_ESCR_RSVD, 0, MSR_P4_U2L_ESCR1),
+/* pmc47 */ PMC_D(PFM_REG_I, "DAC_ESCR1"  , 0x0, PFM_ESCR_RSVD, 0, MSR_P4_DAC_ESCR1),
+/* pmc48 */ PMC_D(PFM_REG_I, "IQ_ESCR1"   , 0x0, PFM_ESCR_RSVD, 0, MSR_P4_IQ_ESCR1), /* only model 1 and 2 */
+/* pmc49 */ PMC_D(PFM_REG_I, "ALF_ESCR1"  , 0x0, PFM_ESCR_RSVD, 0, MSR_P4_ALF_ESCR1),
+/* pmc50 */ PMC_D(PFM_REG_I, "RAT_ESCR1"  , 0x0, PFM_ESCR_RSVD, 0, MSR_P4_RAT_ESCR1),
+/* pmc51 */ PMC_D(PFM_REG_I, "CRU_ESCR1"  , 0x0, PFM_ESCR_RSVD, 0, MSR_P4_CRU_ESCR1),
+/* pmc52 */ PMC_D(PFM_REG_I, "CRU_ESCR3"  , 0x0, PFM_ESCR_RSVD, 0, MSR_P4_CRU_ESCR3),
+/* pmc53 */ PMC_D(PFM_REG_I, "CRU_ESCR5"  , 0x0, PFM_ESCR_RSVD, 0, MSR_P4_CRU_ESCR5),
+/* pmc54 */ PMC_D(PFM_REG_I64, "BPU_CCCR2"  , PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_P4_NO64, MSR_P4_BPU_CCCR2),
+/* pmc55 */ PMC_D(PFM_REG_I64, "BPU_CCCR3"  , PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_P4_NO64, MSR_P4_BPU_CCCR3),
+/* pmc56 */ PMC_D(PFM_REG_I64, "MS_CCCR2"   , PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_P4_NO64, MSR_P4_MS_CCCR2),
+/* pmc57 */ PMC_D(PFM_REG_I64, "MS_CCCR3"   , PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_P4_NO64, MSR_P4_MS_CCCR3),
+/* pmc58 */ PMC_D(PFM_REG_I64, "FLAME_CCCR2", PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_P4_NO64, MSR_P4_FLAME_CCCR2),
+/* pmc59 */ PMC_D(PFM_REG_I64, "FLAME_CCCR3", PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_P4_NO64, MSR_P4_FLAME_CCCR3),
+/* pmc60 */ PMC_D(PFM_REG_I64, "IQ_CCCR2"   , PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_P4_NO64, MSR_P4_IQ_CCCR2),
+/* pmc61 */ PMC_D(PFM_REG_I64, "IQ_CCCR3"   , PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_P4_NO64, MSR_P4_IQ_CCCR3),
+/* pmc62 */ PMC_D(PFM_REG_I64, "IQ_CCCR5"   , PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_P4_NO64, MSR_P4_IQ_CCCR5),
+/* pmc63 */ PMC_D(PFM_REG_I, "PEBS_MATRIX_VERT", 0, 0x13, 0, 0x3f2),
+/* pmc64 */ PMC_D(PFM_REG_I, "PEBS_ENABLE", 0, 0x3000fff, 0, 0x3f1)
+};
+#define PFM_P4_NUM_PMCS ARRAY_SIZE(pfm_p4_pmc_desc)
+
+/*
+ * See section 15.10.6.6 for details about the IQ block
+ */
+static struct pfm_reg_desc pfm_p4_pmd_desc[]={
+/* pmd0  */ PMD_D(PFM_REG_C, "BPU_CTR0", MSR_P4_BPU_PERFCTR0),
+/* pmd1  */ PMD_D(PFM_REG_C, "BPU_CTR1", MSR_P4_BPU_PERFCTR1),
+/* pmd2  */ PMD_D(PFM_REG_C, "MS_CTR0", MSR_P4_MS_PERFCTR0),
+/* pmd3  */ PMD_D(PFM_REG_C, "MS_CTR1", MSR_P4_MS_PERFCTR1),
+/* pmd4  */ PMD_D(PFM_REG_C, "FLAME_CTR0", MSR_P4_FLAME_PERFCTR0),
+/* pmd5  */ PMD_D(PFM_REG_C, "FLAME_CTR1", MSR_P4_FLAME_PERFCTR1),
+/* pmd6  */ PMD_D(PFM_REG_C, "IQ_CTR0", MSR_P4_IQ_PERFCTR0),
+/* pmd7  */ PMD_D(PFM_REG_C, "IQ_CTR1", MSR_P4_IQ_PERFCTR1),
+/* pmd8  */ PMD_D(PFM_REG_C, "IQ_CTR4", MSR_P4_IQ_PERFCTR4),
+		/* no HT extension */
+/* pmd9  */ PMD_D(PFM_REG_C, "BPU_CTR2", MSR_P4_BPU_PERFCTR2),
+/* pmd10 */ PMD_D(PFM_REG_C, "BPU_CTR3", MSR_P4_BPU_PERFCTR3),
+/* pmd11 */ PMD_D(PFM_REG_C, "MS_CTR2", MSR_P4_MS_PERFCTR2),
+/* pmd12 */ PMD_D(PFM_REG_C, "MS_CTR3", MSR_P4_MS_PERFCTR3),
+/* pmd13 */ PMD_D(PFM_REG_C, "FLAME_CTR2", MSR_P4_FLAME_PERFCTR2),
+/* pmd14 */ PMD_D(PFM_REG_C, "FLAME_CTR3", MSR_P4_FLAME_PERFCTR3),
+/* pmd15 */ PMD_D(PFM_REG_C, "IQ_CTR2", MSR_P4_IQ_PERFCTR1),
+/* pmd16 */ PMD_D(PFM_REG_C, "IQ_CTR3", MSR_P4_IQ_PERFCTR3),
+/* pmd17 */ PMD_D(PFM_REG_C, "IQ_CTR5", MSR_P4_IQ_PERFCTR5)
+};
+#define PFM_P4_NUM_PMDS ARRAY_SIZE(pfm_p4_pmd_desc)
+
+/*
+ * Due to hotplug CPU support, threads may not necessarily
+ * be activated at the time the module is inserted. We need
+ * to check whether  they could be activated by looking at
+ * the present CPU (present != online).
+ */
+static int pfm_p4_probe_pmu(void)
+{
+	unsigned int i, has_ht;
+
+	/*
+	 * only works on Intel processors
+	 */
+	if (cpu_data->x86_vendor != X86_VENDOR_INTEL) {
+		PFM_INFO("not running on Intel processor");
+		return -1;
+	}
+
+	if (cpu_data->x86 != 15) {
+		PFM_INFO("unsupported family=%d", cpu_data->x86);
+		return -1;
+	}
+
+	switch(cpu_data->x86_model) {
+		case 0 ... 2:
+			break;
+		case 3 ... 6:
+			/*
+			 * IQ_ESCR0, IQ_ESCR1 only present on model 1, 2
+			 */
+			pfm_p4_pmc_desc[16].type = PFM_REG_NA;
+			pfm_p4_pmc_desc[48].type = PFM_REG_NA;
+			break;
+		default:
+			/*
+			 * do not know if they all work the same, so reject
+			 * for now
+			 */
+			if (force == 0) {
+				PFM_INFO("unknown model %d", cpu_data->x86_model);
+				return -1;
+			}
+	}
+
+	/*
+	 * check for local APIC (required)
+	 */
+	if (!cpu_has_apic) {
+		PFM_INFO("no local APIC, unsupported");
+		return -1;
+	}
+	has_ht = is_multithreading_enabled();
+	PFM_INFO("cores/package=%d threads/core=%d",
+		 cpu_data->x86_max_cores,
+		 has_ht);
+
+	if (cpu_has_ht) {
+
+		PFM_INFO("HyperThreading supported, status %s",
+			 has_ht ? "on": "off");
+		/*
+		 * disable registers not supporting HT
+		 */
+		if (has_ht) {
+			PFM_INFO("disabling half the registers for HT");
+			for (i = 0; i < PFM_P4_NUM_PMCS; i++) {
+				if (pfm_p4_pmu_info.pmc_addrs[(i)].reg_type &
+				    PFM_REGT_NOHT)
+					pfm_p4_pmc_desc[i].type = PFM_REG_NA;
+			}
+			for (i = 0; i < PFM_P4_NUM_PMDS; i++) {
+				if (pfm_p4_pmu_info.pmd_addrs[(i)].reg_type &
+				    PFM_REGT_NOHT)
+					pfm_p4_pmd_desc[i].type = PFM_REG_NA;
+			}
+		}
+	}
+
+	if (cpu_has_ds) {
+		PFM_INFO("Data Save Area (DS) supported");
+
+		pfm_p4_pmu_info.flags = PFM_X86_PMU_DS;
+
+		if (cpu_has_pebs) {
+			/*
+			 * PEBS does not work with HyperThreading enabled
+			 */
+	                if (has_ht) {
+				pfm_p4_pmu_info.flags |= PFM_X86_PMU_PEBS;
+				PFM_INFO("PEBS supported, status on");
+			} else {
+				PFM_INFO("PEBS supported, status off (because of HT)");
+			}
+		}
+	}
+
+	/*
+	 * XXX: we *CURRENTLY*  force a failure is NMI watchdog is active due to a
+	 *      some difficulties in implementing the pfm_handle_nmi() function
+	 *      for P4 due to possible deadlock due a potential race between NMI
+	 *      interrupt handler and context locking (because we need to freeze
+	 *      PMU).
+	 */
+	if (nmi_watchdog == NMI_LOCAL_APIC) {
+		PFM_INFO("NMI watchdog using CRU_ESCR0/IQ_CCR0/IQ_CTR0,"
+			 "cannot *currently share NMI interrupt,"
+			 "reboot with nmi_watchdog=0");
+		return -1;
+#if 0
+		pfm_p4_pmc_desc[20].type = PFM_REG_NA; /* CRU_ESCR0 */
+		pfm_p4_pmc_desc[29].type = PFM_REG_NA; /* IQ_CCCR0 */
+		pfm_p4_pmd_desc[6].type = PFM_REG_NA;  /* IQ_CTR0 */
+
+		pfm_p4_pmu_info.pmc_addrs[20].reg_type = PFM_REGT_NA;
+		pfm_p4_pmu_info.pmc_addrs[29].reg_type = PFM_REGT_NA;
+		pfm_p4_pmu_info.pmd_addrs[6].reg_type = PFM_REGT_NA;
+#endif
+		/*
+		 * in HT CRU_ESCR1, IQ_CCCR1, IQ_CTR1 become automatically
+		 * become automatically unavailable because they are never
+		 * exposed to users. They are accessed ONLY if IQ_CCCR0 is
+		 * used.
+		 */
+	}
+	return 0;
+}
+
+static struct pfm_pmu_config pfm_p4_pmu_conf={
+	.pmu_name = "Intel P4",
+	.counter_width = 40,
+	.pmd_desc = pfm_p4_pmd_desc,
+	.pmc_desc = pfm_p4_pmc_desc,
+	.num_pmc_entries = PFM_P4_NUM_PMCS,
+	.num_pmd_entries = PFM_P4_NUM_PMDS,
+	.probe_pmu = pfm_p4_probe_pmu,
+	.version = "1.0",
+	.flags = PFM_PMU_BUILTIN_FLAG,
+	.owner = THIS_MODULE,
+	.arch_info = &pfm_p4_pmu_info
+};
+	
+static int __init pfm_p4_pmu_init_module(void)
+{
+	return pfm_pmu_register(&pfm_p4_pmu_conf);
+}
+
+static void __exit pfm_p4_pmu_cleanup_module(void)
+{
+	pfm_pmu_unregister(&pfm_p4_pmu_conf);
+}
+
+module_init(pfm_p4_pmu_init_module);
+module_exit(pfm_p4_pmu_cleanup_module);
--- linux-2.6.18.base/arch/i386/perfmon/perfmon_p4_pebs_smpl.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.18/arch/i386/perfmon/perfmon_p4_pebs_smpl.c	2006-09-25 12:12:58.000000000 -0700
@@ -0,0 +1,254 @@
+/*
+ * Copyright (c) 2005-2006 Hewlett-Packard Development Company, L.P.
+ * Contributed by Stephane Eranian <eranian@hpl.hp.com>
+ *
+ * This file implements the PEBS sampling format for 32-bit
+ * and 64-bit Pentium 4/Xeon processors.
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
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/sysctl.h>
+#include <asm/msr.h>
+
+#include <linux/perfmon.h>
+#include <asm/perfmon_p4_pebs_smpl.h>
+
+MODULE_AUTHOR("Stephane Eranian <eranian@hpl.hp.com>");
+MODULE_DESCRIPTION("Intel Precise Event-Based Sampling (PEBS)");
+MODULE_LICENSE("GPL");
+
+#define ALIGN_PEBS(a, order) \
+		((a)+(1UL<<(order))-1) & ~((1UL<<(order))-1)
+
+#define PEBS_PADDING_ORDER 8 /* log2(256) padding for PEBS alignment constraint */
+
+static int pfm_pebs_fmt_validate(u32 flags, u16 npmds, void *data)
+{
+	struct pfm_p4_pebs_smpl_arg *arg = data;
+	size_t min_buf_size;
+
+	/*
+	 * need to define at least the size of the buffer
+	 */
+	if (data == NULL) {
+		PFM_DBG("no argument passed");
+		return -EINVAL;
+	}
+
+	/*
+	 * compute min buf size. npmds is the maximum number
+	 * of implemented PMD registers.
+	 */
+	min_buf_size = sizeof(struct pfm_p4_pebs_smpl_hdr)
+		     + sizeof(struct pfm_p4_pebs_smpl_entry);
+
+	PFM_DBG("validate flags=0x%x min_buf_size=%zu buf_size=%zu",
+		  flags,
+		  min_buf_size,
+		  arg->buf_size);
+
+	/*
+	 * must hold at least the buffer header + one minimally sized entry
+	 */
+	if (arg->buf_size < min_buf_size)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int pfm_pebs_fmt_get_size(unsigned int flags, void *data, size_t *size)
+{
+	struct pfm_p4_pebs_smpl_arg *arg = data;
+
+	/*
+	 * size has been validated in pfm_pebs_fmt_validate()
+	 * we add space for the DS AREA + padding for alignment
+	 * The extra sotrage requests is taken into account 
+	 * for maximum buffer size limit as it represents actual
+	 * kernel memory.
+	 */
+	*size = arg->buf_size
+	      + sizeof(struct pfm_p4_ds_area)
+	      + (1UL<<PEBS_PADDING_ORDER); /* padding for alignment */
+
+	return 0;
+}
+
+static int pfm_pebs_fmt_init(struct pfm_context *ctx, void *buf,
+			     u32 flags, u16 npmds, void *data)
+{
+	struct pfm_arch_context *ctx_arch;
+	struct pfm_p4_pebs_smpl_hdr *hdr;
+	struct pfm_p4_pebs_smpl_arg *arg = data;
+	unsigned long pebs_start, pebs_end;
+	struct pfm_p4_ds_area *ds;
+
+	ctx_arch = pfm_ctx_arch(ctx);
+
+	hdr = buf;
+	ds = &hdr->ds;
+
+	/*
+	 * align PEBS buffer base
+	 */
+	pebs_start = ALIGN_PEBS((unsigned long)(hdr+1), PEBS_PADDING_ORDER);
+	pebs_end = pebs_start + arg->buf_size + 1;
+
+	hdr->version = PFM_P4_PEBS_SMPL_VERSION;
+	hdr->buf_size = arg->buf_size;
+	hdr->overflows = 0;
+
+	/*
+	 * express PEBS buffer base as offset from the end of the header
+	 */
+	hdr->start_offs = pebs_start - (unsigned long)(hdr+1);
+
+	/*
+	 * PEBS buffer boundaries
+	 */
+	ds->pebs_buf_base = pebs_start;
+	ds->pebs_abs_max = pebs_end;
+
+	/*
+	 * PEBS starting position
+	 */
+	ds->pebs_index = pebs_start;
+
+	/*
+	 * PEBS interrupt threshold
+	 */
+	ds->pebs_intr_thres = pebs_start
+			    + arg->intr_thres
+			    * sizeof(struct pfm_p4_pebs_smpl_entry);
+
+	/*
+	 * save counter reset value for IQ_CCCR4
+	 */
+	ds->pebs_cnt_reset = arg->cnt_reset;
+
+	/*
+	 * keep track of DS AREA
+	 */
+	ctx_arch->ds_area = (unsigned long)ds;
+
+	PFM_DBG("buffer=%p buf_size=%llu offs=%llu pebs_start=0x%lx "
+		  "pebs_end=0x%lx ds=%p pebs_thres=0x%lx cnt_reset=0x%llx",
+		  buf,
+		  (unsigned long long)hdr->buf_size,
+		  (unsigned long long)hdr->start_offs,
+		  pebs_start,
+		  pebs_end,
+		  ds,
+		  ds->pebs_intr_thres,
+		  (unsigned long long)ds->pebs_cnt_reset);
+
+	return 0;
+}
+
+static int pfm_pebs_fmt_handler(void *buf, struct pfm_ovfl_arg *arg,
+			       unsigned long ip, u64 tstamp, void *data)
+{
+	struct pfm_p4_pebs_smpl_hdr *hdr;
+
+	hdr = buf;
+
+	PFM_DBG_ovfl("buffer full");
+	/*
+	 * increment number of buffer overflows.
+	 * important to detect duplicate set of samples.
+	 */
+	hdr->overflows++;
+
+	/*
+	 * request notification and masking of monitoring.
+	 * Notification is still subject to the overflowed
+	 * register having the FL_NOTIFY flag set.
+	 */
+	arg->ovfl_ctrl = PFM_OVFL_CTRL_NOTIFY| PFM_OVFL_CTRL_MASK;
+
+	return -ENOBUFS; /* we are full, sorry */
+}
+
+static int pfm_pebs_fmt_restart(int is_active, pfm_flags_t *ovfl_ctrl,
+				void *buf)
+{
+	struct pfm_p4_pebs_smpl_hdr *hdr = buf;
+
+	/*
+	 * reset index to base of buffer
+	 */
+	hdr->ds.pebs_index = hdr->ds.pebs_buf_base;
+
+	*ovfl_ctrl = PFM_OVFL_CTRL_RESET;
+
+	return 0;
+}
+
+static int pfm_pebs_fmt_exit(void *buf)
+{
+	return 0;
+}
+
+static struct pfm_smpl_fmt pebs_fmt={
+	.fmt_name = "PEBS",
+	.fmt_uuid = PFM_P4_PEBS_SMPL_UUID,
+	.fmt_arg_size = sizeof(struct pfm_p4_pebs_smpl_arg),
+	.fmt_validate = pfm_pebs_fmt_validate,
+	.fmt_getsize = pfm_pebs_fmt_get_size,
+	.fmt_init = pfm_pebs_fmt_init,
+	.fmt_handler = pfm_pebs_fmt_handler,
+	.fmt_restart = pfm_pebs_fmt_restart,
+	.fmt_exit = pfm_pebs_fmt_exit,
+	.fmt_flags = PFM_FMT_BUILTIN_FLAG,
+	.owner = THIS_MODULE,
+};
+
+static int __init pfm_pebs_fmt_init_module(void)
+{
+	int l1, l2;
+
+	if (!cpu_has_ds) {
+		PFM_INFO("processor does not have Data Save Area (DS)");
+		return -1;
+	}
+
+	rdmsr(MSR_IA32_MISC_ENABLE, l1, l2);
+	if ((l1 & (1<<12))) {
+		PFM_INFO("processor does not support PEBS");
+		return -1;
+	}
+
+#ifdef CONFIG_SMP
+	if (cpu_has_ht && cpus_weight(cpu_sibling_map[0]) > 1) {
+		PFM_INFO("PEBS not available because HyperThreading in on");
+		return -1;
+	}
+#endif
+	return pfm_fmt_register(&pebs_fmt);
+}
+
+static void __exit pfm_pebs_fmt_cleanup_module(void)
+{
+	pfm_fmt_unregister(pebs_fmt.fmt_uuid);
+}
+
+module_init(pfm_pebs_fmt_init_module);
+module_exit(pfm_pebs_fmt_cleanup_module);
--- linux-2.6.18.base/arch/i386/perfmon/perfmon_p6.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.18/arch/i386/perfmon/perfmon_p6.c	2006-09-25 12:13:08.000000000 -0700
@@ -0,0 +1,162 @@
+/*
+ * This file contains the P6 family processor PMU register description tables
+ * and pmc checker used by perfmon.c. This module support original P6 processors
+ * (Pentium II, Pentium Pro, Pentium III) and Pentium M.
+ *
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
+#include <asm/msr.h>
+#include <asm/nmi.h>
+
+MODULE_AUTHOR("Stephane Eranian <eranian@hpl.hp.com>");
+MODULE_DESCRIPTION("P6 PMU description table");
+MODULE_LICENSE("GPL");
+
+/*
+ * - upper 32 bits are reserved
+ * - INT: APIC enable bit is reserved (forced to 1)
+ * - bit 21 is reserved
+ *
+ * RSVD: bit=0 means reserved
+ *
+ */
+#define PFM_P6_PMC_RSVD	~((~((PFM_ONE_64<<32)-1)) \
+			| (PFM_ONE_64<<20) \
+			| (PFM_ONE_64<<21))
+
+/*
+ * force Local APIC interrupt on overflow
+ * disable with NO_EMUL64
+ */
+#define PFM_P6_PMC_VAL  (PFM_ONE_64<<20)
+#define PFM_P6_NO64	(PFM_ONE_64<<20)
+
+/*
+ * physical addresses of MSR control the perfsel and perfctr registers
+ */
+struct pfm_arch_pmu_info pfm_p6_pmu_info={
+	.pmc_addrs = {
+		{{MSR_P6_EVNTSEL0, 0}, 0, PFM_REGT_EN}, /* has enable bit */
+		{{MSR_P6_EVNTSEL1, 0}, 1, PFM_REGT_OTH} /* no enable bit  */
+	},
+	.pmd_addrs = {
+		{{MSR_P6_PERFCTR0, 0}, 0, PFM_REGT_CTR},
+		{{MSR_P6_PERFCTR1, 0}, 0, PFM_REGT_CTR}
+	},
+	.pmu_style = PFM_X86_PMU_P6,
+};
+
+static struct pfm_reg_desc pfm_p6_pmc_desc[]={
+/* pmc0  */ PMC_D(PFM_REG_I64, "PERFEVTSEL0", PFM_P6_PMC_VAL, PFM_P6_PMC_RSVD, PFM_P6_NO64, MSR_P6_EVNTSEL0),
+/* pmc1  */ PMC_D(PFM_REG_I64, "PERFEVTSEL1", PFM_P6_PMC_VAL, PFM_P6_PMC_RSVD, PFM_P6_NO64, MSR_P6_EVNTSEL1)
+};
+#define PFM_P6_NUM_PMCS	ARRAY_SIZE(pfm_p6_pmc_desc)
+
+static struct pfm_reg_desc pfm_p6_pmd_desc[]={
+/* pmd0  */ PMD_D(PFM_REG_C  , "PERFCTR0", MSR_P6_PERFCTR0),
+/* pmd1  */ PMD_D(PFM_REG_C  , "PERFCTR1", MSR_P6_PERFCTR1)
+};
+#define PFM_P6_NUM_PMDS ARRAY_SIZE(pfm_p6_pmd_desc)
+
+static int pfm_p6_probe_pmu(void)
+{
+	int high, low;
+
+	if (cpu_data->x86_vendor != X86_VENDOR_INTEL) {
+		PFM_INFO("not an Intel processor");
+		return -1;
+	}
+
+	/*
+	 * check for P6 processor family
+	 */
+	if (cpu_data->x86 != 6) {
+		PFM_INFO("unsupported family=%d", cpu_data->x86);
+		return -1;
+	}
+
+	switch(cpu_data->x86_model) {
+		case 3:
+		case 7 ... 11:
+			break;
+		case 13:
+			/* for Pentium M, we need to check if PMU exist */
+			rdmsr(MSR_IA32_MISC_ENABLE, low, high);
+			if (low & (1U << 7))
+				break;
+		default:
+			PFM_INFO("unsupported CPU model %d",
+				 cpu_data->x86_model);
+			return -1;
+
+	}
+
+	if (!cpu_has_apic) {
+		PFM_INFO("no Local APIC, unsupported");
+		return -1;
+	}
+
+	/*
+	 * we cannot have perfmon/nmi_watchdog running together as there
+	 * is only one enable bit for both counters and it is located in
+	 * PERFEVTSEL0 which is used by NMI watchdog
+	 */
+	if (nmi_watchdog == NMI_LOCAL_APIC) {
+		PFM_INFO("NMI watchdog using PERFEVTSEL0/PERTCTR0."
+			 "perfmon cannot work correctly, reboot with nmi_watchdog=0");
+		return -1;
+	}
+	return 0;
+}
+
+/*
+ * Counters have 40 bits implemented. However they are designed such
+ * that bits [32-39] are sign extensions of bit 31. As such the
+ * effective width of a counter for P6-like PMU is 31 bits only.
+ *
+ * See IA-32 Intel Architecture Software developer manual Vol 3b:
+ * system programming and section 18.17.2 in particular.
+ */
+static struct pfm_pmu_config pfm_p6_pmu_conf={
+	.pmu_name = "Intel P6 processor Family",
+	.counter_width = 31,
+	.pmd_desc = pfm_p6_pmd_desc,
+	.pmc_desc = pfm_p6_pmc_desc,
+	.num_pmc_entries = PFM_P6_NUM_PMCS,
+	.num_pmd_entries = PFM_P6_NUM_PMDS,
+	.probe_pmu = pfm_p6_probe_pmu,
+	.version = "1.0",
+	.flags = PFM_PMU_BUILTIN_FLAG,
+	.owner = THIS_MODULE,
+	.arch_info = &pfm_p6_pmu_info
+};
+	
+static int __init pfm_p6_pmu_init_module(void)
+{
+	return pfm_pmu_register(&pfm_p6_pmu_conf);
+}
+
+static void __exit pfm_p6_pmu_cleanup_module(void)
+{
+	pfm_pmu_unregister(&pfm_p6_pmu_conf);
+}
+
+module_init(pfm_p6_pmu_init_module);
+module_exit(pfm_p6_pmu_cleanup_module);
--- linux-2.6.18.base/include/asm-i386/perfmon.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.18/include/asm-i386/perfmon.h	2006-09-25 12:16:53.000000000 -0700
@@ -0,0 +1,319 @@
+/*
+ * Copyright (c) 2005-2006 Hewlett-Packard Development Company, L.P.
+ * Contributed by Stephane Eranian <eranian@hpl.hp.com>
+ *
+ * This file contains X86 Processor Family specific definitions
+ * for the perfmon interface. This covers P6, Pentium M, P4/Xeon
+ * (32-bit and 64-bit, i.e., EM64T) and AMD X86-64.
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
+#ifndef _ASM_I386_PERFMON_H_
+#define _ASM_I386_PERFMON_H_
+
+#ifdef __KERNEL__
+
+#define PFM_ARCH_HAS_IDLE_NOTIFIER 1
+
+#ifdef CONFIG_4KSTACKS
+#define PFM_ARCH_PMD_STK_ARG	2
+#define PFM_ARCH_PMC_STK_ARG	2
+#else
+#define PFM_ARCH_PMD_STK_ARG	4 /* about 700 bytes of stack space */
+#define PFM_ARCH_PMC_STK_ARG	4 /* about 200 bytes of stack space */
+#endif
+
+#include <asm/desc.h>
+#include <asm/apic.h>
+
+/*
+ * For P4/Xeon/EM64T:
+ * - bits 31 - 63 reserved
+ * - T1_OS and T1_USR bits are reserved - set depending on logical proc
+ *      user mode application should use T0_OS and T0_USR to indicate
+ */
+#define PFM_ESCR_RSVD  0x000000007ffffffc
+
+/*
+ * bitmask for reg_type
+ */
+#define PFM_REGT_NA	 0x00 /* not available */
+#define PFM_REGT_EN 	 0x01 /* has enable bit (cleared on ctxsw) */
+#define PFM_REGT_ESCR    0x02 /* P4: ESCR */
+#define PFM_REGT_CCCR    0x04 /* P4: CCCR */
+#define PFM_REGT_OTH 	 0x80 /* other type of register */
+#define PFM_REGT_PEBS	 0x10 /* PEBS related */
+#define PFM_REGT_NOHT    0x20 /* unavailable with HT */
+#define PFM_REGT_CTR     0x40 /* counter */
+
+/*
+ * This design and the partitioning of resources for SMT (hyper threads)
+ * is very static and limited due to limitations in the number of ESCRs
+ * and CCCRs per group.
+ */
+#define MAX_SMT_ID 1
+
+/*
+ * For extended register information in addition to address that is used
+ * at runtime to figure out the mapping of reg addresses to logical procs
+ * and association of registers to hardware specific features
+ */
+struct pfm_arch_ext_reg {
+	/*
+	 * one each for the logical CPUs.  Index 0 corresponds to T0 and
+	 * index 1 corresponds to T1.  Index 1 can be zero if no T1
+	 * complement reg exists.
+	 */
+	unsigned long addrs[MAX_SMT_ID+1];
+	unsigned int ctr;	/* for CCCR/PERFEVTSEL, associated counter */
+	unsigned int reg_type;
+};
+
+struct pfm_arch_pmu_info {
+	struct pfm_arch_ext_reg pmc_addrs[PFM_MAX_HW_PMCS];
+	struct pfm_arch_ext_reg pmd_addrs[PFM_MAX_HW_PMDS];
+	u64 enable_mask[PFM_PMC_BV]; /* PMC registers with enable bit */
+
+	u16 pebs_ctr_idx;  /* index of PEBS IQ_CTR4 counter  (for overflow) */
+	u16 flags;	   /* PMU feature flags */
+	u8  pmu_style;	   /* type of PMU interface (P4, P6) */
+};
+/*
+ * X86 PMU style
+ */
+
+#define PFM_X86_PMU_P4	1 /* Intel P4/Xeon/EM64T processor PMU */
+#define PFM_X86_PMU_P6	2 /* Intel P6/Pentium M, AMD X86-64 processor PMU */
+
+/*
+ * PMU feature flags
+ */
+#define PFM_X86_PMU_DS		0x1	/* Intel: support for Data Save Area (DS) */
+#define PFM_X86_PMU_PEBS	0x2	/* Intel: support PEBS (implies DS) */
+
+void __pfm_read_reg(const struct pfm_arch_ext_reg *xreg, u64 *val);
+void __pfm_write_reg(const struct pfm_arch_ext_reg *xreg, u64 val);
+
+static inline void pfm_arch_resend_irq(void)
+{
+	unsigned long val, dest;
+	/*
+	 * we cannot use hw_resend_irq() because it goes to
+	 * the I/O APIC. We need to go to the Local Apic.
+	 *
+	 * The "int vec" is not the right solution either
+	 * because it triggers a software intr. We need
+	 * to regenerate the interrupt and have it pended
+	 * until we unmask interrupts.
+	 *
+	 * Instead we send ourself an IPI on the perfmon
+	 * vector.
+	 */
+	val  = APIC_DEST_SELF|APIC_INT_ASSERT|
+	       APIC_DM_FIXED|LOCAL_PERFMON_VECTOR;
+	dest = apic_read(APIC_ID);
+	apic_write(APIC_ICR2, dest);
+	apic_write(APIC_ICR, val);
+
+}
+
+#define pfm_arch_serialize()	/* nothing */
+
+static inline void pfm_arch_write_pmc(struct pfm_context *ctx, unsigned int cnum, u64 value)
+{
+	struct pfm_arch_pmu_info *arch_info = pfm_pmu_conf->arch_info;
+	/*
+	 * we only write to the actual register when monitoring is
+	 * active (pfm_start was issued)
+	 */
+	if (ctx && ctx->flags.started == 0) return;
+
+	__pfm_write_reg(&arch_info->pmc_addrs[cnum], value);
+}
+
+static inline void pfm_arch_write_pmd(struct pfm_context *ctx, unsigned int cnum, u64 value)
+{
+	struct pfm_arch_pmu_info *arch_info = pfm_pmu_conf->arch_info;
+
+	/*
+	 * force upper bit set for counter to ensure overflow
+	 */
+	if (arch_info->pmd_addrs[cnum].reg_type & PFM_REGT_CTR)
+		value |= ~pfm_pmu_conf->ovfl_mask;
+
+	__pfm_write_reg(&arch_info->pmd_addrs[cnum], value);
+}
+
+static inline u64 pfm_arch_read_pmd(struct pfm_context *ctx, unsigned int cnum)
+{
+	struct pfm_arch_pmu_info *arch_info = pfm_pmu_conf->arch_info;
+	u64 tmp;
+	__pfm_read_reg(&arch_info->pmd_addrs[cnum], &tmp);
+	return tmp;
+}
+
+static inline u64 pfm_arch_read_pmc(struct pfm_context *ctx, unsigned int cnum)
+{
+	struct pfm_arch_pmu_info *arch_info = pfm_pmu_conf->arch_info;
+	u64 tmp;
+	__pfm_read_reg(&arch_info->pmc_addrs[cnum], &tmp);
+	return tmp;
+}
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
+		       struct pfm_context *ctx, struct pfm_event_set *set)
+{}
+
+static inline void pfm_arch_ctxswin_sys(struct task_struct *task,
+                       struct pfm_context *ctx, struct pfm_event_set *set)
+{}
+
+int  pfm_arch_init(void);
+void pfm_arch_init_percpu(void);
+
+int  pfm_arch_ctxswout_thread(struct task_struct *task,
+		      struct pfm_context *ctx, struct pfm_event_set *set);
+void pfm_arch_ctxswin_thread(struct task_struct *task,
+		      struct pfm_context *ctx, struct pfm_event_set *set);
+void pfm_arch_stop(struct task_struct *task,
+		   struct pfm_context *ctx, struct pfm_event_set *set);
+void pfm_arch_start(struct task_struct *task,
+		    struct pfm_context *ctx, struct pfm_event_set *set);
+void pfm_arch_restore_pmds(struct pfm_context *ctx, struct pfm_event_set *set);
+void pfm_arch_restore_pmcs(struct pfm_context *ctx, struct pfm_event_set *set);
+void pfm_arch_intr_freeze_pmu(struct pfm_context *ctx);
+void pfm_arch_intr_unfreeze_pmu(struct pfm_context *ctx);
+int  pfm_arch_pmu_config_init(struct pfm_pmu_config *cfg);
+char *pfm_arch_get_pmu_module_name(void);
+
+static inline void pfm_arch_unload_context(struct pfm_context *ctx,
+			     		   struct task_struct *task)
+{
+}
+
+static inline int pfm_arch_load_context(struct pfm_context *ctx,
+			  		struct task_struct *task)
+{
+	return 0;
+}
+
+static inline int pfm_arch_reserve_session(struct pfm_sessions *session,
+			     		   struct pfm_context *ctx,
+			     		   u32 cpu)
+{
+	return 0;
+}
+
+static inline void pfm_arch_release_session(struct pfm_sessions *session,
+			      		    struct pfm_context *ctx,
+			      		    u32 cpu)
+{}
+
+static inline void pfm_arch_mask_monitoring(struct pfm_context *ctx)
+{
+	/*
+	 * on IA-32 masking/unmasking uses start/stop
+	 * mechanism because it cannot be controlled from
+	 * userland
+	 */
+	pfm_arch_stop(current, ctx, ctx->active_set);
+}
+
+static inline void pfm_arch_unmask_monitoring(struct pfm_context *ctx)
+{
+	/*
+	 * on IA-32 masking/unmasking uses start/stop
+	 * mechanism because it cannot be controlled from
+	 * userland
+	 */
+	pfm_arch_start(current, ctx, ctx->active_set);
+
+}
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
+static inline int pfm_arch_context_initialize(struct pfm_context *ctx, u32 ctx_flags)
+{
+	return 0;
+}
+
+/*
+ * on all CPUs, the upper bits of a counter must be
+ * set in order for the overflow interrupt to happen. On overflow, the
+ * counter has wrapped around, and the upper bits are now cleared. This
+ * function set them back.
+ *
+ * The current version loses whatever is remaining in the counter,
+ * which is usually not zero but has a small count. In order not
+ * to loose this count, we do a read-modify-write to set the upper
+ * bits while preserving the low-order bits. This is slow but
+ * works.
+ */
+static inline void pfm_arch_ovfl_reset_pmd(struct pfm_context *ctx, unsigned int cnum)
+{
+	u64 val;
+	val = pfm_arch_read_pmd(ctx, cnum);
+	pfm_arch_write_pmd(ctx, cnum, val);
+}
+
+/*
+ * For Intel P4/Xeon/EM64T
+ */
+struct pfm_arch_context {
+	unsigned long	ds_area;	/* address of DS management area */
+	u32		flags;		/* arch-specific flags */
+};
+#define PFM_ARCH_CTX_SIZE	(sizeof(struct pfm_arch_context))
+
+asmlinkage void  pmu_interrupt(void);
+
+void pfm_handle_nmi(struct pt_regs *regs);
+
+#endif /* __KERNEL__ */
+#endif /* _ASM_I386_PERFMON_H_ */
--- linux-2.6.18.base/include/asm-i386/perfmon_p4_pebs_smpl.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.18/include/asm-i386/perfmon_p4_pebs_smpl.h	2006-09-25 12:17:03.000000000 -0700
@@ -0,0 +1,194 @@
+/*
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
+ *
+ * This file implements the sampling format to support Intel
+ * Pentium 4 Precise Event Based Sampling (PEBS) feature of Pentium 4
+ * processors.
+ *
+ * What is PEBS?
+ * ------------
+ *  This is a hardware feature to enhance sampling by providing
+ *  better precision as to where a sample is taken. This avoids the
+ *  typical skew in the instruction one can observe with any
+ *  interrupt-based sampling technique.
+ *
+ *  PEBS also lowers sampling overhead significantly by having the
+ *  processor store samples instead of the OS. PMU interrupt are only
+ *  generated after multiple samples are written.
+ *
+ *  Another benefit of PEBS is that samples can be captured inside
+ *  critical sections where interrupts are masked.
+ *
+ * How does it work?
+ *  PEBS effectively implements a Hw buffer. The Os must pass a region
+ *  of memory where samples are to be stored. The region can have any
+ *  size. The OS must also specify the sampling period to reload. The PMU
+ *  will interrupt when it reaches the end of the buffer or a specified
+ *  threshold location inside the memory region.
+ *
+ *  The description of the buffer is stored in the Data Save Area (DS).
+ *  The samples are stored sequentially in the buffer. The format of the
+ *  buffer is fixed and specified in the PEBS documentation.  The sample
+ *  format changes between 32-bit and 64-bit modes due to extended register
+ *  file.
+ *
+ *  PEBS does not work when HyperThreading is enabled due to certain MSR
+ *  being shared being to two threads.
+ *
+ *  What does the format do?
+ *   It provides access to the PEBS feature for both 32-bit and 64-bit
+ *   processors that support it.
+ *
+ *   The same code is used for both 32-bit and 64-bit mode, but different
+ *   UUID are used because the two modes are not compatible due to
+ *   data model and register file differences. Similarly the public data
+ *   structures describing the samples are different.
+ *
+ *   It is important to realize that the format provide a zero-copy environment
+ *   for the samples, i.e,, the OS never touches the samples. Whatever the
+ *   processor write is directly accessible to the user.
+ *
+ *   Parameters to the buffer can be passed via pfm_create_context() in
+ *   the pfm_p4_pebs_smpl_arg structure.
+ *
+ *   It is not possible to mix a 32-bit PEBS application on top of a 64-bit
+ *   host kernel.
+ */
+#ifndef __PERFMON_P4_PEBS_SMPL_H__
+#define __PERFMON_P4_PEBS_SMPL_H__ 1
+
+#ifdef __i386__
+/*
+ * UUId for the 32-bit PEBS format
+ */
+#define PFM_P4_PEBS_SMPL_UUID { \
+	0x0d, 0x85, 0x91, 0xe7, 0x49, 0x3f, 0x49, 0xae,\
+	0x8c, 0xfc, 0xe8, 0xb9, 0x33, 0xe4, 0xeb, 0x8b}
+#else
+#define PFM_P4_PEBS_SMPL_UUID { \
+	0x36, 0xbe, 0x97, 0x94, 0x1f, 0xbf, 0x41, 0xdf,\
+	0xb4, 0x63, 0x10, 0x62, 0xeb, 0x72, 0x9b, 0xad}
+#endif
+
+/*
+ * format specific parameters (passed at context creation)
+ *
+ * intr_thres: index from start of buffer of entry where the
+ * PMU interrupt must be triggered. It must be several samples
+ * short of the end of the buffer.
+ */
+struct pfm_p4_pebs_smpl_arg {
+	u64 cnt_reset;		/* counter reset value */
+	size_t buf_size;	/* size of the buffer in bytes */
+	size_t intr_thres;	/* index of interrupt threshold entry */
+	u64 reserved[6];	/* for future use */
+};
+
+/*
+ * Data Save Area (32 and 64-bit mode)
+ *
+ * The DS area must be exposed to the user because this is the only
+ * way to report on the number of valid entries recorded by the CPU.
+ * This is required when the buffer is not full, i..e, there was not
+ * PMU interrupt.
+ * 
+ * Layout of the structure is mandated by hardware and specified in
+ * the Intel documentation.
+ */
+struct pfm_p4_ds_area {
+	unsigned long	bts_buf_base;
+	unsigned long	bts_index;
+	unsigned long	bts_abs_max;
+	unsigned long	bts_intr_thres;
+	unsigned long	pebs_buf_base;
+	unsigned long	pebs_index;
+	unsigned long	pebs_abs_max;
+	unsigned long	pebs_intr_thres;
+	u64     	pebs_cnt_reset;
+};
+
+/*
+ * This header is at the beginning of the sampling buffer returned to the user.
+ *
+ * Because of PEBS alignement constraints, the actual PEBS buffer area does
+ * not necessarily begin right after the header. The hdr_start_offs must be
+ * used to compute the first byte of the buffer. The offset is defined as
+ * the number of bytes between the end of the header and the beginning of
+ * the buffer. As such the formula is:
+ * 	actual_buffer = (unsigned long)(hdr+1)+hdr->hdr_start_offs
+ */
+struct pfm_p4_pebs_smpl_hdr {
+	u64 overflows;			/* #overflows for buffer */
+	size_t buf_size;		/* bytes in the buffer */
+	size_t start_offs; 		/* actual buffer start offset */
+	u32 version;			/* smpl format version */
+	u32 reserved1;			/* for future use */
+	u64 reserved2[5];		/* for future use */
+	struct pfm_p4_ds_area ds;	/* data save area */
+};
+
+/*
+ * P4 64-bit PEBS record format is described in
+ * http://www.intel.com/technology/64bitextensions/30083502.pdf
+ *
+ * The format does not peek at samples. The sample structure is only
+ * used to ensure that the buffer is large enough to accomodate one
+ * sample.
+ */
+#ifdef __i386__
+struct pfm_p4_pebs_smpl_entry {
+	u32	eflags;
+	u32	ip;
+	u32	eax;
+	u32	ebx;
+	u32	ecx;
+	u32	edx;
+	u32	esi;
+	u32	edi;
+	u32	ebp;
+	u32	esp;
+};
+#else
+struct pfm_p4_pebs_smpl_entry {
+	u64	eflags;
+	u64	ip;
+	u64	eax;
+	u64	ebx;
+	u64	ecx;
+	u64	edx;
+	u64	esi;
+	u64	edi;
+	u64	ebp;
+	u64	esp;
+	u64	r8;
+	u64	r9;
+	u64	r10;
+	u64	r11;
+	u64	r12;
+	u64	r13;
+	u64	r14;
+	u64	r15;
+};
+#endif
+
+#define PFM_P4_PEBS_SMPL_VERSION_MAJ 1U
+#define PFM_P4_PEBS_SMPL_VERSION_MIN 0U
+#define PFM_P4_PEBS_SMPL_VERSION (((PFM_P4_PEBS_SMPL_VERSION_MAJ&0xffff)<<16)|\
+				   (PFM_P4_PEBS_SMPL_VERSION_MIN & 0xffff))
+
+#endif /* __PERFMON_P4_PEBS_SMPL_H__ */
