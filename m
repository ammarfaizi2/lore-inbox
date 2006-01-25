Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbWAYVhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbWAYVhy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 16:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWAYVhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 16:37:18 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:61901 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751207AbWAYVhH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 16:37:07 -0500
Subject: [patch 5/9] mempool - Update kmalloc mempool users
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: linux-kernel@vger.kernel.org
Cc: sri@us.ibm.com, andrea@suse.de, pavel@suse.cz, linux-mm@kvack.org
References: <20060125161321.647368000@localhost.localdomain>
Content-Type: text/plain
Organization: IBM LTC
Date: Wed, 25 Jan 2006 11:40:10 -0800
Message-Id: <1138218010.2092.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (critical_mempools)
Fixup existing mempool users to use the new mempool API, part 2.

This patch fixes up all the trivial mempool users, all of which are basically
currently just wrappers around kmalloc().  Change these functions to 
call kmalloc_node() with their shiny new 'node_id' argument.

Possible further work:  Many of these functions could be replaced by a single
common mempool_kmalloc() function, storing the size to kmalloc in pool_data.

Signed-off-by: Matthew Dobson <colpatch@us.ibm.com>

 drivers/block/pktcdvd.c      |    8 ++++----
 drivers/md/bitmap.c          |    6 +++---
 drivers/md/dm-io.c           |    4 ++--
 drivers/md/dm-raid1.c        |    4 ++--
 drivers/s390/scsi/zfcp_aux.c |    4 ++--
 drivers/scsi/lpfc/lpfc_mem.c |    4 ++--
 fs/bio.c                     |   12 ++++++------
 7 files changed, 21 insertions(+), 21 deletions(-)

Index: linux-2.6.16-rc1+critical_mempools/drivers/block/pktcdvd.c
===================================================================
--- linux-2.6.16-rc1+critical_mempools.orig/drivers/block/pktcdvd.c
+++ linux-2.6.16-rc1+critical_mempools/drivers/block/pktcdvd.c
@@ -229,9 +229,9 @@ static int pkt_grow_pktlist(struct pktcd
 	return 1;
 }
 
-static void *pkt_rb_alloc(gfp_t gfp_mask, void *data)
+static void *pkt_rb_alloc(gfp_t gfp_mask, int nid, void *data)
 {
-	return kmalloc(sizeof(struct pkt_rb_node), gfp_mask);
+	return kmalloc_node(sizeof(struct pkt_rb_node), gfp_mask, nid);
 }
 
 static void pkt_rb_free(void *ptr, void *data)
@@ -2085,9 +2085,9 @@ static int pkt_close(struct inode *inode
 }
 

-static void *psd_pool_alloc(gfp_t gfp_mask, void *data)
+static void *psd_pool_alloc(gfp_t gfp_mask, int nid, void *data)
 {
-	return kmalloc(sizeof(struct packet_stacked_data), gfp_mask);
+	return kmalloc_node(sizeof(struct packet_stacked_data), gfp_mask, nid);
 }
 
 static void psd_pool_free(void *ptr, void *data)
Index: linux-2.6.16-rc1+critical_mempools/drivers/scsi/lpfc/lpfc_mem.c
===================================================================
--- linux-2.6.16-rc1+critical_mempools.orig/drivers/scsi/lpfc/lpfc_mem.c
+++ linux-2.6.16-rc1+critical_mempools/drivers/scsi/lpfc/lpfc_mem.c
@@ -39,9 +39,9 @@
 #define LPFC_MEM_POOL_SIZE      64      /* max elem in non-DMA safety pool */
 
 static void *
-lpfc_pool_kmalloc(gfp_t gfp_flags, void *data)
+lpfc_pool_kmalloc(gfp_t gfp_flags, int nid, void *data)
 {
-	return kmalloc((unsigned long)data, gfp_flags);
+	return kmalloc_node((unsigned long)data, gfp_flags, nid);
 }
 
 static void
Index: linux-2.6.16-rc1+critical_mempools/drivers/md/dm-raid1.c
===================================================================
--- linux-2.6.16-rc1+critical_mempools.orig/drivers/md/dm-raid1.c
+++ linux-2.6.16-rc1+critical_mempools/drivers/md/dm-raid1.c
@@ -122,9 +122,9 @@ static inline sector_t region_to_sector(
 /* FIXME move this */
 static void queue_bio(struct mirror_set *ms, struct bio *bio, int rw);
 
-static void *region_alloc(gfp_t gfp_mask, void *pool_data)
+static void *region_alloc(gfp_t gfp_mask, int nid, void *pool_data)
 {
-	return kmalloc(sizeof(struct region), gfp_mask);
+	return kmalloc_node(sizeof(struct region), gfp_mask, nid);
 }
 
 static void region_free(void *element, void *pool_data)
Index: linux-2.6.16-rc1+critical_mempools/drivers/s390/scsi/zfcp_aux.c
===================================================================
--- linux-2.6.16-rc1+critical_mempools.orig/drivers/s390/scsi/zfcp_aux.c
+++ linux-2.6.16-rc1+critical_mempools/drivers/s390/scsi/zfcp_aux.c
@@ -832,9 +832,9 @@ zfcp_unit_dequeue(struct zfcp_unit *unit
 }
 
 static void *
-zfcp_mempool_alloc(gfp_t gfp_mask, void *size)
+zfcp_mempool_alloc(gfp_t gfp_mask, int nid, void *size)
 {
-	return kmalloc((size_t) size, gfp_mask);
+	return kmalloc_node((size_t) size, gfp_mask, nid);
 }
 
 static void
Index: linux-2.6.16-rc1+critical_mempools/drivers/md/dm-io.c
===================================================================
--- linux-2.6.16-rc1+critical_mempools.orig/drivers/md/dm-io.c
+++ linux-2.6.16-rc1+critical_mempools/drivers/md/dm-io.c
@@ -32,9 +32,9 @@ struct io {
 static unsigned _num_ios;
 static mempool_t *_io_pool;
 
-static void *alloc_io(gfp_t gfp_mask, void *pool_data)
+static void *alloc_io(gfp_t gfp_mask, int nid, void *pool_data)
 {
-	return kmalloc(sizeof(struct io), gfp_mask);
+	return kmalloc_node(sizeof(struct io), gfp_mask, nid);
 }
 
 static void free_io(void *element, void *pool_data)
Index: linux-2.6.16-rc1+critical_mempools/drivers/md/bitmap.c
===================================================================
--- linux-2.6.16-rc1+critical_mempools.orig/drivers/md/bitmap.c
+++ linux-2.6.16-rc1+critical_mempools/drivers/md/bitmap.c
@@ -90,9 +90,9 @@ int bitmap_active(struct bitmap *bitmap)
 
 #define WRITE_POOL_SIZE 256
 /* mempool for queueing pending writes on the bitmap file */
-static void *write_pool_alloc(gfp_t gfp_flags, void *data)
+static void *write_pool_alloc(gfp_t gfp_flags, int nid, void *data)
 {
-	return kmalloc(sizeof(struct page_list), gfp_flags);
+	return kmalloc_node(sizeof(struct page_list), gfp_flags, nid);
 }
 
 static void write_pool_free(void *ptr, void *data)
@@ -1565,7 +1565,7 @@ int bitmap_create(mddev_t *mddev)
 	INIT_LIST_HEAD(&bitmap->complete_pages);
 	init_waitqueue_head(&bitmap->write_wait);
 	bitmap->write_pool = mempool_create(WRITE_POOL_SIZE, write_pool_alloc,
-				write_pool_free, NULL);
+					    write_pool_free, NULL);
 	err = -ENOMEM;
 	if (!bitmap->write_pool)
 		goto error;
Index: linux-2.6.16-rc1+critical_mempools/fs/bio.c
===================================================================
--- linux-2.6.16-rc1+critical_mempools.orig/fs/bio.c
+++ linux-2.6.16-rc1+critical_mempools/fs/bio.c
@@ -1122,9 +1122,9 @@ struct bio_pair *bio_split(struct bio *b
 	return bp;
 }
 
-static void *bio_pair_alloc(gfp_t gfp_flags, void *data)
+static void *bio_pair_alloc(gfp_t gfp_flags, int nid, void *data)
 {
-	return kmalloc(sizeof(struct bio_pair), gfp_flags);
+	return kmalloc_node(sizeof(struct bio_pair), gfp_flags, nid);
 }
 
 static void bio_pair_free(void *bp, void *data)
@@ -1149,7 +1149,7 @@ static int biovec_create_pools(struct bi
 			pool_entries >>= 1;
 
 		*bvp = mempool_create(pool_entries, mempool_alloc_slab,
-					mempool_free_slab, bp->slab);
+				      mempool_free_slab, bp->slab);
 		if (!*bvp)
 			return -ENOMEM;
 	}
@@ -1188,7 +1188,7 @@ struct bio_set *bioset_create(int bio_po
 
 	memset(bs, 0, sizeof(*bs));
 	bs->bio_pool = mempool_create(bio_pool_size, mempool_alloc_slab,
-			mempool_free_slab, bio_slab);
+				      mempool_free_slab, bio_slab);
 
 	if (!bs->bio_pool)
 		goto bad;
@@ -1252,8 +1252,8 @@ static int __init init_bio(void)
 	if (!fs_bio_set)
 		panic("bio: can't allocate bios\n");
 
-	bio_split_pool = mempool_create(BIO_SPLIT_ENTRIES,
-				bio_pair_alloc, bio_pair_free, NULL);
+	bio_split_pool = mempool_create(BIO_SPLIT_ENTRIES, bio_pair_alloc,
+					    bio_pair_free, NULL);
 	if (!bio_split_pool)
 		panic("bio: can't create split pool\n");
 

--

