Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261579AbVDSOgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbVDSOgp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 10:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbVDSOfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 10:35:16 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:13997 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261568AbVDSOde (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 10:33:34 -0400
Date: Tue, 19 Apr 2005 16:33:26 +0200
From: Jens Axboe <axboe@suse.de>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Tejun Heo <htejun@gmail.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Regarding posted scsi midlyaer patchsets
Message-ID: <20050419143325.GL2827@suse.de>
References: <20050417224101.GA2344@htj.dyndns.org> <1113833744.4998.13.camel@mulgrave> <4263CB26.2070609@gmail.com> <20050419123436.GA2827@suse.de> <1113920295.4998.13.camel@mulgrave> <20050419142959.GK2827@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050419142959.GK2827@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19 2005, Jens Axboe wrote:
> On Tue, Apr 19 2005, James Bottomley wrote:
> > On Tue, 2005-04-19 at 14:34 +0200, Jens Axboe wrote:
> > > On Mon, Apr 18 2005, Tejun Heo wrote:
> > > >  And, James, regarding REQ_SOFTBARRIER, if the REQ_SOFTBARRIER thing can
> > > > be removed from SCSI midlayer, do you agree to change REQ_SPECIAL to
> > > > mean special requests?  If so, I have three proposals.
> > > > 
> > > >  * move REQ_SOFTBARRIER setting to right after the allocation of
> > > > scsi_cmnd in scsi_prep_fn().  This will be the only place where
> > > > REQ_SOFTBARRIER is used in SCSI midlayer, making it less pervasive.
> > > >  * Or, make another API which sets REQ_SOFTBARRIER on requeue.  maybe
> > > > blk_requeue_ordered_request()?
> > > >  * Or, make blk_insert_request() not set REQ_SPECIAL on requeue.  IMHO,
> > > > this is a bit too subtle.
> > > > 
> > > >  I like #1 or #2.  Jens, what do you think?  Do you agree to remove
> > > > requeue feature from blk_insert_request()?
> > > 
> > > #2 is the best, imho. We really want to maintain ordering on requeue
> > > always, marking it softbarrier automatically in the block layer means
> > > the io schedulers don't have to do anything specific to handle it.
> > 
> > This is my preference too.  In general, block is the only one that
> > should care what the REQ_SOFTBARRIER flag actually means.  SCSI only
> > cares that it submits a non mergeable request.
> > 
> > I'm happy to separate the meaning of REQ_SPECIAL from req->special.
> 
> Isn't it just duplicate information anyways? I mean, just clear
> ->special if it isn't valid anymore. Having a seperate flag to indicate
> this seems a little suboptimal. It made more sense when ->cmd was a
> integer being READ, WRITE, etc. But as a seperate state now it doesn't.

Oh, and this is only true of SCSI, btw. REQ_SPECIAL should not be seen
outside of driver code, its meaning is defined solely by the driver.
SCSI ties it to ->special, but that is not necessarily true for any
other driver.

-- 
Jens Axboe

