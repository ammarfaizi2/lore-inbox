Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbUKTJdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbUKTJdg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 04:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbUKTJdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 04:33:36 -0500
Received: from [220.248.27.114] ([220.248.27.114]:34215 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S261342AbUKTJaA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 04:30:00 -0500
Date: Sat, 20 Nov 2004 17:27:33 +0800
From: hugang@soulinfo.com
To: linux-kernel@vger.kernel.org
Subject: Re: swsusp bigdiff [was Re: [PATCH] Software Suspend split to two stage V2.]
Message-ID: <20041120092733.GB4328@hugang.soulinfo.com>
References: <20041119194007.GA1650@hugang.soulinfo.com> <20041120003010.GG1594@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041120003010.GG1594@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
X-Virus-Checked: Checked
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2004 at 01:30:10AM +0100, Pavel Machek wrote:
> Hi!
> 
> >   This patch using pagemap for PageSet2 bitmap, It increase suspend
> >   speed, In my PowerPC suspend only need 5 secs, cool. 
> > 
> >   Test passed in my ppc and x86 laptop.
> > 
> >   ppc swsusp patch for 2.6.9
> >    http://honk.physik.uni-konstanz.de/~agx/linux-ppc/kernel/
> >   Have fun.
> 
> BTW here's my curent bigdiff. It already has some rather nice
> swsusp speedups. Please try it on your machine; if it works for you,
> try to send your patches relative to this one. I hope to merge these
> changes during 2.6.11.
> 
> 								Pavel
>

Here is my diff with powerpc support, tested passed, readlly faster in
my powerpc laptop. 

First get clean 2.6.9 kernel, apply big diff, apply my diff, apply 
2.6.9-oom-kill-fix.patch from ck1.

* The sysfs interface can't works, I still using reboot system call 
 reading Documents/power/swsusp.txt.

Have fun.


diff -ur linux-2.6.9-peval-hg/arch/ppc/Kconfig linux-2.6.9-peval-hg-ppc.old/arch/ppc/Kconfig
--- linux-2.6.9-peval-hg/arch/ppc/Kconfig	2004-10-20 15:58:39.000000000 +0800
+++ linux-2.6.9-peval-hg-ppc.old/arch/ppc/Kconfig	2004-11-20 16:17:05.000000000 +0800
@@ -983,6 +983,8 @@
 
 source "drivers/zorro/Kconfig"
 
+source kernel/power/Kconfig
+
 endmenu
 
 menu "Bus options"
Only in linux-2.6.9-peval-hg-ppc.old/arch/ppc: Kconfig~
diff -ur linux-2.6.9-peval-hg/arch/ppc/kernel/Makefile linux-2.6.9-peval-hg-ppc.old/arch/ppc/kernel/Makefile
--- linux-2.6.9-peval-hg/arch/ppc/kernel/Makefile	2004-10-20 15:58:40.000000000 +0800
+++ linux-2.6.9-peval-hg-ppc.old/arch/ppc/kernel/Makefile	2004-11-20 16:17:05.000000000 +0800
@@ -16,6 +16,7 @@
 					semaphore.o syscalls.o setup.o \
 					cputable.o ppc_htab.o
 obj-$(CONFIG_6xx)		+= l2cr.o cpu_setup_6xx.o
+obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o
 obj-$(CONFIG_POWER4)		+= cpu_setup_power4.o
 obj-$(CONFIG_MODULES)		+= module.o ppc_ksyms.o
 obj-$(CONFIG_NOT_COHERENT_CACHE)	+= dma-mapping.o
diff -ur linux-2.6.9-peval-hg/arch/ppc/kernel/signal.c linux-2.6.9-peval-hg-ppc.old/arch/ppc/kernel/signal.c
--- linux-2.6.9-peval-hg/arch/ppc/kernel/signal.c	2004-10-20 15:58:41.000000000 +0800
+++ linux-2.6.9-peval-hg-ppc.old/arch/ppc/kernel/signal.c	2004-11-20 16:17:05.000000000 +0800
@@ -28,6 +28,7 @@
 #include <linux/elf.h>
 #include <linux/tty.h>
 #include <linux/binfmts.h>
+#include <linux/suspend.h>
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -604,6 +605,14 @@
 	unsigned long frame, newsp;
 	int signr, ret;
 
+	if (current->flags & PF_FREEZE) {
+		refrigerator(PF_FREEZE);
+		signr = 0;
+		ret = regs->gpr[3];
+		if (!signal_pending(current))
+			goto no_signal;
+	}
+
 	if (!oldset)
 		oldset = &current->blocked;
 
@@ -626,6 +635,7 @@
 			regs->gpr[3] = EINTR;
 			/* note that the cr0.SO bit is already set */
 		} else {
+no_signal:
 			regs->nip -= 4;	/* Back up & retry system call */
 			regs->result = 0;
 			regs->trap = 0;
Only in linux-2.6.9-peval-hg-ppc.old/arch/ppc/kernel: swsusp.S
diff -ur linux-2.6.9-peval-hg/arch/ppc/kernel/vmlinux.lds.S linux-2.6.9-peval-hg-ppc.old/arch/ppc/kernel/vmlinux.lds.S
--- linux-2.6.9-peval-hg/arch/ppc/kernel/vmlinux.lds.S	2004-10-20 15:58:41.000000000 +0800
+++ linux-2.6.9-peval-hg-ppc.old/arch/ppc/kernel/vmlinux.lds.S	2004-11-20 16:17:05.000000000 +0800
@@ -74,6 +74,12 @@
     CONSTRUCTORS
   }
 
+  . = ALIGN(4096);
+  __nosave_begin = .;
+  .data_nosave : { *(.data.nosave) }
+  . = ALIGN(4096);
+  __nosave_end = .;
+
   . = ALIGN(32);
   .data.cacheline_aligned : { *(.data.cacheline_aligned) }
 
diff -ur linux-2.6.9-peval-hg/arch/ppc/platforms/pmac_setup.c linux-2.6.9-peval-hg-ppc.old/arch/ppc/platforms/pmac_setup.c
--- linux-2.6.9-peval-hg/arch/ppc/platforms/pmac_setup.c	2004-10-20 15:58:41.000000000 +0800
+++ linux-2.6.9-peval-hg-ppc.old/arch/ppc/platforms/pmac_setup.c	2004-11-20 16:43:16.000000000 +0800
@@ -51,6 +51,7 @@
 #include <linux/irq.h>
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
+#include <linux/suspend.h>
 
 #include <asm/reg.h>
 #include <asm/sections.h>
@@ -70,6 +71,8 @@
 #include <asm/pmac_feature.h>
 #include <asm/time.h>
 #include <asm/of_device.h>
+#include <asm/mmu_context.h>
+
 #include "pmac_pic.h"
 #include "mem_pieces.h"
 
@@ -420,11 +423,67 @@
 #endif
 }
 
+/* TODO: Merge the suspend-to-ram with the common code !!!
+ * currently, this is a stub implementation for suspend-to-disk
+ * only
+ */
+
+#ifdef CONFIG_PM
+
+extern void enable_kernel_altivec(void);
+
+static int pmac_pm_prepare(u32 state)
+{
+	printk(KERN_DEBUG "pmac_pm_prepare(%d)\n", state);
+
+	return 0;
+}
+
+static int pmac_pm_enter(u32 state)
+{
+	printk(KERN_DEBUG "pmac_pm_enter(%d)\n", state);
+
+	/* Giveup the lazy FPU & vec so we don't have to back them
+	 * up from the low level code
+	 */
+	enable_kernel_fp();
+
+#ifdef CONFIG_ALTIVEC
+	if (cur_cpu_spec[0]->cpu_features & CPU_FTR_ALTIVEC)
+		enable_kernel_altivec();
+#endif /* CONFIG_ALTIVEC */
+
+	return 0;
+}
+
+static int pmac_pm_finish(u32 state)
+{
+	printk(KERN_DEBUG "pmac_pm_finish(%d)\n", state);
+
+	/* Restore userland MMU context */
+	set_context(current->active_mm->context, current->active_mm->pgd);
+
+	return 0;
+}
+
+static struct pm_ops pmac_pm_ops = {
+	.pm_disk_mode	= PM_DISK_SHUTDOWN,
+	.prepare	= pmac_pm_prepare,
+	.enter		= pmac_pm_enter,
+	.finish		= pmac_pm_finish,
+};
+
+#endif /* CONFIG_PM */
+
 static int initializing = 1;
 
 static int pmac_late_init(void)
 {
 	initializing = 0;
+
+#ifdef CONFIG_PM
+	pm_set_ops(&pmac_pm_ops);
+#endif /* CONFIG_PM */
 	return 0;
 }
 
diff -ur linux-2.6.9-peval-hg/arch/ppc/syslib/open_pic.c linux-2.6.9-peval-hg-ppc.old/arch/ppc/syslib/open_pic.c
--- linux-2.6.9-peval-hg/arch/ppc/syslib/open_pic.c	2004-10-20 15:58:42.000000000 +0800
+++ linux-2.6.9-peval-hg-ppc.old/arch/ppc/syslib/open_pic.c	2004-11-20 16:25:10.000000000 +0800
@@ -776,7 +776,8 @@
 	if (ISR[irq] == 0)
 		return;
 	if (!cpus_empty(keepmask)) {
-		cpumask_t irqdest = { .bits[0] = openpic_read(&ISR[irq]->Destination) };
+		cpumask_t irqdest;
+		irqdest.bits[0] = openpic_read(&ISR[irq]->Destination);
 		cpus_and(irqdest, irqdest, keepmask);
 		cpus_or(physmask, physmask, irqdest);
 	}
diff -ur linux-2.6.9-peval-hg/drivers/ide/ppc/pmac.c linux-2.6.9-peval-hg-ppc.old/drivers/ide/ppc/pmac.c
--- linux-2.6.9-peval-hg/drivers/ide/ppc/pmac.c	2004-10-20 15:59:12.000000000 +0800
+++ linux-2.6.9-peval-hg-ppc.old/drivers/ide/ppc/pmac.c	2004-11-20 16:17:05.000000000 +0800
@@ -32,6 +32,7 @@
 #include <linux/notifier.h>
 #include <linux/reboot.h>
 #include <linux/pci.h>
+#include <linux/pm.h>
 #include <linux/adb.h>
 #include <linux/pmu.h>
 
@@ -1364,7 +1365,7 @@
 	ide_hwif_t	*hwif = (ide_hwif_t *)dev_get_drvdata(&mdev->ofdev.dev);
 	int		rc = 0;
 
-	if (state != mdev->ofdev.dev.power_state && state >= 2) {
+	if (state != mdev->ofdev.dev.power_state && state == PM_SUSPEND_MEM) {
 		rc = pmac_ide_do_suspend(hwif);
 		if (rc == 0)
 			mdev->ofdev.dev.power_state = state;
@@ -1472,7 +1473,7 @@
 	ide_hwif_t	*hwif = (ide_hwif_t *)pci_get_drvdata(pdev);
 	int		rc = 0;
 	
-	if (state != pdev->dev.power_state && state >= 2) {
+	if (state != pdev->dev.power_state && state == PM_SUSPEND_MEM ) {
 		rc = pmac_ide_do_suspend(hwif);
 		if (rc == 0)
 			pdev->dev.power_state = state;
diff -ur linux-2.6.9-peval-hg/drivers/macintosh/Kconfig linux-2.6.9-peval-hg-ppc.old/drivers/macintosh/Kconfig
--- linux-2.6.9-peval-hg/drivers/macintosh/Kconfig	2004-10-20 15:53:31.000000000 +0800
+++ linux-2.6.9-peval-hg-ppc.old/drivers/macintosh/Kconfig	2004-11-20 16:17:05.000000000 +0800
@@ -80,7 +80,7 @@
 
 config PMAC_PBOOK
 	bool "Power management support for PowerBooks"
-	depends on ADB_PMU
+	depends on PM && ADB_PMU
 	---help---
 	  This provides support for putting a PowerBook to sleep; it also
 	  enables media bay support.  Power management works on the
@@ -97,11 +97,6 @@
 	  have it autoloaded. The act of removing the module shuts down the
 	  sound hardware for more power savings.
 
-config PM
-	bool
-	depends on PPC_PMAC && ADB_PMU && PMAC_PBOOK
-	default y
-
 config PMAC_APM_EMU
 	tristate "APM emulation"
 	depends on PMAC_PBOOK
diff -ur linux-2.6.9-peval-hg/drivers/macintosh/mediabay.c linux-2.6.9-peval-hg-ppc.old/drivers/macintosh/mediabay.c
--- linux-2.6.9-peval-hg/drivers/macintosh/mediabay.c	2004-10-20 15:53:32.000000000 +0800
+++ linux-2.6.9-peval-hg-ppc.old/drivers/macintosh/mediabay.c	2004-11-20 16:17:05.000000000 +0800
@@ -713,7 +713,7 @@
 {
 	struct media_bay_info	*bay = macio_get_drvdata(mdev);
 
-	if (state != mdev->ofdev.dev.power_state && state >= 2) {
+	if (state != mdev->ofdev.dev.power_state && state == PM_SUSPEND_MEM) {
 		down(&bay->lock);
 		bay->sleeping = 1;
 		set_mb_power(bay, 0);
diff -ur linux-2.6.9-peval-hg/drivers/macintosh/therm_adt746x.c linux-2.6.9-peval-hg-ppc.old/drivers/macintosh/therm_adt746x.c
--- linux-2.6.9-peval-hg/drivers/macintosh/therm_adt746x.c	2004-10-20 15:59:24.000000000 +0800
+++ linux-2.6.9-peval-hg-ppc.old/drivers/macintosh/therm_adt746x.c	2004-11-20 16:17:05.000000000 +0800
@@ -22,6 +22,7 @@
 #include <linux/spinlock.h>
 #include <linux/smp_lock.h>
 #include <linux/wait.h>
+#include <linux/suspend.h>
 #include <asm/prom.h>
 #include <asm/machdep.h>
 #include <asm/io.h>
@@ -238,6 +239,11 @@
 #endif
 	while(!kthread_should_stop())
 	{
+ 		if (current->flags & PF_FREEZE) {
+ 			printk(KERN_INFO "therm_adt746x: freezing thermostat\n");
+ 			refrigerator(PF_FREEZE);
+ 		}
+ 
 		msleep_interruptible(2000);
 
 		/* Check status */
diff -ur linux-2.6.9-peval-hg/drivers/macintosh/therm_pm72.c linux-2.6.9-peval-hg-ppc.old/drivers/macintosh/therm_pm72.c
--- linux-2.6.9-peval-hg/drivers/macintosh/therm_pm72.c	2004-10-20 15:53:32.000000000 +0800
+++ linux-2.6.9-peval-hg-ppc.old/drivers/macintosh/therm_pm72.c	2004-11-20 16:17:05.000000000 +0800
@@ -88,6 +88,7 @@
 #include <linux/spinlock.h>
 #include <linux/smp_lock.h>
 #include <linux/wait.h>
+#include <linux/suspend.h>
 #include <linux/reboot.h>
 #include <linux/kmod.h>
 #include <linux/i2c.h>
@@ -1044,6 +1045,11 @@
 	while (state == state_attached) {
 		unsigned long elapsed, start;
 
+		if (current->flags & PF_FREEZE) {
+			printk(KERN_INFO "therm_pm72: freezing thermostat\n");
+			refrigerator(PF_FREEZE);
+		}
+
 		start = jiffies;
 
 		down(&driver_lock);
diff -ur linux-2.6.9-peval-hg/drivers/macintosh/via-pmu.c linux-2.6.9-peval-hg-ppc.old/drivers/macintosh/via-pmu.c
--- linux-2.6.9-peval-hg/drivers/macintosh/via-pmu.c	2004-10-20 15:59:24.000000000 +0800
+++ linux-2.6.9-peval-hg-ppc.old/drivers/macintosh/via-pmu.c	2004-11-20 16:23:11.000000000 +0800
@@ -43,6 +43,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/device.h>
+#include <linux/sysdev.h>
 #include <linux/suspend.h>
 #include <linux/syscalls.h>
 #include <asm/prom.h>
@@ -2326,7 +2327,7 @@
 	/* Sync the disks. */
 	/* XXX It would be nice to have some way to ensure that
 	 * nobody is dirtying any new buffers while we wait. That
-	 * could be acheived using the refrigerator for processes
+	 * could be achieved using the refrigerator for processes
 	 * that swsusp uses
 	 */
 	sys_sync();
@@ -2379,7 +2380,6 @@
 
 	/* Wait for completion of async backlight requests */
 	while (!bright_req_1.complete || !bright_req_2.complete ||
-
 			!batt_req.complete)
 		pmu_poll();
 
@@ -3048,6 +3048,88 @@
 }
 #endif /* DEBUG_SLEEP */
 
+
+/* FIXME: This is a temporary set of callbacks to enable us
+ * to do suspend-to-disk.
+ */
+
+#ifdef CONFIG_PM
+
+static int pmu_sys_suspended = 0;
+
+static int pmu_sys_suspend(struct sys_device *sysdev, pm_message_t state)
+{
+	if (state != PMSG_FREEZE || pmu_sys_suspended)
+		return 0;
+
+	/* Suspend PMU event interrupts */
+	pmu_suspend();
+
+	pmu_sys_suspended = 1;
+	return 0;
+}
+
+static int pmu_sys_resume(struct sys_device *sysdev)
+{
+	struct adb_request req;
+
+	if (!pmu_sys_suspended)
+		return 0;
+
+	/* Tell PMU we are ready */
+	pmu_request(&req, NULL, 2, PMU_SYSTEM_READY, 2);
+	pmu_wait_complete(&req);
+
+	/* Resume PMU event interrupts */
+	pmu_resume();
+
+	pmu_sys_suspended = 0;
+
+	return 0;
+}
+
+#endif /* CONFIG_PM */
+
+static struct sysdev_class pmu_sysclass = {
+	set_kset_name("pmu"),
+};
+
+static struct sys_device device_pmu = {
+	.id		= 0,
+	.cls		= &pmu_sysclass,
+};
+
+static struct sysdev_driver driver_pmu = {
+#ifdef CONFIG_PM
+	.suspend	= &pmu_sys_suspend,
+	.resume		= &pmu_sys_resume,
+#endif /* CONFIG_PM */
+};
+
+static int __init init_pmu_sysfs(void)
+{
+	int rc;
+
+	rc = sysdev_class_register(&pmu_sysclass);
+	if (rc) {
+		printk(KERN_ERR "Failed registering PMU sys class\n");
+		return -ENODEV;
+	}
+	rc = sysdev_register(&device_pmu);
+	if (rc) {
+		printk(KERN_ERR "Failed registering PMU sys device\n");
+		return -ENODEV;
+	}
+	rc = sysdev_driver_register(&pmu_sysclass, &driver_pmu);
+	if (rc) {
+		printk(KERN_ERR "Failed registering PMU sys driver\n");
+		return -ENODEV;
+	}
+	return 0;
+}
+
+subsys_initcall(init_pmu_sysfs);
+
 EXPORT_SYMBOL(pmu_request);
 EXPORT_SYMBOL(pmu_poll);
 EXPORT_SYMBOL(pmu_poll_adb);
diff -ur linux-2.6.9-peval-hg/drivers/video/aty/radeon_pm.c linux-2.6.9-peval-hg-ppc.old/drivers/video/aty/radeon_pm.c
--- linux-2.6.9-peval-hg/drivers/video/aty/radeon_pm.c	2004-10-20 15:55:34.000000000 +0800
+++ linux-2.6.9-peval-hg-ppc.old/drivers/video/aty/radeon_pm.c	2004-11-20 16:17:05.000000000 +0800
@@ -859,6 +859,10 @@
 	 * know we'll be rebooted, ...
 	 */
 
+#if 0	/* this breaks suspend to ram until the dust settles... */
+	if (state != PM_SUSPEND_MEM)
+#endif
+		return 0;
 	printk(KERN_DEBUG "radeonfb: suspending to state: %d...\n", state);
 	
 	acquire_console_sem();
Only in linux-2.6.9-peval-hg-ppc.old/include/asm-ppc: suspend.h
diff -ur linux-2.6.9-peval-hg/include/linux/reboot.h linux-2.6.9-peval-hg-ppc.old/include/linux/reboot.h
--- linux-2.6.9-peval-hg/include/linux/reboot.h	2004-06-16 13:20:26.000000000 +0800
+++ linux-2.6.9-peval-hg-ppc.old/include/linux/reboot.h	2004-11-20 16:17:05.000000000 +0800
@@ -42,6 +42,8 @@
 extern int register_reboot_notifier(struct notifier_block *);
 extern int unregister_reboot_notifier(struct notifier_block *);
 
+/* For use by swsusp only */
+extern struct notifier_block *reboot_notifier_list;
 
 /*
  * Architecture-specific implementations of sys_reboot commands.
diff -ur linux-2.6.9-peval-hg/include/linux/suspend.h linux-2.6.9-peval-hg-ppc.old/include/linux/suspend.h
--- linux-2.6.9-peval-hg/include/linux/suspend.h	2004-11-20 14:14:45.000000000 +0800
+++ linux-2.6.9-peval-hg-ppc.old/include/linux/suspend.h	2004-11-20 16:17:05.000000000 +0800
@@ -1,7 +1,7 @@
 #ifndef _LINUX_SWSUSP_H
 #define _LINUX_SWSUSP_H
 
-#ifdef CONFIG_X86
+#if (defined  CONFIG_X86) || (defined CONFIG_PPC32)
 #include <asm/suspend.h>
 #endif
 #include <linux/swap.h>
diff -ur linux-2.6.9-peval-hg/kernel/power/disk.c linux-2.6.9-peval-hg-ppc.old/kernel/power/disk.c
--- linux-2.6.9-peval-hg/kernel/power/disk.c	2004-11-20 14:51:21.000000000 +0800
+++ linux-2.6.9-peval-hg-ppc.old/kernel/power/disk.c	2004-11-20 16:19:03.000000000 +0800
@@ -16,6 +16,7 @@
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/fs.h>
+#include <linux/reboot.h>
 #include <linux/device.h>
 #include "power.h"
 
@@ -50,14 +51,16 @@
 	unsigned long flags;
 	int error = 0;
 
-	local_irq_save(flags);
 	switch(mode) {
 	case PM_DISK_PLATFORM:
- 		device_power_down(PMSG_SUSPEND);
+ 		/* device_power_down(PMSG_SUSPEND); */
+		local_irq_save(flags);
 		error = pm_ops->enter(PM_SUSPEND_DISK);
+		local_irq_restore(flags);
 		break;
 	case PM_DISK_SHUTDOWN:
 		printk("Powering off system\n");
+		notifier_call_chain(&reboot_notifier_list, SYS_POWER_OFF, NULL);
 		device_shutdown();
 		machine_power_off();
 		break;
diff -ur linux-2.6.9-peval-hg/kernel/power/disk.c~ linux-2.6.9-peval-hg-ppc.old/kernel/power/disk.c~
--- linux-2.6.9-peval-hg/kernel/power/disk.c~	2004-11-20 14:14:45.000000000 +0800
+++ linux-2.6.9-peval-hg-ppc.old/kernel/power/disk.c~	2004-11-20 14:51:21.000000000 +0800
@@ -29,6 +29,8 @@
 extern int swsusp_resume(void);
 extern int swsusp_free(void);
 
+extern int write_page_caches(void);
+extern int read_page_caches(void);
 
 static int noresume = 0;
 char resume_file[256] = CONFIG_PM_STD_PARTITION;
@@ -106,6 +108,7 @@
 	}
 }
 
+
 static inline void platform_finish(void)
 {
 	if (pm_disk_mode == PM_DISK_PLATFORM) {
@@ -118,13 +121,14 @@
 {
 	device_resume();
 	platform_finish();
+	read_page_caches();
 	enable_nonboot_cpus();
 	thaw_processes();
 	pm_restore_console();
 }
 
 
-static int prepare(void)
+static int prepare(int resume)
 {
 	int error;
 
@@ -144,9 +148,13 @@
 	}
 
 	/* Free memory before shutting down devices. */
-	free_some_memory();
+	/* free_some_memory(); */
 
 	disable_nonboot_cpus();
+	if (!resume) 
+		if ((error = write_page_caches())) {
+			goto Finish;
+		}
 	if ((error = device_suspend(PMSG_FREEZE))) {
 		printk("Some devices failed to suspend\n");
 		goto Finish;
@@ -176,7 +184,7 @@
 {
 	int error;
 
-	if ((error = prepare()))
+	if ((error = prepare(0)))
 		return error;
 
 	pr_debug("PM: Attempting to suspend to disk.\n");
@@ -233,7 +241,7 @@
 
 	pr_debug("PM: Preparing system for restore.\n");
 
-	if ((error = prepare()))
+	if ((error = prepare(1)))
 		goto Free;
 
 	barrier();
Only in linux-2.6.9-peval-hg-ppc.old/kernel/power: disk.c.rej
diff -ur linux-2.6.9-peval-hg/kernel/power/main.c linux-2.6.9-peval-hg-ppc.old/kernel/power/main.c
--- linux-2.6.9-peval-hg/kernel/power/main.c	2004-11-20 14:14:45.000000000 +0800
+++ linux-2.6.9-peval-hg-ppc.old/kernel/power/main.c	2004-11-20 16:17:05.000000000 +0800
@@ -4,7 +4,7 @@
  * Copyright (c) 2003 Patrick Mochel
  * Copyright (c) 2003 Open Source Development Lab
  * 
- * This file is release under the GPLv2
+ * This file is released under the GPLv2
  *
  */
 
diff -ur linux-2.6.9-peval-hg/kernel/power/swsusp.c linux-2.6.9-peval-hg-ppc.old/kernel/power/swsusp.c
--- linux-2.6.9-peval-hg/kernel/power/swsusp.c	2004-11-20 16:04:27.000000000 +0800
+++ linux-2.6.9-peval-hg-ppc.old/kernel/power/swsusp.c	2004-11-20 16:46:14.000000000 +0800
@@ -1138,7 +1138,7 @@
 	return error;
 }
 
-
+#if defined(__i386__)
 asmlinkage int swsusp_restore(void)
 {
 	BUG_ON (pagedir_order_check != pagedir_order);
@@ -1149,6 +1149,7 @@
 	wbinvd();	/* Nigel says wbinvd here is good idea... */
 	return 0;
 }
+#endif
 
 int swsusp_resume(void)
 {
@@ -1453,7 +1454,7 @@
 		return -ENOMEM;
 	pagedir_nosave = (struct pbe *)addr;
 
-	pr_debug("pmdisk: Reading pagedir (%d Pages)\n",n);
+	pr_debug("swsusp: Reading pagedir (%d Pages)\n",n);
 
 	for (i = 0; i < n && !error; i++, addr += PAGE_SIZE) {
 		unsigned long offset = swp_offset(swsusp_info.pagedir[i]);
@@ -1483,7 +1484,7 @@
 }
 
 /**
- *	pmdisk_read - Read saved image from swap.
+ *	swsusp_read - Read saved image from swap.
  */
 
 int __init swsusp_read(void)
@@ -1507,6 +1508,6 @@
 	if (!error)
 		pr_debug("Reading resume file was successful\n");
 	else
-		pr_debug("pmdisk: Error %d resuming\n", error);
+		pr_debug("swsusp: Error %d resuming\n", error);
 	return error;
 }
diff -ur linux-2.6.9-peval-hg/kernel/power/swsusp.c~ linux-2.6.9-peval-hg-ppc.old/kernel/power/swsusp.c~
--- linux-2.6.9-peval-hg/kernel/power/swsusp.c~	2004-11-20 14:14:45.000000000 +0800
+++ linux-2.6.9-peval-hg-ppc.old/kernel/power/swsusp.c~	2004-11-20 16:04:27.000000000 +0800
@@ -76,6 +76,7 @@
 
 /* Variables to be preserved over suspend */
 static int pagedir_order_check;
+static int nr_copy_pages_check;
 
 extern char resume_file[];
 static dev_t resume_device;
@@ -302,6 +303,12 @@
 			printk( "\b\b\b\b%3d%%", i / mod );
 		error = write_page((pagedir_nosave+i)->address,
 					  &((pagedir_nosave+i)->swap_address));
+#ifdef PCS_DEBUG
+		pr_debug("data_write: %p %p %u\n", 
+				(void *)(pagedir_nosave+i)->address, 
+				(void *)(pagedir_nosave+i)->orig_address,
+				(pagedir_nosave+i)->swap_address);
+#endif
 	}
 	printk("\b\b\b\bdone\n");
 	return error;
@@ -504,6 +511,327 @@
 	return 0;
 }
 
+/**
+ *	calc_order - Determine the order of allocation needed for pagedir_save.
+ *
+ *	This looks tricky, but is just subtle. Please fix it some time.
+ *	Since there are %nr_copy_pages worth of pages in the snapshot, we need
+ *	to allocate enough contiguous space to hold 
+ *		(%nr_copy_pages * sizeof(struct pbe)), 
+ *	which has the saved/orig locations of the page.. 
+ *
+ *	SUSPEND_PD_PAGES() tells us how many pages we need to hold those 
+ *	structures, then we call get_bitmask_order(), which will tell us the
+ *	last bit set in the number, starting with 1. (If we need 30 pages, that
+ *	is 0x0000001e in hex. The last bit is the 5th, which is the order we 
+ *	would use to allocate 32 contiguous pages).
+ *
+ *	Since we also need to save those pages, we add the number of pages that
+ *	we need to nr_copy_pages, and in case of an overflow, do the 
+ *	calculation again to update the number of pages needed. 
+ *
+ *	With this model, we will tend to waste a lot of memory if we just cross
+ *	an order boundary. Plus, the higher the order of allocation that we try
+ *	to do, the more likely we are to fail in a low-memory situtation 
+ *	(though	we're unlikely to get this far in such a case, since swsusp 
+ *	requires half of memory to be free anyway).
+ */
+
+static void calc_order(int *po, int *nr)
+{
+	int diff = 0;
+	int order = 0;
+
+	do {
+		diff = get_bitmask_order(SUSPEND_PD_PAGES(*nr)) - order;
+		if (diff) {
+			order += diff;
+			*nr += 1 << diff;
+		}
+	} while(diff);
+	*po = order;
+}
+
+typedef int (*do_page_t)(struct page *page, void *p);
+
+static int foreach_zone_page(struct zone *zone, do_page_t fun, void *p)
+{
+	int inactive = 0, active = 0;
+
+	/* spin_lock_irq(&zone->lru_lock); */
+	if (zone->nr_inactive) {
+		struct list_head * entry = zone->inactive_list.prev;
+		while (entry != &zone->inactive_list) {
+			if (fun) {
+				struct page * page = list_entry(entry, struct page, lru);
+				inactive += fun(page, p);
+			} else { 
+				inactive ++;
+			}
+			entry = entry->prev;
+		}
+	}
+	if (zone->nr_active) {
+		struct list_head * entry = zone->active_list.prev;
+		while (entry != &zone->active_list) {
+			if (fun) {
+				struct page * page = list_entry(entry, struct page, lru);
+				active += fun(page, p);
+			} else {
+				active ++;
+			}
+			entry = entry->prev;
+		}
+	}
+	/* spin_unlock_irq(&zone->lru_lock); */
+
+	return (active + inactive);
+}
+
+/* I'll move this to include/linux/page-flags.h */
+#define PG_pcs (PG_nosave_free + 1)
+
+#define SetPagePcs(page)    set_bit(PG_pcs, &(page)->flags)
+#define ClearPagePcs(page)  clear_bit(PG_pcs, &(page)->flags)
+#define PagePcs(page)   test_bit(PG_pcs, &(page)->flags)
+
+static int setup_pcs_pe(struct page *page, void *p)
+{
+	suspend_pagedir_t **pe = p;
+	unsigned long pfn = page_to_pfn(page);
+
+	BUG_ON(PageReserved(page) && PageNosave(page));
+	if (!pfn_valid(pfn)) {
+		printk("not valid page\n");
+		return 0;
+	}
+	if (PageNosave(page)) {
+		printk("nosave\n");
+		return 0;
+	}
+	if (PageReserved(page) /*&& pfn_is_nosave(pfn)*/) {
+		printk("[nosave]\n");
+		return 0;
+	}
+	if (PageSlab(page)) {
+		printk("slab\n");
+		return (0);
+	}
+	if (pe && *pe) {
+		BUG_ON(!PagePcs(page));
+		(*pe)->address = (long) page_address(page);
+		(*pe) ++;
+	} 
+	SetPagePcs(page);
+
+	return (1);
+}
+
+static int count_pcs(struct zone *zone, suspend_pagedir_t **pe)
+{
+	return foreach_zone_page(zone, setup_pcs_pe, pe);	
+}
+
+static suspend_pagedir_t *pagedir_cache = NULL;
+static int nr_copy_pcs = 0;
+static int pcs_order = 0;
+
+static int alloc_pagedir_cache(void)
+{
+	int need_nr_copy_pcs = nr_copy_pcs;
+
+	calc_order(&pcs_order, &need_nr_copy_pcs);
+	pagedir_cache = (suspend_pagedir_t *)
+		__get_free_pages(GFP_ATOMIC | __GFP_COLD, pcs_order);
+	if (!pagedir_cache)
+		return -ENOMEM;
+	memset(pagedir_cache, 0, (1 << pcs_order) * PAGE_SIZE);
+
+	pr_debug("alloc pcs %p, %d\n", pagedir_cache, pcs_order);
+
+	return 0;
+}
+
+static void page_cache_unlock(void)
+{
+	struct zone *zone;
+
+	for_each_zone(zone) {
+		if (!is_highmem(zone)) {
+			spin_unlock_irq(&zone->lru_lock);
+		}
+	}
+}
+
+static void page_cache_lock(void)
+{
+	struct zone *zone;
+
+	for_each_zone(zone) {
+		if (!is_highmem(zone)) {
+			spin_lock_irq(&zone->lru_lock);
+		}
+	}
+}
+int bio_read_page(pgoff_t page_off, void * page);
+
+int read_page_caches(void)
+{
+	struct pbe * p;
+	int error = 0, i;
+	swp_entry_t entry;
+	int mod = nr_copy_pcs / 100;
+
+	printk( "Reading PageCaches from swap (%d pages)...     ", nr_copy_pcs);
+	for(i = 0, p = pagedir_cache; i < nr_copy_pcs && !error; i++, p++) {
+		if (!(i%100))
+			printk( "\b\b\b\b%3d%%", i / mod );
+		error = bio_read_page(swp_offset(p->swap_address),
+				(void *)p->address);
+#ifdef PCS_DEBUG
+		pr_debug("pcs_read: %p %p %u\n", 
+				(void *)p->address, (void *)p->orig_address, 
+				swp_offset(p->swap_address));
+#endif
+	}
+
+	for (i = 0; i < nr_copy_pcs; i++) {
+		entry = (pagedir_cache + i)->swap_address;
+		if (entry.val)
+			swap_free(entry);
+	}
+	free_pages((unsigned long)pagedir_cache, pcs_order);
+
+	printk("\b\b\b\bdone\n");
+
+	page_cache_unlock();
+
+	return (0);
+}
+
+static int pcs_write(void)
+{
+	int error = 0;
+	int i;
+	int mod = nr_copy_pcs / 100;
+
+	printk( "Writing PageCaches to swap (%d pages)...     ", nr_copy_pcs);
+	for (i = 0; i < nr_copy_pcs && !error; i++) {
+		if (!(i%100))
+			printk( "\b\b\b\b%3d%%", i / mod );
+		error = write_page((pagedir_cache+i)->address,
+					  &((pagedir_cache+i)->swap_address));
+#ifdef PCS_DEBUG
+		pr_debug("pcs_write: %p %p %u\n", 
+				(void *)(pagedir_cache+i)->address, 
+				(void *)(pagedir_cache+i)->orig_address,
+				(pagedir_cache+i)->swap_address);
+#endif
+	}
+	printk("\b\b\b\bdone\n");
+
+	return error;
+}
+
+static void count_data_pages(void);
+static int swsusp_alloc(void);
+
+static void page_caches_recal(void)
+{
+	struct zone *zone;
+	int i;
+
+	for (i = 0; i < max_mapnr; i++)
+		ClearPagePcs(mem_map+i);
+
+	nr_copy_pcs = 0;
+	drain_local_pages();
+	for_each_zone(zone) {
+		if (!is_highmem(zone)) {
+			nr_copy_pcs += count_pcs(zone, NULL);
+		}
+	}
+}
+
+int write_page_caches(void)
+{
+	struct zone *zone;
+	suspend_pagedir_t *pe = NULL;
+	int error;
+	int recal = 0;
+
+	page_cache_lock();
+	page_caches_recal();
+
+	if (nr_copy_pcs == 0) {
+		page_cache_unlock();
+		return (0);
+	}
+	printk("swsusp: Need to copy %u pcs\n", nr_copy_pcs);
+
+	if ((error = swsusp_swap_check())) {
+		page_cache_unlock();
+		return error;
+	}
+
+	if ((error = alloc_pagedir_cache())) {
+		page_cache_unlock();
+		return error;
+	}
+
+	drain_local_pages();
+	count_data_pages();
+	printk("swsusp(1/2): Need to copy %u pages, %u pcs\n",
+			nr_copy_pages, nr_copy_pcs);
+
+	while (nr_free_pages() < nr_copy_pages + PAGES_FOR_IO) {
+		if (recal == 0) {
+			page_cache_unlock();
+		}
+		printk("#");
+		shrink_all_memory(nr_copy_pages + PAGES_FOR_IO);
+		recal ++;
+	}
+
+	if (recal) {
+		page_cache_lock();
+		page_caches_recal();
+		drain_local_pages();
+		count_data_pages();
+		printk("swsusp(1/2): Need to copy %u pages, %u pcs\n",
+				nr_copy_pages, nr_copy_pcs);
+	}
+	
+	drain_local_pages();
+	count_data_pages();
+	printk("swsusp(2/2): Need to copy %u pages, %u pcs\n",
+			nr_copy_pages, nr_copy_pcs);
+
+	error = swsusp_alloc();
+	if (error) {
+		printk("swsusp_alloc failed, %d\n", error);
+		return error;
+	}
+
+	drain_local_pages();
+	count_data_pages();
+	printk("swsusp(final): Need to copy %u/%u pages, %u pcs\n",
+			nr_copy_pages, nr_copy_pages_check, nr_copy_pcs);
+
+	pe = pagedir_cache;
+
+	drain_local_pages();
+	for_each_zone(zone) {
+		if (!is_highmem(zone)) {
+			count_pcs(zone, &pe);
+		}
+	}
+	error = pcs_write();
+	if (error) 
+		return error;
+
+	return (0);
+}
 
 static int pfn_is_nosave(unsigned long pfn)
 {
@@ -539,7 +867,10 @@
 	}
 	if (PageNosaveFree(page))
 		return 0;
-
+	if (PagePcs(page)) {
+		BUG_ON(zone->nr_inactive == 0 && zone->nr_active == 0);
+		return 0;
+	}
 	return 1;
 }
 
@@ -549,10 +880,12 @@
 	unsigned long zone_pfn;
 
 	nr_copy_pages = 0;
+	nr_copy_pcs = 0;
 
 	for_each_zone(zone) {
 		if (is_highmem(zone))
 			continue;
+		nr_copy_pcs += count_pcs(zone, NULL);
 		mark_free_pages(zone);
 		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
 			nr_copy_pages += saveable(zone, &zone_pfn);
@@ -588,47 +921,6 @@
 }
 
 
-/**
- *	calc_order - Determine the order of allocation needed for pagedir_save.
- *
- *	This looks tricky, but is just subtle. Please fix it some time.
- *	Since there are %nr_copy_pages worth of pages in the snapshot, we need
- *	to allocate enough contiguous space to hold 
- *		(%nr_copy_pages * sizeof(struct pbe)), 
- *	which has the saved/orig locations of the page.. 
- *
- *	SUSPEND_PD_PAGES() tells us how many pages we need to hold those 
- *	structures, then we call get_bitmask_order(), which will tell us the
- *	last bit set in the number, starting with 1. (If we need 30 pages, that
- *	is 0x0000001e in hex. The last bit is the 5th, which is the order we 
- *	would use to allocate 32 contiguous pages).
- *
- *	Since we also need to save those pages, we add the number of pages that
- *	we need to nr_copy_pages, and in case of an overflow, do the 
- *	calculation again to update the number of pages needed. 
- *
- *	With this model, we will tend to waste a lot of memory if we just cross
- *	an order boundary. Plus, the higher the order of allocation that we try
- *	to do, the more likely we are to fail in a low-memory situtation 
- *	(though	we're unlikely to get this far in such a case, since swsusp 
- *	requires half of memory to be free anyway).
- */
-
-
-static void calc_order(void)
-{
-	int diff = 0;
-	int order = 0;
-
-	do {
-		diff = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages)) - order;
-		if (diff) {
-			order += diff;
-			nr_copy_pages += 1 << diff;
-		}
-	} while(diff);
-	pagedir_order = order;
-}
 
 
 /**
@@ -640,13 +932,15 @@
 
 static int alloc_pagedir(void)
 {
-	calc_order();
+	calc_order(&pagedir_order, &nr_copy_pages);
 	pagedir_save = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC | __GFP_COLD,
 							     pagedir_order);
 	if (!pagedir_save)
 		return -ENOMEM;
 	memset(pagedir_save, 0, (1 << pagedir_order) * PAGE_SIZE);
+	
 	pagedir_nosave = pagedir_save;
+	pr_debug("pagedir %p, %d\n", pagedir_save, pagedir_order);
 	return 0;
 }
 
@@ -752,15 +1046,16 @@
 		return -ENOSPC;
 
 	if ((error = alloc_pagedir())) {
-		pr_debug("suspend: Allocating pagedir failed.\n");
+		printk("suspend: Allocating pagedir failed.\n");
 		return error;
 	}
 	if ((error = alloc_image_pages())) {
-		pr_debug("suspend: Allocating image pages failed.\n");
+		printk("suspend: Allocating image pages failed.\n");
 		swsusp_free();
 		return error;
 	}
 
+	nr_copy_pages_check = nr_copy_pages;
 	pagedir_order_check = pagedir_order;
 	return 0;
 }
@@ -768,7 +1063,6 @@
 int suspend_prepare_image(void)
 {
 	unsigned int nr_needed_pages;
-	int error;
 
 	pr_debug("swsusp: critical section: \n");
 	if (save_highmem()) {
@@ -777,15 +1071,8 @@
 		return -ENOMEM;
 	}
 
-	drain_local_pages();
-	count_data_pages();
-	printk("swsusp: Need to copy %u pages\n",nr_copy_pages);
 	nr_needed_pages = nr_copy_pages + PAGES_FOR_IO;
 
-	error = swsusp_alloc();
-	if (error)
-		return error;
-	
 	/* During allocating of suspend pagedir, new cold pages may appear. 
 	 * Kill them.
 	 */
@@ -855,7 +1142,8 @@
 asmlinkage int swsusp_restore(void)
 {
 	BUG_ON (pagedir_order_check != pagedir_order);
-	
+	BUG_ON (nr_copy_pages_check != nr_copy_pages);
+
 	/* Even mappings of "global" things (vmalloc) need to be fixed */
 	__flush_tlb_global();
 	wbinvd();	/* Nigel says wbinvd here is good idea... */
@@ -993,7 +1281,7 @@
 	return 0;
 }
 
-static struct block_device * resume_bdev;
+static struct block_device * resume_bdev __nosavedata;
 
 /**
  *	submit - submit BIO request.
@@ -1141,6 +1429,11 @@
 			printk( "\b\b\b\b%3d%%", i / mod );
 		error = bio_read_page(swp_offset(p->swap_address),
 				  (void *)p->address);
+#ifdef PCS_DEBUG
+		pr_debug("data_read: %p %p %u\n", 
+				(void *)p->address, (void *)p->orig_address, 
+				swp_offset(p->swap_address));
+#endif
 	}
 	printk(" %d done.\n",i);
 	return error;
@@ -1207,7 +1500,7 @@
 	if (!IS_ERR(resume_bdev)) {
 		set_blocksize(resume_bdev, PAGE_SIZE);
 		error = read_suspend_image();
-		blkdev_put(resume_bdev);
+		/* blkdev_put(resume_bdev); */
 	} else
 		error = PTR_ERR(resume_bdev);
 
Only in linux-2.6.9-peval-hg-ppc.old/kernel/power: swsusp.c.rej
diff -ur linux-2.6.9-peval-hg/kernel/sys.c linux-2.6.9-peval-hg-ppc.old/kernel/sys.c
--- linux-2.6.9-peval-hg/kernel/sys.c	2004-11-20 14:14:45.000000000 +0800
+++ linux-2.6.9-peval-hg-ppc.old/kernel/sys.c	2004-11-20 16:17:05.000000000 +0800
@@ -84,7 +84,7 @@
  *	and the like. 
  */
 
-static struct notifier_block *reboot_notifier_list;
+struct notifier_block *reboot_notifier_list;
 rwlock_t notifier_lock = RW_LOCK_UNLOCKED;
 
 /**

--
Hu Gang / Steve
Linux Registered User 204016
GPG Public Key: http://soulinfo.com/~hugang/hugang.asc

