Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262327AbVDFVKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbVDFVKU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 17:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbVDFVKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 17:10:20 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:17051 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262320AbVDFVKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 17:10:09 -0400
Subject: Re: [OOPS] 2.6.11 - NMI lockup with CFQ scheduler
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Jens Axboe <axboe@suse.de>
Cc: Chris Rankin <rankincj@yahoo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20050406190838.GE15165@suse.de>
References: <20050329115405.97559.qmail@web52909.mail.yahoo.com>
	 <20050329120311.GO16636@suse.de> <1112804840.5476.16.camel@mulgrave>
	 <20050406175838.GC15165@suse.de> <1112811607.5555.15.camel@mulgrave>
	 <20050406190838.GE15165@suse.de>
Content-Type: text/plain
Date: Wed, 06 Apr 2005 17:09:59 -0400
Message-Id: <1112821799.5850.19.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-04-06 at 21:08 +0200, Jens Axboe wrote:
> > I think the correct model for all of this is that the block driver
> > shouldn't care (or be tied to) the scsi one.  Thus, as long as SCSI can
> > reject requests from a queue whose device has been released (without
> > checking the device) then everything is fine as long as we sort out the
> > lock lifetime problem.
> 
> But you are tying it completely to the SCSI problem, since we have no
> locking problems of this sort elsewhere. At least the notified could
> potentially be used for something else. The lock is just hack number two
> to work around the problem.

Then help me understand the problem as you see it.

My current understanding is that these problems occur because we've
mixed data in two objects of different lifetimes.  So far, this is stack
independent.

My proposal is to correct this by moving the data back to the correct
object, and make any object using it hold a reference, so this would
make the provider of the block request_fn hold a reference to the queue
and initialise the queue lock pointer with the lock currently in the
queue.  Drivers that still use a global lock would be unaffected.  This
also means that any provider of a request_fn may expect to process (and
reject) requests for a period of time after blk_cleanup_queue().
Really, this refcounting is inherent in blk_init_queue(),
blk_cleanup_queue() so the only additional requirement is sanely
processing queue requests after you think it's been cleaned up.  This is
request_fn() provider independent, I think (providers who currently
don't violate the lifetime rules don't need fixing).

I claim that this proposal solves the current problem, and any other
ones we run across that occur because of data mixing.

Your current patch tries to solve the problem by tying the two objects
together; unifying the lifetimes.  I agree this can be done (it was how
the sd/sr close race was fixed). But the current way the freeing
functions thread across the subsystems doesn't look nice and I don't
currently see a way to get the queue freed:  We free the queue on scsi
device release; if the queue holds a reference to the scsi_device, the
release function will never be called.  Our only other choice is to try
to free the queue on device_del instead, but that's too early, I think.

James


