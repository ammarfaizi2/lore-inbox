Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267209AbTBILXd>; Sun, 9 Feb 2003 06:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267212AbTBILXd>; Sun, 9 Feb 2003 06:23:33 -0500
Received: from [195.39.17.254] ([195.39.17.254]:8452 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267209AbTBILXW>;
	Sun, 9 Feb 2003 06:23:22 -0500
Date: Sun, 9 Feb 2003 12:32:01 +0100
From: Pavel Machek <pavel@ucw.cz>
To: levon@movementarian.org, kernel list <linux-kernel@vger.kernel.org>
Subject: Switch APIC (+nmi, +oprofile) to driver model
Message-ID: <20030209113201.GA1296@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Here's next attempt at moving APIC (+nmi, +oprofile) to the driver
model. If it looks good I'l submit it to Linus.

								Pavel

--- clean/arch/i386/kernel/apic.c	2003-01-05 22:58:18.000000000 +0100
+++ linux-swsusp/arch/i386/kernel/apic.c	2003-02-03 16:36:41.000000000 +0100
@@ -10,6 +10,7 @@
  *					for testing these extensively.
  *	Maciej W. Rozycki	:	Various updates and fixes.
  *	Mikael Pettersson	:	Power Management for UP-APIC.
+ *	Pavel Machek		:	Converted to driver model.
  */
 
 #include <linux/config.h>
@@ -23,6 +24,10 @@
 #include <linux/interrupt.h>
 #include <linux/mc146818rtc.h>
 #include <linux/kernel_stat.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/device.h>
+#include <linux/pm.h>
 
 #include <asm/atomic.h>
 #include <asm/smp.h>
@@ -54,6 +59,8 @@
 int prof_old_multiplier[NR_CPUS] = { 1, };
 int prof_counter[NR_CPUS] = { 1, };
 
+unsigned long apic_phys;
+
 int get_maxlvt(void)
 {
 	unsigned int v, ver, maxlvt;
@@ -292,6 +299,27 @@
 	apic_write_around(APIC_LVT1, value);
 }
 
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
 void __init setup_local_APIC (void)
 {
 	unsigned long value, ver, maxlvt;
@@ -435,44 +463,19 @@
 
 	if (nmi_watchdog == NMI_LOCAL_APIC)
 		setup_apic_nmi_watchdog();
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
+static int apic_suspend(struct device *dev, u32 state, u32 level)
 {
 	unsigned int l, h;
 	unsigned long flags;
 
-	if (apic_pm_state.perfctr_pmdev)
-		pm_send(apic_pm_state.perfctr_pmdev, PM_SUSPEND, data);
+	if (level != SUSPEND_DISABLE)
+		return 0;
+
 	apic_pm_state.apic_id = apic_read(APIC_ID);
 	apic_pm_state.apic_taskpri = apic_read(APIC_TASKPRI);
 	apic_pm_state.apic_ldr = apic_read(APIC_LDR);
@@ -493,13 +496,19 @@
 	l &= ~MSR_IA32_APICBASE_ENABLE;
 	wrmsr(MSR_IA32_APICBASE, l, h);
 	local_irq_restore(flags);
+	return 0;
 }
 
-static void apic_pm_resume(void *data)
+static int apic_resume(struct device *dev, u32 level)
 {
 	unsigned int l, h;
 	unsigned long flags;
 
+	if (level != RESUME_POWER_ON)
+		return 0;
+
+	set_fixmap_nocache(FIX_APIC_BASE, apic_phys);		/* FIXME: this is needed for S3 resume, but why? */
+
 	local_irq_save(flags);
 	rdmsr(MSR_IA32_APICBASE, l, h);
 	l &= ~MSR_IA32_APICBASE_BASE;
@@ -524,74 +533,34 @@
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
+static struct device_driver apic_driver = {
+	.name		= "apic",
+	.bus		= &system_bus_type,
+	.resume		= apic_resume,
+	.suspend	= apic_suspend,
+};
+
+struct sys_device device_apic = {
+	.name		= "apic",
+	.id		= 0,
+	.dev		= {
+		.name	= "APIC",
+		.driver	= &apic_driver,
+	},
+};
 
-static void __init apic_pm_init1(void)
-{
-	/* can't pm_register() at this early stage in the boot process
-	   (causes an immediate reboot), so just set the flag */
-	apic_pm_state.active = 1;
-}
-
-static void __init apic_pm_init2(void)
+static int __init init_apic_devicefs(void)
 {
+	driver_register(&apic_driver);
 	if (apic_pm_state.active)
-		pm_register(PM_SYS_DEV, 0, apic_pm_callback);
+		return sys_device_register(&device_apic);
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
@@ -658,9 +627,6 @@
 		nmi_watchdog = NMI_LOCAL_APIC;
 
 	printk("Found and enabled local APIC!\n");
-
-	apic_pm_init1();
-
 	return 0;
 
 no_apic:
@@ -670,8 +636,6 @@
 
 void __init init_apic_mappings(void)
 {
-	unsigned long apic_phys;
-
 	/*
 	 * If no local APIC can be found then set up a fake all
 	 * zeroes page to simulate the local APIC and another
@@ -1141,8 +1105,6 @@
 	phys_cpu_present_map = 1;
 	apic_write_around(APIC_ID, boot_cpu_physical_apicid);
 
-	apic_pm_init2();
-
 	setup_local_APIC();
 
 	if (nmi_watchdog == NMI_LOCAL_APIC)
--- clean/arch/i386/kernel/apm.c	2003-01-09 22:16:11.000000000 +0100
+++ linux-swsusp/arch/i386/kernel/apm.c	2003-01-28 10:35:51.000000000 +0100
@@ -1263,6 +1263,11 @@
 		}
 		printk(KERN_CRIT "apm: suspend was vetoed, but suspending anyway.\n");
 	}
+
+	device_suspend(3, SUSPEND_NOTIFY);
+	device_suspend(3, SUSPEND_SAVE_STATE);
+	device_suspend(3, SUSPEND_DISABLE);
+
 	/* serialize with the timer interrupt */
 	write_lock_irq(&xtime_lock);
 
@@ -1283,6 +1288,8 @@
 	if (err != APM_SUCCESS)
 		apm_error("suspend", err);
 	err = (err == APM_SUCCESS) ? 0 : -EIO;
+	device_resume(RESUME_RESTORE_STATE);
+	device_resume(RESUME_ENABLE);
 	pm_send_all(PM_RESUME, (void *)0);
 	queue_event(APM_NORMAL_RESUME, NULL);
  out:
@@ -1396,6 +1403,8 @@
 				write_lock_irq(&xtime_lock);
 				set_time();
 				write_unlock_irq(&xtime_lock);
+				device_resume(RESUME_RESTORE_STATE);
+				device_resume(RESUME_ENABLE);
 				pm_send_all(PM_RESUME, (void *)0);
 				queue_event(event, NULL);
 			}
--- clean/arch/i386/kernel/i386_ksyms.c	2003-01-17 23:09:51.000000000 +0100
+++ linux-swsusp/arch/i386/kernel/i386_ksyms.c	2003-01-19 19:58:34.000000000 +0100
@@ -161,10 +161,6 @@
 EXPORT_SYMBOL(flush_tlb_page);
 #endif
 
-#if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_PM)
-EXPORT_SYMBOL_GPL(set_nmi_pm_callback);
-EXPORT_SYMBOL_GPL(unset_nmi_pm_callback);
-#endif
 #ifdef CONFIG_X86_IO_APIC
 EXPORT_SYMBOL(IO_APIC_get_PCI_irq_vector);
 #endif
--- clean/arch/i386/kernel/nmi.c	2003-01-05 22:58:19.000000000 +0100
+++ linux-swsusp/arch/i386/kernel/nmi.c	2003-02-09 11:43:29.000000000 +0100
@@ -9,6 +9,7 @@
  *  Mikael Pettersson	: AMD K7 support for local APIC NMI watchdog.
  *  Mikael Pettersson	: Power Management for local APIC NMI watchdog.
  *  Mikael Pettersson	: Pentium 4 support for local APIC NMI watchdog.
+ *  Pavel Machek	: Driver model here, too.
  */
 
 #include <linux/config.h>
@@ -20,6 +21,7 @@
 #include <linux/interrupt.h>
 #include <linux/mc146818rtc.h>
 #include <linux/kernel_stat.h>
+#include <linux/device.h>
 
 #include <asm/smp.h>
 #include <asm/mtrr.h>
@@ -29,6 +31,7 @@
 static unsigned int nmi_hz = HZ;
 unsigned int nmi_perfctr_msr;	/* the MSR to reset in NMI handler */
 extern void show_registers(struct pt_regs *regs);
+static int nmi_active;
 
 #define K7_EVNTSEL_ENABLE	(1 << 22)
 #define K7_EVNTSEL_INT		(1 << 20)
@@ -118,10 +121,6 @@
 	 * missing bits. Right now Intel P6/P4 and AMD K7 only.
 	 */
 	if ((nmi == NMI_LOCAL_APIC) &&
-			(boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) &&
-			(boot_cpu_data.x86 == 6 || boot_cpu_data.x86 == 15))
-		nmi_watchdog = nmi;
-	if ((nmi == NMI_LOCAL_APIC) &&
 			(boot_cpu_data.x86_vendor == X86_VENDOR_AMD) &&
 	  		(boot_cpu_data.x86 == 6 || boot_cpu_data.x86 == 15))
 		nmi_watchdog = nmi;
@@ -136,14 +135,11 @@
 
 __setup("nmi_watchdog=", setup_nmi_watchdog);
 
-#ifdef CONFIG_PM
-
-#include <linux/pm.h>
 
-struct pm_dev *nmi_pmdev;
-
-static void disable_apic_nmi_watchdog(void)
+void disable_apic_nmi_watchdog(void)
 {
+	if (!nmi_active)
+		return;
 	switch (boot_cpu_data.x86_vendor) {
 	case X86_VENDOR_AMD:
 		wrmsr(MSR_K7_EVNTSEL0, 0, 0);
@@ -160,47 +156,58 @@
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
+	if (level != SUSPEND_DISABLE)
+		return 0;
+
+	disable_apic_nmi_watchdog();
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
+		setup_apic_nmi_watchdog();
+
+	return 0;
 }
 
-#define __pminit	/*empty*/
 
-#else	/* CONFIG_PM */
+static struct device_driver nmi_driver = {
+	.name		= "nmi",
+	.bus		= &system_bus_type,
+	.resume		= nmi_resume,
+	.suspend	= nmi_suspend,
+};
+
+static struct device device_nmi = {
+	.name	= "NMI",
+	.bus_id = "NMI",
+	.driver	= &nmi_driver,
+};
+
+extern struct sys_device device_apic;
 
-static inline void nmi_pm_init(void) { }
+static int __init init_nmi_devicefs(void)
+{
+	driver_register(&nmi_driver);
+
+	device_nmi.parent = &device_apic.dev;
+        return device_register(&device_nmi);
+}
 
-#define __pminit	__init
+device_initcall(init_nmi_devicefs);
 
+#define __pminit
 #endif	/* CONFIG_PM */
 
 /*
@@ -290,7 +297,7 @@
 	return 1;
 }
 
-void __pminit setup_apic_nmi_watchdog (void)
+void setup_apic_nmi_watchdog (void)
 {
 	switch (boot_cpu_data.x86_vendor) {
 	case X86_VENDOR_AMD:
@@ -314,7 +321,7 @@
 	default:
 		return;
 	}
-	nmi_pm_init();
+	nmi_active = 1;
 }
 
 static spinlock_t nmi_print_lock = SPIN_LOCK_UNLOCKED;
--- clean/arch/i386/oprofile/nmi_int.c	2003-01-05 22:58:19.000000000 +0100
+++ linux-swsusp/arch/i386/oprofile/nmi_int.c	2003-02-09 12:16:52.000000000 +0100
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
@@ -86,7 +66,42 @@
 	saved_lvtpc[cpu] = apic_read(APIC_LVTPC);
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
 }
- 
+
+static int nmi_enabled = 0;	/* 0 == registered but off, 1 == registered and on */
+
+static int nmi_suspend(struct device *dev, u32 state, u32 level)
+{
+	if (level != SUSPEND_DISABLE)
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
+};
+
+extern struct sys_device device_apic;
 
 static int nmi_setup(void)
 {
@@ -95,13 +110,25 @@
 	 * without actually triggering any NMIs as this will
 	 * break the core code horrifically.
 	 */
+	if (nmi_watchdog == NMI_LOCAL_APIC) {
+		disable_apic_nmi_watchdog();
+		nmi_watchdog = NMI_LOCAL_APIC_SUSPENDED_BY_OPROFILE;
+	}
 	smp_call_function(nmi_cpu_setup, NULL, 0, 1);
 	nmi_cpu_setup(0);
 	set_nmi_callback(nmi_callback);
-	oprofile_pmdev = set_nmi_pm_callback(oprofile_pm_callback);
-	return 0;
+	nmi_enabled = 1;
+        return 0;
 }
 
+static int __init init_nmi_driverfs(void)
+{
+	driver_register(&nmi_driver);
+	device_nmi.parent = &device_apic.dev;
+	device_register(&device_nmi);
+}
+
+device_initcall(init_nmi_driverfs);
 
 static void nmi_restore_registers(struct op_msrs * msrs)
 {
@@ -146,10 +173,14 @@
  
 static void nmi_shutdown(void)
 {
-	unset_nmi_pm_callback(oprofile_pmdev);
+	nmi_enabled = 0;
 	unset_nmi_callback();
 	smp_call_function(nmi_cpu_shutdown, NULL, 0, 1);
 	nmi_cpu_shutdown(0);
+	if (nmi_watchdog == NMI_LOCAL_APIC_SUSPENDED_BY_OPROFILE) {
+		nmi_watchdog = NMI_LOCAL_APIC_SUSPENDED_BY_OPROFILE;
+		setup_apic_nmi_watchdog();
+	}
 }
 
  
@@ -217,9 +248,9 @@
  
 int __init nmi_init(struct oprofile_operations ** ops, enum oprofile_cpu * cpu)
 {
-	__u8 vendor = current_cpu_data.x86_vendor;
-	__u8 family = current_cpu_data.x86;
-	__u8 cpu_model = current_cpu_data.x86_model;
+	u8 vendor = current_cpu_data.x86_vendor;
+	u8 family = current_cpu_data.x86;
+	u8 cpu_model = current_cpu_data.x86_model;
  
 	if (!cpu_has_apic)
 		return 0;
--- clean/include/asm-i386/apic.h	2002-10-20 16:22:45.000000000 +0200
+++ linux-swsusp/include/asm-i386/apic.h	2003-02-09 11:46:09.000000000 +0100
@@ -95,6 +95,7 @@
 #define NMI_IO_APIC	1
 #define NMI_LOCAL_APIC	2
 #define NMI_INVALID	3
+#define NMI_LOCAL_APIC_SUSPENDED_BY_OPROFILE	4
 
 #endif /* CONFIG_X86_LOCAL_APIC */
 

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
