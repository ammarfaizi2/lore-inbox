Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261393AbSJMAQg>; Sat, 12 Oct 2002 20:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261388AbSJMAPr>; Sat, 12 Oct 2002 20:15:47 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:56841 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S261386AbSJMAOj>; Sat, 12 Oct 2002 20:14:39 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] add show_options to fat (4/5)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 13 Oct 2002 09:20:23 +0900
Message-ID: <873crbb35k.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This adds fat_show_options() to fat. And instead, this doesn't output
the charset name in fat_fill_super().

Please apply.


 fs/fat/inode.c |   71 +++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 66 insertions(+), 5 deletions(-)
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

diff -urNp fat_kill_posixfs/fs/fat/inode.c fat_show_opt/fs/fat/inode.c
--- fat_kill_posixfs/fs/fat/inode.c	2002-10-13 07:39:16.000000000 +0900
+++ fat_show_opt/fs/fat/inode.c	2002-10-13 07:40:36.000000000 +0900
@@ -14,6 +14,7 @@
 #include <linux/time.h>
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
+#include <linux/seq_file.h>
 #include <linux/msdos_fs.h>
 #include <linux/fat_cvf.h>
 #include <linux/pagemap.h>
@@ -215,6 +216,69 @@ static int simple_getbool(char *s, int *
 	return 1;
 }
 
+static int fat_show_options(struct seq_file *m, struct vfsmount *mnt)
+{
+	struct msdos_sb_info *sbi = MSDOS_SB(mnt->mnt_sb);
+	struct fat_mount_options *opts = &sbi->options;
+	int isvfat = opts->isvfat;
+
+	if (opts->fs_uid != 0)
+		seq_printf(m, ",uid=%d", opts->fs_uid);
+	if (opts->fs_gid != 0)
+		seq_printf(m, ",gid=%d", opts->fs_gid);
+	seq_printf(m, ",umask=%04o", opts->fs_umask);
+	if (sbi->nls_disk)
+		seq_printf(m, ",codepage=%s", sbi->nls_disk->charset);
+	if (isvfat) {
+		if (sbi->nls_io
+		    && strcmp(sbi->nls_io->charset, CONFIG_NLS_DEFAULT))
+			seq_printf(m, ",iocharset=%s", sbi->nls_io->charset);
+
+		switch (opts->shortname) {
+		case VFAT_SFN_DISPLAY_WIN95 | VFAT_SFN_CREATE_WIN95:
+			seq_puts(m, ",shortname=win95");
+			break;
+		case VFAT_SFN_DISPLAY_WINNT | VFAT_SFN_CREATE_WINNT:
+			seq_puts(m, ",shortname=winnt");
+			break;
+		case VFAT_SFN_DISPLAY_WINNT | VFAT_SFN_CREATE_WIN95:
+			seq_puts(m, ",shortname=mixed");
+			break;
+		case VFAT_SFN_DISPLAY_LOWER | VFAT_SFN_CREATE_WIN95:
+			/* seq_puts(m, ",shortname=lower"); */
+			break;
+		default:
+			seq_puts(m, ",shortname=unknown");
+			break;
+		}
+	}
+	if (opts->name_check != 'n')
+		seq_printf(m, ",check=%c", opts->name_check);
+	if (opts->conversion != 'b')
+		seq_printf(m, ",conv=%c", opts->conversion);
+	if (opts->quiet)
+		seq_puts(m, ",quiet");
+	if (opts->showexec)
+		seq_puts(m, ",showexec");
+	if (opts->sys_immutable)
+		seq_puts(m, ",sys_immutable");
+	if (!isvfat) {
+		if (opts->dotsOK)
+			seq_puts(m, ",dotsOK=yes");
+		if (opts->nocase)
+			seq_puts(m, ",nocase");
+	} else {
+		if (opts->utf8)
+			seq_puts(m, ",utf8");
+		if (opts->unicode_xlate)
+			seq_puts(m, ",uni_xlate");
+		if (!opts->numtail)
+			seq_puts(m, ",nonumtail");
+	}
+
+	return 0;
+}
+
 static int parse_options(char *options, int is_vfat, int *debug,
 			 struct fat_mount_options *opts,
 			 char *cvf_format, char *cvf_options)
@@ -682,6 +746,8 @@ static struct super_operations fat_sops 
 	clear_inode:	fat_clear_inode,
 
 	read_inode:	make_bad_inode,
+
+	show_options:	fat_show_options,
 };
 
 static struct export_operations fat_export_ops = {
@@ -936,8 +1002,6 @@ int fat_fill_super(struct super_block *s
 		sbi->options.codepage = 0; /* already 0?? */
 		sbi->nls_disk = load_nls_default();
 	}
-	if (!silent)
-		printk("FAT: Using codepage %s\n", sbi->nls_disk->charset);
 
 	/* FIXME: utf8 is using iocharset for upper/lower conversion */
 	if (sbi->options.isvfat) {
@@ -950,9 +1014,6 @@ int fat_fill_super(struct super_block *s
 			}
 		} else
 			sbi->nls_io = load_nls_default();
-		if (!silent)
-			printk("FAT: Using IO charset %s\n",
-			       sbi->nls_io->charset);
 	}
 
 	error = -ENOMEM;
