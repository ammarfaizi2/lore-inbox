Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbWDIK3j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWDIK3j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 06:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbWDIK3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 06:29:38 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:30004 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750719AbWDIK3i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 06:29:38 -0400
Date: Sun, 9 Apr 2006 12:29:42 +0200
From: Jens Axboe <axboe@suse.de>
To: Rachita Kothiyal <rachita@in.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Patch to fix cdrom being confused on using kdump
Message-ID: <20060409102942.GI3859@suse.de>
References: <20060407135714.GA25569@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060407135714.GA25569@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07 2006, Rachita Kothiyal wrote:
> Hi Jens
> 
> As we had discussed earlier, I had seen the cdrom drive appearing
> confused on using kdump on certain x86_64 systems. During the booting 
> up of the second kernel, the following message would keep flooding
> the console, and the booting would not proceed any further.
> 
> hda: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
> 
> In this patch, whenever we are hitting a confused state in the interrupt
> handler with the DRQ set, we clear the DSC bit of the status register and 
> return 'ide_stopped' from the interrupt handler. 
> 
> Please provide your comments and feedback.
> 
> Thanks
> Rachita
> 
> 
> Signed-off-by: Rachita Kothiyal <rachita@in.ibm.com>
> ---
> 
>  drivers/ide/ide-cd.c |    5 +++++
>  1 files changed, 5 insertions(+)
> 
> diff -puN drivers/ide/ide-cd.c~cdrom-confused-clrinterrupt drivers/ide/ide-cd.c
> --- linux-2.6.16-mm2/drivers/ide/ide-cd.c~cdrom-confused-clrinterrupt	2006-03-29 11:23:18.000000000 +0530
> +++ linux-2.6.16-mm2-rachita/drivers/ide/ide-cd.c	2006-04-07 19:05:48.962710872 +0530
> @@ -1450,6 +1450,11 @@ static ide_startstop_t cdrom_pc_intr (id
>  			rq->sense_len += thislen;
>  	} else {
>  confused:
> +		if (( stat & DRQ_STAT) == DRQ_STAT) {

if (stat & DRQ_STAT)

checking for DRQ_STAT again doesn't make sense, how can it ever be
anything but DRQ_STAT if DRQ_STAT is set?

> +			/* DRQ is set. Interrupt not welcome now. Ignore */
> +			HWIF(drive)->OUTB((stat & 0xEF), IDE_STATUS_REG);
> +			return ide_stopped;

And this looks very wrong, you can't write to the status register. Well
you can, but then it's the command register! Writing stat & 0xef to the
command register is an odd thing to do. I think you just want to clear
the DRQ bit, which should be fine after it was read initially. How about


        if (stat & DRQ_STAT)
                return ide_stopped;

Can you test that?

-- 
Jens Axboe

