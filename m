Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932406AbWHWIRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbWHWIRG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 04:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbWHWIQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 04:16:42 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:55513 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S932395AbWHWIQ0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 04:16:26 -0400
Date: Wed, 23 Aug 2006 01:06:01 -0700
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200608230806.k7N86151000456@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 10/18] 2.6.17.9 perfmon2 patch for review: PMU context switch support
Cc: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@frankl.hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the PMU context switch routines.

For per-thread contexts, the PMU state must be saved and restored on
context switch. For systm-wide context we may need to intervene on
certain architectures to cleanup certain registers.

The PMU context switch code is concentrated into a single routine
named pfm_ctxsw() which is called from __switch_to().

Because accessing PMU registers is usually much more expensive
than accessing general registers, we take great care at minimizing
the number of register accesses using various lazy save/restore schemes
for both UP and SMP kernels.



--- linux-2.6.17.9.base/perfmon/perfmon_ctxsw.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17.9/perfmon/perfmon_ctxsw.c	2006-08-21 03:37:46.000000000 -0700
@@ -0,0 +1,333 @@
+/*
+ * perfmon_cxtsw.c: perfmon2 context switch code
+ *
+ * This file implements the perfmon2 interface which
+ * provides access to the hardware performance counters
+ * of the host processor.
+ *
+ * The initial version of perfmon.c was written by
+ * Ganesh Venkitachalam, IBM Corp.
+ *
+ * Then it was modified for perfmon-1.x by Stephane Eranian and
+ * David Mosberger, Hewlett Packard Co.
+ *
+ * Version Perfmon-2.x is a complete rewrite of perfmon-1.x
+ * by Stephane Eranian, Hewlett Packard Co.
+ *
+ * Copyright (c) 1999-2006 Hewlett-Packard Development Company, L.P.
+ * Contributed by Stephane Eranian <eranian@hpl.hp.com>
+ *                David Mosberger-Tang <davidm@hpl.hp.com>
+ *
+ * More information about perfmon available at:
+ * 	http://www.hpl.hp.com/research/linux/perfmon
+ */
+#include <linux/kernel.h>
+#include <linux/perfmon.h>
+
+
+#ifdef CONFIG_SMP
+#define PFM_LAST_CPU(ctx, act) \
+	((ctx)->last_cpu == smp_processor_id() && (ctx)->last_act == act)
+#else
+#define PFM_LAST_CPU(ctx, act) \
+	((ctx)->last_act == act)
+#endif
+
+void pfm_save_pmds(struct pfm_context *ctx, struct pfm_event_set *set)
+{
+	u64 val, hw_val, *pmds, ovfl_mask;
+	u64 *used_mask, *cnt_mask;
+	u16 i, num;
+
+	ovfl_mask = pfm_pmu_conf->ovfl_mask;
+	num = set->nused_pmds;
+	cnt_mask = pfm_pmu_conf->cnt_pmds;
+	used_mask = set->used_pmds;
+	pmds = set->view->set_pmds;
+
+	for (i = 0; num; i++) {
+		if (pfm_bv_isset(used_mask, i)) {
+			hw_val = val = pfm_read_pmd(ctx, i);
+			if (likely(pfm_bv_isset(cnt_mask, i)))
+				val = (pmds[i] & ~ovfl_mask) |
+					(hw_val & ovfl_mask);
+			pmds[i] = val;
+			num--;
+		}
+	}
+}
+
+/*
+ * interrupts are masked
+ */
+static void __pfm_ctxswin_thread(struct task_struct *task,
+				 struct pfm_context *ctx)
+{
+	u64 cur_act, now;
+	struct pfm_event_set *set;
+	int reload_pmcs, reload_pmds;
+
+	now = pfm_arch_get_itc();
+
+	BUG_ON(!task->pid);
+
+	spin_lock(&ctx->lock);
+
+	cur_act = __get_cpu_var(pmu_activation_number);
+
+	set = ctx->active_set;
+
+	/*
+	 * in case fo zombie, we do not complete ctswin of the
+	 * PMU, and we force a call to pfm_handle_work() to finish
+	 * cleanup, i.e., free context + smpl_buff. The reason for
+	 * deferring to pfm_handle_work() is that it is not possible
+	 * to vfree() with interrupts disabled.
+	 */
+	if (unlikely(ctx->state == PFM_CTX_ZOMBIE)) {
+		ctx->flags.trap_reason = PFM_TRAP_REASON_ZOMBIE;
+		set_tsk_thread_flag(task, TIF_NOTIFY_RESUME);
+		spin_unlock(&ctx->lock);
+		return;
+	}
+
+	if (set->flags & PFM_SETFL_TIME_SWITCH)
+		__get_cpu_var(pfm_syst_info) = PFM_CPUINFO_TIME_SWITCH;
+
+	/*
+	 * if we were the last user of the PMU on that CPU,
+	 * then nothing to do except restore psr
+	 */
+	if (PFM_LAST_CPU(ctx, cur_act)) {
+		/*
+		 * check for forced reload conditions
+		 */
+		reload_pmcs = set->priv_flags & PFM_SETFL_PRIV_MOD_PMCS;
+		reload_pmds = set->priv_flags & PFM_SETFL_PRIV_MOD_PMDS;
+	} else {
+#ifndef CONFIG_SMP
+		struct pfm_context *ctxp;
+		ctxp = __get_cpu_var(pmu_ctx);
+		if (ctxp) {
+			struct pfm_event_set *setp;
+			setp = ctxp->active_set;
+			pfm_modview_begin(setp);
+			pfm_save_pmds(ctxp, setp);
+			setp->view->set_status &= ~PFM_SETVFL_ACTIVE;
+			pfm_modview_end(setp);
+			/*
+			 * do not clear ownership because we rewrite
+			 * right away
+			 */
+		}
+#endif
+		reload_pmcs = 1;
+		reload_pmds = 1;
+	}
+	/* consumed */
+	set->priv_flags &= ~PFM_SETFL_PRIV_MOD_BOTH;
+
+	if (reload_pmds)
+		pfm_arch_restore_pmds(ctx, set);
+
+	/*
+	 * need to check if had in-flight interrupt in
+	 * pfm_ctxswout_thread(). If at least one bit set, then we must replay
+	 * the interrupt to avoid losing some important performance data.
+	 *
+	 * npend_ovfls is cleared in interrupt handler
+	 */
+	if (set->npend_ovfls) {
+		pfm_arch_resend_irq();
+		__get_cpu_var(pfm_stats).pfm_ovfl_intr_replay_count++;
+	}
+
+	if (reload_pmcs)
+		pfm_arch_restore_pmcs(ctx, set);
+
+	/*
+	 * record current activation for this context
+	 */
+	pfm_inc_activation();
+	pfm_set_last_cpu(ctx, smp_processor_id());
+	pfm_set_activation(ctx);
+
+	/*
+	 * establish new ownership.
+	 */
+	pfm_set_pmu_owner(task, ctx);
+
+	pfm_arch_ctxswin_thread(task, ctx, set);
+	/*
+	 * ctx->duration does count even when context in MASKED state
+	 * set->duration does not count when context in MASKED state.
+	 * But the set->duration_start is reset in unmask_monitoring()
+	 */
+	ctx->duration_start = now;
+	set->duration_start = now;
+
+	spin_unlock(&ctx->lock);
+}
+
+/*
+ * interrupts are masked, runqueue lock is held.
+ *
+ * In UP. we simply stop monitoring and leave the state
+ * in place, i.e., lazy save
+ */
+static void __pfm_ctxswout_thread(struct task_struct *task,
+				  struct pfm_context *ctx)
+{
+	struct pfm_event_set *set;
+	u64 now;
+	int need_save_pmds;
+
+	now = pfm_arch_get_itc();
+
+	spin_lock(&ctx->lock);
+
+	set = ctx->active_set;
+
+	pfm_modview_begin(set);
+
+	/*
+	 * stop monitoring and collect any pending
+	 * overflow information into set_povfl_pmds
+	 * and set_npend_ovfls for use on ctxswin_thread()
+	 * to potentially replay the PMU interrupt
+	 *
+	 * The key point is that we cannot afford to loose a PMU
+	 * interrupt. We cannot cancel in-flight interrupts, therefore
+	 * we let them happen and be treated as spurious and then we
+	 * replay them on ctxsw in.
+	 */
+	need_save_pmds = pfm_arch_ctxswout_thread(task, ctx, set);
+
+	ctx->duration += now - ctx->duration_start;
+	/*
+	 * accumulate only when set is actively monitoring,
+	 */
+	if (ctx->state == PFM_CTX_LOADED)
+		set->duration += now - set->duration_start;
+
+#ifdef CONFIG_SMP
+	/*
+	 * in SMP, release ownership of this PMU.
+	 * PMU interrupts are masked, so nothing
+	 * can happen.
+	 */
+	pfm_set_pmu_owner(NULL, NULL);
+
+	/*
+	 * On some architectures, it is necessary to read the
+	 * PMD registers to check for pending overflow in
+	 * pfm_arch_ctxswout_thread(). In that case, saving of
+	 * the PMDs  may be  done there and not here.
+	 */
+	if (need_save_pmds)
+		pfm_save_pmds(ctx, set);
+#endif
+	pfm_modview_end(set);
+
+	/*
+	 * clear cpuinfo, cpuinfo is used in
+	 * per task mode with the set time switch flag.
+	 */
+	__get_cpu_var(pfm_syst_info) = 0;
+
+	spin_unlock(&ctx->lock);
+}
+
+/*
+ * no need to lock the context. To operate on a system-wide
+ * context, the task has to run on the monitored CPU. In the
+ * case of close issued on another CPU, an IPI is sent but
+ * this routine runs with interrupts masked, so we are
+ * protected
+ */
+static void __pfm_ctxsw_sys(struct task_struct *prev,
+			    struct task_struct *next)
+{
+	struct pfm_context *ctx;
+	struct pfm_event_set *set;
+	u32 has_excl;
+
+	ctx = __get_cpu_var(pmu_ctx);
+	if (!ctx) {
+		pr_info("prev=%d tif=%d ctx=%p next=%d tif=%d ctx=%p\n",
+			prev->pid,
+			test_tsk_thread_flag(prev, TIF_PERFMON),
+			prev->pfm_context,
+			next->pid,
+			test_tsk_thread_flag(next, TIF_PERFMON),
+			next->pfm_context);
+		BUG_ON(!ctx);
+	}
+
+	set = ctx->active_set;
+	has_excl = set->flags & PFM_SETFL_EXCL_IDLE;
+
+	/*
+	 * propagate TIF_PERFMON to ensure that:
+	 * - previous task has TIF_PERFMON cleared, in case it is
+	 *   scheduled onto another CPU where there is syswide monitoring
+	 * - next task has TIF_PERFMON set to ensure it will come back
+	 *   here when context switched out
+	 */
+	clear_tsk_thread_flag(prev, TIF_PERFMON);
+	set_tsk_thread_flag(next, TIF_PERFMON);
+
+	/*
+	 * nothing to do until actually started
+	 * XXX: assumes no mean to start from user level
+	 */
+	if (!ctx->flags.started)
+		return;
+
+	if (unlikely(has_excl)) {
+		if (prev->pid == 0) {
+			pfm_arch_start(next, ctx, set);
+			return;
+		}
+		if (next->pid == 0) {
+			pfm_arch_stop(next, ctx, set);
+			return;
+		} 
+	}
+	pfm_arch_ctxswout_sys(prev, ctx, set);
+	pfm_arch_ctxswin_sys(next, ctx, set);
+}
+
+/*
+ * come here when either prev or next has TIF_PERFMON flag set
+ * Note that this is not because a task has TIF_PERFMON set that
+ * it has a context attached, e.g., in system-wide on certain arch.
+ */
+void __pfm_ctxsw(struct task_struct *prev, struct task_struct *next)
+{
+	struct pfm_context *ctxp, *ctxn;
+	u64 now;
+
+	now = pfm_arch_get_itc();
+
+	ctxp = prev->pfm_context;
+	ctxn = next->pfm_context;
+
+	if (ctxp)
+		__pfm_ctxswout_thread(prev, ctxp);
+
+	if (ctxn)
+		__pfm_ctxswin_thread(next, ctxn);
+
+	/*
+	 * given that prev and next can never be the same, this
+	 * test is checking that ctxp == ctxn == NULL which is
+	 * an indication we have an active system-wide session on
+	 * this CPU
+	 */
+	if (ctxp == ctxn)
+		__pfm_ctxsw_sys(prev, next);
+
+	__get_cpu_var(pfm_stats).pfm_ctxsw_count++;
+	__get_cpu_var(pfm_stats).pfm_ctxsw_cycles += pfm_arch_get_itc() - now;
+}
