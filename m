Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262461AbVDGNZD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262461AbVDGNZD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 09:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262463AbVDGNZD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 09:25:03 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:57285 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262461AbVDGNYx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 09:24:53 -0400
Date: Thu, 7 Apr 2005 15:24:45 +0200
From: Jens Axboe <axboe@suse.de>
To: Christoph Hellwig <hch@infradead.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Chris Rankin <rankincj@yahoo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [OOPS] 2.6.11 - NMI lockup with CFQ scheduler
Message-ID: <20050407132444.GI1847@suse.de>
References: <20050329115405.97559.qmail@web52909.mail.yahoo.com> <20050329120311.GO16636@suse.de> <1112804840.5476.16.camel@mulgrave> <20050406175838.GC15165@suse.de> <1112811607.5555.15.camel@mulgrave> <20050406190838.GE15165@suse.de> <1112821799.5850.19.camel@mulgrave> <20050407064934.GJ15165@suse.de> <1112879919.5842.3.camel@mulgrave> <20050407132205.GA16517@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050407132205.GA16517@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07 2005, Christoph Hellwig wrote:
> On Thu, Apr 07, 2005 at 09:18:38AM -0400, James Bottomley wrote:
> > On Thu, 2005-04-07 at 08:49 +0200, Jens Axboe wrote:
> > > On Wed, Apr 06 2005, James Bottomley wrote:
> > > > My proposal is to correct this by moving the data back to the correct
> > > > object, and make any object using it hold a reference, so this would
> > > > make the provider of the block request_fn hold a reference to the queue
> > > > and initialise the queue lock pointer with the lock currently in the
> > > > queue.  Drivers that still use a global lock would be unaffected.  This
> > > 
> > > But this is the current requirement, as long as you use the queue you
> > > must hold a reference to it.
> > 
> > Exactly! that's why I think this solution must work independently of
> > subsystem.
> > 
> > > What do you think of the attached, then? Allow NULL lock to be passed
> > > in, in which case we use the queue private lock (that no one should ever
> > > ever touch). It looks a little confusing that
> > > sdev->request_queue->queue_lock now protects some sdev structures, if
> > > you want we can retain ->sdev_lock but as a pointer to the queue lock
> > > instead.
> > 
> > Looks good.  How about the attached modification?  It makes sdev_lock a
> > pointer that uses the queue lock which we null out when we release it
> > (not that I don't trust SCSI or anything ;-)
> 
> Do we really need the sdev_lock pointer?  There's just a single place
> where we're using it and the code would be much more clear if it had just
> one name.

A comment would work equally well, and save space of course :-)

-- 
Jens Axboe

