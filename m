Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262194AbUEFN1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbUEFN1T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 09:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262215AbUEFNZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 09:25:57 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:51891 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S262194AbUEFNVB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 09:21:01 -0400
Date: Thu, 6 May 2004 15:21:05 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH COW] MAD COW
Message-ID: <20040506132105.GF7930@wohnheim.fh-wedel.de>
References: <20040506131731.GA7930@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040506131731.GA7930@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 5

Jörn

-- 
A victorious army first wins and then seeks battle.
-- Sun Tzu

Allow COW behaviour for hard links, depending on an inode flag.

Semantics:
o Files with S_COWLINK do cow. (yes, really ;)
o Directories with S_COWLINK inherit flag to new files.
o If in doubt, return -EMLINK and let the user sort it out:
  - When linking non-cow files to cow directories.
  - When moving non-cow files/directories to cow directories.
  - When moving cow files/directories to non-cow directories.

Thanks to Sytse and Andrew for tips.

 fs/ext2/inode.c         |   11 ++++++
 fs/ext2/super.c         |    2 -
 fs/ext3/inode.c         |   11 ++++++
 fs/ext3/super.c         |    2 -
 fs/fcntl.c              |   24 ++++++++++++++
 fs/namei.c              |   76 +++++++++++++++++++++++++++++++++++++++++++++-
 fs/open.c               |   79 +++++++++++++++++++++++++++++++++++++++++++++---
 include/linux/ext2_fs.h |    1 
 include/linux/ext3_fs.h |    1 
 include/linux/fcntl.h   |    3 +
 include/linux/fs.h      |    4 ++
 11 files changed, 205 insertions(+), 9 deletions(-)


--- linux-2.6.5cow/fs/open.c~break_madcow	2004-05-04 16:31:50.000000000 +0200
+++ linux-2.6.5cow/fs/open.c	2004-05-06 01:02:57.000000000 +0200
@@ -723,6 +723,71 @@
 	return error;
 }
 
+char *index(const char *s, int c)
+{
+	while (*s) {
+		if (*s == c)
+			return (char *) s;
+		s++;
+	}
+	return NULL;
+}
+
+char *rindex(const char *s, int c)
+{
+	char *ret = NULL;
+	while (*s) {
+		if (*s == c)
+			ret = (char *) s;
+		s++;
+	}
+	return ret;
+}
+
+char *madcow_temp_name(const char *name)
+{
+	const char temp[] = "__MADCOW_BREAK_LINK"; /* FIXME: add random part */
+	char *last_slash = rindex(name, '/');
+	size_t dir_len = last_slash ? last_slash + 1 - name : 0;
+	size_t len = sizeof(temp) + dir_len;
+	char *ret;
+
+	ret = kmalloc(len, GFP_KERNEL);
+	if (!ret)
+		return NULL;
+
+	strncpy(ret, name, dir_len);
+	strcpy(ret+dir_len, temp);
+	return ret;
+}
+
+int vfs_rename_other(struct inode *, struct dentry *,
+		struct inode *, struct dentry *);
+int do_copyfile(const char *from, const char *to, int mode);
+int do_rename(const char * oldname, const char * newname);
+
+int madcow_break_link(const char *from)
+{
+	int err, ret = -EMLINK;
+	char *to = madcow_temp_name(from);
+
+	printk("break link '%s' -> '%s'\n", from, to);
+	err = do_copyfile(from, to, -1);
+	printk("do_copyfile returned %d\n", err);
+	if (err)
+		goto out;
+
+	err = do_rename(to, from);
+	printk("do_rename returned %d\n", err);
+	if (err)
+		goto out;
+
+	ret = 0;
+out:
+	kfree(to);
+	return ret;
+}
+
 /*
  * Note that while the flag value (low two bits) for sys_open means:
  *	00 - read-only
@@ -746,13 +811,19 @@
 	if ((namei_flags+1) & O_ACCMODE)
 		namei_flags++;
 	if (namei_flags & O_TRUNC)
-		namei_flags |= 2;
+		namei_flags |= FMODE_WRITE;
 
 	error = open_namei(filename, namei_flags, mode, &nd);
-	if (!error)
-		return dentry_open(nd.dentry, nd.mnt, flags);
 
-	return ERR_PTR(error);
+	if (error == -EMLINK) {
+		error = madcow_break_link(filename);
+		if (!error) /*retry*/
+			error = open_namei(filename, namei_flags, mode, &nd);
+	}
+	if (error)
+		return ERR_PTR(error);
+
+	return dentry_open(nd.dentry, nd.mnt, flags);
 }
 
 EXPORT_SYMBOL(filp_open);
--- linux-2.6.5cow/fs/ext2/inode.c~madcow	2004-04-27 16:48:55.000000000 +0200
+++ linux-2.6.5cow/fs/ext2/inode.c	2004-04-27 17:02:33.000000000 +0200
@@ -1021,7 +1021,8 @@
 	unsigned int flags = EXT2_I(inode)->i_flags;
 
 	spin_lock(inode->i_lock);
-	inode->i_flags &= ~(S_SYNC|S_APPEND|S_IMMUTABLE|S_NOATIME|S_DIRSYNC);
+	inode->i_flags &= ~(S_SYNC | S_APPEND | S_IMMUTABLE | S_NOATIME
+			| S_DIRSYNC | S_MADCOWLINK);
 	if (flags & EXT2_SYNC_FL)
 		inode->i_flags |= S_SYNC;
 	if (flags & EXT2_APPEND_FL)
@@ -1032,6 +1033,8 @@
 		inode->i_flags |= S_NOATIME;
 	if (flags & EXT2_DIRSYNC_FL)
 		inode->i_flags |= S_DIRSYNC;
+	if (flags & EXT2_MADCOWLINK_FL)
+		inode->i_flags |= S_MADCOWLINK;
 	spin_unlock(inode->i_lock);
 }
 
@@ -1159,6 +1162,12 @@
 	if (IS_ERR(raw_inode))
  		return -EIO;
 
+	/* vfs inode holds the current MADCOWLINK flag, so we have to update
+	 * ei->i_flags first */
+	ei->i_flags &= ~EXT2_MADCOWLINK_FL;
+	if (inode_flags(inode, S_MADCOWLINK))
+		ei->i_flags |= EXT2_MADCOWLINK_FL;
+
 	/* For fields not not tracking in the in-memory inode,
 	 * initialise them to zero for new inodes. */
 	if (ei->i_state & EXT2_STATE_NEW)
--- linux-2.6.5cow/fs/ext2/super.c~madcow	2004-04-27 16:34:42.000000000 +0200
+++ linux-2.6.5cow/fs/ext2/super.c	2004-04-27 17:03:10.000000000 +0200
@@ -1015,7 +1015,7 @@
 	.name		= "ext2",
 	.get_sb		= ext2_get_sb,
 	.kill_sb	= kill_block_super,
-	.fs_flags	= FS_REQUIRES_DEV,
+	.fs_flags	= FS_REQUIRES_DEV | FS_MADCOW,
 };
 
 static int __init init_ext2_fs(void)
--- linux-2.6.5cow/fs/ext3/inode.c~madcow	2004-04-27 16:48:55.000000000 +0200
+++ linux-2.6.5cow/fs/ext3/inode.c	2004-04-27 17:04:41.000000000 +0200
@@ -2448,7 +2448,8 @@
 	unsigned int flags = EXT3_I(inode)->i_flags;
 
 	spin_lock(inode->i_lock);
-	inode->i_flags &= ~(S_SYNC|S_APPEND|S_IMMUTABLE|S_NOATIME|S_DIRSYNC);
+	inode->i_flags &= ~(S_SYNC | S_APPEND | S_IMMUTABLE | S_NOATIME
+			| S_DIRSYNC | S_MADCOWLINK);
 	if (flags & EXT3_SYNC_FL)
 		inode->i_flags |= S_SYNC;
 	if (flags & EXT3_APPEND_FL)
@@ -2459,6 +2460,8 @@
 		inode->i_flags |= S_NOATIME;
 	if (flags & EXT3_DIRSYNC_FL)
 		inode->i_flags |= S_DIRSYNC;
+	if (flags & EXT3_MADCOWLINK_FL)
+		inode->i_flags |= S_MADCOWLINK;
 	spin_unlock(inode->i_lock);
 }
 
@@ -2594,6 +2597,12 @@
 	struct buffer_head *bh = iloc->bh;
 	int err = 0, rc, block;
 
+	/* vfs inode holds the current MADCOWLINK flag, so we have to update
+	 * ei->i_flags first */
+	ei->i_flags &= ~EXT3_MADCOWLINK_FL;
+	if (inode_flags(inode, S_MADCOWLINK))
+		ei->i_flags |= EXT3_MADCOWLINK_FL;
+
 	/* For fields not not tracking in the in-memory inode,
 	 * initialise them to zero for new inodes. */
 	if (ei->i_state & EXT3_STATE_NEW)
--- linux-2.6.5cow/fs/ext3/super.c~madcow	2004-04-27 16:34:42.000000000 +0200
+++ linux-2.6.5cow/fs/ext3/super.c	2004-04-27 17:05:22.000000000 +0200
@@ -2004,7 +2004,7 @@
 	.name		= "ext3",
 	.get_sb		= ext3_get_sb,
 	.kill_sb	= kill_block_super,
-	.fs_flags	= FS_REQUIRES_DEV,
+	.fs_flags	= FS_REQUIRES_DEV | FS_MADCOW,
 };
 
 static int __init init_ext3_fs(void)
--- linux-2.6.5cow/fs/fcntl.c~madcow	2004-04-27 16:34:42.000000000 +0200
+++ linux-2.6.5cow/fs/fcntl.c	2004-04-27 16:55:42.000000000 +0200
@@ -282,6 +282,24 @@
 
 EXPORT_SYMBOL(f_delown);
 
+static long fcntl_setmadcow(struct file *filp, unsigned long arg)
+{
+	struct inode *inode = filp->f_dentry->d_inode;
+
+	if (!(inode->i_sb->s_type->fs_flags & FS_MADCOW))
+		return -EINVAL;
+	//FIXME: -EPERM?
+
+	spin_lock(&inode->i_lock);
+	if (arg)
+		inode->i_flags |= S_MADCOWLINK;
+	else
+		inode->i_flags &= ~S_MADCOWLINK;
+	spin_unlock(&inode->i_lock);
+	mark_inode_dirty(inode);
+	return 0;
+}
+
 static long do_fcntl(unsigned int fd, unsigned int cmd,
 		     unsigned long arg, struct file * filp)
 {
@@ -346,6 +364,12 @@
 		case F_NOTIFY:
 			err = fcntl_dirnotify(fd, filp, arg);
 			break;
+		case F_SETMADCOW:
+			err = fcntl_setmadcow(filp, arg);
+			break;
+		case F_GETMADCOW:
+			err = !!inode_flags(filp->f_dentry->d_inode, S_MADCOWLINK);
+			break;
 		default:
 			break;
 	}
--- linux-2.6.5cow/fs/namei.c~madcow	2004-04-27 16:48:55.000000000 +0200
+++ linux-2.6.5cow/fs/namei.c	2004-05-02 15:07:57.000000000 +0200
@@ -223,6 +223,41 @@
 	return security_inode_permission(inode, mask, nd);
 }
 
+static inline void set_madcowflag(struct inode *inode)
+{
+	spin_lock(&inode->i_lock);
+	inode->i_flags |= S_MADCOWLINK;
+	spin_unlock(&inode->i_lock);
+	mark_inode_dirty(inode);
+}
+
+/*
+ * Files with the S_MADCOWLINK flag set cannot be written to, if more
+ * than one hard link to them exists.  Ultimately, this function
+ * should copy the inode, assign the copy to the dentry and lower use
+ * count of the old inode - one day.
+ * For now, it is sufficient to return an error and let userspace
+ * deal with the messy part.  Not exactly the meaning of
+ * copy-on-write, but much better than writing to fifty files at once
+ * and noticing month later.
+ *
+ * Yes, this breaks the kernel interface and is simply wrong.  This
+ * is intended behaviour, so Linus will not merge the code before
+ * it is complete.  Or will he?
+ */
+static int break_madcow_link(struct inode *inode)
+{
+	if (!inode_flags(inode, S_MADCOWLINK))
+		return 0;
+	if (!S_ISREG(inode->i_mode))
+		return 0;
+	if (inode->i_nlink < 2)
+		return 0;
+	/* TODO: As soon as sendfile can do normal file copies, use that
+	 * and always return 0 */
+	return -EMLINK;
+}
+
 /*
  * get_write_access() gets write permission for a file.
  * put_write_access() releases this write permission.
@@ -243,6 +278,10 @@
 
 int get_write_access(struct inode * inode)
 {
+	int error = break_madcow_link(inode);
+	if (error)
+		return error;
+
 	spin_lock(&inode->i_lock);
 	if (atomic_read(&inode->i_writecount) < 0) {
 		spin_unlock(&inode->i_lock);
@@ -1146,6 +1185,8 @@
 	DQUOT_INIT(dir);
 	error = dir->i_op->create(dir, dentry, mode, nd);
 	if (!error) {
+		if (inode_flags(dir, S_MADCOWLINK))
+			set_madcowflag(dentry->d_inode);
 		inode_dir_notify(dir, DN_CREATE);
 		security_inode_post_create(dir, dentry, mode);
 	}
@@ -1520,6 +1561,8 @@
 	DQUOT_INIT(dir);
 	error = dir->i_op->mkdir(dir, dentry, mode);
 	if (!error) {
+		if (inode_flags(dir, S_MADCOWLINK))
+			set_madcowflag(dentry->d_inode);
 		inode_dir_notify(dir, DN_CREATE);
 		security_inode_post_mkdir(dir,dentry, mode);
 	}
@@ -1823,6 +1866,13 @@
 		return -EXDEV;
 
 	/*
+	 * Madcowlink attribute is inherited from directory, but here,
+	 * the inode already has one.  If they don't match, bail out.
+	 */
+	if (inode_flags(dir, S_MADCOWLINK) != inode_flags(inode, S_MADCOWLINK))
+		return -EMLINK;
+
+	/*
 	 * A link to an append-only or immutable file cannot be created.
 	 */
 	if (IS_APPEND(inode) || IS_IMMUTABLE(inode))
@@ -2003,6 +2053,26 @@
 	return error;
 }
 
+static int madcow_allow_rename(struct inode *old_dir, struct dentry *old_dentry,
+			       struct inode *new_dir)
+{
+	struct inode *old_inode = old_dentry->d_inode;
+
+	/* source and target share directory: allow */
+	if (old_dir == new_dir)
+		return 0;
+	/* source and target directory have identical madcowlink flag: allow */
+	if (inode_flags(old_inode, S_MADCOWLINK) == inode_flags(new_dir, S_MADCOWLINK))
+		return 0;
+	/* We could always fail here, but madcowlink flag is only defined for
+	 * files and directories, so let's allow special files */
+	if (!S_ISREG(old_inode->i_mode))
+		return -EMLINK;
+	if (!S_ISDIR(old_inode->i_mode))
+		return -EMLINK;
+	return 0;
+}
+
 int vfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	       struct inode *new_dir, struct dentry *new_dentry)
 {
@@ -2026,6 +2096,10 @@
 	if (!old_dir->i_op || !old_dir->i_op->rename)
 		return -EPERM;
 
+	error = madcow_allow_rename(old_dir, old_dentry, new_dir);
+	if (error)
+		return error;
+
 	DQUOT_INIT(old_dir);
 	DQUOT_INIT(new_dir);
 
@@ -2118,7 +2118,7 @@
 	return error;
 }
 
-static inline int do_rename(const char * oldname, const char * newname)
+int do_rename(const char * oldname, const char * newname)
 {
 	int error = 0;
 	struct dentry * old_dir, * new_dir;
--- linux-2.6.5cow/include/linux/ext2_fs.h~madcow	2004-04-27 16:34:42.000000000 +0200
+++ linux-2.6.5cow/include/linux/ext2_fs.h	2004-04-27 17:01:30.000000000 +0200
@@ -192,6 +192,7 @@
 #define EXT2_NOTAIL_FL			0x00008000 /* file tail should not be merged */
 #define EXT2_DIRSYNC_FL			0x00010000 /* dirsync behaviour (directories only) */
 #define EXT2_TOPDIR_FL			0x00020000 /* Top of directory hierarchies*/
+#define EXT2_MADCOWLINK_FL		0x00040000 /* COW behaviour for hard links */
 #define EXT2_RESERVED_FL		0x80000000 /* reserved for ext2 lib */
 
 #define EXT2_FL_USER_VISIBLE		0x0003DFFF /* User visible flags */
--- linux-2.6.5cow/include/linux/ext3_fs.h~madcow	2004-04-27 16:34:42.000000000 +0200
+++ linux-2.6.5cow/include/linux/ext3_fs.h	2004-04-27 17:03:46.000000000 +0200
@@ -185,6 +185,7 @@
 #define EXT3_NOTAIL_FL			0x00008000 /* file tail should not be merged */
 #define EXT3_DIRSYNC_FL			0x00010000 /* dirsync behaviour (directories only) */
 #define EXT3_TOPDIR_FL			0x00020000 /* Top of directory hierarchies*/
+#define EXT3_MADCOWLINK_FL		0x00040000 /* COW behaviour for hard links */
 #define EXT3_RESERVED_FL		0x80000000 /* reserved for ext3 lib */
 
 #define EXT3_FL_USER_VISIBLE		0x0003DFFF /* User visible flags */
--- linux-2.6.5cow/include/linux/fcntl.h~madcow	2004-04-27 16:34:42.000000000 +0200
+++ linux-2.6.5cow/include/linux/fcntl.h	2004-04-27 16:49:45.000000000 +0200
@@ -23,6 +23,9 @@
 #define DN_ATTRIB	0x00000020	/* File changed attibutes */
 #define DN_MULTISHOT	0x80000000	/* Don't remove notifier */
 
+#define F_SETMADCOW	(F_LINUX_SPECIFIC_BASE+3)
+#define F_GETMADCOW	(F_LINUX_SPECIFIC_BASE+4)
+
 #ifdef __KERNEL__
 
 #if BITS_PER_LONG == 32
--- linux-2.6.5cow/include/linux/fs.h~madcow	2004-04-27 16:48:55.000000000 +0200
+++ linux-2.6.5cow/include/linux/fs.h	2004-04-30 08:40:04.000000000 +0200
@@ -90,6 +90,7 @@
 /* public flags for file_system_type */
 #define FS_REQUIRES_DEV 1 
 #define FS_BINARY_MOUNTDATA 2
+#define FS_MADCOW	4
 #define FS_REVAL_DOT	16384	/* Check the paths ".", ".." for staleness */
 #define FS_ODD_RENAME	32768	/* Temporary stuff; will go away as soon
 				  * as nfs_rename() will be cleaned up
@@ -139,6 +140,9 @@
 #define S_NOQUOTA	64	/* Inode is not counted to quota */
 #define S_DIRSYNC	128	/* Directory modifications are synchronous */
 #define S_NOCMTIME	256	/* Do not update file c/mtime */
+#define S_MADCOWLINK	512	/* Hard links have copy on write semantics.
+				 * This flag has no meaning for directories,
+				 * but is inherited to directory children */
 
 /*
  * Note that nosuid etc flags are inode-specific: setting some file-system
