Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315223AbSEDWZr>; Sat, 4 May 2002 18:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315225AbSEDWZq>; Sat, 4 May 2002 18:25:46 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:52810 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S315223AbSEDWZp>; Sat, 4 May 2002 18:25:45 -0400
Subject: [PATCH-2.5.13] NTFS 2.0.6 Bugfix/adapt to 2.5.12 changes
To: linux-kernel@vger.kernel.org (Linux Kernel)
Date: Sat, 4 May 2002 23:25:43 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1747yJ-0005eY-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have just sent the below NTFS update to Linus for inclusion. Andrew 
Morton's changes to 2.5.12 broke NTFS because they added fields to
struct address_space which ntfs obviously wasn't initializing...

The below patch is also available in the BK repository:

	http://linux-ntfs.bkbits.net/ntfs-tng-2.5

ChangeSet@1.517, 2002-05-04 22:58:17+01:00, aia21@cantab.net
NTFS: Release 2.0.6 - Major bugfix to make compatible with other kernel changes.
- Initialize the mftbmp address space properly now that there are more
  fields in the struct address_space. This was leading to hangs and
  oopses on umount since 2.5.12 because of changes to other parts of
  the kernel. We probably want a kernel generic init_address_space()
  function...
- Drop BKL from ntfs_readdir() after consultation with Al Viro. The
  only caller of ->readdir() is vfs_readdir() which holds i_sem during
  the call, and i_sem is sufficient protection against changes in the
  directory inode (including ->i_size).
- Use generic_file_llseek() for directories (as opposed to
  default_llseek()) as this downs i_sem instead of the BKL which is
  what we now need for exclusion against ->f_pos changes considering we
  no longer take the BKL in ntfs_readdir().


 Documentation/filesystems/ntfs.txt |    7 ++++++
 fs/ntfs/ChangeLog                  |   23 +++++++++++++++++----
 fs/ntfs/Makefile                   |    2 -
 fs/ntfs/compress.c                 |    7 +++---
 fs/ntfs/dir.c                      |   14 ++++++++-----
 fs/ntfs/super.c                    |   39 +++++++++++++++++++------------------
 6 files changed, 60 insertions(+), 32 deletions(-)


diff -Nru a/Documentation/filesystems/ntfs.txt b/Documentation/filesystems/ntfs.txt
--- a/Documentation/filesystems/ntfs.txt	Sat May  4 23:12:47 2002
+++ b/Documentation/filesystems/ntfs.txt	Sat May  4 23:12:47 2002
@@ -262,6 +262,13 @@
 
 Note that a technical ChangeLog aimed at kernel hackers is in fs/ntfs/ChangeLog.
 
+2.0.6:
+	- Major bugfix to make compatible with other kernel changes. This fixes
+	  the hangs/oopses on umount.
+	- Locking cleanup in directory operations (remove BKL usage).
+2.0.5:
+	- Major buffer overflow bug fix.
+	- Minor cleanups and updates for kernel 2.5.12.
 2.0.4:
 	- Cleanups and updates for kernel 2.5.11.
 2.0.3:
diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	Sat May  4 23:12:47 2002
+++ b/fs/ntfs/ChangeLog	Sat May  4 23:12:47 2002
@@ -14,11 +14,6 @@
 	  strictly a speed optimization. Obviously need to keep the ->run_list
 	  locked or RACE. load_attribute_list() already performs such an
 	  optimization so use the same optimization where desired.
-	- Optimize all our readpage functions to not do i/o on buffer heads
-	  beyond initialized_size, just zero the buffer heads instead.
-	  Question: How to setup the buffer heads so they point to the on disk
-	  location correctly (after all they are allocated) but are not read
-	  from disk?
 	- Consider if ntfs_file_read_compressed_block() shouldn't be coping
 	  with initialized_size < data_size. I don't think it can happen but
 	  it requires more careful consideration.
@@ -26,6 +21,24 @@
 	  several copies of almost identicall functions and the functions are
 	  quite big. Modularising them a bit, e.g. a-la get_block(), will make
 	  them cleaner and make code reuse easier.
+	- Want to use dummy inodes for address space i/o. We need some VFS
+	  changes first, which are currently under discussion.
+
+2.0.6 - Major bugfix to make compatible with other kernel changes.
+
+	- Initialize the mftbmp address space properly now that there are more
+	  fields in the struct address_space. This was leading to hangs and
+	  oopses on umount since 2.5.12 because of changes to other parts of
+	  the kernel. We probably want a kernel generic init_address_space()
+	  function...
+	- Drop BKL from ntfs_readdir() after consultation with Al Viro. The
+	  only caller of ->readdir() is vfs_readdir() which holds i_sem during
+	  the call, and i_sem is sufficient protection against changes in the
+	  directory inode (including ->i_size).
+	- Use generic_file_llseek() for directories (as opposed to
+	  default_llseek()) as this downs i_sem instead of the BKL which is
+	  what we now need for exclusion against ->f_pos changes considering we
+	  no longer take the BKL in ntfs_readdir().
 
 2.0.5 - Major bugfix. Buffer overflow in extent inode handling.
 
diff -Nru a/fs/ntfs/Makefile b/fs/ntfs/Makefile
--- a/fs/ntfs/Makefile	Sat May  4 23:12:47 2002
+++ b/fs/ntfs/Makefile	Sat May  4 23:12:47 2002
@@ -7,7 +7,7 @@
 
 obj-m   := $(O_TARGET)
 
-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.0.5\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.0.6\"
 
 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff -Nru a/fs/ntfs/compress.c b/fs/ntfs/compress.c
--- a/fs/ntfs/compress.c	Sat May  4 23:12:47 2002
+++ b/fs/ntfs/compress.c	Sat May  4 23:12:47 2002
@@ -763,9 +763,10 @@
 		 * ntfs_decompess.
 		 */
 		if (err) {
-			ntfs_error(vol->sb, "ntfs_decompress() failed with "
-					"error code %i. Skipping this "
-					"compression block.\n", -err);
+			ntfs_error(vol->sb, "ntfs_decompress() failed in inode "
+					"0x%Lx with error code %i. Skipping "
+					"this compression block.\n",
+					(unsigned long long)ni->mft_no, -err);
 			/* Release the unfinished pages. */
 			for (; prev_cur_page < cur_page; prev_cur_page++) {
 				page = pages[prev_cur_page];
diff -Nru a/fs/ntfs/dir.c b/fs/ntfs/dir.c
--- a/fs/ntfs/dir.c	Sat May  4 23:12:47 2002
+++ b/fs/ntfs/dir.c	Sat May  4 23:12:47 2002
@@ -500,7 +500,12 @@
 }
 
 /*
- * VFS calls readdir with BKL held so no possible RACE conditions.
+ * VFS calls readdir without BKL but with i_sem held. This protects the VFS
+ * parts (e.g. ->f_pos and ->i_size, and it also protects against directory
+ * modifications). Together with the rw semaphore taken by the call to
+ * map_mft_record(), the directory is truly locked down so we have a race free
+ * ntfs_readdir() without the BKL. (-:
+ *
  * We use the same basic approach as the old NTFS driver, i.e. we parse the
  * index root entries and then the index allocation entries that are marked
  * as in use in the index bitmap.
@@ -525,7 +530,6 @@
 	u8 *kaddr, *bmp, *index_end;
 	attr_search_context *ctx;
 
-	lock_kernel();
 	ntfs_debug("Entering for inode 0x%Lx, f_pos 0x%Lx.",
 			(unsigned long long)ndir->mft_no, filp->f_pos);
 	rc = err = 0;
@@ -794,7 +798,6 @@
 		ntfs_debug("filldir returned %i, f_pos 0x%Lx, returning 0.",
 				rc, filp->f_pos);
 #endif
-	unlock_kernel();
 	return 0;
 map_page_err_out:
 	ntfs_error(sb, "Reading index allocation data failed.");
@@ -817,7 +820,8 @@
 }
 
 struct file_operations ntfs_dir_ops = {
-	read:			generic_read_dir,	/* Return -EISDIR. */
-	readdir:		ntfs_readdir,		/* Read directory. */
+	llseek:		generic_file_llseek,	/* Seek inside directory. */
+	read:		generic_read_dir,	/* Return -EISDIR. */
+	readdir:	ntfs_readdir,		/* Read directory contents. */
 };
 
diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	Sat May  4 23:12:47 2002
+++ b/fs/ntfs/super.c	Sat May  4 23:12:47 2002
@@ -1126,8 +1126,7 @@
 	down_write(&vol->mftbmp_lock);
 	/*
 	 * Clean up mft bitmap address space. Ignore the _inode_ bit in the
-	 * name of the function... FIXME: What does this do with dirty pages?
-	 * (ask Al Viro)
+	 * name of the function... FIXME: This destroys dirty pages!!! (AIA)
 	 */
 	truncate_inode_pages(&vol->mftbmp_mapping, 0);
 	vol->mftbmp_mapping.a_ops = NULL;
@@ -1493,22 +1492,6 @@
 	vol->sb = sb;
 	vol->upcase = NULL;
 	vol->mft_ino = NULL;
-	init_rwsem(&vol->mftbmp_lock);
-	INIT_LIST_HEAD(&vol->mftbmp_mapping.clean_pages);
-	INIT_LIST_HEAD(&vol->mftbmp_mapping.dirty_pages);
-	INIT_LIST_HEAD(&vol->mftbmp_mapping.locked_pages);
-	vol->mftbmp_mapping.a_ops = NULL;
-	vol->mftbmp_mapping.host = NULL;
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,6)
-	vol->mftbmp_mapping.i_mmap = NULL;
-	vol->mftbmp_mapping.i_mmap_shared = NULL;
-#else
-	INIT_LIST_HEAD(&vol->mftbmp_mapping.i_mmap);
-	INIT_LIST_HEAD(&vol->mftbmp_mapping.i_mmap_shared);
-#endif
-	spin_lock_init(&vol->mftbmp_mapping.i_shared_lock);
-	init_run_list(&vol->mftbmp_rl);
 	vol->mftmirr_ino = NULL;
 	vol->lcnbmp_ino = NULL;
 	init_rwsem(&vol->lcnbmp_lock);
@@ -1519,6 +1502,26 @@
 	vol->on_errors = 0;
 	vol->mft_zone_multiplier = 0;
 	vol->nls_map = NULL;
+	init_rwsem(&vol->mftbmp_lock);
+	init_run_list(&vol->mftbmp_rl);
+
+	/* Initialize the mftbmp address space mapping.  */
+	INIT_RADIX_TREE(&vol->mftbmp_mapping.page_tree, GFP_ATOMIC);
+	rwlock_init(&vol->mftbmp_mapping.page_lock);
+	INIT_LIST_HEAD(&vol->mftbmp_mapping.clean_pages);
+	INIT_LIST_HEAD(&vol->mftbmp_mapping.dirty_pages);
+	INIT_LIST_HEAD(&vol->mftbmp_mapping.locked_pages);
+	INIT_LIST_HEAD(&vol->mftbmp_mapping.io_pages);
+	vol->mftbmp_mapping.nrpages = 0;
+	vol->mftbmp_mapping.a_ops = NULL;
+	vol->mftbmp_mapping.host = NULL;
+	INIT_LIST_HEAD(&vol->mftbmp_mapping.i_mmap);
+	INIT_LIST_HEAD(&vol->mftbmp_mapping.i_mmap_shared);
+	spin_lock_init(&vol->mftbmp_mapping.i_shared_lock);
+	vol->mftbmp_mapping.dirtied_when = 0;
+	vol->mftbmp_mapping.gfp_mask = GFP_HIGHUSER;
+	vol->mftbmp_mapping.ra_pages =
+			sb->s_bdev->bd_inode->i_mapping->ra_pages;
 
 	/*
 	 * Default is group and other don't have any access to files or

