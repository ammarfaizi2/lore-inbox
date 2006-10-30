Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030543AbWJ3PnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030543AbWJ3PnJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 10:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030541AbWJ3PnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 10:43:09 -0500
Received: from brick.kernel.dk ([62.242.22.158]:35884 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1030544AbWJ3PnF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 10:43:05 -0500
Date: Mon, 30 Oct 2006 16:44:44 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Mark Lord <liml@rtr.ca>,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, mingo@elte.hu
Subject: Re: 2.6.19-rc3-git7: scsi_device_unbusy: inconsistent lock state
Message-ID: <20061030154444.GH4563@kernel.dk>
References: <45460D52.3000404@rtr.ca> <20061030144315.GG4563@kernel.dk> <1162220239.2948.27.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162220239.2948.27.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30 2006, Arjan van de Ven wrote:
> 
> > which has always been considered safe, while not very pretty.
> 
> 
> actually it's different I think (based on a brief inspection of the
> code, I could well be wrong): 
> get_request_wait() causes a get_request() call with a GFP_NOIO gfp_mask
> which perculates upto cfq_set_request() as argument.
> cfq_set_request() then calls the inline cfq_get_queue() (which isn't in
> the backtrace due to inlining) which does
>                 } else if (gfp_mask & __GFP_WAIT) {
>                         /* 
>                          * Inform the allocator of the fact that we will
>                          * just repeat this allocation if it fails, to allow
>                          * the allocator to do whatever it needs to attempt to
>                          * free memory.
>                          */
>                         spin_unlock_irq(cfqd->queue->queue_lock);
> 
> which enables interrupts right smack in the middle of holding a whole
> bunch of locks.....

Where do you get 'a bunch' from? If you call get_request() with a
gfp_mask that includes __GFP_WAIT with a spinlock held, it's a bug. Just
as if you had called kmalloc() or similar with __GFP_WAIT set and
holding a lock. cfq even includes a warning check:

        might_sleep_if(gfp_mask & __GFP_WAIT);

So there's no bug there, cfq even grabbed the lock on its own before
calling cfq_get_queue().

> so to me it looks like lockdep at least has the appearance of moaning
> about a reasonably fishy situation...

To me it looks more about lockdep complaining because it doesn't grok
the full picture. The question is how to shut it up.

-- 
Jens Axboe

