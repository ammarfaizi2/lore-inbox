Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262425AbVAJSwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbVAJSwn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 13:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262402AbVAJSuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 13:50:16 -0500
Received: from coderock.org ([193.77.147.115]:55228 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262428AbVAJSpm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 13:45:42 -0500
Subject: [patch 4/5] fs/devpts: use lib/parser
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org, domen@coderock.org
From: domen@coderock.org
Date: Mon, 10 Jan 2005 19:45:33 +0100
Message-Id: <20050110184534.5E2721F206@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Hi.

Use lib/parser.c for parsing mount options (item from "2.6 should fix").
 1 files changed, 49 insertions(+), 27 deletions(-)

Compile & boot tested.

Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/fs/devpts/inode.c |   76 +++++++++++++++++++++++++++++----------------
 1 files changed, 49 insertions(+), 27 deletions(-)

diff -puN fs/devpts/inode.c~lib-parser-fs_devpts_inode fs/devpts/inode.c
--- kj/fs/devpts/inode.c~lib-parser-fs_devpts_inode	2005-01-10 18:00:22.000000000 +0100
+++ kj-domen/fs/devpts/inode.c	2005-01-10 18:00:22.000000000 +0100
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
