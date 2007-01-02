Return-Path: <linux-kernel-owner+w=401wt.eu-S1755328AbXABPrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755328AbXABPrl (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 10:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755330AbXABPrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 10:47:41 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60491 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755327AbXABPrk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 10:47:40 -0500
Date: Tue, 2 Jan 2007 15:57:52 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] atiixp: Old drivers/ide layer driver for the ATIIXP hang
 fix
Message-ID: <20070102155752.78f6a01e@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When the old IDE layer calls into methods in the driver during error
handling it is essentially random whether ide_lock is already held. This
causes a deadlock in the atiixp driver which also uses ide_lock internally
for locking.

Switch to a private lock instead. 

Signed-off-by: Alan Cox <alan@redhat.com>

--- linux.vanilla-2.6.20-rc3/drivers/ide/pci/atiixp.c	2007-01-01 21:43:27.000000000 +0000
+++ linux-2.6.20-rc3/drivers/ide/pci/atiixp.c	2007-01-02 15:27:37.494937880 +0000
@@ -46,6 +46,8 @@
 
 static int save_mdma_mode[4];
 
+static spinlock_t atiixp_lock;
+
 /**
  *	atiixp_ratemask		-	compute rate mask for ATIIXP IDE
  *	@drive: IDE drive to compute for
@@ -105,7 +107,7 @@
 	unsigned long flags;
 	u16 tmp16;
 
-	spin_lock_irqsave(&ide_lock, flags);
+	spin_lock_irqsave(&atiixp_lock, flags);
 
 	pci_read_config_word(dev, ATIIXP_IDE_UDMA_CONTROL, &tmp16);
 	if (save_mdma_mode[drive->dn])
@@ -114,7 +116,7 @@
 		tmp16 |= (1 << drive->dn);
 	pci_write_config_word(dev, ATIIXP_IDE_UDMA_CONTROL, tmp16);
 
-	spin_unlock_irqrestore(&ide_lock, flags);
+	spin_unlock_irqrestore(&atiixp_lock, flags);
 
 	return __ide_dma_host_on(drive);
 }
@@ -125,13 +127,13 @@
 	unsigned long flags;
 	u16 tmp16;
 
-	spin_lock_irqsave(&ide_lock, flags);
+	spin_lock_irqsave(&atiixp_lock, flags);
 
 	pci_read_config_word(dev, ATIIXP_IDE_UDMA_CONTROL, &tmp16);
 	tmp16 &= ~(1 << drive->dn);
 	pci_write_config_word(dev, ATIIXP_IDE_UDMA_CONTROL, tmp16);
 
-	spin_unlock_irqrestore(&ide_lock, flags);
+	spin_unlock_irqrestore(&atiixp_lock, flags);
 
 	return __ide_dma_host_off(drive);
 }
@@ -152,7 +154,7 @@
 	u32 pio_timing_data;
 	u16 pio_mode_data;
 
-	spin_lock_irqsave(&ide_lock, flags);
+	spin_lock_irqsave(&atiixp_lock, flags);
 
 	pci_read_config_word(dev, ATIIXP_IDE_PIO_MODE, &pio_mode_data);
 	pio_mode_data &= ~(0x07 << (drive->dn * 4));
@@ -165,7 +167,7 @@
 		 (pio_timing[pio].command_width << (timing_shift + 4));
 	pci_write_config_dword(dev, ATIIXP_IDE_PIO_TIMING, pio_timing_data);
 
-	spin_unlock_irqrestore(&ide_lock, flags);
+	spin_unlock_irqrestore(&atiixp_lock, flags);
 }
 
 /**
@@ -189,7 +191,7 @@
 
 	speed = ide_rate_filter(atiixp_ratemask(drive), xferspeed);
 
-	spin_lock_irqsave(&ide_lock, flags);
+	spin_lock_irqsave(&atiixp_lock, flags);
 
 	save_mdma_mode[drive->dn] = 0;
 	if (speed >= XFER_UDMA_0) {
@@ -208,7 +210,7 @@
 		}
 	}
 
-	spin_unlock_irqrestore(&ide_lock, flags);
+	spin_unlock_irqrestore(&atiixp_lock, flags);
 
 	if (speed >= XFER_SW_DMA_0)
 		pio = atiixp_dma_2_pio(speed);
@@ -380,6 +382,7 @@
 
 static int atiixp_ide_init(void)
 {
+	spin_lock_init(&atiixp_lock);
 	return ide_pci_register_driver(&driver);
 }
 
