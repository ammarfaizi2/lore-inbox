Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263834AbTEODmb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 23:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263788AbTEODUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 23:20:04 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:17132 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263792AbTEODSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 23:18:23 -0400
Date: Thu, 15 May 2003 04:31:10 +0100
Message-Id: <200305150331.h4F3VAqc000671@deviant.impure.org.uk>
To: torvalds@transmeta.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: ASUS P4B SMBus quirks.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Dominik Brodowski, comments says it all..

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/pci/quirks.c linux-2.5/drivers/pci/quirks.c
--- bk-linus/drivers/pci/quirks.c	2003-04-10 06:01:22.000000000 +0100
+++ linux-2.5/drivers/pci/quirks.c	2003-04-22 17:38:20.000000000 +0100
@@ -647,6 +647,56 @@ static void __init quirk_eisa_bridge(str
 }
 
 /*
+ * On ASUS P4B boards, the SMBus PCI Device within the ICH2/4 southbridge
+ * is not activated. The myth is that Asus said that they do not want the
+ * users to be irritated by just another PCI Device in the Win98 device
+ * manager. (see the file prog/hotplug/README.p4b in the lm_sensors 
+ * package 2.7.0 for details)
+ *
+ * The SMBus PCI Device can be activated by setting a bit in the ICH LPC 
+ * bridge. Unfortunately, this device has no subvendor/subdevice ID. So it 
+ * becomes necessary to do this tweak in two steps -- I've chosen the Host
+ * bridge as trigger.
+ */
+
+static int __initdata asus_hides_smbus = 0;
+
+static void __init asus_hides_smbus_hostbridge(struct pci_dev *dev)
+{
+	if (likely(dev->subsystem_vendor != PCI_VENDOR_ID_ASUSTEK))
+		return;
+
+	if ((dev->device == PCI_DEVICE_ID_INTEL_82845_HB) && 
+	    (dev->subsystem_device == 0x8088)) /* P4B533 */
+		asus_hides_smbus = 1;
+	if ((dev->device == PCI_DEVICE_ID_INTEL_82845G_HB) &&
+	    (dev->subsystem_device == 0x80b2)) /* P4PE */
+		asus_hides_smbus = 1;
+	if ((dev->device == PCI_DEVICE_ID_INTEL_82850_HB) &&
+	    (dev->subsystem_device == 0x8030)) /* P4T533 */
+		asus_hides_smbus = 1;
+	return;
+}
+
+static void __init asus_hides_smbus_lpc(struct pci_dev *dev)
+{
+	u16 val;
+	
+	if (likely(!asus_hides_smbus))
+		return;
+
+	pci_read_config_word(dev, 0xF2, &val);
+	if (val & 0x8) {
+		pci_write_config_word(dev, 0xF2, val & (~0x8));
+		pci_read_config_word(dev, 0xF2, &val);
+		if(val & 0x8)
+			printk(KERN_INFO "PCI: i801 SMBus device continues to play 'hide and seek'! 0x%x\n", val);
+		else
+			printk(KERN_INFO "PCI: Enabled i801 SMBus device\n");
+	}
+}
+
+/*
  *  The main table of quirks.
  */
 
@@ -725,6 +775,15 @@ static struct pci_fixup pci_fixups[] __d
 	
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82375,	quirk_eisa_bridge },
 
+	/*
+	 * on Asus P4B boards, the i801SMBus device is disabled at startup.
+	 */
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82845_HB,	asus_hides_smbus_hostbridge },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82845G_HB,	asus_hides_smbus_hostbridge },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82850_HB,	asus_hides_smbus_hostbridge },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_0,	asus_hides_smbus_lpc },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801BA_0,	asus_hides_smbus_lpc },
+
 	{ 0 }
 };
 
