Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262573AbTC1Iel>; Fri, 28 Mar 2003 03:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262428AbTC1Iel>; Fri, 28 Mar 2003 03:34:41 -0500
Received: from [195.39.17.254] ([195.39.17.254]:2564 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262573AbTC1Idj>;
	Fri, 28 Mar 2003 03:33:39 -0500
Date: Thu, 27 Mar 2003 23:31:55 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
Subject: Convert APIC to driver model
Message-ID: <20030327223155.GA182@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This cleans mess in APICs (creative use of pm_send), and converts it
to driver model. Please apply,

							Pavel
%patch
Index: linux/arch/i386/kernel/apic.c
===================================================================
--- linux.orig/arch/i386/kernel/apic.c	2003-03-27 11:09:18.000000000 +0100
+++ linux/arch/i386/kernel/apic.c	2003-03-16 18:51:05.000000000 +0100
@@ -10,6 +10,8 @@
  *					for testing these extensively.
  *	Maciej W. Rozycki	:	Various updates and fixes.
  *	Mikael Pettersson	:	Power Management for UP-APIC.
+ *	Pavel Machek and
+ *	Mikael Pettersson	:	Converted to driver model.
  */
 
 #include <linux/config.h>
@@ -23,6 +25,10 @@
 #include <linux/interrupt.h>
 #include <linux/mc146818rtc.h>
 #include <linux/kernel_stat.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/device.h>
+#include <linux/pm.h>
 
 #include <asm/atomic.h>
 #include <asm/smp.h>
@@ -77,7 +83,7 @@
 	return maxlvt;
 }
 
-void clear_local_APIC(void)
+void clear_lapic(void)
 {
 	int maxlvt;
 	unsigned long v;
@@ -143,7 +149,7 @@
 		/*
 		 * Do not trust the local APIC being empty at bootup.
 		 */
-		clear_local_APIC();
+		clear_lapic();
 		/*
 		 * PIC mode, enable APIC mode in the IMCR, i.e.
 		 * connect BSP's local APIC to INT and NMI lines.
@@ -169,11 +175,11 @@
 	}
 }
 
-void disable_local_APIC(void)
+void disable_lapic(void)
 {
 	unsigned long value;
 
-	clear_local_APIC();
+	clear_lapic();
 
 	/*
 	 * Disable APIC (implies clearing of registers
@@ -189,7 +195,7 @@
  * Check these against your board if the CPUs aren't getting
  * started for no apparent reason.
  */
-int __init verify_local_APIC(void)
+int __init verify_lapic(void)
 {
 	unsigned int reg0, reg1;
 
@@ -279,7 +285,7 @@
 	/*
 	 * Do not trust the local APIC being empty at bootup.
 	 */
-	clear_local_APIC();
+	clear_lapic();
 
 	/*
 	 * Enable APIC.
@@ -304,7 +310,28 @@
 	apic_write_around(APIC_LVT1, value);
 }
 
-void __init setup_local_APIC (void)
+static struct {
+	/* 'active' is true if the local APIC was enabled by us and
+	   not the BIOS; this signifies that we are also responsible
+	   for disabling it before entering apm/acpi suspend */
+	int active;
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
+	unsigned int apic_thmr;
+} apic_pm_state;
+
+void __init setup_lapic (void)
 {
 	unsigned long value, ver, maxlvt;
 
@@ -445,46 +472,24 @@
 			printk("No ESR for 82489DX.\n");
 	}
 
-	if (nmi_watchdog == NMI_LOCAL_APIC)
-		setup_apic_nmi_watchdog();
+	if (nmi_watchdog == NMI_LOCAL_APIC) {
+		enable_lapic_nmi_watchdog();
+	}
+
+	apic_pm_state.active = 1;
 }
 
 #ifdef CONFIG_PM
-
-#include <linux/slab.h>
-#include <linux/pm.h>
-
-static struct {
-	/* 'active' is true if the local APIC was enabled by us and
-	   not the BIOS; this signifies that we are also responsible
-	   for disabling it before entering apm/acpi suspend */
-	int active;
-	/* 'perfctr_pmdev' is here because the current (2.4.1) PM
-	   callback system doesn't handle hierarchical dependencies */
-	struct pm_dev *perfctr_pmdev;
-	/* r/w apic fields */
-	unsigned int apic_id;
-	unsigned int apic_taskpri;
-	unsigned int apic_ldr;
-	unsigned int apic_dfr;
-	unsigned int apic_spiv;
-	unsigned int apic_lvtt;
-	unsigned int apic_lvtpc;
-	unsigned int apic_lvt0;
-	unsigned int apic_lvt1;
-	unsigned int apic_lvterr;
-	unsigned int apic_tmict;
-	unsigned int apic_tdcr;
-	unsigned int apic_thmr;
-} apic_pm_state;
-
-static void apic_pm_suspend(void *data)
+static int lapic_suspend(struct device *dev, u32 state, u32 level)
 {
 	unsigned int l, h;
 	unsigned long flags;
 
-	if (apic_pm_state.perfctr_pmdev)
-		pm_send(apic_pm_state.perfctr_pmdev, PM_SUSPEND, data);
+	if (level != SUSPEND_POWER_DOWN)
+		return 0;
+	if (!apic_pm_state.active)
+		return 0;
+
 	apic_pm_state.apic_id = apic_read(APIC_ID);
 	apic_pm_state.apic_taskpri = apic_read(APIC_TASKPRI);
 	apic_pm_state.apic_ldr = apic_read(APIC_LDR);
@@ -500,18 +505,26 @@
 	apic_pm_state.apic_thmr = apic_read(APIC_LVTTHMR);
 	
 	local_irq_save(flags);
-	disable_local_APIC();
+	disable_lapic();
 	rdmsr(MSR_IA32_APICBASE, l, h);
 	l &= ~MSR_IA32_APICBASE_ENABLE;
 	wrmsr(MSR_IA32_APICBASE, l, h);
 	local_irq_restore(flags);
+	return 0;
 }
 
-static void apic_pm_resume(void *data)
+static int lapic_resume(struct device *dev, u32 level)
 {
 	unsigned int l, h;
 	unsigned long flags;
 
+	if (level != RESUME_POWER_ON)
+		return 0;
+	if (!apic_pm_state.active)
+		return 0;
+
+	set_fixmap_nocache(FIX_APIC_BASE, APIC_DEFAULT_PHYS_BASE);	/* FIXME: this is needed for S3 resume, but why? */
+
 	local_irq_save(flags);
 	rdmsr(MSR_IA32_APICBASE, l, h);
 	l &= ~MSR_IA32_APICBASE_BASE;
@@ -536,74 +549,35 @@
 	apic_write(APIC_ESR, 0);
 	apic_read(APIC_ESR);
 	local_irq_restore(flags);
-	if (apic_pm_state.perfctr_pmdev)
-		pm_send(apic_pm_state.perfctr_pmdev, PM_RESUME, data);
-}
-
-static int apic_pm_callback(struct pm_dev *dev, pm_request_t rqst, void *data)
-{
-	switch (rqst) {
-	case PM_SUSPEND:
-		apic_pm_suspend(data);
-		break;
-	case PM_RESUME:
-		apic_pm_resume(data);
-		break;
-	}
 	return 0;
 }
 
-/* perfctr driver should call this instead of pm_register() */
-struct pm_dev *apic_pm_register(pm_dev_t type,
-				unsigned long id,
-				pm_callback callback)
-{
-	struct pm_dev *dev;
-
-	if (!apic_pm_state.active)
-		return pm_register(type, id, callback);
-	if (apic_pm_state.perfctr_pmdev)
-		return NULL;	/* we're busy */
-	dev = kmalloc(sizeof(struct pm_dev), GFP_KERNEL);
-	if (dev) {
-		memset(dev, 0, sizeof(*dev));
-		dev->type = type;
-		dev->id = id;
-		dev->callback = callback;
-		apic_pm_state.perfctr_pmdev = dev;
-	}
-	return dev;
-}
-
-/* perfctr driver should call this instead of pm_unregister() */
-void apic_pm_unregister(struct pm_dev *dev)
-{
-	if (!apic_pm_state.active) {
-		pm_unregister(dev);
-	} else if (dev == apic_pm_state.perfctr_pmdev) {
-		apic_pm_state.perfctr_pmdev = NULL;
-		kfree(dev);
-	}
-}
-
-static void __init apic_pm_init1(void)
-{
-	/* can't pm_register() at this early stage in the boot process
-	   (causes an immediate reboot), so just set the flag */
-	apic_pm_state.active = 1;
-}
+static struct device_driver lapic_driver = {
+	.name		= "apic",
+	.bus		= &system_bus_type,
+	.resume		= lapic_resume,
+	.suspend	= lapic_suspend,
+};
+
+/* not static, needed by child devices */
+struct sys_device device_lapic = {
+	.name		= "apic",
+	.id		= 0,
+	.dev		= {
+		.name	= "lapic",
+		.driver	= &lapic_driver,
+	},
+};
 
-static void __init apic_pm_init2(void)
+static int __init init_apic_devicefs(void)
 {
+	driver_register(&lapic_driver);
 	if (apic_pm_state.active)
-		pm_register(PM_SYS_DEV, 0, apic_pm_callback);
+		return sys_device_register(&device_lapic);
+	return 0;
 }
 
-#else	/* CONFIG_PM */
-
-static inline void apic_pm_init1(void) { }
-static inline void apic_pm_init2(void) { }
-
+device_initcall(init_apic_devicefs);
 #endif	/* CONFIG_PM */
 
 /*
@@ -669,9 +643,6 @@
 		nmi_watchdog = NMI_LOCAL_APIC;
 
 	printk("Found and enabled local APIC!\n");
-
-	apic_pm_init1();
-
 	return 0;
 
 no_apic:
@@ -682,7 +653,6 @@
 void __init init_apic_mappings(void)
 {
 	unsigned long apic_phys;
-
 	/*
 	 * If no local APIC can be found then set up a fake all
 	 * zeroes page to simulate the local APIC and another
@@ -1149,15 +1119,12 @@
 		return -1;
 	}
 
-	verify_local_APIC();
-
+	verify_lapic();
 	connect_bsp_APIC();
 
 	phys_cpu_present_map = 1 << boot_cpu_physical_apicid;
 
-	apic_pm_init2();
-
-	setup_local_APIC();
+	setup_lapic();
 
 	if (nmi_watchdog == NMI_LOCAL_APIC)
 		check_nmi_watchdog();
Index: linux/arch/i386/kernel/apm.c
===================================================================
--- linux.orig/arch/i386/kernel/apm.c	2003-03-27 11:09:19.000000000 +0100
+++ linux/arch/i386/kernel/apm.c	2003-03-19 13:36:43.000000000 +0100
@@ -221,6 +221,7 @@
 #include <linux/kernel.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
+#include <linux/device.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -1237,6 +1238,10 @@
 		}
 		printk(KERN_CRIT "apm: suspend was vetoed, but suspending anyway.\n");
 	}
+
+	
+	device_suspend(3, SUSPEND_POWER_DOWN);
+
 	/* serialize with the timer interrupt */
 	write_seqlock_irq(&xtime_lock);
 
@@ -1257,6 +1262,7 @@
 	if (err != APM_SUCCESS)
 		apm_error("suspend", err);
 	err = (err == APM_SUCCESS) ? 0 : -EIO;
+	device_resume(RESUME_POWER_ON);
 	pm_send_all(PM_RESUME, (void *)0);
 	queue_event(APM_NORMAL_RESUME, NULL);
  out:
@@ -1370,6 +1376,7 @@
 				write_seqlock_irq(&xtime_lock);
 				set_time();
 				write_sequnlock_irq(&xtime_lock);
+				device_resume(RESUME_POWER_ON);
 				pm_send_all(PM_RESUME, (void *)0);
 				queue_event(event, NULL);
 			}
Index: linux/arch/i386/kernel/i386_ksyms.c
===================================================================
--- linux.orig/arch/i386/kernel/i386_ksyms.c	2003-03-27 11:09:19.000000000 +0100
+++ linux/arch/i386/kernel/i386_ksyms.c	2003-03-18 17:22:21.000000000 +0100
@@ -163,10 +163,6 @@
 EXPORT_SYMBOL(flush_tlb_page);
 #endif
 
-#if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_PM)
-EXPORT_SYMBOL_GPL(set_nmi_pm_callback);
-EXPORT_SYMBOL_GPL(unset_nmi_pm_callback);
-#endif
 #ifdef CONFIG_X86_IO_APIC
 EXPORT_SYMBOL(IO_APIC_get_PCI_irq_vector);
 #endif
Index: linux/arch/i386/kernel/io_apic.c
===================================================================
--- linux.orig/arch/i386/kernel/io_apic.c	2003-03-27 11:09:19.000000000 +0100
+++ linux/arch/i386/kernel/io_apic.c	2003-03-27 10:41:20.000000000 +0100
@@ -1245,8 +1245,11 @@
 	enable_8259A_irq(0);
 }
 
-static inline void UNEXPECTED_IO_APIC(void)
+static void __init unexpected_IO_APIC(void)
 {
+	printk(KERN_WARNING "INFO: unexpected IO-APIC, please file a report at\n");
+	printk(KERN_WARNING "      http://bugzilla.kernel.org\n");
+	printk(KERN_WARNING "      if your kernel is less than 3 months old.\n");
 }
 
 void __init print_IO_APIC(void)
@@ -1284,7 +1287,7 @@
 	printk(KERN_DEBUG ".......    : Delivery Type: %X\n", reg_00.delivery_type);
 	printk(KERN_DEBUG ".......    : LTS          : %X\n", reg_00.LTS);
 	if (reg_00.__reserved_0 || reg_00.__reserved_1 || reg_00.__reserved_2)
-		UNEXPECTED_IO_APIC();
+		unexpected_IO_APIC();
 
 	printk(KERN_DEBUG ".... register #01: %08X\n", *(int *)&reg_01);
 	printk(KERN_DEBUG ".......     : max redirection entries: %04X\n", reg_01.entries);
@@ -1296,7 +1299,7 @@
 		(reg_01.entries != 0x2E) &&
 		(reg_01.entries != 0x3F)
 	)
-		UNEXPECTED_IO_APIC();
+		unexpected_IO_APIC();
 
 	printk(KERN_DEBUG ".......     : PRQ implemented: %X\n", reg_01.PRQ);
 	printk(KERN_DEBUG ".......     : IO APIC version: %04X\n", reg_01.version);
@@ -1306,15 +1309,15 @@
 		(reg_01.version != 0x13) && /* Xeon IO-APICs */
 		(reg_01.version != 0x20)    /* Intel P64H (82806 AA) */
 	)
-		UNEXPECTED_IO_APIC();
+		unexpected_IO_APIC();
 	if (reg_01.__reserved_1 || reg_01.__reserved_2)
-		UNEXPECTED_IO_APIC();
+		unexpected_IO_APIC();
 
 	if (reg_01.version >= 0x10) {
 		printk(KERN_DEBUG ".... register #02: %08X\n", *(int *)&reg_02);
 		printk(KERN_DEBUG ".......     : arbitration: %02X\n", reg_02.arbitration);
 		if (reg_02.__reserved_1 || reg_02.__reserved_2)
-			UNEXPECTED_IO_APIC();
+			unexpected_IO_APIC();
 	}
 
 	printk(KERN_DEBUG ".... IRQ redirection table:\n");
Index: linux/arch/i386/kernel/nmi.c
===================================================================
--- linux.orig/arch/i386/kernel/nmi.c	2003-03-27 11:09:19.000000000 +0100
+++ linux/arch/i386/kernel/nmi.c	2003-03-16 18:51:05.000000000 +0100
@@ -9,6 +9,8 @@
  *  Mikael Pettersson	: AMD K7 support for local APIC NMI watchdog.
  *  Mikael Pettersson	: Power Management for local APIC NMI watchdog.
  *  Mikael Pettersson	: Pentium 4 support for local APIC NMI watchdog.
+ *  Pavel Machek and
+ *  Mikael Pettersson	: PM converted to driver model. disable/enable API.
  */
 
 #include <linux/config.h>
@@ -20,6 +22,8 @@
 #include <linux/interrupt.h>
 #include <linux/mc146818rtc.h>
 #include <linux/kernel_stat.h>
+#include <linux/device.h>
+#include <linux/module.h>
 
 #include <asm/smp.h>
 #include <asm/mtrr.h>
@@ -29,6 +33,7 @@
 static unsigned int nmi_hz = HZ;
 unsigned int nmi_perfctr_msr;	/* the MSR to reset in NMI handler */
 extern void show_registers(struct pt_regs *regs);
+static int nmi_active;
 
 #define K7_EVNTSEL_ENABLE	(1 << 22)
 #define K7_EVNTSEL_INT		(1 << 20)
@@ -117,7 +122,7 @@
 	 */
 	if ((nmi == NMI_LOCAL_APIC) &&
 			(boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) &&
-			(boot_cpu_data.x86 == 6 || boot_cpu_data.x86 == 15))
+	  		(boot_cpu_data.x86 == 6 || boot_cpu_data.x86 == 15))
 		nmi_watchdog = nmi;
 	if ((nmi == NMI_LOCAL_APIC) &&
 			(boot_cpu_data.x86_vendor == X86_VENDOR_AMD) &&
@@ -134,14 +139,11 @@
 
 __setup("nmi_watchdog=", setup_nmi_watchdog);
 
-#ifdef CONFIG_PM
-
-#include <linux/pm.h>
-
-struct pm_dev *nmi_pmdev;
 
-static void disable_apic_nmi_watchdog(void)
+void disable_lapic_nmi_watchdog(void)
 {
+	if (!nmi_active)
+		return;
 	switch (boot_cpu_data.x86_vendor) {
 	case X86_VENDOR_AMD:
 		wrmsr(MSR_K7_EVNTSEL0, 0, 0);
@@ -158,46 +160,60 @@
 		}
 		break;
 	}
+	nmi_active = 0;
 }
 
-static int nmi_pm_callback(struct pm_dev *dev, pm_request_t rqst, void *data)
+#ifdef CONFIG_PM
+
+static int nmi_suspend(struct device *dev, u32 state, u32 level)
 {
-	switch (rqst) {
-	case PM_SUSPEND:
-		disable_apic_nmi_watchdog();
-		break;
-	case PM_RESUME:
-		setup_apic_nmi_watchdog();
-		break;
-	}
+	if (level != SUSPEND_POWER_DOWN)
+		return 0;
+
+	disable_lapic_nmi_watchdog();
 	return 0;
 }
 
-struct pm_dev * set_nmi_pm_callback(pm_callback callback)
+static int nmi_resume(struct device *dev, u32 level)
 {
-	apic_pm_unregister(nmi_pmdev);
-	return apic_pm_register(PM_SYS_DEV, 0, callback);
-}
+	if (level != RESUME_POWER_ON)
+		return 0;
 
-void unset_nmi_pm_callback(struct pm_dev * dev)
-{
-	apic_pm_unregister(dev);
-	nmi_pmdev = apic_pm_register(PM_SYS_DEV, 0, nmi_pm_callback);
-}
- 
-static void nmi_pm_init(void)
-{
-	if (!nmi_pmdev)
-		nmi_pmdev = apic_pm_register(PM_SYS_DEV, 0, nmi_pm_callback);
+	if (nmi_watchdog == NMI_LOCAL_APIC)
+		enable_lapic_nmi_watchdog();
+
+	return 0;
 }
 
-#define __pminit	/*empty*/
 
-#else	/* CONFIG_PM */
+static struct device_driver nmi_driver = {
+	.name		= "lapic_nmi",
+	.bus		= &system_bus_type,
+	.resume		= nmi_resume,
+	.suspend	= nmi_suspend,
+};
+
+static struct sys_device device_nmi = {
+	.name	= "lapic_nmi",
+	.id	= 0,
+	.dev	= {
+		.name = "lapic_nmi",
+		.driver = &nmi_driver,
+		.parent = &device_lapic.dev,
+	}
+};
+
+extern struct sys_device device_apic;
 
-static inline void nmi_pm_init(void) { }
+static int __init init_nmi_devicefs(void)
+{
+	if (nmi_watchdog == NMI_LOCAL_APIC) {
+		driver_register(&nmi_driver);
+		return sys_device_register(&device_nmi);
+	}
+}
 
-#define __pminit	__init
+late_initcall(init_nmi_devicefs);
 
 #endif	/* CONFIG_PM */
 
@@ -206,7 +222,7 @@
  * Original code written by Keith Owens.
  */
 
-static void __pminit clear_msr_range(unsigned int base, unsigned int n)
+static void clear_msr_range(unsigned int base, unsigned int n)
 {
 	unsigned int i;
 
@@ -214,7 +230,7 @@
 		wrmsr(base+i, 0, 0);
 }
 
-static void __pminit setup_k7_watchdog(void)
+static void setup_k7_watchdog(void)
 {
 	unsigned int evntsel;
 
@@ -236,7 +252,7 @@
 	wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
 }
 
-static void __pminit setup_p6_watchdog(void)
+static void setup_p6_watchdog(void)
 {
 	unsigned int evntsel;
 
@@ -258,7 +274,7 @@
 	wrmsr(MSR_P6_EVNTSEL0, evntsel, 0);
 }
 
-static int __pminit setup_p4_watchdog(void)
+static int setup_p4_watchdog(void)
 {
 	unsigned int misc_enable, dummy;
 
@@ -288,7 +304,7 @@
 	return 1;
 }
 
-void __pminit setup_apic_nmi_watchdog (void)
+void enable_lapic_nmi_watchdog (void)
 {
 	switch (boot_cpu_data.x86_vendor) {
 	case X86_VENDOR_AMD:
@@ -312,7 +328,7 @@
 	default:
 		return;
 	}
-	nmi_pm_init();
+	nmi_active = 1;
 }
 
 static spinlock_t nmi_print_lock = SPIN_LOCK_UNLOCKED;
@@ -400,3 +416,7 @@
 		wrmsr(nmi_perfctr_msr, -(cpu_khz/nmi_hz*1000), -1);
 	}
 }
+
+EXPORT_SYMBOL(nmi_watchdog);
+EXPORT_SYMBOL(enable_lapic_nmi_watchdog);
+EXPORT_SYMBOL(disable_lapic_nmi_watchdog);
Index: linux/arch/i386/oprofile/nmi_int.c
===================================================================
--- linux.orig/arch/i386/oprofile/nmi_int.c	2003-03-27 11:09:20.000000000 +0100
+++ linux/arch/i386/oprofile/nmi_int.c	2003-03-18 17:22:21.000000000 +0100
@@ -11,6 +11,7 @@
 #include <linux/notifier.h>
 #include <linux/smp.h>
 #include <linux/oprofile.h>
+#include <linux/device.h>
 #include <asm/nmi.h>
 #include <asm/msr.h>
 #include <asm/apic.h>
@@ -24,27 +25,6 @@
  
 static int nmi_start(void);
 static void nmi_stop(void);
-
-static struct pm_dev * oprofile_pmdev;
- 
-/* We're at risk of causing big trouble unless we
- * make sure to not cause any NMI interrupts when
- * suspended.
- */
-static int oprofile_pm_callback(struct pm_dev * dev,
-		pm_request_t rqst, void * data)
-{
-	switch (rqst) {
-		case PM_SUSPEND:
-			nmi_stop();
-			break;
-		case PM_RESUME:
-			nmi_start();
-			break;
-	}
-	return 0;
-}
- 
  
 static int nmi_callback(struct pt_regs * regs, int cpu)
 {
@@ -86,7 +66,41 @@
 	saved_lvtpc[cpu] = apic_read(APIC_LVTPC);
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
 }
- 
+
+static int nmi_enabled = 0;	/* 0 == registered but off, 1 == registered and on */
+
+static int nmi_suspend(struct device *dev, u32 state, u32 level)
+{
+	if (level != SUSPEND_POWER_DOWN)
+		return 0;
+	if (nmi_enabled == 1)
+		nmi_stop();
+	return 0;
+}
+
+static int nmi_resume(struct device *dev, u32 level)
+{
+	if (level != RESUME_POWER_ON)
+		return 0;
+	if (nmi_enabled == 1)
+		nmi_start();
+	return 0;
+}
+
+
+static struct device_driver nmi_driver = {
+	.name		= "oprofile",
+	.bus		= &system_bus_type,
+	.resume		= nmi_resume,
+	.suspend	= nmi_suspend,
+};
+
+static struct device device_nmi = {
+	.name	= "oprofile",
+	.bus_id = "oprofile",
+	.driver	= &nmi_driver,
+	.parent = &device_lapic,
+};
 
 static int nmi_setup(void)
 {
@@ -95,12 +109,26 @@
 	 * without actually triggering any NMIs as this will
 	 * break the core code horrifically.
 	 */
+	if (nmi_watchdog == NMI_LOCAL_APIC) {
+		disable_lapic_nmi_watchdog();
+		nmi_watchdog = NMI_LOCAL_APIC_SUSPENDED_BY_OPROFILE;
+	}
 	on_each_cpu(nmi_cpu_setup, NULL, 0, 1);
 	set_nmi_callback(nmi_callback);
-	oprofile_pmdev = set_nmi_pm_callback(oprofile_pm_callback);
-	return 0;
+	nmi_enabled = 1;
+        return 0;
+}
+
+static int __init init_nmi_driverfs(void)
+{
+	if (nmi_watchdog == NMI_LOCAL_APIC) {
+		printk("Registering oprofile-nmi\n");
+		driver_register(&nmi_driver);
+		device_register(&device_nmi);
+	}
 }
 
+late_initcall(init_nmi_driverfs);
 
 static void nmi_restore_registers(struct op_msrs * msrs)
 {
@@ -145,9 +173,13 @@
  
 static void nmi_shutdown(void)
 {
-	unset_nmi_pm_callback(oprofile_pmdev);
+	nmi_enabled = 0;
 	unset_nmi_callback();
 	on_each_cpu(nmi_cpu_shutdown, NULL, 0, 1);
+	if (nmi_watchdog == NMI_LOCAL_APIC_SUSPENDED_BY_OPROFILE) {
+		nmi_watchdog = NMI_LOCAL_APIC;
+		enable_lapic_nmi_watchdog();
+	}
 }
 
  
Index: linux/include/asm-i386/apic.h
===================================================================
--- linux.orig/include/asm-i386/apic.h	2003-03-27 11:09:20.000000000 +0100
+++ linux/include/asm-i386/apic.h	2003-03-16 18:51:05.000000000 +0100
@@ -78,7 +78,8 @@
 extern void smp_local_timer_interrupt (struct pt_regs * regs);
 extern void setup_boot_APIC_clock (void);
 extern void setup_secondary_APIC_clock (void);
-extern void setup_apic_nmi_watchdog (void);
+extern void enable_lapic_nmi_watchdog (void);
+extern void disable_lapic_nmi_watchdog (void);
 extern inline void nmi_watchdog_tick (struct pt_regs * regs);
 extern int APIC_init_uniprocessor (void);
 extern void disable_APIC_timer(void);
@@ -95,6 +96,9 @@
 #define NMI_IO_APIC	1
 #define NMI_LOCAL_APIC	2
 #define NMI_INVALID	3
+#define NMI_LOCAL_APIC_SUSPENDED_BY_OPROFILE	4
+
+extern struct sys_device device_lapic;
 
 #endif /* CONFIG_X86_LOCAL_APIC */
 

%diffstat
 arch/i386/kernel/apic.c       |  189 +++++++++++++++++-------------------------
 arch/i386/kernel/apm.c        |    7 +
 arch/i386/kernel/i386_ksyms.c |    4 
 arch/i386/kernel/io_apic.c    |   15 ++-
 arch/i386/kernel/nmi.c        |  100 +++++++++++++---------
 arch/i386/oprofile/nmi_int.c  |   82 ++++++++++++------
 include/asm-i386/apic.h       |    6 +
 7 files changed, 216 insertions(+), 187 deletions(-)


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
