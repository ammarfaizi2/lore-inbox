Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261388AbSJMAQh>; Sat, 12 Oct 2002 20:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261387AbSJMAPh>; Sat, 12 Oct 2002 20:15:37 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:59145 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S261388AbSJMAPP>; Sat, 12 Oct 2002 20:15:15 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] adds dmask option to fat (5/5)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 13 Oct 2002 09:20:58 +0900
Message-ID: <87y9939ok5.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This adds the dmask option. Yes, the dmask option is the permission
bitmask for directory.

Please apply.


 Documentation/filesystems/vfat.txt |    4 ++
 fs/fat/inode.c                     |   39 +++++++++++++++------------
 include/linux/msdos_fs_sb.h        |    1 
 3 files changed, 28 insertions(+), 16 deletions(-)
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

diff -urNp fat_show_opt/Documentation/filesystems/vfat.txt fat_dmask/Documentation/filesystems/vfat.txt
--- fat_show_opt/Documentation/filesystems/vfat.txt	2002-10-13 07:39:16.000000000 +0900
+++ fat_dmask/Documentation/filesystems/vfat.txt	2002-10-13 07:41:39.000000000 +0900
@@ -8,6 +8,10 @@ if you want to format from within Linux.
 
 VFAT MOUNT OPTIONS
 ----------------------------------------------------------------------
+umask=###     -- The permission mask (see umask(1)) for the regulare file.
+                 The default is the umask of current process.
+dmask=###     -- The permission mask for the directory.
+                 The default is the umask of current process.
 codepage=###  -- Sets the codepage for converting to shortname characters
 		 on FAT and VFAT filesystems.  By default, codepage 437
 		 is used.  This is the default for the U.S. and some
diff -urNp fat_show_opt/fs/fat/inode.c fat_dmask/fs/fat/inode.c
--- fat_show_opt/fs/fat/inode.c	2002-10-13 07:40:36.000000000 +0900
+++ fat_dmask/fs/fat/inode.c	2002-10-13 07:41:39.000000000 +0900
@@ -227,6 +227,7 @@ static int fat_show_options(struct seq_f
 	if (opts->fs_gid != 0)
 		seq_printf(m, ",gid=%d", opts->fs_gid);
 	seq_printf(m, ",umask=%04o", opts->fs_umask);
+	seq_printf(m, ",dmask=%04o", opts->fs_dmask);
 	if (sbi->nls_disk)
 		seq_printf(m, ",codepage=%s", sbi->nls_disk->charset);
 	if (isvfat) {
@@ -290,7 +291,7 @@ static int parse_options(char *options, 
 
 	opts->fs_uid = current->uid;
 	opts->fs_gid = current->gid;
-	opts->fs_umask = current->fs->umask;
+	opts->fs_umask = opts->fs_dmask = current->fs->umask;
 	opts->codepage = 0;
 	opts->iocharset = NULL;
 	if (is_vfat)
@@ -368,6 +369,13 @@ static int parse_options(char *options, 
 				if (*value) ret = 0;
 			}
 		}
+		else if (!strcmp(this_char,"dmask")) {
+			if (!value || !*value) ret = 0;
+			else {
+				opts->fs_dmask = simple_strtoul(value,&value,8);
+				if (*value) ret = 0;
+			}
+		}
 		else if (!strcmp(this_char,"debug")) {
 			if (value) ret = 0;
 			else *debug = 1;
@@ -530,7 +538,7 @@ static int fat_read_root(struct inode *i
 	inode->i_gid = sbi->options.fs_gid;
 	inode->i_version++;
 	inode->i_generation = 0;
-	inode->i_mode = (S_IRWXUGO & ~sbi->options.fs_umask) | S_IFDIR;
+	inode->i_mode = (S_IRWXUGO & ~sbi->options.fs_dmask) | S_IFDIR;
 	inode->i_op = sbi->dir_ops;
 	inode->i_fop = &fat_dir_operations;
 	if (sbi->fat_bits == 32) {
@@ -1157,8 +1165,8 @@ static int fat_fill_inode(struct inode *
 	
 	if ((de->attr & ATTR_DIR) && !IS_FREE(de->name)) {
 		inode->i_generation &= ~1;
-		inode->i_mode = MSDOS_MKMODE(de->attr,S_IRWXUGO &
-		    ~sbi->options.fs_umask) | S_IFDIR;
+		inode->i_mode = MSDOS_MKMODE(de->attr,
+			S_IRWXUGO & ~sbi->options.fs_dmask) | S_IFDIR;
 		inode->i_op = sbi->dir_ops;
 		inode->i_fop = &fat_dir_operations;
 
@@ -1278,9 +1286,9 @@ retry:
 
 int fat_notify_change(struct dentry * dentry, struct iattr * attr)
 {
-	struct super_block *sb = dentry->d_sb;
+	struct msdos_sb_info *sbi = MSDOS_SB(dentry->d_sb);
 	struct inode *inode = dentry->d_inode;
-	int error = 0;
+	int mask, error = 0;
 
 	lock_kernel();
 
@@ -1294,21 +1302,21 @@ int fat_notify_change(struct dentry * de
 
 	error = inode_change_ok(inode, attr);
 	if (error) {
-		if( MSDOS_SB(sb)->options.quiet )
-		    error = 0; 
+		if (sbi->options.quiet)
+			error = 0;
  		goto out;
 	}
 
 	if (((attr->ia_valid & ATTR_UID) && 
-	     (attr->ia_uid != MSDOS_SB(sb)->options.fs_uid)) ||
+	     (attr->ia_uid != sbi->options.fs_uid)) ||
 	    ((attr->ia_valid & ATTR_GID) && 
-	     (attr->ia_gid != MSDOS_SB(sb)->options.fs_gid)) ||
+	     (attr->ia_gid != sbi->options.fs_gid)) ||
 	    ((attr->ia_valid & ATTR_MODE) &&
 	     (attr->ia_mode & ~MSDOS_VALID_MODE)))
 		error = -EPERM;
 
 	if (error) {
-		if( MSDOS_SB(sb)->options.quiet )  
+		if (sbi->options.quiet)  
 			error = 0;
 		goto out;
 	}
@@ -1317,11 +1325,10 @@ int fat_notify_change(struct dentry * de
 		goto out;
 
 	if (S_ISDIR(inode->i_mode))
-		inode->i_mode |= S_IXUGO;
-
-	inode->i_mode = ((inode->i_mode & S_IFMT) | ((((inode->i_mode & S_IRWXU
-	    & ~MSDOS_SB(sb)->options.fs_umask) | S_IRUSR) >> 6)*S_IXUGO)) &
-	    ~MSDOS_SB(sb)->options.fs_umask;
+		mask = sbi->options.fs_dmask;
+	else
+		mask = sbi->options.fs_umask;
+	inode->i_mode &= S_IFMT | (S_IRWXUGO & ~mask);
 out:
 	unlock_kernel();
 	return error;
diff -urNp fat_show_opt/include/linux/msdos_fs_sb.h fat_dmask/include/linux/msdos_fs_sb.h
--- fat_show_opt/include/linux/msdos_fs_sb.h	2002-10-13 07:39:16.000000000 +0900
+++ fat_dmask/include/linux/msdos_fs_sb.h	2002-10-13 07:41:39.000000000 +0900
@@ -10,6 +10,7 @@ struct fat_mount_options {
 	uid_t fs_uid;
 	gid_t fs_gid;
 	unsigned short fs_umask;
+	unsigned short fs_dmask;
 	unsigned short codepage;  /* Codepage for shortname conversions */
 	char *iocharset;          /* Charset used for filename input/display */
 	unsigned short shortname; /* flags for shortname display/create rule */
