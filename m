Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271911AbRJ0PBV>; Sat, 27 Oct 2001 11:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270619AbRJ0PBM>; Sat, 27 Oct 2001 11:01:12 -0400
Received: from calais.pt.lu ([194.154.192.52]:58359 "EHLO calais.pt.lu")
	by vger.kernel.org with ESMTP id <S271800AbRJ0PA7>;
	Sat, 27 Oct 2001 11:00:59 -0400
Message-Id: <200110271500.f9RF0vO01848@hitchhiker.org.lu>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Cc: viro@math.psu.edu
Reply-To: alain@linux.lu
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: Re: Poor floppy performance in kernel 2.4.10
Date: Sat, 27 Oct 2001 17:00:57 +0200
From: Alain Knaff <Alain.Knaff@hitchhiker.org.lu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Appended to this mail is a patch meant to fix the "non-cached floppy"
problem.

The  block_device_operations structure now has a new member:
  can_trust_media_change
If this returns 1, the VFS trusts the driver's check_media_change
function, and skips the call to kill_bdev in blkdev_put. If the driver
provides no such function, it defaults to "don't trust" (i.e. call
kill_bdev)

The floppy driver implements this new function in the following way:
 1. if broken_dcl on a drive is set, can_trust_media_change always
returns false
 2. if broken_dcl is not set, the function initially returns false,
until a disk change signal is seen. From then on, it always returns
true.

Other block devices could implement this by using black or whitelists,
or hardwiring a value.

HOWEVER, even after these changes, the caching problem still wasn't
solved (I confirmed with additional printk's that invalidate_bdev was
indeed no longer called).

Further investigation showed that the real culprit was actually
bdput. This function seems to de-allocate all structures attached to
the block device, including the cache... Ifdeffing it out did indeed
restore cache functionality. However, I understand that this would not
be a proper way to address the problem, as it would certainly cause a
memory leak.

Appended to this mail is the patch (without the debugging printk's,
and with bdput still intact); however in order to make it really work
bdput would need to be changed to not free up the cache, if that is
possible... Any ideas?

Regards,

Alain

diff -ur 2.4.13/linux/drivers/block/floppy.c linux/drivers/block/floppy.c
--- 2.4.13/linux/drivers/block/floppy.c	Sat Oct 27 09:42:34 2001
+++ linux/drivers/block/floppy.c	Sat Oct 27 16:17:33 2001
@@ -741,6 +741,7 @@
 		return UTESTF(FD_DISK_CHANGED);
 	if ((fd_inb(FD_DIR) ^ UDP->flags) & 0x80){
 		USETF(FD_VERIFY); /* verify write protection */
+		USETF(FD_DCL_SEEN); /* DCL for this drive has been seen */
 		if (UDRS->maxblock){
 			/* mark it changed */
 			USETF(FD_DISK_CHANGED);
@@ -3901,12 +3902,23 @@
 	return 0;
 }
 
+/* determines whether we can trust media change
+ * answers true if we have seen disk change at least once, and not marked as
+ * broken */
+static int floppy_can_trust_media_change(kdev_t dev)
+{
+	int drive=DRIVE(dev);
+	return (UTESTF(FD_DCL_SEEN) &&
+		((UDP->flags & FD_BROKEN_DCL) == 0));
+}
+
 static struct block_device_operations floppy_fops = {
 	open:			floppy_open,
 	release:		floppy_release,
 	ioctl:			fd_ioctl,
 	check_media_change:	check_floppy_change,
 	revalidate:		floppy_revalidate,
+	can_trust_media_change: floppy_can_trust_media_change
 };
 
 static void __init register_devfs_entries (int drive)
diff -ur 2.4.13/linux/fs/block_dev.c linux/fs/block_dev.c
--- 2.4.13/linux/fs/block_dev.c	Sat Oct 27 09:43:27 2001
+++ linux/fs/block_dev.c	Sat Oct 27 16:18:19 2001
@@ -601,8 +601,12 @@
 		__block_fsync(bd_inode);
 	else if (kind == BDEV_FS)
 		fsync_no_super(rdev);
-	if (!--bdev->bd_openers)
-		kill_bdev(bdev);
+	if (!--bdev->bd_openers) {
+		if(!bdev->bd_op->can_trust_media_change ||
+		   !bdev->bd_op->can_trust_media_change(rdev)) {
+			kill_bdev(bdev);
+		}
+	}
 	if (bdev->bd_op->release)
 		ret = bdev->bd_op->release(bd_inode, NULL);
 	if (!bdev->bd_openers)
diff -ur 2.4.13/linux/include/linux/fd.h linux/include/linux/fd.h
--- 2.4.13/linux/include/linux/fd.h	Fri Aug 13 21:16:16 1999
+++ linux/include/linux/fd.h	Sat Oct 27 13:37:08 2001
@@ -177,7 +177,8 @@
 				 * to clear media change status */
 	FD_UNUSED_BIT,
 	FD_DISK_CHANGED_BIT,	/* disk has been changed since last i/o */
-	FD_DISK_WRITABLE_BIT	/* disk is writable */
+	FD_DISK_WRITABLE_BIT,	/* disk is writable */
+	FD_DCL_SEEN_BIT		/* have we seen DCL? */
 };
 
 #define FDSETDRVPRM _IOW(2, 0x90, struct floppy_drive_params)
@@ -196,6 +197,7 @@
 #define FD_DISK_NEWCHANGE (1 << FD_DISK_NEWCHANGE_BIT)
 #define FD_DISK_CHANGED (1 << FD_DISK_CHANGED_BIT)
 #define FD_DISK_WRITABLE (1 << FD_DISK_WRITABLE_BIT)
+#define FD_DCL_SEEN (1 << FD_DCL_SEEN)
 
 	unsigned long spinup_date;
 	unsigned long select_date;
diff -ur 2.4.13/linux/include/linux/fs.h linux/include/linux/fs.h
--- 2.4.13/linux/include/linux/fs.h	Sat Oct 27 11:53:28 2001
+++ linux/include/linux/fs.h	Sat Oct 27 13:05:03 2001
@@ -793,6 +793,7 @@
 	int (*ioctl) (struct inode *, struct file *, unsigned, unsigned long);
 	int (*check_media_change) (kdev_t);
 	int (*revalidate) (kdev_t);
+	int (*can_trust_media_change) (kdev_t);
 };
 
 /*
