Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263505AbTDYLwk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 07:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263879AbTDYLwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 07:52:39 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:10901 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263505AbTDYLwi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 07:52:38 -0400
Date: Fri, 25 Apr 2003 14:04:06 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jens Axboe <axboe@suse.de>
cc: Alexander Atanasov <alex@ssi.bg>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/PATCH] IDE Power Management try 1
In-Reply-To: <20030425103342.GJ1012@suse.de>
Message-ID: <Pine.SOL.4.30.0304251342080.12558-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 25 Apr 2003, Jens Axboe wrote:

> On Fri, Apr 25 2003, Alexander Atanasov wrote:
> > 		Hello,
> >
> > Benjamin Herrenschmidt wrote:
> >
> >
> > >The point is to pipe the power management requests through the request
> > >queue for proper locking. Since those requests involve several
> > >operations that have to be tied together with the queue beeing locked
> > >for further 'user' requests, they are implemented as a state machine
> > >with specific callbacks in the subdrivers
> > >
> > [cut]
> > >
> > >One thing that should probably be cleaned up is the difference between
> > >the suspend and the resume request. I didn't want to implement 2
> > >different request bits to avoid using too much of that bit-space, and
> > >because most of the core handling is the same. So right now, I carry in
> > >the special structure attached to the request, 2 fields. An int
> > >indicating if we are doing a suspend or a resume op, and an int that is
> > >the actual state machine step.
> >
> > > ===== include/linux/blkdev.h 1.100 vs edited =====
> > > --- 1.100/include/linux/blkdev.h	Sun Apr 20 18:20:10 2003
> > > +++ edited/include/linux/blkdev.h	Thu Apr 24 14:30:50 2003
> > > @@ -116,6 +116,7 @@
> > >  	__REQ_DRIVE_CMD,
> > >  	__REQ_DRIVE_TASK,
> > >  	__REQ_DRIVE_TASKFILE,
> > > +	__REQ_POWER_MANAGEMENT,
> > >  	__REQ_NR_BITS,	/* stops here */
> > >  };
> >
> >
> > 		What about this - add __REQ_DRIVE_INTERNAL, and carry args
> > 		in rq->cmd[16] [0] = PM, [1] = SUSPEND/RESUME, [2]= STATE ? IDE can use it
> > for power managment, error handling (do not do it from interrupt
> > context, but queue it), may be more. This way it would really makes
> > things a bit better with the complicated IDE locking. SCSI and probably
> > other block devices can benefit from this internal requests too, so the
> > bit is not wasted.
>
> There are already lots of "INTERNAL" - basically take your pick from all
> the ones you quote above (DRIVE_TASK, DRIVE_CMD, DRIVE_TASKFILE - it's a
> MESS). A power management special request makes sense to me.

To me too. Alex please do not add next "INTERNAL", I am just in process of
removing DRIVE_CMD and DRIVE_TASK.
And I can't see how using rq->cmd[] will help with IDE locking.

--
Bartlomiej


