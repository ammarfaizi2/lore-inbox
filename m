Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267273AbTATW2l>; Mon, 20 Jan 2003 17:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267310AbTATW2l>; Mon, 20 Jan 2003 17:28:41 -0500
Received: from [195.39.17.254] ([195.39.17.254]:20740 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267273AbTATW2g>;
	Mon, 20 Jan 2003 17:28:36 -0500
Date: Mon, 20 Jan 2003 23:25:27 +0100
From: Pavel Machek <pavel@suse.cz>
To: ak@suse.de, kernel list <linux-kernel@vger.kernel.org>,
       torvalds@transmeta.com
Subject: Switch APIC to driver model (and make S3 sleep with APIC on)
Message-ID: <20030120222526.GA541@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This switches apic code to driver model, cleans code up a lot, and
makes S3 while apic is used work. Please apply,
							Pavel

--- clean/arch/i386/kernel/apic.c	2003-01-05 22:58:18.000000000 +0100
+++ linux-swsusp/arch/i386/kernel/apic.c	2003-01-20 23:19:50.000000000 +0100
@@ -54,6 +55,8 @@
 int prof_old_multiplier[NR_CPUS] = { 1, };
 int prof_counter[NR_CPUS] = { 1, };
 
+unsigned long apic_phys;
+
 int get_maxlvt(void)
 {
 	unsigned int v, ver, maxlvt;
@@ -438,8 +441,8 @@
 }
 
 #ifdef CONFIG_PM
-
 #include <linux/slab.h>
+#include <linux/device.h>
 #include <linux/pm.h>
 
 static struct {
@@ -447,9 +450,6 @@
 	   not the BIOS; this signifies that we are also responsible
 	   for disabling it before entering apm/acpi suspend */
 	int active;
-	/* 'perfctr_pmdev' is here because the current (2.4.1) PM
-	   callback system doesn't handle hierarchical dependencies */
-	struct pm_dev *perfctr_pmdev;
 	/* r/w apic fields */
 	unsigned int apic_id;
 	unsigned int apic_taskpri;
@@ -466,13 +466,15 @@
 	unsigned int apic_thmr;
 } apic_pm_state;
 
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
+	disable_apic_nmi_watchdog();
 	apic_pm_state.apic_id = apic_read(APIC_ID);
 	apic_pm_state.apic_taskpri = apic_read(APIC_TASKPRI);
 	apic_pm_state.apic_ldr = apic_read(APIC_LDR);
@@ -493,13 +495,19 @@
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
@@ -524,74 +532,33 @@
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
+	setup_apic_nmi_watchdog();
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
+static struct device_driver apic_driver = {
+	.name		= "apic",
+	.bus		= &system_bus_type,
+	.resume		= apic_resume,
+	.suspend	= apic_suspend,
+};
+
+static struct sys_device device_apic = {
+	.name		= "apic",
+	.id		= 0,
+	.dev		= {
+		.name	= "APIC",
+		.driver	= &apic_driver,
+	},
+};
 
-/* perfctr driver should call this instead of pm_unregister() */
-void apic_pm_unregister(struct pm_dev *dev)
+static int __init init_apic_devicefs(void)
 {
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
-
-static void __init apic_pm_init2(void)
-{
-	if (apic_pm_state.active)
-		pm_register(PM_SYS_DEV, 0, apic_pm_callback);
+	driver_register(&apic_driver);
+	return sys_device_register(&device_apic);
 }
 
-#else	/* CONFIG_PM */
-
-static inline void apic_pm_init1(void) { }
-static inline void apic_pm_init2(void) { }
-
+device_initcall(init_apic_devicefs);
 #endif	/* CONFIG_PM */
 
 /*
@@ -658,9 +625,6 @@
 		nmi_watchdog = NMI_LOCAL_APIC;
 
 	printk("Found and enabled local APIC!\n");
-
-	apic_pm_init1();
-
 	return 0;
 
 no_apic:
@@ -670,8 +634,6 @@
 
 void __init init_apic_mappings(void)
 {
-	unsigned long apic_phys;
-
 	/*
 	 * If no local APIC can be found then set up a fake all
 	 * zeroes page to simulate the local APIC and another
@@ -1141,8 +1103,6 @@
 	phys_cpu_present_map = 1;
 	apic_write_around(APIC_ID, boot_cpu_physical_apicid);
 
-	apic_pm_init2();
-
 	setup_local_APIC();
 
 	if (nmi_watchdog == NMI_LOCAL_APIC)
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
+++ linux-swsusp/arch/i386/kernel/nmi.c	2003-01-19 20:02:27.000000000 +0100
@@ -138,11 +138,7 @@
 
 #ifdef CONFIG_PM
 
-#include <linux/pm.h>
-
-struct pm_dev *nmi_pmdev;
-
-static void disable_apic_nmi_watchdog(void)
+void disable_apic_nmi_watchdog(void)
 {
 	switch (boot_cpu_data.x86_vendor) {
 	case X86_VENDOR_AMD:
@@ -162,45 +158,7 @@
 	}
 }
 
-static int nmi_pm_callback(struct pm_dev *dev, pm_request_t rqst, void *data)
-{
-	switch (rqst) {
-	case PM_SUSPEND:
-		disable_apic_nmi_watchdog();
-		break;
-	case PM_RESUME:
-		setup_apic_nmi_watchdog();
-		break;
-	}
-	return 0;
-}
-
-struct pm_dev * set_nmi_pm_callback(pm_callback callback)
-{
-	apic_pm_unregister(nmi_pmdev);
-	return apic_pm_register(PM_SYS_DEV, 0, callback);
-}
-
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
-}
-
-#define __pminit	/*empty*/
-
-#else	/* CONFIG_PM */
-
-static inline void nmi_pm_init(void) { }
-
-#define __pminit	__init
-
+#define __pminit
 #endif	/* CONFIG_PM */
 
 /*
@@ -314,7 +272,6 @@
 	default:
 		return;
 	}
-	nmi_pm_init();
 }
 
 static spinlock_t nmi_print_lock = SPIN_LOCK_UNLOCKED;

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
