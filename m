Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315102AbSDWJSZ>; Tue, 23 Apr 2002 05:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315109AbSDWJSY>; Tue, 23 Apr 2002 05:18:24 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:31497 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S315102AbSDWJSX>;
	Tue, 23 Apr 2002 05:18:23 -0400
Date: Tue, 23 Apr 2002 11:18:09 +0200
From: Jens Axboe <axboe@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Miles Lane <miles@megapathdsl.net>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.9 -- OOPS in IDE code (symbolic dump and boot log included)
Message-ID: <20020423091809.GM810@suse.de>
In-Reply-To: <1019549894.1450.41.camel@turbulence.megapathdsl.net> <3CC51494.8040309@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23 2002, Martin Dalecki wrote:
> Miles Lane wrote:
> >I should probably add the /proc/ksyms snapshotting stuff to 
> >get the module information for you as well.  I hope this 
> >current batch of info helps, for starters.
> >
> >ksymoops 2.4.4 on i686 2.4.7-10.  Options used
> >     -v /usr/src/linux/vmlinux (specified)
> >     -K (specified)
> >     -L (specified)
> >     -o /lib/modules/2.5.9/ (specified)
> >     -m /boot/System.map-2.5.9 (specified)
> 
> 
> Looks like the oops came from module code.
> Which modules did you use: ide-flappy and ide-scsi are still
> in need of the same medication ide-cd got.

Martin,

There are several 'issues' with the ide-cd changes, in fact I think they
are horrible. I'll take part of the blame for that, I'll explain.

The ata_ar_get() doesn't belong inside the do_request() strategies, the
reason I did that for ide-disk was to get going on the tcq stuff and not
spend too much time rewriting the ide request handling at that point. It
was _never_ meant to propagate into the other ide drivers, and in fact
the code in ide-disk has several tcq specific parts that really cannot
work in ide-cd. Such as (ide-cd.c:ide_cdrom_do_request()):

	spin_lock...

	ar = ata_ar_get()
	if (!ar) {
		spin_unlock;
		return ide_started;
	}
	...

ide-disk guarentees that if ata_ar_get() fails, it's because we have
some pending commands on the drive. The ide_started is bogus too, in
this context it really should be ide_didnt_start_jack, but it works for
ide-disk because of the above assumptions.

Don't tell me you can read ide_cdrom_do_request() right now without a
barf bag :-)

I'd suggest moving the ata_ar_get() at the ide_queue_commands() level,
and just pass { drive, ar } to the do_request() strategies. That's also
why ide-disk.c:idedisk_do_request() has this comment:

	/*
	 * get a new command (push ar further down to avoid grabbing
	 * lock here
	 */
	spin_lock_irqsave(DRIVE_LOCK(drive), flags);

	ar = ata_ar_get(drive);
	...

I've been meaning to do this once tcq settled down, just didn't get
around to it yet. But please don't start moving stuff like this into
ide-cd too.

-- 
Jens Axboe

