Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281631AbRKZMCX>; Mon, 26 Nov 2001 07:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281638AbRKZMCS>; Mon, 26 Nov 2001 07:02:18 -0500
Received: from [195.63.194.11] ([195.63.194.11]:20237 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S281631AbRKZMCD>; Mon, 26 Nov 2001 07:02:03 -0500
Message-ID: <3C022CEF.BC4340A1@evision-ventures.com>
Date: Mon, 26 Nov 2001 12:52:15 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: PATCH 2.5.0 kill  read_ahead array.
In-Reply-To: <Pine.LNX.4.33.0111221046170.1479-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------B9420818980385CBE0100F39"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------B9420818980385CBE0100F39
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The subject says it all...

This is removing the "write only" read_ahead sparse array from all
the places where it's "used" by now. 
This is just saving some memmory.
--------------B9420818980385CBE0100F39
Content-Type: text/plain; charset=us-ascii;
 name="kill-read_ahead.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kill-read_ahead.patch"

diff -urN linux/drivers/acorn/block/mfmhd.c linux-new/drivers/acorn/block/mfmhd.c
--- linux/drivers/acorn/block/mfmhd.c	Thu Oct 25 22:58:35 2001
+++ linux-new/drivers/acorn/block/mfmhd.c	Mon Nov 26 03:06:16 2001
@@ -1444,7 +1444,6 @@
 	hdc63463_irqpollmask	= irqmask;
 
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
-	read_ahead[MAJOR_NR] = 8;	/* 8 sector (4kB?) read ahread */
 
 	add_gendisk(&mfm_gendisk);
 
diff -urN linux/drivers/block/DAC960.c linux-new/drivers/block/DAC960.c
--- linux/drivers/block/DAC960.c	Thu Oct 25 22:58:35 2001
+++ linux-new/drivers/block/DAC960.c	Mon Nov 26 02:49:45 2001
@@ -2033,10 +2033,6 @@
   blksize_size[MajorNumber] = Controller->BlockSizes;
   max_sectors[MajorNumber] = Controller->MaxSectorsPerRequest;
   /*
-    Initialize Read Ahead to 128 sectors.
-  */
-  read_ahead[MajorNumber] = 128;
-  /*
     Complete initialization of the Generic Disk Information structure.
   */
   Controller->GenericDiskInfo.major = MajorNumber;
@@ -5481,8 +5477,6 @@
 				       .part[MINOR(Inode->i_rdev)]
 				       .nr_sects << 9,
 		      (u64 *) Argument);
-    case BLKRAGET:
-    case BLKRASET:
     case BLKFLSBUF:
     case BLKBSZGET:
     case BLKBSZSET:
diff -urN linux/drivers/block/acsi.c linux-new/drivers/block/acsi.c
--- linux/drivers/block/acsi.c	Fri Nov  9 22:58:03 2001
+++ linux-new/drivers/block/acsi.c	Mon Nov 26 03:03:41 2001
@@ -1786,7 +1786,6 @@
 	STramMask = ATARIHW_PRESENT(EXTD_DMA) ? 0x00000000 : 0xff000000;
 	
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
-	read_ahead[MAJOR_NR] = 8;		/* 8 sector (4kB) read-ahead */
 	add_gendisk(&acsi_gendisk);
 
 #ifdef CONFIG_ATARI_SLM
diff -urN linux/drivers/block/blkpg.c linux-new/drivers/block/blkpg.c
--- linux/drivers/block/blkpg.c	Sun Nov 11 19:20:21 2001
+++ linux-new/drivers/block/blkpg.c	Mon Nov 26 02:27:33 2001
@@ -210,22 +210,11 @@
 				return -EFAULT;
 			set_device_ro(dev, intval);
 			return 0;
+
 		case BLKROGET:
 			intval = (is_read_only(dev) != 0);
 			return put_user(intval, (int *)(arg));
 
-		case BLKRASET:
-			if(!capable(CAP_SYS_ADMIN))
-				return -EACCES;
-			if(arg > 0xff)
-				return -EINVAL;
-			read_ahead[MAJOR(dev)] = arg;
-			return 0;
-		case BLKRAGET:
-			if (!arg)
-				return -EINVAL;
-			return put_user(read_ahead[MAJOR(dev)], (long *) arg);
-
 		case BLKFLSBUF:
 			if(!capable(CAP_SYS_ADMIN))
 				return -EACCES;
diff -urN linux/drivers/block/cciss.c linux-new/drivers/block/cciss.c
--- linux/drivers/block/cciss.c	Fri Nov  9 23:28:46 2001
+++ linux-new/drivers/block/cciss.c	Mon Nov 26 02:48:52 2001
@@ -412,8 +412,6 @@
 	case BLKBSZGET:
 	case BLKROSET:
 	case BLKROGET:
-	case BLKRASET:
-	case BLKRAGET:
 	case BLKPG:
 	case BLKELVGET:
 	case BLKELVSET:
@@ -1948,7 +1946,6 @@
 	/* fill in the other Kernel structs */
 	blksize_size[MAJOR_NR+i] = hba[i]->blocksizes;
         hardsect_size[MAJOR_NR+i] = hba[i]->hardsizes;
-        read_ahead[MAJOR_NR+i] = READ_AHEAD;
 
 	/* Set the pointers to queue functions */ 
 	q->back_merge_fn = cpq_back_merge_fn;
diff -urN linux/drivers/block/cpqarray.c linux-new/drivers/block/cpqarray.c
--- linux/drivers/block/cpqarray.c	Fri Nov  9 23:28:46 2001
+++ linux-new/drivers/block/cpqarray.c	Mon Nov 26 02:47:51 2001
@@ -527,7 +527,6 @@
 		blk_queue_headactive(q, 0);
 		blksize_size[MAJOR_NR+i] = ida_blocksizes + (i*256);
 		hardsect_size[MAJOR_NR+i] = ida_hardsizes + (i*256);
-		read_ahead[MAJOR_NR+i] = READ_AHEAD;
 
 		q->back_merge_fn = cpq_back_merge_fn;
 		q->front_merge_fn = cpq_front_merge_fn;
@@ -1249,8 +1248,6 @@
 	case BLKBSZGET:
 	case BLKROSET:
 	case BLKROGET:
-	case BLKRASET:
-	case BLKRAGET:
 	case BLKELVGET:
 	case BLKELVSET:
 	case BLKPG:
diff -urN linux/drivers/block/floppy.c linux-new/drivers/block/floppy.c
--- linux/drivers/block/floppy.c	Thu Oct 25 22:58:34 2001
+++ linux-new/drivers/block/floppy.c	Mon Nov 26 02:29:29 2001
@@ -3450,8 +3450,6 @@
 	switch (cmd) {
 		case BLKROSET:
 		case BLKROGET:
-		case BLKRASET:
-		case BLKRAGET:
 		case BLKFLSBUF:
 			return blk_ioctl(device, cmd, param);
 	}
diff -urN linux/drivers/block/ll_rw_blk.c linux-new/drivers/block/ll_rw_blk.c
--- linux/drivers/block/ll_rw_blk.c	Mon Oct 29 21:11:17 2001
+++ linux-new/drivers/block/ll_rw_blk.c	Mon Nov 26 02:22:51 2001
@@ -64,10 +64,6 @@
  */
 spinlock_t io_request_lock = SPIN_LOCK_UNLOCKED;
 
-/* This specifies how many sectors to read ahead on the disk. */
-
-int read_ahead[MAX_BLKDEV];
-
 /* blk_dev_struct is:
  *	*request_fn
  *	*current_request
diff -urN linux/drivers/block/paride/pcd.c linux-new/drivers/block/paride/pcd.c
--- linux/drivers/block/paride/pcd.c	Sat Oct 27 11:03:47 2001
+++ linux-new/drivers/block/paride/pcd.c	Mon Nov 26 02:51:42 2001
@@ -356,7 +356,6 @@
 	}
 
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
-	read_ahead[MAJOR_NR] = 8;	/* 8 sector (4kB) read ahead */
 
 	for (i=0;i<PCD_UNITS;i++) pcd_blocksizes[i] = 1024;
         blksize_size[MAJOR_NR] = pcd_blocksizes;
diff -urN linux/drivers/block/paride/pd.c linux-new/drivers/block/paride/pd.c
--- linux/drivers/block/paride/pd.c	Fri Nov  9 22:58:03 2001
+++ linux-new/drivers/block/paride/pd.c	Mon Nov 26 02:50:50 2001
@@ -397,8 +397,7 @@
         }
 	q = BLK_DEFAULT_QUEUE(MAJOR_NR);
 	blk_init_queue(q, DEVICE_REQUEST);
-        read_ahead[MAJOR_NR] = 8;       /* 8 sector (4kB) read ahead */
-        
+
 	pd_gendisk.major = major;
 	pd_gendisk.major_name = name;
 	add_gendisk(&pd_gendisk);
@@ -483,8 +482,6 @@
 	    case BLKGETSIZE64:
 	    case BLKROSET:
 	    case BLKROGET:
-	    case BLKRASET:
-	    case BLKRAGET:
 	    case BLKFLSBUF:
 	    case BLKPG:
 		return blk_ioctl(inode->i_rdev, cmd, arg);
diff -urN linux/drivers/block/paride/pf.c linux-new/drivers/block/paride/pf.c
--- linux/drivers/block/paride/pf.c	Thu Oct 25 22:58:35 2001
+++ linux-new/drivers/block/paride/pf.c	Mon Nov 26 02:52:19 2001
@@ -412,8 +412,7 @@
 	q->back_merge_fn = pf_back_merge_fn;
 	q->front_merge_fn = pf_front_merge_fn;
 	q->merge_requests_fn = pf_merge_requests_fn;
-        read_ahead[MAJOR_NR] = 8;       /* 8 sector (4kB) read ahead */
-        
+
 	for (i=0;i<PF_UNITS;i++) pf_blocksizes[i] = 1024;
 	blksize_size[MAJOR_NR] = pf_blocksizes;
 	for (i=0;i<PF_UNITS;i++)
@@ -482,8 +481,6 @@
                 return put_user((u64)PF.capacity << 9,(u64 *)arg);
 	    case BLKROSET:
 	    case BLKROGET:
-	    case BLKRASET:
-	    case BLKRAGET:
 	    case BLKFLSBUF:
 		return blk_ioctl(inode->i_rdev, cmd, arg);
             default:
diff -urN linux/drivers/block/ps2esdi.c linux-new/drivers/block/ps2esdi.c
--- linux/drivers/block/ps2esdi.c	Fri Nov  9 23:01:21 2001
+++ linux-new/drivers/block/ps2esdi.c	Mon Nov 26 03:04:08 2001
@@ -181,7 +181,6 @@
 	}
 	/* set up some global information - indicating device specific info */
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
-	read_ahead[MAJOR_NR] = 8;	/* 8 sector (4kB) read ahead */
 
 	/* some minor housekeeping - setup the global gendisk structure */
 	add_gendisk(&ps2esdi_gendisk);
@@ -1116,8 +1115,6 @@
 		case BLKGETSIZE64:
 		case BLKROSET:
 		case BLKROGET:
-		case BLKRASET:
-		case BLKRAGET:
 		case BLKFLSBUF:
 		case BLKBSZGET:
 		case BLKBSZSET:
diff -urN linux/drivers/block/xd.c linux-new/drivers/block/xd.c
--- linux/drivers/block/xd.c	Fri Nov  9 23:01:21 2001
+++ linux-new/drivers/block/xd.c	Mon Nov 26 02:46:22 2001
@@ -172,7 +172,6 @@
 	}
 	devfs_handle = devfs_mk_dir (NULL, xd_gendisk.major_name, NULL);
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
-	read_ahead[MAJOR_NR] = 8;	/* 8 sector (4kB) read ahead */
 	add_gendisk(&xd_gendisk);
 	xd_geninit();
 
@@ -355,8 +354,6 @@
 		case BLKFLSBUF:
 		case BLKROSET:
 		case BLKROGET:
-		case BLKRASET:
-		case BLKRAGET:
 		case BLKPG:
 			return blk_ioctl(inode->i_rdev, cmd, arg);
 
@@ -1109,7 +1106,6 @@
 	blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
 	blk_size[MAJOR_NR] = NULL;
 	hardsect_size[MAJOR_NR] = NULL;
-	read_ahead[MAJOR_NR] = 0;
 	del_gendisk(&xd_gendisk);
 	release_region(xd_iobase,4);
 }
diff -urN linux/drivers/cdrom/aztcd.c linux-new/drivers/cdrom/aztcd.c
--- linux/drivers/cdrom/aztcd.c	Thu Oct 25 22:58:35 2001
+++ linux-new/drivers/cdrom/aztcd.c	Mon Nov 26 02:53:02 2001
@@ -1929,7 +1929,6 @@
 	}
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
 	blksize_size[MAJOR_NR] = aztcd_blocksizes;
-	read_ahead[MAJOR_NR] = 4;
 	register_disk(NULL, MKDEV(MAJOR_NR, 0), 1, &azt_fops, 0);
 
 	if ((azt_port == 0x1f0) || (azt_port == 0x170))
diff -urN linux/drivers/cdrom/cdu31a.c linux-new/drivers/cdrom/cdu31a.c
--- linux/drivers/cdrom/cdu31a.c	Thu Oct 25 22:58:35 2001
+++ linux-new/drivers/cdrom/cdu31a.c	Mon Nov 26 02:54:01 2001
@@ -3454,7 +3454,6 @@
 
 		blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR),
 			       DEVICE_REQUEST);
-		read_ahead[MAJOR_NR] = CDU31A_READAHEAD;
 		cdu31a_block_size = 1024;	/* 1kB default block size */
 		/* use 'mount -o block=2048' */
 		blksize_size[MAJOR_NR] = &cdu31a_block_size;
diff -urN linux/drivers/cdrom/cm206.c linux-new/drivers/cdrom/cm206.c
--- linux/drivers/cdrom/cm206.c	Thu Oct 25 22:58:35 2001
+++ linux-new/drivers/cdrom/cm206.c	Mon Nov 26 02:54:31 2001
@@ -1501,7 +1501,6 @@
 	devfs_plain_cdrom(&cm206_info, &cm206_bdops);
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
 	blksize_size[MAJOR_NR] = cm206_blocksizes;
-	read_ahead[MAJOR_NR] = 16;	/* reads ahead what? */
 	init_bh(CM206_BH, cm206_bh);
 
 	memset(cd, 0, sizeof(*cd));	/* give'm some reasonable value */
diff -urN linux/drivers/cdrom/gscd.c linux-new/drivers/cdrom/gscd.c
--- linux/drivers/cdrom/gscd.c	Thu Oct 25 22:58:35 2001
+++ linux-new/drivers/cdrom/gscd.c	Mon Nov 26 02:54:54 2001
@@ -1021,7 +1021,6 @@
 
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
 	blksize_size[MAJOR_NR] = gscd_blocksizes;
-	read_ahead[MAJOR_NR] = 4;
 
 	disk_state = 0;
 	gscdPresent = 1;
diff -urN linux/drivers/cdrom/mcd.c linux-new/drivers/cdrom/mcd.c
--- linux/drivers/cdrom/mcd.c	Thu Oct 25 22:58:35 2001
+++ linux-new/drivers/cdrom/mcd.c	Mon Nov 26 02:55:28 2001
@@ -1077,7 +1077,6 @@
 
 	blksize_size[MAJOR_NR] = mcd_blocksizes;
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
-	read_ahead[MAJOR_NR] = 4;
 
 	/* check for card */
 
diff -urN linux/drivers/cdrom/mcdx.c linux-new/drivers/cdrom/mcdx.c
--- linux/drivers/cdrom/mcdx.c	Thu Oct 25 22:58:35 2001
+++ linux-new/drivers/cdrom/mcdx.c	Mon Nov 26 02:55:58 2001
@@ -1188,7 +1188,6 @@
 	}
 
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
-	read_ahead[MAJOR_NR] = READ_AHEAD;
 	blksize_size[MAJOR_NR] = mcdx_blocksizes;
 
 	xtrace(INIT, "init() subscribe irq and i/o\n");
diff -urN linux/drivers/cdrom/optcd.c linux-new/drivers/cdrom/optcd.c
--- linux/drivers/cdrom/optcd.c	Thu Oct 25 22:58:35 2001
+++ linux-new/drivers/cdrom/optcd.c	Mon Nov 26 02:59:31 2001
@@ -2066,7 +2066,6 @@
 	hardsect_size[MAJOR_NR] = &hsecsize;
 	blksize_size[MAJOR_NR] = &blksize;
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
-	read_ahead[MAJOR_NR] = 4;
 	request_region(optcd_port, 4, "optcd");
 	register_disk(NULL, MKDEV(MAJOR_NR,0), 1, &opt_fops, 0);
 
diff -urN linux/drivers/cdrom/sbpcd.c linux-new/drivers/cdrom/sbpcd.c
--- linux/drivers/cdrom/sbpcd.c	Thu Oct 25 22:58:35 2001
+++ linux-new/drivers/cdrom/sbpcd.c	Mon Nov 26 03:01:11 2001
@@ -4531,12 +4531,6 @@
 		RETURN_UP(0);
 	} /* end of CDROMREADAUDIO */
 		
-	case BLKRASET:
-		if(!capable(CAP_SYS_ADMIN)) RETURN_UP(-EACCES);
-		if(!(cdi->dev)) RETURN_UP(-EINVAL);
-		if(arg > 0xff) RETURN_UP(-EINVAL);
-		read_ahead[MAJOR(cdi->dev)] = arg;
-		RETURN_UP(0);
 	default:
 		msg(DBG_IOC,"ioctl: unknown function request %04X\n", cmd);
 		RETURN_UP(-EINVAL);
@@ -5871,10 +5865,9 @@
 	(BLK_DEFAULT_QUEUE(MAJOR_NR))->merge_requests_fn = dont_merge_requests_fn;
 #endif
 	blk_queue_headactive(BLK_DEFAULT_QUEUE(MAJOR_NR), 0);
-	read_ahead[MAJOR_NR] = buffers * (CD_FRAMESIZE / 512);
-	
+
 	request_region(CDo_command,4,major_name);
-	
+
 	devfs_handle = devfs_mk_dir (NULL, "sbp", NULL);
 	for (j=0;j<NR_SBPCD;j++)
 	{
diff -urN linux/drivers/cdrom/sjcd.c linux-new/drivers/cdrom/sjcd.c
--- linux/drivers/cdrom/sjcd.c	Thu Oct 25 22:58:35 2001
+++ linux-new/drivers/cdrom/sjcd.c	Mon Nov 26 03:01:36 2001
@@ -1702,7 +1702,6 @@
 	}
 
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
-	read_ahead[MAJOR_NR] = 4;
 	register_disk(NULL, MKDEV(MAJOR_NR, 0), 1, &sjcd_fops, 0);
 
 	if (check_region(sjcd_base, 4)) {
diff -urN linux/drivers/cdrom/sonycd535.c linux-new/drivers/cdrom/sonycd535.c
--- linux/drivers/cdrom/sonycd535.c	Thu Oct 25 22:58:35 2001
+++ linux-new/drivers/cdrom/sonycd535.c	Mon Nov 26 03:02:25 2001
@@ -1595,7 +1595,6 @@
 				}
 				blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
 				blksize_size[MAJOR_NR] = &sonycd535_block_size;
-				read_ahead[MAJOR_NR] = 8;	/* 8 sector (4kB) read-ahead */
 
 				sony_toc = (struct s535_sony_toc *)
 					kmalloc(sizeof *sony_toc, GFP_KERNEL);
diff -urN linux/drivers/ide/hd.c linux-new/drivers/ide/hd.c
--- linux/drivers/ide/hd.c	Mon Oct 15 22:27:42 2001
+++ linux-new/drivers/ide/hd.c	Mon Nov 26 03:04:37 2001
@@ -652,8 +652,6 @@
 
 		case BLKROSET:
 		case BLKROGET:
-		case BLKRASET:
-		case BLKRAGET:
 		case BLKFLSBUF:
 		case BLKPG:
 			return blk_ioctl(inode->i_rdev, cmd, arg);
@@ -840,7 +838,6 @@
 		return -1;
 	}
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
-	read_ahead[MAJOR_NR] = 8;		/* 8 sector (4kB) read-ahead */
 	add_gendisk(&hd_gendisk);
 	init_timer(&device_timer);
 	device_timer.function = hd_times_out;
diff -urN linux/drivers/ide/ide-cd.c linux-new/drivers/ide/ide-cd.c
--- linux/drivers/ide/ide-cd.c	Thu Oct 25 08:53:51 2001
+++ linux-new/drivers/ide/ide-cd.c	Mon Nov 26 03:05:02 2001
@@ -2709,7 +2709,6 @@
 	int major = HWIF(drive)->major;
 	int minor = drive->select.b.unit << PARTN_BITS;
 
-	ide_add_setting(drive,	"breada_readahead",	SETTING_RW, BLKRAGET, BLKRASET, TYPE_INT, 0, 255, 1, 2, &read_ahead[major], NULL);
 	ide_add_setting(drive,	"file_readahead",	SETTING_RW, BLKFRAGET, BLKFRASET, TYPE_INTA, 0, INT_MAX, 1, 1024, &max_readahead[major][minor],	NULL);
 	ide_add_setting(drive,	"max_kb_per_request",	SETTING_RW, BLKSECTGET, BLKSECTSET, TYPE_INTA, 1, 255, 1, 2, &max_sectors[major][minor], NULL);
 	ide_add_setting(drive,	"dsc_overlap",		SETTING_RW, -1, -1, TYPE_BYTE, 0, 1, 1,	1, &drive->dsc_overlap, NULL);
diff -urN linux/drivers/ide/ide-disk.c linux-new/drivers/ide/ide-disk.c
--- linux/drivers/ide/ide-disk.c	Wed Nov 21 06:35:28 2001
+++ linux-new/drivers/ide/ide-disk.c	Mon Nov 26 02:31:42 2001
@@ -689,7 +689,6 @@
 	ide_add_setting(drive,	"bswap",		SETTING_READ,					-1,			-1,			TYPE_BYTE,	0,	1,				1,	1,	&drive->bswap,			NULL);
 	ide_add_setting(drive,	"multcount",		id ? SETTING_RW : SETTING_READ,			HDIO_GET_MULTCOUNT,	HDIO_SET_MULTCOUNT,	TYPE_BYTE,	0,	id ? id->max_multsect : 0,	1,	2,	&drive->mult_count,		set_multcount);
 	ide_add_setting(drive,	"nowerr",		SETTING_RW,					HDIO_GET_NOWERR,	HDIO_SET_NOWERR,	TYPE_BYTE,	0,	1,				1,	1,	&drive->nowerr,			set_nowerr);
-	ide_add_setting(drive,	"breada_readahead",	SETTING_RW,					BLKRAGET,		BLKRASET,		TYPE_INT,	0,	255,				1,	2,	&read_ahead[major],		NULL);
 	ide_add_setting(drive,	"file_readahead",	SETTING_RW,					BLKFRAGET,		BLKFRASET,		TYPE_INTA,	0,	4096,			PAGE_SIZE,	1024,	&max_readahead[major][minor],	NULL);
 	ide_add_setting(drive,	"max_kb_per_request",	SETTING_RW,					BLKSECTGET,		BLKSECTSET,		TYPE_INTA,	1,	255,				1,	2,	&max_sectors[major][minor],	NULL);
 	ide_add_setting(drive,	"lun",			SETTING_RW,					-1,			-1,			TYPE_INT,	0,	7,				1,	1,	&drive->lun,			NULL);
diff -urN linux/drivers/ide/ide-floppy.c linux-new/drivers/ide/ide-floppy.c
--- linux/drivers/ide/ide-floppy.c	Thu Oct 11 18:14:32 2001
+++ linux-new/drivers/ide/ide-floppy.c	Mon Nov 26 02:32:14 2001
@@ -1918,7 +1918,6 @@
 	ide_add_setting(drive,	"bios_cyl",		SETTING_RW,					-1,			-1,			TYPE_INT,	0,	1023,				1,	1,	&drive->bios_cyl,		NULL);
 	ide_add_setting(drive,	"bios_head",		SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	255,				1,	1,	&drive->bios_head,		NULL);
 	ide_add_setting(drive,	"bios_sect",		SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	63,				1,	1,	&drive->bios_sect,		NULL);
-	ide_add_setting(drive,	"breada_readahead",	SETTING_RW,					BLKRAGET,		BLKRASET,		TYPE_INT,	0,	255,				1,	2,	&read_ahead[major],		NULL);
 	ide_add_setting(drive,	"file_readahead",	SETTING_RW,					BLKFRAGET,		BLKFRASET,		TYPE_INTA,	0,	INT_MAX,			1,	1024,	&max_readahead[major][minor],	NULL);
 	ide_add_setting(drive,	"max_kb_per_request",	SETTING_RW,					BLKSECTGET,		BLKSECTSET,		TYPE_INTA,	1,	255,				1,	2,	&max_sectors[major][minor],	NULL);
 
diff -urN linux/drivers/ide/ide-probe.c linux-new/drivers/ide/ide-probe.c
--- linux/drivers/ide/ide-probe.c	Thu Oct 11 18:14:32 2001
+++ linux-new/drivers/ide/ide-probe.c	Mon Nov 26 02:30:40 2001
@@ -863,11 +863,10 @@
 		printk("%s: probed IRQ %d failed, using default.\n",
 			hwif->name, hwif->irq);
 	}
-	
+
 	init_gendisk(hwif);
 	blk_dev[hwif->major].data = hwif;
 	blk_dev[hwif->major].queue = ide_get_queue;
-	read_ahead[hwif->major] = 8;	/* (4kB) */
 	hwif->present = 1;	/* success */
 
 #if (DEBUG_SPINLOCK > 0)
diff -urN linux/drivers/md/lvm.c linux-new/drivers/md/lvm.c
--- linux/drivers/md/lvm.c	Mon Nov 19 18:56:04 2001
+++ linux-new/drivers/md/lvm.c	Mon Nov 26 03:11:21 2001
@@ -885,29 +885,6 @@
 		invalidate_buffers(inode->i_rdev);
 		break;
 
-
-	case BLKRASET:
-		/* set read ahead for block device */
-		if (!capable(CAP_SYS_ADMIN)) return -EACCES;
-
-		P_IOCTL("BLKRASET: %ld sectors for %s\n",
-			(long) arg, kdevname(inode->i_rdev));
-
-		if ((long) arg < LVM_MIN_READ_AHEAD ||
-		    (long) arg > LVM_MAX_READ_AHEAD)
-			return -EINVAL;
-		lv_ptr->lv_read_ahead = (long) arg;
-		break;
-
-
-	case BLKRAGET:
-		/* get current read ahead setting */
-		P_IOCTL("BLKRAGET %d\n", lv_ptr->lv_read_ahead);
-		if (put_user(lv_ptr->lv_read_ahead, (long *)arg))
-			return -EFAULT;
-		break;
-
-
 	case HDIO_GETGEO:
 		/* get disk geometry */
 		P_IOCTL("%s -- lvm_blk_ioctl -- HDIO_GETGEO\n", lvm_name);
diff -urN linux/drivers/md/md.c linux-new/drivers/md/md.c
--- linux/drivers/md/md.c	Thu Oct 25 22:58:34 2001
+++ linux-new/drivers/md/md.c	Mon Nov 26 02:33:46 2001
@@ -1734,7 +1734,6 @@
 	register_disk(&md_gendisk, MKDEV(MAJOR_NR,mdidx(mddev)),
 			1, &md_fops, md_size[mdidx(mddev)]<<1);
 
-	read_ahead[MD_MAJOR] = 1024;
 	return (0);
 }
 
@@ -2619,8 +2618,6 @@
 						(u64 *) arg);
 			goto done;
 
-		case BLKRAGET:
-		case BLKRASET:
 		case BLKFLSBUF:
 		case BLKBSZGET:
 		case BLKBSZSET:
@@ -3167,13 +3164,6 @@
 
 	sz += sprintf(page+sz, "\n");
 
-
-	sz += sprintf(page+sz, "read_ahead ");
-	if (read_ahead[MD_MAJOR] == INT_MAX)
-		sz += sprintf(page+sz, "not set\n");
-	else
-		sz += sprintf(page+sz, "%d sectors\n", read_ahead[MD_MAJOR]);
-
 	ITERATE_MDDEV(mddev,tmp) {
 		sz += sprintf(page + sz, "md%d : %sactive", mdidx(mddev),
 						mddev->pers ? "" : "in");
@@ -3663,9 +3653,6 @@
 	/* forward all md request to md_make_request */
 	blk_queue_make_request(BLK_DEFAULT_QUEUE(MAJOR_NR), md_make_request);
 
-
-	read_ahead[MAJOR_NR] = INT_MAX;
-
 	add_gendisk(&md_gendisk);
 
 	md_recovery_thread = md_register_thread(md_do_recovery, NULL, name);
diff -urN linux/drivers/message/i2o/i2o_block.c linux-new/drivers/message/i2o/i2o_block.c
--- linux/drivers/message/i2o/i2o_block.c	Thu Oct 25 22:58:35 2001
+++ linux-new/drivers/message/i2o/i2o_block.c	Mon Nov 26 03:09:04 2001
@@ -1170,11 +1170,9 @@
 		case BLKFLSBUF:
 		case BLKROSET:
 		case BLKROGET:
-		case BLKRASET:
-		case BLKRAGET:
 		case BLKPG:
 			return blk_ioctl(inode->i_rdev, cmd, arg);
-			
+
 		default:
 			return -EINVAL;
 	}
diff -urN linux/drivers/s390/block/xpram.c linux-new/drivers/s390/block/xpram.c
--- linux/drivers/s390/block/xpram.c	Thu Oct 25 22:58:35 2001
+++ linux-new/drivers/s390/block/xpram.c	Mon Nov 26 03:07:23 2001
@@ -659,22 +659,6 @@
 		if ( capable(CAP_SYS_ADMIN) )invalidate_buffers(inode->i_rdev);
 		return 0;
 
-	case BLKRAGET: /* return the readahead value, 0x1263 */
-		if (!arg)  return -EINVAL;
-		err = 0; /* verify_area_20(VERIFY_WRITE, (long *) arg, sizeof(long));
-		          * if (err) return err;
-                          */
-		put_user(read_ahead[MAJOR(inode->i_rdev)], (long *)arg);
-
-		return 0;
-
-	case BLKRASET: /* set the readahead value, 0x1262 */
-		if (!capable(CAP_SYS_ADMIN)) return -EACCES;
-		if (arg > 0xff) return -EINVAL; /* limit it */
-		read_ahead[MAJOR(inode->i_rdev)] = arg;
-                atomic_eieio();
-		return 0;
-
 	case BLKRRPART: /* re-read partition table: can't do it, 0x1259 */
 		return -EINVAL;
 
@@ -1043,7 +1027,6 @@
 	blk_init_queue (q, xpram_request);
 	blk_queue_headactive (BLK_DEFAULT_QUEUE (major), 0);
 #endif /* V22/V24 */
-	read_ahead[major] = xpram_rahead;
 
 	/* we want to have XPRAM_UNUSED blocks security buffer between devices */
 	mem_usable=xpram_mem_avail-(XPRAM_UNUSED*(xpram_devs-1));
@@ -1182,7 +1165,6 @@
 	kfree(xpram_hardsects);
 	hardsect_size[major] = NULL;
  fail_malloc:
-	read_ahead[major] = 0;
 #if (XPRAM_VERSION == 22)
 	blk_dev[major].request_fn = NULL;
 #endif /* V22 */
@@ -1222,7 +1204,6 @@
 #if (XPRAM_VERSION == 22)
 	blk_dev[major].request_fn = NULL;
 #endif /* V22 */
-	read_ahead[major] = 0;
 	blk_size[major] = NULL;
 	kfree(blksize_size[major]);
 	blksize_size[major] = NULL;
diff -urN linux/drivers/s390/char/tapeblock.c linux-new/drivers/s390/char/tapeblock.c
--- linux/drivers/s390/char/tapeblock.c	Thu Oct 25 22:58:35 2001
+++ linux-new/drivers/s390/char/tapeblock.c	Mon Nov 26 03:08:01 2001
@@ -102,7 +102,6 @@
     }
     if (tapeblock_major == 0) tapeblock_major = result;   /* accept dynamic major number*/
     INIT_BLK_DEV(tapeblock_major,tape_request_fn,tapeblock_getqueue,NULL);
-    read_ahead[tapeblock_major]=TAPEBLOCK_READAHEAD;
     PRINT_WARN(KERN_ERR " tape gets major %d for block device\n", result);
     blk_size[tapeblock_major] = (int*) kmalloc (256*sizeof(int),GFP_ATOMIC);
     memset(blk_size[tapeblock_major],0,256*sizeof(int));
diff -urN linux/drivers/scsi/sd.c linux-new/drivers/scsi/sd.c
--- linux/drivers/scsi/sd.c	Fri Nov  9 23:05:06 2001
+++ linux-new/drivers/scsi/sd.c	Mon Nov 26 03:13:51 2001
@@ -234,8 +234,6 @@
 		case BLKGETSIZE64:
 		case BLKROSET:
 		case BLKROGET:
-		case BLKRASET:
-		case BLKRAGET:
 		case BLKFLSBUF:
 		case BLKSSZGET:
 		case BLKPG:
@@ -1217,18 +1215,14 @@
 				rscsi_disks[i].has_part_table = 1;
 			}
 		}
-	/* If our host adapter is capable of scatter-gather, then we increase
-	 * the read-ahead to 60 blocks (120 sectors).  If not, we use
-	 * a two block (4 sector) read ahead. We can only respect this with the
-	 * granularity of every 16 disks (one device major).
+
+	/* FIXME: If our host adapter is capable of scatter-gather, then we
+	 * should increase the number of blocks we read at once to 60 (120
+	 * sectors).  However there is currently no such kind of mechanism
+	 * there... Please have a look at the corresponding comment in sr.c
+	 *
+	 * --dalecki
 	 */
-	for (i = 0; i < N_USED_SD_MAJORS; i++) {
-		read_ahead[SD_MAJOR(i)] =
-		    (rscsi_disks[i * SCSI_DISKS_PER_MAJOR].device
-		     && rscsi_disks[i * SCSI_DISKS_PER_MAJOR].device->host->sg_tablesize)
-		    ? 120	/* 120 sector read-ahead */
-		    : 4;	/* 4 sector read-ahead */
-	}
 
 	return;
 }
@@ -1405,7 +1399,6 @@
 		del_gendisk(&sd_gendisks[i]);
 		blk_size[SD_MAJOR(i)] = NULL;
 		hardsect_size[SD_MAJOR(i)] = NULL;
-		read_ahead[SD_MAJOR(i)] = 0;
 	}
 	sd_template.dev_max = 0;
 	if (sd_gendisks != &sd_gendisk)
diff -urN linux/drivers/scsi/sr.c linux-new/drivers/scsi/sr.c
--- linux/drivers/scsi/sr.c	Thu Oct 25 22:58:35 2001
+++ linux-new/drivers/scsi/sr.c	Mon Nov 26 02:45:19 2001
@@ -888,14 +888,12 @@
 		register_cdrom(&scsi_CDs[i].cdi);
 	}
 
-
-	/* If our host adapter is capable of scatter-gather, then we increase
-	 * the read-ahead to 16 blocks (32 sectors).  If not, we use
-	 * a two block (4 sector) read ahead. */
-	if (scsi_CDs[0].device && scsi_CDs[0].device->host->sg_tablesize)
-		read_ahead[MAJOR_NR] = 32;	/* 32 sector read-ahead.  Always removable. */
-	else
-		read_ahead[MAJOR_NR] = 4;	/* 4 sector read-ahead */
+	/* FIXME: There should be a way to increase some kind of driver read
+	 * ahead value for the device here. Plase have a look at the
+	 * corresponding note in sd.c.
+	 *
+	 * --dalecki
+	 */
 
 	return;
 }
@@ -954,7 +952,6 @@
 	blksize_size[MAJOR_NR] = NULL;
         hardsect_size[MAJOR_NR] = NULL;
 	blk_size[MAJOR_NR] = NULL;
-	read_ahead[MAJOR_NR] = 0;
 
 	sr_template.dev_max = 0;
 }
diff -urN linux/drivers/scsi/sr_ioctl.c linux-new/drivers/scsi/sr_ioctl.c
--- linux/drivers/scsi/sr_ioctl.c	Mon Oct 15 22:27:42 2001
+++ linux-new/drivers/scsi/sr_ioctl.c	Mon Nov 26 03:14:37 2001
@@ -550,8 +550,6 @@
 		return put_user((u64)scsi_CDs[target].capacity << 9, (u64 *)arg);
 	case BLKROSET:
 	case BLKROGET:
-	case BLKRASET:
-	case BLKRAGET:
 	case BLKFLSBUF:
 	case BLKSSZGET:
 		return blk_ioctl(cdi->dev, cmd, arg);
diff -urN linux/dump linux-new/dump
--- linux/dump	Thu Jan  1 01:00:00 1970
+++ linux-new/dump	Mon Nov 26 03:12:16 2001
@@ -0,0 +1,2 @@
+BLKRASET
+BLKRAGET
diff -urN linux/fs/hfs/file.c linux-new/fs/hfs/file.c
--- linux/fs/hfs/file.c	Sun Aug 12 19:56:56 2001
+++ linux-new/fs/hfs/file.c	Mon Nov 26 02:23:10 2001
@@ -313,8 +313,8 @@
 
 	bhb = bhe = buflist;
 	if (reada) {
-		if (blocks < read_ahead[MAJOR(dev)] / (HFS_SECTOR_SIZE>>9)) {
-			blocks = read_ahead[MAJOR(dev)] / (HFS_SECTOR_SIZE>>9);
+		if (blocks < reada / (HFS_SECTOR_SIZE>>9)) {
+			blocks = reada / (HFS_SECTOR_SIZE>>9);
 		}
 		if (block + blocks > size) {
 			blocks = size - block;
diff -urN linux/include/linux/fs.h linux-new/include/linux/fs.h
--- linux/include/linux/fs.h	Thu Nov 22 20:46:19 2001
+++ linux-new/include/linux/fs.h	Mon Nov 26 03:23:50 2001
@@ -170,8 +170,10 @@
 #define BLKRRPART  _IO(0x12,95)	/* re-read partition table */
 #define BLKGETSIZE _IO(0x12,96)	/* return device size /512 (long *arg) */
 #define BLKFLSBUF  _IO(0x12,97)	/* flush buffer cache */
+#if 0
 #define BLKRASET   _IO(0x12,98)	/* Set read ahead for block device */
 #define BLKRAGET   _IO(0x12,99)	/* get current read ahead setting */
+#endif
 #define BLKFRASET  _IO(0x12,100)/* set filesystem (mm/filemap.c) read-ahead */
 #define BLKFRAGET  _IO(0x12,101)/* get filesystem (mm/filemap.c) read-ahead */
 #define BLKSECTSET _IO(0x12,102)/* set max sectors per request (ll_rw_blk.c) */
@@ -1438,7 +1440,6 @@
 
 extern ssize_t char_read(struct file *, char *, size_t, loff_t *);
 extern ssize_t block_read(struct file *, char *, size_t, loff_t *);
-extern int read_ahead[];
 
 extern ssize_t char_write(struct file *, const char *, size_t, loff_t *);
 extern ssize_t block_write(struct file *, const char *, size_t, loff_t *);
diff -urN linux/kernel/ksyms.c linux-new/kernel/ksyms.c
--- linux/kernel/ksyms.c	Wed Nov 21 23:07:25 2001
+++ linux-new/kernel/ksyms.c	Mon Nov 26 02:23:04 2001
@@ -496,7 +496,6 @@
 EXPORT_SYMBOL(clear_inode);
 EXPORT_SYMBOL(___strtok);
 EXPORT_SYMBOL(init_special_inode);
-EXPORT_SYMBOL(read_ahead);
 EXPORT_SYMBOL(get_hash_table);
 EXPORT_SYMBOL(get_empty_inode);
 EXPORT_SYMBOL(insert_inode_hash);

--------------B9420818980385CBE0100F39--

