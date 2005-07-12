Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261526AbVGLON2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbVGLON2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 10:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbVGLON1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 10:13:27 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:16035 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S261556AbVGLOMI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 10:12:08 -0400
Date: Tue, 12 Jul 2005 10:12:05 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Michel Bouissou <michel@bouissou.net>
cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.6.12 + IO-APIC + uhci_hcd = Trouble
In-Reply-To: <200507120954.59522@totor.bouissou.net>
Message-ID: <Pine.LNX.4.44L0.0507121004080.4996-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2005, Michel Bouissou wrote:

> > To try and help pin things down, tomorrow (i.e., Tuesday) I'll send you a
> > test patch to completely disable the UHCI controllers, leaving them awake
> > and idle, not generating interrupts.  If you still get those spurious
> > IRQs, they will have to come from somewhere else.  (Assuming you can
> > devote server time to this sort of testing...)
> 
> I'll try my best, although I will have little time for playing with this until 
> the end of this week, and will be on travel next week. But if you send me a 
> test patch, I'll try my best to test it.

Okay, the patch (for 2.6.12) is below.  It does several things:

	Prevents the system from reading the port status registers,
	so the computer won't know when any devices are plugged in.

	Makes the system think there always is a device plugged in,
	so it will never automatically suspend the controllers.

	Leaves all the interrupt-enable bits turned off, so the
	controllers won't ever generate an interrupt request.

	Prints a message to the system log every time the interrupt
	handler is called.

In case it's not already clear, when you install this patch the UHCI 
controllers will not be useable.

Alan Stern


Index: linux-2.6.12/drivers/usb/host/uhci-hub.c
===================================================================
--- linux-2.6.12.orig/drivers/usb/host/uhci-hub.c
+++ linux-2.6.12/drivers/usb/host/uhci-hub.c
@@ -38,6 +38,7 @@ static int uhci_hub_status_data(struct u
 	struct uhci_hcd *uhci = hcd_to_uhci(hcd);
 	int port;
 
+	return 0;
 	*buf = 0;
 	for (port = 0; port < uhci->rh_numports; ++port) {
 		if ((inw(uhci->io_addr + USBPORTSC1 + port * 2) & RWC_BITS) ||
@@ -154,6 +155,7 @@ static int uhci_hub_control(struct usb_h
 		if (to_pci_dev(hcd->self.controller)->vendor ==
 				PCI_VENDOR_ID_VIA)
 			status ^= USBPORTSC_OC;
+		status = 0;
 
 		/* UHCI doesn't support C_RESET (always false) */
 		wPortChange = lstatus = 0;
Index: linux-2.6.12/drivers/usb/host/uhci-hcd.c
===================================================================
--- linux-2.6.12.orig/drivers/usb/host/uhci-hcd.c
+++ linux-2.6.12/drivers/usb/host/uhci-hcd.c
@@ -169,6 +169,7 @@ static irqreturn_t uhci_irq(struct usb_h
 	 * "HC Halted" status bit is persistent: it is RO, not R/WC.
 	 */
 	status = inw(io_addr + USBSTS);
+	dev_info(uhci_dev(uhci), "IRQ, status = %x\n", status);
 	if (!(status & ~USBSTS_HCH))	/* shared interrupt, not mine */
 		return IRQ_NONE;
 	outw(status, io_addr + USBSTS);		/* Clear it */
@@ -282,6 +283,7 @@ static int ports_active(struct uhci_hcd 
 	int connection = 0;
 	int i;
 
+	return 1;
 	for (i = 0; i < uhci->rh_numports; i++)
 		connection |= (inw(io_addr + USBPORTSC1 + i * 2) & USBPORTSC_CCS);
 
@@ -389,8 +391,10 @@ static int start_hc(struct uhci_hcd *uhc
 	/* Turn on PIRQ and all interrupts */
 	pci_write_config_word(to_pci_dev(uhci_dev(uhci)), USBLEGSUP,
 			USBLEGSUP_DEFAULT);
+#if 0
 	outw(USBINTR_TIMEOUT | USBINTR_RESUME | USBINTR_IOC | USBINTR_SP,
 		io_addr + USBINTR);
+#endif
 
 	/* Start at frame 0 */
 	outw(0, io_addr + USBFRNUM);
@@ -757,8 +761,10 @@ static int uhci_resume(struct usb_hcd *h
 				0);
 		outw(uhci->frame_number, uhci->io_addr + USBFRNUM);
 		outl(uhci->fl->dma_handle, uhci->io_addr + USBFLBASEADD);
+#if 0
 		outw(USBINTR_TIMEOUT | USBINTR_RESUME | USBINTR_IOC |
 				USBINTR_SP, uhci->io_addr + USBINTR);
+#endif
 		uhci->resume_detect = 1;
 		pci_write_config_word(to_pci_dev(uhci_dev(uhci)), USBLEGSUP,
 				USBLEGSUP_DEFAULT);

