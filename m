Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266042AbUAWJfn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 04:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266279AbUAWJfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 04:35:43 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:29906 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266042AbUAWJfb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 04:35:31 -0500
Date: Fri, 23 Jan 2004 10:35:25 +0100
From: Jens Axboe <axboe@suse.de>
To: Pascal Schmidt <der.eremit@email.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make ide-cd handle non-2kB sector sizes
Message-ID: <20040123093525.GP2734@suse.de>
References: <Pine.LNX.4.44.0401222014390.1296-100000@neptune.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401222014390.1296-100000@neptune.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 22 2004, Pascal Schmidt wrote:
> 
> Hello Jens,
> 
> as I suspected, ide-cd doesn't want to play with my 512 byte sector
> MO discs. You asked me whether I could cook up a patch to support
> different hardware sector sizes, and here it is.
> 
> I've tested it with a 230 MB MO disc, which uses 512 byte sectors.
> I filled the whole disk, then ejected - reinsert - fsck - read and
> compare. Everything worked without problems. Then I inserted a
> 640 MB MO disc, which uses 2048 byte sectors, and went through the
> same procedure. No problems either, so switching between different
> sector sizes appears to work.
> 
> I've also tested with DVDs and CD-ROMs, which continue to work like
> before the patch.
> 
> Without this patch, I only get tons of I/O errors when trying to read
> or write the 512 byte sector disc.
> 
> Please check the logic of my changes.

It's a good first start, thanks for doing this. You really want to be
storing this info in the queue, though, there's a hardsector size just
for this very purpose. That way other layers know about the hardware
sector size as well, not just ide-cd. And you get other things right for
free as well, for instance ide_cdrom_prep_fs() needs a correct hardware
block size or it will build wrong cdbs.

>  static ide_startstop_t cdrom_start_write(ide_drive_t *drive, struct request *rq)
>  {
>  	struct cdrom_info *info = drive->driver_data;
> +	byte sectors_per_frame = CDROM_STATE_FLAGS(drive)->sectors_per_frame;
>  
>  	/*
> -	 * writes *must* be 2kB frame aligned
> +	 * writes *must* be 2kB frame aligned if not MO
>  	 */
> -	if ((rq->nr_sectors & 3) || (rq->sector & 3)) {
> -		cdrom_end_request(drive, 0);
> -		return ide_stopped;
> -	}
> +	if (!CDROM_CONFIG_FLAGS(drive)->mo_drive)
> +		if ((rq->nr_sectors & 3) || (rq->sector & 3)) {
> +			cdrom_end_request(drive, 0);
> +			return ide_stopped;
> +		}

Hmm, you made it a bit more confusing. It should read that writes must
be hardware sector aligned. Something ala

	if ((rq->nr_sectors << 9) & (sector_size - 1) ||
	    (rq->sector & ((sector_size >> 9) - 1)))
		problem

> -	set_capacity(drive->disk, toc->capacity * SECTORS_PER_FRAME);
> +	set_capacity(drive->disk, toc->capacity * sectors_per_frame);
> +
> +	if (CDROM_STATE_FLAGS(drive)->sectors_per_frame != sectors_per_frame)
> +		printk(KERN_INFO "%s: new hardware sector size %lu\n",
> +			drive->name, sectors_per_frame << 9);

if you feel you must print this, then do it in the same line as the
other cdrom info printed.

-- 
Jens Axboe

