Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262343AbVDLOQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262343AbVDLOQX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 10:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262336AbVDLLHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 07:07:53 -0400
Received: from fire.osdl.org ([65.172.181.4]:29130 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262255AbVDLKdP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:33:15 -0400
Message-Id: <200504121033.j3CAX6g1005777@shell0.pdx.osdl.net>
Subject: [patch 155/198] IPoIB: convert to debugfs
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, roland@topspin.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:33:00 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Roland Dreier <roland@topspin.com>

Convert IPoIB to use debugfs instead of its own custom debugging filesystem.

Signed-off-by: Roland Dreier <roland@topspin.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/infiniband/ulp/ipoib/ipoib_fs.c   |  140 ++--------------------
 25-akpm/drivers/infiniband/ulp/ipoib/ipoib_main.c |    8 -
 2 files changed, 18 insertions(+), 130 deletions(-)

diff -puN drivers/infiniband/ulp/ipoib/ipoib_fs.c~ipoib-convert-to-debugfs drivers/infiniband/ulp/ipoib/ipoib_fs.c
--- 25/drivers/infiniband/ulp/ipoib/ipoib_fs.c~ipoib-convert-to-debugfs	2005-04-12 03:21:40.674953368 -0700
+++ 25-akpm/drivers/infiniband/ulp/ipoib/ipoib_fs.c	2005-04-12 03:21:40.679952608 -0700
@@ -32,19 +32,16 @@
  * $Id: ipoib_fs.c 1389 2004-12-27 22:56:47Z roland $
  */
 
-#include <linux/pagemap.h>
+#include <linux/err.h>
 #include <linux/seq_file.h>
 
-#include "ipoib.h"
+struct file_operations;
 
-enum {
-	IPOIB_MAGIC = 0x49504942 /* "IPIB" */
-};
+#include <linux/debugfs.h>
+
+#include "ipoib.h"
 
-static DECLARE_MUTEX(ipoib_fs_mutex);
 static struct dentry *ipoib_root;
-static struct super_block *ipoib_sb;
-static LIST_HEAD(ipoib_device_list);
 
 static void *ipoib_mcg_seq_start(struct seq_file *file, loff_t *pos)
 {
@@ -145,143 +142,34 @@ static struct file_operations ipoib_fops
 	.release = seq_release
 };
 
-static struct inode *ipoib_get_inode(void)
-{
-	struct inode *inode = new_inode(ipoib_sb);
-
-	if (inode) {
-		inode->i_mode 	 = S_IFREG | S_IRUGO;
-		inode->i_uid 	 = 0;
-		inode->i_gid 	 = 0;
-		inode->i_blksize = PAGE_CACHE_SIZE;
-		inode->i_blocks  = 0;
-		inode->i_atime 	 = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
-		inode->i_fop     = &ipoib_fops;
-	}
-
-	return inode;
-}
-
-static int __ipoib_create_debug_file(struct net_device *dev)
+int ipoib_create_debug_file(struct net_device *dev)
 {
 	struct ipoib_dev_priv *priv = netdev_priv(dev);
-	struct dentry *dentry;
-	struct inode *inode;
 	char name[IFNAMSIZ + sizeof "_mcg"];
 
 	snprintf(name, sizeof name, "%s_mcg", dev->name);
 
-	dentry = d_alloc_name(ipoib_root, name);
-	if (!dentry)
-		return -ENOMEM;
-
-	inode = ipoib_get_inode();
-	if (!inode) {
-		dput(dentry);
-		return -ENOMEM;
-	}
-
-	inode->u.generic_ip = dev;
-	priv->mcg_dentry = dentry;
-
-	d_add(dentry, inode);
-
-	return 0;
-}
-
-int ipoib_create_debug_file(struct net_device *dev)
-{
-	struct ipoib_dev_priv *priv = netdev_priv(dev);
-
-	down(&ipoib_fs_mutex);
-
-	list_add_tail(&priv->fs_list, &ipoib_device_list);
-
-	if (!ipoib_sb) {
-		up(&ipoib_fs_mutex);
-		return 0;
-	}
-
-	up(&ipoib_fs_mutex);
+	priv->mcg_dentry = debugfs_create_file(name, S_IFREG | S_IRUGO,
+					       ipoib_root, dev, &ipoib_fops);
 
-	return __ipoib_create_debug_file(dev);
+	return priv->mcg_dentry ? 0 : -ENOMEM;
 }
 
 void ipoib_delete_debug_file(struct net_device *dev)
 {
 	struct ipoib_dev_priv *priv = netdev_priv(dev);
 
-	down(&ipoib_fs_mutex);
-	list_del(&priv->fs_list);
-	if (!ipoib_sb) {
-		up(&ipoib_fs_mutex);
-		return;
-	}
-	up(&ipoib_fs_mutex);
-
-	if (priv->mcg_dentry) {
-		d_drop(priv->mcg_dentry);
-		simple_unlink(ipoib_root->d_inode, priv->mcg_dentry);
-	}
-}
-
-static int ipoib_fill_super(struct super_block *sb, void *data, int silent)
-{
-	static struct tree_descr ipoib_files[] = {
-		{ "" }
-	};
-	struct ipoib_dev_priv *priv;
-	int ret;
-
-	ret = simple_fill_super(sb, IPOIB_MAGIC, ipoib_files);
-	if (ret)
-		return ret;
-
-	ipoib_root = sb->s_root;
-
-	down(&ipoib_fs_mutex);
-
-	ipoib_sb = sb;
-
-	list_for_each_entry(priv, &ipoib_device_list, fs_list) {
-		ret = __ipoib_create_debug_file(priv->dev);
-		if (ret)
-			break;
-	}
-
-	up(&ipoib_fs_mutex);
-
-	return ret;
-}
-
-static struct super_block *ipoib_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
-{
-	return get_sb_single(fs_type, flags, data, ipoib_fill_super);
+	if (priv->mcg_dentry)
+		debugfs_remove(priv->mcg_dentry);
 }
 
-static void ipoib_kill_sb(struct super_block *sb)
-{
-	down(&ipoib_fs_mutex);
-	ipoib_sb = NULL;
-	up(&ipoib_fs_mutex);
-
-	kill_litter_super(sb);
-}
-
-static struct file_system_type ipoib_fs_type = {
-	.owner		= THIS_MODULE,
-	.name		= "ipoib_debugfs",
-	.get_sb		= ipoib_get_sb,
-	.kill_sb	= ipoib_kill_sb,
-};
-
 int ipoib_register_debugfs(void)
 {
-	return register_filesystem(&ipoib_fs_type);
+	ipoib_root = debugfs_create_dir("ipoib", NULL);
+	return ipoib_root ? 0 : -ENOMEM;
 }
 
 void ipoib_unregister_debugfs(void)
 {
-	unregister_filesystem(&ipoib_fs_type);
+	debugfs_remove(ipoib_root);
 }
diff -puN drivers/infiniband/ulp/ipoib/ipoib_main.c~ipoib-convert-to-debugfs drivers/infiniband/ulp/ipoib/ipoib_main.c
--- 25/drivers/infiniband/ulp/ipoib/ipoib_main.c~ipoib-convert-to-debugfs	2005-04-12 03:21:40.676953064 -0700
+++ 25-akpm/drivers/infiniband/ulp/ipoib/ipoib_main.c	2005-04-12 03:21:40.680952456 -0700
@@ -1082,19 +1082,19 @@ static int __init ipoib_init_module(void
 
 	return 0;
 
-err_fs:
-	ipoib_unregister_debugfs();
-
 err_wq:
 	destroy_workqueue(ipoib_workqueue);
 
+err_fs:
+	ipoib_unregister_debugfs();
+
 	return ret;
 }
 
 static void __exit ipoib_cleanup_module(void)
 {
-	ipoib_unregister_debugfs();
 	ib_unregister_client(&ipoib_client);
+	ipoib_unregister_debugfs();
 	destroy_workqueue(ipoib_workqueue);
 }
 
_
