Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264367AbTLBUbj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 15:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264365AbTLBU26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 15:28:58 -0500
Received: from havoc.gtf.org ([63.247.75.124]:17558 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S264364AbTLBUQu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 15:16:50 -0500
Date: Tue, 2 Dec 2003 15:16:49 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Greg Stark <gsstark@mit.edu>
Cc: Mike Fedyk <mfedyk@matchmail.com>, Erik Steffl <steffl@bigfoot.com>,
       linux-kernel@vger.kernel.org
Subject: Re: libata in 2.4.24?
Message-ID: <20031202201649.GB17779@gtf.org>
References: <3FCBB15F.7050505@rackable.com> <3FCBB9F1.2080300@bigfoot.com> <87n0abbx2k.fsf@stark.dyndns.tv> <20031202055336.GO1566@mis-mike-wstn.matchmail.com> <20031202055852.GP1566@mis-mike-wstn.matchmail.com> <87zneb9o5q.fsf@stark.dyndns.tv> <20031202180241.GB1990@gtf.org> <87iskz9hp6.fsf@stark.dyndns.tv> <20031202190646.GA9043@gtf.org> <877k1f9e1g.fsf@stark.dyndns.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877k1f9e1g.fsf@stark.dyndns.tv>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 02, 2003 at 03:10:19PM -0500, Greg Stark wrote:
> Jeff Garzik <jgarzik@pobox.com> writes:
> 
> > So, today, no acknowledgement occurs until the data _really_ is in the
> > drive's buffers.
> 
> The drive's buffers isn't good enough. If power is lost the write will be lost
> and the database corrupt. It needs to be on the platters.

Certainly agreed.


> > > This doesn't happen with SCSI disks where multiple requests can be pending so
> > > there's no urgency to reporting a false success. The request doesn't complete
> > > until the write hits disk. As a result SCSI disks are reliable for database
> > > operation and IDE disks aren't unless write caching is disabled.
> > 
> > This is not really true.
> > 
> > Regardless of TCQ, if the OS driver has not issued a FLUSH CACHE (IDE)
> > or SYNCHRONIZE CACHE (SCSI), then the data is not guaranteed to be on
> > the disk media.  Plain and simple.
> 
> That doesn't agree with people's experience. People seem to find that SCSI
> drives never cache writes. This sort of makes sense since there's just not
> much reason to report a write success before the write can be performed.
> There's no performance advantage as long as more requests can be queued up.

Some IDE _and/or_ SCSI drives do not cache writes.  For these drives,
the _absence_ of an OS flush-cache command still means your data gets
to the platter.

The core problem is not issuing a flush-cache command, it sounds like.
The drive technology (wcache, or no) is largely irrelevant.


> > If fsync(2) returns without a flush-cache, then your data is not
> > guaranteed to be on the disk.  And as you noted, flush-cache destroys
> > performance.
> 
> It's my understanding that it doesn't. There was some discussion in the past

eh?  flush-cache very definitely hurts performance, on both IDE and
SCSI, for drives that support write caching.


> > There are three levels:
> > 
> > a) Data is successfully transferred to the controller/drive queue (TCQ).
> > b) Data is successfully transferred to the drive's internal buffers.
> > c) The drive successfully transfers data to the media.
> 
> Only the third is of interest to Postgres or other databases. In fact, I

Certainly.


> suspect only the third is of interest to other systems that are supposed to be
> reliable like MTAs etc. I think Wietse and others would be shocked if they
> were told fsync wasn't guaranteed to have waited until the writes had actually
> hit the media.

As well he should be :)

	Jeff



