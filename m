Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265832AbTIETOx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 15:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265780AbTIETOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 15:14:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:19857 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265784AbTIETKH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 15:10:07 -0400
Date: Fri, 5 Sep 2003 11:54:50 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: fsdev <linux-fsdevel@vger.kernel.org>
Subject: [CFT] [4/15] autofs options parsing
Message-Id: <20030905115450.08fc5d9f.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-260-test4-pv/fs/autofs/inode.c linux-260-test4-fs/fs/autofs/inode.c
--- linux-260-test4-pv/fs/autofs/inode.c	2003-08-22 16:58:11.000000000 -0700
+++ linux-260-test4-fs/fs/autofs/inode.c	2003-08-27 11:19:07.000000000 -0700
@@ -14,6 +14,7 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/file.h>
+#include <linux/parser.h>
 #include <asm/bitops.h>
 #include "autofs_i.h"
 #include <linux/module.h>
@@ -45,9 +46,22 @@ static struct super_operations autofs_so
 	.statfs		= simple_statfs,
 };
 
+enum {Opt_err, Opt_fd, Opt_uid, Opt_gid, Opt_pgrp, Opt_minproto, Opt_maxproto};
+
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
@@ -57,55 +71,37 @@ static int parse_options(char *options, 
 
 	*pipefd = -1;
 
-	if ( !options ) return 1;
-	while ((this_char = strsep(&options,",")) != NULL) {
-		if (!*this_char)
+	if (!options)
+		return 1;
+
+	while ((p = strsep(&options, ",")) != NULL) {
+		int token;
+		if (!*p)
 			continue;
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
+
+		token = match_token(p, autofs_tokens, args);
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


--
~Randy
