Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbVJVP00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbVJVP00 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 11:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbVJVP00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 11:26:26 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:42766 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S1751325AbVJVP0Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 11:26:25 -0400
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>
Subject: [PATCH] Fix and add EXPORT_SYMBOL(filemap_write_and_wait)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 23 Oct 2005 00:26:00 +0900
Message-ID: <87ek6dtvxz.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add EXPORT_SYMBOL(filemap_write_and_wait) and use it.

See mm/filemap.c:

And changes the filemap_write_and_wait() and filemap_write_and_wait_range().

Current filemap_write_and_wait() doesn't wait if filemap_fdatawrite()
returns error. However, even if filemap_fdatawrite() returns error, it
may be submiting data pages . (e.g. in the case of -ENOSPC)

However, even if filemap_fdatawrite() returned an error, it may have
submitted the partially data pages to the device.

I think we should wait those submitted data pages.

Please apply.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>



Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/9p/vfs_dir.c                |    3 +--
 fs/9p/vfs_file.c               |    3 +--
 fs/cifs/file.c                 |    6 ++----
 fs/cifs/inode.c                |    3 +--
 fs/jfs/jfs_dmap.c              |    3 +--
 fs/jfs/jfs_imap.c              |    6 ++----
 fs/jfs/jfs_umount.c            |    6 ++----
 fs/jfs/resize.c                |    3 +--
 fs/jfs/super.c                 |    3 +--
 fs/nfs/inode.c                 |    6 ++----
 fs/smbfs/file.c                |    3 +--
 fs/smbfs/inode.c               |    3 +--
 fs/xfs/linux-2.6/xfs_fs_subr.c |    9 +++------
 mm/filemap.c                   |   28 +++++++++++++++-------------
 14 files changed, 34 insertions(+), 51 deletions(-)

diff -puN fs/9p/vfs_dir.c~export-filemap_write_and_wait fs/9p/vfs_dir.c
--- linux-2.6.14-rc4/fs/9p/vfs_dir.c~export-filemap_write_and_wait	2005-10-22 21:18:46.000000000 +0900
+++ linux-2.6.14-rc4-hirofumi/fs/9p/vfs_dir.c	2005-10-22 21:18:46.000000000 +0900
@@ -193,8 +193,7 @@ int v9fs_dir_release(struct inode *inode
 		fid->fid);
 	fidnum = fid->fid;
 
-	filemap_fdatawrite(inode->i_mapping);
-	filemap_fdatawait(inode->i_mapping);
+	filemap_write_and_wait(inode->i_mapping);
 
 	if (fidnum >= 0) {
 		dprintk(DEBUG_VFS, "fidopen: %d v9f->fid: %d\n", fid->fidopen,
diff -puN fs/9p/vfs_file.c~export-filemap_write_and_wait fs/9p/vfs_file.c
--- linux-2.6.14-rc4/fs/9p/vfs_file.c~export-filemap_write_and_wait	2005-10-22 21:18:46.000000000 +0900
+++ linux-2.6.14-rc4-hirofumi/fs/9p/vfs_file.c	2005-10-22 21:18:46.000000000 +0900
@@ -166,8 +166,7 @@ static int v9fs_file_lock(struct file *f
 		return -ENOLCK;
 
 	if ((IS_SETLK(cmd) || IS_SETLKW(cmd)) && fl->fl_type != F_UNLCK) {
-		filemap_fdatawrite(inode->i_mapping);
-		filemap_fdatawait(inode->i_mapping);
+		filemap_write_and_wait(inode->i_mapping);
 		invalidate_inode_pages(&inode->i_data);
 	}
 
diff -puN fs/cifs/file.c~export-filemap_write_and_wait fs/cifs/file.c
--- linux-2.6.14-rc4/fs/cifs/file.c~export-filemap_write_and_wait	2005-10-22 21:18:46.000000000 +0900
+++ linux-2.6.14-rc4-hirofumi/fs/cifs/file.c	2005-10-22 21:18:46.000000000 +0900
@@ -118,8 +118,7 @@ static inline int cifs_open_inode_helper
 		if (file->f_dentry->d_inode->i_mapping) {
 		/* BB no need to lock inode until after invalidate
 		   since namei code should already have it locked? */
-			filemap_fdatawrite(file->f_dentry->d_inode->i_mapping);
-			filemap_fdatawait(file->f_dentry->d_inode->i_mapping);
+			filemap_write_and_wait(file->f_dentry->d_inode->i_mapping);
 		}
 		cFYI(1, ("invalidating remote inode since open detected it "
 			 "changed"));
@@ -403,8 +402,7 @@ static int cifs_reopen_file(struct inode
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
--- linux-2.6.14-rc4/fs/cifs/inode.c~export-filemap_write_and_wait	2005-10-22 21:18:46.000000000 +0900
+++ linux-2.6.14-rc4-hirofumi/fs/cifs/inode.c	2005-10-22 21:18:46.000000000 +0900
@@ -957,8 +957,7 @@ int cifs_setattr(struct dentry *direntry
 	/* BB check if we need to refresh inode from server now ? BB */
 
 	/* need to flush data before changing file size on server */
-	filemap_fdatawrite(direntry->d_inode->i_mapping);
-	filemap_fdatawait(direntry->d_inode->i_mapping);
+	filemap_write_and_wait(direntry->d_inode->i_mapping);
 
 	if (attrs->ia_valid & ATTR_SIZE) {
 		read_lock(&GlobalSMBSeslock);
diff -puN fs/jfs/jfs_dmap.c~export-filemap_write_and_wait fs/jfs/jfs_dmap.c
--- linux-2.6.14-rc4/fs/jfs/jfs_dmap.c~export-filemap_write_and_wait	2005-10-22 21:18:46.000000000 +0900
+++ linux-2.6.14-rc4-hirofumi/fs/jfs/jfs_dmap.c	2005-10-22 21:18:46.000000000 +0900
@@ -302,8 +302,7 @@ int dbSync(struct inode *ipbmap)
 	/*
 	 * write out dirty pages of bmap
 	 */
-	filemap_fdatawrite(ipbmap->i_mapping);
-	filemap_fdatawait(ipbmap->i_mapping);
+	filemap_write_and_wait(ipbmap->i_mapping);
 
 	ipbmap->i_state |= I_DIRTY;
 	diWriteSpecial(ipbmap, 0);
diff -puN fs/jfs/jfs_imap.c~export-filemap_write_and_wait fs/jfs/jfs_imap.c
--- linux-2.6.14-rc4/fs/jfs/jfs_imap.c~export-filemap_write_and_wait	2005-10-22 21:18:46.000000000 +0900
+++ linux-2.6.14-rc4-hirofumi/fs/jfs/jfs_imap.c	2005-10-22 21:18:46.000000000 +0900
@@ -259,8 +259,7 @@ int diSync(struct inode *ipimap)
 	/*
 	 * write out dirty pages of imap
 	 */
-	filemap_fdatawrite(ipimap->i_mapping);
-	filemap_fdatawait(ipimap->i_mapping);
+	filemap_write_and_wait(ipimap->i_mapping);
 
 	diWriteSpecial(ipimap, 0);
 
@@ -559,8 +558,7 @@ void diFreeSpecial(struct inode *ip)
 		jfs_err("diFreeSpecial called with NULL ip!");
 		return;
 	}
-	filemap_fdatawrite(ip->i_mapping);
-	filemap_fdatawait(ip->i_mapping);
+	filemap_write_and_wait(ip->i_mapping);
 	truncate_inode_pages(ip->i_mapping, 0);
 	iput(ip);
 }
diff -puN fs/jfs/jfs_umount.c~export-filemap_write_and_wait fs/jfs/jfs_umount.c
--- linux-2.6.14-rc4/fs/jfs/jfs_umount.c~export-filemap_write_and_wait	2005-10-22 21:18:46.000000000 +0900
+++ linux-2.6.14-rc4-hirofumi/fs/jfs/jfs_umount.c	2005-10-22 21:18:46.000000000 +0900
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
--- linux-2.6.14-rc4/fs/jfs/resize.c~export-filemap_write_and_wait	2005-10-22 21:18:46.000000000 +0900
+++ linux-2.6.14-rc4-hirofumi/fs/jfs/resize.c	2005-10-22 21:18:46.000000000 +0900
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
--- linux-2.6.14-rc4/fs/jfs/super.c~export-filemap_write_and_wait	2005-10-22 21:18:46.000000000 +0900
+++ linux-2.6.14-rc4-hirofumi/fs/jfs/super.c	2005-10-22 21:18:46.000000000 +0900
@@ -501,8 +501,7 @@ out_no_rw:
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
--- linux-2.6.14-rc4/fs/nfs/inode.c~export-filemap_write_and_wait	2005-10-22 21:18:46.000000000 +0900
+++ linux-2.6.14-rc4-hirofumi/fs/nfs/inode.c	2005-10-22 21:18:46.000000000 +0900
@@ -817,8 +817,7 @@ nfs_setattr(struct dentry *dentry, struc
 	nfs_begin_data_update(inode);
 	/* Write all dirty data if we're changing file permissions or size */
 	if ((attr->ia_valid & (ATTR_MODE|ATTR_UID|ATTR_GID|ATTR_SIZE)) != 0) {
-		if (filemap_fdatawrite(inode->i_mapping) == 0)
-			filemap_fdatawait(inode->i_mapping);
+		filemap_write_and_wait(inode->i_mapping);
 		nfs_wb_all(inode);
 	}
 	error = NFS_PROTO(inode)->setattr(dentry, &fattr, attr);
@@ -1154,8 +1153,7 @@ void nfs_revalidate_mapping(struct inode
 
 	if (nfsi->cache_validity & NFS_INO_INVALID_DATA) {
 		if (S_ISREG(inode->i_mode)) {
-			if (filemap_fdatawrite(mapping) == 0)
-				filemap_fdatawait(mapping);
+			filemap_write_and_wait(mapping);
 			nfs_wb_all(inode);
 		}
 		invalidate_inode_pages2(mapping);
diff -puN fs/smbfs/file.c~export-filemap_write_and_wait fs/smbfs/file.c
--- linux-2.6.14-rc4/fs/smbfs/file.c~export-filemap_write_and_wait	2005-10-22 21:18:46.000000000 +0900
+++ linux-2.6.14-rc4-hirofumi/fs/smbfs/file.c	2005-10-22 21:18:46.000000000 +0900
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
--- linux-2.6.14-rc4/fs/smbfs/inode.c~export-filemap_write_and_wait	2005-10-22 21:18:46.000000000 +0900
+++ linux-2.6.14-rc4-hirofumi/fs/smbfs/inode.c	2005-10-22 21:18:46.000000000 +0900
@@ -697,8 +697,7 @@ smb_notify_change(struct dentry *dentry,
 			DENTRY_PATH(dentry),
 			(long) inode->i_size, (long) attr->ia_size);
 
-		filemap_fdatawrite(inode->i_mapping);
-		filemap_fdatawait(inode->i_mapping);
+		filemap_write_and_wait(inode->i_mapping);
 
 		error = smb_open(dentry, O_WRONLY);
 		if (error)
diff -puN fs/xfs/linux-2.6/xfs_fs_subr.c~export-filemap_write_and_wait fs/xfs/linux-2.6/xfs_fs_subr.c
--- linux-2.6.14-rc4/fs/xfs/linux-2.6/xfs_fs_subr.c~export-filemap_write_and_wait	2005-10-22 21:18:46.000000000 +0900
+++ linux-2.6.14-rc4-hirofumi/fs/xfs/linux-2.6/xfs_fs_subr.c	2005-10-22 21:18:46.000000000 +0900
@@ -93,8 +93,7 @@ fs_flushinval_pages(
 	struct inode	*ip = LINVFS_GET_IP(vp);
 
 	if (VN_CACHED(vp)) {
-		filemap_fdatawrite(ip->i_mapping);
-		filemap_fdatawait(ip->i_mapping);
+		filemap_write_and_wait(ip->i_mapping);
 
 		truncate_inode_pages(ip->i_mapping, first);
 	}
@@ -115,10 +114,8 @@ fs_flush_pages(
 	vnode_t		*vp = BHV_TO_VNODE(bdp);
 	struct inode	*ip = LINVFS_GET_IP(vp);
 
-	if (VN_CACHED(vp)) {
-		filemap_fdatawrite(ip->i_mapping);
-		filemap_fdatawait(ip->i_mapping);
-	}
+	if (VN_CACHED(vp))
+		filemap_write_and_wait(ip->i_mapping);
 
 	return 0;
 }
diff -puN mm/filemap.c~export-filemap_write_and_wait mm/filemap.c
--- linux-2.6.14-rc4/mm/filemap.c~export-filemap_write_and_wait	2005-10-22 21:18:46.000000000 +0900
+++ linux-2.6.14-rc4-hirofumi/mm/filemap.c	2005-10-22 21:17:26.000000000 +0900
@@ -343,30 +343,32 @@ EXPORT_SYMBOL(filemap_fdatawait);
 
 int filemap_write_and_wait(struct address_space *mapping)
 {
-	int retval = 0;
+	int err = 0, err2;
 
 	if (mapping->nrpages) {
-		retval = filemap_fdatawrite(mapping);
-		if (retval == 0)
-			retval = filemap_fdatawait(mapping);
+		err = filemap_fdatawrite(mapping);
+		err2 = filemap_fdatawait(mapping);
+		if (!err)
+			err = err2;
 	}
-	return retval;
+	return err;
 }
 
 int filemap_write_and_wait_range(struct address_space *mapping,
 				 loff_t lstart, loff_t lend)
 {
-	int retval = 0;
+	int err = 0, err2;
 
 	if (mapping->nrpages) {
-		retval = __filemap_fdatawrite_range(mapping, lstart, lend,
-						    WB_SYNC_ALL);
-		if (retval == 0)
-			retval = wait_on_page_writeback_range(mapping,
-						    lstart >> PAGE_CACHE_SHIFT,
-						    lend >> PAGE_CACHE_SHIFT);
+		err = __filemap_fdatawrite_range(mapping, lstart, lend,
+						 WB_SYNC_ALL);
+		err2 = wait_on_page_writeback_range(mapping,
+						   lstart >> PAGE_CACHE_SHIFT,
+						   lend >> PAGE_CACHE_SHIFT);
+		if (!err)
+			err = err2;
 	}
-	return retval;
+	return err;
 }
 
 /*
_
