Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265980AbTIET3z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 15:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265866AbTIETRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 15:17:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:19345 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265765AbTIETKH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 15:10:07 -0400
Date: Fri, 5 Sep 2003 11:53:04 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [CFT] [3/15]  affs options parsing
Message-Id: <20030905115304.54609039.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-260-test4-pv/fs/affs/super.c linux-260-test4-fs/fs/affs/super.c
--- linux-260-test4-pv/fs/affs/super.c	2003-08-22 16:57:49.000000000 -0700
+++ linux-260-test4-fs/fs/affs/super.c	2003-09-03 14:20:28.000000000 -0700
@@ -28,6 +28,7 @@
 #include <linux/smp_lock.h>
 #include <linux/buffer_head.h>
 #include <linux/vfs.h>
+#include <linux/parser.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
 
@@ -142,12 +143,37 @@ static struct super_operations affs_sops
 	.remount_fs	= affs_remount,
 };
 
+enum {
+	Opt_bs, Opt_mode, Opt_mufs, Opt_prefix, Opt_protect,
+	Opt_reserved, Opt_root, Opt_setgid, Opt_setuid,
+	Opt_verbose, Opt_volume, Opt_ignore, Opt_err,
+};
+
+static match_table_t tokens = {
+	{Opt_bs, "bs=%d"},
+	{Opt_mode, "mode=%o"},
+	{Opt_mufs, "mufs"},
+	{Opt_prefix, "prefix=%s"},
+	{Opt_protect, "protect"},
+	{Opt_reserved, "reserved=%d"},
+	{Opt_root, "root=%d"},
+	{Opt_setgid, "setgid=%d"},
+	{Opt_setuid, "setuid=%d"},
+	{Opt_verbose, "verbose"},
+	{Opt_volume, "volume=%s"},
+	{Opt_ignore, "grpquota"},
+	{Opt_ignore, "noquota"},
+	{Opt_ignore, "quota"},
+	{Opt_ignore, "usrquota"},
+	{Opt_err, NULL},
+};
+
 static int
 parse_options(char *options, uid_t *uid, gid_t *gid, int *mode, int *reserved, s32 *root,
 		int *blocksize, char **prefix, char *volume, unsigned long *mount_opts)
 {
-	char	*this_char, *value, *optn;
-	int	 f;
+	char *p;
+	substring_t args[MAX_OPT_ARGS];
 
 	/* Fill in defaults */
 
@@ -161,109 +187,76 @@ parse_options(char *options, uid_t *uid,
 	*mount_opts = 0;
 	if (!options)
 		return 1;
-	while ((this_char = strsep(&options, ",")) != NULL) {
-		if (!*this_char)
+
+	while ((p = strsep(&options, ",")) != NULL) {
+		int token, n;
+		if (!*p)
 			continue;
-		f = 0;
-		if ((value = strchr(this_char,'=')) != NULL)
-			*value++ = 0;
-		if ((optn = "protect") && !strcmp(this_char, optn)) {
-			if (value)
-				goto out_inv_arg;
-			*mount_opts |= SF_IMMUTABLE;
-		} else if ((optn = "verbose") && !strcmp(this_char, optn)) {
-			if (value)
-				goto out_inv_arg;
-			*mount_opts |= SF_VERBOSE;
-		} else if ((optn = "mufs") && !strcmp(this_char, optn)) {
-			if (value)
-				goto out_inv_arg;
-			*mount_opts |= SF_MUFS;
-		} else if ((f = !strcmp(this_char,"setuid")) || !strcmp(this_char,"setgid")) {
-			if (value) {
-				if (!*value) {
-					printk("AFFS: Argument for set[ug]id option missing\n");
+
+		token = match_token(p, tokens, args);
+		switch (token) {
+			case Opt_bs:
+				n = match_int(&args[0]);
+				if (n != 512 && n != 1024 && n != 2048
+				    && n != 4096) {
+					printk ("AFFS: Invalid blocksize (512, 1024, 2048, 4096 allowed)\n");
 					return 0;
-				} else {
-					(f ? *uid : *gid) = simple_strtoul(value,&value,0);
-					if (*value) {
-						printk("AFFS: Bad set[ug]id argument\n");
-						return 0;
-					}
-					*mount_opts |= f ? SF_SETUID : SF_SETGID;
 				}
+				*blocksize = n;
+				break;
+			case Opt_mode:
+				*mode = match_octal(&args[0]) & 0777;
+				*mount_opts |= SF_SETMODE;
+				break;
+			case Opt_mufs:
+				*mount_opts |= SF_MUFS;
+				break;
+			case Opt_prefix:
+				if (*prefix) {		/* Free any previous prefix */
+					kfree(*prefix);
+					*prefix = NULL;
+				}
+				*prefix = match_strdup(&args[0]);
+				if (!*prefix)
+					return 0;
+				*mount_opts |= SF_PREFIX;
+				break;
+			case Opt_protect:
+				*mount_opts |= SF_IMMUTABLE;
+				break;
+			case Opt_reserved:
+				*reserved = match_int(&args[0]);
+				break;
+			case Opt_root:
+				*root = match_int(&args[0]);
+				break;
+			case Opt_setgid:
+				*gid = match_int(&args[0]);
+				*mount_opts |= SF_SETGID;
+				break;
+			case Opt_setuid:
+				*uid = match_int(&args[0]);
+				*mount_opts |= SF_SETUID;
+				break;
+			case Opt_verbose:
+				*mount_opts |= SF_VERBOSE;
+				break;
+			case Opt_volume: {
+				char *vol = match_strdup(&args[0]);
+				strlcpy(volume, vol, 32);
+				kfree(vol);
+				break;
 			}
-		} else if (!strcmp(this_char,"prefix")) {
-			optn = "prefix";
-			if (!value || !*value)
-				goto out_no_arg;
-			if (*prefix) {		/* Free any previous prefix */
-				kfree(*prefix);
-				*prefix = NULL;
-			}
-			*prefix = kmalloc(strlen(value) + 1,GFP_KERNEL);
-			if (!*prefix)
+			case Opt_ignore:
+			 	/* Silently ignore the quota options */
+				break;
+			default:
+				printk("AFFS: Unrecognized mount option \"%s\" "
+						"or missing value\n", p);
 				return 0;
-			strcpy(*prefix,value);
-			*mount_opts |= SF_PREFIX;
-		} else if (!strcmp(this_char,"volume")) {
-			optn = "volume";
-			if (!value || !*value)
-				goto out_no_arg;
-			strlcpy(volume,value,31);
-		} else if (!strcmp(this_char,"mode")) {
-			optn = "mode";
-			if (!value || !*value)
-				goto out_no_arg;
-			*mode = simple_strtoul(value,&value,8) & 0777;
-			if (*value)
-				return 0;
-			*mount_opts |= SF_SETMODE;
-		} else if (!strcmp(this_char,"reserved")) {
-			optn = "reserved";
-			if (!value || !*value)
-				goto out_no_arg;
-			*reserved = simple_strtoul(value,&value,0);
-			if (*value)
-				return 0;
-		} else if (!strcmp(this_char,"root")) {
-			optn = "root";
-			if (!value || !*value)
-				goto out_no_arg;
-			*root = simple_strtoul(value,&value,0);
-			if (*value)
-				return 0;
-		} else if (!strcmp(this_char,"bs")) {
-			optn = "bs";
-			if (!value || !*value)
-				goto out_no_arg;
-			*blocksize = simple_strtoul(value,&value,0);
-			if (*value)
-				return 0;
-			if (*blocksize != 512 && *blocksize != 1024 && *blocksize != 2048
-			    && *blocksize != 4096) {
-				printk ("AFFS: Invalid blocksize (512, 1024, 2048, 4096 allowed)\n");
-				return 0;
-			}
-		} else if (!strcmp (this_char, "grpquota")
-			 || !strcmp (this_char, "noquota")
-			 || !strcmp (this_char, "quota")
-			 || !strcmp (this_char, "usrquota"))
-			 /* Silently ignore the quota options */
-			;
-		else {
-			printk("AFFS: Unrecognized mount option %s\n", this_char);
-			return 0;
 		}
 	}
 	return 1;
-
-out_no_arg:
-	printk("AFFS: The %s option requires an argument\n", optn);
-	return 0;
-out_inv_arg:
-	printk("AFFS: Option %s does not take an argument\n", optn);
-	return 0;
 }
 
 /* This function definitely needs to be split up. Some fine day I'll


--
~Randy
