Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129282AbRBTSLf>; Tue, 20 Feb 2001 13:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129377AbRBTSL0>; Tue, 20 Feb 2001 13:11:26 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:38337 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S129282AbRBTSLH>;
	Tue, 20 Feb 2001 13:11:07 -0500
Date: Tue, 20 Feb 2001 19:11:02 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200102201811.TAA00748@harpo.it.uu.se>
To: alan@lxorguk.ukuu.org.uk
Subject: [PATCH] 2.4.1-ac UP-APIC updates
Cc: linux-kernel@vger.kernel.org, macro@ds2.pg.gda.pl, mingo@redhat.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

This patch (against 2.4.1-ac19) includes the following UP-APIC updates:

* Power Management: If the kernel's UP-APIC code enabled the local APIC
  because the BIOS chose not to, it is imperative that the kernel also
  disables the local APIC before entering apm/acpi suspend mode. Failure
  to do this causes suspend failures and hard system hangs.

  The patch fixes apm suspend problems at least on my ASUS P3B-F and
  Petr Vandrovec's A7V. (Petr had to use the "standard" UHCI support,
  the alternate "JE" one dies after resume.)

* Maciej Rozycki's SMP kernel on UP hardware fix: smpboot needs to call
  APIC_unit_uniprocessor() in order to activate the NMI watchdog.

* Code cleanups in nmi.c. Moved P6/K7 setup code to their own functions.
  Simplified the P6 code.

* NMI rate reduction for UP-APIC: the 100Hz default rate is excessive for
  normal systems, 1Hz suffices. It turns out we cannot start at 1Hz due to
  this interacting badly with check_nmi_watchdog() and the watchdog itself,
  so the rate is reduced after check_nmi_watchdog() is done.

  Some people see much less than 100 NMI/s with the current code in 2.4.1-ac.
  I _believe_ it has to do with APM being enabled or not: with APM disabled
  the kernel will 'hlt' when idle, which will stop the CPU clock and thus
  the perfctr generating NMIs until the next timer irq.

/Mikael

diff -ruN linux-2.4.1-ac19/arch/i386/kernel/apic.c linux-2.4.1-ac19-upapic/arch/i386/kernel/apic.c
--- linux-2.4.1-ac19/arch/i386/kernel/apic.c	Tue Feb 20 14:11:36 2001
+++ linux-2.4.1-ac19-upapic/arch/i386/kernel/apic.c	Tue Feb 20 14:10:48 2001
@@ -9,6 +9,7 @@
  *					and Rolf G. Tews
  *					for testing these extensively.
  *	Maciej W. Rozycki	:	Various updates and fixes.
+ *	Mikael Pettersson	:	Power Management for UP-APIC.
  */
 
 #include <linux/config.h>
@@ -379,14 +380,169 @@
 		setup_apic_nmi_watchdog();
 }
 
+#ifdef CONFIG_PM
+
+#include <linux/slab.h>
+#include <linux/pm.h>
+
+static struct {
+	/* 'active' is true if the local APIC was enabled by us and
+	   not the BIOS; this signifies that we are also responsible
+	   for disabling it before entering apm/acpi suspend */
+	int active;
+	/* 'perfctr_pmdev' is here because the current (2.4.1) PM
+	   callback system doesn't handle hierarchical dependencies */
+	struct pm_dev *perfctr_pmdev;
+	/* r/w apic fields */
+	unsigned int apic_id;
+	unsigned int apic_taskpri;
+	unsigned int apic_ldr;
+	unsigned int apic_dfr;
+	unsigned int apic_spiv;
+	unsigned int apic_lvtt;
+	unsigned int apic_lvtpc;
+	unsigned int apic_lvt0;
+	unsigned int apic_lvt1;
+	unsigned int apic_lvterr;
+	unsigned int apic_tmict;
+	unsigned int apic_tdcr;
+} apic_pm_state;
+
+static void apic_pm_suspend(void *data)
+{
+	unsigned int l, h;
+	unsigned long flags;
+
+	if (apic_pm_state.perfctr_pmdev)
+		pm_send(apic_pm_state.perfctr_pmdev, PM_SUSPEND, data);
+	apic_pm_state.apic_id = apic_read(APIC_ID);
+	apic_pm_state.apic_taskpri = apic_read(APIC_TASKPRI);
+	apic_pm_state.apic_ldr = apic_read(APIC_LDR);
+	apic_pm_state.apic_dfr = apic_read(APIC_DFR);
+	apic_pm_state.apic_spiv = apic_read(APIC_SPIV);
+	apic_pm_state.apic_lvtt = apic_read(APIC_LVTT);
+	apic_pm_state.apic_lvtpc = apic_read(APIC_LVTPC);
+	apic_pm_state.apic_lvt0 = apic_read(APIC_LVT0);
+	apic_pm_state.apic_lvt1 = apic_read(APIC_LVT1);
+	apic_pm_state.apic_lvterr = apic_read(APIC_LVTERR);
+	apic_pm_state.apic_tmict = apic_read(APIC_TMICT);
+	apic_pm_state.apic_tdcr = apic_read(APIC_TDCR);
+	__save_flags(flags);
+	__cli();
+	disable_local_APIC();
+	rdmsr(MSR_IA32_APICBASE, l, h);
+	l &= ~MSR_IA32_APICBASE_ENABLE;
+	wrmsr(MSR_IA32_APICBASE, l, h);
+	__restore_flags(flags);
+}
+
+static void apic_pm_resume(void *data)
+{
+	unsigned int l, h;
+	unsigned long flags;
+
+	__save_flags(flags);
+	__cli();
+	rdmsr(MSR_IA32_APICBASE, l, h);
+	l &= ~MSR_IA32_APICBASE_BASE;
+	l |= MSR_IA32_APICBASE_ENABLE | APIC_DEFAULT_PHYS_BASE;
+	wrmsr(MSR_IA32_APICBASE, l, h);
+	apic_write(APIC_ID, apic_pm_state.apic_id);
+	apic_write(APIC_DFR, apic_pm_state.apic_dfr);
+	apic_write(APIC_LDR, apic_pm_state.apic_ldr);
+	apic_write(APIC_TASKPRI, apic_pm_state.apic_taskpri);
+	apic_write(APIC_SPIV, apic_pm_state.apic_spiv);
+	apic_write(APIC_LVT0, apic_pm_state.apic_lvt0);
+	apic_write(APIC_LVT1, apic_pm_state.apic_lvt1);
+	apic_write(APIC_ESR, 0);
+	apic_read(APIC_ESR);
+	apic_write(APIC_LVTERR, apic_pm_state.apic_lvterr);
+	apic_write(APIC_ESR, 0);
+	apic_read(APIC_ESR);
+	apic_write(APIC_LVTPC, apic_pm_state.apic_lvtpc);
+	apic_write(APIC_LVTT, apic_pm_state.apic_lvtt);
+	apic_write(APIC_TDCR, apic_pm_state.apic_tdcr);
+	apic_write(APIC_TMICT, apic_pm_state.apic_tmict);
+	__restore_flags(flags);
+	if (apic_pm_state.perfctr_pmdev)
+		pm_send(apic_pm_state.perfctr_pmdev, PM_RESUME, data);
+}
+
+static int apic_pm_callback(struct pm_dev *dev, pm_request_t rqst, void *data)
+{
+	switch (rqst) {
+	case PM_SUSPEND:
+		apic_pm_suspend(data);
+		break;
+	case PM_RESUME:
+		apic_pm_resume(data);
+		break;
+	}
+	return 0;
+}
+
+/* perfctr driver should call this instead of pm_register() */
+struct pm_dev *apic_pm_register(pm_dev_t type,
+				unsigned long id,
+				pm_callback callback)
+{
+	struct pm_dev *dev;
+
+	if (!apic_pm_state.active)
+		return pm_register(type, id, callback);
+	if (apic_pm_state.perfctr_pmdev)
+		return NULL;	/* we're busy */
+	dev = kmalloc(sizeof(struct pm_dev), GFP_KERNEL);
+	if (dev) {
+		memset(dev, 0, sizeof(*dev));
+		dev->type = type;
+		dev->id = id;
+		dev->callback = callback;
+		apic_pm_state.perfctr_pmdev = dev;
+	}
+	return dev;
+}
+
+/* perfctr driver should call this instead of pm_unregister() */
+void apic_pm_unregister(struct pm_dev *dev)
+{
+	if (!apic_pm_state.active) {
+		pm_unregister(dev);
+	} else if (dev == apic_pm_state.perfctr_pmdev) {
+		apic_pm_state.perfctr_pmdev = NULL;
+		kfree(dev);
+	}
+}
+
+static void __init apic_pm_init1(void)
+{
+	/* can't pm_register() at this early stage in the boot process
+	   (causes an immediate reboot), so just set the flag */
+	apic_pm_state.active = 1;
+}
+
+static void __init apic_pm_init2(void)
+{
+	if (apic_pm_state.active)
+		pm_register(PM_SYS_DEV, 0, apic_pm_callback);
+}
+
+#else	/* CONFIG_PM */
+
+static inline void apic_pm_init1(void) { }
+static inline void apic_pm_init2(void) { }
+
+#endif	/* CONFIG_PM */
+
 /*
  * Detect and enable local APICs on non-SMP boards.
  * Original code written by Keir Fraser.
  */
 
-int __init detect_init_APIC (void)
+static int __init detect_init_APIC (void)
 {
 	u32 h, l, dummy, features;
+	int needs_pm = 0;
 	extern void get_cpu_vendor(struct cpuinfo_x86*);
 
 	/* Workaround for us being called before identify_cpu(). */
@@ -418,6 +574,7 @@
 			l &= ~MSR_IA32_APICBASE_BASE;
 			l |= MSR_IA32_APICBASE_ENABLE | APIC_DEFAULT_PHYS_BASE;
 			wrmsr(MSR_IA32_APICBASE, l, h);
+			needs_pm = 1;
 		}
 	}
 	/*
@@ -437,6 +594,9 @@
 
 	printk("Found and enabled local APIC!\n");
 
+	if (needs_pm)
+		apic_pm_init1();
+
 	return 0;
 
 no_apic:
@@ -893,10 +1053,10 @@
  * This initializes the IO-APIC and APIC hardware if this is
  * a UP kernel.
  */
-void __init APIC_init_uniprocessor (void)
+int __init APIC_init_uniprocessor (void)
 {
 	if (!smp_found_config && !cpu_has_apic)
-		return;
+		return -1;
 
 	/*
 	 * Complain if the BIOS pretends there is one.
@@ -904,7 +1064,7 @@
 	if (!cpu_has_apic && APIC_INTEGRATED(apic_version[boot_cpu_id])) {
 		printk(KERN_ERR "BIOS bug, local APIC #%d not detected!...\n",
 			boot_cpu_id);
-		return;
+		return -1;
 	}
 
 	verify_local_APIC();
@@ -914,6 +1074,8 @@
 	phys_cpu_present_map = 1;
 	apic_write_around(APIC_ID, boot_cpu_id);
 
+	apic_pm_init2();
+
 	setup_local_APIC();
 
 	if (nmi_watchdog == NMI_LOCAL_APIC)
@@ -923,4 +1085,6 @@
 		setup_IO_APIC();
 #endif
 	setup_APIC_clocks();
+
+	return 0;
 }
diff -ruN linux-2.4.1-ac19/arch/i386/kernel/nmi.c linux-2.4.1-ac19-upapic/arch/i386/kernel/nmi.c
--- linux-2.4.1-ac19/arch/i386/kernel/nmi.c	Tue Feb 20 14:11:36 2001
+++ linux-2.4.1-ac19-upapic/arch/i386/kernel/nmi.c	Tue Feb 20 14:10:48 2001
@@ -4,6 +4,10 @@
  *  NMI watchdog support on APIC systems
  *
  *  Started by Ingo Molnar <mingo@redhat.com>
+ *
+ *  Fixes:
+ *  Mikael Pettersson	: AMD K7 support for local APIC NMI watchdog.
+ *  Mikael Pettersson	: Power Management for local APIC NMI watchdog.
  */
 
 #include <linux/mm.h>
@@ -22,6 +26,22 @@
 extern void bust_spinlocks(void);
 
 unsigned int nmi_watchdog = NMI_IO_APIC;
+static unsigned int nmi_hz = HZ;
+unsigned int nmi_perfctr_msr;	/* the MSR to reset in NMI handler */
+
+#define K7_EVNTSEL_ENABLE	(1 << 22)
+#define K7_EVNTSEL_INT		(1 << 20)
+#define K7_EVNTSEL_OS		(1 << 17)
+#define K7_EVNTSEL_USR		(1 << 16)
+#define K7_EVENT_CYCLES_PROCESSOR_IS_RUNNING	0x76
+#define K7_NMI_EVENT		K7_EVENT_CYCLES_PROCESSOR_IS_RUNNING
+
+#define P6_EVNTSEL0_ENABLE	(1 << 22)
+#define P6_EVNTSEL_INT		(1 << 20)
+#define P6_EVNTSEL_OS		(1 << 17)
+#define P6_EVNTSEL_USR		(1 << 16)
+#define P6_EVENT_CPU_CLOCKS_NOT_HALTED	0x79
+#define P6_NMI_EVENT		P6_EVENT_CPU_CLOCKS_NOT_HALTED
 
 int __init check_nmi_watchdog (void)
 {
@@ -32,7 +52,7 @@
 
 	memcpy(tmp, irq_stat, sizeof(tmp));
 	sti();
-	mdelay((10*1000)/HZ); // wait 10 ticks
+	mdelay((10*1000)/nmi_hz); // wait 10 ticks
 
 	for (j = 0; j < smp_num_cpus; j++) {
 		cpu = cpu_logical_map(j);
@@ -42,6 +62,12 @@
 		}
 	}
 	printk("OK.\n");
+
+	/* now that we know it works we can reduce NMI frequency to
+	   something more reasonable; makes a difference in some configs */
+	if (nmi_watchdog == NMI_LOCAL_APIC)
+		nmi_hz = 1;
+
 	return 0;
 }
 
@@ -56,9 +82,9 @@
 	if (nmi == NMI_NONE)
 		nmi_watchdog = nmi;
 	/*
-	 * If any non-Intel x86 CPU has a local APIC, then
+	 * If any other x86 CPU has a local APIC, then
 	 * please test the NMI stuff there and send me the
-	 * missing bits. Right now Intel only.
+	 * missing bits. Right now Intel P6 and AMD K7 only.
 	 */
 	if ((nmi == NMI_LOCAL_APIC) &&
 			(boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) &&
@@ -79,73 +105,125 @@
 
 __setup("nmi_watchdog=", setup_nmi_watchdog);
 
+#ifdef CONFIG_PM
+
+#include <linux/pm.h>
+
+struct pm_dev *nmi_pmdev;
+
+static void disable_apic_nmi_watchdog(void)
+{
+	switch (boot_cpu_data.x86_vendor) {
+	case X86_VENDOR_AMD:
+		wrmsr(MSR_K7_EVNTSEL0, 0, 0);
+		break;
+	case X86_VENDOR_INTEL:
+		wrmsr(MSR_IA32_EVNTSEL0, 0, 0);
+		break;
+	}
+}
+
+static int nmi_pm_callback(struct pm_dev *dev, pm_request_t rqst, void *data)
+{
+	switch (rqst) {
+	case PM_SUSPEND:
+		disable_apic_nmi_watchdog();
+		break;
+	case PM_RESUME:
+		setup_apic_nmi_watchdog();
+		break;
+	}
+	return 0;
+}
+
+static void nmi_pm_init(void)
+{
+	if (!nmi_pmdev)
+		nmi_pmdev = apic_pm_register(PM_SYS_DEV, 0, nmi_pm_callback);
+}
+
+#define __pminit	/*empty*/
+
+#else	/* CONFIG_PM */
+
+static inline void nmi_pm_init(void) { }
+
+#define __pminit	__init
+
+#endif	/* CONFIG_PM */
+
 /*
  * Activate the NMI watchdog via the local APIC.
  * Original code written by Keith Owens.
- * AMD K7 code by Mikael Pettersson.
  */
 
-static unsigned int nmi_perfctr_msr;	/* the MSR to reset in NMI handler */
-#define MSR_K7_EVNTSEL0 0xC0010000
-#define MSR_K7_PERFCTR0 0xC0010004
-/* Event 0x76 isn't listed in recent revisions of AMD #22007, and it
-   slows down (but doesn't halt) when the CPU is idle. Unfortunately
-   the K7 doesn't appear to have any other clock-like perfctr event. */
-#define K7_NMI_EVENT	0x76	/* CYCLES_PROCESSOR_IS_RUNNING */
-#define K7_NMI_EVNTSEL	((1<<20)|(3<<16)|K7_NMI_EVENT)	/* INT,OS,USR,<event> */
-
-void __init setup_apic_nmi_watchdog (void)
-{
-	int value;
-
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
-	    boot_cpu_data.x86 == 6) {
-		unsigned i;
-		unsigned evntsel;
-
-		nmi_perfctr_msr = MSR_K7_PERFCTR0;
-
-		for(i = 0; i < 4; ++i) {
-			wrmsr(MSR_K7_EVNTSEL0+i, 0, 0);
-			wrmsr(MSR_K7_PERFCTR0+i, 0, 0);
-		}
+static void __pminit setup_k7_watchdog(void)
+{
+	int i;
+	unsigned int evntsel;
 
-		evntsel = K7_NMI_EVNTSEL;
-		wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
-		printk("setting K7_PERFCTR0 to %08lx\n", -(cpu_khz/HZ*1000));
-		wrmsr(MSR_K7_PERFCTR0, -(cpu_khz/HZ*1000), -1);
-		printk("setting K7 LVTPC to DM_NMI\n");
-		apic_write(APIC_LVTPC, APIC_DM_NMI);
-		evntsel |= (1<<22);	/* ENable */
-		printk("setting K7_EVNTSEL0 to %08x\n", evntsel);
-		wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
-		return;
+	nmi_perfctr_msr = MSR_K7_PERFCTR0;
+
+	for(i = 0; i < 4; ++i) {
+		wrmsr(MSR_K7_EVNTSEL0+i, 0, 0);
+		wrmsr(MSR_K7_PERFCTR0+i, 0, 0);
 	}
 
-	nmi_perfctr_msr = MSR_IA32_PERFCTR1;
+	evntsel = K7_EVNTSEL_INT
+		| K7_EVNTSEL_OS
+		| K7_EVNTSEL_USR
+		| K7_NMI_EVENT;
+
+	wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
+	Dprintk("setting K7_PERFCTR0 to %08lx\n", -(cpu_khz/nmi_hz*1000));
+	wrmsr(MSR_K7_PERFCTR0, -(cpu_khz/nmi_hz*1000), -1);
+	apic_write(APIC_LVTPC, APIC_DM_NMI);
+	evntsel |= K7_EVNTSEL_ENABLE;
+	wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
+}
+
+static void __pminit setup_p6_watchdog(void)
+{
+	int i;
+	unsigned int evntsel;
 
-	/* clear performance counters 0, 1 */
+	nmi_perfctr_msr = MSR_IA32_PERFCTR0;
 
-	wrmsr(MSR_IA32_EVNTSEL0, 0, 0);
-	wrmsr(MSR_IA32_EVNTSEL1, 0, 0);
-	wrmsr(MSR_IA32_PERFCTR0, 0, 0);
-	wrmsr(MSR_IA32_PERFCTR1, 0, 0);
-
-	/* send local-APIC timer counter overflow event as an NMI */
-
-	value =   1 << 20	/* Interrupt on overflow */
-		| 1 << 17	/* OS mode */
-		| 1 << 16	/* User mode */
-		| 0x79;		/* Event, cpu clocks not halted */
-	wrmsr(MSR_IA32_EVNTSEL1, value, 0);
-	printk("PERFCTR1: %08lx\n", -(cpu_khz/HZ*1000));
-	wrmsr(MSR_IA32_PERFCTR1, -(cpu_khz/HZ*1000), 0);
-
-	/* Enable performance counters, only using ctr1 */
-
-	apic_write_around(APIC_LVTPC, APIC_DM_NMI);
-	value = 1 << 22;
-	wrmsr(MSR_IA32_EVNTSEL0, value, 0);
+	for(i = 0; i < 2; ++i) {
+		wrmsr(MSR_IA32_EVNTSEL0+i, 0, 0);
+		wrmsr(MSR_IA32_PERFCTR0+i, 0, 0);
+	}
+
+	evntsel = P6_EVNTSEL_INT
+		| P6_EVNTSEL_OS
+		| P6_EVNTSEL_USR
+		| P6_NMI_EVENT;
+
+	wrmsr(MSR_IA32_EVNTSEL0, evntsel, 0);
+	Dprintk("setting IA32_PERFCTR0 to %08lx\n", -(cpu_khz/nmi_hz*1000));
+	wrmsr(MSR_IA32_PERFCTR0, -(cpu_khz/nmi_hz*1000), 0);
+	apic_write(APIC_LVTPC, APIC_DM_NMI);
+	evntsel |= P6_EVNTSEL0_ENABLE;
+	wrmsr(MSR_IA32_EVNTSEL0, evntsel, 0);
+}
+
+void __pminit setup_apic_nmi_watchdog (void)
+{
+	switch (boot_cpu_data.x86_vendor) {
+	case X86_VENDOR_AMD:
+		if (boot_cpu_data.x86 != 6)
+			return;
+		setup_k7_watchdog();
+		break;
+	case X86_VENDOR_INTEL:
+		if (boot_cpu_data.x86 != 6)
+			return;
+		setup_p6_watchdog();
+		break;
+	default:
+		return;
+	}
+	nmi_pm_init();
 }
 
 static spinlock_t nmi_print_lock = SPIN_LOCK_UNLOCKED;
@@ -184,7 +262,7 @@
 		 * wait a few IRQs (5 seconds) before doing the oops ...
 		 */
 		alert_counter[cpu]++;
-		if (alert_counter[cpu] == 1*HZ) {
+		if (alert_counter[cpu] == 5*nmi_hz) {
 			spin_lock(&nmi_print_lock);
 			/*
 			 * We are in trouble anyway, lets at least try
@@ -202,6 +280,6 @@
 		last_irq_sums[cpu] = sum;
 		alert_counter[cpu] = 0;
 	}
-	if (cpu_has_apic && (nmi_watchdog == NMI_LOCAL_APIC))
-		wrmsr(nmi_perfctr_msr, -(cpu_khz/HZ*1000), -1);
+	if (nmi_perfctr_msr)
+		wrmsr(nmi_perfctr_msr, -(cpu_khz/nmi_hz*1000), -1);
 }
diff -ruN linux-2.4.1-ac19/arch/i386/kernel/smpboot.c linux-2.4.1-ac19-upapic/arch/i386/kernel/smpboot.c
--- linux-2.4.1-ac19/arch/i386/kernel/smpboot.c	Tue Feb 20 14:11:36 2001
+++ linux-2.4.1-ac19-upapic/arch/i386/kernel/smpboot.c	Tue Feb 20 14:10:48 2001
@@ -869,12 +869,15 @@
 	 * get out of here now!
 	 */
 	if (!smp_found_config) {
-		printk(KERN_NOTICE "SMP motherboard not detected. Using dummy APIC emulation.\n");
+		printk(KERN_NOTICE "SMP motherboard not detected.\n");
 #ifndef CONFIG_VISWS
 		io_apic_irqs = 0;
 #endif
 		cpu_online_map = phys_cpu_present_map = 1;
 		smp_num_cpus = 1;
+		if (APIC_init_uniprocessor())
+			printk(KERN_NOTICE "Local APIC not detected."
+					   " Using dummy APIC emulation.\n");
 		goto smp_done;
 	}
 
@@ -1020,4 +1023,3 @@
 smp_done:
 	zap_low_mappings();
 }
-
diff -ruN linux-2.4.1-ac19/include/asm-i386/apic.h linux-2.4.1-ac19-upapic/include/asm-i386/apic.h
--- linux-2.4.1-ac19/include/asm-i386/apic.h	Tue Feb 20 14:11:48 2001
+++ linux-2.4.1-ac19-upapic/include/asm-i386/apic.h	Tue Feb 20 14:10:48 2001
@@ -2,6 +2,7 @@
 #define __ASM_APIC_H
 
 #include <linux/config.h>
+#include <linux/pm.h>
 #include <asm/apicdef.h>
 #include <asm/system.h>
 
@@ -69,7 +70,6 @@
 extern int verify_local_APIC (void);
 extern void cache_APIC_registers (void);
 extern void sync_Arb_IDs (void);
-extern int detect_init_APIC (void);
 extern void init_bsp_APIC (void);
 extern void setup_local_APIC (void);
 extern void init_apic_mappings (void);
@@ -77,18 +77,19 @@
 extern void setup_APIC_clocks (void);
 extern void setup_apic_nmi_watchdog (void);
 extern inline void nmi_watchdog_tick (struct pt_regs * regs);
-extern void APIC_init_uniprocessor (void);
+extern int APIC_init_uniprocessor (void);
+
+extern struct pm_dev *apic_pm_register(pm_dev_t, unsigned long, pm_callback);
+extern void apic_pm_unregister(struct pm_dev*);
 
 extern unsigned int apic_timer_irqs [NR_CPUS];
 extern int check_nmi_watchdog (void);
 
 extern unsigned int nmi_watchdog;
-enum nmi_watchdog_source_types {
-	NMI_NONE = 0,
-	NMI_IO_APIC = 1,
-	NMI_LOCAL_APIC = 2,
-	NMI_INVALID = 3
-};
+#define NMI_NONE	0
+#define NMI_IO_APIC	1
+#define NMI_LOCAL_APIC	2
+#define NMI_INVALID	3
 
 #endif /* CONFIG_X86_LOCAL_APIC */
 
diff -ruN linux-2.4.1-ac19/include/asm-i386/msr.h linux-2.4.1-ac19-upapic/include/asm-i386/msr.h
--- linux-2.4.1-ac19/include/asm-i386/msr.h	Tue Feb 20 14:11:48 2001
+++ linux-2.4.1-ac19-upapic/include/asm-i386/msr.h	Tue Feb 20 14:10:48 2001
@@ -67,4 +67,7 @@
 #define		MSR_IA32_MC0_MISC_OFFSET	0x3
 #define		MSR_IA32_MC0_BANK_COUNT		0x4
 
-#endif
+#define MSR_K7_EVNTSEL0			0xC0010000
+#define MSR_K7_PERFCTR0			0xC0010004
+
+#endif /* __ASM_MSR_H */
