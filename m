Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263725AbUGIUeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263725AbUGIUeh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 16:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbUGIUeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 16:34:37 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:20243 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S263725AbUGIUeY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 16:34:24 -0400
To: linux-kernel@vger.kernel.org
Cc: Andries Brouwer <aebr@win.tue.nl>
Subject: [RFC] FAT: default nls choice
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 10 Jul 2004 05:34:15 +0900
Message-ID: <87briokji0.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Previously, fatfs was using NLS_DEFAULT if users didn't specify the
codepage or iocharset option. This became cause of trouble (filename
access).

This patch removes the default configs, instead, fatfs uses builtin
nls ("default"), also it reports and mounts as read-only. This will
limit the some access.  Note: If peoples want to write, it still can
switch by remount.

The fatfs doesn't care about setting anymore, it just uses specified
options.  There is mount.fat command for usability. It can help the
choice of nls by config file or locale or something else.

Comment?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>



Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 Documentation/filesystems/vfat.txt |   37 +++++++++---
 fs/Kconfig                         |   19 ------
 fs/fat/inode.c                     |  112 +++++++++++++++++++++----------------
 3 files changed, 94 insertions(+), 74 deletions(-)

diff -puN fs/Kconfig~fat_default-nls fs/Kconfig
--- linux-2.6.7/fs/Kconfig~fat_default-nls	2004-07-10 00:15:50.000000000 +0900
+++ linux-2.6.7-hirofumi/fs/Kconfig	2004-07-10 00:16:16.000000000 +0900
@@ -672,25 +672,6 @@ config VFAT_FS
 	  To compile this as a module, choose M here: the module will be called
 	  vfat.
 
-config FAT_DEFAULT_CODEPAGE
-	int "Default codepage for FAT"
-	depends on MSDOS_FS || VFAT_FS
-	default 437
-	help
-	  This option should be set to the codepage of your FAT filesystems.
-	  It can be overridden with the 'codepage' mount option.
-
-config FAT_DEFAULT_IOCHARSET
-	string "Default iocharset for FAT"
-	depends on VFAT_FS
-	default "iso8859-1"
-	help
-	  Set this to the default I/O character set you'd like FAT to use.
-	  It should probably match the character set that most of your
-	  FAT filesystems use, and can be overridded with the 'iocharset'
-	  mount option for FAT filesystems.  Note that UTF8 is *not* a
-	  supported charset for FAT filesystems.
-
 config UMSDOS_FS
 #dep_tristate '    UMSDOS: Unix-like file system on top of standard MSDOS fs' CONFIG_UMSDOS_FS $CONFIG_MSDOS_FS
 # UMSDOS is temprory broken
diff -puN fs/fat/inode.c~fat_default-nls fs/fat/inode.c
--- linux-2.6.7/fs/fat/inode.c~fat_default-nls	2004-07-10 00:16:55.000000000 +0900
+++ linux-2.6.7-hirofumi/fs/fat/inode.c	2004-07-10 04:22:20.000000000 +0900
@@ -23,14 +23,6 @@
 #include <linux/parser.h>
 #include <asm/unaligned.h>
 
-#ifndef CONFIG_FAT_DEFAULT_IOCHARSET
-/* if user don't select VFAT, this is undefined. */
-#define CONFIG_FAT_DEFAULT_IOCHARSET	""
-#endif
-
-static int fat_default_codepage = CONFIG_FAT_DEFAULT_CODEPAGE;
-static char fat_default_iocharset[] = CONFIG_FAT_DEFAULT_IOCHARSET;
-
 /*
  * New FAT inode stuff. We do the following:
  *	a) i_ino is constant and has nothing with on-disk location.
@@ -174,15 +166,15 @@ void fat_put_super(struct super_block *s
 	if (sbi->nls_disk) {
 		unload_nls(sbi->nls_disk);
 		sbi->nls_disk = NULL;
-		sbi->options.codepage = fat_default_codepage;
+		sbi->options.codepage = 0;
 	}
 	if (sbi->nls_io) {
 		unload_nls(sbi->nls_io);
 		sbi->nls_io = NULL;
 	}
-	if (sbi->options.iocharset != fat_default_iocharset) {
+	if (sbi->options.iocharset != NULL) {
 		kfree(sbi->options.iocharset);
-		sbi->options.iocharset = fat_default_iocharset;
+		sbi->options.iocharset = NULL;
 	}
 
 	sb->s_fs_info = NULL;
@@ -201,11 +193,10 @@ static int fat_show_options(struct seq_f
 		seq_printf(m, ",gid=%u", opts->fs_gid);
 	seq_printf(m, ",fmask=%04o", opts->fs_fmask);
 	seq_printf(m, ",dmask=%04o", opts->fs_dmask);
-	if (sbi->nls_disk && opts->codepage != fat_default_codepage)
+	if (sbi->nls_disk && opts->codepage)
 		seq_printf(m, ",codepage=%s", sbi->nls_disk->charset);
 	if (isvfat) {
-		if (sbi->nls_io &&
-		    strcmp(opts->iocharset, fat_default_iocharset))
+		if (sbi->nls_io && opts->iocharset)
 			seq_printf(m, ",iocharset=%s", sbi->nls_io->charset);
 
 		switch (opts->shortname) {
@@ -336,15 +327,14 @@ static int parse_options(char *options, 
 	char *p;
 	substring_t args[MAX_OPT_ARGS];
 	int option;
-	char *iocharset;
 
 	opts->isvfat = is_vfat;
 
 	opts->fs_uid = current->uid;
 	opts->fs_gid = current->gid;
 	opts->fs_fmask = opts->fs_dmask = current->fs->umask;
-	opts->codepage = fat_default_codepage;
-	opts->iocharset = fat_default_iocharset;
+	opts->codepage = 0;
+	opts->iocharset = NULL;
 	if (is_vfat)
 		opts->shortname = VFAT_SFN_DISPLAY_LOWER|VFAT_SFN_CREATE_WIN95;
 	else
@@ -443,12 +433,11 @@ static int parse_options(char *options, 
 
 		/* vfat specific */
 		case Opt_charset:
-			if (opts->iocharset != fat_default_iocharset)
+			if (opts->iocharset != NULL)
 				kfree(opts->iocharset);
-			iocharset = match_strdup(&args[0]);
-			if (!iocharset)
+			opts->iocharset = match_strdup(&args[0]);
+			if (opts->iocharset == NULL)
 				return -ENOMEM;
-			opts->iocharset = iocharset;
 			break;
 		case Opt_shortname_lower:
 			opts->shortname = VFAT_SFN_DISPLAY_LOWER
@@ -497,15 +486,9 @@ static int parse_options(char *options, 
 			return -EINVAL;
 		}
 	}
-	/* UTF8 doesn't provide FAT semantics */
-	if (!strcmp(opts->iocharset, "utf8")) {
-		printk(KERN_ERR "FAT: utf8 is not a recommended IO charset"
-		       " for FAT filesystems, filesystem will be case sensitive!\n");
-	}
-
 	if (opts->unicode_xlate)
 		opts->utf8 = 0;
-	
+
 	return 0;
 }
 
@@ -785,6 +768,58 @@ static struct export_operations fat_expo
 	.get_parent	= fat_get_parent,
 };
 
+static int fat_load_nls(struct super_block *sb)
+{
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+	struct fat_mount_options *opts = &sbi->options;
+	char codepage[50] = "default", *iocharset = "default";
+	int error = 0;
+
+	if (opts->codepage)
+		snprintf(codepage, sizeof(codepage), "cp%d", opts->codepage);
+	sbi->nls_disk = load_nls(codepage);
+	if (!sbi->nls_disk) {
+		printk(KERN_ERR "FAT: codepage %s not found\n", codepage);
+		error = -EINVAL;
+		goto out;
+	}
+
+	if (!opts->isvfat)
+		goto check_nls;
+
+	if (opts->iocharset)
+		iocharset = opts->iocharset;
+	/*
+	 * FIXME: utf8 is using iocharset for upper/lower conversion
+	 * UTF8 doesn't provide FAT semantics
+	 */
+	if (!strcmp(iocharset, "utf8")) {
+		printk(KERN_WARNING "FAT: utf8 is not a recommended IO charset"
+		       " for FAT filesystem,"
+		       " filesystem will be case sensitive!\n");
+	}
+	sbi->nls_io = load_nls(iocharset);
+	if (!sbi->nls_io) {
+		printk(KERN_ERR "FAT: IO charset %s not found\n", iocharset);
+		error = -EINVAL;
+		goto out;
+	}
+
+check_nls:
+	if (!opts->codepage || (opts->isvfat && opts->iocharset == NULL)) {
+		unsigned long not_ro = !(sb->s_flags & MS_RDONLY);
+		if (not_ro)
+			sb->s_flags |= MS_RDONLY;
+
+		printk(KERN_INFO "FAT: %s option didn't specified\n"
+		       "     File name can not access proper%s\n",
+		       opts->isvfat ? "codepage or iocharset" : "codepage",
+		       not_ro ? " (mounted as read-only)" : "");
+	}
+out:
+	return error;
+}
+
 /*
  * Read the super block of an MS-DOS FS.
  */
@@ -800,7 +835,6 @@ int fat_fill_super(struct super_block *s
 	int debug, first;
 	unsigned int media;
 	long error;
-	char buf[50];
 
 	sbi = kmalloc(sizeof(struct msdos_sb_info), GFP_KERNEL);
 	if (!sbi)
@@ -1015,23 +1049,9 @@ int fat_fill_super(struct super_block *s
 		goto out_invalid;
 	}
 
-	error = -EINVAL;
-	sprintf(buf, "cp%d", sbi->options.codepage);
-	sbi->nls_disk = load_nls(buf);
-	if (!sbi->nls_disk) {
-		printk(KERN_ERR "FAT: codepage %s not found\n", buf);
+	error = fat_load_nls(sb);
+	if (error)
 		goto out_fail;
-	}
-
-	/* FIXME: utf8 is using iocharset for upper/lower conversion */
-	if (sbi->options.isvfat) {
-		sbi->nls_io = load_nls(sbi->options.iocharset);
-		if (!sbi->nls_io) {
-			printk(KERN_ERR "FAT: IO charset %s not found\n",
-			       sbi->options.iocharset);
-			goto out_fail;
-		}
-	}
 
 	error = -ENOMEM;
 	root_inode = new_inode(sb);
@@ -1065,7 +1085,7 @@ out_fail:
 		unload_nls(sbi->nls_io);
 	if (sbi->nls_disk)
 		unload_nls(sbi->nls_disk);
-	if (sbi->options.iocharset != fat_default_iocharset)
+	if (sbi->options.iocharset != NULL)
 		kfree(sbi->options.iocharset);
 	sb->s_fs_info = NULL;
 	kfree(sbi);
diff -puN Documentation/filesystems/vfat.txt~fat_default-nls Documentation/filesystems/vfat.txt
--- linux-2.6.7/Documentation/filesystems/vfat.txt~fat_default-nls	2004-07-10 03:14:06.000000000 +0900
+++ linux-2.6.7-hirofumi/Documentation/filesystems/vfat.txt	2004-07-10 04:05:19.000000000 +0900
@@ -10,23 +10,40 @@ VFAT MOUNT OPTIONS
 ----------------------------------------------------------------------
 umask=###     -- The permission mask (for files and directories, see umask(1)).
                  The default is the umask of current process.
+
 dmask=###     -- The permission mask for the directory.
                  The default is the umask of current process.
+
 fmask=###     -- The permission mask for files.
                  The default is the umask of current process.
-codepage=###  -- Sets the codepage for converting to shortname characters
-		 on FAT and VFAT filesystems.  By default, codepage 437
-		 is used.  This is the default for the U.S. and some
-		 European countries.
-iocharset=name -- Character set to use for converting between 8 bit characters
-		 and 16 bit Unicode characters. Long filenames are stored on
-		 disk in Unicode format, but Unix for the most part doesn't
-		 know how to deal with Unicode. There is also an option of
-		 doing UTF8 translations with the utf8 option.
+
+codepage=###  -- Sets the codepage number for converting to shortname
+		 characters on FAT filesystem.
+
+		 NOTE: If this option was not specified, the file name
+		 could not be read/write rightly, also filesystem is
+		 mounted as read-only.
+
+iocharset=name -- Character set to use for converting between the
+		 encoding is used for user visible filename and 16 bit
+		 Unicode characters. Long filenames are stored on disk
+		 in Unicode format, but Unix for the most part doesn't
+		 know how to deal with Unicode.
+		 There is also an option of doing UTF8 translations
+		 with the utf8 option.
+
+		 NOTE: If this option was not specified, the file name
+		 could not be read/write rightly, also filesystem is
+		 mounted as read-only.
+
+		 NOTE: "iocharset=utf8" is not recommended. If unsure,
+		 you should consider the following option instead.
+
 utf8=<bool>   -- UTF8 is the filesystem safe version of Unicode that
 		 is used by the console.  It can be be enabled for the
 		 filesystem with this option. If 'uni_xlate' gets set,
 		 UTF8 gets disabled.
+
 uni_xlate=<bool> -- Translate unhandled Unicode characters to special
 		 escaped sequences.  This would let you backup and
 		 restore filenames that are created with any Unicode
@@ -37,6 +54,7 @@ uni_xlate=<bool> -- Translate unhandled 
 		 illegal on the vfat filesystem.  The escape sequence
 		 that gets used is ':' and the four digits of hexadecimal
 		 unicode.
+
 nonumtail=<bool> -- When creating 8.3 aliases, normally the alias will
                  end in '~1' or tilde followed by some number.  If this
                  option is set, then if the filename is 
@@ -45,6 +63,7 @@ nonumtail=<bool> -- When creating 8.3 al
                  be the short alias instead of 'longfi~1.txt'. 
                   
 quiet         -- Stops printing certain warning messages.
+
 check=s|r|n   -- Case sensitivity checking setting.
                  s: strict, case sensitive
                  r: relaxed, case insensitive
_
