Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315137AbSDWJzD>; Tue, 23 Apr 2002 05:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315164AbSDWJzC>; Tue, 23 Apr 2002 05:55:02 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:28421 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S315137AbSDWJzB>;
	Tue, 23 Apr 2002 05:55:01 -0400
Date: Tue, 23 Apr 2002 11:54:59 +0200
From: Jens Axboe <axboe@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Miles Lane <miles@megapathdsl.net>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.9 -- OOPS in IDE code (symbolic dump and boot log included)
Message-ID: <20020423095459.GB810@suse.de>
In-Reply-To: <1019549894.1450.41.camel@turbulence.megapathdsl.net> <3CC51494.8040309@evision-ventures.com> <20020423091809.GM810@suse.de> <3CC51EA7.5040801@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23 2002, Martin Dalecki wrote:
> >Martin,
> >
> >There are several 'issues' with the ide-cd changes, in fact I think they
> >are horrible. I'll take part of the blame for that, I'll explain.
> 
> Well... I refer you to my change long, where I indeed admitted directly
> that it's an ugly band aid ;-).

Didn't read that :)

> >The ata_ar_get() doesn't belong inside the do_request() strategies, the
> >reason I did that for ide-disk was to get going on the tcq stuff and not
> >spend too much time rewriting the ide request handling at that point. It
> 
> Right. it belongs one level up. The request handling should
> possible learn whatever it it's handling ATA or ATAPI devices.
> In esp. the ide_start_dma() changes where no pretty...

Why would you care what type of transport they use??

> >was _never_ meant to propagate into the other ide drivers, and in fact
> >the code in ide-disk has several tcq specific parts that really cannot
> >work in ide-cd. Such as (ide-cd.c:ide_cdrom_do_request()):
> >
> >	spin_lock...
> >
> >	ar = ata_ar_get()
> >	if (!ar) {
> >		spin_unlock;
> >		return ide_started;
> >	}
> >	...
> >
> >ide-disk guarentees that if ata_ar_get() fails, it's because we have
> >some pending commands on the drive. The ide_started is bogus too, in
> >this context it really should be ide_didnt_start_jack, but it works for
> >ide-disk because of the above assumptions.
> 
> Fortunately it can't happen becouse the other devices don't
> support TCQ.

Right, it should rather be a bug trigger in ide-cd... Doesn't matter, it
will be killed soon.

> >I'd suggest moving the ata_ar_get() at the ide_queue_commands() level,
> >and just pass { drive, ar } to the do_request() strategies. That's also
> >why ide-disk.c:idedisk_do_request() has this comment:
> 
> Yes this was my intention for the future. The only driver which will have
> problems with this is ide-scsi.c - it's not obvious (at least right now)
> to me how to change the do_request signature there.

How so? Even with pusing ar at the level discussed here, ide-xx.c does
really not need to care. Change the do_request() strategy to just take
the drive and ar, driver is free to just:

	/* something to this effect */
	struct request *rq = ar->ar_rq;
	sector_t block = ar->ar_block;

and the rest could remain unchanged. It's up to the driver how far it
wants to take this. The only "problem" is that rq->special will always
contain the pointer to the ar used, so none of them can touch it.

> >	/*
> >	 * get a new command (push ar further down to avoid grabbing
> >	 * lock here
> >	 */
> >	spin_lock_irqsave(DRIVE_LOCK(drive), flags);
> >
> >	ar = ata_ar_get(drive);
> >	...
> >
> >I've been meaning to do this once tcq settled down, just didn't get
> >around to it yet. But please don't start moving stuff like this into
> >ide-cd too.
> 
> You notice that I didn't even care to change the write request code-path?
> BTW.> It became obvious to me as well that even all the drivers out
> there not supporting TCQ will have to get the TCQ parts of struct ata_device
> initialized - with a trivial queue depth. drive->tcq should therefore be 
> really just a memmber of struct ata_device()..

I disagree, there's no need to have a ->tcq if you don't support
queueing. The "trivial queue depth" is already done, it's called
drive->queue_depth and is 1 for non-tcq (or tcq with depth 1 :-).

-- 
Jens Axboe

