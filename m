Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262213AbUEFNYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbUEFNYp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 09:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbUEFNXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 09:23:45 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:43955 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S262109AbUEFNUY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 09:20:24 -0400
Date: Thu, 6 May 2004 15:20:27 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH COW] lock_flags
Message-ID: <20040506132027.GE7930@wohnheim.fh-wedel.de>
References: <20040506131731.GA7930@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040506131731.GA7930@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 4 - just for completeness

Jörn

-- 
Optimizations always bust things, because all optimizations are, in
the long haul, a form of cheating, and cheaters eventually get caught.
-- Larry Wall 

spins on i_lock before accessing i_flags

Omissions:
o fs/befs/linuxvfs.c	inode->i_flags should be befs_ino->i_flags
o fs/dquot.c		vfs_quota_on() is racy.  the race is now limited to
			S_NOATIME, S_QUOTA and S_NOQUOTA, but it still exists.

 drivers/usb/core/inode.c |    2 ++
 fs/afs/inode.c           |    2 ++
 fs/dquot.c               |   21 ++++++++++++++++++---
 fs/ext2/ialloc.c         |    2 ++
 fs/ext2/inode.c          |    2 ++
 fs/ext3/ialloc.c         |    2 ++
 fs/ext3/inode.c          |    2 ++
 fs/fat/inode.c           |    5 ++++-
 fs/hfs/inode.c           |    2 +-
 fs/hfsplus/catalog.c     |    4 ++--
 fs/hfsplus/dir.c         |   10 ++++++++--
 fs/hfsplus/inode.c       |    6 +++++-
 fs/hfsplus/ioctl.c       |    2 ++
 fs/intermezzo/vfs.c      |    7 ++++++-
 fs/namei.c               |   10 ++++++++--
 fs/nfs/inode.c           |    2 ++
 fs/proc/base.c           |    4 ++++
 fs/reiserfs/inode.c      |    9 ++++++++-
 fs/smbfs/file.c          |    2 +-
 fs/udf/ialloc.c          |    2 ++
 fs/ufs/ialloc.c          |    2 ++
 fs/xfs/linux/xfs_ioctl.c |    2 +-
 fs/xfs/linux/xfs_super.c |    2 ++
 fs/xfs/linux/xfs_vnode.c |    2 ++
 fs/xfs/xfs_acl.c         |    2 +-
 fs/xfs/xfs_cap.c         |    2 +-
 include/linux/fs.h       |   32 +++++++++++++++++++++-----------
 27 files changed, 113 insertions(+), 29 deletions(-)


--- linux-2.6.5cow/include/linux/fs.h~lock_flags	2004-04-14 16:22:15.000000000 +0200
+++ linux-2.6.5cow/include/linux/fs.h	2004-04-27 16:34:42.000000000 +0200
@@ -155,24 +155,25 @@
  */
 #define __IS_FLG(inode,flg) ((inode)->i_sb->s_flags & (flg))
 
-#define IS_RDONLY(inode) ((inode)->i_sb->s_flags & MS_RDONLY)
+#define IS_RDONLY(inode)	(__IS_FLG(inode, MS_RDONLY))
 #define IS_SYNC(inode)		(__IS_FLG(inode, MS_SYNCHRONOUS) || \
-					((inode)->i_flags & S_SYNC))
+					inode_flags((inode), S_SYNC))
 #define IS_DIRSYNC(inode)	(__IS_FLG(inode, MS_SYNCHRONOUS|MS_DIRSYNC) || \
-					((inode)->i_flags & (S_SYNC|S_DIRSYNC)))
+				       inode_flags((inode), (S_SYNC|S_DIRSYNC)))
 #define IS_MANDLOCK(inode)	__IS_FLG(inode, MS_MANDLOCK)
 
-#define IS_QUOTAINIT(inode)	((inode)->i_flags & S_QUOTA)
-#define IS_NOQUOTA(inode)	((inode)->i_flags & S_NOQUOTA)
-#define IS_APPEND(inode)	((inode)->i_flags & S_APPEND)
-#define IS_IMMUTABLE(inode)	((inode)->i_flags & S_IMMUTABLE)
-#define IS_NOATIME(inode)	(__IS_FLG(inode, MS_NOATIME) || ((inode)->i_flags & S_NOATIME))
+#define IS_QUOTAINIT(inode)	(inode_flags((inode), S_QUOTA))
+#define IS_NOQUOTA(inode)	(inode_flags((inode), S_NOQUOTA))
+#define IS_APPEND(inode)	(inode_flags((inode), S_APPEND))
+#define IS_IMMUTABLE(inode)	(inode_flags((inode), S_IMMUTABLE))
+#define IS_NOATIME(inode)	(__IS_FLG(inode, MS_NOATIME) || \
+					inode_flags((inode), S_NOATIME))
 #define IS_NODIRATIME(inode)	__IS_FLG(inode, MS_NODIRATIME)
 #define IS_POSIXACL(inode)	__IS_FLG(inode, MS_POSIXACL)
 #define IS_ONE_SECOND(inode)	__IS_FLG(inode, MS_ONE_SECOND)
 
-#define IS_DEADDIR(inode)	((inode)->i_flags & S_DEAD)
-#define IS_NOCMTIME(inode)	((inode)->i_flags & S_NOCMTIME)
+#define IS_DEADDIR(inode)	(inode_flags((inode), S_DEAD))
+#define IS_NOCMTIME(inode)	(inode_flags((inode), S_NOCMTIME))
 
 /* the read-only stuff doesn't really belong here, but any other place is
    probably as bad and I don't want to create yet another include file. */
@@ -417,7 +418,7 @@
 	unsigned long		i_state;
 	unsigned long		dirtied_when;	/* jiffies of first dirtying */
 
-	unsigned int		i_flags;
+	unsigned int		i_flags;	/* protected by i_lock */
 	unsigned char		i_sock;
 
 	atomic_t		i_writecount;
@@ -431,6 +432,15 @@
 #endif
 };
 
+static inline unsigned int inode_flags(struct inode *inode, unsigned int mask)
+{
+	int ret;
+	spin_lock(inode->i_lock);
+	ret = inode->i_flags & mask;
+	spin_unlock(inode->i_lock);
+	return ret;
+}
+
 /*
  * NOTE: in a 32bit arch with a preemptable kernel and
  * an UP compile the i_size_read/write must be atomic
--- linux-2.6.5cow/drivers/usb/core/inode.c~lock_flags	2004-04-14 16:22:15.000000000 +0200
+++ linux-2.6.5cow/drivers/usb/core/inode.c	2004-04-14 16:22:24.000000000 +0200
@@ -277,7 +277,9 @@
 	if (usbfs_empty(dentry)) {
 		dentry->d_inode->i_nlink -= 2;
 		dput(dentry);
+		spin_lock(inode->i_lock);
 		inode->i_flags |= S_DEAD;
+		spin_unlock(inode->i_lock);
 		dir->i_nlink--;
 		error = 0;
 	}
--- linux-2.6.5cow/fs/xfs/linux/xfs_vnode.c~lock_flags	2004-04-14 16:22:15.000000000 +0200
+++ linux-2.6.5cow/fs/xfs/linux/xfs_vnode.c	2004-04-14 16:22:24.000000000 +0200
@@ -213,6 +213,7 @@
 		inode->i_mtime	    = va.va_mtime;
 		inode->i_ctime	    = va.va_ctime;
 		inode->i_atime	    = va.va_atime;
+		spin_lock(inode->i_lock);
 		if (va.va_xflags & XFS_XFLAG_IMMUTABLE)
 			inode->i_flags |= S_IMMUTABLE;
 		else
@@ -229,6 +230,7 @@
 			inode->i_flags |= S_NOATIME;
 		else
 			inode->i_flags &= ~S_NOATIME;
+		spin_unlock(inode->i_lock);
 		VUNMODIFY(vp);
 	}
 	return -error;
--- linux-2.6.5cow/fs/xfs/linux/xfs_ioctl.c~lock_flags	2004-04-14 16:22:15.000000000 +0200
+++ linux-2.6.5cow/fs/xfs/linux/xfs_ioctl.c	2004-04-14 16:22:24.000000000 +0200
@@ -885,7 +885,7 @@
 	int			attr_flags = 0;
 	int			error;
 
-	if (vp->v_inode.i_flags & (S_IMMUTABLE|S_APPEND))
+	if (inode_flags(vp->v_inode, (S_IMMUTABLE|S_APPEND)))
 		return -XFS_ERROR(EPERM);
 
 	if (!(filp->f_flags & FMODE_WRITE))
--- linux-2.6.5cow/fs/xfs/linux/xfs_super.c~lock_flags	2004-04-14 16:22:15.000000000 +0200
+++ linux-2.6.5cow/fs/xfs/linux/xfs_super.c	2004-04-14 16:22:24.000000000 +0200
@@ -187,6 +187,7 @@
 	inode->i_mtime.tv_nsec	= ip->i_d.di_mtime.t_nsec;
 	inode->i_ctime.tv_sec	= ip->i_d.di_ctime.t_sec;
 	inode->i_ctime.tv_nsec	= ip->i_d.di_ctime.t_nsec;
+	spin_lock(inode->i_lock);
 	if (ip->i_d.di_flags & XFS_DIFLAG_IMMUTABLE)
 		inode->i_flags |= S_IMMUTABLE;
 	else
@@ -203,6 +204,7 @@
 		inode->i_flags |= S_NOATIME;
 	else
 		inode->i_flags &= ~S_NOATIME;
+	spin_unlock(inode->i_lock);
 	vp->v_flag &= ~VMODIFIED;
 }
 
--- linux-2.6.5cow/fs/xfs/xfs_acl.c~lock_flags	2004-04-14 16:22:15.000000000 +0200
+++ linux-2.6.5cow/fs/xfs/xfs_acl.c	2004-04-14 16:22:24.000000000 +0200
@@ -388,7 +388,7 @@
 	vattr_t		va;
 	int		error;
 
-	if (vp->v_inode.i_flags & (S_IMMUTABLE|S_APPEND))
+	if (inode_flags(&vp->v_inode, (S_IMMUTABLE|S_APPEND)))
 		return EPERM;
 	if (kind == _ACL_TYPE_DEFAULT && vp->v_type != VDIR)
 		return ENOTDIR;
--- linux-2.6.5cow/fs/xfs/xfs_cap.c~lock_flags	2004-04-14 16:22:15.000000000 +0200
+++ linux-2.6.5cow/fs/xfs/xfs_cap.c	2004-04-14 16:22:24.000000000 +0200
@@ -192,7 +192,7 @@
 
 	if (vp->v_vfsp->vfs_flag & VFS_RDONLY)
 		return EROFS;
-	if (vp->v_inode.i_flags & (S_IMMUTABLE|S_APPEND))
+	if (inode_flags(&vp->v_inode, (S_IMMUTABLE|S_APPEND)))
 		return EPERM;
 	if ((error = _MAC_VACCESS(vp, NULL, VWRITE)))
 		return error;
--- linux-2.6.5cow/fs/nfs/inode.c~lock_flags	2004-04-14 16:22:15.000000000 +0200
+++ linux-2.6.5cow/fs/nfs/inode.c	2004-04-14 16:22:24.000000000 +0200
@@ -695,7 +695,9 @@
 		inode->i_ino = hash;
 
 		/* We can't support update_atime(), since the server will reset it */
+		spin_lock(inode->i_lock);
 		inode->i_flags |= S_NOATIME|S_NOCMTIME;
+		spin_unlock(inode->i_lock);
 		inode->i_mode = fattr->mode;
 		/* Why so? Because we want revalidate for devices/FIFOs, and
 		 * that's precisely what we have in nfs_file_inode_operations.
--- linux-2.6.5cow/fs/ufs/ialloc.c~lock_flags	2004-04-14 16:22:15.000000000 +0200
+++ linux-2.6.5cow/fs/ufs/ialloc.c	2004-04-14 16:22:24.000000000 +0200
@@ -283,7 +283,9 @@
 
 	if (DQUOT_ALLOC_INODE(inode)) {
 		DQUOT_DROP(inode);
+		spin_lock(inode->i_lock);
 		inode->i_flags |= S_NOQUOTA;
+		spin_unlock(inode->i_lock);
 		inode->i_nlink = 0;
 		iput(inode);
 		return ERR_PTR(-EDQUOT);
--- linux-2.6.5cow/fs/hfs/inode.c~lock_flags	2004-04-14 16:22:15.000000000 +0200
+++ linux-2.6.5cow/fs/hfs/inode.c	2004-04-20 16:20:21.000000000 +0200
@@ -540,7 +540,7 @@
 	if (atomic_dec_and_test(&HFS_I(inode)->opencnt)) {
 		down(&inode->i_sem);
 		hfs_file_truncate(inode);
-		//if (inode->i_flags & S_DEAD) {
+		//if (IS_DEADDIR(inode) {
 		//	hfs_delete_cat(inode->i_ino, HFSPLUS_SB(sb).hidden_dir, NULL);
 		//	hfs_delete_inode(inode);
 		//}
--- linux-2.6.5cow/fs/intermezzo/vfs.c~lock_flags	2004-04-14 16:22:15.000000000 +0200
+++ linux-2.6.5cow/fs/intermezzo/vfs.c	2004-04-14 16:22:24.000000000 +0200
@@ -1441,7 +1441,9 @@
                 error = iops->rmdir(dir->d_inode, dentry);
                 unlock_kernel();
                 if (!error) {
+			spin_lock(dentry->d_inode->i_lock);
                         dentry->d_inode->i_flags |= S_DEAD;
+			spin_unlock(dentry->d_inode->i_lock);
                         error = presto_settime(fset, NULL, NULL, dir, info,
                                                ATTR_CTIME | ATTR_MTIME);
                 }
@@ -1838,8 +1840,11 @@
                 error = do_rename(fset, old_parent, old_dentry,
                                          new_parent, new_dentry, info);
         if (target) {
-                if (!error)
+                if (!error) {
+			spin_lock(target);
                         target->i_flags |= S_DEAD;
+			spin_unlock(target);
+		}
                 //                triple_up(&old_dir->i_zombie,
                 //                          &new_dir->i_zombie,
                 //                          &target->i_zombie);
--- linux-2.6.5cow/fs/udf/ialloc.c~lock_flags	2004-04-14 16:22:15.000000000 +0200
+++ linux-2.6.5cow/fs/udf/ialloc.c	2004-04-14 16:22:24.000000000 +0200
@@ -165,7 +165,9 @@
 	if (DQUOT_ALLOC_INODE(inode))
 	{
 		DQUOT_DROP(inode);
+		spin_lock(inode->i_lock);
 		inode->i_flags |= S_NOQUOTA;
+		spin_unlock(inode->i_lock);
 		inode->i_nlink = 0;
 		iput(inode);
 		*err = -EDQUOT;
--- linux-2.6.5cow/fs/reiserfs/inode.c~lock_flags	2004-04-14 16:22:15.000000000 +0200
+++ linux-2.6.5cow/fs/reiserfs/inode.c	2004-04-20 16:20:21.000000000 +0200
@@ -1612,8 +1612,11 @@
     /* uid and gid must already be set by the caller for quota init */
 
     /* symlink cannot be immutable or append only, right? */
-    if( S_ISLNK( inode -> i_mode ) )
+    if( S_ISLNK( inode -> i_mode ) ) {
+	    spin_lock(inode->i_lock);
 	    inode -> i_flags &= ~ ( S_IMMUTABLE | S_APPEND );
+	    spin_unlock(inode->i_lock);
+    }
 
     inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
     inode->i_size = i_size;
@@ -2287,6 +2290,7 @@
 void sd_attrs_to_i_attrs( __u16 sd_attrs, struct inode *inode )
 {
 	if( reiserfs_attrs( inode -> i_sb ) ) {
+		spin_lock(inode->i_lock);
 		if( sd_attrs & REISERFS_SYNC_FL )
 			inode -> i_flags |= S_SYNC;
 		else
@@ -2307,12 +2311,14 @@
 			REISERFS_I(inode)->i_flags |= i_nopack_mask;
 		else
 			REISERFS_I(inode)->i_flags &= ~i_nopack_mask;
+		spin_unlock(inode->i_lock);
 	}
 }
 
 void i_attrs_to_sd_attrs( struct inode *inode, __u16 *sd_attrs )
 {
 	if( reiserfs_attrs( inode -> i_sb ) ) {
+		spin_lock(inode->i_lock);
 		if( inode -> i_flags & S_IMMUTABLE )
 			*sd_attrs |= REISERFS_IMMUTABLE_FL;
 		else
@@ -2329,6 +2335,7 @@
 			*sd_attrs |= REISERFS_NOTAIL_FL;
 		else
 			*sd_attrs &= ~REISERFS_NOTAIL_FL;
+		spin_unlock(inode->i_lock);
 	}
 }
 
--- linux-2.6.5cow/fs/fat/inode.c~lock_flags	2004-04-14 16:22:15.000000000 +0200
+++ linux-2.6.5cow/fs/fat/inode.c	2004-04-20 16:20:21.000000000 +0200
@@ -1193,8 +1193,11 @@
 		MSDOS_I(inode)->mmu_private = inode->i_size;
 	}
 	if(de->attr & ATTR_SYS)
-		if (sbi->options.sys_immutable)
+		if (sbi->options.sys_immutable) {
+			spin_lock(inode->i_lock);
 			inode->i_flags |= S_IMMUTABLE;
+			spin_unlock(inode->i_lock);
+		}
 	MSDOS_I(inode)->i_attrs = de->attr & ATTR_UNUSED;
 	/* this is as close to the truth as we can get ... */
 	inode->i_blksize = sbi->cluster_size;
--- linux-2.6.5cow/fs/ext3/ialloc.c~lock_flags	2004-04-14 16:22:15.000000000 +0200
+++ linux-2.6.5cow/fs/ext3/ialloc.c	2004-04-14 16:22:24.000000000 +0200
@@ -627,7 +627,9 @@
 	return ret;
 
 fail2:
+	spin_lock(inode->i_lock);
 	inode->i_flags |= S_NOQUOTA;
+	spin_unlock(inode->i_lock);
 	inode->i_nlink = 0;
 	iput(inode);
 	brelse(bitmap_bh);
--- linux-2.6.5cow/fs/ext3/inode.c~lock_flags	2004-04-14 16:22:15.000000000 +0200
+++ linux-2.6.5cow/fs/ext3/inode.c	2004-04-27 16:34:42.000000000 +0200
@@ -2447,6 +2447,7 @@
 {
 	unsigned int flags = EXT3_I(inode)->i_flags;
 
+	spin_lock(inode->i_lock);
 	inode->i_flags &= ~(S_SYNC|S_APPEND|S_IMMUTABLE|S_NOATIME|S_DIRSYNC);
 	if (flags & EXT3_SYNC_FL)
 		inode->i_flags |= S_SYNC;
@@ -2458,6 +2459,7 @@
 		inode->i_flags |= S_NOATIME;
 	if (flags & EXT3_DIRSYNC_FL)
 		inode->i_flags |= S_DIRSYNC;
+	spin_unlock(inode->i_lock);
 }
 
 void ext3_read_inode(struct inode * inode)
--- linux-2.6.5cow/fs/proc/base.c~lock_flags	2004-04-14 16:22:15.000000000 +0200
+++ linux-2.6.5cow/fs/proc/base.c	2004-04-14 16:22:24.000000000 +0200
@@ -1594,7 +1594,9 @@
 	inode->i_op = &proc_tgid_base_inode_operations;
 	inode->i_fop = &proc_tgid_base_operations;
 	inode->i_nlink = 3;
+	spin_lock(inode->i_lock);
 	inode->i_flags|=S_IMMUTABLE;
+	spin_unlock(inode->i_lock);
 
 	dentry->d_op = &pid_base_dentry_operations;
 
@@ -1649,7 +1651,9 @@
 	inode->i_op = &proc_tid_base_inode_operations;
 	inode->i_fop = &proc_tid_base_operations;
 	inode->i_nlink = 3;
+	spin_lock(inode->i_lock);
 	inode->i_flags|=S_IMMUTABLE;
+	spin_unlock(inode->i_lock);
 
 	dentry->d_op = &pid_base_dentry_operations;
 
--- linux-2.6.5cow/fs/ext2/inode.c~lock_flags	2004-04-14 16:22:15.000000000 +0200
+++ linux-2.6.5cow/fs/ext2/inode.c	2004-04-27 16:34:42.000000000 +0200
@@ -1020,6 +1020,7 @@
 {
 	unsigned int flags = EXT2_I(inode)->i_flags;
 
+	spin_lock(inode->i_lock);
 	inode->i_flags &= ~(S_SYNC|S_APPEND|S_IMMUTABLE|S_NOATIME|S_DIRSYNC);
 	if (flags & EXT2_SYNC_FL)
 		inode->i_flags |= S_SYNC;
@@ -1031,6 +1032,7 @@
 		inode->i_flags |= S_NOATIME;
 	if (flags & EXT2_DIRSYNC_FL)
 		inode->i_flags |= S_DIRSYNC;
+	spin_unlock(inode->i_lock);
 }
 
 void ext2_read_inode (struct inode * inode)
--- linux-2.6.5cow/fs/ext2/ialloc.c~lock_flags	2004-04-14 16:22:15.000000000 +0200
+++ linux-2.6.5cow/fs/ext2/ialloc.c	2004-04-14 16:22:24.000000000 +0200
@@ -620,7 +620,9 @@
 	return inode;
 
 fail2:
+	spin_lock(inode->i_lock);
 	inode->i_flags |= S_NOQUOTA;
+	spin_unlock(inode->i_lock);
 	inode->i_nlink = 0;
 	iput(inode);
 	return ERR_PTR(err);
--- linux-2.6.5cow/fs/namei.c~lock_flags	2004-04-14 16:22:15.000000000 +0200
+++ linux-2.6.5cow/fs/namei.c	2004-04-27 16:34:42.000000000 +0200
@@ -1609,8 +1609,11 @@
 		error = security_inode_rmdir(dir, dentry);
 		if (!error) {
 			error = dir->i_op->rmdir(dir, dentry);
-			if (!error)
+			if (!error) {
+				spin_lock(dentry->d_inode->i_lock);
 				dentry->d_inode->i_flags |= S_DEAD;
+				spin_unlock(dentry->d_inode->i_lock);
+			}
 		}
 	}
 	up(&dentry->d_inode->i_sem);
@@ -1952,8 +1955,11 @@
 	else 
 		error = old_dir->i_op->rename(old_dir, old_dentry, new_dir, new_dentry);
 	if (target) {
-		if (!error)
+		if (!error) {
+			spin_lock(target->i_lock);
 			target->i_flags |= S_DEAD;
+			spin_unlock(target->i_lock);
+		}
 		up(&target->i_sem);
 		if (d_unhashed(new_dentry))
 			d_rehash(new_dentry);
--- linux-2.6.5cow/fs/dquot.c~lock_flags	2004-04-14 16:22:15.000000000 +0200
+++ linux-2.6.5cow/fs/dquot.c	2004-04-14 16:22:24.000000000 +0200
@@ -573,7 +573,9 @@
 		if (inode->i_dquot[cnt] != NODQUOT)
 			goto put_it;
 	}
+	spin_lock(inode->i_lock);
 	inode->i_flags &= ~S_QUOTA;
+	spin_unlock(inode->i_lock);
 put_it:
 	if (dquot != NODQUOT) {
 		if (dqput_blocks(dquot)) {
@@ -824,8 +826,11 @@
 					break;
 			}
 			inode->i_dquot[cnt] = dqget(inode->i_sb, id, cnt);
-			if (inode->i_dquot[cnt])
+			if (inode->i_dquot[cnt]) {
+				spin_lock(inode->i_lock);
 				inode->i_flags |= S_QUOTA;
+				spin_unlock(inode->i_lock);
+			}
 		}
 	}
 	up_write(&sb_dqopt(inode->i_sb)->dqptr_sem);
@@ -839,7 +844,9 @@
 {
 	int cnt;
 
+	spin_lock(inode->i_lock);
 	inode->i_flags &= ~S_QUOTA;
+	spin_unlock(inode->i_lock);
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
 		to_drop[cnt] = inode->i_dquot[cnt];
 		inode->i_dquot[cnt] = NODQUOT;
@@ -1174,6 +1181,7 @@
 	return 0;
 }
 
+#define SAFE_FLAGS (S_QUOTA | S_NOQUOTA | S_NOATIME)
 int vfs_quota_on(struct super_block *sb, int type, int format_id, char *path)
 {
 	struct file *f;
@@ -1207,14 +1215,18 @@
 		error = -EBUSY;
 		goto out_lock;
 	}
-	oldflags = inode->i_flags;
+	/* FIXME: this is a race for i_flags.  not sure how to fix it properly,
+	 * but at least it only affects the three SAFE_FLAGS now */
+	oldflags = inode_flags(inode, SAFE_FLAGS);
 	dqopt->files[type] = f;
 	error = -EINVAL;
 	if (!fmt->qf_ops->check_quota_file(sb, type))
 		goto out_file_init;
 	/* We don't want quota and atime on quota files (deadlocks possible) */
 	dquot_drop_nolock(inode);
+	spin_lock(inode->i_lock);
 	inode->i_flags |= S_NOQUOTA | S_NOATIME;
+	spin_unlock(inode->i_lock);
 
 	dqopt->ops[type] = fmt->qf_ops;
 	dqopt->info[type].dqi_format = fmt;
@@ -1233,7 +1245,10 @@
 	return 0;
 
 out_file_init:
-	inode->i_flags = oldflags;
+	spin_lock(inode->i_lock);
+	inode->i_flags &= ~SAFE_FLAGS;
+	inode->i_flags |= oldflags;
+	spin_unlock(inode->i_lock);
 	dqopt->files[type] = NULL;
 out_lock:
 	up_write(&dqopt->dqptr_sem);
--- linux-2.6.5cow/fs/hfsplus/catalog.c~lock_flags	2004-04-14 16:22:15.000000000 +0200
+++ linux-2.6.5cow/fs/hfsplus/catalog.c	2004-04-14 16:22:24.000000000 +0200
@@ -54,11 +54,11 @@
 
 static void hfsplus_set_perms(struct inode *inode, struct hfsplus_perm *perms)
 {
-	if (inode->i_flags & S_IMMUTABLE)
+	if (IS_IMMUTABLE(inode))
 		perms->rootflags |= HFSPLUS_FLG_IMMUTABLE;
 	else
 		perms->rootflags &= ~HFSPLUS_FLG_IMMUTABLE;
-	if (inode->i_flags & S_APPEND)
+	if (IS_APPEND(inode))
 		perms->rootflags |= HFSPLUS_FLG_APPEND;
 	else
 		perms->rootflags &= ~HFSPLUS_FLG_APPEND;
--- linux-2.6.5cow/fs/hfsplus/dir.c~lock_flags	2004-04-14 16:22:15.000000000 +0200
+++ linux-2.6.5cow/fs/hfsplus/dir.c	2004-04-14 16:22:24.000000000 +0200
@@ -315,8 +315,11 @@
 		res = hfsplus_rename_cat(inode->i_ino,
 					 dir, &dentry->d_name,
 					 HFSPLUS_SB(sb).hidden_dir, &str);
-		if (!res)
+		if (!res) {
+			spin_lock(inode->i_lock);
 			inode->i_flags |= S_DEAD;
+			spin_unlock(inode->i_lock);
+		}
 		return res;
 	}
 	res = hfsplus_delete_cat(cnid, dir, &dentry->d_name);
@@ -330,8 +333,11 @@
 			res = hfsplus_delete_cat(inode->i_ino, HFSPLUS_SB(sb).hidden_dir, NULL);
 			if (!res)
 				hfsplus_delete_inode(inode);
-		} else
+		} else {
+			spin_lock(inode->i_lock);
 			inode->i_flags |= S_DEAD;
+			spin_unlock(inode->i_lock);
+		}
 	}
 	inode->i_ctime = CURRENT_TIME;
 	mark_inode_dirty(inode);
--- linux-2.6.5cow/fs/hfsplus/inode.c~lock_flags	2004-04-14 16:22:15.000000000 +0200
+++ linux-2.6.5cow/fs/hfsplus/inode.c	2004-04-20 16:20:21.000000000 +0200
@@ -225,6 +225,7 @@
 
 	HFSPLUS_I(inode).rootflags = perms->rootflags;
 	HFSPLUS_I(inode).userflags = perms->userflags;
+	spin_lock(inode->i_lock);
 	if (perms->rootflags & HFSPLUS_FLG_IMMUTABLE)
 		inode->i_flags |= S_IMMUTABLE;
 	else
@@ -233,10 +234,12 @@
 		inode->i_flags |= S_APPEND;
 	else
 		inode->i_flags &= ~S_APPEND;
+	spin_unlock(inode->i_lock);
 }
 
 static void hfsplus_set_perms(struct inode *inode, struct hfsplus_perm *perms)
 {
+	spin_lock(inode->i_lock);
 	if (inode->i_flags & S_IMMUTABLE)
 		perms->rootflags |= HFSPLUS_FLG_IMMUTABLE;
 	else
@@ -245,6 +248,7 @@
 		perms->rootflags |= HFSPLUS_FLG_APPEND;
 	else
 		perms->rootflags &= ~HFSPLUS_FLG_APPEND;
+	spin_unlock(inode->i_lock);
 	perms->userflags = HFSPLUS_I(inode).userflags;
 	perms->mode = cpu_to_be16(inode->i_mode);
 	perms->owner = cpu_to_be32(inode->i_uid);
@@ -285,7 +289,7 @@
 	if (atomic_dec_and_test(&HFSPLUS_I(inode).opencnt)) {
 		down(&inode->i_sem);
 		hfsplus_file_truncate(inode);
-		if (inode->i_flags & S_DEAD) {
+		if (IS_DEADDIR(inode)) {
 			hfsplus_delete_cat(inode->i_ino, HFSPLUS_SB(sb).hidden_dir, NULL);
 			hfsplus_delete_inode(inode);
 		}
--- linux-2.6.5cow/fs/hfsplus/ioctl.c~lock_flags	2004-04-14 16:22:15.000000000 +0200
+++ linux-2.6.5cow/fs/hfsplus/ioctl.c	2004-04-14 16:22:24.000000000 +0200
@@ -53,6 +53,7 @@
 			      EXT2_FLAG_NODUMP))
 			return -EOPNOTSUPP;
 
+		spin_lock(inode->i_lock);
 		if (flags & EXT2_FLAG_IMMUTABLE) { /* EXT2_IMMUTABLE_FL */
 			inode->i_flags |= S_IMMUTABLE;
 			HFSPLUS_I(inode).rootflags |= HFSPLUS_FLG_IMMUTABLE;
@@ -67,6 +68,7 @@
 			inode->i_flags &= ~S_APPEND;
 			HFSPLUS_I(inode).rootflags &= ~HFSPLUS_FLG_APPEND;
 		}
+		spin_unlock(inode->i_lock);
 		if (flags & EXT2_FLAG_NODUMP) /* EXT2_NODUMP_FL */
 			HFSPLUS_I(inode).userflags |= HFSPLUS_FLG_NODUMP;
 		else
--- linux-2.6.5cow/fs/smbfs/file.c~lock_flags	2004-04-14 16:22:15.000000000 +0200
+++ linux-2.6.5cow/fs/smbfs/file.c	2004-04-15 22:03:45.000000000 +0200
@@ -230,7 +230,7 @@
 
 	VERBOSE("before read, size=%ld, flags=%x, atime=%ld\n",
 		(long)dentry->d_inode->i_size,
-		dentry->d_inode->i_flags, dentry->d_inode->i_atime);
+		inode_flags(dentry->d_inode, -1U), dentry->d_inode->i_atime);
 
 	status = generic_file_read(file, buf, count, ppos);
 out:
--- linux-2.6.5cow/fs/afs/inode.c~lock_flags	2004-04-14 16:22:15.000000000 +0200
+++ linux-2.6.5cow/fs/afs/inode.c	2004-04-14 16:22:24.000000000 +0200
@@ -188,7 +188,9 @@
 #endif
 
 	/* okay... it's a new inode */
+	spin_lock(inode->i_lock);
 	inode->i_flags |= S_NOATIME;
+	spin_unlock(inode->i_lock);
 	vnode->flags |= AFS_VNODE_CHANGED;
 	ret = afs_inode_fetch_status(inode);
 	if (ret<0)
