Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265325AbSKAT4o>; Fri, 1 Nov 2002 14:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265364AbSKAT4o>; Fri, 1 Nov 2002 14:56:44 -0500
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:36529
	"HELO mail.theoesters.com") by vger.kernel.org with SMTP
	id <S265325AbSKAT4n>; Fri, 1 Nov 2002 14:56:43 -0500
Date: Fri, 1 Nov 2002 12:03:11 -0800
From: Phil Oester <kernel@theoesters.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Allow 2.5.45 IDE to compile without DMA
Message-ID: <20021101120311.A31647@ns1.theoesters.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I enable generic IDE chipset support, but do not enable DMA, the kernel won't compile.  The patch below (while admittedly inelegant) fixed that up for me.

For the record, I only enabled these IDE options:

CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y

-Phil Oester


diff -ru linux-2.5.45-orig/drivers/ide/pci/generic.c linux-2.5.45/drivers/ide/pci/generic.c
--- linux-2.5.45-orig/drivers/ide/pci/generic.c Wed Oct 30 19:42:57 2002
+++ linux-2.5.45/drivers/ide/pci/generic.c      Fri Nov  1 14:42:16 2002
@@ -60,7 +60,11 @@
 
 static void init_dma_generic (ide_hwif_t *hwif, unsigned long dmabase)
 {
+#ifdef CONFIG_BLK_DEV_IDEDMA
        ide_setup_dma(hwif, dmabase, 8);
+#else /* !CONFIG_BLK_DEV_IDEDMA */
+       return;
+#endif /* CONFIG_BLK_DEV_IDEDMA */
 }
 
 extern void ide_setup_pci_device(struct pci_dev *, ide_pci_device_t *);
diff -ru linux-2.5.45-orig/drivers/ide/setup-pci.c linux-2.5.45/drivers/ide/setup-pci.c
--- linux-2.5.45-orig/drivers/ide/setup-pci.c   Wed Oct 30 19:42:28 2002
+++ linux-2.5.45/drivers/ide/setup-pci.c        Fri Nov  1 14:00:55 2002
@@ -475,6 +475,8 @@
        return hwif;
 }
 
+#ifdef CONFIG_BLK_DEV_IDEDMA
+
 /**
  *     ide_hwif_setup_dma      -       configure DMA interface
  *     @dev: PCI device
@@ -528,6 +530,8 @@
        }
 }
 
+#endif /* CONFIG_BLK_DEV_IDEDMA */
+
 /**
  *     ide_setup_pci_controller        -       set up IDE PCI
  *     @dev: PCI device

