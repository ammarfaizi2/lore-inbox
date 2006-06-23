Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbWFWKze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbWFWKze (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 06:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932541AbWFWKze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 06:55:34 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:1292 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932156AbWFWKzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 06:55:32 -0400
Date: Fri, 23 Jun 2006 12:55:30 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, reiserfs-dev@namesys.com
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] fs/reiser4/: possible cleanups
Message-ID: <20060623105530.GJ9111@stusta.de>
References: <20060621034857.35cfe36f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621034857.35cfe36f.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make needlessly global code static
- proper prototype for the following function:
  - plugin/file/file.c: init_uf_coord()
- "extern inline" -> "static inline"
- #if 0/comment out the following unused functions:
  - plugin/file/cryptcompress.c: jnode_of_cluster()
  - plugin/plugin.c: force_plugin()
  - plugin/plugin_set.c: plugin_set_compression()
- remove the following unused variable:
  - plugin/file/file.c: xversion

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/reiser4/block_alloc.c                 |   10 +++++-----
 fs/reiser4/flush_queue.c                 |    2 +-
 fs/reiser4/jnode.c                       |    7 ++++---
 fs/reiser4/jnode.h                       |    4 ----
 fs/reiser4/plugin/cluster.h              |    1 -
 fs/reiser4/plugin/file/cryptcompress.c   |    6 ++++--
 fs/reiser4/plugin/file/cryptcompress.h   |    2 --
 fs/reiser4/plugin/file/file.c            |    4 +---
 fs/reiser4/plugin/file/file.h            |    4 ++--
 fs/reiser4/plugin/item/extent_file_ops.c |    2 --
 fs/reiser4/plugin/plugin.c               |    2 ++
 fs/reiser4/plugin/plugin.h               |    1 -
 fs/reiser4/plugin/plugin_set.c           |    2 +-
 fs/reiser4/plugin/plugin_set.h           |    1 -
 fs/reiser4/super.h                       |    1 -
 fs/reiser4/super_ops.c                   |    4 ++--
 fs/reiser4/txnmgr.h                      |    1 -
 17 files changed, 22 insertions(+), 32 deletions(-)

--- linux-2.6.17-mm1-full/fs/reiser4/block_alloc.c.old	2006-06-22 16:00:18.000000000 +0200
+++ linux-2.6.17-mm1-full/fs/reiser4/block_alloc.c	2006-06-22 16:02:35.000000000 +0200
@@ -554,8 +554,8 @@
 
 /* adjust sb block counters, if real (on-disk) block allocation immediately
    follows grabbing of free disk space. */
-void grabbed2used(reiser4_context *ctx, reiser4_super_info_data *sbinfo,
-		  __u64 count)
+static void grabbed2used(reiser4_context *ctx, reiser4_super_info_data *sbinfo,
+			 __u64 count)
 {
 	sub_from_ctx_grabbed(ctx, count);
 
@@ -570,8 +570,8 @@
 }
 
 /* adjust sb block counters when @count unallocated blocks get mapped to disk */
-void fake_allocated2used(reiser4_super_info_data *sbinfo, __u64 count,
-			 reiser4_ba_flags_t flags)
+static void fake_allocated2used(reiser4_super_info_data *sbinfo, __u64 count,
+				reiser4_ba_flags_t flags)
 {
 	spin_lock_reiser4_super(sbinfo);
 
@@ -583,7 +583,7 @@
 	spin_unlock_reiser4_super(sbinfo);
 }
 
-void flush_reserved2used(txn_atom * atom, __u64 count)
+static void flush_reserved2used(txn_atom * atom, __u64 count)
 {
 	reiser4_super_info_data *sbinfo;
 
--- linux-2.6.17-mm1-full/fs/reiser4/txnmgr.h.old	2006-06-22 16:02:59.000000000 +0200
+++ linux-2.6.17-mm1-full/fs/reiser4/txnmgr.h	2006-06-22 16:03:04.000000000 +0200
@@ -661,7 +661,6 @@
 extern void fq_put(flush_queue_t *);
 extern void fuse_fq(txn_atom * to, txn_atom * from);
 extern void queue_jnode(flush_queue_t *, jnode *);
-extern void mark_jnode_queued(flush_queue_t *, jnode *);
 
 extern int write_fq(flush_queue_t *, long *, int);
 extern int current_atom_finish_all_fq(void);
--- linux-2.6.17-mm1-full/fs/reiser4/flush_queue.c.old	2006-06-22 16:03:13.000000000 +0200
+++ linux-2.6.17-mm1-full/fs/reiser4/flush_queue.c	2006-06-22 16:03:20.000000000 +0200
@@ -191,7 +191,7 @@
 }
 
 /* */
-void mark_jnode_queued(flush_queue_t * fq, jnode * node)
+static void mark_jnode_queued(flush_queue_t * fq, jnode * node)
 {
 	JF_SET(node, JNODE_FLUSH_QUEUED);
 	count_enqueued_node(fq);
--- linux-2.6.17-mm1-full/fs/reiser4/jnode.h.old	2006-06-22 16:04:24.000000000 +0200
+++ linux-2.6.17-mm1-full/fs/reiser4/jnode.h	2006-06-22 16:05:25.000000000 +0200
@@ -349,12 +349,8 @@
 extern jnode *jnode_by_page(struct page *pg) NONNULL;
 extern jnode *jnode_of_page(struct page *pg) NONNULL;
 void jnode_attach_page(jnode * node, struct page *pg);
-jnode *find_get_jnode(reiser4_tree * tree,
-		      struct address_space *mapping, oid_t oid,
-		      unsigned long index);
 
 void unhash_unformatted_jnode(jnode *);
-struct page *jnode_get_page_locked(jnode *, gfp_t gfp_flags);
 extern jnode *page_next_jnode(jnode * node) NONNULL;
 extern void jnode_init(jnode * node, reiser4_tree * tree, jnode_type) NONNULL;
 extern void jnode_make_dirty(jnode * node) NONNULL;
--- linux-2.6.17-mm1-full/fs/reiser4/jnode.c.old	2006-06-22 16:04:40.000000000 +0200
+++ linux-2.6.17-mm1-full/fs/reiser4/jnode.c	2006-06-22 16:05:34.000000000 +0200
@@ -537,8 +537,9 @@
  * allocate new jnode, insert it, and also insert into radix tree for the
  * given inode/mapping.
  */
-jnode *find_get_jnode(reiser4_tree * tree, struct address_space *mapping,
-		      oid_t oid, unsigned long index)
+static jnode *find_get_jnode(reiser4_tree * tree,
+			     struct address_space *mapping,
+			     oid_t oid, unsigned long index)
 {
 	jnode *result;
 	jnode *shadow;
@@ -786,7 +787,7 @@
 
 /* Lock a page attached to jnode, create and attach page to jnode if it had no
  * one. */
-struct page *jnode_get_page_locked(jnode * node, gfp_t gfp_flags)
+static struct page *jnode_get_page_locked(jnode * node, gfp_t gfp_flags)
 {
 	struct page *page;
 
--- linux-2.6.17-mm1-full/fs/reiser4/plugin/file/cryptcompress.h.old	2006-06-22 16:06:08.000000000 +0200
+++ linux-2.6.17-mm1-full/fs/reiser4/plugin/file/cryptcompress.h	2006-06-22 16:07:20.000000000 +0200
@@ -459,7 +459,6 @@
 void save_file_hint(struct file *, const hint_t *);
 void hint_init_zero(hint_t *);
 int crc_inode_ok(struct inode *inode);
-int jnode_of_cluster(const jnode * node, struct page * page);
 extern int ctail_read_disk_cluster (reiser4_cluster_t *, struct inode *, int);
 extern int do_readpage_ctail(struct inode *, reiser4_cluster_t *,
 			     struct page * page);
@@ -472,7 +471,6 @@
 				int (*can_inherit)(struct inode * child,
 						   struct inode * parent));
 void attach_crypto_stat(struct inode * inode, crypto_stat_t * info);
-void detach_crypto_stat(struct inode * inode);
 void change_crypto_stat(struct inode * inode, crypto_stat_t * new);
 crypto_stat_t * alloc_crypto_stat (struct inode * inode);
 
--- linux-2.6.17-mm1-full/fs/reiser4/plugin/cluster.h.old	2006-06-22 16:06:47.000000000 +0200
+++ linux-2.6.17-mm1-full/fs/reiser4/plugin/cluster.h	2006-06-22 16:06:53.000000000 +0200
@@ -240,7 +240,6 @@
 
 int inflate_cluster(reiser4_cluster_t *, struct inode *);
 int find_cluster(reiser4_cluster_t *, struct inode *, int read, int write);
-void forget_cluster_pages(struct page **page, int nrpages);
 int flush_cluster_pages(reiser4_cluster_t *, jnode *, struct inode *);
 int deflate_cluster(reiser4_cluster_t *, struct inode *);
 void truncate_page_cluster(struct inode *inode, cloff_t start);
--- linux-2.6.17-mm1-full/fs/reiser4/plugin/file/cryptcompress.c.old	2006-06-22 16:06:19.000000000 +0200
+++ linux-2.6.17-mm1-full/fs/reiser4/plugin/file/cryptcompress.c	2006-06-22 16:07:39.000000000 +0200
@@ -380,7 +380,7 @@
 }
 #endif  /*  REISER4_DEBUG  */
 
-void detach_crypto_stat(struct inode * inode)
+static void detach_crypto_stat(struct inode * inode)
 {
 	assert("edward-1385", inode != NULL);
 	assert("edward-1386", host_allows_crypto_stat(inode));
@@ -1574,6 +1574,7 @@
    understand that pages of cryptcompress files are not
    flushable.
 */
+#if 0
 int jnode_of_cluster(const jnode * node, struct page * page)
 {
 	assert("edward-1339", node != NULL);
@@ -1597,6 +1598,7 @@
 	}
 	return 0;
 }
+#endif  /*  0  */
 
 /* put cluster pages */
 void release_cluster_pages(reiser4_cluster_t * clust)
@@ -1751,7 +1753,7 @@
 	jput(node);
 }
 
-void forget_cluster_pages(struct page **pages, int nr)
+static void forget_cluster_pages(struct page **pages, int nr)
 {
 	int i;
 	for (i = 0; i < nr; i++) {
--- linux-2.6.17-mm1-full/fs/reiser4/plugin/file/file.h.old	2006-06-22 16:07:55.000000000 +0200
+++ linux-2.6.17-mm1-full/fs/reiser4/plugin/file/file.h	2006-06-22 16:18:08.000000000 +0200
@@ -114,7 +114,6 @@
 			  const reiser4_key *, znode_lock_mode,
 			  struct inode *);
 
-void validate_extended_coord(uf_coord_t *, loff_t offset);
 int load_file_hint(struct file *, hint_t *);
 void save_file_hint(struct file *, const hint_t *);
 
@@ -235,8 +234,9 @@
 int find_or_create_extent(struct page *);
 int equal_to_ldk(znode *, const reiser4_key *);
 
+void init_uf_coord(uf_coord_t *uf_coord, lock_handle *lh);
 
-extern inline int cbk_errored(int cbk_result)
+static inline int cbk_errored(int cbk_result)
 {
 	return (cbk_result != CBK_COORD_NOTFOUND
 		&& cbk_result != CBK_COORD_FOUND);
--- linux-2.6.17-mm1-full/fs/reiser4/plugin/item/extent_file_ops.c.old	2006-06-22 16:49:24.000000000 +0200
+++ linux-2.6.17-mm1-full/fs/reiser4/plugin/item/extent_file_ops.c	2006-06-22 16:49:51.000000000 +0200
@@ -734,8 +734,6 @@
 	return count;
 }
 
-void init_uf_coord(uf_coord_t *uf_coord, lock_handle *lh);
-
 /**
  * update_extent
  * @file:
--- linux-2.6.17-mm1-full/fs/reiser4/plugin/file/file.c.old	2006-06-22 16:08:12.000000000 +0200
+++ linux-2.6.17-mm1-full/fs/reiser4/plugin/file/file.c	2006-06-22 16:08:37.000000000 +0200
@@ -103,7 +103,7 @@
 	uf_coord->valid = 0;
 }
 
-void validate_extended_coord(uf_coord_t *uf_coord, loff_t offset)
+static void validate_extended_coord(uf_coord_t *uf_coord, loff_t offset)
 {
 	assert("vs-1333", uf_coord->valid == 0);
 
@@ -760,8 +760,6 @@
 			     hint->ext_coord.lh, lock_mode, ZNODE_LOCK_LOPRI);
 }
 
-int xversion;
-
 /**
  * find_or_create_extent -
  * @page:
--- linux-2.6.17-mm1-full/fs/reiser4/plugin/plugin.h.old	2006-06-22 16:09:55.000000000 +0200
+++ linux-2.6.17-mm1-full/fs/reiser4/plugin/plugin.h	2006-06-22 16:10:05.000000000 +0200
@@ -886,7 +886,6 @@
 int grab_plugin(struct inode *self, struct inode *ancestor, pset_member memb);
 int grab_plugin_from(struct inode *self, pset_member memb,
 		     reiser4_plugin * plug);
-int force_plugin(struct inode *self, pset_member memb, reiser4_plugin * plug);
 
 /* defined in fs/reiser4/plugin/object.c */
 extern file_plugin file_plugins[LAST_FILE_PLUGIN_ID];
--- linux-2.6.17-mm1-full/fs/reiser4/plugin/plugin.c.old	2006-06-22 16:10:12.000000000 +0200
+++ linux-2.6.17-mm1-full/fs/reiser4/plugin/plugin.c	2006-06-22 16:11:03.000000000 +0200
@@ -348,6 +348,7 @@
 	return result;
 }
 
+#if 0
 int force_plugin(struct inode *self, pset_member memb, reiser4_plugin * plug)
 {
 	reiser4_inode *info;
@@ -362,6 +363,7 @@
 		update_plugin_mask(info, memb);
 	return result;
 }
+#endif  /*  0  */
 
 reiser4_plugin_type_data plugins[REISER4_PLUGIN_TYPES] = {
 	/* C90 initializers */
--- linux-2.6.17-mm1-full/fs/reiser4/plugin/plugin_set.h.old	2006-06-22 16:11:33.000000000 +0200
+++ linux-2.6.17-mm1-full/fs/reiser4/plugin/plugin_set.h	2006-06-22 16:11:42.000000000 +0200
@@ -57,7 +57,6 @@
 extern int plugin_set_hash(plugin_set ** set, hash_plugin * plug);
 extern int plugin_set_fibration(plugin_set ** set, fibration_plugin * plug);
 extern int plugin_set_sd(plugin_set ** set, item_plugin * plug);
-extern int plugin_set_compression(plugin_set ** set, compression_plugin * plug);
 extern int plugin_set_cluster(plugin_set ** set, cluster_plugin * plug);
 
 extern int init_plugin_set(void);
--- linux-2.6.17-mm1-full/fs/reiser4/plugin/plugin_set.c.old	2006-06-22 16:11:54.000000000 +0200
+++ linux-2.6.17-mm1-full/fs/reiser4/plugin/plugin_set.c	2006-06-22 16:12:25.000000000 +0200
@@ -322,7 +322,7 @@
     DEFINE_PLUGIN_SET(item_plugin, sd)
     /* DEFINE_PLUGIN_SET(cipher_plugin, cipher) */
     /* DEFINE_PLUGIN_SET(digest_plugin, digest) */
-    DEFINE_PLUGIN_SET(compression_plugin, compression)
+    /* DEFINE_PLUGIN_SET(compression_plugin, compression) */
     /* DEFINE_PLUGIN_SET(compression_mode_plugin, compression_mode) */
     DEFINE_PLUGIN_SET(cluster_plugin, cluster)
     /* DEFINE_PLUGIN_SET(regular_plugin, regular_entry) */
--- linux-2.6.17-mm1-full/fs/reiser4/super.h.old	2006-06-22 16:12:41.000000000 +0200
+++ linux-2.6.17-mm1-full/fs/reiser4/super.h	2006-06-22 16:12:46.000000000 +0200
@@ -452,7 +452,6 @@
 extern struct super_operations reiser4_super_operations;
 extern struct export_operations reiser4_export_operations;
 extern struct dentry_operations reiser4_dentry_operations;
-extern struct dentry *reiser4_debugfs_root;
 
 /* __REISER4_SUPER_H__ */
 #endif
--- linux-2.6.17-mm1-full/fs/reiser4/super_ops.c.old	2006-06-22 16:12:55.000000000 +0200
+++ linux-2.6.17-mm1-full/fs/reiser4/super_ops.c	2006-06-22 16:13:16.000000000 +0200
@@ -16,6 +16,8 @@
 /* slab cache for inodes */
 static kmem_cache_t *inode_cache;
 
+static struct dentry *reiser4_debugfs_root = NULL;
+
 /**
  * init_once - constructor for reiser4 inodes
  * @obj: inode to be initialized
@@ -593,8 +595,6 @@
 	*cachep = NULL;
 }
 
-struct dentry *reiser4_debugfs_root = NULL;
-
 /**
  * init_reiser4 - reiser4 initialization entry point
  *

