Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278662AbRJ1UkV>; Sun, 28 Oct 2001 15:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278665AbRJ1UkM>; Sun, 28 Oct 2001 15:40:12 -0500
Received: from calais.pt.lu ([194.154.192.52]:34183 "EHLO calais.pt.lu")
	by vger.kernel.org with ESMTP id <S278662AbRJ1UkD>;
	Sun, 28 Oct 2001 15:40:03 -0500
Message-Id: <200110282040.f9SKe6M02113@hitchhiker.org.lu>
To: Alexander Viro <viro@math.psu.edu>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Richard Gooch <rgooch@ras.ucalgary.ca>, linux-kernel@vger.kernel.org
Reply-To: alain@linux.lu
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: Re: Poor floppy performance in kernel 2.4.10 
In-Reply-To: Your message of "Sat, 27 Oct 2001 15:19:48 EDT."
             <Pine.GSO.4.21.0110271517010.21545-100000@weyl.math.psu.edu> 
Date: Sun, 28 Oct 2001 21:40:05 +0100
From: Alain Knaff <Alain.Knaff@hitchhiker.org.lu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Appended to this mail is the "long live the struct block_device"
patch. It includes the stuff covered in the last patch as well. The
issue of stopping transfers in progress is not yet addressed.

How it works: rather than have bdput free up the struct block_device
unconditionnally as soon as the count drops to zero, forcefully
bd_forgetting any inodes that still reference it, it now checks the
list of inodes references it, and only frees it up if not referenced.

Moreover, bd_forget also calls __bdput to free up the struct
block_device when the number of referencers drops to zero later on.

Simple tests show this to make the cache workeable again, and an extra
printk in floppy_open allows to show that the struct block_device can
be freed up if needed (by creating high memory pressure).


diff -ur 2.4.13/linux/drivers/block/floppy.c linux/drivers/block/floppy.c
--- 2.4.13/linux/drivers/block/floppy.c	Sat Oct 27 09:42:34 2001
+++ linux/drivers/block/floppy.c	Sun Oct 28 21:21:46 2001
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
--- 2.4.13/linux/fs/block_dev.c	Sun Oct 28 09:52:53 2001
+++ linux/fs/block_dev.c	Sun Oct 28 21:11:08 2001
@@ -346,19 +346,36 @@
 	inode->i_mapping = &inode->i_data;
 }
 
+/**
+ * Physically delete bdev iff inode list empty AND counter zero. Must be
+ * called with bdev_lock held. bdev_lock will be released on exit.
+ * Should be called by all functions which can make either of the conditions
+ * true (decrease counter (bdput) or free inode (bdforget)
+ */
+static void __bdput(struct block_device *bdev) {
+    int shouldDrop =
+	    (bdev->bd_inodes.next == &bdev->bd_inodes) &&
+	    (atomic_read(&bdev->bd_count) == 0);
+    if(shouldDrop) {
+	    if (bdev->bd_openers)
+		    BUG();
+	    list_del(&bdev->bd_hash);
+    }
+    spin_unlock(&bdev_lock);
+    if(shouldDrop) {
+	    if (bdev->bd_openers)
+		    BUG();
+	    iput(bdev->bd_inode);
+	    destroy_bdev(bdev);
+    }
+}
+
 void bdput(struct block_device *bdev)
 {
 	if (atomic_dec_and_lock(&bdev->bd_count, &bdev_lock)) {
-		struct list_head *p;
 		if (bdev->bd_openers)
 			BUG();
-		list_del(&bdev->bd_hash);
-		while ( (p = bdev->bd_inodes.next) != &bdev->bd_inodes ) {
-			__bd_forget(list_entry(p, struct inode, i_devices));
-		}
-		spin_unlock(&bdev_lock);
-		iput(bdev->bd_inode);
-		destroy_bdev(bdev);
+		__bdput(bdev);
 	}
 }
  
@@ -390,9 +407,17 @@
 
 void bd_forget(struct inode *inode)
 {
+	struct block_device *bdev;
 	spin_lock(&bdev_lock);
-	if (inode->i_bdev)
+	bdev = inode->i_bdev;
+	if (bdev) {
 		__bd_forget(inode);
+		if(inode != bdev->bd_inode) {
+			/* if not "root" inode, do the bdput */
+			__bdput(bdev);
+			return;
+		}
+	}
 	spin_unlock(&bdev_lock);
 }
 
@@ -601,8 +626,12 @@
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
