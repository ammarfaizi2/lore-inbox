Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261976AbVANMxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbVANMxE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 07:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261980AbVANMxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 07:53:04 -0500
Received: from adsl-298.mirage.euroweb.hu ([193.226.239.42]:24461 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261976AbVANMw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 07:52:26 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] FUSE - remove mount_max and user_allow_other module parameters
Message-Id: <E1CpQvu-0000WV-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 14 Jan 2005 13:52:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This patch removes checks for zero uid (spotted by you).  These cannot
be replaced with checking for capable(CAP_SYS_ADMIN), since for mount
this capability will always be set.  Better aproach seems to be to
move the checks to fusermount (the mount utility provided with the
FUSE library).

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
diff -rup linux-2.6.11-rc1-mm1/fs/fuse/inode.c linux-2.6.11-rc1-mm1-fuse/fs/fuse/inode.c
--- linux-2.6.11-rc1-mm1/fs/fuse/inode.c	2005-01-14 12:30:07.000000000 +0100
+++ linux-2.6.11-rc1-mm1-fuse/fs/fuse/inode.c	2005-01-14 12:44:36.000000000 +0100
@@ -15,7 +15,6 @@
 #include <linux/seq_file.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/moduleparam.h>
 #include <linux/parser.h>
 #include <linux/statfs.h>
 
@@ -25,15 +24,6 @@ MODULE_LICENSE("GPL");
 
 spinlock_t fuse_lock;
 static kmem_cache_t *fuse_inode_cachep;
-static int mount_count;
-
-static int user_allow_other;
-module_param(user_allow_other, int, 0644);
-MODULE_PARM_DESC(user_allow_other, "Allow non root user to specify the \"allow_other\" or \"allow_root\" mount options");
-
-static int mount_max = 1000;
-module_param(mount_max, int, 0644);
-MODULE_PARM_DESC(mount_max, "Maximum number of FUSE mounts allowed, if -1 then unlimited (default: 1000)");
 
 #define FUSE_SUPER_MAGIC 0x65735546
 
@@ -199,7 +189,6 @@ static void fuse_put_super(struct super_
 	struct fuse_conn *fc = get_fuse_conn_super(sb);
 
 	spin_lock(&fuse_lock);
-	mount_count --;
 	fc->sb = NULL;
 	fc->user_id = 0;
 	fc->flags = 0;
@@ -512,17 +501,6 @@ static struct super_operations fuse_supe
 	.show_options	= fuse_show_options,
 };
 
-static int inc_mount_count(void)
-{
-	int success = 0;
-	spin_lock(&fuse_lock);
-	mount_count ++;
-	if (mount_max == -1 || mount_count <= mount_max)
-		success = 1;
-	spin_unlock(&fuse_lock);
-	return success;
-}
-
 static int fuse_fill_super(struct super_block *sb, void *data, int silent)
 {
 	struct fuse_conn *fc;
@@ -534,11 +512,6 @@ static int fuse_fill_super(struct super_
 	if (!parse_fuse_opt((char *) data, &d))
 		return -EINVAL;
 
-	if (!user_allow_other &&
-	    (d.flags & (FUSE_ALLOW_OTHER | FUSE_ALLOW_ROOT)) &&
-	    current->uid != 0)
-		return -EPERM;
-
 	sb->s_blocksize = PAGE_CACHE_SIZE;
 	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
 	sb->s_magic = FUSE_SUPER_MAGIC;
@@ -564,10 +537,6 @@ static int fuse_fill_super(struct super_
 
 	*get_fuse_conn_super_p(sb) = fc;
 
-	err = -ENFILE;
-	if (!inc_mount_count() && current->uid != 0)
-		goto err;
-
 	err = -ENOMEM;
 	root = get_root_inode(sb, d.rootmode);
 	if (root == NULL)
@@ -583,7 +552,6 @@ static int fuse_fill_super(struct super_
 
  err:
 	spin_lock(&fuse_lock);
-	mount_count --;
 	fc->sb = NULL;
 	fuse_release_conn(fc);
 	spin_unlock(&fuse_lock);

