Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283708AbRLMIq3>; Thu, 13 Dec 2001 03:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283717AbRLMIqU>; Thu, 13 Dec 2001 03:46:20 -0500
Received: from [195.66.192.167] ([195.66.192.167]:20240 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S283708AbRLMIqJ>; Thu, 13 Dec 2001 03:46:09 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Corrin Lakeland <lakeland@atlas.otago.ac.nz>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.16 not booting with Athlon optimisations
Date: Thu, 13 Dec 2001 10:44:01 -0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.OSF.4.21.0112130954120.517863-100000@atlas.otago.ac.nz>
In-Reply-To: <Pine.OSF.4.21.0112130954120.517863-100000@atlas.otago.ac.nz>
MIME-Version: 1.0
Message-Id: <01121310440102.01849@manta>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 December 2001 19:01, Corrin Lakeland wrote:
> This message seems similar to a thread a few months back called "Duron
> kernel crash (i686 works)".  I posted a) because I couldn't find a
> solution at the end of that thread and b) I could be wrong about it being
> the same.

The fix went into mainstream. Grep pci-pc.c for "Athlon bug".
If it does not work for you, we might need more thorough VIA fix.
You may try this patch (it is not mine and untested, use it with
reasonable caution).

Please report back.
--
vda

--- linux-2.4.16/arch/i386/kernel/pci-pc.c	Fri Nov  9 22:58:02 2001
+++ linux-2.4.16-devel/arch/i386/kernel/pci-pc.c	Fri Dec  7 11:00:01 2001
@@ -1109,25 +1109,38 @@
 }
 
 /*
- * Nobody seems to know what this does. Damn.
- *
- * But it does seem to fix some unspecified problem
+ * This does seem to fix some unspecified problem
  * with 'movntq' copies on Athlons.
  *
- * VIA 8363 chipset:
- *  - bit 7 at offset 0x55: Debug (RW)
+ * VIA 8361/8363/8662 chipset:
+ *  - bit 7,6,5 at offset 0x55: Debug (RW)
  */
 static void __init pci_fixup_via_athlon_bug(struct pci_dev *d)
 {
 	u8 v;
 	pci_read_config_byte(d, 0x55, &v);
-	if (v & 0x80) {
-		printk("Trying to stomp on Athlon bug...\n");
-		v &= 0x7f; /* clear bit 55.7 */
+	if (v & 0xE0) {
+		printk("PCI: Disabling VIA VT8361/8363/8662 Memory Write Queue\n");
+		v &= 0x1f; /* clear bit 55.7, 6, 5 */
 		pci_write_config_byte(d, 0x55, v);
 	}
 }
 
+/*
+ * VIA 8366 chipset:
+ *  - bit 7,6,5 at offset 0x95: Debug (RW)
+ */
+static void __init pci_fixup_via_kt266_athlon_bug(struct pci_dev *d)
+{
+	u8 v;
+	pci_read_config_byte(d, 0x95, &v);
+	if (v & 0xE0) {
+		printk("PCI: Disabling VIA VT8366 Memory Write Queue\n");
+		v &= 0x1f; /* clear bit 55.7, 6, 5 */
+		pci_write_config_byte(d, 0x95, v);
+	}
+}
+
 struct pci_fixup pcibios_fixups[] = {
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82451NX,	
pci_fixup_i450nx },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82454GX,	
pci_fixup_i450gx },
@@ -1138,6 +1151,9 @@
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_5598,		
pci_fixup_latency },
  	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371AB_3,	
pci_fixup_piix4_acpi },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8363_0,	
pci_fixup_via_athlon_bug },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8366_0,	
pci_fixup_via_kt266_athlon_bug },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8662_0,	
pci_fixup_via_athlon_bug },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8361_0,	
pci_fixup_via_athlon_bug },
 	{ 0 }
 };
 
--- linux-2.4.16/include/linux/pci_ids.h	Fri Nov  9 23:11:15 2001
+++ linux-2.4.16-devel/include/linux/pci_ids.h	Fri Dec  7 00:25:12 2001
@@ -948,6 +948,9 @@
 #define PCI_DEVICE_ID_VIA_8233_0	0x3074
 #define PCI_DEVICE_ID_VIA_8233C_0	0x3109
 #define PCI_DEVICE_ID_VIA_8633_0	0x3091
+#define PCI_DEVICE_ID_VIA_8366_0	0x3099
+#define PCI_DEVICE_ID_VIA_8662_0	0x3102
+#define PCI_DEVICE_ID_VIA_8361_0	0x3112
 #define PCI_DEVICE_ID_VIA_8367_0	0x3099
 #define PCI_DEVICE_ID_VIA_86C100A	0x6100
 #define PCI_DEVICE_ID_VIA_8231		0x8231
