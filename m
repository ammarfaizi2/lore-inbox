Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265877AbUAEEEq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 23:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265883AbUAEEEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 23:04:45 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:14233 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S265877AbUAEEEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 23:04:04 -0500
Date: Mon, 5 Jan 2004 04:52:19 +0100
From: Christophe Saout <christophe@saout.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Possibly wrong BIO usage in ide_multwrite
Message-ID: <20040105035219.GA6393@leto.cs.pocnet.net>
References: <1072977507.4170.14.camel@leto.cs.pocnet.net> <200401020127.50558.bzolnier@elka.pw.edu.pl> <1073013643.20163.51.camel@leto.cs.pocnet.net> <200401032302.32914.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401032302.32914.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartlomiej,

I've been playing with the code a bit.

I simple (but not really cleaner) solution to my original problem that
is minimal invasive is to use an unused field from struct request, in
this case nr_cbio_segments. It actually really counts the remaining
segments, only in rq->bio instead of rq->cbio. (The bio_kmap_irq
in ide_map_buffer prevents us from using anything else than rq->bio to
walk the request).

This segment count is then used to correctly restore the bi_idx fields
before ending requests instead of assuming they were zero.

(Well, I just also see that you could probably drop the scratch buffer
and just copy rq->cbio to rq->bio before ending the request... brrr,
no, that's just too ugly...)

BTW, what was ide_multwrite expected to return? These if clauses in
multwrite_intr are never executed.

Please don't shoot me for this proposal.


--- linux.orig/drivers/ide/ide-disk.c	2004-01-04 23:29:01.000000000 +0100
+++ linux/drivers/ide/ide-disk.c	2004-01-04 23:32:32.000000000 +0100
@@ -279,7 +279,7 @@
 			 * all bvecs in this one.
 			 */
 			if (++bio->bi_idx >= bio->bi_vcnt) {
-				bio->bi_idx = 0;
+				bio->bi_idx = bio->bi_vcnt - bio->nr_cbio_segments;
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
@@ -312,6 +313,7 @@
 	ide_hwgroup_t *hwgroup	= HWGROUP(drive);
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct request *rq	= &hwgroup->wrq;
+	struct bio *bio		= rq->bio;
 	u8 stat;
 
 	stat = hwif->INB(IDE_STATUS_REG);
@@ -322,8 +324,10 @@
 			 *	of the request
 			 */
 			if (rq->nr_sectors) {
-				if (ide_multwrite(drive, drive->mult_count))
+				if (ide_multwrite(drive, drive->mult_count)) {
+					bio->bi_idx = bio->bi_vcnt - bio->nr_cbio_segments;
 					return ide_stopped;
+				}
 				ide_set_handler(drive, &multwrite_intr, WAIT_CMD, NULL);
 				return ide_started;
 			}
@@ -333,6 +337,7 @@
 			 *	we can end the original request.
 			 */
 			if (!rq->nr_sectors) {	/* all done? */
+				bio->bi_idx = bio->bi_vcnt - bio->nr_cbio_segments;
 				rq = hwgroup->rq;
 				ide_end_request(drive, 1, rq->nr_sectors);
 				return ide_stopped;

