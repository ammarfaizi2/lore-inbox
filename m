Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262956AbTDFM4K (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 08:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262958AbTDFM4K (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 08:56:10 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:17383 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262956AbTDFM4I (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 08:56:08 -0400
Date: Sun, 6 Apr 2003 15:07:37 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] take 48-bit lba a bit further
Message-ID: <20030406130737.GL786@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for taking the previous bit Alan, here's an incremental update to
2.5.66-ac2. Just cleans up the 'when to use 48-bit lba' logic a bit per
Andries suggestion, and also expands the request size for 48-bit lba
capable drives to 512KiB.

Works perfectly in testing here, ext2/3 generates nice big 512KiB
requests and the drive flies.

diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.66-ac2/drivers/ide/ide-disk.c linux-2.5.66-ac2/drivers/ide/ide-disk.c
--- /opt/kernel/linux-2.5.66-ac2/drivers/ide/ide-disk.c	2003-04-06 13:15:19.000000000 +0200
+++ linux-2.5.66-ac2/drivers/ide/ide-disk.c	2003-04-06 15:05:07.000000000 +0200
@@ -373,7 +373,7 @@
 
 	nsectors.all		= (u16) rq->nr_sectors;
 
-	if (drive->addressing == 1 && block + rq->nr_sectors > 0xfffffff)
+	if (drive->addressing == 1 && rq_lba48(rq))
 		lba48 = 1;
 
 	if (driver_blocked)
@@ -583,7 +583,7 @@
 {
 	int lba48bit = 0;
 
-	if (drive->addressing == 1 && block > 0xfffffff)
+	if (drive->addressing == 1 && rq_lba48(rq))
 		lba48bit = 1;
 
 	BUG_ON(drive->blocked);
@@ -611,7 +611,7 @@
 		return ide_started;
 	}
 
-	if (lba48bit && block > 0xfffffff)
+	if (lba48bit)
 		return lba_48_rw_disk(drive, rq, (unsigned long long) block);
 	if (drive->select.b.lba)		/* 28-bit LBA */
 		return lba_28_rw_disk(drive, rq, (unsigned long) block);
@@ -625,7 +625,7 @@
 	int cmd = rq_data_dir(rq);
 	int lba48bit = 0;
 
-	if (drive->addressing == 1 && rq->sector > 0xfffffff)
+	if (drive->addressing == 1 && rq_lba48(rq))
 		lba48bit = 1;
 
 	if ((cmd == READ) && drive->using_tcq)
@@ -1504,7 +1504,7 @@
 
 static int set_lba_addressing (ide_drive_t *drive, int arg)
 {
-	return (probe_lba_addressing(drive, arg));
+	return probe_lba_addressing(drive, arg);
 }
 
 static void idedisk_add_settings(ide_drive_t *drive)
@@ -1591,6 +1591,9 @@
 
 	(void) probe_lba_addressing(drive, 1);
 
+	if (drive->addressing)
+		blk_queue_max_sectors(&drive->queue, 1024);
+
 	/* Extract geometry if we did not already have one for the drive */
 	if (!drive->cyl || !drive->head || !drive->sect) {
 		drive->cyl     = drive->bios_cyl  = id->cyls;
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.66-ac2/drivers/ide/ide-dma.c linux-2.5.66-ac2/drivers/ide/ide-dma.c
--- /opt/kernel/linux-2.5.66-ac2/drivers/ide/ide-dma.c	2003-04-06 13:15:19.000000000 +0200
+++ linux-2.5.66-ac2/drivers/ide/ide-dma.c	2003-04-06 13:19:34.000000000 +0200
@@ -663,7 +663,7 @@
 	if (drive->media != ide_disk)
 		return 0;
 
-	if (drive->addressing == 1 && rq->sector > 0xfffffff)
+	if (drive->addressing == 1 && rq_lba48(rq))
 		lba48 = 1;
 
 	command = (lba48) ? WIN_READDMA_EXT : WIN_READDMA;
@@ -698,7 +698,7 @@
 	if (drive->media != ide_disk)
 		return 0;
 
-	if (drive->addressing == 1 && rq->sector > 0xfffffff)
+	if (drive->addressing == 1 && rq_lba48(rq))
 		lba48 = 1;
 
 	command = (lba48) ? WIN_WRITEDMA_EXT : WIN_WRITEDMA;
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.66-ac2/include/linux/ide.h linux-2.5.66-ac2/include/linux/ide.h
--- /opt/kernel/linux-2.5.66-ac2/include/linux/ide.h	2003-04-06 13:15:20.000000000 +0200
+++ linux-2.5.66-ac2/include/linux/ide.h	2003-04-06 13:20:25.000000000 +0200
@@ -866,6 +866,12 @@
 		bio_kunmap_irq(buffer, flags);
 }
 
+/*
+ * must be addressed with 48-bit lba
+ */
+#define rq_lba48(rq)	\
+	(((rq)->sector + (rq)->nr_sectors) > 0xfffffff || rq->nr_sectors > 256)
+
 #define IDE_CHIPSET_PCI_MASK	\
     ((1<<ide_pci)|(1<<ide_cmd646)|(1<<ide_ali14xx))
 #define IDE_CHIPSET_IS_PCI(c)	((IDE_CHIPSET_PCI_MASK >> (c)) & 1)

-- 
Jens Axboe

