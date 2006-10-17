Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbWJQVKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWJQVKf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 17:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWJQVKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 17:10:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6824 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750784AbWJQVKc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 17:10:32 -0400
Date: Tue, 17 Oct 2006 14:10:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: balagi@justmail.de, linux-kernel@vger.kernel.org, petero2@telia.com,
       "Jens Axboe" <jens.axboe@oracle.com>
Subject: Re: [PATCH 1/2] 2.6.19-rc2-mm1 ll_rw_blk.c: export
 clear_queue_congested and set_queue_congested
Message-Id: <20061017141005.5bdf31e3.akpm@osdl.org>
In-Reply-To: <20061017133907.7155b2ac.akpm@osdl.org>
References: <op.thkzomdriudtyh@master>
	<20061017133907.7155b2ac.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2006 13:39:07 -0700
Andrew Morton <akpm@osdl.org> wrote:

> What we should have is set_bdi_read_congested(),
> clear_bdi_read_congested(), bdi_read_congested(), bdi_write_congested(),
> etc.  Some of these are already in backing-dev.h.
> 
> Sometime we should add [set|clear]_bdi_[read|write]_congested() to
> backing-dev.h and make the block code call them.  And move the waitqueue
> stuff in clear_queue_congested() out of the block layer and into, umm, mm/
> I guess.  And rename blk_congestion_wait() to congestion_wait() and move it
> into mm/ too.
> 
> If all of this is done, the kernel would actually link with CONFIG_BLOCK=n.

Like this, which compiles, but might need a few fixes yet.


From: Andrew Morton <akpm@osdl.org>

Separate out the concept of "queue congestion" frmo "backing-dev congestion". 
Congestion is a backing-dev concept, not a queue concept.

The blk_* congestion fucntions are retained, as wrappers around the core
backing-dev congestion functions.

This proper layering is needed so that NFS can cleanly use the congestion
functions, and so that CONFIG_BLOCK=n actually links.

Cc: "Thomas Maier" <balagi@justmail.de>
Cc: "Jens Axboe" <jens.axboe@oracle.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/i386/lib/usercopy.c    |    3 +
 block/ll_rw_blk.c           |   54 +--------------------------
 drivers/md/dm-crypt.c       |    3 +
 fs/fat/file.c               |    3 +
 fs/nfs/write.c              |    4 +-
 fs/reiserfs/journal.c       |    3 +
 fs/xfs/linux-2.6/kmem.c     |    5 +-
 fs/xfs/linux-2.6/xfs_buf.c  |    3 +
 include/linux/backing-dev.h |    7 +++
 include/linux/blkdev.h      |    2 -
 include/linux/writeback.h   |    1 
 mm/Makefile                 |    3 +
 mm/backing-dev.c            |   66 ++++++++++++++++++++++++++++++++++
 mm/page-writeback.c         |   17 ++------
 mm/page_alloc.c             |    5 +-
 mm/shmem.c                  |    3 +
 mm/vmscan.c                 |    6 +--
 17 files changed, 105 insertions(+), 83 deletions(-)

diff -puN block/ll_rw_blk.c~separate-bdi-congestion-functions-from-queue-congestion-functions block/ll_rw_blk.c
--- a/block/ll_rw_blk.c~separate-bdi-congestion-functions-from-queue-congestion-functions
+++ a/block/ll_rw_blk.c
@@ -56,11 +56,6 @@ static kmem_cache_t *requestq_cachep;
  */
 static kmem_cache_t *iocontext_cachep;
 
-static wait_queue_head_t congestion_wqh[2] = {
-		__WAIT_QUEUE_HEAD_INITIALIZER(congestion_wqh[0]),
-		__WAIT_QUEUE_HEAD_INITIALIZER(congestion_wqh[1])
-	};
-
 /*
  * Controlling structure to kblockd
  */
@@ -119,14 +114,7 @@ static void blk_queue_congestion_thresho
  */
 void blk_clear_queue_congested(request_queue_t *q, int rw)
 {
-	enum bdi_state bit;
-	wait_queue_head_t *wqh = &congestion_wqh[rw];
-
-	bit = (rw == WRITE) ? BDI_write_congested : BDI_read_congested;
-	clear_bit(bit, &q->backing_dev_info.state);
-	smp_mb__after_clear_bit();
-	if (waitqueue_active(wqh))
-		wake_up(wqh);
+	clear_bdi_congested(&q->backing_dev_info, rw);
 }
 EXPORT_SYMBOL(blk_clear_queue_congested);
 
@@ -136,10 +124,7 @@ EXPORT_SYMBOL(blk_clear_queue_congested)
  */
 void blk_set_queue_congested(request_queue_t *q, int rw)
 {
-	enum bdi_state bit;
-
-	bit = (rw == WRITE) ? BDI_write_congested : BDI_read_congested;
-	set_bit(bit, &q->backing_dev_info.state);
+	set_bdi_congested(&q->backing_dev_info, rw);
 }
 EXPORT_SYMBOL(blk_set_queue_congested);
 
@@ -2755,41 +2740,6 @@ void blk_end_sync_rq(struct request *rq,
 }
 EXPORT_SYMBOL(blk_end_sync_rq);
 
-/**
- * blk_congestion_wait - wait for a queue to become uncongested
- * @rw: READ or WRITE
- * @timeout: timeout in jiffies
- *
- * Waits for up to @timeout jiffies for a queue (any queue) to exit congestion.
- * If no queues are congested then just wait for the next request to be
- * returned.
- */
-long blk_congestion_wait(int rw, long timeout)
-{
-	long ret;
-	DEFINE_WAIT(wait);
-	wait_queue_head_t *wqh = &congestion_wqh[rw];
-
-	prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
-	ret = io_schedule_timeout(timeout);
-	finish_wait(wqh, &wait);
-	return ret;
-}
-
-EXPORT_SYMBOL(blk_congestion_wait);
-
-/**
- * blk_congestion_end - wake up sleepers on a congestion queue
- * @rw: READ or WRITE
- */
-void blk_congestion_end(int rw)
-{
-	wait_queue_head_t *wqh = &congestion_wqh[rw];
-
-	if (waitqueue_active(wqh))
-		wake_up(wqh);
-}
-
 /*
  * Has to be called with the request spinlock acquired
  */
diff -puN include/linux/backing-dev.h~separate-bdi-congestion-functions-from-queue-congestion-functions include/linux/backing-dev.h
--- a/include/linux/backing-dev.h~separate-bdi-congestion-functions-from-queue-congestion-functions
+++ a/include/linux/backing-dev.h
@@ -10,6 +10,8 @@
 
 #include <asm/atomic.h>
 
+struct page;
+
 /*
  * Bits in backing_dev_info.state
  */
@@ -88,6 +90,11 @@ static inline int bdi_rw_congested(struc
 				  (1 << BDI_write_congested));
 }
 
+void clear_bdi_congested(struct backing_dev_info *bdi, int rw);
+void set_bdi_congested(struct backing_dev_info *bdi, int rw);
+long congestion_wait(int rw, long timeout);
+void congestion_end(int rw);
+
 #define bdi_cap_writeback_dirty(bdi) \
 	(!((bdi)->capabilities & BDI_CAP_NO_WRITEBACK))
 
diff -puN /dev/null mm/backing-dev.c
--- /dev/null
+++ a/mm/backing-dev.c
@@ -0,0 +1,66 @@
+
+#include <linux/wait.h>
+#include <linux/backing-dev.h>
+#include <linux/fs.h>
+#include <linux/sched.h>
+#include <linux/module.h>
+
+static wait_queue_head_t congestion_wqh[2] = {
+		__WAIT_QUEUE_HEAD_INITIALIZER(congestion_wqh[0]),
+		__WAIT_QUEUE_HEAD_INITIALIZER(congestion_wqh[1])
+	};
+
+
+void clear_bdi_congested(struct backing_dev_info *bdi, int rw)
+{
+	enum bdi_state bit;
+	wait_queue_head_t *wqh = &congestion_wqh[rw];
+
+	bit = (rw == WRITE) ? BDI_write_congested : BDI_read_congested;
+	clear_bit(bit, &bdi->state);
+	smp_mb__after_clear_bit();
+	if (waitqueue_active(wqh))
+		wake_up(wqh);
+}
+
+void set_bdi_congested(struct backing_dev_info *bdi, int rw)
+{
+	enum bdi_state bit;
+
+	bit = (rw == WRITE) ? BDI_write_congested : BDI_read_congested;
+	set_bit(bit, &bdi->state);
+}
+
+/**
+ * congestion_wait - wait for a backing_dev to become uncongested
+ * @rw: READ or WRITE
+ * @timeout: timeout in jiffies
+ *
+ * Waits for up to @timeout jiffies for a backing_dev (any backing_dev) to exit
+ * write congestion.  If no backing_devs are congested then just wait for the
+ * next write to be completed.
+ */
+long congestion_wait(int rw, long timeout)
+{
+	long ret;
+	DEFINE_WAIT(wait);
+	wait_queue_head_t *wqh = &congestion_wqh[rw];
+
+	prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
+	ret = io_schedule_timeout(timeout);
+	finish_wait(wqh, &wait);
+	return ret;
+}
+
+/**
+ * congestion_end - wake up sleepers on a congested backing_dev_info
+ * @rw: READ or WRITE
+ */
+void congestion_end(int rw)
+{
+	wait_queue_head_t *wqh = &congestion_wqh[rw];
+
+	if (waitqueue_active(wqh))
+		wake_up(wqh);
+}
+EXPORT_SYMBOL(congestion_end);
diff -puN mm/page-writeback.c~separate-bdi-congestion-functions-from-queue-congestion-functions mm/page-writeback.c
--- a/mm/page-writeback.c~separate-bdi-congestion-functions-from-queue-congestion-functions
+++ a/mm/page-writeback.c
@@ -222,7 +222,7 @@ static void balance_dirty_pages(struct a
 			if (pages_written >= write_chunk)
 				break;		/* We've done our duty */
 		}
-		blk_congestion_wait(WRITE, HZ/10);
+		congestion_wait(WRITE, HZ/10);
 	}
 
 	if (nr_reclaimable + global_page_state(NR_WRITEBACK)
@@ -314,7 +314,7 @@ void throttle_vm_writeout(void)
                 if (global_page_state(NR_UNSTABLE_NFS) +
 			global_page_state(NR_WRITEBACK) <= dirty_thresh)
                         	break;
-                blk_congestion_wait(WRITE, HZ/10);
+                congestion_wait(WRITE, HZ/10);
         }
 }
 
@@ -351,7 +351,7 @@ static void background_writeout(unsigned
 		min_pages -= MAX_WRITEBACK_PAGES - wbc.nr_to_write;
 		if (wbc.nr_to_write > 0 || wbc.pages_skipped > 0) {
 			/* Wrote less than expected */
-			blk_congestion_wait(WRITE, HZ/10);
+			congestion_wait(WRITE, HZ/10);
 			if (!wbc.encountered_congestion)
 				break;
 		}
@@ -422,7 +422,7 @@ static void wb_kupdate(unsigned long arg
 		writeback_inodes(&wbc);
 		if (wbc.nr_to_write > 0) {
 			if (wbc.encountered_congestion)
-				blk_congestion_wait(WRITE, HZ/10);
+				congestion_wait(WRITE, HZ/10);
 			else
 				break;	/* All the old data is written */
 		}
@@ -956,15 +956,6 @@ int test_set_page_writeback(struct page 
 EXPORT_SYMBOL(test_set_page_writeback);
 
 /*
- * Wakes up tasks that are being throttled due to writeback congestion
- */
-void writeback_congestion_end(void)
-{
-	blk_congestion_end(WRITE);
-}
-EXPORT_SYMBOL(writeback_congestion_end);
-
-/*
  * Return true if any of the pages in the mapping are marged with the
  * passed tag.
  */
diff -puN mm/page_alloc.c~separate-bdi-congestion-functions-from-queue-congestion-functions mm/page_alloc.c
--- a/mm/page_alloc.c~separate-bdi-congestion-functions-from-queue-congestion-functions
+++ a/mm/page_alloc.c
@@ -39,6 +39,7 @@
 #include <linux/stop_machine.h>
 #include <linux/sort.h>
 #include <linux/pfn.h>
+#include <linux/backing-dev.h>
 
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -1050,7 +1051,7 @@ nofail_alloc:
 			if (page)
 				goto got_pg;
 			if (gfp_mask & __GFP_NOFAIL) {
-				blk_congestion_wait(WRITE, HZ/50);
+				congestion_wait(WRITE, HZ/50);
 				goto nofail_alloc;
 			}
 		}
@@ -1113,7 +1114,7 @@ rebalance:
 			do_retry = 1;
 	}
 	if (do_retry) {
-		blk_congestion_wait(WRITE, HZ/50);
+		congestion_wait(WRITE, HZ/50);
 		goto rebalance;
 	}
 
diff -puN mm/shmem.c~separate-bdi-congestion-functions-from-queue-congestion-functions mm/shmem.c
--- a/mm/shmem.c~separate-bdi-congestion-functions-from-queue-congestion-functions
+++ a/mm/shmem.c
@@ -48,6 +48,7 @@
 #include <linux/ctype.h>
 #include <linux/migrate.h>
 #include <linux/highmem.h>
+#include <linux/backing-dev.h>
 
 #include <asm/uaccess.h>
 #include <asm/div64.h>
@@ -1131,7 +1132,7 @@ repeat:
 			page_cache_release(swappage);
 			if (error == -ENOMEM) {
 				/* let kswapd refresh zone for GFP_ATOMICs */
-				blk_congestion_wait(WRITE, HZ/50);
+				congestion_wait(WRITE, HZ/50);
 			}
 			goto repeat;
 		}
diff -puN mm/vmscan.c~separate-bdi-congestion-functions-from-queue-congestion-functions mm/vmscan.c
--- a/mm/vmscan.c~separate-bdi-congestion-functions-from-queue-congestion-functions
+++ a/mm/vmscan.c
@@ -1059,7 +1059,7 @@ unsigned long try_to_free_pages(struct z
 
 		/* Take a nap, wait for some writeback to complete */
 		if (sc.nr_scanned && priority < DEF_PRIORITY - 2)
-			blk_congestion_wait(WRITE, HZ/10);
+			congestion_wait(WRITE, HZ/10);
 	}
 	/* top priority shrink_caches still had more to do? don't OOM, then */
 	if (!sc.all_unreclaimable)
@@ -1214,7 +1214,7 @@ scan:
 		 * another pass across the zones.
 		 */
 		if (total_scanned && priority < DEF_PRIORITY - 2)
-			blk_congestion_wait(WRITE, HZ/10);
+			congestion_wait(WRITE, HZ/10);
 
 		/*
 		 * We do this so kswapd doesn't build up large priorities for
@@ -1458,7 +1458,7 @@ unsigned long shrink_all_memory(unsigned
 				goto out;
 
 			if (sc.nr_scanned && prio < DEF_PRIORITY - 2)
-				blk_congestion_wait(WRITE, HZ / 10);
+				congestion_wait(WRITE, HZ / 10);
 		}
 
 		lru_pages = 0;
diff -puN include/linux/blkdev.h~separate-bdi-congestion-functions-from-queue-congestion-functions include/linux/blkdev.h
--- a/include/linux/blkdev.h~separate-bdi-congestion-functions-from-queue-congestion-functions
+++ a/include/linux/blkdev.h
@@ -767,10 +767,8 @@ extern int blk_queue_init_tags(request_q
 extern void blk_queue_free_tags(request_queue_t *);
 extern int blk_queue_resize_tags(request_queue_t *, int);
 extern void blk_queue_invalidate_tags(request_queue_t *);
-extern long blk_congestion_wait(int rw, long timeout);
 extern struct blk_queue_tag *blk_init_tags(int);
 extern void blk_free_tags(struct blk_queue_tag *);
-extern void blk_congestion_end(int rw);
 
 static inline struct request *blk_map_queue_find_tag(struct blk_queue_tag *bqt,
 						int tag)
diff -puN mm/Makefile~separate-bdi-congestion-functions-from-queue-congestion-functions mm/Makefile
--- a/mm/Makefile~separate-bdi-congestion-functions-from-queue-congestion-functions
+++ a/mm/Makefile
@@ -10,7 +10,8 @@ mmu-$(CONFIG_MMU)	:= fremap.o highmem.o 
 obj-y			:= bootmem.o filemap.o mempool.o oom_kill.o fadvise.o \
 			   page_alloc.o page-writeback.o pdflush.o \
 			   readahead.o swap.o truncate.o vmscan.o \
-			   prio_tree.o util.o mmzone.o vmstat.o $(mmu-y)
+			   prio_tree.o util.o mmzone.o vmstat.o backing-dev.o \
+			   $(mmu-y)
 
 ifeq ($(CONFIG_MMU)$(CONFIG_BLOCK),yy)
 obj-y			+= bounce.o
diff -puN arch/i386/lib/usercopy.c~separate-bdi-congestion-functions-from-queue-congestion-functions arch/i386/lib/usercopy.c
--- a/arch/i386/lib/usercopy.c~separate-bdi-congestion-functions-from-queue-congestion-functions
+++ a/arch/i386/lib/usercopy.c
@@ -9,6 +9,7 @@
 #include <linux/highmem.h>
 #include <linux/blkdev.h>
 #include <linux/module.h>
+#include <linux/backing-dev.h>
 #include <asm/uaccess.h>
 #include <asm/mmx.h>
 
@@ -741,7 +742,7 @@ survive:
 
 			if (retval == -ENOMEM && is_init(current)) {
 				up_read(&current->mm->mmap_sem);
-				blk_congestion_wait(WRITE, HZ/50);
+				congestion_wait(WRITE, HZ/50);
 				goto survive;
 			}
 
diff -puN drivers/md/dm-crypt.c~separate-bdi-congestion-functions-from-queue-congestion-functions drivers/md/dm-crypt.c
--- a/drivers/md/dm-crypt.c~separate-bdi-congestion-functions-from-queue-congestion-functions
+++ a/drivers/md/dm-crypt.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/crypto.h>
 #include <linux/workqueue.h>
+#include <linux/backing-dev.h>
 #include <asm/atomic.h>
 #include <linux/scatterlist.h>
 #include <asm/page.h>
@@ -602,7 +603,7 @@ static void process_write(struct crypt_i
 
 		/* out of memory -> run queues */
 		if (remaining)
-			blk_congestion_wait(bio_data_dir(clone), HZ/100);
+			congestion_wait(bio_data_dir(clone), HZ/100);
 	}
 }
 
diff -puN fs/fat/file.c~separate-bdi-congestion-functions-from-queue-congestion-functions fs/fat/file.c
--- a/fs/fat/file.c~separate-bdi-congestion-functions-from-queue-congestion-functions
+++ a/fs/fat/file.c
@@ -13,6 +13,7 @@
 #include <linux/smp_lock.h>
 #include <linux/buffer_head.h>
 #include <linux/writeback.h>
+#include <linux/backing-dev.h>
 #include <linux/blkdev.h>
 
 int fat_generic_ioctl(struct inode *inode, struct file *filp,
@@ -118,7 +119,7 @@ static int fat_file_release(struct inode
 	if ((filp->f_mode & FMODE_WRITE) &&
 	     MSDOS_SB(inode->i_sb)->options.flush) {
 		fat_flush_inodes(inode->i_sb, inode, NULL);
-		blk_congestion_wait(WRITE, HZ/10);
+		congestion_wait(WRITE, HZ/10);
 	}
 	return 0;
 }
diff -puN fs/reiserfs/journal.c~separate-bdi-congestion-functions-from-queue-congestion-functions fs/reiserfs/journal.c
--- a/fs/reiserfs/journal.c~separate-bdi-congestion-functions-from-queue-congestion-functions
+++ a/fs/reiserfs/journal.c
@@ -53,6 +53,7 @@
 #include <linux/workqueue.h>
 #include <linux/writeback.h>
 #include <linux/blkdev.h>
+#include <linux/backing-dev.h>
 
 /* gets a struct reiserfs_journal_list * from a list head */
 #define JOURNAL_LIST_ENTRY(h) (list_entry((h), struct reiserfs_journal_list, \
@@ -970,7 +971,7 @@ int reiserfs_async_progress_wait(struct 
 	DEFINE_WAIT(wait);
 	struct reiserfs_journal *j = SB_JOURNAL(s);
 	if (atomic_read(&j->j_async_throttle))
-		blk_congestion_wait(WRITE, HZ / 10);
+		congestion_wait(WRITE, HZ / 10);
 	return 0;
 }
 
diff -puN fs/xfs/linux-2.6/kmem.c~separate-bdi-congestion-functions-from-queue-congestion-functions fs/xfs/linux-2.6/kmem.c
--- a/fs/xfs/linux-2.6/kmem.c~separate-bdi-congestion-functions-from-queue-congestion-functions
+++ a/fs/xfs/linux-2.6/kmem.c
@@ -21,6 +21,7 @@
 #include <linux/highmem.h>
 #include <linux/swap.h>
 #include <linux/blkdev.h>
+#include <linux/backing-dev.h>
 #include "time.h"
 #include "kmem.h"
 
@@ -53,7 +54,7 @@ kmem_alloc(size_t size, unsigned int __n
 			printk(KERN_ERR "XFS: possible memory allocation "
 					"deadlock in %s (mode:0x%x)\n",
 					__FUNCTION__, lflags);
-		blk_congestion_wait(WRITE, HZ/50);
+		congestion_wait(WRITE, HZ/50);
 	} while (1);
 }
 
@@ -131,7 +132,7 @@ kmem_zone_alloc(kmem_zone_t *zone, unsig
 			printk(KERN_ERR "XFS: possible memory allocation "
 					"deadlock in %s (mode:0x%x)\n",
 					__FUNCTION__, lflags);
-		blk_congestion_wait(WRITE, HZ/50);
+		congestion_wait(WRITE, HZ/50);
 	} while (1);
 }
 
diff -puN fs/xfs/linux-2.6/xfs_buf.c~separate-bdi-congestion-functions-from-queue-congestion-functions fs/xfs/linux-2.6/xfs_buf.c
--- a/fs/xfs/linux-2.6/xfs_buf.c~separate-bdi-congestion-functions-from-queue-congestion-functions
+++ a/fs/xfs/linux-2.6/xfs_buf.c
@@ -30,6 +30,7 @@
 #include <linux/hash.h>
 #include <linux/kthread.h>
 #include <linux/migrate.h>
+#include <linux/backing-dev.h>
 #include "xfs_linux.h"
 
 STATIC kmem_zone_t *xfs_buf_zone;
@@ -395,7 +396,7 @@ _xfs_buf_lookup_pages(
 
 			XFS_STATS_INC(xb_page_retries);
 			xfsbufd_wakeup(0, gfp_mask);
-			blk_congestion_wait(WRITE, HZ/50);
+			congestion_wait(WRITE, HZ/50);
 			goto retry;
 		}
 
diff -puN fs/nfs/write.c~separate-bdi-congestion-functions-from-queue-congestion-functions fs/nfs/write.c
--- a/fs/nfs/write.c~separate-bdi-congestion-functions-from-queue-congestion-functions
+++ a/fs/nfs/write.c
@@ -57,6 +57,8 @@
 #include <linux/nfs_fs.h>
 #include <linux/nfs_mount.h>
 #include <linux/nfs_page.h>
+#include <linux/backing-dev.h>
+
 #include <asm/uaccess.h>
 #include <linux/smp_lock.h>
 
@@ -395,7 +397,7 @@ int nfs_writepages(struct address_space 
 out:
 	clear_bit(BDI_write_congested, &bdi->state);
 	wake_up_all(&nfs_write_congestion);
-	writeback_congestion_end();
+	congestion_end(WRITE);
 	return err;
 }
 
diff -puN include/linux/writeback.h~separate-bdi-congestion-functions-from-queue-congestion-functions include/linux/writeback.h
--- a/include/linux/writeback.h~separate-bdi-congestion-functions-from-queue-congestion-functions
+++ a/include/linux/writeback.h
@@ -85,7 +85,6 @@ int wakeup_pdflush(long nr_pages);
 void laptop_io_completion(void);
 void laptop_sync_completion(void);
 void throttle_vm_writeout(void);
-void writeback_congestion_end(void);
 
 /* These are exported to sysctl. */
 extern int dirty_background_ratio;
_


