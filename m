Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261579AbVCYKNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbVCYKNF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 05:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbVCYKNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 05:13:04 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51864 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261579AbVCYKMj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 05:12:39 -0500
Date: Fri, 25 Mar 2005 11:11:49 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Linux-pm mailing list <linux-pm@lists.osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Cc: Len Brown <len.brown@intel.com>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: pm_message_t becoming struct
Message-ID: <20050325101149.GA1301@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

pm_message_t is becoming typedefed into struct with single field,
"event" real soon now. If you do anything that wants to look inside
pm_message_t, please base it on this patch.

[Patrick and David would like to pass struct pm_message * instead of
pm_message_t, but that just does not fly. Original code passed u32
there (ouch), and it is not easy to replace u32 with struct pm_message
* and not breaking the whole tree. Plus you do not get enough
typechecking that way.]

Len, please do something with platform_pci_choose_state(). I guess
right way is to make it return pci_power_t and add

#define PCI_POWER_ERROR -1...

Patch is relative to 2.6.12-rc1-mm3, and works okay here.

								Pavel


--- clean-mm/drivers/base/power/resume.c	2005-03-25 09:56:42.000000000 +0100
+++ linux-mm/drivers/base/power/resume.c	2005-03-25 08:47:16.000000000 +0100
@@ -45,7 +45,7 @@
 		list_add_tail(entry, &dpm_active);
 
 		up(&dpm_list_sem);
-		if (!dev->power.prev_state)
+		if (!dev->power.prev_state.event)
 			resume_device(dev);
 		down(&dpm_list_sem);
 		put_device(dev);
--- clean-mm/drivers/base/power/runtime.c	2005-01-12 11:07:39.000000000 +0100
+++ linux-mm/drivers/base/power/runtime.c	2005-03-25 08:47:16.000000000 +0100
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
--- clean-mm/drivers/base/power/shutdown.c	2004-08-15 19:14:55.000000000 +0200
+++ linux-mm/drivers/base/power/shutdown.c	2005-03-25 08:47:16.000000000 +0100
@@ -29,7 +29,8 @@
 			dev->driver->shutdown(dev);
 		return 0;
 	}
-	return dpm_runtime_suspend(dev, dev->detach_state);
+	/* FIXME we now pass single state for "runtime PM", but that's ok, it never really worked anyway  */
+	return dpm_runtime_suspend(dev, PMSG_FREEZE);
 }
 
 
--- clean-mm/drivers/base/power/suspend.c	2005-03-25 09:56:42.000000000 +0100
+++ linux-mm/drivers/base/power/suspend.c	2005-03-25 08:47:47.000000000 +0100
@@ -43,7 +43,7 @@
 
 	down(&dev->sem);
 	dev->power.prev_state = dev->power.power_state;
-	if (dev->bus && dev->bus->suspend && !dev->power.power_state)
+	if (dev->bus && dev->bus->suspend && (!dev->power.power_state.event))
 		error = dev->bus->suspend(dev, state);
 	up(&dev->sem);
 	return error;
--- clean-mm/drivers/base/power/sysfs.c	2004-08-15 19:14:55.000000000 +0200
+++ linux-mm/drivers/base/power/sysfs.c	2005-03-25 08:47:16.000000000 +0100
@@ -26,19 +26,19 @@
 
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
 	if (*rest)
 		return -EINVAL;
-	if (state)
+	if (state.event)
 		error = dpm_runtime_suspend(dev, state);
 	else
 		dpm_runtime_resume(dev);
Only in linux-mm/drivers/char: consolemap_deftbl.c
--- clean-mm/drivers/ide/ide.c	2005-03-25 09:56:43.000000000 +0100
+++ linux-mm/drivers/ide/ide.c	2005-03-25 08:47:16.000000000 +0100
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
--- clean-mm/drivers/pci/pci.c	2005-03-25 09:56:43.000000000 +0100
+++ linux-mm/drivers/pci/pci.c	2005-03-25 08:49:24.000000000 +0100
@@ -376,14 +376,12 @@
 	if (!pci_find_capability(dev, PCI_CAP_ID_PM))
 		return PCI_D0;
 
-	if (platform_pci_choose_state) {
-		ret = platform_pci_choose_state(dev, state);
-		if (ret >= 0)
-			state = ret;
-	}
-	switch (state) {
-	case 0: return PCI_D0;
-	case 3: return PCI_D3hot;
+	switch (state.event) {
+	case PM_EVENT_ON:
+		return PCI_D0;
+	case PM_EVENT_FREEZE:
+	case PM_EVENT_SUSPEND:
+		return PCI_D3hot;
 	default:
 		printk("They asked me for state %d\n", state);
 		BUG();
--- clean-mm/drivers/usb/core/hub.c	2005-03-25 09:56:43.000000000 +0100
+++ linux-mm/drivers/usb/core/hub.c	2005-03-25 08:51:25.000000000 +0100
@@ -1568,7 +1568,7 @@
 			struct usb_driver	*driver;
 
 			intf = udev->actconfig->interface[i];
-			if (state <= intf->dev.power.power_state)
+			if (state.event <= intf->dev.power.power_state.event)
 				continue;
 			if (!intf->dev.driver)
 				continue;
@@ -1576,11 +1576,11 @@
 
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
@@ -1593,7 +1593,7 @@
 			 * since we know every driver's probe/disconnect works
 			 * even for drivers that can't suspend.
 			 */
-			if (!driver->suspend || state > PM_SUSPEND_MEM) {
+			if (!driver->suspend || state.event > PM_EVENT_FREEZE) {
 #if 1
 				dev_warn(&intf->dev, "resume is unsafe!\n");
 #else
@@ -1614,7 +1614,7 @@
 	 * policies (when HNP doesn't apply) once we have mechanisms to
 	 * turn power back on!  (Likely not before 2.7...)
 	 */
-	if (state > PM_SUSPEND_MEM) {
+	if (state.event > PM_EVENT_FREEZE) {
 		dev_warn(&udev->dev, "no poweroff yet, suspending instead\n");
 	}
 
@@ -1731,7 +1731,7 @@
 			struct usb_driver	*driver;
 
 			intf = udev->actconfig->interface[i];
-			if (intf->dev.power.power_state == PMSG_SUSPEND)
+			if (intf->dev.power.power_state.event == PM_EVENT_SUSPEND)
 				continue;
 			if (!intf->dev.driver) {
 				/* FIXME maybe force to alt 0 */
@@ -1745,11 +1745,11 @@
 
 			/* can we do better than just logging errors? */
 			status = driver->resume(intf);
-			if (intf->dev.power.power_state != PMSG_ON
+			if (intf->dev.power.power_state.event != PM_EVENT_ON
 					|| status)
 				dev_dbg(&intf->dev,
 					"resume fail, state %d code %d\n",
-					intf->dev.power.power_state, status);
+					intf->dev.power.power_state.event, status);
 		}
 		status = 0;
 
@@ -1932,7 +1932,7 @@
 	unsigned		port1;
 	int			status;
 
-	if (intf->dev.power.power_state == PM_SUSPEND_ON)
+	if (intf->dev.power.power_state.event == PM_EVENT_ON)
 		return 0;
 
 	for (port1 = 1; port1 <= hdev->maxchild; port1++) {
--- clean-mm/drivers/usb/core/usb.c	2005-03-25 09:56:43.000000000 +0100
+++ linux-mm/drivers/usb/core/usb.c	2005-03-25 08:47:16.000000000 +0100
@@ -1376,7 +1376,7 @@
 	driver = to_usb_driver(dev->driver);
 
 	/* there's only one USB suspend state */
-	if (intf->dev.power.power_state)
+	if (intf->dev.power.power_state.event)
 		return 0;
 
 	if (driver->suspend)
--- clean-mm/drivers/usb/host/ehci-dbg.c	2005-03-25 09:56:43.000000000 +0100
+++ linux-mm/drivers/usb/host/ehci-dbg.c	2005-03-25 08:47:16.000000000 +0100
@@ -641,7 +641,7 @@
 
 	spin_lock_irqsave (&ehci->lock, flags);
 
-	if (bus->controller->power.power_state) {
+	if (bus->controller->power.power_state.event) {
 		size = scnprintf (next, size,
 			"bus %s, device %s (driver " DRIVER_VERSION ")\n"
 			"SUSPENDED (no register access)\n",
--- clean-mm/drivers/usb/host/ohci-dbg.c	2005-03-25 09:56:43.000000000 +0100
+++ linux-mm/drivers/usb/host/ohci-dbg.c	2005-03-25 08:47:16.000000000 +0100
@@ -625,7 +625,7 @@
 		hcd->self.controller->bus_id,
 		hcd_name);
 
-	if (bus->controller->power.power_state) {
+	if (bus->controller->power.power_state.event) {
 		size -= scnprintf (next, size,
 			"SUSPENDED (no register access)\n");
 		goto done;
--- clean-mm/drivers/usb/host/sl811-hcd.c	2005-03-25 09:56:43.000000000 +0100
+++ linux-mm/drivers/usb/host/sl811-hcd.c	2005-03-25 08:47:16.000000000 +0100
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
 
--- clean-mm/drivers/video/aty/atyfb_base.c	2005-03-25 09:56:43.000000000 +0100
+++ linux-mm/drivers/video/aty/atyfb_base.c	2005-03-25 08:47:16.000000000 +0100
@@ -2071,12 +2071,12 @@
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
 
--- clean-mm/drivers/video/aty/radeon_pm.c	2005-03-25 09:56:43.000000000 +0100
+++ linux-mm/drivers/video/aty/radeon_pm.c	2005-03-25 09:39:47.000000000 +0100
@@ -2520,8 +2520,6 @@
 }
 
 
-static/*extern*/ int susdisking = 0;
-
 int radeonfb_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 {
         struct fb_info *info = pci_get_drvdata(pdev);
@@ -2529,24 +2527,19 @@
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
 
@@ -2638,7 +2631,7 @@
         struct radeonfb_info *rinfo = info->par;
 	int rc = 0;
 
-	if (pdev->dev.power.power_state == 0)
+	if (pdev->dev.power.power_state.event == PM_EVENT_ON)
 		return 0;
 
 	if (rinfo->no_schedule) {
@@ -2648,7 +2641,7 @@
 		acquire_console_sem();
 
 	printk(KERN_DEBUG "radeonfb (%s): resuming from state: %d...\n",
-	       pci_name(pdev), pdev->dev.power.power_state);
+	       pci_name(pdev), pdev->dev.power.power_state.event);
 
 
 	if (pci_enable_device(pdev)) {
@@ -2659,7 +2652,7 @@
 	}
 	pci_set_master(pdev);
 
-	if (pdev->dev.power.power_state == PM_SUSPEND_MEM) {
+	if (pdev->dev.power.power_state.event == PM_EVENT_SUSPEND) {
 		/* Wakeup chip. Check from config space if we were powered off
 		 * (todo: additionally, check CLK_PIN_CNTL too)
 		 */
--- clean-mm/drivers/video/i810/i810_main.c	2005-03-25 09:56:43.000000000 +0100
+++ linux-mm/drivers/video/i810/i810_main.c	2005-03-25 08:54:42.000000000 +0100
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
@@ -1538,7 +1538,7 @@
 		return 0;
 
 	pci_restore_state(dev);
-	pci_set_power_state(dev, 0);
+	pci_set_power_state(dev, PCI_D0);
 	pci_enable_device(dev);
 	agp_bind_memory(par->i810_gtt.i810_fb_memory,
 			par->fb.offset);
--- clean-mm/include/linux/pm.h	2005-03-25 09:56:45.000000000 +0100
+++ linux-mm/include/linux/pm.h	2005-03-25 08:47:16.000000000 +0100
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
