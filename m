Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269046AbUIHJYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269046AbUIHJYt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 05:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269045AbUIHJYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 05:24:48 -0400
Received: from cantor.suse.de ([195.135.220.2]:44970 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269050AbUIHJYS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 05:24:18 -0400
Date: Wed, 8 Sep 2004 11:23:09 +0200
From: Jens Axboe <axboe@suse.de>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: bug in md write barrier support?
Message-ID: <20040908092309.GD2258@suse.de>
References: <20040903172414.GA6771@lst.de> <16697.4817.621088.474648@cse.unsw.edu.au> <20040904082121.GB2343@suse.de> <16699.48946.29579.495180@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16699.48946.29579.495180@cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 06 2004, Neil Brown wrote:
> On Saturday September 4, axboe@suse.de wrote:
> > On Sat, Sep 04 2004, Neil Brown wrote:
> > > On Friday September 3, hch@lst.de wrote:
> > > > md_flush_mddev just passes on the sector relative to the raid device,
> > > > shouldn't it be translated somewhere?
> > > 
> > > Yes.  md_flush_mddev should simply be removed.  
> > > The functionality should be, and largely is, in the individual
> > > personalities. 
> > 
> > Yes, sorry I was a little lazy there even though I followed the plugging
> > conversion :(
> > 
> > > Is there documentation somewhere on exactly what an issue_flush_fn
> > > should do (is it  allowed to sleep? what must happen before it is
> > > allowed to return, what is the "error_sector" for,  that sort of thing).
> > 
> > It is allowed to sleep, you should return when the flush is complete.
> > error_sector is the failed location, which really should be a dev,sector
> > tupple.
> 
> Could I get a little more information about this function please.
> I've read through the code, and there isn't much in the way of
> examples to follow: only reiserfs uses it, only scsi-disk and ide-disk
> supports it (I think).

That is correct. The current definition is to ensure that previously
sent writes are on disk. I hope to tie a range to it in the future, for
devices that can optimize the flush in that case. So for ide with write
back caching, it's currently a FLUSH_CACHE command. Ditto for SCSI. SCSI
with write through cache can make it a noop as well.

> It would seem that this is for write requests where b_end_io has already
> been called, indicating that the data is safe, but that maybe the data
> isn't really safe after-all, and blk_issue_flush needs to be called.

Right on.

> I would have thought that after b_end_io is called, that data should
> be safe anyway.  Not so?

Not necessarily, if you have write caching enabled.

> How do you tell a device: it is OK to just leave the data is cache,
> I'll call blk_issue_flush when I want it safe.

How would md know? The lower level driver knows what to do (if anything)
to ensure the data is safe.

> Is this related to barriers are all??

Yes and no. Currently it's used to fsync(), but can be used for
anything where you want to insert a flush point without having a piece
of data to tie it to.

-- 
Jens Axboe

