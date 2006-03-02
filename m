Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbWCBKEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbWCBKEi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 05:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWCBKEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 05:04:38 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:42509 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932395AbWCBKEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 05:04:37 -0500
Date: Thu, 2 Mar 2006 10:04:09 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Jens Axboe <axboe@suse.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to map high memory for block io
Message-ID: <20060302100409.GB14017@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	Jens Axboe <axboe@suse.de>, LKML <linux-kernel@vger.kernel.org>
References: <20060128191759.GC9750@suse.de> <43DBC6E2.4000305@drzeus.cx> <20060129152228.GF13831@suse.de> <43DDC6F9.6070007@drzeus.cx> <20060130080930.GB4209@suse.de> <43DFAEC6.3090205@drzeus.cx> <20060301232913.GC4024@flint.arm.linux.org.uk> <44069E3A.4000907@drzeus.cx> <20060302094153.GA14017@flint.arm.linux.org.uk> <4406C044.4080201@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4406C044.4080201@drzeus.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2006 at 10:52:04AM +0100, Pierre Ossman wrote:
> Russell King wrote:
> > I think you're asking Jens that question - I know of no way to tell
> > the block layer that clustering is fine for normal but not highmem.
> 
> That wasn't what I meant. What I was referring to was disabling highmem
> altogether, the way that is done now through looking at the dma mask.

You need to set your struct device's dma_mask appropriately:

        u64 limit = BLK_BOUNCE_HIGH;

        if (host->dev->dma_mask && *host->dev->dma_mask)
                limit = *host->dev->dma_mask;

        blk_queue_bounce_limit(mq->queue, limit);

Hence, if dma_mask is a NULL pointer or zero, highmem will be bounced.
Neither PNP nor your platform device sets dma_mask, so highmem will
always be bounced in the case of wbsd - which from what you write above
is what you require anyway.

Note: The host can't reach the queue itself because the queues are
created dynamically - it doesn't know when the queue is created or
destroyed or which request comes from which queue.  I'd also guess that
randomly changing the bounce limit will probably end up with a random
selection of requests which have been bounced and those which haven't
hitting the driver.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
