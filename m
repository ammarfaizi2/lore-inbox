Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263316AbTDGHik (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 03:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263317AbTDGHik (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 03:38:40 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:46490 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263316AbTDGHif (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 03:38:35 -0400
Date: Mon, 7 Apr 2003 09:50:09 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] take 48-bit lba a bit further
Message-ID: <20030407075009.GS786@suse.de>
References: <20030406130737.GL786@suse.de> <20030406164306.GC8303@vana.vc.cvut.cz> <1049646450.1349.1.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1049646450.1349.1.camel@dhcp22.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 06 2003, Alan Cox wrote:
> On Sul, 2003-04-06 at 17:43, Petr Vandrovec wrote:
> > > Works perfectly in testing here, ext2/3 generates nice big 512KiB
> > > requests and the drive flies.
> > > 
> > >  	(void) probe_lba_addressing(drive, 1);
> > >  
> > > +	if (drive->addressing)
> > > +		blk_queue_max_sectors(&drive->queue, 1024);
> > > +
> > 
> > Should not you honor host's max queue length? siimage & pdc4030 sets
> > max_sectors to 128 (resp. 16 resp. 127), while you overwrite it here
> > unconditionally with 1024.
> 
> For production code thats required. The actual change required is to
> clamp the default/hwif set queue limit to 256 if driver->addressing !=1

Yes I was aware of this short-cut. I want to see rqsize being generally
set as a maximum, of the host adapter doesn't set its own upper limit.
This patch adds that little piece (I think I caught both legacy and pci,
please double check Alan), and also fixes pdc202xx_old to work with
48-bit again.

diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.66-ac2/drivers/ide/ide-disk.c linux-2.5.66-ac2/drivers/ide/ide-disk.c
--- /opt/kernel/linux-2.5.66-ac2/drivers/ide/ide-disk.c	2003-04-06 13:15:19.000000000 +0200
+++ linux-2.5.66-ac2/drivers/ide/ide-disk.c	2003-04-07 09:44:34.000000000 +0200
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
@@ -1591,6 +1591,15 @@
 
 	(void) probe_lba_addressing(drive, 1);
 
+	if (drive->addressing) {
+		int max_sectors = 1024;
+
+		if (max_sectors > HWIF(drive)->rqsize)
+			max_sectors = HWIF(drive)->rqsize;
+
+		blk_queue_max_sectors(&drive->queue, max_sectors);
+	}
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
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.66-ac2/drivers/ide/ide.c linux-2.5.66-ac2/drivers/ide/ide.c
--- /opt/kernel/linux-2.5.66-ac2/drivers/ide/ide.c	2003-04-06 13:15:19.000000000 +0200
+++ linux-2.5.66-ac2/drivers/ide/ide.c	2003-04-07 09:41:01.000000000 +0200
@@ -947,6 +947,9 @@
 #endif
 	}
 
+	if (!hwif->rqsize)
+		hwif->rqsize = 65535;
+
 	if (hwifp)
 		*hwifp = hwif;
 
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.66-ac2/drivers/ide/pci/pdc202xx_old.c linux-2.5.66-ac2/drivers/ide/pci/pdc202xx_old.c
--- /opt/kernel/linux-2.5.66-ac2/drivers/ide/pci/pdc202xx_old.c	2003-03-24 23:01:47.000000000 +0100
+++ linux-2.5.66-ac2/drivers/ide/pci/pdc202xx_old.c	2003-04-07 09:13:50.000000000 +0200
@@ -535,8 +535,9 @@
 
 static int pdc202xx_old_ide_dma_begin(ide_drive_t *drive)
 {
-	if (drive->addressing == 1) {
-		struct request *rq	= HWGROUP(drive)->rq;
+	struct request *rq = HWGROUP(drive)->rq;
+
+	if (drive->addressing == 1 && rq_lba48(rq)) {
 		ide_hwif_t *hwif	= HWIF(drive);
 //		struct pci_dev *dev	= hwif->pci_dev;
 //		unsgned long high_16	= pci_resource_start(dev, 4);
@@ -557,7 +558,9 @@
 
 static int pdc202xx_old_ide_dma_end(ide_drive_t *drive)
 {
-	if (drive->addressing == 1) {
+	struct request *rq = HWGROUP(drive)->rq;
+
+	if (drive->addressing == 1 && rq_lba48(rq)) {
 		ide_hwif_t *hwif	= HWIF(drive);
 //		unsigned long high_16	= pci_resource_start(hwif->pci_dev, 4);
 		unsigned long high_16	= hwif->dma_master;
diff -ur -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.5.66-ac2/drivers/ide/setup-pci.c linux-2.5.66-ac2/drivers/ide/setup-pci.c
--- /opt/kernel/linux-2.5.66-ac2/drivers/ide/setup-pci.c	2003-03-24 23:00:20.000000000 +0100
+++ linux-2.5.66-ac2/drivers/ide/setup-pci.c	2003-04-07 09:40:48.000000000 +0200
@@ -632,7 +632,6 @@
 			index->b.low = hwif->index;
 		}
 
-		
 		if (d->init_iops)
 			d->init_iops(hwif);
 
@@ -658,6 +657,9 @@
 			 */
 			d->init_hwif(hwif);
 
+		if (!hwif->rqsize)
+			hwif->rqsize = 65535;
+
 		/*
 		 *	This is in the wrong place. The driver may
 		 *	do set up based on the autotune value and this
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

