Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267524AbTBUXK1>; Fri, 21 Feb 2003 18:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267801AbTBUXK1>; Fri, 21 Feb 2003 18:10:27 -0500
Received: from sccrmhc02.attbi.com ([204.127.202.62]:58563 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S267524AbTBUXKZ>; Fri, 21 Feb 2003 18:10:25 -0500
Message-ID: <3E56B428.7080505@quark.didntduck.org>
Date: Fri, 21 Feb 2003 18:20:08 -0500
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Use mempool_alloc/free_slab
Content-Type: multipart/mixed;
 boundary="------------020705080502050607010607"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020705080502050607010607
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Convert fs/bio.c and fs/jfs/jfs_metapage.c to use the mempool_alloc_slab 
and mempool_free_slab helper functions.

--
				Brian Gerst

--------------020705080502050607010607
Content-Type: text/plain;
 name="mempool_alloc_slab-3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mempool_alloc_slab-3"

diff -urN linux-2.5.62-bk6/fs/bio.c linux/fs/bio.c
--- linux-2.5.62-bk6/fs/bio.c	2003-01-13 16:20:57.000000000 -0500
+++ linux/fs/bio.c	2003-02-21 08:48:11.000000000 -0500
@@ -52,16 +52,6 @@
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
@@ -749,8 +739,8 @@
 		if (i >= scale)
 			pool_entries >>= 1;
 
-		bp->pool = mempool_create(pool_entries, slab_pool_alloc,
-					slab_pool_free, bp->slab);
+		bp->pool = mempool_create(pool_entries, mempool_alloc_slab,
+					mempool_free_slab, bp->slab);
 		if (!bp->pool)
 			panic("biovec: can't init mempool\n");
 
@@ -766,7 +756,7 @@
 					SLAB_HWCACHE_ALIGN, NULL, NULL);
 	if (!bio_slab)
 		panic("bio: can't create slab cache\n");
-	bio_pool = mempool_create(BIO_POOL_SIZE, slab_pool_alloc, slab_pool_free, bio_slab);
+	bio_pool = mempool_create(BIO_POOL_SIZE, mempool_alloc_slab, mempool_free_slab, bio_slab);
 	if (!bio_pool)
 		panic("bio: can't create mempool\n");
 
diff -urN linux-2.5.62-bk6/fs/jfs/jfs_metapage.c linux/fs/jfs/jfs_metapage.c
--- linux-2.5.62-bk6/fs/jfs/jfs_metapage.c	2003-02-10 14:22:17.000000000 -0500
+++ linux/fs/jfs/jfs_metapage.c	2003-02-21 08:48:11.000000000 -0500
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

--------------020705080502050607010607--

