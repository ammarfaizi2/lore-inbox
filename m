Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbTFGBxf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 21:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbTFGBxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 21:53:34 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:46090
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S262493AbTFGBxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 21:53:33 -0400
Date: Fri, 6 Jun 2003 18:55:09 -0700 (PDT)
From: Andre Hedrick <andre@pyxtechnologies.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, axboe@suse.de,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IDE Power Management, try 2
In-Reply-To: <Pine.SOL.4.30.0306051604320.18218-100000@mion.elka.pw.edu.pl>
Message-ID: <Pine.LNX.4.10.10306061828020.21521-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



You mean more like a "task management call".

On Thu, 5 Jun 2003, Bartlomiej Zolnierkiewicz wrote:

> 
> 
> On 5 Jun 2003, Benjamin Herrenschmidt wrote:
> 
> > Ok, Here's the new one.
> >
> > However, I'm not completely happy with it yet. Bart, as you suggested, I
> 
> Yeah, I am not happy too.
> 
> > moved the state value to drive in order to keep a normal taskfile struct
> > in rq->special. But that has a drawback: The request beeing re-fetched
> > from the queue on each step, it goes through start_request for each of
> > them. So I needed a way to know when is the "first pass" so I could
> > initialize drive->pm_step properly. I don't want to initialize it
> > prior to queuing the request as it would be racy. In fact, that pm_step
> > is really a property of the request itself.
> >
> > I had to add yet another rq->flags bit for that, and I think that sucks
> 
> You don't have if you use additional, default pm_state (on == 0).
> This sucks too, but a bit less.
> 
> > Also, currently, I'm not passing the "state" argument of the PM callback
> > to the PM request. That argument would be needed if we ever wanted to
> > distinguish between S1,S2,S3,S4.... For example, that could be used to
> > skip the STANDBY pass on suspend-to-disk to avoid the disk spinning down
> > and back up (suspend-to-disk is slow enough already ;)
> >
> > So I'm considering going back to putting some custom pm state structure
> > in rq->special, but having this structure hold a taskfile structure as
> > it's first entry so it is transparent to the taskfile interrupt
> > handlers. It's not the prettiest thing, but unless we add more fields
> > to struct request (which would be an option too since those PM requests
> > could be used by _any_ block driver to implement proper power
> > management).
> >
> > Jens, Bart, what do you think ? Should I add pm_step & pm_state to
> > struct request ? Do the "extended taskfile structure" thing ? Or just
> > keep things like they are in this new patch and forget about carrying
> > the PM state value ?
> 
> I think extending struct request is the way to go,
> pm_step & pm_state or even pointer to rq_pm_struct.
> 
> > I also added another rq->flags bit for requests forced at the head of
> > the queue with ide_preempt. This is typically for sense requests done
> > by ide-cd (though I also spotted a user in the tcq stuff). I need that
> > to make sure that if such a request ever happens to be pushed in front
> > of the current PM request (with the drive->blocked flag already set),
> > we don't enter an endless loop, fetching that new request and dropping
> > it right away because we only accept PM requests from the queue once
> > the drive is suspended.
> 
> Jens, I think generic version of ide_do_drive_cmd() would be useful for
> other block devices, what do you think?
> 
> Regards,
> --
> Bartlomiej
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

