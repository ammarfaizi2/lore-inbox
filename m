Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273834AbRIXJm6>; Mon, 24 Sep 2001 05:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273836AbRIXJml>; Mon, 24 Sep 2001 05:42:41 -0400
Received: from [195.63.194.11] ([195.63.194.11]:58118 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S273834AbRIXJmU>; Mon, 24 Sep 2001 05:42:20 -0400
Message-ID: <3BAEFEC9.2C41445C@evision-ventures.com>
Date: Mon, 24 Sep 2001 11:37:13 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-12 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: PATCH[2.4.9-pre14] Kill *writeonly* variable.
In-Reply-To: <Pine.LNX.4.33.0109231142060.1078-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------AA7911A054708F9B7D528650"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------AA7911A054708F9B7D528650
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

HellO!

Inside the kernel we have an array called read_ahead[MAJOR(dev)] - a
true
offended to human mind ;-).

Let us have a look on it in the 2.4.10-pre14 kernel.

This array was supposed as a way for a block device to specify the most
desirable size
of chunks to read in in advance during block operations. However let's
have a look at the places (other then initializations) where the values
it holds
*actually* are used.

Inside fs/hfs/file.c:

hfs_do_read(..... int reada)

	if (reada) {
		if (blocks < read_ahead[MAJOR(dev)] / (HFS_SECTOR_SIZE>>9)) {
			blocks = read_ahead[MAJOR(dev)] / (HFS_SECTOR_SIZE>>9);
		}
		if (block + blocks > size) {
			blocks = size - block;
		}
	}

Here the desired value already is provided by the reada parameter.  We
don't
need to read it at all there, we should use the reada value directly
instead.

So the only places where read_ahead is used are only the
following ioctrl handler implementations:

The generic one:

./drivers/block/blkpg.c:
		case BLKRAGET:
			if (!arg)
				return -EINVAL;
			return put_user(read_ahead[MAJOR(dev)], (long *) arg);

And two specific ones:
./drivers/s390/block/xpram.c:
	case BLKRAGET: /* return the readahead value, 0x1263 */
		if (!arg)  return -EINVAL;
		err = 0; /* verify_area_20(VERIFY_WRITE, (long *) arg, sizeof(long));
		          * if (err) return err;
                          */
		put_user(read_ahead[MAJOR(inode->i_rdev)], (long *)arg);

		return 0;

./drivers/md/lvm.c: 
	case BLKRAGET:
		/* get current read ahead setting */
		P_IOCTL("%s -- lvm_blk_ioctl -- BLKRAGET\n", lvm_name);
		if (put_user(lv_ptr->lv_read_ahead, (long *)arg))
			return -EFAULT;
		break;

Therefore we can see that the read_ahead array is de facto only maybe
used as a
BOGOUS advice value for the user space.  At all other places it get's
only used
as a "write only" variable. We could therefore kill the WHOLE ARRAY and
all the
initialization code for it inside block device drivers where it get's
set!  We
would just have to replace it inside the ioctl handlers by a constant or
a
more appriopriate value and fix the bug in hfs! In fact the tests for
the
attached patch show that even ORACLE 9.0.1 doesn't bother with it, so I
have just
removed it.

So we thankfully to the wonderfull work by Andera and Alexander we can
now
get rid of this crappy read_ahead array. 

Marvelous isn't it?!
--------------AA7911A054708F9B7D528650
Content-Type: text/plain; charset=us-ascii;
 name="kill-read_ahead.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kill-read_ahead.patch"

diff -urN linux/drivers/acorn/block/mfmhd.c linux-new/drivers/acorn/block/mfmhd.c
--- linux/drivers/acorn/block/mfmhd.c	Sun Sep 23 15:09:23 2001
+++ linux-new/drivers/acorn/block/mfmhd.c	Sun Sep 23 14:56:44 2001
@@ -1448,7 +1448,6 @@
 	hdc63463_irqpollmask	= irqmask;
 
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
-	read_ahead[MAJOR_NR] = 8;	/* 8 sector (4kB?) read ahread */
 
 	add_gendisk(&mfm_gendisk);
 
diff -urN linux/drivers/block/DAC960.c linux-new/drivers/block/DAC960.c
--- linux/drivers/block/DAC960.c	Sun Sep 23 15:09:23 2001
+++ linux-new/drivers/block/DAC960.c	Sun Sep 23 14:17:07 2001
@@ -1921,10 +1921,6 @@
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
diff -urN linux/drivers/block/acsi.c linux-new/drivers/block/acsi.c
--- linux/drivers/block/acsi.c	Sun Sep 23 15:09:23 2001
+++ linux-new/drivers/block/acsi.c	Sun Sep 23 14:55:30 2001
@@ -1793,7 +1793,6 @@
 	STramMask = ATARIHW_PRESENT(EXTD_DMA) ? 0x00000000 : 0xff000000;
 	
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
-	read_ahead[MAJOR_NR] = 8;		/* 8 sector (4kB) read-ahead */
 	add_gendisk(&acsi_gendisk);
 
 #ifdef CONFIG_ATARI_SLM
diff -urN linux/drivers/block/blkpg.c linux-new/drivers/block/blkpg.c
--- linux/drivers/block/blkpg.c	Sun Sep 23 15:09:23 2001
+++ linux-new/drivers/block/blkpg.c	Sun Sep 23 13:47:28 2001
@@ -209,18 +209,6 @@
 			intval = (is_read_only(dev) != 0);
 			return put_user(intval, (int *)(arg));
 
-		case BLKRASET:
-			if(!capable(CAP_SYS_ADMIN))
-				return -EACCES;
-			if(!dev || arg > 0xff)
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
--- linux/drivers/block/cciss.c	Sun Sep 23 15:09:23 2001
+++ linux-new/drivers/block/cciss.c	Sun Sep 23 14:16:11 2001
@@ -1952,7 +1952,6 @@
 	/* fill in the other Kernel structs */
 	blksize_size[MAJOR_NR+i] = hba[i]->blocksizes;
         hardsect_size[MAJOR_NR+i] = hba[i]->hardsizes;
-        read_ahead[MAJOR_NR+i] = READ_AHEAD;
 
 	/* Set the pointers to queue functions */ 
 	q->back_merge_fn = cpq_back_merge_fn;
diff -urN linux/drivers/block/cpqarray.c linux-new/drivers/block/cpqarray.c
--- linux/drivers/block/cpqarray.c	Sun Sep 23 15:09:23 2001
+++ linux-new/drivers/block/cpqarray.c	Sun Sep 23 14:15:50 2001
@@ -526,7 +526,6 @@
 		blk_queue_headactive(q, 0);
 		blksize_size[MAJOR_NR+i] = ida_blocksizes + (i*256);
 		hardsect_size[MAJOR_NR+i] = ida_hardsizes + (i*256);
-		read_ahead[MAJOR_NR+i] = READ_AHEAD;
 
 		q->back_merge_fn = cpq_back_merge_fn;
 		q->front_merge_fn = cpq_front_merge_fn;
diff -urN linux/drivers/block/ll_rw_blk.c linux-new/drivers/block/ll_rw_blk.c
--- linux/drivers/block/ll_rw_blk.c	Sun Sep 23 15:09:23 2001
+++ linux-new/drivers/block/ll_rw_blk.c	Sun Sep 23 14:29:41 2001
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
--- linux/drivers/block/paride/pcd.c	Sun Feb  4 19:05:29 2001
+++ linux-new/drivers/block/paride/pcd.c	Sun Sep 23 14:42:24 2001
@@ -344,7 +344,6 @@
 		if (PCD.present) register_cdrom(&PCD.info);
 
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
-	read_ahead[MAJOR_NR] = 8;	/* 8 sector (4kB) read ahead */
 
 	for (i=0;i<PCD_UNITS;i++) pcd_blocksizes[i] = 1024;
         blksize_size[MAJOR_NR] = pcd_blocksizes;
diff -urN linux/drivers/block/paride/pd.c linux-new/drivers/block/paride/pd.c
--- linux/drivers/block/paride/pd.c	Sun Sep 23 15:09:23 2001
+++ linux-new/drivers/block/paride/pd.c	Sun Sep 23 14:41:58 2001
@@ -396,8 +396,7 @@
         }
 	q = BLK_DEFAULT_QUEUE(MAJOR_NR);
 	blk_init_queue(q, DEVICE_REQUEST);
-        read_ahead[MAJOR_NR] = 8;       /* 8 sector (4kB) read ahead */
-        
+
 	pd_gendisk.major = major;
 	pd_gendisk.major_name = name;
 	add_gendisk(&pd_gendisk);
diff -urN linux/drivers/block/paride/pf.c linux-new/drivers/block/paride/pf.c
--- linux/drivers/block/paride/pf.c	Sun Sep 23 15:09:23 2001
+++ linux-new/drivers/block/paride/pf.c	Sun Sep 23 14:42:52 2001
@@ -411,8 +411,7 @@
 	q->back_merge_fn = pf_back_merge_fn;
 	q->front_merge_fn = pf_front_merge_fn;
 	q->merge_requests_fn = pf_merge_requests_fn;
-        read_ahead[MAJOR_NR] = 8;       /* 8 sector (4kB) read ahead */
-        
+
 	for (i=0;i<PF_UNITS;i++) pf_blocksizes[i] = 1024;
 	blksize_size[MAJOR_NR] = pf_blocksizes;
 	for (i=0;i<PF_UNITS;i++)
diff -urN linux/drivers/block/ps2esdi.c linux-new/drivers/block/ps2esdi.c
--- linux/drivers/block/ps2esdi.c	Sun Sep 23 15:09:23 2001
+++ linux-new/drivers/block/ps2esdi.c	Sun Sep 23 14:54:27 2001
@@ -179,7 +179,6 @@
 	}
 	/* set up some global information - indicating device specific info */
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
-	read_ahead[MAJOR_NR] = 8;	/* 8 sector (4kB) read ahead */
 
 	/* some minor housekeeping - setup the global gendisk structure */
 	add_gendisk(&ps2esdi_gendisk);
diff -urN linux/drivers/block/xd.c linux-new/drivers/block/xd.c
--- linux/drivers/block/xd.c	Sun Sep 23 15:09:23 2001
+++ linux-new/drivers/block/xd.c	Sun Sep 23 14:15:22 2001
@@ -171,7 +171,6 @@
 	}
 	devfs_handle = devfs_mk_dir (NULL, xd_gendisk.major_name, NULL);
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
-	read_ahead[MAJOR_NR] = 8;	/* 8 sector (4kB) read ahead */
 	add_gendisk(&xd_gendisk);
 	xd_geninit();
 
@@ -1116,7 +1115,6 @@
 	blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
 	blk_size[MAJOR_NR] = NULL;
 	hardsect_size[MAJOR_NR] = NULL;
-	read_ahead[MAJOR_NR] = 0;
 	del_gendisk(&xd_gendisk);
 	release_region(xd_iobase,4);
 }
diff -urN linux/drivers/cdrom/aztcd.c linux-new/drivers/cdrom/aztcd.c
--- linux/drivers/cdrom/aztcd.c	Sun Sep 23 15:09:23 2001
+++ linux-new/drivers/cdrom/aztcd.c	Sun Sep 23 14:33:30 2001
@@ -1932,7 +1932,6 @@
 	}
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
 	blksize_size[MAJOR_NR] = aztcd_blocksizes;
-	read_ahead[MAJOR_NR] = 4;
 	register_disk(NULL, MKDEV(MAJOR_NR, 0), 1, &azt_fops, 0);
 
 	if ((azt_port == 0x1f0) || (azt_port == 0x170))
diff -urN linux/drivers/cdrom/cdu31a.c linux-new/drivers/cdrom/cdu31a.c
--- linux/drivers/cdrom/cdu31a.c	Sun Sep 23 15:09:23 2001
+++ linux-new/drivers/cdrom/cdu31a.c	Sun Sep 23 14:34:22 2001
@@ -3450,7 +3450,6 @@
 
 		blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR),
 			       DEVICE_REQUEST);
-		read_ahead[MAJOR_NR] = CDU31A_READAHEAD;
 		cdu31a_block_size = 1024;	/* 1kB default block size */
 		/* use 'mount -o block=2048' */
 		blksize_size[MAJOR_NR] = &cdu31a_block_size;
diff -urN linux/drivers/cdrom/cm206.c linux-new/drivers/cdrom/cm206.c
--- linux/drivers/cdrom/cm206.c	Sun Sep 23 15:09:24 2001
+++ linux-new/drivers/cdrom/cm206.c	Sun Sep 23 14:34:55 2001
@@ -1493,7 +1493,6 @@
 	}
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
 	blksize_size[MAJOR_NR] = cm206_blocksizes;
-	read_ahead[MAJOR_NR] = 16;	/* reads ahead what? */
 	init_bh(CM206_BH, cm206_bh);
 
 	memset(cd, 0, sizeof(*cd));	/* give'm some reasonable value */
diff -urN linux/drivers/cdrom/gscd.c linux-new/drivers/cdrom/gscd.c
--- linux/drivers/cdrom/gscd.c	Sun Sep 23 15:09:24 2001
+++ linux-new/drivers/cdrom/gscd.c	Sun Sep 23 14:35:22 2001
@@ -1024,7 +1024,6 @@
 
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
 	blksize_size[MAJOR_NR] = gscd_blocksizes;
-	read_ahead[MAJOR_NR] = 4;
 
 	disk_state = 0;
 	gscdPresent = 1;
diff -urN linux/drivers/cdrom/mcd.c linux-new/drivers/cdrom/mcd.c
--- linux/drivers/cdrom/mcd.c	Sun Sep 23 15:09:24 2001
+++ linux-new/drivers/cdrom/mcd.c	Sun Sep 23 14:35:51 2001
@@ -1072,7 +1072,6 @@
 
 	blksize_size[MAJOR_NR] = mcd_blocksizes;
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
-	read_ahead[MAJOR_NR] = 4;
 
 	/* check for card */
 
diff -urN linux/drivers/cdrom/mcdx.c linux-new/drivers/cdrom/mcdx.c
--- linux/drivers/cdrom/mcdx.c	Sun Sep 23 15:09:24 2001
+++ linux-new/drivers/cdrom/mcdx.c	Sun Sep 23 14:36:14 2001
@@ -1188,7 +1188,6 @@
 	}
 
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
-	read_ahead[MAJOR_NR] = READ_AHEAD;
 	blksize_size[MAJOR_NR] = mcdx_blocksizes;
 
 	xtrace(INIT, "init() subscribe irq and i/o\n");
diff -urN linux/drivers/cdrom/optcd.c linux-new/drivers/cdrom/optcd.c
--- linux/drivers/cdrom/optcd.c	Sun Sep 23 15:09:24 2001
+++ linux-new/drivers/cdrom/optcd.c	Sun Sep 23 14:36:48 2001
@@ -2069,7 +2069,6 @@
 	hardsect_size[MAJOR_NR] = &hsecsize;
 	blksize_size[MAJOR_NR] = &blksize;
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
-	read_ahead[MAJOR_NR] = 4;
 	request_region(optcd_port, 4, "optcd");
 	register_disk(NULL, MKDEV(MAJOR_NR,0), 1, &opt_fops, 0);
 
diff -urN linux/drivers/cdrom/sbpcd.c linux-new/drivers/cdrom/sbpcd.c
--- linux/drivers/cdrom/sbpcd.c	Sun Sep 23 15:09:24 2001
+++ linux-new/drivers/cdrom/sbpcd.c	Sun Sep 23 14:38:23 2001
@@ -4535,7 +4535,6 @@
 		if(!capable(CAP_SYS_ADMIN)) RETURN_UP(-EACCES);
 		if(!(cdi->dev)) RETURN_UP(-EINVAL);
 		if(arg > 0xff) RETURN_UP(-EINVAL);
-		read_ahead[MAJOR(cdi->dev)] = arg;
 		RETURN_UP(0);
 	default:
 		msg(DBG_IOC,"ioctl: unknown function request %04X\n", cmd);
@@ -5864,10 +5863,9 @@
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
--- linux/drivers/cdrom/sjcd.c	Sun Sep 23 15:09:24 2001
+++ linux-new/drivers/cdrom/sjcd.c	Sun Sep 23 14:39:03 2001
@@ -1707,7 +1707,6 @@
 	}
 
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
-	read_ahead[MAJOR_NR] = 4;
 	register_disk(NULL, MKDEV(MAJOR_NR, 0), 1, &sjcd_fops, 0);
 
 	if (check_region(sjcd_base, 4)) {
diff -urN linux/drivers/cdrom/sonycd535.c linux-new/drivers/cdrom/sonycd535.c
--- linux/drivers/cdrom/sonycd535.c	Sun Sep 23 15:09:24 2001
+++ linux-new/drivers/cdrom/sonycd535.c	Sun Sep 23 14:39:29 2001
@@ -1599,7 +1599,6 @@
 				}
 				blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
 				blksize_size[MAJOR_NR] = &sonycd535_block_size;
-				read_ahead[MAJOR_NR] = 8;	/* 8 sector (4kB) read-ahead */
 
 				sony_toc = (struct s535_sony_toc *)
 					kmalloc(sizeof *sony_toc, GFP_KERNEL);
diff -urN linux/drivers/ide/hd.c linux-new/drivers/ide/hd.c
--- linux/drivers/ide/hd.c	Sun Sep 23 15:09:24 2001
+++ linux-new/drivers/ide/hd.c	Sun Sep 23 14:30:38 2001
@@ -840,7 +840,6 @@
 		return -1;
 	}
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
-	read_ahead[MAJOR_NR] = 8;		/* 8 sector (4kB) read-ahead */
 	add_gendisk(&hd_gendisk);
 	init_timer(&device_timer);
 	device_timer.function = hd_times_out;
diff -urN linux/drivers/ide/ide-cd.c linux-new/drivers/ide/ide-cd.c
--- linux/drivers/ide/ide-cd.c	Thu Aug 16 18:30:45 2001
+++ linux-new/drivers/ide/ide-cd.c	Sun Sep 23 14:01:08 2001
@@ -2709,7 +2709,6 @@
 	int major = HWIF(drive)->major;
 	int minor = drive->select.b.unit << PARTN_BITS;
 
-	ide_add_setting(drive,	"breada_readahead",	SETTING_RW, BLKRAGET, BLKRASET, TYPE_INT, 0, 255, 1, 2, &read_ahead[major], NULL);
 	ide_add_setting(drive,	"file_readahead",	SETTING_RW, BLKFRAGET, BLKFRASET, TYPE_INTA, 0, INT_MAX, 1, 1024, &max_readahead[major][minor],	NULL);
 	ide_add_setting(drive,	"max_kb_per_request",	SETTING_RW, BLKSECTGET, BLKSECTSET, TYPE_INTA, 1, 255, 1, 2, &max_sectors[major][minor], NULL);
 	ide_add_setting(drive,	"dsc_overlap",		SETTING_RW, -1, -1, TYPE_BYTE, 0, 1, 1,	1, &drive->dsc_overlap, NULL);
diff -urN linux/drivers/ide/ide-disk.c linux-new/drivers/ide/ide-disk.c
--- linux/drivers/ide/ide-disk.c	Mon Aug 13 23:56:19 2001
+++ linux-new/drivers/ide/ide-disk.c	Sun Sep 23 13:53:29 2001
@@ -689,7 +689,6 @@
 	ide_add_setting(drive,	"bswap",		SETTING_READ,					-1,			-1,			TYPE_BYTE,	0,	1,				1,	1,	&drive->bswap,			NULL);
 	ide_add_setting(drive,	"multcount",		id ? SETTING_RW : SETTING_READ,			HDIO_GET_MULTCOUNT,	HDIO_SET_MULTCOUNT,	TYPE_BYTE,	0,	id ? id->max_multsect : 0,	1,	2,	&drive->mult_count,		set_multcount);
 	ide_add_setting(drive,	"nowerr",		SETTING_RW,					HDIO_GET_NOWERR,	HDIO_SET_NOWERR,	TYPE_BYTE,	0,	1,				1,	1,	&drive->nowerr,			set_nowerr);
-	ide_add_setting(drive,	"breada_readahead",	SETTING_RW,					BLKRAGET,		BLKRASET,		TYPE_INT,	0,	255,				1,	2,	&read_ahead[major],		NULL);
 	ide_add_setting(drive,	"file_readahead",	SETTING_RW,					BLKFRAGET,		BLKFRASET,		TYPE_INTA,	0,	INT_MAX,			1,	1024,	&max_readahead[major][minor],	NULL);
 	ide_add_setting(drive,	"max_kb_per_request",	SETTING_RW,					BLKSECTGET,		BLKSECTSET,		TYPE_INTA,	1,	255,				1,	2,	&max_sectors[major][minor],	NULL);
 	ide_add_setting(drive,	"lun",			SETTING_RW,					-1,			-1,			TYPE_INT,	0,	7,				1,	1,	&drive->lun,			NULL);
diff -urN linux/drivers/ide/ide-floppy.c linux-new/drivers/ide/ide-floppy.c
--- linux/drivers/ide/ide-floppy.c	Sun Sep 23 15:09:25 2001
+++ linux-new/drivers/ide/ide-floppy.c	Sun Sep 23 14:17:57 2001
@@ -1918,7 +1918,6 @@
 	ide_add_setting(drive,	"bios_cyl",		SETTING_RW,					-1,			-1,			TYPE_INT,	0,	1023,				1,	1,	&drive->bios_cyl,		NULL);
 	ide_add_setting(drive,	"bios_head",		SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	255,				1,	1,	&drive->bios_head,		NULL);
 	ide_add_setting(drive,	"bios_sect",		SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	63,				1,	1,	&drive->bios_sect,		NULL);
-	ide_add_setting(drive,	"breada_readahead",	SETTING_RW,					BLKRAGET,		BLKRASET,		TYPE_INT,	0,	255,				1,	2,	&read_ahead[major],		NULL);
 	ide_add_setting(drive,	"file_readahead",	SETTING_RW,					BLKFRAGET,		BLKFRASET,		TYPE_INTA,	0,	INT_MAX,			1,	1024,	&max_readahead[major][minor],	NULL);
 	ide_add_setting(drive,	"max_kb_per_request",	SETTING_RW,					BLKSECTGET,		BLKSECTSET,		TYPE_INTA,	1,	255,				1,	2,	&max_sectors[major][minor],	NULL);
 
diff -urN linux/drivers/ide/ide-probe.c linux-new/drivers/ide/ide-probe.c
--- linux/drivers/ide/ide-probe.c	Sun Sep 23 15:09:25 2001
+++ linux-new/drivers/ide/ide-probe.c	Sun Sep 23 13:52:12 2001
@@ -867,7 +867,6 @@
 	init_gendisk(hwif);
 	blk_dev[hwif->major].data = hwif;
 	blk_dev[hwif->major].queue = ide_get_queue;
-	read_ahead[hwif->major] = 8;	/* (4kB) */
 	hwif->present = 1;	/* success */
 
 #if (DEBUG_SPINLOCK > 0)
diff -urN linux/drivers/md/lvm.c linux-new/drivers/md/lvm.c
--- linux/drivers/md/lvm.c	Sun Sep 23 15:09:25 2001
+++ linux-new/drivers/md/lvm.c	Sun Sep 23 14:28:55 2001
@@ -197,14 +197,6 @@
 
 #include "lvm-snap.h"
 
-#define	LVM_CORRECT_READ_AHEAD(a)		\
-do {						\
-	if ((a) < LVM_MIN_READ_AHEAD ||		\
-	    (a) > LVM_MAX_READ_AHEAD)		\
-		(a) = LVM_DEFAULT_READ_AHEAD;	\
-	read_ahead[MAJOR_NR] = (a);		\
-} while(0)
-
 #ifndef WRITEA
 #  define WRITEA WRITE
 #endif
@@ -897,30 +889,6 @@
 		invalidate_buffers(inode->i_rdev);
 		break;
 
-
-	case BLKRASET:
-		/* set read ahead for block device */
-		if (!capable(CAP_SYS_ADMIN)) return -EACCES;
-
-		P_IOCTL("%s -- lvm_blk_ioctl -- BLKRASET: %d sectors for %02X:%02X\n",
-			lvm_name, (long) arg, MAJOR(inode->i_rdev), minor);
-
-		if ((long) arg < LVM_MIN_READ_AHEAD ||
-		    (long) arg > LVM_MAX_READ_AHEAD)
-			return -EINVAL;
-		lv_ptr->lv_read_ahead = (long) arg;
-		read_ahead[MAJOR_NR] = lv_ptr->lv_read_ahead;
-		break;
-
-
-	case BLKRAGET:
-		/* get current read ahead setting */
-		P_IOCTL("%s -- lvm_blk_ioctl -- BLKRAGET\n", lvm_name);
-		if (put_user(lv_ptr->lv_read_ahead, (long *)arg))
-			return -EFAULT;
-		break;
-
-
 	case HDIO_GETGEO:
 		/* get disk geometry */
 		P_IOCTL("%s -- lvm_blk_ioctl -- HDIO_GETGEO\n", lvm_name);
@@ -2277,7 +2245,6 @@
 	lvm_size[MINOR(lv_ptr->lv_dev)] = lv_ptr->lv_size >> 1;
 	vg_lv_map[MINOR(lv_ptr->lv_dev)].vg_number = vg_ptr->vg_number;
 	vg_lv_map[MINOR(lv_ptr->lv_dev)].lv_number = lv_ptr->lv_number;
-	LVM_CORRECT_READ_AHEAD(lv_ptr->lv_read_ahead);
 	vg_ptr->lv_cur++;
 	lv_ptr->lv_status = lv_status_save;
 
@@ -2582,8 +2549,6 @@
 	lvm_gendisk.part[MINOR(lv_ptr->lv_dev)].nr_sects = lv_ptr->lv_size;
 	lvm_size[MINOR(lv_ptr->lv_dev)] = lv_ptr->lv_size >> 1;
 	/* vg_lv_map array doesn't have to be changed here */
-
-	LVM_CORRECT_READ_AHEAD(lv_ptr->lv_read_ahead);
 
 	/* save availiable i/o statistic data */
 	/* linear logical volume */
diff -urN linux/drivers/md/md.c linux-new/drivers/md/md.c
--- linux/drivers/md/md.c	Sun Sep 23 15:09:25 2001
+++ linux-new/drivers/md/md.c	Sun Sep 23 14:20:10 2001
@@ -1727,7 +1727,6 @@
 	register_disk(&md_gendisk, MKDEV(MAJOR_NR,mdidx(mddev)),
 			1, &md_fops, md_size[mdidx(mddev)]<<1);
 
-	read_ahead[MD_MAJOR] = 1024;
 	return (0);
 }
 
@@ -3149,13 +3148,6 @@
 
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
@@ -3637,9 +3629,6 @@
 
 	/* forward all md request to md_make_request */
 	blk_queue_make_request(BLK_DEFAULT_QUEUE(MAJOR_NR), md_make_request);
-	
-
-	read_ahead[MAJOR_NR] = INT_MAX;
 
 	add_gendisk(&md_gendisk);
 
diff -urN linux/drivers/s390/block/xpram.c linux-new/drivers/s390/block/xpram.c
--- linux/drivers/s390/block/xpram.c	Sun Sep 23 15:09:27 2001
+++ linux-new/drivers/s390/block/xpram.c	Sun Sep 23 14:57:38 2001
@@ -661,22 +661,6 @@
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
 
@@ -1044,7 +1028,6 @@
 	blk_init_queue (q, xpram_request);
 	blk_queue_headactive (BLK_DEFAULT_QUEUE (major), 0);
 #endif /* V22/V24 */
-	read_ahead[major] = xpram_rahead;
 
 	/* we want to have XPRAM_UNUSED blocks security buffer between devices */
 	mem_usable=xpram_mem_avail-(XPRAM_UNUSED*(xpram_devs-1));
@@ -1183,7 +1166,6 @@
 	kfree(xpram_hardsects);
 	hardsect_size[major] = NULL;
  fail_malloc:
-	read_ahead[major] = 0;
 #if (XPRAM_VERSION == 22)
 	blk_dev[major].request_fn = NULL;
 #endif /* V22 */
@@ -1223,7 +1205,6 @@
 #if (XPRAM_VERSION == 22)
 	blk_dev[major].request_fn = NULL;
 #endif /* V22 */
-	read_ahead[major] = 0;
 	blk_size[major] = NULL;
 	kfree(blksize_size[major]);
 	blksize_size[major] = NULL;
diff -urN linux/drivers/s390/char/tapeblock.c linux-new/drivers/s390/char/tapeblock.c
--- linux/drivers/s390/char/tapeblock.c	Wed Jul 25 23:12:02 2001
+++ linux-new/drivers/s390/char/tapeblock.c	Sun Sep 23 14:59:12 2001
@@ -101,7 +101,6 @@
     }
     if (tapeblock_major == 0) tapeblock_major = result;   /* accept dynamic major number*/
     INIT_BLK_DEV(tapeblock_major,tape_request_fn,tapeblock_getqueue,NULL);
-    read_ahead[tapeblock_major]=TAPEBLOCK_READAHEAD;
     PRINT_WARN(KERN_ERR " tape gets major %d for block device\n", result);
     blk_size[tapeblock_major] = (int*) kmalloc (256*sizeof(int),GFP_ATOMIC);
     memset(blk_size[tapeblock_major],0,256*sizeof(int));
diff -urN linux/drivers/scsi/sd.c linux-new/drivers/scsi/sd.c
--- linux/drivers/scsi/sd.c	Sun Sep 23 15:09:28 2001
+++ linux-new/drivers/scsi/sd.c	Sun Sep 23 14:26:00 2001
@@ -1212,18 +1212,6 @@
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
-	}
 
 	return;
 }
@@ -1400,7 +1388,6 @@
 		del_gendisk(&sd_gendisks[i]);
 		blk_size[SD_MAJOR(i)] = NULL;
 		hardsect_size[SD_MAJOR(i)] = NULL;
-		read_ahead[SD_MAJOR(i)] = 0;
 	}
 	sd_template.dev_max = 0;
 	if (sd_gendisks != &sd_gendisk)
diff -urN linux/drivers/scsi/sr.c linux-new/drivers/scsi/sr.c
--- linux/drivers/scsi/sr.c	Sun Sep 23 15:09:28 2001
+++ linux-new/drivers/scsi/sr.c	Sun Sep 23 14:26:47 2001
@@ -867,15 +867,6 @@
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
-
 	return;
 }
 
@@ -933,7 +924,6 @@
 	blksize_size[MAJOR_NR] = NULL;
         hardsect_size[MAJOR_NR] = NULL;
 	blk_size[MAJOR_NR] = NULL;
-	read_ahead[MAJOR_NR] = 0;
 
 	sr_template.dev_max = 0;
 }
diff -urN linux/fs/hfs/file.c linux-new/fs/hfs/file.c
--- linux/fs/hfs/file.c	Sun Aug 12 19:56:56 2001
+++ linux-new/fs/hfs/file.c	Sun Sep 23 14:47:22 2001
@@ -312,14 +312,6 @@
 	blocks = (count+offset+HFS_SECTOR_SIZE-1) >> HFS_SECTOR_SIZE_BITS;
 
 	bhb = bhe = buflist;
-	if (reada) {
-		if (blocks < read_ahead[MAJOR(dev)] / (HFS_SECTOR_SIZE>>9)) {
-			blocks = read_ahead[MAJOR(dev)] / (HFS_SECTOR_SIZE>>9);
-		}
-		if (block + blocks > size) {
-			blocks = size - block;
-		}
-	}
 
 	/* We do this in a two stage process.  We first try and
 	   request as many blocks as we can, then we wait for the
diff -urN linux/include/linux/fs.h linux-new/include/linux/fs.h
--- linux/include/linux/fs.h	Sun Sep 23 15:09:35 2001
+++ linux-new/include/linux/fs.h	Sun Sep 23 13:33:48 2001
@@ -1418,7 +1418,6 @@
 
 extern ssize_t char_read(struct file *, char *, size_t, loff_t *);
 extern ssize_t block_read(struct file *, char *, size_t, loff_t *);
-extern int read_ahead[];
 
 extern ssize_t char_write(struct file *, const char *, size_t, loff_t *);
 extern ssize_t block_write(struct file *, const char *, size_t, loff_t *);
diff -urN linux/include/linux/lvm.h linux-new/include/linux/lvm.h
--- linux/include/linux/lvm.h	Sun Sep 23 15:09:35 2001
+++ linux-new/include/linux/lvm.h	Sun Sep 23 14:04:02 2001
@@ -608,7 +608,6 @@
 	uint lv_badblock;	/* for future use */
 	uint lv_allocation;
 	uint lv_io_timeout;	/* for future use */
-	uint lv_read_ahead;
 
 	/* delta to version 1 starts here */
 	struct lv_v4 *lv_snapshot_org;
@@ -658,7 +657,7 @@
 	uint32_t lv_badblock;	/* for future use */
 	uint32_t lv_allocation;
 	uint32_t lv_io_timeout;	/* for future use */
-	uint32_t lv_read_ahead;	/* HM */
+	uint32_t __unused;	/* HM */
 } lv_disk_v3_t;
 
 /*
diff -urN linux/kernel/ksyms.c linux-new/kernel/ksyms.c
--- linux/kernel/ksyms.c	Sun Sep 23 15:09:36 2001
+++ linux-new/kernel/ksyms.c	Sun Sep 23 13:35:14 2001
@@ -493,7 +493,6 @@
 EXPORT_SYMBOL(nr_async_pages);
 EXPORT_SYMBOL(___strtok);
 EXPORT_SYMBOL(init_special_inode);
-EXPORT_SYMBOL(read_ahead);
 EXPORT_SYMBOL(get_hash_table);
 EXPORT_SYMBOL(get_empty_inode);
 EXPORT_SYMBOL(insert_inode_hash);

--------------AA7911A054708F9B7D528650--

