Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263096AbUKTCzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263096AbUKTCzW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 21:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263092AbUKTCtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 21:49:45 -0500
Received: from baikonur.stro.at ([213.239.196.228]:53993 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S263089AbUKTCrC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 21:47:02 -0500
Subject: [patch 3/4]  fs/devpts: use lib/parser
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, domen@coderock.org
From: janitor@sternwelten.at
Date: Sat, 20 Nov 2004 03:47:00 +0100
Message-ID: <E1CVLHA-0002UM-Vv@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Hi.

Use lib/parser.c for parsing mount options (item from "2.6 should fix").
 1 files changed, 49 insertions(+), 27 deletions(-)

Compile & boot tested.

Signed-off-by: Domen Puncer <domen@coderock.org>

---

 linux-2.6.10-rc2-bk4-max/fs/devpts/inode.c |   76 ++++++++++++++++++-----------
 1 files changed, 49 insertions(+), 27 deletions(-)

diff -puN fs/devpts/inode.c~lib-parser-fs_devpts_inode fs/devpts/inode.c
--- linux-2.6.10-rc2-bk4/fs/devpts/inode.c~lib-parser-fs_devpts_inode	2004-11-20 00:29:49.000000000 +0100
+++ linux-2.6.10-rc2-bk4-max/fs/devpts/inode.c	2004-11-20 00:29:49.000000000 +0100
@@ -19,6 +19,7 @@
 #include <linux/tty.h>
 #include <linux/devpts_fs.h>
 #include <linux/xattr.h>
+#include <linux/parser.h>
 
 #define DEVPTS_SUPER_MAGIC 0x1cd1
 
@@ -51,39 +52,60 @@ static struct {
 	umode_t mode;
 } config = {.mode = 0600};
 
+enum {
+	Opt_uid, Opt_gid, Opt_mode,
+	Opt_err
+};
+
+static match_table_t tokens = {
+	{Opt_uid, "uid=%u"},
+	{Opt_gid, "gid=%u"},
+	{Opt_mode, "mode=%o"},
+	{Opt_err, NULL}
+};
+
 static int devpts_remount(struct super_block *sb, int *flags, char *data)
 {
-	int setuid = 0;
-	int setgid = 0;
-	uid_t uid = 0;
-	gid_t gid = 0;
-	umode_t mode = 0600;
-	char *this_char;
-
-	this_char = NULL;
-	while ((this_char = strsep(&data, ",")) != NULL) {
-		int n;
-		char dummy;
-		if (!*this_char)
+	char *p;
+
+	config.setuid  = 0;
+	config.setgid  = 0;
+	config.uid     = 0;
+	config.gid     = 0;
+	config.mode    = 0600;
+
+	while ((p = strsep(&data, ",")) != NULL) {
+		substring_t args[MAX_OPT_ARGS];
+		int token;
+		int option;
+
+		if (!*p)
 			continue;
-		if (sscanf(this_char, "uid=%i%c", &n, &dummy) == 1) {
-			setuid = 1;
-			uid = n;
-		} else if (sscanf(this_char, "gid=%i%c", &n, &dummy) == 1) {
-			setgid = 1;
-			gid = n;
-		} else if (sscanf(this_char, "mode=%o%c", &n, &dummy) == 1)
-			mode = n & ~S_IFMT;
-		else {
-			printk("devpts: called with bogus options\n");
+
+		token = match_token(p, tokens, args);
+		switch (token) {
+		case Opt_uid:
+			if (match_int(&args[0], &option))
+				return -EINVAL;
+			config.uid = option;
+			config.setuid = 1;
+			break;
+		case Opt_gid:
+			if (match_int(&args[0], &option))
+				return -EINVAL;
+			config.gid = option;
+			config.setgid = 1;
+			break;
+		case Opt_mode:
+			if (match_octal(&args[0], &option))
+				return -EINVAL;
+			config.mode = option & ~S_IFMT;
+			break;
+		default:
+			printk(KERN_ERR "devpts: called with bogus options\n");
 			return -EINVAL;
 		}
 	}
-	config.setuid  = setuid;
-	config.setgid  = setgid;
-	config.uid     = uid;
-	config.gid     = gid;
-	config.mode    = mode;
 
 	return 0;
 }
_
