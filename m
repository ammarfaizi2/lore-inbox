Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbUCWKsy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 05:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262454AbUCWKsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 05:48:54 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:53227 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262422AbUCWKss (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 05:48:48 -0500
Date: Tue, 23 Mar 2004 11:48:47 +0100
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Cc: samuel@ibrium.se
Subject: Re: ide-cd bug (MODE_SENSE/CDROM_SEND_PACKET)
Message-ID: <20040323104846.GZ1481@suse.de>
References: <20040323004049.GA931@ibrium.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040323004049.GA931@ibrium.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23 2004, Samuel Rydh wrote:
> 
> If a MODE_SENSE(6) command is sent to an IDE cd using the CDROM_SEND_PACKET
> ioctl, then the kernel freezes solidly. To reproduce this, one can take the
> SCSI cmd [1a 08 31 00 10 00] and a 16 byte data buffer.
> 
> After some bug hunting, I found out that the following is what happens:
> 
> - ide-cd recognizes that MODE_SENSE(6) isn't supported and tries
> to abort the request from ide_cdrom_prep_pc by returning BLKPREP_KILL.
> 
> - in elv_next_request(), the kill request is handled by
> the following code:
> 
> 	while (end_that_request_first(rq, 0, rq->nr_sectors))
> 		;
> 	end_that_request_last(rq);
>
> The while loop never exits. The end_that_request_first() doesn't do anything
> since rq->nr_sectors is 0; it just returns "not-done" after handling those 0
> bytes (rq->bio->bi_size is 16).
> 
> I'm not quite sure how to fix this properly. For one thing, the data buffer
> associated with the MODE_SENSE command is not sector sized in the first
> place...
> 
> This is with a recent 2.6.5-rc1 kernel built from the BK tree.

Could you check if this works for you?

===== drivers/block/elevator.c 1.53 vs edited =====
--- 1.53/drivers/block/elevator.c	Mon Jan 19 07:38:36 2004
+++ edited/drivers/block/elevator.c	Tue Mar 23 11:47:53 2004
@@ -210,10 +210,14 @@
 			rq = NULL;
 			break;
 		} else if (ret == BLKPREP_KILL) {
+			int nr_bytes = rq->hard_nr_sectors << 9;
+
+			if (!nr_bytes)
+				nr_bytes = rq->data_len;
+
 			blkdev_dequeue_request(rq);
 			rq->flags |= REQ_QUIET;
-			while (end_that_request_first(rq, 0, rq->nr_sectors))
-				;
+			end_that_request_chunk(rq, 0, nr_bytes);
 			end_that_request_last(rq);
 		} else {
 			printk("%s: bad return=%d\n", __FUNCTION__, ret);

-- 
Jens Axboe

