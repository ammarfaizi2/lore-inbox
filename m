Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262933AbSJDWFA>; Fri, 4 Oct 2002 18:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262934AbSJDWFA>; Fri, 4 Oct 2002 18:05:00 -0400
Received: from dexter.citi.umich.edu ([141.211.133.33]:13184 "EHLO
	dexter.citi.umich.edu") by vger.kernel.org with ESMTP
	id <S262933AbSJDWE5>; Fri, 4 Oct 2002 18:04:57 -0400
Date: Fri, 4 Oct 2002 18:10:26 -0400 (EDT)
From: Chuck Lever <cel@citi.umich.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux NFS List <nfs@lists.sourceforge.net>
Subject: [PATCH] direct-IO API change
Message-ID: <Pine.LNX.4.44.0210041807340.8094-100000@dexter.citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Linus-

this patch is a pre-requisite for NFS direct I/O support (which many would
like to see in 2.5/6), and is being awaited by the raw dev guys.  please
apply this to 2.5.40.

this patch adds a "struct file *" argument to direct I/O.  this is needed 
by NFS direct I/O to make the file's credentials available to direct I/O 
subroutines.  we can't remove "struct inode *" yet because the raw driver 
still needs it.

andrew, trond, and the raw dev team are OK with this patch.

diff -drN -U2 05-jiffies/drivers/char/raw.c 06-odirect1/drivers/char/raw.c
--- 05-jiffies/drivers/char/raw.c	Tue Oct  1 03:07:07 2002
+++ 06-odirect1/drivers/char/raw.c	Fri Oct  4 15:23:13 2002
@@ -223,5 +223,5 @@
 		nr_segs = iov_shorten((struct iovec *)iov, nr_segs, count);
 	}
-	ret = generic_file_direct_IO(rw, inode, iov, *offp, nr_segs);
+	ret = generic_file_direct_IO(rw, filp, inode, iov, *offp, nr_segs);
 
 	if (ret > 0)
diff -drN -U2 05-jiffies/fs/block_dev.c 06-odirect1/fs/block_dev.c
--- 05-jiffies/fs/block_dev.c	Tue Oct  1 03:07:55 2002
+++ 06-odirect1/fs/block_dev.c	Fri Oct  4 15:23:13 2002
@@ -117,6 +117,7 @@
 
 static int
-blkdev_direct_IO(int rw, struct inode *inode, const struct iovec *iov,
-			loff_t offset, unsigned long nr_segs)
+blkdev_direct_IO(int rw, struct file *file, struct inode *inode,
+			const struct iovec *iov, loff_t offset,
+			unsigned long nr_segs)
 {
 	return generic_direct_IO(rw, inode, iov, offset,
diff -drN -U2 05-jiffies/fs/direct-io.c 06-odirect1/fs/direct-io.c
--- 05-jiffies/fs/direct-io.c	Tue Oct  1 03:07:04 2002
+++ 06-odirect1/fs/direct-io.c	Fri Oct  4 15:23:13 2002
@@ -647,11 +647,12 @@
 
 ssize_t
-generic_file_direct_IO(int rw, struct inode *inode, const struct iovec *iov, 
-	loff_t offset, unsigned long nr_segs)
+generic_file_direct_IO(int rw, struct file *file, struct inode *inode,
+	const struct iovec *iov, loff_t offset, unsigned long nr_segs)
 {
 	struct address_space *mapping = inode->i_mapping;
 	ssize_t retval;
 
-	retval = mapping->a_ops->direct_IO(rw, inode, iov, offset, nr_segs);
+	retval = mapping->a_ops->direct_IO(rw, file, inode, iov, offset,
+								nr_segs);
 	if (inode->i_mapping->nrpages)
 		invalidate_inode_pages2(inode->i_mapping);
diff -drN -U2 05-jiffies/fs/ext2/inode.c 06-odirect1/fs/ext2/inode.c
--- 05-jiffies/fs/ext2/inode.c	Tue Oct  1 03:06:16 2002
+++ 06-odirect1/fs/ext2/inode.c	Fri Oct  4 15:23:13 2002
@@ -620,6 +620,7 @@
 
 static int
-ext2_direct_IO(int rw, struct inode *inode, const struct iovec *iov,
-			loff_t offset, unsigned long nr_segs)
+ext2_direct_IO(int rw, struct file *file, struct inode *inode,
+			const struct iovec *iov, loff_t offset,
+			unsigned long nr_segs)
 {
 	return generic_direct_IO(rw, inode, iov,
diff -drN -U2 05-jiffies/fs/ext3/inode.c 06-odirect1/fs/ext3/inode.c
--- 05-jiffies/fs/ext3/inode.c	Tue Oct  1 03:07:11 2002
+++ 06-odirect1/fs/ext3/inode.c	Fri Oct  4 15:23:13 2002
@@ -1400,5 +1400,5 @@
  * crashes then stale disk data _may_ be exposed inside the file.
  */
-static int ext3_direct_IO(int rw, struct inode *inode,
+static int ext3_direct_IO(int rw, struct file *file, struct inode *inode,
 			const struct iovec *iov, loff_t offset,
 			unsigned long nr_segs)
diff -drN -U2 05-jiffies/fs/jfs/inode.c 06-odirect1/fs/jfs/inode.c
--- 05-jiffies/fs/jfs/inode.c	Tue Oct  1 03:05:46 2002
+++ 06-odirect1/fs/jfs/inode.c	Fri Oct  4 15:23:13 2002
@@ -311,6 +311,7 @@
 }
 
-static int jfs_direct_IO(int rw, struct inode *inode, const struct iovec *iov, 
-			loff_t offset, unsigned long nr_segs)
+static int jfs_direct_IO(int rw, struct file *file, struct inode *inode,
+			const struct iovec *iov, loff_t offset,
+			unsigned long nr_segs)
 {
 	return generic_direct_IO(rw, inode, iov,
diff -drN -U2 05-jiffies/fs/xfs/linux/xfs_aops.c 06-odirect1/fs/xfs/linux/xfs_aops.c
--- 05-jiffies/fs/xfs/linux/xfs_aops.c	Tue Oct  1 03:07:36 2002
+++ 06-odirect1/fs/xfs/linux/xfs_aops.c	Fri Oct  4 15:23:13 2002
@@ -682,4 +682,5 @@
 linvfs_direct_IO(
 	int			rw,
+	struct file		*file,
 	struct inode		*inode,
 	const struct iovec	*iov,
diff -drN -U2 05-jiffies/include/linux/fs.h 06-odirect1/include/linux/fs.h
--- 05-jiffies/include/linux/fs.h	Tue Oct  1 03:06:25 2002
+++ 06-odirect1/include/linux/fs.h	Fri Oct  4 15:23:13 2002
@@ -309,5 +309,7 @@
 	int (*invalidatepage) (struct page *, unsigned long);
 	int (*releasepage) (struct page *, int);
-	int (*direct_IO)(int, struct inode *, const struct iovec *iov, loff_t offset, unsigned long nr_segs);
+	int (*direct_IO)(int, struct file *, struct inode *,
+				const struct iovec *iov, loff_t offset,
+				unsigned long nr_segs);
 };
 
@@ -1248,6 +1250,7 @@
 extern ssize_t generic_file_sendfile(struct file *, struct file *, loff_t *, size_t);
 extern void do_generic_file_read(struct file *, loff_t *, read_descriptor_t *, read_actor_t);
-extern ssize_t generic_file_direct_IO(int rw, struct inode *inode, 
-	const struct iovec *iov, loff_t offset, unsigned long nr_segs);
+extern ssize_t generic_file_direct_IO(int rw, struct file *file,
+	struct inode *inode, const struct iovec *iov, loff_t offset,
+	unsigned long nr_segs);
 extern int generic_direct_IO(int rw, struct inode *inode, const struct iovec 
 	*iov, loff_t offset, unsigned long nr_segs, get_blocks_t *get_blocks);
diff -drN -U2 05-jiffies/include/linux/nfs_fs.h 06-odirect1/include/linux/nfs_fs.h
--- 05-jiffies/include/linux/nfs_fs.h	Tue Oct  1 03:06:30 2002
+++ 06-odirect1/include/linux/nfs_fs.h	Fri Oct  4 15:23:13 2002
@@ -15,4 +15,5 @@
 #include <linux/pagemap.h>
 #include <linux/wait.h>
+#include <linux/uio.h>
 
 #include <linux/nfs_fs_sb.h>
@@ -285,4 +286,10 @@
 
 /*
+ * linux/fs/nfs/direct.c
+ */
+extern int nfs_direct_IO(int, struct file *, struct inode *,
+		const struct iovec *, loff_t, unsigned long);
+
+/*
  * linux/fs/nfs/dir.c
  */
diff -drN -U2 05-jiffies/kernel/ksyms.c 06-odirect1/kernel/ksyms.c
--- 05-jiffies/kernel/ksyms.c	Tue Oct  1 03:05:49 2002
+++ 06-odirect1/kernel/ksyms.c	Fri Oct  4 15:23:13 2002
@@ -193,4 +193,5 @@
 EXPORT_SYMBOL(invalidate_device);
 EXPORT_SYMBOL(invalidate_inode_pages);
+EXPORT_SYMBOL_GPL(invalidate_inode_pages2);
 EXPORT_SYMBOL(truncate_inode_pages);
 EXPORT_SYMBOL(fsync_bdev);
diff -drN -U2 05-jiffies/mm/filemap.c 06-odirect1/mm/filemap.c
--- 05-jiffies/mm/filemap.c	Wed Oct  2 13:02:19 2002
+++ 06-odirect1/mm/filemap.c	Fri Oct  4 15:23:13 2002
@@ -1159,5 +1159,5 @@
 							nr_segs, count);
 			}
-			retval = generic_file_direct_IO(READ, inode, 
+			retval = generic_file_direct_IO(READ, filp, inode, 
 					iov, pos, nr_segs);
 			if (retval > 0)
@@ -1841,5 +1841,5 @@
 			nr_segs = iov_shorten((struct iovec *)iov,
 						nr_segs, count);
-		written = generic_file_direct_IO(WRITE, inode, 
+		written = generic_file_direct_IO(WRITE, file, inode, 
 					iov, pos, nr_segs);
 		if (written > 0) {

-- 

corporate:	<cel at netapp dot com>
personal:	<chucklever at bigfoot dot com>

