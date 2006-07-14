Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161077AbWGNMJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161077AbWGNMJv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 08:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161091AbWGNMJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 08:09:51 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:7308 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1161077AbWGNMJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 08:09:50 -0400
Message-ID: <44B78AFA.80806@gentoo.org>
Date: Fri, 14 Jul 2006 13:15:54 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060603)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: greg@kroah.com, akpm@osdl.org, cw@f00f.org, harmon@ksu.edu,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add SATA device to VIA IRQ quirk fixup list
References: <20060714095233.5678A8B6253@zog.reactivated.net> <44B77B1A.6060502@garzik.org> <44B78294.1070308@gentoo.org> <44B78538.6030909@garzik.org>
In-Reply-To: <44B78538.6030909@garzik.org>
Content-Type: multipart/mixed;
 boundary="------------070609040806050002030108"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070609040806050002030108
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Jeff Garzik wrote:
> Same rationale, but the VIA SATA PCI ID had been submitted before, as 
> well...

OK. So what's the realistic solution?

The best I can think of is something like this (see attachment).

It's not perfect, because if someone inserts a VIA PCI card into a 
VIA-based motherboard, the quirk will also run on that VIA PCI card.
Is there a way we can realistically say "this is an on-board device" vs 
"this is a PCI card"?

This is untested but I'll happily test and work on it further if it 
doesn't get shot down :)
I have only added the southbridges for my own hardware and the one 
listed on the Gentoo bug. I guess there will be more. I also wonder if 
listing the southbridges is the most sensible approach or if other 
devices (e.g. the host bridge at 00:00.0) would be more appropriate?

Daniel

--------------070609040806050002030108
Content-Type: text/x-patch;
 name="via-irq-fixup-sata.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="via-irq-fixup-sata.patch"

[PATCH] Add SATA device to VIA IRQ quirk fixup list

Gentoo users at http://bugs.gentoo.org/138036 reported a 2.6.16.17 regression:
new kernels will not boot their system from their VIA SATA hardware.

The solution is just to add the SATA device to the fixup list.
This should also fix the same problem reported by Scott J. Harmon on LKML.

Signed-off-by: Daniel Drake <dsd@gentoo.org>

Index: linux/drivers/pci/quirks.c
===================================================================
--- linux.orig/drivers/pci/quirks.c
+++ linux/drivers/pci/quirks.c
@@ -648,10 +648,31 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_V
  * Some of the on-chip devices are actually '586 devices' so they are
  * listed here.
  */
+
+static int via_irq_fixup_needed = -1;
+
+/*
+ * As some VIA hardware is available in PCI-card form, we need to restrict
+ * this quirk to VIA PCI hardware built onto VIA-based motherboards only.
+ * This table lists southbridges on motherboards where this quirk needs to
+ * be run.
+ */
+static const struct pci_device_id via_irq_fixup_tbl[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8233A) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8237) },
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
@@ -661,13 +682,7 @@ static void quirk_via_irq(struct pci_dev
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

--------------070609040806050002030108--
