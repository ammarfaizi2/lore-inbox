Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130306AbQKRK7I>; Sat, 18 Nov 2000 05:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131477AbQKRK66>; Sat, 18 Nov 2000 05:58:58 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:59565 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130306AbQKRK6s>;
	Sat, 18 Nov 2000 05:58:48 -0500
Date: Sat, 18 Nov 2000 05:28:46 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] ext2 largefile fixes + [f]truncate() error value fix
Message-ID: <Pine.GSO.4.21.0011180503110.19917-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	* maximal allowed size is calculated during the ext2_read_super()
and stored in sb->u.ext2_sb.s_max_size. ext2_file_lseek() uses it instead
of the (rather ugly) tricks with ext2_max_sizes[]. Cleaner, more effecient
and IMO more readable.
	* ext2_notify_change() is used as ->setattr(). It checks for the
iattr->ia_size validity before calling inode_setattr() (and returns -EFBIG
if the new size is too large).
	* ext2_get_branch() is not inline anymore. It was too long for that
and change gives smaller and faster code.
	* ext2_get_block() returns -EFBIG if the block number is too large.
Warning from ext2_block_to_path() is gone - there's nothing wrong with
such request in itself.
	* truncate() returns -EINVAL for pipes/symlinks/sockets/devices.
For directories - -EISDIR. I.e. same behaviour as in case of other Unices.
(code in the tree gives -EACCES, which is rather strange in that context
and doesn't conform to standards and behaviour of other Unices).
	* ftruncate() returns -EINVAL for non-files and for files opened
read-only. Rationale: same as above (arguably, -EACCES would be fine for
file opened with O_RDONLY, but... both the standards and other Unices
say -EINVAL here).
	* #include <linux/ext2_fs.h> removed from ksyms.c. It is not
needed there (hardly a surprise, since ext2 can be modular itself and
it doesn't export anything). Ditto for <linux/minix_fs.h> - how on the
Earth did they get there in the first place?
	* #include <linux/ext2_fs.h> removed from fs/nfsd/vfs.c - it isn't
needed there (it _is_ needed in fs/nfsd/nfs3proc.c due to the ugly pathconf
stuff, so that instance had been left intact. That area needs watching -
it has a nice potential of growing into a big, ugly array of kludges).

	Warning: this stuff didn't get really serious testing. OTOH, it
looks fairly obvious, so I wouldn't expect problems with it. Famous
last words and all such...
							Cheers,
								Al

diff -urN rc11-pre7/fs/ext2/file.c rc11-pre7-ext2/fs/ext2/file.c
--- rc11-pre7/fs/ext2/file.c	Wed Oct  4 03:44:54 2000
+++ rc11-pre7-ext2/fs/ext2/file.c	Sat Nov 18 05:00:40 2000
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
diff -urN rc11-pre7/fs/ext2/inode.c rc11-pre7-ext2/fs/ext2/inode.c
--- rc11-pre7/fs/ext2/inode.c	Wed Oct  4 03:44:54 2000
+++ rc11-pre7-ext2/fs/ext2/inode.c	Sat Nov 18 05:13:58 2000
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
@@ -1255,6 +1257,13 @@
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
 	
diff -urN rc11-pre7/fs/ext2/super.c rc11-pre7-ext2/fs/ext2/super.c
--- rc11-pre7/fs/ext2/super.c	Wed Oct  4 03:44:54 2000
+++ rc11-pre7-ext2/fs/ext2/super.c	Sat Nov 18 05:01:03 2000
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
diff -urN rc11-pre7/fs/nfsd/vfs.c rc11-pre7-ext2/fs/nfsd/vfs.c
--- rc11-pre7/fs/nfsd/vfs.c	Sat Nov 18 00:28:17 2000
+++ rc11-pre7-ext2/fs/nfsd/vfs.c	Sat Nov 18 05:52:11 2000
@@ -23,7 +23,6 @@
 #include <linux/locks.h>
 #include <linux/fs.h>
 #include <linux/major.h>
-#include <linux/ext2_fs.h>
 #include <linux/proc_fs.h>
 #include <linux/stat.h>
 #include <linux/fcntl.h>
diff -urN rc11-pre7/fs/open.c rc11-pre7-ext2/fs/open.c
--- rc11-pre7/fs/open.c	Thu Nov  2 22:38:59 2000
+++ rc11-pre7-ext2/fs/open.c	Sat Nov 18 05:19:26 2000
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
diff -urN rc11-pre7/include/linux/ext2_fs.h rc11-pre7-ext2/include/linux/ext2_fs.h
--- rc11-pre7/include/linux/ext2_fs.h	Sat Jul 29 12:08:57 2000
+++ rc11-pre7-ext2/include/linux/ext2_fs.h	Sat Nov 18 05:40:28 2000
@@ -568,6 +568,8 @@
 extern int ext2_sync_inode (struct inode *);
 extern void ext2_discard_prealloc (struct inode *);
 
+extern int ext2_notify_change (struct dentry *, struct iattr *);
+
 /* ioctl.c */
 extern int ext2_ioctl (struct inode *, struct file *, unsigned int,
 		       unsigned long);
diff -urN rc11-pre7/include/linux/ext2_fs_sb.h rc11-pre7-ext2/include/linux/ext2_fs_sb.h
--- rc11-pre7/include/linux/ext2_fs_sb.h	Wed Oct  4 03:45:06 2000
+++ rc11-pre7-ext2/include/linux/ext2_fs_sb.h	Sat Nov 18 04:47:37 2000
@@ -59,6 +59,7 @@
 	int s_feature_compat;
 	int s_feature_incompat;
 	int s_feature_ro_compat;
+	loff_t s_max_size;
 };
 
 #endif	/* _LINUX_EXT2_FS_SB */
diff -urN rc11-pre7/kernel/ksyms.c rc11-pre7-ext2/kernel/ksyms.c
--- rc11-pre7/kernel/ksyms.c	Sat Nov 18 00:28:25 2000
+++ rc11-pre7-ext2/kernel/ksyms.c	Sat Nov 18 05:52:40 2000
@@ -23,8 +23,6 @@
 #include <linux/serial.h>
 #include <linux/locks.h>
 #include <linux/delay.h>
-#include <linux/minix_fs.h>
-#include <linux/ext2_fs.h>
 #include <linux/random.h>
 #include <linux/reboot.h>
 #include <linux/pagemap.h>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
