Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273135AbRIJBmm>; Sun, 9 Sep 2001 21:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273132AbRIJBmf>; Sun, 9 Sep 2001 21:42:35 -0400
Received: from hera.cwi.nl ([192.16.191.8]:56810 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S273136AbRIJBmU>;
	Sun, 9 Sep 2001 21:42:20 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 10 Sep 2001 03:42:39 +0200 (MET DST)
Message-Id: <200109100142.DAA12898@boragie.ins.cwi.nl>
To: torvalds@transmeta.com
Subject: [PATCH] minor corrections to 2.4.10-pre6
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seeing that some version of my 07 patch made it into 2.4.10-pre6
I compared and noticed a few minor flaws:
- in DAC960.c and nftlcore.c unused variables have not been deleted
- in ps2esdi.c a semicolon is missing
- in hd.c add_gendisk() has a parameter too many
- in nftlcore.c there is a spurious :

Andries

[I hope to submit the rest of 07 some other time -
there is nothing controversial in the rest I think,
all could have been applied at once.]


diff -u --recursive --new-file ../linux-2.4.10-pre6/linux/drivers/block/DAC960.c ./linux/drivers/block/DAC960.c
--- ../linux-2.4.10-pre6/linux/drivers/block/DAC960.c	Sun Sep  9 14:28:41 2001
+++ ./linux/drivers/block/DAC960.c	Mon Sep 10 03:13:43 2001
@@ -1883,7 +1883,6 @@
 static boolean DAC960_RegisterBlockDevice(DAC960_Controller_T *Controller)
 {
   int MajorNumber = DAC960_MAJOR + Controller->ControllerNumber;
-  GenericDiskInfo_T *GenericDiskInfo;
   RequestQueue_T *RequestQueue;
   int MinorNumber;
   /*
diff -u --recursive --new-file ../linux-2.4.10-pre6/linux/drivers/block/ps2esdi.c ./linux/drivers/block/ps2esdi.c
--- ../linux-2.4.10-pre6/linux/drivers/block/ps2esdi.c	Sun Sep  9 14:28:41 2001
+++ ./linux/drivers/block/ps2esdi.c	Mon Sep 10 03:15:44 2001
@@ -222,14 +222,13 @@
 void
 cleanup_module(void)
 {
-	if(ps2esdi_slot)
-	{
+	if(ps2esdi_slot) {
 		mca_mark_as_unused(ps2esdi_slot);
 		mca_set_adapter_procfn(ps2esdi_slot, NULL, NULL);
 	}
 	release_region(io_base, 4);
 	free_dma(dma_arb_level);
-  	free_irq(PS2ESDI_IRQ, NULL)
+  	free_irq(PS2ESDI_IRQ, NULL);
 	devfs_unregister_blkdev(MAJOR_NR, "ed");
 	del_gendisk(&ps2esdi_gendisk);
 	blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
diff -u --recursive --new-file ../linux-2.4.10-pre6/linux/drivers/ide/hd.c ./linux/drivers/ide/hd.c
--- ../linux-2.4.10-pre6/linux/drivers/ide/hd.c	Sun Sep  9 14:28:43 2001
+++ ./linux/drivers/ide/hd.c	Mon Sep 10 03:06:35 2001
@@ -842,7 +842,7 @@
 	}
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
 	read_ahead[MAJOR_NR] = 8;		/* 8 sector (4kB) read-ahead */
-	add_gendisk(&hd_gendisk, MAJOR_NR);
+	add_gendisk(&hd_gendisk);
 	init_timer(&device_timer);
 	device_timer.function = hd_times_out;
 	hd_geninit();
diff -u --recursive --new-file ../linux-2.4.10-pre6/linux/drivers/mtd/nftlcore.c ./linux/drivers/mtd/nftlcore.c
--- ../linux-2.4.10-pre6/linux/drivers/mtd/nftlcore.c	Sun Sep  9 14:28:44 2001
+++ ./linux/drivers/mtd/nftlcore.c	Mon Sep 10 03:21:36 2001
@@ -1024,11 +1024,6 @@
  *
  ****************************************************************************/
 
-#if LINUX_VERSION_CODE < 0x20212 && defined(MODULE)
-#define init_nftl init_module
-#define cleanup_nftl cleanup_module
-#endif
-
 static struct mtd_notifier nftl_notifier = {
 	add:	NFTL_notify_add,
 	remove:	NFTL_notify_remove
@@ -1045,14 +1040,12 @@
 #endif
 
 	if (register_blkdev(MAJOR_NR, "nftl", &nftl_fops)){
-		printk("unable to register NFTL block device on major %d\n", MAJOR_NR);
+		printk("unable to register NFTL block device on major %d\n",
+		       MAJOR_NR);
 		return -EBUSY;
 	} else {
-#if LINUX_VERSION_CODE < 0x20320
-		blk_dev[MAJOR_NR].request_fn = nftl_request;
-#else
 		blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), &nftl_request);
-#endif
+
 		/* set block size to 1kB each */
 		for (i = 0; i < 256; i++) {
 			nftl_blocksizes[i] = 1024;
@@ -1069,20 +1062,12 @@
 
 static void __exit cleanup_nftl(void)
 {
-	struct gendisk *gd, **gdp;
-
   	unregister_mtd_user(&nftl_notifier);
   	unregister_blkdev(MAJOR_NR, "nftl");
   	
-#if LINUX_VERSION_CODE < 0x20320
-  	blk_dev[MAJOR_NR].request_fn = 0;
-#else
   	blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
-#endif	
 
-	/* remove ourself from generic harddisk list
-	   FIXME: why can't I found this partition on /proc/partition */
-	del_gendisk(&nftl_gendisk);:
+	del_gendisk(&nftl_gendisk);
 }
 
 module_init(init_nftl);
