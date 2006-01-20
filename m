Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbWATPXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWATPXA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 10:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWATPW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 10:22:59 -0500
Received: from palrel11.hp.com ([156.153.255.246]:32459 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S1750753AbWATPWn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 10:22:43 -0500
Date: Fri, 20 Jan 2006 07:20:16 -0800
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200601201520.k0KFKGwB023144@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] 2.6.16-rc1 perfmon2 patch for review
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
diff -urN linux-2.6.16-rc1.orig/arch/x86_64/Kconfig linux-2.6.16-rc1/arch/x86_64/Kconfig
--- linux-2.6.16-rc1.orig/arch/x86_64/Kconfig	2006-01-18 08:48:15.000000000 -0800
+++ linux-2.6.16-rc1/arch/x86_64/Kconfig	2006-01-18 08:50:44.000000000 -0800
@@ -479,6 +479,21 @@
 
 source kernel/Kconfig.hz
 
+menu "Hardware Performance Monitoring support"
+
+config PERFMON
+ 	bool "Perfmon2 performance monitoring interface"
+	select X86_LOCAL_APIC
+	default y
+ 	help
+ 	  include the perfmon2 performance monitoring interface
+	  in the kernel.  See <http://www.hpl.hp.com/research/linux/perfmon> for
+	  more details.  If you're unsure, say Y.
+
+source "arch/x86_64/perfmon/Kconfig"
+
+endmenu
+
 endmenu
 
 #
diff -urN linux-2.6.16-rc1.orig/arch/x86_64/Makefile linux-2.6.16-rc1/arch/x86_64/Makefile
--- linux-2.6.16-rc1.orig/arch/x86_64/Makefile	2006-01-18 08:48:15.000000000 -0800
+++ linux-2.6.16-rc1/arch/x86_64/Makefile	2006-01-18 08:50:44.000000000 -0800
@@ -63,6 +63,7 @@
 					   arch/x86_64/crypto/
 core-$(CONFIG_IA32_EMULATION)		+= arch/x86_64/ia32/
 drivers-$(CONFIG_PCI)			+= arch/x86_64/pci/
+drivers-$(CONFIG_PERFMON)		+= arch/x86_64/perfmon/
 drivers-$(CONFIG_OPROFILE)		+= arch/x86_64/oprofile/
 
 boot := arch/x86_64/boot
diff -urN linux-2.6.16-rc1.orig/arch/x86_64/kernel/apic.c linux-2.6.16-rc1/arch/x86_64/kernel/apic.c
--- linux-2.6.16-rc1.orig/arch/x86_64/kernel/apic.c	2006-01-18 08:48:15.000000000 -0800
+++ linux-2.6.16-rc1/arch/x86_64/kernel/apic.c	2006-01-18 08:50:44.000000000 -0800
@@ -26,6 +26,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/sysdev.h>
 #include <linux/module.h>
+#include <linux/perfmon.h>
 
 #include <asm/atomic.h>
 #include <asm/smp.h>
@@ -869,6 +870,7 @@
 void smp_local_timer_interrupt(struct pt_regs *regs)
 {
 	profile_tick(CPU_PROFILING, regs);
+ 	pfm_handle_switch_timeout();
 #ifdef CONFIG_SMP
 	update_process_times(user_mode(regs));
 #endif
diff -urN linux-2.6.16-rc1.orig/arch/x86_64/kernel/entry.S linux-2.6.16-rc1/arch/x86_64/kernel/entry.S
--- linux-2.6.16-rc1.orig/arch/x86_64/kernel/entry.S	2006-01-18 08:48:15.000000000 -0800
+++ linux-2.6.16-rc1/arch/x86_64/kernel/entry.S	2006-01-18 08:50:44.000000000 -0800
@@ -648,6 +648,11 @@
 
 ENTRY(spurious_interrupt)
 	apicinterrupt SPURIOUS_APIC_VECTOR,smp_spurious_interrupt
+
+#ifdef CONFIG_PERFMON
+ENTRY(pmu_interrupt)
+	apicinterrupt LOCAL_PERFMON_VECTOR, pfm_intr_handler
+#endif
 #endif
 				
 /*
diff -urN linux-2.6.16-rc1.orig/arch/x86_64/kernel/i8259.c linux-2.6.16-rc1/arch/x86_64/kernel/i8259.c
--- linux-2.6.16-rc1.orig/arch/x86_64/kernel/i8259.c	2006-01-18 08:48:15.000000000 -0800
+++ linux-2.6.16-rc1/arch/x86_64/kernel/i8259.c	2006-01-18 08:50:44.000000000 -0800
@@ -13,6 +13,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/sysdev.h>
 #include <linux/bitops.h>
+#include <linux/perfmon.h>
 
 #include <asm/acpi.h>
 #include <asm/atomic.h>
@@ -589,6 +590,8 @@
 	/* IPI vectors for APIC spurious and error interrupts */
 	set_intr_gate(SPURIOUS_APIC_VECTOR, spurious_interrupt);
 	set_intr_gate(ERROR_APIC_VECTOR, error_interrupt);
+
+ 	pfm_vector_init();
 #endif
 
 	/*
diff -urN linux-2.6.16-rc1.orig/arch/x86_64/kernel/nmi.c linux-2.6.16-rc1/arch/x86_64/kernel/nmi.c
--- linux-2.6.16-rc1.orig/arch/x86_64/kernel/nmi.c	2006-01-18 08:48:15.000000000 -0800
+++ linux-2.6.16-rc1/arch/x86_64/kernel/nmi.c	2006-01-18 08:50:44.000000000 -0800
@@ -247,6 +247,7 @@
 	old_owner = lapic_nmi_owner;
 	lapic_nmi_owner |= LAPIC_NMI_RESERVED;
 	spin_unlock(&lapic_nmi_owner_lock);
+printk("CPU%d old_owner=0x%x lapic_nmi_owner=0x%x\n", smp_processor_id(), old_owner, lapic_nmi_owner);
 	if (old_owner & LAPIC_NMI_RESERVED)
 		return -EBUSY;
 	if (old_owner & LAPIC_NMI_WATCHDOG)
diff -urN linux-2.6.16-rc1.orig/arch/x86_64/kernel/process.c linux-2.6.16-rc1/arch/x86_64/kernel/process.c
--- linux-2.6.16-rc1.orig/arch/x86_64/kernel/process.c	2006-01-18 08:48:15.000000000 -0800
+++ linux-2.6.16-rc1/arch/x86_64/kernel/process.c	2006-01-18 08:50:44.000000000 -0800
@@ -37,6 +37,7 @@
 #include <linux/random.h>
 #include <linux/kprobes.h>
 #include <linux/notifier.h>
+#include <linux/perfmon.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -372,6 +373,7 @@
 		t->io_bitmap_max = 0;
 		put_cpu();
 	}
+	pfm_exit_thread(me);
 }
 
 void flush_thread(void)
@@ -473,6 +475,8 @@
 	asm("mov %%es,%0" : "=m" (p->thread.es));
 	asm("mov %%ds,%0" : "=m" (p->thread.ds));
 
+	pfm_copy_thread(p, childregs);
+
 	if (unlikely(me->thread.io_bitmap_ptr != NULL)) { 
 		p->thread.io_bitmap_ptr = kmalloc(IO_BITMAP_BYTES, GFP_KERNEL);
 		if (!p->thread.io_bitmap_ptr) {
@@ -496,6 +500,8 @@
 		if (err) 
 			goto out;
 	}
+
+
 	err = 0;
 out:
 	if (err && p->thread.io_bitmap_ptr) {
@@ -624,6 +630,7 @@
 			memset(tss->io_bitmap, 0xff, prev->io_bitmap_max);
 		}
 	}
+	pfm_ctxswin(next_p);
 
 	return prev_p;
 }
diff -urN linux-2.6.16-rc1.orig/arch/x86_64/kernel/signal.c linux-2.6.16-rc1/arch/x86_64/kernel/signal.c
--- linux-2.6.16-rc1.orig/arch/x86_64/kernel/signal.c	2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.16-rc1/arch/x86_64/kernel/signal.c	2006-01-18 08:50:44.000000000 -0800
@@ -24,6 +24,7 @@
 #include <linux/stddef.h>
 #include <linux/personality.h>
 #include <linux/compiler.h>
+#include <linux/perfmon.h>
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
 #include <asm/i387.h>
@@ -496,6 +497,10 @@
 		regs->eflags |= TF_MASK;
 		clear_thread_flag(TIF_SINGLESTEP);
 	}
+	/*
+	 * must be done before signals
+	 */
+	pfm_handle_work();
 
 	/* deal with pending signal delivery */
 	if (thread_info_flags & _TIF_SIGPENDING)
diff -urN linux-2.6.16-rc1.orig/arch/x86_64/perfmon/Kconfig linux-2.6.16-rc1/arch/x86_64/perfmon/Kconfig
--- linux-2.6.16-rc1.orig/arch/x86_64/perfmon/Kconfig	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.16-rc1/arch/x86_64/perfmon/Kconfig	2006-01-18 08:50:44.000000000 -0800
@@ -0,0 +1,27 @@
+
+config X86_64_PERFMON_AMD
+         tristate "Support AMD X86-64 generic hardware performance counters"
+	 depends on PERFMON
+         default m
+         help
+         Enables support for the generic AMD X86-64 hardware performance
+	 counters. Does not work with Intel EM64T processors.
+         If unsure, say m.
+
+config X86_64_PERFMON_EM64T
+         tristate "Support Intel EM64T hardware performance counters"
+	 depends on PERFMON
+         default m
+         help
+         Enables support for the Intel EM64T hardware performance
+	 counters. Does not work with AMD X86-64 processors.
+         If unsure, say m.
+	 
+config X86_64_PERFMON_EM64T_PEBS
+         tristate "Support for Intel EM64T PEBS sampling format"
+	 depends on X86_64_PERFMON_EM64T
+         default m
+         help
+         Enables support for Precise Event-Based Sampling (PEBS) on the Intel EM64T
+	 processors which support it.  Does not work with AMD X86-64 processors.
+         If unsure, say m.
diff -urN linux-2.6.16-rc1.orig/arch/x86_64/perfmon/Makefile linux-2.6.16-rc1/arch/x86_64/perfmon/Makefile
--- linux-2.6.16-rc1.orig/arch/x86_64/perfmon/Makefile	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.16-rc1/arch/x86_64/perfmon/Makefile	2006-01-18 08:50:44.000000000 -0800
@@ -0,0 +1,8 @@
+#
+# Copyright (c) 2005-2006 Hewlett-Packard Development Company, L.P.
+# Contributed by Stephane Eranian <eranian@hpl.hp.com>
+#
+obj-$(CONFIG_PERFMON)			+= perfmon.o
+obj-$(CONFIG_X86_64_PERFMON_AMD)	+= perfmon_amd.o
+obj-$(CONFIG_X86_64_PERFMON_EM64T)	+= perfmon_em64t.o
+obj-$(CONFIG_X86_64_PERFMON_EM64T_PEBS)	+= perfmon_em64t_pebs_smpl.o
diff -urN linux-2.6.16-rc1.orig/arch/x86_64/perfmon/perfmon.c linux-2.6.16-rc1/arch/x86_64/perfmon/perfmon.c
--- linux-2.6.16-rc1.orig/arch/x86_64/perfmon/perfmon.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.16-rc1/arch/x86_64/perfmon/perfmon.c	2006-01-18 08:50:44.000000000 -0800
@@ -0,0 +1,1072 @@
+/*
+ * This file implements the AMD X86-64/Intel EM64T specific
+ * support for the perfmon2 interface
+ *
+ * Copyright (c) 2005-2006 Hewlett-Packard Development Company, L.P.
+ * Contributed by Stephane Eranian <eranian@hpl.hp.com>
+ */
+#include <linux/interrupt.h>
+#include <linux/perfmon.h>
+
+#define MSR_IA32_PEBS_ENABLE	0x3f1 /* unique per-thread */
+#define MSR_IA32_DS_AREA	0x600 /* unique per-thread */
+
+
+DEFINE_PER_CPU(int, apic_state);
+DEFINE_PER_CPU(u64 *, nmi_pmds);
+DEFINE_PER_CPU(u64 *, nmi_pmcs);
+
+/*
+ * Debug Store (DS) management area (for Intel EM64T PEBS)
+ */
+struct pfm_ds_area {
+	unsigned long	bts_buf_base;
+	unsigned long	bts_index;
+	unsigned long	bts_abs_max;
+	unsigned long	bts_intr_thres;
+	unsigned long	pebs_buf_base;
+	unsigned long	pebs_index;
+	unsigned long	pebs_abs_max;
+	unsigned long	pebs_intr_thres;
+	u64		pebs_cnt_reset;
+};
+
+static void (*pfm_stop_active)(struct task_struct *task, struct pfm_context *ctx,
+				   struct pfm_event_set *set);
+
+static inline void pfm_set_pce(void)
+{
+	write_cr4(read_cr4() | X86_CR4_PCE);
+}
+
+static inline void pfm_clear_pce(void)
+{
+	write_cr4(read_cr4() & ~X86_CR4_PCE);
+}
+
+static u8 get_smt_id_mask(void)
+{
+	struct pfm_arch_pmu_info *arch_info = pfm_pmu_conf->arch_info;
+	u8 mask = 0;
+	u8 cnt;
+	
+	cnt = arch_info->lps_per_core;
+	
+	/* TODO : replace this with the algorithm from 7.10.3 as
+	 *        soon as I figure out this bizarre GCC/AT&T
+	 *       inline assembler
+	 */
+	if (likely(cnt <= 2))
+		mask = 0x01;
+	else if (unlikely(cnt<=4))
+		mask = 0x03;
+	else if (unlikely(cnt<=8))
+		mask = 0x07;
+	else if (unlikely(cnt<=16))
+		mask = 0x0F;
+	
+	return mask;
+}
+
+/*
+ * returns the logical processor id (0 or 1) if running on an HT system
+ */
+static u8 get_smt_id(void)
+{
+	struct pfm_arch_pmu_info *arch_info = pfm_pmu_conf->arch_info;
+	u8 apic_id,val8 ;
+	/*
+	 * not HT enabled
+	 */
+	if (arch_info->lps_per_core <= 1)
+		return 0;
+	
+	/*
+	 * TODO : add per_cpu caching here to avoid calling cpuid repeatedly
+	 */
+	apic_id = (cpuid_ebx(1)&0xff000000) >> 24;
+	val8 = apic_id & get_smt_id_mask();
+	return val8;
+}
+
+void __pfm_write_reg(const struct pfm_arch_ext_reg *xreg, u64 val)
+{
+	unsigned long pmi;
+	int smt_id = get_smt_id();
+
+	if (unlikely(smt_id > MAX_SMT_ID)) {
+		printk(KERN_ERR "%s: smt_id (%d) exceeds maximun number of SMTs"
+		       " (%d) supported by perfmon",
+		       __FUNCTION__, smt_id, MAX_SMT_ID);
+		return;
+	}
+
+	/*
+	 * LBR TOS is read only
+	 * TODO : need to save the TOS value somewhere and move the LBRs according
+	 * to where ever it is currently pointing
+	 */
+	if (xreg->reg_type & PFM_REGT_LBRTOS)
+		return;
+
+	/*
+	 * Adjust for T1 if necessary:
+	 *
+	 * - move the T0_OS/T0_USR bits into T1 slots
+	 * - move the OVF_PMI_T0 bits into T1 slot
+	 *
+	 * The EM64T write checker systematically clears T1
+	 * fields, i.e., user  only works with T0.
+	 */
+	if (smt_id > 0) {
+		if (xreg->reg_type & PFM_REGT_ESCR) {
+			val |= (val >> 2) & 0x3;
+			val &= ~(1ULL << 2);
+		} else if (xreg->reg_type & PFM_REGT_CCCR) {
+			pmi = (val >> 26) & 0x1;
+			if (pmi) {
+				val &=~(1ULL<<26);
+				val |= 1ULL<<27;
+			}
+		}
+	}
+	
+	if (xreg->addrs[smt_id]) {
+		wrmsrl(xreg->addrs[smt_id], val);
+	}
+}
+
+void __pfm_read_reg(const struct pfm_arch_ext_reg *xreg, u64 *val)
+{
+	int smt_id = get_smt_id();
+
+	*val = 0;
+
+	if (unlikely(smt_id > MAX_SMT_ID)) {
+		printk(KERN_ERR "%s: smt_id (%d) exceeds maximun number of SMTs"
+		       " (%d) supported by perfmon",
+		       __FUNCTION__, smt_id, MAX_SMT_ID);
+		return;
+	}
+
+	if (xreg->addrs[smt_id] != 0) {
+		rdmsrl(xreg->addrs[smt_id], *val);
+
+		/*
+		 * move the Tx_OS and Tx_USR bits into
+		 * T0 slots setting the T1 slots to zero
+		 */
+		if (xreg->reg_type & PFM_REGT_ESCR) {
+
+			if (smt_id > 0)
+				*val |= (((*val) & 0x3) << 2);
+
+			/*
+			 * zero out bits that are reserved
+			 * (including T1_OS and T1_USR)
+			 */
+			*val &= PFM_ESCR_RSVD;
+		}
+	}
+}
+
+void pfm_arch_init_percpu(void)
+{
+	/*
+	 * We initialize APIC with LVTPC vector masked.
+	 *
+	 * this is motivated by the fact that the PMU may be
+	 * in a condition where is has already an interrupt pending
+	 * as with boot. Given that we cannot touch the PMU registers
+	 * at this point, we may not have a way to remove the condition.
+	 * As such, we need to keep the interrupt masked until a PMU
+	 * description is loaded. At that point, we can enable intr.
+	 *
+	 * We have seen problems on EM64T machines on boot with spurious
+	 * PMU interrupts.
+	 */
+	if (nmi_watchdog != NMI_LOCAL_APIC) {
+		apic_write(APIC_LVTPC, APIC_LVT_MASKED|LOCAL_PERFMON_VECTOR);
+		printk(KERN_INFO"perfmon: CPU%d APIC LVTPC vector masked\n", smp_processor_id());
+	} else {
+		__get_cpu_var(apic_state) = 0;
+		__get_cpu_var(nmi_pmds) = kmalloc(sizeof(u64)*PFM_MAX_PMDS, GFP_KERNEL);
+		__get_cpu_var(nmi_pmcs) = kmalloc(sizeof(u64)*PFM_MAX_PMCS, GFP_KERNEL);
+		if (__get_cpu_var(nmi_pmds) == NULL || __get_cpu_var(nmi_pmcs) == NULL)
+			printk(KERN_ERR"perfmon: CPU%d cannot allocate NMI save area\n", smp_processor_id());
+	}
+}
+
+void pfm_arch_context_initialize(struct pfm_context *ctx, u32 ctx_flags)
+{
+	struct pfm_arch_context *ctx_arch;
+	
+	ctx_arch = pfm_ctx_arch(ctx);
+
+	ctx_arch->flags = ctx_flags & PFM_X86_64_FL_INSECURE;
+}
+
+/*
+ * function called from pfm_load_context_*(). Task is not guaranteed to be
+ * current task. If not then other task is guaranteed stopped and off any CPU.
+ * context is locked and interrupts are masked.
+ *
+ * On PFM_LOAD_CONTEXT, the interface guarantees monitoring is stopped.
+ *
+ * For system-wide task is NULL
+ */
+int pfm_arch_load_context(struct pfm_context *ctx, struct task_struct *task)
+{
+	struct pfm_arch_context *ctx_arch;
+
+	ctx_arch = pfm_ctx_arch(ctx);
+
+	/*
+	 * always authorize user level rdpmc for self-monitoring
+	 */
+	if (task == current || ctx->ctx_fl_system) {
+		/*
+		 * for system-wide or self-monitoring, we always enable
+		 * rdpmc at user level
+		 */
+		ctx_arch->flags |= PFM_X86_64_FL_INSECURE;
+
+		pfm_set_pce();
+		DPRINT(("setting cr4.pce (rdpmc authorized at user level)\n"));
+	}
+	return 0;
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
+	struct pfm_arch_context *ctx_arch;
+
+	ctx_arch = pfm_ctx_arch(ctx);
+
+	if (ctx_arch->flags & PFM_X86_64_FL_INSECURE) {
+		pfm_clear_pce();
+		DPRINT(("clearing cr4.pce\n"));
+	}
+}
+
+/*
+ * called from __pfm_interrupt_handler(). ctx is not NULL.
+ * ctx is locked. PMU interrupt is masked.
+ *
+ * must stop all monitoring to ensure handler has consistent view.
+ * must collect overflowed PMDs bitmask  into set_povfls_pmds and
+ * set_npend_ovfls. If no interrupt detected then set_npend_ovfls
+ * must be set to zero.
+ */
+void pfm_arch_intr_freeze_pmu(struct pfm_context *ctx)
+{
+	struct pfm_arch_pmu_info *arch_info;
+	struct pfm_arch_context *ctx_arch;
+	struct pfm_event_set *set;
+	struct pfm_ds_area *ds;
+
+	arch_info = pfm_pmu_conf->arch_info;
+	ctx_arch = pfm_ctx_arch(ctx);
+
+	set = ctx->ctx_active_set;
+
+	pfm_stop_active(current, ctx, ctx->ctx_active_set);
+
+	/*
+	 * PMU is stopped, thus PEBS is stopped already
+	 * on PEBS full interrupt, the IQ_CCCR4 counter does
+	 * not have the OVF bit set. Thus we use the pebs index
+	 * to detect overflow. This is required because we may
+	 * have more than one reason for overflow due to 64-bit
+	 * counter virtualization.
+	 *
+	 * We don't actually keep track of the overflow unless
+	 * IQ_CTR4 is actually used.
+	 *
+	 * With HT enabled, the mappings are such that IQ_CTR4 and IQ_CTR5
+	 * are mapped onto the same PMD registers.
+	 *
+	 * XXX: remove assumption on IQ_CTR4 and IQ_CTR5 being mapped onto
+	 *      the same PMD.
+	 */
+	if (ctx_arch->flags & PFM_X86_64_FL_USE_PEBS) {
+		ds = ctx_arch->ds_area;
+		if (ds->pebs_index >= ds->pebs_intr_thres
+		    && pfm_bv_isset(set->set_used_pmds, arch_info->pebs_ctr_idx)) {
+			pfm_bv_set(set->set_povfl_pmds, arch_info->pebs_ctr_idx);
+			set->set_npend_ovfls++;
+		}
+	}
+}
+
+/*
+ * unfreeze PMU from pfm_do_interrupt_handler()
+ * ctx may be NULL for spurious
+ */
+void pfm_arch_intr_unfreeze_pmu(struct pfm_context *ctx)
+{
+	struct pfm_arch_context *ctx_arch;
+
+	if (ctx == NULL)
+		return;
+
+	ctx_arch = pfm_ctx_arch(ctx);
+
+	pfm_arch_restore_pmcs(ctx, ctx->ctx_active_set);
+
+	/*
+	 * reload DS area pointer because it is cleared by
+	 * pfm_stop_active()
+	 */
+	if (ctx_arch->flags & PFM_X86_64_FL_USE_PEBS)
+		wrmsrl(MSR_IA32_DS_AREA, ctx_arch->ds_area);
+}
+
+/*
+ * Called from pfm_ctxswin_*(). Task is guaranteed to be current.
+ * set cannot be NULL. Context is locked. Interrupts are masked.
+ * Caller has already restored all PMD and PMC registers.
+ *
+ * must reactivate monitoring
+ */
+void pfm_arch_ctxswin(struct task_struct *task, struct pfm_context *ctx,
+		      struct pfm_event_set *set)
+{
+	struct pfm_arch_context *ctx_arch;
+
+	ctx_arch = pfm_ctx_arch(ctx);
+
+	/*
+	 * nothing to do for system-wide
+	 */
+	if (ctx->ctx_fl_system)
+		return;
+
+	if (ctx_arch->flags & PFM_X86_64_FL_INSECURE)
+		pfm_set_pce();
+	/*
+	 * reload DS management area pointer. Pointer
+	 * not managed as a PMC hus it is not restored
+	 * with the rest of the registers.
+	 */
+	if (ctx_arch->flags & PFM_X86_64_FL_USE_PEBS)
+		wrmsrl(MSR_IA32_DS_AREA, ctx_arch->ds_area);
+}
+
+static void __pfm_stop_active_amd(struct task_struct *task, struct pfm_context *ctx,
+				   struct pfm_event_set *set)
+{
+	struct pfm_arch_pmu_info *arch_info = pfm_pmu_conf->arch_info;
+	struct pfm_arch_ext_reg *xrc, *xrd;
+	unsigned int i, max;
+	u64 val, wmask;
+
+	max = pfm_pmu_conf->max_pmc;
+	xrc = arch_info->pmc_addrs;
+	xrd = arch_info->pmd_addrs;
+	wmask = PFM_ONE_64 << pfm_pmu_conf->counter_width;
+
+	/*
+	 * clear enable bits
+	 */
+	for (i = 0; i < max; i++) {
+		if (pfm_bv_isset(set->set_used_pmcs, i))
+			wrmsr(xrc[i].addrs[0], 0, 0);
+	}
+
+	if (set->set_npend_ovfls)
+		return;
+
+	/*
+	 * check for pending overflows
+	 */
+	max = pfm_pmu_conf->max_cnt_pmd;
+	for (i = 0; i < max; i++) {
+		if (pfm_bv_isset(set->set_used_pmds, i)) {
+			rdmsrl(xrd[i].addrs[0], val);
+			//DPRINT_ovfl(("pmd%d[0x%lx]=0x%llx sw_pmd=0x%llx\n", i, xrd[i].addrs[0], val, set->set_view->set_pmds[i]));
+			if ((val & wmask) == 0) {
+                                //DPRINT_ovfl(("pmd%d overflow\n", i));
+				pfm_bv_set(set->set_povfl_pmds, i);
+				set->set_npend_ovfls++;
+			}
+		}
+	}
+}
+
+/*
+ * stop active set only
+ */
+static void __pfm_stop_active_p4(struct task_struct *task, struct pfm_context *ctx,
+				  struct pfm_event_set *set)
+{
+	struct pfm_arch_pmu_info *arch_info = pfm_pmu_conf->arch_info;
+	struct pfm_arch_context *ctx_arch;
+	struct pfm_arch_ext_reg *xrc, *xrd;
+	unsigned long enable_mask[PFM_PMC_BV];
+	unsigned int i, max_pmc;
+	u64 cccr, ctr1, ctr2;
+
+	ctx_arch = pfm_ctx_arch(ctx);
+	max_pmc = pfm_pmu_conf->max_pmc;
+	xrc = arch_info->pmc_addrs;
+	xrd = arch_info->pmd_addrs;
+
+	bitmap_and(enable_mask, set->set_used_pmcs, arch_info->enable_mask, max_pmc);
+
+	/*
+	 * stop PEBS and clear DS area pointer
+	 */
+	if (ctx_arch->flags & PFM_X86_64_FL_USE_PEBS) {
+		wrmsr(MSR_IA32_PEBS_ENABLE, 0, 0);
+		wrmsr(MSR_IA32_DS_AREA, 0, 0);
+	}
+
+	/*
+	 * ensures we do not destroy information collected
+	 * at ctxswout. This function is called from
+	 * pfm_arch_intr_freeze_pmu() as well.
+	 */
+	if (set->set_npend_ovfls) {
+		for (i = 0; i < max_pmc; i++) {
+			if (pfm_bv_isset(enable_mask, i)) {
+				__pfm_write_reg(xrc+i, 0);
+			}
+		}
+		return;
+	}
+
+	for (i = 0; i < max_pmc; i++) {
+
+		if (pfm_bv_isset(enable_mask, i)) {
+
+			/* read counter controlled by PMC */
+			__pfm_read_reg(xrd+(xrc[i].ctr), &ctr1);
+
+			/* read PMC value */
+			__pfm_read_reg(xrc+i, &cccr);
+
+			/* clear CCCR value (destroy OVF) */
+			__pfm_write_reg(xrc+i, 0);
+
+			/* read counter controlled by CCCR again */
+			__pfm_read_reg(xrd+(xrc[i].ctr), &ctr2);
+
+			/*
+			 * there is an overflow if either:
+			 * 	- CCCR.ovf is set (and we just cleared it)
+			 * 	- ctr2 < ctr1
+			 * in that case we set the bit corresponding to the
+			 * overflowed PMD  in povfl_pmds.
+			 */
+			if ((cccr & (PFM_ONE_64<<31)) || (ctr2 < ctr1)) {
+				pfm_bv_set(set->set_povfl_pmds, xrc[i].ctr);
+				set->set_npend_ovfls++;
+			}
+
+		}
+	}
+}
+
+/*
+ * Called from pfm_stop() and pfm_ctxswin_*() when idle
+ * task and EXCL_IDLE is on.
+ *
+ * Interrupts are masked. Context is locked. Set is the active set.
+ *
+ * For per-thread:
+ *   task is not necessarily current. If not current task, then
+ *   task is guaranteed stopped and off any cpu. Access to PMU
+ *   is not guaranteed. Interrupts are masked. Context is locked.
+ *   Set is the active set.
+ *
+ * For system-wide:
+ * 	task is current
+ *
+ * must disable active monitoring.
+ */
+void pfm_arch_stop(struct task_struct *task, struct pfm_context *ctx,
+		   struct pfm_event_set *set)
+{
+	if (task != current)
+		return;
+
+	pfm_stop_active(task, ctx, set);
+}
+
+/*
+ * Called from pfm_ctxswout_*(). Task is guaranteed to be current.
+ * Context is locked. Interrupts are masked. Monitoring is active.
+ * PMU access is guaranteed. PMC and PMD registers are live in PMU.
+ *
+ * for per-thread:
+ * 	must stop monitoring for the task
+ * for system-wide:
+ * 	must ensure task has monitoring stopped. But monitoring may continue
+ * 	on the current processor
+ */
+void pfm_arch_ctxswout(struct task_struct *task, struct pfm_context *ctx,
+		       struct pfm_event_set *set)
+{
+	struct pfm_arch_context *ctx_arch;
+
+	ctx_arch = pfm_ctx_arch(ctx);
+
+	/*
+	 * nothing to do in system-wide
+	 */
+	if (ctx->ctx_fl_system)
+		return;
+
+	if (ctx_arch->flags & PFM_X86_64_FL_INSECURE)
+		pfm_clear_pce();
+
+	/*
+	 * disable lazy restore of PMCS on ctxswin because
+	 * we modify some of them.
+	 */
+	set->set_priv_flags |= PFM_SETFL_PRIV_MOD_PMCS;
+
+	pfm_stop_active(task, ctx, set);
+}
+
+/*
+ * called from pfm_start() or pfm_ctxswout_sys() when idle task and
+ * EXCL_IDLE is on.
+ *
+ * Interrupts are masked. Context is locked. Set is the active set.
+ *
+ * For per-trhead:
+ * 	Task is not necessarily current. If not current task, then task
+ * 	is guaranteed stopped and off any cpu. Access to PMU is not guaranteed.
+ *
+ * For system-wide:
+ * 	task is always current
+ *
+ * must enable active monitoring.
+ */
+static void __pfm_arch_start(struct task_struct *task, struct pfm_context *ctx,
+			     struct pfm_event_set *set)
+{
+	struct pfm_arch_pmu_info *arch_info = pfm_pmu_conf->arch_info;
+	struct pfm_arch_context *ctx_arch;
+	struct pfm_arch_ext_reg *xregs;
+	unsigned long *impl_mask;
+	u16 i, max_pmc;
+
+	if (task != current)
+		return;
+
+	ctx_arch = pfm_ctx_arch(ctx);
+	max_pmc = pfm_pmu_conf->max_pmc;
+	impl_mask = pfm_pmu_conf->impl_pmcs;
+
+	xregs = arch_info->pmc_addrs;
+
+	/*
+	 * we must actually install all implemented pmcs registers because
+	 * until started, we do not touch any PMC registers. On P4, touching
+	 * only the CCCR (which have the enable field) is not enough. On AMD
+	 * all PMC have an enable bit, so this is not worse.
+	 */
+	for (i = 0; i < max_pmc; i++) {
+		if (pfm_bv_isset(impl_mask, i)) {
+			__pfm_write_reg(xregs+i, set->set_pmcs[i]);
+		}
+	}
+
+	/*
+	 * reload DS area pointer. PEBS_ENABLE is restored with the PMCs
+	 * in pfm_restore_pmcs(). PEBS_ENABLE is not considered part of
+	 * the set of PMCs with an enable bit. This is reserved for counter
+	 * PMC, i.e., CCCR.
+	 */
+	if (task == current && (ctx_arch->flags & PFM_X86_64_FL_USE_PEBS))
+		wrmsrl(MSR_IA32_DS_AREA, ctx_arch->ds_area);
+}
+
+void pfm_arch_start(struct task_struct *task, struct pfm_context *ctx,
+		    struct pfm_event_set *set)
+{
+	/*
+	 * mask/unmask uses start/stop mechanism, so we cannot allow
+	 * while masked.
+	 */
+	if (ctx->ctx_state == PFM_CTX_MASKED)
+		return;
+
+	__pfm_arch_start(task, ctx, set);
+}
+
+
+/*
+ * function called from pfm_switch_sets(), pfm_context_load_thread(),
+ * pfm_context_load_sys(), pfm_ctxswin_*(), pfm_switch_sets()
+ * context is locked. Interrupts are masked. set cannot be NULL.
+ * Access to the PMU is guaranteed.
+ *
+ * function must restore all PMD registers from set.
+ */
+void pfm_arch_restore_pmds(struct pfm_context *ctx, struct pfm_event_set *set)
+{
+	struct pfm_arch_pmu_info *arch_info = pfm_pmu_conf->arch_info;
+	struct pfm_arch_ext_reg *xregs;
+	u64 ovfl_mask, val, *pmds;
+	unsigned long *impl_rw_mask, *cnt_mask;
+	u16 i, max_rw_pmd;
+
+	max_rw_pmd = pfm_pmu_conf->max_rw_pmd;
+	cnt_mask = pfm_pmu_conf->cnt_pmds;
+	ovfl_mask = pfm_pmu_conf->ovfl_mask;
+	impl_rw_mask = pfm_pmu_conf->impl_rw_pmds;
+	pmds = set->set_view->set_pmds;
+
+	xregs = arch_info->pmd_addrs;
+
+	/*
+	 * must restore all pmds to avoid leaking
+	 * especially when PFM_I386_FL_INSECURE is set.
+	 *
+	 * XXX: should check PFM_X86_64_FL_INSECURE==0 and use used_pmd instead
+	 */
+	for (i = 0; i < max_rw_pmd; i++) {
+		if (likely(pfm_bv_isset(impl_rw_mask, i))) {
+			val = pmds[i];
+			if (likely(pfm_bv_isset(cnt_mask, i)))
+				val |= ~ovfl_mask;
+			__pfm_write_reg(xregs+i, val);
+		}
+	}
+}
+
+/*
+ * function called from pfm_switch_sets(), pfm_context_load_thread(),
+ * pfm_context_load_sys(), pfm_ctxswin_*(), pfm_switch_sets()
+ * context is locked. Interrupts are masked. set cannot be NULL.
+ * Access to the PMU is guaranteed.
+ *
+ * function must restore all PMC registers from set, if needed.
+ */
+void pfm_arch_restore_pmcs(struct pfm_context *ctx, struct pfm_event_set *set)
+{
+	struct pfm_arch_pmu_info *arch_info = pfm_pmu_conf->arch_info;
+	struct pfm_arch_ext_reg *xregs;
+	unsigned long *impl_pmcs;
+	u16 i, max_pmc;
+
+	max_pmc = pfm_pmu_conf->max_pmc;
+	xregs = arch_info->pmc_addrs;
+	impl_pmcs = pfm_pmu_conf->impl_pmcs;
+
+	/*
+	 * - by default, no PMC measures anything
+	 * - on ctxswout, all used PMCs are disabled (cccr cleared)
+	 *
+	 * we need to restore the PMC (incl enable bits) only if
+	 * not masked and user issued pfm_start()
+	 */
+	if (ctx->ctx_state == PFM_CTX_MASKED || ctx->ctx_fl_started == 0)
+		return;
+
+	/*
+	 * restore all pmcs and not just the ones that are used
+	 * to avoid using stale registers
+	 */
+	for (i = 0; i < max_pmc; i++)
+		if (pfm_bv_isset(impl_pmcs, i))
+			__pfm_write_reg(xregs+i, set->set_pmcs[i]);
+}
+
+/*
+ * function called from pfm_mask_monitoring(), pfm_switch_sets(),
+ * pfm_ctxswout_thread(), pfm_flush_pmds().
+ * context is locked. interrupts are masked. the set argument cannot
+ * be NULL. Access to PMU is guaranteed.
+ *
+ * function must saved PMD registers into set save area set_pmds[]
+ */
+void pfm_arch_save_pmds(struct pfm_context *ctx, struct pfm_event_set *set)
+{
+	struct pfm_arch_pmu_info *arch_info = pfm_pmu_conf->arch_info;
+	struct pfm_arch_ext_reg *xregs;
+	u64 hw_val, *pmds, ovfl_mask;
+	unsigned long *used_mask, *cnt_mask;
+	u16 i, max_pmd;
+
+	ovfl_mask = pfm_pmu_conf->ovfl_mask;
+	cnt_mask = pfm_pmu_conf->cnt_pmds;
+	used_mask = set->set_used_pmds;
+	pmds = set->set_view->set_pmds;
+	max_pmd = pfm_pmu_conf->max_pmd;
+
+	xregs = arch_info->pmd_addrs;
+
+	/*
+	 * save all used pmds
+	 */
+	for (i = 0; i < max_pmd; i++) {
+		if (pfm_bv_isset(used_mask, i)) {
+			__pfm_read_reg(xregs+i, &hw_val);
+			if (likely(pfm_bv_isset(cnt_mask, i)))
+				hw_val = (pmds[i] & ~ovfl_mask) | (hw_val & ovfl_mask);
+			pmds[i] = hw_val;
+		}
+	}
+}
+
+asmlinkage void pfm_intr_handler(struct pt_regs *regs)
+{
+	ack_APIC_irq();
+	irq_enter();
+	pfm_interrupt_handler(LOCAL_PERFMON_VECTOR, NULL, regs);
+	irq_exit();
+
+	/*
+	 * Intel EM64T:
+	 * 	- it is necessary to clear the MASK field for the LVTPC
+	 * 	  vector. Otherwise interrupts will stay masked. See
+	 * 	  section 8.5.1
+	 *
+	 * AMD X8-64:
+	 * 	- the documentation does not stipulate the behavior.
+	 * 	  To be safe, we also rewrite the vector to clear the
+	 * 	  mask field
+	 *
+	 * We only clear the mask field, if there is a PMU description
+	 * loaded. Otherwise we would have a problem  because without
+	 * PMU description we cannot access PMu registers to clear the
+	 * overfow condition and may end up in a flood of PMU interrupts.
+	 *
+	 * The APIC vector is initialized as masked, but we may already
+	 * have a pending PMU overflow by the time we get to
+	 * pfm_arch_init_percpu(). Such interrupt would generate a call
+	 * to this function, which would undo the masking and would
+	 * cause a flood.
+	 */
+	if (pfm_pmu_conf) apic_write(APIC_LVTPC, LOCAL_PERFMON_VECTOR);
+}
+
+
+asmlinkage void  pmu_interrupt(void);
+void pfm_vector_init(void)
+{
+	set_intr_gate(LOCAL_PERFMON_VECTOR, (void *)pmu_interrupt);
+	printk("CPU%d installed perfmon gate\n", smp_processor_id());
+}
+
+int pfm_arch_initialize(void)
+{
+	return 0;
+}
+
+void pfm_arch_mask_monitoring(struct pfm_context *ctx)
+{
+	/*
+	 * on X86-64 masking/unmasking uses start/stop
+	 * mechanism
+	 */
+	pfm_arch_stop(current, ctx, ctx->ctx_active_set);
+}
+
+void pfm_arch_unmask_monitoring(struct pfm_context *ctx)
+{
+	/*
+	 * on X86-64 masking/unmasking uses start/stop
+	 * mechanism
+	 */
+	__pfm_arch_start(current, ctx, ctx->ctx_active_set);
+}
+
+static void __pfm_stop_one_pmu(void *data)
+{
+	struct pfm_pmu_config *cfg = data;
+	struct pfm_arch_pmu_info *arch_info = cfg->arch_info;
+	struct pfm_arch_ext_reg *xregs;
+	unsigned int i, num_pmcs;
+
+	/*
+	 * if NMI watchdog is using Local APIC, then
+	 * counters are already initialized to a decent
+	 * state
+	 */
+	if (nmi_watchdog == NMI_LOCAL_APIC)
+		return;
+
+	DPRINT(("stopping on CPU%d: LVT=0x%x\n",
+		smp_processor_id(),
+		(unsigned int)apic_read(APIC_LVTPC)));
+
+	num_pmcs  = cfg->num_pmcs;
+	xregs = arch_info->pmc_addrs;
+
+	for (i = 0; i < num_pmcs; i++)
+		if (pfm_bv_isset(arch_info->enable_mask, i))
+			__pfm_write_reg(xregs+i, 0);
+
+	/*
+	 * now that we have a PMU description we can deal with spurious
+	 * interrupts, thus we can safely re-enable the LVTPC vector
+	 * by clearing the mask field
+	 */
+	apic_write(APIC_LVTPC, LOCAL_PERFMON_VECTOR);
+}
+
+/*
+ * called from pfm_register_pmu_config() after the new
+ * config has been validated and installed. No lock
+ * is held. Interrupts are not masked.
+ *
+ * The role of the function is, based on the PMU description, to
+ * put the PMU into a quiet state on each CPU. This function is
+ * not necessary if there is an architected way of doing this
+ * for a processor family.
+ */
+void pfm_arch_pmu_config_init(struct pfm_pmu_config *cfg)
+{
+	on_each_cpu(__pfm_stop_one_pmu, cfg, 1, 1);
+}
+
+/*
+ * called from pfm_register_pmu_config() after the new
+ * config has been validated and installed. The pfs_lock is held
+ * is held.
+ *
+ * Must sanity check the arch-specific config information
+ *
+ * return:
+ * 	< 0 : if error
+ * 	  0 : if success
+ */
+int pfm_arch_pmu_config_check(struct pfm_pmu_config *cfg)
+{
+	struct pfm_arch_pmu_info *arch_info = cfg->arch_info;
+
+	switch(arch_info->pmu_style) {
+		case PFM_X86_64_PMU_P4:
+			pfm_stop_active = __pfm_stop_active_p4;
+			break;
+		case PFM_X86_64_PMU_AMD:
+			pfm_stop_active = __pfm_stop_active_amd;
+			break;
+		default:
+			printk(KERN_ERR"unknown pmu_style=%d\n", arch_info->pmu_style);
+			return -1;
+	}
+	return 0;
+}
+
+static void pfm_save_pmu_nmi(void)
+{
+	struct pfm_arch_pmu_info *arch_info = pfm_pmu_conf->arch_info;
+	struct pfm_arch_ext_reg *xregs;
+	u64 *regs;
+	unsigned long *impl_mask;
+	u16 i, max_reg;
+printk(KERN_INFO"CPU%d: pfm_save_pmu_nmi called\n", smp_processor_id());
+	impl_mask = pfm_pmu_conf->impl_pmcs;
+	regs = __get_cpu_var(nmi_pmcs);
+	max_reg = pfm_pmu_conf->max_pmc;
+	xregs = arch_info->pmc_addrs;
+
+	if (regs == NULL)
+		return;
+
+	/*
+	 * save and clear all implemented pmcs
+	 */
+	for (i = 0; i < max_reg; i++) {
+		if (pfm_bv_isset(impl_mask, i)) {
+			__pfm_read_reg(xregs+i, regs+i);
+			__pfm_write_reg(xregs+i, 0);
+		}
+	}
+
+	impl_mask = pfm_pmu_conf->impl_pmds;
+	regs = __get_cpu_var(nmi_pmds);
+	max_reg = pfm_pmu_conf->max_pmd;
+	xregs = arch_info->pmd_addrs;
+
+	if (regs == NULL)
+		return;
+	/*
+	 * save all implemented pmds
+	 */
+	for (i = 0; i < max_reg; i++) {
+		if (pfm_bv_isset(impl_mask, i)) {
+			__pfm_read_reg(xregs+i, regs+i);
+		}
+	}
+}
+
+static void pfm_restore_pmu_nmi(void)
+{
+	struct pfm_arch_pmu_info *arch_info = pfm_pmu_conf->arch_info;
+	struct pfm_arch_ext_reg *xregs;
+	u64 *regs;
+	unsigned long *impl_mask;
+	u16 i, max_reg;
+
+printk(KERN_INFO"CPU%d: pfm_restore_pmu_nmi called\n", smp_processor_id());
+	impl_mask = pfm_pmu_conf->impl_pmds;
+	regs = __get_cpu_var(nmi_pmds);
+	max_reg = pfm_pmu_conf->max_pmd;
+	xregs = arch_info->pmd_addrs;
+
+	/*
+	 * restore all implemented pmds
+	 */
+	for (i = 0; i < max_reg; i++) {
+		if (pfm_bv_isset(impl_mask, i)) {
+			__pfm_write_reg(xregs+i, regs[i]);
+		}
+	}
+
+	impl_mask = pfm_pmu_conf->impl_pmcs;
+	regs = __get_cpu_var(nmi_pmcs);
+	max_reg = pfm_pmu_conf->max_pmc;
+	xregs = arch_info->pmc_addrs;
+
+	/*
+	 * restore all implemented pmcs
+	 */
+	for (i = 0; i < max_reg; i++) {
+		if (pfm_bv_isset(impl_mask, i)) {
+			__pfm_write_reg(xregs+i, regs[i]);
+		}
+	}
+}
+
+static void
+__pfm_reserve_lapic_nmi(void *data)
+{
+	__get_cpu_var(apic_state) = apic_read(APIC_LVTPC);
+	pfm_save_pmu_nmi();
+	apic_write(APIC_LVTPC, LOCAL_PERFMON_VECTOR);
+}
+
+static void
+__pfm_release_lapic_nmi(void *dummy)
+{
+	/*
+	 * apic_state assumed identical on all CPUs
+	 */
+	apic_write(APIC_LVTPC, __get_cpu_var(apic_state));
+	pfm_restore_pmu_nmi();
+}
+
+static int
+pfm_reserve_lapic_nmi(void)
+{
+	int ret;
+
+	/*
+	 * The NMI LAPIC watchdog timer is active on every CPU, so we need
+	 * to reserve (disable) on each CPU.
+	 */
+	ret = reserve_lapic_nmi();
+	if (ret)
+		return ret;
+
+	/*
+	 * save current APIC value for LVTPC entry
+	 * we assume APIC_LVTPC is identical on all CPUs
+	 */
+	__get_cpu_var(apic_state) = apic_read(APIC_LVTPC);
+
+#ifdef CONFIG_SMP
+	/*
+	 * invoke on all CPU but self
+	 */
+	smp_call_function(__pfm_reserve_lapic_nmi, NULL, 0, 1);
+#endif
+	__pfm_reserve_lapic_nmi(NULL);
+
+	return ret;
+}
+
+static void
+pfm_release_lapic_nmi(void)
+{
+	unsigned long flags;
+
+	/*
+	 * The NMI LAPIC watchdog timer is active on every CPU, so we need
+	 * to release on each CPU.
+	 *
+	 * we may be called with interrupts disabled. It is ok to
+	 * re-enable given where in perfmon.c this gets called from.
+	 *
+	 * XXX: if we clean up perfmon.c some more, this can go away
+	 */
+	local_save_flags(flags);
+	local_irq_enable();
+
+	__pfm_release_lapic_nmi(NULL);
+	
+#ifdef CONFIG_SMP
+	/*
+	 * invoke on all CPU but self
+	 */
+	smp_call_function( __pfm_release_lapic_nmi, NULL, 0, 1);
+#endif
+
+	local_irq_disable();
+
+	release_lapic_nmi();
+
+	local_irq_restore(flags);
+}
+
+/*
+ * Called from pfm_release_session() after release is done.
+ * Holding pfs_sessions lock. Interrupts may be masked.
+ */
+void pfm_arch_release_session(struct pfm_sessions *session,
+			  	struct pfm_context *ctx,
+				u32 cpu)
+{
+	u32 all_sessions;
+
+	all_sessions = session->pfs_task_sessions + session->pfs_sys_sessions;
+
+	/*
+	 * release APIC NMI when last session
+	 */
+	if (all_sessions == 0 && (__get_cpu_var(apic_state) & APIC_DM_NMI))
+		pfm_release_lapic_nmi();
+}
+
+/*
+ * Called from pfm_reserve_session() before any actual reservation
+ * is made. Holding pfs_sessions lock. Interrupts are not masked.
+ * Return:
+ * 	< 0 cannot reserve
+ * 	0 successful
+ */
+int pfm_arch_reserve_session(struct pfm_sessions *session,
+			     struct pfm_context *ctx,
+                             u32 cpu)
+{
+	u32 all_sessions;
+
+	all_sessions = session->pfs_task_sessions + session->pfs_sys_sessions;
+	/*
+	 * reserve only when first session
+	 */
+	if(all_sessions == 0 && nmi_watchdog == NMI_LOCAL_APIC
+	   && pfm_reserve_lapic_nmi() < 0) {
+		printk(KERN_WARNING"perfmon: conflict with NMI\n");
+		return -EBUSY;
+	}
+	return 0;
+}
diff -urN linux-2.6.16-rc1.orig/arch/x86_64/perfmon/perfmon_amd.c linux-2.6.16-rc1/arch/x86_64/perfmon/perfmon_amd.c
--- linux-2.6.16-rc1.orig/arch/x86_64/perfmon/perfmon_amd.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.16-rc1/arch/x86_64/perfmon/perfmon_amd.c	2006-01-18 08:50:44.000000000 -0800
@@ -0,0 +1,125 @@
+/*
+ * This file contains the AMD generic X86-64 PMU register
+ * description tables and pmc checker used by perfmon.c.
+ *
+ * Copyright (c) 2005-2006 Hewlett-Packard Development Company, L.P.
+ * Contributed by Stephane Eranian <eranian@hpl.hp.com>
+ */
+#include <linux/module.h>
+#include <linux/perfmon.h>
+
+MODULE_AUTHOR("Stephane Eranian <eranian@hpl.hp.com>");
+MODULE_DESCRIPTION("AMD X86-64 PMU description table");
+MODULE_LICENSE("GPL");
+
+static struct pfm_arch_pmu_info pfm_x86_64_pmu_info={
+	.pmc_addrs = {
+		{{MSR_K7_EVNTSEL0, 0}, 0, PFM_REGT_PERFSEL},
+		{{MSR_K7_EVNTSEL1, 0}, 1, PFM_REGT_PERFSEL},
+		{{MSR_K7_EVNTSEL2, 0}, 2, PFM_REGT_PERFSEL},
+		{{MSR_K7_EVNTSEL3, 0}, 3, PFM_REGT_PERFSEL},
+	},
+	.pmd_addrs = {
+		{{MSR_K7_PERFCTR0, 0}, 0, PFM_REGT_CTR},
+		{{MSR_K7_PERFCTR1, 0}, 0, PFM_REGT_CTR},
+		{{MSR_K7_PERFCTR2, 0}, 0, PFM_REGT_CTR},
+		{{MSR_K7_PERFCTR3, 0}, 0, PFM_REGT_CTR},
+	},
+	.pmu_style = PFM_X86_64_PMU_AMD,
+	.lps_per_core = 1
+};
+
+/*
+ * reserved bits must be zero
+ *
+ * - upper 32 bits are reserved
+ * - APIC enable bit is reserved (forced to 1)
+ * - bit 21 is reserved
+ */
+#define PFM_X86_64_RSVD	~((0xffffffffULL<<32)	\
+				| (PFM_ONE_64<<20)	\
+				| (PFM_ONE_64<<21))
+
+/*
+ * force Local APIC interrupt on overflow
+ */
+#define PFM_X86_64_VAL  (PFM_ONE_64<<20)
+#define PFM_X86_64_NO64	    (PFM_ONE_64<<20)
+
+static struct pfm_reg_desc pfm_x86_64_pmc_desc[PFM_MAX_PMCS+1]={
+/* pmc0  */ { PFM_REG_W64, "PERFSEL0", PFM_X86_64_VAL, PFM_X86_64_RSVD, PFM_X86_64_NO64},
+/* pmc1  */ { PFM_REG_W64, "PERFSEL1", PFM_X86_64_VAL, PFM_X86_64_RSVD, PFM_X86_64_NO64},
+/* pmc2  */ { PFM_REG_W64, "PERFSEL2", PFM_X86_64_VAL, PFM_X86_64_RSVD, PFM_X86_64_NO64},
+/* pmc3  */ { PFM_REG_W64, "PERFSEL3", PFM_X86_64_VAL, PFM_X86_64_RSVD, PFM_X86_64_NO64},
+	    { PFM_REG_END} /* end marker */
+};
+
+static struct pfm_reg_desc pfm_x86_64_pmd_desc[PFM_MAX_PMDS+1]={
+/* pmd0  */ { PFM_REG_C, "PERFCTR0", 0x0, -1},
+/* pmd1  */ { PFM_REG_C, "PERFCTR1", 0x0, -1},
+/* pmd2  */ { PFM_REG_C, "PERFCTR2", 0x0, -1},
+/* pmd3  */ { PFM_REG_C, "PERFCTR3", 0x0, -1},
+	    { PFM_REG_END} /* end marker */
+};
+
+static int pfm_x86_64_probe_pmu(void)
+{
+	printk(KERN_INFO"perfmon_x86_64: family=%d x86_model=%d\n",
+		cpu_data->x86,
+		cpu_data->x86_model);
+
+	if (cpu_data->x86 != 15) {
+		printk(KERN_INFO"perfmon_x86_64: unsupported family=%d\n", cpu_data->x86);
+		return -1;
+	}
+
+	if (cpu_data->x86_vendor != X86_VENDOR_AMD) {
+		printk(KERN_INFO"perfmon_x86_64: not an AMD processor\n");
+		return -1;
+	}
+
+	/*
+	 * check for local APIC (required)
+	 */
+	if (!cpu_has_apic) {
+		printk(KERN_INFO"perfmon_x86_64: no local APIC, unsupported\n");
+		return -1;
+	}
+	return 0;
+}
+
+static struct pfm_pmu_config pfm_x86_64_pmu_conf={
+	.pmu_name = "AMD X86-64",
+	.counter_width = 47,
+	.pmd_desc = pfm_x86_64_pmd_desc,
+	.pmc_desc = pfm_x86_64_pmc_desc,
+	.probe_pmu = pfm_x86_64_probe_pmu,
+	.version = "1.0",
+	.arch_info = &pfm_x86_64_pmu_info,
+	.flags = PFM_PMU_BUILTIN_FLAG,
+	.owner = THIS_MODULE
+};
+	
+static int __init pfm_x86_64_pmu_init_module(void)
+{
+	unsigned int i;
+
+	/*
+	 * XXX: could be hardcoded for this PMU model
+	 */
+	bitmap_zero(pfm_x86_64_pmu_info.enable_mask, PFM_MAX_HW_PMCS);
+	for(i=0; i < PFM_MAX_HW_PMCS; i++) {
+		if (pfm_x86_64_pmu_info.pmc_addrs[i].reg_type & PFM_REGT_PERFSEL) {
+			pfm_bv_set(pfm_x86_64_pmu_info.enable_mask, i);
+		}
+	}
+	return pfm_register_pmu_config(&pfm_x86_64_pmu_conf);
+}
+
+static void __exit pfm_x86_64_pmu_cleanup_module(void)
+{
+	pfm_unregister_pmu_config(&pfm_x86_64_pmu_conf);
+}
+
+module_init(pfm_x86_64_pmu_init_module);
+module_exit(pfm_x86_64_pmu_cleanup_module);
diff -urN linux-2.6.16-rc1.orig/arch/x86_64/perfmon/perfmon_em64t.c linux-2.6.16-rc1/arch/x86_64/perfmon/perfmon_em64t.c
--- linux-2.6.16-rc1.orig/arch/x86_64/perfmon/perfmon_em64t.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.16-rc1/arch/x86_64/perfmon/perfmon_em64t.c	2006-01-18 08:50:44.000000000 -0800
@@ -0,0 +1,390 @@
+/*	
+ * This file contains the EM64T PMU register description tables
+ * and pmc checker used by perfmon.c.
+ *
+ * Copyright (c) 2005 Intel Corporation
+ * Contributed by Bryan Wilkerson <bryan.p.wilkerson@intel.com>
+ */
+#include <linux/module.h>
+#include <linux/perfmon.h>
+#include <asm/msr.h>
+#include <asm/apic.h>
+
+MODULE_AUTHOR("Bryan Wilkerson <bryan.p.wilkerson@intel.com>");
+MODULE_DESCRIPTION("Intel EM64T PMU description table");
+MODULE_LICENSE("GPL");
+/*
+ * CCCR default value:
+ * 	- OVF_PMI_T0=1 (bit 26)
+ * 	- OVF_PMI_T1=0 (bit 27) (set if necessary in pfm_write_reg())
+ * 	- all other bits are zero
+ *
+ * OVF_PMI is force to zero if PFM_REGFL_NO_EMUL64 is set on CCCR
+ */
+#define PFM_CCCR_DFL	(PFM_ONE_64<<26)
+
+#define PFM_EM64T_NO64	(3ULL<<26) /* use 3 even in non HT */
+
+/*
+ * CCCR reserved fields:
+ * 	- bits 0-11, 25-29, 31-63
+ * 	- OVF_PMI (26-27), override with REGFL_NO_EMUL64
+ */
+#define PFM_CCCR_RSVD  0x0000000041fff000
+
+/*
+ * With HyperThreading enabled:
+ *
+ *  The ESCRs and CCCRs are divided in half with the top half
+ *  belonging to logical processor 0 and the bottom half going to
+ *  logical processor 1. Thus only half of the PMU resources are
+ *  accessible to applications.
+ *
+ *  PEBS is not available due to the fact that:
+ *  	- MSR_PEBS_MATRIX_VERT is shared between the threads
+ *      - IA32_PEBS_ENABLE is shared between the threads
+ *
+ * With Hyperthreading disabled:
+ *
+ * The full set of PMU resources is exposed to applications.
+ *
+ * The mapping is chosen such that PMCxx -> MSR is the same
+ * in HT and non HT mode, if register is present in HT mode.
+ *
+ */
+#define PFM_REGT_NHTESCR (PFM_REGT_ESCR|PFM_REGT_NOHT)
+#define PFM_REGT_NHTCCCR (PFM_REGT_CCCR|PFM_REGT_NOHT)
+#define PFM_REGT_NHTPEBS (PFM_REGT_PEBS|PFM_REGT_NOHT)
+#define PFM_REGT_NHTCTR  (PFM_REGT_CTR|PFM_REGT_NOHT)
+
+static struct pfm_arch_pmu_info pfm_em64t_pmu_info={
+	.pmc_addrs = {
+	/*pmc 0 */    {{0x3b2, 0x3b3}, 0, PFM_REGT_ESCR}, /*   BPU_ESCR0,1 */
+	/*pmc 1 */    {{0x3b4, 0x3b5}, 0, PFM_REGT_ESCR}, /*    IS_ESCR0,1 */
+	/*pmc 2 */    {{0x3aa, 0x3ab}, 0, PFM_REGT_ESCR}, /*   MOB_ESCR0,1 */
+	/*pmc 3 */    {{0x3b6, 0x3b7}, 0, PFM_REGT_ESCR}, /*  ITLB_ESCR0,1 */
+	/*pmc 4 */    {{0x3ac, 0x3ad}, 0, PFM_REGT_ESCR}, /*   PMH_ESCR0,1 */
+	/*pmc 5 */    {{0x3c8, 0x3c9}, 0, PFM_REGT_ESCR}, /*    IX_ESCR0,1 */
+	/*pmc 6 */    {{0x3a2, 0x3a3}, 0, PFM_REGT_ESCR}, /*   FSB_ESCR0,1 */
+	/*pmc 7 */    {{0x3a0, 0x3a1}, 0, PFM_REGT_ESCR}, /*   BSU_ESCR0,1 */
+	/*pmc 8 */    {{0x3c0, 0x3c1}, 0, PFM_REGT_ESCR}, /*    MS_ESCR0,1 */
+	/*pmc 9 */    {{0x3c4, 0x3c5}, 0, PFM_REGT_ESCR}, /*    TC_ESCR0,1 */
+	/*pmc 10*/    {{0x3c2, 0x3c3}, 0, PFM_REGT_ESCR}, /*  TBPU_ESCR0,1 */
+	/*pmc 11*/    {{0x3a6, 0x3a7}, 0, PFM_REGT_ESCR}, /* FLAME_ESCR0,1 */
+	/*pmc 12*/    {{0x3a4, 0x3a5}, 0, PFM_REGT_ESCR}, /*  FIRM_ESCR0,1 */
+	/*pmc 13*/    {{0x3ae, 0x3af}, 0, PFM_REGT_ESCR}, /*  SAAT_ESCR0,1 */
+	/*pmc 14*/    {{0x3b0, 0x3b1}, 0, PFM_REGT_ESCR}, /*   U2L_ESCR0,1 */
+	/*pmc 15*/    {{0x3a8, 0x3a9}, 0, PFM_REGT_ESCR}, /*   DAC_ESCR0,1 */
+	/*pmc 16*/    {{0x3ba, 0x3bb}, 0, PFM_REGT_ESCR}, /*    IQ_ESCR0,1 */
+	/*pmc 17*/    {{0x3ca, 0x3cb}, 0, PFM_REGT_ESCR}, /*   ALF_ESCR0,1 */
+	/*pmc 18*/    {{0x3bc, 0x3bd}, 0, PFM_REGT_ESCR}, /*   RAT_ESCR0,1 */
+	/*pmc 19*/    {{0x3be,     0}, 0, PFM_REGT_ESCR}, /*   SSU_ESCR0   */
+	/*pmc 20*/    {{0x3b8, 0x3b9}, 0, PFM_REGT_ESCR}, /*   CRU_ESCR0,1 */
+	/*pmc 21*/    {{0x3cc, 0x3cd}, 0, PFM_REGT_ESCR}, /*   CRU_ESCR2,3 */
+	/*pmc 22*/    {{0x3e0, 0x3e1}, 0, PFM_REGT_ESCR}, /*   CRU_ESCR4,5 */
+
+	/*pmc 23*/    {{0x360, 0x362}, 0, PFM_REGT_CCCR}, /*   BPU_CCCR0,1 */
+	/*pmc 24*/    {{0x361, 0x363}, 1, PFM_REGT_CCCR}, /*   BPU_CCCR2,3 */
+	/*pmc 25*/    {{0x364, 0x366}, 2, PFM_REGT_CCCR}, /*    MS_CCCR0,1 */
+	/*pmc 26*/    {{0x365, 0x367}, 3, PFM_REGT_CCCR}, /*    MS_CCCR2,3 */
+	/*pmc 27*/    {{0x368, 0x36a}, 4, PFM_REGT_CCCR}, /* FLAME_CCCR0,1 */
+	/*pmc 28*/    {{0x369, 0x36b}, 5, PFM_REGT_CCCR}, /* FLAME_CCCR2,3 */
+	/*pmc 29*/    {{0x36c, 0x36e}, 6, PFM_REGT_CCCR}, /*    IQ_CCCR0,1 */
+	/*pmc 30*/    {{0x36d, 0x36f}, 7, PFM_REGT_CCCR}, /*    IQ_CCCR2,3 */
+	/*pmc 31*/    {{0x370, 0x371}, 8, PFM_REGT_CCCR}, /*    IQ_CCCR4,5 */
+			/* non HT extensions */	
+	/*pmc 32*/    {{0x3b3,     0}, 0, PFM_REGT_NHTESCR}, /*   BPU_ESCR1   */
+	/*pmc 33*/    {{0x3b5,     0}, 0, PFM_REGT_NHTESCR}, /*    IS_ESCR1   */
+	/*pmc 34*/    {{0x3ab,     0}, 0, PFM_REGT_NHTESCR}, /*   MOB_ESCR1   */
+	/*pmc 35*/    {{0x3b7,     0}, 0, PFM_REGT_NHTESCR}, /*  ITLB_ESCR1   */
+	/*pmc 36*/    {{0x3ad,     0}, 0, PFM_REGT_NHTESCR}, /*   PMH_ESCR1   */
+	/*pmc 37*/    {{0x3c9,     0}, 0, PFM_REGT_NHTESCR}, /*    IX_ESCR1   */
+	/*pmc 38*/    {{0x3a3,     0}, 0, PFM_REGT_NHTESCR}, /*   FSB_ESCR1   */
+	/*pmc 39*/    {{0x3a1,     0}, 0, PFM_REGT_NHTESCR}, /*   BSU_ESCR1   */
+	/*pmc 40*/    {{0x3c1,     0}, 0, PFM_REGT_NHTESCR}, /*    MS_ESCR1   */
+	/*pmc 41*/    {{0x3c5,     0}, 0, PFM_REGT_NHTESCR}, /*    TC_ESCR1   */
+	/*pmc 42*/    {{0x3c3,     0}, 0, PFM_REGT_NHTESCR}, /*  TBPU_ESCR1   */
+	/*pmc 43*/    {{0x3a7,     0}, 0, PFM_REGT_NHTESCR}, /* FLAME_ESCR1   */
+	/*pmc 44*/    {{0x3a5,     0}, 0, PFM_REGT_NHTESCR}, /*  FIRM_ESCR1   */
+	/*pmc 45*/    {{0x3af,     0}, 0, PFM_REGT_NHTESCR}, /*  SAAT_ESCR1   */
+	/*pmc 46*/    {{0x3b1,     0}, 0, PFM_REGT_NHTESCR}, /*   U2L_ESCR1   */
+	/*pmc 47*/    {{0x3a9,     0}, 0, PFM_REGT_NHTESCR}, /*   DAC_ESCR1   */
+	/*pmc 48*/    {{0x3bb,     0}, 0, PFM_REGT_NHTESCR}, /*    IQ_ESCR1   */
+	/*pmc 49*/    {{0x3cb,     0}, 0, PFM_REGT_NHTESCR}, /*   ALF_ESCR1   */
+	/*pmc 50*/    {{0x3bd,     0}, 0, PFM_REGT_NHTESCR}, /*   RAT_ESCR1   */
+	/*pmc 51*/    {{0x3b9,     0}, 0, PFM_REGT_NHTESCR}, /*   CRU_ESCR1   */
+	/*pmc 52*/    {{0x3cd,     0}, 0, PFM_REGT_NHTESCR}, /*   CRU_ESCR3   */
+	/*pmc 53*/    {{0x3e1,     0}, 0, PFM_REGT_NHTESCR}, /*   CRU_ESCR5   */
+	/*pmc 54*/    {{0x362,     0}, 9, PFM_REGT_NHTCCCR}, /*   BPU_CCCR1   */
+	/*pmc 55*/    {{0x363,     0},10, PFM_REGT_NHTCCCR}, /*   BPU_CCCR3   */
+	/*pmc 56*/    {{0x366,     0},11, PFM_REGT_NHTCCCR}, /*    MS_CCCR1   */
+	/*pmc 57*/    {{0x367,     0},12, PFM_REGT_NHTCCCR}, /*    MS_CCCR3   */
+	/*pmc 58*/    {{0x36a,     0},13, PFM_REGT_NHTCCCR}, /* FLAME_CCCR1   */
+	/*pmc 59*/    {{0x36b,     0},14, PFM_REGT_NHTCCCR}, /* FLAME_CCCR3   */
+	/*pmc 60*/    {{0x36e,     0},15, PFM_REGT_NHTCCCR}, /*    IQ_CCCR1   */
+	/*pmc 61*/    {{0x36f,     0},16, PFM_REGT_NHTCCCR}, /*    IQ_CCCR3   */
+	/*pmc 62*/    {{0x371,     0},17, PFM_REGT_NHTCCCR}, /*    IQ_CCCR5   */
+	/*pmc 63*/    {{0x3f2,     0}, 0, PFM_REGT_NHTPEBS},/* PEBS_MATRIX_VERT */
+	/*pmc 64*/    {{0x3f1,     0}, 0, PFM_REGT_NHTPEBS} /* PEBS_ENABLE   */
+	},
+
+	.pmd_addrs = {
+	/*pmd 0 */    {{0x300, 0x302}, 0, PFM_REGT_CTR},  /*   BPU_CRT0,1  */
+	/*pmd 1 */    {{0x301, 0x303}, 0, PFM_REGT_CTR},  /*   BPU_CTR2,3  */
+	/*pmd 2 */    {{0x304, 0x306}, 0, PFM_REGT_CTR},  /*    MS_CRT0,1  */
+	/*pmd 3 */    {{0x305, 0x307}, 0, PFM_REGT_CTR},  /*    MS_CRT2,3  */
+	/*pmd 4 */    {{0x308, 0x30a}, 0, PFM_REGT_CTR},  /* FLAME_CRT0,1  */
+	/*pmd 5 */    {{0x309, 0x30b}, 0, PFM_REGT_CTR},  /* FLAME_CRT2,3  */
+	/*pmd 6 */    {{0x30c, 0x30e}, 0, PFM_REGT_CTR},  /*    IQ_CRT0,1  */
+	/*pmd 7 */    {{0x30d, 0x30f}, 0, PFM_REGT_CTR},  /*    IQ_CRT2,3  */
+	/*pmd 8 */    {{0x310, 0x311}, 0, PFM_REGT_CTR},  /*    IQ_CRT4,5  */
+			/*
+			 * non HT extensions
+			 */
+	/*pmd 9 */    {{0x302,     0}, 0, PFM_REGT_NHTCTR},  /*   BPU_CRT1    */
+	/*pmd 10*/    {{0x303,     0}, 0, PFM_REGT_NHTCTR},  /*   BPU_CTR3    */
+	/*pmd 11*/    {{0x306,     0}, 0, PFM_REGT_NHTCTR},  /*    MS_CRT1    */
+	/*pmd 12*/    {{0x307,     0}, 0, PFM_REGT_NHTCTR},  /*    MS_CRT3    */
+	/*pmd 13*/    {{0x30a,     0}, 0, PFM_REGT_NHTCTR},  /* FLAME_CRT1    */
+	/*pmd 14*/    {{0x30b,     0}, 0, PFM_REGT_NHTCTR},  /* FLAME_CRT3    */
+	/*pmd 15*/    {{0x30e,     0}, 0, PFM_REGT_NHTCTR},  /*    IQ_CRT1    */
+	/*pmd 16*/    {{0x30f,     0}, 0, PFM_REGT_NHTCTR},  /*    IQ_CRT3    */
+	/*pmd 17*/    {{0x311,     0}, 0, PFM_REGT_NHTCTR},  /*    IQ_CRT5    */
+	},
+	.pebs_ctr_idx = 8, /* thread0: IQ_CTR4, thread1: IQ_CTR5 */
+	.pmu_style  = PFM_X86_64_PMU_P4,
+	.lps_per_core = 1
+};
+
+static struct pfm_reg_desc pfm_em64t_pmc_desc[PFM_MAX_PMCS+1]={
+/* pmc0  */ { PFM_REG_W, "BPU_ESCR0"  , 0x0, PFM_ESCR_RSVD},
+/* pmc1  */ { PFM_REG_W, "IS_ESCR0"   , 0x0, PFM_ESCR_RSVD},
+/* pmc2  */ { PFM_REG_W, "MOB_ESCR0"  , 0x0, PFM_ESCR_RSVD},
+/* pmc3  */ { PFM_REG_W, "ITLB_ESCR0" , 0x0, PFM_ESCR_RSVD},
+/* pmc4  */ { PFM_REG_W, "PMH_ESCR0"  , 0x0, PFM_ESCR_RSVD},
+/* pmc5  */ { PFM_REG_W, "IX_ESCR0"   , 0x0, PFM_ESCR_RSVD},
+/* pmc6  */ { PFM_REG_W, "FSB_ESCR0"  , 0x0, PFM_ESCR_RSVD},
+/* pmc7  */ { PFM_REG_W, "BSU_ESCR0"  , 0x0, PFM_ESCR_RSVD},
+/* pmc8  */ { PFM_REG_W, "MS_ESCR0"   , 0x0, PFM_ESCR_RSVD},
+/* pmc9  */ { PFM_REG_W, "TC_ESCR0"   , 0x0, PFM_ESCR_RSVD},
+/* pmc10 */ { PFM_REG_W, "TBPU_ESCR0" , 0x0, PFM_ESCR_RSVD},
+/* pmc11 */ { PFM_REG_W, "FLAME_ESCR0", 0x0, PFM_ESCR_RSVD},
+/* pmc12 */ { PFM_REG_W, "FIRM_ESCR0" , 0x0, PFM_ESCR_RSVD},
+/* pmc13 */ { PFM_REG_W, "SAAT_ESCR0" , 0x0, PFM_ESCR_RSVD},
+/* pmc14 */ { PFM_REG_W, "U2L_ESCR0"  , 0x0, PFM_ESCR_RSVD},
+/* pmc15 */ { PFM_REG_W, "DAC_ESCR0"  , 0x0, PFM_ESCR_RSVD},
+/* pmc16 */ { PFM_REG_W, "IQ_ESCR0"   , 0x0, PFM_ESCR_RSVD},
+/* pmc17 */ { PFM_REG_W, "ALF_ESCR0"  , 0x0, PFM_ESCR_RSVD},
+/* pmc18 */ { PFM_REG_W, "RAT_ESCR0"  , 0x0, PFM_ESCR_RSVD},
+/* pmc19 */ { PFM_REG_W, "SSU_ESCR0"  , 0x0, PFM_ESCR_RSVD},
+/* pmc20 */ { PFM_REG_W, "CRU_ESCR0"  , 0x0, PFM_ESCR_RSVD},
+/* pmc21 */ { PFM_REG_W, "CRU_ESCR2"  , 0x0, PFM_ESCR_RSVD},
+/* pmc22 */ { PFM_REG_W, "CRU_ESCR4"  , 0x0, PFM_ESCR_RSVD},
+/* pmc23 */ { PFM_REG_W64, "BPU_CCCR0"  , PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_EM64T_NO64},
+/* pmc24 */ { PFM_REG_W64, "BPU_CCCR2"  , PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_EM64T_NO64},
+/* pmc25 */ { PFM_REG_W64, "MS_CCCR0"   , PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_EM64T_NO64},
+/* pmc26 */ { PFM_REG_W64, "MS_CCCR2"   , PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_EM64T_NO64},
+/* pmc27 */ { PFM_REG_W64, "FLAME_CCCR0", PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_EM64T_NO64},
+/* pmc28 */ { PFM_REG_W64, "FLAME_CCCR2", PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_EM64T_NO64},
+/* pmc29 */ { PFM_REG_W64, "IQ_CCCR0"   , PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_EM64T_NO64},
+/* pmc30 */ { PFM_REG_W64, "IQ_CCCR2"   , PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_EM64T_NO64},
+/* pmc31 */ { PFM_REG_W64, "IQ_CCCR4"   , PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_EM64T_NO64},
+		/* No HT extension */
+/* pmc32 */ { PFM_REG_W, "BPU_ESCR1"  , 0x0, PFM_ESCR_RSVD},
+/* pmc33 */ { PFM_REG_W, "IS_ESCR1"   , 0x0, PFM_ESCR_RSVD},
+/* pmc34 */ { PFM_REG_W, "MOB_ESCR1"  , 0x0, PFM_ESCR_RSVD},
+/* pmc35 */ { PFM_REG_W, "ITLB_ESCR1" , 0x0, PFM_ESCR_RSVD},
+/* pmc36 */ { PFM_REG_W, "PMH_ESCR1"  , 0x0, PFM_ESCR_RSVD},
+/* pmc37 */ { PFM_REG_W, "IX_ESCR1"   , 0x0, PFM_ESCR_RSVD},
+/* pmc38 */ { PFM_REG_W, "FSB_ESCR1"  , 0x0, PFM_ESCR_RSVD},
+/* pmc39 */ { PFM_REG_W, "BSU_ESCR1"  , 0x0, PFM_ESCR_RSVD},
+/* pmc40 */ { PFM_REG_W, "MS_ESCR1"   , 0x0, PFM_ESCR_RSVD},
+/* pmc41 */ { PFM_REG_W, "TC_ESCR1"   , 0x0, PFM_ESCR_RSVD},
+/* pmc42 */ { PFM_REG_W, "TBPU_ESCR1" , 0x0, PFM_ESCR_RSVD},
+/* pmc43 */ { PFM_REG_W, "FLAME_ESCR1", 0x0, PFM_ESCR_RSVD},
+/* pmc44 */ { PFM_REG_W, "FIRM_ESCR1" , 0x0, PFM_ESCR_RSVD},
+/* pmc45 */ { PFM_REG_W, "SAAT_ESCR1" , 0x0, PFM_ESCR_RSVD},
+/* pmc46 */ { PFM_REG_W, "U2L_ESCR1"  , 0x0, PFM_ESCR_RSVD},
+/* pmc47 */ { PFM_REG_W, "DAC_ESCR1"  , 0x0, PFM_ESCR_RSVD},
+/* pmc48 */ { PFM_REG_W, "IQ_ESCR1"   , 0x0, PFM_ESCR_RSVD},
+/* pmc49 */ { PFM_REG_W, "ALF_ESCR1"  , 0x0, PFM_ESCR_RSVD},
+/* pmc50 */ { PFM_REG_W, "RAT_ESCR1"  , 0x0, PFM_ESCR_RSVD},
+/* pmc51 */ { PFM_REG_W, "CRU_ESCR1"  , 0x0, PFM_ESCR_RSVD},
+/* pmc52 */ { PFM_REG_W, "CRU_ESCR3"  , 0x0, PFM_ESCR_RSVD},
+/* pmc53 */ { PFM_REG_W, "CRU_ESCR5"  , 0x0, PFM_ESCR_RSVD},
+/* pmc54 */ { PFM_REG_W64, "BPU_CCCR1"  , PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_EM64T_NO64},
+/* pmc55 */ { PFM_REG_W64, "BPU_CCCR3"  , PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_EM64T_NO64},
+/* pmc56 */ { PFM_REG_W64, "MS_CCCR1"   , PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_EM64T_NO64},
+/* pmc57 */ { PFM_REG_W64, "MS_CCCR3"   , PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_EM64T_NO64},
+/* pmc58 */ { PFM_REG_W64, "FLAME_CCCR1", PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_EM64T_NO64},
+/* pmc59 */ { PFM_REG_W64, "FLAME_CCCR3", PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_EM64T_NO64},
+/* pmc60 */ { PFM_REG_W64, "IQ_CCCR1"   , PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_EM64T_NO64},
+/* pmc61 */ { PFM_REG_W64, "IQ_CCCR3"   , PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_EM64T_NO64},
+/* pmc62 */ { PFM_REG_W64, "IQ_CCCR5"   , PFM_CCCR_DFL, PFM_CCCR_RSVD, PFM_EM64T_NO64},
+/* pmc63 */ { PFM_REG_W, "PEBS_MATRIX_VERT", 0, 0x13},
+/* pmc64 */ { PFM_REG_W, "PEBS_ENABLE", 0, 0x3000fff},
+	    { PFM_REG_END} /* end marker */
+};
+
+/*
+ * See section 15.10.6.6 for details about the IQ block
+ */
+static struct pfm_reg_desc pfm_em64t_pmd_desc[PFM_MAX_PMDS+1]={
+/* pmd0  */ { PFM_REG_C, "BPU_CTR0"   , 0x0, -1},
+/* pmd1  */ { PFM_REG_C, "BPU_CTR2"   , 0x0, -1},
+/* pmd2  */ { PFM_REG_C, "MS_CTR0"    , 0x0, -1},
+/* pmd3  */ { PFM_REG_C, "MS_CTR2"    , 0x0, -1},
+/* pmd4  */ { PFM_REG_C, "FLAME_CTR0" , 0x0, -1},
+/* pmd5  */ { PFM_REG_C, "FLAME_CTR2" , 0x0, -1},
+/* pmd6  */ { PFM_REG_C, "IQ_CTR0"    , 0x0, -1},
+/* pmd7  */ { PFM_REG_C, "IQ_CTR2"    , 0x0, -1},
+/* pmd8  */ { PFM_REG_C, "IQ_CTR4"    , 0x0, -1},
+		/* no HT extension */
+/* pmd9  */ { PFM_REG_C, "BPU_CTR1"   , 0x0, -1},
+/* pmd10 */ { PFM_REG_C, "BPU_CTR3"   , 0x0, -1},
+/* pmd11 */ { PFM_REG_C, "MS_CTR1"    , 0x0, -1},
+/* pmd12 */ { PFM_REG_C, "MS_CTR3"    , 0x0, -1},
+/* pmd13 */ { PFM_REG_C, "FLAME_CTR1" , 0x0, -1},
+/* pmd14 */ { PFM_REG_C, "FLAME_CTR3" , 0x0, -1},
+/* pmd15 */ { PFM_REG_C, "IQ_CTR1"    , 0x0, -1},
+/* pmd16 */ { PFM_REG_C, "IQ_CTR3"    , 0x0, -1},
+/* pmd17 */ { PFM_REG_C, "IQ_CTR5"    , 0x0, -1},
+	    { PFM_REG_END} /* end marker */
+};
+
+#define MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL (1<<12) /* PEBS unavailable */
+#define cpu_has_dts boot_cpu_has(X86_FEATURE_DTES)
+#define IS_LAST_PMC(i) (pfm_em64t_pmc_desc[i].type & PFM_REG_END)
+#define IS_LAST_PMD(i) (pfm_em64t_pmd_desc[i].type & PFM_REG_END)
+
+static int pfm_em64t_probe_pmu(void)
+{
+	int high, low;
+	unsigned int i;
+
+	printk(KERN_INFO"perfmon_em64t: family=%d x86_model=%d\n",
+		cpu_data->x86,
+		cpu_data->x86_model);
+	/*
+	 * must be family 15
+	 */
+	if (cpu_data->x86 != 15) {
+		printk(KERN_INFO"perfmon_em64t: unsupported family=%d\n", cpu_data->x86);
+		return -1;
+	}
+
+	/*
+	 * only works on Intel processors
+	 */
+	if (cpu_data->x86_vendor != X86_VENDOR_INTEL) {
+		printk(KERN_INFO"perfmon_em64t: not running on Intel processor\n");
+		return -1;
+	}
+
+	switch(cpu_data->x86_model) {
+		case 4:
+			break;
+		default:
+			/*
+			 * do not know if they all work the same, so reject for now
+			 */
+			printk(KERN_INFO"perfmon_em64t: unknown model %d\n", cpu_data->x86_model);
+			return -1;
+	}
+
+	/*
+	 * does not work with non EM64T processors
+	 */
+	if (cpuid_eax(0x80000000) < 0x80000001
+	    || (cpuid_edx(0x80000001) & (1<<29)) == 0) {
+		printk(KERN_INFO"perfmon_em64t: does not support non EM64T mode\n");
+		return -1;
+	}
+
+	/*
+	 * check for local APIC (required)
+	 */
+	if (!cpu_has_apic) {
+		printk(KERN_INFO"perfmon_em64t: no local APIC, unsupported\n");
+		return -1;
+	}
+
+	rdmsr(MSR_IA32_APICBASE, low, high);
+	if ((low & MSR_IA32_APICBASE_ENABLE) == 0)
+		printk(KERN_INFO"Local APIC in 3-wire mode\n");
+	
+#ifdef CONFIG_SMP
+	pfm_em64t_pmu_info.lps_per_core = cpus_weight(cpu_sibling_map[0]);
+#endif
+
+	printk(KERN_INFO"perfmon_em64t: cores/package=%d threads/core=%d\n",
+		cpu_data->x86_max_cores,
+		pfm_em64t_pmu_info.lps_per_core);
+
+
+	if (cpu_has_ht) {
+		printk(KERN_INFO"HyperThreading supported: %s\n",
+			pfm_em64t_pmu_info.lps_per_core > 1 ? "on": "off");
+		
+		/*
+		 * disable registers not supporting HT
+		 */
+		if (pfm_em64t_pmu_info.lps_per_core > 1) {
+			for (i = 0; !IS_LAST_PMC(i);  i++) {
+				if( pfm_em64t_pmu_info.pmc_addrs[(i)].reg_type & PFM_REGT_NOHT )
+					pfm_em64t_pmc_desc[i].type = PFM_REG_NA;
+			}
+			for (i = 0; !IS_LAST_PMD(i);  i++) {
+				if( pfm_em64t_pmu_info.pmd_addrs[(i)].reg_type & PFM_REGT_NOHT )
+					pfm_em64t_pmd_desc[i].type = PFM_REG_NA;
+			}
+		}
+	}
+	
+	if (cpu_has_dts) {
+		printk("Data Save Area (DS) supported\n");
+		pfm_em64t_pmu_info.flags = PFM_X86_64_PMU_DS;
+		rdmsr(MSR_IA32_MISC_ENABLE, low, high);
+		if ((low & MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL)==0) {
+			printk(KERN_INFO"PEBS supported\n");
+			pfm_em64t_pmu_info.flags |= PFM_X86_64_PMU_PEBS;
+		}
+	}
+	return 0;
+}
+
+static struct pfm_pmu_config pfm_em64t_pmu_conf={
+	.pmu_name = "Intel EM64T",
+	.counter_width = 40,
+	.pmd_desc = pfm_em64t_pmd_desc,
+	.pmc_desc = pfm_em64t_pmc_desc,
+	.probe_pmu = pfm_em64t_probe_pmu,
+	.version = "1.0",
+	.flags = PFM_PMU_BUILTIN_FLAG,
+	.owner = THIS_MODULE,
+	.arch_info = &pfm_em64t_pmu_info
+};
+	
+static int __init pfm_em64t_pmu_init_module(void)
+{
+	unsigned int i;
+
+	/*
+	 * compute enable bitmask
+	 */
+	bitmap_zero(pfm_em64t_pmu_info.enable_mask, PFM_MAX_HW_PMCS);
+	for(i=0; i < PFM_MAX_HW_PMCS; i++) {
+		if (pfm_em64t_pmu_info.pmc_addrs[i].reg_type & PFM_REGT_CCCR) {
+			pfm_bv_set(pfm_em64t_pmu_info.enable_mask, i);
+		}
+	}
+	return pfm_register_pmu_config(&pfm_em64t_pmu_conf);
+}
+
+static void __exit pfm_em64t_pmu_cleanup_module(void)
+{
+	pfm_unregister_pmu_config(&pfm_em64t_pmu_conf);
+}
+
+module_init(pfm_em64t_pmu_init_module);
+module_exit(pfm_em64t_pmu_cleanup_module);
diff -urN linux-2.6.16-rc1.orig/arch/x86_64/perfmon/perfmon_em64t_pebs_smpl.c linux-2.6.16-rc1/arch/x86_64/perfmon/perfmon_em64t_pebs_smpl.c
--- linux-2.6.16-rc1.orig/arch/x86_64/perfmon/perfmon_em64t_pebs_smpl.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.16-rc1/arch/x86_64/perfmon/perfmon_em64t_pebs_smpl.c	2006-01-18 08:50:44.000000000 -0800
@@ -0,0 +1,224 @@
+/*
+ * Copyright (c) 2005-2006 Hewlett-Packard Development Company, L.P.
+ * Contributed by Stephane Eranian <eranian@hpl.hp.com>
+ *
+ * This file implements the PEBS sampling format for Intel
+ * EM64T Intel Pentium 4/Xeon processors. It does not work
+ * with Intel 32-bit P4/Xeon processors.
+ */
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/sysctl.h>
+#include <asm/msr.h>
+
+#ifdef MODULE
+#define FMT_FLAGS	0
+#else
+#define FMT_FLAGS	PFM_FMTFL_IS_BUILTIN
+#endif
+
+#include <linux/perfmon.h>
+#include <asm/perfmon_em64t_pebs_smpl.h>
+
+#ifndef __x86_64__
+#error "this module is for the Intel EM64T processors"
+#endif
+
+MODULE_AUTHOR("Stephane Eranian <eranian@hpl.hp.com>");
+MODULE_DESCRIPTION("Intel 64-bit P4/Xeon PEBS sampling");
+MODULE_LICENSE("GPL");
+
+static int pfm_pebs_fmt_validate(u32 flags, u16 npmds, void *data)
+{
+	struct pfm_arch_pmu_info *arch_info = pfm_pmu_conf->arch_info;
+	pfm_em64t_pebs_smpl_arg_t *arg = data;
+	size_t min_buf_size;
+
+	/*
+	 * host CPU does not have PEBS support
+	 */
+	if ((arch_info->flags & PFM_X86_64_PMU_PEBS) == 0) {
+		DPRINT(("host PMU does not support PEBS sampling\n"));
+		return -EINVAL;
+	}
+
+	/*
+	 * need to define at least the size of the buffer
+	 */
+	if (data == NULL) {
+		DPRINT(("no argument passed\n"));
+		return -EINVAL;
+	}
+
+	/*
+	 * compute min buf size. npmds is the maximum number
+	 * of implemented PMD registers.
+	 */
+	min_buf_size = sizeof(pfm_em64t_pebs_smpl_hdr_t) + sizeof(pfm_em64t_pebs_smpl_entry_t);
+
+	DPRINT(("validate flags=0x%x min_buf_size=%zu buf_size=%zu\n",
+		flags,
+		min_buf_size,
+		arg->buf_size));
+
+	/*
+	 * must hold at least the buffer header + one minimally sized entry
+	 */
+	if (arg->buf_size < min_buf_size)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int pfm_pebs_fmt_get_size(unsigned int flags, void *data, size_t *size)
+{
+	pfm_em64t_pebs_smpl_arg_t *arg = data;
+
+	/*
+	 * size has been validated in pebs_fmt_validate()
+	 */
+	*size = arg->buf_size + 256;
+
+	return 0;
+}
+
+static int pfm_pebs_fmt_init(struct pfm_context *ctx, void *buf,
+			     u32 flags, u16 npmds, void *data)
+{
+	struct pfm_arch_context *ctx_arch;
+	pfm_em64t_pebs_smpl_hdr_t *hdr;
+	pfm_em64t_pebs_smpl_arg_t *arg = data;
+	unsigned long base;
+	pfm_em64t_ds_area_t *ds;
+
+	ctx_arch = pfm_ctx_arch(ctx);
+
+	hdr = buf;
+	ds = &hdr->hdr_ds;
+
+	hdr->hdr_version = PFM_EM64T_PEBS_SMPL_VERSION;
+	hdr->hdr_buf_size = arg->buf_size;
+	hdr->hdr_overflows = 0;
+
+	/*
+	 * align base
+	 */
+	base = ((unsigned long)(hdr+1) + 256) & ~0xffUL;
+	hdr->hdr_start_offs = base - (unsigned long)(hdr+1);
+	ds->pebs_buf_base = base;
+	ds->pebs_abs_max = base + arg->buf_size + 1;
+	ds->pebs_intr_thres = base + arg->intr_thres*sizeof(pfm_em64t_pebs_smpl_entry_t);
+	ds->pebs_index = base;
+
+	/*
+	 * save counter reset value for IQ_CCCR4 (thread0) or IQ_CCCR5 (thread1)
+	 */
+	ds->pebs_cnt_reset = arg->cnt_reset;
+
+	/*
+	 * ensure proper PEBS handling in arch/.../perfmon/perfmon.c
+	 */
+	ctx_arch->flags |= PFM_X86_64_FL_USE_PEBS;
+	ctx_arch->ds_area = ds;
+
+	DPRINT(("buffer=%p buf_size=%zu  ctx_flags=0x%x"
+		"pebs_base=0x%llx pebs_max=0x%llx pebs_thres=0x%llx cnt_reset=0x%llx\n",
+		buf,
+		hdr->hdr_buf_size,
+		ctx_arch->flags,
+		ds->pebs_buf_base,
+		ds->pebs_abs_max,
+		ds->pebs_intr_thres,
+		ds->pebs_cnt_reset));
+
+	return 0;
+}
+
+static int pfm_pebs_fmt_handler(void *buf, struct pfm_ovfl_arg *arg,
+			       unsigned long ip, u64 tstamp, void *data)
+{
+	pfm_em64t_pebs_smpl_hdr_t *hdr;
+
+	hdr = buf;
+
+	DPRINT_ovfl(("buffer full\n"));
+	/*
+	 * increment number of buffer overflows.
+	 * important to detect duplicate set of samples.
+	 */
+	hdr->hdr_overflows++;
+
+	/*
+	 * request notification and masking of monitoring.
+	 * Notification is still subject to the overflowed
+	 * register having the FL_NOTIFY flag set.
+	 */
+	arg->ovfl_ctrl = PFM_OVFL_CTRL_NOTIFY| PFM_OVFL_CTRL_MASK;
+
+	return -ENOBUFS; /* we are full, sorry */
+}
+
+static int pfm_pebs_fmt_restart(int is_active, u32 *ovfl_ctrl, void *buf)
+{
+	pfm_em64t_pebs_smpl_hdr_t *hdr = buf;
+
+	/*
+	 * reset index to base of buffer
+	 */
+	hdr->hdr_ds.pebs_index = hdr->hdr_ds.pebs_buf_base;
+
+	*ovfl_ctrl = PFM_OVFL_CTRL_RESET;
+
+	return 0;
+}
+
+static int pfm_pebs_fmt_exit(void *buf)
+{
+	return 0;
+}
+
+static struct pfm_smpl_fmt pebs_fmt={
+ 	.fmt_name = "EM64T P4/Xeon PEBS",
+ 	.fmt_uuid = PFM_EM64T_PEBS_SMPL_UUID,
+ 	.fmt_arg_size = sizeof(pfm_em64t_pebs_smpl_arg_t),
+ 	.fmt_validate = pfm_pebs_fmt_validate,
+ 	.fmt_getsize = pfm_pebs_fmt_get_size,
+ 	.fmt_init = pfm_pebs_fmt_init,
+ 	.fmt_handler = pfm_pebs_fmt_handler,
+ 	.fmt_restart = pfm_pebs_fmt_restart,
+ 	.fmt_exit = pfm_pebs_fmt_exit,
+	.fmt_flags = FMT_FLAGS,
+	.owner = THIS_MODULE
+};
+
+#define MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL (1<<12) /* PEBS unavailable */
+#define cpu_has_dts boot_cpu_has(X86_FEATURE_DTES)
+
+static int __init pfm_pebs_fmt_init_module(void)
+{
+	int low, high;
+
+	if (!cpu_has_dts) {
+		printk(KERN_INFO"Processor does not have Data Save Area (DS)\n");
+		return -1;
+	}
+	rdmsr(MSR_IA32_MISC_ENABLE, low, high);
+
+	if (low & MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL) {
+		printk(KERN_INFO"Processor does not support PEBS\n");
+		return -1;
+	}
+	return pfm_register_smpl_fmt(&pebs_fmt);
+}
+
+static void __exit pfm_pebs_fmt_cleanup_module(void)
+{
+	pfm_unregister_smpl_fmt(pebs_fmt.fmt_uuid);
+}
+
+module_init(pfm_pebs_fmt_init_module);
+module_exit(pfm_pebs_fmt_cleanup_module);
diff -urN linux-2.6.16-rc1.orig/include/asm-x86_64/hw_irq.h linux-2.6.16-rc1/include/asm-x86_64/hw_irq.h
--- linux-2.6.16-rc1.orig/include/asm-x86_64/hw_irq.h	2006-01-18 08:48:17.000000000 -0800
+++ linux-2.6.16-rc1/include/asm-x86_64/hw_irq.h	2006-01-18 08:50:44.000000000 -0800
@@ -67,6 +67,7 @@
  * sources per level' errata.
  */
 #define LOCAL_TIMER_VECTOR	0xef
+#define LOCAL_PERFMON_VECTOR	0xee
 
 /*
  * First APIC vector available to drivers: (vectors 0x30-0xee)
@@ -74,7 +75,7 @@
  * levels. (0x80 is the syscall vector)
  */
 #define FIRST_DEVICE_VECTOR	0x31
-#define FIRST_SYSTEM_VECTOR	0xef   /* duplicated in irq.h */
+#define FIRST_SYSTEM_VECTOR	0xee   /* duplicated in irq.h */
 
 
 #ifndef __ASSEMBLY__
diff -urN linux-2.6.16-rc1.orig/include/asm-x86_64/irq.h linux-2.6.16-rc1/include/asm-x86_64/irq.h
--- linux-2.6.16-rc1.orig/include/asm-x86_64/irq.h	2006-01-18 08:48:17.000000000 -0800
+++ linux-2.6.16-rc1/include/asm-x86_64/irq.h	2006-01-18 08:50:44.000000000 -0800
@@ -29,7 +29,7 @@
  */
 #define NR_VECTORS 256
 
-#define FIRST_SYSTEM_VECTOR	0xef   /* duplicated in hw_irq.h */
+#define FIRST_SYSTEM_VECTOR	0xee   /* duplicated in hw_irq.h */
 
 #ifdef CONFIG_PCI_MSI
 #define NR_IRQS FIRST_SYSTEM_VECTOR
diff -urN linux-2.6.16-rc1.orig/include/asm-x86_64/perfmon.h linux-2.6.16-rc1/include/asm-x86_64/perfmon.h
--- linux-2.6.16-rc1.orig/include/asm-x86_64/perfmon.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.16-rc1/include/asm-x86_64/perfmon.h	2006-01-18 08:50:44.000000000 -0800
@@ -0,0 +1,270 @@
+/*
+ * Copyright (c) 2005-2006 Hewlett-Packard Development Company, L.P.
+ * Contributed by Stephane Eranian <eranian@hpl.hp.com>
+ *
+ * This file contains X86-64 Processor Family specific definitions
+ * for the perfmon interface.
+ *
+ * This file MUST never be included directly. Use linux/perfmon.h.
+ */
+#ifndef _ASM_X86_64_PERFMON_H_
+#define _ASM_X86_64_PERFMON_H_
+
+/*
+ * X86-64 specific context flags
+ */
+#define PFM_X86_64_FL_INSECURE	0x10000	/* allow rdpmc at user level */
+
+#ifdef __KERNEL__
+
+#include <asm/desc.h>
+#include <asm/apic.h>
+
+/* 
+ * For EM64T only: - bits 31 - 63 reserved
+ * - T1_OS and T1_USR bits are reserved - set depending on logical proc
+ *      user mode application should use T0_OS and T0_USR to indicate
+ */
+#define PFM_ESCR_RSVD  0x000000007ffffffc
+
+/*
+ * bitmask for reg_type
+ * layout:
+ * bit 00-15: reg_type (1 bit set)
+ * bit 16-31: attribute (can be ORed with bit 0-15)
+ */
+#define PFM_REGT_PERFSEL 0x01 /* AMD: PERFSEL cannot be zero due to ext_reg init */
+#define PFM_REGT_ESCR    0x02 /* P4: ESCR */
+#define PFM_REGT_CCCR    0x04 /* P4: CCCR (has enable bit) */
+#define PFM_REGT_CTR     0x08 /* P4/P6: is a counter */
+#define PFM_REGT_LBR     0x10 /* P4: LBR */
+#define PFM_REGT_LBRTOS  0x20 /* P4: LBRTOS */
+#define PFM_REGT_PEBS	 0x40 /* P4: PEBS related */
+#define PFM_REGT_NOHT    0x10000 /* P4: no available with HT */
+
+/*
+ * This design and the partitioning of resources for SMT (hyper threads)
+ * is very static and limited due to limitations in the number of ESCRs
+ * and CCCRs per group.
+ */
+#define MAX_SMT_ID 1
+
+/*
+ * For extended register information in addition to address that is used
+ * at runtime to figure out the mapping of reg addresses to logical procs
+ * and association of registers to hardware specific features
+ */
+struct pfm_arch_ext_reg {
+	/*
+	 * one each for the logical CPUs.  Index 0 corresponds to T0 and
+	 * index 1 corresponds to T1.  Index 1 can be zero if no T1
+	 * complement reg exists (example SSU_ESCR0 or as in all AMD64)
+	 */
+	unsigned long addrs[MAX_SMT_ID+1];
+	unsigned int ctr; /* for CCCR/PERFSEL, associated counter */
+	unsigned int reg_type;
+};
+
+struct pfm_arch_pmu_info {
+	struct pfm_arch_ext_reg pmc_addrs[PFM_MAX_HW_PMCS];
+	struct pfm_arch_ext_reg pmd_addrs[PFM_MAX_HW_PMDS];
+	unsigned long enable_mask[PFM_PMC_BV]; /* PMC registers with enable bit */
+
+	u16 lps_per_core;  /* # of logical processors per core */
+	u8  pmu_style;	   /* type of PMU interface (P4, P6) */
+	u16 pebs_ctr_idx;  /* index of PEBS IQ_CTR4 counter  (for overflow) */
+	u16 flags;	   /* PMU feature flags */
+};
+/*
+ * X86-64/EM64T PMU style
+ */
+#define PFM_X86_64_PMU_AMD	1	/* AMD X86-64 (architected) */
+#define PFM_X86_64_PMU_P4	2	/* Intel EM64T P4/Xeon style */
+
+/*
+ * PMU feature flags
+ */
+#define PFM_X86_64_PMU_DS	0x1	/* Intel: support for Data Save Area (DS) */
+#define PFM_X86_64_PMU_PEBS	0x2	/* Intel: support PEBS (implies DS) */
+
+extern void __pfm_read_reg(const struct pfm_arch_ext_reg *xreg, u64 *val);
+extern void __pfm_write_reg(const struct pfm_arch_ext_reg *xreg, u64 val);
+
+static inline void pfm_arch_resend_irq(void)
+{
+	unsigned long val, dest;
+	
+	/*
+	 * we cannot use hw_resend_irq() because it goes to
+	 * the I/O APIC. We need to go to the Local Apic.
+	 *
+	 * The "int vec" is not the right solution either
+	 * because it triggers a software intr. We need
+	 * to regenerate the intr. and have it pended until
+	 * we unmask interrupts.
+	 *
+	 * Instead we send ourself an IPI on the perfmon
+	 * vector.
+	 */
+	val  = APIC_DEST_SELF|APIC_INT_ASSERT|
+	       APIC_DM_FIXED|LOCAL_PERFMON_VECTOR;
+	dest = apic_read(APIC_ID);
+	apic_write(APIC_ICR2, dest);
+	apic_write(APIC_ICR, val);
+}
+
+#define pfm_arch_serialize()	/* nothing */
+
+static inline u64 pfm_arch_get_itc(void)
+{
+	u64 tmp;
+	rdtscll(tmp);
+	return tmp;
+}
+
+extern void __pfm_read_reg(const struct pfm_arch_ext_reg *xreg, u64 *val);
+extern void __pfm_write_reg(const struct pfm_arch_ext_reg *xreg, u64 val);
+
+static inline void pfm_arch_write_pmc(struct pfm_context *ctx, unsigned int cnum, u64 value)
+{
+	struct pfm_arch_pmu_info *arch_info = pfm_pmu_conf->arch_info;
+	/*
+	 * we only write to the actual register when monitoring is
+	 * active (pfm_start was issued)
+	 */
+	if (ctx && ctx->ctx_fl_started == 0) return;
+
+	__pfm_write_reg(&arch_info->pmc_addrs[cnum], value);
+}
+
+static inline void pfm_arch_write_pmd(struct pfm_context *ctx, unsigned int cnum, u64 value)
+{
+	struct pfm_arch_pmu_info *arch_info = pfm_pmu_conf->arch_info;
+
+	/*
+	 * force upper bit set for counter to ensure overflow
+	 */
+	if (arch_info->pmd_addrs[cnum].reg_type & PFM_REGT_CTR)
+		value |=~pfm_pmu_conf->ovfl_mask;
+
+	__pfm_write_reg(&arch_info->pmd_addrs[cnum], value);
+}
+
+static inline u64 pfm_arch_read_pmd(struct pfm_context *ctx, unsigned int cnum)
+{
+	struct pfm_arch_pmu_info *arch_info = pfm_pmu_conf->arch_info;
+	u64 tmp;
+	__pfm_read_reg(&arch_info->pmd_addrs[cnum], &tmp);
+	return tmp;
+}
+
+static inline u64 pfm_arch_read_pmc(struct pfm_context *ctx, unsigned int cnum)
+{
+	struct pfm_arch_pmu_info *arch_info = pfm_pmu_conf->arch_info;
+	u64 tmp;
+	__pfm_read_reg(&arch_info->pmc_addrs[cnum], &tmp);
+	return tmp;
+}
+
+/*
+ * At certain points, perfmon needs to know if monitoring has been
+ * explicitely started/stopped by user via pfm_start/pfm_stop. The
+ * information is tracked in ctx_fl_started. However on certain
+ * architectures, it may be possible to start/stop directly from
+ * user level with a single assembly instruction bypassing
+ * the kernel. This function must be used to determine by
+ * an arch-specific mean if monitoring is actually started/stopped.
+ * If there is no other way but to go through pfm_start/pfm_stop
+ * then this function can simply return 0
+ */
+static inline int pfm_arch_is_active(struct pfm_context *ctx)
+{
+	return 0;
+}
+
+extern void pfm_arch_init_percpu(void);
+extern void pfm_arch_ctxswout(struct task_struct *task,
+		struct pfm_context *ctx, struct pfm_event_set *set);
+extern void pfm_arch_ctxswin(struct task_struct *task,
+		struct pfm_context *ctx, struct pfm_event_set *set);
+extern void pfm_arch_stop(struct task_struct *task,
+		struct pfm_context *ctx, struct pfm_event_set *set);
+extern void pfm_arch_start(struct task_struct *task,
+		struct pfm_context *ctx, struct pfm_event_set *set);
+extern void pfm_arch_restore_pmds(struct pfm_context *ctx, struct pfm_event_set *set);
+extern void pfm_arch_save_pmds(struct pfm_context *ctx, struct pfm_event_set *set);
+extern void pfm_arch_restore_pmcs(struct pfm_context *ctx, struct pfm_event_set *set);
+extern int  pfm_arch_get_ovfl_pmds(struct pfm_context *ctx,
+		struct pfm_event_set *set);
+extern void pfm_arch_intr_freeze_pmu(struct pfm_context *ctx);
+extern void pfm_arch_intr_unfreeze_pmu(struct pfm_context *ctx);
+extern int  pfm_arch_initialize(void);
+extern void pfm_arch_mask_monitoring(struct pfm_context *ctx);
+extern void pfm_arch_unmask_monitoring(struct pfm_context *ctx);
+extern int  pfm_arch_pmu_config_check(struct pfm_pmu_config *cfg);
+extern void pfm_arch_pmu_config_init(struct pfm_pmu_config *cfg);
+extern void pfm_arch_context_initialize(struct pfm_context *ctx, u32 ctx_flags);
+extern void pfm_arch_unload_context(struct pfm_context *ctx,
+		struct task_struct *task);
+extern int  pfm_arch_load_context(struct pfm_context *ctx,
+		struct task_struct *task);
+
+extern void pfm_arch_release_session(struct pfm_sessions *session,
+				     struct pfm_context *ctx,
+				     u32 cpu);
+
+extern int pfm_arch_reserve_session(struct pfm_sessions *session,
+				    struct pfm_context *ctx,
+	                            u32 cpu);
+
+//void pfm_arch_unfreeze_pmu(void)
+#define pfm_arch_unfreeze_pmu()
+
+
+/*
+ * function called from pfm_setfl_sane(). Context is locked
+ * and interrupts are masked. The value of flags is the value
+ * of ctx_flags as passed by user.
+ *
+ * function must check arch-specific set flags.
+ * Return:
+ * 	1 when flags are valid
+ *      0 on error
+ */
+static inline int pfm_arch_setfl_sane(struct pfm_context *ctx, u32 flags)
+{
+	return 0;
+}
+
+//static inline void pfm_arch_show_session(struct seq_file *m);
+#define pfm_arch_show_session(m) /* nothing */
+
+/*
+ * on AMD X86-64, Intel EM64T P4/Xeon the upper bits of a counter
+ * must be set in order for the overflow interrupt to happen. On
+ * overflow, the counter has wrapped around, and the upper bits
+ * are now cleared. This function set them back.
+ *
+ * The current version loses whatever is remaining in the counter,
+ * which is usually not zero but has a small count. In order not
+ * to loose this count, we do a read-modify-write to set the upper
+ * bits while preserving the low-order bits. This is slow but
+ * works.
+ */
+static inline void pfm_arch_ovfl_reset_pmd(struct pfm_context *ctx, unsigned int cnum)
+{
+	u64 val;
+	val = pfm_arch_read_pmd(ctx, cnum);
+	pfm_arch_write_pmd(ctx, cnum, val);
+}
+
+#define PFM_X86_64_FL_USE_PEBS	0x20000	/* Intel: context uses PEBS */
+struct pfm_arch_context {
+	void	*ds_area;	/* Intel: pointer to DS management area */
+	u32	flags;		/* arch-specific flags */
+};
+
+#define PFM_ARCH_CTX_SIZE	sizeof(struct pfm_arch_context)
+
+#endif /* __KERNEL__ */
+#endif /* _ASM_X86_64_PERFMON_H_ */
diff -urN linux-2.6.16-rc1.orig/include/asm-x86_64/perfmon_em64t_pebs_smpl.h linux-2.6.16-rc1/include/asm-x86_64/perfmon_em64t_pebs_smpl.h
--- linux-2.6.16-rc1.orig/include/asm-x86_64/perfmon_em64t_pebs_smpl.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.16-rc1/include/asm-x86_64/perfmon_em64t_pebs_smpl.h	2006-01-18 08:50:44.000000000 -0800
@@ -0,0 +1,106 @@
+/*
+ * Copyright (c) 2005-2006 Hewlett-Packard Development Company, L.P.
+ * Contributed by Stephane Eranian <eranian@hpl.hp.com>
+ *
+ * This file implements the PEBS sampling format for 64-bit
+ * Intel EM64T Pentium 4/Xeon processors. Not to be used with
+ * 32-bit Intel processors.
+ */
+#ifndef __PERFMON_EM64T_PEBS_SMPL_H__
+#define __PERFMON_EM64T_PEBS_SMPL_H__ 1
+
+#define PFM_EM64T_PEBS_SMPL_UUID { \
+	0x36, 0xbe, 0x97, 0x94, 0x1f, 0xbf, 0x41, 0xdf,\
+	0xb4, 0x63, 0x10, 0x62, 0xeb, 0x72, 0x9b, 0xad}
+
+/*
+ * format specific parameters (passed at context creation)
+ *
+ * intr_thres: index from start of buffer of entry where the
+ * PMU interrupt must be triggered. It must be several samples
+ * short of the end of the buffer.
+ */
+typedef struct {
+	size_t	buf_size;	/* size of the buffer in bytes */
+	size_t	intr_thres;	/* index of interrupt threshold entry */
+	u32	flags;		/* buffer specific flags */
+	u64	cnt_reset;	/* counter reset value */
+	u32	res1;		/* for future use */
+	u64	reserved[2];	/* for future use */
+} pfm_em64t_pebs_smpl_arg_t;
+
+/*
+ * combined context+format specific structure. Can be passed
+ * to pfm_context_create()
+ */
+typedef struct {
+	pfarg_ctx_t			ctx_arg;
+	pfm_em64t_pebs_smpl_arg_t	buf_arg;
+} pfm_em64t_pebs_smpl_ctx_arg_t;
+
+/*
+ * DS Save Area as described in section 15.10.5 for
+ * 32-bit but extended to 64-bit
+ */
+typedef struct {
+	u64	bts_buf_base;
+	u64	bts_index;
+	u64	bts_abs_max;
+	u64	bts_intr_thres;
+	u64	pebs_buf_base;
+	u64	pebs_index;
+	u64	pebs_abs_max;
+	u64	pebs_intr_thres;
+	u64     pebs_cnt_reset;
+} pfm_em64t_ds_area_t;
+
+/*
+ * This header is at the beginning of the sampling buffer returned to the user.
+ *
+ * Because of PEBS alignement constraints, the actual PEBS buffer area does
+ * not necessarily begin right after the header. The hdr_start_offs must be
+ * used to compute the first byte of the buffer. The offset is defined as
+ * the number of bytes between the end of the header and the beginning of
+ * the buffer. As such the formula is:
+ * 	actual_buffer = (unsigned long)(hdr+1)+hdr->hdr_start_offs
+ */
+typedef struct {
+	u64			hdr_overflows;	/* #overflows for buffer */
+	size_t			hdr_buf_size;	/* bytes in the buffer */
+	size_t			hdr_start_offs; /* actual buffer start offset */
+	u32			hdr_version;	/* smpl format version */
+	u64			hdr_res[3];	/* for future use */
+	pfm_em64t_ds_area_t	hdr_ds;		/* DS management Area */
+} pfm_em64t_pebs_smpl_hdr_t;
+
+/*
+ * EM64T PEBS record format as described in
+ * http://www.intel.com/technology/64bitextensions/30083502.pdf
+ */
+typedef struct {
+	u64	eflags;
+	u64	ip;
+	u64	eax;
+	u64	ebx;
+	u64	ecx;
+	u64	edx;
+	u64	esi;
+	u64	edi;
+	u64	ebp;
+	u64	esp;
+	u64	r8;
+	u64	r9;
+	u64	r10;
+	u64	r11;
+	u64	r12;
+	u64	r13;
+	u64	r14;
+	u64	r15;
+} pfm_em64t_pebs_smpl_entry_t;
+
+#define PFM_EM64T_PEBS_SMPL_VERSION_MAJ 1U
+#define PFM_EM64T_PEBS_SMPL_VERSION_MIN 0U
+#define PFM_EM64T_PEBS_SMPL_VERSION (((PFM_EM64T_PEBS_SMPL_VERSION_MAJ&0xffff)<<16)|\
+				   (PFM_EM64T_PEBS_SMPL_VERSION_MIN & 0xffff))
+
+#endif /* __PERFMON_EM64T_PEBS_SMPL_H__ */
diff -urN linux-2.6.16-rc1.orig/include/asm-x86_64/processor.h linux-2.6.16-rc1/include/asm-x86_64/processor.h
--- linux-2.6.16-rc1.orig/include/asm-x86_64/processor.h	2006-01-18 08:48:17.000000000 -0800
+++ linux-2.6.16-rc1/include/asm-x86_64/processor.h	2006-01-18 08:50:44.000000000 -0800
@@ -258,6 +258,7 @@
 	int		ioperm;
 	unsigned long	*io_bitmap_ptr;
 	unsigned io_bitmap_max;
+	void *pfm_context;
 /* cached TLS descriptors. */
 	u64 tls_array[GDT_ENTRY_TLS_ENTRIES];
 } __attribute__((aligned(16)));
diff -urN linux-2.6.16-rc1.orig/include/asm-x86_64/system.h linux-2.6.16-rc1/include/asm-x86_64/system.h
--- linux-2.6.16-rc1.orig/include/asm-x86_64/system.h	2006-01-18 08:48:17.000000000 -0800
+++ linux-2.6.16-rc1/include/asm-x86_64/system.h	2006-01-18 08:50:44.000000000 -0800
@@ -27,6 +27,7 @@
 	,"rcx","rbx","rdx","r8","r9","r10","r11","r12","r13","r14","r15"
 
 #define switch_to(prev,next,last) \
+	pfm_ctxswout(prev);							  \
 	asm volatile(SAVE_CONTEXT						    \
 		     "movq %%rsp,%P[threadrsp](%[prev])\n\t" /* save RSP */	  \
 		     "movq %P[threadrsp](%[next]),%%rsp\n\t" /* restore RSP */	  \
diff -urN linux-2.6.16-rc1.orig/include/asm-x86_64/unistd.h linux-2.6.16-rc1/include/asm-x86_64/unistd.h
--- linux-2.6.16-rc1.orig/include/asm-x86_64/unistd.h	2006-01-18 08:48:17.000000000 -0800
+++ linux-2.6.16-rc1/include/asm-x86_64/unistd.h	2006-01-18 08:50:44.000000000 -0800
@@ -573,8 +573,32 @@
 __SYSCALL(__NR_inotify_rm_watch, sys_inotify_rm_watch)
 #define __NR_migrate_pages	256
 __SYSCALL(__NR_migrate_pages, sys_migrate_pages)
-
-#define __NR_syscall_max __NR_migrate_pages
+#define __NR_pfm_create_context	257
+__SYSCALL(__NR_pfm_create_context, sys_pfm_create_context)
+#define __NR_pfm_write_pmcs	(__NR_pfm_create_context+1)
+__SYSCALL(__NR_pfm_write_pmcs, sys_pfm_write_pmcs)
+#define __NR_pfm_write_pmds	(__NR_pfm_create_context+2)
+__SYSCALL(__NR_pfm_write_pmds, sys_pfm_write_pmds)
+#define __NR_pfm_read_pmds	(__NR_pfm_create_context+3)
+__SYSCALL(__NR_pfm_read_pmds, sys_pfm_read_pmds)
+#define __NR_pfm_load_context	(__NR_pfm_create_context+4)
+__SYSCALL(__NR_pfm_load_context, sys_pfm_load_context)
+#define __NR_pfm_start		(__NR_pfm_create_context+5)
+__SYSCALL(__NR_pfm_start, sys_pfm_start)
+#define __NR_pfm_stop		(__NR_pfm_create_context+6)
+__SYSCALL(__NR_pfm_stop, sys_pfm_stop)
+#define __NR_pfm_restart	(__NR_pfm_create_context+7)
+__SYSCALL(__NR_pfm_restart, sys_pfm_restart)
+#define __NR_pfm_create_evtsets	(__NR_pfm_create_context+8)
+__SYSCALL(__NR_pfm_create_evtsets, sys_pfm_create_evtsets)
+#define __NR_pfm_getinfo_evtsets (__NR_pfm_create_context+9)
+__SYSCALL(__NR_pfm_getinfo_evtsets, sys_pfm_getinfo_evtsets)
+#define __NR_pfm_delete_evtsets (__NR_pfm_create_context+10)
+__SYSCALL(__NR_pfm_delete_evtsets, sys_pfm_delete_evtsets)
+#define __NR_pfm_unload_context	(__NR_pfm_create_context+11)
+__SYSCALL(__NR_pfm_unload_context, sys_pfm_unload_context)
+ 
+#define __NR_syscall_max __NR_pfm_unload_context
 #ifndef __NO_STUBS
 
 /* user-visible error numbers are in the range -1 - -4095 */
