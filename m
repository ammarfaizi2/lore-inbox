Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266733AbUAXEl2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 23:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266861AbUAXEl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 23:41:28 -0500
Received: from gate.crashing.org ([63.228.1.57]:38108 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266733AbUAXEku (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 23:40:50 -0500
Subject: pmdisk working on ppc (WAS: Help port swsusp to ppc)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Patrick Mochel <mochel@digitalimplant.org>, Pavel Machek <pavel@ucw.cz>,
       Nigel Cunningham <ncunningham@users.sourceforge.net>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Hugang <hugang@soulinfo.com>
In-Reply-To: <20040123183030.02fd16d6@localhost>
References: <20040119105237.62a43f65@localhost>
	 <1074483354.10595.5.camel@gaston> <1074489645.2111.8.camel@laptop-linux>
	 <1074490463.10595.16.camel@gaston> <1074534964.2505.6.camel@laptop-linux>
	 <1074549790.10595.55.camel@gaston> <20040122211746.3ec1018c@localhost>
	 <1074841973.974.217.camel@gaston>  <20040123183030.02fd16d6@localhost>
Content-Type: text/plain
Message-Id: <1074919185.814.82.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 24 Jan 2004 15:39:45 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(RESENT, sorry if you got it already, something apparently went wrong
on the SMTP here)

Ok, I hammered that for a day and got pmdisk (patrick's version) suspending
and resuming on a pismo G3 (with XFree etc.. running). Lots of rough edges
still (via-pmu sleep need to be improved, ADB need porting to the new driver
model to be properly suspended/resumed, a sysdev for RTC is needed too for
time, the asm code should be fixed for G5, etc...)

I had to fix some issues in the core pmdisk code though. One big one is that
lots of drivers expect suspend to disk to be state 4 while the current code
used state 3 for that (and suspend to RAM to be state 3 btw). I hacked that
in include/linux/suspend.h, but we shall probably just get rid of those
stupid numbers and properly define each constant indstead.

We should also use a different state for the suspend calls done before saving
the image, and the ones done before resuming the image, some driver may be
optimized for these cases.

The patch is against my tree currently, and the arch/ppc/kernel/pmdisk.S file
is appended as-is (not in patch form). I don't plan to release that right now,
I may hack a bit on it in the "background" (I want to get HIGHMEM working
some day). Feel free to improve, but then keep me informed please.

Ah, also: The "Freeing memory" phase takes forever. That should really be fixed.

Ben.

First the patch:

===== arch/ppc/Kconfig 1.60 vs edited =====
--- 1.60/arch/ppc/Kconfig	Wed Jan 21 11:29:19 2004
+++ edited/arch/ppc/Kconfig	Fri Jan 23 17:03:20 2004
@@ -913,6 +913,8 @@
 
 source "drivers/zorro/Kconfig"
 
+source kernel/power/Kconfig
+
 endmenu
 
 menu "Bus options"
===== arch/ppc/kernel/Makefile 1.61 vs edited =====
--- 1.61/arch/ppc/kernel/Makefile	Wed Jan 21 11:29:20 2004
+++ edited/arch/ppc/kernel/Makefile	Fri Jan 23 16:57:28 2004
@@ -15,6 +15,7 @@
 extra-$(CONFIG_8xx)		:= head_8xx.o
 extra-$(CONFIG_6xx)		+= idle_6xx.o
 extra-$(CONFIG_POWER4)		+= idle_power4.o
+
 extra-y				+= vmlinux.lds.s
 
 obj-y				:= entry.o traps.o irq.o idle.o time.o misc.o \
@@ -22,6 +23,7 @@
 					semaphore.o syscalls.o setup.o \
 					cputable.o ppc_htab.o
 obj-$(CONFIG_6xx)		+= l2cr.o cpu_setup_6xx.o
+obj-$(CONFIG_PM_DISK)		+= pmdisk.o
 obj-$(CONFIG_POWER4)		+= cpu_setup_power4.o
 obj-$(CONFIG_MODULES)		+= module.o ppc_ksyms.o
 obj-$(CONFIG_PCI)		+= pci.o
===== arch/ppc/kernel/signal.c 1.37 vs edited =====
--- 1.37/arch/ppc/kernel/signal.c	Fri Nov 28 12:13:45 2003
+++ edited/arch/ppc/kernel/signal.c	Fri Jan 23 18:47:07 2004
@@ -28,6 +28,7 @@
 #include <linux/elf.h>
 #include <linux/tty.h>
 #include <linux/binfmts.h>
+#include <linux/suspend.h>
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -563,6 +564,11 @@
 	struct k_sigaction *ka;
 	unsigned long frame, newsp;
 	int signr, ret;
+
+	if (current->flags & PF_FREEZE) {
+		refrigerator(0);
+		return 0;
+	}
 
 	if (!oldset)
 		oldset = &current->blocked;
===== arch/ppc/kernel/vmlinux.lds.S 1.39 vs edited =====
--- 1.39/arch/ppc/kernel/vmlinux.lds.S	Mon Nov 17 12:29:47 2003
+++ edited/arch/ppc/kernel/vmlinux.lds.S	Fri Jan 23 18:26:26 2004
@@ -72,6 +72,12 @@
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
 
===== arch/ppc/platforms/pmac_setup.c 1.48 vs edited =====
--- 1.48/arch/ppc/platforms/pmac_setup.c	Sat Nov  1 12:36:52 2003
+++ edited/arch/ppc/platforms/pmac_setup.c	Fri Jan 23 18:08:18 2004
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
 
@@ -425,11 +428,65 @@
 #endif
 }
 
+/* TODO: Merge the suspend-to-ram with the common code !!!
+ * currently, this is a stub implementation for suspend-to-disk
+ * only
+ */
+
+#ifdef CONFIG_PM_DISK
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
+#endif /* CONFIG_PM_DISK */
+
 static int initializing = 1;
 
 static int pmac_late_init(void)
 {
 	initializing = 0;
+
+#ifdef CONFIG_PM_DISK
+	pm_set_ops(&pmac_pm_ops);
+#endif /* CONFIG_PM_DISK */
 	return 0;
 }
 
===== drivers/ide/ppc/pmac.c 1.47 vs edited =====
--- 1.47/drivers/ide/ppc/pmac.c	Mon Nov  3 09:30:01 2003
+++ edited/drivers/ide/ppc/pmac.c	Sat Jan 24 13:17:26 2004
@@ -1366,7 +1366,7 @@
 	ide_hwif_t	*hwif = (ide_hwif_t *)dev_get_drvdata(&mdev->ofdev.dev);
 	int		rc = 0;
 
-	if (state != mdev->ofdev.dev.power_state && state >= 2) {
+	if (state != mdev->ofdev.dev.power_state && state >= 2 && state != 4) {
 		rc = pmac_ide_do_suspend(hwif);
 		if (rc == 0)
 			mdev->ofdev.dev.power_state = state;
@@ -1469,7 +1469,7 @@
 	ide_hwif_t	*hwif = (ide_hwif_t *)pci_get_drvdata(pdev);
 	int		rc = 0;
 	
-	if (state != pdev->dev.power_state && state >= 2) {
+	if (state != pdev->dev.power_state && state >= 2  && state != 4) {
 		rc = pmac_ide_do_suspend(hwif);
 		if (rc == 0)
 			pdev->dev.power_state = state;
===== drivers/macintosh/Kconfig 1.1 vs edited =====
--- 1.1/drivers/macintosh/Kconfig	Fri Jan  9 14:50:21 2004
+++ edited/drivers/macintosh/Kconfig	Fri Jan 23 17:03:41 2004
@@ -29,7 +29,7 @@
 
 config PMAC_PBOOK
 	bool "Power management support for PowerBooks"
-	depends on ADB_PMU
+	depends on PM && ADB_PMU
 	---help---
 	  This provides support for putting a PowerBook to sleep; it also
 	  enables media bay support.  Power management works on the
@@ -46,10 +46,10 @@
 	  have it autoloaded. The act of removing the module shuts down the
 	  sound hardware for more power savings.
 
-config PM
-	bool
-	depends on PPC_PMAC && ADB_PMU && PMAC_PBOOK
-	default y
+#config PM
+#	bool
+#	depends on PPC_PMAC && ADB_PMU && PMAC_PBOOK
+#	default y
 
 config PMAC_APM_EMU
 	tristate "APM emulation"
===== drivers/macintosh/mediabay.c 1.23 vs edited =====
--- 1.23/drivers/macintosh/mediabay.c	Sun Oct  5 09:22:51 2003
+++ edited/drivers/macintosh/mediabay.c	Sat Jan 24 12:49:53 2004
@@ -703,7 +703,7 @@
 {
 	struct media_bay_info	*bay = macio_get_drvdata(mdev);
 
-	if (state != mdev->ofdev.dev.power_state && state >= 2) {
+	if (state != mdev->ofdev.dev.power_state && state >= 2 && state != 4) {
 		down(&bay->lock);
 		bay->sleeping = 1;
 		set_mb_power(bay, 0);
===== drivers/macintosh/via-pmu.c 1.54 vs edited =====
--- 1.54/drivers/macintosh/via-pmu.c	Wed Nov  5 18:01:27 2003
+++ edited/drivers/macintosh/via-pmu.c	Fri Jan 23 18:17:17 2004
@@ -43,6 +43,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/device.h>
+#include <linux/sysdev.h>
 #include <linux/suspend.h>
 #include <asm/prom.h>
 #include <asm/machdep.h>
@@ -3074,6 +3075,88 @@
 	return 0;
 }
 #endif /* DEBUG_SLEEP */
+
+
+/* FIXME: This is a temporary set of callbacks to enable us
+ * to do suspend-to-disk.
+ */
+
+#ifdef CONFIG_PM
+
+static int pmu_sys_suspended = 0;
+
+static int pmu_sys_suspend(struct sys_device *sysdev, u32 state)
+{
+	if (state != PM_SUSPEND_DISK || pmu_sys_suspended)
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
+	rc = sys_device_register(&device_pmu);
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
 
 EXPORT_SYMBOL(pmu_request);
 EXPORT_SYMBOL(pmu_poll);
===== drivers/video/aty/aty128fb.c 1.34 vs edited =====
--- 1.34/drivers/video/aty/aty128fb.c	Tue Oct 14 17:28:07 2003
+++ edited/drivers/video/aty/aty128fb.c	Sat Jan 24 12:49:28 2004
@@ -2251,13 +2251,16 @@
 	 * can properly take care of D3 ? Also, with swsusp, we
 	 * know we'll be rebooted, ...
 	 */
+	if (state != 2 && state != 3)
+		return 0;
+
 #ifdef CONFIG_PPC_PMAC
 	/* HACK ALERT ! Once I find a proper way to say to each driver
 	 * individually what will happen with it's PCI slot, I'll change
 	 * that. On laptops, the AGP slot is just unclocked, so D2 is
 	 * expected, while on desktops, the card is powered off
 	 */
-	if (state >= 3)
+	if (state == 3)
 		state = 2;
 #endif /* CONFIG_PPC_PMAC */
 	 
===== drivers/video/aty/radeon_pm.c 1.4 vs edited =====
--- 1.4/drivers/video/aty/radeon_pm.c	Wed Jan 21 17:00:06 2004
+++ edited/drivers/video/aty/radeon_pm.c	Fri Jan 23 18:55:16 2004
@@ -845,6 +845,8 @@
 	 */
 
 	printk(KERN_DEBUG "radeonfb: suspending to state: %d...\n", state);
+	if (state != 2 && state != 3)
+		return 0;
 	
 	acquire_console_sem();
 
===== include/linux/pm.h 1.9 vs edited =====
--- 1.9/include/linux/pm.h	Tue Aug 26 06:03:37 2003
+++ edited/include/linux/pm.h	Fri Jan 23 18:56:02 2004
@@ -195,10 +195,10 @@
 extern void (*pm_power_off)(void);
 
 enum {
-	PM_SUSPEND_ON,
-	PM_SUSPEND_STANDBY,
-	PM_SUSPEND_MEM,
-	PM_SUSPEND_DISK,
+	PM_SUSPEND_ON = 0,
+	PM_SUSPEND_STANDBY = 1,
+	PM_SUSPEND_MEM = 3,
+	PM_SUSPEND_DISK = 4,
 	PM_SUSPEND_MAX,
 };
 
===== include/linux/reboot.h 1.5 vs edited =====
--- 1.5/include/linux/reboot.h	Thu Aug  7 04:47:22 2003
+++ edited/include/linux/reboot.h	Sat Jan 24 12:31:11 2004
@@ -40,6 +40,8 @@
 extern int register_reboot_notifier(struct notifier_block *);
 extern int unregister_reboot_notifier(struct notifier_block *);
 
+/* For use by swsusp only */
+extern struct notifier_block *reboot_notifier_list;
 
 /*
  * Architecture-specific implementations of sys_reboot commands.
===== include/linux/suspend.h 1.22 vs edited =====
--- 1.22/include/linux/suspend.h	Tue Oct 14 17:28:08 2003
+++ edited/include/linux/suspend.h	Fri Jan 23 18:06:56 2004
@@ -1,9 +1,9 @@
 #ifndef _LINUX_SWSUSP_H
 #define _LINUX_SWSUSP_H
 
-#ifdef CONFIG_X86
+//#ifdef CONFIG_X86
 #include <asm/suspend.h>
-#endif
+//#endif
 #include <linux/swap.h>
 #include <linux/notifier.h>
 #include <linux/config.h>
===== kernel/sys.c 1.68 vs edited =====
--- 1.68/kernel/sys.c	Wed Jan 21 11:29:32 2004
+++ edited/kernel/sys.c	Sat Jan 24 12:30:31 2004
@@ -84,7 +84,7 @@
  *	and the like. 
  */
 
-static struct notifier_block *reboot_notifier_list;
+struct notifier_block *reboot_notifier_list;
 rwlock_t notifier_lock = RW_LOCK_UNLOCKED;
 
 /**
===== kernel/power/disk.c 1.6 vs edited =====
--- 1.6/kernel/power/disk.c	Thu Oct  2 04:52:48 2003
+++ edited/kernel/power/disk.c	Sat Jan 24 12:31:31 2004
@@ -16,6 +16,7 @@
 #include <linux/string.h>
 #include <linux/delay.h>
 #include <linux/fs.h>
+#include <linux/reboot.h>
 #include "power.h"
 

@@ -46,23 +47,26 @@
 	unsigned long flags;
 	int error = 0;
 
-	local_irq_save(flags);
-	device_power_down(PM_SUSPEND_DISK);
 	switch(mode) {
 	case PM_DISK_PLATFORM:
+		local_irq_save(flags);
 		error = pm_ops->enter(PM_SUSPEND_DISK);
+		local_irq_restore(flags);
 		break;
 	case PM_DISK_SHUTDOWN:
 		printk("Powering off system\n");
+		notifier_call_chain(&reboot_notifier_list, SYS_POWER_OFF, NULL);
+		device_shutdown();
 		machine_power_off();
 		break;
 	case PM_DISK_REBOOT:
+		printk("Rebooting system\n");
+		notifier_call_chain(&reboot_notifier_list, SYS_RESTART, NULL);
+		device_shutdown();
 		machine_restart(NULL);
 		break;
 	}
 	machine_halt();
-	device_power_up();
-	local_irq_restore(flags);
 	return 0;
 }
 
@@ -163,8 +167,10 @@
 
 	pr_debug("PM: snapshotting memory.\n");
 	in_suspend = 1;
-	if ((error = pmdisk_save()))
+	if ((error = pmdisk_save())) {
+		pr_debug("PM: snapshot memory failed !\n");
 		goto Done;
+	}
 
 	if (in_suspend) {
 		pr_debug("PM: writing image.\n");
@@ -225,9 +231,6 @@
 	 * Do it with disabled interrupts for best effect. That way, if some
 	 * driver scheduled DMA, we have good chance for DMA to finish ;-).
 	 */
-	pr_debug("PM: Waiting for DMAs to settle down.\n");
-	mdelay(1000);
-
 	pr_debug("PM: Restoring saved image.\n");
 	pmdisk_restore();
 	pr_debug("PM: Restore failed, recovering.n");
===== kernel/power/main.c 1.16 vs edited =====
--- 1.16/kernel/power/main.c	Tue Sep  9 08:13:46 2003
+++ edited/kernel/power/main.c	Fri Jan 23 19:27:16 2004
@@ -120,6 +120,7 @@
 
 char * pm_states[] = {
 	[PM_SUSPEND_STANDBY]	= "standby",
+	[2]			= "",
 	[PM_SUSPEND_MEM]	= "mem",
 	[PM_SUSPEND_DISK]	= "disk",
 	NULL,
===== kernel/power/pmdisk.c 1.80 vs edited =====
--- 1.80/kernel/power/pmdisk.c	Thu Oct  2 04:52:48 2003
+++ edited/kernel/power/pmdisk.c	Sat Jan 24 13:52:30 2004
@@ -18,7 +18,7 @@
  *
  */
 
-#undef DEBUG
+#define DEBUG
 
 #include <linux/mm.h>
 #include <linux/bio.h>
@@ -28,6 +28,7 @@
 #include <linux/device.h>
 #include <linux/swapops.h>
 #include <linux/bootmem.h>
+#include <linux/utsname.h>
 
 #include <asm/mmu_context.h>
 
@@ -624,8 +625,10 @@
 {
 	int error = 0;
 
-	if ((error = read_swapfiles()))
+	if ((error = read_swapfiles())) {
+		printk("Can't read swapfiles\n");
 		return error;
+	}
 
 	drain_local_pages();
 
@@ -702,6 +705,7 @@
  * Magic happens here
  */
 
+#if 0
 int pmdisk_resume(void)
 {
 	BUG_ON (nr_copy_pages_check != pmdisk_pages);
@@ -711,6 +715,7 @@
 	__flush_tlb_global();
 	return 0;
 }
+#endif
 
 /* pmdisk_arch_suspend() is implemented in arch/?/power/pmdisk.S,
    and basically does:
@@ -1082,9 +1087,11 @@
 	if ((error = arch_prepare_suspend()))
 		return error;
 	local_irq_disable();
+	device_power_down(PM_SUSPEND_DISK);
 	save_processor_state();
 	error = pmdisk_arch_suspend(0);
 	restore_processor_state();
+	device_power_up();
 	local_irq_enable();
 	return error;
 }
@@ -1143,10 +1150,13 @@
 int __init pmdisk_restore(void)
 {
 	int error;
+
 	local_irq_disable();
+	device_power_down(PM_SUSPEND_DISK);
 	save_processor_state();
 	error = pmdisk_arch_suspend(1);
 	restore_processor_state();
+	device_power_up();
 	local_irq_enable();
 	return error;
 }

Then the arch/ppc/kernel/pmdisk.S file:

#include <linux/config.h>
#include <linux/threads.h>
#include <asm/processor.h>
#include <asm/page.h>
#include <asm/cputable.h>
#include <asm/thread_info.h>
#include <asm/ppc_asm.h>
#include <asm/offsets.h>


/*
 * Structure for storing CPU registers on the save area.
 */
#define SL_SP		0
#define SL_PC		4
#define SL_MSR		8
#define SL_SDR1		0xc
#define SL_SPRG0	0x10	/* 4 sprg's */
#define SL_DBAT0	0x20
#define SL_IBAT0	0x28
#define SL_DBAT1	0x30
#define SL_IBAT1	0x38
#define SL_DBAT2	0x40
#define SL_IBAT2	0x48
#define SL_DBAT3	0x50
#define SL_IBAT3	0x58
#define SL_TB		0x60
#define SL_R2		0x68
#define SL_CR		0x6c
#define SL_LR		0x70
#define SL_R12		0x74	/* r12 to r31 */
#define SL_SIZE		(SL_R12 + 80)

	.section .data
	.align	5

_GLOBAL(pmdisk_save_area)
	.space	SL_SIZE


	.section .text
	.align	5

_GLOBAL(pmdisk_arch_suspend)
	cmpi	0,r3,0
	bne	do_resume

	lis	r11,pmdisk_save_area@h
	ori	r11,r11,pmdisk_save_area@l

	mflr	r0
	stw	r0,SL_LR(r11)
	mfcr	r0
	stw	r0,SL_CR(r11)
	stw	r1,SL_SP(r11)
	stw	r2,SL_R2(r11)
	stmw	r12,SL_R12(r11)

	/* Save MSR & SDR1 */
	mfmsr	r4
	stw	r4,SL_MSR(r11)
	mfsdr1	r4
	stw	r4,SL_SDR1(r11)

	/* Get a stable timebase and save it */
1:	mftbu	r4
	stw	r4,SL_TB(r11)
	mftb	r5
	stw	r5,SL_TB+4(r11)
	mftbu	r3
	cmpw	r3,r4
	bne	1b

	/* Save SPRGs */
	mfsprg	r4,0
	stw	r4,SL_SPRG0(r11)
	mfsprg	r4,1
	stw	r4,SL_SPRG0+4(r11)
	mfsprg	r4,2
	stw	r4,SL_SPRG0+8(r11)
	mfsprg	r4,3
	stw	r4,SL_SPRG0+12(r11)

	/* Save BATs */
	mfdbatu	r4,0
	stw	r4,SL_DBAT0(r11)
	mfdbatl	r4,0
	stw	r4,SL_DBAT0+4(r11)
	mfdbatu	r4,1
	stw	r4,SL_DBAT1(r11)
	mfdbatl	r4,1
	stw	r4,SL_DBAT1+4(r11)
	mfdbatu	r4,2
	stw	r4,SL_DBAT2(r11)
	mfdbatl	r4,2
	stw	r4,SL_DBAT2+4(r11)
	mfdbatu	r4,3
	stw	r4,SL_DBAT3(r11)
	mfdbatl	r4,3
	stw	r4,SL_DBAT3+4(r11)
	mfibatu	r4,0
	stw	r4,SL_IBAT0(r11)
	mfibatl	r4,0
	stw	r4,SL_IBAT0+4(r11)
	mfibatu	r4,1
	stw	r4,SL_IBAT1(r11)
	mfibatl	r4,1
	stw	r4,SL_IBAT1+4(r11)
	mfibatu	r4,2
	stw	r4,SL_IBAT2(r11)
	mfibatl	r4,2
	stw	r4,SL_IBAT2+4(r11)
	mfibatu	r4,3
	stw	r4,SL_IBAT3(r11)
	mfibatl	r4,3
	stw	r4,SL_IBAT3+4(r11)

#if  0
	/* Backup various CPU config stuffs */
	bl	__save_cpu_setup
#endif
	/* Call the low level suspend stuff (we should probably have made
	 * a stackframe...
	 */
	bl	pmdisk_suspend
	
	/* Restore LR from the save area */
	lis	r11,pmdisk_save_area@h
	ori	r11,r11,pmdisk_save_area@l
	lwz	r0,SL_LR(r11)
	mtlr	r0

	blr


/* Resume code */	
do_resume:

	/* Stop pending alitvec streams and memory accesses */
BEGIN_FTR_SECTION
	DSSALL
END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	sync

	/* Disable MSR:DR to make sure we don't take a TLB or
	 * hash miss during the copy, as our hash table will
	 * for a while be unuseable. For .text, we assume we are
	 * covered by a BAT. This works only for non-G5 at this
	 * point. G5 will need a better approach, possibly using
	 * a small temporary hash table filled with large mappings,
	 * disabling the MMU completely isn't a good option for
	 * performance reasons.
	 * (Note that 750's may have the same performance issue as
	 * the G5 in this case, we should investigate using moving
	 * BATs for these CPUs)
	 */
	mfmsr	r0
	sync
	rlwinm	r0,r0,0,28,26		/* clear MSR_DR */
	mtmsr	r0
	sync
	isync

	/* Load ptr the list of pages to copy in r3 */
	lis	r11,(pm_pagedir_nosave - KERNELBASE)@h
	ori	r11,r11,pm_pagedir_nosave@l
	lwz	r10,0(r11)
	tophys(r3,r10)

	/* Load the count of pages to copy in r4 */
	lis	r11,(pmdisk_pages - KERNELBASE)@h
	ori	r11,r11,pmdisk_pages@l
	lwz	r4,0(r11)
	

	/* Copy the pages. This is a very basic implementation, to
	 * be replaced by something more cache efficient */
1:
	li	r0,256
	mtctr	r0
	lwz	r11,0(r3)	/* source */
	tophys(r5,r11)
	lwz	r10,4(r3)	/* destination */
	tophys(r6,r10)
2:
	lwz	r8,0(r5)
	lwz	r9,4(r5)
	lwz	r10,8(r5)
	lwz	r11,12(r5)
	addi	r5,r5,16
	stw	r8,0(r6)
	stw	r9,4(r6)
	stw	r10,8(r6)
	stw	r11,12(r6)
	addi	r6,r6,16
	bdnz	2b
	addi	r3,r3,16
	subi	r4,r4,1
	cmpwi	0,r4,0
	bne	1b
	
	/* Do a very simple cache flush/inval of the L1 to ensure
	 * coherency of the icache
	 */
	lis	r3,0x0002
	mtctr	r3
	li	r3, 0
1:
	lwz	r0,0(r3)
	addi	r3,r3,0x0020
	bdnz	1b
	isync
	sync

	/* Now flush those cache lines */
	lis	r3,0x0002
	mtctr	r3
	li	r3, 0
1:
	dcbf	0,r3
	addi	r3,r3,0x0020
	bdnz	1b
	sync

	/* Ok, we are now running with the kernel data of the old
	 * kernel fully restored. We can get to the save area
	 * easily now. As for the rest of the code, it assumes the
	 * loader kernel and the booted one are exactly identical
	 */
	lis	r11,pmdisk_save_area@h
	ori	r11,r11,pmdisk_save_area@l
	tophys(r11,r11)
	
#if 0
	/* Restore various CPU config stuffs */
	bl	__restore_cpu_setup
#endif
	/* Restore the BATs, and SDR1.  Then we can turn on the MMU. 
	 * This is a bit hairy as we are running out of those BATs,
	 * but first, our code is probably in the icache, and we are
	 * writing the same value to the BAT, so that should be fine,
	 * though a better solution will have to be found long-term
	 */
	lwz	r4,SL_SDR1(r11)
	mtsdr1	r4
	lwz	r4,SL_SPRG0(r11)
	mtsprg	0,r4
	lwz	r4,SL_SPRG0+4(r11)
	mtsprg	1,r4
	lwz	r4,SL_SPRG0+8(r11)
	mtsprg	2,r4
	lwz	r4,SL_SPRG0+12(r11)
	mtsprg	3,r4

#if 0
	lwz	r4,SL_DBAT0(r11)
	mtdbatu	0,r4
	lwz	r4,SL_DBAT0+4(r11)
	mtdbatl	0,r4
	lwz	r4,SL_DBAT1(r11)
	mtdbatu	1,r4
	lwz	r4,SL_DBAT1+4(r11)
	mtdbatl	1,r4
	lwz	r4,SL_DBAT2(r11)
	mtdbatu	2,r4
	lwz	r4,SL_DBAT2+4(r11)
	mtdbatl	2,r4
	lwz	r4,SL_DBAT3(r11)
	mtdbatu	3,r4
	lwz	r4,SL_DBAT3+4(r11)
	mtdbatl	3,r4
	lwz	r4,SL_IBAT0(r11)
	mtibatu	0,r4
	lwz	r4,SL_IBAT0+4(r11)
	mtibatl	0,r4
	lwz	r4,SL_IBAT1(r11)
	mtibatu	1,r4
	lwz	r4,SL_IBAT1+4(r11)
	mtibatl	1,r4
	lwz	r4,SL_IBAT2(r11)
	mtibatu	2,r4
	lwz	r4,SL_IBAT2+4(r11)
	mtibatl	2,r4
	lwz	r4,SL_IBAT3(r11)
	mtibatu	3,r4
	lwz	r4,SL_IBAT3+4(r11)
	mtibatl	3,r4
#endif

BEGIN_FTR_SECTION
	li	r4,0
	mtspr	SPRN_DBAT4U,r4
	mtspr	SPRN_DBAT4L,r4
	mtspr	SPRN_DBAT5U,r4
	mtspr	SPRN_DBAT5L,r4
	mtspr	SPRN_DBAT6U,r4
	mtspr	SPRN_DBAT6L,r4
	mtspr	SPRN_DBAT7U,r4
	mtspr	SPRN_DBAT7L,r4
	mtspr	SPRN_IBAT4U,r4
	mtspr	SPRN_IBAT4L,r4
	mtspr	SPRN_IBAT5U,r4
	mtspr	SPRN_IBAT5L,r4
	mtspr	SPRN_IBAT6U,r4
	mtspr	SPRN_IBAT6L,r4
	mtspr	SPRN_IBAT7U,r4
	mtspr	SPRN_IBAT7L,r4
END_FTR_SECTION_IFSET(CPU_FTR_HAS_HIGH_BATS)

	/* Flush all TLBs */
	lis	r4,0x1000
1:	addic.	r4,r4,-0x1000
	tlbie	r4
	blt	1b
	sync

	/* restore the MSR and turn on the MMU */
	lwz	r3,SL_MSR(r11)
	bl	turn_on_mmu
	tovirt(r11,r11)

	/* Restore TB */
	li	r3,0
	mttbl	r3
	lwz	r3,SL_TB(r11)
	lwz	r4,SL_TB+4(r11)
	mttbu	r3
	mttbl	r4

	/* Kick decrementer */
	li	r0,1
	mtdec	r0

	/* Restore the callee-saved registers and return */
	lwz	r0,SL_CR(r11)
	mtcr	r0
	lwz	r2,SL_R2(r11)
	lmw	r12,SL_R12(r11)
	lwz	r1,SL_SP(r11)
	lwz	r0,SL_LR(r11)
	mtlr	r0

	// XXX Note: we don't really need to call pmdisk_resume

	li	r3,0
	blr

/* FIXME:This construct is actually not useful since we don't shut
 * down the instruction MMU, we could just flip back MSR-DR on.
 */
turn_on_mmu:
	mflr	r4
	mtsrr0	r4
	mtsrr1	r3
	sync
	isync
	rfi


