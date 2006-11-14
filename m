Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbWKNHyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWKNHyM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 02:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933212AbWKNHyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 02:54:12 -0500
Received: from brick.kernel.dk ([62.242.22.158]:12385 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S932126AbWKNHyL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 02:54:11 -0500
Date: Tue, 14 Nov 2006 08:56:49 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to cleanly shut down a block device
Message-ID: <20061114075648.GK15031@kernel.dk>
References: <455969F2.80401@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455969F2.80401@drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14 2006, Pierre Ossman wrote:
> Hi Jens,
> 
> I've been trying to sort out some bugs in the MMC layer's block driver,
> but my knowledge about the block layer is severely lacking. So I was
> hoping you could educate me a bit. :)
> 
> Upon creation, the following happens:
> 
> alloc_disk()
> spin_lock_init()
> blk_init_queue()
> blk_queue_*() (Set up limits)
> disk->* = * (assign members)
> blk_queue_hardsect_size()
> set_capacity()
> add_disk()
> 
> And on a clean removal, where there are no users of a card when it is
> removed:
> 
> del_gendisk()
> put_disk()
> blk_cleanup_queue()
> 
> So far everything seems nice and peachy. The question is what to do when
> a card is removed when the device is open.
> 
> In that case, del_gendisk() will be called, which seems to be documented
> as blocking any new requests to be added to the queue. But there will be
> a lot of outstanding requests in the queue.
> 
> Is it up to each block device to iterate and fail these or can I tell
> the kernel "I'm broken, go away!"?
> 
> When the queue eventually drains (without too many oopses) and the user
> calls close(), then put_disk() and blk_cleanup_queue() will be called.

There is no helper to kill already queued requests when a device is
removed, if you look at SCSI you'll see that it handles this "manually"
as well in the request_fn handler. So you'll need a "device dead or
gone" check in your request_fn handler, and do it from there.

-- 
Jens Axboe

