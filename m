Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264289AbUAHIbS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 03:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264290AbUAHIbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 03:31:17 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:13289 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264289AbUAHIbP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 03:31:15 -0500
Date: Thu, 8 Jan 2004 09:31:12 +0100
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.1-rc2 ide barrier support
Message-ID: <20040108083112.GN16720@suse.de>
References: <20040107134323.GB16720@suse.de> <200401071945.04649.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401071945.04649.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07 2004, Bartlomiej Zolnierkiewicz wrote:
> On Wednesday 07 of January 2004 14:43, Jens Axboe wrote:
> > Bart, would you care to review the ide bits for sanity?
> 
> Yep, here is just a first sight...
>
> > +	struct request *flush_rq = &HWGROUP(drive)->wrq;
> 
> I want to remove drive->wrq in the future.

Yes I've wanted that, too, but only because of the ugly (and often racy)
multimode crap. I'm just considering wrq a 'reserve rq' to be used where
you cannot reliably get a new request atomically.

I'm open to any better ideas you have for this...

> > +	memset(drive->special_buf, 0, sizeof(drive->special_buf));
> > +
> > +	ide_init_drive_cmd(flush_rq);
> > +
> > +	flush_rq->flags = REQ_DRIVE_TASK;
> > +	flush_rq->buffer = drive->special_buf;
> > +	flush_rq->special = rq;
> > +	flush_rq->buffer[0] = WIN_FLUSH_CACHE;
> > +	flush_rq->nr_sectors = rq->nr_sectors;
> 
> I think you should try use REQ_DRIVE_TASKFILE,
> instead of adding drive->special_buf.

How does that change anything? I still need a command buffer, if I use
REQ_DRIVE_TASKFILE I need an even bigger one.

> > +/*
> > + * FIXME: probably move this somewhere else, name is bad too :)
> > + */
> > +static sector_t ide_get_error_location(ide_drive_t *drive, char *args)
> 
> This is probably useful in few other places.

Yeah, as the comment states I know it's not really in the right place.
Where do you want it? And any suggestions for a better name? :)

-- 
Jens Axboe

