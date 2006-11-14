Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933416AbWKNLin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933416AbWKNLin (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 06:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933419AbWKNLin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 06:38:43 -0500
Received: from brick.kernel.dk ([62.242.22.158]:56858 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S933416AbWKNLim (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 06:38:42 -0500
Date: Tue, 14 Nov 2006 12:41:20 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to cleanly shut down a block device
Message-ID: <20061114114120.GC22178@kernel.dk>
References: <455969F2.80401@drzeus.cx> <20061114075648.GK15031@kernel.dk> <45597B0A.3060409@drzeus.cx> <20061114084519.GL15031@kernel.dk> <45598462.80605@drzeus.cx> <20061114104844.GA15340@flint.arm.linux.org.uk> <4559A99B.6070207@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4559A99B.6070207@drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14 2006, Pierre Ossman wrote:
> Russell King wrote:
> > Just arrange for the mmc_queue_thread() to empty the queue when
> > MMC_QUEUE_EXIT is set, and then exit.  I thought this was something
> > that the block layer looked after (Jens must have missed this in his
> > original review of the MMC code.)
> >   
> 
> mmc_queue_thread() will empty the thread when MMC_QUEUE_EXIT is set. The
> problem is that we do not set that bit until the last person closes the
> device. In order to avoid problems we need to empty the queue before
> mmc_blk_remove() exits (after which the card structure is no longer valid).
> 
> > The handling of userspace keeping the device open despite the hardware
> > having been removed is already in place.
> >
> >   
> 
> Ok, that's one less problem for me to worry about. :)
> 
> Jens Axboe wrote:
> > What do you mean by "killing off the queue"? As long as the queue can be
> > gotten at, it needs to remain valid. That is what the references are
> > for.
> >   
> 
> I do:
> 
> del_gendisk();
> (wait for queue to become empty, i.e. elv_next_request() == NULL)
> blk_cleanup_queue();

elv_next_request() returning NULL means nothing wrt the queue being
empty.

> and then assume that the request function will no longer be called for
> this queue.
> 
> Suggested patch:

I think you are making this way too complicated, it's actually pretty
simple: you call blk_put_queue() or blk_cleanup_queue() (same thing)
when _you_ drop your reference to the queue. That's just normal cleanup.
When a device goes away, you make sure that you know about this. I said
that SCSI clears q->queuedata, so it knows that when ->request_fn is
invoked with a NULL q->queuedata (where it stores the device pointer),
the device is not there and the request should just be flushed to
heaven.

Don't make any assumptions about when request_fn will be called or not.
That's bound to be racy anyway.

-- 
Jens Axboe

