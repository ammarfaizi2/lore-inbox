Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262010AbVBAM5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262010AbVBAM5L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 07:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbVBAM5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 07:57:11 -0500
Received: from guri.is.scarlet.be ([193.74.71.22]:49070 "EHLO
	guri.is.scarlet.be") by vger.kernel.org with ESMTP id S262010AbVBAM5D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 07:57:03 -0500
Date: Tue, 1 Feb 2005 13:56:56 +0100
To: linux-kernel@vger.kernel.org
Subject: M7101 unhiding patch
Message-ID: <20050201125656.GD627@frans.deprez-aerts.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="f0KYrhQ4vYSV2aJu"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: maartendeprez@scarlet.be
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--f0KYrhQ4vYSV2aJu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Can this patch to drivers/pci/quirks.c be incorporated into the kernel? It fixes a bug in some BIOSes that hide the M7101 PMU and SMBUS device and is needed for some boards to use the i2c-ali15x3 driver. lm_sensors includes a module that makes that device visible. i got this patch from the kernel mailing list and adapted it to the kernel coding style.

Maarten Deprez

--f0KYrhQ4vYSV2aJu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="m7101.patch"

--- linux-2.6.11-rc2-mm1/drivers/pci/quirks.c.orig	2005-01-28 10:55:20.524801664 +0100
+++ linux-2.6.11-rc2-mm1/drivers/pci/quirks.c	2005-01-28 11:24:34.626137728 +0100
@@ -281,6 +281,55 @@
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL,	PCI_DEVICE_ID_AL_M7101,		quirk_ali7101_acpi );
 
 /*
+ * ALi 1533 fixup to enable the M7101 SMBus Controller
+ *          ported from prog/hotplug of the lm_sensors
+ *          package
+ */
+static void __devinit quirk_ali1533_smbus(struct pci_dev *dev)
+{
+	u8 val = 0;
+	struct pci_dev *m7101;
+
+	m7101 = pci_get_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M7101, NULL);
+
+	if (m7101)
+		return;
+
+	/* enable device */
+
+	pci_read_config_byte(dev, 0x5F, &val);
+
+	if (val & 0x04) {
+		pci_write_config_byte(dev, 0x5F, val & ~0x04);
+		pci_read_config_byte(dev, 0x5F, &val);
+
+		if (val & 0x4) {
+			printk(KERN_INFO "PCI: Failed to enable M7101 SMBus Controller\n");
+			return;
+		}
+	}
+
+	m7101 = pci_scan_single_device(dev->bus, 0x18);
+
+	/* unlock registers */
+
+	if (pci_read_config_byte(m7101, 0x5B, &val)) {
+		printk(KERN_INFO "PCI: Failed to enable M7101 SMBus Controller\n");
+		return;
+	}
+
+	if (val & 0x06) {
+		if (pci_write_config_byte(m7101, 0x5B, val & ~0x06)) {
+			printk(KERN_INFO "PCI: Failed to enable M7101 SMBus Controller\n");
+			return;
+		}
+	}
+
+	printk(KERN_INFO "PCI: Enabled M7101 SMBus Controller\n");
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL,	PCI_DEVICE_ID_AL_M1533,		quirk_ali1533_smbus );
+
+/*
  * PIIX4 ACPI: Two IO regions pointed to by longwords at
  *	0x40 (64 bytes of ACPI registers)
  *	0x90 (32 bytes of SMB registers)

--f0KYrhQ4vYSV2aJu--
