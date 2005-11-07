Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbVKGVIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbVKGVIv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 16:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbVKGVIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 16:08:51 -0500
Received: from mirage.confident-solutions.de ([80.190.233.175]:40363 "EHLO
	mirage.confident-solutions.de") by vger.kernel.org with ESMTP
	id S932349AbVKGVIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 16:08:50 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] SMBus for Toshiba M40, kernel 2.6.14
From: webmaster@toshsoft.de
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
X-MimeOLE: Produced by Confixx WebMail
X-Mailer: Confixx WebMail (like SquirrelMail)
Cc: alan@lxorguk.ukuu.org.uk
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Message-Id: <20051107210849.1418813F85D@mirage.confident-solutions.de>
Date: Mon,  7 Nov 2005 22:08:49 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for my previous miss-posting. Mail-App didnt work as expected :)
This Patch patches quirks.c to be able to show hidden SMBus devices
for Notebooks with the ICH6 Chipset. Only Notebook i could integrate
and test so far is the Toshiba M40/M45 It applies to
vanilla-sources-2.6.14
Could you please send me a Mail if it was helpful and will be
integrated?

Thanks and have Fun

Oliver


--- /usr/src/linux-2.6.14/drivers/pci/quirks.c	2005-10-30
19:47:11.000000000 +0100
+++ /usr/src/linux/drivers/pci/quirks.c	2005-11-07 17:39:38.000000000
+0100
@@ -945,6 +945,11 @@
 			case 0x0001: /* Toshiba Tecra M2 */
 				asus_hides_smbus = 1;
 			}
+		if (dev->device == PCI_DEVICE_ID_INTEL_82915GM_HB)
+			switch(dev->subsystem_device) {
+			case 0xFF10: /* Toshiba Satellite M40 */
+				asus_hides_smbus = 1;
+			}
        } else if (unlikely(dev->subsystem_vendor ==
PCI_VENDOR_ID_SAMSUNG)) {
                if (dev->device ==  PCI_DEVICE_ID_INTEL_82855PM_HB)
                        switch(dev->subsystem_device) {
@@ -966,6 +971,7 @@
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_7205_0,	asus_hides_smbus_hostbridge
);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82855PM_HB,	asus_hides_smbus_hostbridge
);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82855GM_HB,	asus_hides_smbus_hostbridge
);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82915GM_HB,	asus_hides_smbus_hostbridge
);

 static void __init asus_hides_smbus_lpc(struct pci_dev *dev)
 {
@@ -984,12 +990,33 @@
 			printk(KERN_INFO "PCI: Enabled i801 SMBus device\n");
 	}
 }
+
+static void __init asus_hides_smbus_ich6(struct pci_dev *dev)
+{
+	u32 val, rcba;
+	void __iomem *base;
+
+	if (likely(!asus_hides_smbus))
+		return;
+
+	pci_read_config_dword(dev, 0xF0, &rcba);
+	base = ioremap_nocache(rcba & 0xFFFFC000, 0x4000);
+	if (base == NULL)
+		return;
+	val = readl(base + 0x3418);
+	writel(val & 0xFFFFFFF7, base + 0x3418);
+	iounmap(base);
+	printk(KERN_INFO "PCI: Enabled ICH6 SMBus device\n");
+}
+
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_0,	asus_hides_smbus_lpc
);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801BA_0,	asus_hides_smbus_lpc
);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801CA_12,	asus_hides_smbus_lpc
);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_12,	asus_hides_smbus_lpc
);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801EB_0,	asus_hides_smbus_lpc
);

+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1,	asus_hides_smbus_ich6
);
+
 /*
  * SiS 96x south bridge: BIOS typically hides SMBus device...
  */


