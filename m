Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131410AbRAHIlr>; Mon, 8 Jan 2001 03:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131097AbRAHIl2>; Mon, 8 Jan 2001 03:41:28 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:664 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131092AbRAHIlT>;
	Mon, 8 Jan 2001 03:41:19 -0500
Date: Mon, 8 Jan 2001 03:41:13 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Wedgwood <cw@f00f.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Stefan Traby <stefan@hello-penguin.com>, linux-kernel@vger.kernel.org
Subject: [PATCH(es)] Re: ramfs problem... (unlink of sparse file in "D" state)
In-Reply-To: <20010108211206.C4993@metastasis.f00f.org>
Message-ID: <Pine.GSO.4.21.0101080313050.2221-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Jan 2001, Chris Wedgwood wrote:

> On Mon, Jan 08, 2001 at 02:56:10AM -0500, Alexander Viro wrote:
> 
>     	Plenty. ext2, for one - e.g. with 4Kb blocks you have limit
>     at 0x4010040c000 for files and 0x100000000 for directories. With
>     1Kb blocks the limit for files is 0x404043000. Notice that the
>     latter is not a multiple of page size on Alpha.
> 
> There is code to support this in 2.4.0-ac4 -- initially I didn't like
> the way Alan had done things (I was think -EFBIG should be used only
> for LFS violations) but after some thought has decided that what he
> has makes a lot of sense.
> 
> The FS calculates the largest suitable byte-size for a file in put it
> in the superblock; when the VFS checks in the generic_file_* paths.
> The only time this won't work is if some complex criteria allows some
> files to be larger than others, in which case -- we add a callback to
> the fs.

It's still not enough. get_block() can fail for a lot of reasons and
generic_file_write() should be prepared to deal with that. -EFBIG
is nothing special in that respect. We don't need new callbacks, get_block()
is quite enough.

IOW, the following is still needed:

diff -urN S0/fs/buffer.c S0-get_block_fail/fs/buffer.c
--- S0/fs/buffer.c	Wed Jan  3 23:45:26 2001
+++ S0-get_block_fail/fs/buffer.c	Mon Jan  8 03:12:07 2001
@@ -1494,6 +1494,7 @@
 	int err, i;
 	unsigned long block;
 	struct buffer_head *bh, *head;
+	int need_unlock = 1;
 
 	if (!PageLocked(page))
 		BUG();
@@ -1539,18 +1540,39 @@
 	} while (bh != head);
 
 	/* Stage 3: submit the IO */
+	SetPageUptodate(page);
 	do {
 		submit_bh(WRITE, bh);
 		bh = bh->b_this_page;		
 	} while (bh != head);
 
 	/* Done - end_buffer_io_async will unlock */
-	SetPageUptodate(page);
 	return 0;
 
 out:
 	ClearPageUptodate(page);
-	UnlockPage(page);
+	bh = head;
+	need_unlock = 1;
+	/* Recovery: lock and submit the mapped buffers */
+	do {
+		if (buffer_mapped(bh)) {
+			lock_buffer(bh);
+			need_unlock = 0;
+		}
+		bh = bh->b_this_page;
+	} while (bh != head);
+	do {
+		if (buffer_mapped(bh)) {
+			bh->b_end_io = end_buffer_io_async;
+			atomic_inc(&bh->b_count);
+			set_bit(BH_Uptodate, &bh->b_state);
+			set_bit(BH_Dirty, &bh->b_state);
+			submit_bh(WRITE, bh);
+		}
+		bh = bh->b_this_page;
+	}
+	if (need_unlock)
+		UnlockPage(page);
 	return err;
 }
 
@@ -1621,6 +1643,15 @@
 	}
 	return 0;
 out:
+	bh = head;
+	do {
+		if (buffer_new(bh) && !buffer_uptodate(bh)) {
+			memset(bh->b_data, 0, bh->b_size);
+			set_bit(BH_Uptodate, &bh->b_state);
+			mark_buffer_dirty(bh);
+		}
+		bh = bh->b_this_page;
+	} while (bh != head);
 	return err;
 }
 
diff -urN S0/mm/filemap.c S0-get_block_fail/mm/filemap.c
--- S0/mm/filemap.c	Tue Jan  2 21:59:45 2001
+++ S0-get_block_fail/mm/filemap.c	Mon Jan  8 03:13:37 2001
@@ -2449,6 +2449,7 @@
 	unsigned long	written;
 	long		status;
 	int		err;
+	unsigned	bytes;
 
 	cached_page = NULL;
 
@@ -2493,7 +2494,7 @@
 	}
 
 	while (count) {
-		unsigned long bytes, index, offset;
+		unsigned long index, offset;
 		char *kaddr;
 		int deactivate = 1;
 
@@ -2532,7 +2533,7 @@
 
 		status = mapping->a_ops->prepare_write(file, page, offset, offset+bytes);
 		if (status)
-			goto unlock;
+			goto sync_failure;
 		kaddr = page_address(page);
 		status = copy_from_user(kaddr+offset, buf, bytes);
 		flush_dcache_page(page);
@@ -2558,6 +2559,7 @@
 		if (status < 0)
 			break;
 	}
+done:
 	*ppos = pos;
 
 	if (cached_page)
@@ -2578,6 +2580,13 @@
 	ClearPageUptodate(page);
 	kunmap(page);
 	goto unlock;
+sync_failure:
+	UnlockPage(page);
+	deactivate_page(page);
+	page_cache_release(page);
+	if (pos + bytes > inode->i_size)
+		vmtruncate(inode, inode->i_size);
+	goto done;
 }
 
 void __init page_cache_init(unsigned long mempages)


and with that patch the rest of filesize limits goes into filesystems. For
ext2 it would be

diff -urN S0/fs/ext2/inode.c S0-ext2_get_block-EFBIG/fs/ext2/inode.c
--- S0/fs/ext2/inode.c	Fri Dec 29 17:36:44 2000
+++ S0-ext2_get_block-EFBIG/fs/ext2/inode.c	Mon Jan  8 03:22:58 2001
@@ -153,11 +153,13 @@
  *	This function translates the block number into path in that tree -
  *	return value is the path length and @offsets[n] is the offset of
  *	pointer to (n+1)th node in the nth one. If @block is out of range
- *	(negative or too large) warning is printed and zero returned.
+ *	(negative or too large) we return zero. Warning is printed if @block
+ *	is negative - that should never happen. Too large value is OK, it
+ *	just means that ext2_get_block() should return -%EFBIG.
  *
  *	Note: function doesn't find node addresses, so no IO is needed. All
  *	we need to know is the capacity of indirect blocks (taken from the
- *	inode->i_sb).
+ *	@inode->i_sb).
  */
 
 /*
@@ -196,7 +198,7 @@
 		offsets[n++] = (i_block >> ptrs_bits) & (ptrs - 1);
 		offsets[n++] = i_block & (ptrs - 1);
 	} else {
-		ext2_warning (inode->i_sb, "ext2_block_to_path", "block > big");
+		/* Too large, nothing to do here */
 	}
 	return n;
 }
@@ -505,7 +507,7 @@
 
 static int ext2_get_block(struct inode *inode, long iblock, struct buffer_head *bh_result, int create)
 {
-	int err = -EIO;
+	int err = -EFBIG;
 	int offsets[4];
 	Indirect chain[4];
 	Indirect *partial;

plus 

diff -urN S0/fs/ext2/inode.c S0-ext2-LFS/fs/ext2/inode.c
--- S0/fs/ext2/inode.c	Fri Dec 29 17:36:44 2000
+++ S0-ext2-LFS/fs/ext2/inode.c	Fri Jan  5 21:11:31 2001
@@ -1188,7 +1188,7 @@
 		raw_inode->i_dir_acl = cpu_to_le32(inode->u.ext2_i.i_dir_acl);
 	else {
 		raw_inode->i_size_high = cpu_to_le32(inode->i_size >> 32);
-		if (raw_inode->i_size_high) {
+		if (raw_inode->i_size_high || (inode->i_size & (1<<31))) {
 			struct super_block *sb = inode->i_sb;
 			if (!EXT2_HAS_RO_COMPAT_FEATURE(sb,
 					EXT2_FEATURE_RO_COMPAT_LARGE_FILE) ||

plus 

diff -urN S0/fs/ext2/file.c S0-ext2_max_size/fs/ext2/file.c
--- S0/fs/ext2/file.c	Wed Sep 27 16:41:33 2000
+++ S0-ext2_max_size/fs/ext2/file.c	Mon Jan  8 03:29:41 2001
@@ -25,17 +25,6 @@
 static loff_t ext2_file_lseek(struct file *, loff_t, int);
 static int ext2_open_file (struct inode *, struct file *);
 
-#define EXT2_MAX_SIZE(bits)							\
-	(((EXT2_NDIR_BLOCKS + (1LL << (bits - 2)) + 				\
-	   (1LL << (bits - 2)) * (1LL << (bits - 2)) + 				\
-	   (1LL << (bits - 2)) * (1LL << (bits - 2)) * (1LL << (bits - 2))) * 	\
-	  (1LL << bits)) - 1)
-
-static long long ext2_max_sizes[] = {
-0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
-EXT2_MAX_SIZE(10), EXT2_MAX_SIZE(11), EXT2_MAX_SIZE(12), EXT2_MAX_SIZE(13)
-};
-
 /*
  * Make sure the offset never goes beyond the 32-bit mark..
  */
@@ -56,7 +45,7 @@
 	if (offset<0)
 		return -EINVAL;
 	if (((unsigned long long) offset >> 32) != 0) {
-		if (offset > ext2_max_sizes[EXT2_BLOCK_SIZE_BITS(inode->i_sb)])
+		if (offset >= inode->i_sb->u.ext2_sb.s_max_size)
 			return -EINVAL;
 	} 
 	if (offset != file->f_pos) {
diff -urN S0/fs/ext2/super.c S0-ext2_max_size/fs/ext2/super.c
--- S0/fs/ext2/super.c	Fri Dec 29 17:36:44 2000
+++ S0-ext2_max_size/fs/ext2/super.c	Mon Jan  8 03:30:49 2001
@@ -380,6 +380,18 @@
 }
 
 #define log2(n) ffz(~(n))
+ 
+/*
+ * maximal file size.
+ */
+static loff_t ext2_max_size(int bits)
+{
+	loff_t res = EXT2_NDIR_BLOCKS;
+	res += 1LL << (bits-2);
+	res += 1LL << (2*(bits-2));
+	res += 1LL << (3*(bits-2));
+	return res << bits;
+}
 
 struct super_block * ext2_read_super (struct super_block * sb, void * data,
 				      int silent)
@@ -549,6 +561,7 @@
 		log2 (EXT2_ADDR_PER_BLOCK(sb));
 	sb->u.ext2_sb.s_desc_per_block_bits =
 		log2 (EXT2_DESC_PER_BLOCK(sb));
+	sb->u.ext2_sb.s_max_size = ext2_max_size(sb->s_blocksize_bits);
 	if (sb->s_magic != EXT2_SUPER_MAGIC) {
 		if (!silent)
 			printk ("VFS: Can't find an ext2 filesystem on dev "
diff -urN S0/include/linux/ext2_fs_sb.h S0-ext2_max_size/include/linux/ext2_fs_sb.h
--- S0/include/linux/ext2_fs_sb.h	Fri Dec 29 17:36:44 2000
+++ S0-ext2_max_size/include/linux/ext2_fs_sb.h	Mon Jan  8 03:31:19 2001
@@ -56,6 +56,7 @@
 	int s_desc_per_block_bits;
 	int s_inode_size;
 	int s_first_ino;
+	loff_t s_max_size;
 };
 
 #endif	/* _LINUX_EXT2_FS_SB */

plus


diff -urN S0-ext2_max_size/fs/ext2/file.c S0-ext2-LFS-full/fs/ext2/file.c
--- S0-ext2_max_size/fs/ext2/file.c	Mon Jan  8 03:29:41 2001
+++ S0-ext2-LFS-full/fs/ext2/file.c	Mon Jan  8 03:37:41 2001
@@ -99,4 +99,5 @@
 
 struct inode_operations ext2_file_inode_operations = {
 	truncate:	ext2_truncate,
+	setattr:	ext2_notify_change,
 };
diff -urN S0-ext2_max_size/fs/ext2/inode.c S0-ext2-LFS-full/fs/ext2/inode.c
--- S0-ext2_max_size/fs/ext2/inode.c	Fri Dec 29 17:36:44 2000
+++ S0-ext2-LFS-full/fs/ext2/inode.c	Mon Jan  8 03:37:41 2001
@@ -880,8 +880,6 @@
 	if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
 	    S_ISLNK(inode->i_mode)))
 		return;
-	if (IS_APPEND(inode) || IS_IMMUTABLE(inode))
-		return;
 
 	ext2_discard_prealloc(inode);
 
@@ -1239,11 +1237,17 @@
 	return ext2_update_inode (inode, 1);
 }
 
+static struct {unsigned attr, flag, ext2;} ext2_attr[] = {
+	{ATTR_FLAG_SYNCRONOUS,	S_SYNC,		EXT2_SYNC_FL},
+	{ATTR_FLAG_NOATIME,	S_NOATIME,	EXT2_NOATIME_FL},
+	{ATTR_FLAG_APPEND,	S_APPEND,	EXT2_APPEND_FL},
+	{ATTR_FLAG_IMMUTABLE,	S_IMMUTABLE,	EXT2_IMMUTABLE_FL}
+};
+	
 int ext2_notify_change(struct dentry *dentry, struct iattr *iattr)
 {
 	struct inode *inode = dentry->d_inode;
 	int		retval;
-	unsigned int	flags;
 	
 	retval = -EPERM;
 	if (iattr->ia_valid & ATTR_ATTR_FLAG &&
@@ -1260,36 +1264,27 @@
 	if (retval != 0)
 		goto out;
 
+	if (iattr->ia_valid & ATTR_SIZE) {
+		if (iattr->ia_size > inode->i_sb->u.ext2_sb.s_max_size) {
+			retval = -EFBIG;
+			goto out;
+		}
+	}
+
 	inode_setattr(inode, iattr);
 	
-	flags = iattr->ia_attr_flags;
-	if (flags & ATTR_FLAG_SYNCRONOUS) {
-		inode->i_flags |= S_SYNC;
-		inode->u.ext2_i.i_flags |= EXT2_SYNC_FL;
-	} else {
-		inode->i_flags &= ~S_SYNC;
-		inode->u.ext2_i.i_flags &= ~EXT2_SYNC_FL;
-	}
-	if (flags & ATTR_FLAG_NOATIME) {
-		inode->i_flags |= S_NOATIME;
-		inode->u.ext2_i.i_flags |= EXT2_NOATIME_FL;
-	} else {
-		inode->i_flags &= ~S_NOATIME;
-		inode->u.ext2_i.i_flags &= ~EXT2_NOATIME_FL;
-	}
-	if (flags & ATTR_FLAG_APPEND) {
-		inode->i_flags |= S_APPEND;
-		inode->u.ext2_i.i_flags |= EXT2_APPEND_FL;
-	} else {
-		inode->i_flags &= ~S_APPEND;
-		inode->u.ext2_i.i_flags &= ~EXT2_APPEND_FL;
-	}
-	if (flags & ATTR_FLAG_IMMUTABLE) {
-		inode->i_flags |= S_IMMUTABLE;
-		inode->u.ext2_i.i_flags |= EXT2_IMMUTABLE_FL;
-	} else {
-		inode->i_flags &= ~S_IMMUTABLE;
-		inode->u.ext2_i.i_flags &= ~EXT2_IMMUTABLE_FL;
+	if (iattr->ia_valid & ATTR_ATTR_FLAG) {
+		unsigned flags = iattr->ia_attr_flags;
+		int i;
+		for (i=0; i<sizeof(ext2_attr)/sizeof(ext2_attr[0]); i++) {
+			if (flags & ext2_attr[i].attr) {
+				inode->i_flags |= ext2_attr[i].flag;
+				inode->u.ext2_i.i_flags |= ext2_attr[i].ext2;
+			} else {
+				inode->i_flags &= ~ext2_attr[i].flag;
+				inode->u.ext2_i.i_flags &= ~ext2_attr[i].ext2;
+			}
+		}
 	}
 	mark_inode_dirty(inode);
 out:
diff -urN S0-ext2_max_size/include/linux/ext2_fs.h S0-ext2-LFS-full/include/linux/ext2_fs.h
--- S0-ext2_max_size/include/linux/ext2_fs.h	Thu Jan  4 17:50:47 2001
+++ S0-ext2-LFS-full/include/linux/ext2_fs.h	Mon Jan  8 03:37:41 2001
@@ -582,6 +582,8 @@
 extern int ext2_sync_inode (struct inode *);
 extern void ext2_discard_prealloc (struct inode *);
 
+extern int ext2_notify_change (struct dentry *, struct iattr *);
+
 /* ioctl.c */
 extern int ext2_ioctl (struct inode *, struct file *, unsigned int,
 		       unsigned long);

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
