Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbUCLRta (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 12:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262141AbUCLRta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 12:49:30 -0500
Received: from piglet.student.utwente.nl ([130.89.161.100]:20353 "EHLO
	piglet.student.utwente.nl") by vger.kernel.org with ESMTP
	id S261982AbUCLRtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 12:49:11 -0500
From: Sytse Wielinga <s.b.wielinga@student.utwente.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH for testing] cow behaviour for hard links
Date: Fri, 12 Mar 2004 18:48:57 +0100
User-Agent: KMail/1.6.1
References: <20040310193429.GB4589@wohnheim.fh-wedel.de>
In-Reply-To: <20040310193429.GB4589@wohnheim.fh-wedel.de>
Cc: =?iso-8859-1?q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_PgfUABM4iGZC5Sb"
Message-Id: <200403121849.03505.s.b.wielinga@student.utwente.nl>
X-Spam-Score: -4.9 (----)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_PgfUABM4iGZC5Sb
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I'm sorry to say this, but I stumbled upon a prohibitive problem...

The problem is that if a hard link would be broken up, one of the dentry's 
would get a link to a new inode with a new inode number. This would mean that 
right under the nose of the app, the file suddenly gets a new inode number. 
Apps don't like that. If anyone has any suggestion that might make this 
possible please say so, but I don't see it.

I have made some pretty thorough changes to your patch though. You can find 
the patch attached to this email.
Things I've changed:

 - moved break_cow_link from dentry_open in open.c to get_write_access in 
namei.c. Putting it in dentry_open thoroughly breaks things, as it's too late 
to save files from being truncated, for example.
 - made something from the mess you made of ext2/ext3 inode flags :-P
 - removed inheritance, as it's not useful in any way, not expected and breaks 
linking of files with S_COWLINK set.
 - made a go at supporting reiserfs, but failed... my changes are in the 
patch, could somebody please have a look and tell me what I've missed?
 - fcntl_setcow now spins a spinlock

Sytse

--Boundary-00=_PgfUABM4iGZC5Sb
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="cowlink.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cowlink.diff"

diff -rU 3 linux-2.6.4/fs/ext2/inode.c linux-2.6.4~cowlink/fs/ext2/inode.c
--- linux-2.6.4/fs/ext2/inode.c	2004-03-11 03:55:22.000000000 +0100
+++ linux-2.6.4~cowlink/fs/ext2/inode.c	2004-03-12 11:56:56.000000000 +0100
@@ -1135,6 +1135,9 @@
 	}
 	brelse (bh);
 	ext2_set_inode_flags(inode);
+	inode->i_flags &= ~S_COWLINK;
+	if (ei->i_flags & EXT2_COWLINK_FL)
+		inode->i_flags |= S_COWLINK;
 	return;
 	
 bad_inode:
@@ -1151,9 +1154,13 @@
 	gid_t gid = inode->i_gid;
 	struct buffer_head * bh;
 	struct ext2_inode * raw_inode = ext2_get_inode(sb, ino, &bh);
+	unsigned int flags = ei->i_flags & ~EXT2_COWLINK_FL;
 	int n;
 	int err = 0;
 
+	if (inode->i_flags & S_COWLINK)
+		flags |= EXT2_COWLINK_FL;
+
 	if (IS_ERR(raw_inode))
  		return -EIO;
 
@@ -1191,7 +1198,7 @@
 
 	raw_inode->i_blocks = cpu_to_le32(inode->i_blocks);
 	raw_inode->i_dtime = cpu_to_le32(ei->i_dtime);
-	raw_inode->i_flags = cpu_to_le32(ei->i_flags);
+	raw_inode->i_flags = cpu_to_le32(flags);
 	raw_inode->i_faddr = cpu_to_le32(ei->i_faddr);
 	raw_inode->i_frag = ei->i_frag_no;
 	raw_inode->i_fsize = ei->i_frag_size;
diff -rU 3 linux-2.6.4/fs/ext3/inode.c linux-2.6.4~cowlink/fs/ext3/inode.c
--- linux-2.6.4/fs/ext3/inode.c	2004-03-11 03:55:35.000000000 +0100
+++ linux-2.6.4~cowlink/fs/ext3/inode.c	2004-03-12 11:56:56.000000000 +0100
@@ -2569,6 +2569,9 @@
 	}
 	brelse (iloc.bh);
 	ext3_set_inode_flags(inode);
+	inode->i_flags &= ~S_COWLINK;
+	if (ei->i_flags & EXT3_COWLINK_FL)
+		inode->i_flags |= S_COWLINK;
 	return;
 
 bad_inode:
@@ -2590,8 +2593,12 @@
 	struct ext3_inode *raw_inode = ext3_raw_inode(iloc);
 	struct ext3_inode_info *ei = EXT3_I(inode);
 	struct buffer_head *bh = iloc->bh;
+	unsigned int flags = ei->i_flags & ~EXT3_COWLINK_FL;
 	int err = 0, rc, block;
 
+	if (inode->i_flags & S_COWLINK)
+		flags |= EXT3_COWLINK_FL;
+
 	/* For fields not not tracking in the in-memory inode,
 	 * initialise them to zero for new inodes. */
 	if (ei->i_state & EXT3_STATE_NEW)
@@ -2629,7 +2636,7 @@
 	raw_inode->i_mtime = cpu_to_le32(inode->i_mtime.tv_sec);
 	raw_inode->i_blocks = cpu_to_le32(inode->i_blocks);
 	raw_inode->i_dtime = cpu_to_le32(ei->i_dtime);
-	raw_inode->i_flags = cpu_to_le32(ei->i_flags);
+	raw_inode->i_flags = cpu_to_le32(flags);
 #ifdef EXT3_FRAGMENTS
 	raw_inode->i_faddr = cpu_to_le32(ei->i_faddr);
 	raw_inode->i_frag = ei->i_frag_no;
diff -rU 3 linux-2.6.4/fs/fcntl.c linux-2.6.4~cowlink/fs/fcntl.c
--- linux-2.6.4/fs/fcntl.c	2004-03-11 03:55:35.000000000 +0100
+++ linux-2.6.4~cowlink/fs/fcntl.c	2004-03-12 13:41:44.000000000 +0100
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
diff -rU 3 linux-2.6.4/fs/namei.c linux-2.6.4~cowlink/fs/namei.c
--- linux-2.6.4/fs/namei.c	2004-03-11 03:55:25.000000000 +0100
+++ linux-2.6.4~cowlink/fs/namei.c	2004-03-12 13:11:03.000000000 +0100
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
+	return -EPERM;
+}
+
+/*
  * get_write_access() gets write permission for a file.
  * put_write_access() releases this write permission.
  * This is used for regular files.
@@ -243,7 +270,15 @@
 
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
+
 	if (atomic_read(&inode->i_writecount) < 0) {
 		spin_unlock(&inode->i_lock);
 		return -ETXTBSY;
@@ -1522,6 +1557,7 @@
 	if (!error) {
 		inode_dir_notify(dir, DN_CREATE);
 		security_inode_post_mkdir(dir,dentry, mode);
+		dentry->d_inode->i_flags |= dir->i_flags & S_COWLINK;
 	}
 	return error;
 }
diff -rU 3 linux-2.6.4/fs/reiserfs/inode.c linux-2.6.4~cowlink/fs/reiserfs/inode.c
--- linux-2.6.4/fs/reiserfs/inode.c	2004-03-11 03:55:25.000000000 +0100
+++ linux-2.6.4~cowlink/fs/reiserfs/inode.c	2004-03-12 11:56:56.000000000 +0100
@@ -2303,6 +2303,10 @@
 			inode -> i_flags |= S_NOATIME;
 		else
 			inode -> i_flags &= ~S_NOATIME;
+		if( sd_attrs & REISERFS_COWLINK_FL )
+			inode -> i_flags |= S_COWLINK;
+		else
+			inode -> i_flags &= ~S_COWLINK;
 		if( sd_attrs & REISERFS_NOTAIL_FL )
 			REISERFS_I(inode)->i_flags |= i_nopack_mask;
 		else
@@ -2325,6 +2329,10 @@
 			*sd_attrs |= REISERFS_NOATIME_FL;
 		else
 			*sd_attrs &= ~REISERFS_NOATIME_FL;
+		if( inode -> i_flags & S_COWLINK )
+			*sd_attrs |= REISERFS_COWLINK_FL;
+		else
+			*sd_attrs &= ~REISERFS_COWLINK_FL;
 		if( REISERFS_I(inode)->i_flags & i_nopack_mask )
 			*sd_attrs |= REISERFS_NOTAIL_FL;
 		else
diff -rU 3 linux-2.6.4/include/linux/ext2_fs.h linux-2.6.4~cowlink/include/linux/ext2_fs.h
--- linux-2.6.4/include/linux/ext2_fs.h	2004-03-11 03:55:22.000000000 +0100
+++ linux-2.6.4~cowlink/include/linux/ext2_fs.h	2004-03-12 11:56:56.000000000 +0100
@@ -192,6 +192,7 @@
 #define EXT2_NOTAIL_FL			0x00008000 /* file tail should not be merged */
 #define EXT2_DIRSYNC_FL			0x00010000 /* dirsync behaviour (directories only) */
 #define EXT2_TOPDIR_FL			0x00020000 /* Top of directory hierarchies*/
+#define EXT2_COWLINK_FL			0x00040000 /* Copy On Write */
 #define EXT2_RESERVED_FL		0x80000000 /* reserved for ext2 lib */
 
 #define EXT2_FL_USER_VISIBLE		0x0003DFFF /* User visible flags */
diff -rU 3 linux-2.6.4/include/linux/ext3_fs.h linux-2.6.4~cowlink/include/linux/ext3_fs.h
--- linux-2.6.4/include/linux/ext3_fs.h	2004-03-11 03:55:33.000000000 +0100
+++ linux-2.6.4~cowlink/include/linux/ext3_fs.h	2004-03-12 11:56:56.000000000 +0100
@@ -185,6 +185,7 @@
 #define EXT3_NOTAIL_FL			0x00008000 /* file tail should not be merged */
 #define EXT3_DIRSYNC_FL			0x00010000 /* dirsync behaviour (directories only) */
 #define EXT3_TOPDIR_FL			0x00020000 /* Top of directory hierarchies*/
+#define EXT3_COWLINK_FL			0x00040000 /* Copy On Write */
 #define EXT3_RESERVED_FL		0x80000000 /* reserved for ext3 lib */
 
 #define EXT3_FL_USER_VISIBLE		0x0003DFFF /* User visible flags */
diff -rU 3 linux-2.6.4/include/linux/fcntl.h linux-2.6.4~cowlink/include/linux/fcntl.h
--- linux-2.6.4/include/linux/fcntl.h	2004-03-11 03:55:24.000000000 +0100
+++ linux-2.6.4~cowlink/include/linux/fcntl.h	2004-03-12 11:56:56.000000000 +0100
@@ -23,6 +23,9 @@
 #define DN_ATTRIB	0x00000020	/* File changed attibutes */
 #define DN_MULTISHOT	0x80000000	/* Don't remove notifier */
 
+#define F_SETCOW	(F_LINUX_SPECIFIC_BASE+3)
+#define F_GETCOW	(F_LINUX_SPECIFIC_BASE+4)
+
 #ifdef __KERNEL__
 
 #if BITS_PER_LONG == 32
diff -rU 3 linux-2.6.4/include/linux/fs.h linux-2.6.4~cowlink/include/linux/fs.h
--- linux-2.6.4/include/linux/fs.h	2004-03-11 03:55:24.000000000 +0100
+++ linux-2.6.4~cowlink/include/linux/fs.h	2004-03-12 13:34:49.000000000 +0100
@@ -137,6 +137,9 @@
 #define S_DEAD		32	/* removed, but still open directory */
 #define S_NOQUOTA	64	/* Inode is not counted to quota */
 #define S_DIRSYNC	128	/* Directory modifications are synchronous */
+#define S_COWLINK	512	/* Hard links have copy on write semantics.
+				 * This flag has no meaning for directories,
+				 * but is inherited to directory children */
 
 /*
  * Note that nosuid etc flags are inode-specific: setting some file-system
@@ -171,6 +174,8 @@
 
 #define IS_DEADDIR(inode)	((inode)->i_flags & S_DEAD)
 
+#define IS_COWLINK(inode)	((inode)->i_flags & S_COWLINK)
+
 /* the read-only stuff doesn't really belong here, but any other place is
    probably as bad and I don't want to create yet another include file. */
 
diff -rU 3 linux-2.6.4/include/linux/reiserfs_fs.h linux-2.6.4~cowlink/include/linux/reiserfs_fs.h
--- linux-2.6.4/include/linux/reiserfs_fs.h	2004-03-11 03:55:44.000000000 +0100
+++ linux-2.6.4~cowlink/include/linux/reiserfs_fs.h	2004-03-12 11:56:56.000000000 +0100
@@ -887,6 +887,12 @@
 #define REISERFS_UNRM_FL      EXT2_UNRM_FL
 #define REISERFS_COMPR_FL     EXT2_COMPR_FL
 #define REISERFS_NOTAIL_FL    EXT2_NOTAIL_FL
+/* TODO: Check how the inheriting of flags work, add this to the inherit mask,
+ * make this a special flag for ext2 too, instead of a special ioctl/flag, and
+ * add it to chattr/lsattr.
+ */
+/* This one is never going to be used in reiserfs 3... I hope */
+#define REISERFS_COWLINK_FL   EXT2_BTREE_FL /* Copy On Write */
 
 /* persistent flags that file inherits from the parent directory */
 #define REISERFS_INHERIT_MASK ( REISERFS_IMMUTABLE_FL |	\

--Boundary-00=_PgfUABM4iGZC5Sb--
