Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265876AbUAEEEc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 23:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265882AbUAEEEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 23:04:31 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:13977 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S265876AbUAEEEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 23:04:02 -0500
Date: Mon, 5 Jan 2004 05:03:37 +0100
From: Christophe Saout <christophe@saout.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Possibly wrong BIO usage in ide_multwrite
Message-ID: <20040105040337.GB6393@leto.cs.pocnet.net>
References: <1072977507.4170.14.camel@leto.cs.pocnet.net> <200401020127.50558.bzolnier@elka.pw.edu.pl> <1073013643.20163.51.camel@leto.cs.pocnet.net> <200401032302.32914.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401032302.32914.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

here another experiment.

I have started moving the code over to using the cbio mechanism. I
have only touched ide-disk.c though, I'm not sure about ide-taskfile.c.

So basically I've replaced bio_kmap_irq with rq_map_buffer in
ide_map_buffer and changed the manual rq->current_nr_sectors/nr_sectors
fiddling with process_that_request_first. I can then recognize whether
a bio border has been crossed if rq->cbio differs from rq->bio since
the rq->current_nr_sectors already might refer to the next bio and won't
drop to zero.

The modifications work here with and without multmode and with all kinds
of bios. Haven't been able to test error conditions since I don't have
broken hardware. ;-)

I also didn't touch ide-taskfile.c which has most probably also been
broken by the ide_map_buffer change. And I stumbled across the code
calling end_request with a null sector count, ide_end_request will then
take hard_nr_sectors which will end the whole request even if only one
bio was finished, huh? Am I missing something here?

And when is bio == NULL in ide_map_buffer? Where can this happen?


bio to cbio
--- linux.orig/drivers/ide/ide-disk.c	2004-01-04 23:43:59.000000000 +0100
+++ linux/drivers/ide/ide-disk.c	2004-01-05 04:17:25.522691784 +0100
@@ -172,11 +172,11 @@
 		(unsigned long) rq->buffer+(nsect<<9), rq->nr_sectors-nsect);
 #endif
 	ide_unmap_buffer(rq, to, &flags);
-	rq->sector += nsect;
+	process_that_request_first(rq, nsect);
 	rq->errors = 0;
-	i = (rq->nr_sectors -= nsect);
-	if (((long)(rq->current_nr_sectors -= nsect)) <= 0)
-		ide_end_request(drive, 1, rq->hard_cur_sectors);
+	i = rq->nr_sectors;
+	if (rq->bio != rq->cbio)
+		ide_end_request(drive, 1, bio_sectors(rq->bio));
 	/*
 	 * Another BH Page walker and DATA INTEGRITY Questioned on ERROR.
 	 * If passed back up on multimode read, BAD DATA could be ACKED
@@ -195,7 +195,7 @@
  * write_intr() is the handler for disk write interrupts
  */
 static ide_startstop_t write_intr (ide_drive_t *drive)
-{
+{ 
 	ide_hwgroup_t *hwgroup	= HWGROUP(drive);
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct request *rq	= hwgroup->rq;
@@ -213,12 +213,11 @@
 			rq->nr_sectors-1);
 #endif
 		if ((rq->nr_sectors == 1) ^ ((stat & DRQ_STAT) != 0)) {
-			rq->sector++;
+			process_that_request_first(rq, 1);
 			rq->errors = 0;
-			i = --rq->nr_sectors;
-			--rq->current_nr_sectors;
-			if (((long)rq->current_nr_sectors) <= 0)
-				ide_end_request(drive, 1, rq->hard_cur_sectors);
+			i = rq->nr_sectors;
+			if (rq->bio != rq->cbio)
+				ide_end_request(drive, 1, bio_sectors(rq->bio));
 			if (i > 0) {
 				unsigned long flags;
 				char *to = ide_map_buffer(rq, &flags);
@@ -245,53 +244,25 @@
  * and IRQ context. The IRQ can happen any time after we've output the
  * full "mcount" number of sectors, so we must make sure we update the
  * state _before_ we output the final part of the data!
- *
- * The update and return to BH is a BLOCK Layer Fakey to get more data
- * to satisfy the hardware atomic segment.  If the hardware atomic segment
- * is shorter or smaller than the BH segment then we should be OKAY.
- * This is only valid if we can rewind the rq->current_nr_sectors counter.
  */
 int ide_multwrite (ide_drive_t *drive, unsigned int mcount)
 {
  	ide_hwgroup_t *hwgroup	= HWGROUP(drive);
- 	struct request *rq	= &hwgroup->wrq;
+ 	struct request *rq	= hwgroup->rq;
 
   	do {
   		char *buffer;
-  		int nsect = rq->current_nr_sectors;
 		unsigned long flags;
+  		int nsect = rq->current_nr_sectors;
  
 		if (nsect > mcount)
 			nsect = mcount;
 		mcount -= nsect;
 		buffer = ide_map_buffer(rq, &flags);
 
-		rq->sector += nsect;
-		rq->nr_sectors -= nsect;
-		rq->current_nr_sectors -= nsect;
-
-		/* Do we move to the next bh after this? */
-		if (!rq->current_nr_sectors) {
-			struct bio *bio = rq->bio;
-
-			/*
-			 * only move to next bio, when we have processed
-			 * all bvecs in this one.
-			 */
-			if (++bio->bi_idx >= bio->bi_vcnt) {
-				bio->bi_idx = 0;
-				bio = bio->bi_next;
-			}
-
-			/* end early early we ran out of requests */
-			if (!bio) {
-				mcount = 0;
-			} else {
-				rq->bio = bio;
-				rq->current_nr_sectors = bio_iovec(bio)->bv_len >> 9;
-				rq->hard_cur_sectors = rq->current_nr_sectors;
-			}
-		}
+		process_that_request_first(rq, nsect);
+		if (!rq->cbio)
+			mcount = 0;
 
 		/*
 		 * Ok, we're all setup for the interrupt
@@ -311,7 +282,7 @@
 {
 	ide_hwgroup_t *hwgroup	= HWGROUP(drive);
 	ide_hwif_t *hwif	= HWIF(drive);
-	struct request *rq	= &hwgroup->wrq;
+	struct request *rq	= hwgroup->rq;
 	u8 stat;
 
 	stat = hwif->INB(IDE_STATUS_REG);
@@ -333,12 +304,11 @@
 			 *	we can end the original request.
 			 */
 			if (!rq->nr_sectors) {	/* all done? */
-				rq = hwgroup->rq;
-				ide_end_request(drive, 1, rq->nr_sectors);
+				ide_end_request(drive, 1, rq->hard_nr_sectors);
 				return ide_stopped;
 			}
 		}
-		/* the original code did this here (?) */
+	 	/* the original code did this here (?) */
 		return ide_stopped;
 	}
 	return DRIVER(drive)->error(drive, "multwrite_intr", stat);
@@ -517,7 +487,9 @@
 	 *
 	 * MAJOR DATA INTEGRITY BUG !!! only if we error 
 	 */
+#if 0
 			hwgroup->wrq = *rq; /* scratchpad */
+#endif
 			ide_set_handler(drive, &multwrite_intr, WAIT_CMD, NULL);
 			if (ide_multwrite(drive, drive->mult_count)) {
 				unsigned long flags;
--- linux.orig/include/linux/ide.h	2004-01-04 23:43:59.000000000 +0100
+++ linux/include/linux/ide.h	2004-01-05 04:17:38.287751200 +0100
@@ -835,7 +835,7 @@
 	 * fs request
 	 */
 	if (rq->bio)
-		return bio_kmap_irq(rq->bio, flags) + ide_rq_offset(rq);
+		return rq_map_buffer(rq, flags);
 
 	/*
 	 * task request
@@ -846,7 +846,7 @@
 static inline void ide_unmap_buffer(struct request *rq, char *buffer, unsigned long *flags)
 {
 	if (rq->bio)
-		bio_kunmap_irq(buffer, flags);
+		rq_unmap_buffer(buffer, flags);
 }
 #endif /* !CONFIG_IDE_TASKFILE_IO */
 
@@ -1057,8 +1057,10 @@
 	struct request *rq;
 		/* failsafe timer */
 	struct timer_list timer;
+#if 0
 		/* local copy of current write rq */
 	struct request wrq;
+#endif
 		/* timeout value during long polls */
 	unsigned long poll_timeout;
 		/* queried upon timeouts */
