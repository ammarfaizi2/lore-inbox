Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262023AbVCaWPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbVCaWPF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 17:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262026AbVCaWPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 17:15:04 -0500
Received: from aun.it.uu.se ([130.238.12.36]:18110 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262023AbVCaWKM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 17:10:12 -0500
Date: Fri, 1 Apr 2005 00:09:49 +0200 (MEST)
Message-Id: <200503312209.j2VM9nCe011940@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH 2.6.12-rc1-mm5 3/3] perfctr: ppc64 driver core
Cc: anton@samba.org, linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ppc64 perfctr driver from David Gibson <david@gibson.dropbear.id.au>:
- ppc64 perfctr driver core

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 drivers/perfctr/ppc64.c       |  743 ++++++++++++++++++++++++++++++++++++++++++
 drivers/perfctr/ppc64_tests.c |  322 ++++++++++++++++++
 drivers/perfctr/ppc64_tests.h |   12 
 include/asm-ppc64/perfctr.h   |  166 +++++++++
 4 files changed, 1243 insertions(+)

diff -rupN linux-2.6.12-rc1-mm4/drivers/perfctr/ppc64.c linux-2.6.12-rc1-mm4.perfctr-ppc64-driver/drivers/perfctr/ppc64.c
--- linux-2.6.12-rc1-mm4/drivers/perfctr/ppc64.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.12-rc1-mm4.perfctr-ppc64-driver/drivers/perfctr/ppc64.c	2005-03-31 23:37:37.000000000 +0200
@@ -0,0 +1,743 @@
+/*
+ * PPC64 performance-monitoring counters driver.
+ *
+ * based on Mikael Pettersson's 32 bit ppc code
+ * Copyright (C) 2004  David Gibson, IBM Corporation.
+ * Copyright (C) 2004  Mikael Pettersson
+ */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/fs.h>
+#include <linux/perfctr.h>
+#include <asm/prom.h>
+#include <asm/time.h>		/* tb_ticks_per_jiffy */
+#include <asm/pmc.h>
+#include <asm/cputable.h>
+
+#include "ppc64_tests.h"
+
+extern void ppc64_enable_pmcs(void); 
+
+/* Support for lazy perfctr SPR updates. */
+struct per_cpu_cache {	/* roughly a subset of perfctr_cpu_state */
+	unsigned int id;	/* cache owner id */
+	/* Physically indexed cache of the MMCRs. */
+	unsigned long ppc64_mmcr0, ppc64_mmcr1, ppc64_mmcra;
+};
+static DEFINE_PER_CPU(struct per_cpu_cache, per_cpu_cache);
+#define __get_cpu_cache(cpu) (&per_cpu(per_cpu_cache, cpu))
+#define get_cpu_cache()	(&__get_cpu_var(per_cpu_cache))
+
+/* Structure for counter snapshots, as 32-bit values. */
+struct perfctr_low_ctrs {
+	unsigned int tsc;
+	unsigned int pmc[8];
+};
+
+static unsigned int new_id(void)
+{
+	static DEFINE_SPINLOCK(lock);
+	static unsigned int counter;
+	int id;
+
+	spin_lock(&lock);
+	id = ++counter;
+	spin_unlock(&lock);
+	return id;
+}
+
+static inline unsigned int read_pmc(unsigned int pmc)
+{
+	switch (pmc) {
+	case 0:
+		return mfspr(SPRN_PMC1);
+		break;
+	case 1:
+		return mfspr(SPRN_PMC2);
+		break;
+	case 2:
+		return mfspr(SPRN_PMC3);
+		break;
+	case 3:
+		return mfspr(SPRN_PMC4);
+		break;
+	case 4:
+		return mfspr(SPRN_PMC5);
+		break;
+	case 5:
+		return mfspr(SPRN_PMC6);
+		break;
+	case 6:
+		return mfspr(SPRN_PMC7);
+		break;
+	case 7:
+		return mfspr(SPRN_PMC8);
+		break;
+
+	default: 
+		return -EINVAL;
+	}
+}
+
+static inline void write_pmc(int pmc, s32 val)
+{
+	switch (pmc) {
+	case 0:
+		mtspr(SPRN_PMC1, val);
+		break;
+	case 1:
+		mtspr(SPRN_PMC2, val);
+		break;
+	case 2:
+		mtspr(SPRN_PMC3, val);
+		break;
+	case 3:
+		mtspr(SPRN_PMC4, val);
+		break;
+	case 4:
+		mtspr(SPRN_PMC5, val);
+		break;
+	case 5:
+		mtspr(SPRN_PMC6, val);
+		break;
+	case 6:
+		mtspr(SPRN_PMC7, val);
+		break;
+	case 7:
+		mtspr(SPRN_PMC8, val);
+		break;
+	}
+}
+
+#ifdef CONFIG_PERFCTR_INTERRUPT_SUPPORT
+static void perfctr_default_ihandler(unsigned long pc)
+{
+	unsigned int mmcr0 = mfspr(SPRN_MMCR0);
+
+	mmcr0 &= ~MMCR0_PMXE;
+	mtspr(SPRN_MMCR0, mmcr0);
+}
+
+static perfctr_ihandler_t perfctr_ihandler = perfctr_default_ihandler;
+
+void do_perfctr_interrupt(struct pt_regs *regs)
+{
+	unsigned long mmcr0;
+
+	/* interrupts are disabled here, so we don't need to
+	 * preempt_disable() */
+
+	(*perfctr_ihandler)(instruction_pointer(regs));
+
+	/* clear PMAO so the interrupt doesn't reassert immediately */
+	mmcr0 = mfspr(SPRN_MMCR0) & ~MMCR0_PMAO;
+	mtspr(SPRN_MMCR0, mmcr0);
+}
+
+void perfctr_cpu_set_ihandler(perfctr_ihandler_t ihandler)
+{
+	perfctr_ihandler = ihandler ? ihandler : perfctr_default_ihandler;
+}
+
+#else
+#define perfctr_cstatus_has_ictrs(cstatus)	0
+#endif
+
+
+#if defined(CONFIG_SMP) && defined(CONFIG_PERFCTR_INTERRUPT_SUPPORT)
+
+static inline void
+set_isuspend_cpu(struct perfctr_cpu_state *state, int cpu)
+{
+	state->isuspend_cpu = cpu;
+}
+
+static inline int
+is_isuspend_cpu(const struct perfctr_cpu_state *state, int cpu)
+{
+	return state->isuspend_cpu == cpu;
+}
+
+static inline void clear_isuspend_cpu(struct perfctr_cpu_state *state)
+{
+	state->isuspend_cpu = NR_CPUS;
+}
+
+#else
+static inline void set_isuspend_cpu(struct perfctr_cpu_state *state, int cpu) { }
+static inline int is_isuspend_cpu(const struct perfctr_cpu_state *state, int cpu) { return 1; }
+static inline void clear_isuspend_cpu(struct perfctr_cpu_state *state) { }
+#endif
+
+
+static void ppc64_clear_counters(void)
+{
+	mtspr(SPRN_MMCR0, 0);
+	mtspr(SPRN_MMCR1, 0);
+	mtspr(SPRN_MMCRA, 0);
+
+	mtspr(SPRN_PMC1, 0);
+	mtspr(SPRN_PMC2, 0);
+	mtspr(SPRN_PMC3, 0);
+	mtspr(SPRN_PMC4, 0);
+	mtspr(SPRN_PMC5, 0);
+	mtspr(SPRN_PMC6, 0);
+
+	if (cpu_has_feature(CPU_FTR_PMC8)) {
+		mtspr(SPRN_PMC7, 0);
+		mtspr(SPRN_PMC8, 0);
+	}
+}
+
+/*
+ * Driver methods, internal and exported.
+ */
+
+static void perfctr_cpu_write_control(const struct perfctr_cpu_state *state)
+{
+	struct per_cpu_cache *cache;
+	unsigned long long value;
+
+	cache = get_cpu_cache();
+	/*
+	 * Order matters here: update threshmult and event
+	 * selectors before updating global control, which
+	 * potentially enables PMIs.
+	 *
+	 * Since mtspr doesn't accept a runtime value for the
+	 * SPR number, unroll the loop so each mtspr targets
+	 * a constant SPR.
+	 *
+	 * For processors without MMCR2, we ensure that the
+	 * cache and the state indicate the same value for it,
+	 * preventing any actual mtspr to it. Ditto for MMCR1.
+	 */
+	value = state->control.mmcra;
+	if (value != cache->ppc64_mmcra) {
+		cache->ppc64_mmcra = value;
+		mtspr(SPRN_MMCRA, value);
+	}
+	value = state->control.mmcr1;
+	if (value != cache->ppc64_mmcr1) {
+		cache->ppc64_mmcr1 = value;
+		mtspr(SPRN_MMCR1, value);
+	}
+	value = state->control.mmcr0;
+	if (perfctr_cstatus_has_ictrs(state->user.cstatus))
+	    value |= MMCR0_PMXE;
+	if (value != cache->ppc64_mmcr0) {
+		cache->ppc64_mmcr0 = value;
+		mtspr(SPRN_MMCR0, value);
+	}
+	cache->id = state->id;
+}
+
+static void perfctr_cpu_read_counters(struct perfctr_cpu_state *state,
+				      struct perfctr_low_ctrs *ctrs)
+{
+	unsigned int cstatus, i, pmc;
+
+	cstatus = state->user.cstatus;
+	if (perfctr_cstatus_has_tsc(cstatus))
+		ctrs->tsc = mftb() & 0xffffffff;
+
+	for (i = 0; i < perfctr_cstatus_nractrs(cstatus); ++i) {
+		pmc = state->user.pmc[i].map;
+		ctrs->pmc[i] = read_pmc(pmc);
+	}
+}
+
+#ifdef CONFIG_PERFCTR_INTERRUPT_SUPPORT
+static void perfctr_cpu_isuspend(struct perfctr_cpu_state *state)
+{
+	unsigned int cstatus, nrctrs, i;
+	int cpu;
+
+	cpu = smp_processor_id();
+	set_isuspend_cpu(state, cpu); /* early to limit cpu's live range */
+	cstatus = state->user.cstatus;
+	nrctrs = perfctr_cstatus_nrctrs(cstatus);
+	for (i = perfctr_cstatus_nractrs(cstatus); i < nrctrs; ++i) {
+		unsigned int pmc = state->user.pmc[i].map;
+		unsigned int now = read_pmc(pmc);
+
+		state->user.pmc[i].sum += now - state->user.pmc[i].start;
+		state->user.pmc[i].start = now;
+	}
+}
+
+static void perfctr_cpu_iresume(const struct perfctr_cpu_state *state)
+{
+	struct per_cpu_cache *cache;
+	unsigned int cstatus, nrctrs, i;
+	int cpu;
+
+	cpu = smp_processor_id();
+	cache = __get_cpu_cache(cpu);
+	if (cache->id == state->id) {
+		/* Clearing cache->id to force write_control()
+		   to unfreeze MMCR0 would be done here, but it
+		   is subsumed by resume()'s MMCR0 reload logic. */
+		if (is_isuspend_cpu(state, cpu)) {
+			return; /* skip reload of PMCs */
+		}
+	}
+	/*
+	 * The CPU state wasn't ours.
+	 *
+	 * The counters must be frozen before being reinitialised,
+	 * to prevent unexpected increments and missed overflows.
+	 *
+	 * All unused counters must be reset to a non-overflow state.
+	 */
+	if (!(cache->ppc64_mmcr0 & MMCR0_FC)) {
+		cache->ppc64_mmcr0 |= MMCR0_FC;
+		mtspr(SPRN_MMCR0, cache->ppc64_mmcr0);
+	}
+	cstatus = state->user.cstatus;
+	nrctrs = perfctr_cstatus_nrctrs(cstatus);
+	for (i = perfctr_cstatus_nractrs(cstatus); i < nrctrs; ++i) {
+		write_pmc(state->user.pmc[i].map, state->user.pmc[i].start);
+	}
+}
+
+/* Call perfctr_cpu_ireload() just before perfctr_cpu_resume() to
+   bypass internal caching and force a reload if the I-mode PMCs. */
+void perfctr_cpu_ireload(struct perfctr_cpu_state *state)
+{
+#ifdef CONFIG_SMP
+	clear_isuspend_cpu(state);
+#else
+	get_cpu_cache()->id = 0;
+#endif
+}
+
+/* PRE: the counters have been suspended and sampled by perfctr_cpu_suspend() */
+unsigned int perfctr_cpu_identify_overflow(struct perfctr_cpu_state *state)
+{
+	unsigned int cstatus, nractrs, nrctrs, i;
+	unsigned int pmc_mask = 0;
+	int nr_pmcs = 6;
+
+	if (cpu_has_feature(CPU_FTR_PMC8))
+		nr_pmcs = 8;
+
+	cstatus = state->user.cstatus;
+	nractrs = perfctr_cstatus_nractrs(cstatus);
+	nrctrs = perfctr_cstatus_nrctrs(cstatus);
+
+	/* Ickity, ickity, ick.  We don't have fine enough interrupt
+	 * control to disable interrupts on all the counters we're not
+	 * interested in.  So, we have to deal with overflows on actrs
+	 * amd unused PMCs as well as the ones we actually care
+	 * about. */
+	for (i = 0; i < nractrs; ++i) {
+		int pmc = state->user.pmc[i].map;
+		unsigned int val = read_pmc(pmc);
+
+		/* For actrs, force a sample if they overflowed */
+
+		if ((int)val < 0) {
+			state->user.pmc[i].sum += val - state->user.pmc[i].start;
+			state->user.pmc[i].start = 0;
+			write_pmc(pmc, 0);
+		}
+	}
+	for (; i < nrctrs; ++i) {
+		if ((int)state->user.pmc[i].start < 0) { /* PPC64-specific */
+			int pmc = state->user.pmc[i].map;
+			/* XXX: "+=" to correct for overshots */
+			state->user.pmc[i].start = state->control.ireset[pmc];
+			pmc_mask |= (1 << i);
+		}
+	}
+
+	/* Clear any unused overflowed counters, so we don't loop on
+	 * the interrupt */
+	for (i = 0; i < nr_pmcs; ++i) {
+		if (! (state->unused_pmcs & (1<<i)))
+			continue;
+
+		if ((int)read_pmc(i) < 0)
+			write_pmc(i, 0);
+	}
+
+	/* XXX: HW cleared MMCR0[ENINT]. We presumably cleared the entire
+	   MMCR0, so the re-enable occurs automatically later, no? */
+	return pmc_mask;
+}
+
+static inline int check_ireset(struct perfctr_cpu_state *state)
+{
+	unsigned int nrctrs, i;
+
+	i = state->control.header.nractrs;
+	nrctrs = i + state->control.header.nrictrs;
+	for(; i < nrctrs; ++i) {
+		unsigned int pmc = state->user.pmc[i].map;
+		if ((int)state->control.ireset[pmc] < 0) /* PPC64-specific */
+			return -EINVAL;
+		state->user.pmc[i].start = state->control.ireset[pmc];
+	}
+	return 0;
+}
+
+#else	/* CONFIG_PERFCTR_INTERRUPT_SUPPORT */
+static inline void perfctr_cpu_isuspend(struct perfctr_cpu_state *state) { }
+static inline void perfctr_cpu_iresume(const struct perfctr_cpu_state *state) { }
+static inline int check_ireset(struct perfctr_cpu_state *state) { return 0; }
+#endif	/* CONFIG_PERFCTR_INTERRUPT_SUPPORT */
+
+static int check_control(struct perfctr_cpu_state *state)
+{
+	unsigned int i, nractrs, nrctrs, pmc_mask, pmc;
+	unsigned int nr_pmcs = 6;
+
+	if (cpu_has_feature(CPU_FTR_PMC8))
+		nr_pmcs = 8;
+
+	nractrs = state->control.header.nractrs;
+	nrctrs = nractrs + state->control.header.nrictrs;
+	if (nrctrs < nractrs || nrctrs > nr_pmcs)
+		return -EINVAL;
+
+	pmc_mask = 0;
+	for (i = 0; i < nrctrs; ++i) {
+		pmc = state->control.pmc_map[i];
+		state->user.pmc[i].map = pmc;
+		if (pmc >= nr_pmcs || (pmc_mask & (1<<pmc)))
+			return -EINVAL;
+		pmc_mask |= (1<<pmc);
+	}
+
+	/* We need to retain internal control of PMXE and PMAO.  PMXE
+	 * will be set when ictrs are active.  We can't really handle
+	 * TB interrupts, so we don't allow those either. */
+	if ( (state->control.mmcr0 & MMCR0_PMXE)
+	     || (state->control.mmcr0 & MMCR0_PMAO) 
+	     || (state->control.mmcr0 & MMCR0_TBEE) )
+		return -EINVAL;
+
+	state->unused_pmcs = ((1 << nr_pmcs)-1) & ~pmc_mask;
+	
+	state->id = new_id();
+
+	return 0;
+}
+
+int perfctr_cpu_update_control(struct perfctr_cpu_state *state, int is_global)
+{
+	int err;
+
+	clear_isuspend_cpu(state);
+	state->user.cstatus = 0;
+
+	/* disallow i-mode counters if we cannot catch the interrupts */
+	if (!(perfctr_info.cpu_features & PERFCTR_FEATURE_PCINT)
+	    && state->control.header.nrictrs)
+		return -EPERM;
+
+	err = check_control(state); /* may initialise state->cstatus */
+	if (err < 0)
+		return err;
+	err = check_ireset(state);
+	if (err < 0)
+		return err;
+	state->user.cstatus |= perfctr_mk_cstatus(state->control.header.tsc_on,
+						  state->control.header.nractrs,
+						  state->control.header.nrictrs);
+	return 0;
+}
+
+/*
+ * get_reg_offset() maps SPR numbers to offsets into struct perfctr_cpu_control.
+ */
+static const struct {
+	unsigned int spr;
+	unsigned int offset;
+	unsigned int size;
+} reg_offsets[] = {
+	{ SPRN_MMCR0, offsetof(struct perfctr_cpu_control, mmcr0), sizeof(long) },
+	{ SPRN_MMCR1, offsetof(struct perfctr_cpu_control, mmcr1), sizeof(long) },
+	{ SPRN_MMCRA, offsetof(struct perfctr_cpu_control, mmcra), sizeof(long) },
+	{ SPRN_PMC1,  offsetof(struct perfctr_cpu_control, ireset[1-1]), sizeof(int) },
+	{ SPRN_PMC2,  offsetof(struct perfctr_cpu_control, ireset[2-1]), sizeof(int) },
+	{ SPRN_PMC3,  offsetof(struct perfctr_cpu_control, ireset[3-1]), sizeof(int) },
+	{ SPRN_PMC4,  offsetof(struct perfctr_cpu_control, ireset[4-1]), sizeof(int) },
+	{ SPRN_PMC5,  offsetof(struct perfctr_cpu_control, ireset[5-1]), sizeof(int) },
+	{ SPRN_PMC6,  offsetof(struct perfctr_cpu_control, ireset[6-1]), sizeof(int) },
+	{ SPRN_PMC7,  offsetof(struct perfctr_cpu_control, ireset[7-1]), sizeof(int) },
+	{ SPRN_PMC8,  offsetof(struct perfctr_cpu_control, ireset[8-1]), sizeof(int) },
+};
+
+static int get_reg_offset(unsigned int spr, unsigned int *size)
+{
+	unsigned int i;
+
+	for(i = 0; i < ARRAY_SIZE(reg_offsets); ++i)
+		if (spr == reg_offsets[i].spr) {
+			*size = reg_offsets[i].size;
+			return reg_offsets[i].offset;
+		}
+	return -1;
+}
+
+static int access_regs(struct perfctr_cpu_control *control,
+		       void *argp, unsigned int argbytes, int do_write)
+{
+	struct perfctr_cpu_reg *regs;
+	unsigned int i, nr_regs, size;
+	int offset;
+
+	nr_regs = argbytes / sizeof(struct perfctr_cpu_reg);
+	if (nr_regs * sizeof(struct perfctr_cpu_reg) != argbytes)
+		return -EINVAL;
+	regs = (struct perfctr_cpu_reg*)argp;
+
+	for(i = 0; i < nr_regs; ++i) {
+		offset = get_reg_offset(regs[i].nr, &size);
+		if (offset < 0)
+			return -EINVAL;
+		if (size == sizeof(long)) {
+			unsigned long *where = (unsigned long*)((char*)control + offset);
+			if (do_write)
+				*where = regs[i].value;
+			else
+				regs[i].value = *where;
+		} else {
+			unsigned int *where = (unsigned int*)((char*)control + offset);
+			if (do_write)
+				*where = regs[i].value;
+			else
+				regs[i].value = *where;
+		}
+	}
+	return argbytes;
+}
+
+int perfctr_cpu_control_write(struct perfctr_cpu_control *control, unsigned int domain,
+			      const void *srcp, unsigned int srcbytes)
+{
+	if (domain != PERFCTR_DOMAIN_CPU_REGS)
+		return -EINVAL;
+	return access_regs(control, (void*)srcp, srcbytes, 1);
+}
+
+int perfctr_cpu_control_read(const struct perfctr_cpu_control *control, unsigned int domain,
+			     void *dstp, unsigned int dstbytes)
+{
+	if (domain != PERFCTR_DOMAIN_CPU_REGS)
+		return -EINVAL;
+	return access_regs((struct perfctr_cpu_control*)control, dstp, dstbytes, 0);
+}
+
+void perfctr_cpu_suspend(struct perfctr_cpu_state *state)
+{
+	unsigned int i, cstatus;
+	struct perfctr_low_ctrs now;
+
+	/* quiesce the counters */
+	mtspr(SPRN_MMCR0, MMCR0_FC);
+	get_cpu_cache()->ppc64_mmcr0 = MMCR0_FC;
+
+	if (perfctr_cstatus_has_ictrs(state->user.cstatus))
+		perfctr_cpu_isuspend(state);
+
+	perfctr_cpu_read_counters(state, &now);
+	cstatus = state->user.cstatus;
+	if (perfctr_cstatus_has_tsc(cstatus))
+		state->user.tsc_sum += now.tsc - state->user.tsc_start;
+
+	for (i = 0; i < perfctr_cstatus_nractrs(cstatus); ++i)
+		state->user.pmc[i].sum += now.pmc[i] - state->user.pmc[i].start;
+}
+
+void perfctr_cpu_resume(struct perfctr_cpu_state *state)
+{
+	struct perfctr_low_ctrs now;
+	unsigned int i, cstatus;
+
+	if (perfctr_cstatus_has_ictrs(state->user.cstatus))
+	    perfctr_cpu_iresume(state);
+	perfctr_cpu_write_control(state);
+
+	perfctr_cpu_read_counters(state, &now);
+	cstatus = state->user.cstatus;
+	if (perfctr_cstatus_has_tsc(cstatus))
+		state->user.tsc_start = now.tsc;
+
+	for (i = 0; i < perfctr_cstatus_nractrs(cstatus); ++i)
+		state->user.pmc[i].start = now.pmc[i];
+
+	/* XXX: if (SMP && start.tsc == now.tsc) ++now.tsc; */
+}
+
+void perfctr_cpu_sample(struct perfctr_cpu_state *state)
+{
+	unsigned int i, cstatus, nractrs;
+	struct perfctr_low_ctrs now;
+
+	perfctr_cpu_read_counters(state, &now);
+	cstatus = state->user.cstatus;
+	if (perfctr_cstatus_has_tsc(cstatus)) {
+		state->user.tsc_sum += now.tsc - state->user.tsc_start;
+		state->user.tsc_start = now.tsc;
+	}
+	nractrs = perfctr_cstatus_nractrs(cstatus);
+	for(i = 0; i < nractrs; ++i) {
+		state->user.pmc[i].sum += now.pmc[i] - state->user.pmc[i].start;
+		state->user.pmc[i].start = now.pmc[i];
+	}
+}
+
+static void perfctr_cpu_clear_counters(void)
+{
+	struct per_cpu_cache *cache;
+
+	cache = get_cpu_cache();
+	memset(cache, 0, sizeof *cache);
+	cache->id = 0;
+
+	ppc64_clear_counters();
+}
+
+/****************************************************************
+ *								*
+ * Processor detection and initialisation procedures.		*
+ *								*
+ ****************************************************************/
+
+static void ppc64_cpu_setup(void)
+{
+	/* allow user to initialize these???? */
+
+        unsigned long long mmcr0 = mfspr(SPRN_MMCR0);
+        unsigned long long mmcra = mfspr(SPRN_MMCRA);
+
+
+        ppc64_enable_pmcs();
+
+        mmcr0 |= MMCR0_FC;
+        mtspr(SPRN_MMCR0, mmcr0); 
+
+        mmcr0 |= MMCR0_FCM1|MMCR0_PMXE|MMCR0_FCECE;
+        mmcr0 |= MMCR0_PMC1CE|MMCR0_PMCjCE;
+        mtspr(SPRN_MMCR0, mmcr0);
+
+        mmcra |= MMCRA_SAMPLE_ENABLE;
+        mtspr(SPRN_MMCRA, mmcra);
+
+	printk("setup on cpu %d, mmcr0 %lx\n", smp_processor_id(),
+            mfspr(SPRN_MMCR0));
+	printk("setup on cpu %d, mmcr1 %lx\n", smp_processor_id(),
+            mfspr(SPRN_MMCR1));
+	printk("setup on cpu %d, mmcra %lx\n", smp_processor_id(),
+            mfspr(SPRN_MMCRA));
+
+/*         mtmsrd(mfmsr() | MSR_PMM); */
+
+	ppc64_clear_counters();
+
+	mmcr0 = mfspr(SPRN_MMCR0);
+        mmcr0 &= ~MMCR0_PMAO;
+        mmcr0 &= ~MMCR0_FC;
+        mtspr(SPRN_MMCR0, mmcr0);
+
+        printk("start on cpu %d, mmcr0 %llx\n", smp_processor_id(), mmcr0);
+}
+
+
+static void perfctr_cpu_clear_one(void *ignore)
+{
+	/* PREEMPT note: when called via on_each_cpu(),
+	   this is in IRQ context with preemption disabled. */
+	perfctr_cpu_clear_counters();
+}
+
+static void perfctr_cpu_reset(void)
+{
+	on_each_cpu(perfctr_cpu_clear_one, NULL, 1, 1);
+	perfctr_cpu_set_ihandler(NULL);
+}
+
+int __init perfctr_cpu_init(void)
+{
+	extern unsigned long ppc_proc_freq;
+	extern unsigned long ppc_tb_freq;
+
+	perfctr_info.cpu_features = PERFCTR_FEATURE_RDTSC
+		| PERFCTR_FEATURE_RDPMC | PERFCTR_FEATURE_PCINT;
+
+	perfctr_cpu_name = "PowerPC64";
+	
+	perfctr_info.cpu_khz = ppc_proc_freq / 1000;
+	/* We need to round here rather than truncating, because in a
+	 * few cases the raw ratio can end up being 7.9999 or
+	 * suchlike */
+	perfctr_info.tsc_to_cpu_mult =
+		(ppc_proc_freq + ppc_tb_freq - 1) / ppc_tb_freq;
+
+	on_each_cpu((void *)ppc64_cpu_setup, NULL, 0, 1);
+	
+	perfctr_ppc64_init_tests();
+
+	perfctr_cpu_reset();
+	return 0;
+}
+
+void __exit perfctr_cpu_exit(void)
+{
+	perfctr_cpu_reset();
+}
+
+/****************************************************************
+ *								*
+ * Hardware reservation.					*
+ *								*
+ ****************************************************************/
+
+static spinlock_t service_mutex = SPIN_LOCK_UNLOCKED;
+static const char *current_service = NULL;
+
+const char *perfctr_cpu_reserve(const char *service)
+{
+	const char *ret;
+
+	spin_lock(&service_mutex);
+
+	ret = current_service;
+	if (ret)
+		goto out;
+
+	ret = "unknown driver (oprofile?)";
+	if (reserve_pmc_hardware(do_perfctr_interrupt) != 0)
+		goto out;
+
+	current_service = service;
+	ret = NULL;
+
+ out:
+	spin_unlock(&service_mutex);
+	return ret;
+}
+
+void perfctr_cpu_release(const char *service)
+{
+	spin_lock(&service_mutex);
+
+	if (service != current_service) {
+		printk(KERN_ERR "%s: attempt by %s to release while reserved by %s\n",
+		       __FUNCTION__, service, current_service);
+		goto out;
+	}
+
+	/* power down the counters */
+	perfctr_cpu_reset();
+	current_service = NULL;
+	release_pmc_hardware();
+
+ out:
+	spin_unlock(&service_mutex);
+}
diff -rupN linux-2.6.12-rc1-mm4/drivers/perfctr/ppc64_tests.c linux-2.6.12-rc1-mm4.perfctr-ppc64-driver/drivers/perfctr/ppc64_tests.c
--- linux-2.6.12-rc1-mm4/drivers/perfctr/ppc64_tests.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.12-rc1-mm4.perfctr-ppc64-driver/drivers/perfctr/ppc64_tests.c	2005-03-31 23:37:37.000000000 +0200
@@ -0,0 +1,322 @@
+/*
+ * Performance-monitoring counters driver.
+ * Optional PPC64-specific init-time tests.
+ *
+ * Copyright (C) 2004  David Gibson, IBM Corporation.
+ * Copyright (C) 2004  Mikael Pettersson
+ */
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/fs.h>
+#include <linux/perfctr.h>
+#include <asm/processor.h>
+#include <asm/time.h>	/* for tb_ticks_per_jiffy */
+#include "ppc64_tests.h"
+
+#define NITER	256
+#define X2(S)	S"; "S
+#define X8(S)	X2(X2(X2(S)))
+
+static void __init do_read_tbl(unsigned int unused)
+{
+	unsigned int i, dummy;
+	for(i = 0; i < NITER/8; ++i)
+		__asm__ __volatile__(X8("mftbl %0") : "=r"(dummy));
+}
+
+static void __init do_read_pmc1(unsigned int unused)
+{
+	unsigned int i, dummy;
+	for(i = 0; i < NITER/8; ++i)
+		__asm__ __volatile__(X8("mfspr %0," __stringify(SPRN_PMC1)) : "=r"(dummy));
+}
+
+static void __init do_read_pmc2(unsigned int unused)
+{
+	unsigned int i, dummy;
+	for(i = 0; i < NITER/8; ++i)
+		__asm__ __volatile__(X8("mfspr %0," __stringify(SPRN_PMC2)) : "=r"(dummy));
+}
+
+static void __init do_read_pmc3(unsigned int unused)
+{
+	unsigned int i, dummy;
+	for(i = 0; i < NITER/8; ++i)
+		__asm__ __volatile__(X8("mfspr %0," __stringify(SPRN_PMC3)) : "=r"(dummy));
+}
+
+static void __init do_read_pmc4(unsigned int unused)
+{
+	unsigned int i, dummy;
+	for(i = 0; i < NITER/8; ++i)
+		__asm__ __volatile__(X8("mfspr %0," __stringify(SPRN_PMC4)) : "=r"(dummy));
+}
+
+static void __init do_read_mmcr0(unsigned int unused)
+{
+	unsigned int i, dummy;
+	for(i = 0; i < NITER/8; ++i)
+		__asm__ __volatile__(X8("mfspr %0," __stringify(SPRN_MMCR0)) : "=r"(dummy));
+}
+
+static void __init do_read_mmcr1(unsigned int unused)
+{
+	unsigned int i, dummy;
+	for(i = 0; i < NITER/8; ++i)
+		__asm__ __volatile__(X8("mfspr %0," __stringify(SPRN_MMCR1)) : "=r"(dummy));
+}
+
+static void __init do_write_pmc2(unsigned int arg)
+{
+	unsigned int i;
+	for(i = 0; i < NITER/8; ++i)
+		__asm__ __volatile__(X8("mtspr " __stringify(SPRN_PMC2) ",%0") : : "r"(arg));
+}
+
+static void __init do_write_pmc3(unsigned int arg)
+{
+	unsigned int i;
+	for(i = 0; i < NITER/8; ++i)
+		__asm__ __volatile__(X8("mtspr " __stringify(SPRN_PMC3) ",%0") : : "r"(arg));
+}
+
+static void __init do_write_pmc4(unsigned int arg)
+{
+	unsigned int i;
+	for(i = 0; i < NITER/8; ++i)
+		__asm__ __volatile__(X8("mtspr " __stringify(SPRN_PMC4) ",%0") : : "r"(arg));
+}
+
+static void __init do_write_mmcr1(unsigned int arg)
+{
+	unsigned int i;
+	for(i = 0; i < NITER/8; ++i)
+		__asm__ __volatile__(X8("mtspr " __stringify(SPRN_MMCR1) ",%0") : : "r"(arg));
+}
+
+static void __init do_write_mmcr0(unsigned int arg)
+{
+	unsigned int i;
+	for(i = 0; i < NITER/8; ++i)
+		__asm__ __volatile__(X8("mtspr " __stringify(SPRN_MMCR0) ",%0") : : "r"(arg));
+}
+
+static void __init do_empty_loop(unsigned int unused)
+{
+	unsigned i;
+	for(i = 0; i < NITER/8; ++i)
+		__asm__ __volatile__("" : : );
+}
+
+static unsigned __init run(void (*doit)(unsigned int), unsigned int arg)
+{
+	unsigned int start, stop;
+	start = mfspr(SPRN_PMC1);
+	(*doit)(arg);	/* should take < 2^32 cycles to complete */
+	stop = mfspr(SPRN_PMC1);
+	return stop - start;
+}
+
+static void __init init_tests_message(void)
+{
+#if 0
+	printk(KERN_INFO "Please email the following PERFCTR INIT lines "
+	       "to mikpe@csd.uu.se\n"
+	       KERN_INFO "To remove this message, rebuild the driver "
+	       "with CONFIG_PERFCTR_INIT_TESTS=n\n");
+	printk(KERN_INFO "PERFCTR INIT: PVR 0x%08x, CPU clock %u kHz, TB clock %lu kHz\n",
+	       pvr,
+	       perfctr_info.cpu_khz,
+	       tb_ticks_per_jiffy*(HZ/10)/(1000/10));
+#endif
+}
+
+static void __init clear(void)
+{
+	mtspr(SPRN_MMCR0, 0);
+	mtspr(SPRN_MMCR1, 0);
+	mtspr(SPRN_MMCRA, 0);
+	mtspr(SPRN_PMC1, 0);
+	mtspr(SPRN_PMC2, 0);
+	mtspr(SPRN_PMC3, 0);
+	mtspr(SPRN_PMC4, 0);
+	mtspr(SPRN_PMC5, 0);
+	mtspr(SPRN_PMC6, 0);
+	mtspr(SPRN_PMC7, 0);
+	mtspr(SPRN_PMC8, 0);
+}
+
+static void __init check_fcece(unsigned int pmc1ce)
+{
+	unsigned int mmcr0;
+	unsigned int pmc1;
+	int x = 0;
+
+	/* JHE check out section 1.6.6.2 of the POWER5 pdf */
+
+	/*
+	 * This test checks if MMCR0[FC] is set after PMC1 overflows
+	 * when MMCR0[FCECE] is set.
+	 * 74xx documentation states this behaviour, while documentation
+	 * for 604/750 processors doesn't mention this at all.
+	 *
+	 * Also output the value of PMC1 shortly after the overflow.
+	 * This tells us if PMC1 really was frozen. On 604/750, it may not
+	 * freeze since we don't enable PMIs. [No freeze confirmed on 750.]
+	 *
+	 * When pmc1ce == 0, MMCR0[PMC1CE] is zero. It's unclear whether
+	 * this masks all PMC1 overflow events or just PMC1 PMIs.
+	 *
+	 * PMC1 counts processor cycles, with 100 to go before overflowing.
+	 * FCECE is set.
+	 * PMC1CE is clear if !pmc1ce, otherwise set.
+	 */
+	pmc1 = mfspr(SPRN_PMC1);
+
+	mtspr(SPRN_PMC1, 0x80000000-100);
+	mmcr0 = MMCR0_FCECE | MMCR0_SHRFC;
+
+	if (pmc1ce)
+		mmcr0 |= MMCR0_PMC1CE;
+
+	mtspr(SPRN_MMCR0, mmcr0);
+
+	pmc1 = mfspr(SPRN_PMC1);
+
+	do {
+		do_empty_loop(0);
+
+		pmc1 = mfspr(SPRN_PMC1);
+		if (x++ > 20000000) {
+			break;
+		}
+	} while (!(mfspr(SPRN_PMC1) & 0x80000000));
+	do_empty_loop(0);
+
+	printk(KERN_INFO "PERFCTR INIT: %s(%u): MMCR0[FC] is %u, PMC1 is %#lx\n",
+	       __FUNCTION__, pmc1ce,
+	       !!(mfspr(SPRN_MMCR0) & MMCR0_FC), mfspr(SPRN_PMC1));
+	mtspr(SPRN_MMCR0, 0);
+	mtspr(SPRN_PMC1, 0);
+}
+
+static void __init check_trigger(unsigned int pmc1ce)
+{
+	unsigned int mmcr0;
+	unsigned int pmc1;
+	int x = 0;
+
+	/*
+	 * This test checks if MMCR0[TRIGGER] is reset after PMC1 overflows.
+	 * 74xx documentation states this behaviour, while documentation
+	 * for 604/750 processors doesn't mention this at all.
+	 * [No reset confirmed on 750.]
+	 *
+	 * Also output the values of PMC1 and PMC2 shortly after the overflow.
+	 * PMC2 should be equal to PMC1-0x80000000.
+	 *
+	 * When pmc1ce == 0, MMCR0[PMC1CE] is zero. It's unclear whether
+	 * this masks all PMC1 overflow events or just PMC1 PMIs.
+	 *
+	 * PMC1 counts processor cycles, with 100 to go before overflowing.
+	 * PMC2 counts processor cycles, starting from 0.
+	 * TRIGGER is set, so PMC2 doesn't start until PMC1 overflows.
+	 * PMC1CE is clear if !pmc1ce, otherwise set.
+	 */
+	mtspr(SPRN_PMC2, 0);
+	mtspr(SPRN_PMC1, 0x80000000-100);
+	mmcr0 = MMCR0_TRIGGER | MMCR0_SHRFC | MMCR0_FCHV;
+
+	if (pmc1ce)
+		mmcr0 |= MMCR0_PMC1CE;
+
+	mtspr(SPRN_MMCR0, mmcr0);
+	do {
+		do_empty_loop(0);
+		pmc1 = mfspr(SPRN_PMC1);
+		if (x++ > 20000000) {
+			break;
+		}
+
+	} while (!(mfspr(SPRN_PMC1) & 0x80000000));
+	do_empty_loop(0);
+	printk(KERN_INFO "PERFCTR INIT: %s(%u): MMCR0[TRIGGER] is %u, PMC1 is %#lx, PMC2 is %#lx\n",
+	       __FUNCTION__, pmc1ce,
+	       !!(mfspr(SPRN_MMCR0) & MMCR0_TRIGGER), mfspr(SPRN_PMC1), mfspr(SPRN_PMC2));
+	mtspr(SPRN_MMCR0, 0);
+	mtspr(SPRN_PMC1, 0);
+	mtspr(SPRN_PMC2, 0);
+}
+
+static void __init measure_overheads(void)
+{
+	int i;
+	unsigned int mmcr0, loop, ticks[12];
+	const char *name[12];
+
+	clear();
+
+	/* PMC1 = "processor cycles",
+	   PMC2 = "completed instructions",
+	   not disabled in any mode,
+	   no interrupts */
+	/* mmcr0 = (0x01 << 6) | (0x02 << 0); */
+	mmcr0 = MMCR0_SHRFC | MMCR0_FCWAIT;
+	mtspr(SPRN_MMCR0, mmcr0);
+
+	name[0] = "mftbl";
+	ticks[0] = run(do_read_tbl, 0);
+	name[1] = "mfspr (pmc1)";
+	ticks[1] = run(do_read_pmc1, 0);
+	name[2] = "mfspr (pmc2)";
+	ticks[2] = run(do_read_pmc2, 0);
+	name[3] = "mfspr (pmc3)";
+	ticks[3] = run(do_read_pmc3, 0);
+	name[4] = "mfspr (pmc4)";
+	ticks[4] = run(do_read_pmc4, 0);
+	name[5] = "mfspr (mmcr0)";
+	ticks[5] = run(do_read_mmcr0, 0);
+	name[6] = "mfspr (mmcr1)";
+	ticks[6] = run(do_read_mmcr1, 0);
+	name[7] = "mtspr (pmc2)";
+	ticks[7] = run(do_write_pmc2, 0);
+	name[8] = "mtspr (pmc3)";
+	ticks[8] = run(do_write_pmc3, 0);
+	name[9] = "mtspr (pmc4)";
+	ticks[9] = run(do_write_pmc4, 0);
+	name[10] = "mtspr (mmcr1)";
+	ticks[10] = run(do_write_mmcr1, 0);
+	name[11] = "mtspr (mmcr0)";
+	ticks[11] = run(do_write_mmcr0, mmcr0);
+
+	loop = run(do_empty_loop, 0);
+
+	clear();
+
+	init_tests_message();
+	printk(KERN_INFO "PERFCTR INIT: NITER == %u\n", NITER);
+	printk(KERN_INFO "PERFCTR INIT: loop overhead is %u cycles\n", loop);
+	for(i = 0; i < ARRAY_SIZE(ticks); ++i) {
+		unsigned int x;
+		if (!ticks[i])
+			continue;
+		x = ((ticks[i] - loop) * 10) / NITER;
+		printk(KERN_INFO "PERFCTR INIT: %s cost is %u.%u cycles (%u total)\n",
+		       name[i], x/10, x%10, ticks[i]);
+	}
+
+	check_fcece(0);
+#if 0
+	check_fcece(1);
+	check_trigger(0);
+	check_trigger(1);
+#endif
+}
+
+void __init perfctr_ppc64_init_tests(void)
+{
+	preempt_disable();
+	measure_overheads();
+	preempt_enable();
+}
diff -rupN linux-2.6.12-rc1-mm4/drivers/perfctr/ppc64_tests.h linux-2.6.12-rc1-mm4.perfctr-ppc64-driver/drivers/perfctr/ppc64_tests.h
--- linux-2.6.12-rc1-mm4/drivers/perfctr/ppc64_tests.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.12-rc1-mm4.perfctr-ppc64-driver/drivers/perfctr/ppc64_tests.h	2005-03-31 23:37:37.000000000 +0200
@@ -0,0 +1,12 @@
+/*
+ * Performance-monitoring counters driver.
+ * Optional PPC32-specific init-time tests.
+ *
+ * Copyright (C) 2004  Mikael Pettersson
+ */
+
+#ifdef CONFIG_PERFCTR_INIT_TESTS
+extern void perfctr_ppc64_init_tests(void);
+#else
+static inline void perfctr_ppc64_init_tests(void) { }
+#endif
diff -rupN linux-2.6.12-rc1-mm4/include/asm-ppc64/perfctr.h linux-2.6.12-rc1-mm4.perfctr-ppc64-driver/include/asm-ppc64/perfctr.h
--- linux-2.6.12-rc1-mm4/include/asm-ppc64/perfctr.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.12-rc1-mm4.perfctr-ppc64-driver/include/asm-ppc64/perfctr.h	2005-03-31 23:37:37.000000000 +0200
@@ -0,0 +1,166 @@
+/*
+ * PPC64 Performance-Monitoring Counters driver
+ *
+ * Copyright (C) 2004  David Gibson, IBM Corporation.
+ * Copyright (C) 2004  Mikael Pettersson
+ */
+#ifndef _ASM_PPC64_PERFCTR_H
+#define _ASM_PPC64_PERFCTR_H
+
+#include <asm/types.h>
+
+struct perfctr_sum_ctrs {
+	__u64 tsc;
+	__u64 pmc[8];	/* the size is not part of the user ABI */
+};
+
+struct perfctr_cpu_control_header {
+	__u32 tsc_on;
+	__u32 nractrs;	/* number of accumulation-mode counters */
+	__u32 nrictrs;	/* number of interrupt-mode counters */
+};
+
+struct perfctr_cpu_state_user {
+	__u32 cstatus;
+	/* The two tsc fields must be inlined. Placing them in a
+	   sub-struct causes unwanted internal padding on x86-64. */
+	__u32 tsc_start;
+	__u64 tsc_sum;
+	struct {
+		__u32 map;
+		__u32 start;
+		__u64 sum;
+	} pmc[8];	/* the size is not part of the user ABI */
+};
+
+/* cstatus is a re-encoding of control.tsc_on/nractrs/nrictrs
+   which should have less overhead in most cases */
+/* XXX: ppc driver internally also uses cstatus&(1<<30) */
+
+static inline
+unsigned int perfctr_mk_cstatus(unsigned int tsc_on, unsigned int nractrs,
+				unsigned int nrictrs)
+{
+	return (tsc_on<<31) | (nrictrs<<16) | ((nractrs+nrictrs)<<8) | nractrs;
+}
+
+static inline unsigned int perfctr_cstatus_enabled(unsigned int cstatus)
+{
+	return cstatus;
+}
+
+static inline int perfctr_cstatus_has_tsc(unsigned int cstatus)
+{
+	return (int)cstatus < 0;	/* test and jump on sign */
+}
+
+static inline unsigned int perfctr_cstatus_nractrs(unsigned int cstatus)
+{
+	return cstatus & 0x7F;		/* and with imm8 */
+}
+
+static inline unsigned int perfctr_cstatus_nrctrs(unsigned int cstatus)
+{
+	return (cstatus >> 8) & 0x7F;
+}
+
+static inline unsigned int perfctr_cstatus_has_ictrs(unsigned int cstatus)
+{
+	return cstatus & (0x7F << 16);
+}
+
+/*
+ * 'struct siginfo' support for perfctr overflow signals.
+ * In unbuffered mode, si_code is set to SI_PMC_OVF and a bitmask
+ * describing which perfctrs overflowed is put in si_pmc_ovf_mask.
+ * A bitmask is used since more than one perfctr can have overflowed
+ * by the time the interrupt handler runs.
+ */
+#define SI_PMC_OVF	-8
+#define si_pmc_ovf_mask	_sifields._pad[0] /* XXX: use an unsigned field later */
+
+#ifdef __KERNEL__
+
+#if defined(CONFIG_PERFCTR)
+
+struct perfctr_cpu_control {
+	struct perfctr_cpu_control_header header;
+	u64 mmcr0;
+	u64 mmcr1;
+	u64 mmcra;
+	unsigned int ireset[8];		/* [0,0x7fffffff], for i-mode counters, physical indices */
+	unsigned int pmc_map[8];	/* virtual to physical index map */
+};
+
+struct perfctr_cpu_state {
+	/* Don't change field order here without first considering the number
+	   of cache lines touched during sampling and context switching. */
+	unsigned int id;
+	int isuspend_cpu;
+	struct perfctr_cpu_state_user user;
+	unsigned int unused_pmcs;
+	struct perfctr_cpu_control control;
+};
+
+/* Driver init/exit. */
+extern int perfctr_cpu_init(void);
+extern void perfctr_cpu_exit(void);
+
+/* CPU type name. */
+extern char *perfctr_cpu_name;
+
+/* Hardware reservation. */
+extern const char *perfctr_cpu_reserve(const char *service);
+extern void perfctr_cpu_release(const char *service);
+
+/* PRE: state has no running interrupt-mode counters.
+   Check that the new control data is valid.
+   Update the driver's private control data.
+   Returns a negative error code if the control data is invalid. */
+extern int perfctr_cpu_update_control(struct perfctr_cpu_state *state, int is_global);
+
+/* Parse and update control for the given domain. */
+extern int perfctr_cpu_control_write(struct perfctr_cpu_control *control,
+				     unsigned int domain,
+				     const void *srcp, unsigned int srcbytes);
+
+/* Retrieve and format control for the given domain.
+   Returns number of bytes written. */
+extern int perfctr_cpu_control_read(const struct perfctr_cpu_control *control,
+				    unsigned int domain,
+				    void *dstp, unsigned int dstbytes);
+
+/* Read a-mode counters. Subtract from start and accumulate into sums.
+   Must be called with preemption disabled. */
+extern void perfctr_cpu_suspend(struct perfctr_cpu_state *state);
+
+/* Write control registers. Read a-mode counters into start.
+   Must be called with preemption disabled. */
+extern void perfctr_cpu_resume(struct perfctr_cpu_state *state);
+
+/* Perform an efficient combined suspend/resume operation.
+   Must be called with preemption disabled. */
+extern void perfctr_cpu_sample(struct perfctr_cpu_state *state);
+
+/* The type of a perfctr overflow interrupt handler.
+   It will be called in IRQ context, with preemption disabled. */
+typedef void (*perfctr_ihandler_t)(unsigned long pc);
+
+/* Operations related to overflow interrupt handling. */
+#ifdef CONFIG_PERFCTR_INTERRUPT_SUPPORT
+extern void perfctr_cpu_set_ihandler(perfctr_ihandler_t);
+extern void perfctr_cpu_ireload(struct perfctr_cpu_state*);
+extern unsigned int perfctr_cpu_identify_overflow(struct perfctr_cpu_state*);
+#else
+static inline void perfctr_cpu_set_ihandler(perfctr_ihandler_t x) { }
+#endif
+static inline int perfctr_cpu_has_pending_interrupt(const struct perfctr_cpu_state *state)
+{
+	return 0;
+}
+
+#endif	/* CONFIG_PERFCTR */
+
+#endif	/* __KERNEL__ */
+
+#endif	/* _ASM_PPC64_PERFCTR_H */
