Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143640AbRAHPsF>; Mon, 8 Jan 2001 10:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143676AbRAHPrz>; Mon, 8 Jan 2001 10:47:55 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:11192 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S143640AbRAHPrn>;
	Mon, 8 Jan 2001 10:47:43 -0500
Date: Mon, 8 Jan 2001 10:47:41 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Mason <mason@suse.com>
cc: Alan Cox <alan@redhat.com>, Stefan Traby <stefan@hello-penguin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: ramfs problem... (unlink of sparse file in "D" state)
In-Reply-To: <52950000.978968258@tiny>
Message-ID: <Pine.GSO.4.21.0101081042490.4061-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Jan 2001, Chris Mason wrote:

> 
> 
> On Monday, January 08, 2001 09:02:46 AM -0500 Alexander Viro
> <viro@math.psu.edu> wrote:
> 
> > Alan, consider applying the patch below.
> > Contents:
> [snip]
> > +	do {
> > +		if (buffer_mapped(bh)) {
> > +			bh->b_end_io = end_buffer_io_async;
> > +			atomic_inc(&bh->b_count);
> > +			set_bit(BH_Uptodate, &bh->b_state);
> > +			set_bit(BH_Dirty, &bh->b_state);
> > +			submit_bh(WRITE, bh);
> > +		}
> > +		bh = bh->b_this_page;
> > +	}
>           ^^^^^^^^^^^^^

> This doesn't look right...

No, it doesn't. s/$/while(bh != head);/, indeed. Sorry about that -
cut-and-waste when I did rediff to 2.4.0. Corrected patch follows:

diff -urN S0-AC4/fs/buffer.c S0-AC4-fixes/fs/buffer.c
--- S0-AC4/fs/buffer.c	Mon Jan  8 08:46:17 2001
+++ S0-AC4-fixes/fs/buffer.c	Mon Jan  8 08:28:55 2001
@@ -1493,6 +1493,7 @@
 	int err, i;
 	unsigned long block;
 	struct buffer_head *bh, *head;
+	int need_unlock = 1;
 
 	if (!PageLocked(page))
 		BUG();
@@ -1549,7 +1550,28 @@
 
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
+	} while (bh != head);
+	if (need_unlock)
+		UnlockPage(page);
 	return err;
 }
 
@@ -1620,6 +1642,15 @@
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
 
diff -urN S0-AC4/fs/ext2/file.c S0-AC4-fixes/fs/ext2/file.c
--- S0-AC4/fs/ext2/file.c	Mon Jan  8 08:46:18 2001
+++ S0-AC4-fixes/fs/ext2/file.c	Mon Jan  8 08:34:04 2001
@@ -22,51 +22,6 @@
 #include <linux/ext2_fs.h>
 #include <linux/sched.h>
 
-static loff_t ext2_file_lseek(struct file *, loff_t, int);
-static int ext2_open_file (struct inode *, struct file *);
-
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
-/*
- * Make sure the offset never goes beyond the 32-bit mark..
- */
-static loff_t ext2_file_lseek(
-	struct file *file,
-	loff_t offset,
-	int origin)
-{
-	struct inode *inode = file->f_dentry->d_inode;
-
-	switch (origin) {
-		case 2:
-			offset += inode->i_size;
-			break;
-		case 1:
-			offset += file->f_pos;
-	}
-	if (offset<0)
-		return -EINVAL;
-	if (((unsigned long long) offset >> 32) != 0) {
-		if (offset > ext2_max_sizes[EXT2_BLOCK_SIZE_BITS(inode->i_sb)])
-			return -EINVAL;
-	} 
-	if (offset != file->f_pos) {
-		file->f_pos = offset;
-		file->f_reada = 0;
-		file->f_version = ++event;
-	}
-	return offset;
-}
-
 /*
  * Called when an inode is released. Note that this is different
  * from ext2_file_open: open gets called at every open, but release
@@ -84,7 +39,6 @@
  * the ext2 filesystem.
  */
 struct file_operations ext2_file_operations = {
-	llseek:		ext2_file_lseek,
 	read:		generic_file_read,
 	write:		generic_file_write,
 	ioctl:		ext2_ioctl,
diff -urN S0-AC4/fs/ext2/super.c S0-AC4-fixes/fs/ext2/super.c
--- S0-AC4/fs/ext2/super.c	Mon Jan  8 08:46:18 2001
+++ S0-AC4-fixes/fs/ext2/super.c	Mon Jan  8 08:35:16 2001
@@ -380,6 +380,20 @@
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
+	if (res > 1LL << 32)
+		res = 1LL << 32;
+	return res << bits;
+}
 
 struct super_block * ext2_read_super (struct super_block * sb, void * data,
 				      int silent)
@@ -476,8 +490,7 @@
 		le32_to_cpu(EXT2_SB(sb)->s_es->s_log_block_size) + 10;
 	sb->s_blocksize = 1 << sb->s_blocksize_bits;
 	
-	/* We allow 2^32 blocks - not pages */
-	sb->s_maxbytes = (1ULL<<(sb->s_blocksize_bits+32))-1;
+	sb->s_maxbytes = ext2_max_size(sb->s_blocksize_bits) - 1;
 	
 	if (sb->s_blocksize != BLOCK_SIZE &&
 	    (sb->s_blocksize == 1024 || sb->s_blocksize == 2048 ||
diff -urN S0-AC4/fs/read_write.c S0-AC4-fixes/fs/read_write.c
--- S0-AC4/fs/read_write.c	Fri Sep 22 17:21:19 2000
+++ S0-AC4-fixes/fs/read_write.c	Mon Jan  8 08:32:27 2001
@@ -36,7 +36,7 @@
 			offset += file->f_pos;
 	}
 	retval = -EINVAL;
-	if (offset >= 0) {
+	if (offset>=0 && offset<=file->f_dentry->d_inode->i_sb->s_maxbytes) {
 		if (offset != file->f_pos) {
 			file->f_pos = offset;
 			file->f_reada = 0;
diff -urN S0-AC4/mm/filemap.c S0-AC4-fixes/mm/filemap.c
--- S0-AC4/mm/filemap.c	Mon Jan  8 08:46:34 2001
+++ S0-AC4-fixes/mm/filemap.c	Mon Jan  8 08:26:21 2001
@@ -2452,6 +2452,7 @@
 	unsigned long	written;
 	long		status;
 	int		err;
+	unsigned	bytes;
 
 	cached_page = NULL;
 
@@ -2537,7 +2538,7 @@
 	mark_inode_dirty_sync(inode);
 
 	while (count) {
-		unsigned long bytes, index, offset;
+		unsigned long index, offset;
 		char *kaddr;
 		int deactivate = 1;
 
@@ -2577,7 +2578,7 @@
 
 		status = mapping->a_ops->prepare_write(file, page, offset, offset+bytes);
 		if (status)
-			goto unlock;
+			goto sync_failure;
 		kaddr = page_address(page);
 		status = copy_from_user(kaddr+offset, buf, bytes);
 		flush_dcache_page(page);
@@ -2603,6 +2604,7 @@
 		if (status < 0)
 			break;
 	}
+done:
 	*ppos = pos;
 
 	if (cached_page)
@@ -2627,6 +2629,13 @@
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
