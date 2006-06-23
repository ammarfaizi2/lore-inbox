Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932961AbWFWJYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932961AbWFWJYI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 05:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbWFWJVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 05:21:41 -0400
Received: from ccerelbas02.cce.hp.com ([161.114.21.105]:21485 "EHLO
	ccerelbas02.cce.hp.com") by vger.kernel.org with ESMTP
	id S1751266AbWFWJVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 05:21:04 -0400
Date: Fri, 23 Jun 2006 02:13:08 -0700
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200606230913.k5N9D8cN032399@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 11/17] 2.6.17.1 perfmon2 patch for review: new generic files
Cc: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the new generic files




--- linux-2.6.17.1.orig/lib/carta_random32.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17.1/lib/carta_random32.c	2006-06-21 04:22:51.000000000 -0700
@@ -0,0 +1,29 @@
+/*
+ * Fast, simple, yet decent quality random number generator based on
+ * a paper by David G. Carta ("Two Fast Implementations of the
+ * `Minimal Standard' Random Number Generator," Communications of the
+ * ACM, January, 1990).
+ *
+ * Copyright (c) 2002-2005 Hewlett-Packard Development Company, L.P.
+ *	Contributed by David Mosberger-Tang <davidm@hpl.hp.com>
+ */
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/perfmon.h>
+
+#ifndef __HAVE_ARCH_CARTA_RANDOM32
+u64 carta_random32 (u64 seed)
+{
+#       define A 16807
+#       define M ((u32) 1 << 31)
+        u64 s, prod = A * seed, p, q;
+
+        p = (prod >> 31) & (M - 1);
+        q = (prod >>  0) & (M - 1);
+        s = p + q;
+        if (s >= M)
+                s -= M - 1;
+        return s;
+}
+EXPORT_SYMBOL(carta_random32);
+#endif
--- linux-2.6.17.1.orig/perfmon/Makefile	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17.1/perfmon/Makefile	2006-06-21 04:22:51.000000000 -0700
@@ -0,0 +1,7 @@
+#
+# Copyright (c) 2005-2006 Hewlett-Packard Development Company, L.P.
+# Contributed by Stephane Eranian <eranian@hpl.hp.com>
+#
+obj-$(CONFIG_PERFMON) = perfmon.o perfmon_res.o perfmon_fmt.o perfmon_pmu.o \
+   perfmon_sysfs.o perfmon_syscalls.o perfmon_file.o perfmon_ctxsw.o \
+   perfmon_intr.o perfmon_dfl_smpl.o perfmon_kapi.o perfmon_sets.o
--- linux-2.6.17.1.orig/perfmon/perfmon.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17.1/perfmon/perfmon.c	2006-06-21 04:22:51.000000000 -0700
@@ -0,0 +1,2571 @@
+/*
+ * perfmon.c: perfmon2 core functions
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
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/vmalloc.h>
+#include <linux/sysctl.h>
+#include <linux/file.h>
+#include <linux/poll.h>
+#include <linux/vfs.h>
+#include <linux/pagemap.h>
+#include <linux/mount.h>
+#include <linux/perfmon.h>
+
+/*
+ * internal variables
+ */
+static kmem_cache_t		*pfm_ctx_cachep;
+
+
+/*
+ * external variables
+ */
+
+DEFINE_PER_CPU(unsigned long, pfm_syst_info);
+DEFINE_PER_CPU(struct task_struct *, pmu_owner);
+DEFINE_PER_CPU(struct pfm_context  *, pmu_ctx);
+DEFINE_PER_CPU(u64, pmu_activation_number);
+DEFINE_PER_CPU(struct pfm_stats, pfm_stats);
+
+#define PFM_INVALID_ACTIVATION	((u64)~0)
+
+/*
+ * Reset PMD register flags
+ */
+#define PFM_PMD_RESET_NONE	0	/* do not reset (pfm_switch_set) */
+#define PFM_PMD_RESET_SHORT	1	/* use short reset value */
+#define PFM_PMD_RESET_LONG	2	/* use long reset value  */
+
+/* forward declaration */
+static int pfm_end_notify_user(struct pfm_context *ctx);
+int pfm_ovfl_notify_user(struct pfm_context *ctx,
+			 struct pfm_event_set *set,
+			 unsigned long ip);
+
+
+static union pfm_msg *pfm_get_new_msg(struct pfm_context *ctx)
+{
+	int idx, next;
+
+	next = (ctx->msgq_tail+1) % PFM_MAX_MSGS;
+
+	PFM_DBG("head=%d tail=%d", ctx->msgq_head, ctx->msgq_tail);
+
+	if (next == ctx->msgq_head)
+		return NULL;
+
+	idx = ctx->msgq_tail;
+	ctx->msgq_tail = next;
+
+	PFM_DBG("head=%d tail=%d msg=%d",
+		ctx->msgq_head,
+		ctx->msgq_tail, idx);
+
+	return ctx->msgq+idx;
+}
+
+static inline void pfm_reset_msgq(struct pfm_context *ctx)
+{
+	ctx->msgq_head = ctx->msgq_tail = 0;
+}
+
+void pfm_context_free(struct pfm_context *ctx)
+{
+	struct pfm_smpl_fmt *fmt;
+
+	fmt = ctx->smpl_fmt;
+
+	pfm_free_sets(ctx);
+
+	if (ctx->smpl_addr) {
+		PFM_DBG("freeing sampling buffer @%p size=%zu",
+			ctx->smpl_addr,
+			ctx->smpl_size);
+
+		if (ctx->flags.kapi == 0)
+			pfm_release_buf_space(ctx->smpl_size);
+
+		if (fmt->fmt_exit)
+			(*fmt->fmt_exit)(ctx->smpl_addr);
+
+		vfree(ctx->smpl_addr);
+	}
+
+	PFM_DBG("free ctx @%p", ctx);
+	kmem_cache_free(pfm_ctx_cachep, ctx);
+
+	/*
+	 * decrease refcount on:
+	 * 	- PMU description table
+	 * 	- sampling format
+	 */
+	pfm_pmu_conf_put();
+	pfm_smpl_fmt_put(fmt);
+}
+
+/*
+ * only called in for the current task
+ */
+static int pfm_setup_smpl_fmt(struct pfm_smpl_fmt *fmt, void *fmt_arg,
+				struct pfm_context *ctx, u32 ctx_flags,
+				int mode, struct file *filp)
+{
+	size_t size = 0;
+	int ret = 0;
+
+	/*
+	 * validate parameters
+	 */
+	if (fmt->fmt_validate) {
+		ret = (*fmt->fmt_validate)(ctx_flags, pfm_pmu_conf->num_pmds,
+					   fmt_arg);
+		PFM_DBG("validate(0x%x,%p)=%d", ctx_flags, fmt_arg, ret);
+		if (ret)
+			goto error;
+	}
+
+	/*
+	 * check if buffer format wants to use perfmon
+	 * buffer allocation/mapping service
+	 */
+	size = 0;
+	if (fmt->fmt_getsize) {
+		ret = (*fmt->fmt_getsize)(ctx_flags, fmt_arg, &size);
+		if (ret) {
+			PFM_DBG("cannot get size ret=%d", ret);
+			goto error;
+		}
+	}
+
+	if (size) {
+#ifdef CONFIG_IA64_PERFMON_COMPAT
+		if (mode == PFM_COMPAT)
+			ret = pfm_smpl_buffer_alloc_old(ctx, size, filp);
+		else
+#endif
+		{
+			ret = pfm_smpl_buffer_alloc(ctx, size);
+		}
+		if (ret)
+			goto error;
+
+	}
+
+	if (fmt->fmt_init) {
+		ret = (*fmt->fmt_init)(ctx, ctx->smpl_addr, ctx_flags,
+				       pfm_pmu_conf->num_pmds,
+				       fmt_arg);
+		if (ret)
+			goto error_buffer;
+	}
+	return 0;
+
+error_buffer:
+	if (ctx->flags.kapi == 0)
+		pfm_release_buf_space(ctx->smpl_size);
+	/*
+	 * we do not call fmt_exit, if init has failed
+	 */
+	vfree(ctx->smpl_addr);
+error:
+	return ret;
+}
+
+void pfm_mask_monitoring(struct pfm_context *ctx)
+{
+	struct pfm_event_set *set;
+	u64 now_itc;
+	int is_system;
+
+	PFM_DBG_ovfl("masking monitoring");
+
+	now_itc = pfm_arch_get_itc();
+	is_system = ctx->flags.system;
+	set = ctx->active_set;
+
+	/*
+	 * monitoring can only be masked as a result of a valid
+	 * counter overflow. In UP and per-thread mode,
+	 * it is possible that the current task may not be the
+	 * one that generated the overflow because the overflow happen
+	 * very close to the context switch point where interrupts are
+	 * masked.  In SMP per-thread, current is always the task that
+	 * generated the overflow.
+	 *
+	 * For system-wide, the current task is alwys the one that
+	 * generated the overflow.
+	 *
+	 * In any case, accessing the PMU directly is always safe
+	 * given that we are only called from the overflow handler.
+	 */
+	pfm_modview_begin(set);
+	pfm_arch_save_pmds(ctx, set);
+	pfm_modview_end(set);
+	pfm_arch_mask_monitoring(ctx);
+
+	/*
+	 * accumulate the set duration up to this point
+	 */
+	set->duration += now_itc - set->duration_start;
+}
+
+/*
+ * interrupts are masked when entering this function.
+ * context must be in MASKED state when calling.
+ */
+static void pfm_unmask_monitoring(struct pfm_context *ctx)
+{
+	struct pfm_event_set *set;
+	u64 now_itc;
+
+	if (ctx->state != PFM_CTX_MASKED)
+		return;
+
+	PFM_DBG("unmasking monitoring");
+
+	set = ctx->active_set;
+
+	/*
+	 * must be done before calling
+	 * pfm_arch_unmask_monitoring()
+	 */
+	ctx->state = PFM_CTX_LOADED;
+
+	pfm_arch_restore_pmds(ctx, set);
+
+	pfm_arch_unmask_monitoring(ctx);
+
+	now_itc = pfm_arch_get_itc();
+
+	set->priv_flags &= ~PFM_SETFL_PRIV_MOD_BOTH;
+
+	/*
+	 * reset set duration timer
+	 */
+	set->duration_start = now_itc;
+}
+
+#ifdef CONFIG_SMP
+/*
+ * this function is exclusively called from pfm_close().
+ * The context is not protected at that time, nor are interrupts
+ * on the remote CPU. That's necessary to avoid deadlocks.
+ */
+static void pfm_syswide_force_stop(void *info)
+{
+	struct pfm_context   *ctx = info;
+	unsigned long flags;
+	int ret;
+
+	/* On some platforms smp_call_function_single() is not
+	 * implemented and we use a broadcast IPI instead. In
+	 * this case, we need ignore the call on all but the
+	 * actual target as indicated by cpu.
+	 */
+	if (ctx->cpu != smp_processor_id()) {
+		PFM_ERR("%s for CPU%u but on CPU%d",
+			__FUNCTION__,
+			ctx->cpu,
+			smp_processor_id());
+		return;
+	}
+
+	if (__get_cpu_var(pmu_ctx) != ctx) {
+		PFM_ERR("%s CPU%d unexpected ctx %p instead of %p",
+			__FUNCTION__,
+			smp_processor_id(),
+			__get_cpu_var(pmu_ctx), ctx);
+		return;
+	}
+
+	/*
+	 * the context is already protected in pfm_close(), we simply
+	 * need to mask interrupts to avoid a PMU interrupt race on
+	 * this CPU
+	 */
+	local_irq_save(flags);
+
+	/*
+	 * defer calling pfm_release_session() to avoid possible
+	 * deadlock caused by nesting of smp_call()
+	 */
+	ret = __pfm_unload_context(ctx, 1);
+	if (ret) {
+		PFM_ERR("%s: context_unload returned %d",
+			__FUNCTION__, ret);
+	}
+
+	/*
+	 * unmask interrupts, PMU interrupts are now spurious here
+	 */
+	local_irq_restore(flags);
+}
+
+void pfm_syswide_cleanup_other_cpu(struct pfm_context *ctx)
+{
+	int ret = 0;
+	int ctx_cpu;
+
+	/*
+	 * grab a cpu, it is detroyed by __pfm_unload_context()
+	 */
+	ctx_cpu = ctx->cpu;
+
+	ret = smp_call_function_single(ctx_cpu, pfm_syswide_force_stop,
+				       ctx, 0, 1);
+
+	/*
+	 * we defer releasing the session until we are back from the
+	 * remote cleanup routine because there may be situations where
+	 * the release_session() may need to nest another smp_call()
+	 * which would lead to a deadlock.
+	 */
+	pfm_release_session(ctx, ctx_cpu);
+
+	PFM_DBG("called CPU%u for cleanup ret=%d", ctx_cpu, ret);
+}
+
+#endif /* CONFIG_SMP */
+
+struct pfm_context *pfm_context_alloc(void)
+{
+	struct pfm_context *ctx;
+
+	/*
+	 * allocate context structure
+	 * the architecture specific portion is allocated
+	 * right after the struct pfm_context struct. It is
+	 * accessible at ctx_arch = (ctx+1)
+	 */
+	ctx = kmem_cache_alloc(pfm_ctx_cachep, SLAB_ATOMIC);
+	if (ctx) {
+		memset(ctx, 0, sizeof(*ctx)+PFM_ARCH_CTX_SIZE);
+		PFM_DBG("alloc ctx @%p", ctx);
+	}
+	return ctx;
+}
+
+/*
+ * in new mode, we only allocate the kernel buffer, an explicit mmap()
+ * is needed to remap the buffer at the user level
+ */
+int pfm_smpl_buffer_alloc(struct pfm_context *ctx, size_t rsize)
+{
+	void *addr;
+	size_t size;
+	int ret;
+
+	/*
+	 * the fixed header + requested size and align to page boundary
+	 */
+	size = PAGE_ALIGN(rsize);
+
+	PFM_DBG("sampling buffer rsize=%zu size=%zu", rsize, size);
+
+	if (ctx->flags.kapi == 0) {
+		ret = pfm_reserve_buf_space(size);
+		if (ret) return ret;
+	}
+
+	addr = vmalloc(size);
+	if (addr == NULL) {
+		PFM_DBG("cannot allocate sampling buffer");
+		goto unres;
+	}
+
+	memset(addr, 0, size);
+
+	//pfm_get_map(addr, size);
+
+	ctx->smpl_addr = addr;
+	ctx->smpl_size = size;
+
+	PFM_DBG("kernel smpl buffer @%p", addr);
+
+	return 0;
+unres:
+	if (ctx->flags.kapi == 0)
+		pfm_release_buf_space(size);
+	return -ENOMEM;
+}
+
+static inline u64 pfm_new_pmd_value (struct pfm_pmd *reg, int reset_mode)
+{
+	u64 val, mask;
+	u64 new_seed, old_seed;
+
+	val = reset_mode == PFM_PMD_RESET_LONG ? reg->long_reset : reg->short_reset;
+	old_seed = reg->seed;
+	mask = reg->mask;
+
+	if (reg->flags & PFM_REGFL_RANDOM) {
+		new_seed = carta_random32(old_seed);
+
+		/* counter values are negative numbers! */
+		val -= (old_seed & mask);
+		if ((mask >> 32) != 0)
+			/* construct a full 64-bit random value: */
+			new_seed |= (u64)carta_random32((u32)(old_seed >> 32)) << 32;
+		reg->seed = new_seed;
+	}
+	reg->lval = val;
+	return val;
+}
+
+void pfm_reset_pmds(struct pfm_context *ctx, struct pfm_event_set *set,
+		    int reset_mode)
+{
+	u64 ovfl_mask, hw_val;
+	u64 *cnt_mask, *reset_pmds;
+	u64 val;
+	unsigned int i, max_pmd, not_masked;
+
+	reset_pmds = set->reset_pmds;
+	max_pmd	= pfm_pmu_conf->max_pmd;
+
+	if (bitmap_empty(ulp(reset_pmds), max_pmd)) return;
+
+	ovfl_mask = pfm_pmu_conf->ovfl_mask;
+	cnt_mask = pfm_pmu_conf->cnt_pmds;
+	not_masked = ctx->state != PFM_CTX_MASKED;
+
+	PFM_DBG_ovfl("%s r_pmds=0x%llx not_masked=%d",
+		     reset_mode == PFM_PMD_RESET_LONG ? "long" : "short",
+		     (unsigned long long)reset_pmds[0],
+		     not_masked);
+
+	pfm_modview_begin(set);
+
+	for (i = 0; i < max_pmd; i++) {
+
+		if (pfm_bv_isset(reset_pmds, i)) {
+
+			val = pfm_new_pmd_value(set->pmds + i,
+						reset_mode);
+
+			set->view->set_pmds[i]= val;
+
+			if (not_masked) {
+				if (pfm_bv_isset(cnt_mask, i)) {
+					hw_val = val & ovfl_mask;
+				} else {
+					hw_val = val;
+				}
+				pfm_write_pmd(ctx, i, hw_val);
+			}
+			PFM_DBG_ovfl("pmd%u set=%u sval=0x%llx",
+				     i,
+				     set->id,
+				     (unsigned long long)val);
+		}
+	}
+
+	pfm_modview_end(set);
+
+	/*
+	 * done with reset
+	 */
+	bitmap_zero(ulp(reset_pmds), max_pmd);
+
+	/*
+	 * make changes visible
+	 */
+	if (not_masked)
+		pfm_arch_serialize();
+}
+
+
+
+
+/*
+ * called from pfm_handle_work() and __pfm_restart()
+ * for system-wide and per-thread context.
+ */
+void pfm_resume_after_ovfl(struct pfm_context *ctx)
+{
+	struct pfm_smpl_fmt *fmt;
+	u32 rst_ctrl;
+	struct pfm_event_set *set;
+	u64 *reset_pmds;
+	void *hdr;
+	int max_cnt_pmd;
+	int state, ret;
+
+	hdr = ctx->smpl_addr;
+	fmt = ctx->smpl_fmt;
+	state = ctx->state;
+	set = ctx->active_set;
+	ret = 0;
+
+	max_cnt_pmd = pfm_pmu_conf->max_cnt_pmd;
+
+	if (hdr) {
+		rst_ctrl = 0;
+		prefetch(hdr);
+		if (fmt->fmt_restart)
+			ret = (*fmt->fmt_restart)(state == PFM_CTX_LOADED,
+					  	  &rst_ctrl, hdr);
+	} else {
+		rst_ctrl= PFM_OVFL_CTRL_RESET;
+	}
+	reset_pmds = set->reset_pmds;
+
+	PFM_DBG("restart=%d r_pmds=0x%llx switch=%d ctx_state=%d",
+		ret,
+		(unsigned long long)reset_pmds[0],
+		(set->priv_flags & PFM_SETFL_PRIV_SWITCH) != 0,
+		state);
+
+	if (ret == 0) {
+		/*
+		 * switch set if needed
+		 */
+		if (set->priv_flags & PFM_SETFL_PRIV_SWITCH) {
+			set->priv_flags &= ~PFM_SETFL_PRIV_SWITCH;
+			pfm_switch_sets(ctx, NULL, PFM_PMD_RESET_LONG, 0);
+			set = ctx->active_set;
+		} else if (rst_ctrl & PFM_OVFL_CTRL_RESET) {
+			pfm_reset_pmds(ctx, set, PFM_PMD_RESET_LONG);
+		}
+
+		if ((rst_ctrl & PFM_OVFL_CTRL_MASK) == 0) {
+			pfm_unmask_monitoring(ctx);
+		} else {
+			PFM_DBG("stopping monitoring?");
+		}
+		ctx->state = PFM_CTX_LOADED;
+	}
+	ctx->flags.can_restart = 0;
+}
+
+/*
+ * save all used pmds and release PMU ownership
+ *
+ * context is locked (not needed in UP) and interrupts
+ * are masked
+ *
+ * owner task is not necessarily current task in UP
+ */
+void pfm_save_pmds_release(struct pfm_context *ctx)
+{
+	struct pfm_event_set *set;
+
+	set = ctx->active_set;
+
+	pfm_modview_begin(set);
+	pfm_arch_save_pmds(ctx, set);
+	pfm_modview_end(set);
+
+	pfm_set_pmu_owner(NULL, NULL);
+	PFM_DBG("released ownership");
+}
+
+/*
+ * This function is always called after pfm_stop has been issued
+ */
+void pfm_flush_pmds(struct task_struct *task, struct pfm_context *ctx)
+{
+	struct pfm_event_set *set;
+	u64 ovfl_mask;
+	u64 *ovfl_pmds;
+	u32 num_ovfls;
+	u16 i, max_cnt_pmd, first_cnt_pmd;
+
+	ovfl_mask = pfm_pmu_conf->ovfl_mask;
+	first_cnt_pmd = pfm_pmu_conf->first_cnt_pmd;
+	max_cnt_pmd = pfm_pmu_conf->max_cnt_pmd;
+
+	set = ctx->active_set;
+
+	/*
+	 * for system-wide, guaranteed to run on correct CPU
+	 */
+	if ((__get_cpu_var(pmu_owner) == task) || ctx->flags.system) {
+		/*
+		 * pending overflows have been saved by pfm_stop()
+		 */
+		pfm_save_pmds_release(ctx);
+	}
+
+	PFM_DBG("active_set=%u", set->id);
+
+	/*
+	 * cleanup each set
+	 */
+	list_for_each_entry(set, &ctx->list, list) {
+		/*
+		 * only look at sets with pending overflows
+		 */
+		if (set->npend_ovfls == 0) continue;
+
+		pfm_modview_begin(set);
+
+		/*
+		 * take care of overflow
+		 * no format handler is called here
+		 */
+		ovfl_pmds = set->povfl_pmds;
+		num_ovfls = set->npend_ovfls;
+
+		PFM_DBG("set%u first=%u novfls=%u",
+			set->id, first_cnt_pmd, num_ovfls);
+		/*
+		 * only look up to the last counting PMD register
+		 */
+		for (i = first_cnt_pmd; num_ovfls; i++) {
+
+			if (pfm_bv_isset(set->used_pmds, i)) {
+
+				if (pfm_bv_isset(ovfl_pmds, i)) {
+					set->view->set_pmds[i] += 1 + ovfl_mask;
+					num_ovfls--;
+					PFM_DBG("pmd%u overflowed", i);
+				}
+
+				PFM_DBG("pmd%u set=%u val=0x%llx",
+					i,
+					set->id,
+					(unsigned long long)set->view->set_pmds[i]);
+			}
+		}
+		pfm_modview_end(set);
+	}
+}
+
+/*
+ * called only from exit_thread(): task == current
+ * we come here only if current has a context
+ * attached (loaded or masked or zombie)
+ */
+void __pfm_exit_thread(struct task_struct *task)
+{
+	struct pfm_context *ctx;
+	unsigned long flags;
+	int free_ok = 0;
+
+	ctx  = task->pfm_context;
+
+	BUG_ON(ctx->flags.system);
+
+	spin_lock_irqsave(&ctx->lock, flags);
+
+	PFM_DBG("state=%d", ctx->state);
+
+	/*
+	 * __pfm_unload_context() cannot fail
+	 * in the context states we are interested in
+	 */
+	switch(ctx->state) {
+		case PFM_CTX_LOADED:
+		case PFM_CTX_MASKED:
+			__pfm_unload_context(ctx, 0);
+			pfm_end_notify_user(ctx);
+			break;
+		case PFM_CTX_ZOMBIE:
+			__pfm_unload_context(ctx, 0);
+			free_ok = 1;
+			break;
+		default:
+			BUG_ON(ctx->state != PFM_CTX_LOADED);
+			break;
+	}
+	spin_unlock_irqrestore(&ctx->lock, flags);
+
+	/*
+	 * All memory free operations (especially for vmalloc'ed memory)
+	 * MUST be done with interrupts ENABLED.
+	 */
+	if (free_ok)
+		pfm_context_free(ctx);
+}
+
+struct pfm_context * pfm_get_ctx(int fd)
+{
+	struct file *filp;
+	struct pfm_context *ctx;
+
+	filp = fget(fd);
+	if (unlikely(filp == NULL)) {
+		PFM_DBG("invalid fd %d", fd);
+		return NULL;
+	}
+
+	if (unlikely(pfm_is_fd(filp) == 0)) {
+		PFM_DBG("fd %d not related to perfmon", fd);
+		fput(filp);
+		return NULL;
+	}
+	ctx = filp->private_data;
+
+	/*
+	 * sanity check
+	 */
+	if (filp != ctx->filp && ctx->filp) {
+		PFM_DBG("filp is different");
+	}
+
+	/*
+	 * update filp
+	 */
+	ctx->filp = filp;
+	return ctx;
+}
+
+
+/*
+ * pfm_handle_work() can be called with interrupts enabled
+ * (TIF_NEED_RESCHED) or disabled. The down_interruptible
+ * call may sleep, therefore we must re-enable interrupts
+ * to avoid deadlocks. It is safe to do so because this function
+ * is called ONLY when returning to user level (PUStk=1), in which case
+ * there is no risk of kernel stack overflow due to deep
+ * interrupt nesting.
+ */
+void __pfm_handle_work(void)
+{
+	struct pfm_context *ctx;
+	unsigned long flags, dummy_flags;
+	unsigned int reason;
+	int ret;
+
+	ctx = current->pfm_context;
+	if (ctx == NULL) {
+		PFM_ERR("handle_work [%d] has no ctx", current->pid);
+		return;
+	}
+
+	BUG_ON(ctx->flags.system);
+
+	spin_lock_irqsave(&ctx->lock, flags);
+
+	clear_thread_flag(TIF_NOTIFY_RESUME);
+
+	/*
+	 * extract reason for being here and clear
+	 */
+	reason = ctx->flags.trap_reason;
+
+	if (reason == PFM_TRAP_REASON_NONE)
+		goto nothing_to_do;
+
+	ctx->flags.trap_reason = PFM_TRAP_REASON_NONE;
+
+	PFM_DBG("reason=%d state=%d", reason, ctx->state);
+
+	/*
+	 * must be done before we check for simple-reset mode
+	 */
+	if (ctx->state == PFM_CTX_ZOMBIE)
+		goto do_zombie;
+
+	if (reason == PFM_TRAP_REASON_RESET)
+		goto skip_blocking;
+
+	/*
+	 * restore interrupt mask to what it was on entry.
+	 * Could be enabled/diasbled.
+	 */
+	spin_unlock_irqrestore(&ctx->lock, flags);
+
+	/*
+	 * force interrupt enable because of down_interruptible()
+	 */
+	local_irq_enable();
+
+	PFM_DBG("before block sleeping");
+
+	/*
+	 * may go through without blocking on SMP systems
+	 * if restart has been received already by the time we call down()
+	 */
+	ret = wait_for_completion_interruptible(&ctx->restart_complete);
+
+	PFM_DBG("after block sleeping ret=%d", ret);
+
+	/*
+	 * lock context and mask interrupts again
+	 * We save flags into a dummy because we may have
+	 * altered interrupts mask compared to entry in this
+	 * function.
+	 */
+	spin_lock_irqsave(&ctx->lock, dummy_flags);
+
+	if (ctx->state == PFM_CTX_ZOMBIE)
+		goto do_zombie;
+
+	/*
+	 * in case of interruption of down() we don't restart anything
+	 */
+	if (ret < 0)
+		goto nothing_to_do;
+
+skip_blocking:
+	pfm_resume_after_ovfl(ctx);
+
+nothing_to_do:
+
+	/*
+	 * restore flags as they were upon entry
+	 */
+	spin_unlock_irqrestore(&ctx->lock, flags);
+	return;
+
+do_zombie:
+	PFM_DBG("context is zombie, bailing out");
+
+	__pfm_unload_context(ctx, 0);
+
+	/*
+	 * enable interrupt for vfree()
+	 */
+	local_irq_enable();
+
+	/*
+	 * actual context free
+	 */
+	pfm_context_free(ctx);
+
+	/*
+	 * restore interrupts as they were upon entry
+	 */
+	local_irq_restore(flags);
+}
+
+static int pfm_notify_user(struct pfm_context *ctx, union pfm_msg *msg)
+{
+	if (ctx->state == PFM_CTX_ZOMBIE) {
+		PFM_DBG("ignoring overflow notification, owner is zombie");
+		return 0;
+	}
+	PFM_DBG("waking up somebody");
+
+	if (ctx->flags.kapi) {
+		complete(ctx->msgq_comp);
+		return 0;
+	}
+
+	wake_up_interruptible(&ctx->msgq_wait);
+
+	/*
+	 * it is safe to call kill_fasync() from an interrupt
+	 * handler. kill_fasync()  grabs two RW locks (fasync_lock,
+	 * tasklist_lock) in read mode. There is conflict only in
+	 * case the PMU interrupt occurs during a write mode critical
+	 * section. This cannot happen because for both locks, the
+	 * write mode is always using interrupt masking (write_lock_irq).
+	 */
+	kill_fasync (&ctx->async_queue, SIGIO, POLL_IN);
+
+	return 0;
+}
+
+int pfm_ovfl_notify_user(struct pfm_context *ctx,
+			struct pfm_event_set *set,
+	     		unsigned long ip)
+{
+	union pfm_msg *msg = NULL;
+	int max_cnt_pmd;
+	u64 *ovfl_pmds;
+
+	max_cnt_pmd = pfm_pmu_conf->max_cnt_pmd;
+
+	if (ctx->flags.no_msg == 0) {
+		msg = pfm_get_new_msg(ctx);
+		if (msg == NULL) {
+			/*
+			 * when message queue fills up it is because the user
+			 * did not extract the message, yet issued
+			 * pfm_restart(). At this point, we stop sending
+			 * notification, thus the user will not be able to get
+			 * new samples when using the default format.
+			 */
+			PFM_DBG_ovfl("no more notification msgs");
+			return -1;
+		}
+
+		msg->pfm_ovfl_msg.msg_type = PFM_MSG_OVFL;
+		msg->pfm_ovfl_msg.msg_ovfl_pid = current->pid;
+		msg->pfm_ovfl_msg.msg_active_set = set->id;
+
+		ovfl_pmds = msg->pfm_ovfl_msg.msg_ovfl_pmds;
+
+		bitmap_copy(ulp(ovfl_pmds), ulp(set->ovfl_pmds),
+			    max_cnt_pmd);
+
+		msg->pfm_ovfl_msg.msg_ovfl_cpu = smp_processor_id();
+		msg->pfm_ovfl_msg.msg_ovfl_tid = current->tgid;
+		msg->pfm_ovfl_msg.msg_ovfl_ip = ip;
+	}
+
+	PFM_DBG("ovfl msg: ip=0x%lx o_pmds=0x%llx",
+		ip,
+		(unsigned long long)set->ovfl_pmds[0]);
+
+	return pfm_notify_user(ctx, msg);
+}
+
+static int pfm_end_notify_user(struct pfm_context *ctx)
+{
+	union pfm_msg *msg;
+
+	msg = pfm_get_new_msg(ctx);
+	if (msg == NULL) {
+		PFM_ERR("%s no more msgs", __FUNCTION__);
+		return -1;
+	}
+	/* no leak */
+	memset(msg, 0, sizeof(*msg));
+
+	msg->type = PFM_MSG_END;
+
+	PFM_DBG("end msg: msg=%p no_msg=%d",
+		msg,
+		ctx->flags.no_msg);
+
+	return pfm_notify_user(ctx, msg);
+}
+
+/*
+ * this function is called from pfm_init()
+ * pfm_pmu_conf is NULL at this point
+ */
+void __cpuinit pfm_init_percpu (void *dummy)
+{
+	pfm_arch_init_percpu();
+}
+
+/*
+ * global initialization routine, executed only once
+ */
+int __init pfm_init(void)
+{
+	int ret;
+
+	PFM_LOG("version %u.%u", PFM_VERSION_MAJ, PFM_VERSION_MIN);
+
+	pfm_ctx_cachep = kmem_cache_create("pfm_context",
+				   sizeof(struct pfm_context)+PFM_ARCH_CTX_SIZE,
+				   SLAB_HWCACHE_ALIGN, 0, NULL, NULL);
+	if (pfm_ctx_cachep == NULL) {
+		PFM_ERR("cannot initialize context slab");
+		goto error_disable;
+	}
+	ret = pfm_sets_init();
+	if (ret)
+		goto error_disable;
+
+
+	if (pfm_sysfs_init())
+		goto error_disable;
+
+	/*
+	 * one time, global initialization
+	 */
+	if (pfm_arch_initialize())
+		goto error_disable;
+
+	init_pfm_fs();
+
+	/*
+	 * per cpu initialization (interrupts must be enabled)
+	 */
+	on_each_cpu(pfm_init_percpu, NULL, 1, 1);
+
+	return 0;
+error_disable:
+	return -1;
+}
+__initcall(pfm_init);
+
+
+/*
+ * called from process.c:copy_thread(). task is new child.
+ */
+void __pfm_copy_thread(struct task_struct *task)
+{
+	PFM_DBG("clearing state for [%d]", task->pid);
+	/*
+	 * cut link inherited from parent (current)
+	 */
+	task->pfm_context = NULL;
+}
+
+
+
+int __pfm_start(struct pfm_context *ctx, struct pfarg_start *start)
+{
+	struct task_struct *task, *owner_task;
+	struct pfm_event_set *new_set, *old_set;
+	u64 now_itc;
+	unsigned long info = 0;
+	int is_self, flags;
+
+	task = ctx->task;
+
+	/*
+	 * context must be loaded.
+	 * we do not support starting while in MASKED state
+	 * (mostly because of set switching issues)
+	 */
+	if (ctx->state != PFM_CTX_LOADED)
+		return -EINVAL;
+
+	owner_task = __get_cpu_var(pmu_owner);
+	old_set = new_set = ctx->active_set;
+
+	is_self = ctx->flags.system || task == current;
+
+	/*
+	 * always the case for system-wide
+	 */
+	if (task == NULL)
+		task = current;
+	/*
+	 * argument is provided?
+	 */
+	if (start) {
+		/*
+		 * find the set to load first
+		 */
+		new_set = pfm_find_set(ctx, start->start_set, 0);
+		if (new_set == NULL) {
+			PFM_DBG("event set%u does not exist",
+				start->start_set);
+			return -EINVAL;
+		}
+	}
+
+	PFM_DBG("cur_set=%u req_set=%u",
+		ctx->active_set->id,
+		new_set->id);
+
+	/*
+	 * if we need to change the active set we need
+	 * to check if we can access the PMU
+	 */
+	if (new_set != old_set) {
+		/*
+		 * system-wide: must run on the right CPU
+		 * per-thread : must be the owner of the PMU context
+		 *
+		 * pfm_switch_sets() returns with monitoring stopped
+		 */
+		if (is_self) {
+			pfm_switch_sets(ctx, new_set, PFM_PMD_RESET_LONG, 1);
+		} else {
+			/*
+			 * In the case of UP kernel, the PMU may
+			 * contain the state of the task we want to
+			 * operate on, yet the task may be switched
+			 * out (lazy save). We need to save current
+			 * state (old_set), switch active_set and
+			 * mark it for reload.
+			 */
+			if (owner_task == task) {
+				pfm_modview_begin(old_set);
+				pfm_arch_save_pmds(ctx, old_set);
+				pfm_modview_end(old_set);
+			}
+			ctx->active_set = new_set;
+			new_set->view->set_status |= PFM_SETVFL_ACTIVE;
+			new_set->priv_flags |= PFM_SETFL_PRIV_MOD_BOTH;
+		}
+	}
+	/*
+	 * mark as started, must be done before calling
+	 * pfm_arch_start()
+	 */
+	ctx->flags.started = 1;
+
+	/*
+	 * at this point, monitoring is:
+	 * 	- stopped if we switched set (self-monitoring)
+	 * 	- stopped if never started
+	 * 	- started if calling pfm_start() in sequence
+	 */
+	now_itc = pfm_arch_get_itc();
+	flags = new_set->flags;
+
+	if (is_self) {
+		if (flags & PFM_SETFL_TIME_SWITCH)
+			info = PFM_CPUINFO_TIME_SWITCH;
+
+		__get_cpu_var(pfm_syst_info) = info;
+	}
+	/*
+	 * in system-wide, the new_set may EXCL_IDLE, in which
+	 * case pfm_start() must actually stop monitoring
+	 */
+	if (current->pid == 0 && (flags & PFM_SETFL_EXCL_IDLE))
+		pfm_arch_stop(task, ctx, new_set);
+	else
+		pfm_arch_start(task, ctx, new_set);
+
+	/*
+	 * we restart total duration even if context was
+	 * already started. In that case, counts are simply
+	 * reset.
+	 *
+	 * For system-wide, we start counting even when we exclude
+	 * idle and pfm_start() called by idle.
+	 *
+	 * For per-thread, if not self-monitoring, the statement
+	 * below will have no effect because thread is stopped.
+	 * The field is reset of ctxsw in.
+	 *
+	 * if monitoring is masked (MASKED), this statement
+	 * will be overriden in pfm_unmask_monitoring()
+	 */
+	ctx->duration_start = now_itc;
+	new_set->duration_start = now_itc;
+
+
+	return 0;
+}
+
+int __pfm_stop(struct pfm_context *ctx)
+{
+	struct pfm_event_set *set;
+	struct task_struct *task;
+	u64 now_itc;
+	int state, is_system;
+
+	now_itc = pfm_arch_get_itc();
+	state = ctx->state;
+	is_system = ctx->flags.system;
+	set = ctx->active_set;
+
+	/*
+	 * context must be attached (zombie cannot happen)
+	 */
+	if (state == PFM_CTX_UNLOADED)
+		return -EINVAL;
+
+	task = ctx->task;
+
+	PFM_DBG("ctx_task=[%d] ctx_state=%d is_system=%d",
+		task ? task->pid : -1,
+		state,
+		is_system);
+
+	/*
+	 * this happens for system-wide context
+	 */
+	if (task == NULL)
+		task = current;
+
+	/*
+	 * compute elapsed time
+	 *
+	 * for non-self-monitorint, the thread is necessarily stopped
+	 * and total duration has already been computed in ctxsw out.
+	 */
+	if (task == current) {
+		ctx->duration += now_itc - ctx->duration_start;
+		/*
+		 * don't update set duration if masked
+		 */
+		if (state == PFM_CTX_LOADED)
+			set->duration += now_itc - set->duration_start;
+	}
+
+	pfm_arch_stop(task, ctx, set);
+
+	ctx->flags.started = 0;
+
+	return 0;
+}
+
+int __pfm_restart(struct pfm_context *ctx)
+{
+	int state, is_system;
+
+	state = ctx->state;
+	is_system = ctx->flags.system;
+
+	switch(state) {
+		case PFM_CTX_MASKED:
+			break;
+		case PFM_CTX_LOADED:
+			if (ctx->smpl_addr && ctx->smpl_fmt->fmt_restart)
+				break;
+			/* fall through */
+		case PFM_CTX_UNLOADED:
+		case PFM_CTX_ZOMBIE:
+			PFM_DBG("invalid state=%d", state);
+			return -EBUSY;
+		default:
+			PFM_DBG("state=%d with no active_restart handler",
+				state);
+			return -EINVAL;
+	}
+	/*
+	 * at this point, the context is either LOADED or MASKED
+	 */
+
+	if (ctx->task == current || is_system) {
+		pfm_resume_after_ovfl(ctx);
+		return 0;
+	}
+
+	/*
+	 * restart another task
+	 */
+
+	/*
+	 * When PFM_CTX_MASKED, we cannot issue a restart before the previous
+	 * one is seen by the task.
+	 */
+	if (state == PFM_CTX_MASKED) {
+		if (ctx->flags.can_restart == 0) {
+			PFM_DBG("cannot restart can_restart=%d",
+				ctx->flags.can_restart);
+			return -EBUSY;
+		}
+		/*
+		 * prevent subsequent restart before this one is
+		 * seen by the task
+		 */
+		ctx->flags.can_restart = 0;
+	}
+
+	/*
+	 * if blocking, then post the semaphore is PFM_CTX_MASKED, i.e.
+	 * the task is blocked or on its way to block. That's the normal
+	 * restart path. If the monitoring is not masked, then the task
+	 * can be actively monitoring and we cannot directly intervene.
+	 * Therefore we use the trap mechanism to catch the task and
+	 * force it to reset the buffer/reset PMDs.
+	 *
+	 * if non-blocking, then we ensure that the task will go into
+	 * pfm_handle_work() before returning to user mode.
+	 *
+	 * We cannot explicitely reset another task, it MUST always
+	 * be done by the task itself. This works for system wide because
+	 * the tool that is controlling the session is logically doing
+	 * "self-monitoring".
+	 */
+	if (ctx->flags.block && state == PFM_CTX_MASKED) {
+		PFM_DBG("unblocking [%d]", ctx->task->pid);
+		complete(&ctx->restart_complete);
+	} else {
+		struct thread_info *info;
+
+		PFM_DBG("[%d] armed exit trap", ctx->task->pid);
+
+		/*
+		 * mark work pending
+		 */
+		ctx->flags.trap_reason = PFM_TRAP_REASON_RESET;
+
+		info = ctx->task->thread_info;
+		set_bit(TIF_NOTIFY_RESUME, &info->flags);
+
+		/*
+		 * XXX: send reschedule if task runs on another CPU
+		 */
+	}
+	return 0;
+}
+
+/*
+ * XXX: interrupts are masked yet monitoring may be active. Hence they
+ * might be a counter overflow during the call. It will be kept pending
+ * and we might return inconsistent unless we check the state of the counter
+ * and compensate for the overflow. Note that we will not loose a sample
+ * when sampling, however, there may be an issue with simple counting and
+ * virtualization.
+ */
+int __pfm_read_pmds(struct pfm_context *ctx, struct pfarg_pmd *req, int count)
+{
+	u64 val = 0, lval, ovfl_mask, hw_val;
+	u64 sw_cnt;
+	u64 *impl_pmds;
+	struct pfm_event_set *set, *active_set;
+	int i, can_access_pmu = 0;
+	int is_system, error_code;
+	u16 cnum, pmd_type, set_id, prev_set_id, max_pmd;
+
+	is_system = ctx->flags.system;
+	ovfl_mask = pfm_pmu_conf->ovfl_mask;
+	impl_pmds = pfm_pmu_conf->impl_pmds;
+	max_pmd   = pfm_pmu_conf->max_pmd;
+	active_set = ctx->active_set;
+	set = NULL;
+	prev_set_id = 0;
+
+	if (likely(ctx->state == PFM_CTX_LOADED)) {
+		/*
+		 * this can be true when not self-monitoring only in UP
+		 */
+		can_access_pmu = __get_cpu_var(pmu_owner) == ctx->task || is_system;
+
+		if (can_access_pmu)
+			pfm_arch_serialize();
+	}
+	error_code = PFM_REG_RETFL_EINVAL;
+
+	/*
+	 * on both UP and SMP, we can only read the PMD from the hardware
+	 * register when the task is the owner of the local PMU.
+	 */
+	for (i = 0; i < count; i++, req++) {
+
+		cnum = req->reg_num;
+		set_id = req->reg_set;
+
+		if (unlikely(cnum >= max_pmd || !pfm_bv_isset(impl_pmds, cnum)))
+			goto error;
+
+		pmd_type = pfm_pmu_conf->pmd_desc[cnum].type;
+
+		/*
+		 * locate event set
+		 */
+		if (i == 0 || set_id != prev_set_id) {
+			set = pfm_find_set(ctx, set_id, 0);
+			if (set == NULL) {
+				PFM_DBG("event set%u does not exist",
+					set_id);
+				error_code = PFM_REG_RETFL_NOSET;
+				goto error;
+			}
+		}
+		/*
+		 * it is not possible to read a PMD which was not requested:
+		 * 	- explicitly written via pfm_write_pmds()
+		 * 	- provided as a reg_smpl_pmds[] to another PMD during
+		 * 	  pfm_write_pmds()
+		 *
+		 * This is motivated by security and for optimizations purposes:
+		 * 	- on context switch restore, we can restore only what we
+		 * 	  use (except when regs directly readable at user level,
+		 * 	  e.g., IA-64 self-monitoring, I386 RDTSC).
+		 * 	- do not need to maintain PMC -> PMD dependencies
+		 */
+		if (unlikely(pfm_bv_isset(set->used_pmds, cnum) == 0)) {
+			PFM_DBG("pmd%u cannot be read, because never "
+				"requested", cnum);
+			goto error;
+		}
+
+		/*
+		 * it is possible to read PMD registers which have not
+		 * explicitely been written by the application. In this case
+		 * the default value is returned.
+		 */
+		val = set->view->set_pmds[cnum];
+		lval = set->pmds[cnum].lval;
+
+		/*
+		 * extract remaining ovfl to switch
+		 */
+		sw_cnt = set->pmds[cnum].ovflsw_thres;
+
+		/*
+		 * If the task is not the current one, then we check if the
+		 * PMU state is still in the local live register due to lazy
+		 * ctxsw. If true, then we read directly from the registers.
+		 */
+		if (set == active_set && can_access_pmu) {
+			hw_val = pfm_read_pmd(ctx, cnum);
+			if (pmd_type & PFM_REG_C64)
+				val = (val & ~ovfl_mask) | (hw_val & ovfl_mask);
+			else
+				val = hw_val;
+		}
+
+		PFM_DBG("set%u pmd%u=0x%llx switch_thres=%llu",
+			set->id,
+			cnum,
+			(unsigned long long)val,
+			(unsigned long long)sw_cnt);
+
+		pfm_retflag_set(req->reg_flags, 0);
+		req->reg_value = val;
+		req->reg_last_reset_val = lval;
+		req->reg_ovfl_switch_cnt = sw_cnt;
+
+		prev_set_id = set_id;
+	}
+	return 0;
+
+error:
+	pfm_retflag_set(req->reg_flags, error_code);
+	return -EINVAL;
+}
+
+int __pfm_write_pmds(struct pfm_context *ctx, struct pfarg_pmd *req, int count,
+		     int compat)
+{
+#define PFM_REGFL_PMD_ALL	(PFM_REGFL_RANDOM     | \
+				 PFM_REGFL_OVFL_NOTIFY| \
+				 PFM_REG_RETFL_MASK)
+
+	struct pfm_event_set *set, *active_set;
+	u64 value, hw_val, ovfl_mask;
+	u64 *smpl_pmds, *reset_pmds, *impl_pmds;
+	u32 req_flags, flags;
+	u16 cnum, pmd_type, max_pmd, max_pmc;
+	u16 set_id, prev_set_id;
+	int i, can_access_pmu;
+	int is_counting, is_system;
+	int ret, error_code, has_wr_check;
+	pfm_pmd_check_t	wr_func;
+
+	is_system = ctx->flags.system;
+	ovfl_mask = pfm_pmu_conf->ovfl_mask;
+	active_set = ctx->active_set;
+	max_pmd	= pfm_pmu_conf->max_pmd;
+	max_pmc	= pfm_pmu_conf->max_pmc;
+	impl_pmds = pfm_pmu_conf->impl_pmds;
+	wr_func = pfm_pmu_conf->pmd_write_check;
+	set = NULL;
+
+	prev_set_id = 0;
+	can_access_pmu = 0;
+
+	/*
+	 * we cannot access the actual PMD registers when monitoring is masked
+	 */
+	if (likely(ctx->state == PFM_CTX_LOADED))
+		can_access_pmu = __get_cpu_var(pmu_owner) == ctx->task
+			       || is_system;
+
+	error_code = PFM_REG_RETFL_EINVAL;
+	ret = -EINVAL;
+
+	has_wr_check = wr_func != NULL && (pfm_controls.expert_mode == 0);
+
+	for (i = 0; i < count; i++, req++) {
+
+		cnum = req->reg_num;
+		set_id = req->reg_set;
+		req_flags = req->reg_flags;
+		smpl_pmds = req->reg_smpl_pmds;
+		reset_pmds = req->reg_reset_pmds;
+		flags = 0;
+
+		if (unlikely(cnum >= max_pmd || !pfm_bv_isset(impl_pmds, cnum))) {
+			PFM_DBG("pmd%u is not implemented or not accessible",
+				cnum);
+			goto error;
+		}
+
+		pmd_type = pfm_pmu_conf->pmd_desc[cnum].type;
+		is_counting = pmd_type & PFM_REG_C64;
+
+		if (likely(compat == 0)) {
+			if (likely(is_counting)) {
+				/*
+				 * ensure only valid flags are set
+				 */
+				if (req_flags & ~(PFM_REGFL_PMD_ALL)) {
+					PFM_DBG("pmd%u: invalid flags=0x%x",
+						cnum, req_flags);
+					goto error;
+				}
+
+				if (req_flags & PFM_REGFL_OVFL_NOTIFY)
+					flags |= PFM_REGFL_OVFL_NOTIFY;
+				if (req_flags & PFM_REGFL_RANDOM)
+					flags |= PFM_REGFL_RANDOM;
+				/*
+				 * verify validity of smpl_pmds
+				 */
+				if (unlikely(bitmap_subset(ulp(smpl_pmds),
+							   ulp(impl_pmds),
+							   max_pmd) == 0)) {
+					PFM_DBG("invalid smpl_pmds=0x%llx "
+						"for pmd%u",
+						(unsigned long long)smpl_pmds[0],
+						cnum);
+					goto error;
+				}
+				/*
+				 * verify validity of reset_pmds
+				 */
+				if (unlikely(bitmap_subset(ulp(reset_pmds),
+							   ulp(impl_pmds),
+							   max_pmd) == 0)) {
+					PFM_DBG("invalid reset_pmds=0x%llx "
+						"for pmd%u",
+						(unsigned long long)reset_pmds[0],
+						cnum);
+					goto error;
+				}
+			}
+		}
+
+		/*
+		 * locate event set
+		 */
+		if (i == 0 || set_id != prev_set_id) {
+			set = pfm_find_set(ctx, set_id, 0);
+			if (set == NULL) {
+				PFM_DBG("event set%u does not exist",
+					set_id);
+				error_code = PFM_REG_RETFL_NOSET;
+				goto error;
+			}
+		}
+
+		/*
+		 * execute write checker, if any
+		 */
+		if (likely(has_wr_check && (pmd_type & PFM_REG_WC))) {
+			ret = (*wr_func)(ctx, set, req);
+			if (ret)
+				goto error;
+
+		}
+		hw_val = value = req->reg_value;
+
+		/*
+		 * now commit changes to software state
+		 */
+		pfm_modview_begin(set);
+
+		if (likely(is_counting)) {
+			if (likely(compat == 0)) {
+
+				set->pmds[cnum].flags = flags;
+
+				/*
+				 * copy reset and sampling bitvectors
+				 */
+				bitmap_copy(ulp(set->pmds[cnum].reset_pmds),
+					    ulp(reset_pmds),
+					    max_pmd);
+
+				bitmap_copy(ulp(set->pmds[cnum].smpl_pmds),
+					    ulp(smpl_pmds),
+					    max_pmd);
+
+				set->pmds[cnum].eventid = req->reg_smpl_eventid;
+
+				/*
+				 * Mark reset/smpl PMDS as used.
+				 *
+				 * We do not keep track of PMC because we have to
+				 * systematically restore ALL of them.
+				 */
+				bitmap_or(ulp(set->used_pmds),
+					  ulp(set->used_pmds),
+					  ulp(reset_pmds), max_pmd);
+
+				bitmap_or(ulp(set->used_pmds),
+					  ulp(set->used_pmds),
+					  ulp(smpl_pmds), max_pmd);
+
+				/*
+				 * we reprogrammed the PMD hence, clear any pending
+				 * ovfl, switch based on the old value
+				 * for restart we have already established new values
+				 */
+				pfm_bv_clear(set->povfl_pmds, cnum);
+				pfm_bv_clear(set->ovfl_pmds, cnum);
+
+				/*
+				 * update ovfl_notify
+				 */
+				if (flags & PFM_REGFL_OVFL_NOTIFY)
+					pfm_bv_set(set->ovfl_notify, cnum);
+				else
+					pfm_bv_clear(set->ovfl_notify, cnum);
+			}
+			/*
+			 * reset last value to new value
+			 */
+			set->pmds[cnum].lval = value;
+
+			hw_val = value & ovfl_mask;
+
+			/*
+			 * establish new switch count
+			 */
+			set->pmds[cnum].ovflsw_thres = req->reg_ovfl_switch_cnt;
+			set->pmds[cnum].ovflsw_ref_thres = req->reg_ovfl_switch_cnt;
+		}
+
+		/*
+		 * update reset values (not just for counters)
+		 */
+		set->pmds[cnum].long_reset = req->reg_long_reset;
+		set->pmds[cnum].short_reset = req->reg_short_reset;
+
+		/*
+		 * update randomization parameters (not just for counters)
+		 */
+		set->pmds[cnum].seed = req->reg_random_seed;
+		set->pmds[cnum].mask = req->reg_random_mask;
+
+		/*
+		 * update set values
+		 */
+		set->view->set_pmds[cnum] = value;
+
+		pfm_modview_end(set);
+
+		pfm_bv_set(set->used_pmds, cnum);
+
+		if (set == active_set) {
+			set->priv_flags |= PFM_SETFL_PRIV_MOD_PMDS;
+			if (can_access_pmu)
+				pfm_write_pmd(ctx, cnum, hw_val);
+		}
+
+		/*
+		 * update number of used PMD registers
+		 */
+		set->nused_pmds = bitmap_weight(ulp(set->used_pmds), max_pmd);
+
+		pfm_retflag_set(req->reg_flags, 0);
+
+		prev_set_id = set_id;
+
+		PFM_DBG("set%u pmd%u=0x%llx flags=0x%x a_pmu=%d "
+			"hw_pmd=0x%llx ctx_pmd=0x%llx s_reset=0x%llx "
+			"l_reset=0x%llx u_pmds=0x%llx nu_pmds=%u "
+			"s_pmds=0x%llx r_pmds=0x%llx o_pmds=0x%llx "
+			"o_thres=%llu compat=%d eventid=%llx",
+			set->id,
+			cnum,
+			(unsigned long long)value,
+			set->pmds[cnum].flags,
+			can_access_pmu,
+			(unsigned long long)hw_val,
+			(unsigned long long)set->view->set_pmds[cnum],
+			(unsigned long long)set->pmds[cnum].short_reset,
+			(unsigned long long)set->pmds[cnum].long_reset,
+			(unsigned long long)set->used_pmds[0],
+			set->nused_pmds,
+			(unsigned long long)set->pmds[cnum].smpl_pmds[0],
+			(unsigned long long)set->pmds[cnum].reset_pmds[0],
+			(unsigned long long)set->ovfl_pmds[0],
+			(unsigned long long)set->pmds[cnum].ovflsw_thres,
+			compat,
+			(unsigned long long)set->pmds[cnum].eventid);
+	}
+
+	/*
+	 * make changes visible
+	 */
+	if (can_access_pmu)
+		pfm_arch_serialize();
+
+	return 0;
+
+error:
+	/*
+	 * for now, we have only one possibility for error
+	 */
+	pfm_retflag_set(req->reg_flags, error_code);
+	return ret;
+}
+
+int __pfm_write_pmcs(struct pfm_context *ctx, struct pfarg_pmc *req, int count)
+{
+#define PFM_REGFL_PMC_ALL	(PFM_REGFL_NO_EMUL64|PFM_REG_RETFL_MASK)
+	struct pfm_event_set *set, *active_set;
+	u64 value, dfl_val, rsvd_msk;
+	u64 *impl_pmcs;
+	int i, can_access_pmu;
+	int is_system, has_wr_check;
+	int ret, error_code;
+	u16 set_id, prev_set_id;
+	u16 cnum, pmc_type, max_pmc;
+	u32 flags;
+	pfm_pmc_check_t	wr_func;
+
+	is_system  = ctx->flags.system;
+	active_set = ctx->active_set;
+
+	wr_func = pfm_pmu_conf->pmc_write_check;
+	max_pmc = pfm_pmu_conf->max_pmc;
+	impl_pmcs = pfm_pmu_conf->impl_pmcs;
+
+	set = NULL;
+	prev_set_id = 0;
+	can_access_pmu = 0;
+
+	/*
+	 * we cannot access the actual PMC registers when monitoring is masked
+	 */
+	if (likely(ctx->state == PFM_CTX_LOADED))
+		can_access_pmu = __get_cpu_var(pmu_owner) == ctx->task
+			      || is_system;
+
+	error_code  = PFM_REG_RETFL_EINVAL;
+
+	has_wr_check = wr_func != NULL && (pfm_controls.expert_mode == 0);
+
+	for (i = 0; i < count; i++, req++) {
+
+		ret = -EINVAL;
+		cnum = req->reg_num;
+		set_id = req->reg_set;
+		value = req->reg_value;
+		flags = req->reg_flags;
+
+		/*
+		 * no access to unimplemented PMC register
+		 */
+		if (unlikely(cnum >= max_pmc || !pfm_bv_isset(impl_pmcs, cnum))) {
+			PFM_DBG("pmc%u is not implemented/unaccessible",
+				cnum);
+			error_code  = PFM_REG_RETFL_NOTAVAIL;
+			goto error;
+		}
+
+		pmc_type = pfm_pmu_conf->pmc_desc[cnum].type;
+		dfl_val = pfm_pmu_conf->pmc_desc[cnum].dfl_val;
+		rsvd_msk = pfm_pmu_conf->pmc_desc[cnum].rsvd_msk;
+
+		/*
+		 * ensure only valid flags are set
+		 */
+		if (flags & ~(PFM_REGFL_PMC_ALL)) {
+			PFM_DBG("pmc%u: invalid flags=0x%x", cnum, flags);
+			goto error;
+		}
+
+		/*
+		 * locate event set
+		 */
+		if (i == 0 || set_id != prev_set_id) {
+			set = pfm_find_set(ctx, set_id, 0);
+			if (set == NULL) {
+				PFM_DBG("event set%u does not exist",
+					set_id);
+				error_code = PFM_REG_RETFL_NOSET;
+				goto error;
+			}
+		}
+
+		/*
+		 * set reserved bits to default values
+		 */
+		value = (value & rsvd_msk) | (dfl_val & ~rsvd_msk);
+
+		if (flags & PFM_REGFL_NO_EMUL64) {
+			if ((pmc_type & PFM_REG_NO64) == 0) {
+				PFM_DBG("pmc%u no support "
+					"PFM_REGFL_NO_EMUL64", cnum);
+				goto error;
+			}
+			value &= ~pfm_pmu_conf->pmc_desc[cnum].no_emul64_msk;
+		}
+
+		/*
+		 * execute write checker, if any
+		 */
+		if (likely(has_wr_check && (pmc_type & PFM_REG_WC))) {
+			req->reg_value = value;
+			ret = (*wr_func)(ctx, set, req);
+			if (ret)
+				goto error;
+			value = req->reg_value;
+		}
+
+		/*
+		 * Now we commit the changes
+		 */
+
+		/*
+		 * mark PMC register as used
+		 * We do not track associated PMC register based on
+		 * the fact that they will likely need to be written
+		 * in order to become useful at which point the statement
+		 * below will catch that.
+		 *
+		 * The used_pmcs bitmask is only useful on architectures where
+		 * the PMC need to be modified for particular bits, especially
+		 * on overflow or to stop/start.
+		 */
+		if (pfm_bv_isset(set->used_pmcs, cnum) == 0) {
+			pfm_bv_set(set->used_pmcs, cnum);
+			set->nused_pmcs++;
+		}
+
+		set->pmcs[cnum] = value;
+
+		if (set == active_set) {
+			set->priv_flags |= PFM_SETFL_PRIV_MOD_PMCS;
+			if (can_access_pmu)
+				pfm_arch_write_pmc(ctx, cnum, value);
+		}
+
+		pfm_retflag_set(req->reg_flags, 0);
+
+		prev_set_id = set_id;
+
+		PFM_DBG("set%u pmc%u=0x%llx a_pmu=%d "
+			"u_pmcs=0x%llx nu_pmcs=%u",
+			set->id,
+			cnum,
+			(unsigned long long)value,
+			can_access_pmu,
+			(unsigned long long)set->used_pmcs[0],
+			set->nused_pmcs);
+	}
+	/*
+	 * make sure the changes are visible
+	 *
+	 * XXX: should check the we actually touched HW
+	 */
+	if (can_access_pmu)
+		pfm_arch_serialize();
+
+	return 0;
+error:
+	pfm_retflag_set(req->reg_flags, error_code);
+	return ret;
+}
+
+/*
+ * should not call when task == current
+ */
+static int pfm_bad_permissions(struct task_struct *task)
+{
+	/* inspired by ptrace_attach() */
+	PFM_DBG("cur: euid=%d uid=%d gid=%d task: euid=%d "
+		"suid=%d uid=%d egid=%d cap:%d sgid=%d",
+		current->euid,
+		current->uid,
+		current->gid,
+		task->euid,
+		task->suid,
+		task->uid,
+		task->egid,
+		task->sgid, capable(CAP_SYS_PTRACE));
+
+	return ((current->uid != task->euid)
+	    || (current->uid != task->suid)
+	    || (current->uid != task->uid)
+	    || (current->gid != task->egid)
+	    || (current->gid != task->sgid)
+	    || (current->gid != task->gid)) && !capable(CAP_SYS_PTRACE);
+}
+
+
+/*
+ * cannot attach if :
+ * 	- kernel task
+ * 	- task not owned by caller
+ * 	- task incompatible with context mode
+ */
+static int pfm_task_incompatible(struct pfm_context *ctx,
+				 struct task_struct *task)
+{
+	/*
+	 * no kernel task or task not owned by caller
+	 */
+	if (task->mm == NULL) {
+		PFM_DBG("cannot attach to kernel thread [%d]", task->pid);
+		return -EPERM;
+	}
+
+	if (pfm_bad_permissions(task)) {
+		PFM_DBG("no permission to attach to [%d]", task->pid);
+		return -EPERM;
+	}
+
+	/*
+	 * cannot block in self-monitoring mode
+	 */
+	if (ctx->flags.block && task == current) {
+		PFM_DBG("cannot load a in blocking mode on self for [%d]",
+			task->pid);
+		return -EINVAL;
+	}
+
+	if (task->state == EXIT_ZOMBIE || task->state == EXIT_DEAD) {
+		PFM_DBG("cannot attach to zombie/dead task [%d]", task->pid);
+		return -EBUSY;
+	}
+
+	/*
+	 * always ok for self
+	 */
+	if (task == current)
+		return 0;
+
+	if ((task->state != TASK_STOPPED) && (task->state != TASK_TRACED)) {
+		PFM_DBG("cannot attach to non-stopped task [%d] state=%ld",
+			task->pid, task->state);
+		return -EBUSY;
+	}
+	PFM_DBG("before wait_inactive() task [%d] state=%ld",
+		task->pid, task->state);
+	/*
+	 * make sure the task is off any CPU
+	 */
+	wait_task_inactive(task);
+
+	PFM_DBG("after wait_inactive() task [%d] state=%ld",
+		task->pid, task->state);
+	/* more to come... */
+
+	return 0;
+}
+static int pfm_get_task(struct pfm_context *ctx, pid_t pid,
+			struct task_struct **task)
+{
+	struct task_struct *p = current;
+	int ret;
+
+	/* XXX: need to add more checks here */
+	if (pid < 2)
+		return -EPERM;
+
+	if (pid != current->pid) {
+
+		read_lock(&tasklist_lock);
+
+		p = find_task_by_pid(pid);
+
+		/* make sure task cannot go away while we operate on it */
+		if (p)
+			get_task_struct(p);
+
+		read_unlock(&tasklist_lock);
+
+		if (p == NULL)
+			return -ESRCH;
+	}
+
+	ret = pfm_task_incompatible(ctx, p);
+	if (ret == 0) {
+		*task = p;
+	} else if (p != current) {
+		put_task_struct(p);
+	}
+	return ret;
+}
+
+static int pfm_check_task_exist(struct pfm_context *ctx)
+{
+	struct task_struct *g, *t;
+	int ret = -ESRCH;
+
+	read_lock(&tasklist_lock);
+
+	do_each_thread (g, t) {
+		if (t->pfm_context == ctx) {
+			ret = 0;
+			break;
+		}
+	} while_each_thread (g, t);
+
+	read_unlock(&tasklist_lock);
+
+	PFM_DBG("ret=%d ctx=%p", ret, ctx);
+
+	return ret;
+}
+
+
+static int pfm_load_context_thread(struct pfm_context *ctx, pid_t pid,
+				   struct pfm_event_set *set)
+{
+	struct task_struct *task = NULL;
+	struct pfm_context *old;
+	u32 set_flags;
+	unsigned long info;
+	int ret, state;
+
+	state = ctx->state;
+	set_flags = set->flags;
+
+	PFM_DBG("load_pid [%d] set=%u runs=%llu set_flags=0x%x",
+		pid,
+		set->id,
+		(unsigned long long)set->view->set_runs,
+		set_flags);
+
+	if (ctx->flags.block && pid == current->pid) {
+		PFM_DBG("cannot use blocking mode in while self-monitoring");
+		return -EINVAL;
+	}
+
+	ret = pfm_get_task(ctx, pid, &task);
+	if (ret) {
+		PFM_DBG("load_pid [%d] get_task=%d", pid, ret);
+		return ret;
+	}
+
+	ret = pfm_arch_load_context(ctx, task);
+	if (ret) {
+		put_task_struct(task);
+		return ret;
+	}
+
+	/*
+	 * now reserve the session
+	 */
+	ret = pfm_reserve_session(ctx, -1);
+	if (ret)
+		goto error;
+
+	/*
+	 * task is necessarily stopped at this point.
+	 *
+	 * If the previous context was zombie, then it got removed in
+	 * pfm_ctxswout_thread(). Therefore we should not see it here.
+	 * If we see a context, then this is an active context
+	 *
+	 */
+	PFM_DBG("before cmpxchg() old_ctx=%p new_ctx=%p",
+		task->pfm_context, ctx);
+
+	ret = -EEXIST;
+
+	old = cmpxchg(&task->pfm_context, NULL, ctx);
+	if (old != NULL) {
+		PFM_DBG("load_pid [%d] has already a context "
+			"old=%p new=%p cur=%p",
+			pid,
+			old,
+			ctx,
+			task->pfm_context);
+		goto error_unres;
+	}
+
+	/*
+	 * link context to task
+	 */
+	ctx->task = task;
+
+	/*
+	 * commit active set
+	 */
+	ctx->active_set = set;
+
+	pfm_modview_begin(set);
+
+	set->view->set_runs++;
+
+	set->view->set_status |= PFM_SETVFL_ACTIVE;
+
+	/*
+	 * self-monitoring
+	 */
+	if (task == current) {
+#ifndef CONFIG_SMP
+		struct pfm_context *ctxp;
+
+		/*
+		 * in UP per-thread, due to lazy save
+		 * there could be a context from another
+		 * task. We need to push it first before
+		 * installing our new state
+		 */
+		ctxp = __get_cpu_var(pmu_ctx);
+		if (ctxp)
+			pfm_save_pmds_release(ctxp);
+#endif
+		pfm_set_last_cpu(ctx, smp_processor_id());
+		pfm_inc_activation();
+		pfm_set_activation(ctx);
+
+		/*
+		 * setting PFM_CPUINFO_TIME_SWITCH, triggers
+		 * further checking if __pfm_handle_switch_timeout().
+		 * switch timeout is effectively decremented only once
+		 * monitoring has been activated via pfm_start() or
+		 * any user level equivalent.
+		 */
+		if (set_flags & PFM_SETFL_TIME_SWITCH) {
+			info = PFM_CPUINFO_TIME_SWITCH;
+			__get_cpu_var(pfm_syst_info) = info;
+		}
+		/*
+		 * load all PMD from set
+		 * load all PMC from set
+		 */
+		pfm_arch_restore_pmds(ctx, set);
+		pfm_arch_restore_pmcs(ctx, set);
+
+		/*
+		 * set new ownership
+		 */
+		pfm_set_pmu_owner(task, ctx);
+
+		PFM_DBG("context loaded on PMU for [%d]", task->pid);
+	} else {
+
+		/* force a full reload */
+		ctx->last_act = PFM_INVALID_ACTIVATION;
+		pfm_set_last_cpu(ctx, -1);
+		set->priv_flags |= PFM_SETFL_PRIV_MOD_BOTH;
+		PFM_DBG("context loaded next ctxswin for [%d]", task->pid);
+	}
+
+	pfm_modview_end(set);
+
+	ret = 0;
+
+error_unres:
+	if (ret)
+		pfm_release_session(ctx, -1);
+error:
+	/*
+	 * release task, there is now a link with the context
+	 */
+	if (task != current) {
+		put_task_struct(task);
+
+		if (ret == 0) {
+			ret = pfm_check_task_exist(ctx);
+			if (ret) {
+				ctx->state = PFM_CTX_UNLOADED;
+				ctx->task = NULL;
+			}
+		}
+	}
+	return ret;
+}
+
+static int pfm_load_context_sys(struct pfm_context *ctx, struct pfm_event_set *set)
+{
+	u32 set_flags;
+	u32 my_cpu;
+	int ret;
+
+	my_cpu = smp_processor_id();
+
+	set_flags = set->flags;
+
+	ret = pfm_arch_load_context(ctx, NULL);
+	if (ret)
+		return ret;
+
+	PFM_DBG("cpu=%d set=%u runs=%llu set_flags=0x%x",
+		smp_processor_id(),
+		set->id,
+		(unsigned long long)set->view->set_runs,
+		set_flags);
+
+	/*
+	 * now reserve the session
+	 */
+	ret = pfm_reserve_session(ctx, my_cpu);
+	if (ret)
+		return ret;
+
+	/*
+	 * bind context to current CPU
+	 */
+	ctx->cpu = my_cpu;
+	ctx->task = NULL;
+
+	pfm_modview_begin(set);
+
+	set->view->set_runs++;
+
+	/*
+	 * commit active set
+	 */
+	ctx->active_set = set;
+	set->view->set_status |= PFM_SETVFL_ACTIVE;
+
+	/*
+	 * load all registes from ctx to PMU
+	 */
+	pfm_arch_restore_pmds(ctx, set);
+	pfm_arch_restore_pmcs(ctx, set);
+
+	pfm_modview_end(set);
+
+	set->priv_flags &= ~PFM_SETFL_PRIV_MOD_BOTH;
+
+	PFM_DBG("context loaded on CPU%d", my_cpu);
+
+	pfm_set_pmu_owner(NULL, ctx);
+
+	return 0;
+}
+
+int __pfm_load_context(struct pfm_context *ctx, struct pfarg_load *req)
+{
+	struct pfm_event_set *set;
+	int ret = 0;
+
+	/*
+	 * can only load from unloaded
+	 */
+	if (ctx->state != PFM_CTX_UNLOADED) {
+		PFM_DBG("context already loaded");
+		return -EBUSY;
+	}
+
+	/*
+	 * locate active set
+	 */
+	set = pfm_find_set(ctx, req->load_set, 0);
+	if (set == NULL) {
+		PFM_DBG("event set%u does not exist", req->load_set);
+		return -EINVAL;
+	}
+	/*
+	 * assess sanity of event sets, initialize set state
+	 */
+	ret = pfm_prepare_sets(ctx, set);
+	if (ret) {
+		PFM_DBG("invalid next field pointers in the sets");
+		return -EINVAL;
+	}
+
+	if (ctx->flags.system)
+		ret = pfm_load_context_sys(ctx, set);
+	else
+		ret = pfm_load_context_thread(ctx, req->load_pid, set);
+
+	if (ret)
+		return ret;
+
+	/*
+	 * reset message queue
+	 */
+	pfm_reset_msgq(ctx);
+
+	ctx->duration = 0;
+	ctx->flags.started = 0;
+	ctx->flags.trap_reason = PFM_TRAP_REASON_NONE;
+	ctx->flags.can_restart = 0;
+	ctx->state = PFM_CTX_LOADED;
+
+	return 0;
+}
+
+int __pfm_unload_context(struct pfm_context *ctx, int defer_release)
+{
+	struct task_struct *task;
+	struct pfm_event_set *set;
+	int state, ret, is_self;
+
+	state = ctx->state;
+
+	/*
+	 * unload only when necessary
+	 */
+	if (state == PFM_CTX_UNLOADED)
+		return 0;
+
+	task = ctx->task;
+	set = ctx->active_set;
+	is_self = ctx->flags.system || task == current;
+
+	PFM_DBG("ctx_state=%d task [%d]", state, task ? task->pid : -1);
+
+	/*
+	 * stop monitoring
+	 */
+	ret = __pfm_stop(ctx);
+	if (ret)
+		return ret;
+
+	pfm_modview_begin(set);
+	set->view->set_status &= ~PFM_SETVFL_ACTIVE;
+	pfm_modview_end(set);
+
+	ctx->state = PFM_CTX_UNLOADED;
+
+	/*
+	 * clear any leftover in pfm_syst_info.
+	 *
+	 * for non-self monitoring,
+	 * this is done in pfm_ctxswout_thread.
+	 */
+	if (is_self)
+		__get_cpu_var(pfm_syst_info) = 0;
+
+	/*
+	 * save PMDs to context
+	 * release ownership
+	 */
+	pfm_flush_pmds(task, ctx);
+
+	pfm_arch_unload_context(ctx, task);
+
+	/*
+	 * at this point we are done with the PMU
+	 * so we can release the resource.
+	 *
+	 * when state was ZOMBIE, we have already released
+	 */
+	if (state != PFM_CTX_ZOMBIE && defer_release == 0)
+		pfm_release_session(ctx, ctx->cpu);
+
+	/*
+	 * reset activation counter
+	 */
+	ctx->last_act = PFM_INVALID_ACTIVATION;
+	pfm_set_last_cpu(ctx, -1);
+
+	/*
+	 * break links between context and task
+	 */
+	if (task) {
+		task->pfm_context = NULL;
+		ctx->task = NULL;
+	}
+	PFM_DBG("done, state was %d", state);
+	return 0;
+}
+
+static int pfm_ctx_flags_sane(u32 ctx_flags)
+{
+	/* valid signal */
+
+	if (ctx_flags & PFM_FL_SYSTEM_WIDE) {
+		/*
+		 * cannot block in this mode
+		 */
+		if (ctx_flags & PFM_FL_NOTIFY_BLOCK) {
+			PFM_DBG("cannot use blocking mode in syswide mode");
+			return -EINVAL;
+		}
+	}
+	/* probably more to add here */
+	return 0;
+}
+
+/*
+ * check for permissions to create a context
+ */
+static inline int pfm_ctx_permissions(u32 ctx_flags)
+{
+	if (  (ctx_flags & PFM_FL_SYSTEM_WIDE)
+	   && pfm_controls.sys_group != PFM_GROUP_PERM_ANY
+	   && !in_group_p(pfm_controls.sys_group)) {
+		PFM_DBG("user group not allowed to create a syswide ctx");
+		return -EPERM;
+	} else if (pfm_controls.task_group != PFM_GROUP_PERM_ANY
+		   && !in_group_p(pfm_controls.task_group)) {
+		PFM_DBG("user group not allowed to create a task context");
+		return -EPERM;
+	}
+	return 0;
+}
+
+int __pfm_create_context(struct pfarg_ctx *req,
+			 struct pfm_smpl_fmt *fmt,
+			 void *fmt_arg,
+			 int mode,
+			 struct completion *c,
+			 struct pfm_context **new_ctx)
+{
+	struct pfm_context *ctx;
+	struct pfm_event_set *set;
+	struct file *filp = NULL;
+	u32 ctx_flags;
+	int fd = 0, ret;
+
+	ctx_flags = req->ctx_flags;
+
+	if (mode == PFM_KAPI && c == NULL)
+		return -EINVAL;
+
+	/* Increase refcount on PMU description */
+	ret = pfm_pmu_conf_get(mode != PFM_KAPI);
+	if (ret < 0)
+		goto error_conf;
+
+	ret = pfm_ctx_flags_sane(ctx_flags);
+	if (ret < 0)
+		goto error_alloc;
+
+	ret = pfm_ctx_permissions(ctx_flags);
+	if (ret < 0)
+		goto error_alloc;
+
+	ret = -ENOMEM;
+	ctx = pfm_context_alloc();
+	if (!ctx)
+		goto error_alloc;
+
+	/*
+	 * link to format, must be done first for correct
+	 * error handling in pfm_context_free()
+	 */
+	ctx->smpl_fmt = fmt;
+
+	if (mode != PFM_KAPI) {
+		ret = -ENFILE;
+		fd = pfm_alloc_fd(&filp);
+		if (fd < 0)
+			goto error_file;
+	}
+
+	/*
+	 * context is unloaded
+	 */
+	ctx->state = PFM_CTX_UNLOADED;
+
+	/*
+	 * initialization of context's flags
+	 * must be done before pfm_find_set()
+	 */
+	ctx->flags.block = (ctx_flags & PFM_FL_NOTIFY_BLOCK) ? 1 : 0;
+	ctx->flags.system = (ctx_flags & PFM_FL_SYSTEM_WIDE) ? 1: 0;
+	ctx->flags.no_msg = (ctx_flags & PFM_FL_OVFL_NO_MSG) ? 1: 0;
+	ctx->flags.mapset = (ctx_flags & PFM_FL_MAP_SETS) ? 1: 0;
+	ctx->flags.trap_reason = PFM_TRAP_REASON_NONE;
+	ctx->flags.kapi = mode == PFM_KAPI;
+
+	INIT_LIST_HEAD(&ctx->list);
+
+	/*
+	 * initialize arch-specific section
+	 * must be done before fmt_init()
+	 *
+	 * XXX: fix dependency with fmt_init()
+	 * XXX: no return value
+	 */
+	pfm_arch_context_initialize(ctx, ctx_flags);
+
+	ret = -ENOMEM;
+	/*
+	 * create initial set
+	 */
+	if (pfm_find_set(ctx, 0, 1) == NULL)
+		goto error_set;
+
+	set = list_entry(ctx->list.next, struct pfm_event_set, list);
+
+	pfm_init_evtset(set);
+
+	/*
+	 * does the user want to sample?
+	 */
+	if (fmt) {
+		ret = pfm_setup_smpl_fmt(fmt, fmt_arg, ctx, ctx_flags,
+					 mode, filp);
+		if (ret)
+			goto error_set;
+	}
+
+	req->ctx_smpl_buf_size = ctx->smpl_size;
+
+	/*
+	 * attach context to file
+	 */
+	if (filp)
+		filp->private_data = ctx;
+
+	spin_lock_init(&ctx->lock);
+	init_completion(&ctx->restart_complete);
+
+	/*
+	 * activation is used in SMP only
+	 */
+	ctx->last_act = PFM_INVALID_ACTIVATION;
+	pfm_set_last_cpu(ctx, -1);
+
+	/*
+	 * initialize notification message queue
+	 */
+	ctx->msgq_head = ctx->msgq_tail = 0;
+	init_waitqueue_head(&ctx->msgq_wait);
+	ctx->msgq_comp = c;
+
+	PFM_DBG("ctx=%p flags=0x%x system=%d notify_block=%d no_msg=%d"
+		" use_fmt=%d remap=%d ctx_fd=%d mode=%d",
+		ctx,
+		ctx_flags,
+		ctx->flags.system,
+		ctx->flags.block,
+		ctx->flags.no_msg,
+		fmt != NULL,
+		ctx->flags.mapset,
+		fd, mode);
+
+	*new_ctx = ctx;
+
+	/*
+	 * we defer the fd_install until we are certain the call succeeded
+	 * to ensure we do not have to undo its effect. Neither put_filp()
+	 * nor put_unused_fd() undoes the effect of fd_install().
+	 */
+	if (mode != PFM_KAPI)
+		fd_install(fd, filp);
+
+	req->ctx_fd = fd;
+
+	return 0;
+
+error_set:
+	if (mode != PFM_KAPI) {
+		put_filp(filp);
+		put_unused_fd(fd);
+	}
+error_file:
+	/* calls the right *_put() functions */
+	pfm_context_free(ctx);
+	return ret;
+
+error_alloc:
+	pfm_pmu_conf_put();
+error_conf:
+	pfm_smpl_fmt_put(fmt);
+	return ret;
+}
+
+/*
+ * function invoked in case, pfm_context_create fails
+ * at the last operation, copy_to_user. It needs to
+ * undo memory allocations and free the file descriptor
+ */
+void pfm_undo_create_context_fd(int fd, struct pfm_context *ctx)
+{
+	struct files_struct *files = current->files;
+	struct file *file;
+
+	file = fget(fd);
+	/*
+	 * there is no fd_uninstall(), so we do it
+	 * here. put_unused_fd() does not remove the
+	 * effect of fd_install().
+	 */
+
+	spin_lock(&files->file_lock);
+	files->fd_array[fd] = NULL;
+	spin_unlock(&files->file_lock);
+
+	/*
+	 * undo the fget()
+	 */
+	fput(file);
+
+	/*
+	 * decrement ref count and kill file
+	 */
+	put_filp(file);
+
+	put_unused_fd(fd);
+
+	pfm_context_free(ctx);
+}
--- linux-2.6.17.1.orig/perfmon/perfmon_res.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17.1/perfmon/perfmon_res.c	2006-06-21 04:22:51.000000000 -0700
@@ -0,0 +1,278 @@
+/*
+ * perfmon_res.c:  perfmon2 resource allocations
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
+#include <linux/spinlock.h>
+#include <linux/perfmon.h>
+
+static struct pfm_sessions pfm_sessions;
+
+static __cacheline_aligned_in_smp DEFINE_SPINLOCK(pfm_sessions_lock);
+
+/*
+ * sampling buffer allocated by perfmon must be
+ * checked against max usage thresholds for security
+ * reasons.
+ *
+ * The first level check is against the system wide limit
+ * as indicated by the system administrator in /proc/sys/kernel/perfmon
+ *
+ * The second level check is on a per-process basis using
+ * RLIMIT_MEMLOCK limit.
+ *
+ * Operating on the current task only.
+ */
+int pfm_reserve_buf_space(size_t size)
+{
+	struct mm_struct *mm;
+	unsigned long locked;
+	size_t buf_mem, buf_mem_max;
+
+	spin_lock(&pfm_sessions_lock);
+
+	/*
+	 * check against global buffer limit
+	 */
+	buf_mem_max = pfm_controls.smpl_buf_size_max;
+	buf_mem = pfm_sessions.pfs_cur_smpl_buf_mem + size;
+
+	if (buf_mem <= buf_mem_max) {
+		pfm_sessions.pfs_cur_smpl_buf_mem = buf_mem;
+
+		PFM_DBG("buf_mem_max=%zu current_buf_mem=%zu",
+			buf_mem_max,
+			buf_mem);
+	}
+	spin_unlock(&pfm_sessions_lock);
+
+	if (buf_mem > buf_mem_max) {
+		PFM_DBG("smpl buffer memory threshold reached");
+		return -ENOMEM;
+	}
+
+	/*
+	 * check against RLIMIT_MEMLOCK
+	 */
+	mm = get_task_mm(current);
+
+	down_write(&mm->mmap_sem);
+
+	locked  = mm->locked_vm << PAGE_SHIFT;
+	locked += size;
+
+	if (locked > current->signal->rlim[RLIMIT_MEMLOCK].rlim_cur) {
+
+		PFM_DBG("RLIMIT_MEMLOCK reached ask_locked=%lu rlim_cur=%lu",
+			locked,
+			current->signal->rlim[RLIMIT_MEMLOCK].rlim_cur);
+
+		up_write(&mm->mmap_sem);
+		mmput(mm);
+		goto unres;
+	}
+
+	up_write(&mm->mmap_sem);
+
+	mmput(mm);
+
+	return 0;
+
+unres:
+	/*
+	 * remove global buffer memory allocation
+	 */
+	spin_lock(&pfm_sessions_lock);
+
+	pfm_sessions.pfs_cur_smpl_buf_mem -= size;
+
+	spin_unlock(&pfm_sessions_lock);
+
+	return -ENOMEM;
+}
+
+void pfm_release_buf_space(size_t size)
+{
+	struct mm_struct *mm;
+
+	mm = get_task_mm(current);
+	if (mm) {
+		down_write(&mm->mmap_sem);
+
+		mm->locked_vm -= size >> PAGE_SHIFT;
+
+		up_write(&mm->mmap_sem);
+
+		mmput(mm);
+	}
+
+	spin_lock(&pfm_sessions_lock);
+
+	pfm_sessions.pfs_cur_smpl_buf_mem -= size;
+
+	spin_unlock(&pfm_sessions_lock);
+}
+
+
+
+int pfm_reserve_session(struct pfm_context *ctx, u32 cpu)
+{
+	int is_system;
+
+	is_system = ctx->flags.system;
+
+	/*
+	 * validy checks on cpu_mask have been done upstream
+	 */
+	spin_lock(&pfm_sessions_lock);
+
+	PFM_DBG("in sys_sessions=%u task_sessions=%u syswide=%d cpu=%u",
+		pfm_sessions.pfs_sys_sessions,
+		pfm_sessions.pfs_task_sessions,
+		is_system,
+		cpu);
+
+	if (pfm_arch_reserve_session(&pfm_sessions, ctx, cpu))
+		goto abort;
+
+	if (is_system) {
+		/*
+		 * cannot mix system wide and per-task sessions
+		 */
+		if (pfm_sessions.pfs_task_sessions > 0) {
+			PFM_DBG("system wide imppossible, %u conflicting"
+				"task_sessions\n",
+			  	pfm_sessions.pfs_task_sessions);
+			goto abort_undo;
+		}
+
+		if (cpu_isset(cpu, pfm_sessions.pfs_sys_cpumask)) {
+			PFM_DBG("syswide not possible, conflicting session "
+				"on CPU%u\n", cpu);
+			goto abort_undo;
+		}
+
+		PFM_DBG("reserving syswide session on CPU%u currently "
+			"on CPU%u\n",
+			cpu,
+			smp_processor_id());
+
+		cpu_set(cpu, pfm_sessions.pfs_sys_cpumask);
+
+		pfm_sessions.pfs_sys_sessions++ ;
+
+	} else {
+		if (pfm_sessions.pfs_sys_sessions)
+			goto abort_undo;
+		pfm_sessions.pfs_task_sessions++;
+	}
+
+	PFM_DBG("out sys_sessions=%u task_sessions=%u syswide=%d cpu=%u",
+		pfm_sessions.pfs_sys_sessions,
+		pfm_sessions.pfs_task_sessions,
+		is_system,
+		cpu);
+
+	spin_unlock(&pfm_sessions_lock);
+
+	return 0;
+
+abort_undo:
+	/*
+	 * must undo arch-specific reservation
+	 */
+	pfm_arch_release_session(&pfm_sessions, ctx, cpu);
+abort:
+	spin_unlock(&pfm_sessions_lock);
+
+	return -EBUSY;
+}
+
+int pfm_release_session(struct pfm_context *ctx, u32 cpu)
+{
+	int is_system;
+
+	is_system = ctx->flags.system;
+
+	/*
+	 * validy checks on cpu_mask have been done upstream
+	 */
+	spin_lock(&pfm_sessions_lock);
+
+	PFM_DBG("in sys_sessions=%u task_sessions=%u syswide=%d cpu=%u",
+		pfm_sessions.pfs_sys_sessions,
+		pfm_sessions.pfs_task_sessions,
+		is_system, cpu);
+
+	if (is_system) {
+		cpu_clear(cpu, pfm_sessions.pfs_sys_cpumask);
+
+		pfm_sessions.pfs_sys_sessions--;
+	} else {
+		pfm_sessions.pfs_task_sessions--;
+	}
+
+	pfm_arch_release_session(&pfm_sessions, ctx, cpu);
+
+	PFM_DBG("out sys_sessions=%u task_sessions=%u syswide=%d cpu=%u",
+		pfm_sessions.pfs_sys_sessions,
+		pfm_sessions.pfs_task_sessions,
+		is_system, cpu);
+
+	spin_unlock(&pfm_sessions_lock);
+
+	return 0;
+}
+
+static struct _pfm_pmu_config empty_config={
+	.pmu_name = "Unknown",
+	.version = "0.0"
+};
+
+ssize_t pfm_sysfs_session_show(char *buf, size_t sz, int what)
+{
+	struct _pfm_pmu_config *p;
+	ssize_t ret = -EINVAL;
+
+	spin_lock(&pfm_sessions_lock);
+
+	if (pfm_pmu_conf)
+		p = pfm_pmu_conf;
+	else
+		p = &empty_config;
+
+	switch(what) {
+		case 0: ret = snprintf(buf, sz, "%s\n", p->pmu_name);
+			break;
+		case 1: ret = snprintf(buf, sz, "%d\n", p->counter_width);
+			break;
+		case 2: ret = snprintf(buf, sz, "%u\n", pfm_sessions.pfs_task_sessions);
+			break;
+		case 3: ret = snprintf(buf, sz, "%u\n", pfm_sessions.pfs_sys_sessions);
+			break;
+		case 4: ret = snprintf(buf, sz, "%zu\n", pfm_sessions.pfs_cur_smpl_buf_mem);
+			break;
+	}
+
+	spin_unlock(&pfm_sessions_lock);
+
+	return ret;
+}
