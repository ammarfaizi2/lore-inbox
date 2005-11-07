Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965314AbVKGTL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965314AbVKGTL1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 14:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965315AbVKGTL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 14:11:27 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:8203 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S965314AbVKGTL0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 14:11:26 -0500
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Trond.Myklebust@netapp.com, ericvh@gmail.com, sfrench@samba.org,
       shaggy@austin.ibm.com, nathans@sgi.com
Subject: [PATCH -mm] Fix and add EXPORT_SYMBOL(filemap_write_and_wait)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 08 Nov 2005 04:10:37 +0900
Message-ID: <87hdaos28i.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch add EXPORT_SYMBOL(filemap_write_and_wait) and use it.

See mm/filemap.c:

And changes the filemap_write_and_wait() and filemap_write_and_wait_range().

Current filemap_write_and_wait() doesn't wait if filemap_fdatawrite()
returns error.  However, even if filemap_fdatawrite() returned an
error, it may have submitted the partially data pages to the device.
(e.g. in the case of -ENOSPC)

<quotation>
Andrew Morton writes,

If filemap_fdatawrite() returns an error, this might be due to some
I/O problem: dead disk, unplugged cable, etc.  Given the generally
crappy quality of the kernel's handling of such exceptions, there's a
good chance that the filemap_fdatawait() will get stuck in D state
forever.
</quotation>

So, this patch doesn't wait if filemap_fdatawrite() returns the -EIO.


Trond, could you please review the nfs part?  Especially I'm not sure,
nfs must use the "filemap_fdatawrite(inode->i_mapping) == 0", or not.

Thanks.

---

 fs/9p/vfs_dir.c                |    3 +--
 fs/9p/vfs_file.c               |    3 +--
 fs/buffer.c                    |   10 ++--------
 fs/cifs/file.c                 |    6 ++----
 fs/cifs/inode.c                |    3 +--
 fs/jfs/jfs_dmap.c              |    3 +--
 fs/jfs/jfs_imap.c              |    6 ++----
 fs/jfs/jfs_txnmgr.c            |    6 ++----
 fs/jfs/jfs_umount.c            |    6 ++----
 fs/jfs/resize.c                |    3 +--
 fs/jfs/super.c                 |    3 +--
 fs/nfs/inode.c                 |    6 ++----
 fs/smbfs/file.c                |    3 +--
 fs/smbfs/inode.c               |    3 +--
 fs/xfs/linux-2.6/xfs_fs_subr.c |    3 +--
 mm/filemap.c                   |   40 +++++++++++++++++++++++++++-------------
 16 files changed, 48 insertions(+), 59 deletions(-)

diff -puN fs/9p/vfs_dir.c~export-filemap_write_and_wait fs/9p/vfs_dir.c
--- linux-2.6.14-mm/fs/9p/vfs_dir.c~export-filemap_write_and_wait	2005-11-08 00:15:54.000000000 +0900
+++ linux-2.6.14-mm-hirofumi/fs/9p/vfs_dir.c	2005-11-08 00:15:55.000000000 +0900
@@ -193,8 +193,7 @@ int v9fs_dir_release(struct inode *inode
 		fid->fid);
 	fidnum = fid->fid;
 
-	filemap_fdatawrite(inode->i_mapping);
-	filemap_fdatawait(inode->i_mapping);
+	filemap_write_and_wait(inode->i_mapping);
 
 	if (fidnum >= 0) {
 		dprintk(DEBUG_VFS, "fidopen: %d v9f->fid: %d\n", fid->fidopen,
diff -puN fs/9p/vfs_file.c~export-filemap_write_and_wait fs/9p/vfs_file.c
--- linux-2.6.14-mm/fs/9p/vfs_file.c~export-filemap_write_and_wait	2005-11-08 00:15:54.000000000 +0900
+++ linux-2.6.14-mm-hirofumi/fs/9p/vfs_file.c	2005-11-08 00:15:55.000000000 +0900
@@ -165,8 +165,7 @@ static int v9fs_file_lock(struct file *f
 		return -ENOLCK;
 
 	if ((IS_SETLK(cmd) || IS_SETLKW(cmd)) && fl->fl_type != F_UNLCK) {
-		filemap_fdatawrite(inode->i_mapping);
-		filemap_fdatawait(inode->i_mapping);
+		filemap_write_and_wait(inode->i_mapping);
 		invalidate_inode_pages(&inode->i_data);
 	}
 
diff -puN fs/buffer.c~export-filemap_write_and_wait fs/buffer.c
--- linux-2.6.14-mm/fs/buffer.c~export-filemap_write_and_wait	2005-11-08 00:15:54.000000000 +0900
+++ linux-2.6.14-mm-hirofumi/fs/buffer.c	2005-11-08 00:15:55.000000000 +0900
@@ -153,14 +153,8 @@ int sync_blockdev(struct block_device *b
 {
 	int ret = 0;
 
-	if (bdev) {
-		int err;
-
-		ret = filemap_fdatawrite(bdev->bd_inode->i_mapping);
-		err = filemap_fdatawait(bdev->bd_inode->i_mapping);
-		if (!ret)
-			ret = err;
-	}
+	if (bdev)
+		ret = filemap_write_and_wait(bdev->bd_inode->i_mapping);
 	return ret;
 }
 EXPORT_SYMBOL(sync_blockdev);
diff -puN fs/cifs/file.c~export-filemap_write_and_wait fs/cifs/file.c
--- linux-2.6.14-mm/fs/cifs/file.c~export-filemap_write_and_wait	2005-11-08 00:15:54.000000000 +0900
+++ linux-2.6.14-mm-hirofumi/fs/cifs/file.c	2005-11-08 00:15:55.000000000 +0900
@@ -127,8 +127,7 @@ static inline int cifs_open_inode_helper
 		if (file->f_dentry->d_inode->i_mapping) {
 		/* BB no need to lock inode until after invalidate
 		   since namei code should already have it locked? */
-			filemap_fdatawrite(file->f_dentry->d_inode->i_mapping);
-			filemap_fdatawait(file->f_dentry->d_inode->i_mapping);
+			filemap_write_and_wait(file->f_dentry->d_inode->i_mapping);
 		}
 		cFYI(1, ("invalidating remote inode since open detected it "
 			 "changed"));
@@ -419,8 +418,7 @@ static int cifs_reopen_file(struct inode
 		pCifsInode = CIFS_I(inode);
 		if (pCifsInode) {
 			if (can_flush) {
-				filemap_fdatawrite(inode->i_mapping);
-				filemap_fdatawait(inode->i_mapping);
+				filemap_write_and_wait(inode->i_mapping);
 			/* temporarily disable caching while we
 			   go to server to get inode info */
 				pCifsInode->clientCanCacheAll = FALSE;
diff -puN fs/cifs/inode.c~export-filemap_write_and_wait fs/cifs/inode.c
--- linux-2.6.14-mm/fs/cifs/inode.c~export-filemap_write_and_wait	2005-11-08 00:15:54.000000000 +0900
+++ linux-2.6.14-mm-hirofumi/fs/cifs/inode.c	2005-11-08 00:15:55.000000000 +0900
@@ -987,8 +987,7 @@ int cifs_setattr(struct dentry *direntry
 	/* BB check if we need to refresh inode from server now ? BB */
 
 	/* need to flush data before changing file size on server */
-	filemap_fdatawrite(direntry->d_inode->i_mapping);
-	filemap_fdatawait(direntry->d_inode->i_mapping);
+	filemap_write_and_wait(direntry->d_inode->i_mapping);
 
 	if (attrs->ia_valid & ATTR_SIZE) {
 		/* To avoid spurious oplock breaks from server, in the case of
diff -puN fs/jfs/jfs_dmap.c~export-filemap_write_and_wait fs/jfs/jfs_dmap.c
--- linux-2.6.14-mm/fs/jfs/jfs_dmap.c~export-filemap_write_and_wait	2005-11-08 00:15:54.000000000 +0900
+++ linux-2.6.14-mm-hirofumi/fs/jfs/jfs_dmap.c	2005-11-08 00:15:55.000000000 +0900
@@ -302,8 +302,7 @@ int dbSync(struct inode *ipbmap)
 	/*
 	 * write out dirty pages of bmap
 	 */
-	filemap_fdatawrite(ipbmap->i_mapping);
-	filemap_fdatawait(ipbmap->i_mapping);
+	filemap_write_and_wait(ipbmap->i_mapping);
 
 	diWriteSpecial(ipbmap, 0);
 
diff -puN fs/jfs/jfs_imap.c~export-filemap_write_and_wait fs/jfs/jfs_imap.c
--- linux-2.6.14-mm/fs/jfs/jfs_imap.c~export-filemap_write_and_wait	2005-11-08 00:15:54.000000000 +0900
+++ linux-2.6.14-mm-hirofumi/fs/jfs/jfs_imap.c	2005-11-08 00:15:55.000000000 +0900
@@ -265,8 +265,7 @@ int diSync(struct inode *ipimap)
 	/*
 	 * write out dirty pages of imap
 	 */
-	filemap_fdatawrite(ipimap->i_mapping);
-	filemap_fdatawait(ipimap->i_mapping);
+	filemap_write_and_wait(ipimap->i_mapping);
 
 	diWriteSpecial(ipimap, 0);
 
@@ -565,8 +564,7 @@ void diFreeSpecial(struct inode *ip)
 		jfs_err("diFreeSpecial called with NULL ip!");
 		return;
 	}
-	filemap_fdatawrite(ip->i_mapping);
-	filemap_fdatawait(ip->i_mapping);
+	filemap_write_and_wait(ip->i_mapping);
 	truncate_inode_pages(ip->i_mapping, 0);
 	iput(ip);
 }
diff -puN fs/jfs/jfs_txnmgr.c~export-filemap_write_and_wait fs/jfs/jfs_txnmgr.c
--- linux-2.6.14-mm/fs/jfs/jfs_txnmgr.c~export-filemap_write_and_wait	2005-11-08 00:15:54.000000000 +0900
+++ linux-2.6.14-mm-hirofumi/fs/jfs/jfs_txnmgr.c	2005-11-08 00:15:55.000000000 +0900
@@ -1231,10 +1231,8 @@ int txCommit(tid_t tid,		/* transaction 
 		 * when we don't need to worry about it at all.
 		 *
 		 * if ((!S_ISDIR(ip->i_mode))
-		 *    && (tblk->flag & COMMIT_DELETE) == 0) {
-		 *	filemap_fdatawrite(ip->i_mapping);
-		 *	filemap_fdatawait(ip->i_mapping);
-		 * }
+		 *    && (tblk->flag & COMMIT_DELETE) == 0)
+		 *	filemap_write_and_wait(ip->i_mapping);
 		 */
 
 		/*
diff -puN fs/jfs/jfs_umount.c~export-filemap_write_and_wait fs/jfs/jfs_umount.c
--- linux-2.6.14-mm/fs/jfs/jfs_umount.c~export-filemap_write_and_wait	2005-11-08 00:15:54.000000000 +0900
+++ linux-2.6.14-mm-hirofumi/fs/jfs/jfs_umount.c	2005-11-08 00:15:55.000000000 +0900
@@ -108,8 +108,7 @@ int jfs_umount(struct super_block *sb)
 	 * Make sure all metadata makes it to disk before we mark
 	 * the superblock as clean
 	 */
-	filemap_fdatawrite(sbi->direct_inode->i_mapping);
-	filemap_fdatawait(sbi->direct_inode->i_mapping);
+	filemap_write_and_wait(sbi->direct_inode->i_mapping);
 
 	/*
 	 * ensure all file system file pages are propagated to their
@@ -161,8 +160,7 @@ int jfs_umount_rw(struct super_block *sb
 	 * mark the superblock clean before everything is flushed to
 	 * disk.
 	 */
-	filemap_fdatawrite(sbi->direct_inode->i_mapping);
-	filemap_fdatawait(sbi->direct_inode->i_mapping);
+	filemap_write_and_wait(sbi->direct_inode->i_mapping);
 
 	updateSuper(sb, FM_CLEAN);
 
diff -puN fs/jfs/resize.c~export-filemap_write_and_wait fs/jfs/resize.c
--- linux-2.6.14-mm/fs/jfs/resize.c~export-filemap_write_and_wait	2005-11-08 00:15:54.000000000 +0900
+++ linux-2.6.14-mm-hirofumi/fs/jfs/resize.c	2005-11-08 00:15:55.000000000 +0900
@@ -376,8 +376,7 @@ int jfs_extendfs(struct super_block *sb,
 	 * by txCommit();
 	 */
 	filemap_fdatawait(ipbmap->i_mapping);
-	filemap_fdatawrite(ipbmap->i_mapping);
-	filemap_fdatawait(ipbmap->i_mapping);
+	filemap_write_and_wait(ipbmap->i_mapping);
 	diWriteSpecial(ipbmap, 0);
 
 	newPage = nPages;	/* first new page number */
diff -puN fs/jfs/super.c~export-filemap_write_and_wait fs/jfs/super.c
--- linux-2.6.14-mm/fs/jfs/super.c~export-filemap_write_and_wait	2005-11-08 00:15:54.000000000 +0900
+++ linux-2.6.14-mm-hirofumi/fs/jfs/super.c	2005-11-08 00:15:55.000000000 +0900
@@ -502,8 +502,7 @@ out_no_rw:
 		jfs_err("jfs_umount failed with return code %d", rc);
 	}
 out_mount_failed:
-	filemap_fdatawrite(sbi->direct_inode->i_mapping);
-	filemap_fdatawait(sbi->direct_inode->i_mapping);
+	filemap_write_and_wait(sbi->direct_inode->i_mapping);
 	truncate_inode_pages(sbi->direct_inode->i_mapping, 0);
 	make_bad_inode(sbi->direct_inode);
 	iput(sbi->direct_inode);
diff -puN fs/nfs/inode.c~export-filemap_write_and_wait fs/nfs/inode.c
--- linux-2.6.14-mm/fs/nfs/inode.c~export-filemap_write_and_wait	2005-11-08 00:15:54.000000000 +0900
+++ linux-2.6.14-mm-hirofumi/fs/nfs/inode.c	2005-11-08 00:15:55.000000000 +0900
@@ -850,8 +850,7 @@ nfs_setattr(struct dentry *dentry, struc
 	nfs_begin_data_update(inode);
 	/* Write all dirty data if we're changing file permissions or size */
 	if ((attr->ia_valid & (ATTR_MODE|ATTR_UID|ATTR_GID|ATTR_SIZE)) != 0) {
-		if (filemap_fdatawrite(inode->i_mapping) == 0)
-			filemap_fdatawait(inode->i_mapping);
+		filemap_write_and_wait(inode->i_mapping);
 		nfs_wb_all(inode);
 	}
 	/*
@@ -1194,8 +1193,7 @@ void nfs_revalidate_mapping(struct inode
 
 	if (nfsi->cache_validity & NFS_INO_INVALID_DATA) {
 		if (S_ISREG(inode->i_mode)) {
-			if (filemap_fdatawrite(mapping) == 0)
-				filemap_fdatawait(mapping);
+			filemap_write_and_wait(mapping);
 			nfs_wb_all(inode);
 		}
 		invalidate_inode_pages2(mapping);
diff -puN fs/smbfs/file.c~export-filemap_write_and_wait fs/smbfs/file.c
--- linux-2.6.14-mm/fs/smbfs/file.c~export-filemap_write_and_wait	2005-11-08 00:15:54.000000000 +0900
+++ linux-2.6.14-mm-hirofumi/fs/smbfs/file.c	2005-11-08 00:15:55.000000000 +0900
@@ -374,8 +374,7 @@ smb_file_release(struct inode *inode, st
 		/* We must flush any dirty pages now as we won't be able to
 		   write anything after close. mmap can trigger this.
 		   "openers" should perhaps include mmap'ers ... */
-		filemap_fdatawrite(inode->i_mapping);
-		filemap_fdatawait(inode->i_mapping);
+		filemap_write_and_wait(inode->i_mapping);
 		smb_close(inode);
 	}
 	unlock_kernel();
diff -puN fs/smbfs/inode.c~export-filemap_write_and_wait fs/smbfs/inode.c
--- linux-2.6.14-mm/fs/smbfs/inode.c~export-filemap_write_and_wait	2005-11-08 00:15:54.000000000 +0900
+++ linux-2.6.14-mm-hirofumi/fs/smbfs/inode.c	2005-11-08 00:15:55.000000000 +0900
@@ -697,8 +697,7 @@ smb_notify_change(struct dentry *dentry,
 			DENTRY_PATH(dentry),
 			(long) inode->i_size, (long) attr->ia_size);
 
-		filemap_fdatawrite(inode->i_mapping);
-		filemap_fdatawait(inode->i_mapping);
+		filemap_write_and_wait(inode->i_mapping);
 
 		error = smb_open(dentry, O_WRONLY);
 		if (error)
diff -puN fs/xfs/linux-2.6/xfs_fs_subr.c~export-filemap_write_and_wait fs/xfs/linux-2.6/xfs_fs_subr.c
--- linux-2.6.14-mm/fs/xfs/linux-2.6/xfs_fs_subr.c~export-filemap_write_and_wait	2005-11-08 00:15:54.000000000 +0900
+++ linux-2.6.14-mm-hirofumi/fs/xfs/linux-2.6/xfs_fs_subr.c	2005-11-08 00:15:55.000000000 +0900
@@ -79,8 +79,7 @@ fs_flushinval_pages(
 	struct inode	*ip = LINVFS_GET_IP(vp);
 
 	if (VN_CACHED(vp)) {
-		filemap_fdatawrite(ip->i_mapping);
-		filemap_fdatawait(ip->i_mapping);
+		filemap_write_and_wait(ip->i_mapping);
 
 		truncate_inode_pages(ip->i_mapping, first);
 	}
diff -puN mm/filemap.c~export-filemap_write_and_wait mm/filemap.c
--- linux-2.6.14-mm/mm/filemap.c~export-filemap_write_and_wait	2005-11-08 00:15:54.000000000 +0900
+++ linux-2.6.14-mm-hirofumi/mm/filemap.c	2005-11-08 00:15:55.000000000 +0900
@@ -345,30 +345,44 @@ EXPORT_SYMBOL(filemap_fdatawait);
 
 int filemap_write_and_wait(struct address_space *mapping)
 {
-	int retval = 0;
+	int err = 0;
 
 	if (mapping->nrpages) {
-		retval = filemap_fdatawrite(mapping);
-		if (retval == 0)
-			retval = filemap_fdatawait(mapping);
+		err = filemap_fdatawrite(mapping);
+		/*
+		 * Even if the above returned error, the pages may be
+		 * written partially (e.g. -ENOSPC), so we wait for it.
+		 * But the -EIO is special case, it may indicate the worst
+		 * thing (e.g. bug) happened, so we avoid waiting for it.
+		 */
+		if (err != -EIO) {
+			int err2 = filemap_fdatawait(mapping);
+			if (!err)
+				err = err2;
+		}
 	}
-	return retval;
+	return err;
 }
+EXPORT_SYMBOL(filemap_write_and_wait);
 
 int filemap_write_and_wait_range(struct address_space *mapping,
 				 loff_t lstart, loff_t lend)
 {
-	int retval = 0;
+	int err = 0;
 
 	if (mapping->nrpages) {
-		retval = __filemap_fdatawrite_range(mapping, lstart, lend,
-						    WB_SYNC_ALL);
-		if (retval == 0)
-			retval = wait_on_page_writeback_range(mapping,
-						    lstart >> PAGE_CACHE_SHIFT,
-						    lend >> PAGE_CACHE_SHIFT);
+		err = __filemap_fdatawrite_range(mapping, lstart, lend,
+						 WB_SYNC_ALL);
+		/* See comment of filemap_write_and_wait() */
+		if (err != -EIO) {
+			int err2 = wait_on_page_writeback_range(mapping,
+						lstart >> PAGE_CACHE_SHIFT,
+						lend >> PAGE_CACHE_SHIFT);
+			if (!err)
+				err = err2;
+		}
 	}
-	return retval;
+	return err;
 }
 
 /*
_
