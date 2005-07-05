Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261962AbVGEWtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbVGEWtb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 18:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261978AbVGEWtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 18:49:31 -0400
Received: from ozlabs.org ([203.10.76.45]:32970 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261962AbVGEWsu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 18:48:50 -0400
Date: Wed, 6 Jul 2005 08:45:28 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org, manfred@colorfullife.com, christoph@lameter.com
Cc: linux-kernel@vger.kernel.org
Subject: slab not freeing with current -git
Message-ID: <20050705224528.GJ12786@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I just booted current -git on a POWER5 machine and quickly ran out of
memory. The machine has 256MB of memory, and looking at the slab stats
we are using almost all of it in unused slabs:

  OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
367860   7202   1%    0.12K  12262       30     49048K size-128
1362032   332   0%    0.03K  12161      112     48644K size-32
 65714     26   0%    0.70K   5974       11     47792K blkdev_queue
 47872    169   0%    0.50K   5984        8     23936K size-512
 23012    181   0%    1.00K   5753        4     23012K size-1024
   299    299 100%   16.00K    299        1      4784K size-16384

Backing out the "NUMA aware block device control structure allocation"
patch fixes the problem. I wonder if kmalloc_node is broken.

FYI the kernel has NUMA enabled but the machine has only 1 NUMA node.

Anton

--

Author: Christoph Lameter <christoph@lameter.com>
Date: Thu, 23 Jun 2005 07:08:19 +0000 (-0700)
Source: http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=1946089a109251655c5438d92c539bd2930e71ea

  [PATCH] NUMA aware block device control structure allocation
  
  Patch to allocate the control structures for for ide devices on the node of
  the device itself (for NUMA systems).  The patch depends on the Slab API
  change patch by Manfred and me (in mm) and the pcidev_to_node patch that I
  posted today.
  
  Does some realignment too.
  
  Signed-off-by: Justin M. Forbes <jmforbes@linuxtx.org>
  Signed-off-by: Christoph Lameter <christoph@lameter.com>
  Signed-off-by: Pravin Shelar <pravin@calsoftinc.com>
  Signed-off-by: Shobhit Dayal <shobhit@calsoftinc.com>
  Signed-off-by: Andrew Morton <akpm@osdl.org>
  Signed-off-by: Linus Torvalds <torvalds@osdl.org>

--- a/drivers/block/as-iosched.c
+++ b/drivers/block/as-iosched.c
@@ -1871,20 +1871,22 @@ static int as_init_queue(request_queue_t
 	if (!arq_pool)
 		return -ENOMEM;
 
-	ad = kmalloc(sizeof(*ad), GFP_KERNEL);
+	ad = kmalloc_node(sizeof(*ad), GFP_KERNEL, q->node);
 	if (!ad)
 		return -ENOMEM;
 	memset(ad, 0, sizeof(*ad));
 
 	ad->q = q; /* Identify what queue the data belongs to */
 
-	ad->hash = kmalloc(sizeof(struct list_head)*AS_HASH_ENTRIES,GFP_KERNEL);
+	ad->hash = kmalloc_node(sizeof(struct list_head)*AS_HASH_ENTRIES,
+				GFP_KERNEL, q->node);
 	if (!ad->hash) {
 		kfree(ad);
 		return -ENOMEM;
 	}
 
-	ad->arq_pool = mempool_create(BLKDEV_MIN_RQ, mempool_alloc_slab, mempool_free_slab, arq_pool);
+	ad->arq_pool = mempool_create_node(BLKDEV_MIN_RQ, mempool_alloc_slab,
+				mempool_free_slab, arq_pool, q->node);
 	if (!ad->arq_pool) {
 		kfree(ad->hash);
 		kfree(ad);
--- a/drivers/block/deadline-iosched.c
+++ b/drivers/block/deadline-iosched.c
@@ -711,18 +711,20 @@ static int deadline_init_queue(request_q
 	if (!drq_pool)
 		return -ENOMEM;
 
-	dd = kmalloc(sizeof(*dd), GFP_KERNEL);
+	dd = kmalloc_node(sizeof(*dd), GFP_KERNEL, q->node);
 	if (!dd)
 		return -ENOMEM;
 	memset(dd, 0, sizeof(*dd));
 
-	dd->hash = kmalloc(sizeof(struct list_head)*DL_HASH_ENTRIES,GFP_KERNEL);
+	dd->hash = kmalloc_node(sizeof(struct list_head)*DL_HASH_ENTRIES,
+				GFP_KERNEL, q->node);
 	if (!dd->hash) {
 		kfree(dd);
 		return -ENOMEM;
 	}
 
-	dd->drq_pool = mempool_create(BLKDEV_MIN_RQ, mempool_alloc_slab, mempool_free_slab, drq_pool);
+	dd->drq_pool = mempool_create_node(BLKDEV_MIN_RQ, mempool_alloc_slab,
+					mempool_free_slab, drq_pool, q->node);
 	if (!dd->drq_pool) {
 		kfree(dd->hash);
 		kfree(dd);
--- a/drivers/block/genhd.c
+++ b/drivers/block/genhd.c
@@ -582,10 +582,16 @@ struct seq_operations diskstats_op = {
 	.show	= diskstats_show
 };
 
-
 struct gendisk *alloc_disk(int minors)
 {
-	struct gendisk *disk = kmalloc(sizeof(struct gendisk), GFP_KERNEL);
+	return alloc_disk_node(minors, -1);
+}
+
+struct gendisk *alloc_disk_node(int minors, int node_id)
+{
+	struct gendisk *disk;
+
+	disk = kmalloc_node(sizeof(struct gendisk), GFP_KERNEL, node_id);
 	if (disk) {
 		memset(disk, 0, sizeof(struct gendisk));
 		if (!init_disk_stats(disk)) {
@@ -594,7 +600,7 @@ struct gendisk *alloc_disk(int minors)
 		}
 		if (minors > 1) {
 			int size = (minors - 1) * sizeof(struct hd_struct *);
-			disk->part = kmalloc(size, GFP_KERNEL);
+			disk->part = kmalloc_node(size, GFP_KERNEL, node_id);
 			if (!disk->part) {
 				kfree(disk);
 				return NULL;
@@ -610,6 +616,7 @@ struct gendisk *alloc_disk(int minors)
 }
 
 EXPORT_SYMBOL(alloc_disk);
+EXPORT_SYMBOL(alloc_disk_node);
 
 struct kobject *get_disk(struct gendisk *disk)
 {
--- a/drivers/block/ll_rw_blk.c
+++ b/drivers/block/ll_rw_blk.c
@@ -28,6 +28,7 @@
 #include <linux/slab.h>
 #include <linux/swap.h>
 #include <linux/writeback.h>
+#include <linux/blkdev.h>
 
 /*
  * for max sense size
@@ -1645,7 +1646,8 @@ static int blk_init_free_list(request_qu
 	init_waitqueue_head(&rl->wait[WRITE]);
 	init_waitqueue_head(&rl->drain);
 
-	rl->rq_pool = mempool_create(BLKDEV_MIN_RQ, mempool_alloc_slab, mempool_free_slab, request_cachep);
+	rl->rq_pool = mempool_create_node(BLKDEV_MIN_RQ, mempool_alloc_slab,
+				mempool_free_slab, request_cachep, q->node);
 
 	if (!rl->rq_pool)
 		return -ENOMEM;
@@ -1657,8 +1659,15 @@ static int __make_request(request_queue_
 
 request_queue_t *blk_alloc_queue(int gfp_mask)
 {
-	request_queue_t *q = kmem_cache_alloc(requestq_cachep, gfp_mask);
+	return blk_alloc_queue_node(gfp_mask, -1);
+}
+EXPORT_SYMBOL(blk_alloc_queue);
 
+request_queue_t *blk_alloc_queue_node(int gfp_mask, int node_id)
+{
+	request_queue_t *q;
+
+	q = kmem_cache_alloc_node(requestq_cachep, gfp_mask, node_id);
 	if (!q)
 		return NULL;
 
@@ -1671,8 +1680,7 @@ request_queue_t *blk_alloc_queue(int gfp
 
 	return q;
 }
-
-EXPORT_SYMBOL(blk_alloc_queue);
+EXPORT_SYMBOL(blk_alloc_queue_node);
 
 /**
  * blk_init_queue  - prepare a request queue for use with a block device
@@ -1705,13 +1713,22 @@ EXPORT_SYMBOL(blk_alloc_queue);
  *    blk_init_queue() must be paired with a blk_cleanup_queue() call
  *    when the block device is deactivated (such as at module unload).
  **/
+
 request_queue_t *blk_init_queue(request_fn_proc *rfn, spinlock_t *lock)
 {
-	request_queue_t *q = blk_alloc_queue(GFP_KERNEL);
+	return blk_init_queue_node(rfn, lock, -1);
+}
+EXPORT_SYMBOL(blk_init_queue);
+
+request_queue_t *
+blk_init_queue_node(request_fn_proc *rfn, spinlock_t *lock, int node_id)
+{
+	request_queue_t *q = blk_alloc_queue_node(GFP_KERNEL, node_id);
 
 	if (!q)
 		return NULL;
 
+	q->node = node_id;
 	if (blk_init_free_list(q))
 		goto out_init;
 
@@ -1754,8 +1771,7 @@ out_init:
 	kmem_cache_free(requestq_cachep, q);
 	return NULL;
 }
-
-EXPORT_SYMBOL(blk_init_queue);
+EXPORT_SYMBOL(blk_init_queue_node);
 
 int blk_get_queue(request_queue_t *q)
 {
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -1215,7 +1215,8 @@ static int ide_disk_probe(struct device 
 	if (!idkp)
 		goto failed;
 
-	g = alloc_disk(1 << PARTN_BITS);
+	g = alloc_disk_node(1 << PARTN_BITS,
+			pcibus_to_node(drive->hwif->pci_dev->bus));
 	if (!g)
 		goto out_free_idkp;
 
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -977,8 +977,9 @@ static int ide_init_queue(ide_drive_t *d
 	 *	limits and LBA48 we could raise it but as yet
 	 *	do not.
 	 */
-	 
-	q = blk_init_queue(do_ide_request, &ide_lock);
+
+	q = blk_init_queue_node(do_ide_request, &ide_lock,
+				pcibus_to_node(drive->hwif->pci_dev->bus));
 	if (!q)
 		return 1;
 
@@ -1095,7 +1096,8 @@ static int init_irq (ide_hwif_t *hwif)
 		hwgroup->hwif->next = hwif;
 		spin_unlock_irq(&ide_lock);
 	} else {
-		hwgroup = kmalloc(sizeof(ide_hwgroup_t),GFP_KERNEL);
+		hwgroup = kmalloc_node(sizeof(ide_hwgroup_t), GFP_KERNEL,
+			pcibus_to_node(hwif->drives[0].hwif->pci_dev->bus));
 		if (!hwgroup)
 	       		goto out_up;
 
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -396,6 +396,7 @@ struct request_queue
 	 */
 	unsigned int		sg_timeout;
 	unsigned int		sg_reserved_size;
+	int			node;
 
 	struct list_head	drain_list;
 
@@ -615,6 +616,8 @@ static inline void blkdev_dequeue_reques
 /*
  * Access functions for manipulating queue properties
  */
+extern request_queue_t *blk_init_queue_node(request_fn_proc *rfn,
+					spinlock_t *lock, int node_id);
 extern request_queue_t *blk_init_queue(request_fn_proc *, spinlock_t *);
 extern void blk_cleanup_queue(request_queue_t *);
 extern void blk_queue_make_request(request_queue_t *, make_request_fn *);
@@ -646,7 +649,8 @@ extern void blk_wait_queue_drained(reque
 extern void blk_finish_queue_drain(request_queue_t *);
 
 int blk_get_queue(request_queue_t *);
-request_queue_t *blk_alloc_queue(int);
+request_queue_t *blk_alloc_queue(int gfp_mask);
+request_queue_t *blk_alloc_queue_node(int,int);
 #define blk_put_queue(q) blk_cleanup_queue((q))
 
 /*
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -403,6 +403,7 @@ extern int rescan_partitions(struct gend
 extern void add_partition(struct gendisk *, int, sector_t, sector_t);
 extern void delete_partition(struct gendisk *, int);
 
+extern struct gendisk *alloc_disk_node(int minors, int node_id);
 extern struct gendisk *alloc_disk(int minors);
 extern struct kobject *get_disk(struct gendisk *disk);
 extern void put_disk(struct gendisk *disk);
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -917,7 +917,7 @@ typedef struct hwif_s {
 	unsigned dma;
 
 	void (*led_act)(void *data, int rw);
-} ide_hwif_t;
+} ____cacheline_maxaligned_in_smp ide_hwif_t;
 
 /*
  *  internal ide interrupt handler type
--- a/include/linux/mempool.h
+++ b/include/linux/mempool.h
@@ -20,9 +20,14 @@ typedef struct mempool_s {
 	mempool_free_t *free;
 	wait_queue_head_t wait;
 } mempool_t;
-extern mempool_t * mempool_create(int min_nr, mempool_alloc_t *alloc_fn,
-				 mempool_free_t *free_fn, void *pool_data);
-extern int mempool_resize(mempool_t *pool, int new_min_nr, unsigned int __nocast gfp_mask);
+
+extern mempool_t *mempool_create(int min_nr, mempool_alloc_t *alloc_fn,
+			mempool_free_t *free_fn, void *pool_data);
+extern mempool_t *mempool_create_node(int min_nr, mempool_alloc_t *alloc_fn,
+			mempool_free_t *free_fn, void *pool_data, int nid);
+
+extern int mempool_resize(mempool_t *pool, int new_min_nr,
+			unsigned int __nocast gfp_mask);
 extern void mempool_destroy(mempool_t *pool);
 extern void * mempool_alloc(mempool_t *pool, unsigned int __nocast gfp_mask);
 extern void mempool_free(void *element, mempool_t *pool);
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -51,16 +51,23 @@ static void free_pool(mempool_t *pool)
  * functions might sleep - as long as the mempool_alloc function is not called
  * from IRQ contexts.
  */
-mempool_t * mempool_create(int min_nr, mempool_alloc_t *alloc_fn,
+mempool_t *mempool_create(int min_nr, mempool_alloc_t *alloc_fn,
 				mempool_free_t *free_fn, void *pool_data)
 {
-	mempool_t *pool;
+	return  mempool_create_node(min_nr,alloc_fn,free_fn, pool_data,-1);
+}
+EXPORT_SYMBOL(mempool_create);
 
-	pool = kmalloc(sizeof(*pool), GFP_KERNEL);
+mempool_t *mempool_create_node(int min_nr, mempool_alloc_t *alloc_fn,
+			mempool_free_t *free_fn, void *pool_data, int node_id)
+{
+	mempool_t *pool;
+	pool = kmalloc_node(sizeof(*pool), GFP_KERNEL, node_id);
 	if (!pool)
 		return NULL;
 	memset(pool, 0, sizeof(*pool));
-	pool->elements = kmalloc(min_nr * sizeof(void *), GFP_KERNEL);
+	pool->elements = kmalloc_node(min_nr * sizeof(void *),
+					GFP_KERNEL, node_id);
 	if (!pool->elements) {
 		kfree(pool);
 		return NULL;
@@ -87,7 +94,7 @@ mempool_t * mempool_create(int min_nr, m
 	}
 	return pool;
 }
-EXPORT_SYMBOL(mempool_create);
+EXPORT_SYMBOL(mempool_create_node);
 
 /**
  * mempool_resize - resize an existing memory pool
