Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283288AbRLIKWl>; Sun, 9 Dec 2001 05:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283287AbRLIKWb>; Sun, 9 Dec 2001 05:22:31 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:46855 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S283288AbRLIKWR>;
	Sun, 9 Dec 2001 05:22:17 -0500
Date: Sun, 9 Dec 2001 11:22:08 +0100
From: Jens Axboe <axboe@suse.de>
To: Carl Ritson <critson@perlfu.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOPS: 2.5.1-pre8 - cdrecord + ide_scsi
Message-ID: <20011209102208.GC20061@suse.de>
In-Reply-To: <Pine.LNX.4.33.0112090919220.1468-100000@eden.lincnet>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="TYecfFk8j8mZq+dy"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0112090919220.1468-100000@eden.lincnet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 09 2001, Carl Ritson wrote:
> Got this at the very start of burning a cd, nothing special, using
> ide-scsi build into kernel. "cdrecord -v dev=0,0,0 speed=4 img.iso".
> Box is Dual-PIII 866, 1GB Ram, all IDE system.

Agrh, because of a bug in ide-scsi conversion this (other) bug went
unnoticed for a while. Basically we cannot look up the request queue
reliably from a request, since it may not have originated from the block
layer. ide-scsi builds it's own, for example. For those, we don't want
to trust the sg count either.

Does attached patch work?

-- 
Jens Axboe


--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ide-dma-queue-1

--- /opt/kernel/linux-2.5.1-pre8/drivers/ide/ide-dma.c	Sun Dec  9 03:54:19 2001
+++ drivers/ide/ide-dma.c	Sun Dec  9 05:03:15 2001
@@ -226,12 +226,13 @@
 
 static int ide_build_sglist (ide_hwif_t *hwif, struct request *rq)
 {
+	request_queue_t *q = &hwif->drives[DEVICE_NR(rq->rq_dev) & 1].queue;
 	struct scatterlist *sg = hwif->sg_table;
 	int nents;
 
-	nents = blk_rq_map_sg(rq->q, rq, hwif->sg_table);
+	nents = blk_rq_map_sg(q, rq, hwif->sg_table);
 
-	if (nents > rq->nr_segments)
+	if (rq->q && nents > rq->nr_segments)
 		printk("ide-dma: received %d segments, build %d\n", rq->nr_segments, nents);
 
 	if (rq_data_dir(rq) == READ)

--TYecfFk8j8mZq+dy--
