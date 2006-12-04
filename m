Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937089AbWLDQZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937089AbWLDQZX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 11:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937091AbWLDQZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 11:25:23 -0500
Received: from [81.2.110.250] ([81.2.110.250]:53199 "EHLO lxorguk.ukuu.org.uk"
	rhost-flags-FAIL-??-OK-FAIL) by vger.kernel.org with ESMTP
	id S937088AbWLDQZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 11:25:20 -0500
Date: Mon, 4 Dec 2006 16:30:57 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] ide-cd: Handle strange interrupt on the Intel ESB2
Message-ID: <20061204163057.2f27a12a@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ESB2 appears to emit spurious DMA interrupts when configured for
native mode and handling ATAPI devices. Stratus were able to pin this bug
down and produce a patch. This is a rework which applies the fixup only
to the ESB2 (for now). We can apply it to other chips later if the same
problem is found.

This code has been tested and confirmed to fix the problem on the tested
systems.

Signed-off-by: Alan Cox <alan@redhat.com>
(Most of the hard work done by Stratus however)

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc6-mm1/drivers/ide/ide-cd.c linux-2.6.19-rc6-mm1/drivers/ide/ide-cd.c
--- linux.vanilla-2.6.19-rc6-mm1/drivers/ide/ide-cd.c	2006-11-24 13:58:06.000000000 +0000
+++ linux-2.6.19-rc6-mm1/drivers/ide/ide-cd.c	2006-12-01 19:24:58.000000000 +0000
@@ -687,8 +687,15 @@
 static int cdrom_decode_status(ide_drive_t *drive, int good_stat, int *stat_ret)
 {
 	struct request *rq = HWGROUP(drive)->rq;
+	ide_hwif_t *hwif = HWIF(drive);
 	int stat, err, sense_key;
 	
+	/* We may have bogus DMA interrupts in PIO state here */
+	if (HWIF(drive)->dma_status && hwif->atapi_irq_bogon) {
+		stat = hwif->INB(hwif->dma_status);
+		/* Should we force the bit as well ? */
+		hwif->OUTB(stat, hwif->dma_status);
+	}
 	/* Check for errors. */
 	stat = HWIF(drive)->INB(IDE_STATUS_REG);
 	if (stat_ret)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc6-mm1/drivers/ide/pci/piix.c linux-2.6.19-rc6-mm1/drivers/ide/pci/piix.c
--- linux.vanilla-2.6.19-rc6-mm1/drivers/ide/pci/piix.c	2006-11-24 13:58:29.000000000 +0000
+++ linux-2.6.19-rc6-mm1/drivers/ide/pci/piix.c	2006-12-01 19:20:46.000000000 +0000
@@ -473,6 +473,10 @@
 		/* This is a painful system best to let it self tune for now */
 		return;
 	}
+	/* ESB2 appears to generate spurious DMA interrupts in PIO mode
+	   when in native mode */
+	if (hwif->pci_dev->device == PCI_DEVICE_ID_INTEL_ESB2_18)
+		hwif->atapi_irq_bogon = 1;
 
 	hwif->autodma = 0;
 	hwif->tuneproc = &piix_tune_drive;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc6-mm1/include/linux/ide.h linux-2.6.19-rc6-mm1/include/linux/ide.h
--- linux.vanilla-2.6.19-rc6-mm1/include/linux/ide.h	2006-11-24 13:58:12.000000000 +0000
+++ linux-2.6.19-rc6-mm1/include/linux/ide.h	2006-12-01 19:16:27.000000000 +0000
@@ -796,6 +796,7 @@
 	unsigned	sg_mapped  : 1;	/* sg_table and sg_nents are ready */
 	unsigned	no_io_32bit : 1; /* 1 = can not do 32-bit IO ops */
 	unsigned	err_stops_fifo : 1; /* 1=data FIFO is cleared by an error */
+	unsigned	atapi_irq_bogon : 1; /* Generates spurious DMA interrupts in PIO mode */
 
 	struct device	gendev;
 	struct completion gendev_rel_comp; /* To deal with device release() */
