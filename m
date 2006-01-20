Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWATPWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWATPWo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 10:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbWATPWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 10:22:44 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:4057 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1750724AbWATPWk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 10:22:40 -0500
Date: Fri, 20 Jan 2006 07:20:13 -0800
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200601201520.k0KFKDG8023120@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] 2.6.16-rc1 perfmon2 patch for review
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This a split version of the perfmon. Each chunk was split to fit
the constraints of lkml on message size. the patch is relative
to 2.6.16-rc1.

Chunks [1-3] represent the common part of the perfmon2 patch. This
code is common to all supported architectures.

Chunk 4 represents the i386 specific perfmon2 patch. It implements
the arch-specific routines for 32-bit P4/Xeon, Pentiun M/P6. It also
includes the 32-bit version of the PEBS sampling format.

Chunk 5 represents the x86_64 specific perfmon2 patch. It implements
the arch-specific routines for 64-bit Opteron, EM64T. It also includes
the 64-bit version of the PEBS sampling format.

Chunk 6 represents the preliminary powerpc specific perfmon2 patch. It
implements the arch-specific routines for the 64-bit Power 4.

The Itanium Processors (IA-64) specific patch is not posted because it
is too big to be split into smaller chunks. The size comes from the fact
that it needs to remove the older implementation. If you are interested,
the patch can be downloaded from our project web site at:

	http://www.sf.net/projects/perfmon2

The MIPS support is not against the same kernel tree. To avoid confusion,
we did not post it directly to lkml. 

The patch is submitted for review by platform maintainers.

Thanks.
diff -urN --exclude-from=/tmp/excl28370 linux-2.6.16-rc1.orig/perfmon/perfmon.c linux-2.6.16-rc1/perfmon/perfmon.c
--- linux-2.6.16-rc1.orig/perfmon/perfmon.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.16-rc1/perfmon/perfmon.c	2006-01-18 08:50:31.000000000 -0800
@@ -0,0 +1,3472 @@
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
+static kmem_cache_t		*pfm_lg_set_cachep;
+static kmem_cache_t		*pfm_set_cachep;
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
+static pfm_msg_t *pfm_get_new_msg(struct pfm_context *ctx)
+{
+	int idx, next;
+
+	next = (ctx->ctx_msgq_tail+1) % PFM_MAX_MSGS;
+
+	DPRINT(("head=%d tail=%d\n",
+		ctx->ctx_msgq_head,
+		ctx->ctx_msgq_tail));
+
+	if (next == ctx->ctx_msgq_head)
+		return NULL;
+
+ 	idx = ctx->ctx_msgq_tail;
+	ctx->ctx_msgq_tail = next;
+
+	DPRINT(("head=%d tail=%d msg=%d\n",
+		ctx->ctx_msgq_head,
+		ctx->ctx_msgq_tail, idx));
+
+	return ctx->ctx_msgq+idx;
+}
+
+static inline void pfm_reset_msgq(struct pfm_context *ctx)
+{
+	ctx->ctx_msgq_head = ctx->ctx_msgq_tail = 0;
+}
+
+#if 0
+static void pfm_map_show(struct pfm_context *ctx)
+{
+	void *end, *base;
+	struct page *page;
+
+	base = ctx->ctx_smpl_addr;
+	if (base == NULL) return;
+	end  = base + ctx->ctx_smpl_size;
+
+	while(base < end) {
+		page = vmalloc_to_page(base);
+
+		DPRINT(("base=%p count=%d\n",
+			base,
+			page_count(page)));
+
+		base += PAGE_SIZE;
+	}
+}
+#endif
+
+void pfm_context_free(struct pfm_context *ctx)
+{
+	struct pfm_event_set *set, *tmp = NULL;
+	kmem_cache_t *cachep;
+	struct pfm_smpl_fmt *fmt;
+	int use_remap;
+
+	use_remap = ctx->ctx_fl_mapset;
+	fmt = ctx->ctx_smpl_fmt;
+
+	if (use_remap)
+		cachep = pfm_set_cachep;
+	else
+		cachep = pfm_lg_set_cachep;
+
+	/* free all sets */
+	for (set = ctx->ctx_sets; set; set = tmp) {
+		tmp = set->set_next;
+		if (use_remap)
+			vfree(set->set_view);
+		kmem_cache_free(cachep, set);
+	}
+
+	if (ctx->ctx_smpl_addr) {
+		DPRINT(("freeing sampling buffer @%p size=%zu\n",
+			ctx->ctx_smpl_addr,
+			ctx->ctx_smpl_size));
+
+		pfm_release_buf_space(ctx->ctx_smpl_size);
+
+		if (fmt->fmt_exit)
+			(*fmt->fmt_exit)(ctx->ctx_smpl_addr);
+
+		vfree(ctx->ctx_smpl_addr);
+	}
+
+	DPRINT(("free ctx @%p\n", ctx));
+	kmem_cache_free(pfm_ctx_cachep, ctx);
+
+	/*
+	 * decrease refcount on:
+	 * 	- PMU description table
+	 * 	- sampling format
+	 */
+	pfm_pmu_conf_put();
+	if (fmt)
+		pfm_smpl_fmt_put(fmt);
+}
+
+/*
+ * only called in for the current task
+ */
+static int pfm_setup_smpl_fmt(struct pfm_smpl_fmt *fmt, void *fmt_arg,
+				struct pfm_context *ctx, u32 ctx_flags,
+				int compat_mode, struct file *filp)
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
+		DPRINT(("validate(0x%x,%p)=%d\n", ctx_flags, fmt_arg, ret));
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
+			DPRINT(("cannot get size ret=%d\n", ret));
+			goto error;
+		}
+	}
+
+	if (size) {
+#ifdef CONFIG_IA64_PERFMON_COMPAT
+		if (compat_mode)
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
+		ret = (*fmt->fmt_init)(ctx, ctx->ctx_smpl_addr, ctx_flags,
+				       pfm_pmu_conf->num_pmds,
+				       fmt_arg);
+		if (ret)
+			goto error_buffer;
+	}
+	return 0;
+
+error_buffer:
+	pfm_release_buf_space(ctx->ctx_smpl_size);
+	/*
+	 * we do not call fmt_exit, if init has failed
+	 */
+	vfree(ctx->ctx_smpl_addr);
+error:
+	return ret;
+}
+
+/*
+ * this function does not modify the set_next field
+ */
+static void pfm_init_evtset(struct pfm_event_set *set)
+{
+	unsigned  long *impl_pmcs;
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
+			set->set_pmcs[i] = pfm_pmu_conf->pmc_desc[i].default_value;
+		DPRINT(("set %u pmc%u=0x%llx\n",
+			set->set_id,
+			i,
+			(unsigned long long)set->set_pmcs[i]));
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
+	struct pfm_event_set *set, *prev;
+	size_t view_size;
+	void *view;
+
+	/*
+	 * shortcut for set 0: always exist, cannot be removed
+	 */
+	if (set_id == 0 && alloc == 0)
+		return ctx->ctx_sets;
+
+	prev = NULL;
+
+	for (set = ctx->ctx_sets; set; set = set->set_next) {
+
+		if (set->set_id == set_id)
+			return set;
+		if (set->set_id > set_id)
+			break;
+		prev = set;
+	}
+	if (alloc == 0)
+		return NULL;
+
+	cachep = ctx->ctx_fl_mapset ? pfm_set_cachep : pfm_lg_set_cachep;
+
+	set = kmem_cache_alloc(cachep, SLAB_ATOMIC);
+	if (set) {
+		memset(set, 0, sizeof(struct pfm_event_set));
+
+		if (ctx->ctx_fl_mapset) {
+			view_size = PAGE_ALIGN(sizeof(pfm_set_view_t));
+			view      = vmalloc(view_size);
+			if (view == NULL) {
+				DPRINT(("cannot allocate set view\n"));
+				kmem_cache_free(cachep, set);
+				return NULL;
+			}
+		} else {
+			view_size = sizeof(pfm_set_view_t);
+			view = (pfm_set_view_t *)(set+1);
+		}
+		
+		memset(view, 0, sizeof(pfm_set_view_t));
+
+		set->set_id = set_id;
+		set->set_view = view;
+		set->set_mmap_offset = PFM_SET_REMAP_BASE
+					+ (set_id*PFM_SET_REMAP_SCALAR);
+
+			pfm_init_evtset(set);
+
+		if (prev) {
+			set->set_next  = prev->set_next;
+			prev->set_next = set;
+		} else {
+			ctx->ctx_sets = ctx->ctx_active_set = set;
+			set->set_view->set_status = PFM_SETVFL_ACTIVE;
+		}
+		
+		DPRINT(("set_id=%u size=%zu view=%p remap=%d mmap_offs=%lu\n",
+			set_id,
+			view_size,
+			view,
+			ctx->ctx_fl_mapset,
+			set->set_mmap_offset));
+	}
+	return set;
+}
+
+void pfm_mask_monitoring(struct pfm_context *ctx)
+{
+	struct pfm_event_set *set;
+	u64 now_itc;
+	int is_system;
+
+	DPRINT_ovfl(("masking monitoring\n"));
+
+	now_itc = pfm_arch_get_itc();
+	is_system = ctx->ctx_fl_system;
+	set = ctx->ctx_active_set;
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
+	set->set_duration += now_itc - set->set_duration_start;
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
+	if (ctx->ctx_state != PFM_CTX_MASKED)
+		return;
+
+	DPRINT(("unmasking monitoring\n"));
+
+	set = ctx->ctx_active_set;
+
+	/*
+	 * must be done before calling
+	 * pfm_arch_unmask_monitoring()
+	 */
+	ctx->ctx_state = PFM_CTX_LOADED;
+
+	pfm_arch_restore_pmds(ctx, set);
+
+	pfm_arch_unmask_monitoring(ctx);
+
+	now_itc = pfm_arch_get_itc();
+
+	set->set_priv_flags &= ~PFM_SETFL_PRIV_MOD_BOTH;
+
+	/*
+	 * reset set duration timer
+	 */
+	set->set_duration_start = now_itc;
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
+	if (ctx->ctx_cpu != smp_processor_id()) {
+#ifdef __i386__
+	/* On IA64 we use smp_call_function_single(), so we
+	 * should never be called on the wrong CPU.  On other
+	 * archs, that doesn't exist and we use
+	 * smp_call_function instead, so silently ignore all
+	 * CPUs except the one we care about.
+	 */
+		printk(KERN_ERR "perfmon: pfm_syswide_force_stop for CPU%u"
+		       "but on CPU%d\n",
+			ctx->ctx_cpu,
+			smp_processor_id());
+#endif
+		return;
+	}
+	if (__get_cpu_var(pmu_ctx) != ctx) {
+		printk(KERN_ERR "perfmon: pfm_syswide_force_stop CPU%d"
+		       "unexpected ctx %p instead of %p\n",
+			smp_processor_id(),
+			__get_cpu_var(pmu_ctx), ctx);
+		return;
+	}
+
+	DPRINT(("forcing CPU-wide stop\n"));
+
+	/*
+	 * the context is already protected in pfm_close(), we simply
+	 * need to mask interrupts to avoid a PMU interrupt race on
+	 * this CPU
+	 */
+	local_irq_save(flags);
+
+	ret = __pfm_unload_context(ctx);
+	if (ret) {
+		printk(KERN_ERR"pfm_syswide_force_stop: "
+		       "context_unload returned %d\n", ret);
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
+
+	DPRINT(("calling CPU%u for cleanup\n", ctx->ctx_cpu));
+#ifndef __i386__
+	ret = smp_call_function_single(ctx->ctx_cpu, pfm_syswide_force_stop,
+				       ctx, 0, 1);
+#else
+	ret = smp_call_function(pfm_syswide_force_stop, ctx, 0, 1);
+#endif
+	DPRINT(("called CPU%u for cleanup ret=%d\n", ctx->ctx_cpu, ret));
+}
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
+		memset(ctx, 0, sizeof(struct pfm_context)+PFM_ARCH_CTX_SIZE);
+		DPRINT(("alloc ctx @%p\n", ctx));
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
+	DPRINT(("sampling buffer rsize=%zu size=%zu\n", rsize, size));
+
+	ret = pfm_reserve_buf_space(size);
+	if (ret) return ret;
+
+	addr = vmalloc(size);
+	if (addr == NULL) {
+		DPRINT(("cannot allocate sampling buffer\n"));
+		goto unres;
+	}
+
+	memset(addr, 0, size);
+
+	//pfm_get_map(addr, size);
+
+	ctx->ctx_smpl_addr = addr;
+	ctx->ctx_smpl_size = size;
+
+	DPRINT(("kernel smpl buffer @%p\n", addr));
+
+	return 0;
+unres:
+	pfm_release_buf_space(size);
+	return -ENOMEM;
+}
+
+#ifdef CONFIG_IA64_PERFMON_COMPAT
+/*
+ * function providing some help for backward compatiblity with old IA-64
+ * applications. In the old model, certain attributes of a counter were
+ * passed via the PMC, now they are passed via the PMD.
+ */
+int pfm_compat_update_pmd(struct pfm_context *ctx, u16 set_id, u16 cnum,
+		          u32 rflags,
+			  unsigned long *smpl_pmds,
+		          unsigned long *reset_pmds,
+			  u64 eventid)
+{
+	struct pfm_event_set *set;
+	int is_counting;
+	unsigned long *impl_pmds;
+	u32 flags = 0;
+	u16 max_pmd;
+
+	impl_pmds = pfm_pmu_conf->impl_pmds;
+	max_pmd	= pfm_pmu_conf->max_pmd;
+
+	is_counting = pfm_pmu_conf->pmd_desc[cnum].type & PFM_REG_C64;
+	set = pfm_find_set(ctx, set_id, 0);
+
+	if (is_counting) {
+		if (rflags & PFM_REGFL_OVFL_NOTIFY)
+			flags |= PFM_REGFL_OVFL_NOTIFY;
+		if (rflags & PFM_REGFL_RANDOM)
+			flags |= PFM_REGFL_RANDOM;
+		/*
+		 * verify validity of smpl_pmds
+		 */
+		if (unlikely(bitmap_subset(smpl_pmds, impl_pmds, max_pmd) == 0)) {
+			DPRINT(("invalid smpl_pmds=0x%llx for pmd%u\n",
+				(unsigned long long)smpl_pmds[0],
+				cnum));
+			return -EINVAL;
+		}
+		/*
+		 * verify validity of reset_pmds
+		 */
+		if (unlikely(bitmap_subset(reset_pmds, impl_pmds, max_pmd) == 0)) {
+			DPRINT(("invalid reset_pmds=0x%lx for pmd%u\n",
+				reset_pmds[0],
+				cnum));
+			return -EINVAL;
+		}
+	} else if (rflags & (PFM_REGFL_OVFL_NOTIFY|PFM_REGFL_RANDOM)) {
+		DPRINT(("cannot set ovfl_notify or random on pmd%u\n", cnum));
+		return -EINVAL;
+	}
+	set->set_pmds[cnum].flags = flags;
+
+	if (is_counting) {
+		bitmap_copy(set->set_pmds[cnum].reset_pmds,
+			    reset_pmds,
+			    max_pmd);
+
+		bitmap_copy(set->set_pmds[cnum].smpl_pmds,
+			    smpl_pmds,
+			    max_pmd);
+
+		set->set_pmds[cnum].eventid = eventid;
+
+		/*
+		 * update ovfl_notify
+		 */
+		if (rflags & PFM_REGFL_OVFL_NOTIFY)
+			pfm_bv_set(set->set_ovfl_notify, cnum);
+		else
+			pfm_bv_clear(set->set_ovfl_notify, cnum);
+
+	}
+	DPRINT(("pmd%u flags=0x%x eventid=0x%lx r_pmds=0x%lx s_pmds=0x%lx\n",
+		cnum, flags,
+		eventid,
+		reset_pmds[0],
+		smpl_pmds[0]));
+
+	return 0;
+}
+#endif
+
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
+	unsigned long *cnt_mask, *reset_pmds;
+	u64 val;
+	unsigned int i, max_pmd, not_masked;
+
+	reset_pmds = set->set_reset_pmds;
+	max_pmd	= pfm_pmu_conf->max_pmd;
+
+	if (bitmap_empty(reset_pmds, max_pmd)) return;
+
+	ovfl_mask = pfm_pmu_conf->ovfl_mask;
+	cnt_mask = pfm_pmu_conf->cnt_pmds;
+	not_masked = ctx->ctx_state != PFM_CTX_MASKED;
+
+	DPRINT_ovfl(("%s r_pmds=0x%lx not_masked=%d\n",
+		     reset_mode == PFM_PMD_RESET_LONG ? "long" : "short",
+		     reset_pmds[0],
+		     not_masked));
+
+	pfm_modview_begin(set);
+
+	for (i = 0; i < max_pmd; i++) {
+
+		if (pfm_bv_isset(reset_pmds, i)) {
+
+			val = pfm_new_pmd_value(set->set_pmds + i,
+						reset_mode);
+
+			set->set_view->set_pmds[i]= val;
+
+			if (not_masked) {
+				if (pfm_bv_isset(cnt_mask, i)) {
+					hw_val = val & ovfl_mask;
+				} else {
+					hw_val = val;
+				}
+				pfm_write_pmd(ctx, i, hw_val);
+			}
+			DPRINT_ovfl(("pmd%u set=%u sval=0x%llx\n",
+				     i,
+				     set->set_id,
+				     (unsigned long long)val));
+		}
+	}
+
+	pfm_modview_end(set);
+
+	/*
+	 * done with reset
+	 */
+	bitmap_zero(reset_pmds, max_pmd);
+
+	/*
+	 * make changes visible
+	 */
+	if (not_masked)
+		pfm_arch_serialize();
+}
+
+/*
+ * reload reference overflow switch thresholds
+ */
+static void pfm_reload_switch_thresholds(struct pfm_event_set *set)
+{
+	unsigned long *mask;
+	u16 i, max_cnt_pmd, first_cnt_pmd;
+
+	mask = set->set_used_pmds;
+	first_cnt_pmd = pfm_pmu_conf->first_cnt_pmd;
+	max_cnt_pmd = pfm_pmu_conf->max_cnt_pmd;
+
+	for (i = first_cnt_pmd; i< max_cnt_pmd; i++) {
+		if (pfm_bv_isset(mask, i)) {
+			set->set_pmds[i].ovflsw_thres = set->set_pmds[i].ovflsw_ref_thres;
+			DPRINT(("pmd%u set=%u ovflsw_thres=%llu\n",
+				i,
+				set->set_id,
+				(unsigned long long)set->set_pmds[i].ovflsw_thres));
+		}
+	}
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
+	u16 max_pmd;
+	int is_system, state, is_active;
+
+	now_itc = pfm_arch_get_itc();
+	set = ctx->ctx_active_set;
+	max_pmd = pfm_pmu_conf->max_pmd;
+	is_active = ctx->ctx_fl_started || pfm_arch_is_active(ctx);
+
+	BUG_ON(ctx->ctx_fl_system == 0 && ctx->ctx_task != current);
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
+		new_set = set->set_switch_next;
+		if (new_set == NULL)
+			new_set = ctx->ctx_sets;
+	}
+
+	DPRINT(("state=%d prev_set=%u prev_runs=%llu new_set=%u new_runs=%llu"
+		" reset_mode=%d\n",
+		ctx->ctx_state,
+		set->set_id,
+		(unsigned long long)set->set_view->set_runs,
+		new_set->set_id,
+		(unsigned long long)new_set->set_view->set_runs,
+		reset_mode));
+
+	/*
+	 * nothing more to do
+	 */
+	if (new_set == set)
+		return;
+
+	is_system = ctx->ctx_fl_system;
+	state = ctx->ctx_state;
+	new_flags = new_set->set_flags;
+	switch_count = __get_cpu_var(pfm_stats).pfm_switch_count;
+
+	pfm_modview_begin(set);
+
+	new_set->set_view->set_runs++;
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
+		set->set_duration += now_itc - set->set_duration_start;
+		set->set_view->set_status &= ~PFM_SETVFL_ACTIVE;
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
+	new_set->set_priv_flags &= ~PFM_SETFL_PRIV_MOD_BOTH;
+
+	/*
+	 * reload switch threshold
+	 */
+	if (new_flags & PFM_SETFL_OVFL_SWITCH)
+		pfm_reload_switch_thresholds(new_set);
+
+	/*
+ 	 * reset timeout for new set
+ 	 */
+	if (new_flags & PFM_SETFL_TIME_SWITCH)
+		new_set->set_timeout = new_set->set_switch_timeout;
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
+		DPRINT(("new_set=%u info=0x%lx flags=0x%x\n",
+			new_set->set_id,
+			info,
+			new_flags));
+
+		if (is_active && (current->pid != 0 || (new_flags & PFM_SETFL_EXCL_IDLE) == 0))
+			pfm_arch_start(current, ctx, new_set);
+	} else {
+		if (is_active)
+			pfm_arch_start(current, ctx, new_set);
+	}
+
+	if (is_active)
+		new_set->set_duration_start = now_itc;
+
+skip_restart:
+	end_itc = pfm_arch_get_itc();
+	ctx->ctx_active_set = new_set;
+	new_set->set_view->set_status |= PFM_SETVFL_ACTIVE;
+
+	__get_cpu_var(pfm_stats).pfm_switch_count   = switch_count;
+	__get_cpu_var(pfm_stats).pfm_switch_cycles += end_itc - now_itc;
+}
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
+	unsigned long *reset_pmds;
+	void *hdr;
+	int max_cnt_pmd;
+	int state, ret;
+
+	hdr = ctx->ctx_smpl_addr;
+	fmt = ctx->ctx_smpl_fmt;
+	state = ctx->ctx_state;
+	set = ctx->ctx_active_set;
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
+	reset_pmds = set->set_reset_pmds;
+
+	DPRINT(("restartt=%d r_pmds=0x%lx switch=%d ctx_state=%d\n",
+		ret,
+		reset_pmds[0],
+		(set->set_priv_flags & PFM_SETFL_PRIV_SWITCH) != 0,
+		state));
+
+	if (ret == 0) {
+		/*
+		 * switch set if needed
+		 */
+		if (set->set_priv_flags & PFM_SETFL_PRIV_SWITCH) {
+			set->set_priv_flags &= ~PFM_SETFL_PRIV_SWITCH;
+			pfm_switch_sets(ctx, NULL, PFM_PMD_RESET_LONG, 0);
+			set = ctx->ctx_active_set;
+		} else if (rst_ctrl & PFM_OVFL_CTRL_RESET) {
+			pfm_reset_pmds(ctx, set, PFM_PMD_RESET_LONG);
+		}
+
+		if ((rst_ctrl & PFM_OVFL_CTRL_MASK) == 0) {
+			pfm_unmask_monitoring(ctx);
+		} else {
+			DPRINT(("stopping monitoring?\n"));
+		}
+		ctx->ctx_state = PFM_CTX_LOADED;
+	}
+	ctx->ctx_fl_can_restart = 0;
+}
+
+
+/*
+ * ensures that all set_id_next sets exists such that the round-robin
+ * will work correctly, i.e., next dangling references.
+ */
+int pfm_prepare_sets(struct pfm_context *ctx)
+{
+	struct pfm_event_set *set1, *set2;
+	int max_cnt_pmd;
+
+	max_cnt_pmd = pfm_pmu_conf->max_cnt_pmd;
+
+	for (set1 = ctx->ctx_sets; set1; set1 = set1->set_next) {
+		set2 = set1->set_next;
+		/*
+		 * set_switch_next is used during actual switching
+		 * so we prepare its value here. When no explicit next
+		 * is requested, the field is initialized with the address
+		 * of the next element in the ordered list
+		 */
+		if (set1->set_flags & PFM_SETFL_EXPL_NEXT) {
+			for (set2 = ctx->ctx_sets; set2; set2 = set2->set_next) {
+				if (set2->set_id == set1->set_id_next)
+					break;
+			}
+			if (set2 == NULL) {
+				DPRINT(("set%u points to set%u which does "
+					"not exist\n",
+					set1->set_id,
+					set1->set_id_next));
+				return -EINVAL;
+			}
+		}
+		/*
+		 * update field used during actual switching
+		 */
+		set1->set_switch_next = set2;
+
+		/*
+		 * cleanup bitvectors
+		 */
+		bitmap_zero(set1->set_ovfl_pmds, max_cnt_pmd);
+		bitmap_zero(set1->set_povfl_pmds, max_cnt_pmd);
+		set1->set_npend_ovfls = 0;
+		/*
+		 * we cannot just use plain clear because of arch-specific flags
+		 */
+		set1->set_priv_flags &= ~(PFM_SETFL_PRIV_MOD_BOTH|PFM_SETFL_PRIV_SWITCH);
+
+		/*
+		 * reset activation and elapsed cycles
+		 */
+		set1->set_duration = 0;
+
+		pfm_modview_begin(set1);
+
+		set1->set_view->set_runs = 0;
+
+		pfm_modview_end(set1);
+	}
+	return 0;
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
+	set = ctx->ctx_active_set;
+
+	pfm_modview_begin(set);
+	pfm_arch_save_pmds(ctx, set);
+	pfm_modview_end(set);
+
+	pfm_set_pmu_owner(NULL, NULL);
+	DPRINT(("released ownership\n"));
+}
+
+/*
+ * This function is always called after pfm_stop has been issued
+ */
+void pfm_flush_pmds(struct task_struct *task, struct pfm_context *ctx)
+{
+	struct pfm_event_set *set;
+	u64 ovfl_mask;
+	unsigned long *ovfl_pmds;
+	int max_pmd, max_cnt_pmd, first_cnt_pmd;
+	unsigned int i, can_access_pmu;
+	u32 num_ovfls;
+
+	ovfl_mask = pfm_pmu_conf->ovfl_mask;
+	max_pmd = pfm_pmu_conf->max_pmd;
+	first_cnt_pmd = pfm_pmu_conf->first_cnt_pmd;
+	max_cnt_pmd = pfm_pmu_conf->max_cnt_pmd;
+
+	set = ctx->ctx_active_set;
+
+	/*
+	 * for system-wide, guaranteed to run on correct CPU
+	 */
+	can_access_pmu = (__get_cpu_var(pmu_owner) == task) || ctx->ctx_fl_system;
+
+	if (can_access_pmu) {
+		/*
+		 * pending overflows have been saved by pfm_stop()
+		 */
+		pfm_save_pmds_release(ctx);
+	}
+
+	DPRINT(("access_pmu=%d active_set=%u\n", can_access_pmu, set->set_id));
+
+	/*
+	 * cleanup each set
+	 */
+	for (set = ctx->ctx_sets; set; set = set->set_next) {
+
+		/*
+		 * only look at sets with pending overflows
+		 */
+		if (set->set_npend_ovfls == 0) continue;
+
+		pfm_modview_begin(set);
+
+		/*
+		 * take care of overflow
+		 * no format handler is called here
+		 */
+		ovfl_pmds = set->set_povfl_pmds;
+		num_ovfls = set->set_npend_ovfls;
+
+		DPRINT(("set%u first=%u novfls=%u\n", set->set_id, first_cnt_pmd, num_ovfls));
+		/*
+		 * only look up to the last counting PMD register
+		 */
+		for (i = first_cnt_pmd; num_ovfls; i++) {
+
+			if (pfm_bv_isset(set->set_used_pmds, i)) {
+
+				if (pfm_bv_isset(ovfl_pmds, i)) {
+					set->set_view->set_pmds[i]  += 1 + ovfl_mask;
+					num_ovfls--;
+					DPRINT(("pmd%u overflowed\n", i));
+				}
+
+				DPRINT(("pmd%u set=%u val=0x%llx\n",
+					i,
+					set->set_id,
+					(unsigned long long)set->set_view->set_pmds[i]));
+			}
+		}
+		pfm_modview_end(set);
+	}
+}
+
+
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
+	ctx  = task->thread.pfm_context;
+
+	BUG_ON(ctx->ctx_fl_system);
+
+	spin_lock_irqsave(&ctx->ctx_lock, flags);
+
+	DPRINT(("state=%d\n", ctx->ctx_state));
+
+	/*
+	 * __pfm_unload_context() cannot fail
+	 * in the context states we are interested in
+	 */
+	switch(ctx->ctx_state) {
+		case PFM_CTX_LOADED:
+		case PFM_CTX_MASKED:
+			__pfm_unload_context(ctx);
+			pfm_end_notify_user(ctx);
+			break;
+		case PFM_CTX_ZOMBIE:
+			__pfm_unload_context(ctx);
+			free_ok = 1;
+			break;
+		default:
+			BUG_ON(ctx->ctx_state != PFM_CTX_LOADED);
+			break;
+	}
+	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
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
+		DPRINT(("invalid fd %d\n", fd));
+		return NULL;
+	}
+
+	if (unlikely(pfm_is_fd(filp) == 0)) {
+		DPRINT(("fd %d not related to perfmon\n", fd));
+		return NULL;
+	}
+	ctx = filp->private_data;
+
+	/*
+	 * sanity check
+	 */
+	if (filp != ctx->ctx_filp && ctx->ctx_filp) {
+		DPRINT(("filp is different\n"));
+	}
+
+	/*
+	 * update ctx_filp
+	 */
+	ctx->ctx_filp = filp;
+	return ctx;
+}
+
+int pfm_check_task_state(struct pfm_context *ctx, int check_mask,
+			 unsigned long *flags)
+{
+	struct task_struct *task;
+	unsigned long local_flags, new_flags;
+	int state, old_state;
+
+recheck:
+	/*
+	 * task is NULL for system-wide context
+	 */
+	task = ctx->ctx_task;
+	state = ctx->ctx_state;
+	local_flags = *flags;
+
+	DPRINT(("state=%d [%d] task_state=%ld check_mask=0x%x\n",
+		state,
+		task ? task->pid : -1,
+		task ? task->state : -1, check_mask));
+
+	if (state == PFM_CTX_UNLOADED)
+		return 0;
+	/*
+	 * no command can operate on a zombie context
+	 */
+	if (state == PFM_CTX_ZOMBIE)
+		return -EINVAL;
+
+	/*
+	 * at this point, state is PFM_CTX_LOADED or PFM_CTX_MASKED
+	 */
+
+	/*
+	 * some commands require the context to be unloaded to operate
+	 */
+	if (check_mask & PFM_CMD_UNLOADED)  {
+		DPRINT(("state=%d, cmd needs unloaded\n", state));
+		return -EBUSY;
+	}
+
+	/*
+	 * self-monitoring always ok.
+	 */
+	if (task == current)
+		return 0;
+
+	/*
+	 * for syswide, we accept if running on the cpu the context is bound
+	 * to. When monitoring another thread, must wait until stopped.
+	 */
+	if (ctx->ctx_fl_system) {
+		if (ctx->ctx_cpu != smp_processor_id())
+			return -EBUSY;
+		return 0;
+	}
+		
+	/*
+	 * monitoring another thread
+	 */
+	if (state == PFM_CTX_MASKED && (check_mask & PFM_CMD_UNLOAD) == 0)
+		return 0;
+	/*
+	 * state is PFM_CTX_LOADED.
+	 *
+	 * We could lift this restriction for UP but it would mean that
+	 * the user has no guarantee the task would not run between
+	 * two successive calls to perfmonctl(). That's probably OK.
+	 * If this user wants to ensure the task does not run, then
+	 * the task must be stopped.
+	 */
+	if (check_mask & PFM_CMD_STOPPED) {
+		if ((task->state != TASK_STOPPED)
+		     && (task->state != TASK_TRACED)) {
+			DPRINT(("[%d] task not in stopped state\n", task->pid));
+			return -EBUSY;
+		}
+		/*
+		 * task is now stopped, wait for ctxsw out
+		 *
+		 * This is an interesting point in the code.
+		 * We need to unprotect the context because
+		 * the pfm_ctxswout_thread() routines needs to grab
+		 * the same lock. There are danger in doing
+		 * this because it leaves a window open for
+		 * another task to get access to the context
+		 * and possibly change its state. The one thing
+		 * that is not possible is for the context to disappear
+		 * because we are protected by the VFS layer, i.e.,
+		 * get_fd()/put_fd().
+		 */
+		old_state = state;
+
+		DPRINT(("going wait_inactive for [%d] state=%ld flags=0x%lx\n",
+			task->pid,
+			task->state,
+			local_flags));
+
+		spin_unlock_irqrestore(&ctx->ctx_lock, local_flags);
+
+		wait_task_inactive(task);
+
+		spin_lock_irqsave(&ctx->ctx_lock, new_flags);
+
+		/*
+		 * flags may be different than when we released the lock
+		 */
+		*flags = new_flags;
+
+		/*
+		 * we must recheck to verify if state has changed
+		 */
+		if (ctx->ctx_state != old_state) {
+			DPRINT(("old_state=%d new_state=%d\n",
+				old_state,
+				ctx->ctx_state));
+			goto recheck;
+		}
+	}
+	return 0;
+}
+
+
+
+ /*
+  * pfm_handle_work() can be called with interrupts enabled
+  * (TIF_NEED_RESCHED) or disabled. The down_interruptible
+  * call may sleep, therefore we must re-enable interrupts
+  * to avoid deadlocks. It is safe to do so because this function
+  * is called ONLY when returning to user level (PUStk=1), in which case
+  * there is no risk of kernel stack overflow due to deep
+  * interrupt nesting.
+  */
+void __pfm_handle_work(void)
+{
+	struct pfm_context *ctx;
+	unsigned long flags, dummy_flags;
+	unsigned int reason;
+	int ret;
+
+	ctx = current->thread.pfm_context;
+	if (ctx == NULL) {
+		printk(KERN_ERR "perfmon: handle_work [%d] has no ctx\n",
+		       current->pid);
+		return;
+	}
+
+	BUG_ON(ctx->ctx_fl_system);
+
+	spin_lock_irqsave(&ctx->ctx_lock, flags);
+
+	clear_thread_flag(TIF_NOTIFY_RESUME);
+
+	/*
+	 * extract reason for being here and clear
+	 */
+	reason = ctx->ctx_fl_trap_reason;
+
+	if (reason == PFM_TRAP_REASON_NONE)
+		goto nothing_to_do;
+
+	ctx->ctx_fl_trap_reason = PFM_TRAP_REASON_NONE;
+
+	DPRINT(("reason=%d state=%d\n", reason, ctx->ctx_state));
+
+	/*
+	 * must be done before we check for simple-reset mode
+	 */
+	if (ctx->ctx_state == PFM_CTX_ZOMBIE)
+		goto do_zombie;
+
+	if (reason == PFM_TRAP_REASON_RESET)
+		goto skip_blocking;
+
+	/*
+	 * restore interrupt mask to what it was on entry.
+	 * Could be enabled/diasbled.
+	 */
+	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
+
+	/*
+	 * force interrupt enable because of down_interruptible()
+	 */
+	local_irq_enable();
+
+	DPRINT(("before block sleeping\n"));
+
+	/*
+	 * may go through without blocking on SMP systems
+	 * if restart has been received already by the time we call down()
+	 */
+	ret = wait_for_completion_interruptible(&ctx->ctx_restart_complete);
+
+	DPRINT(("after block sleeping ret=%d\n", ret));
+
+	/*
+	 * lock context and mask interrupts again
+	 * We save flags into a dummy because we may have
+	 * altered interrupts mask compared to entry in this
+	 * function.
+	 */
+	spin_lock_irqsave(&ctx->ctx_lock, dummy_flags);
+
+	if (ctx->ctx_state == PFM_CTX_ZOMBIE)
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
+	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
+	return;
+
+do_zombie:
+	DPRINT(("context is zombie, bailing out\n"));
+
+	__pfm_unload_context(ctx);
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
+static int pfm_notify_user(struct pfm_context *ctx, pfm_msg_t *msg)
+{
+	if (ctx->ctx_state == PFM_CTX_ZOMBIE) {
+		DPRINT(("ignoring overflow notification, owner is zombie\n"));
+		return 0;
+	}
+
+	DPRINT(("waking up somebody\n"));
+
+	if (msg)
+		wake_up_interruptible(&ctx->ctx_msgq_wait);
+
+	/*
+	 * safe, we are not in intr handler, nor in ctxsw when
+	 * we come here
+	 */
+	kill_fasync (&ctx->ctx_async_queue, SIGIO, POLL_IN);
+
+	return 0;
+}
+
+int pfm_ovfl_notify_user(struct pfm_context *ctx,
+			struct pfm_event_set *set,
+	     		unsigned long ip)
+{
+	pfm_msg_t *msg = NULL;
+	int max_cnt_pmd;
+	unsigned long *ovfl_pmds;
+
+	max_cnt_pmd = pfm_pmu_conf->max_cnt_pmd;
+
+	if (ctx->ctx_fl_no_msg == 0) {
+		msg = pfm_get_new_msg(ctx);
+		if (msg == NULL) {
+			/*
+			 * when message queue fills up it is because the user
+			 * did not extract the message, yet issued
+			 * pfm_restart(). At this point, we stop sending
+			 * notification, thus the user will not be able to get
+			 * new samples when using the default format.
+			 */
+			DPRINT_ovfl((KERN_ERR "perfmon: pfm_ovfl_notify_user no more"
+			       " notification msgs\n"));
+			return -1;
+		}
+
+		msg->pfm_ovfl_msg.msg_type = PFM_MSG_OVFL;
+		msg->pfm_ovfl_msg.msg_ovfl_pid = current->pid;
+		msg->pfm_ovfl_msg.msg_active_set = set->set_id;
+
+		ovfl_pmds = msg->pfm_ovfl_msg.msg_ovfl_pmds;
+
+		bitmap_copy(ovfl_pmds,
+			    set->set_ovfl_pmds,
+			    max_cnt_pmd);
+
+		msg->pfm_ovfl_msg.msg_ovfl_cpu = smp_processor_id();
+		msg->pfm_ovfl_msg.msg_ovfl_tid = current->tgid;
+		msg->pfm_ovfl_msg.msg_ovfl_ip = ip;
+	}
+
+	DPRINT(("ovfl msg: ip=0x%lx o_pmds=0x%lx\n",
+		ip,
+		set->set_ovfl_pmds[0]));
+
+	return pfm_notify_user(ctx, msg);
+}
+
+static int pfm_end_notify_user(struct pfm_context *ctx)
+{
+	pfm_msg_t *msg;
+
+	msg = pfm_get_new_msg(ctx);
+	if (msg == NULL) {
+		printk(KERN_ERR "perfmon: pfm_end_notify_user no more msgs\n");
+		return -1;
+	}
+	/* no leak */
+	memset(msg, 0, sizeof(*msg));
+
+	msg->type = PFM_MSG_END;
+
+	DPRINT(("end msg: msg=%p no_msg=%d\n",
+		msg,
+		ctx->ctx_fl_no_msg));
+
+	return pfm_notify_user(ctx, msg);
+}
+
+/*
+ * this function is called before pfm_init()
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
+	unsigned int i;
+
+	printk("perfmon: version %u.%u\n",
+		PFM_VERSION_MAJ,
+		PFM_VERSION_MIN);
+
+	pfm_ctx_cachep = kmem_cache_create("pfm_context",
+				   sizeof(struct pfm_context)+PFM_ARCH_CTX_SIZE,
+				   SLAB_HWCACHE_ALIGN, 0, NULL, NULL);
+	if (pfm_ctx_cachep == NULL) {
+		printk(KERN_ERR "cannot initialize context slab\n");
+		goto error_disable;
+	}
+
+	pfm_lg_set_cachep = kmem_cache_create("pfm_large_event_set",
+			   sizeof(struct pfm_event_set)+sizeof(pfm_set_view_t),
+			   SLAB_HWCACHE_ALIGN, 0, NULL, NULL);
+	if (pfm_lg_set_cachep == NULL) {
+		printk(KERN_ERR "cannot initialize large event set slab\n");
+		goto error_disable;
+	}
+
+	pfm_set_cachep = kmem_cache_create("pfm_event_set",
+					   sizeof(struct pfm_event_set),
+					   SLAB_HWCACHE_ALIGN, 0, NULL, NULL);
+	if (pfm_set_cachep == NULL) {
+		printk(KERN_ERR "cannot initialize event set slab\n");
+		goto error_disable;
+	}
+
+	if (pfm_proc_init())
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
+	for (i = 0; i < NR_CPUS; i++)
+		per_cpu(pfm_stats,i).pfm_intr_cycles_min = ~0;
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
+	DPRINT(("clearing state for [%d]\n", task->pid));
+	/*
+	 * cut link inherited from parent (current)
+	 */
+	task->thread.pfm_context = NULL;
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
+	spin_lock_irqsave(&ctx->ctx_lock, flags);
+
+	set = ctx->ctx_active_set;
+
+	/*
+	 * we decrement only when attached and not masked or zombie
+	 */
+	if (ctx->ctx_state != PFM_CTX_LOADED)
+		goto done;
+
+	/*
+	 * do not decrement timeout unless monitoring is active.
+	 */
+	if (ctx->ctx_fl_started == 0 && pfm_arch_is_active(ctx) == 0)
+		goto done;
+
+	set->set_timeout--;
+
+	__get_cpu_var(pfm_stats).pfm_handle_timeout_count++;
+
+	if (set->set_timeout == 0)
+		pfm_switch_sets(ctx, NULL, PFM_PMD_RESET_SHORT, 0);
+done:
+	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
+}
+
+int __pfm_start(struct pfm_context *ctx, pfarg_start_t *start)
+{
+	struct task_struct *task, *owner_task;
+	struct pfm_event_set *new_set, *old_set;
+	u64 now_itc;
+	unsigned long info = 0;
+	int state, is_self, flags, is_new_set;
+
+	state = ctx->ctx_state;
+	task = ctx->ctx_task;
+
+	/*
+	 * context must be loaded.
+	 * we do not support starting while in MASKED state
+	 * (mostly because of set switching issues)
+	 */
+	if (state != PFM_CTX_LOADED)
+		return -EINVAL;
+
+	owner_task = __get_cpu_var(pmu_owner);
+	old_set = new_set = ctx->ctx_active_set;
+
+	is_self = ctx->ctx_fl_system || task == current;
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
+			DPRINT(("event set%u does not exist\n", start->start_set));
+			return -EINVAL;
+		}
+	}
+	is_new_set = new_set != old_set;
+
+	DPRINT(("cur_set=%u req_set=%u\n",
+		ctx->ctx_active_set->set_id,
+		new_set->set_id));
+
+	/*
+	 * if we need to change the active set we need
+	 * to check if we can access the PMU
+	 */
+	if (is_new_set) {
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
+			ctx->ctx_active_set = new_set;
+			new_set->set_view->set_status |= PFM_SETVFL_ACTIVE;
+			new_set->set_priv_flags |= PFM_SETFL_PRIV_MOD_BOTH;
+		}
+	}
+	/*
+	 * at this point, monitoring is:
+	 * 	- stopped if we switched set (self-monitoring)
+	 * 	- stopped if never started
+	 * 	- started if calling pfm_start() in sequence
+	 */
+	now_itc = pfm_arch_get_itc();
+	flags = new_set->set_flags;
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
+	ctx->ctx_duration_start = now_itc;
+	new_set->set_duration_start = now_itc;
+
+	/*
+	 * monitoring has been explicitely started
+	 */
+	ctx->ctx_fl_started = 1;
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
+	state = ctx->ctx_state;
+	is_system = ctx->ctx_fl_system;
+	set = ctx->ctx_active_set;
+
+	/*
+	 * context must be attached (zombie cannot happen)
+	 */
+	if (state == PFM_CTX_UNLOADED)
+		return -EINVAL;
+
+	task = ctx->ctx_task;
+
+	DPRINT(("ctx_task=[%d] ctx_state=%d is_system=%d\n",
+		task ? task->pid : -1,
+		state,
+		is_system));
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
+		ctx->ctx_duration += now_itc - ctx->ctx_duration_start;
+		/*
+		 * don't update set duration if masked
+		 */
+		if (state == PFM_CTX_LOADED)
+			set->set_duration += now_itc - set->set_duration_start;
+	}
+
+	pfm_arch_stop(task, ctx, set);
+
+	ctx->ctx_fl_started = 0;
+
+	return 0;
+}
+
+int __pfm_restart(struct pfm_context *ctx)
+{
+	int state, is_system;
+
+	state = ctx->ctx_state;
+	is_system = ctx->ctx_fl_system;
+
+	switch(state) {
+		case PFM_CTX_MASKED:
+			break;
+		case PFM_CTX_LOADED:
+			if (ctx->ctx_smpl_addr && ctx->ctx_smpl_fmt->fmt_restart)
+				break;
+			/* fall through */
+		case PFM_CTX_UNLOADED:
+		case PFM_CTX_ZOMBIE:
+			DPRINT(("invalid state=%d\n", state));
+			return -EBUSY;
+		default:
+			DPRINT(("state=%d with no active_restart handler)\n",
+				state));
+			return -EINVAL;
+	}
+	/*
+	 * at this point, the context is either LOADED or MASKED
+	 */
+
+	if (ctx->ctx_task == current || is_system) {
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
+		if (ctx->ctx_fl_can_restart == 0) {
+			DPRINT(("cannot restart can_restart=%d\n",
+				ctx->ctx_fl_can_restart));
+			return -EBUSY;
+		}
+		/*
+		 * prevent subsequent restart before this one is
+		 * seen by the task
+		 */
+		ctx->ctx_fl_can_restart = 0;
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
+	if (ctx->ctx_fl_block && state == PFM_CTX_MASKED) {
+		DPRINT(("unblocking [%d] \n", ctx->ctx_task->pid));
+		complete(&ctx->ctx_restart_complete);
+	} else {
+		struct thread_info *info;
+
+		DPRINT(("[%d] armed exit trap\n", ctx->ctx_task->pid));
+
+		/*
+		 * mark work pending
+		 */
+		ctx->ctx_fl_trap_reason = PFM_TRAP_REASON_RESET;
+
+		info = ctx->ctx_task->thread_info;
+		set_bit(TIF_NOTIFY_RESUME, &info->flags);
+
+		/*
+		 * XXX: send reschedule if task runs on another CPU
+		 */
+	}
+	return 0;
+}
+/*
+ * XXX: interrupts are masked yet monitoring may be active. Hence they
+ * might be a counter overflow during the call. It will be kept pending
+ * and we might return inconsistent unless we check the state of the counter
+ * and compensate for the overflow. Note that we will not loose a sample
+ * when sampling, however, there may be an issue with simple counting and
+ * virtualization.
+ */
+int __pfm_read_pmds(struct pfm_context *ctx, pfarg_pmd_t *req, int count)
+{
+	u64 val = 0, lval, ovfl_mask, hw_val;
+	u64 sw_cnt;
+	unsigned long *impl_pmds;
+	struct pfm_event_set *set, *active_set;
+	int i, can_access_pmu = 0;
+	int is_system, has_rd_check, error_code;
+	u16 cnum, pmd_type, set_id, prev_set_id, max_pmd;
+	pfm_reg_check_t rd_func;
+
+	is_system = ctx->ctx_fl_system;
+	ovfl_mask = pfm_pmu_conf->ovfl_mask;
+	rd_func = pfm_pmu_conf->pmd_read_check;
+	impl_pmds = pfm_pmu_conf->impl_pmds;
+	max_pmd   = pfm_pmu_conf->max_pmd;
+	active_set = ctx->ctx_active_set;
+	set = NULL;
+	prev_set_id = 0;
+
+	if (likely(ctx->ctx_state == PFM_CTX_LOADED)) {
+		/*
+		 * this can be true when not self-monitoring only in UP
+		 */
+		can_access_pmu = __get_cpu_var(pmu_owner) == ctx->ctx_task || is_system;
+
+		if (can_access_pmu)
+			pfm_arch_serialize();
+	}
+	has_rd_check = rd_func != NULL && (pfm_sysctl.expert_mode == 0);
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
+				DPRINT(("event set%u does not exist\n", set_id));
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
+		if (unlikely(pfm_bv_isset(set->set_used_pmds, cnum) == 0)) {
+			DPRINT(("pmd%u cannot be read, because never requested\n", cnum));
+			goto error;
+		}
+
+		/*
+		 * it is possible to read PMD registers which have not
+		 * explicitely been written by the application. In this case
+		 * the default value is returned.
+		 */
+		val = set->set_view->set_pmds[cnum];
+		lval = set->set_pmds[cnum].lval;
+
+		/*
+		 * extract remaining ovfl to switch
+		 */
+		sw_cnt = set->set_pmds[cnum].ovflsw_thres;
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
+		/*
+		 * execute read checker, if any
+		 * a read checker cannot fail, it can simply modify the
+		 * value returned.
+		 */
+		if (unlikely(has_rd_check && (pmd_type & PFM_REG_RC))) {
+			u64 v = val;
+			(*rd_func)(ctx, set, cnum, req->reg_flags, &v);
+			val = v;
+		}
+
+		DPRINT(("set%u pmd%u=0x%llx switch_thres=%llu\n",
+			set->set_id,
+			cnum,
+			(unsigned long long)val,
+			(unsigned long long)sw_cnt));
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
+int __pfm_write_pmds(struct pfm_context *ctx, pfarg_pmd_t *req, int count,
+		     int compat)
+{
+#define PFM_REGFL_PMD_ALL	(PFM_REGFL_RANDOM|PFM_REGFL_OVFL_NOTIFY|PFM_REG_RETFL_MASK)
+	struct pfm_event_set *set, *active_set;
+	u64 value, hw_val, ovfl_mask;
+	unsigned long *smpl_pmds, *reset_pmds, *impl_pmds;
+	u32 req_flags, flags;
+	u16 cnum, pmd_type, max_pmd, max_pmc;
+	u16 set_id, prev_set_id;
+	int i, can_access_pmu;
+	int is_counting, is_system;
+	int has_wr_check;
+	int ret, error_code;
+	pfm_reg_check_t wr_func;
+
+	is_system = ctx->ctx_fl_system;
+	ovfl_mask = pfm_pmu_conf->ovfl_mask;
+	active_set = ctx->ctx_active_set;
+	wr_func = pfm_pmu_conf->pmd_write_check;
+	max_pmd	= pfm_pmu_conf->max_pmd;
+	max_pmc	= pfm_pmu_conf->max_pmc;
+	impl_pmds = pfm_pmu_conf->impl_pmds;
+	set = NULL;
+
+	prev_set_id = 0;
+	can_access_pmu = 0;
+
+	has_wr_check = wr_func != NULL && (pfm_sysctl.expert_mode == 0);
+
+	/*
+	 * we cannot access the actual PMD registers when monitoring is masked
+	 */
+	if (likely(ctx->ctx_state == PFM_CTX_LOADED))
+		can_access_pmu = __get_cpu_var(pmu_owner) == ctx->ctx_task
+			       || is_system;
+
+	error_code = PFM_REG_RETFL_EINVAL;
+	ret = -EINVAL;
+
+	for (i = 0; i < count; i++, req++) {
+
+		cnum = req->reg_num;
+		value = req->reg_value;
+		set_id = req->reg_set;
+		req_flags = req->reg_flags;
+		smpl_pmds = req->reg_smpl_pmds;
+		reset_pmds = req->reg_reset_pmds;
+		flags = 0;
+
+		if (unlikely(cnum >= max_pmd || !pfm_bv_isset(impl_pmds, cnum))) {
+			DPRINT(("pmd%u is not implemented or not accessible\n", cnum));
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
+					DPRINT(("pmd%u: invalid flags=0x%x\n", cnum, req_flags));
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
+				if (unlikely(bitmap_subset(smpl_pmds, impl_pmds, max_pmd) == 0)) {
+					DPRINT(("invalid smpl_pmds=0x%llx for pmd%u\n",
+						(unsigned long long)smpl_pmds[0],
+						cnum));
+					goto error;
+				}
+				/*
+				 * verify validity of reset_pmds
+				 */
+				if (unlikely(bitmap_subset(reset_pmds, impl_pmds, max_pmd) == 0)) {
+					DPRINT(("invalid reset_pmds=0x%llx for pmd%u\n",
+						(unsigned long long)reset_pmds[0],
+						cnum));
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
+				DPRINT(("event set%u does not exist\n", set_id));
+				error_code = PFM_REG_RETFL_NOSET;
+				goto error;
+			}
+		}
+
+		/*
+		 * execute write checker, if any
+		 */
+		if (unlikely(has_wr_check && (pmd_type & PFM_REG_WC))) {
+			u64 v = value;
+
+			ret = (*wr_func)(ctx, set, cnum, req_flags, &v);
+			if (ret)
+				goto error;
+
+			value = v;
+			ret   = -EINVAL;
+		}
+
+		pfm_modview_begin(set);
+
+		/*
+		 * now commit changes to software state
+		 */
+		hw_val = value;
+
+		if (likely(is_counting)) {
+			if (likely(compat == 0)) {
+
+				set->set_pmds[cnum].flags = flags;
+
+				/*
+				 * copy reset and sampling bitvectors
+				 */
+				bitmap_copy(set->set_pmds[cnum].reset_pmds,
+					    reset_pmds,
+					    max_pmd);
+
+				bitmap_copy(set->set_pmds[cnum].smpl_pmds,
+					    smpl_pmds,
+					    max_pmd);
+
+				set->set_pmds[cnum].eventid = req->reg_smpl_eventid;
+
+				/*
+				 * Mark reset/smpl PMDS as used.
+				 *
+				 * We do not keep track of PMC because we have to
+				 * systematically restore ALL of them.
+				 */
+				bitmap_or(set->set_used_pmds,
+					  set->set_used_pmds,
+					  reset_pmds, max_pmd);
+
+				bitmap_or(set->set_used_pmds,
+					  set->set_used_pmds,
+					  smpl_pmds, max_pmd);
+
+				/*
+				 * we reprogrammed the PMD hence, clear any pending
+				 * ovfl, switch based on the old value
+				 * for restart we have already established new values
+				 */
+				pfm_bv_clear(set->set_povfl_pmds, cnum);
+				pfm_bv_clear(set->set_ovfl_pmds, cnum);
+
+				/*
+				 * update ovfl_notify
+				 */
+				if (flags & PFM_REGFL_OVFL_NOTIFY)
+					pfm_bv_set(set->set_ovfl_notify, cnum);
+				else
+					pfm_bv_clear(set->set_ovfl_notify, cnum);
+			}
+			/*
+			 * reset last value to new value
+			 */
+			set->set_pmds[cnum].lval = value;
+
+			hw_val = value & ovfl_mask;
+
+			/*
+			 * establish new switch count
+			 */
+			set->set_pmds[cnum].ovflsw_thres = req->reg_ovfl_switch_cnt;
+			set->set_pmds[cnum].ovflsw_ref_thres = req->reg_ovfl_switch_cnt;
+		}
+
+		/*
+		 * update reset values (not just for counters)
+		 */
+		set->set_pmds[cnum].long_reset = req->reg_long_reset;
+		set->set_pmds[cnum].short_reset = req->reg_short_reset;
+
+		/*
+		 * update randomization parameters (not just for counters)
+		 */
+		set->set_pmds[cnum].seed = req->reg_random_seed;
+		set->set_pmds[cnum].mask = req->reg_random_mask;
+
+		/*
+		 * update set values
+		 */
+		set->set_view->set_pmds[cnum] = value;
+
+		pfm_modview_end(set);
+
+		pfm_bv_set(set->set_used_pmds, cnum);
+
+		if (set == active_set) {
+			set->set_priv_flags |= PFM_SETFL_PRIV_MOD_PMDS;
+			if (can_access_pmu)
+				pfm_write_pmd(ctx, cnum, hw_val);
+		}
+
+		/*
+		 * update number of used PMD registers
+		 */
+		set->set_nused_pmds = bitmap_weight(set->set_used_pmds, max_pmd);
+
+		pfm_retflag_set(req->reg_flags, 0);
+
+		prev_set_id = set_id;
+
+		DPRINT(("set%u pmd%u=0x%llx flags=0x%x"
+			" a_pmu=%d hw_pmd=0x%llx ctx_pmd=0x%llx s_reset=0x%llx"
+			" l_reset=0x%llx u_pmds=0x%lx nu_pmds=%u s_pmds=0x%lx"
+			" r_pmds=0x%lx o_pmds=0x%lx o_thres=%llu compat=%d"
+			" eventid=%llx\n",
+			set->set_id,
+			cnum,
+			(unsigned long long)value,
+			set->set_pmds[cnum].flags,
+			can_access_pmu,
+			(unsigned long long)hw_val,
+			(unsigned long long)set->set_view->set_pmds[cnum],
+			(unsigned long long)set->set_pmds[cnum].short_reset,
+			(unsigned long long)set->set_pmds[cnum].long_reset,
+			set->set_used_pmds[0],
+			set->set_nused_pmds,
+			set->set_pmds[cnum].smpl_pmds[0],
+			set->set_pmds[cnum].reset_pmds[0],
+			set->set_ovfl_pmds[0],
+			(unsigned long long)set->set_pmds[cnum].ovflsw_thres,
+			compat,
+			(unsigned long long)set->set_pmds[cnum].eventid));
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
+int __pfm_write_pmcs(struct pfm_context *ctx, pfarg_pmc_t *req, int count)
+{
+#define PFM_REGFL_PMC_ALL	(PFM_REGFL_NO_EMUL64|PFM_REG_RETFL_MASK)
+	struct pfm_event_set *set, *active_set;
+	u64 value, default_value, reserved_mask;
+	unsigned long *impl_pmcs;
+	int i, can_access_pmu;
+	int is_system, has_wr_check;
+	int ret, error_code;
+	u16 set_id, prev_set_id;
+	u16 cnum, pmc_type, max_pmc;
+	u32 flags;
+	pfm_reg_check_t	wr_func;
+
+	is_system  = ctx->ctx_fl_system;
+	active_set = ctx->ctx_active_set;
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
+	if (likely(ctx->ctx_state == PFM_CTX_LOADED))
+		can_access_pmu = __get_cpu_var(pmu_owner) == ctx->ctx_task
+			      || is_system;
+
+	error_code  = PFM_REG_RETFL_EINVAL;
+
+	has_wr_check = wr_func != NULL && (pfm_sysctl.expert_mode == 0);
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
+			DPRINT(("pmc%u is not implemented/unaccessible\n", cnum));
+			goto error;
+		}
+
+		pmc_type = pfm_pmu_conf->pmc_desc[cnum].type;
+		default_value = pfm_pmu_conf->pmc_desc[cnum].default_value;
+		reserved_mask = pfm_pmu_conf->pmc_desc[cnum].reserved_mask;
+
+		/*
+		 * ensure only valid flags are set
+		 */
+		if (flags & ~(PFM_REGFL_PMC_ALL)) {
+			DPRINT(("pmc%u: invalid flags=0x%x\n", cnum, flags));
+			goto error;
+		}
+
+		/*
+		 * locate event set
+		 */
+		if (i == 0 || set_id != prev_set_id) {
+			set = pfm_find_set(ctx, set_id, 0);
+			if (set == NULL) {
+				DPRINT(("event set%u does not exist\n", set_id));
+				error_code = PFM_REG_RETFL_NOSET;
+				goto error;
+			}
+		}
+
+		/*
+		 * set reserved bits to default values
+		 */
+		value = (value & reserved_mask) | (default_value & ~reserved_mask);
+
+		if (flags & PFM_REGFL_NO_EMUL64) {
+			if ((pmc_type & PFM_REG_NO64) == 0) {
+				DPRINT(("pmc%u no support PFM_REGFL_NO_EMUL64\n", cnum));
+				goto error;
+			}
+			value &= ~pfm_pmu_conf->pmc_desc[cnum].no_emul64_mask;
+		}
+
+		/*
+		 * execute write checker, if any
+		 */
+		if (likely(has_wr_check && (pmc_type & PFM_REG_WC))) {
+			u64 v = value;
+			ret = (*wr_func)(ctx, set, cnum, flags, &v);
+			if (ret)
+				goto error;
+			value = v ;
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
+		if (pfm_bv_isset(set->set_used_pmcs, cnum) == 0) {
+			pfm_bv_set(set->set_used_pmcs, cnum);
+			set->set_nused_pmcs++;
+		}
+
+		set->set_pmcs[cnum] = value;
+
+		if (set == active_set) {
+			set->set_priv_flags |= PFM_SETFL_PRIV_MOD_PMCS;
+			if (can_access_pmu)
+				pfm_arch_write_pmc(ctx, cnum, value);
+		}
+
+		pfm_retflag_set(req->reg_flags, 0);
+
+		prev_set_id = set_id;
+
+		DPRINT(("set%u pmc%u=0x%llx a_pmu=%d u_pmcs=0x%llx nu_pmcs=%u\n",
+			set->set_id,
+			cnum,
+			(unsigned long long)value,
+			can_access_pmu,
+			(unsigned long long)set->set_used_pmcs[0],
+			set->set_nused_pmcs));
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
+/*
+ * should not call when task == current
+ */
+static int pfm_bad_permissions(struct task_struct *task)
+{
+	/* inspired by ptrace_attach() */
+	DPRINT(("cur: euid=%d uid=%d gid=%d "
+		"task: euid=%d suid=%d uid=%d egid=%d cap:%d"
+		"sgid=%d\n",
+		current->euid,
+		current->uid,
+		current->gid,
+		task->euid,
+		task->suid,
+		task->uid,
+		task->egid,
+		task->sgid, capable(CAP_SYS_PTRACE)));
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
+	 * no kernel task or task not owner by caller
+	 */
+	if (task->mm == NULL) {
+		DPRINT(("task [%d] has no mm (kernel thread)\n", task->pid));
+		return -EPERM;
+	}
+	if (pfm_bad_permissions(task)) {
+		DPRINT(("no permission to attach to [%d]\n", task->pid));
+		return -EPERM;
+	}
+	/*
+	 * cannot block in self-monitoring mode
+	 */
+	if (ctx->ctx_fl_block && task == current) {
+		DPRINT(("cannot load a in blocking mode on self for [%d]\n",
+			task->pid));
+		return -EINVAL;
+	}
+
+	if (task->state == EXIT_ZOMBIE || task->state == EXIT_DEAD) {
+		DPRINT(("cannot attach to zombie/dead task [%d]\n", task->pid));
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
+		DPRINT(("cannot attach to non-stopped task [%d] state=%ld\n",
+			task->pid, task->state));
+		return -EBUSY;
+	}
+	DPRINT(("before wait_inactive() task [%d] state=%ld\n",
+		task->pid, task->state));
+	/*
+	 * make sure the task is off any CPU
+	 */
+	wait_task_inactive(task);
+
+	DPRINT(("after wait_inactive() task [%d] state=%ld\n",
+		task->pid, task->state));
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
+		if (t->thread.pfm_context == ctx) {
+			ret = 0;
+			break;
+		}
+	} while_each_thread (g, t);
+
+	read_unlock(&tasklist_lock);
+
+	DPRINT(("pfm_check_task_exist: ret=%d ctx=%p\n", ret, ctx));
+
+	return ret;
+}
+
+
+static int pfm_load_context_thread(struct pfm_context *ctx, pid_t pid,
+				   struct pfm_event_set *set)
+{
+	struct task_struct *task = NULL;
+	struct thread_struct *thread;
+	struct pfm_context *old;
+	u32 set_flags;
+	unsigned long info;
+	int ret, state;
+
+	state = ctx->ctx_state;
+	set_flags = set->set_flags;
+
+	DPRINT(("load_pid [%d] set=%u runs=%llu set_flags=0x%x\n",
+		pid,
+		set->set_id,
+		(unsigned long long)set->set_view->set_runs,
+		set_flags));
+
+	if (ctx->ctx_fl_block && pid == current->pid) {
+		DPRINT(("cannot use blocking mode in while self-monitoring\n"));
+		return -EINVAL;
+	}
+
+	ret = pfm_get_task(ctx, pid, &task);
+	if (ret) {
+		DPRINT(("load_pid [%d] get_task=%d\n", pid, ret));
+		return ret;
+	}
+
+	ret = pfm_arch_load_context(ctx, task);
+	if (ret) {
+		put_task_struct(task);
+		return ret;
+	}
+
+	thread = &task->thread;
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
+	DPRINT(("before cmpxchg() old_ctx=%p new_ctx=%p\n",
+		thread->pfm_context, ctx));
+
+	ret = -EEXIST;
+
+	old = cmpxchg(&thread->pfm_context, NULL, ctx);
+	if (old != NULL) {
+		DPRINT(("load_pid [%d] has already a context old=%p new=%p"
+			" cur=%p\n",
+			pid,
+			old,
+			ctx,
+			thread->pfm_context));
+		goto error_unres;
+	}
+
+	if (set_flags & PFM_SETFL_OVFL_SWITCH) {
+		pfm_reload_switch_thresholds(set);
+	} else if (set_flags & PFM_SETFL_TIME_SWITCH) {
+		set->set_timeout = set->set_switch_timeout;
+	}
+
+	/*
+	 * link context to task
+	 */
+	ctx->ctx_task = task;
+
+	/*
+	 * commit active set
+	 */
+	ctx->ctx_active_set = set;
+
+	pfm_modview_begin(set);
+
+	set->set_view->set_runs++;
+
+	set->set_view->set_status |= PFM_SETVFL_ACTIVE;
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
+		DPRINT(("context loaded on PMU for [%d]\n", task->pid));
+	} else {
+
+		/* force a full reload */
+		ctx->ctx_last_act = PFM_INVALID_ACTIVATION;
+		pfm_set_last_cpu(ctx, -1);
+		set->set_priv_flags |= PFM_SETFL_PRIV_MOD_BOTH;
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
+				ctx->ctx_state = PFM_CTX_UNLOADED;
+				ctx->ctx_task = NULL;
+			}
+		}
+	}
+	return ret;
+}
+
+static int pfm_load_context_sys(struct pfm_context *ctx, struct pfm_event_set *set)
+{
+	u32 set_flags;
+	unsigned long info;
+	u32 my_cpu;
+	int ret;
+
+	my_cpu = smp_processor_id();
+
+	set_flags = set->set_flags;
+
+	ret = pfm_arch_load_context(ctx, NULL);
+	if (ret)
+		return ret;
+
+	DPRINT(("cpu=%d set=%u runs=%llu set_flags=0x%x\n",
+		smp_processor_id(),
+		set->set_id,
+		(unsigned long long)set->set_view->set_runs,
+		set_flags));
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
+	ctx->ctx_cpu = my_cpu;
+	ctx->ctx_task = NULL;
+
+	/*
+	 * setting PFM_CPUINFO_TIME_SWITCH, triggers
+	 * further checking if __pfm_handle_switch_timeout().
+	 * switch timeout is effectively decremented only when
+	 * monitoring has been activated via pfm_start() or
+	 * any user level equivalent.
+	 */
+	if (set_flags & PFM_SETFL_OVFL_SWITCH) {
+		pfm_reload_switch_thresholds(set);
+	} else if (set_flags & PFM_SETFL_TIME_SWITCH) {
+		set->set_timeout = set->set_switch_timeout;
+		info = PFM_CPUINFO_TIME_SWITCH;
+		__get_cpu_var(pfm_syst_info) = info;
+	}
+
+	pfm_modview_begin(set);
+
+	set->set_view->set_runs++;
+
+	/*
+	 * commit active set
+	 */
+	ctx->ctx_active_set = set;
+	set->set_view->set_status |= PFM_SETVFL_ACTIVE;
+
+	/*
+	 * load all registes from ctx to PMU
+	 */
+	pfm_arch_restore_pmds(ctx, set);
+	pfm_arch_restore_pmcs(ctx, set);
+
+	pfm_modview_end(set);
+
+	set->set_priv_flags &= ~PFM_SETFL_PRIV_MOD_BOTH;
+
+	DPRINT(("context loaded on CPU%d\n", my_cpu));
+
+	pfm_set_pmu_owner(NULL, ctx);
+
+	return 0;
+}
+int __pfm_load_context(struct pfm_context *ctx, pfarg_load_t *req)
+{
+	struct pfm_event_set *set;
+	int ret = 0;
+
+	/*
+	 * can only load from unloaded
+	 */
+	if (ctx->ctx_state != PFM_CTX_UNLOADED) {
+		DPRINT(("context already loaded\n"));
+		return -EBUSY;
+	}
+
+	set = pfm_find_set(ctx, req->load_set, 0);
+	if (set == NULL) {
+		DPRINT(("event set%u does not exist\n",req->load_set));
+		return -EINVAL;
+	}
+	/*
+	 * assess sanity of the event sets
+	 */
+	ret = pfm_prepare_sets(ctx);
+	if (ret) {
+		DPRINT(("invalid next field pointers in the sets\n"));
+		return -EINVAL;
+	}
+
+	if (ctx->ctx_fl_system)
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
+	ctx->ctx_duration = 0;
+	ctx->ctx_fl_started = 0;
+	ctx->ctx_fl_trap_reason = PFM_TRAP_REASON_NONE;
+	ctx->ctx_fl_can_restart = 0;
+	ctx->ctx_state = PFM_CTX_LOADED;
+
+	return 0;
+}
+
+int __pfm_unload_context(struct pfm_context *ctx)
+{
+	struct task_struct *task;
+	struct pfm_event_set *set;
+	int state, ret, is_self;
+
+	state = ctx->ctx_state;
+
+	/*
+	 * unload only when necessary
+	 */
+	if (state == PFM_CTX_UNLOADED) {
+		DPRINT(("nothing to do\n"));
+		return 0;
+	}
+	task = ctx->ctx_task;
+	set = ctx->ctx_active_set;
+	is_self = ctx->ctx_fl_system || task == current;
+
+	DPRINT(("ctx_state=%d task [%d]\n", state, task ? task->pid : -1));
+
+	/*
+	 * stop monitoring
+	 */
+	ret = __pfm_stop(ctx);
+	if (ret)
+		return ret;
+
+	pfm_modview_begin(set);
+	set->set_view->set_status &= ~PFM_SETVFL_ACTIVE;
+	pfm_modview_end(set);
+
+	ctx->ctx_state = PFM_CTX_UNLOADED;
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
+	if (state != PFM_CTX_ZOMBIE)
+		pfm_release_session(ctx, ctx->ctx_cpu);
+
+	/*
+	 * reset activation counter
+	 */
+	ctx->ctx_last_act = PFM_INVALID_ACTIVATION;
+	pfm_set_last_cpu(ctx, -1);
+
+	/*
+	 * break links between context and task
+	 */
+	if (task) {
+		task->thread.pfm_context = NULL;
+		ctx->ctx_task = NULL;
+	}
+	DPRINT(("done, state was %d\n", state));
+	return 0;
+}
+
+/*
+ * context is unloaded for this command. Interrupts are enabled
+ */
+int __pfm_delete_evtsets(struct pfm_context *ctx, void *arg, int count)
+{
+	pfarg_setdesc_t *req = arg;
+	struct pfm_event_set *set, *prev;
+	kmem_cache_t *cachep;
+	u16 set_id;
+	size_t view_size;
+	int is_loaded, i;
+
+	is_loaded = ctx->ctx_state == PFM_CTX_LOADED;
+	view_size = PAGE_ALIGN(sizeof(pfm_set_view_t));
+
+	DPRINT(("active_set=%u\n", ctx->ctx_active_set->set_id));
+
+	if (ctx->ctx_fl_mapset) {
+		cachep = pfm_set_cachep;
+	} else {
+		cachep = pfm_lg_set_cachep;
+	}
+
+	for (i = 0; i < count; i++, req++) {
+		set_id = req->set_id;
+		/*
+		 * cannot remove set 0
+		 */
+		if (set_id == 0)
+			goto error;
+
+		DPRINT(("set_id=%u\n", set_id));
+		prev = NULL;
+		for (set = ctx->ctx_sets; set; set = set->set_next) {
+			if (set->set_id == set_id) goto found;
+			prev = set;
+		}
+		DPRINT(("set_id=%u not found\n", set_id));
+error:
+		pfm_retflag_set(req->set_flags, PFM_REG_RETFL_EINVAL);
+		return -EINVAL;
+found:
+		if (is_loaded && set == ctx->ctx_active_set)
+			goto error;
+
+		if (prev)
+			prev->set_next = set->set_next;
+		else
+			ctx->ctx_sets = set->set_next;
+		/*
+		 * correct active set if necessary
+		 */
+		if (set == ctx->ctx_active_set) {
+			ctx->ctx_active_set = set->set_next ?
+					      set->set_next : ctx->ctx_sets;
+		}
+
+		vfree(set->set_view);
+		kmem_cache_free(cachep, set);
+
+		pfm_retflag_set(req->set_flags, 0);
+	}
+	return 0;
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
+		DPRINT(("both switch ovfl and switch time are set\n"));
+		return -EINVAL;
+	}
+
+	if ((flags & PFM_SETFL_EXCL_IDLE) != 0 && ctx->ctx_fl_system == 0) {
+		DPRINT(("excl idle is for system wide only\n"));
+		return -EINVAL;
+	}
+	return 0;
+}
+
+/*
+ * it is never possible to change the identification of an existing set
+ */
+static int __pfm_change_event_set(struct pfm_context *ctx,
+				  struct pfm_event_set *set,
+				  pfarg_setdesc_t *req)
+{
+	u32 flags;
+	u16 set_id, set_id_next, max_pmd;
+	unsigned long ji;
+	struct timespec ts;
+	int ret;
+
+	BUG_ON(ctx->ctx_state == PFM_CTX_LOADED);
+
+	set_id = req->set_id;
+	set_id_next = req->set_id_next;
+	flags = req->set_flags;
+	max_pmd	= pfm_pmu_conf->max_pmd;
+
+	ret = pfm_setfl_sane(ctx, flags);
+	if (ret) {
+		DPRINT(("invalid flags 0x%x set %u\n", flags, set_id));
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
+	set->set_id = set_id;
+	set->set_id_next = set_id_next;
+	set->set_flags = flags;
+	set->set_priv_flags = 0;
+
+	/*
+	 * XXX: what about set_priv_flags
+	 */
+
+	/*
+	 * reset pointer to next set
+	 */
+	set->set_switch_next = NULL;
+
+	ji = timespec_to_jiffies(&req->set_timeout);
+	/*
+	 * verify that timeout is not 0
+	 */
+	if (ji == 0 && (flags & PFM_SETFL_TIME_SWITCH) != 0) {
+		DPRINT(("invalid timeout=0\n"));
+		return -EINVAL;
+	}
+
+	set->set_switch_timeout = set->set_timeout = ji;
+
+	jiffies_to_timespec(ji, &ts);
+
+	DPRINT(("set %u flags=0x%x id_next=%u req_sec=%lus req_nsec=%lu"
+		" jiffies=%lu "
+		" runs=%llu HZ=%u  TICK_NSEC=%lu eff_sec=%lu eff_nsec=%lun\n",
+		set_id,
+		flags,
+		set_id_next,
+		req->set_timeout.tv_sec,
+		req->set_timeout.tv_nsec,
+		ji,
+		(unsigned long long)set->set_view->set_runs,
+		HZ, TICK_NSEC,
+		ts.tv_sec,
+		ts.tv_nsec));
+	/*
+	 * return actual timeout used in ms
+	 */
+	req->set_timeout = ts;
+	req->set_mmap_offset = set->set_mmap_offset;
+
+	return 0;
+}
+
+/*
+ * context is unloaded for this command. Interrupts are enabled
+ */
+int __pfm_create_evtsets(struct pfm_context *ctx, pfarg_setdesc_t *req,
+			int count)
+{
+	struct pfm_event_set *set;
+	u16 set_id;
+	int i, ret;
+
+	for (i = 0; i < count; i++, req++) {
+		set_id = req->set_id;
+
+		DPRINT(("set_id=%u\n", set_id));
+
+		set = pfm_find_set(ctx, set_id, 1);
+		if (set == NULL)
+			goto error_mem;
+
+		ret = __pfm_change_event_set(ctx, set, req);
+		if (ret)
+			goto error_params;
+
+		pfm_init_evtset(set);
+	}
+	return 0;
+error_mem:
+	DPRINT(("cannot allocate set %u\n", set_id));
+	pfm_retflag_set(req->set_flags, PFM_REG_RETFL_EINVAL);
+	return -ENOMEM;
+error_params:
+	pfm_retflag_set(req->set_flags, PFM_REG_RETFL_EINVAL);
+	return ret;
+}
+
+int __pfm_getinfo_evtsets(struct pfm_context *ctx, pfarg_setinfo_t *req,
+				 int count)
+{
+	struct pfm_event_set *set;
+	struct timespec ts;
+	int i, is_system, is_loaded;
+	u16 set_id;
+	int max_cnt_pmd;
+	u64 end_cycles;
+
+	DPRINT(("active_set=%u\n", ctx->ctx_active_set->set_id));
+
+	end_cycles = pfm_arch_get_itc();
+	is_system = ctx->ctx_fl_system;
+	is_loaded = ctx->ctx_state == PFM_CTX_LOADED;
+	max_cnt_pmd = pfm_pmu_conf->max_cnt_pmd;
+
+	for (i = 0; i < count; i++, req++) {
+
+		set_id = req->set_id;
+
+		DPRINT(("set_id=%u\n", set_id));
+
+		for (set = ctx->ctx_sets; set; set = set->set_next) {
+			if (set->set_id == set_id)
+				goto found;
+		}
+		DPRINT(("set %u not found\n", set_id));
+		pfm_retflag_set(req->set_flags, PFM_REG_RETFL_EINVAL);
+		return -EINVAL;
+found:
+		/*
+		 * compute leftover timeout
+		 */
+		jiffies_to_timespec(set->set_timeout, &ts);
+
+		req->set_flags = set->set_flags;
+		req->set_timeout = ts;
+		req->set_runs = set->set_view->set_runs;
+		req->set_act_duration = set->set_duration;
+		req->set_mmap_offset = set->set_mmap_offset;
+
+		/*
+		 * adjust for active set if needed
+		 */
+		if (is_system && is_loaded && ctx->ctx_fl_started
+		    && set == ctx->ctx_active_set)
+			req->set_act_duration  += end_cycles
+						- set->set_duration_start;
+
+		/*
+		 * copy the list of pmds which last overflowed for
+		 * the set
+		 */
+		bitmap_copy(req->set_ovfl_pmds,
+			    set->set_ovfl_pmds,
+			    max_cnt_pmd);
+
+		pfm_retflag_set(req->set_flags, 0);
+
+		DPRINT(("set %u flags=0x%x eff_sec=%lu eff_nsec=%lu runs=%llu\n",
+			set_id,
+			set->set_flags,
+			ts.tv_sec,
+			ts.tv_nsec,
+			(unsigned long long)set->set_view->set_runs));
+	}
+	return 0;
+}
+
+
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
+			DPRINT(("cannot use blocking mode in syswide mode\n"));
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
+	   && pfm_sysctl.sys_group != PFM_GROUP_PERM_ANY
+	   && in_group_p(pfm_sysctl.sys_group)) {
+		DPRINT(("user group not allowed to create a syswide ctx\n"));
+		return -EPERM;
+	} else if (pfm_sysctl.task_group != PFM_GROUP_PERM_ANY
+		   && in_group_p(pfm_sysctl.task_group)) {
+		DPRINT(("user group not allowed to create a task context\n"));
+		return -EPERM;
+	}
+	return -0;
+}
+
+
+int __pfm_create_context(pfarg_ctx_t *req, struct pfm_smpl_fmt *fmt,
+			 void *fmt_arg, int compat_mode,
+			 struct pfm_context **new_ctx)
+{
+	struct pfm_context *ctx;
+	struct file *filp = NULL;
+	u32 ctx_flags;
+	int fd, ret;
+
+	ctx_flags = req->ctx_flags;
+
+	ret = pfm_ctx_flags_sane(ctx_flags);
+	if (ret < 0)
+		return ret;
+
+	if (pfm_ctx_permissions(ctx_flags))
+		return -EPERM;
+
+	ret = -ENOMEM;
+	ctx = pfm_context_alloc();
+	if (!ctx)
+		goto error;
+
+	/*
+	 * link to format, must be done first for correct
+	 * error handling in pfm_context_free()
+	 */
+	ctx->ctx_smpl_fmt = fmt;
+
+	ret = -ENFILE;
+	fd = pfm_alloc_fd(&filp);
+	if (fd < 0)
+		goto error_file;
+
+	/*
+	 * context is unloaded
+	 */
+	ctx->ctx_state = PFM_CTX_UNLOADED;
+
+	/*
+	 * initialization of context's flags
+	 * must be done before pfm_find_set()
+	 */
+	ctx->ctx_fl_block = (ctx_flags & PFM_FL_NOTIFY_BLOCK) ? 1 : 0;
+	ctx->ctx_fl_system = (ctx_flags & PFM_FL_SYSTEM_WIDE) ? 1: 0;
+	ctx->ctx_fl_no_msg = (ctx_flags & PFM_FL_OVFL_NO_MSG) ? 1: 0;
+	ctx->ctx_fl_mapset = (ctx_flags & PFM_FL_MAP_SETS) ? 1: 0;
+	ctx->ctx_fl_trap_reason = PFM_TRAP_REASON_NONE;
+
+	/*
+	 * initialize arch-specific section
+	 * must be done before fmt_init()
+	 * XXX: fix dependency with fmt_init()
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
+	/*
+	 * does the user want to sample?
+	 */
+	if (fmt) {
+		ret = pfm_setup_smpl_fmt(fmt, fmt_arg, ctx, ctx_flags,
+					 compat_mode, filp);
+		if (ret)
+			goto error_set;
+	}
+
+	req->ctx_smpl_buf_size = ctx->ctx_smpl_size;
+
+	/*
+	 * attach context to file
+	 */
+	filp->private_data = ctx;
+
+	spin_lock_init(&ctx->ctx_lock);
+	init_completion(&ctx->ctx_restart_complete);
+
+	/*
+	 * activation is used in SMP only
+	 */
+	ctx->ctx_last_act = PFM_INVALID_ACTIVATION;
+	pfm_set_last_cpu(ctx, -1);
+
+	/*
+	 * initialize notification message queue
+	 */
+	ctx->ctx_msgq_head = ctx->ctx_msgq_tail = 0;
+	init_waitqueue_head(&ctx->ctx_msgq_wait);
+
+	DPRINT(("ctx=%p flags=0x%x system=%d notify_block=%d no_msg=%d"
+		" use_fmt=%d remap=%d ctx_fd=%d \n",
+		ctx,
+		ctx_flags,
+		ctx->ctx_fl_system,
+		ctx->ctx_fl_block,
+		ctx->ctx_fl_no_msg,
+		fmt != NULL,
+		ctx->ctx_fl_mapset,
+		fd));
+
+	*new_ctx = ctx;
+
+	/*
+	 * we defer the fd_install until we are certain the call succeeded
+	 * to ensure we do not have to undo its effect. Neither put_filp()
+	 * nor put_unused_fd() undoes the effect of fd_install().
+	 */
+	fd_install(fd, filp);
+
+	req->ctx_fd = fd;
+
+	return 0;
+
+error_set:
+	put_filp(filp);
+	put_unused_fd(fd);
+
+error_file:
+	pfm_context_free(ctx);
+	fmt = NULL;
+error:
+	if (fmt)
+		pfm_smpl_fmt_put(fmt);
+	return ret;
+}
+
+/*
+ * function invoked in case, pfm_context_create fails
+ * at the last operation, copy_to_user. It needs to
+ * undo memory allocations and free the file descriptor
+ */
+void pfm_undo_create_context(int fd, struct pfm_context *ctx)
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
diff -urN --exclude-from=/tmp/excl28370 linux-2.6.16-rc1.orig/perfmon/perfmon_ctxsw.c linux-2.6.16-rc1/perfmon/perfmon_ctxsw.c
--- linux-2.6.16-rc1.orig/perfmon/perfmon_ctxsw.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.16-rc1/perfmon/perfmon_ctxsw.c	2006-01-18 08:50:31.000000000 -0800
@@ -0,0 +1,405 @@
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
+
+
+#ifdef CONFIG_SMP
+/*
+ * interrupts are masked, runqueue lock is held, context is locked
+ */
+void pfm_ctxswin_thread(struct task_struct *task, struct pfm_context *ctx,
+			struct pfm_event_set *set, int must_reload)
+{
+	struct thread_struct *t;
+	u64 cur_act;
+	u32 set_flags;
+	int reload_pmcs, reload_pmds;
+
+	BUG_ON(task->pid == 0);
+	BUG_ON(__get_cpu_var(pmu_owner));
+
+	BUG_ON(task->thread.pfm_context != ctx);
+
+	t = &task->thread;
+
+	cur_act = __get_cpu_var(pmu_activation_number);
+
+	set = ctx->ctx_active_set;
+	set_flags = set->set_flags;
+
+	/*
+	 * in case fo zombie, we do not complete ctswin of the
+	 * PMU, and we force a call to pfm_handle_work() to finish
+	 * cleanup, i.e., free context + smpl_buff. The reason for
+	 * deferring to pfm_handle_work() is that it is not possible
+	 * to vfree() with interrupts disabled.
+	 */
+	if (unlikely(ctx->ctx_state == PFM_CTX_ZOMBIE)) {
+		struct thread_info *th_info;
+
+		/*
+		 * ensure everything is properly stopped
+		 */
+		__pfm_stop(ctx);
+
+		ctx->ctx_fl_trap_reason = PFM_TRAP_REASON_ZOMBIE;
+		th_info = task->thread_info;
+		set_bit(TIF_NOTIFY_RESUME, &th_info->flags);
+
+		return;
+	}
+
+	if (set_flags & PFM_SETFL_TIME_SWITCH)
+		__get_cpu_var(pfm_syst_info) = PFM_CPUINFO_TIME_SWITCH;
+
+	/*
+	 * if we were the last user of the PMU on that CPU,
+	 * then nothing to do except restore psr
+	 */
+	if (ctx->ctx_last_cpu == smp_processor_id() && ctx->ctx_last_act == cur_act) {
+		/*
+		 * check for forced reload conditions
+		 */
+		reload_pmcs = set->set_priv_flags & PFM_SETFL_PRIV_MOD_PMCS;
+		reload_pmds = set->set_priv_flags & PFM_SETFL_PRIV_MOD_PMDS;
+	} else {
+		reload_pmcs = 1;
+		reload_pmds = 1;
+	}
+	/* consumed */
+	set->set_priv_flags &= ~PFM_SETFL_PRIV_MOD_BOTH;
+
+	if (reload_pmds)
+		pfm_arch_restore_pmds(ctx, set);
+
+	/*
+	 * need to check if had in-flight interrupt in
+	 * pfm_ctxswout_thread(). If at least one bit set, then we must replay
+	 * the interrupt to avoid losing some important performance data.
+	 */
+	if (set->set_npend_ovfls) {
+		pfm_arch_resend_irq();
+		__get_cpu_var(pfm_stats).pfm_replay_intr_count++;
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
+	u32 set_flags, set_priv_flags;
+
+	set_flags = set->set_flags;
+	set_priv_flags = set->set_priv_flags;
+
+	if (set_flags & PFM_SETFL_TIME_SWITCH) {
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
+	if (set->set_npend_ovfls) {
+		pfm_arch_resend_irq();
+		__get_cpu_var(pfm_stats).pfm_replay_intr_count++;
+	}
+
+	if (set_priv_flags & PFM_SETFL_PRIV_MOD_PMCS)
+		pfm_arch_restore_pmcs(ctx, set);
+
+	set->set_priv_flags &= ~PFM_SETFL_PRIV_MOD_BOTH;
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
+	u32 set_flags;
+
+	info = __get_cpu_var(pfm_syst_info);
+
+	/*
+	 * don't do anything before started
+	 */
+	if (ctx->ctx_fl_started == 0)
+		return;
+
+	set_flags = set->set_flags;
+
+	/*
+	 * pid 0 is guaranteed to be the idle task. There is one such task with pid 0
+	 * on each CPU, so we can rely on the pid to identify the idle task.
+	 */
+	if (task->pid == 0 && (set_flags & PFM_SETFL_EXCL_IDLE) != 0)
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
+	ctx = task->thread.pfm_context;
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
+	if (ctxp && ctxp->ctx_fl_system)
+		ctx = ctxp;
+	else if (ctx) {
+		if (ctxp && ctxp != ctx) {
+			pfm_save_pmds_release(ctxp);
+			must_force_reload = 1;
+		}
+	} else
+		return;
+#endif
+	spin_lock(&ctx->ctx_lock);
+
+	set = ctx->ctx_active_set;
+
+	if (ctx->ctx_fl_system)
+		pfm_ctxswin_sys(task, ctx, set);
+	else
+		pfm_ctxswin_thread(task, ctx, set, must_force_reload);
+
+	/*
+	 * ctx_duration does count even when context in MASKED state
+	 * set_duration does not count when context in MASKED state.
+	 * But the set_duration_start is reset in unmask_monitoring()
+	 */
+
+	now_itc = pfm_arch_get_itc();
+
+	ctx->ctx_duration_start = now_itc;
+	set->set_duration_start = now_itc;
+
+	spin_unlock(&ctx->ctx_lock);
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
+	BUG_ON(task->thread.pfm_context != ctx);
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
+	u32 set_flags;
+
+	/*
+	 * do nothing before started
+	 * XXX: assumes cannot be started from user level
+	 */
+	if (ctx->ctx_fl_started == 0)
+		return;
+
+	set_flags = set->set_flags;
+
+	/*
+	 * restore monitoring if set has EXCL_IDLE and task was idle task
+	 */
+	if (task->pid == 0 && (set_flags & PFM_SETFL_EXCL_IDLE) != 0) {
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
+	spin_lock(&ctx->ctx_lock);
+
+	now_itc = pfm_arch_get_itc();
+	set = ctx->ctx_active_set;
+
+	if (ctx->ctx_fl_system) {
+		pfm_ctxswout_sys(task, ctx, set);
+	} else {
+		/*
+		 * in UP, due to lazy save, we may have a
+		 * context loaded onto the PMU BUT it may not
+		 * be the one from the current task. In that case
+		 * simply skip everything else
+		 */
+		if (task->thread.pfm_context == NULL)
+			goto skip_itc;
+
+		pfm_ctxswout_thread(task, ctx, set);
+	}
+
+	diff = now_itc - ctx->ctx_duration_start;
+	ctx->ctx_duration += diff;
+
+	/*
+	 * accumulate only when set is actively monitoring,
+	 */
+	if (ctx->ctx_state == PFM_CTX_LOADED)
+		set->set_duration += now_itc - set->set_duration_start;
+
+skip_itc:
+	spin_unlock(&ctx->ctx_lock);
+}

