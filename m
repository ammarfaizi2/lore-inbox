Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751383AbWEOJTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbWEOJTo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 05:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWEOJTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 05:19:44 -0400
Received: from mx02.stofanet.dk ([212.10.10.12]:11142 "EHLO mx02.stofanet.dk")
	by vger.kernel.org with ESMTP id S1751383AbWEOJTn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 05:19:43 -0400
Date: Mon, 15 May 2006 11:18:08 +0200
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Cc: mason@suse.com
Subject: [PATCH] fcache: a remapping boot cache
Message-ID: <20060515091806.GA4110@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Inspired by recent postings on various ways to speedup booting, I wrote
a little module as a weekend project to actually test some of this. The
goal was to make the boot process be completely linear on disk, without
having to modify the file system. The results is 'fcache', a remapping
cache that sits between the file system and block device.

fcache has two run modes - a priming mode and a normal mode. When run in
priming mode, it mirrors every read to the target partition as a write
operation on a cache partition resulting in data being laid out linearly
on the cache device as a function of time. When running in the normal
mode, it acts as a lookup cache and serves data from the cache partition
if it can. So if the workload is mostly repeatable, fcache will provide
perfect access to the data. So the idea is that you boot with priming
enabled once and the subsequent boots with priming off will be faster
than normal.

Some facts about fcache and how it works:

o fcache is a "perfect" solution to the problem because it will catch
  everything, data as well as file system meta data.

o fcache is detachable from the file system at any time. IOW, the file
  system remains completely valid at all times.

o fcache is file system independent. The patch only includes a half
  assed modification to ext3 to support it, other file systems are
  trivially supportable.

o fcache isn't implemented as a dm target, as I wanted to be able to
  easily attach fcache to any already installed system and easily boot
  older kernels on it as well.

o fcache requires a separate partition to be used as a cache device,
  similar to how people normally setup swap. In fact for easy testing if
  you don't have an extra partition available, just disable swap and use
  the swap device as the cache device.

Some facts about the current implementation:

o It only supports a single device currently. Can trivially be extended
  to more.

o As mentioned above, only ext3 is modified to support fcache
  open/close.

o Trying it on my notebook brought the time from the kernel starts
  loading to kde has fully auto-logged in down from 50 seconds to 38
  seconds. The primed boot took 61 seconds. The notebook is about 4
  months old and the file system is very fresh, so better results should
  be seen on more fragmented installs.

How to use it:

Two new mount options are added to allow specifying the cache device and
cache mode, fcache_dev and fcache_prime. fcache_dev takes a string
describing the major and minor number of the cache device, and
fcache_prime takes a simple integer 0/1 describing whether this is a
primed mount or not. IOW:

mount /dev/sda1 /foo -o fcache_dev=8/6,fcache_prime=1

will mount /dev/sda1 on /foo with /dev/sda6 as the cache device and in
priming mode. The easiest way to try it out as a boot optimizer is to
modify the boot script that remounts the file system rw and attach
fcache there. On suse, that's /etc/init.d/boot.rootfsck - just grep for
"remount,rw" in /etc/init.d should help you find the location. Add the
fcache arguments there, eg for the first boot you would have:

	mount -n -o remount,rw,fcache_dev=8/6,fcache_prime=1 /

and for subsequent boots:

	mount -n -o remount,rw,fcache_dev=8/6,fcache_prime=0 /

After the first boot with priming has been completed, you should remount
the fs with priming disabled to end the priming period. When you choose
to do that depends on how much you want to prime - perhaps you would do
it right after log in, or perhaps you want to start firefox first to get
that added as well. Either way, you would issue a normal remount
operation with fcache_prime=0 to do that:

# mount / -o remount,fcache_dev=8/6,fcache_prime=0o

fcache will then tell you how much it logged:

# dmesg
[...]
fcache: reads 8787, hits 0, nothing 0
fcache: wrote 8787 extents, holding 281724KiB of data
fcache: wrote header (extents=8787,serial=323)
fcache: open 800006, prime=0, serial=323
fcache: header looks valid (extents=8787 extents, serial=323)
fcache: loaded 8787 extents
fcache: sda6 opened successfully

You probably also want to do that after the first non-primed boot just
to check that your hit rate is in the range expected (eg hits == reads,
or at least very close):

# dmesg
[...]
fcache: reads 8293, hits 8273, nothing 16
fcache: wrote header (extents=8525,serial=325)
fcache: open 800006, prime=0, serial=325
fcache: header looks valid (extents=8525 extents, serial=325)
fcache: loaded 8525 extents
fcache: sda6 opened successfully

Random notes if this is interesting enough to be taken further:

o Wants to be completely integrated with the distro, of course. It
  should handle the prime/non-prime mounts automatically by for instance
  doing a primed boot after the first install and/or whenever the hit
  rate drops too much due to file system layout changes. You also would
  want to prevent preload from stepping on your toes during boot. The
  root remount script should also check for fcache presence so you don't
  get failed boots due to unknown mount options on older kernels or
  kernels without fcache loaded.

o Fixup the ext3 integration and add support for other file systems. In
  theory this could be done generically, perhaps?

Patch is against recent Linus tree, should apply easily to most newer
kernels.

diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index e5041a0..3a50e3f 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -2804,12 +2804,10 @@ static void init_request_from_bio(struct
 	 */
 	if (bio_rw_ahead(bio) || bio_failfast(bio))
 		req->flags |= REQ_FAILFAST;
-
-	/*
-	 * REQ_BARRIER implies no merging, but lets make it explicit
-	 */
 	if (unlikely(bio_barrier(bio)))
-		req->flags |= (REQ_HARDBARRIER | REQ_NOMERGE);
+		req->flags |= REQ_HARDBARRIER;
+	if (!bio_mergeable(bio))
+		req->flags |= REQ_NOMERGE;
 
 	req->errors = 0;
 	req->hard_sector = req->sector = bio->bi_sector;
@@ -2857,7 +2855,7 @@ static int __make_request(request_queue_
 
 	spin_lock_irq(q->queue_lock);
 
-	if (unlikely(barrier) || elv_queue_empty(q))
+	if (!bio_mergeable(bio) || elv_queue_empty(q))
 		goto get_rq;
 
 	el_ret = elv_merge(q, &req, bio);
@@ -3096,6 +3094,7 @@ void submit_bio(int rw, struct bio *bio)
 
 	BIO_BUG_ON(!bio->bi_size);
 	BIO_BUG_ON(!bio->bi_io_vec);
+	WARN_ON(bio->bi_next);
 	bio->bi_rw |= rw;
 	if (rw & WRITE)
 		mod_page_state(pgpgout, count);
diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index ae0949b..b53ecec 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -456,4 +456,10 @@ config ATA_OVER_ETH
 	This driver provides Support for ATA over Ethernet block
 	devices like the Coraid EtherDrive (R) Storage Blade.
 
+config BLK_FCACHE
+	bool "Boot frontend cache driver"
+	help
+	This driver puts the data needed for a boot sequentially in a
+	defined place, taking all seeks out of the boot process.
+
 endmenu
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index 410f259..279988d 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -30,3 +30,4 @@ obj-$(CONFIG_VIODASD)		+= viodasd.o
 obj-$(CONFIG_BLK_DEV_SX8)	+= sx8.o
 obj-$(CONFIG_BLK_DEV_UB)	+= ub.o
 
+obj-$(CONFIG_BLK_FCACHE)	+= fcache.o
diff --git a/drivers/block/fcache.c b/drivers/block/fcache.c
new file mode 100644
index 0000000..673b90b
--- /dev/null
+++ b/drivers/block/fcache.c
@@ -0,0 +1,1204 @@
+/*
+ * A frontend cache for a block device. The purpose is to speedup a
+ * fairly random but repeated read work load, like the boot of a system.
+ *
+ * When run in priming mode, fcache allocates and writes data read from
+ * the source drive to our extent cache in the order in which they are
+ * accessed. When later run in non-priming mode, data accessed in the same
+ * order will be linearly available in the cache.
+ *
+ * Performance when priming is slower than non-fcache usage would be. If
+ * the fcache is located on another disk, the hit should be small. If the
+ * the fcache is located on the same disk (another partition), it runs
+ * at about half the speed. Non-priming performance should be fairly
+ * similar on same/other disk.
+ *
+ * On-disk format is as follows:
+ *	Block0:		header
+ *	Block1..X	extent maps
+ *	BlockX+1..Y	extent data
+ *
+ * Copyright (C) 2006 Jens Axboe <axboe@suse.de>
+ *
+ */
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/sched.h>
+#include <linux/blkdev.h>
+#include <linux/prio_tree.h>
+#include <linux/buffer_head.h>
+#include <linux/slab.h>
+
+#define FCACHE_MAGIC	0x61786663
+#define FCACHE_VERSION	0x01
+
+#define FCACHE_HEADER_BLOCK	0
+#define FCACHE_EXTENT_BLOCK	1
+
+struct fcache_dev {
+	struct block_device *bdev;
+	struct block_device *fs_bdev;
+	make_request_fn *mfn;
+	struct prio_tree_root prio_root;
+	unsigned long next_cache_block;
+	unsigned long nr_extents;
+	unsigned long max_extents;
+	unsigned int old_bs;
+	spinlock_t lock;
+
+	sector_t cache_start_sector;
+	unsigned long cache_blocks;
+	sector_t fs_start_sector;
+	sector_t fs_sectors;
+
+	unsigned long flags;
+	int priming;
+	int serial;
+
+	struct list_head list;
+	struct work_struct work;
+
+	/*
+	 * stats
+	 */
+	unsigned int ios;
+	unsigned int hits;
+	unsigned int nothing;
+};
+
+static struct fcache_dev fcache_dev;
+
+static int disable;
+module_param(disable, int, 0444);
+
+struct fcache_endio_data {
+	struct fcache_dev *fdev;
+	sector_t fs_sector;
+	unsigned int fs_size;
+	sector_t cache_sector;
+	struct bio *real_bio;
+	struct bio *clone_bio;
+	int write_complete;
+	struct list_head list;
+};
+
+/*
+ * Maps a file system block to the fcache
+ */
+struct fcache_extent {
+	sector_t fs_sector;	/* real device offset */
+	unsigned int fs_size;	/* extent length */
+	sector_t cache_sector;	/* cache device offset */
+
+	struct prio_tree_node prio_node;
+};
+
+/*
+ * Header on fcache device
+ */
+struct fcache_dev_header {
+	u32 magic;		/* bdcache magic */
+	u32 version;		/* bdcache version */
+	u32 nr_extents;		/* nr of extents in cache */
+	u32 max_extents;	/* max nr of extents */
+	u32 serial;		/* fs and cache serial */
+	u32 extent_offset;	/* where extents start */
+	u16 sector_t_size;	/* user space helper */
+	u16 extent_size;	/* user space helper */
+};
+
+#define BLOCK_SHIFT	(PAGE_SHIFT - 9)
+
+static struct kmem_cache *fcache_slab;
+static struct workqueue_struct *fcache_workqueue;
+
+static int fcache_rw_page_endio(struct bio *bio, unsigned int bytes, int err)
+{
+	if (bio->bi_size)
+		return 1;
+
+	complete(bio->bi_private);
+	return 0;
+}
+
+/*
+ * Writes out a page of data and waits for it to complete.
+ */
+static int fcache_rw_page(struct fcache_dev *fdev, unsigned long index,
+			  struct page *page, int rw)
+{
+	DECLARE_COMPLETION(wait);
+	struct bio *bio;
+	int ret = 0;
+
+	bio = bio_alloc(GFP_KERNEL, 1);
+	if (!bio)
+		return -ENOMEM;
+
+	bio->bi_sector = index << BLOCK_SHIFT;
+	bio->bi_bdev = fdev->bdev;
+	bio->bi_end_io = fcache_rw_page_endio;
+	bio->bi_private = &wait;
+	bio->bi_flags |= (1 << BIO_FCACHE);
+
+	bio_add_page(bio, page, PAGE_SIZE, 0);
+	submit_bio(rw, bio);
+	generic_unplug_device(bdev_get_queue(fdev->bdev));
+
+	wait_for_completion(&wait);
+
+	if (!bio_flagged(bio, BIO_UPTODATE))
+		ret = -EIO;
+
+	bio_put(bio);
+	return ret;
+}
+
+static inline void fcache_fill_header(struct fcache_dev *fdev,
+				      struct fcache_dev_header *header,
+				      unsigned int nr_extents)
+{
+	/*
+	 * See how many pages we need to extent headers, then we know where
+	 * to start putting data. Assume worst case of 1 page per extent, and
+	 * reserve the first page for the header.
+	 */
+
+	header->magic = FCACHE_MAGIC;
+	header->version = FCACHE_VERSION;
+	header->nr_extents = nr_extents;
+	header->max_extents = ((fdev->cache_blocks - 1) * PAGE_SIZE) / (PAGE_SIZE - sizeof(struct fcache_extent));
+	header->serial = fdev->serial;
+
+	header->extent_offset = 1 + (header->max_extents * sizeof(struct fcache_extent) / PAGE_SIZE);
+
+	header->sector_t_size = sizeof(sector_t);
+	header->extent_size = sizeof(struct fcache_extent);
+}
+
+static int fcache_write_new_header(struct fcache_dev *fdev)
+{
+	struct fcache_dev_header *header;
+	struct page *page;
+	int ret;
+
+	page = alloc_page(GFP_HIGHUSER);
+	if (!page)
+		return -ENOMEM;
+
+	header = kmap_atomic(page, KM_USER0);
+	clear_page(header);
+	fcache_fill_header(fdev, header, 0);
+	fdev->next_cache_block = header->extent_offset;
+	fdev->max_extents = header->max_extents;
+	kunmap_atomic(header, KM_USER0);
+
+	printk("fcache: new header: first block %lu, max %lu\n", fdev->next_cache_block, fdev->max_extents);
+
+	ret = fcache_rw_page(fdev, FCACHE_HEADER_BLOCK, page, WRITE);
+	__free_page(page);
+	return ret;
+}
+
+static void fcache_free_prio_tree(struct fcache_dev *fdev)
+{
+	struct fcache_extent *fe;
+	struct prio_tree_iter iter;
+	struct prio_tree_node *node;
+
+	/*
+	 * Now prune and free tree, wish there was a better way...
+	 */
+	do {
+		prio_tree_iter_init(&iter, &fdev->prio_root, 0, ULONG_MAX);
+
+		node = prio_tree_next(&iter);
+		if (!node)
+			break;
+
+		fe = prio_tree_entry(node, struct fcache_extent, prio_node);
+		prio_tree_remove(&fdev->prio_root, node);
+		kmem_cache_free(fcache_slab, fe);
+	} while (1);
+}
+
+/*
+ * First clear the header, write extents, then write real header.
+ */
+static int fcache_write_extents(struct fcache_dev *fdev)
+{
+	struct fcache_dev_header *header;
+	unsigned long index, kib;
+	unsigned int nr_extents, this_extents;
+	struct fcache_extent *fe;
+	struct prio_tree_iter iter;
+	struct prio_tree_node *node;
+	struct page *page;
+	void *p;
+	int ret;
+
+	page = alloc_page(GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;
+
+	header = page_address(page);
+	clear_page(header);
+	fcache_fill_header(fdev, header, 0);
+	ret = fcache_rw_page(fdev, FCACHE_HEADER_BLOCK, page, WRITE);
+	if (ret)
+		goto err;
+
+	/*
+	 * Now write the extents in page size chunks.
+	 */
+	p = page_address(page);
+	clear_page(p);
+	index = FCACHE_EXTENT_BLOCK;
+	kib = 0;
+	this_extents = nr_extents = 0;
+
+	prio_tree_iter_init(&iter, &fdev->prio_root, 0, ULONG_MAX);
+
+	do {
+		node = prio_tree_next(&iter);
+		if (!node)
+			break;
+
+		fe = prio_tree_entry(node, struct fcache_extent, prio_node);
+		nr_extents++;
+		this_extents++;
+		kib += fe->fs_size >> 10;
+		memcpy(p, fe, sizeof(*fe));
+		p += sizeof(*fe);
+		if ((this_extents + 1) * sizeof(*fe) > PAGE_SIZE) {
+			ret = fcache_rw_page(fdev, index, page, WRITE);
+			if (ret)
+				break;
+
+			this_extents = 0;
+			index++;
+			p = page_address(page);
+		}
+	} while (1);
+
+	if (this_extents)
+		ret = fcache_rw_page(fdev, index, page, WRITE);
+
+	fdev->nr_extents = nr_extents;
+	printk("fcache: wrote %d extents, holding %luKiB of data\n", nr_extents, kib);
+err:
+	__free_page(page);
+	return ret;
+}
+
+static int fcache_write_header(struct fcache_dev *fdev)
+{
+	struct fcache_dev_header *header;
+	struct page *page;
+	int ret;
+
+	page = alloc_page(GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;
+
+	header = page_address(page);
+	ret = fcache_rw_page(fdev, FCACHE_HEADER_BLOCK, page, READ);
+	if (ret) {
+		__free_page(page);
+		return ret;
+	}
+
+	fcache_fill_header(fdev, header, fdev->nr_extents);
+	ret = fcache_rw_page(fdev, FCACHE_HEADER_BLOCK, page, WRITE);
+	__free_page(page);
+	printk("fcache: wrote header (extents=%lu,serial=%d)\n", fdev->nr_extents, fdev->serial);
+	return ret;
+}
+
+static void fcache_tree_link(struct fcache_dev *fdev, struct fcache_extent *fe)
+{
+	struct prio_tree_node *node = &fe->prio_node;
+	unsigned long flags;
+
+	INIT_PRIO_TREE_NODE(node);
+	node->start = fe->fs_sector;
+	node->last = fe->fs_sector + (fe->fs_size >> 9) - 1;
+
+	spin_lock_irqsave(&fdev->lock, flags);
+	prio_tree_insert(&fdev->prio_root, node);
+	spin_unlock_irqrestore(&fdev->lock, flags);
+}
+
+#define MAX_FE	16
+
+static int fcache_lookup_extent(struct fcache_dev *fdev, sector_t offset,
+				unsigned int bytes, struct fcache_extent **map)
+{
+	sector_t end_sector = offset + (bytes >> 9) - 1;
+	struct prio_tree_node *node;
+	struct prio_tree_iter iter;
+	int i = 0;
+
+	prio_tree_iter_init(&iter, &fdev->prio_root, offset, end_sector);
+
+	/*
+	 * We only need to lock, if we are priming. Only then will the prio
+	 * tree ever change.
+	 */
+	if (fdev->priming)
+		spin_lock_irq(&fdev->lock);
+
+	do {
+		node = prio_tree_next(&iter);
+		if (!node)
+			break;
+
+		map[i] = prio_tree_entry(node, struct fcache_extent, prio_node);
+	} while (++i < MAX_FE);
+
+	if (fdev->priming)
+		spin_unlock_irq(&fdev->lock);
+
+	return i;
+}
+
+/*
+ * Our data write is done, now insert the fcache extents into the rbtree.
+ */
+static int fcache_instantiate_extent(struct fcache_dev *fdev,
+				     struct fcache_endio_data *fed)
+{
+	struct fcache_extent *fe;
+
+	fe = kmem_cache_alloc(fcache_slab, GFP_KERNEL);
+	if (fe) {
+		fe->fs_sector = fed->fs_sector;
+		fe->fs_size = fed->fs_size;
+		fe->cache_sector = fed->cache_sector;
+
+		fcache_tree_link(fdev, fe);
+		return 0;
+	}
+
+	return -ENOMEM;
+}
+
+static void fcache_get_bio_pages(struct fcache_dev *fdev, struct bio *bio)
+{
+	struct bio_vec *bvec;
+	int i;
+
+	bio_get(bio);
+
+	__bio_for_each_segment(bvec, bio, i, 0)
+		get_page(bvec->bv_page);
+}
+
+static void fcache_put_bio_pages(struct fcache_dev *fdev, struct bio *bio)
+{
+	struct bio_vec *bvec;
+	int i;
+
+	__bio_for_each_segment(bvec, bio, i, 0)
+		put_page(bvec->bv_page);
+
+	bio_put(bio);
+}
+
+/*
+ * Our data write to the cache completes, we can free our clone and kick
+ * the process handler again so it can instantiate the extent block and
+ * end the original bio read.
+ */
+static int fcache_extent_write_endio(struct bio *bio, unsigned int bytes,
+				     int err)
+{
+	struct fcache_dev *fdev;
+	struct fcache_endio_data *fed;
+	unsigned long flags;
+
+	if (bio->bi_size)
+		return 1;
+
+	fed = bio->bi_private;
+
+	/*
+	 * Now we can free our clone.
+	 */
+	WARN_ON(bio != fed->clone_bio);
+	bio_put(bio);
+	fed->clone_bio = NULL;
+
+	fdev = fed->fdev;
+	fed->write_complete = 1;
+	spin_lock_irqsave(&fdev->lock, flags);
+	list_add_tail(&fed->list, &fdev->list);
+	spin_unlock_irqrestore(&fdev->lock, flags);
+	queue_work(fcache_workqueue, &fdev->work);
+	return 0;
+}
+
+static void fcache_work(void *data)
+{
+	struct fcache_dev *fdev = data;
+
+	do {
+		struct fcache_endio_data *fed = NULL;
+		struct bio *bio, *clone;
+
+		spin_lock_irq(&fdev->lock);
+		if (!list_empty(&fdev->list)) {
+			fed = list_entry(fdev->list.next, struct fcache_endio_data,list);
+			list_del_init(&fed->list);
+		}
+		spin_unlock_irq(&fdev->lock);
+
+		if (!fed)
+			break;
+
+		bio = fed->real_bio;
+
+		/*
+		 * If write isn't complete, schedule that.
+		 */
+		if (!fed->write_complete) {
+			clone = fed->clone_bio;
+
+			__bio_clone(clone, bio);
+			clone->bi_bdev = fdev->bdev;
+			clone->bi_sector = fed->cache_sector;
+			clone->bi_end_io = fcache_extent_write_endio;
+			clone->bi_private = fed;
+			clone->bi_flags |= (1 << BIO_FCACHE);
+			clone->bi_next = NULL;
+
+			/*
+			 * Get a ref on the original bio and pages, then
+			 * we should be able to signal completion of the READ
+			 * without waiting for the write to finish first.
+			 */
+			fcache_get_bio_pages(fdev, bio);
+			bio_endio(bio, bio->bi_size, 0);
+
+			submit_bio(WRITE, clone);
+		} else {
+			/*
+			 * Release our reference to the original bio and
+			 * its pages.
+			 */
+			fcache_put_bio_pages(fdev, bio);
+
+			/*
+			 * All done, now add extent to our list.
+			 */
+			fcache_instantiate_extent(fdev, fed);
+			kfree(fed);
+		}
+	} while (1);
+}
+
+/*
+ * Align bio to start at extent and stop sooner if extent is short. Must
+ * be called cautiously - it's only allowed to modify the bio if this is
+ * a clone and a write request, reads must be fully aligned and only
+ * possibly require a starting offset modification.
+ */
+static void fcache_bio_align(struct bio *bio, struct fcache_extent *fe)
+{
+	struct bio_vec *bvec;
+	sector_t start, end;
+	sector_t org_start, org_end;
+	unsigned int org_size, org_idx;
+	int i;
+
+	start = bio->bi_sector;
+	bio->bi_sector = fe->cache_sector;
+
+	/*
+	 * Nothing to do, perfectly aligned.
+	 */
+	if (start == fe->fs_sector && bio->bi_size == fe->fs_size)
+		return;
+
+	org_start = bio->bi_sector;
+	org_end = bio->bi_sector + (bio->bi_size >> 9);
+	org_size = bio->bi_size;
+	org_idx = bio->bi_idx;
+
+	/*
+	 * Adjust beginning.
+	 */
+	if (start > fe->fs_sector)
+		bio->bi_sector += (start - fe->fs_sector);
+	else if (start < fe->fs_sector) {
+		sector_t diff = fe->fs_sector - start;
+		int idx = 0;
+
+		BUG_ON(!(bio->bi_flags & (1 << BIO_CLONED)));
+		BUG_ON(bio_data_dir(bio) != WRITE);
+
+		/*
+		 * Adjust where bio starts
+		 */
+		__bio_for_each_segment(bvec, bio, i, 0) {
+			unsigned int bsec = bvec->bv_len >> 9;
+			unsigned int this_diff = bsec;
+
+			if (!diff)
+				break;
+			if (this_diff > diff)
+				this_diff = diff;
+
+			bio->bi_sector += this_diff;
+			bio->bi_size -= (this_diff << 9);
+
+			/*
+			 * Bigger than this chunk, skip ahead.
+			 */
+			if (this_diff == bsec) {
+				idx++;
+				diff -= this_diff;
+				continue;
+			}
+
+			/*
+			 * Adjust this bvec
+			 */
+			bvec->bv_offset += (this_diff << 9);
+			bvec->bv_len -= (this_diff << 9);
+			break;
+		}
+		bio->bi_idx += idx;
+	}
+
+	/*
+	 * Goes beyond the end, shrink size.
+	 */
+	end = bio->bi_sector + (bio->bi_size >> 9);
+	if (end > fe->cache_sector + (fe->fs_size >> 9)) {
+		sector_t diff = end - (fe->cache_sector + (fe->fs_size >> 9));
+		int vecs = 0;
+
+		BUG_ON(!(bio->bi_flags & (1 << BIO_CLONED)));
+		BUG_ON(bio_data_dir(bio) != WRITE);
+
+		/*
+		 * This is __bio_for_each_segment_reverse().
+		 */
+		for (i = bio->bi_vcnt; i >= bio->bi_idx; i--) {
+			struct bio_vec *bvec = &bio->bi_io_vec[i];
+			unsigned int bsec = bvec->bv_len >> 9;
+			unsigned int this_diff = bsec;
+
+			if (!diff)
+				break;
+			if (this_diff > diff)
+				this_diff = diff;
+
+			bio->bi_size -= (this_diff << 9);
+
+			/*
+			 * Bigger than this chunk, skip ahead.
+			 */
+			if (this_diff == bsec) {
+				vecs++;
+				diff -= this_diff;
+				continue;
+			}
+
+			/*
+			 * Adjust this bvec
+			 */
+			bvec->bv_len -= (this_diff << 9);
+			break;
+		}
+		bio->bi_vcnt -= vecs;
+	}
+
+	WARN_ON(bio->bi_sector < fe->cache_sector);
+	WARN_ON(bio->bi_sector + (bio->bi_size >> 9) > fe->cache_sector + (fe->fs_size >> 9));
+
+	/*
+	 * Invalidate the segment counts, we changed the bio layout.
+	 */
+	bio->bi_flags &= ~(1 << BIO_SEG_VALID);
+}
+
+static int fcache_overwrite_endio(struct bio *bio, unsigned int bytes, int err)
+{
+	if (bio->bi_size)
+		return 1;
+
+	bio_put(bio);
+	return 0;
+}
+
+/*
+ * Schedule overwrite of some existing block(s).
+ */
+static int fcache_overwrite_extent(struct fcache_dev *fdev,
+				   struct fcache_extent *fe, struct bio *bio)
+{
+	struct bio *clone;
+
+	clone = bio_clone(bio, GFP_NOFS);
+	if (clone) {
+		clone->bi_bdev = fdev->bdev;
+		clone->bi_end_io = fcache_overwrite_endio;
+		clone->bi_flags |= (1 << BIO_FCACHE);
+		fcache_bio_align(clone, fe);
+		submit_bio(WRITE, clone);
+		return 0;
+	}
+
+	return -ENOMEM;
+}
+
+/*
+ * Our real data read is complete. Kick our process context handler so it
+ * can submit the write to our cache.
+ */
+static int fcache_extent_endio(struct bio *bio, unsigned int bytes, int err)
+{
+	struct fcache_dev *fdev;
+	struct fcache_endio_data *fed;
+	unsigned long flags;
+
+	if (bio->bi_size)
+		return 1;
+
+	fed = bio->bi_private;
+	WARN_ON(bio != fed->clone_bio);
+
+	fdev = fed->fdev;
+	spin_lock_irqsave(&fdev->lock, flags);
+	list_add_tail(&fed->list, &fdev->list);
+	spin_unlock_irqrestore(&fdev->lock, flags);
+	queue_work(fcache_workqueue, &fdev->work);
+	return 0;
+}
+
+/*
+ * This initiates adding an extent to our list. We do this by cloning the
+ * original bio and submitting that to the real device and when that completes
+ * we write that out to the cache device and instantiate the extent.
+ */
+static int fcache_add_extent(struct fcache_dev *fdev, struct bio *bio)
+{
+	struct fcache_endio_data *fed;
+	struct bio *clone;
+
+	fed = kmalloc(sizeof(*fed), GFP_NOFS);
+	if (!fed)
+		return -ENOMEM;
+
+	clone = bio_clone(bio, GFP_NOFS);
+	if (!clone) {
+		kfree(fed);
+		return -ENOMEM;
+	}
+
+	fed->fs_sector = bio->bi_sector;
+	fed->fs_size = bio->bi_size;
+	fed->fdev = fdev;
+	fed->real_bio = bio;
+	fed->clone_bio = clone;
+	fed->write_complete = 0;
+	INIT_LIST_HEAD(&fed->list);
+
+	/*
+	 * Allocate/assign an extent block for this range
+	 */
+	spin_lock_irq(&fdev->lock);
+	fdev->nr_extents++;
+	if (fdev->nr_extents < fdev->max_extents) {
+		fed->cache_sector = fdev->next_cache_block << BLOCK_SHIFT;
+		fdev->next_cache_block += bio->bi_size >> PAGE_SHIFT;
+	} else
+		fed->cache_sector = -1;
+	spin_unlock_irq(&fdev->lock);
+
+	/*
+	 * Ran out of room
+	 */
+	if (fed->cache_sector == -1) {
+		printk("fcache: ran out of space\n");
+		bio_put(clone);
+		kfree(fed);
+		return -ENOENT;
+	}
+
+	clone->bi_private = fed;
+	clone->bi_end_io = fcache_extent_endio;
+
+	clone->bi_flags |= (1 << BIO_FCACHE);
+	submit_bio(READ, clone);
+	generic_unplug_device(bdev_get_queue(bio->bi_bdev));
+	return 0;
+}
+
+static int fcache_parse_extents(struct fcache_dev *fdev, void *addr,
+				unsigned int max_extents)
+{
+	int nr_extents = PAGE_SIZE / sizeof(struct fcache_extent);
+	int extents_read;
+	void *start = addr;
+
+	if (nr_extents > max_extents)
+		nr_extents = max_extents;
+
+	extents_read = 0;
+	while (nr_extents) {
+		struct fcache_extent *fe, *__fe = addr;
+
+		BUG_ON(addr - start + sizeof(*fe) > PAGE_SIZE);
+
+		fe = kmem_cache_alloc(fcache_slab, GFP_KERNEL);
+		if (!fe)
+			return -ENOMEM;
+
+		memset(fe, 0, sizeof(*fe));
+		fe->fs_sector = __fe->fs_sector;
+		fe->fs_size = __fe->fs_size;
+		fe->cache_sector = __fe->cache_sector;
+
+		fcache_tree_link(fdev, fe);
+
+		nr_extents--;
+		extents_read++;
+		addr += sizeof(*fe);
+	}
+
+	return extents_read;
+}
+
+static int fcache_read_extents(struct fcache_dev *fdev)
+{
+	unsigned int nr_extents = fdev->nr_extents;
+	int ret, extents, total_extents;
+	unsigned long index;
+	struct page *page;
+	void *p;
+
+	page = alloc_page(GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;
+
+	ret = 0;
+	total_extents = 0;
+	index = FCACHE_EXTENT_BLOCK;
+	while (nr_extents) {
+		ret = fcache_rw_page(fdev, index, page, READ);
+		if (ret)
+			break;
+
+		p = page_address(page);
+		extents = fcache_parse_extents(fdev, p, nr_extents);
+
+		if (extents < 0) {
+			ret = extents;
+			break;
+		}
+
+		index++;
+		nr_extents -= extents;
+		total_extents += extents;
+	}
+
+	__free_page(page);
+
+	if (ret)
+		return ret;
+
+	return total_extents;
+}
+
+static int fcache_load_header(struct fcache_dev *fdev, int serial)
+{
+	struct fcache_dev_header *header = NULL;
+	struct page *page;
+	int ret, wrong_serial = 0;
+
+	page = alloc_page(GFP_HIGHUSER);
+	if (!page)
+		return -ENOMEM;
+
+	ret = fcache_rw_page(fdev, FCACHE_HEADER_BLOCK, page, READ);
+	if (ret)
+		goto err;
+
+	ret = -EINVAL;
+	header = kmap_atomic(page, KM_USER0);
+	if (header->magic != FCACHE_MAGIC) {
+		printk("fcache: bad magic %x\n", header->magic);
+		goto err;
+	}
+	if (header->version != FCACHE_VERSION) {
+		printk("fcache: bad version %d\n", header->version);
+		goto err;
+	}
+
+	fdev->nr_extents = header->nr_extents;
+	fdev->max_extents = header->max_extents;
+
+	/*
+	 * Don't fail on out-of-date serial, just warn that the user needs
+	 * to prime the cache again. Until then we'll just bypass the cache.
+	 */
+	if (header->serial != serial) {
+		printk("fcache: found serial %d, expected %d.\n", header->serial, serial);
+		printk("fcache: reprime the cache!\n");
+		wrong_serial = 1;
+	}
+
+	fdev->serial = header->serial;
+	kunmap_atomic(header, KM_USER0);
+	__free_page(page);
+
+	if (!wrong_serial) {
+		printk("fcache: header looks valid (extents=%ld extents, serial=%u)\n", fdev->nr_extents, fdev->serial);
+		ret = fcache_read_extents(fdev);
+		printk("fcache: loaded %d extents\n", ret);
+		if (ret != fdev->nr_extents)
+			ret = -EINVAL;
+		else
+			ret = 0;
+	}
+
+	return ret;
+err:
+	__free_page(page);
+	if (header)
+		kunmap_atomic(header, KM_USER0);
+	return ret;
+}
+
+static void fcache_fill_fs_size(struct fcache_dev *fdev)
+{
+	struct block_device *bdev = fdev->fs_bdev;
+
+	if (bdev != bdev->bd_contains) {
+		struct hd_struct *p = bdev->bd_part;
+
+		fdev->fs_start_sector = p->start_sect;
+		fdev->fs_sectors = p->nr_sects;
+	} else {
+		fdev->fs_start_sector = 0;
+		fdev->fs_sectors = bdev->bd_inode->i_size >> 9;
+	}
+}
+
+static void fcache_fill_cache_size(struct fcache_dev *fdev)
+{
+	struct block_device *bdev = fdev->bdev;
+
+	if (bdev != bdev->bd_contains) {
+		struct hd_struct *p = bdev->bd_part;
+
+		fdev->cache_start_sector = p->start_sect;
+		fdev->cache_blocks = p->nr_sects >> BLOCK_SHIFT;
+	} else {
+		fdev->cache_start_sector = 0;
+		fdev->cache_blocks = bdev->bd_inode->i_size >> PAGE_SHIFT;
+	}
+}
+
+/*
+ * Wrapper around ->mfn, we need to make sure the queue is unplugged.
+ */
+static inline int fcache_queue(struct fcache_dev *fdev, request_queue_t *q,
+			       struct bio *bio)
+{
+	int ret;
+
+	bio->bi_flags |= (1 << BIO_FCACHE);
+	ret = fdev->mfn(q, bio);
+	generic_unplug_device(q);
+
+	return ret;
+}
+
+/*
+ * This is a read request, check if we have that block. If we do, then
+ * just redirect. If not, pass it through.
+ */
+static int fcache_read_request(struct fcache_dev *fdev, request_queue_t *q,
+			       struct bio *bio)
+{
+	struct fcache_extent *extents[MAX_FE];
+	struct fcache_extent *fe;
+	int i, nr;
+
+	fdev->ios++;
+
+	/*
+	 * Not there, redirect to original but schedule adding this extent
+	 * to our list if we are priming.
+	 */
+	nr = fcache_lookup_extent(fdev, bio->bi_sector, bio->bi_size, extents);
+	if (!nr) {
+		if (fdev->priming && !fcache_add_extent(fdev, bio))
+			return 0;
+
+		fdev->nothing++;
+		return fcache_queue(fdev, q, bio);
+	}
+
+	/*
+	 * If range is at least as big, we use our cache. If not, cop out
+	 * and just submit to real device.
+	 */
+	for (i = 0; i < nr; i++) {
+		sector_t end_fe, end_bi;
+		fe = extents[i];
+
+		end_fe = fe->fs_sector + (fe->fs_size >> 9);
+		end_bi = bio->bi_sector + (bio->bi_size >> 9);
+
+		/*
+		 * match!
+		 */
+		if (bio->bi_sector >= fe->fs_sector && end_bi <= end_fe)
+			break;
+
+		fe = NULL;
+	}
+
+	/*
+	 * Nopes, send to real device.
+	 */
+	if (!fe)
+		return fcache_queue(fdev, q, bio);
+
+	/*
+	 * Perfect, adjust start offset if it isn't aligned.
+	 */
+	bio->bi_bdev = fdev->bdev;
+	fcache_bio_align(bio, fe);
+	fdev->hits++;
+	return 1;
+}
+
+/*
+ * If we are priming the cache, always add this block. If not, then we still
+ * need to overwrite this block if it's in our cache.
+ */
+static int fcache_write_request(struct fcache_dev *fdev, request_queue_t *q,
+				struct bio *bio)
+{
+	struct fcache_extent *extents[MAX_FE];
+	struct fcache_extent *fe;
+	sector_t start = bio->bi_sector;
+	int i, nr;
+
+repeat:
+	nr = fcache_lookup_extent(fdev, bio->bi_sector, bio->bi_size, extents);
+
+	/*
+	 * Find out what to overwrite, if anything.
+	 */
+	for (i = 0; i < nr; i++) {
+		fe = extents[i];
+		fcache_overwrite_extent(fdev, fe, bio);
+	}
+
+	/*
+	 * If i == MAX_FE, there _may_ be more extents. Repeat lookup, start
+	 * from the end of last request.
+	 */
+	if (i == MAX_FE) {
+		fe = extents[i - 1];
+		start = fe->fs_sector + (fe->fs_size >> 9);
+		goto repeat;
+	}
+
+	return fcache_queue(fdev, q, bio);
+}
+
+static int fcache_make_request(request_queue_t *q, struct bio *bio)
+{
+	struct fcache_dev *fdev = &fcache_dev;
+
+	/*
+	 * If it's in the sector range we are monitoring and the device isn't
+	 * being shutdown, then pass it on. Assume a bio doesn't span into
+	 * the next partition, so don't bother accounting for size.
+	 */
+	if ((bio->bi_sector >= fdev->fs_start_sector) &&
+	    (bio->bi_sector < (fdev->fs_start_sector + fdev->fs_sectors)) &&
+	    !test_bit(0, &fdev->flags) &&
+	    !bio_flagged(bio, BIO_FCACHE)) {
+
+		if (bio_data_dir(bio) == READ)
+			return fcache_read_request(fdev, q, bio);
+
+		return fcache_write_request(fdev, q, bio);
+	}
+
+	/*
+	 * Pass through to original make_request_fn.
+	 */
+	return fcache_queue(fdev, q, bio);
+}
+
+/*
+ * Attach the cache device 'bdev' to 'fdev'.
+ */
+static int fcache_setup_dev(struct fcache_dev *fdev,
+			    struct block_device *fs_bdev,
+			    struct block_device *bdev,
+			    int priming, int serial)
+{
+	char b[BDEVNAME_SIZE];
+	int ret;
+
+	memset(fdev, 0, sizeof(*fdev));
+	INIT_PRIO_TREE_ROOT(&fdev->prio_root);
+	spin_lock_init(&fdev->lock);
+	INIT_LIST_HEAD(&fdev->list);
+	INIT_WORK(&fdev->work, fcache_work, fdev);
+	fdev->priming = priming;
+	fdev->fs_bdev = fs_bdev;
+
+	ret = bd_claim(bdev, fcache_setup_dev);
+	if (ret < 0) {
+		bdev = NULL;
+		goto out;
+	}
+
+	fdev->bdev = bdev;
+	ret = block_size(bdev);
+	if (ret != PAGE_SIZE) {
+		fdev->old_bs = ret;
+		ret = set_blocksize(bdev, PAGE_SIZE);
+		if (ret < 0)
+			goto out;
+	} else
+		ret = 0;
+
+	fcache_fill_cache_size(fdev);
+	fcache_fill_fs_size(fdev);
+
+	if (priming) {
+		fdev->serial = serial;
+		ret = fcache_write_new_header(fdev);
+	} else
+		ret = fcache_load_header(fdev, serial);
+
+	if (!ret) {
+		printk("fcache: %s opened successfully (%spriming)\n", bdevname(bdev, b), priming ? "" : "not ");
+		return 0;
+	}
+out:
+	printk("fcache: failed %d\n", ret);
+	if (fdev->bdev)
+		bd_release(fdev->bdev);
+
+	return ret;
+}
+
+static void fcache_shutdown_dev(struct fcache_dev *fdev,
+				struct block_device *bdev)
+{
+	if (fdev->bdev) {
+		if (fdev->mfn) {
+			request_queue_t *q = bdev_get_queue(bdev);
+
+			(void) xchg(&q->make_request_fn, fdev->mfn);
+		}
+		sync_blockdev(fdev->bdev);
+		if (fdev->old_bs)
+			set_blocksize(fdev->bdev, fdev->old_bs);
+
+		bd_release(fdev->bdev);
+		blkdev_put(fdev->bdev);
+		fdev->bdev = NULL;
+		INIT_PRIO_TREE_ROOT(&fdev->prio_root);
+	}
+}
+
+/*
+ * bdev is the file system device, cache_dev is the device we want to store
+ * the cache on.
+ */
+int fcache_dev_open(struct block_device *bdev, unsigned long cache_dev,
+		    int priming, int serial)
+{
+	struct block_device *fcache_bdev;
+	request_queue_t *q;
+	int ret;
+
+	if (disable)
+		return 0;
+	if (fcache_dev.bdev)
+		return -EBUSY;
+
+	fcache_bdev = open_by_devnum(cache_dev, FMODE_READ|FMODE_WRITE);
+	if (IS_ERR(fcache_bdev)) {
+		ret = PTR_ERR(fcache_bdev);
+		printk("fcache: can't open %lx, err=%d\n", cache_dev, ret);
+		return PTR_ERR(fcache_bdev);
+	}
+
+	ret = fcache_setup_dev(&fcache_dev, bdev, fcache_bdev, priming, serial);
+	if (ret) {
+		blkdev_put(fcache_bdev);
+		return ret;
+	}
+		
+	q = bdev_get_queue(bdev);
+	fcache_dev.mfn = xchg(&q->make_request_fn, fcache_make_request);
+	return 0;
+}
+
+void fcache_dev_close(struct block_device *bdev, int serial)
+{
+	struct fcache_dev *fdev = &fcache_dev;
+
+	if (disable)
+		return;
+
+	if (!fdev->bdev)
+		return;
+
+	printk("fcache: reads %u, hits %u, nothing %u\n", fdev->ios, fdev->hits, fdev->nothing);
+
+	fdev->serial = serial;
+
+	sync_blockdev(bdev);
+	set_bit(0, &fdev->flags);
+
+	if (fdev->priming)
+		fcache_write_extents(fdev);
+
+	fcache_write_header(fdev);
+	fcache_free_prio_tree(fdev);
+	fcache_shutdown_dev(fdev, bdev);
+}
+
+static int fcache_init(void)
+{
+	fcache_slab = kmem_cache_create("fcache", sizeof(struct fcache_extent),
+					0, 0, NULL, NULL);
+	if (!fcache_slab)
+		return -ENOMEM;
+
+	fcache_workqueue = create_workqueue("fcached");
+	if (!fcache_workqueue)
+		panic("fcache: failed to create fcached\n");
+
+	return 0;
+}
+
+static void fcache_exit(void)
+{
+	destroy_workqueue(fcache_workqueue);
+	kmem_cache_destroy(fcache_slab);
+}
+
+MODULE_AUTHOR("Jens Axboe <axboe@suse.de>");
+MODULE_LICENSE("GPL");
+
+module_init(fcache_init);
+module_exit(fcache_exit);
diff --git a/fs/ext3/super.c b/fs/ext3/super.c
index f8a5266..1d7c8da 100644
--- a/fs/ext3/super.c
+++ b/fs/ext3/super.c
@@ -384,11 +384,43 @@ static void dump_orphan_list(struct supe
 	}
 }
 
+extern int fcache_dev_open(struct block_device *, unsigned long, int, int);
+extern int fcache_dev_close(struct block_device *, int);
+
+static void ext3_close_fcache(struct super_block *sb)
+{
+	struct ext3_sb_info *sbi = EXT3_SB(sb);
+	struct ext3_super_block *es = sbi->s_es;
+	int serial = le16_to_cpu(es->s_mnt_count);
+
+	fcache_dev_close(sb->s_bdev, serial);
+}
+
+static int ext3_open_fcache(struct super_block *sb, unsigned long cachedev)
+{
+	struct ext3_sb_info *sbi = EXT3_SB(sb);
+	struct ext3_super_block *es = sbi->s_es;
+	int priming = test_opt(sb, FCACHEPRIME);
+	int serial = le16_to_cpu(es->s_mnt_count);
+	int ret;
+
+	ret = fcache_dev_open(sb->s_bdev, cachedev, priming, serial);
+	if (!ret) {
+		set_opt(sbi->s_mount_opt, FCACHE);
+		return 0;
+	}
+
+	printk(KERN_ERR "ext3: failed to open fcache (err=%d)\n", ret);
+	return ret;
+}
+
 static void ext3_put_super (struct super_block * sb)
 {
 	struct ext3_sb_info *sbi = EXT3_SB(sb);
 	struct ext3_super_block *es = sbi->s_es;
-	int i;
+	int i, has_fcache;
+	
+	has_fcache = test_opt(sb, FCACHE);
 
 	ext3_xattr_put_super(sb);
 	journal_destroy(sbi->s_journal);
@@ -431,6 +463,8 @@ #endif
 		invalidate_bdev(sbi->journal_bdev, 0);
 		ext3_blkdev_remove(sbi);
 	}
+	if (has_fcache)
+		ext3_close_fcache(sb);
 	sb->s_fs_info = NULL;
 	kfree(sbi);
 	return;
@@ -635,7 +669,7 @@ enum {
 	Opt_usrjquota, Opt_grpjquota, Opt_offusrjquota, Opt_offgrpjquota,
 	Opt_jqfmt_vfsold, Opt_jqfmt_vfsv0, Opt_quota, Opt_noquota,
 	Opt_ignore, Opt_barrier, Opt_err, Opt_resize, Opt_usrquota,
-	Opt_grpquota
+	Opt_grpquota, Opt_fcache_dev, Opt_fcache_prime,
 };
 
 static match_table_t tokens = {
@@ -684,6 +718,8 @@ static match_table_t tokens = {
 	{Opt_quota, "quota"},
 	{Opt_usrquota, "usrquota"},
 	{Opt_barrier, "barrier=%u"},
+	{Opt_fcache_dev, "fcache_dev=%s"},
+	{Opt_fcache_prime, "fcache_prime=%u"},
 	{Opt_err, NULL},
 	{Opt_resize, "resize"},
 };
@@ -710,6 +746,7 @@ static unsigned long get_sb_block(void *
 
 static int parse_options (char *options, struct super_block *sb,
 			  unsigned long *inum, unsigned long *journal_devnum,
+			  unsigned long *fcache_devnum,
 			  unsigned long *n_blocks_count, int is_remount)
 {
 	struct ext3_sb_info *sbi = EXT3_SB(sb);
@@ -1012,6 +1049,29 @@ #endif
 		case Opt_nobh:
 			set_opt(sbi->s_mount_opt, NOBH);
 			break;
+		case Opt_fcache_dev: {
+			int maj, min;
+			char *p, *pm;
+
+			if (!fcache_devnum)
+				break;
+			p = match_strdup(&args[0]);
+			if (!p)
+				return 0;
+			maj = simple_strtol(p, &pm, 10);
+			min = simple_strtol(pm + 1, NULL, 10);
+			*fcache_devnum = maj << MINORBITS | min;
+			kfree(p);
+			break;
+			}
+		case Opt_fcache_prime:
+			if (match_int(&args[0], &option))
+				return 0;
+			if (option)
+				set_opt(sbi->s_mount_opt, FCACHEPRIME);
+			else
+				clear_opt(sbi->s_mount_opt, FCACHEPRIME);
+			break;
 		default:
 			printk (KERN_ERR
 				"EXT3-fs: Unrecognized mount option \"%s\" "
@@ -1346,6 +1406,7 @@ static int ext3_fill_super (struct super
 	unsigned long offset = 0;
 	unsigned long journal_inum = 0;
 	unsigned long journal_devnum = 0;
+	unsigned long fcache_devnum = 0;
 	unsigned long def_mount_opts;
 	struct inode *root;
 	int blocksize;
@@ -1353,6 +1414,7 @@ static int ext3_fill_super (struct super
 	int db_count;
 	int i;
 	int needs_recovery;
+	int fcache = 0;
 	__le32 features;
 
 	sbi = kmalloc(sizeof(*sbi), GFP_KERNEL);
@@ -1427,7 +1489,7 @@ static int ext3_fill_super (struct super
 	set_opt(sbi->s_mount_opt, RESERVATION);
 
 	if (!parse_options ((char *) data, sb, &journal_inum, &journal_devnum,
-			    NULL, 0))
+			    &fcache_devnum, NULL, 0))
 		goto failed_mount;
 
 	sb->s_flags = (sb->s_flags & ~MS_POSIXACL) |
@@ -1651,6 +1713,9 @@ #endif
 		goto failed_mount2;
 	}
 
+	if (fcache_devnum)
+		fcache = ext3_open_fcache(sb, fcache_devnum);
+
 	/* We have now updated the journal if required, so we can
 	 * validate the data journaling mode. */
 	switch (test_opt(sb, DATA_FLAGS)) {
@@ -1740,6 +1805,8 @@ cantfind_ext3:
 	goto failed_mount;
 
 failed_mount3:
+	if (!fcache)
+		ext3_close_fcache(sb);
 	journal_destroy(sbi->s_journal);
 failed_mount2:
 	for (i = 0; i < db_count; i++)
@@ -2205,6 +2272,7 @@ static int ext3_remount (struct super_bl
 	struct ext3_sb_info *sbi = EXT3_SB(sb);
 	unsigned long n_blocks_count = 0;
 	unsigned long old_sb_flags;
+	unsigned long fcache_devnum = 0;
 	struct ext3_mount_options old_opts;
 	int err;
 #ifdef CONFIG_QUOTA
@@ -2226,7 +2294,7 @@ #endif
 	/*
 	 * Allow the "check" option to be passed as a remount option.
 	 */
-	if (!parse_options(data, sb, NULL, NULL, &n_blocks_count, 1)) {
+	if (!parse_options(data, sb, NULL, NULL, &fcache_devnum, &n_blocks_count, 1)) {
 		err = -EINVAL;
 		goto restore_opts;
 	}
@@ -2241,6 +2309,11 @@ #endif
 
 	ext3_init_journal_params(sb, sbi->s_journal);
 
+	if (fcache_devnum) {
+		ext3_close_fcache(sb);
+		ext3_open_fcache(sb, fcache_devnum);
+	}
+
 	if ((*flags & MS_RDONLY) != (sb->s_flags & MS_RDONLY) ||
 		n_blocks_count > le32_to_cpu(es->s_blocks_count)) {
 		if (sbi->s_mount_opt & EXT3_MOUNT_ABORT) {
diff --git a/include/linux/bio.h b/include/linux/bio.h
index b60ffe3..db43b56 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -124,6 +124,7 @@ #define BIO_CLONED	4	/* doesn't own data
 #define BIO_BOUNCED	5	/* bio is a bounce bio */
 #define BIO_USER_MAPPED 6	/* contains user pages */
 #define BIO_EOPNOTSUPP	7	/* not supported */
+#define BIO_FCACHE	8	/* foo */
 #define bio_flagged(bio, flag)	((bio)->bi_flags & (1 << (flag)))
 
 /*
@@ -179,6 +180,14 @@ #define bio_sync(bio)		((bio)->bi_rw & (
 #define bio_failfast(bio)	((bio)->bi_rw & (1 << BIO_RW_FAILFAST))
 #define bio_rw_ahead(bio)	((bio)->bi_rw & (1 << BIO_RW_AHEAD))
 
+static inline int bio_mergeable(struct bio *bio)
+{
+	if (!bio_barrier(bio) && !bio->bi_idx)
+		return 1;
+
+	return 0;
+}
+
 /*
  * will die
  */
diff --git a/include/linux/ext3_fs.h b/include/linux/ext3_fs.h
index 3ade6a4..47ed5a9 100644
--- a/include/linux/ext3_fs.h
+++ b/include/linux/ext3_fs.h
@@ -376,6 +376,8 @@ #define EXT3_MOUNT_NOBH			0x40000 /* No 
 #define EXT3_MOUNT_QUOTA		0x80000 /* Some quota option set */
 #define EXT3_MOUNT_USRQUOTA		0x100000 /* "old" user quota */
 #define EXT3_MOUNT_GRPQUOTA		0x200000 /* "old" group quota */
+#define EXT3_MOUNT_FCACHE		0x400000 /* using fcache */
+#define EXT3_MOUNT_FCACHEPRIME		0x800000 /* priming fcache */
 
 /* Compatibility, for having both ext2_fs.h and ext3_fs.h included at once */
 #ifndef _LINUX_EXT2_FS_H

-- 
Jens Axboe

