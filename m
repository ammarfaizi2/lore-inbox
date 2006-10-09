Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932901AbWJIOPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932901AbWJIOPb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 10:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932829AbWJIOLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 10:11:31 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:29425 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S932874AbWJIOLH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 10:11:07 -0400
Date: Mon, 9 Oct 2006 07:10:17 -0700
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200610091410.k99EAHJb026129@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 10/21] 2.6.18 perfmon2 : PMU context switch support
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



--- linux-2.6.18.base/perfmon/perfmon_ctxsw.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.18/perfmon/perfmon_ctxsw.c	2006-09-26 02:32:47.000000000 -0700
@@ -0,0 +1,344 @@
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
+ * 	http://perfmon2.sf.net
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
+#include <linux/kernel.h>
+#include <linux/perfmon.h>
+
+/*
+ * used only in UP mode
+ */
+void pfm_save_prev_context(struct pfm_context *ctxp)
+{
+	struct pfm_event_set *set;
+
+	/*
+	 * in UP per-thread, due to lazy save
+	 * there could be a context from another
+	 * task. We need to push it first before
+	 * installing our new state
+	 */
+	set = ctxp->active_set;
+	pfm_modview_begin(set);
+	pfm_save_pmds(ctxp, set);
+	set->view->set_status &= ~PFM_SETVFL_ACTIVE;
+	pfm_modview_end(set);
+	/*
+	 * do not clear ownership because we rewrite
+	 * right away
+	 */
+}
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
+				 struct pfm_context *ctx, u64 now)
+{
+	u64 cur_act;
+	struct pfm_event_set *set;
+	int reload_pmcs, reload_pmds;
+
+	BUG_ON(!task->mm);
+
+	/*
+	 * we need to lock context because it could be accessed
+	 * from another CPU
+	 */
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
+		ctx->flags.work_type = PFM_WORK_ZOMBIE;
+		set_tsk_thread_flag(task, TIF_PERFMON_WORK);
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
+	if (ctx->last_cpu == smp_processor_id() && ctx->last_act == cur_act) {
+		/*
+		 * check for forced reload conditions
+		 */
+		reload_pmcs = set->priv_flags & PFM_SETFL_PRIV_MOD_PMCS;
+		reload_pmds = set->priv_flags & PFM_SETFL_PRIV_MOD_PMDS;
+	} else {
+#ifndef CONFIG_SMP
+		struct pfm_context *ctxp;
+		ctxp = __get_cpu_var(pmu_ctx);
+		if (ctxp)
+			pfm_save_prev_context(ctxp);
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
+	 * set->duration does not count when context in MASKED state.
+	 * set->duration_start is reset in unmask_monitoring()
+	 */
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
+				  struct pfm_context *ctx, u64 now)
+{
+	struct pfm_event_set *set;
+	int need_save_pmds;
+
+	/*
+	 * we need to lock context because it could be accessed
+	 * from another CPU
+	 */
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
+ * 
+ * On some architectures, such as IA-64, it may be necessary
+ * to intervene during the context even in system-wide mode
+ * to modify some machine state.
+ */
+static void __pfm_ctxsw_sys(struct task_struct *prev,
+			    struct task_struct *next)
+{
+	struct pfm_context *ctx;
+	struct pfm_event_set *set;
+
+	ctx = __get_cpu_var(pmu_ctx);
+	if (!ctx) {
+		pr_info("prev=%d tif=%d ctx=%p next=%d tif=%d ctx=%p\n",
+			prev->pid,
+			test_tsk_thread_flag(prev, TIF_PERFMON_CTXSW),
+			prev->pfm_context,
+			next->pid,
+			test_tsk_thread_flag(next, TIF_PERFMON_CTXSW),
+			next->pfm_context);
+		BUG_ON(!ctx);
+	}
+
+	set = ctx->active_set;
+
+	/*
+	 * propagate TIF_PERFMON_CTXSW to ensure that:
+	 * - previous task has TIF_PERFMON_CTXSW cleared, in case it is
+	 *   scheduled onto another CPU where there is syswide monitoring
+	 * - next task has TIF_PERFMON_CTXSW set to ensure it will come back
+	 *   here when context switched out
+	 */
+	clear_tsk_thread_flag(prev, TIF_PERFMON_CTXSW);
+	set_tsk_thread_flag(next, TIF_PERFMON_CTXSW);
+
+	/*
+	 * nothing to do until actually started
+	 * XXX: assumes no mean to start from user level
+	 */
+	if (!ctx->flags.started)
+		return;
+
+	pfm_arch_ctxswout_sys(prev, ctx, set);
+	pfm_arch_ctxswin_sys(next, ctx, set);
+}
+
+/*
+ * come here when either prev or next has TIF_PERFMON_CTXSW flag set
+ * Note that this is not because a task has TIF_PERFMON_CTXSW set that
+ * it has a context attached, e.g., in system-wide on certain arch.
+ */
+void __pfm_ctxsw(struct task_struct *prev, struct task_struct *next)
+{
+	struct pfm_context *ctxp, *ctxn;
+	u64 now;
+
+	now = sched_clock();
+
+	ctxp = prev->pfm_context;
+	ctxn = next->pfm_context;
+PFM_DBG("[%d] ctxp=%p [%d] ctxn=%p", prev->pid, ctxp, next->pid, ctxn);
+	if (ctxp)
+		__pfm_ctxswout_thread(prev, ctxp, now);
+
+	if (ctxn)
+		__pfm_ctxswin_thread(next, ctxn, now);
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
+	__get_cpu_var(pfm_stats).pfm_ctxsw_ns += sched_clock() - now;
+}
