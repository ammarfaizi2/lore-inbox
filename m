Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262270AbVDFSCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262270AbVDFSCE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 14:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbVDFSCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 14:02:04 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:24224 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262270AbVDFSBl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 14:01:41 -0400
Date: Wed, 6 Apr 2005 20:01:33 +0200
From: Jens Axboe <axboe@suse.de>
To: Tejun Heo <htejun@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Chris Rankin <rankincj@yahoo.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [OOPS] 2.6.11 - NMI lockup with CFQ scheduler
Message-ID: <20050406180132.GD15165@suse.de>
References: <20050329122226.94666.qmail@web52902.mail.yahoo.com> <20050329122635.GP16636@suse.de> <20050406123147.GD9417@suse.de> <1112791930.6275.69.camel@laptopd505.fenrus.org> <20050406125536.GG9417@suse.de> <4253E673.2000001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4253E673.2000001@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06 2005, Tejun Heo wrote:
> Jens Axboe wrote:
> >On Wed, Apr 06 2005, Arjan van de Ven wrote:
> >
> >>>@@ -324,6 +334,7 @@
> >>>	issue_flush_fn		*issue_flush_fn;
> >>>	prepare_flush_fn	*prepare_flush_fn;
> >>>	end_flush_fn		*end_flush_fn;
> >>>+	release_queue_data_fn	*release_queue_data_fn;
> >>>
> >>>	/*
> >>>	 * Auto-unplugging state
> >>
> >>where does this function method actually get called?
> >
> >
> >I missed the hunk in ll_rw_blk.c, rmk pointed the same thing out not 5
> >minutes ago :-)
> >
> >The patch would not work anyways, as scsi_sysfs.c clears queuedata
> >unconditionally. This is a better work-around, it just makes the queue
> >hold a reference to the device as well only killing it when the queue is
> >torn down.
> >
> >Still not super happy with it, but I don't see how to solve the circular
> >dependency problem otherwise.
> >
> 
>  Hello, Jens.
> 
>  I've been thinking about it for a while.  The problem is that we're 
> reference counting two different objects to track lifetime of one 
> entity.  This happens in both SCSI upper and mid layers.  In the upper 
> layer, genhd and scsi_disk (or scsi_cd, ...) are ref'ed separately while 
> they share their destiny together (not really different entity) and in 
> the middle layer scsi_device and request_queue does the same thing. 
> Circular dependency is occuring because we separate one entity into two 
> and reference counting them separately.  Two are actually one and 
> necessarily want each other. (until death aparts.  Wow, serious. :-)

That's precisely correct.

>  IMHO, what we need to do is consolidate ref counting such that in each 
> layer only one object is reference counted, and the other object is 
> freed when the ref counted object is released.  The object of choice 
> would be genhd in upper layer and request_queue in mid layer.  All 
> ref-counting should be updated to only ref those objects.  We'll need to 
> add a release callback to genhd and make request_queue properly 
> reference counted.
> 
>  Conceptually, scsi_disk extends genhd and scsi_device extends 
> request_queue.  So, to go one step further, as what UL represents is 
> genhd (disk device) and ML request_queue (request-based device), 
> embedding scsi_disk into genhd and scsi_device into request_queue will 
> make the architecture clearer.  To do this, we'll need something like 
> alloc_disk_with_udata(int minors, size_t udata_len) and the equivalent 
> for request_queue.
> 
>  I've done this half-way and then doing it without fixing the SCSI 
> model seemed silly so got into working on the state model.  (BTW, the 
> state model is almost done, I'm about to run tests.)
> 
>  What do you think?  Jens?

It is of course the optimal solution to really solve the hierarchy of
references, but more involved. If you have time / desire to do it, I'd
be happy to review it :-)

For now I'm happy with the work-around. It's not too ugly, and at least
it makes it possible to kill the worse work-around of
scsi_kill_requests().

-- 
Jens Axboe

