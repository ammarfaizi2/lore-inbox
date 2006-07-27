Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161055AbWG0NDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161055AbWG0NDW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 09:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161030AbWG0NDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 09:03:21 -0400
Received: from mail-gw1.sa.eol.hu ([212.108.200.67]:22222 "EHLO
	mail-gw1.sa.eol.hu") by vger.kernel.org with ESMTP id S1161027AbWG0NDV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 09:03:21 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk
In-reply-to: <E1G65Ok-0002fh-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Thu, 27 Jul 2006 14:55:30 +0200)
Subject: [PATCH 5/5] vfs: define new lookup flag for chdir
References: <E1G65Ok-0002fh-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1G65Vu-0002jG-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 27 Jul 2006 15:02:54 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the "operation does permission checking" model used by fuse, chdir
permission is not checked, since there's no chdir method.

For this case set a lookup flag, which will be passed to
->permission(), so fuse can distinguish it from permission checks for
other operations.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
---

Index: linux/fs/fuse/dir.c
===================================================================
--- linux.orig/fs/fuse/dir.c	2006-07-27 14:38:04.000000000 +0200
+++ linux/fs/fuse/dir.c	2006-07-27 14:38:15.000000000 +0200
@@ -776,7 +776,7 @@ static int fuse_permission(struct inode 
 		if ((mask & MAY_EXEC) && !S_ISDIR(mode) && !(mode & S_IXUGO))
 			return -EACCES;
 
-		if (nd && (nd->flags & LOOKUP_ACCESS))
+		if (nd && (nd->flags & (LOOKUP_ACCESS | LOOKUP_CHDIR)))
 			return fuse_access(inode, mask);
 		return 0;
 	}
Index: linux/fs/open.c
===================================================================
--- linux.orig/fs/open.c	2006-07-27 14:35:14.000000000 +0200
+++ linux/fs/open.c	2006-07-27 14:38:15.000000000 +0200
@@ -546,7 +546,8 @@ asmlinkage long sys_chdir(const char __u
 	struct nameidata nd;
 	int error;
 
-	error = __user_walk(filename, LOOKUP_FOLLOW|LOOKUP_DIRECTORY, &nd);
+	error = __user_walk(filename,
+			    LOOKUP_FOLLOW|LOOKUP_DIRECTORY|LOOKUP_CHDIR, &nd);
 	if (error)
 		goto out;
 
Index: linux/include/linux/namei.h
===================================================================
--- linux.orig/include/linux/namei.h	2006-07-27 14:35:14.000000000 +0200
+++ linux/include/linux/namei.h	2006-07-27 14:38:15.000000000 +0200
@@ -54,6 +54,7 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LA
 #define LOOKUP_OPEN		(0x0100)
 #define LOOKUP_CREATE		(0x0200)
 #define LOOKUP_ACCESS		(0x0400)
+#define LOOKUP_CHDIR		(0x0800)
 
 extern int FASTCALL(__user_walk(const char __user *, unsigned, struct nameidata *));
 extern int FASTCALL(__user_walk_fd(int dfd, const char __user *, unsigned, struct nameidata *));
