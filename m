Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265141AbTFEUww (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 16:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265125AbTFEUvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 16:51:52 -0400
Received: from fyserv1.fy.chalmers.se ([129.16.110.66]:46511 "EHLO
	fyserv1.fy.chalmers.se") by vger.kernel.org with ESMTP
	id S265141AbTFEUvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 16:51:10 -0400
Message-ID: <3EDFB07D.75892CC8@fy.chalmers.se>
Date: Thu, 05 Jun 2003 23:05:01 +0200
From: Andy Polyakov <appro@fy.chalmers.se>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.20-xfs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Jens Axboe <axboe@suse.de>
Subject: Re: 2.5.69-70 ide-cd to guarantee fault-free CD/DVD burning experience?
References: <3ED4681A.738DA3C6@fy.chalmers.se> <3EDE4B96.21DBA04B@fy.chalmers.se> <20030604195546.GB477@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > ... accept ... patch which makes it possible to access the
> > > sense data returned by IDE CD/DVD units from user-land with SG_IO ioctl.
> >
> > ... [another] problem discussed here is not specific to DVD-RW
> > recordings. It's generic bug/deficiency. Once a packet commands is
> > terminated with an error condition the whole bio should be purged at
> > once and not only the first chunk as it's currently implemented.
> 
> The *sector* values don't really work well for REQ_BLOCK_PC, ...
> ... a nicer one is probably to make cdrom_end_request return
> ide_end_request ret value, and simply make the error locations kill the
> requests... It's not very nice, but should work.

Well, if *sectors has no meaning in this context, then there is hadrly
a reason to call ide_end_request either... So I figured rq can be
terminated as below. As for postponing HWIF(drive)->ide_dma_off(drive).
Legitimately terminated commands is hardly a reason for switchinf DMA
off. Most notably DVD-RW units terminate WRITE requests every time
internal buffer gets exhausted, which happens all the time...

Cheers. A.
8<--------8<--------8<--------8<--------8<--------8<--------8<--------
--- ./drivers/ide/ide-cd.c.orig	Tue Jun  3 12:21:56 2003
+++ ./drivers/ide/ide-cd.c	Thu Jun  5 22:26:56 2003
@@ -749,12 +749,17 @@
 		   by transferring the semaphore from the packet
 		   command request to the request sense request. */
 
+		rq->flags |= REQ_FAILED;
 		if ((stat & ERR_STAT) != 0) {
 			wait = rq->waiting;
 			rq->waiting = NULL;
+			if (rq->flags&REQ_BLOCK_PC) {
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
+		if (stat&ERR_STAT)
+		{	end_that_request_chunk(rq, 0, rq->data_len);
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
