Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316532AbSFUKFF>; Fri, 21 Jun 2002 06:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316533AbSFUKFE>; Fri, 21 Jun 2002 06:05:04 -0400
Received: from [195.63.194.11] ([195.63.194.11]:21005 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316532AbSFUKFE> convert rfc822-to-8bit; Fri, 21 Jun 2002 06:05:04 -0400
Message-ID: <3D12FA4D.6060500@evision-ventures.com>
Date: Fri, 21 Jun 2002 12:05:01 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: hda: error: DMA in progress..
References: <20020621092459.GD27090@suse.de>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Jens Axboe napisa³:
> Martin,
> 
> I gave 2.5.24 a spin, and it quickly dies with the error in subject,
> under moderate disk load. It's an IBM travel star on a PIIX4.
> 


if (test_bit(IDE_DMA, ch->active)) {
		printk(KERN_ERR "%s: error: DMA in progress...\n", drive->name);
			break;
}

Well I did the change we where talking about .waiting_for_dma -> xxx_bit(IDE_DMA.
And I was asking about it's possible interactions with TCQ.
And now we see that it is indeed apparently really interacting with
the TCQ code in bad ways. But if I look down from the above code (Just below in 
ide.c)

	if (blk_queue_plugged(&drive->queue)) {
			BUG_ON(!drive->using_tcq);
			break;
		}

It seems like the check which is catching reality right now
is bogous in itself. Becouse having DMA running would be
only problematic if the queue was still plugged. (Right?)
So please just disable the check.

This time it's no new damage - just detecting weak code
from the past...

