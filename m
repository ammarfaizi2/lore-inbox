Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271741AbRIROxb>; Tue, 18 Sep 2001 10:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271687AbRIROxW>; Tue, 18 Sep 2001 10:53:22 -0400
Received: from [195.66.192.167] ([195.66.192.167]:21508 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S271719AbRIROxP>; Tue, 18 Sep 2001 10:53:15 -0400
Date: Tue, 18 Sep 2001 17:51:48 +0300
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <11433641523.20010918175148@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Athlon bug stomper. Pls apply.
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Alan,

Since we don't have any negative feedback on Athlon bug
stomper, I think patch could be applied to
arch/i386/kernel/pci-pc.c in mainline kernel.
Diffed against 4.2.9.
BTW, there are similar fixup routines in drivers/pci/quirks.c
Why two .c files for hw related fixes?
-- 
Best regards, VDA
mailto:VDA@port.imtp.ilyichevsk.odessa.ua
http://port.imtp.ilyichevsk.odessa.ua/vda/

--- pci-pc.c.orig       Sun Aug 12 15:54:07 2001
+++ pci-pc.c    Tue Sep 18 16:45:21 2001
@@ -948,6 +948,26 @@
        d->irq = 9;
 }
 
+/* Fixes some oopses on Athlon optimized
+ * fast_copy_page when it uses 'movntq's
+ * instead of 'movq's on Athlon/Duron optimized kernels. 
+ * Bit 7 at offset 0x55 seems to be responsible:
+ * > Device 0 Offset 55 - Debug (RW)
+ * >   Bits 7-0: Reserved (do not program). default = 0
+ * ABIT KT7A 3R BIOS: 0x89 (oopses)
+ * ABIT KT7A YH BIOS: 0x00 (works)
+ */
+static void __init pci_fixup_athlon_bug(struct pci_dev *d)
+{
+       u8 v;
+        pci_read_config_byte(d, 0x55, &v);
+        if(v & 0x80) {
+                printk(KERN_NOTICE "Stomping on Athlon bug.\n");
+                v &= 0x7f; /* clear bit 55.7 */
+                pci_write_config_byte(d, 0x55, v);
+        }
+}
+
 struct pci_fixup pcibios_fixups[] = {
        { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82451NX,    pci_fixup_i450nx },
        { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82454GX,    pci_fixup_i450gx },
@@ -961,6 +981,7 @@
 /* Our bus code shouldnt need this fixup any more. Delete once verified */
        { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_COMPAQ,   PCI_DEVICE_ID_COMPAQ_6010,      pci_fixup_compaq },
 #endif 
+       { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_VIA,      PCI_DEVICE_ID_VIA_8363_0,       pci_fixup_athlon_bug },
        { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_UMC,      PCI_DEVICE_ID_UMC_UM8886BF,     pci_fixup_umc_ide },
        { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_SI,       PCI_DEVICE_ID_SI_5513,          pci_fixup_ide_trash },
        { PCI_FIXUP_HEADER,     PCI_ANY_ID,             PCI_ANY_ID,                     pci_fixup_ide_bases },


