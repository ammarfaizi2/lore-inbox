Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbWIGW3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWIGW3W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 18:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbWIGW3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 18:29:21 -0400
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:29743 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932251AbWIGW3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 18:29:20 -0400
From: Daniel Drake <dsd@gentoo.org>
To: akpm@osdl.org
Cc: torvalds@osdl.org
Cc: sergio@sergiomb.no-ip.org
Cc: jeff@garzik.org
Cc: greg@kroah.com
Cc: cw@f00f.org
Cc: bjorn.helgaas@hp.com
Cc: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Cc: harmon@ksu.edu
Cc: len.brown@intel.com
Cc: vsu@altlinux.ru
Cc: liste@jordet.net
Subject: [PATCH V3] VIA IRQ quirk behaviour change
Message-Id: <20060907223313.1770B7B40A0@zog.reactivated.net>
Date: Thu,  7 Sep 2006 23:33:13 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The most recent VIA IRQ quirk changes have broken various VIA devices for
some users.  We are not able to add these devices to the blacklist as they
are also available in PCI-card form, and running the quirk on these devices
brings us back to square one (running the VIA quirk on non-VIA boards where
the quirk is not needed).

This patch, based on suggestions from Sergey Vlasov, implements a scheme
similar to but more restrictive than the scheme we had in 2.6.16 and
earlier.  It runs the quirk on all VIA hardware, but *only* if a VIA
southbridge was detected on the system.

To further reduce the amount of quirked devices, this patch includes a change
suggested by Linus at http://lkml.org/lkml/2005/9/27/113
This ensures that devices bound to non-legacy IO-APIC interrupt lines are
not quirked. We have made one change to Linus' suggestion: we do a comparison
of ">15" rather than ">=15", as 15 is still in the legacy interrupt range.

There is still a downside to this patch: if the user inserts a VIA PCI card
into a VIA-based motherboard, in some circumstances the quirk will also run on
the VIA PCI card. This corner case is hard to avoid.

Signed-off-by: Daniel Drake <dsd@gentoo.org>
---

Andrew, please replace the current -mm patch with this one. The general idea
is that we *consider* applying the quirk to a lot more devices than we currently
do (more comparable to 2.6.16 and previous), but we add various bail-out
conditions to actually end up applying the quirks much less.

I am fairly confident that we'll still be quirking enough hardware to not
cause any breakage, but we can't be sure until it has seen some testing. This
is compile-tested only.

Index: linux/drivers/pci/quirks.c
===================================================================
--- linux.orig/drivers/pci/quirks.c
+++ linux/drivers/pci/quirks.c
@@ -650,11 +650,43 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_V
  * Some of the on-chip devices are actually '586 devices' so they are
  * listed here.
  */
+
+static int via_irq_fixup_needed = -1;
+
+/*
+ * As some VIA hardware is available in PCI-card form, we need to restrict
+ * this quirk to VIA PCI hardware built onto VIA-based motherboards only.
+ * We try to locate a VIA southbridge before deciding whether the quirk
+ * should be applied.
+ */
+static const struct pci_device_id via_irq_fixup_tbl[] = {
+	{
+		.vendor 	= PCI_VENDOR_ID_VIA,
+		.device		= PCI_ANY_ID,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.class		= PCI_CLASS_BRIDGE_ISA << 8,
+		.class_mask	= 0xffff00,
+	},
+	{ 0, },
+};
+
 static void quirk_via_irq(struct pci_dev *dev)
 {
 	u8 irq, new_irq;
 
-	new_irq = dev->irq & 0xf;
+	if (via_irq_fixup_needed == -1)
+		via_irq_fixup_needed = pci_dev_present(via_irq_fixup_tbl);
+
+	if (!via_irq_fixup_needed)
+		return;
+
+	new_irq = dev->irq;
+
+	/* Don't quirk interrupts outside the legacy IRQ range */
+	if (!new_irq || new_irq > 15)
+		return;
+
 	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
 	if (new_irq != irq) {
 		printk(KERN_INFO "PCI: VIA IRQ fixup for %s, from %d to %d\n",
@@ -663,13 +695,7 @@ static void quirk_via_irq(struct pci_dev
 		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
 	}
 }
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_0, quirk_via_irq);
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1, quirk_via_irq);
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_2, quirk_via_irq);
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_3, quirk_via_irq);
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686, quirk_via_irq);
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_4, quirk_via_irq);
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_5, quirk_via_irq);
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irq);
 
 /*
  * VIA VT82C598 has its device ID settable and many BIOSes
