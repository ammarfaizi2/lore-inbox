Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265998AbUAEXB3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 18:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265994AbUAEXB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 18:01:28 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:17105 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S265998AbUAEXAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 18:00:09 -0500
Date: Mon, 5 Jan 2004 23:51:17 +0100
From: Christophe Saout <christophe@saout.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Possibly wrong BIO usage in ide_multwrite
Message-ID: <20040105225117.GA5841@leto.cs.pocnet.net>
References: <1072977507.4170.14.camel@leto.cs.pocnet.net> <200401032302.32914.bzolnier@elka.pw.edu.pl> <20040105035219.GA6393@leto.cs.pocnet.net> <200401051808.49010.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401051808.49010.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 06:08:49PM +0100, Bartlomiej Zolnierkiewicz wrote:

> On Monday 05 of January 2004 04:52, Christophe Saout wrote:
> 
> > BTW, what was ide_multwrite expected to return? These if clauses in
> > multwrite_intr are never executed.
> 
> Dunno.  It can't fail so it should be made void.

Ok, done.

> Please also add bio->bi_idx restoring for failed requests.
> Put it before DRIVER(drive)->error()

Whoops, overlooked this one. Right.

> (and remember about if (bio) check).

Remember? Can bio be NULL somewhere? Or what do you mean? It's our
scratchpad and ide_multwrite never puts a NULL bio on it.

> Otherwise I patch is OK for me.

Ok, take two.

I also did legacy/pdc4030.c, it's more or less the same though I'm not
able to test it.


--- linux.orig/drivers/ide/ide-disk.c	2004-01-04 23:29:01.000000000 +0100
+++ linux/drivers/ide/ide-disk.c	2004-01-05 23:35:35.258199832 +0100
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
 		/* the original code did this here (?) */
+		bio->bi_idx = bio->bi_vcnt - rq->nr_cbio_segments;
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
--- linux.orig/drivers/ide/legacy/pdc4030.c	2004-01-05 20:34:29.000000000 +0100
+++ linux/drivers/ide/legacy/pdc4030.c	2004-01-05 23:34:41.895312224 +0100
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

