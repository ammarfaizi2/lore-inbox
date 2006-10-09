Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932905AbWJIOLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932905AbWJIOLZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 10:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932900AbWJIOLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 10:11:23 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:59391 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S932879AbWJIOLT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 10:11:19 -0400
Date: Mon, 9 Oct 2006 07:10:13 -0700
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200610091410.k99EAD05026077@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 06/21] 2.6.18 perfmon2 : PMU interruption support
Cc: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@frankl.hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the PMU interruption support.


Perfmon2 registers a interrupt handler for the PMU is order:
	- to support 64-bit counter emulation
	- to support event-based sampling

Typically the PMU interrupt vector is very high priority to ensure
better coverage when sampling.

On PMU interrupt the handler, pfm_overflow_handler(), is invoked and:
	- check which counter overflowed
	- increment 64-bit software counter accordingly.
	- if there the software 64-bit counter overflowed, then a counter overflow
	  is declared, otherwise execution resumes
	- on counter overflow, check if there is a samplinf format used and if so
	  call its handler routine
	- if notification uis requested, then a message is appedend to the context message
	  queue, any potential waiter is woken up
	- switches to a new event set if this is a requested by user (i.e., switch on overflow)

--- linux-2.6.18.base/perfmon/perfmon_intr.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.18/perfmon/perfmon_intr.c	2006-09-25 12:09:55.000000000 -0700
@@ -0,0 +1,523 @@
+/*
+ * perfmon_intr.c: perfmon2 interrupt handling
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
+  */
+#include <linux/kernel.h>
+#include <linux/perfmon.h>
+
+/*
+ * main overflow processing routine.
+ *
+ * set->num_ovfl_pmds is 0 when returning from this function even though
+ * set->ovfl_pmds[] may have bits set. When leaving set->num_ovfl_pmds
+ * must never be used to determine if there was a pending overflow.
+ */
+static void pfm_overflow_handler(struct pfm_context *ctx, struct pfm_event_set *set,
+				 unsigned long ip,
+				 struct pt_regs *regs)
+{
+	struct pfm_ovfl_arg *ovfl_arg;
+	struct pfm_event_set *set_orig;
+	void *hdr;
+	u64 old_val, ovfl_mask, new_val, ovfl_thres;
+	u64 *ovfl_notify, *ovfl_pmds, *pend_ovfls;
+	u64 *smpl_pmds, *reset_pmds;
+	u64 now, *pmds, time_phase;
+	u32 ovfl_ctrl, num_ovfl, num_ovfl_orig;
+	u16 i, max_pmd, max_cnt_pmd, first_cnt_pmd;
+	u8 use_ovfl_switch, must_switch, has_64b_ovfl;
+	u8 ctx_block, has_notify;
+
+	now = sched_clock();
+	ovfl_mask = pfm_pmu_conf->ovfl_mask;
+	max_pmd = pfm_pmu_conf->max_pmd;
+	first_cnt_pmd = pfm_pmu_conf->first_cnt_pmd;
+	max_cnt_pmd = pfm_pmu_conf->max_cnt_pmd;
+	ovfl_pmds = set->ovfl_pmds;
+	set_orig = set;
+
+	if (unlikely(ctx->state == PFM_CTX_ZOMBIE))
+		goto stop_monitoring;
+
+	/*
+	 * initialized in caller function
+	 */
+	use_ovfl_switch = set->flags & PFM_SETFL_OVFL_SWITCH;
+	must_switch = 0;
+	num_ovfl = num_ovfl_orig = set->npend_ovfls;
+	has_64b_ovfl = 0;
+	pend_ovfls = set->povfl_pmds;
+
+	hdr = ctx->smpl_addr;
+
+	PFM_DBG_ovfl("ovfl_pmds=0x%llx ip=%p, blocking=%d "
+		     "u_pmds=0x%llx use_fmt=%u",
+		     (unsigned long long)pend_ovfls[0],
+		     (void *)ip,
+		     ctx->flags.block,
+		     (unsigned long long)set->used_pmds[0],
+		     hdr != NULL);
+
+	/*
+	 * initialize temporary bitvectors
+	 * we allocate bitvectors in the context
+	 * rather than on the stack to minimize stack
+	 * space consumption. PMU interrupt is very high
+	 * which implies possible deep nesting of interrupt
+	 * hence limited kernel stack space.
+	 *
+	 * This is safe because a context can only be in the
+	 * overflow handler once at a time
+	 */
+	reset_pmds = set->reset_pmds;
+	ovfl_notify = ctx->ovfl_ovfl_notify;
+	pmds = set->view->set_pmds;
+	bitmap_zero(ulp(reset_pmds), max_pmd);
+
+	pfm_modview_begin(set);
+
+	set->last_iip = ip;
+	/*
+	 * first we update the virtual counters
+	 *
+	 * we leverage num_ovfl to minimize number of
+	 * iterations of the loop.
+	 *
+	 * The i < max_cnt_pmd is just a sanity check
+	 */
+	for (i = first_cnt_pmd; num_ovfl && i < max_cnt_pmd; i++) {
+		/*
+		 * skip pmd which did not overflow
+		 */
+		if (!pfm_bv_isset(pend_ovfls, i))
+			continue;
+
+		num_ovfl--;
+
+		/*
+		 * Note that the pmd is not necessarily 0 at this point as
+		 * qualified events may have happened before the PMU was
+		 * frozen. The residual count is not taken into consideration
+		 * here but will be with any read of the pmd
+		 */
+		old_val = new_val = pmds[i];
+		ovfl_thres = set->pmds[i].ovflsw_thres;
+		new_val += 1 + ovfl_mask;
+		pmds[i] = new_val;
+
+		/*
+		 * on some PMU, it may be necessary to re-arm the PMD
+		 */
+		pfm_arch_ovfl_reset_pmd(ctx, i);
+
+		/*
+		 * check for overflow condition
+		 */
+		if (likely(old_val > new_val)) {
+
+			if (!has_64b_ovfl) {
+				set->last_ovfl_pmd = i;
+				set->last_ovfl_pmd_reset = set->pmds[i].lval;
+			}
+
+			has_64b_ovfl = 1;
+
+			if (use_ovfl_switch && ovfl_thres > 0) {
+				if (ovfl_thres == 1)
+					must_switch = 1;
+				set->pmds[i].ovflsw_thres = ovfl_thres - 1;
+			}
+
+			/*
+			 * what to reset because of this overflow
+			 */
+			pfm_bv_set(reset_pmds, i);
+
+			bitmap_or(ulp(reset_pmds),
+				  ulp(reset_pmds),
+				  ulp(set->pmds[i].reset_pmds),
+				  max_pmd);
+
+		} else {
+			/* only keep track of 64-bit overflows */
+			pfm_bv_clear(pend_ovfls, i);
+		}
+
+		PFM_DBG_ovfl("pmd%u=0x%llx old_val=0x%llx "
+			     "hw_pmd=0x%llx o_pmds=0x%llx must_switch=%u "
+			     "o_thres=%llu o_thres_ref=%llu",
+			     i,
+			     (unsigned long long)new_val,
+			     (unsigned long long)old_val,
+			     (unsigned long long)(pfm_read_pmd(ctx, i) & ovfl_mask),
+			     (unsigned long long)ovfl_pmds[0],
+			     must_switch,
+			     (unsigned long long)set->pmds[i].ovflsw_thres,
+			     (unsigned long long)set->pmds[i].ovflsw_ref_thres);
+	}
+	pfm_modview_end(set);
+
+	time_phase = sched_clock();
+	/*
+	 * ensure we do not come back twice for the same overflow
+	 */
+	set->npend_ovfls = 0;
+
+	ctx_block = ctx->flags.block;
+
+	__get_cpu_var(pfm_stats).pfm_ovfl_intr_phase1 += time_phase - now;
+
+	/*
+	 * there was no 64-bit overflow, nothing else to do
+	 */
+	if (!has_64b_ovfl)
+		return;
+
+
+	/*
+	 * copy pending_ovfls to ovfl_pmd. It is used in
+	 * the notification message or getinfo_evtsets().
+	 *
+	 * pend_ovfls modified to reflect only 64-bit overflows
+	 */
+	bitmap_copy(ulp(ovfl_pmds),
+		    ulp(pend_ovfls),
+		    max_cnt_pmd);
+
+	/*
+	 * build ovfl_notify bitmask from ovfl_pmds
+	 */
+	bitmap_and(ulp(ovfl_notify),
+		   ulp(pend_ovfls),
+		   ulp(set->ovfl_notify),
+		   max_cnt_pmd);
+
+	has_notify = !bitmap_empty(ulp(ovfl_notify), max_cnt_pmd);
+	/*
+	 * must reset for next set of overflows
+	 */
+	bitmap_zero(ulp(pend_ovfls), max_cnt_pmd);
+
+	/*
+	 * check for format
+	 */
+	if (likely(ctx->smpl_fmt)) {
+		u64 start_cycles, end_cycles;
+		u64 *cnt_pmds;
+		int j, k, ret = 0;
+
+		ovfl_ctrl = 0;
+		num_ovfl = num_ovfl_orig;
+		ovfl_arg = &ctx->ovfl_arg;
+		cnt_pmds = pfm_pmu_conf->cnt_pmds;
+
+		ovfl_arg->active_set = set->id;
+
+		for (i = first_cnt_pmd; num_ovfl && !ret; i++) {
+
+			if (!pfm_bv_isset(ovfl_pmds, i))
+				continue;
+
+			num_ovfl--;
+
+			ovfl_arg->ovfl_pmd = i;
+			ovfl_arg->ovfl_ctrl = 0;
+
+			ovfl_arg->pmd_last_reset = set->pmds[i].lval;
+			ovfl_arg->pmd_eventid = set->pmds[i].eventid;
+
+			/*
+		 	 * copy values of pmds of interest.
+			 * Sampling format may use them
+			 * We do not initialize the unused smpl_pmds_values
+		 	 */
+			k = 0;
+			smpl_pmds = set->pmds[i].smpl_pmds;
+			if (!bitmap_empty(ulp(smpl_pmds), max_pmd)) {
+
+				for (j = 0; j < max_pmd; j++) {
+
+					if (!pfm_bv_isset(smpl_pmds, j))
+						continue;
+
+					new_val = pfm_read_pmd(ctx, j);
+
+					/* for counters, build 64-bit value */
+					if (pfm_bv_isset(cnt_pmds, j)) {
+						new_val = (set->view->set_pmds[j] & ~ovfl_mask)
+							| (new_val & ovfl_mask);
+					}
+					ovfl_arg->smpl_pmds_values[k++] = new_val;
+
+					PFM_DBG_ovfl("s_pmd_val[%u]="
+						     "pmd%u=0x%llx",
+						     k, j,
+						     (unsigned long long)new_val);
+				}
+			}
+			ovfl_arg->num_smpl_pmds = k;
+
+			__get_cpu_var(pfm_stats).pfm_fmt_handler_calls++;
+
+			start_cycles = sched_clock();
+
+			/*
+		 	 * call custom buffer format record (handler) routine
+		 	 */
+			ret = (*ctx->smpl_fmt->fmt_handler)(hdr,
+							    ovfl_arg,
+							    ip,
+							    now,
+							    regs);
+
+			end_cycles = sched_clock();
+
+			/*
+			 * for PFM_OVFL_CTRL_MASK and PFM_OVFL_CTRL_NOTIFY
+			 * we take the union
+			 *
+			 * PFM_OVFL_CTRL_RESET is ignored here
+			 *
+			 * The reset_pmds mask is constructed automatically
+			 * on overflow. When the actual reset takes place
+			 * depends on the masking, switch and notification
+			 * status. It may may deferred until pfm_restart().
+			 */
+			ovfl_ctrl |= ovfl_arg->ovfl_ctrl
+				   & (PFM_OVFL_CTRL_NOTIFY|PFM_OVFL_CTRL_MASK);
+
+			__get_cpu_var(pfm_stats).pfm_fmt_handler_ns += end_cycles
+							 	     - start_cycles;
+		}
+		/*
+		 * when the format cannot handle the rest of the overflow,
+		 * we abort right here
+		 */
+		if (ret) {
+			PFM_DBG_ovfl("handler aborted at PMD%u ret=%d",
+				     i, ret);
+		}
+	} else {
+		/*
+		 * When no sampling format is used, the default
+		 * is:
+		 * 	- mask monitoring
+		 * 	- notify user if requested
+		 *
+		 * If notification is not requested, monitoring is masked
+		 * and overflowed counters are not reset (saturation).
+		 * This mimics the behavior of the default sampling format.
+		 */
+		ovfl_ctrl = PFM_OVFL_CTRL_NOTIFY;
+
+		if (!must_switch || has_notify)
+			ovfl_ctrl |= PFM_OVFL_CTRL_MASK;
+	}
+	__get_cpu_var(pfm_stats).pfm_ovfl_intr_phase2 += sched_clock() - now;
+
+	PFM_DBG_ovfl("set%u o_notify=0x%llx o_pmds=0x%llx "
+		     "r_pmds=0x%llx masking=%d notify=%d",
+		     set->id,
+		     (unsigned long long)ovfl_notify[0],
+		     (unsigned long long)ovfl_pmds[0],
+		     (unsigned long long)reset_pmds[0],
+		     (ovfl_ctrl & PFM_OVFL_CTRL_MASK)  != 0,
+		     (ovfl_ctrl & PFM_OVFL_CTRL_NOTIFY)!= 0);
+
+	/*
+	 * we only reset (short reset) when we are not masking. Otherwise
+	 * the reset is postponed until restart.
+	 */
+	if (likely(!(ovfl_ctrl & PFM_OVFL_CTRL_MASK))) {
+		/*
+		 * masking has priority over switching
+	 	 */
+		if (must_switch) {
+			/*
+			 * pfm_switch_sets() takes care
+			 * of resetting new set if needed
+			 */
+			pfm_switch_sets(ctx, NULL, PFM_PMD_RESET_SHORT, 0);
+
+			/*
+		 	 * update our view of the active set
+		 	 */
+			set = ctx->active_set;
+
+			must_switch = 0;
+		} else if (!bitmap_empty(ulp(reset_pmds), max_pmd))
+			pfm_reset_pmds(ctx, set, PFM_PMD_RESET_SHORT);
+		/*
+		 * do not block if not masked
+		 */
+		ctx_block = 0;
+	} else {
+		pfm_mask_monitoring(ctx);
+		ctx->state = PFM_CTX_MASKED;
+		ctx->flags.can_restart = 1;
+	}
+	/*
+	 * if we have not switched here, then remember for the
+	 * time monitoring is resumed
+	 */
+	if (must_switch)
+		set->priv_flags |= PFM_SETFL_PRIV_SWITCH;
+
+	/*
+	 * block only if CTRL_NOTIFY+CTRL_MASK and requested by user
+	 *
+	 * Defer notification until last operation in the handler
+	 * to avoid spinlock contention
+	 */
+	if (has_notify && (ovfl_ctrl & PFM_OVFL_CTRL_NOTIFY)) {
+		if (ctx_block) {
+			ctx->flags.work_type = PFM_WORK_BLOCK;
+			set_thread_flag(TIF_PERFMON_WORK);
+		}
+		pfm_ovfl_notify_user(ctx, set_orig, ip);
+	}
+
+	__get_cpu_var(pfm_stats).pfm_ovfl_intr_phase3 += sched_clock() - now;
+
+	return;
+
+stop_monitoring:
+	/*
+	 * Does not happen for a system-wide context nor for a
+	 * self-monitored context. We cannot attach to kernel-only
+	 * thread, thus it is safe to set TIF bits, i.e., the thread
+	 * will eventually leave the kernel or die and either we will
+	 * catch the context and clean it up in pfm_handler_work() or
+	 * pfm_exit_thread().
+	 */
+	PFM_DBG_ovfl("ctx is zombie, converted to spurious");
+
+	__pfm_stop(ctx);
+	ctx->flags.work_type = PFM_WORK_ZOMBIE;
+	set_thread_flag(TIF_PERFMON_WORK);
+}
+/*
+ * interrupts are masked
+ *
+ * Context locking necessary to avoid concurrent accesses from other CPUs
+ * 	- For per-thread, we must prevent pfm_restart() which works when
+ * 	  context is LOADED or MASKED
+ */
+static void __pfm_interrupt_handler(unsigned long iip, struct pt_regs *regs)
+{
+	struct task_struct *task;
+	struct pfm_context *ctx;
+	struct pfm_event_set *set;
+
+	__get_cpu_var(pfm_stats).pfm_ovfl_intr_all_count++;
+
+	task = __get_cpu_var(pmu_owner);
+	ctx = __get_cpu_var(pmu_ctx);
+
+	if (unlikely(ctx == NULL))
+		goto spurious;
+
+	spin_lock(&ctx->lock);
+
+	set = ctx->active_set;
+
+	/*
+	 * For SMP per-thread, it is not possible to have
+	 * owner != NULL && task != current.
+	 *
+	 * For UP per-thread, because of lazy save, it
+	 * is possible to receive an interrupt in another task
+	 * which is not using the PMU. This means
+	 * that the interrupt was in-flight at the
+	 * time of pfm_ctxswout_thread(). In that
+	 * case it will be replayed when the task
+	 * is scheduled again. Hence we convert to spurious.
+	 *
+	 * The basic rule is that an overflow is always
+	 * processed in the context of the task that
+	 * generated it for all per-thread contexts.
+	 *
+	 * for system-wide, task is always NULL
+	 */
+	if (unlikely(task && current->pfm_context != ctx)) {
+		PFM_DBG_ovfl("spurious: task is [%d]", task->pid);
+		goto spurious;
+	}
+
+	/*
+	 * freeze PMU and collect overflowed PMD registers
+	 * into set->povfl_pmds. Number of overflowed PMDs reported
+	 * in set->npend_ovfls
+	 */
+	pfm_arch_intr_freeze_pmu(ctx);
+
+	/*
+	 * check if we already have some overflows pending
+	 * from pfm_ctxswout_thread(). If so process those.
+	 * Otherwise, inspect PMU again to check for new
+	 * overflows.
+	 */
+	if (unlikely(!set->npend_ovfls))
+		goto spurious;
+
+	__get_cpu_var(pfm_stats).pfm_ovfl_intr_regular_count++;
+
+	pfm_overflow_handler(ctx, set, iip, regs);
+
+	pfm_arch_intr_unfreeze_pmu(ctx);
+
+	spin_unlock(&ctx->lock);
+	return;
+
+spurious:
+	/* ctx may be NULL */
+	pfm_arch_intr_unfreeze_pmu(ctx);
+	if (ctx)
+		spin_unlock(&ctx->lock);
+}
+
+void pfm_interrupt_handler(unsigned long iip, struct pt_regs *regs)
+{
+	u64 start;
+
+	BUG_ON(!irqs_disabled());
+
+	start = sched_clock();
+
+	__pfm_interrupt_handler(iip, regs);
+
+	__get_cpu_var(pfm_stats).pfm_ovfl_intr_ns += sched_clock() - start;
+}
