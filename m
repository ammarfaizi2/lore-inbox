Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261923AbUKCV4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbUKCV4r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 16:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbUKCVzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 16:55:46 -0500
Received: from gprs214-112.eurotel.cz ([160.218.214.112]:13955 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261923AbUKCVv0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 16:51:26 -0500
Date: Wed, 3 Nov 2004 22:50:47 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: type-checking for driver model
Message-ID: <20041103215047.GA1907@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This adds type-checking to driver model. No code changes, but it
should enable us to switch to structure easier in future. Please
apply,

								Pavel

%patch
Index: linux/arch/i386/kernel/apm.c
===================================================================
--- linux.orig/arch/i386/kernel/apm.c	2004-10-29 11:45:54.000000000 +0200
+++ linux/arch/i386/kernel/apm.c	2004-11-01 18:36:52.000000000 +0100
@@ -1201,8 +1201,8 @@
 		printk(KERN_CRIT "apm: suspend was vetoed, but suspending anyway.\n");
 	}
 
-	device_suspend(3);
-	device_power_down(3);
+	device_suspend(PMSG_SUSPEND);
+	device_power_down(PMSG_SUSPEND);
 
 	/* serialize with the timer interrupt */
 	write_seqlock_irq(&xtime_lock);
@@ -1255,7 +1255,7 @@
 {
 	int	err;
 
-	device_power_down(3);
+	device_power_down(PMSG_SUSPEND);
 	/* serialize with the timer interrupt */
 	write_seqlock_irq(&xtime_lock);
 	/* If needed, notify drivers here */
Index: linux/drivers/base/power/power.h
===================================================================
--- linux.orig/drivers/base/power/power.h	2004-10-29 11:45:54.000000000 +0200
+++ linux/drivers/base/power/power.h	2004-10-29 11:56:59.000000000 +0200
@@ -66,14 +66,14 @@
 /*
  * suspend.c
  */
-extern int suspend_device(struct device *, u32);
+extern int suspend_device(struct device *, pm_message_t);
 
 
 /*
  * runtime.c
  */
 
-extern int dpm_runtime_suspend(struct device *, u32);
+extern int dpm_runtime_suspend(struct device *, pm_message_t);
 extern void dpm_runtime_resume(struct device *);
 
 #else /* CONFIG_PM */
@@ -88,7 +88,7 @@
 
 }
 
-static inline int dpm_runtime_suspend(struct device * dev, u32 state)
+static inline int dpm_runtime_suspend(struct device * dev, pm_message_t state)
 {
 	return 0;
 }
Index: linux/drivers/base/power/resume.c
===================================================================
--- linux.orig/drivers/base/power/resume.c	2004-10-29 11:45:54.000000000 +0200
+++ linux/drivers/base/power/resume.c	2004-10-29 11:56:59.000000000 +0200
@@ -36,7 +36,7 @@
 		struct device * dev = to_device(entry);
 		list_del_init(entry);
 
-		if (!dev->power.prev_state)
+		if (dev->power.prev_state == PMSG_ON)
 			resume_device(dev);
 
 		list_add_tail(entry, &dpm_active);
Index: linux/drivers/base/power/runtime.c
===================================================================
--- linux.orig/drivers/base/power/runtime.c	2004-10-29 11:45:54.000000000 +0200
+++ linux/drivers/base/power/runtime.c	2004-10-29 11:56:59.000000000 +0200
@@ -13,10 +13,10 @@
 static void runtime_resume(struct device * dev)
 {
 	dev_dbg(dev, "resuming\n");
-	if (!dev->power.power_state)
+	if (dev->power.power_state == PMSG_ON)
 		return;
 	if (!resume_device(dev))
-		dev->power.power_state = 0;
+		dev->power.power_state = PMSG_ON;
 }
 
 
@@ -44,7 +44,7 @@
  *	@state:	State to enter.
  */
 
-int dpm_runtime_suspend(struct device * dev, u32 state)
+int dpm_runtime_suspend(struct device * dev, pm_message_t state)
 {
 	int error = 0;
 
@@ -52,7 +52,7 @@
 	if (dev->power.power_state == state)
 		goto Done;
 
-	if (dev->power.power_state)
+	if (dev->power.power_state != PMSG_ON)
 		runtime_resume(dev);
 
 	if (!(error = suspend_device(dev, state)))
@@ -73,7 +73,7 @@
  *	always be able to tell, but we need accurate information to
  *	work reliably.
  */
-void dpm_set_power_state(struct device * dev, u32 state)
+void dpm_set_power_state(struct device * dev, pm_message_t state)
 {
 	down(&dpm_sem);
 	dev->power.power_state = state;
Index: linux/drivers/base/power/shutdown.c
===================================================================
--- linux.orig/drivers/base/power/shutdown.c	2004-10-29 11:45:54.000000000 +0200
+++ linux/drivers/base/power/shutdown.c	2004-11-01 18:40:40.000000000 +0100
@@ -29,7 +29,8 @@
 			dev->driver->shutdown(dev);
 		return 0;
 	}
-	return dpm_runtime_suspend(dev, dev->detach_state);
+	/* FIXME */
+	return dpm_runtime_suspend(dev, PMSG_FREEZE);
 }
 
 
Index: linux/drivers/base/power/suspend.c
===================================================================
--- linux.orig/drivers/base/power/suspend.c	2004-10-29 11:45:54.000000000 +0200
+++ linux/drivers/base/power/suspend.c	2004-10-29 11:56:59.000000000 +0200
@@ -11,7 +11,7 @@
 #include <linux/device.h>
 #include "power.h"
 
-extern int sysdev_suspend(u32 state);
+extern int sysdev_suspend(pm_message_t state);
 
 /*
  * The entries in the dpm_active list are in a depth first order, simply
@@ -35,7 +35,7 @@
  *	@state:	Power state device is entering.
  */
 
-int suspend_device(struct device * dev, u32 state)
+int suspend_device(struct device * dev, pm_message_t state)
 {
 	int error = 0;
 
@@ -43,7 +43,7 @@
 
 	dev->power.prev_state = dev->power.power_state;
 
-	if (dev->bus && dev->bus->suspend && !dev->power.power_state)
+	if (dev->bus && dev->bus->suspend && (dev->power.power_state == PMSG_ON))
 		error = dev->bus->suspend(dev, state);
 
 	return error;
@@ -70,7 +70,7 @@
  *
  */
 
-int device_suspend(u32 state)
+int device_suspend(pm_message_t state)
 {
 	int error = 0;
 
@@ -112,7 +112,7 @@
  *	done, power down system devices.
  */
 
-int device_power_down(u32 state)
+int device_power_down(pm_message_t state)
 {
 	int error = 0;
 	struct device * dev;
Index: linux/drivers/usb/core/hcd-pci.c
===================================================================
--- linux.orig/drivers/usb/core/hcd-pci.c	2004-10-29 11:45:54.000000000 +0200
+++ linux/drivers/usb/core/hcd-pci.c	2004-10-29 11:56:59.000000000 +0200
@@ -355,8 +355,8 @@
 	hcd->state = USB_STATE_RESUMING;
 
 	if (has_pci_pm)
-		pci_set_power_state (dev, 0);
-	dev->dev.power.power_state = 0;
+		pci_set_power_state (dev, PCI_D0);
+	dev->dev.power.power_state = PMSG_ON;
 	retval = request_irq (dev->irq, usb_hcd_irq, SA_SHIRQ,
 				hcd->description, hcd);
 	if (retval < 0) {
Index: linux/drivers/usb/host/ohci-hub.c
===================================================================
--- linux.orig/drivers/usb/host/ohci-hub.c	2004-10-29 11:45:54.000000000 +0200
+++ linux/drivers/usb/host/ohci-hub.c	2004-10-29 11:56:59.000000000 +0200
@@ -76,7 +76,7 @@
 	struct usb_device	*root = hcd_to_bus (&ohci->hcd)->root_hub;
 	int			status = 0;
 
-	if (root->dev.power.power_state != 0)
+	if (root->dev.power.power_state != PMSG_ON)
 		return 0;
 	if (time_before (jiffies, ohci->next_statechange))
 		return -EAGAIN;
Index: linux/include/linux/pm.h
===================================================================
--- linux.orig/include/linux/pm.h	2004-10-29 11:45:54.000000000 +0200
+++ linux/include/linux/pm.h	2004-11-01 23:46:45.000000000 +0100
@@ -195,10 +195,34 @@
 
 struct device;
 
+typedef u32 __bitwise pm_message_t;
+
+/*
+ * There are 4 important states driver can be in:
+ * ON     -- driver is working
+ * FREEZE -- stop operations and apply whatever policy is applicable to a suspended driver
+ *           of that class, freeze queues for block like IDE does, drop packets for
+ *           ethernet, etc... stop DMA engine too etc... so a consistent image can be
+ *           saved; but do not power any hardware down.
+ * SUSPEND - like FREEZE, but hardware is doing as much powersaving as possible. Roughly
+ *           pci D3.
+ *
+ * Unfortunately, current drivers only recognize numeric values 0 (ON) and 3 (SUSPEND).
+ * We'll need to fix the drivers. So yes, putting 3 to all diferent defines is intentional,
+ * and will go away as soon as drivers are fixed. Also note that typedef is neccessary,
+ * we'll probably want to switch to
+ *   typedef struct pm_message_t { int event; int flags; } pm_message_t
+ * or something similar soon.
+ */
+
+#define PMSG_FREEZE	((__force pm_message_t) 3)
+#define PMSG_SUSPEND	((__force pm_message_t) 3)
+#define PMSG_ON		((__force pm_message_t) 0)
+
 struct dev_pm_info {
-	u32			power_state;
+	pm_message_t			power_state;
 #ifdef	CONFIG_PM
-	u32			prev_state;
+	pm_message_t			prev_state;
 	u8			* saved_state;
 	atomic_t		pm_users;
 	struct device		* pm_parent;
@@ -208,8 +232,8 @@
 
 extern void device_pm_set_parent(struct device * dev, struct device * parent);
 
-extern int device_suspend(u32 state);
-extern int device_power_down(u32 state);
+extern int device_suspend(pm_message_t state);
+extern int device_power_down(pm_message_t state);
 extern void device_power_up(void);
 extern void device_resume(void);
 
Index: linux/kernel/power/disk.c
===================================================================
--- linux.orig/kernel/power/disk.c	2004-10-29 11:56:46.000000000 +0200
+++ linux/kernel/power/disk.c	2004-11-01 23:50:41.000000000 +0100
@@ -51,7 +51,7 @@
 	local_irq_save(flags);
 	switch(mode) {
 	case PM_DISK_PLATFORM:
-		device_power_down(PM_SUSPEND_DISK);
+ 		device_power_down(PMSG_SUSPEND);
 		error = pm_ops->enter(PM_SUSPEND_DISK);
 		break;
 	case PM_DISK_SHUTDOWN:
@@ -116,6 +116,7 @@
 
 static void finish(void)
 {
+	sysdev_resume();
 	device_resume();
 	platform_finish();
 	enable_nonboot_cpus();
@@ -147,8 +148,12 @@
 	free_some_memory();
 
 	disable_nonboot_cpus();
-	if ((error = device_suspend(PM_SUSPEND_DISK)))
+	if ((error = device_suspend(PMSG_FREEZE))) {
+		printk("Some devices failed to suspend\n");
 		goto Finish;
+	}
+
+	sysdev_suspend(PMSG_FREEZE);
 
 	return 0;
  Finish:
Index: linux/kernel/power/main.c
===================================================================
--- linux.orig/kernel/power/main.c	2004-10-29 11:45:54.000000000 +0200
+++ linux/kernel/power/main.c	2004-11-01 18:38:01.000000000 +0100
@@ -65,7 +65,7 @@
 			goto Thaw;
 	}
 
-	if ((error = device_suspend(state)))
+	if ((error = device_suspend(PMSG_SUSPEND)))
 		goto Finish;
 	return 0;
  Finish:
@@ -78,13 +78,14 @@
 }
 
 
-static int suspend_enter(u32 state)
+static int suspend_enter(suspend_state_t state)
 {
 	int error = 0;
 	unsigned long flags;
 
 	local_irq_save(flags);
-	if ((error = device_power_down(state)))
+
+	if ((error = device_power_down(PMSG_SUSPEND)))
 		goto Done;
 	error = pm_ops->enter(state);
 	device_power_up();
===================================================================
--- linux.orig/kernel/sys.c	2004-10-29 11:56:46.000000000 +0200
+++ linux/kernel/sys.c	2004-11-01 23:50:21.000000000 +0100
@@ -471,7 +471,7 @@
 	case LINUX_REBOOT_CMD_HALT:
 		notifier_call_chain(&reboot_notifier_list, SYS_HALT, NULL);
 		system_state = SYSTEM_HALT;
-		device_suspend(3);
+		device_suspend(PMSG_SUSPEND);
 		device_shutdown();
 		printk(KERN_EMERG "System halted.\n");
 		machine_halt();
@@ -482,7 +482,7 @@
 	case LINUX_REBOOT_CMD_POWER_OFF:
 		notifier_call_chain(&reboot_notifier_list, SYS_POWER_OFF, NULL);
 		system_state = SYSTEM_POWER_OFF;
-		device_suspend(3);
+		device_suspend(PMSG_SUSPEND);
 		device_shutdown();
 		printk(KERN_EMERG "Power down.\n");
 		machine_power_off();
@@ -499,7 +499,7 @@
 
 		notifier_call_chain(&reboot_notifier_list, SYS_RESTART, buffer);
 		system_state = SYSTEM_RESTART;
-		device_suspend(3);
+		device_suspend(PMSG_FREEZE);
 		device_shutdown();
 		printk(KERN_EMERG "Restarting system with command '%s'.\n", buffer);
 		machine_restart(buffer);

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
