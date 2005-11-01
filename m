Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbVKAQnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbVKAQnY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 11:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbVKAQnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 11:43:24 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:31725 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1750936AbVKAQnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 11:43:24 -0500
Date: Tue, 1 Nov 2005 11:43:22 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Linus Torvalds <torvalds@osdl.org>
cc: Paul Mackerras <paulus@samba.org>, <akpm@osdl.org>,
       David Brownell <david-b@pacbell.net>,
       Greg Kroah-Hartman <gregkh@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Don't touch USB controllers with MMIO disabled in quirks
In-Reply-To: <Pine.LNX.4.64.0511010748430.27915@g5.osdl.org>
Message-ID: <Pine.LNX.4.44L0.0511011140390.5081-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Nov 2005, Linus Torvalds wrote:

> On Tue, 1 Nov 2005, Alan Stern wrote:
> > 
> > In theory, is it possible for a UHCI controller still to be running, doing 
> > DMA and/or generating interrupts, even if PCI_COMMAND_IO isn't set?
> 
> Yes, it's possible in theory. I guess we could check whether BUS_MASTER is 
> enabled (which _does_ need to be enabled, otherwise it couldn't function), 
> and then enable it.
> 
> > Or is this scenario not worth worrying about?
> 
> It's probably not worth worrying about. After all, this is really just for 
> when something else (firmware) has enabled the USB controller for its own 
> nefarious purposes (ie it also wanted keyboard input), and left it 
> running. If something has left it running by mistake, it won't have 
> disabled IO access either.
> 
> And if it _has_ disabled IO access, we wouldn't know how to enable it at 
> this point. Sure, we could enable the command bit, but this is too early 
> for us to know where in the IO address space it would be safe to enable 
> it.
> 
> But an alternative strategy (which might be very sensible) is to forget 
> about the handoff entirely, and just shut down the bus master flag 
> unconditionally. Just make sure that the eventual driver will reset the 
> controller before it re-enables bus mastering.
> 
> That would seem to be the simplest possible "handoff". The only danger is 
> that I could imagine that there would be controllers out there that get 
> really confused (ie "I'm not going to play nice any more") if we shut them 
> up that way.

Then here's a patch to do that.

Unfortunately, the current setup _does_ enable bus mastering before 
resetting the controller.  That deserves to be fixed in a separate patch.

Alan Stern


Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

Index: usb-2.6/drivers/usb/host/pci-quirks.c
===================================================================
--- usb-2.6.orig/drivers/usb/host/pci-quirks.c
+++ usb-2.6/drivers/usb/host/pci-quirks.c
@@ -138,11 +138,47 @@ reset_needed:
 }
 EXPORT_SYMBOL_GPL(uhci_check_and_reset_hc);
 
+static int __devinit io_type_enabled(struct pci_dev *pdev, unsigned int mask)
+{
+	u16 cmd = 0;
+
+	if (pci_read_config_word(pdev, PCI_COMMAND, &cmd) || !(cmd & mask)) {
+
+		/* The controller is at least partially disabled.
+		 * To be on the safe side, we'll turn off the COMMAND_MASTER
+		 * bit so that it can't do DMA.
+		 */
+		if (cmd & PCI_COMMAND_MASTER)
+			pci_write_config_word(pdev, PCI_COMMAND,
+					cmd & ~PCI_COMMAND_MASTER);
+		cmd = 0;
+	}
+	return cmd;
+}
+
+#define pio_enabled(dev) io_type_enabled(dev, PCI_COMMAND_IO)
+#define mmio_enabled(dev) io_type_enabled(dev, PCI_COMMAND_MEMORY)
+
+static int __devinit mmio_resource_enabled(struct pci_dev *pdev, int idx)
+{
+	return mmio_enabled(pdev) && pci_resource_start(pdev, idx);
+}
+
 static void __devinit quirk_usb_handoff_uhci(struct pci_dev *pdev)
 {
 	unsigned long base = 0;
 	int i;
 
+	if (!pio_enabled(pdev)) {
+
+		/* The controller is at least partially disabled.
+		 * To be safe, we'll disable PIRQD and SMI so that
+		 * it can't generate interrupts.
+		 */
+		pci_write_config_word(pdev, UHCI_USBLEGSUP, 0);
+		return;
+	}
+
 	for (i = 0; i < PCI_ROM_RESOURCE; i++)
 		if ((pci_resource_flags(pdev, i) & IORESOURCE_IO)) {
 			base = pci_resource_start(pdev, i);
@@ -159,6 +195,9 @@ static void __devinit quirk_usb_handoff_
 	int wait_time;
 	u32 control;
 
+	if (!mmio_resource_enabled(pdev, 0))
+		return;
+
 	base = ioremap_nocache(pci_resource_start(pdev, 0),
 				     pci_resource_len(pdev, 0));
 	if (base == NULL) return;
@@ -201,6 +240,9 @@ static void __devinit quirk_usb_disable_
 	u32 hcc_params, val, temp;
 	u8 cap_length;
 
+	if (!mmio_resource_enabled(pdev, 0))
+		return;
+
 	base = ioremap_nocache(pci_resource_start(pdev, 0),
 				pci_resource_len(pdev, 0));
 	if (base == NULL) return;

