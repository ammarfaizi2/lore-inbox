Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263247AbUCTIei (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 03:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263248AbUCTIei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 03:34:38 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:36019 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263247AbUCTIe3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 03:34:29 -0500
Date: Sat, 20 Mar 2004 09:34:11 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@digeo.com>, viro@parcelfarce.linux.theplanet.co.uk,
       Sytse Wielinga <s.b.wielinga@student.utwente.nl>
Subject: [PATCH] cowlinks v2
Message-ID: <20040320083411.GA25934@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Version 2 of my cowlink patch, tested and currently running on my
machine.

Al, I'd especially like your opinion on it.  Would you accept
something like this?

Changes since v1:
o moved break_cow_link() check to get_write_access()
o added inode locking when changing flags
o switched to mark_inode_dirty_sync()

TODO:
o Disallow fcntl() for filesystems without support
o Proper support for ext[23]
o Switch to mark_inode_dirty() without sync?
o Library support for
  o copyfile() (link and set cow-flag)
  o cow_open() (break link if open() fails)

Jörn

-- 
Premature optimization is the root of all evil.
-- Donald Knuth


 fs/ext2/inode.c       |    3 +-
 fs/ext3/inode.c       |    4 ++
 fs/fcntl.c            |   21 +++++++++++++++
 fs/namei.c            |   70 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fcntl.h |    3 ++
 include/linux/fs.h    |    3 ++
 6 files changed, 102 insertions(+), 2 deletions(-)

--- linux-2.6.4/include/linux/fcntl.h~cowlink	2004-03-19 17:38:48.000000000 +0100
+++ linux-2.6.4/include/linux/fcntl.h	2004-03-19 17:52:49.000000000 +0100
@@ -23,6 +23,9 @@
 #define DN_ATTRIB	0x00000020	/* File changed attibutes */
 #define DN_MULTISHOT	0x80000000	/* Don't remove notifier */
 
+#define F_SETCOW	(F_LINUX_SPECIFIC_BASE+3)
+#define F_GETCOW	(F_LINUX_SPECIFIC_BASE+4)
+
 #ifdef __KERNEL__
 
 #if BITS_PER_LONG == 32
--- linux-2.6.4/include/linux/fs.h~cowlink	2004-03-19 17:47:29.000000000 +0100
+++ linux-2.6.4/include/linux/fs.h	2004-03-19 17:52:49.000000000 +0100
@@ -137,6 +137,9 @@
 #define S_DEAD		32	/* removed, but still open directory */
 #define S_NOQUOTA	64	/* Inode is not counted to quota */
 #define S_DIRSYNC	128	/* Directory modifications are synchronous */
+#define S_COWLINK	256	/* Hard links have copy on write semantics.
+				 * This flag has no meaning for directories,
+				 * but is inherited to directory children */
 
 /*
  * Note that nosuid etc flags are inode-specific: setting some file-system
--- linux-2.6.4/fs/fcntl.c~cowlink	2004-03-19 17:47:15.000000000 +0100
+++ linux-2.6.4/fs/fcntl.c	2004-03-19 17:59:20.000000000 +0100
@@ -282,6 +282,20 @@
 
 EXPORT_SYMBOL(f_delown);
 
+static long fcntl_setcow(struct file *filp, unsigned long arg)
+{
+	struct inode *inode = filp->f_dentry->d_inode;
+
+	spin_lock(&inode->i_lock);
+	if (arg)
+		inode->i_flags |= S_COWLINK;
+	else
+		inode->i_flags &= ~S_COWLINK;
+	mark_inode_dirty_sync(inode);
+	spin_unlock(&inode->i_lock);
+	return 0;
+}
+
 static long do_fcntl(unsigned int fd, unsigned int cmd,
 		     unsigned long arg, struct file * filp)
 {
@@ -346,6 +360,13 @@
 		case F_NOTIFY:
 			err = fcntl_dirnotify(fd, filp, arg);
 			break;
+		case F_SETCOW:
+			err = fcntl_setcow(filp, arg);
+			break;
+		case F_GETCOW:
+			err = (filp->f_dentry->d_inode->i_flags & S_COWLINK) /
+				S_COWLINK;
+			break;
 		default:
 			break;
 	}
--- linux-2.6.4/fs/namei.c~cowlink	2004-03-19 17:47:19.000000000 +0100
+++ linux-2.6.4/fs/namei.c	2004-03-19 18:10:00.000000000 +0100
@@ -224,6 +224,33 @@
 }
 
 /*
+ * Files with the S_COWLINK flag set cannot be written to, if more
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
+static int break_cow_link(struct inode *inode)
+{
+	if (!(inode->i_flags & S_COWLINK))
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
+/*
  * get_write_access() gets write permission for a file.
  * put_write_access() releases this write permission.
  * This is used for regular files.
@@ -243,7 +270,14 @@
 
 int get_write_access(struct inode * inode)
 {
+	int error;
+
 	spin_lock(&inode->i_lock);
+	error = break_cow_link(inode);
+	if (error) {
+		spin_unlock(&inode->i_lock);
+		return error;
+	}
 	if (atomic_read(&inode->i_writecount) < 0) {
 		spin_unlock(&inode->i_lock);
 		return -ETXTBSY;
@@ -1148,6 +1182,10 @@
 	if (!error) {
 		inode_dir_notify(dir, DN_CREATE);
 		security_inode_post_create(dir, dentry, mode);
+		spin_lock(&inode->i_lock);
+		dentry->d_inode->i_flags |= dir->i_flags & S_COWLINK;
+		mark_inode_dirty_sync(inode);
+		spin_unlock(&inode->i_lock);
 	}
 	return error;
 }
@@ -1522,6 +1560,9 @@
 	if (!error) {
 		inode_dir_notify(dir, DN_CREATE);
 		security_inode_post_mkdir(dir,dentry, mode);
+		spin_lock(&inode->i_lock);
+		dentry->d_inode->i_flags |= dir->i_flags & S_COWLINK;
+		spin_unlock(&inode->i_lock);
 	}
 	return error;
 }
@@ -1820,6 +1861,13 @@
 		return -EXDEV;
 
 	/*
+	 * Cowlink attribute is inherited from directory, but here,
+	 * the inode already has one.  If they don't match, bail out.
+	 */
+	if ((dir->i_flags ^ old_dentry->d_inode->i_flags) & S_COWLINK)
+		return -EMLINK;
+
+	/*
 	 * A link to an append-only or immutable file cannot be created.
 	 */
 	if (IS_APPEND(inode) || IS_IMMUTABLE(inode))
@@ -1997,6 +2045,24 @@
 	return error;
 }
 
+static int cow_allow_rename(struct inode *old_dir, struct dentry *old_dentry,
+			    struct inode *new_dir)
+{
+	/* source and target share directory: allow */
+	if (old_dir == new_dir)
+		return 0;
+	/* source and target directory have identical cowlink flag: allow */
+	if (! ((old_dentry->d_inode->i_flags ^ new_dir->i_flags) & S_COWLINK))
+		return 0;
+	/* We could always fail here, but cowlink flag is only defined for
+	 * files and directories, so let's allow special files */
+	if (!S_ISREG(old_dentry->d_inode->i_mode))
+		return -EMLINK;
+	if (!S_ISDIR(old_dentry->d_inode->i_mode))
+		return -EMLINK;
+	return 0;
+}
+
 int vfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	       struct inode *new_dir, struct dentry *new_dentry)
 {
@@ -2020,6 +2086,10 @@
 	if (!old_dir->i_op || !old_dir->i_op->rename)
 		return -EPERM;
 
+	error = cow_allow_rename(old_dir, old_dentry, new_dir);
+	if (error)
+		return error;
+
 	DQUOT_INIT(old_dir);
 	DQUOT_INIT(new_dir);
 
--- linux-2.6.4/fs/ext2/inode.c~cowlink	2004-03-19 17:44:02.000000000 +0100
+++ linux-2.6.4/fs/ext2/inode.c	2004-03-19 17:52:49.000000000 +0100
@@ -1020,6 +1020,7 @@
 {
 	unsigned int flags = EXT2_I(inode)->i_flags;
 
+	inode->i_flags  = flags;
 	inode->i_flags &= ~(S_SYNC|S_APPEND|S_IMMUTABLE|S_NOATIME|S_DIRSYNC);
 	if (flags & EXT2_SYNC_FL)
 		inode->i_flags |= S_SYNC;
@@ -1191,7 +1192,7 @@
 
 	raw_inode->i_blocks = cpu_to_le32(inode->i_blocks);
 	raw_inode->i_dtime = cpu_to_le32(ei->i_dtime);
-	raw_inode->i_flags = cpu_to_le32(ei->i_flags);
+	raw_inode->i_flags = cpu_to_le32(inode->i_flags);
 	raw_inode->i_faddr = cpu_to_le32(ei->i_faddr);
 	raw_inode->i_frag = ei->i_frag_no;
 	raw_inode->i_fsize = ei->i_frag_size;
--- linux-2.6.4/fs/ext3/inode.c~cowlink	2004-03-19 17:44:02.000000000 +0100
+++ linux-2.6.4/fs/ext3/inode.c	2004-03-19 17:52:49.000000000 +0100
@@ -2447,6 +2447,7 @@
 {
 	unsigned int flags = EXT3_I(inode)->i_flags;
 
+	inode->i_flags  = flags;
 	inode->i_flags &= ~(S_SYNC|S_APPEND|S_IMMUTABLE|S_NOATIME|S_DIRSYNC);
 	if (flags & EXT3_SYNC_FL)
 		inode->i_flags |= S_SYNC;
@@ -2629,7 +2630,8 @@
 	raw_inode->i_mtime = cpu_to_le32(inode->i_mtime.tv_sec);
 	raw_inode->i_blocks = cpu_to_le32(inode->i_blocks);
 	raw_inode->i_dtime = cpu_to_le32(ei->i_dtime);
-	raw_inode->i_flags = cpu_to_le32(ei->i_flags);
+	raw_inode->i_flags = cpu_to_le32((ei->i_flags & ~S_COWLINK) |
+					 (inode->i_flags & S_COWLINK));
 #ifdef EXT3_FRAGMENTS
 	raw_inode->i_faddr = cpu_to_le32(ei->i_faddr);
 	raw_inode->i_frag = ei->i_frag_no;
