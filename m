Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261981AbVBPJ7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbVBPJ7v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 04:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbVBPJ7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 04:59:51 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:6155 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261981AbVBPJ7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 04:59:23 -0500
Date: Wed, 16 Feb 2005 10:59:21 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: jffs-dev@axis.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/jffs/: misc cleanups
Message-ID: <20050216095921.GD3272@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- make some needlessly global code static
- #if 0 the following unused functions:
  - intrep.c: jffs_print_file
  - jffs_fm.c: jffs_print_node_ref

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 8 Jan 2005
- 24 Jan 2005

 fs/jffs/inode-v23.c  |   10 +++----
 fs/jffs/intrep.c     |   60 ++++++++++++++++++++++++++++++-------------
 fs/jffs/intrep.h     |   32 +---------------------
 fs/jffs/jffs_fm.c    |   12 ++++++--
 fs/jffs/jffs_fm.h    |    6 +---
 include/linux/jffs.h |    1 
 6 files changed, 61 insertions(+), 60 deletions(-)

--- linux-2.6.10-mm2-full/fs/jffs/inode-v23.c.old	2005-01-08 04:00:49.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/jffs/inode-v23.c	2005-01-08 04:01:36.000000000 +0100
@@ -334,7 +334,7 @@
 } /* jffs_notify_change()  */
 
 
-struct inode *
+static struct inode *
 jffs_new_inode(const struct inode * dir, struct jffs_raw_inode *raw_inode,
 	       int * err)
 {
@@ -376,7 +376,7 @@
 }
 
 /* Get statistics of the file system.  */
-int
+static int
 jffs_statfs(struct super_block *sb, struct kstatfs *buf)
 {
 	struct jffs_control *c = (struct jffs_control *) sb->s_fs_info;
@@ -410,7 +410,7 @@
 
 
 /* Rename a file.  */
-int
+static int
 jffs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	    struct inode *new_dir, struct dentry *new_dentry)
 {
@@ -1739,7 +1739,7 @@
 }
 
 
-void
+static void
 jffs_delete_inode(struct inode *inode)
 {
 	struct jffs_file *f;
@@ -1762,7 +1762,7 @@
 }
 
 
-void
+static void
 jffs_write_super(struct super_block *sb)
 {
 	struct jffs_control *c = (struct jffs_control *)sb->s_fs_info;
--- linux-2.6.10-mm2-full/fs/jffs/intrep.h.old	2005-01-08 04:02:44.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/jffs/intrep.h	2005-01-08 04:11:37.000000000 +0100
@@ -20,9 +20,6 @@
 struct jffs_node *jffs_alloc_node(void);
 void jffs_free_node(struct jffs_node *n);
 int jffs_get_node_inuse(void);
-long jffs_get_file_count(void);
-
-__u32 jffs_checksum(const void *data, int size);
 
 void jffs_cleanup_control(struct jffs_control *c);
 int jffs_build_fs(struct super_block *sb);
@@ -36,15 +33,9 @@
 void jffs_free_node(struct jffs_node *node);
 
 int jffs_foreach_file(struct jffs_control *c, int (*func)(struct jffs_file *));
-int jffs_free_node_list(struct jffs_file *f);
-int jffs_free_file(struct jffs_file *f);
 int jffs_possibly_delete_file(struct jffs_file *f);
-int jffs_build_file(struct jffs_file *f);
-int jffs_insert_file_into_hash(struct jffs_file *f);
 int jffs_insert_file_into_tree(struct jffs_file *f);
-int jffs_unlink_file_from_hash(struct jffs_file *f);
 int jffs_unlink_file_from_tree(struct jffs_file *f);
-int jffs_remove_redundant_nodes(struct jffs_file *f);
 int jffs_file_count(struct jffs_file *f);
 
 int jffs_write_node(struct jffs_control *c, struct jffs_node *node,
@@ -56,32 +47,13 @@
 /* Garbage collection stuff.  */
 int jffs_garbage_collect_thread(void *c);
 void jffs_garbage_collect_trigger(struct jffs_control *c);
-int jffs_garbage_collect_now(struct jffs_control *c);
-
-/* Is there enough space on the flash?  */
-static inline int JFFS_ENOUGH_SPACE(struct jffs_control *c, __u32 space)
-{
-	struct jffs_fmcontrol *fmc = c->fmc;
-
-	while (1) {
-		if ((fmc->flash_size - (fmc->used_size + fmc->dirty_size)) 
-			>= fmc->min_free_size + space) {
-			return 1;
-		}
-		if (fmc->dirty_size < fmc->sector_size)
-			return 0;
-
-		if (jffs_garbage_collect_now(c)) {
-		  D1(printk("JFFS_ENOUGH_SPACE: jffs_garbage_collect_now() failed.\n"));
-		  return 0;
-		}
-	}
-}
 
 /* For debugging purposes.  */
 void jffs_print_node(struct jffs_node *n);
 void jffs_print_raw_inode(struct jffs_raw_inode *raw_inode);
+#if 0
 int jffs_print_file(struct jffs_file *f);
+#endif  /*  0  */
 void jffs_print_hash_table(struct jffs_control *c);
 void jffs_print_tree(struct jffs_file *first_file, int indent);
 
--- linux-2.6.10-mm2-full/include/linux/jffs.h.old	2005-01-08 04:12:11.000000000 +0100
+++ linux-2.6.10-mm2-full/include/linux/jffs.h	2005-01-08 04:12:16.000000000 +0100
@@ -208,7 +208,6 @@
 #define JFFS_MEMORY_DEBUG 0
 
 extern long no_jffs_node;
-extern long no_jffs_file;
 #if defined(JFFS_MEMORY_DEBUG) && JFFS_MEMORY_DEBUG
 extern long no_jffs_control;
 extern long no_jffs_raw_inode;
--- linux-2.6.10-mm2-full/fs/jffs/intrep.c.old	2005-01-08 04:01:56.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/jffs/intrep.c	2005-01-08 04:12:28.000000000 +0100
@@ -72,7 +72,7 @@
 #include "jffs_fm.h"
 
 long no_jffs_node = 0;
-long no_jffs_file = 0;
+static long no_jffs_file = 0;
 #if defined(JFFS_MEMORY_DEBUG) && JFFS_MEMORY_DEBUG
 long no_jffs_control = 0;
 long no_jffs_raw_inode = 0;
@@ -85,6 +85,32 @@
 
 static int jffs_scan_flash(struct jffs_control *c);
 static int jffs_update_file(struct jffs_file *f, struct jffs_node *node);
+static int jffs_build_file(struct jffs_file *f);
+static int jffs_free_file(struct jffs_file *f);
+static int jffs_free_node_list(struct jffs_file *f);
+static int jffs_garbage_collect_now(struct jffs_control *c);
+static int jffs_insert_file_into_hash(struct jffs_file *f);
+static int jffs_remove_redundant_nodes(struct jffs_file *f);
+
+/* Is there enough space on the flash?  */
+static inline int JFFS_ENOUGH_SPACE(struct jffs_control *c, __u32 space)
+{
+	struct jffs_fmcontrol *fmc = c->fmc;
+
+	while (1) {
+		if ((fmc->flash_size - (fmc->used_size + fmc->dirty_size)) 
+			>= fmc->min_free_size + space) {
+			return 1;
+		}
+		if (fmc->dirty_size < fmc->sector_size)
+			return 0;
+
+		if (jffs_garbage_collect_now(c)) {
+		  D1(printk("JFFS_ENOUGH_SPACE: jffs_garbage_collect_now() failed.\n"));
+		  return 0;
+		}
+	}
+}
 
 #if CONFIG_JFFS_FS_VERBOSE > 0
 static __u8
@@ -331,7 +357,7 @@
 }
 
 /* This routine calculates checksums in JFFS.  */
-__u32
+static __u32
 jffs_checksum(const void *data, int size)
 {
 	__u32 sum = 0;
@@ -344,7 +370,7 @@
 }
 
 
-int
+static int
 jffs_checksum_flash(struct mtd_info *mtd, loff_t start, int size, __u32 *result)
 {
 	__u32 sum = 0;
@@ -646,7 +672,7 @@
   a (even) higher degree of confidence in your mount process. 
   A higher number would of course slow down your mount.
 */
-int check_partly_erased_sectors(struct jffs_fmcontrol *fmc){
+static int check_partly_erased_sectors(struct jffs_fmcontrol *fmc){
 
 #define NUM_REREADS             4 /* see note above */
 #define READ_AHEAD_BYTES        4096 /* must be a multiple of 4, 
@@ -1478,7 +1504,7 @@
 
 /* Remove redundant nodes from a file.  Mark the on-flash memory
    as dirty.  */
-int
+static int
 jffs_remove_redundant_nodes(struct jffs_file *f)
 {
 	struct jffs_node *newest_node;
@@ -1532,7 +1558,7 @@
 
 
 /* Insert a file into the hash table.  */
-int
+static int
 jffs_insert_file_into_hash(struct jffs_file *f)
 {
 	int i = f->ino % f->c->hash_len;
@@ -1580,7 +1606,7 @@
 
 
 /* Remove a file from the hash table.  */
-int
+static int
 jffs_unlink_file_from_hash(struct jffs_file *f)
 {
 	D3(printk("jffs_unlink_file_from_hash(): f: 0x%p, "
@@ -2038,7 +2064,7 @@
 
 
 /* Free all nodes associated with a file.  */
-int
+static int
 jffs_free_node_list(struct jffs_file *f)
 {
 	struct jffs_node *node;
@@ -2058,7 +2084,7 @@
 
 
 /* Free a file and its name.  */
-int
+static int
 jffs_free_file(struct jffs_file *f)
 {
 	D3(printk("jffs_free_file: f #%u, \"%s\"\n",
@@ -2073,7 +2099,7 @@
 	return 0;
 }
 
-long
+static long
 jffs_get_file_count(void)
 {
 	return no_jffs_file;
@@ -2127,7 +2153,7 @@
 
 /* Build up a file's range list from scratch by going through the
    version list.  */
-int
+static int
 jffs_build_file(struct jffs_file *f)
 {
 	struct jffs_node *n;
@@ -2481,7 +2507,6 @@
 	return 0;
 }
 
-
 /* Print the contents of a node.  */
 void
 jffs_print_node(struct jffs_node *n)
@@ -2541,6 +2566,7 @@
 
 
 /* Print the contents of a file.  */
+#if 0
 int
 jffs_print_file(struct jffs_file *f)
 {
@@ -2580,7 +2606,7 @@
 	D(printk("}\n"));
 	return 0;
 }
-
+#endif  /*  0  */
 
 void
 jffs_print_hash_table(struct jffs_control *c)
@@ -2655,7 +2681,7 @@
 
 
 /* Rewrite `size' bytes, and begin at `node'.  */
-int
+static int
 jffs_rewrite_data(struct jffs_file *f, struct jffs_node *node, __u32 size)
 {
 	struct jffs_control *c = f->c;
@@ -2858,7 +2884,7 @@
    process and is often called multiple times at each occasion of a
    garbage collect.  */
 
-int
+static int
 jffs_garbage_collect_next(struct jffs_control *c)
 {
 	struct jffs_fmcontrol *fmc = c->fmc;
@@ -3097,7 +3123,7 @@
 } /* jffs_clear_end_of_node()  */
 
 /* Try to erase as much as possible of the dirt in the flash memory.  */
-long
+static long
 jffs_try_to_erase(struct jffs_control *c)
 {
 	struct jffs_fmcontrol *fmc = c->fmc;
@@ -3198,7 +3224,7 @@
    collection can be.  */
 
 
-int
+static int
 jffs_garbage_collect_now(struct jffs_control *c)
 {
 	struct jffs_fmcontrol *fmc = c->fmc;
--- linux-2.6.10-mm2-full/fs/jffs/jffs_fm.h.old	2005-01-08 04:12:44.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/jffs/jffs_fm.h	2005-01-08 04:15:45.000000000 +0100
@@ -64,10 +64,6 @@
 
 
 
-void jffs_free_fm(struct jffs_fm *n);
-struct jffs_fm *jffs_alloc_fm(void);
-
-
 struct jffs_node_ref
 {
 	struct jffs_node *node;
@@ -145,6 +141,8 @@
 
 void jffs_print_fmcontrol(struct jffs_fmcontrol *fmc);
 void jffs_print_fm(struct jffs_fm *fm);
+#if 0
 void jffs_print_node_ref(struct jffs_node_ref *ref);
+#endif  /*  0  */
 
 #endif /* __LINUX_JFFS_FM_H__  */
--- linux-2.6.10-mm2-full/fs/jffs/jffs_fm.c.old	2005-01-08 04:12:57.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/jffs/jffs_fm.c	2005-01-08 04:16:02.000000000 +0100
@@ -25,6 +25,9 @@
 static int jffs_mark_obsolete(struct jffs_fmcontrol *fmc, __u32 fm_offset);
 #endif
 
+static struct jffs_fm *jffs_alloc_fm(void);
+static void jffs_free_fm(struct jffs_fm *n);
+
 extern kmem_cache_t     *fm_cache;
 extern kmem_cache_t     *node_cache;
 
@@ -602,7 +605,7 @@
 /* check if it's possible to erase the wanted range, and if not, return
  * the range that IS erasable, or a negative error code.
  */
-long
+static long
 jffs_flash_erasable_size(struct mtd_info *mtd, __u32 offset, __u32 size)
 {
          u_long ssize;
@@ -700,7 +703,7 @@
 	return (ret >= 0 ? ret : 0);
 }
 
-struct jffs_fm *jffs_alloc_fm(void)
+static struct jffs_fm *jffs_alloc_fm(void)
 {
 	struct jffs_fm *fm;
 
@@ -710,7 +713,7 @@
 	return fm;
 }
 
-void jffs_free_fm(struct jffs_fm *n)
+static void jffs_free_fm(struct jffs_fm *n)
 {
 	kmem_cache_free(fm_cache,n);
 	DJM(no_jffs_fm--);
@@ -778,6 +781,7 @@
 	D(printk("}\n"));
 }
 
+#if 0
 void
 jffs_print_node_ref(struct jffs_node_ref *ref)
 {
@@ -787,3 +791,5 @@
 	D(printk("       0x%p, /* next  */\n", ref->next));
 	D(printk("}\n"));
 }
+#endif  /*  0  */
+

