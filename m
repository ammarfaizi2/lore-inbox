Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129675AbRAPRNB>; Tue, 16 Jan 2001 12:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129627AbRAPRMv>; Tue, 16 Jan 2001 12:12:51 -0500
Received: from irz301.inf.tu-dresden.de ([141.76.2.1]:19908 "EHLO
	irz301.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id <S129436AbRAPRMk>; Tue, 16 Jan 2001 12:12:40 -0500
Date: Tue, 16 Jan 2001 18:12:07 +0100
From: Adam Lackorzynski <al10@inf.tu-dresden.de>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] PCI-Devices and ServerWorks chipset
Message-ID: <20010116181207.A1325@inf.tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch below (against vanilla 2.4.0) makes Linux recognize
PCI-Devices sitting in another PCI bus than 0 (or 1).

This was tested on a Netfinity 7100-8666 using a ServerWorks chipset.


00:00.0 Host bridge: ServerWorks CNB20HE (rev 21)
00:00.1 Host bridge: ServerWorks CNB20HE (rev 01)
00:00.2 Host bridge: ServerWorks: Unknown device 0006
00:00.3 Host bridge: ServerWorks: Unknown device 0006
00:01.0 SCSI storage controller: Adaptec 7896
00:01.1 SCSI storage controller: Adaptec 7896
00:05.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet LANCE] (rev 44)
00:06.0 VGA compatible controller: S3 Inc. Trio 64 3D (rev 01)
00:0f.0 ISA bridge: ServerWorks OSB4 (rev 4f)
00:0f.1 IDE interface: ServerWorks: Unknown device 0211
00:0f.2 USB Controller: ServerWorks: Unknown device 0220 (rev 04)
02:04.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
02:06.0 RAID bus controller: IBM: Unknown device 01bd

The last two lines do not occur without the patch.


diff -ur linux-2.4.0/linux/arch/i386/kernel/pci-pc.c linux/arch/i386/kernel/pci-pc.c
--- linux-2.4.0/linux/arch/i386/kernel/pci-pc.c Thu Jun 22 16:17:16 2000
+++ linux/arch/i386/kernel/pci-pc.c     Tue Jan 16 18:10:30 2001
@@ -849,10 +849,13 @@
         * ServerWorks host bridges -- Find and scan all secondary buses.
         * Register 0x44 contains first, 0x45 last bus number routed there.
         */
-       u8 busno;
-       pci_read_config_byte(d, 0x44, &busno);
-       printk("PCI: ServerWorks host bridge: secondary bus %02x\n", busno);
-       pci_scan_bus(busno, pci_root_ops, NULL);
+       u8 busno_first, busno_last, i;
+       pci_read_config_byte(d, 0x44, &busno_first);
+       pci_read_config_byte(d, 0x45, &busno_last);
+       for (i = busno_first; i <= busno_last; i++) {
+               printk("PCI: ServerWorks host bridge: secondary bus %02x\n", i);
+               pci_scan_bus(i, pci_root_ops, NULL);
+       }
        pcibios_last_bus = -1;
 }
 


Adam
-- 
Adam                 al10@inf.tu-dresden.de
  Lackorzynski         http://a.home.dhs.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
