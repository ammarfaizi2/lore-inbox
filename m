Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266558AbUAWOCF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 09:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266559AbUAWOCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 09:02:05 -0500
Received: from mail1-106.ewetel.de ([212.6.122.106]:34239 "EHLO
	mail1.ewetel.de") by vger.kernel.org with ESMTP id S266558AbUAWOCC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 09:02:02 -0500
Date: Fri, 23 Jan 2004 15:01:59 +0100 (CET)
From: Pascal Schmidt <der.eremit@email.de>
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make ide-cd handle non-2kB sector sizes
In-Reply-To: <20040123093525.GP2734@suse.de>
Message-ID: <Pine.LNX.4.44.0401231456450.944-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jan 2004, Jens Axboe wrote:

> It's a good first start, thanks for doing this. You really want to be
> storing this info in the queue, though, there's a hardsector size just
> for this very purpose. That way other layers know about the hardware
> sector size as well, not just ide-cd. And you get other things right for
> free as well, for instance ide_cdrom_prep_fs() needs a correct hardware
> block size or it will build wrong cdbs.

Hmmm. I'm doing

	blk_queue_hardsect_size(drive->queue, sectors_per_frame << 9);

inside of cdrom_read_toc, is that not enough? Or do you mean that
I should only store it in the queue and not also in cdrom_state_flags?

> Hmm, you made it a bit more confusing. It should read that writes must
> be hardware sector aligned. Something ala
> 
> 	if ((rq->nr_sectors << 9) & (sector_size - 1) ||
> 	    (rq->sector & ((sector_size >> 9) - 1)))
> 		problem

I'll change that.

> > -	set_capacity(drive->disk, toc->capacity * SECTORS_PER_FRAME);
> > +	set_capacity(drive->disk, toc->capacity * sectors_per_frame);
> > +
> > +	if (CDROM_STATE_FLAGS(drive)->sectors_per_frame != sectors_per_frame)
> > +		printk(KERN_INFO "%s: new hardware sector size %lu\n",
> > +			drive->name, sectors_per_frame << 9);
> 
> if you feel you must print this, then do it in the same line as the
> other cdrom info printed.

This happens on disc change, no other info is normally printed. But this
printk can probably go away, I just put it there for debugging.

-- 
Ciao,
Pascal

