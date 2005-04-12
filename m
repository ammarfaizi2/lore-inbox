Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263006AbVDLV0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263006AbVDLV0A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 17:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263005AbVDLVY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 17:24:57 -0400
Received: from graphe.net ([209.204.138.32]:23571 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262551AbVDLVS1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 17:18:27 -0400
Date: Tue, 12 Apr 2005 14:18:07 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: linux-kernel@vger.kernel.org, ak@suse.de,
       "Shai Fultheim (Shai@ScaleMP.com)" <shai@scalemp.com>
Subject: [NUMA] Make IDE control structures node local
In-Reply-To: <425BE87409B6BA49954C7D375C69F9ED87ADF0@ms09.mse4.exchange.ms>
Message-ID: <Pine.LNX.4.58.0504121416280.10332@graphe.net>
References: <425BE87409B6BA49954C7D375C69F9ED87ADF0@ms09.mse4.exchange.ms>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to allocate the control structures for for ide devices on the node
of the device itself (yield performance improvements for NUMA systems).
The patch depends on the Slab API change patch by Manfred and me (in mm)
and the pcidev_to_node patch that I posted today.

Signed-off-by: Justin M. Forbes <jmforbes@linuxtx.org>
Signed-off-by: Christoph Lameter <christoph@lameter.com>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.11/drivers/block/as-iosched.c
===================================================================
--- linux-2.6.11.orig/drivers/block/as-iosched.c	2005-04-11 16:36:19.000000000 -0700
+++ linux-2.6.11/drivers/block/as-iosched.c	2005-04-11 16:36:40.000000000 -0700
@@ -1871,20 +1871,21 @@ static int as_init_queue(request_queue_t
 	if (!arq_pool)
 		return -ENOMEM;

-	ad = kmalloc(sizeof(*ad), GFP_KERNEL);
+	ad = kmalloc_node(sizeof(*ad), GFP_KERNEL, q->node);
 	if (!ad)
 		return -ENOMEM;
 	memset(ad, 0, sizeof(*ad));

 	ad->q = q; /* Identify what queue the data belongs to */

-	ad->hash = kmalloc(sizeof(struct list_head)*AS_HASH_ENTRIES,GFP_KERNEL);
+	ad->hash = kmalloc_node(sizeof(struct list_head)*AS_HASH_ENTRIES, GFP_KERNEL, q->node);
 	if (!ad->hash) {
 		kfree(ad);
 		return -ENOMEM;
 	}

-	ad->arq_pool = mempool_create(BLKDEV_MIN_RQ, mempool_alloc_slab, mempool_free_slab, arq_pool);
+	ad->arq_pool = mempool_create_node(BLKDEV_MIN_RQ,mempool_alloc_slab, mempool_free_slab,
+						arq_pool, q->node);
 	if (!ad->arq_pool) {
 		kfree(ad->hash);
 		kfree(ad);
Index: linux-2.6.11/drivers/block/deadline-iosched.c
===================================================================
--- linux-2.6.11.orig/drivers/block/deadline-iosched.c	2005-04-11 16:36:19.000000000 -0700
+++ linux-2.6.11/drivers/block/deadline-iosched.c	2005-04-11 16:36:40.000000000 -0700
@@ -711,18 +711,18 @@ static int deadline_init_queue(request_q
 	if (!drq_pool)
 		return -ENOMEM;

-	dd = kmalloc(sizeof(*dd), GFP_KERNEL);
+	dd = kmalloc_node(sizeof(*dd), GFP_KERNEL, q->node);
 	if (!dd)
 		return -ENOMEM;
 	memset(dd, 0, sizeof(*dd));

-	dd->hash = kmalloc(sizeof(struct list_head)*DL_HASH_ENTRIES,GFP_KERNEL);
+	dd->hash = kmalloc_node(sizeof(struct list_head)*DL_HASH_ENTRIES, GFP_KERNEL, q->node);
 	if (!dd->hash) {
 		kfree(dd);
 		return -ENOMEM;
 	}

-	dd->drq_pool = mempool_create(BLKDEV_MIN_RQ, mempool_alloc_slab, mempool_free_slab, drq_pool);
+	dd->drq_pool = mempool_create_node(BLKDEV_MIN_RQ, mempool_alloc_slab, mempool_free_slab, drq_pool, q->node);
 	if (!dd->drq_pool) {
 		kfree(dd->hash);
 		kfree(dd);
Index: linux-2.6.11/drivers/block/genhd.c
===================================================================
--- linux-2.6.11.orig/drivers/block/genhd.c	2005-04-11 16:36:19.000000000 -0700
+++ linux-2.6.11/drivers/block/genhd.c	2005-04-11 16:36:40.000000000 -0700
@@ -582,9 +582,15 @@ struct seq_operations diskstats_op = {
 };


+inline
 struct gendisk *alloc_disk(int minors)
 {
-	struct gendisk *disk = kmalloc(sizeof(struct gendisk), GFP_KERNEL);
+	return alloc_disk_node(minors, -1);
+}
+
+struct gendisk *alloc_disk_node(int minors, int node_id)
+{
+	struct gendisk *disk = kmalloc_node(sizeof(struct gendisk), GFP_KERNEL, node_id);
 	if (disk) {
 		memset(disk, 0, sizeof(struct gendisk));
 		if (!init_disk_stats(disk)) {
@@ -593,7 +599,7 @@ struct gendisk *alloc_disk(int minors)
 		}
 		if (minors > 1) {
 			int size = (minors - 1) * sizeof(struct hd_struct *);
-			disk->part = kmalloc(size, GFP_KERNEL);
+			disk->part = kmalloc_node(size, GFP_KERNEL, node_id);
 			if (!disk->part) {
 				kfree(disk);
 				return NULL;
@@ -609,6 +615,7 @@ struct gendisk *alloc_disk(int minors)
 }

 EXPORT_SYMBOL(alloc_disk);
+EXPORT_SYMBOL(alloc_disk_node);

 struct kobject *get_disk(struct gendisk *disk)
 {
Index: linux-2.6.11/drivers/block/ll_rw_blk.c
===================================================================
--- linux-2.6.11.orig/drivers/block/ll_rw_blk.c	2005-04-11 16:36:19.000000000 -0700
+++ linux-2.6.11/drivers/block/ll_rw_blk.c	2005-04-11 16:36:40.000000000 -0700
@@ -1644,7 +1644,8 @@ static int blk_init_free_list(request_qu
 	init_waitqueue_head(&rl->wait[WRITE]);
 	init_waitqueue_head(&rl->drain);

-	rl->rq_pool = mempool_create(BLKDEV_MIN_RQ, mempool_alloc_slab, mempool_free_slab, request_cachep);
+	rl->rq_pool = mempool_create_node(BLKDEV_MIN_RQ, mempool_alloc_slab, mempool_free_slab,
+						request_cachep, q->node);

 	if (!rl->rq_pool)
 		return -ENOMEM;
@@ -1654,9 +1655,18 @@ static int blk_init_free_list(request_qu

 static int __make_request(request_queue_t *, struct bio *);

-request_queue_t *blk_alloc_queue(int gfp_mask)
+request_queue_t *blk_alloc_queue_node(int gfp_mask, int node_id);
+
+inline request_queue_t *blk_alloc_queue(int gfp_mask)
 {
-	request_queue_t *q = kmem_cache_alloc(requestq_cachep, gfp_mask);
+	return blk_alloc_queue_node(gfp_mask, -1);
+}
+
+
+
+request_queue_t *blk_alloc_queue_node(int gfp_mask, int node_id)
+{
+	request_queue_t *q = kmem_cache_alloc_node(requestq_cachep, gfp_mask, node_id);

 	if (!q)
 		return NULL;
@@ -1672,6 +1682,7 @@ request_queue_t *blk_alloc_queue(int gfp
 }

 EXPORT_SYMBOL(blk_alloc_queue);
+EXPORT_SYMBOL(blk_alloc_queue_node);

 /**
  * blk_init_queue  - prepare a request queue for use with a block device
@@ -1704,13 +1715,20 @@ EXPORT_SYMBOL(blk_alloc_queue);
  *    blk_init_queue() must be paired with a blk_cleanup_queue() call
  *    when the block device is deactivated (such as at module unload).
  **/
+inline
 request_queue_t *blk_init_queue(request_fn_proc *rfn, spinlock_t *lock)
 {
-	request_queue_t *q = blk_alloc_queue(GFP_KERNEL);
+	return blk_init_queue_node(rfn, lock, -1);
+}
+
+request_queue_t *blk_init_queue_node(request_fn_proc *rfn, spinlock_t *lock, int node_id)
+{
+	request_queue_t *q = blk_alloc_queue_node(GFP_KERNEL, node_id);

 	if (!q)
 		return NULL;

+	q->node = node_id;
 	if (blk_init_free_list(q))
 		goto out_init;

@@ -1746,6 +1764,7 @@ out_init:
 }

 EXPORT_SYMBOL(blk_init_queue);
+EXPORT_SYMBOL(blk_init_queue_node);

 int blk_get_queue(request_queue_t *q)
 {
Index: linux-2.6.11/drivers/ide/ide-disk.c
===================================================================
--- linux-2.6.11.orig/drivers/ide/ide-disk.c	2005-04-11 16:36:19.000000000 -0700
+++ linux-2.6.11/drivers/ide/ide-disk.c	2005-04-11 16:36:40.000000000 -0700
@@ -1216,7 +1216,7 @@ static int idedisk_attach(ide_drive_t *d
 	if (!idkp)
 		goto failed;

-	g = alloc_disk(1 << PARTN_BITS);
+	g = alloc_disk_node(1 << PARTN_BITS, pcibus_to_node(drive->hwif->pci_dev->bus));
 	if (!g)
 		goto out_free_idkp;

Index: linux-2.6.11/drivers/ide/ide-probe.c
===================================================================
--- linux-2.6.11.orig/drivers/ide/ide-probe.c	2005-04-11 16:36:19.000000000 -0700
+++ linux-2.6.11/drivers/ide/ide-probe.c	2005-04-11 16:36:40.000000000 -0700
@@ -976,8 +976,8 @@ static int ide_init_queue(ide_drive_t *d
 	 *	limits and LBA48 we could raise it but as yet
 	 *	do not.
 	 */
-
-	q = blk_init_queue(do_ide_request, &ide_lock);
+
+	q = blk_init_queue_node(do_ide_request, &ide_lock, pcibus_to_node(drive->hwif->pci_dev->bus));
 	if (!q)
 		return 1;

@@ -1094,7 +1094,7 @@ static int init_irq (ide_hwif_t *hwif)
 		hwgroup->hwif->next = hwif;
 		spin_unlock_irq(&ide_lock);
 	} else {
-		hwgroup = kmalloc(sizeof(ide_hwgroup_t),GFP_KERNEL);
+		hwgroup = kmalloc_node(sizeof(ide_hwgroup_t), GFP_KERNEL, pcibus_to_node(&hwif->drives[0]->hwif->pci_dev->bus));
 		if (!hwgroup)
 	       		goto out_up;

Index: linux-2.6.11/include/linux/blkdev.h
===================================================================
--- linux-2.6.11.orig/include/linux/blkdev.h	2005-04-11 16:36:19.000000000 -0700
+++ linux-2.6.11/include/linux/blkdev.h	2005-04-11 16:36:40.000000000 -0700
@@ -393,6 +393,7 @@ struct request_queue
 	 */
 	unsigned int		sg_timeout;
 	unsigned int		sg_reserved_size;
+	int			node;

 	struct list_head	drain_list;

@@ -612,6 +613,7 @@ static inline void blkdev_dequeue_reques
 /*
  * Access functions for manipulating queue properties
  */
+extern request_queue_t *blk_init_queue_node(request_fn_proc *rfn, spinlock_t *lock, int);
 extern request_queue_t *blk_init_queue(request_fn_proc *, spinlock_t *);
 extern void blk_cleanup_queue(request_queue_t *);
 extern void blk_queue_make_request(request_queue_t *, make_request_fn *);
@@ -644,6 +646,7 @@ extern void blk_finish_queue_drain(reque

 int blk_get_queue(request_queue_t *);
 request_queue_t *blk_alloc_queue(int);
+request_queue_t *blk_alloc_queue_node(int,int);
 #define blk_put_queue(q) blk_cleanup_queue((q))

 /*
Index: linux-2.6.11/include/linux/genhd.h
===================================================================
--- linux-2.6.11.orig/include/linux/genhd.h	2005-04-11 16:36:19.000000000 -0700
+++ linux-2.6.11/include/linux/genhd.h	2005-04-11 16:36:40.000000000 -0700
@@ -403,6 +403,7 @@ extern int rescan_partitions(struct gend
 extern void add_partition(struct gendisk *, int, sector_t, sector_t);
 extern void delete_partition(struct gendisk *, int);

+extern struct gendisk *alloc_disk_node(int minors, int node_id);
 extern struct gendisk *alloc_disk(int minors);
 extern struct kobject *get_disk(struct gendisk *disk);
 extern void put_disk(struct gendisk *disk);
Index: linux-2.6.11/include/linux/ide.h
===================================================================
--- linux-2.6.11.orig/include/linux/ide.h	2005-04-11 16:36:19.000000000 -0700
+++ linux-2.6.11/include/linux/ide.h	2005-04-11 16:36:40.000000000 -0700
@@ -916,7 +916,7 @@ typedef struct hwif_s {
 	unsigned dma;

 	void (*led_act)(void *data, int rw);
-} ide_hwif_t;
+} ____cacheline_maxaligned_in_smp ide_hwif_t;

 /*
  *  internal ide interrupt handler type
Index: linux-2.6.11/include/linux/mempool.h
===================================================================
--- linux-2.6.11.orig/include/linux/mempool.h	2005-04-11 16:36:19.000000000 -0700
+++ linux-2.6.11/include/linux/mempool.h	2005-04-11 16:36:40.000000000 -0700
@@ -22,6 +22,9 @@ typedef struct mempool_s {
 } mempool_t;
 extern mempool_t * mempool_create(int min_nr, mempool_alloc_t *alloc_fn,
 				 mempool_free_t *free_fn, void *pool_data);
+extern mempool_t * mempool_create_node(int min_nr, mempool_alloc_t *alloc_fn,
+				mempool_free_t *free_fn, void *pool_data, int nid);
+
 extern int mempool_resize(mempool_t *pool, int new_min_nr, unsigned int __nocast gfp_mask);
 extern void mempool_destroy(mempool_t *pool);
 extern void * mempool_alloc(mempool_t *pool, unsigned int __nocast gfp_mask);
Index: linux-2.6.11/mm/mempool.c
===================================================================
--- linux-2.6.11.orig/mm/mempool.c	2005-04-11 16:36:19.000000000 -0700
+++ linux-2.6.11/mm/mempool.c	2005-04-11 16:36:40.000000000 -0700
@@ -51,16 +51,23 @@ static void free_pool(mempool_t *pool)
  * functions might sleep - as long as the mempool_alloc function is not called
  * from IRQ contexts.
  */
+inline
 mempool_t * mempool_create(int min_nr, mempool_alloc_t *alloc_fn,
 				mempool_free_t *free_fn, void *pool_data)
 {
-	mempool_t *pool;
+	return  mempool_create_node(min_nr,alloc_fn,free_fn, pool_data,-1);
+}
+

-	pool = kmalloc(sizeof(*pool), GFP_KERNEL);
+mempool_t * mempool_create_node(int min_nr, mempool_alloc_t *alloc_fn,
+				mempool_free_t *free_fn, void *pool_data, int node_id)
+{
+	mempool_t *pool;
+	pool = kmalloc_node(sizeof(*pool), GFP_KERNEL, node_id);
 	if (!pool)
 		return NULL;
 	memset(pool, 0, sizeof(*pool));
-	pool->elements = kmalloc(min_nr * sizeof(void *), GFP_KERNEL);
+	pool->elements = kmalloc_node(min_nr * sizeof(void *), GFP_KERNEL, node_id);
 	if (!pool->elements) {
 		kfree(pool);
 		return NULL;
@@ -87,7 +94,9 @@ mempool_t * mempool_create(int min_nr, m
 	}
 	return pool;
 }
+
 EXPORT_SYMBOL(mempool_create);
+EXPORT_SYMBOL(mempool_create_node);

 /**
  * mempool_resize - resize an existing memory pool
