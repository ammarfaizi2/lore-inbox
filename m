Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264940AbTFQVk2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 17:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264948AbTFQVk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 17:40:28 -0400
Received: from fyserv1.fy.chalmers.se ([129.16.110.66]:48258 "EHLO
	fyserv1.fy.chalmers.se") by vger.kernel.org with ESMTP
	id S264940AbTFQVkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 17:40:11 -0400
Message-ID: <3EEF8E2E.5E14946E@fy.chalmers.se>
Date: Tue, 17 Jun 2003 23:54:54 +0200
From: Andy Polyakov <appro@fy.chalmers.se>
X-Mailer: Mozilla 4.8 [en] (Windows NT 5.0; U)
X-Accept-Language: en,sv,ru
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: axboe@suse.de
Subject: Regarding drivers/ide/ide-cd.c in 2.5.72
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have brought this issue once already in 2.5.70 context (see uppermost
post in http://marc.theaimsgroup.com/?t=105410790500005&r=1&w=2), but it
apparently slipped through. So I've decided to bring it up again, this
time describing [hopefully] better how does this *generic* problem with
ide-cd.c manifests itself. In the nutshell the problem is that [as it is
now] every failed SG_IO request is replayed second time without data
transfer. E.g. if WRITE(10) SCSI command fails with sense code X, ide-cd
immediately resends the command block descriptor one more time, this time
without programming for any associated I/O payload, which [normally]
results in *different* sense code. And the catch is that user-land gets
this second sense code instead of the real/original one. Suggested patch
overcomes this problem by immediately purging the failed SG_IO request
from the request queue.

P.S. Non-essential "rant." One can wonder how come the originally
discussed patch, the one which made to 2.5.71, was sufficient for DVD+RW
units, but not DVD-RW. Are commands sent to DVD-RW unit so to say bound
to fail? In a sense yes! Majority of DVD-RW units terminate WRITE
requests  with "LONG WRITE IN PROGRESS" sense code wherever internal
buffer gets full. The idea behind this LUN behaviour is to minimize
IDE-bus monopolization periods. The sense code is commonly treated as
"estimate how long does it take to purge say 1/2 of internal buffer,
hibernate for that while and retry the failed WRITE command." Needless
to say that if original sense code is effectively discarded and replaced
by another code [apparently by "INVALID ADDRESS FOR WRITE"], it makes it
impossible to treat this essentially *non-error* condition appropriately
For whatever reason DVD+RW units don't terminate WRITE requests in same
manner and IDE-bus remains monopilized till there is buffer space
available to meet the outstanding WRITE request. Well, there're commands
which get replayed even in DVD+RW case, those are data-less commands,
most notably TEST UNIT READY, which are "safe" to replay.

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
