Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933426AbWKNLtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933426AbWKNLtH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 06:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933427AbWKNLtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 06:49:06 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:8970 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S933426AbWKNLtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 06:49:05 -0500
Date: Tue, 14 Nov 2006 11:48:57 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Jens Axboe <jens.axboe@oracle.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to cleanly shut down a block device
Message-ID: <20061114114857.GC15340@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	Jens Axboe <jens.axboe@oracle.com>,
	LKML <linux-kernel@vger.kernel.org>
References: <455969F2.80401@drzeus.cx> <20061114075648.GK15031@kernel.dk> <45597B0A.3060409@drzeus.cx> <20061114084519.GL15031@kernel.dk> <45598462.80605@drzeus.cx> <20061114104844.GA15340@flint.arm.linux.org.uk> <4559A99B.6070207@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4559A99B.6070207@drzeus.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2006 at 12:33:47PM +0100, Pierre Ossman wrote:
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
> 
> and then assume that the request function will no longer be called for
> this queue.
> 
> Suggested patch:
> 
> diff --git a/drivers/mmc/mmc_block.c b/drivers/mmc/mmc_block.c
> index f9027c8..5025abe 100644
> --- a/drivers/mmc/mmc_block.c
> +++ b/drivers/mmc/mmc_block.c
> @@ -83,7 +83,6 @@ static void mmc_blk_put(struct mmc_blk_d
>         md->usage--;
>         if (md->usage == 0) {
>                 put_disk(md->disk);
> -               mmc_cleanup_queue(&md->queue);
>                 kfree(md);
>         }
>         mutex_unlock(&open_lock);
> @@ -553,12 +552,11 @@ static void mmc_blk_remove(struct mmc_ca
>         if (md) {
>                 int devidx;
>  
> +               /* Stop new requests from getting into the queue */
>                 del_gendisk(md->disk);
>  
> -               /*
> -                * I think this is needed.
> -                */
> -               md->disk->queue = NULL;
> +               /* Then flush out any already in there */
> +               mmc_cleanup_queue(&md->queue);
>  
>                 devidx = md->disk->first_minor >> MMC_SHIFT;
>                 __clear_bit(devidx, dev_use);

You now have a disk which may be in use (and a block device) for which
there is no queue.  I couldn't see any locking what so ever in del_gendisk
so it's quite possible that the queue could still be referenced while
the disk is still open.

I also don't think del_gendisk() is sufficient to ensure that no new
requests appear in the queue, which is why I'm setting md->disk->queue
to NULL there.

But shug, I don't know the block layer.  Jens is your best bet.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
