Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932402AbWHWITi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbWHWITi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 04:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbWHWISd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 04:18:33 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:18173 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S932410AbWHWIRI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 04:17:08 -0400
Date: Wed, 23 Aug 2006 01:06:05 -0700
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200608230806.k7N8654c000504@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 14/18] 2.6.17.9 perfmon2 patch for review: new i386 files
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
	  operations such as save/restore/start/stop/detect overflow counters, ...

arch/i386/perfmon/perfmon_gen_ia32.c:
	- PMU description table for architectural perfmon, e.g., used by Core Duo/Core Solo

arch/i386/perfmon/perfmon_p4.c:
	- PMU description table for P4 (32 and 64 bit modes)

arch/i386/perfmon/perfmon_p4_pebs_smpl.c:
	- implement 32-bit PEBS sampling format

arch/i386/perfmon/perfmon_p6.c:
	- PMU description table for all P6-based processors, incl Pentium M

include/asm-i386/perfmon.h:
	- architecture specific header definitions

include/asm-i386/perfmon_p4_pebs_smpl.h:
	- public header file for 32-bit PEBS sampling format




--- linux-2.6.17.9.base/arch/i386/perfmon/Kconfig	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17.9/arch/i386/perfmon/Kconfig	2006-08-21 03:37:46.000000000 -0700
@@ -0,0 +1,55 @@
+menu "Hardware Performance Monitoring support"
+config PERFMON
+  	bool "Perfmon2 performance monitoring interface"
+	select X86_LOCAL_APIC
+	default y
+  	help
+  	Enables the perfmon2 interface to access the hardware
+	performance counters. See <http://perfmon2.sf.net/> for
+ 	more details. If you're unsure, say Y.
+
+config PERFMON_P6
+	tristate "Support for P6/Pentium M processor hardware performance counters"
+	depends on PERFMON
+	default m
+	help
+	Enables support for the P6-style hardware performance counters.
+	To be used for P6 processors (Pentium III, PentiumPro) and also
+	for Pentium M.
+	If unsure, say M.
+
+config PERFMON_P4
+	tristate "Support for 32-bit P4/Xeon hardware performance counters"
+	depends on PERFMON
+	default m
+	help
+	Enables support for the 32-bit P4/Xeon style hardware performance
+	counters.
+	If unsure, say M.
+
+config PERFMON_P4_PEBS
+	tristate "Support for Intel P4 PEBS sampling format"
+	depends on PERFMON_P4
+	default m
+	help
+	Enables support for Precise Event-Based Sampling (PEBS) on the Intel P4
+	processors which support it.  Does not work with P6 processors.
+	If unsure, say m.
+
+config PERFMON_GEN_IA32
+	tristate "Support for the architected IA-32 PMU"
+	depends on PERFMON
+	default m
+	help
+	Enables support for the architected IA-32 hardware performance counters.
+	You need a Core micro-architecture based processor for this to work.
+	If unsure, say M.
+
+config I386_PERFMON_K8
+       tristate "Support 32-bit mode AMD64 hardware performance counters"
+       depends on PERFMON
+       default m
+       help
+       Enables support for 32-bit mode AMD64 hardware performance counters.
+       If unsure, say m.
+endmenu
--- linux-2.6.17.9.base/arch/i386/perfmon/Makefile	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17.9/arch/i386/perfmon/Makefile	2006-08-21 03:37:46.000000000 -0700
@@ -0,0 +1,12 @@
+#
+# Copyright (c) 2005-2006 Hewlett-Packard Development Company, L.P.
+# Contributed by Stephane Eranian <eranian@hpl.hp.com>
+#
+obj-$(CONFIG_PERFMON)		+= perfmon.o
+obj-$(CONFIG_PERFMON_P6)	+= perfmon_p6.o
+obj-$(CONFIG_PERFMON_P4)	+= perfmon_p4.o
+obj-$(CONFIG_PERFMON_GEN_IA32)	+= perfmon_gen_ia32.o
+obj-$(CONFIG_PERFMON_P4_PEBS)	+= perfmon_p4_pebs_smpl.o
+obj-$(CONFIG_I386_PERFMON_K8)   += perfmon_amd64.o
+
+perfmon_amd64-$(subst m,y,$(CONFIG_I386_PERFMON_K8)) += ../../x86_64/perfmon/perfmon_amd64.o
--- linux-2.6.17.9.base/arch/i386/perfmon/perfmon.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17.9/arch/i386/perfmon/perfmon.c	2006-08-22 04:06:58.000000000 -0700
@@ -0,0 +1,1009 @@
+/*
+ * This file implements the IA-32/X86-64/EM64T specific
+ * support for the perfmon2 interface
+ *
+ * Copyright (c) 2005-2006 Hewlett-Packard Development Company, L.P.
+ * Contributed by Stephane Eranian <eranian@hpl.hp.com>
+ */
+#include <linux/interrupt.h>
+#include <linux/perfmon.h>
+
+#define MSR_IA32_PEBS_ENABLE	0x3f1 /* unique per-thread */
+#define MSR_IA32_DS_AREA	0x600 /* unique per-thread */
+
+#ifdef __i386__
+#define __pfm_wrmsrl(a, b) wrmsr((a), (b), 0)
+#else
+#define __pfm_wrmsrl(a, b) wrmsrl((a), (b))
+#endif
+
+/*
+ * Debug Store (DS) management area for 32 and 64 bit P4/Xeon PEBS
+ */
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
+asmlinkage void  pmu_interrupt(void);
+
+static int (*pfm_stop_active)(struct task_struct *task,
+			       struct pfm_context *ctx,
+			       struct pfm_event_set *set);
+
+static int pfm_nmi_watchdog;
+
+static inline void pfm_set_pce(void)
+{
+	write_cr4(read_cr4() | X86_CR4_PCE);
+}
+
+static inline void pfm_clear_pce(void)
+{
+	write_cr4(read_cr4() & ~X86_CR4_PCE);
+}
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
+
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
+	if (xreg->addrs[smt_id])
+		wrmsrl(xreg->addrs[smt_id], val);
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
+void pfm_arch_init_percpu(void)
+{
+	/*
+	 * We initialize APIC with LVTPC vector masked.
+	 *
+	 * this is motivated by the fact that the PMU may be
+	 * in a condition where it has already an interrupt pending.
+	 * Given that we cannot touch the PMU registers
+	 * at this point, we may not have a way to remove the condition.
+	 * As such, we need to keep the interrupt masked until a PMU
+	 * description is loaded. At that point, we can enable intr.
+	 *
+	 * If NMI is using local APIC, then the problem does not exist
+	 * because LAPIC has already been properly initialized.
+	 */
+	if (nmi_watchdog != NMI_LOCAL_APIC) {
+		apic_write(APIC_LVTPC, APIC_LVT_MASKED|LOCAL_PERFMON_VECTOR);
+		PFM_INFO("CPU%d APIC LVTPC vector masked", smp_processor_id());
+	} 
+}
+
+/*
+ * function called from pfm_load_context_*(). Task is not guaranteed to be
+ * current task. If not, then other task is guaranteed stopped and off any CPU.
+ * context is locked and interrupts are masked.
+ *
+ * On pfm_load_context(), the interface guarantees monitoring is stopped.
+ *
+ * For system-wide task is NULL
+ */
+int pfm_arch_load_context(struct pfm_context *ctx, struct task_struct *task)
+{
+	struct pfm_arch_context *ctx_arch;
+
+	ctx_arch = pfm_ctx_arch(ctx);
+
+	/*
+	 * always authorize user level rdpmc for self-monitoring
+	 * only. It is not possible to do this for system-wide because
+	 * thread may not be running on the monitored CPU.
+	 *
+	 * We set a private flag to avoid write cr4.ce on context switch
+	 * if not necessary as this is a very expensive operation.
+	 */
+	if (task == current) {
+		ctx_arch->flags |= PFM_X86_FL_INSECURE;
+		pfm_set_pce();
+		PFM_DBG("setting cr4.pce (rdpmc authorized at user level)");
+	}
+	return 0;
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
+ * called for both system-wide and per-thread.
+ * task is NULL for system-wide
+ */
+void pfm_arch_unload_context(struct pfm_context *ctx, struct task_struct *task)
+{
+	struct pfm_arch_context *ctx_arch;
+
+	ctx_arch = pfm_ctx_arch(ctx);
+
+	if (ctx_arch->flags & PFM_X86_FL_INSECURE) {
+		pfm_clear_pce();
+		ctx_arch->flags &= ~PFM_X86_FL_INSECURE;
+		PFM_DBG("clearing cr4.pce");
+	}
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
+
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
+		ds = ctx_arch->ds_area;
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
+		__pfm_wrmsrl(MSR_IA32_DS_AREA, ctx_arch->ds_area);
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
+
+	if (ctx_arch->flags & PFM_X86_FL_INSECURE)
+		pfm_set_pce();
+
+	/*
+	 * reload DS management area pointer. Pointer
+	 * not managed as a PMC thus it is not restored
+	 * with the rest of the registers.
+	 */
+	if (ctx_arch->ds_area)
+		__pfm_wrmsrl(MSR_IA32_DS_AREA, ctx_arch->ds_area);
+}
+
+static int __pfm_stop_active_p6(struct task_struct *task,
+				 struct pfm_context *ctx,
+				 struct pfm_event_set *set)
+{
+	struct pfm_arch_pmu_info *arch_info = pfm_pmu_conf->arch_info;
+	struct pfm_arch_ext_reg *xrc, *xrd;
+	u64 *cnt_mask, *pmds;
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
+			__pfm_wrmsrl(xrc[i].addrs[0], 0);
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
+	pmds = set->view->set_pmds;
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
+				val = (pmds[i] & ~ovfl_mask) | (val & ovfl_mask);
+			}
+			pmds[i] = val;
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
+		__pfm_wrmsrl(MSR_IA32_PEBS_ENABLE, 0);
+		__pfm_wrmsrl(MSR_IA32_DS_AREA, 0);
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
+		   struct pfm_event_set *set)
+{
+	if (task != current)
+		return;
+
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
+	if (unlikely(ctx_arch->flags & PFM_X86_FL_INSECURE))
+		pfm_clear_pce();
+
+	/*
+	 * disable lazy restore of PMCS on ctxswin because
+	 * we modify some of them.
+	 */
+	set->priv_flags |= PFM_SETFL_PRIV_MOD_PMCS;
+
+	return pfm_stop_active(task, ctx, set);
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
+	struct pfm_arch_pmu_info *arch_info = pfm_pmu_conf->arch_info;
+	struct pfm_arch_context *ctx_arch;
+	struct pfm_arch_ext_reg *xregs;
+	u64 *impl_mask;
+	u16 i, max_pmc;
+
+
+	ctx_arch = pfm_ctx_arch(ctx);
+	max_pmc = pfm_pmu_conf->max_pmc;
+	impl_mask = pfm_pmu_conf->impl_pmcs;
+	xregs = arch_info->pmc_addrs;
+
+	/*
+	 * we must actually install all implemented pmcs registers because
+	 * until started, we do not write any PMC registers. For P4-style,
+	 * touching only the CCCR (which have the enable field) is not enough.
+	 * On P6-style, all PMCs have an enable bit, so this is not worse.
+	 *
+	 * The registers that are actually not used have their default  value
+	 * such that the counter does not count anything. As such, we can afford
+	 * to write all of them but then stop only the one we use on stop and
+	 * ctxswout.
+	 */
+	for (i = 0; i < max_pmc; i++) {
+		if (pfm_bv_isset(impl_mask, i))
+			__pfm_write_reg(xregs+i, set->pmcs[i]);
+	}
+
+	/*
+	 * reload DS area pointer. PEBS_ENABLE is restored with the PMCs
+	 * in pfm_restore_pmcs(). PEBS_ENABLE is not considered part of
+	 * the set of PMCs with an enable bit. This is reserved for counter
+	 * PMC, i.e., CCCR.
+	 */
+	if (ctx_arch->ds_area) {
+		__pfm_wrmsrl(MSR_IA32_DS_AREA, ctx_arch->ds_area);
+		PFM_DBG("restoring DS");
+	}
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
+	if (task == current)
+		__pfm_arch_start(task, ctx, set);
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
+	struct pfm_arch_pmu_info *arch_info = pfm_pmu_conf->arch_info;
+	struct pfm_arch_ext_reg *xregs;
+	u64 ovfl_mask, val, *pmds;
+	u64 *impl_rw_mask, *cnt_mask;
+	u16 i, max_rw_pmd;
+
+	pmds = set->view->set_pmds;
+	impl_rw_mask = pfm_pmu_conf->impl_rw_pmds;
+	ovfl_mask = pfm_pmu_conf->ovfl_mask;
+	max_rw_pmd = pfm_pmu_conf->max_rw_pmd;
+	cnt_mask = pfm_pmu_conf->cnt_pmds;
+	xregs = arch_info->pmd_addrs;
+
+	/*
+	 * must restore all pmds to avoid leaking
+	 * especially when PFM_X86_FL_INSECURE is set.
+	 *
+	 * XXX: should check PFM_X86_FL_INSECURE==0 and use used_pmd instead
+	 */
+	for (i = 0; i < max_rw_pmd; i++) {
+		if (likely(pfm_bv_isset(impl_rw_mask, i))) {
+			val = pmds[i];
+			if (likely(pfm_bv_isset(cnt_mask, i)))
+				val |= ~ovfl_mask;
+			__pfm_write_reg(xregs+i, val);
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
+	if (arch_info->pmu_style == PFM_X86_PMU_P6) {
+		num = set->nused_pmcs;
+		mask = set->used_pmcs;
+	} else {
+		num = pfm_pmu_conf->num_pmcs;
+		mask = pfm_pmu_conf->impl_pmcs;
+	}
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
+	for (i = 0; num; i++) {
+		if (pfm_bv_isset(mask, i)) {
+			__pfm_write_reg(xregs+i, set->pmcs[i]);
+			num--;
+		}
+	}
+}
+
+fastcall void smp_pmu_interrupt(struct pt_regs *regs)
+{
+	ack_APIC_irq();
+	irq_enter();
+	pfm_interrupt_handler(LOCAL_PERFMON_VECTOR, NULL, regs);
+	irq_exit();
+	/*
+	 * On Intel P6, Pentium M, P4, EM64T:
+	 * 	- it is necessary to clear the MASK field for the LVTPC
+	 * 	  vector. Otherwise interrupts remain masked. See
+	 * 	  section 8.5.1
+	 * AMD X8-64:
+	 * 	- the documentation does not stipulate the behavior.
+	 * 	  To be safe, we also rewrite the vector to clear the
+	 * 	  mask field
+	 *
+	 * We only clear the mask field, if there is a PMU description
+	 * loaded. Otherwise we would have a problem  because without
+	 * PMU description we cannot access PMu registers to clear the
+	 * overfow condition and may end up in a flood of PMU interrupts.
+	 *
+	 * The APIC vector is initialized as masked, but we may already
+	 * have a pending PMU overflow by the time we get to
+	 * pfm_arch_init_percpu(). Such interrupt would generate a call
+	 * to this function, which would undo the masking and would
+	 * cause a flood.
+	 */
+	if (pfm_pmu_conf)
+		apic_write(APIC_LVTPC, LOCAL_PERFMON_VECTOR);
+}
+
+
+void pfm_vector_init(void)
+{
+	set_intr_gate(LOCAL_PERFMON_VECTOR, (void *)pmu_interrupt);
+	PFM_INFO("installed interrupt gate");
+}
+	
+static void __pfm_stop_one_pmu(void *dummy)
+{
+	struct pfm_arch_pmu_info *arch_info;
+	struct pfm_arch_ext_reg *xregs;
+	unsigned int i, num_pmcs;
+
+	PFM_DBG("stopping on CPU%d: LVT=0x%x",
+	        smp_processor_id(),
+		(unsigned int)apic_read(APIC_LVTPC));
+
+	num_pmcs = pfm_pmu_conf->num_pmcs;
+	arch_info = pfm_pmu_conf->arch_info;
+	xregs = arch_info->pmc_addrs;
+
+	for (i = 0; i < num_pmcs; i++)
+		if (pfm_bv_isset(arch_info->enable_mask, i))
+			__pfm_write_reg(xregs+i, 0);
+
+	/*
+	 * now that we have a PMU description we can deal with spurious
+	 * interrupts, thus we can safely re-enable the LVTPC vector
+	 * by clearing the mask field
+	 */
+	apic_write(APIC_LVTPC, LOCAL_PERFMON_VECTOR);
+	PFM_INFO("CPU%d installed APIC vector", smp_processor_id());
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
+int pfm_arch_pmu_config_check(struct pfm_pmu_config *cfg)
+{
+	struct pfm_arch_pmu_info *arch_info = cfg->arch_info;
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
+	return 0;
+}
+
+/*
+ * called from pfm_register_pmu_config() after the new
+ * config has been validated and installed. No lock
+ * is held. Interrupts are not masked.
+ *
+ * The role of the function is, based on the PMU description, to
+ * put the PMU into a quiet state on each CPU. This function is
+ * not necessary if there is an architected way of doing this
+ * for a processor family.
+ */
+void pfm_arch_pmu_config_init(void)
+{
+	/*
+	 * if NMI watchdog is using Local APIC, then
+	 * counters are already initialized to a decent
+	 * state
+	 */
+	if (nmi_watchdog == NMI_LOCAL_APIC)
+		return;
+
+	on_each_cpu(__pfm_stop_one_pmu, NULL, 1, 1);
+}
+	
+int pfm_arch_initialize(void)
+{
+	return 0;
+}
+
+void pfm_arch_mask_monitoring(struct pfm_context *ctx)
+{
+	/*
+	 * on IA-32 masking/unmasking uses start/stop
+	 * mechanism
+	 */
+	pfm_arch_stop(current, ctx, ctx->active_set);
+}
+
+void pfm_arch_unmask_monitoring(struct pfm_context *ctx)
+{
+	/*
+	 * on IA-32 masking/unmasking uses start/stop
+	 * mechanism
+	 */
+	__pfm_arch_start(current, ctx, ctx->active_set);
+}
+
+
+static void
+__pfm_reserve_lapic_nmi(void *data)
+{
+	PFM_DBG("rewrite APIC to perfmon");
+	apic_write(APIC_LVTPC, LOCAL_PERFMON_VECTOR);
+}
+
+static void
+__pfm_restart_lapic_nmi(void *dummy)
+{
+	PFM_DBG("restart APIC NMI");
+	setup_apic_nmi_watchdog();
+}
+
+static int
+pfm_reserve_lapic_nmi(void)
+{
+	int ret = 0;
+	unsigned long flags;
+
+	local_save_flags(flags);
+	local_irq_enable();
+
+
+	/*
+	 * keep track that we have disabled NMI watchdog
+	 */
+	pfm_nmi_watchdog = 1;
+
+	/*
+	 * The NMI LAPIC watchdog timer is active on every CPU, so we need
+	 * to reserve (disable) on each CPU. The problem is that the function
+	 * reserve_lapic_nmi() stops the NMI watchdog but only clears the
+	 * counters on the current CPU. The other counters on the other CPUs
+	 * keep on running until they overflow. At that point, they will be
+	 * treated as spurious interrupts by perfmon and the counters will not
+	 * be reloaded, so we are fine.
+	 */
+	ret = reserve_lapic_nmi();
+	if (ret)
+		goto skip;
+
+	/*
+	 * all cpu, incl. self
+	 */
+	on_each_cpu(__pfm_reserve_lapic_nmi, NULL, 0, 1);
+
+skip:
+	local_irq_restore(flags);
+
+	return ret;
+}
+
+static void
+pfm_release_lapic_nmi(void)
+{
+	unsigned long flags;
+
+	local_save_flags(flags);
+	local_irq_enable();
+
+	/*
+	 * must be done BEFORE setup_apic_nmi_watchdog()
+	 */
+	release_lapic_nmi();
+
+	/*
+	 * all cpu, incl self
+	 */
+	on_each_cpu( __pfm_restart_lapic_nmi, NULL, 0, 1);
+
+	pfm_nmi_watchdog = 0;
+
+	local_irq_restore(flags);
+}
+
+/*
+ * Called from pfm_release_session() after release is done.
+ * Holding pfs_sessions lock. Interrupts may be masked.
+ */
+void pfm_arch_release_session(struct pfm_sessions *session,
+			      struct pfm_context *ctx,
+			      u32 cpu)
+{
+	u32 sum;
+
+	sum = session->pfs_task_sessions + session->pfs_sys_sessions;
+
+	PFM_DBG("sum=%u nmi=%d pfm_nmi=%d", sum, nmi_watchdog, pfm_nmi_watchdog);
+
+	/*
+	 * release APIC NMI when last session
+	 */
+	if (sum == 0 && pfm_nmi_watchdog)
+		pfm_release_lapic_nmi();
+}
+
+/*
+ * Called from pfm_reserve_session() before any actual reservation
+ * is made. Holding pfs_sessions lock. Interrupts may be masked.
+ * Return:
+ * 	< 0 cannot reserve
+ * 	0 successful
+ */
+int pfm_arch_reserve_session(struct pfm_sessions *session,
+			     struct pfm_context *ctx,
+			     u32 cpu)
+{
+	u32 sum;
+
+	sum = session->pfs_task_sessions + session->pfs_sys_sessions;
+
+	PFM_DBG("sum=%u nmi=%d pfm_nmi=%d", sum, nmi_watchdog, pfm_nmi_watchdog);
+
+	/*
+	 * reserve only when first session
+	 */
+	if(sum == 0 && nmi_watchdog == NMI_LOCAL_APIC
+	   && pfm_reserve_lapic_nmi() < 0) {
+		PFM_WARN("conflict with NMI");
+		return -EBUSY;
+	}
+	return 0;
+}
+
+static int has_ia32_arch_pmu(void)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	if (cpu_data->x86_vendor != X86_VENDOR_INTEL)
+		return 0;
+
+	cpuid(0x0, &eax, &ebx, &ecx, &edx);
+	if (eax < 0xa)
+		return 0;
+
+	cpuid(0xa, &eax, &ebx, &ecx, &edx);
+	return (eax & 0xff) < 1 ? 0 : 1;
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
+					return NULL;
+			}
+		case 15:
+			/* All Opteron processors */
+			if (cpu_data->x86_vendor == X86_VENDOR_AMD)
+				return "perfmon_amd64";
+
+			switch(cpu_data->x86_model) {
+				case 0 ... 6:
+					return "perfmon_p4";
+			}
+			/* FALL THROUGH */
+		default:
+			if (has_ia32_arch_pmu())
+				return "perfmon_gen_ia32";
+			return NULL;
+	}
+	return NULL;
+}
--- linux-2.6.17.9.base/arch/i386/perfmon/perfmon_gen_ia32.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17.9/arch/i386/perfmon/perfmon_gen_ia32.c	2006-08-21 03:37:46.000000000 -0700
@@ -0,0 +1,260 @@
+/*
+ * This file contains the IA-32 architectural perfmon register description tables.
+ *
+ * The IA-32 architectural perfmon (PMU) was introduced with Intel Core Solo
+ * and Core Duo processors.
+ *
+ * Copyright (c) 2006 Hewlett-Packard Development Company, L.P.
+ * Contributed by Stephane Eranian <eranian@hpl.hp.com>
+ */
+#include <linux/module.h>
+#include <linux/perfmon.h>
+#include <asm/msr.h>
+#include <asm/apic.h>
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
+	.reg_type = PFM_REGT_SELEN}
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
+	}
+
+#define PFM_GEN_IA32_D(n) { \
+	.type = PFM_REG_C,  \
+	.desc = "PMC"#n,    \
+	.dfl_val = 0,       \
+	.rsvd_msk = -1,     \
+	.no_emul64_msk = 0, \
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
+	int high, low;
+
+	PFM_INFO("family=%d x86_model=%d",
+		 cpu_data->x86, cpu_data->x86_model);
+	/*
+	 * check for P6 processor family
+	 */
+	if (cpu_data->x86 != 6) {
+		PFM_INFO("unsupported family=%d", cpu_data->x86);
+		return -1;
+	}
+
+	/*
+	 * only works on Intel processors
+	 */
+	if (cpu_data->x86_vendor != X86_VENDOR_INTEL) {
+		PFM_INFO("not running on Intel processor");
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
+	 * instead of dynamically generaint the description table
+	 * and MSR addresses, we have a default description with a reasonably
+	 * large number of counters (32). We believe this is plenty for quite
+	 * some time. Thus allows us to have a much simpler probing and
+	 * initialization routine, especially because we have no dynamic
+	 * allocation, especially for the counter names
+	 */
+	if (num_cnt >= PFM_GEN_IA32_MAX_PMCS) {
+		PFM_INFO("too many counters (max=%d) actual=%u\n",
+			PFM_GEN_IA32_MAX_PMCS, num_cnt);
+		return -1;
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
+	rdmsr(MSR_IA32_APICBASE, low, high);
+	if ((low & MSR_IA32_APICBASE_ENABLE) == 0) {
+		PFM_INFO("local APIC disabled, you must enable "
+			 "with lapic kernel command line option");
+		return -1;
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
+	.pmu_name = "Generic IA-32",
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
+	unsigned int i;
+
+	bitmap_zero(ulp(pfm_gen_ia32_pmu_info.enable_mask), PFM_MAX_HW_PMCS);
+	for(i=0; i < PFM_MAX_HW_PMCS; i++) {
+		if (pfm_gen_ia32_pmu_info.pmc_addrs[i].reg_type & PFM_REGT_SELEN) {
+			pfm_bv_set(pfm_gen_ia32_pmu_info.enable_mask, i);
+		}
+	}
+	return pfm_register_pmu_config(&pfm_gen_ia32_pmu_conf);
+}
+
+static void __exit pfm_gen_ia32_pmu_cleanup_module(void)
+{
+	pfm_unregister_pmu_config(&pfm_gen_ia32_pmu_conf);
+}
+
+module_init(pfm_gen_ia32_pmu_init_module);
+module_exit(pfm_gen_ia32_pmu_cleanup_module);
--- linux-2.6.17.9.base/arch/i386/perfmon/perfmon_p4.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17.9/arch/i386/perfmon/perfmon_p4.c	2006-08-22 04:05:43.000000000 -0700
@@ -0,0 +1,408 @@
+/*	
+ * This file contains the P4/Xeon/EM64T PMU register description tables
+ * and pmc checker used by perfmon.c.
+ *
+ * Copyright (c) 2005 Intel Corporation
+ * Contributed by Bryan Wilkerson <bryan.p.wilkerson@intel.com>
+ */
+#include <linux/module.h>
+#include <linux/perfmon.h>
+#include <asm/msr.h>
+#include <asm/apic.h>
+
+MODULE_AUTHOR("Bryan Wilkerson <bryan.p.wilkerson@intel.com>");
+MODULE_DESCRIPTION("P4/Xeon/EM64T PMU description table");
+MODULE_LICENSE("GPL");
+
+/*
+ * CCCR default value:
+ * 	- OVF_PMI_T0=1 (bit 26)
+ * 	- OVF_PMI_T1=0 (bit 27) (set if necessary in pfm_write_reg())
+ * 	- all other bits are zero
+ *
+ * OVF_PMI is force to zero if PFM_REGFL_NO_EMUL64 is set on CCCR
+ */
+#define PFM_CCCR_DFL	(PFM_ONE_64<<26)
+
+/*
+ * CCCR reserved fields:
+ * 	- bits 0-11, 25-29, 31-63
+ * 	- OVF_PMI (26-27), override with REGFL_NO_EMUL64
+ */
+#define PFM_CCCR_RSVD  0x0000000041fff000
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
+#define PFM_REGT_NHTCCCR (PFM_REGT_CCCR|PFM_REGT_NOHT)
+#define PFM_REGT_NHTPEBS (PFM_REGT_PEBS|PFM_REGT_NOHT)
+#define PFM_REGT_NHTCTR  (PFM_REGT_CTR|PFM_REGT_NOHT)
+
+static struct pfm_arch_pmu_info pfm_p4_pmu_info={
+	.pmc_addrs = {
+	/*pmc 0 */    {{0x3b2, 0x3b3}, 0, PFM_REGT_ESCR}, /*   BPU_ESCR0,1 */
+	/*pmc 1 */    {{0x3b4, 0x3b5}, 0, PFM_REGT_ESCR}, /*    IS_ESCR0,1 */
+	/*pmc 2 */    {{0x3aa, 0x3ab}, 0, PFM_REGT_ESCR}, /*   MOB_ESCR0,1 */
+	/*pmc 3 */    {{0x3b6, 0x3b7}, 0, PFM_REGT_ESCR}, /*  ITLB_ESCR0,1 */
+	/*pmc 4 */    {{0x3ac, 0x3ad}, 0, PFM_REGT_ESCR}, /*   PMH_ESCR0,1 */
+	/*pmc 5 */    {{0x3c8, 0x3c9}, 0, PFM_REGT_ESCR}, /*    IX_ESCR0,1 */
+	/*pmc 6 */    {{0x3a2, 0x3a3}, 0, PFM_REGT_ESCR}, /*   FSB_ESCR0,1 */
+	/*pmc 7 */    {{0x3a0, 0x3a1}, 0, PFM_REGT_ESCR}, /*   BSU_ESCR0,1 */
+	/*pmc 8 */    {{0x3c0, 0x3c1}, 0, PFM_REGT_ESCR}, /*    MS_ESCR0,1 */
+	/*pmc 9 */    {{0x3c4, 0x3c5}, 0, PFM_REGT_ESCR}, /*    TC_ESCR0,1 */
+	/*pmc 10*/    {{0x3c2, 0x3c3}, 0, PFM_REGT_ESCR}, /*  TBPU_ESCR0,1 */
+	/*pmc 11*/    {{0x3a6, 0x3a7}, 0, PFM_REGT_ESCR}, /* FLAME_ESCR0,1 */
+	/*pmc 12*/    {{0x3a4, 0x3a5}, 0, PFM_REGT_ESCR}, /*  FIRM_ESCR0,1 */
+	/*pmc 13*/    {{0x3ae, 0x3af}, 0, PFM_REGT_ESCR}, /*  SAAT_ESCR0,1 */
+	/*pmc 14*/    {{0x3b0, 0x3b1}, 0, PFM_REGT_ESCR}, /*   U2L_ESCR0,1 */
+	/*pmc 15*/    {{0x3a8, 0x3a9}, 0, PFM_REGT_ESCR}, /*   DAC_ESCR0,1 */
+	/*pmc 16*/    {{0x3ba, 0x3bb}, 0, PFM_REGT_ESCR}, /*    IQ_ESCR0,1 */
+	/*pmc 17*/    {{0x3ca, 0x3cb}, 0, PFM_REGT_ESCR}, /*   ALF_ESCR0,1 */
+	/*pmc 18*/    {{0x3bc, 0x3bd}, 0, PFM_REGT_ESCR}, /*   RAT_ESCR0,1 */
+	/*pmc 19*/    {{0x3be,     0}, 0, PFM_REGT_ESCR}, /*   SSU_ESCR0   */
+	/*pmc 20*/    {{0x3b8, 0x3b9}, 0, PFM_REGT_ESCR}, /*   CRU_ESCR0,1 */
+	/*pmc 21*/    {{0x3cc, 0x3cd}, 0, PFM_REGT_ESCR}, /*   CRU_ESCR2,3 */
+	/*pmc 22*/    {{0x3e0, 0x3e1}, 0, PFM_REGT_ESCR}, /*   CRU_ESCR4,5 */
+
+	/*pmc 23*/    {{0x360, 0x362}, 0, PFM_REGT_CCCR}, /*   BPU_CCCR0,1 */
+	/*pmc 24*/    {{0x361, 0x363}, 1, PFM_REGT_CCCR}, /*   BPU_CCCR2,3 */
+	/*pmc 25*/    {{0x364, 0x366}, 2, PFM_REGT_CCCR}, /*    MS_CCCR0,1 */
+	/*pmc 26*/    {{0x365, 0x367}, 3, PFM_REGT_CCCR}, /*    MS_CCCR2,3 */
+	/*pmc 27*/    {{0x368, 0x36a}, 4, PFM_REGT_CCCR}, /* FLAME_CCCR0,1 */
+	/*pmc 28*/    {{0x369, 0x36b}, 5, PFM_REGT_CCCR}, /* FLAME_CCCR2,3 */
+	/*pmc 29*/    {{0x36c, 0x36e}, 6, PFM_REGT_CCCR}, /*    IQ_CCCR0,1 */
+	/*pmc 30*/    {{0x36d, 0x36f}, 7, PFM_REGT_CCCR}, /*    IQ_CCCR2,3 */
+	/*pmc 31*/    {{0x370, 0x371}, 8, PFM_REGT_CCCR}, /*    IQ_CCCR4,5 */
+			/* non HT extensions */	
+	/*pmc 32*/    {{0x3b3,     0}, 0, PFM_REGT_NHTESCR}, /*   BPU_ESCR1   */
+	/*pmc 33*/    {{0x3b5,     0}, 0, PFM_REGT_NHTESCR}, /*    IS_ESCR1   */
+	/*pmc 34*/    {{0x3ab,     0}, 0, PFM_REGT_NHTESCR}, /*   MOB_ESCR1   */
+	/*pmc 35*/    {{0x3b7,     0}, 0, PFM_REGT_NHTESCR}, /*  ITLB_ESCR1   */
+	/*pmc 36*/    {{0x3ad,     0}, 0, PFM_REGT_NHTESCR}, /*   PMH_ESCR1   */
+	/*pmc 37*/    {{0x3c9,     0}, 0, PFM_REGT_NHTESCR}, /*    IX_ESCR1   */
+	/*pmc 38*/    {{0x3a3,     0}, 0, PFM_REGT_NHTESCR}, /*   FSB_ESCR1   */
+	/*pmc 39*/    {{0x3a1,     0}, 0, PFM_REGT_NHTESCR}, /*   BSU_ESCR1   */
+	/*pmc 40*/    {{0x3c1,     0}, 0, PFM_REGT_NHTESCR}, /*    MS_ESCR1   */
+	/*pmc 41*/    {{0x3c5,     0}, 0, PFM_REGT_NHTESCR}, /*    TC_ESCR1   */
+	/*pmc 42*/    {{0x3c3,     0}, 0, PFM_REGT_NHTESCR}, /*  TBPU_ESCR1   */
+	/*pmc 43*/    {{0x3a7,     0}, 0, PFM_REGT_NHTESCR}, /* FLAME_ESCR1   */
+	/*pmc 44*/    {{0x3a5,     0}, 0, PFM_REGT_NHTESCR}, /*  FIRM_ESCR1   */
+	/*pmc 45*/    {{0x3af,     0}, 0, PFM_REGT_NHTESCR}, /*  SAAT_ESCR1   */
+	/*pmc 46*/    {{0x3b1,     0}, 0, PFM_REGT_NHTESCR}, /*   U2L_ESCR1   */
+	/*pmc 47*/    {{0x3a9,     0}, 0, PFM_REGT_NHTESCR}, /*   DAC_ESCR1   */
+	/*pmc 48*/    {{0x3bb,     0}, 0, PFM_REGT_NHTESCR}, /*    IQ_ESCR1   */
+	/*pmc 49*/    {{0x3cb,     0}, 0, PFM_REGT_NHTESCR}, /*   ALF_ESCR1   */
+	/*pmc 50*/    {{0x3bd,     0}, 0, PFM_REGT_NHTESCR}, /*   RAT_ESCR1   */
+	/*pmc 51*/    {{0x3b9,     0}, 0, PFM_REGT_NHTESCR}, /*   CRU_ESCR1   */
+	/*pmc 52*/    {{0x3cd,     0}, 0, PFM_REGT_NHTESCR}, /*   CRU_ESCR3   */
+	/*pmc 53*/    {{0x3e1,     0}, 0, PFM_REGT_NHTESCR}, /*   CRU_ESCR5   */
+	/*pmc 54*/    {{0x362,     0}, 9, PFM_REGT_NHTCCCR}, /*   BPU_CCCR1   */
+	/*pmc 55*/    {{0x363,     0},10, PFM_REGT_NHTCCCR}, /*   BPU_CCCR3   */
+	/*pmc 56*/    {{0x366,     0},11, PFM_REGT_NHTCCCR}, /*    MS_CCCR1   */
+	/*pmc 57*/    {{0x367,     0},12, PFM_REGT_NHTCCCR}, /*    MS_CCCR3   */
+	/*pmc 58*/    {{0x36a,     0},13, PFM_REGT_NHTCCCR}, /* FLAME_CCCR1   */
+	/*pmc 59*/    {{0x36b,     0},14, PFM_REGT_NHTCCCR}, /* FLAME_CCCR3   */
+	/*pmc 60*/    {{0x36e,     0},15, PFM_REGT_NHTCCCR}, /*    IQ_CCCR1   */
+	/*pmc 61*/    {{0x36f,     0},16, PFM_REGT_NHTCCCR}, /*    IQ_CCCR3   */
+	/*pmc 62*/    {{0x371,     0},17, PFM_REGT_NHTCCCR}, /*    IQ_CCCR5   */
+	/*pmc 63*/    {{0x3f2,     0}, 0, PFM_REGT_NHTPEBS},/* PEBS_MATRIX_VERT */
+	/*pmc 64*/    {{0x3f1,     0}, 0, PFM_REGT_NHTPEBS} /* PEBS_ENABLE   */
+	},
+
+	.pmd_addrs = {
+	/*pmd 0 */    {{0x300, 0x302}, 0, PFM_REGT_CTR},  /*   BPU_CRT0,1  */
+	/*pmd 1 */    {{0x301, 0x303}, 0, PFM_REGT_CTR},  /*   BPU_CTR2,3  */
+	/*pmd 2 */    {{0x304, 0x306}, 0, PFM_REGT_CTR},  /*    MS_CRT0,1  */
+	/*pmd 3 */    {{0x305, 0x307}, 0, PFM_REGT_CTR},  /*    MS_CRT2,3  */
+	/*pmd 4 */    {{0x308, 0x30a}, 0, PFM_REGT_CTR},  /* FLAME_CRT0,1  */
+	/*pmd 5 */    {{0x309, 0x30b}, 0, PFM_REGT_CTR},  /* FLAME_CRT2,3  */
+	/*pmd 6 */    {{0x30c, 0x30e}, 0, PFM_REGT_CTR},  /*    IQ_CRT0,1  */
+	/*pmd 7 */    {{0x30d, 0x30f}, 0, PFM_REGT_CTR},  /*    IQ_CRT2,3  */
+	/*pmd 8 */    {{0x310, 0x311}, 0, PFM_REGT_CTR},  /*    IQ_CRT4,5  */
+			/*
+			 * non HT extensions
+			 */
+	/*pmd 9 */    {{0x302,     0}, 0, PFM_REGT_NHTCTR},  /*   BPU_CRT1    */
+	/*pmd 10*/    {{0x303,     0}, 0, PFM_REGT_NHTCTR},  /*   BPU_CTR3    */
+	/*pmd 11*/    {{0x306,     0}, 0, PFM_REGT_NHTCTR},  /*    MS_CRT1    */
+	/*pmd 12*/    {{0x307,     0}, 0, PFM_REGT_NHTCTR},  /*    MS_CRT3    */
+	/*pmd 13*/    {{0x30a,     0}, 0, PFM_REGT_NHTCTR},  /* FLAME_CRT1    */
+	/*pmd 14*/    {{0x30b,     0}, 0, PFM_REGT_NHTCTR},  /* FLAME_CRT3    */
+	/*pmd 15*/    {{0x30e,     0}, 0, PFM_REGT_NHTCTR},  /*    IQ_CRT1    */
+	/*pmd 16*/    {{0x30f,     0}, 0, PFM_REGT_NHTCTR},  /*    IQ_CRT3    */
+	/*pmd 17*/    {{0x311,     0}, 0, PFM_REGT_NHTCTR},  /*    IQ_CRT5    */
+	},
+	.pebs_ctr_idx = 8, /* thread0: IQ_CTR4, thread1: IQ_CTR5 */
+	.pmu_style  = PFM_X86_PMU_P4,
+};
+
+static struct pfm_reg_desc pfm_p4_pmc_desc[]={
+/* pmc0  */ PMC_D(PFM_REG_I, "BPU_ESCR0"  , 0x0, PFM_ESCR_RSVD, 0),
+/* pmc1  */ PMC_D(PFM_REG_I, "IS_ESCR0"   , 0x0, PFM_ESCR_RSVD, 0),
+/* pmc2  */ PMC_D(PFM_REG_I, "MOB_ESCR0"  , 0x0, PFM_ESCR_RSVD, 0),
+/* pmc3  */ PMC_D(PFM_REG_I, "ITLB_ESCR0" , 0x0, PFM_ESCR_RSVD, 0),
+/* pmc4  */ PMC_D(PFM_REG_I, "PMH_ESCR0"  , 0x0, PFM_ESCR_RSVD, 0),
+/* pmc5  */ PMC_D(PFM_REG_I, "IX_ESCR0"   , 0x0, PFM_ESCR_RSVD, 0),
+/* pmc6  */ PMC_D(PFM_REG_I, "FSB_ESCR0"  , 0x0, PFM_ESCR_RSVD, 0),
+/* pmc7  */ PMC_D(PFM_REG_I, "BSU_ESCR0"  , 0x0, PFM_ESCR_RSVD, 0),
+/* pmc8  */ PMC_D(PFM_REG_I, "MS_ESCR0"   , 0x0, PFM_ESCR_RSVD, 0),
+/* pmc9  */ PMC_D(PFM_REG_I, "TC_ESCR0"   , 0x0, PFM_ESCR_RSVD, 0),
+/* pmc10 */ PMC_D(PFM_REG_I, "TBPU_ESCR0" , 0x0, PFM_ESCR_RSVD, 0),
+/* pmc11 */ PMC_D(PFM_REG_I, "FLAME_ESCR0", 0x0, PFM_ESCR_RSVD, 0),
+/* pmc12 */ PMC_D(PFM_REG_I, "FIRM_ESCR0" , 0x0, PFM_ESCR_RSVD, 0),
+/* pmc13 */ PMC_D(PFM_REG_I, "SAAT_ESCR0" , 0x0, PFM_ESCR_RSVD, 0),
+/* pmc14 */ PMC_D(PFM_REG_I, "U2L_ESCR0"  , 0x0, PFM_ESCR_RSVD, 0),
+/* pmc15 */ PMC_D(PFM_REG_I, "DAC_ESCR0"  , 0x0, PFM_ESCR_RSVD, 0),
+/* pmc16 */ PMC_D(PFM_REG_I, "IQ_ESCR0"   , 0x0, PFM_ESCR_RSVD, 0),
+/* pmc17 */ PMC_D(PFM_REG_I, "ALF_ESCR0"  , 0x0, PFM_ESCR_RSVD, 0),
+/* pmc18 */ PMC_D(PFM_REG_I, "RAT_ESCR0"  , 0x0, PFM_ESCR_RSVD, 0),
+/* pmc19 */ PMC_D(PFM_REG_I, "SSU_ESCR0"  , 0x0, PFM_ESCR_RSVD, 0),
+/* pmc20 */ PMC_D(PFM_REG_I, "CRU_ESCR0"  , 0x0, PFM_ESCR_RSVD, 0),
+/* pmc21 */ PMC_D(PFM_REG_I, "CRU_ESCR2"  , 0x0, PFM_ESCR_RSVD, 0),
+/* pmc22 */ PMC_D(PFM_REG_I, "CRU_ESCR4"  , 0x0, PFM_ESCR_RSVD, 0),
+/* pmc23 */ PMC_D(PFM_REG_I64, "BPU_CCCR0"  , PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_P4_NO64),
+/* pmc24 */ PMC_D(PFM_REG_I64, "BPU_CCCR2"  , PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_P4_NO64),
+/* pmc25 */ PMC_D(PFM_REG_I64, "MS_CCCR0"   , PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_P4_NO64),
+/* pmc26 */ PMC_D(PFM_REG_I64, "MS_CCCR2"   , PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_P4_NO64),
+/* pmc27 */ PMC_D(PFM_REG_I64, "FLAME_CCCR0", PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_P4_NO64),
+/* pmc28 */ PMC_D(PFM_REG_I64, "FLAME_CCCR2", PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_P4_NO64),
+/* pmc29 */ PMC_D(PFM_REG_I64, "IQ_CCCR0"   , PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_P4_NO64),
+/* pmc30 */ PMC_D(PFM_REG_I64, "IQ_CCCR2"   , PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_P4_NO64),
+/* pmc31 */ PMC_D(PFM_REG_I64, "IQ_CCCR4"   , PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_P4_NO64),
+		/* No HT extension */
+/* pmc32 */ PMC_D(PFM_REG_I, "BPU_ESCR1"  , 0x0, PFM_ESCR_RSVD, 0),
+/* pmc33 */ PMC_D(PFM_REG_I, "IS_ESCR1"   , 0x0, PFM_ESCR_RSVD, 0),
+/* pmc34 */ PMC_D(PFM_REG_I, "MOB_ESCR1"  , 0x0, PFM_ESCR_RSVD, 0),
+/* pmc35 */ PMC_D(PFM_REG_I, "ITLB_ESCR1" , 0x0, PFM_ESCR_RSVD, 0),
+/* pmc36 */ PMC_D(PFM_REG_I, "PMH_ESCR1"  , 0x0, PFM_ESCR_RSVD, 0),
+/* pmc37 */ PMC_D(PFM_REG_I, "IX_ESCR1"   , 0x0, PFM_ESCR_RSVD, 0),
+/* pmc38 */ PMC_D(PFM_REG_I, "FSB_ESCR1"  , 0x0, PFM_ESCR_RSVD, 0),
+/* pmc39 */ PMC_D(PFM_REG_I, "BSU_ESCR1"  , 0x0, PFM_ESCR_RSVD, 0),
+/* pmc40 */ PMC_D(PFM_REG_I, "MS_ESCR1"   , 0x0, PFM_ESCR_RSVD, 0),
+/* pmc41 */ PMC_D(PFM_REG_I, "TC_ESCR1"   , 0x0, PFM_ESCR_RSVD, 0),
+/* pmc42 */ PMC_D(PFM_REG_I, "TBPU_ESCR1" , 0x0, PFM_ESCR_RSVD, 0),
+/* pmc43 */ PMC_D(PFM_REG_I, "FLAME_ESCR1", 0x0, PFM_ESCR_RSVD, 0),
+/* pmc44 */ PMC_D(PFM_REG_I, "FIRM_ESCR1" , 0x0, PFM_ESCR_RSVD, 0),
+/* pmc45 */ PMC_D(PFM_REG_I, "SAAT_ESCR1" , 0x0, PFM_ESCR_RSVD, 0),
+/* pmc46 */ PMC_D(PFM_REG_I, "U2L_ESCR1"  , 0x0, PFM_ESCR_RSVD, 0),
+/* pmc47 */ PMC_D(PFM_REG_I, "DAC_ESCR1"  , 0x0, PFM_ESCR_RSVD, 0),
+/* pmc48 */ PMC_D(PFM_REG_I, "IQ_ESCR1"   , 0x0, PFM_ESCR_RSVD, 0),
+/* pmc49 */ PMC_D(PFM_REG_I, "ALF_ESCR1"  , 0x0, PFM_ESCR_RSVD, 0),
+/* pmc50 */ PMC_D(PFM_REG_I, "RAT_ESCR1"  , 0x0, PFM_ESCR_RSVD, 0),
+/* pmc51 */ PMC_D(PFM_REG_I, "CRU_ESCR1"  , 0x0, PFM_ESCR_RSVD, 0),
+/* pmc52 */ PMC_D(PFM_REG_I, "CRU_ESCR3"  , 0x0, PFM_ESCR_RSVD, 0),
+/* pmc53 */ PMC_D(PFM_REG_I, "CRU_ESCR5"  , 0x0, PFM_ESCR_RSVD, 0),
+/* pmc54 */ PMC_D(PFM_REG_I64, "BPU_CCCR1"  , PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_P4_NO64),
+/* pmc55 */ PMC_D(PFM_REG_I64, "BPU_CCCR3"  , PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_P4_NO64),
+/* pmc56 */ PMC_D(PFM_REG_I64, "MS_CCCR1"   , PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_P4_NO64),
+/* pmc57 */ PMC_D(PFM_REG_I64, "MS_CCCR3"   , PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_P4_NO64),
+/* pmc58 */ PMC_D(PFM_REG_I64, "FLAME_CCCR1", PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_P4_NO64),
+/* pmc59 */ PMC_D(PFM_REG_I64, "FLAME_CCCR3", PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_P4_NO64),
+/* pmc60 */ PMC_D(PFM_REG_I64, "IQ_CCCR1"   , PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_P4_NO64),
+/* pmc61 */ PMC_D(PFM_REG_I64, "IQ_CCCR3"   , PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_P4_NO64),
+/* pmc62 */ PMC_D(PFM_REG_I64, "IQ_CCCR5"   , PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_P4_NO64),
+/* pmc63 */ PMC_D(PFM_REG_I, "PEBS_MATRIX_VERT", 0, 0x13, 0),
+/* pmc64 */ PMC_D(PFM_REG_I, "PEBS_ENABLE", 0, 0x3000fff, 0)
+};
+#define PFM_P4_NUM_PMCS ARRAY_SIZE(pfm_p4_pmc_desc)
+
+/*
+ * See section 15.10.6.6 for details about the IQ block
+ */
+static struct pfm_reg_desc pfm_p4_pmd_desc[]={
+/* pmd0  */ PMD_D(PFM_REG_C, "BPU_CTR0"   ),
+/* pmd1  */ PMD_D(PFM_REG_C, "BPU_CTR2"   ),
+/* pmd2  */ PMD_D(PFM_REG_C, "MS_CTR0"    ),
+/* pmd3  */ PMD_D(PFM_REG_C, "MS_CTR2"    ),
+/* pmd4  */ PMD_D(PFM_REG_C, "FLAME_CTR0" ),
+/* pmd5  */ PMD_D(PFM_REG_C, "FLAME_CTR2" ),
+/* pmd6  */ PMD_D(PFM_REG_C, "IQ_CTR0"    ),
+/* pmd7  */ PMD_D(PFM_REG_C, "IQ_CTR2"    ),
+/* pmd8  */ PMD_D(PFM_REG_C, "IQ_CTR4"    ),
+		/* no HT extension */
+/* pmd9  */ PMD_D(PFM_REG_C, "BPU_CTR1"   ),
+/* pmd10 */ PMD_D(PFM_REG_C, "BPU_CTR3"   ),
+/* pmd11 */ PMD_D(PFM_REG_C, "MS_CTR1"    ),
+/* pmd12 */ PMD_D(PFM_REG_C, "MS_CTR3"    ),
+/* pmd13 */ PMD_D(PFM_REG_C, "FLAME_CTR1" ),
+/* pmd14 */ PMD_D(PFM_REG_C, "FLAME_CTR3" ),
+/* pmd15 */ PMD_D(PFM_REG_C, "IQ_CTR1"    ),
+/* pmd16 */ PMD_D(PFM_REG_C, "IQ_CTR3"    ),
+/* pmd17 */ PMD_D(PFM_REG_C, "IQ_CTR5"    )
+};
+#define PFM_P4_NUM_PMDS ARRAY_SIZE(pfm_p4_pmd_desc)
+
+#define MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL (1<<12) /* PEBS unavailable */
+#define cpu_has_dts boot_cpu_has(X86_FEATURE_DTES)
+
+static int pfm_p4_probe_pmu(void)
+{
+	int high, low;
+	unsigned int i, num_ht;
+	
+	PFM_INFO("family=%d x86_model=%d",
+		 cpu_data->x86,
+		 cpu_data->x86_model);
+	/*
+	 * must be family 15
+	 */
+	if (cpu_data->x86 != 15) {
+		PFM_INFO("unsupported family=%d", cpu_data->x86);
+		return -1;
+	}
+
+	/*
+	 * only works on Intel processors
+	 */
+	if (cpu_data->x86_vendor != X86_VENDOR_INTEL) {
+		PFM_INFO("not running on Intel processor");
+		return -1;
+	}
+
+	switch(cpu_data->x86_model) {
+		case 1:
+			PFM_INFO("Willamette P4 detected");
+			break;
+		case 2:
+			PFM_INFO("Northwood P4 detected");
+			break;
+		case 3: /* Pentium 4 505, 520, 540, 550 */
+		case 4: 
+		case 5: /* incl. some Celeron D */
+		case 0:
+			PFM_INFO("P4 detected");
+			break;
+		case 6:
+			PFM_INFO("Pentium D or Extreme Edition detected");
+			break;
+		default:
+			/*
+			 * do not know if they all work the same, so reject
+			 * for now
+			 */
+			PFM_INFO("unknown model %d", cpu_data->x86_model);
+			return -1;
+	}
+
+	/*
+	 * check for local APIC (required)
+	 */
+	if (!cpu_has_apic) {
+		PFM_INFO("no local APIC, unsupported");
+		return -1;
+	}
+	rdmsr(MSR_IA32_APICBASE, low, high);
+	if ((low & MSR_IA32_APICBASE_ENABLE) == 0)
+		PFM_INFO("Local APIC in 3-wire mode");
+
+#ifdef CONFIG_SMP
+	num_ht = cpus_weight(cpu_sibling_map[0]);
+#else
+	num_ht = 1;
+#endif
+
+	PFM_INFO("cores/package=%d threads/core=%d",
+		 cpu_data->x86_max_cores,
+		 num_ht);
+
+	if (cpu_has_ht) {
+
+		PFM_INFO("HyperThreading supported, status %s",
+			 num_ht > 1 ? "on": "off");
+		/*
+		 * disable registers not supporting HT
+		 */
+		if (num_ht > 1) {
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
+	if (cpu_has_dts) {
+		PFM_INFO("Data Save Area (DS) supported");
+
+		pfm_p4_pmu_info.flags = PFM_X86_PMU_DS;
+
+		rdmsr(MSR_IA32_MISC_ENABLE, low, high);
+		if ((low & MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL) == 0) {
+			/*
+			 * PEBS does not work with HyperThreading enabled
+			 */
+	                if (num_ht == 1) {
+				pfm_p4_pmu_info.flags |= PFM_X86_PMU_PEBS;
+				PFM_INFO("PEBS supported, status on");
+			} else {
+				PFM_INFO("PEBS supported, status off (because of HT)");
+			}
+		}
+	}
+	PFM_INFO("NMI watchdog=%d\n", nmi_watchdog);
+	return 0;
+}
+
+static struct pfm_pmu_config pfm_p4_pmu_conf={
+	.pmu_name = "Intel P4/Xeon/EM64T",
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
+	unsigned int i;
+
+	/*
+	 * compute enable bitmask
+	 */
+	bitmap_zero(ulp(pfm_p4_pmu_info.enable_mask), PFM_MAX_HW_PMCS);
+	for(i=0; i < PFM_MAX_HW_PMCS; i++) {
+		if (pfm_p4_pmu_info.pmc_addrs[i].reg_type & PFM_REGT_CCCR) {
+			pfm_bv_set(pfm_p4_pmu_info.enable_mask, i);
+		}
+	}
+	return pfm_register_pmu_config(&pfm_p4_pmu_conf);
+}
+
+static void __exit pfm_p4_pmu_cleanup_module(void)
+{
+	pfm_unregister_pmu_config(&pfm_p4_pmu_conf);
+}
+
+module_init(pfm_p4_pmu_init_module);
+module_exit(pfm_p4_pmu_cleanup_module);
--- linux-2.6.17.9.base/arch/i386/perfmon/perfmon_p4_pebs_smpl.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17.9/arch/i386/perfmon/perfmon_p4_pebs_smpl.c	2006-08-21 03:37:46.000000000 -0700
@@ -0,0 +1,219 @@
+/*
+ * Copyright (c) 2005-2006 Hewlett-Packard Development Company, L.P.
+ * Contributed by Stephane Eranian <eranian@hpl.hp.com>
+ *
+ * This file implements the PEBS sampling format for 32-bit
+ * Pentium 4/Xeon processors. it does not work with Intel EM64T
+ * processors.
+ */
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
+#ifndef __i386__
+#error "this module is for the 32-bit Pentium 4/Xeon processors"
+#endif
+
+MODULE_AUTHOR("Stephane Eranian <eranian@hpl.hp.com>");
+MODULE_DESCRIPTION("Intel 32-bit P4/Xeon PEBS sampling");
+MODULE_LICENSE("GPL");
+
+static int pfm_pebs_fmt_validate(u32 flags, u16 npmds, void *data)
+{
+	struct pfm_arch_pmu_info *arch_info = pfm_pmu_conf->arch_info;
+	struct pfm_p4_pebs_smpl_arg *arg = data;
+	size_t min_buf_size;
+
+	/*
+	 * host CPU does not have PEBS support
+	 */
+	if ((arch_info->flags & PFM_X86_PMU_PEBS) == 0) {
+		PFM_DBG("host PMU does not support PEBS sampling");
+		return -EINVAL;
+	}
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
+	min_buf_size = sizeof(struct pfm_p4_pebs_smpl_hdr) +
+		       sizeof(struct pfm_p4_pebs_smpl_entry);
+
+	PFM_DBG("validate flags=0x%x min_buf_size=%zu buf_size=%zu",
+		  flags, min_buf_size, arg->buf_size);
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
+	 * size has been validated in pebs_fmt_validate()
+	 */
+	*size = arg->buf_size + 256;
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
+	unsigned long base;
+	struct pfm_p4_ds_area *ds;
+
+	ctx_arch = pfm_ctx_arch(ctx);
+
+	hdr = buf;
+	ds = &hdr->hdr_ds;
+
+	hdr->hdr_version = PFM_P4_PEBS_SMPL_VERSION;
+	hdr->hdr_buf_size = arg->buf_size;
+	hdr->hdr_overflows = 0;
+
+	/*
+	 * align base
+	 */
+	base = ((unsigned long)(hdr+1) + 256) & ~0xffUL;
+	hdr->hdr_start_offs = base - (unsigned long)(hdr+1);
+	ds->pebs_buf_base = base;
+	ds->pebs_abs_max = base + arg->buf_size + 1;
+	ds->pebs_intr_thres = base +
+			      arg->intr_thres *
+			      sizeof(struct pfm_p4_pebs_smpl_entry);
+	ds->pebs_index = base;
+
+	/*
+	 * save counter reset value for IQ_CCCR4 (thread0) or IQ_CCCR5 (thread1)
+	 */
+	ds->pebs_cnt_reset = arg->cnt_reset;
+
+	/*
+	 * keep track of DS AREA
+	 */
+	ctx_arch->ds_area = ds;
+
+	PFM_DBG("buffer=%p buf_size=%zu  ctx_flags=0x%x pebs_base=0x%x "
+		  "pebs_max=0x%x pebs_thres=0x%x cnt_reset=0x%llx",
+		  buf,
+		  hdr->hdr_buf_size,
+		  ctx_arch->flags,
+		  ds->pebs_buf_base,
+		  ds->pebs_abs_max,
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
+	hdr->hdr_overflows++;
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
+	hdr->hdr_ds.pebs_index = hdr->hdr_ds.pebs_buf_base;
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
+	.fmt_name = "P4-PEBS-32bit",
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
+#define MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL (1<<12) /* PEBS unavailable */
+#define cpu_has_dts boot_cpu_has(X86_FEATURE_DTES)
+
+static int __init pfm_pebs_fmt_init_module(void)
+{
+	int low, high;
+
+	if (!cpu_has_dts) {
+		PFM_INFO("processor does not have Data Save Area (DS)");
+		return -1;
+	}
+	rdmsr(MSR_IA32_MISC_ENABLE, low, high);
+
+	if (low & MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL) {
+		PFM_INFO("processor does not support PEBS");
+		return -1;
+	}
+	return pfm_register_smpl_fmt(&pebs_fmt);
+}
+
+static void __exit pfm_pebs_fmt_cleanup_module(void)
+{
+	pfm_unregister_smpl_fmt(pebs_fmt.fmt_uuid);
+}
+
+module_init(pfm_pebs_fmt_init_module);
+module_exit(pfm_pebs_fmt_cleanup_module);
--- linux-2.6.17.9.base/arch/i386/perfmon/perfmon_p6.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17.9/arch/i386/perfmon/perfmon_p6.c	2006-08-21 03:37:46.000000000 -0700
@@ -0,0 +1,156 @@
+/*
+ * This file contains the P6 family processor PMU register description tables
+ * and pmc checker used by perfmon.c. This module support original P6 processors
+ * (Pentium II, Pentium Pro, Pentium III) and Pentium M.
+ *
+ * Copyright (c) 2005-2006 Hewlett-Packard Development Company, L.P.
+ * Contributed by Stephane Eranian <eranian@hpl.hp.com>
+ */
+#include <linux/module.h>
+#include <linux/perfmon.h>
+#include <asm/msr.h>
+#include <asm/apic.h>
+
+MODULE_AUTHOR("Stephane Eranian <eranian@hpl.hp.com>");
+MODULE_DESCRIPTION("P6 PMU description table");
+MODULE_LICENSE("GPL");
+
+/*
+ * - upper 32 bits are reserved
+ * - INT: APIC enable bit is reserved (forced to 1)
+ * - bit 21 is reserved
+ */
+#define PFM_P6_PMC_RSVD	~((0xffffffffULL<<32) \
+		  	| (PFM_ONE_64<<20)    \
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
+		{{MSR_P6_EVNTSEL0, 0}, 0, PFM_REGT_SELEN}, /* has enable bit */
+		{{MSR_P6_EVNTSEL1, 0}, 1, PFM_REGT_SEL}	   /* no enable bit  */
+	},
+	.pmd_addrs = {
+		{{MSR_P6_PERFCTR0, 0}, 0, PFM_REGT_CTR},
+		{{MSR_P6_PERFCTR1, 0}, 0, PFM_REGT_CTR}
+	},
+	.pmu_style = PFM_X86_PMU_P6,
+};
+
+static struct pfm_reg_desc pfm_p6_pmc_desc[]={
+/* pmc0  */ PMC_D(PFM_REG_I64, "PERFEVTSEL0", PFM_P6_PMC_VAL, PFM_P6_PMC_RSVD, PFM_P6_NO64),
+/* pmc1  */ PMC_D(PFM_REG_I64, "PERFEVTSEL1", PFM_P6_PMC_VAL, PFM_P6_PMC_RSVD, PFM_P6_NO64),
+};
+#define PFM_P6_NUM_PMCS	ARRAY_SIZE(pfm_p6_pmc_desc)
+
+static struct pfm_reg_desc pfm_p6_pmd_desc[]={
+/* pmd0  */ PMD_D(PFM_REG_C  , "PERFCTR0"),
+/* pmd1  */ PMD_D(PFM_REG_C  , "PERFCTR1")
+};
+#define PFM_P6_NUM_PMDS ARRAY_SIZE(pfm_p6_pmd_desc)
+
+#define MSR_IA32_MISC_ENABLE_PERF_AVAIL (1<<7) /* read-only status bit */
+
+static int pfm_p6_probe_pmu(void)
+{
+	int high, low;
+
+	PFM_INFO("family=%d x86_model=%d",
+		 cpu_data->x86, cpu_data->x86_model);
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
+			PFM_INFO("Pentium II PMU detected");
+			break;
+
+		case 7 ... 11:
+			PFM_INFO("P6 core PMU detected");
+			break;
+		case 13:
+			rdmsr(MSR_IA32_MISC_ENABLE, low, high);
+			if ((low & MSR_IA32_MISC_ENABLE_PERF_AVAIL) == 0) {
+				PFM_INFO("Pentium M without PMU");
+				return -1;
+			}
+			PFM_INFO("Pentium M PMU detected");
+			break;
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
+	rdmsr(MSR_IA32_APICBASE, low, high);
+	if ((low & MSR_IA32_APICBASE_ENABLE) == 0) {
+		PFM_INFO("local APIC disabled, you must enable "
+			 "with lapic kernel command line option");
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
+	unsigned int i;
+	/*
+	 * XXX: could be hardcoded for this PMU model
+	 */
+	bitmap_zero(ulp(pfm_p6_pmu_info.enable_mask), PFM_MAX_HW_PMCS);
+	for(i=0; i < PFM_MAX_HW_PMCS; i++) {
+		if (pfm_p6_pmu_info.pmc_addrs[i].reg_type & PFM_REGT_SELEN)
+			pfm_bv_set(pfm_p6_pmu_info.enable_mask, i);
+	}
+	return pfm_register_pmu_config(&pfm_p6_pmu_conf);
+}
+
+static void __exit pfm_p6_pmu_cleanup_module(void)
+{
+	pfm_unregister_pmu_config(&pfm_p6_pmu_conf);
+}
+
+module_init(pfm_p6_pmu_init_module);
+module_exit(pfm_p6_pmu_cleanup_module);
--- linux-2.6.17.9.base/include/asm-i386/perfmon.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17.9/include/asm-i386/perfmon.h	2006-08-21 03:37:46.000000000 -0700
@@ -0,0 +1,281 @@
+/*
+ * Copyright (c) 2005-2006 Hewlett-Packard Development Company, L.P.
+ * Contributed by Stephane Eranian <eranian@hpl.hp.com>
+ *
+ * This file contains X86 Processor Family specific definitions
+ * for the perfmon interface. This covers P6, Pentium M, P4/Xeon
+ * (32-bit and 64-bit, i.e., EM64T) and AMD X86-64.
+ *
+ * This file MUST never be included directly. Use linux/perfmon.h.
+ */
+#ifndef _ASM_I386_PERFMON_H_
+#define _ASM_I386_PERFMON_H_
+
+#ifdef __KERNEL__
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
+ * layout:
+ * bit 00-15: reg_type (1 bit set)
+ * bit 16-31: attribute (can be ORed with bit 0-15)
+ */
+#define PFM_REGT_NA	 0x00 /* not available */
+#define PFM_REGT_SELEN 	 0x01 /* P6/AMD: PERFSEL with enable bit22 */
+#define PFM_REGT_SEL 	 0x02 /* P6: PERFSEL no enable bit */
+#define PFM_REGT_ESCR    0x04 /* P4: ESCR */
+#define PFM_REGT_CCCR    0x08 /* P4: CCCR (enable bit) */
+#define PFM_REGT_CTR     0x10 /* P4/P6/AMD: counter */
+#define PFM_REGT_PEBS	 0x20 /* P4: PEBS related */
+#define PFM_REGT_NOHT    0x10000 /* P4: no available with HT */
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
+	 * to regenerate the intr. and have it pended until
+	 * we unmask interrupts.
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
+static inline u64 pfm_arch_get_itc(void)
+{
+	u64 tmp;
+	rdtscll(tmp);
+	return tmp;
+}
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
+void pfm_arch_init_percpu(void);
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
+int  pfm_arch_pmu_config_check(struct pfm_pmu_config *cfg);
+void pfm_arch_pmu_config_init(void);
+int  pfm_arch_initialize(void);
+char *pfm_arch_get_pmu_module_name(void);
+void pfm_arch_mask_monitoring(struct pfm_context *ctx);
+void pfm_arch_unmask_monitoring(struct pfm_context *ctx);
+void pfm_arch_unload_context(struct pfm_context *ctx,
+			     struct task_struct *task);
+int pfm_arch_load_context(struct pfm_context *ctx,
+			  struct task_struct *task);
+
+int pfm_arch_reserve_session(struct pfm_sessions *session,
+			     struct pfm_context *ctx,
+			     u32 cpu);
+
+void pfm_arch_release_session(struct pfm_sessions *session,
+			      struct pfm_context *ctx,
+			      u32 cpu);
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
+	void	*ds_area;	/* pointer to DS management area */
+	u32	flags;		/* arch-specific flags */
+};
+#define PFM_X86_FL_INSECURE	0x1 /* allow user level rdpmc (self-monitoring) */
+
+#define PFM_ARCH_CTX_SIZE	(sizeof(struct pfm_arch_context))
+
+#endif /* __KERNEL__ */
+#endif /* _ASM_I386_PERFMON_H_ */
--- linux-2.6.17.9.base/include/asm-i386/perfmon_p4_pebs_smpl.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17.9/include/asm-i386/perfmon_p4_pebs_smpl.h	2006-08-21 03:37:46.000000000 -0700
@@ -0,0 +1,96 @@
+/*
+ * Copyright (c) 2005-2006 Hewlett-Packard Development Company, L.P.
+ * Contributed by Stephane Eranian <eranian@hpl.hp.com>
+ *
+ * This file implements the PEBS sampling format for 32-bit
+ * Intel Pentium 4/Xeon processors. Not to be used with Intel EM64T
+ * processors.
+ */
+#ifndef __PERFMON_P4_PEBS_SMPL_H__
+#define __PERFMON_P4_PEBS_SMPL_H__ 1
+
+#define PFM_P4_PEBS_SMPL_UUID { \
+	0x0d, 0x85, 0x91, 0xe7, 0x49, 0x3f, 0x49, 0xae,\
+	0x8c, 0xfc, 0xe8, 0xb9, 0x33, 0xe4, 0xeb, 0x8b}
+
+/*
+ * format specific parameters (passed at context creation)
+ *
+ * intr_thres: index from start of buffer of entry where the
+ * PMU interrupt must be triggered. It must be several samples
+ * short of the end of the buffer.
+ */
+struct pfm_p4_pebs_smpl_arg {
+	size_t	buf_size;	/* size of the buffer in bytes */
+	size_t	intr_thres;	/* index of interrupt threshold entry */
+	u32	flags;		/* buffer specific flags */
+	u64	cnt_reset;	/* counter reset value */
+	u32	res1;		/* for future use */
+	u64	reserved[2];	/* for future use */
+};
+
+/*
+ * combined context+format specific structure. Can be passed
+ * to pfm_context_create()
+ */
+struct pfm_p4_pebs_smpl_ctx_arg {
+	struct pfarg_ctx		ctx_arg;
+	struct pfm_p4_pebs_smpl_arg	buf_arg;
+};
+
+/*
+ * DS save area as described in section 15.10.5
+ */
+struct pfm_p4_ds_area {
+	u32	bts_buf_base;
+	u32	bts_index;
+	u32	bts_abs_max;
+	u32	bts_intr_thres;
+	u32	pebs_buf_base;
+	u32	pebs_index;
+	u32	pebs_abs_max;
+	u32	pebs_intr_thres;
+	u64     pebs_cnt_reset;
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
+	u64			hdr_overflows;	/* #overflows for buffer */
+	size_t			hdr_buf_size;	/* bytes in the buffer */
+	size_t			hdr_start_offs; /* actual buffer start offset */
+	u32			hdr_version;	/* smpl format version */
+	u64			hdr_res[3];	/* for future use */
+	struct pfm_p4_ds_area	hdr_ds;		/* DS management Area */
+};
+
+/*
+ * PEBS record format as described in section 15.10.6
+ */
+struct pfm_p4_pebs_smpl_entry{
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
+
+#define PFM_P4_PEBS_SMPL_VERSION_MAJ 1U
+#define PFM_P4_PEBS_SMPL_VERSION_MIN 0U
+#define PFM_P4_PEBS_SMPL_VERSION (((PFM_P4_PEBS_SMPL_VERSION_MAJ&0xffff)<<16)|\
+				   (PFM_P4_PEBS_SMPL_VERSION_MIN & 0xffff))
+
+#endif /* __PERFMON_P4_PEBS_SMPL_H__ */
