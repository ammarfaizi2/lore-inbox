Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313206AbSEERJ7>; Sun, 5 May 2002 13:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313217AbSEERJ6>; Sun, 5 May 2002 13:09:58 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:19720 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S313206AbSEERJ4>;
	Sun, 5 May 2002 13:09:56 -0400
Date: Sun, 5 May 2002 19:09:30 +0200
From: Jens Axboe <axboe@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.13 IDE 52
Message-ID: <20020505170930.GG811@suse.de>
In-Reply-To: <1019549894.1450.41.camel@turbulence.megapathdsl.net> <3CC7E358.8050905@evision-ventures.com> <20020425172508.GK3542@suse.de> <20020425173439.GM3542@suse.de> <aa9qtb$d8a$1@penguin.transmeta.com> <3CD555BD.2010505@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 05 2002, Martin Dalecki wrote:
> - Split up the TCQ UDMA handling stuff in to proper functions. Jens must has
>   been dreaming as he introduced them ;-).

This was pending stuff, and why I wrote that the start command tcq = 1
stuff was a gross hack.

> -		int tcq = 0;
>  
>  		if (!drive->using_dma)
>  			return ide_started;
>  
>  		/* for dma commands we don't set the handler */
> -		if (args->taskfile.command == WIN_WRITEDMA || args->taskfile.command == WIN_WRITEDMA_EXT)
> +		if (args->taskfile.command == WIN_WRITEDMA
> +		 || args->taskfile.command == WIN_WRITEDMA_EXT)
>  			dma_act = ide_dma_write;
> -		else if (args->taskfile.command == WIN_READDMA || args->taskfile.command == WIN_READDMA_EXT)
> +		else if (args->taskfile.command == WIN_READDMA
> +		      || args->taskfile.command == WIN_READDMA_EXT)
>  			dma_act = ide_dma_read;
> -		else if (args->taskfile.command == WIN_WRITEDMA_QUEUED || args->taskfile.command == WIN_WRITEDMA_QUEUED_EXT) {
> -			tcq = 1;
> -			dma_act = ide_dma_write_queued;
> -		} else if (args->taskfile.command == WIN_READDMA_QUEUED || args->taskfile.command == WIN_READDMA_QUEUED_EXT) {
> -			tcq = 1;
> -			dma_act = ide_dma_read_queued;
> -		} else {
> +#ifdef CONFIG_BLK_DEV_IDE_TCQ
> +		else if (args->taskfile.command == WIN_WRITEDMA_QUEUED
> +		      || args->taskfile.command == WIN_WRITEDMA_QUEUED_EXT
> +		      || args->taskfile.command == WIN_READDMA_QUEUED
> +		      || args->taskfile.command == WIN_READDMA_QUEUED_EXT)
> +			return udma_tcq_taskfile(drive, rq);
> +#endif
> +		else {
>  			printk("ata_taskfile: unknown command %x\n", args->taskfile.command);
>  			return ide_stopped;
>  		}
>  
> -		/*
> -		 * FIXME: this is a gross hack, need to unify tcq dma proc and
> -		 * regular dma proc -- basically split stuff that needs to act
> -		 * on a request from things like ide_dma_check etc.
> -		 */
> -		if (tcq)
> -			return drive->channel->udma(dma_act, drive, rq);
> -		else {
> -			if (drive->channel->udma(dma_act, drive, rq))
> -				return ide_stopped;
> -		}
> +
> +		if (drive->channel->udma(dma_act, drive, rq))
> +			return ide_stopped;

This is still ugly, IMHO. What I wanted was to split the udma->
function into two parts, one that acts on a request (ide_dma_read,
ide_dma_being, etc -- and then also ide_dma_read_queued) ad one that
does the silly stuff like ide_dma_check etc. Then unify the tcq and
non-tcq stuff so that udma_rw->(dma_act, drive, rq) always returns
ide_started or ide_stopped (or ide_released) and kill the #ifdef above.

I don't think udma_tcq_taskfile() should be public like this, and btw I
think the name really SUCKS! :-). ata_tcq_dma() is much better for
instance, even though it should be a private stratey. BTW, this goes for
all your tcq.c renaming.

-- 
Jens Axboe

