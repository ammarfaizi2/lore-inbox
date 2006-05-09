Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750908AbWEIU6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbWEIU6t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 16:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWEIU5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 16:57:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13789 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750775AbWEIU5N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 16:57:13 -0400
From: dzickus <dzickus@redhat.com>
Message-Id: <20060509205957.466442000@drseuss.boston.redhat.com>
References: <20060509205035.446349000@drseuss.boston.redhat.com>
User-Agent: quilt/0.45-1
Date: Tue, 09 May 2006 16:50:40 -0400
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, oprofile-list@lists.sourceforge.net, dzickus@redhat.com
Subject: [patch 5/8] Add SMP support on i386 to reservation framework
Content-Disposition: inline; filename=nmi-x86-reservation-SMP-i386.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch includes the changes to make the nmi watchdog on i386 SMP aware.
A bunch of code was moved around to make it simpler to read.  In addition,
it is now possible to determine if a particular NMI was the result of the
watchdog or not.  This feature allows the kernel to filter out unknown NMIs
easier.

Signed-off-by:  Don Zickus <dzickus@redhat.com>

Index: linux-don/arch/i386/kernel/apic.c
===================================================================
--- linux-don.orig/arch/i386/kernel/apic.c
+++ linux-don/arch/i386/kernel/apic.c
@@ -587,8 +587,7 @@ void __devinit setup_local_APIC(void)
 			printk("No ESR for 82489DX.\n");
 	}
 
-	if (nmi_watchdog == NMI_LOCAL_APIC)
-		setup_apic_nmi_watchdog();
+	setup_apic_nmi_watchdog(NULL);
 	apic_pm_activate();
 }
 
Index: linux-don/arch/i386/kernel/nmi.c
===================================================================
--- linux-don.orig/arch/i386/kernel/nmi.c
+++ linux-don/arch/i386/kernel/nmi.c
@@ -24,16 +24,10 @@
 
 #include <asm/smp.h>
 #include <asm/nmi.h>
+#include <asm/kdebug.h>
 
 #include "mach_traps.h"
 
-unsigned int nmi_watchdog = NMI_NONE;
-extern int unknown_nmi_panic;
-static unsigned int nmi_hz = HZ;
-static unsigned int nmi_perfctr_msr;	/* the MSR to reset in NMI handler */
-static unsigned int nmi_p4_cccr_val;
-extern void show_registers(struct pt_regs *regs);
-
 /* perfctr_nmi_owner tracks the ownership of the perfctr registers:
  * evtsel_nmi_owner tracks the ownership of the event selection
  * - different performance counters/ event selection may be reserved for
@@ -63,51 +57,31 @@ static unsigned int lapic_nmi_owner;
 #define LAPIC_NMI_RESERVED	(1<<1)
 
 /* nmi_active:
- * +1: the lapic NMI watchdog is active, but can be disabled
- *  0: the lapic NMI watchdog has not been set up, and cannot
+ * >0: the lapic NMI watchdog is active, but can be disabled
+ * <0: the lapic NMI watchdog has not been set up, and cannot
  *     be enabled
- * -1: the lapic NMI watchdog is disabled, but can be enabled
+ *  0: the lapic NMI watchdog is disabled, but can be enabled
  */
-int nmi_active;
+atomic_t nmi_active = ATOMIC_INIT(0);		/* oprofile uses this */
 
-#define K7_EVNTSEL_ENABLE	(1 << 22)
-#define K7_EVNTSEL_INT		(1 << 20)
-#define K7_EVNTSEL_OS		(1 << 17)
-#define K7_EVNTSEL_USR		(1 << 16)
-#define K7_EVENT_CYCLES_PROCESSOR_IS_RUNNING	0x76
-#define K7_NMI_EVENT		K7_EVENT_CYCLES_PROCESSOR_IS_RUNNING
+unsigned int nmi_watchdog = NMI_DEFAULT;
+static unsigned int nmi_hz = HZ;
 
-#define P6_EVNTSEL0_ENABLE	(1 << 22)
-#define P6_EVNTSEL_INT		(1 << 20)
-#define P6_EVNTSEL_OS		(1 << 17)
-#define P6_EVNTSEL_USR		(1 << 16)
-#define P6_EVENT_CPU_CLOCKS_NOT_HALTED	0x79
-#define P6_NMI_EVENT		P6_EVENT_CPU_CLOCKS_NOT_HALTED
+struct nmi_watchdog_ctlblk {
+	int enabled;
+	u64 check_bit;
+	unsigned int cccr_msr;
+	unsigned int perfctr_msr;  /* the MSR to reset in NMI handler */
+	unsigned int evntsel_msr;  /* the MSR to select the events to handle */
+};
+static DEFINE_PER_CPU(struct nmi_watchdog_ctlblk, nmi_watchdog_ctlblk);
 
-#define MSR_P4_MISC_ENABLE	0x1A0
-#define MSR_P4_MISC_ENABLE_PERF_AVAIL	(1<<7)
-#define MSR_P4_MISC_ENABLE_PEBS_UNAVAIL	(1<<12)
-#define MSR_P4_PERFCTR0		0x300
-#define MSR_P4_CCCR0		0x360
-#define P4_ESCR_EVENT_SELECT(N)	((N)<<25)
-#define P4_ESCR_OS		(1<<3)
-#define P4_ESCR_USR		(1<<2)
-#define P4_CCCR_OVF_PMI0	(1<<26)
-#define P4_CCCR_OVF_PMI1	(1<<27)
-#define P4_CCCR_THRESHOLD(N)	((N)<<20)
-#define P4_CCCR_COMPLEMENT	(1<<19)
-#define P4_CCCR_COMPARE		(1<<18)
-#define P4_CCCR_REQUIRED	(3<<16)
-#define P4_CCCR_ESCR_SELECT(N)	((N)<<13)
-#define P4_CCCR_ENABLE		(1<<12)
-/* Set up IQ_COUNTER0 to behave like a clock, by having IQ_CCCR0 filter
-   CRU_ESCR0 (with any non-null event selector) through a complemented
-   max threshold. [IA32-Vol3, Section 14.9.9] */
-#define MSR_P4_IQ_COUNTER0	0x30C
-#define P4_NMI_CRU_ESCR0	(P4_ESCR_EVENT_SELECT(0x3F)|P4_ESCR_OS|P4_ESCR_USR)
-#define P4_NMI_IQ_CCCR0	\
-	(P4_CCCR_OVF_PMI0|P4_CCCR_THRESHOLD(15)|P4_CCCR_COMPLEMENT|	\
-	 P4_CCCR_COMPARE|P4_CCCR_REQUIRED|P4_CCCR_ESCR_SELECT(4)|P4_CCCR_ENABLE)
+/* local prototypes */
+static void stop_apic_nmi_watchdog(void *unused);
+static int unknown_nmi_panic_callback(struct pt_regs *regs, int cpu);
+
+extern void show_registers(struct pt_regs *regs);
+extern int unknown_nmi_panic;
 
 /* converts an msr to an appropriate reservation bit */
 static inline unsigned int nmi_perfctr_msr_to_bit(unsigned int msr)
@@ -208,6 +182,17 @@ void release_evntsel_nmi(unsigned int ms
 	clear_bit(counter, &__get_cpu_var(evntsel_nmi_owner[0]));
 }
 
+static __cpuinit inline int nmi_known_cpu(void)
+{
+	switch (boot_cpu_data.x86_vendor) {
+	case X86_VENDOR_AMD:
+		return ((boot_cpu_data.x86 == 15) || (boot_cpu_data.x86 == 6));
+	case X86_VENDOR_INTEL:
+		return ((boot_cpu_data.x86 == 15) || (boot_cpu_data.x86 == 6));
+	}
+	return 0;
+}
+
 #ifdef CONFIG_SMP
 /* The performance counters used by NMI_LOCAL_APIC don't trigger when
  * the CPU is idle. To make sure the NMI watchdog really ticks on all
@@ -234,7 +219,10 @@ static int __init check_nmi_watchdog(voi
 	unsigned int *prev_nmi_count;
 	int cpu;
 
-	if (nmi_watchdog == NMI_NONE)
+	if ((nmi_watchdog == NMI_NONE) || (nmi_watchdog == NMI_DEFAULT))
+		return 0;
+
+	if (!atomic_read(&nmi_active))
 		return 0;
 
 	prev_nmi_count = kmalloc(NR_CPUS * sizeof(int), GFP_KERNEL);
@@ -258,18 +246,22 @@ static int __init check_nmi_watchdog(voi
 		if (!cpu_isset(cpu, cpu_callin_map))
 			continue;
 #endif
+		if (!per_cpu(nmi_watchdog_ctlblk.enabled, cpu))
+			continue;
 		if (nmi_count(cpu) - prev_nmi_count[cpu] <= 5) {
-			endflag = 1;
 			printk("CPU#%d: NMI appears to be stuck (%d->%d)!\n",
 				cpu,
 				prev_nmi_count[cpu],
 				nmi_count(cpu));
-			nmi_active = 0;
-			lapic_nmi_owner &= ~LAPIC_NMI_WATCHDOG;
-			kfree(prev_nmi_count);
-			return -1;
+			per_cpu(nmi_watchdog_ctlblk.enabled, cpu) = 0;
+			atomic_dec(&nmi_active);
 		}
 	}
+	if (!atomic_read(&nmi_active)) {
+		kfree(prev_nmi_count);
+		atomic_set(&nmi_active, -1);
+		return -1;
+	}
 	endflag = 1;
 	printk("OK.\n");
 
@@ -290,31 +282,16 @@ static int __init setup_nmi_watchdog(cha
 
 	get_option(&str, &nmi);
 
-	if (nmi >= NMI_INVALID)
+	if ((nmi >= NMI_INVALID) || (nmi < NMI_NONE))
 		return 0;
-	if (nmi == NMI_NONE)
-		nmi_watchdog = nmi;
 	/*
 	 * If any other x86 CPU has a local APIC, then
 	 * please test the NMI stuff there and send me the
 	 * missing bits. Right now Intel P6/P4 and AMD K7 only.
 	 */
-	if ((nmi == NMI_LOCAL_APIC) &&
-			(boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) &&
-			(boot_cpu_data.x86 == 6 || boot_cpu_data.x86 == 15))
-		nmi_watchdog = nmi;
-	if ((nmi == NMI_LOCAL_APIC) &&
-			(boot_cpu_data.x86_vendor == X86_VENDOR_AMD) &&
-	  		(boot_cpu_data.x86 == 6 || boot_cpu_data.x86 == 15))
-		nmi_watchdog = nmi;
-	/*
-	 * We can enable the IO-APIC watchdog
-	 * unconditionally.
-	 */
-	if (nmi == NMI_IO_APIC) {
-		nmi_active = 1;
-		nmi_watchdog = nmi;
-	}
+	if ((nmi == NMI_LOCAL_APIC) && (nmi_known_cpu() == 0))
+		return 0;  /* no lapic support */
+	nmi_watchdog = nmi;
 	return 1;
 }
 
@@ -322,41 +299,30 @@ __setup("nmi_watchdog=", setup_nmi_watch
 
 static void disable_lapic_nmi_watchdog(void)
 {
-	if (nmi_active <= 0)
+	BUG_ON(nmi_watchdog != NMI_LOCAL_APIC);
+
+	if (atomic_read(&nmi_active) <= 0)
 		return;
-	switch (boot_cpu_data.x86_vendor) {
-	case X86_VENDOR_AMD:
-		wrmsr(MSR_K7_EVNTSEL0, 0, 0);
-		break;
-	case X86_VENDOR_INTEL:
-		switch (boot_cpu_data.x86) {
-		case 6:
-			if (boot_cpu_data.x86_model > 0xd)
-				break;
 
-			wrmsr(MSR_P6_EVNTSEL0, 0, 0);
-			break;
-		case 15:
-			if (boot_cpu_data.x86_model > 0x4)
-				break;
+	on_each_cpu(stop_apic_nmi_watchdog, NULL, 0, 1);
 
-			wrmsr(MSR_P4_IQ_CCCR0, 0, 0);
-			wrmsr(MSR_P4_CRU_ESCR0, 0, 0);
-			break;
-		}
-		break;
-	}
-	nmi_active = -1;
-	/* tell do_nmi() and others that we're not active any more */
-	nmi_watchdog = 0;
+	BUG_ON(atomic_read(&nmi_active) != 0);
 }
 
 static void enable_lapic_nmi_watchdog(void)
 {
-	if (nmi_active < 0) {
-		nmi_watchdog = NMI_LOCAL_APIC;
-		setup_apic_nmi_watchdog();
-	}
+	BUG_ON(nmi_watchdog != NMI_LOCAL_APIC);
+
+	/* are we already enabled */
+	if (atomic_read(&nmi_active) != 0)
+		return;
+
+	/* are we lapic aware */
+	if (nmi_known_cpu() <= 0)
+		return;
+
+	on_each_cpu(setup_apic_nmi_watchdog, NULL, 0, 1);
+	touch_nmi_watchdog();
 }
 
 int reserve_lapic_nmi(void)
@@ -388,20 +354,25 @@ void release_lapic_nmi(void)
 
 void disable_timer_nmi_watchdog(void)
 {
-	if ((nmi_watchdog != NMI_IO_APIC) || (nmi_active <= 0))
+	BUG_ON(nmi_watchdog != NMI_IO_APIC);
+
+	if (atomic_read(&nmi_active) <= 0)
 		return;
 
-	unset_nmi_callback();
-	nmi_active = -1;
-	nmi_watchdog = NMI_NONE;
+	disable_irq(0);
+	on_each_cpu(stop_apic_nmi_watchdog, NULL, 0, 1);
+
+	BUG_ON(atomic_read(&nmi_active) != 0);
 }
 
 void enable_timer_nmi_watchdog(void)
 {
-	if (nmi_active < 0) {
-		nmi_watchdog = NMI_IO_APIC;
+	BUG_ON(nmi_watchdog != NMI_IO_APIC);
+
+	if (atomic_read(&nmi_active) == 0) {
 		touch_nmi_watchdog();
-		nmi_active = 1;
+		on_each_cpu(setup_apic_nmi_watchdog, NULL, 0, 1);
+		enable_irq(0);
 	}
 }
 
@@ -411,7 +382,7 @@ static int nmi_pm_active; /* nmi_active 
 
 static int lapic_nmi_suspend(struct sys_device *dev, pm_message_t state)
 {
-	nmi_pm_active = nmi_active;
+	nmi_pm_active = atomic_read(&nmi_active);
 	disable_lapic_nmi_watchdog();
 	return 0;
 }
@@ -439,7 +410,13 @@ static int __init init_lapic_nmi_sysfs(v
 {
 	int error;
 
-	if (nmi_active == 0 || nmi_watchdog != NMI_LOCAL_APIC)
+	/* should really be a BUG_ON but b/c this is an
+	 * init call, it just doesn't work.  -dcz
+	 */
+	if (nmi_watchdog != NMI_LOCAL_APIC)
+		return 0;
+
+	if ( atomic_read(&nmi_active) < 0 )
 		return 0;
 
 	error = sysdev_class_register(&nmi_sysclass);
@@ -457,143 +434,312 @@ late_initcall(init_lapic_nmi_sysfs);
  * Original code written by Keith Owens.
  */
 
-static void write_watchdog_counter(const char *descr)
+static void write_watchdog_counter(unsigned int perfctr_msr, const char *descr)
 {
 	u64 count = (u64)cpu_khz * 1000;
 
 	do_div(count, nmi_hz);
 	if(descr)
 		Dprintk("setting %s to -0x%08Lx\n", descr, count);
-	wrmsrl(nmi_perfctr_msr, 0 - count);
+	wrmsrl(perfctr_msr, 0 - count);
 }
 
+/* Note that these events don't tick when the CPU idles. This means
+   the frequency varies with CPU load. */
+
+#define K7_EVNTSEL_ENABLE	(1 << 22)
+#define K7_EVNTSEL_INT		(1 << 20)
+#define K7_EVNTSEL_OS		(1 << 17)
+#define K7_EVNTSEL_USR		(1 << 16)
+#define K7_EVENT_CYCLES_PROCESSOR_IS_RUNNING	0x76
+#define K7_NMI_EVENT		K7_EVENT_CYCLES_PROCESSOR_IS_RUNNING
+
 static int setup_k7_watchdog(void)
 {
+	unsigned int perfctr_msr, evntsel_msr;
 	unsigned int evntsel;
+	struct nmi_watchdog_ctlblk *wd = &__get_cpu_var(nmi_watchdog_ctlblk);
 
-	nmi_perfctr_msr = MSR_K7_PERFCTR0;
-
-	if (!reserve_perfctr_nmi(nmi_perfctr_msr))
+	perfctr_msr = MSR_K7_PERFCTR0;
+	evntsel_msr = MSR_K7_EVNTSEL0;
+	if (!reserve_perfctr_nmi(perfctr_msr))
 		goto fail;
 
-	if (!reserve_evntsel_nmi(MSR_K7_EVNTSEL0))
+	if (!reserve_evntsel_nmi(evntsel_msr))
 		goto fail1;
 
-	wrmsrl(MSR_K7_PERFCTR0, 0UL);
+	wrmsrl(perfctr_msr, 0UL);
 
 	evntsel = K7_EVNTSEL_INT
 		| K7_EVNTSEL_OS
 		| K7_EVNTSEL_USR
 		| K7_NMI_EVENT;
 
-	wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
-	write_watchdog_counter("K7_PERFCTR0");
+	/* setup the timer */
+	wrmsr(evntsel_msr, evntsel, 0);
+	write_watchdog_counter(perfctr_msr, "K7_PERFCTR0");
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
 	evntsel |= K7_EVNTSEL_ENABLE;
-	wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
+	wrmsr(evntsel_msr, evntsel, 0);
+
+	wd->perfctr_msr = perfctr_msr;
+	wd->evntsel_msr = evntsel_msr;
+	wd->cccr_msr = 0;  //unused
+	wd->check_bit = 1ULL<<63;
 	return 1;
 fail1:
-	release_perfctr_nmi(nmi_perfctr_msr);
+	release_perfctr_nmi(perfctr_msr);
 fail:
 	return 0;
 }
 
+static void stop_k7_watchdog(void)
+{
+	struct nmi_watchdog_ctlblk *wd = &__get_cpu_var(nmi_watchdog_ctlblk);
+
+	wrmsr(wd->evntsel_msr, 0, 0);
+
+	release_evntsel_nmi(wd->evntsel_msr);
+	release_perfctr_nmi(wd->perfctr_msr);
+}
+
+#define P6_EVNTSEL0_ENABLE	(1 << 22)
+#define P6_EVNTSEL_INT		(1 << 20)
+#define P6_EVNTSEL_OS		(1 << 17)
+#define P6_EVNTSEL_USR		(1 << 16)
+#define P6_EVENT_CPU_CLOCKS_NOT_HALTED	0x79
+#define P6_NMI_EVENT		P6_EVENT_CPU_CLOCKS_NOT_HALTED
+
 static int setup_p6_watchdog(void)
 {
+	unsigned int perfctr_msr, evntsel_msr;
 	unsigned int evntsel;
+	struct nmi_watchdog_ctlblk *wd = &__get_cpu_var(nmi_watchdog_ctlblk);
 
-	nmi_perfctr_msr = MSR_P6_PERFCTR0;
-
-	if (!reserve_perfctr_nmi(nmi_perfctr_msr))
+	perfctr_msr = MSR_P6_PERFCTR0;
+	evntsel_msr = MSR_P6_EVNTSEL0;
+	if (!reserve_perfctr_nmi(perfctr_msr))
 		goto fail;
 
-	if (!reserve_evntsel_nmi(MSR_P6_EVNTSEL0))
+	if (!reserve_evntsel_nmi(evntsel_msr))
 		goto fail1;
 
+	wrmsrl(perfctr_msr, 0UL);
+
 	evntsel = P6_EVNTSEL_INT
 		| P6_EVNTSEL_OS
 		| P6_EVNTSEL_USR
 		| P6_NMI_EVENT;
 
-	wrmsr(MSR_P6_EVNTSEL0, evntsel, 0);
-	write_watchdog_counter("P6_PERFCTR0");
+	/* setup the timer */
+	wrmsr(evntsel_msr, evntsel, 0);
+	write_watchdog_counter(perfctr_msr, "P6_PERFCTR0");
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
-	evntsel |= P6_EVNTSEL0_ENABLE;
-	wrmsr(MSR_P6_EVNTSEL0, evntsel, 0);
+	evntsel |= K7_EVNTSEL_ENABLE;
+	wrmsr(evntsel_msr, evntsel, 0);
+
+	wd->perfctr_msr = perfctr_msr;
+	wd->evntsel_msr = evntsel_msr;
+	wd->cccr_msr = 0;  //unused
+	wd->check_bit = 1ULL<<39;
 	return 1;
 fail1:
-	release_perfctr_nmi(nmi_perfctr_msr);
+	release_perfctr_nmi(perfctr_msr);
 fail:
 	return 0;
 }
 
+static void stop_p6_watchdog(void)
+{
+	struct nmi_watchdog_ctlblk *wd = &__get_cpu_var(nmi_watchdog_ctlblk);
+
+	wrmsr(wd->evntsel_msr, 0, 0);
+
+	release_evntsel_nmi(wd->evntsel_msr);
+	release_perfctr_nmi(wd->perfctr_msr);
+}
+
+/* Note that these events don't tick when the CPU idles. This means
+   the frequency varies with CPU load. */
+
+#define MSR_P4_MISC_ENABLE_PERF_AVAIL	(1<<7)
+#define P4_ESCR_EVENT_SELECT(N)	((N)<<25)
+#define P4_ESCR_OS		(1<<3)
+#define P4_ESCR_USR		(1<<2)
+#define P4_CCCR_OVF_PMI0	(1<<26)
+#define P4_CCCR_OVF_PMI1	(1<<27)
+#define P4_CCCR_THRESHOLD(N)	((N)<<20)
+#define P4_CCCR_COMPLEMENT	(1<<19)
+#define P4_CCCR_COMPARE		(1<<18)
+#define P4_CCCR_REQUIRED	(3<<16)
+#define P4_CCCR_ESCR_SELECT(N)	((N)<<13)
+#define P4_CCCR_ENABLE		(1<<12)
+#define P4_CCCR_OVF 		(1<<31)
+/* Set up IQ_COUNTER0 to behave like a clock, by having IQ_CCCR0 filter
+   CRU_ESCR0 (with any non-null event selector) through a complemented
+   max threshold. [IA32-Vol3, Section 14.9.9] */
+
 static int setup_p4_watchdog(void)
 {
+	unsigned int perfctr_msr, evntsel_msr, cccr_msr;
+	unsigned int evntsel, cccr_val;
 	unsigned int misc_enable, dummy;
+	unsigned int ht_num;
+	struct nmi_watchdog_ctlblk *wd = &__get_cpu_var(nmi_watchdog_ctlblk);
 
-	rdmsr(MSR_P4_MISC_ENABLE, misc_enable, dummy);
+	rdmsr(MSR_IA32_MISC_ENABLE, misc_enable, dummy);
 	if (!(misc_enable & MSR_P4_MISC_ENABLE_PERF_AVAIL))
 		return 0;
 
-	nmi_perfctr_msr = MSR_P4_IQ_COUNTER0;
-	nmi_p4_cccr_val = P4_NMI_IQ_CCCR0;
 #ifdef CONFIG_SMP
-	if (smp_num_siblings == 2)
-		nmi_p4_cccr_val |= P4_CCCR_OVF_PMI1;
+	/* detect which hyperthread we are on */
+	if (smp_num_siblings == 2) {
+		unsigned int ebx, apicid;
+
+        	ebx = cpuid_ebx(1);
+	        apicid = (ebx >> 24) & 0xff;
+        	ht_num = apicid & 1;
+	} else
 #endif
+		ht_num = 0;
 
-	if (!reserve_perfctr_nmi(nmi_perfctr_msr))
+	/* performance counters are shared resources
+	 * assign each hyperthread its own set
+	 * (re-use the ESCR0 register, seems safe
+	 * and keeps the cccr_val the same)
+	 */
+	if (!ht_num) {
+		/* logical cpu 0 */
+		perfctr_msr = MSR_P4_IQ_PERFCTR0;
+		evntsel_msr = MSR_P4_CRU_ESCR0;
+		cccr_msr = MSR_P4_IQ_CCCR0;
+		cccr_val = P4_CCCR_OVF_PMI0 | P4_CCCR_ESCR_SELECT(4);
+	} else {
+		/* logical cpu 1 */
+		perfctr_msr = MSR_P4_IQ_PERFCTR1;
+		evntsel_msr = MSR_P4_CRU_ESCR0;
+		cccr_msr = MSR_P4_IQ_CCCR1;
+		cccr_val = P4_CCCR_OVF_PMI1 | P4_CCCR_ESCR_SELECT(4);
+	}
+
+	if (!reserve_perfctr_nmi(perfctr_msr))
 		goto fail;
 
-	if (!reserve_evntsel_nmi(MSR_P4_CRU_ESCR0))
+	if (!reserve_evntsel_nmi(evntsel_msr))
 		goto fail1;
 
-	wrmsr(MSR_P4_CRU_ESCR0, P4_NMI_CRU_ESCR0, 0);
-	wrmsr(MSR_P4_IQ_CCCR0, P4_NMI_IQ_CCCR0 & ~P4_CCCR_ENABLE, 0);
-	write_watchdog_counter("P4_IQ_COUNTER0");
+	evntsel = P4_ESCR_EVENT_SELECT(0x3F)
+	 	| P4_ESCR_OS
+		| P4_ESCR_USR;
+
+	cccr_val |= P4_CCCR_THRESHOLD(15)
+		 | P4_CCCR_COMPLEMENT
+		 | P4_CCCR_COMPARE
+		 | P4_CCCR_REQUIRED;
+
+	wrmsr(evntsel_msr, evntsel, 0);
+	wrmsr(cccr_msr, cccr_val, 0);
+	write_watchdog_counter(perfctr_msr, "P4_IQ_COUNTER0");
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
-	wrmsr(MSR_P4_IQ_CCCR0, nmi_p4_cccr_val, 0);
+	cccr_val |= P4_CCCR_ENABLE;
+	wrmsr(cccr_msr, cccr_val, 0);
+	wd->perfctr_msr = perfctr_msr;
+	wd->evntsel_msr = evntsel_msr;
+	wd->cccr_msr = cccr_msr;
+	wd->check_bit = 1ULL<<39;
 	return 1;
 fail1:
-	release_perfctr_nmi(nmi_perfctr_msr);
+	release_perfctr_nmi(perfctr_msr);
 fail:
 	return 0;
 }
 
-void setup_apic_nmi_watchdog (void)
+static void stop_p4_watchdog(void)
 {
-	switch (boot_cpu_data.x86_vendor) {
-	case X86_VENDOR_AMD:
-		if (boot_cpu_data.x86 != 6 && boot_cpu_data.x86 != 15)
-			return;
-		if (!setup_k7_watchdog())
-			return;
-		break;
-	case X86_VENDOR_INTEL:
-		switch (boot_cpu_data.x86) {
-		case 6:
-			if (boot_cpu_data.x86_model > 0xd)
-				return;
+	struct nmi_watchdog_ctlblk *wd = &__get_cpu_var(nmi_watchdog_ctlblk);
+
+	wrmsr(wd->cccr_msr, 0, 0);
+	wrmsr(wd->evntsel_msr, 0, 0);
+
+	release_evntsel_nmi(wd->evntsel_msr);
+	release_perfctr_nmi(wd->perfctr_msr);
+}
+
+void setup_apic_nmi_watchdog (void *unused)
+{
+	/* only support LOCAL and IO APICs for now */
+	if ((nmi_watchdog != NMI_LOCAL_APIC) &&
+	    (nmi_watchdog != NMI_IO_APIC))
+	    	return;
 
-			if(!setup_p6_watchdog())
+	if (nmi_watchdog == NMI_LOCAL_APIC) {
+		switch (boot_cpu_data.x86_vendor) {
+		case X86_VENDOR_AMD:
+			if (boot_cpu_data.x86 != 6 && boot_cpu_data.x86 != 15)
 				return;
-			break;
-		case 15:
-			if (boot_cpu_data.x86_model > 0x4)
+			if (!setup_k7_watchdog())
 				return;
+			break;
+		case X86_VENDOR_INTEL:
+			switch (boot_cpu_data.x86) {
+			case 6:
+				if (boot_cpu_data.x86_model > 0xd)
+					return;
 
-			if (!setup_p4_watchdog())
+				if (!setup_p6_watchdog())
+					return;
+				break;
+			case 15:
+				if (boot_cpu_data.x86_model > 0x4)
+					return;
+
+				if (!setup_p4_watchdog())
+					return;
+				break;
+			default:
 				return;
+			}
+			break;
+		default:
+			return;
+		}
+	}
+	__get_cpu_var(nmi_watchdog_ctlblk.enabled) = 1;
+	atomic_inc(&nmi_active);
+}
+
+static void stop_apic_nmi_watchdog(void *unused)
+{
+	/* only support LOCAL and IO APICs for now */
+	if ((nmi_watchdog != NMI_LOCAL_APIC) &&
+	    (nmi_watchdog != NMI_IO_APIC))
+	    	return;
+
+	if (nmi_watchdog == NMI_LOCAL_APIC) {
+		switch (boot_cpu_data.x86_vendor) {
+		case X86_VENDOR_AMD:
+			stop_k7_watchdog();
+			break;
+		case X86_VENDOR_INTEL:
+			switch (boot_cpu_data.x86) {
+			case 6:
+				if (boot_cpu_data.x86_model > 0xd)
+					break;
+				stop_p6_watchdog();
+				break;
+			case 15:
+				if (boot_cpu_data.x86_model > 0x4)
+					break;
+				stop_p4_watchdog();
+				break;
+			}
 			break;
 		default:
 			return;
 		}
-		break;
-	default:
-		return;
 	}
-	lapic_nmi_owner = LAPIC_NMI_WATCHDOG;
-	nmi_active = 1;
+	__get_cpu_var(nmi_watchdog_ctlblk.enabled) = 0;
+	atomic_dec(&nmi_active);
 }
 
 /*
@@ -634,7 +780,7 @@ void touch_nmi_watchdog (void)
 
 extern void die_nmi(struct pt_regs *, const char *msg);
 
-void nmi_watchdog_tick (struct pt_regs * regs)
+void nmi_watchdog_tick (struct pt_regs * regs, unsigned reason)
 {
 
 	/*
@@ -643,11 +789,21 @@ void nmi_watchdog_tick (struct pt_regs *
 	 * smp_processor_id().
 	 */
 	unsigned int sum;
+	int touched = 0;
 	int cpu = smp_processor_id();
+	struct nmi_watchdog_ctlblk *wd = &__get_cpu_var(nmi_watchdog_ctlblk);
+	u64 dummy;
+
+	/* check for other users first */
+	if (notify_die(DIE_NMI, "nmi", regs, reason, 2, SIGINT)
+			== NOTIFY_STOP) {
+		touched = 1;
+	}
 
 	sum = per_cpu(irq_stat, cpu).apic_timer_irqs;
 
-	if (last_irq_sums[cpu] == sum) {
+	/* if the apic timer isn't firing, this cpu isn't doing much */
+	if (!touched && last_irq_sums[cpu] == sum) {
 		/*
 		 * Ayiee, looks like this CPU is stuck ...
 		 * wait a few IRQs (5 seconds) before doing the oops ...
@@ -662,26 +818,41 @@ void nmi_watchdog_tick (struct pt_regs *
 		last_irq_sums[cpu] = sum;
 		alert_counter[cpu] = 0;
 	}
-	if (nmi_perfctr_msr) {
-		if (nmi_perfctr_msr == MSR_P4_IQ_COUNTER0) {
-			/*
-			 * P4 quirks:
-			 * - An overflown perfctr will assert its interrupt
-			 *   until the OVF flag in its CCCR is cleared.
-			 * - LVTPC is masked on interrupt and must be
-			 *   unmasked by the LVTPC handler.
-			 */
-			wrmsr(MSR_P4_IQ_CCCR0, nmi_p4_cccr_val, 0);
-			apic_write(APIC_LVTPC, APIC_DM_NMI);
-		}
-		else if (nmi_perfctr_msr == MSR_P6_PERFCTR0) {
-			/* Only P6 based Pentium M need to re-unmask
-			 * the apic vector but it doesn't hurt
-			 * other P6 variant */
-			apic_write(APIC_LVTPC, APIC_DM_NMI);
+	/* see if the nmi watchdog went off */
+	if (wd->enabled) {
+		if (nmi_watchdog == NMI_LOCAL_APIC) {
+			rdmsrl(wd->perfctr_msr, dummy);
+			if (dummy & wd->check_bit){
+				/* this wasn't a watchdog timer interrupt */
+				goto done;
+			}
+
+			/* only Intel P4 uses the cccr msr */
+	 		if (wd->cccr_msr != 0) {
+	 			/*
+	 			 * P4 quirks:
+	 			 * - An overflown perfctr will assert its interrupt
+	 			 *   until the OVF flag in its CCCR is cleared.
+	 			 * - LVTPC is masked on interrupt and must be
+	 			 *   unmasked by the LVTPC handler.
+	 			 */
+				rdmsrl(wd->cccr_msr, dummy);
+				dummy &= ~P4_CCCR_OVF;
+	 			wrmsrl(wd->cccr_msr, dummy);
+	 			apic_write(APIC_LVTPC, APIC_DM_NMI);
+	 		}
+			else if (wd->perfctr_msr == MSR_P6_PERFCTR0) {
+				/* Only P6 based Pentium M need to re-unmask
+				 * the apic vector but it doesn't hurt
+				 * other P6 variant */
+				apic_write(APIC_LVTPC, APIC_DM_NMI);
+			}
+			/* start the cycle over again */
+			write_watchdog_counter(wd->perfctr_msr, NULL);
 		}
-		write_watchdog_counter(NULL);
 	}
+done:
+	return;
 }
 
 #ifdef CONFIG_SYSCTL
Index: linux-don/arch/i386/kernel/traps.c
===================================================================
--- linux-don.orig/arch/i386/kernel/traps.c
+++ linux-don/arch/i386/kernel/traps.c
@@ -691,7 +691,7 @@ static void default_do_nmi(struct pt_reg
 		 * so it must be the NMI watchdog.
 		 */
 		if (nmi_watchdog) {
-			nmi_watchdog_tick(regs);
+			nmi_watchdog_tick(regs, reason);
 			return;
 		}
 #endif
Index: linux-don/include/asm-i386/nmi.h
===================================================================
--- linux-don.orig/include/asm-i386/nmi.h
+++ linux-don/include/asm-i386/nmi.h
@@ -32,13 +32,14 @@ extern void release_perfctr_nmi(unsigned
 extern int reserve_evntsel_nmi(unsigned int);
 extern void release_evntsel_nmi(unsigned int);
 
-extern void setup_apic_nmi_watchdog (void);
+extern void setup_apic_nmi_watchdog (void *);
 extern int reserve_lapic_nmi(void);
 extern void release_lapic_nmi(void);
 extern void disable_timer_nmi_watchdog(void);
 extern void enable_timer_nmi_watchdog(void);
-extern void nmi_watchdog_tick (struct pt_regs * regs);
+extern void nmi_watchdog_tick (struct pt_regs * regs, unsigned reason);
 
+extern atomic_t nmi_active;
 extern unsigned int nmi_watchdog;
 #define NMI_DEFAULT     -1
 #define NMI_NONE	0
Index: linux-don/arch/i386/oprofile/nmi_timer_int.c
===================================================================
--- linux-don.orig/arch/i386/oprofile/nmi_timer_int.c
+++ linux-don/arch/i386/oprofile/nmi_timer_int.c
@@ -42,9 +42,7 @@ static void timer_stop(void)
 
 int __init op_nmi_timer_init(struct oprofile_operations * ops)
 {
-	extern int nmi_active;
-
-	if (nmi_active <= 0)
+	if (atomic_read(&nmi_active) <= 0)
 		return -ENODEV;
 
 	ops->start = timer_start;

--
