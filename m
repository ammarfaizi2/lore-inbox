Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261571AbVAMLDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbVAMLDY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 06:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261599AbVAMLDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 06:03:24 -0500
Received: from news.suse.de ([195.135.220.2]:64918 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261571AbVAMKky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 05:40:54 -0500
Date: Thu, 13 Jan 2005 11:31:43 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Alex Tomas <alex@clusterfs.com>,
       Andreas Dilger <adilger@clusterfs.com>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Andrew Tridgell <tridge@samba.org>
Subject: [RESEND][PATCH 7/9] Ext3: extended attribute sharing fixes and in-inode EAs
Message-Id: <1105549936.94447@suse.de>
References: <1105549936.694778@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup and prepare ext3 for in-inode xattrs

Clean up several things in the xattr code, and prepare it for
in-inode attributes:

* Add the ext3_xattr_check_names, ext3_xattr_check_block, and
  ext3_xattr_check_entry functions for checking xattr data
  structures.
* Add the ext3_xattr_find_entry, ext3_xattr_list_entries, and
  ext3_xattr_set_entry functions for manipulating xattr entries.
  Switch to using these functions in ext3_xattr_get,
  ext3_xattr_list, and ext3_xattr_set_handle.
* Merge ext3_xattr_set_handle and ext3_xattr_set_handle2.
* Rename the HDR and FIRST_ENTRY macros.
* We have no way to deal with a ext3_xattr_cache_insert failure,
  so make it return void.
* Make the debug messages more useful.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.10/fs/ext2/xattr.c
===================================================================
--- linux-2.6.10.orig/fs/ext2/xattr.c
+++ linux-2.6.10/fs/ext2/xattr.c
@@ -24,7 +24,7 @@
  *
  *   +------------------+
  *   | header           |
- *   ¦ entry 1          | |
+ *   | entry 1          | |
  *   | entry 2          | | growing downwards
  *   | entry 3          | v
  *   | four null bytes  |
Index: linux-2.6.10/fs/ext3/xattr.c
===================================================================
--- linux-2.6.10.orig/fs/ext3/xattr.c
+++ linux-2.6.10/fs/ext3/xattr.c
@@ -24,7 +24,7 @@
  *
  *   +------------------+
  *   | header           |
- *   ¦ entry 1          | |
+ *   | entry 1          | |
  *   | entry 2          | | growing downwards
  *   | entry 3          | v
  *   | four null bytes  |
@@ -64,9 +64,9 @@
 #include "xattr.h"
 #include "acl.h"
 
-#define HDR(bh) ((struct ext3_xattr_header *)((bh)->b_data))
+#define BHDR(bh) ((struct ext3_xattr_header *)((bh)->b_data))
 #define ENTRY(ptr) ((struct ext3_xattr_entry *)(ptr))
-#define FIRST_ENTRY(bh) ENTRY(HDR(bh)+1)
+#define BFIRST(bh) ENTRY(BHDR(bh)+1)
 #define IS_LAST_ENTRY(entry) (*(__u32 *)(entry) == 0)
 
 #ifdef EXT3_XATTR_DEBUG
@@ -89,11 +89,7 @@
 # define ea_bdebug(f...)
 #endif
 
-static int ext3_xattr_set_handle2(handle_t *, struct inode *,
-				  struct buffer_head *,
-				  struct ext3_xattr_header *);
-
-static int ext3_xattr_cache_insert(struct buffer_head *);
+static void ext3_xattr_cache_insert(struct buffer_head *);
 static struct buffer_head *ext3_xattr_cache_find(struct inode *,
 						 struct ext3_xattr_header *,
 						 struct mb_cache_entry **);
@@ -148,6 +144,68 @@ ext3_listxattr(struct dentry *dentry, ch
 	return ext3_xattr_list(dentry->d_inode, buffer, size);
 }
 
+static int
+ext3_xattr_check_names(struct ext3_xattr_entry *entry, void *end)
+{
+	while (!IS_LAST_ENTRY(entry)) {
+		struct ext3_xattr_entry *next = EXT3_XATTR_NEXT(entry);
+		if ((void *)next >= end)
+			return -EIO;
+		entry = next;
+	}
+	return 0;
+}
+
+static inline int
+ext3_xattr_check_block(struct buffer_head *bh)
+{
+	int error;
+
+	if (BHDR(bh)->h_magic != cpu_to_le32(EXT3_XATTR_MAGIC) ||
+	    BHDR(bh)->h_blocks != cpu_to_le32(1))
+		return -EIO;
+	error = ext3_xattr_check_names(BFIRST(bh), bh->b_data + bh->b_size);
+	return error;
+}
+
+static inline int
+ext3_xattr_check_entry(struct ext3_xattr_entry *entry, size_t size)
+{
+	size_t value_size = le32_to_cpu(entry->e_value_size);
+
+	if (entry->e_value_block != 0 || value_size > size ||
+	    le16_to_cpu(entry->e_value_offs) + value_size > size)
+		return -EIO;
+	return 0;
+}
+
+static int
+ext3_xattr_find_entry(struct ext3_xattr_entry **pentry, int name_index,
+		      const char *name, size_t size, int sorted)
+{
+	struct ext3_xattr_entry *entry;
+	size_t name_len;
+	int cmp = 1;
+
+	if (name == NULL)
+		return -EINVAL;
+	name_len = strlen(name);
+	entry = *pentry;
+	for (; !IS_LAST_ENTRY(entry); entry = EXT3_XATTR_NEXT(entry)) {
+		cmp = name_index - entry->e_name_index;
+		if (!cmp)
+			cmp = name_len - entry->e_name_len;
+		if (!cmp)
+			cmp = memcmp(name, entry->e_name, name_len);
+		if (cmp <= 0 && (sorted || cmp == 0))
+			break;
+	}
+	*pentry = entry;
+	if (!cmp && ext3_xattr_check_entry(entry, size))
+			return -EIO;
+	return cmp ? -ENODATA : 0;
+}
+
 /*
  * ext3_xattr_get()
  *
@@ -164,8 +222,7 @@ ext3_xattr_get(struct inode *inode, int 
 {
 	struct buffer_head *bh = NULL;
 	struct ext3_xattr_entry *entry;
-	size_t name_len, size;
-	char *end;
+	size_t size;
 	int error;
 
 	ea_idebug(inode, "name=%d.%s, buffer=%p, buffer_size=%ld",
@@ -179,78 +236,65 @@ ext3_xattr_get(struct inode *inode, int 
 		goto cleanup;
 	ea_idebug(inode, "reading block %d", EXT3_I(inode)->i_file_acl);
 	bh = sb_bread(inode->i_sb, EXT3_I(inode)->i_file_acl);
-	error = -EIO;
 	if (!bh)
 		goto cleanup;
 	ea_bdebug(bh, "b_count=%d, refcount=%d",
-		atomic_read(&(bh->b_count)), le32_to_cpu(HDR(bh)->h_refcount));
-	end = bh->b_data + bh->b_size;
-	if (HDR(bh)->h_magic != cpu_to_le32(EXT3_XATTR_MAGIC) ||
-	    HDR(bh)->h_blocks != cpu_to_le32(1)) {
-bad_block:	ext3_error(inode->i_sb, "ext3_xattr_get",
-			"inode %ld: bad block %d", inode->i_ino,
-			EXT3_I(inode)->i_file_acl);
+		atomic_read(&(bh->b_count)), le32_to_cpu(BHDR(bh)->h_refcount));
+	if (ext3_xattr_check_block(bh)) {
+bad_block:	ext3_error(inode->i_sb, __FUNCTION__,
+			   "inode %ld: bad block %d", inode->i_ino,
+			   EXT3_I(inode)->i_file_acl);
 		error = -EIO;
 		goto cleanup;
 	}
-	/* find named attribute */
-	name_len = strlen(name);
-
-	error = -ERANGE;
-	if (name_len > 255)
-		goto cleanup;
-	entry = FIRST_ENTRY(bh);
-	while (!IS_LAST_ENTRY(entry)) {
-		struct ext3_xattr_entry *next =
-			EXT3_XATTR_NEXT(entry);
-		if ((char *)next >= end)
-			goto bad_block;
-		if (name_index == entry->e_name_index &&
-		    name_len == entry->e_name_len &&
-		    memcmp(name, entry->e_name, name_len) == 0)
-			goto found;
-		entry = next;
-	}
-	/* Check the remaining name entries */
-	while (!IS_LAST_ENTRY(entry)) {
-		struct ext3_xattr_entry *next =
-			EXT3_XATTR_NEXT(entry);
-		if ((char *)next >= end)
-			goto bad_block;
-		entry = next;
-	}
-	if (ext3_xattr_cache_insert(bh))
-		ea_idebug(inode, "cache insert failed");
-	error = -ENODATA;
-	goto cleanup;
-found:
-	/* check the buffer size */
-	if (entry->e_value_block != 0)
+	ext3_xattr_cache_insert(bh);
+	entry = BFIRST(bh);
+	error = ext3_xattr_find_entry(&entry, name_index, name, bh->b_size, 1);
+	if (error == -EIO)
 		goto bad_block;
+	if (error)
+		goto cleanup;
 	size = le32_to_cpu(entry->e_value_size);
-	if (size > inode->i_sb->s_blocksize ||
-	    le16_to_cpu(entry->e_value_offs) + size > inode->i_sb->s_blocksize)
-		goto bad_block;
-
-	if (ext3_xattr_cache_insert(bh))
-		ea_idebug(inode, "cache insert failed");
 	if (buffer) {
 		error = -ERANGE;
 		if (size > buffer_size)
 			goto cleanup;
-		/* return value of attribute */
 		memcpy(buffer, bh->b_data + le16_to_cpu(entry->e_value_offs),
-			size);
+		       size);
 	}
 	error = size;
 
 cleanup:
 	brelse(bh);
 	up_read(&EXT3_I(inode)->xattr_sem);
-
 	return error;
 }
 
+static int
+ext3_xattr_list_entries(struct inode *inode, struct ext3_xattr_entry *entry,
+			char *buffer, size_t buffer_size)
+{
+	size_t rest = buffer_size;
+
+	for (; !IS_LAST_ENTRY(entry); entry = EXT3_XATTR_NEXT(entry)) {
+		struct xattr_handler *handler =
+			ext3_xattr_handler(entry->e_name_index);
+
+		if (handler) {
+			size_t size = handler->list(inode, buffer, rest,
+						    entry->e_name,
+						    entry->e_name_len);
+			if (buffer) {
+				if (size > rest)
+					return -ERANGE;
+				buffer += size;
+			}
+			rest -= size;
+		}
+	}
+	return buffer_size - rest;
+}
+
 /*
  * ext3_xattr_list()
  *
@@ -265,9 +309,6 @@ int
 ext3_xattr_list(struct inode *inode, char *buffer, size_t buffer_size)
 {
 	struct buffer_head *bh = NULL;
-	struct ext3_xattr_entry *entry;
-	char *end;
-	size_t rest = buffer_size;
 	int error;
 
 	ea_idebug(inode, "buffer=%p, buffer_size=%ld",
@@ -283,50 +324,16 @@ ext3_xattr_list(struct inode *inode, cha
 	if (!bh)
 		goto cleanup;
 	ea_bdebug(bh, "b_count=%d, refcount=%d",
-		atomic_read(&(bh->b_count)), le32_to_cpu(HDR(bh)->h_refcount));
-	end = bh->b_data + bh->b_size;
-	if (HDR(bh)->h_magic != cpu_to_le32(EXT3_XATTR_MAGIC) ||
-	    HDR(bh)->h_blocks != cpu_to_le32(1)) {
-bad_block:	ext3_error(inode->i_sb, "ext3_xattr_list",
-			"inode %ld: bad block %d", inode->i_ino,
-			EXT3_I(inode)->i_file_acl);
+		atomic_read(&(bh->b_count)), le32_to_cpu(BHDR(bh)->h_refcount));
+	if (ext3_xattr_check_block(bh)) {
+		ext3_error(inode->i_sb, __FUNCTION__,
+			   "inode %ld: bad block %d", inode->i_ino,
+			   EXT3_I(inode)->i_file_acl);
 		error = -EIO;
 		goto cleanup;
 	}
-
-	/* check the on-disk data structure */
-	entry = FIRST_ENTRY(bh);
-	while (!IS_LAST_ENTRY(entry)) {
-		struct ext3_xattr_entry *next = EXT3_XATTR_NEXT(entry);
-
-		if ((char *)next >= end)
-			goto bad_block;
-		entry = next;
-	}
-	if (ext3_xattr_cache_insert(bh))
-		ea_idebug(inode, "cache insert failed");
-
-	/* list the attribute names */
-	for (entry = FIRST_ENTRY(bh); !IS_LAST_ENTRY(entry);
-	     entry = EXT3_XATTR_NEXT(entry)) {
-		struct xattr_handler *handler =
-			ext3_xattr_handler(entry->e_name_index);
-
-		if (handler) {
-			size_t size = handler->list(inode, buffer, rest,
-						    entry->e_name,
-						    entry->e_name_len);
-			if (buffer) {
-				if (size > rest) {
-					error = -ERANGE;
-					goto cleanup;
-				}
-				buffer += size;
-			}
-			rest -= size;
-		}
-	}
-	error = buffer_size - rest;  /* total size */
+	ext3_xattr_cache_insert(bh);
+	error = ext3_xattr_list_entries(inode, BFIRST(bh), buffer, buffer_size);
 
 cleanup:
 	brelse(bh);
@@ -366,8 +373,8 @@ ext3_xattr_release_block(handle_t *handl
 	struct mb_cache_entry *ce = NULL;
 
 	ce = mb_cache_entry_get(ext3_xattr_cache, bh->b_bdev, bh->b_blocknr);
-	if (HDR(bh)->h_refcount == cpu_to_le32(1)) {
-		ea_bdebug(bh, "freeing");
+	if (BHDR(bh)->h_refcount == cpu_to_le32(1)) {
+		ea_bdebug(bh, "refcount now=0; freeing");
 		if (ce)
 			mb_cache_entry_free(ce);
 		ext3_free_blocks(handle, inode, bh->b_blocknr, 1);
@@ -376,20 +383,137 @@ ext3_xattr_release_block(handle_t *handl
 	} else {
 		if (ext3_journal_get_write_access(handle, bh) == 0) {
 			lock_buffer(bh);
-			HDR(bh)->h_refcount = cpu_to_le32(
-				le32_to_cpu(HDR(bh)->h_refcount) - 1);
+			BHDR(bh)->h_refcount = cpu_to_le32(
+				le32_to_cpu(BHDR(bh)->h_refcount) - 1);
 			ext3_journal_dirty_metadata(handle, bh);
 			if (IS_SYNC(inode))
 				handle->h_sync = 1;
 			DQUOT_FREE_BLOCK(inode, 1);
 			unlock_buffer(bh);
-			ea_bdebug(bh, "refcount now=%d",
-				  le32_to_cpu(HDR(bh)->h_refcount) - 1);
+			ea_bdebug(bh, "refcount now=%d; releasing",
+				  le32_to_cpu(BHDR(bh)->h_refcount));
 		}
 		if (ce)
 			mb_cache_entry_release(ce);
 	}
 }
+
+struct ext3_xattr_info {
+	int name_index;
+	const char *name;
+	const void *value;
+	size_t value_len;
+};
+
+struct ext3_xattr_search {
+	struct ext3_xattr_entry *first;
+	void *base;
+	void *end;
+	struct ext3_xattr_entry *here;
+	int not_found;
+};
+
+static int
+ext3_xattr_set_entry(struct ext3_xattr_info *i, struct ext3_xattr_search *s)
+{
+	struct ext3_xattr_entry *last;
+	size_t free, min_offs = s->end - s->base, name_len = strlen(i->name);
+
+	/* Compute min_offs and last. */
+	last = s->first;
+	for (; !IS_LAST_ENTRY(last); last = EXT3_XATTR_NEXT(last)) {
+		if (!last->e_value_block && last->e_value_size) {
+			size_t offs = le16_to_cpu(last->e_value_offs);
+			if (offs < min_offs)
+				min_offs = offs;
+		}
+	}
+	free = min_offs - ((void *)last - s->base) - sizeof(__u32);
+	if (!s->not_found) {
+		if (!s->here->e_value_block && s->here->e_value_size) {
+			size_t size = le32_to_cpu(s->here->e_value_size);
+			free += EXT3_XATTR_SIZE(size);
+		}
+		free += EXT3_XATTR_LEN(name_len);
+	}
+	if (i->value) {
+		if (free < EXT3_XATTR_SIZE(i->value_len) ||
+		    free < EXT3_XATTR_LEN(name_len) +
+			   EXT3_XATTR_SIZE(i->value_len))
+			return -ENOSPC;
+	}
+
+	if (i->value && s->not_found) {
+		/* Insert the new name. */
+		size_t size = EXT3_XATTR_LEN(name_len);
+		size_t rest = (void *)last - (void *)s->here + sizeof(__u32);
+		memmove((void *)s->here + size, s->here, rest);
+		memset(s->here, 0, size);
+		s->here->e_name_index = i->name_index;
+		s->here->e_name_len = name_len;
+		memcpy(s->here->e_name, i->name, name_len);
+	} else {
+		if (!s->here->e_value_block && s->here->e_value_size) {
+			void *first_val = s->base + min_offs;
+			size_t offs = le16_to_cpu(s->here->e_value_offs);
+			void *val = s->base + offs;
+			size_t size = EXT3_XATTR_SIZE(
+				le32_to_cpu(s->here->e_value_size));
+
+			if (i->value && size == EXT3_XATTR_SIZE(i->value_len)) {
+				/* The old and the new value have the same
+				   size. Just replace. */
+				s->here->e_value_size =
+					cpu_to_le32(i->value_len);
+				memset(val + size - EXT3_XATTR_PAD, 0,
+				       EXT3_XATTR_PAD); /* Clear pad bytes. */
+				memcpy(val, i->value, i->value_len);
+				return 0;
+			}
+
+			/* Remove the old value. */
+			memmove(first_val + size, first_val, val - first_val);
+			memset(first_val, 0, size);
+			s->here->e_value_size = 0;
+			s->here->e_value_offs = 0;
+			min_offs += size;
+
+			/* Adjust all value offsets. */
+			last = s->first;
+			while (!IS_LAST_ENTRY(last)) {
+				size_t o = le16_to_cpu(last->e_value_offs);
+				if (!last->e_value_block &&
+				    last->e_value_size && o < offs)
+					last->e_value_offs =
+						cpu_to_le16(o + size);
+				last = EXT3_XATTR_NEXT(last);
+			}
+		}
+		if (!i->value) {
+			/* Remove the old name. */
+			size_t size = EXT3_XATTR_LEN(name_len);
+			last = ENTRY((void *)last - size);
+			memmove(s->here, (void *)s->here + size,
+				(void *)last - (void *)s->here + sizeof(__u32));
+			memset(last, 0, size);
+		}
+	}
+
+	if (i->value) {
+		/* Insert the new value. */
+		s->here->e_value_size = cpu_to_le32(i->value_len);
+		if (i->value_len) {
+			size_t size = EXT3_XATTR_SIZE(i->value_len);
+			void *val = s->base + min_offs - size;
+			s->here->e_value_offs = cpu_to_le16(min_offs - size);
+			memset(val + size - EXT3_XATTR_PAD, 0,
+			       EXT3_XATTR_PAD); /* Clear the pad bytes. */
+			memcpy(val, i->value, i->value_len);
+		}
+	}
+	return 0;
+}
+
 /*
  * ext3_xattr_set_handle()
  *
@@ -408,23 +532,24 @@ ext3_xattr_set_handle(handle_t *handle, 
 		      int flags)
 {
 	struct super_block *sb = inode->i_sb;
-	struct buffer_head *bh = NULL;
-	struct ext3_xattr_header *header = NULL;
-	struct ext3_xattr_entry *here, *last;
-	size_t name_len, free, min_offs = sb->s_blocksize;
-	int not_found = 1, error;
-	char *end;
+	struct buffer_head *old_bh = NULL, *new_bh = NULL;
+	struct ext3_xattr_info i = {
+		.name_index = name_index,
+		.name = name,
+		.value = value,
+		.value_len = value_len,
+	};
+	struct ext3_xattr_search s = {
+		.not_found = 1,
+	};
+	struct mb_cache_entry *ce = NULL;
+	int error;
+
+#define header ((struct ext3_xattr_header *)(s.base))
 
 	/*
 	 * header -- Points either into bh, or to a temporarily
 	 *           allocated buffer.
-	 * here -- The named entry found, or the place for inserting, within
-	 *         the block pointed to by header.
-	 * last -- Points right after the last named entry within the block
-	 *         pointed to by header.
-	 * min_offs -- The offset of the first value (values are aligned
-	 *             towards the end of the block).
-	 * end -- Points right after the block pointed to by header.
 	 */
 
 	ea_idebug(inode, "name=%d.%s, value=%p, value_len=%ld",
@@ -434,77 +559,38 @@ ext3_xattr_set_handle(handle_t *handle, 
 		return -EROFS;
 	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
 		return -EPERM;
-	if (value == NULL)
-		value_len = 0;
-	if (name == NULL)
-		return -EINVAL;
-	name_len = strlen(name);
-	if (name_len > 255 || value_len > sb->s_blocksize)
-		return -ERANGE;
+	if (i.value == NULL)
+		i.value_len = 0;
 	down_write(&EXT3_I(inode)->xattr_sem);
 	if (EXT3_I(inode)->i_file_acl) {
 		/* The inode already has an extended attribute block. */
-		bh = sb_bread(sb, EXT3_I(inode)->i_file_acl);
+		old_bh = sb_bread(sb, EXT3_I(inode)->i_file_acl);
 		error = -EIO;
-		if (!bh)
+		if (!old_bh)
 			goto cleanup;
-		ea_bdebug(bh, "b_count=%d, refcount=%d",
-			atomic_read(&(bh->b_count)),
-			le32_to_cpu(HDR(bh)->h_refcount));
-		header = HDR(bh);
-		end = bh->b_data + bh->b_size;
-		if (header->h_magic != cpu_to_le32(EXT3_XATTR_MAGIC) ||
-		    header->h_blocks != cpu_to_le32(1)) {
-bad_block:		ext3_error(sb, "ext3_xattr_set",
+		ea_bdebug(old_bh, "b_count=%d, refcount=%d",
+			atomic_read(&(old_bh->b_count)),
+			le32_to_cpu(BHDR(old_bh)->h_refcount));
+		if (ext3_xattr_check_block(old_bh)) {
+bad_block:		ext3_error(sb, __FUNCTION__,
 				"inode %ld: bad block %d", inode->i_ino,
 				EXT3_I(inode)->i_file_acl);
 			error = -EIO;
 			goto cleanup;
 		}
 		/* Find the named attribute. */
-		here = FIRST_ENTRY(bh);
-		while (!IS_LAST_ENTRY(here)) {
-			struct ext3_xattr_entry *next = EXT3_XATTR_NEXT(here);
-			if ((char *)next >= end)
-				goto bad_block;
-			if (!here->e_value_block && here->e_value_size) {
-				size_t offs = le16_to_cpu(here->e_value_offs);
-				if (offs < min_offs)
-					min_offs = offs;
-			}
-			not_found = name_index - here->e_name_index;
-			if (!not_found)
-				not_found = name_len - here->e_name_len;
-			if (!not_found)
-				not_found = memcmp(name, here->e_name,name_len);
-			if (not_found <= 0)
-				break;
-			here = next;
-		}
-		last = here;
-		/* We still need to compute min_offs and last. */
-		while (!IS_LAST_ENTRY(last)) {
-			struct ext3_xattr_entry *next = EXT3_XATTR_NEXT(last);
-			if ((char *)next >= end)
-				goto bad_block;
-			if (!last->e_value_block && last->e_value_size) {
-				size_t offs = le16_to_cpu(last->e_value_offs);
-				if (offs < min_offs)
-					min_offs = offs;
-			}
-			last = next;
-		}
-
-		/* Check whether we have enough space left. */
-		free = min_offs - ((char*)last - (char*)header) - sizeof(__u32);
-	} else {
-		/* We will use a new extended attribute block. */
-		free = sb->s_blocksize -
-			sizeof(struct ext3_xattr_header) - sizeof(__u32);
-		here = last = NULL;  /* avoid gcc uninitialized warning. */
+		s.base = BHDR(old_bh);
+		s.first = BFIRST(old_bh);
+		s.end = old_bh->b_data + old_bh->b_size;
+		s.here = BFIRST(old_bh);
+		error = ext3_xattr_find_entry(&s.here, name_index, name,
+					      old_bh->b_size, 1);
+		if (error && error != -ENODATA)
+			goto cleanup;
+		s.not_found = error;
 	}
 
-	if (not_found) {
+	if (s.not_found) {
 		/* Request to remove a nonexistent attribute? */
 		error = -ENODATA;
 		if (flags & XATTR_REPLACE)
@@ -517,183 +603,90 @@ bad_block:		ext3_error(sb, "ext3_xattr_s
 		error = -EEXIST;
 		if (flags & XATTR_CREATE)
 			goto cleanup;
-		if (!here->e_value_block && here->e_value_size) {
-			size_t size = le32_to_cpu(here->e_value_size);
-
-			if (le16_to_cpu(here->e_value_offs) + size > 
-			    sb->s_blocksize || size > sb->s_blocksize)
-				goto bad_block;
-			free += EXT3_XATTR_SIZE(size);
-		}
-		free += EXT3_XATTR_LEN(name_len);
 	}
-	error = -ENOSPC;
-	if (free < EXT3_XATTR_LEN(name_len) + EXT3_XATTR_SIZE(value_len))
-		goto cleanup;
-
-	/* Here we know that we can set the new attribute. */
 
 	if (header) {
-		struct mb_cache_entry *ce;
-
-		/* assert(header == HDR(bh)); */
-		ce = mb_cache_entry_get(ext3_xattr_cache, bh->b_bdev,
-					bh->b_blocknr);
+		/* assert(header == BHDR(old_bh)); */
+		ce = mb_cache_entry_get(ext3_xattr_cache, old_bh->b_bdev,
+					old_bh->b_blocknr);
 		if (header->h_refcount == cpu_to_le32(1)) {
-			if (ce)
+			if (ce) {
 				mb_cache_entry_free(ce);
-			ea_bdebug(bh, "modifying in-place");
-			error = ext3_journal_get_write_access(handle, bh);
+				ce = NULL;
+			}
+			ea_bdebug(old_bh, "modifying in-place");
+			error = ext3_journal_get_write_access(handle, old_bh);
 			if (error)
 				goto cleanup;
-			lock_buffer(bh);
-			/* keep the buffer locked while modifying it. */
+			lock_buffer(old_bh);
+			error = ext3_xattr_set_entry(&i, &s);
+			if (!error) {
+				if (!IS_LAST_ENTRY(s.first))
+					ext3_xattr_rehash(header, s.here);
+				ext3_xattr_cache_insert(old_bh);
+			}
+			unlock_buffer(old_bh);
+			if (error == -EIO)
+				goto bad_block;
+			if (!error && old_bh && header == BHDR(old_bh)) {
+				error = ext3_journal_dirty_metadata(handle,
+								    old_bh);
+			}
+			if (error)
+				goto cleanup;
+			goto inserted;
 		} else {
-			int offset;
+			int offset = (char *)s.here - old_bh->b_data;
 
-			if (ce)
+			if (ce) {
 				mb_cache_entry_release(ce);
-			ea_bdebug(bh, "cloning");
-			header = kmalloc(bh->b_size, GFP_KERNEL);
+				ce = NULL;
+			}
+			ea_bdebug(old_bh, "cloning");
+			s.base = kmalloc(old_bh->b_size, GFP_KERNEL);
+			/*assert(header == s.base)*/
 			error = -ENOMEM;
 			if (header == NULL)
 				goto cleanup;
-			memcpy(header, HDR(bh), bh->b_size);
+			memcpy(header, BHDR(old_bh), old_bh->b_size);
+			s.first = ENTRY(header+1);
 			header->h_refcount = cpu_to_le32(1);
-			offset = (char *)here - bh->b_data;
-			here = ENTRY((char *)header + offset);
-			offset = (char *)last - bh->b_data;
-			last = ENTRY((char *)header + offset);
+			s.here = ENTRY(s.base + offset);
+			s.end = header + old_bh->b_size;
 		}
 	} else {
 		/* Allocate a buffer where we construct the new block. */
-		header = kmalloc(sb->s_blocksize, GFP_KERNEL);
+		s.base = kmalloc(sb->s_blocksize, GFP_KERNEL);
+		/*assert(header == s.base)*/
 		error = -ENOMEM;
 		if (header == NULL)
 			goto cleanup;
 		memset(header, 0, sb->s_blocksize);
-		end = (char *)header + sb->s_blocksize;
 		header->h_magic = cpu_to_le32(EXT3_XATTR_MAGIC);
 		header->h_blocks = header->h_refcount = cpu_to_le32(1);
-		last = here = ENTRY(header+1);
+		s.first = ENTRY(header+1);
+		s.here = ENTRY(header+1);
+		s.end = (void *)header + sb->s_blocksize;
 	}
 
-	/* Iff we are modifying the block in-place, bh is locked here. */
-
-	if (not_found) {
-		/* Insert the new name. */
-		size_t size = EXT3_XATTR_LEN(name_len);
-		size_t rest = (char *)last - (char *)here;
-		memmove((char *)here + size, here, rest);
-		memset(here, 0, size);
-		here->e_name_index = name_index;
-		here->e_name_len = name_len;
-		memcpy(here->e_name, name, name_len);
-	} else {
-		if (!here->e_value_block && here->e_value_size) {
-			char *first_val = (char *)header + min_offs;
-			size_t offs = le16_to_cpu(here->e_value_offs);
-			char *val = (char *)header + offs;
-			size_t size = EXT3_XATTR_SIZE(
-				le32_to_cpu(here->e_value_size));
-
-			if (size == EXT3_XATTR_SIZE(value_len)) {
-				/* The old and the new value have the same
-				   size. Just replace. */
-				here->e_value_size = cpu_to_le32(value_len);
-				memset(val + size - EXT3_XATTR_PAD, 0,
-				       EXT3_XATTR_PAD); /* Clear pad bytes. */
-				memcpy(val, value, value_len);
-				goto skip_replace;
-			}
-
-			/* Remove the old value. */
-			memmove(first_val + size, first_val, val - first_val);
-			memset(first_val, 0, size);
-			here->e_value_offs = 0;
-			min_offs += size;
-
-			/* Adjust all value offsets. */
-			last = ENTRY(header+1);
-			while (!IS_LAST_ENTRY(last)) {
-				size_t o = le16_to_cpu(last->e_value_offs);
-				if (!last->e_value_block && o < offs)
-					last->e_value_offs =
-						cpu_to_le16(o + size);
-				last = EXT3_XATTR_NEXT(last);
-			}
-		}
-		if (value == NULL) {
-			/* Remove the old name. */
-			size_t size = EXT3_XATTR_LEN(name_len);
-			last = ENTRY((char *)last - size);
-			memmove(here, (char*)here + size,
-				(char*)last - (char*)here);
-			memset(last, 0, size);
-		}
-	}
-
-	if (value != NULL) {
-		/* Insert the new value. */
-		here->e_value_size = cpu_to_le32(value_len);
-		if (value_len) {
-			size_t size = EXT3_XATTR_SIZE(value_len);
-			char *val = (char *)header + min_offs - size;
-			here->e_value_offs =
-				cpu_to_le16((char *)val - (char *)header);
-			memset(val + size - EXT3_XATTR_PAD, 0,
-			       EXT3_XATTR_PAD); /* Clear the pad bytes. */
-			memcpy(val, value, value_len);
-		}
-	}
-
-skip_replace:
-	if (!IS_LAST_ENTRY(ENTRY(header+1)))
-		ext3_xattr_rehash(header, here);
-	if (bh && header == HDR(bh)) {
-		/* we were modifying in-place. */
-		unlock_buffer(bh);
-		error = ext3_journal_dirty_metadata(handle, bh);
-		if (error)
-			goto cleanup;
-	}
-	error = ext3_xattr_set_handle2(handle, inode, bh,
-				       IS_LAST_ENTRY(ENTRY(header+1)) ?
-				       NULL : header);
-
-cleanup:
-	brelse(bh);
-	if (!(bh && header == HDR(bh)))
-		kfree(header);
-	up_write(&EXT3_I(inode)->xattr_sem);
-
-	return error;
-}
-
-/*
- * Second half of ext3_xattr_set_handle(): Update the file system.
- */
-static int
-ext3_xattr_set_handle2(handle_t *handle, struct inode *inode,
-		       struct buffer_head *old_bh,
-		       struct ext3_xattr_header *header)
-{
-	struct super_block *sb = inode->i_sb;
-	struct buffer_head *new_bh = NULL;
-	struct mb_cache_entry *ce = NULL;
-	int error;
+	error = ext3_xattr_set_entry(&i, &s);
+	if (error == -EIO)
+		goto bad_block;
+	if (error)
+		goto cleanup;
+	if (!IS_LAST_ENTRY(s.first))
+		ext3_xattr_rehash(header, s.here);
 
-	if (header) {
+inserted:
+	if (!IS_LAST_ENTRY(s.first)) {
 		new_bh = ext3_xattr_cache_find(inode, header, &ce);
 		if (new_bh) {
 			/* We found an identical block in the cache. */
 			if (new_bh == old_bh)
-				ea_bdebug(new_bh, "keeping this block");
+				ea_bdebug(new_bh, "keeping");
 			else {
 				/* The old block is released after updating
 				   the inode. */
-				ea_bdebug(new_bh, "reusing block");
-
 				error = -EDQUOT;
 				if (DQUOT_ALLOC_BLOCK(inode, 1))
 					goto cleanup;
@@ -701,25 +694,23 @@ ext3_xattr_set_handle2(handle_t *handle,
 				if (error)
 					goto cleanup;
 				lock_buffer(new_bh);
-				HDR(new_bh)->h_refcount = cpu_to_le32(1 +
-					le32_to_cpu(HDR(new_bh)->h_refcount));
-				ea_bdebug(new_bh, "refcount now=%d",
-					le32_to_cpu(HDR(new_bh)->h_refcount));
+				BHDR(new_bh)->h_refcount = cpu_to_le32(1 +
+					le32_to_cpu(BHDR(new_bh)->h_refcount));
+				ea_bdebug(new_bh, "reusing; refcount now=%d",
+					le32_to_cpu(BHDR(new_bh)->h_refcount));
 				unlock_buffer(new_bh);
-				error = ext3_journal_dirty_metadata(handle, new_bh);
+				error = ext3_journal_dirty_metadata(handle,
+								    new_bh);
 				if (error)
 					goto cleanup;
 			}
 			mb_cache_entry_release(ce);
 			ce = NULL;
-		} else if (old_bh && header == HDR(old_bh)) {
+		} else if (old_bh && header == BHDR(old_bh)) {
 			/* We were modifying this block in-place. */
-
-			/* Keep this block. No need to lock the block as we
-			 * don't need to change the reference count. */
+			ea_bdebug(old_bh, "keeping this block");
 			new_bh = old_bh;
 			get_bh(new_bh);
-			ext3_xattr_cache_insert(new_bh);
 		} else {
 			/* We need to allocate a new block */
 			int goal = le32_to_cpu(
@@ -748,11 +739,10 @@ getblk_failed:
 			set_buffer_uptodate(new_bh);
 			unlock_buffer(new_bh);
 			ext3_xattr_cache_insert(new_bh);
-
-			ext3_xattr_update_super_block(handle, sb);
 			error = ext3_journal_dirty_metadata(handle, new_bh);
 			if (error)
 				goto cleanup;
+			ext3_xattr_update_super_block(handle, sb);
 		}
 	}
 
@@ -763,21 +753,23 @@ getblk_failed:
 	if (IS_SYNC(inode))
 		handle->h_sync = 1;
 
-	error = 0;
-	if (old_bh && old_bh != new_bh) {
-		/*
-		 * If there was an old block, and we are no longer using it,
-		 * release the old block.
-		 */
+	/* Drop the previous xattr block. */
+	if (old_bh && old_bh != new_bh)
 		ext3_xattr_release_block(handle, inode, old_bh);
-	}
+	error = 0;
 
 cleanup:
 	if (ce)
 		mb_cache_entry_release(ce);
 	brelse(new_bh);
+	brelse(old_bh);
+	if (!(old_bh && header == BHDR(old_bh)))
+		kfree(header);
+	up_write(&EXT3_I(inode)->xattr_sem);
 
 	return error;
+
+#undef header
 }
 
 /*
@@ -832,14 +824,14 @@ ext3_xattr_delete_inode(handle_t *handle
 		goto cleanup;
 	bh = sb_bread(inode->i_sb, EXT3_I(inode)->i_file_acl);
 	if (!bh) {
-		ext3_error(inode->i_sb, "ext3_xattr_delete_inode",
+		ext3_error(inode->i_sb, __FUNCTION__,
 			"inode %ld: block %d read error", inode->i_ino,
 			EXT3_I(inode)->i_file_acl);
 		goto cleanup;
 	}
-	if (HDR(bh)->h_magic != cpu_to_le32(EXT3_XATTR_MAGIC) ||
-	    HDR(bh)->h_blocks != cpu_to_le32(1)) {
-		ext3_error(inode->i_sb, "ext3_xattr_delete_inode",
+	if (BHDR(bh)->h_magic != cpu_to_le32(EXT3_XATTR_MAGIC) ||
+	    BHDR(bh)->h_blocks != cpu_to_le32(1)) {
+		ext3_error(inode->i_sb, __FUNCTION__,
 			"inode %ld: bad block %d", inode->i_ino,
 			EXT3_I(inode)->i_file_acl);
 		goto cleanup;
@@ -871,30 +863,29 @@ ext3_xattr_put_super(struct super_block 
  *
  * Returns 0, or a negative error number on failure.
  */
-static int
+static void
 ext3_xattr_cache_insert(struct buffer_head *bh)
 {
-	__u32 hash = le32_to_cpu(HDR(bh)->h_hash);
+	__u32 hash = le32_to_cpu(BHDR(bh)->h_hash);
 	struct mb_cache_entry *ce;
 	int error;
 
 	ce = mb_cache_entry_alloc(ext3_xattr_cache);
-	if (!ce)
-		return -ENOMEM;
+	if (!ce) {
+		ea_bdebug(bh, "out of memory");
+		return;
+	}
 	error = mb_cache_entry_insert(ce, bh->b_bdev, bh->b_blocknr, &hash);
 	if (error) {
 		mb_cache_entry_free(ce);
 		if (error == -EBUSY) {
-			ea_bdebug(bh, "already in cache (%d cache entries)",
-				atomic_read(&ext3_xattr_cache->c_entry_count));
+			ea_bdebug(bh, "already in cache");
 			error = 0;
 		}
 	} else {
-		ea_bdebug(bh, "inserting [%x] (%d cache entries)", (int)hash,
-			  atomic_read(&ext3_xattr_cache->c_entry_count));
+		ea_bdebug(bh, "inserting [%x]", (int)hash);
 		mb_cache_entry_release(ce);
 	}
-	return error;
 }
 
 /*
@@ -967,16 +958,16 @@ again:
 		}
 		bh = sb_bread(inode->i_sb, ce->e_block);
 		if (!bh) {
-			ext3_error(inode->i_sb, "ext3_xattr_cache_find",
+			ext3_error(inode->i_sb, __FUNCTION__,
 				"inode %ld: block %ld read error",
 				inode->i_ino, (unsigned long) ce->e_block);
-		} else if (le32_to_cpu(HDR(bh)->h_refcount) >
+		} else if (le32_to_cpu(BHDR(bh)->h_refcount) >=
 				EXT3_XATTR_REFCOUNT_MAX) {
-			ea_idebug(inode, "block %ld refcount %d>%d",
+			ea_idebug(inode, "block %ld refcount %d>=%d",
 				  (unsigned long) ce->e_block,
-				  le32_to_cpu(HDR(bh)->h_refcount),
+				  le32_to_cpu(BHDR(bh)->h_refcount),
 					  EXT3_XATTR_REFCOUNT_MAX);
-		} else if (ext3_xattr_cmp(header, HDR(bh)) == 0) {
+		} else if (ext3_xattr_cmp(header, BHDR(bh)) == 0) {
 			*pce = ce;
 			return bh;
 		}
--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH

