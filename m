Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265969AbTIET1n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 15:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265881AbTIETTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 15:19:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:22929 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265763AbTIETKH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 15:10:07 -0400
Date: Fri, 5 Sep 2003 11:57:46 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: fsdev <linux-fsdevel@vger.kernel.org>
Subject: [CFT] [9/15] hfs options parsing
Message-Id: <20030905115746.13434768.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-260-test4-pv/fs/hfs/super.c linux-260-test4-fs/fs/hfs/super.c
--- linux-260-test4-pv/fs/hfs/super.c	2003-08-22 16:54:19.000000000 -0700
+++ linux-260-test4-fs/fs/hfs/super.c	2003-08-27 11:19:07.000000000 -0700
@@ -31,6 +31,7 @@
 #include <linux/blkdev.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/parser.h>
 #include <linux/smp_lock.h>
 #include <linux/vfs.h>
 
@@ -211,6 +212,60 @@ static int hfs_statfs(struct super_block
 	return 0;
 }
 
+enum {
+	Opt_version, Opt_uid, Opt_gid, Opt_umask, Opt_part,
+	Opt_type, Opt_creator, Opt_quiet, Opt_afpd,
+	Opt_names_netatalk, Opt_names_trivial, Opt_names_alpha, Opt_names_latin,
+	Opt_names_7bit, Opt_names_8bit, Opt_names_cap,
+	Opt_fork_netatalk, Opt_fork_single, Opt_fork_double, Opt_fork_cap,
+	Opt_case_lower, Opt_case_asis,
+	Opt_conv_binary, Opt_conv_text, Opt_conv_auto,
+};
+
+static match_table_t tokens = {
+	{Opt_version, "version=%u"},
+	{Opt_uid, "uid=%u"},
+	{Opt_gid, "gid=%u"},
+	{Opt_umask, "umask=%o"},
+	{Opt_part, "part=%u"},
+	{Opt_type, "type=%s"},
+	{Opt_creator, "creator=%s"},
+	{Opt_quiet, "quiet"},
+	{Opt_afpd, "afpd"},
+	{Opt_names_netatalk, "names=netatalk"},
+	{Opt_names_trivial, "names=trivial"},
+	{Opt_names_alpha, "names=alpha"},
+	{Opt_names_latin, "names=latin"},
+	{Opt_names_7bit, "names=7bit"},
+	{Opt_names_8bit, "names=8bit"},
+	{Opt_names_cap, "names=cap"},
+	{Opt_names_netatalk, "names=n"},
+	{Opt_names_trivial, "names=t"},
+	{Opt_names_alpha, "names=a"},
+	{Opt_names_latin, "names=l"},
+	{Opt_names_7bit, "names=7"},
+	{Opt_names_8bit, "names=8"},
+	{Opt_names_cap, "names=c"},
+	{Opt_fork_netatalk, "fork=netatalk"},
+	{Opt_fork_single, "fork=single"},
+	{Opt_fork_double, "fork=double"},
+	{Opt_fork_cap, "fork=cap"},
+	{Opt_fork_netatalk, "fork=n"},
+	{Opt_fork_single, "fork=s"},
+	{Opt_fork_double, "fork=d"},
+	{Opt_fork_cap, "fork=c"},
+	{Opt_case_lower, "case=lower"},
+	{Opt_case_asis, "case=asis"},
+	{Opt_case_lower, "case=l"},
+	{Opt_case_asis, "case=a"},
+	{Opt_conv_binary, "conv=binary"},
+	{Opt_conv_text, "conv=text"},
+	{Opt_conv_auto, "conv=auto"},
+	{Opt_conv_binary, "conv=b"},
+	{Opt_conv_text, "conv=t"},
+	{Opt_conv_auto, "conv=a"},
+};
+
 /*
  * parse_options()
  * 
@@ -219,8 +274,9 @@ static int hfs_statfs(struct super_block
  */
 static int parse_options(char *options, struct hfs_sb_info *hsb, int *part)
 {
-	char *this_char, *value;
+	char *p;
 	char names, fork;
+	substring_t args[MAX_OPT_ARGS];
 
 	/* initialize the sb with defaults */
 	memset(hsb, 0, sizeof(*hsb));
@@ -243,118 +299,100 @@ static int parse_options(char *options, 
 	if (!options) {
 		goto done;
 	}
-	while ((this_char = strsep(&options,",")) != NULL) {
-		if (!*this_char)
+	while ((p = strsep(&options,",")) != NULL) {
+		int token;
+		if (!*p)
 			continue;
-		if ((value = strchr(this_char,'=')) != NULL) {
-			*value++ = 0;
-		}
-	/* Numeric-valued options */
-		if (!strcmp(this_char, "version")) {
-			if (!value || !*value) {
-				return 0;
-			}
-			hsb->s_version = simple_strtoul(value,&value,0);
-			if (*value) {
-				return 0;
-			}
-		} else if (!strcmp(this_char,"uid")) {
-			if (!value || !*value) {
-				return 0;
-			}
-			hsb->s_uid = simple_strtoul(value,&value,0);
-			if (*value) {
-				return 0;
-			}
-		} else if (!strcmp(this_char,"gid")) {
-			if (!value || !*value) {
-				return 0;
-			}
-			hsb->s_gid = simple_strtoul(value,&value,0);
-			if (*value) {
-				return 0;
-			}
-		} else if (!strcmp(this_char,"umask")) {
-			if (!value || !*value) {
-				return 0;
-			}
-			hsb->s_umask = simple_strtoul(value,&value,8);
-			if (*value) {
-				return 0;
-			}
-		} else if (!strcmp(this_char,"part")) {
-			if (!value || !*value) {
-				return 0;
-			}
-			*part = simple_strtoul(value,&value,0);
-			if (*value) {
-				return 0;
-			}
-	/* String-valued options */
-		} else if (!strcmp(this_char,"type") && value) {
-			if (strlen(value) != 4) {
-				return 0;
-			}
-			hsb->s_type = hfs_get_nl(value);
-		} else if (!strcmp(this_char,"creator") && value) {
-			if (strlen(value) != 4) {
-				return 0;
-			}
-			hsb->s_creator = hfs_get_nl(value);
-	/* Boolean-valued options */
-		} else if (!strcmp(this_char,"quiet")) {
-			if (value) {
-				return 0;
-			}
-			hsb->s_quiet = 1;
-		} else if (!strcmp(this_char,"afpd")) {
-			if (value) {
-				return 0;
-			}
-			hsb->s_afpd = 1;
-	/* Multiple choice options */
-		} else if (!strcmp(this_char,"names") && value) {
-			if ((*value && !value[1] && strchr("ntal78c",*value)) ||
-			    !strcmp(value,"netatalk") ||
-			    !strcmp(value,"trivial") ||
-			    !strcmp(value,"alpha") ||
-			    !strcmp(value,"latin") ||
-			    !strcmp(value,"7bit") ||
-			    !strcmp(value,"8bit") ||
-			    !strcmp(value,"cap")) {
-				names = *value;
-			} else {
-				return 0;
-			}
-		} else if (!strcmp(this_char,"fork") && value) {
-			if ((*value && !value[1] && strchr("nsdc",*value)) ||
-			    !strcmp(value,"netatalk") ||
-			    !strcmp(value,"single") ||
-			    !strcmp(value,"double") ||
-			    !strcmp(value,"cap")) {
-				fork = *value;
-			} else {
-				return 0;
-			}
-		} else if (!strcmp(this_char,"case") && value) {
-			if ((*value && !value[1] && strchr("la",*value)) ||
-			    !strcmp(value,"lower") ||
-			    !strcmp(value,"asis")) {
-				hsb->s_lowercase = (*value == 'l');
-			} else {
-				return 0;
-			}
-		} else if (!strcmp(this_char,"conv") && value) {
-			if ((*value && !value[1] && strchr("bta",*value)) ||
-			    !strcmp(value,"binary") ||
-			    !strcmp(value,"text") ||
-			    !strcmp(value,"auto")) {
-				hsb->s_conv = *value;
-			} else {
+
+		token = match_token(p, tokens, args);
+		switch (token) {
+			/* Numeric-valued options */
+			case Opt_version:
+				hsb->s_version = match_int(&args[0]);
+				break;
+			case Opt_uid:
+				hsb->s_uid = match_int(&args[0]);
+				break;
+			case Opt_gid:
+				hsb->s_gid = match_int(&args[0]);
+				break;
+			case Opt_umask:
+				hsb->s_umask = match_octal(&args[0]);
+				break;
+			case Opt_part:
+				*part = match_int(&args[0]);
+				break;
+			/* String-valued options */
+			case Opt_type:
+				if (strlen(args[0].from) != 4) {
+					return 0;
+				}
+				hsb->s_type = hfs_get_nl(args[0].from);
+				break;
+			case Opt_creator:
+				if (strlen(args[0].from) != 4) {
+					return 0;
+				}
+				hsb->s_creator = hfs_get_nl(args[0].from);
+				break;
+			/* Boolean-valued options */
+			case Opt_quiet:
+				hsb->s_quiet = 1;
+				break;
+			case Opt_afpd:
+				hsb->s_afpd = 1;
+				break;
+			/* Multiple choice options */
+			case Opt_names_netatalk: 
+				names = 'n';
+				break;
+			case Opt_names_trivial: 
+				names = 't';
+				break;
+			case Opt_names_alpha: 
+				names = 'a';
+				break;
+			case Opt_names_latin: 
+				names = 'l';
+				break;
+			case Opt_names_7bit: 
+				names = '7';
+				break;
+			case Opt_names_8bit: 
+				names = '8';
+				break;
+			case Opt_names_cap: 
+				names = 'c';
+				break;
+			case Opt_fork_netatalk:
+				fork = 'n';
+				break;
+			case Opt_fork_single:
+				fork = 's';
+				break;
+			case Opt_fork_double:
+				fork = 'd';
+				break;
+			case Opt_fork_cap:
+				fork = 'c';
+				break;
+			case Opt_case_lower:
+				hsb->s_lowercase = 1;
+				break;
+			case Opt_case_asis:
+				hsb->s_lowercase = 0;
+				break;
+			case Opt_conv_binary:
+				hsb->s_conv = 'b';
+				break;
+			case Opt_conv_text:
+				hsb->s_conv = 't';
+				break;
+			case Opt_conv_auto:
+				hsb->s_conv = 'a';
+				break;
+			default:
 				return 0;
-			}
-		} else {
-			return 0;
 		}
 	}
 


--
~Randy
