Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129110AbRBNA46>; Tue, 13 Feb 2001 19:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129138AbRBNA4r>; Tue, 13 Feb 2001 19:56:47 -0500
Received: from tux.mkp.net ([130.225.60.11]:49934 "EHLO tux.mkp.net")
	by vger.kernel.org with ESMTP id <S129110AbRBNA4g>;
	Tue, 13 Feb 2001 19:56:36 -0500
To: Andries.Brouwer@cwi.nl
Cc: michael_e_brown@dell.com, Matt_Domsch@exchange.dell.com,
        freitag@alancoxonachip.com, linux-kernel@vger.kernel.org
Subject: Re: block ioctl to read/write last sector
In-Reply-To: <UTC200102132254.XAA98078.aeb@vlet.cwi.nl>
From: "Martin K. Petersen" <mkp@mkp.net>
Organization: mkp.net
Date: 13 Feb 2001 14:24:50 -0500
In-Reply-To: <UTC200102132254.XAA98078.aeb@vlet.cwi.nl>
Message-ID: <yq1pugmwflp.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Canyonlands)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

>>>>> "Andries" == Andries Brouwer <Andries.Brouwer@cwi.nl> writes:

Andries> Anyway, an ioctl just to read the last sector is too silly.
Andries> An ioctl to change the blocksize is more reasonable.  

I actually sent you a patch implementing this some time ago, remember?
We need it for XFS...

Patch against 2.4.2-pre3 follows.

-- 
Martin K. Petersen, Principal Linux Consultant, Linuxcare, Inc.
mkp@linuxcare.com, http://www.linuxcare.com/
SGI XFS for Linux Developer, http://oss.sgi.com/projects/xfs/


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=blksetsize-2.4.2pre3.patch

diff -urN linux/arch/mips64/kernel/ioctl32.c linux-blksetsize/arch/mips64/kernel/ioctl32.c
--- linux/arch/mips64/kernel/ioctl32.c	Wed Nov 29 00:42:04 2000
+++ linux-blksetsize/arch/mips64/kernel/ioctl32.c	Tue Feb 13 14:15:20 2001
@@ -712,6 +712,7 @@
 	IOCTL32_HANDLER(BLKPG, blkpg_ioctl_trans),
 	IOCTL32_DEFAULT(BLKELVGET),
 	IOCTL32_DEFAULT(BLKELVSET),
+	IOCTL32_DEFAULT(BLKSETSIZE),
 
 	IOCTL32_DEFAULT(MTIOCTOP),			/* mtio.h ioctls  */
 	IOCTL32_HANDLER(MTIOCGET32, mt_ioctl_trans),
diff -urN linux/arch/sparc64/kernel/ioctl32.c linux-blksetsize/arch/sparc64/kernel/ioctl32.c
--- linux/arch/sparc64/kernel/ioctl32.c	Tue Feb 13 14:12:17 2001
+++ linux-blksetsize/arch/sparc64/kernel/ioctl32.c	Tue Feb 13 14:15:20 2001
@@ -3107,6 +3107,7 @@
 COMPATIBLE_IOCTL(BLKFRASET)
 COMPATIBLE_IOCTL(BLKSECTSET)
 COMPATIBLE_IOCTL(BLKSSZGET)
+COMPATIBLE_IOCTL(BLKSETSIZE)
 
 /* RAID */
 COMPATIBLE_IOCTL(RAID_VERSION)
diff -urN linux/drivers/block/blkpg.c linux-blksetsize/drivers/block/blkpg.c
--- linux/drivers/block/blkpg.c	Fri Oct 27 02:35:47 2000
+++ linux-blksetsize/drivers/block/blkpg.c	Tue Feb 13 14:15:20 2001
@@ -208,6 +208,7 @@
 int blk_ioctl(kdev_t dev, unsigned int cmd, unsigned long arg)
 {
 	int intval;
+	long longval;
 
 	switch (cmd) {
 		case BLKROSET:
@@ -258,6 +259,22 @@
 				longval = g->part[MINOR(dev)].nr_sects;
 			return put_user(longval, (long *) arg);
 #endif
+		case BLKSETSIZE:
+			/* Can be used to set block size from userland. */
+			if(!capable(CAP_SYS_ADMIN))
+				return -EACCES;
+
+			if(!dev || !arg)
+				return -EINVAL;
+
+			if (get_user(longval, (int *)(arg)))
+				return -EFAULT;
+
+			if (longval > PAGE_SIZE || longval < 512 || (longval & (longval-1)))
+				return -EINVAL;
+
+			set_blocksize(dev, longval);
+			return 0;
 #if 0
 		case BLKRRPART: /* Re-read partition tables */
 			if (!capable(CAP_SYS_ADMIN)) 
diff -urN linux/drivers/ide/ide.c linux-blksetsize/drivers/ide/ide.c
--- linux/drivers/ide/ide.c	Tue Feb 13 14:12:23 2001
+++ linux-blksetsize/drivers/ide/ide.c	Tue Feb 13 14:15:20 2001
@@ -2672,6 +2672,7 @@
 		case BLKPG:
 		case BLKELVGET:
 		case BLKELVSET:
+		case BLKSETSIZE:
 			return blk_ioctl(inode->i_rdev, cmd, arg);
 
 		default:
diff -urN linux/drivers/md/lvm.c linux-blksetsize/drivers/md/lvm.c
--- linux/drivers/md/lvm.c	Sun Jan 28 19:11:20 2001
+++ linux-blksetsize/drivers/md/lvm.c	Tue Feb 13 14:15:20 2001
@@ -910,6 +910,8 @@
 			return -EFAULT;
 		break;
 
+	case BLKSETSIZE:
+		return blk_ioctl(inode->i_rdev, command, a);
 
 	case BLKFLSBUF:
 		/* flush buffer cache */
diff -urN linux/drivers/md/md.c linux-blksetsize/drivers/md/md.c
--- linux/drivers/md/md.c	Tue Feb 13 14:12:24 2001
+++ linux-blksetsize/drivers/md/md.c	Tue Feb 13 14:15:20 2001
@@ -2511,6 +2511,9 @@
 						(long *) arg);
 			goto done;
 
+		case BLKSETSIZE:
+			return blk_ioctl(dev, cmd, (long *) arg);
+
 		case BLKFLSBUF:
 			fsync_dev(dev);
 			invalidate_buffers(dev);
diff -urN linux/drivers/scsi/sd.c linux-blksetsize/drivers/scsi/sd.c
--- linux/drivers/scsi/sd.c	Tue Feb 13 14:12:32 2001
+++ linux-blksetsize/drivers/scsi/sd.c	Tue Feb 13 14:15:21 2001
@@ -234,6 +234,7 @@
 		case BLKPG:
                 case BLKELVGET:
                 case BLKELVSET:
+                case BLKSETSIZE:
 			return blk_ioctl(inode->i_rdev, cmd, arg);
 
 		case BLKRRPART: /* Re-read partition tables */
diff -urN linux/include/linux/fs.h linux-blksetsize/include/linux/fs.h
--- linux/include/linux/fs.h	Tue Feb 13 14:12:42 2001
+++ linux-blksetsize/include/linux/fs.h	Tue Feb 13 14:15:21 2001
@@ -181,6 +181,7 @@
 #define BLKSECTSET _IO(0x12,102)/* set max sectors per request (ll_rw_blk.c) */
 #define BLKSECTGET _IO(0x12,103)/* get max sectors per request (ll_rw_blk.c) */
 #define BLKSSZGET  _IO(0x12,104)/* get block device sector size */
+#define BLKSETSIZE _IO(0x12,108)/* set device block size */
 #if 0
 #define BLKPG      _IO(0x12,105)/* See blkpg.h */
 #define BLKELVGET  _IOR(0x12,106,sizeof(blkelv_ioctl_arg_t))/* elevator get */

--=-=-=--
