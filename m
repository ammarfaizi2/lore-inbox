Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbWAUOEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWAUOEj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 09:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWAUOEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 09:04:39 -0500
Received: from uproxy.gmail.com ([66.249.92.199]:46509 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750755AbWAUOEi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 09:04:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=gJ1fPYw9EjgAZ6+11LJFbUaCZR/1Iqy+ej/UsxM9etKkEFbgoK6Oij6ZLqolOB/wzKppVNX3MG9/s9TbEBwObxjesskAeFgFD9OEdnRmm5PgqxRh2m2X3yHkj6uKUSLRYKXSiWRSXbtL3KrBDht4medSaBIG/AnQxOLrMhDHJl8=
Date: Sat, 21 Jan 2006 17:21:54 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] devpts: use lib/parser.c for parsing mount options
Message-ID: <20060121142154.GA19692@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Domen Puncer <domen@coderock.org>

Item from "2.6 should fix" list.

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/devpts/inode.c |   76 ++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 49 insertions(+), 27 deletions(-)

--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -18,6 +18,7 @@
 #include <linux/mount.h>
 #include <linux/tty.h>
 #include <linux/devpts_fs.h>
+#include <linux/parser.h>
 
 #define DEVPTS_SUPER_MAGIC 0x1cd1
 
@@ -32,39 +33,60 @@ static struct {
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

