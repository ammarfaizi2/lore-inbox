Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316535AbSFUKgB>; Fri, 21 Jun 2002 06:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316538AbSFUKgB>; Fri, 21 Jun 2002 06:36:01 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:3811 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S316535AbSFUKgA>;
	Fri, 21 Jun 2002 06:36:00 -0400
Date: Fri, 21 Jun 2002 12:35:53 +0200
From: Jens Axboe <axboe@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: hda: error: DMA in progress..
Message-ID: <20020621103553.GI27090@suse.de>
References: <20020621092459.GD27090@suse.de> <3D12FA4D.6060500@evision-ventures.com> <20020621101202.GF27090@suse.de> <3D130095.6050207@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D130095.6050207@evision-ventures.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21 2002, Martin Dalecki wrote:
> U?ytkownik Jens Axboe napisa?:
> >On Fri, Jun 21 2002, Martin Dalecki wrote:
> 
> >
> >>And I was asking about it's possible interactions with TCQ.
> >
> >
> >Haven't even tried TCQ yet, the above is just plain dma (no travelstarts
> >can do tcq).
> 
> Argh...

Indeed

> >>
> >>	if (blk_queue_plugged(&drive->queue)) {
> >>			BUG_ON(!drive->using_tcq);
> >>			break;
> 
> >
> >Not exactly, let me see if I remember the race here... The queue can
> >become plugged when we queue one request with the drive (the only on the
> >queue at that time), and then try to queue another right after (hence
> >only a tcq issue). In that time period, we drop the queue lock, so it's
> >indeed possible for the block layer to plug the queue before we reach
> >the above code again. The drive can be in two states here, 1) IDE_DMA is
> >set because the drive didn't release the bus (or it did, and it already
> >reconnected), or 2) drive is disconnected from the bus.
> 
> OK. We have now just one single place where IDE_DMA gets unset ->
> udma_stop. This to too early to reset IDE_BUSY. However it well
> may be that ide_dma_intr() simply doesn't care about IDE_BUSY.
> Let's have a look...

You can leave IDE_BUSY there, that's ok. It's not invalid for IDE_BUSY
to be set while IDE_DMA gets cleared. That's expected.

> >For non-tcq, hitting IDE_DMA set queue_commands() is a bug. The old
> >IDE_BUSY/IDE_DMA worked because IDE_DMA must not be set if IDE_BUSY is
> >not set.
> >
> >
> >>This time it's no new damage - just detecting weak code
> >>from the past...
> >
> >
> >Smells like new breakage to me :-)
> 
> Well lets look at ata_irq_intr, the end of it:
> 
> 	 * Note that handler() may have set things up for another
> 	 * interrupt to occur soon, but it cannot happen until
> 	 * we exit from this routine, because it will be the
> 	 * same irq as is currently being serviced here, and Linux
> 	 * won't allow another of the same (on any CPU) until we return.
> 	 */
> 	if (startstop == ide_stopped) {
> 		if (!ch->handler) {	/* paranoia */
> 			clear_bit(IDE_BUSY, ch->active);
> 			do_request(ch);
> 		} else {
> 			printk("%s: %s: huh? expected NULL handler on 
> 			exit\n", drive->name, __FUNCTION__);
> 		}
> 	} else if (startstop == ide_released)
> 		queue_commands(drive);
> 
> I think the above needs more tough now...

Same case as the one I described in the email following this, will only
happen for TCQ with release interrupt enabled. Otherwise it's illegal to
release the bus from the tcq interrupt handler. Since I removed all
traces of that long ago, you can safely kill the

	} else if (startstop == ide_released)
		queue_commands(drive);

part of it.

The rest looks sane. If handler returns it's no longer busy
(ide_stopped), we clear IDE_BUSY (IDE_DMA damn well better be cleared at
this point as well!!) and let do_request() start a new request (heck or
the same, we don't know and don't care).

-- 
Jens Axboe

