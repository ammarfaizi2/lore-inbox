Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265326AbSKNX5p>; Thu, 14 Nov 2002 18:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265355AbSKNX5p>; Thu, 14 Nov 2002 18:57:45 -0500
Received: from hera.cwi.nl ([192.16.191.8]:36279 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S265326AbSKNX5o>;
	Thu, 14 Nov 2002 18:57:44 -0500
From: Andries.Brouwer@cwi.nl
Date: Fri, 15 Nov 2002 01:04:35 +0100 (MET)
Message-Id: <UTC200211150004.gAF04Zi01845.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] fix vfat mount options
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.5.43 the meaning of the umask mount option for (V)FAT
was changed (first: define mask for all files, later: only for nondirs,
with dmask a new option for dirs).
This is bad because it introduces an inconvenient incompatibility with 2.4.
This is also bad because it introduces an unnecessary difference
with the way NTFS handles things (namely: umask keeps old meaning,
dmask is for directories, fmask is for regular files).

The patch below fixes the VFAT option handling, and makes VFAT do
what NTFS does already.

Andries


diff -u --recursive --new-file -X /linux/dontdiff a/fs/fat/inode.c b/fs/fat/inode.c
--- a/fs/fat/inode.c	Thu Nov 14 17:10:27 2002
+++ b/fs/fat/inode.c	Thu Nov 14 17:11:12 2002
@@ -204,7 +204,7 @@
 		seq_printf(m, ",uid=%d", opts->fs_uid);
 	if (opts->fs_gid != 0)
 		seq_printf(m, ",gid=%d", opts->fs_gid);
-	seq_printf(m, ",umask=%04o", opts->fs_umask);
+	seq_printf(m, ",fmask=%04o", opts->fs_fmask);
 	seq_printf(m, ",dmask=%04o", opts->fs_dmask);
 	if (sbi->nls_disk)
 		seq_printf(m, ",codepage=%s", sbi->nls_disk->charset);
@@ -266,7 +266,7 @@
 
 	opts->fs_uid = current->uid;
 	opts->fs_gid = current->gid;
-	opts->fs_umask = opts->fs_dmask = current->fs->umask;
+	opts->fs_fmask = opts->fs_dmask = current->fs->umask;
 	opts->codepage = 0;
 	opts->iocharset = NULL;
 	if (is_vfat)
@@ -332,7 +332,15 @@
 		else if (!strcmp(this_char,"umask")) {
 			if (!value || !*value) ret = 0;
 			else {
-				opts->fs_umask = simple_strtoul(value,&value,8);
+				opts->fs_fmask = opts->fs_dmask =
+					simple_strtoul(value,&value,8);
+				if (*value) ret = 0;
+			}
+		}
+		else if (!strcmp(this_char,"fmask")) {
+			if (!value || !*value) ret = 0;
+			else {
+				opts->fs_fmask = simple_strtoul(value,&value,8);
 				if (*value) ret = 0;
 			}
 		}
@@ -1117,7 +1125,7 @@
 		    ((sbi->options.showexec &&
 		       !is_exec(de->ext))
 		    	? S_IRUGO|S_IWUGO : S_IRWXUGO)
-		    & ~sbi->options.fs_umask) | S_IFREG;
+		    & ~sbi->options.fs_fmask) | S_IFREG;
 		MSDOS_I(inode)->i_start = CF_LE_W(de->start);
 		if (sbi->fat_bits == 32) {
 			MSDOS_I(inode)->i_start |=
@@ -1249,7 +1257,7 @@
 	if (S_ISDIR(inode->i_mode))
 		mask = sbi->options.fs_dmask;
 	else
-		mask = sbi->options.fs_umask;
+		mask = sbi->options.fs_fmask;
 	inode->i_mode &= S_IFMT | (S_IRWXUGO & ~mask);
 out:
 	unlock_kernel();
diff -u --recursive --new-file -X /linux/dontdiff a/fs/umsdos/ioctl.c b/fs/umsdos/ioctl.c
--- a/fs/umsdos/ioctl.c	Sun Jun  9 07:27:21 2002
+++ b/fs/umsdos/ioctl.c	Fri Nov  8 02:28:45 2002
@@ -430,7 +430,9 @@
 		 */
 		dir->i_sb->u.msdos_sb.options.fs_uid = data.umsdos_dirent.uid;
 		dir->i_sb->u.msdos_sb.options.fs_gid = data.umsdos_dirent.gid;
-		dir->i_sb->u.msdos_sb.options.fs_umask = data.umsdos_dirent.mode;
+		dir->i_sb->u.msdos_sb.options.fs_fmask =
+			dir->i_sb->u.msdos_sb.options.fs_dmask =
+				data.umsdos_dirent.mode;
 		ret = 0;
 	}
 out:
diff -u --recursive --new-file -X /linux/dontdiff a/include/linux/msdos_fs_sb.h b/include/linux/msdos_fs_sb.h
--- a/include/linux/msdos_fs_sb.h	Thu Oct 31 14:14:50 2002
+++ b/include/linux/msdos_fs_sb.h	Thu Nov 14 23:44:18 2002
@@ -8,7 +8,7 @@
 struct fat_mount_options {
 	uid_t fs_uid;
 	gid_t fs_gid;
-	unsigned short fs_umask;
+	unsigned short fs_fmask;
 	unsigned short fs_dmask;
 	unsigned short codepage;  /* Codepage for shortname conversions */
 	char *iocharset;          /* Charset used for filename input/display */
