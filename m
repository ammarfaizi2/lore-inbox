Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750911AbVKWO6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbVKWO6f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 09:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbVKWO6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 09:58:35 -0500
Received: from tayrelbas04.tay.hp.com ([161.114.80.247]:9864 "EHLO
	tayrelbas04.tay.hp.com") by vger.kernel.org with ESMTP
	id S1750911AbVKWO6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 09:58:33 -0500
Date: Wed, 23 Nov 2005 06:57:54 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: linux-kernel@vger.kernel.org
Cc: Stephane Eranian <eranian@hpl.hp.com>
Subject: Re: [PATCH 5/5] powerpc perfmon2 code for review
Message-ID: <20051123145754.GF17228@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20051118170055.GF30262@frankl.hpl.hp.com> <20051123145308.GB17228@frankl.hpl.hp.com> <20051123145543.GD17228@frankl.hpl.hp.com> <20051123145645.GE17228@frankl.hpl.hp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PPYy/fEw/8QCHSq3"
Content-Disposition: inline
In-Reply-To: <20051123145645.GE17228@frankl.hpl.hp.com>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PPYy/fEw/8QCHSq3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

For some reasons, the original annoucement from 11/18
for this release never made it to this list.

You can download the latest packages from:

	http://www.sf.net/projects/perfmon2

You need to grab:
	2.6.15-rc1-git6 (kernel code)
	libpfm-3.2-051118 (user library)


For convenience, I am also posting the patch directly
to the list. At this point, the patch is for review.
Please cc me on your replies because due to the volume
of traffic I am not a member of the list.

I have split the patch into 5 parts. The first part is needed on
each platform (common code). All the others are specific to
a processor architecture. There is an exception for x86-64 which
needs the i386 portion due to cross use of header files. The
patch is relative to 2.6.15-rc1-git6.

thanks.

This E-mail contains Part 5: powerpc code (PPC64)

--PPYy/fEw/8QCHSq3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="perfmon-new-base-powerpc-051118.diff"

diff -urN linux-2.6.15-rc1-git6.orig/arch/powerpc/Kconfig linux-2.6.15-rc1-git6/arch/powerpc/Kconfig
--- linux-2.6.15-rc1-git6.orig/arch/powerpc/Kconfig	2005-11-18 05:16:42.000000000 -0800
+++ linux-2.6.15-rc1-git6/arch/powerpc/Kconfig	2005-11-18 05:48:12.000000000 -0800
@@ -237,6 +237,18 @@
 	bool
 	depends on 4xx || 8xx || E200
 	default y
+
+menu "Hardware Performance Monitoring support"
+config PERFMON
+	bool "Perfmon2 performance monitoring interface"
+	default y
+	help
+	include the perfmon2 performance monitoring interface
+	in the kernel.  See <http://www.hpl.hp.com/research/linux/perfmon> for
+	more details.  If you're unsure, say Y.
+source "arch/powerpc/perfmon/Kconfig"
+endmenu
+
 endmenu
 
 source "init/Kconfig"
diff -urN linux-2.6.15-rc1-git6.orig/arch/powerpc/Makefile linux-2.6.15-rc1-git6/arch/powerpc/Makefile
--- linux-2.6.15-rc1-git6.orig/arch/powerpc/Makefile	2005-11-18 05:16:42.000000000 -0800
+++ linux-2.6.15-rc1-git6/arch/powerpc/Makefile	2005-11-18 05:48:12.000000000 -0800
@@ -132,6 +132,7 @@
 				   arch/powerpc/platforms/
 core-$(CONFIG_MATH_EMULATION)	+= arch/ppc/math-emu/
 core-$(CONFIG_XMON)		+= arch/powerpc/xmon/
+core-$(CONFIG_PERFMON)		+= arch/powerpc/perfmon/
 core-$(CONFIG_APUS)		+= arch/ppc/amiga/
 drivers-$(CONFIG_8xx)		+= arch/ppc/8xx_io/
 drivers-$(CONFIG_4xx)		+= arch/ppc/4xx_io/
diff -urN linux-2.6.15-rc1-git6.orig/arch/powerpc/kernel/entry_64.S linux-2.6.15-rc1-git6/arch/powerpc/kernel/entry_64.S
--- linux-2.6.15-rc1-git6.orig/arch/powerpc/kernel/entry_64.S	2005-11-18 05:16:42.000000000 -0800
+++ linux-2.6.15-rc1-git6/arch/powerpc/kernel/entry_64.S	2005-11-18 05:48:12.000000000 -0800
@@ -603,6 +603,9 @@
 	b	.ret_from_except_lite
 
 1:	bl	.save_nvgprs
+#ifdef CONFIG_PERFMON
+	bl	.ppc64_pfm_handle_work
+#endif /* CONFIG_PERFMON */
 	li	r3,0
 	addi	r4,r1,STACK_FRAME_OVERHEAD
 	bl	.do_signal
diff -urN linux-2.6.15-rc1-git6.orig/arch/powerpc/kernel/process.c linux-2.6.15-rc1-git6/arch/powerpc/kernel/process.c
--- linux-2.6.15-rc1-git6.orig/arch/powerpc/kernel/process.c	2005-11-18 05:16:42.000000000 -0800
+++ linux-2.6.15-rc1-git6/arch/powerpc/kernel/process.c	2005-11-18 05:48:12.000000000 -0800
@@ -38,6 +38,7 @@
 #include <linux/hardirq.h>
 #include <linux/utsname.h>
 #include <linux/kprobes.h>
+#include <linux/perfmon.h>
 
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
@@ -306,7 +307,9 @@
 #endif
 
 	local_irq_save(flags);
+	pfm_ctxswout(prev);
 	last = _switch(old_thread, new_thread);
+	pfm_ctxswin(current);
 
 	local_irq_restore(flags);
 
@@ -447,6 +450,7 @@
 		last_task_used_spe = NULL;
 #endif
 #endif /* CONFIG_SMP */
+	pfm_exit_thread(current);
 }
 
 void flush_thread(void)
@@ -570,6 +574,7 @@
 	kregs->nip = (unsigned long)ret_from_fork;
 	p->thread.last_syscall = -1;
 #endif
+	pfm_copy_thread(p, childregs);
 
 	return 0;
 }
diff -urN linux-2.6.15-rc1-git6.orig/arch/powerpc/kernel/systbl.S linux-2.6.15-rc1-git6/arch/powerpc/kernel/systbl.S
--- linux-2.6.15-rc1-git6.orig/arch/powerpc/kernel/systbl.S	2005-11-18 05:16:42.000000000 -0800
+++ linux-2.6.15-rc1-git6/arch/powerpc/kernel/systbl.S	2005-11-18 05:48:12.000000000 -0800
@@ -319,3 +319,15 @@
 SYSCALL(inotify_init)
 SYSCALL(inotify_add_watch)
 SYSCALL(inotify_rm_watch)
+SYSCALL(pfm_create_context)
+SYSCALL(pfm_write_pmcs)
+SYSCALL(pfm_write_pmds)
+SYSCALL(pfm_read_pmds)
+SYSCALL(pfm_load_context)
+SYSCALL(pfm_start)
+SYSCALL(pfm_stop)
+SYSCALL(pfm_restart)
+SYSCALL(pfm_create_evtsets)
+SYSCALL(pfm_getinfo_evtsets)
+SYSCALL(pfm_delete_evtsets)
+SYSCALL(pfm_unload_context)
diff -urN linux-2.6.15-rc1-git6.orig/arch/powerpc/perfmon/Kconfig linux-2.6.15-rc1-git6/arch/powerpc/perfmon/Kconfig
--- linux-2.6.15-rc1-git6.orig/arch/powerpc/perfmon/Kconfig	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.15-rc1-git6/arch/powerpc/perfmon/Kconfig	2005-11-18 05:48:12.000000000 -0800
@@ -0,0 +1,7 @@
+config PERFMON_POWER5
+	tristate "Support for Power5 hardware performance counters"
+	depends on PERFMON
+	default m
+	help
+	Enables support for the Power 5 hardware performance counters
+	If unsure, say M.
diff -urN linux-2.6.15-rc1-git6.orig/arch/powerpc/perfmon/Makefile linux-2.6.15-rc1-git6/arch/powerpc/perfmon/Makefile
--- linux-2.6.15-rc1-git6.orig/arch/powerpc/perfmon/Makefile	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.15-rc1-git6/arch/powerpc/perfmon/Makefile	2005-11-18 05:48:12.000000000 -0800
@@ -0,0 +1,2 @@
+obj-$(CONFIG_PERFMON)		+= perfmon.o
+obj-$(CONFIG_PERFMON_POWER5)	+= perfmon_power5.o
diff -urN linux-2.6.15-rc1-git6.orig/arch/powerpc/perfmon/perfmon.c linux-2.6.15-rc1-git6/arch/powerpc/perfmon/perfmon.c
--- linux-2.6.15-rc1-git6.orig/arch/powerpc/perfmon/perfmon.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.15-rc1-git6/arch/powerpc/perfmon/perfmon.c	2005-11-18 05:48:12.000000000 -0800
@@ -0,0 +1,347 @@
+/*
+ * This file implements the ppc64 specific
+ * support for the perfmon2 interface
+ *
+ * Copyright (c) 2005 David Gibson, IBM Corporation.
+ *
+ * based on versions for other architectures:
+ * Copyright (c) 2005 Hewlett-Packard Development Company, L.P.
+ * Contributed by Stephane Eranian <eranian@hpl.hp.com>
+ */
+#include <linux/interrupt.h>
+#include <linux/perfmon.h>
+
+/*
+ * collect pending overflowed PMDs. Called from ctxswout_*()
+ * and from PMU interrupt handler. Must fill in set->set_povfl_pmds[]
+ * and set->set_npend_ovfls. Interrupts are masked
+ */
+static void __pfm_get_ovfl_pmds(struct pfm_context *ctx, struct pfm_event_set *set)
+{
+ 	u64 new_val, wmask;
+	unsigned long *used_mask;
+	unsigned int i, max;
+
+	max = pfm_pmu_conf->max_cnt_pmd;
+	used_mask = set->set_used_pmds;
+	wmask = PFM_ONE_64 << pfm_pmu_conf->counter_width;
+
+	for (i = 0; i < max; i++) {
+		/* assume all PMD are counters */
+		if (pfm_bv_isset(used_mask, i)) {
+			new_val = pfm_arch_read_pmd(ctx, i);
+
+ 			DPRINT_ovfl(("pmd%u new_val=0x%lx bit=%d\n",
+  				i, new_val, (new_val&wmask) ? 1 : 0));
+
+  			if ((new_val & wmask) == 0) {
+				pfm_bv_set(set->set_povfl_pmds, i);
+				set->set_npend_ovfls++;
+			}
+		}
+	}
+}
+
+/*
+ * Called from pfm_ctxswout_*(). Task is guaranteed to be current.
+ * Context is locked. Interrupts are masked. Monitoring is active.
+ * PMU access is guaranteed. PMC and PMD registers are live in PMU.
+ *
+ * for per-thread:
+ * 	must stop monitoring for the task
+ * for system-wide:
+ * 	must ensure task has monitoring stopped. But monitoring may continue
+ * 	on the current processor
+ */
+void pfm_arch_ctxswout(struct task_struct *task, struct pfm_context *ctx,
+		       struct pfm_event_set *set)
+{
+	mtspr(SPRN_MMCR0, MMCR0_FC);
+
+	if (ctx->ctx_fl_system)
+		return;
+
+	/*
+	 * disable lazy restore of PMC registers.
+	 */
+	if (set)
+		set->set_priv_flags |= PFM_SETFL_PRIV_MOD_PMCS;
+
+	__pfm_get_ovfl_pmds(ctx, set);
+}
+
+/*
+ * Called from pfm_ctxswin_*(). Task is guaranteed to be current.
+ * set cannot be NULL. Context is locked. Interrupts are masked.
+ * Caller has already restored all PMD and PMC registers.
+ *
+ * must reactivate monitoring
+ */
+void pfm_arch_ctxswin(struct task_struct *task,
+		struct pfm_context *ctx, struct pfm_event_set *set)
+{
+	/* nothing to do will be restored correctly */
+}
+
+/*
+ * Called from pfm_stop() and pfm_ctxswin_*() when idle
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
+ * called from pfm_start() or pfm_ctxswout_sys() when idle task and
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
+	mtspr(SPRN_MMCR0, set->set_pmcs[0]);
+	mtspr(SPRN_MMCR1, set->set_pmcs[1]);
+	mtspr(SPRN_MMCRA, set->set_pmcs[2]);
+}
+
+void pfm_arch_start(struct task_struct *task, struct pfm_context *ctx,
+		    struct pfm_event_set *set)
+{
+	/*
+	 * mask/unmask uses start/stop mechanism, so we cannot allow
+	 * while masked.
+	 */
+	if (ctx->ctx_state == PFM_CTX_MASKED)
+		return;
+
+	__pfm_arch_start(task, ctx, set);
+}
+
+/*
+ * function called from pfm_switch_sets(), pfm_context_load_thread(),
+ * pfm_context_load_sys(), pfm_ctxswin_*(), pfm_switch_sets()
+ * context is locked. Interrupts are masked. set cannot be NULL.
+ * Access to the PMU is guaranteed.
+ *
+ * function must restore all PMD registers from set.
+ */
+void pfm_arch_restore_pmds(struct pfm_context *ctx, struct pfm_event_set *set)
+{
+	unsigned int i;
+	unsigned int num_cnt;
+	u64 ovfl_mask, val, *pmds;
+
+	num_cnt   = pfm_pmu_conf->num_pmds;
+	ovfl_mask = pfm_pmu_conf->ovfl_mask;
+	pmds      = set->set_view->set_pmds;
+
+	/* start at 1 to skip TB */
+	for (i = 1; i < num_cnt; i++) {
+		val = pmds[i] & ovfl_mask;
+		pfm_arch_write_pmd(ctx, i, val);
+	}
+}
+
+/*
+ * function called from pfm_switch_sets(), pfm_context_load_thread(),
+ * pfm_context_load_sys(), pfm_ctxswin_*(), pfm_switch_sets()
+ * context is locked. Interrupts are masked. set cannot be NULL.
+ * Access to the PMU is guaranteed.
+ *
+ * function must restore all PMC registers from set, if needed.
+ */
+void pfm_arch_restore_pmcs(struct pfm_context *ctx, struct pfm_event_set *set)
+{
+	unsigned int i, num_cnt;
+
+	num_cnt   = pfm_pmu_conf->num_pmcs;
+
+	/*
+	 * - by default, no PMC measures anything
+	 * - on ctxswout, all used PMCs are disabled (cccr cleared)
+	 *
+	 * we need to restore the PMC (incl enable bits) only if
+	 * not masked and user issued pfm_start()
+	 */
+	if (ctx->ctx_state == PFM_CTX_MASKED || ctx->ctx_fl_started == 0)
+		return;
+
+	/*
+	 * restore all pmcs
+	 */
+	for (i = 0; i < num_cnt; i++)
+		pfm_arch_write_pmc(ctx, i, set->set_pmcs[i]);
+}
+
+/*
+ * function called from pfm_mask_monitoring(), pfm_switch_sets(),
+ * pfm_ctxswout_*(), pfm_flush_pmds().
+ * context is locked. interrupts are masked. the set argument cannot
+ * be NULL. Access to PMU is guaranteed.
+ *
+ * function must saved PMD registers into set save area set_pmds[]
+ */
+void pfm_arch_save_pmds(struct pfm_context *ctx, struct pfm_event_set *set)
+{
+	unsigned int i;
+	u64 ovfl_mask, *pmds, hw_val, used_mask;
+
+	ovfl_mask = pfm_pmu_conf->ovfl_mask;
+	used_mask = set->set_used_pmds[0];
+	pmds      = set->set_view->set_pmds;
+
+	/*
+	 * save all used pmds
+	 * XXX: assume all pmds are counters
+	 */
+	for (i = 0; used_mask; i++, used_mask >>=1) {
+		if (likely(used_mask & 0x1)) {
+			hw_val = pfm_arch_read_pmd(ctx, i);
+			pmds[i] = (pmds[i] & ~ovfl_mask) | (hw_val & ovfl_mask);
+		}
+	}
+}
+
+asmlinkage void pfm_intr_handler(struct pt_regs *regs)
+{
+	pfm_interrupt_handler(0, NULL, regs);
+}
+	
+int pfm_arch_initialize(void)
+{
+	return 0;
+}
+
+extern void ppc64_enable_pmcs(void);
+
+void pfm_arch_init_percpu(void)
+{
+	ppc64_enable_pmcs();
+}
+
+/*
+ * function called from pfm_load_context_*(). Task is not guaranteed to be
+ * current task. If not then other task is guaranteed stopped and off any CPU.
+ * context is locked and interrupts are masked.
+ *
+ * On PFM_LOAD_CONTEXT, the interface guarantees monitoring is stopped.
+ *
+ * For system-wide task is NULL
+ */
+int pfm_arch_load_context(struct pfm_context *ctx, struct task_struct *task)
+{
+	return 0;
+}
+
+/*
+ * called from __pfm_interrupt_handler(). ctx is not NULL.
+ * ctx is locked. PMU interrupt is masked.
+ *
+ * must stop all monitoring to ensure handler has consistent view.
+ * must collect overflowed PMDs bitmask  into set_povfls_pmds and
+ * set_npend_ovfls. If no interrupt detected then set_npend_ovfls
+ * must be set to zero.
+ */
+void pfm_arch_intr_freeze_pmu(struct pfm_context *ctx)
+{
+	mtspr(SPRN_MMCR0, MMCR0_FC);
+	__pfm_get_ovfl_pmds(ctx, ctx->ctx_active_set);
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
+	pfm_arch_restore_pmcs(ctx, ctx->ctx_active_set);
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
+	__pfm_arch_start(current, ctx, ctx->ctx_active_set);
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
+static void pfm_stop_one_pmu(void *data)
+{
+	mtspr(SPRN_MMCR0, MMCR0_FC);
+}
+
+/*
+ * called from pfm_register_pmu_config() after the new
+ * config has been validated and installed. The pfm_session_lock
+ * is held. Interrupts are not masked.
+ *
+ * The role of the function is, based on the PMU description, to
+ * put the PMU into a quiet state on each CPU. This function is only
+ * needed when there is no architected way to do this operation. In
+ * that case nothing can be done before a pmu description is registered.
+ */
+void pfm_arch_pmu_config_init(struct pfm_pmu_config *cfg)
+{
+	on_each_cpu(pfm_stop_one_pmu, cfg, 1, 1);
+}
diff -urN linux-2.6.15-rc1-git6.orig/arch/powerpc/perfmon/perfmon_power5.c linux-2.6.15-rc1-git6/arch/powerpc/perfmon/perfmon_power5.c
--- linux-2.6.15-rc1-git6.orig/arch/powerpc/perfmon/perfmon_power5.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.15-rc1-git6/arch/powerpc/perfmon/perfmon_power5.c	2005-11-18 05:48:12.000000000 -0800
@@ -0,0 +1,103 @@
+/*
+ * This file contains the POWER4 and decendent PMU register description tables
+ * and pmc checker used by perfmon.c.
+ *
+ * Copyright (c) 2005 David Gibson, IBM Corporation.
+ *
+ * Based on perfmon_p6.c:
+ * Copyright (c) 2005 Hewlett-Packard Development Company, L.P.
+ * Contributed by Stephane Eranian <eranian@hpl.hp.com>
+ */
+#include <linux/module.h>
+#include <linux/perfmon.h>
+
+MODULE_AUTHOR("David Gibson <dwg@au1.ibm.com>");
+MODULE_DESCRIPTION("POWER4 performance counters");
+MODULE_LICENSE("GPL");
+
+static struct pfm_reg_desc pfm_power5_pmc_desc[PFM_MAX_PMCS+1]={
+/* mmcr0 */ {PFM_REG_W, "MMCR0", MMCR0_FC, 0, {RDEP(0)|RDEP(1)|RDEP(2)|RDEP(3)|RDEP(4)|RDEP(5)|RDEP(6)}},
+/* mmcr1 */ {PFM_REG_W, "MMCR1", 0x0, 0, {RDEP(0)|RDEP(1)|RDEP(2)|RDEP(3)|RDEP(4)|RDEP(5)|RDEP(6)}},
+/* mmcra */ {PFM_REG_W, "MMCRA", 0x0, 0, {RDEP(0)|RDEP(1)|RDEP(2)|RDEP(3)|RDEP(4)|RDEP(5)|RDEP(6)}},
+	    {PFM_REG_END,} /* end marker */
+};
+
+static struct pfm_reg_desc pfm_power5_pmd_desc[PFM_MAX_PMDS+1]={
+/* tb    */ {PFM_REG_C, "TB"  , 0x0, -1, {0}},
+/* pmd1  */ {PFM_REG_C, "PMC1", 0x0, 0, {0}},
+/* pmd2  */ {PFM_REG_C, "PMC2", 0x0, 0, {0}},
+/* pmd3  */ {PFM_REG_C, "PMC3", 0x0, 0, {0}},
+/* pmd4  */ {PFM_REG_C, "PMC4", 0x0, 0, {0}},
+/* pmd5  */ {PFM_REG_C, "PMC5", 0x0, 0, {0}},
+/* pmd6  */ {PFM_REG_C, "PMC6", 0x0, 0, {0}},
+	    { PFM_REG_END, } /* end marker */
+};
+
+static int pfm_power5_pmc_check(struct pfm_context *ctx, struct pfm_event_set *set,
+			        u16 cnum, u32 flags, u64 *val)
+{
+	u64 tmpval;
+	u64 tmp1, tmp2;
+	u64 rsvd_mask, dfl_value;
+
+	tmpval    = *val;
+	rsvd_mask = pfm_power5_pmc_desc[cnum].reserved_mask;
+	dfl_value = pfm_power5_pmc_desc[cnum].default_value;
+
+	/* remove reserved areas from user value */
+	tmp1 = tmpval & rsvd_mask;
+
+	/* get reserved fields values */
+	tmp2 = dfl_value & ~rsvd_mask;
+
+	tmpval = tmp1 | tmp2;
+
+	*val = tmpval;
+
+	DPRINT(("pmc%u(%s): ival=0x%llx, rsvd_mask=0x%llx, def_value=0x%llx, "
+		"new_val=0x%llx\n",
+		cnum, 
+		pfm_power5_pmc_desc[cnum].desc,
+		(unsigned long long)*val,
+		(unsigned long long)rsvd_mask,
+		(unsigned long long)dfl_value,
+		(unsigned long long)tmpval));
+
+	return 0;
+}
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
+	.pmu_name        = "POWER5",
+	.counter_width   = 31,
+	.pmd_desc        = pfm_power5_pmd_desc,
+	.pmc_desc        = pfm_power5_pmc_desc,
+	.pmc_write_check = pfm_power5_pmc_check,
+	.probe_pmu	 = pfm_power5_probe_pmu,
+	.version	 = "0.0"
+};
+	
+static int __init pfm_power5_pmu_init_module(void)
+{
+	return pfm_register_pmu_config(&pfm_power5_pmu_conf);
+}
+
+static void __exit pfm_power5_pmu_cleanup_module(void)
+{
+	pfm_unregister_pmu_config(&pfm_power5_pmu_conf);
+}
+
+module_init(pfm_power5_pmu_init_module);
+module_exit(pfm_power5_pmu_cleanup_module);
diff -urN linux-2.6.15-rc1-git6.orig/include/asm-powerpc/perfmon.h linux-2.6.15-rc1-git6/include/asm-powerpc/perfmon.h
--- linux-2.6.15-rc1-git6.orig/include/asm-powerpc/perfmon.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.15-rc1-git6/include/asm-powerpc/perfmon.h	2005-11-18 05:48:12.000000000 -0800
@@ -0,0 +1,257 @@
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
+ */
+#ifndef _ASM_PPC64_PERFMON_H_
+#define _ASM_PPC64_PERFMON_H_
+
+#ifdef __KERNEL__
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
+static inline void pfm_arch_ovfl_reset_pmd(struct pfm_context *ctx, unsigned int cnum)
+{
+}
+
+static inline void
+pfm_arch_resend_irq(void)
+{
+	/* nothing needed */
+}
+
+#define pfm_arch_serialize()	/* nothing */
+
+static inline void
+pfm_arch_unfreeze_pmu(void)
+{
+}
+
+static inline u64
+pfm_arch_get_itc(void)
+{
+	return mftb();
+}
+
+static inline void
+pfm_arch_write_pmc(struct pfm_context *ctx, unsigned int cnum, u64 value)
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
+static inline void
+pfm_arch_write_pmd(struct pfm_context *ctx, unsigned int cnum, u64 value)
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
+static inline u64
+pfm_arch_read_pmd(struct pfm_context *ctx, unsigned int cnum)
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
+static inline u64
+pfm_arch_read_pmc(struct pfm_context *ctx, unsigned int cnum)
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
+ * information is tracked in ctx_fl_started. However on certain
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
+extern void pfm_arch_init_percpu(void);
+extern int  pfm_arch_is_monitoring_active(struct pfm_context *ctx);
+extern void pfm_arch_ctxswout(struct task_struct *task, struct pfm_context *ctx,
+			      struct pfm_event_set *set);
+extern void pfm_arch_ctxswin(struct task_struct *task, struct pfm_context *ctx,
+			     struct pfm_event_set *set);
+extern void pfm_arch_stop(struct task_struct *task, struct pfm_context *ctx,
+			  struct pfm_event_set *set);
+extern void pfm_arch_start(struct task_struct *task, struct pfm_context *ctx,
+			   struct pfm_event_set *set);
+extern void pfm_arch_restore_pmds(struct pfm_context *ctx, struct pfm_event_set *set);
+extern void pfm_arch_save_pmds(struct pfm_context *ctx, struct pfm_event_set *set);
+extern void pfm_arch_restore_pmcs(struct pfm_context *ctx, struct pfm_event_set *set);
+extern int  pfm_arch_get_ovfl_pmds(struct pfm_context *ctx,
+				   struct pfm_event_set *set);
+extern void pfm_arch_intr_freeze_pmu(struct pfm_context *ctx);
+extern void pfm_arch_intr_unfreeze_pmu(struct pfm_context *ctx);
+extern int  pfm_arch_initialize(void);
+extern void pfm_arch_mask_monitoring(struct pfm_context *ctx);
+extern void pfm_arch_unmask_monitoring(struct pfm_context *ctx);
+extern void pfm_arch_pmu_config_init(struct pfm_pmu_config *cfg);
+
+/*
+ * called from pfm_register_pmu_config() after the new
+ * config has been validated and installed. The pfs_lock is held
+ * is held.
+ *
+ * Must sanity check the arch-specific config information
+ *
+ * return:
+ * 	< 0 : if error
+ * 	  0 : if success
+ */
+static inline int pfm_arch_pmu_config_check(struct pfm_pmu_config *cfg)
+{
+	return 0;
+}
+
+//static inline void pfm_arch_context_initialize(struct pfm_context *ctx, u32 ctx_flags);
+#define pfm_arch_context_initialize(ctx, ctx_flags) /* nothing */
+
+extern int  pfm_arch_load_context(struct pfm_context *ctx, struct task_struct *task);
+extern void pfm_arch_unload_context(struct pfm_context *ctx, struct task_struct *task);
+
+static inline int
+pfm_arch_reserve_session(struct pfm_context *ctx, unsigned int cpu)
+{
+	return 0;
+}
+
+//static inline void pfm_arch_unreserve_session(struct pfm_context *ctx, unsigned int cpu)
+#define pfm_arch_unreserve_session(ctx, cpu) /* nothing */
+
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
+static inline int
+pfm_arch_setfl_sane(struct pfm_context *ctx, u32 flags)
+{
+	return 0;
+}
+
+//static inline void pfm_arch_show_session(struct seq_file *m);
+#define pfm_arch_show_session(m) /* nothing */
+
+struct pfm_arch_context {
+	/* empty */
+};
+
+#define PFM_ARCH_CTX_SIZE	sizeof(struct pfm_arch_context)
+
+#endif /* __KERNEL__ */
+#endif /* _ASM_PPC64_PERFMON_H_ */
diff -urN linux-2.6.15-rc1-git6.orig/include/asm-powerpc/processor.h linux-2.6.15-rc1-git6/include/asm-powerpc/processor.h
--- linux-2.6.15-rc1-git6.orig/include/asm-powerpc/processor.h	2005-11-18 05:16:51.000000000 -0800
+++ linux-2.6.15-rc1-git6/include/asm-powerpc/processor.h	2005-11-18 05:48:12.000000000 -0800
@@ -194,6 +194,7 @@
 	unsigned long	spefscr;	/* SPE & eFP status */
 	int		used_spe;	/* set if process has used spe */
 #endif /* CONFIG_SPE */
+	void *pfm_context;
 };
 
 #define ARCH_MIN_TASKALIGN 16
diff -urN linux-2.6.15-rc1-git6.orig/include/asm-powerpc/unistd.h linux-2.6.15-rc1-git6/include/asm-powerpc/unistd.h
--- linux-2.6.15-rc1-git6.orig/include/asm-powerpc/unistd.h	2005-11-18 05:16:51.000000000 -0800
+++ linux-2.6.15-rc1-git6/include/asm-powerpc/unistd.h	2005-11-18 05:48:12.000000000 -0800
@@ -297,6 +297,19 @@
 #define __NR_inotify_add_watch	276
 #define __NR_inotify_rm_watch	277
 
+#define __NR_pfm_create_context	278
+#define __NR_pfm_write_pmcs	(__NR_pfm_create_context+1)
+#define __NR_pfm_write_pmds	(__NR_pfm_create_context+2)
+#define __NR_pfm_read_pmds	(__NR_pfm_create_context+3)
+#define __NR_pfm_load_context	(__NR_pfm_create_context+4)
+#define __NR_pfm_start		(__NR_pfm_create_context+5)
+#define __NR_pfm_stop		(__NR_pfm_create_context+6)
+#define __NR_pfm_restart	(__NR_pfm_create_context+7)
+#define __NR_pfm_create_evtsets	(__NR_pfm_create_context+8)
+#define __NR_pfm_getinfo_evtsets (__NR_pfm_create_context+9)
+#define __NR_pfm_delete_evtsets (__NR_pfm_create_context+10)
+#define __NR_pfm_unload_context	(__NR_pfm_create_context+11)
+
 #define __NR_syscalls		278
 
 #ifdef __KERNEL__

--PPYy/fEw/8QCHSq3--
