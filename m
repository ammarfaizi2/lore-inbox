Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032202AbWLGNY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032202AbWLGNY2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 08:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032206AbWLGNY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 08:24:28 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:1708 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1032202AbWLGNYZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 08:24:25 -0500
Date: Thu, 7 Dec 2006 14:24:30 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Daniel Ritz <daniel.ritz@gmx.ch>, Daniel Drake <dsd@gentoo.org>,
       Jean Delvare <khali@linux-fr.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Linus Torvalds <torvalds@osdl.org>, Brice Goglin <brice@myri.com>,
       "John W. Linville" <linville@tuxdriver.com>,
       Bauke Jan Douma <bjdouma@xs4all.nl>,
       Tomasz Koprowski <tomek@koprowski.org>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: RFC: PCI quirks update for 2.6.16
Message-ID: <20061207132430.GF8963@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While checking how to fix the VIA quirk regressions for several users 
introduced into -stable in 2.6.16.17, I started looking through all 
drivers/pci/quirks.c updates up to both -stable and 2.6.19.

Below is the selection the seemed good and safe.

Any comments on whether it's really good or whether I should change 
anything?

TIA
Adrian


Bauke Jan Douma (1):
      PCI: quirk for asus a8v and a8v delux motherboards

Bjorn Helgaas (1):
      PCI: quirk to disable e100 interrupt if RESET failed to

Brice Goglin (1):
      PCI: nVidia quirk to make AER PCI-E extended capability visible

Daniel Drake (1):
      PCI: VIA IRQ quirk behaviour change

Daniel Ritz (2):
      PCI: fix ICH6 quirks
      PCI: add ICH7/8 ACPI/GPIO io resource quirks

Jean Delvare (1):
      PCI: Unhide the SMBus on Asus PU-DLS

John W. Linville (1):
      pci_ids.h: correct naming of 1022:7450 (AMD 8131 Bridge)

Linus Torvalds (1):
      Add PIIX4 APCI quirk for the 440MX chipset too

Tomasz Koprowski (1):
      PCI: SMBus unhide on HP Compaq nx6110


 drivers/pci/quirks.c    |  172 +++++++++++++++++++++++++++++++++++++---
 include/linux/pci_ids.h |    5 -
 2 files changed, 167 insertions(+), 10 deletions(-)


diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 381f36b..5640be5 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -390,6 +390,7 @@ static void __devinit quirk_piix4_acpi(struct pci_dev *dev)
 	piix4_io_quirk(dev, "PIIX4 devres J", 0x7c, 1 << 20);
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371AB_3,	quirk_piix4_acpi );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82443MX_3,	quirk_piix4_acpi );
 
 /*
  * ICH4, ICH4-M, ICH5, ICH5-M ACPI: Three IO regions pointed to by longwords at
@@ -427,7 +428,14 @@ static void __devinit quirk_ich6_lpc_acpi(struct pci_dev *dev)
 	pci_read_config_dword(dev, 0x48, &region);
 	quirk_io_region(dev, region, 64, PCI_BRIDGE_RESOURCES+1, "ICH6 GPIO");
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_0, quirk_ich6_lpc_acpi );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH6_1, quirk_ich6_lpc_acpi );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH7_0, quirk_ich6_lpc_acpi );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH7_1, quirk_ich6_lpc_acpi );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH7_31, quirk_ich6_lpc_acpi );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH8_0, quirk_ich6_lpc_acpi );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH8_2, quirk_ich6_lpc_acpi );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ICH8_3, quirk_ich6_lpc_acpi );
 
 /*
  * VIA ACPI: One IO region pointed to by longword at
@@ -589,7 +597,7 @@ static void __init quirk_amd_8131_ioapic(struct pci_dev *dev)
                 pci_write_config_byte( dev, AMD8131_MISC, tmp);
         }
 } 
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8131_APIC,         quirk_amd_8131_ioapic ); 
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8131_BRIDGE, quirk_amd_8131_ioapic);
 
 static void __init quirk_svw_msi(struct pci_dev *dev)
 {
@@ -635,11 +643,43 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_4,	quirk_vi
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
 
-	new_irq = dev->irq & 0xf;
+	if (via_irq_fixup_needed == -1)
+		via_irq_fixup_needed = pci_dev_present(via_irq_fixup_tbl);
+
+	if (!via_irq_fixup_needed)
+		return;
+
+	new_irq = dev->irq;
+
+	/* Don't quirk interrupts outside the legacy IRQ range */
+	if (!new_irq || new_irq > 15)
+		return;
+
 	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
 	if (new_irq != irq) {
 		printk(KERN_INFO "PCI: VIA IRQ fixup for %s, from %d to %d\n",
@@ -648,13 +688,7 @@ static void quirk_via_irq(struct pci_dev *dev)
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
@@ -917,6 +951,11 @@ static void __init asus_hides_smbus_hostbridge(struct pci_dev *dev)
 			case 0x8070: /* P4G8X Deluxe */
 				asus_hides_smbus = 1;
 			}
+		if (dev->device == PCI_DEVICE_ID_INTEL_E7501_MCH)
+			switch (dev->subsystem_device) {
+			case 0x80c9: /* PU-DLS */
+				asus_hides_smbus = 1;
+			}
 		if (dev->device == PCI_DEVICE_ID_INTEL_82855GM_HB)
 			switch (dev->subsystem_device) {
 			case 0x1751: /* M2N notebook */
@@ -948,6 +987,12 @@ static void __init asus_hides_smbus_hostbridge(struct pci_dev *dev)
 			case 0x12bd: /* HP D530 */
 				asus_hides_smbus = 1;
 			}
+		if (dev->device == PCI_DEVICE_ID_INTEL_82915GM_HB) {
+			switch (dev->subsystem_device) {
+			case 0x099c: /* HP Compaq nx6110 */
+				asus_hides_smbus = 1;
+			}
+		}
 	} else if (unlikely(dev->subsystem_vendor == PCI_VENDOR_ID_TOSHIBA)) {
 		if (dev->device == PCI_DEVICE_ID_INTEL_82855GM_HB)
 			switch(dev->subsystem_device) {
@@ -978,6 +1023,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82845G_HB,	asu
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82850_HB,	asus_hides_smbus_hostbridge );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82865_HB,	asus_hides_smbus_hostbridge );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_7205_0,	asus_hides_smbus_hostbridge );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7501_MCH,	asus_hides_smbus_hostbridge );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82855PM_HB,	asus_hides_smbus_hostbridge );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82855GM_HB,	asus_hides_smbus_hostbridge );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82915GM_HB, asus_hides_smbus_hostbridge );
@@ -1001,6 +1047,7 @@ static void __init asus_hides_smbus_lpc(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_0,	asus_hides_smbus_lpc );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801BA_0,	asus_hides_smbus_lpc );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801CA_0,	asus_hides_smbus_lpc );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801CA_12,	asus_hides_smbus_lpc );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_12,	asus_hides_smbus_lpc );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801EB_0,	asus_hides_smbus_lpc );
@@ -1084,6 +1131,37 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_651,		quirk_sis_96x_
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_735,		quirk_sis_96x_compatible );
 
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_503,		quirk_sis_503 );
+/*
+ * On ASUS A8V and A8V Deluxe boards, the onboard AC97 audio controller
+ * and MC97 modem controller are disabled when a second PCI soundcard is
+ * present. This patch, tweaking the VT8237 ISA bridge, enables them.
+ * -- bjd
+ */
+static void __init asus_hides_ac97_lpc(struct pci_dev *dev)
+{
+	u8 val;
+	int asus_hides_ac97 = 0;
+
+	if (likely(dev->subsystem_vendor == PCI_VENDOR_ID_ASUSTEK)) {
+		if (dev->device == PCI_DEVICE_ID_VIA_8237)
+			asus_hides_ac97 = 1;
+	}
+
+	if (!asus_hides_ac97)
+		return;
+
+	pci_read_config_byte(dev, 0x50, &val);
+	if (val & 0xc0) {
+		pci_write_config_byte(dev, 0x50, val & (~0xc0));
+		pci_read_config_byte(dev, 0x50, &val);
+		if (val & 0xc0)
+			printk(KERN_INFO "PCI: onboard AC97/MC97 devices continue to play 'hide and seek'! 0x%x\n", val);
+		else
+			printk(KERN_INFO "PCI: enabled onboard AC97/MC97 devices\n");
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237, asus_hides_ac97_lpc );
+
 
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_961,		quirk_sis_96x_smbus );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_962,		quirk_sis_96x_smbus );
@@ -1292,6 +1370,63 @@ static void __devinit quirk_netmos(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NETMOS, PCI_ANY_ID, quirk_netmos);
 
+static void __devinit quirk_e100_interrupt(struct pci_dev *dev)
+{
+	u16 command;
+	u32 bar;
+	u8 __iomem *csr;
+	u8 cmd_hi;
+
+	switch (dev->device) {
+	/* PCI IDs taken from drivers/net/e100.c */
+	case 0x1029:
+	case 0x1030 ... 0x1034:
+	case 0x1038 ... 0x103E:
+	case 0x1050 ... 0x1057:
+	case 0x1059:
+	case 0x1064 ... 0x106B:
+	case 0x1091 ... 0x1095:
+	case 0x1209:
+	case 0x1229:
+	case 0x2449:
+	case 0x2459:
+	case 0x245D:
+	case 0x27DC:
+		break;
+	default:
+		return;
+	}
+
+	/*
+	 * Some firmware hands off the e100 with interrupts enabled,
+	 * which can cause a flood of interrupts if packets are
+	 * received before the driver attaches to the device.  So
+	 * disable all e100 interrupts here.  The driver will
+	 * re-enable them when it's ready.
+	 */
+	pci_read_config_word(dev, PCI_COMMAND, &command);
+	pci_read_config_dword(dev, PCI_BASE_ADDRESS_0, &bar);
+
+	if (!(command & PCI_COMMAND_MEMORY) || !bar)
+		return;
+
+	csr = ioremap(bar, 8);
+	if (!csr) {
+		printk(KERN_WARNING "PCI: Can't map %s e100 registers\n",
+			pci_name(dev));
+		return;
+	}
+
+	cmd_hi = readb(csr + 3);
+	if (cmd_hi == 0) {
+		printk(KERN_WARNING "PCI: Firmware left %s e100 interrupts "
+			"enabled, disabling\n", pci_name(dev));
+		writeb(1, csr + 3);
+	}
+
+	iounmap(csr);
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, PCI_ANY_ID, quirk_e100_interrupt);
 
 static void __devinit fixup_rev1_53c810(struct pci_dev* dev)
 {
@@ -1387,6 +1522,25 @@ static void __devinit quirk_p64h2_1k_io(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	0x1460,		quirk_p64h2_1k_io);
 
+/* Under some circumstances, AER is not linked with extended capabilities.
+ * Force it to be linked by setting the corresponding control bit in the
+ * config space.
+ */
+static void __devinit quirk_nvidia_ck804_pcie_aer_ext_cap(struct pci_dev *dev)
+{
+	uint8_t b;
+	if (pci_read_config_byte(dev, 0xf41, &b) == 0) {
+		if (!(b & 0x20)) {
+			pci_write_config_byte(dev, 0xf41, b | 0x20);
+			printk(KERN_INFO
+			       "PCI: Linking AER extended capability on %s\n",
+			       pci_name(dev));
+		}
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA,  PCI_DEVICE_ID_NVIDIA_CK804_PCIE,
+			quirk_nvidia_ck804_pcie_aer_ext_cap);
+
 EXPORT_SYMBOL(pcie_mch_quirk);
 #ifdef CONFIG_HOTPLUG
 EXPORT_SYMBOL(pci_fixup_device);
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 77ccd6e..386c6a7 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -496,7 +496,8 @@
 #define PCI_DEVICE_ID_AMD_8111_SMBUS	0x746b
 #define PCI_DEVICE_ID_AMD_8111_AUDIO	0x746d
 #define PCI_DEVICE_ID_AMD_8151_0	0x7454
-#define PCI_DEVICE_ID_AMD_8131_APIC     0x7450
+#define PCI_DEVICE_ID_AMD_8131_BRIDGE	0x7450
+#define PCI_DEVICE_ID_AMD_8131_APIC	0x7451
 #define PCI_DEVICE_ID_AMD_CS5536_ISA    0x2090
 #define PCI_DEVICE_ID_AMD_CS5536_FLASH  0x2091
 #define PCI_DEVICE_ID_AMD_CS5536_AUDIO  0x2093
@@ -1007,6 +1008,7 @@
 #define PCI_DEVICE_ID_NVIDIA_NVENET_8		0x0056
 #define PCI_DEVICE_ID_NVIDIA_NVENET_9		0x0057
 #define PCI_DEVICE_ID_NVIDIA_CK804_AUDIO	0x0059
+#define PCI_DEVICE_ID_NVIDIA_CK804_PCIE		0x005d
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2_SMBUS	0x0064
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE	0x0065
 #define PCI_DEVICE_ID_NVIDIA_NVENET_2		0x0066
@@ -2081,6 +2083,7 @@
 #define PCI_DEVICE_ID_INTEL_82820_UP_HB	0x2501
 #define PCI_DEVICE_ID_INTEL_82850_HB	0x2530
 #define PCI_DEVICE_ID_INTEL_82860_HB	0x2531
+#define PCI_DEVICE_ID_INTEL_E7501_MCH	0x254c
 #define PCI_DEVICE_ID_INTEL_82845G_HB	0x2560
 #define PCI_DEVICE_ID_INTEL_82845G_IG	0x2562
 #define PCI_DEVICE_ID_INTEL_82865_HB	0x2570

