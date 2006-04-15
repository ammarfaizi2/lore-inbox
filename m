Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965155AbWDOVzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965155AbWDOVzM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 17:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965183AbWDOVzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 17:55:12 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:43024 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965155AbWDOVzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 17:55:10 -0400
Date: Sat, 15 Apr 2006 23:55:07 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org
Subject: [-mm patch] fs/reiser4/: misc cleanups
Message-ID: <20060415215507.GO15022@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some needlessly global code static and #ifdef's some 
unused code away.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 5 Jan 2006

 fs/reiser4/debug.c                         |   31 ++++-----
 fs/reiser4/debug.h                         |    2 
 fs/reiser4/entd.c                          |    4 +
 fs/reiser4/entd.h                          |    2 
 fs/reiser4/estimate.c                      |    2 
 fs/reiser4/inode.c                         |    2 
 fs/reiser4/inode.h                         |    1 
 fs/reiser4/jnode.c                         |   62 +++++++++---------
 fs/reiser4/jnode.h                         |    2 
 fs/reiser4/plugin/cluster.h                |    3 
 fs/reiser4/plugin/compress/compress_mode.c |    2 
 fs/reiser4/plugin/file/cryptcompress.c     |   69 +++++++++++++--------
 fs/reiser4/plugin/file/cryptcompress.h     |    7 --
 fs/reiser4/plugin/file/file.h              |    3 
 fs/reiser4/plugin/file/funcs.h             |    2 
 fs/reiser4/plugin/file_ops.c               |    2 
 fs/reiser4/plugin/file_plugin_common.c     |    2 
 fs/reiser4/plugin/item/ctail.c             |    2 
 fs/reiser4/plugin/object.h                 |    3 
 fs/reiser4/plugin/plugin_set.c             |    8 +-
 fs/reiser4/plugin/plugin_set.h             |    5 -
 21 files changed, 106 insertions(+), 110 deletions(-)

--- linux-2.6.15-mm1-full/fs/reiser4/estimate.c.old	2006-01-05 21:16:06.000000000 +0100
+++ linux-2.6.15-mm1-full/fs/reiser4/estimate.c	2006-01-05 21:16:17.000000000 +0100
@@ -70,7 +70,7 @@
 }
 
 /* returnes max number of nodes can be occupied by disk cluster */
-reiser4_block_nr estimate_cluster(struct inode * inode, int unprepped)
+static reiser4_block_nr estimate_cluster(struct inode * inode, int unprepped)
 {
 	int per_cluster;
 	per_cluster = (unprepped ? 1 : cluster_nrpages(inode));
--- linux-2.6.15-mm1-full/fs/reiser4/debug.h.old	2006-01-05 21:16:40.000000000 +0100
+++ linux-2.6.15-mm1-full/fs/reiser4/debug.h	2006-01-05 21:16:47.000000000 +0100
@@ -226,8 +226,6 @@
 
 
 #if REISER4_DEBUG
-extern void print_lock_counters(const char *prefix,
-				const lock_counters_info * info);
 extern int no_counters_are_held(void);
 extern int commit_check_locks(void);
 #else
--- linux-2.6.15-mm1-full/fs/reiser4/debug.c.old	2006-01-05 21:16:54.000000000 +0100
+++ linux-2.6.15-mm1-full/fs/reiser4/debug.c	2006-01-05 21:17:45.000000000 +0100
@@ -123,22 +123,6 @@
 }
 
 #if REISER4_DEBUG
-
-/* check that no spinlocks are held */
-int schedulable(void)
-{
-	if (get_current_context_check() != NULL) {
-		if (!LOCK_CNT_NIL(spin_locked)) {
-			print_lock_counters("in atomic", lock_counters());
-			return 0;
-		}
-	}
-	might_sleep();
-	return 1;
-}
-#endif
-
-#if REISER4_DEBUG
 /* Debugging aid: return struct where information about locks taken by current
    thread is accumulated. This can be used to formulate lock ordering
    constraints and various assertions.
@@ -154,7 +138,8 @@
 /*
  * print human readable information about locks held by the reiser4 context.
  */
-void print_lock_counters(const char *prefix, const lock_counters_info * info)
+static void print_lock_counters(const char *prefix,
+				const lock_counters_info * info)
 {
 	printk("%s: jnode: %i, tree: %i (r:%i,w:%i), dk: %i (r:%i,w:%i)\n"
 	       "jload: %i, "
@@ -187,6 +172,18 @@
 	       info->d_refs, info->x_refs, info->t_refs);
 }
 
+/* check that no spinlocks are held */
+int schedulable(void)
+{
+	if (get_current_context_check() != NULL) {
+		if (!LOCK_CNT_NIL(spin_locked)) {
+			print_lock_counters("in atomic", lock_counters());
+			return 0;
+		}
+	}
+	might_sleep();
+	return 1;
+}
 /*
  * return true, iff no locks are held.
  */
--- linux-2.6.15-mm1-full/fs/reiser4/entd.h.old	2006-01-05 21:18:24.000000000 +0100
+++ linux-2.6.15-mm1-full/fs/reiser4/entd.h	2006-01-05 21:18:41.000000000 +0100
@@ -75,8 +75,6 @@
 extern int wbq_available(void);
 extern void ent_writes_page(struct super_block *, struct page *);
 
-extern struct wbq *get_wbq(struct super_block *);
-extern void put_wbq(struct super_block *, struct wbq *);
 extern jnode *get_jnode_by_wbq(struct super_block *, struct wbq *);
 /* __ENTD_H__ */
 #endif
--- linux-2.6.15-mm1-full/fs/reiser4/entd.c.old	2006-01-05 21:18:50.000000000 +0100
+++ linux-2.6.15-mm1-full/fs/reiser4/entd.c	2006-01-05 21:19:14.000000000 +0100
@@ -86,6 +86,8 @@
 	return wbq;
 }
 
+#if 0
+
 struct wbq * get_wbq(struct super_block * super)
 {
 	struct wbq *result;
@@ -107,6 +109,8 @@
 	spin_unlock(&ent->guard);
 }
 
+#endif  /*  0  */
+
 static void wakeup_all_wbq(entd_context * ent)
 {
 	struct wbq *rq;
--- linux-2.6.15-mm1-full/fs/reiser4/inode.h.old	2006-01-05 21:19:53.000000000 +0100
+++ linux-2.6.15-mm1-full/fs/reiser4/inode.h	2006-01-05 21:19:58.000000000 +0100
@@ -340,7 +340,6 @@
 
 extern file_plugin *inode_file_plugin(const struct inode *inode);
 extern dir_plugin *inode_dir_plugin(const struct inode *inode);
-extern perm_plugin *inode_perm_plugin(const struct inode *inode);
 extern formatting_plugin *inode_formatting_plugin(const struct inode *inode);
 extern hash_plugin *inode_hash_plugin(const struct inode *inode);
 extern fibration_plugin *inode_fibration_plugin(const struct inode *inode);
--- linux-2.6.15-mm1-full/fs/reiser4/inode.c.old	2006-01-05 21:20:05.000000000 +0100
+++ linux-2.6.15-mm1-full/fs/reiser4/inode.c	2006-01-05 21:20:20.000000000 +0100
@@ -521,11 +521,13 @@
 	return reiser4_inode_data(inode)->pset->dir;
 }
 
+#if 0
 perm_plugin *inode_perm_plugin(const struct inode * inode)
 {
 	assert("nikita-1999", inode != NULL);
 	return reiser4_inode_data(inode)->pset->perm;
 }
+#endif  /*  0  */
 
 formatting_plugin *inode_formatting_plugin(const struct inode * inode)
 {
--- linux-2.6.15-mm1-full/fs/reiser4/jnode.h.old	2006-01-05 21:20:49.000000000 +0100
+++ linux-2.6.15-mm1-full/fs/reiser4/jnode.h	2006-01-05 21:20:56.000000000 +0100
@@ -449,12 +449,10 @@
 
 extern int znode_is_any_locked(const znode * node);
 extern void jnode_list_remove(jnode * node);
-extern void info_jnode(const char *prefix, const jnode * node);
 
 #else
 
 #define jnode_list_remove(node) noop
-#define info_jnode(p, n) noop
 
 #endif
 
--- linux-2.6.15-mm1-full/fs/reiser4/jnode.c.old	2006-01-05 21:21:04.000000000 +0100
+++ linux-2.6.15-mm1-full/fs/reiser4/jnode.c	2006-01-05 21:56:35.000000000 +0100
@@ -1824,34 +1824,6 @@
 
 }
 
-/* debugging aid: check znode invariant and panic if it doesn't hold */
-static int jnode_invariant(const jnode * node, int tlocked, int jlocked)
-{
-	char const *failed_msg;
-	int result;
-	reiser4_tree *tree;
-
-	tree = jnode_get_tree(node);
-
-	assert("umka-063312", node != NULL);
-	assert("umka-064321", tree != NULL);
-
-	if (!jlocked && !tlocked)
-		spin_lock_jnode((jnode *) node);
-	if (!tlocked)
-		read_lock_tree(jnode_get_tree(node));
-	result = jnode_invariant_f(node, &failed_msg);
-	if (!result) {
-		info_jnode("corrupted node", node);
-		warning("jmacd-555", "Condition %s failed", failed_msg);
-	}
-	if (!tlocked)
-		read_unlock_tree(jnode_get_tree(node));
-	if (!jlocked && !tlocked)
-		spin_unlock_jnode((jnode *) node);
-	return result;
-}
-
 static const char *jnode_type_name(jnode_type type)
 {
 	switch (type) {
@@ -1880,8 +1852,8 @@
 	( JF_ISSET( ( node ), ( flag ) ) ? ((#flag "|")+6) : "" )
 
 /* debugging aid: output human readable information about @node */
-void info_jnode(const char *prefix /* prefix to print */ ,
-		const jnode * node /* node to print */ )
+static void info_jnode(const char *prefix /* prefix to print */ ,
+		       const jnode * node /* node to print */ )
 {
 	assert("umka-068", prefix != NULL);
 
@@ -1925,8 +1897,37 @@
 }
 
 
+/* debugging aid: check znode invariant and panic if it doesn't hold */
+static int jnode_invariant(const jnode * node, int tlocked, int jlocked)
+{
+	char const *failed_msg;
+	int result;
+	reiser4_tree *tree;
+
+	tree = jnode_get_tree(node);
+
+	assert("umka-063312", node != NULL);
+	assert("umka-064321", tree != NULL);
+
+	if (!jlocked && !tlocked)
+		spin_lock_jnode((jnode *) node);
+	if (!tlocked)
+		read_lock_tree(jnode_get_tree(node));
+	result = jnode_invariant_f(node, &failed_msg);
+	if (!result) {
+		info_jnode("corrupted node", node);
+		warning("jmacd-555", "Condition %s failed", failed_msg);
+	}
+	if (!tlocked)
+		read_unlock_tree(jnode_get_tree(node));
+	if (!jlocked && !tlocked)
+		spin_unlock_jnode((jnode *) node);
+	return result;
+}
+
 #endif				/* REISER4_DEBUG */
 
+#if REISER4_COPY_ON_CAPTURE
 /* this is only used to created jnode during capture copy */
 jnode *jclone(jnode * node)
 {
@@ -1942,6 +1943,7 @@
 	JF_SET(clone, JNODE_CC);
 	return clone;
 }
+#endif  /*  REISER4_COPY_ON_CAPTURE  */
 
 /* Make Linus happy.
    Local variables:
--- linux-2.6.15-mm1-full/fs/reiser4/plugin/file/cryptcompress.h.old	2006-01-05 21:23:46.000000000 +0100
+++ linux-2.6.15-mm1-full/fs/reiser4/plugin/file/cryptcompress.h	2006-01-05 21:28:57.000000000 +0100
@@ -436,14 +436,11 @@
 	crypto_stat_t *crypt;
 } cryptcompress_info_t;
 
-cryptcompress_info_t *cryptcompress_inode_data(const struct inode *inode);
 int equal_to_rdk(znode *, const reiser4_key *);
 int goto_right_neighbor(coord_t *, lock_handle *);
 int load_file_hint(struct file *, hint_t *);
 void save_file_hint(struct file *, const hint_t *);
 void hint_init_zero(hint_t *);
-int need_cipher (struct inode *);
-int host_allows_crypto_stat(struct inode * inode);
 int crc_inode_ok(struct inode *inode);
 int jnode_of_cluster(const jnode * node, struct page * page);
 extern int ctail_read_disk_cluster (reiser4_cluster_t *, struct inode *, int);
@@ -457,14 +454,10 @@
 void inherit_crypto_stat_common(struct inode * parent, struct inode * object,
 				int (*can_inherit)(struct inode * child,
 						   struct inode * parent));
-crypto_stat_t * create_crypto_stat(struct inode * parent, crypto_data_t * data);
-int crypto_stat_instantiated(crypto_stat_t * info);
 void attach_crypto_stat(struct inode * inode, crypto_stat_t * info);
 void detach_crypto_stat(struct inode * inode);
 void change_crypto_stat(struct inode * inode, crypto_stat_t * new);
-int can_inherit_crypto_crc(struct inode *child, struct inode *parent);
 crypto_stat_t * alloc_crypto_stat (struct inode * inode);
-int switch_compression(struct inode *inode);
 
 
 static inline reiser4_tfma_t *
--- linux-2.6.15-mm1-full/fs/reiser4/plugin/compress/compress_mode.c.old	2006-01-05 21:23:58.000000000 +0100
+++ linux-2.6.15-mm1-full/fs/reiser4/plugin/compress/compress_mode.c	2006-01-05 21:24:05.000000000 +0100
@@ -25,7 +25,7 @@
 }
 
 /* generic turn on/off compression */
-int switch_compression(struct inode *inode)
+static int switch_compression(struct inode *inode)
 {
 	int result;
 
--- linux-2.6.15-mm1-full/fs/reiser4/plugin/file/file.h.old	2006-01-05 21:24:24.000000000 +0100
+++ linux-2.6.15-mm1-full/fs/reiser4/plugin/file/file.h	2006-01-05 21:30:16.000000000 +0100
@@ -192,9 +192,6 @@
 extern int readpage_cryptcompress(struct file *, struct page *);
 extern int writepages_cryptcompress(struct address_space *,
 				     struct writeback_control *);
-extern void readpages_cryptcompress(struct file *, struct address_space *,
-				    struct list_head *pages);
-extern sector_t bmap_cryptcompress(struct address_space *, sector_t lblock);
 
 
 /* file plugin operations */
--- linux-2.6.15-mm1-full/fs/reiser4/plugin/cluster.h.old	2006-01-05 21:30:53.000000000 +0100
+++ linux-2.6.15-mm1-full/fs/reiser4/plugin/cluster.h	2006-01-05 21:49:06.000000000 +0100
@@ -245,8 +245,6 @@
 int flush_cluster_pages(reiser4_cluster_t *, jnode *, struct inode *);
 int deflate_cluster(reiser4_cluster_t *, struct inode *);
 void truncate_page_cluster(struct inode *inode, cloff_t start);
-void set_hint_cluster(struct inode *inode, hint_t * hint, unsigned long index,
-		      znode_lock_mode mode);
 void invalidate_hint_cluster(reiser4_cluster_t * clust);
 void put_hint_cluster(reiser4_cluster_t * clust, struct inode *inode,
 		      znode_lock_mode mode);
@@ -263,7 +261,6 @@
 int tfm_cluster_is_uptodate(tfm_cluster_t * tc);
 void tfm_cluster_set_uptodate(tfm_cluster_t * tc);
 void tfm_cluster_clr_uptodate(tfm_cluster_t * tc);
-unsigned long clust_by_coord(const coord_t * coord, struct inode *inode);
 
 /* move cluster handle to the target position
    specified by the page of index @pgidx
--- linux-2.6.15-mm1-full/fs/reiser4/plugin/file/cryptcompress.c.old	2006-01-05 21:25:14.000000000 +0100
+++ linux-2.6.15-mm1-full/fs/reiser4/plugin/file/cryptcompress.c	2006-01-05 22:13:54.000000000 +0100
@@ -19,7 +19,7 @@
 #include <linux/random.h>
 
 /* get cryptcompress specific portion of inode */
-cryptcompress_info_t *cryptcompress_inode_data(const struct inode *inode)
+static cryptcompress_info_t *cryptcompress_inode_data(const struct inode *inode)
 {
 	return &reiser4_inode_data(inode)->file_plugin_data.cryptcompress_info;
 }
@@ -100,6 +100,7 @@
 	return info;
 }
 
+#if 0
 static int
 alloc_crypto_tfms(plugin_set * pset, crypto_stat_t * info)
 {
@@ -139,6 +140,7 @@
 	}
 	return RETERR(-EINVAL);
 }
+#endif  /*  0  */
 
 static void
 free_crypto_tfms(crypto_stat_t * info)
@@ -153,6 +155,7 @@
 	return;
 }
 
+#if 0
 static int create_keyid (crypto_stat_t * info, crypto_data_t * data)
 {
 	int ret = -ENOMEM;
@@ -207,6 +210,7 @@
  exit1:
 	return ret;
 }
+#endif  /*  0  */
 
 static void destroy_keyid(crypto_stat_t * info)
 {
@@ -225,12 +229,14 @@
 	kfree(info);
 }
 
+#if 0
 static void instantiate_crypto_stat(crypto_stat_t * info)
 {
 	assert("edward-1373", info != NULL);
 	assert("edward-1374", info->inst == 0);
 	info->inst = 1;
 }
+#endif  /*  0  */
 
 static void uninstantiate_crypto_stat(crypto_stat_t * info)
 {
@@ -238,7 +244,7 @@
 	info->inst = 0;
 }
 
-int crypto_stat_instantiated(crypto_stat_t * info)
+static int crypto_stat_instantiated(crypto_stat_t * info)
 {
 	return info->inst;
 }
@@ -256,7 +262,14 @@
 	free_crypto_stat(inode_crypto_stat(inode));
 }
 
+static int need_cipher(struct inode * inode)
+{
+	return inode_cipher_plugin(inode) !=
+		cipher_plugin_by_id(NONE_CIPHER_ID);
+}
+
 /* Instantiate a crypto-stat represented by low-lewel @data for the @object */
+#if 0
 crypto_stat_t *
 create_crypto_stat(struct inode * object, crypto_data_t * data)
 {
@@ -300,6 +313,7 @@
 	free_crypto_stat(info);
  	return ERR_PTR(ret);
 }
+#endif  /*  0  */
 
 static void load_crypto_stat(crypto_stat_t * info)
 {
@@ -328,6 +342,24 @@
 	load_crypto_stat(info);
 }
 
+/* returns true, if crypto stat can be attached to the @host */
+#if REISER4_DEBUG
+static int host_allows_crypto_stat(struct inode * host)
+{
+	int ret;
+	file_plugin * fplug = inode_file_plugin(host);
+
+	switch (fplug->h.id) {
+	case CRC_FILE_PLUGIN_ID:
+		ret = 1;
+		break;
+	default:
+		ret = 0;
+	}
+	return ret;
+}
+#endif  /*  REISER4_DEBUG  */
+
 void detach_crypto_stat(struct inode * inode)
 {
 	assert("edward-1385", inode != NULL);
@@ -338,6 +370,8 @@
 	set_inode_crypto_stat(inode, NULL);
 }
 
+#if 0
+
 static int keyid_eq(crypto_stat_t * child, crypto_stat_t * parent)
 {
 	return !memcmp(child->keyid, parent->keyid, info_digest_plugin(parent)->fipsize);
@@ -359,27 +393,7 @@
 		keyid_eq(inode_crypto_stat(child), inode_crypto_stat(parent)));
 }
 
-int need_cipher(struct inode * inode)
-{
-	return inode_cipher_plugin(inode) !=
-		cipher_plugin_by_id(NONE_CIPHER_ID);
-}
-
-/* returns true, if crypto stat can be attached to the @host */
-int host_allows_crypto_stat(struct inode * host)
-{
-	int ret;
-	file_plugin * fplug = inode_file_plugin(host);
-
-	switch (fplug->h.id) {
-	case CRC_FILE_PLUGIN_ID:
-		ret = 1;
-		break;
-	default:
-		ret = 0;
-	}
-	return ret;
-}
+#endif  /*  0  */
 
 static int inode_set_crypto(struct inode * object)
 {
@@ -1248,6 +1262,7 @@
 }
 
 /* plugin->readpages() */
+#if 0
 void
 readpages_cryptcompress(struct file *file, struct address_space *mapping,
 			struct list_head *pages)
@@ -1270,6 +1285,7 @@
 
 	return;
 }
+#endif  /*  0  */
 
 /* how much pages will be captured */
 static int cluster_nrpages_to_capture(reiser4_cluster_t * clust)
@@ -1885,9 +1901,8 @@
 }
 
 /* set hint for the cluster of the index @index */
-void
-set_hint_cluster(struct inode *inode, hint_t * hint,
-		 cloff_t index, znode_lock_mode mode)
+static void set_hint_cluster(struct inode *inode, hint_t * hint,
+			     cloff_t index, znode_lock_mode mode)
 {
 	reiser4_key key;
 	assert("edward-722", crc_inode_ok(inode));
@@ -3668,6 +3683,7 @@
 /* implentation of vfs' bmap method of struct address_space_operations for
    cryptcompress plugin
 */
+#if 0
 sector_t bmap_cryptcompress(struct address_space * mapping, sector_t lblock)
 {
 	struct inode *inode;
@@ -3727,6 +3743,7 @@
 		return result;
 	}
 }
+#endif  /*  0  */
 
 /* this is implementation of delete method of file plugin for
    cryptcompress objects */
--- linux-2.6.15-mm1-full/fs/reiser4/plugin/file/funcs.h.old	2006-01-05 21:26:58.000000000 +0100
+++ linux-2.6.15-mm1-full/fs/reiser4/plugin/file/funcs.h	2006-01-05 21:27:07.000000000 +0100
@@ -21,7 +21,7 @@
 int equal_to_ldk(znode *, const reiser4_key *);
 #endif
 
-extern inline int cbk_errored(int cbk_result)
+static inline int cbk_errored(int cbk_result)
 {
 	return (cbk_result != CBK_COORD_NOTFOUND
 		&& cbk_result != CBK_COORD_FOUND);
--- linux-2.6.15-mm1-full/fs/reiser4/plugin/object.h.old	2006-01-05 21:31:32.000000000 +0100
+++ linux-2.6.15-mm1-full/fs/reiser4/plugin/object.h	2006-01-05 21:32:31.000000000 +0100
@@ -34,8 +34,6 @@
 int readdir_common(struct file *, void *dirent, filldir_t);
 int release_dir_common(struct inode *, struct file *);
 int sync_common(struct file *, struct dentry *, int datasync);
-ssize_t sendfile_common(struct file *, loff_t *ppos, size_t count,
-			read_actor_t, void *target);
 
 /* common implementations of address space operations */
 int prepare_write_common(struct file *, struct page *, unsigned from,
@@ -105,7 +103,6 @@
 int do_prepare_write(struct file *, struct page *, unsigned from, unsigned to);
 
 /* merely useful functions */
-int locate_inode_sd(struct inode *, reiser4_key *, coord_t *, lock_handle *);
 int lookup_sd(struct inode *, znode_lock_mode, coord_t *, lock_handle *,
 	      const reiser4_key *, int silent);
 
--- linux-2.6.15-mm1-full/fs/reiser4/plugin/file_ops.c.old	2006-01-05 21:31:46.000000000 +0100
+++ linux-2.6.15-mm1-full/fs/reiser4/plugin/file_ops.c	2006-01-05 21:32:02.000000000 +0100
@@ -64,6 +64,7 @@
    Reads @count bytes from @file and calls @actor for every page read. This is
    needed for loop back devices support.
 */
+#if 0
 ssize_t
 sendfile_common(struct file *file, loff_t *ppos, size_t count,
 		read_actor_t actor, void *target)
@@ -78,6 +79,7 @@
 	reiser4_exit_context(ctx);
 	return result;
 }
+#endif  /*  0  */
 
 /* address space operations */
 
--- linux-2.6.15-mm1-full/fs/reiser4/plugin/file_plugin_common.c.old	2006-01-05 21:32:35.000000000 +0100
+++ linux-2.6.15-mm1-full/fs/reiser4/plugin/file_plugin_common.c	2006-01-05 21:32:41.000000000 +0100
@@ -709,7 +709,7 @@
 	return result;
 }
 
-int
+static int
 locate_inode_sd(struct inode *inode,
 		reiser4_key * key, coord_t * coord, lock_handle * lh)
 {
--- linux-2.6.15-mm1-full/fs/reiser4/plugin/item/ctail.c.old	2006-01-05 21:49:17.000000000 +0100
+++ linux-2.6.15-mm1-full/fs/reiser4/plugin/item/ctail.c	2006-01-05 21:49:24.000000000 +0100
@@ -68,7 +68,7 @@
 	return (int)cluster_shift_by_coord(coord) == (int)UCTAIL_SHIFT;
 }
 
-cloff_t clust_by_coord(const coord_t * coord, struct inode *inode)
+static cloff_t clust_by_coord(const coord_t * coord, struct inode *inode)
 {
 	int shift;
 
--- linux-2.6.15-mm1-full/fs/reiser4/plugin/plugin_set.h.old	2006-01-05 21:50:11.000000000 +0100
+++ linux-2.6.15-mm1-full/fs/reiser4/plugin/plugin_set.h	2006-01-05 21:52:09.000000000 +0100
@@ -57,13 +57,8 @@
 extern int plugin_set_hash(plugin_set ** set, hash_plugin * plug);
 extern int plugin_set_fibration(plugin_set ** set, fibration_plugin * plug);
 extern int plugin_set_sd(plugin_set ** set, item_plugin * plug);
-extern int plugin_set_cipher(plugin_set ** set, cipher_plugin * plug);
-extern int plugin_set_digest(plugin_set ** set, digest_plugin * plug);
 extern int plugin_set_compression(plugin_set ** set, compression_plugin * plug);
-extern int plugin_set_compression_mode(plugin_set ** set,
-				       compression_mode_plugin * plug);
 extern int plugin_set_cluster(plugin_set ** set, cluster_plugin * plug);
-extern int plugin_set_regular_entry(plugin_set ** set, regular_plugin * plug);
 
 extern int init_plugin_set(void);
 extern void done_plugin_set(void);
--- linux-2.6.15-mm1-full/fs/reiser4/plugin/plugin_set.c.old	2006-01-05 22:35:16.000000000 +0100
+++ linux-2.6.15-mm1-full/fs/reiser4/plugin/plugin_set.c	2006-01-05 21:51:54.000000000 +0100
@@ -320,12 +320,12 @@
     DEFINE_PLUGIN_SET(hash_plugin, hash)
     DEFINE_PLUGIN_SET(fibration_plugin, fibration)
     DEFINE_PLUGIN_SET(item_plugin, sd)
-    DEFINE_PLUGIN_SET(cipher_plugin, cipher)
-    DEFINE_PLUGIN_SET(digest_plugin, digest)
+    /* DEFINE_PLUGIN_SET(cipher_plugin, cipher) */
+    /* DEFINE_PLUGIN_SET(digest_plugin, digest) */
     DEFINE_PLUGIN_SET(compression_plugin, compression)
-    DEFINE_PLUGIN_SET(compression_mode_plugin, compression_mode)
+    /* DEFINE_PLUGIN_SET(compression_mode_plugin, compression_mode) */
     DEFINE_PLUGIN_SET(cluster_plugin, cluster)
-    DEFINE_PLUGIN_SET(regular_plugin, regular_entry)
+    /* DEFINE_PLUGIN_SET(regular_plugin, regular_entry) */
 
 
 /**

