Return-Path: <linux-kernel-owner+w=401wt.eu-S1425602AbWLHQLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425602AbWLHQLt (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 11:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425600AbWLHQLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 11:11:48 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3304 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1425602AbWLHQLr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 11:11:47 -0500
Date: Fri, 8 Dec 2006 17:11:55 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Daniel Ritz <daniel.ritz@gmx.ch>, Daniel Drake <dsd@gentoo.org>,
       Jean Delvare <khali@linux-fr.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Linus Torvalds <torvalds@osdl.org>, Brice Goglin <brice@myri.com>,
       "John W. Linville" <linville@tuxdriver.com>, Alan Cox <alan@redhat.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, john.ronciak@intel.com,
       jesse.brandeburg@intel.com, jeffrey.t.kirsher@intel.com,
       auke-jan.h.kok@intel.com
Subject: RFC: PCI quirks update for 2.6.16 (v2)
Message-ID: <20061208161155.GC3356@stusta.de>
References: <20061207132430.GF8963@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061207132430.GF8963@stusta.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for all the comments I've gotten so far.

Below is my current stack of PCI quirks updates for 2.6.16.36.

Does all of this look OK?

TIA
Adrian


Adrian Bunk (1):
      revert the quirk_via_irq changes

Bjorn Helgaas (1):
      PCI: quirk to disable e100 interrupt if RESET failed to

Brice Goglin (1):
      PCI: nVidia quirk to make AER PCI-E extended capability visible

Daniel Ritz (2):
      PCI: fix ICH6 quirks
      PCI: add ICH7/8 ACPI/GPIO io resource quirks

Jean Delvare (1):
      PCI: Unhide the SMBus on Asus PU-DLS

John W. Linville (1):
      pci_ids.h: correct naming of 1022:7450 (AMD 8131 Bridge)

Linus Torvalds (1):
      Add PIIX4 APCI quirk for the 440MX chipset too


 drivers/pci/quirks.c    |  101 ++++++++++++++++++++++++++++++++++++----
 include/linux/pci_ids.h |    5 +
 2 files changed, 97 insertions(+), 9 deletions(-)


diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 381f36b..2a66e39 100644
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
@@ -648,13 +656,7 @@ static void quirk_via_irq(struct pci_dev *dev)
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
@@ -917,6 +919,11 @@ static void __init asus_hides_smbus_hostbridge(struct pci_dev *dev)
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
@@ -978,6 +985,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82845G_HB,	asu
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82850_HB,	asus_hides_smbus_hostbridge );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82865_HB,	asus_hides_smbus_hostbridge );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_7205_0,	asus_hides_smbus_hostbridge );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7501_MCH,	asus_hides_smbus_hostbridge );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82855PM_HB,	asus_hides_smbus_hostbridge );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82855GM_HB,	asus_hides_smbus_hostbridge );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82915GM_HB, asus_hides_smbus_hostbridge );
@@ -1001,6 +1009,7 @@ static void __init asus_hides_smbus_lpc(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_0,	asus_hides_smbus_lpc );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801BA_0,	asus_hides_smbus_lpc );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801CA_0,	asus_hides_smbus_lpc );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801CA_12,	asus_hides_smbus_lpc );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_12,	asus_hides_smbus_lpc );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801EB_0,	asus_hides_smbus_lpc );
@@ -1292,6 +1301,63 @@ static void __devinit quirk_netmos(struct pci_dev *dev)
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
@@ -1387,6 +1453,25 @@ static void __devinit quirk_p64h2_1k_io(struct pci_dev *dev)
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

