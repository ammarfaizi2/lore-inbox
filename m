Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbVKOMAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbVKOMAP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 07:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbVKOMAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 07:00:14 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:47471 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932382AbVKOMAM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 07:00:12 -0500
Date: Tue, 15 Nov 2005 13:00:16 +0100
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org,
       lkml <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] libata error handling fixes (ATAPI)
Message-ID: <20051115120016.GD7787@suse.de>
References: <20051114195717.GA24373@havoc.gtf.org> <20051115074148.GA17459@htj.dyndns.org> <4379AA5B.1060900@pobox.com> <4379B28E.9070708@gmail.com> <4379C062.3010302@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4379C062.3010302@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15 2005, Jeff Garzik wrote:
> >For departure of libata from SCSI, I was thinking more of another more 
> >generic block device framework in which libata can live in.  And I 
> >thought that it was reasonable to assume that the framework would supply 
> >a EH mechanism which supports queue stalling/draining and separate 
> >thread.  So, my EH patches tried to make the same environment for libata 
> 
> A big reason why libata uses the SCSI layer is infrastructure like this. 
>  It would certainly be nice to see timeouts and EH at the block layer. 
>  The block layer itself already supports queue stalling/draining.

I have a pretty simple plan for this:

- Add a timer to struct request. It already has a timeout field for
  SG_IO originated requests, we could easily utilize this in general.
  I'm not sure how the querying of timeout would happen so far, it would
  probably require a q->set_rq_timeout() hook to ask the low level
  driver to set/return rq->timeout for a given request.

- Add a timeout hook to struct request_queue that would get invoked from
  the timeout handler. Something along the lines of:

        - Timeout on a request happens. Freeze the queue and use
          kblockd to take the actual timeout into process context, where
          we call the queue ->rq_timeout() hook. Unfreeze/reschedule
          queue operations based on what the ->rq_timeout() hook tells
          us.

That is generic enough to be able to arm the timeout automatically from
->elevator_activate_req_fn() and dearm it when it completes or gets
deactivated. It should also be possible to implement the SCSI error
handling on top of that.

-- 
Jens Axboe

