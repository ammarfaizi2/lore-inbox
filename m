Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316753AbSIALzZ>; Sun, 1 Sep 2002 07:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316788AbSIALzZ>; Sun, 1 Sep 2002 07:55:25 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:34013 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S316753AbSIALzY>;
	Sun, 1 Sep 2002 07:55:24 -0400
Date: Sun, 1 Sep 2002 13:59:51 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200209011159.NAA15370@harpo.it.uu.se>
To: torvalds@transmeta.com
Subject: Re: 2.5.33-bk testing
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Sep 2002 05:24:58 +0000 (UTC), Linus Torvalds wrote:
>In article <Pine.LNX.4.44.0208312209240.1129-100000@dad.molina>,
>Thomas Molina  <tmolina@cox.net> wrote:
>>
>>I've beat on the floppy driver and it seems to work well.  I haven't been 
>>able to make it hiccup yet.
>
>Really? I was looking at my cleanups, and I'm fairly certain they are
>buggy.  I just pushed an update to the BK tree a few minutes ago that I
>think should fix it, but since I'm not a floppy user myself I can only
>go by the source and trying to imagine everything that could go wrong. 

I was able to get 2.5.33 (even with your patch) to corrupt data
in a few seconds: writes (with dd) put corrupted data on the
media, and reads (again with dd) returns data that doesn't
match what's on the media.

The patch below is an update of the floppy workarounds patch
I've been maintaining since the problems began in 2.5.13.
With this patch I'm able to reliably read and write to the
raw /dev/fd0 device. I'm not suggesting that my hack to
bdev->bd_block_size is the correct fix, but maybe someone who
understands the block I/O system can see what's going on and
do a proper fix.

There is also a fix to the broken {,un}register_sys_device() calls.
The driver forgets to unregister in several cases, leading to data
structure corruption.

/Mikael

diff -ruN linux-2.5.33.linus/drivers/block/floppy.c linux-2.5.33.floppy/drivers/block/floppy.c
--- linux-2.5.33.linus/drivers/block/floppy.c	Sun Sep  1 13:25:00 2002
+++ linux-2.5.33.floppy/drivers/block/floppy.c	Sun Sep  1 13:24:30 2002
@@ -3710,6 +3710,10 @@
 		UDRS->fd_ref = 0;
 	}
 	floppy_release_irq_and_dma();
+
+	/* undo ++bd_openers in floppy_open() */
+	--inode->i_bdev->bd_openers;
+
 	return 0;
 }
 
@@ -3802,6 +3806,44 @@
 		invalidate_buffers(mk_kdev(FLOPPY_MAJOR,old_dev));
 	}
 
+	/* Problems:
+	 * 1. fs/block_dev.c:do_open() calls bd_set_size() which
+	 *    changes bdev's block size after floppy_open() has
+	 *    returned. For some reason, this causes data corruption.
+	 * 2. The device size appears to be zero on first access
+	 *    sometimes, especially if the first access is a write.
+	 * Workarounds:
+	 * 1. Set bdev block size equal to the hardsect/queue size.
+	 *    This seems to cure the data corruption problem for raw
+	 *    accesses. VFS accesses to mounted floppies still cause
+	 *    data corruption for unknown reasons.
+	 * 2. Fake a constant 1.44MB i_size.
+	 * 1&2. ++bdev->bd_openers to bypass do_open()'s changes.
+	 *    floppy_release() does a --bdev->bd_openers.
+	 */
+	{
+		struct block_device *bdev = inode->i_bdev;
+		struct backing_dev_info *bdi;
+		sector_t sect;
+
+		bdev->bd_offset = 0;
+
+		sect = (1440 * 1024) >> 9;
+
+		/* like bd_set_size() but don't mutate block_size */
+		bdev->bd_inode->i_size = (loff_t)sect << 9;
+		bdev->bd_block_size = bdev_hardsect_size(bdev);
+		bdev->bd_inode->i_blkbits = blksize_bits(block_size(bdev));
+
+		bdi = blk_get_backing_dev_info(bdev);
+		if (bdi == NULL)
+			bdi = &default_backing_dev_info;
+		inode->i_data.backing_dev_info = bdi;
+		bdev->bd_inode->i_data.backing_dev_info = bdi;
+
+		++bdev->bd_openers;
+	}
+
 	/* Allow ioctls if we have write-permissions even if read-only open.
 	 * Needed so that programs such as fdrawcmd still can work on write
 	 * protected disks */
@@ -4239,8 +4281,6 @@
 {
 	int i,unit,drive;
 
-	register_sys_device(&device_floppy);
-
 	raw_cmd = NULL;
 
 	devfs_handle = devfs_mk_dir (NULL, "floppy", NULL);
@@ -4367,6 +4407,9 @@
 			register_disk(NULL, mk_kdev(MAJOR_NR,TOMINOR(drive)+i*4),
 					1, &floppy_fops, 0);
 	}
+
+	register_sys_device(&device_floppy);
+
 	return have_no_fdc;
 }
 
@@ -4549,6 +4592,7 @@
 {
 	int dummy;
 		
+	unregister_sys_device(&device_floppy);
 	devfs_unregister (devfs_handle);
 	unregister_blkdev(MAJOR_NR, "fd");
 
