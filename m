Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261908AbVGUWHO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261908AbVGUWHO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 18:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261902AbVGUWHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 18:07:14 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:14859 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261909AbVGUWHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 18:07:07 -0400
Date: Fri, 22 Jul 2005 00:07:01 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Marek Szyprowski <march@staszic.waw.pl>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] fs/asfs/: make code static
Message-ID: <20050721220701.GI3160@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/asfs/asfs_fs.h |   12 ------------
 fs/asfs/extents.c |    4 +++-
 fs/asfs/inode.c   |   29 ++++++++++++++++++++++-------
 fs/asfs/objects.c |    4 +++-
 fs/asfs/super.c   |   18 +++++++++++++-----
 5 files changed, 41 insertions(+), 26 deletions(-)

--- linux-2.6.13-rc3-mm1-full/fs/asfs/extents.c.old	2005-07-21 23:04:26.000000000 +0200
+++ linux-2.6.13-rc3-mm1-full/fs/asfs/extents.c	2005-07-21 23:04:45.000000000 +0200
@@ -271,7 +271,9 @@
 
 /* Returns created extentbnode - returned_bh need to saved and realesed in caller funkction! */
 
-int createextentbnode(struct super_block *sb, u32 key, struct buffer_head **returned_bh, struct BNode **returned_bnode)
+static int createextentbnode(struct super_block *sb, u32 key,
+			     struct buffer_head **returned_bh,
+			     struct BNode **returned_bnode)
 {
 	int errorcode;
 
--- linux-2.6.13-rc3-mm1-full/fs/asfs/asfs_fs.h.old	2005-07-21 23:06:11.000000000 +0200
+++ linux-2.6.13-rc3-mm1-full/fs/asfs/asfs_fs.h	2005-07-21 23:10:22.000000000 +0200
@@ -174,13 +174,6 @@
 /* inode.c */
 struct inode *asfs_get_root_inode(struct super_block *sb);
 void asfs_read_locked_inode(struct inode *inode, void *arg);
-int asfs_create(struct inode *dir, struct dentry *dentry, int mode, struct nameidata *nd);
-int asfs_mkdir(struct inode *dir, struct dentry *dentry, int mode);
-int asfs_symlink(struct inode *dir, struct dentry *dentry, const char *symname);
-int asfs_rmdir(struct inode *dir, struct dentry *dentry);
-int asfs_unlink(struct inode *dir, struct dentry *dentry);
-int asfs_rename(struct inode *old_dir, struct dentry *old_dentry,
-		struct inode *new_dir, struct dentry *new_dentry);
 int asfs_notify_change(struct dentry *dentry, struct iattr *attr);
 
 /* namei */
@@ -221,11 +214,6 @@
 /* super.c */
 struct super_block *asfs_read_super(struct super_block *sb, void *data,
 				    int silent);
-void asfs_put_super(struct super_block *sb);
-int asfs_statfs(struct super_block *sb, struct kstatfs *buf);
-int asfs_remount(struct super_block *sb, int *flags, char *data);
-struct inode *asfs_alloc_inode(struct super_block *sb);
-void asfs_destroy_inode(struct inode *inode);
 
 /* symlink.c */
 int asfs_symlink_readpage(struct file *file, struct page *page);
--- linux-2.6.13-rc3-mm1-full/fs/asfs/inode.c.old	2005-07-21 23:05:25.000000000 +0200
+++ linux-2.6.13-rc3-mm1-full/fs/asfs/inode.c	2005-07-21 23:22:36.000000000 +0200
@@ -26,6 +26,18 @@
 
 #include <asm/byteorder.h>
 
+#ifdef CONFIG_ASFS_RW
+static int asfs_create(struct inode *dir, struct dentry *dentry,
+		       int mode, struct nameidata *nd);
+static int asfs_mkdir(struct inode *dir, struct dentry *dentry, int mode);
+static int asfs_symlink(struct inode *dir, struct dentry *dentry,
+			const char *symname);
+static int asfs_unlink(struct inode *dir, struct dentry *dentry);
+static int asfs_rmdir(struct inode *dir, struct dentry *dentry);
+static int asfs_rename(struct inode *old_dir, struct dentry *old_dentry,
+		       struct inode *new_dir, struct dentry *new_dentry);
+#endif /*  CONFIG_ASFS_RW  */
+
 /* Mapping from our types to the kernel */
 
 static struct address_space_operations asfs_aops = {
@@ -277,22 +289,24 @@
 	return error;
 }
 
-int asfs_create(struct inode *dir, struct dentry *dentry, int mode, struct nameidata *nd)
+static int asfs_create(struct inode *dir, struct dentry *dentry,
+		       int mode, struct nameidata *nd)
 {
 	return asfs_create_object(dir, dentry, mode, it_file, NULL);
 }
 
-int asfs_mkdir(struct inode *dir, struct dentry *dentry, int mode)
+static int asfs_mkdir(struct inode *dir, struct dentry *dentry, int mode)
 {
 	return asfs_create_object(dir, dentry, mode, it_dir, NULL);
 }
 
-int asfs_symlink(struct inode *dir, struct dentry *dentry, const char *symname)
+static int asfs_symlink(struct inode *dir, struct dentry *dentry,
+			const char *symname)
 {
 	return asfs_create_object(dir, dentry, 0, it_link, symname);
 }
 
-int asfs_rmdir(struct inode *dir, struct dentry *dentry)
+static int asfs_rmdir(struct inode *dir, struct dentry *dentry)
 {
 	asfs_debug("ASFS: %s\n", __FUNCTION__);
 
@@ -302,7 +316,7 @@
 	return asfs_unlink(dir, dentry);
 }
 
-int asfs_unlink(struct inode *dir, struct dentry *dentry)
+static int asfs_unlink(struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode = dentry->d_inode;
 	int error;
@@ -341,7 +355,8 @@
 	return 0;
 }
 
-int asfs_rename(struct inode *old_dir, struct dentry *old_dentry, struct inode *new_dir, struct dentry *new_dentry)
+static int asfs_rename(struct inode *old_dir, struct dentry *old_dentry,
+		       struct inode *new_dir, struct dentry *new_dentry)
 {
 	struct super_block *sb = old_dir->i_sb;
 	struct buffer_head *src_bh, *old_bh, *new_bh;
@@ -411,7 +426,7 @@
 }
 
 /*
-int asfs_notify_change(struct dentry *dentry, struct iattr *attr)
+static int asfs_notify_change(struct dentry *dentry, struct iattr *attr)
 {
 	struct inode *inode = dentry->d_inode;
 	int error = 0;
--- linux-2.6.13-rc3-mm1-full/fs/asfs/objects.c.old	2005-07-21 23:08:23.000000000 +0200
+++ linux-2.6.13-rc3-mm1-full/fs/asfs/objects.c	2005-07-21 23:08:42.000000000 +0200
@@ -54,7 +54,9 @@
 
 #ifdef CONFIG_ASFS_RW
 
-struct fsObject *find_obj_by_node(struct super_block *sb, struct fsObjectContainer *objcont, u32 objnode)
+static struct fsObject *find_obj_by_node(struct super_block *sb,
+					 struct fsObjectContainer *objcont,
+					 u32 objnode)
 {
 	struct fsObject *obj;
 
--- linux-2.6.13-rc3-mm1-full/fs/asfs/super.c.old	2005-07-21 23:09:09.000000000 +0200
+++ linux-2.6.13-rc3-mm1-full/fs/asfs/super.c	2005-07-21 23:22:52.000000000 +0200
@@ -67,6 +67,14 @@
 static char asfs_default_codepage[] = CONFIG_ASFS_DEFAULT_CODEPAGE;
 static char asfs_default_iocharset[] = CONFIG_NLS_DEFAULT;
 
+static struct inode *asfs_alloc_inode(struct super_block *sb);
+static void asfs_destroy_inode(struct inode *inode);
+static void asfs_put_super(struct super_block *sb);
+static int asfs_statfs(struct super_block *sb, struct kstatfs *buf);
+#ifdef CONFIG_ASFS_RW
+static int asfs_remount(struct super_block *sb, int *flags, char *data);
+#endif
+
 u32 asfs_calcchecksum(void *block, u32 blocksize)
 {
 	u32 *data = block, checksum = 1;
@@ -340,7 +348,7 @@
 }
 
 #ifdef CONFIG_ASFS_RW
-int asfs_remount(struct super_block *sb, int *flags, char *data)
+static int asfs_remount(struct super_block *sb, int *flags, char *data)
 {
 	asfs_debug("ASFS: remount (flags=0x%x, opts=\"%s\")\n",*flags,data);
 
@@ -362,7 +370,7 @@
 }
 #endif
 
-void asfs_put_super(struct super_block *sb)
+static void asfs_put_super(struct super_block *sb)
 {
 	struct asfs_sb_info *sbi = ASFS_SB(sb);
 
@@ -385,7 +393,7 @@
 }
 
 /* That's simple too. */
-int asfs_statfs(struct super_block *sb, struct kstatfs *buf)
+static int asfs_statfs(struct super_block *sb, struct kstatfs *buf)
 {
 	buf->f_type = ASFS_MAGIC;
 	buf->f_bsize = sb->s_blocksize;
@@ -398,7 +406,7 @@
 /* --- new in 2.6.x --- */
 static kmem_cache_t * asfs_inode_cachep;
 
-struct inode *asfs_alloc_inode(struct super_block *sb)
+static struct inode *asfs_alloc_inode(struct super_block *sb)
 {
 	struct asfs_inode_info *ei;
 	ei = (struct asfs_inode_info *)kmem_cache_alloc(asfs_inode_cachep, SLAB_KERNEL);
@@ -407,7 +415,7 @@
 	return &ei->vfs_inode;
 }
 
-void asfs_destroy_inode(struct inode *inode)
+static void asfs_destroy_inode(struct inode *inode)
 {
 	kmem_cache_free(asfs_inode_cachep, ASFS_I(inode));
 }

