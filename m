Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313571AbSFBUcy>; Sun, 2 Jun 2002 16:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313698AbSFBUcx>; Sun, 2 Jun 2002 16:32:53 -0400
Received: from [195.63.194.11] ([195.63.194.11]:56582 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313571AbSFBUcw>; Sun, 2 Jun 2002 16:32:52 -0400
Message-ID: <3CFA733F.4070907@evision-ventures.com>
Date: Sun, 02 Jun 2002 21:34:23 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.19 IDE 78
In-Reply-To: <Pine.LNX.4.33.0205291146510.1344-100000@penguin.transmeta.com>	<3CF9B58B.9080509@evision-ventures.com> <15609.58274.499517.16643@argo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras wrote:
> Martin,
> 
> I think you have a typo here:
> 
> 
>>diff -urN linux-2.5.19/drivers/ide/ide-pmac.c linux/drivers/ide/ide-pmac.c
>>--- linux-2.5.19/drivers/ide/ide-pmac.c	2002-06-01 18:53:06.000000000 +0200
>>+++ linux/drivers/ide/ide-pmac.c	2002-06-01 18:17:36.000000000 +0200
>>@@ -434,7 +434,7 @@
>> 		goto out;
>> 	}
>> 	udelay(10);
>>-	OUT_BYTE(drive->ctl | 2, IDE_CONTROL_REG);
>>+	ata_irq_enale(drive, 0);

For sure not. The nIEN bit is *negated* on the part of the
device - please look at the ata_irq_enable() functions definition.
I have explained it there.

> ata_irq_enable surely?

The toggle is the second parameter becouse I didn't wan't to
provide two functions. - 0 measn disable it 1 means enable it.

> 
> Also, we need the patch below now that ata_channel.active is a
> pointer.

That actually is obviously correct - thank's I will include it.

> 
> Paul.
> 
> diff -urN linux-2.5/drivers/ide/ide-pmac.c pmac-2.5/drivers/ide/ide-pmac.c
> --- linux-2.5/drivers/ide/ide-pmac.c	Sun Jun  2 14:45:47 2002
> +++ pmac-2.5/drivers/ide/ide-pmac.c	Sun Jun  2 15:41:31 2002
> @@ -1584,9 +1584,9 @@
>  	 */
>  	if (used_dma && !ide_spin_wait_hwgroup(drive)) {
>  		/* Lock HW group */
> -		set_bit(IDE_BUSY, &drive->channel->active);
> +		set_bit(IDE_BUSY, drive->channel->active);
>  		pmac_ide_check_dma(drive);
> -		clear_bit(IDE_BUSY, &drive->channel->active);
> +		clear_bit(IDE_BUSY, drive->channel->active);
>  		spin_unlock_irq(drive->channel->lock);
>  	}
>  #endif
> @@ -1633,7 +1633,7 @@
>  		return;
>  	else {
>  		/* Lock HW group */
> -		set_bit(IDE_BUSY, &drive->channel->active);
> +		set_bit(IDE_BUSY, drive->channel->active);
>  		/* Stop the device */
>  		idepmac_sleep_device(drive, idx, base);
>  		spin_unlock_irq(drive->channel->lock);
> @@ -1663,7 +1663,7 @@
>  
>  	/* We resume processing on the lock group */
>  	spin_lock_irq(drive->channel->lock);
> -	clear_bit(IDE_BUSY, &drive->channel->active);
> +	clear_bit(IDE_BUSY, drive->channel->active);
>  	if (!list_empty(&drive->queue.queue_head))
>  		do_ide_request(&drive->queue);
>  	spin_unlock_irq(drive->channel->lock);
> 
> 



-- 
- phone: +49 214 8656 283
- job:   eVision-Ventures AG, LEV .de (MY OPINIONS ARE MY OWN!)
- langs: de_DE.ISO8859-1, en_US, pl_PL.ISO8859-2, last ressort: ru_RU.KOI8-R

