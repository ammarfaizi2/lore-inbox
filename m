Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261384AbSJMANh>; Sat, 12 Oct 2002 20:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261385AbSJMANh>; Sat, 12 Oct 2002 20:13:37 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:53001 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S261384AbSJMANY>; Sat, 12 Oct 2002 20:13:24 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] merges parse_options() of fat and parse_options() of vfat (2/5)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 13 Oct 2002 09:19:09 +0900
Message-ID: <87bs5zb37m.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This merges parse_options() of fat and parse_options() of vfat.
And this doesn't recognize the unknown options.

Please apply.


 fs/fat/inode.c  |  148 +++++++++++++++++++++++++++++++++-------------
 fs/vfat/namei.c |  104 +-------------------------------
 2 files changed, 111 insertions(+), 141 deletions(-)
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

diff -urNp fat_super_err_fix/fs/fat/inode.c fat_vfat_opt_shift/fs/fat/inode.c
--- fat_super_err_fix/fs/fat/inode.c	2002-10-13 03:18:25.000000000 +0900
+++ fat_vfat_opt_shift/fs/fat/inode.c	2002-10-13 07:30:59.000000000 +0900
@@ -201,38 +201,54 @@ void fat_put_super(struct super_block *s
 	kfree(sbi);
 }
 
+static int simple_getbool(char *s, int *setval)
+{
+	if (s) {
+		if (!strcmp(s,"1") || !strcmp(s,"yes") || !strcmp(s,"true"))
+			*setval = 1;
+		else if (!strcmp(s,"0") || !strcmp(s,"no") || !strcmp(s,"false"))
+			*setval = 0;
+		else
+			return 0;
+	} else
+		*setval = 1;
+	return 1;
+}
 
-static int parse_options(char *options, int *debug,
+static int parse_options(char *options, int is_vfat, int *debug,
 			 struct fat_mount_options *opts,
 			 char *cvf_format, char *cvf_options)
 {
-	char *this_char,*value,save,*savep;
-	char *p;
-	int ret = 1, len;
+	char *this_char, *value, *p;
+	int ret = 1, val, len;
+
+	opts->isvfat = is_vfat;
 
-	opts->name_check = 'n';
-	opts->conversion = 'b';
 	opts->fs_uid = current->uid;
 	opts->fs_gid = current->gid;
 	opts->fs_umask = current->fs->umask;
-	opts->quiet = opts->sys_immutable = opts->dotsOK = opts->showexec = 0;
 	opts->codepage = 0;
-	opts->nocase = 0;
-	opts->shortname = 0;
-	opts->utf8 = 0;
 	opts->iocharset = NULL;
+	if (is_vfat)
+		opts->shortname = VFAT_SFN_DISPLAY_LOWER|VFAT_SFN_CREATE_WIN95;
+	else
+		opts->shortname = 0;
+	opts->name_check = 'n';
+	opts->conversion = 'b';
+	opts->quiet = opts->showexec = opts->sys_immutable = opts->dotsOK =  0;
+	opts->utf8 = opts->unicode_xlate = opts->posixfs = 0;
+	opts->numtail = 1;
+	opts->nocase = 0;
 	*debug = 0;
 
 	if (!options)
 		goto out;
-	save = 0;
-	savep = NULL;
 	while ((this_char = strsep(&options,",")) != NULL) {
-		if ((value = strchr(this_char,'=')) != NULL) {
-			save = *value;
-			savep = value;
+		if (!*this_char)
+			continue;
+		if ((value = strchr(this_char,'=')) != NULL)
 			*value++ = 0;
-		}
+
 		if (!strcmp(this_char,"check") && value) {
 			if (value[0] && !value[1] && strchr("rns",*value))
 				opts->name_check = *value;
@@ -255,23 +271,18 @@ static int parse_options(char *options, 
 				opts->conversion = 'a';
 			else ret = 0;
 		}
-		else if (!strcmp(this_char,"dots")) {
-			opts->dotsOK = 1;
-		}
 		else if (!strcmp(this_char,"nocase")) {
-			opts->nocase = 1;
-		}
-		else if (!strcmp(this_char,"nodots")) {
-			opts->dotsOK = 0;
+			if (!is_vfat)
+				opts->nocase = 1;
+			else {
+				/* for backward compatible */
+				opts->shortname = VFAT_SFN_DISPLAY_WIN95
+					| VFAT_SFN_CREATE_WIN95;
+			}
 		}
 		else if (!strcmp(this_char,"showexec")) {
 			opts->showexec = 1;
 		}
-		else if (!strcmp(this_char,"dotsOK") && value) {
-			if (!strcmp(value,"yes")) opts->dotsOK = 1;
-			else if (!strcmp(value,"no")) opts->dotsOK = 0;
-			else ret = 0;
-		}
 		else if (!strcmp(this_char,"uid")) {
 			if (!value || !*value) ret = 0;
 			else {
@@ -317,7 +328,32 @@ static int parse_options(char *options, 
 			opts->codepage = simple_strtoul(value,&value,0);
 			if (*value) ret = 0;
 		}
-		else if (!strcmp(this_char,"iocharset") && value) {
+		else if (!strcmp(this_char,"cvf_format")) {
+			if (!value)
+				return 0;
+			strncpy(cvf_format,value,20);
+		}
+		else if (!strcmp(this_char,"cvf_options")) {
+			if (!value)
+				return 0;
+			strncpy(cvf_options,value,100);
+		}
+
+		/* msdos specific */
+		else if (!is_vfat && !strcmp(this_char,"dots")) {
+			opts->dotsOK = 1;
+		}
+		else if (!is_vfat && !strcmp(this_char,"nodots")) {
+			opts->dotsOK = 0;
+		}
+		else if (!is_vfat && !strcmp(this_char,"dotsOK") && value) {
+			if (!strcmp(value,"yes")) opts->dotsOK = 1;
+			else if (!strcmp(value,"no")) opts->dotsOK = 0;
+			else ret = 0;
+		}
+
+		/* vfat specific */
+		else if (is_vfat && !strcmp(this_char,"iocharset") && value) {
 			p = value;
 			while (*value && *value != ',')
 				value++;
@@ -338,23 +374,54 @@ static int parse_options(char *options, 
 					ret = 0;
 			}
 		}
-		else if (!strcmp(this_char,"cvf_format")) {
-			if (!value)
-				return 0;
-			strncpy(cvf_format,value,20);
+		else if (is_vfat && !strcmp(this_char,"utf8")) {
+			ret = simple_getbool(value, &val);
+			if (ret) opts->utf8 = val;
+		}
+		else if (is_vfat && !strcmp(this_char,"uni_xlate")) {
+			ret = simple_getbool(value, &val);
+			if (ret) opts->unicode_xlate = val;
+		}
+		else if (is_vfat && !strcmp(this_char,"posix")) {
+			ret = simple_getbool(value, &val);
+			if (ret) opts->posixfs = val;
+		}
+		else if (is_vfat && !strcmp(this_char,"nonumtail")) {
+			ret = simple_getbool(value, &val);
+			if (ret) {
+				opts->numtail = !val;
+			}
 		}
-		else if (!strcmp(this_char,"cvf_options")) {
-			if (!value)
-				return 0;
-			strncpy(cvf_options,value,100);
+		else if (is_vfat && !strcmp(this_char, "shortname")) {
+			if (!strcmp(value, "lower"))
+				opts->shortname = VFAT_SFN_DISPLAY_LOWER
+						| VFAT_SFN_CREATE_WIN95;
+			else if (!strcmp(value, "win95"))
+				opts->shortname = VFAT_SFN_DISPLAY_WIN95
+						| VFAT_SFN_CREATE_WIN95;
+			else if (!strcmp(value, "winnt"))
+				opts->shortname = VFAT_SFN_DISPLAY_WINNT
+						| VFAT_SFN_CREATE_WINNT;
+			else if (!strcmp(value, "mixed"))
+				opts->shortname = VFAT_SFN_DISPLAY_WINNT
+						| VFAT_SFN_CREATE_WIN95;
+			else
+				ret = 0;
+		} else {
+			printk("FAT: Unrecognized mount option %s\n",
+			       this_char);
+			ret = 0;
 		}
 
-		if (options) *(options-1) = ',';
-		if (value) *savep = save;
 		if (ret == 0)
 			break;
 	}
 out:
+	if (opts->posixfs)
+		opts->name_check = 's';
+	if (opts->unicode_xlate)
+		opts->utf8 = 0;
+	
 	return ret;
 }
 
@@ -658,12 +725,11 @@ int fat_fill_super(struct super_block *s
 	sb->s_magic = MSDOS_SUPER_MAGIC;
 	sb->s_op = &fat_sops;
 	sb->s_export_op = &fat_export_ops;
-	sbi->options.isvfat = isvfat;
 	sbi->dir_ops = fs_dir_inode_ops;
 	sbi->cvf_format = &default_cvf;
 
 	error = -EINVAL;
-	if (!parse_options((char *)data, &debug, &sbi->options,
+	if (!parse_options((char *)data, isvfat, &debug, &sbi->options,
 			   cvf_format, cvf_options))
 		goto out_fail;
 
diff -urNp fat_super_err_fix/fs/vfat/namei.c fat_vfat_opt_shift/fs/vfat/namei.c
--- fat_super_err_fix/fs/vfat/namei.c	2002-10-13 03:18:25.000000000 +0900
+++ fat_vfat_opt_shift/fs/vfat/namei.c	2002-10-13 03:31:53.000000000 +0900
@@ -80,93 +80,6 @@ static int vfat_revalidate(struct dentry
 	return 0;
 }
 
-static int simple_getbool(char *s, int *setval)
-{
-	if (s) {
-		if (!strcmp(s,"1") || !strcmp(s,"yes") || !strcmp(s,"true")) {
-			*setval = 1;
-		} else if (!strcmp(s,"0") || !strcmp(s,"no") || !strcmp(s,"false")) {
-			*setval = 0;
-		} else {
-			return 0;
-		}
-	} else {
-		*setval = 1;
-	}
-	return 1;
-}
-
-static int parse_options(char *options,	struct fat_mount_options *opts)
-{
-	char *this_char,*value,save,*savep;
-	int ret, val;
-
-	opts->unicode_xlate = opts->posixfs = 0;
-	opts->numtail = 1;
-	opts->utf8 = 0;
-	opts->shortname = VFAT_SFN_DISPLAY_LOWER | VFAT_SFN_CREATE_WIN95;
-	/* for backward compatible */
-	if (opts->nocase) {
-		opts->nocase = 0;
-		opts->shortname = VFAT_SFN_DISPLAY_WIN95
-		  		| VFAT_SFN_CREATE_WIN95;
-	}
-
-	if (!options) return 1;
-	save = 0;
-	savep = NULL;
-	ret = 1;
-	while ((this_char = strsep(&options,",")) != NULL) {
-		if ((value = strchr(this_char,'=')) != NULL) {
-			save = *value;
-			savep = value;
-			*value++ = 0;
-		}
-		if (!strcmp(this_char,"utf8")) {
-			ret = simple_getbool(value, &val);
-			if (ret) opts->utf8 = val;
-		} else if (!strcmp(this_char,"uni_xlate")) {
-			ret = simple_getbool(value, &val);
-			if (ret) opts->unicode_xlate = val;
-		} else if (!strcmp(this_char,"posix")) {
-			ret = simple_getbool(value, &val);
-			if (ret) opts->posixfs = val;
-		} else if (!strcmp(this_char,"nonumtail")) {
-			ret = simple_getbool(value, &val);
-			if (ret) {
-				opts->numtail = !val;
-			}
-		} else if (!strcmp(this_char, "shortname")) {
-			if (!strcmp(value, "lower"))
-				opts->shortname = VFAT_SFN_DISPLAY_LOWER
-						| VFAT_SFN_CREATE_WIN95;
-			else if (!strcmp(value, "win95"))
-				opts->shortname = VFAT_SFN_DISPLAY_WIN95
-						| VFAT_SFN_CREATE_WIN95;
-			else if (!strcmp(value, "winnt"))
-				opts->shortname = VFAT_SFN_DISPLAY_WINNT
-						| VFAT_SFN_CREATE_WINNT;
-			else if (!strcmp(value, "mixed"))
-				opts->shortname = VFAT_SFN_DISPLAY_WINNT
-						| VFAT_SFN_CREATE_WIN95;
-			else
-				ret = 0;
-		}
-		if (options)
-			*(options-1) = ',';
-		if (value) {
-			*savep = save;
-		}
-		if (ret == 0) {
-			return 0;
-		}
-	}
-	if (opts->unicode_xlate) {
-		opts->utf8 = 0;
-	}
-	return 1;
-}
-
 static inline unsigned char
 vfat_tolower(struct nls_table *t, unsigned char c)
 {
@@ -1281,24 +1194,15 @@ struct inode_operations vfat_dir_inode_o
 int vfat_fill_super(struct super_block *sb, void *data, int silent)
 {
 	int res;
-	struct msdos_sb_info *sbi;
-  
+
 	res = fat_fill_super(sb, data, silent, &vfat_dir_inode_operations, 1);
 	if (res)
 		return res;
 
-	sbi = MSDOS_SB(sb);
-
-	if (parse_options((char *) data, &(sbi->options))) {
-		sbi->options.dotsOK = 0;
-		if (sbi->options.posixfs) {
-			sbi->options.name_check = 's';
-		}
-	}
-	if (sbi->options.name_check != 's') {
+	if (MSDOS_SB(sb)->options.name_check != 's')
 		sb->s_root->d_op = &vfat_dentry_ops[0];
-	} else {
+	else
 		sb->s_root->d_op = &vfat_dentry_ops[2];
-	}
+
 	return 0;
 }
