Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261679AbVEaKdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261679AbVEaKdz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 06:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbVEaKdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 06:33:55 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:54987 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S261679AbVEaKdS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 06:33:18 -0400
Date: Tue, 31 May 2005 12:25:56 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: [patch] switch pm_message_t to struct
Message-ID: <20050531102556.GA14411@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Turn pm_message_t into struct, so that it is typechecked properly (and
so that we can add flags field in future). This should not go in
before 2.6.12.

Note: this rejects against -mm tree. Some rejects are caused by
	state_store getting more arguments, and some by added hook
	in pci_choose_state. I still do not like that pci_choose_state
	hook, it really should return pci_power_t, not int.

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit a249072c4e0ef136c27c9e59d664e5be0d677ddc
tree 24a21ff5302734d40e08c400b14c0c1624cceded
parent f4bed68f59d9f32a4460288f40bb7f2af463babd
author <pavel@amd.(none)> Tue, 31 May 2005 11:57:50 +0200
committer <pavel@amd.(none)> Tue, 31 May 2005 11:57:50 +0200

 drivers/base/power/resume.c    |    8 ++++----
 drivers/base/power/runtime.c   |    8 ++++----
 drivers/base/power/suspend.c   |   12 ++++++------
 drivers/base/power/sysfs.c     |    8 ++++----
 drivers/ide/ide.c              |    4 ++--
 drivers/pci/pci.c              |   14 +++++++-------
 drivers/serial/pmac_zilog.c    |    2 +-
 drivers/usb/core/hub.c         |   18 +++++++++---------
 drivers/usb/core/usb.c         |    2 +-
 drivers/usb/host/ehci-dbg.c    |    2 +-
 drivers/usb/host/ohci-dbg.c    |    2 +-
 drivers/usb/host/sl811-hcd.c   |    6 +++---
 drivers/video/aty/atyfb_base.c |    4 ++--
 drivers/video/aty/radeon_pm.c  |   12 ++++++------
 drivers/video/i810/i810_main.c |    6 +++---
 include/linux/pm.h             |   14 ++++++++++----
 16 files changed, 64 insertions(+), 58 deletions(-)

Index: drivers/base/power/resume.c
===================================================================
--- cdda23a10f60ce0fce85bd8b8667e7c7cf022118/drivers/base/power/resume.c  (mode:100644)
+++ 24a21ff5302734d40e08c400b14c0c1624cceded/drivers/base/power/resume.c  (mode:100644)
@@ -23,11 +23,11 @@
 int resume_device(struct device * dev)
 {
 	if (dev->power.pm_parent
-			&& dev->power.pm_parent->power.power_state) {
+			&& dev->power.pm_parent->power.power_state.event) {
 		dev_err(dev, "PM: resume from %d, parent %s still %d\n",
-			dev->power.power_state,
+			dev->power.power_state.event,
 			dev->power.pm_parent->bus_id,
-			dev->power.pm_parent->power.power_state);
+			dev->power.pm_parent->power.power_state.event);
 	}
 	if (dev->bus && dev->bus->resume) {
 		dev_dbg(dev,"resuming\n");
@@ -50,7 +50,7 @@
 		list_add_tail(entry, &dpm_active);
 
 		up(&dpm_list_sem);
-		if (!dev->power.prev_state)
+		if (!dev->power.prev_state.event)
 			resume_device(dev);
 		down(&dpm_list_sem);
 		put_device(dev);
Index: drivers/base/power/runtime.c
===================================================================
--- cdda23a10f60ce0fce85bd8b8667e7c7cf022118/drivers/base/power/runtime.c  (mode:100644)
+++ 24a21ff5302734d40e08c400b14c0c1624cceded/drivers/base/power/runtime.c  (mode:100644)
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
Index: drivers/base/power/suspend.c
===================================================================
--- cdda23a10f60ce0fce85bd8b8667e7c7cf022118/drivers/base/power/suspend.c  (mode:100644)
+++ 24a21ff5302734d40e08c400b14c0c1624cceded/drivers/base/power/suspend.c  (mode:100644)
@@ -39,22 +39,22 @@
 {
 	int error = 0;
 
-	if (dev->power.power_state) {
+	if (dev->power.power_state.event) {
 		dev_dbg(dev, "PM: suspend %d-->%d\n",
-			dev->power.power_state, state);
+			dev->power.power_state.event, state.event);
 	}
 	if (dev->power.pm_parent
-			&& dev->power.pm_parent->power.power_state) {
+			&& dev->power.pm_parent->power.power_state.event) {
 		dev_err(dev,
 			"PM: suspend %d->%d, parent %s already %d\n",
-			dev->power.power_state, state,
+			dev->power.power_state.event, state.event,
 			dev->power.pm_parent->bus_id,
-			dev->power.pm_parent->power.power_state);
+			dev->power.pm_parent->power.power_state.event);
 	}
 
 	dev->power.prev_state = dev->power.power_state;
 
-	if (dev->bus && dev->bus->suspend && !dev->power.power_state) {
+	if (dev->bus && dev->bus->suspend && !dev->power.power_state.event) {
 		dev_dbg(dev, "suspending\n");
 		error = dev->bus->suspend(dev, state);
 	}
Index: drivers/base/power/sysfs.c
===================================================================
--- cdda23a10f60ce0fce85bd8b8667e7c7cf022118/drivers/base/power/sysfs.c  (mode:100644)
+++ 24a21ff5302734d40e08c400b14c0c1624cceded/drivers/base/power/sysfs.c  (mode:100644)
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
Index: drivers/ide/ide.c
===================================================================
--- cdda23a10f60ce0fce85bd8b8667e7c7cf022118/drivers/ide/ide.c  (mode:100644)
+++ 24a21ff5302734d40e08c400b14c0c1624cceded/drivers/ide/ide.c  (mode:100644)
@@ -1385,7 +1385,7 @@
 	rq.special = &args;
 	rq.pm = &rqpm;
 	rqpm.pm_step = ide_pm_state_start_suspend;
-	rqpm.pm_state = state;
+	rqpm.pm_state = state.event;
 
 	return ide_do_drive_cmd(drive, &rq, ide_wait);
 }
@@ -1404,7 +1404,7 @@
 	rq.special = &args;
 	rq.pm = &rqpm;
 	rqpm.pm_step = ide_pm_state_start_resume;
-	rqpm.pm_state = 0;
+	rqpm.pm_state = PM_EVENT_ON;
 
 	return ide_do_drive_cmd(drive, &rq, ide_head_wait);
 }
Index: drivers/pci/pci.c
===================================================================
--- cdda23a10f60ce0fce85bd8b8667e7c7cf022118/drivers/pci/pci.c  (mode:100644)
+++ 24a21ff5302734d40e08c400b14c0c1624cceded/drivers/pci/pci.c  (mode:100644)
@@ -316,14 +316,14 @@
 
 pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state)
 {
-	if (!pci_find_capability(dev, PCI_CAP_ID_PM))
+	switch (state.event) {
+	case PM_EVENT_ON:
 		return PCI_D0;
-
-	switch (state) {
-	case 0: return PCI_D0;
-	case 3: return PCI_D3hot;
-	default:
-		printk("They asked me for state %d\n", state);
+	case PM_EVENT_FREEZE:
+	case PM_EVENT_SUSPEND:
+		return PCI_D3hot;
+	default: 
+		printk("They asked me for state %d\n", state.event);
 		BUG();
 	}
 	return PCI_D0;
Index: drivers/serial/pmac_zilog.c
===================================================================
--- cdda23a10f60ce0fce85bd8b8667e7c7cf022118/drivers/serial/pmac_zilog.c  (mode:100644)
+++ 24a21ff5302734d40e08c400b14c0c1624cceded/drivers/serial/pmac_zilog.c  (mode:100644)
@@ -1601,7 +1601,7 @@
 		return 0;
 	}
 
-	if (pm_state == mdev->ofdev.dev.power.power_state || pm_state < 2)
+	if (pm_state.event == mdev->ofdev.dev.power.power_state.event)
 		return 0;
 
 	pmz_debug("suspend, switching to state %d\n", pm_state);
Index: drivers/usb/core/hub.c
===================================================================
--- cdda23a10f60ce0fce85bd8b8667e7c7cf022118/drivers/usb/core/hub.c  (mode:100644)
+++ 24a21ff5302734d40e08c400b14c0c1624cceded/drivers/usb/core/hub.c  (mode:100644)
@@ -1564,7 +1564,7 @@
 			struct usb_driver	*driver;
 
 			intf = udev->actconfig->interface[i];
-			if (state <= intf->dev.power.power_state)
+			if (state.event <= intf->dev.power.power_state.event)
 				continue;
 			if (!intf->dev.driver)
 				continue;
@@ -1572,11 +1572,11 @@
 
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
@@ -1589,7 +1589,7 @@
 			 * since we know every driver's probe/disconnect works
 			 * even for drivers that can't suspend.
 			 */
-			if (!driver->suspend || state > PM_SUSPEND_MEM) {
+			if (!driver->suspend || state.event > PM_EVENT_FREEZE) {
 #if 1
 				dev_warn(&intf->dev, "resume is unsafe!\n");
 #else
@@ -1610,7 +1610,7 @@
 	 * policies (when HNP doesn't apply) once we have mechanisms to
 	 * turn power back on!  (Likely not before 2.7...)
 	 */
-	if (state > PM_SUSPEND_MEM) {
+	if (state.event > PM_EVENT_FREEZE) {
 		dev_warn(&udev->dev, "no poweroff yet, suspending instead\n");
 	}
 
@@ -1727,7 +1727,7 @@
 			struct usb_driver	*driver;
 
 			intf = udev->actconfig->interface[i];
-			if (intf->dev.power.power_state == PMSG_SUSPEND)
+			if (intf->dev.power.power_state.event == PM_EVENT_ON)
 				continue;
 			if (!intf->dev.driver) {
 				/* FIXME maybe force to alt 0 */
@@ -1741,11 +1741,11 @@
 
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
 
@@ -1928,7 +1928,7 @@
 	unsigned		port1;
 	int			status;
 
-	if (intf->dev.power.power_state == PM_SUSPEND_ON)
+	if (intf->dev.power.power_state.event == PM_EVENT_ON)
 		return 0;
 
 	for (port1 = 1; port1 <= hdev->maxchild; port1++) {
Index: drivers/usb/core/usb.c
===================================================================
--- cdda23a10f60ce0fce85bd8b8667e7c7cf022118/drivers/usb/core/usb.c  (mode:100644)
+++ 24a21ff5302734d40e08c400b14c0c1624cceded/drivers/usb/core/usb.c  (mode:100644)
@@ -1389,7 +1389,7 @@
 	driver = to_usb_driver(dev->driver);
 
 	/* there's only one USB suspend state */
-	if (intf->dev.power.power_state)
+	if (intf->dev.power.power_state.event)
 		return 0;
 
 	if (driver->suspend)
Index: drivers/usb/host/ehci-dbg.c
===================================================================
--- cdda23a10f60ce0fce85bd8b8667e7c7cf022118/drivers/usb/host/ehci-dbg.c  (mode:100644)
+++ 24a21ff5302734d40e08c400b14c0c1624cceded/drivers/usb/host/ehci-dbg.c  (mode:100644)
@@ -641,7 +641,7 @@
 
 	spin_lock_irqsave (&ehci->lock, flags);
 
-	if (bus->controller->power.power_state) {
+	if (bus->controller->power.power_state.event) {
 		size = scnprintf (next, size,
 			"bus %s, device %s (driver " DRIVER_VERSION ")\n"
 			"SUSPENDED (no register access)\n",
Index: drivers/usb/host/ohci-dbg.c
===================================================================
--- cdda23a10f60ce0fce85bd8b8667e7c7cf022118/drivers/usb/host/ohci-dbg.c  (mode:100644)
+++ 24a21ff5302734d40e08c400b14c0c1624cceded/drivers/usb/host/ohci-dbg.c  (mode:100644)
@@ -631,7 +631,7 @@
 		hcd->product_desc,
 		hcd_name);
 
-	if (bus->controller->power.power_state) {
+	if (bus->controller->power.power_state.event) {
 		size -= scnprintf (next, size,
 			"SUSPENDED (no register access)\n");
 		goto done;
Index: drivers/usb/host/sl811-hcd.c
===================================================================
--- cdda23a10f60ce0fce85bd8b8667e7c7cf022118/drivers/usb/host/sl811-hcd.c  (mode:100644)
+++ 24a21ff5302734d40e08c400b14c0c1624cceded/drivers/usb/host/sl811-hcd.c  (mode:100644)
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
@@ -1802,7 +1802,7 @@
 	/* with no "check to see if VBUS is still powered" board hook,
 	 * let's assume it'd only be powered to enable remote wakeup.
 	 */
-	if (dev->power.power_state > PM_SUSPEND_MEM
+	if (dev->power.power_state.event == PM_EVENT_SUSPEND
 			|| !hcd->can_wakeup) {
 		sl811->port1 = 0;
 		port_power(sl811, 1);
Index: drivers/video/aty/atyfb_base.c
===================================================================
--- cdda23a10f60ce0fce85bd8b8667e7c7cf022118/drivers/video/aty/atyfb_base.c  (mode:100644)
+++ 24a21ff5302734d40e08c400b14c0c1624cceded/drivers/video/aty/atyfb_base.c  (mode:100644)
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
 
Index: drivers/video/aty/radeon_pm.c
===================================================================
--- cdda23a10f60ce0fce85bd8b8667e7c7cf022118/drivers/video/aty/radeon_pm.c  (mode:100644)
+++ 24a21ff5302734d40e08c400b14c0c1624cceded/drivers/video/aty/radeon_pm.c  (mode:100644)
@@ -2526,18 +2526,18 @@
         struct radeonfb_info *rinfo = info->par;
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
+	if (state.event == PM_EVENT_FREEZE)
 		goto done;
 
 	acquire_console_sem();
@@ -2616,7 +2616,7 @@
         struct radeonfb_info *rinfo = info->par;
 	int rc = 0;
 
-	if (pdev->dev.power.power_state == 0)
+	if (pdev->dev.power.power_state.event == PM_EVENT_ON)
 		return 0;
 
 	if (rinfo->no_schedule) {
@@ -2626,7 +2626,7 @@
 		acquire_console_sem();
 
 	printk(KERN_DEBUG "radeonfb (%s): resuming from state: %d...\n",
-	       pci_name(pdev), pdev->dev.power.power_state);
+	       pci_name(pdev), pdev->dev.power.power_state.event);
 
 
 	if (pci_enable_device(pdev)) {
@@ -2637,7 +2637,7 @@
 	}
 	pci_set_master(pdev);
 
-	if (pdev->dev.power.power_state == PM_SUSPEND_MEM) {
+	if (pdev->dev.power.power_state.event == PM_EVENT_SUSPEND) {
 		/* Wakeup chip. Check from config space if we were powered off
 		 * (todo: additionally, check CLK_PIN_CNTL too)
 		 */
Index: drivers/video/i810/i810_main.c
===================================================================
--- cdda23a10f60ce0fce85bd8b8667e7c7cf022118/drivers/video/i810/i810_main.c  (mode:100644)
+++ 24a21ff5302734d40e08c400b14c0c1624cceded/drivers/video/i810/i810_main.c  (mode:100644)
@@ -1506,12 +1506,12 @@
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
Index: include/linux/pm.h
===================================================================
--- cdda23a10f60ce0fce85bd8b8667e7c7cf022118/include/linux/pm.h  (mode:100644)
+++ 24a21ff5302734d40e08c400b14c0c1624cceded/include/linux/pm.h  (mode:100644)
@@ -185,7 +185,9 @@
 
 struct device;
 
-typedef u32 __bitwise pm_message_t;
+typedef struct pm_message {
+	int event;
+} pm_message_t;
 
 /*
  * There are 4 important states driver can be in:
@@ -205,9 +207,13 @@
  * or something similar soon.
  */
 
-#define PMSG_FREEZE	((__force pm_message_t) 3)
-#define PMSG_SUSPEND	((__force pm_message_t) 3)
-#define PMSG_ON		((__force pm_message_t) 0)
+#define PM_EVENT_ON 0
+#define PM_EVENT_FREEZE 1
+#define PM_EVENT_SUSPEND 2
+
+#define PMSG_FREEZE	({struct pm_message m; m.event = PM_EVENT_FREEZE; m; })
+#define PMSG_SUSPEND	({struct pm_message m; m.event = PM_EVENT_SUSPEND; m; })
+#define PMSG_ON		({struct pm_message m; m.event = PM_EVENT_ON; m; })
 
 struct dev_pm_info {
 	pm_message_t		power_state;
