Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161695AbWKHTJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161695AbWKHTJy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 14:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161697AbWKHTJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 14:09:54 -0500
Received: from sycorax.lbl.gov ([128.3.5.196]:58127 "EHLO sycorax.lbl.gov")
	by vger.kernel.org with ESMTP id S1161695AbWKHTJy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 14:09:54 -0500
From: Alex Romosan <romosan@sycorax.lbl.gov>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc5: known regressions
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
	<20061108085235.GT4729@stusta.de> <20061108093442.GB19471@kernel.dk>
Date: Wed, 08 Nov 2006 11:09:40 -0800
In-Reply-To: <20061108093442.GB19471@kernel.dk> (message from Jens Axboe on
	Wed, 8 Nov 2006 10:34:43 +0100)
Message-ID: <87ejsd3gcr.fsf@sycorax.lbl.gov>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <jens.axboe@oracle.com> writes:

> On Wed, Nov 08 2006, Adrian Bunk wrote:
>> Subject    : unable to rip cd
>> References : http://lkml.org/lkml/2006/10/13/100
>> Submitter  : Alex Romosan <romosan@sycorax.lbl.gov>
>> Status     : unknown
>
> Alex, was/is this repeatable? If so I'd like you to repeat with this
> debug patch applied, I cannot reproduce it locally.
>
> diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
> index bddfebd..ad03e19 100644
> --- a/drivers/ide/ide-cd.c
> +++ b/drivers/ide/ide-cd.c
> @@ -1726,8 +1726,10 @@ static ide_startstop_t cdrom_newpc_intr(
>  		/*
>  		 * write to drive
>  		 */
> -		if (cdrom_write_check_ireason(drive, len, ireason))
> +		if (cdrom_write_check_ireason(drive, len, ireason)) {
> +			blk_dump_rq_flags(rq, "cdrom_newpc");
>  			return ide_stopped;
> +		}
>  
>  		xferfunc = HWIF(drive)->atapi_output_bytes;
>  	} else  {
> @@ -1859,8 +1861,10 @@ static ide_startstop_t cdrom_write_intr(
>  	}
>  
>  	/* Check that the drive is expecting to do the same thing we are. */
> -	if (cdrom_write_check_ireason(drive, len, ireason))
> +	if (cdrom_write_check_ireason(drive, len, ireason)) {
> +		blk_dump_rq_flags(rq, "cdrom_pc");
>  		return ide_stopped;
> +	}
>  
>  	sectors_to_transfer = len / SECTOR_SIZE;
>  

i've tried it again with the above patch applied and when i start
cdparanoia i get:

kernel: hdc: write_intr: wrong transfer direction!
kernel: cdrom_newpc: dev hdc: type=2, flags=114c9
kernel: 
kernel: sector 59534648, nr/cnr 0/0
kernel: bio 00000000, biotail c14b2800, buffer 00000000, data 00000000, len 56
kernel: cdb: 12 00 00 00 38 00 00 00 00 00 00 00 00 00 00 00 

as for the lock up, the ripping process never completes, it starts and
then it hangs somewhere in the middle of the track. it could be that
the disk has some problems. anyway, abort execution doesn't work until
i physically eject the cd from the drive (which seems to be an
improvement from a couple of rc's ago). hope this helps.

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
