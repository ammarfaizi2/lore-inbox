Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261566AbVAMKmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbVAMKmm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 05:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261574AbVAMKl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 05:41:58 -0500
Received: from ns.suse.de ([195.135.220.2]:60822 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261561AbVAMKkx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 05:40:53 -0500
Date: Thu, 13 Jan 2005 11:31:43 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Alex Tomas <alex@clusterfs.com>,
       Andreas Dilger <adilger@clusterfs.com>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Andrew Tridgell <tridge@samba.org>
Subject: [RESEND][PATCH 2/9] Ext3: extended attribute sharing fixes and in-inode EAs
Message-Id: <1105549936.775354@suse.de>
References: <1105549936.694778@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mbcache cleanup

There is no need to export struct mb_cache outside mbcache.c. Move
struct mb_cache to fs/mbcache.c and remove the superfluous struct
mb_cache_entry_index declaration.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.10/fs/mbcache.c
===================================================================
--- linux-2.6.10.orig/fs/mbcache.c
+++ linux-2.6.10/fs/mbcache.c
@@ -72,6 +72,20 @@ EXPORT_SYMBOL(mb_cache_entry_find_first)
 EXPORT_SYMBOL(mb_cache_entry_find_next);
 #endif
 
+struct mb_cache {
+	struct list_head		c_cache_list;
+	const char			*c_name;
+	struct mb_cache_op		c_op;
+	atomic_t			c_entry_count;
+	int				c_bucket_bits;
+#ifndef MB_CACHE_INDEXES_COUNT
+	int				c_indexes_count;
+#endif
+	kmem_cache_t			*c_entry_cache;
+	struct list_head		*c_block_hash;
+	struct list_head		*c_indexes_hash[0];
+};
+
 
 /*
  * Global data: list of all mbcache's, lru list, and a spinlock for
@@ -229,7 +243,7 @@ mb_cache_create(const char *name, struct
 	struct mb_cache *cache = NULL;
 
 	if(entry_size < sizeof(struct mb_cache_entry) +
-	   indexes_count * sizeof(struct mb_cache_entry_index))
+	   indexes_count * sizeof(((struct mb_cache_entry *) 0)->e_indexes[0]))
 		return NULL;
 
 	cache = kmalloc(sizeof(struct mb_cache) +
Index: linux-2.6.10/include/linux/mbcache.h
===================================================================
--- linux-2.6.10.orig/include/linux/mbcache.h
+++ linux-2.6.10/include/linux/mbcache.h
@@ -7,31 +7,6 @@
 /* Hardwire the number of additional indexes */
 #define MB_CACHE_INDEXES_COUNT 1
 
-struct mb_cache_entry;
-
-struct mb_cache_op {
-	int (*free)(struct mb_cache_entry *, int);
-};
-
-struct mb_cache {
-	struct list_head		c_cache_list;
-	const char			*c_name;
-	struct mb_cache_op		c_op;
-	atomic_t			c_entry_count;
-	int				c_bucket_bits;
-#ifndef MB_CACHE_INDEXES_COUNT
-	int				c_indexes_count;
-#endif
-	kmem_cache_t			*c_entry_cache;
-	struct list_head		*c_block_hash;
-	struct list_head		*c_indexes_hash[0];
-};
-
-struct mb_cache_entry_index {
-	struct list_head		o_list;
-	unsigned int			o_key;
-};
-
 struct mb_cache_entry {
 	struct list_head		e_lru_list;
 	struct mb_cache			*e_cache;
@@ -39,7 +14,14 @@ struct mb_cache_entry {
 	struct block_device		*e_bdev;
 	sector_t			e_block;
 	struct list_head		e_block_list;
-	struct mb_cache_entry_index	e_indexes[0];
+	struct {
+		struct list_head	o_list;
+		unsigned int		o_key;
+	} e_indexes[0];
+};
+
+struct mb_cache_op {
+	int (*free)(struct mb_cache_entry *, int);
 };
 
 /* Functions on caches */
@@ -54,7 +36,6 @@ void mb_cache_destroy(struct mb_cache *)
 struct mb_cache_entry *mb_cache_entry_alloc(struct mb_cache *);
 int mb_cache_entry_insert(struct mb_cache_entry *, struct block_device *,
 			  sector_t, unsigned int[]);
-void mb_cache_entry_rehash(struct mb_cache_entry *, unsigned int[]);
 void mb_cache_entry_release(struct mb_cache_entry *);
 void mb_cache_entry_free(struct mb_cache_entry *);
 struct mb_cache_entry *mb_cache_entry_get(struct mb_cache *,
Index: linux-2.6.10/fs/ext3/xattr.c
===================================================================
--- linux-2.6.10.orig/fs/ext3/xattr.c
+++ linux-2.6.10/fs/ext3/xattr.c
@@ -1080,7 +1080,7 @@ init_ext3_xattr(void)
 {
 	ext3_xattr_cache = mb_cache_create("ext3_xattr", NULL,
 		sizeof(struct mb_cache_entry) +
-		sizeof(struct mb_cache_entry_index), 1, 6);
+		sizeof(((struct mb_cache_entry *) 0)->e_indexes[0]), 1, 6);
 	if (!ext3_xattr_cache)
 		return -ENOMEM;
 	return 0;
Index: linux-2.6.10/fs/ext2/xattr.c
===================================================================
--- linux-2.6.10.orig/fs/ext2/xattr.c
+++ linux-2.6.10/fs/ext2/xattr.c
@@ -1016,7 +1016,7 @@ init_ext2_xattr(void)
 {
 	ext2_xattr_cache = mb_cache_create("ext2_xattr", NULL,
 		sizeof(struct mb_cache_entry) +
-		sizeof(struct mb_cache_entry_index), 1, 6);
+		sizeof(((struct mb_cache_entry *) 0)->e_indexes[0]), 1, 6);
 	if (!ext2_xattr_cache)
 		return -ENOMEM;
 	return 0;
--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH

