Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263465AbUCTQ1m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 11:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263467AbUCTQ1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 11:27:42 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:45265 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263465AbUCTQ1i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 11:27:38 -0500
Date: Sat, 20 Mar 2004 17:27:27 +0100
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Chris Mason <mason@suse.com>
Subject: Re: [PATCH] barrier patch set
Message-ID: <20040320162727.GJ2933@suse.de>
References: <20040319153554.GC2933@suse.de> <200403200059.22234.bzolnier@elka.pw.edu.pl> <20040320095341.GA2711@suse.de> <200403201723.11906.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403201723.11906.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20 2004, Bartlomiej Zolnierkiewicz wrote:
> On Saturday 20 of March 2004 10:53, Jens Axboe wrote:
> > On Sat, Mar 20 2004, Bartlomiej Zolnierkiewicz wrote:
> > > - do not use hwgroup->wrq (die!) and do not add drive->special_buf,
> > >   just do what PM code does and other special commands do - use taskfile
> > >   (yes, dirty stack allocation)
> >
> > Doesn't work for split flush, ie issue a bunch of flushes to devices,
> > then wait for them. I agree using ->wrq and special_buf is ugly as hell,
> > though.
> 
> I can't see why it doesn't work, please explain.

You'd need to pass on some opaque buffer from the issuer to the flush
cache function for that to work, which would be ugly.

> > > - why does blkdev_issue_flush() add REQ_BLOCK_PC to rq->flags?
> >
> > Ehm, because it _is_ a REQ_BLOCK_PC? ;-)
> 
> Ok, it is PC till SCSI->IDE transform, then it is no longer PC. :)

Right, and during that transform, REQ_BLOCK_PC is cleared:

+       rq->flags &= ~REQ_BLOCK_PC;
+       rq->flags |= REQ_DRIVE_TASK | REQ_STARTED;

(REQ_STARTED should be removed, btw).

> > > - why are we doing pre-flush?
> >
> > To ensure previously written data is on platter first.
> 
> I know this, I want to know what for you are doing this?
> 
> Previously written data is already acknowledgment to the upper layers
> so you can't do much even if you hit error on flush cache.  IMO if
> error happens we should just check if failed sector is of our ordered
> write if not well report it and continue.  It's cleaner and can give
> some (small?) performance gain.

This depends entirely on what you assume with a barrier and what the
upper layers want. My implementation guarentees that existing data sent
to drive is on platter before you issue the barrier. What is confusing
is that you cannot pass back where the error occured, that probably
needs some work.

-- 
Jens Axboe

