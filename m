Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266578AbUGPQge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266578AbUGPQge (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 12:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266583AbUGPQgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 12:36:31 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:61445 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S266578AbUGPQfX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 12:35:23 -0400
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] FAT: kill nls default
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 17 Jul 2004 01:35:08 +0900
Message-ID: <87pt6vlxkz.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, fatfs was using NLS_DEFAULT if users didn't specify the
codepage or iocharset option. This became cause of trouble (filename
access).

This patch removes the complicated default config in kernel.

Instead of it, by default, fatfs uses builtin nls ("default"), also
reports it and mounts as read-only.  This default will limit the
access more or less.  Note: If peoples want to write on this default,
it still can switch by remount.

Therefore, basically users will need to specify mount options always.
("codepage" for msdos, and "codepage" and "iocharset" for vfat)
However, it can be done simply by script or shell alias or something
else in userland.


Thanks to Andries Brouwer for your many advice.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 Documentation/filesystems/vfat.txt |   11 ++-
 fs/Kconfig                         |   57 -----------------
 fs/fat/inode.c                     |  120 ++++++++++++++++++++++---------------
 3 files changed, 82 insertions(+), 106 deletions(-)

diff -puN fs/Kconfig~fat_default-nls fs/Kconfig
--- linux-2.6.8-rc1/fs/Kconfig~fat_default-nls	2004-07-16 04:33:50.000000000 +0900
+++ linux-2.6.8-rc1-hirofumi/fs/Kconfig	2004-07-16 04:33:50.000000000 +0900
@@ -554,44 +554,6 @@ menu "DOS/FAT/NT Filesystems"
 config FAT_FS
 	tristate
 	select NLS
-	help
-	  If you want to use one of the FAT-based file systems (the MS-DOS,
-	  VFAT (Windows 95) and UMSDOS (used to run Linux on top of an
-	  ordinary DOS partition) file systems), then you must say Y or M here
-	  to include FAT support. You will then be able to mount partitions or
-	  diskettes with FAT-based file systems and transparently access the
-	  files on them, i.e. MSDOS files will look and behave just like all
-	  other Unix files.
-
-	  This FAT support is not a file system in itself, it only provides
-	  the foundation for the other file systems. You will have to say Y or
-	  M to at least one of "MSDOS fs support" or "VFAT fs support" in
-	  order to make use of it.
-
-	  Another way to read and write MSDOS floppies and hard drive
-	  partitions from within Linux (but not transparently) is with the
-	  mtools ("man mtools") program suite. You don't need to say Y here in
-	  order to do that.
-
-	  If you need to move large files on floppies between a DOS and a
-	  Linux box, say Y here, mount the floppy under Linux with an MSDOS
-	  file system and use GNU tar's M option. GNU tar is a program
-	  available for Unix and DOS ("man tar" or "info tar").
-
-	  It is now also becoming possible to read and write compressed FAT
-	  file systems; read <file:Documentation/filesystems/fat_cvf.txt> for
-	  details.
-
-	  The FAT support will enlarge your kernel by about 37 KB. If unsure,
-	  say Y.
-
-	  To compile this as a module, choose M here: the module will be called
-	  fat.  Note that if you compile the FAT support as a module, you
-	  cannot compile any of the FAT-based file systems into the kernel
-	  -- they will have to be modules as well.
-	  The file system of your root partition (the one containing the
-	  directory /) cannot be a module, so don't say M here if you intend
-	  to use UMSDOS as your root file system.
 
 config MSDOS_FS
 	tristate "MSDOS fs support"
@@ -644,25 +606,6 @@ config VFAT_FS
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
--- linux-2.6.8-rc1/fs/fat/inode.c~fat_default-nls	2004-07-16 04:33:50.000000000 +0900
+++ linux-2.6.8-rc1-hirofumi/fs/fat/inode.c	2004-07-16 04:53:50.000000000 +0900
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
+	if (sbi->options.iocharset) {
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
+			if (opts->iocharset)
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
 
@@ -785,6 +768,66 @@ static struct export_operations fat_expo
 	.get_parent	= fat_get_parent,
 };
 
+static int fat_load_nls(struct super_block *sb)
+{
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+	struct fat_mount_options *opts = &sbi->options;
+	char codepage[50], *iocharset;
+	int error = 0, not_specified = 0;
+
+	if (opts->codepage)
+		snprintf(codepage, sizeof(codepage), "cp%d", opts->codepage);
+	else {
+		not_specified = 1;
+		strcpy(codepage, "default");
+	}
+	sbi->nls_disk = load_nls(codepage);
+	if (sbi->nls_disk == NULL) {
+		printk(KERN_ERR "FAT: codepage %s not found\n", codepage);
+		error = -EINVAL;
+		goto out;
+	}
+
+	if (opts->isvfat) {
+		if (opts->iocharset)
+			iocharset = opts->iocharset;
+		else {
+			not_specified = 1;
+			iocharset = "default";
+		}
+		/*
+		 * FIXME: utf8 is using iocharset for upper/lower conversion
+		 * UTF8 doesn't provide FAT semantics
+		 */
+		if (!strcmp(iocharset, "utf8")) {
+			printk(KERN_WARNING
+			       "FAT: utf8 is not a recommended IO charset"
+			       " for FAT filesystem,"
+			       " filesystem will be case sensitive!\n");
+		}
+		sbi->nls_io = load_nls(iocharset);
+		if (sbi->nls_io == NULL) {
+			printk(KERN_ERR "FAT: IO charset %s not found\n",
+			       iocharset);
+			error = -EINVAL;
+			goto out;
+		}
+	}
+
+	if (not_specified) {
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
@@ -800,7 +843,6 @@ int fat_fill_super(struct super_block *s
 	int debug, first;
 	unsigned int media;
 	long error;
-	char buf[50];
 
 	sbi = kmalloc(sizeof(struct msdos_sb_info), GFP_KERNEL);
 	if (!sbi)
@@ -1015,23 +1057,9 @@ int fat_fill_super(struct super_block *s
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
@@ -1065,7 +1093,7 @@ out_fail:
 		unload_nls(sbi->nls_io);
 	if (sbi->nls_disk)
 		unload_nls(sbi->nls_disk);
-	if (sbi->options.iocharset != fat_default_iocharset)
+	if (sbi->options.iocharset)
 		kfree(sbi->options.iocharset);
 	sb->s_fs_info = NULL;
 	kfree(sbi);
diff -puN Documentation/filesystems/vfat.txt~fat_default-nls Documentation/filesystems/vfat.txt
--- linux-2.6.8-rc1/Documentation/filesystems/vfat.txt~fat_default-nls	2004-07-16 04:33:50.000000000 +0900
+++ linux-2.6.8-rc1-hirofumi/Documentation/filesystems/vfat.txt	2004-07-16 04:33:50.000000000 +0900
@@ -19,18 +19,23 @@ fmask=###     -- The permission mask for
 
 codepage=###  -- Sets the codepage number for converting to shortname
 		 characters on FAT filesystem.
-		 By default, FAT_DEFAULT_CODEPAGE setting is used.
+
+		 NOTE: If this option was not specified, the file name
+		 may not be read/written rightly, also filesystem is
+		 mounted as read-only.
 
 iocharset=name -- Character set to use for converting between the
 		 encoding is used for user visible filename and 16 bit
 		 Unicode characters. Long filenames are stored on disk
 		 in Unicode format, but Unix for the most part doesn't
 		 know how to deal with Unicode.
-		 By default, FAT_DEFAULT_IOCHARSET setting is used.
-
 		 There is also an option of doing UTF8 translations
 		 with the utf8 option.
 
+		 NOTE: If this option was not specified, the file name
+		 may not be read/written rightly, also filesystem is
+		 mounted as read-only.
+
 		 NOTE: "iocharset=utf8" is not recommended. If unsure,
 		 you should consider the following option instead.
 
_
