Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273996AbRJIKtq>; Tue, 9 Oct 2001 06:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274964AbRJIKtk>; Tue, 9 Oct 2001 06:49:40 -0400
Received: from [195.66.192.167] ([195.66.192.167]:61969 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S274897AbRJIKt3>; Tue, 9 Oct 2001 06:49:29 -0400
Date: Tue, 9 Oct 2001 13:45:17 +0200
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <140103605516.20011009134517@port.imtp.ilyichevsk.odessa.ua>
To: "Marco Berizzi" <pupilla@hotmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] again: Re: Athlon kernel crash (i686 works)
In-Reply-To: <LAW2-OE3760Ov0Hvk1w000079df@hotmail.com>
In-Reply-To: <LAW2-OE3760Ov0Hvk1w000079df@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh no.

Anybody still insist that 'Athlon bug' patch is not to be
included into mainstream kernel?
If someone doesn't like it, feel free to make it a config
option (enabled by default!) and submit an updated patch.
My original patch against 2.4.9 is at the end.

Tuesday, October 09, 2001, 11:32:24 AM,
"Marco Berizzi" <pupilla@hotmail.com> wrote:
MB> I updated my motherboard from ASUS A7V to ABIT KT7A (VIA Apollo KT133A
MB> chipset). The kernel I had (2.4.10) started crashing on boot  usually
MB> right after starting init. I tryed a i686 kernel and noticed it works
MB> OK, so I recompiled my crashy kernel only switching the processor type
MB> and it also worked. Changed it back to Athlon/K7/Duron and it starts
MB> crashing.

MB> I also search the mailing list. My mother board is KT7A series v1.3 with
MB> bios revision 4T (I also try with 3N, same results). K7 at 1333MHz. BIOS
MB> settings are default (except I have disabled all BIOS/video shadow).
MB> After flash I also reset CMOS via hardware jumper.

MB> Is there any solution to this (except compiling kernel for 6x86)?
-- 
Best regards, VDA
mailto:VDA@port.imtp.ilyichevsk.odessa.ua

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
        { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_INTEL,   
PCI_DEVICE_ID_INTEL_82451NX,    pci_fixup_i450nx },
        { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_INTEL,   
PCI_DEVICE_ID_INTEL_82454GX,    pci_fixup_i450gx },
@@ -961,6 +981,7 @@
 /* Our bus code shouldnt need this fixup any more. Delete once
verified */
        { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_COMPAQ,  
PCI_DEVICE_ID_COMPAQ_6010,      pci_fixup_compaq },
 #endif 
+       { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_VIA,     
PCI_DEVICE_ID_VIA_8363_0,       pci_fixup_athlon_bug },
        { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_UMC,     
PCI_DEVICE_ID_UMC_UM8886BF,     pci_fixup_umc_ide },
        { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_SI,      
PCI_DEVICE_ID_SI_5513,          pci_fixup_ide_trash },
        { PCI_FIXUP_HEADER,     PCI_ANY_ID,             PCI_ANY_ID,    
pci_fixup_ide_bases },


