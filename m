Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261315AbVDBVss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbVDBVss (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 16:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbVDBVSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 16:18:51 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:27114 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261297AbVDBVOt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 16:14:49 -0500
Date: Sat, 2 Apr 2005 23:14:12 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Greg KH <greg@kroah.com>, kernel list <linux-kernel@vger.kernel.org>
Subject: fix u32 vs. pm_message_t in usb
Message-ID: <20050402211412.GA2069@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I thought I'm done with fixing u32 vs. pm_message_t ... unfortunately
that turned out not to be the case as Russel King pointed out. Here
are remaining fixes for USB. [These patches are independend and change
no object code; therefore not numbered].

Please apply,

Signed-off-by: Pavel Machek <pavel@suse.cz>
                                                        Pavel

--- clean-cvs/drivers/usb/core/hcd-pci.c	2005-03-31 23:34:27.000000000 +0200
+++ linux-cvs/drivers/usb/core/hcd-pci.c	2005-03-31 23:54:47.000000000 +0200
@@ -186,7 +186,7 @@
 
 #ifdef	CONFIG_PM
 
-static char __attribute_used__ *pci_state(u32 state)
+static char __attribute_used__ *pci_state(pci_power_t state)
 {
 	switch (state) {
 	case 0:		return "D0";
@@ -205,11 +205,12 @@
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
 
@@ -218,8 +219,10 @@
 	 * PM-sensitive HCDs may already have done this.
 	 */
 	has_pci_pm = pci_find_capability(dev, PCI_CAP_ID_PM);
-	if (state > 4)
-		state = 4;
+
+	state = pci_choose_state(dev, pmsg);
+	if (state > PCI_D3cold)
+		state = PCI_D3cold;
 
 	switch (hcd->state) {
 
@@ -291,9 +294,6 @@
 		break;
 	}
 
-	/* update power_state **ONLY** to make sysfs happier */
-	if (retval == 0)
-		dev->dev.power.power_state = state;
 	return retval;
 }
 EXPORT_SYMBOL (usb_hcd_pci_suspend);
@@ -327,7 +327,7 @@
 
 	if (has_pci_pm)
 		pci_set_power_state (dev, 0);
-	dev->dev.power.power_state = 0;
+	dev->dev.power.power_state = PMSG_ON;
 	retval = request_irq (dev->irq, usb_hcd_irq, SA_SHIRQ,
 				hcd->driver->description, hcd);
 	if (retval < 0) {
--- clean-cvs/drivers/usb/core/hcd.h	2005-03-31 23:34:27.000000000 +0200
+++ linux-cvs/drivers/usb/core/hcd.h	2005-03-31 23:54:47.000000000 +0200
@@ -18,6 +18,7 @@
 
 
 #ifdef __KERNEL__
+#include <linux/pci.h>
 
 /* This file contains declarations of usbcore internals that are mostly
  * used or exposed by Host Controller Drivers.
@@ -177,7 +178,7 @@
 	 * a whole, not just the root hub; they're for bus glue.
 	 */
 	/* called after all devices were suspended */
-	int	(*suspend) (struct usb_hcd *hcd, u32 state);
+	int	(*suspend) (struct usb_hcd *hcd, pm_message_t state);
 
 	/* called before any devices get resumed */
 	int	(*resume) (struct usb_hcd *hcd);
@@ -226,7 +227,7 @@
 extern void usb_hcd_pci_remove (struct pci_dev *dev);
 
 #ifdef CONFIG_PM
-extern int usb_hcd_pci_suspend (struct pci_dev *dev, u32 state);
+extern int usb_hcd_pci_suspend (struct pci_dev *dev, pm_message_t state);
 extern int usb_hcd_pci_resume (struct pci_dev *dev);
 #endif /* CONFIG_PM */
 
--- clean-cvs/drivers/usb/core/hub.c	2005-03-31 23:34:27.000000000 +0200
+++ linux-cvs/drivers/usb/core/hub.c	2005-03-31 23:54:47.000000000 +0200
@@ -1456,7 +1456,7 @@
 	/* FIXME let caller ask to power down the port:
 	 *  - some devices won't enumerate without a VBUS power cycle
 	 *  - SRP saves power that way
-	 *  - usb_suspend_device(dev,PM_SUSPEND_DISK)
+	 *  - usb_suspend_device(dev, PMSG_SUSPEND)
 	 * That's easy if this hub can switch power per-port, and
 	 * khubd reactivates the port later (timer, SRP, etc).
 	 * Powerdown must be optional, because of reset/DFU.
@@ -1531,7 +1531,7 @@
 
 /*
  * Devices on USB hub ports have only one "suspend" state, corresponding
- * to ACPI D2 (PM_SUSPEND_MEM), "may cause the device to lose some context".
+ * to ACPI D2, "may cause the device to lose some context".
  * State transitions include:
  *
  *   - suspend, resume ... when the VBUS power link stays live
--- clean-cvs/drivers/usb/core/usb.c	2005-03-31 23:34:27.000000000 +0200
+++ linux-cvs/drivers/usb/core/usb.c	2005-04-01 00:12:45.000000000 +0200
@@ -1382,7 +1382,7 @@
 			usb_pipein (pipe) ? DMA_FROM_DEVICE : DMA_TO_DEVICE);
 }
 
-static int usb_generic_suspend(struct device *dev, u32 state)
+static int usb_generic_suspend(struct device *dev, pm_message_t state)
 {
 	struct usb_interface *intf;
 	struct usb_driver *driver;
--- clean-cvs/drivers/usb/gadget/omap_udc.c	2005-03-29 13:30:37.000000000 +0200
+++ linux-cvs/drivers/usb/gadget/omap_udc.c	2005-03-31 23:54:47.000000000 +0200
@@ -2809,17 +2809,15 @@
 	return 0;
 }
 
-/* suspend/resume/wakeup from sysfs (echo > power/state) */
-
-static int omap_udc_suspend(struct device *dev, u32 state, u32 level)
+static int omap_udc_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	if (level != 0)
 		return 0;
 
 	DBG("suspend, state %d\n", state);
 	omap_pullup(&udc->gadget, 0);
-	udc->gadget.dev.power.power_state = 3;
-	udc->gadget.dev.parent->power.power_state = 3;
+	udc->gadget.dev.power.power_state = PMSG_SUSPEND;
+	udc->gadget.dev.parent->power.power_state = PMSG_SUSPEND;
 	return 0;
 }
 
@@ -2829,8 +2827,8 @@
 		return 0;
 
 	DBG("resume + wakeup/SRP\n");
-	udc->gadget.dev.parent->power.power_state = 0;
-	udc->gadget.dev.power.power_state = 0;
+	udc->gadget.dev.parent->power.power_state = PMSG_ON;
+	udc->gadget.dev.power.power_state = PMSG_ON;
 	omap_pullup(&udc->gadget, 1);
 
 	/* maybe the host would enumerate us if we nudged it */
--- clean-cvs/drivers/usb/host/ehci-hcd.c	2005-03-31 23:34:27.000000000 +0200
+++ linux-cvs/drivers/usb/host/ehci-hcd.c	2005-03-31 23:54:47.000000000 +0200
@@ -721,7 +721,7 @@
  * the right sort of wakeup.  
  */
 
-static int ehci_suspend (struct usb_hcd *hcd, u32 state)
+static int ehci_suspend (struct usb_hcd *hcd, pm_message_t state)
 {
 	struct ehci_hcd		*ehci = hcd_to_ehci (hcd);
 
--- clean-cvs/drivers/usb/host/ohci-omap.c	2005-03-31 23:34:28.000000000 +0200
+++ linux-cvs/drivers/usb/host/ohci-omap.c	2005-03-31 23:54:47.000000000 +0200
@@ -458,9 +458,11 @@
 
 /* states match PCI usage, always suspending the root hub except that
  * 4 ~= D3cold (ACPI D3) with clock off (resume sees reset).
+ *
+ * FIXME: above comment is not right, and code is wrong, too :-(.
  */
 
-static int ohci_omap_suspend(struct device *dev, u32 state, u32 level)
+static int ohci_omap_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	struct ohci_hcd	*ohci = hcd_to_ohci(dev_get_drvdata(dev));
 	int		status = -EINVAL;
--- clean-cvs/drivers/usb/host/ohci-pci.c	2005-01-16 22:27:50.000000000 +0100
+++ linux-cvs/drivers/usb/host/ohci-pci.c	2005-03-31 23:54:47.000000000 +0200
@@ -102,7 +102,7 @@
 
 #ifdef	CONFIG_PM
 
-static int ohci_pci_suspend (struct usb_hcd *hcd, u32 state)
+static int ohci_pci_suspend (struct usb_hcd *hcd, pm_message_t state)
 {
 	struct ohci_hcd		*ohci = hcd_to_ohci (hcd);
 
--- clean-cvs/drivers/usb/host/ohci-pxa27x.c	2005-03-29 13:30:38.000000000 +0200
+++ linux-cvs/drivers/usb/host/ohci-pxa27x.c	2005-03-31 23:54:47.000000000 +0200
@@ -337,7 +337,7 @@
 	return 0;
 }
 
-static int ohci_hcd_pxa27x_drv_suspend(struct device *dev, u32 state, u32 level)
+static int ohci_hcd_pxa27x_drv_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 //	struct platform_device *pdev = to_platform_device(dev);
 //	struct usb_hcd *hcd = dev_get_drvdata(dev);
@@ -346,7 +346,7 @@
 	return 0;
 }
 
-static int ohci_hcd_pxa27x_drv_resume(struct device *dev, u32 state)
+static int ohci_hcd_pxa27x_drv_resume(struct device *dev, u32 level)
 {
 //	struct platform_device *pdev = to_platform_device(dev);
 //	struct usb_hcd *hcd = dev_get_drvdata(dev);
--- clean-cvs/drivers/usb/host/uhci-hcd.c	2005-03-31 23:34:28.000000000 +0200
+++ linux-cvs/drivers/usb/host/uhci-hcd.c	2005-03-31 23:54:47.000000000 +0200
@@ -716,7 +716,7 @@
 }
 
 #ifdef CONFIG_PM
-static int uhci_suspend(struct usb_hcd *hcd, u32 state)
+static int uhci_suspend(struct usb_hcd *hcd, pci_power_t state)
 {
 	struct uhci_hcd *uhci = hcd_to_uhci(hcd);
 
--- clean-cvs/drivers/usb/input/hid-core.c	2005-03-29 13:30:38.000000000 +0200
+++ linux-cvs/drivers/usb/input/hid-core.c	2005-03-31 23:54:47.000000000 +0200
@@ -1790,7 +1790,7 @@
 	return 0;
 }
 
-static int hid_suspend(struct usb_interface *intf, u32 state)
+static int hid_suspend(struct usb_interface *intf, pm_message_t state)
 {
 	struct hid_device *hid = usb_get_intfdata (intf);
 
@@ -1805,7 +1805,7 @@
 	struct hid_device *hid = usb_get_intfdata (intf);
 	int status;
 
-	intf->dev.power.power_state = PM_SUSPEND_ON;
+	intf->dev.power.power_state = PMSG_ON;
 	if (hid->open)
 		status = usb_submit_urb(hid->urbin, GFP_NOIO);
 	else
--- clean-cvs/drivers/usb/net/usbnet.c	2005-03-31 23:34:30.000000000 +0200
+++ linux-cvs/drivers/usb/net/usbnet.c	2005-03-31 23:54:47.000000000 +0200
@@ -3732,7 +3732,7 @@
 
 #ifdef	CONFIG_PM
 
-static int usbnet_suspend (struct usb_interface *intf, u32 state)
+static int usbnet_suspend (struct usb_interface *intf, pm_message_t state)
 {
 	struct usbnet		*dev = usb_get_intfdata(intf);
 	

--- clean-cvs/include/linux/pcieport_if.h	2005-01-18 16:48:03.000000000 +0100
+++ linux-cvs/include/linux/pcieport_if.h	2005-03-31 23:54:51.000000000 +0200
@@ -59,7 +59,7 @@
 	int (*probe) (struct pcie_device *dev, 
 		const struct pcie_port_service_id *id);
 	void (*remove) (struct pcie_device *dev);
-	int (*suspend) (struct pcie_device *dev, u32 state);
+	int (*suspend) (struct pcie_device *dev, pm_message_t state);
 	int (*resume) (struct pcie_device *dev);
 
 	const struct pcie_port_service_id *id_table;
--- clean-cvs/include/linux/usb.h	2005-03-31 23:36:06.000000000 +0200
+++ linux-cvs/include/linux/usb.h	2005-03-31 23:54:51.000000000 +0200
@@ -558,7 +558,7 @@
 
 	int (*ioctl) (struct usb_interface *intf, unsigned int code, void *buf);
 
-	int (*suspend) (struct usb_interface *intf, u32 state);
+	int (*suspend) (struct usb_interface *intf, pm_message_t state);
 	int (*resume) (struct usb_interface *intf);
 
 	const struct usb_device_id *id_table;
@@ -977,7 +977,7 @@
 	int timeout);
 
 /* selective suspend/resume */
-extern int usb_suspend_device(struct usb_device *dev, u32 state);
+extern int usb_suspend_device(struct usb_device *dev, pm_message_t state);
 extern int usb_resume_device(struct usb_device *dev);
 
 

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
