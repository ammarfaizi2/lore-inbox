Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750891AbVKKQuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbVKKQuQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 11:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbVKKQuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 11:50:15 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:45527 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750891AbVKKQuN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 11:50:13 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17268.52121.810790.84372@tut.ibm.com>
Date: Fri, 11 Nov 2005 10:49:29 -0600
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, karim@opersys.com
Subject: [PATCH 5/12] relayfs: remove unused alloc/destroy_inode()
In-Reply-To: <17268.51814.215178.281986@tut.ibm.com>
References: <17268.51814.215178.281986@tut.ibm.com>
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since we're no longer using relayfs_inode_info, remove
relayfs_alloc_inode() and relayfs_destroy_inode() along with the
relayfs inode cache.

Signed-off-by: Tom Zanussi <zanussi@us.ibm.com>

---

 fs/relayfs/inode.c         |   46 ---------------------------------------------
 include/linux/relayfs_fs.h |   14 -------------
 2 files changed, 1 insertion(+), 59 deletions(-)

diff --git a/fs/relayfs/inode.c b/fs/relayfs/inode.c
--- a/fs/relayfs/inode.c
+++ b/fs/relayfs/inode.c
@@ -26,7 +26,6 @@
 
 static struct vfsmount *		relayfs_mount;
 static int				relayfs_mount_count;
-static kmem_cache_t *			relayfs_inode_cachep;
 
 static struct backing_dev_info		relayfs_backing_dev_info = {
 	.ra_pages	= 0,	/* No readahead */
@@ -499,34 +498,6 @@ out:
 	return ret;
 }
 
-/**
- *	relayfs alloc_inode() implementation
- */
-static struct inode *relayfs_alloc_inode(struct super_block *sb)
-{
-	struct relayfs_inode_info *p = kmem_cache_alloc(relayfs_inode_cachep, SLAB_KERNEL);
-	if (!p)
-		return NULL;
-	p->data = NULL;
-
-	return &p->vfs_inode;
-}
-
-/**
- *	relayfs destroy_inode() implementation
- */
-static void relayfs_destroy_inode(struct inode *inode)
-{
-	kmem_cache_free(relayfs_inode_cachep, RELAYFS_I(inode));
-}
-
-static void init_once(void *p, kmem_cache_t *cachep, unsigned long flags)
-{
-	struct relayfs_inode_info *i = p;
-	if ((flags & (SLAB_CTOR_VERIFY | SLAB_CTOR_CONSTRUCTOR)) == SLAB_CTOR_CONSTRUCTOR)
-		inode_init_once(&i->vfs_inode);
-}
-
 struct file_operations relayfs_file_operations = {
 	.open		= relayfs_open,
 	.poll		= relayfs_poll,
@@ -539,8 +510,6 @@ struct file_operations relayfs_file_oper
 static struct super_operations relayfs_ops = {
 	.statfs		= simple_statfs,
 	.drop_inode	= generic_delete_inode,
-	.alloc_inode	= relayfs_alloc_inode,
-	.destroy_inode	= relayfs_destroy_inode,
 };
 
 static int relayfs_fill_super(struct super_block * sb, void * data, int silent)
@@ -584,25 +553,12 @@ static struct file_system_type relayfs_f
 
 static int __init init_relayfs_fs(void)
 {
-	int err;
-
-	relayfs_inode_cachep = kmem_cache_create("relayfs_inode_cache",
-				sizeof(struct relayfs_inode_info), 0,
-				0, init_once, NULL);
-	if (!relayfs_inode_cachep)
-		return -ENOMEM;
-
-	err = register_filesystem(&relayfs_fs_type);
-	if (err)
-		kmem_cache_destroy(relayfs_inode_cachep);
-
-	return err;
+	return register_filesystem(&relayfs_fs_type);
 }
 
 static void __exit exit_relayfs_fs(void)
 {
 	unregister_filesystem(&relayfs_fs_type);
-	kmem_cache_destroy(relayfs_inode_cachep);
 }
 
 module_init(init_relayfs_fs)
diff --git a/include/linux/relayfs_fs.h b/include/linux/relayfs_fs.h
--- a/include/linux/relayfs_fs.h
+++ b/include/linux/relayfs_fs.h
@@ -64,20 +64,6 @@ struct rchan
 };
 
 /*
- * Relayfs inode
- */
-struct relayfs_inode_info
-{
-	struct inode vfs_inode;
-	void *data;
-};
-
-static inline struct relayfs_inode_info *RELAYFS_I(struct inode *inode)
-{
-	return container_of(inode, struct relayfs_inode_info, vfs_inode);
-}
-
-/*
  * Relay channel client callbacks
  */
 struct rchan_callbacks


