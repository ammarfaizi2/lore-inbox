Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319058AbSHFLAU>; Tue, 6 Aug 2002 07:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319059AbSHFLAU>; Tue, 6 Aug 2002 07:00:20 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:29130 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S319058AbSHFLAS>;
	Tue, 6 Aug 2002 07:00:18 -0400
Date: Tue, 6 Aug 2002 13:03:54 +0200
From: Jens Axboe <axboe@suse.de>
To: martin@dalecki.de
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.30 IDE 113
Message-ID: <20020806110354.GE1323@suse.de>
References: <13AC5F92253@vcnet.vc.cvut.cz> <20020806104414.GC1132@suse.de> <3D4FA924.3030601@evision.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D4FA924.3030601@evision.ag>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06 2002, Marcin Dalecki wrote:
> Uz.ytkownik Jens Axboe napisa?:
> >On Tue, Aug 06 2002, Petr Vandrovec wrote:
> >
> >>>After all ide_raw_taskfile only gets used for REQ_SPECIAL request
> >>>types. This does *not* contain normal data request from block IO.
> >>>As of master slave issues - well we have the data pre allocated per
> >>>device not per channel! If q->request_fn would properly return the
> >>>error count instead of void, we could even get rid ot the
> >>>checking for rq->errors after finishment... But well that's
> >>>entierly different story.
> >>
> >>For example do_cmd_ioctl() invokes ide_raw_taskfile, without any locking.
> >>Two programs, both issuing HDIO_DRIVE_CMD at same time, will compete
> >>over one drive->srequest struct: you'll get same drive->srequest structure
> >>submitted twice to blk_insert_request (hm, Jens, will this trigger
> >>BUG, or will this just damage request list?).
> >
> >
> >Just silently damage request list. We _could_ easily add code to detect
> >this, but it's not been a problem in the past so not worth looking for.
> >
> >AFAICS, Petr is completely right wrt this race.
> 
> For the ioctl case yes. But:
> 
> 1. We already look for blk_queue_empty there.
> 2. We have just to deal properly with the queue plugging there
> to close it up.

I don't know what you mean here. Clearly this is an ide problem. If you
have a statically allocated request, you _must_ serialize that yourself.

> 3. I will just add spin locking on ide_lock to maintain that no two
> ioctl can overlapp at all.

Agrh god no. So you'll spin waiting for the ioctl to complete?

>From ide_raw_taskfile(), the right way to do it is:

	struct request *rq = blk_get_request(...);

This gets _everything_ right.

BTW, _glad to see you got rid of the horrible insert-and-execute stuff
in ide_raw_taskfile(). That was a layering violation.

> OK?

Not likely :-)

-- 
Jens Axboe

