Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261895AbVCANQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbVCANQj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 08:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbVCANQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 08:16:39 -0500
Received: from gprs215-241.eurotel.cz ([160.218.215.241]:39391 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261895AbVCANMl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 08:12:41 -0500
Date: Tue, 1 Mar 2005 14:12:20 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc4-mm1: something is wrong with swsusp powerdown
Message-ID: <20050301131220.GF1843@elf.ucw.cz>
References: <20050228231721.GA1326@elf.ucw.cz> <20050301020722.6faffb69.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050301020722.6faffb69.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> btw, suspend is a bit messy.  The disk spins down.  Then up.  Then down
> again.  And:

Here's preview patch to make disk not do stupid yo-yo. Please do not
apply (it will probably not apply cleanly anyway).

I can fix disk going yo-yo without switching pm_message_t to struct,
but will have to back parts of that later. Do you want patch?
								Pavel

--- clean/drivers/base/power/resume.c	2004-12-25 13:34:59.000000000 +0100
+++ linux/drivers/base/power/resume.c	2005-02-28 15:38:51.000000000 +0100
@@ -41,7 +41,7 @@
 		list_add_tail(entry, &dpm_active);
 
 		up(&dpm_list_sem);
-		if (!dev->power.prev_state)
+		if (!dev->power.prev_state EVENT)
 			resume_device(dev);
 		down(&dpm_list_sem);
 		put_device(dev);
--- clean/drivers/base/power/runtime.c	2005-01-12 11:07:39.000000000 +0100
+++ linux/drivers/base/power/runtime.c	2005-02-28 15:42:10.000000000 +0100
@@ -13,10 +13,10 @@
 static void runtime_resume(struct device * dev)
 {
 	dev_dbg(dev, "resuming\n");
-	if (!dev->power.power_state)
+	if (!dev->power.power_state EVENT)
 		return;
 	if (!resume_device(dev))
-		dev->power.power_state = 0;
+		dev->power.power_state = PMSG_ON;
 }
 
 
@@ -49,10 +49,10 @@
 	int error = 0;
 
 	down(&dpm_sem);
-	if (dev->power.power_state == state)
+	if (dev->power.power_state EVENT == state EVENT)
 		goto Done;
 
-	if (dev->power.power_state)
+	if (dev->power.power_state EVENT)
 		runtime_resume(dev);
 
 	if (!(error = suspend_device(dev, state)))
--- clean/drivers/base/power/shutdown.c	2004-08-15 19:14:55.000000000 +0200
+++ linux/drivers/base/power/shutdown.c	2005-01-12 10:57:23.000000000 +0100
@@ -29,7 +29,8 @@
 			dev->driver->shutdown(dev);
 		return 0;
 	}
-	return dpm_runtime_suspend(dev, dev->detach_state);
+	/* FIXME */
+	return dpm_runtime_suspend(dev, PMSG_FREEZE);
 }
 
 
--- clean/drivers/base/power/suspend.c	2005-01-12 11:07:39.000000000 +0100
+++ linux/drivers/base/power/suspend.c	2005-02-28 21:30:13.000000000 +0100
@@ -43,7 +43,7 @@
 
 	dev->power.prev_state = dev->power.power_state;
 
-	if (dev->bus && dev->bus->suspend && !dev->power.power_state)
+	if (dev->bus && dev->bus->suspend && (!dev->power.power_state EVENT))
 		error = dev->bus->suspend(dev, state);
 
 	return error;
@@ -134,6 +134,8 @@
  Done:
 	return error;
  Error:
+	printk(KERN_ERR "Could not power down device %s: "
+		"error %d\n", kobject_name(&dev->kobj), error);
 	dpm_power_up();
 	goto Done;
 }
--- clean/drivers/base/power/sysfs.c	2004-08-15 19:14:55.000000000 +0200
+++ linux/drivers/base/power/sysfs.c	2005-02-28 15:43:57.000000000 +0100
@@ -26,19 +26,20 @@
 
 static ssize_t state_show(struct device * dev, char * buf)
 {
-	return sprintf(buf, "%u\n", dev->power.power_state);
+	return sprintf(buf, "%u\n", dev->power.power_state EVENT);
 }
 
 static ssize_t state_store(struct device * dev, const char * buf, size_t n)
 {
-	u32 state;
+	pm_message_t state;
 	char * rest;
 	int error = 0;
 
-	state = simple_strtoul(buf, &rest, 10);
+	state EVENT = simple_strtoul(buf, &rest, 10);
+//	state.flags = PFL_RUNTIME;
 	if (*rest)
 		return -EINVAL;
-	if (state)
+	if (state EVENT)
 		error = dpm_runtime_suspend(dev, state);
 	else
 		dpm_runtime_resume(dev);
--- clean/drivers/ide/ide-disk.c	2005-02-14 14:12:21.000000000 +0100
+++ linux/drivers/ide/ide-disk.c	2005-02-14 22:34:43.000000000 +0100
@@ -872,7 +872,7 @@
 {
 	switch (rq->pm->pm_step) {
 	case idedisk_pm_flush_cache:	/* Suspend step 1 (flush cache) complete */
-		if (rq->pm->pm_state == 4)
+		if (rq->pm->pm_state == EVENT_FREEZE)
 			rq->pm->pm_step = ide_pm_state_completed;
 		else
 			rq->pm->pm_step = idedisk_pm_standby;
@@ -1155,8 +1155,7 @@
 		return;
 	}
 
-	printk("Shutdown: %s\n", drive->name);
-	dev->bus->suspend(dev, PM_SUSPEND_STANDBY);
+	dev->bus->suspend(dev, PMSG_SUSPEND);
 }
 
 /*
--- clean/drivers/ide/ide.c	2005-02-28 00:50:42.000000000 +0100
+++ linux/drivers/ide/ide.c	2005-02-28 15:48:21.000000000 +0100
@@ -1398,7 +1398,7 @@
 	rq.special = &args;
 	rq.pm = &rqpm;
 	rqpm.pm_step = ide_pm_state_start_suspend;
-	rqpm.pm_state = state;
+	rqpm.pm_state = state EVENT;
 
 	return ide_do_drive_cmd(drive, &rq, ide_wait);
 }
@@ -1417,7 +1417,7 @@
 	rq.special = &args;
 	rq.pm = &rqpm;
 	rqpm.pm_step = ide_pm_state_start_resume;
-	rqpm.pm_state = 0;
+	rqpm.pm_state = EVENT_ON;
 
 	return ide_do_drive_cmd(drive, &rq, ide_head_wait);
 }
--- clean/drivers/pci/pci.c	2005-02-28 00:50:43.000000000 +0100
+++ linux/drivers/pci/pci.c	2005-02-28 15:54:24.000000000 +0100
@@ -312,22 +312,27 @@
 /**
  * pci_choose_state - Choose the power state of a PCI device
  * @dev: PCI device to be suspended
- * @state: target sleep state for the whole system
+ * @state: target sleep state for the whole system. This is the value
+ *	that is passed to suspend() function.
  *
  * Returns PCI power state suitable for given device and given system
  * message.
  */
 
-pci_power_t pci_choose_state(struct pci_dev *dev, u32 state)
+pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state)
 {
 	if (!pci_find_capability(dev, PCI_CAP_ID_PM))
 		return PCI_D0;
 
-	switch (state) {
-	case 0:	return PCI_D0;
-	case 2: return PCI_D2;
-	case 3: return PCI_D3hot;
-	default: BUG();
+	switch (state EVENT) {
+	case EVENT_ON:
+	case EVENT_FREEZE:
+		return PCI_D0;
+	case EVENT_SUSPEND:
+		return PCI_D3hot;
+	default: 
+		printk("They asked me for state %d\n", state EVENT);
+		BUG();
 	}
 	return PCI_D0;
 }
--- clean/drivers/usb/core/usb.c	2005-01-22 21:24:52.000000000 +0100
+++ linux/drivers/usb/core/usb.c	2005-02-28 16:01:01.000000000 +0100
@@ -1364,7 +1364,7 @@
 	driver = to_usb_driver(dev->driver);
 
 	/* there's only one USB suspend state */
-	if (intf->dev.power.power_state)
+	if (intf->dev.power.power_state EVENT)
 		return 0;
 
 	if (driver->suspend)
--- clean/drivers/usb/host/ehci-dbg.c	2005-01-12 11:07:40.000000000 +0100
+++ linux/drivers/usb/host/ehci-dbg.c	2005-02-14 22:35:42.000000000 +0100
@@ -641,7 +641,7 @@
 
 	spin_lock_irqsave (&ehci->lock, flags);
 
-	if (bus->controller->power.power_state) {
+	if (bus->controller->power.power_state.event) {
 		size = scnprintf (next, size,
 			"bus %s, device %s (driver " DRIVER_VERSION ")\n"
 			"SUSPENDED (no register access)\n",
--- clean/drivers/usb/host/ohci-dbg.c	2005-01-12 11:07:40.000000000 +0100
+++ linux/drivers/usb/host/ohci-dbg.c	2005-02-14 22:35:42.000000000 +0100
@@ -625,7 +625,7 @@
 		hcd->self.controller->bus_id,
 		hcd_name);
 
-	if (bus->controller->power.power_state) {
+	if (bus->controller->power.power_state.event) {
 		size -= scnprintf (next, size,
 			"SUSPENDED (no register access)\n");
 		goto done;
--- clean/drivers/video/aty/atyfb_base.c	2005-02-28 00:50:43.000000000 +0100
+++ linux/drivers/video/aty/atyfb_base.c	2005-02-28 00:50:54.000000000 +0100
@@ -2070,12 +2070,12 @@
 	struct fb_info *info = pci_get_drvdata(pdev);
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 
-	if (pdev->dev.power.power_state == 0)
+	if (pdev->dev.power.power_state.event == EVENT_ON)
 		return 0;
 
 	acquire_console_sem();
 
-	if (pdev->dev.power.power_state == 2)
+	if (pdev->dev.power.power_state.event == 2)
 		aty_power_mgmt(0, par);
 	par->asleep = 0;
 
@@ -2091,7 +2091,7 @@
 
 	release_console_sem();
 
-	pdev->dev.power.power_state = 0;
+	pdev->dev.power.power_state = PMSG_ON;
 
 	return 0;
 }
--- clean/drivers/video/aty/radeon_pm.c	2005-02-28 00:50:43.000000000 +0100
+++ linux/drivers/video/aty/radeon_pm.c	2005-02-28 16:06:12.000000000 +0100
@@ -2501,31 +2501,25 @@
 }
 
 
-static/*extern*/ int susdisking = 0;
-
-int radeonfb_pci_suspend(struct pci_dev *pdev, u32 state)
+int radeonfb_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 {
         struct fb_info *info = pci_get_drvdata(pdev);
         struct radeonfb_info *rinfo = info->par;
 	int i;
 
-	if (state == pdev->dev.power.power_state)
+	if (state EVENT == pdev->dev.power.power_state EVENT)
 		return 0;
 
 	printk(KERN_DEBUG "radeonfb (%s): suspending to state: %d...\n",
-	       pci_name(pdev), state);
+	       pci_name(pdev), state EVENT);
 
 	/* For suspend-to-disk, we cheat here. We don't suspend anything and
 	 * let fbcon continue drawing until we are all set. That shouldn't
 	 * really cause any problem at this point, provided that the wakeup
 	 * code knows that any state in memory may not match the HW
 	 */
-	if (state != PM_SUSPEND_MEM)
-		goto done;
-	if (susdisking) {
-		printk("suspending to disk but state = %d\n", state);
+	if (state EVENT == EVENT_FREEZE)
 		goto done;
-	}
 
 	acquire_console_sem();
 
@@ -2596,7 +2590,7 @@
         struct radeonfb_info *rinfo = info->par;
 	int rc = 0;
 
-	if (pdev->dev.power.power_state == 0)
+	if (pdev->dev.power.power_state EVENT == EVENT_ON)
 		return 0;
 
 	if (rinfo->no_schedule) {
@@ -2606,7 +2600,7 @@
 		acquire_console_sem();
 
 	printk(KERN_DEBUG "radeonfb (%s): resuming from state: %d...\n",
-	       pci_name(pdev), pdev->dev.power.power_state);
+	       pci_name(pdev), pdev->dev.power.power_state EVENT);
 
 
 	if (pci_enable_device(pdev)) {
@@ -2617,7 +2611,7 @@
 	}
 	pci_set_master(pdev);
 
-	if (pdev->dev.power.power_state == PM_SUSPEND_MEM) {
+	if (pdev->dev.power.power_state EVENT == EVENT_SUSPEND) {
 		/* Wakeup chip. Check from config space if we were powered off
 		 * (todo: additionally, check CLK_PIN_CNTL too)
 		 */
@@ -2663,7 +2657,7 @@
 	else if (rinfo->dynclk == 0)
 		radeon_pm_disable_dynamic_mode(rinfo);
 
-	pdev->dev.power.power_state = 0;
+	pdev->dev.power.power_state = PMSG_ON;
 
  bail:
 	release_console_sem();
--- clean/drivers/video/i810/i810_main.c	2005-01-22 21:24:52.000000000 +0100
+++ linux/drivers/video/i810/i810_main.c	2005-01-30 23:53:29.000000000 +0100
@@ -1492,18 +1492,18 @@
 /***********************************************************************
  *                         Power Management                            *
  ***********************************************************************/
-static int i810fb_suspend(struct pci_dev *dev, u32 state)
+static int i810fb_suspend(struct pci_dev *dev, pm_message_t state)
 {
 	struct fb_info *info = pci_get_drvdata(dev);
 	struct i810fb_par *par = (struct i810fb_par *) info->par;
 	int blank = 0, prev_state = par->cur_state;
 
-	if (state == prev_state)
+	if (state.event == prev_state)
 		return 0;
 
-	par->cur_state = state;
+	par->cur_state = state.event;
 
-	switch (state) {
+	switch (state.event) {
 	case 1:
 		blank = VESA_VSYNC_SUSPEND;
 		break;
--- clean/include/linux/pm.h	2005-01-12 11:07:40.000000000 +0100
+++ linux/include/linux/pm.h	2005-02-28 18:08:20.000000000 +0100
@@ -195,7 +195,11 @@
 
 struct device;
 
-typedef u32 __bitwise pm_message_t;
+#if 1
+typedef struct pm_message {
+	int event;
+	int flags;
+} pm_message_t;
 
 /*
  * There are 4 important states driver can be in:
@@ -215,9 +219,32 @@
  * or something similar soon.
  */
 
-#define PMSG_FREEZE	((__force pm_message_t) 3)
-#define PMSG_SUSPEND	((__force pm_message_t) 3)
-#define PMSG_ON		((__force pm_message_t) 0)
+#define EVENT_ON 0
+#define EVENT_FREEZE 1
+#define EVENT_SUSPEND 2
+
+#define PFL_RUNTIME 1
+
+#define PMSG_FREEZE	({struct pm_message m; m.event = EVENT_FREEZE; m.flags = 0; m; })
+#define PMSG_SUSPEND	({struct pm_message m; m.event = EVENT_SUSPEND; m.flags = 0; m; })
+#define PMSG_ON		({struct pm_message m; m.event = EVENT_ON; m.flags = 0; m; })
+#define EVENT .event
+#else
+
+typedef u32 pm_message_t;
+
+#define EVENT_ON 0
+#define EVENT_FREEZE 2
+#define EVENT_SUSPEND 3
+
+#define PFL_RUNTIME 1
+
+#define PMSG_FREEZE	EVENT_FREEZE
+#define PMSG_SUSPEND	EVENT_SUSPEND
+#define PMSG_ON		EVENT_ON
+#define EVENT
+#endif
+
 
 struct dev_pm_info {
 	pm_message_t		power_state;
--- clean/kernel/power/main.c	2005-02-03 22:27:26.000000000 +0100
+++ linux/kernel/power/main.c	2005-02-28 01:16:02.000000000 +0100
@@ -65,8 +65,10 @@
 			goto Thaw;
 	}
 
-	if ((error = device_suspend(PMSG_SUSPEND)))
+	if ((error = device_suspend(PMSG_SUSPEND))) {
+		printk(KERN_ERR "Some devices failed to suspend\n");
 		goto Finish;
+	}
 	return 0;
  Finish:
 	if (pm_ops->finish)
@@ -85,8 +87,10 @@
 
 	local_irq_save(flags);
 
-	if ((error = device_power_down(PMSG_SUSPEND)))
+	if ((error = device_power_down(PMSG_SUSPEND))) {
+		printk(KERN_ERR "Some devices failed to power down\n");		
 		goto Done;
+	}
 	error = pm_ops->enter(state);
 	device_power_up();
  Done:
--- clean/kernel/sys.c	2005-01-12 11:07:40.000000000 +0100
+++ linux/kernel/sys.c	2005-01-12 11:12:10.000000000 +0100
@@ -402,6 +402,7 @@
 	case LINUX_REBOOT_CMD_HALT:
 		notifier_call_chain(&reboot_notifier_list, SYS_HALT, NULL);
 		system_state = SYSTEM_HALT;
+		device_suspend(PMSG_SUSPEND);
 		device_shutdown();
 		printk(KERN_EMERG "System halted.\n");
 		machine_halt();
@@ -412,6 +413,7 @@
 	case LINUX_REBOOT_CMD_POWER_OFF:
 		notifier_call_chain(&reboot_notifier_list, SYS_POWER_OFF, NULL);
 		system_state = SYSTEM_POWER_OFF;
+		device_suspend(PMSG_SUSPEND);
 		device_shutdown();
 		printk(KERN_EMERG "Power down.\n");
 		machine_power_off();
@@ -428,6 +430,7 @@
 
 		notifier_call_chain(&reboot_notifier_list, SYS_RESTART, buffer);
 		system_state = SYSTEM_RESTART;
+		device_suspend(PMSG_FREEZE);
 		device_shutdown();
 		printk(KERN_EMERG "Restarting system with command '%s'.\n", buffer);
 		machine_restart(buffer);


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
