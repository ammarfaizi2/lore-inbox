Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314494AbSEYL7U>; Sat, 25 May 2002 07:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314500AbSEYL7T>; Sat, 25 May 2002 07:59:19 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:49156 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S314494AbSEYL7R>; Sat, 25 May 2002 07:59:17 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Add dmask option to fatfs (4/4)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 25 May 2002 20:59:01 +0900
Message-ID: <87u1owzbei.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch separate the umask for directory and file. And added the
new dmask option to be able to specify umask of a directory.

Please apply.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

diff -urN fat_parse_opt-2.5.18/fs/fat/inode.c fat_dmask-2.5.18/fs/fat/inode.c
--- fat_parse_opt-2.5.18/fs/fat/inode.c	Sat May 25 17:19:33 2002
+++ fat_dmask-2.5.18/fs/fat/inode.c	Sat May 25 17:24:08 2002
@@ -271,7 +271,7 @@
 
 	opts->fs_uid = current->uid;
 	opts->fs_gid = current->gid;
-	opts->fs_umask = current->fs->umask;
+	opts->fs_umask = opts->fs_dmask = current->fs->umask;
 	opts->codepage = 0;
 	opts->iocharset = NULL;
 	opts->shortname = 0;
@@ -311,6 +311,11 @@
 				goto error;
 			opts->fs_umask = val & S_IRWXUGO;
 		}
+		else if (!strcmp(this_char, "dmask")) {
+			if (want_oct(value, "dmask", &val))
+				goto error;
+			opts->fs_dmask = val & S_IRWXUGO;
+		}
 		else if (!strcmp(this_char, "codepage")) {
 			if (want_numeric(value, "codepage", &val))
 				goto error;
@@ -496,7 +501,7 @@
 	inode->i_gid = sbi->options.fs_gid;
 	inode->i_version++;
 	inode->i_generation = 0;
-	inode->i_mode = (S_IRWXUGO & ~sbi->options.fs_umask) | S_IFDIR;
+	inode->i_mode = (S_IRWXUGO & ~sbi->options.fs_dmask) | S_IFDIR;
 	inode->i_op = sbi->dir_ops;
 	inode->i_fop = &fat_dir_operations;
 	if (sbi->fat_bits == 32) {
@@ -1111,8 +1116,8 @@
 	
 	if ((de->attr & ATTR_DIR) && !IS_FREE(de->name)) {
 		inode->i_generation &= ~1;
-		inode->i_mode = MSDOS_MKMODE(de->attr,S_IRWXUGO &
-		    ~sbi->options.fs_umask) | S_IFDIR;
+		inode->i_mode = MSDOS_MKMODE(de->attr,
+			S_IRWXUGO & ~sbi->options.fs_dmask) | S_IFDIR;
 		inode->i_op = sbi->dir_ops;
 		inode->i_fop = &fat_dir_operations;
 
@@ -1232,9 +1237,9 @@
 
 int fat_notify_change(struct dentry * dentry, struct iattr * attr)
 {
-	struct super_block *sb = dentry->d_sb;
+	struct msdos_sb_info *sbi = MSDOS_SB(dentry->d_sb);
 	struct inode *inode = dentry->d_inode;
-	int error = 0;
+	int mask, error = 0;
 
 	lock_kernel();
 
@@ -1248,21 +1253,21 @@
 
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
@@ -1271,11 +1276,10 @@
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
diff -urN fat_parse_opt-2.5.18/include/linux/msdos_fs_sb.h fat_dmask-2.5.18/include/linux/msdos_fs_sb.h
--- fat_parse_opt-2.5.18/include/linux/msdos_fs_sb.h	Sat May 25 16:52:43 2002
+++ fat_dmask-2.5.18/include/linux/msdos_fs_sb.h	Sat May 25 17:24:08 2002
@@ -10,6 +10,7 @@
 	uid_t fs_uid;
 	gid_t fs_gid;
 	unsigned short fs_umask;
+	unsigned short fs_dmask;
 	unsigned short codepage;  /* Codepage for shortname conversions */
 	char *iocharset;          /* Charset used for filename input/display */
 	unsigned short shortname; /* flags for shortname display/create rule */
