Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262961AbTCSKV7>; Wed, 19 Mar 2003 05:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262966AbTCSKV6>; Wed, 19 Mar 2003 05:21:58 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:5877 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S262961AbTCSKVs>;
	Wed, 19 Mar 2003 05:21:48 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15992.18243.605716.244572@gargle.gargle.HOWL>
Date: Wed, 19 Mar 2003 11:32:35 +0100
From: mikpe@csd.uu.se
To: Andrew Morton <akpm@digeo.com>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: apic-to-drivermodel conversion
In-Reply-To: <20030318161852.41a703a4.akpm@digeo.com>
References: <20030318202858.GA154@elf.ucw.cz>
	<20030318161852.41a703a4.akpm@digeo.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
 > Pavel Machek <pavel@ucw.cz> wrote:
 > >
 > > Hi!
 > > 
 > > This converts apic code to use driver model. It is neccessary for S3
 > > when you are using apic. 
 > 
 > Seems to be missing something.
 > 
 > arch/i386/kernel/apm.c: In function `suspend':
 > arch/i386/kernel/apm.c:1242: warning: implicit declaration of function `device_suspend'
 > arch/i386/kernel/apm.c:1242: `SUSPEND_POWER_DOWN' undeclared (first use in this function)
 > arch/i386/kernel/apm.c:1242: (Each undeclared identifier is reported only once
 > arch/i386/kernel/apm.c:1242: for each function it appears in.)
 > arch/i386/kernel/apm.c:1264: warning: implicit declaration of function `device_resume'
 > arch/i386/kernel/apm.c:1264: `RESUME_POWER_ON' undeclared (first use in this function)
 > arch/i386/kernel/apm.c: In function `check_events':
 > arch/i386/kernel/apm.c:1378: `RESUME_POWER_ON' undeclared (first use in this function)

Try this patch instead. This is my merge of my and Pavel's earlier
patches, so it differs from Pavel's in some details.
My patch works with APM -- I can do repeated synchronous and
asynchronous suspends with it.
I haven't tested oprofile. There are some issues wrt oprofile's
interface with the local-APIC NMI watchdog. Pavel suggested one
(IMHO ugly) workaround, I and John suggested another (viz, an
enable/disable API with one bit of history). My patch implements
that API.

/Mikael

diff -ruN linux-2.5.65/arch/i386/kernel/apic.c linux-2.5.65.apic-driver-model/arch/i386/kernel/apic.c
--- linux-2.5.65/arch/i386/kernel/apic.c	2003-03-08 17:22:31.000000000 +0100
+++ linux-2.5.65.apic-driver-model/arch/i386/kernel/apic.c	2003-03-19 00:54:40.000000000 +0100
@@ -10,6 +10,8 @@
  *					for testing these extensively.
  *	Maciej W. Rozycki	:	Various updates and fixes.
  *	Mikael Pettersson	:	Power Management for UP-APIC.
+ *	Pavel Machek and
+ *	Mikael Pettersson	:	PM converted to driver model.
  */
 
 #include <linux/config.h>
@@ -451,17 +453,14 @@
 
 #ifdef CONFIG_PM
 
-#include <linux/slab.h>
-#include <linux/pm.h>
+#include <linux/device.h>
+#include <linux/module.h>
 
 static struct {
 	/* 'active' is true if the local APIC was enabled by us and
 	   not the BIOS; this signifies that we are also responsible
 	   for disabling it before entering apm/acpi suspend */
 	int active;
-	/* 'perfctr_pmdev' is here because the current (2.4.1) PM
-	   callback system doesn't handle hierarchical dependencies */
-	struct pm_dev *perfctr_pmdev;
 	/* r/w apic fields */
 	unsigned int apic_id;
 	unsigned int apic_taskpri;
@@ -478,13 +477,16 @@
 	unsigned int apic_thmr;
 } apic_pm_state;
 
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
@@ -505,13 +507,22 @@
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
+	/* XXX: Pavel needs this for S3 resume, but can't explain why */
+	set_fixmap_nocache(FIX_APIC_BASE, APIC_DEFAULT_PHYS_BASE);
+
 	local_irq_save(flags);
 	rdmsr(MSR_IA32_APICBASE, l, h);
 	l &= ~MSR_IA32_APICBASE_BASE;
@@ -536,73 +547,45 @@
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
+static struct device_driver lapic_driver = {
+	.name		= "lapic",
+	.bus		= &system_bus_type,
+	.resume		= lapic_resume,
+	.suspend	= lapic_suspend,
+};
+
+/* not static, needed by child devices */
+struct sys_device device_lapic = {
+	.name		= "lapic",
+	.id		= 0,
+	.dev		= {
+		.name	= "lapic",
+		.driver	= &lapic_driver,
+	},
+};
+EXPORT_SYMBOL(device_lapic);
 
-static void __init apic_pm_init1(void)
+static void __init apic_pm_activate(void)
 {
-	/* can't pm_register() at this early stage in the boot process
-	   (causes an immediate reboot), so just set the flag */
 	apic_pm_state.active = 1;
 }
 
-static void __init apic_pm_init2(void)
+static int __init init_lapic_devicefs(void)
 {
-	if (apic_pm_state.active)
-		pm_register(PM_SYS_DEV, 0, apic_pm_callback);
+	if (!cpu_has_apic)
+		return 0;
+	/* XXX: remove suspend/resume procs if !apic_pm_state.active? */
+	driver_register(&lapic_driver);
+	return sys_device_register(&device_lapic);
 }
+device_initcall(init_lapic_devicefs);
 
 #else	/* CONFIG_PM */
 
-static inline void apic_pm_init1(void) { }
-static inline void apic_pm_init2(void) { }
+static inline void apic_pm_activate(void) { }
 
 #endif	/* CONFIG_PM */
 
@@ -670,7 +653,7 @@
 
 	printk("Found and enabled local APIC!\n");
 
-	apic_pm_init1();
+	apic_pm_activate();
 
 	return 0;
 
@@ -1155,8 +1138,6 @@
 
 	phys_cpu_present_map = 1 << boot_cpu_physical_apicid;
 
-	apic_pm_init2();
-
 	setup_local_APIC();
 
 	if (nmi_watchdog == NMI_LOCAL_APIC)
diff -ruN linux-2.5.65/arch/i386/kernel/apm.c linux-2.5.65.apic-driver-model/arch/i386/kernel/apm.c
--- linux-2.5.65/arch/i386/kernel/apm.c	2003-03-08 17:22:31.000000000 +0100
+++ linux-2.5.65.apic-driver-model/arch/i386/kernel/apm.c	2003-03-19 00:54:31.000000000 +0100
@@ -218,6 +218,7 @@
 #include <linux/time.h>
 #include <linux/sched.h>
 #include <linux/pm.h>
+#include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
@@ -1237,6 +1238,9 @@
 		}
 		printk(KERN_CRIT "apm: suspend was vetoed, but suspending anyway.\n");
 	}
+
+	device_suspend(3, SUSPEND_POWER_DOWN);
+
 	/* serialize with the timer interrupt */
 	write_seqlock_irq(&xtime_lock);
 
@@ -1257,6 +1261,7 @@
 	if (err != APM_SUCCESS)
 		apm_error("suspend", err);
 	err = (err == APM_SUCCESS) ? 0 : -EIO;
+	device_resume(RESUME_POWER_ON);
 	pm_send_all(PM_RESUME, (void *)0);
 	queue_event(APM_NORMAL_RESUME, NULL);
  out:
@@ -1370,6 +1375,7 @@
 				write_seqlock_irq(&xtime_lock);
 				set_time();
 				write_sequnlock_irq(&xtime_lock);
+				device_resume(RESUME_POWER_ON);
 				pm_send_all(PM_RESUME, (void *)0);
 				queue_event(event, NULL);
 			}
diff -ruN linux-2.5.65/arch/i386/kernel/i386_ksyms.c linux-2.5.65.apic-driver-model/arch/i386/kernel/i386_ksyms.c
--- linux-2.5.65/arch/i386/kernel/i386_ksyms.c	2003-03-18 13:49:29.000000000 +0100
+++ linux-2.5.65.apic-driver-model/arch/i386/kernel/i386_ksyms.c	2003-03-19 00:54:31.000000000 +0100
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
diff -ruN linux-2.5.65/arch/i386/kernel/nmi.c linux-2.5.65.apic-driver-model/arch/i386/kernel/nmi.c
--- linux-2.5.65/arch/i386/kernel/nmi.c	2003-03-08 17:22:31.000000000 +0100
+++ linux-2.5.65.apic-driver-model/arch/i386/kernel/nmi.c	2003-03-19 00:54:31.000000000 +0100
@@ -9,6 +9,8 @@
  *  Mikael Pettersson	: AMD K7 support for local APIC NMI watchdog.
  *  Mikael Pettersson	: Power Management for local APIC NMI watchdog.
  *  Mikael Pettersson	: Pentium 4 support for local APIC NMI watchdog.
+ *  Pavel Machek and
+ *  Mikael Pettersson	: PM converted to driver model. Disable/enable API.
  */
 
 #include <linux/config.h>
@@ -20,6 +22,7 @@
 #include <linux/interrupt.h>
 #include <linux/mc146818rtc.h>
 #include <linux/kernel_stat.h>
+#include <linux/module.h>
 
 #include <asm/smp.h>
 #include <asm/mtrr.h>
@@ -134,14 +137,18 @@
 
 __setup("nmi_watchdog=", setup_nmi_watchdog);
 
-#ifdef CONFIG_PM
-
-#include <linux/pm.h>
-
-struct pm_dev *nmi_pmdev;
+/* nmi_active:
+ * +1: the lapic NMI watchdog is active, but can be disabled
+ *  0: the lapic NMI watchdog has not been set up, and cannot
+ *     be enabled
+ * -1: the lapic NMI watchdog is disabled, but can be enabled
+ */
+static int nmi_active;
 
-static void disable_apic_nmi_watchdog(void)
+void disable_lapic_nmi_watchdog(void)
 {
+	if (nmi_active <= 0)
+		return;
 	switch (boot_cpu_data.x86_vendor) {
 	case X86_VENDOR_AMD:
 		wrmsr(MSR_K7_EVNTSEL0, 0, 0);
@@ -158,46 +165,65 @@
 		}
 		break;
 	}
+	nmi_active = -1;
+	/* tell do_nmi() and others that we're not active any more */
+	nmi_watchdog = 0;
 }
 
-static int nmi_pm_callback(struct pm_dev *dev, pm_request_t rqst, void *data)
+void enable_lapic_nmi_watchdog(void)
 {
-	switch (rqst) {
-	case PM_SUSPEND:
-		disable_apic_nmi_watchdog();
-		break;
-	case PM_RESUME:
+	if (nmi_active < 0) {
+		nmi_watchdog = NMI_LOCAL_APIC;
 		setup_apic_nmi_watchdog();
-		break;
 	}
-	return 0;
 }
 
-struct pm_dev * set_nmi_pm_callback(pm_callback callback)
-{
-	apic_pm_unregister(nmi_pmdev);
-	return apic_pm_register(PM_SYS_DEV, 0, callback);
-}
+#ifdef CONFIG_PM
+
+#include <linux/device.h>
 
-void unset_nmi_pm_callback(struct pm_dev * dev)
+static int lapic_nmi_suspend(struct device *dev, u32 state, u32 level)
 {
-	apic_pm_unregister(dev);
-	nmi_pmdev = apic_pm_register(PM_SYS_DEV, 0, nmi_pm_callback);
+	if (level != SUSPEND_POWER_DOWN)
+		return 0;
+	disable_lapic_nmi_watchdog();
+	return 0;
 }
- 
-static void nmi_pm_init(void)
+
+static int lapic_nmi_resume(struct device *dev, u32 level)
 {
-	if (!nmi_pmdev)
-		nmi_pmdev = apic_pm_register(PM_SYS_DEV, 0, nmi_pm_callback);
+	if (level != RESUME_POWER_ON)
+		return 0;
+	enable_lapic_nmi_watchdog();
+	return 0;
 }
 
-#define __pminit	/*empty*/
-
-#else	/* CONFIG_PM */
+static struct device_driver lapic_nmi_driver = {
+	.name		= "lapic_nmi",
+	.bus		= &system_bus_type,
+	.resume		= lapic_nmi_resume,
+	.suspend	= lapic_nmi_suspend,
+};
+
+static struct sys_device device_lapic_nmi = {
+	.name		= "lapic_nmi",
+	.id		= 0,
+	.dev		= {
+		.name	= "lapic_nmi",
+		.driver	= &lapic_nmi_driver,
+		.parent = &device_lapic.dev,
+	},
+};
 
-static inline void nmi_pm_init(void) { }
-
-#define __pminit	__init
+static int __init init_lapic_nmi_devicefs(void)
+{
+	if (nmi_active == 0)
+		return 0;
+	driver_register(&lapic_nmi_driver);
+	return sys_device_register(&device_lapic_nmi);
+}
+/* must come after the local APIC's device_initcall() */
+late_initcall(init_lapic_nmi_devicefs);
 
 #endif	/* CONFIG_PM */
 
@@ -206,7 +232,7 @@
  * Original code written by Keith Owens.
  */
 
-static void __pminit clear_msr_range(unsigned int base, unsigned int n)
+static void clear_msr_range(unsigned int base, unsigned int n)
 {
 	unsigned int i;
 
@@ -214,7 +240,7 @@
 		wrmsr(base+i, 0, 0);
 }
 
-static void __pminit setup_k7_watchdog(void)
+static void setup_k7_watchdog(void)
 {
 	unsigned int evntsel;
 
@@ -236,7 +262,7 @@
 	wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
 }
 
-static void __pminit setup_p6_watchdog(void)
+static void setup_p6_watchdog(void)
 {
 	unsigned int evntsel;
 
@@ -258,7 +284,7 @@
 	wrmsr(MSR_P6_EVNTSEL0, evntsel, 0);
 }
 
-static int __pminit setup_p4_watchdog(void)
+static int setup_p4_watchdog(void)
 {
 	unsigned int misc_enable, dummy;
 
@@ -288,7 +314,7 @@
 	return 1;
 }
 
-void __pminit setup_apic_nmi_watchdog (void)
+void setup_apic_nmi_watchdog (void)
 {
 	switch (boot_cpu_data.x86_vendor) {
 	case X86_VENDOR_AMD:
@@ -312,7 +338,7 @@
 	default:
 		return;
 	}
-	nmi_pm_init();
+	nmi_active = 1;
 }
 
 static spinlock_t nmi_print_lock = SPIN_LOCK_UNLOCKED;
@@ -400,3 +426,7 @@
 		wrmsr(nmi_perfctr_msr, -(cpu_khz/nmi_hz*1000), -1);
 	}
 }
+
+EXPORT_SYMBOL(nmi_watchdog);
+EXPORT_SYMBOL(disable_lapic_nmi_watchdog);
+EXPORT_SYMBOL(enable_lapic_nmi_watchdog);
diff -ruN linux-2.5.65/arch/i386/oprofile/nmi_int.c linux-2.5.65.apic-driver-model/arch/i386/oprofile/nmi_int.c
--- linux-2.5.65/arch/i386/oprofile/nmi_int.c	2003-03-18 13:49:29.000000000 +0100
+++ linux-2.5.65.apic-driver-model/arch/i386/oprofile/nmi_int.c	2003-03-19 00:54:31.000000000 +0100
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
@@ -86,7 +66,43 @@
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
+
+extern struct sys_device device_apic;
 
 static int nmi_setup(void)
 {
@@ -95,12 +111,20 @@
 	 * without actually triggering any NMIs as this will
 	 * break the core code horrifically.
 	 */
+	disable_lapic_nmi_watchdog();
 	on_each_cpu(nmi_cpu_setup, NULL, 0, 1);
 	set_nmi_callback(nmi_callback);
-	oprofile_pmdev = set_nmi_pm_callback(oprofile_pm_callback);
+	nmi_enabled = 1;
 	return 0;
 }
 
+static int __init init_nmi_driverfs(void)
+{
+	driver_register(&nmi_driver);
+	return device_register(&device_nmi);
+}
+
+late_initcall(init_nmi_driverfs);
 
 static void nmi_restore_registers(struct op_msrs * msrs)
 {
@@ -145,9 +169,10 @@
  
 static void nmi_shutdown(void)
 {
-	unset_nmi_pm_callback(oprofile_pmdev);
+	nmi_enabled = 0;
 	unset_nmi_callback();
 	on_each_cpu(nmi_cpu_shutdown, NULL, 0, 1);
+	enable_lapic_nmi_watchdog();
 }
 
  
diff -ruN linux-2.5.65/include/asm-i386/apic.h linux-2.5.65.apic-driver-model/include/asm-i386/apic.h
--- linux-2.5.65/include/asm-i386/apic.h	2002-10-20 18:51:08.000000000 +0200
+++ linux-2.5.65.apic-driver-model/include/asm-i386/apic.h	2003-03-19 00:54:31.000000000 +0100
@@ -79,13 +79,14 @@
 extern void setup_boot_APIC_clock (void);
 extern void setup_secondary_APIC_clock (void);
 extern void setup_apic_nmi_watchdog (void);
+extern void disable_lapic_nmi_watchdog(void);
+extern void enable_lapic_nmi_watchdog(void);
 extern inline void nmi_watchdog_tick (struct pt_regs * regs);
 extern int APIC_init_uniprocessor (void);
 extern void disable_APIC_timer(void);
 extern void enable_APIC_timer(void);
 
-extern struct pm_dev *apic_pm_register(pm_dev_t, unsigned long, pm_callback);
-extern void apic_pm_unregister(struct pm_dev*);
+extern struct sys_device device_lapic;
 
 extern int check_nmi_watchdog (void);
 extern void enable_NMI_through_LVT0 (void * dummy);
diff -ruN linux-2.5.65/include/asm-i386/nmi.h linux-2.5.65.apic-driver-model/include/asm-i386/nmi.h
--- linux-2.5.65/include/asm-i386/nmi.h	2002-10-16 18:31:11.000000000 +0200
+++ linux-2.5.65.apic-driver-model/include/asm-i386/nmi.h	2003-03-19 00:54:31.000000000 +0100
@@ -25,25 +25,4 @@
  */
 void unset_nmi_callback(void);
  
-#ifdef CONFIG_PM
- 
-/** Replace the PM callback routine for NMI. */
-struct pm_dev * set_nmi_pm_callback(pm_callback callback);
-
-/** Unset the PM callback routine back to the default. */
-void unset_nmi_pm_callback(struct pm_dev * dev);
-
-#else
-
-static inline struct pm_dev * set_nmi_pm_callback(pm_callback callback)
-{
-	return 0;
-} 
- 
-static inline void unset_nmi_pm_callback(struct pm_dev * dev)
-{
-}
-
-#endif /* CONFIG_PM */
- 
 #endif /* ASM_NMI_H */
