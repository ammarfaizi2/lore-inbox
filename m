Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbTISTIq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 15:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261691AbTISTIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 15:08:45 -0400
Received: from mail.kroah.org ([65.200.24.183]:13506 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261690AbTISTIi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 15:08:38 -0400
Date: Fri, 19 Sep 2003 12:08:56 -0700
From: Greg KH <greg@kroah.com>
To: jtholmes <jtholmes@jtholmes.com>
Cc: linux-kernel@vger.kernel.org, jtholmesjr@comcast.net,
       David Brownell <david-b@pacbell.net>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: irq 11: nobody cared! is back
Message-ID: <20030919190856.GJ6624@kroah.com>
References: <3F6B0671.1070603@jtholmes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F6B0671.1070603@jtholmes.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 19, 2003 at 09:36:49AM -0400, jtholmes wrote:
> I don't take the  Distribution, and don't need email copy of
> answer,  just  answer in LKML  and I will see it.
> 
> If I knew how to turn on more debugging I would gladly do so
> as I need to figure out the Kernel debugging scheme.
> 
> Problem  Description
> 
> 	After loading  Module uhci-hcd
> 
> 	USB Optical Mouse light shuts off and  irq 11:  is disabled.

Hm, can you apply this patch with -R and see if it fixes your problem?

thanks,

greg k-h


diff -Nru a/drivers/usb/host/uhci-hcd.c b/drivers/usb/host/uhci-hcd.c
--- a/drivers/usb/host/uhci-hcd.c	Fri Sep 19 12:13:36 2003
+++ b/drivers/usb/host/uhci-hcd.c	Fri Sep 19 12:13:36 2003
@@ -2143,6 +2143,20 @@
 #endif
 }
 
+static int uhci_reset(struct usb_hcd *hcd)
+{
+	struct uhci_hcd *uhci = hcd_to_uhci(hcd);
+
+	uhci->io_addr = (unsigned long) hcd->regs;
+
+	/* Maybe kick BIOS off this hardware.  Then reset, so we won't get
+	 * interrupts from any previous setup.
+	 */
+	pci_write_config_word(hcd->pdev, USBLEGSUP, USBLEGSUP_DEFAULT);
+	reset_hc(uhci);
+	return 0;
+}
+
 /*
  * Allocate a frame list, and then setup the skeleton
  *
@@ -2159,7 +2173,7 @@
  *  - The fourth queue is the bandwidth reclamation queue, which loops back
  *    to the high speed control queue.
  */
-static int __devinit uhci_start(struct usb_hcd *hcd)
+static int uhci_start(struct usb_hcd *hcd)
 {
 	struct uhci_hcd *uhci = hcd_to_uhci(hcd);
 	int retval = -EBUSY;
@@ -2171,7 +2185,6 @@
 	struct proc_dir_entry *ent;
 #endif
 
-	uhci->io_addr = (unsigned long) hcd->regs;
 	io_size = pci_resource_len(hcd->pdev, hcd->region);
 
 #ifdef CONFIG_PROC_FS
@@ -2188,10 +2201,6 @@
 	uhci->proc_entry = ent;
 #endif
 
-	/* Reset here so we don't get any interrupts from an old setup */
-	/*  or broken setup */
-	reset_hc(uhci);
-
 	uhci->fsbr = 0;
 	uhci->fsbrtimeout = 0;
 
@@ -2343,9 +2352,6 @@
 
 	init_stall_timer(hcd);
 
-	/* disable legacy emulation */
-	pci_write_config_word(hcd->pdev, USBLEGSUP, USBLEGSUP_DEFAULT);
-
 	udev->speed = USB_SPEED_FULL;
 
 	if (usb_register_root_hub(udev, &hcd->pdev->dev) != 0) {
@@ -2484,6 +2490,7 @@
 	.flags =		HCD_USB11,
 
 	/* Basic lifecycle operations */
+	.reset =		uhci_reset,
 	.start =		uhci_start,
 #ifdef CONFIG_PM
 	.suspend =		uhci_suspend,
