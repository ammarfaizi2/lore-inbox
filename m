Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965007AbWA3VXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965007AbWA3VXr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 16:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965004AbWA3VXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 16:23:46 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:50891 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S965012AbWA3VXp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 16:23:45 -0500
Subject: [patch 2/8] mempool - Use common mempool page allocator
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: linux-kernel@vger.kernel.org
Cc: penberg@cs.helsinki.fi, akpm@osdl.org
References: <20060130211951.225129000@localhost.localdomain>
Content-Type: text/plain
Organization: IBM LTC
Date: Mon, 30 Jan 2006 13:23:42 -0800
Message-Id: <1138656223.20704.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (mempool-use_page_allocator.patch)
Convert two mempool users that currently use their own mempool-backed page
allocators to use the generic mempool page allocator.

Also included are 2 trivial whitespace fixes.

Signed-off-by: Matthew Dobson <colpatch@us.ibm.com>

 drivers/md/dm-crypt.c |   17 +----------------
 mm/highmem.c          |   23 +++++++----------------
 2 files changed, 8 insertions(+), 32 deletions(-)

Index: linux-2.6.16-rc1-mm4+mempool_work/drivers/md/dm-crypt.c
===================================================================
--- linux-2.6.16-rc1-mm4+mempool_work.orig/drivers/md/dm-crypt.c
+++ linux-2.6.16-rc1-mm4+mempool_work/drivers/md/dm-crypt.c
@@ -94,20 +94,6 @@ struct crypt_config {
 static kmem_cache_t *_crypt_io_pool;
 
 /*
- * Mempool alloc and free functions for the page
- */
-static void *mempool_alloc_page(gfp_t gfp_mask, void *data)
-{
-	return alloc_page(gfp_mask);
-}
-
-static void mempool_free_page(void *page, void *data)
-{
-	__free_page(page);
-}
-
-
-/*
  * Different IV generation algorithms:
  *
  * plain: the initial vector is the 32-bit low-endian version of the sector
@@ -637,8 +623,7 @@ static int crypt_ctr(struct dm_target *t
 		goto bad3;
 	}
 
-	cc->page_pool = mempool_create(MIN_POOL_PAGES, mempool_alloc_page,
-				       mempool_free_page, NULL);
+	cc->page_pool = mempool_create_page_pool(MIN_POOL_PAGES, 0);
 	if (!cc->page_pool) {
 		ti->error = PFX "Cannot allocate page mempool";
 		goto bad4;
Index: linux-2.6.16-rc1-mm4+mempool_work/mm/highmem.c
===================================================================
--- linux-2.6.16-rc1-mm4+mempool_work.orig/mm/highmem.c
+++ linux-2.6.16-rc1-mm4+mempool_work/mm/highmem.c
@@ -31,14 +31,9 @@
 
 static mempool_t *page_pool, *isa_page_pool;
 
-static void *page_pool_alloc_isa(gfp_t gfp_mask, void *data)
+static void *mempool_alloc_pages_isa(gfp_t gfp_mask, void *data)
 {
-	return alloc_page(gfp_mask | GFP_DMA);
-}
-
-static void page_pool_free(void *page, void *data)
-{
-	__free_page(page);
+	return mempool_alloc_pages(gfp_mask | GFP_DMA, data);
 }
 
 /*
@@ -51,11 +46,6 @@ static void page_pool_free(void *page, v
  */
 #ifdef CONFIG_HIGHMEM
 
-static void *page_pool_alloc(gfp_t gfp_mask, void *data)
-{
-	return alloc_page(gfp_mask);
-}
-
 static int pkmap_count[LAST_PKMAP];
 static unsigned int last_pkmap_nr;
 static  __cacheline_aligned_in_smp DEFINE_SPINLOCK(kmap_lock);
@@ -229,7 +219,7 @@ static __init int init_emergency_pool(vo
 	if (!i.totalhigh)
 		return 0;
 
-	page_pool = mempool_create(POOL_SIZE, page_pool_alloc, page_pool_free, NULL);
+	page_pool = mempool_create_page_pool(POOL_SIZE, 0);
 	if (!page_pool)
 		BUG();
 	printk("highmem bounce pool size: %d pages\n", POOL_SIZE);
@@ -272,7 +262,8 @@ int init_emergency_isa_pool(void)
 	if (isa_page_pool)
 		return 0;
 
-	isa_page_pool = mempool_create(ISA_POOL_SIZE, page_pool_alloc_isa, page_pool_free, NULL);
+	isa_page_pool = mempool_create(ISA_POOL_SIZE, mempool_alloc_pages_isa,
+				       mempool_free_pages, (void *) 0);
 	if (!isa_page_pool)
 		BUG();
 
@@ -337,7 +328,7 @@ static void bounce_end_io(struct bio *bi
 	bio_put(bio);
 }
 
-static int bounce_end_io_write(struct bio *bio, unsigned int bytes_done,int err)
+static int bounce_end_io_write(struct bio *bio, unsigned int bytes_done, int err)
 {
 	if (bio->bi_size)
 		return 1;
@@ -384,7 +375,7 @@ static int bounce_end_io_read_isa(struct
 }
 
 static void __blk_queue_bounce(request_queue_t *q, struct bio **bio_orig,
-			mempool_t *pool)
+			       mempool_t *pool)
 {
 	struct page *page;
 	struct bio *bio = NULL;

--

