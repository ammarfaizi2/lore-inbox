Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267945AbTBRRpm>; Tue, 18 Feb 2003 12:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267950AbTBRRpm>; Tue, 18 Feb 2003 12:45:42 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15625 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267945AbTBRRpk>; Tue, 18 Feb 2003 12:45:40 -0500
Subject: PATCH: ide resync
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 18 Feb 2003 17:55:59 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18lByJ-00066L-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok this first piece eliminates some of the use of ide_ioreg_t, which
actually only works as a ulong anyway. Its a dysfunctional abstraction.

We also need the ide pci stuff if we have IDE PCI not if we have PCI but
only legacy mode IDE support

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/include/asm-i386/ide.h linux-2.5.61-ac2/include/asm-i386/ide.h
--- linux-2.5.61/include/asm-i386/ide.h	2003-02-10 18:37:58.000000000 +0000
+++ linux-2.5.61-ac2/include/asm-i386/ide.h	2003-02-18 15:27:32.000000000 +0000
@@ -16,14 +16,14 @@
 #include <linux/config.h>
 
 #ifndef MAX_HWIFS
-# ifdef CONFIG_PCI
+# ifdef CONFIG_BLK_DEV_IDEPCI
 #define MAX_HWIFS	10
 # else
 #define MAX_HWIFS	6
 # endif
 #endif
 
-static __inline__ int ide_default_irq(ide_ioreg_t base)
+static __inline__ int ide_default_irq(unsigned long base)
 {
 	switch (base) {
 		case 0x1f0: return 14;
@@ -37,16 +37,24 @@
 	}
 }
 
-static __inline__ ide_ioreg_t ide_default_io_base(int index)
+static __inline__ unsigned long ide_default_io_base(int index)
 {
-	static unsigned long ata_io_base[MAX_HWIFS] = { 0x1f0, 0x170, 0x1e8, 0x168, 0x1e0, 0x160 };
-
-	return ata_io_base[index];
+	switch (index) {
+		case 0:	return 0x1f0;
+		case 1:	return 0x170;
+		case 2: return 0x1e8;
+		case 3: return 0x168;
+		case 4: return 0x1e0;
+		case 5: return 0x160;
+		default:
+			return 0;
+	}
 }
 
-static __inline__ void ide_init_hwif_ports(hw_regs_t *hw, ide_ioreg_t data_port, ide_ioreg_t ctrl_port, int *irq)
+static __inline__ void ide_init_hwif_ports(hw_regs_t *hw, unsigned long data_port,
+	 unsigned long ctrl_port, int *irq)
 {
-	ide_ioreg_t reg = data_port;
+	unsigned long reg = data_port;
 	int i;
 
 	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
@@ -65,7 +73,7 @@
 
 static __inline__ void ide_init_default_hwifs(void)
 {
-#ifndef CONFIG_PCI
+#ifndef CONFIG_BLK_DEV_IDEPCI
 	hw_regs_t hw;
 	int index;
 
@@ -75,9 +83,11 @@
 		hw.irq = ide_default_irq(ide_default_io_base(index));
 		ide_register_hw(&hw, NULL);
 	}
-#endif
+#endif /* CONFIG_BLK_DEV_IDEPCI */
 }
 
+#include <asm-generic/ide_iops.h>
+
 #endif /* __KERNEL__ */
 
 #endif /* __ASMi386_IDE_H */
