Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263932AbTDDTJL (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 14:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263933AbTDDTJL (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 14:09:11 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:1273 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S263932AbTDDTJH (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 14:09:07 -0500
Message-ID: <3E8DDB13.9020009@RedHat.com>
Date: Fri, 04 Apr 2003 14:20:51 -0500
From: Steve Dickson <SteveD@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: nfs@lists.sourceforge.net, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [NFS] [PATCH] mmap corruption
Content-Type: multipart/mixed;
 boundary="------------010001080807020904040708"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010001080807020904040708
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The following patch stops memory mapped corruption due
to pages not being flushed in a timely matter. This
patch is for the 2.4.20 kernel.

The Problem: The corruption occurred when 300 of the File System
Exerciser (fsx) processes are started simultaneously. These processes do
random mmap-ed read/writes, file truncations, normal reads/writes,
and opens/closes one on data file. Just to make things more interesting,
each process opens a logging file and output file in the same directory
(a total of three files per process). The corruption occurred on one
of the data files after 3 to 5 mins.

The Cause: Memory mapped pages were not being flushed out in a timely
manner. When a file is about to truncated (up or down), nfs_writepage()
is called (by filemap_fdatasync()) to flush out dirty pages. When this done
asynchronously, nfs_writepage() will (indirectly) call nfs_strategy().
nfs_strategy() wants to send groups of pages (in this case 4 pages). Now in
the error case, only one page was dirty so it was *not* flushed out.
Eventually that page would be flushed (by kupdate) but it was too late
because the file size had already change due to a second truncation.

My Solution: When a file is going to be truncated down (i.e. the file
is going to shrink), _synchronously_ flush out the mmapped pages. I used
the (unused) NFS_INO_FLUSH flag be to tell nfs_writepage to synchronously
write out the page. This sync write *only* occurs when there are dirty
mmapped pages and the file size is going to shrink. And then only the
mmapped pages are written out synchronously so there should very little
affect on I/O performance due to this synchronization. Definitely worth
the price of  correctness, IMHO....


SteveD.

--------------010001080807020904040708
Content-Type: text/plain;
 name="linux-2.4.20-nfs-mmap-corruption.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.4.20-nfs-mmap-corruption.patch"

--- linux-2.4.20/fs/nfs/write.c.orig	2002-11-28 18:53:15.000000000 -0500
+++ linux-2.4.20/fs/nfs/write.c	2003-02-20 08:17:48.000000000 -0500
@@ -242,7 +242,7 @@
 	struct inode *inode = page->mapping->host;
 	unsigned long end_index;
 	unsigned offset = PAGE_CACHE_SIZE;
-	int err;
+	int err, is_sync;
 
 	end_index = inode->i_size >> PAGE_CACHE_SHIFT;
 
@@ -261,7 +261,8 @@
 		goto out;
 do_it:
 	lock_kernel();
-	if (NFS_SERVER(inode)->wsize >= PAGE_CACHE_SIZE && !IS_SYNC(inode)) {
+	is_sync = (IS_SYNC(inode) || NFS_FLUSH(inode));
+	if (NFS_SERVER(inode)->wsize >= PAGE_CACHE_SIZE && !is_sync) {
 		err = nfs_writepage_async(NULL, inode, page, 0, offset);
 		if (err >= 0)
 			err = 0;
@@ -749,15 +750,18 @@
 static void
 nfs_strategy(struct inode *inode)
 {
-	unsigned int	dirty, wpages;
+	unsigned int	dirty, wpages, flush;
 
 	dirty  = inode->u.nfs_i.ndirty;
 	wpages = NFS_SERVER(inode)->wpages;
+	flush = NFS_FLUSH(inode);
 #ifdef CONFIG_NFS_V3
 	if (NFS_PROTO(inode)->version == 2) {
 		if (dirty >= NFS_STRATEGY_PAGES * wpages)
 			nfs_flush_file(inode, NULL, 0, 0, 0);
-	} else if (dirty >= wpages)
+	} else if (dirty >= wpages) {
+		nfs_flush_file(inode, NULL, 0, 0, 0);
+	} else if (dirty && flush)
 		nfs_flush_file(inode, NULL, 0, 0, 0);
 #else
 	if (dirty >= NFS_STRATEGY_PAGES * wpages)
--- linux-2.4.20/fs/nfs/inode.c.orig	2003-02-18 13:31:44.000000000 -0500
+++ linux-2.4.20/fs/nfs/inode.c	2003-02-20 07:15:50.000000000 -0500
@@ -746,12 +746,37 @@
 	goto out;
 }
 
+#define IS_TRUNC_DOWN(_inode, _attr) \
+	(_attr->ia_valid & ATTR_SIZE  && _attr->ia_size < _inode->i_size)
+static inline void
+nfs_inode_flush_on(struct inode *inode)
+{
+	atomic_inc(&(NFS_I(inode)->flushers));
+	lock_kernel(); 
+	NFS_FLAGS(inode) |= NFS_INO_FLUSH;
+	unlock_kernel();
+	return;
+}
+
+static inline void
+nfs_inode_flush_off(struct inode *inode)
+{
+	atomic_dec(&(NFS_I(inode)->flushers));
+	if (atomic_read(&(NFS_I(inode)->flushers)) == 0) {
+		lock_kernel();
+		NFS_FLAGS(inode) &= ~NFS_INO_FLUSH;
+		wake_up(&inode->i_wait);
+		unlock_kernel();
+	}
+	return;
+}
+
 int
 nfs_notify_change(struct dentry *dentry, struct iattr *attr)
 {
 	struct inode *inode = dentry->d_inode;
 	struct nfs_fattr fattr;
-	int error;
+	int error, flusher=0;
 
 	/*
 	 * Make sure the inode is up-to-date.
@@ -767,11 +792,30 @@
 	if (!S_ISREG(inode->i_mode))
 		attr->ia_valid &= ~ATTR_SIZE;
 
-	filemap_fdatasync(inode->i_mapping);
-	error = nfs_wb_all(inode);
-	filemap_fdatawait(inode->i_mapping);
-	if (error)
-		goto out;
+	/*
+	 * If the file is going to be truncated down
+	 * make sure all of the mmapped pages get flushed
+	 * by telling nfs_writepage to flush them synchronously.
+	 * If they are flushed asynchronously and the file size
+	 * changes (again) before they are flushed, data corruption
+	 * will occur.
+	 * XXX: It would be nice if there was an filemap_ api
+	 * that would tell how many (if any) dirty mmapped pages there
+	 * are. That way I would have to take the lock_kernel() when
+	 * its not necessary.
+	 */
+	if (IS_TRUNC_DOWN(inode, attr)) { 
+		flusher = 1;
+		nfs_inode_flush_on(inode);
+	}
+
+	do {
+		filemap_fdatasync(inode->i_mapping);
+		error = nfs_wb_all(inode);
+		filemap_fdatawait(inode->i_mapping);
+		if (error)
+			goto out;
+	} while (flusher && NFS_I(inode)->npages);
 
 	error = NFS_PROTO(inode)->setattr(inode, &fattr, attr);
 	if (error)
@@ -801,6 +845,9 @@
 	NFS_CACHEINV(inode);
 	error = nfs_refresh_inode(inode, &fattr);
 out:
+	if (flusher) {
+		nfs_inode_flush_off(inode);
+	}
 	return error;
 }
 
--- linux-2.4.20/include/linux/nfs_fs_i.h.orig	2003-02-19 08:22:20.000000000 -0500
+++ linux-2.4.20/include/linux/nfs_fs_i.h	2003-02-20 07:36:01.000000000 -0500
@@ -75,6 +75,9 @@
 
 	/* Credentials for shared mmap */
 	struct rpc_cred		*mm_cred;
+
+	/* The number of threads flushing out dirty mmaps pages */
+	atomic_t    flushers;
 };
 
 /*
--- linux-2.4.20/include/linux/nfs_fs.h.orig	2003-02-19 08:22:21.000000000 -0500
+++ linux-2.4.20/include/linux/nfs_fs.h	2003-02-20 07:36:02.000000000 -0500
@@ -99,6 +99,7 @@
 #define NFS_FLAGS(inode)		((inode)->u.nfs_i.flags)
 #define NFS_REVALIDATING(inode)		(NFS_FLAGS(inode) & NFS_INO_REVALIDATING)
 #define NFS_STALE(inode)		(NFS_FLAGS(inode) & NFS_INO_STALE)
+#define NFS_FLUSH(inode)		(NFS_FLAGS(inode) & NFS_INO_FLUSH)
 
 #define NFS_FILEID(inode)		((inode)->u.nfs_i.fileid)
 

--------------010001080807020904040708--

