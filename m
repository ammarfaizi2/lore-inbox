Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751287AbWCaUWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbWCaUWE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 15:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbWCaUWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 15:22:04 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:62217 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751287AbWCaUWB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 15:22:01 -0500
Date: Fri, 31 Mar 2006 22:22:03 +0200
From: Jens Axboe <axboe@suse.de>
To: Chris Caputo <ccaputo@alt.net>
Cc: erich <erich@areca.com.tw>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: about ll_rw_blk.c of void generic_make_request(struct bio *bio)
Message-ID: <20060331202202.GH14022@suse.de>
References: <001d01c65302$0fee8e10$b100a8c0@erich2003> <20060330155804.GP13476@suse.de> <Pine.LNX.4.64.0603311700310.14317@nacho.alt.net> <Pine.LNX.4.64.0603311748010.14317@nacho.alt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603311748010.14317@nacho.alt.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31 2006, Chris Caputo wrote:
> On Fri, 31 Mar 2006, Chris Caputo wrote:
> > On Thu, 30 Mar 2006, Jens Axboe wrote:
> > > I can't really say, from my recollection of leafing over lkml emails, I
> > > seem to recall someone saying he hit this with a newer kernel where as
> > > the older one did not?
> > > 
> > > What are the sectors exactly it complains about, eg the full line you
> > > see?
> > 
> > I see:
> > 
> >   attempt to access beyond end of device
> >   sdb1: rw=0, want=134744080, limit=128002016
> 
> I believe the "rw=0" means that was a simple read request, and not a 
> read-ahead.

Correct.

> 128002016 equals about 62 gigs, which is the correct volume size:
> 
>   Filesystem           1K-blocks      Used Available Use% Mounted on
>   /dev/sdb1             62995364   2832696  56962620   5% /xxx
> 
>   /dev/sdb1 on /xxx type ext2 (rw,noatime)

How are you reproducing this, through the file system (reading files),
or reading the device? If the former, is the file system definitely
sound - eg does it pass fsck?

> I'm at a loss as to why ext2 would want to read 3+ gigs past the end of 
> the volume or why the arcmsr driver setting max_sectors to be 4096 instead 
> of 512 makes a difference.

It's truly puzzing why the 4k vs 512 would make a difference, except if
the driver really doesn't support that large requests and corrupts the
data somehow. I'm having an extraordinarily hard time imaging how the
SCSI layer could even come up with such a bug.

So everything seems to point us getting wrong data from the hardware,
most likely because of a driver bug in either handling the larger
transfers or the hardware just not liking them very much.

> Erich, while using 4096 as the max_sectors count, in your lab can you
> make it so ll_rw_blk.c:handle_bad_sector() makes a call to
> dump_stack() after the printk's?  What does it show as the call trace?

Probably wont tell you much.

-- 
Jens Axboe

