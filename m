Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316496AbSFUKbv>; Fri, 21 Jun 2002 06:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316535AbSFUKbu>; Fri, 21 Jun 2002 06:31:50 -0400
Received: from [195.63.194.11] ([195.63.194.11]:44813 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316496AbSFUKbt> convert rfc822-to-8bit; Fri, 21 Jun 2002 06:31:49 -0400
Message-ID: <3D130095.6050207@evision-ventures.com>
Date: Fri, 21 Jun 2002 12:31:49 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: hda: error: DMA in progress..
References: <20020621092459.GD27090@suse.de> <3D12FA4D.6060500@evision-ventures.com> <20020621101202.GF27090@suse.de>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Jens Axboe napisa³:
> On Fri, Jun 21 2002, Martin Dalecki wrote:

> 
>>And I was asking about it's possible interactions with TCQ.
> 
> 
> Haven't even tried TCQ yet, the above is just plain dma (no travelstarts
> can do tcq).

Argh...


>>
>>	if (blk_queue_plugged(&drive->queue)) {
>>			BUG_ON(!drive->using_tcq);
>>			break;

> 
> Not exactly, let me see if I remember the race here... The queue can
> become plugged when we queue one request with the drive (the only on the
> queue at that time), and then try to queue another right after (hence
> only a tcq issue). In that time period, we drop the queue lock, so it's
> indeed possible for the block layer to plug the queue before we reach
> the above code again. The drive can be in two states here, 1) IDE_DMA is
> set because the drive didn't release the bus (or it did, and it already
> reconnected), or 2) drive is disconnected from the bus.

OK. We have now just one single place where IDE_DMA gets unset ->
udma_stop. This to too early to reset IDE_BUSY. However it well
may be that ide_dma_intr() simply doesn't care about IDE_BUSY.
Let's have a look...

> 
> For non-tcq, hitting IDE_DMA set queue_commands() is a bug. The old
> IDE_BUSY/IDE_DMA worked because IDE_DMA must not be set if IDE_BUSY is
> not set.
> 
> 
>>This time it's no new damage - just detecting weak code
>>from the past...
> 
> 
> Smells like new breakage to me :-)

Well lets look at ata_irq_intr, the end of it:

	 * Note that handler() may have set things up for another
	 * interrupt to occur soon, but it cannot happen until
	 * we exit from this routine, because it will be the
	 * same irq as is currently being serviced here, and Linux
	 * won't allow another of the same (on any CPU) until we return.
	 */
	if (startstop == ide_stopped) {
		if (!ch->handler) {	/* paranoia */
			clear_bit(IDE_BUSY, ch->active);
			do_request(ch);
		} else {
			printk("%s: %s: huh? expected NULL handler on exit\n", drive->name, __FUNCTION__);
		}
	} else if (startstop == ide_released)
		queue_commands(drive);

I think the above needs more tough now...

