Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266007AbTIETd6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 15:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265758AbTIETNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 15:13:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:24977 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265775AbTIETKH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 15:10:07 -0400
Date: Fri, 5 Sep 2003 12:00:05 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: fsdev <linux-fsdevel@vger.kernel.org>
Subject: [CFT] [13/15] proc options parsing
Message-Id: <20030905120005.68620844.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-260-test4-pv/fs/proc/inode.c linux-260-test4-fs/fs/proc/inode.c
--- linux-260-test4-pv/fs/proc/inode.c	2003-08-22 16:59:37.000000000 -0700
+++ linux-260-test4-fs/fs/proc/inode.c	2003-08-27 11:19:07.000000000 -0700
@@ -14,6 +14,7 @@
 #include <linux/limits.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/parser.h>
 #include <linux/smp_lock.h>
 #include <linux/init.h>
 
@@ -136,34 +137,42 @@ static struct super_operations proc_sops
 	.statfs		= simple_statfs,
 };
 
+enum {
+	Opt_uid, Opt_gid, Opt_err
+};
+
+static match_table_t tokens = {
+	{Opt_uid, "uid=%u"},
+	{Opt_gid, "gid=%u"},
+	{Opt_err, NULL}
+};
+
 static int parse_options(char *options,uid_t *uid,gid_t *gid)
 {
-	char *this_char,*value;
+	char *p;
 
 	*uid = current->uid;
 	*gid = current->gid;
 	if (!options)
 		return 1;
-	while ((this_char = strsep(&options,",")) != NULL) {
-		if (!*this_char)
+
+	while ((p = strsep(&options, ",")) != NULL) {
+		substring_t args[MAX_OPT_ARGS];
+		int token;
+		if (!*p)
 			continue;
-		if ((value = strchr(this_char,'=')) != NULL)
-			*value++ = 0;
-		if (!strcmp(this_char,"uid")) {
-			if (!value || !*value)
-				return 0;
-			*uid = simple_strtoul(value,&value,0);
-			if (*value)
-				return 0;
-		}
-		else if (!strcmp(this_char,"gid")) {
-			if (!value || !*value)
-				return 0;
-			*gid = simple_strtoul(value,&value,0);
-			if (*value)
+
+		token = match_token(p, tokens, args);
+		switch (token) {
+			case Opt_uid:
+				*uid = match_int(args);
+				break;
+			case Opt_gid:
+				*gid = match_int(args);
+				break;
+			default:
 				return 0;
 		}
-		else return 1;
 	}
 	return 1;
 }


--
~Randy
