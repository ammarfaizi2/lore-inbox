Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262003AbUEWKEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbUEWKEX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 06:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbUEWKEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 06:04:23 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:45995 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262003AbUEWKEF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 06:04:05 -0400
Date: Sun, 23 May 2004 12:03:49 +0200
From: Jens Axboe <axboe@suse.de>
To: Lorenzo Allegrucci <l_allegrucci@despammed.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm5 oops mounting ext3 or reiserfs with -o barrier
Message-ID: <20040523100348.GJ1952@suse.de>
References: <200405222107.55505.l_allegrucci@despammed.com> <20040522212028.GA31188@suse.de> <20040522213018.GA31224@suse.de> <200405231058.03336.l_allegrucci@despammed.com> <20040523091137.GB5415@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040523091137.GB5415@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23 2004, Jens Axboe wrote:
> On Sun, May 23 2004, Lorenzo Allegrucci wrote:
> > On Saturday 22 May 2004 23:30, Jens Axboe wrote:
> > > On Sat, May 22 2004, Jens Axboe wrote:
> > > > On Sat, May 22 2004, Andrew Morton wrote:
> > > > > Lorenzo Allegrucci <l_allegrucci@despammed.com> wrote:
> > > > > > I get a 100% reproducible oops mounting an ext3 or reiserfs
> > > > > > partition with -o barrier enabled.
> > > > > > Hand written oops (for ext3):
> > > > >
> > > > > That's a lot of hand-writing.  Thanks for doing that.  You can usually
> > > > > omit the hex numbers in [brackets] when doing this.
> > > > >
> > > > > The crash is here:
> > > > >
> > > > > static inline void blkdev_dequeue_request(struct request *req)
> > > > > {
> > > > > 	BUG_ON(list_empty(&req->queuelist));
> > > > >
> > > > > perhaps related to that I/O error sending the code through less-tested
> > > > > paths.
> > > >
> > > > Ouch indeed, I'll get that fixed up first thing in the morning.
> > >
> > > Can you test this work-around? The work-around should be perfectly safe,
> > > this is just a case where a BUG_ON() does more harm than good :-)
> > >
> > > --- drivers/ide/ide-io.c~	2004-05-21 11:02:58.000000000 +0200
> > > +++ drivers/ide/ide-io.c	2004-05-22 23:28:37.692944185 +0200
> > > @@ -291,6 +291,8 @@
> > >  		sector = real_rq->hard_sector;
> > >
> > >  	bad_sectors = real_rq->hard_nr_sectors - good_sectors;
> > > +	/* work-around, make sure request is on queue */
> > > +	elv_requeue_request(drive->queue, real_rq);
> > >  	if (good_sectors)
> > >  		__ide_end_request(drive, real_rq, 1, good_sectors);
> > >  	if (bad_sectors)
> > 
> > The oops goes away but:
> > 
> > hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> > hda: drive_cmd: error=0x04 { DriveStatusError }
> > end_request: I/O error, dev hda, sector 84667085
> > Buffer I/O error on device hda11, logical block 559
> > lost page write due to I/O error on hda11
> > hda: failed barrier write: sector=50beacd(good=0/bad=8)
> > Aborting journal on device hda11.
> > ext3_abort called.
> > EXT3-fs abort (device hda11): ext3_journal_start: Detected aborted journal
> > Remounting filesystem read-only
> 
> That's expected with that patch. Try the one I just sent you as well.
> ext3 doesn't recover nicely though, I'll see if I can find a way to pass
> back -EOPNOTSUPP in case of ABRT in completer_barrier().

Here's a rolled up updated version that tries to get async notification
of missing barrier support working as well. reiser currently doesn't
cope with that correctly (fails mount), ext3 seems to but gets stuck.
Andrew has that fixed already, I think :-)

Lorenzo, can you test this on top of 2.6.6-mm5?

diff -urp -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.6-mm5/drivers/block/ll_rw_blk.c linux-2.6.6-mm5/drivers/block/ll_rw_blk.c
--- /opt/kernel/linux-2.6.6-mm5/drivers/block/ll_rw_blk.c	2004-05-23 09:56:19.000000000 +0200
+++ linux-2.6.6-mm5/drivers/block/ll_rw_blk.c	2004-05-23 11:29:57.774204303 +0200
@@ -2706,10 +2706,17 @@ void blk_recalc_rq_sectors(struct reques
 static int __end_that_request_first(struct request *req, int uptodate,
 				    int nr_bytes)
 {
-	int total_bytes, bio_nbytes, error = 0, next_idx = 0;
+	int total_bytes, bio_nbytes, error, next_idx = 0;
 	struct bio *bio;
 
 	/*
+	 * extend uptodate bool to allow < 0 value to be direct io error
+	 */
+	error = 0;
+	if (end_io_error(uptodate))
+		error = !uptodate ? -EIO : uptodate;
+
+	/*
 	 * for a REQ_BLOCK_PC request, we want to carry any eventual
 	 * sense key with us all the way through
 	 */
@@ -2717,7 +2724,6 @@ static int __end_that_request_first(stru
 		req->errors = 0;
 
 	if (!uptodate) {
-		error = -EIO;
 		if (blk_fs_request(req) && !(req->flags & REQ_QUIET))
 			printk("end_request: I/O error, dev %s, sector %llu\n",
 				req->rq_disk ? req->rq_disk->disk_name : "?",
@@ -2800,7 +2806,7 @@ static int __end_that_request_first(stru
 /**
  * end_that_request_first - end I/O on a request
  * @req:      the request being processed
- * @uptodate: 0 for I/O error
+ * @uptodate: 1 for success, 0 for I/O error, < 0 for specific error
  * @nr_sectors: number of sectors to end I/O on
  *
  * Description:
@@ -2821,7 +2827,7 @@ EXPORT_SYMBOL(end_that_request_first);
 /**
  * end_that_request_chunk - end I/O on a request
  * @req:      the request being processed
- * @uptodate: 0 for I/O error
+ * @uptodate: 1 for success, 0 for I/O error, < 0 for specific error
  * @nr_bytes: number of bytes to complete
  *
  * Description:
diff -urp -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.6-mm5/drivers/ide/ide-disk.c linux-2.6.6-mm5/drivers/ide/ide-disk.c
--- /opt/kernel/linux-2.6.6-mm5/drivers/ide/ide-disk.c	2004-05-23 09:56:20.000000000 +0200
+++ linux-2.6.6-mm5/drivers/ide/ide-disk.c	2004-05-23 11:48:51.095716239 +0200
@@ -1392,13 +1392,6 @@ static int set_nowerr(ide_drive_t *drive
 	return 0;
 }
 
-/* check if CACHE FLUSH (EXT) command is supported (bits defined in ATA-6) */
-#define ide_id_has_flush_cache(id)	((id)->cfs_enable_2 & 0x3000)
-
-/* some Maxtor disks have bit 13 defined incorrectly so check bit 10 too */
-#define ide_id_has_flush_cache_ext(id)	\
-	(((id)->cfs_enable_2 & 0x2400) == 0x2400)
-
 static int write_cache (ide_drive_t *drive, int arg)
 {
 	ide_task_t args;
@@ -1597,6 +1590,7 @@ static void idedisk_setup (ide_drive_t *
 {
 	struct hd_driveid *id = drive->id;
 	unsigned long long capacity;
+	int barrier = 0;
 
 	idedisk_add_settings(drive);
 
@@ -1729,8 +1723,32 @@ static void idedisk_setup (ide_drive_t *
 
 	write_cache(drive, 1);
 
-	blk_queue_ordered(drive->queue, 1);
-	blk_queue_issue_flush_fn(drive->queue, idedisk_issue_flush);
+	/*
+	 * decide if we can sanely support flushes and barriers on
+	 * this drive. if we have FLUSH_CACHE_EXT, it's always safe.
+	 * if not, it's only safe if drive has FLUSH_CACHE, and:
+	 *	- capacity is less than required for LBA48
+	 *	- doesn't use LBA48
+	 */
+	if (ide_id_has_flush_cache_ext(id))
+		barrier = 1;
+	else {
+		if (drive->addressing == 1) {
+			if (capacity <= (1ULL << 28))
+				barrier = 1;
+			else
+				printk("%s: drive is buggy, no support for FLUSH_CACHE_EXT with lba48\n", drive->name);
+		} else {
+			if (ide_id_has_flush_cache(id))
+				barrier = 1;
+		}
+	}
+			barrier = 1;
+	printk("%s: cache flushes %ssupported\n", drive->name, barrier ? "" : "not ");
+	if (barrier) {
+		blk_queue_ordered(drive->queue, 1);
+		blk_queue_issue_flush_fn(drive->queue, idedisk_issue_flush);
+	}
 
 #ifdef CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
 	if (drive->using_dma)
diff -urp -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.6-mm5/drivers/ide/ide-io.c linux-2.6.6-mm5/drivers/ide/ide-io.c
--- /opt/kernel/linux-2.6.6-mm5/drivers/ide/ide-io.c	2004-05-23 09:56:20.000000000 +0200
+++ linux-2.6.6-mm5/drivers/ide/ide-io.c	2004-05-23 12:00:13.150994698 +0200
@@ -67,7 +67,7 @@ static void ide_fill_flush_cmd(ide_drive
 	rq->buffer = buf;
 	rq->buffer[0] = WIN_FLUSH_CACHE;
 
-	if (drive->id->cfs_enable_2 & 0x2400)
+	if (ide_id_has_flush_cache_ext(drive->id))
 		rq->buffer[0] = WIN_FLUSH_CACHE_EXT;
 }
 
@@ -115,10 +115,10 @@ static int __ide_end_request(ide_drive_t
 	 * if failfast is set on a request, override number of sectors and
 	 * complete the whole request right now
 	 */
-	if (blk_noretry_request(rq) && !uptodate)
+	if (blk_noretry_request(rq) && end_io_error(uptodate))
 		nr_sectors = rq->hard_nr_sectors;
 
-	if (!blk_fs_request(rq) && !uptodate && !rq->errors)
+	if (!blk_fs_request(rq) && end_io_error(uptodate) && !rq->errors)
 		rq->errors = -EIO;
 
 	/*
@@ -229,7 +229,7 @@ u64 ide_get_error_location(ide_drive_t *
 	lcyl = args[4];
 	sect = args[3];
 
-	if (drive->id->cfs_enable_2 & 0x2400) {
+	if (ide_id_has_flush_cache_ext(drive->id)) {
 		low = (hcyl << 16) | (lcyl << 8) | sect;
 		HWIF(drive)->OUTB(drive->ctl|0x80, IDE_CONTROL_REG);
 		high = ide_read_24(drive);
@@ -277,32 +277,48 @@ static void ide_complete_barrier(ide_dri
 	}
 
 	/*
-	 * bummer, flush failed. if it was the pre-flush, fail the barrier.
-	 * if it was the post-flush, complete the succesful part of the request
-	 * and fail the rest
+	 * we need to end real_rq, but it's not on the queue currently.
+	 * put it back on the queue, so we don't have to special case
+	 * anything else for completing it
 	 */
-	good_sectors = 0;
-	if (blk_barrier_postflush(rq)) {
-		sector = ide_get_error_location(drive, rq->buffer);
-
-		if ((sector >= real_rq->hard_sector) &&
-		    (sector < real_rq->hard_sector + real_rq->hard_nr_sectors))
-			good_sectors = sector - real_rq->hard_sector;
-	} else
-		sector = real_rq->hard_sector;
+	elv_requeue_request(drive->queue, real_rq);
+	
+	/*
+	 * drive aborted flush command, assume FLUSH_CACHE_* doesn't
+	 * work and disable barrier support
+	 */
+	if (error & ABRT_ERR) {
+		printk(KERN_ERR "%s: barrier support doesn't work\n", drive->name);
+		__ide_end_request(drive, real_rq, -EOPNOTSUPP, real_rq->hard_nr_sectors);
+		blk_queue_ordered(drive->queue, 0);
+		blk_queue_issue_flush_fn(drive->queue, NULL);
+	} else {
+		/*
+		 * find out what part of the request failed
+		 */
+		good_sectors = 0;
+		if (blk_barrier_postflush(rq)) {
+			sector = ide_get_error_location(drive, rq->buffer);
 
-	bad_sectors = real_rq->hard_nr_sectors - good_sectors;
-	if (good_sectors)
-		__ide_end_request(drive, real_rq, 1, good_sectors);
-	if (bad_sectors)
-		__ide_end_request(drive, real_rq, 0, bad_sectors);
+			if ((sector >= real_rq->hard_sector) &&
+			    (sector < real_rq->hard_sector + real_rq->hard_nr_sectors))
+				good_sectors = sector - real_rq->hard_sector;
+		} else
+			sector = real_rq->hard_sector;
+
+		bad_sectors = real_rq->hard_nr_sectors - good_sectors;
+		if (good_sectors)
+			__ide_end_request(drive, real_rq, 1, good_sectors);
+		if (bad_sectors)
+			__ide_end_request(drive, real_rq, 0, bad_sectors);
+
+		printk(KERN_ERR "%s: failed barrier write: "
+				"sector=%Lx(good=%d/bad=%d)\n",
+				drive->name, (unsigned long long)sector,
+				good_sectors, bad_sectors);
+	}
 
 	drive->doing_barrier = 0;
-
-	printk(KERN_ERR "%s: failed barrier write: "
-			"sector=%Lx(good=%d/bad=%d)\n",
-			drive->name, (unsigned long long)sector,
-			good_sectors, bad_sectors);
 }
 
 /**
diff -urp -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.6-mm5/include/linux/blkdev.h linux-2.6.6-mm5/include/linux/blkdev.h
--- /opt/kernel/linux-2.6.6-mm5/include/linux/blkdev.h	2004-05-23 09:56:21.000000000 +0200
+++ linux-2.6.6-mm5/include/linux/blkdev.h	2004-05-23 11:57:30.227604989 +0200
@@ -571,6 +571,14 @@ extern void end_that_request_last(struct
 extern int process_that_request_first(struct request *, unsigned int);
 extern void end_request(struct request *req, int uptodate);
 
+/*
+ * end_that_request_first/chunk() takes an uptodate argument. we account
+ * any value <= as an io error. 0 means -EIO for compatability reasons,
+ * any other < 0 value is the direct error type. An uptodate value of
+ * 1 indicates successful io completion
+ */
+#define end_io_error(uptodate)	(unlikely((uptodate) <= 0))
+
 static inline void blkdev_dequeue_request(struct request *req)
 {
 	BUG_ON(list_empty(&req->queuelist));
diff -urp -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.6-mm5/include/linux/ide.h linux-2.6.6-mm5/include/linux/ide.h
--- /opt/kernel/linux-2.6.6-mm5/include/linux/ide.h	2004-05-23 09:56:21.000000000 +0200
+++ linux-2.6.6-mm5/include/linux/ide.h	2004-05-23 10:09:21.313967868 +0200
@@ -1716,4 +1716,11 @@ static inline int ata_can_queue(ide_driv
 
 extern struct bus_type ide_bus_type;
 
+/* check if CACHE FLUSH (EXT) command is supported (bits defined in ATA-6) */
+#define ide_id_has_flush_cache(id)	((id)->cfs_enable_2 & 0x3000)
+
+/* some Maxtor disks have bit 13 defined incorrectly so check bit 10 too */
+#define ide_id_has_flush_cache_ext(id)	\
+	(((id)->cfs_enable_2 & 0x2400) == 0x2400)
+
 #endif /* _IDE_H */

-- 
Jens Axboe

