Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264820AbUEaWYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264820AbUEaWYK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 18:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264835AbUEaWYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 18:24:10 -0400
Received: from aun.it.uu.se ([130.238.12.36]:445 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S264820AbUEaWTW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 18:19:22 -0400
Date: Tue, 1 Jun 2004 00:19:06 +0200 (MEST)
Message-Id: <200405312219.i4VMJ6dS012296@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: i386
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

perfctr-2.7.3 for 2.6.7-rc1-mm1, part 2/6:

- i386 driver and arch changes

 arch/i386/Kconfig                           |    2 
 arch/i386/kernel/entry.S                    |   16 
 arch/i386/kernel/i8259.c                    |    3 
 arch/i386/kernel/process.c                  |    9 
 drivers/perfctr/x86.c                       | 1626 ++++++++++++++++++++++++++++
 drivers/perfctr/x86_tests.c                 |  275 ++++
 drivers/perfctr/x86_tests.h                 |   30 
 include/asm-i386/mach-default/irq_vectors.h |    5 
 include/asm-i386/mach-pc9800/irq_vectors.h  |    5 
 include/asm-i386/mach-visws/irq_vectors.h   |    5 
 include/asm-i386/perfctr.h                  |  200 +++
 include/asm-i386/processor.h                |    2 
 include/asm-i386/unistd.h                   |    8 
 13 files changed, 2179 insertions(+), 7 deletions(-)

diff -ruN linux-2.6.7-rc1-mm1/arch/i386/Kconfig linux-2.6.7-rc1-mm1.perfctr-2.7.3.i386/arch/i386/Kconfig
--- linux-2.6.7-rc1-mm1/arch/i386/Kconfig	2004-05-30 15:59:30.000000000 +0200
+++ linux-2.6.7-rc1-mm1.perfctr-2.7.3.i386/arch/i386/Kconfig	2004-05-31 23:45:13.692821000 +0200
@@ -852,6 +852,8 @@
 config REGPARM
 	def_bool y
 
+source "drivers/perfctr/Kconfig"
+
 endmenu
 
 
diff -ruN linux-2.6.7-rc1-mm1/arch/i386/kernel/entry.S linux-2.6.7-rc1-mm1.perfctr-2.7.3.i386/arch/i386/kernel/entry.S
--- linux-2.6.7-rc1-mm1/arch/i386/kernel/entry.S	2004-05-30 15:59:30.000000000 +0200
+++ linux-2.6.7-rc1-mm1.perfctr-2.7.3.i386/arch/i386/kernel/entry.S	2004-05-31 23:45:13.692821000 +0200
@@ -432,6 +432,16 @@
 /* The include is where all of the SMP etc. interrupts come from */
 #include "entry_arch.h"
 
+#if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_PERFCTR)
+ENTRY(perfctr_interrupt)
+	pushl $LOCAL_PERFCTR_VECTOR-256
+	SAVE_ALL
+	pushl %esp
+	call smp_perfctr_interrupt
+	addl $4, %esp
+	jmp ret_from_intr
+#endif
+
 ENTRY(divide_error)
 	pushl $0			# no error code
 	pushl $do_divide_error
@@ -912,5 +922,11 @@
 	.long sys_mq_notify
 	.long sys_mq_getsetattr
 	.long sys_ni_syscall		/* reserved for kexec */
+	.long sys_perfctr_info
+	.long sys_vperfctr_open
+	.long sys_vperfctr_control
+	.long sys_vperfctr_unlink
+	.long sys_vperfctr_iresume
+	.long sys_vperfctr_read
 
 syscall_table_size=(.-sys_call_table)
diff -ruN linux-2.6.7-rc1-mm1/arch/i386/kernel/i8259.c linux-2.6.7-rc1-mm1.perfctr-2.7.3.i386/arch/i386/kernel/i8259.c
--- linux-2.6.7-rc1-mm1/arch/i386/kernel/i8259.c	2004-05-30 15:59:30.000000000 +0200
+++ linux-2.6.7-rc1-mm1.perfctr-2.7.3.i386/arch/i386/kernel/i8259.c	2004-05-31 23:45:13.692821000 +0200
@@ -23,6 +23,7 @@
 #include <asm/apic.h>
 #include <asm/arch_hooks.h>
 #include <asm/i8259.h>
+#include <asm/perfctr.h>
 
 #include <linux/irq.h>
 
@@ -427,6 +428,8 @@
 	 */
 	intr_init_hook();
 
+	perfctr_vector_init();
+
 	/*
 	 * Set the clock to HZ Hz, we already have a valid
 	 * vector now:
diff -ruN linux-2.6.7-rc1-mm1/arch/i386/kernel/process.c linux-2.6.7-rc1-mm1.perfctr-2.7.3.i386/arch/i386/kernel/process.c
--- linux-2.6.7-rc1-mm1/arch/i386/kernel/process.c	2004-05-30 15:59:30.000000000 +0200
+++ linux-2.6.7-rc1-mm1.perfctr-2.7.3.i386/arch/i386/kernel/process.c	2004-05-31 23:45:13.692821000 +0200
@@ -32,6 +32,7 @@
 #include <linux/delay.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
+#include <linux/perfctr.h>
 #include <linux/mc146818rtc.h>
 #include <linux/module.h>
 #include <linux/kallsyms.h>
@@ -304,6 +305,7 @@
 		tss->io_bitmap_base = INVALID_IO_BITMAP_OFFSET;
 		put_cpu();
 	}
+	perfctr_exit_thread(&tsk->thread);
 }
 
 void flush_thread(void)
@@ -366,6 +368,8 @@
 	savesegment(fs,p->thread.fs);
 	savesegment(gs,p->thread.gs);
 
+	perfctr_copy_thread(&p->thread);
+
 	tsk = current;
 	if (unlikely(NULL != tsk->thread.io_bitmap_ptr)) {
 		p->thread.io_bitmap_ptr = kmalloc(IO_BITMAP_BYTES, GFP_KERNEL);
@@ -511,6 +515,8 @@
 
 	/* never put a printk in __switch_to... printk() calls wake_up*() indirectly */
 
+	perfctr_suspend_thread(prev);
+
 	__unlazy_fpu(prev_p);
 
 	/*
@@ -573,6 +579,9 @@
 			 */
 			tss->io_bitmap_base = INVALID_IO_BITMAP_OFFSET;
 	}
+
+	perfctr_resume_thread(next);
+
 	return prev_p;
 }
 
diff -ruN linux-2.6.7-rc1-mm1/drivers/perfctr/x86.c linux-2.6.7-rc1-mm1.perfctr-2.7.3.i386/drivers/perfctr/x86.c
--- linux-2.6.7-rc1-mm1/drivers/perfctr/x86.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.7-rc1-mm1.perfctr-2.7.3.i386/drivers/perfctr/x86.c	2004-05-31 23:45:13.692821000 +0200
@@ -0,0 +1,1626 @@
+/* $Id: x86.c,v 1.141 2004/05/31 18:13:42 mikpe Exp $
+ * x86/x86_64 performance-monitoring counters driver.
+ *
+ * Copyright (C) 1999-2004  Mikael Pettersson
+ */
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/interrupt.h>
+#include <linux/perfctr.h>
+
+#include <asm/msr.h>
+#undef MSR_P6_PERFCTR0
+#undef MSR_IA32_MISC_ENABLE
+#include <asm/fixmap.h>
+#include <asm/apic.h>
+struct hw_interrupt_type;
+#include <asm/hw_irq.h>
+#include <asm/timex.h>	/* cpu_khz */
+
+#include "cpumask.h"
+#include "x86_tests.h"
+
+/* Support for lazy evntsel and perfctr MSR updates. */
+struct per_cpu_cache {	/* roughly a subset of perfctr_cpu_state */
+	union {
+		unsigned int p5_cesr;
+		unsigned int id;	/* cache owner id */
+	} k1;
+	struct {
+		/* NOTE: these caches have physical indices, not virtual */
+		unsigned int evntsel[18];
+		unsigned int escr[0x3E2-0x3A0];
+		unsigned int pebs_enable;
+		unsigned int pebs_matrix_vert;
+	} control;
+} ____cacheline_aligned;
+static DEFINE_PER_CPU(struct per_cpu_cache, per_cpu_cache);
+
+/* Structure for counter snapshots, as 32-bit values. */
+struct perfctr_low_ctrs {
+	unsigned int tsc;
+	unsigned int pmc[18];
+};
+
+/* Intel P5, Cyrix 6x86MX/MII/III, Centaur WinChip C6/2/3 */
+#define MSR_P5_CESR		0x11
+#define MSR_P5_CTR0		0x12		/* .. 0x13 */
+#define P5_CESR_CPL		0x00C0
+#define P5_CESR_RESERVED	(~0x01FF)
+#define MII_CESR_RESERVED	(~0x05FF)
+#define C6_CESR_RESERVED	(~0x00FF)
+
+/* Intel P6, VIA C3 */
+#define MSR_P6_PERFCTR0		0xC1		/* .. 0xC2 */
+#define MSR_P6_EVNTSEL0		0x186		/* .. 0x187 */
+#define P6_EVNTSEL_ENABLE	0x00400000
+#define P6_EVNTSEL_INT		0x00100000
+#define P6_EVNTSEL_CPL		0x00030000
+#define P6_EVNTSEL_RESERVED	0x00280000
+#define VC3_EVNTSEL1_RESERVED	(~0x1FF)
+
+/* AMD K7 */
+#define MSR_K7_EVNTSEL0		0xC0010000	/* .. 0xC0010003 */
+#define MSR_K7_PERFCTR0		0xC0010004	/* .. 0xC0010007 */
+
+/* Intel P4, Intel Pentium M */
+#define MSR_IA32_MISC_ENABLE	0x1A0
+#define MSR_IA32_MISC_ENABLE_PERF_AVAIL (1<<7)	/* read-only status bit */
+#define MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL (1<<12) /* read-only status bit */
+
+/* Intel P4 */
+#define MSR_P4_PERFCTR0		0x300		/* .. 0x311 */
+#define MSR_P4_CCCR0		0x360		/* .. 0x371 */
+#define MSR_P4_ESCR0		0x3A0		/* .. 0x3E1, with some gaps */
+
+#define MSR_P4_PEBS_ENABLE	0x3F1
+#define P4_PE_REPLAY_TAG_BITS	0x00000607
+#define P4_PE_UOP_TAG		0x01000000
+#define P4_PE_RESERVED		0xFEFFF9F8	/* only allow ReplayTagging */
+
+#define MSR_P4_PEBS_MATRIX_VERT	0x3F2
+#define P4_PMV_REPLAY_TAG_BITS	0x00000003
+#define P4_PMV_RESERVED		0xFFFFFFFC
+
+#define P4_CCCR_OVF		0x80000000
+#define P4_CCCR_CASCADE		0x40000000
+#define P4_CCCR_OVF_PMI_T1	0x08000000
+#define P4_CCCR_OVF_PMI_T0	0x04000000
+#define P4_CCCR_FORCE_OVF	0x02000000
+#define P4_CCCR_ACTIVE_THREAD	0x00030000
+#define P4_CCCR_ENABLE		0x00001000
+#define P4_CCCR_ESCR_SELECT(X)	(((X) >> 13) & 0x7)
+#define P4_CCCR_EXTENDED_CASCADE	0x00000800
+#define P4_CCCR_RESERVED	(0x300007FF|P4_CCCR_OVF|P4_CCCR_OVF_PMI_T1)
+
+#define P4_ESCR_CPL_T1		0x00000003
+#define P4_ESCR_CPL_T0		0x0000000C
+#define P4_ESCR_TAG_ENABLE	0x00000010
+#define P4_ESCR_RESERVED	(0x80000000)
+
+#define P4_FAST_RDPMC		0x80000000
+#define P4_MASK_FAST_RDPMC	0x0000001F	/* we only need low 5 bits */
+
+/* missing from <asm-i386/cpufeature.h> */
+#define cpu_has_msr	boot_cpu_has(X86_FEATURE_MSR)
+
+#define rdmsr_low(msr,low) \
+	__asm__ __volatile__("rdmsr" : "=a"(low) : "c"(msr) : "edx")
+#define rdpmc_low(ctr,low) \
+	__asm__ __volatile__("rdpmc" : "=a"(low) : "c"(ctr) : "edx")
+
+static void clear_msr_range(unsigned int base, unsigned int n)
+{
+	unsigned int i;
+
+	for(i = 0; i < n; ++i)
+		wrmsr(base+i, 0, 0);
+}
+
+static inline void set_in_cr4_local(unsigned int mask)
+{
+	write_cr4(read_cr4() | mask);
+}
+
+static inline void clear_in_cr4_local(unsigned int mask)
+{
+	write_cr4(read_cr4() & ~mask);
+}
+
+static unsigned int new_id(void)
+{
+	static spinlock_t lock = SPIN_LOCK_UNLOCKED;
+	static unsigned int counter;
+	int id;
+
+	spin_lock(&lock);
+	id = ++counter;
+	spin_unlock(&lock);
+	return id;
+}
+
+#if PERFCTR_INTERRUPT_SUPPORT
+static void perfctr_default_ihandler(unsigned long pc)
+{
+}
+
+static perfctr_ihandler_t perfctr_ihandler = perfctr_default_ihandler;
+
+asmlinkage void smp_perfctr_interrupt(struct pt_regs *regs)
+{
+	/* PREEMPT note: invoked via an interrupt gate, which
+	   masks interrupts. We're still on the originating CPU. */
+	/* XXX: recursive interrupts? delay the ACK, mask LVTPC, or queue? */
+	ack_APIC_irq();
+	irq_enter();
+	(*perfctr_ihandler)(instruction_pointer(regs));
+	irq_exit();
+}
+
+void perfctr_cpu_set_ihandler(perfctr_ihandler_t ihandler)
+{
+	perfctr_ihandler = ihandler ? ihandler : perfctr_default_ihandler;
+}
+
+#else
+#define perfctr_cstatus_has_ictrs(cstatus)	0
+#undef cpu_has_apic
+#define cpu_has_apic				0
+#undef apic_write
+#define apic_write(reg,vector)			do{}while(0)
+#endif
+
+#if defined(CONFIG_SMP) && PERFCTR_INTERRUPT_SUPPORT
+
+static inline void
+set_isuspend_cpu(struct perfctr_cpu_state *state, int cpu)
+{
+	state->k1.isuspend_cpu = cpu;
+}
+
+static inline int
+is_isuspend_cpu(const struct perfctr_cpu_state *state, int cpu)
+{
+	return state->k1.isuspend_cpu == cpu;
+}
+
+static inline void clear_isuspend_cpu(struct perfctr_cpu_state *state)
+{
+	state->k1.isuspend_cpu = NR_CPUS;
+}
+
+#else
+static inline void set_isuspend_cpu(struct perfctr_cpu_state *state, int cpu) { }
+static inline int is_isuspend_cpu(const struct perfctr_cpu_state *state, int cpu) { return 1; }
+static inline void clear_isuspend_cpu(struct perfctr_cpu_state *state) { }
+#endif
+
+/****************************************************************
+ *								*
+ * Driver procedures.						*
+ *								*
+ ****************************************************************/
+
+/*
+ * Intel P5 family (Pentium, family code 5).
+ * - One TSC and two 40-bit PMCs.
+ * - A single 32-bit CESR (MSR 0x11) controls both PMCs.
+ *   CESR has two halves, each controlling one PMC.
+ *   To keep the API reasonably clean, the user puts 16 bits of
+ *   control data in each counter's evntsel; the driver combines
+ *   these to a single 32-bit CESR value.
+ * - Overflow interrupts are not available.
+ * - Pentium MMX added the RDPMC instruction. RDPMC has lower
+ *   overhead than RDMSR and it can be used in user-mode code.
+ * - The MMX events are not symmetric: some events are only available
+ *   for some PMC, and some event codes denote different events
+ *   depending on which PMCs they control.
+ */
+
+/* shared with MII and C6 */
+static int p5_like_check_control(struct perfctr_cpu_state *state,
+				 unsigned int reserved_bits, int is_c6)
+{
+	unsigned short cesr_half[2];
+	unsigned int pmc, evntsel, i;
+
+	if (state->control.nrictrs != 0 || state->control.nractrs > 2)
+		return -EINVAL;
+	cesr_half[0] = 0;
+	cesr_half[1] = 0;
+	for(i = 0; i < state->control.nractrs; ++i) {
+		pmc = state->control.pmc_map[i];
+		state->pmc[i].map = pmc;
+		if (pmc > 1 || cesr_half[pmc] != 0)
+			return -EINVAL;
+		evntsel = state->control.evntsel[i];
+		/* protect reserved bits */
+		if ((evntsel & reserved_bits) != 0)
+			return -EPERM;
+		/* the CPL field (if defined) must be non-zero */
+		if (!is_c6 && !(evntsel & P5_CESR_CPL))
+			return -EINVAL;
+		cesr_half[pmc] = evntsel;
+	}
+	state->k1.id = (cesr_half[1] << 16) | cesr_half[0];
+	return 0;
+}
+
+static int p5_check_control(struct perfctr_cpu_state *state, int is_global)
+{
+	return p5_like_check_control(state, P5_CESR_RESERVED, 0);
+}
+
+/* shared with MII but not C6 */
+static void p5_write_control(const struct perfctr_cpu_state *state)
+{
+	struct per_cpu_cache *cache;
+	unsigned int cesr;
+
+	cesr = state->k1.id;
+	if (!cesr)	/* no PMC is on (this test doesn't work on C6) */
+		return;
+	cache = &__get_cpu_var(per_cpu_cache);
+	if (cache->k1.p5_cesr != cesr) {
+		cache->k1.p5_cesr = cesr;
+		wrmsr(MSR_P5_CESR, cesr, 0);
+	}
+}
+
+static void p5_read_counters(const struct perfctr_cpu_state *state,
+			     struct perfctr_low_ctrs *ctrs)
+{
+	unsigned int cstatus, nrctrs, i;
+
+	/* The P5 doesn't allocate a cache line on a write miss, so do
+	   a dummy read to avoid a write miss here _and_ a read miss
+	   later in our caller. */
+	asm("" : : "r"(ctrs->tsc));
+
+	cstatus = state->cstatus;
+	if (perfctr_cstatus_has_tsc(cstatus))
+		rdtscl(ctrs->tsc);
+	nrctrs = perfctr_cstatus_nractrs(cstatus);
+	for(i = 0; i < nrctrs; ++i) {
+		unsigned int pmc = state->pmc[i].map;
+		rdmsr_low(MSR_P5_CTR0+pmc, ctrs->pmc[i]);
+	}
+}
+
+/* used by all except pre-MMX P5 */
+static void rdpmc_read_counters(const struct perfctr_cpu_state *state,
+				struct perfctr_low_ctrs *ctrs)
+{
+	unsigned int cstatus, nrctrs, i;
+
+	cstatus = state->cstatus;
+	if (perfctr_cstatus_has_tsc(cstatus))
+		rdtscl(ctrs->tsc);
+	nrctrs = perfctr_cstatus_nractrs(cstatus);
+	for(i = 0; i < nrctrs; ++i) {
+		unsigned int pmc = state->pmc[i].map;
+		rdpmc_low(pmc, ctrs->pmc[i]);
+	}
+}
+
+/* shared with MII and C6 */
+static void p5_clear_counters(void)
+{
+	clear_msr_range(MSR_P5_CESR, 1+2);
+}
+
+/*
+ * Cyrix 6x86/MII/III.
+ * - Same MSR assignments as P5 MMX. Has RDPMC and two 48-bit PMCs.
+ * - Event codes and CESR formatting as in the plain P5 subset.
+ * - Many but not all P5 MMX event codes are implemented.
+ * - Cyrix adds a few more event codes. The event code is widened
+ *   to 7 bits, and Cyrix puts the high bit in CESR bit 10
+ *   (and CESR bit 26 for PMC1).
+ */
+
+static int mii_check_control(struct perfctr_cpu_state *state, int is_global)
+{
+	return p5_like_check_control(state, MII_CESR_RESERVED, 0);
+}
+
+/*
+ * Centaur WinChip C6/2/3.
+ * - Same MSR assignments as P5 MMX. Has RDPMC and two 40-bit PMCs.
+ * - CESR is formatted with two halves, like P5. However, there
+ *   are no defined control fields for e.g. CPL selection, and
+ *   there is no defined method for stopping the counters.
+ * - Only a few event codes are defined.
+ * - The 64-bit TSC is synthesised from the low 32 bits of the
+ *   two PMCs, and CESR has to be set up appropriately.
+ *   Reprogramming CESR causes RDTSC to yield invalid results.
+ *   (The C6 may also hang in this case, due to C6 erratum I-13.)
+ *   Therefore, using the PMCs on any of these processors requires
+ *   that the TSC is not accessed at all:
+ *   1. The kernel must be configured or a TSC-less processor, i.e.
+ *      generic 586 or less.
+ *   2. The "notsc" boot parameter must be passed to the kernel.
+ *   3. User-space libraries and code must also be configured and
+ *      compiled for a generic 586 or less.
+ */
+
+#if !defined(CONFIG_X86_TSC)
+static int c6_check_control(struct perfctr_cpu_state *state, int is_global)
+{
+	if (state->control.tsc_on)
+		return -EINVAL;
+	return p5_like_check_control(state, C6_CESR_RESERVED, 1);
+}
+
+static void c6_write_control(const struct perfctr_cpu_state *state)
+{
+	struct per_cpu_cache *cache;
+	unsigned int cesr;
+
+	if (perfctr_cstatus_nractrs(state->cstatus) == 0) /* no PMC is on */
+		return;
+	cache = &__get_cpu_var(per_cpu_cache);
+	cesr = state->k1.id;
+	if (cache->k1.p5_cesr != cesr) {
+		cache->k1.p5_cesr = cesr;
+		wrmsr(MSR_P5_CESR, cesr, 0);
+	}
+}
+#endif
+
+/*
+ * Intel P6 family (Pentium Pro, Pentium II, and Pentium III cores,
+ * and Xeon and Celeron versions of Pentium II and III cores).
+ * - One TSC and two 40-bit PMCs.
+ * - One 32-bit EVNTSEL MSR for each PMC.
+ * - EVNTSEL0 contains a global enable/disable bit.
+ *   That bit is reserved in EVNTSEL1.
+ * - Each EVNTSEL contains a CPL field.
+ * - Overflow interrupts are possible, but requires that the
+ *   local APIC is available. Some Mobile P6s have no local APIC.
+ * - The PMCs cannot be initialised with arbitrary values, since
+ *   wrmsr fills the high bits by sign-extending from bit 31.
+ * - Most events are symmetric, but a few are not.
+ */
+
+/* shared with K7 */
+static int p6_like_check_control(struct perfctr_cpu_state *state, int is_k7)
+{
+	unsigned int evntsel, i, nractrs, nrctrs, pmc_mask, pmc;
+
+	nractrs = state->control.nractrs;
+	nrctrs = nractrs + state->control.nrictrs;
+	if (nrctrs < nractrs || nrctrs > (is_k7 ? 4 : 2))
+		return -EINVAL;
+
+	pmc_mask = 0;
+	for(i = 0; i < nrctrs; ++i) {
+		pmc = state->control.pmc_map[i];
+		state->pmc[i].map = pmc;
+		if (pmc >= (is_k7 ? 4 : 2) || (pmc_mask & (1<<pmc)))
+			return -EINVAL;
+		pmc_mask |= (1<<pmc);
+		evntsel = state->control.evntsel[i];
+		/* protect reserved bits */
+		if (evntsel & P6_EVNTSEL_RESERVED)
+			return -EPERM;
+		/* check ENable bit */
+		if (is_k7) {
+			/* ENable bit must be set in each evntsel */
+			if (!(evntsel & P6_EVNTSEL_ENABLE))
+				return -EINVAL;
+		} else {
+			/* only evntsel[0] has the ENable bit */
+			if (evntsel & P6_EVNTSEL_ENABLE) {
+				if (pmc > 0)
+					return -EPERM;
+			} else {
+				if (pmc == 0)
+					return -EINVAL;
+			}
+		}
+		/* the CPL field must be non-zero */
+		if (!(evntsel & P6_EVNTSEL_CPL))
+			return -EINVAL;
+		/* INT bit must be off for a-mode and on for i-mode counters */
+		if (evntsel & P6_EVNTSEL_INT) {
+			if (i < nractrs)
+				return -EINVAL;
+		} else {
+			if (i >= nractrs)
+				return -EINVAL;
+		}
+	}
+	state->k1.id = new_id();
+	return 0;
+}
+
+static int p6_check_control(struct perfctr_cpu_state *state, int is_global)
+{
+	return p6_like_check_control(state, 0);
+}
+
+#if PERFCTR_INTERRUPT_SUPPORT
+/* PRE: perfctr_cstatus_has_ictrs(state->cstatus) != 0 */
+/* shared with K7 and P4 */
+static void p6_like_isuspend(struct perfctr_cpu_state *state,
+			     unsigned int msr_evntsel0)
+{
+	struct per_cpu_cache *cache;
+	unsigned int cstatus, nrctrs, i;
+	int cpu;
+
+	cpu = smp_processor_id();
+	set_isuspend_cpu(state, cpu); /* early to limit cpu's live range */
+	cache = &per_cpu(per_cpu_cache, cpu);
+	cstatus = state->cstatus;
+	nrctrs = perfctr_cstatus_nrctrs(cstatus);
+	for(i = perfctr_cstatus_nractrs(cstatus); i < nrctrs; ++i) {
+		unsigned int pmc_raw, pmc_idx, now;
+		pmc_raw = state->pmc[i].map;
+		/* Note: P4_MASK_FAST_RDPMC is a no-op for P6 and K7.
+		   We don't need to make it into a parameter. */
+		pmc_idx = pmc_raw & P4_MASK_FAST_RDPMC;
+		cache->control.evntsel[pmc_idx] = 0;
+		/* On P4 this intensionally also clears the CCCR.OVF flag. */
+		wrmsr(msr_evntsel0+pmc_idx, 0, 0);
+		/* P4 erratum N17 does not apply since we read only low 32 bits. */
+		rdpmc_low(pmc_raw, now);
+		state->pmc[i].sum += now - state->pmc[i].start;
+		state->pmc[i].start = now;
+	}
+	/* cache->k1.id is still == state->k1.id */
+}
+
+/* PRE: perfctr_cstatus_has_ictrs(state->cstatus) != 0 */
+/* shared with K7 and P4 */
+static void p6_like_iresume(const struct perfctr_cpu_state *state,
+			    unsigned int msr_evntsel0,
+			    unsigned int msr_perfctr0)
+{
+	struct per_cpu_cache *cache;
+	unsigned int cstatus, nrctrs, i;
+	int cpu;
+
+	cpu = smp_processor_id();
+	cache = &per_cpu(per_cpu_cache, cpu);
+	if (cache->k1.id == state->k1.id) {
+		cache->k1.id = 0; /* force reload of cleared EVNTSELs */
+		if (is_isuspend_cpu(state, cpu))
+			return; /* skip reload of PERFCTRs */
+	}
+	cstatus = state->cstatus;
+	nrctrs = perfctr_cstatus_nrctrs(cstatus);
+	for(i = perfctr_cstatus_nractrs(cstatus); i < nrctrs; ++i) {
+		/* Note: P4_MASK_FAST_RDPMC is a no-op for P6 and K7.
+		   We don't need to make it into a parameter. */
+		unsigned int pmc = state->pmc[i].map & P4_MASK_FAST_RDPMC;
+		/* If the control wasn't ours we must disable the evntsels
+		   before reinitialising the counters, to prevent unexpected
+		   counter increments and missed overflow interrupts. */
+		if (cache->control.evntsel[pmc]) {
+			cache->control.evntsel[pmc] = 0;
+			wrmsr(msr_evntsel0+pmc, 0, 0);
+		}
+		/* P4 erratum N15 does not apply since the CCCR is disabled. */
+		wrmsr(msr_perfctr0+pmc, state->pmc[i].start, -1);
+	}
+	/* cache->k1.id remains != state->k1.id */
+}
+
+static void p6_isuspend(struct perfctr_cpu_state *state)
+{
+	p6_like_isuspend(state, MSR_P6_EVNTSEL0);
+}
+
+static void p6_iresume(const struct perfctr_cpu_state *state)
+{
+	p6_like_iresume(state, MSR_P6_EVNTSEL0, MSR_P6_PERFCTR0);
+}
+#endif	/* PERFCTR_INTERRUPT_SUPPORT */
+
+/* shared with K7 and VC3 */
+static void p6_like_write_control(const struct perfctr_cpu_state *state,
+				  unsigned int msr_evntsel0)
+{
+	struct per_cpu_cache *cache;
+	unsigned int nrctrs, i;
+
+	cache = &__get_cpu_var(per_cpu_cache);
+	if (cache->k1.id == state->k1.id)
+		return;
+	nrctrs = perfctr_cstatus_nrctrs(state->cstatus);
+	for(i = 0; i < nrctrs; ++i) {
+		unsigned int evntsel = state->control.evntsel[i];
+		unsigned int pmc = state->pmc[i].map;
+		if (evntsel != cache->control.evntsel[pmc]) {
+			cache->control.evntsel[pmc] = evntsel;
+			wrmsr(msr_evntsel0+pmc, evntsel, 0);
+		}
+	}
+	cache->k1.id = state->k1.id;
+}
+
+/* shared with VC3, Generic*/
+static void p6_write_control(const struct perfctr_cpu_state *state)
+{
+	p6_like_write_control(state, MSR_P6_EVNTSEL0);
+}
+
+static void p6_clear_counters(void)
+{
+	clear_msr_range(MSR_P6_EVNTSEL0, 2);
+	clear_msr_range(MSR_P6_PERFCTR0, 2);
+}
+
+/*
+ * AMD K7 family (Athlon, Duron).
+ * - Somewhat similar to the Intel P6 family.
+ * - Four 48-bit PMCs.
+ * - Four 32-bit EVNTSEL MSRs with similar layout as in P6.
+ * - Completely different MSR assignments :-(
+ * - Fewer countable events defined :-(
+ * - The events appear to be completely symmetric.
+ * - The EVNTSEL MSRs are symmetric since each has its own enable bit.
+ * - Publicly available documentation is incomplete.
+ * - K7 model 1 does not have a local APIC. AMD Document #22007
+ *   Revision J hints that it may use debug interrupts instead.
+ *
+ * The K8 has the same hardware layout as the K7. It also has
+ * better documentation and a different set of available events.
+ */
+
+static int k7_check_control(struct perfctr_cpu_state *state, int is_global)
+{
+	return p6_like_check_control(state, 1);
+}
+
+#if PERFCTR_INTERRUPT_SUPPORT
+static void k7_isuspend(struct perfctr_cpu_state *state)
+{
+	p6_like_isuspend(state, MSR_K7_EVNTSEL0);
+}
+
+static void k7_iresume(const struct perfctr_cpu_state *state)
+{
+	p6_like_iresume(state, MSR_K7_EVNTSEL0, MSR_K7_PERFCTR0);
+}
+#endif	/* PERFCTR_INTERRUPT_SUPPORT */
+
+static void k7_write_control(const struct perfctr_cpu_state *state)
+{
+	p6_like_write_control(state, MSR_K7_EVNTSEL0);
+}
+
+static void k7_clear_counters(void)
+{
+	clear_msr_range(MSR_K7_EVNTSEL0, 4+4);
+}
+
+/*
+ * VIA C3 family.
+ * - A Centaur design somewhat similar to the P6/Celeron.
+ * - PERFCTR0 is an alias for the TSC, and EVNTSEL0 is read-only.
+ * - PERFCTR1 is 32 bits wide.
+ * - EVNTSEL1 has no defined control fields, and there is no
+ *   defined method for stopping the counter.
+ * - According to testing, the reserved fields in EVNTSEL1 have
+ *   no function. We always fill them with zeroes.
+ * - Only a few event codes are defined.
+ * - No local APIC or interrupt-mode support.
+ * - pmc_map[0] must be 1, if nractrs == 1.
+ */
+static int vc3_check_control(struct perfctr_cpu_state *state, int is_global)
+{
+	if (state->control.nrictrs || state->control.nractrs > 1)
+		return -EINVAL;
+	if (state->control.nractrs == 1) {
+		if (state->control.pmc_map[0] != 1)
+			return -EINVAL;
+		state->pmc[0].map = 1;
+		if (state->control.evntsel[0] & VC3_EVNTSEL1_RESERVED)
+			return -EPERM;
+		state->k1.id = state->control.evntsel[0];
+	} else
+		state->k1.id = 0;
+	return 0;
+}
+
+static void vc3_clear_counters(void)
+{
+	/* Not documented, but seems to be default after boot. */
+	wrmsr(MSR_P6_EVNTSEL0+1, 0x00070079, 0);
+}
+
+/*
+ * Intel Pentium 4.
+ * Current implementation restrictions:
+ * - No DS/PEBS support.
+ *
+ * Known quirks:
+ * - OVF_PMI+FORCE_OVF counters must have an ireset value of -1.
+ *   This allows the regular overflow check to also handle FORCE_OVF
+ *   counters. Not having this restriction would lead to MAJOR
+ *   complications in the driver's "detect overflow counters" code.
+ *   There is no loss of functionality since the ireset value doesn't
+ *   affect the counter's PMI rate for FORCE_OVF counters.
+ * - In experiments with FORCE_OVF counters, and regular OVF_PMI
+ *   counters with small ireset values between -8 and -1, it appears
+ *   that the faulting instruction is subjected to a new PMI before
+ *   it can complete, ad infinitum. This occurs even though the driver
+ *   clears the CCCR (and in testing also the ESCR) and invokes a
+ *   user-space signal handler before restoring the CCCR and resuming
+ *   the instruction.
+ */
+
+/*
+ * Table 15-4 in the IA32 Volume 3 manual contains a 18x8 entry mapping
+ * from counter/CCCR number (0-17) and ESCR SELECT value (0-7) to the
+ * actual ESCR MSR number. This mapping contains some repeated patterns,
+ * so we can compact it to a 4x8 table of MSR offsets:
+ *
+ * 1. CCCRs 16 and 17 are mapped just like CCCRs 13 and 14, respectively.
+ *    Thus, we only consider the 16 CCCRs 0-15.
+ * 2. The CCCRs are organised in pairs, and both CCCRs in a pair use the
+ *    same mapping. Thus, we only consider the 8 pairs 0-7.
+ * 3. In each pair of pairs, the second odd-numbered pair has the same domain
+ *    as the first even-numbered pair, and the range is 1+ the range of the
+ *    the first even-numbered pair. For example, CCCR(0) and (1) map ESCR
+ *    SELECT(7) to 0x3A0, and CCCR(2) and (3) map it to 0x3A1.
+ *    The only exception is that pair (7) [CCCRs 14 and 15] does not have
+ *    ESCR SELECT(3) in its domain, like pair (6) [CCCRs 12 and 13] has.
+ *    NOTE: Revisions of IA32 Volume 3 older than #245472-007 had an error
+ *    in this table: CCCRs 12, 13, and 16 had their mappings for ESCR SELECT
+ *    values 2 and 3 swapped.
+ * 4. All MSR numbers are on the form 0x3??. Instead of storing these as
+ *    16-bit numbers, the table only stores the 8-bit offsets from 0x300.
+ */
+
+static const unsigned char p4_cccr_escr_map[4][8] = {
+	/* 0x00 and 0x01 as is, 0x02 and 0x03 are +1 */
+	[0x00/4] {	[7] 0xA0,
+			[6] 0xA2,
+			[2] 0xAA,
+			[4] 0xAC,
+			[0] 0xB2,
+			[1] 0xB4,
+			[3] 0xB6,
+			[5] 0xC8, },
+	/* 0x04 and 0x05 as is, 0x06 and 0x07 are +1 */
+	[0x04/4] {	[0] 0xC0,
+			[2] 0xC2,
+			[1] 0xC4, },
+	/* 0x08 and 0x09 as is, 0x0A and 0x0B are +1 */
+	[0x08/4] {	[1] 0xA4,
+			[0] 0xA6,
+			[5] 0xA8,
+			[2] 0xAE,
+			[3] 0xB0, },
+	/* 0x0C, 0x0D, and 0x10 as is,
+	   0x0E, 0x0F, and 0x11 are +1 except [3] is not in the domain */
+	[0x0C/4] {	[4] 0xB8,
+			[5] 0xCC,
+			[6] 0xE0,
+			[0] 0xBA,
+			[2] 0xBC,
+			[3] 0xBE,
+			[1] 0xCA, },
+};
+
+static unsigned int p4_escr_addr(unsigned int pmc, unsigned int cccr_val)
+{
+	unsigned int escr_select, pair, escr_offset;
+
+	escr_select = P4_CCCR_ESCR_SELECT(cccr_val);
+	if (pmc > 0x11)
+		return 0;	/* pmc range error */
+	if (pmc > 0x0F)
+		pmc -= 3;	/* 0 <= pmc <= 0x0F */
+	pair = pmc / 2;		/* 0 <= pair <= 7 */
+	escr_offset = p4_cccr_escr_map[pair / 2][escr_select];
+	if (!escr_offset || (pair == 7 && escr_select == 3))
+		return 0;	/* ESCR SELECT range error */
+	return escr_offset + (pair & 1) + 0x300;
+};
+
+static int p4_IQ_ESCR_ok;	/* only models <= 2 can use IQ_ESCR{0,1} */
+static int p4_is_ht;		/* affects several CCCR & ESCR fields */
+static int p4_extended_cascade_ok;	/* only models >= 2 can use extended cascading */
+
+static int p4_check_control(struct perfctr_cpu_state *state, int is_global)
+{
+	unsigned int i, nractrs, nrctrs, pmc_mask;
+
+	nractrs = state->control.nractrs;
+	nrctrs = nractrs + state->control.nrictrs;
+	if (nrctrs < nractrs || nrctrs > 18)
+		return -EINVAL;
+
+	pmc_mask = 0;
+	for(i = 0; i < nrctrs; ++i) {
+		unsigned int pmc, cccr_val, escr_val, escr_addr;
+		/* check that pmc_map[] is well-defined;
+		   pmc_map[i] is what we pass to RDPMC, the PMC itself
+		   is extracted by masking off the FAST_RDPMC flag */
+		pmc = state->control.pmc_map[i] & ~P4_FAST_RDPMC;
+		state->pmc[i].map = state->control.pmc_map[i];
+		if (pmc >= 18 || (pmc_mask & (1<<pmc)))
+			return -EINVAL;
+		pmc_mask |= (1<<pmc);
+		/* check CCCR contents */
+		cccr_val = state->control.evntsel[i];
+		if (cccr_val & P4_CCCR_RESERVED)
+			return -EPERM;
+		if (cccr_val & P4_CCCR_EXTENDED_CASCADE) {
+			if (!p4_extended_cascade_ok)
+				return -EPERM;
+			if (!(pmc == 12 || pmc >= 15))
+				return -EPERM;
+		}
+		if ((cccr_val & P4_CCCR_ACTIVE_THREAD) != P4_CCCR_ACTIVE_THREAD && !p4_is_ht)
+			return -EINVAL;
+		if (!(cccr_val & (P4_CCCR_ENABLE | P4_CCCR_CASCADE | P4_CCCR_EXTENDED_CASCADE)))
+			return -EINVAL;
+		if (cccr_val & P4_CCCR_OVF_PMI_T0) {
+			if (i < nractrs)
+				return -EINVAL;
+			if ((cccr_val & P4_CCCR_FORCE_OVF) &&
+			    state->control.ireset[i] != -1)
+				return -EINVAL;
+		} else {
+			if (i >= nractrs)
+				return -EINVAL;
+		}
+		/* check ESCR contents */
+		escr_val = state->control.p4.escr[i];
+		if (escr_val & P4_ESCR_RESERVED)
+			return -EPERM;
+		if ((escr_val & P4_ESCR_CPL_T1) && (!p4_is_ht || !is_global))
+			return -EINVAL;
+		/* compute and cache ESCR address */
+		escr_addr = p4_escr_addr(pmc, cccr_val);
+		if (!escr_addr)
+			return -EINVAL;		/* ESCR SELECT range error */
+		/* IQ_ESCR0 and IQ_ESCR1 only exist in models <= 2 */
+		if ((escr_addr & ~0x001) == 0x3BA && !p4_IQ_ESCR_ok)
+			return -EINVAL;
+		/* XXX: Two counters could map to the same ESCR. Should we
+		   check that they use the same ESCR value? */
+		state->p4_escr_map[i] = escr_addr - MSR_P4_ESCR0;
+	}
+	/* check ReplayTagging control (PEBS_ENABLE and PEBS_MATRIX_VERT) */
+	if (state->control.p4.pebs_enable) {
+		if (!nrctrs)
+			return -EPERM;
+		if (state->control.p4.pebs_enable & P4_PE_RESERVED)
+			return -EPERM;
+		if (!(state->control.p4.pebs_enable & P4_PE_UOP_TAG))
+			return -EINVAL;
+		if (!(state->control.p4.pebs_enable & P4_PE_REPLAY_TAG_BITS))
+			return -EINVAL;
+		if (state->control.p4.pebs_matrix_vert & P4_PMV_RESERVED)
+			return -EPERM;
+		if (!(state->control.p4.pebs_matrix_vert & P4_PMV_REPLAY_TAG_BITS))
+			return -EINVAL;
+	} else if (state->control.p4.pebs_matrix_vert)
+		return -EPERM;
+	state->k1.id = new_id();
+	return 0;
+}
+
+#if PERFCTR_INTERRUPT_SUPPORT
+static void p4_isuspend(struct perfctr_cpu_state *state)
+{
+	return p6_like_isuspend(state, MSR_P4_CCCR0);
+}
+
+static void p4_iresume(const struct perfctr_cpu_state *state)
+{
+	return p6_like_iresume(state, MSR_P4_CCCR0, MSR_P4_PERFCTR0);
+}
+#endif	/* PERFCTR_INTERRUPT_SUPPORT */
+
+static void p4_write_control(const struct perfctr_cpu_state *state)
+{
+	struct per_cpu_cache *cache;
+	unsigned int nrctrs, i;
+
+	cache = &__get_cpu_var(per_cpu_cache);
+	if (cache->k1.id == state->k1.id)
+		return;
+	nrctrs = perfctr_cstatus_nrctrs(state->cstatus);
+	for(i = 0; i < nrctrs; ++i) {
+		unsigned int escr_val, escr_off, cccr_val, pmc;
+		escr_val = state->control.p4.escr[i];
+		escr_off = state->p4_escr_map[i];
+		if (escr_val != cache->control.escr[escr_off]) {
+			cache->control.escr[escr_off] = escr_val;
+			wrmsr(MSR_P4_ESCR0+escr_off, escr_val, 0);
+		}
+		cccr_val = state->control.evntsel[i];
+		pmc = state->pmc[i].map & P4_MASK_FAST_RDPMC;
+		if (cccr_val != cache->control.evntsel[pmc]) {
+			cache->control.evntsel[pmc] = cccr_val;
+			wrmsr(MSR_P4_CCCR0+pmc, cccr_val, 0);
+		}
+	}
+	if (state->control.p4.pebs_enable != cache->control.pebs_enable) {
+		cache->control.pebs_enable = state->control.p4.pebs_enable;
+		wrmsr(MSR_P4_PEBS_ENABLE, state->control.p4.pebs_enable, 0);
+	}
+	if (state->control.p4.pebs_matrix_vert != cache->control.pebs_matrix_vert) {
+		cache->control.pebs_matrix_vert = state->control.p4.pebs_matrix_vert;
+		wrmsr(MSR_P4_PEBS_MATRIX_VERT, state->control.p4.pebs_matrix_vert, 0);
+	}
+	cache->k1.id = state->k1.id;
+}
+
+static void p4_clear_counters(void)
+{
+	/* MSR 0x3F0 seems to have a default value of 0xFC00, but current
+	   docs doesn't fully define it, so leave it alone for now. */
+	/* clear PEBS_ENABLE and PEBS_MATRIX_VERT; they handle both PEBS
+	   and ReplayTagging, and should exist even if PEBS is disabled */
+	clear_msr_range(0x3F1, 2);
+	clear_msr_range(0x3A0, 31);
+	clear_msr_range(0x3C0, 6);
+	clear_msr_range(0x3C8, 6);
+	clear_msr_range(0x3E0, 2);
+	clear_msr_range(MSR_P4_CCCR0, 18);
+	clear_msr_range(MSR_P4_PERFCTR0, 18);
+}
+
+/*
+ * Generic driver for any x86 with a working TSC.
+ */
+
+static int generic_check_control(struct perfctr_cpu_state *state, int is_global)
+{
+	if (state->control.nractrs || state->control.nrictrs)
+		return -EINVAL;
+	return 0;
+}
+
+static void generic_clear_counters(void)
+{
+}
+
+/*
+ * Driver methods, internal and exported.
+ *
+ * Frequently called functions (write_control, read_counters,
+ * isuspend and iresume) are back-patched to invoke the correct
+ * processor-specific methods directly, thereby saving the
+ * overheads of indirect function calls.
+ *
+ * Backpatchable call sites must have been "finalised" after
+ * initialisation. The reason for this is that unsynchronised code
+ * modification doesn't work in multiprocessor systems, due to
+ * Intel P6 errata. Consequently, all backpatchable call sites
+ * must be known and local to this file.
+ *
+ * Backpatchable calls must initially be to 'noinline' stubs.
+ * Otherwise the compiler may inline the stubs, which breaks
+ * redirect_call() and finalise_backpatching().
+ */
+
+static int redirect_call_disable;
+
+static noinline void redirect_call(void *ra, void *to)
+{
+	/* XXX: make this function __init later */
+	if (redirect_call_disable)
+		printk(KERN_ERR __FILE__ ":%s: unresolved call to %p at %p\n",
+		       __FUNCTION__, to, ra);
+	/* we can only redirect `call near relative' instructions */
+	if (*((unsigned char*)ra - 5) != 0xE8) {
+		printk(KERN_WARNING __FILE__ ":%s: unable to redirect caller %p to %p\n",
+		       __FUNCTION__, ra, to);
+		return;
+	}
+	*(int*)((char*)ra - 4) = (char*)to - (char*)ra;
+}
+
+static void (*write_control)(const struct perfctr_cpu_state*);
+static noinline void perfctr_cpu_write_control(const struct perfctr_cpu_state *state)
+{
+	redirect_call(__builtin_return_address(0), write_control);
+	return write_control(state);
+}
+
+static void (*read_counters)(const struct perfctr_cpu_state*,
+			     struct perfctr_low_ctrs*);
+static noinline void perfctr_cpu_read_counters(const struct perfctr_cpu_state *state,
+					       struct perfctr_low_ctrs *ctrs)
+{
+	redirect_call(__builtin_return_address(0), read_counters);
+	return read_counters(state, ctrs);
+}
+
+#if PERFCTR_INTERRUPT_SUPPORT
+static void (*cpu_isuspend)(struct perfctr_cpu_state*);
+static noinline void perfctr_cpu_isuspend(struct perfctr_cpu_state *state)
+{
+	redirect_call(__builtin_return_address(0), cpu_isuspend);
+	return cpu_isuspend(state);
+}
+
+static void (*cpu_iresume)(const struct perfctr_cpu_state*);
+static noinline void perfctr_cpu_iresume(const struct perfctr_cpu_state *state)
+{
+	redirect_call(__builtin_return_address(0), cpu_iresume);
+	return cpu_iresume(state);
+}
+
+/* Call perfctr_cpu_ireload() just before perfctr_cpu_resume() to
+   bypass internal caching and force a reload if the I-mode PMCs. */
+void perfctr_cpu_ireload(struct perfctr_cpu_state *state)
+{
+#ifdef CONFIG_SMP
+	clear_isuspend_cpu(state);
+#else
+	__get_cpu_var(per_cpu_cache).k1.id = 0;
+#endif
+}
+
+/* PRE: the counters have been suspended and sampled by perfctr_cpu_suspend() */
+static int lvtpc_reinit_needed;
+unsigned int perfctr_cpu_identify_overflow(struct perfctr_cpu_state *state)
+{
+	unsigned int cstatus, nrctrs, pmc, pmc_mask;
+
+	cstatus = state->cstatus;
+	pmc = perfctr_cstatus_nractrs(cstatus);
+	nrctrs = perfctr_cstatus_nrctrs(cstatus);
+
+	for(pmc_mask = 0; pmc < nrctrs; ++pmc) {
+		if ((int)state->pmc[pmc].start >= 0) { /* XXX: ">" ? */
+			/* XXX: "+=" to correct for overshots */
+			state->pmc[pmc].start = state->control.ireset[pmc];
+			pmc_mask |= (1 << pmc);
+			/* On a P4 we should now clear the OVF flag in the
+			   counter's CCCR. However, p4_isuspend() already
+			   did that as a side-effect of clearing the CCCR
+			   in order to stop the i-mode counters. */
+		}
+	}
+	if (lvtpc_reinit_needed)
+		apic_write(APIC_LVTPC, LOCAL_PERFCTR_VECTOR);
+	return pmc_mask;
+}
+
+static inline int check_ireset(const struct perfctr_cpu_state *state)
+{
+	unsigned int nrctrs, i;
+
+	i = state->control.nractrs;
+	nrctrs = i + state->control.nrictrs;
+	for(; i < nrctrs; ++i)
+		if (state->control.ireset[i] >= 0)
+			return -EINVAL;
+	return 0;
+}
+
+static inline void setup_imode_start_values(struct perfctr_cpu_state *state)
+{
+	unsigned int cstatus, nrctrs, i;
+
+	cstatus = state->cstatus;
+	nrctrs = perfctr_cstatus_nrctrs(cstatus);
+	for(i = perfctr_cstatus_nractrs(cstatus); i < nrctrs; ++i)
+		state->pmc[i].start = state->control.ireset[i];
+}
+
+#else	/* PERFCTR_INTERRUPT_SUPPORT */
+static inline void perfctr_cpu_isuspend(struct perfctr_cpu_state *state) { }
+static inline void perfctr_cpu_iresume(const struct perfctr_cpu_state *state) { }
+static inline int check_ireset(const struct perfctr_cpu_state *state) { return 0; }
+static inline void setup_imode_start_values(struct perfctr_cpu_state *state) { }
+#endif	/* PERFCTR_INTERRUPT_SUPPORT */
+
+static int (*check_control)(struct perfctr_cpu_state*, int);
+int perfctr_cpu_update_control(struct perfctr_cpu_state *state, int is_global)
+{
+	int err;
+
+	clear_isuspend_cpu(state);
+	state->cstatus = 0;
+
+	/* disallow i-mode counters if we cannot catch the interrupts */
+	if (!(perfctr_info.cpu_features & PERFCTR_FEATURE_PCINT)
+	    && state->control.nrictrs)
+		return -EPERM;
+
+	err = check_control(state, is_global);
+	if (err < 0)
+		return err;
+	err = check_ireset(state);
+	if (err < 0)
+		return err;
+	state->cstatus = perfctr_mk_cstatus(state->control.tsc_on,
+					    state->control.nractrs,
+					    state->control.nrictrs);
+	setup_imode_start_values(state);
+	return 0;
+}
+
+void perfctr_cpu_suspend(struct perfctr_cpu_state *state)
+{
+	unsigned int i, cstatus, nractrs;
+	struct perfctr_low_ctrs now;
+
+	if (perfctr_cstatus_has_ictrs(state->cstatus))
+	    perfctr_cpu_isuspend(state);
+	perfctr_cpu_read_counters(state, &now);
+	cstatus = state->cstatus;
+	if (perfctr_cstatus_has_tsc(cstatus))
+		state->tsc_sum += now.tsc - state->tsc_start;
+	nractrs = perfctr_cstatus_nractrs(cstatus);
+	for(i = 0; i < nractrs; ++i)
+		state->pmc[i].sum += now.pmc[i] - state->pmc[i].start;
+	/* perfctr_cpu_disable_rdpmc(); */	/* not for x86 */
+}
+
+void perfctr_cpu_resume(struct perfctr_cpu_state *state)
+{
+	if (perfctr_cstatus_has_ictrs(state->cstatus))
+	    perfctr_cpu_iresume(state);
+	/* perfctr_cpu_enable_rdpmc(); */	/* not for x86 or global-mode */
+	perfctr_cpu_write_control(state);
+	//perfctr_cpu_read_counters(state, &state->start);
+	{
+		struct perfctr_low_ctrs now;
+		unsigned int i, cstatus, nrctrs;
+		perfctr_cpu_read_counters(state, &now);
+		cstatus = state->cstatus;
+		if (perfctr_cstatus_has_tsc(cstatus))
+			state->tsc_start = now.tsc;
+		nrctrs = perfctr_cstatus_nractrs(cstatus);
+		for(i = 0; i < nrctrs; ++i)
+			state->pmc[i].start = now.pmc[i];
+	}
+	/* XXX: if (SMP && start.tsc == now.tsc) ++now.tsc; */
+}
+
+void perfctr_cpu_sample(struct perfctr_cpu_state *state)
+{
+	unsigned int i, cstatus, nractrs;
+	struct perfctr_low_ctrs now;
+
+	perfctr_cpu_read_counters(state, &now);
+	cstatus = state->cstatus;
+	if (perfctr_cstatus_has_tsc(cstatus)) {
+		state->tsc_sum += now.tsc - state->tsc_start;
+		state->tsc_start = now.tsc;
+	}
+	nractrs = perfctr_cstatus_nractrs(cstatus);
+	for(i = 0; i < nractrs; ++i) {
+		state->pmc[i].sum += now.pmc[i] - state->pmc[i].start;
+		state->pmc[i].start = now.pmc[i];
+	}
+}
+
+static void (*clear_counters)(void);
+static void perfctr_cpu_clear_counters(void)
+{
+	return clear_counters();
+}
+
+/****************************************************************
+ *								*
+ * Processor detection and initialisation procedures.		*
+ *								*
+ ****************************************************************/
+
+static inline void clear_perfctr_cpus_forbidden_mask(void)
+{
+#if !defined(perfctr_cpus_forbidden_mask)
+	cpus_clear(perfctr_cpus_forbidden_mask);
+#endif
+}
+
+static inline void set_perfctr_cpus_forbidden_mask(cpumask_t mask)
+{
+#if !defined(perfctr_cpus_forbidden_mask)
+	perfctr_cpus_forbidden_mask = mask;
+#endif
+}
+
+/* see comment above at redirect_call() */
+static void __init finalise_backpatching(void)
+{
+	struct per_cpu_cache *cache;
+	struct perfctr_cpu_state state;
+	cpumask_t old_mask;
+
+	old_mask = perfctr_cpus_forbidden_mask;
+	clear_perfctr_cpus_forbidden_mask();
+
+	cache = &__get_cpu_var(per_cpu_cache);
+	memset(cache, 0, sizeof *cache);
+	memset(&state, 0, sizeof state);
+	state.cstatus =
+		(perfctr_info.cpu_features & PERFCTR_FEATURE_PCINT)
+		? perfctr_mk_cstatus(0, 0, 1)
+		: 0;
+	perfctr_cpu_sample(&state);
+	perfctr_cpu_resume(&state);
+	perfctr_cpu_suspend(&state);
+
+	set_perfctr_cpus_forbidden_mask(old_mask);
+
+	redirect_call_disable = 1;
+}
+
+#ifdef CONFIG_SMP
+
+cpumask_t perfctr_cpus_forbidden_mask;
+
+static void __init p4_ht_mask_setup_cpu(void *forbidden)
+{
+	unsigned int local_apic_physical_id = cpuid_ebx(1) >> 24;
+	unsigned int logical_processor_id = local_apic_physical_id & 1;
+	if (logical_processor_id != 0)
+		/* We rely on cpu_set() being atomic! */
+		cpu_set(smp_processor_id(), *(cpumask_t*)forbidden);
+}
+
+static int __init p4_ht_smp_init(void)
+{
+	cpumask_t forbidden;
+	unsigned int cpu;
+
+	cpus_clear(forbidden);
+	smp_call_function(p4_ht_mask_setup_cpu, &forbidden, 1, 1);
+	p4_ht_mask_setup_cpu(&forbidden);
+	if (cpus_empty(forbidden))
+		return 0;
+	perfctr_cpus_forbidden_mask = forbidden;
+	printk(KERN_INFO "perfctr/x86.c: hyper-threaded P4s detected:"
+	       " restricting access for CPUs");
+	for(cpu = 0; cpu < NR_CPUS; ++cpu)
+		if (cpu_isset(cpu, forbidden))
+			printk(" %u", cpu);
+	printk("\n");
+	return 0;
+}
+#else /* SMP */
+#define p4_ht_smp_init()	(0)
+#endif /* SMP */
+
+static int __init p4_ht_init(void)
+{
+	unsigned int nr_siblings;
+
+	if (!cpu_has_ht)
+		return 0;
+	nr_siblings = (cpuid_ebx(1) >> 16) & 0xFF;
+	if (nr_siblings > 2) {
+		printk(KERN_WARNING "perfctr/x86.c: hyper-threaded P4s detected:"
+		       " unsupported number of siblings: %u -- bailing out\n",
+		       nr_siblings);
+		return -ENODEV;
+	}
+	if (nr_siblings < 2)
+		return 0;
+	p4_is_ht = 1;	/* needed even in a UP kernel */
+	return p4_ht_smp_init();
+}
+
+static int __init intel_init(void)
+{
+	static char p5_name[] __initdata = "Intel P5";
+	static char p6_name[] __initdata = "Intel P6";
+	static char p4_name[] __initdata = "Intel P4";
+	unsigned int misc_enable;
+
+	if (!cpu_has_tsc)
+		return -ENODEV;
+	switch (current_cpu_data.x86) {
+	case 5:
+		if (cpu_has_mmx) {
+			read_counters = rdpmc_read_counters;
+
+			/* Avoid Pentium Erratum 74. */
+			if (current_cpu_data.x86_model == 4 &&
+			    (current_cpu_data.x86_mask == 4 ||
+			     (current_cpu_data.x86_mask == 3 &&
+			      ((cpuid_eax(1) >> 12) & 0x3) == 1)))
+				perfctr_info.cpu_features &= ~PERFCTR_FEATURE_RDPMC;
+		} else {
+			perfctr_info.cpu_features &= ~PERFCTR_FEATURE_RDPMC;
+			read_counters = p5_read_counters;
+		}
+		perfctr_set_tests_type(PTT_P5);
+		perfctr_cpu_name = p5_name;
+		write_control = p5_write_control;
+		check_control = p5_check_control;
+		clear_counters = p5_clear_counters;
+		return 0;
+	case 6:
+		if (current_cpu_data.x86_model == 9) {	/* Pentium M */
+			/* Pentium M added the MISC_ENABLE MSR from P4. */
+			rdmsr_low(MSR_IA32_MISC_ENABLE, misc_enable);
+			if (!(misc_enable & MSR_IA32_MISC_ENABLE_PERF_AVAIL))
+				break;
+			/* Erratum Y3 probably does not apply since we
+			   read only the low 32 bits. */
+		} else if (current_cpu_data.x86_model < 3) {	/* Pentium Pro */
+			/* Avoid Pentium Pro Erratum 26. */
+			if (current_cpu_data.x86_mask < 9)
+				perfctr_info.cpu_features &= ~PERFCTR_FEATURE_RDPMC;
+		}
+		perfctr_set_tests_type(PTT_P6);
+		perfctr_cpu_name = p6_name;
+		read_counters = rdpmc_read_counters;
+		write_control = p6_write_control;
+		check_control = p6_check_control;
+		clear_counters = p6_clear_counters;
+#if PERFCTR_INTERRUPT_SUPPORT
+		if (cpu_has_apic) {
+			perfctr_info.cpu_features |= PERFCTR_FEATURE_PCINT;
+			cpu_isuspend = p6_isuspend;
+			cpu_iresume = p6_iresume;
+			/* P-M apparently inherited P4's LVTPC auto-masking :-( */
+			if (current_cpu_data.x86_model == 9)
+				lvtpc_reinit_needed = 1;
+		}
+#endif
+		return 0;
+	case 15:	/* Pentium 4 */
+		rdmsr_low(MSR_IA32_MISC_ENABLE, misc_enable);
+		if (!(misc_enable & MSR_IA32_MISC_ENABLE_PERF_AVAIL))
+			break;
+		if (p4_ht_init() != 0)
+			break;
+		if (current_cpu_data.x86_model <= 2)
+			p4_IQ_ESCR_ok = 1;
+		if (current_cpu_data.x86_model >= 2)
+			p4_extended_cascade_ok = 1;
+		perfctr_set_tests_type(PTT_P4);
+		perfctr_cpu_name = p4_name;
+		read_counters = rdpmc_read_counters;
+		write_control = p4_write_control;
+		check_control = p4_check_control;
+		clear_counters = p4_clear_counters;
+#if PERFCTR_INTERRUPT_SUPPORT
+		if (cpu_has_apic) {
+			perfctr_info.cpu_features |= PERFCTR_FEATURE_PCINT;
+			cpu_isuspend = p4_isuspend;
+			cpu_iresume = p4_iresume;
+			lvtpc_reinit_needed = 1;
+		}
+#endif
+		return 0;
+	}
+	return -ENODEV;
+}
+
+static int __init amd_init(void)
+{
+	static char amd_name[] __initdata = "AMD K7/K8";
+
+	if (!cpu_has_tsc)
+		return -ENODEV;
+	switch (current_cpu_data.x86) {
+	case 6: /* K7 */
+	case 15: /* K8. Like a K7 with a different event set. */
+		break;
+	default:
+		return -ENODEV;
+	}
+	perfctr_set_tests_type(PTT_AMD);
+	perfctr_cpu_name = amd_name;
+	read_counters = rdpmc_read_counters;
+	write_control = k7_write_control;
+	check_control = k7_check_control;
+	clear_counters = k7_clear_counters;
+#if PERFCTR_INTERRUPT_SUPPORT
+	if (cpu_has_apic) {
+		perfctr_info.cpu_features |= PERFCTR_FEATURE_PCINT;
+		cpu_isuspend = k7_isuspend;
+		cpu_iresume = k7_iresume;
+	}
+#endif
+	return 0;
+}
+
+static int __init cyrix_init(void)
+{
+	static char mii_name[] __initdata = "Cyrix 6x86MX/MII/III";
+	if (!cpu_has_tsc)
+		return -ENODEV;
+	switch (current_cpu_data.x86) {
+	case 6:	/* 6x86MX, MII, or III */
+		perfctr_set_tests_type(PTT_P5);
+		perfctr_cpu_name = mii_name;
+		read_counters = rdpmc_read_counters;
+		write_control = p5_write_control;
+		check_control = mii_check_control;
+		clear_counters = p5_clear_counters;
+		return 0;
+	}
+	return -ENODEV;
+}
+
+static int __init centaur_init(void)
+{
+#if !defined(CONFIG_X86_TSC)
+	static char winchip_name[] __initdata = "WinChip C6/2/3";
+#endif
+	static char vc3_name[] __initdata = "VIA C3";
+	switch (current_cpu_data.x86) {
+#if !defined(CONFIG_X86_TSC)
+	case 5:
+		switch (current_cpu_data.x86_model) {
+		case 4: /* WinChip C6 */
+		case 8: /* WinChip 2, 2A, or 2B */
+		case 9: /* WinChip 3, a 2A with larger cache and lower voltage */
+			break;
+		default:
+			return -ENODEV;
+		}
+		perfctr_set_tests_type(PTT_WINCHIP);
+		perfctr_cpu_name = winchip_name;
+		/*
+		 * TSC must be inaccessible for perfctrs to work.
+		 */
+		if (!(read_cr4() & X86_CR4_TSD) || cpu_has_tsc)
+			return -ENODEV;
+		perfctr_info.cpu_features &= ~PERFCTR_FEATURE_RDTSC;
+		read_counters = rdpmc_read_counters;
+		write_control = c6_write_control;
+		check_control = c6_check_control;
+		clear_counters = p5_clear_counters;
+		return 0;
+#endif
+	case 6: /* VIA C3 */
+		if (!cpu_has_tsc)
+			return -ENODEV;
+		switch (current_cpu_data.x86_model) {
+		case 6:	/* Cyrix III */
+		case 7:	/* Samuel 2, Ezra (steppings >= 8) */
+		case 8:	/* Ezra-T */
+		case 9: /* Antaur/Nehemiah */
+			break;
+		default:
+			return -ENODEV;
+		}
+		perfctr_set_tests_type(PTT_VC3);
+		perfctr_cpu_name = vc3_name;
+		read_counters = rdpmc_read_counters;
+		write_control = p6_write_control;
+		check_control = vc3_check_control;
+		clear_counters = vc3_clear_counters;
+		return 0;
+	}
+	return -ENODEV;
+}
+
+static int __init generic_init(void)
+{
+	static char generic_name[] __initdata = "Generic x86 with TSC";
+	if (!cpu_has_tsc)
+		return -ENODEV;
+	perfctr_info.cpu_features &= ~PERFCTR_FEATURE_RDPMC;
+	perfctr_set_tests_type(PTT_GENERIC);
+	perfctr_cpu_name = generic_name;
+	check_control = generic_check_control;
+	write_control = p6_write_control;
+	read_counters = rdpmc_read_counters;
+	clear_counters = generic_clear_counters;
+	return 0;
+}
+
+static void perfctr_cpu_invalidate_cache(void)
+{
+	/*
+	 * per_cpu_cache[] is initialised to contain "impossible"
+	 * evntsel values guaranteed to differ from anything accepted
+	 * by perfctr_cpu_update_control().
+	 * All-bits-one works for all currently supported processors.
+	 * The memset also sets the ids to -1, which is intentional.
+	 */
+	memset(&__get_cpu_var(per_cpu_cache), ~0,
+	       sizeof(struct per_cpu_cache));
+}
+
+static void perfctr_cpu_init_one(void *ignore)
+{
+	/* PREEMPT note: when called via smp_call_function(),
+	   this is in IRQ context with preemption disabled. */
+	perfctr_cpu_clear_counters();
+	perfctr_cpu_invalidate_cache();
+	if (cpu_has_apic)
+		apic_write(APIC_LVTPC, LOCAL_PERFCTR_VECTOR);
+	if (perfctr_info.cpu_features & PERFCTR_FEATURE_RDPMC)
+		set_in_cr4_local(X86_CR4_PCE);
+}
+
+static void perfctr_cpu_exit_one(void *ignore)
+{
+	/* PREEMPT note: when called via smp_call_function(),
+	   this is in IRQ context with preemption disabled. */
+	perfctr_cpu_clear_counters();
+	perfctr_cpu_invalidate_cache();
+	if (cpu_has_apic)
+		apic_write(APIC_LVTPC, APIC_DM_NMI | APIC_LVT_MASKED);
+	if (perfctr_info.cpu_features & PERFCTR_FEATURE_RDPMC)
+		clear_in_cr4_local(X86_CR4_PCE);
+}
+
+#if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_PM)
+
+static void perfctr_pm_suspend(void)
+{
+	/* XXX: clear control registers */
+	printk("perfctr/x86: PM suspend\n");
+}
+
+static void perfctr_pm_resume(void)
+{
+	/* XXX: reload control registers */
+	printk("perfctr/x86: PM resume\n");
+}
+
+#include <linux/sysdev.h>
+
+static int perfctr_device_suspend(struct sys_device *dev, u32 state)
+{
+	perfctr_pm_suspend();
+	return 0;
+}
+
+static int perfctr_device_resume(struct sys_device *dev)
+{
+	perfctr_pm_resume();
+	return 0;
+}
+
+static struct sysdev_class perfctr_sysclass = {
+	set_kset_name("perfctr"),
+	.resume		= perfctr_device_resume,
+	.suspend	= perfctr_device_suspend,
+};
+
+static struct sys_device device_perfctr = {
+	.id	= 0,
+	.cls	= &perfctr_sysclass,
+};
+
+static void x86_pm_init(void)
+{
+	if (sysdev_class_register(&perfctr_sysclass) == 0)
+		sysdev_register(&device_perfctr);
+}
+
+static void x86_pm_exit(void)
+{
+	sysdev_unregister(&device_perfctr);
+	sysdev_class_unregister(&perfctr_sysclass);
+}
+
+#else
+
+static inline void x86_pm_init(void) { }
+static inline void x86_pm_exit(void) { }
+
+#endif	/* CONFIG_X86_LOCAL_APIC && CONFIG_PM */
+
+#if !defined(CONFIG_X86_LOCAL_APIC)
+static inline int reserve_lapic_nmi(void) { return 0; }
+static inline void release_lapic_nmi(void) { }
+#endif
+
+static void do_init_tests(void)
+{
+#ifdef CONFIG_PERFCTR_INIT_TESTS
+	if (reserve_lapic_nmi() >= 0) {
+		perfctr_x86_init_tests();
+		release_lapic_nmi();
+	}
+#endif
+}
+
+static int init_done;
+
+int __init perfctr_cpu_init(void)
+{
+	int err = -ENODEV;
+
+	preempt_disable();
+
+	/* RDPMC and RDTSC are on by default. They will be disabled
+	   by the init procedures if necessary. */
+	perfctr_info.cpu_features = PERFCTR_FEATURE_RDPMC | PERFCTR_FEATURE_RDTSC;
+
+	if (cpu_has_msr) {
+		switch (current_cpu_data.x86_vendor) {
+		case X86_VENDOR_INTEL:
+			err = intel_init();
+			break;
+		case X86_VENDOR_AMD:
+			err = amd_init();
+			break;
+		case X86_VENDOR_CYRIX:
+			err = cyrix_init();
+			break;
+		case X86_VENDOR_CENTAUR:
+			err = centaur_init();
+		}
+	}
+	if (err) {
+		err = generic_init();	/* last resort */
+		if (err)
+			goto out;
+	}
+	do_init_tests();
+	finalise_backpatching();
+
+	perfctr_info.cpu_khz = cpu_khz;
+	perfctr_info.tsc_to_cpu_mult = 1;
+	init_done = 1;
+
+ out:
+	preempt_enable();
+	return err;
+}
+
+void __exit perfctr_cpu_exit(void)
+{
+}
+
+/****************************************************************
+ *								*
+ * Hardware reservation.					*
+ *								*
+ ****************************************************************/
+
+static DECLARE_MUTEX(mutex);
+static const char *current_service = 0;
+
+const char *perfctr_cpu_reserve(const char *service)
+{
+	const char *ret;
+
+	if (!init_done)
+		return "unsupported hardware";
+	down(&mutex);
+	ret = current_service;
+	if (ret)
+		goto out_up;
+	ret = "unknown driver (oprofile?)";
+	if (reserve_lapic_nmi() < 0)
+		goto out_up;
+	current_service = service;
+	if (perfctr_info.cpu_features & PERFCTR_FEATURE_RDPMC)
+		mmu_cr4_features |= X86_CR4_PCE;
+	on_each_cpu(perfctr_cpu_init_one, NULL, 1, 1);
+	perfctr_cpu_set_ihandler(NULL);
+	x86_pm_init();
+	ret = NULL;
+ out_up:
+	up(&mutex);
+	return ret;
+}
+
+void perfctr_cpu_release(const char *service)
+{
+	down(&mutex);
+	if (service != current_service) {
+		printk(KERN_ERR "%s: attempt by %s to release while reserved by %s\n",
+		       __FUNCTION__, service, current_service);
+		goto out_up;
+	}
+	/* power down the counters */
+	if (perfctr_info.cpu_features & PERFCTR_FEATURE_RDPMC)
+		mmu_cr4_features &= ~X86_CR4_PCE;
+	on_each_cpu(perfctr_cpu_exit_one, NULL, 1, 1);
+	perfctr_cpu_set_ihandler(NULL);
+	x86_pm_exit();
+	current_service = 0;
+	release_lapic_nmi();
+ out_up:
+	up(&mutex);
+}
diff -ruN linux-2.6.7-rc1-mm1/drivers/perfctr/x86_tests.c linux-2.6.7-rc1-mm1.perfctr-2.7.3.i386/drivers/perfctr/x86_tests.c
--- linux-2.6.7-rc1-mm1/drivers/perfctr/x86_tests.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.7-rc1-mm1.perfctr-2.7.3.i386/drivers/perfctr/x86_tests.c	2004-05-31 23:45:13.692821000 +0200
@@ -0,0 +1,275 @@
+/* $Id: x86_tests.c,v 1.28 2004/05/23 23:22:44 mikpe Exp $
+ * Performance-monitoring counters driver.
+ * Optional x86/x86_64-specific init-time tests.
+ *
+ * Copyright (C) 1999-2004  Mikael Pettersson
+ */
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/fs.h>
+#include <linux/perfctr.h>
+#include <asm/msr.h>
+#undef MSR_P6_PERFCTR0
+#undef MSR_P4_IQ_CCCR0
+#undef MSR_P4_CRU_ESCR0
+#include <asm/fixmap.h>
+#include <asm/apic.h>
+#include <asm/timex.h>	/* cpu_khz */
+#include "x86_tests.h"
+
+#define MSR_P5_CESR		0x11
+#define MSR_P5_CTR0		0x12
+#define P5_CESR_VAL		(0x16 | (3<<6))
+#define MSR_P6_PERFCTR0		0xC1
+#define MSR_P6_EVNTSEL0		0x186
+#define P6_EVNTSEL0_VAL		(0xC0 | (3<<16) | (1<<22))
+#define MSR_K7_EVNTSEL0		0xC0010000
+#define MSR_K7_PERFCTR0		0xC0010004
+#define K7_EVNTSEL0_VAL		(0xC0 | (3<<16) | (1<<22))
+#define VC3_EVNTSEL1_VAL	0xC0
+#define MSR_P4_IQ_COUNTER0	0x30C
+#define MSR_P4_IQ_CCCR0		0x36C
+#define MSR_P4_CRU_ESCR0	0x3B8
+#define P4_CRU_ESCR0_VAL	((2<<25) | (1<<9) | (0x3<<2))
+#define P4_IQ_CCCR0_VAL		((0x3<<16) | (4<<13) | (1<<12))
+
+#define NITER	64
+#define X2(S)	S";"S
+#define X8(S)	X2(X2(X2(S)))
+
+#ifdef __x86_64__
+#define CR4MOV	"movq"
+#else
+#define CR4MOV	"movl"
+#endif
+
+static void __init do_rdpmc(unsigned pmc, unsigned unused2)
+{
+	unsigned i;
+	for(i = 0; i < NITER/8; ++i)
+		__asm__ __volatile__(X8("rdpmc") : : "c"(pmc) : "eax", "edx");
+}
+
+static void __init do_rdmsr(unsigned msr, unsigned unused2)
+{
+	unsigned i;
+	for(i = 0; i < NITER/8; ++i)
+		__asm__ __volatile__(X8("rdmsr") : : "c"(msr) : "eax", "edx");
+}
+
+static void __init do_wrmsr(unsigned msr, unsigned data)
+{
+	unsigned i;
+	for(i = 0; i < NITER/8; ++i)
+		__asm__ __volatile__(X8("wrmsr") : : "c"(msr), "a"(data), "d"(0));
+}
+
+static void __init do_rdcr4(unsigned unused1, unsigned unused2)
+{
+	unsigned i;
+	unsigned long dummy;
+	for(i = 0; i < NITER/8; ++i)
+		__asm__ __volatile__(X8(CR4MOV" %%cr4,%0") : "=r"(dummy));
+}
+
+static void __init do_wrcr4(unsigned cr4, unsigned unused2)
+{
+	unsigned i;
+	for(i = 0; i < NITER/8; ++i)
+		__asm__ __volatile__(X8(CR4MOV" %0,%%cr4") : : "r"((long)cr4));
+}
+
+static void __init do_rdtsc(unsigned unused1, unsigned unused2)
+{
+	unsigned i;
+	for(i = 0; i < NITER/8; ++i)
+		__asm__ __volatile__(X8("rdtsc") : : : "eax", "edx");
+}
+
+static void __init do_wrlvtpc(unsigned val, unsigned unused2)
+{
+	unsigned i;
+	for(i = 0; i < NITER/8; ++i) {
+		apic_write(APIC_LVTPC, val);
+		apic_write(APIC_LVTPC, val);
+		apic_write(APIC_LVTPC, val);
+		apic_write(APIC_LVTPC, val);
+		apic_write(APIC_LVTPC, val);
+		apic_write(APIC_LVTPC, val);
+		apic_write(APIC_LVTPC, val);
+		apic_write(APIC_LVTPC, val);
+	}
+}
+
+static void __init do_empty_loop(unsigned unused1, unsigned unused2)
+{
+	unsigned i;
+	for(i = 0; i < NITER/8; ++i)
+		__asm__ __volatile__("" : : "c"(0));
+}
+
+static unsigned __init run(void (*doit)(unsigned, unsigned),
+			   unsigned arg1, unsigned arg2)
+{
+	unsigned start, dummy, stop;
+	rdtsc(start, dummy);
+	(*doit)(arg1, arg2);	/* should take < 2^32 cycles to complete */
+	rdtsc(stop, dummy);
+	return stop - start;
+}
+
+static void __init init_tests_message(void)
+{
+	printk(KERN_INFO "Please email the following PERFCTR INIT lines "
+	       "to mikpe@csd.uu.se\n"
+	       KERN_INFO "To remove this message, rebuild the driver "
+	       "with CONFIG_PERFCTR_INIT_TESTS=n\n");
+	printk(KERN_INFO "PERFCTR INIT: vendor %u, family %u, model %u, stepping %u, clock %u kHz\n",
+	       current_cpu_data.x86_vendor,
+	       current_cpu_data.x86,
+	       current_cpu_data.x86_model,
+	       current_cpu_data.x86_mask,
+	       (unsigned int)cpu_khz);
+}
+
+static void __init
+measure_overheads(unsigned msr_evntsel0, unsigned evntsel0, unsigned msr_perfctr0,
+		  unsigned msr_cccr, unsigned cccr_val)
+{
+	int i;
+	unsigned int loop, ticks[12];
+	const char *name[12];
+
+	if (msr_evntsel0)
+		wrmsr(msr_evntsel0, 0, 0);
+	if (msr_cccr)
+		wrmsr(msr_cccr, 0, 0);
+
+	name[0] = "rdtsc";
+	ticks[0] = run(do_rdtsc, 0, 0);
+	name[1] = "rdpmc";
+	ticks[1] = (perfctr_info.cpu_features & PERFCTR_FEATURE_RDPMC)
+		? run(do_rdpmc,1,0) : 0;
+	name[2] = "rdmsr (counter)";
+	ticks[2] = msr_perfctr0 ? run(do_rdmsr, msr_perfctr0, 0) : 0;
+	name[3] = msr_cccr ? "rdmsr (escr)" : "rdmsr (evntsel)";
+	ticks[3] = msr_evntsel0 ? run(do_rdmsr, msr_evntsel0, 0) : 0;
+	name[4] = "wrmsr (counter)";
+	ticks[4] = msr_perfctr0 ? run(do_wrmsr, msr_perfctr0, 0) : 0;
+	name[5] = msr_cccr ? "wrmsr (escr)" : "wrmsr (evntsel)";
+	ticks[5] = msr_evntsel0 ? run(do_wrmsr, msr_evntsel0, evntsel0) : 0;
+	name[6] = "read cr4";
+	ticks[6] = run(do_rdcr4, 0, 0);
+	name[7] = "write cr4";
+	ticks[7] = run(do_wrcr4, read_cr4(), 0);
+	name[8] = "rdpmc (fast)";
+	ticks[8] = msr_cccr ? run(do_rdpmc, 0x80000001, 0) : 0;
+	name[9] = "rdmsr (cccr)";
+	ticks[9] = msr_cccr ? run(do_rdmsr, msr_cccr, 0) : 0;
+	name[10] = "wrmsr (cccr)";
+	ticks[10] = msr_cccr ? run(do_wrmsr, msr_cccr, cccr_val) : 0;
+	name[11] = "write LVTPC";
+	ticks[11] = (perfctr_info.cpu_features & PERFCTR_FEATURE_PCINT)
+		? run(do_wrlvtpc, APIC_DM_NMI|APIC_LVT_MASKED, 0) : 0;
+
+	loop = run(do_empty_loop, 0, 0);
+
+	if (msr_evntsel0)
+		wrmsr(msr_evntsel0, 0, 0);
+	if (msr_cccr)
+		wrmsr(msr_cccr, 0, 0);
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
+}
+
+#ifndef __x86_64__
+static inline void perfctr_p5_init_tests(void)
+{
+	measure_overheads(MSR_P5_CESR, P5_CESR_VAL, MSR_P5_CTR0, 0, 0);
+}
+
+static inline void perfctr_p6_init_tests(void)
+{
+	measure_overheads(MSR_P6_EVNTSEL0, P6_EVNTSEL0_VAL, MSR_P6_PERFCTR0, 0, 0);
+}
+
+#if !defined(CONFIG_X86_TSC)
+static inline void perfctr_c6_init_tests(void)
+{
+	unsigned int cesr, dummy;
+
+	rdmsr(MSR_P5_CESR, cesr, dummy);
+	init_tests_message();
+	printk(KERN_INFO "PERFCTR INIT: boot CESR == %#08x\n", cesr);
+}
+#endif
+
+static inline void perfctr_vc3_init_tests(void)
+{
+	measure_overheads(MSR_P6_EVNTSEL0+1, VC3_EVNTSEL1_VAL, MSR_P6_PERFCTR0+1, 0, 0);
+}
+
+static inline void perfctr_p4_init_tests(void)
+{
+	measure_overheads(MSR_P4_CRU_ESCR0, P4_CRU_ESCR0_VAL, MSR_P4_IQ_COUNTER0,
+			  MSR_P4_IQ_CCCR0, P4_IQ_CCCR0_VAL);
+}
+#endif /* !__x86_64__ */
+
+static inline void perfctr_k7_init_tests(void)
+{
+	measure_overheads(MSR_K7_EVNTSEL0, K7_EVNTSEL0_VAL, MSR_K7_PERFCTR0, 0, 0);
+}
+
+static inline void perfctr_generic_init_tests(void)
+{
+	measure_overheads(0, 0, 0, 0, 0);
+}
+
+enum perfctr_x86_tests_type perfctr_x86_tests_type __initdata = PTT_UNKNOWN;
+
+void __init perfctr_x86_init_tests(void)
+{
+	switch (perfctr_x86_tests_type) {
+#ifndef __x86_64__
+	case PTT_P5: /* Intel P5, P5MMX; Cyrix 6x86MX, MII, III */
+		perfctr_p5_init_tests();
+		break;
+	case PTT_P6: /* Intel PPro, PII, PIII, PENTM */
+		perfctr_p6_init_tests();
+		break;
+#if !defined(CONFIG_X86_TSC)
+	case PTT_WINCHIP: /* WinChip C6, 2, 3 */
+		perfctr_c6_init_tests();
+		break;
+#endif
+	case PTT_VC3: /* VIA C3 */
+		perfctr_vc3_init_tests();
+		break;
+	case PTT_P4: /* Intel P4 */
+		perfctr_p4_init_tests();
+		break;
+#endif /* !__x86_64__ */
+	case PTT_AMD: /* AMD K7, K8 */
+		perfctr_k7_init_tests();
+		break;
+	case PTT_GENERIC:
+		perfctr_generic_init_tests();
+		break;
+	default:
+		printk(KERN_INFO "%s: unknown CPU type %u\n",
+		       __FUNCTION__, perfctr_x86_tests_type);
+		break;
+	}
+}
diff -ruN linux-2.6.7-rc1-mm1/drivers/perfctr/x86_tests.h linux-2.6.7-rc1-mm1.perfctr-2.7.3.i386/drivers/perfctr/x86_tests.h
--- linux-2.6.7-rc1-mm1/drivers/perfctr/x86_tests.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.7-rc1-mm1.perfctr-2.7.3.i386/drivers/perfctr/x86_tests.h	2004-05-31 23:45:13.692821000 +0200
@@ -0,0 +1,30 @@
+/* $Id: x86_tests.h,v 1.10 2004/05/22 20:48:57 mikpe Exp $
+ * Performance-monitoring counters driver.
+ * Optional x86/x86_64-specific init-time tests.
+ *
+ * Copyright (C) 1999-2004  Mikael Pettersson
+ */
+
+/* 'enum perfctr_x86_tests_type' classifies CPUs according
+   to relevance for perfctr_x86_init_tests(). */
+enum perfctr_x86_tests_type {
+	PTT_UNKNOWN,
+	PTT_GENERIC,
+	PTT_P5,
+	PTT_P6,
+	PTT_P4,
+	PTT_AMD,
+	PTT_WINCHIP,
+	PTT_VC3,
+};
+
+extern enum perfctr_x86_tests_type perfctr_x86_tests_type;
+
+static inline void perfctr_set_tests_type(enum perfctr_x86_tests_type t)
+{
+#ifdef CONFIG_PERFCTR_INIT_TESTS
+	perfctr_x86_tests_type = t;
+#endif
+}
+
+extern void perfctr_x86_init_tests(void);
diff -ruN linux-2.6.7-rc1-mm1/include/asm-i386/mach-default/irq_vectors.h linux-2.6.7-rc1-mm1.perfctr-2.7.3.i386/include/asm-i386/mach-default/irq_vectors.h
--- linux-2.6.7-rc1-mm1/include/asm-i386/mach-default/irq_vectors.h	2004-05-10 11:14:37.000000000 +0200
+++ linux-2.6.7-rc1-mm1.perfctr-2.7.3.i386/include/asm-i386/mach-default/irq_vectors.h	2004-05-31 23:45:13.692821000 +0200
@@ -56,14 +56,15 @@
  * sources per level' errata.
  */
 #define LOCAL_TIMER_VECTOR	0xef
+#define LOCAL_PERFCTR_VECTOR	0xee
 
 /*
- * First APIC vector available to drivers: (vectors 0x30-0xee)
+ * First APIC vector available to drivers: (vectors 0x30-0xed)
  * we start at 0x31 to spread out vectors evenly between priority
  * levels. (0x80 is the syscall vector)
  */
 #define FIRST_DEVICE_VECTOR	0x31
-#define FIRST_SYSTEM_VECTOR	0xef
+#define FIRST_SYSTEM_VECTOR	0xee
 
 #define TIMER_IRQ 0
 
diff -ruN linux-2.6.7-rc1-mm1/include/asm-i386/mach-pc9800/irq_vectors.h linux-2.6.7-rc1-mm1.perfctr-2.7.3.i386/include/asm-i386/mach-pc9800/irq_vectors.h
--- linux-2.6.7-rc1-mm1/include/asm-i386/mach-pc9800/irq_vectors.h	2004-01-09 13:19:11.000000000 +0100
+++ linux-2.6.7-rc1-mm1.perfctr-2.7.3.i386/include/asm-i386/mach-pc9800/irq_vectors.h	2004-05-31 23:45:13.692821000 +0200
@@ -59,14 +59,15 @@
  * sources per level' errata.
  */
 #define LOCAL_TIMER_VECTOR	0xef
+#define LOCAL_PERFCTR_VECTOR	0xee
 
 /*
- * First APIC vector available to drivers: (vectors 0x30-0xee)
+ * First APIC vector available to drivers: (vectors 0x30-0xed)
  * we start at 0x31 to spread out vectors evenly between priority
  * levels. (0x80 is the syscall vector)
  */
 #define FIRST_DEVICE_VECTOR	0x31
-#define FIRST_SYSTEM_VECTOR	0xef
+#define FIRST_SYSTEM_VECTOR	0xee
 
 #define TIMER_IRQ 0
 
diff -ruN linux-2.6.7-rc1-mm1/include/asm-i386/mach-visws/irq_vectors.h linux-2.6.7-rc1-mm1.perfctr-2.7.3.i386/include/asm-i386/mach-visws/irq_vectors.h
--- linux-2.6.7-rc1-mm1/include/asm-i386/mach-visws/irq_vectors.h	2004-01-09 13:19:11.000000000 +0100
+++ linux-2.6.7-rc1-mm1.perfctr-2.7.3.i386/include/asm-i386/mach-visws/irq_vectors.h	2004-05-31 23:45:13.692821000 +0200
@@ -35,14 +35,15 @@
  * sources per level' errata.
  */
 #define LOCAL_TIMER_VECTOR	0xef
+#define LOCAL_PERFCTR_VECTOR	0xee
 
 /*
- * First APIC vector available to drivers: (vectors 0x30-0xee)
+ * First APIC vector available to drivers: (vectors 0x30-0xed)
  * we start at 0x31 to spread out vectors evenly between priority
  * levels. (0x80 is the syscall vector)
  */
 #define FIRST_DEVICE_VECTOR	0x31
-#define FIRST_SYSTEM_VECTOR	0xef
+#define FIRST_SYSTEM_VECTOR	0xee
 
 #define TIMER_IRQ 0
 
diff -ruN linux-2.6.7-rc1-mm1/include/asm-i386/perfctr.h linux-2.6.7-rc1-mm1.perfctr-2.7.3.i386/include/asm-i386/perfctr.h
--- linux-2.6.7-rc1-mm1/include/asm-i386/perfctr.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.7-rc1-mm1.perfctr-2.7.3.i386/include/asm-i386/perfctr.h	2004-05-31 23:45:13.692821000 +0200
@@ -0,0 +1,200 @@
+/* $Id: perfctr.h,v 1.52 2004/05/23 22:36:34 mikpe Exp $
+ * x86/x86_64 Performance-Monitoring Counters driver
+ *
+ * Copyright (C) 1999-2004  Mikael Pettersson
+ */
+#ifndef _ASM_I386_PERFCTR_H
+#define _ASM_I386_PERFCTR_H
+
+/* cpu_type values */
+#define PERFCTR_X86_GENERIC	0	/* any x86 with rdtsc */
+#define PERFCTR_X86_INTEL_P5	1	/* no rdpmc */
+#define PERFCTR_X86_INTEL_P5MMX	2
+#define PERFCTR_X86_INTEL_P6	3
+#define PERFCTR_X86_INTEL_PII	4
+#define PERFCTR_X86_INTEL_PIII	5
+#define PERFCTR_X86_CYRIX_MII	6
+#define PERFCTR_X86_WINCHIP_C6	7	/* no rdtsc */
+#define PERFCTR_X86_WINCHIP_2	8	/* no rdtsc */
+#define PERFCTR_X86_AMD_K7	9
+#define PERFCTR_X86_VIA_C3	10	/* no pmc0 */
+#define PERFCTR_X86_INTEL_P4	11	/* model 0 and 1 */
+#define PERFCTR_X86_INTEL_P4M2	12	/* model 2 */
+#define PERFCTR_X86_AMD_K8	13
+#define PERFCTR_X86_INTEL_PENTM	14	/* Pentium M */
+#define PERFCTR_X86_AMD_K8C	15	/* Revision C */
+#define PERFCTR_X86_INTEL_P4M3	16	/* model 3 and above */
+
+struct perfctr_sum_ctrs {
+	unsigned long long tsc;
+	unsigned long long pmc[18];
+};
+
+struct perfctr_cpu_control {
+	unsigned int tsc_on;
+	unsigned int nractrs;		/* # of a-mode counters */
+	unsigned int nrictrs;		/* # of i-mode counters */
+	unsigned int pmc_map[18];
+	unsigned int evntsel[18];	/* one per counter, even on P5 */
+	struct {
+		unsigned int escr[18];
+		unsigned int pebs_enable;	/* for replay tagging */
+		unsigned int pebs_matrix_vert;	/* for replay tagging */
+	} p4;
+	int ireset[18];			/* < 0, for i-mode counters */
+	unsigned int _reserved1;
+	unsigned int _reserved2;
+	unsigned int _reserved3;
+	unsigned int _reserved4;
+};
+
+struct perfctr_cpu_state {
+	unsigned int cstatus;
+	struct {	/* k1 is opaque in the user ABI */
+		unsigned int id;
+		int isuspend_cpu;
+	} k1;
+	/* The two tsc fields must be inlined. Placing them in a
+	   sub-struct causes unwanted internal padding on x86-64. */
+	unsigned int tsc_start;
+	unsigned long long tsc_sum;
+	struct {
+		unsigned int map;
+		unsigned int start;
+		unsigned long long sum;
+	} pmc[18];	/* the size is not part of the user ABI */
+#ifdef __KERNEL__
+	struct perfctr_cpu_control control;
+	unsigned int p4_escr_map[18];
+#endif
+};
+
+/* cstatus is a re-encoding of control.tsc_on/nractrs/nrictrs
+   which should have less overhead in most cases */
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
+ *
+ * glibc's <signal.h> doesn't seem to define __SI_FAULT or __SI_CODE(),
+ * and including <asm/siginfo.h> as well may cause redefinition errors,
+ * so the user and kernel values are different #defines here.
+ */
+#ifdef __KERNEL__
+#define SI_PMC_OVF	(__SI_FAULT|'P')
+#else
+#define SI_PMC_OVF	('P')
+#endif
+#define si_pmc_ovf_mask	_sifields._pad[0] /* XXX: use an unsigned field later */
+
+/* version number for user-visible CPU-specific data */
+#define PERFCTR_CPU_VERSION	0x0500	/* 5.0 */
+
+#ifdef __KERNEL__
+
+#if defined(CONFIG_PERFCTR)
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
+   is_global should be zero for per-process counters and non-zero
+   for global-mode counters. This matters for HT P4s, alas.
+   Returns a negative error code if the control data is invalid. */
+extern int perfctr_cpu_update_control(struct perfctr_cpu_state *state, int is_global);
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
+#if defined(CONFIG_X86_LOCAL_APIC)
+#define PERFCTR_INTERRUPT_SUPPORT 1
+#endif
+
+#if PERFCTR_INTERRUPT_SUPPORT
+extern void perfctr_cpu_set_ihandler(perfctr_ihandler_t);
+extern void perfctr_cpu_ireload(struct perfctr_cpu_state*);
+extern unsigned int perfctr_cpu_identify_overflow(struct perfctr_cpu_state*);
+#else
+static inline void perfctr_cpu_set_ihandler(perfctr_ihandler_t x) { }
+#endif
+
+#if defined(CONFIG_SMP)
+/* CPUs in `perfctr_cpus_forbidden_mask' must not use the
+   performance-monitoring counters. TSC use is unrestricted.
+   This is needed to prevent resource conflicts on hyper-threaded P4s.
+   The declaration of `perfctr_cpus_forbidden_mask' is in the driver's
+   private compat.h, since it needs to handle cpumask_t incompatibilities. */
+#define PERFCTR_CPUS_FORBIDDEN_MASK_NEEDED 1
+#endif
+
+#endif	/* CONFIG_PERFCTR */
+
+#if defined(CONFIG_PERFCTR) && PERFCTR_INTERRUPT_SUPPORT
+asmlinkage void perfctr_interrupt(struct pt_regs*);
+#define perfctr_vector_init()	\
+	set_intr_gate(LOCAL_PERFCTR_VECTOR, perfctr_interrupt)
+#else
+#define perfctr_vector_init()	do{}while(0)
+#endif
+
+#endif	/* __KERNEL__ */
+
+#endif	/* _ASM_I386_PERFCTR_H */
diff -ruN linux-2.6.7-rc1-mm1/include/asm-i386/processor.h linux-2.6.7-rc1-mm1.perfctr-2.7.3.i386/include/asm-i386/processor.h
--- linux-2.6.7-rc1-mm1/include/asm-i386/processor.h	2004-05-30 15:59:30.000000000 +0200
+++ linux-2.6.7-rc1-mm1.perfctr-2.7.3.i386/include/asm-i386/processor.h	2004-05-31 23:45:13.692821000 +0200
@@ -422,6 +422,8 @@
 	unsigned int		saved_fs, saved_gs;
 /* IO permissions */
 	unsigned long	*io_bitmap_ptr;
+/* performance counters */
+	struct vperfctr *perfctr;
 };
 
 #define INIT_THREAD  {							\
diff -ruN linux-2.6.7-rc1-mm1/include/asm-i386/unistd.h linux-2.6.7-rc1-mm1.perfctr-2.7.3.i386/include/asm-i386/unistd.h
--- linux-2.6.7-rc1-mm1/include/asm-i386/unistd.h	2004-05-30 15:59:08.000000000 +0200
+++ linux-2.6.7-rc1-mm1.perfctr-2.7.3.i386/include/asm-i386/unistd.h	2004-05-31 23:45:13.692821000 +0200
@@ -289,8 +289,14 @@
 #define __NR_mq_notify		(__NR_mq_open+4)
 #define __NR_mq_getsetattr	(__NR_mq_open+5)
 #define __NR_sys_kexec_load	283
+#define __NR_perfctr_info	284
+#define __NR_vperfctr_open	(__NR_perfctr_info+1)
+#define __NR_vperfctr_control	(__NR_perfctr_info+2)
+#define __NR_vperfctr_unlink	(__NR_perfctr_info+3)
+#define __NR_vperfctr_iresume	(__NR_perfctr_info+4)
+#define __NR_vperfctr_read	(__NR_perfctr_info+5)
 
-#define NR_syscalls 284
+#define NR_syscalls 290
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
