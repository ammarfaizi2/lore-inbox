Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965001AbVKAEEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965001AbVKAEEE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 23:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965010AbVKAEEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 23:04:04 -0500
Received: from ozlabs.org ([203.10.76.45]:3976 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965001AbVKAEEC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 23:04:02 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17254.59690.713323.294726@cargo.ozlabs.ibm.com>
Date: Tue, 1 Nov 2005 15:03:54 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
CC: David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>,
       Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] Don't touch USB controllers with MMIO disabled in quirks
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recently a quirk was added which attempts to do usb-handoff on all USB
host controllers on all platforms.  This is causing machine checks on
various machines such as my G4 powerbook, because the quirk code
attempts to do MMIO to the device without calling pci_enable_device,
or even checking that MMIO is enabled.

I still think that a FIXUP_HEADER header is the wrong place to be
doing this sort of thing, and that code that touches a device without
doing pci_enable_device is just asking for trouble; however, in order
to get my machine to be able to boot, this patch adds a check that
MMIO is enabled for the device, and if it isn't, leaves the device
alone.  With this patch my powerbook will boot.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---

diff -urN powerpc-merge/drivers/usb/host/pci-quirks.c merge-hack/drivers/usb/host/pci-quirks.c
--- powerpc-merge/drivers/usb/host/pci-quirks.c	2005-10-31 13:15:27.000000000 +1100
+++ merge-hack/drivers/usb/host/pci-quirks.c	2005-11-01 14:47:47.000000000 +1100
@@ -286,6 +286,11 @@
 
 static void __devinit quirk_usb_early_handoff(struct pci_dev *pdev)
 {
+	u16 cmd;
+
+	if (pci_read_config_word(pdev, PCI_COMMAND, &cmd) ||
+	    (cmd & PCI_COMMAND_MEMORY) == 0)
+		return;
 	if (pdev->class == PCI_CLASS_SERIAL_USB_UHCI)
 		quirk_usb_handoff_uhci(pdev);
 	else if (pdev->class == PCI_CLASS_SERIAL_USB_OHCI)
