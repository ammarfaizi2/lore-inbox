Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266948AbTAIRpB>; Thu, 9 Jan 2003 12:45:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266952AbTAIRpB>; Thu, 9 Jan 2003 12:45:01 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:23300 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S266948AbTAIRo7>; Thu, 9 Jan 2003 12:44:59 -0500
Date: Thu, 9 Jan 2003 20:51:17 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Grant Grundler <grundler@cup.hp.com>,
       Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, davidm@hpl.hp.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       greg@kroah.com
Subject: [patch 2.5] 2-pass PCI probing, i386 USB quirk
Message-ID: <20030109205117.C2007@jurassic.park.msu.ru>
References: <1041942820.20658.2.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0301070942440.1913-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0301070942440.1913-100000@home.transmeta.com>; from torvalds@transmeta.com on Tue, Jan 07, 2003 at 09:44:53AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Untested, but it might work. Perhaps this needs to be chip specific (VIA?).

Ivan.

--- 2.5.55/arch/i386/pci/fixup.c	Thu Jan  9 07:04:19 2003
+++ linux/arch/i386/pci/fixup.c	Thu Jan  9 15:10:34 2003
@@ -187,6 +187,24 @@ static void __devinit pci_fixup_transpar
 		dev->transparent = 1;
 }
 
+/*
+ * On certain systems with legacy USB support, the USB controller does
+ * access the system memory while we boot, so disconnecting the host
+ * bridge (along with system memory) from PCI bus during the PCI window
+ * sizing causes immediate crash.
+ * To avoid this, clear the MASTER bit before we start probing the BARs.
+ */
+static void __devinit pci_fixup_usb_dma(struct pci_dev *dev)
+{
+	u16 cmd;
+
+	if ((dev->class >> 8) == PCI_CLASS_SERIAL_USB) {
+		pci_read_config_word(dev, PCI_COMMAND, &cmd);
+		pci_write_config_word(dev, PCI_COMMAND,
+				      cmd & ~PCI_COMMAND_MASTER);
+	}
+}
+
 struct pci_fixup pcibios_fixups[] = {
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82451NX,	pci_fixup_i450nx },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82454GX,	pci_fixup_i450gx },
@@ -205,5 +223,6 @@ struct pci_fixup pcibios_fixups[] = {
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8367_0,	pci_fixup_via_northbridge_bug },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_NCR,	PCI_DEVICE_ID_NCR_53C810,	pci_fixup_ncr53c810 },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_ANY_ID,			pci_fixup_transparent_bridge },
+	{ PCI_FIXUP_EARLY,	PCI_ANY_ID,		PCI_ANY_ID,			pci_fixup_usb_dma },
 	{ 0 }
 };
