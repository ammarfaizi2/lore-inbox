Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314362AbSEFNqZ>; Mon, 6 May 2002 09:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314444AbSEFNqZ>; Mon, 6 May 2002 09:46:25 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:58633 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S314362AbSEFNpn>;
	Mon, 6 May 2002 09:45:43 -0400
Date: Mon, 6 May 2002 15:45:35 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: "Andre M. Hedrick" <andre@linux-ide.org>, linux-ide@vger.kernel.org
Subject: [PATCH] IDE TCQ for 2.4.19-pre8
Message-ID: <20020506134535.GC18817@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I backported the block layer generic tcq bits and ide tcq parts to
2.4.19-pre.

The IDE bits are nearly identical, they differ only where 2.5 does
things differently than 2.5. In addition, 2.4 has dual code paths
(taskfile i/o is currently disabled per default) so tagging needs to be
started a few places extra.

The block bits have a few extra fixes, some of which have been posted
already.

People who were (rightfully so) afraid to test 2.5 can now play with ide
tagged queueing in 2.4. Works great here.

-- 
Jens Axboe


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=block-tag-2419p8-1

diff -urzN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.4.19-pre8/drivers/block/ll_rw_blk.c linux/drivers/block/ll_rw_blk.c
--- /opt/kernel/linux-2.4.19-pre8/drivers/block/ll_rw_blk.c	2002-05-03 08:42:13.000000000 +0200
+++ linux/drivers/block/ll_rw_blk.c	2002-05-06 15:30:16.000000000 +0200
@@ -178,6 +178,9 @@
 	if (count)
 		printk("blk_cleanup_queue: leaked requests (%d)\n", count);
 
+	if (blk_queue_tagged(q))
+		blk_queue_free_tags(q);
+
 	memset(q, 0, sizeof(*q));
 }
 
@@ -238,6 +241,205 @@
 	q->make_request_fn = mfn;
 }
 
+/**
+ * blk_queue_free_tags - release tag maintenance info
+ * @q:  the request queue for the device
+ *
+ *  Notes:
+ *    blk_cleanup_queue() will take care of calling this function, if tagging
+ *    has been used. So there's usually no need to call this directly, unless
+ *    tagging is just being disabled but the queue remains in function.
+ **/
+void blk_queue_free_tags(request_queue_t *q)
+{
+	struct blk_queue_tag *bqt = q->queue_tags;
+
+	if (!bqt)
+		return;
+
+	BUG_ON(bqt->busy);
+	BUG_ON(!list_empty(&bqt->busy_list));
+
+	kfree(bqt->tag_index);
+	bqt->tag_index = NULL;
+
+	kfree(bqt->tag_map);
+	bqt->tag_map = NULL;
+
+	kfree(bqt);
+	q->queue_tags = NULL;
+	q->tagged_queueing = 0;
+}
+
+/**
+ * blk_queue_init_tags - initialize the queue tag info
+ * @q:  the request queue for the device
+ * @depth:  the maximum queue depth supported
+ **/
+int blk_queue_init_tags(request_queue_t *q, int depth)
+{
+	struct blk_queue_tag *tags;
+	int bits, i;
+
+	if (depth > q->nr_requests) {
+		depth = q->nr_requests;
+		printk("blk_queue_init_tags: adjusted depth to %d\n", depth);
+	}
+
+	tags = kmalloc(sizeof(struct blk_queue_tag), GFP_ATOMIC);
+	if (!tags)
+		goto fail;
+
+	tags->tag_index = kmalloc(depth * sizeof(struct request *), GFP_ATOMIC);
+	if (!tags->tag_index)
+		goto fail_index;
+
+	bits = (depth / BLK_TAGS_PER_LONG) + 1;
+	tags->tag_map = kmalloc(bits * sizeof(unsigned long), GFP_ATOMIC);
+	if (!tags->tag_map)
+		goto fail_map;
+
+	memset(tags->tag_index, 0, depth * sizeof(struct request *));
+	memset(tags->tag_map, 0, bits * sizeof(unsigned long));
+	INIT_LIST_HEAD(&tags->busy_list);
+	tags->busy = 0;
+	tags->max_depth = depth;
+
+	/*
+	 * set the upper bits if the depth isn't a multiple of the word size
+	 */
+	for (i = depth; i < bits * BLK_TAGS_PER_LONG; i++)
+		__set_bit(i, tags->tag_map);
+
+	/*
+	 * assign it, all done
+	 */
+	q->queue_tags = tags;
+	q->tagged_queueing = 1;
+	return 0;
+
+fail_map:
+	kfree(tags->tag_index);
+fail_index:
+	kfree(tags);
+fail:
+	return -ENOMEM;
+}
+
+/**
+ * blk_queue_end_tag - end tag operations for a request
+ * @q:  the request queue for the device
+ * @tag:  the tag that has completed
+ *
+ *  Description:
+ *    Typically called when end_that_request_first() returns 0, meaning
+ *    all transfers have been done for a request. It's important to call
+ *    this function before end_that_request_last(), as that will put the
+ *    request back on the free list thus corrupting the internal tag list.
+ *
+ *  Notes:
+ *   io_request_lock must be held.
+ **/
+void blk_queue_end_tag(request_queue_t *q, struct request *rq)
+{
+	struct blk_queue_tag *bqt = q->queue_tags;
+	int tag = rq->tag;
+
+	BUG_ON(tag == -1);
+
+	if (unlikely(tag >= bqt->max_depth))
+		return;
+
+	if (unlikely(!__test_and_clear_bit(tag, bqt->tag_map))) {
+		printk("attempt to clear non-busy tag (%d)\n", tag);
+		return;
+	}
+
+	list_del(&rq->queue);
+	rq->tag = -1;
+	rq->tagged = 0;
+
+	if (unlikely(bqt->tag_index[tag] == NULL))
+		printk("tag %d is missing\n", tag);
+
+	bqt->tag_index[tag] = NULL;
+	bqt->busy--;
+}
+
+/**
+ * blk_queue_start_tag - find a free tag and assign it
+ * @q:  the request queue for the device
+ * @rq:  the block request that needs tagging
+ *
+ *  Description:
+ *    Note that this function assumes that only regular read/write requests
+ *    can be queued! The request will also be removed from the request queue,
+ *    so it's the drivers responsibility to readd it if it should need to
+ *    be restarted for some reason.
+ *
+ *  Notes:
+ *   io_request_lock must be held
+ **/
+int blk_queue_start_tag(request_queue_t *q, struct request *rq)
+{
+	struct blk_queue_tag *bqt = q->queue_tags;
+	unsigned long *map = bqt->tag_map;
+	int tag = 0;
+
+	if (rq->cmd != READ && rq->cmd != WRITE)
+		return 1;
+
+	for (map = bqt->tag_map; *map == -1UL; map++) {
+		tag += BLK_TAGS_PER_LONG;
+
+		if (tag >= bqt->max_depth)
+			return 1;
+	}
+
+	tag += ffz(*map);
+	__set_bit(tag, bqt->tag_map);
+
+	rq->tag = tag;
+	rq->tagged = 1;
+	bqt->tag_index[tag] = rq;
+	blkdev_dequeue_request(rq);
+	list_add(&rq->queue, &bqt->busy_list);
+	bqt->busy++;
+	return 0;
+}
+
+/**
+ * blk_queue_invalidate_tags - invalidate all pending tags
+ * @q:  the request queue for the device
+ *
+ *  Description:
+ *   Hardware conditions may dictate a need to stop all pending requests.
+ *   In this case, we will safely clear the block side of the tag queue and
+ *   readd all requests to the request queue in the right order.
+ *
+ *  Notes:
+ *   io_request_lock must be held.
+ **/
+void blk_queue_invalidate_tags(request_queue_t *q)
+{
+	struct blk_queue_tag *bqt = q->queue_tags;
+	struct list_head *tmp;
+	struct request *rq;
+
+	list_for_each(tmp, &bqt->busy_list) {
+		rq = list_entry(tmp, struct request, queue);
+
+		if (rq->tag == -1) {
+			printk("bad tag found on list\n");
+			list_del(&rq->queue);
+			rq->tagged = 0;
+		} else
+			blk_queue_end_tag(q, rq);
+
+		list_add(&rq->queue, &q->queue_head);
+	}
+}
+
 static inline int ll_new_segment(request_queue_t *q, struct request *req, int max_segments)
 {
 	if (req->nr_segments < max_segments) {
@@ -667,6 +869,7 @@
 		hd->wr_sectors += sectors;
 		break;
 	default:
+		;
 	}
 	if (!merge)
 		up_ios(hd);
@@ -685,6 +888,7 @@
 		hd->wr_ios++;
 		break;
 	default:
+		;
 	}
 	down_ios(hd);
 }
@@ -1441,3 +1645,9 @@
 EXPORT_SYMBOL(blkdev_release_request);
 EXPORT_SYMBOL(req_finished_io);
 EXPORT_SYMBOL(generic_unplug_device);
+
+EXPORT_SYMBOL(blk_queue_init_tags);
+EXPORT_SYMBOL(blk_queue_free_tags);
+EXPORT_SYMBOL(blk_queue_start_tag);
+EXPORT_SYMBOL(blk_queue_end_tag);
+EXPORT_SYMBOL(blk_queue_invalidate_tags);
diff -urzN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.4.19-pre8/include/linux/blkdev.h linux/include/linux/blkdev.h
--- /opt/kernel/linux-2.4.19-pre8/include/linux/blkdev.h	2002-05-03 08:42:22.000000000 +0200
+++ linux/include/linux/blkdev.h	2002-05-06 13:24:29.000000000 +0200
@@ -37,12 +37,14 @@
 	unsigned int nr_segments;
 	unsigned int nr_hw_segments;
 	unsigned long current_nr_sectors;
+	int tag;
 	void * special;
 	char * buffer;
 	struct completion * waiting;
 	struct buffer_head * bh;
 	struct buffer_head * bhtail;
 	request_queue_t *q;
+	char tagged;
 };
 
 #include <linux/elevator.h>
@@ -72,6 +74,18 @@
 	struct list_head free;
 };
 
+#define BLK_TAGS_PER_LONG	(sizeof(unsigned long) * 8)
+#define BLK_TAGS_MASK		(BLK_TAGS_PER_LONG - 1)
+
+struct blk_queue_tag {
+	struct request **tag_index;	/* map of busy tags */
+	unsigned long *tag_map;		/* bit map of free/busy tags */
+	struct list_head busy_list;	/* fifo list of busy tags */
+	int busy;			/* current depth */
+	int max_depth;
+};
+
+
 struct request_queue
 {
 	/*
@@ -123,6 +137,8 @@
 	 */
 	char			head_active;
 
+	char			tagged_queueing;
+
 	/*
 	 * Is meant to protect the queue in the future instead of
 	 * io_request_lock
@@ -133,8 +149,12 @@
 	 * Tasks wait here for free read and write requests
 	 */
 	wait_queue_head_t	wait_for_requests[2];
+
+	struct blk_queue_tag	*queue_tags;
 };
 
+#define blk_queue_tagged(q)	(q)->tagged_queueing
+
 struct blk_dev_struct {
 	/*
 	 * queue_proc has to be atomic
@@ -175,6 +195,19 @@
 extern void blk_queue_make_request(request_queue_t *, make_request_fn *);
 extern void generic_unplug_device(void *);
 
+/*
+ * tag stuff
+ */
+#define blk_queue_tag_request(q, tag)	((q)->queue_tags->tag_index[(tag)])
+#define blk_queue_tag_depth(q)		((q)->queue_tags->busy)
+#define blk_queue_tag_queue(q)		((q)->queue_tags->busy < (q)->queue_tags->max_depth)
+#define blk_rq_tagged(rq)		((rq)->tagged)
+extern int blk_queue_start_tag(request_queue_t *, struct request *);
+extern void blk_queue_end_tag(request_queue_t *, struct request *);
+extern int blk_queue_init_tags(request_queue_t *, int);
+extern void blk_queue_free_tags(request_queue_t *);
+extern void blk_queue_invalidate_tags(request_queue_t *);
+
 extern int * blk_size[MAX_BLKDEV];
 
 extern int * blksize_size[MAX_BLKDEV];

--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ide-tag-2419p8-1

diff -urzN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.4.19-pre8/Documentation/Configure.help linux/Documentation/Configure.help
--- /opt/kernel/linux-2.4.19-pre8/Documentation/Configure.help	2002-05-03 08:42:10.000000000 +0200
+++ linux/Documentation/Configure.help	2002-05-06 13:24:29.000000000 +0200
@@ -793,6 +793,37 @@
 
   Generally say N here.
 
+CONFIG_BLK_DEV_IDE_TCQ
+  Support for tagged command queueing on ATA disk drives. This enables
+  the IDE layer to have multiple in-flight requests on hardware that
+  supports it. For now this includes the IBM Deskstar series drives,
+  such as the 22GXP, 75GXP, 40GV, 60GXP, and 120GXP (ie any Deskstar made
+  in the last couple of years), and at least some of the Western
+  Digital drives in the Expert series (by nature of really being IBM
+  drives).
+
+  If you have such a drive, say Y here.
+
+CONFIG_BLK_DEV_IDE_TCQ_DEPTH
+  Maximum size of commands to enable per-drive. Any value between 1
+  and 32 is valid, with 32 being the maxium that the hardware supports.
+
+  You probably just want the default of 32 here. If you enter an invalid
+  number, the default value will be used.
+
+CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
+  Enabled tagged command queueing unconditionally on drives that report
+  support for it. Regardless of the chosen value here, tagging can be
+  controlled at run time:
+
+  echo "using_tcq:32" > /proc/ide/hdX/settings
+
+  where any value between 1-32 selects chosen queue depth and enables
+  TCQ, and 0 disables it. hdparm version 4.7 an above also support
+  TCQ manipulations.
+
+  Generally say Y here.
+
 SCSI emulation support
 CONFIG_BLK_DEV_IDESCSI
   This will provide SCSI host adapter emulation for IDE ATAPI devices,
diff -urzN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.4.19-pre8/drivers/ide/Config.in linux/drivers/ide/Config.in
--- /opt/kernel/linux-2.4.19-pre8/drivers/ide/Config.in	2002-05-03 08:42:13.000000000 +0200
+++ linux/drivers/ide/Config.in	2002-05-06 13:24:29.000000000 +0200
@@ -52,6 +52,11 @@
 	    dep_bool '      Use PCI DMA by default when available' CONFIG_IDEDMA_PCI_AUTO $CONFIG_BLK_DEV_IDEDMA_PCI
             dep_bool '    Enable DMA only for disks ' CONFIG_IDEDMA_ONLYDISK $CONFIG_IDEDMA_PCI_AUTO
 	    define_bool CONFIG_BLK_DEV_IDEDMA $CONFIG_BLK_DEV_IDEDMA_PCI
+	    dep_bool '    ATA tagged command queueing' CONFIG_BLK_DEV_IDE_TCQ $CONFIG_BLK_DEV_IDEDMA_PCI
+	    dep_bool '      TCQ on by default' CONFIG_BLK_DEV_IDE_TCQ_DEFAULT $CONFIG_BLK_DEV_IDE_TCQ
+	    if [ "$CONFIG_BLK_DEV_IDE_TCQ" != "n" ]; then
+		int '      Default queue depth' CONFIG_BLK_DEV_IDE_TCQ_DEPTH 32
+	    fi
 	    dep_bool '      ATA Work(s) In Progress (EXPERIMENTAL)' CONFIG_IDEDMA_PCI_WIP $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_EXPERIMENTAL
 	    dep_bool '      Attempt to HACK around Chipsets that TIMEOUT (WIP)' CONFIG_BLK_DEV_IDEDMA_TIMEOUT $CONFIG_IDEDMA_PCI_WIP
 	    dep_bool '      Good-Bad DMA Model-Firmware (WIP)' CONFIG_IDEDMA_NEW_DRIVE_LISTINGS $CONFIG_IDEDMA_PCI_WIP
diff -urzN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.4.19-pre8/drivers/ide/ide.c linux/drivers/ide/ide.c
--- /opt/kernel/linux-2.4.19-pre8/drivers/ide/ide.c	2002-05-03 08:42:13.000000000 +0200
+++ linux/drivers/ide/ide.c	2002-05-06 15:35:20.000000000 +0200
@@ -577,7 +577,10 @@
 
 	if (!end_that_request_first(rq, uptodate, hwgroup->drive->name)) {
 		add_blkdev_randomness(MAJOR(rq->rq_dev));
-		blkdev_dequeue_request(rq);
+		if (!blk_rq_tagged(rq))
+			blkdev_dequeue_request(rq);
+		else
+			blk_queue_end_tag(&drive->queue, rq);
         	hwgroup->rq = NULL;
 		end_that_request_last(rq);
 	}
@@ -1577,13 +1580,31 @@
 		}
 		hwgroup->hwif = hwif;
 		hwgroup->drive = drive;
+queue_next:
+		if (!ata_can_queue(drive)) {
+			if (!ata_pending_commands(drive))
+				hwgroup->busy = 0;
+			break;
+		}
+
 		drive->sleep = 0;
 		drive->service_start = jiffies;
 
-		if ( drive->queue.plugged )	/* paranoia */
+		if (drive->queue.plugged) {
+			if (drive->using_tcq)
+				break;
 			printk("%s: Huh? nuking plugged queue\n", drive->name);
+		}
+
+		if (list_empty(&drive->queue.queue_head))
+			break;
+
+		rq = blkdev_entry_next_request(&drive->queue.queue_head);
+		if (!rq->bh && ata_pending_commands(drive))
+			break;
+
+		hwgroup->rq = rq;
 
-		rq = hwgroup->rq = blkdev_entry_next_request(&drive->queue.queue_head);
 		/*
 		 * Some systems have trouble with IDE IRQs arriving while
 		 * the driver is still setting things up.  So, here we disable
@@ -1602,6 +1623,8 @@
 			enable_irq(hwif->irq);
 		if (startstop == ide_stopped)
 			hwgroup->busy = 0;
+		else if (startstop == ide_released)
+			goto queue_next;
 	}
 }
 
diff -urzN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.4.19-pre8/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- /opt/kernel/linux-2.4.19-pre8/drivers/ide/ide-disk.c	2002-05-03 08:42:13.000000000 +0200
+++ linux/drivers/ide/ide-disk.c	2002-05-06 15:39:01.000000000 +0200
@@ -29,9 +29,10 @@
  * Version 1.10		request queue changes, Ultra DMA 100
  * Version 1.11		added 48-bit lba
  * Version 1.12		adding taskfile io access method
+ * Version 1.13		tcq support
  */
 
-#define IDEDISK_VERSION	"1.12"
+#define IDEDISK_VERSION	"1.13"
 
 #undef REALLY_SLOW_IO		/* most systems can safely undef this */
 
@@ -334,6 +335,27 @@
 }
 #endif /* __TASKFILE__IO */
 
+static int idedisk_start_tag(ide_drive_t *drive, struct request *rq)
+{
+	unsigned long flags;
+	int ret;
+
+	if (!drive->using_tcq)
+		return 0;
+
+	spin_lock_irqsave(&io_request_lock, flags);
+
+	ret = blk_queue_start_tag(&drive->queue, rq);
+
+	if (ata_pending_commands(drive) > drive->max_depth)
+		drive->max_depth = ata_pending_commands(drive);
+	if (ata_pending_commands(drive) > drive->max_last_depth)
+		drive->max_last_depth = ata_pending_commands(drive);
+
+	spin_unlock_irqrestore(&io_request_lock, flags);
+	return ret;
+}
+
 #ifdef __TASKFILE__IO
 
 static ide_startstop_t chs_rw_disk (ide_drive_t *drive, struct request *rq, unsigned long block);
@@ -358,6 +380,13 @@
 
 good_command:
 
+	if (idedisk_start_tag(drive, rq)) {
+		if (!ata_pending_commands(drive))
+			BUG();
+
+		return ide_started;
+	}
+
 #ifdef CONFIG_BLK_DEV_PDC4030
 	if (IS_PDC4030_DRIVE) {
 		extern ide_startstop_t promise_rw_disk(ide_drive_t *, struct request *, unsigned long);
@@ -382,12 +411,16 @@
 	lba48bit = drive->addressing;
 #endif
 
+	if ((cmd == READ) && drive->using_tcq)
+		return lba48bit ? WIN_READDMA_QUEUED_EXT : WIN_READDMA_QUEUED;
 	if ((cmd == READ) && (drive->using_dma))
 		return (lba48bit) ? WIN_READDMA_EXT : WIN_READDMA;
 	else if ((cmd == READ) && (drive->mult_count))
 		return (lba48bit) ? WIN_MULTREAD_EXT : WIN_MULTREAD;
 	else if (cmd == READ)
 		return (lba48bit) ? WIN_READ_EXT : WIN_READ;
+	else if ((cmd == WRITE) && drive->using_tcq)
+		return lba48bit ? WIN_WRITEDMA_QUEUED_EXT : WIN_WRITEDMA_QUEUED;
 	else if ((cmd == WRITE) && (drive->using_dma))
 		return (lba48bit) ? WIN_WRITEDMA_EXT : WIN_WRITEDMA;
 	else if ((cmd == WRITE) && (drive->mult_count))
@@ -403,6 +436,7 @@
 	struct hd_drive_task_hdr	taskfile;
 	struct hd_drive_hob_hdr		hobfile;
 	ide_task_t			args;
+	__u8 sectors = rq->nr_sectors;
 
 	task_ioreg_t command	= get_command(drive, rq->cmd);
 	unsigned int track	= (block / drive->sect);
@@ -413,7 +447,12 @@
 	memset(&taskfile, 0, sizeof(task_struct_t));
 	memset(&hobfile, 0, sizeof(hob_struct_t));
 
-	taskfile.sector_count	= (rq->nr_sectors==256)?0x00:rq->nr_sectors;
+	if (blk_rq_tagged(rq)) {
+		taskfile.feature = sectors;
+		taskfile.sector_count = rq->tag << 3;
+	} else
+		taskfile.sector_count = sectors;
+
 	taskfile.sector_number	= sect;
 	taskfile.low_cylinder	= cyl;
 	taskfile.high_cylinder	= (cyl>>8);
@@ -448,13 +487,19 @@
 	struct hd_drive_task_hdr	taskfile;
 	struct hd_drive_hob_hdr		hobfile;
 	ide_task_t			args;
+	__u8 sectors = rq->nr_sectors;
 
 	task_ioreg_t command	= get_command(drive, rq->cmd);
 
 	memset(&taskfile, 0, sizeof(task_struct_t));
 	memset(&hobfile, 0, sizeof(hob_struct_t));
 
-	taskfile.sector_count	= (rq->nr_sectors==256)?0x00:rq->nr_sectors;
+	if (blk_rq_tagged(rq)) {
+		taskfile.feature = sectors;
+		taskfile.sector_count = rq->tag << 3;
+	} else
+		taskfile.sector_count = sectors;
+
 	taskfile.sector_number	= block;
 	taskfile.low_cylinder	= (block>>=8);
 	taskfile.high_cylinder	= (block>>=8);
@@ -496,18 +541,20 @@
 	struct hd_drive_task_hdr	taskfile;
 	struct hd_drive_hob_hdr		hobfile;
 	ide_task_t			args;
+	__u16 sectors = rq->nr_sectors;
 
 	task_ioreg_t command	= get_command(drive, rq->cmd);
 
 	memset(&taskfile, 0, sizeof(task_struct_t));
 	memset(&hobfile, 0, sizeof(hob_struct_t));
 
-	taskfile.sector_count	= rq->nr_sectors;
-	hobfile.sector_count	= (rq->nr_sectors>>8);
-
-	if (rq->nr_sectors == 65536) {
-		taskfile.sector_count	= 0x00;
-		hobfile.sector_count	= 0x00;
+	if (blk_rq_tagged(rq)) {
+		taskfile.feature = sectors;
+		hobfile.feature = sectors >> 8;
+		taskfile.sector_count = rq->tag << 3;
+	} else {
+		taskfile.sector_count = sectors;
+		hobfile.sector_count = sectors >> 8;
 	}
 
 	taskfile.sector_number	= block;	/* low lba */
@@ -551,9 +598,18 @@
  */
 static ide_startstop_t do_rw_disk (ide_drive_t *drive, struct request *rq, unsigned long block)
 {
+	ide_startstop_t startstop;
+
 	if (IDE_CONTROL_REG)
 		OUT_BYTE(drive->ctl,IDE_CONTROL_REG);
 
+	if (idedisk_start_tag(drive, rq)) {
+		if (!ata_pending_commands(drive))
+			BUG();
+
+		return ide_started;
+	}
+
 #ifdef CONFIG_BLK_DEV_PDC4030
 	if (drive->select.b.lba || IS_PDC4030_DRIVE) {
 #else /* !CONFIG_BLK_DEV_PDC4030 */
@@ -562,15 +618,20 @@
 
 		if ((drive->id->cfs_enable_2 & 0x0400) && (drive->addressing)) {
 			task_ioreg_t tasklets[10];
+			__u16 sectors = rq->nr_sectors;
 
-			tasklets[0] = 0;
-			tasklets[1] = 0;
-			tasklets[2] = rq->nr_sectors;
-			tasklets[3] = (rq->nr_sectors>>8);
-			if (rq->nr_sectors == 65536) {
-				tasklets[2] = 0x00;
-				tasklets[3] = 0x00;
+			if (blk_rq_tagged(rq)) {
+				tasklets[0] = sectors;
+				tasklets[1] = sectors >> 8;
+				tasklets[2] = rq->tag << 3;
+				tasklets[3] = 0;
+			} else {
+				tasklets[0] = 0;
+				tasklets[1] = 0;
+				tasklets[2] = sectors;
+				tasklets[3] = sectors >> 8;
 			}
+
 			tasklets[4] = (task_ioreg_t) block;
 			tasklets[5] = (task_ioreg_t) (block>>8);
 			tasklets[6] = (task_ioreg_t) (block>>16);
@@ -605,13 +666,19 @@
 			OUT_BYTE(tasklets[6], IDE_HCYL_REG);
 			OUT_BYTE(0x00|drive->select.all,IDE_SELECT_REG);
 		} else {
+			__u8 sectors = rq->nr_sectors;
 #ifdef DEBUG
 			printk("%s: %sing: LBAsect=%ld, sectors=%ld, buffer=0x%08lx\n",
 				drive->name, (rq->cmd==READ)?"read":"writ",
 				block, rq->nr_sectors, (unsigned long) rq->buffer);
 #endif
-			OUT_BYTE(0x00, IDE_FEATURE_REG);
-			OUT_BYTE((rq->nr_sectors==256)?0x00:rq->nr_sectors,IDE_NSECTOR_REG);
+			if (blk_rq_tagged(rq)) {
+				OUT_BYTE(sectors, IDE_FEATURE_REG);
+				OUT_BYTE(rq->tag << 3, IDE_NSECTOR_REG);
+			} else {
+				OUT_BYTE(0x00, IDE_FEATURE_REG);
+				OUT_BYTE(sectors, IDE_NSECTOR_REG);
+			}
 			OUT_BYTE(block,IDE_SECTOR_REG);
 			OUT_BYTE(block>>=8,IDE_LCYL_REG);
 			OUT_BYTE(block>>=8,IDE_HCYL_REG);
@@ -619,14 +686,21 @@
 		}
 	} else {
 		unsigned int sect,head,cyl,track;
+		__u8 sectors = rq->nr_sectors;
+
 		track = block / drive->sect;
 		sect  = block % drive->sect + 1;
 		OUT_BYTE(sect,IDE_SECTOR_REG);
 		head  = track % drive->head;
 		cyl   = track / drive->head;
 
-		OUT_BYTE(0x00, IDE_FEATURE_REG);
-		OUT_BYTE((rq->nr_sectors==256)?0x00:rq->nr_sectors,IDE_NSECTOR_REG);
+		if (blk_rq_tagged(rq)) {
+			OUT_BYTE(sectors, IDE_FEATURE_REG);
+			OUT_BYTE(rq->tag << 3, IDE_NSECTOR_REG);
+		} else {
+			OUT_BYTE(0x00, IDE_FEATURE_REG);
+			OUT_BYTE(sectors, IDE_NSECTOR_REG);
+		}
 		OUT_BYTE(cyl,IDE_LCYL_REG);
 		OUT_BYTE(cyl>>8,IDE_HCYL_REG);
 		OUT_BYTE(head|drive->select.all,IDE_SELECT_REG);
@@ -644,7 +718,11 @@
 #endif /* CONFIG_BLK_DEV_PDC4030 */
 	if (rq->cmd == READ) {
 #ifdef CONFIG_BLK_DEV_IDEDMA
-		if (drive->using_dma && !(HWIF(drive)->dmaproc(ide_dma_read, drive)))
+		if (drive->using_tcq) {
+			startstop = HWIF(drive)->dmaproc(ide_dma_read_queued, drive);
+			if (startstop != ide_stopped)
+				return startstop;
+		} else if (drive->using_dma && !(HWIF(drive)->dmaproc(ide_dma_read, drive)))
 			return ide_started;
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 		ide_set_handler(drive, &read_intr, WAIT_CMD, NULL);
@@ -658,7 +736,11 @@
 	if (rq->cmd == WRITE) {
 		ide_startstop_t startstop;
 #ifdef CONFIG_BLK_DEV_IDEDMA
-		if (drive->using_dma && !(HWIF(drive)->dmaproc(ide_dma_write, drive)))
+		if (drive->using_tcq) {
+			startstop = HWIF(drive)->dmaproc(ide_dma_write_queued, drive);
+			if (startstop != ide_stopped)
+				return startstop;
+		} else if (drive->using_dma && !(HWIF(drive)->dmaproc(ide_dma_write, drive)))
 			return ide_started;
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 		if ((drive->id->cfs_enable_2 & 0x0400) && (drive->addressing)) {
@@ -1161,11 +1243,61 @@
 	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
 }
 
+#ifdef CONFIG_BLK_DEV_IDE_TCQ
+static int proc_idedisk_read_tcq
+	(char *page, char **start, off_t off, int count, int *eof, void *data)
+{
+	ide_drive_t	*drive = (ide_drive_t *) data;
+	char		*out = page;
+	int		len, cmds, i;
+	unsigned long	flags;
+
+	if (!blk_queue_tagged(&drive->queue)) {
+		len = sprintf(out, "not configured\n");
+		PROC_IDE_READ_RETURN(page, start, off, count, eof, len);
+	}
+
+	spin_lock_irqsave(&io_request_lock, flags);
+
+	len = sprintf(out, "TCQ currently on:\t%s\n", drive->using_tcq ? "yes" : "no");
+	len += sprintf(out+len, "Max queue depth:\t%d\n",drive->queue_depth);
+	len += sprintf(out+len, "Max achieved depth:\t%d\n",drive->max_depth);
+	len += sprintf(out+len, "Max depth since last:\t%d\n",drive->max_last_depth);
+	len += sprintf(out+len, "Current depth:\t\t%d\n", ata_pending_commands(drive));
+	len += sprintf(out+len, "Active tags:\t\t[ ");
+	for (i = 0, cmds = 0; i < drive->queue_depth; i++) {
+		struct request *rq = blk_queue_tag_request(&drive->queue, i);
+
+		if (!rq)
+			continue;
+
+		len += sprintf(out+len, "%d, ", i);
+		cmds++;
+	}
+	len += sprintf(out+len, "]\n");
+
+	len += sprintf(out+len, "Queue:\t\t\treleased [ %lu ] - started [ %lu ]\n", drive->immed_rel, drive->immed_comp);
+
+	if (ata_pending_commands(drive) != cmds)
+		len += sprintf(out+len, "pending request and queue count mismatch (counted: %d)\n", cmds);
+
+	len += sprintf(out+len, "DMA status:\t\t%srunning\n", HWGROUP(drive)->dma ? "" : "not ");
+
+	drive->max_last_depth = 0;
+
+	spin_unlock_irqrestore(&io_request_lock, flags);
+	PROC_IDE_READ_RETURN(page, start, off, count, eof, len);
+}
+#endif
+
 static ide_proc_entry_t idedisk_proc[] = {
 	{ "cache",		S_IFREG|S_IRUGO,	proc_idedisk_read_cache,		NULL },
 	{ "geometry",		S_IFREG|S_IRUGO,	proc_ide_read_geometry,			NULL },
 	{ "smart_values",	S_IFREG|S_IRUSR,	proc_idedisk_read_smart_values,		NULL },
 	{ "smart_thresholds",	S_IFREG|S_IRUSR,	proc_idedisk_read_smart_thresholds,	NULL },
+#ifdef CONFIG_BLK_DEV_IDE_TCQ
+	{ "tcq",		S_IFREG|S_IRUSR,	proc_idedisk_read_tcq,			NULL },
+#endif
 	{ NULL, 0, NULL, NULL }
 };
 
@@ -1272,6 +1404,32 @@
 	return 0;
 }
 
+#ifdef CONFIG_BLK_DEV_IDE_TCQ
+static int set_using_tcq(ide_drive_t *drive, int arg)
+{
+	if (!drive->driver)
+		return -EPERM;
+	if (!HWIF(drive)->dmaproc)
+		return -EPERM;
+	if (arg == drive->queue_depth && drive->using_tcq)
+		return 0;
+
+	/*
+	 * set depth, but check also id for max supported depth
+	 */
+	drive->queue_depth = arg ? arg : 1;
+	if (drive->id) {
+		if (drive->queue_depth > drive->id->queue_depth + 1)
+			drive->queue_depth = drive->id->queue_depth + 1;
+	}
+
+	if (HWIF(drive)->dmaproc(arg ? ide_dma_queued_on : ide_dma_queued_off, drive))
+		return -EIO;
+
+	return 0;
+}
+#endif
+
 static int probe_lba_addressing (ide_drive_t *drive, int arg)
 {
 	drive->addressing =  0;
@@ -1309,6 +1467,9 @@
 	ide_add_setting(drive,	"acoustic",		SETTING_RW,					HDIO_GET_ACOUSTIC,	HDIO_SET_ACOUSTIC,	TYPE_BYTE,	0,	254,				1,	1,	&drive->acoustic,		set_acoustic);
  	ide_add_setting(drive,	"failures",		SETTING_RW,					-1,			-1,			TYPE_INT,	0,	65535,				1,	1,	&drive->failures,		NULL);
  	ide_add_setting(drive,	"max_failures",		SETTING_RW,					-1,			-1,			TYPE_INT,	0,	65535,				1,	1,	&drive->max_failures,		NULL);
+#ifdef CONFIG_BLK_DEV_IDE_TCQ
+	ide_add_setting(drive,	"using_tcq",		SETTING_RW,					HDIO_GET_QDMA,		HDIO_SET_QDMA,		TYPE_BYTE,	0,	IDE_MAX_TAG,			1,		1,		&drive->using_tcq,		set_using_tcq);
+#endif
 }
 
 static void idedisk_setup (ide_drive_t *drive)
diff -urzN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.4.19-pre8/drivers/ide/ide-dma.c linux/drivers/ide/ide-dma.c
--- /opt/kernel/linux-2.4.19-pre8/drivers/ide/ide-dma.c	2002-05-03 08:42:13.000000000 +0200
+++ linux/drivers/ide/ide-dma.c	2002-05-06 13:24:29.000000000 +0200
@@ -584,6 +584,21 @@
 }
 #endif /* CONFIG_BLK_DEV_IDEDMA_TIMEOUT */
 
+int ide_start_dma(ide_dma_action_t func, ide_drive_t *drive, unsigned int reading)
+{
+	ide_hwif_t *hwif = HWIF(drive);
+	unsigned long dma_base = hwif->dma_base;
+
+	if (!ide_build_dmatable(drive, func))
+		return 1;	/* try PIO instead of DMA */
+
+	outl(hwif->dmatable_dma, dma_base + 4); /* PRD table */
+	outb(reading, dma_base);		/* specify r/w */
+	outb(inb(dma_base+2)|6, dma_base+2);	/* clear INTR & ERROR flags */
+	drive->waiting_for_dma = 1;
+	return 0;
+}
+
 /*
  * ide_dmaproc() initiates/aborts DMA read/write operations on a drive.
  *
@@ -606,7 +621,7 @@
 	ide_hwif_t *hwif		= HWIF(drive);
 	unsigned long dma_base		= hwif->dma_base;
 	byte unit			= (drive->select.b.unit & 0x01);
-	unsigned int count, reading	= 0;
+	unsigned int reading		= 0;
 	byte dma_stat;
 
 	switch (func) {
@@ -614,23 +629,25 @@
 			printk("%s: DMA disabled\n", drive->name);
 		case ide_dma_off_quietly:
 			outb(inb(dma_base+2) & ~(1<<(5+unit)), dma_base+2);
+#ifdef CONFIG_BLK_DEV_IDE_TCQ
+			hwif->dmaproc(ide_dma_queued_off, drive);
+#endif
 		case ide_dma_on:
 			drive->using_dma = (func == ide_dma_on);
-			if (drive->using_dma)
+			if (drive->using_dma) {
 				outb(inb(dma_base+2)|(1<<(5+unit)), dma_base+2);
+#ifdef CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
+				hwif->dmaproc(ide_dma_queued_on, drive);
+#endif
+			}
 			return 0;
 		case ide_dma_check:
 			return config_drive_for_dma (drive);
 		case ide_dma_read:
 			reading = 1 << 3;
 		case ide_dma_write:
-			SELECT_READ_WRITE(hwif,drive,func);
-			if (!(count = ide_build_dmatable(drive, func)))
-				return 1;	/* try PIO instead of DMA */
-			outl(hwif->dmatable_dma, dma_base + 4); /* PRD table */
-			outb(reading, dma_base);			/* specify r/w */
-			outb(inb(dma_base+2)|6, dma_base+2);		/* clear INTR & ERROR flags */
-			drive->waiting_for_dma = 1;
+			if (ide_start_dma(func, drive, reading))
+				return 1;
 			if (drive->media != ide_disk)
 				return 0;
 #ifdef CONFIG_BLK_DEV_IDEDMA_TIMEOUT
@@ -648,6 +665,14 @@
 				OUT_BYTE(reading ? WIN_READDMA : WIN_WRITEDMA, IDE_COMMAND_REG);
 			}
 			return HWIF(drive)->dmaproc(ide_dma_begin, drive);
+#ifdef CONFIG_BLK_DEV_IDE_TCQ
+		case ide_dma_queued_on:
+		case ide_dma_queued_off:
+		case ide_dma_read_queued:
+		case ide_dma_write_queued:
+		case ide_dma_queued_start:
+			return ide_tcq_dmaproc(func, drive);
+#endif
 		case ide_dma_begin:
 			/* Note that this is done *after* the cmd has
 			 * been issued to the drive, as per the BM-IDE spec.
@@ -655,6 +680,7 @@
 			 * we do this part before issuing the drive cmd.
 			 */
 			outb(inb(dma_base)|1, dma_base);		/* start DMA */
+			HWGROUP(drive)->dma = 1;
 			return 0;
 		case ide_dma_end: /* returns 1 on error, 0 otherwise */
 			drive->waiting_for_dma = 0;
@@ -662,6 +688,7 @@
 			dma_stat = inb(dma_base+2);		/* get DMA status */
 			outb(dma_stat|6, dma_base+2);	/* clear the INTR & ERROR bits */
 			ide_destroy_dmatable(drive);	/* purge DMA mappings */
+			HWGROUP(drive)->dma = 0;
 			return (dma_stat & 7) != 4 ? (0x10 | dma_stat) : 0;	/* verify good DMA status */
 		case ide_dma_test_irq: /* returns 1 if dma irq issued, 0 otherwise */
 			dma_stat = inb(dma_base+2);
diff -urzN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.4.19-pre8/drivers/ide/ide-probe.c linux/drivers/ide/ide-probe.c
--- /opt/kernel/linux-2.4.19-pre8/drivers/ide/ide-probe.c	2002-05-03 08:42:13.000000000 +0200
+++ linux/drivers/ide/ide-probe.c	2002-05-06 13:24:29.000000000 +0200
@@ -176,6 +176,17 @@
 	drive->media = ide_disk;
 	printk("ATA DISK drive\n");
 	QUIRK_LIST(HWIF(drive),drive);
+
+	/* Initialize queue depth settings */
+	drive->queue_depth = 1;
+#ifdef CONFIG_BLK_DEV_IDE_TCQ_DEPTH
+	drive->queue_depth = CONFIG_BLK_DEV_IDE_TCQ_DEPTH;
+#else
+	drive->queue_depth = drive->id->queue_depth + 1;
+#endif
+	if (drive->queue_depth < 1 || drive->queue_depth > IDE_MAX_TAG)
+		drive->queue_depth = IDE_MAX_TAG;
+
 	return;
 
 err_misc:
diff -urzN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.4.19-pre8/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- /opt/kernel/linux-2.4.19-pre8/drivers/ide/ide-taskfile.c	2002-05-03 08:42:13.000000000 +0200
+++ linux/drivers/ide/ide-taskfile.c	2002-05-06 13:24:29.000000000 +0200
@@ -243,8 +243,38 @@
 		}
 #endif
 	} else {
-		/* for dma commands we down set the handler */
-		if (drive->using_dma && !(HWIF(drive)->dmaproc(((taskfile->command == WIN_WRITEDMA) || (taskfile->command == WIN_WRITEDMA_EXT)) ? ide_dma_write : ide_dma_read, drive)));
+		ide_dma_action_t dma_act;
+		int tcq = 0;
+
+		if (!drive->using_dma)
+			return ide_stopped;
+
+		/* for dma commands we don't set the handler */
+		if (taskfile->command == WIN_WRITEDMA || taskfile->command == WIN_WRITEDMA_EXT)
+			dma_act = ide_dma_write;
+		else if (taskfile->command == WIN_READDMA || taskfile->command == WIN_READDMA_EXT)
+			dma_act = ide_dma_read;
+		else if (taskfile->command == WIN_WRITEDMA_QUEUED || taskfile->command == WIN_WRITEDMA_QUEUED_EXT) {
+			tcq = 1;
+			dma_act = ide_dma_write_queued;
+		} else if (taskfile->command == WIN_READDMA_QUEUED || taskfile->command == WIN_READDMA_QUEUED_EXT) {
+			tcq = 1;
+			dma_act = ide_dma_read_queued;
+		} else {
+			printk("ata_taskfile: unknown command %x\n", taskfile->command);
+			return ide_stopped;
+		}
+
+		/*
+		 * FIXME: this is a gross hack, need to unify tcq dma proc and
+		 * regular dma proc -- basically split stuff that needs to act
+		 * on a request from things like ide_dma_check etc.
+		 */
+		if (tcq)
+			return HWIF(drive)->dmaproc(dma_act, drive);
+
+		if (HWIF(drive)->dmaproc(dma_act, drive))
+			return ide_stopped;
 	}
 
 	return ide_started;
diff -urzN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.4.19-pre8/drivers/ide/ide-tcq.c linux/drivers/ide/ide-tcq.c
--- /opt/kernel/linux-2.4.19-pre8/drivers/ide/ide-tcq.c	1970-01-01 01:00:00.000000000 +0100
+++ linux/drivers/ide/ide-tcq.c	2002-05-06 15:29:00.000000000 +0200
@@ -0,0 +1,672 @@
+/*
+ * Copyright (C) 2001, 2002 Jens Axboe <axboe@suse.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+/*
+ * Support for the DMA queued protocol, which enables ATA disk drives to
+ * use tagged command queueing.
+ */
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+//#include <linux/interrupt.h>
+#include <linux/ide.h>
+
+#include <asm/io.h>
+#include <asm/delay.h>
+
+/*
+ * warning: it will be _very_ verbose if defined
+ */
+#undef IDE_TCQ_DEBUG
+
+#ifdef IDE_TCQ_DEBUG
+#define TCQ_PRINTK printk
+#else
+#define TCQ_PRINTK(x...)
+#endif
+
+/*
+ * use nIEN or not
+ */
+#undef IDE_TCQ_NIEN
+
+/*
+ * we are leaving the SERVICE interrupt alone, IBM drives have it
+ * on per default and it can't be turned off. Doesn't matter, this
+ * is the sane config.
+ */
+#undef IDE_TCQ_FIDDLE_SI
+
+ide_startstop_t ide_dmaq_intr(ide_drive_t *drive);
+ide_startstop_t ide_service(ide_drive_t *drive);
+
+static inline void drive_ctl_nien(ide_drive_t *drive, int set)
+{
+#ifdef IDE_TCQ_NIEN
+	if (IDE_CONTROL_REG) {
+		int mask = set ? 0x02 : 0x00;
+
+		OUT_BYTE(drive->ctl | mask, IDE_CONTROL_REG);
+	}
+#endif
+}
+
+static ide_startstop_t ide_tcq_nop_handler(ide_drive_t *drive)
+{
+	ide_task_t *args = HWGROUP(drive)->rq->special;
+
+	ide__sti();
+	ide_end_drive_cmd(drive, GET_STAT(), GET_ERR());
+	kfree(args);
+	return ide_stopped;
+}
+
+/*
+ * if we encounter _any_ error doing I/O to one of the tags, we must
+ * invalidate the pending queue. clear the software busy queue and requeue
+ * on the request queue for restart. issue a WIN_NOP to clear hardware queue
+ */
+static void ide_tcq_invalidate_queue(ide_drive_t *drive)
+{
+	ide_hwgroup_t *hwgroup = HWGROUP(drive);
+	request_queue_t *q = &drive->queue;
+#if 0
+	struct ata_taskfile *args;
+	struct request *rq;
+#endif
+	unsigned long flags;
+
+	printk("%s: invalidating pending queue (%d)\n", drive->name, ata_pending_commands(drive));
+
+	spin_lock_irqsave(&io_request_lock, flags);
+
+	del_timer(&hwgroup->timer);
+
+	if (hwgroup->dma)
+		HWIF(drive)->dmaproc(ide_dma_end, drive);
+
+	blk_queue_invalidate_tags(q);
+
+	drive->using_tcq = 0;
+	drive->queue_depth = 1;
+	hwgroup->busy = 0;
+	hwgroup->handler = NULL;
+
+#if 0
+	/*
+	 * do some internal stuff -- we really need this command to be
+	 * executed before any new commands are started. issue a NOP
+	 * to clear internal queue on drive
+	 */
+	args = kmalloc(sizeof(*args), GFP_ATOMIC);
+	if (!args) {
+		printk("%s: failed to issue NOP\n", drive->name);
+		goto out;
+	}
+	
+	rq = blk_get_request(q, READ, GFP_ATOMIC);
+	if (!rq)
+		rq = blk_get_request(q, WRITE, GFP_ATOMIC);
+
+	/*
+	 * blk_queue_invalidate_tags() just added back at least one command
+	 * to the free list, so there _must_ be at least one free
+	 */
+	BUG_ON(!rq);
+
+	rq->special = args;
+	args->taskfile.command = WIN_NOP;
+	args->handler = ide_tcq_nop_handler;
+	args->command_type = IDE_DRIVE_TASK_NO_DATA;
+
+	rq->rq_dev = mk_kdev(drive->channel->major, (drive->select.b.unit)<<PARTN_BITS);
+	_elv_add_request(q, rq, 0, 0);
+
+	/*
+	 * make sure that nIEN is cleared
+	 */
+out:
+#endif
+	drive_ctl_nien(drive, 0);
+
+	/*
+	 * start doing stuff again
+	 */
+	q->request_fn(q);
+	spin_unlock_irqrestore(&io_request_lock, flags);
+	printk("ide_tcq_invalidate_queue: done\n");
+}
+
+void ide_tcq_intr_timeout(unsigned long data)
+{
+	ide_drive_t *drive = (ide_drive_t *) data;
+	ide_hwgroup_t *hwgroup = HWGROUP(drive);
+	unsigned long flags;
+
+	printk("ide_tcq_intr_timeout: timeout waiting for %s interrupt...\n", hwgroup->rq ? "completion" : "service");
+
+	spin_lock_irqsave(&io_request_lock, flags);
+
+	if (!hwgroup->busy)
+		printk("ide_tcq_intr_timeout: hwgroup not busy\n");
+	if (hwgroup->handler == NULL)
+		printk("ide_tcq_intr_timeout: missing isr!\n");
+
+	hwgroup->busy = 1;
+	spin_unlock_irqrestore(&io_request_lock, flags);
+
+	/*
+	 * if pending commands, try service before giving up
+	 */
+	if (ata_pending_commands(drive) && (GET_STAT() & SERVICE_STAT))
+		if (ide_service(drive) == ide_started)
+			return;
+
+	if (drive)
+		ide_tcq_invalidate_queue(drive);
+}
+
+void ide_tcq_set_intr(ide_hwgroup_t *hwgroup, ide_handler_t *handler)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&io_request_lock, flags);
+
+	/*
+	 * always just bump the timer for now, the timeout handling will
+	 * have to be changed to be per-command
+	 */
+	hwgroup->timer.function = ide_tcq_intr_timeout;
+	hwgroup->timer.data = (unsigned long) hwgroup->drive;
+	mod_timer(&hwgroup->timer, jiffies + 5 * HZ);
+
+	hwgroup->handler = handler;
+	spin_unlock_irqrestore(&io_request_lock, flags);
+}
+
+/*
+ * wait 400ns, then poll for busy_mask to clear from alt status
+ */
+#define IDE_TCQ_WAIT	(10000)
+int ide_tcq_wait_altstat(ide_drive_t *drive, byte *stat, byte busy_mask)
+{
+	int i = 0;
+
+	udelay(1);
+
+	while ((*stat = GET_ALTSTAT()) & busy_mask) {
+		if (unlikely(i++ > IDE_TCQ_WAIT))
+			return 1;
+
+		udelay(10);
+	}
+
+	return 0;
+}
+
+/*
+ * issue SERVICE command to drive -- drive must have been selected first,
+ * and it must have reported a need for service (status has SERVICE_STAT set)
+ *
+ * Also, nIEN must be set as not to need protection against ide_dmaq_intr
+ */
+ide_startstop_t ide_service(ide_drive_t *drive)
+{
+	struct request *rq;
+	byte feat, stat;
+	int tag;
+
+	TCQ_PRINTK("%s: started service\n", drive->name);
+
+	/*
+	 * could be called with IDE_DMA in-progress from invalidate
+	 * handler, refuse to do anything
+	 */
+	if (HWGROUP(drive)->dma)
+		return ide_stopped;
+
+	/*
+	 * need to select the right drive first...
+	 */
+	if (drive != HWGROUP(drive)->drive) {
+		SELECT_DRIVE(HWIF(drive), drive);
+		udelay(10);
+	}
+
+	drive_ctl_nien(drive, 1);
+
+	/*
+	 * send SERVICE, wait 400ns, wait for BUSY_STAT to clear
+	 */
+	OUT_BYTE(WIN_QUEUED_SERVICE, IDE_COMMAND_REG);
+
+	if (ide_tcq_wait_altstat(drive, &stat, BUSY_STAT)) {
+		printk("ide_service: BUSY clear took too long\n");
+		ide_dump_status(drive, "ide_service", stat);
+		ide_tcq_invalidate_queue(drive);
+		return ide_stopped;
+	}
+
+	drive_ctl_nien(drive, 0);
+
+	/*
+	 * FIXME, invalidate queue
+	 */
+	if (stat & ERR_STAT) {
+		ide_dump_status(drive, "ide_service", stat);
+		ide_tcq_invalidate_queue(drive);
+		return ide_stopped;
+	}
+
+	/*
+	 * should not happen, a buggy device could introduce loop
+	 */
+	if ((feat = GET_FEAT()) & NSEC_REL) {
+		HWGROUP(drive)->rq = NULL;
+		printk("%s: release in service\n", drive->name);
+		return ide_stopped;
+	}
+
+	tag = feat >> 3;
+
+	TCQ_PRINTK("ide_service: stat %x, feat %x\n", stat, feat);
+
+	rq = blk_queue_tag_request(&drive->queue, tag);
+	if (!rq) {
+		printk("ide_service: missing request for tag %d\n", tag);
+		return ide_stopped;
+	}
+
+	HWGROUP(drive)->rq = rq;
+
+	/*
+	 * we'll start a dma read or write, device will trigger
+	 * interrupt to indicate end of transfer, release is not allowed
+	 */
+	TCQ_PRINTK("ide_service: starting command, stat=%x\n", stat);
+	return HWIF(drive)->dmaproc(ide_dma_queued_start, drive);
+}
+
+ide_startstop_t ide_check_service(ide_drive_t *drive)
+{
+	byte stat;
+
+	TCQ_PRINTK("%s: ide_check_service\n", drive->name);
+
+	if (!ata_pending_commands(drive))
+		return ide_stopped;
+
+	if ((stat = GET_STAT()) & SERVICE_STAT)
+		return ide_service(drive);
+
+	/*
+	 * we have pending commands, wait for interrupt
+	 */
+	TCQ_PRINTK("%s: wait for service interrupt\n", drive->name);
+	ide_tcq_set_intr(HWGROUP(drive), ide_dmaq_intr);
+	return ide_started;
+}
+
+ide_startstop_t ide_dmaq_complete(ide_drive_t *drive, struct request *rq, byte stat)
+{
+	byte dma_stat;
+	int i;
+
+	/*
+	 * transfer was in progress, stop DMA engine
+	 */
+	dma_stat = HWIF(drive)->dmaproc(ide_dma_end, drive);
+
+	/*
+	 * must be end of I/O, check status and complete as necessary
+	 */
+	if (unlikely(!OK_STAT(stat, READY_STAT, drive->bad_wstat | DRQ_STAT))) {
+		printk("ide_dmaq_intr: %s: error status %x\n",drive->name,stat);
+		ide_dump_status(drive, "ide_dmaq_intr", stat);
+		ide_tcq_invalidate_queue(drive);
+		return ide_stopped;
+	}
+
+	if (dma_stat)
+		printk("%s: bad DMA status (dma_stat=%x)\n", drive->name, dma_stat);
+
+	TCQ_PRINTK("ide_dmaq_intr: ending %p, tag %d\n", rq, rq->tag);
+	for (i = rq->nr_sectors; i > 0;) {
+		i -= rq->current_nr_sectors;
+		ide_end_request(1, HWGROUP(drive));
+	}
+
+	/*
+	 * we completed this command, check if we can service a new command
+	 */
+	return ide_check_service(drive);
+}
+
+/*
+ * intr handler for queued dma operations. this can be entered for two
+ * reasons:
+ *
+ * 1) device has completed dma transfer
+ * 2) service request to start a command
+ *
+ * if the drive has an active tag, we first complete that request before
+ * processing any pending SERVICE.
+ */
+ide_startstop_t ide_dmaq_intr(ide_drive_t *drive)
+{
+	struct request *rq = HWGROUP(drive)->rq;
+	byte stat = GET_STAT();
+
+	TCQ_PRINTK("ide_dmaq_intr: stat=%x\n", stat);
+
+	/*
+	 * if a command completion interrupt is pending, do that first and
+	 * check service afterwards
+	 */
+	if (rq)
+		return ide_dmaq_complete(drive, rq, stat);
+
+	/*
+	 * service interrupt
+	 */
+	if (stat & SERVICE_STAT) {
+		TCQ_PRINTK("ide_dmaq_intr: SERV (stat=%x)\n", stat);
+		return ide_service(drive);
+	}
+
+	printk("ide_dmaq_intr: stat=%x, not expected\n", stat);
+	return ide_check_service(drive);
+}
+
+/*
+ * check if the ata adapter this drive is attached to supports the
+ * NOP auto-poll for multiple tcq enabled drives on one channel
+ */
+static int ide_tcq_check_autopoll(ide_drive_t *drive)
+{
+	struct request rq;
+	int drives = 0, i;
+	ide_task_t args;
+
+	/*
+	 * only need to probe if both drives on a channel support tcq
+	 */
+	for (i = 0; i < MAX_DRIVES; i++)
+		if (HWIF(drive)->drives[i].present && drive->media == ide_disk)
+			drives++;
+
+	if (drives <= 1)
+		return 0;
+
+	/*
+	 * what a mess...
+	 */
+	memset(&args, 0, sizeof(args));
+
+	args.tfRegister[IDE_FEATURE_OFFSET] = 0x01;
+	args.tfRegister[IDE_COMMAND_OFFSET] = WIN_NOP;
+	ide_init_drive_taskfile(&rq);
+	args.command_type = IDE_DRIVE_TASK_NO_DATA;
+	args.handler = ide_tcq_nop_handler;
+	rq.cmd = IDE_DRIVE_TASKFILE;
+	rq.special = &args;
+	(void) ide_do_drive_cmd(drive, &rq, ide_wait);
+
+	/*
+	 * do taskfile and check ABRT bit -- intelligent adapters will not
+	 * pass NOP with sub-code 0x01 to device, so the command will not
+	 * fail there
+	 */
+	ide_raw_taskfile(drive, &args, NULL);
+	if (args.tfRegister[IDE_FEATURE_OFFSET] & ABRT_ERR)
+		return 1;
+
+	HWIF(drive)->auto_poll = 1;
+	printk("%s: NOP Auto-poll enabled\n", HWIF(drive)->name);
+	return 0;
+}
+
+/*
+ * configure the drive for tcq
+ */
+static int ide_tcq_configure(ide_drive_t *drive)
+{
+	int tcq_mask = 1 << 1 | 1 << 14;
+	int tcq_bits = tcq_mask | 1 << 15;
+	struct hd_drive_task_hdr taskfile;
+	struct hd_drive_hob_hdr hobfile;
+
+	/*
+	 * bit 14 and 1 must be set in word 83 of the device id to indicate
+	 * support for dma queued protocol, and bit 15 must be cleared
+	 */
+	if ((drive->id->command_set_2 & tcq_bits) ^ tcq_mask)
+		return -EIO;
+
+	memset(&taskfile, 0, sizeof(taskfile));
+	memset(&hobfile, 0, sizeof(hobfile));
+	taskfile.command = WIN_SETFEATURES;
+	taskfile.feature = SETFEATURES_EN_WCACHE;
+
+	if (ide_wait_taskfile(drive, &taskfile, &hobfile, NULL)) {
+		printk("%s: failed to enable write cache\n", drive->name);
+		return 1;
+	}
+
+	/*
+	 * disable RELease interrupt, it's quicker to poll this after
+	 * having sent the command opcode
+	 */
+	memset(&taskfile, 0, sizeof(taskfile));
+	memset(&hobfile, 0, sizeof(hobfile));
+	taskfile.command = WIN_SETFEATURES;
+	taskfile.feature = SETFEATURES_DIS_RI;
+
+	if (ide_wait_taskfile(drive, &taskfile, &hobfile, NULL)) {
+		printk("%s: disabling release interrupt fail\n", drive->name);
+		return 1;
+	}
+
+#ifdef IDE_TCQ_FIDDLE_SI
+	/*
+	 * enable SERVICE interrupt
+	 */
+	memset(&taskfile, 0, sizeof(taskfile));
+	memset(&hobfile, 0, sizeof(hobfile));
+	taskfile.command = WIN_SETFEATURES;
+	taskfile.feature = SETFEATURES_EN_SI;
+
+	if (ide_wait_taskfile(drive, &taskfile, &hobfile, NULL)) {
+		printk("%s: enabling service interrupt fail\n", drive->name);
+		return 1;
+	}
+#endif
+
+	return 0;
+}
+
+/*
+ * for now assume that command list is always as big as we need and don't
+ * attempt to shrink it on tcq disable
+ */
+static int ide_enable_queued(ide_drive_t *drive, int on)
+{
+	int depth = drive->using_tcq ? drive->queue_depth : 0;
+
+	/*
+	 * disable or adjust queue depth
+	 */
+	if (!on) {
+		if (drive->using_tcq)
+			printk("%s: TCQ disabled\n", drive->name);
+		drive->using_tcq = 0;
+		return 0;
+	}
+
+	if (ide_tcq_configure(drive)) {
+		drive->using_tcq = 0;
+		return 1;
+	}
+
+	/*
+	 * enable block tagging
+	 */
+	if (!blk_queue_tagged(&drive->queue))
+		blk_queue_init_tags(&drive->queue, IDE_MAX_TAG);
+
+	/*
+	 * check auto-poll support
+	 */
+	ide_tcq_check_autopoll(drive);
+
+	if (depth != drive->queue_depth)
+		printk("%s: tagged command queueing enabled, command queue depth %d\n", drive->name, drive->queue_depth);
+
+	drive->using_tcq = 1;
+	return 0;
+}
+
+int ide_tcq_wait_dataphase(ide_drive_t *drive)
+{
+	byte stat;
+	int i;
+
+	while ((stat = GET_STAT()) & BUSY_STAT)
+		udelay(10);
+
+	if (OK_STAT(stat, READY_STAT | DRQ_STAT, drive->bad_wstat))
+		return 0;
+
+	i = 0;
+	udelay(1);
+	while (!OK_STAT(GET_STAT(), READY_STAT | DRQ_STAT, drive->bad_wstat)) {
+		if (unlikely(i++ > IDE_TCQ_WAIT))
+			return 1;
+
+		udelay(10);
+	}
+
+	return 0;
+}
+
+ide_startstop_t ide_tcq_dmaproc(ide_dma_action_t func, ide_drive_t *drive)
+{
+	ide_hwgroup_t *hwgroup = HWGROUP(drive);
+	ide_hwif_t *hwif = HWIF(drive);
+	unsigned int enable_tcq = 1;
+	struct request *rq = hwgroup->rq;
+	unsigned int reading = 0;
+	byte stat, feat, command;
+
+	switch (func) {
+		/*
+		 * invoked from a SERVICE interrupt, command etc already known.
+		 * just need to start the dma engine for this tag
+		 */
+		case ide_dma_queued_start:
+			TCQ_PRINTK("ide_dma: setting up queued %d\n", rq->tag);
+
+			if (!hwgroup->busy)
+				printk("queued_rw: hwgroup not busy\n");
+
+			if (ide_tcq_wait_dataphase(drive))
+				return ide_stopped;
+
+			if (rq->cmd == READ)
+				reading = 1 << 3;
+
+			if (ide_start_dma(func, drive, reading))
+				return ide_stopped;
+
+			ide_tcq_set_intr(HWGROUP(drive), ide_dmaq_intr);
+
+			if (!hwif->dmaproc(ide_dma_begin, drive))
+				return ide_started;
+
+			return ide_stopped;
+
+			/*
+			 * start a queued command from scratch
+			 */
+		case ide_dma_read_queued:
+		case ide_dma_write_queued: {
+			TCQ_PRINTK("%s: start tag %d\n", drive->name, rq->tag);
+
+			/*
+			 * set nIEN, tag start operation will enable again when
+			 * it is safe
+			 */
+			drive_ctl_nien(drive, 1);
+
+			/*
+			 * stupid mixed taskfile and non-taskfile calls
+			 */
+			if (rq->cmd == READ)
+				command = drive->addressing ? WIN_READDMA_QUEUED_EXT : WIN_READDMA_QUEUED;
+			else
+				command = drive->addressing ? WIN_WRITEDMA_QUEUED_EXT : WIN_WRITEDMA_QUEUED;
+		
+			OUT_BYTE(command, IDE_COMMAND_REG);
+
+			if (ide_tcq_wait_altstat(drive, &stat, BUSY_STAT)) {
+				ide_dump_status(drive, "queued start", stat);
+				ide_tcq_invalidate_queue(drive);
+				return ide_stopped;
+			}
+
+			drive_ctl_nien(drive, 0);
+
+			if (stat & ERR_STAT) {
+				ide_dump_status(drive, "tcq_start", stat);
+				return ide_stopped;
+			}
+
+			/*
+			 * drive released the bus, clear active tag and
+			 * check for service
+			 */
+			if ((feat = GET_FEAT()) & NSEC_REL) {
+				drive->immed_rel++;
+				HWGROUP(drive)->rq = NULL;
+				ide_tcq_set_intr(HWGROUP(drive), ide_dmaq_intr);
+
+				TCQ_PRINTK("REL in queued_start\n");
+
+				if ((stat = GET_STAT()) & SERVICE_STAT)
+					return ide_service(drive);
+
+				return ide_released;
+			}
+
+			TCQ_PRINTK("IMMED in queued_start\n");
+			drive->immed_comp++;
+			return hwif->dmaproc(ide_dma_queued_start, drive);
+			}
+
+		case ide_dma_queued_off:
+			enable_tcq = 0;
+		case ide_dma_queued_on:
+			if (enable_tcq && !drive->using_dma)
+				return 1;
+			return ide_enable_queued(drive, enable_tcq);
+		default:
+			break;
+	}
+
+	return 1;
+}
diff -urzN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.4.19-pre8/drivers/ide/Makefile linux/drivers/ide/Makefile
--- /opt/kernel/linux-2.4.19-pre8/drivers/ide/Makefile	2002-05-03 08:42:13.000000000 +0200
+++ linux/drivers/ide/Makefile	2002-05-06 13:24:29.000000000 +0200
@@ -46,6 +46,7 @@
 ide-obj-$(CONFIG_BLK_DEV_IDE_ICSIDE)	+= icside.o
 ide-obj-$(CONFIG_BLK_DEV_ADMA)		+= ide-adma.o
 ide-obj-$(CONFIG_BLK_DEV_IDEDMA_PCI)	+= ide-dma.o
+ide-obj-$(CONFIG_BLK_DEV_IDE_TCQ)	+= ide-tcq.o
 ide-obj-$(CONFIG_BLK_DEV_IDEPCI)	+= ide-pci.o
 ide-obj-$(CONFIG_BLK_DEV_ISAPNP)	+= ide-pnp.o
 ide-obj-$(CONFIG_BLK_DEV_IDE_PMAC)	+= ide-pmac.o
diff -urzN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.4.19-pre8/include/linux/hdreg.h linux/include/linux/hdreg.h
--- /opt/kernel/linux-2.4.19-pre8/include/linux/hdreg.h	2002-05-03 08:42:22.000000000 +0200
+++ linux/include/linux/hdreg.h	2002-05-06 13:24:29.000000000 +0200
@@ -34,6 +34,7 @@
 #define ECC_STAT		0x04	/* Corrected error */
 #define DRQ_STAT		0x08
 #define SEEK_STAT		0x10
+#define SERVICE_STAT		SEEK_STAT
 #define WRERR_STAT		0x20
 #define READY_STAT		0x40
 #define BUSY_STAT		0x80
@@ -50,6 +51,13 @@
 #define ICRC_ERR		0x80	/* new meaning:  CRC error during transfer */
 
 /*
+ * sector count bits
+ */
+#define NSEC_CD			0x01
+#define NSEC_IO			0x02
+#define NSEC_REL		0x04
+
+/*
  * Command Header sizes for IOCTL commands
  *	HDIO_DRIVE_CMD, HDIO_DRIVE_TASK, and HDIO_DRIVE_TASKFILE
  */
diff -urzN -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.4.19-pre8/include/linux/ide.h linux/include/linux/ide.h
--- /opt/kernel/linux-2.4.19-pre8/include/linux/ide.h	2002-05-03 08:42:22.000000000 +0200
+++ linux/include/linux/ide.h	2002-05-06 13:24:53.000000000 +0200
@@ -163,6 +163,7 @@
 #define GET_ERR()		IN_BYTE(IDE_ERROR_REG)
 #define GET_STAT()		IN_BYTE(IDE_STATUS_REG)
 #define GET_ALTSTAT()		IN_BYTE(IDE_CONTROL_REG)
+#define GET_FEAT()		IN_BYTE(IDE_NSECTOR_REG)
 #define OK_STAT(stat,good,bad)	(((stat)&((good)|(bad)))==(good))
 #define BAD_R_STAT		(BUSY_STAT   | ERR_STAT)
 #define BAD_W_STAT		(BAD_R_STAT  | WRERR_STAT)
@@ -357,6 +358,7 @@
 	special_t	special;	/* special action flags */
 	byte     keep_settings;		/* restore settings after drive reset */
 	byte     using_dma;		/* disk is using dma for read/write */
+	byte	 using_tcq;		/* disk is using queueing */
 	byte	 retry_pio;		/* retrying dma capable host in pio */
 	byte	 state;			/* retry state */
 	byte     waiting_for_dma;	/* dma currently in progress */
@@ -426,8 +428,16 @@
 	byte		dn;		/* now wide spread use */
 	byte		wcache;		/* status of write cache */
 	byte		acoustic;	/* acoustic management */
+	byte		queue_depth;	/* max queue depth */
 	unsigned int	failures;	/* current failure count */
 	unsigned int	max_failures;	/* maximum allowed failure count */
+	/*
+	 * tcq statistics
+	 */
+	unsigned long	immed_rel;
+	unsigned long	immed_comp;
+	int		max_last_depth;
+	int		max_depth;
 } ide_drive_t;
 
 /*
@@ -446,7 +456,10 @@
 		ide_dma_off,	ide_dma_off_quietly,	ide_dma_test_irq,
 		ide_dma_bad_drive,			ide_dma_good_drive,
 		ide_dma_verbose,			ide_dma_retune,
-		ide_dma_lostirq,			ide_dma_timeout
+		ide_dma_lostirq,			ide_dma_timeout,
+		ide_dma_read_queued,			ide_dma_write_queued,
+		ide_dma_queued_start,			ide_dma_queued_on,
+		ide_dma_queued_off,
 } ide_dma_action_t;
 
 typedef int (ide_dmaproc_t)(ide_dma_action_t, ide_drive_t *);
@@ -511,6 +524,29 @@
 #define IDE_PCI_DEVID_EQ(a,b)	(a.vid == b.vid && a.did == b.did)
 #endif /* CONFIG_BLK_DEV_IDEPCI */
 
+#define IDE_MAX_TAG	32
+
+#ifdef CONFIG_BLK_DEV_IDE_TCQ
+static inline int ata_pending_commands(ide_drive_t *drive)
+{
+	if (drive->using_tcq)
+		return blk_queue_tag_depth(&drive->queue);
+
+	return 0;
+}
+
+static inline int ata_can_queue(ide_drive_t *drive)
+{
+	if (drive->using_tcq)
+		return blk_queue_tag_queue(&drive->queue);
+
+	return 1;
+}
+#else
+#define ata_pending_commands(drive)	(0)
+#define ata_can_queue(drive)		(1)
+#endif
+
 typedef struct hwif_s {
 	struct hwif_s	*next;		/* for linked-list in ide_hwgroup_t */
 	void		*hwgroup;	/* actually (ide_hwgroup_t *) */
@@ -552,6 +588,7 @@
 	unsigned	reset      : 1;	/* reset after probe */
 	unsigned	autodma    : 1;	/* automatically try to enable DMA at boot */
 	unsigned	udma_four  : 1;	/* 1=ATA-66 capable, 0=default */
+	unsigned	auto_poll  : 1; /* supports nop auto-poll */
 	byte		channel;	/* for dual-port chips: 0=primary, 1=secondary */
 #ifdef CONFIG_BLK_DEV_IDEPCI
 	struct pci_dev	*pci_dev;	/* for pci chipsets */
@@ -571,7 +608,8 @@
  */
 typedef enum {
 	ide_stopped,	/* no drive operation was started */
-	ide_started	/* a drive operation was started, and a handler was set */
+	ide_started,	/* a drive operation was started, and a handler was set */
+	ide_released,	/* as ide_started, but bus also released */
 } ide_startstop_t;
 
 /*
@@ -590,6 +628,7 @@
 typedef struct hwgroup_s {
 	ide_handler_t		*handler;/* irq handler, if active */
 	volatile int		busy;	/* BOOL: protects all fields below */
+	volatile int		dma;	/* dma in progress */
 	int			sleeping; /* BOOL: wake us up on timer expiry */
 	ide_drive_t		*drive;	/* current drive */
 	ide_hwif_t		*hwif;	/* ptr to current hwif in linked-list */
@@ -1089,9 +1128,11 @@
 int check_drive_lists (ide_drive_t *drive, int good_bad);
 int report_drive_dmaing (ide_drive_t *drive);
 int ide_dmaproc (ide_dma_action_t func, ide_drive_t *drive);
+extern ide_startstop_t ide_tcq_dmaproc(ide_dma_action_t func, ide_drive_t *drive);
 int ide_release_dma (ide_hwif_t *hwif);
 void ide_setup_dma (ide_hwif_t *hwif, unsigned long dmabase, unsigned int num_ports) __init;
 unsigned long ide_get_or_set_dma_base (ide_hwif_t *hwif, int extra, const char *name) __init;
+extern int ide_start_dma(ide_dma_action_t func, ide_drive_t *drive, unsigned int reading);
 #endif
 
 void hwif_unregister (ide_hwif_t *hwif);

--7JfCtLOvnd9MIVvH--
