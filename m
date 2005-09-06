Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932399AbVIFFVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbVIFFVE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 01:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbVIFFVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 01:21:04 -0400
Received: from ozlabs.org ([203.10.76.45]:40843 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932399AbVIFFVB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 01:21:01 -0400
Date: Tue, 6 Sep 2005 15:14:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Stephane Eranian <eranian@hpl.hp.com>
Cc: perfctr-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [Perfctr-devel] new perfmon2 kernel patch available
Message-ID: <20050906051432.GC8628@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Stephane Eranian <eranian@hpl.hp.com>,
	perfctr-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	linux-ia64@vger.kernel.org
References: <20050808210230.GA13092@frankl.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050808210230.GA13092@frankl.hpl.hp.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2005 at 02:02:31PM -0700, Stephane Eranian wrote:
> Hello,
> 
> I have released a new version of the perfmon2  kernel patch
> along with a new version of the libpfm user library.
> 
> The kernel patch is relative to 2.6.13-rc4-mm1. You need to
> apply Andrew Morton's -mm1 to rc4.
> 
> This new release includes:
> 	- update to newer kernel
> 	- code  reformatting to fit kernel coding style
> 	- switch from single system call to multi syscalls
> 	- some more cleanups of macros vs. inline
> 
> The patch has been tested on IA-64, Pentium M (with Local APIC)
> and X86-64. I have updated the PPC64 but could not test it.
> 
> The new version of libpfm is required to exploit the new multi
> system call interface. Older versions (incl. 3.2-050701) will
> not work. Note that on IA-64, older applications using the
> single syscall interface are still supported. At this point,
> I have not yet updated the specification document to reflect
> the switch to multiple system calls.
> 
> 
> You can download the two packages from our new SourceForget.net
> project site (still under construction). The new kernel
> patch and libpfm are dated 050805.
> 
> 		http://www.sf.net/projects/perfmon2

Ok, below is a patch which updates the ppc64 stuff.  This fixes a
problem which meant it didn't even build before, but also does a bunch
of stuff: it mangles the ppc64 files to be closer in layout to the
i386 version, it fixes up the syscall entry points, and adds a
callback to pfm_handle_work() (I *think* it's in the right place).  I
think it's still quite a long way from actually working, but it's
closer.

A couple of other questions:
	- do you have an up-to-date version of the little
self_standalone test program you send me a while ago - the one I have
is still expecting perfmonctl() instead of individual syscalls
	- where can I get the current version of the perfmon
specification?  I've poked around on the perfmon site, but can't find
it.

Index: working-2.6/arch/ppc64/perfmon/perfmon.c
===================================================================
--- working-2.6.orig/arch/ppc64/perfmon/perfmon.c	2005-09-06 14:52:16.000000000 +1000
+++ working-2.6/arch/ppc64/perfmon/perfmon.c	2005-09-06 14:52:16.000000000 +1000
@@ -11,6 +11,63 @@
 #include <linux/interrupt.h>
 #include <linux/perfmon.h>
 
+extern void ppc64_enable_pmcs(void);
+
+void pfm_arch_init_percpu(void)
+{
+	ppc64_enable_pmcs();
+}
+
+void pfm_arch_context_initialize(struct pfm_context *ctx, u32 ctx_flags)
+{
+}
+
+/*
+ * function called from pfm_load_context_*(). Task is not guaranteed to be
+ * current task. If not that other task is guaranteed stopped and off any CPU.
+ * context is locked and interrupts are masked.
+ *
+ *
+ * function must ensure that monitoring is stopped, i.e. no counter is active.
+ * On PFM_LOAD_CONTEXT, the interface guarantees monitoring is stopped.
+ *
+ * called for per-thread and system-wide. For system-wide task is NULL
+ */
+void pfm_arch_load_context(struct pfm_context *ctx, struct task_struct *task)
+{
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
+	DPRINT(("pfm_arch_unload_context()\n"));
+}
+
+void pfm_arch_intr_freeze_pmu(struct pfm_context *ctx)
+{
+	mtspr(SPRN_MMCR0, MMCR0_FC);
+}
+
+/*
+ * unfreeze PMU from pfm_do_interrupt_handler()
+ * ctx may be NULL for spurious
+ */
+void pfm_arch_intr_unfreeze_pmu(struct pfm_context *ctx)
+{
+	if (ctx == NULL)
+		return;
+	pfm_arch_restore_pmcs(ctx->ctx_active_set, ctx->ctx_fl_masked);
+}
+
 /*
  * called  from pfm_ctxswout_thread(). Interrupts are masked.
  * the routine needs to stop monitoring and save enough state
@@ -18,16 +75,16 @@
  * task is guaranteed to be the current task.
  */
 void pfm_arch_ctxswout_thread(struct task_struct *task, struct pfm_context *ctx,
-		struct pfm_event_set *set)
+			      struct pfm_event_set *set)
 {
 	/*
-	 * we could avoid clearing if we know monitoring is
-	 * not active (no PFM_START)
+	 * we could avoid clearing if we know monitoring is not active
+	 * (no PFM_START)
 	 */
 	mtspr(SPRN_MMCR0, MMCR0_FC);
 
 	/*
-	 * disable lazy restore.
+	 * disable lazy restore on ctxswin.
 	 */
 	if (set)
 		set->set_priv_flags |= PFM_SETFL_PRIV_MODIFIED_PMCS;
@@ -40,8 +97,8 @@
  * must reactivate monitoring. Note that caller has already restored
  * all PMD and PMC registers.
  */
-void pfm_arch_ctxswin_thread(struct task_struct *task,
-		struct pfm_context *ctx, struct pfm_event_set *set)
+void pfm_arch_ctxswin_thread(struct task_struct *task, struct pfm_context *ctx,
+			     struct pfm_event_set *set)
 {
 	/* nothing to do will be restored correctly */
 }
@@ -55,7 +112,7 @@
  * must disable active monitoring.
  */
 void pfm_arch_stop(struct task_struct *task, struct pfm_context *ctx,
-		struct pfm_event_set *aset)
+		   struct pfm_event_set *aset)
 {
 	struct pfm_event_set *set;
 
@@ -71,25 +128,11 @@
 	if (task != current)
 		return;
 
+	DPRINT(("clearing actual PMC\n"));
 	mtspr(SPRN_MMCR0, MMCR0_FC);
 }
 
 /*
- * function called from pfm_unload_context_*(). Context is locked.
- * interrupts are masked. task is not guaranteed to be current task.
- * Access to PMU is not guaranteed.
- *
- * function must do whatever arch-specific action is required on unload
- * of a context.
- *
- * called for both system-wide and per-thread. task is NULL for ssytem-wide
- */
-void pfm_arch_unload_context(struct pfm_context *ctx, struct task_struct *task)
-{
-	DPRINT(("pfm_arch_unload_context()\n"));
-}
-
-/*
  * called from pfm_start(). Task is not necessarily current.
  * If not current task, then task  is guaranteed stopped and
  * off any cpu. Access to PMU is not guaranteed.
@@ -97,25 +140,28 @@
  *
  * must enable active monitoring.
  */
-void pfm_arch_start(struct task_struct *task, struct pfm_context *ctx,
-		struct pfm_event_set *fset)
+static void __pfm_arch_start(struct task_struct *task, struct pfm_context *ctx,
+			     struct pfm_event_set *fset)
 {
 	struct pfm_event_set *set;
 
-	if (ctx->ctx_state == PFM_CTX_MASKED)
-		return;
-
 	for (set = ctx->ctx_sets; set; set = set->set_next)
 		set->set_pmcs[0] &= ~MMCR0_FC;
 
 	if (task != current)
 		return;
 
+	DPRINT(("actual PMC start\n"));
 	mtspr(SPRN_MMCR0, fset->set_pmcs[0]);
 	mtspr(SPRN_MMCR1, fset->set_pmcs[1]);
 	mtspr(SPRN_MMCRA, fset->set_pmcs[2]);
 }
 
+void pfm_arch_start(struct task_struct *task, struct pfm_context *ctx,
+		    struct pfm_event_set *fset)
+{
+	__pfm_arch_start(task, ctx, fset);
+}
 
 /*
  * function called from pfm_switch_sets(), pfm_context_load_thread(),
@@ -131,9 +177,9 @@
 	unsigned int num_cnt;
 	u64 ovfl_mask, val, *pmds;
 
-	num_cnt   = pfm_pmu_conf->num_pmds;
+	num_cnt = pfm_pmu_conf->num_pmds;
 	ovfl_mask = pfm_pmu_conf->ovfl_mask;
-	pmds      = set->set_view->set_pmds;
+	pmds = set->set_view->set_pmds;
 
 	/* start at 1 to skip TB */
 	for (i = 1; i < num_cnt; i++) {
@@ -144,8 +190,8 @@
 
 /*
  * function called from pfm_switch_sets(), pfm_context_load_thread(),
- * pfm_context_load_sys(), pfm_ctxswin_thread(), pfm_switch_sets()
- * context is locked. Interrupts are masked. set cannot be NULL.
+ * pfm_context_load_sys(), pfm_ctxswin_thread().
+ * Context is locked. Interrupts are masked. set cannot be NULL.
  * Access to the PMU is guaranteed.
  *
  * function must restore all PMC registers from set. Privilege level
@@ -159,16 +205,22 @@
 {
 	unsigned int i, num_cnt;
 
-	num_cnt   = pfm_pmu_conf->num_pmcs;
+	num_cnt = pfm_pmu_conf->num_pmcs;
 
+	/*
+	 * - by default all pmcs are cleared
+	 * - on ctxswout, all used PMCs are cleared
+	 * hence when masked we do not need to restore anything
+	 */
 	if (masked)
 		return;
 
 	/*
 	 * restore all pmcs
 	 */
-	for (i = 0; i < num_cnt; i++)
+	for (i = 0; i < num_cnt; i++) {
 		pfm_arch_write_pmc(i, set->set_pmcs[i]);
+	}
 }
 
 /*
@@ -186,7 +238,7 @@
 
 	ovfl_mask = pfm_pmu_conf->ovfl_mask;
 	used_mask = set->set_used_pmds[0];
-	pmds      = set->set_view->set_pmds;
+	pmds = set->set_view->set_pmds;
 
 	/*
 	 * save all used pmds
@@ -200,33 +252,48 @@
 	}
 }
 
-void pfm_intr_handler(struct pt_regs *regs)
+asmlinkage void pfm_intr_handler(struct pt_regs *regs)
 {
-	pfm_interrupt_handler(PFM_PERFMON_VECTOR, NULL, regs);
+	pfm_interrupt_handler(0, NULL, regs);
 }
-	
+
+static void pfm_stop_one_pmu(void *data)
+{
+	mtspr(SPRN_MMCR0, MMCR0_FC);
+}
+
+/*
+ * called from pfm_register_pmu_config() after the new
+ * config has been validated and installed. The pfm_session_lock
+ * is held. Interrupts are not masked. This function cannot sleep.
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
+
 int pfm_arch_initialize(void)
 {
 	return 0;
 }
 
-void pfm_arch_init_percpu(void)
+void pfm_arch_mask_monitoring(struct pfm_context *ctx)
 {
+	mtspr(SPRN_MMCR0, MMCR0_FC);
 }
 
-/*
- * function called from pfm_load_context_*(). Task is not guaranteed to be
- * current task. If not that other task is guaranteed stopped and off any CPU.
- * context is locked and interrupts are masked.
- *
- *
- * function must ensure that monitoring is stopped, i.e. no counter is active.
- * On PFM_LOAD_CONTEXT, the interface guarantees monitoring is stopped.
- *
- * called for per-thread and system-wide. For system-wide task is NULL
- */
-void pfm_arch_load_context(struct pfm_context *ctx, struct task_struct *task)
+void pfm_arch_unmask_monitoring(struct pfm_context *ctx)
 {
+	/*
+	 * on ppc64 masking/unmasking uses start/stop
+	 * mechanism
+	 */
+	__pfm_arch_start(current, ctx, ctx->ctx_active_set);
 }
 
 /*
@@ -234,76 +301,41 @@
  */
 int pfm_arch_get_ovfl_pmds(struct pfm_context *ctx, struct pfm_event_set *set)
 {
-	unsigned int i, num_cnt;
- 	u64 new_val, bv, *pmds, used_mask;
+	unsigned int i, width;
+	u64 new_val, bv, used_mask, *pmds;
 
-	used_mask = set->set_used_pmds[0];
-	pmds      = set->set_view->set_pmds;
-
-	if (!ctx)
+	if (ctx == NULL)
 		return 0;
 
+	width = pfm_pmu_conf->counter_width;
+	used_mask = set->set_used_pmds[0];
+	pmds = set->set_view->set_pmds;
+
 	BUG_ON(set->set_hw_ovfl_pmds[0]);
 
 	bv = 0;
 
 	for (i = 0; used_mask; i++, used_mask >>=1) {
+
 		if (likely(used_mask & 0x1)) {
 			new_val = pfm_arch_read_pmd(i);
- 			DPRINT(("pmd%u new_val=0x%llx bit=%d\n",
-  				i, new_val, (new_val&(PFM_ONE_64<<width)) ? 1 : 0));
-  			if ((new_val & (PFM_ONE_64 << width)) == 0) {
+			DPRINT(("pmd%u new_val=0x%lx bit31=%d\n",
+				i, new_val, (new_val&(PFM_ONE_64<<width)) ? 1 : 0));
+
+			if ((new_val & (PFM_ONE_64 << width)) == 0) {
 				bv |= PFM_ONE_64 << i;
 			}
 		}
 	}
 	set->set_hw_ovfl_pmds[0] = bv;
-	return bv != 0;
-}
 
-void pfm_arch_intr_freeze_pmu(struct pfm_context *ctx)
-{
-	mtspr(SPRN_MMCR0, MMCR0_FC);
-}
+	DPRINT(("bv=0x%lx\n", bv));
 
-/*
- * unfreeze PMU from pfm_do_interrupt_handler()
- * ctx may be NULL for spurious
- */
-void pfm_arch_intr_unfreeze_pmu(struct pfm_context *ctx)
-{
-	if (! ctx)
-		return;
-	pfm_arch_restore_pmcs(ctx->ctx_active_set, ctx->ctx_fl_masked);
-}
-
-void pfm_arch_mask_monitoring(struct pfm_context *ctx)
-{
-	mtspr(SPRN_MMCR0, MMCR0_FC);
-}
-
-void pfm_arch_unmask_monitoring(struct pfm_context *ctx)
-{
-	pfm_arch_restore_pmds(ctx->ctx_active_set);
-	pfm_arch_restore_pmcs(ctx->ctx_active_set, 0);
+	return bv != 0;
 }
 
-static void pfm_stop_one_pmu(void *data)
+void ppc64_pfm_handle_work(void)
 {
-	mtspr(SPRN_MMCR0, MMCR0_FC);
+	pfm_handle_work();
 }
 
-/*
- * called from pfm_register_pmu_config() after the new
- * config has been validated and installed. The pfm_session_lock
- * is held. Interrupts are not masked. This function cannot sleep.
- *
- * The role of the function is, based on the PMU description, to
- * put the PMU into a quiet state on each CPU. This function is only
- * needed when there is no architected way to do this operation. In
- * that case nothing can be done before a pmu description is registered.
- */
-void pfm_arch_pmu_config_init(struct pfm_pmu_config *cfg)
-{
-	on_each_cpu(pfm_stop_one_pmu, cfg, 1, 1);
-}
Index: working-2.6/include/asm-ppc64/perfmon.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/perfmon.h	2005-09-06 14:52:16.000000000 +1000
+++ working-2.6/include/asm-ppc64/perfmon.h	2005-09-06 14:52:16.000000000 +1000
@@ -15,28 +15,28 @@
 
 #ifdef __KERNEL__
 
-static inline void
-pfm_arch_resend_irq(int vec)
+struct pfm_arch_pmu_info {
+	/* empty */
+};
+
+static inline void pfm_arch_resend_irq(void)
 {
 	/* nothing needed */
 }
 
 #define pfm_arch_serialize()	/* nothing */
 
-static inline void
-pfm_arch_unfreeze_pmu(void)
+static inline void pfm_arch_unfreeze_pmu(void)
 {
 	printk(KERN_ERR "pfm_arch_unfreeze_pmu() called\n");
 }
 
-static inline u64
-pfm_arch_get_itc(void)
+static inline u64 pfm_arch_get_itc(void)
 {
 	return mftb();
 }
 
-static inline void
-pfm_arch_write_pmc(unsigned int cnum, u64 value)
+static inline void pfm_arch_write_pmc(unsigned int cnum, u64 value)
 {
 	switch (cnum) {
 	case 0:
@@ -53,8 +53,7 @@
 	}
 }
 
-static inline void
-pfm_arch_write_pmd(unsigned int cnum, u64 value)
+static inline void pfm_arch_write_pmd(unsigned int cnum, u64 value)
 {
 	switch (cnum) {
 	case 1:
@@ -86,8 +85,7 @@
 	}
 }
 
-static inline u64
-pfm_arch_read_pmd(unsigned int cnum)
+static inline u64 pfm_arch_read_pmd(unsigned int cnum)
 {
 	switch (cnum) {
 	case 0:
@@ -119,11 +117,11 @@
 		break;
 	default:
 		BUG();
+		return 0; /* Suppress gcc4 warning */
 	}
 }
 
-static inline u64
-pfm_arch_read_pmc(unsigned int cnum)
+static inline u64 pfm_arch_read_pmc(unsigned int cnum)
 {
 	switch (cnum) {
 	case 0:
@@ -137,15 +135,10 @@
 		break;
 	default:
 		BUG();
+		return 0; /* Suppress gcc4 warning */
 	}
 }
 
-static inline int
-pfm_arch_is_monitoring_active(struct pfm_context *ctx)
-{
-	return !(mfspr(SPRN_MMCR0) & MMCR0_FC);
-}
-
 //void pfm_arch_ctxswout_sys(struct task_struct *task, struct pfm_context *ctx);
 #define pfm_arch_ctxswout_sys(_t, _c)
 
@@ -153,30 +146,39 @@
 #define pfm_arch_ctxswin_sys(_t, _c)
 
 extern void pfm_arch_init_percpu(void);
-extern int  pfm_arch_is_monitoring_active(struct pfm_context *ctx);
-extern void pfm_arch_ctxswout_thread(struct task_struct *task, struct pfm_context *ctx, struct pfm_event_set *set);
-extern void pfm_arch_ctxswin_thread(struct task_struct *task, struct pfm_context *ctx, struct pfm_event_set *set);
-extern void pfm_arch_stop(struct task_struct *task, struct pfm_context *ctx, struct pfm_event_set *set);
-extern void pfm_arch_start(struct task_struct *task, struct pfm_context *ctx, struct pfm_event_set *set);
+extern void pfm_arch_ctxswout_thread(struct task_struct *task,
+			struct pfm_context *ctx, struct pfm_event_set *set);
+extern void pfm_arch_ctxswin_thread(struct task_struct *task,
+			struct pfm_context *ctx, struct pfm_event_set *set);
+extern void pfm_arch_stop(struct task_struct *task,
+			struct pfm_context *ctx, struct pfm_event_set *set);
+extern void pfm_arch_start(struct task_struct *task,
+			struct pfm_context *ctx, struct pfm_event_set *set);
 extern void pfm_arch_restore_pmds(struct pfm_event_set *set);
 extern void pfm_arch_save_pmds(struct pfm_event_set *set);
-extern void pfm_arch_restore_pmcs(struct pfm_event_set *set, int masked);
-extern int  pfm_arch_get_ovfl_pmds(struct pfm_context *ctx, struct pfm_event_set *set);
+extern void pfm_arch_restore_pmcs(struct pfm_event_set *set, int plm_mask);
 extern void pfm_arch_intr_freeze_pmu(struct pfm_context *ctx);
 extern void pfm_arch_intr_unfreeze_pmu(struct pfm_context *ctx);
+extern void pfm_arch_pmu_config_init(struct pfm_pmu_config *cfg);
 extern int  pfm_arch_initialize(void);
 extern void pfm_arch_mask_monitoring(struct pfm_context *ctx);
 extern void pfm_arch_unmask_monitoring(struct pfm_context *ctx);
-extern void pfm_arch_pmu_config_init(struct pfm_pmu_config *cfg);
+extern int  pfm_arch_get_ovfl_pmds(struct pfm_context *ctx,
+			struct pfm_event_set *set);
+static inline int pfm_arch_is_monitoring_active(struct pfm_context *ctx)
+{
+	return !(mfspr(SPRN_MMCR0) & MMCR0_FC);
+}
 
-//static inline void pfm_arch_context_initialize(struct pfm_context *ctx, u32 ctx_flags);
-#define pfm_arch_context_initialize(ctx, ctx_flags) /* nothing */
 
-extern void pfm_arch_load_context(struct pfm_context *ctx, struct task_struct *task);
-extern void pfm_arch_unload_context(struct pfm_context *ctx, struct task_struct *task);
+extern void pfm_arch_context_initialize(struct pfm_context *ctx, u32 ctx_flags);
+extern void pfm_arch_unload_context(struct pfm_context *ctx,
+		struct task_struct *task);
+extern void pfm_arch_load_context(struct pfm_context *ctx,
+		struct task_struct *task);
 
-static inline int
-pfm_arch_reserve_session(struct pfm_context *ctx, unsigned int cpu)
+static inline int pfm_arch_reserve_session(struct pfm_context *ctx,
+					   unsigned int cpu)
 {
 	return 0;
 }
@@ -184,7 +186,6 @@
 //static inline void pfm_arch_unreserve_session(struct pfm_context *ctx, unsigned int cpu)
 #define pfm_arch_unreserve_session(ctx, cpu) /* nothing */
 
-
 /*
  * function called from pfm_setfl_sane(). Context is locked
  * and interrupts are masked.
@@ -196,38 +197,37 @@
  * 	1 when flags are valid
  *      0 on error
  */
-static inline int
-pfm_arch_setfl_sane(struct pfm_context *ctx, u32 flags)
+static inline int pfm_arch_setfl_sane(struct pfm_context *ctx, u32 flags)
 {
 	return 0;
 }
 
-static inline void
-pfm_arch_stop_thread(struct task_struct *task, struct pfm_context *ctx, struct pfm_event_set *set)
+static inline void pfm_arch_stop_thread(struct task_struct *task,
+			struct pfm_context *ctx, struct pfm_event_set *set)
 {
 	pfm_arch_stop(task, ctx, set);
 }
 
-static inline void
-pfm_arch_start_thread(struct task_struct *task, struct pfm_context *ctx, struct pfm_event_set *set)
+static inline void pfm_arch_start_thread(struct task_struct *task,
+		struct pfm_context *ctx, struct pfm_event_set *set)
 {
 	pfm_arch_start(task, ctx, set);
 }
 
-static inline void
-pfm_arch_stop_sys(struct task_struct *task, struct pfm_context *ctx, struct pfm_event_set *set)
+static inline void pfm_arch_stop_sys(struct task_struct *task,
+		struct pfm_context *ctx, struct pfm_event_set *set)
 {
 	pfm_arch_stop(task, ctx, set);
 }
 
-static inline void
-pfm_arch_start_sys(struct task_struct *task, struct pfm_context *ctx, struct pfm_event_set *set)
+static inline void pfm_arch_start_sys(struct task_struct *task,
+		struct pfm_context *ctx, struct pfm_event_set *set)
 {
 	pfm_arch_start(task, ctx, set);
 }
 
-static inline int
-pfm_arch_load_checks(struct pfm_context *ctx, struct task_struct *task)
+static inline int pfm_arch_load_checks(struct pfm_context *ctx,
+		struct task_struct *task)
 {
 	return 0;
 }
@@ -235,15 +235,11 @@
 //static inline void pfm_arch_show_session(struct seq_file *m);
 #define pfm_arch_show_session(m) /* nothing */
 
-struct pfm_arch_pmu_info {
-	/* empty */
-};
-
 struct pfm_arch_context {
 	/* empty */
 };
 
-#define PFM_ARCH_CTX_SIZE	sizeof(struct pfm_arch_context)
+#define PFM_ARCH_CTX_SIZE	(sizeof(struct pfm_arch_context))
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_PPC64_PERFMON_H_ */
Index: working-2.6/arch/ppc64/kernel/entry.S
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/entry.S	2005-09-06 14:51:26.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/entry.S	2005-09-06 15:05:39.000000000 +1000
@@ -597,6 +597,9 @@
 	b	.ret_from_except_lite
 
 1:	bl	.save_nvgprs
+#ifdef CONFIG_PERFMON
+	bl	.ppc64_pfm_handle_work
+#endif /* CONFIG_PERFMON */
 	li	r3,0
 	addi	r4,r1,STACK_FRAME_OVERHEAD
 	bl	.do_signal
Index: working-2.6/arch/ppc64/kernel/misc.S
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/misc.S	2005-09-06 14:52:16.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/misc.S	2005-09-06 15:04:26.000000000 +1000
@@ -1138,6 +1138,18 @@
 	.llong .sys_vperfctr_control
 	.llong .sys_vperfctr_write
 	.llong .sys_vperfctr_read	/* 280 */
+	.llong .sys_pfm_create_context	/* 281 */
+	.llong .sys_pfm_write_pmcs
+	.llong .sys_pfm_write_pmds
+	.llong .sys_pfm_read_pmds
+	.llong .sys_pfm_load_context	/* 285 *
+	.llong .sys_pfm_start
+	.llong .sys_pfm_stop
+	.llong .sys_pfm_restart
+	.llong .sys_pfm_create_evtsets
+	.llong .sys_pfm_getinfo_evtsets /* 290 */
+	.llong .sys_pfm_delete_evtsets
+	.llong .sys_pfm_unload_context
 
 	.balign 8
 _GLOBAL(sys_call_table)
@@ -1425,16 +1437,16 @@
 	.llong .sys_vperfctr_control
 	.llong .sys_vperfctr_write
 	.llong .sys_vperfctr_read	/* 280 */
-	.llong sys_pfm_create_context	/* 281 */
-	.llong sys_pfm_write_pmcs
-	.llong sys_pfm_write_pmds
-	.llong sys_pfm_read_pmds
-	.llong sys_pfm_load_context	/* 285 *
-	.llong sys_pfm_start
-	.llong sys_pfm_stop
-	.llong sys_pfm_restart
-	.llong sys_pfm_create_evtsets
-	.llong sys_pfm_getinfo_evtsets /* 290 */
-	.llong sys_pfm_delete_evtsets
-	.llong sys_pfm_unload_context
+	.llong .sys_pfm_create_context	/* 281 */
+	.llong .sys_pfm_write_pmcs
+	.llong .sys_pfm_write_pmds
+	.llong .sys_pfm_read_pmds
+	.llong .sys_pfm_load_context	/* 285 *
+	.llong .sys_pfm_start
+	.llong .sys_pfm_stop
+	.llong .sys_pfm_restart
+	.llong .sys_pfm_create_evtsets
+	.llong .sys_pfm_getinfo_evtsets /* 290 */
+	.llong .sys_pfm_delete_evtsets
+	.llong .sys_pfm_unload_context
 


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/people/dgibson
