Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315427AbSEBVTM>; Thu, 2 May 2002 17:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315428AbSEBVTL>; Thu, 2 May 2002 17:19:11 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:30574 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S315427AbSEBVTH>; Thu, 2 May 2002 17:19:07 -0400
Subject: [BK-2.5.12-BUGFIX] NTFS 2.0.5 update, fixes nasty buffer overflow
To: linux-kernel@vger.kernel.org (Linux Kernel)
Date: Thu, 2 May 2002 22:19:06 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E173Nyk-0008Ln-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is an update for ntfs to 2.0.5 which I have just sent for Linus
for inclusion.

It fixes a kmalloc()ed memory buffer overflow in ntfs caused by a logic 
inversion bug (a misplaced not operator).

I am still brooding over whether I can remove the BKL for ntfs_readdir
or not... I have a private rw semaphore locking down the meta data of 
the directory which one would need to take to make any changes to the 
directory so I think it will be safe to remove the BKL but I am not sure 
whether the BKL is protecting f_pos as well or whether that is protected 
by other means already...

 CREDITS                              |    5 ++---
 MAINTAINERS                          |    3 ++-
 drivers/video/matrox/matroxfb_base.c |    2 +-
 fs/ntfs/ChangeLog                    |   14 +++++++++++++-
 fs/ntfs/Makefile                     |    2 +-
 fs/ntfs/inode.c                      |    3 ++-
 fs/ntfs/mft.c                        |    2 +-
 fs/ntfs/super.c                      |   11 ++++-------
 fs/ntfs/upcase.c                     |    2 +-
 fs/partitions/ldm.c                  |    2 +-
 fs/partitions/ldm.h                  |    2 +-
 11 files changed, 29 insertions(+), 19 deletions(-)

The few files touched outside fs/ntfs are just updates for my contact
details...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

--- patch ---
diff -urNp linux-2.5.12/CREDITS tng-2.0.5/CREDITS
--- linux-2.5.12/CREDITS	Thu May  2 22:08:53 2002
+++ tng-2.0.5/CREDITS	Thu May  2 22:07:46 2002
@@ -63,10 +63,9 @@ S: B-2610 Wilrijk-Antwerpen
 S: Belgium
 
 N: Anton Altaparmakov
-E: aia21@cus.cam.ac.uk
+E: aia21@cantab.net
 W: http://www-stu.christs.cam.ac.uk/~aia21/
-D: NTFS driver maintainer. NTFS fixes and cleanup.
-D: Tiny fixes in linear md device and emu10k1 driver.
+D: Author of new NTFS driver, various other kernel hacks.
 S: Christ's College
 S: Cambridge CB2 3BU
 S: United Kingdom
diff -urNp linux-2.5.12/MAINTAINERS tng-2.0.5/MAINTAINERS
--- linux-2.5.12/MAINTAINERS	Thu May  2 22:08:39 2002
+++ tng-2.0.5/MAINTAINERS	Thu May  2 22:07:33 2002
@@ -1146,9 +1146,10 @@ S:	Maintained
 
 NTFS FILESYSTEM
 P:	Anton Altaparmakov
-M:	aia21@cus.cam.ac.uk
+M:	aia21@cantab.net
 L:	linux-ntfs-dev@lists.sourceforge.net
 L:	linux-kernel@vger.kernel.org
+W:	http://linux-ntfs.sf.net/
 S:	Maintained
 
 NVIDIA (RIVA) FRAMEBUFFER DRIVER
diff -urNp linux-2.5.12/drivers/video/matrox/matroxfb_base.c tng-2.0.5/drivers/video/matrox/matroxfb_base.c
--- linux-2.5.12/drivers/video/matrox/matroxfb_base.c	Thu May  2 22:11:10 2002
+++ tng-2.0.5/drivers/video/matrox/matroxfb_base.c	Thu May  2 22:10:53 2002
@@ -68,7 +68,7 @@
  *               "Samuel Hocevar" <sam@via.ecp.fr>
  *                     Fixes
  *
- *               "Anton Altaparmakov" <AntonA@bigfoot.com>
+ *               "Anton Altaparmakov"
  *                     G400 MAX/non-MAX distinction
  *
  *               "Ken Aaker" <kdaaker@rchland.vnet.ibm.com>
diff -urNp linux-2.5.12/fs/ntfs/ChangeLog tng-2.0.5/fs/ntfs/ChangeLog
--- linux-2.5.12/fs/ntfs/ChangeLog	Thu May  2 22:09:25 2002
+++ tng-2.0.5/fs/ntfs/ChangeLog	Thu May  2 22:08:18 2002
@@ -27,6 +27,18 @@ ToDo:
 	  quite big. Modularising them a bit, e.g. a-la get_block(), will make
 	  them cleaner and make code reuse easier.
 
+2.0.5 - Major bugfix. Buffer overflow in extent inode handling.
+
+	- No need to set old blocksize in super.c::ntfs_fill_super() as the
+	  VFS does so via invocation of deactivate_super() calling
+	  fs->fill_super() calling block_kill_super() which does it.
+	- BKL moved from VFS into dir.c::ntfs_readdir(). (Linus Torvalds)
+	  -> Do we really need it? I don't think so as we have exclusion on
+	  the directory ntfs_inode rw_semaphore mrec_lock. We mmight have to
+	  move the ->f_pos accesses under the mrec_lock though. Check this...
+	- Fix really, really, really stupid buffer overflow in extent inode
+	  handling in mft.c::map_extent_mft_record().
+
 2.0.4 - Cleanups and updates for kernel 2.5.11.
 
 	- Add documentation on how to use the MD driver to be able to use NTFS
@@ -35,7 +47,7 @@ ToDo:
 	Remove all uses of kdev_t in favour of struct block_device *:
 	- Change compress.c::ntfs_file_read_compressed_block() to use
 	  sb_getblk() instead of getblk().
-	- Change super.c::ntfs_fill_suoer() to use bdev_hardsect_size() instead
+	- Change super.c::ntfs_fill_super() to use bdev_hardsect_size() instead
 	  of get_hardsect_size().
 	- No need to get old blocksize in super.c::ntfs_fill_super() as
 	  fs/super.c::get_sb_bdev() already does this.
diff -urNp linux-2.5.12/fs/ntfs/Makefile tng-2.0.5/fs/ntfs/Makefile
--- linux-2.5.12/fs/ntfs/Makefile	Thu May  2 22:08:34 2002
+++ tng-2.0.5/fs/ntfs/Makefile	Thu May  2 22:07:32 2002
@@ -7,7 +7,7 @@ obj-y   := aops.o attrib.o compress.o de
 
 obj-m   := $(O_TARGET)
 
-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.0.4\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.0.5\"
 
 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff -urNp linux-2.5.12/fs/ntfs/inode.c tng-2.0.5/fs/ntfs/inode.c
--- linux-2.5.12/fs/ntfs/inode.c	Thu May  2 22:09:45 2002
+++ tng-2.0.5/fs/ntfs/inode.c	Thu May  2 22:08:57 2002
@@ -1191,7 +1191,8 @@ void ntfs_read_inode_mount(struct inode 
 				"for $MFT/$DATA. Driver bug or "
 				"corrupt $MFT. Run chkdsk.");
 		ntfs_debug("highest_vcn = 0x%Lx, last_vcn - 1 = 0x%Lx",
-				(long long)highest_vcn, (long long)last_vcn - 1);
+				(long long)highest_vcn,
+				(long long)last_vcn - 1);
 		goto put_err_out;
 	}
 	put_attr_search_ctx(ctx);
diff -urNp linux-2.5.12/fs/ntfs/mft.c tng-2.0.5/fs/ntfs/mft.c
--- linux-2.5.12/fs/ntfs/mft.c	Thu May  2 22:08:45 2002
+++ tng-2.0.5/fs/ntfs/mft.c	Thu May  2 22:07:40 2002
@@ -459,7 +459,7 @@ map_err_out:
 		goto unm_err_out;
 	}
 	/* Attach extent inode to base inode, reallocating memory if needed. */
-	if (!(base_ni->nr_extents & ~3)) {
+	if (!(base_ni->nr_extents & 3)) {
 		ntfs_inode **tmp;
 		int new_size = (base_ni->nr_extents + 4) * sizeof(ntfs_inode *);
 
diff -urNp linux-2.5.12/fs/ntfs/super.c tng-2.0.5/fs/ntfs/super.c
--- linux-2.5.12/fs/ntfs/super.c	Thu May  2 22:08:46 2002
+++ tng-2.0.5/fs/ntfs/super.c	Thu May  2 22:07:43 2002
@@ -1555,7 +1555,7 @@ static int ntfs_fill_super(struct super_
 	if (sb_set_blocksize(sb, NTFS_BLOCK_SIZE) != NTFS_BLOCK_SIZE) {
 		if (!silent)
 			ntfs_error(sb, "Unable to set block size.");
-		goto set_blk_size_err_out_now;
+		goto err_out_now;
 	}
 
 	/* Get the size of the device in units of NTFS_BLOCK_SIZE bytes. */
@@ -1565,7 +1565,7 @@ static int ntfs_fill_super(struct super_
 	if (!(bh = read_ntfs_boot_sector(sb, silent))) {
 		if (!silent)
 			ntfs_error(sb, "Not an NTFS volume.");
-		goto set_blk_size_err_out_now;
+		goto err_out_now;
 	}
 	
 	/*
@@ -1579,7 +1579,7 @@ static int ntfs_fill_super(struct super_
 	if (!result) {
 		if (!silent)
 			ntfs_error(sb, "Unsupported NTFS filesystem.");
-		goto set_blk_size_err_out_now;
+		goto err_out_now;
 	}
 
 	/* 
@@ -1750,10 +1750,7 @@ cond_iput_mft_ino_err_out_now:
 		printk("VFS: Busy inodes after umount. Self-destruct in 5 "
 				"seconds.  Have a nice day...\n");
 	}
-set_blk_size_err_out_now:
 	/* Errors at this stage are irrelevant. */
-	// FIXME: This should be done in fs/super.c::get_sb_bdev() itself! (AIA)
-	sb_set_blocksize(sb, sb->s_old_blocksize);
 err_out_now:
 	sb->u.generic_sbp = NULL;
 	kfree(vol);
@@ -1936,7 +1933,7 @@ static void __exit exit_ntfs_fs(void)
 }
 
 EXPORT_NO_SYMBOLS;
-MODULE_AUTHOR("Anton Altaparmakov <aia21@cam.ac.uk>");
+MODULE_AUTHOR("Anton Altaparmakov <aia21@cantab.net>");
 MODULE_DESCRIPTION("NTFS 1.2/3.x driver");
 MODULE_LICENSE("GPL");
 #ifdef DEBUG
diff -urNp linux-2.5.12/fs/ntfs/upcase.c tng-2.0.5/fs/ntfs/upcase.c
--- linux-2.5.12/fs/ntfs/upcase.c	Thu May  2 22:08:38 2002
+++ tng-2.0.5/fs/ntfs/upcase.c	Thu May  2 22:07:33 2002
@@ -3,7 +3,7 @@
  *	      Part of the Linux-NTFS project.
  *
  * Copyright (C) 2001 Richard Russon <ntfs@flatcap.org>
- * Copyright (c) 2001 Anton Altaparmakov <aia21@cam.ac.uk>
+ * Copyright (c) 2001,2002 Anton Altaparmakov
  *
  * Modified for mkntfs inclusion 9 June 2001 by Anton Altaparmakov.
  * Modified for kernel inclusion 10 September 2001 by Anton Altparmakov.
diff -urNp linux-2.5.12/fs/partitions/ldm.c tng-2.0.5/fs/partitions/ldm.c
--- linux-2.5.12/fs/partitions/ldm.c	Thu May  2 22:09:47 2002
+++ tng-2.0.5/fs/partitions/ldm.c	Thu May  2 22:09:04 2002
@@ -2,7 +2,7 @@
  * ldm - Part of the Linux-NTFS project.
  *
  * Copyright (C) 2001 Richard Russon <ldm@flatcap.org>
- * Copyright (C) 2001 Anton Altaparmakov <antona@users.sf.net> (AIA)
+ * Copyright (C) 2001 Anton Altaparmakov (AIA)
  *
  * Documentation is available at http://linux-ntfs.sf.net/ldm
  *
diff -urNp linux-2.5.12/fs/partitions/ldm.h tng-2.0.5/fs/partitions/ldm.h
--- linux-2.5.12/fs/partitions/ldm.h	Thu May  2 22:09:38 2002
+++ tng-2.0.5/fs/partitions/ldm.h	Thu May  2 22:08:34 2002
@@ -4,7 +4,7 @@
  * ldm - Part of the Linux-NTFS project.
  *
  * Copyright (C) 2001 Richard Russon <ldm@flatcap.org>
- * Copyright (C) 2001 Anton Altaparmakov <antona@users.sf.net>
+ * Copyright (C) 2001 Anton Altaparmakov
  *
  * Documentation is available at http://linux-ntfs.sf.net/ldm
  *
