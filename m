Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262828AbSI3S3W>; Mon, 30 Sep 2002 14:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262829AbSI3S3W>; Mon, 30 Sep 2002 14:29:22 -0400
Received: from mons.uio.no ([129.240.130.14]:8328 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S262828AbSI3S3D>;
	Mon, 30 Sep 2002 14:29:03 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15768.39196.468797.249573@charged.uio.no>
Date: Mon, 30 Sep 2002 20:34:04 +0200
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Chuck Lever <cel@netapp.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: [PATCH] 2.4.20 Direct IO patch for NFS. (Note: a trivial API change...)
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Marcelo,

  The following patch implements direct I/O for NFS as a compilation option.
It does not in any way touch the standard NFS read/write code, however it
does change the interface for generic direct I/O: Instead of taking a
'struct inode' argument, we need to take the full 'struct file' in order
to be able to pass the RPC credential information down to the NFS layer.

Cheers,
  Trond


diff -u --recursive --new-file linux-2.4.20-pre8/Documentation/Configure.help linux-2.4.20-directio/Documentation/Configure.help
--- linux-2.4.20-pre8/Documentation/Configure.help	Wed Sep 25 03:02:37 2002
+++ linux-2.4.20-directio/Documentation/Configure.help	Mon Sep 30 18:24:45 2002
@@ -15249,6 +15249,30 @@
 
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
diff -u --recursive --new-file linux-2.4.20-pre8/fs/Config.in linux-2.4.20-directio/fs/Config.in
--- linux-2.4.20-pre8/fs/Config.in	Wed Aug 14 15:18:24 2002
+++ linux-2.4.20-directio/fs/Config.in	Mon Sep 30 18:24:45 2002
@@ -102,6 +102,7 @@
    dep_tristate 'InterMezzo file system support (replicating fs) (EXPERIMENTAL)' CONFIG_INTERMEZZO_FS $CONFIG_INET $CONFIG_EXPERIMENTAL
    dep_tristate 'NFS file system support' CONFIG_NFS_FS $CONFIG_INET
    dep_mbool '  Provide NFSv3 client support' CONFIG_NFS_V3 $CONFIG_NFS_FS
+   dep_mbool '  Allow direct I/O on NFS files (EXPERIMENTAL)' CONFIG_NFS_DIRECTIO $CONFIG_NFS_FS $CONFIG_EXPERIMENTAL
    dep_bool '  Root file system on NFS' CONFIG_ROOT_NFS $CONFIG_NFS_FS $CONFIG_IP_PNP
 
    dep_tristate 'NFS server support' CONFIG_NFSD $CONFIG_INET
diff -u --recursive --new-file linux-2.4.20-pre8/fs/block_dev.c linux-2.4.20-directio/fs/block_dev.c
--- linux-2.4.20-pre8/fs/block_dev.c	Sun May 12 02:26:03 2002
+++ linux-2.4.20-directio/fs/block_dev.c	Mon Sep 30 18:24:45 2002
@@ -131,8 +131,9 @@
 	return 0;
 }
 
-static int blkdev_direct_IO(int rw, struct inode * inode, struct kiobuf * iobuf, unsigned long blocknr, int blocksize)
+static int blkdev_direct_IO(int rw, struct file * filp, struct kiobuf * iobuf, unsigned long blocknr, int blocksize)
 {
+	struct inode * inode = filp->f_dentry->d_inode->i_mapping->host;
 	return generic_direct_IO(rw, inode, iobuf, blocknr, blocksize, blkdev_get_block);
 }
 
diff -u --recursive --new-file linux-2.4.20-pre8/fs/ext2/inode.c linux-2.4.20-directio/fs/ext2/inode.c
--- linux-2.4.20-pre8/fs/ext2/inode.c	Sun Jul  7 11:31:53 2002
+++ linux-2.4.20-directio/fs/ext2/inode.c	Mon Sep 30 18:24:45 2002
@@ -583,8 +583,9 @@
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
diff -u --recursive --new-file linux-2.4.20-pre8/fs/jfs/inode.c linux-2.4.20-directio/fs/jfs/inode.c
--- linux-2.4.20-pre8/fs/jfs/inode.c	Wed Sep 18 15:34:43 2002
+++ linux-2.4.20-directio/fs/jfs/inode.c	Mon Sep 30 18:29:12 2002
@@ -323,9 +323,10 @@
 	return generic_block_bmap(mapping, block, jfs_get_block);
 }
 
-static int jfs_direct_IO(int rw, struct inode *inode, struct kiobuf *iobuf,
+static int jfs_direct_IO(int rw, struct file *filp, struct kiobuf *iobuf,
 			 unsigned long blocknr, int blocksize)
 {
+	struct inode * inode = filp->f_dentry->d_inode->i_mapping->host;
 	return generic_direct_IO(rw, inode, iobuf, blocknr,
 				 blocksize, jfs_get_block);
 }
diff -u --recursive --new-file linux-2.4.20-pre8/fs/nfs/Makefile linux-2.4.20-directio/fs/nfs/Makefile
--- linux-2.4.20-pre8/fs/nfs/Makefile	Tue Feb  5 08:55:11 2002
+++ linux-2.4.20-directio/fs/nfs/Makefile	Mon Sep 30 18:24:45 2002
@@ -14,6 +14,7 @@
 
 obj-$(CONFIG_ROOT_NFS) += nfsroot.o mount_clnt.o      
 obj-$(CONFIG_NFS_V3) += nfs3proc.o nfs3xdr.o
+obj-$(CONFIG_NFS_DIRECTIO) += direct.o
 
 obj-m   := $(O_TARGET)
 
diff -u --recursive --new-file linux-2.4.20-pre8/fs/nfs/direct.c linux-2.4.20-directio/fs/nfs/direct.c
--- linux-2.4.20-pre8/fs/nfs/direct.c	Thu Jan  1 01:00:00 1970
+++ linux-2.4.20-directio/fs/nfs/direct.c	Mon Sep 30 18:24:45 2002
@@ -0,0 +1,374 @@
+/*
+ * linux/fs/nfs/direct.c
+ *
+ * High-performance direct I/O for the NFS client
+ *
+ * When an application requests uncached I/O, all read and write requests
+ * are made directly to the server; data stored or fetched via these
+ * requests is not cached in the Linux page cache.  The client does not
+ * correct unaligned requests from applications.  All requested bytes are
+ * held on permanent storage before a direct write system call returns to
+ * an application.  Applications that manage their own data caching, such
+ * as databases, make very good use of direct I/O on local file systems.
+ *
+ * Solaris implements an uncached I/O facility called directio() that
+ * is used for backups and sequential I/O to very large files.  Solaris
+ * also supports uncaching whole NFS partitions with "-o forcedirectio,"
+ * an undocumented mount option.
+ *
+ * Note that I/O to read in executables (e.g. kernel_read) cannot use
+ * direct (kiobuf) reads because there is no vma backing the passed-in
+ * data buffer.
+ *
+ * Designed by Jeff Kimmel, Chuck Lever, and Trond Myklebust.
+ *
+ * Initial implementation:	12/2001 by Chuck Lever <cel@netapp.com>
+ *
+ * TODO:
+ *
+ * 1.  Use concurrent asynchronous network requests rather than
+ *     serialized synchronous network requests for normal (non-sync)
+ *     direct I/O.
+ */
+
+#include <linux/config.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/file.h>
+#include <linux/errno.h>
+#include <linux/nfs_fs.h>
+#include <linux/smp_lock.h>
+#include <linux/sunrpc/clnt.h>
+#include <linux/iobuf.h>
+
+#include <asm/system.h>
+#include <asm/uaccess.h>
+
+#define NFSDBG_FACILITY		(NFSDBG_PAGECACHE | NFSDBG_VFS)
+#define VERF_SIZE		(2 * sizeof(__u32))
+
+static /* inline */ int
+nfs_direct_read_rpc(struct file *file, struct nfs_readargs *arg)
+{
+	int result;
+	struct inode * inode = file->f_dentry->d_inode;
+	struct nfs_fattr fattr;
+        struct rpc_message msg;
+        struct nfs_readres res = { &fattr, arg->count, 0 };
+
+#ifdef CONFIG_NFS_V3
+	msg.rpc_proc = (NFS_PROTO(inode)->version == 3) ?
+						NFS3PROC_READ : NFSPROC_READ;
+#else
+	msg.rpc_proc = NFSPROC_READ;
+#endif
+	msg.rpc_argp = arg;
+        msg.rpc_resp = &res;
+
+	lock_kernel();
+        msg.rpc_cred = nfs_file_cred(file);
+        fattr.valid = 0;
+        result = rpc_call_sync(NFS_CLIENT(inode), &msg, 0);
+	nfs_refresh_inode(inode, &fattr);
+	unlock_kernel();
+
+	return result;
+}
+
+static /* inline */ int
+nfs_direct_write_rpc(struct file *file, struct nfs_writeargs *arg,
+	struct nfs_writeverf *verf)
+{
+	int result;
+	struct inode *inode = file->f_dentry->d_inode;
+	struct nfs_fattr fattr;
+        struct rpc_message msg;
+        struct nfs_writeres res = { &fattr, verf, 0 };
+
+#ifdef CONFIG_NFS_V3
+	msg.rpc_proc = (NFS_PROTO(inode)->version == 3) ?
+						NFS3PROC_WRITE : NFSPROC_WRITE;
+#else
+	msg.rpc_proc = NFSPROC_WRITE;
+#endif
+	msg.rpc_argp = arg;
+        msg.rpc_resp = &res;
+
+	lock_kernel();
+	msg.rpc_cred = get_rpccred(nfs_file_cred(file));
+	fattr.valid = 0;
+        result = rpc_call_sync(NFS_CLIENT(inode), &msg, 0);
+	nfs_write_attributes(inode, &fattr);
+	put_rpccred(msg.rpc_cred);
+	unlock_kernel();
+
+#ifdef CONFIG_NFS_V3
+	if (NFS_PROTO(inode)->version == 3) {
+		if (result > 0) {
+			if ((arg->stable == NFS_FILE_SYNC) &&
+			    (verf->committed != NFS_FILE_SYNC)) {
+				printk(KERN_ERR __FUNCTION__
+				": server didn't sync stable write request\n");
+				return -EIO;
+			}
+
+			if (result != arg->count) {
+				printk(KERN_INFO __FUNCTION__
+					": short write, count=%u, result=%d\n",
+							arg->count, result);
+			}
+		}
+		return result;
+	} else {
+#endif
+        	verf->committed = NFS_FILE_SYNC; /* NFSv2 always syncs data */
+		if (result == 0)
+			return arg->count;
+		return result;
+#ifdef CONFIG_NFS_V3
+	}
+#endif
+}
+
+#ifdef CONFIG_NFS_V3
+static /* inline */ int
+nfs_direct_commit_rpc(struct inode *inode, loff_t offset, size_t count,
+	struct nfs_writeverf *verf)
+{
+	int result;
+	struct nfs_fattr fattr;
+	struct nfs_writeargs	arg = { NFS_FH(inode), offset, count, 0, 0,
+					NULL };
+	struct nfs_writeres	res = { &fattr, verf, 0 };
+	struct rpc_message	msg = { NFS3PROC_COMMIT, &arg, &res, NULL };
+
+	fattr.valid = 0;
+
+	lock_kernel();
+	result = rpc_call_sync(NFS_CLIENT(inode), &msg, 0);
+	nfs_write_attributes(inode, &fattr);
+	unlock_kernel();
+
+	return result;
+}
+#else
+static inline int
+nfs_direct_commit_rpc(struct inode *inode, loff_t offset, size_t count,
+	struct nfs_writeverf *verf)
+{
+	return 0;
+}
+#endif
+
+/*
+ * Walk through the iobuf and create an iovec for each "rsize" bytes.
+ */
+static int
+nfs_direct_read(struct file *file, struct kiobuf *iobuf, loff_t offset,
+	size_t count)
+{
+	int curpage, total;
+	struct inode *inode = file->f_dentry->d_inode;
+	int rsize = NFS_SERVER(inode)->rsize;
+	struct page **src = iobuf->maplist,
+		    **end = iobuf->maplist + iobuf->nr_pages;
+	struct page *pages[NFS_READ_MAXIOV];
+	struct nfs_readargs args = { NFS_FH(inode),
+				     offset,
+				     0,
+				     iobuf->offset,
+				     pages };
+
+	total = 0;
+	curpage = 0;
+        while (count) {
+		int request, result;
+		struct page **dst = pages;
+
+                request = count;
+                if (count > rsize)
+                        request = rsize;
+		args.count = request;
+
+		do {
+			if (!*src)
+				return -EFAULT;
+
+			*dst++ = *src;
+			/* zero after the first iov */
+			if (request < PAGE_SIZE)
+				break;
+			request -= PAGE_SIZE;
+			src++;
+		} while (request != 0 && src != end);
+
+                result = nfs_direct_read_rpc(file, &args);
+
+                if (result < 0) {
+			if (result == -EISDIR)
+				total = -EINVAL;
+			else
+                        	total = result;
+                        break;
+                }
+
+                total += result;
+                if (result < args.count)   /* NFSv2ism */
+                        break;
+                count -= result;
+		args.offset += result;
+		args.pgbase += result;
+	        args.pgbase &= ~PAGE_MASK;
+        };
+	return total;
+}
+
+/*
+ * Walk through the iobuf and create an iovec for each "wsize" bytes.
+ * If only one network write is necessary, or if the O_SYNC flag or
+ * 'sync' mount option are present, or if this is a V2 inode, use
+ * FILE_SYNC.  Otherwise, use UNSTABLE and finish with a COMMIT.
+ *
+ * The mechanics of this function are much the same as nfs_direct_read,
+ * with the added complexity of committing unstable writes.
+ */
+static int
+nfs_direct_write(struct file *file, struct kiobuf *iobuf,
+	loff_t offset, size_t count)
+{
+	int curpage, total;
+	int need_commit = 0;
+	loff_t save_offset = offset;
+	struct inode *inode = file->f_dentry->d_inode;
+	int wsize = NFS_SERVER(inode)->wsize;
+	struct nfs_writeverf first_verf, ret_verf;
+	struct page *pages[NFS_WRITE_MAXIOV];
+        struct nfs_writeargs args = { NFS_FH(inode), 0, 0, NFS_FILE_SYNC, 0, pages };
+
+#ifdef CONFIG_NFS_V3
+	if ((NFS_PROTO(inode)->version == 3) && (count > wsize) &&
+							(!IS_SYNC(inode)))
+		args.stable = NFS_UNSTABLE;
+#endif
+
+retry:
+	total = 0;
+	curpage = 0;
+        while (count) {
+		int request, result;
+		struct page **dest = pages;
+
+                request = count;
+                if (count > wsize)
+                        request = wsize;
+		args.count = request;
+		args.offset = offset;
+		args.pgbase = (iobuf->offset + total) & ~PAGE_MASK;
+
+		do {
+			struct page *page = iobuf->maplist[curpage];
+
+			if (!page)
+				return -EFAULT;
+
+			*dest++ = page;
+			/* zero after the first iov */
+			if (request > PAGE_SIZE)
+				break;
+			request -= PAGE_SIZE;
+			curpage++;
+		} while (request != 0 && curpage < iobuf->nr_pages);
+
+                result = nfs_direct_write_rpc(file, &args, &ret_verf);
+
+                if (result < 0) {
+                        total = result;
+                        break;
+                }
+
+		if (!total)
+			memcpy(&first_verf.verifier, &ret_verf.verifier,
+								VERF_SIZE);
+		if (ret_verf.committed != NFS_FILE_SYNC) {
+			need_commit = 1;
+			if (memcmp(&first_verf.verifier, &ret_verf.verifier,
+								VERF_SIZE))
+				goto print_retry;
+		}
+
+                total += result;
+                count -= result;
+                offset += result;
+        };
+
+	/*
+	 * Commit data written so far, even in the event of an error
+	 */
+	if (need_commit) {
+		if (nfs_direct_commit_rpc(inode, save_offset,
+					iobuf->length - count, &ret_verf))
+			goto print_retry;
+		if (memcmp(&first_verf.verifier, &ret_verf.verifier,
+								VERF_SIZE))
+			goto print_retry;
+	}
+
+	return total;
+
+print_retry:
+	printk(KERN_INFO __FUNCTION__
+		": detected server restart; retrying with FILE_SYNC\n");
+	args.stable = NFS_FILE_SYNC;
+	offset = save_offset;
+	count = iobuf->length;
+	goto retry;
+}
+
+/*
+ * Read or write data, moving the data directly to/from the
+ * application's buffer without caching in the page cache.
+ *
+ * Rules for direct I/O
+ *
+ * 1.  block size = 512 bytes or more
+ * 2.  file byte offset is block aligned
+ * 3.  byte count is a multiple of block size
+ * 4.  user buffer is not aligned
+ * 5.  user buffer is faulted in and pinned
+ *
+ * These are verified before we get here.
+ */
+int
+nfs_direct_IO(int rw, struct file *file, struct kiobuf *iobuf,
+	unsigned long blocknr, int blocksize)
+{
+	int result = -EINVAL;
+	size_t count = iobuf->length;
+	struct dentry *dentry = file->f_dentry;
+	struct inode *inode = dentry->d_inode;
+	loff_t offset = blocknr << inode->i_blkbits;
+
+	switch (rw) {
+	case READ:
+		dfprintk(VFS,
+			"NFS: direct_IO(READ) (%s/%s) off/cnt(%Lu/%d)\n",
+				dentry->d_parent->d_name.name,
+					dentry->d_name.name, offset, count);
+
+		result = nfs_direct_read(file, iobuf, offset, count);
+		break;
+	case WRITE:
+		dfprintk(VFS,
+			"NFS: direct_IO(WRITE) (%s/%s) off/cnt(%Lu/%d)\n",
+				dentry->d_parent->d_name.name,
+					dentry->d_name.name, offset, count);
+
+		result = nfs_direct_write(file, iobuf, offset, count);
+		break;
+	default:
+		break;
+	}
+
+	dfprintk(VFS, "NFS: direct_IO result = %d\n", result);
+	return result;
+}
diff -u --recursive --new-file linux-2.4.20-pre8/fs/nfs/file.c linux-2.4.20-directio/fs/nfs/file.c
--- linux-2.4.20-pre8/fs/nfs/file.c	Tue Feb  5 15:10:21 2002
+++ linux-2.4.20-directio/fs/nfs/file.c	Mon Sep 30 18:24:45 2002
@@ -16,6 +16,7 @@
  *  nfs regular file handling functions
  */
 
+#include <linux/config.h>
 #include <linux/sched.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -199,6 +200,9 @@
 	sync_page: nfs_sync_page,
 	writepage: nfs_writepage,
 	prepare_write: nfs_prepare_write,
+#ifdef CONFIG_NFS_DIRECTIO
+	direct_IO: nfs_direct_IO,
+#endif
 	commit_write: nfs_commit_write
 };
 
diff -u --recursive --new-file linux-2.4.20-pre8/fs/nfs/write.c linux-2.4.20-directio/fs/nfs/write.c
--- linux-2.4.20-pre8/fs/nfs/write.c	Wed Aug 14 14:58:39 2002
+++ linux-2.4.20-directio/fs/nfs/write.c	Mon Sep 30 18:24:46 2002
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
diff -u --recursive --new-file linux-2.4.20-pre8/fs/reiserfs/inode.c linux-2.4.20-directio/fs/reiserfs/inode.c
--- linux-2.4.20-pre8/fs/reiserfs/inode.c	Thu Sep 12 10:39:21 2002
+++ linux-2.4.20-directio/fs/reiserfs/inode.c	Mon Sep 30 18:32:04 2002
@@ -2119,10 +2119,11 @@
 	}
 }
 
-static int reiserfs_direct_io(int rw, struct inode *inode, 
+static int reiserfs_direct_io(int rw, struct file *filp, 
                               struct kiobuf *iobuf, unsigned long blocknr,
 			      int blocksize) 
 {
+    struct inode * inode = filp->f_dentry->d_inode->i_mapping->host;
     return generic_direct_IO(rw, inode, iobuf, blocknr, blocksize,
                              reiserfs_get_block_direct_io) ;
 }
diff -u --recursive --new-file linux-2.4.20-pre8/include/linux/fs.h linux-2.4.20-directio/include/linux/fs.h
--- linux-2.4.20-pre8/include/linux/fs.h	Wed Sep  4 22:14:54 2002
+++ linux-2.4.20-directio/include/linux/fs.h	Mon Sep 30 18:24:46 2002
@@ -395,7 +395,7 @@
 	int (*flushpage) (struct page *, unsigned long);
 	int (*releasepage) (struct page *, int);
 #define KERNEL_HAS_O_DIRECT /* this is for modules out of the kernel */
-	int (*direct_IO)(int, struct inode *, struct kiobuf *, unsigned long, int);
+	int (*direct_IO)(int, struct file *, struct kiobuf *, unsigned long, int);
 };
 
 struct address_space {
diff -u --recursive --new-file linux-2.4.20-pre8/include/linux/nfs_fs.h linux-2.4.20-directio/include/linux/nfs_fs.h
--- linux-2.4.20-pre8/include/linux/nfs_fs.h	Tue Mar 12 15:25:14 2002
+++ linux-2.4.20-directio/include/linux/nfs_fs.h	Mon Sep 30 18:24:46 2002
@@ -270,6 +270,11 @@
 extern int  nfs_scan_lru_read_timeout(struct nfs_server *, struct list_head *);
 
 /*
+ * linux/fs/nfs/direct.c
+ */
+extern int  nfs_direct_IO(int, struct file *, struct kiobuf *, unsigned long, int);
+
+/*
  * linux/fs/mount_clnt.c
  * (Used only by nfsroot module)
  */
@@ -298,6 +303,23 @@
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
diff -u --recursive --new-file linux-2.4.20-pre8/include/linux/nfs_xdr.h linux-2.4.20-directio/include/linux/nfs_xdr.h
--- linux-2.4.20-pre8/include/linux/nfs_xdr.h	Wed Aug 14 14:59:37 2002
+++ linux-2.4.20-directio/include/linux/nfs_xdr.h	Mon Sep 30 18:24:46 2002
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
diff -u --recursive --new-file linux-2.4.20-pre8/mm/filemap.c linux-2.4.20-directio/mm/filemap.c
--- linux-2.4.20-pre8/mm/filemap.c	Tue Aug 20 13:39:48 2002
+++ linux-2.4.20-directio/mm/filemap.c	Mon Sep 30 18:24:46 2002
@@ -1595,7 +1595,7 @@
 		if (retval)
 			break;
 
-		retval = mapping->a_ops->direct_IO(rw, inode, iobuf, (offset+progress) >> blocksize_bits, blocksize);
+		retval = mapping->a_ops->direct_IO(rw, filp, iobuf, (offset+progress) >> blocksize_bits, blocksize);
 
 		if (rw == READ && retval > 0)
 			mark_dirty_kiobuf(iobuf, retval);
