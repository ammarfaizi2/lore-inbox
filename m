Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbTICHBf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 03:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261481AbTICHBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 03:01:35 -0400
Received: from sunpizz1.rvs.uni-bielefeld.de ([129.70.123.31]:54762 "EHLO
	mail.rvs.uni-bielefeld.de") by vger.kernel.org with ESMTP
	id S261492AbTICHBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 03:01:11 -0400
To: marcelo@conectiva.com.br
Subject: [PATCH 2.4.23-pre2] PCI quirk for SMBus bridge on Asus P4 boards
Cc: linux-kernel@vger.kernel.org
Message-Id: <20030903070040.40F2F6657@home.holtmann.net>
Date: Wed,  3 Sep 2003 09:00:40 +0200 (CEST)
From: marcel@holtmann.org (Marcel Holtmann)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

this has been in 2.5 for some time now and I think it can be added to 2.4 too.

Regards

Marcel


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.1131, 2003-09-03 08:42:53+02:00, marcel@holtmann.org
  [PATCH] PCI quirk for SMBus bridge on Asus P4 boards
  
  Asus hides the SMBus PCI bridge within the ICH2 or ICH4 southbridge on
  Asus P4 mainboards. The attached patch adds a quirk to re-enable the
  SMBus PCI bridge for P4B533, P4T533, P4PE and P4G8X Deluxe mainboards.
  
  Original patch for 2.5 from Dominik Brodowski <linux@brodo.de>


 drivers/pci/quirks.c    |   66 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci_ids.h |    4 ++
 2 files changed, 70 insertions(+)


diff -Nru a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c	Wed Sep  3 08:54:00 2003
+++ b/drivers/pci/quirks.c	Wed Sep  3 08:54:00 2003
@@ -648,6 +648,62 @@
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
+	if (dev->device == PCI_DEVICE_ID_INTEL_82845_HB)
+		switch(dev->subsystem_device) {
+		case 0x8070: /* P4B */
+	    	case 0x8088: /* P4B533 */
+			asus_hides_smbus = 1;
+		}
+	if ((dev->device == PCI_DEVICE_ID_INTEL_82845G_HB) &&
+	    (dev->subsystem_device == 0x80b2)) /* P4PE */
+		asus_hides_smbus = 1;
+	if ((dev->device == PCI_DEVICE_ID_INTEL_82850_HB) &&
+	    (dev->subsystem_device == 0x8030)) /* P4T533 */
+		asus_hides_smbus = 1;
+	if ((dev->device == PCI_DEVICE_ID_INTEL_7205_0) &&
+	    (dev->subsystem_device == 0x8070)) /* P4G8X Deluxe */
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
 
@@ -724,6 +780,16 @@
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_AMD,      PCI_DEVICE_ID_AMD_8131_APIC, 
 	  quirk_amd_8131_ioapic }, 
 #endif
+
+	/*
+	 * on Asus P4B boards, the i801SMBus device is disabled at startup.
+	 */
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82845_HB,	asus_hides_smbus_hostbridge },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82845G_HB,	asus_hides_smbus_hostbridge },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82850_HB,	asus_hides_smbus_hostbridge },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_7205_0,	asus_hides_smbus_hostbridge },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_0,	asus_hides_smbus_lpc },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801BA_0,	asus_hides_smbus_lpc },
 
 	{ 0 }
 };
diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	Wed Sep  3 08:54:00 2003
+++ b/include/linux/pci_ids.h	Wed Sep  3 08:54:00 2003
@@ -1768,6 +1768,7 @@
 #define PCI_DEVICE_ID_INTEL_82092AA_0	0x1221
 #define PCI_DEVICE_ID_INTEL_82092AA_1	0x1222
 #define PCI_DEVICE_ID_INTEL_7116	0x1223
+#define PCI_DEVICE_ID_INTEL_7205_0	0x255d
 #define PCI_DEVICE_ID_INTEL_82596	0x1226
 #define PCI_DEVICE_ID_INTEL_82865	0x1227
 #define PCI_DEVICE_ID_INTEL_82557	0x1229
@@ -1780,6 +1781,7 @@
 #define PCI_DEVICE_ID_INTEL_82380FB	0x124b
 #define PCI_DEVICE_ID_INTEL_82439	0x1250
 #define PCI_DEVICE_ID_INTEL_80960_RP	0x1960
+#define PCI_DEVICE_ID_INTEL_82845_HB	0x1a30
 #define PCI_DEVICE_ID_INTEL_82371SB_0	0x7000
 #define PCI_DEVICE_ID_INTEL_82371SB_1	0x7010
 #define PCI_DEVICE_ID_INTEL_82371SB_2	0x7020
@@ -1868,6 +1870,8 @@
 #define PCI_DEVICE_ID_INTEL_ESB_11	0x25ac
 #define PCI_DEVICE_ID_INTEL_ESB_12	0x25ad
 #define PCI_DEVICE_ID_INTEL_ESB_13	0x25ae
+#define PCI_DEVICE_ID_INTEL_82850_HB	0x2530
+#define PCI_DEVICE_ID_INTEL_82845G_HB	0x2560
 #define PCI_DEVICE_ID_INTEL_80310	0x530d
 #define PCI_DEVICE_ID_INTEL_82810_MC1	0x7120
 #define PCI_DEVICE_ID_INTEL_82810_IG1	0x7121

===================================================================


This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


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
GO8FU'[19BK^[&%PG%_^$"F,6CD0QWB!VG="^[1K_ ARVQ0[T$@  
 
