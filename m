Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315148AbSDWJpp>; Tue, 23 Apr 2002 05:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315147AbSDWJpo>; Tue, 23 Apr 2002 05:45:44 -0400
Received: from [195.63.194.11] ([195.63.194.11]:31244 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315146AbSDWJpn>; Tue, 23 Apr 2002 05:45:43 -0400
Message-ID: <3CC51EA7.5040801@evision-ventures.com>
Date: Tue, 23 Apr 2002 10:43:19 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Miles Lane <miles@megapathdsl.net>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.9 -- OOPS in IDE code (symbolic dump and boot log included)
In-Reply-To: <1019549894.1450.41.camel@turbulence.megapathdsl.net> <3CC51494.8040309@evision-ventures.com> <20020423091809.GM810@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Martin,
> 
> There are several 'issues' with the ide-cd changes, in fact I think they
> are horrible. I'll take part of the blame for that, I'll explain.

Well... I refer you to my change long, where I indeed admitted directly
that it's an ugly band aid ;-).

> The ata_ar_get() doesn't belong inside the do_request() strategies, the
> reason I did that for ide-disk was to get going on the tcq stuff and not
> spend too much time rewriting the ide request handling at that point. It

Right. it belongs one level up. The request handling should
possible learn whatever it it's handling ATA or ATAPI devices.
In esp. the ide_start_dma() changes where no pretty...

> was _never_ meant to propagate into the other ide drivers, and in fact
> the code in ide-disk has several tcq specific parts that really cannot
> work in ide-cd. Such as (ide-cd.c:ide_cdrom_do_request()):
> 
> 	spin_lock...
> 
> 	ar = ata_ar_get()
> 	if (!ar) {
> 		spin_unlock;
> 		return ide_started;
> 	}
> 	...
> 
> ide-disk guarentees that if ata_ar_get() fails, it's because we have
> some pending commands on the drive. The ide_started is bogus too, in
> this context it really should be ide_didnt_start_jack, but it works for
> ide-disk because of the above assumptions.

Fortunately it can't happen becouse the other devices don't
support TCQ.

> Don't tell me you can read ide_cdrom_do_request() right now without a
> barf bag :-)

Ohhh. there are a lot of other things I'm unhappy about there as well.

> I'd suggest moving the ata_ar_get() at the ide_queue_commands() level,
> and just pass { drive, ar } to the do_request() strategies. That's also
> why ide-disk.c:idedisk_do_request() has this comment:

Yes this was my intention for the future. The only driver which will have
problems with this is ide-scsi.c - it's not obvious (at least right now)
to me how to change the do_request signature there.

> 	/*
> 	 * get a new command (push ar further down to avoid grabbing
> 	 * lock here
> 	 */
> 	spin_lock_irqsave(DRIVE_LOCK(drive), flags);
> 
> 	ar = ata_ar_get(drive);
> 	...
> 
> I've been meaning to do this once tcq settled down, just didn't get
> around to it yet. But please don't start moving stuff like this into
> ide-cd too.

You notice that I didn't even care to change the write request code-path?
BTW.> It became obvious to me as well that even all the drivers out
there not supporting TCQ will have to get the TCQ parts of struct ata_device
initialized - with a trivial queue depth. drive->tcq should therefore be really
just a memmber of struct ata_device()..

