Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264433AbUBOJmi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 04:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264437AbUBOJmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 04:42:38 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:59629 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264433AbUBOJmf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 04:42:35 -0500
Date: Sun, 15 Feb 2004 10:42:24 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mh@nadir.org,
       linux-kernel@vger.kernel.org
Subject: Re: oops w/ 2.6.2-mm1 on ppc32
Message-ID: <20040215094224.GY26397@suse.de>
References: <20040215074140.GA3840@nadir.org> <1076831383.6958.38.camel@gaston> <20040215001019.33e4089b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040215001019.33e4089b.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 15 2004, Andrew Morton wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >
> > On Sun, 2004-02-15 at 18:41, Marc Heckmann wrote:
> > > It happened while the machine was waking up from sleep. There were no
> > > UDF or ISO filesystems mounted at the time, in fact, there wasn't even
> > > a cd in the drive. The "autorun" process was running though (polls the
> > > cdrom drive, to see if a disc has been inserted...). There were some
> > > request timeouts on the cdrom drive (hdc) just before, it went to
> > > sleep (system was idle at the time, I wasn't even at home).
> > > 
> > > Here is the kernel output before and after the machine went to sleep. The Oops
> > > is at the bottom.
> > 
> > Looks like CD went berserk, and something didn't deal with the
> > error correctly... I don't know those code path in there
> > very well... Can you paste more of the ide-cd errors,
> > those are weird.
> 
> Note that isofs_fill_super() calls sb_bread() before setting the blocksize.
> For this it is relying on blockdev.bd_block_size being set up
> appropriately.
> 
> Which all tends to imply that the underlying queue's ->hardsect_size is
> very wrong.
> 
> The code which is responsible for setting up the queue's hardsect_size
> appears to live in cdrom_read_toc():
> 
> 	/* Check to see if the existing data is still valid.
> 	   If it is, just return. */
> 	(void) cdrom_check_status(drive, sense);
> 
> 	if (CDROM_STATE_FLAGS(drive)->toc_valid)
> 		return 0;
> 
> 	/* Try to get the total cdrom capacity and sector size. */
> 	stat = cdrom_read_capacity(drive, &toc->capacity, &sectors_per_frame,
> 				   sense);
> 	if (stat)
> 		toc->capacity = 0x1fffff;
> 
> 	set_capacity(drive->disk, toc->capacity * sectors_per_frame);
> 	blk_queue_hardsect_size(drive->queue,
> 				sectors_per_frame << SECTOR_BITS);
> 
> I'm wondering about that `return 0;' in there.  That will return "success"
> even though we haven't set up half the things which should have been set
> up.
> 
> Jens, should we be returning some sort of error code there?

I'll have a look to see if it can go wrong, but ->toc_valid should never
be set if the hardsector stuff etc hasn't been set up yet.

-- 
Jens Axboe

