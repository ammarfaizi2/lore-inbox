Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263252AbSJ1Kws>; Mon, 28 Oct 2002 05:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263267AbSJ1Kws>; Mon, 28 Oct 2002 05:52:48 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:18922 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S263252AbSJ1Kwr>;
	Mon, 28 Oct 2002 05:52:47 -0500
Date: Mon, 28 Oct 2002 11:57:54 +0100
From: Jens Axboe <axboe@suse.de>
To: Nyk Tarr <nyk@giantx.co.uk>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.5.44-ac4 scsi CDROMEJECT problem
Message-ID: <20021028105754.GB844@suse.de>
References: <20021027223138.GA601@giantx.co.uk> <20021028081507.GD30429@suse.de> <20021028105433.GA18585@giantx.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021028105433.GA18585@giantx.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28 2002, Nyk Tarr wrote:
> On Mon, Oct 28, 2002 at 09:15:07AM +0100, Jens Axboe wrote:
> > On Sun, Oct 27 2002, Nyk Tarr wrote:
> > > Hi
> > > 
> > > This patch of Jens Axboe was missing from 2.5.44-ac4. Was this by design
> > > or accidental?
> > 
> > Please check blk_do_rq(), it sets rq_dev and rq_disk. So it's indeed
> > intentional. Since you ask, do you have problems ejecting?
> 
> Yup.
> 
> I can only see rq -> rq_dev being set in sg_io(), but then again, you
> could write the amount of C I know on a small postage stamp. ^_^
> 
> recompiled with the two assignments in under CDROMEJECT it works fine.

I just checked the -ac4 patch, and bits are indeed missing. The
recommended patch against -ac4 is:

--- drivers/block/scsi_ioctl.c~	2002-10-25 19:00:11.000000000 +0200
+++ drivers/block/scsi_ioctl.c	2002-10-25 19:01:15.000000000 +0200
@@ -37,11 +37,14 @@
 
 #define BLK_DEFAULT_TIMEOUT	(60 * HZ)
 
-int blk_do_rq(request_queue_t *q, struct request *rq)
+int blk_do_rq(request_queue_t *q, struct block_device *bdev, struct request *rq)
 {
 	DECLARE_COMPLETION(wait);
 	int err = 0;
 
+	rq->rq_dev = to_kdev_t(bdev->bd_dev);
+	rq->rq_disk = bdev->bd_disk;
+
 	/*
 	 * we need an extra reference to the request, so we can look at
 	 * it after io completion
@@ -221,9 +224,6 @@
 	if (writing)
 		rq->flags |= REQ_RW;
 
-	rq->rq_dev = to_kdev_t(bdev->bd_dev);
-	rq->rq_disk = bdev->bd_disk;
-
 	rq->hard_nr_sectors = rq->nr_sectors = nr_sectors;
 	rq->hard_cur_sectors = rq->current_nr_sectors = nr_sectors;
 
@@ -253,7 +253,7 @@
 	 * return -EIO if we didn't transfer all data, caller can look at
 	 * residual count to find out how much did succeed
 	 */
-	err = blk_do_rq(q, rq);
+	err = blk_do_rq(q, bdev, rq);
 	if (rq->data_len > 0)
 		err = -EIO;
 		
@@ -325,7 +325,7 @@
 			memset(rq->cmd, 0, sizeof(rq->cmd));
 			rq->cmd[0] = GPCMD_START_STOP_UNIT;
 			rq->cmd[4] = 0x02 + (close != 0);
-			err = blk_do_rq(q, rq);
+			err = blk_do_rq(q, bdev, rq);
 			blk_put_request(rq);
 			break;
 		default:

I think Alan dropped this last bit (or maybe it didn't apply for him,
dunno), at least I know it was sent.

-- 
Jens Axboe

