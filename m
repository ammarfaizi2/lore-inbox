Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269942AbTGKNMY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 09:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262290AbTGKNMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 09:12:24 -0400
Received: from fyserv1.fy.chalmers.se ([129.16.110.66]:59358 "EHLO
	fyserv1.fy.chalmers.se") by vger.kernel.org with ESMTP
	id S269942AbTGKNMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 09:12:15 -0400
Message-ID: <3F0EBB05.E90B3DF2@fy.chalmers.se>
Date: Fri, 11 Jul 2003 15:26:29 +0200
From: Andy Polyakov <appro@fy.chalmers.se>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.21-xfs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org, proski@gnu.org
Subject: Re: Regarding drivers/ide/ide-cd.c in 2.5.72
References: <3EEF8E2E.5E14946E@fy.chalmers.se> <20030619122010.GL6445@suse.de> <3EF1C4C8.98300966@fy.chalmers.se> <20030619140735.GU6445@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > ... In the nutshell the problem is that [as it is
> > > > now] every failed SG_IO request is replayed second time without data
> > > > transfer. ... Suggested patch
> > > > overcomes this problem by immediately purging the failed SG_IO request
> > > > from the request queue.
> > >
> > > Patch looks fine, care to resend actually trying to follow the style in
> > > the file in question?
> >
> > Revised to my best ability for follow the coding style of file in
> > question. A:-)
> 
> Much better, thanks :)

And it slipped through again:-( Sharpen up! BTW, the proposed patch
fixes even http://marc.theaimsgroup.com/?t=105634805100001&r=1&w=2,
where induced kernel crash occurs upon packet replay. Applicable to
up to 2.5.75. A.
8<--------8<--------8<--------8<--------8<--------8<--------8<--------
--- ./drivers/ide/ide-cd.c.orig	Tue Jun 17 06:20:00 2003
+++ ./drivers/ide/ide-cd.c	Thu Jun 19 15:56:39 2003
@@ -749,12 +749,17 @@
 		   by transferring the semaphore from the packet
 		   command request to the request sense request. */
 
+		rq->flags |= REQ_FAILED;
 		if ((stat & ERR_STAT) != 0) {
 			wait = rq->waiting;
 			rq->waiting = NULL;
+			if ((rq->flags & REQ_BLOCK_PC) != 0) {
+				cdrom_queue_request_sense(drive, wait,
+							  rq->sense, rq);
+				return 1; /* REQ_BLOCK_PC self-cares */
+			}
 		}
 
-		rq->flags |= REQ_FAILED;
 		cdrom_end_request(drive, 0);
 
 		if ((stat & ERR_STAT) != 0)
@@ -1657,13 +1662,14 @@
 	dma = info->dma;
 	if (dma) {
 		info->dma = 0;
-		if ((dma_error = HWIF(drive)->ide_dma_end(drive))) {
-			printk("ide-cd: dma error\n");
-			HWIF(drive)->ide_dma_off(drive);
-		}
+		dma_error = HWIF(drive)->ide_dma_end(drive);
 	}
 
 	if (cdrom_decode_status(drive, 0, &stat)) {
+		if ((stat & ERR_STAT) != 0) {
+			end_that_request_chunk(rq, 0, rq->data_len);
+			goto end_request; /* purge the whole thing... */
+		}
 		end_that_request_chunk(rq, 1, rq->data_len);
 		return ide_stopped;
 	}
@@ -1672,8 +1678,11 @@
 	 * using dma, transfer is complete now
 	 */
 	if (dma) {
-		if (dma_error)
+		if (dma_error) {
+			printk("ide-cd: dma error\n");
+			HWIF(drive)->ide_dma_off(drive);
 			return DRIVER(drive)->error(drive, "dma error", stat);
+		}
 
 		end_that_request_chunk(rq, 1, rq->data_len);
 		rq->data_len = 0;
