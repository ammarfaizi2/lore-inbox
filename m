Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263876AbTEOEEJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 00:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263875AbTEOEEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 00:04:09 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:2728 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263876AbTEOEEH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 00:04:07 -0400
Date: Thu, 15 May 2003 09:37:31 +0530
From: Bharata B Rao <bharata@in.ibm.com>
To: Jens Axboe <axboe@suse.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Adrian Bunk <bunk@fs.tum.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>
Subject: Re: 2.5.69-mjb1: undefined reference to `blk_queue_empty'
Message-ID: <20030515093731.N31823@in.ibm.com>
Reply-To: bharata@in.ibm.com
References: <9380000.1052624649@[10.10.2.4]> <20030512205139.GT1107@fs.tum.de> <20570000.1052797864@[10.10.2.4]> <20030513124807.A31823@in.ibm.com> <25840000.1052834304@[10.10.2.4]> <20030513181155.GL17033@suse.de> <20030514133843.H31823@in.ibm.com> <20030514083224.GC13456@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030514083224.GC13456@suse.de>; from axboe@suse.de on Wed, May 14, 2003 at 10:32:24AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 10:32:24AM +0200, Jens Axboe wrote:
> 
> That really has to be locked down as well. For your purpose, I think the
> use of elv_queue_empty() is much better even though it really is an
> internal function. The problem mainly comes from AS, that can have non
> empty queue but still return NULL in elv_next_request().
> 
> But yes, it needs to be locked. If you have pinned the other CPUs, then
> I suppose it should work. But it's still a violation of the locking
> rules, and one would get in trouble dropping the queue lock from the io
> scheduler elevator_queue_empty_fn. No one does that currently, but... So
> please take the lock.
> 

Ok, Now we try to acquire the lock and refuse to dump if we don't get 
the lock.

--- 2569+mjb1/drivers/dump/dump_blockdev.c.orig	Wed May 14 13:23:36 2003
+++ 2569+mjb1/drivers/dump/dump_blockdev.c	Thu May 15 09:26:12 2003
@@ -258,10 +258,19 @@
 dump_block_silence(struct dump_dev *dev)
 {
 	struct dump_blockdev *dump_bdev = DUMP_BDEV(dev);
+	struct request_queue *q = bdev_get_queue(dump_bdev->bdev);
+	int ret;
+
+	/* If we can't get request queue lock, refuse to take the dump */
+	if (!spin_trylock(q->queue_lock))
+		return -EBUSY;
+
+	ret = elv_queue_empty(q);
+	spin_unlock(q->queue_lock);
 
 	/* For now we assume we have the device to ourselves */
 	/* Just a quick sanity check */
-	if (!blk_queue_empty(bdev_get_queue(dump_bdev->bdev))) {
+	if (!ret) {
 		/* i/o in flight - safer to quit */
 		return -EBUSY;
 	}

Regards,
Bharata.
