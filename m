Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261299AbVE2JzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbVE2JzK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 05:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbVE2JzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 05:55:10 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:15304 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261299AbVE2JzB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 05:55:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=WgZYCXTTVGQVzNRh3Ys5IwBAv95KWty7aF1mDP3BxcF9G1cQHlu9HLdulKCJeMv/EcJCGXT3J8pbwf0r3eZnbndOvSlHTSYDwzVe+amq7TuLM7j6Guk4UDuqkIQBCwVPxg1hFbD3rXaoiEPktrcbAwgTsiHtqZBza9E1xNwNw/o=
Date: Sun, 29 May 2005 18:54:51 +0900
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, James.Bottomley@steeleye.com, bzolnier@gmail.com,
       jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH Linux 2.6.12-rc5-mm1 04/06] blk: reimplement QUEUE_OREDERED_FLUSH
Message-ID: <20050529095451.GA17001@htj.dyndns.org>
References: <20050529042034.5FF4CF1C@htj.dyndns.org> <20050529042034.2CF278F2@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050529042034.2CF278F2@htj.dyndns.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 29, 2005 at 01:23:38PM +0900, Tejun Heo wrote:
> 04_blk_flush_reimplementation.patch
> 
> 	Reimplement QUEUE_ORDERED_FLUSH.
> 
> 	* Implementation is contained inside blk layer.  Only
> 	  prepare_flush_fn() is needed from individual drivers.
> 	* Tagged queues which don't support ordered tag can use
>           flushing.
> 	* Multi-bio barrier requests supported.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
>  drivers/block/elevator.c   |   52 ++++----
>  drivers/block/ll_rw_blk.c  |  279 +++++++++++++++++++++++++++------------------
>  drivers/ide/ide-disk.c     |   39 ------
>  drivers/ide/ide-io.c       |    5 
>  drivers/scsi/scsi_lib.c    |   21 ---
>  drivers/scsi/sd.c          |   25 ----
>  include/linux/blkdev.h     |   29 ++--
>  include/scsi/scsi_driver.h |    1 
>  8 files changed, 210 insertions(+), 241 deletions(-)

 In blk_do_barrier() above patch implements, when a barrier request is
terminated w/ -EOPNOTSUPP, the request is not dequeued.  The following
patch fixes this.  The fixed path is a very rare error path, so, for
reviewing, this patch doesn't make much difference.  I'll use properly
regenerated patch on the next posting of this patchset.

diff -u blk-fixes/drivers/block/ll_rw_blk.c blk-fixes/drivers/block/ll_rw_blk.c
--- blk-fixes/drivers/block/ll_rw_blk.c	2005-05-29 13:20:31.000000000 +0900
+++ blk-fixes/drivers/block/ll_rw_blk.c	2005-05-29 18:23:05.000000000 +0900
@@ -352,6 +352,8 @@
 	struct request *rq = q->bar_rq;
 	struct bio *bio = q->bar_bio;
 
+	BUG_ON(!list_empty(&rq->queuelist));
+
 	q->flush_seq = QUEUE_FLUSH_NONE;
 	q->bar_rq = NULL;
 	q->bar_bio = NULL;
@@ -457,6 +459,7 @@
 			 * This can happen when the queue switches to
 			 * ORDERED_NONE while this request is on it.
 			 */
+			blkdev_dequeue_request(rq);
 			end_that_request_first(rq, -EOPNOTSUPP,
 					       rq->hard_nr_sectors);
 			end_that_request_last(rq, -EOPNOTSUPP);
