Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280332AbRKNIMC>; Wed, 14 Nov 2001 03:12:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280328AbRKNILw>; Wed, 14 Nov 2001 03:11:52 -0500
Received: from 28.ppp1-3.hob.worldonline.dk ([212.54.85.28]:19332 "EHLO
	milhouse.home.kernel.dk") by vger.kernel.org with ESMTP
	id <S280323AbRKNILs>; Wed, 14 Nov 2001 03:11:48 -0500
Date: Wed, 14 Nov 2001 09:11:29 +0100
From: Jens Axboe <axboe@suse.de>
To: Jonathan Lahr <lahr@us.ibm.com>
Cc: lahr@eng2.beaverton.ibm.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] SCSI io_request_lock patch
Message-ID: <20011114091129.H17933@suse.de>
In-Reply-To: <20011112130902.B26302@us.ibm.com> <20011113092311.L786@suse.de> <20011113104210.L26302@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011113104210.L26302@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13 2001, Jonathan Lahr wrote:
> Jens Axboe [axboe@suse.de] wrote:
> > On Mon, Nov 12 2001, Jonathan Lahr wrote:
> > > 
> > > This is a request for comments on the patch described below which
> > > implements a revised approach to reducing io_request_lock
> > > contention in 2.4.
> > > 
> > > This new version of the io_request_lock patch (siorl-v0) is
> > > available at http://sourceforge.net/projects/lse/.  It employs the
> > > same concurrent request queueing scheme as the iorlv0 patch but
> > > isolates code changes to the SCSI subsystem and engages the new
> > > locking scheme only for SCSI drivers which explicitly request it.
> > > I took this more restricted approach after additional development
> > > based on comments from Jens and others indicated that iorlv0
> > > impacted the IDE subsystem and was unnecessarily broad in general.
> > > 
> > > The siorl-v0 patch allows drivers to enable concurrent queueing
> > > through the concurrent_queue field in the Scsi_Host_Template which
> > > is copied to the request queue.  It creates SCSI-specific versions
> > > of generic block i/o functions used by the SCSI subsystem and
> > > modifies them to conditionally engage the new locking scheme based
> > > on this field.  It allows control over which drivers use
> > > concurrent queueing and preserves original block i/o behavior by
> > > default.
> > 
> > Sorry Jonathan, but this is even more broken than the last patch. In
> > different ways. In no particular order:
> > 
> > o You are duplicating way too much code and exporting block
> > internals
> 
> The duplication is a reasonable starting point for SCSI-specific
> functions.  The block i/o design provides for exactly this type of
> tailoring through function pointers installed in request_queue.

Yes I know, I wrote most of said code :-)

> What problem you do see with exporting block internals?

It's absolutely worthless. Look, it ties in with the points I made
below. You are exporting the merge functions for instance, and setting
them in the queue. This will cause scsi_merge not to use it's own
functions, broken.

The make_request_fn addition could be ok, just needs to be cleaned a
bit.

> > o You are breaking SCSI merge completely, why on earth are you
> > suddenly using ll_*_merge functions for SCSI?!  o scsi_make_request
> > need not worry about head active o scsi_make_request can safe the
> > q->*_merge indirect o scsi_dispatch_cmd() io_request_lock removal
> > looks racy
> 
> I will investigate the above comments further.
> 
> > At least you are not breaking anything other than SCSI this time...
> 
> Do you think the separation of SCSI from generic block i/o code and
> the driver-activated control of concurrent queueing provides a path
> for future work to reduce io_request_lock contention in SCSI/FC?

Not really, but I do think it could be a viable 2.4 alternative. For 2.5
we still want to do this the right way.

-- 
Jens Axboe

