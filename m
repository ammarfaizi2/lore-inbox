Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbUDWUFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUDWUFy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 16:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbUDWUFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 16:05:54 -0400
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:44487 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261232AbUDWUDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 16:03:42 -0400
Date: Fri, 23 Apr 2004 21:03:41 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH-2.6.6-rc2-bk] NTFS 2.1.7 release: Implement NFS exporting
Message-ID: <Pine.SOL.4.58.0404232055210.15465@orange.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

	bk pull http://linux-ntfs.bkbits.net/ntfs-2.6

Thanks!  This update implements NFS exporting of mounted NTFS volumes
which people have been requesting for a while.  Also, there are some minor
updates and white space cleanups.  This has been tested including forcing
a server reboot while clients have open files on an NTFS volume NFS
exported by the server.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

This will update the following files:

 Documentation/filesystems/ntfs.txt |    2
 fs/ntfs/ChangeLog                  |   27 +++
 fs/ntfs/Makefile                   |    4
 fs/ntfs/aops.c                     |   25 +--
 fs/ntfs/attrib.c                   |    9 -
 fs/ntfs/dir.c                      |    8 -
 fs/ntfs/inode.c                    |   35 +++--
 fs/ntfs/layout.h                   |    4
 fs/ntfs/namei.c                    |  250 +++++++++++++++++++++++++++++++------
 fs/ntfs/super.c                    |   48 ++++++-
 fs/ntfs/unistr.c                   |    7 -
 11 files changed, 338 insertions(+), 81 deletions(-)

through these ChangeSets:

<aia21@cantab.net> (04/02/08 1.1557.9.1)
   NTFS: Set i_generation in VFS inode from seq_no in NTFS inode.

<aia21@cantab.net> (04/02/09 1.1557.17.2)
   NTFS: Make ntfs_lookup() NFS export safe, i.e. use d_splice_alias(), etc.

<aia21@cantab.net> (04/02/09 1.1557.17.3)
   NTFS: Make it compile...

<aia21@cantab.net> (04/02/11 1.1557.35.2)
   NTFS: Release 2.1.7 - Enable NFS exporting of mounted NTFS volumes.
   - Implement ntfs_get_parent() and ntfs_get_dentry() as the NTFS specific
     export operations ->get_parent() and ->get_dentry() respectively.

<aia21@cantab.net> (04/02/12 1.1557.5.73)
   NTFS: Add missing return -EOPNOTSUPP; in fs/ntfs/aops.c::ntfs_commit_nonresident_write().

<aia21@cantab.net> (04/02/26 1.1608.20.1)
   NTFS: Fix off by one error in ntfs_get_parent().

<aia21@cantab.net> (04/03/15 1.1630.6.2)
   NTFS: Enforce no atime and no dir atime updates at mount/remount time
   as they are not implemented yet anyway.

<aia21@cantab.net> (04/04/23 1.1907)
   NTFS: Move a few assignments after a NULL check in fs/ntfs/attrib.c.

<aia21@cantab.net> (04/04/23 1.1908)
   NTFS: Finally fix NFS exporting of mounted NTFS volumes by checking the
   return of d_splice_alias() and acting accordingly rather than just
   ignoring the returned dentry.

the combined GNU diff -urNp:

diff -urNp linux-2.6.6-rc2-bk/Documentation/filesystems/ntfs.txt linux-2.6.6-rc2-bk-ntfs-2.1.7/Documentation/filesystems/ntfs.txt
--- linux-2.6.6-rc2-bk/Documentation/filesystems/ntfs.txt	2004-04-23 20:14:43.100894872 +0100
+++ linux-2.6.6-rc2-bk-ntfs-2.1.7/Documentation/filesystems/ntfs.txt	2004-04-23 20:21:39.545585656 +0100
@@ -272,6 +272,8 @@ ChangeLog

 Note, a technical ChangeLog aimed at kernel hackers is in fs/ntfs/ChangeLog.

+2.1.7:
+	- Enable NFS exporting of mounted NTFS volumes.
 2.1.6:
 	- Fix minor bug in handling of compressed directories that fixes the
 	  erroneous "du" and "stat" output people reported.
diff -urNp linux-2.6.6-rc2-bk/fs/ntfs/aops.c linux-2.6.6-rc2-bk-ntfs-2.1.7/fs/ntfs/aops.c
--- linux-2.6.6-rc2-bk/fs/ntfs/aops.c	2004-04-23 20:15:49.588787176 +0100
+++ linux-2.6.6-rc2-bk-ntfs-2.1.7/fs/ntfs/aops.c	2004-04-23 20:22:02.994020952 +0100
@@ -1,8 +1,8 @@
 /**
  * aops.c - NTFS kernel address space operations and page cache handling.
- * 	    Part of the Linux-NTFS project.
+ *	    Part of the Linux-NTFS project.
  *
- * Copyright (c) 2001-2003 Anton Altaparmakov
+ * Copyright (c) 2001-2004 Anton Altaparmakov
  * Copyright (c) 2002 Richard Russon
  *
  * This program/include file is free software; you can redistribute it and/or
@@ -10,13 +10,13 @@
  * by the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
  *
- * This program/include file is distributed in the hope that it will be
- * useful, but WITHOUT ANY WARRANTY; without even the implied warranty
+ * This program/include file is distributed in the hope that it will be
+ * useful, but WITHOUT ANY WARRANTY; without even the implied warranty
  * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
- * along with this program (in the main directory of the Linux-NTFS
+ * along with this program (in the main directory of the Linux-NTFS
  * distribution in the file COPYING); if not, write to the Free Software
  * Foundation,Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
@@ -572,11 +572,11 @@ static int ntfs_write_block(struct write
 				// Again for each page do:
 				// - wait_on_page_locked()
 				// - Check (PageUptodate(page) &&
-				// 			!PageError(page))
+				//			!PageError(page))
 				// Update initialized size in the attribute and
 				// in the inode.
 				// Again, for each page do:
-				// 	__set_page_dirty_buffers();
+				//	__set_page_dirty_buffers();
 				// page_cache_release()
 				// We don't need to wait on the writes.
 				// Update iblock.
@@ -1112,11 +1112,11 @@ static int ntfs_prepare_nonresident_writ
 				// Again for each page do:
 				// - wait_on_page_locked()
 				// - Check (PageUptodate(page) &&
-				// 			!PageError(page))
+				//			!PageError(page))
 				// Update initialized size in the attribute and
 				// in the inode.
 				// Again, for each page do:
-				// 	__set_page_dirty_buffers();
+				//	__set_page_dirty_buffers();
 				// page_cache_release()
 				// We don't need to wait on the writes.
 				// Update iblock.
@@ -1188,7 +1188,7 @@ lock_retry_remap:
 					// TODO: Instantiate the hole.
 					// clear_buffer_new(bh);
 					// unmap_underlying_metadata(bh->b_bdev,
-					// 		bh->b_blocknr);
+					//		bh->b_blocknr);
 					// For non-uptodate buffers, need to
 					// zero out the region outside the
 					// request in this bh or all bhs,
@@ -1279,7 +1279,7 @@ lock_retry_remap:
 		if (PageUptodate(page)) {
 			if (!buffer_uptodate(bh))
 				set_buffer_uptodate(bh);
-			continue;
+			continue;
 		}
 		/*
 		 * The page is not uptodate. The buffer is mapped. If it is not
@@ -1525,6 +1525,7 @@ static int ntfs_commit_nonresident_write
 	if (pos > vi->i_size) {
 		ntfs_error(vi->i_sb, "Writing beyond the existing file size is "
 				"not supported yet. Sorry.");
+		return -EOPNOTSUPP;
 		// vi->i_size = pos;
 		// mark_inode_dirty(vi);
 	}
@@ -1708,7 +1709,7 @@ static int ntfs_commit_write(struct file
 		/*
 		 * Bring the out of bounds area(s) uptodate by copying data
 		 * from the mft record to the page.
-	 	 */
+		 */
 		if (from > 0)
 			memcpy(kaddr, kattr, from);
 		if (to < bytes)
diff -urNp linux-2.6.6-rc2-bk/fs/ntfs/attrib.c linux-2.6.6-rc2-bk-ntfs-2.1.7/fs/ntfs/attrib.c
--- linux-2.6.6-rc2-bk/fs/ntfs/attrib.c	2004-04-23 20:16:52.395239144 +0100
+++ linux-2.6.6-rc2-bk-ntfs-2.1.7/fs/ntfs/attrib.c	2004-04-23 20:22:43.383880760 +0100
@@ -1235,11 +1235,11 @@ int load_attribute_list(ntfs_volume *vol
 	u8 *al_end = al + initialized_size;
 	run_list_element *rl;
 	struct buffer_head *bh;
-	struct super_block *sb = vol->sb;
-	unsigned long block_size = sb->s_blocksize;
+	struct super_block *sb;
+	unsigned long block_size;
 	unsigned long block, max_block;
 	int err = 0;
-	unsigned char block_size_bits = sb->s_blocksize_bits;
+	unsigned char block_size_bits;

 	ntfs_debug("Entering.");
 	if (!vol || !run_list || !al || size <= 0 || initialized_size < 0 ||
@@ -1249,6 +1249,9 @@ int load_attribute_list(ntfs_volume *vol
 		memset(al, 0, size);
 		return 0;
 	}
+	sb = vol->sb;
+	block_size = sb->s_blocksize;
+	block_size_bits = sb->s_blocksize_bits;
 	down_read(&run_list->lock);
 	rl = run_list->rl;
 	/* Read all clusters specified by the run list one run at a time. */
diff -urNp linux-2.6.6-rc2-bk/fs/ntfs/ChangeLog linux-2.6.6-rc2-bk-ntfs-2.1.7/fs/ntfs/ChangeLog
--- linux-2.6.6-rc2-bk/fs/ntfs/ChangeLog	2004-04-23 20:13:59.842471152 +0100
+++ linux-2.6.6-rc2-bk-ntfs-2.1.7/fs/ntfs/ChangeLog	2004-04-23 20:21:10.812953680 +0100
@@ -1,6 +1,5 @@
 ToDo:
 	- Find and fix bugs.
-	- Enable NFS exporting of NTFS.
 	- Implement aops->set_page_dirty() in order to take control of buffer
 	  dirtying. Not having it means if page_has_buffers(), all buffers
 	  will be dirtied with the page. And if not they won't be. That is
@@ -20,6 +19,26 @@ ToDo:
 	  sufficient for synchronisation here. We then just need to make sure
 	  ntfs_readpage/writepage/truncate interoperate properly with us.

+2.1.7 - Enable NFS exporting of mounted NTFS volumes.
+
+	- Set i_generation in the VFS inode from the seq_no of the NTFS inode.
+	- Make ntfs_lookup() NFS export safe, i.e. use d_splice_alias(), etc.
+	- Implement ->get_dentry() in fs/ntfs/namei.c::ntfs_get_dentry() as the
+	  default doesn't allow inode number 0 which is a valid inode on NTFS
+	  and even if it did allow that it uses iget() instead of ntfs_iget()
+	  which makes it useless for us.
+	- Implement ->get_parent() in fs/ntfs/namei.c::ntfs_get_parent() as the
+	  default just returns -EACCES which is not very useful.
+	- Define export operations (->s_export_op) for NTFS (ntfs_export_ops)
+	  and set them up in the super block at mount time (super.c) this
+	  allows mounted NTFS volumes to be exported via NFS.
+	- Add missing return -EOPNOTSUPP; in
+	  fs/ntfs/aops.c::ntfs_commit_nonresident_write().
+	- Enforce no atime and no dir atime updates at mount/remount time as
+	  they are not implemented yet anyway.
+	- Move a few assignments in fs/ntfs/attrib.c::load_attribute_list() to
+	  after a NULL check.  Thanks to Dave Jones for pointing this out.
+
 2.1.6 - Fix minor bug in handling of compressed directories.

 	- Fix bug in handling of compressed directories.  A compressed
@@ -60,6 +79,10 @@ ToDo:
 	- Reduce function local stack usage from 0x3d4 bytes to just noise in
 	  fs/ntfs/upcase.c. (Randy Dunlap <rddunlap@osdl.ord>)
 	- Remove compiler warnings for newer gcc.
+	- Pages are no longer kmapped by mm/filemap.c::generic_file_write()
+	  around calls to ->{prepare,commit}_write.  Adapt NTFS appropriately
+	  in fs/ntfs/aops.c::ntfs_prepare_nonresident_write() by using
+	  kmap_atomic(KM_USER0).

 2.1.0 - First steps towards write support: implement file overwrite.

diff -urNp linux-2.6.6-rc2-bk/fs/ntfs/dir.c linux-2.6.6-rc2-bk-ntfs-2.1.7/fs/ntfs/dir.c
--- linux-2.6.6-rc2-bk/fs/ntfs/dir.c	2004-04-23 20:14:02.513065160 +0100
+++ linux-2.6.6-rc2-bk-ntfs-2.1.7/fs/ntfs/dir.c	2004-04-23 20:21:20.101541600 +0100
@@ -1,7 +1,7 @@
 /**
  * dir.c - NTFS kernel directory operations. Part of the Linux-NTFS project.
  *
- * Copyright (c) 2001-2003 Anton Altaparmakov
+ * Copyright (c) 2001-2004 Anton Altaparmakov
  * Copyright (c) 2002 Richard Russon
  *
  * This program/include file is free software; you can redistribute it and/or
@@ -200,7 +200,8 @@ found_it:
 						"and if that doesn't find any "
 						"errors please report you saw "
 						"this message to "
-						"linux-ntfs-dev@lists.sf.net.");
+						"linux-ntfs-dev@lists."
+						"sourceforge.net.");
 				goto dir_err_out;
 			}

@@ -457,7 +458,8 @@ found_it2:
 						"and if that doesn't find any "
 						"errors please report you saw "
 						"this message to "
-						"linux-ntfs-dev@lists.sf.net.");
+						"linux-ntfs-dev@lists."
+						"sourceforge.net.");
 				ntfs_unmap_page(page);
 				goto dir_err_out;
 			}
diff -urNp linux-2.6.6-rc2-bk/fs/ntfs/inode.c linux-2.6.6-rc2-bk-ntfs-2.1.7/fs/ntfs/inode.c
--- linux-2.6.6-rc2-bk/fs/ntfs/inode.c	2004-04-23 20:16:13.117210312 +0100
+++ linux-2.6.6-rc2-bk-ntfs-2.1.7/fs/ntfs/inode.c	2004-04-23 20:22:15.165170656 +0100
@@ -196,7 +196,7 @@ struct inode *ntfs_iget(struct super_blo
 	}
 	/*
 	 * There is no point in keeping bad inodes around if the failure was
-	 * due to ENOMEM. We want to be able to retry again layer.
+	 * due to ENOMEM. We want to be able to retry again later.
 	 */
 	if (err == -ENOMEM) {
 		iput(vi);
@@ -533,7 +533,7 @@ static int ntfs_read_locked_inode(struct
 	}

 	/* Transfer information from mft record into vfs and ntfs inodes. */
-	ni->seq_no = le16_to_cpu(m->sequence_number);
+	vi->i_generation = ni->seq_no = le16_to_cpu(m->sequence_number);

 	/*
 	 * FIXME: Keep in mind that link_count is two for files which have both
@@ -1109,7 +1109,7 @@ static int ntfs_read_locked_attr_inode(s
 	vi->i_mtime	= base_vi->i_mtime;
 	vi->i_ctime	= base_vi->i_ctime;
 	vi->i_atime	= base_vi->i_atime;
-	ni->seq_no	= base_ni->seq_no;
+	vi->i_generation = ni->seq_no = base_ni->seq_no;

 	/* Set inode type to zero but preserve permissions. */
 	vi->i_mode	= base_vi->i_mode & ~S_IFMT;
@@ -1137,7 +1137,8 @@ static int ntfs_read_locked_attr_inode(s
 					"the attribute is resident (mft_no "
 					"0x%lx, type 0x%x, name_len %i). "
 					"Please report you saw this message "
-					"to linux-ntfs-dev@lists.sf.net",
+					"to linux-ntfs-dev@lists."
+					"sourceforge.net",
 					vi->i_ino, ni->type, ni->name_len);
 			goto unm_err_out;
 		}
@@ -1157,8 +1158,9 @@ static int ntfs_read_locked_attr_inode(s
 						"type 0x%x, name_len %i). "
 						"Please report you saw this "
 						"message to linux-ntfs-dev@"
-						"lists.sf.net", vi->i_ino,
-						ni->type, ni->name_len);
+						"lists.sourceforge.net",
+						vi->i_ino, ni->type,
+						ni->name_len);
 				goto unm_err_out;
 			}
 			NInoSetCompressed(ni);
@@ -1169,7 +1171,8 @@ static int ntfs_read_locked_attr_inode(s
 						"(mft_no 0x%lx, type 0x%x, "
 						"name_len %i). Please report "
 						"you saw this message to "
-						"linux-ntfs-dev@lists.sf.net",
+						"linux-ntfs-dev@lists."
+						"sourceforge.net",
 						vi->i_ino, ni->type,
 						ni->name_len);
 				goto unm_err_out;
@@ -1224,8 +1227,9 @@ static int ntfs_read_locked_attr_inode(s
 						"type 0x%x, name_len %i). "
 						"Please report you saw this "
 						"message to linux-ntfs-dev@"
-						"lists.sf.net", vi->i_ino,
-						ni->type, ni->name_len);
+						"lists.sourceforge.net",
+						vi->i_ino, ni->type,
+						ni->name_len);
 				goto unm_err_out;
 			}
 			NInoSetEncrypted(ni);
@@ -1238,8 +1242,9 @@ static int ntfs_read_locked_attr_inode(s
 						"type 0x%x, name_len %i). "
 						"Please report you saw this "
 						"message to linux-ntfs-dev@"
-						"lists.sf.net", vi->i_ino,
-						ni->type, ni->name_len);
+						"lists.sourceforge.net",
+						vi->i_ino, ni->type,
+						ni->name_len);
 				goto unm_err_out;
 			}
 			NInoSetSparse(ni);
@@ -1414,7 +1419,7 @@ void ntfs_read_inode_mount(struct inode
 	}

 	/* Need this to sanity check attribute list references to $MFT. */
-	ni->seq_no = le16_to_cpu(m->sequence_number);
+	vi->i_generation = ni->seq_no = le16_to_cpu(m->sequence_number);

 	/* Provides readpage() and sync_page() for map_mft_record(). */
 	vi->i_mapping->a_ops = &ntfs_mft_aops;
@@ -1541,7 +1546,8 @@ void ntfs_read_inode_mount(struct inode
 						"of $MFT is not in the base "
 						"mft record. Please report "
 						"you saw this message to "
-						"linux-ntfs-dev@lists.sf.net");
+						"linux-ntfs-dev@lists."
+						"sourceforge.net");
 				goto put_err_out;
 			} else {
 				/* Sequence numbers must match. */
@@ -1662,7 +1668,8 @@ void ntfs_read_inode_mount(struct inode
 						"Run chkdsk and if no errors "
 						"are found, please report you "
 						"saw this message to "
-						"linux-ntfs-dev@lists.sf.net");
+						"linux-ntfs-dev@lists."
+						"sourceforge.net");
 				put_attr_search_ctx(ctx);
 				/* Revert to the safe super operations. */
 				sb->s_op = &ntfs_mount_sops;
diff -urNp linux-2.6.6-rc2-bk/fs/ntfs/layout.h linux-2.6.6-rc2-bk-ntfs-2.1.7/fs/ntfs/layout.h
--- linux-2.6.6-rc2-bk/fs/ntfs/layout.h	2004-04-23 20:14:44.597667328 +0100
+++ linux-2.6.6-rc2-bk-ntfs-2.1.7/fs/ntfs/layout.h	2004-04-23 20:21:40.348463600 +0100
@@ -2,7 +2,7 @@
  * layout.h - All NTFS associated on-disk structures. Part of the Linux-NTFS
  *	      project.
  *
- * Copyright (c) 2001-2003 Anton Altaparmakov
+ * Copyright (c) 2001-2004 Anton Altaparmakov
  * Copyright (c) 2002 Richard Russon
  *
  * This program/include file is free software; you can redistribute it and/or
@@ -941,7 +941,7 @@ typedef struct {
 					   modified. */
 /* 18*/	s64 last_mft_change_time;	/* Time this mft record was last
 					   modified. */
-/* 20*/	s64 last_access_time;		/* Last time this mft record was
+/* 20*/	s64 last_access_time;		/* Time this mft record was last
 					   accessed. */
 /* 28*/	s64 allocated_size;		/* Byte size of allocated space for the
 					   data attribute. NOTE: Is a multiple
diff -urNp linux-2.6.6-rc2-bk/fs/ntfs/Makefile linux-2.6.6-rc2-bk-ntfs-2.1.7/fs/ntfs/Makefile
--- linux-2.6.6-rc2-bk/fs/ntfs/Makefile	2004-04-23 20:14:46.906316360 +0100
+++ linux-2.6.6-rc2-bk-ntfs-2.1.7/fs/ntfs/Makefile	2004-04-23 20:21:41.361309624 +0100
@@ -5,7 +5,7 @@ obj-$(CONFIG_NTFS_FS) += ntfs.o
 ntfs-objs := aops.o attrib.o compress.o debug.o dir.o file.o inode.o mft.o \
 	     mst.o namei.o super.o sysctl.o time.o unistr.o upcase.o

-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.6\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.7\"

 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff -urNp linux-2.6.6-rc2-bk/fs/ntfs/namei.c linux-2.6.6-rc2-bk-ntfs-2.1.7/fs/ntfs/namei.c
--- linux-2.6.6-rc2-bk/fs/ntfs/namei.c	2004-04-23 20:15:49.464806024 +0100
+++ linux-2.6.6-rc2-bk-ntfs-2.1.7/fs/ntfs/namei.c	2004-04-23 20:22:02.816048008 +0100
@@ -2,7 +2,7 @@
  * namei.c - NTFS kernel directory inode operations. Part of the Linux-NTFS
  * 	     project.
  *
- * Copyright (c) 2001-2003 Anton Altaparmakov
+ * Copyright (c) 2001-2004 Anton Altaparmakov
  *
  * This program/include file is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as published
@@ -21,6 +21,7 @@
  */

 #include <linux/dcache.h>
+#include <linux/security.h>

 #include "ntfs.h"
 #include "dir.h"
@@ -41,16 +42,17 @@
  * @dir_ino looking for the converted Unicode name. If the name is found in the
  * directory, the corresponding inode is loaded by calling ntfs_iget() on its
  * inode number and the inode is associated with the dentry @dent via a call to
- * d_add().
+ * d_splice_alias().
  *
  * If the name is not found in the directory, a NULL inode is inserted into the
- * dentry @dent. The dentry is then termed a negative dentry.
+ * dentry @dent via a call to d_add(). The dentry is then termed a negative
+ * dentry.
  *
  * Only if an actual error occurs, do we return an error via ERR_PTR().
  *
  * In order to handle the case insensitivity issues of NTFS with regards to the
  * dcache and the dcache requiring only one dentry per directory, we deal with
- * dentry aliases that only differ in case in ->ntfs_lookup() while maintining
+ * dentry aliases that only differ in case in ->ntfs_lookup() while maintaining
  * a case sensitive dcache. This means that we get the full benefit of dcache
  * speed when the file/directory is looked up with the same case as returned by
  * ->ntfs_readdir() but that a lookup for any other case (or for the short file
@@ -70,15 +72,18 @@
  * 1) @dent perfectly matches (i.e. including case) a directory entry with a
  *    file name in the WIN32 or POSIX namespaces. In this case
  *    ntfs_lookup_inode_by_name() will return with name set to NULL and we
- *    just d_add() @dent.
+ *    just d_splice_alias() @dent.
  * 2) @dent matches (not including case) a directory entry with a file name in
  *    the WIN32 namespace. In this case ntfs_lookup_inode_by_name() will return
  *    with name set to point to a kmalloc()ed ntfs_name structure containing
  *    the properly cased little endian Unicode name. We convert the name to the
  *    current NLS code page, search if a dentry with this name already exists
- *    and if so return that instead of @dent. The VFS will then destroy the old
- *    @dent and use the one we returned. If a dentry is not found, we allocate
- *    a new one, d_add() it, and return it as above.
+ *    and if so return that instead of @dent.  At this point things are
+ *    complicated by the possibility of 'disconnected' dentries due to NFS
+ *    which we deal with appropriately (see the code comments).  The VFS will
+ *    then destroy the old @dent and use the one we returned.  If a dentry is
+ *    not found, we allocate a new one, d_splice_alias() it, and return it as
+ *    above.
  * 3) @dent matches either perfectly or not (i.e. we don't care about case) a
  *    directory entry with a file name in the DOS namespace. In this case
  *    ntfs_lookup_inode_by_name() will return with name set to point to a
@@ -88,7 +93,8 @@
  *    name. We then convert the name to the current NLS code page, and proceed
  *    searching for a dentry with this name, etc, as in case 2), above.
  */
-static struct dentry *ntfs_lookup(struct inode *dir_ino, struct dentry *dent, struct nameidata *nd)
+static struct dentry *ntfs_lookup(struct inode *dir_ino, struct dentry *dent,
+		struct nameidata *nd)
 {
 	ntfs_volume *vol = NTFS_SB(dir_ino->i_sb);
 	struct inode *dent_inode;
@@ -120,9 +126,8 @@ static struct dentry *ntfs_lookup(struct
 					dent_ino == FILE_MFT) {
 				/* Perfect WIN32/POSIX match. -- Case 1. */
 				if (!name) {
-					d_add(dent, dent_inode);
 					ntfs_debug("Done.");
-					return NULL;
+					return d_splice_alias(dent_inode, dent);
 				}
 				/*
 				 * We are too indented. Handle imperfect
@@ -132,7 +137,7 @@ static struct dentry *ntfs_lookup(struct
 			}
 			ntfs_error(vol->sb, "Found stale reference to inode "
 					"0x%lx (reference sequence number = "
-					"0x%x, inode sequence number = 0x%x, "
+					"0x%x, inode sequence number = 0x%x), "
 					"returning -EIO. Run chkdsk.",
 					dent_ino, MSEQNO(mref),
 					NTFS_I(dent_inode)->seq_no);
@@ -162,7 +167,7 @@ static struct dentry *ntfs_lookup(struct
 	// TODO: Consider moving this lot to a separate function! (AIA)
 handle_name:
    {
-	struct dentry *real_dent;
+	struct dentry *real_dent, *new_dent;
 	MFT_RECORD *m;
 	attr_search_context *ctx;
 	ntfs_inode *ni = NTFS_I(dent_inode);
@@ -173,8 +178,7 @@ handle_name:
 	if (name->type != FILE_NAME_DOS) {			/* Case 2. */
 		nls_name.len = (unsigned)ntfs_ucstonls(vol,
 				(uchar_t*)&name->name, name->len,
-				(unsigned char**)&nls_name.name,
-				name->len * 3 + 1);
+				(unsigned char**)&nls_name.name, 0);
 		kfree(name);
 	} else /* if (name->type == FILE_NAME_DOS) */ {		/* Case 3. */
 		FILE_NAME_ATTR *fn;
@@ -225,8 +229,7 @@ handle_name:
 		/* Convert the found WIN32 name to current NLS code page. */
 		nls_name.len = (unsigned)ntfs_ucstonls(vol,
 				(uchar_t*)&fn->file_name, fn->file_name_length,
-				(unsigned char**)&nls_name.name,
-				fn->file_name_length * 3 + 1);
+				(unsigned char**)&nls_name.name, 0);

 		put_attr_search_ctx(ctx);
 		unmap_mft_record(ni);
@@ -256,8 +259,12 @@ handle_name:
 			err = -ENOMEM;
 			goto err_out;
 		}
-		d_add(real_dent, dent_inode);
-		return real_dent;
+		new_dent = d_splice_alias(dent_inode, real_dent);
+		if (new_dent)
+			dput(real_dent);
+		else
+			new_dent = real_dent;
+		return new_dent;
 	}
 	kfree(nls_name.name);
 	/* Matching dentry exists, check if it is negative. */
@@ -266,14 +273,54 @@ handle_name:
 		/*
 		 * Already have the inode and the dentry attached, decrement
 		 * the reference count to balance the ntfs_iget() we did
-		 * earlier on.
+		 * earlier on.  We found the dentry using d_lookup() so it
+		 * cannot be disconnected and thus we do not need to worry
+		 * about any NFS/disconnectedness issues here.
 		 */
 		iput(dent_inode);
 		return real_dent;
 	}
-	/* Negative dentry: instantiate it. */
-	d_instantiate(real_dent, dent_inode);
-	return real_dent;
+	/*
+	 * Negative dentry: instantiate it unless the inode is a directory and
+	 * has a 'disconnected' dentry (i.e. IS_ROOT and DCACHE_DISCONNECTED),
+	 * in which case d_move() that in place of the found dentry.
+	 */
+	if (!S_ISDIR(dent_inode->i_mode)) {
+		/* Not a directory; everything is easy. */
+		d_instantiate(real_dent, dent_inode);
+		return real_dent;
+	}
+	spin_lock(&dcache_lock);
+	if (list_empty(&dent_inode->i_dentry)) {
+		/*
+		 * Directory without a 'disconnected' dentry; we need to do
+		 * d_instantiate() by hand because it takes dcache_lock which
+		 * we already hold.
+		 */
+		list_add(&real_dent->d_alias, &dent_inode->i_dentry);
+		real_dent->d_inode = dent_inode;
+		spin_unlock(&dcache_lock);
+		security_d_instantiate(real_dent, dent_inode);
+		return real_dent;
+	}
+	/*
+	 * Directory with a 'disconnected' dentry; get a reference to the
+	 * 'disconnected' dentry.
+	 */
+	new_dent = list_entry(dent_inode->i_dentry.next, struct dentry,
+			d_alias);
+	dget_locked(new_dent);
+	spin_unlock(&dcache_lock);
+	/* Do security vodoo. */
+	security_d_instantiate(real_dent, dent_inode);
+	/* Move new_dent in place of real_dent. */
+	d_move(new_dent, real_dent);
+	/* Balance the ntfs_iget() we did above. */
+	iput(dent_inode);
+	/* Throw away real_dent. */
+	dput(real_dent);
+	/* Use new_dent as the actual dentry. */
+	return new_dent;

 eio_err_out:
 	ntfs_error(vol->sb, "Illegal file name attribute. Run chkdsk.");
@@ -288,10 +335,139 @@ err_out:
    }
 }

-/*
+/**
  * Inode operations for directories.
  */
 struct inode_operations ntfs_dir_inode_ops = {
 	.lookup	= ntfs_lookup,	/* VFS: Lookup directory. */
 };

+/**
+ * ntfs_get_parent - find the dentry of the parent of a given directory dentry
+ * @child_dent:		dentry of the directory whose parent directory to find
+ *
+ * Find the dentry for the parent directory of the directory specified by the
+ * dentry @child_dent.  This function is called from
+ * fs/exportfs/expfs.c::find_exported_dentry() which in turn is called from the
+ * default ->decode_fh() which is export_decode_fh() in the same file.
+ *
+ * The code is based on the ext3 ->get_parent() implementation found in
+ * fs/ext3/namei.c::ext3_get_parent().
+ *
+ * Note: ntfs_get_parent() is called with @child_dent->d_inode->i_sem down.
+ *
+ * Return the dentry of the parent directory on success or the error code on
+ * error (IS_ERR() is true).
+ */
+struct dentry *ntfs_get_parent(struct dentry *child_dent)
+{
+	struct inode *vi = child_dent->d_inode;
+	ntfs_inode *ni = NTFS_I(vi);
+	MFT_RECORD *mrec;
+	attr_search_context *ctx;
+	ATTR_RECORD *attr;
+	FILE_NAME_ATTR *fn;
+	struct inode *parent_vi;
+	struct dentry *parent_dent;
+	unsigned long parent_ino;
+
+	ntfs_debug("Entering for inode 0x%lx.", vi->i_ino);
+	/* Get the mft record of the inode belonging to the child dentry. */
+	mrec = map_mft_record(ni);
+	if (unlikely(IS_ERR(mrec)))
+		return (struct dentry *)mrec;
+	/* Find the first file name attribute in the mft record. */
+	ctx = get_attr_search_ctx(ni, mrec);
+	if (unlikely(!ctx)) {
+		unmap_mft_record(ni);
+		return ERR_PTR(-ENOMEM);
+	}
+try_next:
+	if (unlikely(!lookup_attr(AT_FILE_NAME, NULL, 0, IGNORE_CASE, 0,
+			NULL, 0, ctx))) {
+		put_attr_search_ctx(ctx);
+		unmap_mft_record(ni);
+		ntfs_error(vi->i_sb, "Inode 0x%lx does not have a file name "
+				"attribute. Run chkdsk.", vi->i_ino);
+		return ERR_PTR(-ENOENT);
+	}
+	attr = ctx->attr;
+	if (unlikely(attr->non_resident))
+		goto try_next;
+	fn = (FILE_NAME_ATTR *)((u8 *)attr +
+			le16_to_cpu(attr->data.resident.value_offset));
+	if (unlikely((u8 *)fn + le32_to_cpu(attr->data.resident.value_length) >
+			(u8*)attr + le32_to_cpu(attr->length)))
+		goto try_next;
+	/* Get the inode number of the parent directory. */
+	parent_ino = MREF_LE(fn->parent_directory);
+	/* Release the search context and the mft record of the child. */
+	put_attr_search_ctx(ctx);
+	unmap_mft_record(ni);
+	/* Get the inode of the parent directory. */
+	parent_vi = ntfs_iget(vi->i_sb, parent_ino);
+	if (unlikely(IS_ERR(parent_vi) || is_bad_inode(parent_vi))) {
+		if (!IS_ERR(parent_vi))
+			iput(parent_vi);
+		ntfs_error(vi->i_sb, "Failed to get parent directory inode "
+				"0x%lx of child inode 0x%lx.", parent_ino,
+				vi->i_ino);
+		return ERR_PTR(-EACCES);
+	}
+	/* Finally get a dentry for the parent directory and return it. */
+	parent_dent = d_alloc_anon(parent_vi);
+	if (unlikely(!parent_dent)) {
+		iput(parent_vi);
+		return ERR_PTR(-ENOMEM);
+	}
+	ntfs_debug("Done for inode 0x%lx.", vi->i_ino);
+	return parent_dent;
+}
+
+/**
+ * ntfs_get_dentry - find a dentry for the inode from a file handle sub-fragment
+ * @sb:		super block identifying the mounted ntfs volume
+ * @fh:		the file handle sub-fragment
+ *
+ * Find a dentry for the inode given a file handle sub-fragment.  This function
+ * is called from fs/exportfs/expfs.c::find_exported_dentry() which in turn is
+ * called from the default ->decode_fh() which is export_decode_fh() in the
+ * same file.  The code is closely based on the default ->get_dentry() helper
+ * fs/exportfs/expfs.c::get_object().
+ *
+ * The @fh contains two 32-bit unsigned values, the first one is the inode
+ * number and the second one is the inode generation.
+ *
+ * Return the dentry on success or the error code on error (IS_ERR() is true).
+ */
+struct dentry *ntfs_get_dentry(struct super_block *sb, void *fh)
+{
+	struct inode *vi;
+	struct dentry *dent;
+	unsigned long ino = ((u32 *)fh)[0];
+	u32 gen = ((u32 *)fh)[1];
+
+	ntfs_debug("Entering for inode 0x%lx, generation 0x%x.", ino, gen);
+	vi = ntfs_iget(sb, ino);
+	if (unlikely(IS_ERR(vi))) {
+		ntfs_error(sb, "Failed to get inode 0x%lx.", ino);
+		return (struct dentry *)vi;
+	}
+	if (unlikely(is_bad_inode(vi) || vi->i_generation != gen)) {
+		/* We didn't find the right inode. */
+		ntfs_error(sb, "Inode 0x%lx, bad count: %d %d or version 0x%x "
+				"0x%x.", vi->i_ino, vi->i_nlink,
+				atomic_read(&vi->i_count), vi->i_generation,
+				gen);
+		iput(vi);
+		return ERR_PTR(-ESTALE);
+	}
+	/* Now find a dentry.  If possible, get a well-connected one. */
+	dent = d_alloc_anon(vi);
+	if (unlikely(!dent)) {
+		iput(vi);
+		return ERR_PTR(-ENOMEM);
+	}
+	ntfs_debug("Done for inode 0x%lx, generation 0x%x.", ino, gen);
+	return dent;
+}
diff -urNp linux-2.6.6-rc2-bk/fs/ntfs/super.c linux-2.6.6-rc2-bk-ntfs-2.1.7/fs/ntfs/super.c
--- linux-2.6.6-rc2-bk/fs/ntfs/super.c	2004-04-23 20:15:28.881935096 +0100
+++ linux-2.6.6-rc2-bk-ntfs-2.1.7/fs/ntfs/super.c	2004-04-23 20:21:53.621445800 +0100
@@ -1,7 +1,7 @@
 /*
  * super.c - NTFS kernel super block handling. Part of the Linux-NTFS project.
  *
- * Copyright (c) 2001-2003 Anton Altaparmakov
+ * Copyright (c) 2001-2004 Anton Altaparmakov
  * Copyright (c) 2001,2002 Richard Russon
  *
  * This program/include file is free software; you can redistribute it and/or
@@ -323,6 +323,9 @@ static int ntfs_remount(struct super_blo
 			return -EROFS;
 		}
 	}
+	// TODO:  For now we enforce no atime and dir atime updates as they are
+	// not implemented.
+	*flags |= MS_NOATIME | MS_NODIRATIME;
 #endif

 	// FIXME/TODO: If left like this we will have problems with rw->ro and
@@ -1338,6 +1341,40 @@ struct super_operations ntfs_sops = {
 	.show_options	= ntfs_show_options, /* Show mount options in proc. */
 };

+
+/**
+ * Declarations for NTFS specific export operations (fs/ntfs/namei.c).
+ */
+extern struct dentry *ntfs_get_parent(struct dentry *child_dent);
+extern struct dentry *ntfs_get_dentry(struct super_block *sb, void *fh);
+
+/**
+ * Export operations allowing NFS exporting of mounted NTFS partitions.
+ *
+ * We use the default ->decode_fh() and ->encode_fh() for now.  Note that they
+ * use 32 bits to store the inode number which is an unsigned long so on 64-bit
+ * architectures is usually 64 bits so it would all fail horribly on huge
+ * volumes.  I guess we need to define our own encode and decode fh functions
+ * that store 64-bit inode numbers at some point but for now we will ignore the
+ * problem...
+ *
+ * We also use the default ->get_name() helper (used by ->decode_fh() via
+ * fs/exportfs/expfs.c::find_exported_dentry()) as that is completely fs
+ * independent.
+ *
+ * The default ->get_parent() just returns -EACCES so we have to provide our
+ * own and the default ->get_dentry() is incompatible with NTFS due to not
+ * allowing the inode number 0 which is used in NTFS for the system file $MFT
+ * and due to using iget() whereas NTFS needs ntfs_iget().
+ */
+static struct export_operations ntfs_export_ops = {
+	.get_parent	= ntfs_get_parent,	/* Find the parent of a given
+						   directory. */
+	.get_dentry	= ntfs_get_dentry,	/* Find a dentry for the inode
+						   given a file handle
+						   sub-fragment. */
+};
+
 /**
  * ntfs_fill_super - mount an ntfs files system
  * @sb:		super block of ntfs file system to mount
@@ -1366,6 +1403,10 @@ static int ntfs_fill_super(struct super_
 	ntfs_debug("Entering.");
 #ifndef NTFS_RW
 	sb->s_flags |= MS_RDONLY | MS_NOATIME | MS_NODIRATIME;
+#else
+	// TODO:  For now we enforce no atime and dir atime updates as they are
+	// not implemented.
+	sb->s_flags |= MS_NOATIME | MS_NODIRATIME;
 #endif
 	/* Allocate a new ntfs_volume and place it in sb->s_fs_info. */
 	sb->s_fs_info = kmalloc(sizeof(ntfs_volume), GFP_NOFS);
@@ -1544,6 +1585,7 @@ static int ntfs_fill_super(struct super_
 			default_upcase = NULL;
 		}
 		up(&ntfs_lock);
+		sb->s_export_op = &ntfs_export_ops;
 		return 0;
 	}
 	ntfs_error(sb, "Failed to allocate root directory.");
@@ -1788,13 +1830,13 @@ static void __exit exit_ntfs_fs(void)
 		printk(KERN_CRIT "NTFS: This causes memory to leak! There is "
 				"probably a BUG in the driver! Please report "
 				"you saw this message to "
-				"linux-ntfs-dev@lists.sf.net\n");
+				"linux-ntfs-dev@lists.sourceforge.net\n");
 	/* Unregister the ntfs sysctls. */
 	ntfs_sysctl(0);
 }

 MODULE_AUTHOR("Anton Altaparmakov <aia21@cantab.net>");
-MODULE_DESCRIPTION("NTFS 1.2/3.x driver - Copyright (c) 2001-2003 Anton Altaparmakov");
+MODULE_DESCRIPTION("NTFS 1.2/3.x driver - Copyright (c) 2001-2004 Anton Altaparmakov");
 MODULE_LICENSE("GPL");
 #ifdef DEBUG
 MODULE_PARM(debug_msgs, "i");
diff -urNp linux-2.6.6-rc2-bk/fs/ntfs/unistr.c linux-2.6.6-rc2-bk-ntfs-2.1.7/fs/ntfs/unistr.c
--- linux-2.6.6-rc2-bk/fs/ntfs/unistr.c	2004-04-23 20:15:26.274331512 +0100
+++ linux-2.6.6-rc2-bk-ntfs-2.1.7/fs/ntfs/unistr.c	2004-04-23 20:21:53.319491704 +0100
@@ -1,7 +1,7 @@
 /*
  * unistr.c - NTFS Unicode string handling. Part of the Linux-NTFS project.
  *
- * Copyright (c) 2001-2003 Anton Altaparmakov
+ * Copyright (c) 2001-2004 Anton Altaparmakov
  *
  * This program/include file is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as published
@@ -305,8 +305,9 @@ conversion_err:
  * Convert the input little endian, 2-byte Unicode string @ins, of length
  * @ins_len into the string format dictated by the loaded NLS.
  *
- * If @outs is NULL, this function allocates the string and the caller is
- * responsible for calling kfree(@outs); when finished with it.
+ * If *@outs is NULL, this function allocates the string and the caller is
+ * responsible for calling kfree(*@outs); when finished with it. In this case
+ * @outs_len is ignored and can be 0.
  *
  * On success the function returns the number of bytes written to the output
  * string *@outs (>= 0), not counting the terminating NULL byte. If the output

===================================================================

This BitKeeper patch contains the following changesets:
1.1908
## Wrapped with gzip_uu ##


M'XL( ,!6B4   ]56;6_B1A#^C'_%**>3X Z<?;$-IN)TO2.YII>F$;E\1HN]
M!A>SB^QU$E3ZWSMK$Q+@TC116ZE@99W=G7EFGGEFQ!NX+F3>;XA4,.J\@9]T
M8?J-2"@C)JZ2!K=&6N/6\4POY'&11\?*)$6'N8&#9Y?"1#.XD7G1;U"7;W?,
M:BG[C=')E^OS'T>.,QC YYE04WDE#0P&CM'YC<CBXJ,PLTPKU^1"%0MIA!OI
MQ7I[=<T(8?CU:9<3/UC3@'C==41C2H5'94R8UPL\IXK]XT/,NPX\XC%.*67,
M7S,>$.8,@;HT)#T@WC$^C ,-^HSU/?:>T#XAL.\0WC/H$.<3_+-Q?W8BN/AV
M>M6'TU2)+%M!DM[!Q>D5R+NESDVJIJ 36.A2&1E75^%&9^5"%C!90323T=S>
M,3.)GG)IREQ9@WA<++,TDF.1I:)HMD"H&$14^1-1I/,8WQ MQRQDCN9"P6]E
M8=!).E4ZW_C<>$3D6"J3KUSG*S#N!SWG\J&:3N>%'\<A@C@?X-/7=5)46CI6
M8B%3-UK3L$L(Q2\GH1^N"9+(UCVO)[GHAJ'T8Y\(_Z X!VZV-?<9XWR-#KF_
M"UA'?ZZGWX$DP3I.@B04M.L3F?!NXCT-^>!H#]3SJ.]7NC^X:O7_^E@.Q?Y$
M+!@))3[C;,UI+^S5HN?^ON8Y_^\U?[V,A9%63C5-OT(GOZT>E,?E(6.OT-@9
M[P%S&AWX1=]($)#(6Q!%@?)>H)8+2-461AB3IQ,WZO<S+>)Q_6]IY#A+"X/-
M8[33 !")P581<'%]?EYWG@OP#2.<%W@#A@)A?M8*.S/1.2QUJDS=1FD!NC3N
MCA8V2MU3PHO:X&D=[+0!8P'U>$A"5&37#RH5\/ E(N#0H?Q?D<'_9NC5$^0)
ME6[H?H5&AV$ U#G#O\PIC#!I!(7)R\ALH.&=!1AG6L_+97-SE"H=2W@7I_D8
M7]O[%G9M.XW&9KL*#IM-H*^XY0PIZR'DD')BD>NE83\;'O=(M-[&%6*[0FC]
MX Q9P##>,Q9P"-!6R=NQ/8+!7QGG4F3CC8=&(TV@>6_7LOCQLC3-W3LR*Z0]
M>N1_>\&>;P*^/\; >+=*JEX:%76QG)33YM$)*JFJKVW-FD!R]S:[<X_:<)-V
M/J0V3$3%H>';J5$;RSS7>;,^+R9M.#I[L(18HQR5-C 3]7Q),UFQ#4<5H4?;
M,>+"J%0HVWE<S \ />(#?Q+P5*#7V(Z7*;;B4N26!ZR\C+ 95YM,-GAU6-@'
MT2S-XOTL:]M*,=7UQT$,/>I9XNIEA[@A#K3G2!OB#*_,J^5O\=[&?)3$1DRU
MLCN5STK-N%^[Y+5+;LMAY5*J+)W+;-4\NQJ?C$;(4JO5@M]WJ?L.:7N!W]/N
M5:G^89&Z5LV>U]LO_'[)VS 1,41V+/7A;6P?S,K^\KW/XE$I=EFZ?\4<U+R-
FH$&EU'IYEO#GV0HL6]N?WM6$+,K%H)NPL,M]ZOP)C8[7LN0+

This BitKeeper patch contains the following changesets:
1.1907
## Wrapped with gzip_uu ##


M'XL( ,%6B4   [5476^;,!1]QK_B2GU;!?$UA@ 55==V7VK61>GR'!GC!+0$
M*NRDVL2/GR%;LH;M8=5F6[K2]=&YQ_<>^0SF6C6)(TK!D)S!^UJ;Q)&B,B+S
M*F5L:E;7-C4JZHT:Z4:.*K/4+O-"8N^FPL@"=JK1B8.>?\B8KX\J<69OWLTG
MKV>$I"G<%*):J0=E($V)J9N=6.?Z2IAB75>>:42E-\H(3]:;]@!M&:7,[@#'
M/@W"%D/*QZW$'%%P5#EE/ HYZ;5?'34_)^"4,Y]&&&/4,C]$G]P">AC3,5 ^
MLH?Y@"RQAP7G%!-*X900SA%<2J[AW^J^(1+N/[]]2.!CO5,@8*F>0&A=KJJ-
MJHP&L32JL?G[^60"LE#R"Y05+'4_@I$PIBDS3WKD#NS#*"/38Y>)^Y>+$"HH
MN83KN_:T0(OQF%*TVZ=Q$+?4+MZ&F<"<AK&,>"1E'@RZ-N3Y.0U$&@;8\LBV
MI3?'*;+SR(N%#/WP.R%6A%WCP.>\Y3SF<6^+&)^9@H9)@'\T10BN_U],L;?#
MP A'&W0CWW?O$[C-4W_L"*>#1K[ !K?(_ @8^6!C;*.C3;.5!O3V436+;%U;
M%[[2V05QME6G4.5@7[V"_F:ARV_JHN/@#+#CZ.,1*@O1_ )=9*71%QTN0/!M
MK0Q2V-5K][*O< 3:M,YL=B]@7\4YX1EB?M ?OJ6^>7J[29>!5($0$?D.*]IE
%50 %

This BitKeeper patch contains the following changesets:
1.1630.6.2
## Wrapped with gzip_uu ##


M'XL( ,-6B4   ]V676O;,!2&KZU?<:!W*[&/)%O^&"G]W!;ZD9*VUT6UY28L
MMH.E- 3\XZ<XH5F3!MJNV\5L@Y$LWO.><QX)[\&=5G7BR)%DE.S!CTJ;Q$EE
M:>2#6RICIP959:>\854H3]>I5YI<=Y@KB/UV+4TZA"=5Z\2A+G^>,?.)2IS!
MV?>[BZ,!(=TNG QE^:ANE(%NEYBJ?I+C3!]*,QQ7I6MJ6>I"&>FF5=$\+VT8
M(K-W0$..@6BH0#]L4II1*GVJ,F1^)'S2>C]<>WXIX".G 46*@=]0*@(DIT!=
M*CBZPF6 OH?<HP%03 *6\' ?,4&$35'89]!!<@R?Z_V$I'!U^^TF@;,RK^I4
M05F!-*-"@2RSQ2 ;U:N)Z2231FD[@J*:EL:K5?N&Q5>K(S68H9J#K!<J!D;%
M9*P*51J5P=QF(,OY3,Y=<@ZV#H*1ZW532.>=%R$HD1S \7F3ZQ8)3T\GJG;3
MAL8AXJ+@'.,@;M#6P6^D$@KQ ;F2R*(HWJKOELRZ=0'CK/'1CZ*7 9?N+ZK'
M5T*B:+)<Y+&D88 JYV'N[PZY%MH(RFD41RV^6TL7&'_<RS:S.[PPRJR7B(J&
M,11\R2[WM[!E_Q[;/P36XFI%W@CLLA%]Z-2S]K$ 7F_WY ,4][@ 1IS.9V3C
MP-O2^9VG%>T;-+UK*^UFZ<56LAQ9<*@5H&$<^BN2PG>0%/X/)"W/D1TDK0KV
M(8Y8 )PXG@>W_=-^ O"MJJV5&<P4J-?R>R6Y]?G="FTDXA+G2SZ6CQJ:+ES>
MW%_UCVY[EV?0+ >GO4$[_DIZU'8;?+*GQEK];4OZH7.@[]_DZ_GO(!VJ]*>>
1%EW!PR"D3))?3;GS&8<(

This BitKeeper patch contains the following changesets:
1.1608.20.1
## Wrapped with gzip_uu ##


M'XL( ,16B4   [5476L;,1!\MG[%0E[L&M_M2KH/'=BD29JVI+3&:9Z-?"?;
M1VR=N9/3&N['5W%*3.Q22&BU L%*#+,S@\[@KC%UUM&EYL3.X%/5N*R3:^OT
M++#&^=:DJGPK7%9K$S9U'EHW;P8\B)F_&VN7+^'!U$W6H4 \=]QN8[+.Y,/'
MNR_O)XP-AW"YU'9A;HV#X9"YJG[0JZ(YUVZYJFS@:FV;M7$ZR*MU^_RTY8C<
M5T2)P"AN*4:9M#D51%J2*9#+-)9LS_W\P/DE@$3.)2I.%+4\$3%G5T"!ATH#
MC@$!RA!YR&,@F4G*(NHC9HAPC I]@@&R"_BWY"]9#E^_7]]F<%W^A&H^A]D.
M*FO U'550VGA4>_IPKCI1M?&NFXO8#?@)TD%&Q]D98-7+L90(QO!Q4T[;_:F
MAE:O31GD+:D$D7P)5)%JT0_"VU2F1NA$*1,5$>KH1* 3F-_BQR2%0M5*F43Q
M/@M'#Q\3\586I^;_F041%Y($>A8I)?L(B/2%]T)EJ/[F/?T7[U_E^I.$WV!0
M_]AO[^+X6,TW!.%** '$/C\=G7(.W:U=E?=FM>MVMRF\Z\TM]&%E!)^Z:IIO
MMEWM7#T8%=I/7INF+#S%P"NS-=.5L0NW[,'H\#_D2Y/?-]OUD)-2?%8D[!==
'*[3!=P0

This BitKeeper patch contains the following changesets:
1.1557.5.73
## Wrapped with gzip_uu ##


M'XL( ,56B4   [5684_C1A#]'/^*J>Y+N+LXNVNOG02!R 'M(2A$$(1.515M
M[$WB8GNM]08:U?WOG;7#<5Q("ZAG1UYG//-FYNT;R^_@NI1ZT!*)8-1Y!Y]5
M:0:M2.1&3-U<&C1=*H6F[D)ELEOJJ)N;6=EA;N#@LY$PT0+NI"X'+>IZ7RUF
M5<A!Z_+XE^NSX:7C[.W!X4+D<WDE#>SM.4;I.Y'&Y8$PBU3EKM$B+S-IA!NI
MK/KJ6C%"&)Z<AA[A044#XH=51&-*A4]E3)C?"WRGKOW@L>:G #YAE)&^1QBO
MN,^Y[QP!=2GGH<O=T /B=PGK4@:4#'AOX-$/A P(@>]1X0.##G$^P?];_*$3
MP?GXYZL!#.,8LJ0LDWP.6IJESJ%S?#$ZOQA?78]&NY#D,"MK]KM"%:4;#0;V
MSP2S9HF9Y"K7LDQBF9O)O4Z,;.^XSBEP+Z#$&3WR[W1>>3@.$<39AT^GU4/^
M!NQ,S2O:#PFA>'JDS_L5P2.HXEDPZPL:<B)G7CCS-[A\!NAAIRCA/1I4C)'
M>YJT:?JYC,P:A1\R&LO $Y3/MF=<HWR3SO-9Y8?$[]<ZW:C,ZO7MK6^*<VOK
MA'H^97[%^ZP7-B+U-N1)@ZWR#'Z4/*^+6!@)41V:JKF55;,_%]#1]_4/93+:
MY.X-6COQ?&!.J_."<7!:\/J). DY^!9_).:R!*$EY J0J+G4<)N)HI Q3%>0
M9=U9DDHT6-BYS*5.HHDU/6#9]$*K91Y#)-*T1.:AL_]7H66!J!^;(OYNO%W
M?D1AZE$'3*)5H1-D-5U9F&VCO<9ZKA-;X]*28^-MW1-A5)9$[=-?)]=7QY<$
M>_U6SPWN=V)^S4@YXK;(#E09IZ[2\]\>9/;[,Y/ED1[M4^XQWJM\'@:-FOO!
M4S%[ Y]M%3/UH$/9#Y'S2Z0%_ZDCBW.SP#]0%B+"Z4BER)>%G8WF9;)E-AJ6
MWC 81QY0G Z\P'O<<D !:P-J!F8AX2S)EW]V:G&AM/Z0D7&=(VX#>!T AZI8
MZ62^,-".=@#)HAW[VH%A;E0.P]0(%%HF;M6=<X3<,^>$VCG$R/$B*2WH7(NL
MF^11NHPEV#D M,=):70R71H<&F3-EK)0A<0;82 Q<)^D*4REQ5F6<K9,/P(Z
MP\W)^//%]1B&YU_@9GAY.3P??]E%9[-0^%3>R08JR8HT0>1[H7'7S0I+Z]N>
MZBM""CNV=1BZ/U8)[74IF<";.-%(A]*K3:Z0HK!7DU0O+3RZ7;S\9-\-QUHK
MW2[P;F<''7NL=JR7M>-D4DHSL1X33&)6D^ER-L-/H?;.+E:*K_*ZUF;]-VQT
MZ:U=>R]%Q\VK0YJU]0 _773VIY-IJJ+;7#>.?=HXUBNZ12HWR(#<12/WFH3/
G# &&AJSN>;VV6O"^^_C-%RUD=%LNLSW\P.#2E]SY!_=X4=]+"@

This BitKeeper patch contains the following changesets:
1.1557.35.2
## Wrapped with gzip_uu ##


M'XL( ,96B4   [U;>W/;-A+_6_H4J'OI28Y%\R7JD;$GKBWG?+&=C.Q<;Z;I
M<"@2E-A0I(8@)7M._>ZW"X"B2$E^-8Z=,24"6.QB'_CM OF9?&$TZ=><P-&U
M^L_D7S%+^S77B5)GI$0TA5?#.(97AY-X2@]9XAY&J<]:NF+5H>VSD[H3,J<)
MZ]<TQ5B]2>]GM%\;#CY\N3P9UNM'1^1TXD1C>D-3<G143^-D[H0>>^^DDS".
ME#1Q(C:EJ:.X\72YZKK4556'W[;6,=2VM=0LU>PL7<W3-,?4J*?J9M<RZYSW
M]P7/90*FJFN:UC9-55T:;<M2ZV=$4[1VNZ,8;44GJGFHZH>:1G2C;YK]=N>M
MJO95E52IDK<=TE+KOY+OR_QIW277M^<W?3*D(748);JB*3 5&43.**3D^OR&
MT+M9G*1!-":Q3Z9Q%J74XZ/(/ ZS*64*4&F1B^DLI%,:I01U9(]I:L^<!+XW
MFL2)O.*M!^^2>WS+2#JA@A2;43?P Q=($3DCB6<T<=(@CAAI'6_0$Z]6Q!**
M)-)@3L-[I?Z1&*9N].J?"]776\_\J==51ZT?DU\_+L]B-T/1.#>'?A!2=L]2
M.F7<'I7T+EUJO8ZJ:O!KJ+UV;ZG"C[;LM%6+=E1?I];(&QFC#;T^A;(T(U4S
M3%/O+8&DI@FV?-'K4,AX&8^W<6$M/=_R>XX&S%#?Z/CF)A>;A-8FU71SV>[I
MW4YYTBOG&T5^M\RI=98^=;516VMKIJ<:HTV#WB13F1'F4RMB>D&BN-NFTY:^
MVO.[K@]BCL#41\;N^001,9G:TSJJU3:7IFY5)PNBV*/;IS.7(]<S_*[E6EU/
M=7L=??=T.9D\%N@HG;K45+6MER>,G"D-MDZHZ\NNV:6&T^GU:-MKJTY[]X0Y
MF?4)#75IFEVMHD"6@7]MG]!<.M2BJCI2#>JH>K?;VSUA3J:B/ZW3ZY@\^#YN
MXAB5OZ.7;<;DIWJ9IO4T0^^UC:5IJ5V+!VM3RZ.T2C0>I?7>SBBMOU:4_C+S
MG)02/TYDB$Y$P,90)R+")])*%OP?A*[/3UCU%P3$"[UC$KW..>C7:\_=)M :
M-D*-5/X+8]FFKG?%,G!VP^A"K%"[L%YB'S;TLFZUOF[NU"WT:>D_7KD\\E:4
MNR'C"W1Y9A!8!1W_7O"_+]OZ+W2+]- 4BOV_LC,'$:D$IWY_%QBHUPCQJ.]D
M84J\F++HGREQPC!>$!Y(291-1S0A*EE, D!Z 2,. 64$GFR/(\X>DD&,0.<T
M(H%/ J &?02E=.*D^"9CE)$ F. \@F\X'HK)61.OD8R8: J[%).#P),8UU4&
MXF\1?(52'A2\P#(;@O^9L11,(,T21#Z#D]/3P4TA<!2GB'GOD14_"SD+9["%
M1G0+;FJTCIDM7MOQK,G9YOIK<$96+:R9+QD#4P=^IB2;H0 (T'B$)Z,P=K\1
M6#IN!R0-II0T9/!O0K^ <1*XQ&RKK8#CD%'.)+3- P>-K!P6<CA0B0K/ AN[
M8T(%;*A=K<NAN=[MR6C?Z3PG(I"6]L,#@@!&.P)"+N!+XD$7(P'^&?SW=GAB
MGYY?GGRX(4>D=89:M/\S&-Y<?+H^^KK'6?JZ5](;AU45I3T#K^U6V0JO&:II
MJ)H.:NXN3=7HF5Q?5JXOM4>T3E^U^NW=^FJ3EO$J^F(^GX#%6>)2T-J8\O3U
M(Q' <H>RN&@OT92)FL(_9)^<QK/[)!A/4M( -P26M18:-SF)4@B&)V'J0*2!
M\!7/(=BK(MK#0Z_7^,]>&$3978NGU1Z=OP\#EC)E+V^M2*3L-=_!]);*&8#'
MWR"S;CT2)5?LYUD0?+<%E2&X]/G.4M4MLRU@@-I]AA%IL$=JWQ_D/6!$F"SL
MA !2NI>8D::97)'\*36Y!T'Z(5U65;EW@'2X)0 =2R-&81$X;+.[:)X'K>/
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
8=T+=;RR;'M$N7O[PO/K_ 9XAB&J!,@

This BitKeeper patch contains the following changesets:
1.1557.17.3
## Wrapped with gzip_uu ##


M'XL( ,=6B4   [646V_:0!"%G[V_8JJ\$$6L]^I;"TH3>D'I!4'SC+;V$%M@
M.[*7I%']X[N !"HT#XU:KZ619F>/SIY/]AG<MM@DGBF,X.0,/M:M3;S45-9\
MIQ5:UYK6M6OY>5VBWS:I7]E%VQ<T(&YO8FR:PP,V;>)Q*O<=^W2/B3=]]^'V
MT]LI(8,!7.>FNL,96A@,B*V;![/*VDMC\U5=4=N8JBW1&IK69;<?[01CPBW-
M0\ETT/& J;!+><:Y41PS)E04*++U?GGP_+N <@(QES+B82>9$!$9 :=<ZY#R
MD$I@RF?"9S%PE0B1:'W!6,(8'*O"!8<^(U?P;\U?DQ2^?'L_2^"S62(4%IS*
M?;%"2BFY >=8!F1RB(_T__(AA!E&AG!UTRW:+3R_,B46-.UX'#+&W9(LUG''
MG&'112I":<(X1IUI9O1)$"<R^Y"5<'?J>!A%X9;YT>"&_$M=G$)^UH7DL9(=
M5V&@MZAE<,Q81<\REM 7_X4Q(BXI0/DGR+O$OD*_>=R^#MKD.+P7<!\+">Z;
M+JITM<X0WJR*:OW#;S%=-X5]HOF0C$2T&1GOBE<LH/=J-A_/1N-I+\/*SHNJ
MSK _+.:EJ^?G\).,) LW1W;%R^[0SE=UNL2L5^'C?'/J_/7AUY#FF"[;=3E0
/@5X(S1?D%T^IK-1R!

This BitKeeper patch contains the following changesets:
1.1557.17.2
## Wrapped with gzip_uu ##


M'XL( ,A6B4   [U8;7/:2!+^C'[%W&Y=%KQ8S$A" E).V3'96RI9)V4[=Q^N
MKJA!&LRLA8;3C.Q0Q_WWZYX1& SDRKG-V2[ 4K\^3W=/HQ_)9RW*08-+'C#O
M1_*KTF;02'EA^,0OA(%+UTK!I<Y,S45'EVFG,%-]&OBQ!_<^<9/.R(,H]:#!
M_'!SQ2P78M"X?O>7SQ\NKCWO[(Q<SGAQ)VZ$(6=GGE'E \\S?<[-+%>%;TI>
MZ+DPW$_5?+417064!O#;94E(N_&*Q31*5BG+&.,1$QD-HEX<>3;V\Z>8=PU$
M8*#/PK ;]5=A$,74&Q+FLVXW\5GB!X1&'1IT:)^P<!#V!BSYF=(!I>2Y5?)S
M1$ZI]Y;\L<%?>BFYNOWE9D!^X_>"(+CC7*G[:M%LD:M?;HCXLE"E(9I/19M(
M7_BDTH)D8[W(92K&/)=<-UMM(DSJ>^])2(.@YWUZPML[?>&/YU%.O3?D[?O5
M5%NV.P6?"^FG*]9/*&7P&])^M[^BD&&PZD4]$?*DWQ?=K$MY=P^Y/3-/K+!^
M%*Y8E,3=78=5(;4I#WOLKP1G/3 0QV$JD@F-CWO<V-FX9*P'=KIA$H:[+G.^
M5)7Q9P=<LGC58U1$<3\5O9A1SMEQEQL[6[778VP5!*P?[[IT''U0=P=\TGB5
M3>-IG[.D2\4T3*;1<9]/AIXYI3T:,]M_>Z+8A]\>RW[3'8VE!V1!]ZUHP&C/
M-5_(]MJ.'6T[]KW:[O,BXT9 SUB0/I+3\M'^00M\VL?K&_IH%'0)\QJG?TAK
M;Y.XKK%G'+ZLA(]3^+R$D<$(^@Y+N&L9#.C+"&3?D4"2JL6RE'<S@_//M=D1
M,M>)?0.70Z1RA"_DA%RN/9)FVB(0,#M%J,A%851!+G+#%[R<\WOUL$-;/?^>
ML?:BX>J94A69/U_>YV)2:7,^76J_DLHOU-_7 /_CT, -:4(CUJ<Q92M&:2^R
M/(;='1Y9?Q"%1WF, P)I?A<FCS3(?^D,PC4I1"JTYN42R7<GR1'R:S#^C]P/
MHP@5[2MH/@_?!X'$"B0DL *B,.62G.,[>9"<<)+R/ >\09=G&:B0VYE8RTE-
MS$P4Q(AR+C(0+L0=-_)!/-D"%]W0!A_6,3A5&X% ?6Z(*O(ER>1T*DHB"W )
M4,/[Z9M=0AYG,A=DSB54A"QD<><-$VL[J6W#S^]0DOLTV80@E*1/0F_48R2N
MQ7F1$3DE6I%2F*HL7#RRT$;PC*AIK4G(A8%;D.]"@7?\6-QIPDM1VX&R0X\P
M##(R62(J(*FUG,A<FB4:^BF3.E4%5 O(_.1@D ! 5@F$%XJM-@59PO[ZB"#S
MG#Q*,R-\L2C5HI1@'H!J:B&LAU1E^#*?@RT-S%AJ_@I5^RCSO+9F^<D$["#*
MA:7RK.87<\>BME<+@2X=""(#6Z,I\+GAN;96*$.FJBJR-DI#92A,V1+_B#;:
M^]!+T[:>:GPE^%U;XQ/U(( 5%E@6W5L#?YY9P3#&LH!TVS:DUFM0"FU/N#>K
M] /]\N<OT*PH1[3X9R6*%'JZFD^@K,X(WH6C[ =0C9VJ?6L -%5JUJF>E(#Z
M&/]IDQ/(RGY$=TD,+3)B25*[:U:%EG> %4EGO#PY:;TJ<CW&%O?QI4TH1@FK
M,*H%0?]E:EV4'[FWK\*Q"=>JQ4XMQC)O- !EP<M<0OHP(PGYFW#D6<;K?"L-
ME0RL;9H,6D$:IPRC%PF?@/!6[5HVS:S2MD:5K8E"P'6HXD=5EDNG#.166&-+
M+.W.MH$"QB64E*Z@^F>BQ H(D@@;,P"0(TBX<^*AB:MZFM2Q#FQ?PG& ?8"%
M5!4YFL)L'.G0GU"SL@0W"F=,D5D[,X[7#S4@-).=[:.;\?7'C[<VM>'EQ>6O
M[\;#T<WEQZNK=Y>W[X:MMK4#(\DUIQU0V7@.Y0N(U2.#+'(.]0:MC@$YH-<S
M$+0[7@,&3?-/-^/1S7!TO45BJT7^!9AU(&& <BN!UT3 %]NE'3:8F^!ZZ5M+
M4!%;6#2W:G;+[&N0J[MN(P#7_@TEOY %,)[>-U]E*4]GPOZ#"AAB#M]8QF*^
M,$NXO3%W^D:.73J;>!W1PPW>.*LLZ8>Q?HT%LZZ43#GMW41:.#QGR,)$I!R'
M$]!LX&B&.?D4J&/!Z=LQ!.EEH >CS;=7$2&;!1Y9KS;)G[[)7 >UR>'$'&);
MTJZLSK9011$+'Q3?(0 ;6J15"3-__+]15+? +KC'D;T3"'LIX 2U4P\0ABJT
M)@YJK$MR/>$@1T<[WFP> @<VL"\0_,ZT;'MV5EM,,9?Q.(- +!8B:ZYMXYVO
M00:%/U1DC1MY4)E2KLQ?BB58^@UZDFRRVN[*C9:S7;?O6G1WDJ*EMSSG%LI9
MO1A*R VW$!R'67UXN;Y>5*:Y%\GMK%2/A#_RY9YKE'_N[K/>BIN[J<934\$.
M4!-@=>MJ>3J9MM?[]<.&9_O]RYYE'/]6MOTL Y_RA '8"<)5U =]]ZUL^VLU
M&[#>H-O_VM.L\'M^*YM616JDLNM/6LJ%_3Q5I6.S2C6LR[G=@M\3]SCFR-Z^
MSOM;%G>W?[]\<0^I71P 8#@801?6L9-S&*YX<I*KSQ\^M-T^NDERO8RYRH%X
M\=#@]6&/2SSNUG;S*H5>*-A")KFP<.!-%+Z?ED(TG9<6#&O<'*>P9^L9C&P[
M?B04\*APCO$,1&M6?)R#+%R$S4:5]8H 5./J0/VGQ[30]>F]KN9G79Y%O4G*
+O?\ PP6)%/X5

This BitKeeper patch contains the following changesets:
1.1557.9.1
## Wrapped with gzip_uu ##


M'XL( ,E6B4   \66;8_:.!#'7^-/8;5O[EHE>!P[#U14^]RNNM>N8+<]G59"
MQG&6:$E"$[.K5OGPYP38)4!TM[2](PC#.)GQS&_^-B_Q=:'R7D?$@@)ZB=]G
MA>YUI$BU&-NITL8TR#)CZDZR1'6+7'93'146M5UDYBZ%EA-\K_*BUP';>;3H
M;S/5ZPQ.WUU?' X0ZO?Q\42DMVJH-.[WD<[R>S$-BP.A)],LM74NTB)16M@R
M2\K'6TM*"#47!\\AW"W!)<PK)80 @H$*"66^R]"1_5<V36.5W\7J(9;?#]3T
M3MBS!UN%<WLV;?ICQI]/&/.Y4]+ HQXZP6 #YYX=V( )ZQ+:)3X&O\=XC_+7
MA/0(P75]#I[J@E\S;!%TA']N*L=(XH]79\,>KBH5CVY5JG*AXRS%<8H_GPW-
MD(4*1WF6X$)]':59-5$]LIBQT0=LT@) ET\E1]8S7P@10=!;?/2AC(H:>'?A
M["*[+2'P" %S.23@04G,RRW#R(T" 1XG*G*\B&T5;(>C%0WPF<-922@0OQGT
M#W&GHGBJ=L0$KXR4A#$'#BPDSGB;T;:;M8B,D)+Z@>\V(RZ**'<%9.58AD[D
MN]+U0R)-[[1'7+EI!/1,BB[CS8!3\2V;:WNR*Z);^D 4<P.I?!>($- >\='/
M>D@:E)1"P&L%;@&HE+@_8?1O"0,$X-# Z,TEODF_UIM#FE)S>IS]]U*[GH5"
M+S13]=XG;.4/]=M(X'*[8'OHZ)Q2S!"UP?:PA;^<7Z(;U+%VJEM/U*;"*]-2
MY5E4_UI7^DT#ZZK)-Z@^2T+M3)L2>D)*?>.U1NJY3:+,L&PE"MB"7TBT/I%,
M66NRM<A;T*[2VH/LB4D3G5<?IW]>#0Y'QV<7A^^&N(^MDPK2Z//I8'C^Z6/_
MYD5-WS+L;UXTB"TWB0U@S]J!VH$U=J U"=+ #Q82)-X6,*\5F(,MYY< ^Y%S
MKMI,6\ NT]^'*W?<BNQBZ-S'UMO&^OHX-:;EFOIXJL =Z6PD9_/?DMH^5ZE4
MHW2>C%7^^QMT @"T<K@<_]'C6!3F\4=+Y8&!5WM8C#^^IO4N7!T<&VWXO'.I
MO0_7SR6'>)0:+X[9>1;G4MV(P68?TN#_VCBJKJH7UM)6JVSVZ:N L0KB8NB^
MPI2\ZG8*E^&I*/1(2*F*8J3C1+WI=,STE?EFMORXP$FD<:YDEH?X013U[4__
8O>5$R;MBGO0YY8QYW$=_ S#(15S3"P

