Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261888AbVDUGKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbVDUGKw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 02:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbVDUGKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 02:10:52 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:45037 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261888AbVDUGKi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 02:10:38 -0400
Date: Thu, 21 Apr 2005 08:10:26 +0200
From: Jens Axboe <axboe@suse.de>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Tejun Heo <htejun@gmail.com>, Christoph Hellwig <hch@infradead.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH scsi-misc-2.6 03/05] scsi: make scsi_queue_insert() use blk_requeue_request()
Message-ID: <20050421061026.GE9371@suse.de>
References: <20050419231435.D85F89C0@htj.dyndns.org> <20050419231435.329FA30B@htj.dyndns.org> <1114039446.5933.17.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114039446.5933.17.camel@mulgrave>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20 2005, James Bottomley wrote:
> On Wed, 2005-04-20 at 08:15 +0900, Tejun Heo wrote:
> > -	 * Insert this command at the head of the queue for it's device.
> > -	 * It will go before all other commands that are already in the queue.
> > -	 *
> > -	 * NOTE: there is magic here about the way the queue is plugged if
> > -	 * we have no outstanding commands.
> > -	 * 
> > -	 * Although this *doesn't* plug the queue, it does call the request
> > -	 * function.  The SCSI request function detects the blocked condition
> > -	 * and plugs the queue appropriately.
> 
> This comment still looks appropriate to me ... why do you want to remove
> it?
> 
> > +	 * Requeue the command.
> >  	 */
> > -	blk_insert_request(device->request_queue, cmd->request, 1, cmd, 1);
> > +	spin_lock_irqsave(q->queue_lock, flags);
> > +	blk_requeue_request(q, cmd->request);
> > +	spin_unlock_irqrestore(q->queue_lock, flags);
> > +
> > +	scsi_run_queue(q);
> 
> Really, wouldn't it be much more efficient simply to call blk_run_queue
> ()? since the blocked flags were set above, that's pretty much what
> scsi_run_queue() collapses to.

I wondered about this action recently myself. What is the point in
requeueing this request, only to call scsi_run_queue() ->
blk_run_queue() -> issue same request. If the point really is to reissue
the request immediately, I can think of many ways more efficient than
this :-)

-- 
Jens Axboe

