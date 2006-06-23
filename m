Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751270AbWFWJVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbWFWJVY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 05:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWFWJVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 05:21:16 -0400
Received: from palrel13.hp.com ([156.153.255.238]:56795 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S1751278AbWFWJVI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 05:21:08 -0400
Date: Fri, 23 Jun 2006 02:13:07 -0700
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200606230913.k5N9D73v032387@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 10/17] 2.6.17.1 perfmon2 patch for review: PMU context switch
Cc: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the PMU context switch routines.




--- linux-2.6.17.1.orig/perfmon/perfmon_ctxsw.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17.1/perfmon/perfmon_ctxsw.c	2006-06-21 04:22:51.000000000 -0700
@@ -0,0 +1,381 @@
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
+#ifdef CONFIG_SMP
+/*
+ * interrupts are masked, runqueue lock is held, context is locked
+ */
+void pfm_ctxswin_thread(struct task_struct *task, struct pfm_context *ctx,
+			struct pfm_event_set *set, int must_reload)
+{
+	u64 cur_act;
+	int reload_pmcs, reload_pmds;
+
+	BUG_ON(task->pid == 0);
+	BUG_ON(__get_cpu_var(pmu_owner));
+
+	BUG_ON(task->pfm_context != ctx);
+
+	cur_act = __get_cpu_var(pmu_activation_number);
+
+	/*
+	 * in case fo zombie, we do not complete ctswin of the
+	 * PMU, and we force a call to pfm_handle_work() to finish
+	 * cleanup, i.e., free context + smpl_buff. The reason for
+	 * deferring to pfm_handle_work() is that it is not possible
+	 * to vfree() with interrupts disabled.
+	 */
+	if (unlikely(ctx->state == PFM_CTX_ZOMBIE)) {
+		struct thread_info *th_info;
+
+		/*
+		 * ensure everything is properly stopped
+		 */
+		__pfm_stop(ctx);
+
+		ctx->flags.trap_reason = PFM_TRAP_REASON_ZOMBIE;
+		th_info = task->thread_info;
+		set_bit(TIF_NOTIFY_RESUME, &th_info->flags);
+
+		return;
+	}
+
+	if (set->flags & PFM_SETFL_TIME_SWITCH)
+		__get_cpu_var(pfm_syst_info) = PFM_CPUINFO_TIME_SWITCH;
+ctx->last_cpu=-1;
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
+	 * the interrupt to avoid loosing some important performance data.
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
+	pfm_arch_ctxswin(task, ctx, set);
+}
+#else /*  !CONFIG_SMP */
+/*
+ * interrupts are disabled
+ */
+void pfm_ctxswin_thread(struct task_struct *task, struct pfm_context *ctx,
+			struct pfm_event_set *set, int force_reload)
+{
+	u32 set_priv_flags;
+
+	set_priv_flags = set->priv_flags;
+
+	if (set->flags & PFM_SETFL_TIME_SWITCH) {
+		__get_cpu_var(pfm_syst_info) = PFM_CPUINFO_TIME_SWITCH;
+	}
+
+	/*
+	 * must force reload due to lazy save
+	 */
+	if (force_reload)
+		set_priv_flags |= PFM_SETFL_PRIV_MOD_BOTH;
+
+	/*
+	 * check what needs to be restored.
+	 * If owner == task, our state is still live and we could
+	 * just reactivate and go. However, we need to check for the
+	 * following conditions:
+	 * 	- pmu owner != task
+	 * 	- PMDs were modified
+	 * 	- PMCs were modified
+	 * 	- arch modifies PMC to stop monitoring
+	 * 	- there was an in-flight interrupt at pfm_ctxswout_thread()
+	 *
+	 * if anyone of these is true, we cannot take the short path, i.e,
+	 * just restore info + arch_ctxswin and return
+	 */
+	if (set_priv_flags & PFM_SETFL_PRIV_MOD_PMDS)
+		pfm_arch_restore_pmds(ctx, set);
+
+	/*
+	 * need to check if had in-flight interrupt at time of pfm_ctxswout_thread().
+	 * If at least one bit set, then we must replay the interrupt to avoid
+	 * losing some important performance data.
+	 */
+	if (set->npend_ovfls) {
+		pfm_arch_resend_irq();
+		__get_cpu_var(pfm_stats).pfm_ovfl_intr_replay_count++;
+	}
+
+	if (set_priv_flags & PFM_SETFL_PRIV_MOD_PMCS)
+		pfm_arch_restore_pmcs(ctx, set);
+
+	set->priv_flags &= ~PFM_SETFL_PRIV_MOD_BOTH;
+
+	/*
+	 * establish new ownership.
+	 */
+	pfm_set_pmu_owner(task, ctx);
+
+	/*
+	 * reactivate monitoring
+	 */
+	pfm_arch_ctxswin(task, ctx, set);
+}
+#endif /* !CONFIG_SMP */
+
+static void pfm_ctxswin_sys(struct task_struct *task, struct pfm_context *ctx,
+			    struct pfm_event_set *set)
+{
+	unsigned long info;
+
+	info = __get_cpu_var(pfm_syst_info);
+
+	/*
+	 * don't do anything before started
+	 */
+	if (ctx->flags.started == 0)
+		return;
+
+	/*
+	 * pid 0 is guaranteed to be the idle task. There is one such task with pid 0
+	 * on each CPU, so we can rely on the pid to identify the idle task.
+	 */
+	if (task->pid == 0 && (set->flags & PFM_SETFL_EXCL_IDLE) != 0)
+		pfm_arch_stop(task ,ctx, set);
+	else
+		pfm_arch_ctxswin(task, ctx, set);
+}
+
+void __pfm_ctxswin(struct task_struct *task)
+{
+	struct pfm_context *ctx, *ctxp;
+	struct pfm_event_set *set;
+	int must_force_reload = 0;
+	u64 now_itc;
+
+	ctxp = __get_cpu_var(pmu_ctx);
+	ctx = task->pfm_context;
+
+	/*
+	 * system-wide   : pmu_ctx must not be NULL to proceed
+	 * per-thread  UP: pmu_ctx may be NULL if no left-over owner
+	 * per-thread SMP: pmu_ctx is always NULL coming in
+	 */
+	if (ctxp == NULL && ctx == NULL)
+		return;
+
+#ifdef CONFIG_SMP
+	/*
+	 * if ctxp != 0, it means we are in system-wide mode.
+	 * thereore ctx is NULL (mutual exclusion)
+	 */
+	if (ctxp)
+		ctx = ctxp;
+#else
+	/*
+	 * someone used the PMU, first push it out and
+	 * then we'll be able to install our stuff !
+	 */
+	if (ctxp && ctxp->flags.system)
+		ctx = ctxp;
+	else if (ctx) {
+		if (ctxp && ctxp != ctx) {
+			pfm_save_pmds_release(ctxp);
+			must_force_reload = 1;
+		}
+	} else
+		return;
+#endif
+	spin_lock(&ctx->lock);
+
+	set = ctx->active_set;
+
+	if (ctx->flags.system)
+		pfm_ctxswin_sys(task, ctx, set);
+	else
+		pfm_ctxswin_thread(task, ctx, set, must_force_reload);
+
+	/*
+	 * ctx->duration does count even when context in MASKED state
+	 * set->duration does not count when context in MASKED state.
+	 * But the set->duration_start is reset in unmask_monitoring()
+	 */
+
+	now_itc = pfm_arch_get_itc();
+
+	ctx->duration_start = now_itc;
+	set->duration_start = now_itc;
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
+void pfm_ctxswout_thread(struct task_struct *task, struct pfm_context *ctx,
+			 struct pfm_event_set *set)
+{
+	BUG_ON(task->pfm_context != ctx);
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
+	pfm_arch_ctxswout(task, ctx, set);
+
+#ifdef CONFIG_SMP
+	/*
+	 * release ownership of this PMU.
+	 * PM interrupts are masked, so nothing
+	 * can happen.
+	 */
+	pfm_set_pmu_owner(NULL, NULL);
+
+	/*
+	 * we systematically save the PMD that we effectively
+	 * use. In SMP, we have no guarantee we will be scheduled
+	 * on the same CPU again.
+	 */
+	pfm_modview_begin(set);
+	pfm_arch_save_pmds(ctx, set);
+	pfm_modview_end(set);
+#endif
+
+	/*
+	 * clear cpuinfo, cpuinfo is used in
+	 * per task mode with the set time switch flag.
+	 */
+	__get_cpu_var(pfm_syst_info) = 0;
+}
+
+static void pfm_ctxswout_sys(struct task_struct *task, struct pfm_context *ctx,
+			     struct pfm_event_set *set)
+{
+	/*
+	 * do nothing before started
+	 * XXX: assumes cannot be started from user level
+	 */
+	if (ctx->flags.started == 0)
+		return;
+
+	/*
+	 * restore monitoring if set has EXCL_IDLE and task was idle task
+	 */
+	if (task->pid == 0 && (set->flags & PFM_SETFL_EXCL_IDLE) != 0) {
+		pfm_arch_start(task, ctx, set);
+	} else {
+		pfm_arch_ctxswout(task, ctx, set);
+	}
+}
+
+/*
+ * we come here on every context switch out.
+ */
+void __pfm_ctxswout(struct task_struct *task)
+{
+	struct pfm_context *ctx;
+	struct pfm_event_set *set;
+	u64 now_itc, diff;
+
+	ctx = __get_cpu_var(pmu_ctx);
+	if (ctx == NULL)
+		return;
+
+	now_itc = pfm_arch_get_itc();
+
+	spin_lock(&ctx->lock);
+
+	set = ctx->active_set;
+
+	if (ctx->flags.system) {
+		pfm_ctxswout_sys(task, ctx, set);
+	} else {
+		/*
+		 * in UP, due to lazy save, we may have a
+		 * context loaded onto the PMU BUT it may not
+		 * be the one from the current task. In that case
+		 * simply skip everything else
+		 */
+		if (task->pfm_context == NULL)
+			goto done;
+
+		pfm_ctxswout_thread(task, ctx, set);
+	}
+
+	diff = now_itc - ctx->duration_start;
+	ctx->duration += diff;
+
+	/*
+	 * accumulate only when set is actively monitoring,
+	 */
+	if (ctx->state == PFM_CTX_LOADED)
+		set->duration += now_itc - set->duration_start;
+
+done:
+	spin_unlock(&ctx->lock);
+}
