Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291105AbSBLPXk>; Tue, 12 Feb 2002 10:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291106AbSBLPXg>; Tue, 12 Feb 2002 10:23:36 -0500
Received: from [195.63.194.11] ([195.63.194.11]:1806 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S291105AbSBLPXS>;
	Tue, 12 Feb 2002 10:23:18 -0500
Message-ID: <3C693357.8000204@evision-ventures.com>
Date: Tue, 12 Feb 2002 16:23:03 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Pavel Machek <pavel@suse.cz>, Jens Axboe <axboe@suse.de>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: another IDE cleanup: kill duplicated code
In-Reply-To: <20020211221102.GA131@elf.ucw.cz> <3C68F3F3.8030709@evision-ventures.com> <20020212132846.A7966@suse.cz> <3C690E56.3070606@evision-ventures.com> <20020212135701.A16420@suse.cz> <3C6915FC.2020707@evision-ventures.com> <20020212144300.A18431@suse.cz> <3C691F9C.10303@evision-ventures.com> <20020212154251.A25201@suse.cz>
Content-Type: multipart/mixed;
 boundary="------------020601000809040007080503"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020601000809040007080503
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Vojtech Pavlik wrote:

>The later (lv_disk_t) struct isn't used anywhere in the kernel -
>probably defined for userspace only? That's weird! And also many other
>structs in lvm.h are nowhere to be found used. Guess we could swipe them
>out as well.
>
>The first lv_read_ahead (in lv_t) removed. And references to it as well.
>
Yes I know the lvm coders where too deaf to separate user level 
structure layout properly
from on disk and kernel space by using just different header files for 
different purposes.
And then they tryed apparently to embarce anything they could think off, 
without really
thinking hard about what should be there and what shouldn't. It was too 
hard for
them to have a sneak view on for example Solaris to recognize what's 
really needed.

But they promise perpetually once in a while that the next version will 
be "coming real soon" and
be wonderfull...  Perhaps someone should just stump over them and clean 
this mess up,
with the disrespect those pseudo maintainers do deserve....

Anyway, you apparently still missed to kill:

     int *bs, max_ra; in ide-probe.c

as well as:
    xpram_rahead and friends in s390 code

The attached patch is fixing this.

BTW.> Since there is no longer any difference about the request head 
handling
between IDE and SCSI, what about the idea of moving the whole ide 
interface stuff under
the umbrella of SCSI host adapter? This would be a true cleanup and make
the whole ide-scsi and ide-atapi mess go away. IDE is moving fast toward 
SCSI on
the logical level anyway and it would make the hwif macro/lookup crap in 
the ide code go
magically way! At least this generic device handler search stuff should 
be merged
between them (I'm trully tempted to give it a shoot this afternoon.)
The only thing it could result in, which would maybe surprise some would 
be the fact
that the major of his root device could just go suddenly away... But 
hey! What's the heck - we
are in odd kernel series anyway ;-).

--------------020601000809040007080503
Content-Type: text/plain;
 name="readahead-clean-4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="readahead-clean-4.diff"

diff -ur linux-2.5.4/Documentation/cdrom/sbpcd linux/Documentation/cdrom/sbpcd
--- linux-2.5.4/Documentation/cdrom/sbpcd	Mon Feb 11 02:50:10 2002
+++ linux/Documentation/cdrom/sbpcd	Tue Feb 12 15:52:45 2002
@@ -613,8 +613,8 @@
 	printf("READ          d      READ RAW     w       READ AUDIO   A\n");
 	printf("MS-INFO       M      TOC          T       START        S\n");
 	printf("SET EJECTSW   X      DEVICE       D       DEBUG        Y\n");
-	printf("AUDIO_BUFSIZ  Z      RESET        R       BLKRASET     B\n");
-	printf("SET VOLUME    v      GET VOLUME   V\n");
+	printf("AUDIO_BUFSIZ  Z      RESET        R       SET VOLUME   v\n");
+	printf("GET VOLUME    V\n");
 }
 
 /*
@@ -882,12 +882,6 @@
 			rc=ioctl(drive,CDROMRESET);
 			if (rc<0) printf("CDROMRESET: rc=%d.\n",rc);
 			break;
-		case 'B': /* set the driver's (?) read ahead value */
-			printf("enter read-ahead size: ? ");
-			scanf("%d",&i);
-			rc=ioctl(drive,BLKRASET,i);
-			if (rc<0) printf("BLKRASET: rc=%d.\n",rc);
-			break;
 #ifdef AZT_PRIVATE_IOCTLS /*not supported by every CDROM driver*/
 		case 'd':
 			printf("Address (min:sec:frm)  ");
diff -ur linux-2.5.4/arch/mips64/kernel/ioctl32.c linux/arch/mips64/kernel/ioctl32.c
--- linux-2.5.4/arch/mips64/kernel/ioctl32.c	Mon Feb 11 02:50:17 2002
+++ linux/arch/mips64/kernel/ioctl32.c	Tue Feb 12 15:52:45 2002
@@ -760,10 +760,6 @@
 	IOCTL32_HANDLER(BLKGETSIZE, w_long),
 
 	IOCTL32_DEFAULT(BLKFLSBUF),
-	IOCTL32_DEFAULT(BLKRASET),
-	IOCTL32_HANDLER(BLKRAGET, w_long),
-	IOCTL32_DEFAULT(BLKFRASET),
-	IOCTL32_HANDLER(BLKFRAGET, w_long),
 	IOCTL32_DEFAULT(BLKSECTSET),
 	IOCTL32_HANDLER(BLKSECTGET, w_long),
 	IOCTL32_DEFAULT(BLKSSZGET),
diff -ur linux-2.5.4/arch/sparc64/kernel/ioctl32.c linux/arch/sparc64/kernel/ioctl32.c
--- linux-2.5.4/arch/sparc64/kernel/ioctl32.c	Mon Feb 11 02:50:14 2002
+++ linux/arch/sparc64/kernel/ioctl32.c	Tue Feb 12 15:52:45 2002
@@ -3997,8 +3997,6 @@
 COMPATIBLE_IOCTL(BLKROGET)
 COMPATIBLE_IOCTL(BLKRRPART)
 COMPATIBLE_IOCTL(BLKFLSBUF)
-COMPATIBLE_IOCTL(BLKRASET)
-COMPATIBLE_IOCTL(BLKFRASET)
 COMPATIBLE_IOCTL(BLKSECTSET)
 COMPATIBLE_IOCTL(BLKSSZGET)
 COMPATIBLE_IOCTL(BLKBSZGET)
@@ -4626,10 +4624,8 @@
 HANDLE_IOCTL(SIOCRTMSG, ret_einval)
 HANDLE_IOCTL(SIOCGSTAMP, do_siocgstamp)
 HANDLE_IOCTL(HDIO_GETGEO, hdio_getgeo)
-HANDLE_IOCTL(BLKRAGET, w_long)
 HANDLE_IOCTL(BLKGETSIZE, w_long)
 HANDLE_IOCTL(0x1260, broken_blkgetsize)
-HANDLE_IOCTL(BLKFRAGET, w_long)
 HANDLE_IOCTL(BLKSECTGET, w_long)
 HANDLE_IOCTL(BLKPG, blkpg_ioctl_trans)
 HANDLE_IOCTL(FBIOPUTCMAP32, fbiogetputcmap)
diff -ur linux-2.5.4/drivers/acorn/block/mfmhd.c linux/drivers/acorn/block/mfmhd.c
--- linux-2.5.4/drivers/acorn/block/mfmhd.c	Mon Feb 11 02:50:11 2002
+++ linux/drivers/acorn/block/mfmhd.c	Tue Feb 12 15:52:45 2002
@@ -1208,15 +1208,6 @@
 			return -EFAULT;
 		return 0;
 
-	case BLKFRASET:
-		if (!capable(CAP_SYS_ADMIN))
-			return -EACCES;
-		max_readahead[major][minor] = arg;
-		return 0;
-
-	case BLKFRAGET:
-		return put_user(max_readahead[major][minor], (long *) arg);
-
 	case BLKSECTGET:
 		return put_user(max_sectors[major][minor], (long *) arg);
 
@@ -1230,8 +1221,6 @@
 	case BLKFLSBUF:
 	case BLKROSET:
 	case BLKROGET:
-	case BLKRASET:
-	case BLKRAGET:
 	case BLKPG:
 		return blk_ioctl(dev, cmd, arg);
 
@@ -1442,7 +1431,6 @@
 	hdc63463_irqpollmask	= irqmask;
 
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
-	read_ahead[MAJOR_NR] = 8;	/* 8 sector (4kB?) read ahread */
 
 	add_gendisk(&mfm_gendisk);
 
diff -ur linux-2.5.4/drivers/block/DAC960.c linux/drivers/block/DAC960.c
--- linux-2.5.4/drivers/block/DAC960.c	Mon Feb 11 02:50:18 2002
+++ linux/drivers/block/DAC960.c	Tue Feb 12 15:52:45 2002
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
@@ -5399,8 +5395,6 @@
 			   sizeof(DiskGeometry_T)) ? -EFAULT : 0);
     case BLKGETSIZE:
     case BLKGETSIZE64:
-    case BLKRAGET:
-    case BLKRASET:
     case BLKFLSBUF:
     case BLKBSZGET:
     case BLKBSZSET:
diff -ur linux-2.5.4/drivers/block/acsi.c linux/drivers/block/acsi.c
--- linux-2.5.4/drivers/block/acsi.c	Mon Feb 11 02:50:16 2002
+++ linux/drivers/block/acsi.c	Tue Feb 12 15:52:45 2002
@@ -1785,7 +1785,6 @@
 	STramMask = ATARIHW_PRESENT(EXTD_DMA) ? 0x00000000 : 0xff000000;
 	
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST, &acsi_lock);
-	read_ahead[MAJOR_NR] = 8;		/* 8 sector (4kB) read-ahead */
 	add_gendisk(&acsi_gendisk);
 
 #ifdef CONFIG_ATARI_SLM
diff -ur linux-2.5.4/drivers/block/ataflop.c linux/drivers/block/ataflop.c
--- linux-2.5.4/drivers/block/ataflop.c	Mon Feb 11 02:50:10 2002
+++ linux/drivers/block/ataflop.c	Tue Feb 12 15:52:45 2002
@@ -1573,8 +1573,6 @@
 	switch (cmd) {
 		case BLKROSET:
 		case BLKROGET:
-		case BLKRASET:
-		case BLKRAGET:
 		case BLKFLSBUF:
 			return blk_ioctl(device, cmd, param);
 	}
diff -ur linux-2.5.4/drivers/block/blkpg.c linux/drivers/block/blkpg.c
--- linux-2.5.4/drivers/block/blkpg.c	Mon Feb 11 02:50:08 2002
+++ linux/drivers/block/blkpg.c	Tue Feb 12 15:52:45 2002
@@ -29,7 +29,7 @@
  */
 
 #include <linux/errno.h>
-#include <linux/fs.h>			/* for BLKRASET, ... */
+#include <linux/fs.h>			/* for BLKROSET, ... */
 #include <linux/sched.h>		/* for capable() */
 #include <linux/blk.h>			/* for set_device_ro() */
 #include <linux/blkpg.h>
@@ -227,31 +227,6 @@
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
-		case BLKFRASET:
-			if (!capable(CAP_SYS_ADMIN))
-				return -EACCES;
-			if (!(iptr = max_readahead[major(dev)]))
-				return -EINVAL;
-			iptr[minor(dev)] = arg;
-			return 0;
-
-		case BLKFRAGET:
-			if (!(iptr = max_readahead[major(dev)]))
-				return -EINVAL;
-			return put_user(iptr[minor(dev)], (long *) arg);
-
 		case BLKSECTGET:
 			if ((q = blk_get_queue(dev)) == NULL)
 				return -EINVAL;
diff -ur linux-2.5.4/drivers/block/cciss.c linux/drivers/block/cciss.c
--- linux-2.5.4/drivers/block/cciss.c	Mon Feb 11 02:50:15 2002
+++ linux/drivers/block/cciss.c	Tue Feb 12 15:52:45 2002
@@ -471,8 +471,6 @@
 	case BLKBSZGET:
 	case BLKROSET:
 	case BLKROGET:
-	case BLKRASET:
-	case BLKRAGET:
 	case BLKPG:
 		return blk_ioctl(inode->i_rdev, cmd, arg);
 	case CCISS_GETPCIINFO:
@@ -2542,7 +2540,6 @@
 
 	/* fill in the other Kernel structs */
 	blksize_size[MAJOR_NR+i] = hba[i]->blocksizes;
-        read_ahead[MAJOR_NR+i] = READ_AHEAD;
 
 	/* Fill in the gendisk data */ 	
 	hba[i]->gendisk.major = MAJOR_NR + i;
diff -ur linux-2.5.4/drivers/block/cpqarray.c linux/drivers/block/cpqarray.c
--- linux-2.5.4/drivers/block/cpqarray.c	Mon Feb 11 02:50:10 2002
+++ linux/drivers/block/cpqarray.c	Tue Feb 12 15:52:45 2002
@@ -481,7 +481,6 @@
 		blk_queue_max_phys_segments(q, SG_MAX);
 
 		blksize_size[MAJOR_NR+i] = ida_blocksizes + (i*256);
-		read_ahead[MAJOR_NR+i] = READ_AHEAD;
 
 		ida_gendisk[i].major = MAJOR_NR + i;
 		ida_gendisk[i].major_name = "ida";
@@ -1181,8 +1180,6 @@
 	case BLKBSZGET:
 	case BLKROSET:
 	case BLKROGET:
-	case BLKRASET:
-	case BLKRAGET:
 	case BLKPG:
 		return blk_ioctl(inode->i_rdev, cmd, arg);
 
diff -ur linux-2.5.4/drivers/block/floppy.c linux/drivers/block/floppy.c
--- linux-2.5.4/drivers/block/floppy.c	Mon Feb 11 02:50:10 2002
+++ linux/drivers/block/floppy.c	Tue Feb 12 15:52:45 2002
@@ -3448,8 +3448,6 @@
 	switch (cmd) {
 		case BLKROSET:
 		case BLKROGET:
-		case BLKRASET:
-		case BLKRAGET:
 		case BLKFLSBUF:
 			return blk_ioctl(device, cmd, param);
 	}
diff -ur linux-2.5.4/drivers/block/ll_rw_blk.c linux/drivers/block/ll_rw_blk.c
--- linux-2.5.4/drivers/block/ll_rw_blk.c	Mon Feb 11 02:50:09 2002
+++ linux/drivers/block/ll_rw_blk.c	Tue Feb 12 15:52:45 2002
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
@@ -84,11 +80,6 @@
 int * blksize_size[MAX_BLKDEV];
 
 /*
- * The following tunes the read-ahead algorithm in mm/filemap.c
- */
-int * max_readahead[MAX_BLKDEV];
-
-/*
  * How many reqeusts do we allocate per queue,
  * and how many do we "batch" on freeing them?
  */
@@ -1689,7 +1680,6 @@
 		dev->queue = NULL;
 
 	memset(ro_bits,0,sizeof(ro_bits));
-	memset(max_readahead, 0, sizeof(max_readahead));
 
 	total_ram = nr_free_pages() << (PAGE_SHIFT - 10);
 
diff -ur linux-2.5.4/drivers/block/paride/pcd.c linux/drivers/block/paride/pcd.c
--- linux-2.5.4/drivers/block/paride/pcd.c	Mon Feb 11 02:50:16 2002
+++ linux/drivers/block/paride/pcd.c	Tue Feb 12 15:52:45 2002
@@ -358,7 +358,6 @@
 	}
 
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST, &pcd_lock);
-	read_ahead[MAJOR_NR] = 8;	/* 8 sector (4kB) read ahead */
 
 	for (i=0;i<PCD_UNITS;i++) pcd_blocksizes[i] = 1024;
         blksize_size[MAJOR_NR] = pcd_blocksizes;
diff -ur linux-2.5.4/drivers/block/paride/pd.c linux/drivers/block/paride/pd.c
--- linux-2.5.4/drivers/block/paride/pd.c	Mon Feb 11 02:50:12 2002
+++ linux/drivers/block/paride/pd.c	Tue Feb 12 15:52:45 2002
@@ -397,7 +397,6 @@
 	q = BLK_DEFAULT_QUEUE(MAJOR_NR);
 	blk_init_queue(q, DEVICE_REQUEST, &pd_lock);
 	blk_queue_max_sectors(q, cluster);
-        read_ahead[MAJOR_NR] = 8;       /* 8 sector (4kB) read ahead */
         
 	pd_gendisk.major = major;
 	pd_gendisk.major_name = name;
@@ -480,8 +479,6 @@
 	    case BLKGETSIZE64:
 	    case BLKROSET:
 	    case BLKROGET:
-	    case BLKRASET:
-	    case BLKRAGET:
 	    case BLKFLSBUF:
 	    case BLKPG:
 		return blk_ioctl(inode->i_rdev, cmd, arg);
diff -ur linux-2.5.4/drivers/block/paride/pf.c linux/drivers/block/paride/pf.c
--- linux-2.5.4/drivers/block/paride/pf.c	Mon Feb 11 02:50:10 2002
+++ linux/drivers/block/paride/pf.c	Tue Feb 12 15:52:45 2002
@@ -363,7 +363,6 @@
 	blk_init_queue(q, DEVICE_REQUEST, &pf_spin_lock);
 	blk_queue_max_phys_segments(q, cluster);
 	blk_queue_max_hw_segments(q, cluster);
-        read_ahead[MAJOR_NR] = 8;       /* 8 sector (4kB) read ahead */
         
 	for (i=0;i<PF_UNITS;i++) pf_blocksizes[i] = 1024;
 	blksize_size[MAJOR_NR] = pf_blocksizes;
@@ -433,8 +432,6 @@
                 return put_user((u64)PF.capacity << 9,(u64 *)arg);
 	    case BLKROSET:
 	    case BLKROGET:
-	    case BLKRASET:
-	    case BLKRAGET:
 	    case BLKFLSBUF:
 		return blk_ioctl(inode->i_rdev, cmd, arg);
             default:
diff -ur linux-2.5.4/drivers/block/ps2esdi.c linux/drivers/block/ps2esdi.c
--- linux-2.5.4/drivers/block/ps2esdi.c	Mon Feb 11 02:50:06 2002
+++ linux/drivers/block/ps2esdi.c	Tue Feb 12 15:52:45 2002
@@ -177,7 +177,6 @@
 	}
 	/* set up some global information - indicating device specific info */
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST, &ps2esdi_lock);
-	read_ahead[MAJOR_NR] = 8;	/* 8 sector (4kB) read ahead */
 
 	/* some minor housekeeping - setup the global gendisk structure */
 	add_gendisk(&ps2esdi_gendisk);
@@ -1108,8 +1107,6 @@
 		case BLKGETSIZE64:
 		case BLKROSET:
 		case BLKROGET:
-		case BLKRASET:
-		case BLKRAGET:
 		case BLKFLSBUF:
 		case BLKBSZGET:
 		case BLKBSZSET:
diff -ur linux-2.5.4/drivers/block/xd.c linux/drivers/block/xd.c
--- linux-2.5.4/drivers/block/xd.c	Mon Feb 11 02:50:13 2002
+++ linux/drivers/block/xd.c	Tue Feb 12 15:52:45 2002
@@ -171,7 +171,6 @@
 	}
 	devfs_handle = devfs_mk_dir (NULL, xd_gendisk.major_name, NULL);
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST, &xd_lock);
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
 
diff -ur linux-2.5.4/drivers/cdrom/aztcd.c linux/drivers/cdrom/aztcd.c
--- linux-2.5.4/drivers/cdrom/aztcd.c	Mon Feb 11 02:50:14 2002
+++ linux/drivers/cdrom/aztcd.c	Tue Feb 12 15:52:45 2002
@@ -1927,7 +1927,6 @@
 	}
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST, &aztSpin);
 	blksize_size[MAJOR_NR] = aztcd_blocksizes;
-	read_ahead[MAJOR_NR] = 4;
 	register_disk(NULL, mk_kdev(MAJOR_NR, 0), 1, &azt_fops, 0);
 
 	if ((azt_port == 0x1f0) || (azt_port == 0x170))
diff -ur linux-2.5.4/drivers/cdrom/cdu31a.c linux/drivers/cdrom/cdu31a.c
--- linux-2.5.4/drivers/cdrom/cdu31a.c	Mon Feb 11 02:50:10 2002
+++ linux/drivers/cdrom/cdu31a.c	Tue Feb 12 15:52:45 2002
@@ -3442,7 +3442,6 @@
 		blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR),
 			       DEVICE_REQUEST,
 			       &cdu31a_lock);
-		read_ahead[MAJOR_NR] = CDU31A_READAHEAD;
 		cdu31a_block_size = 1024;	/* 1kB default block size */
 		/* use 'mount -o block=2048' */
 		blksize_size[MAJOR_NR] = &cdu31a_block_size;
diff -ur linux-2.5.4/drivers/cdrom/cm206.c linux/drivers/cdrom/cm206.c
--- linux-2.5.4/drivers/cdrom/cm206.c	Mon Feb 11 02:50:14 2002
+++ linux/drivers/cdrom/cm206.c	Tue Feb 12 15:52:45 2002
@@ -1503,7 +1503,6 @@
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST,
 		       &cm206_lock);
 	blksize_size[MAJOR_NR] = cm206_blocksizes;
-	read_ahead[MAJOR_NR] = 16;	/* reads ahead what? */
 	init_bh(CM206_BH, cm206_bh);
 
 	memset(cd, 0, sizeof(*cd));	/* give'm some reasonable value */
diff -ur linux-2.5.4/drivers/cdrom/gscd.c linux/drivers/cdrom/gscd.c
--- linux-2.5.4/drivers/cdrom/gscd.c	Mon Feb 11 02:50:07 2002
+++ linux/drivers/cdrom/gscd.c	Tue Feb 12 15:52:45 2002
@@ -1022,7 +1022,6 @@
 
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST, &gscd_lock);
 	blksize_size[MAJOR_NR] = gscd_blocksizes;
-	read_ahead[MAJOR_NR] = 4;
 
 	disk_state = 0;
 	gscdPresent = 1;
diff -ur linux-2.5.4/drivers/cdrom/mcd.c linux/drivers/cdrom/mcd.c
--- linux-2.5.4/drivers/cdrom/mcd.c	Mon Feb 11 02:50:08 2002
+++ linux/drivers/cdrom/mcd.c	Tue Feb 12 15:52:45 2002
@@ -1075,7 +1075,6 @@
 	blksize_size[MAJOR_NR] = mcd_blocksizes;
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST,
 		       &mcd_spinlock);
-	read_ahead[MAJOR_NR] = 4;
 
 	/* check for card */
 
diff -ur linux-2.5.4/drivers/cdrom/mcdx.c linux/drivers/cdrom/mcdx.c
--- linux-2.5.4/drivers/cdrom/mcdx.c	Mon Feb 11 02:50:16 2002
+++ linux/drivers/cdrom/mcdx.c	Tue Feb 12 15:52:45 2002
@@ -1184,7 +1184,6 @@
 
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST,
 		       &mcdx_lock);
-	read_ahead[MAJOR_NR] = READ_AHEAD;
 	blksize_size[MAJOR_NR] = mcdx_blocksizes;
 
 	xtrace(INIT, "init() subscribe irq and i/o\n");
diff -ur linux-2.5.4/drivers/cdrom/optcd.c linux/drivers/cdrom/optcd.c
--- linux-2.5.4/drivers/cdrom/optcd.c	Mon Feb 11 02:50:12 2002
+++ linux/drivers/cdrom/optcd.c	Tue Feb 12 15:52:45 2002
@@ -2062,7 +2062,6 @@
 	blksize_size[MAJOR_NR] = &blksize;
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST,
 		       &optcd_lock);
-	read_ahead[MAJOR_NR] = 4;
 	request_region(optcd_port, 4, "optcd");
 	register_disk(NULL, mk_kdev(MAJOR_NR,0), 1, &opt_fops, 0);
 
diff -ur linux-2.5.4/drivers/cdrom/sbpcd.c linux/drivers/cdrom/sbpcd.c
--- linux-2.5.4/drivers/cdrom/sbpcd.c	Mon Feb 11 02:50:11 2002
+++ linux/drivers/cdrom/sbpcd.c	Tue Feb 12 15:52:45 2002
@@ -4531,12 +4531,6 @@
 		RETURN_UP(0);
 	} /* end of CDROMREADAUDIO */
 		
-	case BLKRASET:
-		if(!capable(CAP_SYS_ADMIN)) RETURN_UP(-EACCES);
-		if(kdev_none(cdi->dev)) RETURN_UP(-EINVAL);
-		if(arg > 0xff) RETURN_UP(-EINVAL);
-		read_ahead[major(cdi->dev)] = arg;
-		RETURN_UP(0);
 	default:
 		msg(DBG_IOC,"ioctl: unknown function request %04X\n", cmd);
 		RETURN_UP(-EINVAL);
diff -ur linux-2.5.4/drivers/cdrom/sjcd.c linux/drivers/cdrom/sjcd.c
--- linux-2.5.4/drivers/cdrom/sjcd.c	Mon Feb 11 02:50:10 2002
+++ linux/drivers/cdrom/sjcd.c	Tue Feb 12 15:52:45 2002
@@ -1695,7 +1695,6 @@
 	}
 
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST,&sjcd_lock);
-	read_ahead[MAJOR_NR] = 4;
 	register_disk(NULL, mk_kdev(MAJOR_NR, 0), 1, &sjcd_fops, 0);
 
 	if (check_region(sjcd_base, 4)) {
diff -ur linux-2.5.4/drivers/cdrom/sonycd535.c linux/drivers/cdrom/sonycd535.c
--- linux-2.5.4/drivers/cdrom/sonycd535.c	Mon Feb 11 02:50:14 2002
+++ linux/drivers/cdrom/sonycd535.c	Tue Feb 12 15:52:45 2002
@@ -1598,7 +1598,6 @@
 				}
 				blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST, &sonycd535_lock);
 				blksize_size[MAJOR_NR] = &sonycd535_block_size;
-				read_ahead[MAJOR_NR] = 8;	/* 8 sector (4kB) read-ahead */
 
 				sony_toc = (struct s535_sony_toc *)
 					kmalloc(sizeof *sony_toc, GFP_KERNEL);
Only in linux/drivers/ide: .ide-probe.c.swp
diff -ur linux-2.5.4/drivers/ide/ataraid.c linux/drivers/ide/ataraid.c
--- linux-2.5.4/drivers/ide/ataraid.c	Mon Feb 11 02:50:16 2002
+++ linux/drivers/ide/ataraid.c	Tue Feb 12 15:52:45 2002
@@ -289,7 +289,6 @@
 	hardsect_size[ATAMAJOR] = NULL;
 	blk_size[ATAMAJOR] = NULL;
 	blksize_size[ATAMAJOR] = NULL;                       
-	max_readahead[ATAMAJOR] = NULL;
 
 	del_gendisk(&ataraid_gendisk);
         
diff -ur linux-2.5.4/drivers/ide/hd.c linux/drivers/ide/hd.c
--- linux-2.5.4/drivers/ide/hd.c	Mon Feb 11 02:50:10 2002
+++ linux/drivers/ide/hd.c	Tue Feb 12 15:52:45 2002
@@ -652,8 +652,6 @@
 		case BLKGETSIZE64:
 		case BLKROSET:
 		case BLKROGET:
-		case BLKRASET:
-		case BLKRAGET:
 		case BLKFLSBUF:
 		case BLKPG:
 			return blk_ioctl(inode->i_rdev, cmd, arg);
@@ -837,7 +835,6 @@
 	}
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST, &hd_lock);
 	blk_queue_max_sectors(BLK_DEFAULT_QUEUE(MAJOR_NR), 255);
-	read_ahead[MAJOR_NR] = 8;		/* 8 sector (4kB) read-ahead */
 	add_gendisk(&hd_gendisk);
 	init_timer(&device_timer);
 	device_timer.function = hd_times_out;
diff -ur linux-2.5.4/drivers/ide/ide-cd.c linux/drivers/ide/ide-cd.c
--- linux-2.5.4/drivers/ide/ide-cd.c	Mon Feb 11 02:50:16 2002
+++ linux/drivers/ide/ide-cd.c	Tue Feb 12 15:52:45 2002
@@ -2659,11 +2659,6 @@
 
 static void ide_cdrom_add_settings(ide_drive_t *drive)
 {
-	int major = HWIF(drive)->major;
-	int minor = drive->select.b.unit << PARTN_BITS;
-
-	ide_add_setting(drive,	"breada_readahead",	SETTING_RW, BLKRAGET, BLKRASET, TYPE_INT, 0, 255, 1, 2, &read_ahead[major], NULL);
-	ide_add_setting(drive,	"file_readahead",	SETTING_RW, BLKFRAGET, BLKFRASET, TYPE_INTA, 0, INT_MAX, 1, 1024, &max_readahead[major][minor],	NULL);
 	ide_add_setting(drive,	"dsc_overlap",		SETTING_RW, -1, -1, TYPE_BYTE, 0, 1, 1,	1, &drive->dsc_overlap, NULL);
 }
 
diff -ur linux-2.5.4/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.5.4/drivers/ide/ide-disk.c	Mon Feb 11 02:50:07 2002
+++ linux/drivers/ide/ide-disk.c	Tue Feb 12 15:52:45 2002
@@ -916,8 +916,6 @@
 	ide_add_setting(drive,	"bswap",		SETTING_READ,					-1,			-1,			TYPE_BYTE,	0,	1,				1,	1,	&drive->bswap,			NULL);
 	ide_add_setting(drive,	"multcount",		id ? SETTING_RW : SETTING_READ,			HDIO_GET_MULTCOUNT,	HDIO_SET_MULTCOUNT,	TYPE_BYTE,	0,	id ? id->max_multsect : 0,	1,	1,	&drive->mult_count,		set_multcount);
 	ide_add_setting(drive,	"nowerr",		SETTING_RW,					HDIO_GET_NOWERR,	HDIO_SET_NOWERR,	TYPE_BYTE,	0,	1,				1,	1,	&drive->nowerr,			set_nowerr);
-	ide_add_setting(drive,	"breada_readahead",	SETTING_RW,					BLKRAGET,		BLKRASET,		TYPE_INT,	0,	255,				1,	1,	&read_ahead[major],		NULL);
-	ide_add_setting(drive,	"file_readahead",	SETTING_RW,					BLKFRAGET,		BLKFRASET,		TYPE_INTA,	0,	4096,			PAGE_SIZE,	1024,	&max_readahead[major][minor],	NULL);
 	ide_add_setting(drive,	"lun",			SETTING_RW,					-1,			-1,			TYPE_INT,	0,	7,				1,	1,	&drive->lun,			NULL);
 	ide_add_setting(drive,	"wcache",		SETTING_RW,					HDIO_GET_WCACHE,	HDIO_SET_WCACHE,	TYPE_BYTE,	0,	1,				1,	1,	&drive->wcache,			write_cache);
 	ide_add_setting(drive,	"acoustic",		SETTING_RW,					HDIO_GET_ACOUSTIC,	HDIO_SET_ACOUSTIC,	TYPE_BYTE,	0,	254,				1,	1,	&drive->acoustic,		set_acoustic);
diff -ur linux-2.5.4/drivers/ide/ide-floppy.c linux/drivers/ide/ide-floppy.c
--- linux-2.5.4/drivers/ide/ide-floppy.c	Mon Feb 11 02:50:12 2002
+++ linux/drivers/ide/ide-floppy.c	Tue Feb 12 15:52:45 2002
@@ -1968,8 +1968,6 @@
 	ide_add_setting(drive,	"bios_cyl",		SETTING_RW,					-1,			-1,			TYPE_INT,	0,	1023,				1,	1,	&drive->bios_cyl,		NULL);
 	ide_add_setting(drive,	"bios_head",		SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	255,				1,	1,	&drive->bios_head,		NULL);
 	ide_add_setting(drive,	"bios_sect",		SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	63,				1,	1,	&drive->bios_sect,		NULL);
-	ide_add_setting(drive,	"breada_readahead",	SETTING_RW,					BLKRAGET,		BLKRASET,		TYPE_INT,	0,	255,				1,	2,	&read_ahead[major],		NULL);
-	ide_add_setting(drive,	"file_readahead",	SETTING_RW,					BLKFRAGET,		BLKFRASET,		TYPE_INTA,	0,	INT_MAX,			1,	1024,	&max_readahead[major][minor],	NULL);
 
 }
 
diff -ur linux-2.5.4/drivers/ide/ide-probe.c linux/drivers/ide/ide-probe.c
--- linux-2.5.4/drivers/ide/ide-probe.c	Mon Feb 11 02:50:06 2002
+++ linux/drivers/ide/ide-probe.c	Tue Feb 12 15:58:33 2002
@@ -789,7 +789,6 @@
 {
 	struct gendisk *gd;
 	unsigned int unit, units, minors;
-	int *bs, *max_ra;
 	extern devfs_handle_t ide_devfs_handle;
 
 #if 1
@@ -802,35 +801,27 @@
 	}
 #endif
 
-	minors    = units * (1<<PARTN_BITS);
-	gd        = kmalloc (sizeof(struct gendisk), GFP_KERNEL);
+	minors = units * (1<<PARTN_BITS);
+
+	gd = kmalloc (sizeof(struct gendisk), GFP_KERNEL);
 	if (!gd)
 		goto err_kmalloc_gd;
 	gd->sizes = kmalloc (minors * sizeof(int), GFP_KERNEL);
 	if (!gd->sizes)
 		goto err_kmalloc_gd_sizes;
-	gd->part  = kmalloc (minors * sizeof(struct hd_struct), GFP_KERNEL);
+	gd->part = kmalloc (minors * sizeof(struct hd_struct), GFP_KERNEL);
 	if (!gd->part)
 		goto err_kmalloc_gd_part;
-	bs        = kmalloc (minors*sizeof(int), GFP_KERNEL);
-	if (!bs)
+	blksize_size[hwif->major] = kmalloc (minors*sizeof(int), GFP_KERNEL);
+	if (!blksize_size[hwif->major])
 		goto err_kmalloc_bs;
-	max_ra    = kmalloc (minors*sizeof(int), GFP_KERNEL);
-	if (!max_ra)
-		goto err_kmalloc_max_ra;
 
 	memset(gd->part, 0, minors * sizeof(struct hd_struct));
 
-	/* cdroms and msdos f/s are examples of non-1024 blocksizes */
-	blksize_size[hwif->major] = bs;
-	max_readahead[hwif->major] = max_ra;
-	for (unit = 0; unit < minors; ++unit) {
-		*bs++ = BLOCK_SIZE;
-		*max_ra++ = MAX_READAHEAD;
-	}
-
-	for (unit = 0; unit < units; ++unit)
+	for (unit = 0; unit < minors; unit++) {
+		blksize_size[hwif->major][unit] = BLOCK_SIZE;
 		hwif->drives[unit].part = &gd->part[unit << PARTN_BITS];
+	}
 
 	gd->major	= hwif->major;		/* our major device number */
 	gd->major_name	= IDE_MAJOR_NAME;	/* treated special in genhd.c */
@@ -875,8 +866,6 @@
 	}
 	return;
 
-err_kmalloc_max_ra:
-	kfree(bs);
 err_kmalloc_bs:
 	kfree(gd->part);
 err_kmalloc_gd_part:
@@ -937,7 +926,6 @@
 	init_gendisk(hwif);
 	blk_dev[hwif->major].data = hwif;
 	blk_dev[hwif->major].queue = ide_get_queue;
-	read_ahead[hwif->major] = 8;	/* (4kB) */
 	hwif->present = 1;	/* success */
 
 	return hwif->present;
diff -ur linux-2.5.4/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.4/drivers/ide/ide.c	Mon Feb 11 02:50:16 2002
+++ linux/drivers/ide/ide.c	Tue Feb 12 15:52:45 2002
@@ -2126,7 +2126,6 @@
 	 */
 	unregister_blkdev(hwif->major, hwif->name);
 	kfree(blksize_size[hwif->major]);
-	kfree(max_readahead[hwif->major]);
 	blk_dev[hwif->major].data = NULL;
 	blk_dev[hwif->major].queue = NULL;
 	blk_clear(hwif->major);
diff -ur linux-2.5.4/drivers/md/lvm.c linux/drivers/md/lvm.c
--- linux-2.5.4/drivers/md/lvm.c	Mon Feb 11 02:50:08 2002
+++ linux/drivers/md/lvm.c	Tue Feb 12 15:52:45 2002
@@ -226,10 +226,6 @@
 
 #include "lvm-internal.h"
 
-#define	LVM_CORRECT_READ_AHEAD( a) \
-   if      ( a < LVM_MIN_READ_AHEAD || \
-             a > LVM_MAX_READ_AHEAD) a = LVM_MAX_READ_AHEAD;
-
 #ifndef WRITEA
 #  define WRITEA WRITE
 #endif
@@ -883,29 +879,6 @@
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
@@ -2035,7 +2008,6 @@
 	lvm_size[minor(lv_ptr->lv_dev)] = lv_ptr->lv_size >> 1;
 	vg_lv_map[minor(lv_ptr->lv_dev)].vg_number = vg_ptr->vg_number;
 	vg_lv_map[minor(lv_ptr->lv_dev)].lv_number = lv_ptr->lv_number;
-	LVM_CORRECT_READ_AHEAD(lv_ptr->lv_read_ahead);
 	vg_ptr->lv_cur++;
 	lv_ptr->lv_status = lv_status_save;
 
diff -ur linux-2.5.4/drivers/md/md.c linux/drivers/md/md.c
--- linux-2.5.4/drivers/md/md.c	Mon Feb 11 02:50:13 2002
+++ linux/drivers/md/md.c	Tue Feb 12 15:52:45 2002
@@ -1737,7 +1737,6 @@
 	register_disk(&md_gendisk, mk_kdev(MAJOR_NR,mdidx(mddev)),
 			1, &md_fops, md_size[mdidx(mddev)]<<1);
 
-	read_ahead[MD_MAJOR] = 1024;
 	return (0);
 }
 
@@ -2622,8 +2621,6 @@
 						(u64 *) arg);
 			goto done;
 
-		case BLKRAGET:
-		case BLKRASET:
 		case BLKFLSBUF:
 		case BLKBSZGET:
 		case BLKBSZSET:
@@ -3176,13 +3173,6 @@
 
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
@@ -3622,7 +3612,6 @@
 	}
 	blksize_size[MAJOR_NR] = md_blocksizes;
 	blk_size[MAJOR_NR] = md_size;
-	max_readahead[MAJOR_NR] = md_maxreadahead;
 
 	dprintk("md: sizeof(mdp_super_t) = %d\n", (int)sizeof(mdp_super_t));
 
@@ -3658,9 +3647,6 @@
 	/* forward all md request to md_make_request */
 	blk_queue_make_request(BLK_DEFAULT_QUEUE(MAJOR_NR), md_make_request);
 
-
-	read_ahead[MAJOR_NR] = INT_MAX;
-
 	add_gendisk(&md_gendisk);
 
 	md_recovery_thread = md_register_thread(md_do_recovery, NULL, name);
diff -ur linux-2.5.4/drivers/message/i2o/i2o_block.c linux/drivers/message/i2o/i2o_block.c
--- linux-2.5.4/drivers/message/i2o/i2o_block.c	Mon Feb 11 02:50:11 2002
+++ linux/drivers/message/i2o/i2o_block.c	Tue Feb 12 15:52:45 2002
@@ -1104,8 +1104,6 @@
 		case BLKFLSBUF:
 		case BLKROSET:
 		case BLKROGET:
-		case BLKRASET:
-		case BLKRAGET:
 		case BLKPG:
 			return blk_ioctl(inode->i_rdev, cmd, arg);
 			
diff -ur linux-2.5.4/drivers/s390/block/dasd.c linux/drivers/s390/block/dasd.c
--- linux-2.5.4/drivers/s390/block/dasd.c	Mon Feb 11 02:50:16 2002
+++ linux/drivers/s390/block/dasd.c	Tue Feb 12 15:52:45 2002
@@ -2489,8 +2489,6 @@
 	case BLKSSZGET:
 	case BLKROSET:
 	case BLKROGET:
-	case BLKRASET:
-	case BLKRAGET:
 	case BLKFLSBUF:
 	case BLKPG:
 	case BLKELVGET:
diff -ur linux-2.5.4/drivers/s390/block/xpram.c linux/drivers/s390/block/xpram.c
--- linux-2.5.4/drivers/s390/block/xpram.c	Mon Feb 11 02:50:11 2002
+++ linux/drivers/s390/block/xpram.c	Tue Feb 12 16:06:40 2002
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
@@ -659,26 +658,9 @@
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
 
-
 #if (XPRAM_VERSION == 22)
 		RO_IOCTLS(inode->i_rdev, arg); /* the default RO operations 
                                                 * BLKROSET
@@ -940,7 +922,6 @@
 				 * snoozing with a debugger.
 				 */
 
-	xpram_rahead   = rahead;
 	xpram_blksize  = blksize;
 	xpram_hardsect = hardsect;
 
@@ -1029,7 +1010,7 @@
 	PRINT_INFO("  %d kB expanded memory found.\n",xpram_mem_avail );
 
 	/*
-	 * Assign the other needed values: request, rahead, size, blksize,
+	 * Assign the other needed values: request, size, blksize,
 	 * hardsect. All the minor devices feature the same value.
 	 * Note that `xpram' defines all of them to allow testing non-default
 	 * values. A real device could well avoid setting values in global
@@ -1042,7 +1023,6 @@
 	q = BLK_DEFAULT_QUEUE (major);
 	blk_init_queue (q, xpram_request);
 #endif /* V22/V24 */
-	read_ahead[major] = xpram_rahead;
 
 	/* we want to have XPRAM_UNUSED blocks security buffer between devices */
 	mem_usable=xpram_mem_avail-(XPRAM_UNUSED*(xpram_devs-1));
@@ -1181,7 +1161,6 @@
 	kfree(xpram_hardsects);
 	hardsect_size[major] = NULL;
  fail_malloc:
-	read_ahead[major] = 0;
 #if (XPRAM_VERSION == 22)
 	blk_dev[major].request_fn = NULL;
 #endif /* V22 */
diff -ur linux-2.5.4/drivers/s390/block/xpram.h linux/drivers/s390/block/xpram.h
--- linux-2.5.4/drivers/s390/block/xpram.h	Mon Feb 11 02:50:17 2002
+++ linux/drivers/s390/block/xpram.h	Tue Feb 12 16:06:44 2002
@@ -18,7 +18,6 @@
 #define XPRAM_NAME "xpram"  /* name of device/module */
 #define XPRAM_DEVICE_NAME_PREFIX "slram" /* Prefix device name for major 35 */
 #define XPRAM_DEVS 1        /* one partition */
-#define XPRAM_RAHEAD 8      /* no real read ahead */
 #define XPRAM_PGSIZE 4096   /* page size of (expanded) mememory pages
                              * according to S/390 architecture
                              */
diff -ur linux-2.5.4/drivers/s390/char/tapeblock.c linux/drivers/s390/char/tapeblock.c
--- linux-2.5.4/drivers/s390/char/tapeblock.c	Mon Feb 11 02:50:15 2002
+++ linux/drivers/s390/char/tapeblock.c	Tue Feb 12 15:52:45 2002
@@ -101,7 +101,6 @@
     }
     if (tapeblock_major == 0) tapeblock_major = result;   /* accept dynamic major number*/
     INIT_BLK_DEV(tapeblock_major,tape_request_fn,tapeblock_getqueue,NULL);
-    read_ahead[tapeblock_major]=TAPEBLOCK_READAHEAD;
     PRINT_WARN(KERN_ERR " tape gets major %d for block device\n", result);
     blk_size[tapeblock_major] = (int*) kmalloc (256*sizeof(int),GFP_ATOMIC);
     memset(blk_size[tapeblock_major],0,256*sizeof(int));
diff -ur linux-2.5.4/drivers/scsi/sd.c linux/drivers/scsi/sd.c
--- linux-2.5.4/drivers/scsi/sd.c	Mon Feb 11 02:50:11 2002
+++ linux/drivers/scsi/sd.c	Tue Feb 12 15:52:45 2002
@@ -228,8 +228,6 @@
 		case BLKGETSIZE64:
 		case BLKROSET:
 		case BLKROGET:
-		case BLKRASET:
-		case BLKRAGET:
 		case BLKFLSBUF:
 		case BLKSSZGET:
 		case BLKPG:
@@ -1190,18 +1188,6 @@
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
diff -ur linux-2.5.4/drivers/scsi/sr.c linux/drivers/scsi/sr.c
--- linux-2.5.4/drivers/scsi/sr.c	Mon Feb 11 02:50:12 2002
+++ linux/drivers/scsi/sr.c	Tue Feb 12 15:52:45 2002
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
diff -ur linux-2.5.4/drivers/scsi/sr_ioctl.c linux/drivers/scsi/sr_ioctl.c
--- linux-2.5.4/drivers/scsi/sr_ioctl.c	Mon Feb 11 02:50:09 2002
+++ linux/drivers/scsi/sr_ioctl.c	Tue Feb 12 15:52:45 2002
@@ -550,8 +550,6 @@
 		return put_user((u64)scsi_CDs[target].capacity << 9, (u64 *)arg);
 	case BLKROSET:
 	case BLKROGET:
-	case BLKRASET:
-	case BLKRAGET:
 	case BLKFLSBUF:
 	case BLKSSZGET:
 		return blk_ioctl(cdi->dev, cmd, arg);
diff -ur linux-2.5.4/fs/hfs/file.c linux/fs/hfs/file.c
--- linux-2.5.4/fs/hfs/file.c	Mon Feb 11 02:50:14 2002
+++ linux/fs/hfs/file.c	Tue Feb 12 15:52:45 2002
@@ -163,8 +163,7 @@
 	if (left <= 0) {
 		return 0;
 	}
-	if ((read = hfs_do_read(inode, HFS_I(inode)->fork, pos,
-				buf, left, filp->f_reada != 0)) > 0) {
+	if ((read = hfs_do_read(inode, HFS_I(inode)->fork, pos, buf, left)) > 0) {
 	        *ppos += read;
 		filp->f_reada = 1;
 	}
@@ -288,7 +287,7 @@
  * It has been changed to take into account that HFS files have no holes.
  */
 hfs_s32 hfs_do_read(struct inode *inode, struct hfs_fork * fork, hfs_u32 pos,
-		    char * buf, hfs_u32 count, int reada)
+		    char * buf, hfs_u32 count)
 {
 	kdev_t dev = inode->i_dev;
 	hfs_s32 size, chars, offset, block, blocks, read = 0;
@@ -309,14 +308,6 @@
 	blocks = (count+offset+HFS_SECTOR_SIZE-1) >> HFS_SECTOR_SIZE_BITS;
 
 	bhb = bhe = buflist;
-	if (reada) {
-		if (blocks < read_ahead[major(dev)] / (HFS_SECTOR_SIZE>>9)) {
-			blocks = read_ahead[major(dev)] / (HFS_SECTOR_SIZE>>9);
-		}
-		if (block + blocks > size) {
-			blocks = size - block;
-		}
-	}
 
 	/* We do this in a two stage process.  We first try and
 	   request as many blocks as we can, then we wait for the
diff -ur linux-2.5.4/include/linux/blkdev.h linux/include/linux/blkdev.h
--- linux-2.5.4/include/linux/blkdev.h	Mon Feb 11 02:50:12 2002
+++ linux/include/linux/blkdev.h	Tue Feb 12 15:52:45 2002
@@ -314,11 +314,8 @@
 extern void generic_unplug_device(void *);
 
 extern int * blk_size[MAX_BLKDEV];
-
 extern int * blksize_size[MAX_BLKDEV];
 
-extern int * max_readahead[MAX_BLKDEV];
-
 #define MAX_PHYS_SEGMENTS 128
 #define MAX_HW_SEGMENTS 128
 #define MAX_SECTORS 255
@@ -340,8 +337,6 @@
 	blk_size_in_bytes[major] = NULL;
 #endif
 	blksize_size[major] = NULL;
-	max_readahead[major] = NULL;
-	read_ahead[major] = 0;
 }
 
 extern inline int get_hardsect_size(kdev_t dev)
diff -ur linux-2.5.4/include/linux/fs.h linux/include/linux/fs.h
--- linux-2.5.4/include/linux/fs.h	Mon Feb 11 02:50:12 2002
+++ linux/include/linux/fs.h	Tue Feb 12 15:52:45 2002
@@ -173,10 +173,12 @@
 #define BLKRRPART  _IO(0x12,95)	/* re-read partition table */
 #define BLKGETSIZE _IO(0x12,96)	/* return device size /512 (long *arg) */
 #define BLKFLSBUF  _IO(0x12,97)	/* flush buffer cache */
-#define BLKRASET   _IO(0x12,98)	/* Set read ahead for block device */
+#if 0				/* Obsolete, these don't do anything. */
+#define BLKRASET   _IO(0x12,98)	/* set read ahead for block device */
 #define BLKRAGET   _IO(0x12,99)	/* get current read ahead setting */
 #define BLKFRASET  _IO(0x12,100)/* set filesystem (mm/filemap.c) read-ahead */
 #define BLKFRAGET  _IO(0x12,101)/* get filesystem (mm/filemap.c) read-ahead */
+#endif
 #define BLKSECTSET _IO(0x12,102)/* set max sectors per request (ll_rw_blk.c) */
 #define BLKSECTGET _IO(0x12,103)/* get max sectors per request (ll_rw_blk.c) */
 #define BLKSSZGET  _IO(0x12,104)/* get block device sector size */
@@ -1490,8 +1492,6 @@
 
 extern ssize_t char_read(struct file *, char *, size_t, loff_t *);
 extern ssize_t block_read(struct file *, char *, size_t, loff_t *);
-extern int read_ahead[];
-
 extern ssize_t char_write(struct file *, const char *, size_t, loff_t *);
 extern ssize_t block_write(struct file *, const char *, size_t, loff_t *);
 
diff -ur linux-2.5.4/include/linux/lvm.h linux/include/linux/lvm.h
--- linux-2.5.4/include/linux/lvm.h	Mon Feb 11 02:50:08 2002
+++ linux/include/linux/lvm.h	Tue Feb 12 15:52:45 2002
@@ -498,7 +498,6 @@
 	uint lv_badblock;	/* for future use */
 	uint lv_allocation;
 	uint lv_io_timeout;	/* for future use */
-	uint lv_read_ahead;
 
 	/* delta to version 1 starts here */
        struct lv_v5 *lv_snapshot_org;
diff -ur linux-2.5.4/kernel/ksyms.c linux/kernel/ksyms.c
--- linux-2.5.4/kernel/ksyms.c	Mon Feb 11 02:50:07 2002
+++ linux/kernel/ksyms.c	Tue Feb 12 15:52:45 2002
@@ -321,7 +321,6 @@
 EXPORT_SYMBOL(tq_disk);
 EXPORT_SYMBOL(init_buffer);
 EXPORT_SYMBOL(refile_buffer);
-EXPORT_SYMBOL(max_readahead);
 EXPORT_SYMBOL(wipe_partitions);
 
 /* tty routines */
@@ -521,7 +520,6 @@
 EXPORT_SYMBOL(clear_inode);
 EXPORT_SYMBOL(___strtok);
 EXPORT_SYMBOL(init_special_inode);
-EXPORT_SYMBOL(read_ahead);
 EXPORT_SYMBOL(__get_hash_table);
 EXPORT_SYMBOL(new_inode);
 EXPORT_SYMBOL(insert_inode_hash);
diff -ur linux-2.5.4/mm/filemap.c linux/mm/filemap.c
--- linux-2.5.4/mm/filemap.c	Mon Feb 11 02:50:14 2002
+++ linux/mm/filemap.c	Tue Feb 12 15:52:45 2002
@@ -1131,13 +1131,6 @@
  *   64k if defined (4K page size assumed).
  */
 
-static inline int get_max_readahead(struct inode * inode)
-{
-	if (kdev_none(inode->i_dev) || !max_readahead[major(inode->i_dev)])
-		return MAX_READAHEAD;
-	return max_readahead[major(inode->i_dev)][minor(inode->i_dev)];
-}
-
 static void generic_file_readahead(int reada_ok,
 	struct file * filp, struct inode * inode,
 	struct page * page)
@@ -1146,7 +1139,6 @@
 	unsigned long index = page->index;
 	unsigned long max_ahead, ahead;
 	unsigned long raend;
-	int max_readahead = get_max_readahead(inode);
 
 	end_index = inode->i_size >> PAGE_CACHE_SHIFT;
 
@@ -1231,8 +1223,8 @@
 
 		filp->f_ramax += filp->f_ramax;
 
-		if (filp->f_ramax > max_readahead)
-			filp->f_ramax = max_readahead;
+		if (filp->f_ramax > MAX_READAHEAD)
+			filp->f_ramax = MAX_READAHEAD;
 
 #ifdef PROFILE_READAHEAD
 		profile_readahead((reada_ok == 2), filp);
@@ -1278,7 +1270,6 @@
 	struct page *cached_page;
 	int reada_ok;
 	int error;
-	int max_readahead = get_max_readahead(inode);
 
 	cached_page = NULL;
 	index = *ppos >> PAGE_CACHE_SHIFT;
@@ -1318,9 +1309,9 @@
 			filp->f_ramax = needed;
 
 		if (reada_ok && filp->f_ramax < MIN_READAHEAD)
-				filp->f_ramax = MIN_READAHEAD;
-		if (filp->f_ramax > max_readahead)
-			filp->f_ramax = max_readahead;
+			filp->f_ramax = MIN_READAHEAD;
+		if (filp->f_ramax > MAX_READAHEAD)
+			filp->f_ramax = MAX_READAHEAD;
 	}
 
 	for (;;) {
@@ -1808,7 +1799,7 @@
 {
 	unsigned long ra_window;
 
-	ra_window = get_max_readahead(vma->vm_file->f_dentry->d_inode);
+	ra_window = MAX_READAHEAD;
 	ra_window = CLUSTER_OFFSET(ra_window + CLUSTER_PAGES - 1);
 
 	/* vm_raend is zero if we haven't read ahead in this area yet.  */

--------------020601000809040007080503--

