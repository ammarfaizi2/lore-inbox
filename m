Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932865AbWJIOML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932865AbWJIOML (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 10:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932901AbWJIOLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 10:11:48 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:28913 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S932865AbWJIOLB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 10:11:01 -0400
Date: Mon, 9 Oct 2006 07:10:16 -0700
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200610091410.k99EAGnV026116@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 09/21] 2.6.18 perfmon2 : register read-write operations
Cc: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@frankl.hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the core read-write operations on the PMU registers


The patch contains the following functions:


__pfm_write_pmds(): implements write operations on a vector of PMD registers
__pfm_read_pmds() : implements read operations on a vector of PMD registers
__pfm_write_pmcs(): implements write operations on a vector of PMC registers


There is no read operation on PMC because they are always set by the users.
On some architectures, such as IA-64, Tsome PMCs may be set by hardware, but
they are never exposed to users.




--- linux-2.6.18.base/perfmon/perfmon_rw.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.18/perfmon/perfmon_rw.c	2006-09-25 12:10:35.000000000 -0700
@@ -0,0 +1,587 @@
+/*
+ * perfmon.c: perfmon2 PMC/PMD read/write system calls
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
+ * 	http://perfmon2.sf.net/
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
+#include <linux/kernel.h>
+#include <linux/perfmon.h>
+
+#define PFM_REGFL_PMC_ALL	(PFM_REGFL_NO_EMUL64|PFM_REG_RETFL_MASK)
+#define PFM_REGFL_PMD_ALL	(PFM_REGFL_RANDOM     | \
+				 PFM_REGFL_OVFL_NOTIFY| \
+				 PFM_REG_RETFL_MASK)
+
+int __pfm_write_pmds(struct pfm_context *ctx, struct pfarg_pmd *req, int count,
+		     int compat)
+{
+	struct pfm_event_set *set, *active_set;
+	u64 value, hw_val, ovfl_mask;
+	u64 *smpl_pmds, *reset_pmds, *impl_pmds;
+	u32 req_flags, flags;
+	u16 cnum, pmd_type, max_pmd, max_pmc;
+	u16 set_id, prev_set_id;
+	int i, can_access_pmu;
+	int is_counting;
+	int ret, error_code;
+	pfm_pmd_check_t	wr_func;
+
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
+			       || ctx->flags.system;
+
+	error_code = PFM_REG_RETFL_EINVAL;
+	ret = -EINVAL;
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
+		if (likely(!compat)) {
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
+				if (unlikely(!bitmap_subset(ulp(smpl_pmds),
+							   ulp(impl_pmds),
+							   max_pmd))) {
+					PFM_DBG("invalid smpl_pmds=0x%llx "
+						"for pmd%u",
+						(unsigned long long)smpl_pmds[0],
+						cnum);
+					goto error;
+				}
+				/*
+				 * verify validity of reset_pmds
+				 */
+				if (unlikely(!bitmap_subset(ulp(reset_pmds),
+							   ulp(impl_pmds),
+							   max_pmd))) {
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
+		if (likely(wr_func && (pmd_type & PFM_REG_WC))) {
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
+			if (likely(!compat)) {
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
+				if (pfm_bv_isset(set->povfl_pmds, cnum)) {
+					set->npend_ovfls--;
+					pfm_bv_clear(set->povfl_pmds, cnum);
+				}
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
+	struct pfm_event_set *set, *active_set;
+	u64 value, dfl_val, rsvd_msk;
+	u64 *impl_pmcs;
+	int i, can_access_pmu;
+	int ret, error_code;
+	u16 set_id, prev_set_id;
+	u16 cnum, pmc_type, max_pmc;
+	u32 flags;
+	pfm_pmc_check_t	wr_func;
+
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
+			        || ctx->flags.system;
+
+	error_code  = PFM_REG_RETFL_EINVAL;
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
+		if (flags & ~PFM_REGFL_PMC_ALL) {
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
+		 * (reserved bits must be zero in rsvd_msk)
+		 */
+		value = (value & rsvd_msk) | (dfl_val & ~rsvd_msk);
+
+		if (flags & PFM_REGFL_NO_EMUL64) {
+			if (!(pmc_type & PFM_REG_NO64)) {
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
+		if (likely(wr_func && (pmc_type & PFM_REG_WC))) {
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
+		 * the PMC needs to be modified for particular bits, especially
+		 * on overflow or to stop/start.
+		 */
+		if (!pfm_bv_isset(set->used_pmcs, cnum)) {
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
+	int error_code;
+	u16 cnum, pmd_type, set_id, prev_set_id, max_pmd;
+
+	ovfl_mask = pfm_pmu_conf->ovfl_mask;
+	impl_pmds = pfm_pmu_conf->impl_pmds;
+	max_pmd   = pfm_pmu_conf->max_pmd;
+	active_set = ctx->active_set;
+	set = NULL;
+	prev_set_id = 0;
+
+	if (likely(ctx->state == PFM_CTX_LOADED)) {
+		can_access_pmu = __get_cpu_var(pmu_owner) == ctx->task
+			       || ctx->flags.system;
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
+		if (unlikely(!pfm_bv_isset(set->used_pmds, cnum))) {
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
