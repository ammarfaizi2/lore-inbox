Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266892AbTGKVs7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 17:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266919AbTGKVs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 17:48:58 -0400
Received: from pat.uio.no ([129.240.130.16]:17366 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S266892AbTGKVqw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 17:46:52 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16143.13230.804339.667805@charged.uio.no>
Date: Sat, 12 Jul 2003 00:01:18 +0200
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [RESEND] 2.4.22 NFS O_DIRECT a la mode ->direct_IO2()
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   The following patch reimplements NFS O_DIRECT using a new
  address_space_operation.

Cheers,
  Trond

diff -u --recursive --new-file linux-2.4.22-nodirect/Documentation/Configure.help linux-2.4.22-blech/Documentation/Configure.help
--- linux-2.4.22-nodirect/Documentation/Configure.help	2003-07-09 19:39:39.000000000 +0200
+++ linux-2.4.22-blech/Documentation/Configure.help	2003-07-09 20:07:36.000000000 +0200
@@ -15938,6 +15938,30 @@
 
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
diff -u --recursive --new-file linux-2.4.22-nodirect/fs/Config.in linux-2.4.22-blech/fs/Config.in
--- linux-2.4.22-nodirect/fs/Config.in	2003-07-09 19:39:39.000000000 +0200
+++ linux-2.4.22-blech/fs/Config.in	2003-07-09 20:08:20.000000000 +0200
@@ -106,6 +106,7 @@
    dep_tristate 'InterMezzo file system support (replicating fs) (EXPERIMENTAL)' CONFIG_INTERMEZZO_FS $CONFIG_INET $CONFIG_EXPERIMENTAL
    dep_tristate 'NFS file system support' CONFIG_NFS_FS $CONFIG_INET
    dep_mbool '  Provide NFSv3 client support' CONFIG_NFS_V3 $CONFIG_NFS_FS
+   dep_mbool '  Allow direct I/O on NFS files (EXPERIMENTAL)' CONFIG_NFS_DIRECTIO $CONFIG_NFS_FS $CONFIG_EXPERIMENTAL
    dep_bool '  Root file system on NFS' CONFIG_ROOT_NFS $CONFIG_NFS_FS $CONFIG_IP_PNP
 
    dep_tristate 'NFS server support' CONFIG_NFSD $CONFIG_INET
diff -u --recursive --new-file linux-2.4.22-nodirect/fs/nfs/direct.c linux-2.4.22-blech/fs/nfs/direct.c
--- linux-2.4.22-nodirect/fs/nfs/direct.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.4.22-blech/fs/nfs/direct.c	2003-07-08 11:52:37.000000000 +0200
@@ -0,0 +1,382 @@
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
+static inline int
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
+static inline int
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
+				printk(KERN_ERR
+				"%s: server didn't sync stable write request\n",
+				__FUNCTION__);
+				return -EIO;
+			}
+
+			if (result != arg->count) {
+				printk(KERN_INFO
+					"%s: short write, count=%u, result=%d\n",
+					__FUNCTION__, arg->count, result);
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
+static inline int
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
+	int result = 0;
+	struct inode *inode = file->f_dentry->d_inode;
+	int rsize = NFS_SERVER(inode)->rsize;
+	struct page *pages[NFS_READ_MAXIOV];
+	struct nfs_readargs args = { NFS_FH(inode), offset, 0, iobuf->offset,
+				     pages };
+
+	total = 0;
+	curpage = 0;
+        while (count) {
+		int len, request;
+		struct page **dest = pages;
+
+                request = count;
+                if (count > rsize)
+                        request = rsize;
+		args.count = request;
+		args.offset = offset;
+		args.pgbase = (iobuf->offset + total) & ~PAGE_MASK;
+		len = PAGE_SIZE - args.pgbase;
+
+		do {
+			struct page *page = iobuf->maplist[curpage];
+
+			if (curpage >= iobuf->nr_pages || !page) {
+				result = -EFAULT;
+				goto out_err;
+			}
+
+			*dest++ = page;
+			/* zero after the first iov */
+			if (request < len)
+				break;
+			request -= len;
+			len = PAGE_SIZE;
+			curpage++;
+		} while (request != 0);
+
+                result = nfs_direct_read_rpc(file, &args);
+
+                if (result < 0)
+                        break;
+
+                total += result;
+                if (result < args.count)   /* NFSv2ism */
+                        break;
+                count -= result;
+                offset += result;
+        };
+out_err:
+	if (!total)
+		return result;
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
+	int result = 0;
+	loff_t save_offset = offset;
+	struct inode *inode = file->f_dentry->d_inode;
+	int wsize = NFS_SERVER(inode)->wsize;
+	struct nfs_writeverf first_verf, ret_verf;
+	struct page *pages[NFS_WRITE_MAXIOV];
+        struct nfs_writeargs args = { NFS_FH(inode), 0, 0, NFS_FILE_SYNC, 0,
+				pages };
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
+		int len, request;
+		struct page **dest = pages;
+
+                request = count;
+                if (count > wsize)
+                        request = wsize;
+		args.count = request;
+		args.offset = offset;
+		args.pgbase = (iobuf->offset + total) & ~PAGE_MASK;
+		len = PAGE_SIZE - args.pgbase;
+
+		do {
+			struct page *page = iobuf->maplist[curpage];
+
+			if (curpage >= iobuf->nr_pages || !page) {
+				result = -EFAULT;
+				goto out_err;
+			}
+
+			*dest++ = page;
+			/* zero after the first iov */
+			if (request < len)
+				break;
+			request -= len;
+			len = PAGE_SIZE;
+			curpage++;
+		} while (request != 0);
+
+                result = nfs_direct_write_rpc(file, &args, &ret_verf);
+
+                if (result < 0)
+                        break;
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
+out_err:
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
+	if (!total)
+		return result;
+	return total;
+
+print_retry:
+	printk(KERN_INFO "%s: detected server restart; retrying with FILE_SYNC\n",
+			__FUNCTION__);
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
diff -u --recursive --new-file linux-2.4.22-nodirect/fs/nfs/file.c linux-2.4.22-blech/fs/nfs/file.c
--- linux-2.4.22-nodirect/fs/nfs/file.c	2003-07-09 19:39:39.000000000 +0200
+++ linux-2.4.22-blech/fs/nfs/file.c	2003-07-09 20:10:21.000000000 +0200
@@ -16,6 +16,7 @@
  *  nfs regular file handling functions
  */
 
+#include <linux/config.h>
 #include <linux/sched.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -199,6 +200,9 @@
 	readpage: nfs_readpage,
 	sync_page: nfs_sync_page,
 	writepage: nfs_writepage,
+#ifdef CONFIG_NFS_DIRECTIO
+	direct_fileIO: nfs_direct_IO,
+#endif
 	prepare_write: nfs_prepare_write,
 	commit_write: nfs_commit_write
 };
diff -u --recursive --new-file linux-2.4.22-nodirect/fs/nfs/Makefile linux-2.4.22-blech/fs/nfs/Makefile
--- linux-2.4.22-nodirect/fs/nfs/Makefile	2003-07-09 19:39:39.000000000 +0200
+++ linux-2.4.22-blech/fs/nfs/Makefile	2003-07-09 20:08:47.000000000 +0200
@@ -14,6 +14,7 @@
 
 obj-$(CONFIG_ROOT_NFS) += nfsroot.o mount_clnt.o      
 obj-$(CONFIG_NFS_V3) += nfs3proc.o nfs3xdr.o
+obj-$(CONFIG_NFS_DIRECTIO) += direct.o
 
 obj-m   := $(O_TARGET)
 
diff -u --recursive --new-file linux-2.4.22-nodirect/fs/nfs/write.c linux-2.4.22-blech/fs/nfs/write.c
--- linux-2.4.22-nodirect/fs/nfs/write.c	2003-07-09 19:39:39.000000000 +0200
+++ linux-2.4.22-blech/fs/nfs/write.c	2003-07-09 20:11:04.000000000 +0200
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
diff -u --recursive --new-file linux-2.4.22-nodirect/include/linux/fs.h linux-2.4.22-blech/include/linux/fs.h
--- linux-2.4.22-nodirect/include/linux/fs.h	2003-07-09 19:39:39.000000000 +0200
+++ linux-2.4.22-blech/include/linux/fs.h	2003-07-09 22:33:00.000000000 +0200
@@ -396,6 +396,8 @@
 	int (*releasepage) (struct page *, int);
 #define KERNEL_HAS_O_DIRECT /* this is for modules out of the kernel */
 	int (*direct_IO)(int, struct inode *, struct kiobuf *, unsigned long, int);
+#define KERNEL_HAS_DIRECT_FILEIO /* Unfortunate kludge due to lack of foresight */
+	int (*direct_fileIO)(int, struct file *, struct kiobuf *, unsigned long, int);
 	void (*removepage)(struct page *); /* called when page gets removed from the inode */
 };
 
diff -u --recursive --new-file linux-2.4.22-nodirect/include/linux/nfs_fs.h linux-2.4.22-blech/include/linux/nfs_fs.h
--- linux-2.4.22-nodirect/include/linux/nfs_fs.h	2003-07-09 19:39:39.000000000 +0200
+++ linux-2.4.22-blech/include/linux/nfs_fs.h	2003-07-09 22:33:07.000000000 +0200
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
diff -u --recursive --new-file linux-2.4.22-nodirect/include/linux/nfs_xdr.h linux-2.4.22-blech/include/linux/nfs_xdr.h
--- linux-2.4.22-nodirect/include/linux/nfs_xdr.h	2003-07-09 19:39:39.000000000 +0200
+++ linux-2.4.22-blech/include/linux/nfs_xdr.h	2003-07-09 22:24:50.000000000 +0200
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
diff -u --recursive --new-file linux-2.4.22-nodirect/mm/filemap.c linux-2.4.22-blech/mm/filemap.c
--- linux-2.4.22-nodirect/mm/filemap.c	2003-07-09 19:39:39.000000000 +0200
+++ linux-2.4.22-blech/mm/filemap.c	2003-07-09 22:29:39.000000000 +0200
@@ -1557,6 +1557,21 @@
 	UPDATE_ATIME(inode);
 }
 
+static inline int have_mapping_directIO(struct address_space * mapping)
+{
+	return mapping->a_ops->direct_IO || mapping->a_ops->direct_fileIO;
+}
+
+/* Switch between old and new directIO formats */
+static inline int do_call_directIO(int rw, struct file *filp, struct kiobuf *iobuf, unsigned long offset, int blocksize)
+{
+	struct address_space * mapping = filp->f_dentry->d_inode->i_mapping;
+
+	if (mapping->a_ops->direct_fileIO)
+		return mapping->a_ops->direct_fileIO(rw, filp, iobuf, offset, blocksize);
+	return mapping->a_ops->direct_IO(rw, mapping->host, iobuf, offset, blocksize);
+}
+
 /*
  * i_sem and i_alloc_sem should be held already.  i_sem may be dropped
  * later once we've mapped the new IO.  i_alloc_sem is kept until the IO
@@ -1593,7 +1608,7 @@
 	retval = -EINVAL;
 	if ((offset & blocksize_mask) || (count & blocksize_mask) || ((unsigned long) buf & blocksize_mask))
 		goto out_free;
-	if (!mapping->a_ops->direct_IO)
+	if (!have_mapping_directIO(mapping))
 		goto out_free;
 
 	if ((rw == READ) && (offset + count > size))
@@ -1621,7 +1636,7 @@
 		if (retval)
 			break;
 
-		retval = mapping->a_ops->direct_IO(rw, inode, iobuf, (offset+progress) >> blocksize_bits, blocksize);
+		retval = do_call_directIO(rw, filp, iobuf, (offset+progress) >> blocksize_bits, blocksize);
 
 		if (rw == READ && retval > 0)
 			mark_dirty_kiobuf(iobuf, retval);
