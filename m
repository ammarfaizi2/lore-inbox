Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265780AbTIETOx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 15:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265830AbTIETON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 15:14:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:24465 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265780AbTIETKH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 15:10:07 -0400
Date: Fri, 5 Sep 2003 11:59:27 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: fsdev <linux-fsdevel@vger.kernel.org>
Subject: [CFT] [12/15] jfs options parsing
Message-Id: <20030905115927.044185b7.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-260-test4-pv/fs/jfs/super.c linux-260-test4-fs/fs/jfs/super.c
--- linux-260-test4-pv/fs/jfs/super.c	2003-08-22 16:55:32.000000000 -0700
+++ linux-260-test4-fs/fs/jfs/super.c	2003-09-03 14:21:11.000000000 -0700
@@ -20,6 +20,7 @@
 #include <linux/fs.h>
 #include <linux/config.h>
 #include <linux/module.h>
+#include <linux/parser.h>
 #include <linux/completion.h>
 #include <linux/vfs.h>
 #include <asm/uaccess.h>
@@ -164,59 +165,82 @@ static void jfs_put_super(struct super_b
 	kfree(sbi);
 }
 
+enum {
+	Opt_integrity, Opt_nointegrity, Opt_iocharset, Opt_resize,
+	Opt_ignore, Opt_err,
+};
+
+static match_table_t tokens = {
+	{Opt_integrity, "integrity"},
+	{Opt_nointegrity, "nointegrity"},
+	{Opt_iocharset, "iocharset=%s"},
+	{Opt_resize, "resize=%u"},
+	{Opt_ignore, "noquota"},
+	{Opt_ignore, "quota"},
+	{Opt_ignore, "usrquota"},
+	{Opt_ignore, "grpquota"},
+	{Opt_err, NULL}
+};
+
 static int parse_options(char *options, struct super_block *sb, s64 *newLVSize,
 			 int *flag)
 {
 	void *nls_map = NULL;
-	char *this_char;
-	char *value;
+	char *p;
 	struct jfs_sb_info *sbi = JFS_SBI(sb);
 
 	*newLVSize = 0;
 
 	if (!options)
 		return 1;
-	while ((this_char = strsep(&options, ",")) != NULL) {
-		if (!*this_char)
+
+	while ((p = strsep(&options, ",")) != NULL) {
+		substring_t args[MAX_OPT_ARGS];
+		int token;
+		if (!*p)
 			continue;
-		if ((value = strchr(this_char, '=')) != NULL)
-			*value++ = 0;
-		if (!strcmp(this_char, "integrity")) {
-			*flag &= ~JFS_NOINTEGRITY;
-		} else 	if (!strcmp(this_char, "nointegrity")) {
-			*flag |= JFS_NOINTEGRITY;
-		} else if (!strcmp(this_char, "iocharset")) {
-			if (!value || !*value)
-				goto needs_arg;
-			if (nls_map)	/* specified iocharset twice! */
-				unload_nls(nls_map);
-			nls_map = load_nls(value);
-			if (!nls_map) {
-				printk(KERN_ERR "JFS: charset not found\n");
-				goto cleanup;
+
+		token = match_token(p, tokens, args);
+		switch (token) {
+			case Opt_integrity:
+				*flag &= ~JFS_NOINTEGRITY;
+				break;
+			case Opt_nointegrity:
+				*flag |= JFS_NOINTEGRITY;
+				break;
+			case Opt_ignore:
+				/* Silently ignore the quota options */
+				/* Don't do anything ;-) */
+				break;
+			case Opt_iocharset:
+				if (nls_map)	/* specified iocharset twice! */
+					unload_nls(nls_map);
+				nls_map = load_nls(args[0].from);
+				if (!nls_map) {
+					printk(KERN_ERR "JFS: charset not found\n");
+					goto cleanup;
+				}
+				break;
+			case Opt_resize:
+			{
+				char *resize = args[0].from;
+				if (!resize || !*resize) {
+					*newLVSize = sb->s_bdev->bd_inode->i_size >>
+						sb->s_blocksize_bits;
+					if (*newLVSize == 0)
+						printk(KERN_ERR
+						"JFS: Cannot determine volume size\n");
+				} else
+					*newLVSize = simple_strtoull(resize, &resize, 0);
+				break;
 			}
-		} else if (!strcmp(this_char, "resize")) {
-			if (!value || !*value) {
-				*newLVSize = sb->s_bdev->bd_inode->i_size >>
-					sb->s_blocksize_bits;
-				if (*newLVSize == 0)
-					printk(KERN_ERR
-					 "JFS: Cannot determine volume size\n");
-			} else
-				*newLVSize = simple_strtoull(value, &value, 0);
-
-			/* Silently ignore the quota options */
-		} else if (!strcmp(this_char, "grpquota")
-			   || !strcmp(this_char, "noquota")
-			   || !strcmp(this_char, "quota")
-			   || !strcmp(this_char, "usrquota"))
-			/* Don't do anything ;-) */ ;
-		else {
-			printk("jfs: Unrecognized mount option %s\n",
-			       this_char);
-			goto cleanup;
+			default:
+				printk("jfs: Unrecognized mount option \"%s\" "
+						" or missing value\n", p);
+				goto cleanup;
 		}
 	}
+
 	if (nls_map) {
 		/* Discard old (if remount) */
 		if (sbi->nls_tab)
@@ -224,8 +248,7 @@ static int parse_options(char *options, 
 		sbi->nls_tab = nls_map;
 	}
 	return 1;
-needs_arg:
-	printk(KERN_ERR "JFS: %s needs an argument\n", this_char);
+
 cleanup:
 	if (nls_map)
 		unload_nls(nls_map);


--
~Randy
