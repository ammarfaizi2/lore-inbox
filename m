Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288810AbSA2NPW>; Tue, 29 Jan 2002 08:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288845AbSA2NPH>; Tue, 29 Jan 2002 08:15:07 -0500
Received: from ns.caldera.de ([212.34.180.1]:46771 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S288810AbSA2NN7>;
	Tue, 29 Jan 2002 08:13:59 -0500
Date: Tue, 29 Jan 2002 14:13:39 +0100
Message-Id: <200201291313.g0TDDd716906@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: dalecki@evision-ventures.com (Martin Dalecki)
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com, axboe@suse.de
Subject: Re: A modest proposal -- We need a patch penguin
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <3C568C52.2060707@evision-ventures.com>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.13 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

In article <3C568C52.2060707@evision-ventures.com> you wrote:
>>One "patch penguin" scales no better than I do. In fact, I will claim
>>that most of them scale a whole lot worse. 
>>
> Bla bla bla... Just tell how frequenty do I have to tell the world, that 
> the read_ahead array is a write
> only variable inside the kernel and therefore not used at 
> all?????!!!!!!!!!!

It IS used. (hint: take a look at fs/hfs/file.c).

I still don't think maintainig this array is worth just for hfs
readahead, so the below patch disables it and gets rid of read_ahead.

Jens, could you check the patch and include it in your next batch of
block-layer changes for Linus?

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.


diff -uNr -Xdontdiff ../master/linux-2.5.3-pre6/drivers/acorn/block/mfmhd.c linux/drivers/acorn/block/mfmhd.c
--- ../master/linux-2.5.3-pre6/drivers/acorn/block/mfmhd.c	Tue Jan 15 10:59:05 2002
+++ linux/drivers/acorn/block/mfmhd.c	Tue Jan 29 14:07:41 2002
@@ -1442,7 +1442,6 @@
 	hdc63463_irqpollmask	= irqmask;
 
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
-	read_ahead[MAJOR_NR] = 8;	/* 8 sector (4kB?) read ahread */
 
 	add_gendisk(&mfm_gendisk);
 
diff -uNr -Xdontdiff ../master/linux-2.5.3-pre6/drivers/block/DAC960.c linux/drivers/block/DAC960.c
--- ../master/linux-2.5.3-pre6/drivers/block/DAC960.c	Tue Jan 15 10:59:05 2002
+++ linux/drivers/block/DAC960.c	Tue Jan 29 13:57:06 2002
@@ -1964,10 +1964,6 @@
   Controller->GenericDiskInfo.sizes = Controller->PartitionSizes;
   blksize_size[MajorNumber] = Controller->BlockSizes;
   /*
-    Initialize Read Ahead to 128 sectors.
-  */
-  read_ahead[MajorNumber] = 128;
-  /*
     Complete initialization of the Generic Disk Information structure.
   */
   Controller->GenericDiskInfo.major = MajorNumber;
diff -uNr -Xdontdiff ../master/linux-2.5.3-pre6/drivers/block/acsi.c linux/drivers/block/acsi.c
--- ../master/linux-2.5.3-pre6/drivers/block/acsi.c	Tue Jan 15 10:59:05 2002
+++ linux/drivers/block/acsi.c	Tue Jan 29 13:57:19 2002
@@ -1785,7 +1785,6 @@
 	STramMask = ATARIHW_PRESENT(EXTD_DMA) ? 0x00000000 : 0xff000000;
 	
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST, &acsi_lock);
-	read_ahead[MAJOR_NR] = 8;		/* 8 sector (4kB) read-ahead */
 	add_gendisk(&acsi_gendisk);
 
 #ifdef CONFIG_ATARI_SLM
diff -uNr -Xdontdiff ../master/linux-2.5.3-pre6/drivers/block/blkpg.c linux/drivers/block/blkpg.c
--- ../master/linux-2.5.3-pre6/drivers/block/blkpg.c	Tue Jan 15 10:59:05 2002
+++ linux/drivers/block/blkpg.c	Tue Jan 29 13:58:51 2002
@@ -227,18 +227,6 @@
 			intval = (is_read_only(dev) != 0);
 			return put_user(intval, (int *)(arg));
 
-		case BLKRASET:
-			if(!capable(CAP_SYS_ADMIN))
-				return -EACCES;
-			if(arg > 0xff)
-				return -EINVAL;
-			read_ahead[major(dev)] = arg;
-			return 0;
-		case BLKRAGET:
-			if (!arg)
-				return -EINVAL;
-			return put_user(read_ahead[major(dev)], (long *) arg);
-
 		case BLKFRASET:
 			if (!capable(CAP_SYS_ADMIN))
 				return -EACCES;
@@ -319,6 +307,9 @@
 			set_blocksize(dev, intval);
 			return 0;
 
+		case BLKRASET:
+		case BLKRAGET:
+			/* this information is no more used by the kernel */
 		default:
 			return -EINVAL;
 	}
diff -uNr -Xdontdiff ../master/linux-2.5.3-pre6/drivers/block/cciss.c linux/drivers/block/cciss.c
--- ../master/linux-2.5.3-pre6/drivers/block/cciss.c	Tue Jan 29 11:24:20 2002
+++ linux/drivers/block/cciss.c	Tue Jan 29 13:59:03 2002
@@ -2542,7 +2542,6 @@
 
 	/* fill in the other Kernel structs */
 	blksize_size[MAJOR_NR+i] = hba[i]->blocksizes;
-        read_ahead[MAJOR_NR+i] = READ_AHEAD;
 
 	/* Fill in the gendisk data */ 	
 	hba[i]->gendisk.major = MAJOR_NR + i;
diff -uNr -Xdontdiff ../master/linux-2.5.3-pre6/drivers/block/cpqarray.c linux/drivers/block/cpqarray.c
--- ../master/linux-2.5.3-pre6/drivers/block/cpqarray.c	Tue Jan 15 10:59:05 2002
+++ linux/drivers/block/cpqarray.c	Tue Jan 29 13:59:14 2002
@@ -481,7 +481,6 @@
 		blk_queue_max_phys_segments(q, SG_MAX);
 
 		blksize_size[MAJOR_NR+i] = ida_blocksizes + (i*256);
-		read_ahead[MAJOR_NR+i] = READ_AHEAD;
 
 		ida_gendisk[i].major = MAJOR_NR + i;
 		ida_gendisk[i].major_name = "ida";
diff -uNr -Xdontdiff ../master/linux-2.5.3-pre6/drivers/block/ll_rw_blk.c linux/drivers/block/ll_rw_blk.c
--- ../master/linux-2.5.3-pre6/drivers/block/ll_rw_blk.c	Tue Jan 29 11:24:20 2002
+++ linux/drivers/block/ll_rw_blk.c	Tue Jan 29 13:59:28 2002
@@ -54,10 +54,6 @@
  */
 DECLARE_TASK_QUEUE(tq_disk);
 
-/* This specifies how many sectors to read ahead on the disk. */
-
-int read_ahead[MAX_BLKDEV];
-
 /* blk_dev_struct is:
  *	request_queue
  *	*queue
diff -uNr -Xdontdiff ../master/linux-2.5.3-pre6/drivers/block/paride/pcd.c linux/drivers/block/paride/pcd.c
--- ../master/linux-2.5.3-pre6/drivers/block/paride/pcd.c	Tue Jan 15 10:59:05 2002
+++ linux/drivers/block/paride/pcd.c	Tue Jan 29 14:00:33 2002
@@ -358,7 +358,6 @@
 	}
 
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST, &pcd_lock);
-	read_ahead[MAJOR_NR] = 8;	/* 8 sector (4kB) read ahead */
 
 	for (i=0;i<PCD_UNITS;i++) pcd_blocksizes[i] = 1024;
         blksize_size[MAJOR_NR] = pcd_blocksizes;
diff -uNr -Xdontdiff ../master/linux-2.5.3-pre6/drivers/block/paride/pd.c linux/drivers/block/paride/pd.c
--- ../master/linux-2.5.3-pre6/drivers/block/paride/pd.c	Tue Jan 15 10:59:05 2002
+++ linux/drivers/block/paride/pd.c	Tue Jan 29 14:00:41 2002
@@ -397,7 +397,6 @@
 	q = BLK_DEFAULT_QUEUE(MAJOR_NR);
 	blk_init_queue(q, DEVICE_REQUEST, &pd_lock);
 	blk_queue_max_sectors(q, cluster);
-        read_ahead[MAJOR_NR] = 8;       /* 8 sector (4kB) read ahead */
         
 	pd_gendisk.major = major;
 	pd_gendisk.major_name = name;
diff -uNr -Xdontdiff ../master/linux-2.5.3-pre6/drivers/block/paride/pf.c linux/drivers/block/paride/pf.c
--- ../master/linux-2.5.3-pre6/drivers/block/paride/pf.c	Tue Jan 29 11:24:20 2002
+++ linux/drivers/block/paride/pf.c	Tue Jan 29 14:00:23 2002
@@ -363,7 +363,6 @@
 	blk_init_queue(q, DEVICE_REQUEST, &pf_spin_lock);
 	blk_queue_max_phys_segments(q, cluster);
 	blk_queue_max_hw_segments(q, cluster);
-        read_ahead[MAJOR_NR] = 8;       /* 8 sector (4kB) read ahead */
         
 	for (i=0;i<PF_UNITS;i++) pf_blocksizes[i] = 1024;
 	blksize_size[MAJOR_NR] = pf_blocksizes;
diff -uNr -Xdontdiff ../master/linux-2.5.3-pre6/drivers/block/ps2esdi.c linux/drivers/block/ps2esdi.c
--- ../master/linux-2.5.3-pre6/drivers/block/ps2esdi.c	Tue Jan 29 11:24:20 2002
+++ linux/drivers/block/ps2esdi.c	Tue Jan 29 14:00:11 2002
@@ -177,8 +177,6 @@
 	}
 	/* set up some global information - indicating device specific info */
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST, &ps2esdi_lock);
-	read_ahead[MAJOR_NR] = 8;	/* 8 sector (4kB) read ahead */
-
 	/* some minor housekeeping - setup the global gendisk structure */
 	add_gendisk(&ps2esdi_gendisk);
 	ps2esdi_geninit();
diff -uNr -Xdontdiff ../master/linux-2.5.3-pre6/drivers/block/xd.c linux/drivers/block/xd.c
--- ../master/linux-2.5.3-pre6/drivers/block/xd.c	Tue Jan 15 10:59:05 2002
+++ linux/drivers/block/xd.c	Tue Jan 29 13:59:39 2002
@@ -171,7 +171,6 @@
 	}
 	devfs_handle = devfs_mk_dir (NULL, xd_gendisk.major_name, NULL);
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST, &xd_lock);
-	read_ahead[MAJOR_NR] = 8;	/* 8 sector (4kB) read ahead */
 	add_gendisk(&xd_gendisk);
 	xd_geninit();
 
diff -uNr -Xdontdiff ../master/linux-2.5.3-pre6/drivers/cdrom/aztcd.c linux/drivers/cdrom/aztcd.c
--- ../master/linux-2.5.3-pre6/drivers/cdrom/aztcd.c	Tue Jan 15 10:59:05 2002
+++ linux/drivers/cdrom/aztcd.c	Tue Jan 29 14:05:15 2002
@@ -1927,7 +1927,6 @@
 	}
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST, &aztSpin);
 	blksize_size[MAJOR_NR] = aztcd_blocksizes;
-	read_ahead[MAJOR_NR] = 4;
 	register_disk(NULL, mk_kdev(MAJOR_NR, 0), 1, &azt_fops, 0);
 
 	if ((azt_port == 0x1f0) || (azt_port == 0x170))
diff -uNr -Xdontdiff ../master/linux-2.5.3-pre6/drivers/cdrom/cdu31a.c linux/drivers/cdrom/cdu31a.c
--- ../master/linux-2.5.3-pre6/drivers/cdrom/cdu31a.c	Tue Jan 15 10:59:05 2002
+++ linux/drivers/cdrom/cdu31a.c	Tue Jan 29 14:05:21 2002
@@ -3442,7 +3442,6 @@
 		blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR),
 			       DEVICE_REQUEST,
 			       &cdu31a_lock);
-		read_ahead[MAJOR_NR] = CDU31A_READAHEAD;
 		cdu31a_block_size = 1024;	/* 1kB default block size */
 		/* use 'mount -o block=2048' */
 		blksize_size[MAJOR_NR] = &cdu31a_block_size;
diff -uNr -Xdontdiff ../master/linux-2.5.3-pre6/drivers/cdrom/cm206.c linux/drivers/cdrom/cm206.c
--- ../master/linux-2.5.3-pre6/drivers/cdrom/cm206.c	Tue Jan 15 10:59:06 2002
+++ linux/drivers/cdrom/cm206.c	Tue Jan 29 14:05:43 2002
@@ -1503,7 +1503,6 @@
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST,
 		       &cm206_lock);
 	blksize_size[MAJOR_NR] = cm206_blocksizes;
-	read_ahead[MAJOR_NR] = 16;	/* reads ahead what? */
 	init_bh(CM206_BH, cm206_bh);
 
 	memset(cd, 0, sizeof(*cd));	/* give'm some reasonable value */
diff -uNr -Xdontdiff ../master/linux-2.5.3-pre6/drivers/cdrom/gscd.c linux/drivers/cdrom/gscd.c
--- ../master/linux-2.5.3-pre6/drivers/cdrom/gscd.c	Tue Jan 15 10:59:06 2002
+++ linux/drivers/cdrom/gscd.c	Tue Jan 29 14:05:50 2002
@@ -1022,7 +1022,6 @@
 
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST, &gscd_lock);
 	blksize_size[MAJOR_NR] = gscd_blocksizes;
-	read_ahead[MAJOR_NR] = 4;
 
 	disk_state = 0;
 	gscdPresent = 1;
diff -uNr -Xdontdiff ../master/linux-2.5.3-pre6/drivers/cdrom/mcd.c linux/drivers/cdrom/mcd.c
--- ../master/linux-2.5.3-pre6/drivers/cdrom/mcd.c	Tue Jan 15 10:59:06 2002
+++ linux/drivers/cdrom/mcd.c	Tue Jan 29 14:05:56 2002
@@ -1075,7 +1075,6 @@
 	blksize_size[MAJOR_NR] = mcd_blocksizes;
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST,
 		       &mcd_spinlock);
-	read_ahead[MAJOR_NR] = 4;
 
 	/* check for card */
 
diff -uNr -Xdontdiff ../master/linux-2.5.3-pre6/drivers/cdrom/mcdx.c linux/drivers/cdrom/mcdx.c
--- ../master/linux-2.5.3-pre6/drivers/cdrom/mcdx.c	Tue Jan 15 10:59:06 2002
+++ linux/drivers/cdrom/mcdx.c	Tue Jan 29 14:06:01 2002
@@ -1184,7 +1184,6 @@
 
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST,
 		       &mcdx_lock);
-	read_ahead[MAJOR_NR] = READ_AHEAD;
 	blksize_size[MAJOR_NR] = mcdx_blocksizes;
 
 	xtrace(INIT, "init() subscribe irq and i/o\n");
diff -uNr -Xdontdiff ../master/linux-2.5.3-pre6/drivers/cdrom/optcd.c linux/drivers/cdrom/optcd.c
--- ../master/linux-2.5.3-pre6/drivers/cdrom/optcd.c	Tue Jan 15 10:59:06 2002
+++ linux/drivers/cdrom/optcd.c	Tue Jan 29 14:06:06 2002
@@ -2062,7 +2062,6 @@
 	blksize_size[MAJOR_NR] = &blksize;
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST,
 		       &optcd_lock);
-	read_ahead[MAJOR_NR] = 4;
 	request_region(optcd_port, 4, "optcd");
 	register_disk(NULL, mk_kdev(MAJOR_NR,0), 1, &opt_fops, 0);
 
diff -uNr -Xdontdiff ../master/linux-2.5.3-pre6/drivers/cdrom/sbpcd.c linux/drivers/cdrom/sbpcd.c
--- ../master/linux-2.5.3-pre6/drivers/cdrom/sbpcd.c	Tue Jan 15 10:59:06 2002
+++ linux/drivers/cdrom/sbpcd.c	Tue Jan 29 14:07:22 2002
@@ -4532,11 +4532,7 @@
 	} /* end of CDROMREADAUDIO */
 		
 	case BLKRASET:
-		if(!capable(CAP_SYS_ADMIN)) RETURN_UP(-EACCES);
-		if(kdev_none(cdi->dev)) RETURN_UP(-EINVAL);
-		if(arg > 0xff) RETURN_UP(-EINVAL);
-		read_ahead[major(cdi->dev)] = arg;
-		RETURN_UP(0);
+		return -EINVAL;
 	default:
 		msg(DBG_IOC,"ioctl: unknown function request %04X\n", cmd);
 		RETURN_UP(-EINVAL);
@@ -5870,7 +5866,6 @@
 	(BLK_DEFAULT_QUEUE(MAJOR_NR))->front_merge_fn = dont_bh_merge_fn;
 	(BLK_DEFAULT_QUEUE(MAJOR_NR))->merge_requests_fn = dont_merge_requests_fn;
 #endif
-	read_ahead[MAJOR_NR] = buffers * (CD_FRAMESIZE / 512);
 	
 	request_region(CDo_command,4,major_name);
 	
diff -uNr -Xdontdiff ../master/linux-2.5.3-pre6/drivers/cdrom/sjcd.c linux/drivers/cdrom/sjcd.c
--- ../master/linux-2.5.3-pre6/drivers/cdrom/sjcd.c	Tue Jan 15 10:59:06 2002
+++ linux/drivers/cdrom/sjcd.c	Tue Jan 29 14:06:10 2002
@@ -1695,7 +1695,6 @@
 	}
 
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST,&sjcd_lock);
-	read_ahead[MAJOR_NR] = 4;
 	register_disk(NULL, mk_kdev(MAJOR_NR, 0), 1, &sjcd_fops, 0);
 
 	if (check_region(sjcd_base, 4)) {
diff -uNr -Xdontdiff ../master/linux-2.5.3-pre6/drivers/cdrom/sonycd535.c linux/drivers/cdrom/sonycd535.c
--- ../master/linux-2.5.3-pre6/drivers/cdrom/sonycd535.c	Tue Jan 15 10:59:06 2002
+++ linux/drivers/cdrom/sonycd535.c	Tue Jan 29 14:06:16 2002
@@ -1598,7 +1598,6 @@
 				}
 				blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST, &sonycd535_lock);
 				blksize_size[MAJOR_NR] = &sonycd535_block_size;
-				read_ahead[MAJOR_NR] = 8;	/* 8 sector (4kB) read-ahead */
 
 				sony_toc = (struct s535_sony_toc *)
 					kmalloc(sizeof *sony_toc, GFP_KERNEL);
diff -uNr -Xdontdiff ../master/linux-2.5.3-pre6/drivers/ide/hd.c linux/drivers/ide/hd.c
--- ../master/linux-2.5.3-pre6/drivers/ide/hd.c	Tue Jan 15 10:59:06 2002
+++ linux/drivers/ide/hd.c	Tue Jan 29 14:04:07 2002
@@ -837,7 +837,6 @@
 	}
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST, &hd_lock);
 	blk_queue_max_sectors(BLK_DEFAULT_QUEUE(MAJOR_NR), 255);
-	read_ahead[MAJOR_NR] = 8;		/* 8 sector (4kB) read-ahead */
 	add_gendisk(&hd_gendisk);
 	init_timer(&device_timer);
 	device_timer.function = hd_times_out;
diff -uNr -Xdontdiff ../master/linux-2.5.3-pre6/drivers/ide/ide-cd.c linux/drivers/ide/ide-cd.c
--- ../master/linux-2.5.3-pre6/drivers/ide/ide-cd.c	Tue Jan 29 11:24:20 2002
+++ linux/drivers/ide/ide-cd.c	Tue Jan 29 14:04:51 2002
@@ -2662,7 +2662,6 @@
 	int major = HWIF(drive)->major;
 	int minor = drive->select.b.unit << PARTN_BITS;
 
-	ide_add_setting(drive,	"breada_readahead",	SETTING_RW, BLKRAGET, BLKRASET, TYPE_INT, 0, 255, 1, 2, &read_ahead[major], NULL);
 	ide_add_setting(drive,	"file_readahead",	SETTING_RW, BLKFRAGET, BLKFRASET, TYPE_INTA, 0, INT_MAX, 1, 1024, &max_readahead[major][minor],	NULL);
 	ide_add_setting(drive,	"dsc_overlap",		SETTING_RW, -1, -1, TYPE_BYTE, 0, 1, 1,	1, &drive->dsc_overlap, NULL);
 }
diff -uNr -Xdontdiff ../master/linux-2.5.3-pre6/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- ../master/linux-2.5.3-pre6/drivers/ide/ide-disk.c	Tue Jan 29 11:24:20 2002
+++ linux/drivers/ide/ide-disk.c	Tue Jan 29 14:04:45 2002
@@ -931,7 +931,6 @@
 	ide_add_setting(drive,	"bswap",		SETTING_READ,					-1,			-1,			TYPE_BYTE,	0,	1,				1,	1,	&drive->bswap,			NULL);
 	ide_add_setting(drive,	"multcount",		id ? SETTING_RW : SETTING_READ,			HDIO_GET_MULTCOUNT,	HDIO_SET_MULTCOUNT,	TYPE_BYTE,	0,	id ? id->max_multsect : 0,	1,	1,	&drive->mult_count,		set_multcount);
 	ide_add_setting(drive,	"nowerr",		SETTING_RW,					HDIO_GET_NOWERR,	HDIO_SET_NOWERR,	TYPE_BYTE,	0,	1,				1,	1,	&drive->nowerr,			set_nowerr);
-	ide_add_setting(drive,	"breada_readahead",	SETTING_RW,					BLKRAGET,		BLKRASET,		TYPE_INT,	0,	255,				1,	1,	&read_ahead[major],		NULL);
 	ide_add_setting(drive,	"file_readahead",	SETTING_RW,					BLKFRAGET,		BLKFRASET,		TYPE_INTA,	0,	4096,			PAGE_SIZE,	1024,	&max_readahead[major][minor],	NULL);
 	ide_add_setting(drive,	"lun",			SETTING_RW,					-1,			-1,			TYPE_INT,	0,	7,				1,	1,	&drive->lun,			NULL);
 	ide_add_setting(drive,	"wcache",		SETTING_RW,					HDIO_GET_WCACHE,	HDIO_SET_WCACHE,	TYPE_BYTE,	0,	1,				1,	1,	&drive->wcache,			write_cache);
diff -uNr -Xdontdiff ../master/linux-2.5.3-pre6/drivers/ide/ide-floppy.c linux/drivers/ide/ide-floppy.c
--- ../master/linux-2.5.3-pre6/drivers/ide/ide-floppy.c	Tue Jan 29 11:24:20 2002
+++ linux/drivers/ide/ide-floppy.c	Tue Jan 29 14:04:40 2002
@@ -1968,7 +1968,6 @@
 	ide_add_setting(drive,	"bios_cyl",		SETTING_RW,					-1,			-1,			TYPE_INT,	0,	1023,				1,	1,	&drive->bios_cyl,		NULL);
 	ide_add_setting(drive,	"bios_head",		SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	255,				1,	1,	&drive->bios_head,		NULL);
 	ide_add_setting(drive,	"bios_sect",		SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	63,				1,	1,	&drive->bios_sect,		NULL);
-	ide_add_setting(drive,	"breada_readahead",	SETTING_RW,					BLKRAGET,		BLKRASET,		TYPE_INT,	0,	255,				1,	2,	&read_ahead[major],		NULL);
 	ide_add_setting(drive,	"file_readahead",	SETTING_RW,					BLKFRAGET,		BLKFRASET,		TYPE_INTA,	0,	INT_MAX,			1,	1024,	&max_readahead[major][minor],	NULL);
 
 }
diff -uNr -Xdontdiff ../master/linux-2.5.3-pre6/drivers/ide/ide-probe.c linux/drivers/ide/ide-probe.c
--- ../master/linux-2.5.3-pre6/drivers/ide/ide-probe.c	Tue Jan 29 11:24:20 2002
+++ linux/drivers/ide/ide-probe.c	Tue Jan 29 14:04:22 2002
@@ -937,7 +937,6 @@
 	init_gendisk(hwif);
 	blk_dev[hwif->major].data = hwif;
 	blk_dev[hwif->major].queue = ide_get_queue;
-	read_ahead[hwif->major] = 8;	/* (4kB) */
 	hwif->present = 1;	/* success */
 
 	return hwif->present;
diff -uNr -Xdontdiff ../master/linux-2.5.3-pre6/drivers/md/md.c linux/drivers/md/md.c
--- ../master/linux-2.5.3-pre6/drivers/md/md.c	Tue Jan 29 11:24:21 2002
+++ linux/drivers/md/md.c	Tue Jan 29 13:56:35 2002
@@ -1737,7 +1737,6 @@
 	register_disk(&md_gendisk, mk_kdev(MAJOR_NR,mdidx(mddev)),
 			1, &md_fops, md_size[mdidx(mddev)]<<1);
 
-	read_ahead[MD_MAJOR] = 1024;
 	return (0);
 }
 
@@ -3177,11 +3176,7 @@
 	sz += sprintf(page+sz, "\n");
 
 
-	sz += sprintf(page+sz, "read_ahead ");
-	if (read_ahead[MD_MAJOR] == INT_MAX)
-		sz += sprintf(page+sz, "not set\n");
-	else
-		sz += sprintf(page+sz, "%d sectors\n", read_ahead[MD_MAJOR]);
+	sz += sprintf(page+sz, "read_ahead not set\n");
 
 	ITERATE_MDDEV(mddev,tmp) {
 		sz += sprintf(page + sz, "md%d : %sactive", mdidx(mddev),
diff -uNr -Xdontdiff ../master/linux-2.5.3-pre6/drivers/s390/block/xpram.c linux/drivers/s390/block/xpram.c
--- ../master/linux-2.5.3-pre6/drivers/s390/block/xpram.c	Tue Jan 15 10:59:08 2002
+++ linux/drivers/s390/block/xpram.c	Tue Jan 29 14:02:25 2002
@@ -163,12 +163,11 @@
 
 static int major    = XPRAM_MAJOR;
 static int devs     = XPRAM_DEVS;
-static int rahead   = XPRAM_RAHEAD;
 static int sizes[XPRAM_MAX_DEVS] = { 0, };
 static int blksize  = XPRAM_BLKSIZE;
 static int hardsect = XPRAM_HARDSECT;
 
-int xpram_devs, xpram_rahead;
+int xpram_devs;
 int xpram_blksize, xpram_hardsect;
 int xpram_mem_avail = 0;
 unsigned long xpram_sizes[XPRAM_MAX_DEVS];
@@ -660,21 +659,7 @@
 		return 0;
 
 	case BLKRAGET: /* return the readahead value, 0x1263 */
-		if (!arg)  return -EINVAL;
-		err = 0; /* verify_area_20(VERIFY_WRITE, (long *) arg, sizeof(long));
-		          * if (err) return err;
-                          */
-		put_user(read_ahead[MAJOR(inode->i_rdev)], (long *)arg);
-
-		return 0;
-
 	case BLKRASET: /* set the readahead value, 0x1262 */
-		if (!capable(CAP_SYS_ADMIN)) return -EACCES;
-		if (arg > 0xff) return -EINVAL; /* limit it */
-		read_ahead[MAJOR(inode->i_rdev)] = arg;
-                atomic_eieio();
-		return 0;
-
 	case BLKRRPART: /* re-read partition table: can't do it, 0x1259 */
 		return -EINVAL;
 
@@ -685,7 +670,6 @@
 						* BLKROGET
                                                 */
 #endif /* V22 */
-
 	case HDIO_GETGEO:
 		/*
 		 * get geometry: we have to fake one...  trim the size to a
@@ -940,7 +924,6 @@
 				 * snoozing with a debugger.
 				 */
 
-	xpram_rahead   = rahead;
 	xpram_blksize  = blksize;
 	xpram_hardsect = hardsect;
 
@@ -1029,7 +1012,7 @@
 	PRINT_INFO("  %d kB expanded memory found.\n",xpram_mem_avail );
 
 	/*
-	 * Assign the other needed values: request, rahead, size, blksize,
+	 * Assign the other needed values: request, size, blksize,
 	 * hardsect. All the minor devices feature the same value.
 	 * Note that `xpram' defines all of them to allow testing non-default
 	 * values. A real device could well avoid setting values in global
@@ -1042,7 +1025,6 @@
 	q = BLK_DEFAULT_QUEUE (major);
 	blk_init_queue (q, xpram_request);
 #endif /* V22/V24 */
-	read_ahead[major] = xpram_rahead;
 
 	/* we want to have XPRAM_UNUSED blocks security buffer between devices */
 	mem_usable=xpram_mem_avail-(XPRAM_UNUSED*(xpram_devs-1));
@@ -1181,7 +1163,6 @@
 	kfree(xpram_hardsects);
 	hardsect_size[major] = NULL;
  fail_malloc:
-	read_ahead[major] = 0;
 #if (XPRAM_VERSION == 22)
 	blk_dev[major].request_fn = NULL;
 #endif /* V22 */
diff -uNr -Xdontdiff ../master/linux-2.5.3-pre6/drivers/s390/char/tapeblock.c linux/drivers/s390/char/tapeblock.c
--- ../master/linux-2.5.3-pre6/drivers/s390/char/tapeblock.c	Sat Dec 22 20:06:57 2001
+++ linux/drivers/s390/char/tapeblock.c	Tue Jan 29 14:02:34 2002
@@ -101,7 +101,6 @@
     }
     if (tapeblock_major == 0) tapeblock_major = result;   /* accept dynamic major number*/
     INIT_BLK_DEV(tapeblock_major,tape_request_fn,tapeblock_getqueue,NULL);
-    read_ahead[tapeblock_major]=TAPEBLOCK_READAHEAD;
     PRINT_WARN(KERN_ERR " tape gets major %d for block device\n", result);
     blk_size[tapeblock_major] = (int*) kmalloc (256*sizeof(int),GFP_ATOMIC);
     memset(blk_size[tapeblock_major],0,256*sizeof(int));
diff -uNr -Xdontdiff ../master/linux-2.5.3-pre6/drivers/scsi/sd.c linux/drivers/scsi/sd.c
--- ../master/linux-2.5.3-pre6/drivers/scsi/sd.c	Tue Jan 15 10:59:09 2002
+++ linux/drivers/scsi/sd.c	Tue Jan 29 14:03:01 2002
@@ -1179,7 +1179,7 @@
 		add_gendisk(&(sd_gendisks[i]));
 	}
 
-	for (i = 0; i < sd_template.dev_max; ++i)
+	for (i = 0; i < sd_template.dev_max; ++i) {
 		if (!rscsi_disks[i].capacity && rscsi_disks[i].device) {
 			sd_init_onedisk(i);
 			if (!rscsi_disks[i].has_part_table) {
@@ -1190,17 +1190,6 @@
 				rscsi_disks[i].has_part_table = 1;
 			}
 		}
-	/* If our host adapter is capable of scatter-gather, then we increase
-	 * the read-ahead to 60 blocks (120 sectors).  If not, we use
-	 * a two block (4 sector) read ahead. We can only respect this with the
-	 * granularity of every 16 disks (one device major).
-	 */
-	for (i = 0; i < N_USED_SD_MAJORS; i++) {
-		read_ahead[SD_MAJOR(i)] =
-		    (rscsi_disks[i * SCSI_DISKS_PER_MAJOR].device
-		     && rscsi_disks[i * SCSI_DISKS_PER_MAJOR].device->host->sg_tablesize)
-		    ? 120	/* 120 sector read-ahead */
-		    : 4;	/* 4 sector read-ahead */
 	}
 
 	return;
diff -uNr -Xdontdiff ../master/linux-2.5.3-pre6/drivers/scsi/sr.c linux/drivers/scsi/sr.c
--- ../master/linux-2.5.3-pre6/drivers/scsi/sr.c	Tue Jan 29 11:24:22 2002
+++ linux/drivers/scsi/sr.c	Tue Jan 29 14:03:53 2002
@@ -785,16 +785,6 @@
                                     &sr_bdops, NULL);
 		register_cdrom(&scsi_CDs[i].cdi);
 	}
-
-
-	/* If our host adapter is capable of scatter-gather, then we increase
-	 * the read-ahead to 16 blocks (32 sectors).  If not, we use
-	 * a two block (4 sector) read ahead. */
-	if (scsi_CDs[0].device && scsi_CDs[0].device->host->sg_tablesize)
-		read_ahead[MAJOR_NR] = 32;	/* 32 sector read-ahead.  Always removable. */
-	else
-		read_ahead[MAJOR_NR] = 4;	/* 4 sector read-ahead */
-
 }
 
 static void sr_detach(Scsi_Device * SDp)
@@ -846,7 +836,6 @@
 		kfree(sr_blocksizes);
 		sr_blocksizes = NULL;
 	}
-	read_ahead[MAJOR_NR] = 0;
 	blk_clear(MAJOR_NR);
 
 	sr_template.dev_max = 0;
diff -uNr -Xdontdiff ../master/linux-2.5.3-pre6/fs/hfs/file.c linux/fs/hfs/file.c
--- ../master/linux-2.5.3-pre6/fs/hfs/file.c	Tue Jan 15 10:59:13 2002
+++ linux/fs/hfs/file.c	Tue Jan 29 14:09:18 2002
@@ -309,6 +309,7 @@
 	blocks = (count+offset+HFS_SECTOR_SIZE-1) >> HFS_SECTOR_SIZE_BITS;
 
 	bhb = bhe = buflist;
+#if 0 /* for readahead we have the pagecache..  --hch */
 	if (reada) {
 		if (blocks < read_ahead[major(dev)] / (HFS_SECTOR_SIZE>>9)) {
 			blocks = read_ahead[major(dev)] / (HFS_SECTOR_SIZE>>9);
@@ -317,6 +318,7 @@
 			blocks = size - block;
 		}
 	}
+#endif
 
 	/* We do this in a two stage process.  We first try and
 	   request as many blocks as we can, then we wait for the
diff -uNr -Xdontdiff ../master/linux-2.5.3-pre6/include/linux/blkdev.h linux/include/linux/blkdev.h
--- ../master/linux-2.5.3-pre6/include/linux/blkdev.h	Tue Jan 29 11:24:24 2002
+++ linux/include/linux/blkdev.h	Tue Jan 29 13:54:49 2002
@@ -341,7 +341,6 @@
 #endif
 	blksize_size[major] = NULL;
 	max_readahead[major] = NULL;
-	read_ahead[major] = 0;
 }
 
 extern inline int get_hardsect_size(kdev_t dev)
diff -uNr -Xdontdiff ../master/linux-2.5.3-pre6/include/linux/fs.h linux/include/linux/fs.h
--- ../master/linux-2.5.3-pre6/include/linux/fs.h	Tue Jan 29 11:24:24 2002
+++ linux/include/linux/fs.h	Tue Jan 29 13:54:36 2002
@@ -1484,7 +1484,6 @@
 
 extern ssize_t char_read(struct file *, char *, size_t, loff_t *);
 extern ssize_t block_read(struct file *, char *, size_t, loff_t *);
-extern int read_ahead[];
 
 extern ssize_t char_write(struct file *, const char *, size_t, loff_t *);
 extern ssize_t block_write(struct file *, const char *, size_t, loff_t *);
diff -uNr -Xdontdiff ../master/linux-2.5.3-pre6/kernel/ksyms.c linux/kernel/ksyms.c
--- ../master/linux-2.5.3-pre6/kernel/ksyms.c	Tue Jan 29 11:24:24 2002
+++ linux/kernel/ksyms.c	Tue Jan 29 13:54:15 2002
@@ -509,7 +509,6 @@
 EXPORT_SYMBOL(clear_inode);
 EXPORT_SYMBOL(___strtok);
 EXPORT_SYMBOL(init_special_inode);
-EXPORT_SYMBOL(read_ahead);
 EXPORT_SYMBOL(__get_hash_table);
 EXPORT_SYMBOL(new_inode);
 EXPORT_SYMBOL(insert_inode_hash);
