Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314065AbSEMPi0>; Mon, 13 May 2002 11:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314068AbSEMPiZ>; Mon, 13 May 2002 11:38:25 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:27627 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S314065AbSEMPiW>;
	Mon, 13 May 2002 11:38:22 -0400
Date: Mon, 13 May 2002 17:38:02 +0200
From: Jens Axboe <axboe@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.15 IDE 62
Message-ID: <20020513153802.GB17509@suse.de>
In-Reply-To: <Pine.LNX.4.44.0205052046590.1405-100000@home.transmeta.com> <3CDFAEC0.6050403@evision-ventures.com> <20020513134832.GV1106@suse.de> <3CDFB962.5070600@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13 2002, Martin Dalecki wrote:
> Uz.ytkownik Jens Axboe napisa?:
> >On Mon, May 13 2002, Martin Dalecki wrote:
> >
> >>Mon May 13 12:38:11 CEST 2002 ide-clean-62
> >>
> >>- Add missing locking around ide_do_request in do_ide_request().
> >
> >
> >This is broken, do_ide_request() is already called with the request lock
> >held. tq_disk run -> generic_unplug_device (grab lock) ->
> >__generic_unplug_device -> do_ide_request(). You just introduced a
> >deadlock.
> >
> >This code would have caused hangs or massive corruption immediately if
> >ide_lock wasn't ready held there. Not to mention instant spin_unlock
> >BUG() triggers in queue_command()
> >
> 
> Oops. Indeed I see now that the ide_lock is exported to
> the upper layers above it in ide-probe.c
> 
> blk_init_queue(q, do_ide_request, &ide_lock);
> 
> But this is problematic in itself, since it means that
> we are basically serialiazing between *all* requests
> on all channels.

Correct.

> So I think we should have per channel locks on this level
> right? This is anyway our unit for serialization.
> (I'm just surprised that blk_init_queue() doesn't
> provide queue specific locking and relies on exported
> locks from the drivers...)

Sure go ahead and fine grain it, I had no time to go that much into
detail when ripping out io_request_lock. A drive->lock passed to
blk_init_queue would do nicely.

But beware that ide locking is a lot nastier than you think. I saw other
irq changes earlier, I just want to make sure that you are _absolutely_
certain that these changes are safe??

-- 
Jens Axboe

