Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbVCETGB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbVCETGB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 14:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbVCETEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 14:04:45 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:28676 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261301AbVCESmn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 13:42:43 -0500
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/29] FAT: Updated FAT attributes patch
References: <87ll92rl6a.fsf@devron.myhome.or.jp>
	<87hdjqrl44.fsf@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 06 Mar 2005 03:42:28 +0900
In-Reply-To: <87hdjqrl44.fsf@devron.myhome.or.jp> (OGAWA Hirofumi's message
 of "Sun, 06 Mar 2005 03:41:31 +0900")
Message-ID: <87d5uerl2j.fsf_-_@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This updates the FAT attributes as well as (hopefully) corrects the 
handling of VFAT ctime.  The FAT attributes are implemented as a 32-bit 
ioctl, per the previous discussions.

Signed-Off-By: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/dir.c             |    2 
 fs/fat/file.c            |   99 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/fat/inode.c           |   38 ++++++++----------
 fs/vfat/namei.c          |    2 
 include/linux/msdos_fs.h |   22 +++++++---
 5 files changed, 135 insertions(+), 28 deletions(-)

diff -puN fs/fat/dir.c~fat_attribute-ioctl fs/fat/dir.c
--- linux-2.6.11/fs/fat/dir.c~fat_attribute-ioctl	2005-03-06 02:36:02.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/fat/dir.c	2005-03-06 02:36:02.000000000 +0900
@@ -639,7 +639,7 @@ static int fat_dir_ioctl(struct inode * 
 		both = 1;
 		break;
 	default:
-		return -EINVAL;
+		return fat_generic_ioctl(inode, filp, cmd, arg);
 	}
 
 	d1 = (struct dirent __user *)arg;
diff -puN fs/fat/file.c~fat_attribute-ioctl fs/fat/file.c
--- linux-2.6.11/fs/fat/file.c~fat_attribute-ioctl	2005-03-06 02:36:02.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/fat/file.c	2005-03-06 02:36:02.000000000 +0900
@@ -42,6 +42,104 @@ static ssize_t fat_file_writev(struct fi
 	return retval;
 }
 
+int fat_generic_ioctl(struct inode *inode, struct file *filp,
+		      unsigned int cmd, unsigned long arg)
+{
+	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
+	u32 __user *user_attr = (u32 __user *)arg;
+
+	switch (cmd) {
+	case FAT_IOCTL_GET_ATTRIBUTES:
+	{
+		u32 attr;
+
+		if (inode->i_ino == MSDOS_ROOT_INO)
+			attr = ATTR_DIR;
+		else
+			attr = fat_attr(inode);
+
+		return put_user(attr, user_attr);
+	}
+	case FAT_IOCTL_SET_ATTRIBUTES:
+	{
+		u32 attr, oldattr;
+		int err, is_dir = S_ISDIR(inode->i_mode);
+		struct iattr ia;
+
+		err = get_user(attr, user_attr);
+		if (err)
+			return err;
+
+		down(&inode->i_sem);
+
+		if (IS_RDONLY(inode)) {
+			err = -EROFS;
+			goto up;
+		}
+
+		/*
+		 * ATTR_VOLUME and ATTR_DIR cannot be changed; this also
+		 * prevents the user from turning us into a VFAT
+		 * longname entry.  Also, we obviously can't set
+		 * any of the NTFS attributes in the high 24 bits.
+		 */
+		attr &= 0xff & ~(ATTR_VOLUME | ATTR_DIR);
+		/* Merge in ATTR_VOLUME and ATTR_DIR */
+		attr |= (MSDOS_I(inode)->i_attrs & ATTR_VOLUME) |
+			(is_dir ? ATTR_DIR : 0);
+		oldattr = fat_attr(inode);
+
+		/* Equivalent to a chmod() */
+		ia.ia_valid = ATTR_MODE | ATTR_CTIME;
+		if (is_dir) {
+			ia.ia_mode = MSDOS_MKMODE(attr,
+				S_IRWXUGO & ~sbi->options.fs_dmask)
+				| S_IFDIR;
+		} else {
+			ia.ia_mode = MSDOS_MKMODE(attr,
+				(S_IRUGO | S_IWUGO | (inode->i_mode & S_IXUGO))
+				& ~sbi->options.fs_fmask)
+				| S_IFREG;
+		}
+
+		/* The root directory has no attributes */
+		if (inode->i_ino == MSDOS_ROOT_INO && attr != ATTR_DIR) {
+			err = -EINVAL;
+			goto up;
+		}
+
+		if (sbi->options.sys_immutable) {
+			if ((attr | oldattr) & ATTR_SYS) {
+				if (!capable(CAP_LINUX_IMMUTABLE)) {
+					err = -EPERM;
+					goto up;
+				}
+			}
+		}
+
+		/* This MUST be done before doing anything irreversible... */
+		err = notify_change(filp->f_dentry, &ia);
+		if (err)
+			goto up;
+
+		if (sbi->options.sys_immutable) {
+			if (attr & ATTR_SYS)
+				inode->i_flags |= S_IMMUTABLE;
+			else
+				inode->i_flags &= S_IMMUTABLE;
+		}
+
+		MSDOS_I(inode)->i_attrs = attr & ATTR_UNUSED;
+		mark_inode_dirty(inode);
+	up:
+		up(&inode->i_sem);
+		return err;
+	}
+	default:
+		return -ENOTTY;	/* Inappropriate ioctl for device */
+	}
+}
+
 struct file_operations fat_file_operations = {
 	.llseek		= generic_file_llseek,
 	.read		= do_sync_read,
@@ -51,6 +149,7 @@ struct file_operations fat_file_operatio
 	.aio_read	= generic_file_aio_read,
 	.aio_write	= fat_file_aio_write,
 	.mmap		= generic_file_mmap,
+	.ioctl		= fat_generic_ioctl,
 	.fsync		= file_fsync,
 	.sendfile	= generic_file_sendfile,
 };
diff -puN fs/fat/inode.c~fat_attribute-ioctl fs/fat/inode.c
--- linux-2.6.11/fs/fat/inode.c~fat_attribute-ioctl	2005-03-06 02:36:02.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/fat/inode.c	2005-03-06 02:36:02.000000000 +0900
@@ -220,8 +220,7 @@ static int fat_calc_dir_size(struct inod
 /* doesn't deal with root inode */
 static int fat_fill_inode(struct inode *inode, struct msdos_dir_entry *de)
 {
-	struct super_block *sb = inode->i_sb;
-	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
 	int error;
 
 	MSDOS_I(inode)->i_pos = 0;
@@ -266,9 +265,10 @@ static int fat_fill_inode(struct inode *
 		inode->i_mapping->a_ops = &fat_aops;
 		MSDOS_I(inode)->mmu_private = inode->i_size;
 	}
-	if(de->attr & ATTR_SYS)
+	if (de->attr & ATTR_SYS) {
 		if (sbi->options.sys_immutable)
 			inode->i_flags |= S_IMMUTABLE;
+	}
 	MSDOS_I(inode)->i_attrs = de->attr & ATTR_UNUSED;
 	/* this is as close to the truth as we can get ... */
 	inode->i_blksize = sbi->cluster_size;
@@ -277,12 +277,15 @@ static int fat_fill_inode(struct inode *
 	inode->i_mtime.tv_sec = inode->i_atime.tv_sec =
 		date_dos2unix(le16_to_cpu(de->time), le16_to_cpu(de->date));
 	inode->i_mtime.tv_nsec = inode->i_atime.tv_nsec = 0;
-	inode->i_ctime.tv_sec =
-		MSDOS_SB(sb)->options.isvfat
-		? date_dos2unix(le16_to_cpu(de->ctime), le16_to_cpu(de->cdate))
-		: inode->i_mtime.tv_sec;
-	inode->i_ctime.tv_nsec = de->ctime_ms * 1000000;
-	MSDOS_I(inode)->i_ctime_ms = de->ctime_ms;
+	if (sbi->options.isvfat) {
+		int secs = de->ctime_cs / 100;
+		int csecs = de->ctime_cs % 100;
+		inode->i_ctime.tv_sec  =
+			date_dos2unix(le16_to_cpu(de->ctime),
+				      le16_to_cpu(de->cdate)) + secs;
+		inode->i_ctime.tv_nsec = csecs * 10000000;
+	} else
+		inode->i_ctime = inode->i_mtime;
 
 	return 0;
 }
@@ -483,22 +486,18 @@ retry:
 
 	raw_entry = &((struct msdos_dir_entry *) (bh->b_data))
 	    [i_pos & (sbi->dir_per_block - 1)];
-	if (S_ISDIR(inode->i_mode)) {
-		raw_entry->attr = ATTR_DIR;
+	if (S_ISDIR(inode->i_mode))
 		raw_entry->size = 0;
-	}
-	else {
-		raw_entry->attr = ATTR_NONE;
+	else
 		raw_entry->size = cpu_to_le32(inode->i_size);
-	}
-	raw_entry->attr |= MSDOS_MKATTR(inode->i_mode) |
-	    MSDOS_I(inode)->i_attrs;
+	raw_entry->attr = fat_attr(inode);
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
@@ -1026,10 +1025,9 @@ static int fat_read_root(struct inode *i
 	MSDOS_I(inode)->i_logstart = 0;
 	MSDOS_I(inode)->mmu_private = inode->i_size;
 
-	MSDOS_I(inode)->i_attrs = 0;
+	MSDOS_I(inode)->i_attrs = ATTR_NONE;
 	inode->i_mtime.tv_sec = inode->i_atime.tv_sec = inode->i_ctime.tv_sec = 0;
 	inode->i_mtime.tv_nsec = inode->i_atime.tv_nsec = inode->i_ctime.tv_nsec = 0;
-	MSDOS_I(inode)->i_ctime_ms = 0;
 	inode->i_nlink = fat_subdirs(inode)+2;
 
 	return 0;
diff -puN fs/vfat/namei.c~fat_attribute-ioctl fs/vfat/namei.c
--- linux-2.6.11/fs/vfat/namei.c~fat_attribute-ioctl	2005-03-06 02:36:02.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/vfat/namei.c	2005-03-06 02:36:02.000000000 +0900
@@ -649,7 +649,7 @@ shortname:
 	de->lcase = lcase;
 	de->adate = de->cdate = de->date = 0;
 	de->ctime = de->time = 0;
-	de->ctime_ms = 0;
+	de->ctime_cs = 0;
 	de->start = 0;
 	de->starthi = 0;
 	de->size = 0;
diff -puN include/linux/msdos_fs.h~fat_attribute-ioctl include/linux/msdos_fs.h
--- linux-2.6.11/include/linux/msdos_fs.h~fat_attribute-ioctl	2005-03-06 02:36:02.000000000 +0900
+++ linux-2.6.11-hirofumi/include/linux/msdos_fs.h	2005-03-06 02:36:02.000000000 +0900
@@ -50,8 +50,6 @@
 #define MSDOS_VALID_MODE (S_IFREG | S_IFDIR | S_IRWXU | S_IRWXG | S_IRWXO)
 /* Convert attribute bits and a mask to the UNIX mode. */
 #define MSDOS_MKMODE(a, m) (m & (a & ATTR_RO ? S_IRUGO|S_IXUGO : S_IRWXUGO))
-/* Convert the UNIX mode to MS-DOS attribute bits. */
-#define MSDOS_MKATTR(m)	((m & S_IWUGO) ? ATTR_NONE : ATTR_RO)
 
 #define MSDOS_NAME	11	/* maximum name length */
 #define MSDOS_LONGNAME	256	/* maximum name length */
@@ -100,8 +98,11 @@
 /*
  * ioctl commands
  */
-#define	VFAT_IOCTL_READDIR_BOTH		_IOR('r', 1, struct dirent [2])
-#define	VFAT_IOCTL_READDIR_SHORT	_IOR('r', 2, struct dirent [2])
+#define VFAT_IOCTL_READDIR_BOTH		_IOR('r', 1, struct dirent [2])
+#define VFAT_IOCTL_READDIR_SHORT	_IOR('r', 2, struct dirent [2])
+/* <linux/videotext.h> has used 0x72 ('r') in collision, so skip a few */
+#define FAT_IOCTL_GET_ATTRIBUTES	_IOR('r', 0x10, __u32)
+#define FAT_IOCTL_SET_ATTRIBUTES	_IOW('r', 0x11, __u32)
 
 /*
  * vfat shortname flags
@@ -152,7 +153,7 @@ struct msdos_dir_entry {
 	__u8	name[8],ext[3];	/* name and extension */
 	__u8	attr;		/* attribute bits */
 	__u8    lcase;		/* Case for base and extension */
-	__u8	ctime_ms;	/* Creation time, milliseconds */
+	__u8	ctime_cs;	/* Creation time, centiseconds (0-199) */
 	__le16	ctime;		/* Creation time */
 	__le16	cdate;		/* Creation date */
 	__le16	adate;		/* Last access date */
@@ -257,7 +258,6 @@ struct msdos_inode_info {
 	int i_start;		/* first cluster or 0 */
 	int i_logstart;		/* logical first cluster */
 	int i_attrs;		/* unused attribute bits */
-	int i_ctime_ms;		/* unused change time in milliseconds */
 	loff_t i_pos;		/* on-disk position of directory entry or 0 */
 	struct hlist_node i_fat_hash;	/* hash by i_location */
 	struct inode vfs_inode;
@@ -273,6 +273,14 @@ static inline struct msdos_inode_info *M
 	return container_of(inode, struct msdos_inode_info, vfs_inode);
 }
 
+/* Return the FAT attribute byte for this inode */
+static inline u8 fat_attr(struct inode *inode)
+{
+	return ((inode->i_mode & S_IWUGO) ? ATTR_NONE : ATTR_RO) |
+		(S_ISDIR(inode->i_mode) ? ATTR_DIR : ATTR_NONE) |
+		MSDOS_I(inode)->i_attrs;
+}
+
 static inline sector_t fat_clus_to_blknr(struct msdos_sb_info *sbi, int clus)
 {
 	return ((sector_t)clus - FAT_START_ENT) * sbi->sec_per_clus
@@ -328,6 +336,8 @@ extern int fat_scan(struct inode *dir, c
 		    struct msdos_dir_entry **res_de, loff_t *i_pos);
 
 /* fat/file.c */
+extern int fat_generic_ioctl(struct inode *inode, struct file *filp,
+			     unsigned int cmd, unsigned long arg);
 extern struct file_operations fat_file_operations;
 extern struct inode_operations fat_file_inode_operations;
 extern int fat_notify_change(struct dentry * dentry, struct iattr * attr);
_
