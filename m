Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269185AbRHGRCp>; Tue, 7 Aug 2001 13:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269111AbRHGRC0>; Tue, 7 Aug 2001 13:02:26 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:46241 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S269049AbRHGRB5>;
	Tue, 7 Aug 2001 13:01:57 -0400
Date: Tue, 7 Aug 2001 13:02:05 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC][PATCH] parser for mount options
Message-ID: <Pine.GSO.4.21.0108071227080.18565-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	OK, folks - here's an implementation of parser for mount options.
Patch contains parser itself (lib/parser.c, include/linux/parser.h) and
switches parse_options() in several filesystems to using it instead of
the current ad-hackery.

	Patch works and AFAICS it shouldn't be hard to convert the rest.

What I wanted to get:
	* set of options accepted by fs and syntax of their arguments
should be visible in source. Explicitly.
	* no cascades of strcmp/strncmp/peeking at individual characters
by hands.
	* simple and regular parse_options() implementations.
	* being able to use that mechanism for procfs ->write() and its ilk.
	* parser itself should be small.

What had been done:
	* match_table_t is an array of pairs (number [== enum member], pattern)
It describes the acceptable options. Patterns are small subset of scanf
formats - the only things recognized by now are %d, %u, %o, %x, %s and
%<num>s. E.g. "uid=%u" or "iocharset=%20s". NULL is a catch-all - everything
matches it.
	* function match_token() looks for the first pattern in the table
that matches given string _and_ fills the array of arguments. Said array
consists of struct { char *from; char *to;} - no conversion, we just find
the substrings.
	* match_int(), match_octal(), etc. take a pointer to such structure
and do the conversion. IOW, usually code will look like
	token = match_token(s, table, argv);
	switch (token) {
		case Opt_uid:
			uid = match_int(&argv[0]);
			break;
		...
	}
	* for %s we have two kinds of conversion - match_strcpy() and
match_strdup(). Meaning should be obvious (allocation is done with
kmalloc(..., GFP_KERNEL);


	It works surprisingly well - syntax is immediately visible in
the table, code is not crapped with tons of global variables and parser
itself is not large.

	Patch applies clean at least to -pre4 and -pre5.  Comments,
suggestions and flames are welcome.  I hope that it got enough
filesystems converted to be representative - adfs, autofs, devpts,
ext2, fat and isofs.
								Al

Patch follows:

diff -urN S8-pre5/fs/adfs/super.c S8-pre5-opt/fs/adfs/super.c
--- S8-pre5/fs/adfs/super.c	Thu Apr 19 23:46:42 2001
+++ S8-pre5-opt/fs/adfs/super.c	Tue Aug  7 11:25:29 2001
@@ -18,6 +18,7 @@
 #include <linux/string.h>
 #include <linux/locks.h>
 #include <linux/init.h>
+#include <linux/parser.h>
 
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
@@ -164,48 +165,43 @@
 	kfree(sb->u.adfs_sb.s_map);
 }
 
+enum {Opt_uid, Opt_gid, Opt_ownmask, Opt_othmask, Opt_err};
+
+static match_table_t tokens = {
+	{Opt_uid, "uid=%u"},
+	{Opt_gid, "gid=%u"},
+	{Opt_ownmask, "ownmask=%o"},
+	{Opt_othmask, "othmask=%o"},
+	{Opt_err, NULL}
+};
+	
 static int parse_options(struct super_block *sb, char *options)
 {
-	char *value, *opt;
+	char *p;
 
 	if (!options)
 		return 0;
 
-	for (opt = strtok(options, ","); opt != NULL; opt = strtok(NULL, ",")) {
-		value = strchr(opt, '=');
-		if (value)
-			*value++ = '\0';
-
-		if (!strcmp(opt, "uid")) {	/* owner of all files */
-			if (!value || !*value)
-				return -EINVAL;
-			sb->u.adfs_sb.s_uid = simple_strtoul(value, &value, 0);
-			if (*value)
-				return -EINVAL;
-		} else
-		if (!strcmp(opt, "gid")) {	/* group owner of all files */
-			if (!value || !*value)
-				return -EINVAL;
-			sb->u.adfs_sb.s_gid = simple_strtoul(value, &value, 0);
-			if (*value)
-				return -EINVAL;
-		} else
-		if (!strcmp(opt, "ownmask")) {	/* owner permission mask */
-			if (!value || !*value)
-				return -EINVAL;
-			sb->u.adfs_sb.s_owner_mask = simple_strtoul(value, &value, 8);
-			if (*value)
-				return -EINVAL;
-		} else
-		if (!strcmp(opt, "othmask")) {	/* others permission mask */
-			if (!value || !*value)
-				return -EINVAL;
-			sb->u.adfs_sb.s_other_mask = simple_strtoul(value, &value, 8);
-			if (*value)
+	for (p = strtok(options, ","); p != NULL; p = strtok(NULL, ",")) {
+		substring_t args[MAX_OPT_ARGS];
+		int token = match_token(p, tokens, args);
+
+		switch (token) {
+			case Opt_uid:
+				sb->u.adfs_sb.s_uid = match_int(args);
+				break;
+			case Opt_gid:
+				sb->u.adfs_sb.s_gid = match_int(args);
+				break;
+			case Opt_ownmask:
+				sb->u.adfs_sb.s_owner_mask = match_octal(args);
+				break;
+			case Opt_othmask:
+				sb->u.adfs_sb.s_other_mask = match_octal(args);
+				break;
+			default:
+				printk("ADFS-fs: unrecognised mount option %s\n", p);
 				return -EINVAL;
-		} else {			/* eh? say again. */
-			printk("ADFS-fs: unrecognised mount option %s\n", opt);
-			return -EINVAL;
 		}
 	}
 	return 0;
diff -urN S8-pre5/fs/autofs/inode.c S8-pre5-opt/fs/autofs/inode.c
--- S8-pre5/fs/autofs/inode.c	Tue Jul  3 21:09:13 2001
+++ S8-pre5-opt/fs/autofs/inode.c	Tue Aug  7 11:25:29 2001
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/file.h>
 #include <linux/locks.h>
+#include <linux/parser.h>
 #include <asm/bitops.h>
 #include "autofs_i.h"
 #define __NO_VERSION__
@@ -47,9 +48,21 @@
 	statfs:		autofs_statfs,
 };
 
+enum {Opt_err, Opt_fd, Opt_uid, Opt_gid, Opt_pgrp, Opt_minproto, Opt_maxproto};
+static match_table_t autofs_tokens = {
+	{Opt_fd, "fd=%d"},
+	{Opt_uid, "uid=%d"},
+	{Opt_gid, "gid=%d"},
+	{Opt_pgrp, "pgrp=%d"},
+	{Opt_minproto, "minproto=%d"},
+	{Opt_maxproto, "maxproto=%d"},
+	{Opt_err, NULL}
+};
+
 static int parse_options(char *options, int *pipefd, uid_t *uid, gid_t *gid, pid_t *pgrp, int *minproto, int *maxproto)
 {
-	char *this_char, *value;
+	char *p;
+	substring_t args[MAX_OPT_ARGS];
 	
 	*uid = current->uid;
 	*gid = current->gid;
@@ -59,53 +72,32 @@
 
 	*pipefd = -1;
 
-	if ( !options ) return 1;
-	for (this_char = strtok(options,","); this_char; this_char = strtok(NULL,",")) {
-		if ((value = strchr(this_char,'=')) != NULL)
-			*value++ = 0;
-		if (!strcmp(this_char,"fd")) {
-			if (!value || !*value)
-				return 1;
-			*pipefd = simple_strtoul(value,&value,0);
-			if (*value)
-				return 1;
-		}
-		else if (!strcmp(this_char,"uid")) {
-			if (!value || !*value)
-				return 1;
-			*uid = simple_strtoul(value,&value,0);
-			if (*value)
-				return 1;
-		}
-		else if (!strcmp(this_char,"gid")) {
-			if (!value || !*value)
-				return 1;
-			*gid = simple_strtoul(value,&value,0);
-			if (*value)
-				return 1;
-		}
-		else if (!strcmp(this_char,"pgrp")) {
-			if (!value || !*value)
-				return 1;
-			*pgrp = simple_strtoul(value,&value,0);
-			if (*value)
-				return 1;
-		}
-		else if (!strcmp(this_char,"minproto")) {
-			if (!value || !*value)
-				return 1;
-			*minproto = simple_strtoul(value,&value,0);
-			if (*value)
-				return 1;
-		}
-		else if (!strcmp(this_char,"maxproto")) {
-			if (!value || !*value)
-				return 1;
-			*maxproto = simple_strtoul(value,&value,0);
-			if (*value)
+	if ( !options )
+		return 1;
+	for (p = strtok(options,","); p; p = strtok(NULL,",")) {
+		int token = match_token(p, autofs_tokens, args);
+		switch (token) {
+			case Opt_fd:
+				*pipefd = match_int(&args[0]);
+				break;
+			case Opt_uid:
+				*uid = match_int(&args[0]);
+				break;
+			case Opt_gid:
+				*gid = match_int(&args[0]);
+				break;
+			case Opt_pgrp:
+				*pgrp = match_int(&args[0]);
+				break;
+			case Opt_minproto:
+				*minproto = match_int(&args[0]);
+				break;
+			case Opt_maxproto:
+				*maxproto = match_int(&args[0]);
+				break;
+			default:
 				return 1;
 		}
-		else break;
 	}
 	return (*pipefd < 0);
 }
diff -urN S8-pre5/fs/devpts/inode.c S8-pre5-opt/fs/devpts/inode.c
--- S8-pre5/fs/devpts/inode.c	Wed Apr 18 00:35:58 2001
+++ S8-pre5-opt/fs/devpts/inode.c	Tue Aug  7 11:25:29 2001
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/stat.h>
 #include <linux/tty.h>
+#include <linux/parser.h>
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
 
@@ -57,6 +58,15 @@
 	remount_fs:	devpts_remount,
 };
 
+enum {Opt_uid, Opt_gid, Opt_mode, Opt_err};
+
+static match_table_t tokens = {
+	{Opt_uid, "uid=%u"},
+	{Opt_gid, "gid=%u"},
+	{Opt_mode, "mode=%o"},
+	{Opt_err, NULL}
+};
+
 static int devpts_parse_options(char *options, struct devpts_sb_info *sbi)
 {
 	int setuid = 0;
@@ -64,39 +74,28 @@
 	uid_t uid = 0;
 	gid_t gid = 0;
 	umode_t mode = 0600;
-	char *this_char, *value;
+	char *p = NULL;
 
-	this_char = NULL;
 	if ( options )
-		this_char = strtok(options,",");
-	for ( ; this_char; this_char = strtok(NULL,",")) {
-		if ((value = strchr(this_char,'=')) != NULL)
-			*value++ = 0;
-		if (!strcmp(this_char,"uid")) {
-			if (!value || !*value)
-				return 1;
-			uid = simple_strtoul(value,&value,0);
-			if (*value)
-				return 1;
-			setuid = 1;
-		}
-		else if (!strcmp(this_char,"gid")) {
-			if (!value || !*value)
-				return 1;
-			gid = simple_strtoul(value,&value,0);
-			if (*value)
-				return 1;
-			setgid = 1;
-		}
-		else if (!strcmp(this_char,"mode")) {
-			if (!value || !*value)
-				return 1;
-			mode = simple_strtoul(value,&value,8);
-			if (*value)
+		p = strtok(options,",");
+	for ( ; p; p = strtok(NULL,",")) {
+		substring_t args[MAX_OPT_ARGS];
+		int token = match_token(p, tokens, args);
+		switch(token) {
+			case Opt_uid:
+				uid = match_int(args);
+				setuid = 1;
+				break;
+			case Opt_gid:
+				gid = match_int(args);
+				setgid = 1;
+				break;
+			case Opt_mode:
+				mode = match_octal(args);
+				break;
+			default:
 				return 1;
 		}
-		else
-			return 1;
 	}
 	sbi->setuid  = setuid;
 	sbi->setgid  = setgid;
diff -urN S8-pre5/fs/ext2/super.c S8-pre5-opt/fs/ext2/super.c
--- S8-pre5/fs/ext2/super.c	Sun Jul 29 01:54:47 2001
+++ S8-pre5-opt/fs/ext2/super.c	Tue Aug  7 11:25:29 2001
@@ -25,6 +25,7 @@
 #include <linux/init.h>
 #include <linux/locks.h>
 #include <linux/blkdev.h>
+#include <linux/parser.h>
 #include <asm/uaccess.h>
 
 
@@ -154,127 +155,102 @@
 	remount_fs:	ext2_remount,
 };
 
-/*
- * This function has been shamelessly adapted from the msdos fs
- */
+enum {
+	Opt_bsd_df, Opt_minix_df, Opt_grpid, Opt_nogrpid,
+	Opt_resgid, Opt_resuid, Opt_sb, Opt_err_cont, Opt_err_panic, Opt_err_ro,
+	Opt_nouid32, Opt_check, Opt_nocheck, Opt_debug, Opt_ignore, Opt_err,
+};
+static match_table_t tokens = {
+	{Opt_bsd_df, "bsddf"},
+	{Opt_minix_df, "minixdf"},
+	{Opt_grpid, "grpid"},
+	{Opt_grpid, "bsdgroups"},
+	{Opt_nogrpid, "nogrpid"},
+	{Opt_nogrpid, "sysvgroups"},
+	{Opt_resgid, "resgid=%d"},
+	{Opt_resuid, "resuid=%d"},
+	{Opt_sb, "sb=%d"},
+	{Opt_err_cont, "errors=continue"},
+	{Opt_err_panic, "errors=panic"},
+	{Opt_err_ro, "errors=remount-ro"},
+	{Opt_nouid32, "nouid32"},
+	{Opt_check, "check"},
+	{Opt_nocheck, "nocheck"},
+	{Opt_nocheck, "check=none"},
+	{Opt_debug, "debug"},
+	{Opt_ignore, "grpquota"},
+	{Opt_ignore, "noquota"},
+	{Opt_ignore, "quota"},
+	{Opt_ignore, "usrquota"},
+	{Opt_err, NULL}
+};
+
 static int parse_options (char * options, unsigned long * sb_block,
 			  unsigned short *resuid, unsigned short * resgid,
 			  unsigned long * mount_options)
 {
-	char * this_char;
-	char * value;
+	char * p;
+	substring_t args[MAX_OPT_ARGS];
+	int kind = EXT2_MOUNT_ERRORS_CONT;
 
 	if (!options)
 		return 1;
-	for (this_char = strtok (options, ",");
-	     this_char != NULL;
-	     this_char = strtok (NULL, ",")) {
-		if ((value = strchr (this_char, '=')) != NULL)
-			*value++ = 0;
-		if (!strcmp (this_char, "bsddf"))
-			clear_opt (*mount_options, MINIX_DF);
-		else if (!strcmp (this_char, "nouid32")) {
-			set_opt (*mount_options, NO_UID32);
-		}
-		else if (!strcmp (this_char, "check")) {
-			if (!value || !*value || !strcmp (value, "none"))
-				clear_opt (*mount_options, CHECK);
-			else
+	for (p = strtok (options, ","); p; p = strtok (NULL, ",")) {
+		int token = match_token(p, tokens, args);
+		switch (token) {
+			case Opt_bsd_df:
+				clear_opt (*mount_options, MINIX_DF);
+				break;
+			case Opt_minix_df:
+				set_opt (*mount_options, MINIX_DF);
+				break;
+			case Opt_grpid:
+				set_opt (*mount_options, GRPID);
+				break;
+			case Opt_nogrpid:
+				clear_opt (*mount_options, GRPID);
+				break;
+			case Opt_resuid:
+				*resuid = match_int(&args[0]);
+				break;
+			case Opt_resgid:
+				*resgid = match_int(&args[0]);
+				break;
+			case Opt_sb:
+				*sb_block = match_int(&args[0]);
+				break;
+			case Opt_err_panic:
+				kind = EXT2_MOUNT_ERRORS_PANIC;
+				break;
+			case Opt_err_ro:
+				kind = EXT2_MOUNT_ERRORS_RO;
+				break;
+			case Opt_err_cont:
+				kind = EXT2_MOUNT_ERRORS_CONT;
+				break;
+			case Opt_nouid32:
+				set_opt (*mount_options, NO_UID32);
+				break;
+			case Opt_check:
 #ifdef CONFIG_EXT2_CHECK
 				set_opt (*mount_options, CHECK);
 #else
 				printk("EXT2 Check option not supported\n");
 #endif
-		}
-		else if (!strcmp (this_char, "debug"))
-			set_opt (*mount_options, DEBUG);
-		else if (!strcmp (this_char, "errors")) {
-			if (!value || !*value) {
-				printk ("EXT2-fs: the errors option requires "
-					"an argument\n");
-				return 0;
-			}
-			if (!strcmp (value, "continue")) {
-				clear_opt (*mount_options, ERRORS_RO);
-				clear_opt (*mount_options, ERRORS_PANIC);
-				set_opt (*mount_options, ERRORS_CONT);
-			}
-			else if (!strcmp (value, "remount-ro")) {
-				clear_opt (*mount_options, ERRORS_CONT);
-				clear_opt (*mount_options, ERRORS_PANIC);
-				set_opt (*mount_options, ERRORS_RO);
-			}
-			else if (!strcmp (value, "panic")) {
-				clear_opt (*mount_options, ERRORS_CONT);
-				clear_opt (*mount_options, ERRORS_RO);
-				set_opt (*mount_options, ERRORS_PANIC);
-			}
-			else {
-				printk ("EXT2-fs: Invalid errors option: %s\n",
-					value);
-				return 0;
-			}
-		}
-		else if (!strcmp (this_char, "grpid") ||
-			 !strcmp (this_char, "bsdgroups"))
-			set_opt (*mount_options, GRPID);
-		else if (!strcmp (this_char, "minixdf"))
-			set_opt (*mount_options, MINIX_DF);
-		else if (!strcmp (this_char, "nocheck"))
-			clear_opt (*mount_options, CHECK);
-		else if (!strcmp (this_char, "nogrpid") ||
-			 !strcmp (this_char, "sysvgroups"))
-			clear_opt (*mount_options, GRPID);
-		else if (!strcmp (this_char, "resgid")) {
-			if (!value || !*value) {
-				printk ("EXT2-fs: the resgid option requires "
-					"an argument\n");
-				return 0;
-			}
-			*resgid = simple_strtoul (value, &value, 0);
-			if (*value) {
-				printk ("EXT2-fs: Invalid resgid option: %s\n",
-					value);
-				return 0;
-			}
-		}
-		else if (!strcmp (this_char, "resuid")) {
-			if (!value || !*value) {
-				printk ("EXT2-fs: the resuid option requires "
-					"an argument");
-				return 0;
-			}
-			*resuid = simple_strtoul (value, &value, 0);
-			if (*value) {
-				printk ("EXT2-fs: Invalid resuid option: %s\n",
-					value);
-				return 0;
-			}
-		}
-		else if (!strcmp (this_char, "sb")) {
-			if (!value || !*value) {
-				printk ("EXT2-fs: the sb option requires "
-					"an argument");
-				return 0;
-			}
-			*sb_block = simple_strtoul (value, &value, 0);
-			if (*value) {
-				printk ("EXT2-fs: Invalid sb option: %s\n",
-					value);
+				break;
+			case Opt_nocheck:
+				clear_opt (*mount_options, CHECK);
+				break;
+			case Opt_debug:
+				set_opt (*mount_options, DEBUG);
+				break;
+			case Opt_ignore:
+				break;
+			default:
 				return 0;
-			}
-		}
-		/* Silently ignore the quota options */
-		else if (!strcmp (this_char, "grpquota")
-		         || !strcmp (this_char, "noquota")
-		         || !strcmp (this_char, "quota")
-		         || !strcmp (this_char, "usrquota"))
-			/* Don't do anything ;-) */ ;
-		else {
-			printk ("EXT2-fs: Unrecognized mount option %s\n", this_char);
-			return 0;
 		}
 	}
+	*mount_options |= kind;
 	return 1;
 }
 
diff -urN S8-pre5/fs/fat/inode.c S8-pre5-opt/fs/fat/inode.c
--- S8-pre5/fs/fat/inode.c	Tue Aug  7 05:57:47 2001
+++ S8-pre5-opt/fs/fat/inode.c	Tue Aug  7 11:25:29 2001
@@ -30,6 +30,7 @@
 #include <linux/slab.h>
 #include <linux/bitops.h>
 #include <linux/smp_lock.h>
+#include <linux/parser.h>
 
 #include "msbuffer.h"
 
@@ -201,14 +202,53 @@
 	}
 }
 
+enum {
+Opt_bits, Opt_blocksize, Opt_charset, Opt_check_n, Opt_check_r, Opt_check_s,
+Opt_codepage, Opt_conv_a, Opt_conv_b, Opt_conv_t, Opt_cvf_format,
+Opt_cvf_options, Opt_debug, Opt_dots, Opt_err, Opt_gid, Opt_immutable,
+Opt_nocase, Opt_nodots, Opt_quiet, Opt_showexec, Opt_uid, Opt_umask,
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
+	{Opt_dots, "dots"},
+	{Opt_dots, "dotsOK=yes"},
+	{Opt_nodots, "nodots"},
+	{Opt_dots, "dotsOK=no"},
+	{Opt_uid, "uid=%d"},
+	{Opt_gid, "gid=%d"},
+	{Opt_umask, "umask=%o"},
+	{Opt_bits, "fat=%d"},
+	{Opt_codepage, "codepage=%d"},
+	{Opt_charset, "iocharset=%s"},
+	{Opt_cvf_format, "cvf_format=%20s"},
+	{Opt_cvf_options, "cvf_options=%100s"},
+	{Opt_blocksize, "blocksize=%d"},
+	{Opt_nocase, "nocase"},
+	{Opt_quiet, "quiet"},
+	{Opt_showexec, "showexec"},
+	{Opt_debug, "debug"},
+	{Opt_immutable, "sys_immutable"},
+	{Opt_err, NULL}
+};
 
 static int parse_options(char *options,int *fat, int *debug,
 			 struct fat_mount_options *opts,
 			 char *cvf_format, char *cvf_options)
 {
-	char *this_char,*value,save,*savep;
+	substring_t args[MAX_OPT_ARGS];
 	char *p;
-	int ret = 1, len;
 
 	opts->name_check = 'n';
 	opts->conversion = 'b';
@@ -223,141 +263,89 @@
 	*debug = *fat = 0;
 
 	if (!options)
-		goto out;
-	save = 0;
-	savep = NULL;
-	for (this_char = strtok(options,","); this_char;
-	     this_char = strtok(NULL,",")) {
-		if ((value = strchr(this_char,'=')) != NULL) {
-			save = *value;
-			savep = value;
-			*value++ = 0;
-		}
-		if (!strcmp(this_char,"check") && value) {
-			if (value[0] && !value[1] && strchr("rns",*value))
-				opts->name_check = *value;
-			else if (!strcmp(value,"relaxed"))
+		return 1;
+
+	for (p = strtok(options,","); p; p = strtok(NULL,",")) {
+		int token = match_token(p, FAT_tokens, args);
+		switch (token) {
+			case Opt_check_s:
+				opts->name_check = 's';
+				break;
+			case Opt_check_r:
 				opts->name_check = 'r';
-			else if (!strcmp(value,"normal"))
+				break;
+			case Opt_check_n:
 				opts->name_check = 'n';
-			else if (!strcmp(value,"strict"))
-				opts->name_check = 's';
-			else ret = 0;
-		}
-		else if (!strcmp(this_char,"conv") && value) {
-			if (value[0] && !value[1] && strchr("bta",*value))
-				opts->conversion = *value;
-			else if (!strcmp(value,"binary"))
-				opts->conversion = 'b';
-			else if (!strcmp(value,"text"))
-				opts->conversion = 't';
-			else if (!strcmp(value,"auto"))
-				opts->conversion = 'a';
-			else ret = 0;
-		}
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
-			opts->showexec = 1;
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
-			else {
-				opts->fs_umask = simple_strtoul(value,&value,8);
-				if (*value) ret = 0;
-			}
-		}
-		else if (!strcmp(this_char,"debug")) {
-			if (value) ret = 0;
-			else *debug = 1;
-		}
-		else if (!strcmp(this_char,"fat")) {
-			if (!value || !*value) ret = 0;
-			else {
-				*fat = simple_strtoul(value,&value,0);
-				if (*value || (*fat != 12 && *fat != 16 &&
-					       *fat != 32)) 
-					ret = 0;
-			}
-		}
-		else if (!strcmp(this_char,"quiet")) {
-			if (value) ret = 0;
-			else opts->quiet = 1;
-		}
-		else if (!strcmp(this_char,"blocksize")) {
-			printk("FAT: blocksize option is obsolete, "
-			       "not supported now\n");
-		}
-		else if (!strcmp(this_char,"sys_immutable")) {
-			if (value) ret = 0;
-			else opts->sys_immutable = 1;
-		}
-		else if (!strcmp(this_char,"codepage") && value) {
-			opts->codepage = simple_strtoul(value,&value,0);
-			if (*value) ret = 0;
-			else printk ("MSDOS FS: Using codepage %d\n",
+				break;
+			case Opt_conv_b:
+				opts->name_check = 'b';
+				break;
+			case Opt_conv_t:
+				opts->name_check = 't';
+				break;
+			case Opt_conv_a:
+				opts->name_check = 'a';
+				break;
+			case Opt_dots:
+				opts->dotsOK = 1;
+				break;
+			case Opt_nodots:
+				opts->dotsOK = 0;
+				break;
+			case Opt_uid:
+				opts->fs_uid = match_int(&args[0]);
+				break;
+			case Opt_gid:
+				opts->fs_gid = match_int(&args[0]);
+				break;
+			case Opt_umask:
+				opts->fs_umask = match_octal(&args[0]);
+				break;
+			case Opt_bits:
+				*fat = match_int(&args[0]);
+				if (*fat != 12 && *fat != 16 && *fat != 32)
+					return 0;
+				break;
+			case Opt_codepage:
+				opts->codepage = match_int(&args[0]);
+				printk("MSDOS FS: Using codepage %d\n",
 					opts->codepage);
+				break;
+			case Opt_charset:
+				opts->iocharset = match_strdup(&args[0]);
+				if (!opts->iocharset)
+					return 0;
+				printk("MSDOS FS: IO charset %s\n",
+					opts->iocharset);
+				break;
+			case Opt_cvf_format:
+				match_strcpy(cvf_format, &args[0]);
+				break;
+			case Opt_cvf_options:
+				match_strcpy(cvf_options, &args[0]);
+				break;
+			case Opt_blocksize:
+				printk("FAT: blocksize option is obsolete, "
+				       "not supported now\n");
+				break;
+			case Opt_nocase:
+				opts->nocase = 1;
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
 		}
-		else if (!strcmp(this_char,"iocharset") && value) {
-			p = value;
-			while (*value && *value != ',') value++;
-			len = value - p;
-			if (len) { 
-				char * buffer = kmalloc(len+1, GFP_KERNEL);
-				if (buffer) {
-					opts->iocharset = buffer;
-					memcpy(buffer, p, len);
-					buffer[len] = 0;
-					printk("MSDOS FS: IO charset %s\n",
-						buffer);
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
-		}
-
-		if (this_char != options) *(this_char-1) = ',';
-		if (value) *savep = save;
-		if (ret == 0)
-			break;
 	}
-out:
-	return ret;
+	return 1;
 }
 
 static void fat_read_root(struct inode *inode)
diff -urN S8-pre5/fs/isofs/inode.c S8-pre5-opt/fs/isofs/inode.c
--- S8-pre5/fs/isofs/inode.c	Thu Apr 19 23:46:45 2001
+++ S8-pre5-opt/fs/isofs/inode.c	Tue Aug  7 11:25:29 2001
@@ -28,6 +28,7 @@
 #include <linux/ctype.h>
 #include <linux/smp_lock.h>
 #include <linux/blkdev.h>
+#include <linux/parser.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -268,9 +269,48 @@
 }
 #endif
 
+enum {
+Opt_block, Opt_check_r, Opt_check_s, Opt_cruft, Opt_gid, Opt_ignore,
+Opt_iocharset, Opt_map_a, Opt_map_n, Opt_map_o, Opt_mode, Opt_nojoliet,
+Opt_norock, Opt_sb, Opt_session, Opt_uid, Opt_unhide, Opt_utf8, Opt_err
+};
+static match_table_t tokens = {
+	{Opt_norock, "norock"},
+	{Opt_nojoliet, "nojoliet"},
+	{Opt_unhide, "unhide"},
+	{Opt_cruft, "cruft"},
+	{Opt_utf8, "utf8"},
+	{Opt_iocharset, "iocharset=%s"},
+	{Opt_map_a, "map=a"},
+	{Opt_map_a, "map=acorn"},
+	{Opt_map_n, "map=n"},
+	{Opt_map_n, "map=normal"},
+	{Opt_map_o, "map=o"},
+	{Opt_map_o, "map=off"},
+	{Opt_session, "session=%u"},
+	{Opt_sb, "sbsector=%u"},
+	{Opt_check_r, "check=r"},
+	{Opt_check_r, "check=relaxed"},
+	{Opt_check_s, "check=s"},
+	{Opt_check_s, "check=strict"},
+	{Opt_uid, "uid=%u"},
+	{Opt_gid, "gid=%u"},
+	{Opt_mode, "mode=%u"},
+	{Opt_block, "block=%u"},
+	{Opt_ignore, "conv=b"},
+	{Opt_ignore, "conv=t"},
+	{Opt_ignore, "conv=m"},
+	{Opt_ignore, "conv=a"},
+	{Opt_ignore, "conv=binary"},
+	{Opt_ignore, "conv=text"},
+	{Opt_ignore, "conv=mtext"},
+	{Opt_ignore, "conv=auto"},
+	{Opt_err, NULL}
+};
+
 static int parse_options(char *options, struct iso9660_options * popt)
 {
-	char *this_char,*value;
+	char *p;
 
 	popt->map = 'n';
 	popt->rock = 'y';
@@ -289,106 +329,82 @@
 	popt->utf8 = 0;
 	popt->session=-1;
 	popt->sbsector=-1;
-	if (!options) return 1;
-	for (this_char = strtok(options,","); this_char; this_char = strtok(NULL,",")) {
-	        if (strncmp(this_char,"norock",6) == 0) {
-		  popt->rock = 'n';
-		  continue;
-		}
-	        if (strncmp(this_char,"nojoliet",8) == 0) {
-		  popt->joliet = 'n';
-		  continue;
-		}
-	        if (strncmp(this_char,"unhide",6) == 0) {
-		  popt->unhide = 'y';
-		  continue;
-		}
-	        if (strncmp(this_char,"cruft",5) == 0) {
-		  popt->cruft = 'y';
-		  continue;
-		}
-	        if (strncmp(this_char,"utf8",4) == 0) {
-		  popt->utf8 = 1;
-		  continue;
-		}
-		if ((value = strchr(this_char,'=')) != NULL)
-			*value++ = 0;
+	if (!options)
+		return 1;
 
+	for (p = strtok(options,","); p; p = strtok(NULL,",")) {
+		substring_t args[MAX_OPT_ARGS];
+		int token = match_token(p, tokens, args);
+		unsigned n;
+
+		switch (token) {
+			case Opt_norock:
+				popt->rock = 'n';
+				break;
+			case Opt_nojoliet:
+				popt->joliet = 'n';
+				break;
+			case Opt_unhide:
+				popt->unhide = 'y';
+				break;
+			case Opt_cruft:
+				popt->cruft = 'y';
+				break;
+			case Opt_utf8:
+				popt->cruft = 1;
+				break;
 #ifdef CONFIG_JOLIET
-		if (!strcmp(this_char,"iocharset") && value) {
-			popt->iocharset = value;
-			while (*value && *value != ',')
-				value++;
-			if (value == popt->iocharset)
+			case Opt_iocharset:
+				popt->iocharset = match_strdup(&args[0]);
+				break;
+#endif
+			case Opt_map_a:
+				popt->map = 'a';
+				break;
+			case Opt_map_o:
+				popt->map = 'o';
+				break;
+			case Opt_map_n:
+				popt->map = 'n';
+				break;
+			case Opt_session:
+				n = match_int(&args[0]);
+				if (n > 99)
+					return 0;
+				popt->session = n + 1;
+				break;
+			case Opt_sb:
+				n = match_int(&args[0]);
+				if (n > 660 * 512)
+					return 0;
+				popt->sbsector = n;
+				break;
+			case Opt_check_r:
+				popt->check = 'r';
+				break;
+			case Opt_check_s:
+				popt->check = 's';
+				break;
+			case Opt_ignore:
+				break;
+			case Opt_uid:
+				popt->uid = match_int(&args[0]);
+				break;
+			case Opt_gid:
+				popt->gid = match_int(&args[0]);
+				break;
+			case Opt_mode:
+				popt->mode = match_int(&args[0]);
+				break;
+			case Opt_block:
+				n = match_int(&args[0]);
+				if (n != 512 && n != 1024 && n != 2048)
+					return 0;
+				popt->blocksize = n;
+				break;
+			default:
 				return 0;
-			*value = 0;
-		} else
-#endif
-		if (!strcmp(this_char,"map") && value) {
-			if (value[0] && !value[1] && strchr("ano",*value))
-				popt->map = *value;
-			else if (!strcmp(value,"off")) popt->map = 'o';
-			else if (!strcmp(value,"normal")) popt->map = 'n';
-			else if (!strcmp(value,"acorn")) popt->map = 'a';
-			else return 0;
-		}
-		if (!strcmp(this_char,"session") && value) {
-			char * vpnt = value;
-			unsigned int ivalue = simple_strtoul(vpnt, &vpnt, 0);
-			if(ivalue < 0 || ivalue >99) return 0;
-			popt->session=ivalue+1;
 		}
-		if (!strcmp(this_char,"sbsector") && value) {
-			char * vpnt = value;
-			unsigned int ivalue = simple_strtoul(vpnt, &vpnt, 0);
-			if(ivalue < 0 || ivalue >660*512) return 0;
-			popt->sbsector=ivalue;
-		}
-		else if (!strcmp(this_char,"check") && value) {
-			if (value[0] && !value[1] && strchr("rs",*value))
-				popt->check = *value;
-			else if (!strcmp(value,"relaxed")) popt->check = 'r';
-			else if (!strcmp(value,"strict")) popt->check = 's';
-			else return 0;
-		}
-		else if (!strcmp(this_char,"conv") && value) {
-			/* no conversion is done anymore;
-			   we still accept the same mount options,
-			   but ignore them */
-			if (value[0] && !value[1] && strchr("btma",*value)) ;
-			else if (!strcmp(value,"binary")) ;
-			else if (!strcmp(value,"text")) ;
-			else if (!strcmp(value,"mtext")) ;
-			else if (!strcmp(value,"auto")) ;
-			else return 0;
-		}
-		else if (value &&
-			 (!strcmp(this_char,"block") ||
-			  !strcmp(this_char,"mode") ||
-			  !strcmp(this_char,"uid") ||
-			  !strcmp(this_char,"gid"))) {
-		  char * vpnt = value;
-		  unsigned int ivalue = simple_strtoul(vpnt, &vpnt, 0);
-		  if (*vpnt) return 0;
-		  switch(*this_char) {
-		  case 'b':
-		    if (   ivalue != 512
-			&& ivalue != 1024
-			&& ivalue != 2048) return 0;
-		    popt->blocksize = ivalue;
-		    break;
-		  case 'u':
-		    popt->uid = ivalue;
-		    break;
-		  case 'g':
-		    popt->gid = ivalue;
-		    break;
-		  case 'm':
-		    popt->mode = ivalue;
-		    break;
-		  }
-		}
-		else return 1;
 	}
 	return 1;
 }
@@ -814,6 +830,9 @@
 	if (opt.check == 'r') table++;
 	s->s_root->d_op = &isofs_dentry_ops[table];
 
+	if (opt.iocharset)
+		kfree(opt.iocharset);
+
 	return s;
 
 	/*
@@ -856,6 +875,8 @@
 out_freebh:
 	brelse(bh);
 out_unlock:
+	if (opt.iocharset)
+		kfree(opt.iocharset);
 	return NULL;
 }
 
diff -urN S8-pre5/include/linux/parser.h S8-pre5-opt/include/linux/parser.h
--- S8-pre5/include/linux/parser.h	Wed Dec 31 19:00:00 1969
+++ S8-pre5-opt/include/linux/parser.h	Tue Aug  7 11:25:29 2001
@@ -0,0 +1,21 @@
+struct match_token {
+	int token;
+	char *pattern;
+};
+
+typedef struct match_token match_table_t[];
+
+enum { MAX_OPT_ARGS=3 };
+
+typedef struct {
+	char *from;
+	char *to;
+} substring_t;
+
+int match_token(char *s, match_table_t table, substring_t args[]);
+
+int match_int(substring_t *);
+int match_octal(substring_t *);
+int match_hex(substring_t *);
+void match_strcpy(char *, substring_t *);
+char *match_strdup(substring_t *);
diff -urN S8-pre5/lib/Makefile S8-pre5-opt/lib/Makefile
--- S8-pre5/lib/Makefile	Fri Apr 27 06:30:47 2001
+++ S8-pre5-opt/lib/Makefile	Tue Aug  7 11:25:29 2001
@@ -8,9 +8,9 @@
 
 L_TARGET := lib.a
 
-export-objs := cmdline.o rwsem-spinlock.o rwsem.o
+export-objs := cmdline.o rwsem-spinlock.o rwsem.o parser.o
 
-obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o
+obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o parser.o
 
 obj-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
 obj-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
diff -urN S8-pre5/lib/parser.c S8-pre5-opt/lib/parser.c
--- S8-pre5/lib/parser.c	Wed Dec 31 19:00:00 1969
+++ S8-pre5-opt/lib/parser.c	Tue Aug  7 11:26:50 2001
@@ -0,0 +1,131 @@
+/*
+ * lib/parser.c - simple parser for mount, etc. options.
+ */
+
+#include <linux/ctype.h>
+#include <linux/string.h>
+#include <linux/parser.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+
+static int match_one(char *s, char *p, substring_t args[])
+{
+	char *meta;
+	int argc = 0;
+
+	if (!p)
+		return 1;
+
+	if (*p != *s && *p != '%')
+		return 0;
+
+	while(1) {
+		int len = -1;
+		meta = strchr(p, '%');
+		if (!meta)
+			return strcmp(p, s) == 0;
+
+		if (strncmp(p, s, meta-p))
+			return 0;
+
+		s += meta - p;
+		p = meta + 1;
+
+		if (isdigit(*p))
+			len = simple_strtoul(p, &p, 10);
+		else if (*p == '%') {
+			if (*s++ != '%')
+				return 0;
+			continue;
+		}
+
+		if (argc >= MAX_OPT_ARGS)
+			return 0;
+
+		args[argc].from = s;
+		switch (*p++) {
+			case 's':
+				if (len == -1 || len > strlen(s))
+					len = strlen(s);
+				args[argc].to = s + len;
+				break;
+			case 'd':
+				simple_strtol(s, &args[argc].to, 0);
+				goto num;
+			case 'u':
+				simple_strtoul(s, &args[argc].to, 0);
+				goto num;
+			case 'o':
+				simple_strtoul(s, &args[argc].to, 8);
+				goto num;
+			case 'x':
+				simple_strtoul(s, &args[argc].to, 16);
+			num:
+				if (args[argc].to == args[argc].from)
+					return 0;
+				break;
+			default:
+				return 0;
+		}
+		s = args[argc].to;
+		argc++;
+	}
+}
+
+int match_token(char *s, match_table_t table, substring_t args[])
+{
+	struct match_token *p;
+
+	for (p = table; !match_one(s, p->pattern, args) ; p++)
+		;
+
+	return p->token;
+}
+
+int match_int(substring_t *s)
+{
+	char buf[s->to - s->from + 1];
+
+	memcpy(buf, s->from, s->to - s->from);
+	buf[s->to - s->from] = '\0';
+	return simple_strtol(buf, NULL, 0);
+}
+
+int match_octal(substring_t *s)
+{
+	char buf[s->to - s->from + 1];
+
+	memcpy(buf, s->from, s->to - s->from);
+	buf[s->to - s->from] = '\0';
+	return simple_strtoul(buf, NULL, 8);
+}
+
+int match_hex(substring_t *s)
+{
+	char buf[s->to - s->from + 1];
+
+	memcpy(buf, s->from, s->to - s->from);
+	buf[s->to - s->from] = '\0';
+	return simple_strtoul(buf, NULL, 16);
+}
+
+void match_strcpy(char *to, substring_t *s)
+{
+	memcpy(to, s->from, s->to - s->from);
+	to[s->to - s->from] = '\0';
+}
+
+char *match_strdup(substring_t *s)
+{
+	char *p = kmalloc(s->to - s->from + 1, GFP_KERNEL);
+	if (p)
+		match_strcpy(p, s);
+	return p;
+}
+
+EXPORT_SYMBOL(match_token);
+EXPORT_SYMBOL(match_int);
+EXPORT_SYMBOL(match_octal);
+EXPORT_SYMBOL(match_hex);
+EXPORT_SYMBOL(match_strcpy);
+EXPORT_SYMBOL(match_strdup);

