Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265758AbTIETd6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 15:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265824AbTIETNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 15:13:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:20881 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265758AbTIETKI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 15:10:08 -0400
Date: Fri, 5 Sep 2003 11:55:46 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: fsdev <linux-fsdevel@vger.kernel.org>
Subject: [CFT] [6/15] ext2 options parsing
Message-Id: <20030905115546.2681b924.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-260-test4-pv/fs/ext2/super.c linux-260-test4-fs/fs/ext2/super.c
--- linux-260-test4-pv/fs/ext2/super.c	2003-08-22 16:57:23.000000000 -0700
+++ linux-260-test4-fs/fs/ext2/super.c	2003-09-03 13:35:54.000000000 -0700
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/blkdev.h>
+#include <linux/parser.h>
 #include <linux/random.h>
 #include <linux/buffer_head.h>
 #include <linux/smp_lock.h>
@@ -265,149 +266,152 @@ static unsigned long get_sb_block(void *
 	return sb_block;
 }
 
-static int want_value(char *value, char *option)
-{
-	if (!value || !*value) {
-		printk(KERN_NOTICE "EXT2-fs: the %s option needs an argument\n",
-		       option);
-		return -1;
-	}
-	return 0;
-}
-
-static int want_null_value(char *value, char *option)
-{
-	if (*value) {
-		printk(KERN_NOTICE "EXT2-fs: Invalid %s argument: %s\n",
-		       option, value);
-		return -1;
-	}
-	return 0;
-}
+enum {
+	Opt_bsd_df, Opt_minix_df, Opt_grpid, Opt_nogrpid,
+	Opt_resgid, Opt_resuid, Opt_sb, Opt_err_cont, Opt_err_panic, Opt_err_ro,
+	Opt_nouid32, Opt_check, Opt_nocheck, Opt_debug, Opt_oldalloc, Opt_orlov, Opt_nobh,
+	Opt_user_xattr, Opt_nouser_xattr, Opt_acl, Opt_noacl,
+	Opt_ignore, Opt_err,
+};
 
-static int want_numeric(char *value, char *option, unsigned long *number)
-{
-	if (want_value(value, option))
-		return -1;
-	*number = simple_strtoul(value, &value, 0);
-	if (want_null_value(value, option))
-		return -1;
-	return 0;
-}
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
+	{Opt_nocheck, "check=none"},
+	{Opt_nocheck, "nocheck"},
+	{Opt_check, "check"},
+	{Opt_debug, "debug"},
+	{Opt_oldalloc, "oldalloc"},
+	{Opt_orlov, "orlov"},
+	{Opt_nobh, "nobh"},
+	{Opt_user_xattr, "user_xattr"},
+	{Opt_nouser_xattr, "nouser_xattr"},
+	{Opt_acl, "acl"},
+	{Opt_noacl, "noacl"},
+	{Opt_ignore, "grpquota"},
+	{Opt_ignore, "noquota"},
+	{Opt_ignore, "quota"},
+	{Opt_ignore, "usrquota"},
+	{Opt_err, NULL}
+};
 
-/*
- * This function has been shamelessly adapted from the msdos fs
- */
 static int parse_options (char * options,
 			  struct ext2_sb_info *sbi)
 {
-	char * this_char;
-	char * value;
+	char * p;
+	substring_t args[MAX_OPT_ARGS];
+	unsigned long kind = EXT2_MOUNT_ERRORS_CONT;
 
 	if (!options)
 		return 1;
-	while ((this_char = strsep (&options, ",")) != NULL) {
-		if (!*this_char)
+
+	while ((p = strsep (&options, ",")) != NULL) {
+		int token;
+		if (!*p)
 			continue;
-		if ((value = strchr (this_char, '=')) != NULL)
-			*value++ = 0;
-#ifdef CONFIG_EXT2_FS_XATTR
-		if (!strcmp (this_char, "user_xattr"))
-			set_opt (sbi->s_mount_opt, XATTR_USER);
-		else if (!strcmp (this_char, "nouser_xattr"))
-			clear_opt (sbi->s_mount_opt, XATTR_USER);
-		else
-#endif
-#ifdef CONFIG_EXT2_FS_POSIX_ACL
-		if (!strcmp(this_char, "acl"))
-			set_opt(sbi->s_mount_opt, POSIX_ACL);
-		else if (!strcmp(this_char, "noacl"))
-			clear_opt(sbi->s_mount_opt, POSIX_ACL);
-		else
-#endif
-		if (!strcmp (this_char, "bsddf"))
-			clear_opt (sbi->s_mount_opt, MINIX_DF);
-		else if (!strcmp (this_char, "nouid32")) {
-			set_opt (sbi->s_mount_opt, NO_UID32);
-		}
-		else if (!strcmp (this_char, "check")) {
-			if (!value || !*value || !strcmp (value, "none"))
-				clear_opt (sbi->s_mount_opt, CHECK);
-			else
+
+		token = match_token(p, tokens, args);
+		switch (token) {
+			case Opt_bsd_df:
+				clear_opt (sbi->s_mount_opt, MINIX_DF);
+				break;
+			case Opt_minix_df:
+				set_opt (sbi->s_mount_opt, MINIX_DF);
+				break;
+			case Opt_grpid:
+				set_opt (sbi->s_mount_opt, GRPID);
+				break;
+			case Opt_nogrpid:
+				clear_opt (sbi->s_mount_opt, GRPID);
+				break;
+			case Opt_resuid:
+				sbi->s_resuid = match_int(&args[0]);
+				break;
+			case Opt_resgid:
+				sbi->s_resgid = match_int(&args[0]);
+				break;
+			case Opt_sb:
+				/* handled by get_sb_block() instead of here */
+				/* *sb_block = match_int(&args[0]); */
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
+				set_opt (sbi->s_mount_opt, NO_UID32);
+				break;
+			case Opt_check:
 #ifdef CONFIG_EXT2_CHECK
 				set_opt (sbi->s_mount_opt, CHECK);
 #else
 				printk("EXT2 Check option not supported\n");
 #endif
-		}
-		else if (!strcmp (this_char, "debug"))
-			set_opt (sbi->s_mount_opt, DEBUG);
-		else if (!strcmp (this_char, "errors")) {
-			if (!value || !*value) {
-				printk ("EXT2-fs: the errors option requires "
-					"an argument\n");
-				return 0;
-			}
-			if (!strcmp (value, "continue")) {
-				clear_opt (sbi->s_mount_opt, ERRORS_RO);
-				clear_opt (sbi->s_mount_opt, ERRORS_PANIC);
-				set_opt (sbi->s_mount_opt, ERRORS_CONT);
-			}
-			else if (!strcmp (value, "remount-ro")) {
-				clear_opt (sbi->s_mount_opt, ERRORS_CONT);
-				clear_opt (sbi->s_mount_opt, ERRORS_PANIC);
-				set_opt (sbi->s_mount_opt, ERRORS_RO);
-			}
-			else if (!strcmp (value, "panic")) {
-				clear_opt (sbi->s_mount_opt, ERRORS_CONT);
-				clear_opt (sbi->s_mount_opt, ERRORS_RO);
-				set_opt (sbi->s_mount_opt, ERRORS_PANIC);
-			}
-			else {
-				printk ("EXT2-fs: Invalid errors option: %s\n",
-					value);
-				return 0;
-			}
-		}
-		else if (!strcmp (this_char, "grpid") ||
-			 !strcmp (this_char, "bsdgroups"))
-			set_opt (sbi->s_mount_opt, GRPID);
-		else if (!strcmp (this_char, "minixdf"))
-			set_opt (sbi->s_mount_opt, MINIX_DF);
-		else if (!strcmp (this_char, "nocheck"))
-			clear_opt (sbi->s_mount_opt, CHECK);
-		else if (!strcmp (this_char, "nogrpid") ||
-			 !strcmp (this_char, "sysvgroups"))
-			clear_opt (sbi->s_mount_opt, GRPID);
-		else if (!strcmp (this_char, "resgid")) {
-			unsigned long v;
-			if (want_numeric(value, "resgid", &v))
-				return 0;
-			sbi->s_resgid = v;
-		}
-		else if (!strcmp (this_char, "resuid")) {
-			unsigned long v;
-			if (want_numeric(value, "resuid", &v))
+				break;
+			case Opt_nocheck:
+				clear_opt (sbi->s_mount_opt, CHECK);
+				break;
+			case Opt_debug:
+				set_opt (sbi->s_mount_opt, DEBUG);
+				break;
+			case Opt_oldalloc:
+				set_opt (sbi->s_mount_opt, OLDALLOC);
+				break;
+			case Opt_orlov:
+				clear_opt (sbi->s_mount_opt, OLDALLOC);
+				break;
+			case Opt_nobh:
+				set_opt (sbi->s_mount_opt, NOBH);
+				break;
+#ifdef CONFIG_EXT2_FS_XATTR
+			case Opt_user_xattr:
+				set_opt (sbi->s_mount_opt, XATTR_USER);
+				break;
+			case Opt_nouser_xattr:
+				clear_opt (sbi->s_mount_opt, XATTR_USER);
+				break;
+#else
+			case Opt_user_xattr:
+			case Opt_nouser_xattr:
+				printk("EXT2 (no)user_xattr options not supported\n");
+				break;
+#endif
+#ifdef CONFIG_EXT2_FS_POSIX_ACL
+			case Opt_acl:
+				set_opt(sbi->s_mount_opt, POSIX_ACL);
+				break;
+			case Opt_noacl:
+				clear_opt(sbi->s_mount_opt, POSIX_ACL);
+				break;
+#else
+			case Opt_acl:
+			case Opt_noacl:
+				printk("EXT2 (no)acl options not supported\n");
+				break;
+#endif
+			case Opt_ignore:
+				break;
+			default:
 				return 0;
-			sbi->s_resuid = v;
-		}
-		else if (!strcmp (this_char, "oldalloc"))
-			set_opt (sbi->s_mount_opt, OLDALLOC);
-		else if (!strcmp (this_char, "orlov"))
-			clear_opt (sbi->s_mount_opt, OLDALLOC);
-		else if (!strcmp (this_char, "nobh"))
-			set_opt(sbi->s_mount_opt, NOBH);
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
+	sbi->s_mount_opt |= kind;
 	return 1;
 }
 


--
~Randy
