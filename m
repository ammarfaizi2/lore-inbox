Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272390AbTGYXsZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 19:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272391AbTGYXsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 19:48:25 -0400
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:41132 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S272390AbTGYXsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 19:48:20 -0400
Message-ID: <3F21C5FA.5020507@pacbell.net>
Date: Fri, 25 Jul 2003 17:06:18 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>, "Trever L. Adams" <tadams-lists@myrealbox.com>
CC: arjanv@redhat.com, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [More Info] Re: 2.6.0test 1 fails on eth0 up (arjanv RPM's -
 all needed rpms installed)
References: <1058196612.3353.2.camel@aurora.localdomain> <3F12FF53.7060708@pobox.com> <1058210139.5981.6.camel@laptop.fenrus.com> <1058217601.4441.1.camel@aurora.localdomain> <1058299838.3358.4.camel@aurora.localdomain> <20030715210240.GA5345@kroah.com>
In-Reply-To: <20030715210240.GA5345@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------000102010603090809090102"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000102010603090809090102
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Greg KH wrote:
> On Tue, Jul 15, 2003 at 04:10:38PM -0400, Trever L. Adams wrote:
> 
>>kernel: ehci_hcd 0000:00:02.2: PCI device 10de:0068 (nVidia Corporation)
>>kernel: irq 3: nobody cared!
>>kernel: Call Trace:
>>...
> 
> 
> Hm, but usb_hcd_irq() reports back the proper interrupt return value.  I
> don't see how this could happen, unless the ehci driver was somehow
> halted...
> 
> David, any ideas?

See if this patch resolves it.

The patch adds an explicit reset to HCD initialization, and then makes
EHCI use it.  (OHCI could do so even more easily ... but nobody's reported
firmware acting that type of strange with OHCI.)   It should prevent IRQs
being enabled while the HC is still in an indeterminate state.

This also fixes a missing local_irq_restore() that was generating some
annoying might_sleep() messages, and a missing readb() that affects some
ARM (and other) PCI systems.

- Dave



--------------000102010603090809090102
Content-Type: text/plain;
 name="hcd-reset.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hcd-reset.patch"

--- 1.29/drivers/usb/core/hcd.h	Tue Jul  1 06:25:37 2003
+++ edited/drivers/usb/core/hcd.h	Thu Jul 24 11:20:45 2003
@@ -173,6 +173,7 @@
 #define	HCD_USB2	0x0020		/* USB 2.0 */
 
 	/* called to init HCD and root hub */
+	int	(*reset) (struct usb_hcd *hcd);
 	int	(*start) (struct usb_hcd *hcd);
 
 	/* called after all devices were suspended */
--- 1.17/drivers/usb/core/hcd-pci.c	Tue Jul 15 07:08:20 2003
+++ edited/drivers/usb/core/hcd-pci.c	Fri Jul 25 16:30:27 2003
@@ -122,10 +122,9 @@
 		base = (void *) resource;
 	}
 
-	// driver->start(), later on, will transfer device from
+	// driver->reset(), later on, will transfer device from
 	// control by SMM/BIOS to control by Linux (if needed)
 
-	pci_set_master (dev);
 	hcd = driver->hcd_alloc ();
 	if (hcd == NULL){
 		dbg ("hcd alloc fail");
@@ -140,6 +139,9 @@
 			return retval;
 		}
 	}
+	hcd->regs = base;
+	hcd->region = region;
+
 	pci_set_drvdata (dev, hcd);
 	hcd->driver = driver;
 	hcd->description = driver->description;
@@ -157,22 +159,27 @@
 
 	dev_info (hcd->controller, "%s\n", hcd->product_desc);
 
+	/* till now HC has been in an indeterminate state ... */
+	if (driver->reset && (retval = driver->reset (hcd)) < 0) {
+		dev_err (hcd->controller, "can't reset\n");
+		goto clean_3;
+	}
+
+	pci_set_master (dev);
 #ifndef __sparc__
 	sprintf (buf, "%d", dev->irq);
 #else
 	bufp = __irq_itoa(dev->irq);
 #endif
-	if (request_irq (dev->irq, usb_hcd_irq, SA_SHIRQ, hcd->description, hcd)
-			!= 0) {
+	retval = request_irq (dev->irq, usb_hcd_irq, SA_SHIRQ,
+				hcd->description, hcd);
+	if (retval != 0) {
 		dev_err (hcd->controller,
 				"request interrupt %s failed\n", bufp);
-		retval = -EBUSY;
 		goto clean_3;
 	}
 	hcd->irq = dev->irq;
 
-	hcd->regs = base;
-	hcd->region = region;
 	dev_info (hcd->controller, "irq %s, %s %p\n", bufp,
 		(driver->flags & HCD_MEMORY) ? "pci mem" : "io base",
 		base);
--- 1.68/drivers/usb/core/hcd.c	Tue Jul 15 09:47:16 2003
+++ edited/drivers/usb/core/hcd.c	Thu Jul 24 23:34:01 2003
@@ -1319,6 +1319,7 @@
 		if (tmp == -EINPROGRESS)
 			urb->status = -ESHUTDOWN;
 		spin_unlock (&urb->lock);
+		local_irq_restore (flags);
 
 		/* kick hcd unless it's already returning this */
 		if (tmp == -EINPROGRESS) {
--- 1.53/drivers/usb/host/ehci-hcd.c	Wed Jun 18 21:50:06 2003
+++ edited/drivers/usb/host/ehci-hcd.c	Fri Jul 25 16:35:10 2003
@@ -318,27 +318,21 @@
 
 /* called by khubd or root hub init threads */
 
-static int ehci_start (struct usb_hcd *hcd)
+static int ehci_hc_reset (struct usb_hcd *hcd)
 {
 	struct ehci_hcd		*ehci = hcd_to_ehci (hcd);
 	u32			temp;
-	struct usb_device	*udev;
-	struct usb_bus		*bus;
-	int			retval;
-	u32			hcc_params;
-	u8                      tempbyte;
 
 	spin_lock_init (&ehci->lock);
 
 	ehci->caps = (struct ehci_caps *) hcd->regs;
-	ehci->regs = (struct ehci_regs *) (hcd->regs + ehci->caps->length);
-	dbg_hcs_params (ehci, "ehci_start");
-	dbg_hcc_params (ehci, "ehci_start");
-
-	hcc_params = readl (&ehci->caps->hcc_params);
+	ehci->regs = (struct ehci_regs *) (hcd->regs +
+					readb (&ehci->caps->length));
+	dbg_hcs_params (ehci, "reset");
+	dbg_hcc_params (ehci, "reset");
 
 	/* EHCI 0.96 and later may have "extended capabilities" */
-	temp = HCC_EXT_CAPS (hcc_params);
+	temp = HCC_EXT_CAPS (readl (&ehci->caps->hcc_params));
 	while (temp) {
 		u32		cap;
 
@@ -363,8 +357,18 @@
 	ehci->hcs_params = readl (&ehci->caps->hcs_params);
 
 	/* force HC to halt state */
-	if ((retval = ehci_halt (ehci)) != 0)
-		return retval;
+	return ehci_halt (ehci);
+}
+
+static int ehci_start (struct usb_hcd *hcd)
+{
+	struct ehci_hcd		*ehci = hcd_to_ehci (hcd);
+	u32			temp;
+	struct usb_device	*udev;
+	struct usb_bus		*bus;
+	int			retval;
+	u32			hcc_params;
+	u8                      tempbyte;
 
 	/*
 	 * hw default: 1K periodic list heads, one per frame.
@@ -375,6 +379,7 @@
 		return retval;
 
 	/* controllers may cache some of the periodic schedule ... */
+	hcc_params = readl (&ehci->caps->hcc_params);
 	if (HCC_ISOC_CACHE (hcc_params)) 	// full frame cache
 		ehci->i_thresh = 8;
 	else					// N microframes cached
@@ -937,6 +942,7 @@
 	/*
 	 * basic lifecycle operations
 	 */
+	.reset =		ehci_hc_reset,
 	.start =		ehci_start,
 #ifdef	CONFIG_PM
 	.suspend =		ehci_suspend,

--------------000102010603090809090102--

