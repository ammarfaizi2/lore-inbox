Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbVAMK5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbVAMK5L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 05:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261593AbVAMK5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 05:57:10 -0500
Received: from mail.suse.de ([195.135.220.2]:63638 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261568AbVAMKky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 05:40:54 -0500
Date: Thu, 13 Jan 2005 11:31:43 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Alex Tomas <alex@clusterfs.com>,
       Andreas Dilger <adilger@clusterfs.com>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Andrew Tridgell <tridge@samba.org>
Subject: [RESEND][PATCH 9/9] Ext3: extended attribute sharing fixes and in-inode EAs
Message-Id: <1105549937.021943@suse.de>
References: <1105549936.694778@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-inode extended attributes for ext3

This started of as a patch by Alex Tomas <alex@clusterfs.com> and got an
overhaul by me. The on-disk structure used is the same as in Alex's
original patch.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.10/fs/ext3/xattr.c
===================================================================
--- linux-2.6.10.orig/fs/ext3/xattr.c	2005-01-11 00:54:42.000000000 +0100
+++ linux-2.6.10/fs/ext3/xattr.c	2005-01-11 02:58:47.296493192 +0100
@@ -9,18 +9,21 @@
  *  suggestion of Luka Renko <luka.renko@hermes.si>.
  * xattr consolidation Copyright (c) 2004 James Morris <jmorris@redhat.com>,
  *  Red Hat Inc.
+ * ea-in-inode support by Alex Tomas <alex@clusterfs.com> aka bzzz
+ *  and Andreas Gruenbacher <agruen@suse.de>.
  */
 
 /*
- * Extended attributes are stored on disk blocks allocated outside of
- * any inode. The i_file_acl field is then made to point to this allocated
- * block. If all extended attributes of an inode are identical, these
- * inodes may share the same extended attribute block. Such situations
- * are automatically detected by keeping a cache of recent attribute block
- * numbers and hashes over the block's contents in memory.
+ * Extended attributes are stored directly in inodes (on file systems with
+ * inodes bigger than 128 bytes) and on additional disk blocks. The i_file_acl
+ * field contains the block number if an inode uses an additional block. All
+ * attributes must fit in the inode and one additional block. Blocks that
+ * contain the identical set of attributes may be shared among several inodes.
+ * Identical blocks are detected by keeping a cache of blocks that have
+ * recently been accessed.
  *
- *
- * Extended attribute block layout:
+ * The attributes in inodes and on blocks have a different header; the entries
+ * are stored in the same format:
  *
  *   +------------------+
  *   | header           |
@@ -34,23 +37,17 @@
  *   | value 2          | |
  *   +------------------+
  *
- * The block header is followed by multiple entry descriptors. These entry
- * descriptors are variable in size, and alligned to EXT3_XATTR_PAD
- * byte boundaries. The entry descriptors are sorted by attribute name,
- * so that two extended attribute blocks can be compared efficiently.
- *
- * Attribute values are aligned to the end of the block, stored in
- * no specific order. They are also padded to EXT3_XATTR_PAD byte
- * boundaries. No additional gaps are left between them.
+ * The header is followed by multiple entry descriptors. Descriptors are
+ * kept sorted. The attribute values are aligned to the end of the block
+ * in no specific order.
  *
  * Locking strategy
  * ----------------
  * EXT3_I(inode)->i_file_acl is protected by EXT3_I(inode)->xattr_sem.
  * EA blocks are only changed if they are exclusive to an inode, so
  * holding xattr_sem also means that nothing but the EA block's reference
- * count will change. Multiple writers to an EA block are synchronized
- * by the bh lock. No more than a single bh lock is held at any time
- * to avoid deadlocks.
+ * count can change. Multiple writers to the same block are synchronized
+ * by the buffer lock.
  */
 
 #include <linux/init.h>
@@ -69,6 +66,13 @@
 #define BFIRST(bh) ENTRY(BHDR(bh)+1)
 #define IS_LAST_ENTRY(entry) (*(__u32 *)(entry) == 0)
 
+#define IHDR(inode, raw_inode) \
+	((struct ext3_xattr_ibody_header *) \
+		((void *)raw_inode + \
+		 EXT3_GOOD_OLD_INODE_SIZE + \
+		 EXT3_I(inode)->i_extra_isize))
+#define IFIRST(hdr) ((struct ext3_xattr_entry *)((hdr)+1))
+
 #ifdef EXT3_XATTR_DEBUG
 # define ea_idebug(inode, f...) do { \
 		printk(KERN_DEBUG "inode %s:%ld: ", \
@@ -206,19 +210,9 @@
 	return cmp ? -ENODATA : 0;
 }
 
-/*
- * ext3_xattr_get()
- *
- * Copy an extended attribute into the buffer
- * provided, or compute the buffer size required.
- * Buffer is NULL to compute the size of the buffer required.
- *
- * Returns a negative error number on failure, or the number of bytes
- * used / required on success.
- */
 int
-ext3_xattr_get(struct inode *inode, int name_index, const char *name,
-	       void *buffer, size_t buffer_size)
+ext3_xattr_block_get(struct inode *inode, int name_index, const char *name,
+		     void *buffer, size_t buffer_size)
 {
 	struct buffer_head *bh = NULL;
 	struct ext3_xattr_entry *entry;
@@ -228,9 +222,6 @@
 	ea_idebug(inode, "name=%d.%s, buffer=%p, buffer_size=%ld",
 		  name_index, name, buffer, (long)buffer_size);
 
-	if (name == NULL)
-		return -EINVAL;
-	down_read(&EXT3_I(inode)->xattr_sem);
 	error = -ENODATA;
 	if (!EXT3_I(inode)->i_file_acl)
 		goto cleanup;
@@ -266,6 +257,75 @@
 
 cleanup:
 	brelse(bh);
+	return error;
+}
+
+static int
+ext3_xattr_ibody_get(struct inode *inode, int name_index, const char *name,
+		     void *buffer, size_t buffer_size)
+{
+	struct ext3_xattr_ibody_header *header;
+	struct ext3_xattr_entry *entry;
+	struct ext3_inode *raw_inode;
+	struct ext3_iloc iloc;
+	size_t size;
+	void *end;
+	int error;
+
+	if (EXT3_SB(inode->i_sb)->s_inode_size <= EXT3_GOOD_OLD_INODE_SIZE ||
+	    !(EXT3_I(inode)->i_state & EXT3_STATE_XATTR))
+		return -ENODATA;
+	error = ext3_get_inode_loc(inode, &iloc);
+	if (error)
+		return error;
+	raw_inode = ext3_raw_inode(&iloc);
+	header = IHDR(inode, raw_inode);
+	entry = IFIRST(header);
+	end = (void *)raw_inode + EXT3_SB(inode->i_sb)->s_inode_size;
+	error = ext3_xattr_check_names(entry, end);
+	if (error)
+		goto cleanup;
+	error = ext3_xattr_find_entry(&entry, name_index, name,
+				      end - (void *)entry, 0);
+	if (error)
+		goto cleanup;
+	size = le32_to_cpu(entry->e_value_size);
+	if (buffer) {
+		error = -ERANGE;
+		if (size > buffer_size)
+			goto cleanup;
+		memcpy(buffer, (void *)IFIRST(header) +
+		       le16_to_cpu(entry->e_value_offs), size);
+	}
+	error = size;
+
+cleanup:
+	brelse(iloc.bh);
+	return error;
+}
+
+/*
+ * ext3_xattr_get()
+ *
+ * Copy an extended attribute into the buffer
+ * provided, or compute the buffer size required.
+ * Buffer is NULL to compute the size of the buffer required.
+ *
+ * Returns a negative error number on failure, or the number of bytes
+ * used / required on success.
+ */
+int
+ext3_xattr_get(struct inode *inode, int name_index, const char *name,
+	       void *buffer, size_t buffer_size)
+{
+	int error;
+
+	down_read(&EXT3_I(inode)->xattr_sem);
+	error = ext3_xattr_ibody_get(inode, name_index, name, buffer,
+				     buffer_size);
+	if (error == -ENODATA)
+		error = ext3_xattr_block_get(inode, name_index, name, buffer,
+					     buffer_size);
 	up_read(&EXT3_I(inode)->xattr_sem);
 	return error;
 }
@@ -295,18 +355,8 @@
 	return buffer_size - rest;
 }
 
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
 int
-ext3_xattr_list(struct inode *inode, char *buffer, size_t buffer_size)
+ext3_xattr_block_list(struct inode *inode, char *buffer, size_t buffer_size)
 {
 	struct buffer_head *bh = NULL;
 	int error;
@@ -314,7 +364,6 @@
 	ea_idebug(inode, "buffer=%p, buffer_size=%ld",
 		  buffer, (long)buffer_size);
 
-	down_read(&EXT3_I(inode)->xattr_sem);
 	error = 0;
 	if (!EXT3_I(inode)->i_file_acl)
 		goto cleanup;
@@ -337,11 +386,71 @@
 
 cleanup:
 	brelse(bh);
-	up_read(&EXT3_I(inode)->xattr_sem);
 
 	return error;
 }
 
+static int
+ext3_xattr_ibody_list(struct inode *inode, char *buffer, size_t buffer_size)
+{
+	struct ext3_xattr_ibody_header *header;
+	struct ext3_inode *raw_inode;
+	struct ext3_iloc iloc;
+	void *end;
+	int error;
+
+	if (EXT3_SB(inode->i_sb)->s_inode_size <= EXT3_GOOD_OLD_INODE_SIZE ||
+	    !(EXT3_I(inode)->i_state & EXT3_STATE_XATTR))
+		return 0;
+	error = ext3_get_inode_loc(inode, &iloc);
+	if (error)
+		return error;
+	raw_inode = ext3_raw_inode(&iloc);
+	header = IHDR(inode, raw_inode);
+	end = (void *)raw_inode + EXT3_SB(inode->i_sb)->s_inode_size;
+	error = ext3_xattr_check_names(IFIRST(header), end);
+	if (error)
+		goto cleanup;
+	error = ext3_xattr_list_entries(inode, IFIRST(header),
+					buffer, buffer_size);
+
+cleanup:
+	brelse(iloc.bh);
+	return error;
+}
+
+/*
+ * ext3_xattr_list()
+ *
+ * Copy a list of attribute names into the buffer
+ * provided, or compute the buffer size required.
+ * Buffer is NULL to compute the size of the buffer required.
+ *
+ * Returns a negative error number on failure, or the number of bytes
+ * used / required on success.
+ */
+int
+ext3_xattr_list(struct inode *inode, char *buffer, size_t buffer_size)
+{
+	int i_error, b_error;
+
+	down_read(&EXT3_I(inode)->xattr_sem);
+	i_error = ext3_xattr_ibody_list(inode, buffer, buffer_size);
+	if (i_error < 0) {
+		b_error = 0;
+	} else {
+		if (buffer) {
+			buffer += i_error;
+			buffer_size -= i_error;
+		}
+		b_error = ext3_xattr_block_list(inode, buffer, buffer_size);
+		if (b_error < 0)
+			i_error = 0;
+	}
+	up_read(&EXT3_I(inode)->xattr_sem);
+	return i_error + b_error;
+}
+
 /*
  * If the EXT3_FEATURE_COMPAT_EXT_ATTR feature of this file system is
  * not set, set it.
@@ -514,175 +623,146 @@
 	return 0;
 }
 
-/*
- * ext3_xattr_set_handle()
- *
- * Create, replace or remove an extended attribute for this inode. Buffer
- * is NULL to remove an existing extended attribute, and non-NULL to
- * either replace an existing extended attribute, or create a new extended
- * attribute. The flags XATTR_REPLACE and XATTR_CREATE
- * specify that an extended attribute must exist and must not exist
- * previous to the call, respectively.
- *
- * Returns 0, or a negative error number on failure.
- */
+struct ext3_xattr_block_find {
+	struct ext3_xattr_search s;
+	struct buffer_head *bh;
+};
+
 int
-ext3_xattr_set_handle(handle_t *handle, struct inode *inode, int name_index,
-		      const char *name, const void *value, size_t value_len,
-		      int flags)
+ext3_xattr_block_find(struct inode *inode, struct ext3_xattr_info *i,
+		      struct ext3_xattr_block_find *bs)
 {
 	struct super_block *sb = inode->i_sb;
-	struct buffer_head *old_bh = NULL, *new_bh = NULL;
-	struct ext3_xattr_info i = {
-		.name_index = name_index,
-		.name = name,
-		.value = value,
-		.value_len = value_len,
-	};
-	struct ext3_xattr_search s = {
-		.not_found = 1,
-	};
-	struct mb_cache_entry *ce = NULL;
 	int error;
 
-#define header ((struct ext3_xattr_header *)(s.base))
-
-	/*
-	 * header -- Points either into bh, or to a temporarily
-	 *           allocated buffer.
-	 */
-
 	ea_idebug(inode, "name=%d.%s, value=%p, value_len=%ld",
-		  name_index, name, value, (long)value_len);
+		  i->name_index, i->name, i->value, (long)i->value_len);
 
-	if (IS_RDONLY(inode))
-		return -EROFS;
-	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
-		return -EPERM;
-	if (i.value == NULL)
-		i.value_len = 0;
-	down_write(&EXT3_I(inode)->xattr_sem);
 	if (EXT3_I(inode)->i_file_acl) {
 		/* The inode already has an extended attribute block. */
-		old_bh = sb_bread(sb, EXT3_I(inode)->i_file_acl);
+		bs->bh = sb_bread(sb, EXT3_I(inode)->i_file_acl);
 		error = -EIO;
-		if (!old_bh)
+		if (!bs->bh)
 			goto cleanup;
-		ea_bdebug(old_bh, "b_count=%d, refcount=%d",
-			atomic_read(&(old_bh->b_count)),
-			le32_to_cpu(BHDR(old_bh)->h_refcount));
-		if (ext3_xattr_check_block(old_bh)) {
-bad_block:		ext3_error(sb, __FUNCTION__,
+		ea_bdebug(bs->bh, "b_count=%d, refcount=%d",
+			atomic_read(&(bs->bh->b_count)),
+			le32_to_cpu(BHDR(bs->bh)->h_refcount));
+		if (ext3_xattr_check_block(bs->bh)) {
+			ext3_error(sb, __FUNCTION__,
 				"inode %ld: bad block %d", inode->i_ino,
 				EXT3_I(inode)->i_file_acl);
 			error = -EIO;
 			goto cleanup;
 		}
 		/* Find the named attribute. */
-		s.base = BHDR(old_bh);
-		s.first = BFIRST(old_bh);
-		s.end = old_bh->b_data + old_bh->b_size;
-		s.here = BFIRST(old_bh);
-		error = ext3_xattr_find_entry(&s.here, name_index, name,
-					      old_bh->b_size, 1);
+		bs->s.base = BHDR(bs->bh);
+		bs->s.first = BFIRST(bs->bh);
+		bs->s.end = bs->bh->b_data + bs->bh->b_size;
+		bs->s.here = bs->s.first;
+		error = ext3_xattr_find_entry(&bs->s.here, i->name_index,
+					      i->name, bs->bh->b_size, 1);
 		if (error && error != -ENODATA)
 			goto cleanup;
-		s.not_found = error;
+		bs->s.not_found = error;
 	}
+	error = 0;
 
-	if (s.not_found) {
-		/* Request to remove a nonexistent attribute? */
-		error = -ENODATA;
-		if (flags & XATTR_REPLACE)
-			goto cleanup;
-		error = 0;
-		if (value == NULL)
-			goto cleanup;
-	} else {
-		/* Request to create an existing attribute? */
-		error = -EEXIST;
-		if (flags & XATTR_CREATE)
-			goto cleanup;
-	}
+cleanup:
+	return error;
+}
 
-	if (header) {
-		/* assert(header == BHDR(old_bh)); */
-		ce = mb_cache_entry_get(ext3_xattr_cache, old_bh->b_bdev,
-					old_bh->b_blocknr);
-		if (header->h_refcount == cpu_to_le32(1)) {
+static int
+ext3_xattr_block_set(handle_t *handle, struct inode *inode,
+		     struct ext3_xattr_info *i,
+		     struct ext3_xattr_block_find *bs)
+{
+	struct super_block *sb = inode->i_sb;
+	struct buffer_head *new_bh = NULL;
+	struct ext3_xattr_search *s = &bs->s;
+	struct mb_cache_entry *ce = NULL;
+	int error;
+
+#define header(x) ((struct ext3_xattr_header *)(x))
+
+	if (i->value && i->value_len > sb->s_blocksize)
+		return -ENOSPC;
+	if (s->base) {
+		ce = mb_cache_entry_get(ext3_xattr_cache, bs->bh->b_bdev,
+					bs->bh->b_blocknr);
+		if (header(s->base)->h_refcount == cpu_to_le32(1)) {
 			if (ce) {
 				mb_cache_entry_free(ce);
 				ce = NULL;
 			}
-			ea_bdebug(old_bh, "modifying in-place");
-			error = ext3_journal_get_write_access(handle, old_bh);
+			ea_bdebug(bs->bh, "modifying in-place");
+			error = ext3_journal_get_write_access(handle, bs->bh);
 			if (error)
 				goto cleanup;
-			lock_buffer(old_bh);
-			error = ext3_xattr_set_entry(&i, &s);
+			lock_buffer(bs->bh);
+			error = ext3_xattr_set_entry(i, s);
 			if (!error) {
-				if (!IS_LAST_ENTRY(s.first))
-					ext3_xattr_rehash(header, s.here);
-				ext3_xattr_cache_insert(old_bh);
+				if (!IS_LAST_ENTRY(s->first))
+					ext3_xattr_rehash(header(s->base),
+							  s->here);
+				ext3_xattr_cache_insert(bs->bh);
 			}
-			unlock_buffer(old_bh);
+			unlock_buffer(bs->bh);
 			if (error == -EIO)
 				goto bad_block;
-			if (!error && old_bh && header == BHDR(old_bh)) {
+			if (!error)
 				error = ext3_journal_dirty_metadata(handle,
-								    old_bh);
-			}
+								    bs->bh);
 			if (error)
 				goto cleanup;
 			goto inserted;
 		} else {
-			int offset = (char *)s.here - old_bh->b_data;
+			int offset = (char *)s->here - bs->bh->b_data;
 
 			if (ce) {
 				mb_cache_entry_release(ce);
 				ce = NULL;
 			}
-			ea_bdebug(old_bh, "cloning");
-			s.base = kmalloc(old_bh->b_size, GFP_KERNEL);
-			/*assert(header == s.base)*/
+			ea_bdebug(bs->bh, "cloning");
+			s->base = kmalloc(bs->bh->b_size, GFP_KERNEL);
 			error = -ENOMEM;
-			if (header == NULL)
+			if (s->base == NULL)
 				goto cleanup;
-			memcpy(header, BHDR(old_bh), old_bh->b_size);
-			s.first = ENTRY(header+1);
-			header->h_refcount = cpu_to_le32(1);
-			s.here = ENTRY(s.base + offset);
-			s.end = header + old_bh->b_size;
+			memcpy(s->base, BHDR(bs->bh), bs->bh->b_size);
+			s->first = ENTRY(header(s->base)+1);
+			header(s->base)->h_refcount = cpu_to_le32(1);
+			s->here = ENTRY(s->base + offset);
+			s->end = s->base + bs->bh->b_size;
 		}
 	} else {
 		/* Allocate a buffer where we construct the new block. */
-		s.base = kmalloc(sb->s_blocksize, GFP_KERNEL);
-		/*assert(header == s.base)*/
+		s->base = kmalloc(sb->s_blocksize, GFP_KERNEL);
+		/* assert(header == s->base) */
 		error = -ENOMEM;
-		if (header == NULL)
+		if (s->base == NULL)
 			goto cleanup;
-		memset(header, 0, sb->s_blocksize);
-		header->h_magic = cpu_to_le32(EXT3_XATTR_MAGIC);
-		header->h_blocks = header->h_refcount = cpu_to_le32(1);
-		s.first = ENTRY(header+1);
-		s.here = ENTRY(header+1);
-		s.end = (void *)header + sb->s_blocksize;
+		memset(s->base, 0, sb->s_blocksize);
+		header(s->base)->h_magic = cpu_to_le32(EXT3_XATTR_MAGIC);
+		header(s->base)->h_blocks = cpu_to_le32(1);
+		header(s->base)->h_refcount = cpu_to_le32(1);
+		s->first = ENTRY(header(s->base)+1);
+		s->here = ENTRY(header(s->base)+1);
+		s->end = s->base + sb->s_blocksize;
 	}
 
-	error = ext3_xattr_set_entry(&i, &s);
+	error = ext3_xattr_set_entry(i, s);
 	if (error == -EIO)
 		goto bad_block;
 	if (error)
 		goto cleanup;
-	if (!IS_LAST_ENTRY(s.first))
-		ext3_xattr_rehash(header, s.here);
+	if (!IS_LAST_ENTRY(s->first))
+		ext3_xattr_rehash(header(s->base), s->here);
 
 inserted:
-	if (!IS_LAST_ENTRY(s.first)) {
-		new_bh = ext3_xattr_cache_find(inode, header, &ce);
+	if (!IS_LAST_ENTRY(s->first)) {
+		new_bh = ext3_xattr_cache_find(inode, header(s->base), &ce);
 		if (new_bh) {
 			/* We found an identical block in the cache. */
-			if (new_bh == old_bh)
+			if (new_bh == bs->bh)
 				ea_bdebug(new_bh, "keeping");
 			else {
 				/* The old block is released after updating
@@ -690,7 +770,8 @@
 				error = -EDQUOT;
 				if (DQUOT_ALLOC_BLOCK(inode, 1))
 					goto cleanup;
-				error = ext3_journal_get_write_access(handle, new_bh);
+				error = ext3_journal_get_write_access(handle,
+								      new_bh);
 				if (error)
 					goto cleanup;
 				lock_buffer(new_bh);
@@ -706,10 +787,10 @@
 			}
 			mb_cache_entry_release(ce);
 			ce = NULL;
-		} else if (old_bh && header == BHDR(old_bh)) {
+		} else if (bs->bh && s->base == bs->bh->b_data) {
 			/* We were modifying this block in-place. */
-			ea_bdebug(old_bh, "keeping this block");
-			new_bh = old_bh;
+			ea_bdebug(bs->bh, "keeping this block");
+			new_bh = bs->bh;
 			get_bh(new_bh);
 		} else {
 			/* We need to allocate a new block */
@@ -735,7 +816,7 @@
 				unlock_buffer(new_bh);
 				goto getblk_failed;
 			}
-			memcpy(new_bh->b_data, header, new_bh->b_size);
+			memcpy(new_bh->b_data, s->base, new_bh->b_size);
 			set_buffer_uptodate(new_bh);
 			unlock_buffer(new_bh);
 			ext3_xattr_cache_insert(new_bh);
@@ -748,30 +829,196 @@
 
 	/* Update the inode. */
 	EXT3_I(inode)->i_file_acl = new_bh ? new_bh->b_blocknr : 0;
-	inode->i_ctime = CURRENT_TIME_SEC;
-	ext3_mark_inode_dirty(handle, inode);
-	if (IS_SYNC(inode))
-		handle->h_sync = 1;
 
 	/* Drop the previous xattr block. */
-	if (old_bh && old_bh != new_bh)
-		ext3_xattr_release_block(handle, inode, old_bh);
+	if (bs->bh && bs->bh != new_bh)
+		ext3_xattr_release_block(handle, inode, bs->bh);
 	error = 0;
 
 cleanup:
 	if (ce)
 		mb_cache_entry_release(ce);
 	brelse(new_bh);
-	brelse(old_bh);
-	if (!(old_bh && header == BHDR(old_bh)))
-		kfree(header);
-	up_write(&EXT3_I(inode)->xattr_sem);
+	if (!(bs->bh && s->base == bs->bh->b_data))
+		kfree(s->base);
 
 	return error;
 
+bad_block:
+	ext3_error(inode->i_sb, __FUNCTION__,
+		   "inode %ld: bad block %d", inode->i_ino,
+		   EXT3_I(inode)->i_file_acl);
+	goto cleanup;
+
 #undef header
 }
 
+struct ext3_xattr_ibody_find {
+	struct ext3_xattr_search s;
+	struct ext3_iloc iloc;
+};
+
+int
+ext3_xattr_ibody_find(struct inode *inode, struct ext3_xattr_info *i,
+		      struct ext3_xattr_ibody_find *is)
+{
+	struct ext3_xattr_ibody_header *header;
+	struct ext3_inode *raw_inode;
+	int error;
+
+	if (EXT3_SB(inode->i_sb)->s_inode_size <= EXT3_GOOD_OLD_INODE_SIZE)
+		return 0;
+	raw_inode = ext3_raw_inode(&is->iloc);
+	header = IHDR(inode, raw_inode);
+	is->s.base = is->s.first = IFIRST(header);
+	is->s.here = is->s.first;
+	is->s.end = (void *)raw_inode + EXT3_SB(inode->i_sb)->s_inode_size;
+	if (EXT3_I(inode)->i_state & EXT3_STATE_XATTR) {
+		error = ext3_xattr_check_names(IFIRST(header), is->s.end);
+		if (error)
+			return error;
+		/* Find the named attribute. */
+		error = ext3_xattr_find_entry(&is->s.here, i->name_index,
+					      i->name, is->s.end -
+					      (void *)is->s.base, 0);
+		if (error && error != -ENODATA)
+			return error;
+		is->s.not_found = error;
+	}
+	return 0;
+}
+
+static int
+ext3_xattr_ibody_set(handle_t *handle, struct inode *inode,
+		     struct ext3_xattr_info *i,
+		     struct ext3_xattr_ibody_find *is)
+{
+	struct ext3_xattr_ibody_header *header;
+	struct ext3_xattr_search *s = &is->s;
+	int error;
+	
+	if (EXT3_SB(inode->i_sb)->s_inode_size <= EXT3_GOOD_OLD_INODE_SIZE)
+		return -ENOSPC;
+	error = ext3_xattr_set_entry(i, s);
+	if (error)
+		return error;
+	header = IHDR(inode, ext3_raw_inode(&is->iloc));
+	if (!IS_LAST_ENTRY(s->first)) {
+		header->h_magic = cpu_to_le32(EXT3_XATTR_MAGIC);
+		EXT3_I(inode)->i_state |= EXT3_STATE_XATTR;
+	} else {
+		header->h_magic = cpu_to_le32(0);
+		EXT3_I(inode)->i_state &= ~EXT3_STATE_XATTR;
+	}
+	return 0;
+}
+
+/*
+ * ext3_xattr_set_handle()
+ *
+ * Create, replace or remove an extended attribute for this inode. Buffer
+ * is NULL to remove an existing extended attribute, and non-NULL to
+ * either replace an existing extended attribute, or create a new extended
+ * attribute. The flags XATTR_REPLACE and XATTR_CREATE
+ * specify that an extended attribute must exist and must not exist
+ * previous to the call, respectively.
+ *
+ * Returns 0, or a negative error number on failure.
+ */
+int
+ext3_xattr_set_handle(handle_t *handle, struct inode *inode, int name_index,
+		      const char *name, const void *value, size_t value_len,
+		      int flags)
+{
+	struct ext3_xattr_info i = {
+		.name_index = name_index,
+		.name = name,
+		.value = value,
+		.value_len = value_len,
+
+	};
+	struct ext3_xattr_ibody_find is = {
+		.s = { .not_found = -ENODATA, },
+	};
+	struct ext3_xattr_block_find bs = {
+		.s = { .not_found = -ENODATA, },
+	};
+	int error;
+
+	if (IS_RDONLY(inode))
+		return -EROFS;
+	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
+		return -EPERM;
+	if (!name)
+		return -EINVAL;
+	if (strlen(name) > 255)
+		return -ERANGE;
+	down_write(&EXT3_I(inode)->xattr_sem);
+	error = ext3_get_inode_loc(inode, &is.iloc);
+	if (error)
+		goto cleanup;
+	error = ext3_xattr_ibody_find(inode, &i, &is);
+	if (error)
+		goto cleanup;
+	if (is.s.not_found)
+		error = ext3_xattr_block_find(inode, &i, &bs);
+	if (error)
+		goto cleanup;
+	if (is.s.not_found && bs.s.not_found) {
+		error = -ENODATA;
+		if (flags & XATTR_REPLACE)
+			goto cleanup;
+		error = 0;
+		if (!value)
+			goto cleanup;
+	} else {
+		error = -EEXIST;
+		if (flags & XATTR_CREATE)
+			goto cleanup;
+	}
+	error = ext3_journal_get_write_access(handle, is.iloc.bh);
+	if (error)
+		goto cleanup;
+	if (!value) {
+		if (!is.s.not_found)
+			error = ext3_xattr_ibody_set(handle, inode, &i, &is);
+		else if (!bs.s.not_found)
+			error = ext3_xattr_block_set(handle, inode, &i, &bs);
+	} else {
+		error = ext3_xattr_ibody_set(handle, inode, &i, &is);
+		if (!error && !bs.s.not_found) {
+			i.value = NULL;
+			error = ext3_xattr_block_set(handle, inode, &i, &bs);
+		} else if (error == -ENOSPC) {
+			error = ext3_xattr_block_set(handle, inode, &i, &bs);
+			if (error)
+				goto cleanup;
+			if (!is.s.not_found) {
+				i.value = NULL;
+				error = ext3_xattr_ibody_set(handle, inode, &i,
+							     &is);
+			}
+		}
+	}
+	if (!error) {
+		inode->i_ctime = CURRENT_TIME_SEC;
+		error = ext3_mark_iloc_dirty(handle, inode, &is.iloc);
+		/*
+		 * The bh is consumed by ext3_mark_iloc_dirty, even with
+		 * error != 0.
+		 */
+		is.iloc.bh = NULL;
+		if (IS_SYNC(inode))
+			handle->h_sync = 1;
+	}
+
+cleanup:
+	brelse(is.iloc.bh);
+	brelse(bs.bh);
+	up_write(&EXT3_I(inode)->xattr_sem);
+	return error;
+}
+
 /*
  * ext3_xattr_set()
  *
Index: linux-2.6.10/fs/ext3/inode.c
===================================================================
--- linux-2.6.10.orig/fs/ext3/inode.c	2005-01-11 01:38:40.000000000 +0100
+++ linux-2.6.10/fs/ext3/inode.c	2005-01-11 01:38:40.000000000 +0100
@@ -2383,7 +2383,9 @@
 
 int ext3_get_inode_loc(struct inode *inode, struct ext3_iloc *iloc)
 {
-	return __ext3_get_inode_loc(inode, iloc, 1);
+	/* We have all inode data except xattrs in memory here. */
+	return __ext3_get_inode_loc(inode, iloc,
+		!(EXT3_I(inode)->i_state & EXT3_STATE_XATTR));
 }
 
 void ext3_set_inode_flags(struct inode *inode)
@@ -2489,6 +2491,16 @@
 		ei->i_data[block] = raw_inode->i_block[block];
 	INIT_LIST_HEAD(&ei->i_orphan);
 
+	ei->i_extra_isize =
+		(EXT3_INODE_SIZE(inode->i_sb) > EXT3_GOOD_OLD_INODE_SIZE) ?
+		le16_to_cpu(raw_inode->i_extra_isize) : 0;
+	if (ei->i_extra_isize) {
+		__le32 *magic = (void *)raw_inode + EXT3_GOOD_OLD_INODE_SIZE +
+				ei->i_extra_isize;
+		if (le32_to_cpu(*magic))
+			 ei->i_state |= EXT3_STATE_XATTR;
+	}
+
 	if (S_ISREG(inode->i_mode)) {
 		inode->i_op = &ext3_file_inode_operations;
 		inode->i_fop = &ext3_file_operations;
@@ -2624,6 +2636,9 @@
 	} else for (block = 0; block < EXT3_N_BLOCKS; block++)
 		raw_inode->i_block[block] = ei->i_data[block];
 
+	if (EXT3_INODE_SIZE(inode->i_sb) > EXT3_GOOD_OLD_INODE_SIZE)
+		raw_inode->i_extra_isize = cpu_to_le16(ei->i_extra_isize);
+
 	BUFFER_TRACE(bh, "call ext3_journal_dirty_metadata");
 	rc = ext3_journal_dirty_metadata(handle, bh);
 	if (!err)
Index: linux-2.6.10/fs/ext3/xattr.h
===================================================================
--- linux-2.6.10.orig/fs/ext3/xattr.h	2005-01-11 00:54:42.000000000 +0100
+++ linux-2.6.10/fs/ext3/xattr.h	2005-01-11 01:38:40.000000000 +0100
@@ -31,6 +31,10 @@
 	__u32	h_reserved[4];	/* zero right now */
 };
 
+struct ext3_xattr_ibody_header {
+	__le32	h_magic;	/* magic number for identification */
+};
+
 struct ext3_xattr_entry {
 	__u8	e_name_len;	/* length of name */
 	__u8	e_name_index;	/* attribute name index */
Index: linux-2.6.10/include/linux/ext3_fs.h
===================================================================
--- linux-2.6.10.orig/include/linux/ext3_fs.h	2005-01-11 01:38:40.000000000 +0100
+++ linux-2.6.10/include/linux/ext3_fs.h	2005-01-11 01:38:40.000000000 +0100
@@ -195,7 +195,7 @@
  */
 #define EXT3_STATE_JDATA		0x00000001 /* journaled data exists */
 #define EXT3_STATE_NEW			0x00000002 /* inode is newly created */
-
+#define EXT3_STATE_XATTR		0x00000004 /* has in-inode xattrs */
 
 /* Used to pass group descriptor data when online resize is done */
 struct ext3_new_group_input {
@@ -293,6 +293,8 @@
 			__u32	m_i_reserved2[2];
 		} masix2;
 	} osd2;				/* OS dependent 2 */
+	__le16	i_extra_isize;
+	__le16	i_pad1;
 };
 
 #define i_size_high	i_dir_acl
Index: linux-2.6.10/include/linux/ext3_fs_i.h
===================================================================
--- linux-2.6.10.orig/include/linux/ext3_fs_i.h	2005-01-11 00:54:42.000000000 +0100
+++ linux-2.6.10/include/linux/ext3_fs_i.h	2005-01-11 02:57:54.128575944 +0100
@@ -113,6 +113,9 @@
 	 */
 	loff_t	i_disksize;
 
+	/* on-disk additional length */
+	__u16 i_extra_isize;
+
 	/*
 	 * truncate_sem is for serialising ext3_truncate() against
 	 * ext3_getblock().  In the 2.4 ext2 design, great chunks of inode's
Index: linux-2.6.10/fs/ext3/ialloc.c
===================================================================
--- linux-2.6.10.orig/fs/ext3/ialloc.c	2005-01-11 00:54:42.000000000 +0100
+++ linux-2.6.10/fs/ext3/ialloc.c	2005-01-11 01:38:40.000000000 +0100
@@ -596,6 +596,9 @@
 	spin_unlock(&sbi->s_next_gen_lock);
 
 	ei->i_state = EXT3_STATE_NEW;
+	ei->i_extra_isize =
+		(EXT3_INODE_SIZE(inode->i_sb) > EXT3_GOOD_OLD_INODE_SIZE) ?
+		sizeof(struct ext3_inode) - EXT3_GOOD_OLD_INODE_SIZE : 0;
 
 	ret = inode;
 	if(DQUOT_ALLOC_INODE(inode)) {
--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH

