Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264636AbRFUR5N>; Thu, 21 Jun 2001 13:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264635AbRFUR46>; Thu, 21 Jun 2001 13:56:58 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:51925 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S265076AbRFUR4i>;
	Thu, 21 Jun 2001 13:56:38 -0400
Date: Thu, 21 Jun 2001 13:56:34 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andries.Brouwer@cwi.nl
cc: linux-kernel@vger.kernel.org
Subject: Re: more gendisk stuff
In-Reply-To: <UTC200106211739.TAA370687.aeb@vlet.cwi.nl>
Message-ID: <Pine.GSO.4.21.0106211352110.29802-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 21 Jun 2001 Andries.Brouwer@cwi.nl wrote:

> Al, I don't know whether you are interested in this stuff, but comments
> (other than: "the stuff is full of races") are welcome.

No comments on races, but there's obvious one on API: doing that on
per-major basis is _wrong_.  That's why register_disk() takes device
number + range instead of major.  Here's an old patch that should
demonstrate what register_disk() is supposed to do:

diff -urN linux-2.3.41/arch/m68k/atari/stram.c linux-bird.bdev/arch/m68k/atari/stram.c
--- linux-2.3.41/arch/m68k/atari/stram.c	Fri Jan 28 21:45:36 2000
+++ linux-bird.bdev/arch/m68k/atari/stram.c	Tue Feb  1 04:07:32 2000
@@ -1255,9 +1255,9 @@
     blksize_size[STRAM_MAJOR] = stram_blocksizes;
 	stram_sizes[STRAM_MINOR] = (swap_end - swap_start)/1024;
     blk_size[STRAM_MAJOR] = stram_sizes;
-	register_disk(NULL, MKDEV(STRAM_MAJOR, STRAM_MINOR), 1, &stram_fops,
-			(swap_end-swap_start)>>9);
 	do_z2_request(); /* to avoid warning */
+	register_disk(NULL, BDEV(STRAM_MAJOR, STRAM_MINOR), 1, &stram_fops,
+			(swap_end-swap_start)>>9);
 	return( 0 );
 }
 
diff -urN linux-2.3.41/drivers/acorn/block/fd1772.c linux-bird.bdev/drivers/acorn/block/fd1772.c
--- linux-2.3.41/drivers/acorn/block/fd1772.c	Tue Jan 11 00:21:04 2000
+++ linux-bird.bdev/drivers/acorn/block/fd1772.c	Tue Feb  1 04:07:32 2000
@@ -1636,6 +1636,13 @@
 
 	config_types();
 
+	for (i=0; i< FD_MAX_UNITS; i++) {
+		int type;
+		for (type = 0; type <= NUM_DISK_TYPES; type++)
+			register_disk(NULL, BDEV(MAJOR_NR, type*4+i), 1,
+					&floppy_fops, 0);
+	}
+
 	return 0;
 }
 
diff -urN linux-2.3.41/drivers/acorn/block/mfmhd.c linux-bird.bdev/drivers/acorn/block/mfmhd.c
--- linux-2.3.41/drivers/acorn/block/mfmhd.c	Thu Jan 20 22:47:22 2000
+++ linux-bird.bdev/drivers/acorn/block/mfmhd.c	Tue Feb  1 04:07:32 2000
@@ -1356,7 +1356,7 @@
 
 	for (i = 0; i < mfm_drives; i++) {
 		mfm_geometry (i);
-		register_disk(&mfm_gendisk, MKDEV(MAJOR_NR,i<<6), 1<<6,
+		register_disk(&mfm_gendisk, BDEV(MAJOR_NR,i<<6), 1<<6,
 				&mfm_fops,
 				mfm_info[i].cylinders * mfm_info[i].heads *
 				mfm_info[i].sectors / 2);
diff -urN linux-2.3.41/drivers/ap1000/ap.c linux-bird.bdev/drivers/ap1000/ap.c
--- linux-2.3.41/drivers/ap1000/ap.c	Thu Jan 20 22:47:22 2000
+++ linux-bird.bdev/drivers/ap1000/ap.c	Tue Feb  1 04:07:32 2000
@@ -275,7 +275,7 @@
 
   read_ahead[MAJOR_NR] = 32; /* 16k read ahead */
   for (i=0;i<NUM_APDEVS;i++)
-	register_disk(NILL, MKDEV(MAJOR_NR,i), 1, &ap_fops, 0);
+	register_disk(NILL, BDEV(MAJOR_NR,i), 1, &ap_fops, 0);
 
   return(0);
 }
diff -urN linux-2.3.41/drivers/ap1000/ddv.c linux-bird.bdev/drivers/ap1000/ddv.c
--- linux-2.3.41/drivers/ap1000/ddv.c	Thu Jan 20 22:47:22 2000
+++ linux-bird.bdev/drivers/ap1000/ddv.c	Tue Feb  1 04:07:32 2000
@@ -732,7 +732,7 @@
 	ddv_geometry.cylinders = ddv_sect_length[0] / 
 		(ddv_geometry.heads*ddv_geometry.sectors);
 
-	register_disk(&ddv_gendisk, MKDEV(MAJOR_NR,0), 1<<PARTN_BITS,
+	register_disk(&ddv_gendisk, BDEV(MAJOR_NR,0), 1<<PARTN_BITS,
 			&ddv_fops, ddv_sect_length[0]);
 	
 	/* FIXME. The crap below is, well, crap. Pseudo-RAID and unsafe one */
diff -urN linux-2.3.41/drivers/block/DAC960.c linux-bird.bdev/drivers/block/DAC960.c
--- linux-2.3.41/drivers/block/DAC960.c	Fri Jan 28 21:45:37 2000
+++ linux-bird.bdev/drivers/block/DAC960.c	Tue Feb  1 04:07:32 2000
@@ -2944,7 +2944,7 @@
   for (LogicalDriveNumber = 0;
        LogicalDriveNumber < Controller->LogicalDriveCount;
        LogicalDriveNumber++)
-	register_disk(GenericDiskInfo, MKDEV(GenericDiskInfo->major,
+	register_disk(GenericDiskInfo, BDEV(GenericDiskInfo->major,
 				       LogicalDriveNumber*DAC960_MaxPartitions),
 		DAC960_MaxPartitions, &DAC960_FileOperations,
 		LogicalDriveInformation[LogicalDriveNumber].LogicalDriveSize);
diff -urN linux-2.3.41/drivers/block/acsi.c linux-bird.bdev/drivers/block/acsi.c
--- linux-2.3.41/drivers/block/acsi.c	Thu Jan 20 22:47:23 2000
+++ linux-bird.bdev/drivers/block/acsi.c	Tue Feb  1 05:44:44 2000
@@ -106,6 +106,8 @@
 	NONE, HARDDISK, CDROM
 } ACSI_TYPE;
 
+static struct block_driver *acsi_driver;
+
 struct acsi_info_struct {
 	ACSI_TYPE		type;			/* type of device */
 	unsigned		target;			/* target number */
@@ -1746,11 +1748,15 @@
 	for( i = 0; i < (MAX_DEV << 4); i++ )
 		acsi_blocksizes[i] = 1024;
 	blksize_size[MAJOR_NR] = acsi_blocksizes;
-	for( i = 0; i < NDevices; ++i )
-		register_disk(&acsi_gendisk, MKDEV(MAJOR_NR,i<<4),
-				(acsi_info[i].type==HARDDISK)?1<<4:1,
-				&acsi_fops,
-				acsi_info[i].size);
+	for( i = 0; i < NDevices; ++i ) {
+		struct disk_struct *disk;
+		disk = register_disk(acsi_driver, &acsi_gendisk,
+				     BDEV(MAJOR_NR,i<<4),
+				     (acsi_info[i].type==HARDDISK)?1<<4:1,
+				     &acsi_fops);
+		disk->sectors = acsi_info[i].size;
+		parse_partitions(disk);
+	}
 	acsi_gendisk.nr_real = NDevices;
 }
 
@@ -1777,7 +1783,8 @@
 	if (!MACH_IS_ATARI || !ATARIHW_PRESENT(ACSI))
 		return 0;
 
-	if (register_blkdev( MAJOR_NR, "ad", &acsi_fops )) {
+	acsi_driver = register_block_driver("ad", MAJOR_NR);
+	if (IS_ERR(acsi_driver)) {
 		printk( KERN_ERR "Unable to get major %d for ACSI\n", MAJOR_NR );
 		return -EBUSY;
 	}
@@ -1785,7 +1792,7 @@
 	if (!(acsi_buffer =
 		  (char *)atari_stram_alloc( ACSI_BUFFER_SIZE, NULL, "acsi" ))) {
 		printk( KERN_ERR "Unable to get ACSI ST-Ram buffer.\n" );
-		unregister_blkdev( MAJOR_NR, "ad" );
+		unregister_block_driver(acsi_driver);
 		return -ENOMEM;
 	}
 	phys_acsi_buffer = virt_to_phys( acsi_buffer );
@@ -1801,6 +1808,7 @@
 #endif
 	if (!err)
 		acsi_geninit();
+	range_unlock(acsi_driver->range);
 	return err;
 }
 
@@ -1824,7 +1832,7 @@
 	blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
 	atari_stram_free( acsi_buffer );
 
-	if (unregister_blkdev( MAJOR_NR, "ad" ) != 0)
+	if (unregister_block_driver(acsi_driver) != 0)
 		printk( KERN_ERR "acsi: cleanup_module failed\n");
 
 	for (gdp = &gendisk_head; *gdp; gdp = &((*gdp)->next))
diff -urN linux-2.3.41/drivers/block/amiflop.c linux-bird.bdev/drivers/block/amiflop.c
--- linux-2.3.41/drivers/block/amiflop.c	Fri Jan 28 21:45:37 2000
+++ linux-bird.bdev/drivers/block/amiflop.c	Tue Feb  1 05:03:20 2000
@@ -114,6 +114,7 @@
 #define FD_HD_3 	0x55555555  /* high-density 3.5" (1760K) drive */
 #define FD_DD_5 	0xaaaaaaaa  /* double-density 5.25" (440K) drive */
 
+static struct block_driver *fd_driver;
 static long int fd_def_df0 = FD_DD_3;     /* default for df0 if it doesn't identify */
 
 MODULE_PARM(fd_def_df0,"l");
@@ -1790,7 +1791,8 @@
 	if (!AMIGAHW_PRESENT(AMI_FLOPPY))
 		return -ENXIO;
 
-	if (register_blkdev(MAJOR_NR,"fd",&floppy_fops)) {
+	fd_driver = register_block_driver("fd", MAJOR_NR);
+	if (IS_ERR(fd_driver)) {
 		printk("fd: Unable to get major %d for floppy\n",MAJOR_NR);
 		return -EBUSY;
 	}
@@ -1798,28 +1800,28 @@
 	if ((raw_buf = (char *)amiga_chip_alloc (RAW_BUF_SIZE, "Floppy")) ==
 	    NULL) {
 		printk("fd: cannot get chip mem buffer\n");
-		unregister_blkdev(MAJOR_NR,"fd");
+		unregister_block_driver(fd_driver);
 		return -ENOMEM;
 	}
 
 	if (request_irq(IRQ_AMIGA_DSKBLK, fd_block_done, 0, "floppy_dma", NULL)) {
 		printk("fd: cannot get irq for dma\n");
 		amiga_chip_free(raw_buf);
-		unregister_blkdev(MAJOR_NR,"fd");
+		unregister_block_driver(fd_driver);
 		return -EBUSY;
 	}
 	if (request_irq(IRQ_AMIGA_CIAA_TB, ms_isr, 0, "floppy_timer", NULL)) {
 		printk("fd: cannot get irq for timer\n");
 		free_irq(IRQ_AMIGA_DSKBLK, NULL);
 		amiga_chip_free(raw_buf);
-		unregister_blkdev(MAJOR_NR,"fd");
+		unregister_block_driver(fd_driver);
 		return -EBUSY;
 	}
 	if (fd_probe_drives() < 1) { /* No usable drives */
 		free_irq(IRQ_AMIGA_CIAA_TB, NULL);
 		free_irq(IRQ_AMIGA_DSKBLK, NULL);
 		amiga_chip_free(raw_buf);
-		unregister_blkdev(MAJOR_NR,"fd");
+		unregister_block_driver(fd_driver);
 		return -ENXIO;
 	}
 
@@ -1865,7 +1867,11 @@
 	/* init ms timer */
 	ciaa.crb = 8; /* one-shot, stop */
 
+	for (i=0; i<8; i++)
+		register_disk(fd_driver,NULL,BDEV(MAJOR_NR,i),1,&floppy_fops);
+
 	(void)do_floppy; /* avoid warning about unused variable */
+	range_unlock(fd_driver->range);
 	return 0;
 }
 
@@ -1893,6 +1899,6 @@
 	blk_size[MAJOR_NR] = NULL;
 	blksize_size[MAJOR_NR] = NULL;
 	blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
-	unregister_blkdev(MAJOR_NR, "fd");
+	unregister_block_driver(fd_driver);
 }
 #endif
diff -urN linux-2.3.41/drivers/block/ataflop.c linux-bird.bdev/drivers/block/ataflop.c
--- linux-2.3.41/drivers/block/ataflop.c	Tue Jan 11 00:21:05 2000
+++ linux-bird.bdev/drivers/block/ataflop.c	Tue Feb  1 05:11:40 2000
@@ -99,6 +99,8 @@
 
 #undef DEBUG
 
+static struct block_driver *fd_driver;
+
 /* Disk types: DD, HD, ED */
 static struct atari_disk_type {
 	const char	*name;
@@ -1974,7 +1976,8 @@
 		/* Hades doesn't have Atari-compatible floppy */
 		return -ENXIO;
 
-	if (register_blkdev(MAJOR_NR,"fd",&floppy_fops)) {
+	fd_driver = register_block_driver("fd", MAJOR_NR);
+	if (IS_ERR(fd_driver)) {
 		printk(KERN_ERR "Unable to get major %d for floppy\n",MAJOR_NR);
 		return -EBUSY;
 	}
@@ -1997,7 +2000,7 @@
 	DMABuffer = atari_stram_alloc( BUFFER_SIZE+512, NULL, "ataflop" );
 	if (!DMABuffer) {
 		printk(KERN_ERR "atari_floppy_init: cannot get dma buffer\n");
-		unregister_blkdev(MAJOR_NR, "fd");
+		unregister_block_driver(fd_driver);
 		return -ENOMEM;
 	}
 	TrackBuffer = DMABuffer + 512;
@@ -2026,6 +2029,14 @@
 	       UseTrackbuffer ? "" : "no ");
 	config_types();
 
+	for (i=0; i< FD_MAX_UNITS; i++) {
+		int type;
+		for (type = 0; type <= NUM_DISK_MINORS; type++)
+			register_disk(fd_driver, NULL,
+				      BDEV(MAJOR_NR,type*4+i), 1, &floppy_fops);
+	}
+
+	range_unlock(fd_driver->range);
 	(void)do_floppy; /* avoid warning about unused variable */
 	return 0;
 }
@@ -2069,7 +2080,7 @@
 
 void cleanup_module (void)
 {
-	unregister_blkdev(MAJOR_NR, "fd");
+	unregister_block_driver(fd_driver);
 
 	blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
 	timer_active &= ~(1 << FLOPPY_TIMER);
diff -urN linux-2.3.41/drivers/block/cpqarray.c linux-bird.bdev/drivers/block/cpqarray.c
--- linux-2.3.41/drivers/block/cpqarray.c	Thu Jan 20 22:47:23 2000
+++ linux-bird.bdev/drivers/block/cpqarray.c	Tue Feb  1 04:07:33 2000
@@ -480,7 +480,7 @@
 
 		ida_geninit(i);
 		for(j=0; j<NWD; j++)	
-			register_disk(&ida_gendisk[i], MKDEV(MAJOR_NR+i,j<<4),
+			register_disk(&ida_gendisk[i], BDEV(MAJOR_NR+i,j<<4),
 					16, &ida_fops, hba[i]->drv[j].nr_blks);
 	}
 	/* done ! */
diff -urN linux-2.3.41/drivers/block/floppy.c linux-bird.bdev/drivers/block/floppy.c
--- linux-2.3.41/drivers/block/floppy.c	Thu Jan 20 22:47:23 2000
+++ linux-bird.bdev/drivers/block/floppy.c	Tue Feb  1 04:36:15 2000
@@ -135,6 +135,7 @@
 static int allowed_drive_mask = 0x33;
 static int irqdma_allocated = 0;
  
+static struct block_driver *floppy_driver;
 
 #include <linux/sched.h>
 #include <linux/fs.h>
@@ -4053,7 +4054,9 @@
 
 	raw_cmd = 0;
 
-	if (register_blkdev(MAJOR_NR,"fd",&floppy_fops)) {
+	floppy_driver = register_block_driver("fd", MAJOR_NR);
+
+	if (IS_ERR(floppy_driver)) {
 		printk("Unable to get major %d for floppy\n",MAJOR_NR);
 		return -EBUSY;
 	}
@@ -4084,7 +4087,7 @@
 	use_virtual_dma = can_use_virtual_dma & 1;
 	fdc_state[0].address = FDC1;
 	if (fdc_state[0].address == -1) {
-		unregister_blkdev(MAJOR_NR,"fd");
+		unregister_block_driver(floppy_driver);
 		del_timer(&fd_timeout);
 		return -ENODEV;
 	}
@@ -4096,7 +4099,7 @@
 	if (floppy_grab_irq_and_dma()){
 		del_timer(&fd_timeout);
 		blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
-		unregister_blkdev(MAJOR_NR,"fd");
+		unregister_block_driver(floppy_driver);
 		del_timer(&fd_timeout);
 		return -EBUSY;
 	}
@@ -4162,7 +4165,7 @@
  		if (usage_count)
  			floppy_release_irq_and_dma();
 		blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
-		unregister_blkdev(MAJOR_NR,"fd");		
+		unregister_block_driver(floppy_driver);
 	}
 	
 	for (drive = 0; drive < N_DRIVE; drive++) {
@@ -4171,9 +4174,11 @@
 		if (fdc_state[FDC(drive)].version == FDC_NONE)
 			continue;
 		for (i = 0; i<NUMBER(floppy_type); i++)
-			register_disk(NULL, MKDEV(MAJOR_NR,TOMINOR(drive)+i*4),
-					1, &floppy_fops, 0);
+			register_disk(floppy_driver, NULL,
+				      BDEV(MAJOR_NR,TOMINOR(drive)+i*4), 1,
+				      &floppy_fops);
 	}
+	range_unlock(floppy_driver->range);
 	return have_no_fdc;
 }
 
@@ -4391,7 +4396,7 @@
 {
 	int dummy;
 		
-	unregister_blkdev(MAJOR_NR, "fd");
+	unregister_block_driver(floppy_driver);
 
 	blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
 	/* eject disk, if any */
diff -urN linux-2.3.41/drivers/block/hd.c linux-bird.bdev/drivers/block/hd.c
--- linux-2.3.41/drivers/block/hd.c	Thu Jan 20 22:47:23 2000
+++ linux-bird.bdev/drivers/block/hd.c	Tue Feb  1 04:35:49 2000
@@ -73,6 +73,8 @@
 static void recal_intr(void);
 static void bad_rw_intr(void);
 
+static struct block_driver *hd_driver;
+
 static char recalibrate[MAX_HD];
 static char special_op[MAX_HD];
 static int access_count[MAX_HD];
@@ -792,15 +794,21 @@
 
 	hd_gendisk.nr_real = NR_HD;
 
-	for(drive=0; drive < NR_HD; drive++)
-		register_disk(&hd_gendisk, MKDEV(MAJOR_NR,drive<<6), 1<<6,
-			&hd_fops, hd_info[drive].head * hd_info[drive].sect *
-			hd_info[drive].cyl);
+	for(drive=0; drive < NR_HD; drive++) {
+		struct disk_struct *disk
+		disk = register_disk(hd_driver, &hd_gendisk,
+				     BDEV(MAJOR_NR,drive<<6), 1<<6,
+				     &hd_fops); 
+		disk->sectors = hd_info[drive].head * hd_info[drive].sect *
+				hd_info[drive].cyl;
+		parse_partitions(disk);
+	}
 }
 
 int __init hd_init(void)
 {
-	if (register_blkdev(MAJOR_NR,"hd",&hd_fops)) {
+	hd_driver = register_block_driver("hd", MAJOR_NR);
+	if (IS_ERR(hd_driver) {
 		printk("hd: unable to get major %d for hard disk\n",MAJOR_NR);
 		return -1;
 	}
@@ -810,6 +818,7 @@
 	gendisk_head = &hd_gendisk;
 	timer_table[HD_TIMER].fn = hd_times_out;
 	hd_geninit();
+	range_unlock(hd_driver->range);
 	return 0;
 }
 
diff -urN linux-2.3.41/drivers/block/ide-probe.c linux-bird.bdev/drivers/block/ide-probe.c
--- linux-2.3.41/drivers/block/ide-probe.c	Fri Jan 28 21:45:38 2000
+++ linux-bird.bdev/drivers/block/ide-probe.c	Tue Feb  1 04:07:33 2000
@@ -756,11 +756,14 @@
 		printk("%s: request_fn NOT DEFINED\n", hwif->name);
 		return (hwif->present = 0);
 	}
+
+/*
 	if (register_blkdev (hwif->major, hwif->name, ide_fops)) {
 		printk("%s: UNABLE TO GET MAJOR NUMBER %d\n", hwif->name, hwif->major);
 		return (hwif->present = 0);
 	}
-	
+*/
+
 	if (init_irq (hwif)) {
 		int i = hwif->irq;
 		/*
diff -urN linux-2.3.41/drivers/block/ide.c linux-bird.bdev/drivers/block/ide.c
--- linux-2.3.41/drivers/block/ide.c	Fri Jan 28 21:45:38 2000
+++ linux-bird.bdev/drivers/block/ide.c	Tue Feb  1 04:07:33 2000
@@ -156,6 +156,8 @@
 #include <linux/kmod.h>
 #endif /* CONFIG_KMOD */
 
+struct block_driver *ide_driver = NULL;
+
 #ifdef CONFIG_BLK_DEV_VIA82CXXX
 extern byte fifoconfig;		/* defined in via82cxxx.c used by ide_setup() */
 #endif /* CONFIG_BLK_DEV_VIA82CXXX */
@@ -554,22 +556,28 @@
 void ide_geninit (ide_hwif_t *hwif)
 {
 	unsigned int unit;
-	struct gendisk *gd = hwif->gd;
+	struct range_node * range;
+	range = block_area_add(ide_driver, BDEV(hwif->major, 0), 128);
 
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		ide_drive_t *drive = &hwif->drives[unit];
 
 		if (!drive->present)
 			continue;
-		if (drive->media!=ide_disk && drive->media!=ide_floppy)
+		if (drive->media!=ide_disk && drive->media!=ide_floppy &&
+		    drive->media!=ide_cdrom)
 			continue;
-		register_disk(gd,MKDEV(hwif->major,unit<<PARTN_BITS),
+		drive->disk = register_disk(
+			ide_driver,
+			hwif->gd,
+			BDEV(hwif->major,unit<<PARTN_BITS),
 #ifdef CONFIG_BLK_DEV_ISAPNP
 			(drive->forced_geom && drive->noprobe) ? 1 :
 #endif /* CONFIG_BLK_DEV_ISAPNP */
 			1<<PARTN_BITS, ide_fops,
 			current_capacity(drive));
 	}
+	range_unlock(range);
 }
 
 static ide_startstop_t do_reset1 (ide_drive_t *, int);		/* needed below */
@@ -1916,7 +1924,6 @@
 	ide_hwgroup_t *hwgroup;
 	int irq_count = 0, unit, i;
 	unsigned long flags;
-	unsigned int p, minor;
 	ide_hwif_t old_hwif;
 
 	if (index >= MAX_HWIFS)
@@ -1945,15 +1952,9 @@
 		drive = &hwif->drives[unit];
 		if (!drive->present)
 			continue;
-		minor = drive->select.b.unit << PARTN_BITS;
-		for (p = 0; p < (1<<PARTN_BITS); ++p) {
-			if (drive->part[p].nr_sects > 0) {
-				kdev_t devp = MKDEV(hwif->major, minor+p);
-				struct super_block * sb = get_super(devp);
-				if (sb) invalidate_inodes(sb);
-				invalidate_buffers (devp);
-			}
-		}
+		if (drive->disk)
+			unregister_disk(drive->disk);
+		drive->disk = NULL;
 #ifdef CONFIG_PROC_FS
 		destroy_proc_ide_drives(hwif);
 #endif
@@ -2020,7 +2021,7 @@
 	/*
 	 * Remove us from the kernel's knowledge
 	 */
-	unregister_blkdev(hwif->major, hwif->name);
+	block_area_remove(ide_driver, BDEV(hwif->major, 0));
 	kfree(blksize_size[hwif->major]);
 	kfree(max_sectors[hwif->major]);
 	kfree(max_readahead[hwif->major]);
@@ -3496,6 +3497,8 @@
 
 	init_ide_data ();
 
+	ide_driver = register_block_driver("ide", 0);
+
 	initializing = 1;
 	ide_init_builtin_drivers();
 	initializing = 0;
@@ -3552,6 +3555,7 @@
 #ifdef CONFIG_PROC_FS
 	proc_ide_destroy();
 #endif
+	unregister_block_driver(ide_driver);
 }
 
 #else /* !MODULE */
diff -urN linux-2.3.41/drivers/block/loop.c linux-bird.bdev/drivers/block/loop.c
--- linux-2.3.41/drivers/block/loop.c	Thu Jan 20 22:47:24 2000
+++ linux-bird.bdev/drivers/block/loop.c	Tue Feb  1 05:16:40 2000
@@ -69,6 +69,7 @@
 #include <linux/blk.h>
 
 #include <linux/malloc.h>
+static struct block_driver *loop_driver;
 static int max_loop = 8;
 static struct loop_device *loop_dev;
 static int *loop_sizes;
@@ -715,7 +716,8 @@
 {
 	int	i;
 
-	if (register_blkdev(MAJOR_NR, "loop", &lo_fops)) {
+	loop_driver = register_block_driver("loop", MAJOR_NR);
+	if (IS_ERR(loop_driver)) {
 		printk(KERN_WARNING "Unable to get major number %d for loop device\n",
 		       MAJOR_NR);
 		return -EIO;
@@ -760,15 +762,16 @@
 	blk_size[MAJOR_NR] = loop_sizes;
 	blksize_size[MAJOR_NR] = loop_blksizes;
 	for (i=0; i < max_loop; i++)
-		register_disk(NULL, MKDEV(MAJOR_NR,i), 1, &lo_fops, 0);
+		register_disk(loop_driver, NULL, BDEV(MAJOR_NR,i), 1, &lo_fops);
 
+	range_unlock(loop_driver->range);
 	return 0;
 }
 
 #ifdef MODULE
 void cleanup_module(void) 
 {
-	if (unregister_blkdev(MAJOR_NR, "loop") != 0)
+	if (unregister_block_driver(loop_driver) != 0)
 		printk(KERN_WARNING "loop: cannot unregister blkdev\n");
 
 	kfree (loop_dev);
diff -urN linux-2.3.41/drivers/block/md.c linux-bird.bdev/drivers/block/md.c
--- linux-2.3.41/drivers/block/md.c	Thu Jan 20 22:47:24 2000
+++ linux-bird.bdev/drivers/block/md.c	Tue Feb  1 05:13:43 2000
@@ -68,6 +68,7 @@
 extern kdev_t name_to_kdev_t(char *line) __init;
 #endif
 
+static struct block_driver *md_driver;
 static struct hd_struct md_hd_struct[MAX_MD_DEV];
 static int md_blocksizes[MAX_MD_DEV];
 int md_maxreadahead[MAX_MD_DEV];
@@ -916,7 +917,7 @@
     md_blocksizes[i] = 1024;
     md_maxreadahead[i] = MD_DEFAULT_DISK_READAHEAD;
     md_dev[i].pers=NULL;
-    register_disk(&md_gendisk, MKDEV(MAJOR_NR,i), 1, &md_fops, 0);
+    register_disk(md_driver, &md_gendisk, BDEV(MAJOR_NR,i), 1, &md_fops);
   }
 
 #ifdef CONFIG_PROC_FS
@@ -1229,7 +1230,8 @@
     MD_MAJOR_VERSION, MD_MINOR_VERSION, MD_PATCHLEVEL_VERSION,
     MAX_MD_DEV, MAX_REAL);
 
-  if (register_blkdev (MD_MAJOR, "md", &md_fops))
+  md_driver = register_block_driver("md", MD_MAJOR);
+  if (IS_ERR(md_driver))
   {
     printk ("Unable to get major %d for md\n", MD_MAJOR);
     return (-1);
diff -urN linux-2.3.41/drivers/block/nbd.c linux-bird.bdev/drivers/block/nbd.c
--- linux-2.3.41/drivers/block/nbd.c	Thu Jan 20 22:47:24 2000
+++ linux-bird.bdev/drivers/block/nbd.c	Tue Feb  1 05:38:25 2000
@@ -46,6 +46,7 @@
 
 #define LO_MAGIC 0x68797548
 
+static struct block_driver *nbd_driver;
 static int nbd_blksizes[MAX_NBD];
 static int nbd_blksize_bits[MAX_NBD];
 static int nbd_sizes[MAX_NBD];
@@ -469,7 +470,8 @@
 		return -EIO;
 	}
 
-	if (register_blkdev(MAJOR_NR, "nbd", &nbd_fops)) {
+	nbd_driver = register_block_device("nbd", MAJOR_NR);
+	if (IS_ERR(nbd_driver)) {
 		printk("Unable to get major number %d for NBD\n",
 		       MAJOR_NR);
 		return -EIO;
@@ -481,6 +483,7 @@
 	blk_size[MAJOR_NR] = nbd_sizes;
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), do_nbd_request);
 	for (i = 0; i < MAX_NBD; i++) {
+		struct disk_struct *disk;
 		nbd_dev[i].refcnt = 0;
 		nbd_dev[i].file = NULL;
 		nbd_dev[i].magic = LO_MAGIC;
@@ -489,16 +492,18 @@
 		nbd_blksize_bits[i] = 10;
 		nbd_bytesizes[i] = 0x7ffffc00; /* 2GB */
 		nbd_sizes[i] = nbd_bytesizes[i] >> nbd_blksize_bits[i];
-		register_disk(NULL, MKDEV(MAJOR_NR,i), 1, &nbd_fops,
-				nbd_bytesizes[i]>>9);
+		disk = register_disk(nbd_driver, NULL, BDEV(MAJOR_NR,i), 1,
+				     &nbd_fops);
+		disk->sectors = nbd_bytesizes[i]>>9;
 	}
+	range_unlock(nbd_driver->range);
 	return 0;
 }
 
 #ifdef MODULE
 void cleanup_module(void)
 {
-	if (unregister_blkdev(MAJOR_NR, "nbd") != 0)
+	if (unregister_block_driver(nbd_driver) != 0)
 		printk("nbd: cleanup_module failed\n");
 	else
 		printk("nbd: module cleaned up.\n");
diff -urN linux-2.3.41/drivers/block/paride/pcd.c linux-bird.bdev/drivers/block/paride/pcd.c
--- linux-2.3.41/drivers/block/paride/pcd.c	Mon Dec 13 02:00:35 1999
+++ linux-bird.bdev/drivers/block/paride/pcd.c	Tue Feb  1 04:07:33 2000
@@ -340,14 +340,17 @@
 		return -1;
 	}
 
-	for (unit=0;unit<PCD_UNITS;unit++)
-		if (PCD.present) register_cdrom(&PCD.info);
-
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
 	read_ahead[MAJOR_NR] = 8;	/* 8 sector (4kB) read ahead */
 
 	for (i=0;i<PCD_UNITS;i++) pcd_blocksizes[i] = 1024;
         blksize_size[MAJOR_NR] = pcd_blocksizes;
+
+	for (unit=0;unit<PCD_UNITS;unit++)
+		if (PCD.present) {
+			register_cdrom(&PCD.info);
+			register_disk(NULL,BDEV(major,unit),1,&cdrom_fops,0);
+		}
 
 	return 0;
 }
diff -urN linux-2.3.41/drivers/block/paride/pd.c linux-bird.bdev/drivers/block/paride/pd.c
--- linux-2.3.41/drivers/block/paride/pd.c	Thu Jan 20 22:47:24 2000
+++ linux-bird.bdev/drivers/block/paride/pd.c	Tue Feb  1 04:07:33 2000
@@ -836,7 +836,7 @@
                 } else pi_release(PI);
             }
 	for (unit=0;unit<PD_UNITS;unit++)
-		register_disk(&pd_gendisk,MKDEV(MAJOR_NR,unit<<PD_BITS),
+		register_disk(&pd_gendisk,BDEV(MAJOR_NR,unit<<PD_BITS),
 				PD_PARTNS,&pd_fops,
 				PD.present?PD.capacity:0);
 
diff -urN linux-2.3.41/drivers/block/paride/pf.c linux-bird.bdev/drivers/block/paride/pf.c
--- linux-2.3.41/drivers/block/paride/pf.c	Thu Jan 20 22:47:24 2000
+++ linux-bird.bdev/drivers/block/paride/pf.c	Tue Feb  1 04:07:33 2000
@@ -361,7 +361,7 @@
 	for (i=0;i<PF_UNITS;i++) pf_blocksizes[i] = 1024;
 	blksize_size[MAJOR_NR] = pf_blocksizes;
 	for (i=0;i<PF_UNITS;i++)
-		register_disk(NULL, MKDEV(MAJOR_NR, i), 1, &pf_fops, 0);
+		register_disk(NULL, BDEV(MAJOR_NR, i), 1, &pf_fops, 0);
 
         return 0;
 }
diff -urN linux-2.3.41/drivers/block/ps2esdi.c linux-bird.bdev/drivers/block/ps2esdi.c
--- linux-2.3.41/drivers/block/ps2esdi.c	Thu Jan 20 22:47:24 2000
+++ linux-bird.bdev/drivers/block/ps2esdi.c	Tue Feb  1 05:48:58 2000
@@ -113,6 +113,7 @@
 static DECLARE_WAIT_QUEUE_HEAD(ps2esdi_wait_open);
 
 int no_int_yet;
+static struct block_driver *ps2esdi_driver;
 static int access_count[MAX_HD] = {0,};
 static char ps2esdi_valid[MAX_HD] = {0,};
 static int ps2esdi_sizes[MAX_HD << 6] = {0,};
@@ -170,10 +171,8 @@
 /* initialization routine called by ll_rw_blk.c   */
 int __init ps2esdi_init(void)
 {
-
-	/* register the device - pass the name, major number and operations
-	   vector .                                                 */
-	if (register_blkdev(MAJOR_NR, "ed", &ps2esdi_fops)) {
+	ps2esdi_driver = register_block_driver("ed", MAJOR_NR);
+	if (IS_ERR(ps2esdi_driver)) {
 		printk("%s: Unable to get major number %d\n", DEVICE_NAME, MAJOR_NR);
 		return -1;
 	}
@@ -185,6 +184,7 @@
 	ps2esdi_gendisk.next = gendisk_head;
 	gendisk_head = &ps2esdi_gendisk;
 	ps2esdi_geninit();
+	range_unlock(ps2esdi_driver->range);
 	return 0;
 }				/* ps2esdi_init */
 
@@ -229,7 +229,7 @@
 	release_region(io_base, 4);
 	free_dma(dma_arb_level);
   	free_irq(PS2ESDI_IRQ, NULL)
-	unregister_blkdev(MAJOR_NR, "ed");
+	unregister_block_driver(ps2esdi_driver);
 }
 #endif /* MODULE */
 
@@ -420,10 +420,12 @@
 	blksize_size[MAJOR_NR] = ps2esdi_blocksizes;
 
 	for (i = 0; i < ps2esdi_drives; i++) {
-		register_disk(&ps2esdi_gendisk,MKDEV(MAJOR_NR,i<<6),1<<6,
-				&ps2esdi_fops,
-				ps2esdi_info[i].head * ps2esdi_info[i].sect *
-				ps2esdi_info[i].cyl);
+		struct disk_struct *disk;
+		disk = register_disk(ps2esdi_driver, &ps2esdi_gendisk,
+				     BDEV(MAJOR_NR,i<<6), 1<<6, &ps2esdi_fops);
+		disk->sectors = ps2esdi_info[i].head * ps2esdi_info[i].sect *
+				ps2esdi_info[i].cyl;
+		parse_partitions(disk);
 		ps2esdi_valid[i] = 1;
 	}
 }
diff -urN linux-2.3.41/drivers/block/rd.c linux-bird.bdev/drivers/block/rd.c
--- linux-2.3.41/drivers/block/rd.c	Thu Jan 20 22:47:24 2000
+++ linux-bird.bdev/drivers/block/rd.c	Tue Feb  1 04:59:22 2000
@@ -93,6 +93,7 @@
 /* Various static variables go here.  Most are used only in the RAM disk code.
  */
 
+static struct block_driver *rd_driver;
 static unsigned long rd_length[NUM_RAMDISKS];	/* Size of RAM disks in bytes   */
 static int rd_hardsec[NUM_RAMDISKS];		/* Size of real blocks in bytes */
 static int rd_blocksizes[NUM_RAMDISKS];		/* Size of 1024 byte blocks :)  */
@@ -389,11 +390,7 @@
 static void __exit rd_cleanup (void)
 {
 	int i;
-
-	for (i = 0 ; i < NUM_RAMDISKS; i++)
-		invalidate_buffers(MKDEV(MAJOR_NR, i));
-
-	unregister_blkdev( MAJOR_NR, "ramdisk" );
+	unregister_block_driver(rd_driver);
 	blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
 }
 
@@ -401,6 +398,7 @@
 int __init rd_init (void)
 {
 	int		i;
+	struct disk_struct *disk;
 
 	if (rd_blocksize > PAGE_SIZE || rd_blocksize < 512 ||
 	    (rd_blocksize & (rd_blocksize-1)))
@@ -410,7 +408,8 @@
 		rd_blocksize = BLOCK_SIZE;
 	}
 
-	if (register_blkdev(MAJOR_NR, "ramdisk", &fd_fops)) {
+	rd_driver = register_block_driver("ramdisk", MAJOR_NR);
+	if (IS_ERR(rd_driver)) {
 		printk("RAMDISK: Could not get major %d", MAJOR_NR);
 		return -EIO;
 	}
@@ -429,12 +428,16 @@
 	blksize_size[MAJOR_NR] = rd_blocksizes;		/* Avoid set_blocksize() check */
 	blk_size[MAJOR_NR] = rd_kbsize;			/* Size of the RAM disk in kB  */
 
-	for (i = 0; i < NUM_RAMDISKS; i++)
-		register_disk(NULL, MKDEV(MAJOR_NR,i), 1, &fd_fops, rd_size<<1);
+	for (i = 0; i < NUM_RAMDISKS; i++) {
+		disk=register_disk(rd_driver,NULL,BDEV(MAJOR_NR,i),1,&fd_fops);
+		disk->sectors=rd_size<<1;
+	}
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	/* We ought to separate initrd operations here */
-	register_disk(NULL, MKDEV(MAJOR_NR,INITRD_MINOR), 1, &fd_fops, rd_size<<1);
+	disk = register_disk(rd_driver,NULL,
+			     BDEV(MAJOR_NR,INITRD_MINOR),1,&fd_fops);
+	disk->sectors = rd_size<<1;
 #endif
 
 		/* rd_size is given in kB */
@@ -442,6 +445,7 @@
 	       "%d RAM disks of %dK size %d blocksize\n",
 	       NUM_RAMDISKS, rd_size, rd_blocksize);
 
+	range_unlock(rd_driver->range);
 	return 0;
 }
 
diff -urN linux-2.3.41/drivers/block/swim3.c linux-bird.bdev/drivers/block/swim3.c
--- linux-2.3.41/drivers/block/swim3.c	Tue Jan 11 00:21:05 2000
+++ linux-bird.bdev/drivers/block/swim3.c	Tue Feb  1 04:07:33 2000
@@ -1039,6 +1039,7 @@
 int swim3_init(void)
 {
 	struct device_node *swim;
+	int i;
 
 	swim = find_devices("floppy");
 	while (swim && (floppy_count < MAX_FLOPPIES))
@@ -1056,6 +1057,7 @@
 
 	if (floppy_count > 0)
 	{
+		int i;
 		if (register_blkdev(MAJOR_NR, "fd", &floppy_fops)) {
 			printk(KERN_ERR "Unable to get major %d for floppy\n",
 			       MAJOR_NR);
@@ -1064,6 +1066,9 @@
 		blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
 		blksize_size[MAJOR_NR] = floppy_blocksizes;
 		blk_size[MAJOR_NR] = floppy_sizes;
+		for (i = 0; i<floppy_count; i++)
+			register_disk(NULL, BDEV(MAJOR_NR, i), 1,
+					&floppy_fops, 0);
 	}
 
 	return 0;
diff -urN linux-2.3.41/drivers/block/swim_iop.c linux-bird.bdev/drivers/block/swim_iop.c
--- linux-2.3.41/drivers/block/swim_iop.c	Tue Jan 11 00:21:05 2000
+++ linux-bird.bdev/drivers/block/swim_iop.c	Tue Feb  1 04:07:33 2000
@@ -190,6 +190,7 @@
 
 		init_timer(&fs->timeout);
 		floppy_count++;
+		register_disk(NULL, BDEV(MAJOR_NR,i), 1, &floppy_fops, 0);
 	}
 	printk("SWIM-IOP: detected %d installed drives.\n", floppy_count);
 
diff -urN linux-2.3.41/drivers/block/xd.c linux-bird.bdev/drivers/block/xd.c
--- linux-2.3.41/drivers/block/xd.c	Thu Jan 20 22:47:24 2000
+++ linux-bird.bdev/drivers/block/xd.c	Tue Feb  1 04:39:37 2000
@@ -127,6 +127,7 @@
 	0xE0000
 };
 
+static struct block_driver *xd_driver;
 static struct hd_struct xd_struct[XD_MAXDRIVES << 6];
 static int xd_sizes[XD_MAXDRIVES << 6], xd_access[XD_MAXDRIVES] = { 0, 0 };
 static int xd_blocksizes[XD_MAXDRIVES << 6];
@@ -167,7 +168,8 @@
 /* xd_init: register the block device number and set up pointer tables */
 int __init xd_init (void)
 {
-	if (register_blkdev(MAJOR_NR,"xd",&xd_fops)) {
+	xd_driver = register_block_driver("xd", MAJOR_NR);
+	if (IS_ERR(xd_driver)) {
 		printk("xd: Unable to get major number %d\n",MAJOR_NR);
 		return -1;
 	}
@@ -176,6 +178,7 @@
 	xd_gendisk.next = gendisk_head;
 	gendisk_head = &xd_gendisk;
 	xd_geninit();
+	range_unlock(xd_driver->range);
 
 	return 0;
 }
@@ -247,10 +250,14 @@
 	}
 
 	for (i = 0; i < xd_drives; i++) {
+		struct disk_struct *disk;
 		xd_valid[i] = 1;
-		register_disk(&xd_gendisk, MKDEV(MAJOR_NR,i<<6), 1<<6, &xd_fops,
-				xd_info[i].heads * xd_info[i].cylinders *
-				xd_info[i].sectors);
+		disk = register_disk(xd_driver, &xd_gendisk,
+				     BDEV(MAJOR_NR,i<<6), 1<<6,
+				     &xd_fops);
+		disk->sectors = xd_info[i].heads * xd_info[i].cylinders *
+				xd_info[i].sectors;
+		parse_partitions(disk);
 	}
 
 	xd_gendisk.nr_real = xd_drives;
@@ -1162,7 +1169,7 @@
 	printk(KERN_INFO "XD: Loaded as a module.\n");
 	if (!xd_drives) {
 		/* no drives detected - unload module */
-		unregister_blkdev(MAJOR_NR, "xd");
+		unregister_block_driver(xd_driver);
 		xd_done();
 		return (-1);
 	}
@@ -1174,17 +1181,7 @@
 {
 	int partition,dev,start;
 
-	unregister_blkdev(MAJOR_NR, "xd");
-	for (dev = 0; dev < xd_drives; dev++) {
-		start = dev << xd_gendisk.minor_shift; 
-		for (partition = xd_gendisk.max_p - 1; partition >= 0; partition--) {
-			int minor = (start | partition);
-			kdev_t devp = MKDEV(MAJOR_NR, minor);
-			start = dev << xd_gendisk.minor_shift; 
-			sync_dev(devp);
-			invalidate_buffers(devp);
-		}
-	}
+	unregister_block_driver(xd_driver);
 	xd_done();
 	if (xd_drives) {
 		free_irq(xd_irq, NULL);
diff -urN linux-2.3.41/drivers/block/z2ram.c linux-bird.bdev/drivers/block/z2ram.c
--- linux-2.3.41/drivers/block/z2ram.c	Fri Jan 28 21:45:38 2000
+++ linux-bird.bdev/drivers/block/z2ram.c	Tue Feb  1 04:07:33 2000
@@ -348,6 +348,10 @@
 	    MAJOR_NR );
 	return -EBUSY;
     }
+   
+    blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
+    blksize_size[ MAJOR_NR ] = z2_blocksizes;
+    blk_size[ MAJOR_NR ] = z2_sizes;
 
     {
 	    /* Initialize size arrays. */
@@ -356,12 +360,9 @@
 	    for (i = 0; i < Z2MINOR_COUNT; i++) {
 		    z2_blocksizes[ i ] = 1024;
 		    z2_sizes[ i ] = 0;
+		    register_disk(NULL,BDEV(MAJOR_NR,i),1,&z2_fops,0);
 	    }
     }    
-   
-    blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
-    blksize_size[ MAJOR_NR ] = z2_blocksizes;
-    blk_size[ MAJOR_NR ] = z2_sizes;
 
     return 0;
 }
diff -urN linux-2.3.41/drivers/cdrom/aztcd.c linux-bird.bdev/drivers/cdrom/aztcd.c
--- linux-2.3.41/drivers/cdrom/aztcd.c	Thu Jan 20 22:47:24 2000
+++ linux-bird.bdev/drivers/cdrom/aztcd.c	Tue Feb  1 04:07:33 2000
@@ -1796,7 +1796,6 @@
 	blksize_size[MAJOR_NR] = aztcd_blocksizes;
 #endif
 	read_ahead[MAJOR_NR] = 4;
-	register_disk(NULL, MKDEV(MAJOR_NR,0), 1, &azt_fops, 0);
 
         if ((azt_port==0x1f0)||(azt_port==0x170))  
 	   request_region(azt_port, 8, "aztcd");  /*IDE-interface*/
@@ -1806,6 +1805,7 @@
 	azt_invalidate_buffers();
 	aztPresent = 1;
 	aztCloseDoor();
+	register_disk(NULL, BDEV(MAJOR_NR,0), 1, &azt_fops, 0);
         return (0);
 }
 
diff -urN linux-2.3.41/drivers/cdrom/cdu31a.c linux-bird.bdev/drivers/cdrom/cdu31a.c
--- linux-2.3.41/drivers/cdrom/cdu31a.c	Mon Dec 13 17:08:40 1999
+++ linux-bird.bdev/drivers/cdrom/cdu31a.c	Tue Feb  1 04:07:44 2000
@@ -3524,17 +3524,12 @@
       scd_info.mask = deficiency;
       strncpy(scd_info.name, "cdu31a", sizeof(scd_info.name));
 
+      disk_changed = 1;
       if (register_cdrom(&scd_info))
       {
          goto errout0;
       }
-   }
-
-
-   disk_changed = 1;
-   
-   if (drive_found)
-   {
+      register_disk(NULL, BDEV(MAJOR_NR,0), 1, &cdrom_fops, 0);
       return(0);
    }
    else
diff -urN linux-2.3.41/drivers/cdrom/cm206.c linux-bird.bdev/drivers/cdrom/cm206.c
--- linux-2.3.41/drivers/cdrom/cm206.c	Mon Dec 13 17:08:40 1999
+++ linux-bird.bdev/drivers/cdrom/cm206.c	Tue Feb  1 04:07:44 2000
@@ -1395,12 +1395,7 @@
     cleanup(3);
     return -EIO;
   }
-  cm206_info.dev = MKDEV(MAJOR_NR,0);
-  if (register_cdrom(&cm206_info) != 0) {
-    printk(KERN_INFO "Cannot register for cdrom %d!\n", MAJOR_NR);
-    cleanup(3);
-    return -EIO;
-  }    
+
   blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
   blksize_size[MAJOR_NR] = cm206_blocksizes;
   read_ahead[MAJOR_NR] = 16;	/* reads ahead what? */
@@ -1411,6 +1406,15 @@
   cd->adapter_last = -1;
   cd->timer.function = cm206_timeout;
   cd->max_sectors = (inw(r_data_status) & ds_ram_size) ? 24 : 97;
+
+  cm206_info.dev = MKDEV(MAJOR_NR,0);
+  if (register_cdrom(&cm206_info) != 0) {
+    printk(KERN_INFO "Cannot register for cdrom %d!\n", MAJOR_NR);
+    cleanup(3);
+    return -EIO;
+  }
+  register_disk(NULL, BDEV(MAJOR_NR,0), 1, &cdrom_fops, 0);
+
   printk(KERN_INFO "%d kB adapter memory available, "  
 	 " %ld bytes kernel memory used.\n", cd->max_sectors*2, size);
   return 0;
diff -urN linux-2.3.41/drivers/cdrom/gscd.c linux-bird.bdev/drivers/cdrom/gscd.c
--- linux-2.3.41/drivers/cdrom/gscd.c	Thu Jan 20 22:47:24 2000
+++ linux-bird.bdev/drivers/cdrom/gscd.c	Tue Feb  1 04:07:44 2000
@@ -1082,7 +1082,7 @@
         gscdPresent = 1;
 
 	request_region(gscd_port, 4, "gscd");
-	register_disk(NULL, MKDEV(MAJOR_NR,0), 1, &gscd_fops, 0);
+	register_disk(NULL, BDEV(MAJOR_NR,0), 1, &gscd_fops, 0);
 
         printk (KERN_INFO "GSCD: GoldStar CD-ROM Drive found.\n" );
 	return 0;
diff -urN linux-2.3.41/drivers/cdrom/mcd.c linux-bird.bdev/drivers/cdrom/mcd.c
--- linux-2.3.41/drivers/cdrom/mcd.c	Mon Dec 13 17:08:40 1999
+++ linux-bird.bdev/drivers/cdrom/mcd.c	Tue Feb  1 04:07:44 2000
@@ -1282,6 +1282,7 @@
               cleanup(3);
               return -EIO;
         }
+	register_disk(NULL, BDEV(MAJOR_NR,0), 1, &cdrom_fops, 0);
         printk(msg);
 
 	return 0;
diff -urN linux-2.3.41/drivers/cdrom/mcdx.c linux-bird.bdev/drivers/cdrom/mcdx.c
--- linux-2.3.41/drivers/cdrom/mcdx.c	Mon Dec 13 17:08:40 1999
+++ linux-bird.bdev/drivers/cdrom/mcdx.c	Tue Feb  1 04:07:44 2000
@@ -1185,6 +1185,7 @@
         		xwarn("cleanup() unregister_blkdev() failed\n");
 		return 2;
         }
+	register_disk(NULL, BDEV(MAJOR_NR,0), 1, &cdrom_fops, 0);
         printk(msg);
 	return 0;
 }
diff -urN linux-2.3.41/drivers/cdrom/optcd.c linux-bird.bdev/drivers/cdrom/optcd.c
--- linux-2.3.41/drivers/cdrom/optcd.c	Thu Jan 20 22:47:24 2000
+++ linux-bird.bdev/drivers/cdrom/optcd.c	Tue Feb  1 04:07:45 2000
@@ -2072,7 +2072,7 @@
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
 	read_ahead[MAJOR_NR] = 4;
 	request_region(optcd_port, 4, "optcd");
-	register_disk(NULL, MKDEV(MAJOR_NR,0), 1, &opt_fops, 0);
+	register_disk(NULL, BDEV(MAJOR_NR,0), 1, &opt_fops, 0);
 
 	printk(KERN_INFO "optcd: DOLPHIN 8000 AT CDROM at 0x%x\n", optcd_port);
 	return 0;
diff -urN linux-2.3.41/drivers/cdrom/sbpcd.c linux-bird.bdev/drivers/cdrom/sbpcd.c
--- linux-2.3.41/drivers/cdrom/sbpcd.c	Mon Dec 13 17:08:40 1999
+++ linux-bird.bdev/drivers/cdrom/sbpcd.c	Tue Feb  1 04:07:45 2000
@@ -5744,6 +5744,8 @@
 	read_ahead[MAJOR_NR] = buffers * (CD_FRAMESIZE / 512);
 	
 	request_region(CDo_command,4,major_name);
+
+	blksize_size[MAJOR_NR]=sbpcd_blocksizes;
 	
 	for (j=0;j<NR_SBPCD;j++)
 	{
@@ -5793,17 +5795,16 @@
 		sbpcd_infop->dev = MKDEV(MAJOR_NR, j);
 		strncpy(sbpcd_infop->name,major_name, sizeof(sbpcd_infop->name)); 
 
-		if (register_cdrom(sbpcd_infop))
-		{
-                	printk(" sbpcd: Unable to register with Uniform CD-ROm driver\n");
-		}
-
 		/*
 		 * set the block size
 		 */
 		sbpcd_blocksizes[j]=CD_FRAMESIZE;
+
+		if (register_cdrom(sbpcd_infop))
+                	printk(" sbpcd: Unable to register with Uniform CD-ROm driver\n");
+		else
+			register_disk(NULL,BDEV(MAJOR_NR,j),1,&cdrom_fops,0);
 	}
-	blksize_size[MAJOR_NR]=sbpcd_blocksizes;
 
 #ifndef MODULE
  init_done:
@@ -5827,13 +5828,6 @@
 {
 	int j;
 	
-	if ((unregister_blkdev(MAJOR_NR, major_name) == -EINVAL))
-	{
-		msg(DBG_INF, "What's that: can't unregister %s.\n", major_name);
-		return;
-	}
-	release_region(CDo_command,4);
-	
 	for (j=0;j<NR_SBPCD;j++)
 	{
 		if (D_S[j].drv_id==-1) continue;
@@ -5846,6 +5840,14 @@
 		}
 		vfree(D_S[j].sbpcd_infop);
 	}
+	
+	if ((unregister_blkdev(MAJOR_NR, major_name) == -EINVAL))
+	{
+		msg(DBG_INF, "What's that: can't unregister %s.\n", major_name);
+		return;
+	}
+	release_region(CDo_command,4);
+
 	msg(DBG_INF, "%s module released.\n", major_name);
 }
 
diff -urN linux-2.3.41/drivers/cdrom/sjcd.c linux-bird.bdev/drivers/cdrom/sjcd.c
--- linux-2.3.41/drivers/cdrom/sjcd.c	Thu Jan 20 22:47:24 2000
+++ linux-bird.bdev/drivers/cdrom/sjcd.c	Tue Feb  1 04:07:45 2000
@@ -1478,7 +1478,6 @@
   
   blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
   read_ahead[ MAJOR_NR ] = 4;
-  register_disk(NULL, MKDEV(MAJOR_NR,0), 1, &sjcd_fops, 0);
   
   if( check_region( sjcd_base, 4 ) ){
     printk( "SJCD: Init failed, I/O port (%X) is already in use\n",
@@ -1565,6 +1564,7 @@
   printk(KERN_INFO "SJCD: Status: port=0x%x.\n", sjcd_base);
 
   sjcd_present++;
+  register_disk(NULL, BDEV(MAJOR_NR,0), 1, &sjcd_fops, 0);
   return( 0 );
 }
 
diff -urN linux-2.3.41/drivers/cdrom/sonycd535.c linux-bird.bdev/drivers/cdrom/sonycd535.c
--- linux-2.3.41/drivers/cdrom/sonycd535.c	Thu Jan 20 22:47:24 2000
+++ linux-bird.bdev/drivers/cdrom/sonycd535.c	Tue Feb  1 04:07:45 2000
@@ -1634,7 +1634,7 @@
 		return -EIO;
 	}
 	request_region(sony535_cd_base_io, 4, CDU535_HANDLE);
-	register_disk(NULL, MKDEV(MAJOR_NR,0), 1, &cdu_fops, 0);
+	register_disk(NULL, BDEV(MAJOR_NR,0), 1, &cdu_fops, 0);
 	return 0;
 }
 
diff -urN linux-2.3.41/drivers/i2o/i2o_block.c linux-bird.bdev/drivers/i2o/i2o_block.c
--- linux-2.3.41/drivers/i2o/i2o_block.c	Thu Jan 20 22:47:25 2000
+++ linux-bird.bdev/drivers/i2o/i2o_block.c	Tue Feb  1 04:07:45 2000
@@ -1120,7 +1120,7 @@
 	 */
 
 	for (i = 0; i < MAX_I2OB; i++)
-		register_disk(&i2ob_gendisk, MKDEV(MAJOR_NR,i<<4), 1<<4,
+		register_disk(&i2ob_gendisk, BDEV(MAJOR_NR,i<<4), 1<<4,
 			&i2ob_fops, 0);
 	i2ob_probe();
 	
diff -urN linux-2.3.41/drivers/scsi/sd.c linux-bird.bdev/drivers/scsi/sd.c
--- linux-2.3.41/drivers/scsi/sd.c	Fri Jan 28 21:45:42 2000
+++ linux-bird.bdev/drivers/scsi/sd.c	Tue Feb  1 04:07:45 2000
@@ -1012,17 +1012,21 @@
 		LAST_SD_GENDISK.next = gendisk_head;
 		gendisk_head = sd_gendisks;
 	}
-	for (i = 0; i < sd_template.dev_max; ++i)
-		if (!rscsi_disks[i].capacity && rscsi_disks[i].device) {
-			sd_init_onedisk(i);
-			if (!rscsi_disks[i].has_part_table) {
-				sd_sizes[i << 4] = rscsi_disks[i].capacity;
-				register_disk(&SD_GENDISK(i), MKDEV_SD(i),
+	for (i = 0; i < sd_template.dev_max; ++i) {
+		if (!rscsi_disks[i].device)	/* nothing to talk about */
+			continue;
+		if (rscsi_disks[i].capacity)
+			continue;
+		sd_init_onedisk(i);
+		if (rscsi_disks[i].has_part_table) /* we are already done */
+			continue;
+		sd_sizes[i << 4] = rscsi_disks[i].capacity;
+		rscsi_disks[i].disk = register_disk(&SD_GENDISK(i),
+						(unsigned)MKDEV_SD(i),
 						1<<4, &sd_fops,
 						rscsi_disks[i].capacity);
-				rscsi_disks[i].has_part_table = 1;
-			}
-		}
+		rscsi_disks[i].has_part_table = 1;
+	}
 	/* If our host adapter is capable of scatter-gather, then we increase
 	 * the read-ahead to 60 blocks (120 sectors).  If not, we use
 	 * a two block (4 sector) read ahead. We can only respect this with the
@@ -1174,7 +1178,8 @@
 				sd_gendisks->part[index].nr_sects = 0;
 				sd_sizes[index] = 0;
 			}
-			/* unregister_disk() */
+			unregister_disk(dpnt->disk);
+			dpnt->disk = NULL;
 			dpnt->has_part_table = 0;
 			dpnt->device = NULL;
 			dpnt->capacity = 0;
diff -urN linux-2.3.41/drivers/scsi/sd.h linux-bird.bdev/drivers/scsi/sd.h
--- linux-2.3.41/drivers/scsi/sd.h	Fri Jan  7 21:49:15 2000
+++ linux-bird.bdev/drivers/scsi/sd.h	Tue Feb  1 04:07:45 2000
@@ -25,6 +25,7 @@
 
 extern struct hd_struct *sd;
 
+struct disk_struct;
 typedef struct scsi_disk {
 	unsigned capacity;	/* size in blocks */
 	Scsi_Device *device;
@@ -33,6 +34,7 @@
 	unsigned char sector_bit_size;	/* sector_size = 2 to the  bit size power */
 	unsigned char sector_bit_shift;		/* power of 2 sectors per FS block */
 	unsigned has_part_table:1;	/* has partition table */
+	struct disk_struct *disk;
 } Scsi_Disk;
 
 extern int revalidate_scsidisk(kdev_t dev, int maxusage);
diff -urN linux-2.3.41/drivers/scsi/sr.c linux-bird.bdev/drivers/scsi/sr.c
--- linux-2.3.41/drivers/scsi/sr.c	Fri Jan 28 21:45:42 2000
+++ linux-bird.bdev/drivers/scsi/sr.c	Tue Feb  1 04:07:45 2000
@@ -735,6 +735,14 @@
 	blk_dev[MAJOR_NR].queue = sr_find_queue;
 	blk_size[MAJOR_NR] = sr_sizes;
 
+	/* If our host adapter is capable of scatter-gather, then we increase
+	 * the read-ahead to 16 blocks (32 sectors).  If not, we use
+	 * a two block (4 sector) read ahead. */
+	if (scsi_CDs[0].device && scsi_CDs[0].device->host->sg_tablesize)
+		read_ahead[MAJOR_NR] = 32;	/* 32 sector read-ahead.  Always removable. */
+	else
+		read_ahead[MAJOR_NR] = 4;	/* 4 sector read-ahead */
+
 	for (i = 0; i < sr_template.nr_dev; ++i) {
 		/* If we have already seen this, then skip it.  Comes up
 		 * with loadable modules. */
@@ -768,17 +776,10 @@
 		sprintf(name, "sr%d", i);
 		strcpy(scsi_CDs[i].cdi.name, name);
 		register_cdrom(&scsi_CDs[i].cdi);
+		scsi_CDs[i].disk = register_disk(NULL, BDEV(MAJOR_NR,i), 1,
+						&cdrom_fops, 0);
 	}
 
-
-	/* If our host adapter is capable of scatter-gather, then we increase
-	 * the read-ahead to 16 blocks (32 sectors).  If not, we use
-	 * a two block (4 sector) read ahead. */
-	if (scsi_CDs[0].device && scsi_CDs[0].device->host->sg_tablesize)
-		read_ahead[MAJOR_NR] = 32;	/* 32 sector read-ahead.  Always removable. */
-	else
-		read_ahead[MAJOR_NR] = 4;	/* 4 sector read-ahead */
-
 	return;
 }
 
@@ -789,16 +790,8 @@
 
 	for (cpnt = scsi_CDs, i = 0; i < sr_template.dev_max; i++, cpnt++)
 		if (cpnt->device == SDp) {
-			kdev_t devi = MKDEV(MAJOR_NR, i);
-			struct super_block *sb = get_super(devi);
-
-			/*
-			 * Since the cdrom is read-only, no need to sync the device.
-			 * We should be kind to our buffer cache, however.
-			 */
-			if (sb)
-				invalidate_inodes(sb);
-			invalidate_buffers(devi);
+			unregister_disk(scsi_CDs[i].disk);
+			scsi_CDs[i].disk = NULL;
 
 			/*
 			 * Reset things back to a sane state so that one can re-load a new
diff -urN linux-2.3.41/drivers/scsi/sr.h linux-bird.bdev/drivers/scsi/sr.h
--- linux-2.3.41/drivers/scsi/sr.h	Mon Dec 13 02:04:20 1999
+++ linux-bird.bdev/drivers/scsi/sr.h	Tue Feb  1 04:07:45 2000
@@ -19,6 +19,8 @@
 
 #include "scsi.h"
 
+struct disk_struct;
+
 typedef struct {
 	unsigned capacity;	/* size in blocks                       */
 	Scsi_Device *device;
@@ -32,6 +34,7 @@
 	unsigned readcd_known:1;	/* drive supports READ_CD (0xbe) */
 	unsigned readcd_cdda:1;	/* reading audio data using READ_CD */
 	struct cdrom_device_info cdi;
+	struct disk_struct *disk;
 } Scsi_CD;
 
 extern Scsi_CD *scsi_CDs;
diff -urN linux-2.3.41/fs/block_dev.c linux-bird.bdev/fs/block_dev.c
--- linux-2.3.41/fs/block_dev.c	Fri Jan 28 21:45:45 2000
+++ linux-bird.bdev/fs/block_dev.c	Tue Feb  1 04:24:50 2000
@@ -10,6 +10,7 @@
 #include <linux/fcntl.h>
 #include <linux/malloc.h>
 #include <linux/kmod.h>
+#include <linux/blkdev.h>
 
 #include <asm/uaccess.h>
 
@@ -304,7 +305,7 @@
 }
 
 /*
- * bdev cache handling - shamelessly stolen from inode.c
+ * bdev and disk_struct caches handling - shamelessly stolen from inode.c
  * We use smaller hashtable, though.
  */
 
@@ -314,12 +315,31 @@
 static struct list_head bdev_hashtable[HASH_SIZE];
 static spinlock_t bdev_lock = SPIN_LOCK_UNLOCKED;
 static kmem_cache_t * bdev_cachep;
+static kmem_cache_t * disks_cachep;
+
+#define alloc_disk() \
+	 ((struct disk_struct *) kmem_cache_alloc(disks_cachep, SLAB_KERNEL))
+#define destroy_disk(disk) kmem_cache_free(bdev_cachep, (disk))
 
 #define alloc_bdev() \
 	 ((struct block_device *) kmem_cache_alloc(bdev_cachep, SLAB_KERNEL))
 #define destroy_bdev(bdev) kmem_cache_free(bdev_cachep, (bdev))
 
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static void init_disk(void * foo, kmem_cache_t * cachep, unsigned long flags)
+{
+	struct disk_struct * disk = (struct disk_struct *) foo;
+
+	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
+	    SLAB_CTOR_CONSTRUCTOR)
+	{
+		memset(disk, 0, sizeof(*disk));
+		init_waitqueue_head(&disk->wqueue);
+		INIT_LIST_HEAD(&disk->disks);
+		INIT_LIST_HEAD(&disk->bdevs);
+	}
+}
+
+static void init_bdev(void * foo, kmem_cache_t * cachep, unsigned long flags)
 {
 	struct block_device * bdev = (struct block_device *) foo;
 
@@ -331,6 +351,15 @@
 	}
 }
 
+struct range_node *root_bdev_range = NULL;
+
+static void bdev_loader(struct range_node *dummy, unsigned devnum)
+{
+	char name[20];
+	sprintf(name, "block-major-%d", MAJOR(devnum));
+	request_module(name);
+}
+
 void bdev_init(void)
 {
 	int i;
@@ -345,10 +374,25 @@
 
 	bdev_cachep = kmem_cache_create("bdev_cache",
 					 sizeof(struct block_device),
-					 0, SLAB_HWCACHE_ALIGN, init_once,
+					 0, SLAB_HWCACHE_ALIGN, init_bdev,
 					 NULL);
 	if (!bdev_cachep)
 		panic("cannot create bdev slab cache");
+
+	disks_cachep = kmem_cache_create("disks_cache",
+					 sizeof(struct disk_struct),
+					 0, SLAB_HWCACHE_ALIGN, init_disk,
+					 NULL);
+	if (!disks_cachep)
+		panic("cannot create disk_struct slab cache");
+
+	root_bdev_range = range_create();
+	if (!root_bdev_range)
+		panic("cannot allocate the root range for block devices");
+	root_bdev_range->from = BDEV(1,0);
+	root_bdev_range->to = BDEV(254,255);
+	root_bdev_range->loader = bdev_loader;
+	range_unlock(root_bdev_range);
 }
 
 /*
@@ -390,7 +434,7 @@
 		return NULL;
 	atomic_set(&new_bdev->bd_count,1);
 	new_bdev->bd_dev = dev;
-	new_bdev->bd_op = NULL;
+	new_bdev->bd_disk = NULL;
 	spin_lock(&bdev_lock);
 	bdev = bdfind(dev, head);
 	if (!bdev) {
@@ -422,56 +466,208 @@
 	{ NULL, NULL },
 };
 
-int get_blkdev_list(char * p)
+/* Handling of the block_driver. Too few of them to bother with slabs */
+
+static LIST_HEAD(block_drivers_list);
+static spinlock_t drivers_lock = SPIN_LOCK_UNLOCKED;	/* insert/remove/look */
+
+struct block_driver *register_block_driver(char *name, int major)
 {
-	int i;
-	int len;
+	struct block_driver *res;
+	struct range_node *range;
+	int err = -ENOMEM;
+	res = (struct block_driver *)kmalloc(sizeof(*res), GFP_KERNEL);
+	if (!res)
+		goto fail;
+	memset(res, 0, sizeof(*res));
+	INIT_LIST_HEAD(&res->disks);
+	res->name = name;
+	if (major) {
+		range = range_create();
+		if (!range)
+			goto fail_range;
+		range->kind = BDEV_DRIVER_RANGE;
+		err = range_add(root_bdev_range, BDEV(major,0),
+				BDEV(major,255), range);
+		if (err)
+			goto fail_add;
+		res->range = range;
+	}
+	spin_lock(&drivers_lock);
+	list_add(&res->drivers,block_drivers_list.prev);
+	spin_unlock(&drivers_lock);
+	return res;
 
-	len = sprintf(p, "\nBlock devices:\n");
-	for (i = 0; i < MAX_BLKDEV ; i++) {
-		if (blkdevs[i].bdops) {
-			len += sprintf(p+len, "%3d %s\n", i, blkdevs[i].name);
+fail_add:
+	range_delete(range);
+fail_range:
+	kfree(res);
+fail:
+	return ERR_PTR(err);
+}
+
+struct disk_struct *__register_disk(struct block_driver *driver,
+				    struct gendisk *gdev,
+				    unsigned first, unsigned minors,
+				    struct block_device_operations *ops,
+				    struct module *owner)
+{
+	struct disk_struct *disk;
+	struct range_node *range, *area;
+	int err = -ENOMEM;
+
+	disk = alloc_disk();
+	if (!disk)
+		goto fail;
+
+	disk->name = NULL;	/* FIXME */
+	disk->gendisk = gdev;
+	disk->bd_ops = ops;
+	disk->driver = driver;
+
+	range = range_create();	
+	if (!range)
+		goto fail_range;
+
+	range->owner = owner;
+	range->data = (void*)disk;
+	disk->range = range;
+	range->kind = BDEV_DISK_RANGE;
+
+	/* Let's find where to put it */
+	err = -EINVAL;
+	for(area = driver->range; area; area = (struct range_node*)area->data)
+		if (area->from <= first && area->to >= first+minors-1)
+			break;
+	if (area)
+		err = range_add(area, first, first+minors-1, range);
+	if (err)
+		goto fail_add;
+	list_add(&disk->disks, &driver->disks);
+	range_unlock(range);
+	return disk;
+
+fail_add:
+	range_delete(range);
+fail_range:
+	destroy_disk(disk);
+fail:
+	return ERR_PTR(err);
+}
+
+void unregister_disk(struct disk_struct *disk)
+{
+	range_delete(disk->range);
+	disk->range = NULL;
+	/*
+	 * If Stephen really wants to keep buffer_cache across the close,
+	 * fine - we will just check that nobody is opened, invalidate
+	 * the cache and detach block_devices from the disk_struct.
+	 */
+	if (!list_empty(&disk->bdevs))
+		goto should_never_ever_happen;
+	list_del(&disk->disks);
+	INIT_LIST_HEAD(&disk->disks);
+	disk->driver = NULL;
+	destroy_disk(disk);
+	return;
+
+should_never_ever_happen:
+	/* We just do not do it. */
+	panic("unregister_disk with device(s) still opened. We are buggered\n");
+}
+
+int unregister_block_driver(struct block_driver *driver)
+{
+	int err;
+	struct range_node *area;
+	while (!list_empty(&driver->disks))
+		unregister_disk(list_entry(driver->disks.next,
+					   struct disk_struct, disks));
+	spin_lock(&drivers_lock);
+	area = driver->range;
+	while(driver->range) {
+		area = driver->range;
+		driver->range = area->data;
+		err = range_delete(area);
+		if (err) {
+			driver->range = area;
+			spin_unlock(&drivers_lock);
+			return err;
 		}
 	}
-	return len;
+	list_del(&driver->drivers);
+	spin_unlock(&drivers_lock);
+	INIT_LIST_HEAD(&driver->drivers);
+	kfree(driver);
+	return 0;
 }
 
-/*
-	Return the function table of a device.
-	Load the driver if needed.
-*/
-static const struct block_device_operations * get_blkfops(unsigned int major)
-{
-	const struct block_device_operations *ret = NULL;
-
-	/* major 0 is used for non-device mounts */
-	if (major && major < MAX_BLKDEV) {
-#ifdef CONFIG_KMOD
-		if (!blkdevs[major].bdops) {
-			char name[20];
-			sprintf(name, "block-major-%d", major);
-			request_module(name);
-		}
-#endif
-		ret = blkdevs[major].bdops;
+int block_area_remove(struct block_driver *driver, unsigned from)
+{
+	int err = -ENODEV;
+	struct range_node **p = &driver->range;
+	spin_lock(&drivers_lock);
+	while(*p && (*p)->from != from)
+		p = (struct range_node **)&(*p)->data;
+	if (*p) {
+		struct range_node *next = (*p)->data;
+		err = range_delete(*p);
+		if (!err)
+			*p = next;
+	}
+	spin_unlock(&drivers_lock);
+	return err;
+}
+
+struct range_node *block_area_add(struct block_driver *driver, unsigned from, unsigned size)
+{
+	struct range_node * range = range_create();
+	struct range_node **p;
+	int err = -ENOMEM;
+	if (!range)
+		goto fail;
+	range->kind = BDEV_DRIVER_RANGE;
+	err = range_add(root_bdev_range, from, from+size-1, range);
+	if (err)
+		goto fail_add;
+	spin_lock(&drivers_lock);
+	for (p = &driver->range; *p; p=(struct range_node **)&(*p)->data)
+		;
+	*p = range;
+	spin_unlock(&drivers_lock);
+	return range;
+
+fail_add:
+	range_delete(range);
+fail:
+	return ERR_PTR(err);
+}
+
+int get_blkdev_list(char * p)
+{
+	int len;
+	struct list_head *tmp;
+	struct block_driver *driver;
+	struct range_node *area;
+	char *name;
+
+	len = sprintf(p, "\nBlock devices:\n");
+	spin_lock(&drivers_lock);
+	tmp = block_drivers_list.next;
+	while (tmp != &block_drivers_list) {
+		driver = list_entry(tmp,struct block_driver,drivers);
+		name = driver->name;
+		for (area = driver->range; area ; area = area->data)
+			len += sprintf(p+len,"%3d %s\n",MAJOR(area->from),name);
+		tmp = tmp->next;
 	}
-	return ret;
+	spin_unlock(&drivers_lock);
+	return len;
 }
 
 int register_blkdev(unsigned int major, const char * name, struct block_device_operations *bdops)
 {
-	if (major == 0) {
-		for (major = MAX_BLKDEV-1; major > 0; major--) {
-			if (blkdevs[major].bdops == NULL) {
-				blkdevs[major].name = name;
-				blkdevs[major].bdops = bdops;
-				return major;
-			}
-		}
-		return -EBUSY;
-	}
-	if (major >= MAX_BLKDEV)
-		return -EINVAL;
 	if (blkdevs[major].bdops && blkdevs[major].bdops != bdops)
 		return -EBUSY;
 	blkdevs[major].name = name;
@@ -536,46 +732,79 @@
 	int res;
 	mm_segment_t old_fs = get_fs();
 
-	if (!bdev->bd_op->ioctl)
+	if (!bdev->bd_disk->bd_ops->ioctl)
 		return -EINVAL;
 	inode_fake.i_rdev=rdev;
 	init_waitqueue_head(&inode_fake.i_wait);
 	set_fs(KERNEL_DS);
-	res = bdev->bd_op->ioctl(&inode_fake, NULL, cmd, arg);
+	res = bdev->bd_disk->bd_ops->ioctl(&inode_fake, NULL, cmd, arg);
 	set_fs(old_fs);
 	return res;
 }
 
+static inline int blkdev_bind(struct block_device *bdev)
+{
+	struct range_node *range;
+	if (bdev->bd_disk)
+		return 0;
+	range = range_lookup(root_bdev_range, bdev->bd_dev);
+	if (range->kind != BDEV_DISK_RANGE)
+		goto fail;
+	bdev->bd_disk = range->data;
+	list_add(&bdev->bd_part, &bdev->bd_disk->bdevs);
+	return 0;
+fail:
+	range_put(range);
+	return -ENODEV;
+}
+
+static inline void blkdev_drop(struct block_device *bdev)
+{
+	if (!atomic_read(&bdev->bd_openers)) {
+		range_put(bdev->bd_disk->range);
+		bdev->bd_disk = NULL;
+		list_del(&bdev->bd_part);
+		INIT_LIST_HEAD(&bdev->bd_part);
+	}
+}
+
 int blkdev_get(struct block_device *bdev, mode_t mode, unsigned flags, int kind)
 {
 	int ret = -ENODEV;
 	kdev_t rdev = to_kdev_t(bdev->bd_dev); /* this should become bdev */
+	struct file fake_file = {};
+	struct dentry fake_dentry = {};
+	struct inode *fake_inode;
+
 	down(&bdev->bd_sem);
-	if (!bdev->bd_op)
-		bdev->bd_op = get_blkfops(MAJOR(rdev));
-	if (bdev->bd_op) {
-		/*
-		 * This crockload is due to bad choice of ->open() type.
-		 * It will go away.
-		 */
-		struct file fake_file = {};
-		struct dentry fake_dentry = {};
-		struct inode *fake_inode = get_empty_inode();
-		ret = -ENOMEM;
-		if (fake_inode) {
-			fake_file.f_mode = mode;
-			fake_file.f_flags = flags;
-			fake_file.f_dentry = &fake_dentry;
-			fake_dentry.d_inode = fake_inode;
-			fake_inode->i_rdev = rdev;
-			ret = 0;
-			if (bdev->bd_op->open)
-				ret = bdev->bd_op->open(fake_inode, &fake_file);
-			if (!ret)
-				atomic_inc(&bdev->bd_openers);
-			iput(fake_inode);
-		}
-	}
+
+	ret = blkdev_bind(bdev);
+	if (ret)
+		goto out;
+
+	/*
+	 * This crockload is due to bad choice of ->open() type.
+	 * It will go away.
+	 */
+	ret = -ENOMEM;
+	fake_inode = get_empty_inode();
+	if (!fake_inode)
+		goto out;
+	fake_file.f_mode = mode;
+	fake_file.f_flags = flags;
+	fake_file.f_dentry = &fake_dentry;
+	fake_dentry.d_inode = fake_inode;
+	fake_inode->i_rdev = rdev;
+	ret = 0;
+
+	if (bdev->bd_disk->bd_ops->open)
+		ret = bdev->bd_disk->bd_ops->open(fake_inode, &fake_file);
+	if (!ret)
+		atomic_inc(&bdev->bd_openers);
+	else
+		blkdev_drop(bdev);
+	iput(fake_inode);
+out:
 	up(&bdev->bd_sem);
 	return ret;
 }
@@ -585,15 +814,16 @@
 	int ret = -ENODEV;
 	struct block_device *bdev = inode->i_bdev;
 	down(&bdev->bd_sem);
-	if (!bdev->bd_op)
-		bdev->bd_op = get_blkfops(MAJOR(inode->i_rdev));
-	if (bdev->bd_op) {
-		ret = 0;
-		if (bdev->bd_op->open)
-			ret = bdev->bd_op->open(inode,filp);
-		if (!ret)
-			atomic_inc(&bdev->bd_openers);
-	}	
+	ret = blkdev_bind(bdev);
+	if (ret)
+		goto out;
+	if (bdev->bd_disk->bd_ops->open)
+		ret = bdev->bd_disk->bd_ops->open(inode,filp);
+	if (!ret)
+		atomic_inc(&bdev->bd_openers);
+	else
+		blkdev_drop(bdev);
+out:
 	up(&bdev->bd_sem);
 	return ret;
 }	
@@ -610,18 +840,16 @@
 		/* invalidating buffers will go here */
 		invalidate_buffers(rdev);
 	}
-	if (bdev->bd_op->release) {
+	if (bdev->bd_disk->bd_ops->release) {
 		struct inode * fake_inode = get_empty_inode();
 		ret = -ENOMEM;
 		if (fake_inode) {
 			fake_inode->i_rdev = rdev;
-			ret = bdev->bd_op->release(fake_inode, NULL);
+			ret = bdev->bd_disk->bd_ops->release(fake_inode, NULL);
 			iput(fake_inode);
 		}
 	}
-	if (!atomic_read(&bdev->bd_openers))
-		bdev->bd_op = NULL;	/* we can't rely on driver being */
-					/* kind to stay around. */
+	blkdev_drop(bdev);
 	up(&bdev->bd_sem);
 	return ret;
 }
@@ -634,8 +862,9 @@
 static int blkdev_ioctl(struct inode *inode, struct file *file, unsigned cmd,
 			unsigned long arg)
 {
-	if (inode->i_bdev->bd_op->ioctl)
-		return inode->i_bdev->bd_op->ioctl(inode, file, cmd, arg);
+	struct block_device_operations *bd_ops = inode->i_bdev->bd_disk->bd_ops;
+	if (bd_ops->ioctl)
+		return bd_ops->ioctl(inode, file, cmd, arg);
 	return -EINVAL;
 }
 
diff -urN linux-2.3.41/fs/partitions/check.c linux-bird.bdev/fs/partitions/check.c
--- linux-2.3.41/fs/partitions/check.c	Fri Jan 28 21:45:46 2000
+++ linux-bird.bdev/fs/partitions/check.c	Tue Feb  1 04:08:49 2000
@@ -273,14 +273,6 @@
  * done
  */
 
-void register_disk(struct gendisk *gdev, kdev_t dev, unsigned minors,
-	struct block_device_operations *ops, long size)
-{
-	if (!gdev)
-		return;
-	grok_partitions(gdev, MINOR(dev)>>gdev->minor_shift, minors, size);
-}
-
 void grok_partitions(struct gendisk *dev, int drive, unsigned minors, long size)
 {
 	int i;
diff -urN linux-2.3.41/include/linux/blkdev.h linux-bird.bdev/include/linux/blkdev.h
--- linux-2.3.41/include/linux/blkdev.h	Fri Jan 28 21:45:48 2000
+++ linux-bird.bdev/include/linux/blkdev.h	Tue Feb  1 04:26:00 2000
@@ -5,6 +5,41 @@
 #include <linux/sched.h>
 #include <linux/genhd.h>
 #include <linux/tqueue.h>
+#include <linux/range_tree.h>
+
+enum { BDEV_DRIVER_RANGE=1, BDEV_DISK_RANGE=2 };
+struct block_driver {
+	/* list of our disks */
+	struct list_head	disks;
+
+	/* list of all block drivers */
+	struct list_head	drivers;
+
+	/* first range of device numbers; if we have more than one -
+	 * ->range->data will point to the next. */
+	struct range_node *	range;
+	char *		name;
+};
+
+struct disk_struct {
+	/* list of all disks belonging to the same driver */
+	struct list_head	disks;
+	/* our driver */
+	struct block_driver *	driver;
+	/* device numbers range; ->range->data points back to us */
+	struct range_node *	range;
+	/* list of all opened block devices that belong to us */
+	struct list_head	bdevs;
+	/* disk size; unit is 512 byte, same as in struct request */
+	unsigned long		sectors;
+	struct block_device_operations *bd_ops;
+	int			users;
+	/* serialization between open and reading partition table */
+	wait_queue_head_t	wqueue;
+	/* atavism */
+	struct gendisk *	gendisk;
+	char *			name;
+};
 
 /*
  * Ok, this is an expanded form so that we can use the same
@@ -102,13 +137,32 @@
  */
 #define BLK_DEFAULT_QUEUE(_MAJOR)  &blk_dev[_MAJOR].request_queue
 
+extern struct range_node *root_bdev_range;
+
 extern struct sec_size * blk_sec[MAX_BLKDEV];
 extern struct blk_dev_struct blk_dev[MAX_BLKDEV];
 extern wait_queue_head_t wait_for_request;
-extern void grok_partitions(struct gendisk *dev, int drive, unsigned minors, long size);
-extern void register_disk(struct gendisk *dev, kdev_t first, unsigned minors, struct block_device_operations *ops, long size);
+extern struct block_driver *register_block_driver(char *name, int major);
+extern int unregister_block_driver(struct block_driver *driver);
+extern struct range_node *block_area_add(struct block_driver *driver, unsigned from, unsigned size);
+extern int block_area_remove(struct block_driver *driver, unsigned from);
+extern struct disk_struct *__register_disk(struct block_driver *driver,
+				    struct gendisk *gdev,
+				    unsigned first, unsigned minors,
+				    struct block_device_operations *ops,
+				    struct module *owner);
+
+static inline struct disk_struct *register_disk(struct block_driver *driver,
+				    struct gendisk *gdev,
+				    unsigned first, unsigned minors,
+				    struct block_device_operations *ops) {
+	return __register_disk(driver, gdev, first, minors, ops, THIS_MODULE);
+}
+extern void unregister_disk(struct disk_struct *disk);
+extern void parse_partitions(struct disk_struct *disk);
 extern void unplug_device(void * data);
 extern void make_request(int major,int rw, struct buffer_head * bh);
+#define BDEV(major,minor) ((unsigned)MKDEV((major),(minor)))
 
 /*
  * Access functions for manipulating queue properties
diff -urN linux-2.3.41/include/linux/fs.h linux-bird.bdev/include/linux/fs.h
--- linux-2.3.41/include/linux/fs.h	Fri Jan 28 21:45:48 2000
+++ linux-bird.bdev/include/linux/fs.h	Tue Feb  1 04:07:53 2000
@@ -338,14 +338,17 @@
 	unsigned long		nrpages;
 };
 
+struct disk_struct;
+
 struct block_device {
 	struct list_head	bd_hash;
 	atomic_t		bd_count;
+	struct disk_struct *	bd_disk;
 /*	struct address_space	bd_data; */
 	dev_t			bd_dev;  /* not a kdev_t - it's a search key */
 	atomic_t		bd_openers;
-	const struct block_device_operations *bd_op;
 	struct semaphore	bd_sem;	/* open/close mutex */
+	struct list_head	bd_part; /* other opened partitions */
 };
 
 struct inode {
diff -urN linux-2.3.41/include/linux/ide.h linux-bird.bdev/include/linux/ide.h
--- linux-2.3.41/include/linux/ide.h	Fri Jan 28 21:45:48 2000
+++ linux-bird.bdev/include/linux/ide.h	Tue Feb  1 04:07:53 2000
@@ -292,6 +292,7 @@
 	void		*driver_data;	/* extra driver data */
 	struct proc_dir_entry *proc;	/* /proc/ide/ directory entry */
 	void		*settings;	/* /proc/ide/ drive settings */
+	struct disk_struct *disk;	/* disk_struct for disks/floppies/CDs */
 	char		driver_req[10];	/* requests specific driver */
 #if 1
 	struct thresholds_s	*smart_thresholds;
diff -urN linux-2.3.41/include/linux/range_tree.h linux-bird.bdev/include/linux/range_tree.h
--- linux-2.3.41/include/linux/range_tree.h	Wed Dec 31 19:00:00 1969
+++ linux-bird.bdev/include/linux/range_tree.h	Tue Feb  1 04:07:53 2000
@@ -0,0 +1,58 @@
+#ifndef _RANGE_TREE_H
+#define _RANGE_TREE_H
+#include <linux/list.h>
+#include <linux/module.h>
+
+struct range_node;
+/*
+ * Gets a reference to range and element of range; supposed to try to get
+ * smaller range containing the element.
+ */
+
+typedef void range_split_t(struct range_node *, unsigned);
+
+/*
+ * Subranges are kept in array. More accurately, references to them are.
+ * Array is sorted by the subrange (they can't intersect ;-). We keep pairs
+ * (reference to subrange's node , left boundary) there.
+ */
+struct range_ref {
+	unsigned from;
+	struct range_node *node;
+};
+
+/*
+ * Range. 'from' and 'to' are its boundaries, 'subnodes' is its array of
+ * references to subranges, 'subs' is the size of used part of array, 'real' -
+ * it's size. 'child' and 'sibs' host the lists of children - cyclic list starts
+ * at parent's 'child' and goes through 'sibs' of children. List is ordered by
+ * the range. 'parent' points to, erm, parent. For the root node - points to
+ * itself. 'loader' is the subrange-finding function of this range (typically
+ * it loads an appropriate module that registers subrange). 'data' is opaque -
+ * it is set upon range creation and ignored by us. Callers should know what
+ * they placed there and what to do with it. 'owner' refers to the module that
+ * registered the range.
+ */
+struct range_node {
+	unsigned from, to;
+	unsigned subs, real;
+	struct range_ref *subnodes;
+	struct range_node *parent;
+	struct list_head child;
+	struct list_head sibs;
+	range_split_t *loader;
+	struct module *owner;
+	void *data;
+	int locked;
+	int kind;
+};
+
+struct range_node *range_lookup(struct range_node *, unsigned);
+int range_add(struct range_node *, unsigned, unsigned, struct range_node*);
+int range_fit(struct range_node *, unsigned, struct range_node *);
+struct range_node *range_create(void);
+int range_delete(struct range_node *);
+void range_put(struct range_node *node);
+void range_unlock(struct range_node *node);
+void range_trees_init(void);
+#endif
diff -urN linux-2.3.41/init/main.c linux-bird.bdev/init/main.c
--- linux-2.3.41/init/main.c	Thu Jan 20 22:47:32 2000
+++ linux-bird.bdev/init/main.c	Tue Feb  1 04:07:53 2000
@@ -92,6 +92,7 @@
 extern void sysctl_init(void);
 extern void filescache_init(void);
 extern void signals_init(void);
+extern void range_trees_init(void);
 extern void bdev_init(void);
 extern int init_pcmcia_ds(void);
 
@@ -521,6 +522,7 @@
 	page_cache_init(mempages);
 	kiobuf_init();
 	signals_init();
+	range_trees_init();
 	bdev_init();
 	inode_init();
 	file_table_init();
diff -urN linux-2.3.41/kernel/ksyms.c linux-bird.bdev/kernel/ksyms.c
--- linux-2.3.41/kernel/ksyms.c	Fri Jan 28 21:45:49 2000
+++ linux-bird.bdev/kernel/ksyms.c	Tue Feb  1 04:07:53 2000
@@ -262,7 +262,11 @@
 EXPORT_SYMBOL(ioctl_by_bdev);
 EXPORT_SYMBOL(gendisk_head);
 EXPORT_SYMBOL(grok_partitions);
-EXPORT_SYMBOL(register_disk);
+EXPORT_SYMBOL(register_block_driver);
+EXPORT_SYMBOL(unregister_block_driver);
+EXPORT_SYMBOL(__register_disk);
+EXPORT_SYMBOL(unregister_disk);
+EXPORT_SYMBOL(range_unlock);
 EXPORT_SYMBOL(unplug_device);
 EXPORT_SYMBOL(make_request);
 EXPORT_SYMBOL(tq_disk);
diff -urN linux-2.3.41/lib/Makefile linux-bird.bdev/lib/Makefile
--- linux-2.3.41/lib/Makefile	Mon Nov 27 08:54:00 1995
+++ linux-bird.bdev/lib/Makefile	Tue Feb  1 04:07:53 2000
@@ -7,6 +7,6 @@
 #
 
 L_TARGET := lib.a
-L_OBJS   := errno.o ctype.o string.o vsprintf.o
+L_OBJS   := errno.o ctype.o string.o vsprintf.o range_tree.o
 
 include $(TOPDIR)/Rules.make
diff -urN linux-2.3.41/lib/range_tree.c linux-bird.bdev/lib/range_tree.c
--- linux-2.3.41/lib/range_tree.c	Wed Dec 31 19:00:00 1969
+++ linux-bird.bdev/lib/range_tree.c	Tue Feb  1 04:07:53 2000
@@ -0,0 +1,296 @@
+#include <linux/range_tree.h>
+#include <linux/malloc.h>
+
+#define DEBUG_RANGES
+
+static rwlock_t ranges_lock = RW_LOCK_UNLOCKED;
+static kmem_cache_t * range_cachep;
+static DECLARE_WAIT_QUEUE_HEAD(ranges_wait);
+
+#define alloc_range() \
+	 ((struct range_node *) kmem_cache_alloc(range_cachep, SLAB_KERNEL))
+#define destroy_range(range) kmem_cache_free(range_cachep, (range))
+
+static inline struct range_ref *__range_find(struct range_ref *p, unsigned n,
+						unsigned key)
+{
+	unsigned m;
+	struct range_ref *q;
+	while (n > 1) {
+		m = n/2;
+		q = p + m;
+		if (q->from > key)
+			n = m;
+		else {
+			p = q;
+			n -= m;
+		}
+	}
+	return p;
+}
+
+static struct range_node *__range_lookup(struct range_node *node, unsigned key)
+{
+	struct range_node *next;
+	struct range_ref *p;
+	read_lock(&ranges_lock);
+	while (1) {
+		if (node->locked)
+			goto locked;
+		if (!node->subs)
+			break;
+		p = __range_find(node->subnodes, node->subs, key);
+		next = p->node;	
+		if (key > next->to)
+			break;
+		/* Did we go before the first subrange? */
+		if (key <next->from)
+			break;
+		node = next;
+	}
+	if (node->owner)
+		__MOD_INC_USE_COUNT(node->owner);
+out:
+	read_unlock(&ranges_lock);
+	return node;
+locked:
+	node = NULL;
+	goto out;
+}
+
+struct range_node *range_create(void)
+{
+	struct range_node *p = alloc_range();
+	if (p)
+		p->locked = 1;
+	return p;
+}
+
+static inline int __range_add(struct range_node *node, unsigned index,
+			unsigned from, unsigned to, struct range_node *child)
+{
+	struct range_ref *p;
+	unsigned i;
+
+	/* need to expand? */
+	if (node->subs == node->real) {
+		/* Had anything? */
+		if (!node->real) {
+			node->subnodes = kmalloc(32*sizeof(struct range_ref),
+						 GFP_KERNEL);
+			if (!node->subnodes)
+				return -ENOMEM;
+			node->real = 32;
+		} else {
+			void *p;
+			p = kmalloc(node->real*2*sizeof(struct range_ref),
+						 GFP_KERNEL);
+			if (!p)
+				return -ENOMEM;
+			memcpy(p, node->subnodes,
+				node->real*sizeof(struct range_ref));
+			kfree(node->subnodes);
+			node->subnodes = p;
+		}
+	}
+	child->from = from;
+	child->to = to;
+	/* We need to shift everything starting from node->subnodes+index */
+	for (i=node->subs, p=node->subnodes+i; i>index; p[0]=p[-1], p--, i--)
+		;
+	p->from = from;
+	p->node = child;
+	node->subs++;
+	child->parent = node;
+	if (index)
+		list_add(&child->sibs, &p[-1].node->sibs);
+	else
+		list_add(&child->sibs, &node->child);
+	return 0;
+}
+
+int range_add(struct range_node *node, unsigned from,
+			       unsigned to, struct range_node *child)
+{
+	int err = -EBUSY;
+	unsigned i = 0;
+	struct range_ref *p;
+
+#ifdef DEBUG_RANGES
+	printk(KERN_INFO "range_add: %4x--%4x\n", from, to);
+#endif
+
+	write_lock(&ranges_lock);
+
+	if (!node->subs)
+		goto found;
+	p = __range_find(node->subnodes, node->subs, from);
+	/* Before the first subrange? */
+	if (from < p->from)
+		goto found;
+	if (from <= p->node->to)
+		goto fail;
+	i = (p - node->subnodes) + 1;
+found:
+	err = -EINVAL;
+	if (from < node->from || to > node->to || from > to)
+		goto fail;
+	err = __range_add(node,i,from,to,child);
+fail:
+	write_unlock(&ranges_lock);
+	return err;
+}
+
+int range_fit(struct range_node *node, unsigned size,
+			       struct range_node *child)
+{
+	int i, err = -EBUSY;
+	unsigned long base;
+	struct range_ref *p;
+
+	write_lock(&ranges_lock);
+
+	for (i=0, base=node->from, p=node->subnodes; i<node->subs; i++, p++) {
+		if (p->from >= base+size)
+			goto found;
+		base = p->node->to;
+		base++;
+	}
+	if (base + size - 1 > node->to)
+		goto fail;
+found:
+	err = __range_add(node,i,(unsigned)base,(unsigned)(base+size-1),child);
+fail:
+	write_unlock(&ranges_lock);
+	return err;
+}
+
+int range_delete(struct range_node *node)
+{
+	int err = -EBUSY;
+
+#ifdef DEBUG_RANGES
+	printk(KERN_INFO "range_delete: %4x--%4x\n", node->from, node->to);
+#endif
+
+	write_lock(&ranges_lock);
+	if (node->subs) 
+		goto fail;
+	if (node->real)
+		kfree(node->subnodes);
+	node->real = 0;
+	if (node->parent) {
+		struct range_ref *p;
+		int i;
+		err = -EINVAL;
+		if (!node->parent->subs)
+			goto fail;
+		p = __range_find(node->parent->subnodes,
+				 node->parent->subs,
+				 node->from);
+		if (p->node != node)
+			goto fail;
+		for(i = p-node->parent->subnodes;
+		    i<node->parent->subs-1;
+		    p[0]=p[1], p++, i++)
+			;
+		node->parent->subs--;
+		list_del(&node->sibs);
+		node->parent = NULL;
+		node->kind = 0;
+		node->loader = NULL;
+		node->owner = NULL;
+		node->data = NULL;
+		if (node->locked) {
+			node->locked = 0;
+			wake_up(&ranges_wait);
+		}
+	}
+	INIT_LIST_HEAD(&node->sibs);
+	err = 0;
+	destroy_range(node);
+fail:
+	write_unlock(&ranges_lock);
+	return err;
+}
+
+void range_put(struct range_node *node)
+{
+	if (node->owner)
+		__MOD_DEC_USE_COUNT(node->owner);
+}
+
+void range_unlock(struct range_node *node)
+{
+#ifdef DEBUG_RANGES
+	printk(KERN_INFO "range_unlock: %4x--%4x\n", node->from, node->to);
+#endif
+	write_lock(&ranges_lock);
+	node->locked = 0;
+	write_unlock(&ranges_lock);
+	wake_up(&ranges_wait);
+}
+
+struct range_node *range_lookup(struct range_node *node, unsigned key)
+{
+	struct range_node *p, *q;
+retry:
+#ifdef DEBUG_RANGES
+	printk(KERN_INFO "range_lookup(%4x): %4x--%4x\n", key, node->from, node->to);
+#endif
+	q = __range_lookup(node, key);
+	if (!q)
+		goto locked;
+	while (q->loader) {
+		q->loader(q, key);
+#ifdef DEBUG_RANGES
+	printk(KERN_INFO "range_lookup(%4x): %4x--%4x\n", key, q->from, q->to);
+#endif
+		p = __range_lookup(q, key);
+		range_put(q);
+		if (!p)
+			goto locked;
+		if (p == q)
+			break;
+		q = p;
+	}
+	return q;
+locked:
+	/*
+	 * We met a locked range. It means that somebody had allocated it
+	 * and right now allocates subranges there. We just sleep and restart
+	 * from square one once some range gets unlocked. Yes, it might be
+	 * made less coarse. We don't need that - to start with, it's a slow
+	 * path and it's taken only when we get a lookup into the range while
+	 * the module is initializing (lookup that lead to module loading will
+	 * not go here - usually it will sleep in request_module()). In theory
+	 * we might want to sleep on class of range, but I doubt that it will
+	 * actually buy us anything.
+	 */
+
+	sleep_on(&ranges_wait);
+	goto retry;
+}
+
+static void init_once(void * p, kmem_cache_t * cachep, unsigned long flags)
+{
+	struct range_node * node = (struct range_node *) p;
+
+	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
+	    SLAB_CTOR_CONSTRUCTOR)
+	{
+		memset(node, 0, sizeof(*node));
+		INIT_LIST_HEAD(&node->sibs);
+		INIT_LIST_HEAD(&node->child);
+	}
+}
+
+void range_trees_init(void)
+{
+	range_cachep = kmem_cache_create("range_cache",
+					 sizeof(struct range_node),
+					 0, SLAB_HWCACHE_ALIGN, init_once,
+					 NULL);
+	if (!range_cachep)
+		panic("cannot create range slab cache");
+}

