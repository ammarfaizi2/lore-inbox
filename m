Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbTENIHD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 04:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbTENIHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 04:07:03 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:1251 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261230AbTENIGy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 04:06:54 -0400
Date: Wed, 14 May 2003 13:38:43 +0530
From: Bharata B Rao <bharata@in.ibm.com>
To: Jens Axboe <axboe@suse.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Adrian Bunk <bunk@fs.tum.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>
Subject: Re: 2.5.69-mjb1: undefined reference to `blk_queue_empty'
Message-ID: <20030514133843.H31823@in.ibm.com>
Reply-To: bharata@in.ibm.com
References: <9380000.1052624649@[10.10.2.4]> <20030512205139.GT1107@fs.tum.de> <20570000.1052797864@[10.10.2.4]> <20030513124807.A31823@in.ibm.com> <25840000.1052834304@[10.10.2.4]> <20030513181155.GL17033@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030513181155.GL17033@suse.de>; from axboe@suse.de on Tue, May 13, 2003 at 08:11:55PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 08:11:55PM +0200, Jens Axboe wrote:
> > >  
> > >  	/* For now we assume we have the device to ourselves */
> > >  	/* Just a quick sanity check */
> > > -	if (!blk_queue_empty(bdev_get_queue(dump_bdev->bdev))) {
> > > +	if (elv_next_request(bdev_get_queue(dump_bdev->bdev))) {
> > >  		/* i/o in flight - safer to quit */
> > >  		return -EBUSY;
> > >  	}
> 
> this looks horribly racy (of the io scheduler internals corrupting
> kind), I don't see you holding the queue lock here. some io schedulers
> do non-significant amount of work inside they next_request functions,
> moving from back-end lists to dispatch queue.
> 

Jens,

All we want to do here is to check if there are requests in the
queue. Hence thinking of using elv_queue_empty(). Do you think
we still need to acquire queue lock for this ? This code will be
run when we have stopped everything else in other cpus by putting
them into spin.

--- 2569+mjb1/drivers/dump/dump_blockdev.c.orig	Wed May 14 13:23:36 2003
+++ 2569+mjb1/drivers/dump/dump_blockdev.c	Wed May 14 13:24:58 2003
@@ -258,10 +258,11 @@
 dump_block_silence(struct dump_dev *dev)
 {
 	struct dump_blockdev *dump_bdev = DUMP_BDEV(dev);
+	struct request_queue *q = bdev_get_queue(dump_bdev->bdev);
 
 	/* For now we assume we have the device to ourselves */
 	/* Just a quick sanity check */
-	if (!blk_queue_empty(bdev_get_queue(dump_bdev->bdev))) {
+	if (!elv_queue_empty(q)) {
 		/* i/o in flight - safer to quit */
 		return -EBUSY;
 	}

Regards,
Bharata.
