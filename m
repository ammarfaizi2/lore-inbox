Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265754AbSKTEyN>; Tue, 19 Nov 2002 23:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265757AbSKTEyM>; Tue, 19 Nov 2002 23:54:12 -0500
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:35488
	"HELO mail.theoesters.com") by vger.kernel.org with SMTP
	id <S265754AbSKTEyL>; Tue, 19 Nov 2002 23:54:11 -0500
Date: Tue, 19 Nov 2002 21:01:15 -0800
From: Phil Oester <kernel@theoesters.com>
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Subject: [PATCH] Allow 2.5.48 IDE to compile w/o DMA
Message-ID: <20021119210115.A32262@ns1.theoesters.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attempting to compile 2.5.48-bk with generic IDE support, but not DMA support gives the following errors:

drivers/built-in.o: In function `init_dma_generic':
drivers/built-in.o(.text+0x34e4d): undefined reference to `ide_setup_dma'
drivers/built-in.o: In function `ide_hwif_setup_dma':
drivers/built-in.o(.text+0x43f9d): undefined reference to `ide_get_or_set_dma_base'
drivers/built-in.o(.text+0x44025): undefined reference to `ide_setup_dma'

The patch below fixed it up for me.

Phil Oester

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

