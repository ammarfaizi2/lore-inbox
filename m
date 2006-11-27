Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758523AbWK0S0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758523AbWK0S0p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 13:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758525AbWK0S0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 13:26:45 -0500
Received: from hera.kernel.org ([140.211.167.34]:64218 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1758523AbWK0S0n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 13:26:43 -0500
Date: Mon, 27 Nov 2006 18:26:34 GMT
From: Eric Van Hensbergen <ericvh@hera.kernel.org>
Message-Id: <200611271826.kARIQYRi032717@hera.kernel.org>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] dm-cache: block level disk cache target for device mapper
Cc: dm-devel@redhat.com, ming@acis.ufl.edu, ericvh@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the first cut of a device-mapper target which provides a write-back
or write-through block cache.  It is intended to be used in conjunction with
remote block devices such as iSCSI or ATA-over-Ethernet, particularly in
cluster situations.

In performance tests with iSCSI, gave peformance improvements of 2-10x that
of iSCSI alone when Postmark or Bonnie loads were applied from 8 clients to
a single server.  Evidence suggests even greater differences on larger
clusters.  A detailed performance analysis will be vailable shortly via a
technical report on IBM's CyberDigest.

This module was developed during an intership at IBM Research by
Ming Zhao.  Please direct comments to both Ming and myself.

Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>
---
 drivers/md/Kconfig    |    6 
 drivers/md/Makefile   |    1 
 drivers/md/dm-cache.c | 1465 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1472 insertions(+), 0 deletions(-)

diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index c92c152..0f23a15 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -261,6 +261,12 @@ config DM_MULTIPATH_EMC
 	---help---
 	  Multipath support for EMC CX/AX series hardware.
 
+config DM_CACHE
+	tristate "Cache target support (EXPERIMENTAL)"
+	depends on BLK_DEV_DM && EXPERIMENTAL
+	---help---
+	  Support for generic cache target for device-mapper.
+
 endmenu
 
 endif
diff --git a/drivers/md/Makefile b/drivers/md/Makefile
index 34957a6..49f7266 100644
--- a/drivers/md/Makefile
+++ b/drivers/md/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_DM_MULTIPATH_EMC)	+= dm-emc
 obj-$(CONFIG_DM_SNAPSHOT)	+= dm-snapshot.o
 obj-$(CONFIG_DM_MIRROR)		+= dm-mirror.o
 obj-$(CONFIG_DM_ZERO)		+= dm-zero.o
+obj-$(CONFIG_DM_CACHE)		+= dm-cache.o
 
 quiet_cmd_unroll = UNROLL  $@
       cmd_unroll = $(PERL) $(srctree)/$(src)/unroll.pl $(UNROLL) \
diff --git a/drivers/md/dm-cache.c b/drivers/md/dm-cache.c
new file mode 100755
index 0000000..209bae0
--- /dev/null
+++ b/drivers/md/dm-cache.c
@@ -0,0 +1,1465 @@
+/*
+ * dm-cache.c
+ * Device mapper target for block-level disk caching
+ *
+ * Copyright (C) International Business Machines Corp., 2006
+ * Author: Ming Zhao (mingzhao@ufl.edu)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; under version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#include <asm/atomic.h>
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/blkdev.h>
+#include <linux/bio.h>
+#include <linux/slab.h>
+#include <linux/hash.h>
+#include <linux/spinlock.h>
+#include <linux/workqueue.h>
+
+#include "dm.h"
+#include "dm-io.h"
+#include "dm-bio-list.h"
+#include "kcopyd.h"
+
+#define DMC_DEBUG		0
+
+#define DM_MSG_PREFIX		"dm-cache"
+#define DMC_PREFIX		"dm-cache: "
+
+#if DMC_DEBUG
+#define DPRINTK( s, arg... ) printk(DMC_PREFIX s "\n", ##arg)
+#else
+#define DPRINTK( s, arg... )
+#endif
+
+#define WRITE_THROUGH	0
+#define WRITE_BACK		1
+#define DEFAULT_WRITE_POLICY	WRITE_BACK
+
+#define DMCACHE_COPY_PAGES	1024
+#define DEFAULT_CACHE_SIZE		65536
+#define DEFAULT_CACHE_ASSOC	1024
+#define DEFAULT_BLOCK_SIZE		8
+#define CONSECUTIVE_BLOCKS		128
+
+#define HASH						0
+#define UNIFORM					1
+#define DEFAULT_HASHFUNC		UNIFORM
+
+/* states of a cache block */
+#define INVALID		0
+#define VALID		1	/* Valid */
+#define RESERVED	2	/* Allocated but data not in place yet */
+#define DIRTY		4	/* Locally modified */
+#define WRITEBACK	8	/* In the process of write back */
+
+/*
+ * cache: maps a cache range of a device.
+ */
+struct cache_c {
+	struct dm_dev *src_dev;	/* Source device */
+	struct dm_dev *cache_dev;	/* Cache device */
+	struct kcopyd_client *kcp_client;	/* Kcopyd client for writing back data */
+
+	struct cacheblock *cache;	/* Hash table for cache blocks */
+	sector_t size;		/* Cache size */
+	unsigned int bits;	/* Cache size in bits */
+	unsigned int assoc;	/* Cache associativity */
+	unsigned int block_size;	/* Cache block size */
+	unsigned int block_shift;	/* Cache block size in bits */
+	unsigned int block_mask;	/* Cache block mask */
+	unsigned int consecutive_shift;	/* Consecutive blocks size in bits */
+	unsigned long counter;	/* Logical timestamp of the cache's last access */
+	unsigned int write_policy;	/* Cache write policy */
+	sector_t dirty_blocks;	/* Number of dirty blocks */
+
+	spinlock_t lock;	/* Lock to protect page allocation/deallocation */
+	struct page_list *pages;	/* Pages for I/O */
+	unsigned int nr_pages;	/* Number of pages */
+	unsigned int nr_free_pages;	/* Number of free pages */
+	wait_queue_head_t destroyq;	/* Wait queue for I/O completion */
+	atomic_t nr_jobs;	/* Number of I/O jobs */
+	/* Stats */
+	unsigned long reads;	/* Number of reads */
+	unsigned long writes;	/* Number of writes */
+	unsigned long cache_hits;	/* Number of cache hits */
+	unsigned long replace;	/* Number of cache replacements */
+	unsigned long writeback;	/* Number of blocks written back for replacements */
+};
+
+struct cacheblock {		/* Cache block metadata structure (size: 28B) */
+	spinlock_t lock;	/* Lock to protect operations on the bio list */
+	sector_t block;		/* Sector number of the cached block */
+	unsigned short state;	/* State of a block */
+	unsigned long counter;	/* Logical timestamp of the block's last access */
+	struct bio_list bios;	/* List of pending bios */
+};
+
+#if DMC_DEBUG
+/* Function for debugging; will be removed */
+static int hexdump(char *data, int data_len)
+{
+	int i, j;
+	char buf[1000];
+	char temp[10];
+
+	if (data == NULL) {
+		DPRINTK("null\n");
+		return -1;
+	}
+
+	for (i = 0; i < data_len; i++) {
+		j = sprintf(temp, "%x", data[i]);
+		if (j < 2) {
+			buf[(i % 16) * 3] = '0';
+			strcpy(buf + (i % 16) * 3 + 1, temp + j - 1);
+		} else
+			strcpy(buf + (i % 16) * 3, temp + j - 2);
+		strcpy(buf + (i % 16) * 3 + 2, " ");
+		if (i % 16 == 15)
+			DPRINTK("%s", buf);
+	}
+
+	if (i % 16 != 0)
+		DPRINTK("%s", buf);
+
+	return 1;
+}
+#endif /* DMC_DEBUG */
+
+/*
+ * Functions for allocating and deallocating pages used for async I/O
+ * Code is largely borrowed from kcopyd.c
+ */
+
+static struct page_list *alloc_pl(void)
+{
+	struct page_list *pl;
+
+	pl = kmalloc(sizeof(*pl), GFP_KERNEL);
+	if (!pl)
+		return NULL;
+
+	pl->page = alloc_page(GFP_KERNEL);
+	if (!pl->page) {
+		kfree(pl);
+		return NULL;
+	}
+
+	return pl;
+}
+
+static void free_pl(struct page_list *pl)
+{
+	__free_page(pl->page);
+	kfree(pl);
+}
+
+static void drop_pages(struct page_list *pl)
+{
+	struct page_list *next;
+
+	while (pl) {
+		next = pl->next;
+		free_pl(pl);
+		pl = next;
+	}
+}
+
+static int kcached_get_pages(struct cache_c *dmc, unsigned int nr,
+			     struct page_list **pages)
+{
+	struct page_list *pl;
+
+	spin_lock(&dmc->lock);
+	if (dmc->nr_free_pages < nr) {
+		DPRINTK("No free pages: %u<%u", dmc->nr_free_pages, nr);
+		spin_unlock(&dmc->lock);
+		return -ENOMEM;
+	}
+
+	dmc->nr_free_pages -= nr;
+	for (*pages = pl = dmc->pages; --nr; pl = pl->next) ;
+
+	dmc->pages = pl->next;
+	pl->next = NULL;
+
+	spin_unlock(&dmc->lock);
+
+	return 0;
+}
+
+static void kcached_put_pages(struct cache_c *dmc, struct page_list *pl)
+{
+	struct page_list *cursor;
+
+	spin_lock(&dmc->lock);
+	for (cursor = pl; cursor->next; cursor = cursor->next)
+		dmc->nr_free_pages++;
+
+	dmc->nr_free_pages++;
+	cursor->next = dmc->pages;
+	dmc->pages = pl;
+
+//      DPRINTK("Free pages %u", dmc->nr_free_pages);
+	spin_unlock(&dmc->lock);
+}
+
+static int alloc_bio_pages(struct cache_c *dmc, unsigned int nr)
+{
+	unsigned int i;
+	struct page_list *pl = NULL, *next;
+
+	for (i = 0; i < nr; i++) {
+		next = alloc_pl();
+		if (!next) {
+			if (pl)
+				drop_pages(pl);
+			return -ENOMEM;
+		}
+		next->next = pl;
+		pl = next;
+	}
+
+	kcached_put_pages(dmc, pl);
+	dmc->nr_pages += nr;
+
+	return 0;
+}
+
+static void free_bio_pages(struct cache_c *dmc)
+{
+	BUG_ON(dmc->nr_free_pages != dmc->nr_pages);
+	drop_pages(dmc->pages);
+	dmc->pages = NULL;
+	dmc->nr_free_pages = dmc->nr_pages = 0;
+}
+
+/*
+ * Functions and data structures for handling async I/O
+ * Code for queue handling is borrowed from kcopyd.c
+ */
+
+struct kcached_job {
+	struct list_head list;
+	struct cache_c *dmc;
+	struct bio *bio;	/* Original bio */
+	struct io_region src;
+	struct io_region dest;
+	struct cacheblock *cacheblock;
+	int rw;
+	/*
+	 * When the original bio is aligned with cache blocks,
+	 * we need extra bvecs and pages for padding.
+	 */
+	struct bio_vec *bvec;
+	unsigned int nr_pages;
+	struct page_list *pages;
+};
+
+static struct workqueue_struct *_kcached_wq;
+static struct work_struct _kcached_work;
+
+static inline void wake(void)
+{
+	queue_work(_kcached_wq, &_kcached_work);
+}
+
+#define MIN_JOBS 1024
+
+static kmem_cache_t *_job_cache;
+static mempool_t *_job_pool;
+
+static DEFINE_SPINLOCK(_job_lock);
+
+static LIST_HEAD(_complete_jobs);
+static LIST_HEAD(_io_jobs);
+static LIST_HEAD(_pages_jobs);
+
+static int jobs_init(void)
+{
+	_job_cache = kmem_cache_create("kcached-jobs",
+				       sizeof(struct kcached_job),
+				       __alignof__(struct kcached_job),
+				       0, NULL, NULL);
+	if (!_job_cache)
+		return -ENOMEM;
+
+	_job_pool = mempool_create(MIN_JOBS, mempool_alloc_slab,
+				   mempool_free_slab, _job_cache);
+	if (!_job_pool) {
+		kmem_cache_destroy(_job_cache);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void jobs_exit(void)
+{
+	BUG_ON(!list_empty(&_complete_jobs));
+	BUG_ON(!list_empty(&_io_jobs));
+	BUG_ON(!list_empty(&_pages_jobs));
+
+	mempool_destroy(_job_pool);
+	kmem_cache_destroy(_job_cache);
+	_job_pool = NULL;
+	_job_cache = NULL;
+}
+
+/*
+ * Functions to push and pop a job onto the head of a given job
+ * list.
+ */
+static inline struct kcached_job *pop(struct list_head *jobs)
+{
+	struct kcached_job *job = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&_job_lock, flags);
+
+	if (!list_empty(jobs)) {
+		job = list_entry(jobs->next, struct kcached_job, list);
+		list_del(&job->list);
+	}
+	spin_unlock_irqrestore(&_job_lock, flags);
+
+	return job;
+}
+
+static inline void push(struct list_head *jobs, struct kcached_job *job)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&_job_lock, flags);
+	list_add_tail(&job->list, jobs);
+	spin_unlock_irqrestore(&_job_lock, flags);
+}
+
+static void io_callback(unsigned long error, void *context)
+{
+	struct kcached_job *job = (struct kcached_job *)context;
+
+	if (error) {
+		/* TODO */
+		DPRINTK("io error");
+	}
+
+	if (job->rw == READ) {
+		job->rw = WRITE;
+		push(&_io_jobs, job);
+	} else
+		push(&_complete_jobs, job);
+	wake();
+}
+
+/*
+ * Read data from source device or write data to cache device, asynchronously
+ * (The most complicated function in the whole module, because the requested
+ * data may not align with the cache blocks and extra handling is required to
+ * pad a block or get the requested data from a block.)
+ */
+static int do_io(struct kcached_job *job)
+{
+	int r = 0, i, j;
+	struct bio *bio = job->bio;
+	struct cache_c *dmc = job->dmc;
+	unsigned int offset, head, tail, remaining, nr_vecs, idx = 0;
+	struct bio_vec *bvec;
+	struct page_list *pl;
+
+	offset = (unsigned int)(bio->bi_sector & dmc->block_mask);
+	head = to_bytes(offset);
+	tail = to_bytes(dmc->block_size) - bio->bi_size - head;
+
+//      DPRINTK("do_io(%s): %llu(%llu->%llu,%llu), head:%u,tail:%u",
+//              job->rw == READ ? "read" : "write",
+//              bio->bi_sector, job->src.sector, job->dest.sector, job->src.count, head, tail);
+
+	if (job->rw == READ) {	/* Read from source device */
+		if (bio_data_dir(bio) == READ) {	/* The original request is a READ */
+			if (0 == job->nr_pages) {	/* The request is aligned to cache block */
+				r = dm_io_async_bvec(1, &job->src, READ,
+						     bio->bi_io_vec +
+						     bio->bi_idx, io_callback,
+						     job);
+				return r;
+			}
+
+			nr_vecs = bio->bi_vcnt - bio->bi_idx;
+			bvec =
+			    kmalloc((nr_vecs + job->nr_pages) * sizeof(*bvec),
+				    GFP_NOIO);
+			if (!bvec) {
+				DPRINTK("No memory");
+				return 1;
+			}
+
+			pl = job->pages;
+			i = 0;
+			while (head) {
+				bvec[i].bv_len =
+				    min(head, (unsigned int)PAGE_SIZE);
+				bvec[i].bv_offset = 0;
+				bvec[i].bv_page = pl->page;
+				head -= bvec[i].bv_len;
+				pl = pl->next;
+				i++;
+			}
+
+			remaining = bio->bi_size;
+			j = bio->bi_idx;
+			while (remaining) {
+				bvec[i] = bio->bi_io_vec[j];
+				remaining -= bvec[i].bv_len;
+				i++;
+				j++;
+			}
+
+			while (tail) {
+				bvec[i].bv_len =
+				    min(tail, (unsigned int)PAGE_SIZE);
+				bvec[i].bv_offset = 0;
+				bvec[i].bv_page = pl->page;
+				tail -= bvec[i].bv_len;
+				pl = pl->next;
+				i++;
+			}
+
+			job->bvec = bvec;
+			r = dm_io_async_bvec(1, &job->src, READ, job->bvec,
+					     io_callback, job);
+			return r;
+		} else {	/* The original request is a WRITE */
+			pl = job->pages;
+
+			if (head && tail) {	/* Special case */
+				bvec =
+				    kmalloc(job->nr_pages * sizeof(*bvec),
+					    GFP_KERNEL);
+				if (!bvec) {
+					DPRINTK("No memory");
+					return 1;
+				}
+				for (i = 0; i < job->nr_pages; i++) {
+					bvec[i].bv_len = PAGE_SIZE;
+					bvec[i].bv_offset = 0;
+					bvec[i].bv_page = pl->page;
+					pl = pl->next;
+				}
+				job->bvec = bvec;
+				r = dm_io_async_bvec(1, &job->src, READ,
+						     job->bvec, io_callback,
+						     job);
+				return r;
+			}
+//                      DPRINTK("Create %u new bvecs", job->nr_pages + bio->bi_vcnt - bio->bi_idx);
+			bvec =
+			    kmalloc((job->nr_pages + bio->bi_vcnt - bio->bi_idx)
+				    * sizeof(*bvec), GFP_KERNEL);
+			if (!bvec) {
+				DPRINTK("No memory");
+				return 1;
+			}
+
+			i = 0;
+			while (head) {
+				bvec[i].bv_len =
+				    min(head, (unsigned int)PAGE_SIZE);
+				bvec[i].bv_offset = 0;
+				bvec[i].bv_page = pl->page;
+				head -= bvec[i].bv_len;
+//                              DPRINTK("New bvec (len: %u, offset: %u, left: %u)", bvec[i].bv_len, bvec[i].bv_offset, head);
+				pl = pl->next;
+				i++;
+			}
+
+			remaining = bio->bi_size;
+			j = bio->bi_idx;
+			while (remaining) {
+				bvec[i] = bio->bi_io_vec[j];
+				remaining -= bvec[i].bv_len;
+//                              DPRINTK("Add bvec (len: %u, offset: %u, left: %u)", bvec[i].bv_len, bvec[i].bv_offset, remaining);
+				i++;
+				j++;
+			}
+
+			if (tail) {
+				idx = i;
+				bvec[i].bv_offset =
+				    (to_bytes(offset) +
+				     bio->bi_size) & (PAGE_SIZE - 1);
+				bvec[i].bv_len = PAGE_SIZE - bvec[i].bv_offset;
+				bvec[i].bv_page = pl->page;
+				tail -= bvec[i].bv_len;
+//                              DPRINTK("Added a bvec (offset: %u, len: %u, left: %u)", bvec[i].bv_offset, bvec[i].bv_len, tail);
+				pl = pl->next;
+				i++;
+				while (tail) {
+					bvec[i].bv_len = PAGE_SIZE;
+					bvec[i].bv_offset = 0;
+					bvec[i].bv_page = pl->page;
+//                                      DPRINTK("Added a page (offset: %u, len: %u, left: %u)", bvec[i].bv_offset, bvec[i].bv_len, tail);
+					tail -= bvec[i].bv_len;
+					pl = pl->next;
+					i++;
+				}
+			}
+
+			job->bvec = bvec;
+//                      DPRINTK("idx: %u", idx);
+			r = dm_io_async_bvec(1, &job->src, READ,
+					     job->bvec + idx, io_callback, job);
+			return r;
+		}
+	} else {		/* job->rw == WRITE; Write to cache device */
+		if (0 == job->nr_pages)	/* Original request is aligned with cache blocks */
+			r = dm_io_async_bvec(1, &job->dest, WRITE,
+					     bio->bi_io_vec + bio->bi_idx,
+					     io_callback, job);
+		else {
+			if (bio_data_dir(bio) == WRITE && head > 0 && tail > 0) {	/* Special case */
+				DPRINTK("Special: %u %u %u", bio_data_dir(bio),
+					head, tail);
+				nr_vecs =
+				    job->nr_pages + bio->bi_vcnt - bio->bi_idx;
+				if (offset
+				    && (offset + bio->bi_size < PAGE_SIZE))
+					nr_vecs++;
+				DPRINTK("Create %u new vecs", nr_vecs);
+				bvec =
+				    kmalloc(nr_vecs * sizeof(*bvec),
+					    GFP_KERNEL);
+				if (!bvec) {
+					DPRINTK("No memory");
+					return 1;
+				}
+
+				i = 0;
+				while (head) {
+					bvec[i].bv_len =
+					    min(head, job->bvec[i].bv_len);
+					bvec[i].bv_offset = 0;
+					bvec[i].bv_page = job->bvec[i].bv_page;
+					head -= bvec[i].bv_len;
+					DPRINTK
+					    ("New bvec (len: %u, offset: %u, left: %u)",
+					     bvec[i].bv_len, bvec[i].bv_offset,
+					     head);
+					i++;
+				}
+				remaining = bio->bi_size;
+				j = bio->bi_idx;
+				while (remaining) {
+					bvec[i] = bio->bi_io_vec[j];
+					remaining -= bvec[i].bv_len;
+					DPRINTK
+					    ("Add bvec (len: %u, offset: %u, left: %u)",
+					     bvec[i].bv_len, bvec[i].bv_offset,
+					     remaining);
+					i++;
+					j++;
+				}
+				j = (to_bytes(offset) +
+				     bio->bi_size) / PAGE_SIZE;
+				bvec[i].bv_offset =
+				    (to_bytes(offset) + bio->bi_size) -
+				    j * PAGE_SIZE;
+				bvec[i].bv_len = PAGE_SIZE - bvec[i].bv_offset;
+				bvec[i].bv_page = job->bvec[j].bv_page;
+				tail -= bvec[i].bv_len;
+				DPRINTK
+				    ("Added a bvec (offset: %u, len: %u, left: %u)",
+				     bvec[i].bv_offset, bvec[i].bv_len, tail);
+				i++;
+				j++;
+				while (tail) {
+					bvec[i] = job->bvec[j];
+					DPRINTK
+					    ("Added a page (offset: %u, len: %u, left: %u)",
+					     bvec[i].bv_offset, bvec[i].bv_len,
+					     tail);
+					tail -= bvec[i].bv_len;
+					i++;
+					j++;
+				}
+				kfree(job->bvec);
+				job->bvec = bvec;
+			}
+
+			r = dm_io_async_bvec(1, &job->dest, WRITE, job->bvec,
+					     io_callback, job);
+		}
+	}
+
+	return r;
+}
+
+/*
+ * Flush the bios that are waiting for this cache insertion or write back
+ */
+static void flush_bios(struct cacheblock *cacheblock)
+{
+	struct bio *bio;
+	struct bio *n;
+
+	spin_lock(&cacheblock->lock);
+	bio = bio_list_get(&cacheblock->bios);
+	if (cacheblock->state & WRITEBACK) {
+		cacheblock->state = INVALID;
+	} else {
+		cacheblock->state |= VALID;
+		cacheblock->state &= ~RESERVED;
+	}
+	spin_unlock(&cacheblock->lock);
+
+	while (bio) {
+		n = bio->bi_next;
+		bio->bi_next = NULL;
+		DPRINTK("Flush bio: %llu->%llu (%u bytes)", cacheblock->block,
+			bio->bi_sector, bio->bi_size);
+		generic_make_request(bio);
+		bio = n;
+	}
+}
+
+static int do_complete(struct kcached_job *job)
+{
+	int r = 0;
+	struct bio *bio = job->bio;
+
+//      DPRINTK("do_complete: %llu", bio->bi_sector);
+
+	bio_endio(bio, bio->bi_size, 0);
+
+	if (job->nr_pages > 0) {
+		kfree(job->bvec);
+		kcached_put_pages(job->dmc, job->pages);
+	}
+
+	flush_bios(job->cacheblock);
+	mempool_free(job, _job_pool);
+
+	if (atomic_dec_and_test(&job->dmc->nr_jobs))
+		wake_up(&job->dmc->destroyq);
+
+	return r;
+}
+
+static int do_pages(struct kcached_job *job)
+{
+	int r = 0;
+
+//      DPRINTK("do_pages: %u", job->nr_pages);
+	r = kcached_get_pages(job->dmc, job->nr_pages, &job->pages);
+
+	if (r == -ENOMEM)	/* can't complete now */
+		return 1;
+
+	/* this job is ready for io */
+	push(&_io_jobs, job);
+	return 0;
+}
+
+/*
+ * Run through a list for as long as possible.  Returns the count
+ * of successful jobs.
+ */
+static int process_jobs(struct list_head *jobs,
+			int (*fn) (struct kcached_job *))
+{
+	struct kcached_job *job;
+	int r, count = 0;
+
+	while ((job = pop(jobs))) {
+		r = fn(job);
+
+		if (r < 0) {
+			/* error this rogue job; TODO */
+			DPRINTK("job processing error");
+		}
+
+		if (r > 0) {
+			/*
+			 * We couldn't service this job ATM, so
+			 * push this job back onto the list.
+			 */
+			push(jobs, job);
+			break;
+		}
+
+		count++;
+	}
+
+	return count;
+}
+
+static void do_work(void *ignored)
+{
+	process_jobs(&_complete_jobs, do_complete);
+	process_jobs(&_pages_jobs, do_pages);
+	process_jobs(&_io_jobs, do_io);
+}
+
+static void queue_job(struct kcached_job *job)
+{
+	atomic_inc(&job->dmc->nr_jobs);
+	if (job->nr_pages > 0)	/* Request pages */
+		push(&_pages_jobs, job);
+	else			/* Go ahead to do I/O */
+		push(&_io_jobs, job);
+	wake();
+}
+
+static int kcached_init(struct cache_c *dmc)
+{
+	int r;
+
+	spin_lock_init(&dmc->lock);
+	dmc->pages = NULL;
+	dmc->nr_pages = dmc->nr_free_pages = 0;
+	r = alloc_bio_pages(dmc, DMCACHE_COPY_PAGES);
+	if (r) {
+		DMERR("Could not allocate bio pages");
+		return r;
+	}
+
+	r = dm_io_get(DMCACHE_COPY_PAGES);
+	if (r) {
+		DMERR("Could not resize dm io pool");
+		free_bio_pages(dmc);
+		return r;
+	}
+
+	init_waitqueue_head(&dmc->destroyq);
+	atomic_set(&dmc->nr_jobs, 0);
+
+	return 0;
+}
+
+/*
+ * Construct a cache mapping
+ */
+static int cache_ctr(struct dm_target *ti, unsigned int argc, char **argv)
+{
+	struct cache_c *dmc;
+	unsigned int consecutive_blocks;
+	sector_t localsize, i, order;
+	int r = -EINVAL;
+
+	if (argc < 2) {
+		ti->error = "dm-cache: Needs at least 2 arguments";
+		goto bad;
+	}
+
+	dmc = kmalloc(sizeof(*dmc), GFP_KERNEL);
+	if (dmc == NULL) {
+		ti->error = "dm-cache: Cannot allocate cache context";
+		r = ENOMEM;
+		goto bad;
+	}
+
+	r = dm_get_device(ti, argv[0], 0, ti->len,
+			  dm_table_get_mode(ti->table), &dmc->src_dev);
+	if (r) {
+		ti->error = "dm-cache: Device lookup failed";
+		goto bad1;
+	}
+
+	r = dm_get_device(ti, argv[1], 0, 0,
+			  dm_table_get_mode(ti->table), &dmc->cache_dev);
+	if (r) {
+		ti->error = "dm-cache: Device lookup failed";
+		goto bad2;
+	}
+
+	r = kcopyd_client_create(DMCACHE_COPY_PAGES, &dmc->kcp_client);
+	if (r) {
+		DMERR("Failed to initialize kcopyd client\n");
+		goto bad3;
+	}
+
+	r = kcached_init(dmc);
+	if (r) {
+		ti->error = "Could not create kcached";
+		goto bad4;
+	}
+
+	if (argc >= 3) {
+		if (sscanf(argv[2], "%u", &dmc->block_size) != 1) {
+			ti->error = "dm-cache: Invalid block size";
+			r = -EINVAL;
+			goto bad4;
+		}
+	} else
+		dmc->block_size = DEFAULT_BLOCK_SIZE;
+	if (!dmc->block_size || (dmc->block_size & (dmc->block_size - 1))) {
+		ti->error = "dm-cache: Invalid block size";
+		r = -EINVAL;
+		goto bad4;
+	}
+	ti->split_io = dmc->block_size;
+	dmc->block_shift = ffs(dmc->block_size) - 1;
+	dmc->block_mask = dmc->block_size - 1;
+
+	if (argc >= 4) {
+		if (sscanf(argv[3], "%llu", &dmc->size) != 1 || !dmc->size) {
+			ti->error = "dm-cache: Invalid cache size";
+			r = -EINVAL;
+			goto bad4;
+		}
+	} else
+		dmc->size = DEFAULT_CACHE_SIZE;
+	localsize = dmc->size;
+	dmc->bits = 0;
+	while (localsize > 1) {
+		if (localsize % 2) {
+			ti->error =
+			    "dm-cache: Cache size must be a power of 2\n";
+			r = -EINVAL;
+			goto bad4;
+		}
+		localsize >>= 1;
+		dmc->bits++;
+	}
+
+	if (argc >= 5) {
+		if (sscanf(argv[4], "%u", &dmc->assoc) != 1 || !dmc->assoc) {
+			ti->error = "dm-cache: Invalid cache associativity";
+			r = -EINVAL;
+			goto bad4;
+		}
+	} else
+		dmc->assoc = DEFAULT_CACHE_ASSOC;
+	if (!dmc->assoc || (dmc->assoc & (dmc->assoc - 1))
+	    || dmc->size < dmc->assoc) {
+		ti->error = "dm-cache: Invalid cache associativity";
+		r = -EINVAL;
+		goto bad4;
+	}
+	if (dmc->size * dmc->block_size >
+	    dmc->cache_dev->bdev->bd_disk->capacity) {
+		DMERR
+		    ("Requested cache size exeeds the cache device's capacity (%llu*%i>%llu)",
+		     dmc->size, dmc->block_size,
+		     dmc->cache_dev->bdev->bd_disk->capacity);
+		ti->error = "dm-cache: Invalid cache size";
+		r = -EINVAL;
+		goto bad4;
+	}
+//      consecutive_blocks = dmc->assoc > CONSECUTIVE_BLOCKS ? dmc->assoc : CONSECUTIVE_BLOCKS;
+	consecutive_blocks = dmc->assoc;
+	dmc->consecutive_shift = ffs(consecutive_blocks) - 1;
+
+	order = dmc->size * sizeof(struct cacheblock);
+	localsize = dmc->size * dmc->block_size >> 11;
+	DMINFO("Going to allocate %lluKB (%uB per) mem for %llu-entry cache "
+	       "(capacity: %lluMB, associativity: %u, block size: %u sectors)",
+	       order >> 10, sizeof(struct cacheblock *), dmc->size, localsize,
+	       dmc->assoc, dmc->block_size);
+	dmc->cache = (struct cacheblock *)vmalloc(order);
+	if (!dmc->cache) {
+		ti->error = "Unable to allocate memory";
+		r = -ENOMEM;
+		goto bad4;
+	}
+
+	/* Initialize the cache */
+	for (i = 0; i < dmc->size; i++) {
+		bio_list_init(&dmc->cache[i].bios);
+		dmc->cache[i].state = 0;
+		dmc->cache[i].counter = 0;
+		dmc->cache[i].block = 0;
+		spin_lock_init(&dmc->cache[i].lock);
+	}
+
+	dmc->counter = 0;
+	dmc->write_policy = DEFAULT_WRITE_POLICY;
+	dmc->dirty_blocks = 0;
+	dmc->reads = 0;
+	dmc->writes = 0;
+	dmc->cache_hits = 0;
+	dmc->replace = 0;
+	dmc->writeback = 0;
+
+	ti->private = dmc;
+	return 0;
+
+      bad4:
+	kcopyd_client_destroy(dmc->kcp_client);
+      bad3:
+	dm_put_device(ti, dmc->cache_dev);
+      bad2:
+	dm_put_device(ti, dmc->src_dev);
+      bad1:
+	kfree(dmc);
+      bad:
+	return r;
+}
+
+/*
+ * Functions for writing back dirty blocks
+ */
+
+static void copy_callback(int read_err, unsigned int write_err, void *context)
+{
+	struct cacheblock *cacheblock = (struct cacheblock *)context;
+
+	flush_bios(cacheblock);
+}
+
+static void copy_block(struct cache_c *dmc, struct io_region src,
+		       struct io_region dest, struct cacheblock *cacheblock)
+{
+	DPRINTK("Copying: %llu:%llu->%llu:%llu",
+		src.sector, src.count * 512, dest.sector, dest.count * 512);
+	kcopyd_copy(dmc->kcp_client,
+		    &src, 1, &dest, 0, copy_callback, cacheblock);
+}
+
+static void write_back(struct cache_c *dmc, sector_t index, unsigned int length)
+{
+	struct io_region src, dest;
+	struct cacheblock *cacheblock = &dmc->cache[index];
+	unsigned int i;
+
+	DPRINTK("Write back block %llu(%llu, %u)",
+		index, cacheblock->block, length);
+	src.bdev = dmc->cache_dev->bdev;
+	src.sector = index << dmc->block_shift;
+	src.count = dmc->block_size * length;
+	dest.bdev = dmc->src_dev->bdev;
+	dest.sector = cacheblock->block;
+	dest.count = dmc->block_size * length;
+
+	for (i = 0; i < length; i++)
+		dmc->cache[index + i].state |= WRITEBACK;
+	dmc->dirty_blocks -= length;
+	copy_block(dmc, src, dest, cacheblock);
+}
+
+static void cache_flush(struct cache_c *dmc)
+{
+	struct cacheblock *cache = dmc->cache;
+	sector_t i = 0;
+	unsigned int j;
+
+	DPRINTK("Starts flushing dirty blocks (%llu)", dmc->dirty_blocks);
+	while (i < dmc->size) {
+//              DPRINTK("%llu: %u %llu", i, cache[i].state, cache[i].block);
+		j = 1;
+		if (cache[i].state & DIRTY) {
+			while ((i + j) < dmc->size
+			       && (cache[i + j].state & DIRTY)
+			       && (cache[i + j].block ==
+				   cache[i].block + j * dmc->block_size)) {
+//                              DPRINTK("%llu %u %llu", i+j, cache[i+j].state, cache[i+j].block);
+				j++;
+			}
+			write_back(dmc, i, j);
+		}
+		i += j;
+	}
+}
+
+void kcached_client_destroy(struct cache_c *dmc)
+{
+	/* Wait for completion of all jobs submitted by this client. */
+	wait_event(dmc->destroyq, !atomic_read(&dmc->nr_jobs));
+
+	dm_io_put(dmc->nr_pages);
+	free_bio_pages(dmc);
+}
+
+/*
+ * Destroy the cache mapping
+ * TODO: store meta data persistently
+ */
+static void cache_dtr(struct dm_target *ti)
+{
+	struct cache_c *dmc = (struct cache_c *)ti->private;
+
+	if (dmc->dirty_blocks > 0)
+		cache_flush(dmc);
+
+	kcached_client_destroy(dmc);
+
+	kcopyd_client_destroy(dmc->kcp_client);
+
+	if (dmc->reads + dmc->writes > 0)
+		DMINFO
+		    ("dm-cache stats: reads (%lu), writes (%lu), cache hits (%lu, 0.%lu), "
+		     "replacement (%lu), write-backs (%lu)", dmc->reads,
+		     dmc->writes, dmc->cache_hits,
+		     dmc->cache_hits * 100 / (dmc->reads + dmc->writes),
+		     dmc->replace, dmc->writeback);
+
+	vfree((void *)dmc->cache);
+
+	dm_put_device(ti, dmc->src_dev);
+	dm_put_device(ti, dmc->cache_dev);
+	kfree(dmc);
+}
+
+/*
+ * Basic hash function for the cache to map a block offset in the device to a block offset in the cache
+ * TODO: Hash consecutive device blocks to consecutive cache blocks in order to improve performance
+ */
+static unsigned long hash_block(struct cache_c *dmc, sector_t block)
+{
+	unsigned long set_number, value;
+
+	value =
+	    (unsigned long)(block >>
+			    (dmc->block_shift + dmc->consecutive_shift));
+	if (DEFAULT_HASHFUNC == HASH)
+		set_number = hash_long(value, dmc->bits) / dmc->assoc;
+	else if (DEFAULT_HASHFUNC == UNIFORM)
+		set_number =
+		    value &
+		    ((unsigned long)(dmc->size >> dmc->consecutive_shift) - 1);
+	DPRINTK("Hash: %llu(%lu)->%lu", block, value, set_number);
+	return set_number;
+}
+
+/*
+ * Reset the LRU counters (the cache's global counter and each cache block's counter)
+ * (This seems to be a naive implementaion. However, consider the rareness of the reset,
+ * it might more efficient that other more complex schemes.)
+ */
+static void cache_reset_counter(struct cache_c *dmc)
+{
+	sector_t i;
+	struct cacheblock *cache = dmc->cache;
+
+	DPRINTK("Reset LRU counters");
+	for (i = 0; i < dmc->size; i++)
+		cache[i].counter = 0;
+
+	dmc->counter = 0;
+}
+
+/*
+ * Lookup a block in the cache
+ *
+ * Return value:
+ *  1: cache hit (the index of the matched block is stored in *cache_block)
+ *  0: cache miss but block allocated for insertion (the index of the allocated frame is stored in *cache_block)
+ * -1: cache miss and no room for insertion
+ *
+ */
+static int cache_lookup(struct cache_c *dmc, sector_t block,
+			sector_t * cache_block)
+{
+	unsigned long set_number = hash_block(dmc, block);
+	sector_t index;
+	int i, res;
+	unsigned int cache_assoc = dmc->assoc;
+	struct cacheblock *cache = dmc->cache;
+	int invalid = -1, oldest = -1, oldest_clean = -1;
+	unsigned long counter = ULONG_MAX, clean_counter = ULONG_MAX;
+//      int j = 0; char *log = kmalloc(1000, GFP_KERNEL);
+
+	index = set_number * cache_assoc;
+	for (i = 0; i < cache_assoc; i++, index++) {
+		if (cache[index].state & VALID || cache[index].state & RESERVED) {
+//                      if (j <= 1000 - sizeof(cacheblock) && i<10)
+//                              j += sprintf(log + j, "%llu,%llu,%i,%lu; ",
+//                                      index, cache[index].block, cache[index].state, cache[index].counter);
+			if (cache[index].block == block) {
+				*cache_block = index;
+				if (dmc->counter == ULONG_MAX)
+					cache_reset_counter(dmc);
+				cache[index].counter = ++dmc->counter;
+				break;
+			} else {
+				/* Don't consider blocks that are in the middle of copying */
+				if (!(cache[index].state & RESERVED)
+				    && !(cache[index].state & WRITEBACK)) {
+					if (!(cache[index].state & DIRTY)
+					    && cache[index].counter <
+					    clean_counter) {
+						clean_counter =
+						    cache[index].counter;
+						oldest_clean = i;
+					}
+					if (cache[index].counter < counter) {
+						counter = cache[index].counter;
+						oldest = i;
+					}
+				}
+			}
+		} else {
+			if (invalid == -1)
+				invalid = i;
+		}
+	}
+//      if (j > 0) DPRINTK("%s", log);
+	res = i < cache_assoc ? 1 : 0;
+	if (!res) {
+		if (invalid != -1)
+			*cache_block = set_number * cache_assoc + invalid;
+		else if (oldest_clean != -1)
+			*cache_block = set_number * cache_assoc + oldest_clean;
+		else if (oldest != -1) {
+			res = 2;
+			*cache_block = set_number * cache_assoc + oldest;
+		} else {
+			res = -1;
+		}
+	}
+
+	if (-1 == res)
+		DPRINTK("Cache lookup: Block %llu(%lu):%s", block, set_number,
+			"NO ROOM");
+	else
+		DPRINTK("Cache lookup: Block %llu(%lu):%llu(%s)",
+			block, set_number, *cache_block,
+			1 == res ? "HIT" : (0 == res ? "MISS" : "WB NEEDED"));
+//      kfree(log);
+	return res;
+}
+
+/*
+ * Insert a block into the cache (in the frame specified by cache_block)
+ */
+static int cache_insert(struct cache_c *dmc, sector_t block,
+			sector_t cache_block)
+{
+	struct cacheblock *cache = dmc->cache;
+
+	/*
+	 * Mark the block as RESERVED because although it is allocated, the data are not in place
+	 * until kcopyd finishes its job.
+	 */
+	cache[cache_block].block = block;
+	cache[cache_block].state = RESERVED;
+	if (dmc->counter == ULONG_MAX)
+		cache_reset_counter(dmc);
+	cache[cache_block].counter = ++dmc->counter;
+
+	return 1;
+}
+
+/*
+ * Invalidate a block (specified by cache_block) in the cache
+ */
+static void cache_invalidate(struct cache_c *dmc, sector_t cache_block)
+{
+	struct cacheblock *cache = dmc->cache;
+
+	DPRINTK("Cache invalidate: Block %llu(%llu)", cache_block,
+		cache[cache_block].block);
+	cache[cache_block].state &= ~VALID;
+}
+
+static int cache_hit(struct cache_c *dmc, struct bio *bio, sector_t cache_block)
+{
+	unsigned int offset = (unsigned int)(bio->bi_sector & dmc->block_mask);
+	struct cacheblock *cache = dmc->cache;
+
+	dmc->cache_hits++;
+
+	if (bio_data_dir(bio) == READ) {	/* READ hit */
+		bio->bi_bdev = dmc->cache_dev->bdev;
+		bio->bi_sector = (cache_block << dmc->block_shift) + offset;
+
+		spin_lock(&cache[cache_block].lock);
+		if (cache[cache_block].state & VALID) {	/* Cache block is valid */
+			spin_unlock(&cache[cache_block].lock);
+			return 1;
+		}
+		/* Cache block is not ready yet */
+		DPRINTK("Add to bio list %s(%llu)",
+			dmc->cache_dev->name, bio->bi_sector);
+		bio_list_add(&cache[cache_block].bios, bio);
+		spin_unlock(&cache[cache_block].lock);
+		return 0;
+	} else {		/* WRITE hit */
+		if (dmc->write_policy == WRITE_THROUGH) {
+			cache_invalidate(dmc, cache_block);
+			bio->bi_bdev = dmc->src_dev->bdev;
+			return 1;
+		}
+
+		/* Write delay */
+		if (!(cache[cache_block].state & DIRTY)) {
+			cache[cache_block].state |= DIRTY;
+			dmc->dirty_blocks++;
+		}
+
+		spin_lock(&cache[cache_block].lock);
+		if (cache[cache_block].state & WRITEBACK) {	/* In the middle of write back */
+			/* Delay this write until the block is written back */
+			bio->bi_bdev = dmc->src_dev->bdev;
+			DPRINTK("Add to bio list %s(%llu)",
+				dmc->src_dev->name, bio->bi_sector);
+			bio_list_add(&cache[cache_block].bios, bio);
+			spin_unlock(&cache[cache_block].lock);
+			return 0;
+		}
+		if (cache[cache_block].state & RESERVED) {	/* Cache block not ready yet */
+			bio->bi_bdev = dmc->cache_dev->bdev;
+			bio->bi_sector =
+			    (cache_block << dmc->block_shift) + offset;
+			DPRINTK("Add to bio list %s(%llu)",
+				dmc->cache_dev->name, bio->bi_sector);
+			bio_list_add(&cache[cache_block].bios, bio);
+			spin_unlock(&cache[cache_block].lock);
+			return 0;
+		}
+		bio->bi_bdev = dmc->cache_dev->bdev;
+		bio->bi_sector = (cache_block << dmc->block_shift) + offset;
+		spin_unlock(&cache[cache_block].lock);
+		return 1;
+	}
+}
+
+static struct kcached_job *new_kcached_job(struct cache_c *dmc, struct bio *bio,
+					   sector_t request_block,
+					   sector_t cache_block)
+{
+	struct io_region src, dest;
+	struct kcached_job *job;
+
+	src.bdev = dmc->src_dev->bdev;
+	src.sector = request_block;
+	src.count = dmc->block_size;
+	dest.bdev = dmc->cache_dev->bdev;
+	dest.sector = cache_block << dmc->block_shift;
+	dest.count = src.count;
+
+	job = mempool_alloc(_job_pool, GFP_NOIO);
+	job->dmc = dmc;
+	job->bio = bio;
+	job->src = src;
+	job->dest = dest;
+	job->cacheblock = &dmc->cache[cache_block];
+
+	return job;
+}
+
+static int cache_read_miss(struct cache_c *dmc, struct bio *bio,
+			   sector_t cache_block)
+{
+	struct cacheblock *cache = dmc->cache;
+	unsigned int offset, head, tail;
+	struct kcached_job *job;
+	sector_t request_block;
+
+	offset = (unsigned int)(bio->bi_sector & dmc->block_mask);
+	request_block = bio->bi_sector - offset;
+
+	if (cache[cache_block].state & VALID) {
+		DPRINTK("Replacing %llu->%llu", cache[cache_block].block,
+			request_block);
+		dmc->replace++;
+	} else
+		DPRINTK("Insert block %llu at empty frame %llu",
+			request_block, cache_block);
+
+	cache_insert(dmc, request_block, cache_block);
+
+	job = new_kcached_job(dmc, bio, request_block, cache_block);
+
+	head = to_bytes(offset);
+	tail = to_bytes(dmc->block_size) - bio->bi_size - head;
+
+	/* Requested block is aligned with a cache block */
+	if (0 == head && 0 == tail)
+		job->nr_pages = 0;
+	else			/* Need new pages to store extra data */
+		job->nr_pages =
+		    dm_div_up(head, PAGE_SIZE) + dm_div_up(tail, PAGE_SIZE);
+	job->rw = READ;
+//      DPRINTK("Queue job for %llu (need %u pages)", bio->bi_sector, job->nr_pages);
+	queue_job(job);
+	return 0;
+}
+
+static int cache_write_miss(struct cache_c *dmc, struct bio *bio,
+			    sector_t cache_block)
+{
+	struct cacheblock *cache = dmc->cache;
+	unsigned int offset, head, tail;
+	struct kcached_job *job;
+	sector_t request_block;
+
+	if (dmc->write_policy == WRITE_THROUGH) {
+		bio->bi_bdev = dmc->src_dev->bdev;
+		return 1;
+	}
+
+	offset = (unsigned int)(bio->bi_sector & dmc->block_mask);
+	request_block = bio->bi_sector - offset;
+
+	/* Write delay */
+	cache_insert(dmc, request_block, cache_block);
+	cache[cache_block].state |= DIRTY;
+	dmc->dirty_blocks++;
+
+	if (cache[cache_block].state & VALID) {
+		DPRINTK("Replacing %llu->%llu", cache[cache_block].block,
+			request_block);
+		dmc->replace++;
+	} else
+		DPRINTK("Insert block %llu at empty frame %llu",
+			request_block, cache_block);
+
+	job = new_kcached_job(dmc, bio, request_block, cache_block);
+
+	head = to_bytes(offset);
+	tail = to_bytes(dmc->block_size) - bio->bi_size - head;
+
+	if (0 == head && 0 == tail) {	/* Requested block is aligned with a cache block */
+		job->nr_pages = 0;
+		job->rw = WRITE;
+	} else if (head && tail) {	/* Special case: need to pad both head and tail */
+		job->nr_pages = dm_div_up(to_bytes(dmc->block_size), PAGE_SIZE);
+		job->rw = READ;
+	} else {
+		if (head) {
+			job->src.count = to_sector(head);
+			job->nr_pages = dm_div_up(head, PAGE_SIZE);
+		} else {
+			job->src.sector =
+			    bio->bi_sector + to_sector(bio->bi_size);
+			job->src.count = to_sector(tail);
+			job->nr_pages = dm_div_up(tail, PAGE_SIZE);
+		}
+		job->rw = READ;
+	}
+
+//      DPRINTK("Queue job for %llu (need %u pages)", bio->bi_sector, job->nr_pages);
+	queue_job(job);
+
+	return 0;
+}
+
+static int cache_miss(struct cache_c *dmc, struct bio *bio,
+		      sector_t cache_block)
+{
+	if (bio_data_dir(bio) == READ)
+		return cache_read_miss(dmc, bio, cache_block);
+	else
+		return cache_write_miss(dmc, bio, cache_block);
+}
+
+static int cache_map(struct dm_target *ti, struct bio *bio,
+		     union map_info *map_context)
+{
+	struct cache_c *dmc = (struct cache_c *)ti->private;
+	sector_t request_block, cache_block = 0, offset;
+	int res;
+
+	offset = bio->bi_sector & dmc->block_mask;
+	request_block = bio->bi_sector - offset;
+	DPRINTK("Got a %s for %llu ((%llu:%llu), %u bytes)",
+		bio_rw(bio) == WRITE ? "WRITE" : (bio_rw(bio) ==
+						  READ ? "READ" : "READA"),
+		bio->bi_sector, request_block, offset, bio->bi_size);
+
+	if (bio_data_dir(bio) == READ)
+		dmc->reads++;
+	else
+		dmc->writes++;
+
+	res = cache_lookup(dmc, request_block, &cache_block);
+	if (1 == res)		/* Cache hit; server request from cache */
+		return cache_hit(dmc, bio, cache_block);
+	else if (0 == res)	/* Cache miss; replacement block is found */
+		return cache_miss(dmc, bio, cache_block);
+	else if (2 == res) {	/* Cache set is dirty; initiate a write-back */
+		write_back(dmc, cache_block, 1);
+		dmc->writeback++;
+	}
+
+	/* Forward to source device */
+	bio->bi_bdev = dmc->src_dev->bdev;
+
+	return 1;
+}
+
+/* TODO */
+static int cache_status(struct dm_target *ti, status_type_t type,
+			char *result, unsigned int maxlen)
+{
+//      struct cache_c *dmc = (struct cache_c *) ti->private;
+
+	switch (type) {
+	case STATUSTYPE_INFO:
+		result[0] = '\0';
+		break;
+	case STATUSTYPE_TABLE:
+		break;
+	}
+	return 0;
+}
+
+static struct target_type cache_target = {
+	.name = "cache",
+	.version = {1, 0, 1},
+	.module = THIS_MODULE,
+	.ctr = cache_ctr,
+	.dtr = cache_dtr,
+	.map = cache_map,
+	.status = cache_status,
+};
+
+int __init dm_cache_init(void)
+{
+	int r;
+
+	r = jobs_init();
+	if (r)
+		return r;
+
+	_kcached_wq = create_singlethread_workqueue("kcached");
+	if (!_kcached_wq) {
+		DMERR("couldn't start kcached");
+		return -ENOMEM;
+	}
+	INIT_WORK(&_kcached_work, do_work, NULL);
+
+	r = dm_register_target(&cache_target);
+	if (r < 0) {
+		DMERR("cache: register failed %d", r);
+		destroy_workqueue(_kcached_wq);
+	}
+
+	return r;
+}
+
+void dm_cache_exit(void)
+{
+	int r = dm_unregister_target(&cache_target);
+
+	if (r < 0)
+		DMERR("cache: unregister failed %d", r);
+
+	jobs_exit();
+	destroy_workqueue(_kcached_wq);
+}
+
+module_init(dm_cache_init);
+module_exit(dm_cache_exit);
+
+MODULE_DESCRIPTION(DM_NAME " cache target");
+MODULE_AUTHOR("Ming Zhao");
+MODULE_LICENSE("GPL");
-- 
1.4.1

