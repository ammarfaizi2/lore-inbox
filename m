Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129931AbRAIL2w>; Tue, 9 Jan 2001 06:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129933AbRAIL2m>; Tue, 9 Jan 2001 06:28:42 -0500
Received: from mail008.syd.optusnet.com.au ([203.2.75.232]:4780 "EHLO
	mail008.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S129931AbRAIL2b>; Tue, 9 Jan 2001 06:28:31 -0500
Date: Tue, 9 Jan 2001 22:24:56 +1100
Message-Id: <200101091124.f09BOlj31522@mail008.syd.optusnet.com.au>
From: David Tritscher <ameuba@dingoblue.net.au>
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: PROBLEM: loop device doesnt reset it's flags
Reply-To: ameuba@dingoblue.net.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.]

The loop device doesnt seem to reset it's read-only status after it
gets used on a file that is on a read-only filesystem.

[6.]

(Pretty chopped up, but it demonstrates the problem)

# mount
/dev/hda1 on / type reiserfs (rw)
/dev/scd0 on /mnt/cdrom type iso9660 (ro,noexec,nosuid,nodev,sync,unhide)
# list /mnt/cdrom/floppy.img 
-r--r--r--   1 root     root      1474560 Dec 16 15:40 /mnt/cdrom/floppy.img
# cp /mnt/cdrom/floppy.img /

# mount -o loop=/dev/loop0 /floppy.img /mnt/disk
# mount
/floppy.img on /mnt/disk type ext2 (rw,loop=/dev/loop0)
# umount /mnt/disk

# mount -o ro,loop=/dev/loop0 /floppy.img /mnt/disk
# mount
/floppy.img on /mnt/disk type ext2 (ro,loop=/dev/loop0)
# umount /mnt/disk

# mount -o rw,loop=/dev/loop0 /floppy.img /mnt/disk
# mount
/floppy.img on /mnt/disk type ext2 (rw,loop=/dev/loop0)
# umount /mnt/disk

(All that above is normal)

# mount -o loop=/dev/loop0 /mnt/cdrom/floppy.img /mnt/disk
# mount
/mnt/cdrom/floppy.img on /mnt/disk type ext2 (ro,loop=/dev/loop0)
# umount /mnt/disk

(Now loop0 is screwed)

# mount -o loop=/dev/loop0 /floppy.img /mnt/disk
mount: floppy.img is write-protected, mounting read-only
# mount
/floppy.img on /mnt/disk type ext2 (ro,loop=/dev/loop0)
# umount /mnt/disk

# mount -o rw,loop=/dev/loop0 /floppy.img /mnt/disk
mount: floppy.img is write-protected, mounting read-only
# mount
/floppy.img on /mnt/disk type ext2 (ro,loop=/dev/loop0)
# umount /mnt/disk

The same behavior as shown above is exhibited by:

losetup /dev/loop1 /mnt/cdrom/floppy.img
losetup -d /dev/loop1

now loop1 thinks it is always read-only.

[7.1.]

Linux dave 2.4.0 #1 i586 unknown
Kernel modules         2.4.0
Gnu C                  2.95.2
Gnu Make               3.79.1
Binutils               2.10.1
Linux C Library        2.2
Dynamic linker         ldd: version 1.9.9
Procps                 2.0.7
Mount                  2.10r
Net-tools              1.57
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         

[X.]

This patch seems to fix the problem on my machine.

--- linux/drivers/block/loop.c.orig     Tue Jan  9 12:16:02 2001
+++ linux/drivers/block/loop.c  Tue Jan  9 12:16:57 2001
@@ -412,13 +412,14 @@
        error = -EINVAL;
        inode = file->f_dentry->d_inode;
 
+       lo->lo_flags = 0;
+
        if (S_ISBLK(inode->i_mode)) {
                /* dentry will be wired, so... */
                error = blkdev_get(inode->i_bdev, file->f_mode,
                                   file->f_flags, BDEV_FILE);
 
                lo->lo_device = inode->i_rdev;
-               lo->lo_flags = 0;
 
                /* Backed by a block device - don't need to hold onto
                   a file structure */
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
