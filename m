Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275693AbRKNS5t>; Wed, 14 Nov 2001 13:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275552AbRKNS5m>; Wed, 14 Nov 2001 13:57:42 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:28631 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S275224AbRKNS5b>; Wed, 14 Nov 2001 13:57:31 -0500
Date: Wed, 14 Nov 2001 10:54:33 -0800
From: Jonathan Lahr <lahr@us.ibm.com>
To: Jens Axboe <axboe@suse.de>
Cc: lahr@eng2.beaverton.ibm.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] SCSI io_request_lock patch
Message-ID: <20011114105433.O26302@us.ibm.com>
In-Reply-To: <20011112130902.B26302@us.ibm.com> <20011113092311.L786@suse.de> <20011113104210.L26302@us.ibm.com> <20011114091129.H17933@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011114091129.H17933@suse.de>; from axboe@suse.de on Wed, Nov 14, 2001 at 09:11:29AM +0100
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe [axboe@suse.de] wrote:
> On Tue, Nov 13 2001, Jonathan Lahr wrote:
> > Jens Axboe [axboe@suse.de] wrote:
> > > On Mon, Nov 12 2001, Jonathan Lahr wrote:
> > > > 
> > > > This is a request for comments on the patch described below which
> > > > implements a revised approach to reducing io_request_lock
> > > > contention in 2.4.
> > > > 
> > > > This new version of the io_request_lock patch (siorl-v0) is
> > > > available at http://sourceforge.net/projects/lse/.  It employs the
> > > > same concurrent request queueing scheme as the iorlv0 patch but
> > > > isolates code changes to the SCSI subsystem and engages the new
> > > > locking scheme only for SCSI drivers which explicitly request it.
> > > > I took this more restricted approach after additional development
> > > > based on comments from Jens and others indicated that iorlv0
> > > > impacted the IDE subsystem and was unnecessarily broad in general.
> > > > 
> > > > The siorl-v0 patch allows drivers to enable concurrent queueing
> > > > through the concurrent_queue field in the Scsi_Host_Template which
> > > > is copied to the request queue.  It creates SCSI-specific versions
> > > > of generic block i/o functions used by the SCSI subsystem and
> > > > modifies them to conditionally engage the new locking scheme based
> > > > on this field.  It allows control over which drivers use
> > > > concurrent queueing and preserves original block i/o behavior by
> > > > default.
> > > 
> > > Sorry Jonathan, but this is even more broken than the last patch. In
> > > different ways. In no particular order:
> > > 
> > > o You are duplicating way too much code and exporting block
> > > internals
> > 
> > The duplication is a reasonable starting point for SCSI-specific
> > functions.  The block i/o design provides for exactly this type of
> > tailoring through function pointers installed in request_queue.
> 
> Yes I know, I wrote most of said code :-)

And this approach makes good use of it.

> > What problem you do see with exporting block internals?
> 
> It's absolutely worthless. Look, it ties in with the points I made
> below. You are exporting the merge functions for instance, and setting
> them in the queue. This will cause scsi_merge not to use it's own
> functions, broken.

As in the baseline, initialize_merge_fn overwrites these pointers:
     q->back_merge_fn = scsi_back_merge_fn_;
     q->front_merge_fn = scsi_front_merge_fn_;
     q->merge_requests_fn = scsi_merge_requests_fn_;

> > Do you think the separation of SCSI from generic block i/o code and
> > the driver-activated control of concurrent queueing provides a path
> > for future work to reduce io_request_lock contention in SCSI/FC?
> 
> Not really, but I do think it could be a viable 2.4 alternative. For 2.5
> we still want to do this the right way.

I'll try to stay apprised of the 2.5 work as it progresses.

-- 
Jonathan Lahr
IBM Linux Technology Center
Beaverton, Oregon
lahr@us.ibm.com
503-578-3385

