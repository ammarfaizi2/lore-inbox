Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbUJ3Wam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbUJ3Wam (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 18:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbUJ3W3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 18:29:46 -0400
Received: from baikonur.stro.at ([213.239.196.228]:42210 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261360AbUJ3W3L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 18:29:11 -0400
Subject: [patch 2/2]  fs/devpts: use lib/parser
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, domen@coderock.org
From: janitor@sternwelten.at
Date: Sun, 31 Oct 2004 00:29:04 +0200
Message-ID: <E1CO1ia-0001N5-L0@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Hi.

Use lib/parser.c for parsing mount options (item from "2.6 should fix").
 1 files changed, 49 insertions(+), 27 deletions(-)

Compile & boot tested.

Signed-off-by: Domen Puncer <domen@coderock.org>

---

 linux-2.6.10-rc1-max/fs/devpts/inode.c |   76 +++++++++++++++++++++------------
 1 files changed, 49 insertions(+), 27 deletions(-)

diff -puN fs/devpts/inode.c~lib-parser-fs_devpts_inode fs/devpts/inode.c
--- linux-2.6.10-rc1/fs/devpts/inode.c~lib-parser-fs_devpts_inode	2004-10-24 17:06:16.000000000 +0200
+++ linux-2.6.10-rc1-max/fs/devpts/inode.c	2004-10-24 17:06:16.000000000 +0200
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
