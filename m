Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbVCVM0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVCVM0z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 07:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbVCVM0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 07:26:54 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:41178 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261159AbVCVMX3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 07:23:29 -0500
Date: Tue, 22 Mar 2005 13:22:51 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: rjw@sisk.pl, linux-kernel@vger.kernel.org, len.brown@intel.com,
       Greg KH <greg@kroah.com>
Subject: pm_message_t to struct conversion [was Re: 2.6.12-rc1-mm1: Kernel BUG at pci:389]
Message-ID: <20050322122251.GB1414@elf.ucw.cz>
References: <20050321025159.1cabd62e.akpm@osdl.org> <200503212343.31665.rjw@sisk.pl> <20050321160306.2f7221ec.akpm@osdl.org> <20050322004456.GB1372@elf.ucw.cz> <20050321170623.4eabc7f8.akpm@osdl.org> <20050322013535.GA1421@elf.ucw.cz> <20050321175232.34d93a13.akpm@osdl.org> <20050322020738.GA1628@elf.ucw.cz> <20050321182733.6a7e10f0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050321182733.6a7e10f0.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> to Linus when he reappears and then I'll duck for cover and let you guys
> sort it out ;)

There should be little reason for taking cover, that patches were just
anotating types... BTW this is how switch to pm_message_t is going to
look. If you are developing something pm-related, you should probably
do it against this tree.
								Pavel

--- clean/drivers/base/power/resume.c	2004-12-25 13:34:59.000000000 +0100
+++ linux/drivers/base/power/resume.c	2005-03-22 12:20:53.000000000 +0100
@@ -41,7 +41,7 @@
 		list_add_tail(entry, &dpm_active);
 
 		up(&dpm_list_sem);
-		if (!dev->power.prev_state)
+		if (!dev->power.prev_state.event)
 			resume_device(dev);
 		down(&dpm_list_sem);
 		put_device(dev);
--- clean/drivers/base/power/runtime.c	2005-01-12 11:07:39.000000000 +0100
+++ linux/drivers/base/power/runtime.c	2005-03-22 12:20:53.000000000 +0100
@@ -13,10 +13,10 @@
 static void runtime_resume(struct device * dev)
 {
 	dev_dbg(dev, "resuming\n");
-	if (!dev->power.power_state)
+	if (!dev->power.power_state.event)
 		return;
 	if (!resume_device(dev))
-		dev->power.power_state = 0;
+		dev->power.power_state = PMSG_ON;
 }
 
 
@@ -49,10 +49,10 @@
 	int error = 0;
 
 	down(&dpm_sem);
-	if (dev->power.power_state == state)
+	if (dev->power.power_state.event == state.event)
 		goto Done;
 
-	if (dev->power.power_state)
+	if (dev->power.power_state.event)
 		runtime_resume(dev);
 
 	if (!(error = suspend_device(dev, state)))
--- clean/drivers/base/power/shutdown.c	2004-08-15 19:14:55.000000000 +0200
+++ linux/drivers/base/power/shutdown.c	2005-03-22 12:20:53.000000000 +0100
@@ -29,7 +29,8 @@
 			dev->driver->shutdown(dev);
 		return 0;
 	}
-	return dpm_runtime_suspend(dev, dev->detach_state);
+	/* FIXME */
+	return dpm_runtime_suspend(dev, PMSG_FREEZE);
 }
 
 
--- clean/drivers/base/power/suspend.c	2005-01-12 11:07:39.000000000 +0100
+++ linux/drivers/base/power/suspend.c	2005-03-22 12:20:53.000000000 +0100
@@ -43,7 +43,7 @@
 
 	dev->power.prev_state = dev->power.power_state;
 
-	if (dev->bus && dev->bus->suspend && !dev->power.power_state)
+	if (dev->bus && dev->bus->suspend && (!dev->power.power_state.event))
 		error = dev->bus->suspend(dev, state);
 
 	return error;
--- clean/drivers/base/power/sysfs.c	2004-08-15 19:14:55.000000000 +0200
+++ linux/drivers/base/power/sysfs.c	2005-03-22 12:20:53.000000000 +0100
@@ -26,19 +26,20 @@
 
 static ssize_t state_show(struct device * dev, char * buf)
 {
-	return sprintf(buf, "%u\n", dev->power.power_state);
+	return sprintf(buf, "%u\n", dev->power.power_state.event);
 }
 
 static ssize_t state_store(struct device * dev, const char * buf, size_t n)
 {
-	u32 state;
+	pm_message_t state;
 	char * rest;
 	int error = 0;
 
-	state = simple_strtoul(buf, &rest, 10);
+	state.event = simple_strtoul(buf, &rest, 10);
+//	state.flags = PFL_RUNTIME;
 	if (*rest)
 		return -EINVAL;
-	if (state)
+	if (state.event)
 		error = dpm_runtime_suspend(dev, state);
 	else
 		dpm_runtime_resume(dev);
--- clean/drivers/ide/ide.c	2005-03-19 00:31:23.000000000 +0100
+++ linux/drivers/ide/ide.c	2005-03-22 12:20:53.000000000 +0100
@@ -1390,7 +1390,7 @@
 	rq.special = &args;
 	rq.pm = &rqpm;
 	rqpm.pm_step = ide_pm_state_start_suspend;
-	rqpm.pm_state = state;
+	rqpm.pm_state = state.event;
 
 	return ide_do_drive_cmd(drive, &rq, ide_wait);
 }
@@ -1409,7 +1409,7 @@
 	rq.special = &args;
 	rq.pm = &rqpm;
 	rqpm.pm_step = ide_pm_state_start_resume;
-	rqpm.pm_state = 0;
+	rqpm.pm_state = PM_EVENT_ON;
 
 	return ide_do_drive_cmd(drive, &rq, ide_head_wait);
 }
--- clean/drivers/pci/pci.c	2005-03-19 00:31:43.000000000 +0100
+++ linux/drivers/pci/pci.c	2005-03-22 12:20:53.000000000 +0100
@@ -312,22 +312,24 @@
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
-	if (!pci_find_capability(dev, PCI_CAP_ID_PM))
+	switch (state.event) {
+	case PM_EVENT_ON:
 		return PCI_D0;
-
-	switch (state) {
-	case 0:	return PCI_D0;
-	case 2: return PCI_D2;
-	case 3: return PCI_D3hot;
-	default: BUG();
+	case PM_EVENT_FREEZE:
+	case PM_EVENT_SUSPEND:
+		return PCI_D3hot;
+	default: 
+		printk("They asked me for state %d\n", state.event);
+		BUG();
 	}
 	return PCI_D0;
 }
--- clean/drivers/usb/core/hcd-pci.c	2005-03-19 00:31:51.000000000 +0100
+++ linux/drivers/usb/core/hcd-pci.c	2005-03-22 12:20:53.000000000 +0100
@@ -68,7 +68,7 @@
 	if (pci_enable_device (dev) < 0)
 		return -ENODEV;
 	dev->current_state = 0;
-	dev->dev.power.power_state = 0;
+	dev->dev.power.power_state.event = 0;
 	
         if (!dev->irq) {
         	dev_err (&dev->dev,
@@ -291,9 +294,6 @@
 		break;
 	}
 
-	/* update power_state **ONLY** to make sysfs happier */
-	if (retval == 0)
-		dev->dev.power.power_state = state;
 	return retval;
 }
 EXPORT_SYMBOL (usb_hcd_pci_suspend);
--- clean/drivers/usb/core/hub.c	2005-03-19 00:31:51.000000000 +0100
+++ linux/drivers/usb/core/hub.c	2005-03-22 12:20:53.000000000 +0100
@@ -1557,7 +1557,7 @@
 			struct usb_driver	*driver;
 
 			intf = udev->actconfig->interface[i];
-			if (state <= intf->dev.power.power_state)
+			if (state.event <= intf->dev.power.power_state.event)
 				continue;
 			if (!intf->dev.driver)
 				continue;
@@ -1565,11 +1565,11 @@
 
 			if (driver->suspend) {
 				status = driver->suspend(intf, state);
-				if (intf->dev.power.power_state != state
+				if (intf->dev.power.power_state.event != state.event
 						|| status)
 					dev_err(&intf->dev,
 						"suspend %d fail, code %d\n",
-						state, status);
+						state.event, status);
 			}
 
 			/* only drivers with suspend() can ever resume();
@@ -1582,7 +1582,7 @@
 			 * since we know every driver's probe/disconnect works
 			 * even for drivers that can't suspend.
 			 */
-			if (!driver->suspend || state > PM_SUSPEND_MEM) {
+			if (!driver->suspend || state.event > PM_EVENT_FREEZE) {
 #if 1
 				dev_warn(&intf->dev, "resume is unsafe!\n");
 #else
@@ -1603,7 +1603,7 @@
 	 * policies (when HNP doesn't apply) once we have mechanisms to
 	 * turn power back on!  (Likely not before 2.7...)
 	 */
-	if (state > PM_SUSPEND_MEM) {
+	if (state.event > PM_EVENT_FREEZE) {
 		dev_warn(&udev->dev, "no poweroff yet, suspending instead\n");
 	}
 
@@ -1718,7 +1718,7 @@
 			struct usb_driver	*driver;
 
 			intf = udev->actconfig->interface[i];
-			if (intf->dev.power.power_state == PM_SUSPEND_ON)
+			if (intf->dev.power.power_state.event == PM_EVENT_ON)
 				continue;
 			if (!intf->dev.driver) {
 				/* FIXME maybe force to alt 0 */
@@ -1732,11 +1732,11 @@
 
 			/* can we do better than just logging errors? */
 			status = driver->resume(intf);
-			if (intf->dev.power.power_state != PM_SUSPEND_ON
+			if (intf->dev.power.power_state.event != PM_EVENT_ON
 					|| status)
 				dev_dbg(&intf->dev,
 					"resume fail, state %d code %d\n",
-					intf->dev.power.power_state, status);
+					intf->dev.power.power_state.event, status);
 		}
 		status = 0;
 
@@ -1917,7 +1917,7 @@
 	unsigned		port1;
 	int			status;
 
-	if (intf->dev.power.power_state == PM_SUSPEND_ON)
+	if (intf->dev.power.power_state.event == PM_EVENT_ON)
 		return 0;
 
 	for (port1 = 1; port1 <= hdev->maxchild; port1++) {
--- clean/drivers/usb/core/usb.c	2005-03-19 00:31:51.000000000 +0100
+++ linux/drivers/usb/core/usb.c	2005-03-22 12:20:53.000000000 +0100
@@ -1367,7 +1367,7 @@
 	driver = to_usb_driver(dev->driver);
 
 	/* there's only one USB suspend state */
-	if (intf->dev.power.power_state)
+	if (intf->dev.power.power_state.event)
 		return 0;
 
 	if (driver->suspend)
--- clean/drivers/usb/host/ehci-dbg.c	2005-01-12 11:07:40.000000000 +0100
+++ linux/drivers/usb/host/ehci-dbg.c	2005-03-22 12:20:53.000000000 +0100
@@ -641,7 +641,7 @@
 
 	spin_lock_irqsave (&ehci->lock, flags);
 
-	if (bus->controller->power.power_state) {
+	if (bus->controller->power.power_state.event) {
 		size = scnprintf (next, size,
 			"bus %s, device %s (driver " DRIVER_VERSION ")\n"
 			"SUSPENDED (no register access)\n",
--- clean/drivers/usb/host/ohci-dbg.c	2005-03-19 00:31:53.000000000 +0100
+++ linux/drivers/usb/host/ohci-dbg.c	2005-03-22 12:20:53.000000000 +0100
@@ -625,7 +625,7 @@
 		hcd->self.controller->bus_id,
 		hcd_name);
 
-	if (bus->controller->power.power_state) {
+	if (bus->controller->power.power_state.event) {
 		size -= scnprintf (next, size,
 			"SUSPENDED (no register access)\n");
 		goto done;
--- clean/drivers/usb/host/sl811-hcd.c	2005-03-19 00:31:53.000000000 +0100
+++ linux/drivers/usb/host/sl811-hcd.c	2005-03-22 12:20:53.000000000 +0100
@@ -1781,9 +1781,9 @@
 	if (phase != SUSPEND_POWER_DOWN)
 		return retval;
 
-	if (state <= PM_SUSPEND_MEM)
+	if (state.event == PM_EVENT_FREEZE)
 		retval = sl811h_hub_suspend(hcd);
-	else
+	else if (state.event == PM_EVENT_SUSPEND)
 		port_power(sl811, 0);
 	if (retval == 0)
 		dev->power.power_state = state;
@@ -1802,14 +1802,14 @@
 	/* with no "check to see if VBUS is still powered" board hook,
 	 * let's assume it'd only be powered to enable remote wakeup.
 	 */
-	if (dev->power.power_state > PM_SUSPEND_MEM
+	if (dev->power.power_state.event == PM_EVENT_SUSPEND
 			|| !hcd->can_wakeup) {
 		sl811->port1 = 0;
 		port_power(sl811, 1);
 		return 0;
 	}
 
-	dev->power.power_state = PM_SUSPEND_ON;
+	dev->power.power_state = PMSG_ON;
 	return sl811h_hub_resume(hcd);
 }
 
--- clean/drivers/video/aty/atyfb_base.c	2005-03-19 00:31:59.000000000 +0100
+++ linux/drivers/video/aty/atyfb_base.c	2005-03-22 12:20:53.000000000 +0100
@@ -2070,12 +2070,12 @@
 	struct fb_info *info = pci_get_drvdata(pdev);
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 
-	if (pdev->dev.power.power_state == 0)
+	if (pdev->dev.power.power_state.event == PM_EVENT_ON)
 		return 0;
 
 	acquire_console_sem();
 
-	if (pdev->dev.power.power_state == 2)
+	if (pdev->dev.power.power_state.event == 2)
 		aty_power_mgmt(0, par);
 	par->asleep = 0;
 
--- clean/drivers/video/aty/radeon_pm.c	2005-03-19 00:31:59.000000000 +0100
+++ linux/drivers/video/aty/radeon_pm.c	2005-03-22 12:20:53.000000000 +0100
@@ -2519,33 +2519,26 @@
 }
 
 
-static/*extern*/ int susdisking = 0;
-
-int radeonfb_pci_suspend(struct pci_dev *pdev, u32 state)
+int radeonfb_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 {
         struct fb_info *info = pci_get_drvdata(pdev);
         struct radeonfb_info *rinfo = info->par;
 	u8 agp;
 	int i;
 
-	if (state == pdev->dev.power.power_state)
+	if (state.event == pdev->dev.power.power_state.event)
 		return 0;
 
 	printk(KERN_DEBUG "radeonfb (%s): suspending to state: %d...\n",
-	       pci_name(pdev), state);
+	       pci_name(pdev), state.event);
 
 	/* For suspend-to-disk, we cheat here. We don't suspend anything and
 	 * let fbcon continue drawing until we are all set. That shouldn't
 	 * really cause any problem at this point, provided that the wakeup
 	 * code knows that any state in memory may not match the HW
 	 */
-	if (state != PM_SUSPEND_MEM)
-		goto done;
-	if (susdisking) {
-		printk("radeonfb (%s): suspending to disk but state = %d\n",
-		       pci_name(pdev), state);
+	if (state.event == PM_EVENT_FREEZE)
 		goto done;
-	}
 
 	acquire_console_sem();
 
@@ -2637,7 +2630,7 @@
         struct radeonfb_info *rinfo = info->par;
 	int rc = 0;
 
-	if (pdev->dev.power.power_state == 0)
+	if (pdev->dev.power.power_state.event == PM_EVENT_ON)
 		return 0;
 
 	if (rinfo->no_schedule) {
@@ -2647,7 +2640,7 @@
 		acquire_console_sem();
 
 	printk(KERN_DEBUG "radeonfb (%s): resuming from state: %d...\n",
-	       pci_name(pdev), pdev->dev.power.power_state);
+	       pci_name(pdev), pdev->dev.power.power_state.event);
 
 
 	if (pci_enable_device(pdev)) {
@@ -2658,7 +2651,7 @@
 	}
 	pci_set_master(pdev);
 
-	if (pdev->dev.power.power_state == PM_SUSPEND_MEM) {
+	if (pdev->dev.power.power_state.event == PM_EVENT_SUSPEND) {
 		/* Wakeup chip. Check from config space if we were powered off
 		 * (todo: additionally, check CLK_PIN_CNTL too)
 		 */
--- clean/drivers/video/i810/i810_main.c	2005-03-19 00:32:00.000000000 +0100
+++ linux/drivers/video/i810/i810_main.c	2005-03-22 12:20:53.000000000 +0100
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
@@ -1524,7 +1524,7 @@
 		pci_disable_device(dev);
 	}
 	pci_save_state(dev);
-	pci_set_power_state(dev, state);
+	pci_set_power_state(dev, pci_choose_state(dev, state));
 
 	return 0;
 }
--- clean/include/linux/pm.h	2005-03-19 00:32:25.000000000 +0100
+++ linux/include/linux/pm.h	2005-03-22 12:25:54.000000000 +0100
@@ -185,7 +185,10 @@
 
 struct device;
 
-typedef u32 __bitwise pm_message_t;
+typedef struct pm_message {
+	int event;
+	int flags;
+} pm_message_t;
 
 /*
  * There are 4 important states driver can be in:
@@ -205,9 +208,15 @@
  * or something similar soon.
  */
 
-#define PMSG_FREEZE	((__force pm_message_t) 3)
-#define PMSG_SUSPEND	((__force pm_message_t) 3)
-#define PMSG_ON		((__force pm_message_t) 0)
+#define PM_EVENT_ON 0
+#define PM_EVENT_FREEZE 1
+#define PM_EVENT_SUSPEND 2
+
+#define PFL_RUNTIME 1
+
+#define PMSG_FREEZE	({struct pm_message m; m.event = PM_EVENT_FREEZE; m.flags = 0; m; })
+#define PMSG_SUSPEND	({struct pm_message m; m.event = PM_EVENT_SUSPEND; m.flags = 0; m; })
+#define PMSG_ON		({struct pm_message m; m.event = PM_EVENT_ON; m.flags = 0; m; })
 
 struct dev_pm_info {
 	pm_message_t		power_state;


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
