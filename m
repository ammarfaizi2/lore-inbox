Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262288AbVDFTKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbVDFTKf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 15:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262289AbVDFTJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 15:09:29 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:35258 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262288AbVDFTIv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 15:08:51 -0400
Date: Wed, 6 Apr 2005 21:08:40 +0200
From: Jens Axboe <axboe@suse.de>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Chris Rankin <rankincj@yahoo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [OOPS] 2.6.11 - NMI lockup with CFQ scheduler
Message-ID: <20050406190838.GE15165@suse.de>
References: <20050329115405.97559.qmail@web52909.mail.yahoo.com> <20050329120311.GO16636@suse.de> <1112804840.5476.16.camel@mulgrave> <20050406175838.GC15165@suse.de> <1112811607.5555.15.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112811607.5555.15.camel@mulgrave>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06 2005, James Bottomley wrote:
> On Wed, 2005-04-06 at 19:58 +0200, Jens Axboe wrote:
> > I rather like the queue lock being a pointer, so you can share at
> > whatever level you want. Lets not grow the request_queue a full lock
> > just to work around a bug elsewhere.
> 
> I'm not proposing that it not be a pointer, merely that it could be
> intialiased to point to a lock structure within the request queue.

Sorry that's what I meant, you are adding a lock inside the queue. I
didn't mean removing q->queue_lock or making it a non-pointer.

> Doing this looks much simpler than your current patch ... one of the
> problems with which looks to be that removing the scsi_driver module is
> in trouble because we currently have the queue_release in the sdev
> release (which won't get called while the queue holds a reference).

It is simpler, but it only solves this particular problem of the lock
going away.

> I think the correct model for all of this is that the block driver
> shouldn't care (or be tied to) the scsi one.  Thus, as long as SCSI can
> reject requests from a queue whose device has been released (without
> checking the device) then everything is fine as long as we sort out the
> lock lifetime problem.

But you are tying it completely to the SCSI problem, since we have no
locking problems of this sort elsewhere. At least the notified could
potentially be used for something else. The lock is just hack number two
to work around the problem.

-- 
Jens Axboe

