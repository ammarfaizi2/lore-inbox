Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264594AbRFTT6t>; Wed, 20 Jun 2001 15:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264596AbRFTT6j>; Wed, 20 Jun 2001 15:58:39 -0400
Received: from hera.cwi.nl ([192.16.191.8]:46734 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S264594AbRFTT6a>;
	Wed, 20 Jun 2001 15:58:30 -0400
Date: Wed, 20 Jun 2001 21:58:24 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200106201958.VAA343451.aeb@vlet.cwi.nl>
To: alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com
Subject: [PATCH] remove null register_disk
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In fs/partitions/check.c we read

void register_disk(struct gendisk *gdev, kdev_t dev, unsigned minors,
        struct block_device_operations *ops, long size)
{
        if (!gdev)
                return;
        grok_partitions(gdev, MINOR(dev)>>gdev->minor_shift, minors, size);
}

showing that register_disk is void when its first argument is NULL.
This allows one to remove some dead code.
Can be applied to 2.4. No behaviour is changed.

(I sent patch 01, adding set blocksize ioctls - hope you applied it.
And patch 02, adding blkdev_get_size_in_bytes - hope you didnt,
ftp.kernel.org has the right version but I mailed a version with typo.
This is patch 05, independent of earlier ones, an attempt to break 1+MB
of patch into meaningful small fragments that each improve something.)

Andries


diff -u --recursive --new-file ../linux-2.4.6-pre3/linux/arch/m68k/atari/stram.c ./linux/arch/m68k/atari/stram.c
--- ../linux-2.4.6-pre3/linux/arch/m68k/atari/stram.c	Fri Feb  9 20:29:44 2001
+++ ./linux/arch/m68k/atari/stram.c	Wed Jun 20 21:35:56 2001
@@ -1067,8 +1067,6 @@
     blksize_size[STRAM_MAJOR] = stram_blocksizes;
 	stram_sizes[STRAM_MINOR] = (swap_end - swap_start)/1024;
     blk_size[STRAM_MAJOR] = stram_sizes;
-	register_disk(NULL, MKDEV(STRAM_MAJOR, STRAM_MINOR), 1, &stram_fops,
-			(swap_end-swap_start)>>9);
 	return( 0 );
 }
 
diff -u --recursive --new-file ../linux-2.4.6-pre3/linux/drivers/block/floppy.c ./linux/drivers/block/floppy.c
--- ../linux-2.4.6-pre3/linux/drivers/block/floppy.c	Fri Feb  9 20:30:22 2001
+++ ./linux/drivers/block/floppy.c	Wed Jun 20 21:35:56 2001
@@ -4268,15 +4268,6 @@
 		devfs_unregister_blkdev(MAJOR_NR,"fd");
 	}
 	
-	for (drive = 0; drive < N_DRIVE; drive++) {
-		if (!(allowed_drive_mask & (1 << drive)))
-			continue;
-		if (fdc_state[FDC(drive)].version == FDC_NONE)
-			continue;
-		for (i = 0; i<NUMBER(floppy_type); i++)
-			register_disk(NULL, MKDEV(MAJOR_NR,TOMINOR(drive)+i*4),
-					1, &floppy_fops, 0);
-	}
 	return have_no_fdc;
 }
 
diff -u --recursive --new-file ../linux-2.4.6-pre3/linux/drivers/block/loop.c ./linux/drivers/block/loop.c
--- ../linux-2.4.6-pre3/linux/drivers/block/loop.c	Wed Jun 13 09:20:58 2001
+++ ./linux/drivers/block/loop.c	Wed Jun 20 21:35:56 2001
@@ -1007,8 +1007,6 @@
 	memset(loop_blksizes, 0, max_loop * sizeof(int));
 	blk_size[MAJOR_NR] = loop_sizes;
 	blksize_size[MAJOR_NR] = loop_blksizes;
-	for (i = 0; i < max_loop; i++)
-		register_disk(NULL, MKDEV(MAJOR_NR, i), 1, &lo_fops, 0);
 
 	printk(KERN_INFO "loop: loaded (max %d devices)\n", max_loop);
 	return 0;
diff -u --recursive --new-file ../linux-2.4.6-pre3/linux/drivers/block/nbd.c ./linux/drivers/block/nbd.c
--- ../linux-2.4.6-pre3/linux/drivers/block/nbd.c	Tue May  1 23:20:25 2001
+++ ./linux/drivers/block/nbd.c	Wed Jun 20 21:35:56 2001
@@ -513,8 +513,6 @@
 		nbd_blksize_bits[i] = 10;
 		nbd_bytesizes[i] = 0x7ffffc00; /* 2GB */
 		nbd_sizes[i] = nbd_bytesizes[i] >> BLOCK_SIZE_BITS;
-		register_disk(NULL, MKDEV(MAJOR_NR,i), 1, &nbd_fops,
-				nbd_bytesizes[i]>>9);
 	}
 	devfs_handle = devfs_mk_dir (NULL, "nbd", NULL);
 	devfs_register_series (devfs_handle, "%u", MAX_NBD,
diff -u --recursive --new-file ../linux-2.4.6-pre3/linux/drivers/block/paride/pf.c ./linux/drivers/block/paride/pf.c
--- ../linux-2.4.6-pre3/linux/drivers/block/paride/pf.c	Sun Feb  4 19:05:29 2001
+++ ./linux/drivers/block/paride/pf.c	Wed Jun 20 21:35:56 2001
@@ -415,8 +415,6 @@
         
 	for (i=0;i<PF_UNITS;i++) pf_blocksizes[i] = 1024;
 	blksize_size[MAJOR_NR] = pf_blocksizes;
-	for (i=0;i<PF_UNITS;i++)
-		register_disk(NULL, MKDEV(MAJOR_NR, i), 1, &pf_fops, 0);
 
         return 0;
 }
diff -u --recursive --new-file ../linux-2.4.6-pre3/linux/drivers/block/rd.c ./linux/drivers/block/rd.c
--- ../linux-2.4.6-pre3/linux/drivers/block/rd.c	Fri Feb  9 20:30:22 2001
+++ ./linux/drivers/block/rd.c	Wed Jun 20 21:35:56 2001
@@ -420,9 +420,6 @@
 			       S_IFBLK | S_IRUSR | S_IWUSR,
 			       &fd_fops, NULL);
 
-	for (i = 0; i < NUM_RAMDISKS; i++)
-		register_disk(NULL, MKDEV(MAJOR_NR,i), 1, &fd_fops, rd_size<<1);
-
 #ifdef CONFIG_BLK_DEV_INITRD
 	/* We ought to separate initrd operations here */
 	register_disk(NULL, MKDEV(MAJOR_NR,INITRD_MINOR), 1, &fd_fops, rd_size<<1);
diff -u --recursive --new-file ../linux-2.4.6-pre3/linux/drivers/cdrom/aztcd.c ./linux/drivers/cdrom/aztcd.c
--- ../linux-2.4.6-pre3/linux/drivers/cdrom/aztcd.c	Fri Oct 27 08:35:47 2000
+++ ./linux/drivers/cdrom/aztcd.c	Wed Jun 20 21:35:56 2001
@@ -1804,7 +1804,6 @@
 	blksize_size[MAJOR_NR] = aztcd_blocksizes;
 #endif
 	read_ahead[MAJOR_NR] = 4;
-	register_disk(NULL, MKDEV(MAJOR_NR,0), 1, &azt_fops, 0);
 
         if ((azt_port==0x1f0)||(azt_port==0x170))  
 	   request_region(azt_port, 8, "aztcd");  /*IDE-interface*/
diff -u --recursive --new-file ../linux-2.4.6-pre3/linux/drivers/cdrom/gscd.c ./linux/drivers/cdrom/gscd.c
--- ../linux-2.4.6-pre3/linux/drivers/cdrom/gscd.c	Fri Feb  9 20:30:22 2001
+++ ./linux/drivers/cdrom/gscd.c	Wed Jun 20 21:35:56 2001
@@ -1092,7 +1092,6 @@
         gscdPresent = 1;
 
 	request_region(gscd_port, 4, "gscd");
-	register_disk(NULL, MKDEV(MAJOR_NR,0), 1, &gscd_fops, 0);
 
         printk (KERN_INFO "GSCD: GoldStar CD-ROM Drive found.\n" );
 	return 0;
diff -u --recursive --new-file ../linux-2.4.6-pre3/linux/drivers/cdrom/optcd.c ./linux/drivers/cdrom/optcd.c
--- ../linux-2.4.6-pre3/linux/drivers/cdrom/optcd.c	Sun Feb  4 19:05:29 2001
+++ ./linux/drivers/cdrom/optcd.c	Wed Jun 20 21:35:56 2001
@@ -2071,7 +2071,6 @@
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
 	read_ahead[MAJOR_NR] = 4;
 	request_region(optcd_port, 4, "optcd");
-	register_disk(NULL, MKDEV(MAJOR_NR,0), 1, &opt_fops, 0);
 
 	printk(KERN_INFO "optcd: DOLPHIN 8000 AT CDROM at 0x%x\n", optcd_port);
 	return 0;
diff -u --recursive --new-file ../linux-2.4.6-pre3/linux/drivers/cdrom/sjcd.c ./linux/drivers/cdrom/sjcd.c
--- ../linux-2.4.6-pre3/linux/drivers/cdrom/sjcd.c	Fri Oct 27 08:35:48 2000
+++ ./linux/drivers/cdrom/sjcd.c	Wed Jun 20 21:35:56 2001
@@ -1480,7 +1480,6 @@
   
   blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
   read_ahead[ MAJOR_NR ] = 4;
-  register_disk(NULL, MKDEV(MAJOR_NR,0), 1, &sjcd_fops, 0);
   
   if( check_region( sjcd_base, 4 ) ){
     printk( "SJCD: Init failed, I/O port (%X) is already in use\n",
diff -u --recursive --new-file ../linux-2.4.6-pre3/linux/drivers/cdrom/sonycd535.c ./linux/drivers/cdrom/sonycd535.c
--- ../linux-2.4.6-pre3/linux/drivers/cdrom/sonycd535.c	Fri Feb  9 20:30:22 2001
+++ ./linux/drivers/cdrom/sonycd535.c	Wed Jun 20 21:35:56 2001
@@ -1645,7 +1645,6 @@
 		return -EIO;
 	}
 	request_region(sony535_cd_base_io, 4, CDU535_HANDLE);
-	register_disk(NULL, MKDEV(MAJOR_NR,0), 1, &cdu_fops, 0);
 	return 0;
 }
 
diff -u --recursive --new-file ../linux-2.4.6-pre3/linux/drivers/sbus/char/jsflash.c ./linux/drivers/sbus/char/jsflash.c
--- ../linux-2.4.6-pre3/linux/drivers/sbus/char/jsflash.c	Fri Feb  9 20:30:23 2001
+++ ./linux/drivers/sbus/char/jsflash.c	Wed Jun 20 21:35:56 2001
@@ -672,8 +672,6 @@
 		jsfd_blksizes[i] = 1024;
 		jsfd_bytesizes[i] = jdp->dsize;
 		jsfd_sizes[i] = jsfd_bytesizes[i] >> 10;
-		register_disk(NULL, MKDEV(JSFD_MAJOR, i), 1, &jsfd_fops,
-				jsfd_bytesizes[i] >> 9);
 		set_device_ro(MKDEV(JSFD_MAJOR, i), 1);
 	}
 	return 0;
