Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbVADMnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbVADMnx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 07:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbVADMnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 07:43:53 -0500
Received: from gprs214-29.eurotel.cz ([160.218.214.29]:25997 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261519AbVADMkD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 07:40:03 -0500
Date: Tue, 4 Jan 2005 13:39:38 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: dm: introduce pm_message_t 
Message-ID: <20050104123938.GA13716@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This introduces pm_message_t. For now, it is only good for type-safety
and sparse checking, but plan is to turn pm_message_t into structure
soon. Please apply,
								Pavel

--- clean-mm/Documentation/power/devices.txt	2004-11-03 01:23:03.000000000 +0100
+++ linux-mm/Documentation/power/devices.txt	2005-01-04 13:10:14.000000000 +0100
@@ -118,6 +118,94 @@
 There is currently no way to know what states a device or driver
 supports a priori. This will change in the future. 
 
+pm_message_t meaning
+
+pm_message_t has two fields. event ("major"), and flags.  If driver
+does not know event code, it aborts the request, returning error. Some
+drivers may need to deal with special cases based on the actual type
+of suspend operation being done at the system level. This is why
+there are flags.
+
+Event codes are:
+
+ON -- no need to do anything except special cases like broken
+HW.
+
+# NOTIFICATION -- pretty much same as ON?
+
+FREEZE -- stop DMA and interrupts, and be prepared to reinit HW from
+scratch. That probably means stop accepting upstream requests, the
+actual policy of what to do with them beeing specific to a given
+driver. It's acceptable for a network driver to just drop packets
+while a block driver is expected to block the queue so no request is
+lost. (Use IDE as an example on how to do that). FREEZE requires no
+power state change, and it's expected for drivers to be able to
+quickly transition back to operating state.
+
+SUSPEND -- like FREEZE, but also put hardware into low-power state. If
+there's need to distinguish several levels of sleep, additional flag
+is probably best way to do that.
+
+Transitions are only from a resumed state to a suspended state, never
+between 2 suspended states. (ON -> FREEZE or ON -> SUSPEND can happen,
+FREEZE -> SUSPEND or SUSPEND -> FREEZE can not).
+
+All events are: 
+
+[NOTE NOTE NOTE: If you are driver author, you should not care; you
+should only look at event, and ignore flags.]
+
+#Prepare for suspend -- userland is still running but we are going to
+#enter suspend state. This gives drivers chance to load firmware from
+#disk and store it in memory, or do other activities taht require
+#operating userland, ability to kmalloc GFP_KERNEL, etc... All of these
+#are forbiden once the suspend dance is started.. event = ON, flags =
+#PREPARE_TO_SUSPEND
+
+Apm standby -- prepare for APM event. Quiesce devices to make life
+easier for APM BIOS. event = FREEZE, flags = APM_STANDBY
+
+Apm suspend -- same as APM_STANDBY, but it we should probably avoid
+spinning down disks. event = FREEZE, flags = APM_SUSPEND
+
+System halt, reboot -- quiesce devices to make life easier for BIOS. event
+= FREEZE, flags = SYSTEM_HALT or SYSTEM_REBOOT
+
+System shutdown -- at least disks need to be spun down, or data may be
+lost. Quiesce devices, just to make life easier for BIOS. event =
+FREEZE, flags = SYSTEM_SHUTDOWN
+
+Kexec    -- turn off DMAs and put hardware into some state where new
+kernel can take over. event = FREEZE, flags = KEXEC
+
+Powerdown at end of swsusp -- very similar to SYSTEM_SHUTDOWN, except wake
+may need to be enabled on some devices. This actually has at least 3
+subtypes, system can reboot, enter S4 and enter S5 at the end of
+swsusp. event = FREEZE, flags = SWSUSP and one of SYSTEM_REBOOT,
+SYSTEM_SHUTDOWN, SYSTEM_S4
+
+Suspend to ram  -- put devices into low power state. event = SUSPEND,
+flags = SUSPEND_TO_RAM
+
+Freeze for swsusp snapshot -- stop DMA and interrupts. No need to put
+devices into low power mode, but you must be able to reinitialize
+device from scratch in resume method. This has two flavors, its done
+once on suspending kernel, once on resuming kernel. event = FREEZE,
+flags = DURING_SUSPEND or DURING_RESUME
+
+Device detach requested from /sys -- deinitialize device; proably same as
+SYSTEM_SHUTDOWN, I do not understand this one too much. probably event
+= FREEZE, flags = DEV_DETACH.
+
+#These are not really events sent:
+#
+#System fully on -- device is working normally; this is probably never
+#passed to suspend() method... event = ON, flags = 0
+#
+#Ready after resume -- userland is now running, again. Time to free any
+#memory you ate during prepare to suspend... event = ON, flags =
+#READY_AFTER_RESUME
+#
 
 Driver Detach Power Management
 
--- clean-mm/arch/arm/common/amba.c	2004-12-25 13:34:57.000000000 +0100
+++ linux-mm/arch/arm/common/amba.c	2005-01-04 13:10:14.000000000 +0100
@@ -59,7 +59,7 @@
 #define amba_hotplug NULL
 #endif
 
-static int amba_suspend(struct device *dev, u32 state)
+static int amba_suspend(struct device *dev, pm_message_t state)
 {
 	struct amba_driver *drv = to_amba_driver(dev->driver);
 	int ret = 0;
--- clean-mm/arch/arm/common/locomo.c	2004-12-25 13:34:57.000000000 +0100
+++ linux-mm/arch/arm/common/locomo.c	2005-01-04 13:10:14.000000000 +0100
@@ -668,7 +668,7 @@
 	return dev->devid == drv->devid;
 }
 
-static int locomo_bus_suspend(struct device *dev, u32 state)
+static int locomo_bus_suspend(struct device *dev, pm_message_t state)
 {
 	struct locomo_dev *ldev = LOCOMO_DEV(dev);
 	struct locomo_driver *drv = LOCOMO_DRV(dev->driver);
--- clean-mm/arch/arm/common/sa1111.c	2004-12-25 13:34:57.000000000 +0100
+++ linux-mm/arch/arm/common/sa1111.c	2005-01-04 13:10:14.000000000 +0100
@@ -1194,7 +1194,7 @@
 	return dev->devid == drv->devid;
 }
 
-static int sa1111_bus_suspend(struct device *dev, u32 state)
+static int sa1111_bus_suspend(struct device *dev, pm_message_t state)
 {
 	struct sa1111_dev *sadev = SA1111_DEV(dev);
 	struct sa1111_driver *drv = SA1111_DRV(dev->driver);
--- clean-mm/drivers/base/platform.c	2004-12-25 13:34:59.000000000 +0100
+++ linux-mm/drivers/base/platform.c	2005-01-04 13:10:14.000000000 +0100
@@ -238,7 +238,7 @@
 	return (strncmp(pdev->name, drv->name, BUS_ID_SIZE) == 0);
 }
 
-static int platform_suspend(struct device * dev, u32 state)
+static int platform_suspend(struct device * dev, pm_message_t state)
 {
 	int ret = 0;
 
--- clean-mm/drivers/base/power/power.h	2004-12-25 13:34:59.000000000 +0100
+++ linux-mm/drivers/base/power/power.h	2005-01-04 13:10:14.000000000 +0100
@@ -71,14 +71,14 @@
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
@@ -93,7 +93,7 @@
 
 }
 
-static inline int dpm_runtime_suspend(struct device * dev, u32 state)
+static inline int dpm_runtime_suspend(struct device * dev, pm_message_t state)
 {
 	return 0;
 }
--- clean-mm/drivers/base/power/runtime.c	2004-08-15 19:14:55.000000000 +0200
+++ linux-mm/drivers/base/power/runtime.c	2005-01-04 13:10:14.000000000 +0100
@@ -44,7 +44,7 @@
  *	@state:	State to enter.
  */
 
-int dpm_runtime_suspend(struct device * dev, u32 state)
+int dpm_runtime_suspend(struct device * dev, pm_message_t state)
 {
 	int error = 0;
 
@@ -73,7 +73,7 @@
  *	always be able to tell, but we need accurate information to
  *	work reliably.
  */
-void dpm_set_power_state(struct device * dev, u32 state)
+void dpm_set_power_state(struct device * dev, pm_message_t state)
 {
 	down(&dpm_sem);
 	dev->power.power_state = state;
--- clean-mm/drivers/base/power/suspend.c	2004-12-25 13:34:59.000000000 +0100
+++ linux-mm/drivers/base/power/suspend.c	2005-01-04 13:10:14.000000000 +0100
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
 
@@ -65,7 +65,7 @@
  *
  */
 
-int device_suspend(u32 state)
+int device_suspend(pm_message_t state)
 {
 	int error = 0;
 
@@ -118,7 +118,7 @@
  *	done, power down system devices.
  */
 
-int device_power_down(u32 state)
+int device_power_down(pm_message_t state)
 {
 	int error = 0;
 	struct device * dev;
--- clean-mm/drivers/ide/ide.c	2005-01-03 17:15:42.000000000 +0100
+++ linux-mm/drivers/ide/ide.c	2005-01-04 13:10:14.000000000 +0100
@@ -1520,7 +1520,7 @@
 	return 1;
 }
 
-static int generic_ide_suspend(struct device *dev, u32 state)
+static int generic_ide_suspend(struct device *dev, pm_message_t state)
 {
 	ide_drive_t *drive = dev->driver_data;
 	struct request rq;
--- clean-mm/drivers/pci/pci-driver.c	2004-12-25 13:35:00.000000000 +0100
+++ linux-mm/drivers/pci/pci-driver.c	2005-01-04 13:10:14.000000000 +0100
@@ -284,7 +284,7 @@
 	return 0;
 }
 
-static int pci_device_suspend(struct device * dev, u32 state)
+static int pci_device_suspend(struct device * dev, pm_message_t state)
 {
 	struct pci_dev * pci_dev = to_pci_dev(dev);
 	struct pci_driver * drv = pci_dev->driver;
--- clean-mm/include/linux/device.h	2004-12-25 13:35:03.000000000 +0100
+++ linux-mm/include/linux/device.h	2005-01-04 13:10:14.000000000 +0100
@@ -61,7 +61,7 @@
 	int		(*match)(struct device * dev, struct device_driver * drv);
 	int		(*hotplug) (struct device *dev, char **envp, 
 				    int num_envp, char *buffer, int buffer_size);
-	int		(*suspend)(struct device * dev, u32 state);
+	int		(*suspend)(struct device * dev, pm_message_t state);
 	int		(*resume)(struct device * dev);
 };
 
--- clean-mm/include/linux/pm.h	2005-01-03 17:15:43.000000000 +0100
+++ linux-mm/include/linux/pm.h	2005-01-04 13:18:05.000000000 +0100
@@ -222,10 +222,34 @@
 
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
+	pm_message_t		power_state;
 #ifdef	CONFIG_PM
-	u32			prev_state;
+	pm_message_t		prev_state;
 	void			* saved_state;
 	atomic_t		pm_users;
 	struct device		* pm_parent;
@@ -235,8 +259,8 @@
 
 extern void device_pm_set_parent(struct device * dev, struct device * parent);
 
-extern int device_suspend(u32 state);
-extern int device_power_down(u32 state);
+extern int device_suspend(pm_message_t state);
+extern int device_power_down(pm_message_t state);
 extern void device_power_up(void);
 extern void device_resume(void);
 

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
