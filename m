Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261407AbREMOYm>; Sun, 13 May 2001 10:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261408AbREMOYc>; Sun, 13 May 2001 10:24:32 -0400
Received: from mons.uio.no ([129.240.130.14]:59368 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S261407AbREMOYW>;
	Sun, 13 May 2001 10:24:22 -0400
MIME-Version: 1.0
Message-ID: <15102.39186.106340.57504@charged.uio.no>
Date: Sun, 13 May 2001 16:24:18 +0200
To: Linux Kernel <linux-kernel@vger.kernel.org>,
        NFS maillist <nfs@lists.sourceforge.net>
Subject: [PATCH] New patch to flush out dirty mmap()ed NFS pages in 2.4.4
In-Reply-To: <Pine.LNX.4.21.0105120801040.12451-100000@penguin.transmeta.com>
In-Reply-To: <15101.19298.12550.240215@charged.uio.no>
	<Pine.LNX.4.21.0105120801040.12451-100000@penguin.transmeta.com>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Linus was not too keen on the patches that circulated last week. In
his concept of shared mmap(), he wants it to ignore the usual
requirement we have on normal files whereby we flush out the pages on
file close.  The problem is, though, that we need at least to schedule
the writes using the correct credentials, and thus a compromise was to
do this when closing the file...

The following patch attempts to implement a fix along Linus'
specification. Features are:

   - Remove inode operation force_delete(). The latter is toxic to all
     mmap(), as it can cause the inode to get killed before the dirty
     pages get scheduled.

   - Schedule dirty pages upon last fput() of the file.

   - Always write out all dirty pages to the server when
     locking/unlocking.

   - Add a write_inode() method in order to allow bdflush() and
     friends to force out writes when the user calls sys_sync(), when
     umounting, or when memory pressure is high.

   - Since we in any case have to add the write_inode() method, scrap
     the NFS special O_SYNC code, so we can just use the generic stuff
     (which will be faster for large writes).

Comments?

Cheers,
  Trond

diff -u --recursive --new-file linux-2.4.4-fixes/fs/nfs/file.c linux-2.4.4-mmap/fs/nfs/file.c
--- linux-2.4.4-fixes/fs/nfs/file.c	Fri Feb  9 20:29:44 2001
+++ linux-2.4.4-mmap/fs/nfs/file.c	Sat May 12 21:31:39 2001
@@ -39,6 +39,7 @@
 static ssize_t nfs_file_write(struct file *, const char *, size_t, loff_t *);
 static int  nfs_file_flush(struct file *);
 static int  nfs_fsync(struct file *, struct dentry *dentry, int datasync);
+static int  nfs_file_release(struct inode *, struct file *);
 
 struct file_operations nfs_file_operations = {
 	read:		nfs_file_read,
@@ -46,7 +47,7 @@
 	mmap:		nfs_file_mmap,
 	open:		nfs_open,
 	flush:		nfs_file_flush,
-	release:	nfs_release,
+	release:	nfs_file_release,
 	fsync:		nfs_fsync,
 	lock:		nfs_lock,
 };
@@ -87,6 +88,13 @@
 	return status;
 }
 
+int
+nfs_file_release(struct inode *inode, struct file *file)
+{
+	filemap_fdatasync(inode->i_mapping);
+	return nfs_release(inode,file);
+}
+
 static ssize_t
 nfs_file_read(struct file * file, char * buf, size_t count, loff_t *ppos)
 {
@@ -283,9 +291,11 @@
 	 * Flush all pending writes before doing anything
 	 * with locks..
 	 */
-	down(&filp->f_dentry->d_inode->i_sem);
+	filemap_fdatasync(inode->i_mapping);
+	down(&inode->i_sem);
 	status = nfs_wb_all(inode);
-	up(&filp->f_dentry->d_inode->i_sem);
+	up(&inode->i_sem);
+	filemap_fdatawait(inode->i_mapping);
 	if (status < 0)
 		return status;
 
@@ -300,10 +310,12 @@
 	 */
  out_ok:
 	if ((cmd == F_SETLK || cmd == F_SETLKW) && fl->fl_type != F_UNLCK) {
-		down(&filp->f_dentry->d_inode->i_sem);
+		filemap_fdatasync(inode->i_mapping);
+		down(&inode->i_sem);
 		nfs_wb_all(inode);      /* we may have slept */
+		up(&inode->i_sem);
+		filemap_fdatawait(inode->i_mapping);
 		nfs_zap_caches(inode);
-		up(&filp->f_dentry->d_inode->i_sem);
 	}
 	return status;
 }
diff -u --recursive --new-file linux-2.4.4-fixes/fs/nfs/inode.c linux-2.4.4-mmap/fs/nfs/inode.c
--- linux-2.4.4-fixes/fs/nfs/inode.c	Wed Apr 25 23:58:17 2001
+++ linux-2.4.4-mmap/fs/nfs/inode.c	Sat May 12 23:54:16 2001
@@ -45,6 +45,7 @@
 static void nfs_invalidate_inode(struct inode *);
 
 static void nfs_read_inode(struct inode *);
+static void nfs_write_inode(struct inode *,int);
 static void nfs_delete_inode(struct inode *);
 static void nfs_put_super(struct super_block *);
 static void nfs_umount_begin(struct super_block *);
@@ -52,7 +53,7 @@
 
 static struct super_operations nfs_sops = { 
 	read_inode:	nfs_read_inode,
-	put_inode:	force_delete,
+	write_inode:	nfs_write_inode,
 	delete_inode:	nfs_delete_inode,
 	put_super:	nfs_put_super,
 	statfs:		nfs_statfs,
@@ -113,6 +114,14 @@
 	NFS_CACHEINV(inode);
 	NFS_ATTRTIMEO(inode) = NFS_MINATTRTIMEO(inode);
 	NFS_ATTRTIMEO_UPDATE(inode) = jiffies;
+}
+
+static void
+nfs_write_inode(struct inode *inode, int sync)
+{
+	int flags = sync ? FLUSH_WAIT : 0;
+
+	nfs_sync_file(inode, NULL, 0, 0, flags);
 }
 
 static void
diff -u --recursive --new-file linux-2.4.4-fixes/fs/nfs/write.c linux-2.4.4-mmap/fs/nfs/write.c
--- linux-2.4.4-fixes/fs/nfs/write.c	Tue Apr  3 22:45:37 2001
+++ linux-2.4.4-mmap/fs/nfs/write.c	Sat May 12 23:49:15 2001
@@ -457,6 +457,7 @@
 	 *     spinlock since it can run flushd().
 	 */
 	inode_schedule_scan(inode, req->wb_timeout);
+	mark_inode_dirty(inode);
 }
 
 /*
@@ -489,6 +490,7 @@
 	 *     spinlock since it can run flushd().
 	 */
 	inode_schedule_scan(inode, req->wb_timeout);
+	mark_inode_dirty(inode);
 }
 #endif
 
@@ -1013,7 +1015,6 @@
 	struct dentry	*dentry = file->f_dentry;
 	struct inode	*inode = dentry->d_inode;
 	struct nfs_page	*req;
-	int		synchronous = file->f_flags & O_SYNC;
 	int		status = 0;
 
 	dprintk("NFS:      nfs_updatepage(%s/%s %d@%Ld)\n",
@@ -1044,24 +1045,14 @@
 	if (status < 0)
 		goto done;
 
-	if (req->wb_bytes == PAGE_CACHE_SIZE)
-		SetPageUptodate(page);
-
 	status = 0;
-	if (synchronous) {
-		int error;
-
-		error = nfs_sync_file(inode, file, page_index(page), 1, FLUSH_SYNC|FLUSH_STABLE);
-		if (error < 0 || (error = file->f_error) < 0)
-			status = error;
-		file->f_error = 0;
-	} else {
-		/* If we wrote past the end of the page.
-		 * Call the strategy routine so it can send out a bunch
-		 * of requests.
-		 */
-		if (req->wb_offset == 0 && req->wb_bytes == PAGE_CACHE_SIZE)
-			nfs_strategy(inode);
+	/* If we wrote past the end of the page.
+	 * Call the strategy routine so it can send out a bunch
+	 * of requests.
+	 */
+	if (req->wb_offset == 0 && req->wb_bytes == PAGE_CACHE_SIZE) {
+		SetPageUptodate(page);
+		nfs_strategy(inode);
 	}
 	nfs_release_request(req);
 done:
diff -u --recursive --new-file linux-2.4.4-fixes/kernel/ksyms.c linux-2.4.4-mmap/kernel/ksyms.c
--- linux-2.4.4-fixes/kernel/ksyms.c	Fri Apr 27 23:23:25 2001
+++ linux-2.4.4-mmap/kernel/ksyms.c	Wed May  9 18:05:58 2001
@@ -262,6 +262,8 @@
 EXPORT_SYMBOL(dentry_open);
 EXPORT_SYMBOL(filemap_nopage);
 EXPORT_SYMBOL(filemap_sync);
+EXPORT_SYMBOL(filemap_fdatasync);
+EXPORT_SYMBOL(filemap_fdatawait);
 EXPORT_SYMBOL(lock_page);
 
 /* device registration */
