Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317568AbSGXVIw>; Wed, 24 Jul 2002 17:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317570AbSGXVIv>; Wed, 24 Jul 2002 17:08:51 -0400
Received: from maroon.csi.cam.ac.uk ([131.111.8.2]:1923 "EHLO
	maroon.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S317568AbSGXVIp>; Wed, 24 Jul 2002 17:08:45 -0400
Subject: [BK-PATCH-2.5] NTFS: 2.0.22 - Cleanups, mainly ntfs_readdir(), and use C99 initializers
To: torvalds@transmeta.com (Linus Torvalds)
Date: Wed, 24 Jul 2002 22:11:58 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17XTQM-0003MS-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

	bk pull http://linux-ntfs.bkbits.net/ntfs-tng-2.5

Thanks! Just a small cleanup to ntfs...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

This will update the following files:

 Documentation/filesystems/ntfs.txt |    2 +
 fs/ntfs/ChangeLog                  |    7 +++
 fs/ntfs/Makefile                   |    2 -
 fs/ntfs/aops.c                     |   10 +----
 fs/ntfs/dir.c                      |   72 +++++++++++++++++++------------------
 fs/ntfs/file.c                     |   10 ++---
 fs/ntfs/inode.c                    |   14 ++++---
 fs/ntfs/inode.h                    |    2 -
 fs/ntfs/mft.c                      |   10 ++---
 fs/ntfs/namei.c                    |    2 -
 fs/ntfs/super.c                    |   62 +++++++++++++++----------------
 11 files changed, 102 insertions(+), 91 deletions(-)

through these ChangeSets:

<aia21@cantab.net> (02/07/24 1.432)
   NTFS: 2.0.22 - Cleanups, mainly to ntfs_readdir(), and use C99 initializers.
   - Change fs/ntfs/dir.c::ntfs_reddir() to only read/write ->f_pos once
     at entry/exit respectively.
   - Use C99 initializers for structures.
   - Remove unused variable blocks from fs/ntfs/aops.c::ntfs_read_block().

<aia21@cantab.net> (02/07/24 1.433)
   NTFS: oops... remove leaked one liner from ntfs write tree


diff -Nru a/Documentation/filesystems/ntfs.txt b/Documentation/filesystems/ntfs.txt
--- a/Documentation/filesystems/ntfs.txt	Wed Jul 24 21:57:40 2002
+++ b/Documentation/filesystems/ntfs.txt	Wed Jul 24 21:57:40 2002
@@ -247,6 +247,8 @@
 
 Note, a technical ChangeLog aimed at kernel hackers is in fs/ntfs/ChangeLog.
 
+2.0.22:
+	- Small internal cleanups.
 2.0.21:
 	These only affect 32-bit architectures:
 	- Check for, and refuse to mount too large volumes (maximum is 2TiB).
diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	Wed Jul 24 21:57:40 2002
+++ b/fs/ntfs/ChangeLog	Wed Jul 24 21:57:40 2002
@@ -2,6 +2,13 @@
 	- Find and fix bugs.
 	- Enable NFS exporting of NTFS.
 
+2.0.22 - Cleanups, mainly to ntfs_readdir(), and use C99 initializers.
+
+	- Change fs/ntfs/dir.c::ntfs_reddir() to only read/write ->f_pos once
+	  at entry/exit respectively.
+	- Use C99 initializers for structures.
+	- Remove unused variable blocks from fs/ntfs/aops.c::ntfs_read_block().
+
 2.0.21 - Check for, and refuse to work with too large files/directories/volumes.
 
 	- Limit volume size at mount time to 2TiB on architectures where
diff -Nru a/fs/ntfs/Makefile b/fs/ntfs/Makefile
--- a/fs/ntfs/Makefile	Wed Jul 24 21:57:40 2002
+++ b/fs/ntfs/Makefile	Wed Jul 24 21:57:40 2002
@@ -5,7 +5,7 @@
 ntfs-objs := aops.o attrib.o compress.o debug.o dir.o file.o inode.o mft.o \
 	     mst.o namei.o super.o sysctl.o time.o unistr.o upcase.o
 
-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.0.21\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.0.22\"
 
 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff -Nru a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c	Wed Jul 24 21:57:40 2002
+++ b/fs/ntfs/aops.c	Wed Jul 24 21:57:40 2002
@@ -171,7 +171,7 @@
 	run_list_element *rl;
 	struct buffer_head *bh, *head, *arr[MAX_BUF_PER_PAGE];
 	sector_t iblock, lblock, zblock;
-	unsigned int blocksize, blocks, vcn_ofs;
+	unsigned int blocksize, vcn_ofs;
 	int i, nr;
 	unsigned char blocksize_bits;
 
@@ -187,7 +187,6 @@
 	if (unlikely(!bh))
 		return -ENOMEM;
 
-	blocks = PAGE_CACHE_SIZE >> blocksize_bits;
 	iblock = page->index << (PAGE_CACHE_SHIFT - blocksize_bits);
 	lblock = (ni->allocated_size + blocksize - 1) >> blocksize_bits;
 	zblock = (ni->initialized_size + blocksize - 1) >> blocksize_bits;
@@ -427,11 +426,8 @@
  * ntfs_aops - general address space operations for inodes and attributes
  */
 struct address_space_operations ntfs_aops = {
-	writepage:	NULL,			/* Write dirty page to disk. */
-	readpage:	ntfs_readpage,		/* Fill page with data. */
-	sync_page:	block_sync_page,	/* Currently, just unplugs the
+	.readpage	= ntfs_readpage,	/* Fill page with data. */
+	.sync_page	= block_sync_page,	/* Currently, just unplugs the
 						   disk request queue. */
-	prepare_write:	NULL,			/* . */
-	commit_write:	NULL,			/* . */
 };
 
diff -Nru a/fs/ntfs/dir.c b/fs/ntfs/dir.c
--- a/fs/ntfs/dir.c	Wed Jul 24 21:57:40 2002
+++ b/fs/ntfs/dir.c	Wed Jul 24 21:57:40 2002
@@ -974,7 +974,7 @@
 /**
  * ntfs_filldir - ntfs specific filldir method
  * @vol:	current ntfs volume
- * @filp:	open file descriptor for the current directory
+ * @fpos:	position in the directory
  * @ndir:	ntfs inode of current directory
  * @index_type:	specifies whether @iu is an index root or an index allocation
  * @iu:		index root or index allocation attribute to which @ie belongs
@@ -986,7 +986,7 @@
  * Convert the Unicode @name to the loaded NLS and pass it to the @filldir
  * callback.
  */
-static inline int ntfs_filldir(ntfs_volume *vol, struct file *filp,
+static inline int ntfs_filldir(ntfs_volume *vol, loff_t *fpos,
 		ntfs_inode *ndir, const INDEX_TYPE index_type,
 		index_union iu, INDEX_ENTRY *ie, u8 *name,
 		void *dirent, filldir_t filldir)
@@ -997,12 +997,12 @@
 
 	/* Advance the position even if going to skip the entry. */
 	if (index_type == INDEX_TYPE_ALLOCATION)
-		filp->f_pos = (u8*)ie - (u8*)iu.ia +
+		*fpos = (u8*)ie - (u8*)iu.ia +
 				(sle64_to_cpu(iu.ia->index_block_vcn) <<
 				ndir->_IDM(index_vcn_size_bits)) +
 				vol->mft_record_size;
 	else /* if (index_type == INDEX_TYPE_ROOT) */
-		filp->f_pos = (u8*)ie - (u8*)iu.ir;
+		*fpos = (u8*)ie - (u8*)iu.ir;
 	name_type = ie->key.file_name.file_name_type;
 	if (name_type == FILE_NAME_DOS) {
 		ntfs_debug("Skipping DOS name space entry.");
@@ -1029,11 +1029,11 @@
 		dt_type = DT_DIR;
 	else
 		dt_type = DT_REG;
-	ntfs_debug("Calling filldir for %s with len %i, f_pos 0x%Lx, inode "
-			"0x%lx, DT_%s.", name, name_len, filp->f_pos,
+	ntfs_debug("Calling filldir for %s with len %i, fpos 0x%Lx, inode "
+			"0x%lx, DT_%s.", name, name_len, *fpos,
 			MREF_LE(ie->_IIF(indexed_file)),
 			dt_type == DT_DIR ? "DIR" : "REG");
-	return filldir(dirent, name, name_len, filp->f_pos,
+	return filldir(dirent, name, name_len, *fpos,
 			MREF_LE(ie->_IIF(indexed_file)), dt_type);
 }
 
@@ -1053,6 +1053,7 @@
 static int ntfs_readdir(struct file *filp, void *dirent, filldir_t filldir)
 {
 	s64 ia_pos, ia_start, prev_ia_pos, bmp_pos;
+	loff_t fpos;
 	struct inode *bmp_vi, *vdir = filp->f_dentry->d_inode;
 	struct super_block *sb = vdir->i_sb;
 	ntfs_inode *ndir = NTFS_I(vdir);
@@ -1068,30 +1069,31 @@
 	u8 *kaddr, *bmp, *index_end;
 	attr_search_context *ctx;
 
-	ntfs_debug("Entering for inode 0x%lx, f_pos 0x%Lx.",
-			vdir->i_ino, filp->f_pos);
+	fpos = filp->f_pos;
+	ntfs_debug("Entering for inode 0x%lx, fpos 0x%Lx.",
+			vdir->i_ino, fpos);
 	rc = err = 0;
 	/* Are we at end of dir yet? */
-	if (filp->f_pos >= vdir->i_size + vol->mft_record_size)
+	if (fpos >= vdir->i_size + vol->mft_record_size)
 		goto done;
 	/* Emulate . and .. for all directories. */
-	if (!filp->f_pos) {
-		ntfs_debug("Calling filldir for . with len 1, f_pos 0x0, "
+	if (!fpos) {
+		ntfs_debug("Calling filldir for . with len 1, fpos 0x0, "
 				"inode 0x%lx, DT_DIR.", vdir->i_ino);
-		rc = filldir(dirent, ".", 1, filp->f_pos, vdir->i_ino, DT_DIR);
+		rc = filldir(dirent, ".", 1, fpos, vdir->i_ino, DT_DIR);
 		if (rc)
 			goto done;
-		filp->f_pos++;
+		fpos++;
 	}
-	if (filp->f_pos == 1) {
-		ntfs_debug("Calling filldir for .. with len 2, f_pos 0x1, "
+	if (fpos == 1) {
+		ntfs_debug("Calling filldir for .. with len 2, fpos 0x1, "
 				"inode 0x%lx, DT_DIR.",
 				parent_ino(filp->f_dentry));
-		rc = filldir(dirent, "..", 2, filp->f_pos,
+		rc = filldir(dirent, "..", 2, fpos,
 				parent_ino(filp->f_dentry), DT_DIR);
 		if (rc)
 			goto done;
-		filp->f_pos++;
+		fpos++;
 	}
 
 	/* Get hold of the mft record for the directory. */
@@ -1120,10 +1122,10 @@
 		goto err_out;
 	}
 	/* Are we jumping straight into the index allocation attribute? */
-	if (filp->f_pos >= vol->mft_record_size)
+	if (fpos >= vol->mft_record_size)
 		goto skip_index_root;
 	/* Get the offset into the index root attribute. */
-	ir_pos = (s64)filp->f_pos;
+	ir_pos = (s64)fpos;
 	/* Find the index root attribute in the mft record. */
 	if (unlikely(!lookup_attr(AT_INDEX_ROOT, I30, 4, CASE_SENSITIVE, 0,
 			NULL, 0, ctx))) {
@@ -1158,7 +1160,7 @@
 		if (ir_pos > (u8*)ie - (u8*)ir)
 			continue;
 		/* Submit the name to the filldir callback. */
-		rc = ntfs_filldir(vol, filp, ndir, INDEX_TYPE_ROOT, ir, ie,
+		rc = ntfs_filldir(vol, &fpos, ndir, INDEX_TYPE_ROOT, ir, ie,
 				name, dirent, filldir);
 		if (rc)
 			goto abort;
@@ -1166,13 +1168,13 @@
 	/* If there is no index allocation attribute we are finished. */
 	if (!NInoIndexAllocPresent(ndir))
 		goto EOD;
-	/* Advance f_pos to the beginning of the index allocation. */
-	filp->f_pos = vol->mft_record_size;
+	/* Advance fpos to the beginning of the index allocation. */
+	fpos = vol->mft_record_size;
 skip_index_root:
 	kaddr = NULL;
 	prev_ia_pos = -1LL;
 	/* Get the offset into the index allocation attribute. */
-	ia_pos = (s64)filp->f_pos - vol->mft_record_size;
+	ia_pos = (s64)fpos - vol->mft_record_size;
 	ia_mapping = vdir->i_mapping;
 	bmp_vi = ndir->_IDM(bmp_ino);
 	if (unlikely(!bmp_vi)) {
@@ -1324,7 +1326,7 @@
 		if (ia_pos - ia_start > (u8*)ie - (u8*)ia)
 			continue;
 		/* Submit the name to the filldir callback. */
-		rc = ntfs_filldir(vol, filp, ndir, INDEX_TYPE_ALLOCATION, ia,
+		rc = ntfs_filldir(vol, &fpos, ndir, INDEX_TYPE_ALLOCATION, ia,
 				ie, name, dirent, filldir);
 		if (rc) {
 			ntfs_unmap_page(ia_page);
@@ -1338,8 +1340,8 @@
 		ntfs_unmap_page(ia_page);
 	ntfs_unmap_page(bmp_page);
 EOD:
-	/* We are finished, set f_pos to EOD. */
-	filp->f_pos = vdir->i_size + vol->mft_record_size;
+	/* We are finished, set fpos to EOD. */
+	fpos = vdir->i_size + vol->mft_record_size;
 abort:
 	put_attr_search_ctx(ctx);
 	unmap_mft_record(READ, ndir);
@@ -1347,11 +1349,12 @@
 done:
 #ifdef DEBUG
 	if (!rc)
-		ntfs_debug("EOD, f_pos 0x%Lx, returning 0.", filp->f_pos);
+		ntfs_debug("EOD, fpos 0x%Lx, returning 0.", fpos);
 	else
-		ntfs_debug("filldir returned %i, f_pos 0x%Lx, returning 0.",
-				rc, filp->f_pos);
+		ntfs_debug("filldir returned %i, fpos 0x%Lx, returning 0.",
+				rc, fpos);
 #endif
+	filp->f_pos = fpos;
 	return 0;
 err_out:
 	if (bmp_page)
@@ -1367,6 +1370,7 @@
 	if (!err)
 		err = -EIO;
 	ntfs_debug("Failed. Returning error code %i.", -err);
+	filp->f_pos = fpos;
 	return err;
 }
 
@@ -1396,9 +1400,9 @@
 }
 
 struct file_operations ntfs_dir_ops = {
-	llseek:		generic_file_llseek,	/* Seek inside directory. */
-	read:		generic_read_dir,	/* Return -EISDIR. */
-	readdir:	ntfs_readdir,		/* Read directory contents. */
-	open:		ntfs_dir_open,		/* Open directory. */
+	.llseek		= generic_file_llseek,	/* Seek inside directory. */
+	.read		= generic_read_dir,	/* Return -EISDIR. */
+	.readdir	= ntfs_readdir,		/* Read directory contents. */
+	.open		= ntfs_dir_open,	/* Open directory. */
 };
 
diff -Nru a/fs/ntfs/file.c b/fs/ntfs/file.c
--- a/fs/ntfs/file.c	Wed Jul 24 21:57:40 2002
+++ b/fs/ntfs/file.c	Wed Jul 24 21:57:40 2002
@@ -49,10 +49,11 @@
 }
 
 struct file_operations ntfs_file_ops = {
-	llseek:		generic_file_llseek,	/* Seek inside file. */
-	read:		generic_file_read,	/* Read from file. */
-	mmap:		generic_file_mmap,	/* Mmap file. */
-	open:		ntfs_file_open,		/* Open file. */
+	.llseek	= generic_file_llseek,	/* Seek inside file. */
+	.read	= generic_file_read,	/* Read from file. */
+	.write	= generic_file_write,	/* Write to a file. */
+	.mmap	= generic_file_mmap,	/* Mmap file. */
+	.open	= ntfs_file_open,	/* Open file. */
 };
 
 struct inode_operations ntfs_file_inode_ops = {};
diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	Wed Jul 24 21:57:40 2002
+++ b/fs/ntfs/inode.c	Wed Jul 24 21:57:40 2002
@@ -282,11 +282,12 @@
 	kmem_cache_free(ntfs_big_inode_cache, NTFS_I(inode));
 }
 
-static ntfs_inode *ntfs_alloc_extent_inode(void)
+static inline ntfs_inode *ntfs_alloc_extent_inode(void)
 {
-	ntfs_inode *ni = (ntfs_inode *)kmem_cache_alloc(ntfs_inode_cache,
-			SLAB_NOFS);
+	ntfs_inode *ni;
+
 	ntfs_debug("Entering.");
+	ni = (ntfs_inode *)kmem_cache_alloc(ntfs_inode_cache, SLAB_NOFS);
 	if (likely(ni != NULL)) {
 		ni->state = 0;
 		return ni;
@@ -340,7 +341,7 @@
 	return;
 }
 
-static void ntfs_init_big_inode(struct inode *vi)
+static inline void ntfs_init_big_inode(struct inode *vi)
 {
 	ntfs_inode *ni = NTFS_I(vi);
 
@@ -350,7 +351,8 @@
 	return;
 }
 
-ntfs_inode *ntfs_new_extent_inode(struct super_block *sb, unsigned long mft_no)
+inline ntfs_inode *ntfs_new_extent_inode(struct super_block *sb,
+		unsigned long mft_no)
 {
 	ntfs_inode *ni = ntfs_alloc_extent_inode();
 
@@ -445,7 +447,7 @@
  * ntfs_read_locked_inode - read an inode from its device
  * @vi:		inode to read
  *
- * ntfs_read_locked_inode() is called from the ntfs_iget() to read the inode
+ * ntfs_read_locked_inode() is called from ntfs_iget() to read the inode
  * described by @vi into memory from the device.
  *
  * The only fields in @vi that we need to/can look at when the function is
diff -Nru a/fs/ntfs/inode.h b/fs/ntfs/inode.h
--- a/fs/ntfs/inode.h	Wed Jul 24 21:57:40 2002
+++ b/fs/ntfs/inode.h	Wed Jul 24 21:57:40 2002
@@ -223,7 +223,7 @@
 
 static inline struct inode *VFS_I(ntfs_inode *ni)
 {
-	return &((big_ntfs_inode*)ni)->vfs_inode;
+	return &((big_ntfs_inode *)ni)->vfs_inode;
 }
 
 extern struct inode *ntfs_iget(struct super_block *sb, unsigned long mft_no);
diff -Nru a/fs/ntfs/mft.c b/fs/ntfs/mft.c
--- a/fs/ntfs/mft.c	Wed Jul 24 21:57:40 2002
+++ b/fs/ntfs/mft.c	Wed Jul 24 21:57:40 2002
@@ -107,12 +107,12 @@
  * ntfs_map_page() in map_mft_record_page().
  */
 struct address_space_operations ntfs_mft_aops = {
-	writepage:	NULL,			/* Write dirty page to disk. */
-	readpage:	ntfs_readpage,		/* Fill page with data. */
-	sync_page:	block_sync_page,	/* Currently, just unplugs the
+	.writepage	= NULL,			/* Write dirty page to disk. */
+	.readpage	= ntfs_readpage,	/* Fill page with data. */
+	.sync_page	= block_sync_page,	/* Currently, just unplugs the
 						   disk request queue. */
-	prepare_write:	NULL,			/* . */
-	commit_write:	NULL,			/* . */
+	.prepare_write	= NULL,			/* . */
+	.commit_write	= NULL,			/* . */
 };
 
 /**
diff -Nru a/fs/ntfs/namei.c b/fs/ntfs/namei.c
--- a/fs/ntfs/namei.c	Wed Jul 24 21:57:40 2002
+++ b/fs/ntfs/namei.c	Wed Jul 24 21:57:40 2002
@@ -286,6 +286,6 @@
  * Inode operations for directories.
  */
 struct inode_operations ntfs_dir_inode_ops = {
-	lookup:		ntfs_lookup,	/* VFS: Lookup directory. */
+	.lookup	= ntfs_lookup,	/* VFS: Lookup directory. */
 };
 
diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	Wed Jul 24 21:57:40 2002
+++ b/fs/ntfs/super.c	Wed Jul 24 21:57:40 2002
@@ -1260,38 +1260,38 @@
  * proper functions.
  */
 struct super_operations ntfs_mount_sops = {
-	alloc_inode:	ntfs_alloc_big_inode,	/* VFS: Allocate a new inode. */
-	destroy_inode:	ntfs_destroy_big_inode,	/* VFS: Deallocate an inode. */
-	read_inode:	ntfs_read_inode_mount,	/* VFS: Load inode from disk,
-						   called from iget(). */
-	clear_inode:	ntfs_clear_big_inode,	/* VFS: Called when an inode is
-						   removed from memory. */
+	.alloc_inode	= ntfs_alloc_big_inode,	  /* VFS: Allocate new inode. */
+	.destroy_inode	= ntfs_destroy_big_inode, /* VFS: Deallocate inode. */
+	.read_inode	= ntfs_read_inode_mount,  /* VFS: Load inode from disk,
+						     called from iget(). */
+	.clear_inode	= ntfs_clear_big_inode,	  /* VFS: Called when inode is
+						     removed from memory. */
 };
 
 /**
  * The complete super operations.
  */
 struct super_operations ntfs_sops = {
-	alloc_inode:	ntfs_alloc_big_inode,	/* VFS: Allocate a new inode. */
-	destroy_inode:	ntfs_destroy_big_inode,	/* VFS: Deallocate an inode. */
-	dirty_inode:	ntfs_dirty_inode,	/* VFS: Called from
-						   __mark_inode_dirty(). */
-	//write_inode:	NULL,		/* VFS: Write dirty inode to disk. */
-	put_inode:	ntfs_put_inode,	/* VFS: Called just before the inode
-					   reference count is decreased. */
-	//delete_inode:	NULL,		/* VFS: Delete inode from disk. Called
-	//				   when i_count becomes 0 and i_nlink is
-	//				   also 0. */
-	put_super:	ntfs_put_super,	/* Syscall: umount. */
-	//write_super:	NULL,		/* Flush dirty super block to disk. */
-	//write_super_lockfs:	NULL,	/* ? */
-	//unlockfs:	NULL,		/* ? */
-	statfs:		ntfs_statfs,	/* Syscall: statfs */
-	remount_fs:	ntfs_remount,	/* Syscall: mount -o remount. */
-	clear_inode:	ntfs_clear_big_inode,	/* VFS: Called when an inode is
+	.alloc_inode	= ntfs_alloc_big_inode,	  /* VFS: Allocate new inode. */
+	.destroy_inode	= ntfs_destroy_big_inode, /* VFS: Deallocate inode. */
+	//.dirty_inode	= ntfs_dirty_inode,	  /* VFS: Called from
+	//					     __mark_inode_dirty(). */
+	//.write_inode	= NULL,		  /* VFS: Write dirty inode to disk. */
+	.put_inode	= ntfs_put_inode, /* VFS: Called just before the inode
+					     reference count is decreased. */
+	//.delete_inode	= NULL,		  /* VFS: Delete inode from disk. Called
+	//				     when i_count becomes 0 and i_nlink
+	//				     is also 0. */
+	.put_super	= ntfs_put_super, /* Syscall: umount. */
+	//write_super	= NULL,		  /* Flush dirty super block to disk. */
+	//write_super_lockfs	= NULL,	  /* ? */
+	//unlockfs	= NULL,		  /* ? */
+	.statfs		= ntfs_statfs,	  /* Syscall: statfs */
+	.remount_fs	= ntfs_remount,	  /* Syscall: mount -o remount. */
+	.clear_inode	= ntfs_clear_big_inode,	/* VFS: Called when an inode is
 						   removed from memory. */
-	//umount_begin:	NULL,		/* Forced umount. */
-	show_options:	ntfs_show_options, /* Show mount options in proc. */
+	//.umount_begin	= NULL,		     /* Forced umount. */
+	.show_options	= ntfs_show_options, /* Show mount options in proc. */
 };
 
 /**
@@ -1562,7 +1562,7 @@
 		ntfs_error(sb, "Busy inodes left. This is most likely a NTFS "
 				"driver bug.");
 		/* Copied from fs/super.c. I just love this message. (-; */
-		printk("VFS: Busy inodes after umount. Self-destruct in 5 "
+		printk("NTFS: Busy inodes after umount. Self-destruct in 5 "
 				"seconds.  Have a nice day...\n");
 	}
 	/* Errors at this stage are irrelevant. */
@@ -1618,11 +1618,11 @@
 }
 
 static struct file_system_type ntfs_fs_type = {
-	owner:		THIS_MODULE,
-	name:		"ntfs",
-	get_sb:		ntfs_get_sb,
-	kill_sb:	kill_block_super,
-	fs_flags:	FS_REQUIRES_DEV,
+	.owner		= THIS_MODULE,
+	.name		= "ntfs",
+	.get_sb		= ntfs_get_sb,
+	.kill_sb	= kill_block_super,
+	.fs_flags	= FS_REQUIRES_DEV,
 };
 
 /* Stable names for the slab caches. */
diff -Nru a/fs/ntfs/file.c b/fs/ntfs/file.c
--- a/fs/ntfs/file.c	Wed Jul 24 21:57:43 2002
+++ b/fs/ntfs/file.c	Wed Jul 24 21:57:43 2002
@@ -51,7 +51,6 @@
 struct file_operations ntfs_file_ops = {
 	.llseek	= generic_file_llseek,	/* Seek inside file. */
 	.read	= generic_file_read,	/* Read from file. */
-	.write	= generic_file_write,	/* Write to a file. */
 	.mmap	= generic_file_mmap,	/* Mmap file. */
 	.open	= ntfs_file_open,	/* Open file. */
 };

===================================================================

This BitKeeper patch contains the following changesets:
aia21@cantab.net|ChangeSet|20020724205708|58884
aia21@cantab.net|ChangeSet|20020724201230|58873
## Wrapped with gzip_uu ##


begin 664 bkpatch18157
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
DZ<7)I7]\\GM__3\CX)P;WA2+V0&V+=.$?[W_`A$O3\:_,0``
`
end
