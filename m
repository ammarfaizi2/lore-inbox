Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288302AbSAUVNR>; Mon, 21 Jan 2002 16:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288342AbSAUVNI>; Mon, 21 Jan 2002 16:13:08 -0500
Received: from echo.sound.net ([205.242.192.21]:36787 "HELO echo.sound.net")
	by vger.kernel.org with SMTP id <S288302AbSAUVMv>;
	Mon, 21 Jan 2002 16:12:51 -0500
Date: Mon, 21 Jan 2002 15:05:57 -0600 (CST)
From: Hal Duston <hald@sound.net>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH ps2esdi fix
Message-ID: <Pine.GSO.4.10.10201211502250.20324-100000@sound.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Get Ps2esdi compiling/working again

bio fixes.
kdev_t fixes.

Hal Duston
hald@sound.net

--- linux-2.5.2/drivers/block/ps2esdi.c	Mon Jan 14 15:06:38 2002
+++ linux-2.5.2-ps2esdi/drivers/block/ps2esdi.c	Mon Jan 14 15:43:27 2002
@@ -422,7 +422,7 @@
 	blk_queue_max_sectors(BLK_DEFAULT_QUEUE(MAJOR_NR), 128);
 
 	for (i = 0; i < ps2esdi_drives; i++) {
-		register_disk(&ps2esdi_gendisk,MKDEV(MAJOR_NR,i<<6),1<<6,
+		register_disk(&ps2esdi_gendisk,mk_kdev(MAJOR_NR,i<<6),1<<6,
 				&ps2esdi_fops,
 				ps2esdi_info[i].head * ps2esdi_info[i].sect *
 				ps2esdi_info[i].cyl);
@@ -466,7 +466,7 @@
 #if 0
 	printk("%s:got request. device : %d minor : %d command : %d  sector : %ld count : %ld, buffer: %p\n",
 	       DEVICE_NAME,
-	       CURRENT_DEV, MINOR(CURRENT->rq_dev),
+	       CURRENT_DEV, minor(CURRENT->rq_dev),
 	       CURRENT->cmd, CURRENT->sector,
 	       CURRENT->current_nr_sectors, CURRENT->buffer);
 #endif
@@ -481,12 +481,12 @@
 	}			/* check for above 16Mb dmas */
 	else if ((CURRENT_DEV < ps2esdi_drives) &&
 	    (CURRENT->sector + CURRENT->current_nr_sectors <=
-	     ps2esdi[MINOR(CURRENT->rq_dev)].nr_sects) &&
+	     ps2esdi[minor(CURRENT->rq_dev)].nr_sects) &&
 	    	CURRENT->flags & REQ_CMD) {
 #if 0
 		printk("%s:got request. device : %d minor : %d command : %d  sector : %ld count : %ld\n",
 		       DEVICE_NAME,
-		       CURRENT_DEV, MINOR(CURRENT->rq_dev),
+		       CURRENT_DEV, minor(CURRENT->rq_dev),
 		       CURRENT->cmd, CURRENT->sector,
 		       CURRENT->current_nr_sectors);
 #endif
@@ -510,7 +510,7 @@
 	/* is request is valid */ 
 	else {
 		printk("Grrr. error. ps2esdi_drives: %d, %lu %lu\n", ps2esdi_drives,
-		       CURRENT->sector, ps2esdi[MINOR(CURRENT->rq_dev)].nr_sects);
+		       CURRENT->sector, ps2esdi[minor(CURRENT->rq_dev)].nr_sects);
 		end_request(FAIL);
 	}
 
@@ -849,7 +849,7 @@
 	switch (int_ret_code & 0x0f) {
 	case INT_TRANSFER_REQ:
 		ps2esdi_prep_dma(CURRENT->buffer, CURRENT->current_nr_sectors,
-		    (CURRENT->cmd == READ)
+		    (rq_data_dir(CURRENT) == READ)
 		    ? MCA_DMA_MODE_16 | MCA_DMA_MODE_WRITE | MCA_DMA_MODE_XFER
 		    : MCA_DMA_MODE_16 | MCA_DMA_MODE_READ);
 		outb(CTRL_ENABLE_DMA | CTRL_ENABLE_INTR, ESDI_CONTROL);

