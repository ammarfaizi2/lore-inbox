Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbVBOAkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbVBOAkP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 19:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbVBOAkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 19:40:15 -0500
Received: from gprs215-140.eurotel.cz ([160.218.215.140]:44256 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261403AbVBOAj5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 19:39:57 -0500
Date: Tue, 15 Feb 2005 01:39:35 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>, gregkh@suse.de
Cc: ncunningham@cyclades.com, bernard@blackham.com.au, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Fix u32 vs. pm_message_t in USB [was Re: PATCH: Address lots of pending pm_message_t changes]
Message-ID: <20050215003935.GB5415@elf.ucw.cz>
References: <1108359808.12611.37.camel@desktop.cunningham.myip.net.au> <20050214213400.GF12235@elf.ucw.cz> <20050214134658.324076c9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050214134658.324076c9.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This fixes (part of) u32 vs. pm_message_t confusion in USB. It should
cause no code changes. Please apply,

								Pavel
Signed-off-by: Pavel Machek <pavel@suse.cz>


--- clean-mm/drivers/usb/core/hcd-pci.c	2005-02-15 00:34:40.000000000 +0100
+++ linux-mm/drivers/usb/core/hcd-pci.c	2005-02-15 01:04:10.000000000 +0100
@@ -396,7 +396,7 @@
 
 	if (has_pci_pm)
 		pci_set_power_state (dev, 0);
-	dev->dev.power.power_state = 0;
+	dev->dev.power.power_state = PMSG_ON;
 	retval = request_irq (dev->irq, usb_hcd_irq, SA_SHIRQ,
 				hcd->driver->description, hcd);
 	if (retval < 0) {
--- clean-mm/drivers/usb/core/hcd.h	2005-02-15 00:46:41.000000000 +0100
+++ linux-mm/drivers/usb/core/hcd.h	2005-02-15 01:04:10.000000000 +0100
@@ -223,7 +223,7 @@
 extern void usb_hcd_pci_remove (struct pci_dev *dev);
 
 #ifdef CONFIG_PM
-extern int usb_hcd_pci_suspend (struct pci_dev *dev, u32 state);
+extern int usb_hcd_pci_suspend (struct pci_dev *dev, pm_message_t state);
 extern int usb_hcd_pci_resume (struct pci_dev *dev);
 #endif /* CONFIG_PM */
 
--- clean-mm/drivers/usb/core/hub.c	2005-02-15 00:46:41.000000000 +0100
+++ linux-mm/drivers/usb/core/hub.c	2005-02-15 01:06:01.000000000 +0100
@@ -1635,7 +1635,7 @@
  *
  * Returns 0 on success, else negative errno.
  */
-int usb_suspend_device(struct usb_device *udev, u32 state)
+int usb_suspend_device(struct usb_device *udev, pm_message_t state)
 {
 	int	port1, status;
 
@@ -1950,7 +1950,7 @@
 
 #else	/* !CONFIG_USB_SUSPEND */
 
-int usb_suspend_device(struct usb_device *udev, u32 state)
+int usb_suspend_device(struct usb_device *udev, pm_message_t state)
 {
 	return 0;
 }
--- clean-mm/drivers/usb/core/usb.c	2005-02-15 00:34:40.000000000 +0100
+++ linux-mm/drivers/usb/core/usb.c	2005-02-15 01:04:11.000000000 +0100
@@ -1348,7 +1348,7 @@
 			usb_pipein (pipe) ? DMA_FROM_DEVICE : DMA_TO_DEVICE);
 }
 
-static int usb_generic_suspend(struct device *dev, u32 state)
+static int usb_generic_suspend(struct device *dev, pm_message_t state)
 {
 	struct usb_interface *intf;
 	struct usb_driver *driver;
--- clean-mm/drivers/usb/host/ehci-hcd.c	2005-02-15 00:34:40.000000000 +0100
+++ linux-mm/drivers/usb/host/ehci-hcd.c	2005-02-15 01:04:11.000000000 +0100
@@ -677,7 +677,7 @@
  * the right sort of wakeup.  
  */
 
-static int ehci_suspend (struct usb_hcd *hcd, u32 state)
+static int ehci_suspend (struct usb_hcd *hcd, pci_power_t state)
 {
 	struct ehci_hcd		*ehci = hcd_to_ehci (hcd);
 
--- clean-mm/drivers/usb/host/ohci-pci.c	2005-02-15 00:34:40.000000000 +0100
+++ linux-mm/drivers/usb/host/ohci-pci.c	2005-02-15 01:04:11.000000000 +0100
@@ -102,7 +102,7 @@
 
 #ifdef	CONFIG_PM
 
-static int ohci_pci_suspend (struct usb_hcd *hcd, u32 state)
+static int ohci_pci_suspend (struct usb_hcd *hcd, pci_power_t state)
 {
 	struct ohci_hcd		*ohci = hcd_to_ohci (hcd);
 
--- clean-mm/drivers/usb/host/sl811-hcd.c	2005-02-15 00:34:40.000000000 +0100
+++ linux-mm/drivers/usb/host/sl811-hcd.c	2005-02-15 01:04:11.000000000 +0100
@@ -103,12 +103,12 @@
 
 		sl811->port1 = (1 << USB_PORT_FEAT_POWER);
 		sl811->irq_enable = SL11H_INTMASK_INSRMV;
-		hcd->self.controller->power.power_state = PM_SUSPEND_ON;
+		hcd->self.controller->power.power_state = PMSG_ON;
 	} else {
 		sl811->port1 = 0;
 		sl811->irq_enable = 0;
 		hcd->state = USB_STATE_HALT;
-		hcd->self.controller->power.power_state = PM_SUSPEND_DISK;
+		hcd->self.controller->power.power_state = PMSG_SUSPEND;
 	}
 	sl811->ctrl1 = 0;
 	sl811_write(sl811, SL11H_IRQ_ENABLE, 0);
@@ -1799,7 +1799,7 @@
  */
 
 static int
-sl811h_suspend(struct device *dev, u32 state, u32 phase)
+sl811h_suspend(struct device *dev, pm_message_t state, u32 phase)
 {
 	struct sl811	*sl811 = dev_get_drvdata(dev);
 	int		retval = 0;
--- clean-mm/drivers/usb/host/uhci-hcd.c	2005-02-15 00:46:41.000000000 +0100
+++ linux-mm/drivers/usb/host/uhci-hcd.c	2005-02-15 01:04:11.000000000 +0100
@@ -758,7 +758,7 @@
 }
 
 #ifdef CONFIG_PM
-static int uhci_suspend(struct usb_hcd *hcd, u32 state)
+static int uhci_suspend(struct usb_hcd *hcd, pci_power_t state)
 {
 	struct uhci_hcd *uhci = hcd_to_uhci(hcd);
 
--- clean-mm/drivers/usb/input/hid-core.c	2005-02-15 00:46:41.000000000 +0100
+++ linux-mm/drivers/usb/input/hid-core.c	2005-02-15 01:04:11.000000000 +0100
@@ -1854,7 +1854,7 @@
 	return 0;
 }
 
-static int hid_suspend(struct usb_interface *intf, u32 state)
+static int hid_suspend(struct usb_interface *intf, pm_message_t state)
 {
 	struct hid_device *hid = usb_get_intfdata (intf);
 
@@ -1869,7 +1869,7 @@
 	struct hid_device *hid = usb_get_intfdata (intf);
 	int status;
 
-	intf->dev.power.power_state = PM_SUSPEND_ON;
+	intf->dev.power.power_state = PMSG_ON;
 	if (hid->open)
 		status = usb_submit_urb(hid->urbin, GFP_NOIO);
 	else
--- clean-mm/drivers/usb/net/pegasus.c	2005-02-15 00:34:40.000000000 +0100
+++ linux-mm/drivers/usb/net/pegasus.c	2005-02-15 01:04:11.000000000 +0100
@@ -1253,7 +1253,7 @@
 	free_netdev(pegasus->net);
 }
 
-static int pegasus_suspend (struct usb_interface *intf, u32 state)
+static int pegasus_suspend (struct usb_interface *intf, pm_message_t state)
 {
 	struct pegasus *pegasus = usb_get_intfdata(intf);
 	

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
