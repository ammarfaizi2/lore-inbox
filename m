Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269795AbRIAAD0>; Fri, 31 Aug 2001 20:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269829AbRIAADR>; Fri, 31 Aug 2001 20:03:17 -0400
Received: from hera.cwi.nl ([192.16.191.8]:19626 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S269795AbRIAADM>;
	Fri, 31 Aug 2001 20:03:12 -0400
From: Andries.Brouwer@cwi.nl
Date: Sat, 1 Sep 2001 00:02:55 GMT
Message-Id: <200109010002.AAA15778@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com
Subject: [PATCH] setbsz ioctl - was: Re: blkgetsize64
Cc: bcrl@redhat.com, linux-kernel@vger.kernel.org, michael_e_brown@dell.com,
        tytso@mit.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	From alan@lxorguk.ukuu.org.uk Fri Aug 31 03:20:18 2001

	> one needs (1) a test in ll_rw_blk.c that uses not the size in 1024-byte blocks
	> but in 512-byte sectors, and (2) a set-blocksize ioctl.
	> And this latter is needed for other reasons as well.
	> 
	> Maybe I should resubmit some such patch fragments?

	If you can doit cleanly - yes

Have you ever seen otherwise from me?
Below part (2), the set-blocksize ioctl.
Since numbers 108,109 have been used for at least three different purposes,
and also 110,111 already occurred, I made them 112,113.

Andries


diff -u --recursive --new-file ../linux-2.4.10-pre2/linux/arch/mips64/kernel/ioctl32.c ./linux/arch/mips64/kernel/ioctl32.c
--- ../linux-2.4.10-pre2/linux/arch/mips64/kernel/ioctl32.c	Wed Jul  4 20:50:39 2001
+++ ./linux/arch/mips64/kernel/ioctl32.c	Sat Sep  1 00:22:54 2001
@@ -770,6 +770,8 @@
 	IOCTL32_HANDLER(BLKPG, blkpg_ioctl_trans),
 	IOCTL32_DEFAULT(BLKELVGET),
 	IOCTL32_DEFAULT(BLKELVSET),
+	IOCTL32_DEFAULT(BLKBSZGET),
+	IOCTL32_DEFAULT(BLKBSZSET),
 
 #ifdef CONFIG_MD
 	/* status */
diff -u --recursive --new-file ../linux-2.4.10-pre2/linux/arch/sparc64/kernel/ioctl32.c ./linux/arch/sparc64/kernel/ioctl32.c
--- ../linux-2.4.10-pre2/linux/arch/sparc64/kernel/ioctl32.c	Tue Aug  7 17:30:50 2001
+++ ./linux/arch/sparc64/kernel/ioctl32.c	Sat Sep  1 00:22:54 2001
@@ -3691,6 +3691,8 @@
 COMPATIBLE_IOCTL(BLKFRASET)
 COMPATIBLE_IOCTL(BLKSECTSET)
 COMPATIBLE_IOCTL(BLKSSZGET)
+COMPATIBLE_IOCTL(BLKBSZGET)
+COMPATIBLE_IOCTL(BLKBSZSET)
 
 /* RAID */
 COMPATIBLE_IOCTL(RAID_VERSION)
diff -u --recursive --new-file ../linux-2.4.10-pre2/linux/drivers/block/DAC960.c ./linux/drivers/block/DAC960.c
--- ../linux-2.4.10-pre2/linux/drivers/block/DAC960.c	Mon Aug  6 19:34:38 2001
+++ ./linux/drivers/block/DAC960.c	Sat Sep  1 00:22:54 2001
@@ -31,6 +31,7 @@
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/hdreg.h>
+#include <linux/blkpg.h>
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <linux/locks.h>
@@ -5094,21 +5095,12 @@
 						 .nr_sects,
 		      (long *) Argument);
     case BLKRAGET:
-      /* Get Read-Ahead. */
-      if ((long *) Argument == NULL) return -EINVAL;
-      return put_user(read_ahead[MAJOR(Inode->i_rdev)], (long *) Argument);
     case BLKRASET:
-      /* Set Read-Ahead. */
-      if (!capable(CAP_SYS_ADMIN)) return -EACCES;
-      if (Argument > 256) return -EINVAL;
-      read_ahead[MAJOR(Inode->i_rdev)] = Argument;
-      return 0;
     case BLKFLSBUF:
-      /* Flush Buffers. */
-      if (!capable(CAP_SYS_ADMIN)) return -EACCES;
-      fsync_dev(Inode->i_rdev);
-      invalidate_buffers(Inode->i_rdev);
-      return 0;
+    case BLKBSZGET:
+    case BLKBSZSET:
+      return blk_ioctl (Inode->i_rdev, Request, Argument);
+
     case BLKRRPART:
       /* Re-Read Partition Table. */
       if (!capable(CAP_SYS_ADMIN)) return -EACCES;
diff -u --recursive --new-file ../linux-2.4.10-pre2/linux/drivers/block/blkpg.c ./linux/drivers/block/blkpg.c
--- ../linux-2.4.10-pre2/linux/drivers/block/blkpg.c	Sun May 20 20:34:05 2001
+++ ./linux/drivers/block/blkpg.c	Sat Sep  1 00:22:54 2001
@@ -274,6 +274,29 @@
 			return blkelvset_ioctl(&blk_get_queue(dev)->elevator,
 					       (blkelv_ioctl_arg_t *) arg);
 
+		case BLKBSZGET:
+			/* get the logical block size (cf. BLKSSZGET) */
+			intval = BLOCK_SIZE;
+			if (blksize_size[MAJOR(dev)])
+				intval = blksize_size[MAJOR(dev)][MINOR(dev)];
+			return put_user (intval, (int *) arg);
+
+		case BLKBSZSET:
+			/* set the logical block size */
+			if (!capable (CAP_SYS_ADMIN))
+				return -EACCES;
+			if (!dev || !arg)
+				return -EINVAL;
+			if (get_user (intval, (int *) arg))
+				return -EFAULT;
+			if (intval > PAGE_SIZE || intval < 512 ||
+			    (intval & (intval - 1)))
+				return -EINVAL;
+			if (is_mounted (dev) || is_swap_partition (dev))
+				return -EBUSY;
+			set_blocksize (dev, intval);
+			return 0;
+
 		default:
 			return -EINVAL;
 	}
diff -u --recursive --new-file ../linux-2.4.10-pre2/linux/drivers/block/cciss.c ./linux/drivers/block/cciss.c
--- ../linux-2.4.10-pre2/linux/drivers/block/cciss.c	Mon Jul  2 22:56:40 2001
+++ ./linux/drivers/block/cciss.c	Sat Sep  1 00:22:54 2001
@@ -406,6 +406,8 @@
 	case BLKRRPART:
 		return revalidate_logvol(inode->i_rdev, 1);
 	case BLKFLSBUF:
+	case BLKBSZSET:
+	case BLKBSZGET:
 	case BLKROSET:
 	case BLKROGET:
 	case BLKRASET:
diff -u --recursive --new-file ../linux-2.4.10-pre2/linux/drivers/block/cpqarray.c ./linux/drivers/block/cpqarray.c
--- ../linux-2.4.10-pre2/linux/drivers/block/cpqarray.c	Wed Jul 25 23:12:01 2001
+++ ./linux/drivers/block/cpqarray.c	Sat Sep  1 00:22:54 2001
@@ -1266,6 +1266,8 @@
 	}	
 
 	case BLKFLSBUF:
+	case BLKBSZSET:
+	case BLKBSZGET:
 	case BLKROSET:
 	case BLKROGET:
 	case BLKRASET:
diff -u --recursive --new-file ../linux-2.4.10-pre2/linux/drivers/block/loop.c ./linux/drivers/block/loop.c
--- ../linux-2.4.10-pre2/linux/drivers/block/loop.c	Sat Jun 30 01:16:56 2001
+++ ./linux/drivers/block/loop.c	Sat Sep  1 01:33:36 2001
@@ -62,6 +62,7 @@
 #include <linux/major.h>
 #include <linux/wait.h>
 #include <linux/blk.h>
+#include <linux/blkpg.h>
 #include <linux/init.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/smp_lock.h>
@@ -853,6 +854,10 @@
 			break;
 		}
 		err = put_user(loop_sizes[lo->lo_number] << 1, (long *) arg);
+		break;
+	case BLKBSZGET:
+	case BLKBSZSET:
+		err = blk_ioctl(inode->i_rdev, cmd, arg);
 		break;
 	default:
 		err = lo->ioctl ? lo->ioctl(lo, cmd, arg) : -EINVAL;
diff -u --recursive --new-file ../linux-2.4.10-pre2/linux/drivers/block/ps2esdi.c ./linux/drivers/block/ps2esdi.c
--- ../linux-2.4.10-pre2/linux/drivers/block/ps2esdi.c	Wed Jul 11 01:18:51 2001
+++ ./linux/drivers/block/ps2esdi.c	Sat Sep  1 00:22:54 2001
@@ -1127,6 +1127,8 @@
 		case BLKRASET:
 		case BLKRAGET:
 		case BLKFLSBUF:
+		case BLKBSZGET:
+		case BLKBSZSET:
 		case BLKPG:
 			return blk_ioctl(inode->i_rdev, cmd, arg);
 		}
diff -u --recursive --new-file ../linux-2.4.10-pre2/linux/drivers/ide/ide.c ./linux/drivers/ide/ide.c
--- ../linux-2.4.10-pre2/linux/drivers/ide/ide.c	Sat Sep  1 00:54:34 2001
+++ ./linux/drivers/ide/ide.c	Sat Sep  1 00:22:54 2001
@@ -2788,6 +2788,8 @@
 		case BLKPG:
 		case BLKELVGET:
 		case BLKELVSET:
+		case BLKBSZGET:
+		case BLKBSZSET:
 			return blk_ioctl(inode->i_rdev, cmd, arg);
 
 		case HDIO_GET_BUSSTATE:
diff -u --recursive --new-file ../linux-2.4.10-pre2/linux/drivers/md/md.c ./linux/drivers/md/md.c
--- ../linux-2.4.10-pre2/linux/drivers/md/md.c	Sat Sep  1 00:54:40 2001
+++ ./linux/drivers/md/md.c	Sat Sep  1 00:22:54 2001
@@ -921,17 +921,19 @@
 	dev = rdev->dev;
 	sb_offset = calc_dev_sboffset(dev, rdev->mddev, 1);
 	if (rdev->sb_offset != sb_offset) {
-		printk("%s's sb offset has changed from %ld to %ld, skipping\n", partition_name(dev), rdev->sb_offset, sb_offset);
+		printk("%s's sb offset has changed from %ld to %ld, skipping\n",
+		       partition_name(dev), rdev->sb_offset, sb_offset);
 		goto skip;
 	}
 	/*
 	 * If the disk went offline meanwhile and it's just a spare, then
-	 * it's size has changed to zero silently, and the MD code does
+	 * its size has changed to zero silently, and the MD code does
 	 * not yet know that it's faulty.
 	 */
 	size = calc_dev_size(dev, rdev->mddev, 1);
 	if (size != rdev->size) {
-		printk("%s's size has changed from %ld to %ld since import, skipping\n", partition_name(dev), rdev->size, size);
+		printk("%s's size has changed from %ld to %ld since import, skipping\n",
+		       partition_name(dev), rdev->size, size);
 		goto skip;
 	}
 
@@ -2488,27 +2490,14 @@
 						(long *) arg);
 			goto done;
 
-		case BLKFLSBUF:
-			fsync_dev(dev);
-			invalidate_buffers(dev);
-			goto done;
-
+		case BLKRAGET:
 		case BLKRASET:
-			if (arg > 0xff) {
-				err = -EINVAL;
-				goto abort;
-			}
-			read_ahead[MAJOR(dev)] = arg;
-			goto done;
+		case BLKFLSBUF:
+		case BLKBSZGET:
+		case BLKBSZSET:
+			err = blk_ioctl (dev, cmd, arg);
+			goto abort;
 
-		case BLKRAGET:
-			if (!arg) {
-				err = -EINVAL;
-				goto abort;
-			}
-			err = md_put_user (read_ahead[
-				MAJOR(dev)], (long *) arg);
-			goto done;
 		default:;
 	}
 
diff -u --recursive --new-file ../linux-2.4.10-pre2/linux/drivers/scsi/sd.c ./linux/drivers/scsi/sd.c
--- ../linux-2.4.10-pre2/linux/drivers/scsi/sd.c	Sun Aug  5 22:12:41 2001
+++ ./linux/drivers/scsi/sd.c	Sat Sep  1 00:22:54 2001
@@ -238,8 +238,10 @@
 		case BLKFLSBUF:
 		case BLKSSZGET:
 		case BLKPG:
-                case BLKELVGET:
-                case BLKELVSET:
+		case BLKELVGET:
+		case BLKELVSET:
+		case BLKBSZGET:
+		case BLKBSZSET:
 			return blk_ioctl(inode->i_rdev, cmd, arg);
 
 		case BLKRRPART: /* Re-read partition tables */
diff -u --recursive --new-file ../linux-2.4.10-pre2/linux/include/linux/fs.h ./linux/include/linux/fs.h
--- ../linux-2.4.10-pre2/linux/include/linux/fs.h	Sat Sep  1 00:55:02 2001
+++ ./linux/include/linux/fs.h	Sat Sep  1 01:03:17 2001
@@ -182,7 +182,9 @@
 /* This was here just to show that the number is taken -
    probably all these _IO(0x12,*) ioctls should be moved to blkpg.h. */
 #endif
-
+/* A jump here: 108-111 have been used for various private purposes. */
+#define BLKBSZGET  _IOR(0x12,112,sizeof(int))
+#define BLKBSZSET  _IOW(0x12,113,sizeof(int))
 
 #define BMAP_IOCTL 1		/* obsolete - kept for compatibility */
 #define FIBMAP	   _IO(0x00,1)	/* bmap access */
