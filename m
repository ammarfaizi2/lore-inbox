Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262784AbVDHMGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262784AbVDHMGR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 08:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262783AbVDHMGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 08:06:17 -0400
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:11493 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262789AbVDHMDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 08:03:22 -0400
Subject: [PATCH] pm_message_t corrections still missing from 2.6.12-rc2
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       FrameBuffer Devel <linux-fbdev-devel@lists.sourceforge.net>
Content-Type: text/plain
Message-Id: <1112961860.3757.755.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 08 Apr 2005 22:04:20 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Here, for your consideration, are fixups I still have in my tree after
updating to rc2.

(USB & Framebuffer lists copied because a reasonable number apply
there).

Regards,

Nigel

diff -ruNp 840-combined-pm_message_t-patch.patch-old/drivers/base/power/resume.c 840-combined-pm_message_t-patch.patch-new/drivers/base/power/resume.c
--- 840-combined-pm_message_t-patch.patch-old/drivers/base/power/resume.c	2004-12-10 14:26:51.000000000 +1100
+++ 840-combined-pm_message_t-patch.patch-new/drivers/base/power/resume.c	2005-04-08 13:41:41.000000000 +1000
@@ -41,7 +41,7 @@ void dpm_resume(void)
 		list_add_tail(entry, &dpm_active);
 
 		up(&dpm_list_sem);
-		if (!dev->power.prev_state)
+		if (!dev->power.prev_state.event)
 			resume_device(dev);
 		down(&dpm_list_sem);
 		put_device(dev);
diff -ruNp 840-combined-pm_message_t-patch.patch-old/drivers/base/power/runtime.c 840-combined-pm_message_t-patch.patch-new/drivers/base/power/runtime.c
--- 840-combined-pm_message_t-patch.patch-old/drivers/base/power/runtime.c	2005-02-03 22:33:23.000000000 +1100
+++ 840-combined-pm_message_t-patch.patch-new/drivers/base/power/runtime.c	2005-04-08 13:41:41.000000000 +1000
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
 
 
@@ -49,10 +49,10 @@ int dpm_runtime_suspend(struct device * 
 	int error = 0;
 
 	down(&dpm_sem);
-	if (dev->power.power_state == state)
+	if (dev->power.power_state.event == state.event)
 		goto Done;
 
-	if (dev->power.power_state)
+	if (dev->power.power_state.event)
 		runtime_resume(dev);
 
 	if (!(error = suspend_device(dev, state)))
diff -ruNp 840-combined-pm_message_t-patch.patch-old/drivers/base/power/shutdown.c 840-combined-pm_message_t-patch.patch-new/drivers/base/power/shutdown.c
--- 840-combined-pm_message_t-patch.patch-old/drivers/base/power/shutdown.c	2004-11-03 21:54:14.000000000 +1100
+++ 840-combined-pm_message_t-patch.patch-new/drivers/base/power/shutdown.c	2005-04-08 13:41:41.000000000 +1000
@@ -29,7 +29,8 @@ int device_detach_shutdown(struct device
 			dev->driver->shutdown(dev);
 		return 0;
 	}
-	return dpm_runtime_suspend(dev, dev->detach_state);
+	/* FIXME */
+	return dpm_runtime_suspend(dev, PMSG_FREEZE);
 }
 
 
diff -ruNp 840-combined-pm_message_t-patch.patch-old/drivers/base/power/suspend.c 840-combined-pm_message_t-patch.patch-new/drivers/base/power/suspend.c
--- 840-combined-pm_message_t-patch.patch-old/drivers/base/power/suspend.c	2005-04-08 12:35:14.000000000 +1000
+++ 840-combined-pm_message_t-patch.patch-new/drivers/base/power/suspend.c	2005-04-08 13:41:41.000000000 +1000
@@ -43,7 +43,7 @@ int suspend_device(struct device * dev, 
 
 	dev->power.prev_state = dev->power.power_state;
 
-	if (dev->bus && dev->bus->suspend && !dev->power.power_state)
+	if (dev->bus && dev->bus->suspend && (!dev->power.power_state.event))
 		error = dev->bus->suspend(dev, state);
 
 	return error;
diff -ruNp 840-combined-pm_message_t-patch.patch-old/drivers/base/power/sysfs.c 840-combined-pm_message_t-patch.patch-new/drivers/base/power/sysfs.c
--- 840-combined-pm_message_t-patch.patch-old/drivers/base/power/sysfs.c	2004-11-03 21:55:04.000000000 +1100
+++ 840-combined-pm_message_t-patch.patch-new/drivers/base/power/sysfs.c	2005-04-08 13:41:41.000000000 +1000
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
+	state.flags = PFL_RUNTIME;
 	if (*rest)
 		return -EINVAL;
-	if (state)
+	if (state.event)
 		error = dpm_runtime_suspend(dev, state);
 	else
 		dpm_runtime_resume(dev);
diff -ruNp 840-combined-pm_message_t-patch.patch-old/drivers/ide/ide.c 840-combined-pm_message_t-patch.patch-new/drivers/ide/ide.c
--- 840-combined-pm_message_t-patch.patch-old/drivers/ide/ide.c	2005-04-08 16:46:36.000000000 +1000
+++ 840-combined-pm_message_t-patch.patch-new/drivers/ide/ide.c	2005-04-08 13:41:41.000000000 +1000
@@ -1385,7 +1385,7 @@ static int generic_ide_suspend(struct de
 	rq.special = &args;
 	rq.pm = &rqpm;
 	rqpm.pm_step = ide_pm_state_start_suspend;
-	rqpm.pm_state = state;
+	rqpm.pm_state = state.event;
 
 	return ide_do_drive_cmd(drive, &rq, ide_wait);
 }
diff -ruNp 840-combined-pm_message_t-patch.patch-old/drivers/media/video/msp3400.c 840-combined-pm_message_t-patch.patch-new/drivers/media/video/msp3400.c
--- 840-combined-pm_message_t-patch.patch-old/drivers/media/video/msp3400.c	2005-04-08 16:46:35.000000000 +1000
+++ 840-combined-pm_message_t-patch.patch-new/drivers/media/video/msp3400.c	2005-04-08 13:41:41.000000000 +1000
@@ -1426,7 +1426,7 @@ static int msp_detach(struct i2c_client 
 static int msp_probe(struct i2c_adapter *adap);
 static int msp_command(struct i2c_client *client, unsigned int cmd, void *arg);
 
-static int msp_suspend(struct device * dev, u32 state, u32 level);
+static int msp_suspend(struct device * dev, pm_message_t state, u32 level);
 static int msp_resume(struct device * dev, u32 level);
 
 static void msp_wake_thread(struct i2c_client *client);
@@ -1834,7 +1834,7 @@ static int msp_command(struct i2c_client
 	return 0;
 }
 
-static int msp_suspend(struct device * dev, u32 state, u32 level)
+static int msp_suspend(struct device * dev, pm_message_t state, u32 level)
 {
 	struct i2c_client *c = container_of(dev, struct i2c_client, dev);
 
diff -ruNp 840-combined-pm_message_t-patch.patch-old/drivers/net/typhoon.c 840-combined-pm_message_t-patch.patch-new/drivers/net/typhoon.c
--- 840-combined-pm_message_t-patch.patch-old/drivers/net/typhoon.c	2005-03-18 19:33:12.000000000 +1100
+++ 840-combined-pm_message_t-patch.patch-new/drivers/net/typhoon.c	2005-04-08 13:41:41.000000000 +1000
@@ -1908,7 +1908,7 @@ typhoon_sleep(struct typhoon *tp, pci_po
 
 	pci_enable_wake(tp->pdev, state, 1);
 	pci_disable_device(pdev);
-	return pci_set_power_state(pdev, pci_choose_state(pdev, state));
+	return pci_set_power_state(pdev, state);
 }
 
 static int
@@ -2274,7 +2274,7 @@ typhoon_suspend(struct pci_dev *pdev, pm
 		goto need_resume;
 	}
 
-	if(typhoon_sleep(tp, state, tp->wol_events) < 0) {
+	if(typhoon_sleep(tp, pci_choose_state(pdev, state), tp->wol_events) < 0) {
 		printk(KERN_ERR "%s: unable to put card to sleep\n", dev->name);
 		goto need_resume;
 	}
diff -ruNp 840-combined-pm_message_t-patch.patch-old/drivers/pci/pci.c 840-combined-pm_message_t-patch.patch-new/drivers/pci/pci.c
--- 840-combined-pm_message_t-patch.patch-old/drivers/pci/pci.c	2005-04-08 12:35:18.000000000 +1000
+++ 840-combined-pm_message_t-patch.patch-new/drivers/pci/pci.c	2005-04-08 14:10:38.000000000 +1000
@@ -318,11 +318,11 @@ pci_power_t pci_choose_state(struct pci_
 	if (!pci_find_capability(dev, PCI_CAP_ID_PM))
 		return PCI_D0;
 
-	switch (state) {
+	switch (state.event) {
 	case 0: return PCI_D0;
 	case 3: return PCI_D3hot;
 	default:
-		printk("They asked me for state %d\n", state);
+		printk("They asked me for state %d\n", state.event);
 		BUG();
 	}
 	return PCI_D0;
diff -ruNp 840-combined-pm_message_t-patch.patch-old/drivers/usb/core/hcd.h 840-combined-pm_message_t-patch.patch-new/drivers/usb/core/hcd.h
--- 840-combined-pm_message_t-patch.patch-old/drivers/usb/core/hcd.h	2005-04-08 12:35:19.000000000 +1000
+++ 840-combined-pm_message_t-patch.patch-new/drivers/usb/core/hcd.h	2005-04-08 13:41:41.000000000 +1000
@@ -177,7 +177,7 @@ struct hc_driver {
 	 * a whole, not just the root hub; they're for bus glue.
 	 */
 	/* called after all devices were suspended */
-	int	(*suspend) (struct usb_hcd *hcd, u32 state);
+	int	(*suspend) (struct usb_hcd *hcd, pm_message_t state);
 
 	/* called before any devices get resumed */
 	int	(*resume) (struct usb_hcd *hcd);
@@ -226,7 +226,7 @@ extern int usb_hcd_pci_probe (struct pci
 extern void usb_hcd_pci_remove (struct pci_dev *dev);
 
 #ifdef CONFIG_PM
-extern int usb_hcd_pci_suspend (struct pci_dev *dev, u32 state);
+extern int usb_hcd_pci_suspend (struct pci_dev *dev, pm_message_t state);
 extern int usb_hcd_pci_resume (struct pci_dev *dev);
 #endif /* CONFIG_PM */
 
diff -ruNp 840-combined-pm_message_t-patch.patch-old/drivers/usb/core/hcd-pci.c 840-combined-pm_message_t-patch.patch-new/drivers/usb/core/hcd-pci.c
--- 840-combined-pm_message_t-patch.patch-old/drivers/usb/core/hcd-pci.c	2005-04-08 12:35:19.000000000 +1000
+++ 840-combined-pm_message_t-patch.patch-new/drivers/usb/core/hcd-pci.c	2005-04-08 13:41:41.000000000 +1000
@@ -68,7 +68,7 @@ int usb_hcd_pci_probe (struct pci_dev *d
 	if (pci_enable_device (dev) < 0)
 		return -ENODEV;
 	dev->current_state = 0;
-	dev->dev.power.power_state = 0;
+	dev->dev.power.power_state = PMSG_ON;
 	
         if (!dev->irq) {
         	dev_err (&dev->dev,
@@ -205,11 +205,12 @@ static char __attribute_used__ *pci_stat
  *
  * Store this function in the HCD's struct pci_driver as suspend().
  */
-int usb_hcd_pci_suspend (struct pci_dev *dev, u32 state)
+int usb_hcd_pci_suspend (struct pci_dev *dev, pm_message_t pmsg)
 {
 	struct usb_hcd		*hcd;
 	int			retval = 0;
 	int			has_pci_pm;
+	pci_power_t		state;
 
 	hcd = pci_get_drvdata(dev);
 
@@ -218,8 +219,16 @@ int usb_hcd_pci_suspend (struct pci_dev 
 	 * PM-sensitive HCDs may already have done this.
 	 */
 	has_pci_pm = pci_find_capability(dev, PCI_CAP_ID_PM);
-	if (state > 4)
-		state = 4;
+
+	/* Hack alert. Currently USB (notably uhci-hcd) only
+	 * understands D3hot or not suspending at all. Revert to
+	 * the pre-driver-model behaviour for now until a better
+	 * fix appears.
+	 */
+	if (pmsg.event == EVENT_ON)
+		state = PCI_D0;
+	else
+		state = PCI_D3hot;
 
 	switch (hcd->state) {
 
@@ -228,7 +237,7 @@ int usb_hcd_pci_suspend (struct pci_dev 
 	 */
 	case HC_STATE_RUNNING:
 		hcd->state = HC_STATE_QUIESCING;
-		retval = hcd->driver->suspend (hcd, state);
+		retval = hcd->driver->suspend (hcd, pmsg);
 		if (retval) {
 			dev_dbg (hcd->self.controller, 
 					"suspend fail, retval %d\n",
@@ -291,9 +300,6 @@ int usb_hcd_pci_suspend (struct pci_dev 
 		break;
 	}
 
-	/* update power_state **ONLY** to make sysfs happier */
-	if (retval == 0)
-		dev->dev.power.power_state = state;
 	return retval;
 }
 EXPORT_SYMBOL (usb_hcd_pci_suspend);
@@ -327,7 +333,7 @@ int usb_hcd_pci_resume (struct pci_dev *
 
 	if (has_pci_pm)
 		pci_set_power_state (dev, 0);
-	dev->dev.power.power_state = 0;
+	dev->dev.power.power_state = PMSG_ON;
 	retval = request_irq (dev->irq, usb_hcd_irq, SA_SHIRQ,
 				hcd->driver->description, hcd);
 	if (retval < 0) {
diff -ruNp 840-combined-pm_message_t-patch.patch-old/drivers/usb/core/hub.c 840-combined-pm_message_t-patch.patch-new/drivers/usb/core/hub.c
--- 840-combined-pm_message_t-patch.patch-old/drivers/usb/core/hub.c	2005-04-08 12:35:19.000000000 +1000
+++ 840-combined-pm_message_t-patch.patch-new/drivers/usb/core/hub.c	2005-04-08 13:41:41.000000000 +1000
@@ -1568,7 +1568,7 @@ static int __usb_suspend_device (struct 
 			struct usb_driver	*driver;
 
 			intf = udev->actconfig->interface[i];
-			if (state <= intf->dev.power.power_state)
+			if (state.event <= intf->dev.power.power_state.event)
 				continue;
 			if (!intf->dev.driver)
 				continue;
@@ -1576,11 +1576,11 @@ static int __usb_suspend_device (struct 
 
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
@@ -1593,7 +1593,7 @@ static int __usb_suspend_device (struct 
 			 * since we know every driver's probe/disconnect works
 			 * even for drivers that can't suspend.
 			 */
-			if (!driver->suspend || state > PM_SUSPEND_MEM) {
+			if (!driver->suspend || state.event > EVENT_SUSPEND) {
 #if 1
 				dev_warn(&intf->dev, "resume is unsafe!\n");
 #else
@@ -1614,7 +1614,7 @@ static int __usb_suspend_device (struct 
 	 * policies (when HNP doesn't apply) once we have mechanisms to
 	 * turn power back on!  (Likely not before 2.7...)
 	 */
-	if (state > PM_SUSPEND_MEM) {
+	if (state.event > EVENT_SUSPEND) {
 		dev_warn(&udev->dev, "no poweroff yet, suspending instead\n");
 	}
 
@@ -1731,7 +1731,7 @@ static int finish_port_resume(struct usb
 			struct usb_driver	*driver;
 
 			intf = udev->actconfig->interface[i];
-			if (intf->dev.power.power_state == PM_SUSPEND_ON)
+			if (intf->dev.power.power_state.event == EVENT_ON)
 				continue;
 			if (!intf->dev.driver) {
 				/* FIXME maybe force to alt 0 */
@@ -1745,11 +1745,11 @@ static int finish_port_resume(struct usb
 
 			/* can we do better than just logging errors? */
 			status = driver->resume(intf);
-			if (intf->dev.power.power_state != PM_SUSPEND_ON
+			if (intf->dev.power.power_state.event != EVENT_ON
 					|| status)
 				dev_dbg(&intf->dev,
 					"resume fail, state %d code %d\n",
-					intf->dev.power.power_state, status);
+					intf->dev.power.power_state.event, status);
 		}
 		status = 0;
 
@@ -1932,7 +1932,7 @@ static int hub_resume(struct usb_interfa
 	unsigned		port1;
 	int			status;
 
-	if (intf->dev.power.power_state == PM_SUSPEND_ON)
+	if (intf->dev.power.power_state.event == EVENT_ON)
 		return 0;
 
 	for (port1 = 1; port1 <= hdev->maxchild; port1++) {
diff -ruNp 840-combined-pm_message_t-patch.patch-old/drivers/usb/core/usb.c 840-combined-pm_message_t-patch.patch-new/drivers/usb/core/usb.c
--- 840-combined-pm_message_t-patch.patch-old/drivers/usb/core/usb.c	2005-04-08 12:35:19.000000000 +1000
+++ 840-combined-pm_message_t-patch.patch-new/drivers/usb/core/usb.c	2005-04-08 13:41:41.000000000 +1000
@@ -1382,7 +1382,7 @@ void usb_buffer_unmap_sg (struct usb_dev
 			usb_pipein (pipe) ? DMA_FROM_DEVICE : DMA_TO_DEVICE);
 }
 
-static int usb_generic_suspend(struct device *dev, u32 state)
+static int usb_generic_suspend(struct device *dev, pm_message_t state)
 {
 	struct usb_interface *intf;
 	struct usb_driver *driver;
@@ -1398,7 +1398,7 @@ static int usb_generic_suspend(struct de
 	driver = to_usb_driver(dev->driver);
 
 	/* there's only one USB suspend state */
-	if (intf->dev.power.power_state)
+	if (intf->dev.power.power_state.event)
 		return 0;
 
 	if (driver->suspend)
diff -ruNp 840-combined-pm_message_t-patch.patch-old/drivers/usb/host/ehci-dbg.c 840-combined-pm_message_t-patch.patch-new/drivers/usb/host/ehci-dbg.c
--- 840-combined-pm_message_t-patch.patch-old/drivers/usb/host/ehci-dbg.c	2005-02-03 22:33:38.000000000 +1100
+++ 840-combined-pm_message_t-patch.patch-new/drivers/usb/host/ehci-dbg.c	2005-04-08 13:41:41.000000000 +1000
@@ -641,7 +641,7 @@ show_registers (struct class_device *cla
 
 	spin_lock_irqsave (&ehci->lock, flags);
 
-	if (bus->controller->power.power_state) {
+	if (bus->controller->power.power_state.event) {
 		size = scnprintf (next, size,
 			"bus %s, device %s (driver " DRIVER_VERSION ")\n"
 			"SUSPENDED (no register access)\n",
diff -ruNp 840-combined-pm_message_t-patch.patch-old/drivers/usb/host/ehci-hcd.c 840-combined-pm_message_t-patch.patch-new/drivers/usb/host/ehci-hcd.c
--- 840-combined-pm_message_t-patch.patch-old/drivers/usb/host/ehci-hcd.c	2005-04-08 12:35:20.000000000 +1000
+++ 840-combined-pm_message_t-patch.patch-new/drivers/usb/host/ehci-hcd.c	2005-04-08 13:41:41.000000000 +1000
@@ -721,7 +721,7 @@ static int ehci_get_frame (struct usb_hc
  * the right sort of wakeup.  
  */
 
-static int ehci_suspend (struct usb_hcd *hcd, u32 state)
+static int ehci_suspend (struct usb_hcd *hcd, pm_message_t state)
 {
 	struct ehci_hcd		*ehci = hcd_to_ehci (hcd);
 
diff -ruNp 840-combined-pm_message_t-patch.patch-old/drivers/usb/host/ohci-dbg.c 840-combined-pm_message_t-patch.patch-new/drivers/usb/host/ohci-dbg.c
--- 840-combined-pm_message_t-patch.patch-old/drivers/usb/host/ohci-dbg.c	2005-04-08 12:35:20.000000000 +1000
+++ 840-combined-pm_message_t-patch.patch-new/drivers/usb/host/ohci-dbg.c	2005-04-08 13:41:41.000000000 +1000
@@ -631,7 +631,7 @@ show_registers (struct class_device *cla
 		hcd->product_desc,
 		hcd_name);
 
-	if (bus->controller->power.power_state) {
+	if (bus->controller->power.power_state.event) {
 		size -= scnprintf (next, size,
 			"SUSPENDED (no register access)\n");
 		goto done;
diff -ruNp 840-combined-pm_message_t-patch.patch-old/drivers/usb/host/ohci-pci.c 840-combined-pm_message_t-patch.patch-new/drivers/usb/host/ohci-pci.c
--- 840-combined-pm_message_t-patch.patch-old/drivers/usb/host/ohci-pci.c	2005-02-03 22:33:38.000000000 +1100
+++ 840-combined-pm_message_t-patch.patch-new/drivers/usb/host/ohci-pci.c	2005-04-08 13:41:41.000000000 +1000
@@ -102,7 +102,7 @@ ohci_pci_start (struct usb_hcd *hcd)
 
 #ifdef	CONFIG_PM
 
-static int ohci_pci_suspend (struct usb_hcd *hcd, u32 state)
+static int ohci_pci_suspend (struct usb_hcd *hcd, pm_message_t state)
 {
 	struct ohci_hcd		*ohci = hcd_to_ohci (hcd);
 
diff -ruNp 840-combined-pm_message_t-patch.patch-old/drivers/usb/host/sl811-hcd.c 840-combined-pm_message_t-patch.patch-new/drivers/usb/host/sl811-hcd.c
--- 840-combined-pm_message_t-patch.patch-old/drivers/usb/host/sl811-hcd.c	2005-04-08 12:35:20.000000000 +1000
+++ 840-combined-pm_message_t-patch.patch-new/drivers/usb/host/sl811-hcd.c	2005-04-08 13:41:41.000000000 +1000
@@ -1781,9 +1781,9 @@ sl811h_suspend(struct device *dev, pm_me
 	if (phase != SUSPEND_POWER_DOWN)
 		return retval;
 
-	if (state <= PM_SUSPEND_MEM)
+	if (state.event == EVENT_FREEZE)
 		retval = sl811h_hub_suspend(hcd);
-	else
+	else if (state.event == EVENT_SUSPEND)
 		port_power(sl811, 0);
 	if (retval == 0)
 		dev->power.power_state = state;
diff -ruNp 840-combined-pm_message_t-patch.patch-old/drivers/usb/host/uhci-hcd.c 840-combined-pm_message_t-patch.patch-new/drivers/usb/host/uhci-hcd.c
--- 840-combined-pm_message_t-patch.patch-old/drivers/usb/host/uhci-hcd.c	2005-04-08 12:35:20.000000000 +1000
+++ 840-combined-pm_message_t-patch.patch-new/drivers/usb/host/uhci-hcd.c	2005-04-08 13:41:41.000000000 +1000
@@ -716,7 +716,7 @@ static void uhci_stop(struct usb_hcd *hc
 }
 
 #ifdef CONFIG_PM
-static int uhci_suspend(struct usb_hcd *hcd, u32 state)
+static int uhci_suspend(struct usb_hcd *hcd, pm_message_t state)
 {
 	struct uhci_hcd *uhci = hcd_to_uhci(hcd);
 
diff -ruNp 840-combined-pm_message_t-patch.patch-old/drivers/usb/input/hid-core.c 840-combined-pm_message_t-patch.patch-new/drivers/usb/input/hid-core.c
--- 840-combined-pm_message_t-patch.patch-old/drivers/usb/input/hid-core.c	2005-03-18 19:33:14.000000000 +1100
+++ 840-combined-pm_message_t-patch.patch-new/drivers/usb/input/hid-core.c	2005-04-08 13:41:41.000000000 +1000
@@ -1790,7 +1790,7 @@ static int hid_probe(struct usb_interfac
 	return 0;
 }
 
-static int hid_suspend(struct usb_interface *intf, u32 state)
+static int hid_suspend(struct usb_interface *intf, pm_message_t state)
 {
 	struct hid_device *hid = usb_get_intfdata (intf);
 
@@ -1805,7 +1805,7 @@ static int hid_resume(struct usb_interfa
 	struct hid_device *hid = usb_get_intfdata (intf);
 	int status;
 
-	intf->dev.power.power_state = PM_SUSPEND_ON;
+	intf->dev.power.power_state = PMSG_ON;
 	if (hid->open)
 		status = usb_submit_urb(hid->urbin, GFP_NOIO);
 	else
diff -ruNp 840-combined-pm_message_t-patch.patch-old/drivers/video/aty/aty128fb.c 840-combined-pm_message_t-patch.patch-new/drivers/video/aty/aty128fb.c
--- 840-combined-pm_message_t-patch.patch-old/drivers/video/aty/aty128fb.c	2005-04-08 12:35:21.000000000 +1000
+++ 840-combined-pm_message_t-patch.patch-new/drivers/video/aty/aty128fb.c	2005-04-08 13:41:41.000000000 +1000
@@ -2344,11 +2344,11 @@ static int aty128_pci_suspend(struct pci
 	 * that. On laptops, the AGP slot is just unclocked, so D2 is
 	 * expected, while on desktops, the card is powered off
 	 */
-	if (state >= 3)
-		state = 2;
+	if (state.event >= 3)
+		state.event = 2;
 #endif /* CONFIG_PPC_PMAC */
 	 
-	if (state != 2 || state == pdev->dev.power.power_state)
+	if (state.event != 2 || state.event == pdev->dev.power.power_state.event)
 		return 0;
 
 	printk(KERN_DEBUG "aty128fb: suspending...\n");
@@ -2395,7 +2395,7 @@ static int aty128_pci_suspend(struct pci
 	 * used dummy fb ops, 2.5 need proper support for this at the
 	 * fbdev level
 	 */
-	if (state == 2)
+	if (state.event == 2)
 		aty128_set_suspend(par, 1);
 
 	release_console_sem();
@@ -2410,11 +2410,11 @@ static int aty128_do_resume(struct pci_d
 	struct fb_info *info = pci_get_drvdata(pdev);
 	struct aty128fb_par *par = info->par;
 
-	if (pdev->dev.power.power_state == 0)
+	if (!pdev->dev.power.power_state.event)
 		return 0;
 
 	/* Wakeup chip */
-	if (pdev->dev.power.power_state == 2)
+	if (pdev->dev.power.power_state.event == 2)
 		aty128_set_suspend(par, 0);
 	par->asleep = 0;
 
diff -ruNp 840-combined-pm_message_t-patch.patch-old/drivers/video/aty/atyfb_base.c 840-combined-pm_message_t-patch.patch-new/drivers/video/aty/atyfb_base.c
--- 840-combined-pm_message_t-patch.patch-old/drivers/video/aty/atyfb_base.c	2005-04-08 12:35:21.000000000 +1000
+++ 840-combined-pm_message_t-patch.patch-new/drivers/video/aty/atyfb_base.c	2005-04-08 13:41:41.000000000 +1000
@@ -2028,11 +2028,11 @@ static int atyfb_pci_suspend(struct pci_
 	 * that. On laptops, the AGP slot is just unclocked, so D2 is
 	 * expected, while on desktops, the card is powered off
 	 */
-	if (state >= 3)
-		state = 2;
+	if (state.event >= 3)
+		state.event = 2;
 #endif /* CONFIG_PPC_PMAC */
 
-	if (state != 2 || state == pdev->dev.power.power_state)
+	if (state.event != 2 || state.event == pdev->dev.power.power_state.event)
 		return 0;
 
 	acquire_console_sem();
@@ -2071,12 +2071,12 @@ static int atyfb_pci_resume(struct pci_d
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
 
diff -ruNp 840-combined-pm_message_t-patch.patch-old/drivers/video/aty/radeon_pm.c 840-combined-pm_message_t-patch.patch-new/drivers/video/aty/radeon_pm.c
--- 840-combined-pm_message_t-patch.patch-old/drivers/video/aty/radeon_pm.c	2005-04-08 12:35:21.000000000 +1000
+++ 840-combined-pm_message_t-patch.patch-new/drivers/video/aty/radeon_pm.c	2005-04-08 13:41:41.000000000 +1000
@@ -2529,22 +2529,22 @@ int radeonfb_pci_suspend(struct pci_dev 
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
+	if (state.event != EVENT_SUSPEND)
 		goto done;
 	if (susdisking) {
 		printk("radeonfb (%s): suspending to disk but state = %d\n",
-		       pci_name(pdev), state);
+		       pci_name(pdev), state.event);
 		goto done;
 	}
 
@@ -2638,7 +2638,7 @@ int radeonfb_pci_resume(struct pci_dev *
         struct radeonfb_info *rinfo = info->par;
 	int rc = 0;
 
-	if (pdev->dev.power.power_state == 0)
+	if (!pdev->dev.power.power_state.event)
 		return 0;
 
 	if (rinfo->no_schedule) {
@@ -2648,7 +2648,7 @@ int radeonfb_pci_resume(struct pci_dev *
 		acquire_console_sem();
 
 	printk(KERN_DEBUG "radeonfb (%s): resuming from state: %d...\n",
-	       pci_name(pdev), pdev->dev.power.power_state);
+	       pci_name(pdev), pdev->dev.power.power_state.event);
 
 
 	if (pci_enable_device(pdev)) {
@@ -2659,7 +2659,7 @@ int radeonfb_pci_resume(struct pci_dev *
 	}
 	pci_set_master(pdev);
 
-	if (pdev->dev.power.power_state == PM_SUSPEND_MEM) {
+	if (pdev->dev.power.power_state.event == EVENT_SUSPEND) {
 		/* Wakeup chip. Check from config space if we were powered off
 		 * (todo: additionally, check CLK_PIN_CNTL too)
 		 */
diff -ruNp 840-combined-pm_message_t-patch.patch-old/drivers/video/i810/i810_main.c 840-combined-pm_message_t-patch.patch-new/drivers/video/i810/i810_main.c
--- 840-combined-pm_message_t-patch.patch-old/drivers/video/i810/i810_main.c	2005-04-08 12:35:22.000000000 +1000
+++ 840-combined-pm_message_t-patch.patch-new/drivers/video/i810/i810_main.c	2005-04-08 13:41:41.000000000 +1000
@@ -1498,12 +1498,12 @@ static int i810fb_suspend(struct pci_dev
 	struct i810fb_par *par = (struct i810fb_par *) info->par;
 	int blank = 0, prev_state = par->cur_state;
 
-	if (state == prev_state)
+	if (state.event == prev_state.event)
 		return 0;
 
-	par->cur_state = state;
+	par->cur_state = state.event;
 
-	switch (state) {
+	switch (state.event) {
 	case 1:
 		blank = VESA_VSYNC_SUSPEND;
 		break;
diff -ruNp 840-combined-pm_message_t-patch.patch-old/drivers/video/savage/savagefb_driver.c 840-combined-pm_message_t-patch.patch-new/drivers/video/savage/savagefb_driver.c
--- 840-combined-pm_message_t-patch.patch-old/drivers/video/savage/savagefb_driver.c	2005-04-08 12:35:22.000000000 +1000
+++ 840-combined-pm_message_t-patch.patch-new/drivers/video/savage/savagefb_driver.c	2005-04-08 13:41:41.000000000 +1000
@@ -2103,22 +2103,22 @@ static void __devexit savagefb_remove (s
 	}
 }
 
-static int savagefb_suspend (struct pci_dev* dev, u32 state)
+static int savagefb_suspend (struct pci_dev* dev, pm_message_t state)
 {
 	struct fb_info *info =
 		(struct fb_info *)pci_get_drvdata(dev);
 	struct savagefb_par *par = (struct savagefb_par *)info->par;
 
 	DBG("savagefb_suspend");
-	printk(KERN_DEBUG "state: %u\n", state);
+	printk(KERN_DEBUG "state: %u\n", state.event);
 
 	acquire_console_sem();
-	fb_set_suspend(info, state);
+	fb_set_suspend(info, (state.event != EVENT_ON));
 	savage_disable_mmio(par);
 	release_console_sem();
 
 	pci_disable_device(dev);
-	pci_set_power_state(dev, state);
+	pci_set_power_state(dev, pci_choose_state(dev, state));
 
 	return 0;
 }
diff -ruNp 840-combined-pm_message_t-patch.patch-old/include/linux/pm.h 840-combined-pm_message_t-patch.patch-new/include/linux/pm.h
--- 840-combined-pm_message_t-patch.patch-old/include/linux/pm.h	2005-03-18 19:33:24.000000000 +1100
+++ 840-combined-pm_message_t-patch.patch-new/include/linux/pm.h	2005-04-08 13:41:41.000000000 +1000
@@ -185,7 +185,10 @@ extern int pm_suspend(suspend_state_t st
 
 struct device;
 
-typedef u32 __bitwise pm_message_t;
+typedef struct pm_message {
+	int event;
+	int flags;
+} pm_message_t;
 
 /*
  * There are 4 important states driver can be in:
@@ -205,9 +208,16 @@ typedef u32 __bitwise pm_message_t;
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
+
 
 struct dev_pm_info {
 	pm_message_t		power_state;
diff -ruNp 840-combined-pm_message_t-patch.patch-old/include/linux/usb.h 840-combined-pm_message_t-patch.patch-new/include/linux/usb.h
--- 840-combined-pm_message_t-patch.patch-old/include/linux/usb.h	2005-04-08 12:35:27.000000000 +1000
+++ 840-combined-pm_message_t-patch.patch-new/include/linux/usb.h	2005-04-08 13:41:41.000000000 +1000
@@ -558,7 +558,7 @@ struct usb_driver {
 
 	int (*ioctl) (struct usb_interface *intf, unsigned int code, void *buf);
 
-	int (*suspend) (struct usb_interface *intf, u32 state);
+	int (*suspend) (struct usb_interface *intf, pm_message_t state);
 	int (*resume) (struct usb_interface *intf);
 
 	const struct usb_device_id *id_table;
@@ -977,7 +977,7 @@ extern int usb_bulk_msg(struct usb_devic
 	int timeout);
 
 /* selective suspend/resume */
-extern int usb_suspend_device(struct usb_device *dev, u32 state);
+extern int usb_suspend_device(struct usb_device *dev, pm_message_t state);
 extern int usb_resume_device(struct usb_device *dev);
 
 
diff -ruNp 840-combined-pm_message_t-patch.patch-old/sound/pci/atiixp.c 840-combined-pm_message_t-patch.patch-new/sound/pci/atiixp.c
--- 840-combined-pm_message_t-patch.patch-old/sound/pci/atiixp.c	2005-04-08 12:35:32.000000000 +1000
+++ 840-combined-pm_message_t-patch.patch-new/sound/pci/atiixp.c	2005-04-08 13:41:41.000000000 +1000
@@ -1419,7 +1419,7 @@ static int snd_atiixp_suspend(snd_card_t
 	snd_atiixp_aclink_down(chip);
 	snd_atiixp_chip_stop(chip);
 
-	pci_set_power_state(chip->pci, 3);
+	pci_set_power_state(chip->pci, PCI_D3hot);
 	pci_disable_device(chip->pci);
 	return 0;
 }
@@ -1430,7 +1430,7 @@ static int snd_atiixp_resume(snd_card_t 
 	int i;
 
 	pci_enable_device(chip->pci);
-	pci_set_power_state(chip->pci, 0);
+	pci_set_power_state(chip->pci, PCI_D0);
 	pci_set_master(chip->pci);
 
 	snd_atiixp_aclink_reset(chip);
diff -ruNp 840-combined-pm_message_t-patch.patch-old/sound/pci/atiixp_modem.c 840-combined-pm_message_t-patch.patch-new/sound/pci/atiixp_modem.c
--- 840-combined-pm_message_t-patch.patch-old/sound/pci/atiixp_modem.c	2005-03-18 19:33:28.000000000 +1100
+++ 840-combined-pm_message_t-patch.patch-new/sound/pci/atiixp_modem.c	2005-04-08 13:41:41.000000000 +1000
@@ -1121,7 +1121,7 @@ static int snd_atiixp_suspend(snd_card_t
 	snd_atiixp_aclink_down(chip);
 	snd_atiixp_chip_stop(chip);
 
-	pci_set_power_state(chip->pci, 3);
+	pci_set_power_state(chip->pci, PCI_D3hot);
 	pci_disable_device(chip->pci);
 	return 0;
 }
@@ -1132,7 +1132,7 @@ static int snd_atiixp_resume(snd_card_t 
 	int i;
 
 	pci_enable_device(chip->pci);
-	pci_set_power_state(chip->pci, 0);
+	pci_set_power_state(chip->pci, PCI_D0);
 	pci_set_master(chip->pci);
 
 	snd_atiixp_aclink_reset(chip);

-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net

