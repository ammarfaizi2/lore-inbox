Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129108AbRBVWTY>; Thu, 22 Feb 2001 17:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129554AbRBVWTP>; Thu, 22 Feb 2001 17:19:15 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:36613 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S129108AbRBVWTM>; Thu, 22 Feb 2001 17:19:12 -0500
Date: Thu, 22 Feb 2001 18:32:40 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jens Axboe <axboe@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: ll_rw_block/submit_bh and request limits
In-Reply-To: <Pine.LNX.4.10.10102221052000.8403-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0102221824480.2401-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 22 Feb 2001, Linus Torvalds wrote:

> 
> 
> On Thu, 22 Feb 2001, Jens Axboe wrote:
> 
> > On Thu, Feb 22 2001, Marcelo Tosatti wrote:
> > > The following piece of code in ll_rw_block() aims to limit the number of
> > > locked buffers by making processes throttle on IO if the number of on
> > > flight requests is bigger than a high watermaker. IO will only start
> > > again if we're under a low watermark.
> > > 
> > >                 if (atomic_read(&queued_sectors) >= high_queued_sectors) {
> > >                         run_task_queue(&tq_disk);
> > >                         wait_event(blk_buffers_wait,
> > >                         	atomic_read(&queued_sectors) < low_queued_sectors);
> > >                 }
> > > 
> > > 
> > > However, if submit_bh() is used to queue IO (which is used by ->readpage()
> > > for ext2, for example), no throttling happens.
> > > 
> > > It looks like ll_rw_block() users (writes, metadata reads) can be starved
> > > by submit_bh() (data reads). 
> > > 
> > > If I'm not missing something, the watermark check should be moved to
> > > submit_bh(). 
> > 
> > We might as well put it there, the idea was to not lock this one
> > buffer either but I doubt this would make any different in reality :-)
> 
> I'd prefer for this check to be a per-queue one.
> 
> Right now a slow device (like a floppy) would artifically throttle a fast
> one, if I read the above right. So instead of moving it down the
> call-chain, I'd rather remove the check completely as it looks wrong to
> me.
> 
> Now, if people want throttling, I'd much rather see that done per-queue.
> 
> (There's another level of throttling that migth make sense: right now the
> swap-out code has this "nr_async_pages" throttling which is very different
> from the queue throttling. It might make sense to move that _VM_-level
> throttling to writepage too - so that syncing of dirty mmap's will not
> cause an overload of pages in flight. This was one of the reasons I
> changed the semantics of write-page - so that shared mappings could do
> that kind of smoothing too).

And what about write() and read() if you do throttling with nr_async_pages ?

The current scheme inside the block-layer throttles write()'s based on the
number of locked buffers in _main memory_. 






