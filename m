Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315481AbSFEQOm>; Wed, 5 Jun 2002 12:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315517AbSFEQOl>; Wed, 5 Jun 2002 12:14:41 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:49377 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S315481AbSFEQOk>;
	Wed, 5 Jun 2002 12:14:40 -0400
Date: Wed, 5 Jun 2002 18:14:17 +0200
From: Jens Axboe <axboe@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.20 IDE 85
Message-ID: <20020605161417.GG16600@suse.de>
In-Reply-To: <Pine.LNX.4.33.0206021853030.1383-100000@penguin.transmeta.com> <3CFE0C16.1020203@evision-ventures.com> <20020605141717.GB16257@suse.de> <3CFE1974.9080509@evision-ventures.com> <20020605154853.GF16600@suse.de> <20020605155241.GD16257@suse.de> <3CFE29FE.90402@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05 2002, Martin Dalecki wrote:
> Jens Axboe wrote:
> >On Wed, Jun 05 2002, Jens Axboe wrote:
> >
> >>On Wed, Jun 05 2002, Martin Dalecki wrote:
> >>
> >>>Jens Axboe wrote:
> >>>
> >>>>On Wed, Jun 05 2002, Martin Dalecki wrote:
> >>>>
> >>>>AFAICS, you just introduced some nasty list races in the interrupt
> >>>>handlers. You must hold the queue locks when calling
> >>>>blkdev_dequeue_request() and end_that_request_last(), for instance.
> >>>>
> >>>
> >>>No. Please be more accurate. Becouse:
> >>>
> >>>1. If anything I have made existing races only "obvious".
> >>
> >>If anything, you've made a race you introduced earlier more obvious.
> >>
> >>
> >>>2. It is called in the context of do_ide_request or ide_raw_taskfile
> >>>  where we already have the lock.
> >>
> >>?? Both tcq and ata_special_intr look like interrupt handlers to me.
> >
> >
> >BTW, I wanted to look at the code (and not just read the patch), but
> >it's not clear from the patch what it is against. Where do you keep
> >older patches so I can get them? Maybe the ide code could do with a bit
> >of peer review :-)
> >
> 
> Well IDE 83 and 84 are already inside the bk repository at linux.bkbits.com.
> No as far as of now I don't have any public FTP or whatever area for
> the patches (Well send you everything in one go.)

Thanks. Just ask hpa for a kernel.org dir, if you don't have anywhere
else to keep it.

> And I of course agree that the code needs a peer review in this area.
> Adding the locking isn't difficult.

Of course not, discovering the missing locking is most of the work. And
of course acknowedging that there's a problem :-)

> However I wonder a bit whatever we couldn't just blkdev_dequeue_request()
> once at request handling start? We drag drive->rq around anyway...

I did that once a long time ago, but it was very broken because the IDE
code would end up in ide_do_request() several times at times before a
request was started. I think there are advantages both ways: leaving the
request on the queue until it is done allows the i/o scheduler to know
what the disk is currently working on. Removing it is potentially a bit
cleaner, however most of the reason for that has long been reworked in
2.5 (the plugging and head active stuff).

-- 
Jens Axboe

