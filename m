Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964801AbVKAEet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbVKAEet (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 23:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbVKAEet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 23:34:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19144 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932538AbVKAEes (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 23:34:48 -0500
Date: Mon, 31 Oct 2005 20:33:53 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Mackerras <paulus@samba.org>
cc: akpm@osdl.org, David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>,
       Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Don't touch USB controllers with MMIO disabled in quirks
In-Reply-To: <17254.59690.713323.294726@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.64.0510312026300.27915@g5.osdl.org>
References: <17254.59690.713323.294726@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 1 Nov 2005, Paul Mackerras wrote:
> 
> I still think that a FIXUP_HEADER header is the wrong place to be
> doing this sort of thing, and that code that touches a device without
> doing pci_enable_device is just asking for trouble; however, in order
> to get my machine to be able to boot, this patch adds a check that
> MMIO is enabled for the device, and if it isn't, leaves the device
> alone.  With this patch my powerbook will boot.

Well, this can't be right, because depending on which controller type it 
is, the handoff code uses PIO, not MMIO. In fact, a uhci controller 
wouldn't necessarily ever have PCI_COMMAND_MEMORY set afaik, since it 
doesn't even _have_ MMIO.

Would something like the appended work instead?

		Linus

---
diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index b7fd3f6..b1aa350 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -138,11 +138,23 @@ reset_needed:
 }
 EXPORT_SYMBOL_GPL(uhci_check_and_reset_hc);
 
+static inline int io_type_enabled(struct pci_dev *pdev, unsigned int mask)
+{
+	u16 cmd;
+	return !pci_read_config_word(pdev, PCI_COMMAND, &cmd) && (cmd & mask);
+}
+
+#define pio_enabled(dev) io_type_enabled(dev, PCI_COMMAND_IO)
+#define mmio_enabled(dev) io_type_enabled(dev, PCI_COMMAND_MEMORY)
+
 static void __devinit quirk_usb_handoff_uhci(struct pci_dev *pdev)
 {
 	unsigned long base = 0;
 	int i;
 
+	if (!pio_enabled(pdev))
+		return;
+
 	for (i = 0; i < PCI_ROM_RESOURCE; i++)
 		if ((pci_resource_flags(pdev, i) & IORESOURCE_IO)) {
 			base = pci_resource_start(pdev, i);
@@ -153,12 +165,20 @@ static void __devinit quirk_usb_handoff_
 		uhci_check_and_reset_hc(pdev, base);
 }
 
+static int __devinit mmio_resource_enabled(struct pci_dev *pdev, int idx)
+{
+	return pci_resource_start(pdev, idx) && mmio_enabled(pdev);
+}
+
 static void __devinit quirk_usb_handoff_ohci(struct pci_dev *pdev)
 {
 	void __iomem *base;
 	int wait_time;
 	u32 control;
 
+	if (!mmio_resource_enabled(pdev, 0))
+		return;
+
 	base = ioremap_nocache(pci_resource_start(pdev, 0),
 				     pci_resource_len(pdev, 0));
 	if (base == NULL) return;
@@ -201,6 +221,9 @@ static void __devinit quirk_usb_disable_
 	u32 hcc_params, val, temp;
 	u8 cap_length;
 
+	if (!mmio_resource_enabled(pdev, 0))
+		return;
+
 	base = ioremap_nocache(pci_resource_start(pdev, 0),
 				pci_resource_len(pdev, 0));
 	if (base == NULL) return;
