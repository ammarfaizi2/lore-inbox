Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbVI1Skx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbVI1Skx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 14:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbVI1Skx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 14:40:53 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:10717 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1750723AbVI1Skw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 14:40:52 -0400
Date: Wed, 28 Sep 2005 14:40:51 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Readahead
In-Reply-To: <20050926212446.365778e3.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44L0.0509281303580.4491-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Sep 2005, Andrew Morton wrote:

> Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> >  Can somebody please tell me where the code is that performs optimistic
> >  readahead when a process does sequential reads on a block device?
> 
> mm/readahead.c:__do_page_cache_readahead() is the main one.  Use
> dump_stack() to be sure.
> 
> >  And can someone explain why those readahead calls are allowed to extend 
> >  beyond the end of the device?
> 
> It has a check in there for reads past the blockdev mapping's i_size. 
> Maybe i_size is wrong, or maybe the code is wrong, or maybe it's a
> different caller.

Thanks for the tip.  The problem I was chasing down was the system's
attempts to read beyond the end of a CD disc.  It turns out the
cause is partly in the block layer and partly in the cdrom drivers.

Here's what happened.  CDs have 2048-byte blocks, and I've got a disc 
containing nothing but a single data track (written with cdrecord) of 
326533 blocks.  (The original .iso was 326518 blocks long and I added 15 
blocks of padding.)

Oddly enough, the values recorded in the disc's Table Of Contents indicate
that the track is 326535 blocks.  Maybe this is normal for cdrecord or for
CDROMs in general -- I don't know.  Anyway, the cdrom drivers believe this
value and report a capacity that is 2 blocks too high.

When I try using dd with bs=2048 to read the very last actual block,
number 326532, the block layer of course issues a read request for an
entire 4 KB memory page.  The drive returns the first 2 KB of data
successfully and reports an error reading the second 2 KB, which is beyond 
the actual end of the track.

Now according to a comment in drivers/scsi/sr.c:

	/*
	 * The SCSI specification allows for the value
	 * returned by READ CAPACITY to be up to 75 2K
	 * sectors past the last readable block.
	 * Therefore, if we hit a medium error within the
	 * last 75 2K sectors, we decrease the saved size
	 * value.
	 */

The code to do this has some flaws, but I fixed them.  The result is that
the stored capacity is reduced to 326533 blocks, as it should be, the SCSI
driver calls end_that_request_chunk(req, 1, 2048), and then it requeues
the request in order to retry the remaining 2048 bytes.  This naturally
fails, and the driver calls end_that_request_chunk(req, 0, 2048).  The
upshot is that the dd process receives an error instead of getting the
2 KB of data as it should.

The _next_ time I use dd to read that block, it works perfectly.  The 
block layer only tries to read 2048 bytes and there's no problem.

So evidently the block layer doesn't like it when a transfer only
partially succeeds, even though that part includes everything up to the
(new) end of the device.  Can this be fixed?  I wouldn't know where to
begin.

It's also worth noting that the IDE cdrom driver does not fix up the 
capacity as the SCSI driver does.  It would be a good idea to copy over 
the code -- I can probably handle that.

Alan Stern

