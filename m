Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265792AbTIETLn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 15:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265708AbTIETLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 15:11:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:22417 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265774AbTIETKK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 15:10:10 -0400
Date: Fri, 5 Sep 2003 11:57:17 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: fsdev <linux-fsdevel@vger.kernel.org>
Subject: [CFT] [8/15] fat options parsing
Message-Id: <20030905115717.2548b728.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-260-test4-pv/fs/fat/inode.c linux-260-test4-fs/fs/fat/inode.c
--- linux-260-test4-pv/fs/fat/inode.c	2003-08-22 16:55:06.000000000 -0700
+++ linux-260-test4-fs/fs/fat/inode.c	2003-09-03 14:20:45.000000000 -0700
@@ -20,6 +20,7 @@
 #include <linux/buffer_head.h>
 #include <linux/mount.h>
 #include <linux/vfs.h>
+#include <linux/parser.h>
 #include <asm/unaligned.h>
 
 /*
@@ -183,20 +184,6 @@ void fat_put_super(struct super_block *s
 	kfree(sbi);
 }
 
-static int simple_getbool(char *s, int *setval)
-{
-	if (s) {
-		if (!strcmp(s,"1") || !strcmp(s,"yes") || !strcmp(s,"true"))
-			*setval = 1;
-		else if (!strcmp(s,"0") || !strcmp(s,"no") || !strcmp(s,"false"))
-			*setval = 0;
-		else
-			return 0;
-	} else
-		*setval = 1;
-	return 1;
-}
-
 static int fat_show_options(struct seq_file *m, struct vfsmount *mnt)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(mnt->mnt_sb);
@@ -259,11 +246,94 @@ static int fat_show_options(struct seq_f
 	return 0;
 }
 
+static void print_obsolete_option(char *optname)
+{
+	printk(KERN_INFO "FAT: %s option is obsolete, "
+			"not supported now\n", optname);
+}
+
+enum {
+	Opt_blocksize, Opt_charset, Opt_check_n, Opt_check_r, Opt_check_s,
+	Opt_fat, Opt_codepage, Opt_conv_a, Opt_conv_b, Opt_conv_t,
+	Opt_debug, Opt_dots, Opt_err, Opt_gid, Opt_immutable,
+	Opt_nocase, Opt_nodots, Opt_quiet, Opt_showexec, Opt_uid,
+	Opt_shortname_lower, Opt_shortname_win95, Opt_shortname_winnt, Opt_shortname_mixed,
+	Opt_umask, Opt_dmask, Opt_fmask, Opt_posix, Opt_cvf_format, Opt_cvf_options,
+	Opt_utf8_off, Opt_utf8_no, Opt_utf8_false,
+	Opt_utf8_on, Opt_utf8_yes, Opt_utf8_true, Opt_utf8_opt,
+	Opt_uni_xl_off, Opt_uni_xl_no, Opt_uni_xl_false,
+	Opt_uni_xl_on, Opt_uni_xl_yes, Opt_uni_xl_true, Opt_uni_xl_opt,
+	Opt_nonumtail_off, Opt_nonumtail_no, Opt_nonumtail_false,
+	Opt_nonumtail_on, Opt_nonumtail_yes, Opt_nonumtail_true, Opt_nonumtail_opt,
+};
+
+static match_table_t FAT_tokens = {
+	{Opt_check_r, "check=relaxed"},
+	{Opt_check_s, "check=strict"},
+	{Opt_check_n, "check=normal"},
+	{Opt_check_r, "check=r"},
+	{Opt_check_s, "check=s"},
+	{Opt_check_n, "check=n"},
+	{Opt_conv_b, "conv=binary"},
+	{Opt_conv_t, "conv=text"},
+	{Opt_conv_a, "conv=auto"},
+	{Opt_conv_b, "conv=b"},
+	{Opt_conv_t, "conv=t"},
+	{Opt_conv_a, "conv=a"},
+	{Opt_nodots, "nodots"},
+	{Opt_nodots, "dotsOK=no"},
+	{Opt_dots, "dotsOK=yes"},
+	{Opt_dots, "dots"},
+	{Opt_uid, "uid=%d"},
+	{Opt_gid, "gid=%d"},
+	{Opt_umask, "umask=%o"},
+	{Opt_dmask, "dmask=%o"},
+	{Opt_fmask, "fmask=%o"},
+	{Opt_fat, "fat=%d"},
+	{Opt_codepage, "codepage=%d"},
+	{Opt_charset, "iocharset=%s"},
+	{Opt_blocksize, "blocksize=%d"},
+	{Opt_nocase, "nocase"},
+	{Opt_cvf_format, "cvf_format=%20s"},
+	{Opt_cvf_options, "cvf_options=%100s"},
+	{Opt_shortname_lower, "shortname=lower"},
+	{Opt_shortname_win95, "shortname=win95"},
+	{Opt_shortname_winnt, "shortname=winnt"},
+	{Opt_shortname_mixed, "shortname=mixed"},
+	{Opt_utf8_off, "utf8=0"},	/* 0 or no or false */
+	{Opt_utf8_no, "utf8=no"},
+	{Opt_utf8_false, "utf8=false"},
+	{Opt_utf8_on, "utf8=1"},	/* empty or 1 or yes or true */
+	{Opt_utf8_yes, "utf8=yes"},
+	{Opt_utf8_true, "utf8=true"},
+	{Opt_utf8_opt, "utf8"},
+	{Opt_uni_xl_off, "uni_xlate=0"},	/* 0 or no or false */
+	{Opt_uni_xl_no, "uni_xlate=no"},
+	{Opt_uni_xl_false, "uni_xlate=false"},
+	{Opt_uni_xl_on, "uni_xlate=1"},		/* empty or 1 or yes or true */
+	{Opt_uni_xl_yes, "uni_xlate=yes"},
+	{Opt_uni_xl_true, "uni_xlate=true"},
+	{Opt_uni_xl_opt, "uni_xlate"},
+	{Opt_nonumtail_off, "nonumtail=0"},	/* 0 or no or false */
+	{Opt_nonumtail_no, "nonumtail=no"},
+	{Opt_nonumtail_false, "nonumtail=false"},
+	{Opt_nonumtail_on, "nonumtail=1"},	/* empty or 1 or yes or true */
+	{Opt_nonumtail_yes, "nonumtail=yes"},
+	{Opt_nonumtail_true, "nonumtail=true"},
+	{Opt_nonumtail_opt, "nonumtail"},
+	{Opt_quiet, "quiet"},
+	{Opt_showexec, "showexec"},
+	{Opt_debug, "debug"},
+	{Opt_immutable, "sys_immutable"},
+	{Opt_posix, "posix"},
+	{Opt_err, NULL}
+};
+
 static int parse_options(char *options, int is_vfat, int *debug,
 			 struct fat_mount_options *opts)
 {
-	char *this_char, *value, *p;
-	int ret = 1, val, len;
+	char *p;
+	substring_t args[MAX_OPT_ARGS];
 
 	opts->isvfat = is_vfat;
 
@@ -284,183 +354,211 @@ static int parse_options(char *options, 
 	*debug = 0;
 
 	if (!options)
-		goto out;
-	while ((this_char = strsep(&options,",")) != NULL) {
-		if (!*this_char)
+		return 1;
+
+	while ((p = strsep(&options, ",")) != NULL) {
+		int token;
+		if (!*p)
 			continue;
-		if ((value = strchr(this_char,'=')) != NULL)
-			*value++ = 0;
 
-		if (!strcmp(this_char,"check") && value) {
-			if (value[0] && !value[1] && strchr("rns",*value))
-				opts->name_check = *value;
-			else if (!strcmp(value,"relaxed"))
-				opts->name_check = 'r';
-			else if (!strcmp(value,"normal"))
-				opts->name_check = 'n';
-			else if (!strcmp(value,"strict"))
+		token = match_token(p, FAT_tokens, args);
+		switch (token) {
+			case Opt_check_s:
 				opts->name_check = 's';
-			else ret = 0;
-		}
-		else if (!strcmp(this_char,"conv") && value) {
-			printk(KERN_INFO "FAT: conv option is obsolete, "
-			       "not supported now\n");
-		}
-		else if (!strcmp(this_char,"nocase")) {
-			if (!is_vfat)
-				opts->nocase = 1;
-			else {
-				/* for backward compatible */
-				opts->shortname = VFAT_SFN_DISPLAY_WIN95
-					| VFAT_SFN_CREATE_WIN95;
-			}
-		}
-		else if (!strcmp(this_char,"showexec")) {
-			opts->showexec = 1;
-		}
-		else if (!strcmp(this_char,"uid")) {
-			if (!value || !*value) ret = 0;
-			else {
-				opts->fs_uid = simple_strtoul(value,&value,0);
-				if (*value) ret = 0;
+				break;
+			case Opt_check_r:
+ 				opts->name_check = 'r';
+				break;
+			case Opt_check_n:
+ 				opts->name_check = 'n';
+				break;
+			case Opt_dots:		/* msdos specific */
+				if (!is_vfat)
+					opts->dotsOK = 1;
+				break;
+			case Opt_nodots:	/* msdos specific */
+				if (!is_vfat)
+					opts->dotsOK = 0;
+				break;
+			case Opt_nocase:
+				if (!is_vfat)
+					opts->nocase = 1;
+				else {
+					/* for backward compatibility */
+					opts->shortname = VFAT_SFN_DISPLAY_WIN95
+						| VFAT_SFN_CREATE_WIN95;
+				}
+				break;
+			case Opt_quiet:
+				opts->quiet = 1;
+				break;
+			case Opt_showexec:
+				opts->showexec = 1;
+				break;
+			case Opt_debug:
+				*debug = 1;
+				break;
+			case Opt_immutable:
+				opts->sys_immutable = 1;
+				break;
+			case Opt_uid:
+			{
+				int uid = match_int(&args[0]);
+				if (!uid)
+					return 0;
+				opts->fs_uid = uid;
+				break;
 			}
-		}
-		else if (!strcmp(this_char,"gid")) {
-			if (!value || !*value) ret= 0;
-			else {
-				opts->fs_gid = simple_strtoul(value,&value,0);
-				if (*value) ret = 0;
+			case Opt_gid:
+			{
+				int gid = match_int(&args[0]);
+				if (!gid)
+					return 0;
+				opts->fs_gid = gid;
+				break;
 			}
-		}
-		else if (!strcmp(this_char,"umask")) {
-			if (!value || !*value) ret = 0;
-			else {
-				opts->fs_fmask = opts->fs_dmask =
-					simple_strtoul(value,&value,8);
-				if (*value) ret = 0;
+			case Opt_umask:
+			{
+				int mask = match_octal(&args[0]);
+				if (!mask)
+					return 0;
+				opts->fs_fmask = opts->fs_dmask = mask;
+				break;
 			}
-		}
-		else if (!strcmp(this_char,"fmask")) {
-			if (!value || !*value) ret = 0;
-			else {
-				opts->fs_fmask = simple_strtoul(value,&value,8);
-				if (*value) ret = 0;
+			case Opt_dmask:
+			{
+				int mask = match_octal(&args[0]);
+				if (!mask)
+					return 0;
+				opts->fs_dmask = mask;
+				break;
 			}
-		}
-		else if (!strcmp(this_char,"dmask")) {
-			if (!value || !*value) ret = 0;
-			else {
-				opts->fs_dmask = simple_strtoul(value,&value,8);
-				if (*value) ret = 0;
+			case Opt_fmask:
+			{
+				int mask = match_octal(&args[0]);
+				if (!mask)
+					return 0;
+				opts->fs_fmask = mask;
+				break;
 			}
-		}
-		else if (!strcmp(this_char,"debug")) {
-			if (value) ret = 0;
-			else *debug = 1;
-		}
-		else if (!strcmp(this_char,"fat")) {
-			printk(KERN_INFO "FAT: fat option is obsolete, "
-			       "not supported now\n");
-		}
-		else if (!strcmp(this_char,"quiet")) {
-			if (value) ret = 0;
-			else opts->quiet = 1;
-		}
-		else if (!strcmp(this_char,"blocksize")) {
-			printk(KERN_INFO "FAT: blocksize option is obsolete, "
-			       "not supported now\n");
-		}
-		else if (!strcmp(this_char,"sys_immutable")) {
-			if (value) ret = 0;
-			else opts->sys_immutable = 1;
-		}
-		else if (!strcmp(this_char,"codepage") && value) {
-			opts->codepage = simple_strtoul(value,&value,0);
-			if (*value) ret = 0;
-		}
-
-		/* msdos specific */
-		else if (!is_vfat && !strcmp(this_char,"dots")) {
-			opts->dotsOK = 1;
-		}
-		else if (!is_vfat && !strcmp(this_char,"nodots")) {
-			opts->dotsOK = 0;
-		}
-		else if (!is_vfat && !strcmp(this_char,"dotsOK") && value) {
-			if (!strcmp(value,"yes")) opts->dotsOK = 1;
-			else if (!strcmp(value,"no")) opts->dotsOK = 0;
-			else ret = 0;
-		}
-
-		/* vfat specific */
-		else if (is_vfat && !strcmp(this_char,"iocharset") && value) {
-			p = value;
-			while (*value && *value != ',')
-				value++;
-			len = value - p;
-			if (len) {
-				char *buffer;
-
-				if (opts->iocharset != NULL) {
+			case Opt_codepage:
+				opts->codepage = match_int(&args[0]);
+				printk("MSDOS FS: Using codepage %d\n",
+ 					opts->codepage);
+				break;
+
+			/* vfat specific */
+			case Opt_charset:
+				if (is_vfat) {
 					kfree(opts->iocharset);
-					opts->iocharset = NULL;
+					opts->iocharset = match_strdup(&args[0]);
+					if (!opts->iocharset)
+						return 0;
+					printk("MSDOS FS: IO charset %s\n",
+						opts->iocharset);
 				}
-				buffer = kmalloc(len + 1, GFP_KERNEL);
-				if (buffer != NULL) {
-					opts->iocharset = buffer;
-					memcpy(buffer, p, len);
-					buffer[len] = 0;
-				} else
-					ret = 0;
-			}
-		}
-		else if (is_vfat && !strcmp(this_char,"utf8")) {
-			ret = simple_getbool(value, &val);
-			if (ret) opts->utf8 = val;
-		}
-		else if (is_vfat && !strcmp(this_char,"uni_xlate")) {
-			ret = simple_getbool(value, &val);
-			if (ret) opts->unicode_xlate = val;
-		}
-		else if (is_vfat && !strcmp(this_char,"posix")) {
-			printk(KERN_INFO "FAT: posix option is obsolete, "
-			       "not supported now\n");
-		}
-		else if (is_vfat && !strcmp(this_char,"nonumtail")) {
-			ret = simple_getbool(value, &val);
-			if (ret) {
-				opts->numtail = !val;
-			}
-		}
-		else if (is_vfat && !strcmp(this_char, "shortname")) {
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
-		} else {
-			printk(KERN_ERR "FAT: Unrecognized mount option %s\n",
-			       this_char);
-			ret = 0;
-		}
+				break;
+			case Opt_shortname_lower:
+				if (is_vfat) {
+					opts->shortname = VFAT_SFN_DISPLAY_LOWER
+							| VFAT_SFN_CREATE_WIN95;
+				}
+				break;
+			case Opt_shortname_win95:
+				if (is_vfat) {
+					opts->shortname = VFAT_SFN_DISPLAY_WIN95
+							| VFAT_SFN_CREATE_WIN95;
+				}
+				break;
+			case Opt_shortname_winnt:
+				if (is_vfat) {
+					opts->shortname = VFAT_SFN_DISPLAY_WINNT
+							| VFAT_SFN_CREATE_WINNT;
+				}
+				break;
+			case Opt_shortname_mixed:
+				if (is_vfat) {
+					opts->shortname = VFAT_SFN_DISPLAY_WINNT
+							| VFAT_SFN_CREATE_WIN95;
+				}
+				break;
+			case Opt_utf8_off:	/* 0 or no or false */
+			case Opt_utf8_no:
+			case Opt_utf8_false:
+				if (is_vfat) {
+					opts->utf8 = 0;
+				}
+				break;
+			case Opt_utf8_on:	/* empty or 1 or yes or true */
+			case Opt_utf8_opt:
+			case Opt_utf8_yes:
+			case Opt_utf8_true:
+				if (is_vfat) {
+					opts->utf8 = 1;
+				}
+				break;
+			case Opt_uni_xl_off:	/* 0 or no or false */
+			case Opt_uni_xl_no:
+			case Opt_uni_xl_false:
+				if (is_vfat) {
+					opts->unicode_xlate = 0;
+				}
+				break;
+			case Opt_uni_xl_on:	/* empty or 1 or yes or true */
+			case Opt_uni_xl_yes:
+			case Opt_uni_xl_true:
+			case Opt_uni_xl_opt:
+				if (is_vfat) {
+					opts->unicode_xlate = 1;
+				}
+				break;
+			case Opt_nonumtail_off:		/* 0 or no or false */
+			case Opt_nonumtail_no:
+			case Opt_nonumtail_false:
+				if (is_vfat) {
+						opts->numtail = 1;	/* negated option */
+				}
+				break;
+			case Opt_nonumtail_on:		/* empty or 1 or yes or true */
+			case Opt_nonumtail_yes:
+			case Opt_nonumtail_true:
+			case Opt_nonumtail_opt:
+				if (is_vfat) {
+						opts->numtail = 0;	/* negated option */
+				}
+				break;
 
-		if (ret == 0)
-			break;
+			/* obsolete mount options */
+			case Opt_conv_b:
+			case Opt_conv_t:
+			case Opt_conv_a:
+				print_obsolete_option("conv");
+				break;
+			case Opt_blocksize:
+				print_obsolete_option("blocksize");
+				break;
+			case Opt_posix:
+				print_obsolete_option("posix");
+				break;
+			case Opt_fat:
+				print_obsolete_option("fat");
+				break;
+			case Opt_cvf_format:
+			case Opt_cvf_options:
+				print_obsolete_option("cvf");
+				break;
+			/* unknown option */
+			default:
+				printk(KERN_ERR "FAT: Unrecognized mount option \"%s\" "
+						"or missing value\n", p);
+				return 0;
+		}
 	}
-out:
+
 	if (opts->unicode_xlate)
 		opts->utf8 = 0;
 	
-	return ret;
+	return 1;
 }
 
 static int fat_calc_dir_size(struct inode *inode)


--
~Randy
