Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262887AbSK3V3n>; Sat, 30 Nov 2002 16:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264644AbSK3V3n>; Sat, 30 Nov 2002 16:29:43 -0500
Received: from hera.cwi.nl ([192.16.191.8]:23806 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S262887AbSK3V3k>;
	Sat, 30 Nov 2002 16:29:40 -0500
From: Andries.Brouwer@cwi.nl
Date: Sat, 30 Nov 2002 22:36:52 +0100 (MET)
Message-Id: <UTC200211302136.gAULaq713410.aeb@smtp.cwi.nl>
To: jochen@jochen.org, torvalds@transmeta.com
Subject: [PATCH] fix wrong permissions for vfat directories
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Jochen Hein <jochen@jochen.org>

    I do mount vfat with autofs, and options umask=002 there.  mount
    and /proc/mounts confirms that: 

    /dev/hda5 on /mount/d type vfat (rw,umask=002,gid=1000)

    The directory permissions don't allow writing:

    drwxr-xr-x    2 root     jochen      32768 2002-11-30 20:37 ./

Fixed by the patch below.

Andries

-----

diff -u --recursive --new-file -X /linux/dontdiff a/fs/fat/inode.c b/fs/fat/inode.c
--- a/fs/fat/inode.c	Fri Nov 22 22:40:41 2002
+++ b/fs/fat/inode.c	Sat Nov 30 22:10:54 2002
@@ -205,7 +205,7 @@
 		seq_printf(m, ",uid=%d", opts->fs_uid);
 	if (opts->fs_gid != 0)
 		seq_printf(m, ",gid=%d", opts->fs_gid);
-	seq_printf(m, ",umask=%04o", opts->fs_umask);
+	seq_printf(m, ",fmask=%04o", opts->fs_fmask);
 	seq_printf(m, ",dmask=%04o", opts->fs_dmask);
 	if (sbi->nls_disk)
 		seq_printf(m, ",codepage=%s", sbi->nls_disk->charset);
@@ -267,7 +267,7 @@
 
 	opts->fs_uid = current->uid;
 	opts->fs_gid = current->gid;
-	opts->fs_umask = opts->fs_dmask = current->fs->umask;
+	opts->fs_fmask = opts->fs_dmask = current->fs->umask;
 	opts->codepage = 0;
 	opts->iocharset = NULL;
 	if (is_vfat)
@@ -333,7 +333,15 @@
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
@@ -1119,7 +1127,7 @@
 		    ((sbi->options.showexec &&
 		       !is_exec(de->ext))
 		    	? S_IRUGO|S_IWUGO : S_IRWXUGO)
-		    & ~sbi->options.fs_umask) | S_IFREG;
+		    & ~sbi->options.fs_fmask) | S_IFREG;
 		MSDOS_I(inode)->i_start = CF_LE_W(de->start);
 		if (sbi->fat_bits == 32) {
 			MSDOS_I(inode)->i_start |=
@@ -1253,7 +1261,7 @@
 	if (S_ISDIR(inode->i_mode))
 		mask = sbi->options.fs_dmask;
 	else
-		mask = sbi->options.fs_umask;
+		mask = sbi->options.fs_fmask;
 	inode->i_mode &= S_IFMT | (S_IRWXUGO & ~mask);
 out:
 	unlock_kernel();
diff -u --recursive --new-file -X /linux/dontdiff a/fs/umsdos/ioctl.c b/fs/umsdos/ioctl.c
--- a/fs/umsdos/ioctl.c	Fri Nov 22 22:40:19 2002
+++ b/fs/umsdos/ioctl.c	Sat Nov 30 22:12:08 2002
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
--- a/include/linux/msdos_fs_sb.h	Fri Nov 22 22:40:42 2002
+++ b/include/linux/msdos_fs_sb.h	Sat Nov 30 22:12:40 2002
@@ -8,7 +8,7 @@
 struct fat_mount_options {
 	uid_t fs_uid;
 	gid_t fs_gid;
-	unsigned short fs_umask;
+	unsigned short fs_fmask;
 	unsigned short fs_dmask;
 	unsigned short codepage;  /* Codepage for shortname conversions */
 	char *iocharset;          /* Charset used for filename input/display */



