Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263179AbTCSVJi>; Wed, 19 Mar 2003 16:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263174AbTCSVJg>; Wed, 19 Mar 2003 16:09:36 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:10399 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S263179AbTCSVIf>; Wed, 19 Mar 2003 16:08:35 -0500
Date: Wed, 19 Mar 2003 22:18:37 +0100
From: Dominik Brodowski <linux@brodo.de>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Subject: [PATCH 2.5] PCI quirk for SMBus bridge on Asus P4 boards
Message-ID: <20030319211837.GA23651@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Asus hides the SMBus PCI bridge within the ICH2 or ICH4 southbridge on
Asus P4B/P4PE mainboards. The attached patch adds a quirk to re-enable the
SMBus PCI bridge for P4B533 and P4PE mainboards.

	   Dominik

diff -ru linux-original/drivers/pci/quirks.c linux/drivers/pci/quirks.c
--- linux-original/drivers/pci/quirks.c	2003-03-19 22:13:57.000000000 +0100
+++ linux/drivers/pci/quirks.c	2003-03-19 22:14:52.000000000 +0100
@@ -647,6 +647,53 @@
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
 
@@ -724,6 +771,13 @@
 	
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82375,	quirk_eisa_bridge },
 
+	/*
+	 * on Asus P4B boards, the i801SMBus device is disabled at startup.
+	 */
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82845_HB,	asus_hides_smbus_hostbridge },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82845G_HB,	asus_hides_smbus_hostbridge },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_0,	asus_hides_smbus_lpc },
+
 	{ 0 }
 };
 
