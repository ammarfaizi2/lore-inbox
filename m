Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262335AbVDXPLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262335AbVDXPLE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 11:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262338AbVDXPLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 11:11:04 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:36760 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262335AbVDXPKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 11:10:17 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] FUSE: remove allow_root mount option
Message-Id: <E1DPijo-0000Ln-00@localhost>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 24 Apr 2005 17:09:36 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the "allow_root" mount option, since it can be done
in userspace.  Based on Jamie Lokier's idea.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

diff -rup linux-2.6.12-rc2-mm3/fs/fuse/dir.c linux-fuse/fs/fuse/dir.c
--- linux-2.6.12-rc2-mm3/fs/fuse/dir.c	2005-04-22 15:37:21.000000000 +0200
+++ linux-fuse/fs/fuse/dir.c	2005-04-22 15:38:04.000000000 +0200
@@ -420,9 +420,7 @@ static int fuse_revalidate(struct dentry
 
 	if (get_node_id(inode) == FUSE_ROOT_ID) {
 		if (!(fc->flags & FUSE_ALLOW_OTHER) &&
-		    current->fsuid != fc->user_id &&
-		    (!(fc->flags & FUSE_ALLOW_ROOT) ||
-		     !capable(CAP_DAC_OVERRIDE)))
+		    current->fsuid != fc->user_id)
 			return -EACCES;
 	} else if (time_before_eq(jiffies, fi->i_time))
 		return 0;
@@ -434,8 +432,7 @@ static int fuse_permission(struct inode 
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
 
-	if (!(fc->flags & FUSE_ALLOW_OTHER) && current->fsuid != fc->user_id &&
-	    (!(fc->flags & FUSE_ALLOW_ROOT) || !capable(CAP_DAC_OVERRIDE)))
+	if (!(fc->flags & FUSE_ALLOW_OTHER) && current->fsuid != fc->user_id)
 		return -EACCES;
 	else if (fc->flags & FUSE_DEFAULT_PERMISSIONS) {
 		int err = generic_permission(inode, mask, NULL);
diff -rup linux-2.6.12-rc2-mm3/fs/fuse/fuse_i.h linux-fuse/fs/fuse/fuse_i.h
--- linux-2.6.12-rc2-mm3/fs/fuse/fuse_i.h	2005-04-22 15:37:21.000000000 +0200
+++ linux-fuse/fs/fuse/fuse_i.h	2005-04-22 15:38:04.000000000 +0200
@@ -37,10 +37,6 @@
 /** Bypass the page cache for read and write operations  */
 #define FUSE_DIRECT_IO           (1 << 3)
 
-/** Allow root and setuid-root programs to access fuse-mounted
-    filesystems */
-#define FUSE_ALLOW_ROOT		 (1 << 4)
-
 /** FUSE inode */
 struct fuse_inode {
 	/** Inode data */
diff -rup linux-2.6.12-rc2-mm3/fs/fuse/inode.c linux-fuse/fs/fuse/inode.c
--- linux-2.6.12-rc2-mm3/fs/fuse/inode.c	2005-04-22 15:37:21.000000000 +0200
+++ linux-fuse/fs/fuse/inode.c	2005-04-22 15:38:04.000000000 +0200
@@ -248,7 +247,6 @@ enum {
 	OPT_USER_ID,
 	OPT_DEFAULT_PERMISSIONS,
 	OPT_ALLOW_OTHER,
-	OPT_ALLOW_ROOT,
 	OPT_KERNEL_CACHE,
 	OPT_DIRECT_IO,
 	OPT_MAX_READ,
@@ -261,7 +259,6 @@ static match_table_t tokens = {
 	{OPT_USER_ID,			"user_id=%u"},
 	{OPT_DEFAULT_PERMISSIONS,	"default_permissions"},
 	{OPT_ALLOW_OTHER,		"allow_other"},
-	{OPT_ALLOW_ROOT,		"allow_root"},
 	{OPT_KERNEL_CACHE,		"kernel_cache"},
 	{OPT_DIRECT_IO,			"direct_io"},
 	{OPT_MAX_READ,			"max_read=%u"},
@@ -310,10 +307,6 @@ static int parse_fuse_opt(char *opt, str
 			d->flags |= FUSE_ALLOW_OTHER;
 			break;
 
-		case OPT_ALLOW_ROOT:
-			d->flags |= FUSE_ALLOW_ROOT;
-			break;
-
 		case OPT_KERNEL_CACHE:
 			d->flags |= FUSE_KERNEL_CACHE;
 			break;
@@ -347,8 +340,6 @@ static int fuse_show_options(struct seq_
 		seq_puts(m, ",default_permissions");
 	if (fc->flags & FUSE_ALLOW_OTHER)
 		seq_puts(m, ",allow_other");
-	if (fc->flags & FUSE_ALLOW_ROOT)
-		seq_puts(m, ",allow_root");
 	if (fc->flags & FUSE_KERNEL_CACHE)
 		seq_puts(m, ",kernel_cache");
 	if (fc->flags & FUSE_DIRECT_IO)
