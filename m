Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135493AbRBETHi>; Mon, 5 Feb 2001 14:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135573AbRBETHa>; Mon, 5 Feb 2001 14:07:30 -0500
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:65295 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id <S129044AbRBETHT>; Mon, 5 Feb 2001 14:07:19 -0500
Date: Mon, 5 Feb 2001 19:05:27 +0000
To: linux-kernel@vger.kernel.org
Subject: VIA silent disk corruption - patch
Message-ID: <20010205190527.A314@colonel-panic.com>
Mail-Followup-To: pdh, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: Peter Horton <pdh@colonel-panic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, looks like this fixes it (for me anyways).

Thanks to Mark Hahn and Andre for their help with this problem.

P.


--- linux-2.4.1/arch/i386/kernel/pci-pc.c	Thu Jun 22 15:17:16 2000
+++ linux-2.4.1-bm-fix/arch/i386/kernel/pci-pc.c	Mon Feb  5 18:37:35 2001
@@ -924,6 +924,22 @@
 	pcibios_max_latency = 32;
 }
 
+static void __init pci_fixup_vt8363(struct pci_dev *d)
+{
+	/*
+	 *  VIA VT8363 host bridge has broken feature 'PCI Master Read
+	 *  Caching'. It caches more than is good for it, sometimes
+	 *  serving the bus master with stale data. Some BIOSes enable
+	 *  it by default, so we disable it.
+	 */
+	u8 tmp;
+	pci_read_config_byte(d, 0x70, &tmp);
+	if(tmp & 4) {
+		printk("PCI: Bus master read caching disabled\n");
+		pci_write_config_byte(d, 0x70, tmp & ~4);
+	}
+}
+
 struct pci_fixup pcibios_fixups[] = {
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82451NX,	pci_fixup_i450nx },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82454GX,	pci_fixup_i450gx },
@@ -936,6 +952,7 @@
 	{ PCI_FIXUP_HEADER,	PCI_ANY_ID,		PCI_ANY_ID,			pci_fixup_ide_bases },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_5597,		pci_fixup_latency },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_5598,		pci_fixup_latency },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8363_0,	pci_fixup_vt8363 },
 	{ 0 }
 };
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
