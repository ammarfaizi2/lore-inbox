Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265761AbTIETQa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 15:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265844AbTIETQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 15:16:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:23441 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265761AbTIETKH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 15:10:07 -0400
Date: Fri, 5 Sep 2003 11:58:23 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: fsdev <linux-fsdevel@vger.kernel.org>
Subject: [CFT] [10/15] hpfs options parsing
Message-Id: <20030905115823.6b21c817.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-260-test4-pv/fs/hpfs/super.c linux-260-test4-fs/fs/hpfs/super.c
--- linux-260-test4-pv/fs/hpfs/super.c	2003-08-22 16:57:01.000000000 -0700
+++ linux-260-test4-fs/fs/hpfs/super.c	2003-08-27 11:19:07.000000000 -0700
@@ -10,6 +10,7 @@
 #include <linux/string.h>
 #include "hpfs_fn.h"
 #include <linux/module.h>
+#include <linux/parser.h>
 #include <linux/init.h>
 #include <linux/vfs.h>
 
@@ -219,15 +220,51 @@ static struct super_operations hpfs_sops
 
 /*
  * A tiny parser for option strings, stolen from dosfs.
- *
  * Stolen again from read-only hpfs.
+ * And updated for table-driven option parsing.
  */
 
+enum {
+	Opt_help, Opt_uid, Opt_gid, Opt_umask, Opt_case_lower, Opt_case_asis,
+	Opt_conv_binary, Opt_conv_text, Opt_conv_auto,
+	Opt_check_none, Opt_check_normal, Opt_check_strict,
+	Opt_err_cont, Opt_err_ro, Opt_err_panic,
+	Opt_eas_no, Opt_eas_ro, Opt_eas_rw,
+	Opt_chkdsk_no, Opt_chkdsk_errors, Opt_chkdsk_always,
+	Opt_timeshift, Opt_err,
+};
+
+static match_table_t tokens = {
+	{Opt_help, "help"},
+	{Opt_uid, "uid=%u"},
+	{Opt_gid, "gid=%u"},
+	{Opt_umask, "umask=%o"},
+	{Opt_case_lower, "case=lower"},
+	{Opt_case_asis, "case=asis"},
+	{Opt_conv_binary, "conv=binary"},
+	{Opt_conv_text, "conv=text"},
+	{Opt_conv_auto, "conv=auto"},
+	{Opt_check_none, "check=none"},
+	{Opt_check_normal, "check=normal"},
+	{Opt_check_strict, "check=strict"},
+	{Opt_err_cont, "errors=continue"},
+	{Opt_err_ro, "errors=remount-ro"},
+	{Opt_err_panic, "errors=panic"},
+	{Opt_eas_no, "eas=no"},
+	{Opt_eas_ro, "eas=ro"},
+	{Opt_eas_rw, "eas=rw"},
+	{Opt_chkdsk_no, "chkdsk=no"},
+	{Opt_chkdsk_errors, "chkdsk=errors"},
+	{Opt_chkdsk_always, "chkdsk=always"},
+	{Opt_timeshift, "timeshift=%d"},
+	{Opt_err, NULL},
+};
+
 int parse_opts(char *opts, uid_t *uid, gid_t *gid, umode_t *umask,
 	       int *lowercase, int *conv, int *eas, int *chk, int *errs,
 	       int *chkdsk, int *timeshift)
 {
-	char *p, *rhs;
+	char *p;
 
 	if (!opts)
 		return 1;
@@ -235,114 +272,91 @@ int parse_opts(char *opts, uid_t *uid, g
 	/*printk("Parsing opts: '%s'\n",opts);*/
 
 	while ((p = strsep(&opts, ",")) != NULL) {
+		substring_t args[MAX_OPT_ARGS];
+		int token;
 		if (!*p)
 			continue;
-		if ((rhs = strchr(p, '=')) != 0)
-			*rhs++ = '\0';
-		if (!strcmp(p, "help")) return 2;
-		if (!strcmp(p, "uid")) {
-			if (!rhs || !*rhs)
-				return 0;
-			*uid = simple_strtoul(rhs, &rhs, 0);
-			if (*rhs)
-				return 0;
-		}
-		else if (!strcmp(p, "gid")) {
-			if (!rhs || !*rhs)
-				return 0;
-			*gid = simple_strtoul(rhs, &rhs, 0);
-			if (*rhs)
-				return 0;
-		}
-		else if (!strcmp(p, "umask")) {
-			if (!rhs || !*rhs)
-				return 0;
-			*umask = simple_strtoul(rhs, &rhs, 8);
-			if (*rhs)
-				return 0;
-		}
-		else if (!strcmp(p, "timeshift")) {
-			int m = 1;
-			if (!rhs || !*rhs)
-				return 0;
-			if (*rhs == '-') m = -1;
-			if (*rhs == '+' || *rhs == '-') rhs++;
-			*timeshift = simple_strtoul(rhs, &rhs, 0) * m;
-			if (*rhs)
-				return 0;
-		}
-		else if (!strcmp(p, "case")) {
-			if (!rhs || !*rhs)
-				return 0;
-			if (!strcmp(rhs, "lower"))
+
+		token = match_token(p, tokens, args);
+		switch (token) {
+			case Opt_help:
+				return 2;
+			case Opt_uid:
+				*uid = match_int(args);
+				break;
+			case Opt_gid:
+				*gid = match_int(args);
+				break;
+			case Opt_umask:
+				*umask = match_octal(args);
+				break;
+			case Opt_case_lower:
 				*lowercase = 1;
-			else if (!strcmp(rhs, "asis"))
+				break;
+			case Opt_case_asis:
 				*lowercase = 0;
-			else
-				return 0;
-		}
-		else if (!strcmp(p, "conv")) {
-			if (!rhs || !*rhs)
-				return 0;
-			if (!strcmp(rhs, "binary"))
+				break;
+			case Opt_conv_binary:
 				*conv = CONV_BINARY;
-			else if (!strcmp(rhs, "text"))
+				break;
+			case Opt_conv_text:
 				*conv = CONV_TEXT;
-			else if (!strcmp(rhs, "auto"))
+				break;
+			case Opt_conv_auto:
 				*conv = CONV_AUTO;
-			else
-				return 0;
-		}
-		else if (!strcmp(p, "check")) {
-			if (!rhs || !*rhs)
-				return 0;
-			if (!strcmp(rhs, "none"))
+				break;
+			case Opt_check_none:
 				*chk = 0;
-			else if (!strcmp(rhs, "normal"))
+				break;
+			case Opt_check_normal:
 				*chk = 1;
-			else if (!strcmp(rhs, "strict"))
+				break;
+			case Opt_check_strict:
 				*chk = 2;
-			else
-				return 0;
-		}
-		else if (!strcmp(p, "errors")) {
-			if (!rhs || !*rhs)
-				return 0;
-			if (!strcmp(rhs, "continue"))
+				break;
+			case Opt_err_cont:
 				*errs = 0;
-			else if (!strcmp(rhs, "remount-ro"))
+				break;
+			case Opt_err_ro:
 				*errs = 1;
-			else if (!strcmp(rhs, "panic"))
+				break;
+			case Opt_err_panic:
 				*errs = 2;
-			else
-				return 0;
-		}
-		else if (!strcmp(p, "eas")) {
-			if (!rhs || !*rhs)
-				return 0;
-			if (!strcmp(rhs, "no"))
+				break;
+			case Opt_eas_no:
 				*eas = 0;
-			else if (!strcmp(rhs, "ro"))
+				break;
+			case Opt_eas_ro:
 				*eas = 1;
-			else if (!strcmp(rhs, "rw"))
+				break;
+			case Opt_eas_rw:
 				*eas = 2;
-			else
-				return 0;
-		}
-		else if (!strcmp(p, "chkdsk")) {
-			if (!rhs || !*rhs)
-				return 0;
-			if (!strcmp(rhs, "no"))
+				break;
+			case Opt_chkdsk_no:
 				*chkdsk = 0;
-			else if (!strcmp(rhs, "errors"))
+				break;
+			case Opt_chkdsk_errors:
 				*chkdsk = 1;
-			else if (!strcmp(rhs, "always"))
+				break;
+			case Opt_chkdsk_always:
 				*chkdsk = 2;
-			else
+				break;
+			case Opt_timeshift:
+			{
+				int m = 1;
+				char *rhs = args[0].from;
+				if (!rhs || !*rhs)
+					return 0;
+				if (*rhs == '-') m = -1;
+				if (*rhs == '+' || *rhs == '-') rhs++;
+				*timeshift = simple_strtoul(rhs, &rhs, 0) * m;
+				if (*rhs)
+					return 0;
+				break;
+			}
+			default:
 				return 0;
 		}
-		else
-			return 0;
 	}
 	return 1;
 }


--
~Randy
