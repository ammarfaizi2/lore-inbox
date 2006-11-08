Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753424AbWKHT1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753424AbWKHT1L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 14:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753451AbWKHT1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 14:27:11 -0500
Received: from brick.kernel.dk ([62.242.22.158]:47669 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1753424AbWKHT1K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 14:27:10 -0500
Date: Wed, 8 Nov 2006 20:29:25 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Alex Romosan <romosan@sycorax.lbl.gov>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc5: known regressions
Message-ID: <20061108192924.GA4527@kernel.dk>
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org> <20061108085235.GT4729@stusta.de> <20061108093442.GB19471@kernel.dk> <87ejsd3gcr.fsf@sycorax.lbl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ejsd3gcr.fsf@sycorax.lbl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08 2006, Alex Romosan wrote:
> Jens Axboe <jens.axboe@oracle.com> writes:
> 
> > On Wed, Nov 08 2006, Adrian Bunk wrote:
> >> Subject    : unable to rip cd
> >> References : http://lkml.org/lkml/2006/10/13/100
> >> Submitter  : Alex Romosan <romosan@sycorax.lbl.gov>
> >> Status     : unknown
> >
> > Alex, was/is this repeatable? If so I'd like you to repeat with this
> > debug patch applied, I cannot reproduce it locally.
> >
> > diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
> > index bddfebd..ad03e19 100644
> > --- a/drivers/ide/ide-cd.c
> > +++ b/drivers/ide/ide-cd.c
> > @@ -1726,8 +1726,10 @@ static ide_startstop_t cdrom_newpc_intr(
> >  		/*
> >  		 * write to drive
> >  		 */
> > -		if (cdrom_write_check_ireason(drive, len, ireason))
> > +		if (cdrom_write_check_ireason(drive, len, ireason)) {
> > +			blk_dump_rq_flags(rq, "cdrom_newpc");
> >  			return ide_stopped;
> > +		}
> >  
> >  		xferfunc = HWIF(drive)->atapi_output_bytes;
> >  	} else  {
> > @@ -1859,8 +1861,10 @@ static ide_startstop_t cdrom_write_intr(
> >  	}
> >  
> >  	/* Check that the drive is expecting to do the same thing we are. */
> > -	if (cdrom_write_check_ireason(drive, len, ireason))
> > +	if (cdrom_write_check_ireason(drive, len, ireason)) {
> > +		blk_dump_rq_flags(rq, "cdrom_pc");
> >  		return ide_stopped;
> > +	}
> >  
> >  	sectors_to_transfer = len / SECTOR_SIZE;
> >  
> 
> i've tried it again with the above patch applied and when i start
> cdparanoia i get:
> 
> kernel: hdc: write_intr: wrong transfer direction!
> kernel: cdrom_newpc: dev hdc: type=2, flags=114c9
> kernel: 
> kernel: sector 59534648, nr/cnr 0/0
> kernel: bio 00000000, biotail c14b2800, buffer 00000000, data 00000000, len 56
> kernel: cdb: 12 00 00 00 38 00 00 00 00 00 00 00 00 00 00 00 

Wonderful! So this is an INQUIRY command, yet the WRITE bit is set. The
drive gets really confused about that, for good reason. The question is
where that write bit comes from, it looks really odd. Additionally, we
have killed ->bio but ->biotail still looks valid. Perhaps it's some of
the error handling that got screwed.

> as for the lock up, the ripping process never completes, it starts and
> then it hangs somewhere in the middle of the track. it could be that
> the disk has some problems. anyway, abort execution doesn't work until
> i physically eject the cd from the drive (which seems to be an
> improvement from a couple of rc's ago). hope this helps.

It helps a lot, thanks! I may ask you to retest with another patch, if
you don't mind.

-- 
Jens Axboe

