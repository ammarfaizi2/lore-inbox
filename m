Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261565AbVAMKu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbVAMKu6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 05:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbVAMKu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 05:50:58 -0500
Received: from news.suse.de ([195.135.220.2]:61846 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261565AbVAMKky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 05:40:54 -0500
Date: Thu, 13 Jan 2005 11:31:43 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Alex Tomas <alex@clusterfs.com>,
       Andreas Dilger <adilger@clusterfs.com>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Andrew Tridgell <tridge@samba.org>
Subject: [RESEND][PATCH 1/9] Ext3: extended attribute sharing fixes and in-inode EAs
Message-Id: <1105549936.737316@suse.de>
References: <1105549936.694778@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a reverse diff of the following changeset:

# ChangeSet
#   2005/01/04 21:29:07-08:00 alex@clusterfs.com 
#   [PATCH] ext3: support for EA in inode
#   
#   1) intent of the patch is to get possibility to store EAs in the body of large
#      inode. it saves space and improves performance in some cases
#   
#   2) the patch is quite simple: it works the same way original xattr does, but
#      using other storage (inode body). body has priority over separate block.
#      original routines (ext3_xattr_get, ext3_xattr_list, ext3_xattr_set) are
#      renamed to ext3_xattr_block_*. new routines that handle inode storate are
#      added (ext3_xattr_ibody_get, ext3_xattr_ibody_list, ext3_xattr_ibody_set).
#      routines ext3_xattr_get, ext3_xattr_list and ext3_xattr_set allow user to
#      accesss both the storages transparently
#   
#   3) the change makes sense on filesystem with inode size >= 256 bytes only.
#      2.4 kernels don't support such a filesystems, AFAIK. 2.6 kernels do support
#      and ignore EAs stored in a body w/o the patch
#   
#   4) debugfs and e2fsck need to be patched to deal with EAs in inode
#      the patch will be sent later
#   
#   5) testing results:
#   	a) Andrew Samba Master (tridge) has done successful tests
#   	b) we've been using ea-in-inode feature in Lustre for many months
#   
#   Signed-off-by: Andreas Dilger <adilger@clusterfs.com>
#   Signed-off-by: Alex Tomas <alex@clusterfs.com>
#   Signed-off-by: Andrew Morton <akpm@osdl.org>
#   Signed-off-by: Linus Torvalds <torvalds@osdl.org>
# 
# fs/ext3/ialloc.c
#   2005/01/04 20:24:30-08:00 alex@clusterfs.com +5 -0
#   ext3: support for EA in inode
# 
# fs/ext3/inode.c
#   2005/01/04 20:24:30-08:00 alex@clusterfs.com +9 -1
#   ext3: support for EA in inode
# 
# fs/ext3/xattr.c
#   2005/01/04 20:24:30-08:00 alex@clusterfs.com +603 -36
#   ext3: support for EA in inode
# 
# fs/ext3/xattr.h
#   2005/01/04 18:48:13-08:00 alex@clusterfs.com +2 -1
#   ext3: support for EA in inode
# 
# include/linux/ext3_fs.h
#   2005/01/04 20:24:22-08:00 alex@clusterfs.com +3 -0
#   ext3: support for EA in inode
# 
# include/linux/ext3_fs_i.h
#   2005/01/04 18:48:13-08:00 alex@clusterfs.com +3 -0
#   ext3: support for EA in inode
# 
Index: linux-2.6.10-bk13/include/linux/ext3_fs.h
===================================================================
--- linux-2.6.10-bk13.orig/include/linux/ext3_fs.h
+++ linux-2.6.10-bk13/include/linux/ext3_fs.h
@@ -293,8 +293,6 @@ struct ext3_inode {
 			__u32	m_i_reserved2[2];
 		} masix2;
 	} osd2;				/* OS dependent 2 */
-	__u16	i_extra_isize;
-	__u16	i_pad1;
 };
 
 #define i_size_high	i_dir_acl
@@ -757,7 +755,6 @@ extern int ext3_forget(handle_t *, int, 
 extern struct buffer_head * ext3_getblk (handle_t *, struct inode *, long, int, int *);
 extern struct buffer_head * ext3_bread (handle_t *, struct inode *, int, int, int *);
 
-extern int ext3_get_inode_loc(struct inode *, struct ext3_iloc *, int);
 extern void ext3_read_inode (struct inode *);
 extern int  ext3_write_inode (struct inode *, int);
 extern int  ext3_setattr (struct dentry *, struct iattr *);
Index: linux-2.6.10-bk13/include/linux/ext3_fs_i.h
===================================================================
--- linux-2.6.10-bk13.orig/include/linux/ext3_fs_i.h
+++ linux-2.6.10-bk13/include/linux/ext3_fs_i.h
@@ -113,9 +113,6 @@ struct ext3_inode_info {
 	 */
 	loff_t	i_disksize;
 
-	/* on-disk additional length */
-	__u16 i_extra_isize;
-
 	/*
 	 * truncate_sem is for serialising ext3_truncate() against
 	 * ext3_getblock().  In the 2.4 ext2 design, great chunks of inode's
Index: linux-2.6.10-bk13/fs/ext3/xattr.c
===================================================================
--- linux-2.6.10-bk13.orig/fs/ext3/xattr.c
+++ linux-2.6.10-bk13/fs/ext3/xattr.c
@@ -9,7 +9,6 @@
  *  suggestion of Luka Renko <luka.renko@hermes.si>.
  * xattr consolidation Copyright (c) 2004 James Morris <jmorris@redhat.com>,
  *  Red Hat Inc.
- * ea-in-inode support by Alex Tomas <alex@clusterfs.com> aka bzzz
  */
 
 /*
@@ -90,9 +89,10 @@
 # define ea_bdebug(f...)
 #endif
 
-static int ext3_xattr_set_handle2(handle_t *handle, struct inode *inode,
-				       struct buffer_head *old_bh,
-				       struct ext3_xattr_header *header);
+static int ext3_xattr_set_handle2(handle_t *, struct inode *,
+				  struct buffer_head *,
+				  struct ext3_xattr_header *);
+
 static int ext3_xattr_cache_insert(struct buffer_head *);
 static struct buffer_head *ext3_xattr_cache_find(handle_t *, struct inode *,
 						 struct ext3_xattr_header *,
@@ -150,12 +150,17 @@ ext3_listxattr(struct dentry *dentry, ch
 }
 
 /*
- * ext3_xattr_block_get()
+ * ext3_xattr_get()
+ *
+ * Copy an extended attribute into the buffer
+ * provided, or compute the buffer size required.
+ * Buffer is NULL to compute the size of the buffer required.
  *
- * routine looks for attribute in EA block and returns it's value and size
+ * Returns a negative error number on failure, or the number of bytes
+ * used / required on success.
  */
 int
-ext3_xattr_block_get(struct inode *inode, int name_index, const char *name,
+ext3_xattr_get(struct inode *inode, int name_index, const char *name,
 	       void *buffer, size_t buffer_size)
 {
 	struct buffer_head *bh = NULL;
@@ -169,6 +174,7 @@ ext3_xattr_block_get(struct inode *inode
 
 	if (name == NULL)
 		return -EINVAL;
+	down_read(&EXT3_I(inode)->xattr_sem);
 	error = -ENODATA;
 	if (!EXT3_I(inode)->i_file_acl)
 		goto cleanup;
@@ -241,87 +247,15 @@ found:
 
 cleanup:
 	brelse(bh);
+	up_read(&EXT3_I(inode)->xattr_sem);
 
 	return error;
 }
 
 /*
- * ext3_xattr_ibody_get()
- *
- * routine looks for attribute in inode body and returns it's value and size
- */
-int
-ext3_xattr_ibody_get(struct inode *inode, int name_index, const char *name,
-	       void *buffer, size_t buffer_size)
-{
-	int size, name_len = strlen(name), storage_size;
-	struct ext3_xattr_entry *last;
-	struct ext3_inode *raw_inode;
-	struct ext3_iloc iloc;
-	char *start, *end;
-	int ret = -ENOENT;
-
-	if (EXT3_SB(inode->i_sb)->s_inode_size <= EXT3_GOOD_OLD_INODE_SIZE)
-		return -ENOENT;
-
-	ret = ext3_get_inode_loc(inode, &iloc, 1);
-	if (ret)
-		return ret;
-	raw_inode = ext3_raw_inode(&iloc);
-
-	storage_size = EXT3_SB(inode->i_sb)->s_inode_size -
-				EXT3_GOOD_OLD_INODE_SIZE -
-				EXT3_I(inode)->i_extra_isize -
-				sizeof(__u32);
-	start = (char *) raw_inode + EXT3_GOOD_OLD_INODE_SIZE +
-			EXT3_I(inode)->i_extra_isize;
-	if (le32_to_cpu((*(__u32*) start)) != EXT3_XATTR_MAGIC) {
-		brelse(iloc.bh);
-		return -ENOENT;
-	}
-	start += sizeof(__u32);
-	end = (char *) raw_inode + EXT3_SB(inode->i_sb)->s_inode_size;
-
-	last = (struct ext3_xattr_entry *) start;
-	while (!IS_LAST_ENTRY(last)) {
-		struct ext3_xattr_entry *next = EXT3_XATTR_NEXT(last);
-		if (le32_to_cpu(last->e_value_size) > storage_size ||
-				(char *) next >= end) {
-			ext3_error(inode->i_sb, "ext3_xattr_ibody_get",
-				"inode %ld", inode->i_ino);
-			brelse(iloc.bh);
-			return -EIO;
-		}
-		if (name_index == last->e_name_index &&
-		    name_len == last->e_name_len &&
-		    !memcmp(name, last->e_name, name_len))
-			goto found;
-		last = next;
-	}
-
-	/* can't find EA */
-	brelse(iloc.bh);
-	return -ENOENT;
-
-found:
-	size = le32_to_cpu(last->e_value_size);
-	if (buffer) {
-		ret = -ERANGE;
-		if (buffer_size >= size) {
-			memcpy(buffer, start + le16_to_cpu(last->e_value_offs),
-				size);
-			ret = size;
-		}
-	} else
-		ret = size;
-	brelse(iloc.bh);
-	return ret;
-}
-
-/*
- * ext3_xattr_get()
+ * ext3_xattr_list()
  *
- * Copy an extended attribute into the buffer
+ * Copy a list of attribute names into the buffer
  * provided, or compute the buffer size required.
  * Buffer is NULL to compute the size of the buffer required.
  *
@@ -329,31 +263,7 @@ found:
  * used / required on success.
  */
 int
-ext3_xattr_get(struct inode *inode, int name_index, const char *name,
-	       void *buffer, size_t buffer_size)
-{
-	int err;
-
-	down_read(&EXT3_I(inode)->xattr_sem);
-
-	/* try to find attribute in inode body */
-	err = ext3_xattr_ibody_get(inode, name_index, name,
-					buffer, buffer_size);
-	if (err < 0)
-		/* search was unsuccessful, try to find EA in dedicated block */
-		err = ext3_xattr_block_get(inode, name_index, name,
-				buffer, buffer_size);
-	up_read(&EXT3_I(inode)->xattr_sem);
-
-	return err;
-}
-
-/* ext3_xattr_block_list()
- *
- * generate list of attributes stored in EA block
- */
-int
-ext3_xattr_block_list(struct inode *inode, char *buffer, size_t buffer_size)
+ext3_xattr_list(struct inode *inode, char *buffer, size_t buffer_size)
 {
 	struct buffer_head *bh = NULL;
 	struct ext3_xattr_entry *entry;
@@ -364,6 +274,7 @@ ext3_xattr_block_list(struct inode *inod
 	ea_idebug(inode, "buffer=%p, buffer_size=%ld",
 		  buffer, (long)buffer_size);
 
+	down_read(&EXT3_I(inode)->xattr_sem);
 	error = 0;
 	if (!EXT3_I(inode)->i_file_acl)
 		goto cleanup;
@@ -373,7 +284,7 @@ ext3_xattr_block_list(struct inode *inod
 	if (!bh)
 		goto cleanup;
 	ea_bdebug(bh, "b_count=%d, refcount=%d",
-		(int) atomic_read(&(bh->b_count)), (int) le32_to_cpu(HDR(bh)->h_refcount));
+		atomic_read(&(bh->b_count)), le32_to_cpu(HDR(bh)->h_refcount));
 	end = bh->b_data + bh->b_size;
 	if (HDR(bh)->h_magic != cpu_to_le32(EXT3_XATTR_MAGIC) ||
 	    HDR(bh)->h_blocks != cpu_to_le32(1)) {
@@ -420,131 +331,11 @@ bad_block:	ext3_error(inode->i_sb, "ext3
 
 cleanup:
 	brelse(bh);
+	up_read(&EXT3_I(inode)->xattr_sem);
 
 	return error;
 }
 
-/* ext3_xattr_ibody_list()
- *
- * generate list of attributes stored in inode body
- */
-int
-ext3_xattr_ibody_list(struct inode *inode, char *buffer, size_t buffer_size)
-{
-	struct ext3_xattr_entry *last;
-	struct ext3_inode *raw_inode;
-	size_t rest = buffer_size;
-	struct ext3_iloc iloc;
-	char *start, *end;
-	int storage_size;
-	int size = 0;
-	int ret;
-
-	if (EXT3_SB(inode->i_sb)->s_inode_size <= EXT3_GOOD_OLD_INODE_SIZE)
-		return 0;
-
-	ret = ext3_get_inode_loc(inode, &iloc, 1);
-	if (ret)
-		return ret;
-	raw_inode = ext3_raw_inode(&iloc);
-
-	storage_size = EXT3_SB(inode->i_sb)->s_inode_size -
-				EXT3_GOOD_OLD_INODE_SIZE -
-				EXT3_I(inode)->i_extra_isize -
-				sizeof(__u32);
-	start = (char *) raw_inode + EXT3_GOOD_OLD_INODE_SIZE +
-			EXT3_I(inode)->i_extra_isize;
-	if (le32_to_cpu((*(__u32*) start)) != EXT3_XATTR_MAGIC)
-		goto cleanup;
-	start += sizeof(__u32);
-	end = (char *) raw_inode + EXT3_SB(inode->i_sb)->s_inode_size;
-
-	last = (struct ext3_xattr_entry *) start;
-	while (!IS_LAST_ENTRY(last)) {
-		struct ext3_xattr_entry *next = EXT3_XATTR_NEXT(last);
-		if ((char *) next >= end) {
-			ext3_error(inode->i_sb, "ext3_xattr_ibody_list",
-					"inode %ld", inode->i_ino);
-			ret = -EIO;
-			goto cleanup;
-		}
-		last = next;
-	}
-
-	last = (struct ext3_xattr_entry *) start;
-	for (; !IS_LAST_ENTRY(last); last = EXT3_XATTR_NEXT(last)) {
-		struct xattr_handler *handler =
-			ext3_xattr_handler(last->e_name_index);
-
-		if (!handler)
-			continue;
-
-		size += handler->list(inode, buffer, rest, last->e_name,
-					last->e_name_len);
-		if (buffer) {
-			if (size > rest) {
-				ret = -ERANGE;
-				goto cleanup;
-			}
-			buffer += size;
-		}
-		rest -= size;
-	}
-	ret = buffer_size - rest; /* total size */
-
-cleanup:
-	brelse(iloc.bh);
-	return ret;
-}
-
-/*
- * ext3_xattr_list()
- *
- * Copy a list of attribute names into the buffer
- * provided, or compute the buffer size required.
- * Buffer is NULL to compute the size of the buffer required.
- *
- * Returns a negative error number on failure, or the number of bytes
- * used / required on success.
- */
-int
-ext3_xattr_list(struct inode *inode, char *buffer, size_t buffer_size)
-{
-	int size = buffer_size;
-	int error;
-
-	down_read(&EXT3_I(inode)->xattr_sem);
-
-	/* get list of attributes stored in inode body */
-	error = ext3_xattr_ibody_list(inode, buffer, buffer_size);
-	if (error < 0) {
-		/* some error occured while collecting
-		 * attributes in inode body */
-		size = 0;
-		goto cleanup;
-	}
-	size = error;
-
-	/* get list of attributes stored in dedicated block */
-	if (buffer) {
-		buffer_size -= error;
-		if (buffer_size <= 0) {
-			buffer = NULL;
-			buffer_size = 0;
-		} else
-			buffer += error;
-	}
-
-	error = ext3_xattr_block_list(inode, buffer, buffer_size);
-	/* listing was successful, so we return len */
-	if (error < 0)
-		size = 0;
-
-cleanup:
-	up_read(&EXT3_I(inode)->xattr_sem);
-	return error + size;
-}
-
 /*
  * If the EXT3_FEATURE_COMPAT_EXT_ATTR feature of this file system is
  * not set, set it.
@@ -566,286 +357,6 @@ static void ext3_xattr_update_super_bloc
 }
 
 /*
- * ext3_xattr_ibody_find()
- *
- * search attribute and calculate free space in inode body
- * NOTE: free space includes space our attribute hold
- */
-int
-ext3_xattr_ibody_find(struct inode *inode, int name_index,
-			const char *name, int *free)
-{
-	struct ext3_xattr_entry *last;
-	struct ext3_inode *raw_inode;
-	int name_len = strlen(name);
-	int err, storage_size;
-	struct ext3_iloc iloc;
-	char *start, *end;
-	int ret = -ENOENT;
-
-	*free = 0;
-	if (EXT3_SB(inode->i_sb)->s_inode_size <= EXT3_GOOD_OLD_INODE_SIZE)
-		return ret;
-
-	err = ext3_get_inode_loc(inode, &iloc, 1);
-	if (err)
-		return -EIO;
-	raw_inode = ext3_raw_inode(&iloc);
-
-	storage_size = EXT3_SB(inode->i_sb)->s_inode_size -
-				EXT3_GOOD_OLD_INODE_SIZE -
-				EXT3_I(inode)->i_extra_isize -
-				sizeof(__u32);
-	*free = storage_size - sizeof(__u32);
-	start = (char *) raw_inode + EXT3_GOOD_OLD_INODE_SIZE +
-			EXT3_I(inode)->i_extra_isize;
-	if (le32_to_cpu((*(__u32*) start)) != EXT3_XATTR_MAGIC) {
-		brelse(iloc.bh);
-		return -ENOENT;
-	}
-	start += sizeof(__u32);
-	end = (char *) raw_inode + EXT3_SB(inode->i_sb)->s_inode_size;
-
-	last = (struct ext3_xattr_entry *) start;
-	while (!IS_LAST_ENTRY(last)) {
-		struct ext3_xattr_entry *next = EXT3_XATTR_NEXT(last);
-		if (le32_to_cpu(last->e_value_size) > storage_size ||
-				(char *) next >= end) {
-			ext3_error(inode->i_sb, "ext3_xattr_ibody_find",
-				"inode %ld", inode->i_ino);
-			brelse(iloc.bh);
-			return -EIO;
-		}
-
-		if (name_index == last->e_name_index &&
-		    name_len == last->e_name_len &&
-		    !memcmp(name, last->e_name, name_len)) {
-			ret = 0;
-		} else {
-			*free -= EXT3_XATTR_LEN(last->e_name_len);
-			*free -= le32_to_cpu(last->e_value_size);
-		}
-		last = next;
-	}
-
-	brelse(iloc.bh);
-	return ret;
-}
-
-/*
- * ext3_xattr_block_find()
- *
- * search attribute and calculate free space in EA block (if it allocated)
- * NOTE: free space includes space our attribute hold
- */
-int
-ext3_xattr_block_find(struct inode *inode, int name_index,
-			const char *name, int *free)
-{
-	struct buffer_head *bh = NULL;
-	struct ext3_xattr_entry *entry;
-	char *end;
-	int name_len, error = -ENOENT;
-
-	if (!EXT3_I(inode)->i_file_acl) {
-		*free = inode->i_sb->s_blocksize -
-			sizeof(struct ext3_xattr_header) -
-			sizeof(__u32);
-		return -ENOENT;
-	}
-	ea_idebug(inode, "reading block %d", EXT3_I(inode)->i_file_acl);
-	bh = sb_bread(inode->i_sb, EXT3_I(inode)->i_file_acl);
-	if (!bh)
-		return -EIO;
-	ea_bdebug(bh, "b_count=%d, refcount=%d",
-		atomic_read(&(bh->b_count)), le32_to_cpu(HDR(bh)->h_refcount));
-	end = bh->b_data + bh->b_size;
-	if (HDR(bh)->h_magic != cpu_to_le32(EXT3_XATTR_MAGIC) ||
-	    HDR(bh)->h_blocks != cpu_to_le32(1)) {
-bad_block:	ext3_error(inode->i_sb, "ext3_xattr_get",
-			"inode %ld: bad block %d", inode->i_ino,
-			EXT3_I(inode)->i_file_acl);
-		brelse(bh);
-		return -EIO;
-	}
-	/* find named attribute */
-	name_len = strlen(name);
-	*free = bh->b_size - sizeof(__u32);
-
-	entry = FIRST_ENTRY(bh);
-	while (!IS_LAST_ENTRY(entry)) {
-		struct ext3_xattr_entry *next =
-			EXT3_XATTR_NEXT(entry);
-		if ((char *)next >= end)
-			goto bad_block;
-		if (name_index == entry->e_name_index &&
-		    name_len == entry->e_name_len &&
-		    memcmp(name, entry->e_name, name_len) == 0) {
-			error = 0;
-		} else {
-			*free -= EXT3_XATTR_LEN(entry->e_name_len);
-			*free -= le32_to_cpu(entry->e_value_size);
-		}
-		entry = next;
-	}
-	brelse(bh);
-
-	return error;
-}
-
-/*
- * ext3_xattr_ibody_set()
- *
- * this routine add/remove/replace attribute in inode body
- */
-int
-ext3_xattr_ibody_set(handle_t *handle, struct inode *inode, int name_index,
-		      const char *name, const void *value, size_t value_len,
-		      int flags)
-{
-	struct ext3_xattr_entry *last, *next, *here = NULL;
-	struct ext3_inode *raw_inode;
-	int name_len = strlen(name);
-	int esize = EXT3_XATTR_LEN(name_len);
-	struct buffer_head *bh;
-	int err, storage_size;
-	struct ext3_iloc iloc;
-	int free, min_offs;
-	char *start, *end;
-
-	if (EXT3_SB(inode->i_sb)->s_inode_size <= EXT3_GOOD_OLD_INODE_SIZE)
-		return -ENOSPC;
-
-	err = ext3_get_inode_loc(inode, &iloc, 1);
-	if (err)
-		return err;
-	raw_inode = ext3_raw_inode(&iloc);
-	bh = iloc.bh;
-
-	storage_size = EXT3_SB(inode->i_sb)->s_inode_size -
-				EXT3_GOOD_OLD_INODE_SIZE -
-				EXT3_I(inode)->i_extra_isize -
-				sizeof(__u32);
-	start = (char *) raw_inode + EXT3_GOOD_OLD_INODE_SIZE +
-			EXT3_I(inode)->i_extra_isize;
-	if ((*(__u32*) start) != EXT3_XATTR_MAGIC) {
-		/* inode had no attributes before */
-		*((__u32*) start) = cpu_to_le32(EXT3_XATTR_MAGIC);
-	}
-	start += sizeof(__u32);
-	end = (char *) raw_inode + EXT3_SB(inode->i_sb)->s_inode_size;
-	min_offs = storage_size;
-	free = storage_size - sizeof(__u32);
-
-	last = (struct ext3_xattr_entry *) start;
-	while (!IS_LAST_ENTRY(last)) {
-		next = EXT3_XATTR_NEXT(last);
-		if (le32_to_cpu(last->e_value_size) > storage_size ||
-				(char *) next >= end) {
-			ext3_error(inode->i_sb, "ext3_xattr_ibody_set",
-				"inode %ld", inode->i_ino);
-			brelse(bh);
-			return -EIO;
-		}
-
-		if (last->e_value_size) {
-			int offs = le16_to_cpu(last->e_value_offs);
-			if (offs < min_offs)
-				min_offs = offs;
-		}
-		if (name_index == last->e_name_index &&
-			name_len == last->e_name_len &&
-			!memcmp(name, last->e_name, name_len))
-			here = last;
-		else {
-			/* we calculate all but our attribute
-			 * because it will be removed before changing */
-			free -= EXT3_XATTR_LEN(last->e_name_len);
-			free -= le32_to_cpu(last->e_value_size);
-		}
-		last = next;
-	}
-
-	if (value && (esize + value_len > free)) {
-		brelse(bh);
-		return -ENOSPC;
-	}
-
-	err = ext3_reserve_inode_write(handle, inode, &iloc);
-	if (err) {
-		brelse(bh);
-		return err;
-	}
-
-	/* optimization: can we simple replace old value ? */
-	if (here && value_len == le32_to_cpu(here->e_value_size)) {
-		int offs = le16_to_cpu(here->e_value_offs);
-		memcpy(start + offs, value, value_len);
-		goto done;
-	}
-
-	if (here) {
-		/* time to remove old value */
-		struct ext3_xattr_entry *e;
-		int size = le32_to_cpu(here->e_value_size);
-		int border = le16_to_cpu(here->e_value_offs);
-		char *src;
-
-		/* move tail */
-		memmove(start + min_offs + size, start + min_offs,
-				border - min_offs);
-
-		/* recalculate offsets */
-		e = (struct ext3_xattr_entry *) start;
-		while (!IS_LAST_ENTRY(e)) {
-			struct ext3_xattr_entry *next = EXT3_XATTR_NEXT(e);
-			int offs = le16_to_cpu(e->e_value_offs);
-			if (offs < border)
-				e->e_value_offs =
-					cpu_to_le16(offs + size);
-			e = next;
-		}
-		min_offs += size;
-
-		/* remove entry */
-		border = EXT3_XATTR_LEN(here->e_name_len);
-		src = (char *) here + EXT3_XATTR_LEN(here->e_name_len);
-		size = (char *) last - src;
-		if ((char *) here + size > end)
-			printk("ALERT at %s:%d: 0x%p + %d > 0x%p\n",
-					__FILE__, __LINE__, here, size, end);
-		memmove(here, src, size);
-		last = (struct ext3_xattr_entry *) ((char *) last - border);
-		*((__u32 *) last) = 0;
-	}
-
-	if (value) {
-		int offs = min_offs - value_len;
-		/* use last to create new entry */
-		last->e_name_len = strlen(name);
-		last->e_name_index = name_index;
-		last->e_value_offs = cpu_to_le16(offs);
-		last->e_value_size = cpu_to_le32(value_len);
-		last->e_hash = last->e_value_block = 0;
-		memset(last->e_name, 0, esize);
-		memcpy(last->e_name, name, last->e_name_len);
-		if (start + offs + value_len > end)
-			printk("ALERT at %s:%d: 0x%p + %d + %zd > 0x%p\n",
-					__FILE__, __LINE__, start, offs,
-					value_len, end);
-		memcpy(start + offs, value, value_len);
-		last = EXT3_XATTR_NEXT(last);
-		*((__u32 *) last) = 0;
-	}
-
-done:
-	ext3_mark_iloc_dirty(handle, inode, &iloc);
-	brelse(bh);
-
-	return 0;
-}
-
-/*
  * ext3_xattr_set_handle()
  *
  * Create, replace or remove an extended attribute for this inode. Buffer
@@ -859,100 +370,6 @@ done:
  */
 int
 ext3_xattr_set_handle(handle_t *handle, struct inode *inode, int name_index,
-		const char *name, const void *value, size_t value_len,
-		int flags)
-{
-	int free1 = -1, free2 = -1;
-	int err, where = 0, total;
-	int name_len;
-
-	ea_idebug(inode, "name=%d.%s, value=%p, value_len=%ld",
-		  name_index, name, value, (long)value_len);
-
-	if (IS_RDONLY(inode))
-		return -EROFS;
-	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
-		return -EPERM;
-	if (value == NULL)
-		value_len = 0;
-	if (name == NULL)
-		return -EINVAL;
-	name_len = strlen(name);
-	if (name_len > 255 || value_len > inode->i_sb->s_blocksize)
-		return -ERANGE;
-	down_write(&EXT3_I(inode)->xattr_sem);
-
-#define EX_FOUND_IN_IBODY	1
-#define EX_FOUND_IN_BLOCK	2
-
-	/* try to find attribute in inode body */
-	err = ext3_xattr_ibody_find(inode, name_index, name, &free1);
-	if (err == 0) {
-		/* found EA in inode */
-		where = EX_FOUND_IN_IBODY;
-	} else if (err == -ENOENT) {
-		/* there is no such attribute in inode body */
-		/* try to find attribute in dedicated block */
-		err = ext3_xattr_block_find(inode, name_index, name, &free2);
-		if (err != 0 && err != -ENOENT) {
-			/* not found EA in block */
-			goto finish;
-		} else if (err == 0) {
-			/* found EA in block */
-			where = EX_FOUND_IN_BLOCK;
-		}
-	} else
-		goto finish;
-
-	/* check flags: may replace? may create ? */
-	if (where && (flags & XATTR_CREATE)) {
-		err = -EEXIST;
-		goto finish;
-	} else if (!where && (flags & XATTR_REPLACE)) {
-		err = -ENODATA;
-		goto finish;
-	}
-
-	/* check if we have enough space to store attribute */
-	total = EXT3_XATTR_LEN(strlen(name)) + value_len;
-	if (total > free1 && free2 > 0 && total > free2) {
-		/* have no enough space */
-		err = -ENOSPC;
-		goto finish;
-	}
-
-	/* there are two cases when we want to remove EA from original storage:
-	 * a) EA is stored in the inode, but new value doesn't fit
-	 * b) EA is stored in the block, but new value fit in inode
-	 */
-	if (where == EX_FOUND_IN_IBODY && total > free1)
-		ext3_xattr_ibody_set(handle, inode, name_index, name,
-					NULL, 0, flags);
-	else if (where == EX_FOUND_IN_BLOCK && total <= free1)
-		ext3_xattr_block_set(handle, inode, name_index,
-					name, NULL, 0, flags);
-
-	/* try to store EA in inode body */
-	err = ext3_xattr_ibody_set(handle, inode, name_index, name,
-					value, value_len, flags);
-	if (err) {
-		/* can't store EA in inode body: try to store in block */
-		err = ext3_xattr_block_set(handle, inode, name_index, name,
-						value, value_len, flags);
-	}
-
-finish:
-	up_write(&EXT3_I(inode)->xattr_sem);
-	return err;
-}
-
-/*
- * ext3_xattr_block_set()
- *
- * this routine add/remove/replace attribute in EA block
- */
-int
-ext3_xattr_block_set(handle_t *handle, struct inode *inode, int name_index,
 		      const char *name, const void *value, size_t value_len,
 		      int flags)
 {
@@ -975,7 +392,22 @@ ext3_xattr_block_set(handle_t *handle, s
 	 *             towards the end of the block).
 	 * end -- Points right after the block pointed to by header.
 	 */
+
+	ea_idebug(inode, "name=%d.%s, value=%p, value_len=%ld",
+		  name_index, name, value, (long)value_len);
+
+	if (IS_RDONLY(inode))
+		return -EROFS;
+	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
+		return -EPERM;
+	if (value == NULL)
+		value_len = 0;
+	if (name == NULL)
+		return -EINVAL;
 	name_len = strlen(name);
+	if (name_len > 255 || value_len > sb->s_blocksize)
+		return -ERANGE;
+	down_write(&EXT3_I(inode)->xattr_sem);
 	if (EXT3_I(inode)->i_file_acl) {
 		/* The inode already has an extended attribute block. */
 		bh = sb_bread(sb, EXT3_I(inode)->i_file_acl);
@@ -1201,6 +633,7 @@ cleanup:
 	brelse(bh);
 	if (!(bh && header == HDR(bh)))
 		kfree(header);
+	up_write(&EXT3_I(inode)->xattr_sem);
 
 	return error;
 }
Index: linux-2.6.10-bk13/fs/ext3/inode.c
===================================================================
--- linux-2.6.10-bk13.orig/fs/ext3/inode.c
+++ linux-2.6.10-bk13/fs/ext3/inode.c
@@ -2275,7 +2275,7 @@ static unsigned long ext3_get_inode_bloc
  * trying to determine the inode's location on-disk and no read need be
  * performed.
  */
-int ext3_get_inode_loc(struct inode *inode,
+static int ext3_get_inode_loc(struct inode *inode,
 				struct ext3_iloc *iloc, int in_mem)
 {
 	unsigned long block;
@@ -2483,11 +2483,6 @@ void ext3_read_inode(struct inode * inod
 		ei->i_data[block] = raw_inode->i_block[block];
 	INIT_LIST_HEAD(&ei->i_orphan);
 
-	if (EXT3_INODE_SIZE(inode->i_sb) > EXT3_GOOD_OLD_INODE_SIZE)
-		ei->i_extra_isize = le16_to_cpu(raw_inode->i_extra_isize);
-	else
-		ei->i_extra_isize = 0;
-
 	if (S_ISREG(inode->i_mode)) {
 		inode->i_op = &ext3_file_inode_operations;
 		inode->i_fop = &ext3_file_operations;
@@ -2623,9 +2618,6 @@ static int ext3_do_update_inode(handle_t
 	} else for (block = 0; block < EXT3_N_BLOCKS; block++)
 		raw_inode->i_block[block] = ei->i_data[block];
 
-	if (EXT3_INODE_SIZE(inode->i_sb) > EXT3_GOOD_OLD_INODE_SIZE)
-		raw_inode->i_extra_isize = cpu_to_le16(ei->i_extra_isize);
-
 	BUFFER_TRACE(bh, "call ext3_journal_dirty_metadata");
 	rc = ext3_journal_dirty_metadata(handle, bh);
 	if (!err)
Index: linux-2.6.10-bk13/fs/ext3/xattr.h
===================================================================
--- linux-2.6.10-bk13.orig/fs/ext3/xattr.h
+++ linux-2.6.10-bk13/fs/ext3/xattr.h
@@ -67,8 +67,7 @@ extern ssize_t ext3_listxattr(struct den
 extern int ext3_xattr_get(struct inode *, int, const char *, void *, size_t);
 extern int ext3_xattr_list(struct inode *, char *, size_t);
 extern int ext3_xattr_set(struct inode *, int, const char *, const void *, size_t, int);
-extern int ext3_xattr_set_handle(handle_t *, struct inode *, int, const char *,const void *,size_t,int);
-extern int ext3_xattr_block_set(handle_t *, struct inode *, int, const char *,const void *,size_t,int);
+extern int ext3_xattr_set_handle(handle_t *, struct inode *, int, const char *, const void *, size_t, int);
 
 extern void ext3_xattr_delete_inode(handle_t *, struct inode *);
 extern void ext3_xattr_put_super(struct super_block *);
Index: linux-2.6.10-bk13/fs/ext3/ialloc.c
===================================================================
--- linux-2.6.10-bk13.orig/fs/ext3/ialloc.c
+++ linux-2.6.10-bk13/fs/ext3/ialloc.c
@@ -596,11 +596,6 @@ got:
 	spin_unlock(&sbi->s_next_gen_lock);
 
 	ei->i_state = EXT3_STATE_NEW;
-	if (EXT3_INODE_SIZE(inode->i_sb) > EXT3_GOOD_OLD_INODE_SIZE) {
-		ei->i_extra_isize = sizeof(__u16)	/* i_extra_isize */
-				+ sizeof(__u16);	/* i_pad1 */
-	} else
-		ei->i_extra_isize = 0;
 
 	ret = inode;
 	if(DQUOT_ALLOC_INODE(inode)) {
--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH

