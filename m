Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbVKPMjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbVKPMjj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 07:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964994AbVKPMjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 07:39:39 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:56839 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750740AbVKPMjh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 07:39:37 -0500
Date: Wed, 16 Nov 2005 13:40:36 +0100
From: Jens Axboe <axboe@suse.de>
To: Mike Christie <michaelc@cs.wisc.edu>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>,
       linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] libata error handling fixes (ATAPI)
Message-ID: <20051116124035.GX7787@suse.de>
References: <20051114195717.GA24373@havoc.gtf.org> <20051115074148.GA17459@htj.dyndns.org> <4379AA5B.1060900@pobox.com> <4379B28E.9070708@gmail.com> <4379C062.3010302@pobox.com> <20051115120016.GD7787@suse.de> <437A2814.1060308@cs.wisc.edu> <20051115184131.GJ7787@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051115184131.GJ7787@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15 2005, Jens Axboe wrote:
> On Tue, Nov 15 2005, Mike Christie wrote:
> > Jens Axboe wrote:
> > >On Tue, Nov 15 2005, Jeff Garzik wrote:
> > >
> > >>>For departure of libata from SCSI, I was thinking more of another more 
> > >>>generic block device framework in which libata can live in.  And I 
> > >>>thought that it was reasonable to assume that the framework would supply 
> > >>>a EH mechanism which supports queue stalling/draining and separate 
> > >>>thread.  So, my EH patches tried to make the same environment for libata 
> > >>
> > >>A big reason why libata uses the SCSI layer is infrastructure like this. 
> > >>It would certainly be nice to see timeouts and EH at the block layer. 
> > >>The block layer itself already supports queue stalling/draining.
> > >
> > >
> > >I have a pretty simple plan for this:
> > >
> > >- Add a timer to struct request. It already has a timeout field for
> > >  SG_IO originated requests, we could easily utilize this in general.
> > >  I'm not sure how the querying of timeout would happen so far, it would
> > >  probably require a q->set_rq_timeout() hook to ask the low level
> > >  driver to set/return rq->timeout for a given request.
> > >
> > >- Add a timeout hook to struct request_queue that would get invoked from
> > >  the timeout handler. Something along the lines of:
> > >
> > >        - Timeout on a request happens. Freeze the queue and use
> > >          kblockd to take the actual timeout into process context, where
> > >          we call the queue ->rq_timeout() hook. Unfreeze/reschedule
> > >          queue operations based on what the ->rq_timeout() hook tells
> > >          us.
> > >
> > >That is generic enough to be able to arm the timeout automatically from
> > >->elevator_activate_req_fn() and dearm it when it completes or gets
> > >deactivated. It should also be possible to implement the SCSI error
> > >handling on top of that.
> > >
> > 
> > To disable the timeout would you then have scsi_done call a block layer 
> > function to disarm it then follow the current flow where or do you think 
> > it would be nice to move the scsi softirq code up to block layer. So 
> > scsi_done would call a block layer function that would disarm the timer, 
> > add the request to a block layer softirq list (a list like scsi-ml's 
> > scsi_done_q), and then in the block layer softirq function it could call 
> > a request_queue callout which for scsi-ml's device queue would call 
> > scsi_decide_disposition and return if it wanted the request requeued or 
> > how many sectors completed or to kick off the eh. I had stated on this 
> > for my block layer multipath driver, but can seperate the patches if 
> > this would be useful.
> 
> Yeah, that was part of my plan as well. I did post such a patch a year
> or so ago, in a thread about decreasing ide completion latencies.
> 
> > Would ide benefit from running from a softirq and would it be able to 
> > use such a thing?
> 
> It's generally useful as it allows lock free completion from the irq
> path, so that's goodness.

I updated that patch, and converted IDE and SCSI to use it. See the
results here:

http://brick.kernel.dk/git/?p=linux-2.6-block.git;a=shortlog;h=blk-softirq

The main change from the version posted last october is killing the
'slightly' overdesigned completion queue hashing.

-- 
Jens Axboe

