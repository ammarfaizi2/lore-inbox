Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264522AbUAFRM2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 12:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264536AbUAFRM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 12:12:28 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:38047 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S264522AbUAFRMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 12:12:07 -0500
Date: Tue, 6 Jan 2004 18:11:56 +0100
From: Christophe Saout <christophe@saout.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: [PATCH] clarify meaning of bio fields in the end_io function
Message-ID: <20040106171156.GA6355@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

so here are the (hopefully) final version of the patches I've discusses
on LKML the last days.

The intent of these are to clarify the meaning of the bio fields in the
bi_end_io function (since we are already mostly there). After these
small modifications bio->bi_idx and the corresponding
bio_iovec(bio)->bv_offset point to the beginning of the completed data,
together with the nr_bytes argument you know exactly what data was
finished, e.g. when you can't track it otherwise (or it would be
unnecessary expensive). Apart from that it's a nice-to-have.

The first mini-patch moves the update of bio_iovec(bio)->bv_offset and
->bv_len after the call of bi_end_io where bi_idx gets updated so they
get updated together. Ok with Jens.

The second part of the patch modifies the multwrite hack in PIO non-
taskfile ide disk code. It modifies the bi_idx field to walk the bios
and doesn't reset it correctly before ending the request. The patch
uses the segment counter in the request field to correctly restore
the bi_idx field before ending the request. Can't possibly break
anything since it's working on the local request copy ("scratchpad")
anyway. Also does this in legacy/pdc4030.c (similar code).
The code modified here is going to die anyway any trying to fix it
would be too invasive. Ok with Bartlomiej.


--- linux-2.6.1-rc1-mm2.orig/drivers/block/ll_rw_blk.c	2004-01-06 17:38:25.784124520 +0100
+++ linux-2.6.1-rc1-mm2/drivers/block/ll_rw_blk.c	2004-01-06 17:38:56.911392456 +0100
@@ -2528,8 +2528,6 @@
 			 * not a complete bvec done
 			 */
 			if (unlikely(nbytes > nr_bytes)) {
-				bio_iovec_idx(bio, idx)->bv_offset += nr_bytes;
-				bio_iovec_idx(bio, idx)->bv_len -= nr_bytes;
 				bio_nbytes += nr_bytes;
 				total_bytes += nr_bytes;
 				break;
@@ -2565,7 +2563,9 @@
 	 */
 	if (bio_nbytes) {
 		bio_endio(bio, bio_nbytes, error);
-		req->bio->bi_idx += next_idx;
+		bio->bi_idx += next_idx;
+		bio_iovec(bio)->bv_offset += nr_bytes;
+		bio_iovec(bio)->bv_len -= nr_bytes;
 	}
 
 	blk_recalc_rq_sectors(req, total_bytes >> 9);
--- linux-2.6.1-rc1-mm2.orig/drivers/ide/ide-disk.c	2004-01-06 17:38:26.088078312 +0100
+++ linux-2.6.1-rc1-mm2/drivers/ide/ide-disk.c	2004-01-06 17:38:57.249341080 +0100
@@ -251,7 +251,7 @@
  * is shorter or smaller than the BH segment then we should be OKAY.
  * This is only valid if we can rewind the rq->current_nr_sectors counter.
  */
-int ide_multwrite (ide_drive_t *drive, unsigned int mcount)
+void ide_multwrite (ide_drive_t *drive, unsigned int mcount)
 {
  	ide_hwgroup_t *hwgroup	= HWGROUP(drive);
  	struct request *rq	= &hwgroup->wrq;
@@ -279,7 +279,7 @@
 			 * all bvecs in this one.
 			 */
 			if (++bio->bi_idx >= bio->bi_vcnt) {
-				bio->bi_idx = 0;
+				bio->bi_idx = bio->bi_vcnt - rq->nr_cbio_segments;
 				bio = bio->bi_next;
 			}
 
@@ -288,7 +288,8 @@
 				mcount = 0;
 			} else {
 				rq->bio = bio;
-				rq->current_nr_sectors = bio_iovec(bio)->bv_len >> 9;
+				rq->nr_cbio_segments = bio_segments(bio);
+				rq->current_nr_sectors = bio_cur_sectors(bio);
 				rq->hard_cur_sectors = rq->current_nr_sectors;
 			}
 		}
@@ -300,8 +301,6 @@
 		taskfile_output_data(drive, buffer, nsect<<7);
 		ide_unmap_buffer(rq, buffer, &flags);
 	} while (mcount);
-
-        return 0;
 }
 
 /*
@@ -312,6 +311,7 @@
 	ide_hwgroup_t *hwgroup	= HWGROUP(drive);
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct request *rq	= &hwgroup->wrq;
+	struct bio *bio		= rq->bio;
 	u8 stat;
 
 	stat = hwif->INB(IDE_STATUS_REG);
@@ -322,8 +322,7 @@
 			 *	of the request
 			 */
 			if (rq->nr_sectors) {
-				if (ide_multwrite(drive, drive->mult_count))
-					return ide_stopped;
+				ide_multwrite(drive, drive->mult_count);
 				ide_set_handler(drive, &multwrite_intr, WAIT_CMD, NULL);
 				return ide_started;
 			}
@@ -333,14 +332,17 @@
 			 *	we can end the original request.
 			 */
 			if (!rq->nr_sectors) {	/* all done? */
+				bio->bi_idx = bio->bi_vcnt - rq->nr_cbio_segments;
 				rq = hwgroup->rq;
 				ide_end_request(drive, 1, rq->nr_sectors);
 				return ide_stopped;
 			}
 		}
+		bio->bi_idx = bio->bi_vcnt - rq->nr_cbio_segments;
 		/* the original code did this here (?) */
 		return ide_stopped;
 	}
+	bio->bi_idx = bio->bi_vcnt - rq->nr_cbio_segments;
 	return DRIVER(drive)->error(drive, "multwrite_intr", stat);
 }
 
@@ -519,14 +521,7 @@
 	 */
 			hwgroup->wrq = *rq; /* scratchpad */
 			ide_set_handler(drive, &multwrite_intr, WAIT_CMD, NULL);
-			if (ide_multwrite(drive, drive->mult_count)) {
-				unsigned long flags;
-				spin_lock_irqsave(&ide_lock, flags);
-				hwgroup->handler = NULL;
-				del_timer(&hwgroup->timer);
-				spin_unlock_irqrestore(&ide_lock, flags);
-				return ide_stopped;
-			}
+			ide_multwrite(drive, drive->mult_count);
 		} else {
 			unsigned long flags;
 			char *to = ide_map_buffer(rq, &flags);
--- linux-2.6.1-rc1-mm2.orig/drivers/ide/legacy/pdc4030.c	2004-01-05 20:34:29.000000000 +0100
+++ linux-2.6.1-rc1-mm2/drivers/ide/legacy/pdc4030.c	2004-01-05 23:34:41.000000000 +0100
@@ -443,7 +443,12 @@
 static ide_startstop_t promise_complete_pollfunc(ide_drive_t *drive)
 {
 	ide_hwgroup_t *hwgroup = HWGROUP(drive);
+#ifdef CONFIG_IDE_TASKFILE_IO
 	struct request *rq = hwgroup->rq;
+#else
+	struct request *rq = &hwgroup->wrq;
+	struct bio *bio = rq->bio;
+#endif
 
 	if ((HWIF(drive)->INB(IDE_STATUS_REG)) & BUSY_STAT) {
 		if (time_before(jiffies, hwgroup->poll_timeout)) {
@@ -472,6 +477,8 @@
 	while (rq->bio != rq->cbio)
 		(void) DRIVER(drive)->end_request(drive, 1, bio_sectors(rq->bio));
 #else
+	bio->bi_idx = bio->bi_vcnt - rq->nr_cbio_segments;
+	rq = hwgroup->rq;
 	DRIVER(drive)->end_request(drive, 1, rq->hard_nr_sectors);
 #endif
 	return ide_stopped;
@@ -530,7 +537,7 @@
 			 * all bvecs in this one.
 			 */
 			if (++bio->bi_idx >= bio->bi_vcnt) {
-				bio->bi_idx = 0;
+				bio->bi_idx = bio->bi_vcnt - rq->nr_cbio_segments;
 				bio = bio->bi_next;
 			}
 
@@ -539,7 +546,8 @@
 				mcount = 0;
 			} else {
 				rq->bio = bio;
-				rq->current_nr_sectors = bio_iovec(bio)->bv_len >> 9;
+				rq->nr_cbio_segments = bio_segments(bio);
+				rq->current_nr_sectors = bio_cur_sectors(bio);
 				rq->hard_cur_sectors = rq->current_nr_sectors;
 			}
 		}
@@ -561,6 +569,9 @@
 	ide_hwgroup_t *hwgroup = HWGROUP(drive);
 #ifdef CONFIG_IDE_TASKFILE_IO
 	struct request *rq = hwgroup->rq;
+#else
+	struct request *rq = &hwgroup->wrq;
+	struct bio *bio = rq->bio;
 #endif
 
 	if (HWIF(drive)->INB(IDE_NSECTOR_REG) != 0) {
@@ -575,6 +586,9 @@
 		}
 		hwgroup->poll_timeout = 0;
 		printk(KERN_ERR "%s: write timed-out!\n",drive->name);
+#ifndef CONFIG_IDE_TASKFILE_IO
+		bio->bi_idx = bio->bi_vcnt - rq->nr_cbio_segments;
+#endif
 		return DRIVER(drive)->error(drive, "write timeout",
 				HWIF(drive)->INB(IDE_STATUS_REG));
 	}

