Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751505AbVKPRJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbVKPRJy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 12:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbVKPRJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 12:09:53 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:8975 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751496AbVKPRJw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 12:09:52 -0500
Date: Wed, 16 Nov 2005 18:10:51 +0100
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Mike Christie <michaelc@cs.wisc.edu>, Jeff Garzik <jgarzik@pobox.com>,
       Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org,
       lkml <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] libata error handling fixes (ATAPI)
Message-ID: <20051116171051.GP7787@suse.de>
References: <4379AA5B.1060900@pobox.com> <4379B28E.9070708@gmail.com> <4379C062.3010302@pobox.com> <20051115120016.GD7787@suse.de> <437A2814.1060308@cs.wisc.edu> <20051115184131.GJ7787@suse.de> <20051116124035.GX7787@suse.de> <58cb370e0511160704w4803a085h7bd6ab352d8c94e6@mail.gmail.com> <20051116153119.GN7787@suse.de> <58cb370e0511160806t1defd373w981e213d1cdeb2b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e0511160806t1defd373w981e213d1cdeb2b3@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16 2005, Bartlomiej Zolnierkiewicz wrote:
> On 11/16/05, Jens Axboe <axboe@suse.de> wrote:
> > On Wed, Nov 16 2005, Bartlomiej Zolnierkiewicz wrote:
> > > On 11/16/05, Jens Axboe <axboe@suse.de> wrote:
> > >
> > > > I updated that patch, and converted IDE and SCSI to use it. See the
> > > > results here:
> > > >
> > > > http://brick.kernel.dk/git/?p=linux-2.6-block.git;a=shortlog;h=blk-softirq
> > >
> > > I like it but:
> > >
> > > * "we know it's either an FS or PC request" assumption in
> > >   ide_softirq_done() is really wrong
> >
> > It used to be correct :-)
> 
> Sorry but it has been always like that,
> other requests also pass through ide_end_request()
> (which of course needs fixing).

You misunderstand, for calls to blk_complete_request() it wasn't true
initially since it always obyed rq_all_done() (which returns 0 for
non-fs and non-pc requests).

> > Irk it's nasty, since it basically means we have to hold ide_lock over
> > the entire functions looking at hwgroup->rq.
> >
> > It's ok for __ide_end_request() to be entered with the ide_lock held,
> > the costly affair is usually completing the request. Which now happens
> > outside of the lock.
> 
> We should get rid of ide_preempt later.
> 
> This will also allow us to remove ide_do_drive_cmd()
> and use blk_execute_rq() exclusively.

That would be very nice! Reminds me that there might still be a race
with head insertion and REQ_STARTED request in front in the block layer,
that needs inspection. But killing ide_do_drive_cmd() would be very
nice.

-- 
Jens Axboe

