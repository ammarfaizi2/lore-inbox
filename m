Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269651AbRIDW1O>; Tue, 4 Sep 2001 18:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269693AbRIDW1G>; Tue, 4 Sep 2001 18:27:06 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:54658 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S269651AbRIDW0s>; Tue, 4 Sep 2001 18:26:48 -0400
Date: Tue, 4 Sep 2001 18:27:06 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@toomuch.toronto.redhat.com>
To: <Andries.Brouwer@cwi.nl>
cc: <linux-kernel@vger.kernel.org>, <torvalds@transmeta.com>
Subject: Re: [resend PATCH] reserve BLKGETSIZE64 ioctl
In-Reply-To: <200109042143.VAA57901@vlet.cwi.nl>
Message-ID: <Pine.LNX.4.33.0109041819050.3895-100000@toomuch.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Sep 2001 Andries.Brouwer@cwi.nl wrote:

> Roughly speaking, yes.
>
> (But why do you insist on using 110?

That was what I'd changed to after the 108-109 conflict.

> I wrote "A jump here: 108-111 have been used" because that is
> what I recall: three groups using 108-109 and one shifting to
> 110-111. I have no details, so may misremember, but still..)

In case it wasn't me, here it is again using 114.  I hope I never have to
diff this patch again.

		-ben

diff -urN v2.4.10-pre4/drivers/acorn/block/mfmhd.c work-v2.4.10-pre4/drivers/acorn/block/mfmhd.c
--- v2.4.10-pre4/drivers/acorn/block/mfmhd.c	Thu Aug 16 16:58:44 2001
+++ work-v2.4.10-pre4/drivers/acorn/block/mfmhd.c	Tue Sep  4 18:17:42 2001
@@ -1210,6 +1210,8 @@

 	case BLKGETSIZE:
 		return put_user (mfm[minor].nr_sects, (long *)arg);
+	case BLKGETSIZE64:
+		return put_user ((u64)mfm[minor].nr_sects << 9, (u64 *)arg);

 	case BLKFRASET:
 		if (!capable(CAP_SYS_ADMIN))
diff -urN v2.4.10-pre4/drivers/block/DAC960.c work-v2.4.10-pre4/drivers/block/DAC960.c
--- v2.4.10-pre4/drivers/block/DAC960.c	Mon Sep  3 11:04:39 2001
+++ work-v2.4.10-pre4/drivers/block/DAC960.c	Tue Sep  4 18:17:42 2001
@@ -5090,10 +5090,12 @@
 			   sizeof(DiskGeometry_T)) ? -EFAULT : 0);
     case BLKGETSIZE:
       /* Get Device Size. */
-      if ((long *) Argument == NULL) return -EINVAL;
       return put_user(Controller->GenericDiskInfo.part[MINOR(Inode->i_rdev)]
 						 .nr_sects,
 		      (long *) Argument);
+    case BLKGETSIZE64:
+      return put_user((u64)Controller->GenericDiskInfo.part[MINOR(Inode->i_rdev)].nr_sects << 9,
+		      (u64 *) Argument);
     case BLKRAGET:
     case BLKRASET:
     case BLKFLSBUF:
diff -urN v2.4.10-pre4/drivers/block/acsi.c work-v2.4.10-pre4/drivers/block/acsi.c
--- v2.4.10-pre4/drivers/block/acsi.c	Thu Aug 16 16:58:44 2001
+++ work-v2.4.10-pre4/drivers/block/acsi.c	Tue Sep  4 18:17:42 2001
@@ -1138,6 +1138,10 @@
 		return put_user(acsi_part[MINOR(inode->i_rdev)].nr_sects,
 				(long *) arg);

+	  case BLKGETSIZE64:   /* Return device size */
+		return put_user((u64)acsi_part[MINOR(inode->i_rdev)].nr_sects << 9,
+				(u64 *) arg);
+
 	  case BLKROSET:
 	  case BLKROGET:
 	  case BLKFLSBUF:
diff -urN v2.4.10-pre4/drivers/block/amiflop.c work-v2.4.10-pre4/drivers/block/amiflop.c
--- v2.4.10-pre4/drivers/block/amiflop.c	Fri May 25 22:48:09 2001
+++ work-v2.4.10-pre4/drivers/block/amiflop.c	Tue Sep  4 18:17:42 2001
@@ -1556,6 +1556,9 @@
 	case BLKGETSIZE:
 		return put_user(unit[drive].blocks,(long *)param);
 		break;
+	case BLKGETSIZE64:
+		return put_user((u64)unit[drive].blocks << 9, (u64 *)param);
+		break;
 	case FDSETPRM:
 	case FDDEFPRM:
 		return -EINVAL;
diff -urN v2.4.10-pre4/drivers/block/blkpg.c work-v2.4.10-pre4/drivers/block/blkpg.c
--- v2.4.10-pre4/drivers/block/blkpg.c	Mon Sep  3 11:04:39 2001
+++ work-v2.4.10-pre4/drivers/block/blkpg.c	Tue Sep  4 18:17:42 2001
@@ -250,6 +250,7 @@
 		case BLKGETSIZE:
 			/* Today get_gendisk() requires a linear scan;
 			   add this when dev has pointer type. */
+			/* add BLKGETSIZE64 too */
 			g = get_gendisk(dev);
 			if (!g)
 				longval = 0;
diff -urN v2.4.10-pre4/drivers/block/cciss.c work-v2.4.10-pre4/drivers/block/cciss.c
--- v2.4.10-pre4/drivers/block/cciss.c	Mon Sep  3 11:04:39 2001
+++ work-v2.4.10-pre4/drivers/block/cciss.c	Tue Sep  4 18:17:42 2001
@@ -400,8 +400,10 @@
 		put_user(hba[ctlr]->hd[MINOR(inode->i_rdev)].start_sect, &geo->start);
 		return 0;
 	case BLKGETSIZE:
-		if (!arg) return -EINVAL;
 		put_user(hba[ctlr]->hd[MINOR(inode->i_rdev)].nr_sects, (long*)arg);
+		return 0;
+	case BLKGETSIZE64:
+		put_user((u64)hba[ctlr]->hd[MINOR(inode->i_rdev)].nr_sects << 9, (u64*)arg);
 		return 0;
 	case BLKRRPART:
 		return revalidate_logvol(inode->i_rdev, 1);
diff -urN v2.4.10-pre4/drivers/block/cpqarray.c work-v2.4.10-pre4/drivers/block/cpqarray.c
--- v2.4.10-pre4/drivers/block/cpqarray.c	Mon Sep  3 11:04:39 2001
+++ work-v2.4.10-pre4/drivers/block/cpqarray.c	Tue Sep  4 18:17:42 2001
@@ -1227,9 +1227,9 @@
 	case IDAGETDRVINFO:
 		return copy_to_user(&io->c.drv,&hba[ctlr]->drv[dsk],sizeof(drv_info_t));
 	case BLKGETSIZE:
-		if (!arg) return -EINVAL;
-		put_user(ida[(ctlr<<CTLR_SHIFT)+MINOR(inode->i_rdev)].nr_sects, (long*)arg);
-		return 0;
+		return put_user(ida[(ctlr<<CTLR_SHIFT)+MINOR(inode->i_rdev)].nr_sects, (long*)arg);
+	case BLKGETSIZE64:
+		return put_user((u64)(ida[(ctlr<<CTLR_SHIFT)+MINOR(inode->i_rdev)].nr_sects) << 9, (u64*)arg);
 	case BLKRRPART:
 		return revalidate_logvol(inode->i_rdev, 1);
 	case IDAPASSTHRU:
diff -urN v2.4.10-pre4/drivers/block/floppy.c work-v2.4.10-pre4/drivers/block/floppy.c
--- v2.4.10-pre4/drivers/block/floppy.c	Mon Aug 13 15:12:07 2001
+++ work-v2.4.10-pre4/drivers/block/floppy.c	Tue Sep  4 18:17:42 2001
@@ -3492,6 +3492,10 @@
 		case BLKGETSIZE:
 			ECALL(get_floppy_geometry(drive, type, &g));
 			return put_user(g->size, (long *) param);
+
+		case BLKGETSIZE64:
+			ECALL(get_floppy_geometry(drive, type, &g));
+			return put_user((u64)g->size << 9, (u64 *) param);
 		/* BLKRRPART is not defined as floppies don't have
 		 * partition tables */
 	}
diff -urN v2.4.10-pre4/drivers/block/loop.c work-v2.4.10-pre4/drivers/block/loop.c
--- v2.4.10-pre4/drivers/block/loop.c	Mon Sep  3 11:04:39 2001
+++ work-v2.4.10-pre4/drivers/block/loop.c	Tue Sep  4 18:17:42 2001
@@ -849,11 +849,14 @@
 			err = -ENXIO;
 			break;
 		}
-		if (!arg) {
-			err = -EINVAL;
+		err = put_user(loop_sizes[lo->lo_number] << 1, (long *) arg);
+		break;
+	case BLKGETSIZE64:
+		if (lo->lo_state != Lo_bound) {
+			err = -ENXIO;
 			break;
 		}
-		err = put_user(loop_sizes[lo->lo_number] << 1, (long *) arg);
+		err = put_user((u64)loop_sizes[lo->lo_number] << 10, (u64*)arg);
 		break;
 	case BLKBSZGET:
 	case BLKBSZSET:
diff -urN v2.4.10-pre4/drivers/block/nbd.c work-v2.4.10-pre4/drivers/block/nbd.c
--- v2.4.10-pre4/drivers/block/nbd.c	Tue Jul  3 21:15:02 2001
+++ work-v2.4.10-pre4/drivers/block/nbd.c	Tue Sep  4 18:17:42 2001
@@ -446,6 +446,8 @@
 #endif
 	case BLKGETSIZE:
 		return put_user(nbd_bytesizes[dev] >> 9, (long *) arg);
+	case BLKGETSIZE64:
+		return put_user((u64)nbd_bytesizes[dev], (u64 *) arg);
 	}
 	return -EINVAL;
 }
diff -urN v2.4.10-pre4/drivers/block/paride/pd.c work-v2.4.10-pre4/drivers/block/paride/pd.c
--- v2.4.10-pre4/drivers/block/paride/pd.c	Fri May 25 22:48:09 2001
+++ work-v2.4.10-pre4/drivers/block/paride/pd.c	Tue Sep  4 18:17:42 2001
@@ -535,6 +535,8 @@
                 if (err) return (err);
                 put_user(pd_hd[dev].nr_sects,(long *) arg);
                 return (0);
+            case BLKGETSIZE64:
+                return put_user((u64)pd_hd[dev].nr_sects << 9, (u64 *)arg);
             case BLKRRPART:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EACCES;
diff -urN v2.4.10-pre4/drivers/block/paride/pf.c work-v2.4.10-pre4/drivers/block/paride/pf.c
--- v2.4.10-pre4/drivers/block/paride/pf.c	Mon Feb 26 10:20:05 2001
+++ work-v2.4.10-pre4/drivers/block/paride/pf.c	Tue Sep  4 18:17:42 2001
@@ -482,11 +482,9 @@
                 put_user(0,(long *)&geo->start);
                 return 0;
             case BLKGETSIZE:
-                if (!arg) return -EINVAL;
-                err = verify_area(VERIFY_WRITE,(long *) arg,sizeof(long));
-                if (err) return (err);
-                put_user(PF.capacity,(long *) arg);
-                return (0);
+                return put_user(PF.capacity,(long *) arg);
+            case BLKGETSIZE64:
+                return put_user((u64)PF.capacity << 9,(u64 *)arg);
 	    case BLKROSET:
 	    case BLKROGET:
 	    case BLKRASET:
diff -urN v2.4.10-pre4/drivers/block/ps2esdi.c work-v2.4.10-pre4/drivers/block/ps2esdi.c
--- v2.4.10-pre4/drivers/block/ps2esdi.c	Mon Sep  3 11:04:39 2001
+++ work-v2.4.10-pre4/drivers/block/ps2esdi.c	Tue Sep  4 18:17:42 2001
@@ -1117,6 +1117,9 @@
 			}
 			break;

+		case BLKGETSIZE64:
+			return put_user((u64)ps2esdi[MINOR(inode->i_rdev)].nr_sects << 9, (u64 *) arg);
+
 		case BLKRRPART:
                         if (!capable(CAP_SYS_ADMIN))
 				return -EACCES;
diff -urN v2.4.10-pre4/drivers/block/rd.c work-v2.4.10-pre4/drivers/block/rd.c
--- v2.4.10-pre4/drivers/block/rd.c	Sun Jul 22 19:17:15 2001
+++ work-v2.4.10-pre4/drivers/block/rd.c	Tue Sep  4 18:17:42 2001
@@ -269,6 +269,9 @@
 			if (!arg)  return -EINVAL;
 			return put_user(rd_kbsize[minor] << 1, (long *) arg);

+         	case BLKGETSIZE64:
+			return put_user((u64)rd_kbsize[minor] << 10, (u64*)arg);
+
 		case BLKROSET:
 		case BLKROGET:
 		case BLKSSZGET:
diff -urN v2.4.10-pre4/drivers/block/xd.c work-v2.4.10-pre4/drivers/block/xd.c
--- v2.4.10-pre4/drivers/block/xd.c	Fri May 25 22:48:09 2001
+++ work-v2.4.10-pre4/drivers/block/xd.c	Tue Sep  4 18:17:42 2001
@@ -339,6 +339,8 @@
 		case BLKGETSIZE:
 			if (!arg) return -EINVAL;
 			return put_user(xd_struct[MINOR(inode->i_rdev)].nr_sects,(long *) arg);
+		case BLKGETSIZE64:
+			return put_user((u64)xd_struct[MINOR(inode->i_rdev)].nr_sects << 9, (u64 *)arg);
 		case HDIO_SET_DMA:
 			if (!capable(CAP_SYS_ADMIN)) return -EACCES;
 			if (xdc_busy) return -EBUSY;
diff -urN v2.4.10-pre4/drivers/i2o/i2o_block.c work-v2.4.10-pre4/drivers/i2o/i2o_block.c
--- v2.4.10-pre4/drivers/i2o/i2o_block.c	Mon Sep  3 11:04:39 2001
+++ work-v2.4.10-pre4/drivers/i2o/i2o_block.c	Tue Sep  4 18:17:42 2001
@@ -1141,6 +1141,8 @@
 	switch (cmd) {
 		case BLKGETSIZE:
 			return put_user(i2ob[minor].nr_sects, (long *) arg);
+		case BLKGETSIZE64:
+			return put_user((u64)i2ob[minor].nr_sects << 9, (u64 *)arg);

 		case HDIO_GETGEO:
 		{
diff -urN v2.4.10-pre4/drivers/ide/hd.c work-v2.4.10-pre4/drivers/ide/hd.c
--- v2.4.10-pre4/drivers/ide/hd.c	Fri May 25 22:48:09 2001
+++ work-v2.4.10-pre4/drivers/ide/hd.c	Tue Sep  4 18:17:42 2001
@@ -639,9 +639,11 @@
 		}

          	case BLKGETSIZE:   /* Return device size */
-			if (!arg)  return -EINVAL;
 			return put_user(hd[MINOR(inode->i_rdev)].nr_sects,
 					(long *) arg);
+         	case BLKGETSIZE64:
+			return put_user((u64)hd[MINOR(inode->i_rdev)].nr_sects << 9,
+					(u64 *) arg);

 		case BLKRRPART: /* Re-read partition tables */
 			if (!capable(CAP_SYS_ADMIN))
diff -urN v2.4.10-pre4/drivers/ide/ide.c work-v2.4.10-pre4/drivers/ide/ide.c
--- v2.4.10-pre4/drivers/ide/ide.c	Mon Sep  3 11:04:39 2001
+++ work-v2.4.10-pre4/drivers/ide/ide.c	Tue Sep  4 18:17:42 2001
@@ -2663,6 +2663,8 @@

 	 	case BLKGETSIZE:   /* Return device size */
 			return put_user(drive->part[MINOR(inode->i_rdev)&PARTN_MASK].nr_sects, (long *) arg);
+	 	case BLKGETSIZE64:
+			return put_user((u64)drive->part[MINOR(inode->i_rdev)&PARTN_MASK].nr_sects << 9, (u64 *) arg);

 		case BLKRRPART: /* Re-read partition tables */
 			if (!capable(CAP_SYS_ADMIN)) return -EACCES;
diff -urN v2.4.10-pre4/drivers/md/lvm.c work-v2.4.10-pre4/drivers/md/lvm.c
--- v2.4.10-pre4/drivers/md/lvm.c	Mon Sep  3 11:04:39 2001
+++ work-v2.4.10-pre4/drivers/md/lvm.c	Tue Sep  4 18:17:42 2001
@@ -906,6 +906,11 @@
 			return -EFAULT;
 		break;

+	case BLKGETSIZE64:
+		if (put_user((u64)lv_ptr->lv_size << 9, (u64 *)arg))
+			return -EFAULT;
+		break;
+

 	case BLKFLSBUF:
 		/* flush buffer cache */
diff -urN v2.4.10-pre4/drivers/md/md.c work-v2.4.10-pre4/drivers/md/md.c
--- v2.4.10-pre4/drivers/md/md.c	Mon Sep  3 11:04:39 2001
+++ work-v2.4.10-pre4/drivers/md/md.c	Tue Sep  4 18:17:42 2001
@@ -2490,6 +2490,11 @@
 						(long *) arg);
 			goto done;

+		case BLKGETSIZE64:   /* Return device size */
+			err = md_put_user((u64)md_hd_struct[minor].nr_sects << 9,
+						(u64 *) arg);
+			goto done;
+
 		case BLKRAGET:
 		case BLKRASET:
 		case BLKFLSBUF:
diff -urN v2.4.10-pre4/drivers/mtd/ftl.c work-v2.4.10-pre4/drivers/mtd/ftl.c
--- v2.4.10-pre4/drivers/mtd/ftl.c	Tue Jul  3 21:15:02 2001
+++ work-v2.4.10-pre4/drivers/mtd/ftl.c	Tue Sep  4 18:17:42 2001
@@ -1174,10 +1174,10 @@
 	put_user(ftl_hd[minor].start_sect, (u_long *)&geo->start);
 	break;
     case BLKGETSIZE:
-	ret = verify_area(VERIFY_WRITE, (long *)arg, sizeof(long));
-	if (ret) return ret;
-	put_user(ftl_hd[minor].nr_sects,
-		 (long *)arg);
+	ret = put_user(ftl_hd[minor].nr_sects, (long *)arg);
+	break;
+    case BLKGETSIZE64:
+	ret = put_user((u64)ftl_hd[minor].nr_sects << 9, (u64 *)arg);
 	break;
     case BLKRRPART:
 	ret = ftl_reread_partitions(minor);
diff -urN v2.4.10-pre4/drivers/mtd/mtdblock.c work-v2.4.10-pre4/drivers/mtd/mtdblock.c
--- v2.4.10-pre4/drivers/mtd/mtdblock.c	Fri May 25 22:48:09 2001
+++ work-v2.4.10-pre4/drivers/mtd/mtdblock.c	Tue Sep  4 18:17:42 2001
@@ -529,10 +529,9 @@

 	switch (cmd) {
 	case BLKGETSIZE:   /* Return device size */
-		if (!arg)
-			return -EFAULT;
-		return put_user((mtdblk->mtd->size >> 9),
-                                (long *) arg)?-EFAULT:0;
+		return put_user((mtdblk->mtd->size >> 9), (long *) arg);
+	case BLKGETSIZE64:
+		return put_user((u64)mtdblk->mtd->size, (u64 *)arg);

 	case BLKFLSBUF:
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
diff -urN v2.4.10-pre4/drivers/mtd/mtdblock_ro.c work-v2.4.10-pre4/drivers/mtd/mtdblock_ro.c
--- v2.4.10-pre4/drivers/mtd/mtdblock_ro.c	Tue Jul  3 21:15:02 2001
+++ work-v2.4.10-pre4/drivers/mtd/mtdblock_ro.c	Tue Sep  4 18:17:42 2001
@@ -211,9 +211,9 @@

 	switch (cmd) {
 	case BLKGETSIZE:   /* Return device size */
-		if (!arg)  return -EFAULT;
-		return Put_user((mtd->size >> 9),
-                                (long *) arg);
+		return put_user((mtd->size >> 9), (long *) arg);
+	case BLKGETSIZE64:
+		return put_user((u64)mtd->size, (u64 *)arg);

 	case BLKFLSBUF:
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
diff -urN v2.4.10-pre4/drivers/mtd/nftlcore.c work-v2.4.10-pre4/drivers/mtd/nftlcore.c
--- v2.4.10-pre4/drivers/mtd/nftlcore.c	Tue Jul  3 21:15:02 2001
+++ work-v2.4.10-pre4/drivers/mtd/nftlcore.c	Tue Sep  4 18:17:42 2001
@@ -791,9 +791,11 @@
 		return copy_to_user((void *)arg, &g, sizeof g) ? -EFAULT : 0;
 	}
 	case BLKGETSIZE:   /* Return device size */
-		if (!arg) return -EINVAL;
 		return put_user(part_table[MINOR(inode->i_rdev)].nr_sects,
                                 (long *) arg);
+	case BLKGETSIZE64:
+		return put_user((u64)part_table[MINOR(inode->i_rdev)].nr_sects << 9,
+                                (u64 *)arg);

 	case BLKFLSBUF:
 		if (!capable(CAP_SYS_ADMIN)) return -EACCES;
diff -urN v2.4.10-pre4/drivers/s390/block/dasd.c work-v2.4.10-pre4/drivers/s390/block/dasd.c
--- v2.4.10-pre4/drivers/s390/block/dasd.c	Mon Sep  3 11:04:39 2001
+++ work-v2.4.10-pre4/drivers/s390/block/dasd.c	Tue Sep  4 18:17:42 2001
@@ -2189,11 +2189,13 @@
 	case BLKGETSIZE:{	/* Return device size */
 			long blocks = major_info->gendisk.sizes
                                       [MINOR (inp->i_rdev)] << 1;
-			rc =
-			    copy_to_user ((long *) data, &blocks,
-					  sizeof (long));
-			if (rc)
-				rc = -EFAULT;
+			rc = put_user(blocks, (long *)arg);
+			break;
+		}
+	case BLKGETSIZE64:{
+			u64 blocks = major_info->gendisk.sizes
+                                      [MINOR (inp->i_rdev)];
+			rc = put_user(blocks << 10, (u64 *)arg);
 			break;
 		}
 	case BLKRRPART:{
diff -urN v2.4.10-pre4/drivers/s390/block/xpram.c work-v2.4.10-pre4/drivers/s390/block/xpram.c
--- v2.4.10-pre4/drivers/s390/block/xpram.c	Mon Sep  3 11:04:39 2001
+++ work-v2.4.10-pre4/drivers/s390/block/xpram.c	Tue Sep  4 18:17:42 2001
@@ -647,14 +647,14 @@

 	case BLKGETSIZE:  /* 0x1260 */
 		/* Return the device size, expressed in sectors */
-		if (!arg) return -EINVAL; /* NULL pointer: not valid */
-		err= 0; /* verify_area_20(VERIFY_WRITE, (long *) arg, sizeof(long));
-			 *  if (err) return err;
-			 */
-		put_user ( 1024* xpram_sizes[MINOR(inode->i_rdev)]
+		return put_user( 1024* xpram_sizes[MINOR(inode->i_rdev)]
                            / XPRAM_SOFTSECT,
 			   (long *) arg);
-		return 0;
+
+	case BLKGETSIZE64:
+		return put_user( (u64)(1024* xpram_sizes[MINOR(inode->i_rdev)]
+                           / XPRAM_SOFTSECT) << 9,
+			   (u64 *) arg);

 	case BLKFLSBUF: /* flush, 0x1261 */
 		fsync_dev(inode->i_rdev);
diff -urN v2.4.10-pre4/drivers/sbus/char/jsflash.c work-v2.4.10-pre4/drivers/sbus/char/jsflash.c
--- v2.4.10-pre4/drivers/sbus/char/jsflash.c	Mon Feb 26 10:20:10 2001
+++ work-v2.4.10-pre4/drivers/sbus/char/jsflash.c	Tue Sep  4 18:17:42 2001
@@ -454,6 +454,8 @@
 	switch (cmd) {
 	case BLKGETSIZE:
 		return put_user(jsfd_bytesizes[dev] >> 9, (long *) arg);
+	case BLKGETSIZE64:
+		return put_user(jsfd_bytesizes[dev], (u64 *) arg);

 #if 0
 	case BLKROSET:
diff -urN v2.4.10-pre4/drivers/scsi/sd.c work-v2.4.10-pre4/drivers/scsi/sd.c
--- v2.4.10-pre4/drivers/scsi/sd.c	Mon Sep  3 11:04:39 2001
+++ work-v2.4.10-pre4/drivers/scsi/sd.c	Tue Sep  4 18:17:42 2001
@@ -227,9 +227,9 @@
 			return 0;
 		}
 		case BLKGETSIZE:   /* Return device size */
-			if (!arg)
-				return -EINVAL;
 			return put_user(sd[SD_PARTITION(inode->i_rdev)].nr_sects, (long *) arg);
+		case BLKGETSIZE64:
+			return put_user((u64)sd[SD_PARTITION(inode->i_rdev)].nr_sects << 9, (u64 *)arg);

 		case BLKROSET:
 		case BLKROGET:
diff -urN v2.4.10-pre4/drivers/scsi/sr_ioctl.c work-v2.4.10-pre4/drivers/scsi/sr_ioctl.c
--- v2.4.10-pre4/drivers/scsi/sr_ioctl.c	Thu Aug 16 16:58:47 2001
+++ work-v2.4.10-pre4/drivers/scsi/sr_ioctl.c	Tue Sep  4 18:17:42 2001
@@ -546,6 +546,8 @@
 	switch (cmd) {
 	case BLKGETSIZE:
 		return put_user(scsi_CDs[target].capacity, (long *) arg);
+	case BLKGETSIZE64:
+		return put_user((u64)scsi_CDs[target].capacity << 9, (u64 *)arg);
 	case BLKROSET:
 	case BLKROGET:
 	case BLKRASET:
diff -urN v2.4.10-pre4/include/asm-i386/uaccess.h work-v2.4.10-pre4/include/asm-i386/uaccess.h
--- v2.4.10-pre4/include/asm-i386/uaccess.h	Tue Sep  4 16:26:04 2001
+++ work-v2.4.10-pre4/include/asm-i386/uaccess.h	Tue Sep  4 18:17:42 2001
@@ -126,6 +126,7 @@
 extern void __put_user_1(void);
 extern void __put_user_2(void);
 extern void __put_user_4(void);
+extern void __put_user_8(void);

 extern void __put_user_bad(void);

@@ -161,6 +162,13 @@
 	  case 1: __put_user_asm(x,ptr,retval,"b","b","iq"); break;	\
 	  case 2: __put_user_asm(x,ptr,retval,"w","w","ir"); break;	\
 	  case 4: __put_user_asm(x,ptr,retval,"l","","ir"); break;	\
+	  case 8: {							\
+		u32 *__put_ptr = (void*)(ptr);				\
+		u64 __put_val = (x);					\
+		__put_user_asm((u32)__put_val,__put_ptr,retval,"l","","ir"); \
+		__put_user_asm((u32)(__put_val>>32),__put_ptr+1,retval,"l","","ir"); \
+		break;							\
+	  }								\
 	  default: __put_user_bad();					\
 	}								\
 } while (0)
diff -urN v2.4.10-pre4/include/linux/fs.h work-v2.4.10-pre4/include/linux/fs.h
--- v2.4.10-pre4/include/linux/fs.h	Mon Sep  3 11:04:39 2001
+++ work-v2.4.10-pre4/include/linux/fs.h	Tue Sep  4 18:18:22 2001
@@ -166,7 +166,7 @@
 #define BLKROSET   _IO(0x12,93)	/* set device read-only (0 = read-write) */
 #define BLKROGET   _IO(0x12,94)	/* get read-only status (0 = read_write) */
 #define BLKRRPART  _IO(0x12,95)	/* re-read partition table */
-#define BLKGETSIZE _IO(0x12,96)	/* return device size */
+#define BLKGETSIZE _IO(0x12,96)	/* return device size /512 (long *arg) */
 #define BLKFLSBUF  _IO(0x12,97)	/* flush buffer cache */
 #define BLKRASET   _IO(0x12,98)	/* Set read ahead for block device */
 #define BLKRAGET   _IO(0x12,99)	/* get current read ahead setting */
@@ -185,6 +185,7 @@
 /* A jump here: 108-111 have been used for various private purposes. */
 #define BLKBSZGET  _IOR(0x12,112,sizeof(int))
 #define BLKBSZSET  _IOW(0x12,113,sizeof(int))
+#define BLKGETSIZE64 _IOR(0x12,114,sizeof(u64))	/* return device size in bytes (u64 *arg) */

 #define BMAP_IOCTL 1		/* obsolete - kept for compatibility */
 #define FIBMAP	   _IO(0x00,1)	/* bmap access */


