Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262786AbUCJTev (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 14:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262689AbUCJTev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 14:34:51 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:58568 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S262786AbUCJTea (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 14:34:30 -0500
Date: Wed, 10 Mar 2004 20:34:29 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH for testing] cow behaviour for hard links
Message-ID: <20040310193429.GB4589@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

<disclaimer>
This is ugly, unfinished and some may consider it pure evil.  So what!
</disclaimer>

Some month ago, I claimed that both filesystems and the buffer cache
should try to identify identical blocks, merge those to save space and
break them back up, when one copy gets written to - commonly known as
copy-on-write or cow.

Yeah, well, here it is, sortof.  It works on file granularity instead
of block, doesn't do the cow part inside the kernel (userspace get's
an error and has to do it).  But it works for ext2 and ext3 and is
relatively short.

Interna:
I introduced a new flag for inodes, switching between normal behaviour
and cow for hard links.  Flag can be changed and queried per fcntl().
Ext[23] needed a bit of tweaking to write this flag to disk.  open()
will fail, when a) cowlink flags is set, b) inode has more than one
link and c) write access is requested.

Worth some discussion is the directory stuff.  The flag has no meaning
per se for directories, but gets inherited to new files.  Also, when
moving or linking a non-cow file into a cow directory or vice versa,
this will fail.  Should it fail?  I don't know but it made some sense
to me.  If you have a good reason either way, please tell me.

So here it is, please flame now!

Jörn

-- 
Fantasy is more important than knowledge. Knowledge is limited,
while fantasy embraces the whole world.
-- Albert Einstein


 Makefile              |    2 +-
 fs/ext2/inode.c       |    3 ++-
 fs/ext3/inode.c       |    4 +++-
 fs/fcntl.c            |   18 ++++++++++++++++++
 fs/namei.c            |   32 ++++++++++++++++++++++++++++++++
 fs/open.c             |   29 +++++++++++++++++++++++++++++
 include/linux/fcntl.h |    3 +++
 include/linux/fs.h    |    3 +++
 8 files changed, 91 insertions(+), 3 deletions(-)

--- linux-2.6.1/Makefile~cowlink	2004-03-08 00:47:30.000000000 +0100
+++ linux-2.6.1/Makefile	2004-03-08 00:47:45.000000000 +0100
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 1
-EXTRAVERSION =
+EXTRAVERSION = moo
 
 # *DOCUMENTATION*
 # To see a list of typical targets execute "make help"
--- linux-2.6.1/include/linux/fcntl.h~cowlink	2004-03-08 00:47:30.000000000 +0100
+++ linux-2.6.1/include/linux/fcntl.h	2004-03-08 00:47:45.000000000 +0100
@@ -23,6 +23,9 @@
 #define DN_ATTRIB	0x00000020	/* File changed attibutes */
 #define DN_MULTISHOT	0x80000000	/* Don't remove notifier */
 
+#define F_SETCOW	(F_LINUX_SPECIFIC_BASE+3)
+#define F_GETCOW	(F_LINUX_SPECIFIC_BASE+4)
+
 #ifdef __KERNEL__
 
 #if BITS_PER_LONG == 32
--- linux-2.6.1/include/linux/fs.h~cowlink	2004-03-08 00:47:30.000000000 +0100
+++ linux-2.6.1/include/linux/fs.h	2004-03-08 00:47:45.000000000 +0100
@@ -137,6 +137,9 @@
 #define S_DEAD		32	/* removed, but still open directory */
 #define S_NOQUOTA	64	/* Inode is not counted to quota */
 #define S_DIRSYNC	128	/* Directory modifications are synchronous */
+#define S_COWLINK	256	/* Hard links have copy on write semantics.
+				 * This flag has no meaning for directories,
+				 * but is inherited to directory children */
 
 /*
  * Note that nosuid etc flags are inode-specific: setting some file-system
--- linux-2.6.1/fs/fcntl.c~cowlink	2004-03-08 00:47:30.000000000 +0100
+++ linux-2.6.1/fs/fcntl.c	2004-03-08 01:18:59.000000000 +0100
@@ -282,6 +282,17 @@
 
 EXPORT_SYMBOL(f_delown);
 
+static long fcntl_setcow(struct file *filp, unsigned long arg)
+{
+	struct inode *inode = filp->f_dentry->d_inode;
+	if (arg)
+		inode->i_flags |= S_COWLINK;
+	else
+		inode->i_flags &= ~S_COWLINK;
+	inode->i_sb->s_op->write_inode(inode, 0);
+	return 0;
+}
+
 static long do_fcntl(unsigned int fd, unsigned int cmd,
 		     unsigned long arg, struct file * filp)
 {
@@ -346,6 +357,13 @@
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
--- linux-2.6.1/fs/namei.c~cowlink	2004-03-08 00:47:30.000000000 +0100
+++ linux-2.6.1/fs/namei.c	2004-03-09 10:58:24.000000000 +0100
@@ -1141,6 +1141,8 @@
 	if (!error) {
 		inode_dir_notify(dir, DN_CREATE);
 		security_inode_post_create(dir, dentry, mode);
+		dentry->d_inode->i_flags |= dir->i_flags & S_COWLINK;
+		dentry->d_inode->i_sb->s_op->write_inode(dentry->d_inode, 0);
 	}
 	return error;
 }
@@ -1516,6 +1518,7 @@
 	if (!error) {
 		inode_dir_notify(dir, DN_CREATE);
 		security_inode_post_mkdir(dir,dentry, mode);
+		dentry->d_inode->i_flags |= dir->i_flags & S_COWLINK;
 	}
 	return error;
 }
@@ -1814,6 +1817,13 @@
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
@@ -1991,6 +2001,24 @@
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
@@ -2014,6 +2042,10 @@
 	if (!old_dir->i_op || !old_dir->i_op->rename)
 		return -EPERM;
 
+	error = cow_allow_rename(old_dir, old_dentry, new_dir);
+	if (error)
+		return error;
+
 	DQUOT_INIT(old_dir);
 	DQUOT_INIT(new_dir);
 
--- linux-2.6.1/fs/open.c~cowlink	2004-03-08 00:47:30.000000000 +0100
+++ linux-2.6.1/fs/open.c	2004-03-10 21:26:24.000000000 +0100
@@ -757,6 +757,33 @@
 
 EXPORT_SYMBOL(filp_open);
 
+/*
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
 struct file *dentry_open(struct dentry *dentry, struct vfsmount *mnt, int flags)
 {
 	struct file * f;
@@ -772,6 +799,8 @@
 	inode = dentry->d_inode;
 	if (f->f_mode & FMODE_WRITE) {
 		error = get_write_access(inode);
+		if (!error)
+			error = break_cow_link(inode);
 		if (error)
 			goto cleanup_file;
 	}
--- linux-2.6.1/fs/ext2/inode.c~cowlink	2004-03-08 00:47:30.000000000 +0100
+++ linux-2.6.1/fs/ext2/inode.c	2004-03-08 00:47:45.000000000 +0100
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
--- linux-2.6.1/fs/ext3/inode.c~cowlink	2004-03-08 00:47:30.000000000 +0100
+++ linux-2.6.1/fs/ext3/inode.c	2004-03-08 00:47:45.000000000 +0100
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
