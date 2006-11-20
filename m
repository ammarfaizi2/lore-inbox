Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965463AbWKTKDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965463AbWKTKDu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 05:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965464AbWKTKDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 05:03:50 -0500
Received: from mail-gw2.sa.eol.hu ([212.108.200.109]:65248 "EHLO
	mail-gw2.sa.eol.hu") by vger.kernel.org with ESMTP id S965419AbWKTKDs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 05:03:48 -0500
To: akpm@osdl.org
CC: randy.dunlap@oracle.com, linux-kernel@vger.kernel.org
Subject: [patch] fuse: fix compile without CONFIG_BLOCK
Message-Id: <E1Gm5zn-0002tV-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 20 Nov 2006 11:03:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Randy.

Andrew, can you please add this patch in place of
fuse-depends-on-block.patch?

Thanks,
Miklos
----

Randy Dunlap wote:
> Should FUSE depend on BLOCK?  Without that and with BLOCK=n, I get:
> 
> inode.c:(.text+0x3acc5): undefined reference to `sb_set_blocksize'
> inode.c:(.text+0x3a393): undefined reference to `get_sb_bdev'
> fs/built-in.o:(.data+0xd718): undefined reference to `kill_block_super

Most fuse filesystems work fine without block device support, so I
think a better solution is to disable the 'fuseblk' filesystem type if
BLOCK=n.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
CC: Randy Dunlap <randy.dunlap@oracle.com>

---
Index: linux/fs/fuse/inode.c
===================================================================
--- linux.orig/fs/fuse/inode.c	2006-11-19 21:09:19.000000000 +0100
+++ linux/fs/fuse/inode.c	2006-11-19 23:12:03.000000000 +0100
@@ -535,8 +535,10 @@ static int fuse_fill_super(struct super_
 		return -EINVAL;
 
 	if (is_bdev) {
+#ifdef CONFIG_BLOCK
 		if (!sb_set_blocksize(sb, d.blksize))
 			return -EINVAL;
+#endif
 	} else {
 		sb->s_blocksize = PAGE_CACHE_SIZE;
 		sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
@@ -629,6 +631,14 @@ static int fuse_get_sb(struct file_syste
 	return get_sb_nodev(fs_type, flags, raw_data, fuse_fill_super, mnt);
 }
 
+static struct file_system_type fuse_fs_type = {
+	.owner		= THIS_MODULE,
+	.name		= "fuse",
+	.get_sb		= fuse_get_sb,
+	.kill_sb	= kill_anon_super,
+};
+
+#ifdef CONFIG_BLOCK
 static int fuse_get_sb_blk(struct file_system_type *fs_type,
 			   int flags, const char *dev_name,
 			   void *raw_data, struct vfsmount *mnt)
@@ -637,13 +647,6 @@ static int fuse_get_sb_blk(struct file_s
 			   mnt);
 }
 
-static struct file_system_type fuse_fs_type = {
-	.owner		= THIS_MODULE,
-	.name		= "fuse",
-	.get_sb		= fuse_get_sb,
-	.kill_sb	= kill_anon_super,
-};
-
 static struct file_system_type fuseblk_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "fuseblk",
@@ -652,6 +655,26 @@ static struct file_system_type fuseblk_f
 	.fs_flags	= FS_REQUIRES_DEV,
 };
 
+static inline int register_fuseblk(void)
+{
+	return register_filesystem(&fuseblk_fs_type);
+}
+
+static inline void unregister_fuseblk(void)
+{
+	unregister_filesystem(&fuseblk_fs_type);
+}
+#else
+static inline int register_fuseblk(void)
+{
+	return 0;
+}
+
+static inline void unregister_fuseblk(void)
+{
+}
+#endif
+
 static decl_subsys(fuse, NULL, NULL);
 static decl_subsys(connections, NULL, NULL);
 
@@ -673,7 +696,7 @@ static int __init fuse_fs_init(void)
 	if (err)
 		goto out;
 
-	err = register_filesystem(&fuseblk_fs_type);
+	err = register_fuseblk();
 	if (err)
 		goto out_unreg;
 
@@ -688,7 +711,7 @@ static int __init fuse_fs_init(void)
 	return 0;
 
  out_unreg2:
-	unregister_filesystem(&fuseblk_fs_type);
+	unregister_fuseblk();
  out_unreg:
 	unregister_filesystem(&fuse_fs_type);
  out:
@@ -698,7 +721,7 @@ static int __init fuse_fs_init(void)
 static void fuse_fs_cleanup(void)
 {
 	unregister_filesystem(&fuse_fs_type);
-	unregister_filesystem(&fuseblk_fs_type);
+	unregister_fuseblk();
 	kmem_cache_destroy(fuse_inode_cachep);
 }
 
