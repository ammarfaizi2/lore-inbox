Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291624AbSBMMwX>; Wed, 13 Feb 2002 07:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291618AbSBMMwK>; Wed, 13 Feb 2002 07:52:10 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:44556 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S291619AbSBMMvo>;
	Wed, 13 Feb 2002 07:51:44 -0500
Date: Wed, 13 Feb 2002 13:51:34 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] queue barrier support
Message-ID: <20020213135134.A1907@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PmA2V3Z32TCmWXqI"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Chris finally got me back in gear with the write barrier patch (for 2.4,
2.5 had a few missing pieces). The following changesets exists:

ChangeSet@1.295, 2002-02-13 13:22:40+01:00, axboe@burns.home.kernel.dk
  Misc small changes and fixes to properly support barrier writes for
  journalled file systems. The support was basically already there
  with the bio merge, since it had not been used at all there were a
  few loose ends though.

  http://bitmover.com:8888//tmp/v2_logging/athlon.transmeta.com/torvalds-20020205173056-16047-c1d11a41ed024864/cset@1.133.114.2?nav=index.html|ChangeSet@-1h


ChangeSet@1.296, 2002-02-13 13:23:34+01:00, axboe@burns.home.kernel.dk
  IDE barrier write support through write cache flushing.

  http://bitmover.com:8888//tmp/v2_logging/athlon.transmeta.com/torvalds-20020205173056-16047-c1d11a41ed024864/cset@1.133.114.3?nav=index.html|ChangeSet@-1h


ChangeSet@1.297, 2002-02-13 13:42:39+01:00, axboe@burns.home.kernel.dk
  Add support for SCSI drivers to indicate support for ordered tags

  http://bitmover.com:8888//tmp/v2_logging/athlon.transmeta.com/torvalds-20020205173056-16047-c1d11a41ed024864/cset@1.133.114.4?nav=index.html|ChangeSet@-1h


ChangeSet@1.298, 2002-02-13 13:43:04+01:00, axboe@burns.home.kernel.dk
  Add ordered tag support to the aic7xxx scsi driver

  http://bitmover.com:8888//tmp/v2_logging/athlon.transmeta.com/torvalds-20020205173056-16047-c1d11a41ed024864/cset@1.133.114.5?nav=index.html|ChangeSet@-1h


ChangeSet@1.299, 2002-02-13 13:44:18+01:00, axboe@burns.home.kernel.dk
  reiserfs barrier write support

  http://bitmover.com:8888//tmp/v2_logging/athlon.transmeta.com/torvalds-20020205173056-16047-c1d11a41ed024864/cset@1.133.114.6?nav=index.html|ChangeSet@-1h

Patches attached, comments welcome.

-- 
Jens Axboe


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="barrier-1-c1.295"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.294   -> 1.295  
#	drivers/block/ll_rw_blk.c	1.46    -> 1.47   
#	include/linux/blkdev.h	1.31    -> 1.32   
#	 include/linux/bio.h	1.12    -> 1.13   
#	  include/linux/fs.h	1.81    -> 1.82   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/02/13	axboe@burns.home.kernel.dk	1.295
# Misc small changes and fixes to properly support barrier writes for
# journalled file systems. The support was basically already there
# with the bio merge, since it had not been used at all there were a
# few loose ends though.
# --------------------------------------------
#
diff -Nru a/drivers/block/ll_rw_blk.c b/drivers/block/ll_rw_blk.c
--- a/drivers/block/ll_rw_blk.c	Wed Feb 13 13:48:11 2002
+++ b/drivers/block/ll_rw_blk.c	Wed Feb 13 13:48:11 2002
@@ -123,6 +123,31 @@
 }
 
 /**
+ * blk_queue_ordered - does this queue support ordered writes
+ * @q:     the request queue
+ * @flag:  see below
+ *
+ * Description:
+ *   For journalled file systems, doing ordered writes on a commit
+ *   block instead of explicitly doing wait_on_buffer (which is bad
+ *   for performance) can be a big win. Block drivers supporting this
+ *   feature should call this function and indicate so.
+ *
+ *   SCSI drivers usually need to support ordered tags, while others
+ *   may have to do a complete drive cache flush if they are using write
+ *   back caching (or not and lying about it)
+ *
+ *   With this in mind, the values are
+ *             QUEUE_ORDERED_NONE:	the default, doesn't support barrier
+ *             QUEUE_ORDERED_TAG:	supports ordered tags
+ *             QUEUE_ORDERED_FLUSH:	supports barrier through cache flush
+ **/
+void blk_queue_ordered(request_queue_t *q, int flag)
+{
+	q->queue_barrier = flag;
+}
+
+/**
  * blk_queue_make_request - define an alternate make_request function for a device
  * @q:  the request queue for the device to be affected
  * @mfn: the alternate make_request function
@@ -1099,7 +1124,12 @@
 
 	spin_lock_prefetch(q->queue_lock);
 
-	barrier = test_bit(BIO_RW_BARRIER, &bio->bi_rw);
+	barrier = bio_barrier(bio);
+
+	if (barrier && q->queue_barrier == QUEUE_BARRIER_NONE) {
+		set_bit(BIO_OPNOTSUPP, &bio->bi_flags);
+		goto end_io;
+	}
 
 	spin_lock_irq(q->queue_lock);
 again:
@@ -1380,7 +1410,7 @@
 	BIO_BUG_ON(!bio->bi_size);
 	BIO_BUG_ON(!bio->bi_io_vec);
 
-	bio->bi_rw = rw;
+	bio->bi_rw |= rw;
 
 	if (rw & WRITE)
 		kstat.pgpgout += count;
@@ -1425,6 +1455,9 @@
 
 	bio->bi_end_io = end_bio_bh_io_sync;
 	bio->bi_private = bh;
+
+	if (buffer_ordered(bh))
+		bio->bi_rw |= 1 << BIO_RW_BARRIER;
 
 	return submit_bio(rw, bio);
 }
diff -Nru a/include/linux/bio.h b/include/linux/bio.h
--- a/include/linux/bio.h	Wed Feb 13 13:48:11 2002
+++ b/include/linux/bio.h	Wed Feb 13 13:48:11 2002
@@ -101,6 +101,7 @@
 #define BIO_EOF		2	/* out-out-bounds error */
 #define BIO_SEG_VALID	3	/* nr_hw_seg valid */
 #define BIO_CLONED	4	/* doesn't own data */
+#define BIO_OPNOTSUPP	5	/* not supported */
 
 /*
  * bio bi_rw flags
@@ -123,7 +124,7 @@
 #define bio_offset(bio)		bio_iovec((bio))->bv_offset
 #define bio_sectors(bio)	((bio)->bi_size >> 9)
 #define bio_data(bio)		(page_address(bio_page((bio))) + bio_offset((bio)))
-#define bio_barrier(bio)	((bio)->bi_rw & (1 << BIO_BARRIER))
+#define bio_barrier(bio)	((bio)->bi_rw & (1 << BIO_RW_BARRIER))
 
 /*
  * will die
diff -Nru a/include/linux/blkdev.h b/include/linux/blkdev.h
--- a/include/linux/blkdev.h	Wed Feb 13 13:48:11 2002
+++ b/include/linux/blkdev.h	Wed Feb 13 13:48:11 2002
@@ -174,6 +174,8 @@
 	 */
 	unsigned long		queue_flags;
 
+	char			queue_barrier;
+
 	/*
 	 * protects queue structures from reentrancy
 	 */
@@ -202,6 +204,10 @@
 #define QUEUE_FLAG_PLUGGED	0	/* queue is plugged */
 #define QUEUE_FLAG_CLUSTER	1	/* cluster several segments into 1 */
 
+#define QUEUE_BARRIER_NONE	0	/* barrier not supported */
+#define QUEUE_BARRIER_TAG	1	/* barrier supported through tags */
+#define QUEUE_BARRIER_FLUSH	2	/* barrier supported through flush */
+
 #define blk_queue_plugged(q)	test_bit(QUEUE_FLAG_PLUGGED, &(q)->queue_flags)
 #define blk_mark_plugged(q)	set_bit(QUEUE_FLAG_PLUGGED, &(q)->queue_flags)
 #define blk_queue_empty(q)	elv_queue_empty(q)
@@ -308,6 +314,7 @@
 extern void blk_queue_segment_boundary(request_queue_t *q, unsigned long);
 extern void blk_queue_assign_lock(request_queue_t *q, spinlock_t *);
 extern void blk_queue_prep_rq(request_queue_t *q, prep_rq_fn *pfn);
+extern void blk_queue_ordered(request_queue_t *, int);
 
 extern int blk_rq_map_sg(request_queue_t *, struct request *, struct scatterlist *);
 extern void blk_dump_rq_flags(struct request *, char *);
diff -Nru a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Wed Feb 13 13:48:11 2002
+++ b/include/linux/fs.h	Wed Feb 13 13:48:11 2002
@@ -221,6 +221,7 @@
 	BH_Wait_IO,	/* 1 if we should write out this buffer */
 	BH_launder,	/* 1 if we should throttle on this buffer */
 	BH_JBD,		/* 1 if it has an attached journal_head */
+	BH_Ordered,	/* 1 if this buffer is a write barrier */
 
 	BH_PrivateStart,/* not a state bit, but the first bit available
 			 * for private allocation by other entities
@@ -278,6 +279,7 @@
 #define buffer_mapped(bh)	__buffer_state(bh,Mapped)
 #define buffer_new(bh)		__buffer_state(bh,New)
 #define buffer_async(bh)	__buffer_state(bh,Async)
+#define buffer_ordered(bh)	__buffer_state(bh,Ordered)
 
 #define bh_offset(bh)		((unsigned long)(bh)->b_data & ~PAGE_MASK)
 

--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="ide-barrier-1-c1.296"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.295   -> 1.296  
#	drivers/ide/ide-probe.c	1.16    -> 1.17   
#	 include/linux/ide.h	1.11    -> 1.12   
#	   drivers/ide/ide.c	1.27    -> 1.28   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/02/13	axboe@burns.home.kernel.dk	1.296
# IDE barrier write support through write cache flushing.
# --------------------------------------------
#
diff -Nru a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c	Wed Feb 13 13:48:25 2002
+++ b/drivers/ide/ide-probe.c	Wed Feb 13 13:48:25 2002
@@ -633,6 +633,9 @@
 
 	/* This is a driver limit and could be eliminated. */
 	blk_queue_max_phys_segments(q, PRD_ENTRIES);
+
+	/* assume all drivers can do ordered flush, disable this later if not */
+	blk_queue_ordered(q, QUEUE_BARRIER_FLUSH);
 }
 
 /*
diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	Wed Feb 13 13:48:25 2002
+++ b/drivers/ide/ide.c	Wed Feb 13 13:48:25 2002
@@ -372,6 +372,32 @@
 	return system_bus_speed;
 }
 
+static struct request *ide_queue_flush_cmd(ide_drive_t *drive, struct request *rq, int post)
+{
+	struct request *flush_rq = &HWGROUP(drive)->wrq;
+
+	elv_remove_request(&drive->queue, rq);
+
+	memset(drive->special_buf, 0, sizeof(drive->special_buf));
+
+	ide_init_drive_cmd(flush_rq);
+
+	flush_rq->flags |= REQ_BARRIER;
+	flush_rq->buffer = drive->special_buf;
+	flush_rq->special = rq;
+
+	flush_rq->buffer[0] = (drive->id->cfs_enable_2 & 0x2400) ? WIN_FLUSH_CACHE_EXT : WIN_FLUSH_CACHE;
+
+	/*
+	 * just signal that this is the post-barrier flush
+	 */
+	if (post)
+		flush_rq->flags |= REQ_SPECIAL;
+
+	_elv_add_request(&drive->queue, flush_rq, 0, 0);
+	return flush_rq;
+}
+
 inline int __ide_end_request(ide_hwgroup_t *hwgroup, int uptodate, int nr_secs)
 {
 	ide_drive_t *drive = hwgroup->drive;
@@ -404,7 +430,17 @@
 		add_blkdev_randomness(major(rq->rq_dev));
 		blkdev_dequeue_request(rq);
         	hwgroup->rq = NULL;
-		end_that_request_last(rq);
+
+		/*
+		 * if this is a write barrier, flush the writecache before
+		 * allowing new requests to finsh and before signalling
+		 * completion of this request
+		 */
+		if (rq->flags & REQ_BARRIER)
+			ide_queue_flush_cmd(drive, rq, 1);
+		else
+			end_that_request_last(rq);
+
 		ret = 0;
 	}
 
@@ -757,8 +793,33 @@
 
 	blkdev_dequeue_request(rq);
 	HWGROUP(drive)->rq = NULL;
-	end_that_request_last(rq);
 
+	/*
+	 * if a cache flush fails, disable ordered write support
+	 */
+	if (rq->flags & REQ_BARRIER) {
+		struct request *real_rq = rq->special;
+
+		/*
+		 * best-effort currently, this ignores the fact that there
+		 * may be other barriers currently queued that we can't
+		 * honor any more
+		 */
+		if (err)
+			blk_queue_ordered(&drive->queue, QUEUE_BARRIER_NONE);
+
+		if (rq->flags & REQ_SPECIAL) 
+			end_that_request_last(real_rq);
+		else {
+			/*
+			 * just indicate that we did the pre flush
+			 */
+			real_rq->flags |= REQ_SPECIAL;
+			_elv_add_request(&drive->queue, real_rq, 0, 0);
+		}
+	}
+
+	end_that_request_last(rq);
 	spin_unlock_irqrestore(&ide_lock, flags);
 }
 
@@ -1376,10 +1437,16 @@
 		if (blk_queue_plugged(&drive->queue))
 			BUG();
 
+		rq = elv_next_request(&drive->queue);
+
 		/*
-		 * just continuing an interrupted request maybe
+		 * if rq is a barrier write, issue pre cache flush if not
+		 * already done
 		 */
-		rq = hwgroup->rq = elv_next_request(&drive->queue);
+		if (!(rq->flags ^ (REQ_BARRIER | REQ_SPECIAL)))
+			rq = ide_queue_flush_cmd(drive, rq, 0);
+
+		hwgroup->rq = rq;
 
 		/*
 		 * Some systems have trouble with IDE IRQs arriving while
diff -Nru a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h	Wed Feb 13 13:48:25 2002
+++ b/include/linux/ide.h	Wed Feb 13 13:48:25 2002
@@ -448,6 +448,7 @@
 	byte		acoustic;	/* acoustic management */
 	unsigned int	failures;	/* current failure count */
 	unsigned int	max_failures;	/* maximum allowed failure count */
+	char		special_buf[4];	/* IDE_DRIVE_CMD, free use */
 } ide_drive_t;
 
 /*

--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="scsi-barrier-1-c1.297"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.296   -> 1.297  
#	drivers/scsi/hosts.c	1.8     -> 1.9    
#	drivers/scsi/hosts.h	1.8     -> 1.9    
#	 drivers/scsi/scsi.c	1.24    -> 1.25   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/02/13	axboe@burns.home.kernel.dk	1.297
# Add support for SCSI drivers to indicate support for ordered tags
# --------------------------------------------
#
diff -Nru a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
--- a/drivers/scsi/hosts.c	Wed Feb 13 13:50:02 2002
+++ b/drivers/scsi/hosts.c	Wed Feb 13 13:50:02 2002
@@ -230,6 +230,7 @@
 
     retval->select_queue_depths = tpnt->select_queue_depths;
     retval->max_sectors = tpnt->max_sectors;
+    retval->can_order = tpnt->can_order;
 
     if(!scsi_hostlist)
 	scsi_hostlist = retval;
diff -Nru a/drivers/scsi/hosts.h b/drivers/scsi/hosts.h
--- a/drivers/scsi/hosts.h	Wed Feb 13 13:50:02 2002
+++ b/drivers/scsi/hosts.h	Wed Feb 13 13:50:02 2002
@@ -286,6 +286,8 @@
 
     unsigned highmem_io:1;
 
+    unsigned can_order:1;
+
     /*
      * Name of proc directory
      */
@@ -386,6 +388,7 @@
     unsigned unchecked_isa_dma:1;
     unsigned use_clustering:1;
     unsigned highmem_io:1;
+    unsigned can_order:1;
 
     /*
      * Host has rejected a command because it was busy.
diff -Nru a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
--- a/drivers/scsi/scsi.c	Wed Feb 13 13:50:02 2002
+++ b/drivers/scsi/scsi.c	Wed Feb 13 13:50:02 2002
@@ -215,6 +215,8 @@
 
 	if (!SHpnt->use_clustering)
 		clear_bit(QUEUE_FLAG_CLUSTER, &q->queue_flags);
+	if (SHpnt->can_order)
+		blk_queue_ordered(&SDpnt->request_queue, QUEUE_BARRIER_TAG);
 }
 
 #ifdef MODULE

--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="aic7xxx-barrier-1-c1.298"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.297   -> 1.298  
#	drivers/scsi/aic7xxx/aic7xxx_linux_host.h	1.5     -> 1.6    
#	drivers/scsi/aic7xxx/aic7xxx_linux.c	1.15    -> 1.16   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/02/13	axboe@burns.home.kernel.dk	1.298
# Add ordered tag support to the aic7xxx scsi driver
# --------------------------------------------
#
diff -Nru a/drivers/scsi/aic7xxx/aic7xxx_linux.c b/drivers/scsi/aic7xxx/aic7xxx_linux.c
--- a/drivers/scsi/aic7xxx/aic7xxx_linux.c	Wed Feb 13 13:50:23 2002
+++ b/drivers/scsi/aic7xxx/aic7xxx_linux.c	Wed Feb 13 13:50:23 2002
@@ -1635,6 +1635,9 @@
 			}
 		}
 
+		if (cmd->request.flags & REQ_BARRIER)
+			hscb->control |= MSG_ORDERED_Q_TAG;
+
 		hscb->cdb_len = cmd->cmd_len;
 		if (hscb->cdb_len <= 12) {
 			memcpy(hscb->shared_data.cdb, cmd->cmnd, hscb->cdb_len);
diff -Nru a/drivers/scsi/aic7xxx/aic7xxx_linux_host.h b/drivers/scsi/aic7xxx/aic7xxx_linux_host.h
--- a/drivers/scsi/aic7xxx/aic7xxx_linux_host.h	Wed Feb 13 13:50:23 2002
+++ b/drivers/scsi/aic7xxx/aic7xxx_linux_host.h	Wed Feb 13 13:50:23 2002
@@ -89,7 +89,8 @@
 	present: 0,		/* number of 7xxx's present   */\
 	unchecked_isa_dma: 0,	/* no memory DMA restrictions */\
 	use_clustering: ENABLE_CLUSTERING,			\
-	highmem_io: 1						\
+	highmem_io: 1,						\
+	can_order: 1,						\
 }
 
 #endif /* _AIC7XXX_LINUX_HOST_H_ */

--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="reiser-barrier-1-c1.299"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.298   -> 1.299  
#	fs/reiserfs/journal.c	1.27    -> 1.28   
#	 fs/reiserfs/super.c	1.28    -> 1.29   
#	include/linux/reiserfs_fs_sb.h	1.9     -> 1.10   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/02/13	axboe@burns.home.kernel.dk	1.299
# reiserfs barrier write support
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
--- a/fs/reiserfs/journal.c	Wed Feb 13 13:50:34 2002
+++ b/fs/reiserfs/journal.c	Wed Feb 13 13:50:34 2002
@@ -115,6 +115,21 @@
   return 0 ;
 }
 
+static int barrier_wait_on_buffer(struct super_block *s, struct buffer_head *bh)
+{
+    int ordered = test_and_clear_bit(BH_Ordered, &bh->b_state) ;
+    if (!reiserfs_barrier(s) || ordered) {
+        wait_on_buffer(bh) ;
+    }
+    return 0 ;
+}
+
+static void mark_barrier(struct super_block *s, struct buffer_head *bh)
+{
+	if (reiserfs_barrier(s))
+		set_bit(BH_Ordered, &bh->b_state);
+}
+
 static struct reiserfs_bitmap_node *
 allocate_bitmap_node(struct super_block *p_s_sb) {
   struct reiserfs_bitmap_node *bn ;
@@ -721,7 +736,7 @@
       bn = SB_ONDISK_JOURNAL_1st_BLOCK(s) + (jl->j_start + i) % SB_ONDISK_JOURNAL_SIZE(s) ;
       tbh = get_hash_table(SB_JOURNAL_DEV(s), bn, s->s_blocksize) ;
 
-      wait_on_buffer(tbh) ;
+      barrier_wait_on_buffer(s, tbh) ;
       if (!buffer_uptodate(tbh)) {
 	reiserfs_panic(s, "journal-601, buffer write failed\n") ;
       }
@@ -741,9 +756,10 @@
 		   atomic_read(&(jl->j_commit_left)));
   }
 
+  mark_barrier(s, jl->j_commit_bh);
   mark_buffer_dirty(jl->j_commit_bh) ;
   ll_rw_block(WRITE, 1, &(jl->j_commit_bh)) ;
-  wait_on_buffer(jl->j_commit_bh) ;
+  barrier_wait_on_buffer(s, jl->j_commit_bh) ;
   if (!buffer_uptodate(jl->j_commit_bh)) {
     reiserfs_panic(s, "journal-615: buffer write failed\n") ;
   }
@@ -835,8 +851,9 @@
     jh->j_first_unflushed_offset = cpu_to_le32(offset) ;
     jh->j_mount_id = cpu_to_le32(SB_JOURNAL(p_s_sb)->j_mount_id) ;
     set_bit(BH_Dirty, &(SB_JOURNAL(p_s_sb)->j_header_bh->b_state)) ;
+    mark_barrier(p_s_sb, SB_JOURNAL(p_s_sb)->j_header_bh);
     ll_rw_block(WRITE, 1, &(SB_JOURNAL(p_s_sb)->j_header_bh)) ;
-    wait_on_buffer((SB_JOURNAL(p_s_sb)->j_header_bh)) ; 
+    barrier_wait_on_buffer(p_s_sb, (SB_JOURNAL(p_s_sb)->j_header_bh)) ; 
     if (!buffer_uptodate(SB_JOURNAL(p_s_sb)->j_header_bh)) {
       printk( "reiserfs: journal-837: IO error during journal replay\n" );
       return -EIO ;
@@ -1057,7 +1074,7 @@
 	if (!cn->bh) {
 	  reiserfs_panic(s, "journal-1011: cn->bh is NULL\n") ;
 	}
-	wait_on_buffer(cn->bh) ;
+	barrier_wait_on_buffer(s, cn->bh) ;
 	if (!cn->bh) {
 	  reiserfs_panic(s, "journal-1012: cn->bh is NULL\n") ;
 	}
@@ -1163,7 +1180,7 @@
         } else if (test_bit(BLOCK_NEEDS_FLUSH, &cn->state)) {
             clear_bit(BLOCK_NEEDS_FLUSH, &cn->state) ;
             if (!pjl && cn->bh) {
-                wait_on_buffer(cn->bh) ;
+                barrier_wait_on_buffer(s, cn->bh) ;
             }
             /* check again, someone could have logged while we scheduled */
             pjl = find_newer_jl_for_cn(cn) ;
diff -Nru a/fs/reiserfs/super.c b/fs/reiserfs/super.c
--- a/fs/reiserfs/super.c	Wed Feb 13 13:50:34 2002
+++ b/fs/reiserfs/super.c	Wed Feb 13 13:50:34 2002
@@ -380,6 +380,9 @@
     reiserfs_prepare_for_journal(s, SB_BUFFER_WITH_SB(s), 1) ;
     set_sb_umount_state( SB_DISK_SUPER_BLOCK(s), s->u.reiserfs_sb.s_mount_state );
     journal_mark_dirty(&th, s, SB_BUFFER_WITH_SB (s));
+
+    /* force full waits when unmounting */
+    s->u.reiserfs_sb.s_mount_opt &= ~(1 << REISERFS_BARRIER) ;
   }
 
   /* note, journal_release checks for readonly mount, and can decide not
@@ -528,6 +531,9 @@
 	    set_bit (REISERFS_NO_UNHASHED_RELOCATION, mount_options);
 	} else if (!strcmp (this_char, "hashed_relocation")) {
 	    set_bit (REISERFS_HASHED_RELOCATION, mount_options);
+	} else if (!strcmp (this_char, "barrier")) {
+	    set_bit (REISERFS_BARRIER, mount_options);
+	    printk("reiserfs: enabling write barrier code\n") ;
 	} else if (!strcmp (this_char, "test4")) {
 	    set_bit (REISERFS_TEST4, mount_options);
 	} else if (!strcmp (this_char, "nolog")) {
diff -Nru a/include/linux/reiserfs_fs_sb.h b/include/linux/reiserfs_fs_sb.h
--- a/include/linux/reiserfs_fs_sb.h	Wed Feb 13 13:50:34 2002
+++ b/include/linux/reiserfs_fs_sb.h	Wed Feb 13 13:50:34 2002
@@ -405,12 +405,8 @@
 #define REISERFS_NO_BORDER 11
 #define REISERFS_NO_UNHASHED_RELOCATION 12
 #define REISERFS_HASHED_RELOCATION 13
-#define REISERFS_TEST4 14 
-
-#define REISERFS_TEST1 11
-#define REISERFS_TEST2 12
-#define REISERFS_TEST3 13
-#define REISERFS_TEST4 14 
+#define REISERFS_BARRIER 14
+#define REISERFS_TEST4 15 
 
 #define reiserfs_r5_hash(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << FORCE_R5_HASH))
 #define reiserfs_rupasov_hash(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << FORCE_RUPASOV_HASH))
@@ -419,6 +415,7 @@
 #define reiserfs_no_border(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << REISERFS_NO_BORDER))
 #define reiserfs_no_unhashed_relocation(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << REISERFS_NO_UNHASHED_RELOCATION))
 #define reiserfs_hashed_relocation(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << REISERFS_HASHED_RELOCATION))
+#define reiserfs_barrier(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << REISERFS_BARRIER))
 #define reiserfs_test4(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << REISERFS_TEST4))
 
 #define dont_have_tails(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << NOTAIL))

--PmA2V3Z32TCmWXqI--
