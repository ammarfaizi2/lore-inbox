Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265883AbTIETTk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 15:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265888AbTIETTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 15:19:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:18833 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265762AbTIETKH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 15:10:07 -0400
Date: Fri, 5 Sep 2003 11:51:22 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [CFT] [2/15] adfs options parsing
Message-Id: <20030905115122.2c0d0cfc.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-260-test4-pv/fs/adfs/super.c linux-260-test4-fs/fs/adfs/super.c
--- linux-260-test4-pv/fs/adfs/super.c	2003-08-22 16:50:52.000000000 -0700
+++ linux-260-test4-fs/fs/adfs/super.c	2003-09-03 14:20:04.000000000 -0700
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 #include <linux/buffer_head.h>
 #include <linux/vfs.h>
+#include <linux/parser.h>
 
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
@@ -134,51 +135,48 @@ static void adfs_put_super(struct super_
 	sb->s_fs_info = NULL;
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
 	struct adfs_sb_info *asb = ADFS_SB(sb);
 
 	if (!options)
 		return 0;
 
-	while ((opt = strsep(&options, ",")) != NULL) {
-		if (!*opt)
+	while ((p = strsep(&options, ",")) != NULL) {
+		substring_t args[MAX_OPT_ARGS];
+		int token;
+		if (!*p)
 			continue;
-		value = strchr(opt, '=');
-		if (value)
-			*value++ = '\0';
 
-		if (!strcmp(opt, "uid")) {	/* owner of all files */
-			if (!value || !*value)
-				return -EINVAL;
-			asb->s_uid = simple_strtoul(value, &value, 0);
-			if (*value)
-				return -EINVAL;
-		} else
-		if (!strcmp(opt, "gid")) {	/* group owner of all files */
-			if (!value || !*value)
-				return -EINVAL;
-			asb->s_gid = simple_strtoul(value, &value, 0);
-			if (*value)
-				return -EINVAL;
-		} else
-		if (!strcmp(opt, "ownmask")) {	/* owner permission mask */
-			if (!value || !*value)
-				return -EINVAL;
-			asb->s_owner_mask = simple_strtoul(value, &value, 8);
-			if (*value)
-				return -EINVAL;
-		} else
-		if (!strcmp(opt, "othmask")) {	/* others permission mask */
-			if (!value || !*value)
-				return -EINVAL;
-			asb->s_other_mask = simple_strtoul(value, &value, 8);
-			if (*value)
+		token = match_token(p, tokens, args);
+		switch (token) {
+			case Opt_uid:
+				asb->s_uid = match_int(args);
+				break;
+			case Opt_gid:
+				asb->s_gid = match_int(args);
+				break;
+			case Opt_ownmask:
+				asb->s_owner_mask = match_octal(args);
+				break;
+			case Opt_othmask:
+				asb->s_other_mask = match_octal(args);
+				break;
+			default:
+				printk("ADFS-fs: unrecognised mount option \"%s\" "
+						"or missing value\n", p);
 				return -EINVAL;
-		} else {			/* eh? say again. */
-			printk("ADFS-fs: unrecognised mount option %s\n", opt);
-			return -EINVAL;
 		}
 	}
 	return 0;


--
~Randy
