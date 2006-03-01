Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751934AbWCAX3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934AbWCAX3b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 18:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751936AbWCAX3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 18:29:31 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:49933 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751934AbWCAX3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 18:29:30 -0500
Date: Wed, 1 Mar 2006 23:29:13 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Jens Axboe <axboe@suse.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to map high memory for block io
Message-ID: <20060301232913.GC4024@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	Jens Axboe <axboe@suse.de>, LKML <linux-kernel@vger.kernel.org>
References: <20060127202646.GC2767@flint.arm.linux.org.uk> <43DA84B2.8010501@drzeus.cx> <43DA97A3.4080408@drzeus.cx> <20060127225428.GD2767@flint.arm.linux.org.uk> <20060128191759.GC9750@suse.de> <43DBC6E2.4000305@drzeus.cx> <20060129152228.GF13831@suse.de> <43DDC6F9.6070007@drzeus.cx> <20060130080930.GB4209@suse.de> <43DFAEC6.3090205@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DFAEC6.3090205@drzeus.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2006 at 07:39:02PM +0100, Pierre Ossman wrote:
> Jens Axboe wrote:
> > On Mon, Jan 30 2006, Pierre Ossman wrote:
> >   
> >> Jens Axboe wrote:
> >>     
> >>>
> >>> Ah, you need to disable clustering to prevent that from happening! I was
> >>> confused there for a while.
> >>>
> >>>   
> >>>       
> >> And which is the lesser evil, highmem bounce buffers or disabling
> >> clustering? I'd probably vote for the former since the MMC overhead can
> >> be quite large.
> >>     
> >
> > Disabling clustering is by far the least expensive way to accomplish it.
> >
> >   
> 
> Russell, what's your view on this? And how should we handle it with
> regard to MMC drivers?

Okay, I've hit this same problem (but in a slightly different way) with
mmci.c.  The way I'm proposing to fix this for mmci is to introduce a
new capability which says "clustering is supported by this driver."

I'm unconvinced that we can safely fiddle with the queue's flags once
the queue is in use, hence why I've gone for the init-time only solution.
Maybe Jens can comment on that?

(The side effect of this patch is that everyone ends up with clustering
disabled until they explicitly update their driver to enable it - which
results in us defaulting to a safe operation mode.)

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x '*.orig' -x '*.rej' -x .git a/drivers/mmc/mmc_queue.c b/drivers/mmc/mmc_queue.c
--- a/drivers/mmc/mmc_queue.c	Sun Nov  6 22:16:40 2005
+++ b/drivers/mmc/mmc_queue.c	Wed Mar  1 23:18:33 2006
@@ -144,6 +144,14 @@ int mmc_init_queue(struct mmc_queue *mq,
 	blk_queue_max_hw_segments(mq->queue, host->max_hw_segs);
 	blk_queue_max_segment_size(mq->queue, host->max_seg_size);
 
+	/*
+	 * If the host does not support clustered requests, tell BIO.
+	 * It is not clear when we can alter this, so only do it at
+	 * initialisation time, before the queue is in use.
+	 */
+	if (!(host->caps & MMC_CAP_CLUSTER))
+		mq->queue->queue_flags &= ~(1 << QUEUE_FLAG_CLUSTER);
+
 	mq->queue->queuedata = mq;
 	mq->req = NULL;
 
diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x '*.orig' -x '*.rej' -x .git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
--- a/include/linux/mmc/host.h	Sun Nov  6 22:20:12 2005
+++ b/include/linux/mmc/host.h	Wed Mar  1 23:10:18 2006
@@ -85,6 +85,7 @@ struct mmc_host {
 	unsigned long		caps;		/* Host capabilities */
 
 #define MMC_CAP_4_BIT_DATA	(1 << 0)	/* Can the host do 4 bit transfers */
+#define MMC_CAP_CLUSTER		(1 << 1)	/* host can support clustered BIOs */
 
 	/* host specific block data */
 	unsigned int		max_seg_size;	/* see blk_queue_max_segment_size */



-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
