Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbWHTNXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbWHTNXf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 09:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbWHTNXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 09:23:35 -0400
Received: from esafe01.essen.de ([217.78.137.231]:23475 "HELO esafe01.essen.de")
	by vger.kernel.org with SMTP id S1750775AbWHTNXe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 09:23:34 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH RFC] unify via soundcard enable quirks
Message-Id: <20060820132327.B9C91102C03D@mail.goron.de>
Date: Sun, 20 Aug 2006 15:23:27 +0200 (CEST)
From: ari@goron.de (Ari)
X-ESAFE-STATUS: Mail allowed
X-ESAFE-DETAILS: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi List,

The following patch against 2.6.18-rc4 unifies some PCI quirks
that affect re-enabling of onboard sound cards with KT880(pro)
chipset boards.

The current quirks do basically the same for different boards
using the same hardware. The MSI K8T additionally fails to
differentiate enough and applies to any board using that chipset,
including my Asus A8V, ending up in duplicate incorrect patching.
This patch now combines the two quirks in one function, and 
additionally introduces the a check for the correct subvendor id
to avoid quirking the wrong hardware.
The quirk for the Asus board additionally was slightly misplaced
in the middle of some SIS quirks (typical merge bug).

As I don't have access to an MSI-K8T board, someone with that
board should verify that the quirk still applies. I had to
google for the MSI vendor id, and I'm not sure if the hardware
setup of that board correctly matches it.


Signed-off-by: Andreas Arens <ari@goron.de>

--- linux-2.6.18-rc4/drivers/pci/quirks.c.unpatched	2006-08-20 12:22:27.000000000 +0200
+++ linux-2.6.18-rc4/drivers/pci/quirks.c	2006-08-20 12:39:31.000000000 +0200
@@ -912,36 +912,51 @@ static void __init quirk_eisa_bridge(str
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82375,	quirk_eisa_bridge );
 
 /*
- * On the MSI-K8T-Neo2Fir Board, the internal Soundcard is disabled
- * when a PCI-Soundcard is added. The BIOS only gives Options
- * "Disabled" and "AUTO". This Quirk Sets the corresponding
- * Register-Value to enable the Soundcard.
- *
- * FIXME: Presently this quirk will run on anything that has an 8237
- * which isn't correct, we need to check DMI tables or something in
- * order to make sure it only runs on the MSI-K8T-Neo2Fir.  Because it
- * runs everywhere at present we suppress the printk output in most
- * irrelevant cases.
+ * On various boards using the VIA VT8287 ISA bridge the BIOS disables
+ * the onboard AC97 audio controller and MC97 modem controller when a
+ * second PCI soundcard is present. This patch enables them.
  */
-static void __init k8t_sound_hostbridge(struct pci_dev *dev)
+static void __init via_sound_hostbridge(struct pci_dev *dev)
 {
-	unsigned char val;
-
-	pci_read_config_byte(dev, 0x50, &val);
-	if (val == 0x88 || val == 0xc8) {
-		/* Assume it's probably a MSI-K8T-Neo2Fir */
-		printk(KERN_INFO "PCI: MSI-K8T-Neo2Fir, attempting to turn soundcard ON\n");
-		pci_write_config_byte(dev, 0x50, val & (~0x40));
+	u8 val;
 
-		/* Verify the Change for Status output */
+	/*
+	 * ASUS A8V and A8V Deluxe boards
+	 */
+	if (dev->subsystem_vendor == PCI_VENDOR_ID_ASUSTEK) {
 		pci_read_config_byte(dev, 0x50, &val);
-		if (val & 0x40)
-			printk(KERN_INFO "PCI: MSI-K8T-Neo2Fir, soundcard still off\n");
-		else
-			printk(KERN_INFO "PCI: MSI-K8T-Neo2Fir, soundcard on\n");
+		if (val & 0xc0) {
+			pci_write_config_byte(dev, 0x50, val & (~0xc0));
+			pci_read_config_byte(dev, 0x50, &val);
+			if (val & 0xc0)
+				printk(KERN_INFO "PCI: onboard AC97/MC97 devices continue to "
+						"play 'hide and seek'! 0x%x\n", val);
+			else
+				printk(KERN_INFO "PCI: enabled onboard AC97/MC97 devices\n");
+		}
+		return;
+	}
+	/*
+	 * MSI-K8T-Neo2Fir Board
+	 * The BIOS only gives Options "Disabled" and "AUTO".
+	 */
+	if (dev->subsystem_vendor == PCI_VENDOR_ID_MSI) {
+		pci_read_config_byte(dev, 0x50, &val);
+		if (val == 0x88 || val == 0xc8) {
+			/* Assume it's probably a MSI-K8T-Neo2Fir */
+			printk(KERN_INFO "PCI: MSI-K8T-Neo2Fir, attempting to turn soundcard ON\n");
+			pci_write_config_byte(dev, 0x50, val & (~0x40));
+
+			/* Verify the Change for Status output */
+			pci_read_config_byte(dev, 0x50, &val);
+			if (val & 0x40)
+				printk(KERN_INFO "PCI: MSI-K8T-Neo2Fir, soundcard still off\n");
+			else
+				printk(KERN_INFO "PCI: MSI-K8T-Neo2Fir, soundcard on\n");
+		}
 	}
 }
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8237, k8t_sound_hostbridge);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8237, via_sound_hostbridge);
 
 #ifndef CONFIG_ACPI_SLEEP
 /*
@@ -1172,37 +1187,6 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_S
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_735,		quirk_sis_96x_compatible );
 
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_503,		quirk_sis_503 );
-/*
- * On ASUS A8V and A8V Deluxe boards, the onboard AC97 audio controller
- * and MC97 modem controller are disabled when a second PCI soundcard is
- * present. This patch, tweaking the VT8237 ISA bridge, enables them.
- * -- bjd
- */
-static void __init asus_hides_ac97_lpc(struct pci_dev *dev)
-{
-	u8 val;
-	int asus_hides_ac97 = 0;
-
-	if (likely(dev->subsystem_vendor == PCI_VENDOR_ID_ASUSTEK)) {
-		if (dev->device == PCI_DEVICE_ID_VIA_8237)
-			asus_hides_ac97 = 1;
-	}
-
-	if (!asus_hides_ac97)
-		return;
-
-	pci_read_config_byte(dev, 0x50, &val);
-	if (val & 0xc0) {
-		pci_write_config_byte(dev, 0x50, val & (~0xc0));
-		pci_read_config_byte(dev, 0x50, &val);
-		if (val & 0xc0)
-			printk(KERN_INFO "PCI: onboard AC97/MC97 devices continue to play 'hide and seek'! 0x%x\n", val);
-		else
-			printk(KERN_INFO "PCI: enabled onboard AC97/MC97 devices\n");
-	}
-}
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237, asus_hides_ac97_lpc );
-
 
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_961,		quirk_sis_96x_smbus );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_962,		quirk_sis_96x_smbus );
--- linux-2.6.18-rc4/include/linux/pci_ids.h.unpatched	2006-08-20 12:36:51.000000000 +0200
+++ linux-2.6.18-rc4/include/linux/pci_ids.h	2006-08-20 12:38:31.000000000 +0200
@@ -1858,6 +1858,8 @@
 
 #define PCI_VENDOR_ID_SAMSUNG		0x144d
 
+#define PCI_VENDOR_ID_MSI		0x1462
+
 #define PCI_VENDOR_ID_MYRICOM		0x14c1
 
 #define PCI_VENDOR_ID_TITAN		0x14D2
