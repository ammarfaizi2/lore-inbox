Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261549AbVB1BY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbVB1BY4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 20:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbVB1BY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 20:24:56 -0500
Received: from gprs215-116.eurotel.cz ([160.218.215.116]:28105 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261549AbVB1BYU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 20:24:20 -0500
Date: Mon, 28 Feb 2005 02:24:00 +0100
From: Pavel Machek <pavel@suse.cz>
To: Greg KH <gregkh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, ncunningham@cyclades.com,
       bernard@blackham.com.au, linux-kernel@vger.kernel.org
Subject: Re: Fix u32 vs. pm_message_t in USB [was Re: PATCH: Address lots of pending pm_message_t changes]
Message-ID: <20050228012400.GD1350@elf.ucw.cz>
References: <1108359808.12611.37.camel@desktop.cunningham.myip.net.au> <20050214213400.GF12235@elf.ucw.cz> <20050214134658.324076c9.akpm@osdl.org> <20050215003935.GB5415@elf.ucw.cz> <20050217234054.GD22369@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050217234054.GD22369@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This fixes (part of) u32 vs. pm_message_t confusion in USB. It should
> > cause no code changes. Please apply,
> 
> Large portions of this patch are already in my tree (and hence the -mm
> tree.)  Care to rediff against the latest -mm and resend the patch?

(Sorry for the delay).

Yes, most of it is already applied; this is what was left
over... hcd_pci_suspend() actually does some change, but code should
be equivalent. Greg, please apply,

								Pavel

--- clean-mm/drivers/usb/core/hcd-pci.c	2005-02-28 01:14:01.000000000 +0100
+++ linux-mm/drivers/usb/core/hcd-pci.c	2005-02-28 02:01:56.000000000 +0100
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
--- clean-mm/drivers/usb/core/hcd.h	2005-02-28 01:14:01.000000000 +0100
+++ linux-mm/drivers/usb/core/hcd.h	2005-02-28 02:01:56.000000000 +0100
@@ -18,6 +18,7 @@
 
 
 #ifdef __KERNEL__
+#include <linux/pci.h>
 
 /* This file contains declarations of usbcore internals that are mostly
  * used or exposed by Host Controller Drivers.
@@ -175,7 +176,7 @@
 	 * a whole, not just the root hub; they're for bus glue.
 	 */
 	/* called after all devices were suspended */
-	int	(*suspend) (struct usb_hcd *hcd, u32 state);
+	int	(*suspend) (struct usb_hcd *hcd, pm_message_t state);
 
 	/* called before any devices get resumed */
 	int	(*resume) (struct usb_hcd *hcd);
--- clean-mm/drivers/usb/core/hub.c	2005-02-28 01:14:01.000000000 +0100
+++ linux-mm/drivers/usb/core/hub.c	2005-02-28 02:07:13.000000000 +0100
@@ -1513,7 +1513,7 @@
 
 /*
  * Devices on USB hub ports have only one "suspend" state, corresponding
- * to ACPI D2 (PM_SUSPEND_MEM), "may cause the device to lose some context".
+ * to ACPI D2, "may cause the device to lose some context".
  * State transitions include:
  *
  *   - suspend, resume ... when the VBUS power link stays live
--- clean-mm/drivers/usb/host/sl811-hcd.c	2005-02-28 01:14:01.000000000 +0100
+++ linux-mm/drivers/usb/host/sl811-hcd.c	2005-02-28 02:08:18.000000000 +0100
@@ -1809,7 +1809,7 @@
 		return 0;
 	}
 
-	dev->power.power_state = PM_SUSPEND_ON;
+	dev->power.power_state = PMSG_ON;
 	return sl811h_hub_resume(hcd);
 }
 
--- clean-mm/include/linux/usb.h	2005-02-28 01:14:08.000000000 +0100
+++ linux-mm/include/linux/usb.h	2005-02-28 02:02:05.000000000 +0100
@@ -551,7 +551,7 @@
 
 	int (*ioctl) (struct usb_interface *intf, unsigned int code, void *buf);
 
-	int (*suspend) (struct usb_interface *intf, u32 state);
+	int (*suspend) (struct usb_interface *intf, pm_message_t state);
 	int (*resume) (struct usb_interface *intf);
 
 	const struct usb_device_id *id_table;
@@ -970,7 +970,7 @@
 	int timeout);
 
 /* selective suspend/resume */
-extern int usb_suspend_device(struct usb_device *dev, u32 state);
+extern int usb_suspend_device(struct usb_device *dev, pm_message_t state);
 extern int usb_resume_device(struct usb_device *dev);
 
 


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
