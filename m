Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262286AbVDLQRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262286AbVDLQRZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 12:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262332AbVDLQOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 12:14:40 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:65292 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262286AbVDLKoS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:44:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=LZWLvhr+ZmiAU0KwL+G0GJBaBYHbE+YWrIjqgJ+FsGqTuzoWJIbHJ9NzJRm+j8QrNfSFmsIyBw7RLV5XVrPWu349HQwm2hIeaYrOuaEkuwzlxtfH7P1Ewx9WO7YsMa34nbodTq/C4NDVpV9IolTq088RiCkS4cWLFvgert4Rihk=
Date: Tue, 12 Apr 2005 19:44:10 +0900
From: Tejun Heo <htejun@gmail.com>
To: Christoph Hellwig <hch@infradead.org>, James.Bottomley@steeleye.com,
       axboe@suse.de, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH scsi-misc-2.6 03/04] scsi: make scsi_requeue_request() use blk_requeue_request()
Message-ID: <20050412104410.GB23571@htj.dyndns.org>
References: <20050411034451.B75F3870@htj.dyndns.org> <20050411034451.6204E57B@htj.dyndns.org> <20050411124419.GA13747@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050411124419.GA13747@infradead.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, Christoph Hellwig.

On Mon, Apr 11, 2005 at 01:44:19PM +0100, Christoph Hellwig wrote:
> > +	cmd->request->flags |= REQ_SOFTBARRIER;
> > +
> > +	spin_lock_irqsave(q->queue_lock, flags);
> > +	blk_requeue_request(q, cmd->request);
> > +	spin_unlock_irqrestore(q->queue_lock, flags);
> >  
> >  	scsi_run_queue(q);
> 
> This exact code sequence is duplicated in the previous patch, maybe time
> for a
> 
> void scsi_requeue_request(struct request *rq)
> {
> 	struct request_queue *q = rq->q;
> 	unsigned long flags;
> 
> 	rq->flags |= REQ_SOFTBARRIER;
> 
> 	spin_lock_irqsave(q->queue_lock, flags);
> 	blk_requeue_request(q, rq);
> 	spin_unlock_irqrestore(q->queue_lock, flags);
>   
>   	scsi_run_queue(q);
> }

 The duplicated code path is in scsi_queue_insert(), and the the
function is removed by later requeue path consolidation patchset.  So,
I don't think separating out scsi_requeue_request() is necessary.
However, I'm thinking about setting REQ_SOFTBARRIER right after
allocating cmd in prep_fn().  So that we don't have to set
REQ_SOFTBARRIER in three different places.  Also, IMHO, it better
represents the purpose of REQ_SOFTBARRIER.

 Thanks a lot for your input.  :-)

-- 
tejun

