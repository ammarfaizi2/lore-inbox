Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313190AbSDYRZU>; Thu, 25 Apr 2002 13:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313217AbSDYRZT>; Thu, 25 Apr 2002 13:25:19 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:23825 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S313190AbSDYRZS>;
	Thu, 25 Apr 2002 13:25:18 -0400
Date: Thu, 25 Apr 2002 19:25:08 +0200
From: Jens Axboe <axboe@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Miles Lane <miles@megapathdsl.net>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.9 -- OOPS in IDE code (symbolic dump and boot log included)
Message-ID: <20020425172508.GK3542@suse.de>
In-Reply-To: <1019549894.1450.41.camel@turbulence.megapathdsl.net> <3CC51494.8040309@evision-ventures.com> <1019583551.1392.5.camel@turbulence.megapathdsl.net> <1019584497.1393.8.camel@turbulence.megapathdsl.net> <3CC66794.5040203@evision-ventures.com> <20020424091151.GD812@suse.de> <3CC7E358.8050905@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25 2002, Martin Dalecki wrote:
> Uz.ytkownik Jens Axboe napisa?:
> >On Wed, Apr 24 2002, Martin Dalecki wrote:
> 
> >>OK I assume that the oops happens inside the ide-scsi module.
> >>This will be fixed in one of the forthcomming patch sets.
> >
> >
> >Are you sure this isn't just due to ->special being set, and
> >ide_end_request() assuming it's an ar? From ide-cd, that is.
> 
> 
> Yes I know it's all the same. However unfortunately
> it's *not easy* to back out the ->special use from
> the drivers that do it. We have the following sutuation:
> 
> 1. Generic BIO code checking for ->special and deciding whatever
> it should trying to merge request or not.
> 
> 2. Gneric ATA code setting ->special for ata_request passing.
> 
> 3. CD-ROM ATAPI code using ->special for passing packet commands
> and failed commands.
> 
> 4. ide-scsi using it for the same purspose as CD-ROM
> 
> 5. ide-floppy not using it at all buf abusing the ->buffer member
>    for precisely the same purpose.
> 
> And unfortunately there is *no* easy solution for any of the
> above circumstances without breaking far too many things.

You don't _have_ to back out the ->special usage. As I mentioned, it was
always just a quick hack for ide-disk so I didn't have to change every
single driver out there.

There are two options, as I see it:

- Keep ata_request as an ide-disk speciality. This is pretty trivial
  even though other drivers use ->special, because the ata_ar_put()
  path simply needs to do

	struct ata_request *ar = rq->special;

	if (ar && drive->media == ide_disk)
		ata_ar_put(ar);

  and that is it.

- Make the ata_request the general means of passing down request in the
  IDE layer -- start by making hwgroup->rq into hwgroup->ar and _never_
  store ar in ->special (you don't have to, you will always just go from
  ar -> rq, which is of course ar->ar_rq). This is what I wanted to do.

> The conclusion simply is: unless the above issues are fixed
> the TCQ stuff has simply to be backed out again anbd live
> separately from the main code chain. :-(.

If you didn't persist on pushing half-done stuff to Linus all the time,
I would have had the time to implement this properly... Now you keep
doing hackish work-arounds to make things limp along. So please calm
down for a moment, sick back, and think about it. It's a heck of a lot
better than going full throttle with an axe.

-- 
Jens Axboe

