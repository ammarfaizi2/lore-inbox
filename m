Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289005AbSBMWAU>; Wed, 13 Feb 2002 17:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288996AbSBMWAP>; Wed, 13 Feb 2002 17:00:15 -0500
Received: from 216-42-72-167.ppp.netsville.net ([216.42.72.167]:157 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S289005AbSBMV7z>; Wed, 13 Feb 2002 16:59:55 -0500
Date: Wed, 13 Feb 2002 16:59:34 -0500
From: Chris Mason <mason@suse.com>
To: reiserfs-list@namesys.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] write barriers for 2.4.x
Message-ID: <3045480000.1013637574@tiny>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello everyone,

This is a modified version of Jens Axboe's write barrier patch, against
2.4.18-pre9.  The idea is to allow journaled filesystems to trigger
write cache flushes on ide drives, and make use of ordered tags on 
scsi systems (only aic7xxx is coded for scsi right now) instead of
forced ordering by waiting on buffers all the time.

reiserfs support is included, mount with -o barrier to trigger the
new code.

IDE performance is mostly unchanged, but you can safely enable writeback
caching, which is a big gain in many usage patterns.  If your IDE
performance goes down with this patch, it's probably because your drive 
has writeback caching on by default.

My scsi performance goes down 5% (postmark, dbench, iozone, all see the
same slow down) with -o barrier, which is surprising because reiserfs skips 
many wait_on_buffer calls when barrier mode is on.  Hopefully people 
with aic7xxx cards can give this a try and let me know if any drives
do see performance gains.

If you really want to experiment with this on scsi, but have a different
adapter, let me know.

Anyway, patch is below.  It should be considered highly experimental.  I'm
looking for benchmarkers and crash testers to try it on non-critical
data.

-chris

Index: linus.22/fs/reiserfs/super.c
--- linus.22/fs/reiserfs/super.c Fri, 11 Jan 2002 10:14:59 -0500 root (linux/41_super.c 1.2.2.1.2.1.1.1 644)
+++ barrier.1/fs/reiserfs/super.c Wed, 13 Feb 2002 10:47:50 -0500 root (linux/41_super.c 1.2.2.1.2.1.1.1.1.1 644)
@@ -335,6 +335,9 @@
     reiserfs_prepare_for_journal(s, SB_BUFFER_WITH_SB(s), 1) ;
     set_sb_state( SB_DISK_SUPER_BLOCK(s), s->u.reiserfs_sb.s_mount_state );
     journal_mark_dirty(&th, s, SB_BUFFER_WITH_SB (s));
+
+    /* force full waits when unmounting */
+    s->u.reiserfs_sb.s_mount_opt &= ~(1 << REISERFS_BARRIER) ;
   }
 
   /* note, journal_release checks for readonly mount, and can decide not
@@ -437,6 +440,9 @@
 	    set_bit (REISERFS_NO_UNHASHED_RELOCATION, mount_options);
 	} else if (!strcmp (this_char, "hashed_relocation")) {
 	    set_bit (REISERFS_HASHED_RELOCATION, mount_options);
+	} else if (!strcmp (this_char, "barrier")) {
+	    set_bit (REISERFS_BARRIER, mount_options);
+	    printk("reiserfs: enabling write barrier code\n") ;
 	} else if (!strcmp (this_char, "test4")) {
 	    set_bit (REISERFS_TEST4, mount_options);
 	} else if (!strcmp (this_char, "nolog")) {
Index: linus.22/fs/reiserfs/journal.c
--- linus.22/fs/reiserfs/journal.c Mon, 28 Jan 2002 09:51:50 -0500 root (linux/b/0_journal.c 1.2.1.1.4.2.1.2 644)
+++ barrier.1/fs/reiserfs/journal.c Wed, 13 Feb 2002 10:47:50 -0500 root (linux/b/0_journal.c 1.2.1.1.4.2.1.3 644)
@@ -112,6 +112,34 @@
   return 0 ;
 }
 
+static int barrier_wait_on_buffer(struct super_block *s, struct buffer_head *bh)
+{
+   if (!reiserfs_barrier(s))
+	wait_on_buffer(bh) ;
+
+    return 0 ;
+}
+
+static void mark_barrier(struct super_block *s, struct buffer_head *bh)
+{
+    if (reiserfs_barrier(s))
+	set_bit(BH_Ordered, &bh->b_state);
+}
+
+static int check_barrier(struct super_block *s, struct buffer_head *bh)
+{
+    clear_bit(BH_Ordered, &bh->b_state) ;
+    if (test_and_clear_bit(BH_IO_OPNOTSUPP, &bh->b_state)) {
+        printk(KERN_INFO "clm-2200: barrier write rejected on device %s "
+	                  "turning off barrier writes\n", kdevname(bh->b_dev));
+        
+	s->u.reiserfs_sb.s_mount_opt &= ~(1 << REISERFS_BARRIER) ;
+	ll_rw_block(WRITE, 1, &bh) ;
+        return 1 ; 
+    }
+    return 0 ;
+}
+
 static struct reiserfs_bitmap_node *
 allocate_bitmap_node(struct super_block *p_s_sb) {
   struct reiserfs_bitmap_node *bn ;
@@ -716,7 +744,7 @@
       bn = reiserfs_get_journal_block(s) + (jl->j_start + i) % JOURNAL_BLOCK_COUNT  ;
       tbh = sb_get_hash_table(s, bn) ;
 
-      wait_on_buffer(tbh) ;
+      barrier_wait_on_buffer(s, tbh) ;
       if (!buffer_uptodate(tbh)) {
 	reiserfs_panic(s, "journal-601, buffer write failed\n") ;
       }
@@ -736,9 +764,11 @@
 		   atomic_read(&(jl->j_commit_left)));
   }
 
+  mark_barrier(s, jl->j_commit_bh);
   mark_buffer_dirty(jl->j_commit_bh) ;
   ll_rw_block(WRITE, 1, &(jl->j_commit_bh)) ;
-  wait_on_buffer(jl->j_commit_bh) ;
+  check_barrier(s, jl->j_commit_bh);
+  barrier_wait_on_buffer(s, jl->j_commit_bh) ;
   if (!buffer_uptodate(jl->j_commit_bh)) {
     reiserfs_panic(s, "journal-615: buffer write failed\n") ;
   }
@@ -831,10 +861,12 @@
     jh->j_first_unflushed_offset = cpu_to_le32(offset) ;
     jh->j_mount_id = cpu_to_le32(SB_JOURNAL(p_s_sb)->j_mount_id) ;
     set_bit(BH_Dirty, &(SB_JOURNAL(p_s_sb)->j_header_bh->b_state)) ;
+    mark_barrier(p_s_sb, SB_JOURNAL(p_s_sb)->j_header_bh);
     ll_rw_block(WRITE, 1, &(SB_JOURNAL(p_s_sb)->j_header_bh)) ;
-    wait_on_buffer((SB_JOURNAL(p_s_sb)->j_header_bh)) ; 
+    check_barrier(p_s_sb, SB_JOURNAL(p_s_sb)->j_header_bh);
+    barrier_wait_on_buffer(p_s_sb, (SB_JOURNAL(p_s_sb)->j_header_bh)) ; 
     if (!buffer_uptodate(SB_JOURNAL(p_s_sb)->j_header_bh)) {
-      printk( "reiserfs: journal-837: IO error during journal replay\n" );
+      printk( "reiserfs: journal-837: IO error during journal update\n" );
       return -EIO ;
     }
   }
@@ -1053,7 +1085,7 @@
 	if (!cn->bh) {
 	  reiserfs_panic(s, "journal-1011: cn->bh is NULL\n") ;
 	}
-	wait_on_buffer(cn->bh) ;
+	barrier_wait_on_buffer(s, cn->bh) ;
 	if (!cn->bh) {
 	  reiserfs_panic(s, "journal-1012: cn->bh is NULL\n") ;
 	}
@@ -1159,7 +1191,7 @@
         } else if (test_bit(BLOCK_NEEDS_FLUSH, &cn->state)) {
             clear_bit(BLOCK_NEEDS_FLUSH, &cn->state) ;
             if (!pjl && cn->bh) {
-                wait_on_buffer(cn->bh) ;
+                barrier_wait_on_buffer(s, cn->bh) ;
             }
             /* check again, someone could have logged while we scheduled */
             pjl = find_newer_jl_for_cn(cn) ;
Index: linus.22/drivers/ide/ide-probe.c
--- linus.22/drivers/ide/ide-probe.c Tue, 27 Nov 2001 23:34:21 -0500 root (linux/m/b/37_ide-probe. 1.2 644)
+++ barrier.1/drivers/ide/ide-probe.c Wed, 13 Feb 2002 10:47:50 -0500 root (linux/m/b/37_ide-probe. 1.3 644)
@@ -597,6 +597,11 @@
 
 	q->queuedata = HWGROUP(drive);
 	blk_init_queue(q, do_ide_request);
+	/*
+	 * assume all drives can do ordered flush, disable this
+	 * later if it fails
+	 */
+	blk_queue_ordered(q, QUEUE_ORDERED_FLUSH);
 }
 
 /*
Index: linus.22/drivers/ide/ide.c
--- linus.22/drivers/ide/ide.c Fri, 11 Jan 2002 10:17:27 -0500 root (linux/n/b/8_ide.c 1.3 644)
+++ barrier.1/drivers/ide/ide.c Wed, 13 Feb 2002 10:47:50 -0500 root (linux/n/b/8_ide.c 1.4 644)
@@ -543,6 +543,36 @@
 }
 
 /*
+ * preempt pending requests, and store this cache flush for immediate
+ * execution
+ */
+#define WIN_FLUSH_CACHE		0xE7
+#define WIN_FLUSH_CACHE_EXT	0xEA
+static struct request *ide_queue_flush_cmd(ide_drive_t *drive, struct request *rq, int post)
+{
+	struct request *flush_rq = &HWGROUP(drive)->wrq;
+
+	list_del(&rq->queue);
+
+	memset(drive->special_buf, 0, sizeof(drive->special_buf));
+
+	ide_init_drive_cmd(flush_rq);
+
+	flush_rq->buffer = drive->special_buf;
+	flush_rq->special = rq;
+
+	flush_rq->buffer[0] = (drive->id->cfs_enable_2 & 0x2400) ? WIN_FLUSH_CACHE_EXT : WIN_FLUSH_CACHE;
+
+	if (post)
+		flush_rq->cmd_flags |= RQ_WRITE_POSTFLUSH;
+	else
+		flush_rq->cmd_flags |= RQ_WRITE_PREFLUSH;
+
+	list_add(&flush_rq->queue, &drive->queue.queue_head);
+	return flush_rq;
+}
+
+/*
  * This is our end_request replacement function.
  */
 void ide_end_request (byte uptodate, ide_hwgroup_t *hwgroup)
@@ -567,7 +597,15 @@
 		add_blkdev_randomness(MAJOR(rq->rq_dev));
 		blkdev_dequeue_request(rq);
         	hwgroup->rq = NULL;
-		end_that_request_last(rq);
+		/*
+		 * if this is a write barrier, flush the writecache before
+		 * allowing new requests to finsh and before signalling
+		 * completion of this request
+		 */
+		if (rq->cmd_flags & RQ_WRITE_ORDERED)
+			ide_queue_flush_cmd(drive, rq, 1);
+		else
+			end_that_request_last(rq);
 	}
 	spin_unlock_irqrestore(&io_request_lock, flags);
 }
@@ -869,8 +907,35 @@
 			args[6] = IN_BYTE(IDE_SELECT_REG);
 		}
 	}
+
 	spin_lock_irqsave(&io_request_lock, flags);
 	blkdev_dequeue_request(rq);
+
+	/*
+	 * if a cache flush fails, disable ordered write support
+	 */
+	if (rq->cmd_flags & (RQ_WRITE_PREFLUSH | RQ_WRITE_POSTFLUSH)) {
+		struct request *real_rq = rq->special;
+
+		/*
+		 * best-effort currently, this ignores the fact that there
+		 * may be other barriers currently queued that we can't
+		 * honor any more
+		 */
+		if (err)
+			blk_queue_ordered(&drive->queue, QUEUE_ORDERED_NONE);
+
+		if (rq->cmd_flags & RQ_WRITE_POSTFLUSH)
+			end_that_request_last(real_rq);
+		else {
+			/*
+			 * just indicate that we did the pre flush
+			 */
+			real_rq->cmd_flags |= RQ_WRITE_PREFLUSH;
+			list_add(&real_rq->queue, &drive->queue.queue_head);
+		}
+	}
+
 	HWGROUP(drive)->rq = NULL;
 	end_that_request_last(rq);
 	spin_unlock_irqrestore(&io_request_lock, flags);
@@ -1375,6 +1440,7 @@
 	ide_drive_t	*drive;
 	ide_hwif_t	*hwif;
 	ide_startstop_t	startstop;
+	struct request	*rq;
 
 	ide_get_lock(&ide_lock, ide_intr, hwgroup);	/* for atari only: POSSIBLY BROKEN HERE(?) */
 
@@ -1426,7 +1492,18 @@
 
 		if ( drive->queue.plugged )	/* paranoia */
 			printk("%s: Huh? nuking plugged queue\n", drive->name);
-		hwgroup->rq = blkdev_entry_next_request(&drive->queue.queue_head);
+
+		rq = blkdev_entry_next_request(&drive->queue.queue_head);
+
+		/*
+		 * if rq is a barrier write, issue pre cache flush if not
+		 * already done
+		 */
+		if (!(rq->cmd_flags ^ (RQ_WRITE_ORDERED | RQ_WRITE_PREFLUSH)))
+			rq = ide_queue_flush_cmd(drive, rq, 0);
+
+		hwgroup->rq = rq;
+
 		/*
 		 * Some systems have trouble with IDE IRQs arriving while
 		 * the driver is still setting things up.  So, here we disable
Index: linus.22/drivers/block/elevator.c
--- linus.22/drivers/block/elevator.c Tue, 06 Nov 2001 15:47:39 -0500 root (linux/v/b/9_elevator.c 1.1 644)
+++ barrier.1/drivers/block/elevator.c Wed, 13 Feb 2002 10:47:50 -0500 root (linux/v/b/9_elevator.c 1.1.1.1 644)
@@ -87,6 +87,12 @@
 		struct request *__rq = blkdev_entry_to_request(entry);
 
 		/*
+		 * we can neither merge nor insert before/with a flush
+		 */
+		if (__rq->cmd_flags & RQ_WRITE_ORDERED)
+			break;
+
+		/*
 		 * simply "aging" of requests in queue
 		 */
 		if (__rq->elevator_sequence-- <= 0)
@@ -155,6 +161,12 @@
 	entry = &q->queue_head;
 	while ((entry = entry->prev) != head) {
 		struct request *__rq = blkdev_entry_to_request(entry);
+
+		/*
+		 * we can neither merge nor insert before/with a flush
+		 */
+		if (__rq->cmd_flags & RQ_WRITE_ORDERED)
+			break;
 
 		if (__rq->cmd != rw)
 			continue;
Index: linus.22/drivers/block/ll_rw_blk.c
--- linus.22/drivers/block/ll_rw_blk.c Fri, 11 Jan 2002 10:17:27 -0500 root (linux/w/b/1_ll_rw_blk. 1.3 644)
+++ barrier.1/drivers/block/ll_rw_blk.c Wed, 13 Feb 2002 10:47:50 -0500 root (linux/w/b/1_ll_rw_blk. 1.4 644)
@@ -242,6 +242,32 @@
 void blk_queue_make_request(request_queue_t * q, make_request_fn * mfn)
 {
 	q->make_request_fn = mfn;
+	q->ordered = QUEUE_ORDERED_NONE;
+}
+
+/**
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
+        q->ordered = flag;
 }
 
 static inline int ll_new_segment(request_queue_t *q, struct request *req, int max_segments)
@@ -429,6 +455,7 @@
 		rq = blkdev_free_rq(&rl->free);
 		list_del(&rq->queue);
 		rl->count--;
+		rq->cmd_flags = 0;
 		rq->rq_status = RQ_ACTIVE;
 		rq->special = NULL;
 		rq->q = q;
@@ -633,19 +660,28 @@
 	int rw_ahead, max_sectors, el_ret;
 	struct list_head *head, *insert_here;
 	int latency;
+	int write_ordered ;
 	elevator_t *elevator = &q->elevator;
 
+	/* fail any barrier requests the device can't handle */
+	write_ordered = buffer_ordered(bh);
+	if (write_ordered && q->ordered == QUEUE_ORDERED_NONE) {
+		set_bit(BH_IO_OPNOTSUPP, &bh->b_state) ;
+		goto end_io ;
+	}
+
 	count = bh->b_size >> 9;
 	sector = bh->b_rsector;
 
-	rw_ahead = 0;	/* normal case; gets changed below for READA */
+	latency = rw_ahead = 0;	/* normal case; gets changed below for READA */
 	switch (rw) {
 		case READA:
 			rw_ahead = 1;
 			rw = READ;	/* drop into READ */
 		case READ:
 		case WRITE:
-			latency = elevator_request_latency(elevator, rw);
+			if (!write_ordered)
+				latency = elevator_request_latency(elevator, rw);
 			break;
 		default:
 			BUG();
@@ -761,6 +797,9 @@
 	}
 
 /* fill up the request-info, and add it to the queue */
+	if (write_ordered) {
+		req->cmd_flags |= RQ_WRITE_ORDERED;
+	}
 	req->elevator_sequence = latency;
 	req->cmd = rw;
 	req->errors = 0;
@@ -775,6 +814,7 @@
 	req->bhtail = bh;
 	req->rq_dev = bh->b_rdev;
 	blk_started_io(count);
+
 	add_request(q, req, insert_here);
 out:
 	if (freereq)
Index: linus.22/drivers/scsi/hosts.c
--- linus.22/drivers/scsi/hosts.c Fri, 11 Jan 2002 10:17:27 -0500 root (linux/x/b/30_hosts.c 1.2 644)
+++ barrier.1/drivers/scsi/hosts.c Wed, 13 Feb 2002 10:47:50 -0500 root (linux/x/b/30_hosts.c 1.3 644)
@@ -238,6 +238,7 @@
 
     retval->select_queue_depths = tpnt->select_queue_depths;
     retval->max_sectors = tpnt->max_sectors;
+    retval->can_order = tpnt->can_order;
 
     if(!scsi_hostlist)
 	scsi_hostlist = retval;
Index: linus.22/drivers/scsi/hosts.h
--- linus.22/drivers/scsi/hosts.h Fri, 11 Jan 2002 10:17:27 -0500 root (linux/y/b/49_hosts.h 1.2 644)
+++ barrier.1/drivers/scsi/hosts.h Wed, 13 Feb 2002 10:47:50 -0500 root (linux/y/b/49_hosts.h 1.3 644)
@@ -292,6 +292,11 @@
     unsigned emulated:1;
 
     /*
+     * Driver supported ordered tags
+     */
+    unsigned can_order:1;
+
+    /*
      * Name of proc directory
      */
     char *proc_name;
@@ -417,6 +422,8 @@
      * when the device becomes less busy that we need to feed them.
      */
     unsigned some_device_starved:1;
+
+    unsigned int can_order:1;
    
     void (*select_queue_depths)(struct Scsi_Host *, Scsi_Device *);
 
Index: linus.22/drivers/scsi/scsi.c
--- linus.22/drivers/scsi/scsi.c Fri, 11 Jan 2002 10:17:27 -0500 root (linux/A/b/7_scsi.c 1.4 644)
+++ barrier.1/drivers/scsi/scsi.c Wed, 13 Feb 2002 10:47:50 -0500 root (linux/A/b/7_scsi.c 1.5 644)
@@ -188,6 +188,8 @@
  */
 void  scsi_initialize_queue(Scsi_Device * SDpnt, struct Scsi_Host * SHpnt) {
 	blk_init_queue(&SDpnt->request_queue, scsi_request_fn);
+	if (SHpnt->can_order)
+		blk_queue_ordered(&SDpnt->request_queue, QUEUE_ORDERED_TAG);
         blk_queue_headactive(&SDpnt->request_queue, 0);
         SDpnt->request_queue.queuedata = (void *) SDpnt;
 }
Index: linus.22/drivers/scsi/aic7xxx/aic7xxx_linux.c
--- linus.22/drivers/scsi/aic7xxx/aic7xxx_linux.c Fri, 11 Jan 2002 10:17:27 -0500 root (linux/A/b/42_aic7xxx_li 1.4 644)
+++ barrier.1/drivers/scsi/aic7xxx/aic7xxx_linux.c Wed, 13 Feb 2002 10:47:50 -0500 root (linux/A/b/42_aic7xxx_li 1.5 644)
@@ -1638,6 +1638,9 @@
 			}
 		}
 
+		if (cmd->request.cmd_flags & RQ_WRITE_ORDERED) {
+			hscb->control |= MSG_ORDERED_Q_TAG;
+		}
 		hscb->cdb_len = cmd->cmd_len;
 		if (hscb->cdb_len <= 12) {
 			memcpy(hscb->shared_data.cdb, cmd->cmnd, hscb->cdb_len);
Index: linus.22/drivers/scsi/aic7xxx/aic7xxx_linux_host.h
--- linus.22/drivers/scsi/aic7xxx/aic7xxx_linux_host.h Tue, 06 Nov 2001 15:52:09 -0500 root (linux/A/b/46_aic7xxx_li 1.2 644)
+++ barrier.1/drivers/scsi/aic7xxx/aic7xxx_linux_host.h Wed, 13 Feb 2002 10:47:50 -0500 root (linux/A/b/46_aic7xxx_li 1.2.1.1 644)
@@ -89,7 +89,8 @@
 	present: 0,		/* number of 7xxx's present   */\
 	unchecked_isa_dma: 0,	/* no memory DMA restrictions */\
 	use_clustering: ENABLE_CLUSTERING,			\
-	use_new_eh_code: 1					\
+	use_new_eh_code: 1,					\
+	can_order: 1,						\
 }
 
 #endif /* _AIC7XXX_LINUX_HOST_H_ */
Index: linus.22/include/linux/reiserfs_fs_sb.h
--- linus.22/include/linux/reiserfs_fs_sb.h Fri, 11 Jan 2002 10:17:27 -0500 root (linux/d/d/4_reiserfs_f 1.1.1.1.4.1.1.2 644)
+++ barrier.1/include/linux/reiserfs_fs_sb.h Wed, 13 Feb 2002 10:47:50 -0500 root (linux/d/d/4_reiserfs_f 1.1.1.1.4.1.1.3 644)
@@ -175,20 +175,6 @@
 #define JOURNAL_NUM_BITMAPS 5 /* number of copies of the bitmaps to have floating.  Must be >= 2 */
 #define JOURNAL_LIST_COUNT 64
 
-/* these are bh_state bit flag offset numbers, for use in the buffer head */
-
-#define BH_JDirty       16      /* journal data needs to be written before buffer can be marked dirty */
-#define BH_JDirty_wait 18	/* commit is done, buffer marked dirty */
-#define BH_JNew 19		/* buffer allocated during this transaction, no need to write if freed during this trans too */
-
-/* ugly.  metadata blocks must be prepared before they can be logged.  
-** prepared means unlocked and cleaned.  If the block is prepared, but not
-** logged for some reason, any bits cleared while preparing it must be 
-** set again.
-*/
-#define BH_JPrepared 20		/* block has been prepared for the log */
-#define BH_JRestore_dirty 22    /* restore the dirty bit later */
-
 /* One of these for every block in every transaction
 ** Each one is in two hash tables.  First, a hash of the current transaction, and after journal_end, a
 ** hash of all the in memory transactions.
@@ -465,12 +451,8 @@
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
@@ -479,6 +461,7 @@
 #define reiserfs_no_border(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << REISERFS_NO_BORDER))
 #define reiserfs_no_unhashed_relocation(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << REISERFS_NO_UNHASHED_RELOCATION))
 #define reiserfs_hashed_relocation(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << REISERFS_HASHED_RELOCATION))
+#define reiserfs_barrier(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << REISERFS_BARRIER))
 #define reiserfs_test4(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << REISERFS_TEST4))
 
 #define dont_have_tails(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << NOTAIL))
Index: linus.22/include/linux/fs.h
--- linus.22/include/linux/fs.h Mon, 28 Jan 2002 09:51:50 -0500 root (linux/e/d/3_fs.h 1.2.1.1.1.3.3.1.1.2 644)
+++ barrier.1/include/linux/fs.h Wed, 13 Feb 2002 10:47:50 -0500 root (linux/e/d/3_fs.h 1.2.1.1.1.3.3.1.1.2.1.1 644)
@@ -219,6 +219,8 @@
 	BH_Wait_IO,	/* 1 if we should write out this buffer */
 	BH_launder,	/* 1 if we should throttle on this buffer */
 	BH_JBD,		/* 1 if it has an attached journal_head */
+	BH_Ordered,	/* 1 if this buffer is a write barrier */
+	BH_IO_OPNOTSUPP,/* 1 if block layer rejected a barrier write */
 
 	BH_PrivateStart,/* not a state bit, but the first bit available
 			 * for private allocation by other entities
@@ -279,6 +281,7 @@
 #define buffer_mapped(bh)	__buffer_state(bh,Mapped)
 #define buffer_new(bh)		__buffer_state(bh,New)
 #define buffer_async(bh)	__buffer_state(bh,Async)
+#define buffer_ordered(bh)	__buffer_state(bh,Ordered)
 
 #define bh_offset(bh)		((unsigned long)(bh)->b_data & ~PAGE_MASK)
 
Index: linus.22/include/linux/ide.h
--- linus.22/include/linux/ide.h Tue, 06 Nov 2001 15:47:39 -0500 root (linux/f/d/28_ide.h 1.1 644)
+++ barrier.1/include/linux/ide.h Wed, 13 Feb 2002 10:47:50 -0500 root (linux/f/d/28_ide.h 1.1.1.1 644)
@@ -371,6 +371,7 @@
 	byte		dn;		/* now wide spread use */
 	unsigned int	failures;	/* current failure count */
 	unsigned int	max_failures;	/* maximum allowed failure count */
+	char		special_buf[4]; /* IDE_DRIVE_CMD, free use */
 } ide_drive_t;
 
 /*
Index: linus.22/include/linux/blkdev.h
--- linus.22/include/linux/blkdev.h Tue, 27 Nov 2001 23:34:21 -0500 root (linux/h/d/14_blkdev.h 1.4 644)
+++ barrier.1/include/linux/blkdev.h Wed, 13 Feb 2002 10:47:50 -0500 root (linux/h/d/14_blkdev.h 1.5 644)
@@ -29,6 +29,7 @@
 
 	kdev_t rq_dev;
 	int cmd;		/* READ or WRITE */
+	unsigned long cmd_flags;
 	int errors;
 	unsigned long sector;
 	unsigned long nr_sectors;
@@ -44,6 +45,10 @@
 	request_queue_t *q;
 };
 
+#define RQ_WRITE_ORDERED	1	/* ordered write */
+#define RQ_WRITE_PREFLUSH	2	/* pre-barrier flush */
+#define RQ_WRITE_POSTFLUSH	4	/* post-barrier flush */
+
 #include <linux/elevator.h>
 
 typedef int (merge_request_fn) (request_queue_t *q, 
@@ -113,6 +118,11 @@
 	char			head_active;
 
 	/*
+	 * ordered write support
+	 */
+	char			ordered;
+
+	/*
 	 * Is meant to protect the queue in the future instead of
 	 * io_request_lock
 	 */
@@ -124,6 +134,10 @@
 	wait_queue_head_t	wait_for_request;
 };
 
+#define QUEUE_ORDERED_NONE	0	/* no support */
+#define QUEUE_ORDERED_TAG	1	/* supported by tags (fast) */
+#define QUEUE_ORDERED_FLUSH	2	/* supported by cache flush (ugh!) */
+
 struct blk_dev_struct {
 	/*
 	 * queue_proc has to be atomic
@@ -160,6 +174,7 @@
 extern void blk_init_queue(request_queue_t *, request_fn_proc *);
 extern void blk_cleanup_queue(request_queue_t *);
 extern void blk_queue_headactive(request_queue_t *, int);
+extern void blk_queue_ordered(request_queue_t *, int);
 extern void blk_queue_make_request(request_queue_t *, make_request_fn *);
 extern void generic_unplug_device(void *);
 
Index: linus.22/include/linux/reiserfs_fs.h
--- linus.22/include/linux/reiserfs_fs.h Thu, 13 Dec 2001 11:06:51 -0500 root (linux/k/d/7_reiserfs_f 1.2.2.1.2.1 644)
+++ barrier.1/include/linux/reiserfs_fs.h Wed, 13 Feb 2002 10:47:50 -0500 root (linux/k/d/7_reiserfs_f 1.2.2.1.2.1.1.1 644)
@@ -1470,6 +1470,23 @@
 extern task_queue reiserfs_commit_thread_tq ;
 extern wait_queue_head_t reiserfs_commit_thread_wait ;
 
+enum bh_reiserfs_bits {
+    /* is in the current transaction */
+    BH_JDirty = BH_PrivateStart,
+    /* is in a previous (perhaps uncommitted) transaction, waiting for 
+    ** flush to disk 
+    */
+    BH_JDirty_wait,
+    /* was allocated during this transaction */
+    BH_JNew,
+    /* cleaned and waited on, ready to be logged */
+    BH_JPrepared,
+    /* dirty when prepared, if it doesn't get logged the dirty bit
+    ** must be restored
+    */
+    BH_JRestore_Dirty,
+} ;
+
 /* biggest tunable defines are right here */
 #define JOURNAL_BLOCK_COUNT 8192 /* number of blocks in the journal */
 #define JOURNAL_MAX_BATCH   900 /* max blocks to batch into one transaction, don't make this any bigger than 900 */

