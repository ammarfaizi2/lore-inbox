Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316541AbSFULKJ>; Fri, 21 Jun 2002 07:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316542AbSFULKJ>; Fri, 21 Jun 2002 07:10:09 -0400
Received: from [195.63.194.11] ([195.63.194.11]:61709 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316541AbSFULKH> convert rfc822-to-8bit; Fri, 21 Jun 2002 07:10:07 -0400
Message-ID: <3D13098E.2020100@evision-ventures.com>
Date: Fri, 21 Jun 2002 13:10:06 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: hda: error: DMA in progress..
References: <20020621092459.GD27090@suse.de> <3D12FA4D.6060500@evision-ventures.com> <20020621101202.GF27090@suse.de> <3D130095.6050207@evision-ventures.com> <20020621103553.GI27090@suse.de>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Jens Axboe napisa³:

>>OK. We have now just one single place where IDE_DMA gets unset ->
>>udma_stop. This to too early to reset IDE_BUSY. However it well
>>may be that ide_dma_intr() simply doesn't care about IDE_BUSY.
>>Let's have a look...
> 
> 
> You can leave IDE_BUSY there, that's ok. It's not invalid for IDE_BUSY
> to be set while IDE_DMA gets cleared. That's expected.
> 

>>Well lets look at ata_irq_intr, the end of it:
>>
>>	 * Note that handler() may have set things up for another
>>	 * interrupt to occur soon, but it cannot happen until
>>	 * we exit from this routine, because it will be the
>>	 * same irq as is currently being serviced here, and Linux
>>	 * won't allow another of the same (on any CPU) until we return.
>>	 */
>>	if (startstop == ide_stopped) {
>>		if (!ch->handler) {	/* paranoia */
>>			clear_bit(IDE_BUSY, ch->active);
>>			do_request(ch);
>>		} else {
>>			printk("%s: %s: huh? expected NULL handler on 
>>			exit\n", drive->name, __FUNCTION__);
>>		}
>>	} else if (startstop == ide_released)
>>		queue_commands(drive);
>>
>>I think the above needs more tough now...
> 
> 
> Same case as the one I described in the email following this, will only
> happen for TCQ with release interrupt enabled. Otherwise it's illegal to
> release the bus from the tcq interrupt handler. Since I removed all
> traces of that long ago, you can safely kill the
> 
> 	} else if (startstop == ide_released)
> 		queue_commands(drive);
> 
> part of it.

I'm glad to get confirmation on this. This leaves only one place, vide:
do_request, where we can queue up new commands. Much easier to trace and
makes queue_commands never run from IRQ context, which is simplyfiying
things too.

> The rest looks sane. If handler returns it's no longer busy
> (ide_stopped), we clear IDE_BUSY (IDE_DMA damn well better be cleared at
> this point as well!!) and let do_request() start a new request (heck or
> the same, we don't know and don't care).

Right now the handlers are expected to clear IDE_BUSY and ->handler
themself. I have now an idea: Could you add a reporting about
the handler function there:

  	if (test_bit(IDE_DMA, ch->active)) {
			printk(KERN_ERR "%s: error: DMA in progress... %p\n", drive->name, ch->handler);
			break;
		}

And please take a short look at System.map.

This will show which IRQ handler is the culprit...

If it's indeed ide_dma_intr, let's have a look on it:

We see that it's calling udma_stop() immediately. This should
reset IDE_DMA unconditionally.. immediately on enty:

static inline int udma_stop(struct ata_device *drive)
{
	clear_bit(IDE_DMA, drive->channel->active);

	return drive->channel->udma_stop(drive);
}

Argh... There is a race in the above it should be:

static inline int udma_stop(struct ata_device *drive)
{
	int ret = drive->channel->udma_stop(drive);
         clear_bit(IDE_DMA, drive->channel->active);
         return ret;
}

Or we should move the clar_bit down do ide_dma_intr and
silbings behind __ata_end_request().
And finally we don't clear the IDE_BUSY on this code path.

