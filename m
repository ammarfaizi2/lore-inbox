Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314485AbSEYL4b>; Sat, 25 May 2002 07:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314494AbSEYL4a>; Sat, 25 May 2002 07:56:30 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:44548 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S314485AbSEYL40>; Sat, 25 May 2002 07:56:26 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] cleanup parse_options() of fatfs (3/4)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 25 May 2002 20:56:16 +0900
Message-ID: <87y9e8zbj3.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch merges the parse_options() of vfat and fat. And, added the
(borrowed from ext3) code for reporting the error of specified
options.

Please apply.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

diff -urN fat_utf8_oops-2.5.18/fs/fat/inode.c fat_parse_opt-2.5.18/fs/fat/inode.c
--- fat_utf8_oops-2.5.18/fs/fat/inode.c	Sat May 25 17:14:49 2002
+++ fat_parse_opt-2.5.18/fs/fat/inode.c	Sat May 25 17:19:33 2002
@@ -201,163 +201,256 @@
 	kfree(sbi);
 }
 
+static int invalid_option(char *value, char *option)
+{
+	printk(KERN_NOTICE "FAT: Invalid %s option: %s\n", option, value);
+	return -EINVAL;
+}
+
+static int want_value(char *value, char *option)
+{
+	if (!value || !*value) {
+		printk(KERN_NOTICE "FAT: the %s option needs an argument\n",
+		       option);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int
+__want_numeric(char *value, char *option, unsigned long *number, int base)
+{
+	char *endp;
+	if (want_value(value, option))
+		return -EINVAL;
+	*number = simple_strtoul(value, &endp, base);
+	if (*endp) {
+		printk(KERN_NOTICE "FAT: Invalid %s argument: %s\n",
+		       option, value);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static inline int want_numeric(char *value, char *option, unsigned long *number)
+{
+	return __want_numeric(value, option, number, 0);
+}
+
+static inline int want_oct(char *value, char *option, unsigned long *number)
+{
+	return __want_numeric(value, option, number, 8);
+}
+
+static int want_bool(char *v, char *option, unsigned long *setval)
+{
+	if (v == NULL) {
+		*setval = 1;
+		return 0;
+	}
 
-static int parse_options(char *options, int *debug,
+	if (want_value(v, option))
+		return -EINVAL;
+	if (!strcmp(v, "1") || !strcmp(v, "yes") || !strcmp(v, "true"))
+		*setval = 1;
+	else if (!strcmp(v, "0") || !strcmp(v, "no") || !strcmp(v, "false"))
+		*setval = 0;
+	else {
+		invalid_option(v, option);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int parse_options(char *options, int is_vfat, int *debug,
 			 struct fat_mount_options *opts,
 			 char *cvf_format, char *cvf_options)
 {
-	char *this_char,*value,save,*savep;
-	char *p;
-	int ret = 1, len;
+	char *this_char, *value;
+	unsigned long val;
 
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
+	opts->shortname = 0;
+	if (is_vfat)
+		opts->shortname = VFAT_SFN_DISPLAY_LOWER|VFAT_SFN_CREATE_WIN95;
+	opts->name_check = 'n';
+	opts->conversion = 'b';
+	opts->quiet = opts->showexec = opts->sys_immutable = opts->dotsOK =  0;
+	opts->isvfat = is_vfat;
+	opts->utf8 = opts->unicode_xlate = opts->posixfs = 0;
+	opts->numtail = 1;
+	opts->nocase = 0;
 	*debug = 0;
 
 	if (!options)
-		goto out;
-	save = 0;
-	savep = NULL;
-	while ((this_char = strsep(&options,",")) != NULL) {
+		return 0;
+	while ((this_char = strsep(&options, ",")) != NULL) {
 		if (!*this_char)
 			continue;
-		if ((value = strchr(this_char,'=')) != NULL) {
-			save = *value;
-			savep = value;
+		if ((value = strchr(this_char, '=')) != NULL)
 			*value++ = 0;
-		}
-		if (!strcmp(this_char,"check") && value) {
-			if (value[0] && !value[1] && strchr("rns",*value))
+
+		if (!strcmp(this_char, "debug"))
+			*debug = 1;
+		else if (!strcmp(this_char, "uid")) {
+			if (want_numeric(value, "uid", &val))
+				goto error;
+			opts->fs_uid = val;
+		}
+		else if (!strcmp(this_char, "gid")) {
+			if (want_numeric(value, "gid", &val))
+				goto error;
+			opts->fs_gid = val;
+		}
+		else if (!strcmp(this_char, "umask")) {
+			if (want_oct(value, "umask", &val))
+				goto error;
+			opts->fs_umask = val & S_IRWXUGO;
+		}
+		else if (!strcmp(this_char, "codepage")) {
+			if (want_numeric(value, "codepage", &val))
+				goto error;
+			opts->codepage = val;
+		}
+		else if (!strcmp(this_char, "check")) {
+			if (want_value(value, "check"))
+				goto error;
+			if (!value[1] && strchr("rns", *value))
 				opts->name_check = *value;
-			else if (!strcmp(value,"relaxed"))
+			else if (!strcmp(value, "relaxed"))
 				opts->name_check = 'r';
-			else if (!strcmp(value,"normal"))
+			else if (!strcmp(value, "normal"))
 				opts->name_check = 'n';
-			else if (!strcmp(value,"strict"))
+			else if (!strcmp(value, "strict"))
 				opts->name_check = 's';
-			else ret = 0;
+			else
+				return invalid_option(value, "check");
 		}
-		else if (!strcmp(this_char,"conv") && value) {
-			if (value[0] && !value[1] && strchr("bta",*value))
+		else if (!strcmp(this_char, "conv")) {
+			if (want_value(value, "conv"))
+				goto error;
+			if (!value[1] && strchr("bta", *value))
 				opts->conversion = *value;
-			else if (!strcmp(value,"binary"))
+			else if (!strcmp(value, "binary"))
 				opts->conversion = 'b';
-			else if (!strcmp(value,"text"))
+			else if (!strcmp(value, "text"))
 				opts->conversion = 't';
-			else if (!strcmp(value,"auto"))
+			else if (!strcmp(value, "auto"))
 				opts->conversion = 'a';
-			else ret = 0;
+			else
+				return invalid_option(value, "conv");
 		}
-		else if (!strcmp(this_char,"dots")) {
-			opts->dotsOK = 1;
-		}
-		else if (!strcmp(this_char,"nocase")) {
-			opts->nocase = 1;
-		}
-		else if (!strcmp(this_char,"nodots")) {
-			opts->dotsOK = 0;
-		}
-		else if (!strcmp(this_char,"showexec")) {
+		else if (!strcmp(this_char, "quiet"))
+			opts->quiet = 1;
+		else if (!strcmp(this_char, "showexec"))
 			opts->showexec = 1;
-		}
-		else if (!strcmp(this_char,"dotsOK") && value) {
-			if (!strcmp(value,"yes")) opts->dotsOK = 1;
-			else if (!strcmp(value,"no")) opts->dotsOK = 0;
-			else ret = 0;
-		}
-		else if (!strcmp(this_char,"uid")) {
-			if (!value || !*value) ret = 0;
-			else {
-				opts->fs_uid = simple_strtoul(value,&value,0);
-				if (*value) ret = 0;
-			}
-		}
-		else if (!strcmp(this_char,"gid")) {
-			if (!value || !*value) ret= 0;
-			else {
-				opts->fs_gid = simple_strtoul(value,&value,0);
-				if (*value) ret = 0;
-			}
-		}
-		else if (!strcmp(this_char,"umask")) {
-			if (!value || !*value) ret = 0;
+		else if (!strcmp(this_char,"sys_immutable"))
+			opts->sys_immutable = 1;
+		else if (!strcmp(this_char, "nocase")) {
+			if (!is_vfat)
+				opts->nocase = 1;
 			else {
-				opts->fs_umask = simple_strtoul(value,&value,8);
-				if (*value) ret = 0;
+				/* for backward compatible */
+				opts->shortname = VFAT_SFN_DISPLAY_WIN95
+					| VFAT_SFN_CREATE_WIN95;
 			}
 		}
-		else if (!strcmp(this_char,"debug")) {
-			if (value) ret = 0;
-			else *debug = 1;
-		}
-		else if (!strcmp(this_char,"fat")) {
-			printk("FAT: fat option is obsolete, "
+		else if (!strcmp(this_char, "fat")) {
+			printk(KERN_NOTICE "FAT: fat option is obsolete, "
 			       "not supported now\n");
 		}
-		else if (!strcmp(this_char,"quiet")) {
-			if (value) ret = 0;
-			else opts->quiet = 1;
-		}
-		else if (!strcmp(this_char,"blocksize")) {
-			printk("FAT: blocksize option is obsolete, "
+		else if (!strcmp(this_char, "blocksize")) {
+			printk(KERN_NOTICE "FAT: blocksize option is obsolete, "
 			       "not supported now\n");
 		}
-		else if (!strcmp(this_char,"sys_immutable")) {
-			if (value) ret = 0;
-			else opts->sys_immutable = 1;
-		}
-		else if (!strcmp(this_char,"codepage") && value) {
-			opts->codepage = simple_strtoul(value,&value,0);
-			if (*value) ret = 0;
-		}
-		else if (!strcmp(this_char,"iocharset") && value) {
-			p = value;
-			while (*value && *value != ',')
-				value++;
-			len = value - p;
-			if (len) {
-				char *buffer;
-
-				if (opts->iocharset != NULL) {
-					kfree(opts->iocharset);
-					opts->iocharset = NULL;
-				}
-				buffer = kmalloc(len + 1, GFP_KERNEL);
-				if (buffer != NULL) {
-					opts->iocharset = buffer;
-					memcpy(buffer, p, len);
-					buffer[len] = 0;
-				} else
-					ret = 0;
-			}
-		}
-		else if (!strcmp(this_char,"cvf_format")) {
-			if (!value)
-				return 0;
-			strncpy(cvf_format,value,20);
-		}
-		else if (!strcmp(this_char,"cvf_options")) {
-			if (!value)
-				return 0;
-			strncpy(cvf_options,value,100);
+		else if (!strcmp(this_char, "cvf_format")) {
+			if (want_value(value, "cvf_format"))
+				goto error;
+			strncpy(cvf_format, value, 20);
+			cvf_format[19] = '\0';
+		}
+		else if (!strcmp(this_char, "cvf_options")) {
+			if (want_value(value, "cvf_options"))
+				goto error;
+			strncpy(cvf_options, value, 100);
+			cvf_options[99] = '\0';
 		}
 
-		if (this_char != options) *(this_char-1) = ',';
-		if (value) *savep = save;
-		if (ret == 0)
-			break;
+		/* msdos specific */
+		else if (!is_vfat && !strcmp(this_char, "dots"))
+			opts->dotsOK = 1;
+		else if (!is_vfat && !strcmp(this_char, "nodots"))
+			opts->dotsOK = 0;
+		else if (!is_vfat && !strcmp(this_char, "dotsOK")) {
+			if (want_bool(value, "dotsOK", &val))
+				goto error;
+			opts->dotsOK = val;
+		}
+
+		/* vfat specific */
+		else if (is_vfat && !strcmp(this_char, "iocharset")) {
+			if (want_value(value, "iocharset"))
+				goto error;
+			if (opts->iocharset != NULL)
+				kfree(opts->iocharset);
+			opts->iocharset = kmalloc(strlen(value)+1, GFP_KERNEL);
+			if (opts->iocharset == NULL)
+				return -ENOMEM;
+			strcpy(opts->iocharset, value);
+		}
+		else if (is_vfat && !strcmp(this_char, "utf8")) {
+			if (want_bool(value, "utf8", &val))
+				goto error;
+			opts->utf8 = val;
+		} else if (is_vfat && !strcmp(this_char, "uni_xlate")) {
+			if (want_bool(value, "uni_xlate", &val))
+				goto error;
+			opts->unicode_xlate = val;
+		} else if (is_vfat && !strcmp(this_char, "posix")) {
+			if (want_bool(value, "posix", &val))
+				goto error;
+			opts->posixfs = val;
+		} else if (is_vfat && !strcmp(this_char,"nonumtail")) {
+			if (want_bool(value, "nonumtail", &val))
+				goto error;
+			opts->numtail = !val;
+		} else if (is_vfat && !strcmp(this_char, "shortname")) {
+			if (want_value(value, "shortname"))
+				goto error;
+			if (!strcmp(value, "lower"))
+				opts->shortname = VFAT_SFN_DISPLAY_LOWER
+					| VFAT_SFN_CREATE_WIN95;
+			else if (!strcmp(value, "win95"))
+				opts->shortname = VFAT_SFN_DISPLAY_WIN95
+					| VFAT_SFN_CREATE_WIN95;
+			else if (!strcmp(value, "winnt"))
+				opts->shortname = VFAT_SFN_DISPLAY_WINNT
+					| VFAT_SFN_CREATE_WINNT;
+			else if (!strcmp(value, "mixed"))
+				opts->shortname = VFAT_SFN_DISPLAY_WINNT
+					| VFAT_SFN_CREATE_WIN95;
+			else
+				return invalid_option(value, "shortname");
+		} else {
+			printk(KERN_NOTICE
+			       "FAT: Unrecognized mount option %s\n",
+			       this_char);
+			goto error;
+		}
 	}
-out:
-	return ret;
+
+	if (opts->posixfs)
+		opts->name_check = 's';
+	if (opts->unicode_xlate)
+		opts->utf8 = 0;
+	
+	return 0;
+error:
+	return -EINVAL;
 }
 
 static int fat_calc_dir_size(struct inode *inode)
@@ -641,7 +734,7 @@
 	int logical_sector_size, fat_clusters, debug, cp, first;
 	unsigned int total_sectors, rootdir_sectors;
 	unsigned char media;
-	long error = -EIO;
+	long error;
 	char buf[50];
 	int i;
 	char cvf_format[21];
@@ -660,18 +753,19 @@
 	sb->s_magic = MSDOS_SUPER_MAGIC;
 	sb->s_op = &fat_sops;
 	sb->s_export_op = &fat_export_ops;
-	sbi->options.isvfat = isvfat;
 	sbi->dir_ops = fs_dir_inode_ops;
 	sbi->cvf_format = &default_cvf;
 
-	if (!parse_options((char *)data, &debug, &sbi->options,
-			   cvf_format, cvf_options))
+	error = parse_options((char *)data, isvfat, &debug, &sbi->options,
+			      cvf_format, cvf_options);
+	if (error < 0)
 		goto out_fail;
 
 	fat_cache_init();
 	/* set up enough so that it can read an inode */
 	init_MUTEX(&sbi->fat_lock);
 
+	error = -EIO;
 	sb_min_blocksize(sb, 512);
 	bh = sb_bread(sb, 0);
 	if (bh == NULL) {
@@ -848,13 +942,14 @@
 		goto out_invalid;
 	}
 
+	error = -EINVAL;
 	if (!strcmp(cvf_format, "none"))
 		i = -1;
 	else
 		i = detect_cvf(sb, cvf_format);
 	if (i >= 0) {
 		if (cvf_formats[i]->mount_cvf(sb, cvf_options))
-			goto out_invalid;
+			goto out_fail;
 	}
 
 	cp = sbi->options.codepage ? sbi->options.codepage : 437;
@@ -912,6 +1007,9 @@
 
 out_invalid:
 	error = -EINVAL;
+	if (!silent)
+		printk(KERN_INFO "VFS: Can't find a valid FAT filesystem"
+		       " on dev %s.\n", sb->s_id);
 
 out_fail:
 	if (root_inode)
diff -urN fat_utf8_oops-2.5.18/fs/msdos/namei.c fat_parse_opt-2.5.18/fs/msdos/namei.c
--- fat_utf8_oops-2.5.18/fs/msdos/namei.c	Sat May 25 17:09:22 2002
+++ fat_parse_opt-2.5.18/fs/msdos/namei.c	Sat May 25 17:19:33 2002
@@ -604,12 +604,8 @@
 	int res;
 
 	res = fat_fill_super(sb, data, silent, &msdos_dir_inode_operations, 0);
-	if (res) {
-		if (res == -EINVAL && !silent)
-			printk(KERN_INFO "VFS: Can't find a valid"
-			       " MSDOS filesystem on dev %s.\n", sb->s_id);
+	if (res)
 		return res;
-	}
 
 	sb->s_root->d_op = &msdos_dentry_operations;
 	return 0;
diff -urN fat_utf8_oops-2.5.18/fs/vfat/namei.c fat_parse_opt-2.5.18/fs/vfat/namei.c
--- fat_utf8_oops-2.5.18/fs/vfat/namei.c	Sat May 25 17:09:22 2002
+++ fat_parse_opt-2.5.18/fs/vfat/namei.c	Sat May 25 17:19:33 2002
@@ -80,95 +80,6 @@
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
-		if (!*this_char)
-			continue;
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
-		if (this_char != options)
-			*(this_char-1) = ',';
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
@@ -1296,25 +1207,14 @@
 	struct msdos_sb_info *sbi;
   
 	res = fat_fill_super(sb, data, silent, &vfat_dir_inode_operations, 1);
-	if (res) {
-		if (res == -EINVAL && !silent)
-			printk(KERN_INFO "VFS: Can't find a valid"
-			       " VFAT filesystem on dev %s.\n", sb->s_id);
+	if (res)
 		return res;
-	}
 
 	sbi = MSDOS_SB(sb);
-
-	if (parse_options((char *) data, &(sbi->options))) {
-		sbi->options.dotsOK = 0;
-		if (sbi->options.posixfs) {
-			sbi->options.name_check = 's';
-		}
-	}
-	if (sbi->options.name_check != 's') {
+	if (sbi->options.name_check != 's')
 		sb->s_root->d_op = &vfat_dentry_ops[0];
-	} else {
+	else
 		sb->s_root->d_op = &vfat_dentry_ops[2];
-	}
+
 	return 0;
 }
