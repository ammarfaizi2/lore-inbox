Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262702AbVCKNI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262702AbVCKNI6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 08:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262726AbVCKNI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 08:08:58 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4255 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262702AbVCKNIu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 08:08:50 -0500
Date: Fri, 11 Mar 2005 14:08:31 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: fix-u32-vs-pm_message_t-in-usb
Message-ID: <20050311130831.GC1379@elf.ucw.cz>
References: <20050310223353.47601d54.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050310223353.47601d54.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch has been spitting warnings:
> 
> drivers/usb/host/uhci-hcd.c:838: warning: initialization from incompatible pointer type
> drivers/usb/host/ohci-pci.c:191: warning: initialization from incompatible pointer type
> 
> Because hc_driver.suspend() takes a u32 as its second arg.  Changing that
> to pci_power_t causes build failures and including pci.h in usb.h seems
> wrong.
> 
> Wanna fix it sometime?

Yep. Here it is.

This fixes remaining confusion. Part of my old patch was merged, I
later decided passing pci_power_t down to drivers is bad idea; this
passes them pm_message_t which contains more info (and actually works
:-). Please apply,

Signed-off-by: Pavel Machek <pavel@suse.cz>

								Pavel

--- clean-mm/drivers/usb/core/hcd-pci.c	2005-03-11 11:25:37.000000000 +0100
+++ linux-mm/drivers/usb/core/hcd-pci.c	2005-03-11 13:46:41.000000000 +0100
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
 
@@ -228,7 +231,7 @@
 	 */
 	case USB_STATE_RUNNING:
 		hcd->state = USB_STATE_QUIESCING;
-		retval = hcd->driver->suspend (hcd, state);
+		retval = hcd->driver->suspend (hcd, pmsg);
 		if (retval) {
 			dev_dbg (hcd->self.controller, 
 					"suspend fail, retval %d\n",
@@ -291,9 +294,6 @@
 		break;
 	}
 
-	/* update power_state **ONLY** to make sysfs happier */
-	if (retval == 0)
-		dev->dev.power.power_state = state;
 	return retval;
 }
 EXPORT_SYMBOL (usb_hcd_pci_suspend);
--- clean-mm/drivers/usb/core/hcd.h	2005-03-11 11:25:37.000000000 +0100
+++ linux-mm/drivers/usb/core/hcd.h	2005-03-11 13:44:18.000000000 +0100
@@ -175,7 +175,7 @@
 	 * a whole, not just the root hub; they're for bus glue.
 	 */
 	/* called after all devices were suspended */
-	int	(*suspend) (struct usb_hcd *hcd, u32 state);
+	int	(*suspend) (struct usb_hcd *hcd, pm_message_t state);
 
 	/* called before any devices get resumed */
 	int	(*resume) (struct usb_hcd *hcd);
--- clean-mm/drivers/usb/host/ehci-hcd.c	2005-03-11 11:25:37.000000000 +0100
+++ linux-mm/drivers/usb/host/ehci-hcd.c	2005-03-11 13:44:18.000000000 +0100
@@ -721,7 +721,7 @@
  * the right sort of wakeup.  
  */
 
-static int ehci_suspend (struct usb_hcd *hcd, pci_power_t state)
+static int ehci_suspend (struct usb_hcd *hcd, pm_message_t state)
 {
 	struct ehci_hcd		*ehci = hcd_to_ehci (hcd);
 
--- clean-mm/drivers/usb/host/ohci-pci.c	2005-03-11 11:25:37.000000000 +0100
+++ linux-mm/drivers/usb/host/ohci-pci.c	2005-03-11 13:44:18.000000000 +0100
@@ -102,7 +102,7 @@
 
 #ifdef	CONFIG_PM
 
-static int ohci_pci_suspend (struct usb_hcd *hcd, pci_power_t state)
+static int ohci_pci_suspend (struct usb_hcd *hcd, pm_message_t state)
 {
 	struct ohci_hcd		*ohci = hcd_to_ohci (hcd);
 
--- clean-mm/drivers/usb/host/uhci-hcd.c	2005-03-11 11:25:37.000000000 +0100
+++ linux-mm/drivers/usb/host/uhci-hcd.c	2005-03-11 13:44:18.000000000 +0100
@@ -758,7 +758,7 @@
 }
 
 #ifdef CONFIG_PM
-static int uhci_suspend(struct usb_hcd *hcd, pci_power_t state)
+static int uhci_suspend(struct usb_hcd *hcd, pm_message_t state)
 {
 	struct uhci_hcd *uhci = hcd_to_uhci(hcd);
 
--- clean-mm/drivers/video/aty/radeon_pm.c	2005-03-11 11:25:38.000000000 +0100
+++ linux-mm/drivers/video/aty/radeon_pm.c	2005-03-11 13:56:52.000000000 +0100
@@ -2521,7 +2521,7 @@
 
 static/*extern*/ int susdisking = 0;
 
-int radeonfb_pci_suspend(struct pci_dev *pdev, u32 state)
+int radeonfb_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 {
         struct fb_info *info = pci_get_drvdata(pdev);
         struct radeonfb_info *rinfo = info->par;
--- clean-mm/include/linux/usb.h	2005-03-11 11:25:39.000000000 +0100
+++ linux-mm/include/linux/usb.h	2005-03-11 13:44:18.000000000 +0100
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
