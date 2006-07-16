Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751586AbWGPODN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbWGPODN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 10:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751584AbWGPODN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 10:03:13 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:23431 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1750786AbWGPODN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 10:03:13 -0400
Message-ID: <44BA48A0.2060008@gentoo.org>
Date: Sun, 16 Jul 2006 15:09:36 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060603)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jeff Garzik <jeff@garzik.org>, greg@kroah.com, cw@f00f.org, harmon@ksu.edu,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add SATA device to VIA IRQ quirk fixup list
References: <20060714095233.5678A8B6253@zog.reactivated.net>	<44B77B1A.6060502@garzik.org>	<44B78294.1070308@gentoo.org>	<44B78538.6030909@garzik.org> <20060714074305.1248b98e.akpm@osdl.org>
In-Reply-To: <20060714074305.1248b98e.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------010103080502000809050901"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010103080502000809050901
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Andrew,

Andrew Morton wrote:
> Guys, this is a really serious failure but afaict nobody is working on it
> and generally nothing at all is happening.
> 
> How do we fix all this?  (Who owns it?)

I'd like to push the attached patch for inclusion. I have tested it on 
my VIA Apollo system, and I hope it is an acceptable compromise while 
nobody has a complete understanding of the issues around this quirk.

I think this belongs to Greg as its a PCI thing, but we should probably 
look for a yay or nay from Jeff as well.

Daniel

--------------010103080502000809050901
Content-Type: text/x-patch;
 name="via-irq-fixup-sata.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="via-irq-fixup-sata.patch"

[PATCH] PCI quirk_via_irq behaviour change

The most recent VIA IRQ quirk changes have broken various VIA devices for
some users. We are not able to add these devices to the blacklist as they
are also available in PCI-card form, and running the quirk on these devices
brings us back to square one (running the VIA quirk on non-VIA boards where
the quirk is not needed).

This patch, based on suggestions from Sergey Vlasov, implements a scheme
similar to but more restrictive than the scheme we had in 2.6.16 and earlier.
It runs the quirk on all VIA hardware, but only if a VIA southbridge was
detected on the system.

There is still a downside to this patch: if the user inserts a VIA PCI card
into a VIA-based motherboard, the quirk will also run on the VIA PCI card.
This corner case is hard to avoid.

However, I think this patch should be applied because:
 - The quirk won't run on Chris's non-VIA system, which was the cause of
   change in the first place.
 - Affected sata_via users will be able to boot again
 - Nobody really has a full understanding of the problem and the issues,
   so I think this "compromise solution" should be acceptable for now.

Signed-off-by: Daniel Drake <dsd@gentoo.org>

Index: linux/drivers/pci/quirks.c
===================================================================
--- linux.orig/drivers/pci/quirks.c
+++ linux/drivers/pci/quirks.c
@@ -648,10 +648,37 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_V
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
 
+	if (via_irq_fixup_needed == -1)
+		via_irq_fixup_needed = pci_dev_present(via_irq_fixup_tbl);
+
+	if (!via_irq_fixup_needed)
+		return;
+
 	new_irq = dev->irq & 0xf;
 	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
 	if (new_irq != irq) {
@@ -661,13 +688,7 @@ static void quirk_via_irq(struct pci_dev
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

--------------010103080502000809050901--
