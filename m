Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261780AbVACU6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbVACU6S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 15:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbVACU6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 15:58:18 -0500
Received: from terminus.zytor.com ([209.128.68.124]:33692 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261780AbVACU5z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 15:57:55 -0500
Message-ID: <41D9B1C4.5050507@zytor.com>
Date: Mon, 03 Jan 2005 12:57:40 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] get/set FAT filesystem attribute bits
Content-Type: multipart/mixed;
 boundary="------------070008010706050706090605"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070008010706050706090605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds a set of ioctls to get and set the FAT filesystem native 
attribute bits, including the unused bits (6 and 7.)

It also includes some very minor code cleanups; mostly by macroizing a 
few idioms.

	-hpa

Signed-Off-By: H. Peter Anvin <hpa@zytor.com>

--------------070008010706050706090605
Content-Type: text/x-patch;
 name="fat-filesystem-attributes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fat-filesystem-attributes.patch"

Index: linux-2.5/fs/fat/dir.c
===================================================================
RCS file: /home/hpa/kernel/bkcvs/linux-2.5/fs/fat/dir.c,v
retrieving revision 1.28
diff -u -r1.28 dir.c
--- linux-2.5/fs/fat/dir.c	1 Nov 2004 00:18:37 -0000	1.28
+++ linux-2.5/fs/fat/dir.c	3 Jan 2005 15:06:16 -0000
@@ -663,7 +663,7 @@
 		both = 1;
 		break;
 	default:
-		return -EINVAL;
+		return fat_generic_ioctl(inode, filp, cmd, arg);
 	}
 
 	d1 = (struct dirent __user *)arg;
Index: linux-2.5/fs/fat/file.c
===================================================================
RCS file: /home/hpa/kernel/bkcvs/linux-2.5/fs/fat/file.c,v
retrieving revision 1.26
diff -u -r1.26 file.c
--- linux-2.5/fs/fat/file.c	24 Aug 2004 18:43:21 -0000	1.26
+++ linux-2.5/fs/fat/file.c	3 Jan 2005 15:06:41 -0000
@@ -19,6 +19,7 @@
 	.read		= generic_file_read,
 	.write		= fat_file_write,
 	.mmap		= generic_file_mmap,
+	.ioctl		= fat_generic_ioctl,
 	.fsync		= file_fsync,
 	.readv		= generic_file_readv,
 	.writev		= generic_file_writev,
Index: linux-2.5/fs/fat/inode.c
===================================================================
RCS file: /home/hpa/kernel/bkcvs/linux-2.5/fs/fat/inode.c,v
retrieving revision 1.108
diff -u -r1.108 inode.c
--- linux-2.5/fs/fat/inode.c	20 Oct 2004 15:16:56 -0000	1.108
+++ linux-2.5/fs/fat/inode.c	3 Jan 2005 20:50:25 -0000
@@ -562,7 +562,6 @@
 	MSDOS_I(inode)->i_attrs = 0;
 	inode->i_mtime.tv_sec = inode->i_atime.tv_sec = inode->i_ctime.tv_sec = 0;
 	inode->i_mtime.tv_nsec = inode->i_atime.tv_nsec = inode->i_ctime.tv_nsec = 0;
-	MSDOS_I(inode)->i_ctime_ms = 0;
 	inode->i_nlink = fat_subdirs(inode)+2;
 
 	return 0;
@@ -1218,8 +1217,7 @@
 		MSDOS_SB(sb)->options.isvfat
 		? date_dos2unix(le16_to_cpu(de->ctime), le16_to_cpu(de->cdate))
 		: inode->i_mtime.tv_sec;
-	inode->i_ctime.tv_nsec = de->ctime_ms * 1000000;
-	MSDOS_I(inode)->i_ctime_ms = de->ctime_ms;
+	inode->i_ctime.tv_nsec = de->ctime_ms * 1000000U;
 
 	return 0;
 }
@@ -1255,21 +1253,18 @@
 	raw_entry = &((struct msdos_dir_entry *) (bh->b_data))
 	    [i_pos & (sbi->dir_per_block - 1)];
 	if (S_ISDIR(inode->i_mode)) {
-		raw_entry->attr = ATTR_DIR;
 		raw_entry->size = 0;
 	}
 	else {
-		raw_entry->attr = ATTR_NONE;
 		raw_entry->size = cpu_to_le32(inode->i_size);
 	}
-	raw_entry->attr |= MSDOS_MKATTR(inode->i_mode) |
-	    MSDOS_I(inode)->i_attrs;
+	raw_entry->attr = msdos_attr(inode);
 	raw_entry->start = cpu_to_le16(MSDOS_I(inode)->i_logstart);
 	raw_entry->starthi = cpu_to_le16(MSDOS_I(inode)->i_logstart >> 16);
 	fat_date_unix2dos(inode->i_mtime.tv_sec, &raw_entry->time, &raw_entry->date);
 	if (sbi->options.isvfat) {
 		fat_date_unix2dos(inode->i_ctime.tv_sec,&raw_entry->ctime,&raw_entry->cdate);
-		raw_entry->ctime_ms = MSDOS_I(inode)->i_ctime_ms; /* use i_ctime.tv_nsec? */
+		raw_entry->ctime_ms = inode->i_ctime.tv_nsec / 1000000U;
 	}
 	spin_unlock(&sbi->inode_hash_lock);
 	mark_buffer_dirty(bh);
@@ -1328,4 +1323,105 @@
 	unlock_kernel();
 	return error;
 }
+
+int fat_generic_ioctl(struct inode * inode, struct file * filp,
+		      unsigned int cmd, unsigned long arg)
+{
+	struct super_block *sb = inode->i_sb;
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+
+	switch (cmd) {
+	case FAT_IOCTL_GET_ATTRIBUTES:
+	{
+		u8 attr;
+		
+		/* msdos_attr() isn't atomic */
+		down(&inode->i_sem);
+
+		if ( inode->i_ino == MSDOS_ROOT_INO )
+			attr = ATTR_DIR;
+		else
+			attr = msdos_attr(inode);
+
+		up(&inode->i_sem);
+
+		return put_user(attr, (u8 __user *)arg);
+	}
+	case FAT_IOCTL_SET_ATTRIBUTES:
+	{
+		u8 attr, oldattr;
+		int err;
+		int is_dir;
+		struct iattr ia;
+
+		if ( (err = get_user(attr, (u8 __user *)arg)) )
+			return err;
+
+		if (IS_RDONLY(inode))
+			return -EROFS;
+
+		/* ATTR_VOLUME and ATTR_DIR cannot be changed; this also
+		   prevents the user from turning us into a VFAT
+		   longname entry. */
+		attr &= ~(ATTR_VOLUME|ATTR_DIR);
+
+		down(&inode->i_sem);
+
+		/* This is equivalent to an fchmod */
+		ia.ia_valid = ATTR_MODE|ATTR_CTIME;
+		ia.ia_ctime = CURRENT_TIME;
+
+		is_dir = S_ISDIR(inode->i_mode);
+
+		/* Merge in ATTR_VOLUME and ATTR_DIR */
+		attr |= (MSDOS_I(inode)->i_attrs & ATTR_VOLUME) |
+			(is_dir ? ATTR_DIR : 0);
+
+		if (is_dir) {
+			ia.ia_mode = MSDOS_MKMODE(attr,
+				S_IRWXUGO & ~sbi->options.fs_dmask)
+				| S_IFDIR;
+		} else {
+			ia.ia_mode = MSDOS_MKMODE(attr,
+				(S_IRUGO|S_IWUGO|(inode->i_mode & S_IXUGO))
+				& ~sbi->options.fs_fmask)
+				| S_IFREG;
+		}
+
+		if ( (err = inode_change_ok(inode, &ia)) )
+			goto out;
+		
+		/* The root directory has no attributes */
+		if ( inode->i_ino == MSDOS_ROOT_INO && attr != ATTR_DIR ) {
+			err = -EINVAL;
+			goto out;
+		}
+
+		oldattr = msdos_attr(inode);
+		if (sbi->options.sys_immutable) {
+			if ((attr^oldattr) & ATTR_SYS) {
+				if (!capable(CAP_LINUX_IMMUTABLE)) {
+					err = -EPERM;
+					goto out;
+				}
+				
+				if ( attr & ATTR_SYS )
+					inode->i_flags |= S_IMMUTABLE;
+				else
+					inode->i_flags &= S_IMMUTABLE;
+			}
+		}
+
+		MSDOS_I(inode)->i_attrs = attr & ATTR_UNUSED;
+		
+		err = inode_setattr(inode, &ia);
+	out:
+		up(&inode->i_sem);
+		return err;
+	}
+	default:
+		return -ENOTTY;	/* Inappropriate ioctl for device */
+	}
+}
+
 MODULE_LICENSE("GPL");
Index: linux-2.5/include/linux/compat_ioctl.h
===================================================================
RCS file: /home/hpa/kernel/bkcvs/linux-2.5/include/linux/compat_ioctl.h,v
retrieving revision 1.35
diff -u -r1.35 compat_ioctl.h
--- linux-2.5/include/linux/compat_ioctl.h	16 Nov 2004 04:09:40 -0000	1.35
+++ linux-2.5/include/linux/compat_ioctl.h	3 Jan 2005 19:15:21 -0000
@@ -571,6 +571,9 @@
 COMPATIBLE_IOCTL(DEVFSDIOC_SET_EVENT_MASK)
 COMPATIBLE_IOCTL(DEVFSDIOC_RELEASE_EVENT_QUEUE)
 COMPATIBLE_IOCTL(DEVFSDIOC_SET_DEBUG_MASK)
+/* FAT */
+COMPATIBLE_IOCTL(FAT_IOCTL_GET_ATTRIBUTES)
+COMPATIBLE_IOCTL(FAT_IOCTL_SET_ATTRIBUTES)
 /* Raw devices */
 COMPATIBLE_IOCTL(RAW_SETBIND)
 COMPATIBLE_IOCTL(RAW_GETBIND)
Index: linux-2.5/include/linux/msdos_fs.h
===================================================================
RCS file: /home/hpa/kernel/bkcvs/linux-2.5/include/linux/msdos_fs.h,v
retrieving revision 1.41
diff -u -r1.41 msdos_fs.h
--- linux-2.5/include/linux/msdos_fs.h	20 Oct 2004 15:16:45 -0000	1.41
+++ linux-2.5/include/linux/msdos_fs.h	3 Jan 2005 20:35:36 -0000
@@ -95,6 +95,9 @@
  */
 #define	VFAT_IOCTL_READDIR_BOTH		_IOR('r', 1, struct dirent [2])
 #define	VFAT_IOCTL_READDIR_SHORT	_IOR('r', 2, struct dirent [2])
+/* Badness: 1..6 conflict with linux/videotext.h, despite ioctl-numbers.txt */
+#define FAT_IOCTL_GET_ATTRIBUTES	_IOR('r', 0x10, __u8)
+#define FAT_IOCTL_SET_ATTRIBUTES	_IOW('r', 0x11, __u8)
 
 /* 
  * vfat shortname flags
@@ -202,6 +205,13 @@
 	return container_of(inode, struct msdos_inode_info, vfs_inode);
 }
 
+static inline u8 msdos_attr(struct inode *inode)
+{
+	return MSDOS_MKATTR(inode->i_mode) |
+		MSDOS_I(inode)->i_attrs |
+		(S_ISDIR(inode->i_mode) ? ATTR_DIR : 0);
+}
+
 static inline void fat16_towchar(wchar_t *dst, const __u8 *src, size_t len)
 {
 #ifdef __BIG_ENDIAN
@@ -267,6 +277,8 @@
 int fat_fill_super(struct super_block *sb, void *data, int silent,
 		   struct inode_operations *fs_dir_inode_ops, int isvfat);
 extern int fat_notify_change(struct dentry * dentry, struct iattr * attr);
+extern int fat_generic_ioctl(struct inode * inode, struct file * filp,
+			     unsigned int cmd, unsigned long arg);
 
 /* fat/misc.c */
 extern void fat_fs_panic(struct super_block *s, const char *fmt, ...);
Index: linux-2.5/include/linux/msdos_fs_i.h
===================================================================
RCS file: /home/hpa/kernel/bkcvs/linux-2.5/include/linux/msdos_fs_i.h,v
retrieving revision 1.11
diff -u -r1.11 msdos_fs_i.h
--- linux-2.5/include/linux/msdos_fs_i.h	20 Oct 2004 15:15:45 -0000	1.11
+++ linux-2.5/include/linux/msdos_fs_i.h	3 Jan 2005 20:37:05 -0000
@@ -20,7 +20,6 @@
 	int i_start;	/* first cluster or 0 */
 	int i_logstart;	/* logical first cluster */
 	int i_attrs;	/* unused attribute bits */
-	int i_ctime_ms;	/* unused change time in milliseconds */
 	loff_t i_pos;	/* on-disk position of directory entry or 0 */
 	struct hlist_node i_fat_hash;	/* hash by i_location */
 	struct inode vfs_inode;

--------------070008010706050706090605--
