Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263554AbVBCTDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263554AbVBCTDO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 14:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263544AbVBCTBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 14:01:10 -0500
Received: from terminus.zytor.com ([209.128.68.124]:955 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S263738AbVBCS5s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 13:57:48 -0500
Message-ID: <4202741F.9040102@zytor.com>
Date: Thu, 03 Feb 2005 10:57:35 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: hirofumi@mail.parknet.co.jp
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Updated FAT attributes patch
Content-Type: multipart/mixed;
 boundary="------------010902050103020102060703"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010902050103020102060703
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

This updates the FAT attributes as well as (hopefully) corrects the 
handling of VFAT ctime.  The FAT attributes are implemented as a 32-bit 
ioctl, per the previous discussions.

	-hpa

Signed-Off-By: H. Peter Anvin <hpa@zytor.com>


--------------010902050103020102060703
Content-Type: text/x-patch;
 name="fatioctl.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fatioctl.patch"

Index: linux-2.5/fs/fat/dir.c
===================================================================
RCS file: /home/hpa/kernel/bkcvs/linux-2.5/fs/fat/dir.c,v
retrieving revision 1.32
diff -u -r1.32 dir.c
--- linux-2.5/fs/fat/dir.c	21 Jan 2005 16:14:48 -0000	1.32
+++ linux-2.5/fs/fat/dir.c	2 Feb 2005 07:13:27 -0000
@@ -639,7 +639,7 @@
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
retrieving revision 1.28
diff -u -r1.28 file.c
--- linux-2.5/fs/fat/file.c	21 Jan 2005 16:14:33 -0000	1.28
+++ linux-2.5/fs/fat/file.c	3 Feb 2005 18:17:39 -0000
@@ -32,6 +32,7 @@
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
retrieving revision 1.113
diff -u -r1.113 inode.c
--- linux-2.5/fs/fat/inode.c	21 Jan 2005 16:15:01 -0000	1.113
+++ linux-2.5/fs/fat/inode.c	3 Feb 2005 18:42:37 -0000
@@ -277,12 +277,18 @@
 	inode->i_mtime.tv_sec = inode->i_atime.tv_sec =
 		date_dos2unix(le16_to_cpu(de->time), le16_to_cpu(de->date));
 	inode->i_mtime.tv_nsec = inode->i_atime.tv_nsec = 0;
-	inode->i_ctime.tv_sec =
-		MSDOS_SB(sb)->options.isvfat
-		? date_dos2unix(le16_to_cpu(de->ctime), le16_to_cpu(de->cdate))
-		: inode->i_mtime.tv_sec;
-	inode->i_ctime.tv_nsec = de->ctime_ms * 1000000;
-	MSDOS_I(inode)->i_ctime_ms = de->ctime_ms;
+	if ( MSDOS_SB(sb)->options.isvfat ) {
+		int secs, csecs;
+
+		secs = de->ctime_cs / 100;
+		csecs = de->ctime_cs % 100;
+		
+		inode->i_ctime.tv_sec  = date_dos2unix(le16_to_cpu(de->ctime),
+						       le16_to_cpu(de->cdate)) + secs;
+		inode->i_ctime.tv_nsec = csecs * 10000000;
+	} else {
+		inode->i_ctime = inode->i_mtime;
+	}
 
 	return 0;
 }
@@ -491,14 +497,14 @@
 		raw_entry->attr = ATTR_NONE;
 		raw_entry->size = cpu_to_le32(inode->i_size);
 	}
-	raw_entry->attr |= MSDOS_MKATTR(inode->i_mode) |
-	    MSDOS_I(inode)->i_attrs;
+	raw_entry->attr |= msdos_attr(inode);
 	raw_entry->start = cpu_to_le16(MSDOS_I(inode)->i_logstart);
 	raw_entry->starthi = cpu_to_le16(MSDOS_I(inode)->i_logstart >> 16);
 	fat_date_unix2dos(inode->i_mtime.tv_sec, &raw_entry->time, &raw_entry->date);
 	if (sbi->options.isvfat) {
 		fat_date_unix2dos(inode->i_ctime.tv_sec,&raw_entry->ctime,&raw_entry->cdate);
-		raw_entry->ctime_ms = MSDOS_I(inode)->i_ctime_ms; /* use i_ctime.tv_nsec? */
+		raw_entry->ctime_cs = (inode->i_ctime.tv_sec & 1) * 100 +
+			inode->i_ctime.tv_nsec / 10000000;
 	}
 	spin_unlock(&sbi->inode_hash_lock);
 	mark_buffer_dirty(bh);
@@ -1337,4 +1343,103 @@
 module_init(init_fat_fs)
 module_exit(exit_fat_fs)
 
+int fat_generic_ioctl(struct inode * inode, struct file * filp,
+		      unsigned int cmd, unsigned long arg)
+{
+	struct super_block *sb = inode->i_sb;
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+
+	switch (cmd) {
+	case FAT_IOCTL_GET_ATTRIBUTES:
+	{
+		u32 attr;
+		
+		if ( inode->i_ino == MSDOS_ROOT_INO )
+			attr = ATTR_DIR;
+		else
+			attr = msdos_attr(inode);
+
+		return put_user(attr, (u32 *)arg);
+	}
+	case FAT_IOCTL_SET_ATTRIBUTES:
+	{
+		u32 attr, oldattr;
+		int err = 0;
+		int is_dir;
+		struct iattr ia;
+
+		/* Equivalent to a chmod() */
+		ia.ia_valid = ATTR_MODE | ATTR_CTIME;
+
+		if ( (err = get_user(attr, (u32 *)arg)) )
+			return err;
+		
+		down(&inode->i_sem);
+
+		if (IS_RDONLY(inode)) {
+			err = -EROFS;
+			goto up;
+		}
+
+		/* ATTR_VOLUME and ATTR_DIR cannot be changed; this also
+		   prevents the user from turning us into a VFAT
+		   longname entry.  Also, we obviously can't set
+		   any of the NTFS attributes in the high 24 bits. */
+		attr &= 0xff & ~(ATTR_VOLUME|ATTR_DIR);
+
+		is_dir = S_ISDIR(inode->i_mode);
+
+		/* Merge in ATTR_VOLUME and ATTR_DIR */
+		attr |= (MSDOS_I(inode)->i_attrs & ATTR_VOLUME) |
+			(is_dir ? ATTR_DIR : 0);
+
+		oldattr = msdos_attr(inode);
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
+		/* The root directory has no attributes */
+		if ( inode->i_ino == MSDOS_ROOT_INO && attr != ATTR_DIR ) {
+			err = -EINVAL;
+			goto up;
+		}
+
+		if (sbi->options.sys_immutable) {
+			if ( ((attr|oldattr) & ATTR_SYS) ) {
+				if (!capable(CAP_LINUX_IMMUTABLE)) {
+					err = -EPERM;
+					goto up;
+				}
+			}
+		}
+
+		/* This MUST be done before doing anything irreversible... */
+		if ( (err = notify_change(filp->f_dentry, &ia)) )
+			goto up;
+		
+		if (sbi->options.sys_immutable) {
+			if ( attr & ATTR_SYS )
+				inode->i_flags |= S_IMMUTABLE;
+			else
+				inode->i_flags &= S_IMMUTABLE;
+		}
+
+		MSDOS_I(inode)->i_attrs = attr & ATTR_UNUSED;
+	up:
+		up(&inode->i_sem);
+		return err;
+	}
+	default:
+		return -ENOTTY;	/* Inappropriate ioctl for device */
+	}
+}
+
 MODULE_LICENSE("GPL");
Index: linux-2.5/fs/vfat/namei.c
===================================================================
RCS file: /home/hpa/kernel/bkcvs/linux-2.5/fs/vfat/namei.c,v
retrieving revision 1.57
diff -u -r1.57 namei.c
--- linux-2.5/fs/vfat/namei.c	21 Jan 2005 16:14:16 -0000	1.57
+++ linux-2.5/fs/vfat/namei.c	31 Jan 2005 22:20:23 -0000
@@ -649,7 +649,7 @@
 	de->lcase = lcase;
 	de->adate = de->cdate = de->date = 0;
 	de->ctime = de->time = 0;
-	de->ctime_ms = 0;
+	de->ctime_cs = 0;
 	de->start = 0;
 	de->starthi = 0;
 	de->size = 0;
Index: linux-2.5/include/linux/msdos_fs.h
===================================================================
RCS file: /home/hpa/kernel/bkcvs/linux-2.5/include/linux/msdos_fs.h,v
retrieving revision 1.45
diff -u -r1.45 msdos_fs.h
--- linux-2.5/include/linux/msdos_fs.h	21 Jan 2005 16:14:48 -0000	1.45
+++ linux-2.5/include/linux/msdos_fs.h	2 Feb 2005 07:32:45 -0000
@@ -50,8 +50,6 @@
 #define MSDOS_VALID_MODE (S_IFREG | S_IFDIR | S_IRWXU | S_IRWXG | S_IRWXO)
 /* Convert attribute bits and a mask to the UNIX mode. */
 #define MSDOS_MKMODE(a, m) (m & (a & ATTR_RO ? S_IRUGO|S_IXUGO : S_IRWXUGO))
-/* Convert the UNIX mode to MS-DOS attribute bits. */
-#define MSDOS_MKATTR(m)	((m & S_IWUGO) ? ATTR_NONE : ATTR_RO)
 
 #define MSDOS_NAME	11	/* maximum name length */
 #define MSDOS_LONGNAME	256	/* maximum name length */
@@ -102,6 +100,9 @@
  */
 #define	VFAT_IOCTL_READDIR_BOTH		_IOR('r', 1, struct dirent [2])
 #define	VFAT_IOCTL_READDIR_SHORT	_IOR('r', 2, struct dirent [2])
+/* <linux/videotext.h> has used 0x72 ('r') in collision, so skip a few */
+#define FAT_IOCTL_GET_ATTRIBUTES	_IOR('r', 0x10, __u32)
+#define FAT_IOCTL_SET_ATTRIBUTES	_IOW('r', 0x11, __u32)
 
 /*
  * vfat shortname flags
@@ -152,7 +153,7 @@
 	__u8	name[8],ext[3];	/* name and extension */
 	__u8	attr;		/* attribute bits */
 	__u8    lcase;		/* Case for base and extension */
-	__u8	ctime_ms;	/* Creation time, milliseconds */
+	__u8	ctime_cs;	/* Creation time, centiseconds (0-199) */
 	__le16	ctime;		/* Creation time */
 	__le16	cdate;		/* Creation date */
 	__le16	adate;		/* Last access date */
@@ -273,6 +274,14 @@
 	return container_of(inode, struct msdos_inode_info, vfs_inode);
 }
 
+/* Return the FAT attribute byte for this inode */
+static inline u8 msdos_attr(struct inode *inode)
+{
+	return ((inode->i_mode & S_IWUGO) ? ATTR_NONE : ATTR_RO) |
+		(S_ISDIR(inode->i_mode) ? ATTR_DIR : ATTR_NONE) |
+		MSDOS_I(inode)->i_attrs;
+}
+
 static inline sector_t fat_clus_to_blknr(struct msdos_sb_info *sbi, int clus)
 {
 	return ((sector_t)clus - FAT_START_ENT) * sbi->sec_per_clus
@@ -341,6 +350,8 @@
 			struct msdos_dir_entry *de, loff_t i_pos, int *res);
 int fat_fill_super(struct super_block *sb, void *data, int silent,
 		   struct inode_operations *fs_dir_inode_ops, int isvfat);
+extern int fat_generic_ioctl(struct inode * inode, struct file * filp,
+			     unsigned int cmd, unsigned long arg);
 
 /* fat/misc.c */
 extern void fat_fs_panic(struct super_block *s, const char *fmt, ...);

--------------010902050103020102060703--
