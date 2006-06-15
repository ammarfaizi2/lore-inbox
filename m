Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964989AbWFOJQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964989AbWFOJQy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 05:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbWFOJQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 05:16:11 -0400
Received: from ccerelbas03.cce.hp.com ([161.114.21.106]:1255 "EHLO
	ccerelbas03.cce.hp.com") by vger.kernel.org with ESMTP
	id S932437AbWFOJPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 05:15:16 -0400
Date: Thu, 15 Jun 2006 02:07:37 -0700
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200606150907.k5F97bKv008168@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 8/16] 2.6.17-rc6 perfmon2 patch for review: event set and multiplexing support
Cc: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the event set and multiplexing support.




--- linux-2.6.17-rc6.orig/perfmon/perfmon_sets.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17-rc6/perfmon/perfmon_sets.c	2006-06-13 05:56:21.000000000 -0700
@@ -0,0 +1,840 @@
+/*
+ * perfmon_sets.c: perfmon2 event sets and multiplexing functions
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
+#include <linux/perfmon.h>
+#include <linux/pagemap.h>
+
+static kmem_cache_t		*pfm_set_cachep;
+static kmem_cache_t		*pfm_lg_set_cachep;
+
+/*
+ * reload reference overflow switch thresholds
+ */
+static void pfm_reload_switch_thresholds(struct pfm_event_set *set)
+{
+	u64 *mask;
+	u16 i, max_cnt_pmd, first_cnt_pmd;
+
+	mask = set->used_pmds;
+	first_cnt_pmd = pfm_pmu_conf->first_cnt_pmd;
+	max_cnt_pmd = pfm_pmu_conf->max_cnt_pmd;
+
+	for (i = first_cnt_pmd; i< max_cnt_pmd; i++) {
+		if (pfm_bv_isset(mask, i)) {
+			set->pmds[i].ovflsw_thres = set->pmds[i].ovflsw_ref_thres;
+			PFM_DBG("pmd%u set=%u ovflsw_thres=%llu",
+				i,
+				set->id,
+				(unsigned long long)set->pmds[i].ovflsw_thres);
+		}
+	}
+}
+
+
+/*
+ * ensures that all id_next sets exists such that the round-robin
+ * will work correctly, i.e., next dangling references.
+ */
+int pfm_prepare_sets(struct pfm_context *ctx, struct pfm_event_set *act_set)
+{
+	struct pfm_event_set *set1, *set2;
+	u16 max_cnt_pmd;
+#define is_last_set(s, c)	((s)->list.next == &(c)->list)
+
+	max_cnt_pmd = pfm_pmu_conf->max_cnt_pmd;
+
+	list_for_each_entry(set1, &ctx->list, list) {
+
+		if (is_last_set(set1, ctx))
+			set2 = list_entry(ctx->list.next,
+					  struct pfm_event_set, list);
+		else
+			set2 = list_entry(set1->list.next,
+					  struct pfm_event_set, list);
+		/*
+		 * switch_next is used during actual switching
+		 * so we prepare its value here. When no explicit next
+		 * is requested, the field is initialized with the address
+		 * of the next element in the ordered list
+		 */
+		if (set1->flags & PFM_SETFL_EXPL_NEXT) {
+			list_for_each_entry(set2, &ctx->list, list) {
+				if (set2->id == set1->id_next)
+					break;
+			}
+			if (set2 == NULL) {
+				PFM_DBG("set%u points to set%u "
+					"which does not exist",
+					set1->id,
+					set1->id_next);
+				return -EINVAL;
+			}
+		}
+		/*
+		 * update field used during actual switching
+		 */
+		set1->sw_next = set2;
+
+		PFM_DBG("set%u sw_next=%u", set1->id, set2->id);
+
+		/*
+		 * cleanup bitvectors
+		 */
+		bitmap_zero(ulp(set1->ovfl_pmds), max_cnt_pmd);
+		bitmap_zero(ulp(set1->povfl_pmds), max_cnt_pmd);
+		set1->npend_ovfls = 0;
+		/*
+		 * we cannot just use plain clear because of arch-specific flags
+		 */
+		set1->priv_flags &= ~(PFM_SETFL_PRIV_MOD_BOTH|PFM_SETFL_PRIV_SWITCH);
+
+		/*
+		 * reset activation and elapsed cycles
+		 */
+		set1->duration = 0;
+
+		pfm_modview_begin(set1);
+
+		set1->view->set_runs = 0;
+
+		pfm_modview_end(set1);
+	}
+	/*
+	 * setting PFM_CPUINFO_TIME_SWITCH, triggers
+	 * further checking if __pfm_handle_switch_timeout().
+	 * switch timeout is effectively decremented only when
+	 * monitoring has been activated via pfm_start() or
+	 * any user level equivalent.
+	 */
+	if (act_set->flags & PFM_SETFL_OVFL_SWITCH) {
+		pfm_reload_switch_thresholds(act_set);
+	} else if (act_set->flags & PFM_SETFL_TIME_SWITCH) {
+		act_set->timeout = act_set->switch_timeout;
+		PFM_DBG("arming timeout for set%u", act_set->id);
+		if (ctx->flags.system)
+			__get_cpu_var(pfm_syst_info) = PFM_CPUINFO_TIME_SWITCH;
+	}
+
+	return 0;
+}
+
+/*
+ * called from *_timer_interrupt(). task == current
+ */
+void __pfm_handle_switch_timeout(void)
+{
+	struct pfm_event_set *set;
+	struct pfm_context *ctx;
+	unsigned long flags;
+
+	/*
+	 * The timer tick check is operating on each
+	 * CPU. Not all CPUs have time switching enabled
+	 * hence we need to check.
+	 */
+	ctx  = __get_cpu_var(pmu_ctx);
+	if (ctx == NULL)
+		return;
+
+	spin_lock_irqsave(&ctx->lock, flags);
+
+	set = ctx->active_set;
+	BUG_ON(set == NULL);
+
+	/*
+	 * we decrement only when attached and not masked or zombie
+	 */
+	if (ctx->state != PFM_CTX_LOADED)
+		goto done;
+
+	/*
+	 * do not decrement timeout unless monitoring is active.
+	 */
+	if (ctx->flags.started == 0 && pfm_arch_is_active(ctx) == 0)
+		goto done;
+
+	set->timeout--;
+
+	__get_cpu_var(pfm_stats).pfm_handle_timeout_count++;
+
+	if (set->timeout == 0)
+		pfm_switch_sets(ctx, NULL, PFM_PMD_RESET_SHORT, 0);
+done:
+	spin_unlock_irqrestore(&ctx->lock, flags);
+}
+
+/*
+ *
+ * always operating on the current task
+ *
+ * input:
+ * 	- new_set: new set to switch to, if NULL follow normal chain
+ */
+void pfm_switch_sets(struct pfm_context *ctx,
+		    struct pfm_event_set *new_set,
+		    int reset_mode,
+		    int no_restart)
+{
+	struct pfm_event_set *set;
+	u64 switch_count;
+	u64 now_itc, end_itc;
+	unsigned long info = 0;
+	u32 new_flags;
+	int is_system, state, is_active;
+
+	now_itc = pfm_arch_get_itc();
+	set = ctx->active_set;
+	is_active = ctx->flags.started || pfm_arch_is_active(ctx);
+
+	BUG_ON(ctx->flags.system == 0 && ctx->task != current);
+
+	/*
+	 * if no set is explicitely requested,
+	 * use the set_switch_next field
+	 */
+	if (new_set == NULL) {
+		/*
+	 	 * we use round-robin unless the user specified
+		 * a particular set to go to.
+	 	 */
+		new_set = set->sw_next;
+		BUG_ON(new_set == NULL);
+	}
+
+	PFM_DBG("state=%d prev_set=%u prev_runs=%llu new_set=%u "
+		  "new_runs=%llu reset_mode=%d",
+		  ctx->state,
+		  set->id,
+		  (unsigned long long)set->view->set_runs,
+		  new_set->id,
+		  (unsigned long long)new_set->view->set_runs,
+		  reset_mode);
+
+	/*
+	 * nothing more to do
+	 */
+	if (new_set == set)
+		return;
+
+	is_system = ctx->flags.system;
+	state = ctx->state;
+	new_flags = new_set->flags;
+	switch_count = __get_cpu_var(pfm_stats).pfm_set_switch_count;
+
+	pfm_modview_begin(set);
+
+	new_set->view->set_runs++;
+
+	if (is_active) {
+		/*
+		 * stop current set
+		 */
+		if (is_system)
+			info = __get_cpu_var(pfm_syst_info);
+
+		pfm_arch_stop(current, ctx, set);
+
+		pfm_arch_save_pmds(ctx, set);
+
+		/*
+	 	 * compute elapsed cycles for active set
+	 	 */
+		set->duration += now_itc - set->duration_start;
+		set->view->set_status &= ~PFM_SETVFL_ACTIVE;
+
+	}
+	pfm_modview_end(set);
+
+	switch_count++;
+
+	pfm_arch_restore_pmds(ctx, new_set);
+
+	/*
+	 * if masked, we must restore the pmcs such that they
+	 * do not capture anything.
+	 */
+	pfm_arch_restore_pmcs(ctx, new_set);
+
+	new_set->priv_flags &= ~PFM_SETFL_PRIV_MOD_BOTH;
+
+	/*
+	 * reload switch threshold
+	 */
+	if (new_flags & PFM_SETFL_OVFL_SWITCH)
+		pfm_reload_switch_thresholds(new_set);
+
+	/*
+	 * reset timeout for new set
+	 */
+	if (new_flags & PFM_SETFL_TIME_SWITCH)
+		new_set->timeout = new_set->switch_timeout;
+
+	/*
+	 * reset overflowed PMD registers
+	 */
+	if (reset_mode != PFM_PMD_RESET_NONE)
+		pfm_reset_pmds(ctx, new_set, reset_mode);
+
+	/*
+	 * this is needed when coming from pfm_start()
+	 */
+	if (no_restart)
+		goto skip_restart;
+
+	/*
+	 * reactivate monitoring
+	 */
+	if (is_system) {
+		info  &= ~PFM_CPUINFO_TIME_SWITCH;
+
+		if (new_flags & PFM_SETFL_TIME_SWITCH)
+			info |= PFM_CPUINFO_TIME_SWITCH;
+
+		__get_cpu_var(pfm_syst_info) = info;
+
+		PFM_DBG("new_set=%u info=0x%lx flags=0x%x",
+			new_set->id,
+			info,
+			new_flags);
+
+		if (is_active && (current->pid != 0 || (new_flags & PFM_SETFL_EXCL_IDLE) == 0))
+			pfm_arch_start(current, ctx, new_set);
+	} else {
+		if (is_active)
+			pfm_arch_start(current, ctx, new_set);
+	}
+
+	if (is_active)
+		new_set->duration_start = now_itc;
+
+skip_restart:
+	end_itc = pfm_arch_get_itc();
+	ctx->active_set = new_set;
+	new_set->view->set_status |= PFM_SETVFL_ACTIVE;
+
+	__get_cpu_var(pfm_stats).pfm_set_switch_count   = switch_count;
+	__get_cpu_var(pfm_stats).pfm_set_switch_cycles += end_itc - now_itc;
+}
+
+static int pfm_setfl_sane(struct pfm_context *ctx, u32 flags)
+{
+#define PFM_SETFL_BOTH_SWITCH	(PFM_SETFL_OVFL_SWITCH|PFM_SETFL_TIME_SWITCH)
+	int ret;
+
+	ret = pfm_arch_setfl_sane(ctx, flags);
+	if (ret)
+		return ret;
+
+	if ((flags & PFM_SETFL_BOTH_SWITCH) == PFM_SETFL_BOTH_SWITCH) {
+		PFM_DBG("both switch ovfl and switch time are set");
+		return -EINVAL;
+	}
+
+	if ((flags & PFM_SETFL_EXCL_IDLE) != 0 && ctx->flags.system == 0) {
+		PFM_DBG("excl idle is for system wide only");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+/*
+ * it is never possible to change the identification of an existing set
+ */
+static int __pfm_change_evtset(struct pfm_context *ctx,
+				  struct pfm_event_set *set,
+				  struct pfarg_setdesc *req)
+{
+	u32 flags;
+	u16 set_id, set_id_next;
+	unsigned long ji;
+	int ret;
+
+	BUG_ON(ctx->state == PFM_CTX_LOADED);
+
+	set_id = req->set_id;
+	set_id_next = req->set_id_next;
+	flags = req->set_flags;
+
+	ret = pfm_setfl_sane(ctx, flags);
+	if (ret) {
+		PFM_DBG("invalid flags 0x%x set %u", flags, set_id);
+		return -EINVAL;
+	}
+
+	/*
+	 * commit changes
+	 *
+	 * note that we defer checking the validity of set_id_next until the
+	 * context is actually attached. This is the only moment where we can
+	 * safely assess the sanity of the sets because sets cannot be changed
+	 * or deleted once the context is attached
+	 */
+	set->id = set_id;
+	set->id_next = set_id_next;
+	set->flags = flags;
+	set->priv_flags = 0;
+	set->sw_next = NULL;
+
+	/*
+	 * XXX: what about set_priv_flags
+	 */
+
+	/*
+	 * reset pointer to next set
+	 */
+	set->sw_next = NULL;
+
+	ji = usecs_to_jiffies(req->set_timeout);
+
+	/*
+	 * verify that timeout is not 0
+	 */
+	if (ji == 0 && (flags & PFM_SETFL_TIME_SWITCH) != 0) {
+		PFM_DBG("invalid timeout=0");
+		return -EINVAL;
+	}
+
+	set->switch_timeout = set->timeout = ji;
+
+	/*
+	 * return actual timeout in usecs
+	 */
+	req->set_timeout = jiffies_to_usecs(ji);
+
+	PFM_DBG("set %u flags=0x%x id_next=%u req_usec=%u"
+		"jiffies=%lu runs=%llu HZ=%u TICK_NSEC=%lu eff_usec=%u",
+		set_id,
+		flags,
+		set_id_next,
+		req->set_timeout,
+		ji,
+		(unsigned long long)set->view->set_runs,
+		HZ, TICK_NSEC,
+		req->set_timeout);
+
+	return 0;
+}
+
+/*
+ * this function does not modify the next field
+ */
+void pfm_init_evtset(struct pfm_event_set *set)
+{
+	u64 *impl_pmcs;
+	u16 i, max_pmc;
+
+	max_pmc = pfm_pmu_conf->max_pmc;
+	impl_pmcs =  pfm_pmu_conf->impl_pmcs;
+
+	/*
+	 * install default values for all PMC  registers
+	 */
+	for (i=0; i < max_pmc;  i++) {
+		if (pfm_bv_isset(impl_pmcs, i)) {
+			set->pmcs[i] = pfm_pmu_conf->pmc_desc[i].dfl_val;
+			PFM_DBG("set%u pmc%u=0x%llx",
+				set->id,
+				i,
+				(unsigned long long)set->pmcs[i]);
+		}
+	}
+
+	/*
+	 * PMD registers are set to 0 when the event set is allocated,
+	 * hence we do not need to explicitely initialize them.
+	 *
+	 * For virtual PMD registers (i.e., those tied to a SW resource)
+	 * their value becomes meaningful once the context is attached.
+	 */
+}
+
+struct pfm_event_set *pfm_find_set(struct pfm_context *ctx, u16 set_id,
+					  int alloc)
+{
+	kmem_cache_t *cachep;
+	struct pfm_event_set *set, *new_set, *prev;
+	unsigned long offs;
+	size_t view_size;
+	void *view;
+
+	PFM_DBG("looking for set=%u", set_id);
+
+	/*
+	 * shortcut for set 0: always exist, cannot be removed
+	 */
+	if (set_id == 0 && alloc == 0)
+		return list_entry(ctx->list.next, struct pfm_event_set, list);
+
+	prev = NULL;
+	list_for_each_entry(set, &ctx->list, list) {
+		if (set->id == set_id)
+			return set;
+		if (set->id > set_id)
+			break;
+		prev = set;
+	}
+
+	if (alloc == 0)
+		return NULL;
+
+	cachep = ctx->flags.mapset ? pfm_set_cachep : pfm_lg_set_cachep;
+
+	new_set = kmem_cache_alloc(cachep, SLAB_ATOMIC);
+	if (new_set) {
+		memset(new_set, 0, sizeof(*set));
+
+		if (ctx->flags.mapset) {
+			view_size = PAGE_ALIGN(sizeof(struct pfm_set_view));
+			view      = vmalloc(view_size);
+			if (view == NULL) {
+				PFM_DBG("cannot allocate set view");
+				kmem_cache_free(cachep, new_set);
+				return NULL;
+			}
+			offs = PFM_SET_REMAP_BASE
+			     + (set_id*PFM_SET_REMAP_SCALAR);
+		} else {
+			view_size = sizeof(struct pfm_set_view);
+			view = (struct pfm_set_view *)(new_set+1);
+			offs = 0;
+		}
+		
+		memset(view, 0, sizeof(struct pfm_set_view));
+
+		new_set->id = set_id;
+		new_set->view = view;
+		new_set->mmap_offset = offs;
+
+		INIT_LIST_HEAD(&new_set->list);
+
+		if (prev == NULL) {
+			list_add(&(new_set->list), &ctx->list);
+		} else {
+			PFM_DBG("add after set=%u", prev->id);
+			list_add(&(new_set->list), &prev->list);
+		}
+		PFM_DBG("set_id=%u size=%zu view=%p remap=%d mmap_offs=%lu",
+			set_id,
+			view_size,
+			view,
+			ctx->flags.mapset,
+			new_set->mmap_offset);
+	}
+	return new_set;
+}
+
+
+/*
+ * context is unloaded for this command. Interrupts are enabled
+ */
+int __pfm_create_evtsets(struct pfm_context *ctx, struct pfarg_setdesc *req,
+			int count)
+{
+	struct pfm_event_set *set;
+	u16 set_id;
+	int i, ret;
+
+	for (i = 0; i < count; i++, req++) {
+		set_id = req->set_id;
+
+		PFM_DBG("set_id=%u", set_id);
+
+		set = pfm_find_set(ctx, set_id, 1);
+		if (set == NULL)
+			goto error_mem;
+
+		ret = __pfm_change_evtset(ctx, set, req);
+		if (ret)
+			goto error_params;
+
+		pfm_init_evtset(set);
+	}
+	return 0;
+error_mem:
+	PFM_DBG("cannot allocate set %u", set_id);
+	pfm_retflag_set(req->set_flags, PFM_REG_RETFL_EINVAL);
+	return -ENOMEM;
+error_params:
+	pfm_retflag_set(req->set_flags, PFM_REG_RETFL_EINVAL);
+	return ret;
+}
+
+int __pfm_getinfo_evtsets(struct pfm_context *ctx, struct pfarg_setinfo *req,
+				 int count)
+{
+	struct pfm_event_set *set;
+	int i, is_system, is_loaded;
+	u16 set_id;
+	int max_cnt_pmd;
+	u64 end_cycles;
+
+	end_cycles = pfm_arch_get_itc();
+	is_system = ctx->flags.system;
+	is_loaded = ctx->state == PFM_CTX_LOADED;
+	max_cnt_pmd = pfm_pmu_conf->max_cnt_pmd;
+
+	for (i = 0; i < count; i++, req++) {
+
+		set_id = req->set_id;
+
+		PFM_DBG("set_id=%u", set_id);
+
+		list_for_each_entry(set, &ctx->list, list) {
+			if (set->id == set_id)
+				goto found;
+			if (set->id > set_id)
+				goto error;
+		}
+found:
+		/*
+		 * compute leftover timeout
+		 */
+
+		req->set_flags = set->flags;
+		req->set_timeout = jiffies_to_usecs(set->timeout);
+		req->set_runs = set->view->set_runs;
+		req->set_act_duration = set->duration;
+		req->set_mmap_offset = set->mmap_offset;
+
+		/*
+		 * adjust for active set if needed
+		 */
+		if (is_system && is_loaded && ctx->flags.started
+		    && set == ctx->active_set)
+			req->set_act_duration  += end_cycles
+						- set->duration_start;
+
+		/*
+		 * copy the list of pmds which last overflowed for
+		 * the set
+		 */
+		bitmap_copy(ulp(req->set_ovfl_pmds),
+			    ulp(set->ovfl_pmds),
+			    max_cnt_pmd);
+
+		/*
+		 * copy bitmask of available PMU registers
+		 */
+		bitmap_copy(ulp(req->set_avail_pmcs),
+			    ulp(pfm_pmu_conf->impl_pmcs),
+			    pfm_pmu_conf->max_pmc);
+
+		bitmap_copy(ulp(req->set_avail_pmds),
+			    ulp(pfm_pmu_conf->impl_pmds),
+			    pfm_pmu_conf->max_pmd);
+
+		pfm_retflag_set(req->set_flags, 0);
+
+		PFM_DBG("set %u flags=0x%x eff_usec=%u runs=%llu",
+			set_id,
+			set->flags,
+			req->set_timeout,
+			(unsigned long long)set->view->set_runs);
+	}
+	return 0;
+error:
+	PFM_DBG("set %u not found", set_id);
+	pfm_retflag_set(req->set_flags, PFM_REG_RETFL_EINVAL);
+	return -EINVAL;
+}
+
+/*
+ * context is unloaded for this command. Interrupts are enabled
+ */
+int __pfm_delete_evtsets(struct pfm_context *ctx, void *arg, int count)
+{
+	struct pfarg_setdesc *req = arg;
+	struct pfm_event_set *set;
+	kmem_cache_t *cachep;
+	u16 set_id;
+	size_t view_size;
+	int i;
+
+	/* delete operation only works when context is detached */
+	BUG_ON(ctx->state != PFM_CTX_UNLOADED);
+
+	view_size = PAGE_ALIGN(sizeof(struct pfm_set_view));
+
+	if (ctx->flags.mapset)
+		cachep = pfm_set_cachep;
+	else
+		cachep = pfm_lg_set_cachep;
+
+	for (i = 0; i < count; i++, req++) {
+		set_id = req->set_id;
+
+		/*
+		 * cannot remove set 0
+		 */
+		if (set_id == 0)
+			goto error;
+
+		list_for_each_entry(set, &ctx->list, list) {
+			if (set->id == set_id)
+				goto found;
+			if (set->id > set_id)
+				goto error;
+		}
+		goto error;
+found:
+		/*
+		 * clear active set if necessary.
+		 * will be updated when context is loaded
+		 */
+		if (set == ctx->active_set)
+			ctx->active_set = NULL;
+
+		list_del(&set->list);
+
+		vfree(set->view);
+		kmem_cache_free(cachep, set);
+
+		pfm_retflag_set(req->set_flags, 0);
+
+		PFM_DBG("deleted set_id=%u", set_id);
+	}
+	return 0;
+error:
+	PFM_DBG("set_id=%u not found or invalid", set_id);
+	pfm_retflag_set(req->set_flags, PFM_REG_RETFL_EINVAL);
+	return -EINVAL;
+}
+
+/*
+ * called from pfm_context_free() to free all sets
+ */
+void pfm_free_sets(struct pfm_context *ctx)
+{
+	struct pfm_event_set *set, *tmp;
+	kmem_cache_t *cachep;
+	int use_remap;
+
+	use_remap = ctx->flags.mapset;
+
+	if (use_remap)
+		cachep = pfm_set_cachep;
+	else
+		cachep = pfm_lg_set_cachep;
+
+	list_for_each_entry_safe(set, tmp, &ctx->list, list) {
+		list_del(&set->list);
+		if (use_remap)
+			vfree(set->view);
+		kmem_cache_free(cachep, set);
+	}
+}
+
+int pfm_sets_init(void)
+{
+
+	pfm_lg_set_cachep = kmem_cache_create("pfm_large_event_set",
+			sizeof(struct pfm_event_set)+sizeof(struct pfm_set_view),
+			SLAB_HWCACHE_ALIGN, 0, NULL, NULL);
+	if (pfm_lg_set_cachep == NULL) {
+		PFM_ERR("cannot initialize large event set slab");
+		return -ENOMEM;
+	}
+
+	pfm_set_cachep = kmem_cache_create("pfm_event_set",
+			sizeof(struct pfm_event_set),
+			SLAB_HWCACHE_ALIGN, 0, NULL, NULL);
+	if (pfm_set_cachep == NULL) {
+		PFM_ERR("cannot initialize event set slab");
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+static struct page *pfm_view_map_pagefault(struct vm_area_struct *vma,
+					   unsigned long address, int *type)
+{
+	void *kaddr;
+	struct page *page;
+
+	kaddr = vma->vm_private_data;
+	if (kaddr == NULL) {
+		PFM_DBG("no view");
+		return NOPAGE_SIGBUS;
+	}
+
+	if ( (address < (unsigned long) vma->vm_start) ||
+	     (address > (unsigned long) (vma->vm_start + PAGE_SIZE)) )
+		return NOPAGE_SIGBUS;
+
+	kaddr += (address - vma->vm_start);
+
+	if (type)
+		*type = VM_FAULT_MINOR;
+
+	page = vmalloc_to_page(kaddr);
+	get_page(page);
+
+	PFM_DBG("[%d] start=%p ref_count=%d",
+		  current->pid,
+		  kaddr, page_count(page));
+
+	return page;
+}
+struct vm_operations_struct pfm_view_map_vm_ops = {
+	.nopage	= pfm_view_map_pagefault,
+};
+
+int pfm_mmap_set(struct pfm_context *ctx, struct vm_area_struct *vma,
+		 size_t size)
+{
+	struct pfm_event_set *set;
+	u16 set_id;
+
+	if (ctx->flags.mapset == 0) {
+		PFM_DBG("context does not use set remapping");
+		return -EINVAL;
+	}
+
+	if (vma->vm_pgoff < PFM_SET_REMAP_OFFS
+			|| vma->vm_pgoff >= PFM_SET_REMAP_OFFS_MAX) {
+		PFM_DBG("invalid offset %lu", vma->vm_pgoff);
+		return -EINVAL;
+	}
+
+	if (size != PAGE_SIZE) {
+		PFM_DBG("size %zu must be page size", size);
+		return -EINVAL;
+	}
+
+	set_id = (u16)(vma->vm_pgoff - PFM_SET_REMAP_OFFS);
+	set = pfm_find_set(ctx, set_id, 0);
+	if (set == NULL) {
+		PFM_DBG("set=%u is undefined", set_id);
+		return -EINVAL;
+	}
+
+	PFM_DBG("mmaping set_id=%u", set_id);
+
+	vma->vm_ops = &pfm_view_map_vm_ops;
+	vma->vm_private_data = set->view;
+
+	return 0;
+}
