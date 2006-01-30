Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965004AbWA3VX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965004AbWA3VX6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 16:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965016AbWA3VX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 16:23:58 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:38020 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S965004AbWA3VX4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 16:23:56 -0500
Subject: [patch 4/8] mempool - Use common mempool kmalloc allocator
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: linux-kernel@vger.kernel.org
Cc: penberg@cs.helsinki.fi, akpm@osdl.org
References: <20060130211951.225129000@localhost.localdomain>
Content-Type: text/plain
Organization: IBM LTC
Date: Mon, 30 Jan 2006 13:23:53 -0800
Message-Id: <1138656233.20704.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (mempool-use_kmalloc_allocator.patch)
This patch changes several mempool users, all of which are basically
just wrappers around kmalloc(), to use the common mempool_kmalloc/kfree,
rather than their own wrapper function, removing a bunch of duplicated code.

Signed-off-by: Matthew Dobson <colpatch@us.ibm.com>

 drivers/block/pktcdvd.c      |   26 ++----------------
 drivers/md/bitmap.c          |   14 +---------
 drivers/md/dm-io.c           |   13 +--------
 drivers/md/dm-raid1.c        |   14 +---------
 drivers/s390/scsi/zfcp_aux.c |   60 ++++++++++++-------------------------------
 drivers/scsi/lpfc/lpfc_mem.c |   22 ++-------------
 fs/bio.c                     |   14 +---------
 7 files changed, 34 insertions(+), 129 deletions(-)

Index: linux-2.6.16-rc1-mm4+mempool_work/drivers/block/pktcdvd.c
===================================================================
--- linux-2.6.16-rc1-mm4+mempool_work.orig/drivers/block/pktcdvd.c
+++ linux-2.6.16-rc1-mm4+mempool_work/drivers/block/pktcdvd.c
@@ -230,16 +230,6 @@ static int pkt_grow_pktlist(struct pktcd
 	return 1;
 }
 
-static void *pkt_rb_alloc(gfp_t gfp_mask, void *data)
-{
-	return kmalloc(sizeof(struct pkt_rb_node), gfp_mask);
-}
-
-static void pkt_rb_free(void *ptr, void *data)
-{
-	kfree(ptr);
-}
-
 static inline struct pkt_rb_node *pkt_rbtree_next(struct pkt_rb_node *node)
 {
 	struct rb_node *n = rb_next(&node->rb_node);
@@ -2086,16 +2076,6 @@ static int pkt_close(struct inode *inode
 }
 

-static void *psd_pool_alloc(gfp_t gfp_mask, void *data)
-{
-	return kmalloc(sizeof(struct packet_stacked_data), gfp_mask);
-}
-
-static void psd_pool_free(void *ptr, void *data)
-{
-	kfree(ptr);
-}
-
 static int pkt_end_io_read_cloned(struct bio *bio, unsigned int bytes_done, int err)
 {
 	struct packet_stacked_data *psd = bio->bi_private;
@@ -2495,7 +2475,8 @@ static int pkt_setup_dev(struct pkt_ctrl
 	if (!pd)
 		return ret;
 
-	pd->rb_pool = mempool_create(PKT_RB_POOL_SIZE, pkt_rb_alloc, pkt_rb_free, NULL);
+	pd->rb_pool = mempool_create_kmalloc_pool(PKT_RB_POOL_SIZE,
+						  sizeof(struct pkt_rb_node));
 	if (!pd->rb_pool)
 		goto out_mem;
 
@@ -2657,7 +2638,8 @@ static int __init pkt_init(void)
 {
 	int ret;
 
-	psd_pool = mempool_create(PSD_POOL_SIZE, psd_pool_alloc, psd_pool_free, NULL);
+	psd_pool = mempool_create_kmalloc_pool(PSD_POOL_SIZE,
+					sizeof(struct packet_stacked_data));
 	if (!psd_pool)
 		return -ENOMEM;
 
Index: linux-2.6.16-rc1-mm4+mempool_work/drivers/scsi/lpfc/lpfc_mem.c
===================================================================
--- linux-2.6.16-rc1-mm4+mempool_work.orig/drivers/scsi/lpfc/lpfc_mem.c
+++ linux-2.6.16-rc1-mm4+mempool_work/drivers/scsi/lpfc/lpfc_mem.c
@@ -38,18 +38,6 @@
 #define LPFC_MBUF_POOL_SIZE     64      /* max elements in MBUF safety pool */
 #define LPFC_MEM_POOL_SIZE      64      /* max elem in non-DMA safety pool */
 
-static void *
-lpfc_pool_kmalloc(gfp_t gfp_flags, void *data)
-{
-	return kmalloc((unsigned long)data, gfp_flags);
-}
-
-static void
-lpfc_pool_kfree(void *obj, void *data)
-{
-	kfree(obj);
-}
-
 int
 lpfc_mem_alloc(struct lpfc_hba * phba)
 {
@@ -79,15 +67,13 @@ lpfc_mem_alloc(struct lpfc_hba * phba)
 		pool->current_count++;
 	}
 
-	phba->mbox_mem_pool = mempool_create(LPFC_MEM_POOL_SIZE,
-				lpfc_pool_kmalloc, lpfc_pool_kfree,
-				(void *)(unsigned long)sizeof(LPFC_MBOXQ_t));
+	phba->mbox_mem_pool = mempool_create_kmalloc_pool(LPFC_MEM_POOL_SIZE,
+							 sizeof(LPFC_MBOXQ_t));
 	if (!phba->mbox_mem_pool)
 		goto fail_free_mbuf_pool;
 
-	phba->nlp_mem_pool = mempool_create(LPFC_MEM_POOL_SIZE,
-			lpfc_pool_kmalloc, lpfc_pool_kfree,
-			(void *)(unsigned long)sizeof(struct lpfc_nodelist));
+	phba->nlp_mem_pool = mempool_create_kmalloc_pool(LPFC_MEM_POOL_SIZE,
+						sizeof(struct lpfc_nodelist));
 	if (!phba->nlp_mem_pool)
 		goto fail_free_mbox_pool;
 
Index: linux-2.6.16-rc1-mm4+mempool_work/drivers/md/dm-raid1.c
===================================================================
--- linux-2.6.16-rc1-mm4+mempool_work.orig/drivers/md/dm-raid1.c
+++ linux-2.6.16-rc1-mm4+mempool_work/drivers/md/dm-raid1.c
@@ -122,16 +122,6 @@ static inline sector_t region_to_sector(
 /* FIXME move this */
 static void queue_bio(struct mirror_set *ms, struct bio *bio, int rw);
 
-static void *region_alloc(gfp_t gfp_mask, void *pool_data)
-{
-	return kmalloc(sizeof(struct region), gfp_mask);
-}
-
-static void region_free(void *element, void *pool_data)
-{
-	kfree(element);
-}
-
 #define MIN_REGIONS 64
 #define MAX_RECOVERY 1
 static int rh_init(struct region_hash *rh, struct mirror_set *ms,
@@ -173,8 +163,8 @@ static int rh_init(struct region_hash *r
 	INIT_LIST_HEAD(&rh->quiesced_regions);
 	INIT_LIST_HEAD(&rh->recovered_regions);
 
-	rh->region_pool = mempool_create(MIN_REGIONS, region_alloc,
-					 region_free, NULL);
+	rh->region_pool = mempool_create_kmalloc_pool(MIN_REGIONS,
+						      sizeof(struct region));
 	if (!rh->region_pool) {
 		vfree(rh->buckets);
 		rh->buckets = NULL;
Index: linux-2.6.16-rc1-mm4+mempool_work/drivers/s390/scsi/zfcp_aux.c
===================================================================
--- linux-2.6.16-rc1-mm4+mempool_work.orig/drivers/s390/scsi/zfcp_aux.c
+++ linux-2.6.16-rc1-mm4+mempool_work/drivers/s390/scsi/zfcp_aux.c
@@ -829,18 +829,6 @@ zfcp_unit_dequeue(struct zfcp_unit *unit
 	device_unregister(&unit->sysfs_device);
 }
 
-static void *
-zfcp_mempool_alloc(gfp_t gfp_mask, void *size)
-{
-	return kmalloc((size_t) size, gfp_mask);
-}
-
-static void
-zfcp_mempool_free(void *element, void *size)
-{
-	kfree(element);
-}
-
 /*
  * Allocates a combined QTCB/fsf_req buffer for erp actions and fcp/SCSI
  * commands.
@@ -853,51 +841,39 @@ static int
 zfcp_allocate_low_mem_buffers(struct zfcp_adapter *adapter)
 {
 	adapter->pool.fsf_req_erp =
-		mempool_create(ZFCP_POOL_FSF_REQ_ERP_NR,
-			       zfcp_mempool_alloc, zfcp_mempool_free, (void *)
-			       sizeof(struct zfcp_fsf_req_pool_element));
-
-	if (NULL == adapter->pool.fsf_req_erp)
+		mempool_create_kmalloc_pool(ZFCP_POOL_FSF_REQ_ERP_NR,
+				sizeof(struct zfcp_fsf_req_pool_element));
+	if (!adapter->pool.fsf_req_erp)
 		return -ENOMEM;
 
 	adapter->pool.fsf_req_scsi =
-		mempool_create(ZFCP_POOL_FSF_REQ_SCSI_NR,
-			       zfcp_mempool_alloc, zfcp_mempool_free, (void *)
-			       sizeof(struct zfcp_fsf_req_pool_element));
-
-	if (NULL == adapter->pool.fsf_req_scsi)
+		mempool_create_kmalloc_pool(ZFCP_POOL_FSF_REQ_SCSI_NR,
+				sizeof(struct zfcp_fsf_req_pool_element));
+	if (!adapter->pool.fsf_req_scsi)
 		return -ENOMEM;
 
 	adapter->pool.fsf_req_abort =
-		mempool_create(ZFCP_POOL_FSF_REQ_ABORT_NR,
-			       zfcp_mempool_alloc, zfcp_mempool_free, (void *)
-			       sizeof(struct zfcp_fsf_req_pool_element));
-
-	if (NULL == adapter->pool.fsf_req_abort)
+		mempool_create_kmalloc_pool(ZFCP_POOL_FSF_REQ_ABORT_NR,
+				sizeof(struct zfcp_fsf_req_pool_element));
+	if (!adapter->pool.fsf_req_abort)
 		return -ENOMEM;
 
 	adapter->pool.fsf_req_status_read =
-		mempool_create(ZFCP_POOL_STATUS_READ_NR,
-			       zfcp_mempool_alloc, zfcp_mempool_free,
-			       (void *) sizeof(struct zfcp_fsf_req));
-
-	if (NULL == adapter->pool.fsf_req_status_read)
+		mempool_create_kmalloc_pool(ZFCP_POOL_STATUS_READ_NR,
+					    sizeof(struct zfcp_fsf_req));
+	if (!adapter->pool.fsf_req_status_read)
 		return -ENOMEM;
 
 	adapter->pool.data_status_read =
-		mempool_create(ZFCP_POOL_STATUS_READ_NR,
-			       zfcp_mempool_alloc, zfcp_mempool_free,
-			       (void *) sizeof(struct fsf_status_read_buffer));
-
-	if (NULL == adapter->pool.data_status_read)
+		mempool_create_kmalloc_pool(ZFCP_POOL_STATUS_READ_NR,
+					sizeof(struct fsf_status_read_buffer));
+	if (!adapter->pool.data_status_read)
 		return -ENOMEM;
 
 	adapter->pool.data_gid_pn =
-		mempool_create(ZFCP_POOL_DATA_GID_PN_NR,
-			       zfcp_mempool_alloc, zfcp_mempool_free, (void *)
-			       sizeof(struct zfcp_gid_pn_data));
-
-	if (NULL == adapter->pool.data_gid_pn)
+		mempool_create_kmalloc_pool(ZFCP_POOL_DATA_GID_PN_NR,
+					    sizeof(struct zfcp_gid_pn_data));
+	if (!adapter->pool.data_gid_pn)
 		return -ENOMEM;
 
 	return 0;
Index: linux-2.6.16-rc1-mm4+mempool_work/drivers/md/dm-io.c
===================================================================
--- linux-2.6.16-rc1-mm4+mempool_work.orig/drivers/md/dm-io.c
+++ linux-2.6.16-rc1-mm4+mempool_work/drivers/md/dm-io.c
@@ -32,16 +32,6 @@ struct io {
 static unsigned _num_ios;
 static mempool_t *_io_pool;
 
-static void *alloc_io(gfp_t gfp_mask, void *pool_data)
-{
-	return kmalloc(sizeof(struct io), gfp_mask);
-}
-
-static void free_io(void *element, void *pool_data)
-{
-	kfree(element);
-}
-
 static unsigned int pages_to_ios(unsigned int pages)
 {
 	return 4 * pages;	/* too many ? */
@@ -65,7 +55,8 @@ static int resize_pool(unsigned int new_
 
 	} else {
 		/* create new pool */
-		_io_pool = mempool_create(new_ios, alloc_io, free_io, NULL);
+		_io_pool = mempool_create_kmalloc_pool(new_ios,
+						       sizeof(struct io));
 		if (!_io_pool)
 			return -ENOMEM;
 
Index: linux-2.6.16-rc1-mm4+mempool_work/drivers/md/bitmap.c
===================================================================
--- linux-2.6.16-rc1-mm4+mempool_work.orig/drivers/md/bitmap.c
+++ linux-2.6.16-rc1-mm4+mempool_work/drivers/md/bitmap.c
@@ -89,16 +89,6 @@ int bitmap_active(struct bitmap *bitmap)
 }
 
 #define WRITE_POOL_SIZE 256
-/* mempool for queueing pending writes on the bitmap file */
-static void *write_pool_alloc(gfp_t gfp_flags, void *data)
-{
-	return kmalloc(sizeof(struct page_list), gfp_flags);
-}
-
-static void write_pool_free(void *ptr, void *data)
-{
-	kfree(ptr);
-}
 
 /*
  * just a placeholder - calls kmalloc for bitmap pages
@@ -1564,8 +1554,8 @@ int bitmap_create(mddev_t *mddev)
 	spin_lock_init(&bitmap->write_lock);
 	INIT_LIST_HEAD(&bitmap->complete_pages);
 	init_waitqueue_head(&bitmap->write_wait);
-	bitmap->write_pool = mempool_create(WRITE_POOL_SIZE, write_pool_alloc,
-				write_pool_free, NULL);
+	bitmap->write_pool = mempool_create_kmalloc_pool(WRITE_POOL_SIZE,
+						sizeof(struct page_list));
 	err = -ENOMEM;
 	if (!bitmap->write_pool)
 		goto error;
Index: linux-2.6.16-rc1-mm4+mempool_work/fs/bio.c
===================================================================
--- linux-2.6.16-rc1-mm4+mempool_work.orig/fs/bio.c
+++ linux-2.6.16-rc1-mm4+mempool_work/fs/bio.c
@@ -1127,16 +1127,6 @@ struct bio_pair *bio_split(struct bio *b
 	return bp;
 }
 
-static void *bio_pair_alloc(gfp_t gfp_flags, void *data)
-{
-	return kmalloc(sizeof(struct bio_pair), gfp_flags);
-}
-
-static void bio_pair_free(void *bp, void *data)
-{
-	kfree(bp);
-}
-
 
 /*
  * create memory pools for biovec's in a bio_set.
@@ -1257,8 +1247,8 @@ static int __init init_bio(void)
 	if (!fs_bio_set)
 		panic("bio: can't allocate bios\n");
 
-	bio_split_pool = mempool_create(BIO_SPLIT_ENTRIES,
-				bio_pair_alloc, bio_pair_free, NULL);
+	bio_split_pool = mempool_create_kmalloc_pool(BIO_SPLIT_ENTRIES,
+						     sizeof(struct bio_pair));
 	if (!bio_split_pool)
 		panic("bio: can't create split pool\n");
 

--

