Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbTERMvm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 08:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbTERMvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 08:51:42 -0400
Received: from tmi.comex.ru ([217.10.33.92]:14033 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S262033AbTERMvV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 08:51:21 -0400
Subject: [RFC] fast EA for ext3
From: Alex Tomas <bzzz@tmi.comex.ru>
To: linux-kernel@vger.kernel.org
Cc: ext2-devel@lists.sourceforge.net, Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: Sun, 18 May 2003 17:04:39 +0000
Message-ID: <87n0hkmbiw.fsf@gw.home.net>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi!

this patch implements possibility to store EA into inode body
which may be larger 128 bytes in 2.5 kernel. I decided to touch
current code as small as possible. format of inode with EA is
following:

<old inode>     /* 128 bytes */
i_extra_isize   /* 2 bytes: how many bytes used _before_ EAs */
i_pad1          /* 2 bytes */
i_uatime        /* 4 bytes: access time (useconds) */
i_uctime	/* 4 bytes: change time (useconds) */
i_umtime	/* 4 bytes: modification time (useconds) */
i_crtim         /* 4 bytes: creation time (seconds) */
i_ucrtime	/* 4 bytes: creation time (useconds) */
<EA magic>      /* 4 bytes: indication that inode has EA in body */
<list of EAs>   /* structure is the same current EA uses */

tested with setfattr/getfattr tools.
there is patch against e2fsprogs-1.33 which adds ability to show
EA stored in inode body.


with best regards, Alex



diff -puNr linux-2.5.69/fs/ext3/ialloc.c edited/fs/ext3/ialloc.c
--- linux-2.5.69/fs/ext3/ialloc.c	2003-03-18 14:13:37.000000000 +0300
+++ edited/fs/ext3/ialloc.c	2003-05-11 23:20:51.000000000 +0400
@@ -576,6 +576,17 @@ repeat:
 
 	ei->i_state = EXT3_STATE_NEW;
 
+	ei->i_crtime = CURRENT_TIME;	
+	if (EXT3_INODE_SIZE(inode->i_sb) > EXT3_GOOD_OLD_INODE_SIZE) {
+		ei->i_extra_isize = 	sizeof(__u16)	/* i_extra_isize */
+					+ sizeof(__u16)	/* i_pad1 */
+					+ sizeof(__u32)	/* i_uatime */
+					+ sizeof(__u32)	/* i_uctime */
+					+ sizeof(__u32)	/* i_umtime */
+					+ sizeof(__u32);/* i_udtime */
+	} else
+		ei->i_extra_isize = 0;
+
 	unlock_super(sb);
 	ret = inode;
 	if(DQUOT_ALLOC_INODE(inode)) {
diff -puNr linux-2.5.69/fs/ext3/xattr.c edited/fs/ext3/xattr.c
--- linux-2.5.69/fs/ext3/xattr.c	2003-05-06 21:21:17.000000000 +0400
+++ edited/fs/ext3/xattr.c	2003-05-10 21:51:08.000000000 +0400
@@ -72,15 +72,15 @@
 
 #ifdef EXT3_XATTR_DEBUG
 # define ea_idebug(inode, f...) do { \
-		printk(KERN_DEBUG "inode %s:%ld: ", \
-			inode->i_sb->s_id, inode->i_ino); \
+		printk(KERN_DEBUG "inode %s:%lu: ", \
+			inode->i_sb->s_id, (unsigned long) inode->i_ino); \
 		printk(f); \
 		printk("\n"); \
 	} while (0)
 # define ea_bdebug(bh, f...) do { \
 		char b[BDEVNAME_SIZE]; \
-		printk(KERN_DEBUG "block %s:%ld: ", \
-			bdevname(bh->b_bdev, b), bh->b_blocknr); \
+		printk(KERN_DEBUG "block %s:%lu: ", \
+			bdevname(bh->b_bdev, b), (unsigned long) bh->b_blocknr); \
 		printk(f); \
 		printk("\n"); \
 	} while (0)
@@ -256,17 +256,12 @@ ext3_removexattr(struct dentry *dentry, 
 }
 
 /*
- * ext3_xattr_get()
- *
- * Copy an extended attribute into the buffer
- * provided, or compute the buffer size required.
- * Buffer is NULL to compute the size of the buffer required.
+ * ext3_xattr_block_get()
  *
- * Returns a negative error number on failure, or the number of bytes
- * used / required on success.
+ * routine looks for attribute in EA block and returns it's value and size
  */
 int
-ext3_xattr_get(struct inode *inode, int name_index, const char *name,
+ext3_xattr_block_get(struct inode *inode, int name_index, const char *name,
 	       void *buffer, size_t buffer_size)
 {
 	struct buffer_head *bh = NULL;
@@ -355,9 +350,80 @@ cleanup:
 }
 
 /*
- * ext3_xattr_list()
+ * ext3_xattr_ibode_get()
  *
- * Copy a list of attribute names into the buffer
+ * routine looks for attribute in inode body and returns it's value and size
+ */
+int
+ext3_xattr_ibody_get(struct inode *inode, int name_index, const char *name,
+	       void *buffer, size_t buffer_size)
+{
+	struct ext3_iloc iloc;
+	char *start, *end;
+	struct ext3_xattr_entry *last;
+	int size, name_len = strlen(name), storage_size;
+	int ret = -ENOENT;
+	
+	if (EXT3_SB(inode->i_sb)->s_inode_size <= EXT3_GOOD_OLD_INODE_SIZE)
+		return -ENOENT;
+
+	ret = ext3_get_inode_loc(inode, &iloc);
+	if (ret)
+		return ret;
+
+	storage_size = EXT3_SB(inode->i_sb)->s_inode_size -
+				EXT3_GOOD_OLD_INODE_SIZE -
+				EXT3_I(inode)->i_extra_isize -
+				sizeof(__u32);
+	start = (char *) iloc.raw_inode + EXT3_GOOD_OLD_INODE_SIZE +
+			EXT3_I(inode)->i_extra_isize;
+	if (le32_to_cpu((*(__u32*) start)) != EXT3_XATTR_MAGIC) {
+		brelse(iloc.bh);
+		return -ENOENT;
+	}
+	start += sizeof(__u32);
+	end = (char *) iloc.raw_inode + EXT3_SB(inode->i_sb)->s_inode_size;
+
+	last = (struct ext3_xattr_entry *) start;
+	while (!IS_LAST_ENTRY(last)) {
+		struct ext3_xattr_entry *next = EXT3_XATTR_NEXT(last);
+		if (le32_to_cpu(last->e_value_size) > storage_size ||
+				(char *) next >= end) {
+			ext3_error(inode->i_sb, "ext3_xattr_ibody_get",
+				"inode %ld", inode->i_ino);
+			brelse(iloc.bh);
+			return -EIO;
+		}
+		if (name_index == last->e_name_index &&
+		    name_len == last->e_name_len &&
+		    !memcmp(name, last->e_name, name_len))
+			goto found;
+		last = next;
+	}
+
+	/* can't find EA */
+	brelse(iloc.bh);
+	return -ENOENT;
+	
+found:
+	size = le32_to_cpu(last->e_value_size);
+	if (buffer) {
+		ret = -ERANGE;
+		if (buffer_size >= size) {
+			memcpy(buffer, start + le16_to_cpu(last->e_value_offs),
+				size);
+			ret = size;
+		}
+	} else
+		ret = size;
+	brelse(iloc.bh);
+	return ret;
+}
+
+/*
+ * ext3_xattr_get()
+ *
+ * Copy an extended attribute into the buffer
  * provided, or compute the buffer size required.
  * Buffer is NULL to compute the size of the buffer required.
  *
@@ -365,7 +431,30 @@ cleanup:
  * used / required on success.
  */
 int
-ext3_xattr_list(struct inode *inode, char *buffer, size_t buffer_size)
+ext3_xattr_get(struct inode *inode, int name_index, const char *name,
+	       void *buffer, size_t buffer_size)
+{
+	int err;
+
+	/* try to find attribute in inode body */
+	err = ext3_xattr_ibody_get(inode, name_index, name,
+					buffer, buffer_size);
+	if (err >= 0) {
+		/* found EA, return them */
+		return err;
+	}
+	
+	/* search was unsuccessful, try to find EA in dedicated block */
+	return ext3_xattr_block_get(inode, name_index, name,
+					buffer, buffer_size);
+}
+
+/* ext3_xattr_ibody_list()
+ *
+ * generate list of attributes stored in EA block
+ */
+int
+ext3_xattr_block_list(struct inode *inode, char *buffer, size_t buffer_size)
 {
 	struct buffer_head *bh = NULL;
 	struct ext3_xattr_entry *entry;
@@ -383,7 +472,7 @@ ext3_xattr_list(struct inode *inode, cha
 	if (!bh)
 		return -EIO;
 	ea_bdebug(bh, "b_count=%d, refcount=%d",
-		atomic_read(&(bh->b_count)), le32_to_cpu(HDR(bh)->h_refcount));
+		(int) atomic_read(&(bh->b_count)), (int) le32_to_cpu(HDR(bh)->h_refcount));
 	end = bh->b_data + bh->b_size;
 	if (HDR(bh)->h_magic != cpu_to_le32(EXT3_XATTR_MAGIC) ||
 	    HDR(bh)->h_blocks != cpu_to_le32(1)) {
@@ -438,6 +527,126 @@ cleanup:
 	return error;
 }
 
+/* ext3_xattr_ibody_list()
+ *
+ * generate list of attributes stored in inode body
+ */
+int
+ext3_xattr_ibody_list(struct inode *inode, char *buffer, size_t buffer_size)
+{
+	struct ext3_iloc iloc;
+	char *start, *end, *buf;
+	struct ext3_xattr_entry *last;
+	int storage_size;
+	int ret;
+	int size = 0;
+	
+	if (EXT3_SB(inode->i_sb)->s_inode_size <= EXT3_GOOD_OLD_INODE_SIZE)
+		return 0;
+
+	ret = ext3_get_inode_loc(inode, &iloc);
+	if (ret) 
+		return ret;
+
+	storage_size = EXT3_SB(inode->i_sb)->s_inode_size -
+				EXT3_GOOD_OLD_INODE_SIZE -
+				EXT3_I(inode)->i_extra_isize -
+				sizeof(__u32);
+	start = (char *) iloc.raw_inode + EXT3_GOOD_OLD_INODE_SIZE +
+			EXT3_I(inode)->i_extra_isize;
+	if (le32_to_cpu((*(__u32*) start)) != EXT3_XATTR_MAGIC) {
+		brelse(iloc.bh);
+		return 0;
+	}
+	start += sizeof(__u32);
+	end = (char *) iloc.raw_inode + EXT3_SB(inode->i_sb)->s_inode_size;
+
+	last = (struct ext3_xattr_entry *) start;
+	while (!IS_LAST_ENTRY(last)) {
+		struct ext3_xattr_entry *next = EXT3_XATTR_NEXT(last);
+		struct ext3_xattr_handler *handler;
+		if (le32_to_cpu(last->e_value_size) > storage_size ||
+				(char *) next >= end) {
+			ext3_error(inode->i_sb, "ext3_xattr_ibody_list",
+				"inode %ld", inode->i_ino);
+			brelse(iloc.bh);
+			return -EIO;
+		}
+		handler = ext3_xattr_handler(last->e_name_index);
+		if (handler)
+			size += handler->list(NULL, inode, last->e_name,
+					      last->e_name_len);
+		last = next;
+	}
+
+	if (!buffer) {
+		ret = size;
+		goto cleanup;
+	} else {
+		ret = -ERANGE;
+		if (size > buffer_size)
+			goto cleanup;
+	}
+
+	last = (struct ext3_xattr_entry *) start;
+	buf = buffer;
+	while (!IS_LAST_ENTRY(last)) {
+		struct ext3_xattr_entry *next = EXT3_XATTR_NEXT(last);
+		struct ext3_xattr_handler *handler;
+		handler = ext3_xattr_handler(last->e_name_index);
+		if (handler)
+			buf += handler->list(buf, inode, last->e_name,
+					      last->e_name_len);
+		last = next;
+	}
+	ret = size;
+cleanup:
+	brelse(iloc.bh);
+	return ret;
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
+	int error;
+	int size = buffer_size;
+
+	/* get list of attributes stored in inode body */
+	error = ext3_xattr_ibody_list(inode, buffer, buffer_size);
+	if (error < 0) {
+		/* some error occured while collecting 
+		 * attributes in inode body */
+		return error;
+	}
+	size = error;
+	
+	/* get list of attributes stored in dedicated block */
+	if (buffer) {
+		buffer_size -= error;
+		if (buffer_size <= 0) {
+			buffer = NULL;
+			buffer_size = 0;
+		} else 
+			buffer += error;
+	}
+		
+	error = ext3_xattr_block_list(inode, buffer, buffer_size);
+	if (error < 0)
+		return error;
+
+	return error + size;
+}
+
 /*
  * If the EXT3_FEATURE_COMPAT_EXT_ATTR feature of this file system is
  * not set, set it.
@@ -458,6 +667,276 @@ static void ext3_xattr_update_super_bloc
 }
 
 /*
+ * ext3_xattr_ibody_find()
+ *
+ * search attribute and calculate free space in inode body
+ * NOTE: free space includes space our attribute hold
+ */
+int
+ext3_xattr_ibody_find(struct inode *inode, int name_index, 
+		const char *name, struct ext3_xattr_entry *rentry, int *free)
+{
+	int err, storage_size;
+	struct ext3_iloc iloc;
+	char *start, *end;
+	struct ext3_xattr_entry *last;
+	int name_len = strlen(name);
+	int ret = -ENOENT;
+	
+	if (EXT3_SB(inode->i_sb)->s_inode_size <= EXT3_GOOD_OLD_INODE_SIZE)
+		return ret;
+
+	err = ext3_get_inode_loc(inode, &iloc);
+	if (err) 
+		return -EIO;
+
+	storage_size = EXT3_SB(inode->i_sb)->s_inode_size -
+				EXT3_GOOD_OLD_INODE_SIZE -
+				EXT3_I(inode)->i_extra_isize -
+				sizeof(__u32);
+	*free = storage_size - sizeof(__u32);
+	start = (char *) iloc.raw_inode + EXT3_GOOD_OLD_INODE_SIZE +
+			EXT3_I(inode)->i_extra_isize;
+	if (le32_to_cpu((*(__u32*) start)) != EXT3_XATTR_MAGIC) {
+		brelse(iloc.bh);
+		return -ENOENT;
+	}
+	start += sizeof(__u32);
+	end = (char *) iloc.raw_inode + EXT3_SB(inode->i_sb)->s_inode_size;
+
+	last = (struct ext3_xattr_entry *) start;
+	while (!IS_LAST_ENTRY(last)) {
+		struct ext3_xattr_entry *next = EXT3_XATTR_NEXT(last);
+		if (le32_to_cpu(last->e_value_size) > storage_size ||
+				(char *) next >= end) {
+			ext3_error(inode->i_sb, "ext3_xattr_ibody_find",
+				"inode %ld", inode->i_ino);
+			brelse(iloc.bh);
+			return -EIO;
+		}
+
+		if (name_index == last->e_name_index &&
+		    name_len == last->e_name_len &&
+		    !memcmp(name, last->e_name, name_len)) {
+			memcpy(rentry, last, sizeof(struct ext3_xattr_entry));
+			ret = 0;
+		} else {
+			*free -= EXT3_XATTR_LEN(last->e_name_len);
+			*free -= le32_to_cpu(last->e_value_size);
+		}
+		last = next;
+	}
+	
+	brelse(iloc.bh);
+	return ret;
+}
+
+/*
+ * ext3_xattr_block_find()
+ *
+ * search attribute and calculate free space in EA block (if it allocated)
+ * NOTE: free space includes space our attribute hold
+ */
+int
+ext3_xattr_block_find(struct inode *inode, int name_index, const char *name,
+	       struct ext3_xattr_entry *rentry, int *free)
+{
+	struct buffer_head *bh = NULL;
+	struct ext3_xattr_entry *entry;
+	char *end;
+	int name_len, error = -ENOENT;
+
+	if (!EXT3_I(inode)->i_file_acl) {
+		*free = inode->i_sb->s_blocksize -
+			sizeof(struct ext3_xattr_header) -
+			sizeof(__u32);
+		return -ENOENT;
+	}
+	ea_idebug(inode, "reading block %d", EXT3_I(inode)->i_file_acl);
+	bh = sb_bread(inode->i_sb, EXT3_I(inode)->i_file_acl);
+	if (!bh)
+		return -EIO;
+	ea_bdebug(bh, "b_count=%d, refcount=%d",
+		atomic_read(&(bh->b_count)), le32_to_cpu(HDR(bh)->h_refcount));
+	end = bh->b_data + bh->b_size;
+	if (HDR(bh)->h_magic != cpu_to_le32(EXT3_XATTR_MAGIC) ||
+	    HDR(bh)->h_blocks != cpu_to_le32(1)) {
+bad_block:	ext3_error(inode->i_sb, "ext3_xattr_get",
+			"inode %ld: bad block %d", inode->i_ino,
+			EXT3_I(inode)->i_file_acl);
+		brelse(bh);
+		return -EIO;
+	}
+	/* find named attribute */
+	name_len = strlen(name);
+	*free = bh->b_size - sizeof(__u32);
+
+	entry = FIRST_ENTRY(bh);
+	while (!IS_LAST_ENTRY(entry)) {
+		struct ext3_xattr_entry *next =
+			EXT3_XATTR_NEXT(entry);
+		if ((char *)next >= end)
+			goto bad_block;
+		if (name_index == entry->e_name_index &&
+		    name_len == entry->e_name_len &&
+		    memcmp(name, entry->e_name, name_len) == 0) {
+			memcpy(rentry, entry, sizeof(struct ext3_xattr_entry));
+			error = 0;
+		} else {
+			*free -= EXT3_XATTR_LEN(entry->e_name_len);
+			*free -= le32_to_cpu(entry->e_value_size);
+		}
+		entry = next;
+	}
+	brelse(bh);
+
+	return error;
+}
+
+/*
+ * ext3_xattr_inode_set()
+ * 
+ * this routine add/remove/replace attribute in inode body
+ */
+int
+ext3_xattr_ibody_set(handle_t *handle, struct inode *inode, int name_index,
+		      const char *name, const void *value, size_t value_len,
+		      int flags)
+{
+	/* first, find empty entry */
+	int err, storage_size;
+	struct ext3_iloc iloc;
+	int free, min_offs;
+	struct ext3_xattr_entry *last, *next, *here = NULL;
+	int name_len = strlen(name);
+	int esize = EXT3_XATTR_LEN(name_len);
+	char *start, *end;
+	struct buffer_head *bh;
+	
+	if (EXT3_SB(inode->i_sb)->s_inode_size <= EXT3_GOOD_OLD_INODE_SIZE)
+		return -ENOSPC;
+
+	err = ext3_get_inode_loc(inode, &iloc);
+	if (err)
+		return err;
+	bh = iloc.bh;
+
+	storage_size = EXT3_SB(inode->i_sb)->s_inode_size -
+				EXT3_GOOD_OLD_INODE_SIZE -
+				EXT3_I(inode)->i_extra_isize -
+				sizeof(__u32);
+	start = (char *) iloc.raw_inode + EXT3_GOOD_OLD_INODE_SIZE +
+			EXT3_I(inode)->i_extra_isize;
+	if ((*(__u32*) start) != EXT3_XATTR_MAGIC) {
+		/* inode had no attributes before */
+		*((__u32*) start) = cpu_to_le32(EXT3_XATTR_MAGIC);
+	}
+	start += sizeof(__u32);
+	end = (char *) iloc.raw_inode +	EXT3_SB(inode->i_sb)->s_inode_size;
+	min_offs = storage_size;
+	free = storage_size - sizeof(__u32);
+
+	last = (struct ext3_xattr_entry *) start;	
+	while (!IS_LAST_ENTRY(last)) {
+		next = EXT3_XATTR_NEXT(last);
+		if (le32_to_cpu(last->e_value_size) > storage_size ||
+				(char *) next >= end) {
+			ext3_error(inode->i_sb, "ext3_xattr_ibody_set",
+				"inode %ld", inode->i_ino);
+			brelse(bh);
+			return -EIO;
+		}
+		
+		if (last->e_value_size) {
+			int offs = le16_to_cpu(last->e_value_offs);
+			if (offs < min_offs)
+				min_offs = offs;
+		}
+		if (name_index == last->e_name_index &&
+			name_len == last->e_name_len &&
+			!memcmp(name, last->e_name, name_len)) 
+			here = last;
+		else {
+			/* we calculate all but our attribute
+			 * because it will be removed before changing */
+			free -= EXT3_XATTR_LEN(last->e_name_len);
+			free -= le32_to_cpu(last->e_value_size);
+		}
+		last = next;
+	}
+
+	if (value && (esize + value_len > free)) {
+		brelse(bh);
+		return -ENOSPC;
+	}
+	
+	err = ext3_reserve_inode_write(handle, inode, &iloc);
+	if (err) {
+		brelse(bh);	
+		return err;
+	}
+
+	if (here) {
+		/* time to remove old value */
+		struct ext3_xattr_entry *e;
+		int size = le32_to_cpu(here->e_value_size);
+		int border = le16_to_cpu(here->e_value_offs);
+		char *src;
+
+		/* move tail */
+		memmove(start + min_offs + size, start + min_offs,
+				border - min_offs);
+
+		/* recalculate offsets */
+		e = (struct ext3_xattr_entry *) start;
+		while (!IS_LAST_ENTRY(e)) {
+			struct ext3_xattr_entry *next = EXT3_XATTR_NEXT(e);
+			int offs = le16_to_cpu(e->e_value_offs); 
+			if (offs < border) 
+				e->e_value_offs = 
+					cpu_to_le16(offs + size);
+			e = next;
+		}
+		min_offs += size;
+
+		/* remove entry */
+		border = EXT3_XATTR_LEN(here->e_name_len);
+		src = (char *) here + EXT3_XATTR_LEN(here->e_name_len);
+		size = (char *) last - src;
+		if ((char *) here + size > end)
+			printk("ALERT at %s:%d: 0x%p + %d > 0x%p\n",
+					__FILE__, __LINE__, here, size, end);
+		memmove(here, src, size);
+		last = (struct ext3_xattr_entry *) ((char *) last - border);
+		*((__u32 *) last) = 0;
+	}
+	
+	if (value) {
+		int offs = min_offs - value_len;
+		/* use last to create new entry */
+		last->e_name_len = strlen(name);
+		last->e_name_index = name_index;
+		last->e_value_offs = cpu_to_le16(offs);
+		last->e_value_size = cpu_to_le32(value_len);
+		last->e_hash = last->e_value_block = 0;
+		memset(last->e_name, 0, esize);
+		memcpy(last->e_name, name, last->e_name_len);
+		if (start + offs + value_len > end)
+			printk("ALERT at %s:%d: 0x%p + %d + %d > 0x%p\n",
+					__FILE__, __LINE__, start, offs,
+					value_len, end);
+		memcpy(start + offs, value, value_len);
+		last = EXT3_XATTR_NEXT(last);
+		*((__u32 *) last) = 0;
+	}
+	
+	ext3_mark_iloc_dirty(handle, inode, &iloc);
+	brelse(bh);
+
+	return 0;
+}
+
+/*
  * ext3_xattr_set_handle()
  *
  * Create, replace or remove an extended attribute for this inode. Buffer
@@ -471,6 +950,103 @@ static void ext3_xattr_update_super_bloc
  */
 int
 ext3_xattr_set_handle(handle_t *handle, struct inode *inode, int name_index,
+		const char *name, const void *value, size_t value_len,
+		int flags)
+{
+	struct ext3_xattr_entry entry;
+	int err, where = 0, found = 0, total;
+	int free1 = -1, free2 = -1;
+	int name_len;
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
+	name_len = strlen(name);
+	if (name_len > 255 || value_len > inode->i_sb->s_blocksize)
+		return -ERANGE;
+	down(&ext3_xattr_sem);
+
+	/* try to find attribute in inode body */
+	err = ext3_xattr_ibody_find(inode, name_index, name, &entry, &free1);
+	if (err == 0) {
+		/* found EA in inode */
+		found = 1;
+		where = 0;
+	} else if (err == -ENOENT) {
+		/* there is no such attribute in inode body */
+		/* try to find attribute in dedicated block */
+		err = ext3_xattr_block_find(inode, name_index, name,
+						&entry, &free2);
+		if (err != 0 && err != -ENOENT) {
+			/* not found EA in block */
+			goto finish;	
+		}
+		/* found EA in block */
+		where = 1;
+		found = 1;
+	} else
+		goto finish;
+
+	/* check flags: may replace? may create ? */
+	if (found && (flags & XATTR_CREATE)) {
+		err = -EEXIST;
+		goto finish;
+	} else if (!found && (flags & XATTR_REPLACE)) {
+		err = -ENODATA;
+		goto finish;
+	}
+
+	/* check if we have enough space to store attribute */
+	total = EXT3_XATTR_LEN(strlen(name)) + value_len;
+	if (free1 >= 0 && total > free1 && free2 >= 0 && total > free2) {
+		/* have no enough space */
+		err = -ENOSPC;
+		goto finish;
+	}
+	
+	/* time to remove attribute */
+	if (found) {
+		if (where == 0) {
+			/* EA is stored in inode body */
+			ext3_xattr_ibody_set(handle, inode, name_index, name,
+					NULL, 0, flags);
+		} else {
+			/* EA is stored in separated block */
+			ext3_xattr_block_set(handle, inode, name_index, name,
+					NULL, 0, flags);
+		}
+	}
+
+	/* try to store EA in inode body */
+	err = ext3_xattr_ibody_set(handle, inode, name_index, name,
+				value, value_len, flags);
+	if (err) {
+		/* can't store EA in inode body */
+		/* try to store in block */
+		err = ext3_xattr_block_set(handle, inode, name_index,
+					name, value, value_len, flags);	
+	}
+
+finish:	
+	up(&ext3_xattr_sem);
+	return err;
+}
+
+/*
+ * ext3_xattr_block_set()
+ * 
+ * this routine add/remove/replace attribute in EA block
+ */
+int
+ext3_xattr_block_set(handle_t *handle, struct inode *inode, int name_index,
 		      const char *name, const void *value, size_t value_len,
 		      int flags)
 {
@@ -493,23 +1069,8 @@ ext3_xattr_set_handle(handle_t *handle, 
 	 *             towards the end of the block).
 	 * end -- Points right after the block pointed to by header.
 	 */
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
 	name_len = strlen(name);
-	if (name_len > 255 || value_len > sb->s_blocksize)
-		return -ERANGE;
-	down(&ext3_xattr_sem);
-
+	
 	if (EXT3_I(inode)->i_file_acl) {
 		/* The inode already has an extended attribute block. */
 		bh = sb_bread(sb, EXT3_I(inode)->i_file_acl);
@@ -708,7 +1269,6 @@ cleanup:
 	brelse(bh);
 	if (!(bh && header == HDR(bh)))
 		kfree(header);
-	up(&ext3_xattr_sem);
 
 	return error;
 }
@@ -735,7 +1295,7 @@ ext3_xattr_set_handle2(handle_t *handle,
 			 */
 			ea_bdebug(new_bh, "%s block %ld",
 				(old_bh == new_bh) ? "keeping" : "reusing",
-				new_bh->b_blocknr);
+				(long int) new_bh->b_blocknr);
 			
 			error = -EDQUOT;
 			if (DQUOT_ALLOC_BLOCK(inode, 1))
diff -puNr linux-2.5.69/fs/ext3/inode.c edited/fs/ext3/inode.c
--- linux-2.5.69/fs/ext3/inode.c	2003-05-06 21:21:00.000000000 +0400
+++ edited/fs/ext3/inode.c	2003-05-11 23:39:01.000000000 +0400
@@ -2326,6 +2326,21 @@ void ext3_read_inode(struct inode * inod
 		ei->i_data[block] = iloc.raw_inode->i_block[block];
 	INIT_LIST_HEAD(&ei->i_orphan);
 
+	if (EXT3_INODE_SIZE(inode->i_sb) > EXT3_GOOD_OLD_INODE_SIZE) {
+		ei->i_extra_isize = le16_to_cpu(raw_inode->i_extra_isize);
+		if (ei->i_extra_isize >= EXT3_FIELD_END(i_uatime))
+			inode->i_atime.tv_nsec = le32_to_cpu(raw_inode->i_uatime);
+		if (ei->i_extra_isize >= EXT3_FIELD_END(i_uctime))
+			inode->i_ctime.tv_nsec = le32_to_cpu(raw_inode->i_uctime);
+		if (ei->i_extra_isize >= EXT3_FIELD_END(i_umtime))
+			inode->i_mtime.tv_nsec = le32_to_cpu(raw_inode->i_umtime);
+		if (ei->i_extra_isize >= EXT3_FIELD_END(i_crtime))
+			ei->i_crtime.tv_sec = le32_to_cpu(raw_inode->i_crtime);
+		if (ei->i_extra_isize >= EXT3_FIELD_END(i_ucrtime))
+			ei->i_crtime.tv_nsec = le32_to_cpu(raw_inode->i_ucrtime);
+	} else
+		ei->i_extra_isize = 0;
+	
 	brelse (iloc.bh);
 
 	if (S_ISREG(inode->i_mode)) {
@@ -2456,6 +2471,20 @@ static int ext3_do_update_inode(handle_t
 	else for (block = 0; block < EXT3_N_BLOCKS; block++)
 		raw_inode->i_block[block] = ei->i_data[block];
 
+	if (EXT3_INODE_SIZE(inode->i_sb) > EXT3_GOOD_OLD_INODE_SIZE) {
+		raw_inode->i_extra_isize = cpu_to_le16(ei->i_extra_isize);
+		if (ei->i_extra_isize >= EXT3_FIELD_END(i_uatime))
+			raw_inode->i_uatime = cpu_to_le32(inode->i_atime.tv_nsec);
+		if (ei->i_extra_isize >= EXT3_FIELD_END(i_uctime))
+			raw_inode->i_uctime = cpu_to_le32(inode->i_ctime.tv_nsec);
+		if (ei->i_extra_isize >= EXT3_FIELD_END(i_umtime))
+			raw_inode->i_umtime = cpu_to_le32(inode->i_mtime.tv_nsec);
+		if (ei->i_extra_isize >= EXT3_FIELD_END(i_crtime))
+			raw_inode->i_crtime = cpu_to_le32(ei->i_crtime.tv_sec);
+		if (ei->i_extra_isize >= EXT3_FIELD_END(i_ucrtime))
+			raw_inode->i_ucrtime = cpu_to_le32(ei->i_crtime.tv_nsec);
+	}
+
 	BUFFER_TRACE(bh, "call ext3_journal_dirty_metadata");
 	rc = ext3_journal_dirty_metadata(handle, bh);
 	if (!err)
diff -puNr linux-2.5.69/fs/ext3/xattr.h edited/fs/ext3/xattr.h
--- linux-2.5.69/fs/ext3/xattr.h	2003-03-14 01:53:36.000000000 +0300
+++ edited/fs/ext3/xattr.h	2003-05-09 13:13:43.000000000 +0400
@@ -75,7 +75,8 @@ extern int ext3_removexattr(struct dentr
 extern int ext3_xattr_get(struct inode *, int, const char *, void *, size_t);
 extern int ext3_xattr_list(struct inode *, char *, size_t);
 extern int ext3_xattr_set(struct inode *, int, const char *, const void *, size_t, int);
-extern int ext3_xattr_set_handle(handle_t *, struct inode *, int, const char *, const void *, size_t, int);
+extern int ext3_xattr_set_handle(handle_t *, struct inode *, int, const char *,const void *,size_t,int);
+extern int ext3_xattr_block_set(handle_t *, struct inode *, int, const char *,const void *,size_t,int);
 
 extern void ext3_xattr_delete_inode(handle_t *, struct inode *);
 extern void ext3_xattr_put_super(struct super_block *);
diff -puNr linux-2.5.69/include/linux/ext3_fs_i.h edited/include/linux/ext3_fs_i.h
--- linux-2.5.69/include/linux/ext3_fs_i.h	2002-12-25 06:03:21.000000000 +0300
+++ edited/include/linux/ext3_fs_i.h	2003-05-11 23:20:51.000000000 +0400
@@ -98,6 +98,12 @@ struct ext3_inode_info {
 	 */
 	struct rw_semaphore truncate_sem;
 	struct inode vfs_inode;
+
+	/* creation time */
+	struct timespec i_crtime; 
+
+	/* on-disk additional lenght */
+	__u16 i_extra_isize;
 };
 
 #endif	/* _LINUX_EXT3_FS_I */
diff -puNr linux-2.5.69/include/linux/ext3_fs.h edited/include/linux/ext3_fs.h
--- linux-2.5.69/include/linux/ext3_fs.h	2003-03-18 14:13:37.000000000 +0300
+++ edited/include/linux/ext3_fs.h	2003-05-11 23:10:19.000000000 +0400
@@ -270,8 +270,19 @@ struct ext3_inode {
 			__u32	m_i_reserved2[2];
 		} masix2;
 	} osd2;				/* OS dependent 2 */
+	__u16	i_extra_isize;
+	__u16	i_pad1;
+	__u32	i_uatime;	/* access time (useconds) */
+	__u32	i_uctime;	/* change time (useconds) */
+	__u32	i_umtime;	/* modification time (useconds) */
+	__u32	i_crtime;	/* creation time (seconds) */
+	__u32	i_ucrtime;	/* creation time (useconds) */
 };
 
+#define EXT3_FIELD_END(field) (offsetof(struct ext3_inode, field) - \
+				EXT3_GOOD_OLD_INODE_SIZE + \
+				sizeof(*(&((struct ext3_inode *) 0)->field)))
+				
 #define i_size_high	i_dir_acl
 
 #if defined(__KERNEL__) || defined(__linux__)

