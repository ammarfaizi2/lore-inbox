Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265883AbUFTOnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265883AbUFTOnH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 10:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265879AbUFTOnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 10:43:06 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:43786 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S265883AbUFTOmE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 10:42:04 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] FAT: doesn't recognize "iocharset=utf8" and doesn't use
 NLS_DEFAULT
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 20 Jun 2004 23:41:51 +0900
Message-ID: <87659mjnps.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Recently, the distributor has set "utf8" to NLS_DEFAULT, therefore,
FAT uses the "iocharset=utf8" as default.  But, since "iocharset=utf8"
doesn't provide the function (lower <-> upper conversion) which FAT
needs, so FAT can't provide suitable behavior.

Then, this patch does,

     - doesn't recognize "utf8" as "iocharset"
     - doesn't use NLS_DEFAULT as default "iocharset"
     - instead of NLS_DEFAULT, adds FAT_DEFAULT_CODEPAGE and
       FAT_DEFAULT_IOCHARSET
     
NOTE: the following looks like buggy, so it's not recommended

    "codepage=437,iocharset=iso8859-1,utf8"

however, some utf8 file name can handle. (in this case, it uses the
table of iso8859-1 for lower <-> upper conversion)


Sign-off-by: Jesse Barnes <jbarnes@engr.sgi.com>
Sign-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


---

 fs/Kconfig     |   19 ++++++++++++
 fs/fat/inode.c |   88 +++++++++++++++++++++++++++++----------------------------
 2 files changed, 65 insertions(+), 42 deletions(-)

diff -puN fs/Kconfig~fat_default-nls fs/Kconfig
--- linux-2.6.7/fs/Kconfig~fat_default-nls	2004-06-20 03:30:39.000000000 +0900
+++ linux-2.6.7-hirofumi/fs/Kconfig	2004-06-20 03:30:39.000000000 +0900
@@ -672,6 +672,25 @@ config VFAT_FS
 	  To compile this as a module, choose M here: the module will be called
 	  vfat.
 
+config FAT_DEFAULT_CODEPAGE
+	int "Default codepage for FAT"
+	depends on MSDOS_FS || VFAT_FS
+	default 437
+	help
+	  This option should be set to the codepage of your FAT filesystems.
+	  It can be overridden with the 'codepage' mount option.
+
+config FAT_DEFAULT_IOCHARSET
+	string "Default iocharset for FAT"
+	depends on VFAT_FS
+	default "iso8859-1"
+	help
+	  Set this to the default I/O character set you'd like FAT to use.
+	  It should probably match the character set that most of your
+	  FAT filesystems use, and can be overridded with the 'iocharset'
+	  mount option for FAT filesystems.  Note that UTF8 is *not* a
+	  supported charset for FAT filesystems.
+
 config UMSDOS_FS
 #dep_tristate '    UMSDOS: Unix-like file system on top of standard MSDOS fs' CONFIG_UMSDOS_FS $CONFIG_MSDOS_FS
 # UMSDOS is temprory broken
diff -puN fs/fat/inode.c~fat_default-nls fs/fat/inode.c
--- linux-2.6.7/fs/fat/inode.c~fat_default-nls	2004-06-20 03:30:39.000000000 +0900
+++ linux-2.6.7-hirofumi/fs/fat/inode.c	2004-06-20 03:30:39.000000000 +0900
@@ -23,6 +23,14 @@
 #include <linux/parser.h>
 #include <asm/unaligned.h>
 
+#ifndef CONFIG_FAT_DEFAULT_IOCHARSET
+/* if user don't select VFAT, this is undefined. */
+#define CONFIG_FAT_DEFAULT_IOCHARSET	""
+#endif
+
+static int fat_default_codepage = CONFIG_FAT_DEFAULT_CODEPAGE;
+static char fat_default_iocharset[] = CONFIG_FAT_DEFAULT_IOCHARSET;
+
 /*
  * New FAT inode stuff. We do the following:
  *	a) i_ino is constant and has nothing with on-disk location.
@@ -166,20 +174,17 @@ void fat_put_super(struct super_block *s
 	if (sbi->nls_disk) {
 		unload_nls(sbi->nls_disk);
 		sbi->nls_disk = NULL;
-		sbi->options.codepage = 0;
+		sbi->options.codepage = fat_default_codepage;
 	}
 	if (sbi->nls_io) {
 		unload_nls(sbi->nls_io);
 		sbi->nls_io = NULL;
 	}
-	/*
-	 * Note: the iocharset option might have been specified
-	 * without enabling nls_io, so check for it here.
-	 */
-	if (sbi->options.iocharset) {
+	if (sbi->options.iocharset != fat_default_iocharset) {
 		kfree(sbi->options.iocharset);
-		sbi->options.iocharset = NULL;
+		sbi->options.iocharset = fat_default_iocharset;
 	}
+
 	sb->s_fs_info = NULL;
 	kfree(sbi);
 }
@@ -196,11 +201,11 @@ static int fat_show_options(struct seq_f
 		seq_printf(m, ",gid=%u", opts->fs_gid);
 	seq_printf(m, ",fmask=%04o", opts->fs_fmask);
 	seq_printf(m, ",dmask=%04o", opts->fs_dmask);
-	if (sbi->nls_disk)
+	if (sbi->nls_disk && opts->codepage != fat_default_codepage)
 		seq_printf(m, ",codepage=%s", sbi->nls_disk->charset);
 	if (isvfat) {
-		if (sbi->nls_io
-		    && strcmp(sbi->nls_io->charset, CONFIG_NLS_DEFAULT))
+		if (sbi->nls_io &&
+		    strcmp(opts->iocharset, fat_default_iocharset))
 			seq_printf(m, ",iocharset=%s", sbi->nls_io->charset);
 
 		switch (opts->shortname) {
@@ -331,14 +336,15 @@ static int parse_options(char *options, 
 	char *p;
 	substring_t args[MAX_OPT_ARGS];
 	int option;
+	char *iocharset;
 
 	opts->isvfat = is_vfat;
 
 	opts->fs_uid = current->uid;
 	opts->fs_gid = current->gid;
 	opts->fs_fmask = opts->fs_dmask = current->fs->umask;
-	opts->codepage = 0;
-	opts->iocharset = NULL;
+	opts->codepage = fat_default_codepage;
+	opts->iocharset = fat_default_iocharset;
 	if (is_vfat)
 		opts->shortname = VFAT_SFN_DISPLAY_LOWER|VFAT_SFN_CREATE_WIN95;
 	else
@@ -351,7 +357,7 @@ static int parse_options(char *options, 
 	*debug = 0;
 
 	if (!options)
-		return 1;
+		return 0;
 
 	while ((p = strsep(&options, ",")) != NULL) {
 		int token;
@@ -437,10 +443,12 @@ static int parse_options(char *options, 
 
 		/* vfat specific */
 		case Opt_charset:
-			kfree(opts->iocharset);
-			opts->iocharset = match_strdup(&args[0]);
-			if (!opts->iocharset)
-				return 0;
+			if (opts->iocharset != fat_default_iocharset)
+				kfree(opts->iocharset);
+			iocharset = match_strdup(&args[0]);
+			if (!iocharset)
+				return -ENOMEM;
+			opts->iocharset = iocharset;
 			break;
 		case Opt_shortname_lower:
 			opts->shortname = VFAT_SFN_DISPLAY_LOWER
@@ -486,14 +494,20 @@ static int parse_options(char *options, 
 		default:
 			printk(KERN_ERR "FAT: Unrecognized mount option \"%s\" "
 			       "or missing value\n", p);
-			return 0;
+			return -EINVAL;
 		}
 	}
+	/* UTF8 doesn't provide FAT semantics */
+	if (!strcmp(opts->iocharset, "utf8")) {
+		printk(KERN_ERR "FAT: utf8 is not a valid IO charset"
+		       " for FAT filesystems\n");
+		return -EINVAL;
+	}
 
 	if (opts->unicode_xlate)
 		opts->utf8 = 0;
 	
-	return 1;
+	return 0;
 }
 
 static int fat_calc_dir_size(struct inode *inode)
@@ -784,7 +798,7 @@ int fat_fill_super(struct super_block *s
 	struct msdos_sb_info *sbi;
 	u16 logical_sector_size;
 	u32 total_sectors, total_clusters, fat_clusters, rootdir_sectors;
-	int debug, cp, first;
+	int debug, first;
 	unsigned int media;
 	long error;
 	char buf[50];
@@ -801,8 +815,8 @@ int fat_fill_super(struct super_block *s
 	sb->s_export_op = &fat_export_ops;
 	sbi->dir_ops = fs_dir_inode_ops;
 
-	error = -EINVAL;
-	if (!parse_options(data, isvfat, &debug, &sbi->options))
+	error = parse_options(data, isvfat, &debug, &sbi->options);
+	if (error)
 		goto out_fail;
 
 	fat_cache_init(sb);
@@ -1009,31 +1023,21 @@ int fat_fill_super(struct super_block *s
 	}
 
 	error = -EINVAL;
-	cp = sbi->options.codepage ? sbi->options.codepage : 437;
-	sprintf(buf, "cp%d", cp);
+	sprintf(buf, "cp%d", sbi->options.codepage);
 	sbi->nls_disk = load_nls(buf);
 	if (!sbi->nls_disk) {
-		/* Fail only if explicit charset specified */
-		if (sbi->options.codepage != 0) {
-			printk(KERN_ERR "FAT: codepage %s not found\n", buf);
-			goto out_fail;
-		}
-		sbi->options.codepage = 0; /* already 0?? */
-		sbi->nls_disk = load_nls_default();
+		printk(KERN_ERR "FAT: codepage %s not found\n", buf);
+		goto out_fail;
 	}
 
 	/* FIXME: utf8 is using iocharset for upper/lower conversion */
 	if (sbi->options.isvfat) {
-		if (sbi->options.iocharset != NULL) {
-			sbi->nls_io = load_nls(sbi->options.iocharset);
-			if (!sbi->nls_io) {
-				printk(KERN_ERR
-				       "FAT: IO charset %s not found\n",
-				       sbi->options.iocharset);
-				goto out_fail;
-			}
-		} else
-			sbi->nls_io = load_nls_default();
+		sbi->nls_io = load_nls(sbi->options.iocharset);
+		if (!sbi->nls_io) {
+			printk(KERN_ERR "FAT: IO charset %s not found\n",
+			       sbi->options.iocharset);
+			goto out_fail;
+		}
 	}
 
 	error = -ENOMEM;
@@ -1068,7 +1072,7 @@ out_fail:
 		unload_nls(sbi->nls_io);
 	if (sbi->nls_disk)
 		unload_nls(sbi->nls_disk);
-	if (sbi->options.iocharset)
+	if (sbi->options.iocharset != fat_default_iocharset)
 		kfree(sbi->options.iocharset);
 	sb->s_fs_info = NULL;
 	kfree(sbi);

_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
