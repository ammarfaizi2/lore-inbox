Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbTGAKoz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 06:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbTGAKoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 06:44:55 -0400
Received: from pat.uio.no ([129.240.130.16]:37841 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262127AbTGAKoh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 06:44:37 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16129.26989.519079.411644@charged.uio.no>
Date: Tue, 1 Jul 2003 12:58:53 +0200
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [RESEND] Experimental O_DIRECT support for NFS
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,
 
  The following patch from Chuck Lever adds experimental support for
O_DIRECT file access under NFS. It is mainly meant for use by database
programs such as Oracle, that need to manage their own caches rather
than relying on the page cache.
                                                                               
Cheers,
  Trond

diff -u --recursive linux-2.4.22-pre2/Documentation/Configure.help linux-2.4.22-odirect/Documentation/Configure.help
--- linux-2.4.22-pre2/Documentation/Configure.help	2003-06-26 23:18:55.000000000 +0200
+++ linux-2.4.22-odirect/Documentation/Configure.help	2003-06-27 01:14:34.000000000 +0200
@@ -15925,6 +15925,30 @@
 
   If unsure, say N.
 
+Allow direct I/O on files in NFS
+CONFIG_NFS_DIRECTIO
+  There are important applications whose performance or correctness
+  depends on uncached access to file data.  Database clusters (multiple
+  copies of the same instance running on separate hosts) implement their
+  own cache coherency protocol that subsumes the NFS cache protocols.
+  Applications that process datasets considerably larger than the client's
+  memory do not always benefit from a local cache.  A streaming video
+  server, for instance, has no need to cache the contents of a file.
+
+  This option enables applications to perform direct I/O on files in NFS
+  file systems using the O_DIRECT open() flag.  When O_DIRECT is set for
+  files, their data is not cached in the system's page cache.  Direct
+  read and write operations are aligned to block boundaries.  Data is
+  moved to and from user-level application buffers directly.
+
+  Unless your program is designed to use O_DIRECT properly, you are much
+  better off allowing the NFS client to manage caching for you.  Misusing
+  O_DIRECT can cause poor server performance or network storms.  This
+  kernel build option defaults OFF to avoid exposing system administrators
+  unwittingly to a potentially hazardous feature.
+
+  If unsure, say N.
+
 Root file system on NFS
 CONFIG_ROOT_NFS
   If you want your Linux box to mount its whole root file system (the
diff -u --recursive linux-2.4.22-pre2/fs/Config.in linux-2.4.22-odirect/fs/Config.in
--- linux-2.4.22-pre2/fs/Config.in	2002-08-14 15:18:24.000000000 +0200
+++ linux-2.4.22-odirect/fs/Config.in	2003-06-27 01:14:34.000000000 +0200
@@ -102,6 +102,7 @@
    dep_tristate 'InterMezzo file system support (replicating fs) (EXPERIMENTAL)' CONFIG_INTERMEZZO_FS $CONFIG_INET $CONFIG_EXPERIMENTAL
    dep_tristate 'NFS file system support' CONFIG_NFS_FS $CONFIG_INET
    dep_mbool '  Provide NFSv3 client support' CONFIG_NFS_V3 $CONFIG_NFS_FS
+   dep_mbool '  Allow direct I/O on NFS files (EXPERIMENTAL)' CONFIG_NFS_DIRECTIO $CONFIG_NFS_FS $CONFIG_EXPERIMENTAL
    dep_bool '  Root file system on NFS' CONFIG_ROOT_NFS $CONFIG_NFS_FS $CONFIG_IP_PNP
 
    dep_tristate 'NFS server support' CONFIG_NFSD $CONFIG_INET
diff -u --recursive linux-2.4.22-pre2/fs/block_dev.c linux-2.4.22-odirect/fs/block_dev.c
--- linux-2.4.22-pre2/fs/block_dev.c	2003-05-28 01:36:30.000000000 +0200
+++ linux-2.4.22-odirect/fs/block_dev.c	2003-06-27 01:14:34.000000000 +0200
@@ -131,8 +131,9 @@
 	return 0;
 }
 
-static int blkdev_direct_IO(int rw, struct inode * inode, struct kiobuf * iobuf, unsigned long blocknr, int blocksize)
+static int blkdev_direct_IO(int rw, struct file * filp, struct kiobuf * iobuf, unsigned long blocknr, int blocksize)
 {
+	struct inode * inode = filp->f_dentry->d_inode->i_mapping->host;
 	return generic_direct_IO(rw, inode, iobuf, blocknr, blocksize, blkdev_get_block);
 }
 
diff -u --recursive linux-2.4.22-pre2/fs/ext2/inode.c linux-2.4.22-odirect/fs/ext2/inode.c
--- linux-2.4.22-pre2/fs/ext2/inode.c	2003-03-13 01:37:19.000000000 +0100
+++ linux-2.4.22-odirect/fs/ext2/inode.c	2003-06-27 01:14:34.000000000 +0200
@@ -592,8 +592,9 @@
 {
 	return generic_block_bmap(mapping,block,ext2_get_block);
 }
-static int ext2_direct_IO(int rw, struct inode * inode, struct kiobuf * iobuf, unsigned long blocknr, int blocksize)
+static int ext2_direct_IO(int rw, struct file * filp, struct kiobuf * iobuf, unsigned long blocknr, int blocksize)
 {
+	struct inode * inode = filp->f_dentry->d_inode->i_mapping->host;
 	return generic_direct_IO(rw, inode, iobuf, blocknr, blocksize, ext2_get_block);
 }
 struct address_space_operations ext2_aops = {
diff -u --recursive linux-2.4.22-pre2/fs/nfs/Makefile linux-2.4.22-odirect/fs/nfs/Makefile
--- linux-2.4.22-pre2/fs/nfs/Makefile	2002-02-05 08:55:11.000000000 +0100
+++ linux-2.4.22-odirect/fs/nfs/Makefile	2003-06-27 01:14:34.000000000 +0200
@@ -14,6 +14,7 @@
 
 obj-$(CONFIG_ROOT_NFS) += nfsroot.o mount_clnt.o      
 obj-$(CONFIG_NFS_V3) += nfs3proc.o nfs3xdr.o
+obj-$(CONFIG_NFS_DIRECTIO) += direct.o
 
 obj-m   := $(O_TARGET)
 
Only in linux-2.4.22-odirect/fs/nfs: direct.c
diff -u --recursive linux-2.4.22-pre2/fs/nfs/file.c linux-2.4.22-odirect/fs/nfs/file.c
--- linux-2.4.22-pre2/fs/nfs/file.c	2002-12-12 11:23:09.000000000 +0100
+++ linux-2.4.22-odirect/fs/nfs/file.c	2003-06-27 01:14:34.000000000 +0200
@@ -16,6 +16,7 @@
  *  nfs regular file handling functions
  */
 
+#include <linux/config.h>
 #include <linux/sched.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -200,6 +201,9 @@
 	sync_page: nfs_sync_page,
 	writepage: nfs_writepage,
 	prepare_write: nfs_prepare_write,
+#ifdef CONFIG_NFS_DIRECTIO
+	direct_IO: nfs_direct_IO,
+#endif
 	commit_write: nfs_commit_write
 };
 
diff -u --recursive linux-2.4.22-pre2/fs/nfs/write.c linux-2.4.22-odirect/fs/nfs/write.c
--- linux-2.4.22-pre2/fs/nfs/write.c	2002-08-14 14:58:39.000000000 +0200
+++ linux-2.4.22-odirect/fs/nfs/write.c	2003-06-27 01:14:34.000000000 +0200
@@ -123,23 +123,6 @@
 }
 
 /*
- * This function will be used to simulate weak cache consistency
- * under NFSv2 when the NFSv3 attribute patch is included.
- * For the moment, we just call nfs_refresh_inode().
- */
-static __inline__ int
-nfs_write_attributes(struct inode *inode, struct nfs_fattr *fattr)
-{
-	if ((fattr->valid & NFS_ATTR_FATTR) && !(fattr->valid & NFS_ATTR_WCC)) {
-		fattr->pre_size  = NFS_CACHE_ISIZE(inode);
-		fattr->pre_mtime = NFS_CACHE_MTIME(inode);
-		fattr->pre_ctime = NFS_CACHE_CTIME(inode);
-		fattr->valid |= NFS_ATTR_WCC;
-	}
-	return nfs_refresh_inode(inode, fattr);
-}
-
-/*
  * Write a page synchronously.
  * Offset is the data offset within the page.
  */
diff -u --recursive linux-2.4.22-pre2/include/linux/fs.h linux-2.4.22-odirect/include/linux/fs.h
--- linux-2.4.22-pre2/include/linux/fs.h	2003-06-20 02:00:00.000000000 +0200
+++ linux-2.4.22-odirect/include/linux/fs.h	2003-06-27 01:14:34.000000000 +0200
@@ -395,7 +395,7 @@
 	int (*flushpage) (struct page *, unsigned long);
 	int (*releasepage) (struct page *, int);
 #define KERNEL_HAS_O_DIRECT /* this is for modules out of the kernel */
-	int (*direct_IO)(int, struct inode *, struct kiobuf *, unsigned long, int);
+	int (*direct_IO)(int, struct file *, struct kiobuf *, unsigned long, int);
 	void (*removepage)(struct page *); /* called when page gets removed from the inode */
 };
 
diff -u --recursive linux-2.4.22-pre2/include/linux/nfs_fs.h linux-2.4.22-odirect/include/linux/nfs_fs.h
--- linux-2.4.22-pre2/include/linux/nfs_fs.h	2002-12-12 11:23:09.000000000 +0100
+++ linux-2.4.22-odirect/include/linux/nfs_fs.h	2003-06-27 01:14:34.000000000 +0200
@@ -274,6 +274,11 @@
 #define NFS_TestClearPageSync(page)	test_and_clear_bit(PG_fs_1, &(page)->flags)
 
 /*
+ * linux/fs/nfs/direct.c
+ */
+extern int  nfs_direct_IO(int, struct file *, struct kiobuf *, unsigned long, int);
+
+/*
  * linux/fs/mount_clnt.c
  * (Used only by nfsroot module)
  */
@@ -302,6 +307,23 @@
 	return __nfs_refresh_inode(inode,fattr);
 }
 
+/*
+ * This function will be used to simulate weak cache consistency
+ * under NFSv2 when the NFSv3 attribute patch is included.
+ * For the moment, we just call nfs_refresh_inode().
+ */
+static __inline__ int
+nfs_write_attributes(struct inode *inode, struct nfs_fattr *fattr)
+{
+	if ((fattr->valid & NFS_ATTR_FATTR) && !(fattr->valid & NFS_ATTR_WCC)) {
+		fattr->pre_size  = NFS_CACHE_ISIZE(inode);
+		fattr->pre_mtime = NFS_CACHE_MTIME(inode);
+		fattr->pre_ctime = NFS_CACHE_CTIME(inode);
+		fattr->valid |= NFS_ATTR_WCC;
+	}
+	return nfs_refresh_inode(inode, fattr);
+}
+
 static inline loff_t
 nfs_size_to_loff_t(__u64 size)
 {
diff -u --recursive linux-2.4.22-pre2/include/linux/nfs_xdr.h linux-2.4.22-odirect/include/linux/nfs_xdr.h
--- linux-2.4.22-pre2/include/linux/nfs_xdr.h	2002-08-14 14:59:37.000000000 +0200
+++ linux-2.4.22-odirect/include/linux/nfs_xdr.h	2003-06-27 01:14:34.000000000 +0200
@@ -59,7 +59,7 @@
 /* Arguments to the read call.
  * Note that NFS_READ_MAXIOV must be <= (MAX_IOVEC-2) from sunrpc/xprt.h
  */
-#define NFS_READ_MAXIOV 8
+#define NFS_READ_MAXIOV		(9)
 
 struct nfs_readargs {
 	struct nfs_fh *		fh;
@@ -78,7 +78,7 @@
 /* Arguments to the write call.
  * Note that NFS_WRITE_MAXIOV must be <= (MAX_IOVEC-2) from sunrpc/xprt.h
  */
-#define NFS_WRITE_MAXIOV        8
+#define NFS_WRITE_MAXIOV	(9)
 struct nfs_writeargs {
 	struct nfs_fh *		fh;
 	__u64			offset;
diff -u --recursive linux-2.4.22-pre2/mm/filemap.c linux-2.4.22-odirect/mm/filemap.c
--- linux-2.4.22-pre2/mm/filemap.c	2003-06-03 13:23:57.000000000 +0200
+++ linux-2.4.22-odirect/mm/filemap.c	2003-06-27 01:14:34.000000000 +0200
@@ -1607,7 +1607,7 @@
 		if (retval)
 			break;
 
-		retval = mapping->a_ops->direct_IO(rw, inode, iobuf, (offset+progress) >> blocksize_bits, blocksize);
+		retval = mapping->a_ops->direct_IO(rw, filp, iobuf, (offset+progress) >> blocksize_bits, blocksize);
 
 		if (rw == READ && retval > 0)
 			mark_dirty_kiobuf(iobuf, retval);
