Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265759AbTIETVX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 15:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265891AbTIETUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 15:20:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:25489 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265759AbTIETKH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 15:10:07 -0400
Date: Fri, 5 Sep 2003 12:00:36 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: fsdev <linux-fsdevel@vger.kernel.org>
Subject: [CFT] [14/15] udf options parsing
Message-Id: <20030905120036.05acbe0a.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-260-test4-pv/fs/udf/super.c linux-260-test4-fs/fs/udf/super.c
--- linux-260-test4-pv/fs/udf/super.c	2003-08-22 16:57:22.000000000 -0700
+++ linux-260-test4-fs/fs/udf/super.c	2003-09-03 14:21:52.000000000 -0700
@@ -51,6 +51,7 @@
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/parser.h>
 #include <linux/stat.h>
 #include <linux/cdrom.h>
 #include <linux/nls.h>
@@ -226,7 +227,7 @@ module_exit(exit_udf_fs)
  *	gid=		Set the default group.
  *	umask=		Set the default umask.
  *	uid=		Set the default user.
- *	bs=			Set the block size.
+ *	bs=		Set the block size.
  *	unhide		Show otherwise hidden files.
  *	undelete	Show deleted files in lists.
  *	adinicb		Embed data in the inode (default)
@@ -260,18 +261,52 @@ module_exit(exit_udf_fs)
  *	uopts		Pointer to mount options variable.
  *
  * POST-CONDITIONS
- *	<return>	0	Mount options parsed okay.
- *	<return>	-1	Error parsing mount options.
+ *	<return>	1	Mount options parsed okay.
+ *	<return>	0	Error parsing mount options.
  *
  * HISTORY
  *	July 1, 1997 - Andrew E. Mileski
  *	Written, tested, and released.
  */
 
+enum {
+	Opt_novrs, Opt_nostrict, Opt_bs, Opt_unhide, Opt_undelete,
+	Opt_noadinicb, Opt_adinicb, Opt_shortad, Opt_longad,
+	Opt_gid, Opt_uid, Opt_umask, Opt_session, Opt_lastblock,
+	Opt_anchor, Opt_volume, Opt_partition, Opt_fileset,
+	Opt_rootdir, Opt_utf8, Opt_iocharset,
+	Opt_err
+};
+
+static match_table_t tokens = {
+	{Opt_novrs, "novrs"},
+	{Opt_nostrict, "nostrict"},
+	{Opt_bs, "bs=%u"},
+	{Opt_unhide, "unhide"},
+	{Opt_undelete, "undelete"},
+	{Opt_noadinicb, "noadinicb"},
+	{Opt_adinicb, "adinicb"},
+	{Opt_shortad, "shortad"},
+	{Opt_longad, "longad"},
+	{Opt_gid, "gid=%u"},
+	{Opt_uid, "uid=%u"},
+	{Opt_umask, "umask=%o"},
+	{Opt_session, "session=%u"},
+	{Opt_lastblock, "lastblock=%u"},
+	{Opt_anchor, "anchor=%u"},
+	{Opt_volume, "volume=%u"},
+	{Opt_partition, "partition=%u"},
+	{Opt_fileset, "fileset=%u"},
+	{Opt_rootdir, "rootdir=%u"},
+	{Opt_utf8, "utf8"},
+	{Opt_iocharset, "iocharset=%s"},
+	{Opt_err, NULL}
+};
+
 static int
 udf_parse_options(char *options, struct udf_options *uopt)
 {
-	char *opt, *val;
+	char *p;
 
 	uopt->novrs = 0;
 	uopt->blocksize = 2048;
@@ -287,72 +322,85 @@ udf_parse_options(char *options, struct 
 	if (!options)
 		return 1;
 
-	while ((opt = strsep(&options, ",")) != NULL)
-	{
-		if (!*opt)
+	while ((p = strsep(&options, ",")) != NULL) {
+		substring_t args[MAX_OPT_ARGS];
+		int token;
+		if (!*p)
 			continue;
-		/* Make "opt=val" into two strings */
-		val = strchr(opt, '=');
-		if (val)
-			*(val++) = 0;
-		if (!strcmp(opt, "novrs") && !val)
-			uopt->novrs = 1;
-		else if (!strcmp(opt, "bs") && val)
-			uopt->blocksize = simple_strtoul(val, NULL, 0);
-		else if (!strcmp(opt, "unhide") && !val)
-			uopt->flags |= (1 << UDF_FLAG_UNHIDE);
-		else if (!strcmp(opt, "undelete") && !val)
-			uopt->flags |= (1 << UDF_FLAG_UNDELETE);
-		else if (!strcmp(opt, "noadinicb") && !val)
-			uopt->flags &= ~(1 << UDF_FLAG_USE_AD_IN_ICB);
-		else if (!strcmp(opt, "adinicb") && !val)
-			uopt->flags |= (1 << UDF_FLAG_USE_AD_IN_ICB);
-		else if (!strcmp(opt, "shortad") && !val)
-			uopt->flags |= (1 << UDF_FLAG_USE_SHORT_AD);
-		else if (!strcmp(opt, "longad") && !val)
-			uopt->flags &= ~(1 << UDF_FLAG_USE_SHORT_AD);
-		else if (!strcmp(opt, "gid") && val)
-			uopt->gid = simple_strtoul(val, NULL, 0);
-		else if (!strcmp(opt, "umask") && val)
-			uopt->umask = simple_strtoul(val, NULL, 0);
-		else if (!strcmp(opt, "nostrict") && !val)
-			uopt->flags &= ~(1 << UDF_FLAG_STRICT);
-		else if (!strcmp(opt, "uid") && val)
-			uopt->uid = simple_strtoul(val, NULL, 0);
-		else if (!strcmp(opt, "session") && val)
-			uopt->session = simple_strtoul(val, NULL, 0);
-		else if (!strcmp(opt, "lastblock") && val)
-			uopt->lastblock = simple_strtoul(val, NULL, 0);
-		else if (!strcmp(opt, "anchor") && val)
-			uopt->anchor = simple_strtoul(val, NULL, 0);
-		else if (!strcmp(opt, "volume") && val)
-			uopt->volume = simple_strtoul(val, NULL, 0);
-		else if (!strcmp(opt, "partition") && val)
-			uopt->partition = simple_strtoul(val, NULL, 0);
-		else if (!strcmp(opt, "fileset") && val)
-			uopt->fileset = simple_strtoul(val, NULL, 0);
-		else if (!strcmp(opt, "rootdir") && val)
-			uopt->rootdir = simple_strtoul(val, NULL, 0);
+
+		token = match_token(p, tokens, args);
+		switch (token) {
+			case Opt_novrs:
+				uopt->novrs = 1;
+				break;
+			case Opt_bs:
+				uopt->blocksize = match_int(&args[0]);
+				break;
+			case Opt_unhide:
+				uopt->flags |= (1 << UDF_FLAG_UNHIDE);
+				break;
+			case Opt_undelete:
+				uopt->flags |= (1 << UDF_FLAG_UNDELETE);
+				break;
+			case Opt_noadinicb:
+				uopt->flags &= ~(1 << UDF_FLAG_USE_AD_IN_ICB);
+				break;
+			case Opt_adinicb:
+				uopt->flags |= (1 << UDF_FLAG_USE_AD_IN_ICB);
+				break;
+			case Opt_shortad:
+				uopt->flags |= (1 << UDF_FLAG_USE_SHORT_AD);
+				break;
+			case Opt_longad:
+				uopt->flags &= ~(1 << UDF_FLAG_USE_SHORT_AD);
+				break;
+			case Opt_gid:
+				uopt->gid = match_int(args);
+				break;
+			case Opt_uid:
+				uopt->uid = match_int(args);
+				break;
+			case Opt_umask:
+				uopt->umask = match_octal(args);
+				break;
+			case Opt_nostrict:
+				uopt->flags &= ~(1 << UDF_FLAG_STRICT);
+				break;
+			case Opt_session:
+				uopt->session = match_int(args);
+				break;
+			case Opt_lastblock:
+				uopt->lastblock = match_int(args);
+				break;
+			case Opt_anchor:
+				uopt->anchor = match_int(args);
+				break;
+			case Opt_volume:
+				uopt->volume = match_int(args);
+				break;
+			case Opt_partition:
+				uopt->partition = match_int(args);
+				break;
+			case Opt_fileset:
+				uopt->fileset = match_int(args);
+				break;
+			case Opt_rootdir:
+				uopt->rootdir = match_int(args);
+				break;
+			case Opt_utf8:
+				uopt->flags |= (1 << UDF_FLAG_UTF8);
+				break;
 #ifdef CONFIG_NLS
-		else if (!strcmp(opt, "iocharset") && val)
-		{
-			uopt->nls_map = load_nls(val);
-			uopt->flags |= (1 << UDF_FLAG_NLS_MAP);
-		}
+			case Opt_iocharset:
+				uopt->nls_map = load_nls(args[0].from);
+				uopt->flags |= (1 << UDF_FLAG_NLS_MAP);
+				break;
 #endif
-		else if (!strcmp(opt, "utf8") && !val)
-			uopt->flags |= (1 << UDF_FLAG_UTF8);
-		else if (val)
-		{
-			printk(KERN_ERR "udf: bad mount option \"%s=%s\"\n",
-				opt, val);
-			return 0;
-		}
-		else
-		{
-			printk(KERN_ERR "udf: bad mount option \"%s\"\n",
-				opt);
-			return 0;
+			default:
+				printk(KERN_ERR "udf: bad mount option \"%s\" "
+						"or missing value\n",
+					p);
+				return 0;
 		}
 	}
 	return 1;


--
~Randy
