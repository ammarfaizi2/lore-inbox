Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261845AbSJNG3O>; Mon, 14 Oct 2002 02:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261862AbSJNG3N>; Mon, 14 Oct 2002 02:29:13 -0400
Received: from packet.digeo.com ([12.110.80.53]:6827 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261845AbSJNG3F>;
	Mon, 14 Oct 2002 02:29:05 -0400
Message-ID: <3DAA6587.2A4C24B0@digeo.com>
Date: Sun, 13 Oct 2002 23:34:47 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: lkml <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [patch] remove BKL from inode_setattr
References: <3DAA4FD6.A18DAFE6@digeo.com> <Pine.LNX.4.44.0210140657240.9845-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Oct 2002 06:34:51.0113 (UTC) FILETIME=[CC89F590:01C2734B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> 
> On Sun, 13 Oct 2002, Andrew Morton wrote:
> >
> > Since April 05 of this year we've been holding the BKL across the
> > vmtruncate call out of inode_setattr().  By accident it seems.
> 
> But until then, the lock_kernel was one level up in notify_change().

OK.

> > This does not affect unlink().  It affects ftruncate() and open(O_TRUNC).
> 
> And the patch you give affects chown, chgrp, chmod, utime also:
> removing a synchronization point if nothing more.  Could that matter?

I don't think so.  If

	lock_kernel();
	foo = bar;
	unlock_kernel();

is racy then so is

	foo = bar;
 
> > Given that the drop_inode() path does not take the BKL, I would
> > suggest that it is safe to assume that the various filesystem's
> > truncate code is safe without this additional VFS-level lock_kernel(),
> > and that it can be simply removed.
> 
> Isn't doing it when the references have gone rather easier/safer
> than when they remain?  I'm not sure your argument holds.

well we hold i_sem.  So races against operations against the same
file are pretty much blotted out.  Only reads I guess.  It's races
against operations on different files which are the concern.  And
we're already exposed to them.

The number of filsystems which do not take the bkl in truncate/setattr
is in fact quite small.  Here's the patch which removes all doubt:




 fs/affs/file.c          |   13 ++++++++-----
 fs/attr.c               |    2 --
 fs/cifs/inode.c         |    7 ++++++-
 fs/jfs/file.c           |    3 +++
 fs/reiserfs/file.c      |    2 ++
 fs/smbfs/proc.c         |   18 +++++++++++++++---
 fs/sysv/itree.c         |    6 +++++-
 fs/xfs/linux/xfs_iops.c |   11 +++++++++--
 8 files changed, 48 insertions(+), 14 deletions(-)

--- 2.5.42/fs/attr.c~truncate-bkl	Sun Oct 13 20:04:06 2002
+++ 2.5.42-akpm/fs/attr.c	Sun Oct 13 21:04:22 2002
@@ -67,7 +67,6 @@ int inode_setattr(struct inode * inode, 
 	unsigned int ia_valid = attr->ia_valid;
 	int error = 0;
 	
-	lock_kernel();
 	if (ia_valid & ATTR_SIZE) {
 		error = vmtruncate(inode, attr->ia_size);
 		if (error)
@@ -91,7 +90,6 @@ int inode_setattr(struct inode * inode, 
 	}
 	mark_inode_dirty(inode);
 out:
-	unlock_kernel();
 	return error;
 }
 
--- 2.5.42/fs/affs/file.c~truncate-bkl	Sun Oct 13 21:02:43 2002
+++ 2.5.42-akpm/fs/affs/file.c	Sun Oct 13 21:03:46 2002
@@ -832,6 +832,7 @@ affs_truncate(struct inode *inode)
 	pr_debug("AFFS: truncate(inode=%d, oldsize=%u, newsize=%u)\n",
 		 (u32)inode->i_ino, (u32)AFFS_I(inode)->mmu_private, (u32)inode->i_size);
 
+	lock_kernel();
 	last_blk = 0;
 	ext = 0;
 	if (inode->i_size) {
@@ -847,7 +848,7 @@ affs_truncate(struct inode *inode)
 
 		page = grab_cache_page(mapping, size >> PAGE_CACHE_SHIFT);
 		if (!page)
-			return;
+			goto out;
 		size = (size & (PAGE_CACHE_SIZE - 1)) + 1;
 		res = mapping->a_ops->prepare_write(NULL, page, size, size);
 		if (!res)
@@ -855,16 +856,16 @@ affs_truncate(struct inode *inode)
 		unlock_page(page);
 		page_cache_release(page);
 		mark_inode_dirty(inode);
-		return;
+		goto out;
 	} else if (inode->i_size == AFFS_I(inode)->mmu_private)
-		return;
+		goto out;
 
 	// lock cache
 	ext_bh = affs_get_extblock(inode, ext);
 	if (IS_ERR(ext_bh)) {
 		affs_warning(sb, "truncate", "unexpected read error for ext block %u (%d)",
 			     ext, PTR_ERR(ext_bh));
-		return;
+		goto out;
 	}
 	if (AFFS_I(inode)->i_lc) {
 		/* clear linear cache */
@@ -910,7 +911,7 @@ affs_truncate(struct inode *inode)
 			if (IS_ERR(ext_bh)) {
 				affs_warning(sb, "truncate", "unexpected read error for last block %u (%d)",
 					     ext, PTR_ERR(ext_bh));
-				return;
+				goto out;
 			}
 			tmp = be32_to_cpu(AFFS_DATA_HEAD(bh)->next);
 			AFFS_DATA_HEAD(bh)->next = 0;
@@ -936,4 +937,6 @@ affs_truncate(struct inode *inode)
 		affs_brelse(ext_bh);
 	}
 	affs_free_prealloc(inode);
+out:
+	unlock_kernel();
 }
--- 2.5.42/fs/cifs/inode.c~truncate-bkl	Sun Oct 13 21:05:31 2002
+++ 2.5.42-akpm/fs/cifs/inode.c	Sun Oct 13 21:05:55 2002
@@ -20,6 +20,7 @@
  */
 #include <linux/fs.h>
 #include <linux/stat.h>
+#include <linux/smp_lock.h>
 #include <asm/div64.h>
 #include "cifsfs.h"
 #include "cifspdu.h"
@@ -517,6 +518,8 @@ cifs_truncate_file(struct inode *inode)
 	struct dentry *dirent;
 	char *full_path = NULL;   
 
+    lock_kernel();
+
 	xid = GetXid();
 
 	cifs_sb = CIFS_SB(inode->i_sb);
@@ -527,7 +530,7 @@ cifs_truncate_file(struct inode *inode)
 		       ("Can not get pathname from empty dentry in inode 0x%p ",
 			inode));
 		FreeXid(xid);
-		return;
+		goto out;
 	}
 	dirent = list_entry(inode->i_dentry.next, struct dentry, d_alias);
 	if (dirent) {
@@ -556,6 +559,8 @@ cifs_truncate_file(struct inode *inode)
 	if (full_path)
 		kfree(full_path);
 	FreeXid(xid);
+out:
+    unlock_kernel();
 	return;
 }
 
--- 2.5.42/fs/jfs/file.c~truncate-bkl	Sun Oct 13 21:11:06 2002
+++ 2.5.42-akpm/fs/jfs/file.c	Sun Oct 13 21:11:11 2002
@@ -18,6 +18,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/smp_lock.h>
 #include "jfs_incore.h"
 #include "jfs_dmap.h"
 #include "jfs_txnmgr.h"
@@ -90,9 +91,11 @@ static void jfs_truncate(struct inode *i
 {
 	jFYI(1, ("jfs_truncate: size = 0x%lx\n", (ulong) ip->i_size));
 
+	lock_kernel();
 	IWRITE_LOCK(ip);
 	jfs_truncate_nolock(ip, ip->i_size);
 	IWRITE_UNLOCK(ip);
+	unlock_kernel();
 }
 
 static int jfs_open(struct inode *inode, struct file *file)
--- 2.5.42/fs/reiserfs/file.c~truncate-bkl	Sun Oct 13 21:15:53 2002
+++ 2.5.42-akpm/fs/reiserfs/file.c	Sun Oct 13 21:16:17 2002
@@ -66,7 +66,9 @@ static int reiserfs_file_release (struct
 }
 
 static void reiserfs_vfs_truncate_file(struct inode *inode) {
+    lock_kernel() ;
     reiserfs_truncate_file(inode, 1) ;
+    unlock_kernel() ;
 }
 
 /* Sync a reiserfs file. */
--- 2.5.42/fs/smbfs/proc.c~truncate-bkl	Sun Oct 13 21:18:13 2002
+++ 2.5.42-akpm/fs/smbfs/proc.c	Sun Oct 13 21:19:41 2002
@@ -1740,12 +1740,17 @@ out:
 static int
 smb_proc_trunc32(struct inode *inode, loff_t length)
 {
+	int ret;
+
 	/*
 	 * Writing 0bytes is old-SMB magic for truncating files.
 	 * MAX_NON_LFS should prevent this from being called with a too
 	 * large offset.
 	 */
-	return smb_proc_write(inode, length, 0, NULL);
+	lock_kernel();
+	ret = smb_proc_write(inode, length, 0, NULL);
+	unlock_kernel();
+	return ret;
 }
 
 static int
@@ -1757,6 +1762,7 @@ smb_proc_trunc64(struct inode *inode, lo
 	char *data;
 	struct smb_request *req;
 
+	lock_kernel();
 	result = -ENOMEM;
 	if (! (req = smb_alloc_request(server, 14)))
 		goto out;
@@ -1787,14 +1793,19 @@ smb_proc_trunc64(struct inode *inode, lo
 out_free:
 	smb_rput(req);
 out:
+	unlock_kernel();
 	return result;
 }
 
 static int
 smb_proc_trunc95(struct inode *inode, loff_t length)
 {
-	struct smb_sb_info *server = server_from_inode(inode);
-	int result = smb_proc_trunc32(inode, length);
+	struct smb_sb_info *server;
+	int result;
+ 
+	lock_kernel();
+	server = server_from_inode(inode);
+	result = smb_proc_trunc32(inode, length);
  
 	/*
 	 * win9x doesn't appear to update the size immediately.
@@ -1804,6 +1815,7 @@ smb_proc_trunc95(struct inode *inode, lo
 	 * FIXME: is this still necessary?
 	 */
 	smb_proc_flush(server, SMB_I(inode)->fileid);
+	unlock_kernel();
 	return result;
 }
 
--- 2.5.42/fs/sysv/itree.c~truncate-bkl	Sun Oct 13 21:20:07 2002
+++ 2.5.42-akpm/fs/sysv/itree.c	Sun Oct 13 21:20:43 2002
@@ -373,6 +373,8 @@ void sysv_truncate (struct inode * inode
 	    S_ISLNK(inode->i_mode)))
 		return;
 
+	lock_kernel();
+
 	blocksize = inode->i_sb->s_blocksize;
 	iblock = (inode->i_size + blocksize-1)
 					>> inode->i_sb->s_blocksize_bits;
@@ -381,7 +383,7 @@ void sysv_truncate (struct inode * inode
 
 	n = block_to_path(inode, iblock, offsets);
 	if (n == 0)
-		return;
+		goto out;
 
 	if (n == 1) {
 		free_data(inode, i_data+offsets[0], i_data + DIRECT);
@@ -421,6 +423,8 @@ do_indirects:
 		sysv_sync_inode (inode);
 	else
 		mark_inode_dirty(inode);
+out:
+	unlock_kernel();
 }
 
 static unsigned sysv_nblocks(struct super_block *s, loff_t size)
--- 2.5.42/fs/xfs/linux/xfs_iops.c~truncate-bkl	Sun Oct 13 21:22:15 2002
+++ 2.5.42-akpm/fs/xfs/linux/xfs_iops.c	Sun Oct 13 21:23:26 2002
@@ -32,6 +32,7 @@
 
 #include <xfs.h>
 #include <linux/xattr.h>
+#include <linux/smp_lock.h>
 
 
 /*
@@ -482,6 +483,8 @@ linvfs_setattr(
 	int		error;
 	int		flags = 0;
 
+	lock_kernel();
+
 	memset(&vattr, 0, sizeof(vattr_t));
 	if (ia_valid & ATTR_UID) {
 		vattr.va_mask |= AT_UID;
@@ -521,8 +524,10 @@ linvfs_setattr(
 		flags = ATTR_UTIME;
 
 	VOP_SETATTR(vp, &vattr, flags, NULL, error);
-	if (error)
-		return(-error); /* Positive error up from XFS */
+	if (error) {
+		error = -error;	/* Positive error up from XFS */
+		goto out;
+	}
 	if (ia_valid & ATTR_SIZE) {
 		error = vmtruncate(inode, attr->ia_size);
 	}
@@ -531,6 +536,8 @@ linvfs_setattr(
 		vn_revalidate(vp, 0);
 		mark_inode_dirty_sync(inode);
 	}
+out:
+	unlock_kernel();
 	return error;
 }
 

.
