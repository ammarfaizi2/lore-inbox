Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131049AbQKWKHx>; Thu, 23 Nov 2000 05:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131133AbQKWKHo>; Thu, 23 Nov 2000 05:07:44 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:9644 "EHLO math.psu.edu")
        by vger.kernel.org with ESMTP id <S131049AbQKWKHf>;
        Thu, 23 Nov 2000 05:07:35 -0500
Date: Thu, 23 Nov 2000 04:37:21 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: "Mohammad A. Haque" <mhaque@haque.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tigran Aivazian <tigran@veritas.com>
Subject: Re: ext2 filesystem corruptions back from dead? 2.4.0-test11
In-Reply-To: <14876.45844.670274.366687@notabene.cse.unsw.edu.au>
Message-ID: <Pine.GSO.4.21.0011230435280.10127-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 23 Nov 2000, Neil Brown wrote:

> Oh, good.  It's not just me and Tigran then.  I was at first blaming
> my raid5 code for this, but if you get it and Tigran gets it (reported 
>   http://boudicca.tux.org/hypermail/linux-kernel/2000week48/0257.html
> ) then it's probably not me.
> 
> And interesting data point:
>  my raid5 reports when it get a read or write request on a block that
>  it currently has an outstanding read or write request.  This report
>  gets triggered just after a spate of "Freeing blocks not in ...zone"
>  messages - there appear to be multiple write requests for the same
>  block.
>  This seems to suggest that something in the buffer cache is getting
>  corrupted.
> 
> Now if only we had a reliable way to reproduce it, we could start a
> binary search for the offending patch... but I can only reproduce it
> on a patched kernel after several hours of performance testing.

Guys, could you try to reproduce it with the following:
diff -urN rc11/fs/buffer.c rc11-ext2/fs/buffer.c
--- rc11/fs/buffer.c	Mon Nov 20 01:18:59 2000
+++ rc11-ext2/fs/buffer.c	Tue Nov 21 01:14:34 2000
@@ -1527,6 +1527,15 @@
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
 
diff -urN rc11/fs/ext2/file.c rc11-ext2/fs/ext2/file.c
--- rc11/fs/ext2/file.c	Wed Oct  4 03:44:54 2000
+++ rc11-ext2/fs/ext2/file.c	Tue Nov 21 01:14:34 2000
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
@@ -110,4 +99,5 @@
 
 struct inode_operations ext2_file_inode_operations = {
 	truncate:	ext2_truncate,
+	setattr:	ext2_notify_change,
 };
diff -urN rc11/fs/ext2/inode.c rc11-ext2/fs/ext2/inode.c
--- rc11/fs/ext2/inode.c	Wed Oct  4 03:44:54 2000
+++ rc11-ext2/fs/ext2/inode.c	Tue Nov 21 01:14:34 2000
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
@@ -216,7 +218,7 @@
  *	i.e. little-endian 32-bit), chain[i].p contains the address of that
  *	number (it points into struct inode for i==0 and into the bh->b_data
  *	for i>0) and chain[i].bh points to the buffer_head of i-th indirect
- *	block for i>0 and NULL for i==0. In other words, it holds the block
+ *	block for i>0 and %NULL for i==0. In other words, it holds the block
  *	numbers of the chain, addresses they were taken from (and where we can
  *	verify that chain did not change) and buffer_heads hosting these
  *	numbers.
@@ -230,11 +232,11 @@
  *	or when it reads all @depth-1 indirect blocks successfully and finds
  *	the whole chain, all way to the data (returns %NULL, *err == 0).
  */
-static inline Indirect *ext2_get_branch(struct inode *inode,
-					int depth,
-					int *offsets,
-					Indirect chain[4],
-					int *err)
+static Indirect *ext2_get_branch(struct inode *inode,
+				 int depth,
+				 int *offsets,
+				 Indirect chain[4],
+				 int *err)
 {
 	kdev_t dev = inode->i_dev;
 	int size = inode->i_sb->s_blocksize;
@@ -505,7 +507,7 @@
 
 static int ext2_get_block(struct inode *inode, long iblock, struct buffer_head *bh_result, int create)
 {
-	int err = -EIO;
+	int err = -EFBIG;
 	int offsets[4];
 	Indirect chain[4];
 	Indirect *partial;
@@ -880,8 +882,6 @@
 	if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
 	    S_ISLNK(inode->i_mode)))
 		return;
-	if (IS_APPEND(inode) || IS_IMMUTABLE(inode))
-		return;
 
 	ext2_discard_prealloc(inode);
 
@@ -1255,6 +1255,13 @@
 	retval = inode_change_ok(inode, iattr);
 	if (retval != 0)
 		goto out;
+
+	if (iattr->ia_valid & ATTR_SIZE) {
+		if (iattr->ia_size > inode->i_sb->u.ext2_sb.s_max_size) {
+			retval = -EFBIG;
+			goto out;
+		}
+	}
 
 	inode_setattr(inode, iattr);
 	
diff -urN rc11/fs/ext2/super.c rc11-ext2/fs/ext2/super.c
--- rc11/fs/ext2/super.c	Wed Oct  4 03:44:54 2000
+++ rc11-ext2/fs/ext2/super.c	Tue Nov 21 01:14:34 2000
@@ -356,6 +356,19 @@
 
 #define log2(n) ffz(~(n))
 
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
+
+
 struct super_block * ext2_read_super (struct super_block * sb, void * data,
 				      int silent)
 {
@@ -517,6 +530,7 @@
 		log2 (EXT2_ADDR_PER_BLOCK(sb));
 	sb->u.ext2_sb.s_desc_per_block_bits =
 		log2 (EXT2_DESC_PER_BLOCK(sb));
+	sb->u.ext2_sb.s_max_size = ext2_max_size(sb->s_blocksize_bits);
 	if (sb->s_magic != EXT2_SUPER_MAGIC) {
 		if (!silent)
 			printk ("VFS: Can't find an ext2 filesystem on dev "
diff -urN rc11/fs/nfsd/vfs.c rc11-ext2/fs/nfsd/vfs.c
--- rc11/fs/nfsd/vfs.c	Mon Nov 20 01:19:03 2000
+++ rc11-ext2/fs/nfsd/vfs.c	Tue Nov 21 01:14:34 2000
@@ -23,7 +23,6 @@
 #include <linux/locks.h>
 #include <linux/fs.h>
 #include <linux/major.h>
-#include <linux/ext2_fs.h>
 #include <linux/proc_fs.h>
 #include <linux/stat.h>
 #include <linux/fcntl.h>
diff -urN rc11/fs/open.c rc11-ext2/fs/open.c
--- rc11/fs/open.c	Thu Nov  2 22:38:59 2000
+++ rc11-ext2/fs/open.c	Tue Nov 21 01:14:34 2000
@@ -102,7 +102,12 @@
 		goto out;
 	inode = nd.dentry->d_inode;
 
-	error = -EACCES;
+	/* For directories it's -EISDIR, for other non-regulars - -EINVAL */
+	error = -EISDIR;
+	if (S_ISDIR(inode->i_mode))
+		goto dput_and_out;
+
+	error = -EINVAL;
 	if (!S_ISREG(inode->i_mode))
 		goto dput_and_out;
 
@@ -163,7 +168,7 @@
 		goto out;
 	dentry = file->f_dentry;
 	inode = dentry->d_inode;
-	error = -EACCES;
+	error = -EINVAL;
 	if (!S_ISREG(inode->i_mode) || !(file->f_mode & FMODE_WRITE))
 		goto out_putf;
 	error = -EPERM;
diff -urN rc11/include/linux/ext2_fs.h rc11-ext2/include/linux/ext2_fs.h
--- rc11/include/linux/ext2_fs.h	Sat Jul 29 12:08:57 2000
+++ rc11-ext2/include/linux/ext2_fs.h	Tue Nov 21 02:02:01 2000
@@ -568,6 +568,8 @@
 extern int ext2_sync_inode (struct inode *);
 extern void ext2_discard_prealloc (struct inode *);
 
+extern int ext2_notify_change (struct dentry *, struct iattr *);
+
 /* ioctl.c */
 extern int ext2_ioctl (struct inode *, struct file *, unsigned int,
 		       unsigned long);
diff -urN rc11/include/linux/ext2_fs_sb.h rc11-ext2/include/linux/ext2_fs_sb.h
--- rc11/include/linux/ext2_fs_sb.h	Wed Oct  4 03:45:06 2000
+++ rc11-ext2/include/linux/ext2_fs_sb.h	Tue Nov 21 01:14:34 2000
@@ -59,6 +59,7 @@
 	int s_feature_compat;
 	int s_feature_incompat;
 	int s_feature_ro_compat;
+	loff_t s_max_size;
 };
 
 #endif	/* _LINUX_EXT2_FS_SB */
diff -urN rc11/kernel/ksyms.c rc11-ext2/kernel/ksyms.c
--- rc11/kernel/ksyms.c	Mon Nov 20 01:19:12 2000
+++ rc11-ext2/kernel/ksyms.c	Tue Nov 21 01:14:35 2000
@@ -23,8 +23,6 @@
 #include <linux/serial.h>
 #include <linux/locks.h>
 #include <linux/delay.h>
-#include <linux/minix_fs.h>
-#include <linux/ext2_fs.h>
 #include <linux/random.h>
 #include <linux/reboot.h>
 #include <linux/pagemap.h>
diff -urN rc11/mm/filemap.c rc11-ext2/mm/filemap.c
--- rc11/mm/filemap.c	Mon Nov 20 01:19:12 2000
+++ rc11-ext2/mm/filemap.c	Tue Nov 21 01:15:04 2000
@@ -2422,6 +2422,7 @@
 	unsigned long	written;
 	long		status;
 	int		err;
+	unsigned	bytes;
 
 	cached_page = NULL;
 
@@ -2466,7 +2467,7 @@
 	}
 
 	while (count) {
-		unsigned long bytes, index, offset;
+		unsigned long index, offset;
 		char *kaddr;
 
 		/*
@@ -2491,7 +2492,7 @@
 
 		status = mapping->a_ops->prepare_write(file, page, offset, offset+bytes);
 		if (status)
-			goto unlock;
+			goto sync_failure;
 		kaddr = page_address(page);
 		status = copy_from_user(kaddr+offset, buf, bytes);
 		flush_dcache_page(page);
@@ -2516,6 +2517,7 @@
 		if (status < 0)
 			break;
 	}
+done:
 	*ppos = pos;
 
 	if (cached_page)
@@ -2530,6 +2532,13 @@
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


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
