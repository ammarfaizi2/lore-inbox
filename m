Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932517AbWGSGd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517AbWGSGd5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 02:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbWGSGd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 02:33:57 -0400
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:31111 "HELO
	smtp107.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932517AbWGSGd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 02:33:56 -0400
Date: Tue, 18 Jul 2006 23:33:44 -0700
From: Chris Wedgwood <cw@f00f.org>
To: ocilent1 <ocilent1@gmail.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Con Kolivas <kernel@kolivas.org>,
       ck@vds.kolivas.org, Hugo Vanwoerkom <rociobarroso@att.net.mx>,
       linux list <linux-kernel@vger.kernel.org>, dsd@gentoo.org
Subject: Re: sound skips on 2.6.16.17
Message-ID: <20060719063344.GA1677@tuatara.stupidest.org>
References: <200606181204.29626.ocilent1@gmail.com> <1152289985.4736.86.camel@mindpipe> <20060707170045.GA23243@tuatara.stupidest.org> <200607191403.26174.ocilent1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607191403.26174.ocilent1@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2006 at 02:03:25PM +0800, ocilent1 wrote:

> Hows progress on this bug? Don't suppose we have got an official fix
> for this somewhere on the horizon?

Daniel Drake posted this recently, I've not had a chance to look over
it in detail but it's probably the best tested suggestion thus far.

Does it work for you?



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
