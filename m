Return-Path: <linux-kernel-owner+w=401wt.eu-S932155AbXARK0D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbXARK0D (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 05:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbXARK0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 05:26:03 -0500
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:49823 "EHLO
	ppsw-9.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932147AbXARKZ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 05:25:59 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: NTFS
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       ntfs-dev <linux-ntfs-dev@lists.sourceforge.net>,
       Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Thu, 18 Jan 2007 10:25:50 +0000
Message-Id: <1169115951.5408.10.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/aia21/ntfs-2.6.git

This NTFS update fixes the deadlock reported by Sergey Vlasov in
ntfs_put_inode().

The fix was to remove ntfs_put_inode() which should make Christoph
Hellwig (CC:-ed) very happy as he wanted to get rid of ->put_inode
altogether a while ago and NTFS stopped him from doing so and now the
way should be clear for it to happen...  (-:

Please apply.  Thanks!

Diffstat:

 Documentation/filesystems/ntfs.txt |    2 +
 fs/ntfs/ChangeLog                  |    7 ++++
 fs/ntfs/dir.c                      |   45 ++++++++++++++---------
 fs/ntfs/inode.c                    |   69 +++++++-----------------------------
 fs/ntfs/inode.h                    |    6 +---
 fs/ntfs/super.c                    |    7 +---
 6 files changed, 52 insertions(+), 84 deletions(-)

The changeset as an actual patch generated using git format-patch is
included below for non-git users.

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer, http://www.linux-ntfs.org/

--- ChangeSet patch generated with "git format-patch origin" ---

NTFS: 2.1.28 - Fix deadlock reported by Sergey Vlasov due to ntfs_put_inode().

- Fix deadlock in fs/ntfs/inode.c::ntfs_put_inode().  Thanks to Sergey
  Vlasov for the report and detailed analysis of the deadlock.  The fix
  involved getting rid of ntfs_put_inode() altogether and hence NTFS no
  longer has a ->put_inode super operation.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>
---
 Documentation/filesystems/ntfs.txt |    2 +
 fs/ntfs/ChangeLog                  |    7 ++++
 fs/ntfs/dir.c                      |   45 ++++++++++++++---------
 fs/ntfs/inode.c                    |   69 +++++++-----------------------------
 fs/ntfs/inode.h                    |    6 +---
 fs/ntfs/super.c                    |    7 +---
 6 files changed, 52 insertions(+), 84 deletions(-)

diff --git a/Documentation/filesystems/ntfs.txt b/Documentation/filesystems/ntfs.txt
index 13ba649..8177906 100644
--- a/Documentation/filesystems/ntfs.txt
+++ b/Documentation/filesystems/ntfs.txt
@@ -457,6 +457,8 @@ ChangeLog
 
 Note, a technical ChangeLog aimed at kernel hackers is in fs/ntfs/ChangeLog.
 
+2.1.28:
+	- Fix a deadlock.
 2.1.27:
 	- Implement page migration support so the kernel can move memory used
 	  by NTFS files and directories around for management purposes.
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
index 35cc4b1..af4ef80 100644
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -17,6 +17,13 @@ ToDo/Notes:
 	  happen is unclear however so it is worth waiting until someone hits
 	  the problem.
 
+2.1.28 - Fix a deadlock.
+
+	- Fix deadlock in fs/ntfs/inode.c::ntfs_put_inode().  Thanks to Sergey
+	  Vlasov for the report and detailed analysis of the deadlock.  The fix
+	  involved getting rid of ntfs_put_inode() altogether and hence NTFS no
+	  longer has a ->put_inode super operation.
+
 2.1.27 - Various bug fixes and cleanups.
 
 	- Fix two compiler warnings on Alpha.  Thanks to Andrew Morton for
diff --git a/fs/ntfs/dir.c b/fs/ntfs/dir.c
index 8296c29..74f99a6 100644
--- a/fs/ntfs/dir.c
+++ b/fs/ntfs/dir.c
@@ -1,7 +1,7 @@
 /**
  * dir.c - NTFS kernel directory operations. Part of the Linux-NTFS project.
  *
- * Copyright (c) 2001-2005 Anton Altaparmakov
+ * Copyright (c) 2001-2007 Anton Altaparmakov
  * Copyright (c) 2002 Richard Russon
  *
  * This program/include file is free software; you can redistribute it and/or
@@ -1249,16 +1249,12 @@ skip_index_root:
 	/* Get the offset into the index allocation attribute. */
 	ia_pos = (s64)fpos - vol->mft_record_size;
 	ia_mapping = vdir->i_mapping;
-	bmp_vi = ndir->itype.index.bmp_ino;
-	if (unlikely(!bmp_vi)) {
-		ntfs_debug("Inode 0x%lx, regetting index bitmap.", vdir->i_ino);
-		bmp_vi = ntfs_attr_iget(vdir, AT_BITMAP, I30, 4);
-		if (IS_ERR(bmp_vi)) {
-			ntfs_error(sb, "Failed to get bitmap attribute.");
-			err = PTR_ERR(bmp_vi);
-			goto err_out;
-		}
-		ndir->itype.index.bmp_ino = bmp_vi;
+	ntfs_debug("Inode 0x%lx, getting index bitmap.", vdir->i_ino);
+	bmp_vi = ntfs_attr_iget(vdir, AT_BITMAP, I30, 4);
+	if (IS_ERR(bmp_vi)) {
+		ntfs_error(sb, "Failed to get bitmap attribute.");
+		err = PTR_ERR(bmp_vi);
+		goto err_out;
 	}
 	bmp_mapping = bmp_vi->i_mapping;
 	/* Get the starting bitmap bit position and sanity check it. */
@@ -1266,7 +1262,7 @@ skip_index_root:
 	if (unlikely(bmp_pos >> 3 >= i_size_read(bmp_vi))) {
 		ntfs_error(sb, "Current index allocation position exceeds "
 				"index bitmap size.");
-		goto err_out;
+		goto iput_err_out;
 	}
 	/* Get the starting bit position in the current bitmap page. */
 	cur_bmp_pos = bmp_pos & ((PAGE_CACHE_SIZE * 8) - 1);
@@ -1282,7 +1278,7 @@ get_next_bmp_page:
 		ntfs_error(sb, "Reading index bitmap failed.");
 		err = PTR_ERR(bmp_page);
 		bmp_page = NULL;
-		goto err_out;
+		goto iput_err_out;
 	}
 	bmp = (u8*)page_address(bmp_page);
 	/* Find next index block in use. */
@@ -1429,6 +1425,7 @@ find_next_index_buffer:
 			/* @ia_page is already unlocked in this case. */
 			ntfs_unmap_page(ia_page);
 			ntfs_unmap_page(bmp_page);
+			iput(bmp_vi);
 			goto abort;
 		}
 	}
@@ -1439,6 +1436,7 @@ unm_EOD:
 		ntfs_unmap_page(ia_page);
 	}
 	ntfs_unmap_page(bmp_page);
+	iput(bmp_vi);
 EOD:
 	/* We are finished, set fpos to EOD. */
 	fpos = i_size + vol->mft_record_size;
@@ -1455,8 +1453,11 @@ done:
 	filp->f_pos = fpos;
 	return 0;
 err_out:
-	if (bmp_page)
+	if (bmp_page) {
 		ntfs_unmap_page(bmp_page);
+iput_err_out:
+		iput(bmp_vi);
+	}
 	if (ia_page) {
 		unlock_page(ia_page);
 		ntfs_unmap_page(ia_page);
@@ -1529,14 +1530,22 @@ static int ntfs_dir_open(struct inode *vi, struct file *filp)
 static int ntfs_dir_fsync(struct file *filp, struct dentry *dentry,
 		int datasync)
 {
-	struct inode *vi = dentry->d_inode;
-	ntfs_inode *ni = NTFS_I(vi);
+	struct inode *bmp_vi, *vi = dentry->d_inode;
 	int err, ret;
+	ntfs_attr na;
 
 	ntfs_debug("Entering for inode 0x%lx.", vi->i_ino);
 	BUG_ON(!S_ISDIR(vi->i_mode));
-	if (NInoIndexAllocPresent(ni) && ni->itype.index.bmp_ino)
-		write_inode_now(ni->itype.index.bmp_ino, !datasync);
+	/* If the bitmap attribute inode is in memory sync it, too. */
+	na.mft_no = vi->i_ino;
+	na.type = AT_BITMAP;
+	na.name = I30;
+	na.name_len = 4;
+	bmp_vi = ilookup5(vi->i_sb, vi->i_ino, (test_t)ntfs_test_inode, &na);
+	if (bmp_vi) {
+ 		write_inode_now(bmp_vi, !datasync);
+		iput(bmp_vi);
+	}
 	ret = ntfs_write_inode(vi, 1);
 	write_inode_now(vi, !datasync);
 	err = sync_blockdev(vi->i_sb->s_bdev);
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 2479898..f8bf8da 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -1,7 +1,7 @@
 /**
  * inode.c - NTFS kernel inode handling. Part of the Linux-NTFS project.
  *
- * Copyright (c) 2001-2006 Anton Altaparmakov
+ * Copyright (c) 2001-2007 Anton Altaparmakov
  *
  * This program/include file is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as published
@@ -95,7 +95,7 @@ int ntfs_test_inode(struct inode *vi, ntfs_attr *na)
  * If initializing the normal file/directory inode, set @na->type to AT_UNUSED.
  * In that case, @na->name and @na->name_len should be set to NULL and 0,
  * respectively. Although that is not strictly necessary as
- * ntfs_read_inode_locked() will fill them in later.
+ * ntfs_read_locked_inode() will fill them in later.
  *
  * Return 0 on success and -errno on error.
  *
@@ -171,8 +171,8 @@ static int ntfs_read_locked_index_inode(struct inode *base_vi,
 struct inode *ntfs_iget(struct super_block *sb, unsigned long mft_no)
 {
 	struct inode *vi;
-	ntfs_attr na;
 	int err;
+	ntfs_attr na;
 
 	na.mft_no = mft_no;
 	na.type = AT_UNUSED;
@@ -229,8 +229,8 @@ struct inode *ntfs_attr_iget(struct inode *base_vi, ATTR_TYPE type,
 		ntfschar *name, u32 name_len)
 {
 	struct inode *vi;
-	ntfs_attr na;
 	int err;
+	ntfs_attr na;
 
 	/* Make sure no one calls ntfs_attr_iget() for indices. */
 	BUG_ON(type == AT_INDEX_ALLOCATION);
@@ -287,8 +287,8 @@ struct inode *ntfs_index_iget(struct inode *base_vi, ntfschar *name,
 		u32 name_len)
 {
 	struct inode *vi;
-	ntfs_attr na;
 	int err;
+	ntfs_attr na;
 
 	na.mft_no = base_vi->i_ino;
 	na.type = AT_INDEX_ALLOCATION;
@@ -402,7 +402,6 @@ void __ntfs_init_inode(struct super_block *sb, ntfs_inode *ni)
 	ntfs_init_runlist(&ni->attr_list_rl);
 	lockdep_set_class(&ni->attr_list_rl.lock,
 				&attr_list_rl_lock_class);
-	ni->itype.index.bmp_ino = NULL;
 	ni->itype.index.block_size = 0;
 	ni->itype.index.vcn_size = 0;
 	ni->itype.index.collation_rule = 0;
@@ -546,6 +545,7 @@ static int ntfs_read_locked_inode(struct inode *vi)
 {
 	ntfs_volume *vol = NTFS_SB(vi->i_sb);
 	ntfs_inode *ni;
+	struct inode *bvi;
 	MFT_RECORD *m;
 	ATTR_RECORD *a;
 	STANDARD_INFORMATION *si;
@@ -780,7 +780,6 @@ skip_attr_list_load:
 	 */
 	if (S_ISDIR(vi->i_mode)) {
 		loff_t bvi_size;
-		struct inode *bvi;
 		ntfs_inode *bni;
 		INDEX_ROOT *ir;
 		u8 *ir_end, *index_end;
@@ -985,13 +984,12 @@ skip_attr_list_load:
 			err = PTR_ERR(bvi);
 			goto unm_err_out;
 		}
-		ni->itype.index.bmp_ino = bvi;
 		bni = NTFS_I(bvi);
 		if (NInoCompressed(bni) || NInoEncrypted(bni) ||
 				NInoSparse(bni)) {
 			ntfs_error(vi->i_sb, "$BITMAP attribute is compressed "
 					"and/or encrypted and/or sparse.");
-			goto unm_err_out;
+			goto iput_unm_err_out;
 		}
 		/* Consistency check bitmap size vs. index allocation size. */
 		bvi_size = i_size_read(bvi);
@@ -1000,8 +998,10 @@ skip_attr_list_load:
 			ntfs_error(vi->i_sb, "Index bitmap too small (0x%llx) "
 					"for index allocation (0x%llx).",
 					bvi_size << 3, vi->i_size);
-			goto unm_err_out;
+			goto iput_unm_err_out;
 		}
+		/* No longer need the bitmap attribute inode. */
+		iput(bvi);
 skip_large_dir_stuff:
 		/* Setup the operations for this inode. */
 		vi->i_op = &ntfs_dir_inode_ops;
@@ -1176,7 +1176,8 @@ no_data_attr_special_case:
 		vi->i_blocks = ni->allocated_size >> 9;
 	ntfs_debug("Done.");
 	return 0;
-
+iput_unm_err_out:
+	iput(bvi);
 unm_err_out:
 	if (!err)
 		err = -EIO;
@@ -1697,7 +1698,7 @@ static int ntfs_read_locked_index_inode(struct inode *base_vi, struct inode *vi)
 				vi->i_size);
 		goto iput_unm_err_out;
 	}
-	ni->itype.index.bmp_ino = bvi;
+	iput(bvi);
 skip_large_index_stuff:
 	/* Setup the operations for this index inode. */
 	vi->i_op = NULL;
@@ -1714,7 +1715,6 @@ skip_large_index_stuff:
 
 	ntfs_debug("Done.");
 	return 0;
-
 iput_unm_err_out:
 	iput(bvi);
 unm_err_out:
@@ -2191,37 +2191,6 @@ err_out:
 	return -1;
 }
 
-/**
- * ntfs_put_inode - handler for when the inode reference count is decremented
- * @vi:		vfs inode
- *
- * The VFS calls ntfs_put_inode() every time the inode reference count (i_count)
- * is about to be decremented (but before the decrement itself.
- *
- * If the inode @vi is a directory with two references, one of which is being
- * dropped, we need to put the attribute inode for the directory index bitmap,
- * if it is present, otherwise the directory inode would remain pinned for
- * ever.
- */
-void ntfs_put_inode(struct inode *vi)
-{
-	if (S_ISDIR(vi->i_mode) && atomic_read(&vi->i_count) == 2) {
-		ntfs_inode *ni = NTFS_I(vi);
-		if (NInoIndexAllocPresent(ni)) {
-			struct inode *bvi = NULL;
-			mutex_lock(&vi->i_mutex);
-			if (atomic_read(&vi->i_count) == 2) {
-				bvi = ni->itype.index.bmp_ino;
-				if (bvi)
-					ni->itype.index.bmp_ino = NULL;
-			}
-			mutex_unlock(&vi->i_mutex);
-			if (bvi)
-				iput(bvi);
-		}
-	}
-}
-
 static void __ntfs_clear_inode(ntfs_inode *ni)
 {
 	/* Free all alocated memory. */
@@ -2287,18 +2256,6 @@ void ntfs_clear_big_inode(struct inode *vi)
 {
 	ntfs_inode *ni = NTFS_I(vi);
 
-	/*
-	 * If the inode @vi is an index inode we need to put the attribute
-	 * inode for the index bitmap, if it is present, otherwise the index
-	 * inode would disappear and the attribute inode for the index bitmap
-	 * would no longer be referenced from anywhere and thus it would remain
-	 * pinned for ever.
-	 */
-	if (NInoAttr(ni) && (ni->type == AT_INDEX_ALLOCATION) &&
-			NInoIndexAllocPresent(ni) && ni->itype.index.bmp_ino) {
-		iput(ni->itype.index.bmp_ino);
-		ni->itype.index.bmp_ino = NULL;
-	}
 #ifdef NTFS_RW
 	if (NInoDirty(ni)) {
 		bool was_bad = (is_bad_inode(vi));
diff --git a/fs/ntfs/inode.h b/fs/ntfs/inode.h
index f088291..117eaf8 100644
--- a/fs/ntfs/inode.h
+++ b/fs/ntfs/inode.h
@@ -2,7 +2,7 @@
  * inode.h - Defines for inode structures NTFS Linux kernel driver. Part of
  *	     the Linux-NTFS project.
  *
- * Copyright (c) 2001-2005 Anton Altaparmakov
+ * Copyright (c) 2001-2007 Anton Altaparmakov
  * Copyright (c) 2002 Richard Russon
  *
  * This program/include file is free software; you can redistribute it and/or
@@ -101,8 +101,6 @@ struct _ntfs_inode {
 	runlist attr_list_rl;	/* Run list for the attribute list value. */
 	union {
 		struct { /* It is a directory, $MFT, or an index inode. */
-			struct inode *bmp_ino;	/* Attribute inode for the
-						   index $BITMAP. */
 			u32 block_size;		/* Size of an index block. */
 			u32 vcn_size;		/* Size of a vcn in this
 						   index. */
@@ -300,8 +298,6 @@ extern void ntfs_clear_extent_inode(ntfs_inode *ni);
 
 extern int ntfs_read_inode_mount(struct inode *vi);
 
-extern void ntfs_put_inode(struct inode *vi);
-
 extern int ntfs_show_options(struct seq_file *sf, struct vfsmount *mnt);
 
 #ifdef NTFS_RW
diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 03a391a..babf94d 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -1,7 +1,7 @@
 /*
  * super.c - NTFS kernel super block handling. Part of the Linux-NTFS project.
  *
- * Copyright (c) 2001-2006 Anton Altaparmakov
+ * Copyright (c) 2001-2007 Anton Altaparmakov
  * Copyright (c) 2001,2002 Richard Russon
  *
  * This program/include file is free software; you can redistribute it and/or
@@ -2702,9 +2702,6 @@ static int ntfs_statfs(struct dentry *dentry, struct kstatfs *sfs)
 static struct super_operations ntfs_sops = {
 	.alloc_inode	= ntfs_alloc_big_inode,	  /* VFS: Allocate new inode. */
 	.destroy_inode	= ntfs_destroy_big_inode, /* VFS: Deallocate inode. */
-	.put_inode	= ntfs_put_inode,	  /* VFS: Called just before
-						     the inode reference count
-						     is decreased. */
 #ifdef NTFS_RW
 	//.dirty_inode	= NULL,			/* VFS: Called from
 	//					   __mark_inode_dirty(). */
@@ -3261,7 +3258,7 @@ static void __exit exit_ntfs_fs(void)
 }
 
 MODULE_AUTHOR("Anton Altaparmakov <aia21@cantab.net>");
-MODULE_DESCRIPTION("NTFS 1.2/3.x driver - Copyright (c) 2001-2006 Anton Altaparmakov");
+MODULE_DESCRIPTION("NTFS 1.2/3.x driver - Copyright (c) 2001-2007 Anton Altaparmakov");
 MODULE_VERSION(NTFS_VERSION);
 MODULE_LICENSE("GPL");
 #ifdef DEBUG
-- 
1.5.0.rc1.g936f3


