Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311710AbSEAMiE>; Wed, 1 May 2002 08:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311829AbSEAMiD>; Wed, 1 May 2002 08:38:03 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:50705 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S311710AbSEAMhh>;
	Wed, 1 May 2002 08:37:37 -0400
Date: Wed, 1 May 2002 14:37:05 +0200
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>,
        Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] reworked IDE/general tagged command queueing
Message-ID: <20020501123705.GI837@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="hQiwHBbRI9kgIhsi"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I've rewritten parts of the IDE TCQ stuff to be, well, a lot better in
my oppinion. I had to accept that the ata_request and rq->special usage
sucked, it was just one big mess.

So following a suggestion from Martin and Linus, I implemented some
basic tagged command queueing back end in the block layer. This is what
the new IDE TCQ core is build on, and what potentially others can use as
well. I'll start by describing the new API:

int blk_queue_init_tags(request_queue_t *q, int depth)

	Setup queueing structures for the request queue and depth given.
	This will setup q->queue_tags, which is a struct blk_queue_tag:

	struct blk_queue_tag {
		struct request **tag_index; /* map of busy tags */
		unsigned long *tag_map;     /* bit map of free/busy tags */
		struct list_head busy_list; /* fifo list of busy tags */
		int busy;                   /* current depth */
		int max_depth;
	};

	tag_index[] holds pointers to the active requests, and tag_map
 	is a bitmap of busy tags. The rest should not need any
	explanation.

void blk_queue_free_tags(request_queue_t *q)

	Tear down the tag info setup by blk_queue_init_tags(). This will
	be done automatically when blk_cleanup_queue() is called, so
	there's usually no need to call this directly (unless you just
	want to disable tagging and let the queue live on).

int blk_queue_start_tag(request_queue_t *q, struct request *rq)

	Start a new tag associated with struct request. This will grab
	an available tag number and add it to the internal structures.

void blk_queue_end_tag(request_queue_t *q, struct request *rq)

	End this tag. Typically called when end_that_request_first()
	says the request is done, before calling
	end_that_request_last().

void blk_queue_invalidate_tags(request_queue_t *q)

	Called by driver to clear our internal tag queue and readd the
	requests to the request queue. Submission order is preserved,
	so should be safe for barriers too.

That's it. For an example of usage, see the IDE TCQ patch attached as
well. The API can of course be extended if the need arises, I've kept it
simple on purpose since it was all I needed for the IDE parts -- and
it's silly to add features just because you _think_ someone might need
them.

Now on to the IDE parts. The TCQ patch is now a LOT less invasive than
before. With the block tagged features in place, there's no need for a
private request type in the IDE layer -- struct request is just fine.
Changes to IDE core (ide.c) are now extremely small. Changes to ide-disk
are minute as well, most of it is actually just the proc file stuff.
ide-dma changes are mainly needed because otherwise ide-tcq would have
to duplicate the ide_start_dma() functionality on its own. ide-taskfile
changes are just to detect the new commands possibly (read queued etc)
and a spelling fix :-). There is one ugly hack in ide-taskfile, that
will disappear once the dmaproc parts are split in two as outlined in
the FIXME there.

So give it a whirl, patches is against 2.5.12. block-tag-4 can be
applied independently, ide-tag-2 relies on it of course.

Note that hdparm-4.7 and later has support for enabling and disabling
tcq/queue depth, it's done with the -Q parameter:

bart:~ # hdparm -Q0 /dev/hdc

/dev/hdc:
 setting using_dma_q to 0 (off)
 using_dma_q    =  0 (off)

bart:~ # hdparm -Q32 /dev/hdc

/dev/hdc:
 setting using_dma_q to 32 (on)
 using_dma_q    =  1 (on)

and so forth :-)

Find it here:

http://www.ibiblio.org/pub/Linux/system/hardware/

-- 
Jens Axboe


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=block-tag-4

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.569   -> 1.570  
#	drivers/block/ll_rw_blk.c	1.64    -> 1.65   
#	include/linux/blkdev.h	1.43    -> 1.44   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/01	axboe@burns.home.kernel.dk	1.570
# Initial block level tagged command queueing helpers
# --------------------------------------------
#
diff -Nru a/drivers/block/ll_rw_blk.c b/drivers/block/ll_rw_blk.c
--- a/drivers/block/ll_rw_blk.c	Wed May  1 14:36:31 2002
+++ b/drivers/block/ll_rw_blk.c	Wed May  1 14:36:31 2002
@@ -311,9 +311,221 @@
 	q->queue_lock = lock;
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
+	q->queue_flags &= ~(1 << QUEUE_FLAG_QUEUED);
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
+	int bits;
+
+	if (depth > queue_nr_requests)
+		depth = queue_nr_requests;
+
+	tags = kmalloc(sizeof(struct blk_queue_tag),GFP_ATOMIC);
+	if (!tags)
+		goto fail;
+
+	tags->tag_index = kmalloc(depth * sizeof(struct request *), GFP_ATOMIC);
+	if (!tags->tag_index)
+		goto fail_index;
+
+	bits = depth / BLK_TAGS_PER_LONG;
+	tags->tag_map = kmalloc(bits * sizeof(unsigned long), GFP_ATOMIC);
+	if (!tags->tag_map)
+		goto fail_map;
+
+	memset(tags->tag_index, depth * sizeof(struct request *), 0);
+	memset(tags->tag_map, bits * sizeof(unsigned long), 0);
+	INIT_LIST_HEAD(&tags->busy_list);
+	tags->busy = 0;
+	tags->max_depth = depth;
+
+	/*
+	 * assign it, all done
+	 */
+	q->queue_tags = tags;
+	q->queue_flags |= (1 << QUEUE_FLAG_QUEUED);
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
+/*
+ * queue_lock must be held for both get_tag and clear_tag
+ */
+static int blk_queue_get_tag(struct blk_queue_tag *bqt)
+{
+	unsigned long *map;
+	int i, depth, tag, bit;
+
+	tag = -1;
+	depth = i = 0;
+	do {
+		map = &bqt->tag_map[i++];
+		if (*map != -1UL)
+			break;
+
+		depth += BLK_TAGS_PER_LONG;
+		if (depth < bqt->max_depth)
+			continue;
+
+		map = NULL;
+	} while (map);
+
+	if (map) {
+		bit = ffz(*map);
+		if (bit + depth <= bqt->max_depth) {
+			__set_bit(bit, map);
+			tag = bit + depth;
+		}
+	}
+
+	return tag;
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
+ *   queue lock must be held.
+ **/
+void blk_queue_end_tag(request_queue_t *q, struct request *rq)
+{
+	struct blk_queue_tag *bqt = q->queue_tags;
+	int tag = rq->tag;
+
+	BUG_ON(tag == -1);
+
+	if (unlikely(!__test_and_clear_bit(tag, bqt->tag_map))) {
+		printk("attempt to clear non-busy tag (%d)\n", tag);
+		return;
+	}
+
+	list_del(&rq->queuelist);
+	rq->flags &= ~REQ_QUEUED;
+	rq->tag = -1;
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
+ *    This can either be used as a stand-alone helper, or possibly be
+ *    assigned as the queue &prep_rq_fn (in which case &struct request
+ *    automagically gets a tag assigned). Note that this function assumes
+ *    that only REQ_CMD requests can be queued! The request will also be
+ *    removed from the request queue, so it's the drivers responsibility to
+ *    readd it if it should need to be restarted for some reason.
+ *
+ *  Notes:
+ *   queue lock must be held.
+ **/
+int blk_queue_start_tag(request_queue_t *q, struct request *rq)
+{
+	struct blk_queue_tag *bqt = q->queue_tags;
+	int tag;
+
+	if (unlikely(!(rq->flags & REQ_CMD)))
+		return 1;
+
+	tag = blk_queue_get_tag(bqt);
+	if (tag != -1) {
+		rq->flags |= REQ_QUEUED;
+		rq->tag = tag;
+		bqt->tag_index[tag] = rq;
+		blkdev_dequeue_request(rq);
+		list_add(&rq->queuelist, &bqt->busy_list);
+		bqt->busy++;
+		return 0;
+	}
+
+	return 1;
+}
+
+/**
+ * blk_queue_invalidate_tags - invalidate all pending tags
+ * @q:  the request queue for the device
+ *
+ *  Description:
+ *   Hardware conditions make dictate a need to stop all pending request.
+ *   In this case, we will safely clear the block side of the tag queue and
+ *   readd all request to the request queue in the right order.
+ *
+ *  Notes:
+ *   queue lock must be held.
+ **/
+void blk_queue_invalidate_tags(request_queue_t *q)
+{
+	struct blk_queue_tag *bqt = q->queue_tags;
+	struct list_head *tmp;
+	struct request *rq;
+
+	list_for_each(tmp, &bqt->busy_list) {
+		rq = list_entry_rq(tmp);
+
+		blk_queue_end_tag(q, rq);
+		rq->flags &= ~REQ_STARTED;
+		elv_add_request(q, rq, 0);
+	}
+}
+
 static char *rq_flags[] = { "REQ_RW", "REQ_RW_AHEAD", "REQ_BARRIER",
 			   "REQ_CMD", "REQ_NOMERGE", "REQ_STARTED",
-			   "REQ_DONTPREP", "REQ_DRIVE_CMD",
+			   "REQ_DONTPREP", "REQ_QUEUED", "REQ_DRIVE_CMD",
 			   "REQ_DRIVE_ACB", "REQ_PC", "REQ_BLOCK_PC",
 			   "REQ_SENSE", "REQ_SPECIAL" };
 
@@ -619,7 +831,7 @@
 	total_hw_segments = req->nr_hw_segments + next->nr_hw_segments;
 	if (blk_hw_contig_segment(q, req->biotail, next->bio))
 		total_hw_segments--;
-    
+
 	if (total_hw_segments > q->max_hw_segments)
 		return 0;
 
@@ -719,7 +931,7 @@
  *     when a block device is being de-registered.  Currently, its
  *     primary task it to free all the &struct request structures that
  *     were allocated to the queue.
- * Caveat: 
+ * Caveat:
  *     Hopefully the low level driver will have finished any
  *     outstanding requests first...
  **/
@@ -733,6 +945,9 @@
 	if (count)
 		printk("blk_cleanup_queue: leaked requests (%d)\n", count);
 
+	if (blk_queue_tagged(q))
+		blk_queue_free_tags(q);
+
 	elevator_exit(q, &q->elevator);
 
 	memset(q, 0, sizeof(*q));
@@ -1599,7 +1814,7 @@
  * Description:
  *     Ends I/O on the first buffer attached to @req, and sets it up
  *     for the next buffer_head (if any) in the cluster.
- *     
+ *
  * Return:
  *     0 - we are done with this request, call end_that_request_last()
  *     1 - still buffers pending for this request
@@ -1753,3 +1968,9 @@
 
 EXPORT_SYMBOL(ll_10byte_cmd_build);
 EXPORT_SYMBOL(blk_queue_prep_rq);
+
+EXPORT_SYMBOL(blk_queue_init_tags);
+EXPORT_SYMBOL(blk_queue_free_tags);
+EXPORT_SYMBOL(blk_queue_start_tag);
+EXPORT_SYMBOL(blk_queue_end_tag);
+EXPORT_SYMBOL(blk_queue_invalidate_tags);
diff -Nru a/include/linux/blkdev.h b/include/linux/blkdev.h
--- a/include/linux/blkdev.h	Wed May  1 14:36:31 2002
+++ b/include/linux/blkdev.h	Wed May  1 14:36:31 2002
@@ -56,6 +56,7 @@
 
 	unsigned int current_nr_sectors;
 	unsigned int hard_cur_sectors;
+	int tag;
 	void *special;
 	char *buffer;
 	struct completion *waiting;
@@ -75,6 +76,7 @@
 	__REQ_NOMERGE,	/* don't touch this for merging */
 	__REQ_STARTED,	/* drive already may have started this one */
 	__REQ_DONTPREP,	/* don't call prep for this one */
+	__REQ_QUEUED,	/* uses queueing */
 	/*
 	 * for ATA/ATAPI devices
 	 */
@@ -97,6 +99,7 @@
 #define REQ_NOMERGE	(1 << __REQ_NOMERGE)
 #define REQ_STARTED	(1 << __REQ_STARTED)
 #define REQ_DONTPREP	(1 << __REQ_DONTPREP)
+#define REQ_QUEUED	(1 << __REQ_QUEUED)
 #define REQ_DRIVE_CMD	(1 << __REQ_DRIVE_CMD)
 #define REQ_DRIVE_ACB	(1 << __REQ_DRIVE_ACB)
 #define REQ_PC		(1 << __REQ_PC)
@@ -121,6 +124,17 @@
 	Queue_up,
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
 /*
  * Default nr free requests per queue, ll_rw_blk will scale it down
  * according to available RAM at init time
@@ -193,6 +207,8 @@
 	unsigned long		seg_boundary_mask;
 
 	wait_queue_head_t	queue_wait;
+
+	struct blk_queue_tag	*queue_tags;
 };
 
 #define RQ_INACTIVE		(-1)
@@ -203,9 +219,11 @@
 
 #define QUEUE_FLAG_PLUGGED	0	/* queue is plugged */
 #define QUEUE_FLAG_CLUSTER	1	/* cluster several segments into 1 */
+#define QUEUE_FLAG_QUEUED	2	/* uses generic tag queueing */
 
 #define blk_queue_plugged(q)	test_bit(QUEUE_FLAG_PLUGGED, &(q)->queue_flags)
 #define blk_mark_plugged(q)	set_bit(QUEUE_FLAG_PLUGGED, &(q)->queue_flags)
+#define blk_queue_tagged(q)	test_bit(QUEUE_FLAG_QUEUED, &(q)->queue_flags)
 #define blk_queue_empty(q)	elv_queue_empty(q)
 #define list_entry_rq(ptr)	list_entry((ptr), struct request, queuelist)
 
@@ -315,6 +333,19 @@
 extern int blk_rq_map_sg(request_queue_t *, struct request *, struct scatterlist *);
 extern void blk_dump_rq_flags(struct request *, char *);
 extern void generic_unplug_device(void *);
+
+/*
+ * tag stuff
+ */
+#define blk_queue_tag_request(q, tag)	((q)->queue_tags->tag_index[(tag)])
+#define blk_queue_tag_depth(q)		((q)->queue_tags->busy)
+#define blk_queue_tag_queue(q)		((q)->queue_tags->busy < (q)->queue_tags->max_depth)
+#define blk_rq_tagged(rq)		((rq)->flags & REQ_QUEUED)
+extern int blk_queue_start_tag(request_queue_t *, struct request *);
+extern void blk_queue_end_tag(request_queue_t *, struct request *);
+extern int blk_queue_init_tags(request_queue_t *, int);
+extern void blk_queue_free_tags(request_queue_t *);
+extern void blk_queue_invalidate_tags(request_queue_t *);
 
 extern int * blk_size[MAX_BLKDEV];	/* in units of 1024 bytes */
 extern int * blksize_size[MAX_BLKDEV];

--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ide-tag-2

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.570   -> 1.571  
#	drivers/ide/ide-probe.c	1.41    -> 1.42   
#	drivers/ide/ide-disk.c	1.44    -> 1.45   
#	drivers/ide/Makefile	1.16    -> 1.17   
#	drivers/ide/ide-dma.c	1.35    -> 1.36   
#	 include/linux/ide.h	1.51    -> 1.52   
#	   drivers/ide/ide.c	1.71    -> 1.72   
#	drivers/ide/ide-taskfile.c	1.30    -> 1.31   
#	drivers/ide/Config.help	1.17    -> 1.18   
#	drivers/ide/Config.in	1.20    -> 1.21   
#	drivers/ide/pdc202xx.c	1.24    -> 1.25   
#	               (new)	        -> 1.1     drivers/ide/ide-tcq.c
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/01	axboe@burns.home.kernel.dk	1.571
# Initial ide tcq support, based on the new block helpers
# --------------------------------------------
#
diff -Nru a/drivers/ide/Config.help b/drivers/ide/Config.help
--- a/drivers/ide/Config.help	Wed May  1 14:36:39 2002
+++ b/drivers/ide/Config.help	Wed May  1 14:36:39 2002
@@ -751,6 +751,35 @@
 
   Generally say N here.
 
+CONFIG_BLK_DEV_IDE_TCQ
+  Support for tagged command queueing on ATA disk drives. This enables
+  the IDE layer to have multiple in-flight requests on hardware that
+  supports it. For now this includes the IBM Deskstar series drives,
+  such as the 22GXP, 75GXP, 40GV, 60GXP, and 120GXP (ie any Deskstar made
+  in the last couple of years), and at least some of the Western
+  Digital drives in the Expert series.
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
+  TCQ, and 0 disables it.
+
+  Generally say Y here.
+
 CONFIG_BLK_DEV_IT8172
   Say Y here to support the on-board IDE controller on the Integrated
   Technology Express, Inc. ITE8172 SBC.  Vendor page at
diff -Nru a/drivers/ide/Config.in b/drivers/ide/Config.in
--- a/drivers/ide/Config.in	Wed May  1 14:36:39 2002
+++ b/drivers/ide/Config.in	Wed May  1 14:36:39 2002
@@ -47,6 +47,11 @@
 	 dep_bool '      Use PCI DMA by default when available' CONFIG_IDEDMA_PCI_AUTO $CONFIG_BLK_DEV_IDEDMA_PCI
          dep_bool '    Enable DMA only for disks ' CONFIG_IDEDMA_ONLYDISK $CONFIG_IDEDMA_PCI_AUTO
 	 define_bool CONFIG_BLK_DEV_IDEDMA $CONFIG_BLK_DEV_IDEDMA_PCI
+	 dep_bool '    ATA tagged command queueing' CONFIG_BLK_DEV_IDE_TCQ $CONFIG_BLK_DEV_IDEDMA_PCI
+	 dep_bool '      TCQ on by default' CONFIG_BLK_DEV_IDE_TCQ_DEFAULT $CONFIG_BLK_DEV_IDE_TCQ
+	 if [ "$CONFIG_BLK_DEV_IDE_TCQ" != "n" ]; then
+	    int '      Default queue depth' CONFIG_BLK_DEV_IDE_TCQ_DEPTH 32
+	 fi
 	 dep_bool '    Good-Bad DMA Model-Firmware (EXPERIMENTAL)' CONFIG_IDEDMA_NEW_DRIVE_LISTINGS $CONFIG_EXPERIMENTAL
 	 dep_bool '    AEC62XX chipset support' CONFIG_BLK_DEV_AEC62XX $CONFIG_BLK_DEV_IDEDMA_PCI
 	 dep_mbool '      AEC62XX Tuning support' CONFIG_AEC62XX_TUNING $CONFIG_BLK_DEV_AEC62XX
diff -Nru a/drivers/ide/Makefile b/drivers/ide/Makefile
--- a/drivers/ide/Makefile	Wed May  1 14:36:39 2002
+++ b/drivers/ide/Makefile	Wed May  1 14:36:39 2002
@@ -44,6 +44,7 @@
 ide-obj-$(CONFIG_BLK_DEV_HT6560B)	+= ht6560b.o
 ide-obj-$(CONFIG_BLK_DEV_IDE_ICSIDE)	+= icside.o
 ide-obj-$(CONFIG_BLK_DEV_IDEDMA_PCI)	+= ide-dma.o
+ide-obj-$(CONFIG_BLK_DEV_IDE_TCQ)	+= ide-tcq.o
 ide-obj-$(CONFIG_BLK_DEV_IDEPCI)	+= ide-pci.o
 ide-obj-$(CONFIG_BLK_DEV_ISAPNP)	+= ide-pnp.o
 ide-obj-$(CONFIG_BLK_DEV_IDE_PMAC)	+= ide-pmac.o
diff -Nru a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c	Wed May  1 14:36:39 2002
+++ b/drivers/ide/ide-disk.c	Wed May  1 14:36:39 2002
@@ -98,6 +98,8 @@
 
 	if (lba48bit) {
 		if (cmd == READ) {
+			if (drive->using_tcq)
+				return WIN_READDMA_QUEUED_EXT;
 			if (drive->using_dma)
 				return WIN_READDMA_EXT;
 			else if (drive->mult_count)
@@ -105,6 +107,8 @@
 			else
 				return WIN_READ_EXT;
 		} else if (cmd == WRITE) {
+			if (drive->using_tcq)
+				return WIN_WRITEDMA_QUEUED_EXT;
 			if (drive->using_dma)
 				return WIN_WRITEDMA_EXT;
 			else if (drive->mult_count)
@@ -114,6 +118,8 @@
 		}
 	} else {
 		if (cmd == READ) {
+			if (drive->using_tcq)
+				return WIN_READDMA_QUEUED;
 			if (drive->using_dma)
 				return WIN_READDMA;
 			else if (drive->mult_count)
@@ -121,6 +127,8 @@
 			else
 				return WIN_READ;
 		} else if (cmd == WRITE) {
+			if (drive->using_tcq)
+				return WIN_WRITEDMA_QUEUED;
 			if (drive->using_dma)
 				return WIN_WRITEDMA;
 			else if (drive->mult_count)
@@ -148,7 +156,11 @@
 
 	memset(&args, 0, sizeof(args));
 
-	args.taskfile.sector_count = sectors;
+	if (blk_rq_tagged(rq)) {
+		args.taskfile.feature = sectors;
+		args.taskfile.sector_count = rq->tag << 3;
+	} else
+		args.taskfile.sector_count = sectors;
 
 	args.taskfile.sector_number = sect;
 	args.taskfile.low_cylinder = cyl;
@@ -184,7 +196,12 @@
 
 	memset(&args, 0, sizeof(args));
 
-	args.taskfile.sector_count = sectors;
+	if (blk_rq_tagged(rq)) {
+		args.taskfile.feature = sectors;
+		args.taskfile.sector_count = rq->tag << 3;
+	} else
+		args.taskfile.sector_count = sectors;
+
 	args.taskfile.sector_number = block;
 	args.taskfile.low_cylinder = (block >>= 8);
 
@@ -226,8 +243,14 @@
 
 	memset(&args, 0, sizeof(args));
 
-	args.taskfile.sector_count = sectors;
-	args.hobfile.sector_count = sectors >> 8;
+	if (blk_rq_tagged(rq)) {
+		args.taskfile.feature = sectors;
+		args.hobfile.feature = sectors >> 8;
+		args.taskfile.sector_count = rq->tag << 3;
+	} else {
+		args.taskfile.sector_count = sectors;
+		args.hobfile.sector_count = sectors >> 8;
+	}
 
 	args.taskfile.sector_number = block;		/* low lba */
 	args.taskfile.low_cylinder = (block >>= 8);	/* mid lba */
@@ -285,6 +308,30 @@
 		return promise_rw_disk(drive, rq, block);
 	}
 
+	/*
+	 * start a tagged operation
+	 */
+	if (drive->using_tcq) {
+		unsigned long flags;
+		int ret;
+
+		spin_lock_irqsave(&ide_lock, flags);
+
+		ret = blk_queue_start_tag(&drive->queue, rq);
+
+		if (ata_pending_commands(drive) > drive->max_depth)
+			drive->max_depth = ata_pending_commands(drive);
+		if (ata_pending_commands(drive) > drive->max_last_depth)
+			drive->max_last_depth = ata_pending_commands(drive);
+
+		spin_unlock_irqrestore(&ide_lock, flags);
+
+		if (ret) {
+			BUG_ON(!ata_pending_commands(drive));
+			return ide_started;
+		}
+	}
+
 	/* 48-bit LBA */
 	if ((drive->id->cfs_enable_2 & 0x0400) && (drive->addressing))
 		return lba48_do_request(drive, rq, block);
@@ -542,11 +589,61 @@
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
+	spin_lock_irqsave(&ide_lock, flags);
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
+	len += sprintf(out+len, "DMA status:\t\t%srunning\n", test_bit(IDE_DMA, &HWGROUP(drive)->flags) ? "" : "not ");
+
+	drive->max_last_depth = 0;
+
+	spin_unlock_irqrestore(&ide_lock, flags);
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
 
@@ -633,6 +730,32 @@
 	return 0;
 }
 
+#ifdef CONFIG_BLK_DEV_IDE_TCQ
+static int set_using_tcq(ide_drive_t *drive, int arg)
+{
+	if (!drive->driver)
+		return -EPERM;
+	if (!drive->channel->udma)
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
+	if (drive->channel->udma(arg ? ide_dma_queued_on : ide_dma_queued_off, drive, NULL))
+		return -EIO;
+
+	return 0;
+}
+#endif
+
 static int probe_lba_addressing (ide_drive_t *drive, int arg)
 {
 	drive->addressing =  0;
@@ -664,6 +787,9 @@
 	ide_add_setting(drive,	"acoustic",		SETTING_RW,					HDIO_GET_ACOUSTIC,	HDIO_SET_ACOUSTIC,	TYPE_BYTE,	0,	254,				1,	1,	&drive->acoustic,		set_acoustic);
 	ide_add_setting(drive,	"failures",		SETTING_RW,					-1,			-1,			TYPE_INT,	0,	65535,				1,	1,	&drive->failures,		NULL);
 	ide_add_setting(drive,	"max_failures",		SETTING_RW,					-1,			-1,			TYPE_INT,	0,	65535,				1,	1,	&drive->max_failures,		NULL);
+#ifdef CONFIG_BLK_DEV_IDE_TCQ
+	ide_add_setting(drive,	"using_tcq",		SETTING_RW,					HDIO_GET_QDMA,		HDIO_SET_QDMA,		TYPE_BYTE,	0,	IDE_MAX_TAG,			1,		1,		&drive->using_tcq,		set_using_tcq);
+#endif
 }
 
 static int idedisk_suspend(struct device *dev, u32 state, u32 level)
diff -Nru a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
--- a/drivers/ide/ide-dma.c	Wed May  1 14:36:39 2002
+++ b/drivers/ide/ide-dma.c	Wed May  1 14:36:39 2002
@@ -523,6 +523,32 @@
 	blk_queue_bounce_limit(&drive->queue, addr);
 }
 
+int ide_start_dma(ide_dma_action_t func, struct ata_device *drive)
+{
+	struct ata_channel *hwif = drive->channel;
+	unsigned long dma_base = hwif->dma_base;
+	unsigned int reading = 0;
+
+	if (rq_data_dir(HWGROUP(drive)->rq) == READ)
+		reading = 1 << 3;
+
+	/* active tuning based on IO direction */
+	if (hwif->rwproc)
+		hwif->rwproc(drive, func);
+
+	/*
+	 * try PIO instead of DMA
+	 */
+	if (!ide_build_dmatable(drive, func))
+		return 1;
+
+	outl(hwif->dmatable_dma, dma_base + 4); /* PRD table */
+	outb(reading, dma_base);		/* specify r/w */
+	outb(inb(dma_base+2)|6, dma_base+2);	/* clear INTR & ERROR flags */
+	drive->waiting_for_dma = 1;
+	return 0;
+}
+
 /*
  * This initiates/aborts DMA read/write operations on a drive.
  *
@@ -544,7 +570,7 @@
 	struct ata_channel *hwif = drive->channel;
 	unsigned long dma_base = hwif->dma_base;
 	byte unit = (drive->select.b.unit & 0x01);
-	unsigned int count, reading = 0, set_high = 1;
+	unsigned int reading = 0, set_high = 1;
 	byte dma_stat;
 
 	switch (func) {
@@ -553,27 +579,27 @@
 		case ide_dma_off_quietly:
 			set_high = 0;
 			outb(inb(dma_base+2) & ~(1<<(5+unit)), dma_base+2);
+#ifdef CONFIG_BLK_DEV_IDE_TCQ
+			hwif->udma(ide_dma_queued_off, drive, rq);
+#endif
 		case ide_dma_on:
 			ide_toggle_bounce(drive, set_high);
 			drive->using_dma = (func == ide_dma_on);
-			if (drive->using_dma)
+			if (drive->using_dma) {
 				outb(inb(dma_base+2)|(1<<(5+unit)), dma_base+2);
+#ifdef CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
+				hwif->udma(ide_dma_queued_on, drive, rq);
+#endif
+			}
 			return 0;
 		case ide_dma_check:
 			return config_drive_for_dma (drive);
 		case ide_dma_read:
 			reading = 1 << 3;
 		case ide_dma_write:
-			/* active tuning based on IO direction */
-			if (hwif->rwproc)
-				hwif->rwproc(drive, func);
-
-			if (!(count = ide_build_dmatable(drive, func)))
-				return 1;	/* try PIO instead of DMA */
-			outl(hwif->dmatable_dma, dma_base + 4); /* PRD table */
-			outb(reading, dma_base);			/* specify r/w */
-			outb(inb(dma_base+2)|6, dma_base+2);		/* clear INTR & ERROR flags */
-			drive->waiting_for_dma = 1;
+			if (ide_start_dma(func, drive))
+				return 1;
+
 			if (drive->type != ATA_DISK)
 				return 0;
 
@@ -588,6 +614,14 @@
 				OUT_BYTE(reading ? WIN_READDMA : WIN_WRITEDMA, IDE_COMMAND_REG);
 			}
 			return drive->channel->udma(ide_dma_begin, drive, NULL);
+#ifdef CONFIG_BLK_DEV_IDE_TCQ
+		case ide_dma_queued_on:
+		case ide_dma_queued_off:
+		case ide_dma_read_queued:
+		case ide_dma_write_queued:
+		case ide_dma_queued_start:
+			return ide_tcq_dmaproc(func, drive, rq);
+#endif
 		case ide_dma_begin:
 			/* Note that this is done *after* the cmd has
 			 * been issued to the drive, as per the BM-IDE spec.
diff -Nru a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c	Wed May  1 14:36:39 2002
+++ b/drivers/ide/ide-probe.c	Wed May  1 14:36:39 2002
@@ -198,6 +198,16 @@
 	if (drive->channel->quirkproc)
 		drive->quirk_list = drive->channel->quirkproc(drive);
 
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
diff -Nru a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
--- a/drivers/ide/ide-taskfile.c	Wed May  1 14:36:39 2002
+++ b/drivers/ide/ide-taskfile.c	Wed May  1 14:36:39 2002
@@ -456,11 +456,39 @@
 		if (args->prehandler != NULL)
 			return args->prehandler(drive, rq);
 	} else {
-		/* for dma commands we down set the handler */
-		if (drive->using_dma &&
-		!(drive->channel->udma(((args->taskfile.command == WIN_WRITEDMA)
-					|| (args->taskfile.command == WIN_WRITEDMA_EXT))
-					? ide_dma_write : ide_dma_read, drive, rq)));
+		ide_dma_action_t dma_act;
+		int tcq = 0;
+
+		if (!drive->using_dma)
+			return ide_started;
+
+		/* for dma commands we don't set the handler */
+		if (args->taskfile.command == WIN_WRITEDMA || args->taskfile.command == WIN_WRITEDMA_EXT)
+			dma_act = ide_dma_write;
+		else if (args->taskfile.command == WIN_READDMA || args->taskfile.command == WIN_READDMA_EXT)
+			dma_act = ide_dma_read;
+		else if (args->taskfile.command == WIN_WRITEDMA_QUEUED || args->taskfile.command == WIN_WRITEDMA_QUEUED_EXT) {
+			tcq = 1;
+			dma_act = ide_dma_write_queued;
+		} else if (args->taskfile.command == WIN_READDMA_QUEUED || args->taskfile.command == WIN_READDMA_QUEUED_EXT) {
+			tcq = 1;
+			dma_act = ide_dma_read_queued;
+		} else {
+			printk("ata_taskfile: unknown command %x\n", args->taskfile.command);
+			return ide_stopped;
+		}
+
+		/*
+		 * FIXME: this is a gross hack, need to unify tcq dma proc and
+		 * regular dma proc -- basically split stuff that needs to act
+		 * on a request from things like ide_dma_check etc.
+		 */
+		if (tcq)
+			return drive->channel->udma(dma_act, drive, rq);
+		else {
+			if (drive->channel->udma(dma_act, drive, rq))
+				return ide_stopped;
+		}
 	}
 
 	return ide_started;
@@ -523,7 +551,7 @@
 	ide__sti();	/* local CPU only */
 
 	if (!OK_STAT(stat = GET_STAT(), READY_STAT, BAD_STAT)) {
-		/* Keep quite for NOP becouse they are expected to fail. */
+		/* Keep quiet for NOP because it is expected to fail. */
 		if (args && args->taskfile.command != WIN_NOP)
 			return ide_error(drive, "task_no_data_intr", stat);
 	}
diff -Nru a/drivers/ide/ide-tcq.c b/drivers/ide/ide-tcq.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/ide/ide-tcq.c	Wed May  1 14:36:39 2002
@@ -0,0 +1,600 @@
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
+#include <linux/interrupt.h>
+#include <linux/ide.h>
+
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
+ide_startstop_t ide_dmaq_intr(ide_drive_t *drive, struct request *rq);
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
+/*
+ * if we encounter _any_ error doing I/O to one of the tags, we must
+ * invalidate the pending queue. clear the software busy queue and requeue
+ * on the request queue for restart. issue a WIN_NOP to clear hardware queue
+ */
+static void ide_tcq_invalidate_queue(ide_drive_t *drive)
+{
+	request_queue_t *q = &drive->queue;
+	unsigned long flags;
+
+	printk("%s: invalidating pending queue (%d)\n", drive->name, ata_pending_commands(drive));
+
+	spin_lock_irqsave(&ide_lock, flags);
+
+	del_timer(&HWGROUP(drive)->timer);
+
+	if (test_bit(IDE_DMA, &HWGROUP(drive)->flags))
+		drive->channel->udma(ide_dma_end, drive, HWGROUP(drive)->rq);
+
+	blk_queue_invalidate_tags(q);
+
+	drive->using_tcq = 0;
+	drive->queue_depth = 1;
+	clear_bit(IDE_BUSY, &HWGROUP(drive)->flags);
+	clear_bit(IDE_DMA, &HWGROUP(drive)->flags);
+	HWGROUP(drive)->handler = NULL;
+
+#if 0
+	/*
+	 * do some internal stuff -- we really need this command to be
+	 * executed before any new commands are started. issue a NOP
+	 * to clear internal queue on drive
+	 */
+	ar = ata_ar_get(drive);
+
+	memset(&ar->ar_task, 0, sizeof(ar->ar_task));
+	AR_TASK_CMD(ar) = WIN_NOP;
+	ide_cmd_type_parser(&ar->ar_task);
+	ar->ar_rq = &HWGROUP(drive)->wrq;
+	init_taskfile_request(ar->ar_rq);
+	ar->ar_rq->rq_dev = mk_kdev(drive->channel->major, (drive->select.b.unit)<<PARTN_BITS);
+	ar->ar_rq->special = ar;
+	_elv_add_request(q, ar->ar_rq, 0, 0);
+#endif
+
+	/*
+	 * make sure that nIEN is cleared
+	 */
+	drive_ctl_nien(drive, 0);
+
+	/*
+	 * start doing stuff again
+	 */
+	q->request_fn(q);
+	spin_unlock_irqrestore(&ide_lock, flags);
+	printk("ide_tcq_invalidate_queue: done\n");
+}
+
+void ide_tcq_intr_timeout(unsigned long data)
+{
+	ide_drive_t *drive = (ide_drive_t *) data;
+	ide_hwgroup_t *hwgroup = HWGROUP(drive);
+	unsigned long flags;
+
+	printk("ide_tcq_intr_timeout: timeout waiting for interrupt...\n");
+
+	spin_lock_irqsave(&ide_lock, flags);
+
+	if (test_and_set_bit(IDE_BUSY, &hwgroup->flags))
+		printk("ide_tcq_intr_timeout: hwgroup not busy\n");
+	if (hwgroup->handler == NULL)
+		printk("ide_tcq_intr_timeout: missing isr!\n");
+
+	spin_unlock_irqrestore(&ide_lock, flags);
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
+void ide_tcq_set_intr(ide_hwgroup_t *hwgroup, ata_handler_t *handler)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ide_lock, flags);
+
+	/*
+	 * always just bump the timer for now, the timeout handling will
+	 * have to be changed to be per-command
+	 */
+	hwgroup->timer.function = ide_tcq_intr_timeout;
+	hwgroup->timer.data = (unsigned long) hwgroup->XXX_drive;
+	mod_timer(&hwgroup->timer, jiffies + 5 * HZ);
+
+	hwgroup->handler = handler;
+	spin_unlock_irqrestore(&ide_lock, flags);
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
+		udelay(10);
+
+		if (unlikely(i++ > IDE_TCQ_WAIT))
+			return 1;
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
+	if (test_bit(IDE_DMA, &HWGROUP(drive)->flags))
+		return ide_stopped;
+
+	/*
+	 * need to select the right drive first...
+	 */
+	if (drive != HWGROUP(drive)->XXX_drive) {
+		SELECT_DRIVE(drive->channel, drive);
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
+	TCQ_PRINTK("ide_service: starting command %x\n", stat);
+	return drive->channel->udma(ide_dma_queued_start, drive, rq);
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
+	ide_tcq_set_intr(HWGROUP(drive), ide_dmaq_intr);
+	return ide_started;
+}
+
+ide_startstop_t ide_dmaq_complete(ide_drive_t *drive, struct request *rq, byte stat)
+{
+	byte dma_stat;
+
+	/*
+	 * transfer was in progress, stop DMA engine
+	 */
+	dma_stat = drive->channel->udma(ide_dma_end, drive, rq);
+
+	/*
+	 * must be end of I/O, check status and complete as necessary
+	 */
+	if (unlikely(!OK_STAT(stat, READY_STAT, drive->bad_wstat | DRQ_STAT))) {
+		printk("ide_dmaq_intr: %s: error status %x\n", drive->name, stat);
+		ide_dump_status(drive, "ide_dmaq_intr", stat);
+		ide_tcq_invalidate_queue(drive);
+		return ide_stopped;
+	}
+
+	if (dma_stat)
+		printk("%s: bad DMA status (dma_stat=%x)\n", drive->name, dma_stat);
+
+	TCQ_PRINTK("ide_dmaq_intr: ending %p, tag %d\n", rq, rq->tag);
+	__ide_end_request(drive, rq, !dma_stat, rq->nr_sectors);
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
+ide_startstop_t ide_dmaq_intr(ide_drive_t *drive, struct request *rq)
+{
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
+	struct ata_channel *ch = drive->channel;
+	struct ata_taskfile args;
+	int drives = 0, i;
+
+	/*
+	 * only need to probe if both drives on a channel support tcq
+	 */
+	for (i = 0; i < MAX_DRIVES; i++)
+		if (drive->channel->drives[i].present &&drive->type == ATA_DISK)
+			drives++;
+
+	if (drives <= 1)
+		return 0;
+
+	memset(&args, 0, sizeof(args));
+
+	args.taskfile.feature = 0x01;
+	args.taskfile.command = WIN_NOP;
+	ide_cmd_type_parser(&args);
+
+	/*
+	 * do taskfile and check ABRT bit -- intelligent adapters will not
+	 * pass NOP with sub-code 0x01 to device, so the command will not
+	 * fail there
+	 */
+	ide_raw_taskfile(drive, &args, NULL);
+	if (args.taskfile.feature & ABRT_ERR)
+		return 1;
+
+	ch->auto_poll = 1;
+	printk("%s: NOP Auto-poll enabled\n", ch->name);
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
+	struct ata_taskfile args;
+
+	/*
+	 * bit 14 and 1 must be set in word 83 of the device id to indicate
+	 * support for dma queued protocol, and bit 15 must be cleared
+	 */
+	if ((drive->id->command_set_2 & tcq_bits) ^ tcq_mask)
+		return -EIO;
+
+	memset(&args, 0, sizeof(args));
+	args.taskfile.feature = SETFEATURES_EN_WCACHE;
+	args.taskfile.command = WIN_SETFEATURES;
+	ide_cmd_type_parser(&args);
+
+	if (ide_raw_taskfile(drive, &args, NULL)) {
+		printk("%s: failed to enable write cache\n", drive->name);
+		return 1;
+	}
+
+	/*
+	 * disable RELease interrupt, it's quicker to poll this after
+	 * having sent the command opcode
+	 */
+	memset(&args, 0, sizeof(args));
+	args.taskfile.feature = SETFEATURES_DIS_RI;
+	args.taskfile.command = WIN_SETFEATURES;
+	ide_cmd_type_parser(&args);
+
+	if (ide_raw_taskfile(drive, &args, NULL)) {
+		printk("%s: disabling release interrupt fail\n", drive->name);
+		return 1;
+	}
+
+#ifdef IDE_TCQ_FIDDLE_SI
+	/*
+	 * enable SERVICE interrupt
+	 */
+	memset(&args, 0, sizeof(args));
+	args.taskfile.feature = SETFEATURES_EN_SI;
+	args.taskfile.command = WIN_SETFEATURES;
+	ide_cmd_type_parser(&args);
+
+	if (ide_raw_taskfile(drive, &args, NULL)) {
+		printk("%s: enabling service interrupt fail\n", drive->name);
+		return 1;
+	}
+#endif
+
+	if (!blk_queue_tagged(&drive->queue))
+		blk_queue_init_tags(&drive->queue, IDE_MAX_TAG);
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
+	ide_startstop_t foo;
+
+	if (ide_wait_stat(&foo, drive, READY_STAT | DRQ_STAT, BUSY_STAT, WAIT_READY)) {
+		printk("%s: timeout waiting for data phase\n", drive->name);
+		return 1;
+	}
+
+	return 0;
+}
+
+ide_startstop_t ide_tcq_dmaproc(ide_dma_action_t func, ide_drive_t *drive, struct request *rq)
+{
+	struct ata_channel *hwif = drive->channel;
+	unsigned int reading = 0, enable_tcq = 1;
+	byte stat, feat;
+
+	switch (func) {
+		/*
+		 * invoked from a SERVICE interrupt, command etc already known.
+		 * just need to start the dma engine for this tag
+		 */
+		case ide_dma_queued_start:
+			TCQ_PRINTK("ide_dma: setting up queued %d\n", rq->tag);
+			if (!test_bit(IDE_BUSY, &HWGROUP(drive)->flags))
+				printk("queued_rw: IDE_BUSY not set\n");
+
+			if (ide_tcq_wait_dataphase(drive))
+				return ide_stopped;
+
+			if (ide_start_dma(func, drive))
+				return ide_stopped;
+
+			ide_tcq_set_intr(HWGROUP(drive), ide_dmaq_intr);
+			if (!hwif->udma(ide_dma_begin, drive, rq))
+				return ide_started;
+
+			return ide_stopped;
+
+			/*
+			 * start a queued command from scratch
+			 */
+		case ide_dma_read_queued:
+			reading = 1;
+		case ide_dma_write_queued: {
+			struct ata_taskfile *args = rq->special;
+
+			TCQ_PRINTK("%s: start tag %d\n", drive->name, rq->tag);
+
+			/*
+			 * set nIEN, tag start operation will enable again when
+			 * it is safe
+			 */
+			drive_ctl_nien(drive, 1);
+
+			OUT_BYTE(args->taskfile.command, IDE_COMMAND_REG);
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
+			return hwif->udma(ide_dma_queued_start, drive, rq);
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
diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	Wed May  1 14:36:39 2002
+++ b/drivers/ide/ide.c	Wed May  1 14:36:39 2002
@@ -397,7 +397,10 @@
 
 	if (!end_that_request_first(rq, uptodate, nr_secs)) {
 		add_blkdev_randomness(major(rq->rq_dev));
-		blkdev_dequeue_request(rq);
+		if (!blk_rq_tagged(rq))
+			blkdev_dequeue_request(rq);
+		else
+			blk_queue_end_tag(&drive->queue, rq);
 		HWGROUP(drive)->rq = NULL;
 		end_that_request_last(rq);
 		ret = 0;
@@ -1306,11 +1309,6 @@
 }
 
 
-/* Place holders for later expansion of functionality.
- */
-#define ata_pending_commands(drive)	(0)
-#define ata_can_queue(drive)		(1)
-
 /*
  * Feed commands to a drive until it barfs.  Called with ide_lock/DRIVE_LOCK
  * held and busy channel.
@@ -1351,7 +1349,7 @@
 		 * still a severe BUG!
 		 */
 		if (blk_queue_plugged(&drive->queue)) {
-			BUG();
+			BUG_ON(!drive->using_tcq);
 			break;
 		}
 
@@ -1763,7 +1761,8 @@
 		} else {
 			printk("%s: %s: huh? expected NULL handler on exit\n", drive->name, __FUNCTION__);
 		}
-	}
+	} else if (startstop == ide_released)
+		queue_commands(drive, ch->irq);
 
 out_lock:
 	spin_unlock_irqrestore(&ide_lock, flags);
@@ -3306,6 +3305,9 @@
 
 			drive->channel->udma(ide_dma_off_quietly, drive, NULL);
 			drive->channel->udma(ide_dma_check, drive, NULL);
+#ifdef CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
+			drive->channel->udma(ide_dma_queued_on, drive, NULL);
+#endif
 		}
 
 		/* Only CD-ROMs and tape drives support DSC overlap.  But only
diff -Nru a/drivers/ide/pdc202xx.c b/drivers/ide/pdc202xx.c
--- a/drivers/ide/pdc202xx.c	Wed May  1 14:36:39 2002
+++ b/drivers/ide/pdc202xx.c	Wed May  1 14:36:39 2002
@@ -1057,6 +1057,12 @@
 		case ide_dma_timeout:
 			if (drive->channel->resetproc != NULL)
 				drive->channel->resetproc(drive);
+		/*
+		 * we cannot support queued operations on promise
+		 */
+		case ide_dma_queued_on:
+			return 1;
+
 		default:
 			break;
 	}
diff -Nru a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h	Wed May  1 14:36:39 2002
+++ b/include/linux/ide.h	Wed May  1 14:36:39 2002
@@ -300,6 +300,7 @@
 	u8 tune_req;			/* requested drive tuning setting */
 
 	byte     using_dma;		/* disk is using dma for read/write */
+	byte	 using_tcq;		/* disk is using queueing */
 	byte	 retry_pio;		/* retrying dma capable host in pio */
 	byte	 state;			/* retry state */
 	byte     dsc_overlap;		/* flag: DSC overlap */
@@ -362,9 +363,17 @@
 	byte		dn;		/* now wide spread use */
 	byte		wcache;		/* status of write cache */
 	byte		acoustic;	/* acoustic management */
+	byte		queue_depth;	/* max queue depth */
 	unsigned int	failures;	/* current failure count */
 	unsigned int	max_failures;	/* maximum allowed failure count */
 	struct device	device;		/* global device tree handle */
+	/*
+	 * tcq statistics
+	 */
+	unsigned long	immed_rel;	
+	unsigned long	immed_comp;
+	int		max_last_depth;
+	int		max_depth;
 } ide_drive_t;
 
 /*
@@ -383,7 +392,10 @@
 		ide_dma_off,	ide_dma_off_quietly,	ide_dma_test_irq,
 		ide_dma_bad_drive,			ide_dma_good_drive,
 		ide_dma_verbose,			ide_dma_retune,
-		ide_dma_lostirq,			ide_dma_timeout
+		ide_dma_lostirq,			ide_dma_timeout,
+		ide_dma_read_queued,			ide_dma_write_queued,
+		ide_dma_queued_start,			ide_dma_queued_on,
+		ide_dma_queued_off,
 } ide_dma_action_t;
 
 enum {
@@ -464,6 +476,7 @@
 	unsigned highmem	: 1;	/* can do full 32-bit dma */
 	unsigned no_io_32bit	: 1;	/* disallow enabling 32bit I/O */
 	unsigned no_unmask	: 1;	/* disallow setting unmask bit */
+	unsigned auto_poll	: 1;	/* supports nop auto-poll */
 	byte		io_32bit;	/* 0=16-bit, 1=32-bit, 2/3=32bit+sync */
 	byte		unmask;		/* flag: okay to unmask other irqs */
 	byte		slow;		/* flag: slow data port */
@@ -503,6 +516,29 @@
 #define IDE_SLEEP	1
 #define IDE_DMA		2	/* DMA in progress */
 
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
 typedef struct hwgroup_s {
 	ide_startstop_t (*handler)(struct ata_device *, struct request *);	/* irq handler, if active */
 	unsigned long flags;		/* BUSY, SLEEPING */
@@ -861,9 +897,11 @@
 extern ide_startstop_t ide_dma_intr(struct ata_device *, struct request *);
 int check_drive_lists (ide_drive_t *drive, int good_bad);
 int ide_dmaproc (ide_dma_action_t func, struct ata_device *drive, struct request *);
+ide_startstop_t ide_tcq_dmaproc(ide_dma_action_t func, struct ata_device *drive, struct request *);
 extern void ide_release_dma(struct ata_channel *hwif);
 extern void ide_setup_dma(struct ata_channel *hwif,
 		unsigned long dmabase, unsigned int num_ports) __init;
+extern int ide_start_dma(ide_dma_action_t func, struct ata_device *drive);
 #endif
 
 extern spinlock_t ide_lock;

--hQiwHBbRI9kgIhsi--
