Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316533AbSFUKMO>; Fri, 21 Jun 2002 06:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316535AbSFUKMN>; Fri, 21 Jun 2002 06:12:13 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:44000 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S316533AbSFUKMM>;
	Fri, 21 Jun 2002 06:12:12 -0400
Date: Fri, 21 Jun 2002 12:12:02 +0200
From: Jens Axboe <axboe@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: hda: error: DMA in progress..
Message-ID: <20020621101202.GF27090@suse.de>
References: <20020621092459.GD27090@suse.de> <3D12FA4D.6060500@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D12FA4D.6060500@evision-ventures.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21 2002, Martin Dalecki wrote:
> U?ytkownik Jens Axboe napisa?:
> >Martin,
> >
> >I gave 2.5.24 a spin, and it quickly dies with the error in subject,
> >under moderate disk load. It's an IBM travel star on a PIIX4.
> >
> 
> 
> if (test_bit(IDE_DMA, ch->active)) {
> 		printk(KERN_ERR "%s: error: DMA in progress...\n", 
> 		drive->name);
> 			break;
> }
> 
> Well I did the change we where talking about .waiting_for_dma -> 
> xxx_bit(IDE_DMA.

Yeah I noticed.

> And I was asking about it's possible interactions with TCQ.

Haven't even tried TCQ yet, the above is just plain dma (no travelstarts
can do tcq).

> And now we see that it is indeed apparently really interacting with
> the TCQ code in bad ways. But if I look down from the above code (Just 
> below in ide.c)
> 
> 	if (blk_queue_plugged(&drive->queue)) {
> 			BUG_ON(!drive->using_tcq);
> 			break;
> 		}
> 
> It seems like the check which is catching reality right now
> is bogous in itself. Becouse having DMA running would be
> only problematic if the queue was still plugged. (Right?)
> So please just disable the check.

Not exactly, let me see if I remember the race here... The queue can
become plugged when we queue one request with the drive (the only on the
queue at that time), and then try to queue another right after (hence
only a tcq issue). In that time period, we drop the queue lock, so it's
indeed possible for the block layer to plug the queue before we reach
the above code again. The drive can be in two states here, 1) IDE_DMA is
set because the drive didn't release the bus (or it did, and it already
reconnected), or 2) drive is disconnected from the bus.

For non-tcq, hitting IDE_DMA set queue_commands() is a bug. The old
IDE_BUSY/IDE_DMA worked because IDE_DMA must not be set if IDE_BUSY is
not set.

> This time it's no new damage - just detecting weak code
> from the past...

Smells like new breakage to me :-)

-- 
Jens Axboe

