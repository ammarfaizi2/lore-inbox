Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265742AbSKFP4L>; Wed, 6 Nov 2002 10:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265737AbSKFP4L>; Wed, 6 Nov 2002 10:56:11 -0500
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:55493 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S265742AbSKFP4H>; Wed, 6 Nov 2002 10:56:07 -0500
Message-ID: <3DC93D22.8050507@quark.didntduck.org>
Date: Wed, 06 Nov 2002 11:02:42 -0500
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] use mempool_alloc_slab
Content-Type: multipart/mixed;
 boundary="------------010701060107090706030405"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010701060107090706030405
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Switches several mempools to use mempool_alloc_slab() instead of local 
duplicates.

--
				Brian Gerst

--------------010701060107090706030405
Content-Type: text/plain;
 name="mempool_alloc_slab-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mempool_alloc_slab-1"

diff -urN linux-2.5.46-bk3/drivers/scsi/scsi.c linux/drivers/scsi/scsi.c
--- linux-2.5.46-bk3/drivers/scsi/scsi.c	Tue Nov  5 18:31:34 2002
+++ linux/drivers/scsi/scsi.c	Tue Nov  5 19:17:57 2002
@@ -2215,16 +2215,6 @@
 __setup("scsihosts=", scsi_setup);
 #endif
 
-static void *scsi_pool_alloc(int gfp_mask, void *data)
-{
-	return kmem_cache_alloc(data, gfp_mask);
-}
-
-static void scsi_pool_free(void *ptr, void *data)
-{
-	kmem_cache_free(data, ptr);
-}
-
 struct scatterlist *scsi_alloc_sgtable(Scsi_Cmnd *SCpnt, int gfp_mask)
 {
 	struct scsi_host_sg_pool *sgp;
@@ -2314,7 +2304,7 @@
 		if (!sgp->slab)
 			panic("SCSI: can't init sg slab\n");
 
-		sgp->pool = mempool_create(SG_MEMPOOL_SIZE, scsi_pool_alloc, scsi_pool_free, sgp->slab);
+		sgp->pool = mempool_create(SG_MEMPOOL_SIZE, mempool_alloc_slab, mempool_free_slab, sgp->slab);
 		if (!sgp->pool)
 			panic("SCSI: can't init sg mempool\n");
 	}
diff -urN linux-2.5.46-bk3/fs/bio.c linux/fs/bio.c
--- linux-2.5.46-bk3/fs/bio.c	Wed Oct 30 20:30:19 2002
+++ linux/fs/bio.c	Tue Nov  5 19:26:07 2002
@@ -51,16 +51,6 @@
 };
 #undef BV
 
-static void *slab_pool_alloc(int gfp_mask, void *data)
-{
-	return kmem_cache_alloc(data, gfp_mask);
-}
-
-static void slab_pool_free(void *ptr, void *data)
-{
-	kmem_cache_free(data, ptr);
-}
-
 static inline struct bio_vec *bvec_alloc(int gfp_mask, int nr, unsigned long *idx)
 {
 	struct biovec_pool *bp;
@@ -644,8 +634,8 @@
 		if (i >= scale)
 			pool_entries >>= 1;
 
-		bp->pool = mempool_create(pool_entries, slab_pool_alloc,
-					slab_pool_free, bp->slab);
+		bp->pool = mempool_create(pool_entries, mempool_alloc_slab,
+					mempool_free_slab, bp->slab);
 		if (!bp->pool)
 			panic("biovec: can't init mempool\n");
 
@@ -661,7 +651,7 @@
 					SLAB_HWCACHE_ALIGN, NULL, NULL);
 	if (!bio_slab)
 		panic("bio: can't create slab cache\n");
-	bio_pool = mempool_create(BIO_POOL_SIZE, slab_pool_alloc, slab_pool_free, bio_slab);
+	bio_pool = mempool_create(BIO_POOL_SIZE, mempool_alloc_slab, mempool_free_slab, bio_slab);
 	if (!bio_pool)
 		panic("bio: can't create mempool\n");
 
diff -urN linux-2.5.46-bk3/fs/buffer.c linux/fs/buffer.c
--- linux-2.5.46-bk3/fs/buffer.c	Wed Oct 30 20:30:19 2002
+++ linux/fs/buffer.c	Tue Nov  5 19:23:22 2002
@@ -2620,16 +2620,6 @@
 	}
 }
 
-static void *bh_mempool_alloc(int gfp_mask, void *pool_data)
-{
-	return kmem_cache_alloc(bh_cachep, gfp_mask);
-}
-
-static void bh_mempool_free(void *element, void *pool_data)
-{
-	return kmem_cache_free(bh_cachep, element);
-}
-
 #define NR_RESERVED (10*MAX_BUF_PER_PAGE)
 #define MAX_UNUSED_BUFFERS NR_RESERVED+20
 
@@ -2669,8 +2659,8 @@
 	bh_cachep = kmem_cache_create("buffer_head",
 			sizeof(struct buffer_head), 0,
 			0, init_buffer_head, NULL);
-	bh_mempool = mempool_create(MAX_UNUSED_BUFFERS, bh_mempool_alloc,
-				bh_mempool_free, NULL);
+	bh_mempool = mempool_create(MAX_UNUSED_BUFFERS, mempool_alloc_slab,
+				mempool_free_slab, bh_cachep);
 	for (i = 0; i < ARRAY_SIZE(bh_wait_queue_heads); i++)
 		init_waitqueue_head(&bh_wait_queue_heads[i].wqh);
 
diff -urN linux-2.5.46-bk3/fs/jfs/jfs_metapage.c linux/fs/jfs/jfs_metapage.c
--- linux-2.5.46-bk3/fs/jfs/jfs_metapage.c	Sun Sep 15 22:18:24 2002
+++ linux/fs/jfs/jfs_metapage.c	Tue Nov  5 19:22:37 2002
@@ -120,15 +120,6 @@
 	mempool_free(mp, metapage_mempool);
 }
 
-static void *mp_mempool_alloc(int gfp_mask, void *pool_data)
-{
-	return kmem_cache_alloc(metapage_cache, gfp_mask);
-}
-static void mp_mempool_free(void *element, void *pool_data)
-{
-	return kmem_cache_free(metapage_cache, element);
-}
-
 int __init metapage_init(void)
 {
 	/*
@@ -139,8 +130,8 @@
 	if (metapage_cache == NULL)
 		return -ENOMEM;
 
-	metapage_mempool = mempool_create(METAPOOL_MIN_PAGES, mp_mempool_alloc,
-					  mp_mempool_free, NULL);
+	metapage_mempool = mempool_create(METAPOOL_MIN_PAGES, mempool_alloc_slab,
+					  mempool_free_slab, metapage_cache);
 
 	if (metapage_mempool == NULL) {
 		kmem_cache_destroy(metapage_cache);
diff -urN linux-2.5.46-bk3/lib/radix-tree.c linux/lib/radix-tree.c
--- linux-2.5.46-bk3/lib/radix-tree.c	Wed Oct 30 20:30:22 2002
+++ linux/lib/radix-tree.c	Tue Nov  5 19:27:01 2002
@@ -343,16 +343,6 @@
 	memset(node, 0, sizeof(struct radix_tree_node));
 }
 
-static void *radix_tree_node_pool_alloc(int gfp_mask, void *data)
-{
-	return kmem_cache_alloc(radix_tree_node_cachep, gfp_mask);
-}
-
-static void radix_tree_node_pool_free(void *node, void *data)
-{
-	kmem_cache_free(radix_tree_node_cachep, node);
-}
-
 /*
  * FIXME!  512 nodes is 200-300k of memory.  This needs to be
  * scaled by the amount of available memory, and hopefully
@@ -365,8 +355,8 @@
 			SLAB_HWCACHE_ALIGN, radix_tree_node_ctor, NULL);
 	if (!radix_tree_node_cachep)
 		panic ("Failed to create radix_tree_node cache\n");
-	radix_tree_node_pool = mempool_create(512, radix_tree_node_pool_alloc,
-			radix_tree_node_pool_free, NULL);
+	radix_tree_node_pool = mempool_create(512, mempool_alloc_slab,
+			mempool_free_slab, radix_tree_node_cachep);
 	if (!radix_tree_node_pool)
 		panic ("Failed to create radix_tree_node pool\n");
 }

--------------010701060107090706030405--

